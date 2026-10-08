# Structural bug hunt, Day 1 steps 14 to 24 (9 Oct 2026)

Helper: hunt_struc, run 1 (read-only, MAX account, desk plan/03). Written Fri 9 Oct 2026, about 09:00 Melbourne time.

**What was read:** the code of the INSTALLED Structural, release commit `origin/claude/rel-20261009f` (9babe787, Structural 1.0.110). It was read with `git archive` into a scratch folder. Nothing was checked out, built or run. No AutoCAD, no accoreconsole.

**What was walked:** DAY1 page steps 14 to 21 (BT1, R1, beam command 1, C1 and TS1, BTX, CSREOBAR, FSF, FPFC, FEDIT), plus the Settings those commands read and the roof-down order (UX-STRUC-13). Steps 22 to 24 (CESUPPORT, saving results, closing) are Civil or Manager code and belong to the other hunts.

**Already in the carpark, so NOT reported again:** FSF Enter at the first question (BUG-454), FPFC label not seen (BUG-454), the C1 Esc choice (DAY1 gap 13, BUG-450), "Text placed" wording (BUG-449, BUG-450), the CSLEVELCARRY sentence (BUG-453), STS1 raw "eOnLockedLayer" (S-21 LOW 3), the doubled default family (BUG-388, BUG-391), FEDIT picking a strip edge near a pad (S-17 LOW 1).

**How to read each item:** "The code shows" is what I read in the file. "I think" is my judgement and has NOT been seen in AutoCAD. Nothing here is accepted. Every item needs a Codex or Tim check on a copy.

---

## The 15 findings, most valuable first

### HUNT-S-01. FPFC: an auto-numbered pad silently takes the size of the pad you started from (MEDIUM-HIGH)

1. **What the drafter does:** types `FPFC`, presses Enter at "Enter text <PF1>:" (PF1 already exists), presses Enter again at "Use anyway? [Yes/No/Increment] <Increment>:".
2. **The code shows:** CE answers "Auto-incremented to 'PF5'." but looks up the saved size using what was TYPED (PF1), not the new mark (PF5). So PF5 is drawn at PF1's size with no size question (`Services/FoundationService.cs` 1176 to 1183; `PromptElementText` 3958 to 3979 returns the typed text; `CheckDuplicateLabel` 3981 to 4031 makes PF5). This is exactly what Codex saw in W44 ("No size questions are asked"), and the DAY1 page lists it as expected.
3. **Also:** the remembered default stays "PF1" (line 3977 stores the typed text), so every later FPFC asks the "already exists" question again. Answering No ends the command with no sentence at all (lines 4011 and 1177).
4. **Real-world effect:** a drafter wanting a new, bigger pad type gets a new mark drawn at the old size. I think the schedule then shows PF5 at 600 x 600 and nothing warns (not read in the schedule code).
5. **Should do (I think):** a new mark asks its size, with PF1's size offered as the default. The default text moves on to the next free mark.
6. **Test on a copy:** with PF1 placed at 600 x 600, type `FPFC`, Enter, Enter. Right now: PF5 at 600 x 600, no size question. Right: CE asks "Enter X size" for PF5.

### HUNT-S-02. In a rotated UCS, BT1, R1 and FPFC put things in the wrong place (HIGH where rotated UCS is used)

1. **What the drafter does:** works on a skewed building with the UCS rotated to the walls (common on angled lots), then runs BT1, R1 or FPFC.
2. **The code shows:** these commands take the clicked point and write it straight into the drawing without turning it from the UCS to World. BT1: `Commands/BracingCommands.cs` 266 to 275 and `Services/BracingService.cs` 1673. R1 (Point option): `Commands/RafterJoistCommands.cs` 1310 to 1314. FPFC: `Services/FoundationService.cs` 1190 to 1207. FSF's two-point line: 3773 to 3791. The code's OWN comment in C1 says this conversion is needed (`Commands/SupportBlockCommands.cs` 245 to 247), and C1, CSREOBAR and the beam command do it. Structural has no UCS guard of its own; Civil's guard only covers Civil commands (`Modules/Drainage/Services/UcsGuardService.cs`, reads its own commands only).
3. **Real-world effect:** the brace, rafter tag or pad lands away from where you clicked, by the UCS angle and origin. On a World UCS everything is fine, which is why no test has caught it.
4. **I think also:** C1's rotation step hands a World point to AutoCAD's own ROTATE (`SupportBlockCommands.cs` 775), so in a rotated UCS the column may swing about the wrong point. Not proven.
5. **Should do:** every Structural command treats a clicked point the same way C1 does.
6. **Test on a copy:** `UCS`, `Z`, `30`. Run `BT1` and click two wall corners. Right now (expected from code): the brace is not on the clicked corners. Repeat with `FPFC` (pad centre) and `R1` using the Point option.

