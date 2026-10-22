# Audit: engineering correctness of the installed Structural line (Thu 22 Oct 2026 late, to Fri 23 Oct 00:10 Melbourne)

Independent senior structural review, Opus 5.5 (claude-opus-5-5), read only. Nothing built, no test run, AutoCAD and Codex
not started, no source, Settings, bundle or log file changed. I read the code with `git archive` of the installed head and
did my own arithmetic (a small throwaway script that recomputes mass and second moment from each catalogue row's own
dimensions). I have no copy of any Australian Standard or supplier catalogue here: every standard or catalogue figure below
is from memory and says so.

**Scope:** `origin/claude/rel-20261022s2` @ `2c9a9694` (Structural 1.0.121), `Modules/Structural` and
`Modules/Structural.DesignCore`.

**Read first so as not to repeat them:** `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`,
REVIEWLANE_LOG entries 1550 to 1593, `R00_STRUC_2026-10-09.md`, `HUNT_STRUC_BRACING_REO_2026-10-12.md`, and the carpark
entries BUG-531, BUG-534, BUG-614, BUG-748, BUG-818, BUG-819. Where a finding below touches one of these, it says so.

---

## ANSWER FIRST (for Tim)

1. **Counts (new findings only): HIGH 1, MEDIUM 7, LOW 6.** Plus a confirmation of BUG-818 (the steel section list) with
   my own arithmetic, not counted again.
2. **Most likely to put a wrong number on an issued drawing (MEDIUM 1):** the member schedule tool XCLMTXT rounds every
   UB and UC to a whole number. Paste "410UB59.7" from the engineer's schedule and the drawing says **410 UB 60**;
   "250UB25.7" becomes **250 UB 26**, a section that does not exist. It happens on every schedule that uses the supplier
   names, and it goes against your 19 Oct answer ("supplier names with decimals ... yep why not").
3. **Worst when it happens (HIGH 1):** the same tool turns the angle symbol into **EA** for every unequal angle except
   150x100x10. A lintel "150x90x10 UA" comes out on the schedule as **150 x 90 x 10 EA**, an equal angle with unequal legs.
4. **Next (MEDIUM 2):** since S-41 the load-bearing-wall-over hatch (LBH) at 1:100 has hatch lines 5 times further apart
   than the office standard: one line every 1.1 m along a wall instead of every 225 mm. A 900 mm wall nib can show no line
   at all, so it reads as not load bearing. The S-41 finalizer said LBH "has had no look".
5. **Also MEDIUM:** the bracing panel adds up metres of brace of every type and calls it enough, with no rating per metre
   (MEDIUM 3); TH, PF, BP, column, 18-text and setout tags are a fixed 250 (or 200, 180) at every scale, so they plot 5 mm
   high at 1:50 beside 2.5 mm notes (MEDIUM 4); SBEAM and CEMEMBER draw the same beam at different sizes at every
   DIMSCALE except 20 (MEDIUM 5); the scale-aware hatches still refuse to draw when LTSCALE is not 10 x DIMSCALE, a hard
   stop R-27 does not allow (MEDIUM 6); the fixed template hatches disagree with their own scale-aware twins (MEDIUM 7).
6. **Checked and sound:** bar mass per metre N10 to N36 (0.617 to 7.990 kg/m) and the bar schedule arithmetic (rows rounded
   to 0.1 kg, the total adds the printed rows); bar marks never reuse an erased number; the reo note and "N12-200" label
   format; drawing-unit factors for all 24 INSUNITS codes; CEMEMBER break lines (1.5 and 2 mm on paper times DIMSCALE:
   30/40 at 1:20, 75/100 at 1:50, 150/200 at 1:100); CEMEMBER base point on nine box positions; EARTH and AR-CONC
   (CH) scales are proportional (8, 20, 40 and 1, 2.5, 5 at 1:20, 1:50, 1:100); the waffle hatch stays real size;
   CHS and unequal-angle masses; UB and UC dimensions.
