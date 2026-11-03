# Look briefs for the b1 train (Civil 3.0.90, candidate c1076), part 3: PRs 13 to 18

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, Team, read-only drafting. Nothing was built, tested, installed or run. No AutoCAD was opened. No code, setting, drawing or git state was changed. Only this file was written. The order gave the folder as `C:\CE_PLANreas\`; that looks like a typo for `C:\CE_PLAN\areas\` (same call as parts 1 and 2), so this file is in `areas`. Please say if it should move.

---

## FOR TIM

1. **Answer:** of these 6 PRs, 1 is robot-first with one thing for Codex to see, 2 need a look by eye, 1 cannot be tested on this PC, 1 has nothing you can see, and 1 is switched off so it changes nothing yet.
2. **Robot first, then a look:** #1972 (Edit Pipe now asks "Recalculate downstream?" after the change is accepted, not in the middle of it). The robot case is written and its fix was made. It proves the old route still works and one Undo takes it all back. It cannot see the ORDER, so Codex must look at the drawing behind the box.
3. **Needs a look:** #1955 (Undo in drawing A after you picked in drawing B) needs two drawings open, so Codex does it, and shares one session with #1953 from part 2. #1923 (double-click on a pit label) is built but ships OFF, so on the installed settings nothing changes. It gets its look only with two test switches turned on in a copy.
4. **Cannot be tested here:** #1969 (a typed level with a comma on a comma-region PC). Needs a PC with the Windows region set to a comma. We must not change the region on this PC.
5. **Nothing visible:** #1958 (a damaged saved list is logged once, not on every pick, in the CE log). #1970 (Edit Pipe warns when a level could not be stored on the pipe) can only be seen on a pipe with a damaged record, and nothing can make one without typed Lisp. Both stay proven by the calculation tests only.
6. **Nothing here needs your time.** Each look is for Codex or the robot, after 5:30 pm, on copies only.
7. **What I did not prove:** every statement about what AutoCAD will show comes from reading code and reports. None has been seen on 3.0.90.
8. **Needs a GO:** the #1923 look and the controls for #1955 and #1972 need a test copy of the settings with switches typed in before AutoCAD starts. Never your real settings file.

---

## WHAT WAS READ, BUILT, TESTED, NOT PROVEN

1. **Read:** `C:\TimOS\RULES.md`; `git fetch origin` first (done, Mon 2 Nov); the first-parent merge list `61fd6fbc..origin/claude/rel-20261108a` (18 merges, tip cf059dcf = Civil 3.0.90); the merge diffs (files and sizes) of the six PRs; the REGRESSION_LOG entries for BUG-1264, BUG-1266, BUG-1164, BUG-1157, BUG-658 and BUG-430 as they stand at cf059dcf; the commit 4445c243 (the switch defaults pinned for the train); the BUG_CARPARK entries for BUG-658, 430 and 1157; `C79B1_AREA_TEST_PLAN_01NOV.md`, `C79B1_WRITING_W1_REPORT.md`, `C79B1_WRITING_W2_REPORT.md`, `C79B1_REVIEW_REPORT.md`, `C79B1_FIXTURE_NOTE.md`, `CODEX_LOOKS_PLAN_C78_C79_01NOV.md`; the robot's draft case folders (names and the header of the W658 case); the style of `LOOKBRIEFS_B1_PART2_02NOV.md`.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing by me.
3. **Authority check:** installed is Civil 3.0.89 = commit 61fd6fbc. I checked each PR head with `git merge-base --is-ancestor` against 61fd6fbc: none of the six is in 3.0.89. All six are inside cf059dcf (c1076 = 3.0.90). Heads: #1955 f5d89113, #1958 9d25604c, #1969 1d411b28, #1970 b3e76c82, #1972 32fc1a44, #1923 454e3eab. `rel-20261110a` (b2) was not read, so I do not say what it holds.
4. **Not proven:** none of the six has been opened in AutoCAD on any build. Every REGRESSION_LOG entry says "Built and unit-tested only".
5. **I could not read:** the PR descriptions on GitHub (no `gh` on this tool's path). I used the merge diffs, the REGRESSION_LOG and the robot reports instead.
6. **Not found:** a robot case for #1955, #1958, #1969, #1970 or #1923 (the REGRESSION_LOG names N13b_undo_two_drawings, N13c_inspector_unreadable_once and N95_pitlabel_dblclick, but no such files exist in the case folders I listed); the exact button that opens the CE Inspector; the b1 smoke spec file named in part 2 is not in `areas` this time, so I could not check which of these six it lists. I did not open the settings file on this PC.
7. **One thing I did not check:** whether the W658 case line 21 fix ("PROVES_BUGS" emptied) was the review's required change. The file now reads `PROVES_BUGS` with nothing after it, which matches the fix. The case files were last changed Sun 1 Nov 03:37, so nothing newer.

---

## THE SIX PRs, IN MERGE ORDER (positions 13 to 18 of 18)

1. **#1955** BUG-1264, Undo in drawing A, after a pick in drawing B, clears CE's pit list properly. Look LB-B1-13, conditional.
2. **#1958** BUG-1266, a damaged saved list is logged once per drawing, not twice on every pick. No look of its own.
3. **#1969** BUG-1164, Edit Pipe stores a typed level with a full stop on a comma-decimal PC. Look LB-B1-15, NOT TESTABLE on this PC.
4. **#1970** BUG-1157, Edit Pipe says so when it could not write the level onto the pipe. No look possible.
5. **#1972** BUG-658, the downstream question comes after the change is accepted. Robot case W658 and its twin, then look LB-B1-17.
6. **#1923** BUG-430, a double-click on a pit label opens Edit Pit, not AutoCAD's attribute editor. Look LB-B1-18, ships OFF.

---

## LOOK LB-B1-13: #1955, UNDO IN DRAWING A AFTER A PICK IN DRAWING B (BUG-1264, head f5d89113), CONDITIONAL

1. **What to look at:** two drawings open. A CE command in A saves CE's pit list into A for the first time. You pick a pit in B. Then Undo in A goes back before that first save. The Inspector in A could still list a pit the Undo had removed (never another drawing's pit). Now each drawing keeps its own note of "CE saved a list in me", so the Undo clears the list correctly.
2. **Switch:** `linking.undoRemembersEachDrawingsRecord`, ships ON. OFF = the old single note (the fault).
3. **Why a look, not the robot:** it needs two drawings open and the robot cannot hold a second drawing steady. The test plan puts #1955 and #1953 (part 2) in one Codex look. The REGRESSION_LOG proposes N13b_undo_two_drawings; no such case file exists (NOT FOUND).
4. **Steps (Codex or a drafter route), two copies of made-up drawings, 3.0.90 installed:**
   1. Open copy A. It must have no CE pit saved in it yet (a fresh drawing). Open copy B, which already has pits. Note the object count of each.
   2. In A, place one pit with the normal pit command. Read the command line. This is the first CE save in A.
   3. Switch to B. Pick a pit there and open the Inspector, so the Inspector reads B.
   4. Switch back to A. Type U enough times to go back to before the pit (check the pit is gone from the drawing).
   5. Pick where the pit was, or the empty drawing, and look at the Inspector. Read the command line. Take a picture.
   6. Control: close AutoCAD, type `undoRemembersEachDrawingsRecord` = false in a test copy of the settings, start again and repeat 1 to 5. Needs CE 00's GO. Do not touch Tim's real settings file.
5. **Right looks like:** switch ON, the Inspector no longer lists the pit and the CE log says "Undo removed CE's record from this drawing". Switch OFF, the removed pit is still listed.
6. **Wrong looks like:** the removed pit still listed with the switch ON; B's pits shown in A; a drawing change or save prompt caused by picking; the Undo not putting the drawing back.
7. **Evidence pictures:** the Inspector in A with the switch ON (one); the command line after the Undo (one); the control with the switch OFF (one).
8. **Not proven:** nothing in AutoCAD. That the Inspector drops the pit on a real Undo is expected from the code, not seen. The REGRESSION_LOG says so itself. Nothing was changed in the Undo path; only the yes/no it is handed differs.
9. **If it cannot be arranged:** record NOT TESTED, TWO-DRAWING LOOK NOT RUN. The unit tests (two drawings both remembered ON, the old single note OFF, close drops only that drawing) stay the only proof.

---

## #1958, A DAMAGED SAVED LIST IS LOGGED ONCE, NOT ON EVERY PICK: NO LOOK OF ITS OWN (BUG-1266, head 9d25604c)

1. **What it is:** when the pit and pipe list saved in a drawing cannot be read (for example written by a newer CE), every pick and every Inspector refresh tried again and wrote two lines in the CE log. Values show Unknown either way. Now the failed read is noted per drawing and later picks write nothing. Pure log noise and repeat work; nothing on the drawing changes.
2. **Switch:** `linking.inspectorUnreadableRecordLoggedOnce`, ships ON. OFF = two log lines on every pick, as before.
3. **Why no look:** it only acts when CE holds NO list in memory, which means a drawing OPENED with the damage already in it. The damage setups need typed Lisp, which the robot refuses, and the runner cannot reopen inside a case. A damaged drawing file does not exist as a fixture. The reviewer accepted the unit test (five picks give one read ON, five reads OFF) as logic evidence for this one, because there is no drawing change at all.
4. **What would show it wrong:** you could not see it as a drafter. In the CE log, one "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown." line per drawing is right, not one per pick.
5. **Not proven:** nothing in AutoCAD. The REGRESSION_LOG also names what it did NOT do: a good saved list is still read on every pick, and the cost on the biggest job drawing was never measured (a question for CE 04 via CE 05).

---

## LOOK LB-B1-15: #1969, A TYPED LEVEL WITH A COMMA ON A COMMA-DECIMAL PC (BUG-1164, head 1d411b28), NOT TESTABLE HERE

1. **What it fixes:** on a PC whose Windows region writes a comma as the decimal mark, typing 18,14 as an Edit Pipe level is read as 18.14 by the window, but the text stored on the pipe and in the schedule stayed "18,14". Later readers treat it as missing, and the audit reads it as 1814. Now it is stored as 18.14. The text drawn on the plan is not changed. Australian-region PCs are not affected.
2. **Switch:** `pipe.editPipeStoresLevelsWithDecimalPoint`, ships ON. OFF = stored as typed.
3. **Why NOT TESTABLE on this PC:** the test needs the Windows regional decimal set to a comma. The robot must not change Tim's regional settings. The Codex looks plan parks this one for Tim's other PC, or a Windows regional switch Tim approves. It is not written as a robot case.
4. **Steps, if such a PC exists, on a copy:**
   1. Check the PC's region really uses a comma: in Windows, Settings, Time and language, Region, look at the number format. Take a picture.
   2. Open a copy of a made-up drawing with a pipe. Open Edit Pipe on it.
   3. Type 18,14 as the first level. Save.
   4. Read the stored level back: look at the schedule row and the pipe's level text in the Inspector or Edit Pipe again. Take a picture. Then run CDAUDIT and read what it says for that pipe.
   5. Undo once. Object count unchanged.
5. **Right looks like:** the schedule and the reopened Edit Pipe show 18.14. CDAUDIT raises no 1814 reading for that pipe.
6. **Wrong looks like:** "18,14" stored; CDAUDIT reading 1814; the level drawn on the plan different from what was typed.
7. **Expect, do not call a fault:** a drawing saved earlier with "18,14" already stored is not repaired, and CDAUDIT's reader is not changed. It is a fix for what is typed from now on.
8. **Not proven:** nothing in AutoCAD, and nobody has a comma-region PC to try it on (the REGRESSION_LOG says so). The unit tests use `de-DE` as the PC's culture and show 18,14 gives 18.14 and 18,10 gives 18.10. That proves the conversion, not Edit Pipe on screen.
9. **If it cannot be arranged:** record NOT TESTED, NO COMMA-REGION PC. Do not change this PC's region to fake it.

---

## #1970, EDIT PIPE WARNS WHEN THE LEVEL COULD NOT BE STORED ON THE PIPE: NO LOOK POSSIBLE (BUG-1157, head b3e76c82)

1. **What it is:** Edit Pipe writes the new level onto the pipe itself in a separate step that caught every failure and said nothing. The schedule and plan showed the new level while the pipe kept the old one, which CE goes back to if the level text is deleted. Now, when that write fails, Edit Pipe prints one line: "[CE] Warning: the level was not saved on pipe P3-P4 itself. The schedule and plan show the new level, but if its level text is deleted CE will go back to the old one. Check the pipe and run Edit Pipe on it again." The save carries on. Nothing is rolled back and nothing is refused.
2. **Switch:** `pipe.editPipeLevelWriteSaysWhenNotSaved`, ships ON. OFF = silent as before.
3. **Why no look or case:** the trigger is a pipe whose saved record throws when read or written, a damaged record. The robot's writer found that a locked layer is NOT a trigger (it skips quietly and says nothing). The damage setups need typed Lisp, which the robot refuses. The REGRESSION_LOG itself says "a case the robot does not have yet". The reviewer accepted the unit tests as logic evidence for this PR, with a limit: it only adds a line on a failure path no robot can trigger.
4. **What a normal pipe shows:** on any ordinary pipe, no such line. That much any Edit Pipe run on 3.0.90 shows (R11v87-style runs pass through this code), so a stray warning line on a healthy pipe would be a visible fault. The W658 robot case below runs Edit Pipe once and its checks include the absence of the new #1972 lines, not this one, so I am not claiming it covers #1970.
5. **Not proven:** nothing in AutoCAD. The four failure paths are proved by source checks only.
6. **Recorded as:** NOT TESTED, NO WAY TO MAKE A DAMAGED PIPE RECORD WITHOUT TYPED LISP.

---

## ROBOT CASES W658 AND W658_BROKEN, THEN LOOK LB-B1-17: #1972, THE DOWNSTREAM QUESTION COMES AFTER THE CHANGE IS ACCEPTED (BUG-658, head 32fc1a44)

1. **What it fixes (plain):** you change a pipe's downstream level in Edit Pipe and Save. CE asks "Recalculate downstream pipe inverts?", shows the preview, and on Yes prints "[CDEDIT-CASCADE] Updated N pipes ...". All of that used to happen INSIDE Edit Pipe's own open change. If the save was then refused (the example given is a locked label layer), the Edit Pipe change was rolled back but the downstream pipes had already been rewritten and the line was false. Now the question, the preview and the cascade run after the change commits, still inside the same command, so one Undo takes everything back.
2. **Switch:** `pipe.cascadeQuestionAfterEditCommits`, ships ON. OFF = the question is asked inside the open change, as before. Read when Edit Pipe saves, but Tim's rule from the settings notes stands: set it before AutoCAD starts.
3. **Behaviour change to know about:** if the cascade itself throws now, the pipe stays saved and one line says so: "[CE] Pipe updated. The downstream recalculation could not be completed; the pipe itself was saved." Before, the throw rolled the whole Edit Pipe save back.
4. **Robot case:** W658 (SETUP-R47v) in `drafts_c79b1_01nov`. It is R11v87's route, which passed on 3.0.88: Edit Pipe on P3 (levels 17.60 and 17.50), Save, Yes to Recalculate, Apply in Cascade Preview, then one U. It should read: the question still comes, "[CDEDIT-CASCADE] Updated 4 pipes and 3 pits from P3 (IL 17.50). Min grade: 1:16." prints, the invert texts match R11v87's after-cascade set, neither new line ("The downstream levels were not recalculated", "The downstream recalculation could not be completed") prints, and one U puts every invert text and the object count back.
5. **The twin W658_BROKEN:** answers No to Recalculate. It goes red on the "Updated 4 pipes" line with every window closed. It is a guard twin, not a switch-off twin.
6. **Honest limit, from the reviewer:** W658 would also pass on a build without #1972, because R11v87 passed on 3.0.88 before the fix existed. The review required the case line "PROVES_BUGS BUG-658" to be emptied so it cannot accept BUG-658; the file I read has it empty. So the robot proves "nothing regressed and one Undo still takes everything back" and nothing more. BUG-658 itself needs the look below.
7. **Look LB-B1-17 (Codex, copies only). What Codex must SEE:**
   1. Open a copy of the made-up drawing used for R11v87. Note the object count. Open Edit Pipe on P3, change the downstream level (17.60 and 17.50), Save.
   2. When the "Recalculate downstream pipe inverts?" box appears, DO NOT answer yet. Move or read what is behind it. Take a picture. With the switch ON, the drawing behind the box already shows P3 at the new levels.
   3. Answer Yes, press Apply in Cascade Preview. Read the command line for "Updated 4 pipes ...". Take a picture. One U. Object count and every invert text as before.
   4. Control: close AutoCAD, type `cascadeQuestionAfterEditCommits` = false in a test copy of the settings, start again, repeat 1 and 2. Right = with the switch OFF the box comes before the change is visible. Needs CE 00's GO.
   5. A refused save: the PR's example is a locked label layer, but the writer found CE's locked-layer rules mostly skip the write and say so, and do not roll the save back. So Codex must first find a refusal that really rolls back. If none can be found, say so. Do not fake it.
8. **Right looks like (look):** ON, the new levels are already on the drawing behind the box; OFF, they are not. In every case, one U takes back the edit and the cascade together.
9. **Wrong looks like:** the box ahead of the visible change with the switch ON; "Updated N pipes" printed after a refused save; two U needed; any layer unlocked by CE (it must not be).
10. **Evidence pictures:** the drawing behind the box (ON); the same with OFF; the command line after Apply; the object count after the U.
11. **Not proven:** nothing in AutoCAD. The order of a window against the drawing change is exactly what no unit test shows. The REGRESSION_LOG itself calls this a DRAFT that needs a real AutoCAD look. The robot cannot read the order because the Recalculate box is a native box and COM is blocked while it is up.
12. **Headless:** no. It uses the Edit Pipe window, a native message box and Cascade Preview.

---

## LOOK LB-B1-18: #1923, DOUBLE-CLICK ON A PIT LABEL OPENS EDIT PIT, NOT AUTOCAD'S ATTRIBUTE EDITOR (BUG-430, head 454e3eab), SHIPS OFF

1. **What it fixes:** with the pit double-click feature on, double-clicking the P8 pit label opened AutoCAD's Enhanced Attribute Editor, not CE's Edit Pit (Codex looks on 3.0.54 and 3.0.56, and still reported failing on 3.0.88 in the proof-lane count). Now a linked pit label gets the same stop as the downpipe: CE refuses AutoCAD's lock for that editor, registers the pit for CDEDIT and starts Edit Pit. A pit label inside a surrounding frame or Xref plan is now treated as one block instead of two.
2. **Switches:** `doubleClick.pitLabelStopsAttributeEditorFirst` ships OFF (changed from ON on 1 Nov; Tim ruled on 22 Oct it stays OFF until Codex has looked). It also acts only while `doubleClick.opensEditWindow` is ON, and that ships OFF. So **on the installed settings #1923 changes nothing at all.** Commit 4445c243 pins both defaults.
3. **Why a look, not the robot alone:** the drafter must see WHICH window opens. A robot case N95_pitlabel_dblclick and its control are proposed in the REGRESSION_LOG; no such file exists (NOT FOUND). The nearest robot work is the downpipe family: N42 and R09s drafts (double-click on a downpipe stops the editor first). Those do not cover a pit label.
4. **Steps (Codex, copies only, after 5:30 pm):**
   1. Close AutoCAD. In a TEST COPY of the settings (never Tim's real file) type `opensEditWindow` = true and `pitLabelStopsAttributeEditorFirst` = true. Start AutoCAD with 3.0.90.
   2. Open a copy of a made-up drawing with pits (P8 as in the earlier looks). Note the object count.
   3. Double-click the P8 pit label. Take a picture of the window that opens.
   4. Cancel or close it. Confirm the drawing is unchanged (object count the same).
   5. Double-click a pit label inside a frame or an Xref plan, if the drawing has one. Take a picture.
   6. Double-click a pit label that is on a locked layer, and one inside an Xref. Take a picture of each.
   7. Control: close AutoCAD, set `pitLabelStopsAttributeEditorFirst` = false, keep `opensEditWindow` = true, start again, repeat 3. Expect AutoCAD's own editor, as before.
5. **Right looks like:** switch ON, step 3 opens CE's Edit Pit for the pit named on the label, and AutoCAD's editor does not appear first. Step 5 opens Edit Pit. Step 6: a label on a locked layer and a label that is Xref content keep AutoCAD's own answer. Control: AutoCAD's Enhanced Attribute Editor opens.
6. **Wrong looks like:** AutoCAD's editor opening first with the switch ON; Edit Pit opening for the wrong pit; a change to the drawing from just double-clicking; a locked layer unlocked or an Xref label edited (CE must never do this); a double-click on a pit, a downpipe or a second label under the pointer behaving differently (those must stay as before).
7. **Evidence pictures:** the window after double-click, ON (one); frame or Xref case (one each); the locked and Xref cases (one each); the control (one).
8. **Not proven:** nothing in AutoCAD, and the cause in the REGRESSION_LOG is "read from code; not seen in a pit-label run on 3.0.88". Whether this fix really closes AutoCAD's editor before it opens is exactly what the look decides. Tim's own words stay: the double-click feature stays OFF until Codex has looked. This look is that look. Whether to flip `opensEditWindow` ON is Tim's call, not Claude's.
9. **If it cannot be arranged:** record NOT TESTED. Nothing changes on a normal install while both switches are OFF.

---

## SKIPPED ITEMS AND WHY

1. **#1958 (BUG-1266):** no look of its own. Only a log line changes, and it needs a drawing opened with a damaged saved list, which does not exist as a fixture. Logic evidence only.
2. **#1970 (BUG-1157):** no look possible. The only trigger is a pipe with a damaged record, which needs typed Lisp the robot refuses. Logic evidence only.
3. **No PR in this part is fully proven by the robot.** Only #1972 has a robot case, and the review said it cannot accept BUG-658 alone. I found no PR in this part the robot proves completely, so none is skipped on that ground.
4. **Conditional looks that may end NOT TESTED:** LB-B1-13 (#1955, needs two open drawings), LB-B1-15 (#1969, needs a comma-region PC), LB-B1-18 (#1923, needs two test switches in a copy of the settings). Each says what is missing.
5. **Not written again here:** positions 1 to 12 are in Parts 1 and 2 (#1953 is in Part 2 and pairs with #1955 for one Codex session).
6. **Open question I did not turn into a decision:** whether a failed Edit Pipe level write (#1970) should also stop the save. The PR's own text says that is an engineering choice and was not made.
