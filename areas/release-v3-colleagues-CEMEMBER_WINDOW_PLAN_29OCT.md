# CEMEMBER window and beam-size warning: plan (Thu 29 Oct 2026, Melbourne; build items B-036 and B-037)

Design only. No code written, no build, no PR, no AutoCAD. Written from the code on the branch that built the installed Structural 1.0.125 (`origin/claude/rel-20261026s`, S-45, version commit `204dfad2`), read with `git show`; the main checkout was not touched. Tim's rulings used: decisions\2026-10-29_TIM_ANSWERS.md items 57, 66 and 67; the approved card (19 Oct, "yes"); the 19 Oct answers.

---

## FOR TIM (read this part only)

**THE PICTURE:** open `C:\CE_PLAN\areas\CEMEMBER_WINDOW_MOCK_29OCT.html` in any browser. It is labelled MOCK-UP. Top left is the window (1280 x 680 px). Top right are small numbered notes about the mock-up (they are not in the window). Bottom is your question, "How big will the beam draw?", with the same beam drawn both ways, and a strip showing both about life size on an A1 sheet.

1. **What the window will look like.** One window, three columns, as you approved on 19 Oct. Steps are numbered 1 to 8 straight through.
   1. **Left:** 1 Member (12 one-click buttons), 2 Size (a Find box and the list), then a small box of figures (depth, width, web, flange, mass, Ix, Iy, Zx, Zy; a dash where the list has none).
   2. **Middle:** a live picture of the member, always showing, with points 1 and 2 marked on a side or top view. It is drawn by the same code that draws it in the drawing, so what you see is what you get.
   3. **Right:** 3 View, 4 Orientation pictures (greyed for a UB), 5 Section in front or beyond, 6 Points sit on (swapped for the 3 x 3 grid when the view is Section), 7 Break lines at (Both, Start, End, None), 8 Scale 1 : number. A quiet status line, then Reset, Cancel, Place at the bottom right. Only Place is solid gold.
2. **What Place does.** The window hides. You pick point 1 then point 2 (a section: one pick). Escape stops. Press Enter or Space afterwards and the window comes back with your last choices. Reset clears them. All of that already works today on the command line; the window is a nicer front for it.
3. **Your question, and what I found.** You said you cannot answer "real size or 5 times" until you see it. I checked the code.
   1. **CEMEMBER (the new command) always draws real size.** A 310UB32.0 is 298 mm deep at every scale. Scale only changes the break-line size.
   2. **The old SBEAM draws size = DIMSCALE divided by 20.** At DIMSCALE 100 that is 5 times (1490 mm for the same beam). At DIMSCALE 20 it is normal. That is your 100 / 20 sentence, and it matches SBEAM's 1490.
   3. **LTSCALE is not the cause.** It only changes how long the dashes are. It looks linked because your office pairs are always 20 with 200 and 100 with 1000.
