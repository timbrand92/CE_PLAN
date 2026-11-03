# Look briefs for the b1 train (Civil 3.0.90, candidate c1076), part 2: PRs 7 to 12

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, Team, read-only drafting. Nothing was built, tested, installed or run. No AutoCAD was opened. No code, setting, drawing or git state was changed. Only this file was written. The order gave the folder as `C:\CE_PLANreas\`; that looks like a typo for `C:\CE_PLAN\areas\` (same call as part 1), so this file is in `areas`. Please say if it should move.

---

## FOR TIM

1. **Answer:** of these 6 PRs, 3 need a look by eye after the install, 1 is robot-first, 1 is probably not testable at all, and 1 needs no look.
2. **Needs a look:** #1945 (CDDESIGN warns when approved outlets came from a Save As copy), #1880 (the Inspector no longer says "Unknown" after you reopen a drawing; this is your own "i always have to cdsync" complaint) and #1953 (two drawings open: the Inspector shows the newer list).
3. **Robot first:** #1952 (after Undo, CE saves again instead of refusing). The robot case is written, but when it was reviewed it could not run (it types Lisp, which the robot refuses). I could not confirm it is runnable now, so I would not count on it.
4. **Probably cannot be tested:** #1950 (a refused upgrade of an old twin detention pipe leaves its route alone). It needs an old drawing with a twin detention pipe and a PC where the upgrade is refused. Neither exists. It stays proven by calculation only.
5. **No look needed:** #1951 (a tidy-up inside CE; nothing on screen changes). #1880's look covers it as a bonus.
6. **Nothing here needs your time.** Each look is for Codex or the robot, after 5:30 pm, on copies only.
7. **What I did not prove:** every statement about what AutoCAD will show comes from reading code and earlier reports. None has been seen on 3.0.90.
8. **Needs a GO:** two items. The #1880 look needs a test settings copy with one switch typed OFF for its control run, and #1953 has no way to make the failed save yet, so it needs CE 00 to decide whether to build one.

---

## WHAT WAS READ, BUILT, TESTED, NOT PROVEN

1. **Read:** `C:\TimOS\RULES.md`; `git fetch origin` first (done, Mon 2 Nov); the 18 merge commits `61fd6fbc..cf059dcf` (git log first-parent, order below); the merge diffs of the six PRs (files and sizes); the REGRESSION_LOG entries for BUG-1158, BUG-1152, BUG-1070, BUG-1240, BUG-1265, BUG-1263 as they stand at cf059dcf; the rule files `LpdSaveAsCopyRule.cs` and `InspectorProjectSourceRule.cs`; BUILD_REGISTER items 267 to 272; `C79B1_AREA_TEST_PLAN_01NOV.md`, `C79B1_WRITING_W1_REPORT.md`, `C79B1_WRITING_W2_REPORT.md`, `C79B1_REVIEW_REPORT.md`, `C79B1_FIXTURE_NOTE.md`; `CODEX_LOOKS_PLAN_C78_C79_01NOV.md`; `spec_c79b1_smoke.txt`; the folder listing of the robot's draft cases; the style of `LOOKBRIEFS_B1_PART1_02NOV.md`.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing by me.
3. **Authority check:** installed is Civil 3.0.89 = commit 61fd6fbc. I checked each of the six PR heads with `git merge-base --is-ancestor` against 61fd6fbc: none is in 3.0.89. All six are inside cf059dcf (c1076 = 3.0.90). Heads: #1945 7c31c33c, #1950 649df208, #1952 6845a095, #1880 3f7ed338, #1951 d34c51b8, #1953 c6a04c9a. `rel-20261110a` (b2) was not read.
4. **Not proven:** none of the six has been opened in AutoCAD on any build. Every REGRESSION_LOG entry says "Built and unit-tested only".
5. **I could not read:** the PR descriptions on GitHub (the `gh` tool is not on this machine's path). I used the merge diffs, REGRESSION_LOG and the robot reports instead.
6. **Not found:** a robot case for #1880 (the REGRESSION_LOG names N39_inspector_reopen, but no such file exists in the robot's case folders and the b1 smoke spec has none); the exact command or button that opens the CE Inspector; any drawing holding an approved Design outlet record or an old twin detention pipe.

---

## THE SIX PRs, IN MERGE ORDER (positions 7 to 12 of 18)

1. **#1945** BUG-1158, CDDESIGN warns once when the approved outlets were approved under another file path. Look LB-B1-07.
2. **#1950** BUG-1152, a refused upgrade of an older twin detention pipe puts its main line back. Look LB-B1-08, conditional, probably NOT TESTABLE.
3. **#1952** BUG-1070, after Undo or Redo CE lifts or sets the "cannot save over an unreadable record" hold correctly. Robot cases W1952 and its twin, then a short note.
4. **#1880** BUG-1240, the Inspector reads the saved list when CE holds none in memory. Look LB-B1-10.
5. **#1951** BUG-1265, CDCHECK and the Inspector ask one shared rule. No look of its own.
6. **#1953** BUG-1263, with two drawings open the Inspector shows the newer kept list. Look LB-B1-12, conditional.

---

## LOOK LB-B1-07: #1945, CDDESIGN WARNS WHEN APPROVED OUTLETS CAME FROM A SAVE AS COPY (BUG-1158, head 7c31c33c)

1. **What to look at:** you approve Design outlets in a job, save, then use Save As to start a new job. CDDESIGN on the new file used to show the old job's outlets as already approved with no word. Now it lists them as before and adds one warning line on the command line.
2. **Switch:** `linking.lpdWarnsWhenOutletsApprovedInAnotherFile`, ships ON. OFF = no path recorded and no warning (the old behaviour).
3. **Why no robot case (plain):** the robot cannot approve outlets (the CDLPD window is not on its press list), cannot Save As, and cannot type the Lisp that would fake the record (the review notes it would not be at the right version anyway). The only robot route is a fixture: someone approves outlets once on a made-up drawing and saves it as a master. Then every robot copy sits under another path, and the warning should appear once. That fixture does not exist (NOT FOUND).
4. **Steps (a drafter route), on a made-up drawing, copies only:**
   1. With 3.0.90 installed, open a copy of a made-up job drawing. Note the object count.
   2. Approve the Design outlets in CDLPD (or in CDDESIGN, whichever offers the approval; the exact buttons are NOT FOUND in what I read, so copy the real ones). Save.
   3. Run CDDESIGN in this same file. Read the command line. Take a picture. Close CDDESIGN with Esc.
   4. Save As a new name in a different folder. Run CDDESIGN in the new file. Read the command line. Take a picture. Close with Esc. Never approve or change anything here.
   5. Control 1 (an older approval): open a drawing whose outlets were approved before 3.0.90 and run CDDESIGN. Expect no warning. Needs such a drawing (NOT FOUND).
   6. Control 2 (switch off): close AutoCAD, type `lpdWarnsWhenOutletsApprovedInAnotherFile` = false in a test copy of the settings, start again, then repeat step 4 on a file approved under 3.0.90. Expect no warning. This needs CE 00's GO. Do not touch Tim's real settings file.
5. **Right looks like:**
   1. Step 3, the original file: the outlets listed, no warning.
   2. Step 4, the Save As copy: the outlets listed exactly as before, plus one line starting "[CE] Warning: the approved outlets in this drawing were approved when it was saved under another file name or folder. If this is a new job started with Save As, check the outlets are right for it before relying on them. Approve the outlets again in CDLPD to clear this warning."
   3. Controls 1 and 2: no warning.
6. **Wrong looks like:** the warning in the original file; the warning twice in one CDDESIGN run; the outlets un-approved or missing in the copy (the fix only warns); no warning in the copy; a brand-new unsaved drawing warning; an error window.
7. **Expect, do not call a fault:** a job you renamed or moved also warns. Tim's wording and path-comparison question on this is still open in QUESTIONS_FOR_MONDAY. The look checks the shipped words only, not whether they are the right words.
8. **Evidence pictures:** the command line after CDDESIGN in the original (one); after CDDESIGN in the Save As copy (one); the control runs (one each).
9. **Not proven:** nothing in AutoCAD. Two things were never seen: what AutoCAD hands back as the file name of a drawing that was never saved (the code now reads "never saved" correctly, per the 31 Oct re-check fix, but only a source test shows that), and that approving writes the path in the same step as the approval so one Undo takes it away.
10. **If it cannot be arranged:** record NOT TESTED, NO FIXTURE. The Opus review said NO to the unit tests alone for this PR, because writing and reading the path is drawing work proved by source checks only.

---

## LOOK LB-B1-08: #1950, A REFUSED TWIN DETENTION PIPE UPGRADE LEAVES ITS ROUTE ALONE (BUG-1152, head 649df208), CONDITIONAL

1. **What to look at:** opening an older job, CE turns each twin detention pipe into a pipe object in two steps: it moves the pipe's main line to the centreline, then swaps the object in. If the swap is refused, the line used to stay moved while the record still called it a barrel, so a later redraw could put the two barrels in the wrong place. Now the line is put back.
2. **Switch:** `linking.twinUpgradeRestoresRouteOnRefusal`, ships ON. OFF = the old behaviour (the moved line stays).
3. **Why this is probably NOT TESTABLE:** it needs (a) a drawing with an older twin detention pipe and (b) a PC where the pipe-object upgrade is refused, which the PR says is a colleague's PC or the enabler saying no. The robot's writer found no fixture holding a twin pipe and no setting that forces a refusal. The drainage corpus holds real job drawings, so the robot may not use it.
4. **Steps (only if both conditions can be met), on a copy:**
   1. Note the object count and the route and barrels of the twin pipe before opening (a picture).
   2. Open the drawing on the PC or setting where the upgrade is refused. Do nothing else.
   3. Read the command line: nothing about this pipe is expected there.
   4. Type REGEN. Take a picture of the twin pipe: same route and same barrels as in step 1.
   5. Read the CE log. Expect one line starting `[BUG-1152]` that names the pipe.
   6. Close without saving. Object count unchanged.
5. **Right looks like:** the twin looks exactly as before the file was opened, after the open and after a regen, with one `[BUG-1152]` log line.
6. **Wrong looks like:** the main line sitting between the barrels instead of on its old route; the barrels in different places after the regen; a message or window appearing; a locked layer unlocked by CE (it must not be: the existing locked-layer check runs first and is unchanged).
7. **Evidence pictures:** before opening; after opening and regen; the log line.
8. **Not proven:** nothing in AutoCAD. The put-back of the main line's points is checked by 9 unit tests that pin the rule, the switch and the order in the code only. The Opus review said NO to those alone.
9. **If the conditions cannot be met:** record NOT TESTED, NO FIXTURE, NO REFUSING PC. Do not fake a refusal by editing the drawing. Nothing changes on a normal install, because the route only changes when an upgrade is refused.

---

## ROBOT CASES W1952 AND W1952_BROKEN, THEN A NOTE: #1952, UNDO LIFTS THE HOLD (BUG-1070, head 6845a095, PROTECTED FILE)

1. **What it fixes (plain):** something damages CE's saved record, and CE refuses to save over it, to protect the original. You press U and CE reloads the good record, but later saves still said "Not saved to the CE record". Drawing changes showed on screen while CE's own record was quietly not updated. Now U and Redo move that "refuse to save" state correctly.
2. **Switch:** `linking.undoRefreshesUnreadableRecordHold`, ships ON, key only, no Settings row. `linking.keepUnreadableDrawingRecord` (BUG-971) is unchanged and still wins: with it OFF nothing is ever held.
3. **What the robot case does (written by the Wave 2 writer):** it damages the saved list in one step, then runs LINE, U, CDREBUILD (save skipped), U, U (takes the damage back), a 12 s pause, REDO (damage returns), CDREBUILD (skipped again), U, U, CDREBUILD (saves). The twin W1952_BROKEN has the switch OFF. It reads the log back after each.
4. **What it should read:** exactly 2 lines "[CE] Not saved to the CE record (CE's own record save): the CE record in this drawing could not be read, so CE does not save over it.", 3 lines "[CE] CDREBUILD complete:", and the record reading damaged after REDO and good after the last two read-backs. The twin should fail those checks (the Opus paper review agreed it goes red without the fix).
5. **Status I could find:** the b1 smoke spec lists it (`bmW1952` and `bmW1952b`, in the b1 packs). BUT the Wave 2 report and the Opus review both marked it NOT RUNNABLE, because the damage setup types Lisp and the robot refuses typed Lisp. I did not find a record that this was fixed. So the PR is NOT skipped: either the runner owner unblocked it (not recorded), or the case will fail to validate on the install. Check that before the install evening.
6. **Biggest risk named by the reviewer:** each U must undo exactly the step the writer names. If another CE save is skipped between the first U and the first CDREBUILD, one line is used up and the count reads 1. That shows as a red check, not a stall, so the first run is effectively a probe.
7. **REDO rule:** nothing is read and no Lisp is typed between U and REDO. The case waits 12 s. Keep it that way.
8. **What a look would add:** nothing visible. The log and the record are the whole evidence. No Codex look is planned. If the robot case cannot run, a Codex route would also need to damage the record, which needs typed Lisp, so there is no ready fallback. Record NOT TESTED rather than hand-damaging a drawing.
9. **Not proven:** nothing in AutoCAD. "A record that is there with text and cannot be read puts the hold on" rests on the reviewer reading the reader code (`ProjectDataService.Persistence.cs` lines 1062 to 1117). It was not seen. Whether CE's own next command rewrites the damage was not confirmed offline.

---

## LOOK LB-B1-10: #1880, THE INSPECTOR NO LONGER SAYS "UNKNOWN" AFTER YOU REOPEN A DRAWING (BUG-1240, head 3f7ed338)

1. **What to look at:** this is Tim's own complaint (29 Oct, hand checks H22 and H53: "i always have to cdsync when i reopen drawing"). After Save As, or after closing and reopening a drawing, picking a pit and opening the CE Inspector said "This pit is not in CE's recorded project data yet. Values below are Unknown", with every value Unknown, until CDSYNC or the Pit Schedule ran. Now the Inspector reads the list saved inside the drawing, without changing anything.
2. **Switch:** `linking.inspectorReadsSavedRecordWhenNotLoaded`, ships ON. OFF = the old behaviour (Unknown until a CE command runs).
3. **Why a look, not the robot:** the REGRESSION_LOG proposes a robot case (N39_inspector_reopen), but no such case file exists (NOT FOUND) and the earlier robot notes say the robot reads the Inspector's pit values badly. The Inspector is a palette. The Codex look for #1880 and #1951 together is in the Codex looks plan.
4. **Steps (a drafter route), on a copy of a job drawing that has pits, with 3.0.90 installed:**
   1. Open the copy. Do not run any CE command. Close it without saving (or Save As a new name and keep that one open).
   2. Open it again (or stay in the Save As copy). Still run no CE command.
   3. Pick pit P2 (or any named pit). Open the CE Inspector (the palette; the exact button is NOT FOUND in what I read, so copy the real one). Read the Number and Cover level. Take a picture.
   4. Run CDCHECK once and read what it says for that pit's name and joins. Take a picture. This is the #1951 bonus: the Inspector and CDCHECK should agree.
   5. Close nothing else. Esc any command. Object count must equal what it was at the open.
   6. Control: close AutoCAD, type `inspectorReadsSavedRecordWhenNotLoaded` = false in a test copy of the settings, start again, repeat steps 1 to 3. Expect the old Unknown text. This needs CE 00's GO. Do not touch Tim's real settings file.
5. **Right looks like:** with the switch ON, the Inspector shows Number P2 and a Cover level straight away, with no CDSYNC. CDCHECK shows names and joins for the same pit. With the switch OFF in the control, the Inspector shows "not in CE's recorded project data yet" and Unknown.
6. **Wrong looks like:** Unknown with the switch ON; the Inspector showing a different pit's values; a drawing change, a save prompt or an Undo entry caused by just picking a pit (this fix is read only); the "Open existing" button behaving differently (it is still decided by CE's list in memory only).
7. **Evidence pictures:** the Inspector on the reopened drawing, switch ON (one); CDCHECK's line (one); the Inspector with the switch OFF (one).
8. **Not proven:** nothing in AutoCAD. That the saved-list read returns P2 on a real reopened drawing is expected from the code, not seen. The Pit Schedule and other palette pages are not changed by this PR.

---

## #1951, ONE SHARED RULE FOR CDCHECK AND THE INSPECTOR: NO LOOK OF ITS OWN (BUG-1265, head d34c51b8)

1. **What it is:** a tidy-up inside CE. The Inspector rule was a near copy of the CDCHECK rule. Now both ask one shared rule. The REGRESSION_LOG says plainly: behaviour none changed, no new switch, nothing a drafter can see.
2. **Proof:** a unit test runs all eight cases and checks the Inspector and CDCHECK choose the same source every time, and that both rule files hold no copy of the logic. That is the right proof for a code tidy. No robot case and no look is written.
3. **What would show it was wrong:** the Inspector and CDCHECK disagreeing after a reopen (one showing names and joins, the other Unknown). Step 4 of LB-B1-10 reads exactly that, so it comes free.
4. **Not proven:** nothing in AutoCAD. A green unit test says the rules agree. It does not say what the palette shows.

---

## LOOK LB-B1-12: #1953, WITH TWO DRAWINGS OPEN THE INSPECTOR SHOWS THE NEWER LIST (BUG-1263, head c6a04c9a), CONDITIONAL

1. **What to look at:** two drawings open. A CE change in drawing A could not be saved before you switched to drawing B. Back in A, picking a pit used to show A's older saved values, not the newer ones CE was holding, until a CE command ran in A. Now the Inspector looks at the newer kept list first.
2. **Switch:** `linking.inspectorShowsRecordWaitingToSave`, ships ON. It only works when `inspectorReadsSavedRecordWhenNotLoaded` (#1880) is also ON. OFF = the older saved list, as before.
3. **Why conditional, and what is missing:** the look needs a CE change that fails to save in A. Two ways are mentioned: a read-only file, or a busy drawing. I could not confirm that either actually makes CE keep an unsaved list (a read-only DWG file may not stop CE writing its record inside the open drawing). The registered robot idea (N13a_inspector_kept_record) is marked "hard to arrange; a Codex look is the alternative". The robot also cannot hold a second drawing steady. NOT FOUND: a reliable recipe for the failed save.
4. **Steps (only after CE 00 gives or builds a recipe for the failed save), on copies:**
   1. Open two copies of made-up drawings, A and B. Both must have pits, and A's pit P2 must have a value you can tell apart (note it).
   2. In A, make a CE change that CE cannot save yet (by the agreed recipe), for example a changed cover level on P2. Note the new value.
   3. Switch to B and run a CE command there.
   4. Switch back to A. Do not run a CE command. Pick P2 and open the Inspector. Read the cover level. Take a picture.
   5. Control: with `inspectorShowsRecordWaitingToSave` = false in a test copy of the settings, repeat. Needs CE 00's GO.
5. **Right looks like:** switch ON shows the NEW value in step 4. The control shows the OLDER saved value. A's own later save at its next command is unchanged.
6. **Wrong looks like:** the old value with the switch ON; the new value with it OFF; the values of B's pit; a change to A's saved record caused by looking (the fix copies the kept list and writes nothing).
7. **Evidence pictures:** the Inspector in A, switch ON (one); switch OFF (one); the object count line for A before and after.
8. **Not proven:** nothing in AutoCAD. That the kept list holds the wanted pit on a real drawing is expected from the code, not seen. Two drawings and a failed save cannot be driven headless.
9. **If no recipe exists:** record NOT TESTED, NO RECIPE. Do not fake it. The unit tests (the rule over every row, the two-drawing case, and the guards that the Inspector never takes or writes the kept record) stay the only proof. The Opus review in the Codex looks plan puts #1953 with #1955 as a look needing two open drawings.

---

## SKIPPED ITEMS AND WHY

1. **#1951 (BUG-1265):** no look of its own, because nothing it changes can be seen. It is covered by step 4 of LB-B1-10. It is not fully proven by the robot (the robot has no case); the unit test is the proof.
2. **No PR in this part is fully proven by the robot.** #1952 is the only one with a robot case, and that case was marked NOT RUNNABLE at review. I found no record that this was fixed.
3. **Not written again here:** #1892 (position 4) and #1940, #1943 (positions 5, 6) are in Part 1. #1955, #1958, #1969, #1970, #1972 and #1923 (positions 13 to 18) belong to Part 3.
4. **Conditional looks that may end NOT TESTED:** LB-B1-08 (#1950) and LB-B1-12 (#1953). Each says what is missing and what to write if it is.
5. **Open question I did not turn into a decision:** Tim's wording and path-comparison question on #1945. I left it in QUESTIONS_FOR_MONDAY.
