# B-043a report: New Pipe declutter v2, slice S1 (the one "Recent" line)

Written Fri 30 Oct 2026 about 02:15 Melbourne time, by the B-043a build job.

## FOR TIM

1. **Draft PR #1861** (branch `fb/declutter-s1-recent-line`, against `claude/rel-20261026z`). BUG-1238 is NOT marked fixed. Nobody has opened this in AutoCAD and there has been no Codex look.
2. **What a drafter will see differently:** on the New Pipe window and the Edit Pipe window, directly under the Size and Material boxes there is now ONE line starting "Recent:". It holds the recent sizes (for example 100 150 225), the recent materials (UPVC, UPVC SN8, RCP / RRJ) and, if B-006's switch is on, the recent levels. One click fills the box. Before, the recent sizes and materials were not on the page at all (they sat on a tab the one-page window threw away), and the recent levels were a separate row under the level boxes.
3. **Nothing moves a second way:** the level buttons from B-006 (PR #1839) land on the same line. When there is nothing recent, the line disappears and the window keeps its one fixed height.
4. **The switch:** `pipe.declutteredLayout`, ON. Set it to false and you get today's page back exactly (B-006's levels row under the level boxes, no recent sizes or materials). The same switch will guard slices S2 to S5.
5. **Mistakes of my own, first:** (a) this is a job that was stopped and restarted. The earlier attempt left five failing window tests in its logs; I did not trust them, re-ran, and all passed on the final code, but I never found which earlier edit had cured them. (b) I waited about 2 hours 55 minutes for a free build slot (another job's builds kept it busy) and my first wait script was killed at its 2 hour limit; no harm, but it cost the evening. (c) I could not open gh from Bash and had to find it on its own path; no effect on the code.
6. **What is NOT proven:** how it looks in real AutoCAD. The window is tested only as a built window in a test, not on screen. Whether the line wraps to two rows when a drafter has many recent sizes, materials and levels at 150% screen scaling is NOT proven (the fit test passes with the default recent lists; a long list could push the window past its fixed height, in which case CE falls back to the older window as today). The button words ("Recent:") are mine.
7. **What to look at in AutoCAD (Codex look):** open New Pipe and Edit Pipe at real size AND at a small laptop scale (150%); the Recent line sits under Size and Material, nothing scrolls, the PLAN PREVIEW is where it always was, Place is in the fixed corner.

## Which part of the drawing, window or CDDESIGN / CDCHECK / CDRULES answer changes

1. **Window only.** New Pipe and Edit Pipe. Nothing in the drawing, CDDESIGN, CDCHECK or CDRULES changes. No new write, command, regen, view or system variable. Locked layers, Xrefs and REFEDIT are not touched.
2. **Worked example:** you place a 100 UPVC pipe, then a 150 UPVC SN8, then open New Pipe for the third. Under the Size and Material row you read: `Recent: 100 150  UPVC UPVC SN8  18.190 18.240`. Press 150 and the Size box reads 150. Press UPVC SN8 and the Material box reads UPVC SN8. Same effect as the old tab buttons, now on the page.

## Robot case that proves it (needs writing by CE 02)

1. **Name:** `N51_recent_line`, with the switch-off control `N51_recent_line_off` (setting `pipe.declutteredLayout` false, set BEFORE launch because CE reads settings at AutoCAD start).
2. **Types:** CD, pick two points, Enter; in New Pipe type diameter 150 and material UPVC SN8, first invert 18.240, second 18.190, press Start Pipe, then Esc. Type CD again and pick two points 2 m south.
3. **Checks:** the window shows exactly one control group named "Recent:" below the Material box with an automation-named button "Use recent diameter 150 mm", one "Use recent material UPVC SN8" and one "Use recent invert 18.190 m AHD". Press the 150 button: the Size box reads 150. Press the material button: the Material box reads UPVC SN8.
4. **Switch-off control:** with the switch false, "Use recent diameter" and "Use recent material" buttons are ABSENT and the "Use recent invert" buttons sit under the level boxes (B-006's place), as today.
5. **Codex look needed** (RULES 5.7) for the picture of the window at real size and at 150%.

## Technical detail

1. **Cause (BUG-1238):** `Modules/Drainage/Dialogs/PipeOnePageLayout.cs`: the one-page layout lifts a named list of rows out of the three tabs (the `MoveRow` key list near line 71) and discards the tabs. The recent-sizes-and-materials row (`PipeEditWorkshopDialog.xaml` lines 100 to 130) was never on that list. Reading of code plus a built-window test; not seen live.
2. **Change:** new `MoveRecentLine` (about line 331 of `PipeOnePageLayout.cs`) lifts the three existing item lists (`RecentDiameters`, `RecentMaterials`, and `RecentInverts` when `RecentButtonsOn`) into one `DockPanel` with a "Recent:" caption, inserted right after the row holding the `Diameter` box. Same commands: `UseRecentDiameterCommand`, `UseRecentMaterialCommand`, `UseRecentInvertCommand`. Slim buttons (`SlimRecentButtons`, shared with B-006's `MoveRecentLevels`). The line collapses through a `MultiDataTrigger` when all lists are empty. `DeclutteredOn` reads `Pipe.DeclutteredLayout` (missing settings read ON, R-27).
3. **Switch:** `UserSettings.cs`: `PipeSettings.DeclutteredLayout`, JSON `declutteredLayout`, "Default: on." There is no Settings page row for B-006's switch either, so none was added.
4. **Tests:** `Bug1238RecentLineTests` (new): switch ON through `DeserializeSettings` and `DeserializeSettingsTolerant`; one line with sizes, materials and levels in order under the Size box and above the level boxes; no button off the right edge; preview still inside the window; buttons fill the boxes; levels-switch off keeps sizes and materials; empty lists leave no line; switch OFF = today's page; GUARD that every binding key on the old page plus the old More... window is on the new page plus More... (New Pipe and Edit Pipe). `C75NewSwitchDefaultsTests` pins the default. `Bug1226RecentButtonsTests` now runs with `DeclutteredLayout` false so it keeps pinning B-006's placement.
5. **Results (net10, below-normal priority, one build slot):** focused run 299 passed, 0 failed (count not 0); full Civil suite 20798 passed, 0 failed, 32 skipped (6 m 22 s); net48 compile of `CE_CVL_SUITE.csproj` 0 errors (242 warnings). The PDF page test passed in the full run.
6. **Files:** `Modules/Drainage/Dialogs/PipeOnePageLayout.cs`, `Modules/Drainage/Models/UserSettings.cs`, `Modules/Drainage.Tests/Dialogs/Bug1238RecentLineTests.cs`, `Bug1226RecentButtonsTests.cs`, `Services/C75NewSwitchDefaultsTests.cs`, `REGRESSION_LOG.md`. CE_SHARED, `CdDialog` and More... untouched. Branch contains B-006's two commits (PR #1839 merged in first), so merge order matters.
7. **Confirmed against the carpark:** file names in the 24 Oct entries checked on `origin/claude/rel-20261026z`: `PipeOnePageLayout.cs`, `PipeEditWorkshopDialog.xaml` exist and match. BUG-1238 and BUG-1226 entries read (BUG-1226 is a card-versus-product question for Tim; Tim's "yep bring back" is in B-006). The section 21 pilot-critical item does not apply to this slice.
8. **Undo:** revert commit 70dec2c2, or set `pipe.declutteredLayout` to false.
