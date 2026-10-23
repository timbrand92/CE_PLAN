# Team Opus audit T3: Structural steel sections and schedules (Sat 24 Oct 2026, 07:55 to 08:30 Melbourne)

Headless, read-only, Opus 5.5. Code read: `origin/claude/rel-20261023s` @ `e6d597c0` (Structural 1.0.122) in a detached
worktree `C:\ce-ta\t3s`. Nothing was built, no test was run, AutoCAD and Codex were not started, no source, Settings,
bundle or log file was changed. Known bugs were checked first in `BUG_CARPARK.md` (to BUG-1087), the `CODEX_AUDIT2_RD*`
reports and the 22 Oct Structural engineering audit. I have no copy of any Standard or supplier catalogue here: every
supplier figure below is from memory and says so.

---

## ANSWER FIRST (for Tim)

1. **Counts (new findings only): HIGH 0, MEDIUM 4, LOW 10.** Everything else I found was already known (list at the end).
2. **Section dimensions are mostly right.** I checked 26 sections by hand. All 19 UB and UC sizes I know by heart have
   the right depth, width and thicknesses. The wrong figures are the ones BUG-818 already lists (PFC webs, angle masses,
   hollow-section stiffness, welded-beam masses).
3. **Top 3 new findings:**
   1. **CEMEMBER can quietly pick a thicker tube (MEDIUM).** Type `114.3x6` meaning the 6.0 mm wall and CEMEMBER
      takes **114.3x6.4 CHS**, because it is the only name that starts with what you typed. `60.3x4` becomes 60.3x4.5,
      `89x89x3` becomes 89x89x3.5 SHS.
   2. **The office's own short spellings are not found (MEDIUM).** XCLMTXT's spelling table writes `410UB59`, `250UB25`,
      `360UB56`, but the section list calls them `410UB60`, `250UB26`, `360UB57`. Typing the office spelling in SBEAM's
      search or in CEMEMBER finds nothing. `460UB74` is the odd one out the other way (the list cuts 74.6 down, not up).
   3. **Since 1.0.122 the office MEMBERS.csv can no longer correct a UB or UC (MEDIUM, impact not proven).** The new
      decimals fix locks every UB/UC size before the office spelling list runs, so any UB/UC row in MEMBERS.csv is
      skipped without a word. I could not see the office file, so I do not know if it has such rows.
