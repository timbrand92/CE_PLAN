# Train C-40 finalizer report (Civil + Manager), Sat 17 Oct 2026

**Answer first: GO.** Train `claude/rel-20261017c`, final head `60075c76` (was 753bbbde; two finalizer commits on top, pushed as a normal fast-forward). Built and unit-tested only. Nobody has opened any of it in AutoCAD; nothing was installed, deployed or version-edited. Civil 3.0.50 / Manager 1.1.50 version fields are as the assembler left them (the payload builder bumps them, not this train).

## 1. What I changed (two commits)

1. **`195486b6` (test only, the net48 red):** #1310's check "every window in the title table is a real Civil window" failed on the AutoCAD 2022-2024 lane for `WaterTankDialog`, because the CDWT tank window is compiled for the AutoCAD 2027 lane only. The check now reads, from the Civil project file, which windows are left out of the lane it is running in, and demands those are really absent there. The AutoCAD 2027 lane still demands every window (no weakening), and a new test pins that only the older lanes leave the tank window out. Red on net48 at 753bbbde (1 failed: "WaterTankDialog is not a window in the Civil assembly"), green after on net48 and net10.
2. **`60075c76` (small product fix, same habit as #1311):** CDIMPORTLANDXML first asks "Use 'name.xml'? [Yes/No] <Yes>" when a LandXML file sits beside the last X-Civil source drawing. Esc there carried on as if Yes. With the Settings switch `xcivilImport.landXmlAskBeforeWrite` ON (default) the new review question still stopped it; with the switch OFF, Esc drew the whole network. Now Esc (or a failed prompt) ends the command with "CDIMPORTLANDXML cancelled. Nothing was drawn."; Enter still means Yes; No still opens the window. `LandXmlFoundFileEscTests` (5): red first (did not compile against 753bbbde), green after. One REGRESSION_LOG entry (11 lines added, 0 removed, stored LF, no new control characters).
3. **Branch note:** the branch name was already checked out in the assembler's worktree, so I worked on a local branch and pushed `HEAD:claude/rel-20261017c`. The assembler's worktree is now 2 commits behind origin; whoever uses it next should fast-forward it.

## 2. Tim's rules, re-verified

1. **Settings-first (R-00):** every new behaviour has a Settings key with a C# default; no engineering number is hard-coded by the train. The new keys live in the settings file but are **not on the Settings window** (LOW, standing gap; see 7.1).
2. **No hard blocks (R-27):** #1308's LandXML review is a question, not a block. "Import to drawing" in the window or Yes on the command line draws exactly as before; Enter or Esc means No (nothing drawn); `xcivilImport.landXmlAskBeforeWrite` OFF turns the question off. Traced in the code: the review sits after the in-memory read, flatten, snap and move and before the first drawing write. Right.
3. **No blue:** no new blue in any window. The PDF page stamp is black (draft) or dark grey (issued). The catchment overlay fill stays ACI 150 as before (a drawing overlay, not a window); its labels now use colour 7 instead of the fill's blue.
4. **Plain English with the AutoCAD command shown:** new messages are plain; window titles now add the command in brackets ("Pit Schedule (PITSCHEDULE)") under the existing switch `rightClick.showCommandNames`.
5. **Redo-safe (guardrail 8 item 17):** no added `StartTransaction`, `SetCurrentView`, `SetSystemVariable`, Idle, document-activation or selection-changed handler in any non-test file of the train or my commits. The two new window hooks (title, placement) run on a window's Loaded event, touch only the window and never the drawing. Redo guard classes green on net10 (full run) and net48 (focused run). `RedoSafeReviewedHooks.baseline.txt` untouched; no line needed.
6. **Locked layers:** nothing unlocks a layer. #1290's redraw call goes through the existing open-for-write-unless-locked path; no `IsLocked = false` anywhere in the diff.

## 3. The new defaults, judged

1. **Keep ON, the old behaviour is the bug:** `calculationExport.stampIssueStateOnEveryPage` and `excelNumbersAsNumbers` (#1281, Tim's recommended Q6/Q7, DRAFT); `pitScheduleRemarks.keepCustomNoteBesideStepIrons` (#1286, a drafter's own note was deleted); `pitScheduleExcel.numbersAsNumbers` (#1289); `pipe.calculatedLevelSetsDirection` (#1292, the flow line ignored the level the window already showed); surface drainage label colour 7, label offset 300 and fill behind the drawing (#1293, labels sat on the pit note and the fill washed out pits and pipes); `longSection.refreshDisplayAfterUpdate` (#1290, needed a REGEN) and `longSection.fitWrappedTitle` (#1291, a long title overlapped the scale note); `xcivilImport.landXmlAskBeforeWrite` (#1308, BUG-603 HIGH: reading the file drew it).
2. **Keep ON, Tim ruled:** `windowFeel.previewQuietMs` 300 (Tim 25 Sep, "as you type"); `rightClick.showCommandNames` (Tim 9 Oct, now also drives window titles and the ribbon brackets).
3. **No visible effect:** `jobChecklist.draftMinJobs` 3, `draftMinSharePercent` 50, empty `officeSteps` (#1309, nothing calls it yet).
4. **Stay OFF:** `windowPlacement.remember` (#1299; Tim ruled "where you last left it", but it should go ON only after a Codex two-monitor run), `councilRfi.enabled`, `tankCallout.addMakeAndSize`.
5. **`checks.consultantCheckReportBesideDwg` OFF changes today's behaviour: keep OFF, and yes, tell Tim in one line.** CDCHECKDWG no longer writes its report into the consultant's drawing folder (often a shared client folder); it goes to the CE logs "checkdwg" folder and the command line prints the full path. ON brings back the old place.

## 4. Post-review heads and #1311

1. **#1310 `3962334d`:** the Profiles window now says (CDPROFILE), Calculations says (CDCALC); only CE_CVL_SUITE windows are touched; errors are logged, never stop a window. Fine apart from the net48 test (fixed above). LOW: `CalculationsDialog` is a dead table entry.
2. **#1301 `978a501d`:** default 300 ms as Tim ruled; 100 to 2000 accepted, anything else falls back to 300; read live. Fine.
3. **#1299 `092d5e5a` (ships OFF):** multi-monitor off-screen risk is handled: screen pixels throughout, a spot per monitor layout, a window pulled fully onto the monitor it mostly sits on (or the nearest one), shrunk if bigger, 120 px minimum, Manual-placed and self-placing windows left alone, content-sized windows get position only. Mixed-DPI monitors not tried. OFF costs one switch read per window.
4. **#1308 `ad6e7f9e` with #1276 `8a54cef0`:** they work together. The review question comes before any drawing write; #1276's invert step runs only after pits and pipes are inserted, so a cancelled review writes no inverts; a cancelled review opens no window; a real read failure still shows the nothing-was-read window; the review page says "from the LandXML file".
5. **#1311 `2c35de86` (new):** right. Esc or a failed prompt at "Proceed with import? [Yes/No] <Yes>" cancels before anything is written; Enter keeps Yes. Other Yes/No prompts in the imports: the X-Civil "Replace or Abort" already treats Esc as Abort; #1308's review treats Esc as No; the AI-extraction consent treats Esc as No; the LandXML found-file question had the same habit and is fixed in `60075c76`. LOW, not fixed: the corpus export's "Existing pits to exclude" text prompt carries on after Esc (it writes evidence files, never the drawing).

## 5. #1253's test project change

Safe. `Installer.Tests/CE_CVL_SUITE_Installer.Tests.csproj` gains a `GitExecutable` property that defaults to plain `git` (identical to before) and is quoted in the one fixture command. Test project only; it never ships. No product csproj, `PackageContents.xml`, `.props`, `.targets`, solution file or version field changed anywhere in the train or my commits.

## 6. CE_SHARED

Four Shared files changed (ribbon label, ribbon builder, window placement and its store). The built CE_SHARED.dll is byte-identical in the Drainage, Manager and Shared outputs on every lane (net48 d7855aa7, net8 2fb32275, net10 ebbef017; the prefixes differ from the assembler's because the build paths differ). Manager rides in the same train, as it must. One Manager source change (#1255, the header wordmark now follows the theme colour).

## 7. Findings (none HIGH, none MEDIUM)

1. **LOW, standing R-00 gap:** the new switches are in the settings file only; none appears on the Settings window. A drafter can only change them by editing the file. Not new to this train; worth one Settings-page card.
2. **LOW, net48 stub limit:** 4 tests of #1288's new `PitSpineRowBackfillSurfaceDrainTests` fail on net48 with "invalid program" inside AutoCAD's own DisposableWrapper comparison (the reference assemblies have no method bodies). They pass on net10 with the real AutoCAD. Not a product fault.
3. **LOW:** corpus export "Existing pits" prompt ignores Esc (above). **LOW:** catchment fill still ACI 150. **LOW:** `CalculationsDialog` dead entry in the title table.
4. **Not run here:** the net8 test lane (no AutoCAD 2026 on this PC, 0 tests discovered; it builds with 0 errors). Installer.Tests and Structural tests (no file of theirs changed apart from #1253's property).

## 8. Builds and tests (shared build lock around every run; Below Normal; skip-bundle, no node reuse, no build servers)

1. **Whole solution, Release, net48 refs from the CERef 24.3.0 folder:** 0 errors (862 warnings on the incremental build; the assembler's cold build had 885). A first build without the explicit net48 ref path gave 15 errors in Structural.Tests net48 only and a net48 Drainage test build that discovered 0 tests; that is the known ref-path gap, cured by passing the CERef path.
2. **Civil net10 (whole suite, one worker):** 17,770 run, 17,750 pass, 19 skipped, 1 failed = Glen Eira, the known one. Assembler: 17,764 / 17,744 / 19 / 1. The 6 extra are my tests (5 + 1). The two SourceAtomicCoordinator IL reds did not appear.
3. **Manager 751/751. CommandTruth 64/64. TestHarness 101/101 (no flake this time). Spine 81/81. Diagnostics 19/19. AI.Core 42/42. ReleaseTests 16/16 on each of net10, net8 and net48.** All equal to the assembler.
4. **net48 focused (every changed test class of the train, my new class and the redo classes):** 525 run, 498 pass, 23 skipped, 4 failed (7.2). The assembler's focused run was 615 with a different filter, so the totals are not comparable; the #1310 red is gone.
5. **Tim's settings files:** CD_Settings.json 15,270 bytes, the Civil CS_Settings.json 351,713, the Structural CS_Settings.json 34,217, the Civil suite settings.json 672 and CD_RecentValues.json 5,027: size and hash identical at the start, before the long run and at the end. The live CE log folders kept the same file count and size; test logs went to a scratch folder (319 files). AutoCAD was not running; no Codex run started in the 3 minutes before any test.
6. **Disk:** 26 GB free throughout; ignored build output cleaned at the end.

## 9. What Tim will see (plain English)

1. **Ribbon buttons and main Civil window titles show the typed command in brackets**, for example "Pit Schedule (PITSCHEDULE)" (his ruling; the switch turns it off).
2. **Calculation PDFs carry the issue state on every page**, and Excel exports from the calculations and the Pit Schedule have real numbers he can add up ("Unknown" stays text).
3. **CDIMPORTLANDXML stops and shows what it read before drawing anything**; Enter or Esc leaves the drawing as it was. Esc at "Use 'name.xml'?" now cancels too. LandXML inverts now reach the pipes and pits.
4. **CDIMPORTXCIVIL: Esc at "Proceed with import?" cancels** instead of importing.
5. **CDCHECKDWG reports go to the CE logs folder**, not the consultant's folder (the command line names the file).
6. **Long sections redraw after an update without REGEN**; a long two-line title no longer hits the scale note.
7. **Catchment overlay** labels are readable (colour 7, 300 off the pit) and the fill sits behind pits and pipes.
8. **New Pipe's flow line follows the worked-out level**; custom notes beside "With Step Irons" survive; previews update about 0.3 s after typing stops.

## 10. What Codex should check in AutoCAD (copies only)

1. **CDIMPORTLANDXML Esc:** run CDIMPORTXCIVIL on a copy whose source drawing has a matching .xml beside it, then type `CDIMPORTLANDXML`, press `Esc` at "Use '...xml'?": command line says cancelled, `ZOOM` `E` shows nothing new. Run again, `Enter`, then `Enter` at "Import these into the drawing? <No>": nothing drawn. Run again, `Enter`, `Y`: pits and pipes drawn with inverts.
2. **CDIMPORTXCIVIL Esc:** at "Proceed with import?" press `Esc`: nothing drawn.
3. **Window titles:** open `PITSCHEDULE`, `CDCALC`, `CDPROFILE`, `CDWT` (2027): titles end in (PITSCHEDULE), (CDCALC), (CDPROFILE), (CDWT).
4. **CDCHECKDWG:** run it on a consultant copy; the report path on the command line is in the CE logs folder, and nothing new appears beside the checked drawing.

## 11. Not tested

No window, PDF, Excel file, drawing or ribbon was looked at; nothing was run in AutoCAD; mixed-DPI and two-monitor window placement not tried; the net8 test lane not run.

OPUS SIGN-OFF train claude/rel-20261017c GO (60075c762007b2818b31670390cc5b2b2c2f71a8)
