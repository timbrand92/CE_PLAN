# Structural faults found in the installed code that have no bug number yet

**Written Fri 13 Nov 2026 by lane trust-struc-mgr-plan, from reading Structural 1.0.126 (commit 8de95c34) for the 32 Structural core tool notes. For the controller to file in `BUG_CARPARK.md`; this lane did not edit it.** Each line: what the drafter sees, where in the code, a severity guess, and DATA where it hides, overstates or loses a value. Nothing was run in AutoCAD; each is a reading of the code.

---

# FOR TIM

1. **How many:** 104 faults across the four tool families (20 roof and bracing, 27 beams, 20 supports, 37 schedules and tools). A few appear in two families.
2. **The worst, each checked or traced by this lane where marked:**
   1. **Schedule sync turns braces again (STRSCHEDSYNC), narrowed 04:19 13 Nov after review:** a sync with no edits turns again only a brace drawn flat and later ROTATEd, on the first sync; it and rewrites every brace's length and angle at the table's two-decimal rounding. **Checked in the code by this lane:** `Services\ScheduleService.cs:725-756` with `Services\ProjectDataService.cs:322-326`.
   2. **The A/B switch can lose an older brace (ABS), narrowed 04:19 13 Nov after review:** only when the BRACING block cannot be loaded; it then erases the old block and still says "It was left as it was." One U brings it back. **Checked in the code by this lane:** `Services\BracingService.cs:2151-2206`, message at `Commands\BracingCommands.cs:498`.
   3. **A schedule size the block cannot show is drawn as the default size (C1, C2, DS, DS1, TS1)** while the line names the schedule size (card TRUST-S3 covers it; no bug number yet).
   4. **BDL has no units handling:** in a metre drawing its minimum length, lower-line offset and wall and opening search are read as metres, so almost every beam would be refused as too short (corrected after review: a wall and opening search, not a support search).
   5. **Beam tools 1 and 2 refuse every beam with "CE hit an internal problem"** when the beam or text layer is locked, off, frozen or a different colour or linetype from CE's.
   6. **CLEAN or FASTSAVE on a never-saved drawing might save over its template** (plausible from the code, not measured).
3. **None of these is filed yet.** Each needs a carpark entry and, before any is called fixed, a robot case and a Codex look on a copy.

---

