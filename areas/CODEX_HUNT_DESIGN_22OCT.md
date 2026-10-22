1. **ANSWER FIRST — HIGH 1 / MEDIUM 3 / LOW 1.** Five additional faults verified by reading the nominated Civil source. None has been reproduced in AutoCAD during this hunt. The filename follows the 22 October brief; this review was completed on 23 October 2026, Melbourne time.

2. **Most important: separate detention systems can be counted together.** If two schedule sets each contain pits P1 and P2, CDTWL joins them by those printed numbers and loses their separate identities. In the fixture below, it reports 3,427 L and says 2,500 L is enough, although neither individual system holds that much under the same calculation.

3. **Other effects a drafter will meet.** CDCALC substitutes RL 0.00 for a negative-level TWL; a long section understates a three-pipe pit's depth; a known low lid disappears from overflow checks when its floor is unknown; exact cover and depth limits can produce false warnings.

4. **Next action.** The later AI test lane should run the five cases below on synthetic copies. No action or testing is requested from Tim. No plugin code, settings or drawing was changed; no build, tests, AutoCAD, installation or sub-agents were run. Only this findings file was authored.

---

1. **Scope and source.** Read `C:\TimOS\RULES.md`, `ROUTER.md`, the CE_PLAN start/map and the D/F and K area records. Fetched the plugin repository and read Git objects only. Civil references below are at `origin/claude/rel-20261022m`, commit `40ee0a36f7960145743954b39859eb6c3af92869` (Civil 3.0.70 / Manager 1.1.70). Also confirmed the nominated Structural ref at `2c9a96942a024888a5ab520600f2d5025de83036`; no Structural finding is asserted. These are source identities, not an independent inspection of installed DLLs.

2. **Earlier findings excluded.** Reviewed `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the Civil, Structural and Gate `CODEX_AUDIT_*_22OCT.md` reports. Also checked the existing Civil DFGH/IJK hunts and `AUDIT_ENGINEERING_CIVIL_2026-10-22.md` for duplicates. Their metre conversion, pit/pipe overlap, phantom tank pit, solid detention chamber, dead storage, full-pipe storage, head definition, straight-distance grade, missing branch marks and already reported flat/adverse-grade cases are not counted here.

3. **Evidence and test limits.** VERIFIED-BY-READING means the production caller, data selection and arithmetic were traced; predicted AutoCAD output is not an observed result. No suspected-only item is included in the counts. Every DETERMINISTIC TEST below is NOT RUN. Fixtures must contain real synthetic CE objects plus matching records, distinct permanent keys/handles and confirmed connections, not just unconnected text. Use isolated test settings and run on AutoCAD 2024/net48 and 2027/net10. Never use client drawings. No new hard block is proposed: preserve unknowns, warn and continue under R-27; engineering settings remain under R-00.

**Numbered findings**

1. **DESIGN-01 — HIGH — CDTWL merges separate systems with repeated pit numbers. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/DetentionTwlService.cs:112` and `:117`; `Modules/Drainage/Commands/DetentionTwlCommand.cs:91`; `Modules/Drainage/Rules/DetentionBranchCollector.cs:85`, `:91`, `:127`, `:164`, `:323`.

   **What happens in AutoCAD:** Two separate networks can become one fictitious storage system. Selecting the outlet by its printed pit number cannot distinguish schedule sets. The result can say the storage is sufficient using pipes from another network, and even measure those pipes using the other network's pit positions.

   **Exact failure:** `FindDetentionPits` returns distinct pit marks, not permanent identities. `WalkUpstream` follows `From`/`To` marks; `pitById[pit.Id.Trim()] = pit` retains the last pit with each mark. Both-end membership then includes every matching pipe, regardless of its `FromSpineKey`, `ToSpineKey` or schedule set. Thus both network membership and pipe length can be wrong. Repeated marks across sets are an expressly recognised case elsewhere: `ProfileRouteEvidenceCaptureService.cs:55` uses handles because two sets can each have a P1.

   **DETERMINISTIC TEST — fixture:** Millimetre drawing, no tanks or twin pipes, `detention.pipeStorageWallToWall=false`. Two physically separate sets A and B, each with one DN300 P1-to-P2 pipe, both endpoint inverts RL 10.000. Both P2s are detention pits. All four pit records have X/Y widths 1,000 mm, floor RL 10.000 and cover RL 12.000. Set A positions: P1 `(0,0)`, P2 `(10000,0)`. Set B: P1 `(0,100000)`, P2 `(20000,100000)`. Give all objects unique keys/handles and correct endpoint keys. Store pits in order A-P1, A-P2, B-P1, B-P2. The simplified pit footprint is held identical to isolate the identity error; this test does not validate the already reported detention-chamber calculation.

   **Typed steps:** Open the fixture; type `CDTWL`; enter required volume `2.5`; at the TWL question enter `10.300` rather than a row number. Capture the command text and the `[TWL]` CE log line.

   **Assertion:** The outlet choice must distinguish A-P2 from B-P2, or explicitly report ambiguous identity without asserting a combined capacity. Each chosen branch must have one pipe. At TWL 10.300, A's pipe holds about 707 L and B's about 1,414 L; using the current pit-volume formula their separate totals are about 1,307 L and 2,014 L. Neither meets 2,500 L. Current source instead automatically chooses the sole distinct mark P2, counts two pipes at B's 20 m length, prints approximately `pipes 2827 L` and total `3427 L`, then `That is enough.` Reversing the pit-record order changes the same drawing's reported total to approximately 2,014 L: an additional deterministic identity check.

   **Correction direction:** Carry outlet and connection identities through collection and measure each pipe using its own resolved ends. Printed numbers are labels, not network keys.

