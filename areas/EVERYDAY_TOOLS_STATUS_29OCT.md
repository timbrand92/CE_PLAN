# Everyday tools: where each of the 40 stands today (Thu 29 Oct 2026)

CE_ACAD / robot / plan / 16. CE 02 Robot and Codex Testing, Team Sonnet headless job, read documents and write this one file. Written about 11:20 to 11:50 Melbourne (PC clock). Nothing was started in AutoCAD, nothing was built or installed, no case was run. Every line below is read from the documents named at the end; where a document does not say, the line says UNKNOWN.

---

## ANSWER FIRST

1. **Accepted today: 19 of 40.** That is the CE 00 ruling (ledger item 28): 16 daily cards plus three named checks. All 19 are Claude-accepted (or Claude plus Codex); none is yet a plain Tim-accepted tool for the whole card.
2. **The plan says 40 but names only 38.** 30 daily cards (D01 to D30) plus eight named checks (PIT, CD, Edit Pipe cascade with U and REDO, quick MOVE, CDSYNC keeps the schedule, CDTWL freeboard, Recover Inverts, Tidy labels). Two slots were never named. This report has 38 lines and does not invent the other two.
3. **30 of 40 by Fri 30 Oct is not reachable.** My honest estimate is 20 to 22 by Fri 30 Oct and 26 to 30 by Sat 7 Nov. It is an estimate, not a record. CE 02's own note in the desk log says 22 to 24 by Sat 31 Oct.
4. **The count for the 11 quickest is below.** If all 11 land, 19 becomes 30.

---

## FOR TIM

1. **Where it stands.** 19 of 40 everyday tools are accepted by the robot or by Codex. That means a check that needs nothing seen on screen passed twice in separate AutoCAD sessions and failed on a deliberately wrong version, or a Codex look in real AutoCAD passed. Your own hand checks this morning (pit, pipe, Recover Inverts, EXPLODE, ERASE, COPY) agree with the robot on every one you ran.
2. **The 11 quickest next, one job each:**
   1. **CDTWL freeboard (the 20th).** Real job: you tighten the freeboard to 200 mm and CDTWL must warn at 200, not 150. The robot has to run its three 200 mm checks twice on the installed build. Tonight, after 5:30 pm.
   2. **PIT keeps placing until Esc.** Real job: you place six pits in a row without retyping PIT. You passed it by hand at 10:10 and the robot has accepted it. It is only missing because the plan lists it as its own line. CE 00 can count it by ruling.
   3. **CD keeps placing pipes until Esc.** Same position: you passed it by hand at 10:15. Same ruling.
   4. **Office layers and current layer (D24).** Real job: you draw a pit and a pipe while on layer BLOCKS and nothing lands on 0 or BLOCKS. The robot check is written and a second reviewer says it is sound. It runs tonight.
   5. **Pit Schedule groups (D21).** Real job: pits LPD, OG, P1 to P10, CP2, CP10 then C1 sit in that order on the issued schedule. Written and reviewed as sound. It runs tonight.
   6. **Quick MOVE of a pit.** Real job: you drag a pit 2 m and its number, cover level and both invert texts come with it, one U puts everything back. Half is accepted. It needs one stronger check and a Codex look on Fri evening.
   7. **Hide grade (D06).** Real job: you turn off "Show grade in pipe text" and the label reads "225 DIA. UPVC PIPE" with no "AT 1 IN". The check is written. It needs one small robot permission applied after 5:30 pm (a reviewer said go).
   8. **Excel export of the Pit Schedule (D23).** Real job: you export the schedule and the workbook has a Checking sheet. Codex has looked and passed it. It lacks a written check that reads the file.
   9. **Hand-placed label stays put (D13).** Real job: you drag a pipe label by hand, move the pit, and the label is not shoved elsewhere. This needs your word (Monday question 19) and a Codex look on Thu evening.
   10. **CDCHECKDWG summary and results window (D28).** Real job: one summary line and one readable list. Needs a Codex look and a ruling from the desk first. A real fault was seen earlier.
   11. **Mid-pipe label wording and direction (D10).** Real job: the label reads along the pipe the right way up on a sloping pipe. The robot cannot read the angle of text, so it needs a Codex look.
