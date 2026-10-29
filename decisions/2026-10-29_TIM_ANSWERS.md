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
