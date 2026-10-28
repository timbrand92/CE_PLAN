# BUG-090 fix report: About CE Suite window cuts off its lower rows (Thu 29 Oct 2026, about 10:10 Melbourne)

## ANSWER FIRST

**FOR TIM**

1. **The cause was clear, and the fix is small, so it is built.** Draft PR **#1836** on the newest line (Manager 1.1.85). Nothing installed, nothing merged.
2. **What went wrong:** the About CE Suite window is a fixed size and cannot be dragged bigger. Its rows need more room than the window has. So the bottom rows were cut off: the AutoCAD row showed only its top, and Runtime could not be read.
3. **What changes for a drafter:** type CE_VERSION. The window now grows to fit all its rows. You see Civil, Structural, Manager, AutoCAD and Runtime in full, the hover hint and the Close button. The width stays the same.
4. **The switch:** `aboutWindowFitsItsRows` in Manager's switch file. It ships ON. Put `"aboutWindowFitsItsRows": false` in that file to get the old fixed window back.
5. **My own mistakes:** two small ones, about 1 minute of machine time. My first test run caught my own test checking the wrong thing ("switch off" after the window had already been set up "on"). I made the "off" setting put back the old size properly. My first full Manager run then had 7 red tests. My test helper had written a temporary folder path with forward slashes, and those tests check for back slashes. I fixed the helper; all pass.
6. **One thing to know:** Structural has its own CE_VERSION command and its own About window with the same fixed size. Codex's evidence shows it saw the Manager window ("Loaded CE versions"), so that is the one fixed. If the Structural one ever opens instead, it would still be cut off. I did not change Structural.
7. **What proves it:** a Codex look at CE_VERSION (a re-run of D8-01, robot case R06's window). A window must be seen, so the robot alone cannot accept it.
8. **Status:** built and unit-tested only. Nobody has opened it in AutoCAD. BUG-090 stays OPEN.

---

## Detail

1. **Start point:** `claude/rel-20261026z` at `09126560f98acc4fd6ca4be298d087307a89a259` (Civil 3.0.85 / Manager 1.1.85, C-75), re-read with `git ls-remote origin` before branching.
2. **Evidence read:** BUG-090 in `BUG_CARPARK.md` (Codex V5-02 on 22 Oct; D8-01 on 26 Oct, Manager 1.1.78); Codex report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_D8_20261026_0623.md` item 6: visible words "Loaded CE versions" and "AutoCAD tools for Creative Engineering" (the Manager window's own words; the Structural window says "AutoCAD plugins for Creative Engineering"), three suite rows complete, "AutoCAD row only top fragments visible", Runtime and the hint unreadable, Close works.
3. **Cause (confident):** `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml` lines 6 to 8: `Width="470" Height="390"`, `ResizeMode="NoResize"`. The content Grid has an Auto header (padding 25, 28 pt heading, subtitle), a star middle row (title, separator, five version rows with a 16 px gap, hint line, margins 20) and an Auto footer (padding 15, Close button). Measured without AutoCAD (WPF, 96 dpi, the window's own theme): the content needs **415 px**, more than the whole 390 px window including its title bar (client area about 350 px). The header and footer keep their size, so the star row loses about 65 px from its bottom: the hint line, the Runtime row and most of the AutoCAD row, exactly what Codex saw.
4. **Second suspect (not acted on):** `Modules/Structural/UI/Dialogs/AboutDialog.xaml` lines 5 to 7 has the same fixed 470 x 390 and no resizing, and `Modules/Structural/Commands/AdminCommands.cs` line 22 also registers CE_VERSION. Which of the two commands AutoCAD runs when both are loaded is not established here. The D8-01 words show the Manager window opened.
5. **Fix:** `CeVersionWindow.FitToRows(Window, bool)` in `CeVersionWindow.xaml.cs`, called in the constructor straight after `InitializeComponent()` and before the versions are read: switch ON sets `SizeToContent = Height` (the width stays 470); OFF sets `Manual` (the XAML's own fixed size). The XAML is unchanged.
6. **Switch:** `CeManagerSwitches.AboutWindowFitsItsRowsKey` = `aboutWindowFitsItsRows` in `%APPDATA%\CE_SUITE\manager-switches.json` (Manager's existing switch file), read by `AboutWindowFitsItsRowsEnabled` / `AboutWindowFitsItsRowsFromText` in `Services/CeOneGlanceStatus.cs`. Default ON (R-27): no file, a broken file, a missing key or a value that is not plain true or false all read ON; only `false` turns it off. Documented like `linking.reopenedDrawingLoadsItsOwnRecord` of #1830 (doc ends "Default: on."). The other Manager switches read exactly as before (the new key is not added to their strict check, so a bad value for it cannot turn them off).
7. **REDO and protection:** window size only. CE_VERSION still changes nothing in the drawing and keeps `NoUndoMarker` (the BUG-1085 guard, which scans this code-behind for drawing writes, still passes).
8. **Tests:** new `Modules/Manager.Tests/UI/Bug090AboutWindowRowsTests.cs`, 15 tests, 15 passed:
   1. The fault reproduced without AutoCAD: the real window with the switch OFF is 390 px, cannot be resized, and its content measures 415 px.
   2. ON gives `SizeToContent.Height` with the width kept at 470; the window as built (no switch file) is ON; `FitToRows(null, ...)` is safe.
   3. The switch reader over nine texts (empty, other keys, true, false, a capitalised key, a non-boolean value, broken text, blank, null) and a real file (missing, typed false with another switch still read, key missing).
   4. The constructor applies the switch after `InitializeComponent` and before `LoadVersionInfo`.
9. **Build and test evidence:** private worktree `C:\ce-fx\b090`; scratch `C:\ce-fx\j859`; Release; `-p:SkipDevBundle=true -nr:false --disable-build-servers`, the C-62 AutoCAD refs, `build.lock`, dotnet at Below Normal. Results:
   1. **Manager net10 full suite: 1,056 total, 1,055 passed, 1 skipped, 0 failed** (second run; the first had 7 red from my helper's forward-slash TEMP path, see FOR TIM item 5; those 7 are CE Blocks settings tests and pass with a normal path).
   2. **Manager net48 build: 0 errors, 0 warnings.**
   3. Civil `CivilAutomationTests` (it builds this window for the automation names): 28 of 28 passed.
   4. Never deployed; AutoCAD not touched; Tim's settings files, switch file and installed bundles not touched.
10. **Commit and PR:** `3db30bfe` on `fb/bug090-about-window-rows`; draft PR **#1836** against `claude/rel-20261026z`. REGRESSION_LOG.md entry added at the top.
11. **Not tested or not known (RULES 5.9):**
    1. Not looked at in AutoCAD. A window needs a Codex look.
    2. 125, 150 and 200 percent display scaling not measured. The window now takes its rows' height, so it should fit; at 200 percent on a 1080p screen it needs about 480 of the 540 logical pixels available.
    3. The Structural About window (item 4) is unchanged.
    4. The bug's older wish to show the exact source commit is not part of this fix.
12. **For Codex after install:** CE_VERSION on a copy. Right result: Civil Suite, Structural Suite, Suite Manager, AutoCAD (for example 26.0) and Runtime (for example .NET 10.0.x) all readable in full, the line "Hover over a version to see which file was loaded." visible, footer with Close. Then U: CE_VERSION leaves no Undo step (BUG-1086 still not seen).