2. **DESIGN-02 — MEDIUM — CDCALC treats valid zero/negative levels as missing and suppresses their freeboard warning. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/ViewModels/DetentionSystemViewModel.cs:708`, `:717`, `:818`, `:823`, `:845`, `:1278`, `:1285`; live drawing-to-seed path `:560`; window bindings `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml:189`, `:201`, `:213`.

   **What happens in AutoCAD:** A system below RL 0.00 gets an invented water level at zero, extra pit storage and the wrong baffle height. Even typing the correct negative TWL does not restore the warning about a low lid. A change of level datum therefore changes the engineering answer for identical geometry.

   **Exact failure:** `ComputeSuggestedTwl` returns zero whenever the highest selected invert is less than or equal to zero. Recalculate writes that into `Twl`, then uses it for storage and baffle calculations. Independently, `UpdateTwlWarning` returns immediately for TWL <= 0 or cover <= 0. The input reader accepts finite negative values, so these are reachable numbers, not parse failures.

   **DETERMINISTIC TEST — fixture:** Millimetre drawing with one selected DN300 detention pipe, 10 m long, from P1 at IL -1.000 to P2 at IL -1.100. Both pits are ordinary 1,000 by 1,000 mm pits with cover RL -0.500; use P2 as the calculator's orifice pit. PSD 5 L/s, required volume 1 m3, automatic baffle/orifice calculation ON. No other pipes, tanks or extras. Prepare a second identical fixture with every level raised by exactly 10 m.

   **Typed steps:** Type `CDCALC`, open Detention and its system, choose P2 in the orifice-pit box, and tick the existing `Use pit cover as TWL (suggested)` checkbox. Read TWL, baffle height and pit storage. Repeat in the translated fixture. Then untick that checkbox in the negative-level fixture, type TWL `-0.400`, and leave the box so it commits.

   **Assertion:** The suggested pipe-obvert TWL must be -0.700 versus 9.300 in the translated copy; baffle height must be 400 mm in both. Current source gives 0.00 and 1,100 mm in the negative copy, versus 9.30 and 400 mm in the translated copy. Its pit subtotal becomes 2.10 m3 instead of 0.70 m3 under the same uncapped pit formula. With manual TWL -0.400 and lid -0.500, the window must report the 100 mm exceedance of the lid; current `TwlWarningText` is empty. Positive- versus negative-datum equivalence is the main oracle, avoiding the separately known storage-model defects.

   **Correction direction:** Test whether a level is known and finite, separately from its sign. A level at or below zero is still a level.

3. **DESIGN-03 — MEDIUM — a three-pipe pit's long-section depth ignores its lower side connection and recorded floor. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/ProfileRouteReviewService.cs:403`, `:432`, `:444`, `:856`; `Modules/Drainage/Services/ProfileRouteEvidenceCaptureService.cs:795`, `:807`; `Modules/Drainage/Services/LongitudinalSectionService.cs:1242`, `:1364`, `:1773`, `:2035`; depth display `Modules/Drainage/ViewModels/ProfileRouteReviewViewModel.cs:47`.

   **What happens in AutoCAD:** Choosing one route through a junction can show the pit shallower than a pipe connected to that very pit. A different route through the same pit can show a different pit depth. This is a wrong depth and pit graphic, additional to the earlier missing branch-tick finding.

   **Exact failure:** For an intermediate pit, the controlling invert is the minimum of the two selected route-pipe ends. External connection evidence is collected only at the first and last route pits, and only for existing pipes. Neither other connected pipes at the intermediate pit nor its `InvertLevel`/`BaseRl` enters that minimum. The renderer repeats the route-only minimum for INVERT DEPTH and draws its fixed 0.30 m sump below it. Merely correcting the review's controlling value would leave the renderer's second calculation wrong.

   **DETERMINISTIC TEST — fixture:** One confirmed millimetre network, one schedule set: A `(0,0)` to B `(20000,0)` to C `(40000,0)`, with side outlet B to D `(20000,-20000)`. All pipes DN300 UPVC, known positive grade labels 1 IN 100. A-B inverts 10.220/10.020; B-C 10.000/9.800; B-D 9.500/9.300. B cover RL 11.000, recorded floor `InvertLevel` and `BaseRl` 9.400, width 1,000 mm. Other covers RL 11.000. Nominate B-C as B's main outlet and C as LPD. Enable the existing long-section office layout, with INVERT DEPTH in its row list.

   **Typed steps:** Type `CDPROFILE`, pick A, choose route A-B-C and its schedule set; datum 8.00, horizontal scale 100, vertical scale 50. Click `Preview New`, pick a clear insertion point, read B's Depth row, then click `Apply`. Inspect B's INVERT DEPTH text and the bottom of its drawn pit bar relative to the datum. Repeat with the B-D route where offered.

   **Assertion:** B's physical depth is 1.60 m from its recorded floor; even without trusting that floor, its known side outlet proves at least 1.50 m is needed. The A-B-C review and depth text must not assert 1.00 m without qualification. Current source shows 1.00 and draws the nominal sump bottom at RL 9.700, 200 mm above the side outlet invert and 300 mm above the recorded floor. Require a consistent floor/depth across route choices, or an explicit unresolved-depth warning. Preserve the selected route pipes' own ILs and grades.

   **Correction direction:** Resolve pit floor/depth from all confirmed pit facts once, independently of which pipe route is being displayed; pass that result through to the renderer.

