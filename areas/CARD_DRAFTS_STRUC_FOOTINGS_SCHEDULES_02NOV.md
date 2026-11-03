# Card drafts 13 of 15: Structural footings and schedules (five cards)

Written Monday 2 November 2026 (Melbourne time) by Sonnet (Team, read-only) for CE 05, at CE 00's request. Latest Structural line read: `origin/claude/rel-20261026s` at 204dfad2 (after `git fetch`). Civil/Manager line: `origin/claude/rel-20261102a` at 3fbb9da5.

## FOR TIM

1. **Five cards below.** Footing register (#1893), footing sizes after Undo (#1894), pier schedule SYNC (#1886), schedule tables and Refresh (#1008 and #1011), and the subfloor "assumed" wording plus the bracing panel and BT1 trusses (#1014 and #1012).
2. **Nothing is approved.** Every card is a suggestion for you to change. Every class (Keep, Modify and so on) is only my suggestion.
3. **Could not pin down:** the exact ribbon flyout for THC (its registry group is blank, so I read it as the "Annotate" panel but did not see it on screen), whether Refresh Schedule shows for everyone (it is marked "expert"), and the exact wording of the footing refusal line on the Structural line (I read it from the PR text, because the fix is not on that line yet).
4. **Questions that need you:** one on each of cards 1, 2, 3 and 4, and three on card 5. The big one is card 5: should roof trusses (BT1) count in the wall bracing total? It is your engineering call and nobody has ruled.
5. **A change from the older cards:** the older family cards (ST-02, ST-04, ST-06, ST-07) say STRSCHEDCREATE and STRSCHEDSYNC are to be rebuilt later. These cards cover only the small fixes on the live commands and do not replace that bigger plan.
6. **Read:** the two Opus pre-reviews (BACKLOG2 R1, BACKLOG R5), the BACKLOG R7 review for #1008, the carpark entries for all seven bugs, the build register, the Structural code on the line (footing register, size library, schedule service, subfloor service, bracing calculator, ribbon and command files) and the older family cards.
7. **NOT proven:** all seven PRs are built and unit-tested by their authors only. I built nothing and ran nothing. Nobody has installed them or opened any of them in AutoCAD, and you have accepted none. I could not run `gh` here, so the PR open/draft state is taken from the Opus reviews of 1 and 2 November.
8. **Two PRs (#1893, #1894) are on the Civil line** and must be copied across as single changes, never merged. #1893 also needs a re-write because the Structural line rebuilt that code.

---

# CARD 1: Footing register, a damaged register is kept, never saved over

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Footing register kept when damaged. If the list of footings stored in the drawing cannot be read, CE keeps it exactly as it is and stops saving over it. Today the next footing you place wipes the other 40 out of the footing schedule without a word.
2. **Ribbon or trigger.** Not a button of its own. It sits under every footing command that saves to the register: THC (registry label "Slab Thickening Outline and Tag"), FTHC, FPFC ("Footing", large button in tab **CE Structural**, panel **Columns & Footings**) and the others. Tab title read from `CeStrucRibbonContributor.cs`: "CE Structural". A second file, `RibbonCommandHubService.cs`, says "CE STRUC": GUESS that "CE Structural" is the live one; I did not see the ribbon.
3. **Works today.** Placing footings with THC, PFC and the like records each one in a register stored in the drawing. The footing schedule is built from that register. On the Structural line the register is held in memory per drawing and forgotten after U, REDO and MREDO (`FoundationRegistryService.cs`, `Memory.Load`, `ForgetAfterCommand`). The fix would protect all of that.
4. **What the train or PR changes.** PR #1893 (BUG-1136, head 4bfdbf62, base `claude/rel-20261102a`, draft). Switch `Options.KeepDamagedFootingRegister`, default ON (read from the PR and Opus review; I did not open the PR's Settings file on the Structural line, where the switch does not exist yet). OFF gives the old overwrite behaviour. **It is on the Civil line and cannot be merged into the Structural line.** It conflicts with the Structural line's rewrite of `FoundationRegistryService.Load` and `Invalidate`. Opus verdict: CHANGE-NEEDED, Structural FULL. It must be copied across as a single change and re-written onto the Structural line's `FoundationRegistryMemory`.
5. **Suggested class: Modify.** The footing commands stay. The register read and save get safer. Suggestion only.
6. **Prompts and windows.** No new window and no question. One plain line at the command line, from the PR text: "[FOUNDATION] The footing register in this drawing could not be read, so it was left exactly as it is. This footing change was NOT saved to the register." Opus asks that the line say what to do next (for example "send the Recovery file to CE support"), because there is no repair route yet (BUG-1154 is the related cause).
7. **Selection.** None added.
8. **Preview.** None. Nothing changes on screen.
9. **Drawing output.** The footing is still drawn. Only the register write is refused, so footing 41 appears on screen but is not in the register or the schedule until the register is repaired. The stored register is left byte for byte as it was. No layer, Xref, REFEDIT or locked-layer path is changed by the PR (Opus read). **Hazard Opus flagged, not traced:** with the register marked damaged, a read returns an empty register, so a footing schedule rebuilt in the same command could come out with no rows. That would change the drawing even though the save is refused.
10. **Cancel, Escape, Undo and Redo.** The copy of the damaged text goes to a file outside the drawing, so U and REDO are unaffected. The re-write must not clear the "damaged" mark on U or REDO, or every U would print the line again and write another Recovery file. Opus says clear it only on drawing close and on Invalidate.
11. **Save and reopen.** The stored register is untouched, so it is still damaged after save and reopen, and the line prints again once per session.
12. **Assets, data and Settings.** Writes a text file to `%APPDATA%\CE_STRUC_SUITE\Recovery\FootingRegister_DAMAGED_<drawing>_<time>.txt` (PR head `FoundationRegistryService.cs`). Reads the register stored in the drawing. Settings: `Options.KeepDamagedFootingRegister`.
13. **Performance.** One extra read check per footing command. GUESS: not noticeable. Opus counted 17 places that save the register (14 in `FoundationService.cs`, one each in `.Grips`, `.LoadPath`, `.Marks`) and warns one footing command could print the refusal line several times, so the re-write should print it once per command.
14. **Discovery.** None today. No Help page found for this. GUESS: the one command-line line is the only way a drafter learns of it.
15. **Example drawing and expected result.** A slab plan with 40 pad footings and a damaged register. Place footing 41 with THC. **Today:** footings 1 to 40 drop out of the footing schedule, no message. **Right:** one line, a file in the Recovery folder, the register text identical before and after, and the schedule still showing 40.
16. **Older family card.** `docs\CARDS\ST-06_FOUNDATIONS_REBAR.md` (rows THC and PFC "Rebuild preview and compound behaviour", FST "Keep and improve"). It says nothing about a damaged register, a Recovery file or refusing to save. It also pre-dates the Structural line's rewrite of the register code.
17. **Tim's AutoCAD checklist.** (Robot and Codex do the damaging, per Opus; this is what you would check.)
    1. Open a copy of a drawing with 3 pad footings and a placed footing schedule.
    2. After CE staff have damaged the register in the copy, save, close and reopen it.
    3. Type THC and place a fourth footing. **You should see** one "could not be read ... NOT saved to the register" line and the footing drawn.
    4. Open the Recovery folder named above. **You should see** one `FootingRegister_DAMAGED_...txt` file.
    5. Look at the footing schedule. **You should see** the same 3 rows as before, not an empty table.
    6. Type U, then REDO. **You should see** no second warning and no second file.
18. **Questions only Tim can answer.**
    1. **Context:** the repair route. **I understand:** there is none yet, so a damaged register stays damaged and new footings never reach the schedule. **Recommendation:** accept it for the pilot and make the line say who to send the file to, because the protection is the point. **On a job:** yes means a drafter keeps drawing but must chase the schedule by hand; no (block the footing command) would stop work, which RULES R-27 avoids.
    2. **Context:** where this ships. **I understand:** it is a Structural FULL change, so it touches every footing command. **Recommendation:** put it in the Structural FULL train after the re-write and the robot check of the empty-schedule hazard. **On a job:** this is the only item here that could change every footing job, so it should not go in as a quick fix.
19. **NOT proven.**
    1. **Built:** yes on the Civil line, by the author (focused tests only). Not built on the Structural line, because it has not been re-written there.
    2. **Tested:** 12 pure tests per Opus (parse, damaged versus nothing stored, refusal rule, copy-aside file name). Nothing tests the real Load and Save in a drawing. Not tested on the Structural line.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Nobody has opened this in AutoCAD, so no Codex-accepted either. BUG-1136 stays OPEN.

---

# CARD 2: Footing sizes removed by Undo are forgotten

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Footing size library follows Undo. When you undo a thickening, its size is no longer remembered or quietly saved back later.
2. **Ribbon or trigger.** THCL, registry label "Slab Thickening Outline and Tag", group Structural, subgroup "Text Tags". By the ribbon code that puts it on tab **CE Structural**, panel **Annotate**, flyout "Beam & Support Tags" (read from `CeStrucRibbonContributor.cs`, not seen on screen). Also typed. The toolbar layout lists THCL under "Footings" with Tim's note about colour, layer and text height. THC and the other THC-type footing commands read the same library.
3. **Works today.** THCL asks for sizes ("Enter X size (width): " then "Enter Y size (height) <same as X>: ") and saves each under a key such as 81 so the next use of 81 does not ask. The library is read once per drawing and kept in memory (`GetFstData`, `CeTextService.cs`, about line 5544 on the line).
4. **What the train or PR changes.** PR #1894 (BUG-1199, head 0224c2e2, base `claude/rel-20261102a`, draft). Switch `Options.FootingSizesReadFromDrawing`, default ON (from the PR and Opus). ON: every lookup reads the library from the drawing and the memory is never filled. OFF: the old memory logic exactly. It is on the Civil line, so it **must be copied across as a single change, never merged**. Opus found it drops onto the Structural line cleanly in `CeTextService.cs`, with `UserSettings.cs` and `REGRESSION_LOG.md` needing keep-both.
5. **Suggested class: Modify.** Same command and same prompts, with a safer memory behind them.
6. **Prompts and windows.** No change. After the fix, a key whose size was undone asks for the X size again.
7. **Selection.** None added.
8. **Preview.** None added.
9. **Drawing output.** No change to what is drawn. The size library inside the drawing is the only thing that changes. The PR touches no layer, Xref, REFEDIT or locked-layer path (Opus read).
10. **Cancel, Escape, Undo and Redo.** This is the Undo fix. Opus read the two places the library is used on the line (`TryGetOrPromptRectSize`, `TryGetOrPromptSfWidth`, both inside a footing-text command) and found no read during U or REDO, so REDO is not thrown away. Separate bug BUG-1200 (Escape at the centre prompt still leaves a saved size) is NOT covered by this PR.
11. **Save and reopen.** The library is stored in the drawing, so it is the same after save and reopen. Only entries you actually accepted should be in it.
12. **Assets, data and Settings.** Reads and writes the footing size library stored in the drawing (`FstMemoryService`). Setting: `Options.FootingSizesReadFromDrawing`.
13. **Performance.** The drawing is read on every lookup instead of once. GUESS: not noticeable for a normal drawing.
14. **Discovery.** None. No Help page read. The change is invisible apart from Undo behaving.
15. **Example drawing and expected result.** Fresh drawing: THCL key 81 at 600 x 600, centre 0,0. Type U. THCL key 82 at 900 x 900, centre 2000,0. **Today:** the library holds 81 and 82, and typing 81 again silently reuses 600 x 600. **Right:** only 82 is stored, and 81 asks for its size again. A 600 x 600 thickening you removed no longer comes back on a later job.
16. **Older family card.** `docs\CARDS\ST-04_TEXT_PLACEMENT.md` (THCL is mapped to it in `COMMAND_TO_CARD_COVERAGE.md`) and `ST-06_FOUNDATIONS_REBAR.md` (FST "Keep and improve"). Neither mentions Undo or a size library kept in memory.
17. **Tim's AutoCAD checklist.**
    1. Start a new blank drawing. Type THCL, key 81, 600 then 600, centre 0,0 and place the text.
    2. Type U. **You should see** the thickening removed.
    3. Type THCL, key 82, 900 then 900, centre 2000,0.
    4. Type THCL and key 81 again. **You should see** CE ask "Enter X size (width):" again. It must not reuse 600.
    5. Type U then REDO once. **You should see** nothing odd.
18. **Questions only Tim can answer.**
    1. **Context:** Opus notes a size library that fails to read comes back empty, and the next save writes "empty plus the new size", which would erase the others. **I understand:** it is the same class as BUG-1136, so this fix makes it a little more likely to show. **Recommendation:** ship it with one log line about this and do the Footing register fix (card 1) first or alongside. **On a job:** otherwise a read failure mid-job could wipe a library of sizes.
19. **NOT proven.**
    1. **Built:** yes on the Civil line (author). Not built on the Structural line.
    2. **Tested:** 4 pure tests per Opus, including one that the old fault is reproduced with the switch OFF. No real Undo tested. The switch is not yet checked through the real settings reader.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Nobody has opened it in AutoCAD. BUG-1199 stays OPEN.

---

# CARD 3: Pier schedule SYNC checks which pier each row is

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** STRSCHEDSYNC on the Bored Pier Schedule. If you reorder the rows of the table (to read in grid order, say), the piers on the plan keep their own sizes instead of swapping diameters.
2. **Ribbon or trigger.** Tab **CE Structural**, panel **Schedules**, flyout "Structural Schedules", button **Synchronise Schedule**, command STRSCHEDSYNC (registry label and `ribbon` code read; not seen on screen). Tim's own toolbar notes on STRSCHEDCREATE, REFRESH and SYNC in the layout file say "REMOVE IF NOT NEEDED".
3. **Works today.** Select the table ("Select schedule table to sync: ", reject message "Select a Table."), and edited cells are written back to the objects. On the Structural line the Bored Pier sync reads its own saved row record first and falls back to the HANDLE column if the table was edited by hand (`ScheduleRowLink.HandleForRow`, `ScheduleService.cs` about line 777). It checks only that the row count matches.
4. **What the train or PR changes.** PR #1886 (BUG-1183, head bb822e60, base `claude/rel-20261026s`, draft, one commit, 0 behind the tip). Switch `ScheduleSet.PierSyncChecksRowIdentity`, default ON, checked through the real settings reader on both paths (Opus read). OFF: the old row handling exactly. It is on the Structural line already and Opus' merge simulation was clean.
5. **Suggested class: Modify.** Opus verdict KEEP-WITH-NOTE. Note that `ST-07` says STRSCHEDSYNC "pushes edited table values back into objects" and is a potential engineering-write risk to be rebuilt. This PR only makes the existing behaviour safer and does not replace that plan.
6. **Prompts and windows.** Same prompt as today. With a HANDLE column: if a handle on a row is unknown, or shown on two rows, CE leaves those rows alone and prints a plain line (exact wording not read). Without a HANDLE column, a swap is recognised only when the set of rows is exactly the drawing's piers in a different order.
7. **Selection.** Pick one schedule table. No change.
8. **Preview.** None, same as today.
9. **Drawing output.** Writes the same pier size property (Visibility1) in the same transaction as before. Nothing new is drawn. A pier on a locked layer behaves exactly as today (Opus: the write was already there, and a raw AutoCAD error word on a locked layer is the separate BUG-503 item). No Xref or REFEDIT path changed. The PR also runs a read of the drawing's piers (`ProjectDataService.ScanFromDrawing`), the same call Refresh already makes.
10. **Cancel, Escape, Undo and Redo.** Escape at the pick does nothing. One U undoes the sync write. REDO is spent by the sync's own write as before.
11. **Save and reopen.** The row record is saved with the drawing as it is today.
12. **Assets, data and Settings.** Reads the table, the saved row record and the model-space piers. Setting: `ScheduleSet.PierSyncChecksRowIdentity`. The match without a HANDLE column relies on the table's DIA MM text equalling `FormatPierDiameter` and the VISIBILITY text equalling the pier's own, both written by the same code when the table is made.
13. **Performance.** One extra scan of model space only when the table has no HANDLE column. GUESS: not noticeable.
14. **Discovery.** Ribbon flyout button and typing the command. No Help page read.
15. **Example drawing and expected result.** Bored pier 300 at 0,0 and 600 at 3000,0. STRSCHEDCREATE, then STRSCHEDREFRESH, then swap data rows 2 and 3, then STRSCHEDSYNC. **Today:** the 300 pier and the 600 pier swap diameters on the plan. **Right:** the 300 stays 300 and the 600 stays 600. **Known gap:** with no HANDLE column, if you swap rows AND edit a value in the same go, CE writes by row position as it does today.
16. **Older family card.** `docs\CARDS\ST-07_SCHEDULES_SHEETS_EXCEL.md` (STRSCHEDSYNC "Potential engineering-write risk: rebuild"). It does not say anything about row identity or swapped rows.
17. **Tim's AutoCAD checklist.**
    1. Type BP and place a 300 pier at 0,0 and a 600 pier at 3000,0.
    2. Type STRSCHEDCREATE and pick a point for the tables. Type STRSCHEDREFRESH and pick the Bored Pier Schedule.
    3. Swap the second and third rows of the table (CE staff supply the swap script; the robot does this).
    4. Type STRSCHEDSYNC and pick the table. **You should see** a line saying CE matched each row by its HANDLE.
    5. Select each pier and read its size. **You should see** the 300 is still 300 and the 600 is still 600.
    6. Change one row's 600 to 300 without moving rows and sync. **You should see** that pier change to 300.
18. **Questions only Tim can answer.**
    1. **Context:** the swap-and-edit gap. **I understand:** if a table has no HANDLE column and you swap rows and also edit a value, CE writes by position (today's behaviour). **Recommendation:** accept the gap, keep it written in the bug entry, and keep the HANDLE column on by default. **On a job:** a drafter who swaps and edits in one go could still resize the wrong pier, so this is only safe if the HANDLE column stays visible.
19. **NOT proven.**
    1. **Built:** yes, by the author, on the Structural line.
    2. **Tested:** 17 pure tests per Opus, including the RD14-01 swap with and without a HANDLE column. The real table write is not tested.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Nobody has opened it in AutoCAD. BUG-1183 stays OPEN.

---

# CARD 4: Schedule tables the right size (STRSCHEDCREATE) and Refresh blanks erased rows (STRSCHEDREFRESH)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** The schedules you create with STRSCHEDCREATE get a row for every brace, bored pier and tie-down, and STRSCHEDREFRESH no longer leaves an erased brace or pier on the schedule. Without it a schedule can list a brace that is gone, which overstates bracing.
2. **Ribbon or trigger.** Tab **CE Structural**, panel **Schedules**, flyout "Structural Schedules". Buttons **Create Schedule** (STRSCHEDCREATE) and **Refresh Schedule** (STRSCHEDREFRESH). Refresh Schedule is marked "expert" in the registry, so it may not show for everyone: GUESS, not seen on screen. Tim's layout notes say "REMOVE IF NOT NEEDED" on both.
3. **Works today.** STRSCHEDCREATE asks "Select insertion point for schedules: ", then places up to three tables (bracing, bored pier, tie-down). The line already has a Settings option to update tables already on the drawing on a rerun (`UpdateExistingOnRerun`). STRSCHEDREFRESH asks "Select schedule table: " (reject message "Select a Table.") and rewrites the rows from the drawing. The tie-down refresh already blanks leftover rows (`UpdateTieDownTable`, `ScheduleService.cs` about line 630).
4. **What the train or PR changes.**
    1. **#1008** (BUG-497, head d30d5a0f, base `claude/rel-20261009t`, draft, 295 commits behind the Structural tip). Each table gets a title row, a heading row and one row per item (`TableRowCount(items) = items + 2`). No Settings switch (Opus: turning it off would only bring the error back). On the Structural line the sizing is still "Count + 1" at `ScheduleService.cs` lines 384, 422 and 572, which I read. Conflict with the line: `REGRESSION_LOG.md` only.
    2. **#1011** (BUG-498, head ba61da8b, same base, draft). After Refresh rewrites bracing or bored pier rows, every row below them is blanked, as the tie-down schedule already does. No switch. On the Structural line the bracing and pier refresh do not blank leftover rows (I read `ScheduleService.cs`: only the tie-down update has the blanking loop). Conflict with the line: the change log and two code pieces added side by side in `ScheduleService.cs` (keep both, Opus).
    3. Both need a cherry-pick onto the Structural line. Opus order: #1011 first, then #1008, but the code joins either way.
5. **Suggested class: Modify** for both (Opus: #1008 KEEP, #1011 KEEP-WITH-NOTE). Suggestion only. The ST-07 plan to merge STRSCHEDCREATE into one schedule authority is not touched.
6. **Prompts and windows.** No change to prompts. No new window.
7. **Selection.** Create: one insertion point. Refresh: pick one table. No change.
8. **Preview.** None, same as today.
9. **Drawing output.** Create: tables with title, heading and one row per item. Refresh: filled rows for what is on the plan and blank rows under them, so the table is not shortened. Nothing is drawn on the plan itself. Blank rows have a blank handle, so Sync skips them, and nothing is written back to the drawing from a blank row (Opus read). **Existing weakness, not from these PRs:** Refresh opens the table for writing with no locked-layer check, so a schedule on a locked layer fails with AutoCAD's own error, not a plain CE line (Opus).
10. **Cancel, Escape, Undo and Redo.** Escape at the pick does nothing. One U removes the created tables, as today. Refresh is one write. REDO behaviour not changed by either PR (Opus read).
11. **Save and reopen.** Tables and the saved row record are stored in the drawing. A blank row stays blank after reopen.
12. **Assets, data and Settings.** Reads the drawing's braces, bored piers and tie-downs. Writes AutoCAD table objects. Both PRs add no Settings value.
13. **Performance.** No change worth noting.
14. **Discovery.** Ribbon flyout and typing the command. No Help page read.
15. **Example drawing and expected result.**
    1. **#1008:** blank millimetre drawing, one AB brace, one bored pier and one tie-down, then STRSCHEDCREATE. **Right:** three tables, each with a title, a heading and the one item, and no error on the command line. Opus says what happens today is "my reading, not seen": an AutoCAD error with no tables, or a missing last row.
    2. **#1011:** four AB braces, STRSCHEDCREATE, erase one, STRSCHEDREFRESH and pick the bracing table. **Today:** it still lists four braces. **Right:** three filled rows and one blank row. Repeat with four bored piers, including the 3-column pier table (the Settings switch for a table without Layer and Handle). Then STRSCHEDSYNC: no brace or pier changes.
16. **Older family card.** `docs\CARDS\ST-07_SCHEDULES_SHEETS_EXCEL.md` (STRSCHEDCREATE "Merge into one schedule authority", STRSCHEDREFRESH "Keep with preview/staleness"). It says nothing about the table being one row short or about leftover rows.
17. **Tim's AutoCAD checklist.**
    1. New blank millimetre drawing. Draw one AB brace, one bored pier (BP) and one tie-down.
    2. Type STRSCHEDCREATE, pick a point. **You should see** three tables, each with a title, a heading and one data row, and no error.
    3. Type U. **You should see** all three tables removed.
    4. Draw four AB braces, run STRSCHEDCREATE and pick a point. Erase one brace.
    5. Type STRSCHEDREFRESH and pick the bracing table. **You should see** three filled rows and one blank row.
    6. Type STRSCHEDSYNC and pick the table. **You should see** no brace change.
18. **Questions only Tim can answer.**
    1. **Context:** a blank row left at the bottom of a refreshed table. **I understand:** the bug's own smallest fix leaves a blank row rather than shortening the table, matching what tie-downs already do. **Recommendation:** accept the blank row for now, because it matches the existing schedule and is safest. **On a job:** a printed schedule shows an empty row at the bottom after a brace is erased. Shortening the table is a bigger change.
19. **NOT proven.**
    1. **Built:** yes, by the authors, on the old base (9 October). Not built on the Structural line.
    2. **Tested:** #1008 has 4 checks (row arithmetic and a text check that no "Count + 1" sizing is left). #1011 has 3 checks. Neither proves a real table is right. The author's "445 schedule tests pass" for #1008 was not confirmed by Opus.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Nobody has opened either in AutoCAD, and the carpark itself says BUG-497 was "found by reading code; not seen in AutoCAD yet". BUG-497 and BUG-498 stay OPEN.

---

# CARD 5: Subfloor questions say "assumed" (CSSUBFLOORGRID) and the bracing panel leaves BT1 trusses out (CSBRACINGPANEL)

**DRAFT FOR TIM: nothing is approved. Part B needs Tim's word before anyone builds it.**

## Part A: CSSUBFLOORGRID says "assumed" (PR #1014, BUG-502)

1. **Name, and what it does for a drafter.** The CSSUBFLOORGRID questions say the starter bearer and stump figures are assumed, so nobody mistakes them for checked sizes.
2. **Ribbon or trigger.** Typed only. The command is marked hidden and expert in the registry (label "Propose Bearer/Stump-Pier Grid", subgroup "Timber subfloor"), so there is no ribbon button.
3. **Works today.** Pick a closed floor outline and the joist direction. CE then asks "Bearer spacing (mm)", "Max stump/pier spacing (mm)", "Bearer size/species" and "Stump/pier size", then "Apply this bearer/stump-pier grid? [Yes/No]". Enter at each gives 3000 and 1800 spacing, 150x50 F17 bearers and 90x90 stumps, drawn on layers BEARERS - SUBFLOOR and STUMPS AND PIERS. The registry notes say the span-table values are assumed and "Tim to confirm before use on a real job".
4. **What the train or PR changes.** PR #1014 (head aca6a37c, base `claude/rel-20261009t`, draft). The prompts say "(assumed starter figure)" for spacings and "(assumed starter size, not checked)" for sizes. New switch `TimberSubfloor.OfferStarterSizes`, default ON, which keeps today's sizes. OFF gives no size default and Enter reads "Unknown". Opus: the code cherry-picks onto the Structural line cleanly; the change log needs keep-both. Opus note: OFF is not byte for byte the old behaviour, because a blank configured size now offers "Unknown".
5. **Suggested class: Modify.** Wording change by default. Suggestion only.
6. **Prompts and windows.** Example from Opus: "Bearer size/species (assumed starter size, not checked)". Enter still gives 150x50 F17. No new window.
7. **Selection.** Unchanged: the floor outline and two direction points.
8. **Preview.** Unchanged. The registry says a preview with mark counts shows before Apply.
9. **Drawing output.** Unchanged by default. With the switch OFF the bearer tag reads "Unknown" instead of 150x50 F17. No layer, Xref, REFEDIT or locked-layer path changes (Opus).
10. **Cancel, Escape, Undo and Redo.** Unchanged. One U after Apply.
11. **Save and reopen.** Unchanged. Tags are ordinary drawing text.
12. **Assets, data and Settings.** Reads the Timber subfloor Settings (spacings and default sizes, edited by CSSUBFLOORSET). The starter span table is assumed, not AS 1684.2 verified. Switch: `TimberSubfloor.OfferStarterSizes`.
13. **Performance.** No change.
14. **Discovery.** Command line only. Not on the ribbon.
15. **Example drawing and expected result.** A 10 m x 8 m closed polyline, joists one way, Enter at every question, then Yes. **Right:** every size question says "assumed", the bearers still read 150x50 F17. With `OfferStarterSizes` OFF (set before AutoCAD starts) the bearer tag reads "Unknown".
16. **Older family card.** None found. I searched `docs\CARDS` for "subfloor" and found nothing. (`ST-02_SUPPORTS_BRACING_JOISTS.md` is the nearest, for joists.) So the command has no family card at all.
17. **Tim's AutoCAD checklist.**
    1. Draw a 10 m x 8 m closed polyline. Type CSSUBFLOORGRID, pick it, then pick two points for the joist direction.
    2. **You should see** each size question carry "assumed".
    3. Press Enter at every question, then type Yes. **You should see** bearers tagged 150x50 F17.
    4. Type U. **You should see** the whole grid removed.
18. **Questions only Tim can answer.**
    1. **Context:** the carpark wants "no size default unless Tim has set one". **I understand:** the PR keeps today's sizes as the default (following INT-073) and only offers the no-default choice as a switch. **Recommendation:** keep it as built (wording only) until you give the office's real figures. **On a job:** with the default, an unchecked 150x50 F17 can still land on a plan; with the switch off, the tag says Unknown and the drafter must type a size.

## Part B: CSBRACINGPANEL leaves BT1 roof trusses out of the wall totals (PR #1012, BUG-499)

1. **Name, and what it does for a drafter.** The Bracing Panel shows wall bracing provided against required, and would no longer add roof bracing trusses (BT1) into that wall total.
2. **Ribbon or trigger.** Tab **CE Structural**, panel **Rebar & Bracing**, flyout "Bracing", button **Bracing Panel** (CSBRACINGPANEL, subgroup Bracing, not hidden). Read from the registry and ribbon code, not seen on screen.
3. **Works today.** Opens a small always-on-top panel that totals bracing length per direction (North-South, East-West) from braces already placed and shows it against the required length set with CSBRACINGREQUIRED (prompts "Required North-South bracing (mm)" and "Required East-West bracing (mm)"). It reads and draws nothing. On the Structural line a direction with mixed brace types shows "unknown" instead of a green tick (BUG-950, switch `Bracing.UnknownWhenTypesDiffer`, ON). The total still includes BT trusses. Codex saw this on 14 October: one 2700 mm BT9 placed by BT1 and no wall braces showed East-West 2700, North-South 0.
4. **What the train or PR changes.** PR #1012 (head 597439fb, base `claude/rel-20261009t`, draft). It skips any brace whose type starts with "BT" in the total. Switch `Bracing.PanelCountsRoofTrusses`, default false (the new behaviour); true restores the old sum. **Opus verdict: CHANGE-NEEDED, and it needs Tim's word first.** It also clashes in code with BUG-950 (`BracingPanelCalculator.Summarise` and `BracingPanelService.BuildSnapshot`), so it must be re-written on the Structural line with the BT instances skipped before the per-direction type list is built (otherwise a BT truss alone makes a direction "unknown"), and the two bool arguments passed by name.
5. **Suggested class: Modify, on hold.** Do not build until Tim answers question 2 below.
6. **Prompts and windows.** No new prompt. The panel's numbers change. The PR defers a "no type" line, which Opus says needs a Codex look at the window.
7. **Selection.** None. It reads every brace block in the drawing.
8. **Preview.** It is a live panel.
9. **Drawing output.** None. The panel draws nothing and writes nothing. It uses the open-close scan so REDO is kept (Opus).
10. **Cancel, Escape, Undo and Redo.** Nothing to undo. REDO is kept.
11. **Save and reopen.** Nothing saved by the panel. The required-bracing figures are saved by CSBRACINGREQUIRED in the PC-wide settings file (a separate open bug, BUG-500).
12. **Assets, data and Settings.** Reads BRACING blocks and their type tags. Switch `Bracing.PanelCountsRoofTrusses`.
13. **Performance.** No change.
14. **Discovery.** Ribbon flyout button and typing the command. No Help page read.
15. **Example drawing and expected result.** Required North-South 5000 (CSBRACINGREQUIRED). One 2700 AB north-south and one 4000 BT1 north-south. **Today:** 6700 provided, so the panel looks fine. **After (if Tim agrees):** 2700 provided and a cross. A second case: BT1 only and no wall braces should read 0 and a cross, not a green tick.
16. **Older family card.** `docs\CARDS\ST-02_SUPPORTS_BRACING_JOISTS.md` (BT1 "Useful; less proven than AB/BB"). It says nothing about the bracing panel or whether BT1 counts in a wall total. No separate family card for CSBRACINGPANEL was found.
17. **Tim's AutoCAD checklist** (only after Tim answers question 2 and the change is re-written).
    1. Type CSBRACINGREQUIRED, North-South 5000, East-West skipped (Enter).
    2. Place one 2700 mm AB brace north-south, then one 4000 mm BT1 truss north-south.
    3. Type CSBRACINGPANEL. **You should see** North-South provided 2700 against 5000 required, with a cross.
    4. Erase the AB brace. **You should see** North-South 0 with a cross, not a tick.
18. **Questions only Tim can answer.**
    1. **Context:** the subfloor "assumed" wording (Part A). **I understand:** wording only by default. **Recommendation:** approve the wording. **On a job:** drafters see that the 150x50 F17 and 90x90 are a starter guess.
    2. **Context:** should BT1 roof bracing trusses count in the wall bracing total? **I understand:** the carpark and Codex's 14 October note leave this as your engineering decision, and I found no ruling. **Recommendation (Opus):** leave BT out, because roof bracing trusses are not wall bracing under AS 1684.2, so counting them overstates wall capacity. **On a job:** if BT counts, 2700 of wall bracing plus a 4000 truss reads 6700 and may show a pass it should not. If BT is out, the panel reads 2700 and shows the real shortfall.
    3. **Context:** a switch (`PanelCountsRoofTrusses`) so either answer can be set. **I understand:** default false means trusses are out. **Recommendation:** keep the switch and set the default to your answer to question 2. **On a job:** if you rule the other way, the default flips and nothing else changes.
19. **NOT proven.**
    1. **Built:** yes, by the authors, on the old 9 October base. Neither part is built on the Structural line. Part B needs a re-write there first.
    2. **Tested:** Part A has 5 pure tests (default, size default three ways, a source check of the four prompt texts). Part B has 2 calculator tests and 2 Structural tests, none checking the real settings reader at start-up. Neither was tested in a drawing.
    3. **Installed:** no.
    4. **Tim-accepted:** no. Nobody has opened either in AutoCAD. BUG-502 and BUG-499 stay OPEN. BUG-499 needs your engineering word on top.

---

## What I read and did not do

1. **Read:** RULES.md, the Opus pre-reviews `OPUS_PREREVIEW_BACKLOG2_R1_02NOV.md`, `OPUS_PREREVIEW_BACKLOG_R5_01NOV.md` and `OPUS_PREREVIEW_BACKLOG_R7_01NOV.md`, the carpark entries for BUG-1136, 1199, 1183, 497, 498, 499 and 502, build register entries 117 and 118, the older family cards ST-02, ST-06, ST-07 and the coverage list, and on `origin/claude/rel-20261026s` the command registry, toolbar layout, Structural ribbon code, footing register, size library, schedule service, subfloor service and bracing calculator. I also read the #1893 commit text.
2. **Not done:** I built nothing, ran no test, opened no AutoCAD, ran no robot, and did not read Tim's real settings files. I did not open the #1894, #1886, #1008, #1011, #1012 or #1014 diffs myself: their details come from the Opus reviews, so any Opus mistake would carry into these cards. `gh` was not available in this shell, so PR open or draft state is from those reviews.
3. **Guesses marked:** the live tab title ("CE Structural" or "CE STRUC"), the THC flyout, whether Refresh Schedule shows for everyone, and the performance remarks.
