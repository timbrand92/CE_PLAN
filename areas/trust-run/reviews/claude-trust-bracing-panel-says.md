# Review: PR 2080 `claude/trust-bracing-panel-says` (BUG-1369 and BUG-1370, the bracing panel says what the count left out and counted)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:32 PC clock. **Head reviewed:** `159f554f` (one commit on `claude/trust04-base-struc-1.0.126` = `8de95c34`, the installed Structural 1.0.126, confirmed). Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **No bracing total changes.** The bracing panel (and CSBRACINGPANEL on the command line) now adds a red note when braces drawn with an older block name are left out of the total and the schedule, and when braces on a frozen or switched-off layer are counted in it. Nothing is said when there is nothing to say.
2. **The two real questions stay yours:** should older-named braces count, and should braces on hidden layers count. Both are listed; neither is decided.
3. **Only half of each bug is done:** the bracing schedule (STRSCHEDCREATE and STRSCHEDREFRESH) still makes a table with the older braces missing and says nothing, so the bugs stay open, as the pull request says.

**Verdict: GO** for the robot on copies, for the panel half. Two items for the controller before 2047 and this one are tested together (below).

---

# Findings (file and line at `159f554f` unless stated)

1. **No figure changed, by reading.** `Services/ProjectDataService.cs:286-296`: a BRACING block is still added to the list exactly as before (the hidden-layer test only counts it afterwards); an older-named block is still not added (it only counts). The panel's totals come from `BracingPanelService.BuildSnapshot` (installed, unchanged), which never reads the notes. The schedule reads the same list, unchanged.
2. **Older names match ABS's reader.** `Services/BracingScanNotes.cs:31-38` uses the same six spellings and the same "starts with" test as `BracingService.cs:2089-2103` (installed), so the count is the braces ABS itself would treat as older A or B braces.
3. **Reads only.** The layer test opens the layer for read inside the existing scan; no save, no Undo step. `ScanFromDrawing` replaces CE's in-memory Structural data, which the live panel already does every 5 seconds and after each command.
4. **Small: the command's own extra scan uses the plain transaction.** `Commands/BracingPanelCommands.cs:68` calls `ScanFromDrawing(db)` (`lightRead: false`). BUG-256 moved the panel's own scans to the open-close read because the plain one threw REDO away after U. The window has just scanned on reopen (`RefreshFromDrawing`), and on first open it cannot (the command is running, `IsQuiescent` false), so a scan here is needed, but `lightRead: true` would match BUG-256. Small.
5. **Small wording.** "N braces on frozen or switched-off layers are counted in the bracing total." (`BracingScanNotes.cs:48-54`): they are also listed in the bracing schedule (same list), which is what BUG-1370's title says. Add "and listed in the schedule".
6. **For the controller: 2047 and this PR meet in two places.**
   1. With 2047 (BUG-499) a roof truss placed with BT1 is a BRACING block left out of the wall totals. This PR counts every BRACING block on a hidden layer as "counted in the bracing total", trusses included. Once both land, a BT truss on a frozen layer would be reported as counted when it is not. The hidden count must skip trusses, or say what it covers.
   2. 2047 still owes an on-screen line for the trusses it leaves out ("carried in the totals, shown in no window yet"). This PR adds the panel's note row. One note row with up to three lines, from one place, avoids two mechanisms.
7. **For Codex's look.** `UI/Dialogs/BracingPanelWindow.xaml:7` adds `SizeToContent="Height"`, so the panel's height now follows its content on every open (it grows by the note's lines); the note colour is a fixed "Firebrick" in a window that has light and dark themes (`ThemeManager.ApplySwissTheme`). Check both themes and that the panel stays where it is placed when it grows.
8. **Tests.** `Bug1369Bug1370BracingPanelSaysTests` (read by its description and the PR): the name rule and the lines are real calls; "the scan fills the list from one place", "a hidden brace is still added", "totals never read the notes" and the wiring are text searches. Nothing opens a drawing or a layer. Acceptable with the robot case already in `PENDING_TESTS.md` (Structural section, item 3), which should add: STRSCHEDCREATE on the same copy still lists no older braces and says nothing (the known open half), and the panel in dark theme.

# What I did not check

1. No build or test run; the lane's 38 of 38 not re-run.
2. The panel's look with two lines, and placement after growth (robot and Codex).
3. Blocks frozen only in a layout viewport (not "frozen" to this test, by design; not discussed in the PR).