3. **Which need a Codex look (the picture half):** D05 window, D10, D13, D22, D28, D30, quick MOVE, D07 (Codex reports the facts first). D23 is already looked at. D11 and D20 are already looked at.
4. **Which need your word:** D13 (does a label you dragged ride along with its pipe end when the pit moves, or stay exactly put? I recommend ride along), D29 (Send report: needs the spare Windows login and your yes), D20 (whether the numbering order is the right engineering order). D02 needs a re-run of your hand test with typed distances, not typed angles (see line D02). CE 00, not you, rules on whether PIT and CD count as separate lines.
5. **Which need a build first:** D05 (recent level buttons back on the main New Pipe page, B-006, running), D07 (raingarden RG1 label, B-007, queued), D25 (existing and demolished layers: not built at all), and D30 plus D28 may need a fix (Codex saw a real fault; I cannot find a build item for either: UNKNOWN).
6. **Realistic count, as an estimate:**
   1. **By Fri 30 Oct: 20 to 22.** 20 if tonight's CDTWL check passes. 22 if CE 00 counts PIT and CD, which add nothing new to the testing.
   2. **By Sat 7 Nov: 26 to 30.** It rises if D24, D21, D06 and D23 pass, if the two builds (D05 recent buttons, D07 raingarden label) are installed and checked, and if your word on D13 comes in. It falls if the Max-like checks or a new build restart the two-pass clock.
7. **What you need to do:** nothing for the count. Questions already on your Monday list that unblock tools: 19 (D13), 20 (D06 settings wording, low priority).

---

## One line per tool, most advanced first

**How to read a line:** tool and D number; plain name; STATUS; the case and the review behind it; the exact next step and who does it; whether a Codex look is still needed for the picture half. "Part" means the case covers only the named part. Reviews are quoted, not re-judged. "On 3.0.84 only" means the build moved to 3.0.85 at 00:21 on 29 Oct and 12 cases owe their second 3.0.85 pass (R01 R02 R02b R03 R04 R05 R07 R10 R14h x3 R16, queued as tester_run77).

### ACCEPTED (19)