## Roof marks and bracing

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. ABS: an older brace can be erased and the line says "It was left as it was." (new block could not be drawn after the old one was erased); `Services\BracingService.cs:2169-2191`, `Commands\BracingCommands.cs:395-398, 496-499`; MEDIUM; DATA (loses a brace and says it was kept).
2. ABS: older brace on a layout tab or inside REFEDIT is erased there and redrawn in Model space, no stop line; `Commands\BracingCommands.cs:385`, `Services\BracingService.cs:1676, 2171`; MEDIUM (I think).
3. ABS: a truss with a blank type tag on layer "WALL BRACING TYPE BT1" reads as type B and is switched to A; `Services\BracingService.cs:2109-2112, 2137-2140`; LOW; DATA (an Unknown turned into a value).
4. CSBRACINGPANEL: a failed read keeps the last numbers on screen with no sign; `UI\Dialogs\BracingPanelWindow.xaml.cs:111-123`; MEDIUM; DATA (shows old totals as current).
5. CSBRACINGPANEL: older-named brace blocks ("A - BRACING LEFT" and the like) count as zero provided; `Services\ProjectDataService.cs:283` against `Services\BracingService.cs:2089-2104`; MEDIUM; DATA (understates provided).
6. CSBRACINGPANEL: braces on a frozen or off layer are counted; `Services\ProjectDataService.cs:266-286`; LOW; DATA (can overstate provided).
7. P1: the purlin lap is fixed at 1200 mm in the code and the question "Apply purlin lap?" does not show the number; `Commands\RafterJoistCommands.cs:283`, prompt at 181-183; MEDIUM; DATA (hides the lap length drawn).
8. R1/P1/FJ1: picks under 25 units apart on the top and bottom give a guessed arrow depth (300 or a quarter of the width) with no line; `Commands\RafterJoistCommands.cs:362-368, 533-539`; LOW; DATA (guess shown as a pick).
9. R1/P1/FJ1: a bay within 12 degrees of horizontal or vertical is drawn exactly horizontal or vertical, width taken along that axis, no line; `Commands\RafterJoistCommands.cs:168-171, 496-564`; LOW; DATA (width a little under the picked length).
10. R1/P1/FJ1: auto placement slides the marker inside the bay to miss text and walls, no line unless detailed logging is on; `Commands\RafterJoistCommands.cs:194-200`; LOW.
11. R1/P1/FJ1: no locked-layer check; the marker is drawn on a locked RAFTERS, PURLINS or JOISTS layer where AB, BB and BT1 refuse; `Commands\RafterJoistCommands.cs:96-272` (no call) against `Commands\BracingCommands.cs:19-24`; LOW.
12. R1/P1/FJ1: a size the block did not take is not reported when the value cannot be read back; `Services\DynamicPropertyReadback.cs:46-47, 53`; LOW; DATA (hides a failed size).
13. R1/P1/FJ1: fixed numbers 25, 300 and +200 (outer width) with no Settings name; `Commands\RafterJoistCommands.cs:27, 351, 362, 635`; LOW.
14. R1/P1/FJ1/AB/BB/BT1: the refusal in a metre, centimetre or inch drawing talks about "footings, labels and text" and says to LIST one footing; `Structural.DesignCore\DrawingUnitRule.cs:330-332` via `Services\FoundationService.Identity.cs:119-128`; LOW.
15. AB/BB/BT1: "CE set the brace direction from the Xref walls: it goes on the side with fewer wall lines." is printed for every decided side, including the 2-lines rule for type A, the local crowding test and the fallback; `Commands\BracingCommands.cs:64-68`, `Services\BracingService.cs:163-209, 249-261, 315-328`; LOW.
16. AB/BB/BT1: the brace end is moved up to 1 degree to a square angle (fixed in the code), no line; `Services\BracingService.cs:38, 98-105, 2217-2221`; LOW.
17. AB/BB/BT1: layer 25CONT is added to the drawing if missing, no line; `Services\BracingService.cs:1610-1643`, `Commands\BracingCommands.cs:102-103`; LOW.
18. AB/BB/BT1/ABS: no error catch, so any other AutoCAD error opens AutoCAD's own error window; `Commands\BracingCommands.cs:29-121, 145-236, 260-366, 389-548`; LOW.
19. BT1: the help text lists "BT number 1-9" before "Insert point" but the tool asks the points first; `Assets\Config\command-registry.json:2562-2565` against `Commands\BracingCommands.cs:271, 288`; LOW.
20. AB/BB: the [Wall] option, the units hold switch and the panel's mixed-types switch have no box on the Settings window (file only); `Models\UserSettings.cs:816, 820, 2128`, `UI\Dialogs\CeSettingsDialog.xaml.cs:137, 357`; LOW.

## Beam tools

Paths are under C:\CE_WORK\scratch\audit_struc\Modules\ (S = Structural\, D = Structural.DesignCore\ConnectedDesign\, H = Structural\Services\ConnectedDesign\Host\, C = Structural\Services\ConnectedDesign\Commit\). Read only; nothing run in AutoCAD.

