> **UPDATE 29 Oct 2026 (Tim, TIM_ANSWERS item 74): the beam-size question is ANSWERED: Option B. CEMEMBER draws real size x DIMSCALE / 20 (5 times at 1:100, real at 1:20; the 20 is a Settings value), the old SBEAM rule; SBEAM unchanged. Everything below that says "Option A recommended" or "no size changes until Tim answers" is SUPERSEDED. The warning keeps its wording and states the factor. Item 75 ("yes your readings are correct") confirms the two readings: "dimscale = 120" is a slip for 20, and other scales follow the same rule. Item 100 approves the window and the warning for building. The picture and sections 5, 6, 9 and 10 were corrected to this on 29 Oct.**

# CEMEMBER window and beam-size warning: plan (Thu 29 Oct 2026, Melbourne; build items B-036 and B-037)

Design only. No code written, no build, no PR, no AutoCAD. Written from the code on the branch that built the installed Structural 1.0.125 (`origin/claude/rel-20261026s`, S-45, version commit `204dfad2`), read with `git show`; the main checkout was not touched. Tim's rulings used: decisions\2026-10-29_TIM_ANSWERS.md items 57, 66 and 67; the approved card (19 Oct, "yes"); the 19 Oct answers.

---

## FOR TIM (read this part only)

**ANSWER FIRST:** your beam-size question is ANSWERED and the picture now shows the rule, not a choice. The window and the warning are approved (decisions item 100) and ready to build after the Civil freeze. Two small readings still need your yes.

**THE PICTURE:** open `C:\CE_PLAN\areas\CEMEMBER_WINDOW_MOCK_29OCT.html` in any browser. It is labelled MOCK-UP. Top left is the window (1280 x 680 px). Top right are small numbered notes about the mock-up. Bottom is "How big the beam draws (decided)": the same 310UB32.0 at 1:20, 1:50 and 1:100, and a strip showing the beam printed the same size on an A1 sheet at every scale.

1. **What the window looks like.** One window, three columns, as you approved.
   1. **Left:** 1 Member (12 one-click buttons), 2 Size (a Find box and the list), then a box of figures (depth, width, web, flange, mass, Ix, Iy, Zx, Zy; a dash where the list has none).
   2. **Middle:** a live picture of the member with points 1 and 2 marked. It is drawn by the same code that draws it in the drawing, so what you see is what you get.
   3. **Right:** 3 View, 4 Orientation pictures (greyed for a UB), 5 Section in front or beyond, 6 Points sit on, 7 Break lines at (Both, Start, End, None), 8 Scale 1 : number. A status line, then Reset, Cancel and Place (bottom right, the only solid gold button).
2. **The beam-size rule (your words, items 74 and 75).** The member draws at its real size times DIMSCALE divided by 20. The 20 is a Settings value you can change.
   1. **1:20:** real size. A 310UB32.0 draws 298 mm deep.
   2. **1:50:** 2.5 times. It draws 745 mm deep.
   3. **1:100:** 5 times. It draws 1490 mm deep.
   4. **On paper:** the beam prints 14.9 mm deep on A1 at every one of those scales. That is the point of the rule: it stays readable.
   5. **SBEAM is unchanged.** It already does this.
3. **The warning (never stops the drawing).**
   1. **Wording:** "Beam size: 310UB32.0 is drawn 5 times its real size (1490 mm deep, real 298 mm) because the drawing scale is 1:100. It prints the same as at 1:20."
   2. **Where:** an amber line in the window under Scale (short form, with the factor), the command line when you Place, and one line in the log.
   3. **When:** only when the factor is not 1. At 1:20 the window shows one quiet grey line, "Real size - line scale OK".
   4. **Separate warning, already built:** if LTSCALE is not 10 times the scale, CEMEMBER warns and carries on.
4. **What Place does.** The window hides. You pick point 1 then point 2 (a section: one pick). Escape stops. Press Enter or Space afterwards and the window comes back with your last choices. Reset clears them.
5. **Still to confirm with you (two readings).**
   1. **"dimscale = 120"** in your answer is read as **20** (so 1:20 draws real size).
   2. **Other scales follow the same rule** (1:50 gives 2.5 times). Your reply "yes your readings are correct" (item 75) already confirms both; the picture is shown so you can see it before it ships.
