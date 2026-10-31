# DRAFT FOR TIM: CESETTINGS, add the five groups that print on drawings (BUG-526)

**Status:** DRAFT FOR TIM. Not built, not tested, not installed. Written 31 Oct 2026 (job z4).
**Classification:** MISSING (rows that do not exist yet) inside a KEEP window. The CESETTINGS window itself, its tabs, Save and Cancel stay as they are.
**Source:** Tim decision 167, "7yes": start with the five groups that print on drawings; the other 24 come later with his command cards. Bug entry BUG-526 (C:\CE_PLAN\BUG_CARPARK.md). Code read on Structural origin/claude/rel-20261026s: Models/UserSettings.cs, Models/FoundationPlanSettings.cs, UI/Dialogs/CeSettingsDialog.xaml and .xaml.cs.

## 1. What works now
1. CESETTINGS has these tabs: General, Beam, Supports, Bracing, Rafter / Joist, Timber subfloor, Rebar, Weld mark, Annotation, Xref Layer, System, Data automation (and their sub-pages). Values typed there are saved and used.
2. Today the window does NOT show 28 of the saved Settings groups at all, and shows only one switch of a 29th (CeSheets, the issue-preview switch). I re-checked this 31 Oct on the installed Structural line: the window's two files never mention any of them.
3. For these groups the only way to change a value is to edit the settings file by hand, which a drafter will not do. Examples I checked: no command or window writes the Founding note wording, the Slabs list, the Foundation plan values or the Layouts label height.
4. Two on-screen messages even send the drafter to a page that does not exist: the footing legend says "after changing Settings > Slabs" and "Check the pattern name on Settings > Slabs". There is no Slabs page.

## 2. What is wrong or missing
1. **Values that print on the drawing cannot be seen or changed from the one Settings window** (R-00 says the values live in Settings, and Settings-first means a drafter can reach them).
2. **The 29 groups:** SbeamPicker, BraceLength, ReoBars, CommandHub, CeSheets, Migration, LineStyles, TieDowns, LevelCarry, Slabs, FoundingNote, StructuralComputations, WindClass, LoadPath, RoofPointLoads, RoofSetout, FootingWidth, LintelProposal, FramingLegend, FloorSetout, MemberSchedule, FoundationPlan, FoundationGrips, BasementWall, FoundationProposal, PumpPit, BoredPierPlan, Layouts, PlanLevel.

## 3. Which five print on drawings (UNCONFIRMED: my reading of the code; Tim to confirm the five)
How I chose: a group qualifies if a command that is LIVE today (no "off until tested" switch) writes its wording or its sizes onto the sheet, and nothing lets the drafter change it. Groups whose command is switched off by default (member schedule, framing legend, floor and roof setout, lintel proposal, level carry) also print once switched on, but they print nothing today, so they go in the "later 24".

1. **FoundingNote** (UNCONFIRMED choice). The wording of the founding note ("SITE CLASSIFIED AS CLASS ... IN ACCORDANCE WITH AS 2870 ... ALLOWABLE BEARING CAPACITY ... MINIMUM FOUNDING DEPTH ... REFER ..."). Printed on the drawing by the founding-note command. No switch, so it is live now. One long text row (with the four fill-in words listed under it).
2. **FoundationPlan** (UNCONFIRMED choice). Prints the footing and R.C. beam schedule titles (concrete strength in MPa), the infill slab note ("100 THICK INFILL SLAB WITH SL82 MESH TOP" wording, thickness, mesh), the legend heading, and the layers they go on. Rows: the two strengths, schedule layer, infill thickness, mesh, note wording, note layer, legend heading.
3. **Slabs** (UNCONFIRMED choice). The slab types shown in the footing-plan legend: code, layer, hatch pattern and scale, colour, thickness text, mesh, cover, concrete strength, membrane, sand. This is a list the drafter adds to, edits and deletes. No editor exists anywhere, yet the legend messages point to one.
4. **Layouts** (UNCONFIRMED choice). Sizes that print on every sheet: the label height on paper (2.5 mm), the plan title height (5 mm) and its gap above the viewport, the office viewport scales list, the A1 and A3 drawing areas, and the switches that decide how hatch density and tag text follow scale (already used by CH, BUG-614 and BUG-748). Nine services read the label height. Rows for the template-drawing paths belong here too but are the riskiest to edit (open question 3).
5. **PlanLevel** (UNCONFIRMED choice). The list of level names (Ground, First, Roof ...) that the plan-level command offers and that then appear in plan titles and schedule titles ("FIRST FLOOR MEMBER SCHEDULE"). A list editor, lowest level first.

