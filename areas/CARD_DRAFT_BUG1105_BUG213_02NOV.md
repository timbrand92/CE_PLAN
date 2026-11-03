# Workflow card drafts: BUG-1105 (tank rating kept with its report, mismatch warning) and BUG-213 (Replace older schedule button)

Written Tuesday 3 November 2026 (Melbourne) by Sonnet (Team, read-only) for CE 05 / CE 00. The only file written is this one. The job file asked for the path `C:\CE_PLANreas\...`; I read that as `C:\CE_PLAN\areas\` (the backslash before "areas" was lost).
Lines read with git after `git fetch origin`: `origin/claude/rel-20261110a` (aa3b92ac, b2) for the code. I also compared the files below against `rel-20261108a` (cf059dcf, b1) and `rel-20261112a` (ccaf0783). `gh` is not on this tool path, so no PR list was read; I searched git branches and commit messages instead.

## FOR TIM

1. **Two cards follow. Both are drafts: nothing is approved, and no code exists for either.** I found no PR, branch or commit for BUG-1105 or BUG-213 (the audit says the same for BUG-1105; for BUG-213 only older "legacy cell" commits exist, not a button). Neither is on any line.
2. **Installed check:** 61fd6fbc (Civil 3.0.89) is an ancestor of b1 (cf059dcf), b2 (aa3b92ac) and the 0112a line. It is NOT an ancestor of `rel-20261102a` (3fbb9da5, 3.0.88). So the code I read is the installed behaviour plus a few later lines.
3. **BUG-213 is a real dead end in the code:** an older schedule shows "UNLINKED SCHEDULE ... deliberately re-place it", and the one button is "Update existing schedule", greyed out. No other button exists. My suggestion: a new "Replace older schedule" button that keeps the old table until you approve a preview, then replaces it in one Undo.
4. **BUG-1105 today:** CDDESIGN reads the rating report and prints "The report's STORM rating is 92". It reads each tank's litres from the report and then uses them for nothing. The tank you draw with CDWT has no link to the report. My suggestion: keep rating, report file name, date and tank litres on the job; warn when the report's litres and the drawn reuse litres differ; let you carry on with a typed reason.
5. **Questions for you: five on BUG-1105 and five on BUG-213, each with a default, inside field 18 of each card.** The two that decide the shape: for 1105, is "different" any gap or a tolerance (default 5 per cent); for 213, should Replace delete the old table or leave it on a hidden layer (default: erase it, one Undo brings it back).
6. **Open point on 1105 I could not settle:** a tank's detention share and its reuse share are different numbers. The report gives one tank size. I assume the comparison is report litres against the drawn tank's reuse litres, as the carpark says. If it should be the total tank size, say so.
7. **Read:** the carpark entries, the audit lines, the code for the report reader, the offer, CDDESIGN's offer step, the tank record and CDWT record builder, the Pit Schedule status, workflow state, view model and window file. **NOT read:** REGRESSION_LOG.md, the Codex screenshots for BUG-213, the CDWT command's prompts end to end, the project-data save code, Tim's settings (not allowed).
8. **Built: nothing. Tested: nothing. Installed: n/a. Tim-accepted: no. NOT proven:** every behaviour below marked "suggested" is a design, not something that exists. I did not open AutoCAD.

---

## CARD 1 of 2: BUG-1105 Rating report kept with its source, and a tank mismatch warning

**DRAFT FOR TIM: nothing is approved. No code, PR or branch exists.**

1. **Name and what it does for a drafter.** Rating report vs drawn tank check (BUG-1105, carpark "T2 finding 11", MEDIUM, SURE). The job remembers which rating report it relied on, and tells you when the tank you drew does not match that report.
2. **Ribbon or trigger.** Two existing commands, no new button. (a) `CDDESIGN`: the offer "Look through this job's folders for its rating report and offer the site and roof areas?" with Yes / No. (b) `CDWT` (water tank placement): where the warning would appear. I did not read the ribbon tab title.
3. **Works today.** CDDESIGN finds the latest-dated report in the job folder, prints "[CE] Read <file name>.", the site and roof figures, and the notes, one of which is "The report's STORM rating is <number>." The report's tank litres are read per row (a field `TreatmentVolumeLitres`) and only used for one nudge: a tank under 100 L ("Is that right?"). The CDWT tank record keeps library name, brand, total litres and detention litres; reuse is total minus detention and is never stored (rule T-02). Nothing links the tank to the report. Example of the gap: a report relying on a 3,000 L tank, drawn tank with 2,000 L of reuse below the outlet: passes silently. Keep: the offer is only an offer (STORM-02), the drafter chooses where figures disagree (STORM-03), a fault reading the report never stops the design.
4. **What the train or PR changes.** Nothing yet. No PR, branch or commit. The line numbers in the carpark entry (`StormReportOffer.cs:162-163`, `StormReport.cs:271-273`, `PitData.cs:272-310`, `WaterTankCommand.Apply.cs:343-357`) are from 3.0.72; the same code now sits around `StormReportOffer.cs:190`, `StormReport.cs:315`, `PitData.cs:270-310` and `WaterTankCommand.Apply.cs:331-357` on b2. On b1 the offer and CDDESIGN files differ slightly from b2 (9 and 8 lines); I did not read the difference. Not on any line.
5. **Suggested class: Modify** (adds to two working commands; the existing offer stays as it is). Suggestion only; if the job record needs a new place to live, that part is closer to Rebuild.
6. **Prompts and windows (suggested).** No new window. Command-line lines only:
   1. After the report is read in CDDESIGN: "[CE] Kept with this job: STORM rating 92, report <file name>, dated <date>, tank 3,000 L." One line per tank row.
   2. In CDWT, when a tank is placed and the job has a kept report tank size that differs: "[CE] The rating report relied on a 3,000 L tank. This tank has 2,000 L of reuse. Keep going, or type the reason this is acceptable (or Cancel):" with keywords Keep / Cancel; Keep asks for a reason on the command line.
   3. The reason line is mandatory text; an empty reason is refused and asked again.
7. **Selection.** No new selection. The tank comes from the CDWT flow already running. The report comes from the job folder search already in CDDESIGN. If the job has several tank rows in the report, the warning compares against the sum of tank rows; this is an assumption (question 3 below).
8. **Preview.** None new. CDWT already shows litres in its own callout; the warning appears before the tank is drawn so you can still cancel. I have not read the CDWT prompt order to confirm the exact point.
9. **Drawing output.** Nothing new drawn. The kept facts and any override reason live in the job record (ProjectData), not as text on the sheet. Suggested: the override reason is also written to the CDWT callout notes line or the computations sheet; Tim to decide (question 5). Locked layers, Xrefs and REFEDIT: the tank is drawn by the existing CDWT path which already respects them; the new record is written to the drawing's own job data, not to an Xref.
10. **Cancel, Escape, Undo and Redo.** Suggested: Escape or Cancel at the warning stops the tank, nothing is drawn, nothing is stored. Storing the report facts is part of the CDDESIGN step; one Undo should take back the tank and its override reason together (CDWT is one command, one Undo today per my reading of the carpark; NOT seen). Not tested.
11. **Save and reopen.** The rating, file name, date, tank litres and any reason must survive QSAVE and reopen, and survive a copy of the drawing. NOT proven; the job-data save was not read.
12. **Assets, data and Settings.** New fields on the job record: rating percent, report file name (the name only, not the full path, because client folder paths are not wanted on drawings), report date, each tank row's litres, and per tank the override reason and who/when. Suggested: a switch in Settings so the check can be turned off, defaulting ON (Tim's decisions 126 puts switches on a Switches tab; not built). Old drawings have no kept report: they must show no warning, not a false one.
13. **Performance.** Nothing heavy: a number comparison per tank. Not measured.
14. **Discovery.** The warning appears in the flow you already use (CDDESIGN, CDWT). Help page for CDWT would need one line; the page address was not checked. No What's New line exists (GUESS: none yet).
15. **Example drawings and expected results.**
    1. Job folder with a report naming a 3,000 L tank. CDDESIGN, Yes. Expect the "Kept with this job" line naming the file, date and 3,000 L.
    2. CDWT, place a tank with 2,000 L reuse. Expect the mismatch line; Keep with the reason "client chose a smaller tank"; tank drawn; reason kept.
    3. Same, answer Cancel: no tank, nothing new stored.
    4. Place a tank with 3,000 L reuse: no warning.
    5. A job with no report (reuse-only): no warning; the card does not invent one.
    6. Older drawing with no kept report: no warning, no error.
16. **Older family card.** I did not find a CDWT or CDDESIGN card in the repo's `docs\CARDS` list within this job's reading; `docs\workflows\CDWT_TANK_LIBRARY_FROM_PAST_JOBS.md` is named in the report reader as the tank source. Not read. GUESS: no older card covers a report-to-tank check.
17. **Tim's AutoCAD checklist** (copy of a drawing, after it is built and installed):
    1. Open a copy in a job folder holding a rating report that names a 3,000 L tank. Type `CDDESIGN`. Answer Yes to the report offer. Read the "Kept with this job" line.
    2. Type `CDWT`. Place a tank with 2,000 L of reuse. Read the warning. Choose Keep. Type a reason. Check the tank is drawn.
    3. Type `U` once. Check the tank is gone and the reason is not left behind.
    4. Place the tank again, choose Cancel. Nothing drawn.
    5. Place a 3,000 L reuse tank: no warning.
    6. `QSAVE`, close, reopen, `CDDESIGN` again: the kept line should still read the same.
    7. Open an older drawing with no kept report: `CDWT` gives no warning.
18. **Questions only Tim can answer.**
    1. Context: "differ" needs a rule. I understand any gap would warn on 2,990 L against 3,000 L. Recommendation: warn when the gap is more than 5 per cent of the report's litres. On a job: a 2,850 L tank against a 3,000 L report is quiet; a 2,000 L one warns.
    2. Context: what is compared. The report gives one tank size; the drawn tank has a total and a reuse share. Recommendation: report litres against drawn reuse litres, as the carpark says. On a job: a 3,000 L total tank with 1,000 L detention has 2,000 L reuse and would warn against a 3,000 L report.
    3. Context: a report with two tank rows. Recommendation: compare the sum of the report's tank rows against the sum of the tanks drawn. On a job: two 1,500 L tanks match one 3,000 L report line.
    4. Context: should a mismatch ever block a tank. Recommendation: never block, warn and ask for a typed reason, as the carpark says. On a job: you can finish the drawing, but the reason is on record for the reviewer.
    5. Context: where the reason is shown. Recommendation: in the job record and on the CDWT callout notes line only if you want it visible on the sheet; default: record only. On a job: a council reviewer will not see the reason on the plan unless you choose to put it there.
19. **NOT proven.** Built: no. Tested: no. Installed: no. Tim-accepted: no. Nobody has written code for this. The date used (file date or date printed inside the report) was not settled by me. The CDWT prompt order, the job-data save and the Undo behaviour were not read. BUG-1105 stays OPEN.

---

## CARD 2 of 2: BUG-213 Replace older schedule button in the Pit Schedule window

**DRAFT FOR TIM: nothing is approved. No code, PR or branch exists. Codex FAIL on 3.0.49, 14 Oct 2026, "same dead end still present".**

1. **Name and what it does for a drafter.** "Replace older schedule" in the Pit Schedule window (BUG-213, pilot-critical per the audit). A drawing whose pit schedule was placed by an older build can be re-placed as a linked schedule, instead of the window telling you to do it and giving no way to.
2. **Ribbon or trigger.** Command `PITSCHEDULE`, ribbon button "Pit Schedule" in the Civil Review panel (same button as the other Pit Schedule card in `CARD_DRAFTS_PIT_SCHEDULE_02NOV.md`). In the window, the last step (Place or Update, the Placement step).
3. **Works today.** On the code I read (b2), a drawing holding a schedule block with no linked source record shows the headline "UNLINKED SCHEDULE" and the text: "An older pit schedule exists without a linked source record. It is preserved; deliberately re-place it before linked status can be shown." The only large button in the last step reads "Update existing schedule" (because the window counts any placed schedule as "placed") and it is greyed out, because the status counts as a conflict. The button's tooltip shows the same sentence. There is no other control. Result: the drafter is told to re-place and cannot. Export to Excel and CSV work separately. Keep: the old schedule is never touched without an action from you (preserved on purpose).
4. **What the train or PR changes.** Nothing yet. No PR, branch or commit for a Replace button. The Pit Schedule window file (`PitScheduleDialog.xaml`) and the status and workflow code are the same on b2 as on b1 and the 0112a line except as noted: the status code on b1 is 38 lines different from b2 (I did not read why); the 0112a line changes the Schedule view model (row growth work, not this). Not on any line.
5. **Suggested class: Rebuild for the window path (a new action and its safety), Keep for everything else in the window.** Suggestion only. It is a window change plus your wording, per the Codex brief of 31 Oct.
6. **Prompts and windows (suggested).**
   1. When the status is "UNLINKED SCHEDULE", the last step shows a second button, "Replace older schedule...", enabled. "Update existing schedule" stays greyed with a plain reason beside it.
   2. Pressing it first shows a preview in the window (see field 8). Only an approve button ("Replace now") draws anything.
   3. "Replace now" asks on the command line for the insertion point, with the old schedule's corner as the default (press Enter to place the new one exactly where the old one is). That default is my suggestion.
   4. Result line: "[CE] Older schedule replaced with a linked schedule of N rows. One Ctrl+Z undoes it."
7. **Selection.** No pick of the old table. CE finds it itself (the "unlinked schedule block" it already detects). If more than one older schedule block is found, or a block is on a locked layer, in an Xref or in REFEDIT, the button explains and stays disabled (field 9).
8. **Preview.** The window's own "Review changes" view shows the full proposed schedule compared with the old one: row count, pits added, pits missing from the drawing. Nothing is erased or drawn until you press Replace now. I did not read how the window builds the old-vs-new view for an unlinked schedule; its snapshot is empty for an older table, so this needs new work.
9. **Drawing output.** One new linked schedule block and its cells; the old block and its cells removed (or kept; see question 1). Locked layer: refused, nothing changes, the line says which layer. Xref or REFEDIT: refused, the old schedule is not edited. If the old table cannot be fully read or removed (partly locked): nothing changes at all, not a half replacement. Pits that have no permanent identity get one, as the normal first placement already does (BUG-212 path, same Undo).
10. **Cancel, Escape, Undo and Redo.** Cancel or Escape at the insertion point or at the preview: nothing changes. One Undo takes back the whole replacement (old table back, new table gone). Redo must put the new table back. NOT seen in AutoCAD; the carpark's own test line asks for "one U undoes it".
11. **Save and reopen.** After QSAVE and reopen the window must show a current linked schedule (green, not UNLINKED), and Update must work. NOT proven.
12. **Assets, data and Settings.** Uses the existing schedule block and the same job record the first placement writes. Suggested: a switch (default ON) so it can be turned off if it misbehaves; this follows the rule that a new behaviour has a switch (Opus review expectations, 18 Oct). No Settings tab exists yet for it.
13. **Performance.** One placement's cost plus erasing one table. Not measured.
14. **Discovery.** It appears in the window you are already in, in the step where the dead end is. The "UNLINKED SCHEDULE" text should name the new button. No What's New line exists.
15. **Example drawings and expected results.**
    1. A copy of FIX_MODERN_PIPE_W1 (the Codex drawing that failed) with its older schedule: `PITSCHEDULE`, go to the last step. Expect "UNLINKED SCHEDULE" and an enabled "Replace older schedule...". Preview shows the pits. Replace now: new linked table, old one gone, status reads CURRENT.
    2. `U` once: old table back, status reads UNLINKED again.
    3. Same drawing with the table's layer locked: Replace stays refused, says which layer, nothing changes.
    4. A drawing with a normal linked schedule: no Replace button; Update works as today.
    5. Five live cell-update checks (the "Q3" checks Codex could not run because of this) can then run on the replaced schedule.
16. **Older family card.** `docs\CARDS\PS-01_PIT_SCHEDULES.md` and the C4 schedule cards (`C4_COMBINED_PIT_SCHEDULE_EXACT_UPDATE_2026-09-09.md`, `C4_SYSTEM_SCOPED_PIT_SCHEDULE_2026-09-10.md`). Cited from the other card's reading in this folder; I did not re-read them. GUESS: none covers re-placing an older table.
17. **Tim's AutoCAD checklist** (copy of the older drawing, after it is built and installed):
    1. Open a copy of a drawing placed by an older build. Type `PITSCHEDULE`. Go to the last step.
    2. Read the headline and text. Check "Replace older schedule..." is enabled and "Update existing schedule" is not offered as the way forward.
    3. Look at the preview. Press Cancel in the window; check nothing changed in the drawing.
    4. Open again, press Replace, accept the default corner. Compare the new table with the old one on the sheet: same position, same pits, same order.
    5. Type `U`. Check the old table is back exactly. Type `REDO`. Check the new one returns.
    6. `QSAVE`, close, reopen, `PITSCHEDULE`: status should read current.
    7. Lock the schedule's layer, try again: the button should refuse and name the layer.
18. **Questions only Tim can answer.**
    1. Context: what happens to the old table. Recommendation: erase it as part of the replacement; one Undo brings it back. On a job: no two tables stacked on top of each other. Alternative: move it to a hidden layer and keep it.
    2. Context: where the new table goes. Recommendation: the old table's corner, so a sheet layout does not change. On a job: no need to re-dimension the sheet.
    3. Context: what the button is called. Recommendation: "Replace older schedule..." (your own words in the carpark), with the window text naming it.
    4. Context: if the drawing's pits do not match the old table (the old table lists pits since deleted). Recommendation: the preview shows the differences and you still decide; never refuse just because they differ. On a job: an old table with a pit you removed is shown as "will be dropped".
    5. Context: more than one older schedule block (a continuation, or two sheets). Recommendation: refuse and say so in this first version. On a job: you replace one at a time by hand or ask us to extend it.
19. **NOT proven.** Built: no. Tested: no. Installed: no. Tim-accepted: no. I read the code that shows the dead end (status text, workflow state, the window file and the update path) but not the Codex screenshots (39 and 40, V3UX_20261014) and not how the old-vs-new preview is built for an unlinked table. Nothing on a screen has been seen by me. BUG-213 stays OPEN. The carpark's FIXED rule applies: robot PASS plus Codex PASS in real AutoCAD, or Tim's word.

---

## SKIPPED ITEMS AND WHY

1. **No PR heads and no `gh` list.** `gh` is not on this tool path. I used git branches and commit-message searches instead; none matched either bug. A PR exists only on GitHub would not show up here.
2. **BUG-1105 date and file name source.** I did not read `StormReportReader.cs` beyond a search, so I do not know whether "date" is the file's saved date or a date printed in the report. Left as an assumption in field 19.
3. **BUG-1105 CDWT prompt order and Undo grouping.** The warning point and the "one Undo" claim are not confirmed from the code.
4. **BUG-213 preview feasibility.** The status service treats an older table as having no snapshot; whether the existing difference service can compare against an empty snapshot was not read.
5. **Not read at all:** `REGRESSION_LOG.md`, `docs\CARDS`, the Help page for CDWT, the Opus pre-review files for these two bugs (none exists by name in `areas`), Tim's real settings files (not allowed), C:\CE_DrawingIntelligence (not touched).
6. **Skipped on purpose:** any decision. Every question carries a default; no default is a decision until you answer.