6. **How it will be accepted.** A window is accepted only after a Codex look at the real window in AutoCAD (screenshots kept), never by a test alone. You may still change the button words after you see the real window.
7. **Mistakes of my own and what I did not check.**
   1. The picture is a drawing, not the window. No code exists and nothing has been seen in AutoCAD.
   2. My first picture asked you to choose A or B after you had already ruled B. This revision replaces it with the rule. I also had to change the window's status line in the picture to amber, because at 1:100 the rule always gives a warning.
   3. Gold on dark, no blue (9 Oct ruling).
   4. The 5-times behaviour of SBEAM is from reading the code, not from drawing one in AutoCAD. The new rule's numbers (745 mm, 1490 mm) are arithmetic, not drawn.
   5. The A1 strip is approximate on a screen.

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
3. **Every value from Settings or the section list:** default scale (existing `DefaultScale`), break sizes, layer names (existing), the reference scale for the size rule (new `ReferenceDimscale`, default 20, used by the size factor and the warning; nothing is hard-coded in the window).
4. **The beam-size rule is now a setting (ANSWERED, items 74 and 75):** `structural.cememberReferenceDimscale` = `CeMemberUserSettings.ReferenceDimscale`, **default 20**, shown on the Settings page, pinned through both start-up reads. Size factor = scale / this value. It replaces the planned `SizeReferenceScale` name. Nothing is hard-coded.
5. **Beam-size switch:** `structural.cememberSizeFollowsDimscale` = `SizeFollowsDimscale`, **default ON** (a switch that guards new behaviour ships ON). OFF returns exactly today's real-size drawing at every scale (factor 1).
6. **Not changed:** SBEAM (it keeps its own DIMSCALE / 20 rule and sizes). Its warning line is still the separate optional slice 0.

### 6. B-037: the scale warning

**BEAM-SIZE QUESTION: ANSWERED (29 Oct, TIM_ANSWERS items 74 and 75).** The Option A / Option B text that stood here is superseded. The rule:

1. **Size factor = DIMSCALE / reference scale**, reference scale 20 from Settings (`structural.cememberReferenceDimscale`, default 20). Every dimension of the member (depth, width, web, flange) is multiplied by the factor; break lines keep their own paper-size rule.
2. **Worked for 310UB32.0 (298 deep, 149 wide):** 1:20 = 1 x, 298 mm; 1:50 = 2.5 x, 745 mm; 1:100 = 5 x, 1490 mm. On A1 the beam is 14.9 mm deep at all three (the same printed size is the point of the rule).
3. **SBEAM is unchanged.** CEMEMBER now follows the same rule SBEAM already has.
4. **Tim's words:** "when dimscale = 100 ltscale = 1000, member gets drawn at 5 times its actual size, when dimscale = 120 ltscale = 200, member gets drawn at actual scale, this should be the rule with dim/ltscale". Item 75: "yes your readings are correct" (120 read as 20; other scales follow the same rule).
5. **Consequences for the build:** the preview and Place share one factor (one code path, rule 1); the typed route gets it too. The warning (below) fires whenever the factor is not 1.

**What the code does today (read, not run; this is the state BEFORE the ruling is built).**

1. **CEMEMBER:** scale = DIMSCALE (`CeMemberScale.Resolve`), used only for break-line size (`CeBreakLine`: 1.5 mm overshoot and 2 mm kink on paper times scale). The member is drawn at its list size at every scale. LTSCALE is only compared with 10 x DIMSCALE.
2. **SBEAM:** `SbeamPlacementPlanner.cs:23` and `:87`: `scale = effectiveDimScale / BaseDimScale` with `BaseDimScale = 20.0`; `effectiveDimScale` is the drawing's DIMSCALE (Auto) or 20 or 100 if the old window's 1:20 / 1:100 buttons are chosen (`SteelSectionPickerDialog.ComputeEffectiveDimscale`, `:689-696`). So SBEAM multiplies every dimension by DIMSCALE / 20.
3. **`HatchCommands.ResolveScale`** (`:1650`) reads DIMSCALE and LTSCALE only to pick the hatch pattern scale (and refuses a pair that is not 20/200 or 100/1000 unless "any scale" is on); it has nothing to do with beam size. The 5-times claim is therefore **established for SBEAM** (planner line 23), **not true of CEMEMBER**, and **LTSCALE is not the cause**. I did not run either command.

