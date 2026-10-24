# Pilot-critical batch 4 report (positions 34 to 47 of section C)

**Run:** Sun 25 Oct 2026, 05:40 to 07:15 Melbourne time. Team, Sonnet. Base `claude/rel-20261025o`, head `2c805a39` (Civil 3.0.75 / Manager 1.1.75), fetched at the start. Every build used `-p:SkipDevBundle=true -nr:false --disable-build-servers`. AutoCAD was not started. Nothing was marked FIXED, closed or deleted.

---

## ANSWER FIRST

1. **Five fixes pushed as draft PRs, none accepted.** Two are complete (BUG-1215, BUG-1179) and three are partial (BUG-1101, BUG-1090, BUG-1097; each says what is left). Each is built and unit-tested only. Nobody has opened any of them in AutoCAD.
2. **Eight bugs skipped** because they need Tim's engineering word, a protected file or a privacy ruling, or a Settings or window layout decision (BUG-901, 902, 903, 905, 907, 866, 1096, 1171; options below). **BUG-1173** was a document fix, done in the colleague pack page, no PR.
3. **The 14 bugs, in the order written (positions 34 to 47):** BUG-901, 907, 905, 902, 903, 1090, 1101, 1097, 1096, 866, 1215, 1179, 1171, 1173.
4. **No real fix already existed on any PR for any of the 14.** `gh pr list --search` returned only unrelated matches (the search is fuzzy); I read each title. BUG-866's neighbour #1549 changes the CDDESIGN soft-C line, not the rainfall note.

---

## PER BUG

1. **BUG-1215 (Feedback Help names a Save report step that does not exist): FIXED IN PR #1768 (draft), head `a3a472b2`.**
   - **Cause verified:** the Help line said "saving is separate from sending it" and "Save report"; the window has one button, "Send report", which saves and tries the office folder in the same call.
   - **Tests:** `FeedbackHelpWordingTests`, 3 cases, 2 fail on the base. Civil net10 full suite 20,248 total, 20,216 passed, 32 skipped, 0 failed.
   - **Switch:** none, wording only.
   - **Real-AutoCAD check:** type CDHELP, search CDFEEDBACK, open Feedback. Right looks like: it talks about Send report, the office folder and the this-PC-only fallback; no Save report.

