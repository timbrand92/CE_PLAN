# Tim's answers, Thu 29 Oct 2026 (questions-partner side session)

Source: Tim, in the questions-partner chat, about 09:50 Melbourne. Batch 1 of the open items in QUESTIONS_FOR_MONDAY.md (items 14 to 18). Documents checked first: QUESTIONS_FOR_MONDAY.md, decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md (UX-SRC-03), BUG_CARPARK.md (BUG-861, BUG-1223, BUG-1226), areas/release-v3-colleagues-BUG1223_FIX_REPORT.md.

1. **Team login (QUESTIONS item 17): NOT ANSWERED, still open.**
   1. Tim's words: "claude team should be logged in?"
   2. Interpretation: he believed he was already logged in, or asked whether it was. The side session ran `claude auth status` with CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team at 09:45 and it read loggedIn false (credentials file last written 05:20).
   3. Desk must: keep desk_jobs\HOLD_ROBOT.flag and keep using Max Agents. Do not lift the hold until Tim says the login is done and the status shows loggedIn true.

2. **BUG-1226 Recent levels buttons (QUESTIONS item 16): bring them back.**
   1. Tim's words: "yep bring back".
   2. Interpretation: the 'Recent levels' / 'Use recent invert' buttons were NOT meant to be dropped; card D05 stands. It is a fix, not a card change.
   3. Desk must: file or keep BUG-1226 as a build fix: the New Pipe window CD opens (the one-page layout) must show the last pipe's levels as 'Recent:' buttons; check Edit Pipe too. Robot case N30 is the guard. Settings-first and one-page-window rules apply. Not FIXED until Codex or Claude acceptance.

3. **Raingarden RG1 label (QUESTIONS item 15): a label is wanted, build it.**
   1. Tim's words: "as recommended" (recommended answer was (b): a label is wanted and it is missing).
   2. Interpretation: CDRG draws a label tagged RG1, RG2 and so on, consistent with his 25 Sep 2026 ruling UX-SRC-03 ("RG1, RG2 (Recommended)"). The card is right.
   3. Desk must: add a build item for a raingarden label (same behaviour as DP and OF tags). Until built, D07 counts only for the part that is tested.

4. **BUG-1223 floor waste on an inspection opening (QUESTIONS item 18, new): no.**
   1. Tim's words: "as recommended" (recommended answer: no, CE keeps its plain refusal).
   2. Interpretation: a floor waste is NOT allowed on top of an inspection opening; CE refuses with the plain sentence ("IO2 is already at this point...").
   3. Desk must: keep draft PR #1833 as built; change runner cases R36e, R36e_p2, R36e_p3, R36e_p4 to expect the refusal message with nothing placed (contains "is already at this point", count 0 for placements). No new sharing rule is needed.

5. **BUG-861 control run (QUESTIONS item 14): yes.**
   1. Tim's words: "yes".
   2. Interpretation: the robot may move the installed add-in folders aside one set at a time (Structural, Manager, CE.AutoCADLink.2027.bundle, CE.Transform.Trial.2027.bundle) for a controlled run, restoring each by hash. Tim's yes covers moving them aside; it does not cover anything else. GUESS: timing. The side session told Tim the run would be after 5:30pm or when he says AutoCAD is closed; he did not object.
   3. Desk must: before each run record the original hashes and a backup copy of each folder; AutoCAD closed (check yourself twice); restore and verify by hash at the end of every run; say where the backup is and the one-step undo; run in a free window (rule 1.8); report which add-in set made REDO work.

## Batch 2 (about 10:00 Melbourne)

6. **#1788 drainPluginOutbox (QUESTIONS item 13): extras accepted; the main question is OPEN.**
   1. Tim's words: "why would we keep it off if it can help the plugin? agreed to two small extras".
   2. Interpretation: (a) ACCEPTED: a figure typed with a comma (630,5) is refused instead of being read ten times too big; an unset material speed in the pipe-speed check falls back to the office figure. He did not ask for a message on the second, so no message (GUESS: silence means no message). (b) The "keep it OFF" recommendation was a challenge, not a decision. It is NOT a ruling to switch it on. It ships OFF as built; that is the current state, not a decision by Tim. Reasons given to him: with it ON, Manager writes usage and fault records with a scrubbed drawing label to the office IT folder; two independent reviews (Codex HOLD, Opus merge-with-fixes) disagreed; nobody has said who may receive the reports or which fields may leave the PC.
   3. Desk must: keep the switch OFF, keep the two extras, and wait for Tim's answer to: who may receive the reports, and may the short list (job number, command failure) be sent. Do not turn the question into a decision.

7. **BUG-1090 computations sheet line (QUESTIONS item 9): NOT ANSWERED.**
   1. Tim's words: "is that what we do currently?"
   2. Answer given to him: no. Today the sheet and CDRULES show pipes passing and nothing says the hydraulic grade line and pit losses were not checked (BUG-1090 symptom). The draft PR #1771 would print the sentence on every council sheet.
   3. Desk must: leave PR #1771 out of the next update until he says yes or no.

8. **Tidy labels switch ON by default (QUESTIONS item 7): yes.**
   1. Tim's words: "yes".
   2. Interpretation: the "Tidy labels names the pipe" switch is ON by default for colleagues and for new installs.
   3. Desk must: set the default ON in the next train; Tim's own settings file may still hold OFF (check it and say so).

9. **Grip copy switch ON for the office (QUESTIONS item 8): yes.**
   1. Tim's words: "yes".
   2. Interpretation: the switch "Clean up grip Ctrl-drag, ROTATE Copy and SCALE Copy like COPY" is ON by default. GUESS: the question text said "yes, once a robot run passes with it on"; I kept that condition (turn the default ON after a robot pass with it on) because Tim answered the question as worded.
   3. Desk must: run the robot pass with it ON, then ship the default ON; Tim's file may need the value changed.

10. **Import with no units set (QUESTIONS 22 Oct item 1, BUG-505): yes.**
   1. Tim's words: "yes".
   2. Interpretation: keep importing as millimetres and print one soft line "This drawing has no units set; CE read it as millimetres." A note, never a block.
   3. Desk must: build it as a note only (R-27, no hard block).

## Batch 2 follow-up (about 10:10 Melbourne)

11. **Team login (QUESTIONS item 17): done.**
   1. Tim's words: "login successful" (then "try look again").
   2. Verified, not assumed: at 10:02 the Team credentials file was rewritten and `claude auth status` with CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team read loggedIn true, orgName Creative Engineering, subscriptionType team.
   3. Desk must: lift desk_jobs\HOLD_ROBOT.flag and go back to Team for headless jobs.
   4. **New request from Tim (not a ruling): "can we set this up so it automatically always opens automatically without me everytime the compouter restarts".** Interpretation (GUESS): after a restart the desk's Team jobs and lanes should start again and stay logged in without Tim doing anything. The login itself is saved on disk and survives a restart; the 29 Oct expiry was the sign-in running out, cause not known. Desk must: propose (not build; no new script without Tim's approval, rule 10.5) how the lanes restart after a reboot, and say what happens when the Team sign-in expires again. Ask Tim to approve before any startup task is created.

12. **#1788 drainPluginOutbox receiver (QUESTIONS item 13): the receiver is Tim.**
   1. Tim's words: "everything goes to me as the coordinator/manager".
   2. Interpretation (GUESS on the fields): every report from colleagues' PCs is sent to Tim, and Tim alone reads them. Not confirmed: whether "everything" also means client names and drawing names, and whether the office IT folder can be opened by anyone besides Tim. Rule 11 (private data, client-identifying evidence is local-only) and the OneDrive syncing warning (11.7) still apply, so those two points are put back to Tim in the next batch.
   3. Desk must: keep the switch OFF and change no code until Tim answers the field question and the folder question.

13. **BUG-1090 computations sheet line (QUESTIONS item 9): asked again.**
   1. Tim's words: "do we do that in the non - ce plugin comps sheets? why should we add ?"
   2. Answer given to him: CE_PLAN does not show what other plugins' sheets print. Civil 3D calculates a hydraulic grade line (CE_VS_CIVIL3D_DRAINAGE_COMPARE_2026-10-10.md item 1), so its sheets have one; CE has none. Frankston, Banyule and Whitehorse ask for the HGL on the long section.
   3. Desk must: leave PR #1771 out until Tim says yes or no. Not a decision.

## Batch 3 (about 10:30 Melbourne)

14. **#1788 drainPluginOutbox fields and folder (QUESTIONS item 13).**
   1. Tim's words: "no and yes" (answering: does "everything" include client names and drawing names? / can anyone besides you open the office IT folder?).
   2. Interpretation (GUESS, he gave one word each): fields: NO, client names and drawing names do not leave the PC (the recommended short list: job number, command that failed, which PC). Folder: YES, other people can open the office IT folder, so nothing client-identifying may go there. Receiver stays Tim.
   3. Desk must: keep the switch OFF until it is scheduled; when built, send only the short list; never delete anything unsent. If Tim meant the opposite, he will say.

15. **BUG-1090 computations sheet line (QUESTIONS item 9): yes, every sheet.**
   1. Tim's words: "do as you recommend" (recommended: print the line on every council sheet). He also asked: "i meant our current jobs where we dont use the or a plugin for computations ... how does our comp sheet look and how does our package compare to what is being sent out by our company now?" (his earlier question "do we do that in the non-CE plugin comps sheets?" meant the company's hand-made sheets for current jobs, not other software).
   2. Interpretation: build PR #1771's line on every council sheet. The comparison of the CE sheet with the package the company sends now is a NEW request, not yet answered (see item 23).
   3. Desk must: include PR #1771 in the next update after the usual review.

16. **Rainfall curve note, BUG-866 (QUESTIONS 22 Oct late item 1).**
   1. Tim's words: "leave them until you've checked the curve".
   2. Interpretation: the curve numbers are NOT changed. He did not separately say yes or no to the new note wording ("may be high or low by up to about 8 per cent; storage moves about 2.5 times as much"). GUESS: build the note as a draft, since the old note ("7 to 9 per cent high") is wrong on the two Glen Eira sheets checked; the desk says so in the next report so Tim can object.
   3. Desk must: check the curve against the guidebook and the council sheets (part of item 23), then report; change no curve value.

17. **Cover to the outside of the pipe (QUESTIONS 22 Oct late item 2): yes.**
   1. Tim's words: "yes, add the pipe wall: about 20 mm for UPVC 225 and about 45 mm for concrete 375".
   2. Interpretation: cover is measured to the outside top of the pipe (AS/NZS 3500.3). The wall figures quoted are examples for those two pipes; the desk must take the wall thickness per size and material from the pipe data, not hard-code them (Settings-first R-00). GUESS: other sizes follow the same rule.
   3. Desk must: build it with the wall thickness from Settings or pipe data; show cover before and after on one job; warn that a pipe at the minimum cover may newly warn.

18. **Pit drop where the pipe gets bigger (QUESTIONS 22 Oct late item 3): yes.**
   1. Tim's words: "yes".
   2. Interpretation: warn (never block, R-27) when the outlet pipe top sits above the inlet pipe top at a pit, as well as when inverts are wrong.
   3. Desk must: build the warning.

19. **Minimum grade table (QUESTIONS 22 Oct late item 5): the guidebook decides.**
   1. Tim's words: "review guidebook and save this guidebook in the memory of this plugin im sick of mentioning it and always being asked."
   2. Interpretation: no number given. The Civil and Drainage Design Guidebook v1.3 is the authority for minimum grades; the desk takes the values from it, not from the old office table. Not a decision on 450 and larger until the review reports.
   3. Desk must: read the guidebook for the minimum grade by size; show Tim the difference from the office table in Settings.

20. **Unknown pipe material roughness, BUG-868 (QUESTIONS 23 Oct evening item 1): Settings roughness.**
   1. Tim's words: "yes". Interpretation: use the Settings roughness (0.013) for an Unknown material. Desk must: keep the draft PR #1664 behaviour.

21. **Wording (QUESTIONS 23 Oct evening item 2): "Unknown" everywhere.**
   1. Tim's words: "yes". Desk must: use "Unknown" in messages for missing values.

