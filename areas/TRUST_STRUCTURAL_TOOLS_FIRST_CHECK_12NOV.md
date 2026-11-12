# Trust checklist, first pass on the 32 Structural core tools (12 Nov 2026)

**Status: DRAFT from records, written 12 Nov 2026, 23:50 PC clock. Nothing was run.** A box marked passed here means a record says so, not that it was re-checked. Where this chat read the installed code (Structural 1.0.126, commit 8de95c34) it says "code".

Part of area TRUST. Checklist: `areas\TRUST_RULES_CHECKLIST_12NOV.md`. Tool list: the 32 KEEP buttons in `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`. Same shape as the Civil first check (`areas\TRUST_CORE_TOOLS_FIRST_CHECK_12NOV.md`).

---

# FOR TIM

1. **Your hand pass is on record for none of the 32 Structural tools.** Your only recorded Structural word is that CLEAN must save again (5 Nov).
2. **Codex has passed parts of 18 of them, all on older builds** (beams on 1.0.77, C1 and TS1 on 1.0.109 to 1.0.110, the rest on 1.0.116). **None was looked at on 1.0.126,** the build on your PC.
3. **13 of the 32 have an open fault that can hide, overstate or leave out a value** (marked DATA below). The worst four are all about numbers on a sheet:
   1. **Bracing schedule:** one row short when made, and erased braces stay listed (BUG-497, 498). Code confirms both.
   2. **Bracing totals:** roof trusses counted as wall bracing (BUG-499). Code confirms.
   3. **Column size:** C1 and C2 take the first schedule row by mark, whatever the floor (BUG-501). Code confirms.
   4. **Schedule sync:** rearranging pier schedule rows can resize the wrong piers (BUG-1183, HIGH).
4. **Also confirmed in code:** the required bracing figures are kept on the PC, not in the drawing, so the last job's figures sit on the next job (BUG-500). Code: `Commands\BracingPanelCommands.cs:93, 123`.
5. **Five in the best state:** the beam tools 1, 2 and 4 (Codex-accepted on 1.0.77, no DATA fault), AB and ABS (Codex narrow pass on 1.0.116), SC1. None is complete and none has been seen on 1.0.126.
6. **Rule 1 line 3 (Cancel leaves everything as it was) is proven by the robot for no Structural tool.** Records show it failing for P1 (Escape still places a purlin, BUG-585) and for C1 and TS1 (cancel leaves the layer changed, BUG-434, fix installed, untested).
7. **Boxes never checked for any Structural tool:** two Windows logins, every value on Settings, your three days on real jobs, your words "it is in", and the whole of rule 5 (no tool note).

---

## How to read each block

1. **Accepted on record:** your hand pass, or "Codex-accepted" by name. A Codex "narrow pass" covers only the slice named.
2. **Faults:** from the carpark, found by a records search on each command name; titles shortened. "Fix installed, untested" = the carpark says a fix went into 1.0.121 and nobody has tested it. Many entries are 9 Oct code-reading finds never seen in AutoCAD.
3. **DATA** marks a fault that loses, hides, overstates or silently leaves out a value. It is a reading of each entry's first lines.
4. **Uses:** your command log on real jobs from 3 Jun (`CORE_TICK_LIST_05NOV.md`). Only DS, DS1, C1, C2, AB, BB and the beam group have counts.
5. **Rules that hold for every tool** unless the block says otherwise: Rule 5 is "none written yet" for all. Rule 4 line 4 and 5 (your trial, your word) are open for all.

---

# ROOF