4. **Good news to confirm:** the XCLMTXT decimals and angle fix (`250UB25.7` kept, `150x90x10` angle written UA) is in
   the 1.0.122 build (PR #1533 merged). The carpark entries still say "draft PR". Built and unit-tested only: nobody
   has run it in AutoCAD.
5. **Schedule quantities:** the bar schedule adds up correctly (checked again). The one mismatch is BARWEIGHT, which
   uses a second, rounded mass table: 100 N20 bars at 6 m come out 1482.0 kg there and 1479.6 kg on the bar schedule.
   No steel-member schedule adds lengths or masses at all, so there is nothing else to add up.

---

## Numbered findings (new, ranked)

### 1. MEDIUM: CEMEMBER takes the only section that starts with what you typed, even when your number was complete

1. **Where:** `Modules/Structural.DesignCore/SteelSections/CeMemberPrompts.cs:101-117` (`FindByName`, the
   `StartsWith` test at line 112), used by `Modules/Structural/Commands/CeMemberCommands.cs:372`.
2. **What the drafter sees:** at "Section name", type `114.3x6` for a 114.3 x 6.0 CHS handrail post. The list has no
   6.0 wall, and the only name starting with `114.3X6` is `114.3x6.4CHS`, so CEMEMBER says "Pick point 1 of
   114.3x6.4CHS" and draws the 6.4 wall. Same for `168.3x6` to 168.3x6.4, `101.6x6` to 101.6x6.4, `60.3x4` to 60.3x4.5,
   `89x89x3` to 89x89x3.5 SHS. The name is on the command line, so a careful drafter can catch it; a fast one will not.
3. **Severity:** MEDIUM. **SURE** (read end to end: squash spaces, exact match first, else one unique prefix wins).
4. **Smallest fix:** a prefix only counts when the next character of the section name is a letter, never a digit or a
   decimal point. `310UB3` still finds 310UB32; `114.3x6` then says "no section called 114.3x6".

### 2. MEDIUM: the office's short spellings and the Lysaght purlin names are not found by SBEAM or CEMEMBER

1. **Where:** names in `Modules/Structural/Assets/Config/section-catalogue.json` (for example line 88 `460UB74`, line
   432 `250UC90`); SBEAM search `SbeamSelectionPlanner.cs:225-241` (contains-match); CEMEMBER `CeMemberPrompts.cs:101`;
   the office spelling table `Modules/Structural/Services/ExcelMTextService.cs:283-293`.
2. **What the drafter sees:** the list rounds most UB masses up (59.7 to `410UB60`, 56.7 to `360UB57`, 25.7 to
   `250UB26`, 29.8 to `200UB30`, 89.5 to `250UC90`, 59.5 to `200UC60`, 96.8 to `310UC97`), but rounds 74.6 down
   (`460UB74`). XCLMTXT's own table spells them `410UB59`, `360UB56`, `250UB25`, `200UB29`, `250UC89`, `310UC96`.
   So on one job: the schedule says 410 UB 59.7, the drafter types `410UB59` in SBEAM and the list goes blank. Typing
   `460UB75` (the rounding everybody else uses) also finds nothing. A Lysaght name such as `Z15019` finds nothing
   either: the list calls it `ZC150` (which does not say the 1.9 mm thickness).
3. **Known parts, not counted again:** the decimals `310UB32.0` and `250UB25.7` (22 Oct audit finding 9) and the rounded
   names in general (BUG-818). New here: the truncated office spellings, the one inconsistent row, and the purlin names.
4. **Severity:** MEDIUM (a refusal, never a wrong section). **SURE.**
5. **Smallest fix:** when the BUG-818 list goes in with supplier names, also accept depth + family + mass within 0.5 kg/m
   (`410UB59`, `410UB60` and `410UB59.7` all find 410UB59.7) and the Lysaght `Z`/`C` + depth + thickness names.

### 3. MEDIUM (impact UNSURE): since 1.0.122, UB and UC rows in the office MEMBERS.csv are never applied

1. **Where:** `ExcelMTextService.cs:5733` locks every UB/UC size (`ProtectExplicitMemberSizes`, its pattern now starts
   with the UB/UC case, line ~5877) before the office spelling list is applied at lines 5736-5765, and unlocks after.
2. **What the office sees:** if MEMBERS.csv (in the shared CE assets folder) has a row such as `250UB26` to
   `250 UB 25.7`, written to correct a common engineer typo, XCLMTXT now prints `250 UB 26` and says nothing. Before
   1.0.122 the row was used.
3. **Severity:** MEDIUM if the office file has UB/UC rows, otherwise none. **SURE** about the code path; **UNSURE** about
   the file contents (I did not open the office file: it is outside the repo).
4. **Smallest fix:** run the office list first and lock the sizes afterwards, or lock only sizes the office list does
   not name. Then check the real MEMBERS.csv for UB/UC rows.

### 4. MEDIUM (needs Tim's word): CEMEMBER always stands an unequal angle on its long leg

1. **Where:** `Modules/Structural.DesignCore/SteelSections/CeMemberCatalogue.cs:96-99` (the long leg is always the
   upright leg) and the four angle choices in `CeMemberPrompts.cs` (`LeftBottom`, `RightBottom`, `LeftTop`, `RightTop`).
2. **What the drafter sees:** a 150 x 90 x 10 UA shelf angle under brickwork with the 90 leg up and the 150 leg flat
   cannot be drawn. The side elevation is always 150 deep, the section always shows the 150 leg standing. The only way
   is to draw it wrong and ROTATE it, losing the base-point choice.
3. **Severity:** MEDIUM. **SURE.** The card (`decisions/2026-10-18_CEMEMBER_DESIGN.md` item E1.4) defines "upright" and
   "flat" legs but never says which UA leg may be upright, so this is a gap, not a decision.
4. **Smallest fix:** for UA only, one more question "Upright leg [Long/Short] <Long>". Recommendation: add it; lintels
   stay as today by default.

### 5. LOW (question for Tim): CEMEMBER cannot draw an RHS laid on its flat

1. **Where:** `CeMemberElevation.cs:86` (`Rhs`: "depth standing vertical"); RHS gets no orientation question.
2. **What the drafter sees:** a 150 x 50 RHS lintel or purlin laid flat has a side elevation 150 deep instead of 50.
3. **Severity:** LOW. **SURE.** Tim confirmed "SHS, RHS, CHS (hollow, one orientation)" on 18 Oct, so this is not a bug
   until he says so. Recommendation: offer "Standing/Flat" for RHS only.

### 6. LOW: the SBEAM window shows small section properties rounded to one decimal place

1. **Where:** `Modules/Structural/UI/Dialogs/SteelSectionPickerDialog.xaml.cs:651-652` (`FormatDim` uses `0.#`).
2. **What the engineer sees:** 40 x 40 x 3 EA shows Ix **0** (list value 0.04); 50 x 50 x 3 EA shows 0.1 (list 0.08);
   75 PFC shows Iy 0.1 (list 0.14, 29 percent off); a 1.12 kg/m angle shows 1.1 kg/m.
3. **Severity:** LOW (display only; the stored record keeps the full figure). **SURE.**
4. **Smallest fix:** show three significant figures.

### 7. LOW: angle toe radius is drawn on the outside corner of each leg tip

1. **Where:** `Modules/Structural/Services/StructuralDetailService.cs:235-275` (`DrawAngleInternal`, used by SBEAM and
   CEMEMBER for every EA and UA section).
2. **What the drafter sees:** zoomed in on a 100 x 100 x 10 EA section, the 5 mm round is on the tip's back corner
   (the face in line with the heel) and the inside corner of the tip is sharp. Supplier drawings put the toe radius on
   the inside corner of the tip (from memory, UNVERIFIED against a catalogue figure here).
3. **Severity:** LOW (5 mm on a section usually drawn at 1:10 to 1:20). **SURE** about what the code draws.
4. **Smallest fix:** keep the outer tip corners sharp and put the arc between the tip face and the inside face
   (bottom leg: from (leg, t minus toe) round to (leg minus toe, t); same on the upright leg).

### 8. LOW: XCLMTXT writes "PLATE" only when "PL" has a space after it

1. **Where:** `ExcelMTextService.cs:5777-5778` (replaces `" PL "` with `" PLATE "`).
2. **What the drafter sees:** `TOP PL & BOT PL` prints `TOP PLATE & BOT PL`; `250 x 16 PL` at the end of a cell stays
   `PL`, while `250 x 16 PL WITH 4/M16` becomes `PLATE WITH`. One schedule then uses both words for the same thing.
3. **Severity:** LOW. **SURE.**
4. **Smallest fix:** replace the whole word `PL` (not followed by a digit) wherever it stands.

### 9. LOW: BARWEIGHT and the bar schedule use two different bar mass tables

1. **Where:** BARWEIGHT reads `Modules/Structural/Services/StandardsService.cs:78-89` (via `RebarService.cs:32-38`); the
   bar schedule reads `Assets/Config/rebar-catalogue.json:5-12` (via `ReoBarService.cs:849-852`).
2. **Hand calculation:** 100 N20 bars x 6.0 m = 600 m. BARWEIGHT: 600 x 2.47 = **1482.0 kg**. Bar schedule:
   600 x 2.466 = **1479.6 kg**. N16, 50 bars x 12 m: 948.0 against 946.8 kg. N40, R6 and R10 get a mass from BARWEIGHT but
   UNKNOWN on the bar schedule (the catalogue has N10 to N36 only).
3. **Severity:** LOW (0.1 to 0.2 percent; but a quantity check against the schedule will not tie). **SURE.**
4. **Smallest fix:** one table (design rule 1): BARWEIGHT reads rebar-catalogue.json.

### 10. LOW: 250UC89.5 is drawn with square corners; every other UC has fillets

1. **Where:** `section-catalogue.json:432` (`250UC90` has no `rootRadius`); `SectionDatabaseService.cs:283-286` treats a
   missing radius as 0.
2. **What the drafter sees:** a 250UC90 section with sharp web-to-flange corners beside a 250UC73 with 13 mm fillets.
3. **Severity:** LOW. **SURE.** The real radius is about 13 mm (from memory, UNVERIFIED).
4. **Smallest fix:** add the radius with the BUG-818 list. (`400WC328` also has none, which happens to be right for a
   welded section; see BUG-819.)

### 11. LOW: SBEAM "Estimated weight" takes a length typed in millimetres as metres

1. **Where:** `SteelSectionPickerDialog.xaml:145` ("Optional member length (m)") and `SbeamSelectionPlanner.cs:123-137`.
2. **What the drafter sees:** type `6000` (the drafter's usual millimetres) for a 310UB32 and the window says
   **192000 kg**. No sense check. (The weight is not stored on the drawing.)
3. **Severity:** LOW. **SURE.**
4. **Smallest fix:** any length over 100 is read as millimetres, with the unit shown beside the result.

### 12. LOW (latent): placed members will not find their section once the list gets supplier names

1. **Where:** `Modules/Structural.DesignCore/SteelSections/CeMemberReplanner.cs:45-52` and `:126-130` (exact name match,
   spaces and case only). No live caller yet (the CEMEMBER edit card is a draft). SBEAMEDIT has the same exposure (22 Oct
   audit finding 14).
2. **What the drafter will see:** after BUG-818 renames `310UB32` to `310UB32.0`, grip-editing an existing CEMEMBER beam
   says "CEMEMBER: 310UB32 is not in the section list, so the member cannot be redrawn. Nothing changed."
3. **Severity:** LOW today, MEDIUM the day the list changes. **SURE** by reading.
4. **Smallest fix:** the new list carries an "old names" field and the lookup accepts it.

### 13. LOW (UNSURE): the new XCLMTXT angle rule only works when the angle symbol comes straight after the size

1. **Where:** `ExcelMTextService.cs:5792-5814` (`NormalizeAngleSymbols`, new in 1.0.122). The old code replaced every
   angle symbol in the cell.
2. **What the drafter would see:** a cell written `L ]L 150x90x10` or `150x90x10 GALV L ]L` now prints the raw
   characters `L ]L` on the schedule.
3. **Severity:** LOW. **UNSURE:** I do not know whether any engineer's sheet puts the symbol anywhere but after the size.
4. **Smallest fix:** after the size rule, replace any angle symbol left over with EA or UA from the nearest size, or
   leave a plain warning line.

### 14. LOW (switched off by default): CSMEMBERSCHED treats "310UB32" and "310 UB 32" as two sizes

1. **Where:** `Modules/Structural/Core/Schedules/MemberScheduleFromPlan.cs:216-227` (sizes compared as typed, case only).
2. **What the drafter would see:** two FB3 beams, one labelled by SBEAM `310UB32`, one typed `310 UB 32`: the
   schedule says FB3 **Unknown** and "drawn with different sizes".
3. **Severity:** LOW (Settings MemberSchedule.Enabled is off by default). **SURE.**
4. **Smallest fix:** compare sizes with spaces removed and `x` treated the same in any case.

---

## Hand checks (26 sections; supplier figures from memory)

Order of each line: depth, flange width, flange thickness, web thickness, mass. "Matches" means the list agrees with the
figure I am sure of.

1. **610UB125:** 612, 229, 19.6, 11.9, 125. Matches.
2. **530UB92.4:** 533, 209, 15.6, 10.2. Matches (name rounded, BUG-818).
3. **460UB82.1:** 460, 191, 16.0, 9.9. Matches.
4. **410UB59.7:** 406, 178, 12.8, 7.8; Ix 216. Matches.
5. **360UB56.7:** 359, 172, 13.0, 8.0. Matches.
6. **310UB46.2:** 307, 166, 11.8, 6.7. Matches.
7. **310UB32.0:** 298, 149, 8.0, 5.5; Ix 63.2; Zx 424. Matches. Hand mass: 2 x 149 x 8 + 282 x 5.5 + four 13 mm
   fillets = 4,080 mm2 x 7850 kg/m3 = **32.0 kg/m**.
8. **250UB37.3:** 256, 146, 10.9, 6.4. Matches.
9. **250UB25.7:** 248, 124, 8.0, 5.0; Ix 35.4. Matches. Hand mass: 1,984 + 1,160 + 124 fillets = 3,268 mm2 = **25.7 kg/m**.
10. **200UB18.2:** 198, 99, 7.0, 4.5. Matches.
11. **180UB16.1:** 173, 90, 7.0, 4.5. Matches.
12. **150UB14.0:** 150, 75, 7.0, 5.0. Dimensions match; Ix 6.06 is low (BUG-818).
13. **310UC158:** 327, 311, 25.0, 15.7. Matches.
14. **310UC96.8:** 308, 305, 15.4, 9.9. Matches.
15. **250UC89.5:** 260, 256, 17.3, 10.5. Dimensions match; no root radius (finding 10).
16. **250UC72.9:** 254, 254, 14.2, 8.6. Matches (mass field 73, rounded).
17. **200UC46.2:** 203, 203, 11.0, 7.3. Matches.
18. **150UC23.4:** 152, 152, 6.8, 6.1. Matches.
19. **100UC14.8:** 97, 99, 7.0, 5.0; Ix 3.18. Matches.
20. **380PFC:** 380 x 100, flange 17.5, web 10.0, 55.2 kg/m. List web 13.5: wrong (BUG-818).
21. **150PFC:** 150 x 75, flange 9.5, web 6.0, 17.7 kg/m. List web 5.5: wrong (BUG-818).
22. **100x100x10 EA:** hand mass from its own figures 10 x 190 = 1,900 mm2 = 14.9 kg/m; list 9.42 (BUG-818).
23. **150x90x10 UA:** hand 10 x 230 = 2,300 mm2 = 18.1 kg/m; list 18.06, self-consistent. Supplier figure UNVERIFIED.
24. **100x100x6 SHS:** hand about 16.7 kg/m (2.5t outside corners); list has no mass (BUG-818).
25. **114.3x6.4 CHS:** hand mass 17.0 kg/m (list 17.0); hand Ix 3.17 x 10^6 against list 4.08 (CHS Ix high, 22 Oct
    audit). Whether 114.3 x 6.4 is a stocked Australian size: UNVERIFIED (6.0 is the one I know).
26. **200x100x5 RHS:** hand about 22.3 kg/m; list 24.1, 8 percent high (22 Oct audit, RHS masses high).

**Names:** a script over all 372 rows found every name parses with its own family pattern, no duplicate names, and
name-to-dimension agreement everywhere. The only name/mass disagreement is `460UB74` (field 74.6). Rows with no mass:
21 CHS, all 12 C purlins and most SHS/RHS (known, BUG-818); their SBEAM "Estimated weight" shows a dash.

---

## Already known (not counted)

BUG-818 (wrong list figures, rounded names, missing masses), BUG-819 (angle actual thickness, welded root radius, purlin
widths and lips), BUG-858 (Z outline), BUG-880 and BUG-952 (member drawn at the wrong size by units or scale), BUG-909
(UCS), BUG-974 and BUG-1014 (XCLMTXT schedule), BUG-1039 (timber quantity 10), AUDIT-XCLMTXT-DECIMALS and
AUDIT-XCLMTXT-ANGLES (now in the 1.0.122 build through #1533: built and unit-tested, not tried in AutoCAD), and the 22 Oct
engineering audit findings 9 (decimals refused), 13 (vertical member flip) and 14 (stored stiffness).

---

## What I did NOT check

1. **Nothing in AutoCAD,** and no test or build was run. Every finding is from reading the code or hand arithmetic.
2. **No Standard or supplier catalogue was open.** All supplier figures are from memory; anything marked UNVERIFIED needs
   the InfraBuild, Australian Tube Mills or Lysaght tables.
3. **The office MEMBERS.csv** (finding 3) and the corrected draft section list on Tim's other PC were not opened.
4. **The real Excel angle glyph** (finding 13): I relied on the earlier audit's reading that it arrives as `L ]L`.
5. **Timber sections,** the timber grade list and the lintel table, the wall and footing schedules beyond their counts,
   the tie-down schedule beyond its counting, and the RC member windows.
6. **Civil and Manager** (not in this area).
7. **Dead code noted, not reported:** `MemberMarkGrammar`/`MemberScheduleParser` (no live caller; would reject an `LL1`
   lintel mark) and the steel table inside `StandardsService` (no caller).