22. **Double-click on the green DP label, BUG-860 (QUESTIONS 22 Oct item 3): yes.**
   1. Tim's words: "yes". Interpretation: opens the same Edit source window as the symbol, only when the label belongs to that downpipe; otherwise plain text edit. Desk must: build it.

23. **STANDING RULING AND NEW REQUEST: the Civil and Drainage Design Guidebook v1.3.**
   1. Tim's words: "review guidebook and save this guidebook in the memory of this plugin im sick of mentioning it and always being asked" and "i need you to compare all our engineering vs our current guidebook for design, then update our plugin to suit and then need to create a document with questions for civil engineers but it needs to have context and cant be super technical and with all this jargon it needs to be in simple english and qwuestions need to be studied before being actually added to this questions, then we need to update the guidebook to suit. make se you review images and text within it".
   2. Where it is: `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Engineering\Civil Stuff\Councils\CIVIL AND DRAINAGE DESIGN GUIDEBOOK.docx` and `... v1.3.pdf` (both dated 5 Feb 2026, 53 pages). CE_PLAN already holds notes on it: `02_COUNCIL_RULES\CE_GUIDEBOOK_V1_3_SUPERSEDES.md` (v1.3 wins over v1), `02_COUNCIL_RULES\CE_DESIGN_GUIDEBOOK_RULESET.md`, `COUNCIL_DIFF_V1_TO_V1_3.md`. Every session must read these and never ask Tim for the guidebook again.
   3. Interpretation: four stages. (a) Compare all of CE's engineering (ENGINEERING_RULEBOOK, Settings values, code behaviour) against the guidebook text AND its images and tables. (b) Draft the plugin changes needed, as Settings values and cards; nothing is coded until the command review gate (cards, Tim's approval) is done, and nothing changes in the live bundle. (c) Write a plain-English questions document for civil engineers, each question studied and checked before it is added, with context and no jargon. (d) Update the guidebook to match what CE and the engineers settle on. GUESS: "update our plugin to suit" means guidebook-led values go into Settings with the guidebook as the source, not that CE overrides Tim's office rules without his word.
   4. Desk must: start stage (a) in its own session (proposed as a card); report the CE comps sheet versus the package the company sends now (client material read locally only, nothing copied into a repo, rule 11).

## Batch 4 (afternoon, Melbourne)

24. **Test machine licence (QUESTIONS item 31, free question for the office admin): the office has spare AutoCAD licences.**
   1. Tim's words: "we have spare autocad licenses".
   2. Interpretation (GUESS on the details): at least one AutoCAD seat is unassigned, so a test machine (the spare PC or the AutoCAD 2026 laptop) can use its own seat and the robot need not sign Tim out of his own. Not stated: which AutoCAD year the spare seat covers (2026 or 2027), who assigns it, and whether the laptop or spare PC already has one signed in. Not a decision to install anything on any machine.
   3. Desk must: record the licence question as answered in principle; ask Tim only which year the spare seat is and who (office admin) assigns it to the laptop's user; do not install or sign in anything on another PC without his word (decisions\2026-10-29_TIM_RELEASE_FREEZE.md item 4). No paid tools (decisions\2026-10-29_TIM_NO_PAID_TOOLS.md).

## Batch 5 (afternoon, Melbourne; Tim answered the corrected batch of 22 to 33)

25. **Max's AutoCAD year and Windows rights (QUESTIONS item 22): year answered; rights not.**
   1. Tim's words: "he will have 2027, currently has 2022".
   2. Interpretation (GUESS on timing): Max is on AutoCAD 2022 today and will be on 2027 before the pilot. Not stated: when he upgrades, and whether he can install programs. Because his year is 2027, the paid cloud test (item 32) is not needed; paid tools are ruled out anyway (decisions\2026-10-29_TIM_NO_PAID_TOOLS.md).
   3. Desk must: keep the pack on 2027; keep BUG-1209 and BUG-1210 on the known-problems page as a note for anyone on an older year; do not install anything on Max's PC before his 2027 is in. Ask Tim once more for the date and the install rights when the pilot pack is near.

26. **Spare ordinary Windows login for install rehearsals (QUESTIONS item 23): Tim organises it.**
   1. Tim's words: "i will organise".
   2. Interpretation (GUESS): Tim will set up the standard (non-administrator) login himself. Item 23 was replaced by the laptop item 33, so this may refer to either; the desk should not assume which machine.
   3. Desk must: wait for Tim to say the login exists and which PC; start no rehearsal before that.

27. **What goes into the frozen build (QUESTIONS item 27): the latest version.**
   1. Tim's words: "the latest version ideally".
   2. Interpretation: consistent with his earlier "option b": freeze on Fri 6 Nov with the latest passing build (C-76, C-77 and the pilot-critical fixes), not a Sat 31 Oct build.
   3. Desk must: freeze the latest reviewed build on 6 Nov; nothing frozen early.

28. **Where the frozen copy sits (QUESTIONS item 24): yes.**
   1. Tim's words: "Recommended: a separate `CE V3 PILOT` folder, shared "can view" to Max only, with the July copies untouched."
   2. Interpretation: approved as the plan. GUESS: the folder is created and shared at the publishing step after the 6 Nov freeze, with the desk saying when before it does (his approval was of the place, not of sharing today).
   3. Desk must: create the folder and share only to Max at the packaging step; never touch the July copies.

29. **Two gate settings (QUESTIONS item 26): yes to both.**
   1. Tim's words: "Recommended: yes to both."
   2. Interpretation: (a) the administrator set-up on Tim's PC is right; (b) Structural stays on Tim's PC only, so gate items 6 and 7 (Publish Issue stamps, job record) are out of the pilot gate.
   3. Desk must: mark gate item 1 confirmed by Tim and remove items 6 and 7 from the gate.

30. **BUG-905 hard-ground runoff 0.9 (QUESTIONS item 20a): yes.**
   1. Tim's words: "Recommended: yes, 0.9. Your real OSD4W printout uses 0.90 for existing hard area. I haven't confirmed the guidebook gives the same figure."
   2. Interpretation: 0.9 is right for hard ground in CDCALC Boyd's; the fix is switched ON. The guidebook figure is not yet confirmed (the guidebook audit session may check).
   3. Desk must: switch the BUG-905 fix ON in the next train; ask the guidebook audit to confirm 0.9 on its page and tell Tim only if it disagrees.

31. **BUG-1097 the 300 mm head check (QUESTIONS item 20b): the head left after losses.**
   1. Tim's words: "Recommended: the head left after losses, because that's the real head at that point. On 25 Oct the desk's view was to keep the typed head as built. This is the newer view."
   2. Interpretation: the 300 mm minimum head check uses the head left after pipe losses (supersedes the 25 Oct "keep the typed head" draft view).
   3. Desk must: change PR #1772's check to the head after losses; keep it a warning (R-27).

32. **Fixes for the freeze, BUG-1095, BUG-1091, BUG-1088 (my question 5): build all three.**
   1. Tim's words: "build all three before 6 Nov."
   2. Interpretation: all three are built and in the frozen build, not warned. (CE 07 already read them as in the build list.)
   3. Desk must: build all three before the 6 Nov freeze.

33. **Test laptop with AutoCAD 2026 (QUESTIONS item 33): Tim will use another PC with 2027 instead.**
   1. Tim's words: "i will get 2027 on another pc".
   2. Interpretation (GUESS): Tim is not providing the 2026 laptop; he will get AutoCAD 2027 on another PC. The six laptop questions (whose, login type, sign-in, when free, powered on, network) are not answered. Together with decision 24 (spare AutoCAD licences), this suggests a spare seat of 2027 on that PC, not confirmed.
   3. Desk must: pause the 2026 laptop assessment; ask Tim which PC, when, who assigns the licence; install nothing on any PC without his word. The robot driver was built for 2027, so a 2027 PC is the easier route.

34. **Re-test rule detail (my question 6, new switch only): NOT ANSWERED yet.** Tim's reply did not include it. The testing session keeps treating any settings change as a full re-test.

24. **GUIDEBOOK QUESTIONS, Tim's marks on the 16 DRAFT questions (29 Oct 2026, after the walk-through; `areas/GUIDEBOOK_ENGINEER_QUESTIONS_DRAFT_2026-10-29.md`).**
   1. Tim's words, one line per question: "1. as the guidebook says" / "2. as the guidebook says" / "3. use the table, with a council figure still winning" / "4. warn for every pipe, using its real size" / "5. B for shared residential driveways, C where larger vehicles drive over" / "6. plain connecting drains may pass under in 150 SN8; detention pipes may not" / "7. engineers name the figure and the document; CE only warns until then" / "8. site figures for Boyd's jobs; keep the OSD4W zone for OSD4W jobs" / "9. no minimum" / "10. the engineer decides per job; CE asks once and records it" / "11. follow the newer council pages, keep Casey's orifice formula" / "12. the engineer enters stub size and fall; CE works out the capacity and warns" / "13. keep the sweep and print the 2-hour answer beside it" / "14. if nobody can point to the document, drop it" / "15. design by the book's sheet" / "16. the splay offset, crossover width, spot levels, tank size, sewer-quality pipe, IOs at bends, and all pits scheduled become checks for every council. The rest stay per council".
   2. Interpretation: 3 to 6, 8 to 16 accept the recommended answers written in the draft. **Q1 and Q2 differ from the recommendation:** Tim chose "as the guidebook says", so ordinary gravity pipes are **1 in 100 at every size** (no size ladder) and detention pipes are **1 in 200 from 225 up for Darebin, Banyule, Manningham and Maroondah only**. GUESS (open): for Manningham the book says 1 in 200 and the council's own 2021 checklist says 1 in 180; "as the guidebook says" is read as 1 in 200, flagged for Tim. This replaces the office ladder (1:200 at 225, 1:250 at 300, 1:300 at 375, 1:200 at 450 and up) and the every-council 1:200 detention rule. Consequence to tell Tim: real 2026 company drawings lay detention pipes at about 1 in 200 in councils that are not in the four, so those jobs will newly warn; and 450 and larger gravity pipes now warn flatter than 1 in 100.
   3. Q7 stays open (the engineers must name the figure and document); Q14 is conditional (drop the Bayside 1 in 20 only if nobody can point to a document). Items 1 to 13 are Tim's working answers; engineers may still correct them before stage 4 updates the guidebook.
   4. Desk must: stage 2, draft command cards (Settings values first, warn and record, never block) for Tim's approval before any code; supersede the minimum grade ladder (R-03) and the every-council detention grade (R-32) only when the card is approved; nothing changes in the live bundle.

## Batch 6 (afternoon, Melbourne)

35. **Re-test rule, new switch only: yes.** Tim's words: "yes. An Edit Pipe fix then re-tests 7 checks (about 1 hour) instead of all 66 (about 6 h 40 min)". Recorded as Addendum 1 in decisions\2026-10-29_TIM_RETEST_RULE.md.

36. **Spare AutoCAD seat and the other PC: 2027.**
   1. Tim's words: "i will get 2027 on that pc".
   2. Interpretation: the other PC gets AutoCAD 2027 (Tim installs it), on the office's spare seat (decision 24). Not stated: which PC, when, who assigns the seat, whether it stays awake and unlocked, how it reads the plan folder (QUESTIONS item 37 still open).
   3. Desk must: wait for Tim's word that the PC is ready; install nothing before.

37. **Pipe sizer, BUG-1088 (QUESTIONS 21a): yes.**
   1. Tim's words: "yes. Today a 40 L/s connection comes out DN100 at about 1 in 3. With the rule it's DN225 at about 1 in 200".
   2. Interpretation: CDDESIGN and network redesign use the flattest grade each size is allowed and step up a size before going steeper. No new number (28 Sep rule, warn above 1 in 10).
   3. Desk must: build it before the 6 Nov freeze (decision 32).

