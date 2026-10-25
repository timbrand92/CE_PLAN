# S-44 Opus finalizer: Structural train claude/rel-20261025s

Independent review of the 32 PRs the assembler merged on top of S-43 (`claude/rel-20261024s` at `4af3f37d`, Structural 1.0.123, the installed Structural line). Sun 25 Oct 2026, 15:11 to about 16:05 Melbourne time (PC clock). Opus 5.5, Team, headless, desk plan/03. Five read-only Opus helpers read the merge diffs against their review files in parallel; every verdict, commit, build and test below is mine. Private worktrees `C:\ce-fin\s44` (train) and `C:\ce-fin\s44b` (base), both removed. I did not start AutoCAD or accoreconsole, deployed nothing, changed no version field, closed no PR, deleted no branch, changed no PR base, merged no Civil or Manager PR, marked no bug FIXED, did not edit DESK_LOG.md.

## ANSWER FIRST

1. **GO at `007a211d9db4bdbd259a7ed821a21711c3b1e92f`.**
2. **Branch `claude/rel-20261025s`.** Start head `da852df3f58cc5ece891712eb7a258790e834c4d` (`git ls-remote` at 15:11 equal to the assembly report, and again just before my push). Final head `007a211d` after a normal fast-forward push of my three commits (leak scan clean, 36 terms). Every one of the 32 PR heads read live on GitHub still equals the head that was merged; all 32 are open.
3. **What I changed (three commits, each with a REGRESSION_LOG entry):**
   1. **`bc71667d`, a fix to #1460 (BUG-840), the one real fault in the train.** The new routine settings save wrote its merged text with a JSON call that AutoCAD 2027's own copy of the JSON library does not have. In AutoCAD every routine save (last used size, recent commands) would have stopped with a "method not found" error. Now it uses the same writer the full save already uses; the file text is the same. The plugin-wide guard that was red goes green.
   2. **`6e7fc15b`, a fix to #1742 (BUG-1079), wording.** The new STRUCEXPORTPDF Help said the plot progress window has "a Cancel button". The button is there, but CE never reads it, so pressing it does nothing. The phrase is dropped; the central register fingerprint of Structural's command list is re-set to `FF2AC767` (same method as the assembler's re-pin; I reproduced the old pin `30A0EEED` with the same method first). Row count 375, drift 395 unchanged.
   3. **`007a211d`, tests only.** `S44NewSwitchDefaultsTests` (4): the five new switches load ON from a blank file, from a 1.0.123-shaped file without the keys, and from a file with one bad value (the value-by-value read); switches typed OFF stay OFF. Its log entry also corrects the BUG-1045 entry's claim about a read-only folder (see 5.3).