**1. R1 (rafter marks)**
1. **Used:** few (no count).
2. **Accepted on record:** Codex narrow pass on 1.0.116 (14 Oct): Escape restores the controls; tag placement, one Undo, delayed Redo, reopen.
3. **Open faults:** BUG-584 bay sizes do not reach the block (DATA, fix installed, untested; Codex FAIL on 1.0.116). BUG-467 wrong place in a rotated UCS. BUG-472 writes to model space from a layout or REFEDIT. BUG-471 ignores metre drawings: **stale by code**, R1 now stops in a drawing that is not in millimetres (`Commands\RafterJoistCommands.cs:100`).
4. **Rule 1:** open. One Undo passed narrowly; Cancel not robot-proven; REFEDIT fault on record (BUG-472).
5. **Rule 2:** open. Millimetre-only by code (it says so and stops). Two logins and 2022 to 2024 never checked.
6. **Rule 3:** open. BUG-584 draws a width that is not the bay's.

**2. P1 (purlin marks)**
1. **Used:** few.
2. **Accepted on record:** Codex narrow pass on 1.0.116 for output recovery; partial for lap 0 or 1200, one Undo, reopen.
3. **Open faults:** BUG-585 Escape at the lap question still places a purlin (fix installed, untested; Codex FAIL on 1.0.116). BUG-584 wrong base width (DATA, fix installed, untested).
4. **Rule 1:** failing on record (BUG-585).
5. **Rule 2:** never checked beyond the millimetre stop (code, same line as R1).
6. **Rule 3:** open (BUG-584).

**3. BT1 (roof bracing truss)**
1. **Used:** no count (bracing group).
2. **Accepted on record:** Codex narrow pass on 1.0.116: number checks, default 2700 mm, one Undo, delayed Redo, totals update, reopen. The record says this does not approve trusses counting toward wall totals.
3. **Open faults:** BUG-499 trusses added to wall totals (DATA; code confirms, `Commands\BracingCommands.cs:318-320` and `Services\ProjectDataService.cs:282-283`). BUG-467 rotated UCS. BUG-472 layout or REFEDIT. BUG-473 no locked-layer check (not re-read for BT1). BUG-535 values with no Settings box (DATA, soft).
4. **Rule 1:** open (BUG-472, 473).
5. **Rule 2:** open. Millimetre-only by code (`BracingCommands.cs:249`).
6. **Rule 3:** failing on record (BUG-499).

# UPPER FLOORS

**4. Beam tools 1, 2, 4 and 5**
1. **Used:** 211 for the "BEAM" group; which number is not known.
2. **Accepted on record:** Codex-accepted on 1.0.77 (27 Sep) for 1, 2 and 4: point mode, left and down, beams follow a moved column (BUG-182, 183, 184 FIXED, Codex-accepted). Codex W40 on 1.0.109: beam 1 on two columns (BUG-449 FIXED, Codex-accepted). Nothing for 5.
3. **Open faults:** BUG-050 label side flips with the pick order (fix installed, untested). BUG-211 erasing a column with a beam attached (fix installed, untested). BUG-577 wrong message with drawing units unset (fix installed, untested). BUG-185 metre drawings (built 27 Sep for 1.0.78, never checked). BUG-085, 088, 089 are August entries still "in progress"; probably stale.
4. **Rule 1:** partly passed on record (one U when beams follow, BUG-184). Cancel not robot-proven.
5. **Rule 2:** open. By code the beam tools scale for millimetre, metre and inch drawings and refuse others (`Services\ConnectedDesign\Host\BeamCommandAutoCadRenderPort.cs:65-75`); never proven in a metre drawing.
6. **Rule 3:** no DATA fault on record.

**5. BDL (paired beam lines)**
1. **Used:** no count.
2. **Accepted on record:** none. A pending test lists "BDL paired output, movement, copy" as still to do.
3. **Open faults:** none naming BDL on its own.
4. **Rules 1 to 3:** never checked.

**6. BSET, BSETLIST, BSETRESET (beam inside point)**
1. **Used:** no count.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1077 tooltip and Help use an internal word. No entry for BSETLIST or BSETRESET.
4. **Rule 1:** never checked.
5. **Rule 2:** never checked. Whether the inside points live in the drawing or on the PC was not read.
6. **Rule 3:** open on wording only (BUG-1077).

