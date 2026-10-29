# R21 fails after R12: diagnosis (job B-043a, read-only)

Fri 30 Oct 2026, 04:25 Melbourne time. Read-only: no build, no test, no branch, no PR, no AutoCAD started, no repo file
edited. Code read on `origin/claude/rel-20261029a` at commit 5888ee75, the same commit as the installed Civil 3.0.86
(`3.0.86+5888ee75`). Evidence: the robot reports in `areas/runner-reports`, the saved CDCHECK lists and the Civil CE
log (`ce_cvl_structured_20261030.log`) on this PC.

---

## FOR TIM

### Answer first

1. **Moving the pit and pressing U is not the problem.** R12 changes nothing that R21 sees. The robot throws R12's
   drawing away and opens the file fresh before R21 starts.
2. **The real fault: CDCHECK reads the wrong pit and pipe list on a drawing opened a second time.** CE keeps one pit
   and pipe list in memory, the one for the drawing it started with. When that drawing is closed and opened again in the
   same AutoCAD, CE does not load the new copy's list until some CE command that draws or edits runs. CDCHECK only reads,
   so it runs with no list at all.
3. **What you would see.** Every pipe shows up as an unnamed pipe and every pit loses its name (P3 shows as a long ID).
   About 40 pit-to-pipe joins show as "Unresolved". The real drawing gives 179 Connected and 4 Unresolved. The second
   open gives 142 Connected and 44 Unresolved.
4. **It is old.** The same wrong numbers (142 and 44) appear in robot runs on 3.0.73 (24 Oct), 3.0.78, 3.0.79, 3.0.80
   and 3.0.83. That was a different case each time, always the second CDCHECK in one AutoCAD start. Nobody connected them,
   because that case was already meant to fail for another reason (BUG-372 wording).
5. **Not caused by the 3.0.86 changes**, and not by the pipe-stealing fault from yesterday (BUG-1227). The BUG-1227 fix
   would not change it.
6. **Drawing data is safe.** CDCHECK writes nothing. The drawing, the pipes and the pits are all correct. Only the
   check's answer is wrong, and only until you run any CE drawing command (PIT, PIPE, EDIT and so on).
7. **Real-job risk.** You open a drawing, close it, reopen it, and type CDCHECK first. You see 44 problems that are
   not there. I expect the same when CDCHECK is the first CE command in a second open drawing, but I have not proven it.

### The fix I recommend (small, not built)

1. **When CE has no pit and pipe list in memory for this drawing, CDCHECK reads the list saved inside the drawing.** It
   reads it without changing anything. The pipe-to-pit size check inside CDCHECK already does exactly this, since BUG-589.
   The new part is that the connection list uses the same saved list.
2. **Settings switch:** `checks.cdcheckReadsThisDrawingsRecord`, ON. With it OFF, CDCHECK behaves exactly as today.
3. **It writes nothing**, so U and REDO are untouched.

### What to check in AutoCAD once it is built (not yet)

1. Open the robot drawing (or any job), type CDCHECK, press Enter, and note the totals line.
2. Close the drawing without saving. Open it again, type CDCHECK, press Enter.
   - **Right:** the same totals as step 1, with pipes named like "P3→P2", not "An unnamed pipe".
3. Open a second drawing, type CDCHECK first, before any other CE command.
   - **Right:** its pits are named (P1, P2...), not long IDs.

### What is not proven

1. I did not run anything. The cause rests on the CE log and the code. The log shows no "Project data loaded" line
   between the reopen (00:11:32) and the two CDCHECKs (00:11:37 and 00:12:03). The list only loaded at 00:12:28, when the
   next case's PIT command ran.
2. That a second open drawing (not a reopen) shows the same fault: likely from the code, not seen.
3. That the saved list gives exactly 179 / 4. It is the same list CE loaded at the first open, so I expect it to, but
   only a robot run proves it.
4. Whether U after a pit MOVE puts every pipe end back: R12 does not read pipe ends, and R21 never sees R12's drawing.
   The probe below answers it directly.

---

## ANSWER FIRST (technical)

1. **PR number:** none. Read-only diagnosis.
2. **What a drafter will see differently after the fix:** CDCHECK (and the Checks palette, which uses the same gather)
   prints the true totals on a drawing that has been reopened, or is not the drawing CE's in-memory record belongs to.
   Today it prints 142 / 44 instead of 179 / 4 on the robot drawing.
