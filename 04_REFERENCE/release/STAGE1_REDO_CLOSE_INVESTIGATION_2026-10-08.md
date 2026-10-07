# Stage 1 blockers: REDO after U, and the close crash (investigation, 8 Oct 2026)

Adversarial investigator for controller 06, Opus, read-only. No code changed, no build, no test run, no AutoCAD.
Builds read: Civil/Manager `origin/claude/rel-20261008c` @ 62514a67 (installed Civil 3.0.34 / Manager 1.1.34, per
Codex W16/W17), Structural `origin/claude/rel-20261008w` @ ebc1654d (installed Structural 1.0.104). Bugs: BUG-256,
BUG-192, BUG-224 (context BUG-274, BUG-231, BUG-411, BUG-421).

## FOR TIM

1. **REDO:** I found no CE code left that writes to the drawing between U and REDO. What is left is code that READS
   the drawing in the background, or reacts while U and REDO themselves run, and nobody has yet checked it in
   AutoCAD for Structural beams, columns and the Foundations manager.
2. **Close crash:** the write that crashed AutoCAD when a drawing closed is gone from the installed build. The exact
   route that crashed (a drawing closed by another program, the way Codex's script closes it) has not been re-run
   since the fix. Codex's attempts were refused with "Drawing is busy", so they did not test that route.
3. **Next:** three Codex runs, listed in item 3 below. You do not need to do anything.

---

## 1. Answer: the top three remaining paths

None of the three is a known bug. Each is a place where REDO-safety depends on something that has not been proven in
real AutoCAD. Ranked by how likely each is to hide a real fault.

1. **Structural reactors that run during U and REDO themselves (beams, columns, footings, reo bars).**
   `Modules/Structural/Services/BeamLinkService.Reactors.cs:139-143` (ObjectModified / ObjectErased / CommandEnded),
   `BeamLinkService.ConnectedFollow.cs:68-71` and the only undo test at `:142` (`state.Depth == 0 || obj.IsUndoing`),
   `FoundationMonitor.cs:94-102`, `ReoBarMonitor.cs:65-68`, `DrawingAutoSaveService.cs:467-473`,
   `UI/Palette/MainPalette.xaml.cs:935-941`. RedoWindowGuard cannot cover these. The window is not open while U
   runs, and REDO closes it as REDO starts. Their end-of-command consumers skip U / UNDO / REDO / MREDO by command name
   (Structural scan baseline). Codex has proved U/REDO for FEDIT only (W15-04, W17-05). Beam REDO, column-with-beam
   REDO and FST delete REDO have never been driven: W13-01(d) did U only, W15-05 did U only. Whether REDO's replay
   counts as "IsUndoing" is Autodesk-internal and Unknown.
2. **The Structural Bracing panel's 5-second timer, which never asks the guard.**
   `Modules/Structural/UI/Dialogs/BracingPanelWindow.xaml.cs:32` (5 s), `:47-48` (timer), `:77-79` and `:92`
   (rescan at every command end, U included), `:98-109` → `Services/BracingPanelService.cs:26` →
   `Services/ProjectDataService.cs:197-226` (`ScanFromDrawing(lightRead: true)`, an open-close read). While the panel
   is open it reads the whole model space two or three times inside the 12 s wait. Its REDO safety rests only on the
   claim "an open-close read keeps REDO". That was measured in the core console (no graphics), not in full AutoCAD
   with this panel open. Structural's baseline accepts it on that claim. Never tested by Codex.
3. **Civil background work in a SECOND open drawing while the first drawing's REDO is open.**
   `Modules/Drainage/Services/LinkService.Reactors.cs:2293-2397` (`OnApplicationIdlePostSave`). The guard is per
   drawing (`RedoWindowGuard.cs:344-348`: "U in drawing A never holds work in drawing B"), so drawing B's grip-placement
   refresh (`:2347-2372`) and post-save draw-order write (`:2375-2397`) still run at Idle while A has REDO waiting.
   Only the cache rebuild needs B to be the drawing in front (`:2327`). Unknown whether a lock and write in B costs A
   its REDO (AutoCAD internals). Never tested: Codex's two-drawing case (W14-01) switched tabs, and that loses REDO in
   plain AutoCAD too (BUG-256 control D).

## 2. Close crash (BUG-224): answer

1. **The diagnosed pattern is gone from the installed code.** `LinkService.OnDocumentToBeDestroyed`
   (`Modules/Drainage/Services/LinkService.cs:1528-1563`) now only drops a waiting save from memory
   (`DiscardPendingSaveFor`) and unhooks events. It no longer calls `FlushPendingSave`. The shutdown write (BUG-231)
   is also gone: `PluginInitialization.cs:390-395` calls `DropWaitingSaveAtShutdown`.
2. **Remaining close-time writes, all by design and before teardown:** `LinkService.OnBeginDocumentClose`
   (`LinkService.cs:1415-1418`, lock + write only when a record is waiting AND it is the drawing's only unsaved
   change), and `LinkService.OnDatabaseBeginSave` (`:1279-1289`, lock + write on Yes at the close question). The
   BUG-224 guard test leaves BeginDocumentClose out on purpose (`Bug224CloseHandlersCallGraphTests.cs:12-14`).
3. **One wrong-thread pattern found, outside both scans (Manager):** a thread-pool timer subscribes to
   `Application.Idle` and changes ribbon state. `Modules/Manager/Plugin.cs:137-148` → `CeReleaseStatusService.cs:135`
   (timer) → `:163` (`Changed`) → `CeUnifiedRibbonService.cs:59-65` (`Application.Idle +=` on that thread, racing
   `OnIdle` at `:79-88` on the drawing thread). The first poll always reports a change, about 35 s after load.
   `Terminate` disposes the timer (`Plugin.cs:252`) without waiting for a callback already running. Not seen to crash.
   It is not the BUG-224 stack.
4. **Not re-proven:** the crash route itself (another program's COM `Document.Close(false)` on a drawing with Civil
   content, after U/REDO and Save As). W12-05 c1-c3 were refused with "Automation Error. Drawing is busy". My reading
   (hypothesis, not proven): the close was typed as a LISP line inside the drawing being closed, so that drawing was
   busy running it. The six user-route closes that passed (W12-05 a1-a3, b1-b3) used new blank acadiso drawings with
   no Civil content and no U/REDO, so Civil's close path barely ran.

## 3. The three best tests (full briefs in section 7)

1. **T1, Structural beam / column-with-beam / FST delete: U, wait 12 s, REDO.** Never proved. Reactor-heavy.
2. **T2, BUG-224 crash route: another program's COM close of a Civil drawing after five U / five REDO and Save As,
   three times.** This is the route that crashed, and it is unproven since the fix.
3. **T3, Bracing panel open: FEDIT (and a beam) then U, wait 12 s, REDO.** This isolates the one timer that does not ask
   the guard. FEDIT already passed without the panel (W17-05).

Also briefed: T4 (PIT visual + Inspector open + second drawing open, no tab switch), T5 (user-route close on Civil
content), T6 (what NOT to retest).

---

## 4. The REDO-safe machinery as built (what is guarded)

1. **The redo window, Civil:** `Modules/Drainage/Services/RedoWindowGuard.cs`. It opens at the end of U / REDO / MREDO,
   and of an UNDO that changed the drawing (`:192-215`, `:390-396`). It closes when any command starts in that drawing
   (`:230-248`), REDO included. At that point it runs the deferred "resume" actions, which only re-arm Idle hooks.
   `DeferWhileRedoOpen` (`:122-129`) is the one question every automatic Idle/timer path asks. Hold time is from
   Settings; Tim's files read 0 (= until the next command): `TIM_CE_CADTOOLS/CD_Settings.json` `redoHoldSeconds: 0`
   and `CE_STRUC_SUITE/CS_Settings.json` `RedoHoldSeconds: 0`. So nothing is released during the 12 s wait.
2. **Structural has its own copy:** `Modules/Structural/Services/RedoWindowGuard.cs:104-129`. It also closes on
   LispEnded (`:207`). Only two callers: `FoundationMonitor.cs:450` and `DrawingAutoSaveService.cs:1100`.
3. **Civil callers of the guard (8):** CivilBackgroundXrefNoticeService.cs:88, CivilProjectQaAutomaticService.cs:423,
   InspectorPaletteService.cs:386, :556, :745, :1120, LinkService.Reactors.cs:2323, PipeObjectUpgradeOnOpenService.cs:108,
   PitBlockMigrationService.cs:156, PitScheduleXrefWatcherAutoCadAdapter.cs:109.
4. **Compiled-code scans:** Civil `Modules/Drainage.Tests/Services/RedoSafeCallGraphTests.cs` and Structural
   `Modules/Structural.Tests/Services/RedoSafeCallGraphTests.cs`. Both follow every AutoCAD event hook, timer Tick and
   overrule callback through the compiled plugin plus CE_SHARED. They forbid a normal transaction, a system-variable
   set, a lock, a header-variable set, a write, an open-for-write, or a command start. Anything reached must be guarded
   or listed with a reason in `RedoSafeReviewedHooks.baseline.txt`. **I read the baselines; I did not run the scans.**
5. **What the Civil baseline accepts (every reason is a runtime branch the scan cannot see):** the U branch of
   `LinkService.OnCommandEnded` (`LinkService.Reactors.cs:860-911`: memory clears, an open-close re-read of the record,
   three model-space position scans with `lightReads: true`), `LinkService.OnCommandWillStart` (REDO only sets memory
   flags, `:1661-1682`), the object reactors (reach `HasCivilContent` only if the per-drawing answer is not cached),
   CLOSE / save writes, BLOCKEDITLOCK restore.
6. **What the Structural baseline accepts:** BeamLink command end (drops its queue at U/REDO), FoundationMonitor
   command end (refuses U/REDO), the Bracing panel open-close reads, DimensionCommands restore (returns first at U, BUG-334
   item 6, `DimensionCommands.cs:904-906, 995-996`), RC's REVCLOUD end (name-checked), ReoBar command end (own U list),
   job time (QSAVE start, SAVEAS end only).
7. **Runtime evidence line:** `PostUndoWriteWatch.cs` logs `[REDO] write after U finished...` in the Civil log
   (`%APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log`). It cannot see a transaction or a system-variable set (`:25-27`).
   **Lines that say "no CE code on the stack" also appear on PASSING runs.** The 8 Oct 02:30 FEDIT U logged 1,025 such
   changes, yet REDO said "Everything has been redone" (W17-05). They are AutoCAD's own. Only a line with "CE code:",
   or REDO answering "Nothing to redo", is evidence against CE. On 5-8 Oct the Civil log has 0 "CE code:" lines.

## 5. Every remaining path between U and REDO, judged

1. **Guarded (asks DeferWhileRedoOpen):** Civil automatic Project QA, Inspector refresh / first scan / busy pick,
   pipe-and-pit link refresh and post-save idle (per drawing), pipe upgrade on open, pit block migration, Pit Schedule
   XREF check, background XREF notice; Structural footing Idle redraw (BUG-274's path, now guarded, and FEDIT passed
   W15/W17), text-anchor check.
2. **Not asking the guard, but no drawing access or open-close reads only (scan-clean):**
   1. **Civil Idle hooks:** ProjectDataService idle-save housekeeping (`Persistence.cs:495-509`, memory only), the
      history re-read retry (`Persistence.cs:981`, hooked from `:1006-1010` only when the U re-read failed; open-close
      read), ownership highlight, zoom fade, selection observer, ribbon, banner.
   2. **Structural:** drawing-health scan (`MainPalette.xaml.cs:800-847`, open-close, only on a drawing change),
      rolling backup copy (`DrawingAutoSaveService.cs:1107-1110`, copies the saved file on disk), status bar.
   3. **Bracing panel timer** (path 2 above).
3. **Command-name branch only (guard impossible: they run during U / REDO):** all object reactors (path 1 above), and
   every CommandWillStart handler as REDO starts. Civil `LinkService.OnCommandWillStart:1622-1726`. Structural
   DimensionCommands, BeamLink follow, DrawingDisciplineDb, CeToolsInitializer, DrawingAutoSave, FoundationMonitor,
   NativeTimTools RC group. All are scan-clean or reviewed.
4. **Started by the drafter, not automatic:** CE grip clicks start a command at Idle
   (`StructuralGripEditQueue.cs:105-135`, `FootingGripOverrule.cs:393-423`, Civil pipe-attachment grips). A grip
   click is a new edit, so REDO is gone by design.
5. **Outside both scans:**
   1. **Manager:** not asserted. A dump-only test writes `%TEMP%\RedoSafeManagerHooks.txt`. Manager hooks: menu retry
      Idle and drawing activation, which sets MENUBAR only when it differs (`CeSuiteManagerMenuService.cs:794-799`); the
      ribbon rebuild at Idle (`CeUnifiedRibbonService.cs:79-103`, ribbon only); the thread-pool status timer (section 2,
      item 3); and the Plugin Manager window.
   2. **The two extra bundles on Tim's PC:** CE.AutoCADLink.2027 has no event hooks (its DLL has no add_Idle /
      CommandEnded / Object* hooks, and only an open-close transaction inside its own commands). CE.Transform.Trial.2027
      loads only when CETESTCR / CETESTMR is typed. Neither is a risk.
   3. **Delegates kept in fields** (CE-internal events such as `CeDrawingRepairRegistry.Changed`), reflection, LISP
      reactors and native code. `acad2027.lsp` is Autodesk's stock file.
