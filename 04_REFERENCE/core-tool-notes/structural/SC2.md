# TOOL NOTE: Change column type (SC2)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Changes a support block you pick into the column type you choose (C2).** The same block is changed in place; no new block is drawn.
2. **Keeps the support where it was** by holding its centre still, then lets you turn it.
3. **Carries the labels near it across** (within 260 drawing units, and only those nearer this support than any other support).

## 2. What it changes in the drawing

1. **The picked block:** its layer becomes SUPPORT COLUMN (colour 3, made if missing), its size is set to the size you choose in the window, and its position shifts so its centre stays put.
2. **The labels near it** are erased and drawn again as new text with the same wording, layer and colour.
3. **The turn:** the block and its carried labels turn if you give an angle.
4. **A new label** only when no label was near enough to carry across (see 4).
5. **The current layer** is put back as it was.
6. **Not touched:** the member schedule (the switch commands never read it). The support file has no save call.

## 3. What it will not do

1. **Read-only drawing:** "[CE_STRUC] SC2: the drawing is read-only. Save a copy you can edit first."
2. **Not a support block:** "Object must be a support block." (picking something that is not a block), or "That is not a support block, so nothing changed. Type the command again and pick a support block." (a block that is not a support). The second one ends the command.
3. **Locked layer on the block:** "SC2 could not switch this support block because its layer <layer> is locked. Nothing was changed. Unlock the layer, then run SC2 again." It never unlocks.
4. **Any other failure of the change:** "SC2 could not switch this support block. Nothing was changed."
5. **No layout tab, REFEDIT or units check.** Unlike the insert tools, this command does not look for them (see 7).
6. **Does not change label wording.** A label "DS3" stays "DS3" on the new type.
7. **Does not read the schedule or ask for a floor.**
8. **Does not check the block is the current approved one.** C2 asks about an outdated block; SC2 does not.

## 4. What it asks you, and what Enter means

1. **"Select support block: "** Esc: cancelled, nothing changed. Enter: the command ends with no line.
2. **The "Select Column Type" window.** "Choose column type / Press 1-9, then Enter to continue." The block's current size is highlighted. Enter takes the highlighted size. Cancel or the window closed: nothing changed. If the window cannot open, a command-line question appears: "C2 column type [SHS2x89/SHS100/...] <...>: ".
3. **"Specify rotation (drag to preview): "** Enter keeps the angle. A drag or typed angle turns the block and its carried labels. Esc keeps the switch with no turn.
4. **When labels were carried across:** "[CE] Carried N side-text label(s) across." and the command ends.
5. **When no label was carried across, the label question follows,** the same as the insert tool: "Pick desired support text location (auto left/right/top/bottom), or Enter for auto right: " (Enter = auto right; with Settings "Auto detect support text side" off it asks "Text position [L/R] <R>: " instead), then "Enter a number to append to 'C' (or press Enter to exit): " or, once a label has been typed, "Enter text for 'C' or <1>: ". Enter with nothing remembered: no label, no line. Esc: the switch is kept and no label is made.

## 5. When it says Unknown or "needs checking"

1. **It never says Unknown.** It prints no line when the change worked, except the lines in section 4.
2. **If the block cannot take the size,** the block keeps its old size but still changes layer and position, and no line says so (see 7).

## 6. How to undo it

1. **U once** is intended. The command opens one undo group and closes it at the end. Not proven in AutoCAD.
2. **Esc at the turn** keeps the switch (the change was already made). Use U to take it back.

## 7. Known faults

