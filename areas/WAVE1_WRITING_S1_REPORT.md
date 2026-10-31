# Wave 1 case writing, job S1: Pit Schedule group (BUG-246, BUG-312, BUG-385, BUG-573), 31 Oct 2026

Writer: Opus case writer, job S1, brief `C:\CE_PLAN\desk_jobs\WAVE1_WRITER_BRIEF.txt`. Written Sat 31 Oct 2026, afternoon, Melbourne. Nothing was run: no AutoCAD, no driver, no runner except the offline `validate`, no build, no test. No existing case, setup, driver, runner, allow-list or settings file was edited. Nothing committed, pushed or deleted. Code read at the installed build `3fbb9da5` (Civil 3.0.88).

## FOR TIM (answer first)

1. **Answer:** 0 of my 4 bugs have a robot case. All 4 go to a Codex look in real AutoCAD; no case file was written.
2. **Why, in one line:** every one of them needs a Pit Schedule table drawn in the drawing, a typed edit in a schedule cell, or the right-click "Stop overriding" item. The robot can do none of these today.
3. **No drawn schedule:** the robot may not press "Place schedule". Its two press lists allow "Place", "Update existing schedule" and "Refresh", but not "Place schedule". No robot drawing is known to hold a placed schedule already (R38 says the same).
4. **No cell edits:** the schedule cells have no name the robot can type into. "Stop overriding" sits on a right-click menu, and the robot never right-clicks inside a window.
5. **BUG-312 also needs a close and reopen in the middle of the test.** One robot case runs in one AutoCAD start, so it cannot.
6. **Other route checked for BUG-312 (CDRENUMBER, which is typed):** it does not work. CDRENUMBER refuses up front when a label is on a locked layer, so no label is ever held back.
7. **One small change would let the robot reach BUG-246 and BUG-573:** add "Place schedule" to the Pit Schedule press list in `acad_driver_witness_v2.allowlist.json`. That list is pinned, so the change needs a reviewed edit and Tim's word. BUG-312 and BUG-385 would still need cell edits.
8. **BUG-385 has already passed twice with Codex on older builds:** W6-02 on 3.0.28 (rows 30 to 30 to 30) and W7-03 on the C-15 build. The carpark still says "not yet tested" against the 3.0.70 fix set, so one Codex recheck on 3.0.88 is enough.
9. **Codex look steps for all four** are in section 2, with the exact words from the code.
10. **Folder check:** `validate` on `drafts_wave1_31oct` printed "35 file(s) checked, 0 invalid". These are other writers' files. None of mine are there, and no W246, W312, W385 or W573 file exists.
11. **The id check and the grep for print, levels and street names** have nothing of mine to check.
12. **No fault found in an existing case or setup** (section 3).

---

## 1. What the robot can and cannot do in the Pit Schedule (read, not run)

1. **Press lists:** v3 `ui-press` (`acad_driver_v3.allowlist.json`, entry "Creative Engineering*") allows only Cancel without saving, Cancel and Close. v2 `ui2-press` (`acad_driver_witness_v2.allowlist.json`, entry "*Pit Schedule*") allows Apply, Place, Update, Update existing schedule, Relink and recalculate, Continue to Place / update, Full Schedule, Back to Full Schedule, Next missing input, Refresh, Sort, Reset Sort, Cancel, Close, OK and Show where. The match is `-like` with no wildcard, so "Place" does not match "Place schedule".
2. **The placement button is called "Place schedule" when nothing is placed yet:** `Models/PitScheduleWorkflowState.cs:40-41`, `HasPlacedSchedule ? "Update existing schedule" : "Place schedule"`. It then asks "Specify schedule insertion point: " (`ViewModels/PitScheduleViewModel.Schedule.cs:819`).
3. **Setting values:** v2 `ui set` writes a text box, tick box or option button by name. The grid cells are TextBlocks. Their edit boxes ("Depth", "Remarks", "Override reason") exist only while a cell is in edit mode, and that needs a double-click (`Dialogs/PitScheduleDialog.xaml:808-830`, `:640-680`). The OVERRIDE tick box is `IsEnabled="False"` (`:643-646`).
4. **Tabs:** v2 `ui set` selects option buttons only, not tabs (`acad_driver_witness_v2.ps1:2671`). The Source tab, which holds the LINKED SCHEDULE badge (`PitScheduleDialog.xaml:172-181`), cannot be opened. The same detail sentence is also on the Placement tab (`ScheduleWorkflowStatusText`, `PitScheduleDialog.xaml:1203`, `ViewModels/PitScheduleViewModel.cs:823-838`). The robot can reach that tab with v2 "Continue to Place / update".
5. **Restart:** SLOT may only be `launch` or `fresh` (`case_runner_lib.ps1:128`), and the runner cannot open a saved copy in a later case.