6. **Civil awake in Structural drawings:** during W17 on DWG-S1 the Civil log printed "Automatic Project QA waits for
   the next command" (8 Oct 02:25-02:32). Civil Idle work therefore runs in Structural drawings, but it is guarded.

## 6. Close / save handlers (BUG-224 part)

1. **Civil DocumentToBeDestroyed (about 25 handlers):** all scanned by `Bug224CloseHandlersCallGraphTests`. None may
   transact, lock or write. The one reviewed exception is `CompoundEditModeService.OnDocumentToBeDestroyed` (puts
   BLOCKEDITLOCK back, a system variable, only after an intercepted BEDIT). LinkService (`:1528-1563`), RedoWindowGuard
   (`:151-165`) and the rest are memory and unhooking only. Verdict: **cannot touch the dismantled drawing** (per the
   scan; not run here).
2. **Civil BeginDocumentClose:** `LinkService.cs:1382-1436` writes under its own lock only in the rare case "record
   waiting and nothing else unsaved". The Pit Schedule XREF watcher's close handlers (`PitScheduleXrefWatcherAutoCadAdapter.cs:441-453`)
   are scan-clean. Verdict: **writes into a live drawing, before teardown; same thread.** Not proven on the COM close route.
3. **Civil BeginSave / SaveComplete / AbortSave:** `LinkService.cs:1246-1316`. An autosave (.sv$) writes nothing.
   QSAVE / Yes-at-close writes before the file is written. SaveComplete / AbortSave are memory only.
   `CivilProjectQaAutomaticService.cs:215` is scan-clean.
