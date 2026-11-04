# Card draft: Civil OFF in older projects, and better handling of old projects (04 Nov 2026)

Review gate (AGENTS.md in the plugin repo): this is step 1 to 3, planning only. No code until Tim approves the card.
Source idea: IDEAS_INBOX.md, IDEA-OLD-PROJECTS-CIVIL-OFF. Tim's words: "WE NEE DTO BE ABLE TO TURN OFF CIVIL IN OLDER PROJECTS AS IT MESSES STUFF UP SOEMTIMES AND WE ALSO NEED TO HANDLE OLD PROJECTS FAR BETTER". Tim, 4 Nov 2026, "Start review".

1. **Classification:** Missing (a per-drawing Civil OFF switch) and Modify (what happens when an older drawing opens). Nothing is retired.
2. **Read from code, not run in AutoCAD.** Installed build Civil 3.0.90, commit cf059dcf. Files: Services/CivilQuietMode.cs, DrawingDisciplinePolicy.cs, DrawingDisciplineService.cs, LinkService.Cache.cs, NativeObjects/PipeObjectUpgradeService.cs, PipeObjectUpgradeGate.
3. **What works today:**
   1. Disable on Restart (CEMANAGER, BUG-851/#1473) switches Civil off for the whole PC, needs a restart, hits every drawing.
   2. Civil already goes quiet per drawing. A drawing with no Civil content (a Structural drawing) is decided "quiet" at open and stays quiet until a Civil command runs, it is tagged Civil, or a Civil object is written (one rule: DrawingDisciplinePolicy.ShouldCivilBeActive). A drawing with a CE record is always "Civil active", whatever its name or tag says.
   3. An explicit tag in the drawing (CE_CVL_DISCIPLINE, CVL or STR) already beats the file name. There is no "OFF" value.
   4. Open-time pipe upgrade (the C7 upgrade): converts CE pipes to pipe objects, takes one PRE_C7 backup the first time, gives pipes CE identities, turns PROXYGRAPHICS on. CORRECTED 4 Nov 2026 (Tim: "ITS ON SILVIAS PC THE UPGRADE BUT ALSO MINE"): it is NOT held on colleagues' PCs. B-046 (29 Oct, "defualt on for everyone") made Automatic mean On for every sign-in on AutoCAD 2027; the old "held on colleagues' PCs" text (UX-MIX-03, 26 Sep) is superseded. The first reading in this card was wrong.
4. **What is missing:** no way to say "this drawing: hands off". Once a drawing holds a CE record, Civil is awake on it and the open-time upgrade runs on Tim's PC.
5. **Design idea (not decided):** reuse the existing quiet flag and add an explicit OFF tag in the drawing that wins over "has Civil content" and stops the wake-up. One code path, no second switch (design rule 1).
6. **Seen on the Dromana job today (log, 4 Nov 2026):** at 13:30 the open upgrade converted 6 pipes; CDRENUMBER at 13:32 and 13:42 changed pit numbers; CE's relinking ran after commands. Which of these "messed stuff up" is Tim's to say (question 1).

## Questions for Tim (batch, with recommendation)

Answers are recorded under each question as Tim's words with the date he gives them. Recommendation first.

1. **Which job and what did Civil change?** Recommend: name one job and say what moved (pipes redrawn, labels moved, numbers changed, pits relinked). CE then reads that job's log.
2. **What does OFF mean?** Recommend: at open and while drafting CE changes nothing in that drawing (no pipe upgrade, no relinking, no identities, no label moves, no auto-renumber); the drawing opens as saved.
3. **What still works in an OFF drawing?** Recommend: commands that only read (PITSCHEDULE, CDCHECK, exports) run; commands that change the drawing ask once ("Civil is OFF here, run anyway?").
4. **Where is the switch?** Recommend: one ribbon toggle on the Civil panel showing ON or OFF, plus a command-line note when an OFF drawing opens.
5. **Where is it stored?** Recommend: inside the drawing, so a colleague opening the file gets the same OFF.
6. **Does CE offer OFF by itself for old drawings?** Recommend: yes, once, when it opens a drawing saved by an older CE: "Older project. Leave as it is (Civil OFF) or upgrade?" Default: leave as it is.
7. **What counts as old?** Recommend: the CE version that last saved the drawing, read from the drawing's own CE record, against the current pipe-object version.
8. **Backup:** today one PRE_C7 backup is made before the first upgrade. Recommend: keep, and make the same backup before any other open-time change.
9. **Turning ON again:** recommend: ON works from then on; CE catches up the old drawing only when you run CDSYNC or CDUPGRADE, never by itself.
10. **Disable on Restart (whole PC):** recommend: keep it as it is.
11. **Colleagues:** recommend: same switch, same default as yours (exact setup rule); no extra question to them.
12. **"Handle old projects far better": pick your top 3.** a) banner on open saying the project is older; b) Pit Schedule and Project QA say what they leave out (BUG-1274); c) preview of what an upgrade would change before it runs; d) open read-only option; e) merge of the old AppData project file; f) something else. Recommend: a, b, c.
13. **Test drawings:** recommend: copies only of Dromana (PRE_C7) plus two older jobs you name.
14. **First slice:** recommend: OFF switch (questions 2 to 5) first, banner (12a) second, the rest after you have used it.

