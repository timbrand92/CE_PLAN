# TOOL NOTE: Draw a pipe (CD)

**Core since:** not yet
**Build this note describes:** Civil 3.0.90 (installed code, commit cf059dcf)

---

## 1. What it does

1. **Draws a stormwater pipe:** you pick the points first, then the New Pipe window opens for size, material, grade and levels (draw-first is the default; a Settings switch puts the window first).
2. **Labels it** with the pipe text, level text at each end and a flow arrow, and joins its ends to the pits they sit in.
3. **Carries on** to the next pipe until you press Esc.

## 2. What it changes in the drawing

1. **Draws** the pipe on STORMWATER PIPE (width = diameter), an outline on DRAINAGE, pipe text on 25TEXT, level text on 20TEXT, the arrow on ARROW, and a breakline symbol on 18CONT where used. On AutoCAD 2027 the pipe becomes CE's one-piece pipe object.
2. **Stores** the pipe's record row (size, material, grade, levels, From and To), its links to pits, and any junction on a main.
3. **Pit ends move to the inside wall** of a pit they land in.
4. **Can change pits:** Upsize a pit too narrow for the pipe (you are asked), or move a detention pit (you are asked).
5. **Splits pipes that cross pits** (asks Yes or No the first time; the answer is remembered in this drawing).
6. **No whole-drawing record update.** It marks the drawing as a CE drawing and makes CE's record this drawing's without saving, before the first point.
7. **Remembered values:** pressing Start Pipe saves the window's values to a file on your PC, even if the pipe is cancelled afterwards.
8. **Zooms** to the pipes and sets object snaps to CE's own, putting yours back at the end.

## 3. What it will not do

1. **Refuses before anything is asked:** read-only drawing, Paper Space, REFEDIT open, Structural drawing (asks first).
2. **Pipe of 1 mm or less** (metre drawings converted): "The pipe has no length (1 mm or less): pick two different points."
3. **Blank size or material:** Start Pipe stays off. Also off for a comma figure, an end on an Xref, an end touching several objects, a duplicate pit name, or both ends in one pit.
4. **"Existing line":** refuses a line that is already a CE pipe, a CE label, in an Xref or on a locked layer ("Nothing was changed"). A curved or closed line is kept, not erased.
5. **Locked pipe layer: no refusal found.** The pipe is drawn; CE then says it left its record alone for a locked layer. A pit on a locked layer: the pipe is drawn and a line says "Do not draw the pipe again".
6. **No Arc option** at the point questions.

## 4. What it asks you, and what Enter means

1. **"Specify first point or [Existing line]":** Enter is not accepted. Esc: "CD command cancelled."
2. **"Specify second point":** Enter is not accepted.
3. **"Select point 3 (or Enter for straight pipe)", then "Select point N (or Enter to finish ...)":** Enter finishes the pipe. Even a two-point pipe needs this Enter.
4. **New Pipe window:** Enter = **Start Pipe**. Cancel: "CD command cancelled." A "Recent:" line offers your last sizes, materials and levels once you have used some.
5. **Levels run against the chosen direction:** "[UseLevelDirection / KeepNominatedDirection / Review] <Review>". Enter reopens the window.
6. **Pipe wider than a pit side:** [Upsize/Continue/Cancel]; **Enter = Upsize** the pit (Continue if no bigger size).
7. **Detention pipe:** [ExtendPipe/MovePit/Cancel] <ExtendPipe>.
8. **Same-plan break:** "Real total pipe length (m) <default>" first; Enter takes the default.
9. **Typed grade more than 10% off the levels:** a box; Enter = Keep typed; Esc cancels.
10. **After drawing:** callout arrow and elbow points (long label); manual text point, rotation (Enter = 0) and "mirror? <No>"; on 3 or more points "Pick a point to move arrow AND text to that segment, or press Enter to accept" (Enter and Esc both accept); design warnings (Enter = OK); breakline "Continues to another plan?" (Enter = Yes); same-plan break points; crossing pits (Enter = Yes).
11. **Join a nearby pipe end** (two or more in reach): Enter = None.
12. **Next pipe:** "Specify first point or [Existing line]" again. Esc: "Stopped. Everything placed stays; U takes back the last one."
13. **Window-first mode only:** the Uphill box. Enter = Yes (flip the levels), No = rising main, Cancel = erase.