1. 1, 2: a BEAM, BEAM LOWER or 25TEXT layer that is locked, off, frozen, or a colour or linetype other than CE's (or no HIDDEN linetype) refuses every beam with the generic "CE hit an internal problem" line; C\BeamAtomicLayerWriter.cs:44-47, 61-70; C\BeamAtomicWriteSession.cs:112-116; D\BeamAtomicCommitCoordinator.cs:107-117; H\BeamCommandAutoCadRoute.cs:446-467; D\BeamRefusalWording.cs:80-84; HIGH; DATA no.
2. 4, 5: the same layer set-up shows "could not confirm this beam's preview or write still exactly matches the drawing ... Run the command again", and running it again cannot help; C\AutoCadBeamSpecialAtomicWriter.cs:111, 172-176; D\BeamSpecialAtomicCommit.cs:160-167; D\BeamRefusalWording.cs:556-559, 602-606; MEDIUM; DATA no.
3. 1, 2: on a layout tab or in REFEDIT the line says "CE hit an internal problem at the drawing check step" instead of "go to model space"; H\BeamCommandAutoCadContext.cs:47-75; H\BeamCommandAutoCadRoute.cs:155-175; D\BeamRefusalWording.cs:626-649; MEDIUM; DATA no.
4. 4, 5: on a layout tab or in REFEDIT the same "safety checks ... Run the command again" line; H\BeamSpecialCommandAutoCadCaptureFactory.cs:78-83, 107-110; D\BeamRefusalWording.cs:602-606; MEDIUM; DATA no.
5. 1, 2, 4, 5: beam shown with Settings layer names ignored, always BEAM, BEAM LOWER and 25TEXT; D\BeamAtomicCommitAdmission.cs:25-42 against S\Models\UserSettings.cs:439, 442 (BDL does use the Settings names); MEDIUM; DATA yes (a value set on Settings is silently not used).
6. 2, 4, 5: when neither side of the beam has room for the mark there is no best-available question and the code PLACEMENT_CONTEXT_UNRESOLVED has no wording, so the generic internal-problem line probably shows; D\BeamCommandPreviewPlanner.cs:161-162; D\BeamPlacementPlanner.cs:488-491; D\BeamSpecialCommandPreviewPlanner.cs:234-249; MEDIUM; DATA no.
7. 4, 5: a lintel mark (L or RL) with no inside point is placed as an ordinary mark with no refusal and no line, so it can land on the inside (1 and 2 refuse); D\BeamSpecialCommandPreviewPlanner.cs:201-206; MEDIUM; DATA yes (the mark is not where a lintel mark is meant to be, and nothing says so).
8. 4, 5: the inside-point question is asked for every mark when none is saved, not only lintels (1 and 2 ask only for lintels); H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:105-124; H\BeamCommandAutoCadInsidePointProposalAdapter.cs:130-135; LOW; DATA no.
9. 4, 5: shorten amounts and offset distances can only be 45 or 100, no Settings list (the old code offered one); H\BeamSpecialCommandAutoCadFinalPromptAdapter.cs:165-197; H\BeamSpecialCommandAutoCadPromptSession.cs:194-206; D\BeamRefusalWording.cs:405-407; S\Commands\BeamPlacementCommands.cs:1427; MEDIUM; DATA no.
10. 1, 2, 4, 5: Enter at "Enter text" with no text shown prints "one of the command-line prompts did not complete properly"; H\BeamCommandAutoCadPromptAdapter.cs:719-750; D\BeamRefusalWording.cs:587-591; LOW; DATA no.
11. 1, 2, 4, 5: "remember last choices" does not remember the mark, beam type, suffix or shortening; after BDL, BDL's mark is offered as the default; S\Commands\BeamPlacementCommands.cs:194, 412, 610; H\BeamCommandSettingsSnapshotReader.cs:137-139; H\BeamSpecialCommandAutoCadPromptHelpers.cs:40-47; LOW; DATA no.
12. 1, 2, 4, 5: any mark starting with L (so LVL1 too) is treated as a lintel and brings the inside-point question and outside placement; D\BeamLabelClassification.cs; S\Models\UserSettings.cs:737; LOW; DATA no.
13. 1, 2, 4, 5: an end is shortened by the auto-trim with no line saying so (only the preview shows it); D\BeamAxisEndAdjustment.cs:16-18; H\BeamCommandAutoCadRoute.cs:384-391; LOW; DATA no.
14. 1, 2, 4, 5: walls and openings are recognised only by words in the layer name (WALL, WINDOW, DOOR), so a wall on any other layer does not steer the mark side; S\Commands\BeamPlacementCommands.cs:1296-1372; H\BeamCommandAutoCadReadScope.cs:467-470; LOW; DATA no.
15. 5: help text says "Beam offset helper command" and does not say the beam moves 45 or 100 mm; S\Assets\Config\command-registry.json:2050; LOW; DATA no.
16. BDL: no units at all, so in a metre drawing the 50 minimum, the 100 offset default and the 250 support search are metres; S\Commands\BeamPlacementCommands.cs:121-127, 145; S\Services\BeamDraftingStandards.cs:78; S\Commands\BeamPlacementCommands.cs:737; HIGH; DATA yes (a millimetre figure applied as drawing units, with no line saying so).
17. BDL: Esc, or Enter with no text shown, at "Enter BEAM text" or "Enter BEAM LOWER text" ends the command with both lines already drawn and no message; S\Commands\BeamPlacementCommands.cs:159-172 against 191-192, 206-207; MEDIUM; DATA no.
18. BDL: no model-space or REFEDIT check, lines always go into Model space at the coordinates picked on a layout tab; S\Commands\BeamPlacementCommands.cs:97; S\Services\BeamService.cs:92-93; MEDIUM; DATA yes (lines in the wrong place).
19. BDL: no locked-layer check on BEAM, BEAM LOWER or 25TEXT (1, 2, 4, 5 refuse); S\Services\BeamService.cs:70-84, 85-100; S\Services\LayerService.cs:206-216; MEDIUM; DATA no.
20. BDL: the view is zoomed (ZOOM Object then 0.7X) with no line saying so, and not as part of an Undo; S\Services\BeamService.cs:537-551; S\Commands\BeamPlacementCommands.cs:184; LOW; DATA no.
21. BSET, BSETRESET: "Inside-point added" and "All inside-points cleared" print even when the store failed to write, because the store swallows the error; S\Services\BeamInsidePointStore.cs:73-76, 92-95; S\Commands\BeamInsidePointCommands.cs:39, 66; MEDIUM; DATA yes (success overstated).
22. BSETLIST: "No inside-points stored for this drawing" prints when the list could not be read, because the read error is swallowed as an empty list; S\Services\BeamInsidePointStore.cs:43-48; S\Commands\BeamInsidePointCommands.cs:88-94; MEDIUM; DATA yes (reports none when it could not look).
23. BSETRESET: clears every inside point with no question, and adds an empty record to a drawing that had none; S\Commands\BeamInsidePointCommands.cs:65-66; S\Services\BeamInsidePointStore.cs:153-165; MEDIUM; DATA yes (loses all saved points on one command).
24. BSET: the clicked point is saved as given, while the beam commands turn a UCS click into World first, so a turned UCS may save the wrong place (which is right: not known); S\Commands\BeamInsidePointCommands.cs:36-37; H\BeamCommandAutoCadInsidePointProposalAdapter.cs:198-199; MEDIUM; DATA yes (a wrong point saved silently if the UCS is turned).
25. BSET, BSETRESET: no read-only, model-space or REFEDIT check, so a point clicked on a layout tab is saved as a model-space inside point and a read-only drawing is changed; S\Commands\BeamInsidePointCommands.cs:22-27, 60-65; MEDIUM; DATA yes (a point from the wrong space).
26. BSET: after 128 saved points the beam commands stop with "the saved inside-of-building point looks wrong", and BSET does not warn at 128; H\BeamCommandAutoCadInsidePointProposalAdapter.cs:136-139; H\BeamCommandAutoCadInsidePointStoreEvidenceReader.cs:170-181; D\BeamRefusalWording.cs:257-259; LOW; DATA no.
27. BSETLIST, BSETRESET: registry text still says "inside-points stored in the drawing's XRecord"; S\Assets\Config\command-registry.json:2176-2206; LOW; DATA no.