4. **Civil DocumentDestroyed:** `CivilHelpHost.cs:594-606` compares a handle and raises a context event. No drawing
   access.
5. **Structural DocumentToBeDestroyed (11 handlers):** DrawingAutoSave (`:413-429`, sets a teardown cool-down so Idle
   skips; refreshes the status bar on the drawing thread), CeToolsInitializer → JobTimeTracker.OnDocumentClosed
   (`JobTimeTracker.cs:324-358`, writes CSV only; its comment explains the old crash), DrawingDisciplineDb, FoundationMonitor,
   ReoBarMonitor, DimensionCommands, StructuralFrameGripOverrule, RedoWindowGuard, AdminTelemetry, RuntimeDiagnostics,
   MainPalette diag. None is in the Structural baseline, so all are scan-clean. Verdict: **safe** (per scan).
6. **Structural save:** job time is written at the START of a QSAVE (`JobTimeTracker.cs:464-487`) and at the END of a
   SAVEAS (CeToolsInitializer command end, baseline). So a tracked drawing (at least 60 s, named) is CHANGED again right
   after Save As, and a following close will ask "Save changes?". That is not a crash cause, but it changes the BUG-224
   sequence (Save As then close).
7. **Quit / palette shutdown / settings:** Civil Terminate writes nothing (BUG-231 fixed). Structural Terminate
   restores PICKSTYLE (`Plugin.cs:344`, a system variable at quit). Manager Terminate: see the thread-pool timer in
   section 2, item 3. The BUG-164 palette fix was not re-read here.
