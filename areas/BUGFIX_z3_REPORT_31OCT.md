# BUGFIX z3 report: four installed fixes that still fail (BUG-430, BUG-642, BUG-505, BUG-788)

Job z3, Sat 31 Oct 2026, Melbourne time. Read-only planning job: no code changed, nothing built, no test run, no PR, AutoCAD, Codex and accoreconsole not started.
Code read: Civil/Manager `origin/claude/rel-20261102a` at 3fbb9da5 (Civil 3.0.88). **Installed Civil bundle read from the DLL at 14:2x today: 3.0.88+3fbb9da5** (Legacy, Modern and Net8 folders), so the code read is the installed code.
Source of the task: Tim's voice batch 3 (decisions\2026-10-29_TIM_ANSWERS.md items 160 to 169) and areas\BUG_PROOF_LANES_31OCT.md item 10.

---

## FOR TIM

**Answer first: all four faults are still there in the build you have installed (3.0.88).** None of them was fixed later without anyone noticing. In order of how often a drafter would hit them:

1. **Double-click on a pit label (BUG-430), hit every day.**
   1. **What you see:** double-click the P8 label and AutoCAD's own attribute editor opens, not Edit Pit.
   2. **Why it still happens:** your 22 Oct answer (decision 94) keeps this OFF until a Codex look passes, so out of the box it does exactly that. With the switch ON, CE still loses the race: AutoCAD's editor opens before CE can stop it. The downpipe got a fix for that race on 29 Oct (3.0.86). The pit label was left out.
   3. **Second cause:** if your drawing has an Xref plan or a sheet border around the pit, CE thinks you might have clicked the border. It then backs off and leaves AutoCAD's editor.
   4. **Smallest fix:** give the pit label the same "stop AutoCAD's editor first" treatment as the downpipe, and ignore a border or Xref that only surrounds the label. It sits behind one new switch, ON. Then Codex looks once and, on a PASS, the main switch is flipped ON as you ruled.

2. **CDCATCHMENT label sits on the pipe wording (BUG-642), hit every time you check a grated pit catchment.**
   1. **What you see:** "P1 catchment: 42 m²…" is written over "225 DIA. UPVC PIPE AT 1 IN 48".
   2. **Why the fix did not work:** the 17 Oct fix (3.0.51) moves every label 300 mm up and to the right of the pit, always. It never looks at what is already there. A 200 mm high label is about 8 m long, so a 300 mm nudge cannot clear a pipe note.
   3. **Smallest fix:** try a few spots round the pit and use the first one that is clear of existing text. CE's text tidy-up already has the rule for this. If no spot is clear, use today's spot and say so on the command line. One new switch, ON. The label height (200) also becomes a Settings value, because it is typed into the code today.

3. **X-Civil import scale warning (BUG-505), once per job but a 1000-times error if missed.**
   1. **What you see:** the "CHECK THE SCALE" line, and since 3.0.87 your "This drawing has no units set; CE read it as millimetres." line, go only to the command line. The import window sits on top of the command line. The window page where you press Import shows neither.
   2. **Why the fix did not work:** Codex's second look (V8-01, 22 Oct, 3.0.69) said exactly this. The note was never wired into the window.
   3. **Smallest fix:** put that sentence as the status line on the window's "Pit and pipe schedule" page, and mark the page "check". One new switch, ON. Note only, never a block, as you ruled on 29 Oct (item 10).
   4. **Still open, for you:** the importer still guesses metres from the first metre-sized object, even when the source drawing's UNITS says millimetres. It only warns. See question 1 below.

4. **Two Xrefs made by Save As show as one schedule source (BUG-788), rare.**
   1. **What you see:** Xref STAGE1 and STAGE2 (STAGE2 made with Save As) show as one source in PITSCHEDULE. Stage 2's pits are missing.
   2. **Why the fix did not work:** the fix compares the two drawings' pit data. But the code that reads the Xrefs remembers the first drawing by its internal ID. It hands Stage 1's pit data back for Stage 2 as well. So the comparison always sees "same data".
   3. **Smallest fix:** read each Xref drawing's own pit data, under the switch that already exists for this fix (ON). No new switch.

