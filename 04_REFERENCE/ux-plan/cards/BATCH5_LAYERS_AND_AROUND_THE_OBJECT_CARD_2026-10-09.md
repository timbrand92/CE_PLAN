**Code read on Civil rel-20261009e 1200744d** (installed Civil 3.0.40, read from the bundle DLL product version on Fri 9 Oct about 08:42; Structural parts
on rel-20261009f 9babe787 = installed Structural 1.0.110). Read with `git show` / `git grep` on those commits, no checkout; never master.

# Batch 5 card: layers, and what is around a CE object (right-click, Ctrl+1, the other discipline), 9 Oct 2026

**Status: DRAFT. Not approved by Tim.** Under INT-073 (Tim, Fri 9 Oct about 05:50: "the builds should not be hung on me answering
questions"), extended by the desk at 08:05 to every batch card with recommended answers, builders MAY build this card on the
**Recommended** answers below, as DRAFT PRs, tests red first, every new behaviour behind a Settings value and OFF where it changes what a
drafter sees, nothing retired, no old command removed, locked layers / Xref / REFEDIT protection unchanged. Tim's answer by number in
`TIM_BATCH_QUESTIONS_6_7_2026-10-09.md` (questions 1 to 8) replaces a recommended default in a follow-up. **Engineering numbers are not
covered** (the zone of influence angle, question 8): they stay blank and CE says "not set" until Tim types them (RULES 12, R-00).
Written by design lane run 8 (headless, Opus), Fri 9 Oct 2026 about 09:00 Melbourne (PC clock). Read-only on plugin code. Code lines are
not proof of what installed Civil 3.0.40 does on screen.
**Numbering:** this is **Batch 5** in `REVIEW_BATCHES_2026-10-09.md` ("layers and around the object"), the first Civil pits/pipes batch
after Day 1. The question file calls it "card 6" (the sixth batch carded): same thing.

**House rules from Tim's answers of 9 Oct (INT-075), apply to everything below:**
1. **No blue.** CE's colours are gold, black and white / grey. Nothing in any window this card touches uses blue (supersedes the 4 Sep deep
   blue #1E5AA8). Drawing colours (layer colours) are the office layer standard, not a theme.
2. **Plain name and command name together during the transition:** wherever a plain-English name is shown (right-click items, ribbon,
   tooltips, window titles, help), show the AutoCAD-style name beside it, e.g. "Edit pit (CDEDIT)", behind a Settings switch "Show AutoCAD
   command names", default ON. The plain name stays the main name.
3. Builders build on the recommended answers without waiting; Tim's later answer changes the default.

**Items (8):** UX-LYR-01, UX-LYR-02, UX-LYR-03, UX-LYR-04, UX-RCLICK-01, UX-PROP-01, UX-XDISC-01, UX-XDISC-04.
**Commands touched:** every Civil command that makes a layer (CD, PIT, CDEDIT/PIPEEDIT/PITEDIT, CDRG, CDSLAB, CDSPOONDRAIN, CDPAVE, CDKERB,
the tank and source tools); CDMANAGER (Drawing Standards window, Layer Colours tab); CDCHECK and the Checks palette (Batch 2); AutoCAD's
right-click menu on CE pits, pipes and labels; AutoCAD's Properties palette (Ctrl+1) and CE's Civil Properties palette (CDINSPECTOR);
Structural footings (FPFC, FSF, BP, CSPIER) and Civil downpipes (DP) as seen by the other discipline.

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`: "Layers and colour" 26 Sep 12:18 (UX-LYR-01..04), "Admin route,
right-click, Ctrl+1, startup" 26 Sep 12:03 (UX-RCLICK-01, UX-PROP-01), "Civil and Structural on the same job" 26 Sep 19:06 (UX-XDISC-01..04),
"Finding and moving around the network" 27 Sep 01:14 (UX-NAV-04: right-click = run); `V3_UX_PLAN.md` section 1 items 18, 21, 22;
`decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` INT-073, INT-074 items 3 and 4 (Tidy labels CDTIDYLABELS), INT-075 (no blue, transition
names). Related: UX-STD-05 (safe fixes pre-ticked), UX-STD-06 (selection unchanged), Batch 2 card (the Checks palette), Batch 1 card (Tidy
labels).
**Related cards (do not build twice):** `BATCH1_DAY1_PLAN_LABELS_CARD_2026-10-09.md` (CDTIDYLABELS: this card only puts it on the right-click
menu); `BATCH2_CHECKING_THE_NETWORK_CARD_2026-10-09.md` (the Checks palette and its rows: this card only adds two kinds of row);
`UX-PIPE-01-03-07_CARD_2026-09-29.md`; `S4_FOUNDATIONS_WALLS_CARD_2026-09-30.md` (footing depths come from there).

**Who does what (INT-073: windows stay Codex's):**
1. **Claude (behaviour):** the one layer-maker rule (made only if missing, never recoloured, never made current); the wrong-layer and
   wrong-colour findings and their safe fixes; ByLayer on every drawn object; the New / Existing / To be removed status and its layers and
   "TO BE REMOVED" text; the right-click items and what each does; the Ctrl+1 values behaviour (and the AutoCAD 2027 native module part);
   the pipe-near-footing and downpipe-near-post checks; Settings values; tests.
2. **Codex (windows):** the Status field in Edit Pit and Edit Pipe; the CDMANAGER Layer tab additions (layer names next to colours); the
   Civil Properties palette's editable values (its look, keys, the rows); the Checks palette rows' look; any Settings page rows' look; and
   every AutoCAD acceptance run (right-click menus and Ctrl+1 need the mouse: the AutoCAD driver cannot right-click, DRIVER_RUN20 item 81).

---

## Card 5.1 — UX-LYR-01: CE objects go on office layers, made if missing; the current layer never changes

1. **Tim ruled (26 Sep 12:18):** "Office layers, auto-made". Each CE object type goes on its office layer from Settings; CE creates a missing
   layer with the office colour and linetype; the current layer is never changed.
2. **Today:**
   - **Names are fixed in the code, not Settings:** pipes by type (`Services/LayerService.cs:47-120`: STORMWATER PIPE 150 DASHED, STORMWATER
     UPVC CHARGED PIPE 10, STORMWATER SUSPENDED PIPE 211, STORMWATER RISING MAIN 70, existing EX DRAIN HATCH 61 PHANTOM, mline DRAINAGE /
     EX STORMWATER) and everything else as constants (`LayerService.cs:127-260`: 25TEXT, 20TEXT, ARROW, STORMWATER PIT, STORMWATER PIT
     LABEL, DOWNPIPES, WATER TANK, TRENCH GRATE, AGI DRAIN, SLAB PERIMETER, HATCH 21, KERB, SPOON DRAIN ...).
   - **Colours can be changed** per layer in CDMANAGER > Layer Colours (`Commands/LayerManagerCommand.cs:12`,
     `Models/UserSettings.cs:1398-1410`, read by `LayerService.cs:329-335`). Names cannot.
   - **A missing layer is made with the office colour and linetype** (`LayerService.cs:454-475`). **But a second layer-maker** in
     `Services/BlockService.cs:892, 1377-1398` (block placement with a preview) makes a missing layer **colour 7** whatever the office
     colour is: two ways to make one layer (design rule 1).
   - **An existing, unlocked layer is recoloured and re-linetyped to CE's every time** a command makes sure of it
     (`LayerService.cs:439-451`); a locked one is left alone with a log line only (`433-437`). This once painted the whole STORMWATER PIPE
     layer white (BUG-135, comment at `Commands/NativePipeObjectCommands.cs:90-94`). Structural already stopped this for its reo layers
     (DRIVER_RUN11 step 2: "Recoloured 35CONT stays colour 5").
   - **Current layer:** CD and Edit Pipe remember the drafter's layer and put it back (`Services/OsnapService.cs:152-178, 184-200`); the Pit
     Schedule repairs a lost current layer (`Services/CurrentLayerGuard.cs`, BUG-387). No other Civil command was found setting the current
     layer. Structural has its own open case: **BUG-434** (C1 / TS1 leave the current layer changed, Codex W21, W26, W28): tracked there,
     not in this card.
3. **What works:** missing layers made; the current layer kept by CD and Edit Pipe; locked layers never unlocked.
4. **Wrong or missing:** names not on Settings; existing layers recoloured; the colour-7 second route.
5. **Classification: MODIFY.**
6. **Proposed:**
   - **One layer-maker:** every Civil route (including `BlockService`) uses the one `LayerService` rule. A missing layer gets the office
     colour, linetype (and plot setting) from Settings; an **existing layer is never changed** (colour, linetype, on/off, freeze, lock,
     plot). If it differs from the office standard, that is a Checks row (card 5.2), never a silent change. Settings switch "CE may
     recolour existing layers" (default **ON = today's behaviour** until Codex accepts the new rule, INT-073; Tim's answer to question 1
     flips it to OFF).
   - **Layer names become Settings values** (Civil Settings > Drawing standards > Layers), seeded with today's names exactly, so no
     drawing changes. CDMANAGER's Layer Colours tab shows the name beside the colour (Codex).
   - Current layer: unchanged rule, written down as a test for every placing command (CLAYER before = CLAYER after, also after Esc).
7. **Cancel / Esc / Undo:** a layer made by a command is part of that command's one U. Esc before anything is drawn makes no layer.
8. **Native protection:** a locked, frozen or Xref-dependent layer is never touched; a locked target layer refuses in the command's own
   words (as today, BUG-364 style).

## Card 5.2 — UX-LYR-02: a CE object on the wrong layer is a pre-ticked safe fix in Checks

1. **Tim ruled (26 Sep 12:18):** "Flag in checks". Shown in Project Checks as a safe drafting fix, pre-ticked (UX-STD-05); never moved
   silently.
2. **Today:**
   - **No wrong-layer finding** in CDCHECK, CDRULES or What CE Found (no rule found in `Rules/`). CEHEALTH (now Manager's) only says a
     missing layer "will be auto-created on next use, but existing entities may be on the wrong layer" (`Commands/HealthCheckCommand.cs:182-188`).
   - **Edit Pipe refuses** when a pipe's label has been moved off the pipe-text layer: "this pipe's label has been moved off the pipe-text
     layer ... Put the label back on the pipe-text layer, then edit the pipe again." (`Rules/PipeEditRefusal.cs:60, 93-94`, raised at
     `Services/LinkService.Registration.cs:2061-2063`). So the drafter meets the problem only as a refusal.
3. **Classification: MISSING** (the finding) / **KEEP** (Edit Pipe's refusal until the fix exists; then it points to the Checks row).
4. **Proposed:**
   - Two new kinds of Checks row (the Checks palette is Batch 2's; Codex owns its look):
     a) **"On the wrong layer":** a CE pit, pipe, CE label, IL text or cover text whose layer is not its office layer. Example row: "P3-P4
        label is on layer 0; office layer 25TEXT. Fix: move it back." **Pre-ticked.**
     b) **"Layer differs from the office standard":** an office layer whose colour or linetype differs (only when "CE may recolour
        existing layers" is OFF, card 5.1). Example: "STORMWATER PIPE is colour 5; office colour 150. Fix: set the office colour."
        **Not pre-ticked** (the drafter may have done it on purpose for this job). Recommended; question 1.
   - Only CE objects are looked at (found through CE's own records), never ordinary linework.
   - A row on a locked layer shows "layer locked: unlock it to fix" and its Fix is greyed (never unlocks).
   - Edit Pipe's refusal gains one line: "Checks lists it: Fix moves the label back."
5. **Cancel / Esc / Undo:** Fix all ticked = **one U**. Nothing moves until Fix is pressed. Ignore follows Batch 2 (comes back when the
   object changes).

## Card 5.3 — UX-LYR-03: colour ByLayer always; preview colour only until Apply

1. **Tim ruled (26 Sep 12:18):** "ByLayer always". Plot styles and the office pen table control output; previews and proposals use a
   temporary preview colour only until Apply.
2. **Today:** most CE objects are drawn ByLayer (no colour set on the object). **Found with a colour fixed on the object instead:** the
   spoon drain outline and its hatch (`Services/SlabService.cs:2261, 2276`), the raingarden outline and hatch
   (`Services/SourcePlacementService.cs:876, 897`), the grade warning marker (`Services/GradeNoteMarker.cs:254`, a non-plotting marker on
   its own layer). Arrows are ByBlock inside their block (`Services/ArrowService.cs:434, 442`), which is ByLayer once placed. Previews draw
   in their own colours (several, set in the code; not read one by one here).
3. **Classification: MODIFY** (small).
4. **Proposed:** the spoon drain and raingarden objects are drawn ByLayer (their layers already carry the same colours, so nothing looks
   different on screen or on paper); the grade marker stays as it is (screen-only, never plotted). A test walks every CE drawing routine
   and fails on any object written with a fixed colour, except non-plotting markers. Preview colours: unchanged, never written into the
   drawing (each preview is temporary until Apply). No blue in any CE window (house rule 1); layer colours are the office standard.
5. **Undo / Esc:** unchanged.

## Card 5.4 — UX-LYR-04: existing greyed on EX layers; demolished dashed on DEMO with "TO BE REMOVED"

1. **Tim ruled (26 Sep 12:18):** "Office layers + linetypes". Existing greyed on EX layers; demolished dashed on a DEMO layer with "TO BE
   REMOVED" text; all from Settings.
2. **Today:**
   - **Existing pipes:** the CD pipe type "Existing" draws on **EX DRAIN HATCH** (colour 61, PHANTOM) with the mline on **EX STORMWATER**
     (colour 9, HIDDEN) (`LayerService.cs:106-115`, recognised in `Services/PipeTruthResolverService.cs:740-741`). Colour 61 is a green,
     not grey.
   - **Existing pits:** no existing status at all (CDIMPORTXCIVIL only asks which pit numbers to leave out of its comparison,
     `Commands/LinkCommands.ImportXcivil.cs:509-512`).
   - **Demolished:** nothing in Civil ("TO BE REMOVED" and a DEMO layer appear nowhere in the code).
   - **The office typical file already has** existing and demolished layers for Structural: WALLS EXISTING, WALLS DEMOLISH, FOOTINGS
     EXISTING, EXISTING WALL, EXISTING WALL HATCH (26 Mar snapshot,
     `Modules/Structural/Docs/CEMARKUP_Template/ce_typical_blocks_layers_schedules_notes.snapshot.json`).
3. **Classification: MISSING** (status for pits, demolished) / **MODIFY** (existing pipes onto the Settings rule).
4. **Proposed:**
   - A **Status** on every CE pit and pipe: **New** (default), **Existing**, **To be removed**. Set in Edit Pit / Edit Pipe (a field,
     Codex) and as a CD / PIT command-line option: "Status [New/Existing/To be removed] <New>:". The CD pipe type "Existing" keeps working
     and means Status Existing.
   - **Layers by status, all Settings values** (question 3). Recommended seeds: existing pipes keep today's EX DRAIN HATCH / EX STORMWATER;
     existing pits "EX STORMWATER PIT" (grey, colour 8); to be removed "STORMWATER DEMOLISH" (colour 8, DASHED), following the typical
     file's "WALLS DEMOLISH" pattern. These two new names are the desk's proposal, not office names: Tim confirms.
   - **"TO BE REMOVED"** text (Settings wording) placed beside a removed pit or along a removed pipe at the office label spot, on the
     pipe-text layer, tidied like any CE label (Batch 1 CDTIDYLABELS).
   - **Pit Schedule and checks:** existing and to-be-removed pits are **left out of the Pit Schedule** (new work only) and existing pits
     still count in the network checks (water still flows through them); to-be-removed items are left out of the checks (question 4).
   - Old drawings: nothing changes by itself; an object is New until someone sets its status.
5. **Cancel / Esc / Undo:** changing the status of one or many objects = one U (layer, linetype, text and schedule together).
6. **Native protection:** a status change on a locked layer refuses with the layer named; nothing unlocked.

## Card 5.5 — UX-RCLICK-01: right-click on a CE object shows a short CE group

1. **Tim ruled (26 Sep 12:03):** "Short CE group on top". Three to five CE actions for that object (e.g. Edit, Connect, Relabel, Show in
   schedule) at the top, AutoCAD's normal menu underneath. Beams and columns the same. UX-NAV-04 (27 Sep): right-click offers "Select this
   run" and "Select whole network".
2. **Today (three right-click groups registered at start, `PluginInitialization.cs:182-185`):**
   - **On a recorded CE pit or pipe:** "CE: Select this run", "CE: Select whole network"
     (`Services/CivilNetworkSelectContextMenuService.cs:14-21, 36-50`); hidden for ordinary blocks and polylines once the drawing's CE
     record is loaded (`171-176`).
   - **On CE labels (text and blocks):** "CE Civil: Slide along pipe", "CE Civil: Move closer to or farther from pipe", "CE Civil: Flip
     side", "CE Civil: Reset position" (`Services/PipeAttachmentContextMenuService.cs:70-87`).
   - **"CE: Edit Pit..." / "CE: Edit Pipe..."** exists but is switched off with the old compound selection suite (`if (false)` at
     `PluginInitialization.cs:139-146`; `Services/CompoundContextMenuService.cs:30-31`). It had no check that the object was CE's.
   - **Codex 30 Sep (SWEEPC1 item 19):** right-click on a selected CE pipe showed AutoCAD's own items and **no CE items**. Not re-checked on
     3.0.40 (a Codex task; it needs the mouse).
   - Where AutoCAD places an add-in's items in its menu is AutoCAD's business (RULES 12.5); Codex's screenshot settles "on top".
3. **What works:** selection items; label nudges; the "only on CE objects" filter.
4. **Wrong or missing:** Edit, Tidy labels, Show in Pit Schedule; one consistent "CE" heading; the transition names.
5. **Classification: MODIFY.**
6. **Proposed (question 5):**
   - **Pit:** Edit pit (CDEDIT) · Show in Pit Schedule (PITSCHEDULE) · Tidy labels (CDTIDYLABELS) · Select this run · Select whole network.
   - **Pipe:** Edit pipe (CDEDIT) · Tidy labels (CDTIDYLABELS) · Select this run · Select whole network.
   - **CE label:** today's four, renamed to the same style: Slide along pipe · Move closer or farther · Flip side · Reset position.
   - All shown only on a recorded CE object (today's filter, extended to the Edit items); several CE objects selected: Edit opens the
     batch editor as CDEDIT does today; the drafter's selection is never changed (UX-STD-06).
   - Command names in brackets follow the "Show AutoCAD command names" switch (house rule 2).
   - Beams and columns: Structural, same pattern, in the Structural framing batch (not here).
7. **Cancel / Esc / Undo:** a right-click item runs the same command as typing it: same prompts, same Esc, same one U. The menu itself
   writes nothing.
8. **Discovery:** Start Here tour page "Right-click a pit"; the first-use tip of PIT and CD mentions it once.

## Card 5.6 — UX-PROP-01: Ctrl+1 shows CE values, editable, with the same rules and one Undo

1. **Tim ruled (26 Sep 12:03):** "CE values, editable". A CE section shows the key values (e.g. size, grade, ILs, material); edits go
   through the same rules, preview where needed and one Undo, as the window.
2. **Today:**
   - **AutoCAD's Properties (Ctrl+1) shows no CE section.** Codex PASS9 item 36: Ctrl+1 on a CE pipe opened AutoCAD's own Properties;
     Codex W20-03: Ctrl+1 on a pit label printed "_propertiesclose" (it closed the open palette). A CE section in Ctrl+1 needs work in the
     AutoCAD 2027 native module (the C7 audit, `docs/workflows/C7_STEP1_AUDIT_2026-09-15.md` lines 28 and 62, "C7-OPM": without it the palette
     shows the generic pipe with no fields).
   - **CE's own Civil Properties palette** (CDINSPECTOR, `Commands/InspectorCommand.cs:13`) shows the selected pit or pipe and has an Edit
     button that opens the editor for exactly that object or refuses ("That object is gone; select again.",
     `Rules/InspectorEditDispatchPolicy.cs`). Values are not edited in the palette itself.
   - Not checked: what happens today when a drafter changes a pit block's own width in AutoCAD's Properties (a Codex task, before any build).
3. **Classification: MISSING** (Ctrl+1 section) / **MODIFY** (Civil Properties palette).
4. **Proposed (question 6):**
   - **Step 1, all AutoCAD versions:** the Civil Properties palette gets editable values for the key fields (pipe: size, material, grade or
     the two ILs; pit: number, size, cover level, type). Typing a value runs the same rule as the Edit window, shows the preview in the
     drawing, and Enter applies it as **one U**; Esc puts the value back. Codex builds the palette rows; Claude the rules.
   - **Step 2, AutoCAD 2027 first:** a "CE" section in AutoCAD's own Ctrl+1 for CE pipes (the C7-OPM native work), same values, same
     rules, one U; 2022 to 2024 keep step 1 (UX-MIX: greyed with "needs AutoCAD 2027" where shown).
   - Ctrl+1 never lets a typed value bypass CE's checks; a value CE cannot accept is refused in one plain line.
5. **Cancel / Esc / Undo:** as above.

## Card 5.7 — UX-XDISC-01: a pipe inside a footing's zone of influence is flagged with a suggestion

1. **Tim ruled (26 Sep 19:06):** "Warn + suggest". Checks flag a pipe inside a footing's zone of influence (angle a Settings value) and
   suggest deepening the footing or rerouting; nothing changes on its own.
2. **Today:** no such check in Civil or Structural (no "influence" or footing-near-pipe code on either release). Civil does not read
   Structural objects from the job folder: Structural's own notes say the cross-discipline read (UX-XDISC-02) "is planning-only"
   (`Modules/Structural.DesignCore/PumpPitEngine.cs:12-30`). The one cross-discipline read that exists is Civil reading Structural's pump pit
   block into the Pit Schedule (`Services/PitScheduleBuilder.cs:52-58, 704-716`). Structural draws footings on **STRIP FOOTINGS**
   (`Modules/Structural/Services/LayerService.cs:95-96`) with their depth in its footing record (Unknown when not typed, S4 card).
3. **Classification: MISSING.**
4. **Proposed:**
   - **The check itself (pure, tested, no AutoCAD):** for each pipe, its invert depth against each footing within reach: the pipe is
     "inside the zone" when it is deeper than the line drawn from the footing's base edge at the Settings angle (any allowance for
     bedding below the invert is a Settings value too, blank by default). Every input that is not known (angle, footing depth, pipe invert) makes the row "cannot check: <what is
     missing>", never a guess.
   - **The angle is an engineering number:** Settings value, **blank by default**; while blank the check shows once: "Zone of influence
     angle not set (Settings > Civil > Checks). Pipes near footings were not checked." (question 8).
   - **Where the footings come from (question 7):** step 1 = footings in this drawing or in an attached Xref of the Structural footing plan
     (read-only, never edited); step 2 = the job folder, when UX-XDISC-02 is built. None found: one line "No footings found in this drawing
     or its Xrefs".
   - **Row wording:** "P4-P5 is inside the zone of influence of PF2 (pipe 1.40 m deep, 0.80 m from the footing). Suggest: deepen PF2 or
     move the pipe. Show where." Warning only (R-27); never pre-ticked; no Fix button (both suggestions are engineering choices).
5. **Undo / Esc:** nothing written.

## Card 5.8 — UX-XDISC-04: downpipes are Civil's; Structural sees them and may suggest a move

1. **Tim ruled (26 Sep 19:06):** "Civil owns, Structural sees". DPs are Civil objects; Structural sees them read-only (e.g. post clashes) and
   can suggest a move.
2. **Today:** Structural has no downpipe code (none found on 9babe787 outside drawing assets). Its pump pit note states the same ownership
   rule and that it never writes into Civil (`PumpPitEngine.cs:20-27`). Civil downpipes are blocks on DOWNPIPES (`LayerService.cs:150-152`).
3. **Classification: MISSING** (Structural side) / **KEEP** (Civil owns DPs: nothing changes in Civil).
4. **Proposed:**
   - In Structural, a read-only "Downpipe near a post" check: a CE downpipe (same drawing or an attached Xref of the Civil plan; job folder
     later, as 5.7) within a Settings distance of a post, column or stud mark: "DP3 is 120 mm from C2. Suggest moving DP3 (Civil). Show
     where." Settings distance: **300 mm proposed, not confirmed** by Tim (a drafting tolerance, changeable).
   - "Suggest a move" = a job message for whoever next opens the Civil drawing (the CE bell, UX-MSG-01/03, once switched on); until the bell
     is on, the Structural row says "Tell the Civil drafter". Structural never moves or edits a downpipe.
5. **Undo / Esc:** nothing written in either drawing.

---

## Recommended answers a builder may use now (INT-073)

1. One layer-maker; existing layers never changed **once the switch flips**; switch "CE may recolour existing layers" ships ON (today) until
   Codex accepts; layer names on Settings, seeded with today's names.
2. Wrong-layer Checks row pre-ticked; "layer differs from office" row not pre-ticked.
3. Spoon drain and raingarden objects drawn ByLayer; a test bans fixed colours on plotted CE objects.
4. Status New / Existing / To be removed; seeds EX STORMWATER PIT and STORMWATER DEMOLISH (proposed); "TO BE REMOVED" text; existing and
   removed pits out of the Pit Schedule; existing pits stay in the checks.
5. Right-click groups as in 5.5, command names in brackets behind the switch (default ON).
6. Civil Properties palette editable first; Ctrl+1 CE section 2027-first later.
7. Zone of influence check engine now; angle blank until Tim types it; footings from this drawing or an attached Xref first.
8. Downpipe-near-post check in Structural, 300 mm proposed, suggestion only.

## Tests (automated, before Codex)

1. Every placing command: CLAYER before = CLAYER after, and after Esc; a missing layer is made with the Settings colour and linetype by
   both the `LayerService` and the old `BlockService` route (the second now calls the first).
2. With the switch OFF, an existing STORMWATER PIPE layer at colour 5 stays colour 5 after CD, PIT, CDEDIT; with it ON, today's behaviour.
3. A pipe label moved to layer 0: Checks lists "on the wrong layer", pre-ticked; Fix moves it back to 25TEXT; one U undoes the fix; a locked
   25TEXT shows the row with Fix greyed and nothing unlocked.
4. CDRG and CDSPOONDRAIN objects read colour ByLayer.
5. Status Existing on a pit: layer EX STORMWATER PIT, not in the Pit Schedule rows, still in the network check; To be removed adds one "TO
   BE REMOVED" text; one U restores layer, text and schedule.
6. Right-click item list for a recorded pit, a recorded pipe, a CE label, an ordinary block (no CE items); each item sends the same command
   as typing it.
7. Civil Properties palette: typing a size runs the Edit Pipe rule (a refused value is refused with the same words); Enter = one U.
8. Zone of influence: blank angle gives the one "not set" line and no rows; with a test angle, a deep pipe near a footing is flagged, a
   shallow one is not; an Unknown footing depth gives "cannot check: footing depth not known".
9. Downpipe check: a DP 120 mm from C2 gives one row; nothing in either drawing changes.

## Example drawings

1. Codex's Civil copies in `C:\Lisp Files\_TEST_COPIES_20260923` (DWG-B1 family), copied fresh: one with STORMWATER PIPE recoloured to 5,
   one pipe label moved to layer 0, 25TEXT locked on a second copy.
2. A synthetic Civil + Structural pair (no real job, DATA-01): a Civil plan with the Structural footing plan Xref'd in, two footings with
   depths set, one pipe close and deep, one far; a Structural plan with the Civil plan Xref'd in and a DP near a post.

## Tim's AutoCAD checklist (about 10 minutes; Codex first)

1. **Your layer colour stays:** make STORMWATER PIPE colour 5 (Layer Properties), draw a pipe with CD. **Should see:** still colour 5 (after
   the switch is flipped); Checks lists "STORMWATER PIPE is colour 5; office colour 150", not ticked.
2. **Wrong layer:** move one pipe label to layer 0, open Checks. **Should see:** "P3-P4 label is on layer 0", ticked; Fix; it goes back; U
   undoes it.
3. **Your current layer:** make layer BLOCKS current, draw a pipe, place a pit, press Esc mid-way once. **Should see:** BLOCKS still
   current every time.
4. **Existing pit:** Edit Pit, Status Existing. **Should see:** the pit greys onto EX STORMWATER PIT and leaves the Pit Schedule; U puts it
   back.
5. **Right-click:** right-click a pit. **Should see:** a short CE group (Edit pit (CDEDIT), Show in Pit Schedule, Tidy labels, Select this
   run, Select whole network) with AutoCAD's own menu still there.
6. **Properties:** open CDINSPECTOR, select a pipe, type 300 for the size, Enter. **Should see:** the preview, then the pipe and label at
   300; U takes it back.
7. **Pipe near a footing:** on the pair, set the angle in Settings, run Checks. **Should see:** one row naming the footing and the pipe, with
   "Suggest: deepen ... or move the pipe"; nothing moved.

## Code references

Civil release commit 1200744d (`Modules\Drainage\` unless marked): `Services/LayerService.cs:47-120, 127-260, 266-335, 350-477, 1285-1300`;
`Services/BlockService.cs:892, 1377-1398`; `Commands/NativePipeObjectCommands.cs:90-94`; `Commands/LayerManagerCommand.cs:12`;
`Models/UserSettings.cs:1398-1410`; `Services/OsnapService.cs:152-178, 184-200, 309-335`; `Services/CurrentLayerGuard.cs:10-60`;
`Commands/HealthCheckCommand.cs:182-188`; `Rules/PipeEditRefusal.cs:60, 93-94`; `Services/LinkService.Registration.cs:2061-2063`;
`Services/SlabService.cs:2252-2280`; `Services/SourcePlacementService.cs:866-900`; `Services/GradeNoteMarker.cs:240-258`;
`Services/ArrowService.cs:434, 442`; `Services/PipeTruthResolverService.cs:740-741`; `Commands/LinkCommands.ImportXcivil.cs:509-512`;
`PluginInitialization.cs:139-146, 182-185`; `Services/CivilNetworkSelectContextMenuService.cs:14-21, 36-50, 171-176`;
`Services/PipeAttachmentContextMenuService.cs:25-40, 70-87`; `Services/CompoundContextMenuService.cs:25-40, 80-95`;
`Commands/InspectorCommand.cs:13`; `Rules/InspectorEditDispatchPolicy.cs`; `Services/PitScheduleBuilder.cs:52-58, 704-716`;
`Core/Messages/CeMessage.cs:18` (the FFL heads-up message kind exists, UX-XDISC-03); repo `docs/workflows/C7_STEP1_AUDIT_2026-09-15.md`
lines 28, 62. Structural release commit 9babe787: `Modules/Structural.DesignCore/PumpPitEngine.cs:12-30`;
`Modules/Structural/Services/LayerService.cs:87-118, 148-175`; `Modules/Structural/Docs/CEMARKUP_Template/
ce_typical_blocks_layers_schedules_notes.snapshot.json` (layer and block names only).
Not found on those commits: any Civil wrong-layer or layer-colour finding, any existing-pit or demolished status, "TO BE REMOVED", a CE
section in AutoCAD's Properties, a zone of influence check, any Structural downpipe code, a working Edit item on the right-click menu.
Codex and driver: `CODEX_SWEEPC1_2026-09-30.md` item 19; `CODEX_TEST_REPORT_PASS9_2026-09-24.md` item 36; `CODEX_VERIFYW20_2026-10-08.md`
items 18-19; `DRIVER_RUN11_2026-10-03.md` item 2; `DRIVER_RUN20_2026-10-04.md` item 81; `CODEX_VERIFYW21_2026-10-08.md` item 18 (BUG-434).