**Still open**
1. **BUG-532:** the support layer names are written in the code (SUPPORT COLUMN is one).

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-975 (neighbour's label):** a label nearer a neighbouring support is no longer picked up, erased or turned with this one. The switched support's own labels are still drawn again as new text.
2. **BUG-424 (locked layer message):** a locked support layer now gives the plain line in 3.3, not a raw "switch failed: eOnLockedLayer".
3. **BUG-576:** the window said "Press 1-8" while nine types were listed. It now counts the list (up to nine keys).

**Partly fixed**
1. **BUG-537 (sizes):** the C2 list has a Settings list (Supports C2Sizes) but no box on the Settings window. Layer, colour and offsets are still in the code.

**New in code, no bug covers it**
1. **No layout tab, REFEDIT or units stop.** On a layout tab, during REFEDIT or in a metre drawing it runs anyway.
2. **The size change is not checked.** If the block lacks the size, the layer and position still change and no line says so.
3. **A label on a locked text layer** is not erased but is still drawn again, so two labels sit on top of each other. It is also not turned.
4. **After a switch the new labels are not recorded** as this support's own, so they stop following the support when it moves.
5. **The block turns about its insertion corner, but its labels turn about its centre,** so after a turn the labels sit a few tens of millimetres off. By reading only; not seen.
6. **Old label wording and layer are kept** on the new type. 
7. **The help list (command registry) shows the wrong prompts** for this command ("Insertion point", "Text value/orientation").
8. **The remembered label text carries from one drawing to the next** in the same AutoCAD session (only when the label question is asked).
9. **A label placed by this command is not recorded** as the support's own, so it does not follow the support.
10. **On an outdated block** the new size is not set, and SC2 does not offer the Upgrade that C2 offers (a case of 2).

## 8. On AutoCAD 2022 to 2024

1. **Same.** No #if in the support, jig, label or link files. The 2022 to 2024 build (net48) compiles the same source. Whether it works there: not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`. "SBC" is `Commands\SupportBlockCommands.cs`.

1. **1.1:** SBC:70, 129-133, 466-596. **1.2:** SBC:540-572. **1.3:** SBC:562-564, 1772-1848, 1850-1888 (radius 260 at 562 and 1801; text layers at 78). **1.4:** SBC:133.
2. **2.1:** SBC:566-575, 70, 106-121. **2.2:** SBC:564, 580, 1905-1987. **2.3:** SBC:601-607, 658-757; `Services\SupportBlockJig.cs:65-100`; SBC:732-748. **2.4:** SBC:609-619. **2.5:** SBC:476, 623; `Services\SettingRestore.cs:11-69`. **2.6:** SBC:489 (the target size is the config size, never a schedule row); grep for save calls in SBC and SupportBlockJig.cs found none.
3. **3.1:** `Services\DrawingSafetyService.cs:18-41` (line 38); SBC:469. **3.2:** SBC:481, 525, 533. **3.3:** SBC:431-439, 587-588. **3.4:** SBC:443-447, 589-594. **3.5:** SBC:469 (CommandPreFlight only) against 215-216 in the insert path. **3.6:** SBC:1926-1987 (contents copied at 1954 and 1973). **3.7:** SBC:489, 566-572.
4. **4.1:** SBC:480-487. **4.2:** SBC:489-510, 1116-1172; `UI\Dialogs\ColumnVisibilityPickerDialog.cs:41, 62, 94-107, 119-140`. **4.3:** SBC:601-607, 658-757; `Services\SupportBlockJig.cs:65, 79-80`. **4.4:** SBC:609-618 (line 616). **4.5:** SBC:185-190, 609-619, 915-990, 1098-1114; `Models\UserSettings.cs:994`; `Services\CeTextService.cs:464-499, 1988-2018, 2031-2032` (prompts at 2002 and 2009).
5. **5.1:** SBC:466-627. **5.2:** SBC:567-572 (the result of SetDynamicVisibility is not read); SBC:1436-1496.
6. **6.1:** SBC:477, 621-626. **6.2:** SBC:601-607 (comment at 604-606).
7. **Open 1:** SBC:66-70, 75. **Fixed 1:** SBC:1795-1830, 1850-1888 (the neighbour test is called at 1803 and 1824; the own labels are erased and drawn again at 564 and 580). **Fixed 2:** SBC:434-439, 587-588. **Fixed 3:** `UI\Dialogs\ColumnVisibilityPickerDialog.cs:62`. **Partly 1:** `Models\UserSettings.cs:1010-1013`; SBC:88-103; `UI\Dialogs\CeSettingsDialog.xaml.cs:136, 356` (the only Supports box). **New 1:** SBC:469 against 215-216; `Services\DrawingSafetyService.cs:62-100`. **New 2:** SBC:567-572, 1487-1491. **New 3:** SBC:1905-1924 (the catch at 1919 hides the locked-layer failure), 1926-1987, 737-748. **New 4:** SBC:466-627 (no call to `RecordSupportLabel`, which is called only at 376); `Services\BeamLinkService.SupportLabel.cs:76-104, 114-122` (an erased label is not read back). **New 5:** `Services\SupportBlockJig.cs:94-99` (sets the block's Rotation); SBC:700, 732. **New 6:** SBC:1954, 1973; 609-618. **New 7:** `Assets\Config\command-registry.json:2826-2844`. **New 8:** `Services\CeTextService.cs:23, 1988-2016, 5523-5542`. **New 9:** SBC:619. **New 10:** SBC:567; the outdated-block check is only on the C2 insert route, SBC:1299-1345.
8. **8.1:** no `#if` in SBC, SupportBlockJig.cs, `Services\BeamLinkService*.cs` or `UI\Dialogs\ColumnVisibilityPickerDialog.cs` as searched; `CE_STRUC_SUITE.csproj:27, 56-58`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 02:58. Nothing was run in AutoCAD.