## 2. Per bug

### 2.1 BUG-246: Pit Schedule status after a protected drawn cell is skipped

1. **Case id and twin:** none written.
2. **Why no case:** the fix only matters when a Pit Schedule table is drawn. The robot cannot place one (section 1.1 and 1.2), and no robot drawing is known to hold one.
3. **What the fix does, in drafting terms:** when PITSCHEDULE finds a drawn schedule cell that is out of date and was left alone (locked layer, Xref or an open REFEDIT), the LINKED SCHEDULE badge reads OUT OF DATE instead of CURRENT. The detail names the cells and says to unlock and press Refresh.
4. **Words from the code:**
   1. **Badge:** "OUT OF DATE" (`Services/PitScheduleStatusService.cs:219-231`; it replaces CURRENT and "not linked" only, at `:258-259`).
   2. **Detail, one cell:** "1 drawn Pit Schedule cell is out of date: it was left as drawn because its layer is locked, it is in an external reference, or a reference edit is open. Unlock the layer (or close the reference edit), then press Refresh." (`Services/ScheduleCellRefreshGate.cs:413-424`)
   3. **Detail, several cells:** the same sentence with "N drawn Pit Schedule cells are out of date: they were left ...". At most 3 cells are named (`PitScheduleStatusService.cs:217`), then "1 more cell." or "N more cells." (`:247-256`).
   4. **Each named cell:** "Pit schedule cell for P3 (cover level) not updated: its layer is locked." (`ScheduleCellRefreshGate.cs:151-158`)
   5. **After Refresh:** "1 drawn schedule cell brought up to date." or "N drawn schedule cells brought up to date." (`ScheduleCellRefreshGate.cs:426-433`)
5. **Codex look (real AutoCAD, a made-up drawing, two pits and one pipe):**
   1. Run PITSCHEDULE and press Place schedule. Pick a point. Close.
   2. Lock the layer the table is on. Change one pit's cover in Edit Pit (or MOVE a pit so a pipe level changes).
   3. Open PITSCHEDULE again. On the Source tab the badge must read OUT OF DATE (never CURRENT), and the detail must name the pit and column. The Placement tab must show the same sentence.
   4. Close, unlock the layer, open PITSCHEDULE again and press Refresh. The footer must say "1 drawn schedule cell brought up to date." and the badge must go back to CURRENT.
   5. One U must undo the Refresh.
6. **What a broken build would show:** CURRENT with "The linked source fingerprints match the placed pit schedule." (`PitScheduleStatusService.cs:188-191`) while the table still shows the old value.
7. **If "Place schedule" is ever added to the v2 list:** a robot case becomes possible on DRV1_B1. Steps: PITSCHEDULE, Place schedule, typed insertion point, lock the table layer with typed `-LAYER`, Edit Pit cover, PITSCHEDULE, "Continue to Place / update", then read the Placement tab sentence. A probe must first confirm the table's layer name and that the typed insertion point is taken.

### 2.2 BUG-312: Refresh still finds plan labels held back by a locked layer after close and reopen