3. **Mistakes of my own first:** none that cost time. The task framed this as a MOVE + U fault. I started down that path
   and switched as soon as the run reports showed the drawing is reopened between cases. No time was lost on a wrong
   build because nothing was built.
4. **NOT proven:** any run of the fix; the second-drawing variant; that the stored-record read reproduces 179 / 4 exactly;
   whether U after MOVE restores P3's pipe ends (not exercised by R21 at all).
5. **Robot cases:** N38_cdcheck_reopen with switch-off control C38, the decisive one. N39_move_undo_cdcheck answers the
   MOVE + U question (details at the end).

## (1) Most likely cause: CDCHECK's passive read has no project record after a reopen

1. **Entry point:** `Modules/Drainage/Commands/SpineCheckCommand.cs:40-71` `CheckConnections`. It calls only
   `TryGetContext` (`CeCommandBase.cs:19-24`), never `InitServices` / `SetDrawingPath`, by design (a check must not
   write; `SetDrawingPath` saves). It then calls `ChecksResultReader.GatherSpine(db)`.
2. **`ChecksResultReader.cs:78-87` `GatherSpine`** calls `LinkService.BuildSpineRecords(db, tr, now, projectSnapshot: null)`.
3. **`LinkService.Spine.cs:233-239` `BuildSpineRecords`**: `project = projectSnapshot ?? PeekProjectForDatabase(db)`.
   `PeekProjectForDatabase` (`:671-672`) is `ProjectDataService.TryPeekCurrent(db)`. It returns the in-memory record only
   when `LinkService.SameDatabase(_currentDatabase, db)` (`ProjectDataService.cs:150-165`; native-pointer compare,
   `LinkService.PipeAttachmentGrip.cs:485-497`).
4. **After a close and reopen,** `_currentDatabase` is still the closed drawing's (BUG-1225 only sets
   `_recordDrawingClosed`, `ProjectDataService.KeptRecords.cs:269-277`). The record is switched only by the next
   `SetDrawingPath` / `BindCore` (`ProjectDataService.Mutations.cs:150-200`, `:239-262`), which CDCHECK never calls.
   `LinkService.OnDocumentActivated` (`LinkService.cs:1199-1210`) does not bind it either. So `project` is null.
5. **Effect inside `BuildSpineRecords` (`:244-321`):** `FindPit` / `FindPipe` return null for every object. Pits lose
   their mark (`pitData?.Id`), and pipes lose `From`, `To`, `FromSpineKey` and `ToSpineKey`. The pit side still lists its
   pipes from the pit's own link record (`ReadPitLinkData`), but the pipe side no longer names the pit. Each such pair
   becomes "Unresolved (not confirmed from the other side)". Saved lists compared:
   - `cdcheck-CLDV30659081_B1-20261028-195939.txt` (3.0.85, first open): "AGI→C1", "P3→P2", 179 / 4.
   - `cdcheck-CLDV30009321_B1-20261029-131137.txt` (3.0.86, reopen): every pipe a bare `CE-CIV-PIPE-…`, every pit a bare
     `CE-CIV-PIT-…`, 36 new "CE-CIV-PIT-… flows from/to CE-CIV-PIPE-…: Unresolved" rows, plus 4 more on TG1's pipes.