4. **DESIGN-04 — MEDIUM — CDTWL drops a known low lid when that pit's storage cannot be calculated. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Rules/DetentionBranchCollector.cs:175`, `:194`, `:198`, `:206`; `Modules/Drainage/Rules/TopWaterLevelCandidates.cs:224`; `Modules/Drainage/Rules/DetentionTwlSolver.cs:142`; `Modules/Drainage/Services/DetentionTwlService.cs:303`.

   **What happens in AutoCAD:** A pit with a known cover but an unknown floor disappears from the lowest-lid and overflow checks. CDTWL says that pit was left out for missing storage data, but it can still describe a higher pit as the lowest lid and omit a warning that the chosen water level is above the known low cover.

   **Exact failure:** `BuildPit` returns null for an unreadable floor, after trying connected inverts, before it reads `KnownCoverLevelRl`. It also returns before that read if dimensions are absent. Candidates, solver ceiling and freeboard warnings all read only the resulting storage items. An unknown storage volume therefore discards an independently known overflow elevation.

   **DETERMINISTIC TEST — fixture:** Millimetre drawing with unique pit identities. Outlet O is the sole detention pit, floor RL 9.900, cover 12.000. P1 has floor 10.000 and cover 12.000. A DN300 pipe joins P1 to O with inverts 10.000/9.900. A second confirmed branch joins LOW to O: its LOW-end invert is blank, O-end invert 9.900. LOW is a normal grated pit with cover 10.200, widths 600/600 mm, blank `InvertLevel`, null `BaseRl`, and no other connection. O and P1 have known positive sizes. The unknown LOW-end invert must remain blank in the saved fixture and displayed label.

   **Typed steps:** Type `CDTWL`; enter required volume `0.1`; enter TWL `10.500`. Capture the candidate list, final command text and `[TWL]` log entry.

   **Assertion:** The output must name LOW as a known lid at 10.200 and warn that the chosen TWL is 300 mm above it, while leaving LOW's storage unknown. It must not identify 12.000 as the lowest lid in the whole system. Current source omits LOW from lid candidates and all freeboard warnings, reports 1,500 mm clearance against the retained pits, and only mentions LOW in the generic left-out note. A second fixture with LOW's floor known but its widths absent exercises the other early return.

   **Correction direction:** Keep level constraints separately from calculable storage pieces. Missing floor or dimensions must not erase a known lid; qualify total capacity where branch data is incomplete.