**7. DS (double stud)**
1. **Used:** 211, the most used Structural tool.
2. **Accepted on record:** Codex narrow pass on 1.0.116: fallback and recovery.
3. **Open faults:** BUG-1139 a column on a copied beam takes over the original's links. BUG-439 layer restored after placing (fix installed, untested). BUG-537 symbol size 90 x 90 (code-reading find).
4. **Rule 1:** open (BUG-1139). Locked layer refused before drawing (code, `Commands\SupportBlockCommands.cs:225-231`).
5. **Rule 2:** millimetre-only by code (`SupportBlockCommands.cs:216`). Two logins never checked.
6. **Rule 3:** open. With a member schedule present, a size the block cannot show is drawn as the default while the line names the schedule size (code, `SupportBlockCommands.cs:1470-1480`).

**8. DS1 (double stud with tag)**
1. **Used:** 93.
2. **Accepted on record:** Codex narrow pass on 1.0.116: the label.
3. **Open faults:** BUG-468 columns placed with linking off are invisible to the level-below tools (fix installed, untested). BUG-537.
4. **Rule 1:** never checked beyond the label.
5. **Rule 2:** as DS.
6. **Rule 3:** open, as DS (a timber stud pack in the schedule draws 90 x 90 unasked).

**9. TS1 (triple stud with tag)**
1. **Used:** under 10.
2. **Accepted on record:** Codex-accepted on 1.0.109 (BUG-449, W40). Codex narrow pass on 1.0.116: label-side Escape.
3. **Open faults:** BUG-437 Enter at the text question refused, Esc removes the placed support (fix installed, untested). BUG-434 cancel leaves the layer changed (fix installed, untested). BUG-424 raw error word on a locked layer. BUG-439, 468, 548.
4. **Rule 1:** open (BUG-434, 437).
5. **Rule 2:** millimetre-only by code.
6. **Rule 3:** open on wording (BUG-424).

**10. C1 (column marker)**
1. **Used:** 60.
2. **Accepted on record:** Codex-accepted on 1.0.109 (BUG-449); Codex W43 wording PASS on 1.0.110; Codex narrow pass on 1.0.116: placement, mark, one U, REDO, rotation Escape.
3. **Open faults:** BUG-501 size by mark, ignoring the floor (DATA; code confirms, `Services\MemberScheduleService.cs:31-44`). BUG-438 the number question fails (fix installed, untested). BUG-437, 434, 439, 468, 1139. BUG-448 first default (observation PASS, not accepted). BUG-211.
4. **Rule 1:** open (BUG-434, 437, 1139).
5. **Rule 2:** millimetre-only by code.
6. **Rule 3:** failing on record (BUG-501).

**11. C2 (column type picker)**
1. **Used:** 12.
2. **Accepted on record:** none.
3. **Open faults:** BUG-501 (DATA). BUG-974 excluded schedule rows still used (DATA in the carpark; **fixed in the installed code**, `Services\XclmTxtService.cs:303-319`, so the entry needs a proof, not a fix). BUG-576 window says "Press 1-8" but 9 works (fix installed, untested). BUG-1139, 468, 537. BUG-086 August, probably stale.
4. **Rule 1:** never checked.
5. **Rule 2:** millimetre-only by code.
6. **Rule 3:** failing on record (BUG-501).

**12. SDS and SDS1 (change to double stud)**
1. **Used:** under 10 each.
2. **Accepted on record:** none.
3. **Open faults:** BUG-975 a switch swings a neighbour's label. BUG-548 (LOW findings).
4. **Rule 1:** open (BUG-975 moves something not picked).
5. **Rules 2 and 3:** never checked.

**13. STS1 (change to tagged triple stud)**
1. **Used:** under 10.
2. **Accepted on record:** none.
3. **Open faults:** BUG-424 raw error word on a locked layer. BUG-548.
4. **Rules 1 to 3:** never checked, except the wording fault.