**My mistakes:** none that cost a run. One script failed on the first try because of how I wrote it, and I re-ran it. I could not find the four Codex evidence files (CODEX_VERIFY_V3_20261021_0954, CODEX_VERIFY_V8_20261022_1506, CODEX_LOOK_L1B_20261018_0922, CODEX_LOOK_L4_20261019_1502). I looked in C:\CE_PLAN, C:\CE_WORK, C:\ce-fx, C:\ce_evidence_local, C:\CE_TEST_JOBS and your Documents and Desktop. So I worked from what the bug list and the 22 Oct reconciliation quote from them.

**What is NOT proven:** everything here comes from reading the code. Nothing was run, and nobody has looked in AutoCAD since 22 Oct for any of the four. Two points are my reading only:
1. BUG-430: the claim that the editor race also affects pit labels comes from the downpipe robot results, not from a pit-label run.
2. BUG-642: I have not measured a real label.

**Question for you (work hours, one only):**
1. **X-Civil source drawing says UNITS = Millimetres, but CE's size guess says metres. Which wins?**
   1. **What happens today:** CE multiplies everything by 1000 and prints a warning. If the drafter misses the warning, the whole job lands 1000 times too big.
   2. **My recommendation:** when the source drawing's UNITS is set to millimetres or metres, use it. Only guess when UNITS is not set, which keeps your 29 Oct ruling. Ship it ON.
   3. **Why:** a stray 200 mm stub on a pipe layer is enough to set off the guess today.
   4. **Example:** a millimetre X-Civil drawing with one short polyline on the pipe layer. Today it lands 1000 times out. With the change it lands in the right place, with no question asked.

---

## Technical detail (below the line: nothing here needs Tim)

### 1. BUG-430: pit label double-click opens AutoCAD's Enhanced Attribute Editor (most frequent)

**(1) Does the fault still exist on 3.0.88?** Yes.
1. **Default:** `Modules/Drainage/Models/DoubleClickSettings.cs:19` `OpensEditWindowDefault = false`. Decision 94 (Tim, 22 Oct: "as recommended") keeps it OFF until a Codex look passes. With it OFF, `CompoundEditModeService.cs:644-652` (step 0b) lets EATTEDIT redirect only a tagged source, so a pit label always gets AutoCAD's editor. This is by ruling, not by accident.
2. **Switch ON, cause A (the race):** the BUG-859 round 4 commit 9b2da5c3 (first in 3.0.86) found, from robot R09 on 3.0.75 to 3.0.85, that a cancel posted from CommandWillStart lands only after EATTEDIT's window closes. Its fix (veto at DocumentLockModeChanged, `CompoundEditModeService.cs:928-1000`) stops the editor only when `DoubleClickAttributeEditorStopRule.ShouldStop` is true, and that is `isTaggedSource && !locked && !refedit` (`Rules/DoubleClickAttributeEditorStopRule.cs:41-42`). A pit label is not a tagged source, so it falls to the command-start path (`CompoundEditModeService.cs:205-280`). That path's cancel is the one proven late for the same command (EATTEDIT). Inference, not seen for a pit label.
3. **Switch ON, cause B (hit-test ambiguity):** EATTEDIT on a double-click arrives with an empty pick-first set, so the block is found by `TryFindBlockUnderDoubleClick` (`CompoundEditModeService.cs:310-326`, 1003-1090). `DoubleClickHitTest.Decide` returns Ambiguous whenever more than one block outline covers the point (`Services/DoubleClickHitTest.cs:93-96`). The "background frame" exception covers tagged sources only (`DoubleClickHitTest.cs:108-131`). A pit label inside an Xref plan or title-block outline therefore gives Ambiguous, then null, then AutoCAD's editor.

**Evidence builds:** W20 on 3.0.35 (8 Oct); L4 on 3.0.54 (18 Oct) and 3.0.56 (19 Oct), all with the switch ON. All three predate the hit-test (8799d200, first in 3.0.71) and the lock veto (3.0.86). Installed: 3.0.88. Nobody has looked at a pit label since 3.0.56.

