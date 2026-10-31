# Wave 1 case writing, job E3: BUG-654, 655, 656, 657 (Sat 31 Oct 2026, afternoon, Melbourne)

## ANSWER FIRST

1. **Count:** all 4 bugs have a robot case and a must-fail twin (8 files). None goes to Codex or Tim instead. Nobody has run them yet.
2. **BUG-654 (hand-typed level kept, pipe runs backwards):** W654 types a level by hand in Edit Pipe, then lowers the pipe upstream 200 mm; CE must say "P82 -> P83 will be flat or running backwards". Twin W654_BROKEN lowers it only 50 mm, so no warning.
3. **BUG-655 (two pipes into one pit):** W655 raises one of two pipes arriving at P83 by 200 mm; the outgoing pipe must stay at 17.88 under the lower pipe, with a warning naming P82 -> P83. Twin turns the fix's switch off.
4. **BUG-656 (cascade re-links the whole drawing):** W656 runs the cascade on the test drawing (the route that passed today on 3.0.88) and reads the CE log: only the cascade's own pipe may be re-linked, none of four far pipes. Twin turns the fix's switch off.
5. **BUG-657 (locked level-text layer):** W657 moves one level text of a pipe to a new locked layer; the cascade must change neither text and say "Nothing was changed". Twin skips the lock, so both texts change.
6. **Offline checks:** validate 43 files, 0 invalid; check_ids "every control id is known"; no "print" word; no street or client names; every level literal matches the arithmetic below.
7. **Main risk (all of 654, 655, 657):** they draw pits and pipes on empty ground with typed pit numbers P81 to P84 and edit robot-drawn pipes. Each step is copied from a case that has run, but this exact chain has not run.
8. **Main risk (656):** it rests on the CE log line "Pipe endpoints updated". Two real 3.0.88 runs show exactly one such line. The twin's extra lines are derived from PIT runs, not seen from a cascade.
9. **What 654 cannot show:** the bug as filed was a silent back-fall. On 3.0.88, BUG-1040 turns the fix's refusal into a warning, so the kept level IS still written. The case proves the check now sees it, not that the write is blocked.
10. **Not driven anywhere:** CDPROPAGATE (the other route for all four bugs). It needs a pick on a pit, a route the robot has not proven. Codex look if wanted.
11. **Fault noticed in another writer's case (not edited):** W652 edits a 225 mm pipe to about 1 in 32. By the code that is 2.6 m/s against the 2.0 m/s pit-outlet limit, so a Design Warnings window could open and stall the case.
12. **Next:** an Opus paper review of these 8 files, then one robot pass of the four mains and four twins.

---

## 1. Source pinned

