# Workflow card drafts 2 of 15: Pit Schedule and Pit editing

Written Monday 2 November 2026 (Melbourne) by Sonnet (Team, read-only) at CE 05's request for CE 00. The only file written is this one.
Lines read with git: `origin/claude/rel-20261102a` (3fbb9da5, Civil 3.0.88) and `origin/claude/rel-20261112a` (ccaf0783, the C-79c finalizer line). `gh` is not on this tool path, so no PR state was read live; PR heads come from the CE 05 pre-reviews and the build register.

## FOR TIM

1. **Five cards follow, one per command. All five are drafts: nothing is approved.** Each has the 19 fields in order.
2. **Only the #1881 row growth is on a line today, and only on the C-79c line.** I checked with git: #1881's head (72b032fa) is on `rel-20261112a`. It is NOT on `rel-20261102a`, and nothing is installed. Every other PR here (#1423, #1816, #1593, #987, #1047, #1983) is a draft that is on neither line.
3. **Two PRs need a rebuild before they can be carded as final.** #1423 (typed cover follows its pit) is CHANGE-NEEDED and FULL, and the line has since rewritten the row it changes. #987 has an open hole: a tank at exactly 45 degrees still snaps to 0 on a number-only Save. #1593 needs a small fix too.
4. **Commands I could not pin down fully:** the ribbon tab title that holds the Pit Schedule button (I read the panel and button, not the tab name). The exact label code of a detention pit (only the number change C1 to C99 is described). The Pit Schedule row's real wrap in AutoCAD, which nobody has seen.
5. **Questions for you are in field 18 of each card.** Six in all, batched. The ones that matter most: whether to put the #1881 switches on a Settings tab first (decision 126 already says yes), and what P1 should look like when two Xrefs both have one (BUG-1044).
6. **Owed to you from the build register:** a picture of a three-line remark (Codex Look 1) before #1881 ships. No record that it was done.
7. **Read:** the Opus reviews AE, BACKLOG_R1, R3, BACKLOG2_R2 and the 1981/1983 group, the carpark entries, the build register, the C-79c assembly line, the command registry, the ribbon file and the Pit Schedule export code on the lines. **NOT read:** REGRESSION_LOG.md entries on the line, the C4 workflow cards, the XAML of the Pit Edit window, and Tim's settings (not allowed).
8. **NOT proven anywhere:** nobody has opened any of these five changes in AutoCAD. Built and unit-tested only, by the authors. I ran nothing.

---

## CARD 1 of 5: Pit Schedule row for a long lid and remarks note

**DRAFT FOR TIM: nothing is approved**