**(2) Why the earlier fix did not work:**
1. On 3.0.54 and 3.0.56 the pick-first set was empty for EATTEDIT, so CE logged "nothing picked" and AutoCAD's command went ahead (`CompoundEditModeService.cs:322-326`). The ccf5d1de diagnostic (3.0.58) added the logs but no fix.
2. The later downpipe fixes (hit-test 3.0.71, lock veto 3.0.86) were scoped to tagged sources and never extended to pit labels.

**(3) Smallest fix.** Switch `doubleClick.pitLabelStopsAttributeEditorFirst`, "Default: on". It takes effect only while `doubleClick.opensEditWindow` is ON, so with that OFF nothing changes for anyone.
1. **Rule:** `DoubleClickAttributeEditorStopRule.ShouldStop` gains a second yes: a linked pit label (owner proof `LinkService.ReadRecordedOwnerForEdit` gives OpenOwnersEditWindow), with `opensEditWindow` ON, the new switch ON, not on a locked layer, not in REFEDIT.
2. **Edit target:** the lock-veto handler registers the recorded owner pit (not the label) for CDEDIT. It uses a read-only open-close transaction and the same veto plus Idle CDEDIT as the downpipe. No new write, regen, view or system variable change (REDO-safe as the BUG-859 round 4 route).
3. **Hit-test candidates:** `DoubleClickBlockCandidate` gains `IsLinkedPitLabel`. `TryPickTaggedBlockInsideBackground` (renamed or widened) accepts one linked pit label in place of one tagged source. Every other blocker under the pointer must still be an untagged non-pit block that surrounds it on all four sides. Two real symbols stay Ambiguous, and an Xref block is still never returned.
4. **Files:**
   1. `Rules/DoubleClickAttributeEditorStopRule.cs`
   2. `Services/CompoundEditModeService.cs` (handler at 928-1000, candidate build at 1030-1048)
   3. `Services/DoubleClickHitTest.cs`
   4. `Models/DoubleClickSettings.cs`
   5. `Models/UserSettings.cs` (doc line)
   6. Settings page rows in `Dialogs/CivilSettingsView.xaml` and `AdvancedSettingsDialog.xaml` (beside sourceStopsAttributeEditorFirst)
   7. `C75NewSwitchDefaultsTests`
   8. REGRESSION_LOG.md
5. **Tests that fail before and pass after:**
   1. `ShouldStop` for a linked pit label with both switches ON is true (today false).
   2. `Decide` for a pit label inside a surrounding untagged frame is OneBlock (today Ambiguous).
   3. Switch OFF: both answers are exactly today's.
   4. The default is ON through both `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`.
6. **Then, separately (decision 94):** after a Codex PASS, flip `OpensEditWindowDefault` to true in the same commit as that PASS. Do not flip it before.

**(4) Proof needed.** Codex look, because the drafter must SEE which window opens. Proposed robot case **N95_pitlabel_dblclick / C95**:
1. **Settings:** set `doubleClick.opensEditWindow` true before AutoCAD starts (settings are read at launch).
2. **Drawing:** a copy of the L4 drawing with an Xref or sheet frame around the pits.
3. **Action:** double-click the P8 label text.
4. **Checks:**
   1. The CE log line from `DoubleClickAttributeEditorStopRule.StoppedLogLine` for the pit label.
   2. "TryRedirectToCdEdit: target registered; CDEDIT scheduled at Idle".
   3. The Edit Pit window for P8 opens.
   4. No "Enhanced Attribute Editor" window is listed.
5. **Switch-off control:** `pitLabelStopsAttributeEditorFirst` false. The log reads "EATTEDIT not stopped at its start (tagged source False, …)" and AutoCAD's editor opens.
6. **Robot reach:** whether the driver can double-click on a drawing point is unproven. If it cannot, this is a Codex-only case.

### 2. BUG-642: CDCATCHMENT label overlaps the pit's pipe wording