1. **D01, PIT and CD keep placing until Esc: ACCEPTED, Tim-confirmed by hand.** Cases R01, R03, R05 (Claude-accepted, ledger 5); your hand checks H1 and H2 passed (PIT, then CD, Esc ends it, the placed pit stays). Holds on 3.0.84 only until tester_run77 runs R01 and R05 on 3.0.85 (Team robot, tonight). Codex look: not needed. Note: an older Codex review (cx_cr20, on 3.0.79) said the "exactly one outcome per command" check was missing; the later ledger count stands.
2. **D14, ERASE a pit, pipes stay, one U restores: ACCEPTED, Tim-confirmed by hand.** Case R19b (ledger 9, two sessions, red twin) and R19 (Opus B5 whole); your hand check H5 passed. Holds on 3.0.84 and the 3.0.85 regrade covered it. Codex look: not needed.
3. **D15, COPY a pit, new number, Check levels: ACCEPTED, Tim-confirmed by hand.** Cases N16 and R34a (Opus B2 and B8 whole, Codex cx_cr23 agrees); your hand check H6 passed. Codex look: G6 (Fri) adds the picture, no count change.
4. **D16, EXPLODE a pit: ACCEPTED, Tim-confirmed by hand.** Cases N02 and N22 (Opus N27 and B2 whole); your hand check H4 passed. Open: BUG-1231 (eight "C1 not updated" lines before the useful sentence). Codex look: not needed.
5. **Recover Inverts (spec card C38): ACCEPTED, Tim-confirmed by hand.** Case R15 (ledger 1; holds on every regrade since); your hand check H3 passed (22 recovered, 29 skipped, totals add up). Codex look: not needed.
6. **D19, every CE Undo step has a plain name: ACCEPTED (PIT half Tim-confirmed).** Cases N07, N17, N18 (Opus B2 whole). Your hand check H7 passed for PIT. The MOVE half was not hand-tested as written (you stretched by grip; the echoes were INTELLIPAN and Grip Edit). Codex look: D8-05 already passed.
7. **D12, one IL text at each pipe end: ACCEPTED.** Case R03 (ledger 5, two sessions, red twin). Next: R03 on 3.0.85, tester_run77 (Team robot). Codex look: not needed.
8. **D17, CDEDIT keeps the selection: ACCEPTED.** Case R20 (ledger 3; Opus CLAUDE-ACCEPTED-READY). Next: R20 passed on 3.0.85. Codex look: not needed.
9. **D04, Esc at CD's third point draws nothing: ACCEPTED (Esc half).** Case R17 (ledger 2; Opus READY). The "Enter gives the straight pipe" half is not in this acceptance. Next: R17 on 3.0.85 passed; owner to decide if the Enter half matters (UNKNOWN). Codex look: D1-04 already passed.
10. **D03, new pipe started on a pit joins it: ACCEPTED.** Cases R02 and R02b (ledger 8). Next: R02 and R02b on 3.0.85, tester_run77. Codex look: not needed.
11. **D18, CE never saves the drawing: ACCEPTED.** Cases N01 with R04 (Opus N27 whole). R04 owes its 3.0.85 pass (tester_run77). Codex look: not needed.
12. **D27, CDSYNC and CDREBUILD warn first: ACCEPTED.** Cases N01 and R13 (Opus N27 whole). Codex look: D4-01 and D4-02 already passed.
13. **CDSYNC keeps the schedule (named check, card C42): ACCEPTED.** Case N26 (Opus B7 whole; Codex cx_cr23 agrees). Open: BUG-855 stays open. Codex look: not needed.
14. **D08, OF and FO share one symbol, own tags: ACCEPTED.** Case N03 (Opus N03N04 whole). Note: after a drawing is reopened in the same AutoCAD see BUG-1225 (Tim passed its fix by hand). Codex look: D7-02 already passed.
15. **D09, pit number and CL cover label: ACCEPTED.** Case N25 (Opus B7 whole; Codex cx_cr23 agrees: lands about 0.1 mm from the click). Codex look: not needed for the count.
16. **D11, short pipe label on a leader: ACCEPTED (robot plus Codex).** Case N20 (Opus B2 part) plus Codex G1 PASS, SURE (ledger 22). Codex look: done.
17. **D20, CDRENUMBER from the outlet up: ACCEPTED (robot plus Codex), not yet shown to you.** Case N15 plus Codex G2 PASS (ledger 21); N24 is part only (Opus B7, Codex cx_cr24). Your hand run H8 printed "nothing to renumber", so the real work was not exercised. Needs Tim: your word on whether the numbering order is the right order. Codex look: done.
18. **D02, a pit catches a pipe end within 100 mm: ACCEPTED (robot).** Case N23 (Opus B7 whole; Codex cx_cr23 agrees, note: it checks 90 mm and 110 mm, not a literal 100 mm). Your hand check H9 was not a valid test (typed angles put both ends inside the reach). Next: offer you a re-run with typed distances (desk). Codex look: not needed.
19. **Tidy labels names the pipe (spec card C37): ACCEPTED, switch ON only.** Case R16 (ledger 4; Opus READY). Your file has the switch OFF; you said yes on 29 Oct to switch it ON by default (answers item 8). Next: R16 on 3.0.85 (tester_run77); the desk makes the default ON in the next train. Codex look: not needed.

### Not yet accepted (19)

