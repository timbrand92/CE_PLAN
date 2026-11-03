# Robot case drafts, set 07: X-Civil import and Xref fixes (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** The desk asked for up to five robot cases, each with a broken twin, for PRs #1982, #1987, #1926, #1925, #1937, #1941 and #1942 (heading for `origin/claude/rel-20261102a`). **No case could honestly be drafted.** Every one of them needs something the robot is not allowed to do or cannot reach. This file says why, fix by fix, and gives a Codex look for each. Nothing was built, run or opened in AutoCAD. The only file written is this one. No git write.

---

## FOR TIM

1. **Cases and twins drafted: none (0 of 0).** Writing a case that can only come back BLOCKED would have been noise. Each fix below is marked BLOCKED-FOR-ROBOT with one line of why.
2. **Codex-only: all six fixes** (seven PRs). Codex notes K7_01 to K7_06 are written below with exact steps.
3. **Why, in drawing words.** The X-Civil import starts from a Windows "pick a file" box, and the robot cannot drive that box. The two Xref fixes need two Xrefs made by Save As and a placed Pit Schedule. The robot cannot make a second drawing and cannot press "Continue to Place".
4. **Needs an Opus review before it is run (touches an Xref or a locked layer):**
   1. **#1925 (two Save As Xrefs)** and **#1937 (recreated Xref source)**: both read Xrefs. Neither changes one, but the Codex look has to create Xref files and overwrite one, so Opus must approve the steps first.
   2. **#1941 (import results page)**: the Codex look locks a layer. It only locks and unlocks it with AutoCAD's own command, but it touches a locked layer, so it goes through Opus first.
   3. **#1982 (level range)**: a shipped default of an existing Settings key. The PR itself asks for an Opus review and the N91 start-up smoke.
5. **A search error to know about.** The desk's search found no case, and so did mine: no case, draft or ledger entry exists for any of the seven PRs or the five bug numbers (BUG-908, 805, 505, 788, 1155, 898, 1256). The only mention is in `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md`, which already gave #1941 and #1942 as Codex looks K1_10 and K1_11.
6. **A fact to correct.** PR #1926's text says "robot case N96" and PR #1925's says "N98_xref_saveas_twins". I found no file with either name in the cases folder or the drafts folders. They are proposals only.
7. **What I could not verify:** every window word below is from PR text, marked DERIVED. I did not read the carpark entries or the regression-log entries in full for #1987, #1941 and #1942 (read PR text and diff only). I did not read the installed build.
8. **Nothing for you to test or decide.**

---

## 1. How this was done

1. **Read:** `C:\TimOS\RULES.md`, `README_CASES.md`, the finished example `ROBOT_CASE_DRAFTS_TOP12_30OCT.md`, the style example `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md`.
2. **Read-only GitHub:** `gh pr view` for all seven PRs; `gh pr diff` for #1982, #1987 (first part), #1926, #1925, #1937. #1941 and #1942 from their PR text and the earlier wave-1 report.
3. **Searched for an existing case or draft** in `C:\Lisp Files\_ACAD_DRIVER\cases` (the main folder, `variants`, `_setups` and all the `drafts_*` folders), all `ROBOT_CASE_DRAFTS_*.md`, all `BUGFIX_*` reports and `runner-reports\ledger.json`, by bug number, PR number, switch name and words like Xref and xcivil. Found none. This was a text search; nothing was run.
4. **Checked for a typed route in place of the file picker.** In `LinkCommands.ImportXcivil.cs` on `origin/claude/rel-20261102a`, the file is chosen with a Windows `OpenFileDialog` (line 737, `ShowDialog` at 744). There is no typed path.
5. **Checked for an Xref fixture.** None of the masters in `C:\ce_rc_drv` or the setups in `cases\_setups` carries an Xref. Making one needs a second drawing or a Save-type step, both refused to the robot.
6. **Time spent per fix was kept short.** All six turned out to be window-only or fixture-blocked.

---

## 2. Case texts

