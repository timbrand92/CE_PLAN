# Open bugs by core tool

Lane: trust-records. Date: Thu 12 Nov 2026. A derived copy, not a status: the bug numbers come from CARPARK_BY_COMMAND_INDEX.md (the group for each command) and each title comes from the heading of that bug in BUG_CARPARK.md. Commands and order follow CIVIL_COMMAND_SORT_06NOV.md, "CE Drainage tab" and "CE Design tab" (47 commands in all).

Where a group says "+N more", the index does not list those numbers, so they are not shown here. "no group in the index" means the index has no group for that command, not that it has no bugs.

## CE Drainage tab
1. **PIT**: 18 open or in progress in the index
    1. BUG-35: Rotated UCS — PIT placed inside or right after CD.
    2. BUG-37: Installer payload — `PIT BLOCK 2.dwg`.
    3. BUG-52: PIT BLOCK 3 — force-adoption + elimination of PIT BLOCK 2 across the suite. PIT/IO/OF/etc. inserts, drawing-open behaviour, installer payload.
    4. BUG-267: OOPS after erasing a PIT (Civil): its labels / linked text.
    5. BUG-287: Civil, drawings whose UNITS are Metres but whose CE pits are millimetre-sized (PIT inserts at scale 1: `PitCommand.cs:343-347`).
    6. BUG-426: C-21 Opus finalizer findings (8 Oct, TRAIN_C21_FINALIZER_REPORT.md; GO at 49034734, none blocks the install). **MEDIUM (#766):** in the Pit Schedule window type 9 in ...
    7. BUG-430: CODEX W20 on installed Civil 3.0.35 / Manager 1.1.35 (8 Oct 05:20, CODEX_VERIFYW20_2026-10-08.md; usage 27 -> 28%). **(1) Double-click on a CE pit label opens AutoCAD's ...
    8. BUG-458: HUNT-C-01 (HIGH): PIT, PP, CD, Edit Pit and the Pit Schedule all run while an Xref is open for in-place editing (REFEDIT). The one start check every Civil command uses ...
    9. BUG-464: HUNT-C-07 (MEDIUM): the Pit Schedule skips the read-only check. PIT, CD and Edit Pit refuse on a read-only drawing ("[CE] PIT cannot run - drawing is read-only."); ...
    10. BUG-465: HUNT-C-08..15 (eight LOWs, reading only): (08) pit cover text takes whatever text style is current (Commands/PitCommand.cs:730, PitEditCommand.cs:1795, ...
    11. BUG-690: PIT placed on an existing pipe (inline split route) (HUNT Civil E finding G1, installed Civil 3.0.51).
    12. BUG-691: PIT placed on one half of a breakline, same-plan-break or twin detention pipe (HUNT Civil E finding G2, installed Civil 3.0.51).
    13. BUG-692: PIT placed on a pipe whose callout text is pulled to the other side (HUNT Civil E finding G3, installed Civil 3.0.51).
    14. BUG-693: PIT placed on a pipe that has an arc (HUNT Civil E finding G4, installed Civil 3.0.51).
    15. BUG-793: Pit-block migration on open trusts the block name only and redefines PIT BLOCK 3 on every open
    16. BUG-1042: New Pit and Edit Pit refuse to go on when the cover level is blank
    17. BUG-1080: CDREFRESHBLOCKS changes the shared symbol that locked copies use
    18. BUG-1165: An old Civil bundle in the all-users folder supplies the pit blocks first
2. **PP**: no group in the index (no open bug named under this command)
3. **CDLPD**: 2 open or in progress in the index
    1. BUG-1153: The fixed-outlet (CDLPD) protection in Redesign is skipped when the LPD record cannot be read as exactly one outlet
    2. BUG-1158: "Same drawing" checks use AutoCAD's drawing identity, which a Save As copy keeps
4. **CDEDIT**: 13 open or in progress in the index
    1. BUG-70: `CDEDIT` / `PITEDIT` — AI suggestion strips (grade/invert strip, pit-setup strip)
    2. BUG-71: `CDEDIT` "Grade mismatch" popup + rising-main "Continue on another plan?" popup
    3. BUG-72: `CDEDIT` / `PITEDIT` — pit P-number label position on resize
    4. BUG-78: `CDEDIT` — can't move invert (IL) text above/below on an already-drawn pipe
    5. BUG-94: Civil CDEDIT pipe selection (MLINE / PLINE)
    6. BUG-173: Civil Edit Pipe (CDEDIT on a pipe) and New Pit / PIT windows: look.
    7. BUG-186: Edit 2 Pipes (CDEDIT batch) "Carry downstream", Civil 3.0.6. Found by Codex pass 13 (N4), 27 Sep 2026.
    8. BUG-223: CDEDIT (Edit Pipe) and the not-drawn-first CD path: flow direction of a pipe whose two ends have the SAME name (two "Open end"s). Found by the Opus review of PR #404 ...
    9. BUG-291: Civil CDEDIT batch 'Design grade' and the single editor's 'work it out from the grade': both hold the FIRST DRAWN END's level as upstream.
    10. BUG-445: CODEX W35 on installed Civil 3.0.38 / Manager 1.1.38 (8 Oct 13:37, CODEX_VERIFYW35_2026-10-08.md; usage 45 -> 47%): **the rebuilt #805 marker WORKS and its single U/12 ...
    11. BUG-674: CDEDIT multi-select pit resize (Plan length/width on several pits) (HUNT Civil E finding D2, installed Civil 3.0.51).
    12. BUG-677: CDEDIT on several pits that have no CE record, 'Pit label block' ticked On (HUNT Civil E finding D5, installed Civil 3.0.51).
    13. BUG-1049: Batch edit: one ticked but blank field disables Apply for the whole batch
5. **CDPITCOVERFLIP**: no group in the index (no open bug named under this command)
6. **CDRENUMBER**: 3 open or in progress in the index
    1. BUG-968: CDRENUMBER (PitRenumberCommand.cs:28, :69); no switch (Civil commands, Undo and Checks), ledger F-158.
    2. BUG-1005: CDRENUMBER. No switch (Civil commands, Undo and Checks), ledger F-202.
    3. BUG-1237: CDRENUMBER stops with "No pit discharges outside the network" and does not say what to draw
7. **DP**: 6 open or in progress in the index
    1. BUG-859: Double-click on a freshly placed downpipe (DP command, tag DP1) in Civil 3.0.68 (train C-58, #1499). Found by Codex V4 (22 Oct 2026, CODEX_VERIFY_V4_20261022_0634.md ...
    2. BUG-860: Double-click on the green DP label of a downpipe (Civil 3.0.68 / 3.0.69). Found by Codex V4 and V5 (22 Oct 2026); cause explained by Opus (REVIEWLANE_LOG entry 1588 item ...
    3. BUG-1118: Downpipe placement preview is a fixed 100 drawing units
    4. BUG-1209: A downpipe cannot be placed directly on a valid pit on AutoCAD 2022-2024
    5. BUG-1228: DP (downpipe) takes a long time to place, Civil 3.0.85 (Tim, 29 Oct 2026, by hand on his own PC: 'the dp command takes a long time'). The robot measured about 29 to 32 ...
    6. BUG-1242: The tag on every source block (DP, OF, FO, RG) does not show its number on the drawing; the number only shows in the Inspector
8. **IO**: no group in the index (no open bug named under this command)
9. **OF**: 2 open or in progress in the index
    1. BUG-1145: An Xref'd Pit Schedule shows "OUT OF DATE" and fails Project QA when nothing on the schedule changed
    2. BUG-1236: FO (front overflow) places a block whose symbol text says "OF", not "FO"
10. **FO**: no group in the index (no open bug named under this command)
11. **GIO**: no group in the index (no open bug named under this command)
12. **CDFW**: 2 open or in progress in the index
    1. BUG-650: Cancelling CDFW clears existing pit invert records before any placement
    2. BUG-1223: CDFW (floor waste), typed point on an inspection opening that sits on pipe ends, Civil 3.0.75 (runner case R36e, two runs b3x2 and b3x3, 25 Oct 2026).
13. **CDTG**: 3 open or in progress in the index
    1. BUG-432: C-22 Opus finalizer findings (8 Oct, TRAIN_C22_FINALIZER_REPORT.md; GO at 596ba72b; no HIGH). **MEDIUM (#769, cover check; advice only, writes nothing):** a trench grate ...
    2. BUG-743: CDTG trench grate, "Enter to skip" cover level (HUNT Civil B finding E4, installed Civil 3.0.53).
    3. BUG-745: CDTG trench drain in a Metres drawing (HUNT Civil B finding E6, installed Civil 3.0.53).
14. **CDRG**: 3 open or in progress in the index
    1. BUG-771: CDRG: Enter to finish the outline, or Undo at the second point, cancels the whole command
    2. BUG-773: CDRG can refuse a good raingarden by comparing saved numbers exactly; the stored "centroid" is the corner average
    3. BUG-1107: The raingarden outlet pit is never recorded
15. **CDWT**: 8 open or in progress in the index
    1. BUG-20: `CDWT` — Riser + Dropper sub-block auto-tagging in `Commands/WaterTankCommand.cs`.
    2. BUG-1081: Water Tank writes riser and dropper lettering onto a locked layer
    3. BUG-1083: Water Tank accepts an attached Xref as the block to turn into a tank
    4. BUG-1102: The council "minimum % of detention underground" is never checked
    5. BUG-1104: R-22 local tank orifice minimum and the "tank flows add up to no more than site PSD" check are never used
    6. BUG-1115: CDWT on the command line ignores a typed detention of 0
    7. BUG-1174: CDWT skips its window without saying why
    8. BUG-1212: CDWT loses both tank-selection pictures and the first window on AutoCAD 2022-2024
16. **CDSOURCE**: 1 open or in progress in the index
    1. BUG-740: CDSOURCE / COPY / CDTAG Set / source numbering setting, multi-word source names (HUNT Civil B finding E1, installed Civil 3.0.53).
17. **CDTAG**: 4 open or in progress in the index
    1. BUG-742: CDTAG on an untagged block (HUNT Civil B finding E3, installed Civil 3.0.53).
    2. BUG-814: Plain-words fixes from run 31: CDTAG retag refusal, CDFIXTAGS refusal sentence, CDCHECKS names pipes by handle, "AGI 1" spacing
    3. BUG-821: CDTAG ignores a block that is already selected and asks for a pick
    4. BUG-927: CDTAG messages, ledger F-096.
18. **CD**: 54 open or in progress in the index (45 numbers shown, 9 more not listed in the index)
    1. BUG-11: `CD` / `CDEDIT` — pipe callout (MLeader text label) placed WEST of the pipe
    2. BUG-14: `CD` command auto-calc grade — `MathHelper.TryParseGrade`
    3. BUG-15: `CD` command Custom Grade input — `CdCommand.BuildGradeValue` / `FormatGradeForDisplay`.
    4. BUG-16: `CD` command Custom Grade textbox — `CdViewModel.CustomGrade` setter + `CdDialog.xaml`.
    5. BUG-21: CD invert placement at near-vertical / steep angles (NW-to-SE direction at approximately 92-95° from north).
    6. BUG-23: `CD` — Rising Main split-across-plans workflow (PARK-032 multi-plan).
    7. BUG-25: `CD` auto-calc — invert display drift (e.g. typed `1.10` displays as `1.11`).
    8. BUG-27: `CD` / `CDEDIT` — Default-Minimum + Auto-Calc " MIN." suffix policy.
    9. BUG-30: `CD` — Rising Main continuation prompt (F12 dynamic input).
    10. BUG-31: `CD` — Rising Main continuation UX.
    11. BUG-34: `CD` / `CDEDIT` — Rising Main continuation mode auto-pick.
    12. BUG-41: `CD` — Custom grade multi-segment polyline support (R4.11 / round 4 / 2026-05-21).
    13. BUG-42: `CD` — regular (gravity) pipe breakline (R4.12 / round 4 / 2026-05-21).
    14. BUG-73: `CD` (draw-first mode) — WPF dialog pipe preview
    15. BUG-74: `CD` — pipe text + flow arrow placement ("move to another segment")
    16. BUG-75: `CD` / `CDEDIT` — invert (IL) text placed on top of the pipe
    17. BUG-76: `CD` dialog — upstream→downstream live suggestion
    18. BUG-77: `CD` — pit inlet→outlet drop propagated down the system
    19. BUG-91: Drainage `CD` free-point AutoCalc, `CDEDIT` local pipe Apply and invert-label MTEXT mask.
    20. BUG-166: double-clicking a CE level label (an IL text) should open Edit Pipe (`CompoundEditModeService`, the TEXTEDIT redirect). Area C (CD / pipe editing).
    21. BUG-187: CD, Existing line then back to Stormwater, Civil 3.0.6. Found by Codex pass 13 (N3), 27 Sep 2026.
    22. BUG-205: CD (New Pipe window, Start Pipe direction question), Civil 3.0.15 installed.
    23. BUG-286: Civil CD to a pit on a LOCKED layer (BUG-254 family, PR #469).
    24. BUG-308: Civil CD pipe end linking, CDDESIGN setup persistence and footer (Codex VERIFYC4C on installed Civil 3.0.18, 1 Oct 2026, report `CODEX_VERIFYC4C_2026-10-01.md`; 37 in ...
    25. BUG-331: Civil metre-drawing leftovers (from the PR #508 builder, 2 Oct): (1) CD REFUSES any pipe 1 m or shorter in a metre drawing (`ValidatePointGeometry` `<= 1.0`, "< 1mm"): a ...
    26. BUG-337: Civil CD level/direction in a metre drawing with a scaled pit (Codex VERIFYC6 run 6, item C6-04, 2 Oct 10:50, installed 3.0.21; ATTRIBUTION UNRESOLVED, Codex marked it ...
    27. BUG-427: CODEX W18 observations on installed Civil 3.0.34 / Structural 1.0.104 (8 Oct 03:53, CODEX_VERIFYW18_2026-10-08.md). **(1) MEDIUM to confirm (New Pipe, flat levels):** CD ...
    28. BUG-435: CODEX W24 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 07:28, CODEX_VERIFYW24_2026-10-08.md; usage 31 -> 32%; PASS 1 / BLOCKED 2 by a brief ...
    29. BUG-442: CODEX W32 on installed Civil 3.0.37 / Manager 1.1.37 / Structural 1.0.107 (8 Oct 11:16, CODEX_VERIFYW32_2026-10-08.md; usage 41 -> 43%; PASS 2 / FAIL 1 by my expected ...
    30. BUG-456: C-27 Opus finalizer findings (9 Oct, TRAIN_C27_FINALIZER_REPORT.md; GO at 319ba688 = 0daeefd6 + one fix commit; nothing HIGH, one MEDIUM FIXED, ten LOWs and one INFO). ...
    31. BUG-463: HUNT-C-06 (MEDIUM, R-00): levels typed in the Pit Schedule are rounded to 2 decimals in code (ViewModels/PitScheduleViewModel.Data.cs:1852 for IL, :1752 for cover, ...
    32. BUG-563: CD pipe with equal inverts, the command-line message, Civil 3.0.41 (Claude driver run 5, 10 Oct 03:15, areas/release-v3-colleagues-CLAUDE_DRIVER_RUN5_2026-10-10.md). LOW.
    33. BUG-669: Moving a pit twice by Properties palette or CD detention MovePit (HUNT Civil E finding C5, installed Civil 3.0.51).
    34. BUG-675: CD pit-fit check and Upsize with a rotated pit (HUNT Civil E finding D3, installed Civil 3.0.51).
    35. BUG-676: Edit Pit Save and CD Upsize overwrite the lid wording (HUNT Civil E finding D4, installed Civil 3.0.51).
    36. BUG-680: CD Upsize on a pit whose record number and label attribute disagree (HUNT Civil E finding D8, installed Civil 3.0.51).
    37. BUG-681: CD new pipe, Uphill warning answered Yes (flip) or Point Order mode (HUNT Civil E finding E1, installed Civil 3.0.51).
    38. BUG-682: CD, Cancel in the Uphill box (HUNT Civil E finding E2, installed Civil 3.0.51).
    39. BUG-683: CD same-plan break, real length typed after the level is worked out (HUNT Civil E finding E3, installed Civil 3.0.51).
    40. BUG-685: CD 'Work it out from the grade', typed level rounded. NEEDS TIM'S RULING (HUNT Civil E finding E5, installed Civil 3.0.51).
    41. BUG-686: CD or Edit Pipe flow arrow, a level of exactly 0.00 (HUNT Civil E finding E6, installed Civil 3.0.51).
    42. BUG-874: CD (Esc after a pipe with a callout), ledger F-004.
    43. BUG-941: CD window wording, ledger F-110.
    44. BUG-943: Repair Centre and CD help page wording, ledger F-112.
    45. BUG-996: CD (manual pipe text, Yes to mirror); no switch (Civil labels and Tidy labels), ledger F-193.
19. **CDREVERSEFLOW**: no group in the index (no open bug named under this command)
20. **CDTIDYLABELS**: 11 open or in progress in the index
    1. BUG-873: CDTIDYLABELS (Tidy labels), ledger F-003.
    2. BUG-879: CDTIDYLABELS hand-placement, ledger F-012.
    3. BUG-890: CDTIDYLABELS leader-out planning, ledger F-030.
    4. BUG-891: CDTIDYLABELS obstacle space and search margin, ledger F-031.
    5. BUG-893: CDTIDYLABELS preview versus Apply, ledger F-034.
    6. BUG-894: CDTIDYLABELS pit cover text, ledger F-035.
    7. BUG-895: CDTIDYLABELS on a layout sheet, cover text, ledger F-036.
    8. BUG-896: CDTIDYLABELS in a crowded drawing, ledger F-037.
    9. BUG-897: CDTIDYLABELS slide step Setting, ledger F-038.
    10. BUG-962: CDTIDYLABELS scan cost, ledger F-149.
    11. BUG-1034: Tidy labels Apply moves the IL text "in from the pipe end" onto its own pipe line
21. **CDANNOTATIONEDIT**: no group in the index (no open bug named under this command)
22. **CDMA**: no group in the index (no open bug named under this command)
23. **CDTEXTSEG**: 3 open or in progress in the index
    1. BUG-1161: Moving or flipping a pipe label forgets its kept wording (for example "APPROX.")
    2. BUG-1194: CDTEXTSEG picks the nearest leg midpoint, not the pipe leg you clicked
    3. BUG-1195: CDTEXTSEG writes a UCS angle into a World-plane text object
24. **CDSL**: 3 open or in progress in the index
    1. BUG-712: CDSL on a locked layer (HUNT Civil B finding B3, installed Civil 3.0.53).
    2. BUG-1175: Leftover wording points at Tim's own folders
    3. BUG-1201: Cancelling the first CDSL placement leaves an imported SPOT LEVEL block definition
25. **MR**: 2 open or in progress in the index
    1. BUG-519: HUNT3 1.1 and 1.2 (MEDIUM; the second part is untrue): Structural prints about 44 lines of program words on the command line at every AutoCAD start, and the list names ...
    2. BUG-1245: Move + Rotate (MR) and Copy + Rotate (CR) stop on Tim's selection with a code word in the message, and Tim cannot tell why
26. **CR**: 1 open or in progress in the index
    1. BUG-1246: Copy + Rotate of a downpipe: the copy "could not be given its own link on this AutoCAD", left as AutoCAD copied it
27. **CDSTRIP**: 3 open or in progress in the index
    1. BUG-22: `CDSTRIP` — Floor Waste placement at corners + 12m centres along straight runs.
    2. BUG-28: `CDSTRIP` — Floor Waste corner / end placement.
    3. BUG-29: `CDSTRIP` — fall arrow style.
28. **CDAGI**: 1 open or in progress in the index
    1. BUG-1052: CDAGI and CDPERIMETER report a flat drain as meeting the minimum grade in a metre drawing
29. **CDCHECKCURRENT**: no group in the index (no open bug named under this command)
30. **CDINSPECTOR**: 5 open or in progress in the index
    1. BUG-98: pit labels vs stored pit identity (plan label text, CDINSPECTOR, long section, schedule).
    2. BUG-99: CDINSPECTOR diagnostics text.
    3. BUG-518: HUNT3 2.1 (MEDIUM): the 'Show AutoCAD command names' switch (Tim, INT-075, 9 Oct about 08:30: show the plain name AND the AutoCAD command, switch on by default during ...
    4. BUG-994: CDINSPECTOR (select a pipe); editors.workshopLayout default ON (Wording and windows), ledger F-190.
    5. BUG-995: CDINSPECTOR > Show full detail > Drawing health buttons (failing grade, low cover, unconnected pits, disconnected pipes, duplicate numbers, missing levels). No switch ...
31. **PITSCHEDULE**: 19 open or in progress in the index
    1. BUG-457: second independent Opus review (read only, no build, 9 Oct, REDO_SAFETY_SECOND_REVIEW_20261009.md) of whether anything in the Civil code writes to the drawing, or takes ...
    2. BUG-780: Pit Schedule puts the wrong pipe on an inlet row when two inlets merge into "DPs"
    3. BUG-786: Saved row order splits a pit's rows once a pipe is added
    4. BUG-787: Typed pit-level cell values are saved per row and slide to another row when an inlet is added
    5. BUG-791: Pit Schedule window marks Pit Size and untouched cells as overridden on every commit
    6. BUG-799: An unloaded source Xref is reported as "SOURCE MISSING"
    7. BUG-817: Opening the Pit Schedule leaves an undo step of its own (U echoes PITSCHEDULE)
    8. BUG-965: PITSCHEDULE Refresh; also every automatic RefreshLinkedCells (for example after a Pit Schedule diameter sync); no switch (Civil records, schedules and sheets), ledger ...
    9. BUG-981: PITSCHEDULE, Source = Drainage XREFs (no switch) (Civil records, schedules and sheets), ledger F-172.
    10. BUG-1008: PITSCHEDULE (no switch) (Civil records, schedules and sheets), ledger F-206.
    11. BUG-1009: PITSCHEDULE with Source set to Drainage XREFs (switch is a window choice; default source is the current drawing, so this only happens after choosing Xrefs) (Civil ...
    12. BUG-1011: PITSCHEDULE, Auto-calculate depth unticked (default ticked) (Civil records, schedules and sheets), ledger F-209.
    13. BUG-1022: PITSCHEDULE, CDSYNC and any command that runs EnsureDrawingDataCurrent (runs on drawing load/change). No switch. (Civil records, schedules and sheets), ledger F-228.
    14. BUG-1023: PITSCHEDULE. Setting linking.scheduleRowOrderByPit default true (does not affect the stale test). (Civil records, schedules and sheets), ledger F-229.
    15. BUG-1031: Pit Schedule window: no "Delete cell" item on the cell right-click menu
    16. BUG-1035: Pit Schedule decides "Shallow" from a hidden fixed 300 mm depth
    17. BUG-1044: Two Xref drawings that both have a pit "P1" give an empty combined Pit Schedule
    18. BUG-1197: Updating one pit schedule can change another schedule's depth heading through a shared block definition
    19. BUG-1198: Cancelling a Pit Schedule export still saves the schedule's row order into the drawing
32. **CDPROFILE**: 17 open or in progress in the index
    1. BUG-756: Long section draws each pipe's top line at the next pipe's size
    2. BUG-759: CDPROFILE accepts a datum above the lowest pipe
    3. BUG-760: A level pipe with no grade label stops the whole long section
    4. BUG-761: An uphill pipe is printed as a normal falling grade with a velocity on the long section
    5. BUG-762: Invert above cover is hidden as depth 0.00; the review says Ready but the drawing prints -0.20
    6. BUG-763: CDPROFILE review grid row mixes two different pipes (size and speed from one, grade from the other)
    7. BUG-764: Long section boundary marks are found on the straight line between pit centres, not on the bent pipe; end-of-route chainage uses straight-line ...
    8. BUG-765: Any plain number in an Xref can become a surface level on the long section
    9. BUG-766: CDPROFILE never draws branch junction marks
    10. BUG-767: Existing-pipe stub at each end of the long section is drawn through the table frame
    11. BUG-768: Every pit counts as at least 1800 mm wide in the profile evidence
    12. BUG-769: CDPROFILE starts on the drawing's first schedule set, not the route's own set
    13. BUG-1012: CDPROFILE (and the older long-section output) (Civil records, schedules and sheets), ledger F-211.
    14. BUG-1020: CDPROFILE (long section), Review then Apply. Long-section office layout setting must list INVERT DEPTH for the text to show. (Civil records, schedules and sheets), ...
    15. BUG-1154: Some large records are saved as one long text value, unlike the rest of CE
    16. BUG-1192: The long section can hide a real depression: survey levels more than 1.20 m from the cover line are discarded without a warning
    17. BUG-1193: A curved property boundary is treated as a straight chord in the long section
33. **CDHELP**: 4 open or in progress in the index
    1. BUG-555: OFF-PC CALLS AUDIT route 15 (MEDIUM): CDHELP falls back to a web address that is NOT the company's domain. Modules/Drainage/Services/CdHelpService.cs 136-166, reached ...
    2. BUG-1215: Feedback Help promises a separate "Save report" and send step that does not exist
    3. BUG-1217: Calculations Help invites input to Pump System and WSUD calculators that are read-only
    4. BUG-1220: Reverse Flow Help promises a change preview and an Apply button that do not exist
34. **CDS**: 4 open or in progress in the index
    1. BUG-227: Civil ribbon tooltip for Settings (CDS), Civil 3.0.15. Only the installed guidance is the fault; the missing future features are simply not installed.
    2. BUG-825: Civil quietly puts a maximum pipe velocity of 3.0 m/s (or less) back to 6.0, and joint label heights under 200 to 250, at every start
    3. BUG-957: CDS (Settings) search, ledger F-141.
    4. BUG-958: Remember window position for Edit Pipe, Edit Pit, New Pit and CDS, ledger F-142.
35. **CDFEEDBACK**: 1 open or in progress in the index
    1. BUG-1166: Civil and Manager look for the office folders in different places
36. **CEBLOCKS**: 4 open or in progress in the index
    1. BUG-188: CEBLOCKS (CE Blocks palette, Manager - Modules/Manager/Services/CeBlocksInsertService.cs).
    2. BUG-524: HUNT3 heading 2, findings 2.2 to 2.8 (ribbon, tooltip and window words; grouped; the switch itself is BUG-518; severity kept per item). Tim, 9 Oct: plain name AND the ...
    3. BUG-1047: CE Blocks refuses a frozen (but unlocked) layer before asking for the point
    4. BUG-1243: CE Blocks (CEBLOCKS) does not work the way Tim wanted
37. **CDMANAGER**: 1 open or in progress in the index
    1. BUG-229: CDMANAGER > Layers > Draw Order list (Civil 3.0.15). An observation, not a Codex FAIL; cause Unknown.
38. **CDNEWDWG**: 1 open or in progress in the index
    1. BUG-969: CDNEWDWG (Civil records, schedules and sheets), ledger F-159.

## CE Design tab
1. **CDDESIGN**: 30 open or in progress in the index
    1. BUG-174: command-line questions (keyword prompts) across Civil and Manager; seen in CDDESIGN.
    2. BUG-259: CDDESIGN Confirm setup (Civil 3.0.16, #432): after "Confirm setup" the window reopens on Start without the picked outlet and During shows no agreed design (Codex ...
    3. BUG-319: CDDESIGN areas (from the Opus confirm of PR #497, 2 Oct).
    4. BUG-342: Civil C-6 adversarial review 2 (CDDESIGN setup, paste, OOPS/ERASE/COPY/ARRAY; Opus a3bd56e68fb7e4091, 2 Oct 11:15; report ...
    5. BUG-365: desk UI mapping session 7 (3 Oct; `C:\Lisp Files\_ACAD_DRIVER\UI_MAP_SESSION7_2026-10-03.md`): New Pit, CDDESIGN (5 tabs), Settings (6 tabs), Repair Center, Foundations ...
    6. BUG-490: AUDIT 01 A5 (privacy, leaves the office in the DWG): confirming a pipe connection or signing off a CDDESIGN redesign writes the colleague's Windows login INSIDE the ...
    7. BUG-506: HUNT2-C-02 (MEDIUM): the CDDESIGN calculation summary prints the connection pipe grade as '1:0'. What the reviewer sees: under CONNECTION PIPE the summary reads ...
    8. BUG-508: HUNT2-C-04 (MEDIUM): CDDESIGN works the flows and the connection pipe off the office rainfall curve, even when the job has its own curve, and says nothing. What the ...
    9. BUG-509: HUNT2-C-05 (MEDIUM): the CDDESIGN summary prints the office pre-development C, not the council's C that was used, so the page shows a figure the discharge did not use. ...
    10. BUG-510: HUNT2-C-06 (MEDIUM, breaks R-00 'nothing hard-coded' and design rule #1): roof and paved areas count as C 0.9 in CDDESIGN but 1.0 in CDCALC, neither on the Settings ...
    11. BUG-511: HUNT2-C-07 (MEDIUM, breaks R-00): CDDESIGN sizes the detention pipe with its own 40 m run and 225 to 600 mm sizes, not the Settings values CDRULES checks. What the ...
    12. BUG-538: R00_CIVIL items 4 (the council and rising-main parts), 5 and 6 (MEDIUM-HIGH; council rules written into the code, so a council change needs a new build of the plugin). ...
    13. BUG-783: A blanked cell ("Delete cell") comes back as the word DELETE; deep-pit Remarks print "DELETE With Step Irons"
    14. BUG-785: Depth on the drawn Pit Schedule changes after the next edit (the after-command refresh uses a different rule from the window)
    15. BUG-812: Redesign Apply puts new pits at the bottom of the schedule; copied pump pit with the same LABEL is skipped
    16. BUG-866: CDDESIGN detention storage: the office rainfall curve (Opus engineering audit 22 Oct, finding 3). HIGH (engineering, needs Tim's word).
    17. BUG-904: CDDESIGN storm sweep, ledger F-049.
    18. BUG-967: CDDESIGN (Yes to "look through the job's folders for its rating report") (Civil engineering numbers), ledger F-157.
    19. BUG-1004: CDDESIGN (During). No switch found (Civil engineering numbers), ledger F-201.
    20. BUG-1088: The automatic pipe sizer picks the smallest pipe at any grade, up to 1 in 1
    21. BUG-1091: Redesign and auto-design drop the minimum grade for pipes DN450 and larger
    22. BUG-1095: The council "minimum after-development C" is never applied ([council], [council], [council])
    23. BUG-1096: The rainwater-tank reuse credit never runs on a real job (R-10)
    24. BUG-1099: [council] and [council]: the council's own before-development C and lot-size Tc table are stored but never used
    25. BUG-1100: R-10 "ask on every job" is not built
    26. BUG-1106: A rating report naming a two-word council sets a council CE cannot find
    27. BUG-1110: CDDESIGN warns about council C values it never uses, and the council's own soft-ground C never wins
    28. BUG-1116: Lots of 1,000 m2 and over get Tc 5 min with no note
    29. BUG-1143: A damaged Design draft is replaced by the next Save Draft, losing the agreed design for good
    30. BUG-1156: An older CE wipes newer agreed-design answers from the Design draft
2. **CDCALC**: 24 open or in progress in the index
    1. BUG-3: `CDCALC` → CE Standard Orifice Pit Detail (CE_CVL_SUITE v3.0)
    2. BUG-158: CDCALC — Prepare export / calculation export package, and the test that was supposed to cover it.
    3. BUG-233: the computations sheet (CDCALC), the orifice discharge-coefficient line. Found by the Opus builder of PR #413 while rendering the sheet, 30 Sep 2026 ~09:10; NOT fixed.
    4. BUG-249: CDCALC Boyds calculation, intensity rows (`Modules/Drainage/ViewModels/BoydsCalcViewModel.cs` ~lines 87-92). Found by the Opus review of PR #427 ([place] 5 years), 30 ...
    5. BUG-507: HUNT2-C-03 (MEDIUM, breaks R-12 'Unknown stays Unknown'): CDCALC's Boyd's tab opens with another job's figures, and they flow on to the Detention tab and to CDDESIGN. ...
    6. BUG-515: HUNT2-C-11 (MEDIUM): the Boyd's storage can be too small when the worst storm is longer than the last row, and nothing says so. What the reviewer sees: CDCALC's Boyd's ...
    7. BUG-517: HUNT3 3.1, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8 (MEDIUM; the printed sheet goes onto paper and PDF): COLLEAGUE RELEASE GATE CANDIDATE (look and print). 'No blue' is not done ...
    8. BUG-539: R00_CIVIL item 1 (MEDIUM-HIGH, ENGINEERING-RESULT RISK; breaks R-00 'nothing hard-coded'; this is the Civil R-00 audit's number one; links to BUG-510, which found the ...
    9. BUG-543: R00_CIVIL items 2 and 24 (MEDIUM; the CDCALC Detention System tab always sizes the orifice with 0.6, and two other tabs use 0.61). What the drafter sees: the orifice ...
    10. BUG-544: R00_CIVIL, the 13 ranked values that HAVE a Settings name which the command ignores because it uses its own copy: items 2, 3, 7, 8, 11, 13, 14, 15, 21, 25, 26, 29 and 30 ...
    11. BUG-758: CDCALC "Older longitudinal" tab still writes long sections with none of CDPROFILE's checks
    12. BUG-772: WSUD tab accepts impervious area bigger than the site and negative areas
    13. BUG-905: CDCALC Boyd's tab versus CDDESIGN, ledger F-050.
    14. BUG-980: CDCALC > Pipe Flows > SELECT FROM DRAWING list (no switch) (Civil engineering numbers), ledger F-170.
    15. BUG-997: CDCALC > Older longitudinal > Update Existing. The tab is shown by default (Civil records, schedules and sheets), ledger F-194.
    16. BUG-1019: CDCALC > Detention system. No switch ("Use pit cover as TWL (suggested)" tick drives the invented value). (Civil engineering numbers), ledger F-224.
    17. BUG-1030: Closing CDCALC with nothing changed leaves an undo step of its own
    18. BUG-1033: CDCALC Pump System tab is read-only but shows no read-only banner
    19. BUG-1036: Pipe Flows tells the drafter roughness is 0.013 / 0.010 and calls them "office Settings values"
    20. BUG-1089: CDCALC Pipe Flows warns at its own fixed 0.5 and 3.0 m/s, not the Settings limits
    21. BUG-1097: R-13: the 300 mm minimum head on a charged downpipe system is never checked
    22. BUG-1101: CDCALC Catchments opens with a made-up catchment and a 15-minute storm
    23. BUG-1103: The Charged System tab takes pipe and downpipe sizes in metres with no sense check
    24. BUG-1112: WSUD export prints a sample site nobody typed
3. **CDRAINFALL**: 1 open or in progress in the index
    1. BUG-1216: Help retains the previous command for newer Civil tools (CDRAINFALL, CDDESIGN, CDCHECKS, CDRUNSOLVE)
4. **CDTWL**: 7 open or in progress in the index
    1. BUG-545: R00_CIVIL items 19 and 20 (MEDIUM-HIGH, ENGINEERING-RESULT RISK; two or three Settings names for one thing, two of the audit's top 40 and the only ones the audit marks ...
    2. BUG-777: CDTWL suggests "highest invert plus its pipe", not the highest obvert, as the default top water level
    3. BUG-871: CDTWL on metre drawings (audit finding 10). MEDIUM.
    4. BUG-970: CDTWL (no switch) (Civil engineering numbers), ledger F-160.
    5. BUG-1021: CDTWL. No switch. (Civil engineering numbers), ledger F-226.
    6. BUG-1032: CDTWL pick list: handle instead of a pipe name, doubled "pipe", and negative "below the lowest lid"
    7. BUG-1056: CDTWL can say "That is enough" when the water is only 100 mm below a habitable floor
5. **CDRUNSOLVE**: 5 open or in progress in the index
    1. BUG-56: `CDRUNSOLVE` (monorepo `Modules/Drainage`)
    2. BUG-290: Civil: several commands run a full refresh of the pipe records from the drawing BEFORE their own preview or question: CDRUNSOLVE, CDAGI, CDSTRIP, CDPROPAGATE, CDUPGRADE ...
    3. BUG-311: CDRUNSOLVE / CDPROPAGATE cancel (#492, disclosed by its builder).
    4. BUG-868: CDRUNSOLVE, network redesign and size proposals (audit finding 2). HIGH.
    5. BUG-999: CDRUNSOLVE (also the hand-off from Edit Pit). No switch (Civil engineering numbers), ledger F-196.
6. **CDDEST**: no group in the index (no open bug named under this command)
7. **CDRULES**: 26 open or in progress in the index
    1. BUG-239: CDRULES findings, the review windows, Manager project QA and the CDAUTO proposal report (Civil 3.0.15 / Manager 1.1.15). Found by the Opus confirm of PR #420 (BUG-233), ...
    2. BUG-441: C-23 Opus finalizer findings (8 Oct, TRAIN_C23_FINALIZER_REPORT.md; GO at 09a0e66b = nine PRs, #805 REVERTED OUT by the finalizer's one commit; no HIGH left). **#805 ...
    3. BUG-461: HUNT-C-04 (MEDIUM): CDRULES and CDCHECK can say "Nothing was changed" after something was changed. CDRULES records the run in the drawing (Commands/RulesCommand.cs:111), ...
    4. BUG-514: HUNT2-C-10 (MEDIUM): CDRULES adds a 'Velocity uses Assumed roughness' warning for every pipe, even after Tim confirms the roughness. What the drafter sees: CDRULES gives ...
    5. BUG-520: HUNT3 4.1, 4.2, 4.3, 4.4 (4.3 MEDIUM because the command is live; the rest LOW-MEDIUM; breaks the Settings-first rule R-00): new engineering values have no row on the ...
    6. BUG-521: HUNT3 5.1 (MEDIUM, ENGINEERING-RESULT RISK): the minimum pipe cover is read from two places that can disagree on the same pit. CDRULES uses council, then project, then ...
    7. BUG-527: HUNT3 heading 5, findings 5.2 to 5.4 (one Settings value read from two places that can disagree; grouped; severity kept per item; the cover split is BUG-521). (5.2, ...
    8. BUG-540: R00_CIVIL items 7 and 8 (MEDIUM-HIGH, ENGINEERING-RESULT RISK; two readers for one value). What the drafter sees: the Pit Schedule writes 'With Step Irons' against any ...
    9. BUG-542: R00_CIVIL item 11 (MEDIUM, ENGINEERING-RESULT RISK; the long section works out pipe speeds with its own roughness list, one of the audit's seven places where two screens ...
    10. BUG-546: WINDOW ROWS FOR CODEX (Civil): R00_CIVIL item 86 and items 15, 19, 20, 30, 37, 56 (MEDIUM; more than 30 engineering values already have a name in CD_Settings.json but NO ...
    11. BUG-547: R00_CIVIL, the remaining ranked values grouped (LOW-MEDIUM; every value named with file:line, all under Modules/Drainage; none seen in AutoCAD; items already filed above ...
    12. BUG-867: CDRULES and CDCHECKS grade and speed (audit finding 1). HIGH.
    13. BUG-901: CDRULES R-04 cover, ledger F-042.
    14. BUG-902: CDRULES cover between pits, ledger F-043.
    15. BUG-903: Inspector, Hub, repair checks versus CDRULES, ledger F-045.
    16. BUG-906: CDRULES R-30 versus R-06, ledger F-051.
    17. BUG-907: CDRULES pit drop where the pipe gets bigger, ledger F-052.
    18. BUG-923: CDRULES row wording, ledger F-092.
    19. BUG-924: CDRULES "no minimum in the rulebook", ledger F-093.
    20. BUG-1006: CDRULES (Explain), CDCHECKS rows; no switch (Civil engineering numbers), ledger F-203.
    21. BUG-1057: Council velocity limits never reach the pipe speed checks
    22. BUG-1059: [council]'s recorded DN150 minimum grade (1 in 80) is not applied
    23. BUG-1060: New jobs show the stormwater standard edition as 2021
    24. BUG-1090: Nothing says the hydraulic grade line and pit losses were not checked
    25. BUG-1092: A pipe up to 5 mm uphill is reported "essentially flat", not "flows uphill"
    26. BUG-1111: The before-development "formula" text still says 0.3 while the number beside it is worked from 0.35
8. **CDRULEBOOK**: 2 open or in progress in the index
    1. BUG-1109: No council value can be edited anywhere in the product
    2. BUG-1213: Older AutoCAD cannot open the council evidence behind a value or saved rule finding
9. **CDSYSTEM**: no group in the index (no open bug named under this command)
