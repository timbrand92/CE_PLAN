# TOOL NOTE: Triple stud marker with tag (TS1)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Places one triple stud marker** (the SUPPORT BLOCK NEW block, 135 x 90 unless Settings says another size) where you click, then lets you turn it.
2. **Asks for the tag** (TS1, TS2 ...) and places it beside the marker.
3. **Links the marker to a beam end** within 250 drawing units, when beam linking is on and a beam end is there.
4. **Takes the size from the member schedule** when the drawing holds one with a row marked TS1. It uses the first such row, with no floor.

## 2. What it changes in the drawing

1. **The marker block** on layer SUPPORT (colour 2, made if missing), at scale 1.
2. **The tag:** plain text, 200 high, turned 45 degrees, on layer SUPPORT TEXT (colour 2).
3. **A note on the marker saying which tag is its own.** No line on screen.
4. **When a beam end is near:** a link written into the beam's own record only. The marker's own list of beams is updated only if it already has one, and a newly placed marker never does (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`). One line says so. The beam is not moved.
5. **The block definition** is loaded from CE's files when the drawing has none.
6. **The current layer** is put back as it was.
7. **Not touched:** the member schedule record. The support file has no save call.

## 3. What it will not do

1. **Read-only drawing:** "[CE_STRUC] TS1: the drawing is read-only. Save a copy you can edit first."
2. **Layout tab:** "You are on a layout tab (paper space), so CE placed no support. Go to the Model tab, or double-click into a viewport, and try again."
3. **REFEDIT open:** "A block or Xref is open for in-place editing (REFEDIT), so CE placed no support. Close it (REFCLOSE) and try again."
4. **Drawing not in millimetres:** it stops and places nothing. The line starts "This drawing's units are ...". The stop is a Settings value (Day1Units, HoldInNonMillimetreDrawings), on by default; turning it OFF lifts the stop. A drawing with units not set goes ahead (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).
5. **Locked layer:** "Layer SUPPORT is locked, so CE drew no support. Unlock it and try again." It checks the marker layer and the tag layer, and never unlocks.
6. **No frozen or off layer check.**
7. **No size question.** With no schedule row it draws the Settings size (135 x 90) and says nothing about it.
8. **No floor.** A mark used on two floors gets the first row's size.
9. **Undo group refused:** "[CE_STRUC_SUITE] Support insertion stopped: AutoCAD could not start the required Undo group."
10. **Placing fails:** "TS1: CE could not place the support, so nothing was placed. The details are in the CE log."
11. **Rotation fails:** "[CE_STRUC_SUITE] Support rotation failed; the inserted support was rolled back."
12. **Block definition not found:** "[CE_STRUC_SUITE] Could not find SUPPORT BLOCK NEW definition."

## 4. What it asks you, and what Enter means

1. **When the schedule has a TS1 row** (a line, not a question): "[CE] TS1: size '<schedule size>' from the schedule, shown as '<the schedule size, shortened>'." The second value is the schedule size made shorter, not the size the block shows: if the block cannot show it, the block falls back to the command's default size and only the log says so (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).
2. **"Specify insertion point for TS1: "** Esc: nothing placed. Enter: the command ends with no line.
3. **AutoCAD's own ROTATE** then runs on the new marker (AutoCAD's wording, not CE's). Enter takes AutoCAD's own default, normally the last angle used; CE's code does not settle it (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`). Esc removes the marker (Settings value, on).
4. **"Pick desired support text location (auto left/right/top/bottom), or Enter for auto right: "** Enter prints "Label on the right: enter its text, then click where it goes." A click prints "Label at the <side>: enter its text, it goes at the spot you picked." Esc removes the marker. (If Settings "Auto detect support text side" is off, it asks "Text position [L/R] <R>: " instead.)
5. **"Enter a number to append to 'TS' (or press Enter to exit): "** Typing 1 makes the tag TS1. Enter with nothing remembered: no tag, no line, the marker stays. Esc removes the marker.
6. **"Enter text for 'TS' or <1>: "** is asked instead once a tag has been typed. Enter takes that remembered text again.
7. **On the Enter route only:** "Specify insertion point: " then "Top or Bottom [T/B] <T>: ". Enter takes T.
8. **Last line:** "[CE] Support linked to nearby beam." or "[CE] No beam found nearby, so the support is not linked. Place the beam first, or run BEAMLINKMIGRATE." or "[CE] Beam linking is switched off in Settings, so the support is not linked."

## 5. When it says Unknown or "needs checking"

