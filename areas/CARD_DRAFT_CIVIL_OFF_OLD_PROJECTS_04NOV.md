# Card draft: Civil OFF in older projects, and better handling of old projects (04 Nov 2026)

Review gate (AGENTS.md in the plugin repo): this is step 1 to 3, planning only. No code until Tim approves the card.
Source idea: IDEAS_INBOX.md, IDEA-OLD-PROJECTS-CIVIL-OFF. Tim's words: "WE NEE DTO BE ABLE TO TURN OFF CIVIL IN OLDER PROJECTS AS IT MESSES STUFF UP SOEMTIMES AND WE ALSO NEED TO HANDLE OLD PROJECTS FAR BETTER". Tim, 4 Nov 2026, "Start review".

1. **Classification:** Missing (a per-drawing Civil OFF switch) and Modify (what happens when an older drawing opens). Nothing is retired.
2. **Read from code, not run in AutoCAD.** Installed build Civil 3.0.90, commit cf059dcf. Files: Services/CivilQuietMode.cs, DrawingDisciplinePolicy.cs, DrawingDisciplineService.cs, LinkService.Cache.cs, NativeObjects/PipeObjectUpgradeService.cs, PipeObjectUpgradeGate.
3. **What works today:**
   1. Disable on Restart (CEMANAGER, BUG-851/#1473) switches Civil off for the whole PC, needs a restart, hits every drawing.
   2. Civil already goes quiet per drawing. A drawing with no Civil content (a Structural drawing) is decided "quiet" at open and stays quiet until a Civil command runs, it is tagged Civil, or a Civil object is written (one rule: DrawingDisciplinePolicy.ShouldCivilBeActive). A drawing with a CE record is always "Civil active", whatever its name or tag says.
   3. An explicit tag in the drawing (CE_CVL_DISCIPLINE, CVL or STR) already beats the file name. There is no "OFF" value.
   4. Open-time pipe upgrade (the C7 upgrade): converts CE pipes to pipe objects, takes one PRE_C7 backup the first time, gives pipes CE identities, turns PROXYGRAPHICS on. It is already "held" (does nothing) on colleagues' PCs; Tim's PC upgrades.
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
1. **Automatic on open** on Tim's PC only (pipe upgrade, one PRE_C7 backup, no question). On a colleague's PC it is held and says only "Pipe upgrade is held on this PC until it is proven on AutoCAD 2022-2024." which tells the drafter nothing about what to do.
2. **CDC7UPGRADE** converts the pipes in place after a backup (AutoCAD 2027 only). **CDUPGRADE** refreshes CE's record from the drawing and asks Merge or Replace. Two commands, two jobs, no word "upgrade" tells which is which, no order, and no ribbon button.
3. **Nothing on screen** says a drawing is old, what is needed, or whether it has been done.

Questions 15 to 18 (recommendation first):
15. **One action or two?** Recommend: one ribbon button and one command, "Upgrade this drawing", that runs the steps in the right order and says what it did. The two old commands stay for now.
16. **What the drafter sees before it runs:** recommend: a short window listing what will change in plain words (for example "46 pipes become pipe objects, 5 pits get a CE number identity, a backup is saved as <name>") with Upgrade and Cancel.
17. **What the drafter sees after:** recommend: a done message with the backup file name, the count of things changed, and the one-line undo ("U" once, or restore the backup). A not-done drawing shows "UPGRADE NEEDED" on the toggle from question 4.
18. **When the upgrade cannot run** (colleague's AutoCAD 2022 to 2024, locked layer, Xref): recommend: say why in plain words and what to do ("Open this drawing on AutoCAD 2027" or "Ask Tim"), never the engineering held-line.
