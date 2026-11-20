# Follow-ups: Part 2, Pit and Pipe (non-blockers, kept so they are not lost)

## From the check of team/pipe-default at 741f0f2 (A5), Fri 20 Nov 2026

Reports: `C:\CE_WORK\check\reports\pipe-default_honest_REPORT.md` and `pipe-default_adv_REPORT.md`. Checked on the bench.

### Belong to A5 (for the build room, with or after the fix round)

1. **A zero or negative default size still gives figures.** With 0 or a negative in the office size row the diameter reads Wrong and the cover check reads "Cannot check yet", but the cover figure still shows 1.00 m or 1.10 m; a zero job override on a 40 m detention pipe gives 0.00 m³ counted (`src/CeCivil.Brain/data/sums.csv:31`, `Things/Network.cs:363`, `data/checks.csv:159`). Standing brief 3.3 says what depends on a Wrong input reads "Cannot check yet". Not held as a blocker: it needs a bad setting and the Job window that would set it is Stage 2. To close before Stage 2.
2. **A blank or text default-size setting stops the whole data library opening** (`Things/Standards.cs:412`, `Things/Library.cs:64`). It refuses honestly, but nothing opens at all.
3. **Clearing the size box keeps the old size** (`bench/CeCivil.Bench.Core/WindowModel.cs:1480`). No ruling that an empty box releases it.
4. **A typed smaller size is kept but no line shows both sizes** (375 arriving, 150 typed). Screen rule 26 asks to show both; the warning and how strong it is are open (U-048).
5. **No test for underground storage on a site with no tank** (`sums.csv:178`, after the engine change in `Sums/Sum.cs:225-232`); the build log says so itself.
6. **A loop of pipes** reads "Not known" and settles; no test.
7. **Not built, as the builder said:** the D-263 switch ("always office default" or "always last used"); the Job window line for the default size.

### On main already, not caused by A5 (passed to the control room, 20 Nov)

8. **The pipe label drops "MIN." when an invert is not entered:** "100 DIA. UPVC PIPE AT 1 IN 100" where D-238 and D-312 need "... AT 1 IN 100 MIN." (`bench/CeCivil.Bench.Core/GradeLabel.cs:30`, `PipeToolWindow.cs:117`). A wrong wording that reaches the plan. The same formatter writes the ordinary wording for charged and suspended pipe and leaves "DETENTION" off a detention pipe (D-268; U-036 leaves their Stage 1 scope open).
9. **A run cannot start on a pipe** ("A pipe cannot start on another pipe", `src/CeCivil.Hands/Pipe/PipeRun.cs:58`, `PipeTool.cs:259`) against D-355's "from anywhere to anywhere"; the junction detail is open (U-033). Item A6.
10. **A run clicked from the first pit to the last misses the pit between** (one pipe, not two); clicking each pit works (`PipeRun.cs:55`). D-355. Item A6.
11. **A plain polyline cannot be picked as the run** (`src/CeCivil.Acad/PipeCommand.cs:62`, `PipeTool.cs:183`). D-356. Item A6.
12. **The Pipe window still holds the words "Bench preview — the real preview will be AutoCAD's own drawing"** (`bench/CeCivil.Bench.Core/WindowSpec.cs:153`, `src/CeCivil.Window/Parts/PreviewPane.cs:57, 322`); with the default-size row missing the preview reads "unknown DIA." Item A3 (team/acad-windows).

### No ruling (for Tim's room)

13. **One arriving size known, another not known:** the leaving pipe reads "Not known"; 100 would be smaller than the known arrival (U-028).
14. **Pipes already drawn below a resized pipe:** in the sums they follow; on the drawing they stay (U-048).
15. **A pipe off an inlet, tank or legal point** opens at 100 as if from nothing (U-034); an ordinary pipe joined to twin barrels has no size rule (D-349 covers the barrels only); the default accepts a size outside the office list (137 was accepted).