38. **Council time of concentration, BUG-1099 (QUESTIONS 21b): yes (GUESS).**
   1. Tim's words: "On a bare 600 m² Maroondah lot, CE says 5.18 L/s permitted discharge and the council method says 3.68, so the tank comes out too small" (he pasted the example without the word yes).
   2. Interpretation (GUESS): he agrees the council's own time of concentration should drive permitted discharge and storage, with the office 5 min kept for the pipe (the recommended answer). If he meant otherwise he will say.
   3. Desk must: build two times of concentration (council's for storage and permitted discharge, office 5 min for the pipe) as a draft; tell Tim in the next report that this one was read as yes.

39. **Rainwater reuse boxes, BUG-1096 (QUESTIONS 21c): yes.**
   1. Tim's words: "yes. On a Manningham job a 3,000 L plumbed tank credits 1.50 m³ and today the sheet shows none".
   2. Interpretation: a "Rainwater reuse" group on the CDDESIGN page (tank litres, roof connected pre-filled, "plumbed for reuse" tick), built with the Kingston credit fix (BUG-1098); the sheet says "needs confirmation" where a council has no recorded rule (R-10).
   3. Desk must: build it as above.

## Batch 7 (afternoon, Melbourne)

40. **Max's move to 2027 (QUESTIONS item 36): "yes" (GUESS).**
   1. Tim's words: "yes".
   2. Interpretation (GUESS): he accepts the recommended plan, Max on AutoCAD 2027 by about Fri 13 Nov so the Mon 16 Nov hand-over works. The question asked two things (when, and can his login install programs); "yes" does not say which. Install rights are NOT answered.
   3. Desk must: plan on Max's 2027 by Fri 13 Nov; ask Tim once more for the install rights near the pack stage; install nothing on Max's PC before his 2027 is in.

41. **The other 2027 PC (QUESTIONS item 37): ready maybe tomorrow.**
   1. Tim's words: "tomorrow maybe".
   2. Interpretation: Tim may have the other PC ready about Fri 30 Oct; not certain. Which PC, awake and unlocked overnight, and how it reads the plan folder are not given.
   3. Desk must: not plan on it; ask Tim for the PC name when he says it is ready; install nothing before.

42. **BUG-1192 long section where the survey is not trusted (QUESTIONS 21d): yes.**
   1. Tim's words: "yes".
   2. Interpretation: CDPROFILE draws the untrusted stretch of ground line dashed with the note "Ground not confirmed here: check survey", on its own Settings switch, alongside the warning line.
   3. Desk must: build it.

43. **BUG-587 Pit Schedule row height (QUESTIONS 21e): NOT the recommended answer; a row does not just grow one line.**
   1. Tim's words: "no - reduce line spacing or yes but you have to make that entire row two rows thick and it needs wipeouts like the structural xclmtxt command".
   2. Interpretation (GUESS on the order): (a) first try: reduce the line spacing of a remark so more lines fit in the standard row; (b) if a remark still needs more room, the whole row becomes two rows thick (not one extra line), and the text sits on a wipeout (a mask) like Structural's XCLMTXT command. Tim wrote both with "or"; it is not clear whether he wants (a) always or only when it fits.
   3. Desk must: read XCLMTXT in the Structural module to copy how it masks text; build (a) first and (b) for what does not fit; show Tim a picture of a three-line remark in each before it ships (rule 5.2); never one line taller. Ask Tim the order only if the picture does not settle it.

44. **BUG-587 (same item), existing schedules: unchanged.** Tim's answer implies ordinary rows keep their height (his words keep rows in whole-row steps). Desk must: no existing schedule row moves.

45. **AG drain (QUESTIONS 21f and 21g): answers conflict; clarification needed.**
   1. Tim's words: "1. yes" (a copied AG drain gets its own grade label worked out from its own levels) and "2. no text needed, agis are shown location only" (to the question: keep the wording "AG DRAIN AT 1 IN 50"?).
   2. Interpretation (GUESS): the AG drain label should carry no wording, AG drains are shown by location only; if so a grade label on a copy is not drawn. These two answers do not fit together unless "yes" meant the copy keeps its own stored grade, with nothing printed. Not decided.
   3. Desk must: build nothing on the AG drain label until Tim answers one line: "Should an AG drain show no text at all, including no grade, on the original and on a copy?" Recommended to him: no text at all, but the grade still stored for the schedule.

25. **CLAUDE API ASSISTANT, own card (29 Oct 2026, same conversation as item 24).**
   1. Tim's words: "is there a way through the claude api that we can have machine learning be smart?" then, asked whether the API work is its own card or waits: "yes add its own card".
   2. Interpretation: the API work is planned as its own card, GB-05, behind the plain GB-04 ready-to-submit checker. Claude reads, checks and drafts and proposes only; every number stays on Settings and plain rules; nothing is written without Preview, Apply and one Undo. Builds on the already-approved Ask CE plan (AI-01); no model training. Not approved, not built.
   3. Draft cards for all the guidebook changes: `04_REFERENCE/guidebook-cards/` (GB-01 pipe and pit checks, GB-02 council data, GB-03 calculations, GB-04 ready to submit, GB-05 Claude assistant), all DRAFT for Tim's approval before any code. Open for Tim in GB-05: provider and model, cost ceiling, who gets it, and confirmation that the 22 Oct privacy finding on the AI connection is fixed.

## Batch 8 (afternoon, Melbourne)

46. **AG drain label (QUESTIONS 21f, 21g, clarification): no text at all.**
   1. Tim's words: "no text at all" (to: should an AG drain show no text at all, on the original and on a copy?).
   2. Interpretation: an AG drain carries no label text, original or copy; it is shown by location only (this settles the conflict in item 45). Recommended to him, not stated by him: the grade is still stored for the schedule (GUESS that this part stands).
   3. Desk must: draw no text for AG drains; keep the stored grade; the "AG DRAIN AT 1 IN 50" wording is not drawn.

47. **BUG-685 typed level not to the nearest 10 mm (QUESTIONS 21h): recommended answer.**
   1. Tim's words: "keep the 10 mm rule but say it in one line: "Typed level 10.125 held as 10.13 (levels are held to the nearest 10 mm)". The grade stays exactly 1 in 100".
   2. Interpretation: levels are held to the nearest 10 mm; CE prints one line saying so when a typed level is rounded; the grade stays exactly as asked.
   3. Desk must: build the one-line note (a note, never a block, R-27).

48. **BUG-1148 pasting a pit between Save As stage drawings (QUESTIONS 21i): known limit for the pilot.**
   1. Tim's words: "treat it as a known limit for the pilot, with one line on the known-problems page, "check the pit after pasting from a stage drawing". Build the fix after a workflow card".
   2. Interpretation: no fix before the pilot; one line on the known-problems page; the "made in this drawing" stamp waits for a workflow card.
   3. Desk must: add the line to page 04 and write the workflow card after the pilot gate.

49. **Blue in the long section water line (QUESTIONS 21j): yes, one place only (GUESS on the words).**
   1. Tim's words: "may it stay blue? Recommended: yes in that one place only. You see a picture first" (pasted the recommended answer).
   2. Interpretation (GUESS): the water line stays blue, nowhere else; Tim sees a picture first. The pit snap glow (21k) was not answered.
   3. Desk must: keep the water line blue and show Tim a picture; leave the pit snap glow as it is until he answers 21k.

50. **Pipe wall table (QUESTIONS 21l): from the pipe data or the standard.**
   1. Tim's words: "the desk takes each size and material from the pipe data or the standard and shows you the table on Settings, tagged Assumed until you tick it".
   2. Interpretation: wall thickness per size and material comes from the pipe data or the standard, is shown on Settings tagged Assumed until Tim ticks it. His earlier "about 20 mm UPVC 225" was an example (decision 17); the desk uses the table.
   3. Desk must: build the table on Settings with the Assumed tag; verify UPVC wall against the standard (CE 01 thought 20 mm looked high).

## Batch 9 (afternoon, Melbourne)

51. **Pit snap glow colour (QUESTIONS 21k): yes, gold.** Tim's words: "yes". Interpretation: the temporary glow when snapping to a pit changes from light blue to gold; picture first. Desk must: build it behind a Settings switch and show Tim a picture before it ships.

52. **BUG-1189 survey XREF detached after approval (QUESTIONS 24 Oct item 5): keep as built.** Tim's words: "keep it as built, because CE can't check a survey it can't see". Desk must: keep draft PR #1756 as built (stops offering stored levels, says the XREF is no longer in the drawing; typed levels still work; the switch can turn the check off).

53. **BUG-1149 stage drawing BIND versus accidental detach (QUESTIONS 24 Oct item 6): keep the yellow.** Tim's words: "keep the yellow. A false red Fail on a normal BIND would train drafters to ignore Fails". Desk must: keep draft PR #1767 as built (yellow warning, not a red QA Fail).

54. **Old July install files (QUESTIONS item 25, BUG-483): move now, delete on a timeline.**
   1. Tim's words: "yes - set a timeline to delete".
   2. Interpretation: move `Install-All-CE-Plugins.ps1`, `CE CVL SUITE`, `CE STR SUITE`, `CE SUITE MANAGER` and `CE_CVL_SUITE_Installer_v2.1.11.exe` into an OLD folder before the pilot; later delete them on a dated timeline. Rule 10.4 still applies: every file to delete is listed for Tim's yes before anything is deleted. The date is NOT his: it is proposed (see 3).
   3. Desk must: move first (nothing deleted); proposed delete review date Mon 14 Dec 2026 (four weeks after the Mon 16 Nov pilot starts; GUESS, for Tim to change); on that date list every file for his yes. Ask Tim whether any colleague still installs from them (he did not say) before moving, and tell colleagues who do.

55. **Card D06 point 3, hide-grade setting (QUESTIONS item 20, card): agreed.** Tim's words: "agreed". Desk must: reword the card so the test turns the grade back on before it ends, and compare the remembered-values file before and after; do not widen the robot's settings protection to that file.

## Batch 10 (afternoon, Melbourne; Structural batch and the test PC rules)

56. **LBH and LBUH hatch scales (QUESTIONS 23 Oct early item 1): Tim gave the numbers.**
   1. Tim's words: "hacth scale 50 at 1:100 and scale 10 at 1:20. lbuh hacth scale 20 at 1:100 and scale 4 at 1:20".
   2. Interpretation: LBH (load-bearing wall hatch) pattern scale 50 at 1:100 and 10 at 1:20; LBUH 20 at 1:100 and 4 at 1:20. That is 0.5 times and 0.2 times the drawing scale, so the lines keep the same spacing on the printed sheet. This replaces the "minimum line spacing" recommendation. GUESS: other scales (for example 1:50) follow the same straight proportion (LBH 25, LBUH 10); "hacth" read as hatch. The numbers are Tim's, not assumed.
   3. Desk must: put these four values on the Settings page (Settings-first), compare with the installed values, and tell Tim what changed; a wall nib must show hatch at 1:100; tell Tim the 1:50 value it derives.

57. **SBEAM versus CEMEMBER size (QUESTIONS 23 Oct early item 2): part answered, part unclear.**
   1. Tim's words: "1:100 draw at real size, 1:20 draw 5 times bigger. does that make sense?"
   2. Interpretation: 1:100 at real size confirms CEMEMBER (298 mm for a 310UB32); SBEAM's 1490 mm is exactly 5 times that, so SBEAM draws 5 times real size at 1:100. The "1:20 draw 5 times bigger" part is not clear: a real-size beam already prints 5 times bigger on paper at 1:20 than at 1:100, so Tim may mean that, or he may mean 5 times real size in the drawing at 1:20. NOT settled.
   3. Desk must: keep the real-size draw (CEMEMBER); ask Tim one line: "Do you want the beam drawn at real size at every scale, so it prints 5 times bigger on paper at 1:20 without being enlarged in the drawing?"

58. **Hatch refusal when LTSCALE is not 10 x DIMSCALE (item 3): yes.** Tim's words: "yes". Interpretation: warn and draw using DIMSCALE (his 20 Oct ruling), never refuse (R-27). Desk must: build it.

59. **Fixed label heights (item 4): yes.** Tim's words: "yes". Interpretation: TH, PF, BP, column and 18-text labels follow the label height setting like EBT already does (BUG-531). Desk must: build it.

60. **Corrected steel section list (CEMEMBER review item 4): yes.** Tim's words: "yes". Interpretation: the corrected 17-type list goes into the installed command now with the code it needs (310UB32.0 accepted, Z15015 added, 380PFC web 10 mm). Desk must: build it; Structural stays on Tim's PC only.

61. **Robot hours rule on the second PC (QUESTIONS item 38): Tim's PC only.** Tim's words: "no only my computer, on the other one testing all day". Interpretation: the stop on starting AutoCAD in Tim's drafting hours applies to Tim's own PC only; the test PC runs all day and night (the "no" is to applying it to both; the substance is the recommended yes). Desk must: apply the hours rule to Tim's PC only; the robot still refuses to start beside another AutoCAD on the same PC.

62. **Codex looks on the test PC (QUESTIONS item 39), and who accepts: yes, Claude and Codex.**
   1. Tim's words: "yes definetely, remember i dont want to test anything unless i say i can you two will be in charge of acceptance".
   2. Interpretation: a Codex pass on the test PC counts as Codex-accepted with the PC's name beside it. GUESS: the conditions in the question stand (the PC has its own licence seat; its graphics card and screen scale are compared on three cases against Tim's PC first; a window that looks wrong only there is re-looked on Tim's PC). Standing rule restated: Tim does not test unless he says he can; Claude and Codex own acceptance (RULES 4.5 and the 20 Oct and 24 Oct amendments). Items needing engineering judgement still need Tim's word (rule 4.5, unchanged).
   3. Desk must: write the PC name beside every Codex-accepted from the test PC; never ask Tim to test.

## Batch 11 (afternoon, Melbourne)

63. **One-piece pipe object (QUESTIONS item 40): default ON for everyone.**
   1. Tim's words: "defualt on for everyone".
   2. Interpretation: the one-piece pipe object (setting `options.pipeObjectUpgrade`) is ON by default for every login, Max's and any test PC's included, not Automatic (which is on for Tim's login only). Consistent with his 24 Sep rule that colleagues get his exact setup. The extra full test pass with it on Automatic (CE 07's recommendation) is for the desk to decide; Tim did not rule on it.
   3. Desk must: change the default to On in the next train and in Max's starting settings (F-023 export); test the ordinary pipe once so the fallback is known; tell Tim whether any existing setting is edited (re-test rule, decision 35).

64. **Old July install files (QUESTIONS item 25 follow-up): no colleague installs from them.**
   1. Tim's words: "no they dont" (to: does any colleague still install from them?).
   2. Interpretation: nobody installs from the July files, so they can move to the OLD folder with nothing deleted (decision 54). This differs from page 06 of the colleague pack, which says some colleagues use the July copies; Tim's word stands, the desk corrects page 06.
   3. Desk must: move the files to the OLD folder before the pilot; correct page 06; the deletion date still needs Tim's yes with a file list.

65. **Max's install rights (QUESTIONS item 36): yes (GUESS).**
   1. Tim's words: "yes".
   2. Interpretation (GUESS): Max's Windows login can install programs. Taken as the answer to "can his Windows login install programs?".
   3. Desk must: plan the hand install on that basis; confirm at the install rehearsal, which uses the ordinary-login test.

26. **GB-01 PIPE AND PIT CHECKS: APPROVED (29 Oct 2026, `04_REFERENCE/guidebook-cards/GB-01_PIPE_AND_PIT_CHECKS.md`).**
   1. Tim's words on the four open points: "1. do as you recommend / 2. bigger pipes get their own figure / 3. yes / 4. yes" and "approved". (Point 1 = Manningham read as 1 in 200; point 2 = 450 and larger gravity pipes; point 3 = charged and pumped pipes are not held to the grade rule; point 4 = the old size ladder and the every-council 1 in 200 rule are retired.)
   2. Interpretation: GB-01 is approved to build in the five slices on the card, Settings first, warn and record, never block. Manningham = 1 in 200. **Point 2 needs care:** the guidebook gives no figure for 450 and larger gravity pipes, so they get their **own Settings row, left Unknown (blank)** until a figure is named; with it blank CE says "no minimum fall set for this size" and does not warn (Unknown stays Unknown). GUESS: Tim wants a separate figure but did not give one; I have not invented one. Desk must ask for that figure (the engineers or Tim) and add it to the engineer questions as an open item.
   3. Desk must: build slice by slice (falls, cover, pit depth, lid class and garages, pit-size table to Settings); Codex checks each in AutoCAD on copies before the next; nothing installs without Tim's "AutoCAD is closed, deploy". The card's retirement of R-03 (size ladder) and R-32 (every-council detention grade) takes effect when slice 1 is built, not before.

## Batch 12 (afternoon, Melbourne)

66. **CEMEMBER window, and beam size versus scale (follow-up to item 57): Tim cannot answer until he sees it.**
   1. Tim's words: "what happened to the cemember ui window? it comes through on command line at the moment? i cant answer this until i see how youve built it. if dimscale is set to 100 and ltscale 1000 then the then the beam gets drawn at 5 times its normal size then for dimscale 20 and ltscale 200 it becomes normal size, need to warn user somehow".
   2. What the records show (checked 29 Oct, not seen running): the CEMEMBER window was never built. The card (areas\release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md section 5) asks for a window with a live preview, a properties box, orientation pictures and a typed scale, and the 23 Oct review (areas\REVIEW_CEMEMBER_AND_MANAGER_2026-10-23.md items 2, 9 and 15) says: "What is still missing is the window, not the drawing... Today it is a command-line command (typed questions)", "Codex owns the window". What exists is the drawing and the typed questions (code on the Structural builds, for example commit cda6956d onward); nothing in CE_PLAN shows the window started.
   3. Interpretation: (a) Tim's DIMSCALE 100 / LTSCALE 1000 and DIMSCALE 20 / LTSCALE 200 sentence describes the SBEAM-style behaviour (the beam grows with the drawing scale: 5 times at 1:100, normal at 1:20; SBEAM's 1490 mm is exactly 5 times 298 mm). It is NOT a ruling on which size is right. (b) Item 57 (real size versus 5 times) stays OPEN until he has seen the window. (c) New request: when a beam is drawn at other than its real size because of the drawing scale, warn the user plainly and visibly (GUESS: a warning, never a block, R-27; on the window and the command line).
   4. Desk must: put the CEMEMBER window (Codex) on the build list and tell Tim when there is a picture to look at; add the "drawn at N times its real size" warning to the card; do not change the beam size rule until he answers after seeing the window. Show Tim a picture, not a description (rule 5.2).