5. **DESIGN-05 — LOW — exact R-04 and R-29 limits can be falsely flagged through floating-point subtraction. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Rules/RulebookEngine.cs:466`, `:471`, `:663`, `:668`; contrast the numerical guard already used in `Modules/Drainage/Rules/PitDropRule.cs:155`.

   **What happens in AutoCAD:** A pipe with exactly 300 mm cover can be described as having `cover 300 mm ... below 300 mm`. A pit exactly 900 mm deep can be told it needs step irons even though this rule applies only above the configured threshold. The displayed rounded numbers conceal the numerical error.

   **Exact failure:** R-04 subtracts binary doubles and compares `coverMm < minimum` without a numerical precision guard. R-29 similarly compares raw calculated depth with the threshold. Decimal inputs such as 10.700, 10.100 and 11.000 are not all represented exactly; the comparison can cross the limit by a tiny fraction of a millimetre. This is distinct from the previously reported genuinely flatter 1:200.4 pipe being printed as 1:200.

   **DETERMINISTIC TEST — fixture A:** A confirmed DN300 gravity pipe with upstream pit cover 10.700 and upstream invert 10.100, downstream invert 10.000, 20 m length. Office minimum cover 300 mm, no council or project cover override, and otherwise complete current records/labels. Type `CDRULES`, `All`. Assert upstream R-04 is Pass at exactly 300 mm; current arithmetic is approximately 299.99999999999966 mm and selects Warn. Inspect that row in the full saved listing if it falls beyond the command-line display limit.

   **DETERMINISTIC TEST — fixture B:** Separate confirmed pit DEEP with cover 11.000, floor 10.100 and every connected pipe invert at that pit 10.100; no step-iron wording anywhere in its notes. Office step-iron threshold 900 mm. Type `CDRULES`, `All`. Assert R-29 Pass, no step irons needed at exactly 900 mm. Current arithmetic is approximately 900.0000000000003 mm and selects Warn. Control fixtures 1 mm either side must retain their proper outcomes; an engineering tolerance must not be invented to hide this precision issue.

   **Correction direction:** Apply a numerical precision guard consistent with the existing R-08 approach, preserving the Settings limits and their strict/inclusive meanings.

**Coverage and exclusions**

1. **Rules actually evaluated.** `RulebookEngine.cs:40` explicitly lists calculation-dependent R-05, R-09..R-28 groups as not evaluated by CDRULES; it is not proof those calculations passed. R-08 does select the lowest incoming invert and requires a unique main-outlet nomination when there are multiple outlets. Its numerical guard is present. No off-by-one fault was found in the inspected incoming `index - 1` / outgoing `index` profile mapping after separating the already reported mixed review columns.

2. **Flat and zero-length pipes.** The current profile fallback rejects zero fall, while CDTWL's barrel arithmetic accepts a flat pipe with a positive length. The earlier IJK flat-profile issue is excluded. CDTWL's collector rejects coincident pit centres with a named note. The known disagreement between centre distance and actual drawn route remains with the earlier audits. These are source observations, not executed edge-case results.

3. **Tailwater terminology.** CDTWL here means the chosen top water level of the upstream detained branch. The inspected collector/solver has no downstream tailwater boundary input. This review does not claim to validate a hydraulic backwater calculation or a new Australian Standard requirement. The findings rely on recorded geometry, arithmetic and Tim's rulings.

4. **Delivery boundary.** Only this file is to be committed by name and pushed in CE_PLAN after fetch and merge of origin/main. No plugin commit, branch, build, test, PR or Manager administrator work belongs to this brief. Unrelated CE_PLAN changes belong to other sessions. Undo is a named revert of this report's commit; the source and installed plugin are unaffected.

**Summary — under 100 words**

1. **Summary.** Five additional faults: one HIGH, three MEDIUM, one LOW. Prioritise CDTWL's mixing of separate networks with repeated pit numbers. Correct CDCALC's rejection of negative levels, the route-dependent pit depth, discarded low-lid constraints and false warnings at exact limits. Each finding includes a synthetic fixture, typed steps and an observable assertion. All are verified by reading; none was executed in AutoCAD. Existing audit findings are excluded. Only this report was authored; no source, settings or drawing changed.