7. **Not checked:** nothing in AutoCAD; the pattern files themselves (ANSI31 spacing 3.175 mm and DOTS pitch 1.5875 mm at
   scale 1 are from memory of acadiso.pat); the corrected draft section list on your other PC; Civil and Manager.

---

## Numbered findings

### 1. HIGH: XCLMTXT turns every unequal angle except 150x100x10 into "EA" on the member schedule

1. **Where:** `Modules/Structural/Services/ExcelMTextService.cs` lines 5784 to 5791 (in `ExpandMemberAbbreviation`, run
   for the member description column by `ProcessColumn2Text`, line 5161). When the pasted text holds the angle symbol
   (it arrives as the characters `L ]L`), the code writes **UA only if the text contains 150X100X10**, and **EA for
   everything else**.
2. **Standard or table:** the supplier angle ranges (InfraBuild/OneSteel equal and unequal angles, AS/NZS 3679.1). Not
   certain of the exact glyph the office Excel template produces; the replacement itself is verified by reading.
3. **Plain words for Tim:** paste a lintel schedule with "150x90x10 [angle]" and the drawing schedule says
   "150 x 90 x 10 EA". Every unequal angle the office uses for lintels (100x75x6, 125x75x8, 150x90x8, 150x90x10) is
   relabelled as an equal angle. A fabricator reading "EA" may order 150x150x10 EA or 90x90x10 EA.
4. **Worked example:** input "150x90x10 L ]L LINTEL". Code: "150 x 90 x 10 EA LINTEL". Correct: "150 x 90 x 10 UA LINTEL".
   Input "150x100x10 L ]L": code "UA", correct, the only case that works.
5. **Right rule:** equal legs (first two numbers the same) = EA, unequal = UA. No size list needed.
6. **DETERMINISTIC TEST:** pure test on `ExpandMemberAbbreviation` (or `ProcessColumn2Text`) with four inputs:
   "150x90x10 L ]L" expects "UA"; "100x75x6 L ]L" expects "UA"; "100x100x8 L ]L" expects "EA";
   "150x100x10 L ]L" expects "UA". Today the first two fail.
7. **Status:** verified by reading. How often the office source text carries the `L ]L` glyph: not certain.

### 2. MEDIUM (most likely wrong number): XCLMTXT rounds every UB and UC to a whole number, and its own spelling table disagrees with the section list

1. **Where:** `ExcelMTextService.cs` lines 6061 to 6078 (`NormalizeUcUbWholeNumbers`, called at line 5172 on every
   description) rounds the mass part with `Math.Round(..., AwayFromZero)`. The built-in spelling table at lines 249 to
   342 truncates instead ("410UB59" -> "410 UB 59", "250UB25", "200UB29", "360UB56"), while `section-catalogue.json`
   rounds ("410UB60", "250UB26", "200UB30", "360UB57").
2. **Standard or table:** InfraBuild/OneSteel hot rolled designations (AS/NZS 3679.1): 410UB59.7, 250UB25.7, 360UB56.7,
   200UB29.8, 310UB32.0, 250UC72.9, 310UC96.8 (from memory, high confidence). Tim 19 Oct 2026
   (decisions/2026-10-19_CEMEMBER_ANSWERS.md, quoted in BUG-818): supplier names with decimals.
3. **Plain words for Tim:** the engineer types the right name and CE prints a rounded one. Two drafters can also get two
   names for one section on one job: typing "410UB59" gives "410 UB 59", typing "410UB59.7" gives "410 UB 60", and SBEAM
   labels it "410UB60".
4. **Worked example:** "250UB25.7 BEAM" -> code "250 UB 26 BEAM" (no such designation). "410UB59.7" -> "410 UB 60".
   "250UC89.5" -> "250 UC 90". "310UB32.0" -> "310 UB 32". Correct per your ruling: the supplier name kept as typed
   ("250UB25.7", spacing to your office style).
5. **DETERMINISTIC TEST:** pure test on `ProcessColumn2Text` (or the public preview row normaliser): "250UB25.7" expects
   the output to contain "25.7"; "410UB59.7" expects "59.7"; "410UB59" and "410UB59.7" must not give two different
   designations. Today: "250 UB 26", "410 UB 60", and "410 UB 59" versus "410 UB 60".