4. **Verdicts (32 merged, none dropped, no revert):**
   1. **#1762 (BUG-1061, BUG-1062, BUG-1063, RCBEAM bar room): MERGE.** Window and writer now share `RcBeamBarRoom`; the writer's sums are the same for every type, so placed sections do not change. The test project links the source file (as 58 others). The Type 7 preview changes (see 6.1).
   2. **#1746 (BUG-1048, CEHATCHCHANGE): MERGE.** The split into "can change" and "left alone" happens before the Undo group starts; one U undoes exactly the hatches that changed; the line names the hatch left alone. All refused or switch OFF: the old "Nothing was changed" refusal.
   3. **#1749 (BUG-1045 Structural half, CE_INSPECT on a read-only drawing): MERGE.** Only the read-only refusal is skipped, only for CE_INSPECT, which only reads. Known limit: if the drawing's folder is also read-only, the report file cannot be written and the line is AutoCAD's raw "[CE_STRUC] CE_INSPECT error: Access to the path '...' is denied." Nothing crashes, the drawing is untouched.
   4. **#1744 (BUG-1072): MERGE.** **#1739 (BUG-1076): MERGE.** The merged Settings window holds #1744's backup tick with its grey note AND #1739's "Show save messages on the command line" and the renamed tab "Saving and fault reports" (I looked at the test-drawn page). Every tick still binds to the same saved setting.
   5. **#1745 (BUG-1073), #1740 (BUG-1077), #1741 (BUG-1078): MERGE.** Each new sentence checked against the code it describes and true. #1745 also writes one support-log line; no drawing or REDO effect.
   6. **#1742 (BUG-1079): MERGE-WITH-FIXES** (my `6e7fc15b`). Help text only; no command added, removed or renamed. Its two known faults are NOT fixed and carry over: Cancel is never read (`ExportService.cs`), and a second plot shows AutoCAD's raw "Another plot is already in progress."
   7. **#1766 (BUG-1069, tests only): MERGE.** It moves the two drawing-close checks from Civil's test project to Structural's: the old Civil copies looked for a retired folder and always skipped (and would have failed if they had run). No product file. The Civil test file still compiles (one helper now unused). It ships nothing to Civil users; the Civil owner should know the checks moved.
   8. **#1736 (BUG-1082, level marks): MERGE.** With 25DIMS or 25TEXT locked, FFL, RL, SSL, NGL and LM draw nothing, unlock nothing, and say "[CE] Layer 25DIMS is locked, so CE drew no level mark. Unlock it and try again." During REFEDIT they stop (REFEDITNAME is only read). The lock check comes after the point, side and value questions (three wasted answers; LOW).
   9. **#1729 (BUG-1037, column bars at real size): MERGE.** **#1732 (BUG-1039, timber quantity 10 or more): MERGE.** Both switches ON and right (old behaviour is the bug). The hand-resolved settings blocks are intact.
   10. **#1385 (BUG-755, RCBEAM Type 2 and 6 pictures): MERGE.** Picture only.
   11. **#1386 (BUG-752, long paths in CESETTINGS): MERGE.** Nine path boxes wrap; the buttons sit in their own bottom strip. Window size unchanged. The General page Data folder box still does not wrap (LOW).
   12. **#1460 (BUG-840, routine save keeps a second AutoCAD's change): MERGE-WITH-FIXES** (my `bc71667d`). The rest is sound: no new lock or wait (the merge runs again inside the existing save lock), a garbled file on disk falls back to writing this AutoCAD's whole copy, a value this AutoCAD changed always wins.
   13. **#1464 (BUG-841, mistyped number in Settings): MERGE.** Save checks every number box first and stops before anything is copied or written, naming the box and bringing its page forward. Loading untouched.
   14. **#1529 (BUG-864, 18HIDDEN and 9HIDDEN2 kept): MERGE.** An existing layer is no longer opened for a change; a missing one is still made exactly as before.
   15. **#1563 (BUG-977, SBEAM picks follow the UCS): MERGE.** The UCS is only read at the six places, never set; with World UCS the result is as before.
   16. **#1564 (BUG-975, support switch neighbour label): MERGE.** A label goes with the switched support only if no other support is nearer.
   17. **#1566 (BUG-978, Structural starts in a second AutoCAD): MERGE.** See 2.4.
   18. **#1568 (BUG-973, CESHEETSCLASSIC sheet number swap): MERGE.** Each row's drawing is recorded before any row is repointed; rename order and rollback unchanged.
   19. **#1574 (BUG-983), #1575 (BUG-985), #1577 (BUG-881), #1581 (BUG-986), #1582 (BUG-1016), #1585 (BUG-1015), #1589 (BUG-974), #1603 (BUG-950), #1604 (BUG-880), #1605 (BUG-610): MERGE, all ten.** These are the assembler's own additions, each with a plain "MERGE, train S-44" in Opus review batches B8, B9, B10 (verdict lines checked), each merged at its reviewed head. #1605 is first in its stack and brought only its own files.
   20. **#1737 (BUG-1041): not in the train, rightly.** Its live head is still `4ae66b1b`, the head the review said needs fixes 1 and 2.
5. **Defaults: five new switches, all ON, all KEPT ON** (the old behaviour is the logged bug each time; each loads ON from an old file, pinned by `S44NewSwitchDefaultsTests`; none changes anything Tim sees except by fixing the bug):
   1. `Options.ColumnBarsAtRealSize` (BUG-1037): the old fixed 40 mm circle whatever the bar was the bug.
   2. `Options.HatchChangeSkipsRefusedAndChangesTheRest` (BUG-1048): refusing every hatch because one could not be cleared was the bug.
   3. `Options.InspectRunsOnReadOnlyDrawing` (BUG-1045): refusing a read-only command on a read-only drawing was the bug.
   4. `Options.TimberQuantityAnyNumber` (BUG-1039): the cap of 9 had no engineering basis.
   5. `Bracing.UnknownWhenTypesDiffer` (BUG-950): a green tick on mixed brace types was the bug. BUG-950 stays open for Tim's rating-per-type ruling.
   6. **Nothing turned OFF.** No value or switch changed.
