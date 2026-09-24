# Structural "Line styles" — command card, DRAFT for Tim's OK (24 Sep 2026)

**Status:** APPROVED by Tim 24 Sep about 11:00 with changes (section 4); Pen & Linetypes only. Classification: **Missing** (StrucPlus had
it; the Structural module does not).

**Source read (read-only, nothing copied):** Tim's StrucPlus copy in OneDrive IT Admin, `StructPlus\CE_StrucPlus\`:
`menu\CE_StrucPlus.mnu` (toolbars "Pen & Linetypes", "Change Color of Entity", "Change Linetype of Entity"),
`lisp\ce_drafter.lsp` (`ce_config`, the pen functions), `lisp\Sptools.lsp` (`setall`, `chgall`, `chlayer`,
`sp_chcolor`), `config\ce_colors.ini`, `config\ce_bylayers.ini`. Tim located it 24 Sep about 10:45.

**Compared with the shipping Structural line** (`claude/struc-d1-prep`, `LegacyPortCommands.cs`, command-registry
"Legacy", 29 commands): none of the buttons below is ported.

## 1. What StrucPlus did — read from the files

### Pen & Linetypes toolbar (21 buttons)

1. **Four pens × five line types = 20 buttons.** Pens 0.25, 0.35, 0.50, 0.70. Line types Continuous, Hidden, Center,
   Dashed, Phantom.
2. **Colour per pen** (`ce_colors.ini`): 0.25 = colour 7 (white on black, black on white), 0.35 = 2 yellow,
   0.50 = 1 red, 0.70 = 4 cyan. (0.18 = 9 grey and 1.00 = 5 blue exist in the file but had no button.)
3. **What a button does** (office setting `cebylayer=Y`): makes the layer if it is missing, e.g. 0.35 Hidden →
   layer `CE-35-HIDDEN`, colour 2, linetype Hidden; if it exists, thaws it and turns it on. Makes it current, with
   colour and linetype ByLayer. **It does not draw.** The drafter then draws with LINE, PLINE etc. Lineweight is not
   set: the pen thickness comes from the colour at plot time.
4. **Set All (SA):** pick an object; its layer, colour and linetype become current, and LINE starts.

### Change Color of Entity toolbar (10 buttons)

5. **Eight colours:** Red 1, Yellow 2, Green 3, Cyan 4, Blue 5, Magenta 6, White 7, Grey 8. Select objects; their
   colour changes (an override, not a layer change). In ByLayer mode it first asked once per session "Do you want
   change a ByLayer Entity to another Layer?"; Yes opened Properties instead.
6. **Change to Match (CA):** select objects, then a target object; they take its layer, colour and linetype.
7. **Change Layer (CHL):** select objects, then a target object; they move to its layer.

### Change Linetype of Entity toolbar (7 buttons)

8. **Five line types:** Continuous, Hidden, Center, Dashed, Phantom, applied to selected objects.
9. Change Layer and Change to Match again (same as 6 and 7).

## 2. Proposed V3 behaviour — waiting on Tim's answers

1. **Pen buttons:** set the layer exactly as StrucPlus did (made if missing, thawed and on if present, current,
   ByLayer), no drawing started. *(Question 1.)*
2. **Layer names:** `CE-<pen>-<TYPE>` as StrucPlus. *(Question 2.)*
3. **Buttons:** all of the above: 20 pen buttons and Set All on a **Line styles** panel; 8 colour, 5 line type,
   Change Layer and Match on a **Change** panel, on the CE STRUC tab. Coloured-line pictures like the old toolbar.
   *(Question 3.)*
4. **Every button is one AutoCAD Undo.** Locked layers and Xref objects are left alone and named on the command line
   (native protection rule). Escape at any pick leaves the drawing unchanged.
5. **Values on the Settings page (R-00):** pen → colour, layer name pattern, the linetype file.
6. **Both lanes:** 2027, and 2022-2024 (net48).

## 3. Tim's AutoCAD checklist (after build) — layer names per section 4: read `35HIDDEN` for `CE-35-HIDDEN`; steps 4 to 6 dropped

1. Click **0.35 Hidden**. The layer list shows `CE-35-HIDDEN` current, yellow, Hidden. Draw a LINE: yellow, hidden.
2. Freeze `CE-35-HIDDEN`, click 0.35 Hidden again: it is thawed and current.
3. Click **Set All**, pick a red dashed line: LINE starts on that line's layer, colour and linetype.
4. Select three lines, click **Change to Magenta**: they turn magenta. One U puts them back.
5. Select two lines, click **Change Layer**, pick a line on another layer: both move to it. One U puts them back.
6. Try 4 with a line on a locked layer: it is left alone and the command line says so.
7. Repeat 1 and 4 in AutoCAD 2024 (net48).

## 4. Tim's answers (24 Sep about 11:00, verbatim in decisions/2026-09-23_V3_COLLEAGUE_RELEASE.md)

1. *"a but layers should be 35CONT, 25TEXT, 70HIDDEN"*: behaviour as StrucPlus; layer names `<pen><TYPE>` (`25CONT`, `35HIDDEN`, `50CENTER`, `70DASHED`, `70PHANTOM`), the original StrucPlus `data\Bylayer.ini` table. **Section 2 item 2 is superseded.**
2. *"A REVIEW ABOVE"*.
3. *"Pen & Linetypes, 21 buttons ONLY"*: the Change panel (section 1 items 5 to 9, checklist steps 4 to 6) is **not built**.
**Release chat's call, not Tim's (24 Sep):** existing layers keep their own colour and linetype (the office layer update, LU, may already define them); a missing linetype is loaded from acadiso.lin.