6. **Status:** verified by reading. Not in BUG-818 (that covers the section list, not XCLMTXT).

### 3. MEDIUM: LBH (load-bearing wall over) at 1:100 now hatches 5 times sparser; short walls can show no hatch at all

1. **Where:** `Commands/HatchCommands.cs` lines 120 to 130 (LBH, ANSI31, 50 at 1:20 and 50 at 1:100) and
   `Core/Units/DrawingScaleRule.cs` lines 58 to 60: with `Layouts.HatchDensityFollowsPaper` ON (default,
   `Models/UserSettings.cs` line 1930) every two-value preset becomes "the 1:20 value x DIMSCALE / 20".
2. **Standard or table:** office drafting standard (the stated 50 at 1:100). Pattern spacing from memory (ANSI31 lines
   3.175 mm apart at scale 1).
3. **Plain words for Tim:** BUG-748 was about DOTS merging to solid at 1:100. The fix also changed ANSI31 LBH, which was
   fine at 1:100. On a 1:100 plan a 110 mm wall is 1.1 mm wide on paper; the hatch lines now cross it about once per
   metre of wall. The S-41 finalizer said "LBH has had no look" (REVIEWLANE 1591). Previous audit item 13 covers only
   CEHATCHAUDIT flagging old hatches, not this look.
4. **Worked example (scale value; line spacing in the model; spacing on paper; lines along a 110 mm wall):**
   1. **1:20:** 50; 159 mm; 7.9 mm; one every 225 mm of wall. Same before and after S-41.
   2. **1:50:** 125 (was 50); 397 mm; 7.9 mm; one every 561 mm (was 225).
   3. **1:100:** 250 (was 50); 794 mm; 7.9 mm; one every 1123 mm (was 225). A 900 mm nib: 0 or 1 line (was 4).
   LBUH (DOTS): 20, 50, 100 at the three scales (was 20 at all), which is the BUG-748 fix working as intended.
5. **Recommendation:** keep paper density for DOTS (LBUH); keep LBH at its stated 50 at 1:100 (or let a line hatch use
   its own rule). Tim's call: it is the look of a load-bearing wall on every plan.
6. **DETERMINISTIC TEST:** `DrawingScaleRule.HatchPatternScale(50, 50, 100, 1000, anyScale: true, paperDensity: true)`
   returns 250 today; expected 50 if Tim keeps the office value. Visual: copy at DIMSCALE 100 / LTSCALE 1000, a 110 x 900
   rectangle, LBH: count hatch lines inside (today 0 or 1; office standard about 4).
7. **Status:** arithmetic verified by reading; the paper look is not seen.

### 4. MEDIUM: the bracing panel adds up metres of brace of every type and calls it "enough"

1. **Where:** `Structural.DesignCore/BracingPanelCalculator.cs` lines 157 to 195. `BracingInstance.Type` is read but never
   used: provided = sum of lengths per direction; sufficient = provided + 0.5 mm >= required length (typed per direction).
2. **Standard or table:** AS 1684.2 bracing (Section 8): wall bracing capacity is length x the bracing type's rating in
   kN/m, compared with the racking force in kN. Not certain of the exact Table 8.18 ratings; for example a nominal or
   light sheet brace is a few kN/m and a structural plywood brace about 6 kN/m.
3. **Plain words for Tim:** if the job's "required" figure was worked out for a strong brace type and the drafter places
   a weaker type, the panel still shows green. The R-00 audit (item 41) noted "only adds up lengths" as nothing to move;
   the engineering gap is that a length is not a capacity.
4. **Worked example (illustrative ratings, check against AS 1684.2):** racking force 20 kN North-South. Engineer sets
   required 3.4 m, assuming a 6 kN/m ply brace. Drafter places 3.6 m of a 1.5 kN/m brace. Panel: 3600 >= 3400, green.
   Real capacity 3.6 x 1.5 = 5.4 kN against 20 kN: about a quarter of what is needed.