### HUNT-S-03. Roof-down: columns placed with beam linking off are invisible to the level-below tools (MEDIUM, roof-down order)

1. **What the drafter does:** drafts roof down (UX-STRUC-13): places posts with `C1` or `TS1` on the upper floor, then moves to the footings.
2. **The code shows:** the only place CE looks for "posts coming down" is the beam-to-support links (`Services/FoundationService.LoadPath.cs` 185 to 262, `CollectLoadPathPosts`). The level-above markers (`FoundationService.LoadTrace.cs` 57) and the footing grips (`FoundationService.Grips.cs` 104) use the same list. Beam linking is OFF in Tim's Settings: C1 prints "[CE] Beam linking is switched off in Settings, so the support is not linked." (`SupportBlockCommands.cs` 385 to 404). The code comment itself admits "A standalone column with no beam attached to it ... is NOT found".
3. **Real-world effect:** with today's settings, every post placed on Day 1 carries nothing down. CSLOADPATH says "No beam-end or post supports found to check", and FPFC's "Nothing needs attention" never knows a post is waiting above.
4. **Should do (I think):** read C1, TS1, DS1 and C2 support blocks directly as posts, linked or not. This is Tim's call against the roof-down card (`04_REFERENCE/ux-plan/cards/STRUC-ROOF-DOWN-PRODUCTION_CARD_2026-10-04.md`).
5. **Test on a copy:** with linking off, place a `C1` on a footing plan away from any footing, type `CSLOADPATH`. Right now (from code): "No beam-end or post supports found to check." Right: the post is listed as having nothing under it.

### HUNT-S-04. FEDIT: Esc at the "new type" question still saves the edit (MEDIUM)

1. **What the drafter does:** `FEDIT`, picks a pad, types a new X size, answers Yes at "Change footing type?", then has second thoughts and presses Esc at "Select new type [ExternalBeam/...]".
2. **The code shows:** Esc at that one question is not treated as cancel. The code carries on, renames, resizes, saves and redraws (`Services/FoundationService.cs` 1908 to 1920, then 1924 to 1970). Every other question in FEDIT stops on Esc.
3. **Real-world effect:** Esc means "stop, change nothing" everywhere else in AutoCAD. Here the new size goes on the drawing and the schedule anyway.
4. **Should do:** Esc there ends FEDIT with nothing changed, like the other questions.
5. **Test on a copy:** `FEDIT` on PF1, X size 700, Yes, then Esc. Right now (from code): the pad becomes 700 wide. Right: still 600, and the line says nothing changed.

### HUNT-S-05. FSF: picking an existing footing's outline as the centre line may lose the new strip at once (MEDIUM, "I think")

1. **What the drafter does:** at "Select centerline (Line/Polyline/Arc)" clicks a line on STRIP FOOTINGS. With the Enter route broken (BUG-454), picking a line is the only way.
2. **The code shows:** FSF accepts any line, polyline or arc, with no check that it is one of CE's own outline lines or another footing's line, and moves it to the footing layer (`Services/FoundationService.cs` 3744 to 3767). CE's footing outlines are exploded into exactly those shapes (2909 to 2924). Each redraw erases every outline line it remembers (3525 to 3555). The redraw runs straight after FSF (1332).
3. **I think:** the new strip's centre line is erased by its own redraw, so the strip shows as "line erased" or does not appear. Not seen in AutoCAD.
4. **Should do:** refuse CE's outline lines and other footings' lines with one plain sentence ("That is the outline of footing SF2. Pick or draw a centre line.").
5. **Test on a copy:** draw one FSF strip. Run `FSF` again and pick one of the first strip's long outline edges. Look for a missing strip or a warning.