1. **Case id and twin:** none written.
2. **Why no case:** a label is only held back when a Pit Schedule edit has to update it. That edit is a typed cell edit (cover, invert or depth; the calls are at `ViewModels/PitScheduleViewModel.Data.cs:1762, 1807, 1885, 1890, 1928` and `Services/ScheduleLinkService.cs:416-419`). The robot cannot type into a cell. The proof also needs the drawing saved, closed and reopened between the edit and the Refresh, and one robot case cannot span two AutoCAD starts.
3. **Other route checked:** CDRENUMBER (`Services/PitRenumberApplyService.cs:147`) calls the same label sync. But its preflight refuses the whole renumber when a label is on a locked layer: "...'s label or cover level text is on the locked layer "<name>" — clear it before renumbering." (`:72-75`, `:95-100`). So it never holds a label back.
4. **What the fix does, in drafting terms:** the list of plan labels a locked layer held back is now kept in the drawing's own CE record (`Models/ProjectData.cs:163-182`; written at `Services/ProjectDataService.Mutations.cs:1085-1117`; read at `:1122`). Refresh after a reopen still finds them (`ScheduleLinkService.cs:3150-3176`; window call at `PitScheduleViewModel.Data.cs:2768-2790`).
5. **Words from the code:**
   1. **When the edit is held back:** "<Pit P3> is on locked layer "<layer>", so CE left a label of pit P3 as it was. CE never unlocks a layer: unlock it and try again." (`Rules/LockedLayerRecordWriteRule.cs:333-340`). The way back is "close the Pit Schedule window, unlock the layer, open PITSCHEDULE again and press Refresh to bring the label up to date" (`:228-230`).
   2. **On Refresh after unlocking:** "Brought 1 plan label up to date that a locked layer had held back." (`LockedLayerRecordWriteRule.cs:325-327`; the window drops the "[CE] " prefix at `PitScheduleViewModel.Data.cs:2785-2787`).
   3. **Civil log:** "[BUG-312] pit <handle> kept in the drawing's held-back plan label list (1 left)", then "... taken off ... (0 left)" (`ProjectDataService.Mutations.cs:1117`).
6. **Codex look:**
   1. On a made-up drawing, lock the layer of pit P1's cover text (CL label). In PITSCHEDULE, type a new cover in row P1 (for example 20.900 to 20.950). Close.
   2. The command line must say the label was left on the locked layer. The plan label must still show the old cover.
   3. QSAVE, close the drawing, open it again. Unlock the layer.
   4. PITSCHEDULE, press Refresh. The footer must say "Brought 1 plan label up to date that a locked layer had held back." and the plan CL label must now show 20.95.
   5. The Civil log must show the BUG-312 line "taken off ... (0 left)".
7. **What a broken build would show:** Refresh says nothing and the plan label stays at the old cover after the reopen.

### 2.3 BUG-385: Revert Row Override (now "Stop overriding") must never remove a row