4. **The warning you asked for (never stops the drawing).**
   1. **Wording:** "Beam size: 310UB32.0 is drawn 5 times its real size (1490 mm deep, real 298 mm) because the drawing scale is 1:100. It prints the same as at 1:20."
   2. **Where:** amber line in the window under Scale; the command line when you Place; one line in the log.
   3. **When:** only when the beam is drawn at other than real size. With real size (today's CEMEMBER) it never fires and the window shows one quiet grey line, "Real size - line scale OK".
   4. **Separate warning, already built:** if LTSCALE is not 10 times the scale, CEMEMBER warns and carries on. The window will show that in the same band.
5. **What is NOT decided (your call after you see the picture).**
   1. **Option A real size, or Option B about 5 times at 1:100.** I recommend A (true dimensions; a dimension or clash check reads right) with the beam printing small at 1:100 (3.0 mm on an A1 sheet). Option B prints 14.9 mm at every scale but the drawing no longer holds the true size. The picture now has a strip showing both about life size as printed (a 10 m beam at 1:100 is 100 mm long; A is 3.0 mm deep, B 14.9 mm; approximate on a screen). Nothing changes until you answer.
   2. **Should the same warning go on the old SBEAM now?** SBEAM draws 5 times at 1:100 today and says nothing. It is a one-line addition and changes no size. I recommend yes, as a small separate piece, because it protects drafters this week. It touches an old command, so I will not do it without your yes.
6. **What I need from you.**
   1. Look at the picture and tell me what to change in the layout.
   2. Answer A or B (or "show me more").
   3. Yes or no to the warning on SBEAM.
   4. Nothing else. Any builder can build this (your 29 Oct ruling); it goes after the Civil freeze work.
7. **Mistakes of my own and what I did not check.**
   1. The mock-up is a drawing, not the window. It has not been seen in AutoCAD and no code exists.
   2. The first version of the picture overflowed its box and was drawn 1880 px wide while this plan said about 1100 x 640; Option A also lacked the inside lines Option B had, and the window carried the picture's own notes. All fixed in the 29 Oct revision after the design review: the window is drawn at 1280 x 680, and the picture fits 1920 x 1032 with no scrolling (Edge headless screenshot, 29 Oct).
   3. Your memory notes say **no blue**: gold, black, white and grey (9 Oct ruling), so the picture is gold on dark with no blue. I did not use the old deep-blue idea.
   4. The 5-times claim: I confirmed it for SBEAM from the code, not by drawing one in AutoCAD.

---

## TECHNICAL PLAN

### 1. What exists on the live line (read 29 Oct, `origin/claude/rel-20261026s`)

1. **Live line:** Structural 1.0.125 is `rel-20261026s` @ `204dfad2` ("Version: Structural 1.0.125 (S-45)"). Later branches (`rel-20261026t` to `rel-20261029a`) were not read, so I do not know whether any carries newer Structural work. Build the window on whichever Structural branch is live when the slice starts and re-read the files below first.
2. **The command is command-line only:** `Modules/Structural/Commands/CeMemberCommands.cs` (472 lines). `Run()` asks View, Member, Orientation, Points on, Ends, then loops picking two points. Settings read at the top (`CeMemberUserSettings`: break sizes, DefaultScale, six layer names). `CeMemberMemory` holds the last answers for Enter-to-repeat.
3. **Pure drawing code, already in DesignCore (no AutoCAD):** `CeMemberPlacement.PlanElevation(dims, view, p1, p2, pointsOn, ends, scale, settings)` returns the line list; `CeMemberSection.Plan(dims, position, base, anchor)` for sections; `CeMemberCatalogue.TryBuild(row, orientation)` for the sizes; `CeMemberLayerNames.MapLines` for office layer names; `CeMemberScale.Resolve(dimScale, ltScale)` for the LTSCALE warning (`CeMemberEngine.cs:175-205`). Writers: `CeMemberLineWriter`, `CeMemberSectionWriter`.
4. **Existing window to copy conventions from:** `SteelSectionPickerDialog` (xaml + `.xaml.cs` + `.Preview.cs` + `.Edit.cs`, SBEAM's window): WPF code-behind with a testable controller (`SbeamPickerController`), `StructuralWindowTheme.Attach` for the look, `AutoCadWindowHostHelper.FitToWorkArea(this)` (BUG-956: comes down to a small screen), shown with `Application.ShowModalWindow(picker)` in `SbeamCommandRunner.cs:32`, family list of 14 codes, a `PreviewCanvas` that already draws the section outline (`RenderPreview`). Not MVVM in the strict sense; follow the same pattern (pure model class plus thin code-behind) rather than invent a new one.
5. **Missing, confirmed by the 23 Oct review item 9:** the window, live preview with points 1 and 2, properties box, orientation pictures, typed scale (today scale is always DIMSCALE, `CeMemberCommands.cs:98-101`).
6. **Settings page:** `CeMemberUserSettings` is at `UserSettings.cs:912`; new switches follow the C75 pattern (declared there, "Default: on." in the comment, pinned in the new-switch-defaults tests through both `SettingsService.DeserializeSettings` and `DeserializeSettingsTolerant`, shown on the Settings page).

### 2. The window (layout exactly as card section 5)

1. **Size:** **1280 x 680 px** (revised 29 Oct after the design review; the first version said about 1100 x 640 and the picture was drawn wider than that). Left column 330, live preview about 550, right column 400. No scrolling layout (rule ui-no-scroll-rule: high-use window; the size list is a bounded list that may scroll inside itself). Fits 1920 x 1032 and shrinks through `FitToWorkArea` on small screens.
2. **Left column, numbered 1 and 2:** 1 Member: the 12 codes (UB, UC, WB, WC, PFC, SHS, RHS, CHS, EA, UA, ZC, CP) as one-click buttons in two rows of six, not a drop-down (tees and bars are deferred); 2 Size: a **Find** box above the size list (typing filters, as the typed route's name search does), then the list; under it a properties box (depth, width, web, flange, mass, Ix, Iy, Zx, Zy, "-" where blank).
3. **Middle:** live preview canvas, always shown, drawn with the real line rules (section 4 below). Points 1 and 2 on elevations; base point mark on sections. The key under the picture lists only the layers actually in the picture (for a side view of a UB: 25cont outline, 18cont inside lines and break lines; 18hidden appears only when something hidden is drawn).
4. **Right column, numbered 3 to 8 so the order reads straight through from the left column:** 3 View (Side, Top, Section); 4 Orientation (four small pictures, greyed unless PFC, angle, Z, C; each picture is the real section drawn at that orientation by `CeMemberSection.Plan`); 5 Section In front / Beyond (greyed for elevations); 6 Points sit on (Centreline default, Top, Bottom); **when View is Section this row is swapped in place for the 3 x 3 base-point grid** (centre of the box, not the balance point), and the row's height is reserved so nothing moves; no faded ghost grid under an elevation; 7 **Break lines at: Both | Start | End | None** (default Both; greyed for a section); 8 Scale 1 : [typed number, default from the drawing's DIMSCALE, else the Settings DefaultScale].
5. **Under Scale:** one status line with a **fixed height reserved for about 3 lines** (the longest amber text), so nothing moves when a warning appears. Healthy state: one quiet muted line, "Real size - line scale OK", no underline, no colour. Amber only when a warning applies (section 6). Same position every open (cockpit test). The in-window text is the short form, "Beam drawn 5 x real size (1490 mm deep, real 298 mm) at 1:100."; the full sentence goes on the command line.
6. **Bottom right:** Reset to default, Cancel, **Place** (solid gold, fixed corner; the only solid gold in the window). Enter = Place, Esc = Cancel.
7. **Look:** the real dark theme: background `#1C1C1C`, panels `#252525`, lines `#41413D`, text `#EEEAE1`, gold `#C9A84C`; **no blue** (9 Oct ruling). Chosen buttons, the chosen size and the chosen scale get a gold outline with a soft tint (`#332A10`), not a solid fill. Plain words only; AutoCAD terms (layer, DIMSCALE, LTSCALE) are fine. Amber band for a waiting decision, bold key numbers (ui-emphasis-rule). The window carries no explanatory hint lines (cockpit test: no repeated hints); the picture keeps its own notes outside the frame, as numbered call-outs N1 to N8.
8. **Typed scale:** a number box; blank, zero, negative or text turns the box red with "Type a scale such as 100" and Place stays off. Never silently replaced.

### 3. Place, Escape, Enter-to-repeat (card section 6)

1. **Place:** window closes; the existing pick loop runs (point 1, point 2, west to east; section one pick; Escape finishes; one U removes the run). No change to that loop.
2. **Cancel / Esc / close box:** "CEMEMBER cancelled. Nothing changed." and nothing is drawn or remembered.
3. **Enter or Space at the Command prompt:** AutoCAD repeats CEMEMBER; the window opens pre-set from `CeMemberMemory` (already remembered only after something was drawn). Reset clears it. No new repeat code.
4. **Refusals unchanged:** metre/inch drawing (BUG-880), locked or Xref layers, REFEDIT: refused by `CanWrite` before anything is drawn. The window never unlocks anything.

### 4. One code path (design rule 1): preview and Place share the drawing code

1. Add one pure class in DesignCore, `CeMemberChoices` (view, member row, orientation, points on, ends, section position, anchor, typed scale), plus `CeMemberWindowModel` (greying rules, validation, the preview request, the status band text). Both routes fill a `CeMemberChoices`: the **typed questions** (today's `TryAsk...` calls) and the **window**.
2. `Run()` is split: step A "get choices" (window or typed, by the switch), step B "pick and draw" (today's loop, unchanged, fed by the choices). So there is no second drawing routine.
3. **The preview calls the same planners as Place:** `CeMemberPlacement.PlanElevation` with two fixed demo points (length about 6 x the member depth, so a break line shows) and `CeMemberSection.Plan` for a section, then `layerNames.MapLines`. A small painter turns the line list into WPF lines (colour and dash from `NewLayerLook`). The painter is the only new drawing-ish code and it draws nothing in AutoCAD.
4. **Guard test:** a source test that the window files contain no line-rule arithmetic (no flange or web offsets) and call only the planners above.

### 5. Settings switches (R-00, R-27)

1. **`structural.cememberWindow`** = `CeMemberUserSettings.UseWindow`, **default ON**. OFF returns exactly today's typed questions. Documented "Default: on.", pinned through both start-up reads, shown on the Settings page. (Read at AutoCAD start, as all settings guards are.)
2. **`structural.cememberSizeWarning`** = `SizeWarning`, **default ON**: print the beam-size warning (section 6). OFF prints nothing new.
3. **Every value from Settings or the section list:** default scale (existing `DefaultScale`), break sizes, layer names (existing), the reference scale for the size rule (new `SizeReferenceScale`, default 20, used only by the warning arithmetic and by SBEAM's rule; nothing is hard-coded in the window).
4. **Not changed:** the beam size rule (real size in CEMEMBER, DIMSCALE / 20 in SBEAM). Tim's ruling 29 Oct: no change until he answers.

### 6. B-037: the scale warning

**What the code does today (read, not run).**

1. **CEMEMBER:** scale = DIMSCALE (`CeMemberScale.Resolve`), used only for break-line size (`CeBreakLine`: 1.5 mm overshoot and 2 mm kink on paper times scale). The member is drawn at its list size at every scale. LTSCALE is only compared with 10 x DIMSCALE.
2. **SBEAM:** `SbeamPlacementPlanner.cs:23` and `:87`: `scale = effectiveDimScale / BaseDimScale` with `BaseDimScale = 20.0`; `effectiveDimScale` is the drawing's DIMSCALE (Auto) or 20 or 100 if the old window's 1:20 / 1:100 buttons are chosen (`SteelSectionPickerDialog.ComputeEffectiveDimscale`, `:689-696`). So SBEAM multiplies every dimension by DIMSCALE / 20.
3. **`HatchCommands.ResolveScale`** (`:1650`) reads DIMSCALE and LTSCALE only to pick the hatch pattern scale (and refuses a pair that is not 20/200 or 100/1000 unless "any scale" is on); it has nothing to do with beam size. The 5-times claim is therefore **established for SBEAM** (planner line 23), **not true of CEMEMBER**, and **LTSCALE is not the cause**. I did not run either command.

**The numbers worked (310UB32.0: 298 deep, 149 wide; installed list still says 310UB32).**

1. **DIMSCALE 100, LTSCALE 1000:** SBEAM factor 100 / 20 = 5: 1490 deep, 745 wide; prints 14.9 mm deep on paper at 1:100. CEMEMBER: 298 deep, 149 wide, prints 3.0 mm.
2. **DIMSCALE 20, LTSCALE 200:** SBEAM factor 1: 298 deep, prints 14.9 mm at 1:20. CEMEMBER the same 298 deep.
3. **DIMSCALE 50, LTSCALE 500:** SBEAM factor 2.5: 745 deep. CEMEMBER 298.

**When it fires.**

1. **Size warning:** when the size multiplier is not 1, where multiplier = (scale the size rule uses) / `SizeReferenceScale`. Today CEMEMBER's multiplier is always 1, so it never fires on CEMEMBER; it fires on SBEAM at any DIMSCALE other than 20; it would fire on CEMEMBER at any scale other than 20 if Tim chooses Option B.
2. **LTSCALE warning (card section 7, 19 Oct "yes as per recommended"):** when LTSCALE is not 10 x the scale. Already built for elevations; add the same check for sections (review Part A item 10: the Beyond section is dashed, so a wrong LTSCALE hides the dashes).
3. **Never blocks (R-27); warn and carry on; one log line each.**

**Exact wording (plain, drawing terms; numbers filled in):**

1. **Size:** "Beam size: 310UB32.0 is drawn 5 times its real size (1490 mm deep, real 298 mm) because the drawing scale is 1:100. It prints the same as at 1:20." (A factor under 1: "drawn 0.5 times its real size ... smaller".) Quiet state in the window: "Real size - line scale OK" (no amber).
2. **LTSCALE (existing text kept):** "The line scale (LTSCALE 100) is not 10 x the drawing scale (1000), so dashed lines may look off. CEMEMBER carried on at 1:100."
3. **Where it prints** (moved here from the picture's warning panel, 29 Oct, because Tim does not read big documents):
   1. **Window:** the status line under Scale turns amber, with the short text "Beam drawn 5 x real size (1490 mm deep, real 298 mm) at 1:100." (bold numbers; it updates as the typed scale changes). Its height is reserved so nothing moves.
   2. **Command line:** the full sentence above, once per run at the first pick ("CEMEMBER: ..."). **Log:** "CEMEMBER size: ..." beside the existing "CEMEMBER scale:" line.
   3. **It never stops the beam being drawn.** With Option A the status line stays one quiet grey line and never turns amber.
   4. **The LTSCALE warning is separate:** if LTSCALE is not 10 x the scale (for example 100 at 1:100), dashed lines may look wrong, and the same status line turns amber and says so.
4. **SBEAM (recommended, needs Tim's yes):** the same sentence on the command line when SBEAM is placed, no size change, switch `structural.sbeamSizeWarning` ON. Without that yes, B-037 covers CEMEMBER only.

### 7. Files to add or change (on the live Structural line; confirm paths at build time)

1. **Add DesignCore:** `CeMemberChoices.cs`, `CeMemberWindowModel.cs`, `CeMemberSizeNote.cs` (the size-warning arithmetic and wording; pure).
2. **Add Structural:** `UI/Dialogs/CeMemberWindow.xaml`, `CeMemberWindow.xaml.cs`, `CeMemberWindow.Preview.cs` (painter), `CeMemberOrientationPicture.cs` (small pictures from `CeMemberSection.Plan`).
3. **Change:** `Commands/CeMemberCommands.cs` (split `Run()` into get-choices and pick-and-draw; window when the switch is ON); `Models/UserSettings.cs` (`UseWindow`, `SizeWarning`, `SizeReferenceScale` in `CeMemberUserSettings`); the Settings dialog (three rows); `command-registry.json` (CEMEMBER notes now wrong: "Elevations only", unhide only when Tim accepts); `REGRESSION_LOG.md`.
4. **Not changed:** `CeMemberElevation.cs`, `CeMemberSectionWriter.cs`, `CeMemberLineWriter.cs`, the section list, SBEAM sizes, `CE_SHARED`.

### 8. Tests

1. **Unit (DesignCore.Tests):** window model greying (UB: orientation off; PFC: on; section: Break lines at greys and the Points-on row swaps to the grid); typed scale parse (blank, 0, -5, "abc", "1:50", 20, 100, 37.5); Reset; memory round trip; size note numbers for DIMSCALE 100 / 20 / 50 and the below-1 case; LTSCALE wording unchanged; **parity test:** for every family x view x orientation, the preview's line list equals the line list Place would draw for the same inputs (same planner, so this pins that nobody adds a second routine).
2. **Switch tests:** defaults ON through both `DeserializeSettings` and `DeserializeSettingsTolerant`; with `UseWindow` OFF the typed route is unchanged (existing source guards `CeMemberCommandSourceGuardTests` and `CeMemberRepeatSourceGuardTests` stay green).
3. **Source guards:** window files call only the shared planners; no number or layer name literals; Cancel path draws nothing; no `SetSystemVariable`, regen or zoom in the window (REDO-safe, BUG-861).
4. **Drawing-output (robot, existing review Part A item 5 E1 to E12):** run each case once typed and once through the window with identical choices; assert the same entities (layers, counts, coordinates). Plus the scale cases below.

### 9. Proof list: robot and a Codex look (a window needs a Codex look; RULES 5.7)

1. **S31_cm_window_ub_side (robot, with switch-off control S31off):** type `CEMEMBER`; with `structural.cememberWindow` OFF (set before launch) the command line asks `View [SIde/Top/SEction/Reset]`; with it ON a window opens (window title "CEMEMBER - draw a steel member"). Types in the window: UB, 310UB32.0, Side elevation, Centreline, Both, scale 100, Place; then `0,0` and `3000,0`, Esc. Checks: 6 new entities, 25CONT lines at Y = 149 and -149, 18CONT at Y = 141 and -141 (the E1 values), and the same entity list as the typed twin. Control: switch OFF gives the typed questions and the same 6 entities.
2. **S32_cm_window_enter_repeat:** place one member, Esc, press Enter at Command: window reopens with 310UB32.0, Side, Centreline, Both, 100 preset. Reset clears them.
3. **S33_cm_size_warning:** `DIMSCALE 100`, `LTSCALE 1000`: status line is the quiet grey "Real size - line scale OK", no extra command-line line. `LTSCALE 100`: amber LTSCALE band and the line "CEMEMBER: The line scale (LTSCALE 100) is not 10 x ..." with the member still drawn. Switch-off control (`cememberSizeWarning` OFF): the new size line is absent. (Option B cases only after Tim answers.)
4. **S34_cm_window_cancel:** Cancel and Esc: "CEMEMBER cancelled. Nothing changed.", zero new entities, U has nothing to undo.
5. **C35_cm_window_codex_look (Codex, real AutoCAD, screenshots):** open the window on 1920 x 1032 and on a small laptop screen; check no scrolling layout, gold on dark with no blue, orientation pictures change with PFC, ZC, EA, preview matches the drawn member, band positions fixed, Place in the bottom-right corner.
6. **Not provable by a machine:** whether it looks right to a drafter (Codex look or Tim), and the A or B answer (Tim's engineering call).

### 10. Slices, estimate and order

1. **Slice 0 (optional, needs Tim's yes): SBEAM size warning line.** About 0.5 day. No size change. Independent of the window.
2. **Slice 1: window shell and member list (B-036a).** Switch, settings rows, `CeMemberChoices`, window with left column, right column controls, Reset/Cancel, greying rules, typed scale; Place returns the choices to `Run()` (split done). About 3 days.
3. **Slice 2: live preview (B-036b).** Painter, preview via the shared planners, orientation pictures, points 1 and 2 and base-point marks, properties box. About 3 days.
4. **Slice 3: Place wiring, repeat, warning band (B-036c, B-037).** Pick loop fed from the window, Enter-to-repeat pre-set, size and LTSCALE band, section LTSCALE check, log lines, regression log, the robot cases above. About 2 days.
5. **Proof and fixes:** robot runs, Codex look, one fix round. About 2 days.
6. **Total:** about 10 working days of building (0.5 more with slice 0), one Opus review per slice. Each slice is a DRAFT PR behind its switch, ON by default.
7. **Order:** after the Civil freeze work (final go Fri 6 Nov, release Mon 9 Nov per the session map); first the picture is shown to Tim and A or B answered. The window slices do not depend on A or B (the status band shows "real size" until he answers), so slices 1 and 2 can start straight after the freeze whatever he says. If Tim wants the section list correction in first (review question 4), that goes ahead of slice 3 so the window shows decimal names such as 310UB32.0 from the start.

### 11. Open items and what I did not do

1. **Open for Tim:** A or B; SBEAM warning yes or no; the four review questions of 23 Oct (Z purlin names, unequal angle long leg flat, C purlin flanges-up top view, corrected section list), because the orientation pictures show them.
2. **Not done:** no code, no build, no test, no AutoCAD, no Codex; the live train after `rel-20261026s` not read; SBEAM's 5x not driven in AutoCAD; properties figures in the picture are from the installed list's 310UB32 row (Iy 4.42, Zy 59.3 are that list's figures, not checked against the supplier).
3. **Records not touched:** no decision file, BUG_CARPARK.md, DESK_LOG.md or register edited. The "Codex owns the window" wording in the 23 Oct review is for its owning session to remove (decision 67).

## Summary (under 100 words)

Plan and picture written for CEMEMBER's window (B-036) and beam-size warning (B-037). Code read: CEMEMBER always draws real size; old SBEAM draws DIMSCALE/20 (5 times at 1:100, normal at 1:20); LTSCALE is not the cause. Warning never blocks, shown in the window, command line and log. Switches `structural.cememberWindow` and size-warning, both ON. Slices ~10 days after the Civil freeze. Nothing built or run. Files: areas\release-v3-colleagues-CEMEMBER_WINDOW_PLAN_29OCT.md and areas\CEMEMBER_WINDOW_MOCK_29OCT.html. Tim must choose A or B.