5. **Fix direction:** a rating per bracing type on the Settings page (R-00), provided shown in kN, required in kN; until
   then, the panel says "lengths only, types not weighted" and shows unknown (not green) when the types differ.
6. **DETERMINISTIC TEST:** `Summarise([new BracingInstance("A", 3600, 90)], 3400, null)` returns Sufficient true today.
   With a mixed set ("A" 1800 + "B" 1800) and no ratings set, expected Sufficient null (unknown) or a plain warning line.
7. **Status:** verified by reading. HUNT2-S-05 (roof trusses counted as walls) and HUNT2-S-10 (axis) are different faults.

### 5. MEDIUM: TH, PF, BP, column, 18-text and setout tags are a fixed height at every scale (not in BUG-531)

1. **Where:** `Services/CeTextService.cs` lines 663 to 678 (THL/THR, PFL/PFR, BPL/BPR: 250), 681 to 690 (CL1/CR1,
   PCL/PCR: 200), 699 to 702 and 742 to 745 (18L/18R/18T/18B: 180), 705 to 720 (SL/SR, DSL/DSR, TSL/TSR: 200), 751 to
   780 (THC, BTHC, PFC, BPFC, BPC rectangle labels: 250 mm, converted for units but not for scale). Setout tags:
   `Models/UserSettings.cs` lines 1424, 1491, 1537, 1692 (`TextHeightMm` 250 "drawing millimetres", read by
   `RoofSetoutDrawService.cs` 96, `FloorSetoutCommandService.cs` 87, `LintelProposalService.cs` 346,
   `LevelCarryDrawService.cs` 93 with no DIMSCALE).
2. **Standard or table:** Tim's ruling "all scales come from the drawing scale"; office label height 2.5 mm on paper
   (Settings, Layouts, Label plot height).
3. **Plain words for Tim:** 25C and EBT now follow DIMSCALE; these do not. On a 1:50 footing plan a pad label PFL plots
   5 mm high beside 2.5 mm notes; at 1:20 it plots 12.5 mm. The Codex audit computed the same numbers in its expected
   values section but did not raise them as a finding. BUG-531 lists the beam labels and the 100-unit labels only.
4. **Worked example (height in the drawing; height on paper):**
   1. **25C at 1:20, 1:50, 1:100:** 50, 125, 250; 2.5 mm each.
   2. **THL/PFL/BPL:** 250 at all; 12.5, 5.0, 2.5 mm.
   3. **CL1/PCL/SL/DSL/TSL:** 200 at all; 10, 4, 2 mm.
   4. **18L/18T:** 180 at all; 9, 3.6, 1.8 mm.
5. **DETERMINISTIC TEST:** on a millimetre copy at DIMSCALE 50 / LTSCALE 500, run PFL and place "PF1"; read the DBText
   height. Today 250; expected 125 (label plot height x DIMSCALE). Repeat for CL1 (today 200) and 18T (today 180).
6. **Status:** verified by reading.

### 6. MEDIUM: SBEAM and CEMEMBER draw the same member at different sizes at every DIMSCALE except 20

1. **Where:** SBEAM: `Structural.DesignCore/SteelSections/SbeamPlacementPlanner.cs` lines 8, 23 and 87 to 92
   (scale = DIMSCALE / 20; depth and every thickness x scale; the picked length is NOT scaled) and
   `Services/SbeamAtomicPlacementWriter.cs` lines 300 to 310. CEMEMBER: `CeMemberElevation.cs` and `CeMemberSection.cs`
   draw catalogue millimetres at real size; only break lines follow the scale.
2. **Standard or table:** drawing convention, Tim's call (SBEAM looks like the older "detail drawn enlarged to read at
   1:20" habit).
3. **Plain words for Tim:** SBEAM is still the ribbon button (`ce_toolbar_layout.json` line 1605); CEMEMBER is typed. At
   1:100 the same 310UB32 elevation picked between two wall points is 298 mm deep from CEMEMBER and 1490 mm deep from
   SBEAM, on a real-length span. In section view SBEAM is 5 times too big against a real-size slab or wall.
