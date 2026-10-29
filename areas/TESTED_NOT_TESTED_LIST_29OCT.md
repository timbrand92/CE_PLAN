# Tested / not tested list for the colleague release note (Thu 29 Oct 2026)

CE_ACAD / robot / plan / 22. CE 02 Robot and Codex Testing, Team Sonnet headless job. Written about 13:15 to 14:00 Melbourne (PC clock read at 13:12). Nothing was started in AutoCAD, nothing was built or installed, no case was run. Every line is read from the files named at the end. Where a file does not say, the line says UNKNOWN. I did not re-judge any case; reviewers are quoted.

**How to read an entry.** Status is one of TESTED, TESTED IN PART (the part is named) or NOT TESTED (the reason is named). Who is one of: robot (Claude-accepted: two AutoCAD starts plus a failing twin plus an independent review), Codex look (real AutoCAD, screenshots), Tim by hand, or not tested. Build is the Civil / Manager / Structural build the evidence is on. The installed build today is Civil 3.0.85 / Manager 1.1.85 / Structural 1.0.125 (taken from the ledger; I did not read the DLL version strings).

---

## ANSWER FIRST

1. **Everyday tools (A): 21 tested, 12 tested in part, 5 not tested** (38 lines; the plan says 40 but names only 38). The 21 include Tim's own hand passes of D10 and D30 (made after the everyday file was written) and the three PIT / CD lines the plan lists separately. CE 00's count of 19 includes two that I list as in part (D04 Esc half only; Tidy labels with the switch ON only), so the two counts differ on purpose.
2. **Pilot-critical bugs (B): 0 tested, 0 in part, 60 not tested.** Two draft robot cases exist (BUG-1194 and BUG-1140) and have never run. 26 fixes are installed on Tim's PC; none has been tested.
3. **Gate items and hand checks (C): 58 entries. 26 tested (passed), 1 tested and failed, 16 in part, 15 not tested.** Gate list alone: 0 whole, 1 in part (administrator set-up on Tim's PC, seen by Codex), 10 not tested.
4. **What the colleague note can honestly say today:** the everyday drawing tools (placing pits and pipes, copy, erase, explode, move, renumber, undo names, short-pipe labels) have been tested in AutoCAD by the robot and, for most, by Tim by hand. It cannot say any pilot-critical bug fix has been tested, and it cannot say the update route, roll back, the privacy switches, the blue colour removal or another PC's install have been tested.

---

## FOR TIM

1. **Where it stands.** About half the everyday tools are properly tested (21 of 38). The 60 pilot-critical bug fixes are all untested: no robot case can reach 24 of the 26 installed ones without a test drawing, a second login or an older AutoCAD.
2. **What the colleague note can say.** "The everyday drawing tools were tested in AutoCAD on build 3.0.85 by the robot and by Tim." It must NOT say "the known bugs are fixed and tested". Say "fixes are installed; testing is in progress".
3. **The honest gaps, in order of what would hurt a colleague first:**
   1. **Pipe window recent buttons (D05).** You said "no": the recent diameter, material and invert buttons are not on the main New Pipe page. Fix running, untested.
   2. **Hide grade (D06).** The tickbox exists but is under More... and you do not like where it is. Not yet turned off and checked on a placed pipe.
   3. **Existing and demolished layers (D25).** Not built, no test.
   4. **A long Pit Schedule on the next sheet (D22) and the check-drawing summary window (D28).** Codex could not finish D22; D28 had a real fault seen.
   5. **All 60 pilot-critical fixes.** Example: the "AT 1 IN 100" invented on an imported pipe (BUG-1188) is fixed in the build but nobody has run it.
   6. **Gate list.** Roll Back hidden, update route, old scripts, fault report coding, millimetre imports, no blue, nothing sent off the PC, the privacy pass: none tested.
4. **What you need to do for this list:** nothing. One answer from you would turn entries green: D13 (does a label you dragged ride with its pipe end when the pit moves; I recommend ride along). BUG-905 and BUG-1097 are no longer waiting on you: you answered both on 29 Oct (0.9 hard-ground ON; the 300 mm rule uses the head left after pipe losses); they are builds to prove by Codex looks H1 and H7 once CE 01 installs them.

---

# A. THE EVERYDAY TOOLS (38 named; 21 tested, 12 in part, 5 not tested)

Source: `EVERYDAY_TOOLS_STATUS_29OCT.md` (written 11:20 to 11:50), updated with Tim's later hand checks H10 to H19 in `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md`. Where the later hand check changes a line, the line says so.

1. **PIT keeps placing until Esc (named check; D01 pit half): you place pit after pit without retyping PIT, Esc stops it.** **Status:** TESTED. **What was tested:** pit placed, next pit offered, Esc ends, placed pit stays. **Build:** robot 3.0.84 (R01, R05; 3.0.85 re-run owed, tester_run77); Tim by hand 3.0.85. **Date:** robot 28 Oct; Tim 29 Oct about 10:10. **Who:** robot and Tim by hand. Note: Tim says PIT is slow to start (BUG-1228 family).
2. **CD keeps placing pipes until Esc (named check; D01 pipe half).** **Status:** TESTED. **What was tested:** first pipe placed, prompt for the next, Esc says "CD command cancelled", the placed pipe stays. **Build:** robot 3.0.84 (R01; 3.0.85 re-run owed); Tim 3.0.85. **Date:** 29 Oct about 10:15. **Who:** robot and Tim by hand.
3. **Erasing a pit leaves its pipes, one U brings it back (D14).** **Status:** TESTED. **What was tested:** erase a pit with one pipe, and with six pipes; schedule updates; one U restores. **Build:** robot 3.0.84 and 3.0.85 (R19b, R19); Tim 3.0.85. **Date:** robot 28 to 29 Oct; Tim 29 Oct about 10:40. **Who:** robot and Tim by hand. Open: BUG-1231 (eight "C1 not updated" lines after the useful sentence).
4. **Copying a pit gives it its own number and says to check levels (D15).** **Status:** TESTED. **What was tested:** plain COPY of a pit: new number, original untouched, U takes it back. **Build:** robot 3.0.85 (N16, R34a, whole; Codex second review cx_cr23 agrees); Tim 3.0.85. **Date:** 29 Oct, Tim about 10:50. **Who:** robot and Tim by hand. A Codex look at the picture (G6, Friday) is not done.
5. **Exploding a pit (D16): the pit becomes plain lines and leaves the schedule, pipes stay, U brings it back.** **Status:** TESTED. **What was tested:** pit with a pipe and a pit with no pipes. **Build:** robot 3.0.84 and 3.0.85 (N02, N22); Tim 3.0.85. **Date:** 28 to 29 Oct; Tim about 10:30. **Who:** robot and Tim by hand. Open: BUG-1231.
6. **Recover Inverts (spec card C38): it puts invert levels back on the pipes and says how many it recovered and skipped.** **Status:** TESTED. **What was tested:** totals add up (Tim's drawing: 22 recovered, 29 skipped, 51 pipes). **Build:** robot 3.0.72 onward (R15, holds on every regrade); Tim 3.0.85. **Date:** robot 24 Oct; Tim 29 Oct about 10:20. **Who:** robot and Tim by hand. Not hand-checked: the one-end-only warning line.
7. **Every CE step has a plain name in the Undo list (D19).** **Status:** TESTED. **What was tested:** U after PIT echoes PIT; the robot checks the other steps. **Build:** robot 3.0.83 on (N07, N17, N18). **Date:** 28 Oct onward. **Who:** robot; Tim by hand for the PIT half only. Tim's MOVE check typed U and the pit came back but his command line was not pasted, so the word MOVE itself is not in the record.
8. **One invert level text at each pipe end (D12).** **Status:** TESTED. **What was tested:** each pipe end shows one IL text. **Build:** robot 3.0.84 (R03; 3.0.85 re-run owed); Tim 3.0.85. **Date:** robot 28 Oct; Tim 29 Oct about 12:55. **Who:** robot and Tim by hand.
9. **CDEDIT keeps your selection (D17).** **Status:** TESTED. **What was tested:** selection is as it was after the edit. **Build:** robot 3.0.85 (R20). **Date:** 29 Oct; Tim 29 Oct about 13:15. **Who:** robot and Tim by hand.
10. **Esc at the third point of CD draws nothing (D04).** **Status:** TESTED IN PART: the Esc half only. **What was tested:** Esc at the third point draws nothing. **Not tested:** "Enter gives the straight pipe" half. **Build:** robot 3.0.84 (R17; 3.0.85 re-run owed). **Date:** 28 Oct. **Who:** robot. (CE 00 counts it among the 19; here it is part.)
11. **A new pipe started on a pit joins it (D03).** **Status:** TESTED. **What was tested:** the pipe joins the pit, the schedule shows it. **Build:** robot 3.0.84 (R02, R02b; 3.0.85 re-run owed); Tim 3.0.85. **Date:** robot 28 Oct; Tim 29 Oct about 12:55 ("Flow: Open end -> P1"). **Who:** robot and Tim by hand.
12. **CE never saves the drawing (D18).** **Status:** TESTED. **What was tested:** CDREBUILD and CDSYNC finish without saving (robot). **Build:** robot 3.0.83 on (N01, R04; 3.0.85 re-run of R04 owed). **Date:** 28 Oct. **Who:** robot. Tim's hand check was on an unsaved new drawing, so it did not show "does not save".
13. **CDSYNC and CDREBUILD warn first (D27).** **Status:** TESTED. **What was tested:** the warning prints first, counts match. **Build:** robot 3.0.83 on (N01, R13); Codex D4-01 and D4-02 on 3.0.77; Tim 3.0.85. **Date:** robot 28 Oct; Codex 25 Oct; Tim 29 Oct about 12:10. **Who:** robot, Codex look and Tim by hand. U was not hand-tested.
14. **CDSYNC keeps the schedule (named check C42).** **Status:** TESTED. **What was tested:** after a cascade the schedule values are kept. **Build:** robot 3.0.85 (N26; Codex second review cx_cr23 agrees). **Date:** 29 Oct. **Who:** robot. BUG-855 (data issues count goes up by one) stays open.
15. **Outfall and floor-waste overflow symbols share one symbol with their own tags (D08).** **Status:** TESTED. **What was tested:** OF and FO place, tags OF1 and FO1, prompts, Esc. **Build:** robot 3.0.83 (N03); Codex D7-02 on 3.0.78; Tim 3.0.85. **Date:** 28 Oct; Tim 29 Oct about 12:20. **Who:** robot, Codex look, Tim by hand. Tim did NOT pass it: he saw the FO symbol reads "OF" (BUG-1236; the card says one symbol by design, so it is a card-versus-Tim question).
16. **Pit number and cover level label (D09).** **Status:** TESTED. **What was tested:** the label lands on the click, cover text reads CL 19.000, one U removes all three. **Build:** robot 3.0.85 (N25; Codex second review agrees: about 0.1 mm from the click). **Date:** 29 Oct; Tim 29 Oct about 12:55 ("P1 and CL 19.50", yes). **Who:** robot and Tim by hand.
17. **Short pipe label on a leader (D11).** **Status:** TESTED. **What was tested:** a 2 m pipe gets one leader, "100 DIA. UPVC PIPE" then "AT 1 IN 200", arrow tip on the pipe, clear of the IL texts. **Build:** robot 3.0.83 (N20); Codex G1-01 on 3.0.84. **Date:** 28 Oct. **Who:** robot and Codex look ("PASS, SURE").
18. **CDRENUMBER numbers pits from the outlet up (D20).** **Status:** TESTED. **What was tested:** preview shows P9 becoming P8 and P10 becoming P9; Yes changes both; U restores. **Build:** robot 3.0.83 (N15); Codex G2-01 on 3.0.84; Tim 3.0.85. **Date:** 28 Oct; Tim 29 Oct about 12:45. **Who:** robot, Codex look, Tim by hand (Yes path and its U; the No path result was not given). Not judged: whether the numbering order is the right engineering order. That is Tim's call.
19. **A pit catches a pipe end within 100 mm (D02).** **Status:** TESTED. **What was tested:** a pipe end 90 mm outside the wall is pulled to the inside wall; one 110 mm outside is left free. **Build:** robot 3.0.85 (N23; Codex review cx_cr23 agrees, checks 90 and 110 mm, not a literal 100 mm); Tim 3.0.85. **Date:** 29 Oct; Tim about 11:50. **Who:** robot and Tim by hand. Tim's first attempt (about 11:30) was not a valid test and is superseded.
20. **Selecting a pipe or pit brings its ribbon tab forward (D30).** **Status:** TESTED. **What was tested:** Tim's word "d30 - pass". **Build:** Tim 3.0.85. **Date:** 29 Oct about 13:30. **Who:** Tim by hand. Earlier Codex D8-04 was DIFFERENT (Esc went back to the tab that was active before; probably a wrong brief). No robot case.
21. **The pipe label reads along the pipe, the right way up (D10).** **Status:** TESTED. **What was tested:** Tim looked at his own drawing: the label sits along the pipe and reads like "100 DIA. UPVC PIPE AT 1 IN 200" (his word: yes). **Build:** Tim 3.0.85. **Date:** 29 Oct about 12:55. **Who:** Tim by hand. The robot cannot read text angle (R18 exists but Codex review cx_cr04 says direction is not established). Only one drawing seen; the arrow clash on the lower pipe is BUG-1234.
22. **Tidy labels names the pipe (spec card C37).** **Status:** TESTED IN PART: switch ON only. **What was tested:** with the Tidy labels switch ON the tidy-up names the pipe. **Not tested:** the default. Tim's file has the switch OFF; he said yes on 29 Oct to making ON the default (not yet built). **Build:** robot 3.0.73 and 3.0.75 (R16; 3.0.85 re-run owed). **Date:** 24 Oct. **Who:** robot.
23. **CDTWL freeboard warns at the 200 mm you set, not 150 (named check C39).** **Status:** TESTED IN PART: the whole claim passed on 3.0.84 only. **What was tested:** R14 and three R14h cases, Opus "whole, hash-matched", two passes on 3.0.84. **Not tested:** the 3.0.85 re-run (first in tonight's queue); what happens when the two freeboard settings disagree. **Build:** 3.0.84 (3.0.85 owed). **Date:** 27 to 28 Oct. **Who:** robot.
24. **Office layers and the current layer are kept (D24).** **Status:** TESTED IN PART. **What was tested:** all five Esc endings (N28, Opus part; Codex review agrees part); Tim answered yes from his own use (13:10). **Not tested:** every new object on its layer (N32 drafted, reviewer says sound, not run); "never recolour an existing layer" is not built. **Build:** robot 3.0.85. **Date:** 29 Oct. **Who:** robot and Tim by hand (his yes).
25. **Pit Schedule groups and natural order (D21): LPD, OG, P1 to P10, CP2, CP10, then C1.** **Status:** TESTED IN PART. **What was tested:** P7 P8 P9 P10 then C1 (N29, part); Tim yes from his own use. **Not tested:** the LPD, OG and CP order (N33 drafted, not run); natural order with the switch ON (N34 judged WEAK). Tim's file has natural order OFF. **Build:** robot 3.0.85. **Date:** 29 Oct. **Who:** robot and Tim by hand (his yes).
26. **Quick MOVE of a pit takes its labels and joined pipes with it, one U puts everything back (named check C41).** **Status:** TESTED IN PART. **What was tested:** the labels go with the pit (R12 part); Codex D3-02 PASS; Tim moved P1 by 0,2000 and typed U once ("passed", H10). **Not tested:** four IL texts after the U; label direction; a hand-placed label after the pit moves. **Build:** robot 3.0.84 and 3.0.85; Codex 3.0.75; Tim 3.0.85. **Date:** 25 to 29 Oct. **Who:** robot, Codex look and Tim by hand.
27. **Edit Pipe cascade with U and REDO (named check).** **Status:** TESTED IN PART. **What was tested:** IL texts after the cascade and U (R11, N11). **Not tested:** the stored levels; REDO after a pit pick FAILS in every session (BUG-861, cause unknown). **Build:** robot 3.0.83 to 3.0.85. **Date:** 27 to 28 Oct. **Who:** robot (REDO half: a real fault).
28. **Hide grade in pipe text (D06): turn off "Show grade in pipe text" and the label reads "225 DIA. UPVC PIPE" with no "AT 1 IN".** **Status:** NOT TESTED. **Reason:** case N35 and twin drafted, reviewed "go to apply", not applied, never run. Tim found the tickbox only under More... (13:40) and has not turned it off on a placed pipe; he does not like where it is. **Build:** none. **Date:** none. **Who:** not tested.
29. **Excel export of the Pit Schedule with a Checking sheet (D23).** **Status:** TESTED IN PART. **What was tested:** Codex D5-03 PASS: an 11,780-byte workbook with Pit Schedule and Checking sheets and the headings PIT No., FIELD, VALUE, SOURCE. **Not tested:** no robot case reads the workbook. **Build:** 3.0.77. **Date:** 25 to 26 Oct. **Who:** Codex look.
30. **A hand-placed pipe label stays put when the pit moves (D13).** **Status:** TESTED IN PART. **What was tested:** N27 for the part named, switch ON only (Opus part; Codex agrees part). **Not tested:** moving the pit 500 mm (N31 drafted, judged WEAK). Needs Tim's word first: ride along with its pipe end (my recommendation) or stay exactly put (Monday question 19). **Build:** robot 3.0.85. **Date:** 29 Oct. **Who:** robot.
31. **One check summary and one results window for CDCHECKDWG (D28).** **Status:** NOT TESTED. **Reason:** R40 does not prove the actual report (Codex cx_cr02); Opus says it needs a Codex look and a desk ruling; a real fault was seen earlier; UNKNOWN whether a fix is queued. **Build:** none. **Date:** none. **Who:** not tested.
32. **Recent diameter, material and invert as one-click buttons in New Pipe (D05).** **Status:** NOT TESTED. **Reason:** Tim looked at his New Pipe window and said "no" (13:10; BUG-1238). The fix (B-006, BUG-1226) is running, not installed; guard case N30 is a draft. **Build:** none. **Date:** none. **Who:** not tested (Tim saw it missing).
33. **Downpipe and raingarden placed before any pipe (D07).** **Status:** TESTED IN PART. **What was tested:** DP and CDRG place with nothing refused, area 12.0 m2, one U takes back only the raingarden (N04, Opus part). **Not tested:** the "RG1" label (not built; fix B-007 queued); the exact tag DP1; DP after a reopen. **Build:** robot 3.0.83. **Date:** 28 Oct. **Who:** robot.
34. **CDSL shows the survey level as existing, then asks for the proposed level (D26).** **Status:** TESTED IN PART. **What was tested:** typed levels and the 18600 refusal (R35, robot); Codex D5-02 PASS; Tim yes from his own use ("Existing level from the survey here: 18.610 m"). **Not tested:** a stored survey from CDSURVEY (no test drawing exists). **Build:** robot 3.0.75; Codex 3.0.77; Tim 3.0.85. **Date:** 25 to 29 Oct. **Who:** robot, Codex look and Tim by hand.
35. **CDFEEDBACK prints one honest result line (D29).** **Status:** TESTED IN PART. **What was tested:** Cancel closes with one "CDFEEDBACK cancelled." line (N21; Tim yes from his own use). **Not tested:** Send report (never pressed; needs a spare Windows login and Tim's yes). **Build:** robot 3.0.83; Tim 3.0.85. **Date:** 28 to 29 Oct. **Who:** robot and Tim by hand.
36. **A long Pit Schedule continues on the next sheet with headers (D22).** **Status:** NOT TESTED. **Reason:** Codex D6-03 stopped because "Continue to Place / update" stayed disabled. The cause is not found. **Build:** none. **Date:** none. **Who:** not tested.
37. **Existing pipes greyed and demolished ones dashed on separate layers (D25).** **Status:** NOT TESTED. **Reason:** not built (no window to set status, existing pipes are green not grey, no demolition layer). **Build:** none. **Date:** none. **Who:** not tested.
38. **PIT and CD keep placing until Esc (daily card D01, the combined line the plan also lists).** **Status:** TESTED. **What was tested:** as lines 1 and 2 together; Tim confirmed both halves in his own AutoCAD. **Build:** robot 3.0.84 (R01, R03, R05; 3.0.85 re-run of R01 and R05 owed); Tim 3.0.85. **Date:** robot 24 to 28 Oct; Tim 29 Oct about 10:10 to 10:15. **Who:** robot and Tim by hand. An older Codex review (cx_cr20, on 3.0.79) said the "exactly one outcome per command" check was missing; the later ledger count stands.

**Count for A, line by line.** TESTED: lines 1 to 9, 11 to 21 and 38 = 21. TESTED IN PART: lines 10, 22, 23, 24, 25, 26, 27, 29, 30, 33, 34, 35 = 12. NOT TESTED: lines 28, 31, 32, 36, 37 = 5. Total 38. Lines 1, 2 and 38 overlap in what they test (PIT, CD, both), as they do in the plan.

---

# B. THE 60 PILOT-CRITICAL BUGS (0 tested, 0 in part, 60 not tested)

Source: `PILOT_CRITICAL_TEST_LIST_29OCT.md`. For every entry: **What was tested:** nothing. **Date:** none. **Who:** not tested. "Fix" shows the first build holding it (from the history of the installed commit, not from the DLL). Build for every entry: none. Drafted robot cases (BUG-1140, BUG-1194) have never run.

## Fix built and installed on Tim's PC (26) or built and not installed (5) or document only (1)

1. **Older CE silently deletes newer parts of a job record (BUG-1135): an ignored check comes back after a colleague saves on an older build.** NOT TESTED: needs two CE builds plus a save and reopen. Fix in Civil 3.0.74.
2. **After Edit Pit, the drawn Pit Schedule depth and "With Step Irons" note change (BUG-1196): P2 drops from 1.10 to 0.80.** NOT TESTED: the robot cannot press Edit Pit Save or read a drawn schedule. Fix in Civil 3.0.75.
3. **Survey levels in a nested block of a turned survey Xref land in the wrong place (BUG-1190): New Pit offers the wrong level.** NOT TESTED: no test drawing with a rotated survey Xref. Fix in Civil 3.0.75.
4. **A LandXML pipe with no grade gets an invented "AT 1 IN 100" (BUG-1188).** NOT TESTED: no test file, file chooser not drivable. Fix in Civil 3.0.76.
5. **On AutoCAD 2022 to 2024, one downpipe in a COPY cancels the clean-up of every pit and pipe copied (BUG-1137).** NOT TESTED: needs AutoCAD 2024. Fix in Civil 3.0.76.
6. **Step-iron depth read from two places that can disagree (BUG-540).** NOT TESTED: the remarks cell is not read by the robot. Fix already on the base.
7. **CDCALC Boyd's tab and CDDESIGN use different hard-ground C (BUG-905).** NOT TESTED: the fix is installed but switched OFF; Tim confirmed 0.9 on 29 Oct (the default goes ON in a coming build, B-033). Needs that build installed, then a Codex look (H7).
8. **On a PC without the CE pipe add-on, CDSYNC empties every pit's pipe list (BUG-1138).** NOT TESTED: needs a PC without the add-on. Fix in Civil 3.0.75.
9. **A network pasted into a new drawing goes quiet after save and reopen: pits move without their pipes (BUG-1150).** NOT TESTED: needs a pasted-and-saved test drawing. Fix in Civil 3.0.75.
10. **One unreadable pit record stops new pipes linking to any pit (BUG-1142).** NOT TESTED: no test drawing with a damaged record. Fix in Civil 3.0.75.
11. **The 300 mm minimum head on a charged downpipe system is never checked (BUG-1097).** NOT TESTED: the CDCALC window cannot be read by the robot. Tim ruled on 29 Oct that the check uses the head left after pipe losses; that change is a coming build (B-034). Needs that build installed, then a Codex look (H1). The partial fix in Civil 3.0.76 uses the typed head.
12. **A pasted downpipe keeps a link to the original's label, so MOVE takes the wrong label (BUG-1140).** NOT TESTED: draft case P02 and its twin written, never run, never reviewed (MOVE half only). Fix in Civil 3.0.75.
13. **CDTEXTSEG puts the pipe label on the leg round the corner, not the leg you clicked (BUG-1194).** NOT TESTED: draft case P01 and its twin written, never run, never reviewed. Fix in Civil 3.0.75.
14. **An Xref'd Pit Schedule says OUT OF DATE when nothing changed (BUG-1145).** NOT TESTED: needs two linked test drawings and a save. Fix in Civil 3.0.75.
15. **Cancel on a Pit Schedule export still writes into the drawing, so CLOSE asks "Save changes?" (BUG-1198).** NOT TESTED: the robot may never press Export; needs a Codex look. Fix in Civil 3.0.75.
16. **In the CDEDIT batch window, one ticked but blank field greys out Apply (BUG-1049).** NOT TESTED: needs a reviewed runner change. Fix in Civil 3.0.77.
17. **A STORM report naming a two-word council (Glen Eira, Yarra Ranges) sets a council CE cannot find (BUG-1106).** NOT TESTED: window cannot be read by the robot; needs a Codex look and a test report. Fix in Civil 3.0.75.
18. **CDCALC Catchments opens with a made-up 500 m2 catchment (BUG-1101).** NOT TESTED: window cannot be read; needs a Codex look. Fix (partial) in Civil 3.0.76.
19. **When Manager loads before Civil, the CE Tools tab is missing (BUG-1206).** NOT TESTED: needs a Codex look on a copy of the bundles. Fix in Manager 1.1.74.
20. **An old Civil bundle in the all-users plug-ins folder supplies the pit blocks first (BUG-1165).** NOT TESTED: needs a spare PC and administrator rights. Fix in Civil 3.0.74.
21. **Copying your settings file to a colleague carries your own office-folder paths (BUG-1167).** NOT TESTED: needs a second Windows login. Fix in Civil 3.0.74. The bug entry's own check does not match what the fix does (see the pilot list, section F).
22. **Feedback Help promises a "Save report" step that does not exist (BUG-1215).** NOT TESTED: Help window cannot be read by the robot; needs a Codex look. Fix in Civil 3.0.76.
23. **A damaged office approval file can still show "CE is current." (BUG-1179).** NOT TESTED: needs a spare profile. Fix in Manager 1.1.76.
24. **Drawing Repair says "Nothing has been changed" after a successful repair (BUG-1180).** NOT TESTED: needs a Codex look. Fix in Manager 1.1.76.
25. **The job-time folder is fixed on the first AutoCAD start and never looked for again (BUG-1168).** NOT TESTED: needs a spare login. Fix in Civil 3.0.76.
26. **The weekly time export runs at AutoCAD start-up and holds it up (BUG-1202).** NOT TESTED: needs a spare login; the bug's own step types a LISP line, which robot cases forbid. Fix in Civil 3.0.76.
27. **On AutoCAD 2022 to 2024 without the add-on, moving a pit leaves CE pipe ends behind with no message (BUG-1151).** NOT TESTED: needs AutoCAD 2024. Fix in Civil 3.0.76.
28. **The colleague pack's backup step saved only 2 of the CE settings folders (BUG-1173).** NOT TESTED: a rollback rehearsal on a spare login. Fix is a document change in pack page 02.
29. **Approved survey levels stay in use after the survey Xref is moved (BUG-1189).** NOT TESTED: fix built, not installed (held for Tim's question). No fix on the installed build.
30. **The long section drops survey levels more than 1.20 m from the cover line (BUG-1192).** NOT TESTED: no fix; waiting for Tim's design word.
31. **The automatic pipe sizer picks the smallest pipe at any grade, up to 1 in 1 (BUG-1088).** NOT TESTED: no fix; waiting for Tim's steepest-grade number.
32. **The council minimum after-development C (Darebin, Maribyrnong, Boroondara) is never applied (BUG-1095).** NOT TESTED: no fix; waiting for Tim's engineering word.
33. **Maroondah and Yarra Ranges' own before-development C and Tc table are never used (BUG-1099).** NOT TESTED: no fix; waiting for Tim's engineering word.
34. **CDDESIGN says the office rainfall curve reads 7 to 9 per cent high (BUG-866).** NOT TESTED: no fix; waiting for Tim's check of the curve. (Other installed commits carry the same number for a different bug.)
35. **LandXML cover and invert levels in millimetres are not converted to metres (BUG-1053).** NOT TESTED: fix built, not installed; needs a review, a train and a test file.
36. **CDAGI and CDPERIMETER pass a flat drain in a metre drawing (BUG-1052).** NOT TESTED: fix built, not installed.
37. **CD "work it out from the grade" rounds the level you typed, 10.125 to 10.13 (BUG-685).** NOT TESTED: no fix; waiting for Tim's ruling.
38. **Pasting a pit from a Save As sister drawing gives it this drawing's pit values (BUG-1148).** NOT TESTED: no fix; waiting for Tim's design word.
39. **Redesign drops the minimum grade for DN450 and larger (BUG-1091).** NOT TESTED: no fix; waiting for Tim.
40. **Cover is measured to the inside top of the pipe, so it reads high by the wall thickness (BUG-901).** NOT TESTED: no fix; queued, not built (Tim said yes to measuring to the outside).
41. **The pit drop where the pipe gets bigger compares inverts only (BUG-907).** NOT TESTED: no fix; queued, not built (Tim said yes to a warning).
42. **The rainwater-tank reuse credit never runs on a real job (BUG-1096).** NOT TESTED: no fix; waiting for Tim.
43. **On AutoCAD 2022 to 2024 a downpipe cannot be placed directly on a pit (BUG-1209).** NOT TESTED: no fix; waiting for Max's AutoCAD year.
44. **Nothing says the hydraulic grade line and pit losses were not checked (BUG-1090).** NOT TESTED: fix built, not installed.
45. **After BIND of a CE Xref, the schedule says SOURCE MISSING and QA fails for good (BUG-1149).** NOT TESTED: fix built, not installed (held for Tim's BIND answer).
46. **Cover is checked only at the two pits, not under a lower garden bed between them (BUG-902).** NOT TESTED: no fix; waiting for Tim.
47. **Different screens judge one pipe against different minimum grades and cover (BUG-903).** NOT TESTED: no fix; waiting for Tim to confirm the grade values.
48. **Civil and Manager look for the office folders in different places (BUG-1166).** NOT TESTED: no fix; waiting for a fact from Max's PC.
49. **Max's old July Structural may load an older shared file with the same version number (BUG-1169).** NOT TESTED: no fix; a release check on a spare PC.
50. **Going back restores an old Manager that may stage updates by itself (BUG-1170).** NOT TESTED: no fix; a rollback rehearsal on a spare login.
51. **On AutoCAD 2022 to 2024, Edit Pipe and Edit Pit lose the plan picture (BUG-1210).** NOT TESTED: no fix; waiting for Max's AutoCAD year and Tim's choice.
52. **The Pit Schedule cell right-click menu has no "Delete cell" (BUG-1031).** NOT TESTED: no fix; a decision needed.
53. **Drawn Pit Schedule remarks cross the row lines on the issued sheet (BUG-587).** NOT TESTED: no fix; waiting for Tim's word on taller rows.
54. **The above-ground drain grade is checked but never labelled (BUG-648).** NOT TESTED: no fix; waiting for Tim's wording and layer.
55. **Every double-click on a block scans every block, slow in survey drawings (BUG-865).** NOT TESTED: no fix; a measurement first.
56. **A "no clear spot" line prints after MOVE even with Tidy labels off (BUG-816).** NOT TESTED: no fix; waiting for Tim's Settings decision.
57. **The other blues in windows, ribbon icons and Help (BUG-525).** NOT TESTED: no fix; waiting for Tim's colour word.
58. **Civil's reports to Tim never arrive and pile up on a colleague's PC (BUG-1171).** NOT TESTED: no fix; waiting for Tim.
59. **In the Grade mismatch box, the corner X still places the pipe (BUG-857).** NOT TESTED: no fix; Tim's call.
60. **The Pit Schedule "data issues" count goes up by one after the first CDSYNC (BUG-855).** NOT TESTED: no fix; the cause is not pinned (may be by design). Related evidence: the CDSYNC check N26 reads a header count of 95 before and after (Codex cx_cr23), which is not a test of this bug.

---

# C. GATE ITEMS, CODEX LOOKS AND TIM'S HAND CHECKS (58 entries)

Sources: top of `release-v3-colleagues.md` and `COLLEAGUE_READINESS_29OCT.md` section 1 (gate); `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` items 11, 13 to 29 and H1 to H19 (the "CE 03 hand checks" are the H entries). The ledger has two items both numbered 28: the Codex review of five cases (entry C-L28 below) and a CE 00 count ruling, which is a counting decision, not a test, so it has no entry.

## C1. The 11 gate items (0 tested, 1 in part, 10 not tested)

1. **Administrator set-up: one person (Tim) is the CE administrator before any colleague installs (BUG-476).** **Status:** TESTED IN PART. **What was tested:** the shared administrator list holds one entry, Tim's Windows login (Codex W53, 3 of 3). **Not tested:** arrival on other PCs; Tim has not confirmed it. **Build:** UNKNOWN (10 Oct, build not recorded in the sources I read). **Date:** 10 Oct 00:31. **Who:** Codex look.
2. **Roll Back is hidden until the installer's older-version path is proven (BUG-477, BUG-441).** **Status:** NOT TESTED. **Reason:** the 24 Oct triage and the T5 audit disagree and no one opened Manager. Max is told not to press it. **Build:** none. **Date:** none. **Who:** not tested.
3. **A real update route, or reworded update messages (BUG-478).** **Status:** NOT TESTED. **Reason:** decided (Tim updates Max by hand during the pilot); no record that the messages were reworded. **Build:** none. **Date:** none. **Who:** not tested.
4. **Old install scripts moved to an OLD folder (BUG-483).** **Status:** NOT TESTED. **Reason:** Tim's call, not done. **Build:** none. **Date:** none. **Who:** not tested.
5. **The Manager fault report and diagnostics code the login, PC name and folders (BUG-488).** **Status:** NOT TESTED. **Reason:** records disagree on whether a fix is installed; Max is told not to press them. **Build:** none. **Date:** none. **Who:** not tested.
6. **Publish Issue stamps only the ticked sheets (BUG-495).** **Status:** NOT TESTED. **Reason:** Structural only; falls away if Structural stays on Tim's PC. Tim has not said so for the gate list. **Build:** none. **Date:** none. **Who:** not tested.
7. **The job record lives with the job (BUG-496).** **Status:** NOT TESTED. **Reason:** Structural only; same position as item 6. **Build:** none. **Date:** none. **Who:** not tested.
8. **Imports read the source drawing's units (BUG-505): a millimetre drawing must never come in 1000 times too big without a word.** **Status:** NOT TESTED. **Reason:** an earlier fix failed in real AutoCAD twice (Codex V3b-04 FAIL 21 Oct, V8-01 DIFFERENT 22 Oct); the new soft-line fix (B-010) is not built. **Build:** none. **Date:** none. **Who:** not tested (earlier Codex looks failed).
9. **No blue anywhere a colleague sees or prints (BUG-517).** **Status:** NOT TESTED. **Reason:** the printed sheet colour is built and unit-tested only; the other blues have no fix; a Codex look is owed. **Build:** none. **Date:** none. **Who:** not tested.
10. **Markup and chat send nothing off the PC unless a switch that defaults OFF is on (BUG-549 family).** **Status:** NOT TESTED. **Reason:** fixes installed, neither tested; for the pilot AI features are OFF and Structural is not shipped. **Build:** none. **Date:** none. **Who:** not tested.
11. **Structural 1.0.113 and the Civil privacy train installed, with a pass showing AI-off messages and nothing sent.** **Status:** NOT TESTED. **Reason:** the install condition is met; the pass that closes it was not found. **Build:** none. **Date:** none. **Who:** not tested.

## C2. Codex AutoCAD looks D3 to D8 (ledger item 11; 25 and 26 Oct; 8 passed, 1 tested and failed, 1 group not tested)

12. **Quick MOVE keeps labels and pipes together and one U restores (D3-02).** **Status:** TESTED. **Build:** Civil 3.0.75. **Date:** 25 Oct. **Who:** Codex look ("PASS, SURE").
13. **EXPLODE names the pit and six pipe ends; the schedule has no group for it; U restores 27 rows (D3-05).** **Status:** TESTED. **Build:** 3.0.75. **Date:** 25 Oct. **Who:** Codex look.
14. **CDSYNC warns and keeps the schedule values (D4-01).** **Status:** TESTED. **Build:** 3.0.77. **Date:** 25 to 26 Oct. **Who:** Codex look.
15. **CDREBUILD warns and says it does not save (D4-02).** **Status:** TESTED. **Build:** 3.0.77. **Date:** 25 to 26 Oct. **Who:** Codex look.
16. **Spot levels typed and blank, 18600 refused, Esc cancels (D5-02).** **Status:** TESTED. **Build:** 3.0.77. **Date:** 25 to 26 Oct. **Who:** Codex look.
17. **Excel export of the Pit Schedule (D5-03).** **Status:** TESTED. **Build:** 3.0.77. **Date:** 25 to 26 Oct. **Who:** Codex look.
18. **Outfall and floor-waste symbols (D7-02).** **Status:** TESTED. **Build:** 3.0.78. **Date:** 26 Oct. **Who:** Codex look.
19. **The [Undo] sentence and U echoes on the third route point (D8-05).** **Status:** TESTED. **Build:** 3.0.78. **Date:** 26 Oct. **Who:** Codex look.
20. **About CE Suite window on Manager 1.1.78 (D8-01).** **Status:** TESTED, FAILED. **What was tested:** the window still cuts off the lower rows (AutoCAD and Runtime unreadable); evidence added to BUG-090. **Build:** Manager 1.1.78. **Date:** 26 Oct. **Who:** Codex look ("FAIL, SURE"). Not re-tested since.
21. **Ten other looks differed from the brief and seven were blocked (D3-01, D3-03, D4-03, D5-05, D5-06, D7-01, D7-03, D8-02, D8-03, D8-04 different; D3-04, D4-04, D5-01, D6-01 to D6-04, D7-04 blocked).** **Status:** NOT TESTED. **Reason:** the brief's selection words or windows did not work; nothing was judged (the ledger says probably brief mismatches). **Build:** 3.0.75 to 3.0.78. **Date:** 25 to 26 Oct. **Who:** not tested.

## C3. Ledger items 13 to 29 (8 tested, 9 in part)

22. **Ledger 13: robot regrade on Civil 3.0.80.** **Status:** TESTED. **What was tested:** 20 accepted cases, two separate AutoCAD starts, 40 passes, 0 fails. **Build:** Civil 3.0.80 / Manager 1.1.80. **Date:** 27 Oct. **Who:** robot. (BUG-861 REDO inconsistent; R24 not run.)
23. **Ledger 14: independent Opus review of seven cases on 3.0.80.** **Status:** TESTED IN PART. **What was tested:** whole claim for the CDTWL freeboard warning and erase-a-pit; part only for CE never saves, Edit Pipe cascade, CDSYNC warning, CDCHECK totals, CDSURVEY refusal. **Build:** 3.0.80, re-held on 3.0.83. **Date:** 27 Oct. **Who:** robot, with Opus review.
24. **Ledger 15: regrade on 3.0.82 and 3.0.83 (interim).** **Status:** TESTED. **What was tested:** 20 cases two starts each on 3.0.82; seven Codex-ask cases twice on 3.0.83, failing twins red. **Build:** 3.0.82, 3.0.83. **Date:** 27 Oct. **Who:** robot.
25. **Ledger 16: final regrade on 3.0.82 and 3.0.83.** **Status:** TESTED. **What was tested:** 20 cases two starts on both builds, 0 failures. BUG-859 and BUG-372 are real faults (still failing). **Build:** 3.0.83+96455f13. **Date:** 28 Oct 02:15. **Who:** robot.
26. **Ledger 17: Opus review of 11 new cases on 3.0.83.** **Status:** TESTED IN PART. **What was tested:** CDREBUILD never saves and EXPLODE a pit: whole. Seven cases part only; two (OF and FO, downpipe) not ready that day. New bug BUG-1225 found. **Build:** 3.0.83. **Date:** 28 Oct. **Who:** robot, with Opus review.
27. **Ledger 18: Opus review of OF and FO, and downpipe plus raingarden.** **Status:** TESTED IN PART. **What was tested:** OF and FO whole; downpipe and raingarden part only (no RG1 label, exact tag DP1, blank drawing, DP after a reopen). **Build:** 3.0.83. **Date:** 28 Oct 08:36. **Who:** robot, with Opus review.
28. **Ledger 19: Opus review of eight cases N15 to N22 on 3.0.83.** **Status:** TESTED IN PART. **What was tested:** copy a pit, the two Undo-name cases and explode with no pipes: whole. CDRENUMBER, pit catch, short-pipe leader, feedback Cancel: part only. **Build:** 3.0.83. **Date:** 28 Oct 12:20. **Who:** robot, with Opus review.
29. **Ledger 20: Opus review of the Codex-ask cases on 3.0.84.** **Status:** TESTED IN PART. **What was tested:** quick MOVE (labels go with the pit), locked pit text layers, floor waste in open space, perimeter drain text, plain COPY of a pit: the part named. BUG-460 written FIXED (Claude-accepted, 3.0.84). Real faults proven: BUG-665, BUG-1222, BUG-1223, BUG-672 message half. **Build:** 3.0.84. **Date:** 28 Oct 15:01. **Who:** robot, with Opus review.
30. **Ledger 21: Codex look G2, CDRENUMBER on the plan.** **Status:** TESTED. **What was tested:** preview P9 to P8 and P10 to P9; No changes nothing; Yes changes both; U restores; circles and symbols did not move. **Build:** Civil 3.0.84 / Manager 1.1.84 / Structural 1.0.125. **Date:** 28 Oct 19:47. **Who:** Codex look ("PASS, SURE").
31. **Ledger 22: Codex look G1, short pipe label on a leader.** **Status:** TESTED. **What was tested:** a 2 m pipe gets ONE leader; the arrow tip touches the pipe; words clear of the pipe and IL texts. **Build:** 3.0.84. **Date:** 28 Oct 20:30. **Who:** Codex look ("PASS, SURE").
32. **Ledger 23: regrade on 3.0.84.** **Status:** TESTED. **What was tested:** 49 accepted cases, two separate starts, 98 passing case-runs, 0 failures; the BUG-1225 fix proved 6 of 6 with a switch-off control. **Build:** 3.0.84+94f521cc. **Date:** 28 Oct 23:09. **Who:** robot.
33. **Ledger 24: Opus review of seven cases N23 to N29 on 3.0.85.** **Status:** TESTED IN PART. **What was tested:** pit catch, pit label on the click, CDSYNC keeps the schedule: whole. CDRENUMBER, hand-placed label, current layer, schedule order: part only. **Build:** 3.0.85. **Date:** 29 Oct 02:40. **Who:** robot, with Opus review.
34. **Ledger 25: Opus review of the C-75 fix proofs on 3.0.85.** **Status:** TESTED IN PART. **What was tested:** Edit Pipe size-only Save (BUG-1222) and plain COPY of a pit: whole. Second plain Save, locked-layer message and COPY-and-SCALE numbers: part. ROTATE Copy label and floor waste at an inspection opening: need a stronger check. BUG-1222 written FIXED (Claude-accepted, 3.0.85). **Build:** 3.0.85. **Date:** 29 Oct 04:40. **Who:** robot, with Opus review.
35. **Ledger 26: regrade on 3.0.85 (Max Sonnet standing in for the Team robot).** **Status:** TESTED IN PART. **What was tested:** 53 of the 65 counted cases passed in two separate starts, 0 failures. **Not tested:** 12 cases (R01 R02 R02b R03 R04 R05 R07 R10 R14h x3 R16) not run on 3.0.85 as of 08:30. **Build:** 3.0.85+09126560. **Date:** 29 Oct to 08:30. **Who:** robot.
36. **Ledger 27: Tim's three hand checks on 3.0.85 (his words: "passed" three times).** **Status:** TESTED. **What was tested:** BUG-1225 (downpipe, close without saving, reopen, downpipe again); BUG-665 ROTATE Copy of a pit gets its own number label and cover text; BUG-1222 Edit Pipe swap levels, Save, Save again. **Build:** 3.0.85. **Date:** 29 Oct about 09:45. **Who:** Tim by hand. Not hand-tested: SCALE Copy, the BUG-672 message.
37. **Ledger 28: Codex second review of five Opus-accepted cases.** **Status:** TESTED. **What was tested:** a different reviewer agrees on pit catch, pit label on the click, CDSYNC keeps the schedule, Edit Pipe size-only Save and plain COPY. Notes: pit catch checks 90 and 110 mm, not exactly 100 mm. **Build:** 3.0.85. **Date:** 29 Oct 09:35. **Who:** robot cases; Codex paper review (not a screen look).
38. **Ledger 29: Codex second review of eleven part-only cases.** **Status:** TESTED IN PART. **What was tested:** Codex agrees every one is part only (N24, N27, N28, N29, R12, R33, R33m, R36, R37b, R32, R34sn) and supports BUG-460 as complete within R33. **Not tested:** the extra checks it asks for stay open. **Build:** 3.0.85. **Date:** 29 Oct 10:10. **Who:** robot cases; Codex paper review.

## C4. Tim's hand checks H1 to H19 (10 tested, 6 in part, 4 not tested; Tim's own AutoCAD, Civil 3.0.85 / Manager 1.1.85 / Structural 1.0.125, 29 Oct)

39. **H1: PIT keeps placing until Esc (about 10:10).** **Status:** TESTED. Tim: next pit offered, Esc ends it, first pit stays. **Who:** Tim by hand. PIT slow to start (BUG-1228 family).
40. **H2: CD keeps placing pipes until Esc (about 10:15).** **Status:** TESTED. Tim: "pass"; Esc gave "CD command cancelled". **Who:** Tim by hand.
41. **H3: Recover Inverts (about 10:20).** **Status:** TESTED. 22 recovered, 29 skipped, 51 pipes, nothing written wrongly. **Who:** Tim by hand. Not seen: the one-end-only warning line.
42. **H4: EXPLODE a pit with a pipe (about 10:30).** **Status:** TESTED. Pit leaves the schedule, pipe unharmed, U brings it back. **Who:** Tim by hand. BUG-1231 filed.
43. **H5: ERASE a pit with one pipe (about 10:40).** **Status:** TESTED. Pit erased, schedule updated, pipe remains with "Not connected yet", U restores. **Who:** Tim by hand. BUG-1231 added.
44. **H6: COPY a pit (about 10:50).** **Status:** TESTED. New number, original untouched, U takes the copy back. **Who:** Tim by hand.
45. **H7: U names what it undid (about 11:00).** **Status:** TESTED IN PART. PIT half passed; the MOVE half was a grip stretch, not the MOVE command (the echoes were INTELLIPAN and Grip Edit). **Who:** Tim by hand.
46. **H8: CDRENUMBER on his scratch drawing (about 11:05).** **Status:** NOT TESTED. CE said "nothing to renumber"; the real work did not run. **Who:** not tested.
47. **H9: pit catch, first attempt (about 11:30).** **Status:** NOT TESTED. Typed angles put both pipe ends inside the 100 mm reach, so it was not a valid test; superseded by H9b. **Who:** not tested.
48. **H9b: pit catch re-run with correct points (about 11:50).** **Status:** TESTED. 90 mm end moved to the wall; 110 mm end left free. Not tried: exactly 100 mm. **Who:** Tim by hand.
49. **H10: quick MOVE of a pit, and the MOVE command's U (about 12:00).** **Status:** TESTED. Tim moved P1 by 0,2000, typed U once: "passed"; labels and joined pipe moved together. His command line was not pasted. **Who:** Tim by hand.
50. **H11: CDREBUILD and CDSYNC warn first (about 12:10).** **Status:** TESTED IN PART. Warnings printed first; counts matched (1 pit, 2 pipes). Not shown: "does not save" (the drawing was a never-saved new one) and U. **Who:** Tim by hand.
51. **H12: OF and FO overflow symbols (about 12:20).** **Status:** TESTED IN PART. Placement, prompts, tags OF1 and FO1 and plan labels worked. Not passed: the FO symbol reads "OF" (BUG-1236). **Who:** Tim by hand.
52. **H13: CDRENUMBER set-up attempt (about 12:35).** **Status:** NOT TESTED. CE said no pit discharges outside the network; stopped before the real work (BUG-1237, wording unhelpful). **Who:** not tested.
53. **H14: CDRENUMBER with an outlet pipe added (about 12:45).** **Status:** TESTED IN PART. Preview, Yes, plan labels and U covered by Tim's word "passed". The No path result was not given. **Who:** Tim by hand.
54. **H15: four tools from his own screenshots (about 12:55).** **Status:** TESTED. Pit number and CL cover label (D09), pipe label along the pipe (D10), one IL text each end (D12), new pipe joins the pit (D03): "yes" to all four. **Who:** Tim by hand. Arrow clash on the lower pipe is BUG-1234.
55. **H16: questions from his own daily use (about 13:10).** **Status:** TESTED IN PART. Yes: office layers (D24), natural order (D21), CDSL (D26). No: recent buttons in New Pipe (D05, BUG-1238). D30 not answered then. **Who:** Tim by hand.
56. **H17: confirmation of three read-as-yes answers (about 13:15).** **Status:** TESTED. Yes: CDSL existing level (D26), CDEDIT keeps the selection (D17), CDFEEDBACK Cancel (D29). **Who:** Tim by hand.
57. **H18: D30 ribbon tab and the D06 tickbox (about 13:30).** **Status:** TESTED IN PART. "d30 - pass" (tested). D06: he could not see "Show grade in pipe text" in the New Pipe window (not tested). **Who:** Tim by hand.
58. **H19: D06 found under More... (about 13:40).** **Status:** NOT TESTED. The tickbox exists under More...; Tim has not turned it off and placed a pipe. He wants a new design (idea UX-NEWPIPE-DECLUTTER). **Who:** not tested.

**Count for C, line by line.** TESTED (passed): entries 12 to 19 (8), 22, 24, 25, 30, 31, 32, 36, 37 (8), 39 to 44, 48, 49, 54, 56 (10) = 26. TESTED, FAILED: entry 20 = 1. TESTED IN PART: entry 1, 23, 26, 27, 28, 29, 33, 34, 35, 38 (10), 45, 50, 51, 53, 55, 57 (6) = 16. NOT TESTED: entries 2 to 11 (10), 21, 46, 47, 52, 58 = 15. Total 26 + 1 + 16 + 15 = 58. (The entry numbers above run 1 to 58 inside section C, restarting at 1; this section uses its own numbers 1 to 11 for the gate items and 12 to 58 after.)

---

# HOW TO REFRESH (for CE 07 or the next session)

1. **After a robot run or regrade:** re-read `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` (the newest numbered items and the build line) and `release-v3-colleagues-RUNNER_*_REGRADE_*_REPORT.md`. Change the Build and Date lines of every Section A entry whose case passed on the new build; the owed 12 cases (R01 R02 R02b R03 R04 R05 R07 R10 R14h x3 R16) change A lines 1, 2, 8, 9, 10, 11, 12, 22, 23 first.
2. **After a Codex look:** re-read `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_*.md` and `CODEX_LOOK_BRIEFS_G_28OCT.md`. A PASS closes A lines 31 (D28), 36 (D22), 37 (D25 when built), 26 and 30 pictures; add one Section C entry per look.
3. **After Tim's hand checks:** re-read the H lines at the bottom of the ledger. Each new H becomes a Section C entry; if it names a D number, update the matching Section A line (D05 line 32, D06 line 28, D13 line 30, D24, D21, D26, D29).
4. **After a fix is installed or a case written for a pilot-critical bug:** re-read `PILOT_CRITICAL_TEST_LIST_29OCT.md` (section A and D) and `BUG_CARPARK.md` (Status lines). Only change a Section B line when a case ran twice on one build with a failing twin and a reviewer wrote it, or a Codex look or Tim passed it; the first candidates are BUG-1194 (B entry 13) and BUG-1140 (B entry 12).
5. **After a gate decision:** re-read the top of `release-v3-colleagues.md` and `COLLEAGUE_READINESS_29OCT.md` section 1; update Section C entries 1 to 11.
6. **After CE 00 changes the count:** re-read `EVERYDAY_TOOLS_STATUS_29OCT.md` and the ledger count ruling; refresh the ANSWER FIRST numbers last, after the line-by-line counts.

---

# What I did NOT verify (RULES 5.9)

1. **Tallies are by hand.** I counted each section line by line (A 21 / 12 / 5, B 0 / 0 / 60, C 26 / 1 / 16 / 15) but no script checked them. CE 07 should recount at the first refresh. The first-line figure in the Summary of the source everyday file ("19 accepted") is a different count, explained at the top.
2. **Nothing was run or opened in AutoCAD.** Every status is read from files.
3. **The installed build was not re-read from the DLLs.** Civil 3.0.85 / Manager 1.1.85 / Structural 1.0.125 is the ledger's word.
4. **Whether tester_run77 or tester_run78 has run since the ledger was last written** (it was due tonight after 5:30 pm). If it has, entries A 1, 2, 8, 9, 10, 11, 12, 22 and 23 may move to 3.0.85.
5. **Case-by-case build match:** the ledger says 53 of 65 counted cases passed on 3.0.85; I did not match each Section A line to its case on that build.
6. **The Opus and Codex case reviews** were read through the ledger's summaries and the everyday file's quotes, not line by line.
7. **The H1 to H3 and C1 to C6 Codex briefs** named in the scoreboard were not found in CE_PLAN, so I do not know which tools they cover.
8. **The ledger's duplicate item 28** (a Codex review and a count ruling) was handled as stated at the top of Section C.
9. **The pilot list's fix-build versions** come from git history on the installed commit, not from the DLL, as that report itself says.
10. **The "no fix installed" counts for B** (32) and "fix installed" (26) are the pilot list's, not re-derived.

# Sources read

C:\TimOS\RULES.md; areas\EVERYDAY_TOOLS_STATUS_29OCT.md; areas\PILOT_CRITICAL_TEST_LIST_29OCT.md; areas\release-v3-colleagues.md (gate list, lines 3 to 17); areas\COLLEAGUE_READINESS_29OCT.md (section 1 and summary); areas\ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md (items 1 to 29 and H1 to H19).

# Summary

Everyday tools: 21 tested, 12 in part, 5 not tested (38 lines). Pilot-critical bugs: 0 tested, 60 not tested. Gate and hand-check entries: 26 tested, 1 failed, 16 in part, 15 not tested (gate list alone: 1 in part, 10 not tested). The colleague note can say the everyday drawing tools were tested; it cannot say bug fixes, update route, privacy or other-PC installs were tested. Counts are by hand; recount at first refresh.

---

**Last line of the plan (confirmed by Tim, TIM_ANSWERS item 70): the confirming full pass on the named pilot build runs Sat 14 and Sun 15 Nov; Tim's go is conditional on its Sunday night result. Anything that arrives after Sat 7 Nov is listed here as 'tested in these areas, not in full' until that pass.**