**Runners-up, for the later batch:** TieDowns (the type list already has its own command CSTIEDOWNTYPES; only its two description switches have no row), WindClass (region and step tables behind the wind class suggestion that ends up in the general notes), MemberSchedule, FramingLegend, FloorSetout, RoofSetout, LevelCarry, LintelProposal, FootingWidth (sizes drawn when a size is unknown).

## 4. Tim's words
1. "7yes" (decision 167). Desk instruction: start with the five groups that print on drawings; go through the other 24 later with his command cards.
2. Earlier house rule (R-00 and R-27): every engineering value comes from Settings, nothing is hard-coded, warnings never block.

## 5. Full experience
1. **Trigger:** CESETTINGS, the existing command and ribbon button. Nothing new to find.
2. **Where the rows go:** one new tab called **Drawing text and sizes**, with five sections in this order: Founding note, Foundation plan, Slabs, Sheet layout (Layouts), Plan levels. (Recommendation: one tab so the five are found together; alternative is to spread them over the existing tabs.)
3. **Prompts:** none. It is the same window: Save, Cancel, Reset to default as today.
4. **Selection / preview:** not applicable to the window. Each text row shows a one-line example of what it prints ("Prints as: 100 THICK INFILL SLAB WITH SL82 MESH TOP"). The Founding note row shows the fill-in words and a plain warning that the wording is an engineering statement.
5. **Drawing output:** none changes by itself. A value changed here is used the next time the command runs. Drawings already placed are not rewritten.
6. **Cancel / Escape:** Cancel or Escape closes with nothing saved, as today.
7. **Undo:** CESETTINGS is not a drawing edit, so AutoCAD Undo does not apply; the window's own Reset restores office defaults per section.
8. **Save and reopen:** values are written to the user's settings file as today; reopen CESETTINGS and they are there; restart AutoCAD and they are still there.
9. **Lists** (Slabs types, Plan level names, Viewport scales): add, edit, delete, move up and down. A blank or duplicate name is refused with one plain line (warn, never block the rest of the save).
10. **Unknown stays Unknown:** a blank number is saved as "not set" and the command asks or warns; it is never turned into a quiet 0 (RULES 12.2).
11. **Dependencies:** none outside the window. The existing Settings file layout stays the same, so older saved files load unchanged; no value moves.
12. **Performance:** none noticeable; the window already loads in one go.
13. **How a drafter discovers it:** the tab name says what it holds; the two messages that point to "Settings > Slabs" then become true.
14. **Switch:** none needed. Showing a row does not change behaviour; if the row is left alone the saved value is untouched.

## 6. Example drawings and expected results
1. **Slabs.** Open CESETTINGS, tab Drawing text and sizes, Slabs, add a type "S2", 200 thick, mesh SL82. Save. Draw or open a footing plan with that slab type and run CSFOOTINGLEGEND. Expected: a legend box for S2 with those words.
2. **Infill note.** Change the infill thickness from 100 to 125. Run the infill note command. Expected: "125 THICK INFILL SLAB ..." (new notes only).
3. **Founding note.** Change one word in the wording, Save, run the founding-note command. Expected: the new wording on the drawing, fill-in words replaced by the site values.
4. **Label height.** Change label height from 2.5 to 3.0 mm at 1:100. Place a section mark label. Expected: text 300 mm high in model space (3.0 x 100), not 250.
5. **Cancel.** Change anything, press Cancel, reopen. Expected: old value.

## 7. Guard tests and Tim's AutoCAD checklist (proposal)
1. **Guards (no AutoCAD):** a pure test that every property of each of the five groups has a row (a new property added later without a row fails the test, so this gap cannot grow back); a round trip: value in the row, Save, reload, same value; blank number stays "not set"; list rows save in order.
2. **Window look:** a window is never accepted by a machine (RULES 5.7), so one Codex look at the new tab, with a screenshot.
3. **Checklist:** examples 1 to 5 above.
4. **Not provable without AutoCAD:** that each command really prints the changed value (examples 1 to 4).

## 8. Open questions for Tim
1. **Are these the right five** (Founding note, Foundation plan, Slabs, Sheet layout, Plan levels)? UNCONFIRMED: this is my reading, he may prefer to swap in WindClass or TieDowns. Recommendation: these five, because their text or sizes print today and no editor exists.
2. **One new tab or spread across the existing tabs?** Recommendation: one new tab.
3. **Template-drawing paths and A1 / A3 drawing-area origins** (inside Layouts): include now, or leave until sheet set-up is reviewed? Recommendation: leave the paths and origins for the later batch, show only label height, title height, scales and the three switches.
4. **Founding note wording:** editable by any drafter, or shown read-only with a "Tim only" note? It is an engineering statement. Recommendation: editable but with a plain warning line.