20. **CDTWL freeboard (named check, card C39): CASE READY NOT RUN on 3.0.85.** Cases R14 and R14h x3 (Opus B5 whole, hash-matched; they passed twice on 3.0.84). Next: run the three R14h cases twice on 3.0.85 (Team robot, tester_run77, first in the queue, tonight after 5:30 pm). Open: what happens when the two freeboard settings disagree has never been tried. Codex look: not needed.
21. **PIT (named check): ACCEPTED through D01 but NOT counted as its own line.** Case R01 and your hand check H1. Cx_cr20 said the plan keeps PIT and CD as separate entries even though D01 covers them. Next: CE 00 rules whether to count it (no testing needed). Codex look: not needed.
22. **CD (named check): ACCEPTED through D01 but NOT counted as its own line.** Case R01 and your hand check H2. Same ruling. Codex look: not needed.
23. **D24, office layers and current layer kept: PART ONLY, whole case DRAFTED.** N28 covers all five Esc endings (Opus B7 part; Codex cx_cr24 agrees part). N32 (every new object on its layer, with a twin) is drafted and Codex cx_cr25 judges it SOUND. Not built: "never recolour an existing layer", so the card counts only "as built". Next: run N32 twice (tester_run78, Team robot, tonight); Opus review tomorrow; desk rules whether "as built" counts. Codex look: not needed.
24. **D21, Pit Schedule groups and natural order: PART ONLY, whole case DRAFTED.** N29 covers P7 P8 P9 P10 then C1 (Opus B7 part). N33 (LPD, OG, P1 to P10, CP2, CP10, C1) is drafted and cx_cr25 judges it SOUND; N34 (natural order, switch ON) is judged WEAK (P1A only between P1 and P2). Your file has the natural-order switch OFF. Next: run N33 twice (tester_run78), Opus review, case owner tightens N34. Codex look: not needed.
25. **Quick MOVE (named check, card C41): PART ONLY.** Case R12 (Opus B6 part: assertions 2 and 3, labels go with the pit; Codex cx_cr24 agrees part). Codex D3-02 PASS (ledger 11): labels and pipes stay together, one U restores. Missing: four IL texts after the U, a label-direction check, and a hand-placed label after the pit moves. Next: case owner adds the checks (Opus drafter, UNKNOWN date); Codex look G5 queued Fri evening (not one of the 40 by its own brief, but it covers the picture). Codex look: yes.
26. **Edit Pipe cascade with U and REDO (named check): PART ONLY, REDO half has a real fault.** Cases R11 and N11 (Opus B5 and N27 part: IL texts checked, stored levels not). REDO after a pit pick fails in every session (R08, BUG-861 open: UNKNOWN cause; the control run with add-ins moved aside is now approved by you, item 5 of your answers). Next: robot control run in a free window (Team robot); case owner adds a stored-level check (UNKNOWN whether a verb exists). Codex look: not needed.
27. **D06, hide grade in pipe text: CASE DRAFTED.** Case N35 and its twin N35_BROKEN (hashes in ROBOT_MORE_BUTTON_B5_29OCT.md). Opus review: GO TO APPLY, with two small case fixes. The robot may not press "More..." until the change is applied. Card point 3 disagrees with the product (hiding is remembered in a file the guard does not protect: Monday question 20). Next: apply the change after 5:30 pm, then run twice (Team robot). Codex look: not needed.
28. **D23, Excel export with Checking sheet: PART ONLY.** Codex D5-03 PASS: an 11,780-byte workbook with Pit Schedule and Checking sheets and PIT No., FIELD, VALUE, SOURCE headings (ledger 11). No two-session case reads the workbook. Next: case owner writes a file-reading case (a check needing nothing seen); I think this is possible but UNKNOWN. Codex look: done.
29. **D13, hand-placed label stays put: NEEDS TIM.** N27 passes for the part named, switch ON only (Opus B7, Codex cx_cr24). N31 drafted; cx_cr25 judges it WEAK (the 10 mm move can pass with the text left behind; the later tidy only previews). Your file has the switch OFF. The card's literal "label stays at its coordinates" would fail by design because CE carries the text with its pipe end. Next: your answer to Monday question 19 (ride along, my recommendation, or stay exactly put); then N31 strengthened and run; Codex look G7 on Thu evening. Codex look: yes.
30. **D28, one check summary and results window (CDCHECKDWG): NEEDS CODEX LOOK.** Case R40 (cx_cr02 said the case does not prove the actual report; Opus B6 says it needs a Codex look and a desk ruling on card D28 line 817 against BUG-606). Scoreboard says a real fault was seen. Next: Codex look G4 on Thu evening; desk ruling; UNKNOWN whether a fix is queued. Codex look: yes.
31. **D10, mid-pipe label wording and direction: NEEDS CODEX LOOK.** Case R18 exists but cx_cr04 says the rotation or direction is not established, and the robot cannot read a text's angle. Next: a Codex look; UNKNOWN whether a brief is written (G1 to G7 do not include D10; the H1 to H3 and C briefs named in the scoreboard are not in this folder). Codex look: yes.
32. **D05, recent diameter, material and invert buttons: NEEDS BUILD.** You said "yep bring back". Fix B-006 (BUG-1226) is running (team_fix_c77a); the robot guard is N30 (draft). Next: fix installed in a free window, then N30 twice (Team robot). Codex D2-01 was not tested, so the window picture still needs a look. Codex look: yes.
33. **D07, downpipe and raingarden before a pipe: NEEDS BUILD.** N04 passes for the part named (Opus N03N04: DP and CDRG place with nothing refused, area 12.0 m2, one U takes back only the raingarden). The "RG1" label is missing: you said "as recommended", so a label is wanted. Fix B-007 is queued (team_fix_c77b). Next: build, install, add the label to N04; Codex G3 on Thu evening reports facts only. Codex look: yes.
34. **D26, CDSL shows the survey level as existing: PART ONLY.** R35 (typed levels and the 18600 refusal) is Claude-accepted (ledger 6) and Codex D5-02 passed; cx_cr20 says the stored-survey half is not covered. Next: a drawing holding a stored CDSURVEY survey does not exist; someone must build one from non-client data (UNKNOWN who). Codex look: not needed once a fixture exists.
35. **D29, CDFEEDBACK prints one honest result line: NEEDS TIM.** N21 covers Cancel only (Opus B2 part; Cancel closes with one "CDFEEDBACK cancelled." line). Send report was never pressed. Next: your yes plus the spare Windows login (sending from your PC would write a file into the shared office feedback folder). Codex look: not needed for Cancel.
36. **D22, a long Pit Schedule continues on the next sheet with headers: NEEDS CODEX LOOK (blocked).** Codex D6-03 stopped because "Continue to Place / update" stayed disabled; that may be CE behaviour, not the brief. No carpark entry names it. The robot lists the drawn schedule as blocked. Next: desk checks the disabled button first, then re-brief Codex. Codex look: yes.
37. **D30, selecting a pipe or pit brings its ribbon tab forward: NEEDS CODEX LOOK, and possibly a build.** Codex D8-04 was DIFFERENT (Esc returned to Plug-ins, not CE Tools; the brief may be wrong). The scoreboard says a real fault was seen. Next: re-brief and look; UNKNOWN whether a fix is queued. Codex look: yes. No robot case.
38. **D25, existing greyed and demolished dashed on separate layers: NEEDS BUILD.** The card says NOT BUILT: the pit record has a status field with no window to set it, existing pipes use EX DRAIN HATCH in green, not grey, and there is no DEMO layer or "TO BE REMOVED" text. No case, no build item found (UNKNOWN). Next: a decision on whether it stays in the 9 Nov scope. Codex look: yes, once built.