8. **Wrong thread:** only the Manager status timer (section 2, item 3). The other background threads (log writer,
   telemetry drains, the Civil telemetry flush, Structural corpus index) touch files and network only. I did not read
   all of them line by line.
9. **Compared with the diagnosis document** (`areas/release-v3-colleagues-BUG224_DIAGNOSIS_2026-09-30.md` §8): fix 1
   (no write in OnDocumentToBeDestroyed) is DONE. Fix 2 (keep BeginDocumentClose / BeginSave as the safety net) is as
   designed. Fix 4 (guard test) is DONE and wider than proposed (a call-graph scan, not a source grep). Fix 3 ("review
   FlushPendingSave writing when nothing waits") is NOT done. `ProjectDataService.Persistence.cs:435-449` still creates a
   save when none is waiting. All teardown callers check `IsSaveWaitingFor` first, so this is not a close risk. Inside
   commands, the Pit Schedule's close (`PitScheduleDialog.xaml.cs:140`, modal inside PITSCHEDULE,
   `PitScheduleCommand.cs:33-34`) still writes the record on every close.

## 7. Codex test briefs (ranked by chance of finding a real bug)

**Rules for every test:** first drawing of a fresh AutoCAD session (Explorer double-click on the COPY). Usual START
CHECK, settings watch, SAVETIME read then set 0, restored at the end. **U once, then wait 12 s touching nothing (no
click, no mouse wheel, no key, no tab switch), then REDO.** Never press F2 (BUG-411). No LIST, no ZOOM, no PAN, no
selection between U and REDO; do any view set-up BEFORE the command under test. After every REDO, save the Civil log
lines starting `[REDO]` from the U time to the REDO time, with drawing names removed. A line containing `CE code:` is
FAIL evidence. Lines saying "no CE code on the stack" are normal. A "... waits for the next command" line is the guard
working. Also check the Structural log `%APPDATA%\CE_STRUC_SUITE\logs\ce_struc_suite.log` for its `[REDO]` lines.
Screenshot before, after U and after REDO with the SAME view.