### HUNT-S-06. R1, BT1, C1 and TS1 ignore metre, centimetre and inch drawings (MEDIUM)

1. **The code shows:** the footing commands convert or warn for non-millimetre drawings (S-7, INT-026), but these four do not look at the drawing's units at all.
2. **R1:** every distance is fixed millimetres: "too short" below 25, a 300 depth, the outer width plus 200 (`Commands/RafterJoistCommands.cs` 27 to 28, 315 to 319, 597). In a metre drawing a 4.2 m bay is 4.2 units, so R1 says "Member length is too short to place the block." That sentence is untrue.
3. **C1 / TS1:** the column block goes in at scale 1 with millimetre offsets (`Commands/SupportBlockCommands.cs` 65 to 69, 290). In a metre drawing an 89 SHS column comes out 89 m wide.
4. **BT1:** only the Enter length is converted (BUG-433). The block itself goes in at scale 1 (`Services/BracingService.cs` 1673 to 1677).
5. **Should do:** the same one-line convert-or-hold rule the footing commands use.
6. **Test on a copy:** new drawing, `UNITS` set to Metres, draw two lines 4.2 apart, `R1` with the Point option. Right now (from code): "Member length is too short to place the block."

### HUNT-S-07. On a layout tab or during REFEDIT, R1, BT1, C1, TS1, BTX, FSF and FPFC still write into Model space (MEDIUM)

1. **The code shows:** these commands always write into Model space and never check REFEDIT or which space you are in. R1: `RafterJoistCommands.cs` 202. BT1: `BracingService.cs` 1672. C1 / TS1: `SupportBlockCommands.cs` 285. BTX: `BeamTextConvertCommands.cs` 103 and 155. FSF: `FoundationService.cs` 3787. FPFC: 3806. The beam command refuses with a plain line ("Beam commands require model space outside REFEDIT", `Services/ConnectedDesign/Host/BeamCommandAutoCadContext.cs` 52 to 56), and so does CSREOBAR (`Services/ReoBarService.cs` 88 to 92).
2. **Worst case, BTX:** text picked on a layout is erased there and re-made in Model space at the layout's coordinates. It vanishes from the sheet.
3. **Others:** a C1 or pad typed on a layout by mistake lands in Model space near the origin, and nothing shows where you clicked.
4. **Should do:** the same refusal line as the beam command, for every Day 1 command.
5. **Test on a copy:** open a layout tab (not inside a viewport). Type `C1` and click. Right now (from code): nothing appears on the layout. Then `BTX` on a layout text: the text disappears from the layout.

### HUNT-S-08. Locked layers: BT1, C1, TS1 and BTX have no locked-layer check (MEDIUM, symptom "I think")

1. **The code shows:** CSREOBAR uses CE's shared check and its plain line "Layer X is locked, so CE drew no ... Unlock it and try again." (`LayerService.cs` 219 to 236; `ReoBarService.cs` 150 to 155). BT1, C1, TS1 and BTX do not call it.
2. **BT1:** after the brace is added, the flip question opens it for changing (`BracingService.cs` 1748 and 1762), and BT1 has no error catch (`BracingCommands.cs` 255 to 361 has only a finally).
3. **I think:** with WALL BRACING TYPE BT1 locked, answering Yes or pressing Esc at "Toggle flip?" ends in an AutoCAD error and leaves the brace in place.
4. **BTX:** it opens each picked text for changing with no catch (`BeamTextConvertCommands.cs` 102 and 154). I think text on a locked layer ends in an error box. Nothing is converted, so the drawing is safe.
5. **C1 / TS1:** the rotation uses AutoCAD's own ROTATE (`SupportBlockCommands.cs` 775). I think ROTATE skips a column on a locked SUPPORT COLUMN layer and the column stays unrotated, with no CE sentence.
6. **Should do:** check first, say the one plain line, draw nothing. Never unlock (native protection rule).
7. **Test on a copy:** lock WALL BRACING TYPE BT1, run `BT1`, answer Yes at the flip question. Then lock 25TEXT and `BTX` a beam text there. Write down exactly what appears.

