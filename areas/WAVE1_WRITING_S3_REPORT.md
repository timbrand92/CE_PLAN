# Wave 1 case writing, job S3: Pit Schedule group (BUG-784, BUG-785, BUG-786, BUG-791), 31 Oct 2026

Writer: Opus case writer, job S3, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Written Sat 31 Oct 2026, afternoon, Melbourne. Nothing was run: no AutoCAD, no driver, no runner except the offline `validate`, no build, no test. No existing case, setup, driver, runner, allow-list or settings file was edited. Nothing committed, pushed or deleted. Code read at the installed build `3fbb9da5` (Civil 3.0.88).

## FOR TIM (answer first)

1. **Answer:** 1 of my 4 bugs has a robot case: BUG-784 (W784, twin W784_BROKEN). The other 3 (BUG-785, BUG-786, BUG-791) have no case and go to a Codex look.
2. **BUG-784, what the case does:** it draws three made-up pits, C5, C6 and P11, and runs a pipe from C5 into P11 and another from C6 into P11, both at the same level. Then it opens the Pit Schedule. P11 must show one row FROM C5 and one row FROM C6, never "C" or one merged "Cs" row.
3. **BUG-784, the twin:** it turns off the Settings switch that holds the fix (`linking.scheduleFromKeepsPitNumber`). That gives back the old fault on purpose, so the twin must fail on the FROM checks.
4. **BUG-784 is the window half only.** The drawn schedule table refreshing its FROM cell after an edit is not driven (item 9).
5. **BUG-785 (depth on the drawn schedule changes after the next edit):** no case. It only shows in the drawn table, after an edit. The robot has never read a drawn schedule cell, and its new rows cannot be placed into the table by a proven route. It also needs a pump-station pit or a pit between 0.9 and 1.2 m deep, and none is known on the test drawing.
6. **BUG-786 (saved row order splits a pit's rows):** no case. The fault needs a saved row order first. Every way of saving one is out of the robot's reach: Place schedule, the ↑ ↓ buttons, + Add Row and Export are not on its press list. "Update existing schedule" returns before it saves. The test drawing has no saved order, because N29's new P8 sits in number order.
7. **BUG-791 (override marks on cells that were not changed):** no case. It needs a typed cell edit (F2 then Enter, or a typed size) and a judgement of cell colour (gold, italic). The robot can do neither.
8. **New fact for the S writers:** the test drawing DRV1_B1 DOES hold a drawn, linked Pit Schedule. R33 has passed 16 times with the line "Pit schedule cell for P3 (lid and remarks) not updated: its layer (25TEXT) is locked". Job S1's report says no robot drawing holds one; that is not so for DRV1_B1. What is still unknown is whether its cells are loose texts the robot can select.
9. **One probe would open BUG-785 and the drawn half of BUG-784 to the robot:** on DRV1_B1 select every text on 25TEXT near the drawn table and read it, then press "Update existing schedule" (on the v2 press list) after adding a pit. That shows whether the table can be read and grown. It is read-only on a copy, but I have not run it.
10. **Checks:** `validate` printed "46 file(s) checked, 0 invalid" (W784: 66 steps, 16 checks; twin the same). The id check printed "every control id is known". Neither file contains the word print or a street name, and every level is 18.000, 17.800 or 17.80, which matches the arithmetic.
11. **Hashes (first 12):** W784 `3746331AC9D0`, W784_BROKEN `43461988EA4C`.
12. **One risk to watch on the first run:** the case types pit names C5, C6 and P11 into New Pit, as N33 and N40 did. The FROM cell text "C5=C5" follows the row shape seen on earlier runs but has never itself been seen (DERIVED).

---

## 1. Per bug

### 1.1 BUG-784: FROM column strips the number off pits not named P-digits

1. **Case id and twin:** `W784` (file `W784_from_column_keeps_c_pit_numbers.case.txt`), twin `W784_BROKEN`. Both are in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_wave1_31oct\`.
2. **What it does, in drafting terms:**
   1. Zooms to the empty area at x 146000 to 174000, y -84000 to -56000.
   2. Runs PIT three times. In New Pit it types the pit number and a cover of 19.000, presses Continue placement, then three Esc. The pits are C5 at 150000,-80000, C6 at 170000,-60000 and P11 at 170000,-80000.
   3. Runs CD from C5 to P11 (east) with levels 18.000 and 17.800 and presses Start Pipe. It records the window list and presses Cancel on a Grade mismatch window only if one has opened (it should not). Then one Esc.
   4. Runs CD from C6 to P11 (south) the same way.
   5. Opens PITSCHEDULE, reads every row and cell, and presses Close.
   6. **At the end it must be true that:** three "Pit placed successfully." lines and 3 new pit blocks; 2 new pipes; no Grade mismatch window either time; a "was 225 mm inside the pit" line; within P11's group one FROM cell reads C5 and one reads C6, and no FROM cell reads C or Cs; the window closed; the drawing file on disk is unchanged.
3. **Where the checked words come from (3fbb9da5):**
   1. **FROM text:** `Services/PitScheduleBuilder.cs` 118-153 (`BuildInletFromDisplay`, ending in `StripSourceTagNumber` at 149 and 153). `StripSourceTagNumber` is at 197-227: the name is kept when `KeepsPitNumberInFrom` (214, body 238-250) says it is a real pit whose letters are not a source tag; otherwise the trailing digits are cut (221).
   2. **Source tags:** `Rules/SourceFamilies.cs` 61-73 (DP, IO, OF, FO, GIO, TG, FW, STRIP, AGI, RG, SOURCE, WT, LPD) plus SD, R, D, PD and PP (`PitScheduleBuilder.cs` 228-230). "C" is not among them. Pit types still shortened: TG, WT, AGI, PD and STRIPDRAIN (`PitScheduleBuilder.cs` 232-235).
   3. **Merge:** `PitScheduleBuilder.cs` 282-330 (`ConsolidateInletsKeepingSource`). With the switch on, letters plus digits count as a real pit and never merge (301-303). With it off, the same label at the same level merges into one row and gains an "s" (326).
   4. **The window uses both:** `ViewModels/PitScheduleViewModel.Data.cs` 310-312 and 362.
   5. **Switch:** `Models/UserSettings.cs` 807-813, `scheduleFromKeepsPitNumber`, default true, inside `LinkingSettings` (588); JSON section `linking` (89).
   6. **Command-line words:** "Pit placed successfully." `Commands/PitCommand.cs` 588-590. "Pipe end moved to the inside wall of ... (was 225 mm inside the pit)." `Rules/PipeEndWallSnap.cs` 78.
   7. **Row shape** 'Pit P3= | P3=P3 | ... | P4=P4 | ...' (a FROM cell reads NAME=NAME): N11, N26 and R13 run records. The gap pattern that allows a comma-named second inlet row comes from N40.
4. **DERIVED, never seen on a run:**
   1. The cells "C5=C5" and "C6=C6" in P11's group.
   2. That New Pit accepts C5, C6 and P11 as typed. N33 and N40 typed CP2, CP10, SPS2 and P10A the same way, and C5, C6 and P11 are free on DRV1_B1 (P1 to P7, P9, P10 and C1 exist).
   3. That P11 takes both pipes as inlets with no outlet chosen. Both pipes run downhill into it.
5. **Arithmetic:**
   1. **Length:** each pipe is 20.000 m centre to centre. Less 225 mm at each pit wall, that gives 19.550 m (paper review C78 section 2 item 1; both pipes are square to the pits, so no diagonal wall distance comes in).
   2. **Fall and grade:** 18.000 - 17.800 = 0.200 m. 19.550 / 0.200 = 1 in 97.75, which is steeper than 1 in 100 and 2.25 per cent off it. That is under the 10 per cent window rule (`CdCommand.Grade.cs` 270-274).
   3. **CE's own level:** 18.000 - 19.550 / 100 = 17.8045, rounded down to 17.80. That equals the typed level, so the box is skipped on that ground as well (paper review section 2 item 5).
   4. **Same level at P11:** both pipes arrive at P11 at 17.80. That is what makes the old code merge them into "Cs".
6. **The one thing the twin breaks:** the SETTING line changes `linking.scheduleFromKeepsPitNumber` from true to false. Steps and checks are otherwise the same. The switch is read only when the FROM text is built, so the pits, pipes and window behave as in W784. The twin fails on the C5 check, the C6 check and the "no C or Cs" check, not on a stalled step.
7. **What a Codex look must see that the robot cannot (drawn half):** on a copy of DRV1_B1 after W784's steps:
   1. Open PITSCHEDULE and press Update existing schedule, so P11's rows are drawn.
   2. MOVE P11 by 1 m (an edit that refreshes the drawn cells).
   3. The drawn FROM cells must still read C5 and C6, on two lines.
   4. One U must take the move back.
8. **Remembered values:** PIT and CD write `CD_RecentValues.json`, as SETUP-P8v does. The settings guard restores only `CD_Settings.json`. The case has a SETTING line, so it runs in its own guarded AutoCAD start.

### 1.2 BUG-785: depth on the drawn Pit Schedule changes after the next edit

1. **Case id and twin:** none written.
2. **Why no case:**
   1. **Drawn table only.** The fix is in the after-command refresh of the DRAWN table and in redesign Apply. The window already used the right rule before the fix. A case must therefore read a drawn depth cell before and after an edit, and the robot has never read one. Whether DRV1_B1's drawn cells are loose texts that `select ... "layer=25TEXT"` can find is unknown (see FOR TIM item 9).
   2. **No suitable pit.** The three cases where the old and new rules differ all need a pit the robot does not have:
      1. a pump station (SPS type) whose inlet is lower than its rising-main outlet;
      2. a pit between 0.90 and 1.20 m deep, with the step-iron depth set to 1200 mm;
      3. a pit with no outlet level.
      The DRV1_B1 depths are not recorded below 1.63 m (P3), and placing a new pit's rows into the drawn table has no proven route.
   3. **The pit-floor rule shadows the fix.** With `linking.pitScheduleUsesPitFloor` on (the default), any pit with a recorded floor goes through the floor rule in both paths (`PitScheduleDepthRule.cs` 64-75; the older rule at 41-56). The difference BUG-785 fixed then shows only for a pit with no recorded floor, and whether CE records a floor on a new pit is not known.
3. **What the fix does, in drafting terms:** the drawn depth cell is worked out by the same rule as the window. A pump station takes the deeper of cover minus inlet and cover minus outlet. A pit with no outlet level uses its lowest inlet. "With Step Irons" uses the Settings step-iron depth, not a fixed 0.90 m.
4. **Code (3fbb9da5):**
   1. **The one rule:** `Rules/PitScheduleDepthRule.cs` 36-56 (`DepthText`, two decimals).
   2. **The refresh:** `Services/ScheduleLinkService.cs` 2043-2048 (depth cell) and 2734-2753 (`BuildDepthTextFromRecord`; the old rule, cover minus outlet only, at 2747-2751 when the switch is off).
   3. **Step irons:** `ScheduleLinkService.cs` 2971-2973.
   4. **The window:** `ViewModels/PitScheduleViewModel.Data.cs` 2155.
   5. **Switch:** `Models/UserSettings.cs` 1027-1032, `linking.pitScheduleDepthOneRule`, default true.
5. **Codex look (real AutoCAD, a made-up drawing):**
   1. Place a pit with cover 10.50 and the SPS pit type. Draw a gravity inlet arriving at 9.00 and an outlet leaving at 10.00.
   2. PITSCHEDULE: the depth must read 1.50. Place schedule; the drawn cell must read 1.50.
   3. Edit Pit (or MOVE the pit 1 m) and look at the drawn cell. It must still read 1.50; the fault read 0.50.
   4. Second part: Settings step-iron depth 1200 mm, a plain pit 1.00 m deep. After an edit, the drawn Remarks must NOT gain "With Step Irons".
   5. Put the Settings figure back to 900 afterwards.

### 1.3 BUG-786: saved row order splits a pit's rows once a pipe is added

1. **Case id and twin:** none written.
2. **Why no case:**
   1. **A saved order is needed first.** The fault shows only when the window holds a saved row order covering at least 90 per cent of rows (`ViewModels/PitScheduleViewModel.Data.cs` 890-910). Below that, the order is thrown away as stale.
   2. **Only `PersistManualRows` saves one** (`ViewModels/PitScheduleViewModel.Filters.cs` 491-534). It runs on:
      1. Place schedule (`PitScheduleViewModel.Schedule.cs` 816);
      2. the ↑ and ↓ buttons (`Data.cs` 2712; they need a selected row and are not on the press list);
      3. + Add Row, CSV import and set moves;
      4. cell edits and Stop overriding (`PitScheduleViewModel.cs` 1112-1493);
      5. Export, which no longer saves with the BUG-1198 switch on (`Schedule.cs` 49-53, 113-117).
   3. **None of these is in the robot's reach.** "Update existing schedule", which is pressable, returns at `Schedule.cs` 799-811 before the save at 816.
   4. **The test drawing has no saved order.** N29 passes with the new P8 between P7 and P9. Under a saved order a new pit with no saved place would go to the end (`Services/PitScheduleRowOrder.cs` 53-63).
3. **What the fix does:** a pit keeps its saved place and its rows stay together. A new inlet sends that pit's rows back to the build order, lowest inlet first (`Services/PitScheduleRowOrder.cs` 7-64; called at `Data.cs` 936-954). Switch: `linking.scheduleRowOrderByPit`, default true (`Models/UserSettings.cs` 824-829).
4. **What would make a robot case possible:** "Place schedule" on the v2 Pit Schedule press list (pinned list, needs Tim's word; job S1 asks the same). The steps would then be:
   1. PITSCHEDULE, Place schedule (this saves the order).
   2. A new pipe into P11 from a new pit (W784's route).
   3. PITSCHEDULE again: P11's rows must stay together and must not drop to the bottom.
   The twin would set `linking.scheduleRowOrderByPit` to false.
5. **Codex look (real AutoCAD, a made-up drawing of 10 or more rows):**
   1. Place the schedule.
   2. Add a second inlet to P5 whose level is the lowest at P5.
   3. Reopen PITSCHEDULE. P5's rows must sit together in P5's place, lowest inlet first. The new row must not be at the bottom with a blank pit number.

### 1.4 BUG-791: override marks on cells that were not changed

1. **Case id and twin:** none written.
2. **Why no case:**
   1. **Every trigger is a typed cell edit:** F2 then Enter with no change, a typed Cover, or a typed pit size. The grid cells have no id the robot can type into; their edit boxes exist only in edit mode, after a double-click (job S1 section 1 item 3).
   2. **The result is a colour.** A changed cell turns gold and italic, which the robot cannot judge.
   3. **The PITEDIT half needs a placed override first.** "PITEDIT P3 to 1200 x 1200 must show 1200 x 1200" can be driven only after a typed size override exists.
3. **Code (3fbb9da5):**
   1. **The decision:** `Dialogs/PitScheduleDialog.xaml.cs` 225-237 (mark a cell only when `PitScheduleOverrideMarkPolicy.ShouldMark` says the figure changed).
   2. **The policy:** `Services/PitScheduleOverrideMarkPolicy.cs` (never Pit Size).
   3. **Switch:** `Models/UserSettings.cs` 838-844, `linking.scheduleWindowMarksOnlyChangedCells`, default true.
4. **Codex look:** the carpark already records Codex W2-02 PASS SURE on 3.0.70: F2-Enter leaves the cell plain, a typed Cover is gold and italic, and a typed size resizes the pit and stays plain. One recheck on 3.0.88 with the same three steps is enough, plus:
   1. On a row overriding cover, type size 900 x 900.
   2. PITEDIT the pit to 1200 x 1200.
   3. The window and the drawn table must show 1200 x 1200, and Review and Update must not refuse with "display override has no accepted linked-value evidence".

## 2. Anything I could not write, and faults noticed (names only, nothing edited)

1. **Not written:** BUG-785, BUG-786 and BUG-791, for the reasons in 1.2 to 1.4.
2. **Fault in a sibling report, not a case:** `WAVE1_WRITING_S1_REPORT.md` section 2.1 item 2 and FOR TIM item 3 say no robot drawing is known to hold a placed schedule. DRV1_B1 does (R33's passing check names a drawn cell). The S1 conclusions still stand for other reasons (cell edits; "Place schedule" not pressable), but the BUG-246 route in S1 2.1 item 7 may already be open on DRV1_B1 through "Update existing schedule".
3. **R38's REVIEWED_AGAINST line** lists BUG-784 and BUG-785 as needing "a placed schedule or other data this fixture does not have". For BUG-784 the window half needs only typed pits (W784). The line is a note, not a fault in a check.
4. **No fault found in SETUP-P8v, SETUP-R47v or SETUP-P8x2v.** W784 uses none of them: it places its own pits, so no setup is needed.