4. **Worked example:** DIMSCALE 100, 310UB32 side elevation from (0,0) to (6000,0). SBEAM: length 6000, depth 1490,
   flange line 40 in. CEMEMBER: length 6000, depth 298, flange line 8 in. At DIMSCALE 20 both give 298.
5. **DETERMINISTIC TEST:** `SbeamPlacementPlanner.PlanElevation` with 310UB32 Side, (0,0) to (6000,0), effective
   DIMSCALE 100: plan depth 1490 today. `CeMemberElevation.Build(CeMemberDims.IShape(298,149,5.5,8), SideElevation,
   6000, Centreline, None, 100)`: outline at y = +149 and -149. One ruling from Tim decides which is right; both commands
   then follow it.
6. **Status:** verified by reading. Not in the previous audits (they cover the metre-drawing factor of 1000, not this 5).

### 7. MEDIUM: the scale-aware hatches still refuse to draw when LTSCALE is not exactly 10 x DIMSCALE (R-27)

1. **Where:** `Commands/HatchCommands.cs` lines 347 to 349 and 1655 to 1678; `DrawingScaleRule.cs` lines 63 to 72.
   EH, CH, LBH and LBUH return "Invalid DIMSCALE/LTSCALE combination" and draw nothing.
2. **Standard or table:** R-27 (only two hard blocks); Tim 19 Oct for CEMEMBER: warn and carry on.
3. **Plain words for Tim:** the pattern scale depends only on DIMSCALE, yet a drawing at DIMSCALE 100 with LTSCALE 1
   (common in drawings that use paper-space line scaling) gets no hatch at all. CEMEMBER in the same drawing warns and
   draws. BUG-614 fixed 1:50 with LTSCALE 500, not this.
4. **Worked example:** DIMSCALE 100, LTSCALE 1, EH. Today: refused. Expected: EARTH at 40, plus one line "LTSCALE is 1,
   not 1000; dashed lines may look off".
5. **DETERMINISTIC TEST:** `DrawingScaleRule.HatchPatternScale(8, 40, 100, 1, anyScale: true)` returns null today;
   expected 40 with a warning flag.
6. **Status:** verified by reading.

### 8. MEDIUM: the fixed-scale template hatches disagree with their own scale-aware twins, and two still have the BUG-748 fault

1. **Where:** `Commands/HatchUpgradeCommands.cs` lines 45 to 58 (fixed values) against `HatchCommands.cs` 85 to 95
   (CH), 120 to 130 (LBH) and 143 to 153 (LBUH). The infill slab tool uses the fixed 2.0 (`FoundationInfillService.cs`
   618 to 628).
2. **Standard or table:** office drafting standard; Tim's ruling that scales come from the drawing scale. DOTS pitch from
   memory (1.5875 mm at scale 1).
3. **Plain words for Tim:** in the CEHATCH library, "Concrete slab" and "Concrete" are both AR-CONC but differ 5 times at
   1:100; "Fence wall over" and "Load-bearing wall over" look the same at 1:20 and 5 times different at 1:100; "Fence wall
   under" (DOTS 20) and "Wet-area setdown" are the very DOTS-merge fault BUG-748 fixed for LBUH.
4. **Worked example at 1:100:**
   1. **Concrete slab (11CH):** AR-CONC 1.0; CE's own Concrete (CH) gives 5.0. 5 times denser.
   2. **Infill slab (11IH, used by the infill tool):** 2.0 against 5.0. At 1:20: 2.0 against 1.0.
   3. **Fence wall over:** ANSI31 50 against LBH 250.
   4. **Fence wall under:** DOTS 20: dot rows 0.32 mm apart on paper (merge to grey) against LBUH 100 (1.6 mm).
   5. **Dot hatch 9 (9DH):** DOTS 30, rows 0.48 mm on paper.
5. **DETERMINISTIC TEST:** `HatchCommands.PlacementScale(<Fence wall under>, 100, 1000, true, true)` = 20 and
   `PlacementScale(DefLBUH, 100, 1000, true, true)` = 100: assert Tim's chosen rule makes the pair equal (or record why
   not). Same for Concrete slab against CH (1.0 against 5.0).
