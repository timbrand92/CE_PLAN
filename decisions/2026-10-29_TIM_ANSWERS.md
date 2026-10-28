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