**(1) Still in code:** yes. `Services/CatchmentOverlayStyle.cs:25-30` places every label at pit centre plus (offset, offset), with offset `surface.catchmentOverlayLabelOffsetMm` = 300. `Services/GratedPitCatchmentOverlayService.cs:136-150` writes it with `TextHeight = 200.0` hard-coded at line 146 (an R-00 breach: a drafting value not from Settings).
- **Fix build:** 287f788f (17 Oct), first in 3.0.51.
- **Evidence build:** L1-03b on 3.0.54 (18 Oct). The evidence was taken on a build that already had the fix.
- **Since then:** no later change to either file. Installed: 3.0.88.

**(2) Why the fix did not work:** it fixed colour (label ACI 7) and draw order (fill sent to the bottom, line 121-134), but placement is a blind fixed diagonal nudge. A 45-character label at 200 high is roughly 7 to 8 m long. The pit's own pipe note sits within a metre or two of the pit, so a 0.3 m nudge cannot clear it.
- **Side fault (seen in code, not proven):** the 300 offset and the 200 height are drawing units. In a drawing whose UNITS are metres they would be 300 m and 200 m. Same family as BUG-209. Raise it as its own bug if confirmed.

**(3) Smallest fix.** Switch `surface.catchmentOverlayLabelAvoidsText`, "Default: on". New value `surface.catchmentOverlayLabelHeightMm`, default 200.
1. **Find the obstacles:** before writing each label, read (read-only, same transaction) the outlines of TEXT and MTEXT in model space within a box round the pit, plus the labels already placed in this run.
2. **Choose a spot:** try candidate spots in order: up-right (today's), up-left, down-right, down-left, then the same set at twice the distance. Take the first that `TextClashTidyUpRule.FirstClash` (`Rules/TextClashTidyUpRule.cs:224`) reports clear. Label size is estimated from character count × height, or measured with the MText's own extents after it is added.
3. **Nothing clear:** today's spot plus one line, "[CE] P1 catchment label could not find a clear spot; check it." (R-27: warn, never block.)
4. **Files:**
   1. `CatchmentOverlayStyle.cs` (pure spot chooser)
   2. `GratedPitCatchmentOverlayService.cs`
   3. `Models/UserSettings.cs` (SurfaceDrainageSettings)
   4. Settings page rows beside the other three BUG-642 values
   5. `C75NewSwitchDefaultsTests`
   6. REGRESSION_LOG.md
5. **Tests:**
   1. A pipe-note box covering the up-right spot makes the chooser return a non-clashing spot (today `LabelPoint` returns the clashing one).
   2. With every spot blocked it returns today's spot with the warn flag.
   3. Switch OFF gives exactly (pit + 300, pit + 300) and height 200.
   4. The default is ON through both start-up reads.

**(4) Proof:** the overlap is a drawing value, so the robot can prove it (Claude-accepted), and a Codex look covers readability. Proposed **N96_catch_label_clear / C96**:
1. **Drawing:** a copy of the CODEX_CATCHMENT_OVERLAY_20261015 two-pit 84 m² drawing.
2. **Typed:** `CDCATCHMENT`, then pick the outline and pits P1 and P2.
3. **Checks:** read the extents of each MText on the catchment overlay layer and of the "225 DIA. UPVC PIPE AT 1 IN 48" text. Pass = no intersection, and no "could not find a clear spot" line.
4. **Switch-off control:** P1's label insertion point equals pit centre + (300, 300) and its box intersects the pipe note.

### 3. BUG-505: X-Civil import scale, the sentence never reaches the window

**(1) Still in code:** yes, in two parts.
1. **Note never on the window:** `Services/XcivilImportService.cs:855-863` puts the CHECK THE SCALE or no-units sentence in `preflightSummary.Lines` and writes it to the command line. The window route's confirm callback (`Commands/LinkCommands.ImportXcivil.cs:167-185`) builds its status only from `summary.ScheduleSourceDegraded` and the rows' Check state (lines 171-175), so the sentence never reaches the "Pit and pipe schedule" page.
2. **The guess:** `Services/XcivilEntityScanner.cs:440-497` (`DetermineXcivilSourceToTargetScale`) still returns 1000 at the FIRST pit 0.05 to 3.0 wide (449-455) or the first pipe-layer path 1 to 250 long (460-467). The source drawing's INSUNITS is read (`XcivilImportService.cs:326`) but only feeds the sentence, never the scale. The target drawing's UNITS is still not read.
3. **LandXML:** that route now reads `<Metric linearUnit>` (`Helpers/LandXmlParser.cs:135-137, 505-512`), so that half is answered.

**Evidence builds** (from CARPARK_RECONCILIATION_2026-10-22.md line 495):
1. V3b-04 FAIL SURE, 21 Oct, 3.0.67: no warning for INSUNITS 0. True on that build, because `XcivilSourceUnitsCheck.Evaluate` returns empty for unitless plus a millimetre guess. Answered in code by accab5c9 (B-010, `xcivilImport.noUnitsNote` ON, first in 3.0.87).
2. V8-01 DIFFERENT SURE, 22 Oct, 3.0.69: "warning only in command history". Still true on 3.0.88 (part 1 above).

Installed: 3.0.88.

**(2) Why the fix did not work:** #1228 (e969b177, first in 3.0.63) wrote the sentence for the headless route's "Proceed with import? [Yes/No]" prompt. Interactively the decision moved into the window's schedule page (UI-IMPORT-20260924), and the sentence was never passed to it.

**(3) Smallest fix.** Switch `xcivilImport.scaleNoteOnReviewPage`, "Default: on".
1. **Carry the sentence:** add `UnitsNote` to `XcivilImportPreflightService.XcivilPreflightSummary` and set it at `XcivilImportService.cs:855-858`.
2. **Pure rule:** `ImportReviewStatusRule.Status(degraded, anyCheckRows, unitsNote, switchOn)` returns (status, needsAttention). With a note and the switch ON, the status is the note and needsAttention is true.
3. **Use it:** call the rule at `LinkCommands.ImportXcivil.cs:171-176`.
4. **Files:**
   1. the three above
   2. `Models/UserSettings.cs` (XcivilImport group)
   3. Settings page row
   4. `C75NewSwitchDefaultsTests`
   5. REGRESSION_LOG.md
5. **Tests:**
   1. Unitless plus a millimetre guess gives the status "This drawing has no units set; CE read it as millimetres." with needsAttention true (fails before: the status is "Schedule read. Review the pit and pipe rows.").
   2. A millimetre source with a metre guess gives the CHECK THE SCALE status.
   3. Switch OFF gives exactly the two old strings.
   4. The default is ON through both start-up reads.
6. **The guess itself (trust a set UNITS over the size guess):** needs Tim's answer to question 1. Do not build it before he answers.

**(4) Proof:** a window line the drafter must see, so a Codex look; the robot can read the status text if its driver reaches the page. Proposed **N97_xcivil_units_page / C97**:
1. **Target:** a drawing already tagged Civil (V1 retry was blocked by an untagged target).
2. **Typed:** `CDIMPORTXCIVIL`, then Choose DWG on a copy of a unitless millimetre X-Civil drawing, then Read source.
3. **Check:** on the "Pit and pipe schedule" page the status text equals "This drawing has no units set; CE read it as millimetres."
4. **Close:** press Close, so nothing is imported.
5. **Switch-off control:** the status reads "Schedule read. Review the pit and pipe rows." or "Check the schedule before accepting the import."
6. **Reach:** robot run 39 was BLOCKED at the file dialog (dialog-path fault); the memory note says a v2 dialog-path now exists. Not proven.

### 4. BUG-788: two Save As Xrefs merge into one schedule source (rarest)

**(1) Still in code:** yes. `Services/PitScheduleXrefDiscoveryService.cs:390-416`: `ReadContext.ReadProjectRecord` returns the cached snapshot by drawing identity (FingerprintGuid) at lines 394-398, before the per-Database cache (400) and before any read (403). The second Xref with the same fingerprint gets the first Xref's JSON. The core check at `PitScheduleXrefDiscoveryCore.cs:66` (`DataFingerprintDiffersFrom`) then sees equal data and merges the pair at 108-111.
- **No later change:** commits since the fix (7f4f8c39 BUG-799, a5775b64 BUG-1145) did not touch `ReadContext`.
- **Evidence:** none in AutoCAD, and no case. Reopened by reading (CODEX_SWEEP_S05_23OCT.md S05-01, Opus VERIFIED, 23 Oct, on the 3.0.70 code). Installed: 3.0.88.

**(2) Why the fix did not work:** PR #1404 (73a63971 and 9df157f9) fixed only the AutoCAD-free core and tested it with hand-made probes carrying different JSON (`PitScheduleXrefSaveAsCopyTests`). The adapter never produces such probes, because its identity cache substitutes the first record.

**(3) Smallest fix:** reuse the existing switch `linking.pitScheduleXrefSeparatesSaveAsCopies` (ON, already on the Settings page). It names exactly this behaviour (design rule 1: one behaviour, one switch).
1. **Change:** with the switch ON, the identity shortcut at lines 394-398 is keyed on identity plus the normalised source path (or skipped, leaving the per-Database cache). Each physical Xref file is then read once and two Save As copies are read separately. Switch OFF keeps today's identity-only key exactly.
2. **Testable:** lift the cache into a small internal generic `XrefRecordCache<TKey>` with an injected read function, so a test can supply two fake "databases" sharing one identity.
3. **Files:**
   1. `PitScheduleXrefDiscoveryService.cs`
   2. a new test in `Drainage.Tests/Services/PitScheduleXrefDiscoveryServiceTests.cs`
   3. REGRESSION_LOG.md
4. **Tests:**
   1. Two sources with one identity and different paths: two reads, two different JSONs returned (fails today: the second gets the first's JSON).
   2. Feeding those probes to `Discover` gives two entries, the second named and not offered.
   3. Switch OFF: one read and one merged source, exactly as today.
   4. The existing `PitScheduleXrefSaveAsCopyTests` stay green.

**(4) Proof:** drawing values and a window list, so the robot can prove it if it can read the Pit Schedule source list (reach unproven). Proposed **N98_xref_saveas_twins / C98**:
1. **Fixture:**
   1. A.dwg with pit A1 at cover RL 20.00.
   2. B.dwg made with SAVEAS from A, then cover changed to 21.00 and pit B2 added.
   3. Confirm that A and B have equal, non-empty FINGERGUID (S05 warns not to assume it).
   4. A host with both attached by `_XATTACH`.
2. **Typed:** `PITSCHEDULE`, Source, Drainage XREFs, Refresh.
3. **Check:** two source entries, the second carrying "has the same internal drawing ID as another Xref but different pit data … not offered".
4. **Switch-off control:** one entry, no note.
5. **Order:** repeat with the attach order reversed.

### Real-files listing (no test was run by this job)

1. **First listing:** taken at 14:2x before any other step that could write. This job ran no dotnet, no test and no AutoCAD, so the job can have written nothing there.
2. **Recent writes seen:** files with times at 14:17 to 14:19 today are AutoCAD's own (Tim's AutoCAD session was writing them during this job). They are:
   1. `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` (12220 bytes, 14:19:05)
   2. `%APPDATA%\CE_CADTOOLS\CE_Admin\manager-menu-state.json` (224, 14:17:39)
   3. `%APPDATA%\CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json` (228, 14:18:16)
   4. `%APPDATA%\CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_snapshot.json` (885, 14:17:44)
3. **Settings files:**
   1. `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` 15270 bytes, 2026-10-04 08:22:30
   2. `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` 35613 bytes, 2026-10-30 19:54:14
   3. `%APPDATA%\CE_CVL_SUITE\settings.json` 672 bytes, 2026-09-16 12:13:17
   4. `%APPDATA%\CE_SUITE`: no settings file listed
4. **Second listing (end of job):** the three settings files are unchanged in size and time. The only difference between the two listings is `%APPDATA%\CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json`, 228 bytes, which went from 14:18:16 to 14:23:16. That is the running Suite Manager's own five-minute session mark, not this job, because this job runs no CE code.

### Cleanup

- **Worktree:** none was made (all code was read through `git show` on origin refs).
- **Scratch:** my files in `C:\CE_WORK\scratch\z3` (`CEMS.cs`, `XIS.cs`, `XES.cs`, `GPC.cs`, `list.ps1`, `listing_1.txt`) are removed at the end. The folder itself is this job's TEMP and TMP while the job runs, so it cannot be removed from inside the job.