2. **BUG-1179 (a damaged office approval file can still show "CE is current."): FIXED IN PR #1769 (draft), head `ce1f54c5`.**
   - **Cause verified:** `GetApprovedReleases` caught the bad file, left the module out, and the status fell through to "CE is current." because the office folder was reachable.
   - **What it does:** the status says "CE could not check the office approval for CE Civil Suite, so it cannot say whether it is current. You can keep drafting. Please ask the office to check the approvals file." A valid approval for another module still turns the dot amber first. Only modules installed on the PC are named. The damaged file is never touched.
   - **Tests:** `Bug1179UnreadableApprovalStatusTests`, 7 cases; they do not compile on the base. Manager net10 full suite 1,001 total, 1,000 passed, 1 skipped, 0 failed. Manager net48 build 0 errors.
   - **Switch:** none. A true sentence replaces a false one, like HUNT-M-05.
   - **Real-AutoCAD check (spare test profile, not Tim's):** put `{` into the Civil `approved.json` in the office releases folder, restart AutoCAD, wait 65 seconds, hover the CE status. Right looks like: it says CE could not check the approval for Civil. Restore the file and it says current again within a minute.

3. **BUG-1101 (CDCALC Catchments opens with a made-up catchment and a 15-minute storm): FIXED IN PART IN PR #1770 (draft), head `67e50f68`.**
   - **Cause verified:** the constructor seeded "C1, 500 m2, C 0.9" and the storm index was fixed at 15 minutes.
   - **What it does:** the tab opens with no rows (total "Unknown") and the storm starts at the office Tc and office storm return period from Settings (5 min and 1 in 5 unless changed).
   - **Switch:** `detention.catchmentsStartBlank`, ships ON (the old opening is the bug); no Settings row.
   - **Tests:** `Bug1101CatchmentsBlankStartTests`, 8 cases; they do not compile on the base. Seven older tests that built the whole CDCALC window and read row one now add that row first (said in the log and the PR). Civil net10 full suite 20,253 total, 20,221 passed, 32 skipped, 0 failed. Civil tests net48 build 0 errors.
   - **Not done, needs Tim:** the job's council storm (Glen Eira is 1 in 10) is not known when the tab opens, so the office Settings storm is used. A row added with Add still carries 500 m2 and C 0.9 (that C is BUG-544).
   - **Real-AutoCAD check:** CDCALC on a new job, Catchments. Right looks like: an empty list, total "Unknown", storm 5 min. Click Add, type 500 m2: about 11 L/s (it was 6.89 L/s at 15 minutes).

4. **BUG-1090 (nothing says the hydraulic grade line and pit losses were not checked): FIXED IN PART IN PR #1771 (draft), head `f3f38c24`.**
   - **Cause verified:** no hydraulic grade line code exists anywhere in the Civil module (grepped hgl, hydraulic grade).
   - **What it does:** CDRULES (screen and saved list) gains an "HGL Hydraulic grade line and pit losses" line in its "not evaluated here" list; the BASIS OF DESIGN block on the computations sheet ends with "Hydraulic grade line and pit losses: not calculated by CE. Each pipe is checked full-bore on its own grade only; where the council asks for a hydraulic grade line, check it separately."
   - **Switch:** none (a true sentence in a printed list).
   - **Tests:** `Bug1090HglNotCheckedTests`, 3 cases; they do not compile on the base. The two byte-for-byte golden sheets (`sheet_ari5.txt`, `sheet_ari10.txt`) gain that one line, said in the log. Civil net10 full suite 20,248 total, 20,216 passed, 32 skipped, 0 failed. Civil tests net48 build 0 errors.
   - **Not done, needs Tim:** raising it to a Warn for a council that asks for a hydraulic grade line. The council profiles hold no such value (R-00), so the line shows for every council.
   - **Real-AutoCAD check:** run CDRULES on a job with pipes and read the end of the list: an HGL line. Prepare the CDCALC computations sheet: the top block ends with the "not calculated by CE" line.

5. **BUG-1097 (the 300 mm minimum head on a charged system is never checked): FIXED IN PART IN PR #1772 (draft), head `a2fa4e3a`.**
   - **Cause verified:** the Charged System tab warned only on zero inputs and low capacity; `ChargedMinHeadMm` is read only to print the CDRULES line.
   - **What it does:** the tab warns "Available head 250 mm is under the 300 mm minimum for a charged system (R-13)." Results still show (warn, never block).
   - **Switch:** `detention.chargedMinHeadWarning`, ships ON; no Settings row.
   - **Tests:** `Bug1097ChargedMinimumHeadTests`, 7 cases; they do not compile on the base. Civil net10 full suite 20,252 total, 20,220 passed, 32 skipped, 0 failed. Civil tests net48 build 0 errors.
   - **Not done, needs Tim:** (a) the Settings box and project override (BUG-546, a Settings page layout decision); (b) the CDRULES line (R-13 still prints as not evaluated); (c) which head the rule means. This uses the typed "Available head (m)", as the audit example does, not the head left after pipe losses.
   - **Real-AutoCAD check:** CDCALC, Charged System, type 0.25 in Available head. Right looks like: a warning that the head is under 300 mm with the flow results still showing. Type 0.84 and the warning goes.

---

## SKIPPED

1. **BUG-901 (cover measured to the inside top of the pipe): SKIPPED, needs Tim's word.**
   - **Cause verified on the base:** `RulebookEngine.CoverRules` takes cover = (cover level minus invert) times 1000 minus the diameter, so it stops at the inside top (obvert). No wall thickness is held anywhere.
   - **Options:** (a) keep measuring to the inside top and say so on the CDRULES row; (b) add a wall-thickness table in Settings per material and size and measure to the outside top. **Recommend (b)**, because a concrete 375 reading 320 mm that is really 275 mm can pass a 300 mm rule it fails. It needs Tim's wall thicknesses.
2. **BUG-902 (cover checked only at the two pits): SKIPPED, needs Tim's word.**
   - **Cause verified:** the same loop checks the two ends only, against the pit cover level.
   - **Options:** (a) leave and add an Unknown note "cover between the pits not checked"; (b) sample surface levels along the pipe from the survey. **Recommend (a) first**, as (b) needs survey levels and a spacing Tim chooses.
3. **BUG-903 (screens judge one pipe against different minimum grades and covers): SKIPPED, needs Tim's word (the grade ladder).**
   - **Cause:** `MinimumCoverForChecks` already has a rulebook switch from BUG-809. The grade side still differs between the Inspector and CDRULES.
   - **Option:** make the Inspector and Hub read the CDRULES ladder. Tim must confirm the ladder values first.
4. **BUG-905 (CDCALC Boyd's tab and CDDESIGN use different hard-ground C): ALREADY BUILT ON THE BASE, switched OFF for Tim's word.**
   - **Verified:** HUNT2-C-06 added `detention.boydsUsesHardGroundC`, default OFF "until Tim confirms the figure". The window text and the carpark entry are stale about the fix's existence.
   - **Option:** Tim confirms 0.9 (or another figure), then the switch ships ON. Nothing to code.
5. **BUG-907 (pit drop where the pipe gets bigger compares inverts only): SKIPPED, needs Tim's word.**
   - **Cause verified:** `PitDropRule` compares the lowest incoming invert with the highest outgoing invert only.
   - **Options:** (a) add a warning only when the outlet top sits above the inlet top (what the carpark asks); (b) also require a drop that matches the obverts. **Recommend (a)** as a warning, but the carpark marks it "needs Tim's word (after 9 Nov)", so I did not guess.
6. **BUG-866 (CDDESIGN says the office rainfall curve reads "7 to 9 per cent high"): SKIPPED, needs Tim's word (Monday question 1).**
   - **Verified:** the sentence is still on the base and in both golden sheets.
   - **Option:** minimum fix is the wording "may be high or low by up to about 8 per cent; storage moves about 2.5 times as much". The curve values are an office Settings value. No code until Tim rules.
7. **BUG-1096 (the tank reuse credit never runs): SKIPPED, a window layout and engineering decision.**
   - **Cause verified:** only `AutoDesignOrchestrator` reads `inputs.ReuseTank` and nothing sets it.
   - **Options:** (a) add three fields to the CDDESIGN window (tank litres, connected roof, plumbed for reuse); (b) pick the tank from the CDRULES water-tank record. **Recommend (a).** Window layout is Tim's call. BUG-1098 (the Kingston credit rule) must be fixed with it, or the credit would over-credit big tanks.
8. **BUG-1171 (Civil's reports never reach Tim's admin view): SKIPPED, needs a protected file or a privacy ruling.**
   - **Cause verified:** Civil writes to `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox` (CE_SHARED `CeTelemetryStore`); Manager uploads only `%APPDATA%\CE_CADTOOLS\CE_Admin\outbox`.
   - **Options:** (a) point Civil at the CE_CADTOOLS folder: this changes CE_SHARED, which this job must not do; (b) Manager also uploads the old folder: no Shared change, but it starts sending Civil failure records, which carry drawing names, to the office folder. That is a privacy ruling (BUG-488, BUG-492), not a code call. **Recommend (a) once Tim lets Shared change on the next train.**
9. **BUG-1173 (the colleague pack's backup step saves only 2 folders): DONE AS A DOCUMENT FIX, no PR.** Page 02 of the colleague pack (a `C:\CE_PLAN` file, not in the plug-in repo) now lists all five folders in step 4 and in rollback step 5, and adds "MENULOAD, unload `CE_SUITE_MANAGER_MENU`" to the rollback. I confirmed the menu name and the three extra folders against the code on the base. The rollback rehearsal has not been done.

---

## WHAT I DID NOT TEST

1. **Nothing was opened in AutoCAD or accoreconsole.** No window, picture, status tooltip or computations sheet was looked at. Every "Real-AutoCAD check" above is untested.
2. **Manager net10 tests were run only for BUG-1179;** Civil tests only for the four Civil fixes. Structural and Installer were not run. Civil net48 was built (not run) for BUG-1101, BUG-1090 and BUG-1097; Manager net48 was built for BUG-1179. BUG-1215 (wording only) had no net48 build.
3. **"Fails on the base":** for BUG-1215 I ran the new tests on the unfixed base and 2 of 3 failed. For the other four the new tests use members that do not exist on the base, so they do not compile there. I did not build a deliberately broken variant.
4. **Machine notes:** AutoCAD was probably open during the runs (not checked). Runs went through my scratch helper `C:\ce-fx\pc4run.sh` (the CE_LOG_DIR value in the older `run.sh` made five Manager tests fail on a path-style mismatch; that is a helper fault, not a product fault). Free space stayed at 17 GB (over the 12 GB limit).
5. **Mistake first:** I deleted my own empty local branch `fb/pc4-bug1171-outbox-both-folders` (created and never committed or pushed) when I dropped BUG-1171. Nothing else was deleted, and no PR was closed.
6. **Worktrees:** five private worktrees under `C:\ce-fx` (`pc4a` to `pc4e`), each removed at the end; their five branches are pushed.
