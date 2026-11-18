# Tools interview: checklist and working notes

**Revision:** 2 (Wed 18 Nov 2026, afternoon, Melbourne time). Revision 1 used T-numbers for answers; now TA-numbers (D-205).
**Reports to:** the planning chat (D-198). Planning only; nothing is built.
**Progress:** 16 of 28 questions answered (16 asked in 9 batches, all answered; 12 still to ask). One message from Tim was also recorded (TA-017).
**Next batch:** prepared below; asked only when Tim comes to this chat (planning chat ruling 7).

## Read before asking

1. `DECISIONS.md` D-001 to D-205.
2. `design\FOUNDATION.md`, `design\UI_PLAN.md` (with the scheme picked 18 Nov at its end), `design\NAMING_DRAFT.md`, `design\NAMES_C_AND_RC_PROPOSAL.md`, `stage6\PERFORMANCE.md`, `stage6\THE_PLAN.md` section 3: read in full.
3. `design\SITUATIONS.md`: Tim's 18 answers (D-177 to D-195) read; the situation walk itself (sections A to K) read by heading only.
4. `reference\today\TOOLS_TODAY.md`, `evidence\TIM_ALIAS_LIST_16NOV.md`, `stage3\PARTS_BIN_REPORT.md`, the old plug-in at `origin/claude/rel-20261114a` (read only).
5. AutoCAD's own short names: a copy of `acad.pgp` (417 short names, file dated 4 Feb 2026) at `C:\CE_WORK\trials\zero\isolate\...\Support\acad.pgp`, read only. Which AutoCAD version it came from is not stated in the file; treated as AutoCAD's standard list. It lists short names only, not full command names (see note 4).
6. Waiting for: `reference\research\R-006_HATCH_AND_GRIPS.md` (D-199). ST-06 hatches is not designed past "too many names" and "wrong scale" until it lands.

## Done (16)

1. [x] Which helpers are used on both civil and structural, list 1 (TA-001)
2. [x] Same, list 2 (TA-002)
3. [x] What is wrong with hatches (TA-003)
4. [x] Dims and leaders (TA-004)
5. [x] C, the repeat copy (TA-005)
6. [x] MR, CR, CPB, DIV (TA-006)
7. [x] Clean-up (TA-007)
8. [x] Revision cloud name (TA-008)
9. [x] Slab joints (TA-009)
10. [x] Blocks palette (TA-010)
11. [x] What the Manager does (TA-011)
12. [x] What the Manager does not do (TA-012)
13. [x] Admin shape (TA-013)
14. [x] First in importance (TA-014)
15. [x] The rest of the order (TA-015, now D-201)
16. [x] Where the tools sit on screen (TA-016, now D-200)

## Still to ask (12)

17. [ ] TQ-01 Names for the three tabs (batch 10)
18. [ ] TQ-02 Does the structural tab show before structural is unparked (batch 10)
19. [ ] TQ-03 A short name for CLEAN (batch 10)
20. [ ] TQ-04 Q against "q, *mltim" in his alias list: first ask what his q does today (batch 10)
21. [ ] TQ-05 DIV and DIVX: first ask what his Div does today (batch 11)
22. [ ] TQ-06 Name for the hatch window (held until R-006)
23. [ ] TQ-07 Revision box: still ask about object snap first (batch 11)
24. [ ] TQ-08 Break line name: first ask what his Bl does today (batch 11)
25. [ ] TQ-09 What "learn from where joints are placed" means (batch 11)
26. [ ] TQ-10 Renaming the 279 machine-named blocks in the master drawing (on a copy) (batch 12)
27. [ ] TQ-11 Typed name for the blocks palette (batch 12)
28. [ ] TQ-12 Which hatches go in the office list (held until R-006)

## Name check results (AutoCAD's acad.pgp copy and Tim's alias list)

1. **Free in both:** RV, CJ, SSC, MR, CR, CPB, LD, AD, QD, DUP, CLEAN, CN, CLN, RD, ARCDIM, BK, BRK, BRL, BLK, OB, QL, DIVX, EH, WH, H2A, HC, HT, HP, HX, FL, OH.
2. **Taken in Tim's list:** Q (mltim), DIV (Divide), CH (Chamfer), BL (Block), WT (Wall-t, D-170).
3. **Taken in AutoCAD's list:** DIV (DIVIDE), CH (PROPERTIES), CL (CENTERLINE), LE (QLEADER), IO (INSERTOBJ; already known and kept by D-054).
4. **Full words not checkable from acad.pgp:** it holds short names only. BREAKLINE is believed to be an AutoCAD Express Tools command name (not proven here; the night run must type it once). REVBOX, CONSTRUCTIONJOINT, SAWCUT, CLEAN, ARCDIM, MOVEROTATE, COPYROTATE, COPYASBLOCK likewise need the night run's one-type check (NAMING_DRAFT check 3).

## Prepared: batch 10 (ask when Tim comes to this chat; each question carries its own context and example)

1. **TQ-01 Tab names.** "You asked for three ribbon tabs with better names than CE CIVIL, CE TOOLS&MANAGER and CE STRUCTURAL. AutoCAD's own tabs are one short word (Home, Insert, Annotate), and AutoCAD already has an 'Express Tools' tab, so a plain 'Tools' tab would sit confusingly near it. Which three?" Choices: **A (recommended): CE Civil · CE Tools · CE Structural**, short, the CE mark keeps them together and apart from Express Tools; B: CE Drainage · CE Draft · CE Structure; C: CE Civil · CE Office · CE Structural (Office = shared tools and Manager).
2. **TQ-02 Structural tab before structural is built.** "Structural tools stay parked until civil works (D-006). Until then, should the CE Structural tab show?" Choices: **Hidden until it has tools (recommended)**, so no one clicks an empty tab; Shown, empty, with a 'coming later' note.
3. **TQ-03 CLEAN short name.** "You type CLEAN many times a day to save. AutoCAD's own short names are one to three letters. CN is free in AutoCAD's list and yours." Choices: **CLEAN only, no short name (recommended)**, you already type it and it is clear; CLEAN with short CN as well.
4. **TQ-04 What your q does.** "Your own alias list has 'q, *mltim', so typing Q runs mltim, not the old CE arrow leader. What is mltim?" Choices: A command I use (keep my Q; the CE leader gets QL, free in both lists); Nothing I use (CE leader takes Q; you move your alias); Not sure.

## Prepared: batch 11

1. **TQ-05 What your Div does.** Div is in your list AND AutoCAD's as Divide. Ask whether DIVX (cross marks) is still wanted, recommended: retire both, use DIVIDE / MEASURE.
2. **TQ-08 What your Bl does.** Bl is Block in your list. Recommended BREAKLINE / BK (BK free in both), with the warning that BREAKLINE may already be an Express Tools command, so BRKLINE / BK is the fallback.
3. **TQ-07 Revision box and object snap.**
4. **TQ-09 Joints that learn.**

## Working notes

1. **Gap, recorded only (planning chat ruling 3):** structural-only commands (text tags, beams, bracing, supports, footings) were never offered as shared tools. They stay parked under D-006 unless Tim raises them himself.
2. **D-199 before ST-06:** hatch grips and "recreate boundary" are misbehaving in Tim's AutoCAD; research R-006 first.
3. **First release changed by Tim's words:** D-200 (three tabs) and D-201 (all shared tools ST-01 to ST-10 in the first release, CLEAN first). THE_PLAN section 3 still says "Not in the first release: CE everyday helpers; Manager changes": the planning chat's to update.