**The numbers worked (310UB32.0: 298 deep, 149 wide; installed list still says 310UB32).**

1. **DIMSCALE 100, LTSCALE 1000:** SBEAM factor 100 / 20 = 5: 1490 deep, 745 wide; prints 14.9 mm deep on paper at 1:100. CEMEMBER: 298 deep, 149 wide, prints 3.0 mm.
2. **DIMSCALE 20, LTSCALE 200:** SBEAM factor 1: 298 deep, prints 14.9 mm at 1:20. CEMEMBER the same 298 deep.
3. **DIMSCALE 50, LTSCALE 500:** SBEAM factor 2.5: 745 deep. CEMEMBER 298.

**When it fires.**

1. **Size warning:** when the size multiplier is not 1, where multiplier = DIMSCALE (the window's typed scale) / `ReferenceDimscale` (Settings, default 20). It fires on CEMEMBER at every scale other than 20 (the rule is decided). Today's CEMEMBER (before this is built) is always 1, so it never fires; SBEAM would fire at any DIMSCALE other than 20 if slice 0 is approved.
2. **LTSCALE warning (card section 7, 19 Oct "yes as per recommended"):** when LTSCALE is not 10 x the scale. Already built for elevations; add the same check for sections (review Part A item 10: the Beyond section is dashed, so a wrong LTSCALE hides the dashes).
3. **Never blocks (R-27); warn and carry on; one log line each.**

**Exact wording (plain, drawing terms; numbers filled in):**

1. **Size:** "Beam size: 310UB32.0 is drawn 5 times its real size (1490 mm deep, real 298 mm) because the drawing scale is 1:100. It prints the same as at 1:20." (A factor under 1: "drawn 0.5 times its real size ... smaller".) Quiet state in the window: "Real size - line scale OK" (no amber).
2. **LTSCALE (existing text kept):** "The line scale (LTSCALE 100) is not 10 x the drawing scale (1000), so dashed lines may look off. CEMEMBER carried on at 1:100."
3. **Where it prints** (moved here from the picture's warning panel, 29 Oct, because Tim does not read big documents):
   1. **Window:** the status line under Scale turns amber, with the short text "Beam drawn 5 x real size (1490 mm deep, real 298 mm) at 1:100." (bold numbers; it updates as the typed scale changes). Its height is reserved so nothing moves.
   2. **Command line:** the full sentence above, once per run at the first pick ("CEMEMBER: ..."). **Log:** "CEMEMBER size: ..." beside the existing "CEMEMBER scale:" line.
   3. **It never stops the beam being drawn.** At factor 1 (scale 20) the status line stays one quiet grey line and does not turn amber.
   4. **The LTSCALE warning is separate:** if LTSCALE is not 10 x the scale (for example 100 at 1:100), dashed lines may look wrong, and the same status line turns amber and says so.
4. **SBEAM (recommended, needs Tim's yes):** the same sentence on the command line when SBEAM is placed, no size change, switch `structural.sbeamSizeWarning` ON. Without that yes, B-037 covers CEMEMBER only.

### 7. Files to add or change (on the live Structural line; confirm paths at build time)

1. **Add DesignCore:** `CeMemberChoices.cs`, `CeMemberWindowModel.cs`, `CeMemberSizeNote.cs` (the size-warning arithmetic and wording; pure).
2. **Add Structural:** `UI/Dialogs/CeMemberWindow.xaml`, `CeMemberWindow.xaml.cs`, `CeMemberWindow.Preview.cs` (painter), `CeMemberOrientationPicture.cs` (small pictures from `CeMemberSection.Plan`).
3. **Change:** `Commands/CeMemberCommands.cs` (split `Run()` into get-choices and pick-and-draw; window when the switch is ON); `Models/UserSettings.cs` (`UseWindow`, `SizeWarning`, `SizeFollowsDimscale`, `ReferenceDimscale` in `CeMemberUserSettings`); the Settings dialog (four rows); `command-registry.json` (CEMEMBER notes now wrong: "Elevations only", unhide only when Tim accepts); `REGRESSION_LOG.md`.
4. **Not changed:** `CeMemberElevation.cs`, `CeMemberSectionWriter.cs`, `CeMemberLineWriter.cs`, the section list, SBEAM sizes, `CE_SHARED`.

### 8. Tests

1. **Unit (DesignCore.Tests):** window model greying (UB: orientation off; PFC: on; section: Break lines at greys and the Points-on row swaps to the grid); typed scale parse (blank, 0, -5, "abc", "1:50", 20, 100, 37.5); Reset; memory round trip; size note numbers for DIMSCALE 100 / 20 / 50 and the below-1 case; LTSCALE wording unchanged; **parity test:** for every family x view x orientation, the preview's line list equals the line list Place would draw for the same inputs (same planner, so this pins that nobody adds a second routine).
2. **Switch tests:** defaults ON through both `DeserializeSettings` and `DeserializeSettingsTolerant`; with `UseWindow` OFF the typed route is unchanged (existing source guards `CeMemberCommandSourceGuardTests` and `CeMemberRepeatSourceGuardTests` stay green).
3. **Source guards:** window files call only the shared planners; no number or layer name literals; Cancel path draws nothing; no `SetSystemVariable`, regen or zoom in the window (REDO-safe, BUG-861).
4. **Drawing-output (robot, existing review Part A item 5 E1 to E12):** run each case once typed and once through the window with identical choices; assert the same entities (layers, counts, coordinates). Plus the scale cases below.

### 9. Proof list: robot and a Codex look (a window needs a Codex look; RULES 5.7)

1. **S31_cm_window_ub_side (robot, with switch-off control S31off):** type `CEMEMBER`; with `structural.cememberWindow` OFF (set before launch) the command line asks `View [SIde/Top/SEction/Reset]`; with it ON a window opens (window title "CEMEMBER - draw a steel member"). Types in the window: UB, 310UB32.0, Side elevation, Centreline, Both, scale 100, Place; then `0,0` and `3000,0`, Esc. Checks: 6 new entities, 25CONT lines at Y = 149 and -149, 18CONT at Y = 141 and -141 (the E1 values), and the same entity list as the typed twin. Control: switch OFF gives the typed questions and the same 6 entities.
2. **S32_cm_window_enter_repeat:** place one member, Esc, press Enter at Command: window reopens with 310UB32.0, Side, Centreline, Both, 100 preset. Reset clears them.
3. **S33_cm_size_warning:** `DIMSCALE 20`, `LTSCALE 200`: status line is the quiet grey "Real size - line scale OK", no size line on the command line; the member is 298 mm deep (25CONT at Y = 149 and -149). `DIMSCALE 100`, `LTSCALE 1000`: amber size band, the line "CEMEMBER: Beam size: 310UB32.0 is drawn 5 times its real size (1490 mm deep, real 298 mm) ...", and 25CONT at Y = 745 and -745. `DIMSCALE 50`: 2.5 x, Y = 372.5. `LTSCALE 100` at 1:100: amber LTSCALE band as well, member still drawn. Switch-off controls: `cememberSizeWarning` OFF removes the size line; `cememberSizeFollowsDimscale` OFF draws 298 mm (Y = 149) at DIMSCALE 100.
4. **S34_cm_window_cancel:** Cancel and Esc: "CEMEMBER cancelled. Nothing changed.", zero new entities, U has nothing to undo.
5. **C35_cm_window_codex_look (Codex, real AutoCAD, screenshots):** open the window on 1920 x 1032 and on a small laptop screen; check no scrolling layout, gold on dark with no blue, orientation pictures change with PFC, ZC, EA, preview matches the drawn member, band positions fixed, Place in the bottom-right corner. **CE 09 acceptance points (added 29 Oct):** (a) the beam in the live preview is drawn up to about 85 percent of the preview width (not a small sliver in the middle); (b) the properties labels (Depth, Width, Mass, and so on) are at least 11 to 12 px, readable without leaning in.
6. **Acceptance rule (RULES 5.7 and 4.5):** a window is accepted only by a Codex look at the real window in AutoCAD, with screenshots; a unit test or robot case never accepts a window. It is then written "Codex-accepted", never plain accepted. **Tim may still change the button words after he sees the real window** (his word, 29 Oct item 100: show him the real window, not only the picture).
7. **Not provable by a machine:** whether it looks right to a drafter (Codex look or Tim). The beam-size rule is decided (items 74 and 75); the factor arithmetic is machine-provable.

### 10. Slices, estimate and order

1. **Slice 0 (optional, needs Tim's yes): SBEAM size warning line.** About 0.5 day. No size change. Independent of the window.
2. **Slice 1: window shell and member list (B-036a).** Switch, settings rows, `CeMemberChoices`, window with left column, right column controls, Reset/Cancel, greying rules, typed scale; Place returns the choices to `Run()` (split done). About 3 days.
3. **Slice 2: live preview (B-036b).** Painter, preview via the shared planners, orientation pictures, points 1 and 2 and base-point marks, properties box. About 3 days.
4. **Slice 3: Place wiring, repeat, warning band (B-036c, B-037).** Pick loop fed from the window, Enter-to-repeat pre-set, size and LTSCALE band, section LTSCALE check, log lines, regression log, the robot cases above. About 2 days.
5. **Proof and fixes:** robot runs, Codex look, one fix round. About 2 days.
6. **Total:** about 10 working days of building (0.5 more with slice 0), one Opus review per slice. Each slice is a DRAFT PR behind its switch, ON by default.
7. **Order:** after the Civil freeze work (final go Fri 6 Nov, release Mon 9 Nov per the session map). The window and warning are approved (item 100) and the size rule is decided (items 74, 75), so slices 1 to 3 can start straight after the freeze. The size factor (DIMSCALE / `ReferenceDimscale`) goes into slice 1 with the shared planner call so preview and Place agree from the start. If Tim wants the section list correction in first (review question 4), that goes ahead of slice 3 so the window shows decimal names such as 310UB32.0 from the start.

### 11. Open items and what I did not do

1. **Open for Tim:** (A or B is ANSWERED, items 74 and 75; window and warning approved, item 100); SBEAM warning yes or no (slice 0); the four review questions of 23 Oct (Z purlin names, unequal angle long leg flat, C purlin flanges-up top view, corrected section list), because the orientation pictures show them.
2. **Not done:** no code, no build, no test, no AutoCAD, no Codex; the live train after `rel-20261026s` not read; SBEAM's 5x not driven in AutoCAD; properties figures in the picture are from the installed list's 310UB32 row (Iy 4.42, Zy 59.3 are that list's figures, not checked against the supplier).
3. **Records not touched:** no decision file, BUG_CARPARK.md, DESK_LOG.md or register edited. The "Codex owns the window" wording in the 23 Oct review is for its owning session to remove (decision 67).

## Summary (under 100 words)

Plan and picture written for CEMEMBER's window (B-036) and beam-size warning (B-037). Code read: CEMEMBER always draws real size; old SBEAM draws DIMSCALE/20 (5 times at 1:100, normal at 1:20); LTSCALE is not the cause. Warning never blocks, shown in the window, command line and log. Switches `structural.cememberWindow` and size-warning, both ON. Slices ~10 days after the Civil freeze. Nothing built or run. Files: areas\release-v3-colleagues-CEMEMBER_WINDOW_PLAN_29OCT.md and areas\CEMEMBER_WINDOW_MOCK_29OCT.html. Corrected 29 Oct to Tim's ruling: beam draws real size x DIMSCALE / 20 (reference scale on Settings, SBEAM unchanged); picture now shows the rule at 1:20, 1:50 and 1:100.