## 5. When it says Unknown or "needs checking"

1. **Blank invert** is a warning, not a block (switch on).
2. **Typed level rounded:** a note says so (switch on); not stopped.
3. **A later Cancel can leave a pit changed:** cancelling after you answered Upsize says "CD cancelled - nothing was drawn." but the pit stays upsized until U.

## 6. How to undo it

1. **U once per pipe:** pipe, labels, record, any pit upsize and crossing split.
2. **Not undone by U:** the remembered values file, recent sizes and levels, and this job's last size and material.

## 7. Known faults

**Still there in this build**
1. **BUG-034:** rising-main continuation is only the window tick; the command-line continuation is never used.
2. **BUG-1233:** a pipe on the Standard grade is switched to "Set my own" by the "I know one end" working.
3. **BUG-1235:** the minimum-grade test is exact but the print is rounded ("1:200 is shallower than minimum 1:200").
4. **BUG-563:** the equal-inverts message wording.
5. **BUG-941:** wording left in the older tabbed window (not the one-page window).
6. **BUG-1267:** a remembered downstream level counts as typed by you, so the old fall is held (read from code, not run).

**Partly fixed**
1. **BUG-023:** the breakline-end level is hidden; one shared level is not built.
2. **BUG-027:** " MIN." is added only for the default grade with one level known.
3. **BUG-308:** pit reach is unit-aware and ends go to the wall; not proven.
4. **BUG-337:** a held line and no worked-out level in a mixed-units drawing; the Edit Pipe half is not CD.
5. **BUG-442:** the FLAT label is fixed; Edit Pipe's "1 in 100" not read.
6. **BUG-685:** a rounded typed level is now said, not stopped. Needs Tim's ruling.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-331:** the minimum length is 1 mm, converted for metre drawings.
2. **BUG-1043:** blank invert no longer blocks Start Pipe.
3. **BUG-1226, BUG-1238:** the "Recent:" line is back on the one-page window (shows after first use).
4. **BUG-675, 676, 680:** pit fit and Upsize with a rotated pit, lid wording kept, number mismatch.
5. **BUG-681, 682:** Uphill answers update the schedule; Uphill Cancel puts back what it can. Window-first mode only.
6. **BUG-011, 014, 015, 016, 021, 025, 041, 042, 073, 074, 075, 076, 077, 091, 205, 286, 427, 463, 669, 683, 686, 874, 996, 1229:** each has a change in this build (see the sources).
7. **BUG-030, 031:** the continuation question is now a window (but see new fault 1).

**Reported, could not confirm in code**
1. **BUG-166** (double-click a level text), **BUG-187**, **BUG-435** (start-up text), **BUG-456** (X-Civil import), **BUG-943** (Help wording), **BUG-1230** (plan preview), **BUG-1234** (labels at pit ends), **BUG-1239** (label position).

**New in code, no bug covers it**
1. **"Continues to another plan?" answer is ignored.** The breakline symbol is placed and "you'll be prompted to continue" is printed whatever you answer, even No or Esc.
2. **Default level-text side ignores Settings** unless "remember" is on.
3. **Quick Mode inverts switch does not change placement.**
4. **A label, level or arrow that fails** is only logged; CD still reports success and the record says the label exists.
5. **Window-first starting levels 1.10 and 1.20 run uphill.**

## 8. On AutoCAD 2022 to 2024

1. **The window shows a schematic,** not the real plan beside the pipe.
2. **The pipe is expected to stay a plain polyline:** the one-piece pipe object's loader says "AutoCAD 2027 only". Whether any older-AutoCAD loader exists was not found.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_civil\Modules\Drainage\`.