6. **Status:** verified by reading; the R-00 audit did not open the hatch presets (its "not checked" line).

### 9. LOW: CEMEMBER refuses the supplier name with decimals

1. **Where:** `Structural.DesignCore/SteelSections/CeMemberPrompts.cs` lines 101 to 117 (exact match or a unique
   prefix) against catalogue names "310UB32", "530UB92", "410UB60".
2. **Plain words for Tim:** type "310UB32.0" or "410UB59.7" from the engineer's mark-up and CEMEMBER says "no section
   called ... in the section list". When BUG-818's names with decimals land, "310UB32" still works as a prefix, so make
   both work.
3. **DETERMINISTIC TEST:** `FindByName(catalogue, m => m.Designation, "310UB32.0")` returns none today; expected the
   310UB32.0 row. "410UB59.7" today none; expected 410UB59.7.
4. **Status:** verified by reading.

### 10. LOW: three engineering tables carry wrong or unsafe values; nothing reads them yet

1. **Where and what:**
   1. **Laps, `Assets/Config/rebar-catalogue.json`:** `standardLapLength` = 40 x bar size, said to be "conservative"
      and from "AS3600-2018 Table 13.2.2" (there is no such table, as far as I know). BUG-534 item 3 records that no
      command reads it.
   2. **Cover, `Services/StandardsService.cs` lines 91 to 100:** A1 20, A2 30, B1 40, B2 45, C1 50, C2 65 regardless of
      concrete strength. `GetMinCover` has no caller.
   3. **Steel grades, same file lines 103 to 116:** UB and UC offered "250, 350, WR350"; SHS and RHS "350, C350". From
      memory, InfraBuild UB/UC are grade 300 (300PLUS) and most SHS/RHS are C450L0. No caller found.
2. **Worked example, laps (AS 3600-2018 Cl 13.1.2.3 and 13.2.2 from memory, not certain; f'c 32 MPa, fsy 500 MPa,
   k1 = 1.0, k3 = 1.0, k7 = 1.25):** N12 552 needed against 480 in the file; N16 762 against 640; N20 986 against 800;
   N24 1228 against 960; N32 1768 against 1280; N36 2072 against 1440. Top bars with more than 300 mm of concrete below
   (k1 = 1.3) need 30 percent more again. 40 x db is short by 13 to 31 percent in this case.
3. **Worked example, cover (AS 3600 Table 4.10.3.2 from memory, not certain):** B1 is 60 mm at 25 MPa but 40 at 32 MPa;
   the table's single 40 is only right at 32 MPa.
4. **DETERMINISTIC TEST:** a guard test that fails the day any command reads `standardLapLength`, `GetMinCover` or
   `GetSteelGrades` without first replacing them with cited values on the Settings page (R-00).
5. **Status:** values verified by reading; the standard figures are from memory.

### 11. LOW: the RC section detail invents a bar size when the bar is not in the list

1. **Where:** `Commands/SectionDetailCommands.cs` lines 93 to 100: a lig not found is drawn as 10 mm, a bottom bar as
   16 mm, a top bar as 12 mm. `rebar-catalogue.json` has no N40 and no R bars.
2. **Plain words for Tim:** a stored or typed N40 bottom bar is drawn as a 16 mm dot with no message. The rest of
   Structural says UNKNOWN rather than invent a number (ST6-4).
3. **DETERMINISTIC TEST:** RC beam spec with BotBarSize "N40": expect a plain line "N40 is not in the bar list" and no
   16 mm dot; today a 16 mm dot.
4. **Status:** verified by reading.

### 12. LOW: the wind class suggestion has no shielding question

1. **Where:** `Rules/WindClassSuggestion.cs` lines 33 to 43 and 84 (region start class plus terrain steps plus
   topography steps).
2. **Standard or table:** AS 4055 classifies from terrain category, shielding (full, partial, none) and topography
   (from memory, not certain of the 2021 table layout). BUG-534 notes the ladder is uncited; the missing shielding input
   is new.