6. **Why the fit check was fine:** `GatherSpine` (`:120-128`) already falls back to
   `ProjectDataService.TryReadProjectWithoutChanging` (BUG-589). Its own comment describes this exact gap ("returned
   nothing on the first CDCHECK after a drawing was opened"). It was fixed for the fit check, never for the connection
   list.
7. **The CE log proves the order** (`ce_cvl_structured_20261030.log`):
   - 00:11:01 `Project data reloaded after Undo/Redo` (R12's U)
   - 00:11:29 `[BUG-1225] The drawing that owns CE's record closed`
   - 00:11:32 reopen, the C7 upgrade at open (handles kept "in place")
   - 00:11:48 and 00:12:03 `CDCHECK cancelled` (R21's two answers): no project load in between
   - 00:12:28 `[BUG-1225] … opened again …; CE loads this drawing's own record` (R33's PIT)
8. **The robot history proves R12 is irrelevant.** In the runs on 3.0.73 (p3b2discA, n1, n4), 3.0.78 (b5r1a),
   3.0.79 (b5s1g), 3.0.80 (x80a6, x80b6) and 3.0.83 (x83a6, x83b6), R21 ran first and passed. The very next case was
   R22 or R21_BROKEN, which ran CDCHECK on a reopened copy after a case that only ran CDCHECK. It printed exactly
   "187 connections: 142 Connected, 1 Possible, 44 Unresolved". R22 was a known BUG-372 failure, so nobody read the
   totals. Conversely, a reopened copy where another CE command ran before CDCHECK is healthy: 00:18:46 on 3.0.86 and
   07:04:28 on 3.0.85 both gave 184 Connected / 4 Unresolved.
9. **Secondary risk (same place, not observed):** `TryPeekCurrent` ignores `_recordDrawingClosed`. If AutoCAD reuses the
   closed drawing's native memory for the reopened one, `SameDatabase` is true and CDCHECK reads the closed drawing's
   in-memory record (unsaved edits made before the close). The BUG-1225 comment warns that AutoCAD may do this.

## (2) C-76 regression? No, older

1. Present on 3.0.73 (24 Oct) with the identical numbers, before #1835 (BUG-372) and #1837 (BUG-1228 OwnerScanMemo).
2. #1835 only rewords lines, and the totals come from `SpineConnectionListing.Summarise`, unchanged. #1837 is in the
   relink/source walk, not in `BuildSpineRecords`.
3. **Prediction for CE 02's diagnostics:** a80X8 (R12 then R21) red; a80X9 (the same with
   `linking.sourceLandingReadsEachObjectOnce false`) red with the same numbers; a80X7 R21 green (it runs first). If X9 is
   green, this diagnosis is wrong and #1837 is back in the frame.

## (3) Would the BUG-1227 Part A guard fix it? No

Part A (`fb/bug1227-pit-copy-keeps-pipe-ends`, `C:\ce-fx\c82a`) changes who owns pipe ends when a COPY lands on a pit.
R12 is a MOVE, R21 runs on a fresh copy of the file, and nothing in the drawing is wrong. The fault is which record
CDCHECK reads. Part A does not touch `BuildSpineRecords` or `GatherSpine`.

## (4) Fix design (small, switch ON, OFF = today exactly)

The task asked for "undo after a pit MOVE restores the pipe ends". The evidence does not show that undo fails, so this
design fixes the fault that was actually found. If N39 below shows a MOVE + U fault, it is a separate item.

1. **Switch:** `checks.cdcheckReadsThisDrawingsRecord` in `ChecksSettings` (`Modules/Drainage/Models/UserSettings.cs`,
   beside `cdcheckLinesShowNoInternalIds` at `:3321`). Documented "Default: on.", pinned in `C76NewSwitchDefaultsTests`
   (or its C-77 successor) through BOTH `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`, and shown
   on the Settings page beside the BUG-372 switch if that one is shown. A missing file or group reads ON.
2. **Pure rule (`Rules/CdCheckProjectSourceRule.cs`):**
   `Choose(snapshotGiven, liveRecordIsThisDrawings, recordDrawingClosed, switchOn)`, giving `Snapshot`, `Live`,
   `StoredRecord` or `None`.
   - Switch OFF: `Snapshot` if given, else `Live` if `liveRecordIsThisDrawings`, else `None` (today exactly, including
     ignoring the closed flag).
   - Switch ON: `Snapshot` if given; `Live` only when `liveRecordIsThisDrawings && !recordDrawingClosed`; otherwise
     `StoredRecord`.
3. **Wiring (one code path):** in `ChecksResultReader.GatherSpine`, before the transaction, when `projectSnapshot == null`:
   - read the rule's choice;
   - on `StoredRecord`, call `ProjectDataService.TryReadProjectWithoutChanging(db, out p)` (already used at `:124`);
   - pass `p` as `projectSnapshot` to `BuildSpineRecords`;
   - reuse the same `p` as `fitProject`, so the drawing's record is read once, not twice.
   One small internal accessor on `ProjectDataService` exposes `_recordDrawingClosed` for the rule. If the stored read
   fails, behave as today (`None`) and log one `[CDCHECK]` line. Warn, never block.
4. **REDO-safe:** read-only. No `SetDrawingPath`, no bind, no save, no regen, no system variable, no view change.
   `TryReadProjectWithoutChanging` is the read BUG-589 already does in the same command.
5. **Scope:** CDCHECK and the Checks palette (`ChecksListPaletteService.cs:98` uses `GatherSpine`). `ProjectDataService.
   RulebookDrawing.cs:229` passes its own snapshot and is unchanged. CE_SHARED does not change.
6. **Unit tests (no AutoCAD):**
   1. The rule's truth table: 16 rows, switch ON and OFF.
   2. Switch OFF gives exactly today's choice (`Live` / `None`) for every row.
   3. The switch default ON through both start-up reads; the JSON default contains `"cdcheckReadsThisDrawingsRecord":true`.
   4. A projector fixture, built directly with `CivilSpineProjector.Project` on plain inputs: one pit listing two pipe
      ends, pipes carrying `ToSpineKey`, gives Connected. The same pipes with null project fields give "Unresolved (not
      confirmed from the other side)". This reproduces 179 to 142 in miniature.
   5. A source guard that `GatherSpine` passes the chosen project to `BuildSpineRecords`, and reuses it for the fit
      check.
   6. A source guard that `GatherSpine` and `SpineCheckCommand` never call `SetDrawingPath`, `BindToDrawing*`,
      `SaveProjectData` or `MarkDrawingActive`.

## (5) Decisive robot probes

### N38_cdcheck_reopen (the fix), control C38

1. **Setup:** DRV1_B1, `SETTING CD_Settings.json checks.cdcheckReadsThisDrawingsRecord true`. Two cases in ONE AutoCAD
   start, with no R12 at all. Case A is plain R21 (runs first, on the launched copy). Case B is R21 again, after the
   runner's normal `reopen-copy -Force`.
2. **Steps in case B:** `type CDCHECK`, Enter (All), Esc. Then `type CDCHECK`, `Problems`, Esc.
3. **Checks in case B:**
   1. The command line holds `[CE] CDCHECK: 212 objects, 184 connections: 179 Connected, 1 Possible, 4 Unresolved, 0 Not
      Connected` twice.
   2. No line containing `An unnamed pipe flows`.
   3. The CE log for case B has no `Project data switched to` line before the first `Command outcome: CDCHECK` line. This
      proves the fix did not bind or save.
4. **Control C38:** the same with the switch `false`, `VARIANT_OF N38`. It must FAIL check 1 by printing `187
   connections: 142 Connected, 1 Possible, 44 Unresolved`. Today's build gives this result without any setting, which
   alone confirms the cause on 3.0.86 before any fix is built.

### N39_move_undo_cdcheck (the MOVE + U question), no switch

1. **Steps, on the launched copy (no reopen):**
   - `type CDCHECK`, Enter, Esc; record the totals;
   - pick-first P3 (handle 109D56), `type _.MOVE`, `0,0`, `0,2000`;
   - `type U`;
   - `type CDCHECK`, Enter, Esc.
2. **Checks:**
   1. Both totals lines are identical, at 179 / 1 / 4.
   2. P3's pipe-end count right after the U equals the count before. The count is the number of rows in the saved CDCHECK
      list (`cdcheck-*.txt`, newest two) matching `flows (to|from) P3: Connected`. Expect 6 before and 6 after, as in the
      3.0.85 list: IO8, P4, WT3, WT4 and WT9 flowing to P3, plus P3→P2 flowing from P3.
3. A red here would be a real MOVE + U fault and a new carpark item. Green clears R12 completely.

---

**Summary (under 100 words):** No PR (read-only). R21's red on 3.0.86 is not caused by R12's MOVE and U. CDCHECK on a
drawing reopened in the same AutoCAD start reads no pit and pipe record. In `LinkService.Spine.cs`, `BuildSpineRecords`
gets null from `PeekProjectForDatabase` / `ProjectDataService.TryPeekCurrent`, and `SpineCheckCommand` never binds, so
40 joins show Unresolved. This is old (identical 142 / 44 on 3.0.73 to 3.0.83), not a C-76 regression, and BUG-1227
Part A does not fix it. Proposed fix: in `ChecksResultReader.GatherSpine`, read the drawing's own record without
changing anything, behind switch `checks.cdcheckReadsThisDrawingsRecord` (ON). Proof: N38 / C38.