1. **T1, Structural beam, column-with-beam, FST delete (highest).** Fixture: copy of DWG-S1_VC7.dwg (85,871 bytes).
   1. **Set-up:** `ZOOM` `W` `-500,1000` `3500,3000` (before anything else).
   2. **(a) Beam place:** type `1`, Enter (pick points), `0,2000`, `3000,2000`, Enter at `Enter text <bd1>:`, Enter at
      `Beam preview [Accept/Cancel] <Accept>:`. Expect `Beam placed. One UNDO removes the complete beam.` Type `U`:
      record the exact echo (never captured before); the cyan beam and bd1 go. Wait 12 s. `REDO`. **PASS** = echo ends
      `Everything has been redone` and beam + bd1 are back in the same place. **FAIL** = `Nothing to redo` or a part
      missing.
   3. **(b) Beam MOVE:** `MOVE`, pick the bd1 beam line, Enter, base `0,0`, second `@500,0`. U → expect `MOVE`; wait
      12 s; `REDO` → `MOVE` / `Everything has been redone`, beam and bd1 at the moved place.
   4. **(c) Column with a beam:** `ZOOM` `E` first (this is a new step, not between U and REDO). Hover a column's CE
      grip until the tooltip reads `CE: move this column or support with its beams.` If none shows: BLOCKED, FIXTURE
      WANTED "a Structural copy with one column carrying a beam". Otherwise click that grip once, type `@300,0`, Enter.
      Expect the column and the beam end follow. U → record the echo (expected CESTRUCGRIPEDIT, Unknown); both back.
      Wait 12 s. `REDO` → `Everything has been redone`; column AND beam end at the moved place.
   5. **(d) FST delete:** `FST`, select PF2, Delete Selected Element, Yes, OK, Cancel; the PF2 outline is gone. U →
      record the echo (W15-05 could not); PF2 back. Wait 12 s. `REDO` → `Everything has been redone`, PF2 gone again.
      Only after that, `FST` should list PF1, PF3, PF4; Cancel.
   6. **Proves:** path 1 for beams, columns and footings. A FAIL names the reactor family; send the log lines with it.