1. **Case id and twin:** none written.
2. **Why no case:** the route is a typed cover in a grid cell, then the right-click item "Stop overriding" (`Dialogs/PitScheduleDialog.xaml:547-550`). The robot can do neither (section 1.3). The second-drawing part of the fix (#667, the "BUG-385 class" records in `Services/ProjectDataService.KeptRecords.cs` and `ProjectDataService.Mutations.cs:214-316`) needs two drawings open, and the driver refuses OPEN.
3. **What the fix does, in drafting terms:** Stop overriding only clears the override flag. The typed value stays and the row stays listed (Tim INT-043: "revert row override i think stop overriding"). CE's record in memory is always bound to the drawing in front, so a second drawing cannot lose this drawing's rows.
4. **Words from the code:** the menu item is "Stop overriding", with the hover text "Stop treating this row as an override. The values you typed stay." (`PitScheduleDialog.xaml:547-550`). The footer shows `StopOverridingSentence` (`ViewModels/PitScheduleViewModel.cs:1460-1494`). Its wording was not copied here, so Codex reads it from the screen.
5. **Previous real-AutoCAD passes (carpark BUG-385 and run 22):** W6-02 PASS on 3.0.28 (rows 30 before, 30 after the cover edit, 30 after Revert on P11; P8, P11 and P12 listed). W7-03 PASS on the C-15 build. Run 22 C1 PASS (two drawings open, W1 kept its 30 rows).
6. **Codex look (repeat W6-02 on 3.0.88):**
   1. On the modern-pipe test drawing, open PITSCHEDULE and note the total rows.
   2. Type a new cover on one pit row. Right-click the row and choose Stop overriding.
   3. The total rows must be unchanged and a search for that pit must find its row.
   4. The typed cover must stay, in the row and on the plan label. One U must undo it.
   5. Then open a second drawing, run PITSCHEDULE there, switch back: the first drawing's row count must be unchanged.
7. **What a broken build would show:** the total drops (30 to 27 on 3.0.27) and the search finds 0 rows.

### 2.4 BUG-573: a placed schedule must not list "changes" that are only trailing zeros

1. **Case id and twin:** none written.
2. **Why no case:** the Changes list exists only once a linked schedule is placed, and the robot cannot place one (section 1.1 and 1.2).
3. **Drawing considered:** the drawing where the bug was seen is in the fixture folder (`C:\ce_rc_drv\CODEX_UI50_CIVIL_20261014.dwg`, last written 14 Oct 09:12). I could not tell offline whether it holds the placed schedule: the DWG is compressed and a text search found no "Pit Schedule" text. Brief rule 8 says not to guess, so it is not used. It was also saved by 3.0.49 with the old baseline, so it would not be a clean test of the fix anyway.
4. **What the fix does, in drafting terms:** when a placed schedule is compared with the drawing, 21.000 and 21.00 (or 20.800 and 20.80) count as the same level. Nothing is rounded: 21.000 against 21.010, or 20.80 against 20.804, is still a change (`Services/PitScheduleDifferenceService.cs:557-575`, `SameValue`, fix commit `caa1db83`).
5. **Codex look:**
   1. On a made-up drawing, place pit P1 with cover 21.000 and pit P2 with cover 20.800, and join them with a pipe. QSAVE, close and reopen.
   2. PITSCHEDULE, press Place schedule, pick a point.
   3. Open PITSCHEDULE again at once, editing nothing. The Changes tab must list no cover change for P1 or P2. The badge must read CURRENT ("The linked source fingerprints match the placed pit schedule.").
   4. Then change P1's cover to 21.010 in Edit Pit and open PITSCHEDULE. Changes must list P1's cover 21.000 to 21.010 (or 21.00 to 21.01).
   5. Repeat with one level at zero and one negative (for example 0.000 and -0.500) if the drawing allows it.
6. **What a broken build would show:** two cover changes, P2 20.800 to 20.80 and P1 21.000 to 21.00, straight after placing.
7. **Not covered by this fix (carpark extension of 14 Oct):** the placed table already showing 21.10 while Placement offers 21.00 to 21.10. That is a separate part of BUG-573 and stays OPEN whatever this look shows.

## 3. Anything not written, and faults noticed

1. **Not written:** all four bugs (reasons in section 2). They go to the Codex lane, or to Tim for the allow-list question in FOR TIM item 7.
2. **Faults in existing cases or setups:** none found. I read R25, R38 and N26 as templates. R25's NOT_AUTOMATED line still says "Revert Row Override", while the menu item is now "Stop overriding" (`PitScheduleDialog.xaml:547`). That is wording only, not a fault in a check.
3. **Carpark note for the desk (not edited):** BUG-385 records Codex PASSes on 3.0.28 (W6-02) and the C-15 build (W7-03), but its Status line says "not yet tested by robot or Codex". The desk may want to reconcile that when the 3.0.88 look comes back.