1. **It never says Unknown.** With no schedule row it draws the Settings size without saying so.
2. **"No beam found nearby ..."** means no beam end within the link distance. The marker is placed, not linked.
3. **The schedule line** names the schedule's size. A timber pack such as "3 No 90 x 45 F17 KDHW" cannot be shown by the block, so 135 x 90 is drawn and the line still names the pack (see 7).

## 6. How to undo it

1. **U once** is intended. The command opens one undo group and closes it at the end. Not proven in AutoCAD.
2. **After Esc,** a layer or block definition the command created can stay behind (BUG-548), so a second U may be needed. Not proven.
3. **Not undone by U:** the tag text CE remembers for the next TS1.

## 7. Known faults

**Still open**
1. **BUG-501:** TS1 takes the first schedule row with that mark and never asks which floor.
2. **BUG-1139:** a support placed at the end of a copied beam makes the copy take over the original beam's links. The lines the bug names are unchanged in this build.
3. **BUG-548:** after Esc, no sentence says it was cancelled, and the layer or block definition it made can remain.
4. **BUG-448 (left over):** Enter at the number question with nothing remembered ends with no sentence.
5. **BUG-532:** the support layer names are written in the code.
6. **BUG-494:** U then REDO on TS1 was never walked, by the record. No cause found in the code.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-434 and BUG-439:** the current layer comes back after Esc and after a finished TS1. The "Duplicate definition of block _Dot" line is silenced when the block is loaded.
2. **BUG-437:** Enter at the text-location question means "auto right" instead of "Invalid point." (the record names C1 and TS1).
3. **BUG-438:** the number question no longer reads a default it was never given. The cause is the record's reading of AutoCAD's library, not proven.
4. **BUG-448:** a tag can no longer land beside the previous marker; Esc at the number question removes the marker quietly; the "Text placed" line is no longer printed early.
5. **BUG-471, 472, 473:** a non-millimetre drawing, a layout tab or REFEDIT, and a locked layer all stop TS1 with one plain line.
6. **BUG-974:** a row left out of the schedule at XCLMTXT is no longer saved. (TS1 still draws the Settings size.)

**Partly fixed**
1. **BUG-537 (sizes):** the size now has a Settings name (Supports TripleStudSize). It has no box on the Settings window. Layers, colours and offsets are still in the code.
2. **BUG-468:** a marker with no beam link can count as a post for the level below, behind a switch that ships off and has no Settings box.

