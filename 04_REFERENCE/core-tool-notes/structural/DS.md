# TOOL NOTE: Double stud marker (DS)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Places one double stud marker** (the SUPPORT BLOCK NEW block, 90 x 90 unless Settings says another size) where you click, then lets you turn it.
2. **Asks for no label.** DS has no text step. DS1 is the one with a tag.
3. **Links the marker to a beam end** within 250 drawing units, when beam linking is on and a beam end is there.
4. **Takes the size from the member schedule** when the drawing holds one with a row marked DS. It uses the first such row, with no floor.

## 2. What it changes in the drawing

1. **The marker block** on layer SUPPORT DS (colour 150, made if missing), at scale 1. DS1 and TS1 use layer SUPPORT instead.
2. **When a beam end is near:** a link written into the beam's own record only. The marker's own list of beams is updated only if it already has one, and a newly placed marker never does (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`). One line says so. The beam is not moved.
3. **The block definition** is loaded from CE's files when the drawing has none.
4. **The current layer** is put back as it was.
5. **Not touched:** the member schedule record. The support file has no save call.

## 3. What it will not do

1. **Read-only drawing:** "[CE_STRUC] DS: the drawing is read-only. Save a copy you can edit first."
2. **Layout tab:** "You are on a layout tab (paper space), so CE placed no support. Go to the Model tab, or double-click into a viewport, and try again."
3. **REFEDIT open:** "A block or Xref is open for in-place editing (REFEDIT), so CE placed no support. Close it (REFCLOSE) and try again."
4. **Drawing not in millimetres:** it stops and places nothing. The line starts "This drawing's units are ...". The stop is a Settings value (Day1Units, HoldInNonMillimetreDrawings), on by default; turning it OFF lifts the stop. A drawing with units not set goes ahead (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).
5. **Locked layer:** "Layer SUPPORT DS is locked, so CE drew no support. Unlock it and try again." It checks that one layer and never unlocks.
6. **No frozen or off layer check.**
7. **No size question.** With no schedule row it draws the Settings size (90 x 90) and says nothing about it.
8. **No floor.** A mark used on two floors gets the first row's size.
9. **Undo group refused:** "[CE_STRUC_SUITE] Support insertion stopped: AutoCAD could not start the required Undo group."
10. **Placing fails:** "DS: CE could not place the support, so nothing was placed. The details are in the CE log."
11. **Rotation fails:** "[CE_STRUC_SUITE] Support rotation failed; the inserted support was rolled back."
12. **Block definition not found:** "[CE_STRUC_SUITE] Could not find SUPPORT BLOCK NEW definition."

## 4. What it asks you, and what Enter means

1. **When the schedule has a DS row** (a line, not a question): "[CE] DS: size '<schedule size>' from the schedule, shown as '<the schedule size, shortened>'." The second value is the schedule size made shorter, not the size the block shows: if the block cannot show it, the block falls back to the command's default size and only the log says so (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).
2. **"Specify insertion point for DS: "** Esc: nothing placed. Enter: the command ends with no line.
3. **AutoCAD's own ROTATE** then runs on the new marker (AutoCAD's wording, not CE's). Enter takes AutoCAD's own default, normally the last angle used; CE's code does not settle it (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`). Esc removes the marker (Settings value, on).
4. **Last line:** "[CE] Support linked to nearby beam." or "[CE] No beam found nearby, so the support is not linked. Place the beam first, or run BEAMLINKMIGRATE." or "[CE] Beam linking is switched off in Settings, so the support is not linked."

## 5. When it says Unknown or "needs checking"

1. **It never says Unknown.** With no schedule row it draws the Settings size without saying so.
2. **"No beam found nearby ..."** means no beam end within the link distance. The marker is placed, not linked.
3. **The schedule line** names the schedule's size. A timber pack such as "2 No 90 x 45 F17 KDHW" cannot be shown by the block, so 90 x 90 is drawn and the line still names the pack (see 7).

## 6. How to undo it

1. **U once** is intended. The command opens one undo group and closes it at the end. Not proven in AutoCAD.
2. **After Esc,** a layer or block definition the command created can stay behind (BUG-548), so a second U may be needed. Not proven.

## 7. Known faults

**Still open**
1. **BUG-501:** DS takes the first schedule row with that mark and never asks which floor.
2. **BUG-1139:** a support placed at the end of a copied beam makes the copy take over the original beam's links. The lines the bug names are unchanged in this build.
3. **BUG-548:** after Esc, no sentence says it was cancelled, and the layer or block definition it made can remain.
4. **BUG-532:** the support layer names are written in the code. DS goes on SUPPORT DS, DS1 and TS1 on SUPPORT.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-439 (the DS part):** the current layer comes back after a finished DS and after Esc. The "Duplicate definition of block _Dot" line is silenced when the block is loaded (BUG-434).
2. **BUG-471, 472, 473:** a non-millimetre drawing, a layout tab or REFEDIT, and a locked layer all stop DS with one plain line.
3. **BUG-974:** a row left out of the schedule at XCLMTXT is no longer saved. (DS still draws the Settings size.)

**Partly fixed**
1. **BUG-537 (sizes):** the size now has a Settings name (Supports DoubleStudSize). It has no box on the Settings window. Layer, colour and offsets are still in the code.
2. **BUG-468:** a marker with no beam link can count as a post for the level below, behind a switch that ships off and has no Settings box.