## Support blocks

Build read: Structural 1.0.126, commit 8de95c34, under C:\CE_WORK\scratch\audit_struc\Modules\Structural\. "SBC" is Commands\SupportBlockCommands.cs. By reading only; none seen in AutoCAD. DATA = it hides, overstates or loses a value.

1. C1/C2/DS/DS1/TS1: a schedule size the block cannot show (timber pack, or a size the block lacks) is drawn as the default size while the screen line still names the schedule size; SBC:252-257, 322-325, 1470-1480 (plan card TRUST-S3 covers it, no bug number); severity HIGH; DATA
2. C1/DS/DS1/TS1: with no schedule row the support is drawn at the default size (89 SHS, 90 x 90, 135 x 90) and nothing says where the size came from; SBC:251-261; severity MEDIUM; DATA
3. C1/DS/DS1/TS1: a Settings size the block does not offer leaves the block in whatever state it had, no line (C2 refuses instead); SBC:322-330, 1487-1491; severity MEDIUM; DATA
4. SDS/SDS1/STS1/SC1/SC2: the size change is not checked, so the layer and position change even when the block keeps its old size (for example SC2 on an outdated block); SBC:567-572 (result of SetDynamicVisibility not read); severity MEDIUM; DATA
5. SDS/SDS1/STS1/SC1/SC2: no layout-tab, REFEDIT or non-millimetre check, so they run where the insert tools stop; SBC:469 against 215-216; severity MEDIUM
6. SDS/SDS1/STS1/SC1/SC2: a label on a locked text layer is not erased but is drawn again, so two labels sit on top of each other, and it is not turned; SBC:1905-1924 (catch at 1919), 1926-1987, 737-748; severity MEDIUM; DATA
7. SDS/SDS1/STS1/SC1/SC2: after a switch the redrawn labels are not recorded as the support's own, so they stop following the support when it moves; SBC:466-627 (no RecordSupportLabel call, only at 376), Services\BeamLinkService.SupportLabel.cs:111-122; severity MEDIUM; DATA
8. SDS/SDS1/STS1/SC1/SC2: the block turns about its insertion corner while its labels turn about its centre, so labels end a few tens of mm off after a turn (by reading, not seen); Services\SupportBlockJig.cs:94-99, SBC:700, 732; severity LOW
9. SDS/SDS1/STS1/SC1/SC2: a carried label keeps its old wording and layer on the new type (a column can read "DS3"), and SDS prints nothing about carrying labels; SBC:1926-1987, 609-618; severity LOW; DATA
10. C1/C2/DS/DS1/TS1: "[CE] Support linked to nearby beam." can print when the link write failed, because the failed write is only logged; Services\BeamLinkService.cs:50-90, 130-148, 419-421, Services\BeamLinkService.Persistence.cs:52-65; severity MEDIUM; DATA
11. C1/C2/DS1/TS1 and the label step of SDS1/STS1/SC1/SC2: the remembered label text (Enter takes it) is a static list that carries from one drawing to the next in the same AutoCAD session; Services\CeTextService.cs:23, 1988-2016, 5523-5542; severity LOW; DATA
12. C1/C2/DS/DS1/TS1 and the switches: label height 200, the 45 degree label turn, the 260 label search radius, the support and label layers and colours, and the size-to-width table are fixed in the code (BUG-537 names only the sizes); Services\CeTextService.cs:680-721, SBC:66-70, 562, 1602-1655; severity LOW
13. C1/C2/DS/DS1/TS1: a schedule saved with every row left out does not replace the old schedule, so the old sizes keep being used; Services\XclmTxtService.cs:329-332; severity LOW; DATA
14. C1/DS/DS1/TS1 and the switches: only C2 checks that the support block in the drawing is the current one; the others use whatever block of that name is there; SBC:1327-1328; severity LOW
15. C2: the first placement can still print AutoCAD's "Duplicate definition of block _Dot ignored." because C2 loads its block without the quiet-read the C1 route uses; Commands\SupportBlockDefinitionUpgradeService.cs:83, 216, 318, SBC:1357; severity LOW
16. C2: if the block cannot be loaded the screen shows the raw error text ("Bundled approved support asset could not be loaded: ..."); Commands\SupportBlockDefinitionUpgradeService.cs:90, 138; severity LOW
17. C1/C2/DS/DS1/TS1: with the rotation preview switched off in Settings, the line still says "CE could not turn the support to the wall direction by itself"; SBC:770-771, 842-843; severity LOW
18. C1/C2/DS/DS1/TS1: the non-millimetre stop line talks about footings ("draws footings, labels and text", "LIST one footing"); Structural.DesignCore\DrawingUnitRule.cs:330-336; severity LOW
19. DS and the five switches: the command help list shows prompts these commands do not ask ("Insertion point", "Text value/orientation"; the switches ask "Select support block:"); Assets\Config\command-registry.json:2769-2787, 2807-2902; severity LOW
20. C1/C2/DS/DS1/TS1: no line about a frozen or off support layer (the footing tools use HiddenLayerLine, these do not); SBC (no call found); what AutoCAD does then is not known; severity LOW