6. **Tests at the final head (Release, -p:SkipDevBundle=true -nr:false --disable-build-servers, Below Normal, own TEMP):**
   1. **Structural net10: 5,923 passed, 0 failed** (16 class chunks of 30 plus the 7 nested-class tests, 465 classes, `SbeamEditAutoCadEvidenceReaderTests` left out). That is S-43's 5,725 plus 198: the 34 new classes of the merged PRs (listed in the assembly report) and my 4. The assembler's one red (the JSON guard) is green.
   2. **Structural net48: 5,160 passed, 53 failed, 704 not run.** I built the base `4af3f37d` and ran the same chunks: 4,976 passed, 39 failed, 704 not run, the same as S-43. **All 39 base names still fail; the 14 extra are all new tests** of #1563 (`WorldUcs_ChangesNothing`, `PickInAMovedUcs_IsCarriedToWorld`, `PickInARotatedUcs_FollowsTheRotation`), #1564 (four `Label...`/`SupportWithNoNeighbour...` tests) and #1575 (`EveryChordPointLiesOnTheArc` x4, `ArcBulgingTheOtherWay_IsHitOnTheNearSide`, `BeamExtendedToAnArcBoundary_StopsOnTheArc_NotOnTheChord`, `StraightSegment_IsOneChordAsBefore`). All 14 fail with `InvalidProgramException` (the reference-only AutoCAD files on net48) and all pass on net10. They do not exist on the base. The assembler's 54 was these 53 plus the JSON guard.
   3. **Focused:** `StructuralSettingsFitAt150Tests` 1 of 1, plus `IssuePreviewSettingsRowTests`, `AutoCadWindowHostScrollTests`, `AutoCadWindowHostMathTests`, `AutoCadWindowHostGuardTests`, `Bug752SettingsLongPathTests`, the Bug841, Bug1048, Bug1045, Bug1037, Bug840, Bug1079 classes, timber quantity, bracing types and `Stage3ConnectedDesignBoundaryTests`: 121 of 121.
   4. **Standalone Structural build, all three lanes (net48, net8, net10): 0 errors**, each DLL stamped `1.0.123+007a211d...` (the final commit).
   5. **NOT re-run by me, because C: was under the 12 GB stop line (see 8.1):** the whole solution build, DesignCore (three lanes), CE.CommandTruth.Tests, Structural.ReleaseTests, and the official release build with its file-count guard. The assembler ran the first four at `da852df3` (solution 0 errors; DesignCore 2,207 per lane with the same five reds; CommandTruth 22 of 23 with the standing 395 drift; ReleaseTests 10 of 10 x3). My commits touch no DesignCore or release-test file; my register fingerprint was computed by the validator's own method and that method reproduces the previous pin exactly. **The official release build (2007-file guard) has not been run on this train by anyone: the payload builder must run it and check the count before building 1.0.124.**
7. **What Tim will see in AutoCAD after this train is installed (plain words):**
   1. **RCBEAM window:** the bar-spacing caution uses the spacing actually drawn (a 410 wide beam with 2N16 now reads 294 c/c, no false "more than 300"); a new line when cover and stirrups leave no room; for rebated beams (Types 4, 6, 7) the depth check uses the depth left after the rebate. In the Type 7 preview the red stirrup now starts 75 mm lower, leaving an empty band at the top with no notch drawn. Placed sections do not change. Type 2 and 6 thumbnails sit inside their boxes.
   2. **CEHATCHCHANGE:** with one hatch that cannot be cleared, the others change and one line names the one left alone; U once undoes the change.
   3. **CE_INSPECT** runs on a read-only drawing.
   4. **CESETTINGS:** System tab now "Saving and fault reports", plainer tick names, "Also keep backup copies of Civil-only drawings" with a grey note; long folder paths wrap; a mistyped number refuses to save and points at the box.
   5. **Help (CEHELP):** plainer words for BSET, the five markup tools, STRUCEXPORTPDF and the damaged markup review line.
   6. **Level marks** refuse on a locked 25DIMS or 25TEXT and during REFEDIT.
   7. **Column bars** drawn at their real size; **SBEAM timber quantity** accepts 10 and more; **SBEAM** picks follow a turned or moved UCS; **support switch** leaves the neighbour's label alone; **18HIDDEN and 9HIDDEN2** keep the drafter's own style; **a second AutoCAD** now loads Structural; **CESHEETSCLASSIC** number swap keeps each row on its own drawing.
   8. **The ten additions:** sheet update freezes only the real title Xref's layers; BEXTEND stops on an arc, not its chord; the hatch audit keeps a hatch's own scale; CSREOBAR uses the plan length and warns when the two picks differ in height; saving templates no longer deletes colleagues' waiting suggestions; a refused RIB or REB leaves the line as it was; a row left out of XCLMTXT no longer sets a support size; the bracing panel shows the amber triangle when brace types differ; CEMEMBER holds in a metre drawing; a checklist N/A then U no longer loses the checklist.