---

## What this report does NOT show (RULES 5.9)

1. **Nothing was run or opened in AutoCAD.** All statuses are read from the ledger and review files.
2. **I did not re-check the installed version.** The ledger says Civil 3.0.85 and Manager 1.1.85 (installed 00:21 on 29 Oct); I did not read the DLL strings.
3. **The count of 19 is CE 00's ruling.** I did not re-derive it. Ledger items 17 to 26 carry slightly different counts (14, 16, 18) depending on build and rule; item 28 is the latest.
4. **The estimates are mine.** They assume tester_run77 and tester_run78 run tonight in the free window and that HOLD_ROBOT.flag is lifted when you say AutoCAD is closed.
5. **The H1 to H3 and C1 to C6 Codex briefs named in the scoreboard are not in CE_PLAN.** I do not know which tools they cover beyond what the scoreboard says.

## Sources read

C:\TimOS\RULES.md; areas\ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md (items 1 to 29, H1 to H9); areas\DAILY_TOOLS_TEST_CASES_2026-10-23.md (head); areas\RELEASE_9NOV_GAP_PLAN_2026-10-22.md (sections 2 and 3); areas\CODEX_CASE_REVIEW_cx_cr20.md (per-card list), cx_cr25.md; areas\ROBOT_NEXT_CASES_SPEC_B4_29OCT.md; areas\ROBOT_MORE_BUTTON_B5_29OCT.md and OPUS_REVIEW_MORE_BUTTON_29OCT.md; areas\CODEX_LOOK_BRIEFS_G_28OCT.md; decisions\2026-10-29_TIM_ANSWERS.md; areas\RELEASE_SCOREBOARD.md; areas\release-v3-colleagues-DESK_LOG.md and BUILD_REGISTER.md; areas\COLLEAGUE_READINESS_29OCT.md; areas\CE_LOG_EVIDENCE_29OCT.md. The Opus B-series reviews were read through their ledger summaries (items 14 to 25), not line by line.

## Summary

Nineteen of 38 named everyday tools are accepted today; the plan names 38, not 40. Thirty by Fri 30 Oct is not reachable. My estimate is 20 to 22 by Fri 30 Oct and 26 to 30 by Sat 7 Nov. Eleven quickest: CDTWL, PIT, CD (ruling), D24, D21, quick MOVE, D06, D23, D13, D28, D10. Builds needed: D05, D07, D25. Your word needed: D13, D29.
