# Review: CEMEMBER against Tim's design, and a second hunt of Manager + CE_SHARED (Fri 23 Oct 2026, Melbourne)

Independent senior review, Opus 5.5 (claude-opus-5-5), read only. Nothing built, no test run, AutoCAD and Codex not
started, no source, setting, bundle or log file changed. Code read with `git show` / `git archive` into a scratch folder.
Log and bundle folders were only listed (names, sizes, dates); no client text from any log is quoted here.

**What I read (heads checked on 23 Oct):**

1. **Structural:** `origin/claude/rel-20261022s2` @ `2c9a9694`. The installed Structural DLL reads `1.0.121+2c9a9694...`
   in all three lanes (checked on disk). CEMEMBER PRs #1487 to #1490, #1500, #1501, #1504 to #1506, #1509, #1518.
2. **Manager + CE_SHARED:** `origin/claude/rel-20261022m` @ `40ee0a36`. The installed Manager DLL reads
   `1.1.70+40ee0a36...` in all three lanes.
3. **Tim's decisions:** `decisions/2026-10-18_CEMEMBER_DESIGN.md`, `decisions/2026-10-19_CEMEMBER_ANSWERS.md`,
   `decisions/2026-10-20_TIM_ANSWERS.md` item 2 ("build now"), the approved card
   `areas/release-v3-colleagues-CEMEMBER_CARD_DRAFT_2026-10-18.md`, the checklist draft and the edit card draft.
4. **Read first so as not to repeat:** `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_GATE_22OCT.md`,
   `CODEX_AUDIT_STRUCTURAL_22OCT.md`, the REVIEWLANE entries 1504 to 1593 on CEMEMBER, `HUNT_MANAGER_2026-10-09.md`,
   `HUNT_MANAGER_INSTALL_2026-10-12.md`. `CODEX_HUNT_MANAGER_22OCT.md` does not exist (checked).
5. **Skipped by Tim's ruling:** administrator-only Manager features (Admin Dashboard, approvals, rollback, policies).

---

## ANSWER FIRST (for Tim)

1. **CEMEMBER draws what you decided, line for line, for every shape you confirmed.** I checked all 12 member types in
   all their orientations against your card: 25cont edges, 18cont near, 18hidden far, no two lines on top of each other,
   lip lines in the side view only, Z-kink break lines at 1.5 mm and 2 mm on paper, LTSCALE warns and carries on. Nothing
   in the drawing rules contradicts what you said.
2. **What is still missing is the window, not the drawing.** No window, no live preview, no properties box, no
   orientation pictures, no typed scale. Today it is a command-line command (typed questions). Editing with SBEAMEDIT is
   not connected yet.
3. **Two things will make the first AutoCAD test fail for the wrong reason, so fix the test first:**
   1. **The section list in the plugin is still the old one** (your rule: the corrected list stays out until you say so).
      So "310UB32.0" is refused (the list says "310UB32"), there is no "Z15015" (the list says "ZC150"), and the 380PFC
      web is 13.5 mm in the old list, not the 10 mm the checklist expects.
   2. **The checklist uses the corrected-list numbers.** Part A item 5 gives the numbers the installed command will
      really draw.
4. **Three places the code has to guess because you have not ruled yet** (questions in Part A item 4):
   1. **Z purlin orientation names** and which flange is the wide one (still open since 20 Oct).
   2. **Unequal angles can only be drawn with the long leg standing up.** A 150x90 angle with the 150 leg lying flat
      cannot be drawn.
   3. **Welded beams (WB, WC) get rolled-beam corner radii in the section** because the old list gives them one. Your
      card says welded sections have no radius.
5. **Manager second hunt: 12 new findings, none HIGH. MEDIUM 6, LOW 6.** The ones you will notice:
   1. **"Open Logs" opens the wrong folder** (confirmed). It opens `%APPDATA%\CE_CADTOOLS`, which holds no Civil log.
      The Civil log is in `%APPDATA%\CE_CVL_SUITE\logs`.
   2. **The support zip leaves out the logs that matter most for Structural and for grips.** Structural's daily log and
      its command records, and Civil's native grip log, are not in it.
   3. **Clicking a CE Blocks tile while another command is running types "CEBLOCKINSERT" into that command.** The ribbon
      had the same fault and was fixed (BUG-828); the palette was not.
   4. **On AutoCAD 2022 to 2024 there is no CE Tools tab**, and the Manager menu that replaces it has no CE Health,
      Support, Version, CE Blocks, Move + Rotate or Copy + Rotate.
6. **Built, tested, installed, accepted:** this is a code and folder reading only. Nothing here was run in AutoCAD.
   Every finding has a test the robot or Codex can run on copies.

---

## Part A: CEMEMBER against Tim's decisions