## Batch 13 (afternoon, Melbourne)

67. **Remove the Codex and Claude ownership split; put CEMEMBER on the build list.**
   1. Tim's words: "lets remove the codex or claude ownship rubbish, add cemember to build list".
   2. Interpretation (GUESS on scope): the labels that say "Claude owns behaviour/spine/deploys; Codex owns windows" (and per-item "Codex owns the window") stop deciding who builds what: any builder can build any item, windows included, and the CEMEMBER window is no longer "Codex owns". Not a change to who tests or accepts (decision 62: Claude and Codex own acceptance), not a change to the one-session-per-file rule (RULES 6.4), and not a ruling on who deploys (only the session Tim names, AGENTS.md). CEMEMBER, including its window, goes on the build list.
   3. Where the old wording lives (found 29 Oct, not edited by this session): `04_REFERENCE\V3_OVERALL_PLAN.md` lines 436 and 529, `04_REFERENCE\ux-plan\cards\` (BATCH4, BATCH5, UX-TITLEBLOCK-NEWJOB cards), `04_REFERENCE\CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md` line 323, `areas\civil-G-water-tanks-cdwt.md`, `areas\REVIEW_CEMEMBER_AND_MANAGER_2026-10-23.md` ("Codex owns the window"), and the repo `AGENTS.md` ("Claude owns behaviour/spine/deploys; Codex owns windows").
   4. Desk must: remove or reword those lines (the owning session edits its own files); add the CEMEMBER window (preview, properties box, orientation pictures, typed scale, and the "drawn at N times its real size" warning, decision 66) to the build list; tell Tim when there is a picture of it. Sent to CE 00 and CE 01.

## Batch 14 (afternoon, Melbourne)

68. **Freeze scope (QUESTIONS item 41): nothing waits for the pilot.**
   1. Tim's words: "nothing waits for the pilot, pilot get very latest version at the time of release, we try to test as much as we can".
   2. Interpretation: no item (guidebook slice 1, the New Pipe window declutter, CEMEMBER and its window, the other guidebook slices) is held back because of the pilot. The pilot gets the very latest version at the time of release; the desk tests as much of it as it can. This overrules CE 00's interim ruling that those builds go after the pilot as drafts. GUESS on the cut-off: it conflicts in part with "option b" (freeze Fri 6 Nov, decisions\2026-10-29_TIM_RELEASE_FREEZE.md): the release candidate may stay open past 6 Nov and take whatever is newest and tested when the pilot packages (Wed 4 Nov to Fri 13 Nov). Asked back to Tim; not decided.
   3. Desk must: keep building everything; do not defer a built item for the pilot; install the newest build that has passed review and the two-pass test before release; say plainly, per item, what was tested and what was not (RULES 5.9) so Tim and Max know what is in the pilot; state the cut-off date once Tim answers.

27. **GB-02 COUNCIL DATA: Tim's answers to the two open points (29 Oct 2026); approval of the card itself not yet said.**
   1. Tim's words: "1. follow book" (Port Phillip) and "2. warning for both" (Banyule underground share).
   2. Interpretation: Port Phillip follows the book (Boyd's method; most Port Phillip jobs need no detention). Banyule: CE warns against BOTH figures with their sources: below 100 per cent underground warns citing Banyule's own 2019 document ("all below ground, above-ground tanks not approved"); below 50 per cent also cites the book ("at least 50 per cent good practice"). GUESS: "both" is read as two separate warning lines, not one figure.
   3. Desk must: add these to GB-02 (done in the card); do not build GB-02 until Tim says it is approved.

28. **GB-02 COUNCIL DATA: APPROVED (29 Oct 2026).** Tim's words: "approve gb02". Interpretation: approved to build as written in `04_REFERENCE/guidebook-cards/GB-02_COUNCIL_DATA.md` with his two answers (item 27). Desk must: queue it after GB-01 slice 1 lands (both edit the council profiles and Settings; two writers never touch the same files); Codex checks in AutoCAD on copies; no install without "AutoCAD is closed, deploy".

## Batch 15 (afternoon, Melbourne)

69. **Release cut-off (follow-up to item 68): the pilot takes the newest tested build on Fri 13 Nov.**
   1. Tim's words: "other choice" (to: keep the Fri 6 Nov freeze as the cut-off, or the other choice: the pilot takes whatever is newest and tested on Fri 13 Nov, the day Max's 2027 should be in).
   2. Interpretation: the Fri 6 Nov freeze in "option b" (decisions\2026-10-29_TIM_RELEASE_FREEZE.md item 1) is SUPERSEDED as the cut-off, 29 Oct 2026. The pilot (Mon 16 Nov) gets the newest build that has passed review and testing on Fri 13 Nov. GUESS: the packaging happens from Wed 11 Nov to Fri 13 Nov instead of Wed 4 Nov to Fri 6 Nov; the exact packaging dates are the desk's to propose. The pilot date stays Mon 16 Nov. Tim accepted that late builds carry less testing (said in the question); the notes say per item what was tested.
   3. Desk must: stop treating Fri 6 Nov as a freeze; plan trains to Fri 13 Nov; keep the full re-test rule (decision 35 and the retest file) and say what was and was not tested per item; give Tim the packaging dates once planned; keep the old option b text, marked superseded.

29. **GB-03 CALCULATIONS: APPROVED (29 Oct 2026).**
   1. Tim's words: "1. yes, can ce do this and collate it all / 2. yes / approve gb03". Point 1 = OSD4W jobs keep the OSD4W printout and CE copies its key figures onto page 1; Tim adds "can CE do this and collate it all". Point 2 = site rainfall for Boyd's jobs applies to new jobs only.
   2. Interpretation: approved as written in `04_REFERENCE/guidebook-cards/GB-03_CALCULATIONS.md`, plus a new slice 5: **collate the whole package** (the CE sheet, the OSD4W printout and the detention and orifice pages in one issued PDF), with the OSD4W key figures read from its printout. GUESS and not checked: the OSD4W printout is plain text so reading it looks feasible, but I have not looked at how the existing CDCALC "Preview package" joins other PDFs; the builder must check first and say if a part cannot be done. Boyd's site rainfall applies to new jobs only: an already-issued job is never changed, and an old job opened again keeps its original rainfall unless the drafter chooses to change it.
   3. Desk must: queue after GB-02; Codex opens the PDF (RULES 5.1) in AutoCAD on copies; no install without "AutoCAD is closed, deploy".

30. **GB-04 READY TO SUBMIT: APPROVED (29 Oct 2026).** Tim's words: "Approve GB-04". Interpretation: approved as written in `04_REFERENCE/guidebook-cards/GB-04_READY_TO_SUBMIT.md` (seven every-council checks first, then Kingston/Monash/Frankston extras, then Bayside and the rest, then recording the list on the job). Open and NOT decided: how CE finds the splay. Tim did not answer; per INT-073 the builder builds the recommended default as a DRAFT behind a Settings value (a drawn line on a named layer set once; no line means Unknown) and Tim's later answer replaces it. Desk must: queue after GB-03 (it can start the checks that need no splay earlier if the builders are free and the files do not overlap); Codex checks each check on a drawing with one deliberate fault; no install without "AutoCAD is closed, deploy".

## Batch 16 (afternoon, Melbourne)

70. **Pilot dates plan (QUESTIONS item 42): yes.**
   1. Tim's words: "yes to all" (to the dates message: installs Thu 29 Oct C-76, Fri 30 Oct C-77, Tue 3 Nov C-78, Fri 6 Nov C-79, Mon 9 Nov after 5:30 pm C-80 as the last build that changes defaults or shared code, Wed 11 to Thu 12 Nov noon C-81 small tested fixes only; full re-tests Sat 31 Oct, Sat 7 Nov, Tue 10 Nov; packaging from Wed 11 Nov; cut Fri 13 Nov; his "yes, hand it to Max" conditional on a confirming full pass Sat 14 and Sun 15 Nov, fallback C-80 as tested on Tue 10 or Mon 23 Nov; folder shared to Max only after his word and that confirmation; hand-over Mon 16 Nov).
   2. Interpretation: the dates plan stands as written by CE 07 (areas\RELEASE_SCOREBOARD.md section 1). NOT covered, GUESS avoided: "yes to all" may also have meant the New Pipe window questions 3 to 6 (all recommended yes) and the A or B beam-size question (not a yes or no question). They are NOT recorded as answered; the builder keeps building on the recommended answers as a draft and the beam size stays open.
   3. Desk must: run the calendar; at C-80 treat Mon 9 Nov after 5:30 pm as the last default-changing install.

31. **GB-04 SPLAY METHOD (29 Oct 2026): accepted.** Tim's words: "a drawn line on a named layer that you set once in Settings. If no line is drawn, that item shows Unknown. Your answer later replaces it". Interpretation: this replaces the draft default of item 30: the splay is a drawn line on a named layer, the layer name is a Settings value set once, and with no line the splay check shows Unknown. GUESS: Tim's last sentence repeats the card's wording; read as acceptance, and he can still change the layer or method later. Desk must: build it so (no longer a draft).

## Batch 17 (afternoon, Melbourne; relayed by CE 09, quote read in areas\UX_NEWPIPE_DECLUTTER_BRIEF_2026-10-29.md line 113)

71. **New Pipe window design v2 and its four questions: approved.**
   1. Tim's words (to CE 09, after trying the clickable v2 mock-up areas\UX_NEWPIPE_DECLUTTER_MOCKUP_2026-10-29_v2_clickable.html): "i am happy with that".
   2. Interpretation (GUESS on scope): the v2 design is approved as shown, and the four questions in section 7 of the brief (merge into "Which level do you know?"; the three group names; "Same as last pipe" in the header; keep the older creation controls under While placing until the new window is accepted) are treated as answered with the recommended answers, as CE 09 reads it. The exact button words stay Tim's call after he sees the real window (brief section 9 item 7); the real window still needs a Codex look.
   3. Desk must: build B-043 (slices a to e) with CE 01 on the v2 design; do not ask Tim questions 3 to 6 again; Tim's earlier "yes to all" is not needed to cover them.

32. **GB-05 CLAUDE ASSISTANT APPROVED, GB-06 UPDATE THE GUIDEBOOK APPROVED BUT ON HOLD (29 Oct 2026).**
   1. Tim's words: "gb05 approved with your recommended answers" and "gb06 is approved but i am getting updated guidebooks from all the councils before we update".
   2. GB-05 interpretation: approved with the three recommended answers in the card: Claude through the existing connection, models by job on Settings (Haiku, Sonnet, Opus); monthly cost cap per person on Settings, blank by default, blank means no Claude calls until Tim names a figure; Tim's PC only until the 22 Oct privacy finding (H01) is fixed and Codex has accepted slice 1, colleagues after that and not on 9 Nov. It still starts last (after GB-04's plain version) and slice 1 does not start until the privacy fix is confirmed.
   3. GB-06 interpretation: approved, but **not started until Tim has the updated guidebooks from the councils and gives them to us** (the start condition in the card, "after GB-01 to GB-04 pass Codex", is replaced by "after Tim supplies the council guidebooks, and GB-01 to GB-04 have passed Codex"). GUESS: the council documents may change values the cards use (council data in GB-02, minimum orifices, underground shares, rear-fall rules); once they arrive the desk compares them with the council profiles and with the audit before writing v1.4, and any difference goes to Tim before it is built. Nothing already approved is paused.
   4. Desk must: put the council guidebooks in `...\Civil Stuff\Councils\<council>` as Tim does today, read each one, and add a "council documents arrived" step to GB-06; until then GB-06 does nothing.

## Batch 18 (afternoon, Melbourne; questions chat)

72. **Splay method (replaces the GB-04 splay entry, item 31 under the guidebook heading): the end user selects it.**
   1. Tim's words: "splay needs to be selected by end user" (he also said "i answered cemember somewhere", see 3).
   2. Interpretation (GUESS on the mechanism): the drafter picks the splay on the drawing each time the check needs it (select the splay line, or its corner points), and CE can remember the pick for that job. This SUPERSEDES the earlier accepted entry "a drawn line on a named layer that you set once in Settings" (29 Oct, kept as written, marked superseded 29 Oct). With no pick, the splay check shows Unknown (R-27). Not decided: whether CE remembers the pick on the job, and whether picking the layer instead of the line is also allowed.
   3. Desk must: change GB-04's splay check from a Settings layer to a user pick (a Settings option for a preferred layer is fine if it only pre-selects); keep Unknown when nothing is picked; tell Tim in the card what he will see.

73. **CEMEMBER beam size, A or B: no answer found.**
   1. Tim's words: "i answered cemember somewhere".
   2. What was found (29 Oct, grep of decisions, areas, ideas and commit messages): no recorded A or B. What IS recorded about CEMEMBER: 19 Oct, warn (never stop) when LTSCALE is not 10 x DIMSCALE ("yes as per recommeneded"); 29 Oct item 57 ("1:100 draw at real size, 1:20 draw 5 times bigger. does that make sense?", unclear) and item 66 (cannot answer until he sees the window; asked for a warning); 29 Oct item 67 (CEMEMBER with its window on the build list); B-037 in the build register now carries the scale warning. He may have answered in a chat that wrote nothing down; that is not recorded and not assumed.
   3. Desk must: keep real size (today's CEMEMBER) until Tim says A or B once more; Tim restates in one word. Nothing about the beam size changes meanwhile.

74. **CEMEMBER beam size: Option B, the size follows DIMSCALE (SUPERSEDES the "real size, recommended" default and my item 73).**
   1. Tim's words: "when dimscale = 100 ltscale = 1000, member gets drawn at 5 times its actual size, when dimscale = 120 ltscale = 200, member gets drawn at actual scale, this should be the rule with dim/ltscale".
   2. Interpretation: a beam is drawn at DIMSCALE divided by 20 times its real size: 5 times at DIMSCALE 100 (LTSCALE 1000), real size at DIMSCALE 20 (LTSCALE 200). This is the old SBEAM behaviour (1490 mm for a 310UB32 at 1:100) and is Option B in the CEMEMBER window picture (14.9 mm on an A1 sheet). It answers QUESTIONS 23 Oct early item 2 and BUG-952: CEMEMBER (today real size, 298 mm at 1:100) is the one that changes. GUESS 1: "dimscale = 120" in his message is a typing slip for 20, since LTSCALE 200 goes with 20. GUESS 2: other scales follow the same rule (DIMSCALE 50 gives 2.5 times). His earlier request stands: warn plainly (never block) that the member is not drawn at its real size, and warn when LTSCALE is not 10 times DIMSCALE (19 Oct "warn, carry on").
   3. Desk must: change CEMEMBER (B-036 window and the placing code) so the member's drawn size is its real size times DIMSCALE / 20; keep the warning (B-037) as a notice stating the factor ("drawn at 5 times real size"); make the CEMEMBER window show the factor and the printed size; keep SBEAM's behaviour unchanged; update BUG-952 and the Settings page if the 20 is a number (Settings-first: the 20 must be a Settings value, not hard-coded); show Tim a picture before it ships. Tim to confirm the "120" and the 50 case in one line when he sees the picture.

75. **CEMEMBER beam size readings confirmed (follows item 74).**
   1. Tim's words: "yes your readings are correct".
   2. Interpretation: both readings in item 74 are confirmed by Tim: (1) "dimscale = 120" was a slip for 20; (2) other scales follow the same rule (DIMSCALE 50 gives 2.5 times real size). The earlier GUESS flags on item 74 are cleared. The picture is still shown before it ships (rule 5.2).
   3. Desk must: build with DIMSCALE / 20 as the factor at every scale.

## Batch 19 (late afternoon, Melbourne; CE 03, CE 05 and CE 02 questions)

76. **FO symbol and source labels (QUESTIONS item 43, BUG-1236): yes, with a label and a tag.**
   1. Tim's words: "the source block should have the dp text thats visible on print that can be modified then it has the tag, we should be able to edit both when double clicking does that make sense? in this case yes fo should insert with FO as the label".
   2. Interpretation: every source block (DP, OF, FO, RG) has two parts: a VISIBLE LABEL that prints and can be changed (for example DP, FO), and a TAG that holds the reference (DP1, FO1). Double-clicking opens one window where both can be edited. FO inserts with FO as its label (not OF). Whether FO gets a different drawn symbol from OF is not stated; the label is what he asked for (GUESS: the symbol can stay shared as card D08 says, the label tells them apart).
   3. Desk must: build label plus tag on all source blocks with one edit window on double-click (extends the DP double-click ruling, QUESTIONS 22 Oct item 3 and BUG-860); FO inserts labelled FO.

77. **Source numbers on the plan (item 44, BUG-1242): number in the tag only; the label never carries it.**
   1. Tim's words: "number shows in tag only, for reference. label is always without the number".
   2. Interpretation: the plan label is OF, FO, DP, RG with no number; OF1, DP1, RG1 live in the tag, for reference. The recommended "show the number on the plan, default ON" is NOT chosen.
   3. Desk must: keep numbers off the plan labels; RG gets a plain label RG (decision 3: raingarden label wanted).

78. **Pipe label gap, Above and Below (item 45, BUG-1239): research done, no number from Tim.**
   1. Tim's words: "what do the current default settings say, do your research before askign em dumb questions?"
   2. Research (29 Oct, read from the installed source branch claude/rel-20261029a and Tim's own file; not seen running): the Settings value is Annotation offsets > pipeTextOffsetMm, default 200 (Models/PipeAnnotationHandles.cs lines 22, 44 to 46; the same file keeps PipeTextSide "Top"). Tim's own settings file C:\Users\TimothyBrand\AppData\Roaming\CE_CVL_SUITE\settings.json holds no annotationOffsets entry, so his PC uses the default 200 mm. The drawing code that applies it was not found in this search. What Tim measured (BUG-1239) is about 450: about two and a quarter times the default; why is not known (not checked: whether 200 is measured to the text middle or edge, or scaled by DIMSCALE).
   3. Interpretation (GUESS, mine, not Tim's): he expects the desk to find the cause and propose a figure. No number is his.
   4. Desk must: measure the real distance on a copy (BUG-1239 steps) and find why 200 reads as 450; set a small default gap measured from the pipe line to the nearest edge of the text (proposal: 50 mm at plot scale, a Settings value, R-00); show Tim a picture of Above and Below before it ships; do not ask him for the number first.

79. **Move+Rotate and Copy+Rotate on a raingarden (item 46, BUG-1245): yes.** Tim's words: "yes". Interpretation: a plain sentence naming the object now, support for moving and rotating later. Desk must: build the sentence; put "support later" on the build list.

80. **Copied CE objects (item 47, BUG-1246): yes, and it is a general rule.**
   1. Tim's words: "yes like pits, all ce items should be like this".
   2. Interpretation: a copied downpipe becomes a real downpipe with the next tag; and every CE object (source, pit, pipe and others) that is copied becomes a real CE object with its own next number, as a copied pit does. GUESS on scope: all CE items means every CE-recorded object, not ordinary AutoCAD lines.
   3. Desk must: build it for downpipes now; audit every CE object kind for the same copy behaviour and list the ones that do not.

81. **Council letters inbox (item 53): yes.** Tim's words: "yes". Interpretation: a plain "council letters inbox" folder per office; CE reads the PDF you save there and files it in the job's Civil\From Council folder; CE never reads a mailbox. Desk must: build it as card UX with the privacy rule (no mailbox access).

82. **AI cost cap (item 54): yes, A$50 a month.** Tim's words: "yes". Interpretation: A$50 per month is the Settings default for the cap, with a warning at 80 per cent and the AI stops at the cap; drawing is never blocked. Note: GB-05's card had the cap blank by default; this is the named figure. Desk must: set the default A$50.

83. **AutoCAD close and reopen helper (QUESTIONS item 55): 08:30 next working day, and weekends and holidays are open for testing.**
   1. Tim's words: "8:30 am next working day, you can also always test on weekends and public holidays".
   2. Interpretation: after the 5:30 pm close, AutoCAD reopens at 08:30 the next working day (Friday's close reopens Monday 08:30). Weekends and public holidays: the robot and Codex may test any time on them, Tim's PC included (GUESS on Tim's PC; the existing hours rule already treated weekends as free, RULES 1.8).
   3. Desk must: set the reopen time 08:30 next working day; schedule tests on weekends and public holidays freely; the helper still only acts after 5 minutes idle.

84. **Help tab in CE Manager (item 50): all five recommended answers accepted.** Tim's words, in the CE 11 design chat after seeing the picture and the clickable mock-up: "Accept all five".
   1. Interpretation: (1) the zip is saved on the PC in a CE Support folder outside OneDrive (not Desktop\CE Support); (2) a tick box, ticked by default, copies it to the shared IT folder, line 3 on screen names who can read it, and CE sends no message itself (the tab gives a paste-ready sentence); (3) no "are you sure" pop-up; (4) typed CESUPPORT and CEMANAGERDIAG only open the tab; (5) the button wording "Something is wrong: get help" and "Open older Civil logs" stay as shown. Source of the answers: areas\UX_HELP_TAB_BRIEF_2026-10-29.md section 8.
   2. GUESS on scope: "all five" means the five recommended answers in section 8, not the earlier idea text. The design is approved; nothing is built and nothing is accepted until seen in AutoCAD.
   3. Desk must: CE 01 gives it a B number; build it with UX-MANAGER-TABS and UX-VERSION-IN-MANAGER so the Manager tabs change once; the builder re-reads the Help tab on the real release branch first and proves "no drawings in the zip" with a test.

## Batch 20 (evening, Melbourne)

85. **Garages for GB-01 slice 4: the recommended answer, plus Tim asks CE to find them on the architect's plan.**
   1. Tim's words: "recommended answers but also why cant it read the architectural drawings and find it on plan?".
   2. Interpretation: the recommended answer stands (the user picks the garage outline; if none is picked the check shows Unknown) AND CE should also try to find garages on the architect's background plan and offer them to pick, the same "detect and confirm" pattern Tim ruled for the architect's downpipes and slab outlines (decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md UX-DP-01 and the slab outline offer, about lines 883 and 2263). Answer given to him: nothing in CE_PLAN says CE cannot; whether CE can recognise a garage depends on how the architect marks it (a layer name, a hatch or the word GARAGE), which varies per architect and is not recorded; whether any garage detection is already built is not known.
   3. Desk must: add "offer garage outlines found in the architect's Xref (closed outlines on layers or with text containing garage), user confirms or picks" to GB-01 slice 4; check what the Xref reader can already find; never decide a garage without the user confirming.

86. **StrucPlus in Manager (item 48): yes.** Tim's words: "yes". Interpretation: take CE StrucPlus out of CE Manager only; no StrucPlus code or product deleted. Desk must: remove the Manager Updates tab entry only.

87. **CE Blocks (item 49, BUG-1243): park it.** Tim's words: "just add to carpark for later". Interpretation: no question answered; BUG-1243 stays in BUG_CARPARK.md as OPEN, parked, with what he wanted still unrecorded (ask him when he is ready). Desk must: confirm BUG-1243 holds "Tim: park for later 29 Oct"; build nothing.

88. **Two CE_SUITE_MANAGER installs (item 51): the recommended answer.** Tim's words: "recommedned answer" (recommended: keep the ProgramData one, the all-users location the installer uses, after the desk reads the version of each and which one AutoCAD loads). Desk must: read both versions first; remove nothing without Tim's yes; tell him which is which.

89. **Long Pit Schedule (item from CE 03, card D22): one table.** Tim's words: "one table". Interpretation: a placed Pit Schedule keeps growing as ONE table with no splitting; the row limit stays as an optional setting for sheets that need a split, headers repeat only when it splits (the recommended answer). Desk must: change card D22 and build it; D22 not counted until then.

90. **Help tab, copy to the IT folder (decision 84 item 2): unticked by default.** SUPERSEDES the ticked default in decision 84, 29 Oct 2026 (old text kept).
   1. Tim's words: "keep the tick box, but unticked by default. The user ticks it when they want you and IT to get the file straight away".
   2. Interpretation: the Help tab has the tick box "Also copy it to the office IT folder" but it starts unticked. The other four accepted answers stand.
   3. Desk must: tell CE 11 and CE 01 so the build uses unticked; the tab still shows line 3 naming who can read it; the file should still carry no client or drawing names where avoidable (decision 14).

## Batch 21 (evening, Melbourne)

91. **Window position memory (QUESTIONS B5): as recommended.** Tim's words: "as recommended". Interpretation: it ships OFF until a Codex run passes on two monitors, then it is switched ON by default. Desk must: run the two-monitor Codex look, then flip the default.

92. **Manager theme preview pictures (I1): as recommended.** Tim's words: "as recommended" (build the three little pictures: Follow AutoCAD, Light, Dark). Because "nothing waits for the pilot" (decision 68), it is on the build list, not parked. Desk must: build it as a draft; picture first.

93. **Add administrator button (I4): yes.** Tim's words: "yes". Interpretation: build the Add administrator button now (with the name-matching and lost-list fixes BUG-829, BUG-843). Desk must: build it; it is a Manager change that needs the full re-test class.

94. **Double-click on a pit label (22 Oct item 2): as recommended.** Tim's words: "as recommended". Interpretation: the Edit Pit window opens on a double-click of a pit label; ON by default only after a Codex look passes. Desk must: run the look, then flip the default.

95. **CEMEMBER Z purlin orientation (23 Oct review item 1): yes.** Tim's words: "yes". Interpretation: keep the current orientation names and show them as four pictures in the CEMEMBER window; the wide flange goes on top. Desk must: add the four pictures to the window plan (B-036).

96. **Unequal angles (23 Oct review item 2): yes.** Tim's words: "yes". Interpretation: add long-leg-flat, so a 150x90 ledger angle with the 150 leg lying flat can be drawn. Desk must: add it to CEMEMBER.

97. **Disk space (item 12): delete the old installer leftover.**
   1. Tim's words: "yes" (to deleting the old 1.7 GB Visual Studio installer leftover `lestw1e0` in his Temp folder).
   2. Interpretation: that one folder only. Nothing bigger (C:\ce_rc_scratch, Codex worktrees) is touched without a further word.
   3. Desk must: look at the folder first (rule 12.7: read the drive, check it is the Visual Studio leftover from 21 Oct and nothing in use), then delete only it, and say how much space came back.

98. **Updates & Rollback button (QUESTIONS item 56, BUG-1247): yes.** Tim's words: "yes". Interpretation: every user's Updates & Rollback button opens that user's own screen (what is running, what is waiting, go back to the previous version); the Administrator Dashboard is reachable only through the separate Admin button, for the owner only. Desk must: build it with the CEHEALTH, Version and Help tab work (B-047) in one Manager change.

## Batch 22 (evening, Melbourne): the older standing questions, answered as a block of 18

99. **Older standing questions (Codex bug triage 16 Oct section 4, gap audit 17 Oct section 3, CEMEMBER review 23 Oct): yes to 17, one sent to planning.**
   1. Tim's words: "1. yes" through "16. yes", "17. can we plan this in planning chat if its not organised already", "18. yes", to the numbered list sent by CE 04 (numbering below is that list's).
   2. Interpretation: each of these is answered YES as recommended:
      1. Rising above-ground drain says plainly "falls the wrong way (rises 200 mm towards the outlet)" (triage 1, BUG-649).
      2. A cover label without an IL line never blanks a stored invert (triage 3, BUG-650).
      3. Pit Schedule remarks keep the custom note and "With Step Irons" as two parts; step irons only by the tick (triage 5, BUG-586, BUG-637).
      4. Excel exports save numbers as numbers; "Unknown" stays text (triage 6, BUG-571, BUG-591).
      5. DRAFT stamp "DRAFT - NOT FOR CONSTRUCTION" and the job name on every PDF page and Excel tab until the sheet is issued (triage 7, BUG-590).
      6. A command that would write to a locked layer stops up front with one sentence naming the layer (triage 8; consistent with the native protection rule).
      7. LandXML import previews pits and pipes before anything is drawn (triage 9, BUG-603).
      8. Footing label height from the drawing scale, 2.5 mm plot height times the annotation scale (triage 10, BUG-454).
      9. Wind class: Enter with nothing typed keeps the old value (triage 11, BUG-504).
      10. C purlin, flanges up, top view: flange lines drawn hidden because the lips sit over them (CEMEMBER review item 3).
      11. One "Set up C01 and C02" command previews and places the legend and four note blocks, one Undo (gap audit 3).
      12. Level 3 network options: A fewest pits, B shortest total pipe, C Tim's usual set-off from the boundary (gap audit 4).
      13. Detention criteria block goes beside the orifice pit (gap audit 5).
      14. Proposed downpipes when a few fail: place the rest, name the ones left out (gap audit 6).
      15. Colleague updates (BUG-478): Manager finishes the update the next time AutoCAD closes (gap audit 10).
      16. Retaining wall and fence footing sizes: layout built now, sizes read "Unknown, engineer to fill" until typed in Settings (gap audit 11).
      18. Office learning suggests something office-wide after 3 people (gap audit 14).
   3. **Item 17 (pump station master detail and storage rule, gap audit 12): NOT decided.** Tim's words: "can we plan this in planning chat if its not organised already". Routed to the planning chat (CE 05); "detail not set" stays the default meanwhile; the duty-point working still runs.
   4. Parked, not asked: clearances (footing, service, zone of influence angle, crossing service, pool zone): "not set, not checked" until Tim types numbers; the new job title block card (UX-TITLEBLOCK-NEWJOB) and the Structural/Manager ribbon card (UX-RIBBON-04) need Tim at the cards.
   5. Desk must: build each as a draft or as part of its existing item; items that are new commands (11, 12, 13, 14) go on the build list (nothing waits for the pilot, decision 68); cross them off QUESTIONS and the gap audit.

## Batch 23 (evening, Melbourne)

100. **Approval of three window designs: CEMEMBER window, New Pipe window v2, Help tab.**
   1. Tim's words: "approve cemember, new pipe v2, and help tab".
   2. Interpretation: Tim approves the three designs as shown in the pictures he was sent (areas\CEMEMBER_WINDOW_MOCK_29OCT.html, areas\UX_NEWPIPE_DECLUTTER_MOCKUP_2026-10-29_v2_clickable.html, areas\UX_HELP_TAB_MOCKUP_2026-10-29_clickable.html), which satisfies the command review gate (card approval before code) for B-036 and B-037 (CEMEMBER window and scale warning), B-043 (New Pipe v2) and the Help tab (B-047 group). For CEMEMBER: the beam-size strip in the picture still shows the old A or B choice; his ruling is B, size = DIMSCALE / 20 (decisions 74 and 75), so the picture must be corrected to B before the window is built (GUESS: he approves the window layout and the B rule, not the old strip). New Pipe v2: already approved on 29 Oct ("i am happy with that", decision 71). Help tab: his five answers are accepted ("Accept all five", decision 84) with the IT copy tick box UNTICKED by default (decision 90). Still Tim's call later: final button words once he sees each real window (RULES 5.7: a window is accepted by a look in AutoCAD, not by a picture).
   3. Desk must: build all three; correct the CEMEMBER picture to the B rule; keep the tick box unticked; get a Codex look for each real window; show Tim the real window, not only the picture, before calling any of them accepted.

## Batch 24 (evening, Melbourne)

101. **New job title block card (UX-TITLEBLOCK-NEWJOB): both questions yes, card approved.**
   1. Tim's words: "1. The other templates (A1 vertical, Civil A1, basement A3 and the client-specific A3 sets): still offered under "More templates", or hidden? Recommended: still offered, below the two. yes" / "2. When a job has both kinds already (a mixed old job), set-up shows what it found and changes nothing. Agreed? yes" / "ux-title block new job card approved".
   2. Interpretation: the other templates stay offered under "More templates", below the two (A1 horizontal and A3 classic); a mixed old job shows what set-up found and changes nothing; the card (areas card `04_REFERENCE\ux-plan\cards\UX-TITLEBLOCK-NEWJOB_CARD_2026-10-05.md`) is APPROVED for building, which clears the command review gate for it. Nothing pre-selected; Create greyed until A1 horizontal or A3 classic is picked (card section 5).
   3. Desk must: add it to the build list (Structural, Tim's PC only); the card's AutoCAD checks (section 5) go to the robot and a Codex look for the window; mark the card APPROVED 29 Oct 2026.

## Batch 25 (evening, Melbourne)

102. **UX-RIBBON-04 card (merge Structural Workspace/System commands, rest into Manager): approved with the recommended answers.**
   1. Tim's words: "UX-RIBBON-04 - approved" (to the card and its questions 3 to 6).
   2. Interpretation: the card (`04_REFERENCE\ux-plan\cards\UX-RIBBON-04_CARD_2026-09-25.md`) is APPROVED for building (clears the review gate), and the open questions take the recommended answers: (OPEN 1) CETOOLS keeps a Structural ribbon entry point, only CENOTES moves into Manager; (OPEN 3) STRIPLAYERSMERGE and STRUCLINKTEXT stay in Structural, typed and expert-flagged; (OPEN 4) "automated" for STRIPLAYERSMERGE means easier to find only, an unattended rewrite needs its own preview and one-Undo card; (OPEN 5) CENOTES is a tab on an existing Manager workspace page. GUESS: "approved" without a number per question was read as accepting those four recommended answers, as Tim did for the New Pipe window and the Help tab; he can change any.
   3. Desk must: add to the build list (Structural and Manager); CESTRUC's launcher retirement (OPEN 2, answered 25 Sep) stays as ruled; mark the card APPROVED 29 Oct 2026.

103. **Pump station master detail (QUESTIONS item 57a): the .dwg is the master.** Tim's words: "7a. yes". Interpretation: `CE Civil WATER TANKS - PUMP STATIONS Details.dwg` in Standard Details\Civil is the master; the PDFs (`CE Civil PUMP STATION Detail.pdf`, `SPS DIAGRAM.pdf`) are print copies; everything else (dxf, .bak, 0_SUPERSEDED) is ignored; CE fills that drawing's levels, storage, pump duty and main size from the job. Desk must: record the path in the pump station area file and build against it.

104. **Pump station storage rule (item 57b): keep it, with Settings.**
   1. Tim's words: "7b. yes" and "keep it as recommenmded".
   2. Interpretation: the storage rule already in the code is approved: the wet well holds the larger of (i) the worst storm's water minus what the pump moves in 30 minutes, and (ii) 10 mm of rain over the catchment (1 per cent of the area in cubic metres); the pump is the smallest standard one (1 to 12 L/s) that covers it; every fixed number goes on the Settings page with its source. GUESS: this floor (ii) sits beside his R-14 ("no fixed floor, 3 m3 is a review flag"); approving the rule is read as the pump-station rule superseding R-14's "no fixed floor" for pump stations only, 29 Oct 2026; R-14 stays as written elsewhere. He did not mention R-14.
   3. Desk must: keep the rule; move every fixed number to Settings with its source; keep R-14's 3 m3 review flag as a warning; tell Tim in the report that this overrides "no fixed floor" for pump stations. NOT covered by "keep it as recommended": the three open points on the card (friction method and roughness, duty flow on a stormwater job, the command name), asked next.

## Batch 26 (evening, Melbourne)

105. **Pump station friction method: Hazen-Williams; the roughness figure is NOT given.**
   1. Tim's words: "1. Hazen-Williams".
   2. Interpretation: the pump main uses Hazen-Williams. He did not give the roughness (C value), which my question asked for; nothing in CE_PLAN gives one. Not guessed.
   3. Desk must: put the Hazen-Williams C value on the Settings page, empty/Unknown until Tim types it (R-27, Unknown stays Unknown); the pump main check shows "C value not set" meanwhile; ask Tim for the figure when the pump station window is near, or find one in a guidebook page with Tim's word.

106. **Pump station duty flow on a stormwater job: typed by the engineer.** Tim's words: "2. recommended: typed by the engineer." Desk must: the engineer types the duty flow; CE does not work it out.

107. **Pump station command name: CDPUMP.** Tim's words: "3. CDPUMP". Desk must: register CDPUMP for the pump station command.

## Batch 27 (evening, Melbourne)

108. **Carpark and bug tidy (plan areas\CARPARK_TIDY_PLAN_29OCT.md): yes.**
   1. Tim's words: "8. yes" (to: start the carpark tidy with T-1 and T-4, then T-2 and T-3, then T-5 to T-8 as review jobs; nothing deleted or closed). Earlier he asked "can we start tidying the carpark and bugs?".
   2. Interpretation: approved as the plan states: T-1 (replace the stale id-range paragraph in the carpark header with one line, the old text moved word for word to a history file), T-4 (a retest list of the 47 IN PROGRESS bugs for the robot and Codex, no status changed), then T-2 and T-3 (a clear status on the 41 entries with none and the 5 with two; none marked fixed), then T-5 to T-8 as review jobs. Nothing is deleted or closed (rule D6 and the 13.3 amendments).
   3. Desk must: CE 05 does T-1 and T-4 first; T-4 goes to CE 02; one session edits BUG_CARPARK.md at a time (RULES 6.4); never mark a bug fixed without the Claude-accepted or Codex-accepted rule.

## Batch 28 (evening, Melbourne)

109. **Windows restart overnight (QUESTIONS item 58): option 1, pause Windows Updates (GUESS on what "1" meant).**
   1. Tim's words: "1".
   2. Interpretation (GUESS): the last message listed three options numbered 1 to 3 for the overnight restart (1 = pause Windows Updates until Mon 2 Nov, recommended; 2 = also automatic sign-in; 3 = leave as is) and, further down, a separate "Still open" list whose first item was the Hazen-Williams C value. "1" is read as option 1, pause updates. If he meant the C value, "1" cannot be a Hazen-Williams C (usual values are about 100 to 150), so that reading is rejected, but it was not confirmed.
   3. Desk must: Tim pauses the updates himself (Settings, Windows Update, Pause updates, to Mon 2 Nov); the desk does not touch his Windows settings. Check on the first morning (Fri 30 Oct) whether the PC restarted overnight (uptime, Event log) and tell Tim; if the pause was not set, say so. Automatic sign-in stays OFF. The Hazen-Williams C value stays open.

110. **Windows Updates paused (follow-up to item 109): done by Tim, until 9 Nov.**
   1. Evidence: Tim sent a screenshot of Settings, Windows Update: "Updates paused until 9/11/2026", the Pause updates box showing 9/11/2026, Resume updates button. This PC's date format is day/month/year, so 9 Nov 2026 (Monday), a week longer than the Mon 2 Nov asked for.
   2. Interpretation: the pause is set, so the "1" in item 109 was the pause option, confirmed. Automatic sign-in stays OFF.
   3. Desk must: treat overnight Windows restarts as unlikely until Mon 9 Nov; before the last big install on Mon 9 Nov after 5:30 pm (C-80) remind Tim that updates resume that day and ask whether to pause again until Fri 13 Nov or later; still check uptime on Fri 30 Oct morning.

111. **CDSL when the nearest survey spot is far away (QUESTIONS item 59, ledger H50): yes.**
   1. Tim's words: "1. yes" (to my numbered list where item 1 was the CDSL warning).
   2. Interpretation: when the nearest survey spot is more than the Settings distance (default 10 m), CDSL warns in plain words ("nearest survey spot is 35 m away: this level is a rough guide only") before it asks for the proposed level. A warning only, never a block (R-27). GUESS: the "1" answered the CDSL question, the first item of the list I had just sent; it could also have meant the Hazen-Williams C value (rejected: not a plausible C value).
   3. Desk must: build it with the distance a Settings value, default 10 m; tell CE 03.

112. **Hazen-Williams C value (decision 105): leave for later.**
   1. Tim's words: "2. leave for later" (to my numbered list where item 2 was the Hazen-Williams C value). This also confirms that his "1." answered the CDSL warning (decision 111).
   2. Interpretation: no C value now; the Settings value stays empty/Unknown and the pump main check says "C value not set" (decision 105). Not a decision on the figure.
   3. Desk must: ask again when the pump station window is near (before CDPUMP is built into a train), and do not guess a figure.

113. **GB-01 pipe and pit checks, slices 2 to 5 built; Tim on the cover rows and garages (29 Oct 2026, builder chat CE 10).**
   1. Tim's words: "Yes, build it" (pipes under garages from a closed outline drawn on a layer named once in Settings; none drawn = Unknown) and "Keep as built" (the five cover rows Garden 300, Footpath 100, Driveway 100, Driveway (larger vehicles) 450, Road 600, and a pit with no surface keeps the single office 300).
   2. Interpretation: the cover rows are confirmed (no longer Assumed in the code); the card's "Unknown surface = Unknown" is NOT used, by his word. Garages: layer names are Settings values, blank by default, so every job shows two Unknown rows until the office names its layers (GUESS: that noise is acceptable; not stated by Tim).
   3. Built: PRs 1841, 1842, 1843, 1849, 1850, 1851 (see areas/council-rulebook.md items 3 to 8 and 04_REFERENCE/guidebook-cards/BUILD_LIST.md).

## Batch 29 (22:38, Melbourne; said in the Control Room chat, relayed by CE 00, not seen by CE 04 directly)

114. **Fri 30 Oct: Tim is on site, the desk keeps going.** (Renumbered from 113: CE 10 also used 113 for the GB-01 garages and cover rows entry.)
   1. Tim's words (as relayed by CE 00): "tomorrow im on site so you can keep going until i say so".
   2. Interpretation (CE 00's, logged as an interpretation): on Fri 30 Oct Tim is away from the work PC all day, so the robot and Codex may use AutoCAD through his usual weekday hours (the runner's away flag is authorised), the overnight self-stop need not cut the pass, installs need not wait for 17:30, and it lasts until Tim says otherwise; the PC stays on and signed in. No question to ask Tim about it unless he returns. Note: Windows Updates are paused until 9 Nov (decision 110); automatic sign-in stays off (decision 109).
   3. Desk must: run through Fri 30 Oct without Tim's PC being needed; stop and ask only if something needs his word; tell Tim when he returns what ran.

115. **Re-test rule from C-77 on (QUESTIONS item 61, my question 12): the recommendation.** Tim's words (relayed by CE 00): "do your recommendation". Interpretation (CE 00's): re-test what the train touches plus a small smoke set per shared file touched, carry the rest, one full re-test before Max by Fri 13 Nov and at the weekends; unmapped files stop forcing FULL once placed in areas; tonight's pass unchanged. Recorded in decisions\2026-10-29_TIM_RETEST_RULE.md Addendum 2. Closed.

116. **Re-test rule is a standing rule (follows 115).** Tim's words (relayed by CE 00): "thats should be the plan throughout as a rule". Interpretation (CE 00's): after ANY install, re-test what the train touches plus a small smoke set per shared file, carry the rest, one full re-test before Max (Fri 13 Nov) and at the weekends; unmapped files placed in areas; new-switch-only changes touch only their own tool. Recorded as Addendum 3 in decisions\2026-10-29_TIM_RETEST_RULE.md and Rule 14 in areas\CE_SESSIONS_MAP_29OCT.md.

117. **A changed starting value or a one-time settings move (re-test rule, follows 116): option 1.** Tim's word (relayed by CE 00): "1". Interpretation (CE 00's): it counts as touching its own tool plus the Settings smoke set (Friday AREA plus SMOKE; the Saturday full re-test is the safety net), unless the settings engine itself changes. Recorded as Addendum 4 in decisions\2026-10-29_TIM_RETEST_RULE.md.

## Sat 31 Oct 2026: Tim's spoken answers to VOICE BATCH 1 (QUESTIONS item 83; asked by CE 04). Tim's words: "1b, 2no but warn, 3yes, 4yes, 5as recommened, 6yes, 7dicuss with me the less i have to do to get these accepted the better, 8yes, 9yes, 10yes, 11as recommended, 12send them through sgsin i have no idea what youre talking about"

118. **Grade mismatch window in Custom grade (voice V1, QUESTIONS item 74): option b.** Tim's words: "1b". Interpretation: when the drafter types their own two levels and they do not match the chosen grade, CE shows a plain warning line (strip and CDRULES) and ACCEPTS the levels. No Grade mismatch window, never a block (R-27). Desk must: replace the Grade mismatch window with a warning line; keep it only in Custom grade as today unless 120 says otherwise; Settings switch per R-00 so it can be reversed; small fix, own tool plus Settings smoke set (re-test rule).

119. **Steeper pipe than the chosen grade (V2, item 74): no window, but warn.** Tim's words: "2no but warn". Interpretation (mine; GUESS on the "warn" part): a pipe typed steeper than the chosen grade does NOT ask in a window, but the same plain warning line shows. This differs from the recommendation (steeper passes quietly). Desk must: same warning line for steeper as for flatter, no window, never a block. If he meant a warning only when flatter than the 1 in 100 minimum, he will say.

120. **Same warning on empty ground in Default grade (V3, items 74c/74d): yes.** Tim's word: "3yes". Interpretation: typing two levels flatter than the 1 in 100 minimum on empty ground in Default grade shows the same plain warning line (the minimum is in Settings). Desk must: build the Default-mode warning; warn, never block.

121. **New Pipe starts in Custom 1 in 100 for colleagues' fresh logins (V4, item 66 second part): yes.** Tim's word: "4yes". Desk must: colleagues' starting settings put New Pipe in Custom 1 in 100, the same as Tim.

122. **Recall Last then a new upstream level (V5, items 76/76a, BUG-1267): as recommended.** Tim's words: "5as recommened". Interpretation: the downstream works from the standard grade for the new pipe's length (19.40 on a 4.1 m pipe at 1 in 100), behind a Settings switch ON by default so he can go back. The old BUG-076 comment needing his confirmation is now confirmed. Desk must: build it; the robot expects 19.40.

123. **Kingston rainwater credit (V6, item 67): yes, close #1817 as replaced by #1874.** Tim's word: "6yes". Desk must: close PR #1817 as replaced (branch stays; keep its idea of storing the credit as council data for later). Note: CDDESIGN still cannot show a reuse credit for any council until there is a box for the permitted discharge (BUG-1096 stays open).

124. **Bug order and pilot cut (V7, item 68): Tim wants to discuss, with the least effort for him.** Tim's words: "7dicuss with me the less i have to do to get these accepted the better". NOT a decision. Desk must: not act on the recommended order as ruled; propose a way where the robot and Codex do the proving and Tim confirms by exception, then discuss. CE 05 keeps using the recommended order as a working default only, as it already says.

125. **Checks window look (V8, item 69): yes.** Tim's word: "8yes". Desk must: gold banner when anything is found, every pass folded into one grey line, make the "not known" count wording plain.

126. **Where the new switches and tuning figures are shown (V9, items 75/75a): new Settings tab "Switches".** Tim's word: "9yes". Desk must: CE 01 builds one new tab listing every new on/off switch and the five Pit Schedule tuning figures in plain English (long list may scroll, no collapsed sections); until then file-only and ON. Settings change: re-test rule applies.

127. **One cover measure on every screen (V10, item 79, BUG-903): yes.** Tim's word: "10yes". Desk must: the Inspector, Civil Hub and repair check measure cover to the outside top of the pipe, as CDRULES does (follow-up build after draft #1897).

128. **Raingarden label (V11): as recommended, plain "RG".** Tim's words: "11as recommended". Interpretation: plain label RG, number in the tag only (matches decision 77). Desk must: fix the C-77 build labelling RG1, RG2 so the visible label is RG.

129. **Colleague pack approval (V12): NOT answered.** Tim's words: "12send them through sgsin i have no idea what youre talking about". The sheet was unclear. Desk must: re-ask in plain words (the ten page-06 questions one at a time, and a short plain description of what is being approved); do not treat the pack as approved.

## Sat 31 Oct 2026: Tim's spoken answers to the ten colleague-pack questions (page 06, plain-words re-ask by CE 04). Tim's words: "1me, 2me but youll need to run me through it, 3yep, 4yes, 5yes run me through on the day what i need to do, 6yes, 7cdrules, 8yes, 9yes, 10dont make max do anything else apart from use it he is busy"

130. **Who installs on Max's PC on Mon 16 Nov (pack Q1): Tim.** Tim's words: "1me". Desk must: Tim installs at 8:40 Mon 16 Nov following page 02, about 20 minutes, desk on the line (the desk cannot reach Max's PC).

131. **Old Manager in Max's all-users folder (Q2, page 06 Q4): Tim checks, with a walk-through.** Tim's words: "2me but youll need to run me through it". Desk must: write Tim a step-by-step (plain words, exact clicks) for checking Max's PC in the week of Mon 9 Nov and run him through it live. Nothing is removed without Tim's word.

132. **Max's old July Structural (Q3): rename its folder to ".backup" before install day.** Tim's words: "3yep" (to the recommended option A). Desk must: include the rename in Tim's install-day steps (undone by renaming back); do not rely on the old Manager working.

133. **Real jobs or copies (Q4): yes.** Tim's word: "4yes". Desk must: Max works on copies of live jobs for the first week; real jobs only once Codex has passed the pilot build and there have been 5 working days with no new bug.

134. **Share the "CE Plugin Pilot Results" folder with Max as "can edit" (Q5): yes, with a walk-through on the day.** Tim's words: "5yes run me through on the day what i need to do". Desk must: give Tim the exact SharePoint steps on the day (Share, Max Mishchenko, "can edit") and confirm Max can save one test file there.

135. **Reply time for Max's reports (Q6): yes, option A.** Tim's word: "6yes". Desk must: same working day for anything that stops him; the weekly Monday session for the rest.

136. **Inspector versus CDRULES (Q7): CDRULES.** Tim's word: "7cdrules". Desk must: Max trusts CDRULES (council first); the Inspector is changed to match (B-022 / decision 127).

137. **Print pages 01 and 05 as one-page sheets (Q8): yes.** Tim's word: "8yes". Page 02 stays on screen for whoever installs.

138. **Screenshots on page 02 taken by Codex on a test copy (Q9): yes.** Tim's word: "9yes". Desk must: Codex takes them during packaging, Wed 11 to Fri 13 Nov, on the pilot build.

139. **Max's first 10 minutes (Q10): Max does nothing except use it.** Tim's words: "10dont make max do anything else apart from use it he is busy". Interpretation (mine, not a template choice): no practice-drawing task, no setup steps, no extra reading for Max. The A1/A3 template choice is NOT answered. Desk must: everything that can be done for Max (install, settings, folder sharing, template opened for him) is done by Tim and the desk; the pack asks Max for nothing beyond using CE on real work copies. Ask Tim the template question only if the desk needs it to open a drawing for him.

140. **Pack wording (follow-up to 129): NOT answered.** The suggestion "the five pages' wording is the desk's job, checked by Codex, Tim reads only if he wants" was put to him; he did not reply to it. Desk must: not treat the 97 changes as approved; keep them as DRAFT until he says so.

## Sat 31 Oct 2026: Tim's spoken answers to the bug-proof plan (brainstorm by CE 04; follows decision 124). Tim's words: "bug: 1 yes seems right, 2i can do some each week, 3yep, 4yep, 5yep. if something has passed we dont need to retest unless code has changed since tested"

141. **Three-lane proof plan (bug-proof question 1): yes.** Tim's words: "1 yes seems right". Lanes: (A) robot proves it in real AutoCAD 2027 and Codex independently re-checks, both pass = accepted by name in the ledger; (B) judged by eye: robot takes pictures, Codex judges them against the Design Guidebook, Tim sees one picture sheet and flags only the ones he dislikes; (C) needs Tim's engineering call: a short list to him. Closes decision 124 (bug order and how to accept): the order of work stays CE 00's recommended order as a working default (60 pilot-critical, then proofs of the 336 installed fixes, then no-fix bugs by how often a drafter hits them), accepted by this plan.

142. **Weekly spot-check (question 2): Tim does some each week.** Tim's words: "2i can do some each week". Interpretation: a random spot-check of about 5 accepted fixes a week, picked by the desk; any failure stops that lane until fixed. He did not give a number: 5 is the desk's proposal (GUESS on the number).

143. **Picture sheet for lane B (question 3): yes.** Tim's word: "3yep". One sheet of pictures per batch, Tim flags only the ones he dislikes; he may skip it.

144. **Start the count (question 4): yes.** Tim's word: "4yep". Desk must: a read-only count sorting the 336 "fix installed" bugs into lanes A, B, C, with how many already have a robot case; no AutoCAD, no builds.

145. **Rule change (question 5): robot plus Codex acceptance counts as fixed.** Tim's word: "5yep". This replaces the line in BUG_CARPARK.md and the project CLAUDE.md "Never mark a bug FIXED until Tim has confirmed it works in AutoCAD": a bug counts FIXED when the ledger accepts it by name (robot PASS plus Codex PASS, per decision 62), and Tim confirms by exception and by the weekly spot-check. Desk must: update the rule text in BUG_CARPARK.md (CE 05 owns it) and say so; "installed" is still not "fixed".

146. **A pass stays valid until the code changes (re-test rule, standing).** Tim's words: "if something has passed we dont need to retest unless code has changed since tested". Interpretation: matches the standing re-test rule (decisions 115 to 117 and Addenda 1 to 4): each acceptance is recorded against the build it passed on; it is NOT re-run after later installs unless that tool's own code, or a shared file it uses, has changed (then its own tool, or its area plus the small smoke set per shared file). One full re-test before Max (Fri 13 Nov) remains from decision 116. GUESS: that full re-test still stands, because he said it is the plan "throughout as a rule" on 30 Oct; if he now means no full re-test at all, he will say. Desk must: record the build hash of each tool's code beside each acceptance so "changed since tested" is a check, not a judgement.

## Sat 31 Oct 2026: Tim on full re-tests

147. **No full re-test (changes decision 116 and the dated full passes of decision 70).** Tim's words: "i think no full retest cause it would take forever". Interpretation (mine; Tim said "i think", GUESS on how far it reaches): the standing "one full re-test before Max (Fri 13 Nov) and at the weekends" is dropped. After any install the desk re-tests only what the train touches plus the small smoke set per shared file (decisions 115 to 117); each acceptance is tied to the build it passed on (decision 146); the weekly spot-check (decision 142) is the backstop. The dated full passes in decision 70 (Sat 31 Oct, Sat 7 Nov, Tue 10 Nov and the confirming full pass Sat 14 and Sun 15 Nov) are probably dropped too: NOT confirmed. Desk must: tell CE 07 and CE 01; do not cancel any dated pass until Tim has confirmed in batch 2 (voice question 1); the robot still uses idle AutoCAD time for area and smoke work (Rule 15).