1. **Commit read:** `3fbb9da5` (Civil 3.0.88, branch origin/claude/rel-20261102a), extracted read-only with `git archive` into `C:\ce-fx\wave1_E3\src`.
2. **Fix commits (all ancestors of 3fbb9da5):** BUG-654 and 655 `3373b6cd` (PR #1317, merged 722f01a5); BUG-657 `8caecdbf` (PR #1378); BUG-656 `4019cc7e` (PR #1379, merged 079c1dce).
3. **Files written:** the 8 case files below in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\`, and this report. No existing case, setup, spec, driver or settings file was changed. Nothing committed.
4. **Live evidence read (read only):** Tim's Civil log `%APPDATA%\CE_CVL_SUITE\logs\CE_CVL_SUITE.log.1` (cascade runs at 11:52:14, 12:45:39 and 13:23:46 on 3.0.88) and runner report `RUN-20261031-1315-C3.0.88-bF6` (N26 PASS).

## 2. Shared facts for W654, W655, W657 (the drawn networks)

1. **Ground:** the empty ground 148000..172000 by -82000..-58000 that the C78 and E2 cases use. Each case runs on its own fresh copy of DRV1_B1.
2. **Pits:** typed `PIT`, number set with `C2.PitNumber` (the N40 / W234 route), cover 19.000, "New pit, Continue placement", three Esc (SETUP-R47v).
3. **Pipes:** typed `CD` pit to pit, `C2.Diameter` 100, `C2.CreatePipeText` off, `C2.AutoCalcSecondInvert` off, `C2.IsGradeDefault` on (Standard grade never opens the Grade mismatch window, `CdCommand.Grade.cs` 244), both levels typed with 3 decimals.
4. **Length arithmetic:** pit centres 10.450 m apart. CE moves each end 225 mm into the pit wall (paper review C78 section 2 item 1), so every pipe is 10.000 m. A fall of 0.100 is exactly 1 in 100.
5. **Why no Design Warnings window after Edit Pipe Save:** the design check runs on every Save (`PipeEditCommand.Update.cs` 563-603; window at 1276). With 100 mm UPVC (n 0.010 in Tim's CD_Settings.json), full-bore speed is 0.86 m/s at 1 in 100 and 0.81 m/s at 1 in 111. That is inside the 0.6 m/s minimum and 1.5 m/s pit-outlet recommended speed (`UserSettings.cs` 2420, 3302). Grades are steeper than the 1 in 200 minimum (2336). This is why I did not use 225 mm: at 1 in 100 it is 1.47 m/s, too close to 1.5.
6. **Text decimals:** New Pipe and Edit Pipe write the level as typed ("IL 18.000", "IL 17.60"; seen in SETUP-R47v and R11). The cascade writes 2 decimals (`InvertPropagation.cs` 30, `IlNumberFormat "0.00"`). So "IL 17.88" can only come from the cascade, and "^IL 17\.88$" never matches "IL 17.880".
7. **Command-line words:** every cascade line goes through `CommandLineText.Plain` (`PipeEditCommand.Update.cs` 2006). That turns the arrow sign into "->" (`CommandLineText.cs` 25), so the lines read "P82 -> P83". The CE log lines are not converted.
8. **Edit Pipe on a robot-drawn pipe:** `pick-first` the handle, then `CDEDIT` with no "Y" (R20 / K06 / W234). The fixture pipe 10A98D needs `CDEDIT{NL}Y` (R11 / N26).
9. **Edit Pipe never asks Keep / Overwrite:** it applies with the default Keep (`PipeEditCommand.Update.cs` 2002; `InvertPropagation.cs` 689-690 comment). A box changed in Edit Pipe marks that end "typed by hand" (`PipeEditCommand.Update.cs` 1549-1553, 1586-1596, called at 1858). New Pipe sets no mark.
10. **Settings pinned with SETTING lines:** `linking.cascadeKeepsPitDrop` (`UserSettings.cs` 884), `linking.cascadeRelinksOnlyPlanPipes` (925) and `linking.flatPipeIsWarningNotBlock` (605). All default to on and none is in Tim's file today; the guard puts the file back.

## 3. Per bug

### 3.1 BUG-654: W654_cascade_kept_typed_level_backfall_warned and W654_BROKEN

1. **In AutoCAD terms:** three pits in a row: P81, P82, P83. Pipes P81->P82 run 18.300 to 18.200 and P82->P83 run 18.150 to 18.050. Edit Pipe on P82->P83: type 18.06 at the P83 end, Save, and answer No to Recalculate. Edit Pipe on P81->P82: 18.10 / 18.00, Save, Yes, Apply. At the end, CE must warn that P82 -> P83 runs backwards. The texts of P82->P83 must read IL 17.95 and IL 18.06, with no IL 17.86.
2. **Words checked, with source at 3fbb9da5:**
   - "[CDEDIT-CASCADE] Downstream cascade skipped.": `PipeEditCommand.Update.cs` 1981.
   - "[CDEDIT-CASCADE] Warning: P82 -> P83 will be flat or running backwards (a level typed by hand was kept, or the grade cannot fall).": `InvertPropagation.cs` 702-705, said from 801-816 (BUG-654's check on the written levels, `PropagationPlan.cs` 56-57, 98-103, 190-191).
   - "[CDEDIT-CASCADE] 1 level(s) you set by hand were kept as they were, on P82 -> P83. The cascade went around them.": lines 1037-1038.
   - "[CDEDIT-CASCADE] Updated 1 pipes and 1 pits from P82 (IL 18.00)": line 1039.
   - Log line "CDEDIT-CASCADE: anchor=P82 IL=18.00 pipes=1 pits=1": line 1040.
3. **Arithmetic:**
   - Pit drop at P82 = 18.200 - 18.150 = 0.050. The walk measures it against the level before the save (lines 233-245, 1989).
   - Step 1: 18.050 becomes 18.06, so the fall is 0.09 (1 in 111).
   - Step 2: anchor P82 at 18.00. New start = 18.00 - 0.05 = 17.95. New end = 17.95 - 0.09 = 17.86.
   - The P83 end is kept at 18.06, so the levels written are 17.95 / 18.06, a back-fall of 0.11. New over new (17.95 / 17.86) still falls, so only the BUG-654 check sees it.
   - Pits updated = 1 (P83; the anchor is not counted, line 966).
4. **Derived, never seen on a run:** every line and number above; that typed pit numbers hold; the Min grade figure (recorded only).
5. **Twin W654_BROKEN, one change:** Edit Pipe on P81->P82 types 18.25 / 18.15 (lowered 50 mm). The written levels are then 18.10 / 18.06, which still falls, so there is no warning. The warning, Updated, log and IL 17.95 checks fail.
6. **Honest limit:** on 3.0.88 BUG-1040 makes this a warning, not a block (`PropagationPlan.FlatPipeIsWarningOnly`, line 169). The pipe is still written backwards, and CE now says so; before the fix it said nothing. The CDPROPAGATE route (Enter = Keep) is not driven.
7. **Codex look (optional):** CDPROPAGATE on the same drawing, answering Keep, should show the same warning.

### 3.2 BUG-655: W655_junction_outlet_follows_lowest_pipe and W655_BROKEN

1. **In AutoCAD terms:** the bug's own example, moved up to RL 18. Pipe P81->P83 arrives at P83 at 17.950. Pipe P82->P83 arrives at 17.900 (from the south). Pipe P83->P84 leaves at 17.880 and ends at 17.780. Edit Pipe on P81->P83: 18.25 / 18.15, Save, Yes, Apply. P83->P84 must stay at IL 17.88 / IL 17.78, CE must name P82 -> P83 as the lower pipe, and no IL 18.05 may appear.
2. **Words checked, with source:**
   - "[CDEDIT-CASCADE] Warning: Pit P83: pipe P82 -> P83 arrives at 17.90, lower than the 18.15 this change brings, so the pipe leaving the pit follows the lower level.": `InvertPropagation.cs` 416-420, said at 785. The levels use `FormatIl "0.00"` (`PropagationPlan.cs` 197-198). The pipe label is built at 707-712.
   - "Updated 1 pipes and 1 pits from P83 (IL 18.15)": line 1039. Log "CDEDIT-CASCADE: anchor=P83 IL=18.15 pipes=1 pits=1": line 1040.
3. **Arithmetic:**
   - Lowest arriving pipe at P83 that the cascade did not touch = P82->P83 at 17.900. The edited pipe counts at its old 17.950 (lines 391-404).
   - Existing drop = 17.900 - 17.880 = 0.020 (lines 423-427).
   - The 18.15 the change brings is higher than 17.900, so the outlet = 17.900 - 0.020 = 17.88. End = 17.88 - 0.100 = 17.78.
   - Old cascade: 18.15 / 18.05, leaving P82->P83 arriving 250 mm under the outlet. The bug's own text says 200 mm for its numbers.
4. **Derived, never seen:** every line and level; that both arriving pipes reach the walk with their drawn levels.
5. **Twin W655_BROKEN, one change:** SETTING `linking.cascadeKeepsPitDrop false` (the older cascade, lines 377-378). The warning and the four text counts fail.
6. **Not driven:** CDPROPAGATE; batch "Carry downstream"; a junction reached by two changed pipes at once (the regression log says that case is "not ordered").

### 3.3 BUG-656: W656_cascade_relinks_only_preview_pipes and W656_BROKEN

1. **In AutoCAD terms:** on the untouched test drawing, Edit Pipe on P4 -> P3 (10A98D) with 17.60 / 17.50, Yes, Apply. This is N26's first half word for word; N26 passed on 3.0.88 today (bF6). Then the CE log is read. Only a pipe in the preview may have its record rewritten. No pipe out at WT5 to WT8, P6 or P7 may.
2. **Words checked, with source:**
   - "Updated 4 pipes and 3 pits from P3 (IL 17.50)": seen on 3.0.88 in bF6.
   - Log "CDEDIT-CASCADE: anchor=P3 IL=17.50 pipes=4 pits=3": line 1040. Seen three times in Tim's log today.
   - Log "Pipe endpoints updated: <pipe> from=<From> to=<To>": `ProjectDataService.Mutations.cs` 1490 and 1587. It is written only when a record changes, plus "fromKey=set" / "toKey=set".
   - The re-link inside the cascade: `InvertPropagation.cs` 976-987; `CascadeRelinkScope.cs` 17-26; `LinkService.Geometry.cs` 938-973.
3. **What the log showed (seen, not derived):**
   - Both cascade runs on fresh copies (11:52:14 and 13:23:45) wrote exactly one endpoint line: "Pipe endpoints updated: 1094BE from=C1 to=STUB toKey=set". 1094BE is a plan pipe, C1 -> STUB.
   - On a fresh copy, PIT (which re-links every pipe, `PitCommand.cs` 575-585) writes one line per pipe, for example "10B083 from=WT6 to=P6 fromKey=set" (12:42:51, and 128 times overnight).
4. **Checks:** 1094BE line present (control); no line for 10B083, 10A942, 10A243 or 10A8C7; exactly one "Pipe endpoints updated:" line in all.
5. **Derived, never seen:** that the switch-off cascade (the twin) writes the far-pipe lines the way PIT does.
6. **Twin W656_BROKEN, one change:** SETTING `linking.cascadeRelinksOnlyPlanPipes false`.
7. **Why not the bug's own picture:** "an unrelated pipe with a wrong From in its record" needs a hand edit of the project data, which the robot cannot make. The first-re-link log lines are the visible stand-in.

### 3.4 BUG-657: W657_locked_level_text_neither_written and W657_BROKEN

1. **In AutoCAD terms:** the W654 row of pits and pipes. The end text "IL 18.050" of P82->P83 goes to a new layer E3LOCK (AutoCAD's own -LAYER New and CHPROP), and E3LOCK is locked (the R33 typed form). Edit Pipe on P81->P82: 18.40 / 18.30, Save, Yes, Apply. CE must change neither text of P82->P83 and say "Nothing was changed - no pipe could be updated (P82 -> P83)". There is no IL 18.25 anywhere, and the locked text is still on E3LOCK. E3LOCK is unlocked at the end.
2. **Words checked, with source:**
   - "[CDEDIT-CASCADE] Nothing was changed - no pipe could be updated (P82 -> P83). The levels on the drawing and in the schedule are as they were.": `InvertPropagation.cs` 1011-1020 and 1052-1056.
   - Log "could not be updated to 18.15": lines 1143-1158 (the BUG-657 pre-check).
   - Log "kept its old level on the drawing": lines 924-931.
   - IL texts are found by their words "IL ", whatever layer they are on (lines 1085-1107), so the moved text is still one of the pipe's two texts. The all-or-nothing gate is `IlTextWriteGate.cs` 15-21.
3. **Arithmetic:** anchor P82 at 18.30. P82->P83 new start = 18.30 - 0.05 = 18.25; end = 18.25 - 0.10 = 18.15. The locked one is the end text, hence "18.15" in the log. Before the fix, the open start text became "IL 18.25" (both writes were tried), while the pipe's record kept 18.150 / 18.050.
4. **Derived, never seen:** every line; that typed `-LAYER _NEW` makes the layer; that CE leaves a CHPROP'd level text on its new layer. A check reads the layer back before the edit, so a wrong set-up fails on that check, not later.
5. **Twin W657_BROKEN, one change:** the lock step (and its wait) is left out. Both texts are written and "Updated 1 pipes and 1 pits from P82 (IL 18.30)" is said. The "Nothing was changed", absent, log and text checks fail.
6. **Not driven:** the start text locked (the reverse order); CDPROPAGATE; the stored record and schedule.

## 4. Could not write, and faults noticed

1. **Nothing left unwritten.** All four bugs have a case and a twin.
2. **W652 (writer E2, not edited):** Edit Pipe sets the 225 mm pipe A->B to 18.500 / 18.200 over about 9.55 m. That is about 1 in 32: full-bore 2.6 m/s with UPVC n 0.010. The pit-outlet limit is 2.0 m/s and the recommended speed 1.5 m/s (`DesignValidationService.cs` 395-418, `UserSettings.cs` 3302-3306). By the code, the Save shows the "Creative Engineering | Design Warnings" window (`PipeEditCommand.Update.cs` 1276), which the case never closes. Its New Pipe pipes at 1 in 96 are 1.50 m/s, right on the 1.5 line. Worth a look before its run.
3. **Brief-wide note:** the brief's check 3 bans the word "print" in any case. R11 and others use "printed" in record labels. It does no harm to the driver; I avoided it.