**None.** No `W1982`, `W1987`, `W1926`, `W1925`, `W1937`, `W1941` or `W1942` file is offered, and no twin. Offering a half case that would only be BLOCKED would waste a runner slot and could be mistaken for proof.

If the desk later wants a switch-off twin pair, the switches are ready to use through `SETTING CD_Settings.json <key> false` (the README mechanism). They only help once a route exists:

1. `xcivilImport.levelRangeFollowsSettings` (#1982, default ON)
2. `xcivilImport.scheduleReadsMetresAndDepthColumn` (#1987, default ON)
3. `xcivilImport.scaleNoteOnReviewPage` (#1926, default ON)
4. `linking.pitScheduleXrefSeparatesSaveAsCopies` (#1925, existing, default ON)
5. `linking.pitScheduleRecreatedSourceWording` (#1937, default ON)
6. `xcivilImport.importResultsFromWhatWasDrawn` (#1941, default ON)
7. `xcivilImport.cancelLineIsPlainEnglish` (#1942, default ON)

---

## 3. Fix by fix: verdict and the Codex look

Rules for every Codex look below: work on **copies only**, in an evidence folder under `C:\CE_WORK\codex\<the id given>`, never accept or capture a folder the file box opened in, and never unlock a layer, detach, unload or explode an Xref to make a step work. To test a switch OFF, the desk sets the key before AutoCAD starts through the settings guard (settings are read at start-up); Codex does not edit Tim's real settings file by hand.

### 3.1 #1982 (B-150, BUG-908): import level range follows Settings

1. **Verdict: BLOCKED-FOR-ROBOT.** CDIMPORTXCIVIL (and CDIMPORTLANDXML) start from a file picker the robot cannot drive.
2. **Part that cannot be proved by the robot:** the whole fix. The unit tests already pin the range rule at -50 to 1000 m (DERIVED from the PR, not seen in AutoCAD).
3. **Codex look K7_01 (evidence folder `C:\CE_WORK\codex\K7_01_levelrange`).**
   1. Prepare a made-up consultant drawing copy with one pit whose cover level reads 300.00 m and one reading -10.00 m. Plain made-up data only, no client names.
   2. Switch ON (the shipped default): run CDIMPORTXCIVIL on it, accept. **Right looks like:** both pits keep their levels (300.00 and -10.00 appear in the schedule page). Take a screenshot of the schedule page.
   3. Set `xcivilImport.levelRangeFollowsSettings` to false before launch and repeat: **the old behaviour** is that those two levels are dropped without a word (DERIVED from the PR: "250 to 1000 m, and 0 down to -50 m, used to be dropped").
   4. Pass needs both screenshots. Note: this widens the accepted range at the shipped values, so the desk must tell Tim in plain words that levels up to 1000 m and down to -50 m are now accepted.
4. **Opus review first:** yes (shipped default of an existing Settings key, N91 start-up smoke).

### 3.2 #1987 (B-158, BUG-805): metres, depth column and half-blank pipe rows

1. **Verdict: BLOCKED-FOR-ROBOT.** File picker. Part 1 of the PR (the AI-vision reader) also needs the AI reader and a picture file.
2. **Codex look K7_02 (evidence folder `C:\CE_WORK\codex\K7_02_schedule_metres`).**
   1. Made-up drawing copy with a drawn pit schedule table on layer GN-ANNO-TABL and a row reading `CL 8.45m 1.20m`.
   2. Switch ON: run CDIMPORTXCIVIL. **Right looks like:** the pit depth reads 1200 mm, not 8450 (DERIVED from the PR).
   3. A table with a DEPTH column: the depth comes from the cell under DEPTH. A row with two possible depths: depth stays Unknown and the import results carry one WARNING line per pit.
   4. A pipe schedule row with one end blank: it is given to no pipe, and the results say so. A full row still applies to its own pipe.
   5. Switch OFF (`xcivilImport.scheduleReadsMetresAndDepthColumn` false): the row reads 8450 as before.
3. **Not covered by this look:** the AI-vision reader ("0.9 m" read as 900 mm). It needs a picture schedule and the AI key. The unit tests pin it; no AutoCAD proof is drafted.

### 3.3 #1926 (B-112, BUG-505): CHECK THE SCALE and no-units note on the import window

1. **Verdict: BLOCKED-FOR-ROBOT.** The words are on a window page opened from the file picker. Window words are Codex-owned (PR text says the same: "Needs a Codex look in real AutoCAD").
2. **Codex look K7_03 (evidence folder `C:\CE_WORK\codex\K7_03_scalenote`).**
   1. Copy A: a source drawing with INSUNITS 0 (no units). Run CDIMPORTXCIVIL. On the "Pit and pipe schedule" page, **right looks like:** the first words of the banner are "This drawing has no units set; CE read it as millimetres." (DERIVED from the PR). Screenshot.
   2. Copy B: INSUNITS 6 (metres) with millimetre-sized objects (the Codex V8 forced-mismatch drawing of 22 Oct). **Right looks like:** the banner leads with "CHECK THE SCALE: ...". Screenshot.
   3. Control: `xcivilImport.scaleNoteOnReviewPage` false before launch: the banner shows only "Schedule read. Review the pit and pipe rows." or "Check the schedule before accepting the import."
   4. Pass needs a screenshot of each. The units rule and the scale guess are not changed by this PR and are not tested here.
3. **This is a PART claim.** BUG-505 stays open: the PR itself says the units rule is an open question with Tim.

### 3.4 #1925 (B-113, BUG-788): two Save As Xrefs read separately

1. **Verdict: BLOCKED-FOR-ROBOT.** Needs two drawings made by Save As (a second drawing and a Save-type step, both refused to the robot) and a Pit Schedule placed over them (the "Continue to Place / update" button is disabled to the robot, per probe run 0001).
2. **Xref item: Opus review before it runs.** The change is read-only (the PR says no Xref is opened for editing or changed), but the look attaches and reads Xrefs.
3. **Codex look K7_04 (evidence folder `C:\CE_WORK\codex\K7_04_saveas_xrefs`).**
   1. Using made-up drawings only, in the evidence folder: drawing A holds two pits. In AutoCAD, Save As A to B (that gives both the same internal drawing ID). Change one pit in B so the two files differ. Do this on copies, never in a job folder.
   2. Open a host drawing copy. Attach A and B as Xrefs (Xref command, attach, nothing else). Do not unlock, detach, reload with changes, bind or explode them.
   3. Open PITSCHEDULE. **Right looks like (switch ON):** two schedule sources are listed, one for A and one for B, each with its own pits. Screenshot of the source list.
   4. Set `linking.pitScheduleXrefSeparatesSaveAsCopies` to false before launch and repeat: **the old behaviour** is one source listed, and B's pits are missing (DERIVED from the PR and its regression-log text).
   5. Pass needs both screenshots and the exact list of sources read back.

### 3.5 #1937 (B-115, BUG-1155): recreated Xref source says SOURCE RECREATED

1. **Verdict: BLOCKED-FOR-ROBOT.** Needs a placed schedule over an Xref, then the source file overwritten (WBLOCK * over the same path): a placed schedule and a Save-type step, both refused.
2. **Xref item: Opus review before it runs.** The look overwrites an Xref source file on disk while it is loaded. It must be a made-up file in the evidence folder, and Opus must say whether AutoCAD can safely have the source replaced under it without Xref protection being bypassed.
3. **Codex look K7_05 (evidence folder `C:\CE_WORK\codex\K7_05_recreated_source`).**
   1. Made-up source drawing S with two pits, in the evidence folder. Host copy with S attached as an Xref and a schedule placed over it.
   2. Close the host. In a separate AutoCAD session, open S and run WBLOCK, choose all objects and the same path, so S gets a new drawing identity (the PR's own example). Close S. Reopen the host with the Xref loaded.
   3. Open PITSCHEDULE. **Right looks like (switch ON):** the window badge reads **SOURCE RECREATED** with "Re-place the schedule" (DERIVED from the PR). It does not read SOURCE MISSING. Updates are still stopped. Project QA still fails but its message says "recreated". Screenshots of the badge and of Project QA.
   4. Control: `linking.pitScheduleRecreatedSourceWording` false before launch: the badge reads SOURCE MISSING with "could not be found".
   5. Also check a really missing source (rename S) still reads SOURCE MISSING, not recreated.

### 3.6 #1941 (B-122, BUG-898) and #1942 (B-122, BUG-1256): import results page and cancel sentence

1. **Verdict: confirmed BLOCKED-FOR-ROBOT, both.** The wave-1 drafter was right. CDIMPORTXCIVIL begins with a file picker and ends in a results window; neither is drivable, and the "Close" on the schedule page of #1942 sits behind the same picker. These are the notes K1_10 and K1_11 of `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md`, repeated here with exact steps.
2. **Stacking note.** Both branches contain #1926's commits; merge #1926 first, then #1941, then #1942. A Codex look on #1942's branch before that order is settled would also show #1926's banner.
3. **Codex look K7_06a, #1941 (evidence folder `C:\CE_WORK\codex\K7_06a_results_drawn`). Opus review first (a locked layer).**
   1. Copy of a made-up consultant package with 3 pits.
   2. With AutoCAD's own LAYER command, lock the layer STORMWATER PIT on the host copy. Do not unlock it by any other route to make the import go through.
   3. Run CDIMPORTXCIVIL and accept. **Right looks like (DERIVED from the PR):** the results status line reads "Import finished, but 3 of N pits and pipes were NOT drawn", and the pit rows read Check with "Not drawn - layer "STORMWATER PIT" is locked, so CE did not draw it". Screenshot.
   4. Unlock the layer with AutoCAD's own command and run again: every row reads Recorded and the line says "Import complete. Check the listed drawing items."
   5. Control: `xcivilImport.importResultsFromWhatWasDrawn` false: rows read Recorded even though nothing was drawn.
4. **Codex look K7_06b, #1942 (evidence folder `C:\CE_WORK\codex\K7_06b_cancel_line`).**
   1. Run CDIMPORTXCIVIL, choose a made-up drawing, let the schedule page open, press **Close**.
   2. **Right looks like (DERIVED):** the last command-line line reads "CDIMPORTXCIVIL cancelled. Nothing was drawn." and no results window opens. Screenshot of the command line.
   3. Control: `xcivilImport.cancelLineIsPlainEnglish` false before launch: the line reads "Import aborted at pre-flight gate - no entities were inserted."
   4. Not part of this PR: the "CHECK THE SCALE printed twice" polish.

---

## 4. Fixes skipped, and why

1. **#1982, #1987, #1926, #1941, #1942:** no case. File picker (and a window page) the robot cannot drive. Codex looks K7_01, K7_02, K7_03, K7_06a, K7_06b.
2. **#1925, #1937:** no case. Needs Save As copies, a second drawing, a placed Pit Schedule, and for #1937 a file overwritten. All refused or disabled for the robot. Codex looks K7_04, K7_05. **Both need an Opus review before they are run.**
3. **One change that would reopen several of these:** a reviewed allow-list change that lets the robot place a schedule, or a typed-path route in place of the file picker (a command setting or a LandXML path argument). I have not asked for either; it is Tim's call and needs Opus.

---

## 5. What was read, built, tested, and NOT proven

1. **Read:** the files in section 1, the seven PR texts, and the diffs listed there. The PR #1987 diff was only read in part (its test file); the service change itself was not read.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing. **AutoCAD:** not opened. The robot was not run.
3. **NOT proven:** every window word and every printed line above is DERIVED from PR text. The installed Civil build was not read, so whether these PRs are in it is not recorded here. Nothing here proves any of these bugs is fixed; each bug stays open until a Codex look (and, where the carpark says so, Tim's word) passes.
