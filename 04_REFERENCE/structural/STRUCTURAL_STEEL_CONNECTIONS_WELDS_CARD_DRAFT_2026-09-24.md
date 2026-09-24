# Structural steel connections and welds — command card, DRAFT for Tim's OK (24 Sep 2026)

**Status:** DRAFT. No code starts until Tim answers section 4 (AGENTS.md review gate).
**Why:** Tim, 24 Sep about 11:10 (verbatim): *"LETS ADD WELD SYMBOLS ... CAN WE UPDATE STEEL CONNECTIONS TO SUIT WHAT
CREATIVE  ENGINEERING USE"* (decision file entry of that time).

## 1. What V3 has today (read from `claude/struc-d1-prep`)

1. **Nothing draws.** STLCONN (+1/3), PORTAL, TRUSS, PURLINS, ANGLES, BOLTS, BRACE, BASEDET, GUSSETS, RIDGE and KNEE
   are hidden stubs in `Modules/Structural/Commands/SteelworkDetailCommands.cs`. Each prints "Phase 3 (not yet
   implemented)". So "update to suit CE" means **build them from CE's own practice**.
2. **No weld tool** of any kind.

## 2. What CE actually details — the evidence (read-only helper, 24 Sep; job numbers only)

Sources: CE's base-plate and connection standard details (text extracted in the evidence store,
`02_Anonymised_Evidence`, gate F native summary; two source drawings), plus keyword hits across the 300-project
evidence set. **These are keyword counts, not a clean per-job tally; treat the ranking as indicative.**

1. **Column base plates — the dominant family** (about 89 hits). CE's standard wording, about 14 times verbatim:
   *"12 THICK BASE PLATE, 6 CFW ALL AROUND TO COLUMN, 4-M16 CHEMSET ANCHORS x175 MIN. EMBEDMENT INTO STRIP FOOTING,
   20 THICK NON-SHRINK GROUT PAD"*. Variants: 16 thick, recessed, square, triangular stiffeners. Included only where
   that column type is on the plan.
2. **Web cleats / bearing plates** (about 16): e.g. *"10 THICK CLEAT PLATE, 6 CFW TO STEEL BEAM, 3-M16 8.8/S
   BOLTS"*; lighter 8 thick cleats with 2-M12 4.6/S bolts to purlins.
3. **Bolted moment end plates (portal frames):** *"20mm THICK PLATE F.S.B.W. TO TOP/BTM FLANGE, 3-M20 or 6-M20
   8.8/S BOLTS"*, extended end plate and cap plate; *"FULLY WELD ... WITH 6CFW AFTER FINAL ALIGNMENT"*.
4. **Beam end plates** (about 10, M12 to M16) and **cast-in plates** (CP1 to CP3, FSBW, N16 L-bar lugs).
5. **Stiffeners / gussets** (about 33): always with another connection, never on their own.
6. **Not seen at all:** "fin plate", "haunch", "knee", "ridge", "web side plate". CE names connections by member mark.
7. **Bolts:** M12, M16, M20 (no M24 seen); 4.6/S for secondary, 8.8/S for primary; 2 to 6 per connection.
8. **Welds: CE writes them as text notes**, e.g. "6 CFW", "6 CFW ALL AROUND", "F.S.B.W.". **No graphic weld
   symbols were found** in the sampled drawings. 6 CFW is by far the most common.
9. Tim's "the rest we don't really use" matches the evidence: stairs, retaining walls, slab-on-ground details and reo
   hooks or cogs are thin or absent.

**Gaps in the evidence:** no weld category (GP/SP) and no bolt gauges are recorded anywhere.

## 3. Proposed V3 behaviour (waiting on section 4)

1. **Weld notes** *(Question 1)*: a leader with CE's weld wording, picked from a short list (6 CFW, 6 CFW ALL AROUND,
   F.S.B.W., 6 CFW AFTER FINAL ALIGNMENT, and a free entry), size editable. List and default size on the Settings page.
2. **Steel connections, one command per family, in this order** *(Question 2)*:
   1. **Base plate:** plan and section to scale, with CE's standard note built from the values.
   2. **Web cleat.**
   3. **Portal moment end plate.**
   4. **Beam end plate.**
   5. **Cast-in plate.**
   Stiffeners are an option inside each, not a command of their own. The KNEE, RIDGE and other stubs stay hidden
   until a family replaces them. Each family gets its own short card before it is built.
3. **Defaults on the Settings page (R-00)**, seeded from CE's standard wording *(Question 3)*.
4. **Every command is one AutoCAD Undo.** Escape leaves the drawing unchanged. Locked layers and Xrefs are respected.
   Both lanes: 2027 and 2022-2024.

## 4. Questions for Tim

1. **Welds: symbol or note?** CE's drawings write welds as text ("6 CFW ALL AROUND"). StrucPlus had graphic
   AS 1101.3 weld symbols.
   - **A (recommended): weld note leaders with CE's wording.** They match how CE drawings already look.
   - **B:** graphic weld symbols as StrucPlus drew them.
   - **C:** both.
2. **Order of the connection families:** base plate, web cleat, portal moment end plate, beam end plate, cast-in plate.
   **Recommended: as listed**, most used first.
3. **Base plate defaults** = 12 thick plate, 6 CFW all around, 4-M16 Chemset anchors x175 embedment, 20 thick
   non-shrink grout pad. **Recommended: yes**, CE's own standard wording, editable on the Settings page.

**Not a Tuesday item.** The build starts after Tim's answers, one family at a time, each tested in AutoCAD before
the next.

## 5. Tim's answers

(none yet)