1. **1.1:** `Commands\CdCommand.cs:44`, `106-214`; `Models\UserSettings.cs:2266, 2278`.
2. **1.3, 4.12:** `CdCommand.cs:233-243`; `Services\PlacementContinuationService.cs:43-76`.
3. **2.1, 8.2:** `Services\LayerService.cs:51-60, 127-138`; `Services\DrawingService.cs:156-168`; `Services\PipeCreationService.cs:217, 585-595`; `CdCommand.Breakline.cs:340`; `Services\NativeObjects\CeCvlObjectsBridge.cs:117`.
4. **2.2:** `Commands\CdCommand.Schedule.cs:78-121, 139`; `CdCommand.cs:778, 787`.
5. **2.3:** `Commands\CdCommand.BranchEnds.cs:27-50`.
6. **2.4, 4.6, 4.7:** `Commands\CdCommand.PitFit.cs:64-98`; `Commands\PitEditCommand.Resize.cs:20`; `CdCommand.cs:1364-1411`.
7. **2.5, 4.10 (crossing):** `Services\PipeCrossingSplitService.cs:100-105`; `UserSettings.cs:1767`.
8. **2.6:** `CdCommand.cs:55, 64, 68`; no record update call in `Commands\CdCommand*.cs`.
9. **2.7, 6.2:** `ViewModels\CdViewModel.Commands.cs:43-51`.
10. **2.8:** `CdCommand.cs:255, 814`; `Services\OsnapService.cs:40, 47`.
11. **3.1:** `CdCommand.cs:55`; `Services\DrawingSafetyService.cs:61-131`.
12. **3.2, 7 BUG-331:** `CdCommand.cs:1296-1317`.
13. **3.3, 4.4:** `Rules\PipeStartReadiness.cs:177-185, 264-306`; `Dialogs\PipeEditWorkshopDialog.xaml:493-494`; `Dialogs\PipeOnePageLayout.cs:82-85, 335-392`; window choice `Services\DialogService.cs:41-45, 80-89`; `Dialogs\WorkshopPipeCreation.cs:24-28`.
14. **3.4:** `Commands\CdCommand.ExistingLine.cs:149-215`.
15. **3.5:** `Services\LinkService.Persistence.cs:1275-1296`; `Rules\LockedLayerRecordWriteRule.cs:88-106`.
16. **3.6, 4.1 to 4.3:** `CdCommand.ExistingLine.cs:80, 103, 128`; `Rules\CdRoutePromptRules.cs:23, 36`; `CdCommand.cs:1244-1278`; `UserSettings.cs:2332`.
17. **4.5:** `CdCommand.cs:166-178, 269-272`.
18. **4.8:** `Commands\CdCommand.SamePlanBreak.cs:265-270`; `UserSettings.cs:1068-1069`.
19. **4.9:** `Dialogs\GradeMismatchDialog.xaml:58`; `UserSettings.cs:1990-1991`.
20. **4.10:** `Services\TextService.cs:104, 131-141, 401, 1625`; `Services\MirrorService.cs:42`; `Commands\CdCommand.Arrows.cs:73-75`; `Dialogs\PipeValidationWarningDialog.xaml:83`; `Dialogs\ContinueRisingMainDialog.xaml:49`.
21. **4.11:** `CdCommand.BranchEnds.cs:151`; `Services\LinkService.PipeEndJoin.cs:21`; `UserSettings.cs:1528`.
22. **4.13, 7 BUG-681, 682:** `CdCommand.cs:865-910`; `UserSettings.cs:1053, 1061`.
23. **5.1, 7 BUG-1043:** `UserSettings.cs:1633-1639`; `PipeStartReadiness.cs:195-208`.
24. **5.2, 7 BUG-685:** `CdCommand.cs:536-547`; `UserSettings.cs:1703`; `Helpers\MathHelper.cs:322`.
25. **5.3:** `CdCommand.PitFit.cs:85, 97`; `CdCommand.cs:218, 406, 427`.
26. **7 still there:** BUG-034 `CdCommand.cs:127-136`; BUG-1233 `ViewModels\CdViewModel.Inverts.cs:823-829`; BUG-1235 `Services\DesignValidationService.cs:363, 369`; BUG-563 `DesignValidationService.cs:347`, `CdCommand.cs:1085`; BUG-941 `Dialogs\CdDialog.xaml:238, 244, 469`; BUG-1267 `CdViewModel.Inverts.cs:730-731, 863-864`, `Helpers\UpstreamDownstreamSuggest.cs:64-65`.
27. **7 partly:** BUG-023 `CdCommand.cs:685-691, 1147-1194`; BUG-027 `Commands\CdCommand.Grade.cs:217-222`; BUG-308 `Services\LinkService.PitOutline.cs:235`; BUG-337 `CdCommand.cs:471-490`; BUG-442 `CdCommand.Grade.cs:187-194`.
28. **7 fixed:** BUG-1226/1238 `PipeOnePageLayout.cs:82-85`, `UserSettings.cs:1736, 1747`; BUG-675 `CdCommand.PitFit.cs:64-66`; BUG-676 `ViewModels\PitViewModel.cs:1302-1305`; BUG-680 `PitEditCommand.Resize.cs:97-104`; BUG-011 `TextService.cs:474, 1467-1480`; BUG-014 `MathHelper.cs:80-110`; BUG-015 `CdCommand.Grade.cs:198, 392`; BUG-016 `ViewModels\CdViewModel.Grade.cs:188-191`; BUG-021 `TextService.cs:1070`; BUG-025 `MathHelper.cs:229`; BUG-041 `CdCommand.cs:1244-1248`; BUG-042 `ViewModels\CdViewModel.PipeType.cs:148-149`; BUG-073 `Commands\CdCommand.GradeSuggestion.cs:131`; BUG-074 `CdCommand.Arrows.cs:64-129`; BUG-075 `TextService.cs:1139`; BUG-076 `CdViewModel.Inverts.cs:770-836`; BUG-077 `CdCommand.GradeSuggestion.cs:474-478`; BUG-091 `Services\LinkService.NewPipeEnds.cs:50-57`; BUG-205 `Services\CdDrawFirstFlowService.cs:98-104`; BUG-286 `Services\LinkService.PitMoves.cs:105-115`; BUG-427 `CdCommand.Grade.cs:187-194, 371-373`; BUG-463 `ViewModels\PitScheduleViewModel.Data.cs:1806, 1906`; BUG-669 `Services\LinkService.Reactors.cs:1707-1710`; BUG-683 `CdCommand.cs:440-453`; BUG-686 `Services\PipeCreationService.PreparedOutputs.cs:267`; BUG-874 `UserSettings.cs:623`; BUG-996 `UserSettings.cs:1293`, `MirrorService.cs:142`; BUG-1229 `CdViewModel.Inverts.cs:783-818`, `UserSettings.cs:1693`; BUG-030/031 `CdCommand.Breakline.cs:73-87`.
29. **7 new 1:** `Commands\CdCommand.Breakline.cs:37-64` (answer stored at 41, never used).
30. **7 new 2:** `CdViewModel.Commands.cs:109-110`; `CdCommand.cs:741-744`; `UserSettings.cs:2112`.
31. **7 new 3:** `PipeCreationService.cs:354, 397-437`; `CdCommand.cs:634, 816`.
32. **7 new 4:** `PipeCreationService.cs:347-350, 414-417, 450-453, 553-556`; `CdCommand.Schedule.cs:91, 98`.
33. **7 new 5:** `CdViewModel.Commands.cs:106-107`; `UserSettings.cs:1864, 1867`.
34. **8.1:** `Dialogs\PipeOnePageLayout.cs:246-265`.

Checked against the installed code (Civil 3.0.90), Fri 13 Nov 2026, 00:43. Nothing was run in AutoCAD.