2. **T2, BUG-224 crash route, COM close by another program (blocker; second).** Fixture: copy of DWG-B1_VC7_b.dwg
   (1,080,181 bytes, Civil content). Before starting, record the count of
   `%LOCALAPPDATA%\CrashDumps\acad.exe.*.dmp` and the newest Windows Application event 1000/1026 for acad.exe.
   1. **Sequence:** `CDDISCIPLINE` Structural, then Civil, Structural, Civil, Structural (five changes, each echo
      quoted). Five `U` (each echo `CDDISCIPLINE`). Wait 12 s. Five `REDO`, each expected
      `CDDISCIPLINE` / `Everything has been redone`. This also re-tests C1's "Nothing to redo". `CDDISCIPLINE` Civil.
      `SAVEAS` `C:\ce_rc_vc7\W18_close_com_1.dwg`. Wait until the command line is empty.
   2. **Close:** from a SEPARATE Python process (the same win32com route as sweep C1, NOT a LISP line typed in AutoCAD),
      find that document by name and call `Close(False)`. Expected: the call returns, the drawing tab goes, AutoCAD
      stays up, no error-report window.
   3. **After:** dump count unchanged; no new event 1000/1026; no Civil log `[ERROR]` within 5 s of the close.
   4. **Repeat** twice more (new fresh session each, Save As `_2`, `_3`). Then open `W18_close_com_1.dwg` and run
      `CDDISCIPLINE`: expect `Current drawing discipline: Civil (set explicitly in this drawing)`; then `cAncel`.
   5. **If COM says "Drawing is busy" again** from the external process: BLOCKED; record whether any command was
      running (CMDNAMES before the call). Never retry by another route in that run.
3. **T3, Bracing panel open (third).** Fixture: copy of DWG-S1_VC7.dwg.
   1. **Set-up:** `CSBRACINGPANEL`; the panel opens (screenshot its first look). Leave it open the whole test.
   2. **(a) FEDIT:** pick the PF1 outline, keep label PF1, X `700`, Y `700`, Enter at depth and type. Expect `[FEDIT]
      PF1 updated.` U → `FEDIT` (PF1 back to 600). Wait 12 s: the panel refreshes at least twice. `REDO` → `FEDIT` /
      `Everything has been redone`, PF1 visibly larger. Same as W17-05 but with the panel open: a FAIL here and not
      there points at the panel.
   3. **(b)** Repeat T1(a) (beam `1`) with the panel open.