### HUNT-S-09. The DAY1 page is wrong about R1: it needs FOUR picks plus a tag, and Enter before each pick (LOW code, HIGH for today's run)

1. **The code shows:** R1 asks "Pick LEFT beam or wall", "Pick RIGHT beam or wall", "Pick TOP/near side", "Pick BOTTOM/far side", then "Enter the tag text <R1>:" (`Commands/RafterJoistCommands.cs` 105 to 155, 541).
2. **The DAY1 page says** "It needs three objects and draws nothing without the third." Tim will meet a fourth pick and a tag question that the page does not mention.
3. **Each pick is a question first** ("[Object/Point] <Object>"): press Enter, THEN click "Select object:" (`RafterJoistCommands.cs` 1281 to 1318). Codex W44 had to do exactly that. That is 8 actions for one rafter tag.
4. **Should do:** correct DAY1 step 14 today. Later, let a click at the first question pick the object straight away (a design question for Tim).

### HUNT-S-10. R1: Esc at "Select object:" asks the same question again (LOW-MEDIUM)

1. **The code shows:** if the first "Select object:" is cancelled, R1 falls through to a second "Select object:" (`Commands/RafterJoistCommands.cs` 1318 to 1339). Only a second Esc ends the command.
2. **Real-world effect:** Esc seems not to work, the drafter presses it again, and nothing says R1 stopped.
3. **Should do:** one Esc ends R1, layer and settings put back (they are, in the finally block).
4. **Test on a copy:** `R1`, Enter, Esc at "Select object:". Right now (from code): "Select object:" appears again.

### HUNT-S-11. FEDIT: renaming a pad to a mark that already exists silently overwrites that mark's saved size (MEDIUM)

1. **The code shows:** FEDIT takes any new label with no "already exists" question (FPFC has one) (`Services/FoundationService.cs` 1827 to 1833). It then writes this pad's size into the saved size for the NEW mark (1957 to 1965).
2. **Real-world effect:** FEDIT on PF5 (700 x 600), rename to PF1. The saved PF1 size becomes 700 x 600. Every later FPFC PF1 is drawn 700 x 600, while the PF1 pads already on the plan stay 600 x 600.
3. **Should do:** ask "PF1 already exists at 600 x 600. Use PF1's size, keep this pad's size for PF1, or pick another mark?", then record the answer.
4. **Test on a copy:** PF1 at 600 x 600 and PF5 at 700 x 600. `FEDIT` PF5, rename to PF1, Enter through. Then `FPFC`, type PF1, Yes. Right now (from code): the new PF1 is 700 x 600.

### HUNT-S-12. Footing sizes: a fixed 10 m limit refuses the value, and the 3 m warning and 600 pad default are fixed in code (LOW-MEDIUM, Settings-first and no-hard-blocks rules)

1. **The code shows:** any size, width or depth over 10000 is refused with "Value must be 10000 or less." and the question repeats (`Services/FoundationService.cs` 4033, 4150 to 4162). That is a hard block, and the no-hard-blocks rule (R-27) allows only two.
2. **Also fixed in code:** the "exceeds typical range" warning at 3000 mm (4034, 4137) and the 600 pad default (36). The strip width default does come from Settings (31), so pads and strips follow different rules.
3. **Should do:** all three as Settings values. Over the limit = warn and record, never refuse (R-00, R-27).

### HUNT-S-13. BT1 ignores the Settings "Longest wall brace (mm)" that AB and BB obey (LOW, Tim's call)

1. **The code shows:** AB and BB check the brace length against Settings and warn (INT-066 C) (`Commands/BracingCommands.cs` 49 to 59 and about 170). BT1 has no such check (296 to 302).
2. **Tim's call:** does a bracing truss fall under the wall-brace limit? If yes, BT1 should warn like AB. If no, nothing to do. Never decide this without Tim.