**New in code, no bug covers it**
1. **A schedule size the block cannot show** (a timber pack, or a size the block lacks) is drawn as the Settings size, while the line still names the schedule size. Log only. (Plan card TRUST-S3 covers it; no bug number.)
2. **A Settings size the block does not offer** leaves the block in whatever state it was. No line.
3. **"Support linked to nearby beam" can print when the link was not written.** A failed write is only logged.
4. **A schedule saved with every row left out** does not replace the old schedule, so DS keeps using the old one.
5. **DS uses whatever support block is already in the drawing,** without checking it is the current one.
6. **The units stop line talks about footings** ("draws footings, labels and text", "LIST one footing").

## 8. On AutoCAD 2022 to 2024

1. **Same.** No #if in the support or link files. The 2022 to 2024 build (net48) compiles the same source. Whether it works there: not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. "SBC" is `Commands\SupportBlockCommands.cs`.

1. **1.1:** SBC:66, 106-121, 123, 284-295, 1347-1358; `Models\UserSettings.cs:1002-1003`. **1.2:** SBC:365-367 (DS has no text commands, 66). **1.3:** `Services\BeamLinkService.cs:328-350, 419-421`; `UserSettings.cs:587`. **1.4:** SBC:247-257; `Services\MemberScheduleService.cs:31-44`.
2. **2.1:** SBC:66-67, 282, 311-317. **2.2:** BeamLinkService.cs:419-421; `Services\BeamLinkService.Persistence.cs:52-65, 120-141`; SBC:410-411. **2.3:** SBC:1347-1358. **2.4:** SBC:233, 415; `Services\SettingRestore.cs:11-69`. **2.5:** `MemberScheduleService.cs:73-111`; grep for save calls in SBC, `Commands\SupportBlockDefinitionUpgradeService.cs` and `Services\SupportBlockJig.cs` found none.
3. **3.1:** `Services\DrawingSafetyService.cs:18-41` (line 38). **3.2, 3.3:** SBC:215; DrawingSafetyService.cs:62-100; `Core\Symbols\ModelSpaceWriteGuard.cs:13-26`. **3.4:** SBC:216; `Services\FoundationService.Identity.cs:119-128`; `Core\Day1UnitsGuard.cs:11-17`; `Structural.DesignCore\DrawingUnitRule.cs:288-299, 330-336`. **3.5:** SBC:225-232 (no text layer is added for DS, line 225-227); `Services\LayerService.cs:219-232, 266-267`. **3.6:** no frozen or off check in SBC. **3.7:** SBC:251-261, 322-325. **3.8:** MemberScheduleService.cs:16-22, 31-44. **3.9:** SBC:234-240. **3.10, 3.11, 3.12:** SBC:334-339, 360-361, 1381.
4. **4.1:** SBC:252-257. **4.2:** SBC:263-267. **4.3:** SBC:344-363, 800-812; `UserSettings.cs:510-511`; the ROTATE prompt text is AutoCAD's. **4.4:** SBC:421-430.
5. **5.1:** SBC:251-261. **5.2:** SBC:427-429. **5.3:** SBC:322-325, 1470-1480; plan `areas\trust-plan-structural.md` section 4 line 2.
6. **6.1:** SBC:234-240, 413-418. **6.2:** SBC:282-284, 1193-1213, 1271-1287; SupportBlockDefinitionUpgradeService.cs:379-424.
7. **Open 1:** SBC:247-257; MemberScheduleService.cs:16-22, 31-44; `Services\XclmTxtService.cs:303-320`. **Open 2:** BeamLinkService.cs:74-83; `Services\BeamLinkService.CopyRelink.cs:20-60` (only the CE unit copy is relinked, `Services\UnitCopyService.cs:214`). **Open 3:** SBC:185-190, 264-265, 282-284, 1271-1287. **Open 4:** SBC:66-70, 75.
8. **Fixed 1:** SBC:233, 415, 1357; `Services\QuietBlockRead.cs:13-21`. **Fixed 2:** SBC:215, 216, 225-232. **Fixed 3:** XclmTxtService.cs:303-320.
9. **Partly 1:** `UserSettings.cs:992-1014`; SBC:106-121; `UI\Dialogs\CeSettingsDialog.xaml.cs:136, 356` (the only Supports box); SBC:66-70. **Partly 2:** `Services\FoundationService.LoadPath.cs:261-264`; `UserSettings.cs:1638`; no Settings window file mentions it.
10. **New 1:** SBC:252-257, 322-325, 1470-1480. **New 2:** SBC:322-330, 1487-1491. **New 3:** BeamLinkService.cs:50-90, 130-148, 419-421; Persistence.cs:52-65. **New 4:** XclmTxtService.cs:331-332. **New 5:** SBC:1327-1328. **New 6:** DrawingUnitRule.cs:330-336.
11. **8.1:** no `#if` in SBC, SupportBlockJig.cs, SupportBlockDefinitionUpgradeService.cs or `Services\BeamLinkService*.cs` as searched; `CE_STRUC_SUITE.csproj:27, 56-58`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 02:58. Nothing was run in AutoCAD.
