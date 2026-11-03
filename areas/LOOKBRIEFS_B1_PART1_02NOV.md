# Look briefs for the b1 train (Civil 3.0.90, candidate c1076), part 1: PRs 1 to 6

Written Mon 2 Nov 2026 (Melbourne) by Sonnet, Team, read-only drafting. Nothing was built, tested, installed or run. No AutoCAD was opened. No code, setting, drawing or git state was changed. Only this file was written. The order gave the folder as `C:\CE_PLANreas\`; that looks like a typo for `C:\CE_PLAN\areas\`, so this file is in `areas`. Please say if it should move.

---

## FOR TIM

1. **Answer:** of the first 6 PRs, only 2 are worth a look by eye after the install. #1891 (a copied downpipe gets its own tag) needs a short look at what the robot cannot see. #1868 (big-pipe minimum fall) needs a look, but only if you or CE 00 agree to set one test figure first.
2. **Nothing to look at:** #1922 (it changes Structural test code only and is not in any shipped file).
3. **Already briefed in another file:** #1892 (one damaged pit record) and #1940 (damaged outlet roles). Their looks are in `LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md`. I did not write them again; this file says only what each leaves unproven.
4. **Cannot be looked at yet:** #1943 (unreadable LPD record). Nobody can make a drawing with a damaged LPD record today, so it stays proven by calculation only until that drawing exists.
5. **Important plain fact:** if you do nothing after the install, #1868 changes nothing on your drawings. The big-pipe minimum fall ships blank, and blank means no change.
6. **Nothing here needs your time.** Each look is for Codex or the robot, after 5:30 pm, copies only.
7. **What I did not prove:** every statement about what AutoCAD will show comes from reading the code and the earlier reports. None of it has been seen on 3.0.90.
8. **Needs a GO:** one item. #1868's look needs a test settings copy with one figure typed in (`designStandards.largeGravityMinGradeN` = 200). That is a settings change, so it needs CE 00's word.

---

## WHAT WAS READ, BUILT, TESTED, NOT PROVEN

1. **Read:** `C:\TimOS\RULES.md`; `git fetch origin` first (done, Mon 2 Nov); the 18 merge commits `61fd6fbc..cf059dcf` on `origin/claude/rel-20261108a`; the merge diffs and rule files of PRs 1 to 6; the REGRESSION_LOG entries for them; BUILD_REGISTER items 267 to 272; `spec_c79b1_smoke.txt`; `C79B1_AREA_TEST_PLAN_01NOV.md`, `C79B1_WRITING_W1_REPORT.md`, `C79B1_WRITING_W2_REPORT.md`, `C79B1_REVIEW_REPORT.md`; `CODEX_LOOKS_PLAN_C78_C79_01NOV.md`; `LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md` (the HUBC and EDTC parts); the style of `LOOKBRIEF_LANEB_PART1_02NOV.md`.
2. **Built:** nothing. **Tested:** nothing. **Installed:** nothing by me.
3. **Authority check:** installed is Civil 3.0.89 = commit 61fd6fbc. I checked each of the six PR heads against it with `git merge-base --is-ancestor`: none is in 3.0.89, all six are in cf059dcf (c1076). `origin/claude/rel-20261108a` is at cf059dcf (checked after the fetch). `rel-20261110a` (b2) does not exist on origin yet.
4. **Not proven:** none of the six has been opened in AutoCAD on any build. The robot cases for #1891 and #1892 are written but not yet run on 3.0.90 (the smoke list puts them in the b1 packs after the install).
5. **I could not read:** the PR descriptions on GitHub (the `gh` tool is not on this machine's path). I used the merge diffs and REGRESSION_LOG instead. The robot's reports name the heads: #1868 38c3f825, #1891 4f21fc9d, #1892 9545489c, #1940 c55494e0, #1943 62c8f363, #1922 7a3238a7. All six heads are inside the c1076 build.

---

## THE SIX PRs, IN MERGE ORDER

1. **#1922** BUG-1257, Structural test projects only. No look.
2. **#1868** BUG-1091, big pipes (450 mm and over) in Civil Design, auto-design and the network redesign hold the same minimum fall as Edit Pipe and CDRULES. Look LB-B1-01.
3. **#1891** BUG-1246, a copied downpipe gets its own next tag and its own label, and no label on a locked layer. Robot case W1246 plus look LB-B1-02.
4. **#1892** BUG-1141, one unreadable pit or pipe record no longer stops CE remembering every other pit's links. Robot W1892 plus the EDTC look already briefed.
5. **#1940** BUG-1144, damaged saved outlet roles: one warning, a kept copy, Apply carries on. HUBC-02 already briefed.
6. **#1943** BUG-1153, unreadable LPD record: one warning, Apply carries on. Look LB-B1-06, conditional.

---

## LOOK LB-B1-01: #1868, A 450 PIPE IS NOT PROPOSED FLATTER THAN THE MINIMUM FALL (BUG-1091, head 38c3f825)

1. **What to look at:** when Civil Design, the network redesign or the Edit Pipe grade suggestion proposes a fall for a pipe of 450 mm or larger, it must now respect the big-pipe minimum fall row. Before the fix those screens only read the 90 to 375 rows, so a 450 could be proposed at about 1 in 890 while Edit Pipe held it to 1 in 200.
2. **Why this look is conditional (plain):** the big-pipe row ships blank. Blank means "no minimum fall set for this size" and nothing changes. So on a normal install there is nothing to see. The row has no Settings window box in this build. It is a settings-file value only. The look runs only on a test copy of the settings with `designStandards.largeGravityMinGradeN` typed as 200 before AutoCAD starts (CE reads settings at start). This needs CE 00's GO. Do not touch Tim's real settings file.
3. **Switch:** `pipe.largePipeRedesignReadsMinFall`, ships ON. OFF gives the old behaviour.
4. **Steps (a drafter route):**
   1. Start AutoCAD with the test settings copy (row = 200, switch ON). Open a copy of the DRV1_B1 drawing. Note the object count.
   2. Run CDCHECK or CDRULES once and read the line for big pipes. Expected: it names a minimum fall of 1 in 200 for pipes of 450 mm and over. If it says "no minimum fall set for gravity pipes of 450 mm and larger (not warned)", the row did not load: stop, the look is NOT TESTED.
   3. Run the network redesign (CDHUB, then "Network redesign") on a drawing where a 450 pipe is carrying a flow that makes the solver pick a 450. NOT FOUND: a fixture that does this. The earlier robot note says Civil Design picks sizes freely, so 30 L/s never gives a 450. Use the redesign keeping existing sizes, on a short 450 (4.1 m) and a long 450 (30 m).
   4. Read the grade the redesign proposes for each 450. Take a picture of the proposal.
   5. Close with Esc. Never press Apply. Object count must equal step 1.
   6. Control: close AutoCAD, type `pipe.largePipeRedesignReadsMinFall` = false in the test copy, start again, repeat steps 3 and 4.
5. **Right looks like:** with the switch ON the proposed fall on every 450 is 1 in 200 or steeper (a short pipe may round to about 1 in 137 and is then flagged by the existing Grade mismatch window, which is expected here, not a fault; the register item 74 says this PR needs #1873, which is already in 3.0.89). With the switch OFF the proposal can be flatter than 1 in 200 (about 1 in 890 in the earlier report).
6. **Wrong looks like:** ON still proposes flatter than 1 in 200; any grade or level actually written to the drawing during the look; a 300 or 375 pipe changing its proposal; a blank row (switch ON) changing anything at all.
7. **Expect side effects, do not call them faults:** a steeper big pipe lifts everything above it, so more COVER warnings appear on a flat site (Opus review K).
8. **Evidence pictures:** the CDRULES or CDCHECK line for big pipes (one picture); the proposal for the short 450 and for the long 450 with the switch ON (two pictures); the same two with the switch OFF (two pictures).
9. **What the robot cannot do:** the robot has no case for #1868. The first writer's reason: the fix changes only the grade proposed inside windows, and it prints no command-line line. The Opus review accepts the unit tests as logic evidence (31 tests). The proposal on screen still needs a look.
10. **Not proven:** nothing in AutoCAD. Odd sizes (400, 1000) still read differently in the redesign and in CDRULES (register item 74).
11. **If the GO is refused:** record NOT TESTED, NO GO. #1868 then rests on the unit tests alone, and Tim sees no change on his drawings anyway.

---

## ROBOT CASE W1246 AND LOOK LB-B1-02: #1891, A COPIED DOWNPIPE GETS ITS OWN TAG (BUG-1246, head 4f21fc9d)

1. **What the robot already covers:** case W1246 and its twin W1246_BROKEN (switch OFF) are written and READY TO RUN (review item 2.1). They are in the b1 smoke spec (`bmW1246`, `bmW1246b`). The robot reads the two CE command-line lines, that the old "could not be given its own link" line does not appear, and the downpipe and GUIDELINES text counts. It has not run on 3.0.90 yet. So the PR is NOT skipped; the robot proves the words and counts only.
2. **What the robot cannot see (the look):** where the copy's label sits, that the schedule or Inspector shows each tag once, and that the locked layer is still locked afterwards. These are the items the W1246 case lists for Codex.
3. **Switch:** `linking.copiedDownpipeGetsOwnTag`, ships ON. Run after the robot's W1246 has run, on the 3.0.90 install, copies only.
4. **Steps (a drafter route), in a copy of the DRV1_B1 drawing:**
   1. Note the object count. Place one downpipe with the DP command at an empty spot (the robot uses 150000,-80000). It becomes DP1 with a label.
   2. Select only that downpipe. Run CR (Copy and Rotate). Pick a base point, a second point 6 m to the right, rotate 90 degrees. This is Tim's hand check H39 route on 3.0.85.
   3. Read the command line. Take a picture of the plan around the copy and of the command line.
   4. Lock the label layer (the robot reads it as GUIDELINES; copy the real name from the first label's layer). Select the original again. Run CR again to a new spot 5 m above.
   5. Read the command line again. Take a picture of the plan and the command line.
   6. Open the pit and pipe schedule or the Inspector and read the downpipe tags. Take a picture.
   7. Unlock nothing. Type U for each copy. The copies go and the layer stays locked. Object count back to step 1.
5. **Right looks like:**
   1. First copy: the line "[CE] The copied downpipe was given its own tag DP2 (the original stays DP1). Check where it connects." The copy has its own label beside it.
   2. Second copy with the layer locked: the line "[CE] The copied downpipe was given its own tag DP3 (the original stays DP1)..." and a second line "[CE] The label for DP3 was not drawn because layer GUIDELINES is locked. CE has not changed the layer; unlock it and the label can be added." No new label for DP3.
   3. The tags read DP1, DP2, DP3, each once. GUIDELINES is still locked. The real layer name and tag numbers win over these words.
6. **Wrong looks like:** two downpipes with the same tag (two DP1); the old line "could not be given its own link"; a label drawn on the locked layer; the layer unlocked by CE; an error window; the copy labelled on the wrong side of the pipe.
7. **If CR now completes the copy in full:** neither line appears. That is a FINDING, not a wrong result: write it down and report the tags that were given.
8. **Control:** the robot's twin (switch OFF) must show the old line and the original's tag on the copy. No separate look is needed for it.
9. **Evidence pictures:** four: plan and command line after copy one; plan and command line after copy two (locked layer); the schedule or Inspector tags; the layer list showing GUIDELINES still locked.
10. **Not proven:** nothing seen in AutoCAD. The next free tags being DP2 and DP3 and the label layer being GUIDELINES are the robot writer's derived readings, not seen.

---

## #1892, ONE DAMAGED PIT RECORD: BRIEFED ELSEWHERE (BUG-1141, head 9545489c)

1. **Where:** `LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md`, Brief 2 (EDTC), pit MOVE looks run twice.
2. **What the robot covers:** cases W1892 and W1892_BROKEN are written and are in the b1 smoke spec (`bmW1892`, `bmW1892b`). On the 3.0.88 build both failed on exactly the three fix checks, as expected without the fix. The robot reads the one named line, the one log line and that the damaged record is still damaged afterwards.
3. **Left for the look:** that after MOVE of pit P2 up 2 m its pipe end follows, and that pit P3 (the one with the damaged record) is not dragged. The robot cannot read a pipe object's points.
4. **Words to expect in the command line:** "[CE] The CE link record on one pit (drawing handle 109D56, at ...) could not be read, so CE skipped it and loaded the rest. That pit may not drag its pipes when it is moved; its record has been left as it is."
5. **Gap:** the EDTC look needs the made-up drawing `EDTC_LINKDMG` (name proposed, file NOT FOUND). Without it the look is a baseline MOVE on a healthy drawing, which does not prove the fix.

---

## #1940, DAMAGED OUTLET ROLES: BRIEFED ELSEWHERE (BUG-1144, head c55494e0)

1. **Where:** `LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md`, Brief 1, look HUBC-02 (with HUBC-03 for Undo and Esc, HUBC-05 as the switch-off control).
2. **What the robot covers:** nothing. No case exists. The robot cannot write the outlet-roles record and cannot press the Civil Hub buttons.
3. **Words to expect after Apply in the Civil Hub box:** "Warning: the outlet roles saved in this drawing at the last redesign could not be read, so the check of the nominated outlets against them was skipped. CE kept a copy of the damaged record in this drawing (CE_CVL_NETWORK_REDESIGN, OUTLET_ROLES_DAMAGED_COPY) before writing the new roles." If no copy could be made it says "No copy of the damaged record was kept, because CE could not make one." instead.
4. **Switches:** `linking.redesignApplyNoticesDamagedOutletRoles` ships ON. `linking.redesignApplyStopsOnDamagedOutletRoles` ships OFF; ON stops Apply with one line and writes nothing.
5. **Gap:** the look needs the made-up drawing `HUBC_FIX` (name proposed, file NOT FOUND) and a decision from CE 00 on how to make it. The Opus review said NO to the unit evidence alone for this PR, because it writes a kept copy into the drawing.

---

## LOOK LB-B1-06: #1943, UNREADABLE LPD RECORD GIVES ONE WARNING (BUG-1153, head 62c8f363), CONDITIONAL

1. **What to look at:** when a network redesign is applied on a drawing whose legal point of discharge (CDLPD) record is there but cannot be read, Apply must give one plain warning and carry on. Before, it treated the record as "no LPD" and skipped the protection that keeps a Fixed outlet where it is, without a word.
2. **Why conditional:** a drawing with a damaged LPD record does not exist, and the driver cannot make one. The record-set verb covers only the pit link record and the project record. The Opus review accepted the unit tests as logic evidence for this PR (the warning shows only in the redesign Apply result; Apply never writes the LPD record). So this is not a required look. It is a free extra only if the HUBC fixture session can also carry an LPD damaged drawing.
3. **Words to expect after Apply:** "Warning: this drawing has a legal point of discharge (CDLPD) record that CE cannot read, so the check that keeps a Fixed outlet where it is was skipped. Apply does not change the CDLPD record. Open CDLPD to check or re-confirm the outlet." The full sentence continues; copy the real words.
4. **Switches:** `linking.redesignApplyNoticesUnreadableLpd` ships ON. `linking.redesignApplyStopsOnUnreadableLpd` ships OFF.
5. **Steps (only if a drawing with an unreadable LPD record is made available):** follow HUBC-02 exactly (CDHUB, Network redesign, the buttons the fixture note lists, Apply), then read the box. Never press Confirm LPD in CDDESIGN or CDLPD on that drawing.
6. **Right looks like:** one warning sentence about the LPD record, "Redesign applied" still shown, the drawing changed as the preview said, the LPD record untouched.
7. **Wrong looks like:** no warning at all (the old fault); the warning twice; Apply stopped while the stop switch is OFF; any change to the LPD record.
8. **Evidence pictures:** the Information box after Apply; the command line or log line "CV-01H4 apply: Warning" if the log can be read.
9. **If no such drawing exists:** record NOT TESTED, NO FIXTURE. Do not fake the damage by hand.
10. **Not proven:** nothing in AutoCAD. Whether a drawing with a damaged LPD record reads as "unreadable" in a real AutoCAD session is derived from the review, not seen.

---

## SKIPPED ITEMS AND WHY

1. **#1922 (BUG-1257, B-099):** it adds a log-folder redirect to Structural code and test projects (16 files, plus `Modules/TestSupport/RealFolderWatch.cs`). Nothing changes in a drawing and no setting is added. The register says it must not appear in any shipped bundle file; the c1076 build lists the same 832 Civil paths as 3.0.89, so a look would show nothing. The 30-minute settings-fingerprint check before and after the run covers it. Not skipped for the finalizer: the finalizer states that no shipped DLL behaviour changes.
2. **#1892 and #1940:** not written again, because `LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md` already holds their full looks. See the two short sections above for what each leaves unproven.
3. **No PR in this part is fully proven by the robot.** #1891 and #1892 are the nearest, and each keeps a look for what the robot cannot read.
4. **Possible later route for #1868, not written:** a draw-first CD of a 450 between two pits might let the robot read the suggested levels from the drawn pipe. The writer judged it too uncertain to spend three runs on (it may open the Grade mismatch window).