**New in code, no bug covers it**
1. **A timber stud pack on TS1** (for example "3 No 90 x 45 F17 KDHW") is drawn as 135 x 90, while the line still names the pack. Log only. (Plan card TRUST-S3 covers it; no bug number.)
2. **A Settings size the block does not offer** leaves the block in whatever state it was. No line.
3. **"Support linked to nearby beam" can print when the link was not written.** A failed write is only logged.
4. **The remembered tag text carries from one drawing to the next** in the same AutoCAD session.
5. **Tag height 200, the 45 degree turn** are fixed in the code. (The 260 label search distance belongs to the switch commands such as SC1, not this one (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`).)
6. **A schedule saved with every row left out** does not replace the old schedule, so TS1 keeps using the old one.
7. **TS1 uses whatever support block is already in the drawing,** without checking it is the current one.
8. **Rotation wording:** with the rotation preview off in Settings, it still says "CE could not turn the support to the wall direction by itself. Type the rotation angle."
9. **The units stop line talks about footings** ("draws footings, labels and text", "LIST one footing").

## 8. On AutoCAD 2022 to 2024

1. **Same.** No #if in the support, label or link files. The 2022 to 2024 build (net48) compiles the same source. Whether it works there: not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. "SBC" is `Commands\SupportBlockCommands.cs`.

1. **1.1:** SBC:68, 106-121, 125, 284-295, 1347-1358; `Models\UserSettings.cs:1005-1006`. **1.2:** SBC:367-377. **1.3:** `Services\BeamLinkService.cs:328-350, 419-421`; `UserSettings.cs:587`. **1.4:** SBC:247-257; `Services\MemberScheduleService.cs:31-44`.
2. **2.1:** SBC:68, 282, 311-317. **2.2:** `Services\CeTextService.cs:716-721`, `903-1007` (rotation 961-965). **2.3:** `Services\BeamLinkService.SupportLabel.cs:76-104`; SBC:373-376. **2.4:** BeamLinkService.cs:419-421; `Services\BeamLinkService.Persistence.cs:52-65, 120-141`; SBC:410-411. **2.5:** SBC:1347-1358. **2.6:** SBC:233, 415; `Services\SettingRestore.cs:11-69`. **2.7:** `MemberScheduleService.cs:73-111`; grep for save calls in SBC, `Commands\SupportBlockDefinitionUpgradeService.cs`, `Services\SupportBlockJig.cs`, `Services\CommandExecutionService.cs` and CeTextService.cs found none.
3. **3.1:** `Services\DrawingSafetyService.cs:18-41` (line 38). **3.2, 3.3:** SBC:215; DrawingSafetyService.cs:62-100; `Core\Symbols\ModelSpaceWriteGuard.cs:13-26`. **3.4:** SBC:216; `Services\FoundationService.Identity.cs:119-128`; `Core\Day1UnitsGuard.cs:11-17`; `Structural.DesignCore\DrawingUnitRule.cs:288-299, 330-336`. **3.5:** SBC:225-232; `Services\LayerService.cs:219-232, 266-267`; SBC:73-75. **3.6:** no frozen or off check in SBC. **3.7:** SBC:251-261, 322-325. **3.8:** MemberScheduleService.cs:16-22, 31-44. **3.9:** SBC:234-240. **3.10, 3.11, 3.12:** SBC:334-339, 360-361, 1381.
4. **4.1:** SBC:252-257. **4.2:** SBC:263-267. **4.3:** SBC:344-363, 766-768, 800-812; `UserSettings.cs:510-511`; the ROTATE prompt text is AutoCAD's. **4.4:** SBC:915-958, 961-990, 1098-1114; `UserSettings.cs:994`; `UI\Dialogs\CeSettingsDialog.xaml.cs:136, 356`; CeTextService.cs:464-499. **4.5, 4.6:** CeTextService.cs:1988-2018, 2031-2032 (prompts at 2002 and 2009); `Services\CeQuestion.cs:30-37`. **4.7:** CeTextService.cs:935-959. **4.8:** SBC:421-430.
5. **5.1:** SBC:251-261. **5.2:** SBC:427-429. **5.3:** SBC:322-325, 1470-1480; plan `areas\trust-plan-structural.md` section 4 line 2.
6. **6.1:** SBC:234-240, 413-418. **6.2:** SBC:282-284, 379-405, 1193-1213, 1271-1287; SupportBlockDefinitionUpgradeService.cs:379-424. **6.3:** CeTextService.cs:23, 5523-5542.
7. **Open 1:** SBC:247-257; MemberScheduleService.cs:16-22, 31-44; `Services\XclmTxtService.cs:303-320`. **Open 2:** BeamLinkService.cs:74-83; `Services\BeamLinkService.CopyRelink.cs:20-60` (only the CE unit copy is relinked, `Services\UnitCopyService.cs:214`). **Open 3:** SBC:185-190, 264-265, 282-284, 1271-1287, 1347-1358. **Open 4:** CeTextService.cs:912-916, 2031-2032. **Open 5:** SBC:66-70. **Open 6:** the record BUG-494.
8. **Fixed 1:** SBC:233, 415, 1357; `Services\QuietBlockRead.cs:13-21`. **Fixed 2:** SBC:944-949, 961-990. **Fixed 3:** CeTextService.cs:2015-2026; CeQuestion.cs:30-37. **Fixed 4:** SBC:1086-1095; CeTextService.cs:464-499, 530-536; SBC:947. **Fixed 5:** SBC:215, 216, 225-232. **Fixed 6:** XclmTxtService.cs:303-320.
9. **Partly 1:** `UserSettings.cs:992-1014`; SBC:106-121; CeSettingsDialog.xaml.cs:136, 356 (the only Supports box); SBC:66-70, 1602-1655. **Partly 2:** `Services\FoundationService.LoadPath.cs:261-264`; `UserSettings.cs:1638`; no Settings window file mentions it.
10. **New 1:** SBC:252-257, 322-325, 1470-1480. **New 2:** SBC:322-330, 1487-1491. **New 3:** BeamLinkService.cs:50-90, 130-148, 419-421; Persistence.cs:52-65. **New 4:** CeTextService.cs:23, 1988-2016, 5523-5542 (a static list, not kept per drawing). **New 5:** CeTextService.cs:716-721, 961-965; SBC:562, 1801. **New 6:** XclmTxtService.cs:331-332. **New 7:** SBC:1327-1328. **New 8:** SBC:770-771, 842-843. **New 9:** DrawingUnitRule.cs:330-336.
11. **8.1:** no `#if` in SBC, SupportBlockJig.cs, SupportBlockDefinitionUpgradeService.cs, CeTextService.cs or `Services\BeamLinkService*.cs` as searched; `CE_STRUC_SUITE.csproj:27, 56-58`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 02:58. Nothing was run in AutoCAD.