1. **Name and what it does for a drafter.** Pit Schedule long-note row (PR #1881, B-028, BUG-587): a pit whose lid and remarks note runs to three lines or more gets a row twice as tall, so the note stops crossing the lines.
2. **Ribbon or trigger.** Command `PITSCHEDULE`, ribbon button "Pit Schedule" in the Civil Review panel (CeCvlRibbonContributor.cs line 258; Settings layout file lists it under "Review"). Registry label "Pit Schedule", group Schedule, Review. The row growth runs when you place the schedule and when you press "Update placed schedule" (and in network redesign). I did not read the ribbon tab's title.
3. **Works today.** On the installed 3.0.88 line a note of three or more lines crosses the divider and the bottom border (carpark BUG-587, seen 14 Oct on 3.0.49). Rows are 750 apart, 20 rows per master, masters 17,500 apart (PS-01 card). Keep: the 750 grid, the 20-row continuation, one Undo for a placement.
4. **What the train or PR changes.** #1881 head 72b032fa, 10 real files, three commits (2179b824, 07df4f48, 72b032fa). Two switches, both ON: `linking.scheduleRowGrowsForLongRemark` and `linking.scheduleDoubleRowHidesDivider`. Five figures, settings file only: `scheduleLongRemarkCharWidthFactor` 0.75, `scheduleLongRemarkMinLinePitch` 1.2, `scheduleRowTextMargin` 50, `scheduleDoubleRowMaskInset` 20, `scheduleDoubleRowMaskHalfHeight` 25. Where: the C-79c line `rel-20261112a` (assembled, finalizer GO, class AREA, becomes Civil 3.0.92, not installed). Not on `rel-20261102a`. Reviewed: AE KEEP-WITH-NOTE (1 Nov).
5. **Suggested class: Modify.** It adds to a working command and the old behaviour comes back with the switch off. Suggestion only.
6. **Prompts and windows.** No new window or prompt. One new command-line line when strips sit on a locked layer: "[CE] The white strips from an earlier two-row remark were left in place: their layer is locked. Unlock that layer yourself and press Update again to remove them." (PitScheduleRowGrowth.cs).
7. **Selection.** None new. Same Pit Schedule window and Update path.
8. **Preview.** None. The grown row is only seen once drawn. The window's own preview was not read as changed (no XAML file is touched).
9. **Drawing output.** A note estimated at three lines or more (22 characters per line for the 4200-wide lid column) first tightens line spacing (never under 1.2 times text height). Otherwise that row becomes two rows (1500 instead of 750), the note sits in the middle, rows below drop one row, and white strips (wipeouts, 50 high, stopping 20 short of each column line) hide the line through the middle. The strips are on the schedule block's own layer. Locked layers: a strip on a locked layer is not drawn or not erased and the line above says so; nothing is unlocked. Xrefs and REFEDIT: strips are made only in this drawing's model space; Update refuses while REFEDIT is open; the placement path has no REFEDIT check of its own (older code, per AE). Not touched: other text, other layers.
10. **Cancel, Escape, Undo and Redo.** Runs inside the command's existing transaction, so one Undo should take back a placement or an Update. NOT seen in AutoCAD: AE lists Undo and a delayed Redo as unproven. Case N35_sched_row2 has an "one U then delayed REDO" step.
11. **Save and reopen.** NOT seen. AE: Update twice after reopen must still give 10 strips (no duplicates); case includes QSAVE, reopen, Update.
12. **Assets, data and Settings.** Reads the two switches and five figures from `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` only. Decision 126 (29 Oct) puts them on a new Settings tab "Switches": not built. Turning the double row off today means editing that file by hand. Switch-off recovery: with growth off, Update moves cells back to the 750 grid and erases only strips this schedule owns.
13. **Performance.** Pure arithmetic per row (AE and the C-79c report: arithmetic only, no event hooks). Not measured in AutoCAD.
14. **Discovery.** Ribbon "Pit Schedule"; Help page https://help.creativeeng.com.au/ce-cvl-suite/commands/pitschedule (registry). No What's New line for this change was found (GUESS: none yet).
15. **Example drawing and expected result.** A 450 x 450 pit P2 on a 1 in 200 run, lid "CODEX CHECK With Step Irons" plus a three-line remark. Expect P2's row 1500 tall, the remark centred, no line through it, P3's row 750 below it; Update again: still 10 strips in a 10-pit schedule. Switch off, Update: rows 750 apart, 0 strips.
16. **Older family card.** `docs\CARDS\PS-01_PIT_SCHEDULES.md` (and `docs\workflows\C4_COMBINED_PIT_SCHEDULE_EXACT_UPDATE_2026-09-09.md`, `C4_SYSTEM_SCOPED_PIT_SCHEDULE_2026-09-10.md`, read as history). PS-01 fixes every row at 750 and says each master carries at most 20 rows. It does not cover a doubled row, white strips, the five figures, or the "nudge of 300 or more is reset" side effect. AutoCAD verification there reads "not started".
17. **Tim's AutoCAD checklist** (copy of a drawing, after the line is installed; robot case N35_sched_row2 is meant to cover this):
    1. Open a copy with 10 pits. Type `PITSCHEDULE`. Give P2 a three-line remark. Place the schedule.
    2. Look at P2: it should be two rows tall, the note in the middle, no line through the words.
    3. Check P3 sits one row lower than it did.
    4. Press Update placed schedule twice. The count of white strips should stay at 10 in a 10-pit schedule.
    5. Type `U`, wait 12 seconds, type `REDO`. Same picture.
    6. `QSAVE`, close, reopen, Update. Same picture.
    7. Plot to PDF. Look at the white strips: no ticks at column lines.
    8. Drag P5's level text down 400, press Update: it will go back (finding H). Say if that is acceptable.
18. **Questions only Tim can answer.**
    1. Context: decision 43.3 asked for a picture of a three-line remark before this ships. I understand none was recorded. Recommendation: ask Codex for Look 1 first, then decide. On a job: a note that wraps differently in your text style could still cross a line.
    2. Context: the build register records that moving a cell by 300 or more is reset on Update. Recommendation: accept it (very rare), but keep the wording in the change log. On a job: a hand-dragged level text jumps back.
    3. Context: switches only in the settings file. Recommendation: hold the install until the Switches tab exists, or accept file-only for colleagues. On a job: a colleague who dislikes the double row cannot turn it off without editing a file.
19. **NOT proven.** Built: yes (C-79c assembly, Civil net10 full 22,708 run, 0 failed per finalizer; net48 had 133 reds = 129 known plus 4 of the same kind in #1881's tests). Tested: unit tests only, 39 in the Bug587 file; no AutoCAD run. Installed: no. Tim-accepted: no. Nobody has done the robot case, the Codex look, or Tim's check. BUG-587 stays OPEN.

---

## CARD 2 of 5: Pit Schedule typed cover stays on its pit; two Xrefs with the same P1

**DRAFT FOR TIM: nothing is approved. Two changes on one card; both are drafts and neither is on a line today.**

1. **Name and what it does for a drafter.** (a) PR #1423 (BUG-787): a cover or other figure you typed on a pit's first row stays there when an inlet is added. (b) PR #1816 (BUG-1044): two Xrefs that both have a pit P1 no longer empty the whole combined Pit Schedule.
2. **Ribbon or trigger.** `PITSCHEDULE` (Civil Review panel, button "Pit Schedule"). For (b) the window path is Source > Drainage XREFs, tick both.
3. **Works today.** (a) On the line today a typed cover lands on the second row after an inlet is added; cover prints only on the first row so it disappears, and a stray depth prints on the inlet row (BUG-787). (b) With two Xrefs that both hold P1 the schedule is empty and placing is blocked: "XREF source conflict - schedule placement blocked" and "Cannot combine sources: Pit P1 appears in A and B. Rename it in a source drawing." (BUG-1044). Keep: Was / Now overrides, BUG-780's merged-row lending (on the line), BUG-1022's re-found pit handle move (on the line).
4. **What the train or PR changes.**
   1. (a) #1423 head da925637, switch `linking.scheduleOverridesFollowPit` ON. New `PitScheduleOverrideMatcher.cs`. Opus review (R1, 1 Nov): CHANGE-NEEDED, class FULL. It is the old 18 Oct branch, on HOLD since 24 Oct. **Not on `rel-20261102a` or `rel-20261112a`** (git: not an ancestor of either).
   2. (b) #1816 head d38ca6ed, switch `linking.xrefScheduleKeepsNonClashingRows` ON, no Settings row. Opus review (R3): KEEP-WITH-NOTE, area plus smoke, half the fix. **Not on either line.**
   3. **Which are on the line today:** neither. Both are drafts only.
5. **Suggested class: (a) Rebuild** (it must be rebuilt on today's code, per R1; the line rewrote the exact line it changes). **(b) Modify.** Suggestion only.
6. **Prompts and windows.** (a) None. (b) The Data check panel line: "[CE] Pit P1 appears in A and B. Rename it in a source drawing. This number is left out of the schedule." Rows exist, so Continue to Place is available. With the switch OFF the old blocking message returns.
7. **Selection.** Same Source choice. (b) Both Xrefs ticked.
8. **Preview.** Window rows only. Nothing is drawn until placed.
9. **Drawing output.** (a) Nothing new until placement; same placement path. (b) Placed schedule lists P2 and P3 only; P1 from both is left out and nothing on the placed table says so (R3). The Xref sources are read-only: no Xref is bound, edited or renamed; locked layers and REFEDIT are untouched by the change (reader opens records for read, per the author; Opus did not trace the reader).
10. **Cancel, Escape, Undo and Redo.** (a) Window-side figures only. (b) Placement path unchanged: robot step "U, wait 12 s, REDO on the placement" is listed, not run.
11. **Save and reopen.** (a) Typed figures are saved per row; the rebuild must keep the cover after reopen (robot step lists it). Second concern from review B3: after an outlet change, clearing a cover may let the old record bring it back; no test.
12. **Assets, data and Settings.** Switches above, settings file. Neither switch is pinned through both start-up reads yet (#1423 pinned for default only; #1816 not through the tolerant read). The ProjectData override records are read and written.
13. **Performance.** Not assessed. (a) FULL class because every schedule rebuild is affected.
14. **Discovery.** Ribbon "Pit Schedule"; the Help page named in Card 1. Nothing new.
15. **Example drawing and expected result.** (a) P5 cover 20.95 typed on the first row, add an inlet lower than the existing one: 20.95 stays on P5's first row, no stray depth on the inlet row; change P5's outlet pipe: 20.95 stays; clear the cover: stays blank. (b) Drawing A has P1 and P2, drawing B has P1 and P3: two rows (A/P2, B/P3), a Data check line naming P1 in A and B, Place enabled. The carpark's own expected result is four rows with A/P1 and B/P1 told apart: **#1816 does not give that, so BUG-1044 stays OPEN.**
16. **Older family card.** `docs\CARDS\PS-01_PIT_SCHEDULES.md` and the two C4 cards. PS-01 says "stable row identity" and "no silent override" but nothing about a typed figure following its pit or about a duplicate P1 across Xrefs.
17. **Tim's AutoCAD checklist** (after a rebuilt #1423 and #1816 are on a line):
    1. Fresh copy. `PITSCHEDULE`. On P5's first row type cover 20.95.
    2. Draw a new inlet into P5 lower than the old one. Reopen the window and place. Expect 20.95 on the first row and no depth on the new inlet row.
    3. Change P5's outlet pipe. Expect 20.95 stays.
    4. Clear the cover and reopen. Expect it stays blank.
    5. Repeat on a merged-row case to check BUG-780 still holds.
    6. For Xrefs: attach A (P1, P2) and B (P1, P3) to a host. `PITSCHEDULE`, Source, Drainage XREFs, tick both. Expect two rows, a line naming P1, and Place available. Place it and read the table.
    7. Open A and B afterwards: P1 still there, files not changed.
18. **Questions only Tim can answer.**
    1. Context: BUG-1044. I understand #1816 leaves both P1s out; the carpark wanted both shown, labelled by source drawing. Recommendation: accept the two-row version as a first step but write on the placed schedule that P1 was left out. On a job: an engineer could issue a schedule missing a pit.
    2. Context: #1423 is FULL class and will touch every schedule rebuild. Recommendation: rebuild it on the new line and run a full re-test. On a job: a wrong carry-over would show a wrong cover level on a council schedule.
    3. Context: #1816 has no tick box in Settings. Recommendation: file-only is acceptable for now, put it on the Switches tab later.
19. **NOT proven.** Built: yes by the authors (#1816: 15 checks, 20,554 run with 8 failures the same as base; #1423: 11 pure matcher tests). Tested: unit only; none in AutoCAD; #1423 needs a rebuild first. Installed: no. Tim-accepted: no. BUG-787 and BUG-1044 stay OPEN.

---

## CARD 3 of 5: Pit Schedule CSV and Excel export, Design-check CSV export (Cancel)

**DRAFT FOR TIM: nothing is approved**

1. **Name and what it does for a drafter.** The three export buttons: Pit Schedule "Export CSV", Pit Schedule "Export Excel", Design check "Export CSV…". PR #1983 (BUG-1268, B-157) adds one log line when you press Cancel in their Save box. Screen behaviour is meant to be the same.
2. **Ribbon or trigger.** Command `PITSCHEDULE` then the window buttons "Export CSV" and "Export Excel" (PitScheduleDialog.xaml lines 1275 and 1284). Design check: command `CDDESIGN` area, the Design-check dashboard window, button "Export CSV…" (DesignCheckDashboardDialog.xaml line 513; save box titled "Export Design-Check Report").
3. **Works today** (read in the code on `rel-20261112a`). Pit Schedule CSV: "No schedule rows to export." if empty; Save box with filter CSV, name `Pit_Schedule.csv`, starting folder the job's Civil folder; **Cancel returns silently, no message and no log**; success sets the status "CSV export complete." Excel works the same way (the 1 Nov Codex cases K1-01 and K1-03 passed). BUG-1198 on the line (switch on the schedule rows exported) is separate. Keep all of this.
4. **What the train or PR changes.** #1983 head 4fcf82b4, one commit on `rel-20261102a` 3fbb9da5. Opus pre-review: KEEP-WITH-NOTE, area plus smoke. For these three exports, only an INFO line when Cancel is pressed (Schedule.cs about lines 69-73 and 137-141; DesignCheckDashboardViewModel.cs about 634-638). It also moves `GetDefaultCivilFolder` to a shared `ExportFolderHelper`, unchanged except private to internal; all four Pit Schedule Save boxes still start in the same folder (Opus checked line by line). **Not on `rel-20261102a` or `rel-20261112a`.** A candidate for C-80; it still needs a Codex look K1_02b.
5. **Suggested class: Keep** for these three exports (log line only). The CDCALC part is Modify and is on the CDCALC card: **BUG-1268 (CDCALC Export to XLSX writes no file) is separate; see the CDCALC card.**
6. **Prompts and windows.** Nothing new. The Windows Save box is unchanged. The one new text is in the CE log, not on screen: Opus quotes "CDCALC: XLSX export cancelled at the Save As window" for CDCALC; the exact wording of the three export lines was not read.
7. **Selection.** None.
8. **Preview.** None.
9. **Drawing output.** None. These write a file only. Not applicable to locked layers, Xrefs or REFEDIT.
10. **Cancel, Escape, Undo and Redo.** Cancel or Escape in the Save box: nothing is written and nothing on screen changes; after #1983 one line goes to the CE log. Undo and Redo do not apply (no drawing change).
11. **Save and reopen.** Not applicable to the drawing. The exported file is the output.
12. **Assets, data and Settings.** Reads the CE log folder. The log line carries no folder name (privacy choice by the author, Opus agreed). Switch `excel.confirmCalcXlsxSaved` ON applies only to CDCALC XLSX, not to these three. New test: `EveryCivilExportMethod_LogsWhenItsSaveAsWindowIsCancelled` (any future silent Cancel in an export fails the build).
13. **Performance.** No change.
14. **Discovery.** Buttons inside the windows; the Pit Schedule Help page. No change.
15. **Example drawing and expected result.** Pit Schedule with 8 pits: Export CSV, name `K1.csv`, Save: file exists, status "CSV export complete.". Repeat and press Cancel: no file, no message, one INFO line in the log.
16. **Older family card.** `docs\CARDS\PS-01_PIT_SCHEDULES.md` (CSV and Excel are in the PS1 to PS20 list). It does not say what Cancel does or what is logged.
17. **Tim's AutoCAD checklist** (after C-80 is installed; the Claude robot refuses Export buttons, so this is a Codex look or yours):
    1. `PITSCHEDULE`, press Export CSV. Check the Save box opens in the job's Civil folder. Save. Check the file is there.
    2. Press Export CSV again and Cancel. Nothing should appear on screen.
    3. Repeat 1 and 2 for Export Excel.
    4. Open the Design-check window, press Export CSV…, then Cancel. Nothing on screen.
    5. Open the CE log and look for one line for each Cancel.
18. **Questions only Tim can answer.** None that I could find. One for the desk, not Tim: should the cancel line say "cancelled" on screen too? Recommendation: no; same as today.
19. **NOT proven.** Built: yes (18 tests in the new class; 116 focused on net10 and net48 per the author). Tested: unit only, not in AutoCAD. Installed: no. Tim-accepted: no. Nobody has run the Cancel on any of the three in AutoCAD.

---

## CARD 4 of 5: CDTWL lid of a pit with no floor level

**DRAFT FOR TIM: nothing is approved**

1. **Name and what it does for a drafter.** Top Water Level (PR #1593, BUG-1021): the low-lid check now counts a pit whose lid is known but whose floor level is not. It still adds no litres for that pit.
2. **Ribbon or trigger.** Command `CDTWL`, ribbon button "Top Water Level" (Review panel, keytip TW); registry "Top Water Level (CDTWL)", group Calculations. Changes nothing in the drawing.
3. **Works today.** CDTWL works upstream from a detention pit or tank outlet, lists every level the system could be held to with where each came from, and reports storage, head on the orifice and any pit the water would come up out of. Today a pit with lid RL 10.200 and no floor is dropped from the lid check, so P1 at RL 12.000 is called the lowest lid and a chosen level of 10.500 is not warned. Keep: the listing, the "never picks the level for you" rule.
4. **What the train or PR changes.** #1593 head 7884b0cf, no switch (carpark: "No switch"). Opus R1 verdict **CHANGE-NEEDED (small)**, area plus smoke. #1635, which had to go first, is already on the line. Not on `rel-20261102a` or `rel-20261112a`. Adds: a "lid only" pit list feeding (a) the lowest-lid figure ("Careful: that is ABOVE the lowest lid in this system (10.20)"), (b) the warning "Water would come up out of pit LOW - the top water level is above its lid", (c) a note "pit LOW holds no water in the sum, but its lid (10.200) is still checked against the top water level."
5. **Suggested class: Modify.**
6. **Prompts and windows.** The three lines above, on the command line and in the report. Still missing (Opus item 2): "...so the water would come up out of P1 first" and the pick-list row "the lid of P1 - the first thing water would come out of" can still name P1 when LOW's lid is lower. The solver's ceiling still stops at the higher lid.
7. **Selection.** You pick the detention pit or tank outlet, then the top water level from the list, or type one (for example 10.500).
8. **Preview.** Report text only.
9. **Drawing output.** None. Nothing drawn or edited, so locked layers, Xrefs and REFEDIT are not involved.
10. **Cancel, Escape, Undo and Redo.** Cancel or Escape ends the command; no drawing change, nothing to undo.
11. **Save and reopen.** Not applicable.
12. **Assets, data and Settings.** Reads pit lids, floors and pipes from the drawing's CE data. No new setting.
13. **Performance.** Not assessed.
14. **Discovery.** Ribbon "Top Water Level"; command line `CDTWL`; Help page not read.
15. **Example drawing and expected result.** Branch with pit LOW lid 10.200, floor blank, no connected invert; pit P1 lid 12.000. Run CDTWL, type 10.500. Expect "ABOVE the lowest lid (10.20)", the "Water would come up out of pit LOW" line, the "holds no water" note, and no litres added for LOW. After the small fix, also: the "come up out of X first" line and the pick-list row must say LOW, not P1. Repeat with LOW's size blank instead of the floor.
16. **Older family card.** `docs\workflows\CDWT_DETENTION_TWL_PLAN.md` (read as history by title only; not opened in this job). GUESS: it predates a lid-only check.
17. **Tim's AutoCAD checklist** (after the small fix):
    1. Open a copy with LOW (lid 10.200, no floor) and P1 (lid 12.000) in one branch.
    2. Type `CDTWL`, pick the outlet, type 10.500.
    3. You should see the "ABOVE the lowest lid (10.20)" line and "Water would come up out of pit LOW".
    4. Look at the pick list: no row should say P1 is the first to overflow.
    5. Check the storage total is the same as before (no litres for LOW).
18. **Questions only Tim can answer.**
    1. Context: the solver's ceiling (the highest level CDTWL will work to) still stops at the higher lid. Recommendation: leave it for now and say so plainly in the change log, because changing it moves a solved level. On a job: the suggested top level could be above LOW's lid even though CDTWL now warns.
19. **NOT proven.** Built: yes (4 pure tests; 2 red before per the Codex ledger). Tested: unit only, no AutoCAD run. Installed: no. Tim-accepted: no. The three places still naming P1 are not fixed. BUG-1021 stays OPEN.

---

## CARD 5 of 5: Edit Pit on a detention tank keeps its sides; plastic pit "PP" printed once

**DRAFT FOR TIM: nothing is approved. Two changes on one card; neither is on a line today.**

1. **Name and what it does for a drafter.** (a) PR #987 (BUG-561): changing only a detention pit's number (C1 to C99) and pressing Save no longer swaps its grate side and solid-cover side. (b) PR #1047: a plastic pit's "PP" cover-text line is not printed twice after you save, reopen and change the level.
2. **Ribbon or trigger.** Command `CDEDIT` ("Edit Pit or Pipe (CDEDIT)" in the registry; old alias `PITEDIT` is retired to `CDEDIT`). Ribbon: select a pit, the contextual "Pit" tab, panel "Pit", button "Edit Pit" (CeCvlRibbonContributor.cs line 211). The label code is the pit's cover text built by the shared formatter (PitAnnotationTextFormatter.cs lines 23-27 add "PP" for the plastic flag, per the Opus review). The other "PP" is the separate command `PP` = "Quick Plastic Pit"; do not confuse the two. The exact label code of a detention pit (C1, C99) was not traced.
3. **Works today.** CDEDIT on a detention pit: after a number-only Save "Pit updated." and then the grate and solid sides swap (BUG-561: Codex W49, C1 to C99, 10 Oct; U puts them back, REDO swaps again, so it is the Save). Edit Pit already skips the "PP" line when reading cover text (PitEditCommand.cs line 1983). The project-record refresh did not, so "PP" was saved as Text above and printed twice: "PP / PP / CL 10.250". Keep: the Edit Pit window, "Pit updated.", single Undo.
4. **What the train or PR changes.**
   1. (a) #987 head 33d4d05e, no switch. Reads the block's real angle when the stored record disagrees by more than 5 degrees; turns the block only if the window's answer is at least 45 degrees away. Opus R1: **CHANGE-NEEDED**, area plus smoke: a tank at exactly 45, 135, 225 or 315 degrees still squares to 0 on a number-only Save (found by Codex 24 Oct; unchanged). Fix needed: remember the orientation and rotation the window opened with and turn only if either changed. Also: cover text may sit off-centre on an odd-angle tank. Base is 1,703 commits behind; one block clashes with the line's `PitWasTurned` (BUG-679). **Not on a line.**
   2. (b) #1047 head 65276f4d, no switch. The record refresh skips a lone "PP" line (four lines of code). Opus BACKLOG2 R2: **KEEP**, area plus smoke. Edge: it does not check the plastic flag, so a typed "PP" on a non-plastic pit is dropped from the record. Switch: none. **Not on a line.**
5. **Suggested class: (a) Modify** (after the 45-degree fix). **(b) Modify** (small). Suggestion only.
6. **Prompts and windows.** The Edit Pit window and its Save, then "Pit updated." Nothing new. The orientation and rotation choices on the window are the ones the new rule compares (for example "Grated Left", "90 deg").
7. **Selection.** Pick the detention pit or select it first (the command accepts a pick set).
8. **Preview.** The window's preview picture. Not re-read; the new rule changes the Save decision only.
9. **Drawing output.** (a) The block's rotation is written only when the rule says a turn is wanted; same ForWrite in one transaction as before, no lock, Xref or REFEDIT bypass added (a locked-layer pit behaves as today; Opus did not check what today does). (b) Cover text is rewritten with PP once.
10. **Cancel, Escape, Undo and Redo.** Cancel closes without change. After Save, U then REDO must give the same result; (a) is meant to make one fewer change on a number-only Save. Not seen in AutoCAD.
11. **Save and reopen.** (a) Record saved with the block's real angle. (b) The "PP" case is exactly a reopen case: place plastic pit, save, reopen, change cover level. A pit already showing PP twice fixes itself at the next refresh.
12. **Assets, data and Settings.** The ProjectData pit record (orientation text, rotation text, Text above). No Settings.
13. **Performance.** No change expected.
14. **Discovery.** Ribbon "Edit Pit"; command `CDEDIT`. No What's New line for these two found (GUESS: none yet).
15. **Example drawing and expected result.** (a) Detention tank D1 at 180 degrees with the record left at defaults. CDEDIT, change D1 to D2, Save: block rotation unchanged, grate and solid chambers stay where they were. Same at 30 and at 45 degrees (an Align to pipe on a 45-degree pipe): angle kept. Real change at 0 degrees to Grated Left: tank turns 180. (b) Plastic pit PP-1: place, QSAVE, reopen, edit cover level to 10.250: text reads "PP" once above "CL 10.250".
16. **Older family card.** `docs\CARDS\UI-02_CIVIL_PIT_VISUAL_REVIEW.md` and `docs\workflows\CD_PIT_AGREED_WINDOWS_2026-09-15.md` (named only; not opened). GUESS: they describe the window layout, not what Save does to a stored detention rotation or a "PP" line.
17. **Tim's AutoCAD checklist** (after the 45-degree fix and a train):
    1. Open a copy with a detention tank D1 rotated 180. `CDEDIT`, pick D1, change the number to D2 only, Save.
    2. The grate and solid sides must stay where they were. Type `U` then `REDO`: same.
    3. Repeat with the tank at 30 degrees and at exactly 45 degrees.
    4. At 0 degrees, change the sides to Grated Left, Save: the tank should turn 180.
    5. For PP: place a plastic pit with `PP`, `QSAVE`, close, reopen, `CDEDIT`, change the cover level. The label must read PP once.
18. **Questions only Tim can answer.**
    1. Context: #987 has no switch and changes what Save does to every detention pit. Opus noted a switch (ON) would let a colleague get the old behaviour back. Recommendation: add one only if the robot finds a surprise; it is CE 01's call.
    2. Context: #1047 drops a typed lone "PP" on a pit that is not plastic. Recommendation: accept; Edit Pit already does this. On a job: a hand-typed "PP" on a normal pit would be lost at the next save.
19. **NOT proven.** Built: yes by the authors (#987: 9 tests, 5 of 11 red with the check off per its own log, not re-verified; #1047: the reviewer says no author report exists). Tested: unit only; no AutoCAD run. Installed: no. Tim-accepted: no. BUG-561 stays OPEN; the 45-degree case, the cover text position on a turned tank, and the PP reopen case have not been seen by anyone.