**14. SC1 (change to column marker)**
1. **Used:** under 10.
2. **Accepted on record:** Codex narrow pass on 1.0.116: refusal on a locked layer.
3. **Open faults:** BUG-548 only.
4. **Rule 1:** locked layer passed narrowly. Cancel not checked.
5. **Rules 2 and 3:** never checked.

**15. SC2 (change column type)**
1. **Used:** under 10.
2. **Accepted on record:** Codex narrow pass on 1.0.116: conversion and recovery.
3. **Open faults:** BUG-975, BUG-576 (fix installed, untested), BUG-548.
4. **Rule 1:** open (BUG-975).
5. **Rules 2 and 3:** never checked.

**16. FJ1 (joist marks)**
1. **Used:** few.
2. **Accepted on record:** Codex narrow pass on 1.0.116: output, one Undo, delayed Redo.
3. **Open faults:** BUG-584 (DATA, fix installed, untested; Codex FAIL on 1.0.116).
4. **Rule 1:** one Undo passed narrowly.
5. **Rule 2:** millimetre-only by code.
6. **Rule 3:** open (BUG-584).

# WALLS AND GROUND

**17. AB (A bracing)**
1. **Used:** 93.
2. **Accepted on record:** Codex narrow pass on 1.0.116: 2700 mm brace, A mark, one Undo, delayed Redo, panel total 2700; locked-layer refusal.
3. **Open faults:** BUG-428 a long brace drawn with no warning (DATA, soft; fix installed, untested). BUG-497, 498, 499 through the schedule and panel (DATA).
4. **Rule 1:** one Undo and locked layer passed narrowly.
5. **Rule 2:** millimetre-only by code (`BracingCommands.cs:18`).
6. **Rule 3:** open. A brace with its type cleared is counted as A (code, `Services\ProjectDataService.cs:316-320`).

**18. BB (B bracing)**
1. **Used:** 134.
2. **Accepted on record:** Codex narrow pass on 1.0.116: locked-layer refusal.
3. **Open faults:** BUG-428 (DATA, soft). BUG-525 icon colour.
4. **Rule 1:** locked layer passed narrowly.
5. **Rule 2:** millimetre-only by code (`BracingCommands.cs:134`).
6. **Rule 3:** as AB.

**19. ABS (switch A and B; also ABSWITCH)**
1. **Used:** no count.
2. **Accepted on record:** Codex narrow pass on 1.0.116: switch, Undo, delayed Redo.
3. **Open faults:** BUG-583 a locked brace opens an error window (seen in AutoCAD 14 Oct; no fix).
4. **Rule 1:** open (BUG-583; protection held, but the window is a raw error).
5. **Rules 2 and 3:** never checked.

**20. CSBRACINGPANEL (required against provided)**
1. **Used:** no count.
2. **Accepted on record:** BUG-218 FIXED (Codex-accepted, narrow pass on 1.0.116): the panel shows.
3. **Open faults:** BUG-499 trusses in wall totals (DATA, code confirms). BUG-500 required figures kept on the PC, so the last job's figures show on the next job (DATA; code confirms, `Commands\BracingPanelCommands.cs:93, 123`). BUG-950 panel colour when brace types differ (draft fix, not installed).
4. **Rule 1:** read-only panel; not applicable beyond the required-figure command.
5. **Rule 2:** failing by code (BUG-500: the same drawing shows different required figures on two PCs).
6. **Rule 3:** failing on record (BUG-499, 500; blank type counted as A).

**21. STRSCHEDCREATE (make the schedules)**
1. **Used:** no count.
2. **Accepted on record:** none.
3. **Open faults:** BUG-497 tables one row short (DATA; code confirms, `Services\ScheduleService.cs:384`). The fix is in the held S-46 build only.
4. **Rule 1:** never checked.
5. **Rule 2:** never checked.
6. **Rule 3:** failing by code (BUG-497).

**22. STRSCHEDREFRESH (refresh a schedule)**
1. **Used:** no count.
2. **Accepted on record:** none.
3. **Open faults:** BUG-498 erased braces and piers stay listed (DATA, overstates; code confirms, `ScheduleService.cs:681-723`). BUG-503 raw error word on a locked layer.
4. **Rules 1 to 3:** failing on record (BUG-498).