### HUNT-S-14. Sentences on the command line that are code words, not plain English (LOW)

1. **R1, every run:** "[R1] Direction=Horizontal angle=0deg (dynamic=0, residual-rotate=0)." and "[R1] Inserted 'RAFTER-JOISTV2' on layer 'RAFTERS', tagged R1." (`RafterJoistCommands.cs` 227 to 228). The first line is a debug line printed even with debug off.
2. **BT1:** "Flip toggled to 1." (`BracingService.cs` 1769). The 0 or 1 means nothing to a drafter. Say "Brace flipped to the other side."
3. **C1 / TS1:** raw AutoCAD error words: "[CE_STRUC_SUITE] Rotation fallback: <error>", "Rotation failed: <error>" and "C1 insert failed: <error>" (`SupportBlockCommands.cs` 312, 816, 857). Same family as the STS1 item already filed.
4. **FEDIT:** "Select new type [ExternalBeam/InternalBeam/Thickening/StripFooting/PadFooting]" (`FoundationService.cs` 1901). Better: External beam / Internal beam / Thickening / Strip footing / Pad footing.
5. **Beam command:** "Beam placed, but its post-write update needs review." and "Drawing evidence needs review." (`Services/ConnectedDesign/Host/BeamCommandAutoCadRoute.cs` 400 and 408). These do not say what to do.

### HUNT-S-15. BTX drops the text's own colour (LOW)

1. **The code shows:** the new text copies layer, height, rotation and style only (`Commands/BeamTextConvertCommands.cs` 112 to 121 and 160 to 171). A colour or linetype set on the text itself (not By Layer), the width factor and the slant are lost. A missing height becomes a fixed 250.
2. **Real-world effect:** a beam mark coloured by hand for a plot pen comes back By Layer and plots differently.
3. **Test on a copy:** set one beam text to colour 1 (red) in Properties, `BTX` it. Right now (from code): the new MTEXT is By Layer.

---

## Roof-down order (UX-STRUC-13), what the Day 1 commands do

1. **Roof (BT1, R1):** they draw and tag only. Nothing they draw is read by any level-below tool. The roof point-load carry-down is built but called by no command (roof-down card, line 64: "the roof point loads are not carried down").
2. **Upper floors (beam 1, C1, TS1):** beams carry down only through beam links. Columns carry down only when linked to a beam, and linking is off (HUNT-S-03).
3. **Ground and footings (CSREOBAR, FSF, FPFC, FEDIT):** they work on their own plan. The level-above markers stay off by default (`LoadPath.TraceFromLevelAbove = false`).
4. **So today:** the roof-down order is a drafting habit, not something CE carries from level to level. That matches the card's "Missing" list. HUNT-S-03 is the one gap that defeats even the built part.

---

## Causes found for bugs ALREADY in the carpark (not counted above)

1. **BUG-454, FPFC label not seen.** The code shows the pad label is 2.5 x DIMSCALE tall in a millimetre drawing (`FoundationService.cs` 5068 to 5071, 2973). In a model-space drawing with DIMSCALE 1 and the annotation scale set instead, the label is 2.5 mm tall and invisible at a 1500 zoom. Metre drawings already fall back to the annotation scale (5077 to 5085); millimetre drawings do not. I have not read DIMSCALE in the test drawing. Next Codex check: `LIST` the new PF label and read its height.
2. **BUG-454, FSF Enter.** I agree with the filed reading: the "press Enter for 2-point line" question has no Enter allowed (`FoundationService.cs` 3744 to 3749, no AllowNone).

---

## What I did NOT check

1. **Nothing was run.** No AutoCAD, no tests, no build. Every symptom is read from code.
2. **The beam command (1)** was read only at its entry and result sentences. Its connected design route is large and handles UCS, model space and REFEDIT. I did not trace its prompts or Undo.
3. **CSREOBAR** looked sound (REFEDIT, locked layer, units and Undo are all handled). I did not trace the bar schedule refresh.
4. **C1's label step** inside CeTextService was not traced for UCS.
5. **Next version.** The Civil and Manager next commit (rel-20261009g, 319ba688) was not read; the job names no Structural "next".