4. **T4, PIT visual + Inspector + a second drawing open (no tab switch).** Fixtures: copies of DWG-B1_VC7.dwg (first)
   and FIX_MODERN_PIPE_W1.dwg (977,777 bytes).
   1. **Set-up:** open DWG-B1 first, then OPEN the second copy, then Ctrl+Tab back to DWG-B1 (all before any test
      command). `CDINSPECTOR`, leave the palette open. Screenshot to find an empty area (W13-02(a) found geometry at
      0,0), then `ZOOM` `W` around that area, about 6 m wide.
   2. **Place:** `PIT`, click in the empty area. In New Pit, type in the window itself (W13 learnt that keys sent to
      the parent window are lost): number `Z8` (or the next free number), cover `21.00`, Continue; pick the label point
      and the cover-text point; Esc. Expect `Pit placed successfully.` and `[CE] Stopped. Everything placed stays; U
      takes back the last one.`
   3. **U / REDO:** U → `PIT`; the pit, its label and its cover text all gone. Wait 12 s. `REDO` → `PIT` /
      `Everything has been redone`; screenshot the same view. **PASS** = exactly one pit symbol, one `Z8` label and
      one `CL 21.00` text, in the same places as before U.
   4. **Only after REDO:** click the pit; the Inspector shows Z8, cover 21.00.
   5. **Proves:** the PIT visual restore and Civil work in another open drawing (path 3). "PIT with the Pit Schedule
      open" cannot happen: PITSCHEDULE is a modal window inside its own command (`PitScheduleCommand.cs:33-34`).
      PITSCHEDULE's own U/REDO passed in W16-02.
5. **T5, user-route close on Civil content.** Same as T2 steps 1-3, but close with the drawing tab X (twice) and typed
   `CLOSE` (twice), answering `No` if asked. Same crash checks. This closes the gap left by W12-05 (blank drawings,
   no U/REDO).
6. **T6, do NOT retest as CE faults:** U, then a tab switch and back, then REDO; U then wheel zoom / -PAN / hatch pick /
   QSAVE / an automatic save; LIST between U and REDO. All of these lose REDO in plain AutoCAD (BUG-256 control D,
   2 Oct; W13-01(c), W15-04, W17-05 LIST notes). W14-01's cross-drawing "Nothing to redo" belongs here.

## 8. What Codex has already proved, and on which build

1. **On the installed 3.0.34 / 1.0.104:** PITEDIT rename/cover U→12 s→REDO (W16-01), PITSCHEDULE override U→REDO
   (W16-02), FEDIT 700 mm U→REDO (W17-05).
2. **On 3.0.32-3.0.33 / 1.0.102-1.0.103 (one or two builds earlier):** grip move, COPY, MOVE with linked pipes,
   CDDISCIPLINE ×2, CD pipe, PIT (echo only), MOVE pit, RC revision cloud, FEDIT (W12-W15). Since 3.0.32, Civil's
   redo-relevant files changed only by two `BindRecordToOpenDrawing` lines that run inside commands
   (`LinkService.Reactors.cs:1746-1748`, `InspectorPaletteService.cs:2990-2991`). Structural Services changed in
   footing code only. So these passes still stand, with that caveat.
3. **Never proved:** beam / column / FST REDO; Bracing panel open; PIT visual; two drawings without a tab switch; the
   COM close route since the fix; a user close on a drawing with Civil content after U/REDO.

## 9. Limits of this investigation

1. Read-only. I did not run the call-graph scans or any test; their pass state on these two heads is taken from the
   baseline files, not verified.
2. AutoCAD internals (whether a read, a write in another drawing, or a reactor during REDO costs REDO) are Unknown. Only
   the tests above can answer them.
3. I did not read every Civil and Structural handler body line by line. Handlers judged "scan-clean" rely on the scans.
4. No change to BUG_CARPARK.md (as instructed).
