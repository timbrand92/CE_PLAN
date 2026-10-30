# BUGFIX p8 report, Fri 30 Oct 2026 (group S1, BUG-467 rotated UCS)

## ANSWER FIRST

1. **PR number: #1883 (draft)**, base claude/rel-20261102a, branch fb/bug467-rotated-ucs. Title has no B number: the build register has no entry for BUG-467, so CE 01 renames it.
2. **Half done, on purpose.** BT1, A and B (bracing) and the R1 Point option are fixed behind a switch. FPFC and the FSF two-point line are NOT fixed: they live in FoundationService.cs, which job p3b owns, and I was told not to edit it.
3. **Mistakes of my own:** I first ran a bash command for a PowerShell script (no pwsh in bash) and had to redo it; the first R1 edit added a byte-order mark to RafterJoistCommands.cs, which I removed before committing. No wasted test runs.
4. **NOT proven:** nobody has driven this in AutoCAD. The full Structural suite was not run (your isolation rule says not to). Only the 8 new tests plus a net48 compile.
5. **Robot case:** `S32_bt1_rotated_ucs` (below).

## FOR TIM

1. **What was wrong:** in a rotated UCS, BT1 (and the same code in A and B) used your two clicks as if the UCS were World. The bracing landed at the wrong place and angle, and the check against xref walls to choose the flip looked in the wrong spot. R1 with the Point option did the same with the point you picked.
2. **What you will see now (if it works in AutoCAD):** type UCS, Z, 30. Run BT1 and click two corners of a wall. The bracing sits between your two clicks at the angle of the line you clicked, and the rubber band follows the cursor. Pressing Enter at the second point gives 2700 mm along the UCS X direction. In a World UCS nothing changes.
3. **Switch:** Settings, Bracing tab, "Follow a rotated UCS (bracing A, B, BT1 and rafter/joist Point pick)". On by default. Off gives exactly the old behaviour.
4. **Still wrong, not touched:** FPFC (centre point and the bored pier loop) and the FSF two-point line in a rotated UCS. They need the footing job's file. I did not look at whether C1's column rotation swings about the wrong point (the carpark says "not proven"); it is not part of this PR.
5. **What to do:** nothing yet. BUG-467 must stay open (not FIXED): half of it is unbuilt and none of it is seen in AutoCAD.

---

## TECHNICAL DETAIL

1. **Confirmed on C-78 (91963bd0) that the fault exists:** BracingCommands.cs took `p1.Value` and the jig's `CurrentPoint` (UCS) straight into `InsertBracingBlock`, `DetermineAutoFlip` and `SafeAngleDegrees` (all World); `BracingPointJig.WorldDraw` drew UCS points as World; RafterJoistCommands.cs `TryGetPick` (Point option) stored `pointRes.Value` unconverted and gave a World base point to a UCS prompt. The hunt's line numbers had moved but the code was the same. Same pattern in A and B, not only BT1, so all three are fixed together.
2. **Change:** `BracingService.PickedPointsToWorld(Editor)` returns `CurrentUserCoordinateSystem` when `Bracing.PickedPointsFollowUcs` is on, else identity (`ChoosePickMatrix` is the testable core). Bracing commands convert pt1; `TryGetSecondPointWithPreview(ed, ucsBase, toWorld, out worldPt)` keeps the jig in UCS and returns World; the jig's Enter default (+2700 on X) is in UCS then converted; `WorldDraw` converts both ends. R1: base point `TransformBy(toWorld.Inverse())`, result `TransformBy(toWorld)`; Object picks untouched (already World). Settings: `BracingSettings.PickedPointsFollowUcs` (UserSettings.cs), Settings dialog checkbox on the Bracing tab (xaml, code-behind read and write).
3. **Rotation written to the block** is now the World angle of the clicked line (block inserted at rotation 0, dynamic rotation property). The on-screen "Preview length / rotation" message therefore shows the World angle, not the UCS angle. Not changed.
4. **Files:** Commands/BracingCommands.cs, Commands/RafterJoistCommands.cs, Models/UserSettings.cs, Services/BracingService.cs, UI/Dialogs/CeSettingsDialog.xaml and .xaml.cs, REGRESSION_LOG.md, new Modules/Structural.Tests/Commands/BracingRotatedUcsTests.cs. CE_SHARED unchanged. FoundationService.cs and the other jobs' files untouched.
5. **Structural has one start-up read** (`JsonConvert.DeserializeObject<UserSettings>` in `SettingsService.LoadSettings`, current file and legacy file), not Civil's two; the tests read the default through a new object, `{}` and an old file with a Bracing group lacking the key; typed false stays false.
6. **Tests:** focused net10 `BracingRotatedUcsTests`: **Passed 8, Failed 0, Total 8** (count not 0; AutoCAD 2027 on PATH). Cases: default on x3, typed off, UCS Z 30 sends 1000 mm along X to (866.03, 500) at 30 degrees and 1000 mm long, switch off leaves (1000, 0), World UCS unchanged, R1 base-point round trip. Structural net48 compile: **Build succeeded, 0 errors**. Full Structural suite: not run (job rule). Manager tests: not run.
7. **Isolation:** CE_STRUC_SUITE_APPDATA_ROOT=C:\ce-scratch\p8\struc, CE_LOG_DIR_OVERRIDE=C:\ce-scratch\p8\logs, TEMP=C:\ce-scratch\p8\tmp echoed first in the log. The new tests touch no settings service.
8. **Settings listing before and after (names, sizes, last-write), identical:**
   1. `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` 35613 bytes, 2026-10-30 19:54:14
   2. `%APPDATA%\CE_CVL_SUITE\settings.json` 672 bytes, 2026-09-16 12:13:17
   3. `%APPDATA%\CE_SUITE`: folder absent
   4. `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` 15270 bytes, 2026-10-04 08:22:30 (and CS_Settings.json 351713 bytes, 2026-03-31 13:18:00)
   The before listing was typed in the first command (the saved copy of it failed to write; the figures above are the same as read at the start). No real settings file changed.
9. **Worktree** C:\ce-fx\p8 cleaned with `git clean -fdXq`; branch and worktree left in place.

## ROBOT CASE (for CE 02)

Name: **`S32_bt1_rotated_ucs`** (twin with the switch off: `S32_bt1_rotated_ucs_off`).

1. Types: new drawing, `UCS` then `Z` then `30`; `BT1`; first point `0,0` (UCS coordinates); second point `3000,0`; Enter at the truss number (1).
2. Reads: the new bracing block reference. Expect insertion point World (0, 0) and the block's dynamic length 3000 with rotation 30 degrees (0.5236 rad); the far end at World (2598.08, 1500). With the switch off (`Bracing.PickedPointsFollowUcs` false, set before launch, per the settings-guard note) the rotation reads 0 and the far end (3000, 0): that is the old behaviour and the failing twin.
3. Second check, R1 Point option: in the same UCS, R1, Point at both pick prompts, read that the stored picks equal the World points of the typed UCS points (needs a case author who knows R1's output).
4. FPFC and FSF are not covered by this PR.