## Added requirement (Tim, Wed 4 Nov 2026, after question list 1 to 14)

Tim: "IT ALSO NEEDS TO BE CLEAR WHAT AN END USER NEEDS TO DO TO GET THE OLD DRAWING UPGRADED".

What an end user has today (read from code at cf059dcf, not run):
1. **Automatic on open** on Tim's PC only (pipe upgrade, one PRE_C7 backup, no question). SUPERSEDED 4 Nov (see item 4 correction): it also runs on colleagues' PCs on AutoCAD 2027. The held line only shows on a PC where the setting is Off or the enabler is missing (AutoCAD 2022 to 2024), and tells the drafter nothing about what to do.
2. **CDC7UPGRADE** converts the pipes in place after a backup (AutoCAD 2027 only). **CDUPGRADE** refreshes CE's record from the drawing and asks Merge or Replace. Two commands, two jobs, no word "upgrade" tells which is which, no order, and no ribbon button.
3. **Nothing on screen** says a drawing is old, what is needed, or whether it has been done.

Questions 15 to 18 (recommendation first):
15. **One action or two?** Recommend: one ribbon button and one command, "Upgrade this drawing", that runs the steps in the right order and says what it did. The two old commands stay for now.
16. **What the drafter sees before it runs:** recommend: a short window listing what will change in plain words (for example "46 pipes become pipe objects, 5 pits get a CE number identity, a backup is saved as <name>") with Upgrade and Cancel.
17. **What the drafter sees after:** recommend: a done message with the backup file name, the count of things changed, and the one-line undo ("U" once, or restore the backup). A not-done drawing shows "UPGRADE NEEDED" on the toggle from question 4.
18. **When the upgrade cannot run** (colleague's AutoCAD 2022 to 2024, locked layer, Xref): recommend: say why in plain words and what to do ("Open this drawing on AutoCAD 2027" or "Ask Tim"), never the engineering held-line.

## Tim's answers, Wed 4 Nov 2026 (verbatim, capitals are his)

"ITS ON SILVIAS PC THE UPGRADE BUT ALSO MINE" (correction of the card's first reading, see item 4)

1. "ITS THE JOB I SENT YOU" (the Dromana job). Reading: the 09:39:59 PRE_C7 backup of that job is not in Tim's log, so the open-time upgrade that morning was most likely on Silvia's PC (interpretation, not proven).
2. "MEANS THE WHOLE PLUGIN TURNS OFF AND ISNT USABLE AND DOESNT TOUCH THE DRAWING THAT IS OPEN"
3. "YES"  (CONFLICTS with answer 2, see open point A)
4. "YES"
5. "YES"
6. "ASK USER WHEN OPENS"
7. "ANYTHING PRIOR TO V3.0.89" (open point B: the record has no CE build stamp)
8. "YES"
9. "YES"
10. "LEAVE AS IS"
11. "RECOMMENDED"
12. "AS YOU RECOMMEND" (banner, Pit Schedule and Project QA say what they leave out, preview before upgrade)
13. "AS RECOMMENDED"
14. "AS RECOMMENDED"
15. "ONE ACTION - PROMPT ON OPENING OF DRAWING"
16. "YEP"
17. "YEP"
18. "YEP"

Open points (CE has not decided these for Tim):
- **A. Answer 2 against answer 3.** Answer 2 says OFF makes the plugin unusable in that drawing; answer 3 says read-only commands (PITSCHEDULE, CDCHECK, exports) still run and changing commands ask. Recommendation: answer 2 wins (OFF = nothing runs, ribbon greyed, one line says "Civil is OFF in this drawing. Upgrade it or turn Civil ON."), and answer 3 applies after the drawing is turned ON. Tim to confirm.
- **B. Answer 7 needs a stamp.** The drawing's CE record carries only a record-format number (2.3 on the Dromana job, 2.1 on its October saves), not the CE build that last saved it. Recommendation: from the next build every save writes the CE build into the record, and a drawing with no stamp counts as "prior to 3.0.89" (old). Tim to confirm.
- **C. "Whole plugin".** Assumed to mean the whole Civil plugin, not Structural or Manager. Tim to confirm.

## Tim's confirmation of open points A, B and C (Wed 4 Nov 2026)

Tim: "Yes, all three". So, as recommended:
- **A (decided):** OFF means nothing runs in that drawing and the ribbon is greyed; one line says "Civil is OFF in this drawing. Upgrade it or turn Civil ON." Answer 3 (read-only commands run) applies only after the drawing is turned ON. Answer 3 as first given is superseded by this for OFF drawings.
- **B (decided):** every save from the next build writes the CE version into the drawing; a drawing with no stamp counts as prior to 3.0.89 (old).
- **C (decided):** "whole plugin" means the whole Civil plugin; Structural and Manager are not touched.

## The card in one page: what a drafter sees (for Tim's approval)

1. **Open an old drawing** (no CE version stamp, or a stamp before 3.0.89): a window asks once. "This is an older project. Upgrade it now, or leave it as it is (Civil OFF)?" Nothing in the drawing has changed yet.
2. **Leave as it is:** Civil is OFF for that drawing. The ribbon is greyed, the command line says "Civil is OFF in this drawing. Upgrade it or turn Civil ON.", and CE does not touch the drawing. The toggle on the Civil panel shows OFF and "UPGRADE NEEDED".
3. **Upgrade it (one button, one command, same window):** a short list in plain words (for example "46 pipes become pipe objects, 5 pits get a CE identity, a backup is saved as <name>") with Upgrade and Cancel. A backup is taken first.
4. **After it runs:** a done message with the backup file name, how many things changed and the undo (U once, or restore the backup). The toggle shows ON and the CE version is stamped.
5. **When it cannot run** (AutoCAD 2022 to 2024, locked layer, Xref): a plain sentence says why and what to do, for example "Open this drawing in AutoCAD 2027."
6. **Pit Schedule and Project QA** say how many pits they leave out and why (BUG-1274). The banner on open says the project is older.

First slice (Tim's answer 14, as recommended): OFF switch and the open prompt, then the banner. Test drawings: copies only of the Dromana job plus two older jobs Tim names (answer 13).

**Status:** all 18 questions and A, B, C answered. Waiting for Tim's approval of this one-page card before any code (review gate step 6). Not built, not tested. A build needs the release chat to take it; this chat does not build it.