8. **Do not mark FIXED.** Every item needs a robot PASS plus a Codex PASS in AutoCAD on copies (section 5 lists the steps): BUG-1061, BUG-1062, BUG-1063, BUG-1048, BUG-1045 (Structural half; Civil half open), BUG-1072, BUG-1076, BUG-1073, BUG-1077, BUG-1078, BUG-1079, BUG-1069, BUG-1082, BUG-1037, BUG-1039, BUG-755, BUG-752, BUG-840, BUG-841, BUG-864, BUG-977, BUG-975, BUG-978, BUG-973, BUG-983, BUG-985, BUG-881, BUG-986, BUG-1016, BUG-1015, BUG-974, BUG-950 (stays open for Tim), BUG-880, BUG-610 (likely fix, not proven).
9. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Review method and merge integrity

1. **Each PR's own merge diff** (`git diff <merge>^1 <merge>`) was compared with the PR's GitHub file list: equal for all 32, nothing extra, nothing missing. `<merge>^2` equals the live head for all 32.
2. **Hand-resolved files:** `UserSettings.cs` and `SettingsService.LoadRecovery.cs` (#1746, #1749, #1729, #1732): all four switch blocks present, each with its own summary line and settings label. `CeSettingsDialog.xaml` (#1744 with #1739, then #1386): both changes present, window still `Width 1180 Height 850 MinWidth 1180 MinHeight 850`.
3. **Scope:** nothing under `Shared/`, `Installer/`, `CE.Host`, `Modules/Drainage` (product) or `Modules/Manager`. Outside `Modules/Structural*`: `REGRESSION_LOG.md`, `Assets/Config/ce-tool-register.json` (two fingerprint re-pins: the assembler's and mine) and `Modules/Drainage.Tests/Services/TeardownCrashGuardTests.cs` (#1766, test only).
4. **REGRESSION_LOG.md:** +330 lines against the base before my commits, nothing removed, no conflict marker, every PR entry present line for line; BUG-1077's and BUG-1078's "5. Undo" lines present.

## 2. Redo safety (U and REDO)

1. **Whole train diff scanned** (added product lines) for `SetCurrentView`, `SetSystemVariable`, `SendStringToExecute`, `Regen`, UCS writes, `+=`, `-=`, Idle, `DocumentManager`, timers, window `Loaded`/`SizeChanged`/`Closing`, transactions, mutexes and waits. **Hits:**
   1. `GetSystemVariable("REFEDITNAME")` (#1736, `LevelMarkCommands.cs`): a read.
   2. `editor.CurrentUserCoordinateSystem` read six times (#1563, `SbeamCommandRunner.cs` 174, 201, 202; `SbeamEditCommandRunner.cs` 402, 421, 422). **The UCS is read, not changed.**
   3. One `StartTransaction` (#1585, `FoundationService.cs` about 3827): puts the picked line back or erases a line CE just drew when RIB or REB is refused, inside the command's own Undo step, during the command. Never opens a locked layer for force, unlocks nothing.
   4. **#1566 at start-up (`Plugin.cs` 456):** the one-copy guard is the same named mutex as before, created once at load with no wait, released on shutdown and on a refused load; its name now carries the AutoCAD process id, so a second AutoCAD loads Structural while a second copy in the same AutoCAD is still refused. No new hook, event, file lock or wait: **it cannot stop or delay AutoCAD starting.**
2. **No added line can clear the redo list:** nothing sets a system variable, the view or the UCS inside a command; no command's transaction start or end changed. My three commits add no such line.

## 3. Installer and update safety

1. **Signed-update gate (`OfficialReleaseGate`) and command-ownership check (`SafeBundleInstaller.VerifyCommandOwnership`):** nothing under `Shared`, `Installer`, `CE.Host`, Manager or Civil product code changed; `PackageContents.xml` unchanged; no `[CommandMethod]` added or removed; Structural `command-registry.json` holds the same 375 command names (sorted list identical to the base), only Help text changed. The train cannot affect either check.
2. **`Plugin.cs`** changed by #1566 only (the mutex name).
3. **Bundle file count: not proven by me.** The official release build could not run under the disk line. No PR adds a file to the bundle as far as the diff shows (new `.cs` files compile into the existing DLLs; no new asset, block, DCL or LISP file), so 2007 is expected, but that is a reading, not the guard. The payload builder must run `build_installer.ps1` three-lane and see "verified 2007, bad 0, extra 0" and added 0, removed 0 against the installed 1.0.123.

## 4. Settings page

1. **Settings-fit:** `StructuralSettingsFitAt150Tests` still passes. #1744, #1739, #1386 and #1464 did not change the Settings window height or minimum size (1180 x 850, 16-unit margins); on a 1920 x 1080 screen at 150 per cent the window shrinks to the room and scrolls, as in S-43. That is a test, not a look.
2. **Values and switches without a Settings page row (no rows built):** the five new switches (none has a tick on the window; the first four have a recovery label, `Bracing.UnknownWhenTypesDiffer` has none). Carried from S-42: `Layouts.HatchDensityFollowsPaper`, `Layouts.TagTextFollowsLabelHeight`, `Layouts.FollowAnyDrawingScale`, the CeMember group. Fixed numbers noticed: #1575's arc tolerance 0.01 drawing units (up to 10 mm in a metre drawing, 0.1 mm on paper at 1:100).

## 5. Codex checks in AutoCAD (copies only, after install of 1.0.124)

1. **BUG-1061, 1062, 1063 (RCBEAM):** RCBEAM, Type 1, width 410, 2N16 bottom: the caution must not say "more than 300" (294 c/c). Width 150, cover 65: the "no room for the bottom bars" line. Type 7, depth 500, rebate 75: depth line names the rebate; **look at the preview**: stirrup starts 75 mm down with an empty band at the top. Place it and compare with an S-43 placed section: identical. U once removes it.
2. **BUG-1048:** three hatches, one with an unclearable property (as in the bug), CEHATCHCHANGE: two change, one line names the third. U once: all back.
3. **BUG-1045:** open a copy read-only, CE_INSPECT, pick two objects: report written beside the drawing. Then from a read-only folder: expect the raw "Access ... is denied" line (known limit).
4. **Wording bugs (BUG-1072, 1076, 1073, 1077, 1078, 1079):** CESETTINGS, System, "Saving and fault reports": read the ticks. CEHELP on BSET, CEMARKUPLOAD, CEMARKUPPREVIEW, CEMARKUPSETDRAWING, CEMARKUPRUN, CEMARKUPUNDO, STRUCEXPORTPDF. Load a damaged markup review: "CE could not read this saved markup review. Choose another saved copy."
5. **BUG-1082:** lock 25DIMS, run FFL: nothing drawn, layer still locked, the plain line. Same with 25TEXT and LM. REFEDIT a block, run RL: refused. U after each: nothing to undo from CE.
6. **BUG-1037:** RC column with N24 bars at 1:20: circles 24 mm, not 40. **BUG-1039:** SBEAM timber, quantity 12: accepted.
7. **BUG-755:** RCBEAM type list: Type 2 and 6 pictures inside their boxes. **BUG-752:** CESETTINGS with a long backup folder path: wraps, Save visible.
8. **BUG-840 (two AutoCADs):** open two AutoCADs; in B change a Settings value and Save; in A run a command that saves its last size; reopen CESETTINGS in B: B's value kept. No error line in A.
9. **BUG-841:** CESETTINGS, type "1,200" in a number box, Save: refused, box named, nothing saved.
10. **BUG-864:** drawing with 18HIDDEN set to Continuous and colour 3: CEMEMBER: layer unchanged.
11. **BUG-977:** UCS Z 45, SBEAM, pick two points: section lands at the picks; UCS icon unchanged after. World UCS: as before.
12. **BUG-975, BUG-978, BUG-973:** switch a support next to another: neighbour's label stays. Start a second AutoCAD: Structural loads (ribbon present). CESHEETSCLASSIC swap two sheet numbers: each row still names its own drawing.
13. **The ten additions:** as in their review batches B8 to B10 (sheet update beside a TITLE_DETAIL Xref; BEXTEND to a polyline arc; hatch audit with DIMSCALE and LTSCALE different; CSREOBAR two heights; save templates with a waiting suggestion; RIB refused; XCLMTXT row left out then C2; bracing panel with two brace types; CEMEMBER in a metre drawing; checklist N/A then U then REDO).

## 6. Risks and carry-over

1. **Type 7 preview** reads like a fault (empty band, no notch). Carpark candidate: draw the rebate notch in the preview.
2. **#1742 carry-over:** Cancel never read; raw "Another plot is already in progress."; the markup Help "layer" lines still use code words.
3. **#1749:** read-only folder gives a raw error (no Desktop fallback).
4. **#1566 side effect:** with two AutoCADs open, both job timers count the same keyboard and mouse time (`IdleDetector.cs`, `JobTimeTracker.cs`), both write the same user time log and crash-recovery file. Not a crash; carpark candidate.
5. **#1568 older weakness:** a rename failing half-way through a swap can leave one drawing under its temporary name with a raw Windows message. Rare (open drawings are filtered out first).
6. **#1736:** the lock check comes after three questions; notes tools warn and draw on a locked layer while level marks and rebar refuse: one rule for all annotation is Tim's call.
7. **#1732 follow-up:** the steel "or" split matches only a single digit before "No" (`ExcelMTextService.cs` about 6031).
8. **#1585:** a locked footing draft layer makes the put-back fail quietly (logged only); same as before the PR.
9. **Window pictures:** test runs rewrite about 75 PNGs under `docs/image/V3_WINDOWS` and add new `...saving-and-fault-reports.png` names; none committed.
10. **Official release build and three test lanes not run by me** (3.3, 6.5 of ANSWER FIRST).

## 7. Method, disk and slips

1. **Disk:** C: had 12.75 GB (as Windows counts it) at 15:11 and fell to 11.9 GB by 15:34 from other jobs (my own worktrees and builds used about 0.6 GB in all). I stopped starting builds at the 12 GB line (Windows count, the stricter reading) and waited about 25 minutes; it stayed at 11.9. I built only the train's net48 test project once, in a moment it was back to 12.0 GB after I removed my base worktree. Tests from existing builds ran throughout (they use almost no disk).
2. **My slip:** my first build (15:24) ran without `-p:SkipDevBundle=true` and the reference paths, because the argument list was not loaded in that shell; it built Debug with default references. Structural has no developer-bundle copy in Debug; I checked that no file in the installed `CE_STRUC_SUITE.bundle` changed (none newer than my start) and deleted that Debug output. Every later command carried the full flags. Cost: about three minutes.
3. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` did not exist; I never created or deleted it; everything ran in my own worktree with my own TEMP.
4. **References:** `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 first on PATH; restore with `EnableUnifiedHostAdapters=true`; standalone build with `=false`.
5. **Tim's four settings files: unchanged** from 15:13 to 15:57 (SHA-256 first 8, size): `TIM_CE_CADTOOLS\CD_Settings.json` `acd64e79` 15,270; `TIM_CE_CADTOOLS\CS_Settings.json` `622a246f` 351,713; `CE_STRUC_SUITE\CS_Settings.json` `2972ce70` 35,259; `CE_CVL_SUITE\settings.json` `efe307c4` 672. A robot AutoCAD (not mine) was running from 15:20 and 15:38.
6. **Installed Structural** still reads `1.0.123+4af3f37d` in all three lanes at 15:57.
7. **Cleanup:** both worktrees removed (`git worktree remove --force`, folders deleted, prune), scratch `C:\ce-fin\s44x` deleted, no subst used. The main checkout shows the same five untracked entries as S-43 reported.
8. **Not tested:** anything in AutoCAD; any window looked at in AutoCAD (I looked only at the test-drawn RCBEAM Type 7 and Settings pictures); Structural net8 tests; the Sbeam evidence class; Drainage tests (so #1766's Civil file was not run); Manager; Installer.Tests; plus the five items in ANSWER FIRST 6.5.

## Summary

GO at `007a211d` on `claude/rel-20261025s`. 32 PRs reviewed, all kept; three commits of mine (the #1460 JSON fix that would have broken routine settings saves in AutoCAD 2027, a misleading Cancel phrase in #1742's Help, a switch-defaults test). Five new switches, all ON, kept. Structural net10 5,923 passed, 0 failed; net48 53 failed, the 39 standing names plus 14 new stub-only tests. Solution, DesignCore, CommandTruth, ReleaseTests and the official 2007-file build not re-run (C: under 12 GB): the payload builder must run the release build. Not installed; nobody has opened it in AutoCAD.