## Schedules, CLEAN, Help and Settings

Paths are under C:\CE_WORK\scratch\audit_struc\Modules\Structural\. Read only; none seen in AutoCAD. "hunt" means a finding in a hunt note under C:\CE_PLAN\areas\ that never got a carpark number; I re-read its lines in 1.0.126. DATA means the fault hides, overstates or loses a value.

1. STRSCHEDCREATE: on a layout tab or in REFEDIT the tables still land in Model space at the point clicked on the sheet (hunt, item 9, 19 Oct); Services\ScheduleService.cs:193, 210-221; MEDIUM.
2. STRSCHEDCREATE: in a rotated UCS the table lands away from the click, because the click is used as World; Services\ScheduleService.cs:210, 221, 228; MEDIUM.
3. STRSCHEDCREATE: a second run adds three more tables and leaves the first three out of date, because the update-on-rerun switch ships off and has no Settings box; Core\ScheduleSetPlan.cs:34-35, Models\UserSettings.cs:2134-2136; MEDIUM; DATA (an out-of-date schedule is left looking current).
4. STRSCHEDCREATE: the tables sit on whatever layer is current, CE sets none; Services\ScheduleService.cs:382-474; LOW.
5. STRSCHEDCREATE, STRSCHEDREFRESH: older brace blocks ("A - BRACING LEFT") are left out of the schedule with no message (hunt BRACE-05); Services\ProjectDataService.cs:282-283; MEDIUM; DATA (hides braces).
6. STRSCHEDCREATE, STRSCHEDREFRESH: the ROTATION column ignores AutoCAD ROTATE on a brace and shows the block's own setting (hunt BRACE-02); Services\ProjectDataService.cs:322-326; MEDIUM; DATA (wrong angle shown).
7. STRSCHEDCREATE, STRSCHEDREFRESH: a brace with a blank type is listed as type A; Services\ProjectDataService.cs:316-320; MEDIUM; DATA (a guess shown as a fact).
8. STRSCHEDCREATE: the two schedule switches (update on rerun, pier table without LAYER and HANDLE) and the FASTSAVE clean-up switch have no box on CESETTINGS; Models\UserSettings.cs:2136, 2141, 372; LOW.
9. STRSCHEDCREATE, STRSCHEDREFRESH, STRSCHEDSYNC: Help lists their steps only as "Command-specific utility prompts" and describes them as "Create Schedule." and so on; Assets\Config\command-registry.json:1941-1943, 1959-1961, 1977-1979; LOW.
10. STRSCHEDREFRESH: picking a table CE did not make does nothing and prints nothing; Services\ScheduleService.cs:330-331, Commands\UtilityCommands.cs:83; LOW.
11. STRSCHEDREFRESH: rows follow the order CE finds blocks, so a table sorted by hand is re-sorted on refresh; Services\ProjectDataService.cs:268-308, ScheduleService.cs:692-696; LOW.
12. STRSCHEDREFRESH: marked expert, so CEHELP hides it until "Show advanced commands" is ticked; Assets\Config\command-registry.json:1965, UI\Dialogs\CommandHelpWindow.xaml.cs:47, 71; LOW.
13. STRSCHEDREFRESH: an old three-column pier table gets no MARK or DIA MM and nothing says so; Services\ScheduleService.cs:512-537, 557-561; LOW.
14. STRSCHEDSYNC: a sync with no edits turns a ROTATEd brace a second time, and rewrites every brace's length and rotation at the table's two-decimal rounding (hunt BRACE-01); Services\ScheduleService.cs:409-410, 727-755, Services\ProjectDataService.cs:322-326; HIGH; DATA (changes values silently).
15. STRSCHEDSYNC: an erased brace or a locked brace layer gives AutoCAD's own error and nothing is synced (hunt BRACE-03); Services\ScheduleService.cs:732-735, 780-783, Commands\UtilityCommands.cs:92-96; MEDIUM.
16. STRSCHEDSYNC: typing B over A changes the type text only, the brace stays on the A layer and plots as A (hunt SCHED-09); Services\ScheduleService.cs:742-743; MEDIUM; DATA (schedule says B, drawing plots A).
17. STRSCHEDSYNC: says nothing about values it skipped (a cell that is not a number, a block that refuses the value); Services\ScheduleService.cs:745-754, Services\BlockReferenceHelpers.cs:79-84; MEDIUM; DATA (hides that an edit did not reach the drawing).
18. STRSCHEDSYNC: edits to the tie-down table and typed pier MARK or DIA MM go nowhere and nothing says so; Services\ScheduleService.cs:369-376, 762-766, Services\BlockReferenceHelpers.cs:66; LOW; DATA (hides that an edit did not reach the drawing).
19. STRSCHEDSYNC: no read-only drawing check, unlike the other two schedule commands; Commands\UtilityCommands.cs:92-96; LOW.
20. CLEAN: one object on any locked layer drops the whole text step and the whole ByLayer step, prints FAIL with AutoCAD's raw word, and the drawing is still saved after a half clean-up; Services\CleanPipelineService.cs:409, 526, 232-236, 746-751; MEDIUM.
21. CLEAN: the tooltip says "Does not save: save the drawing yourself." and Settings says "CE never saves" while CLEAN saves; Assets\Config\command-registry.json:4145, UI\Dialogs\CeSettingsDialog.xaml:557; MEDIUM.
22. CLEAN: prints "drawing saved" when it only sent QSAVE and never checked (fallback too); Services\CleanPipelineService.cs:167-171, 284-287, 208; MEDIUM; DATA (overstates a save).
23. CLEAN, FASTSAVE: a never-saved drawing may be saved over its template file, if AutoCAD 2027 gives a new drawing's name as the template (hunt DS-04, plausible, not measured); Services\DrawingSafetyService.cs:187-206, 356-362, Services\DrawingAutoSaveService.cs:198; HIGH; DATA (loses the template).
24. CLEAN: no read-only, layout or REFEDIT check at the start; Services\CleanPipelineService.cs:59-90; MEDIUM.
25. CLEAN: ignores Settings > Xref Layer (always layer XREF, colour 7, HATCH 21, Arial Narrow); Services\CleanPipelineService.cs:16-19, 305, 483 against UI\Dialogs\CeSettingsDialog.xaml.cs:171-173, 403-405; MEDIUM.
26. CLEAN: the next hatch is SOLID on layer HATCH 21 for the rest of the session; Services\CleanPipelineService.cs:561-563; LOW.
27. CLEAN: attribute definitions inside block definitions are caught as text and set to STANDARD while the step prints "attributes=preserved"; Services\CleanPipelineService.cs:133, 416; LOW.
28. CLEAN: saves in the running AutoCAD's own file version, not the Save As format setting; whether 2027 files open on 2022 to 2024 is not known; Services\DrawingAutoSaveService.cs:198; LOW.
29. CLEAN: keeps no copy from before the clean-up, because CE's backup copy is taken after the save; Services\DrawingAutoSaveService.cs:198-219, 308-312; MEDIUM; DATA (the pre-clean state is overwritten with no way back).
30. FASTSAVE: Help still says "lighter cleanup sequence" and "May normalize object properties/layers" and lists FASTSAVE as another name for CLEAN though it only regenerates and saves by default; Assets\Config\command-registry.json:4138, 4164, 4168; LOW.
31. CEHELP: opens already filtered by the last thing searched, so the list can be empty with "No matching command"; UI\Dialogs\CommandHelpWindow.xaml.cs:43-49, 101-107; LOW.
32. CEHELP: the 19 visible Foundations commands (FPFC, FSF, FST, BP and others) never appear in the list and show only when typed exactly; UI\Dialogs\CommandHelpWindow.xaml.cs:16, 110-143, Services\CommandRegistryService.cs:99-114; LOW.
33. CEHELP: the settings file is rewritten on every key typed in the search box, every tick and every Run; UI\Dialogs\CommandHelpWindow.xaml.cs:347-366, 441; LOW.
34. CEHELP: Run command starts the selected command with no confirmation, including CLEAN, which saves; UI\Dialogs\CommandHelpWindow.xaml.cs:409-421; LOW.
35. CESETTINGS: blanking a note or list box (candidate positions, lintel prefixes, Xref patterns, steel and timber notes) is ignored on Save and the old text stays; UI\Dialogs\CeSettingsDialog.xaml.cs:294-296, 325-337; LOW.
36. CESETTINGS: "Share learning data" is ticked by default and nothing in the code reads it, and the page does not say where anything goes; Models\MarkupAIModels.cs:231, UI\Dialogs\CeSettingsDialog.xaml:827; LOW.
37. CESETTINGS: the Markup service page still offers "API key environment variable name", "Service URL" and "AI model", which do nothing while the page-send is blocked; UI\Dialogs\CeSettingsDialog.xaml:781-790, Services\MarkupAIOffPcPolicy.cs:32-35; LOW.

---

## Not checked

1. **Nothing was run.** Severity and DATA marks are the readers' guesses.
2. **Duplicates with existing carpark entries are possible** where an older entry describes the same thing in other words; the controller checks before filing.