3. **Plain words for Tim:** a fully shielded suburban lot and an unshielded one on the same terrain get the same
   suggestion; the difference is often one class (N2 against N3).
4. **DETERMINISTIC TEST:** same region and terrain, shielding "Full" and "None": expect different suggestions, or a
   Basis line saying shielding was not considered. Today there is no way to give shielding.
5. **Status:** verified by reading.

### 13. LOW: a vertical CEMEMBER elevation flips "top of member" with the pick order

1. **Where:** `Structural.DesignCore/SteelSections/CeMemberPlacement.cs` lines 65, 66, 79 and 80. Points are swapped
   west to east; when both have the same X nothing is swapped and "up" in the member's frame is 90 degrees
   anticlockwise from the pick direction.
2. **Worked example:** points (0,0) then (0,3000), Top of member: the member sits to the west of the line. Points
   (0,3000) then (0,0): to the east. A 0.01 mm difference in X decides it.
3. **DETERMINISTIC TEST:** `PlanElevation` with the two orders and TopOfMember: assert the same side both times (or a
   prompt asking which side).
4. **Status:** verified by reading.

### 14. LOW: SBEAM writes the list's wrong stiffness and mass into every member it places (a new effect of BUG-818)

1. **Where:** `SbeamPlacementPersistenceContract.cs` lines 451 to 454 (MEMBER_MASS_KG_M, MEMBER_IX..., MEMBER_ZX...);
   shown to the drafter in `UI/Dialogs/SteelSectionPickerDialog.xaml.cs` lines 242 to 245.
2. **Plain words for Tim:** the SBEAM window shows these numbers as fact and the drawing keeps them. After the list is
   corrected, older drawings still carry the old numbers, and SBEAMEDIT compares stored against current
   (`SteelSectionPickerDialog.Edit.cs` 130 to 133), so every older member may read as "changed".
3. **Worked example:** 150PFC shows Ix 10.8 x 10^6 mm^4; from its correct dimensions it is about 8.3. 400x400x16 SHS shows
   328; computed about 575 to 605.
4. **DETERMINISTIC TEST:** place a 150PFC with SBEAM on a copy, read MEMBER_IX_MILLION_MM4 from the record: today 10.8.
   After the BUG-818 list lands, SBEAMEDIT on that member must not report a change the drafter did not make.
5. **Status:** verified by reading.

---

## BUG-818 confirmed with my own arithmetic (not counted)

Mass and second moment recomputed from each row's own dimensions (steel 7850 kg/m^3, root fillets included for I and
channel shapes, hollow-section corners at 2.5t outside). Where mass and dimensions cannot both be right, the row is wrong
whatever the catalogue says.

1. **PFC:** every row is inconsistent. 380PFC web 13.5 gives 64.7 kg/m, not 55.2 (the real web is 10.0, from memory);
   200PFC Ix 22.2 against 16.4 from its own dimensions; 150PFC Ix 10.8 against 8.3; 125PFC Zx 95 against 70.
   **Effect on the drawing:** SBEAM and CEMEMBER draw these thicknesses, so a 380PFC section is drawn with a 13.5 mm web.
2. **Equal angles:** every mass is 35 to 38 percent low (100x100x10EA 9.42 against 14.9 computed).
3. **SHS and RHS:** every Ix with a value is 23 to 46 percent low (200x200x10SHS 25.2 against 45.9 gross); SHS masses 3 to
   5 percent low and RHS masses up to 10 percent high. 300x300x16SHS (131) and 400x200x16RHS (141) have the same perimeter and
   thickness, so they must weigh the same.
4. **CHS:** masses right; every Ix 23 to 29 percent HIGH (168.3x6.4CHS 13.6 against 10.7).
5. **WB and WC:** Ix 28 to 50 percent low on every row; 900WB and 700WB masses disagree with their own dimensions.
6. **UB:** 150UB18 and 150UB14 Ix and Zx 9 to 10 percent low; the rest within 4 percent. Names rounded (250UB26, 410UB60,
   360UB57 do not exist; the supplier names are 250UB25.7, 410UB59.7, 360UB56.7).
