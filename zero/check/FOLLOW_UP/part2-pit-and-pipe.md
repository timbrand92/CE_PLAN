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

## From the check of team/acad-windows at 53442d4 (A1 to A3), Fri 20 Nov 2026

Reports: `C:\CE_WORK\check\reports\acad-windows_honest_REPORT.md` and `acad-windows_adv_REPORT.md`; pictures in the folders `acad-windows_pics` and `acad-windows_adv_tests` beside them. Checked on the bench. The blockers are in the verdict page `team-acad-windows.md`.

### Belong to the windows (for the build room)

16. **A refused figure leaves a confident label.** Type letters over the grade or the size: the field is flagged, but the top strip still reads the old "1 IN 62.5" or "150 DIA." (`bench/CeCivil.Bench.Core/WindowModel.cs:798, 1480`; `src/CeCivil.Window/Parts/Std/StdPreviewDraw.cs:194`). Standing brief 3.3: Wrong, and what depends on it "Cannot check yet".
17. **The Pit picture shows the wrong pipe size:** a 100 inlet and a 300 outlet; step 2 reads 300 out, the left picture shows 100 both sides (`StdPreviewDraw.cs:116`).
18. **A turned rectangular pit is drawn unturned** (D-267); a pit that had no size shows a dashed 450 "old size" it never had; the 350 plastic pit shows no grate; with "Cover level text" unticked its prefix still shows (`StdPreviewDraw.cs:89-131`).
19. **The Pit preview shows text the tool does not draw:** "IL ..." at each pipe end; "PP" and the cover text on two lines where the drawing has one (`StdPreviewDraw.cs:126-131`).
20. **Bends do not show in the Pipe strip;** a 0.30 m pipe and a 120 m pipe look the same; a pipe ending on another pipe reads "not joined yet"; a legal point at the end is drawn as a square pit with a cover level (legal point is Stage 2).
21. **In the Pipe strip an unknown size is drawn at the width of a 150,** and a pit of unknown size as a solid square (dashed only in the Pit window) (`StdPreviewDraw.cs:158-170`).
22. **"Work downhill" does nothing when neither invert is known** (`bench/CeCivil.Bench.Core/WindowModel.cs:996`). Screen rule 23.
23. **The Inspect button is gone from the footer** (`src/CeCivil.Window/Parts/Std/StdChrome.cs:84`; D-065). For the control room: wanted in the approved style or not.
24. **Second monitor:** the window is placed on the main screen's work area (`src/CeCivil.Acad/PitCommand.cs:107`).
25. **Two windows saving a size at once lose one** (32 of 32 paired saves); a read-only folder leaves a `.tmp` file behind (`bench/CeCivil.Bench.Core/WindowSizeStore.cs:42-45`). A remembered small size (down to 640 by 420) can clip the steps.
26. **An untouched pipe says its choices changed** on reopening (material and label side "was ...") (`bench/CeCivil.Bench.Core/PipeToolWindow.cs:75`).
27. **The style check would pass a wrong label** ("999 DIA. WRONG"): it looks for " DIA. " and named parts only (`bench/CeCivil.Bench/StyleCheck.cs:769-942`). The A2 tests use made-up content and one screen size; one A3 test checks two flags only.
28. **The Pipe picture beside the inputs (D-313)** sits in step 3, not beside step 1; its size and contents are open (U-013, U-038). The Pipe band is 108 high against Detention's approved 240 (D-305).
29. **The bench's own Pit picture is not what PT opens** (`bench/CeCivil.Bench/Shoot.cs:137` opens with no starting pit; the command opens at 450 by 450).
30. **Long or missing names:** an unnamed joined pit shows an empty name, not "Not known"; a very long name runs off the strip; the caption says "between its two pits" with none.

### On main already, not caused by this branch (passed to the control room, 20 Nov)

31. **Pipe kinds on the label:** a charged pipe carries a grade ("100 DIA. UPVC PIPE AT 1 IN 100" where the office wording is "... CHARGED TO WATER TANK"); a suspended pipe loses "SUSPENDED" and "MIN."; a detention pipe loses its length and "DETENTION" (`bench/CeCivil.Bench.Core/GradeLabel.cs:30`, `PipeToolWindow.cs:117`; D-268, D-312). Their Stage 1 scope is open (U-036). With item 8 above, one fault: the label formatter writes the ordinary wording for everything.
32. **Cover not known:** the preview shows "CL TBC" but the Pit tool leaves the cover text off the drawing (`src/CeCivil.Hands/Pit/PitTool.cs:246`); D-178 asks for TBC on the sheet.
33. **A held depth is lost:** type a depth of 1.20, OK, reopen the pit: depth is "Not known" (the list of figures kept with the pit leaves depth out: `src/CeCivil.Brain/data/tools.csv:36`, `bench/CeCivil.Bench.Core/ToolWindow.cs:137`). A held cover level survives. Screen rule 26.