How to read each item: **Decision** (Tim's words where recorded) / **Code** (does it, where) / **Missing** /
**Contradicted**. File:line is at `2c9a9694`. "Card" means the approved card of 19 Oct.

### 1. The decisions, one by one

1. **Name CEMEMBER, SBEAM kept until CEMEMBER passes** (18 Oct A1).
   1. **Code:** yes. `CeMemberCommands.cs:29`, registered in `Plugin.cs:26`; hidden from the ribbon
      (`command-registry.json:6705-6727`, `"hidden": true`). SBEAM and SBEAMEDIT unchanged.
   2. **Missing:** nothing.
   3. **Contradicted:** nothing. Note: the registry help text still says "Elevations only ... use SBEAM for sections",
      which is now wrong (the section view is built). Already known as stale help; not counted.

2. **Three views: section, side elevation, top elevation** (A2).
   1. **Code:** yes. `CeMemberEngine.cs:8-13`; question `View [SIde/Top/SEction/Reset]` at `CeMemberCommands.cs:317`.
   2. **Missing / contradicted:** nothing.

3. **Section view: outline 25cont, existing 10H hatch (solid, colour 10, HATCH 10); In front or Beyond; Beyond is outline
   only on 9hidden2, no hatch; hollow sections hatched on the wall only** (A3, card 2).
   1. **Code:** yes. Layers `CeMemberEngine.cs:257-260`; hatch `StructuralDetailService.cs:1751-1792` (SOLID, colour 10,
      associative, inner loop as an island for SHS, RHS, CHS); 9HIDDEN2 created colour 9, HIDDEN2
      (`StructuralDetailService.cs:1915-1918`); hatch added after the outline is turned (`CeMemberSectionWriter.cs:78-88`).
   2. **Missing:** nothing for the rule itself.
   3. **Contradicted (data, not rule):** welded WB and WC sections are drawn with an 8 mm rolled-beam root radius
      (`CeMemberSectionWriter.cs:106` and `:116-117` pass the list's `rootRadius`; `section-catalogue.json:671` gives
      900WB282 a radius of 8.0). Card section 8: "no rootRadius for welded WB/WC". This can be fixed in code now (ignore the
      radius for WB/WC) without waiting for the corrected list. Part of BUG-819.

4. **Elevations: extents 25cont; web and flange lines 18cont near, 18hidden far** (A4).
   1. **Code:** yes, one code path for every shape: `CeMemberElevation.cs:184-223`, inner lines `:238-415`.
   2. **Missing / contradicted:** nothing.

5. **Never two lines on top of each other; the line closest to the viewer wins** (A5, Tim: "we never put two lines on top
   of each other").
   1. **UB and UC top elevation: no flange lines, web on 18hidden.** Yes, `CeMemberElevation.cs:253-258` (two hidden lines
      at half the web each side of the centre).
   2. **SHS, RHS, CHS: inside walls 18hidden both views, CHS at the inside diameter.** Yes, `:261-265`.
   3. **Z purlin top elevation: top flange end edge 18cont, the other flange edge 18hidden** (Tim: "yes correct").
      Yes, `:376-393`. I checked the offsets against the section outline (`CeMemberSection.cs:137-168`): the 18cont line
      lands where the top flange meets the web and the 18hidden line on the web's far face.
   4. **PFC web outer face not drawn on top of the 25cont edge.** Yes, no line at offset 0 anywhere.
   5. **Missing / contradicted:** nothing. I found no shape where two inner lines can coincide with the installed list
      (smallest gap: C10015, flange line 1.5 mm, lip line 15 mm).

6. **Odd shapes (PFC, angles, Z and C) in four orientations; the orientation replaces Toward/Away** (A6, card 3 and 4).
   1. **PFC:** all four, every line matches card section 3 (`CeMemberElevation.cs:286-325`). The section turns to match
      (`CeMemberSection.cs:113-130`).
   2. **Angles:** all four match card section 3 (`:396-415`).
   3. **C purlin:** uses the PFC rules plus lips (`:271-274`). Matches the 19 Oct answers.
   4. **Z purlin:** four orientations built on a DRAFT naming (TopRight, TopLeft, LeftUp, LeftDown;
      `CeMemberPrompts.cs:86-94`, `CeMemberElevation.cs:112-131`). **Not Tim's naming.** QUESTIONS_FOR_MONDAY item 12 is
      still open.
   5. **Missing:** orientation pictures (window). **Gap the card did not cover:** an unequal angle can only be drawn with the
      LONG leg upright. `CeMemberCatalogue.cs:96-99` always makes the list's `depth` (the long leg) the upright leg; the
      four choices only flip left/right and top/bottom. A 150x90 lintel angle with the 150 leg flat cannot be drawn.
      Question 2 below.
   6. **Contradicted:** nothing.

7. **Picking: west to east; elevation points on Centreline (default), Top or Bottom; section one point from nine
   positions on the box (centre of the box, not the balance point)** (A7, card 5).
   1. **Code:** yes. Swap to west-to-east `CeMemberPlacement.cs:64-66`; Points sit on `CeMemberCommands.cs:408-425`;
      nine positions `CeMemberPrompts.cs:50-61` and `CeMemberPlacement.cs:105-112`; box per orientation `:89-99`.
   2. **Missing:** nothing.
   3. **Contradicted:** nothing, but the old LOW from entry 1507 is **still not fixed**: a vertical member (both picks with
      the same X) is never swapped, so picking bottom-to-top and top-to-bottom gives mirror-image hidden lines on PFCs and
      angles (`CeMemberPlacement.cs:65` compares X only). Test A5.9 below.

8. **Break lines: same Z-kink as BL, on 18CONT, 1.5 mm overshoot and 2 mm kink on paper, scaled with the scale** (A8,
   card 7).
   1. **Code:** yes. `CeMemberEngine.cs:215-241` is point for point `StructuralDetailService.DrawBLBreakLine`
      (`:1121-1157`) with sizes = paper mm x scale; layer 18CONT (`CeMemberEngine.cs:47`); both are Settings values
      (`UserSettings.cs` CeMember group).
   2. **Missing / contradicted:** nothing in the rule. Known elsewhere, not recounted: metre drawings and paper space
      (Codex F2, F5).

9. **Window: left member + size + properties box; middle live preview, always shown; right column view, orientation,
   front/beyond, points or base point, ends, typed scale; Cancel, Place, Reset; window hides after Place; Enter or Space
   reopens with the previous choices** (A9, card 5 and 6).
   1. **Code, command-line form only:** the same questions are asked on the command line; Escape cancels; Ends
      Both/Start/End/None with Both the default (`CeMemberCommands.cs:427-447`), not asked for a section; Enter repeats
      CEMEMBER with the last answers as defaults (`CeMemberMemory.cs`, remembered only after something is drawn,
      `CeMemberCommands.cs:157-163`); "Reset" at the first question clears them (`:326-331`).
   2. **Missing:** the window itself, the live preview with points 1 and 2 marked, the properties box (depth, width, web,
      flange, mass, Ix, Iy, Zx, Zy), the orientation pictures, and the **typed scale** (there is no way to type a scale; it
      is always DIMSCALE, `CeMemberCommands.cs:98-101`). Any builder can build the window (Tim, 29 Oct 2026: "lets remove the codex or claude ownship rubbish, add cemember to build list").
   3. **Contradicted:** nothing.

10. **Scale: default 100, read from DIMSCALE; LTSCALE is 10 x DIMSCALE, only a check; mismatch warns, carries on, and
    records a line in the log** (A10; 19 Oct answer 1, "yes as per recommeneded").
    1. **Code:** yes for elevations: `CeMemberEngine.cs:184-205`, message and log line `CeMemberCommands.cs:102-107`.
    2. **Missing:** the section view never checks LTSCALE (`RunSection`, `CeMemberCommands.cs:173-217`). A "Beyond"
       section is dashed 9hidden2, so a wrong LTSCALE makes it look solid with no warning. LOW.
    3. **Contradicted:** DIMSCALE 0 uses a fixed 100, not the office DefaultScale Setting. Already found (AUDIT LOW 6,
       Codex F7); not recounted.

11. **Purlins are Lysaght; no tapered flange beams** (A11).
    1. **Code:** no TFB anywhere (checked the list families). Lysaght two-width Z purlins are drawn with **equal flanges**
       because the installed list has one width (`CeMemberCatalogue.cs:84-89`, said plainly in the code).
    2. **Missing / contradicted:** the installed list still holds sizes Lysaght does not make (`ZC400`,
       `section-catalogue.json:3018`; `C40030`, `:3090`). This is BUG-818 and is held back by Tim's own rule, so it is
       not a code fault. It does mean the first AutoCAD test draws non-Lysaght purlins.

12. **Purlin lips** (19 Oct answers 2, 3, 4, 12).
    1. **Side elevation: flange line one thickness in, lip line one lip depth in, 18cont toward, 18hidden away** (Tim:
       "Yes, the lip picture is right"). Yes: C purlin `CeMemberElevation.cs:331-344`, Z purlin `:359-375`.
    2. **No lip lines in the top elevation** (Tim: "nope they interfere"). Yes, side view only (`:333`, `:370`).
    3. **C purlin top elevation = web inner face 18hidden** (the session's inference, never separately confirmed). Built
       that way (PFC rule, `:298`).
    4. **Gap already raised (entry 1506), still open:** C purlin flanges UP, top view draws the flange inside faces as
       18cont, but the lips sit over them, so they would really be hidden. Question 3.

13. **Tees and bars not for now** (19 Oct answer 5).
    1. **Code:** yes. Any other family is refused with a plain line (`CeMemberCatalogue.cs:101-102`).

14. **Supplier names with decimals, e.g. 530UB92.4** (19 Oct answer 9, "yep why not").
    1. **Code:** not yet; the installed list says `310UB32`, `530UB92` (`section-catalogue.json:205`). Typing the decided
       name `310UB32.0` gives "no section called ..." because the name search only matches a typed text that is the start
       of a list name (`CeMemberPrompts.cs:101-117`).
    2. **Why:** held back with the corrected list (Tim's rule). Not a code fault, but see Question 4.

15. **Rules from 20 Oct "build now" that still bind** (draft list out of the repo; checklist written before testing;
    Structural on Tim's PC only).
    1. **Draft list out:** yes, `section-catalogue.json` is the old list (checked: 380PFC still web 13.5).
    2. **Checklist written:** yes (`CEMEMBER_TIM_AUTOCAD_CHECKLIST_DRAFT_2026-10-20.md`), but its numbers are the draft
       list's (item 5 below).

16. **Native protection (AGENTS.md): never unlock, detach, explode or edit inside an Xref or REFEDIT.**
    1. **Code:** yes, refused before anything is drawn (`CeMemberLineWriter.cs:42-82`).
    2. **Already found, not recounted:** the existing 18HIDDEN or 9HIDDEN2 layer's linetype is re-set (AUDIT MEDIUM 2,
       Codex F1); frozen or off layer still says "placed" (AUDIT LOW 5).

17. **Editing with SBEAMEDIT** (desk answer of 20 Oct, not a Tim decision; the edit card is a DRAFT Tim has not seen).
    1. **Code:** the saved-record engine exists with no caller (`CeMemberRecord.cs`, `CeMemberReplanner.cs`). SBEAMEDIT
       cannot edit a CEMEMBER member. Correct per the edit card's slice plan.

### 2. Summary of Part A

1. **Drawing rules:** every drawing rule Tim decided (items 1 to 13 above) is built as decided. None contradicted.
2. **Built but on a draft default Tim has not ruled:** Z purlin orientation names; C purlin top elevation; C purlin
   flanges up/down top view.
3. **Not built:** the window (preview, properties box, pictures, typed scale), SBEAMEDIT editing.
4. **Held back by Tim's own rule:** the corrected section list (names with decimals, Lysaght purlins, two-width Z, correct
   PFC webs, angle thickness).
5. **Fixable now without the list:** welded WB/WC drawn with a rolled radius; vertical member flips; no LTSCALE check on
   sections.

### 3. Real-world example of what is right and what is not

1. **Right today:** a 310UB32 side elevation at 1:100 between two picks 3 m apart comes out as two 25cont lines 298 apart,
   two 18cont lines 8 in from them, and a Z-kink break at each end sticking out 150 past the edges. That is your picture.
2. **Not right today:** a 900WB282 section shows 8 mm curved corners where the web meets the flanges. A welded beam has a
   square corner with a fillet weld, so the detail looks like a rolled beam.

### 4. Questions for Tim (one batch; nothing is blocked while you decide)

1. **Z purlin: names and which flange is wide.** The code uses "TopRight / TopLeft / LeftUp / LeftDown" and puts the WIDE
   flange on top (or left). **Recommend:** keep these words but show them as four pictures, wide flange on top. Example:
   a roof purlin drawn "TopRight" has its 65 mm flange up the slope and the 61 mm flange down.
2. **Unequal angle with the long leg lying flat.** Today only long-leg-up exists. **Recommend:** add a "long leg flat"
   switch (eight pictures in total), because lintel and ledger angles are often drawn that way. Example: a 150x90x8 UA
   ledger bolted to a wall with the 150 leg flat on the slab edge cannot be drawn today.
3. **C purlin with the flanges up, top view.** The lips cover the flange inside faces. **Recommend:** draw those two lines
   18hidden (they are behind the lips), still no lip lines. Example: a C15015 laid flanges-up as a girt in plan.
4. **The corrected section list.** On 19 Oct you checked the ten rows ("looks right"); on 20 Oct the rule was "stays out
   until Tim has reviewed the ten-row check". That check is done. **Recommend:** put the corrected list in now, together
   with the code that reads its new fields (two Z widths, real angle thickness, no radius on welded beams), as card
   section 8 says. Example: today 380PFC draws its web 13.5 thick; InfraBuild says 10.

### 5. What the first real-AutoCAD test of CEMEMBER must assert

Fixture: a fresh COPY of the robot's Structural copy `DRV2_S1` (or a new drawing), World UCS, INSUNITS 4 (mm),
DIMSCALE 100, LTSCALE 1000, OSNAP off, nothing locked. Use the INSTALLED list names. All coordinates are typed. Read
each entity with LIST or the robot's entity dump. "Today" = what the code predicts.

1. **Elevation, side (E1).** `CEMEMBER`, `SI`, `310UB32`, Enter (Centreline), Enter (Both), `0,0`, `3000,0`, Esc.
   1. **Assert:** exactly 6 new entities. Lines on 25CONT at Y = 149 and Y = -149, X 0 to 3000. Lines on 18CONT at
      Y = 141 and Y = -141. Two open polylines on 18CONT, the one at X = 0 with vertices (0,299) (0,100) (200,100)
      (-200,-100) (0,-100) (0,-299); the one at X = 3000 the same shifted by 3000. Nothing on 18HIDDEN.
   2. **Assert:** command line ends "CEMEMBER finished: 1 member(s). One U removes the whole run."
2. **Elevation, top (E2).** `CEMEMBER`, `T`, `310UB32`, Enter, `None`, `0,1000`, `3000,1000`, Esc.
   1. **Assert:** 25CONT lines at Y = 1074.5 and 925.5; 18HIDDEN lines at Y = 1002.75 and 997.25; straight 25CONT end lines
      at X = 0 and X = 3000; no 18CONT line; 6 entities.
3. **Points sit on (E3).** `CEMEMBER`, `SI`, `310UB32`, `Top`, `None`, `0,2000`, `3000,2000`, Esc.
   1. **Assert:** 25CONT at Y = 2000 and Y = 1702 (the picks sit on the top edge).
4. **How it sits, PFC (E4)** with the installed 380PFC (flange 17.5, WEB 13.5). For each of `Right`, `Left`, `Up`, `Down`,
   draw side `0,Y` to `3000,Y` and top on a fresh Y, ends `None`. Offsets are from the member's centre line:
   1. **Right:** side 18HIDDEN at +172.5 and -172.5; top (edges at +-50) one 18HIDDEN at -36.5.
   2. **Left:** side 18CONT at +-172.5; top one 18HIDDEN at +36.5.
   3. **Up:** side (edges at +-50) one 18HIDDEN at -36.5; top (edges at +-190) 18CONT at +-172.5.
   4. **Down:** side one 18HIDDEN at +36.5; top 18HIDDEN at +-172.5.
   5. **Assert also:** no line lies on a 25CONT edge in any of the eight. **Record (do not judge):** which side of the top
      view the web line is on; the code puts the section's LEFT edge at the BOTTOM of the top view. Tim or a Codex look
      decides if that is the right way round.
5. **How it sits, angle (E5)** `100x100x6EA`, side and top, ends `None`:
   1. **LeftBottom:** side 18HIDDEN at -44; top 18CONT at -44.
   2. **RightBottom:** side 18CONT at -44; top 18CONT at +44.
   3. **LeftTop:** side 18HIDDEN at +44; top 18HIDDEN at -44.
   4. **RightTop:** side 18CONT at +44; top 18HIDDEN at +44.
6. **Purlins (E6).** `C15015` `Right` side: 18HIDDEN at +-73.5 (flange) and +-60 (lip); top: one 18HIDDEN at -31.0, no lip
   line. `ZC150` `TopRight` side: 18CONT at -73.1 and -60 (near, bottom), 18HIDDEN at +73.1 and +60 (far, top); top
   (edges at +-64.05): 18CONT at -0.95, 18HIDDEN at +0.95.
7. **Section and base point (E7).**
   1. `CEMEMBER`, `SE`, `310UB32`, `Front`, `Centre`, `5000,0`, Esc. **Assert:** one closed polyline on 25CONT with extents
      X 4925.5 to 5074.5, Y -149 to 149; one SOLID hatch on HATCH 10, colour 10, associative, one loop.
   2. Same with `Beyond`. **Assert:** outline on 9HIDDEN2, no hatch.
   3. `380PFC`, `Up`, `Front`, `BottomLeft`, `0,-3000`. **Assert:** extents X 0 to 380, Y -3000 to -2900, flange tips at the
      top (Y -2900) at both ends. Repeat with `TopRight` at `0,-3000`: extents X -380 to 0, Y -3100 to -3000.
   4. `100x100x6SHS`, `Front`, `Centre`, `6000,0`. **Assert:** two closed outlines on 25CONT and one hatch with two loops;
      the middle is NOT filled (click inside the void: no hatch selected).
8. **Hidden layers (E8)** in a drawing with none of the CE layers. After E1 to E7: **Assert** 18HIDDEN colour 8, linetype
   HIDDEN, 0.18; 9HIDDEN2 colour 9, linetype HIDDEN2, 0.18; HATCH 10 colour 10; 25CONT colour 7 0.25; 18CONT colour 6
   0.18. Then the known MEDIUM (AUDIT 3): an existing 18HIDDEN on Continuous must stay Continuous. Today it becomes
   HIDDEN: expected FAIL, already carparked.
9. **Vertical member (E9).** `100x100x6EA` `LeftBottom` side, `None`: picks `9000,0` then `9000,3000`, then a second member
   `9500,3000` then `9500,0`. **Assert:** both have the 18HIDDEN line on the same side. Today they are mirror images:
   expected FAIL (entry 1507 LOW, not fixed).
10. **Scale warning (E10).** `LTSCALE 100`, then E1 again. **Assert:** the line "CEMEMBER: The line scale (LTSCALE 100) is not
    10 x the drawing scale (1000), so dashed lines may look off. CEMEMBER carried on at 1:100." and a "CEMEMBER scale:"
    line in the Structural log (`CE_STRUC_SUITE\logs\ce_struc_suite.log` or the structured log in
    `TIM_CE_CADTOOLS\logs`; which of the two was not traced); the member is still drawn.
11. **Undo, Escape, repeat (E11).** Place three members in one run, Esc, `U`: all three go; `REDO`: all three return.
    Escape at each question: "CEMEMBER cancelled. Nothing changed." and no new entity. Enter at the Command prompt
    straight after a run: the defaults offered are the last answers.
12. **Names (E12).** Type `310UB32.0`. **Assert today:** "no section called ..." (installed list). Record it; it passes only
    after the corrected list goes in (Question 4).

---

## Part B: second-pass hunt of Manager + CE_SHARED (installed C-60, `40ee0a36`)

**Severity:** HIGH = wrong evidence or a silent drawing change; MEDIUM = something a drafter or support relies on does
not work as it says; LOW = edge case, wording, Tim's call. **Verified** = read in code (and on disk where said).
**Suspected** = reasoning, not seen.

### MEDIUM

1. **B1. MEDIUM. "Open Logs" (CEMANAGERLOGS, CE Tools > Open Logs, Manager menu > Logs) opens the wrong folder. Verified.**
   1. **Where:** `Modules/Manager/Services/CeSupportBundleService.cs:218-223` opens `CeCadToolsFolder()` (`:226-229`) =
      `%APPDATA%\CE_CADTOOLS`, and creates it if missing. The Civil log is written to `%APPDATA%\CE_CVL_SUITE\logs`
      (`Modules/Drainage/Services/LoggingService.cs:68-70`). Structural writes `%APPDATA%\CE_STRUC_SUITE\logs` and
      `%APPDATA%\TIM_CE_CADTOOLS\logs`; Manager's trace is `%LOCALAPPDATA%\CE_SUITE_MANAGER\crash_trace.log`.
   2. **Plain words:** support asks a colleague to "open the logs and send CE_CVL_SUITE.log". The folder that opens holds a
      CE_Admin folder (its logs folder is empty on Tim's PC), a menu folder and an install id. No CE log at all.
   3. **Failure scenario:** a colleague on 9 Nov reports a pipe fault; they send whatever is in that folder; the real log
      never arrives. The ribbon tooltip says "Open the CE support data folder", which is also not where the logs are.
   4. **Deterministic test:** (a) unit: the folder `OpenLogsFolder` targets equals `LoggingService.ResolveLogFolder()` of
      Civil (or the agreed choice). (b) AutoCAD, robot: type `CEMANAGERLOGS`; read the new Explorer window's path
      (PowerShell `Shell.Application` windows, `LocationURL`). **Assert:** it ends `\AppData\Roaming\CE_CVL_SUITE\logs`
      and contains `CE_CVL_SUITE.log`. Today `\CE_CADTOOLS`: FAIL.

2. **B2. MEDIUM. The support zip (CESUPPORT) leaves out the logs that matter most for Structural and for grips. Verified in
   code and on disk.**
   1. **Where:** `CeSupportBundleService.cs:36-41` reads only `CE_CVL_SUITE\logs`, `CE_STRUC_SUITE\logs` (top level),
      `%LOCALAPPDATA%\CE_SUITE_MANAGER`, plus `CE_CADTOOLS\CE_Admin\logs` and `\sessions` (`:29`). Inside those, only names
      matching `:132-134` go in, and sub-folders are skipped (`:146-150`).
   2. **Left out (listed on Tim's PC today):**
      1. Structural's daily structured log and command logs: `%APPDATA%\TIM_CE_CADTOOLS\logs\ce_struc_structured_YYYYMMDD.log`
         (written today) and `ce_struc_commands_YYYYMMDD.log` (54 files). That folder is never read.
      2. Structural's command records `CE_STRUC_SUITE\logs\RuntimeDiagnostics\runtime_YYYYMMDD.jsonl` (the file the AUDIT
         used to see CEMEMBER outcomes): a sub-folder, skipped.
      3. Civil's `native_grip_2027.log` and `ribbon-clicks.log` in `CE_CVL_SUITE\logs`: names fail the pattern.
      4. The diagnostics report: CEMANAGERDIAG saves it in the OFFICE folder when that is reachable
         (`CeDiagnosticsService.cs:300-311`), but the zip only reads `Desktop\CE Diagnostics` (`CeSupportBundleService.cs:54`).
         On an office PC the newest diagnostics are never in the zip.
   3. **Plain words:** the zip promises "the Civil, Structural and Manager logs from the last 14 days"; for Structural it
      holds the short log only, and for a grip crash it holds no grip log.
   4. **Failure scenario:** a CEMEMBER or grip problem on Tim's PC; the zip goes to the desk; the one file that shows what
      happened is not in it, so a second round trip is needed.
   5. **Deterministic test:** unit, with `CE_LOG_DIR_OVERRIDE` pointing at a temp profile seeded with the four files above
      (synthetic text, dated today) and a `CE Diagnostics\<code>\report.txt` in a fake office folder; call `BuildBundle`.
      **Assert:** the zip has an entry for each, or `WHAT_IS_IN_THIS_ZIP.txt` names each as left out with the reason.
      Today: absent and not named.

3. **B3. MEDIUM. Clicking a CE Blocks tile while another command is waiting types "CEBLOCKINSERT" into that command.
   Verified.**
   1. **Where:** `Modules/Manager/Services/CeBlocksPaletteService.cs:46` sends `"CEBLOCKINSERT "` with no cancel in front.
      The ribbon had exactly this fault (HUNT-MI-06) and was fixed by sending two cancels first when a command is running
      (`Shared/CE_SHARED/Services/RibbonBuilder.cs:28-29`, `:704`, BUG-828). The palette does not use that helper.
   2. **Plain words:** you are at TEXT's "Enter text:" and click a block in the CE Blocks palette; the word CEBLOCKINSERT is
      typed into your text instead of the block starting. AutoCAD's own tool palettes cancel first.
   3. **Deterministic test (Codex, mouse):** copy of `DRV1_B1`; `TEXT`, pick `0,0`, height `2.5`, rotation `0`; at "Enter
      text:" click any CE Blocks tile. **Assert:** no text entity containing "CEBLOCKINSERT"; the command line shows "Scale
      for ...". Today: FAIL (expected). Source guard: the palette builds its string with `RibbonBuilder.BuildSendString`.

4. **B4. MEDIUM. When the CE ribbon or a ribbon tab fails to build, the reason is thrown away; a broken switch file is also
   silent. Verified.**
   1. **Where:** `CeUnifiedRibbonService.cs:150-154` and `:168-172` write failures with `System.Diagnostics.Trace`, which
      nothing records inside AutoCAD (no file). Same for the menu one-try (`CeSuiteManagerMenuService.cs:111`), CE Blocks
      settings damaged or not saved (`CeBlocksSettings.cs:72`, `:77`, `:104`; `CeBlocksPaletteService.cs:74`;
      `CeBlocksInsertService.cs:117`), and the switch file (`CeOneGlanceStatus.cs:367-370`). The switch-file comment
      (`:219-222`) says a broken file "is noted in the trace log": it is not; it only goes to `Trace`.
   2. **Contrast:** start-up failures DO go to `crash_trace.log` (`CeManagerStartupWords.cs:22-26`). Only the start-up hook
      is covered; the real build runs later at Idle, and that is the part that fails.
   3. **Plain words:** if the CE Tools tab never appears, nothing anywhere says why, and the support zip has nothing to
      show. If someone adds a stray comma to `%APPDATA%\CE_SUITE\manager-switches.json`, every Manager switch turns off
      (show Roll Back, menu bar, local support zip folder, short staging folders) with no message and no log line.
   4. **Deterministic test:** (a) unit: register a test ribbon contributor whose `GetPanels` throws; run the build; **assert**
      one line in `crash_trace.log` naming the tab. Today none. (b) test profile with `manager-switches.json` =
      `{"showRollBack": true,}`; start; **assert** `crash_trace.log` has a "switch file is broken" line. Today none.

5. **B5. MEDIUM (suspected). The CE Tools tab may appear late, or only after a status change, when Manager starts before
   Civil and Structural. Verified in code; load order not seen.**
   1. **Where:** `CeUnifiedRibbonService.cs:61-62`: if no CE tab has registered at the moment Manager starts, the build is
      never queued. The next trigger is the release status monitor (`Plugin.cs:140-161`): a 15 s sleep, then the whole
      update staging copy from OneDrive, then the first poll 20 s later (`CeReleaseStatusService.cs:200`). Civil registers
      its tab in its own start (`Modules/Drainage/PluginInitialization.cs:253`) and never asks Manager to rebuild.
   2. **Which plugin AutoCAD starts first is not something I can state** (RULES 12.5). The code comment itself says "in the
      one CE bundle the Manager starts first with no tabs registered".
   3. **Plain words:** on a colleague's PC, if Manager happens to start first, the CE Tools tab (CE Manager, Health, Support,
      Blocks, Move + Rotate) is missing for the first half-minute or more, longer when an update is being copied.
   4. **Deterministic test:** (a) unit: `Initialize()` with no contributors, then `CeRibbonRegistry.Register(test)`;
      **assert** a build is queued (today: not). (b) AutoCAD: robot screenshot every 5 s from launch; note the Civil log's
      "plugin initialized" time and the Manager banner order. **Assert:** CE Tools tab visible within 10 s of the banner.

6. **B6. MEDIUM. AutoCAD 2022 to 2024: no CE Tools tab, and the Manager menu that replaces it lacks six tools. Verified.**
   1. **Where:** on net48 the ribbon service is a no-op (`CeUnifiedRibbonService.cs:27-43`). Manager's menu is built from
      `Modules/Manager/Assets/Config/ce_toolbar_layout.json`, which lists only CEMANAGER, CEMANAGERREFRESH,
      CEMANAGERUPDATES, CEMANAGERDIAG, CEMANAGERLOGS and CEMANAGERADMIN.
   2. **Missing for older AutoCAD:** CE Health, Support Bundle, Version, Survey Review, CE Blocks, Move + Rotate, Copy +
      Rotate (typing the command still works). Not checked: whether Civil's own older-AutoCAD menu carries CE Blocks or
      MR/CR.
   3. **Plain words:** a colleague on AutoCAD 2024 (in scope since 15 Sep) cannot find CE Health or Support Bundle anywhere
      on screen; support has to tell them to type CESUPPORT.
   4. **Deterministic test:** (a) static: the layout file (or Civil's net48 menu) contains CEHEALTH, CESUPPORT, CE_VERSION,
      CESURVEYREVIEW, CEBLOCKS, MR, CR. Today: FAIL. (b) AutoCAD 2024 on a test profile: open the CE Suite Manager menu
      and check each item runs.

### LOW

7. **B7. LOW (suspected). Survey Review shows the old survey if the review was left open; its real errors are never
   logged.**
   1. **Where:** `PluginManagerWindow.SurveyIntake.cs:41-47`: when a review session already exists, CESURVEYREVIEW only
      refreshes its colours, it does not load the new intake. The bridge swallows the real exception text
      (`CeCivilSurveyIntakeBridgeSession.cs:127-131`, `:171-175`, `:182-183`).
   2. **Plain words:** CDSURVEY on survey A, review left open with no decision, CDSURVEY on survey B: the review may still
      show A. If the review cannot open, the drafter sees "could not be opened" and the log has nothing.
   3. **Deterministic test:** test copy; `CDSURVEY` on synthetic file A, `CESURVEYREVIEW` (no decision); `CDSURVEY` on file
      B; **assert** the review shows B's file name and point count. Unit: a bridge factory that throws writes one
      scrubbed line to `crash_trace.log`.

8. **B8. LOW. Move + Rotate and Copy + Rotate lose a pre-selection on the opt-in C# path (AutoCAD 2022 to 2026 with
   `Options.UseNativeCopyRotate` ON). Verified.**
   1. **Where:** `Modules/Drainage/Commands/CopyRotateCommands.cs` (net48/net8 half): `FlushState` clears the pick-first
      set, then `GetSelection` reads it, so it is always empty and asks "Select objects" again. The comment says the
      selection is captured first; the code does not. Default is OFF (LISP route); AutoCAD 2027 uses the ARX and is not
      affected.
   2. **Deterministic test:** AutoCAD 2026, test profile with the switch ON; draw three lines, select them, `MR`. **Assert:**
      the first prompt is MOVE's base point, not "Select objects". Today: FAIL.

9. **B9. LOW. CE Blocks re-reads the whole office block drawing on every stamp. Verified in code; timing not measured.**
   1. **Where:** `CeBlocksInsertService.cs:83` calls `PlaceOne` per point, which opens the source DWG with `ReadDwgFile`
      each time (`:130-132`). With OneDrive "online only" files the first read also downloads on AutoCAD's thread.
   2. **Plain words:** stamping 20 bollards means reading the office library 20 times; the click rhythm slows, and a
      not-yet-downloaded library freezes AutoCAD with no message.
   3. **Deterministic test:** `CEBLOCKS`, one tile, Enter scale, 10 typed points; **assert** each placement after the first
      takes under 300 ms (log or robot timing). Second case: library set "Free up space"; **assert** a plain message or
      under 5 s.

10. **B10. LOW (suspected). Manager's assembly resolver serves any same-named DLL to every plugin, ignoring version, and is
    never removed. Verified in code; harm not seen.**
    1. **Where:** `Modules/Manager/Plugin.cs:58-89`: for any failed load of a non-Autodesk name in AutoCAD, it returns
       Manager's own file of that name, else a file of that name in the AutoCAD program folder, with no version check.
       Not removed in `Terminate`.
    2. **Plain words:** if Civil and Manager ever carry different CE_SHARED copies (the BUG-522 case), this can hand a
       plugin the wrong copy instead of a clean error.
    3. **Deterministic test:** unit: call the handler with `"CE_SHARED, Version=99.0.0.0"`; **assert** null unless the
       versions match. AutoCAD: after start, **assert** exactly one CE_SHARED in the loaded assemblies (CE_VERSION shows it).

11. **B11. LOW. "Starts with AutoCAD" writes the tool's start-up file straight over itself. Verified.**
    1. **Where:** `CePluginRegistryService.cs:287-288` writes `PackageContents.xml` in place (no temp file and swap).
       Rewriting at all is S2-007 (already known); the new angle is a part-written file and a changed signed file.
    2. **Plain words:** if AutoCAD or Windows stops mid-save, that CE tool's start-up file is broken and the tool does not
       load at all next time.
    3. **Deterministic test:** unit: make the writer fail after 100 bytes; **assert** the original file is unchanged.

12. **B12. LOW (Tim's call). Diagnostics saves into the shared office folder; CEMANAGERREFRESH uploads on AutoCAD's own
    thread.**
    1. **Where:** `CeDiagnosticsService.cs:300-311` (office `CE Diagnostics\<coded PC>` when reachable, else Desktop, which
       is inside OneDrive on Tim's PC); `PluginManagerCommands.cs:124` runs the outbox upload inside the command.
    2. **Plain words:** every colleague with office-folder access can open every PC's diagnostics (coded names, but full
       plugin paths and versions). The support zip was ruled "stays on this PC" (INT-069 item 12); the diagnostics report
       was never ruled. A slow OneDrive makes Refresh freeze AutoCAD until the copy finishes.
    3. **Deterministic test:** CEMANAGERDIAG with the office folder reachable: **assert** the file lands where Tim rules.
       CEMANAGERREFRESH with the office folder on a deliberately slow synthetic share: **assert** the command returns in
       under 1 s.

### Already known and still true at `40ee0a36` (not counted)

1. **Civil and Structural reports never reach the office:** they write `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox`
   (`CeTelemetryStore.cs:60-68`); Manager uploads `%APPDATA%\CE_CADTOOLS\CE_Admin\outbox`. Recorded 9 Oct (AUDIT_01,
   OFF_PC_CALLS). **Now 21,415 files** in the never-uploaded folder on Tim's PC, still growing daily.
2. **Ribbon click log written into Civil's folder** from CE_SHARED on any PC (HUNT-MI-31).
3. **Manager's rebuild overwrites the Civil tab** (HUNT-MI-28); **CE Tools buttons call Civil commands with no Civil**
   (HUNT-MI-30, includes MR and CR).
4. **Codex gate items** (administrator installer, approvals with absolute paths, packaging, About window LOW 14) and
   the 22 Oct AUDIT items: not repeated.

### Checked and sound

1. **Support zip privacy:** logins and PC names coded, drawing paths cut to job numbers, the administrator's name book
   never included, zip never copied to the office (`CeSupportBundleService.cs:50-61`, `:168-171`).
2. **Ribbon rebuild requests from the timer** are handed back to AutoCAD's thread and ignored after shut-down
   (`CeUnifiedRibbonService.cs:70-106`, `CeUiThread.cs`).
3. **crash_trace.log** is trimmed at 50 KB and scrubbed (`CeAdminTelemetryService.cs:150-171`).
4. **Menu install** retries on DocumentActivated, so a start on the Start tab (no drawing) still gets the menu
   (`CeSuiteManagerMenuService.cs:77-114`).
5. **CE Blocks** refuses REFEDIT, locked or frozen layers and Xref blocks, and reuses an existing block definition
   instead of making duplicates (`CeBlocksInsertService.cs:30-57`, `:280-304`).
6. **Switches on Tim's PC:** there is no `%APPDATA%\CE_SUITE\manager-switches.json`, so every Manager switch is OFF; a
   colleague gets the same.

---

## What I did not do

1. No build, test, AutoCAD, accoreconsole or Codex run. No file outside this report was changed.
2. Did not read Civil's older-AutoCAD menu (B6 note), the Structural runtime logger, or Civil's Survey Intake view (B7 is
   suspected).
3. Did not measure any timing (B5, B9, B12).
4. AutoCAD's plugin load order was not observed (B5).

## Summary (under 120 words)

CEMEMBER matches Tim's design: every confirmed line rule, layer, break size and scale behaviour is built, with nothing
contradicted. Missing: the window (preview, properties, pictures, typed scale) and SBEAMEDIT editing. The installed
section list is still the old one by Tim's rule, so the checklist's names (310UB32.0, Z15015) and 380PFC web (10 mm) will
fail; Part A gives the real numbers. Four questions: Z names, unequal angles long-leg-flat, C purlin flanges-up top view,
and whether the corrected list may go in. Manager hunt: 12 new findings (6 MEDIUM, 6 LOW): Open Logs wrong folder,
support zip missing key logs, CE Blocks typing into running commands, silent ribbon failures, no CE Tools on 2022-2024.