7. **Sections that look outside the Australian Tube Mills range (not certain):** the 6.3 mm SHS and RHS rows
   (250x250x6.3, 200x200x6.3, 150x150x6.3, 250x150x6.3, 200x100x6.3) beside their 6.0 twins; CHS 193.7, 165.1x9.5,
   139.7x6.4, 101.6x6.4, 88.9x6.4, 76.1x6.4; purlins ZC400, C40030 (BUG-818 already says Lysaght does not make these).
8. **DETERMINISTIC TEST for the corrected list:** a pure test over `section-catalogue.json` that recomputes mass from
   each row's dimensions and fails any row more than 3 percent out, and fails any SHS/RHS pair with the same perimeter and
   thickness whose masses differ by more than 1 percent. Today the mass check alone fails about 80 rows (38 equal angles,
   13 RHS, 8 SHS, 8 WC, 6 PFC, 6 WB).

---

## Engineering numbers written in the code, not on the Settings page (R-00), not already in R00_STRUC or BUG-531 to 536

1. **Hatch scales:** `Commands/HatchCommands.cs` 80-81 (EH 8, 40), 92-93 (CH 1, 5), 105 (WH 1), 127-128 (LBH 50, 50),
   139 (BLH 50), 150-151 (LBUH 20, 20), 162 (21LH 60), 174 (21DH 80), 186 (9DH 30); `Commands/HatchUpgradeCommands.cs`
   45 to 58 (11CH 1.0, 11IH 2.0, 47PH 60, 6DH 80, 6H 35, 8H 110, 47TH 60, 253EH 100, 11BH 50, 11FH 50, 231DH 20).
2. **Hatch scale references:** `Core/Units/DrawingScaleRule.cs` 16-17 (the 1:20 and 1:100 reference scales), 20-22 (break
   line 1.5, 2, 2 mm, while CEMEMBER's same sizes are Settings values), 104-112 (the old 150/200 and 30/40 break sizes).
3. **Text heights:** `Services/CeTextService.cs` 663-720 and 751-780 (250, 200, 180); `Services/SbeamAtomicPlacementWriter.cs`
   279 (20 x 2.5); `Commands/SectionMarkCommands.cs` 99 (1.8 x DIMSCALE).
4. **Reo:** `Services/RebarService.cs` 56-57 (stirrup hook 6 x bar size); `Commands/SectionDetailCommands.cs` 94, 98, 100
   (fallback bar sizes 10, 16, 12).
5. **Footing label offset:** `Services/FoundationService.cs` 5240-5241 (200 mm in the model, not on paper: 10 mm on paper
   at 1:20, 2 mm at 1:100).
6. **Bracing:** `Structural.DesignCore/BracingPanelCalculator.cs` 148 (45 degree split between North-South and East-West)
   and 193 (0.5 mm).
7. **Support footprints:** `Commands/SupportBlockCommands.cs` 1610 to 1630 (89 SHS read as 90 x 90, 2x89 SHS as 180 x 90;
   real 89 and 178; half a millimetre to one millimetre of offset, harmless but a second size table).
8. **Engines with no caller today (flagged so they are not wired as they are):** `Structural.DesignCore/BeamProposalEngine.cs`
   64 to 104 (span 1000 to 9000, jamb gaps 1000 to 6000, tolerances); `LoadPathEngine.cs` 199 to 216 (pad sized from an
   assumed load and bearing, rounded up to 50).

---

## Summary

Fourteen new findings: 1 HIGH, 7 MEDIUM, 6 LOW. The most likely wrong number on a drawing is XCLMTXT rounding 250UB25.7 to
"250 UB 26" on every member schedule, against Tim's decimals ruling; the worst is XCLMTXT relabelling unequal-angle lintels
as EA. LBH hatch at 1:100 is now five times sparser, the bracing panel sums lengths not capacities, fixed text heights ignore
DIMSCALE, SBEAM and CEMEMBER disagree on member size, and the hatches still hard-refuse a mismatched LTSCALE. BUG-818's
section-list errors are confirmed by arithmetic. Everything is verified by reading only; nothing was seen in AutoCAD.