**23. STRSCHEDSYNC (push schedule values back to the blocks)**
1. **Used:** no count.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1183 rearranging pier schedule rows can resize the wrong piers (HIGH, DATA). By code the bracing sync writes table values back into the blocks with no check that a brace was erased (code reader's reading; not re-read here).
4. **Rule 1:** failing on record (BUG-1183 changes blocks you did not mean to change).
5. **Rules 2 and 3:** never checked.

# ON EVERY DRAWING

**24. CLEAN (and FASTSAVE)**
1. **Used:** not in the log (typed). Your 5 Nov word: it must save.
2. **Accepted on record:** none on 1.0.126. Earlier CLEAN results were invalidated in September.
3. **Open faults:** BUG-425 adds an empty Undo step (fix recorded as installed, untested). BUG-620 FASTSAVE still purges and moves Xrefs (source finding). BUG-411 the F2 key runs CLEAN (needs your decision). Not in the carpark yet, found in code by this lane: the tooltip and the Settings page say CE never saves (registry lines 4145-4146; `UI\Dialogs\CeSettingsDialog.xaml:557`); a failed save can still be reported as done (`Services\CleanPipelineService.cs:167-169`); one object on a locked layer fails a whole step (lines 409, 526, 232-236).
4. **Rule 1:** open. It changes much more than its name (purge, Xrefs to XREF, text to Arial Narrow, ByLayer). It prints a summary.
5. **Rule 1 line 5 (never saves):** CLEAN saves by your decision. It is the one tool where saving is the job; its words must say so (card TRUST-S2).
6. **Rule 2:** never checked.
7. **Rule 3:** open (says "never saves" while it saves).

**25. CEHELP**
1. **Used:** no count.
2. **Accepted on record:** none.
3. **Open faults:** BUG-1077, 1078, 1079 internal words in Help. BUG-1219 Beam and Rafter-Joist Settings Help describes questions the commands do not ask.
4. **Rule 1:** not applicable (read only).
5. **Rule 3:** open (BUG-1219 describes questions that do not exist).

**26. CESETTINGS**
1. **Used:** no count.
2. **Accepted on record:** Codex narrow pass on 1.0.116: 23-page layout and timer Escape.
3. **Open faults:** BUG-826 Reset Defaults wipes the whole file in one click (HIGH, DATA; code confirms, `UI\Dialogs\CeSettingsDialog.xaml.cs:475-478`). BUG-840 a second AutoCAD's save reverts a change (DATA). BUG-841 a mistyped number is ignored and the window closes as if saved (DATA). BUG-1072 "CE never saves" note against an autosave tick. BUG-536 eight commands ignore a Settings value (DATA). BUG-299, 520, 530, 535 values with no Settings box or loaded without warning. BUG-575 version reads 1.0.1.0.
4. **Rule 1:** failing on record (BUG-826, 841).
5. **Rule 2:** failing by code. The whole settings file is written at first start, so each login keeps the defaults of the build it first ran (`Services\SettingsService.cs:675-684`).
6. **Rule 3:** open (BUG-1072, 841).

---

# What this did not check

1. **Nothing was run.** No AutoCAD, robot, build or test.
2. **Carpark matches are by command name** in each entry's heading and first lines, by a records search; titles were shortened, not re-read in full, except six spot-checked by this chat (BUG-500, 583, 585, 620, 826, 1183).
3. **Short names were hard to search.** About 30 Civil entries use P1, C1 or C2 as pit numbers; they were left out. A Structural entry that names a tool only deep in a long bundle may be missing.
4. **The robot ledger names cases, not commands,** so no robot result could be tied to a Structural tool.
5. **"Fix installed, untested" is a 23 Oct reconciliation** and may be stale at 1.0.126.
6. **DATA marks are a reading** of each entry's first lines.
7. **No client or job names** were carried from carpark entries.
