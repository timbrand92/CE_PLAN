# Bug carpark reconciliation, 22 to 23 October 2026

Written Fri 23 Oct 2026, about 01:00 Melbourne, by the CE bug-register librarian (Opus 5.5, desk agent). Read-only on `BUG_CARPARK.md`: this file proposes changes, the desk applies them. Snapshot of the register taken Thu 22 Oct 23:50 (11766 lines, 822 entries, BUG-001 to BUG-872); entries added after that are not covered.

**Installed builds checked against:** Civil 3.0.70 / Manager 1.1.70 (rel-20261022m), installed 22 Oct 20:24; Structural 1.0.121 (rel-20261022s2), installed 22 Oct 14:26 (QUEUE items 291 and 292).

---

## ANSWER FIRST (for Tim)

1. **The register is well behind the builds.** Of 822 bug entries, **427 have a wrong status line**: most say OPEN although the fix has been installed for days, and a few are accepted by Codex but never marked FIXED.
2. **Where every bug really is on the installed builds:**
   1. **OPEN, no fix:** 203
   2. **Fix built, not installed:** 63
   3. **Fix installed, robot (or a Codex look) says PASS, awaiting Codex acceptance:** 21
   4. **Fix installed, nobody has tested it yet in AutoCAD:** 468
   5. **Fix installed, tested and still FAILS in real AutoCAD:** 6
   6. **FIXED (Codex-accepted or your word):** 41
   7. **Superseded or duplicate:** 20
3. **The two examples the recount gave are confirmed.** BUG-858 (Z purlin outline) is installed in Structural 1.0.121 but its line says "not installed". BUG-859 (downpipe double-click) is installed in Civil 3.0.70 and still fails: Codex V10-01, 22 Oct 21:14, still opens AutoCAD's attribute editor.
4. **Newly found as accepted but never marked FIXED (17):** BUG-002, BUG-005, BUG-006, BUG-008, BUG-100, BUG-164, BUG-169, BUG-189, BUG-190, BUG-193, BUG-218, BUG-221, BUG-449, BUG-466, BUG-516, BUG-580, BUG-698.
5. **The biggest pile is "installed, never tested" (468).** These need robot then Codex looks, not more building. The 20 that most block 9 Nov are at the end of this file.
6. **102 entries still ask you to test in AutoCAD** ("awaiting Tim's test", "Steps for Tim"). Under your 20 Oct rule the AI does the testing; the list is below so the desk can reword them.

---

## How this was worked out (for the desk)

1. **States:** 1 OPEN no fix; 2 fix built, not installed; 3 fix installed, split into **3 (robot PASS)** = a robot run or a Codex look saw it pass but it is not Codex-accepted, and **3 (not yet tested)** = no robot or Codex result after the fix; 4 fix installed and still fails in real AutoCAD; 5 FIXED (Codex-accepted or Tim's word, per the carpark header); 6 superseded or duplicate (surviving id named).
2. **"Installed" test:** a commit whose subject names the bug (including forms like BUG-670/671/672 and BUG-070..078), or a PR whose title names it, reachable from `origin/claude/rel-20261022m` (40ee0a36, Civil and Manager) or `origin/claude/rel-20261022s2` (2c9a9694, Structural). Structural bugs count only on the Structural branch. A commit that only mentions a bug in passing was not counted where I read the entry.
3. **Test evidence:** entry text, robot reports `CLAUDE_DRIVER_RUN30_V2` to `RUN47_V2`, and Codex `CODEX_VERIFY_V1` to `V10` in `C:\Lisp Files\_TEST_COPIES_20260923`. A Codex result counts as PASS only where the report says PASS (DIFFERENT, BLOCKED, SEEN and NOT TESTED do not). Older Codex passes (pass 13 to 18, sweep C1, W-series, looks L1 to L4) are taken from what the entries quote.
4. **Limits:** about 200 entries were read and judged by hand (the ones with any test evidence and all of BUG-700 onwards); the rest were placed by the commit and PR rule and spot-checked. Umbrella entries with several items are placed by their main item; where only part is fixed the evidence line says so. Pre-monorepo fixes (May to July) are counted as carried into today's builds because the 2 Jul import copied that code; that was not re-proved line by line.
5. **Ready-to-apply replacements** are in section 4. Find the entry by its heading `## BUG-NNN`, then replace the first status line in that entry with the new line. Old lines are copied exactly from the snapshot; if the line has changed since, skip it and re-check.

---

## 1. Every bug, in number order

Format: **id** | current status (first six words) | **proposed state** | evidence.

1. **BUG-001** | FIXED (C only) — 2026-05-20; CR/MR | **5 FIXED** | C alias Tim-confirmed T19 (20 May); CR/MR handed to Tim, no CE work
1. **BUG-002** | ❌ STILL BROKEN — coded fix | **5 FIXED** **(status line wrong)** | Status Summary table: FIXED 13 May, Tim confirmed "works for now", a rare residual case parked; the entry line still says STILL BROKEN (12 May)
1. **BUG-003** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-004** | FIXED — 2026-05-20. | **5 FIXED** | status line: FIXED — 2026-05-20.
1. **BUG-005** | IN PROGRESS — coded 2026-05-08, awaiting | **5 FIXED** **(status line wrong)** | Status Summary table: FIXED 8 May, Tim checklist T21 Pass; the entry line still says IN PROGRESS
1. **BUG-006** | IN PROGRESS — coded 2026-05-08, awaiting | **5 FIXED** **(status line wrong)** | Status Summary table: FIXED 8 May, Tim checklist T20 Pass; the entry line still says IN PROGRESS
1. **BUG-007** | PARTIAL — 9 ✅ Pass, 4 | **6 superseded** **(status line wrong)** | umbrella of the 12 May batch; open parts live on as BUG-002, BUG-011, BUG-012
1. **BUG-008** | IN PROGRESS — coded 2026-05-12, awaiting | **5 FIXED** **(status line wrong)** | Status Summary table: FIXED 13 May, Tim confirmed; the entry line still says IN PROGRESS
1. **BUG-009** | FIXED — 2026-05-20. | **5 FIXED** | status line: FIXED — 2026-05-20.
1. **BUG-010** | FIXED — 2026-05-20. Tim re-confirmed T1 | **5 FIXED** | status line: FIXED — 2026-05-20. Tim re-confirmed T1 ✓ on 2026-05-20 after 3 successful opens recorded
1. **BUG-011** | OPEN — deferred to next update | **3 installed, not yet tested** **(status line wrong)** | commit 0bda3751 (29 Sep) locks the west callout left-justify, on rel-20261022m (Civil 3.0.70); Summary table says IN PROGRESS, entry says OPEN
1. **BUG-012** | OPEN — first attempt reverted 2026-05-12 | **3 installed, not yet tested** **(status line wrong)** | fix 0bda3751 (2026-09-29, "Fix BUG-012: FALL text patch no longer drags both texts to the origin;") on rel-20261022m; no robot or Codex result recorded
1. **BUG-013** | FIXED — 2026-05-13. Documentation only — | **5 FIXED** | build documentation item, no drawing behaviour; FIXED 13 May (commit e4546f6b)
1. **BUG-014** | FIXED — 2026-05-13 (commit 13fc5acb). Awaiting | **3 installed, not yet tested** **(status line wrong)** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-015** | FIXED — 2026-05-13. Awaiting Tim's AutoCAD | **3 installed, not yet tested** **(status line wrong)** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-016** | FIXED — 2026-05-13. Awaiting Tim's AutoCAD | **6 superseded** **(status line wrong)** | Status Summary: DEFERRED, replaced by the CD button redesign (v2.1 Phase 2); the entry line still says FIXED awaiting Tim
1. **BUG-017** | PARTIAL — 2026-05-20. Tim confirmed T23 | **6 superseded** **(status line wrong)** | T23 to T25 Tim-confirmed; the remaining T22 regression is BUG-035
1. **BUG-018** | FIXED — 2026-05-20. Tim confirmed T18 | **5 FIXED** | status line: FIXED — 2026-05-20. Tim confirmed T18 ✓. Installer payload verification (does PIT BLOCK 2
1. **BUG-019** | FIXED — 2026-05-20 (T7 ✓ confirmed | **5 FIXED** | status line: FIXED — 2026-05-20 (T7 ✓ confirmed by Tim).
1. **BUG-020** | IN PROGRESS — coded 2026-05-20, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex; CDWT rebuilt 13 Sep
1. **BUG-021** | IN PROGRESS — coded 2026-05-20, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-022** | PARTIAL — 2026-05-20. Tim confirmed middle | **6 superseded** **(status line wrong)** | middle floor wastes Tim-confirmed; ends and corners moved to BUG-028, arrow style BUG-029
1. **BUG-023** | ✅ Built 2026-05-19. Implemented in three | **6 superseded** **(status line wrong)** | mechanics Tim-confirmed 20 May; UX issues moved to BUG-030 to BUG-034
1. **BUG-024** | ✅ Built 2026-05-19. 78 grade tests | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-025** | IN PROGRESS — coded 2026-05-20, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-026** | IN PROGRESS — coded 2026-05-20 (transitive | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-027** | IN PROGRESS — coded 2026-05-20, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-028** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-029** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-030** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-031** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-032** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-033** | IN PROGRESS — coded 2026-05-20, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-034** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-035** | IN PROGRESS — coded 2026-05-20, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-036** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-037** | IN PROGRESS — verified 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-038** | IN PROGRESS — coded 2026-05-20 (Batch | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-040** | RETIRED FROM CDWT — 2026-09-13. Tim: | **6 superseded** | status says RETIRED
1. **BUG-041** | IN PROGRESS — coded 2026-05-21, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-042** | IN PROGRESS — coded 2026-05-21, awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-049** | OPEN — to be fixed in | **1 OPEN, no fix** | v2-era settings window crash; no fix or later test found
1. **BUG-050** | FIXED 2026-06-09 — awaiting Tim's AutoCAD | **3 installed, not yet tested** **(status line wrong)** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-051** | FIXED — 2026-06-15. Coded, NUnit tests | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-052** | IN PROGRESS — code + tests | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-053** | IN PROGRESS — DEPLOYED v2.1.11 (2026-06-24) | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-054** | OPEN — reported 2026-06-24, parked pending | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-056** | OPEN (Tim handling outside the parallel | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-057** | OPEN (Tim handling outside the parallel | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-058** | IN PROGRESS — fix coded 2026-07-03 | **3 installed, not yet tested** | fix d77f8d2b (2026-07-03, "fix(import): BUG-058 registered IO/OF pits purged before save + BUG-06") on rel-20261022m; no robot or Codex result recorded
1. **BUG-059** | IN PROGRESS — round-4 fix coded | **3 installed, not yet tested** | fix d48f8d5b (2026-07-03, "fix(import): round 4 — pipe accumulation across re-imports + single-ru") on rel-20261022m; no robot or Codex result recorded
1. **BUG-060** | IN PROGRESS — fix coded 2026-07-03 | **3 installed, not yet tested** | fix d77f8d2b (2026-07-03, "fix(import): BUG-058 registered IO/OF pits purged before save + BUG-06") on rel-20261022m; no robot or Codex result recorded
1. **BUG-061** | OPEN — re-evaluate after BUG-059 lands. | **1 OPEN, no fix** | no fix; Codex W25 saw 53 vs 45 pipes (BUG-436), Codex W29 did not reproduce it (BUG-440)
1. **BUG-062** | OPEN. | **3 installed, not yet tested** **(status line wrong)** | fix 61eff37e (2026-09-29, "Fix BUG-062: imported pits use the real source block's rotation, CNTR ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-063** | OPEN — design item, needs Tim | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-064** | OPEN. | **3 installed, not yet tested** **(status line wrong)** | fix f42798c6 (2026-09-29, "Fix BUG-064: Propose fixes for all always reports a plain grouped resu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-065** | OPEN. | **3 installed, not yet tested** **(status line wrong)** | fix b42766ab (2026-09-29, "Fix BUG-065: imported pipes stop on the pit outline using CD's one out") on rel-20261022m; no robot or Codex result recorded
1. **BUG-066** | OPEN — re-evaluate after BUG-059. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-067** | OPEN. | **3 installed, not yet tested** **(status line wrong)** | fix 0a79865a (2026-09-29, "Fix BUG-067: Pit Schedule FROM column never silently blank or guessed") on rel-20261022m; no robot or Codex result recorded
1. **BUG-068** | OPEN — ruling received, design/build pending. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-069** | OPEN — filed from screenshots; investigate | **2 built, not installed** | PR #369 is an open draft, not on rel-20261022m
1. **BUG-070** | IN PROGRESS (2026-07-03) — coded, 96/96 | **3 installed, not yet tested** | fix 509dc431 (2026-07-04, "docs: home AutoCAD-2026 deploy + test handoff for BUG-070..078 batch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-071** | IN PROGRESS (2026-07-03) — coded (SizeToContent="Height" | **3 installed, not yet tested** | fix 509dc431 (2026-07-04, "docs: home AutoCAD-2026 deploy + test handoff for BUG-070..078 batch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-072** | IN PROGRESS (2026-07-03) — glitch fix | **3 installed, not yet tested** | fix 509dc431 (2026-07-04, "docs: home AutoCAD-2026 deploy + test handoff for BUG-070..078 batch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-073** | IN PROGRESS (2026-07-03) — CODED, 28/28 | **3 installed, not yet tested** | fix 509dc431 (2026-07-04, "docs: home AutoCAD-2026 deploy + test handoff for BUG-070..078 batch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-074** | IN PROGRESS (2026-07-03) — CODED (pure | **3 installed, not yet tested** | batch commit "CD smartify + drafting-quality batch (BUG-070..078)" 4 Jul, carried into Civil 3.0.70
1. **BUG-075** | IN PROGRESS (2026-07-03) — CODED, 71/71 | **3 installed, not yet tested** | fix 509dc431 (2026-07-04, "docs: home AutoCAD-2026 deploy + test handoff for BUG-070..078 batch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-076** | OPEN (2026-07-03) — building alongside/after BUG-075. | **3 installed, not yet tested** **(status line wrong)** | batch commit for BUG-070..078 (4 Jul) on rel-20261022m; entry still says OPEN "building"
1. **BUG-077** | IN PROGRESS (2026-07-03) — CODED incl. | **3 installed, not yet tested** | fix 509dc431 (2026-07-04, "docs: home AutoCAD-2026 deploy + test handoff for BUG-070..078 batch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-078** | IN PROGRESS (2026-07-03) — CODED, root | **3 installed, not yet tested** | fix 509dc431 (2026-07-04, "docs: home AutoCAD-2026 deploy + test handoff for BUG-070..078 batch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-079** | FIXED IN CODE — latest is | **3 installed, not yet tested** | fix c940e457 (2026-09-29, "Land BUG-079 FALL symbol rounds 1-8: FALL SYMBOL 2, arrow follows drag") on rel-20261022m; no robot or Codex result recorded
1. **BUG-080** | OPEN — deliberately deferred, awaiting Tim's | **1 OPEN, no fix** | waits for Tim's AS/NZS values (engineering)
1. **BUG-082** | FIXED — 2026-07-27. No AutoCAD test | **5 FIXED** | status line: FIXED — 2026-07-27. No AutoCAD test is required. Previously orphaned
1. **BUG-083** | FIXED IN CODE — 2026-07-27. Awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-084** | FIXED IN CODE — 2026-07-27. Awaiting | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-085** | IN PROGRESS — source correction verified; | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-086** | IN PROGRESS — source correction verified; | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-087** | FIXED — 2026-08-14. Tim confirmed the | **5 FIXED** | status line: FIXED — 2026-08-14. Tim confirmed the live 1.0.72 result in AutoCAD: HATCH WORKS HOWEVER.
1. **BUG-088** | IN PROGRESS — source correction verified; | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-089** | IN PROGRESS — exact AutoCAD failure | **1 OPEN, no fix** | failed in AutoCAD 20 Aug on bd517ef; no later fix commit found on rel-20261022s2
1. **BUG-090** | SOURCE COMPLETE — exact combined candidate | **4 installed, FAILS in AutoCAD** **(status line wrong)** | source fix carried in; Codex V5-02 (22 Oct, Manager 1.1.68) DIFFERENT SURE: About opens but the AutoCAD row is clipped and Runtime lines hidden
1. **BUG-091** | IN PROGRESS — Tim explicitly approved | **1 OPEN, no fix** | repair approved 25 Aug; no fix commit found on rel-20261022m
1. **BUG-092** | IN PROGRESS — Tim approved the | **1 OPEN, no fix** | repair approved 25 Aug; no fix commit found on rel-20261022m
1. **BUG-093** | OPEN — decisive runtime evidence captured. | **1 OPEN, no fix** | only the #655 tidy-up is installed; the grip repair itself is not built
1. **BUG-094** | IN PROGRESS — Tim authorised larger | **3 installed, not yet tested** | fix code from before the monorepo (May to Jul), carried into today's builds; never tested by robot or Codex
1. **BUG-095** | OPEN — engineering calibration discrepancy, baseline-reproduced. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-096** | LOCALLY CORRECTED 2026-09-08 at 3ccb9e59 — | **3 installed, not yet tested** | test-inventory item, corrected locally 8 Sep; no AutoCAD behaviour
1. **BUG-097** | LOCALLY CORRECTED 2026-09-08 at 0233ff05 — | **3 installed, not yet tested** | command-inventory item, corrected locally 8 Sep; no AutoCAD behaviour
1. **BUG-098** | OPEN — logged 2026-09-14; not fixed. | **1 OPEN, no fix** | commits only mention it; diagnosis not done
1. **BUG-099** | OPEN — reported 2026-09-14 on the | **1 OPEN, no fix** | commits only mention it; no fix found
1. **BUG-100** | typed A CONFIRMED by Tim 2026-09-14 | **5 FIXED** **(status line wrong)** | typed A Tim-confirmed 14 Sep on b312bf0f; the doubled list is BUG-101
1. **BUG-101** | FIXED IN SOURCE — 2026-09-14 (REGRESSION_LOG | **3 installed, not yet tested** | fixed in source 14 Sep, carried into today's builds; never tested by robot or Codex
1. **BUG-102** | FIXED IN SOURCE — 2026-09-14 round | **3 installed, not yet tested** | fixed in source 14 Sep, carried into today's builds; never tested by robot or Codex
1. **BUG-103** | FIXED IN SOURCE — 2026-09-14 (MLeader | **3 installed, not yet tested** | fixed in source 14 Sep, carried into today's builds; never tested by robot or Codex
1. **BUG-104** | FIXED IN SOURCE — 2026-09-14: [CE | **3 installed, not yet tested** | fixed in source 14 Sep, carried into today's builds; never tested by robot or Codex
1. **BUG-105** | FIXED IN SOURCE — 2026-09-14 evening | **3 installed, not yet tested** | fixed in source 14 Sep, carried into today's builds; never tested by robot or Codex
1. **BUG-106** | FIXED IN SOURCE — 2026-09-14 evening. | **3 installed, not yet tested** | fixed in source 14 Sep, carried into today's builds; never tested by robot or Codex
1. **BUG-127** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-128** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-129** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-130** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-131** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-132** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-133** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-134** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-135** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-136** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-137** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-138** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-139** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-140** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-141** | FIXED (Codex-accepted, both halves, Civil 3.0.65, | **5 FIXED** | status line: FIXED (Codex-accepted, both halves, Civil 3.0.65, 20 Oct 2026): Drawing Border half on 3.0
1. **BUG-142** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-143** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-144** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-145** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-146** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-147** | FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG | **3 installed, not yet tested** | R2/R3/R4 fix batch (15 Sep) on rel-20261022m; never tested by robot or Codex since
1. **BUG-158** | OPEN | **3 installed, not yet tested** **(status line wrong)** | PR #347 "Fix BUG-158: CDCALC warns instead of silently dropping the council sheet" merged, on rel-20261022m
1. **BUG-160** | ON HOLD (28 Sep ~20:10) - | **3 installed, not yet tested** **(status line wrong)** | part 1 PR #354 and part 2 commits on rel-20261022m (29 Sep); status still says ON HOLD
1. **BUG-161** | FIXED — 2026-09-23 (PR #87 merged, | **5 FIXED** | release-process item, FIXED 23 Sep (PR #87), nothing to test in AutoCAD
1. **BUG-162** | FIXED — 2026-09-23 (test only: PR | **5 FIXED** | test-only item, FIXED 23 Sep (PR #93)
1. **BUG-163** | NOT REPRODUCED. Tim-tested 24 Sep 2026 | **1 OPEN, no fix** | not reproduced (Tim-tested 24 Sep); no fix aimed at it
1. **BUG-164** | IN PROGRESS — installed 23 Sep | **5 FIXED** **(status line wrong)** | Codex pass 17 B5 PASS (29 Sep, Civil 3.0.12) recorded in the entry as Codex-accepted; status still says waiting for Tim. Watch BUG-224
1. **BUG-165** | IN PROGRESS — fix merged 23 | **3 installed, not yet tested** **(status line wrong)** | PR #92 merged 23 Sep and carried into Manager 1.1.70; status still says not installed
1. **BUG-166** | IN PROGRESS — fix merged 23 | **3 installed, not yet tested** **(status line wrong)** | fix e4d690a5 (2026-10-17, "Double-click opens the Edit window for pit labels: switch ON (Tim G2),") on rel-20261022m; no robot or Codex result recorded
1. **BUG-167** | OPEN. It must be fixed or | **3 installed, not yet tested** | fix d6bea373 (2026-09-29, "Fix BUG-167: replace hanging Compress-Archive with ZipFile.CreateFromD") on rel-20261022m; no robot or Codex result recorded
1. **BUG-168** | FIXED for CDGRIPDIAG — Tim confirmed | **5 FIXED** | CDGRIPDIAG Tim-confirmed 24 Sep; other prompts not each clicked; 2024 check open
1. **BUG-169** | IN PROGRESS — CODE COMPLETE, MERGED, | **5 FIXED** **(status line wrong)** | Codex pass 18 (30 Sep, Structural 1.0.86) "mostly PASSED (Codex-accepted)" recorded in the entry; status still IN PROGRESS; see BUG-215
1. **BUG-170** | IN PROGRESS — the fix is | **3 installed, not yet tested** | fix 4465e22d (2026-09-24, "Fix BUG-170 What's New readability and release claims") on rel-20261022m; no robot or Codex result recorded
1. **BUG-171** | IN PROGRESS — round 1 (PR | **3 installed, not yet tested** | round 2 commit (24 Sep) on rel-20261022m after the Codex pass 9 FAIL on round 1; no test since
1. **BUG-172** | IN PROGRESS — 28 Sep 2026, | **3 installed, not yet tested** | fix bbe75e70 (2026-09-28, "BUG-172: record the full Civil suite result in REGRESSION_LOG.md") on rel-20261022m; no robot or Codex result recorded
1. **BUG-173** | IN PROGRESS for native acceptance. Pit | **3 installed, not yet tested** | fix aa7dc42d (2026-09-24, "BUG-173 pit preview: wire the picked point and the pending edit into t") on rel-20261022m; no robot or Codex result recorded
1. **BUG-174** | IN PROGRESS — built, MERGED to | **3 installed, not yet tested** **(status line wrong)** | PR #177 merged 24 Sep, on rel-20261022m; status still says not installed
1. **BUG-175** | IN PROGRESS — built, MERGED to | **3 installed, not yet tested** **(status line wrong)** | PR #179 merged 24 Sep, on rel-20261022m; status still says not installed
1. **BUG-176** | OPEN - diagnostics only in draft | **3 installed, not yet tested** **(status line wrong)** | fix PRs #346 and #656 on rel-20261022m; Codex pass 18 BLOCKED (30 Sep), not a FAIL
1. **BUG-177** | IN PROGRESS (27 Sep: CDPIPEOBJ hidden | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-178** | FIXED — 2026-09-27 (Codex-accepted, pass 13 | **5 FIXED** | status line: FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_
1. **BUG-179** | FIXED — 2026-09-27 (Codex-accepted, pass 13 | **5 FIXED** | status line: FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_
1. **BUG-180** | OPEN (fix queued) | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fix 947a00c2 (PR #296) installed; Codex narrow PASS recorded for a single selected pipe; the Home-then-shift-pick case NOT TESTED twice
1. **BUG-181** | FIXED — 2026-09-27 (Codex-accepted, pass 13 | **5 FIXED** | status line: FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_
1. **BUG-182** | FIXED — 2026-09-27 (Codex-accepted, pass 13 | **5 FIXED** | status line: FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_
1. **BUG-183** | FIXED — 2026-09-27 (Codex-accepted, pass 13 | **5 FIXED** | status line: FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_
1. **BUG-184** | FIXED — 2026-09-27 (Codex-accepted, pass 13 | **5 FIXED** | status line: FIXED — 2026-09-27 (Codex-accepted, pass 13 on 3.0.6 / 1.0.77; report C:\Lisp Files\_TEST_
1. **BUG-185** | IN PROGRESS (fix built 27 Sep: | **3 installed, not yet tested** | fix bcaf4506 (2026-09-27, "Structural: unblock the test host, all-lanes compile, wording fix, BUG") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-186** | IN PROGRESS (28 Sep 2026: found | **3 installed, not yet tested** | reopened by Codex pass 17 FAIL; second fix 677dd6a5 (29 Sep) on rel-20261022m; no test since
1. **BUG-187** | IN PROGRESS (28 Sep 2026: found | **3 installed, not yet tested** | fix 223c49f8 (2026-09-28, "BUG-186/187: verify already-fixed root causes, add behavioral test cov") on rel-20261022m; no robot or Codex result recorded
1. **BUG-188** | IN PROGRESS - fixed and merged | **3 installed, not yet tested** | fix 33593742 (2026-09-28, "BUG-188: CE Blocks now attaches real attribute tags before insert/expl") on rel-20261022m; no robot or Codex result recorded
1. **BUG-189** | IN PROGRESS (28 Sep evening) - | **5 FIXED** **(status line wrong)** | Tim's word 29 Sep ("its working way faster") and Codex pass 18 timing recorded as accepted; status still IN PROGRESS
1. **BUG-190** | IN PROGRESS (28 Sep ~22:00) - | **5 FIXED** **(status line wrong)** | Codex pass 17 Q4 PASS (29 Sep) recorded in the entry as Codex-accepted; status still IN PROGRESS
1. **BUG-191** | IN PROGRESS (28 Sep ~23:00) - | **3 installed, not yet tested** **(status line wrong)** | fix b90d7eb1 (2026-09-29, "Version: Civil 3.0.13 / Manager 1.1.13 (BUG-189 speed round4, BUG-191 ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-192** | OPEN (reproduce cleanly first). | **6 superseded** **(status line wrong)** | Codex pass 18 still failing on 3.0.15; carried on as the BUG-256 family, now BUG-558 and BUG-861
1. **BUG-193** | IN PROGRESS (29 Sep ~05:30) - | **5 FIXED** **(status line wrong)** | Codex pass 18 PASS (30 Sep) for an ordinary pit, recorded as Codex-accepted for that scope; the P6 900 x 900 case untested
1. **BUG-194** | IN PROGRESS (29 Sep ~13:30) - | **3 installed, not yet tested** **(status line wrong)** | fix 4f959f0f (2026-09-29, "Version: Civil 3.0.14 / Manager 1.1.14 (BUG-194 pipe tab ownership, PE") on rel-20261022m; no robot or Codex result recorded
1. **BUG-195** | (no status line) | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | one entry covers BUG-195 to BUG-201; fixes #387/#388 installed; Codex pass 18 PARTLY PASSED (30 Sep)
1. **BUG-202** | OPEN - investigating (mostly environment; CE | **1 OPEN, no fix** | investigating; mostly environment (split into BUG-203, BUG-204)
1. **BUG-203** | OPEN (29 Sep 20:30) - built, | **3 installed, not yet tested** **(status line wrong)** | fix f498b772 (2026-09-29, "BUG-203 Opus review fixes: whole-record-empty save gate, every list co") on rel-20261022m; no robot or Codex result recorded
1. **BUG-204** | OPEN (29 Sep 23:10) - built, | **3 installed, not yet tested** **(status line wrong)** | fix 4e88c6e5 (2026-09-29, "Fix BUG-204: Structural settings file no longer grows; repeated Excel ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-205** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 5b45f760 (2026-09-30, "Fix BUG-205: Use level direction no longer makes an uphill pipe betwee") on rel-20261022m; no robot or Codex result recorded
1. **BUG-206** | OPEN (30 Sep 2026, found by | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-207** | FIXED — 15 Oct 2026, Codex-accepted | **5 FIXED** | status says Codex-accepted 15 Oct for "Structural 1.0.116" but the bug is the Civil Pit Schedule (14 Oct partial pass on Civil 3.0.49): version in the status line is wrong
1. **BUG-208** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 82abe627 (2026-09-30, "BUG-208 round 5: a reconnected or moved pipe keeps its upstream end") on rel-20261022m; no robot or Codex result recorded
1. **BUG-209** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 17b88211 (2026-09-30, "Fix BUG-209: CDCATCHMENT area converted from drawing units to m2 via I") on rel-20261022m; no robot or Codex result recorded
1. **BUG-210** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 06aaf868 (2026-09-30, "BUG-210: a pit COPYed onto an erased pit's junction links to the touch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-211** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix e03fafb3 (2026-09-30, "BUG-211/218 review fixes: clear every erased support on each beam, cat") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-212** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 6e2aeda4 (2026-09-30, "BUG-212 confirm-2: CDSPINEUPGRADE repair text says "and choose Apply"") on rel-20261022m; no robot or Codex result recorded
1. **BUG-213** | OPEN (30 Sep 2026, found by | **1 OPEN, no fix** | no fix; Codex FAIL 14 Oct on Civil 3.0.49 (same dead end)
1. **BUG-214** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | Codex sweep C1 FAIL (30 Sep) came before the Opus follow-up fix (30 Sep) on rel-20261022m; no re-test since
1. **BUG-215** | OPEN (30 Sep 2026, found by | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | PR #418 in Structural since 1.0.114; native confirmation recorded 15 Oct on 1.0.116; not marked Codex-accepted
1. **BUG-216** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix f85c1f9e (2026-09-30, "Fix BUG-216: CDFALLSUGGEST accepts Enter at the Next level question") on rel-20261022m; no robot or Codex result recorded
1. **BUG-217** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 3ed1def2 (2026-09-30, "BUG-217: a perimeter drain draws its own PD tag on the plan and its pr") on rel-20261022m; no robot or Codex result recorded
1. **BUG-218** | OPEN (30 Sep 2026, found by | **5 FIXED** **(status line wrong)** | Codex real-AutoCAD narrow PASS 14 Oct on Structural 1.0.116 recorded in the entry; status still OPEN
1. **BUG-219** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | Codex sweep C1 FAIL (30 Sep) came before the fix (2 Oct) on rel-20261022m; no re-test since
1. **BUG-220** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | Codex sweep C1 FAIL (30 Sep) came before PR #465 (in Structural since 1.0.114); no re-test since
1. **BUG-221** | OPEN (30 Sep 2026, found by | **5 FIXED** **(status line wrong)** | fix commit 18 Oct; Codex look L3-01a/b PASS SURE 19 Oct on Manager 1.1.56; status still OPEN
1. **BUG-222** | OPEN (30 Sep 2026, found by | **1 OPEN, no fix** | no fix; Codex re-test FAIL 14 Oct on Manager 1.1.49
1. **BUG-223** | OPEN (30 Sep ~08:05) - filed | **3 installed, not yet tested** **(status line wrong)** | fix 0bd0502a (2026-09-30, "BUG-223 Opus confirm: typed-by-hand mark moves only when the boxes wer") on rel-20261022m; no robot or Codex result recorded
1. **BUG-224** | OPEN (30 Sep 2026, found by | **1 OPEN, no fix** | cause unknown, not reproduced; PR #753 is a test only
1. **BUG-225** | OPEN (30 Sep 2026, found by | **1 OPEN, no fix** | no fix found
1. **BUG-226** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 30815f1c (2026-10-04, "Merge #624 (discipline hover, BUG-226) @ 511e9b20 into claude/rel-2026") on rel-20261022m; no robot or Codex result recorded
1. **BUG-227** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix f06eb666 (2026-10-04, "Merge #625 (Settings hover, BUG-227) @ 8520fa12 into claude/rel-202610") on rel-20261022m; no robot or Codex result recorded
1. **BUG-228** | OPEN (30 Sep 2026, found by | **3 installed, not yet tested** **(status line wrong)** | fix 27578a2e (2026-10-04, "Merge #622 (CDDIAG words, BUG-228) @ 222232ef into claude/rel-20261015") on rel-20261022m; no robot or Codex result recorded
1. **BUG-229** | OPEN (30 Sep 2026, found by | **1 OPEN, no fix** | observation, no fix
1. **BUG-230** | OPEN (30 Sep ~08:50) - after | **3 installed, not yet tested** **(status line wrong)** | fix af8b4fa9 (2026-09-30, "BUG-230 Opus confirm: CDCATCHMENT area uses the exact-divisor conversi") on rel-20261022m; no robot or Codex result recorded
1. **BUG-231** | OPEN (30 Sep ~08:50) - carparked; | **3 installed, not yet tested** **(status line wrong)** | fix 59019337 (2026-10-04, "Merge #636 (BUG-231: shutdown no longer writes CE's record into a draw") on rel-20261022m; no robot or Codex result recorded
1. **BUG-232** | OPEN (30 Sep ~09:00) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 7a906c50 (2026-09-30, "BUG-232 review fixes: full refresh names each skipped cell, failed REF") on rel-20261022m; no robot or Codex result recorded
1. **BUG-233** | OPEN (30 Sep ~09:10) - lane | **3 installed, not yet tested** **(status line wrong)** | fix cd18a9eb (2026-09-30, "BUG-233 confirm fixes: engineer-confirmed wording with no document, "T") on rel-20261022m; no robot or Codex result recorded
1. **BUG-234** | OPEN (30 Sep ~10:10) - lane | **3 installed, not yet tested** **(status line wrong)** | fix ea8d9933 (2026-10-04, "Merge #645 (BUG-234: a flat-levelled pipe moved or gripped onto other ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-235** | OPEN (30 Sep ~10:20) - carparked | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-236** | OPEN (30 Sep ~10:20) - carparked. | **3 installed, not yet tested** **(status line wrong)** | fix d2c90661 (2026-09-30, "BUG-236 confirm fix: one plain line when a drain copy is not a proven ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-237** | OPEN (30 Sep ~10:20) - carparked. | **3 installed, not yet tested** **(status line wrong)** | fix 05028608 (2026-09-30, "BUG-237 review fixes: an end moved off its column stays Unresolved aft") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-238** | WONT FIX — not a bug | **6 superseded** | WONT FIX 30 Sep: read from the Claude app's private registry copy; BUG-240 is the real profile
1. **BUG-239** | OPEN (30 Sep ~10:35) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 51273223 (2026-10-04, "Merge #629 (BUG-239: council rule sources in words) at 2d420688 into t") on rel-20261022m; no robot or Codex result recorded
1. **BUG-240** | OPEN - (2) log files moved; | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-242** | OPEN (30 Sep ~10:55) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 49d26043 (2026-10-04, "Merge #635 (BUG-242: out-of-date raingarden area) at 1374aade into the") on rel-20261022m; no robot or Codex result recorded
1. **BUG-243** | OPEN (30 Sep ~10:55) - lane | **3 installed, not yet tested** **(status line wrong)** | fix af402318 (2026-10-04, "Merge #633 (BUG-243 overlay label size) @ 01bd5b91 into claude/rel-202") on rel-20261022m; no robot or Codex result recorded
1. **BUG-244** | OPEN (30 Sep ~11:10) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 60581e26 (2026-10-04, "Merge #654 (BUG-244: automatic relink keeps an open-end pipe running d") on rel-20261022m; no robot or Codex result recorded
1. **BUG-245** | OPEN (30 Sep ~11:10) - lane | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-246** | OPEN (30 Sep ~11:25) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 2175f147 (2026-10-08, "Fix BUG-246 (Opus #658 LOW 1): ticking Xref sources clears the drawn-c") on rel-20261022m; no robot or Codex result recorded
1. **BUG-247** | OPEN (30 Sep ~11:55) - before | **3 installed, not yet tested** | fix e8dd6631 (2026-10-04, "BUG-318 item 3 / BUG-247 (tests only): the two Manager release-payload") on rel-20261022m; no robot or Codex result recorded
1. **BUG-248** | OPEN (30 Sep ~12:20) - lane | **3 installed, not yet tested** **(status line wrong)** | fix PR #426 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-249** | OPEN (30 Sep ~12:45) - needs | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-250** | OPEN (30 Sep ~12:50) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 73229f5e (2026-10-01, "BUG-250: apply review lane confirm of #466 (13:32) - a U no longer wip") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-251** | OPEN (30 Sep ~14:50) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 761e80c2 (2026-10-08, "BUG-251: Kingston commercial tests run alone (they edit the shared Kin") on rel-20261022m; no robot or Codex result recorded
1. **BUG-252** | OPEN (30 Sep ~15:50) - lane | **3 installed, not yet tested** **(status line wrong)** | fix e7ca5ead (2026-10-04, "Merge #632 (BUG-252 Manning's n in whole words) @ 65a842de into claude") on rel-20261022m; no robot or Codex result recorded
1. **BUG-253** | OPEN (30 Sep ~16:05) - lane | **3 installed, not yet tested** **(status line wrong)** | fix 4d0b8b18 (2026-10-04, "Merge #648 (BUG-253: one pipe batch preflight) at 7e756b07 into the C-") on rel-20261022m; no robot or Codex result recorded
1. **BUG-254** | OPEN (30 Sep ~19:50) - verify | **3 installed, not yet tested** **(status line wrong)** | fix d627e675 (2026-10-01, "Merge #469 (BUG-254 + BUG-278) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-255** | OPEN (30 Sep ~19:50) - after | **3 installed, not yet tested** **(status line wrong)** | fix 688da9de (2026-10-01, "Merge #470 (BUG-255 + BUG-271) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-256** | OPEN - the top blocker (1 | **6 superseded** **(status line wrong)** | general REDO fixed (Codex W35 U/REDO passes, see BUG-445); residual cases tracked as BUG-558 and BUG-861
1. **BUG-257** | OPEN (1 Oct 04:20) | **3 installed, not yet tested** **(status line wrong)** | fix ae33d561 (2026-10-01, "Train C-2 final: merge PR #442 BUG-257 (claude/bug257-close-cancel @ 0") on rel-20261022m; no robot or Codex result recorded
1. **BUG-258** | OPEN (1 Oct 04:20) - the | **3 installed, not yet tested** **(status line wrong)** | fix f166b235 (2026-10-01, "Train C-2 final: merge PR #443 BUG-258 (claude/bug258-pd-oops @ 0f0feb") on rel-20261022m; no robot or Codex result recorded
1. **BUG-259** | OPEN (1 Oct 04:20) - check | **3 installed, not yet tested** **(status line wrong)** | fix 2e1690c0 (2026-10-01, "Merge #448 (BUG-259 confirm outlet) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-260** | OPEN (1 Oct 04:20) - diagnose | **3 installed, not yet tested** | fix c2008af9 (2026-10-01, "Train C-3: envelope-width guard counts ArrowPlacementForSave too (BUG-") on rel-20261022m; no robot or Codex result recorded
1. **BUG-261** | OPEN (1 Oct 04:20) | **3 installed, not yet tested** **(status line wrong)** | fix e9b4cd85 (2026-10-01, "Train C-2 final: merge PR #444 BUG-261/260 (claude/bug261-direction @ ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-262** | OPEN (1 Oct 04:20) | **3 installed, not yet tested** **(status line wrong)** | fix bbec3912 (2026-10-01, "Merge #454 (BUG-260/262) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-263** | OPEN (1 Oct 04:20) | **3 installed, not yet tested** **(status line wrong)** | fix 686c69c3 (2026-10-01, "BUG-263: Opus review of #446 findings 1-4 (true source wording, each a") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-264** | OPEN (1 Oct 04:20) - Codex | **3 installed, not yet tested** **(status line wrong)** | fix 0b9c3300 (2026-10-01, "BUG-264: apply Opus review of #456 (split behind a switch, screen-awar") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-265** | OPEN (1 Oct 04:20) | **2 built, not installed** | fix commit only on the Structural line; the Civil-side PR #445 is not merged
1. **BUG-266** | OPEN (1 Oct 04:20) - measure | **3 installed, not yet tested** **(status line wrong)** | fix 15b2e00d (2026-10-01, "Merge #450 (BUG-266 far copy) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-267** | OPEN (1 Oct 05:00) - measure | **3 installed, not yet tested** **(status line wrong)** | fix 3a86dc5f (2026-10-01, "Merge #460 (BUG-267/268) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-268** | OPEN (1 Oct 05:00) | **3 installed, not yet tested** **(status line wrong)** | fix 3a86dc5f (2026-10-01, "Merge #460 (BUG-267/268) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-269** | OPEN (1 Oct 09:40) | **3 installed, not yet tested** **(status line wrong)** | fix b7fc3dc8 (2026-10-01, "Merge #458 (BUG-269 array cleanup) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-270** | IN PROGRESS (1 Oct 09:50): draft | **3 installed, not yet tested** **(status line wrong)** | fix 95c3f212 (2026-10-01, "Merge #453 (BUG-270 reach units) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-271** | OPEN (1 Oct 09:50) | **3 installed, not yet tested** **(status line wrong)** | fix 688da9de (2026-10-01, "Merge #470 (BUG-255 + BUG-271) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-272** | OPEN (1 Oct 10:25), being built | **3 installed, not yet tested** | fix a7833986 (2026-10-01, "BUG-272: apply Opus review of #455 (one guard, also catches WriteTo(wr") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-273** | OPEN (1 Oct 12:00). Not a | **3 installed, not yet tested** **(status line wrong)** | fix 9dda7272 (2026-10-01, "BUG-273: apply review lane confirm of #467 (13:32) - name the real job") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-274** | OPEN (1 Oct 12:40). | **3 installed, not yet tested** **(status line wrong)** | fix cb17de15 (2026-10-01, "BUG-256 Structural review fixes + BUG-274: re-arm after the next comma") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-275** | OPEN (1 Oct 11:55) | **3 installed, not yet tested** **(status line wrong)** | fix f57033d6 (2026-10-03, "BUG-275 on S-6: drop the footing-lookup guard test (S-3 #480 changed t") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-276** | OPEN (1 Oct 11:50) - fix | **3 installed, not yet tested** | fix 1c86ac7d (2026-10-01, "BUG-276: apply Opus confirm of #430 (13:53) - Assumed, Tim to confirm;") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-277** | OPEN (1 Oct 11:50) | **3 installed, not yet tested** **(status line wrong)** | fix 060fbd6c (2026-10-01, "BUG-277 #440: apply review lane confirm (16:33) - a schedule on a lock") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-278** | OPEN (1 Oct 12:15) | **3 installed, not yet tested** **(status line wrong)** | fix d627e675 (2026-10-01, "Merge #469 (BUG-254 + BUG-278) into rel-20261002b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-279** | OPEN (filed 1 Oct about 12:10 | **3 installed, not yet tested** **(status line wrong)** | fix b9b30a46 (2026-10-01, "BUG-279 item 0: footings follow AutoCAD's own grips again in AutoCAD 2") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-280** | OPEN (1 Oct 12:25) | **1 OPEN, no fix** | convergence task; no fix
1. **BUG-281** | OPEN (1 Oct 13:00) | **3 installed, not yet tested** **(status line wrong)** | fix 337b56ce (2026-10-01, "C-5: mixed-units warning, metre grade strip, downpipe radius in mm, ru") on rel-20261022m; no robot or Codex result recorded
1. **BUG-282** | OPEN (1 Oct 13:00) | **3 installed, not yet tested** **(status line wrong)** | fix PR #470 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-283** | OPEN (1 Oct 13:00) | **3 installed, not yet tested** **(status line wrong)** | fix PR #489 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-284** | OPEN (1 Oct 13:00) | **3 installed, not yet tested** **(status line wrong)** | fix 9ba9e0d4 (2026-10-01, "Merge #489 (C-5 locked-layer write audit BUG-284) into rel-20261004a") on rel-20261022m; no robot or Codex result recorded
1. **BUG-285** | OPEN (1 Oct 15:10) | **3 installed, not yet tested** **(status line wrong)** | fix 71980a7f (2026-10-01, "C-5: pipe OOPS, locked-pit CD, open-end rescan, atomic repair (BUG-285") on rel-20261022m; no robot or Codex result recorded
1. **BUG-286** | OPEN (1 Oct 15:10) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-287** | OPEN (1 Oct 15:10) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-288** | OPEN (1 Oct 15:10) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-289** | OPEN (1 Oct 15:10) | **3 installed, not yet tested** **(status line wrong)** | fix 8eb5b113 (2026-10-01, "C-5: refresh respects typed levels, direction-aware Design grade, repa") on rel-20261022m; no robot or Codex result recorded
1. **BUG-290** | OPEN (1 Oct 16:05) | **3 installed, not yet tested** **(status line wrong)** | fix da006db6 (2026-10-16, "Fix BUG-650: cancelling CDFW/CDSOURCE no longer blanks stored pit inve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-291** | OPEN (1 Oct 16:05) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-292** | OPEN (1 Oct 16:05) | **3 installed, not yet tested** **(status line wrong)** | fix PR #437 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-293** | OPEN (1 Oct 17:20) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-294** | OPEN (1 Oct 19:10). 2 Oct | **3 installed, not yet tested** | fix PR #483 merged on rel-20261022s2; no robot or Codex result recorded
1. **BUG-295** | OPEN (1 Oct 19:00) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-296** | OPEN (1 Oct 19:00) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-297** | OPEN (1 Oct 19:00) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-298** | OPEN (1 Oct 19:00) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-299** | OPEN (1 Oct 19:55) | **3 installed, not yet tested** **(status line wrong)** | fix 93e3f3b0 (2026-10-01, "Fix BUG-299: a Structural settings save that never finished is put bac") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-300** | OPEN (1 Oct 20:20) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-302** | OPEN (1 Oct 21:25) | **3 installed, not yet tested** **(status line wrong)** | fix 2ead5192 (2026-10-02, "Fix BUG-302 (code half): FADOPT label search reaches 1.5 m in every dr") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-303** | OPEN (1 Oct 21:25) | **3 installed, not yet tested** **(status line wrong)** | fix 2e6d5e27 (2026-10-02, "BUG-303 (ADV4 LOW 6): CSINFILL on a copied infill outline adopts the c") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-304** | OPEN (1 Oct 21:25) | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-305** | OPEN (1 Oct 22:55) | **3 installed, not yet tested** **(status line wrong)** | fix 4bb033ad (2026-10-02, "Merge claude/c6-paste-settings (3d1d630f, PR #501, BUG-305) into claud") on rel-20261022m; no robot or Codex result recorded
1. **BUG-306** | OPEN (1 Oct 22:55) | **3 installed, not yet tested** **(status line wrong)** | fix 2e12441a (2026-10-04, "Merge #638 (BUG-306: pit placing leaves CD_Settings.json alone) at 272") on rel-20261022m; no robot or Codex result recorded
1. **BUG-307** | OPEN (1 Oct 23:15) | **6 superseded** **(status line wrong)** | same failing Glen Eira back-test as BUG-095 and BUG-872 (Codex build queued under BUG-872)
1. **BUG-308** | OPEN (1 Oct 23:25). Route (a)(b) | **3 installed, not yet tested** **(status line wrong)** | found by Codex VERIFYC4C; review fixes (#497) on rel-20261022m; no re-test of these items
1. **BUG-309** | OPEN (1 Oct 23:55). | **3 installed, not yet tested** **(status line wrong)** | fix dc3329a8 (2026-10-02, "C-6 review fix 1: BUG-309 claims say what happens in a metre drawing") on rel-20261022m; no robot or Codex result recorded
1. **BUG-310** | OPEN (1 Oct 23:55). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-311** | OPEN (1 Oct 23:55). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-312** | OPEN (1 Oct 23:55). | **3 installed, not yet tested** **(status line wrong)** | fix 7a47f825 (2026-10-02, "BUG-312: plan labels held back by a locked layer are kept in the drawi") on rel-20261022m; no robot or Codex result recorded
1. **BUG-313** | OPEN (1 Oct 23:55). | **3 installed, not yet tested** **(status line wrong)** | fix d67d1806 (2026-10-02, "C-6 review fix 4: BUG-313 native comments say what is proven and what ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-314** | OPEN (2 Oct 00:30). | **3 installed, not yet tested** **(status line wrong)** | fix 2fb79996 (2026-10-02, "BUG-314 (3): footing record read open-close so REDO survives; drawing-") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-315** | OPEN (2 Oct 00:30). | **3 installed, not yet tested** **(status line wrong)** | fix d72c574a (2026-10-02, "BUG-315 (2): a new footing legend forgets the old space, so it goes wh") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-316** | OPEN (2 Oct 00:30). | **3 installed, not yet tested** **(status line wrong)** | fix c126f1df (2026-10-02, "Fix BUG-316 (2): SBEAM Place seeds a first settings write from the old") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-317** | OPEN (2 Oct 00:40). Opus CONFIRM | **3 installed, not yet tested** **(status line wrong)** | fix e1332003 (2026-10-02, "Merge claude/c6-scaled-pit-record (84ff3116, PR #502, BUG-317) into cl") on rel-20261022m; no robot or Codex result recorded
1. **BUG-318** | OPEN (2 Oct 00:40). | **3 installed, not yet tested** **(status line wrong)** | fix e8dd6631 (2026-10-04, "BUG-318 item 3 / BUG-247 (tests only): the two Manager release-payload") on rel-20261022m; no robot or Codex result recorded
1. **BUG-319** | OPEN (2 Oct 01:05). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-320** | OPEN (2 Oct 01:20). Opus review | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-321** | OPEN (2 Oct 01:50). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-322** | OPEN (2 Oct 02:20). | **3 installed, not yet tested** **(status line wrong)** | fix 4f2430e3 (2026-10-04, "BUG-322 item 2 / BUG-329 item 3: the job-record copy keeps pavement ar") on rel-20261022m; no robot or Codex result recorded
1. **BUG-323** | OPEN (2 Oct 02:20). | **3 installed, not yet tested** **(status line wrong)** | fix ee040599 (2026-10-02, "Merge claude/c6-c5-findings (209d9303, PR #507, BUG-323/324/325, inclu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-324** | OPEN (2 Oct 02:20). | **3 installed, not yet tested** **(status line wrong)** | fix ee040599 (2026-10-02, "Merge claude/c6-c5-findings (209d9303, PR #507, BUG-323/324/325, inclu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-325** | OPEN (2 Oct 02:20). | **3 installed, not yet tested** **(status line wrong)** | fix ee040599 (2026-10-02, "Merge claude/c6-c5-findings (209d9303, PR #507, BUG-323/324/325, inclu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-326** | OPEN (2 Oct 02:20). UPDATE 2 | **1 OPEN, no fix** | AutoCAD crash, Opus says about 80 percent not CE code
1. **BUG-328** | OPEN (2 Oct 02:36). Builder assigned | **3 installed, not yet tested** **(status line wrong)** | fix 0879ce46 (2026-10-02, "BUG-328 repair review fix 8: say when the grade is today's Settings va") on rel-20261022m; no robot or Codex result recorded
1. **BUG-329** | OPEN (2 Oct 02:36). | **3 installed, not yet tested** **(status line wrong)** | fix 4f2430e3 (2026-10-04, "BUG-322 item 2 / BUG-329 item 3: the job-record copy keeps pavement ar") on rel-20261022m; no robot or Codex result recorded
1. **BUG-330** | OPEN (2 Oct 03:00). Opus review | **3 installed, not yet tested** **(status line wrong)** | fix bab2dcaf (2026-10-04, "Merge #627 (BUG-330: lengths in metre drawings) at abf4fe51 into the C") on rel-20261022m; no robot or Codex result recorded
1. **BUG-331** | OPEN (2 Oct 03:15). C-6 FINALIZER | **3 installed, not yet tested** **(status line wrong)** | fix 9a7cba36 (2026-10-04, "Merge #646 (BUG-331 item 4: long-section grade uses CD's one grade rul") on rel-20261022m; no robot or Codex result recorded
1. **BUG-332** | OPEN (2 Oct 04:00). | **3 installed, not yet tested** **(status line wrong)** | fix 4a1cf7a6 (2026-10-02, "BUG-332 (3)(4)(6): old settings saves removed at start-up, CSLOADPATH ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-333** | OPEN (2 Oct 05:50). Item 1 | **3 installed, not yet tested** **(status line wrong)** | fix 09996787 (2026-10-03, "BUG-333 (5) #536: class summary says list rows are the exception (Opus") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-334** | OPEN (2 Oct 05:50). Items 1-3 | **3 installed, not yet tested** **(status line wrong)** | fix 89c5fa4d (2026-10-02, "Fix BUG-334 (5): Structural compiled-code REDO guard (Cecil hook scan ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-335** | OPEN (2 Oct 06:00). Items 1-3 | **3 installed, not yet tested** **(status line wrong)** | fix 875e2bc2 (2026-10-02, "Fix BUG-335 (8) part: stretching a raft slab edge redraws the raft's b") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-336** | OPEN (2 Oct 07:30). | **3 installed, not yet tested** **(status line wrong)** | fix b645b962 (2026-10-03, "BUG-336 (3) #525: hand-retyped split says 'labels were changed by hand") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-337** | OPEN (2 Oct 10:50). Passed to | **3 installed, not yet tested** **(status line wrong)** | fix PR #508 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-338** | OPEN (2 Oct 11:00). Whether the | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-339** | OPEN (2 Oct 11:15). Opus builder | **3 installed, not yet tested** **(status line wrong)** | fix 1edefb23 (2026-10-02, "BUG-339: Edit Pipe batch Apply fills an older drawing's Pit Schedule l") on rel-20261022m; no robot or Codex result recorded
1. **BUG-340** | OPEN (2 Oct 11:15). Items 1-6 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-341** | OPEN (2 Oct 11:30). Items 1-4 | **3 installed, not yet tested** **(status line wrong)** | fix 1bf49237 (2026-10-02, "S-6 task 5 (BUG-341): a pad adopted slightly out of square is not call") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-342** | OPEN (2 Oct 11:15). Items 1, | **3 installed, not yet tested** **(status line wrong)** | fix 0eff93d4 (2026-10-04, "Merge #567 (quiet paste catcher, BUG-342 part 1 / BUG-366, approved IN") on rel-20261022m; no robot or Codex result recorded
1. **BUG-343** | OPEN (2 Oct 11:25). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-344** | OPEN, queued for S-7. Decision recorded | **3 installed, not yet tested** **(status line wrong)** | fix 43615c9b (2026-10-02, "S-7 (BUG-344, INT-026): footing commands in a non-mm drawing convert (") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-345** | OPEN, carpark. Not fixed until Tim | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-346** | OPEN, carpark. Not fixed until Tim | **3 installed, not yet tested** **(status line wrong)** | fix e5cd643f (2026-10-03, "BUG-346 review #549 (04:38): detention MovePit heals an old copy befor") on rel-20261022m; no robot or Codex result recorded
1. **BUG-347** | OPEN (observations). Codex waits for the | **3 installed, not yet tested** **(status line wrong)** | Codex verifyC7 result record; C-8 fixes (ARRAY no longer acts as ERASE) on rel-20261022m; no re-test
1. **BUG-348** | OPEN. Not fixed until Tim confirms | **3 installed, not yet tested** **(status line wrong)** | fix commits on rel-20261022s2 (Structural 1.0.121); PR #545 open but its content landed
1. **BUG-349** | OPEN. Items 1-4 are being fixed | **3 installed, not yet tested** **(status line wrong)** | fix PR #546 merged on rel-20261022s2; no robot or Codex result recorded
1. **BUG-350** | OPEN. Items 1-6 and PR #543 | **3 installed, not yet tested** **(status line wrong)** | fix f75903f2 (2026-10-03, "BUG-350 item 9 (Opus 04:35 NOTE): move the outline summary back onto i") on rel-20261022m; no robot or Codex result recorded
1. **BUG-351** | OPEN. Opus review of #548 running | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fixes on rel-20261022m (#805 and others); Codex narrow PASS 14 Oct for one item only
1. **BUG-352** | OPEN. Codex checks (35 steps) are | **3 installed, not yet tested** **(status line wrong)** | fix 50d7d27f (2026-10-03, "BUG-352 item 3: a widened schedule column follows its mark, not its po") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-353** | OPEN. Codex checks: the six in | **3 installed, not yet tested** **(status line wrong)** | fix 7734f43b (2026-10-03, "BUG-353 item 3 / BUG-351 item 2: REGRESSION_LOG entry (item 4 drain de") on rel-20261022m; no robot or Codex result recorded
1. **BUG-354** | OPEN (LOW), nothing changed. Not fixed | **6 superseded** **(status line wrong)** | same start-up line as BUG-402 (CE_StrucPlus LISP not found)
1. **BUG-355** | OPEN (observations). Re-run S-05, S-06, S-07, | **3 installed, not yet tested** **(status line wrong)** | FEDIT outline fix (bc636eea) on rel-20261022s2; driver PASS on the other items
1. **BUG-356** | OPEN (LOW-MED). Candidate for the Team | **3 installed, not yet tested** **(status line wrong)** | fix fb57f338 (2026-10-03, "BUG-356 review 04:35: the open What's New window's crash catcher names") on rel-20261022m; no robot or Codex result recorded
1. **BUG-357** | OPEN (3 = MED to confirm). | **3 installed, not yet tested** **(status line wrong)** | fix 23a0b4a7 (2026-10-03, "BUG-357: a pit MOVE with the pipe layer locked leaves the pipes and th") on rel-20261022m; no robot or Codex result recorded
1. **BUG-358** | OPEN. Not fixed until Tim confirms | **3 installed, not yet tested** **(status line wrong)** | S-8 fix on rel-20261022s2; S-05 FAIL was before it
1. **BUG-359** | closed as 'driver' (confirmed 3 Oct | **6 superseded** | closed as a driver fault, not CE (3 Oct); the open measurement is BUG-361
1. **BUG-360** | OPEN (LOW-MED). Not fixed until Tim | **3 installed, not yet tested** **(status line wrong)** | fix 5ce92c32 (2026-10-17, "BUG-360 (Pit Schedule footer): no AutoCAD handle in the picked-pipe se") on rel-20261022m; no robot or Codex result recorded
1. **BUG-361** | investigated: driver mechanism (see BUG-359). Stays | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-362** | OPEN (LOW). Not fixed until Tim | **3 installed, not yet tested** **(status line wrong)** | fix dcfccd57 (2026-10-03, "BUG-362 LOW 2: regression log test count") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-363** | OPEN. 10 driver/Codex checks in the | **3 installed, not yet tested** **(status line wrong)** | fix 5aa59db6 (2026-10-03, "BUG-363 #561 Opus MED 1 + LOW 2: forget remembered pipe routes at U/UN") on rel-20261022m; no robot or Codex result recorded
1. **BUG-364** | OPEN (LOW wording bug). Not fixed | **3 installed, not yet tested** **(status line wrong)** | fix 55a5da59 (2026-10-03, "BUG-364 (C-10 Opus finalizer): the locked pipe layer line never shows ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-365** | OPEN. Candidates: Team build worker (Structural/Civil | **3 installed, not yet tested** **(status line wrong)** | fix 2a381332 (2026-10-03, "BUG-365 driver run 15: a blank Civil grid cell reads 'IL (Inlet): blan") on rel-20261022m; no robot or Codex result recorded
1. **BUG-366** | OPEN. Not fixed until Tim confirms | **3 installed, not yet tested** **(status line wrong)** | fix 0eff93d4 (2026-10-04, "Merge #567 (quiet paste catcher, BUG-342 part 1 / BUG-366, approved IN") on rel-20261022m; no robot or Codex result recorded
1. **BUG-367** | OPEN. Not fixed until Tim confirms | **3 installed, not yet tested** **(status line wrong)** | fix 8595a6d2 (2026-10-03, "BUG-367 (driver run 10): RBL/RBC/STR/BWT create their layers inside th") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-368** | OPEN (MED). Team build worker job | **3 installed, not yet tested** **(status line wrong)** | fix f88522e9 (2026-10-03, "BUG-368: REGRESSION_LOG test count") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-369** | OPEN (LOW). Not fixed until Tim | **3 installed, not yet tested** **(status line wrong)** | fix 70ff0847 (2026-10-03, "BUG-369/370: REGRESSION_LOG test count") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-370** | Structural 1.0.94 proofs done; LOW items | **3 installed, not yet tested** **(status line wrong)** | fix 70ff0847 (2026-10-03, "BUG-369/370: REGRESSION_LOG test count") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-371** | OPEN (LOW). Not fixed until Tim | **1 OPEN, no fix** | LOW leftovers; driver runs 12 and 13 ALL PASS on the checked items; nothing built
1. **BUG-372** | OPEN (LOW). Team build worker (Civil, | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | name half: fix 283e013f on rel-20261022m, robot run 33 PASS; Drawing Border half is BUG-141 (Codex-accepted)
1. **BUG-373** | OPEN. Not fixed until Tim confirms | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-374** | OPEN. Not accepted until Tim confirms. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-375** | OPEN (items 1 and 2 are | **3 installed, not yet tested** **(status line wrong)** | fix fac19d70 (2026-10-04, "BUG-375 item 1: register and Civil registry are one honest list") on rel-20261022m; no robot or Codex result recorded
1. **BUG-376** | OPEN. Fix to Team build/02 (read | **3 installed, not yet tested** **(status line wrong)** | fix dd307761 (2026-10-03, "BUG-376 review fixes: plan text fills only with no disagreeing CE leve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-377** | OPEN, LOW. Wording; no behaviour change. | **3 installed, not yet tested** **(status line wrong)** | fix 1a059b6d (2026-10-04, "BUG-377 follow-up: CDMA/Move arrow, CDRUNSOLVE apply result and invert") on rel-20261022m; no robot or Codex result recorded
1. **BUG-378** | OPEN, LOW until reproduced. Next driver | **3 installed, not yet tested** **(status line wrong)** | fix 32ef6d35 (2026-10-04, "Merge #602 (BUG-378 first-open pipe upgrade) @ 33c60fa5 into C-13 exte") on rel-20261022m; no robot or Codex result recorded
1. **BUG-380** | OPEN. Not accepted until Tim confirms. | **3 installed, not yet tested** **(status line wrong)** | fix e3ffe44b (2026-10-03, "BUG-380: the pipe batch write puts the drafter's running snaps back") on rel-20261022m; no robot or Codex result recorded
1. **BUG-381** | OPEN (to Team after run 52; | **3 installed, not yet tested** **(status line wrong)** | fix 7e3cf643 (2026-10-03, "Merge PR #586 (BUG-381: Structural command restore writes only what di") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-382** | OPEN, LOW wording. | **3 installed, not yet tested** **(status line wrong)** | found by driver run 18; wording sweep #597 on rel-20261022s2; no re-test
1. **BUG-383** | OPEN, LOW. Not Tim-facing yet. (BUG-381 | **3 installed, not yet tested** **(status line wrong)** | found by driver run 19; PR #593 installed; no re-test
1. **BUG-384** | OPEN, LOW wording (to a Team | **3 installed, not yet tested** **(status line wrong)** | found by driver run 20; #603/#611 wording on rel-20261022m; no re-test
1. **BUG-385** | OPEN, to Team (read-first, next round). | **3 installed, not yet tested** **(status line wrong)** | fix de7fd4ab (2026-10-04, "BUG-385 class (#667 Opus round 2): REGRESSION_LOG entry") on rel-20261022m; no robot or Codex result recorded
1. **BUG-386** | OPEN (question). | **1 OPEN, no fix** | question for Tim (Revert keeps the typed cover)
1. **BUG-387** | OPEN, to Team (read-first); the #604 | **3 installed, not yet tested** **(status line wrong)** | fix 6637535e (2026-10-05, "Merge PR #683 (BUG-387 current layer put back) into rel-20261015i") on rel-20261022m; no robot or Codex result recorded
1. **BUG-388** | OPEN. | **3 installed, not yet tested** **(status line wrong)** | found by driver run 21; prompt fix (#619/#628/#647) on rel-20261022s2; no re-test
1. **BUG-389** | OPEN (to build/03 or build/04). | **3 installed, not yet tested** **(status line wrong)** | found by driver run 22; #634 on rel-20261022m; no re-test
1. **BUG-390** | result record; W6-03 to redo as | **6 superseded** **(status line wrong)** | Codex W6 result record; findings filed under their own ids
1. **BUG-391** | OPEN (items 1-7 to the Team; | **1 OPEN, no fix** | driver run 24 result record; items 1 to 7 handed to the Team, no single fix
1. **BUG-392** | result record; FINDING A to build/02 | **2 built, not installed** | fix PR #606 (open, draft) not on the installed branch
1. **BUG-393** | OPEN (MED, pre-existing, metre jobs only). | **3 installed, not yet tested** **(status line wrong)** | fix 0f07a2ec (2026-10-05, "Merge PR #666 (BUG-393 remainder) into rel-20261015i") on rel-20261022m; no robot or Codex result recorded
1. **BUG-394** | OPEN. | **3 installed, not yet tested** **(status line wrong)** | fix 9ba5d9f6 (2026-10-05, "Merge PR #686 (11c4fd9a): BUG-394 one shared helper for AutoCAD's copy") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-395** | result record. Re-run as W9 (separate | **6 superseded** **(status line wrong)** | Codex W8 result record; re-run as W9
1. **BUG-396** | OPEN (items 2-6 to the Team; | **4 installed, FAILS in AutoCAD** **(status line wrong)** | fixes on rel-20261022m (#747 and others); Codex look L4-08 DIFFERENT SURE (19 Oct, Civil 3.0.56): Pit Schedule cell double-click opens AutoCAD MTEDIT
1. **BUG-397** | OPEN (Team build/03 r19). | **3 installed, not yet tested** **(status line wrong)** | fix PR #670, #684 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-398** | OPEN. Do NOT merge #692 into | **3 installed, not yet tested** | fix a730f2fb (2026-10-04, "Unify BUG-398 preview and issue revision/date decisions") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-399** | OPEN (observation). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-400** | OPEN (LOW, observation). UPDATE 4 Oct | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-401** | DECIDED 5 Oct (Tim, INT-059/060): New | **6 superseded** **(status line wrong)** | Tim ruled 5 Oct (INT-059/060): a blank New Pit cover after restart is right; no code change needed
1. **BUG-402** | AWAITING TIM CONFIRM (5 Oct 01:40: | **3 installed, not yet tested** **(status line wrong)** | desk edited ce_suite_startup.lsp 5 Oct with Tim's yes; no robot or Codex start-up check recorded
1. **BUG-403** | OPEN (HIGH-ish: the approved line does | **2 built, not installed** | fix PR #710 (open, draft) not on the installed branch
1. **BUG-404** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-405** | OPEN (LOW-MEDIUM privacy; Team). | **3 installed, not yet tested** **(status line wrong)** | fix 64f22192 (2026-10-07, "Merge PR #757 (BUG-405 (3): Structural usage report drawing name no lo") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-406** | OPEN (MEDIUM; Team or Codex). | **3 installed, not yet tested** **(status line wrong)** | fix PR #666 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-407** | OPEN (Team). | **3 installed, not yet tested** **(status line wrong)** | fix 5526f778 (2026-10-07, "Merge PR #738 (dd1a784b) into claude/rel-20261007s: BUG-407 CSFDNPROPO") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-408** | OPEN (observation; retest as W10b). | **3 installed, not yet tested** **(status line wrong)** | fix 631f3b3b (2026-10-08, "Merge #763 (BUG-408d window warns on lookalike pit number) @ 7a608105 ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-409** | RESTORED 5 Oct ~10:50 by the | **6 superseded** **(status line wrong)** | test incident record; Tim's file restored 5 Oct; nothing to fix in the product
1. **BUG-410** | OPEN (observations; W11b with a corrected | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-411** | OPEN (Tim's decision needed on the | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-412** | OPEN (observation; W10d with the CDRULES | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-413** | OPEN (Team; Tim's call on the | **2 built, not installed** | fix PR #745 (open, draft) not on the installed branch
1. **BUG-414** | OPEN (MEDIUM). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-415** | OPEN (LOW). | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-416** | OPEN (LOW; W14). | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | #1502 in Civil 3.0.67+; Codex V4/V6 saw 4 of 4 CE right-click runs keep REDO but the control was inconsistent (BUG-861 entry)
1. **BUG-417** | OPEN (HIGH; Team; needs Tim's ruling | **3 installed, not yet tested** **(status line wrong)** | fix 7e097226 (2026-10-08, "Merge PR #765 (BUG-417: X-Civil import skips a locked layer and says s") on rel-20261022m; no robot or Codex result recorded
1. **BUG-418** | RULED 7 Oct (INT-065, Tim: "some | **3 installed, not yet tested** **(status line wrong)** | fix 035256a7 (2026-10-08, "Merge PR #764 (BUG-418: strip layer merge respects locked layers, Xref") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-419** | OPEN (Team triage; several are R-00 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-420** | OPEN (FAIL, Team to read the | **3 installed, not yet tested** **(status line wrong)** | fix f86bfadd (2026-10-08, "Merge #766 (BUG-420 Pit Schedule window checks a typed pit number at o") on rel-20261022m; no robot or Codex result recorded
1. **BUG-421** | OPEN (Codex-tool glitch, low harm: Esc | **1 OPEN, no fix** | Codex tool glitch from brief wording; no product fix
1. **BUG-422** | OPEN (MEDIUM, wrong 'works' answer; Team | **3 installed, not yet tested** **(status line wrong)** | fix 09e1ccd1 (2026-10-08, "Merge PR #769 (BUG-422) into claude/rel-20261008e") on rel-20261022m; no robot or Codex result recorded
1. **BUG-423** | OPEN (Tim: release note + the | **3 installed, not yet tested** **(status line wrong)** | fix 032e9f44 (2026-10-08, "Merge #774 (BUG-423 LOWs: refusal says press Save; Pit Schedule footer") on rel-20261022m; no robot or Codex result recorded
1. **BUG-424** | OPEN (LOW; Team). | **3 installed, not yet tested** **(status line wrong)** | fix bd4c5363 (2026-10-08, "Merge PR #780 (BUG-424 item 5: Structural report hides a login glued t") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-425** | OPEN. Filed 8 Oct 02:59 by | **3 installed, not yet tested** **(status line wrong)** | fix d7bf5695 (2026-10-09, "Merge #811 @ 88f48907 (BUG-425 S2-006 read side, damaged office files)") on rel-20261022m; no robot or Codex result recorded
1. **BUG-426** | OPEN (MEDIUM). Filed 8 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix 93585d67 (2026-10-08, "Merge PR #786 (BUG-426) into claude/rel-20261008e") on rel-20261022m; no robot or Codex result recorded
1. **BUG-427** | OPEN (MEDIUM to confirm). Filed 8 | **3 installed, not yet tested** **(status line wrong)** | #789 on rel-20261022m; the 14 Oct Codex W61-04 PASS covered a different requirement
1. **BUG-428** | OPEN (LOW). Filed 8 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix 5beeb384 (2026-10-08, "Merge PR #787 (BUG-428: BB warns about a long brace like AB; 2700 mm l") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-429** | OPEN (LOW, design question). Filed 8 | **3 installed, not yet tested** **(status line wrong)** | fix 148860a4 (2026-10-08, "Merge PR #799 (BUG-429 start-up settings log line) at f159e83e into cl") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-430** | OPEN (LOW-MED). Filed 8 Oct by | **4 installed, FAILS in AutoCAD** **(status line wrong)** | diagnostic and switch installed (#1176/#1390/#1477); Codex look L4-01a DIFFERENT SURE 19 Oct with the switch ON: pit label opens AutoCAD's editor
1. **BUG-431** | OPEN (council rulebook: verify the 2018/2025 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-432** | OPEN (MEDIUM, advice only). Filed 8 | **3 installed, not yet tested** **(status line wrong)** | fix 14253b67 (2026-10-09, "Merge PR #820 (BUG-432 round 3: fix planner, detention, Inspector read") on rel-20261022m; no robot or Codex result recorded
1. **BUG-433** | OPEN (LOW). Filed 8 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix 3fa0dcdc (2026-10-08, "Merge PR #808 (BUG-433 follow-up delta, 9cf0f20c) into S-25 train") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-434** | OPEN (MEDIUM to confirm). Filed 8 | **3 installed, not yet tested** **(status line wrong)** | fix b664bb2c (2026-10-08, "Merge PR #810 (BUG-434 current layer comes back after C1/TS1 cancel) a") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-435** | OPEN (MEDIUM to confirm). Filed 8 | **3 installed, not yet tested** **(status line wrong)** | fix b2d8d14a (2026-10-09, "Merge #826 @ 964c25ba (BUG-435 Civil half, no edit of the main acad.cu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-436** | OPEN. Filed 8 Oct by the | **6 superseded** **(status line wrong)** | Codex W25 result record for BUG-061
1. **BUG-437** | OPEN (MEDIUM). Filed 8 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix c1c4cf81 (2026-10-09, "Merge PR #812 (BUG-437 wording, b7aaa225) into claude/rel-20261009f") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-438** | OPEN (MEDIUM). Filed 8 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix a1c25012 (2026-10-09, "Merge PR #815 (BUG-438: C1/TS1 text step 'DefaultValue is not set'; li") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-439** | OPEN (LOW). Filed 8 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix PR #798 merged on rel-20261022s2; no robot or Codex result recorded
1. **BUG-440** | OPEN (zero-length pipe = Team item | **3 installed, not yet tested** **(status line wrong)** | fix 36758ff0 (2026-10-09, "Merge PR #814 (BUG-440: import skips a zero-length pipe) into rel-2026") on rel-20261022m; no robot or Codex result recorded
1. **BUG-441** | OPEN (release notes + Team items). | **3 installed, not yet tested** **(status line wrong)** | fix PR #794, #796 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-442** | OPEN (MEDIUM to confirm). Filed 8 | **3 installed, not yet tested** **(status line wrong)** | fix 51353ad2 (2026-10-09, "Merge #816 @ 3a9f1bba (BUG-442 CE support bundle reads the real log fo") on rel-20261022m; no robot or Codex result recorded
1. **BUG-443** | OPEN (LOW). Filed 8 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix ca4450be (2026-10-09, "Merge PR #818 (BUG-443 wording, f89af2ca) into claude/rel-20261009f") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-444** | OPEN (LOW + Codex test W33). | **1 OPEN, no fix** | finalizer LOWs; nothing built
1. **BUG-445** | OPEN (#805 REDO proven in AutoCAD; | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | Codex W35 (8 Oct): the #805 marker keeps REDO; marker layer and Edit Pipe removal not yet seen
1. **BUG-446** | OPEN (MEDIUM). Filed 9 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix 800cab61 (2026-10-09, "Merge PR #823 (BUG-446: Edit Pipe Save erases the stale grade-check ma") on rel-20261022m; no robot or Codex result recorded
1. **BUG-447** | OPEN (end-matching cure = Team item). | **3 installed, not yet tested** **(status line wrong)** | fix 1a14029d (2026-10-09, "Merge PR #827 (BUG-447: X-Civil import keeps the far end of a short br") on rel-20261022m; no robot or Codex result recorded
1. **BUG-448** | W39 (9 Oct 04:13) SEEN IN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | Codex W39 (9 Oct, Structural 1.0.109) saw the C1/TS1 fix work; Esc at the number question still owed
1. **BUG-449** | W40 (9 Oct 04:42 to 05:01, | **5 FIXED** **(status line wrong)** | Codex W40 (9 Oct, Structural 1.0.109) PASS 4 FAIL 0: Enter at the text question works; wording item
1. **BUG-450** | OPEN (LOWs). Filed 9 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix edb4b28b (2026-10-09, "Merge PR #848 (BUG-450 LOW 1: C1/TS1 clicked-spot wording) @ b448275f ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-451** | OPEN (observations; W42 re-run in progress). | **1 OPEN, no fix** | Codex W41 observations; W42 re-run; no single fix
1. **BUG-452** | OPEN (LOWs). Filed 9 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix 9a7d9610 (2026-10-10, "BUG-452 item 5: every Manager trace line is scrubbed of the login and ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-453** | OPEN (wording). Filed 9 Oct by | **2 built, not installed** | fix PR #843 (open, draft) not on the installed branch
1. **BUG-454** | OPEN (FSF Enter and FPFC label | **3 installed, not yet tested** **(status line wrong)** | FSF Enter fix #846 on rel-20261022s2; no Codex re-test after the W44 FAIL
1. **BUG-455** | OPEN (start-up lines remain; #819 preview | **6 superseded** **(status line wrong)** | start-up lines: Civil half fixed under BUG-435; the remaining "; error: syntax error" line is BUG-562
1. **BUG-456** | OPEN (LOWs). Filed 9 Oct by | **3 installed, not yet tested** **(status line wrong)** | fix PR #827 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-457** | OPEN (test gaps and unwalked routes; | **3 installed, not yet tested** **(status line wrong)** | fix 6868955e (2026-10-09, "Merge #870 BUG-457 redo guard (4708690f) into claude/rel-20261009l") on rel-20261022m; no robot or Codex result recorded
1. **BUG-458** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-459** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix PR #1090 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-460** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix PR #1090 merged on rel-20261022m; no robot or Codex result recorded
1. **BUG-461** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-462** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-463** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-464** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-465** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1219 (open, draft), #1221 (open, draft), #1242 (open, draft) not on the installed branch
1. **BUG-466** | OPEN (found by reading code; not | **5 FIXED** **(status line wrong)** | Codex W57 PASS (10 Oct, Structural 1.0.113): "SEEN FIXED by Codex", PR #865 installed; status still OPEN
1. **BUG-467** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-468** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix a385ce74 (2026-10-10, "BUG-468 log: grips read the same post list") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-469** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-470** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-471** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1204 (open, draft) not on the installed branch
1. **BUG-472** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-473** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-474** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-475** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-476** | SEEN by Codex 10 Oct 00:31 | **3 installed, robot PASS, awaiting Codex** | Codex W53 PASS 3 of 3 (10 Oct); code changed since (#1226 round 10) and the remaining hole is BUG-829; robot run 39 UNPROVEN
1. **BUG-477** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-478** | OPEN (found by reading code; not | **2 built, not installed** | groundwork #1508/#1515 installed with no caller; the actual start-up decision is not wired
1. **BUG-479** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-480** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-481** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1231 (open, draft) not on the installed branch
1. **BUG-482** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-483** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-484** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1233 (open, draft) not on the installed branch
1. **BUG-485** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1232 (open, draft) not on the installed branch
1. **BUG-486** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1234 (open, draft) not on the installed branch
1. **BUG-487** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1235 (open, draft), #1236 (open, draft), #1238 (open, draft) not on the installed branch
1. **BUG-488** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-489** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-490** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-491** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1167 (open, draft) not on the installed branch
1. **BUG-492** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-493** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-494** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-495** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-496** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1024 (open, draft) not on the installed branch
1. **BUG-497** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1008 (open, draft) not on the installed branch
1. **BUG-498** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1011 (open, draft) not on the installed branch
1. **BUG-499** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1012 (open, draft) not on the installed branch
1. **BUG-500** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1024 (open, draft) not on the installed branch
1. **BUG-501** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1013 (open, draft) not on the installed branch
1. **BUG-502** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1014 (open, draft) not on the installed branch
1. **BUG-503** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1026 (open, draft), #1146 (open, draft), #1157 (open, draft) not on the installed branch
1. **BUG-504** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 8a1aec7c (2026-10-16, "Fix BUG-504: CSWINDCLASS saves nothing for a blank wind class, warns o") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-505** | OPEN (found by reading code; not | **4 installed, FAILS in AutoCAD** **(status line wrong)** | fix #1228 installed; Codex V3b-04 FAIL SURE (21 Oct, 3.0.67, no warning for INSUNITS 0) and V8-01 DIFFERENT SURE (22 Oct, 3.0.69, warning only in command history)
1. **BUG-506** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-507** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-508** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-509** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1215 (open, draft) not on the installed branch
1. **BUG-510** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-511** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1217 (open, draft) not on the installed branch
1. **BUG-512** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1229 (open, draft) not on the installed branch
1. **BUG-513** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1229 (open, draft) not on the installed branch
1. **BUG-514** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1230 (open, draft) not on the installed branch
1. **BUG-515** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1216 (open, draft) not on the installed branch
1. **BUG-516** | OPEN (found by reading code; not | **5 FIXED** **(status line wrong)** | robot runs 39 and 40 PASS and Codex V2b V2-03 PASS SURE (20 Oct, 3.0.65); the body says FIXED (Codex-accepted) but the status line still says OPEN
1. **BUG-517** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1029 (open, draft) not on the installed branch
1. **BUG-518** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 42716215 (2026-10-17, "Build BUG-524 (2.5, 2.6): Civil window titles carry the AutoCAD comman") on rel-20261022m; no robot or Codex result recorded
1. **BUG-519** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1135 (open, draft) not on the installed branch
1. **BUG-520** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix d4c9ef30 (2026-10-17, "BUG-520 part c: recovery lines name the three offered footing widths i") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-521** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 0bdbd536 (2026-10-10, "BUG-521 display half: Inspector, Civil Hub, repair checks can read the") on rel-20261022m; no robot or Codex result recorded
1. **BUG-522** | OPEN (found by reading code; not | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | #1165 in Civil 3.0.64+; robot run 40 PASS for equal copies; mismatch case UNPROVEN
1. **BUG-523** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix af6a9d14 (2026-10-17, "BUG-523 1.11 Civil half: a stopped command prints a plain sentence and") on rel-20261022m; no robot or Codex result recorded
1. **BUG-524** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 3962334d (2026-10-17, "BUG-524: the Profiles window says (CDPROFILE), not (CDCALC) (Opus revi") on rel-20261022m; no robot or Codex result recorded
1. **BUG-525** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-526** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-527** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1147 (open, draft) not on the installed branch
1. **BUG-528** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-529** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-530** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1154 (open, draft) not on the installed branch
1. **BUG-531** | OPEN —15October2026; EBT now has scoped | **3 installed, not yet tested** **(status line wrong)** | #1496 in Structural 1.0.121 (S-41); robot run 46 did not measure it; Codex V9-03 BLOCKED (22 Oct)
1. **BUG-532** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 6d903f98 (2026-10-10, "BUG-532 joist part: the layer FJ1 draws floor joists on is a Settings ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-533** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-534** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1142 (open, draft), #1212 (open, draft) not on the installed branch
1. **BUG-535** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-536** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-537** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-538** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-539** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-540** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-541** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1150 (open, draft) not on the installed branch
1. **BUG-542** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix bdc70c03 (2026-10-10, "BUG-542: long section speeds can read the Settings roughness list (swi") on rel-20261022m; no robot or Codex result recorded
1. **BUG-543** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1144 (open, draft) not on the installed branch
1. **BUG-544** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 0018b393 (2026-10-10, "BUG-544 item 21: Detention Design tab can open at the Settings pre-dev") on rel-20261022m; no robot or Codex result recorded
1. **BUG-545** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1152 (open, draft) not on the installed branch
1. **BUG-546** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1208 (open, draft), #1246 (open, draft) not on the installed branch
1. **BUG-547** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1156 (open, draft), #1159 (open, draft), #1161 (open, draft) not on the installed branch
1. **BUG-548** | OPEN (LOWs; the MEDIUM waits for | **2 built, not installed** | fix PR #1207 (open, draft) not on the installed branch
1. **BUG-549** | OPEN (HIGH; fix is build/02's first | **3 installed, not yet tested** **(status line wrong)** | fix d82424b9 (2026-10-09, "Merge PR #949 (BUG-549 markup upload privacy fix) into claude/rel-2026") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-550** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1139 (open, draft) not on the installed branch
1. **BUG-551** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 4b4f68b3 (2026-10-09, "PRIVACY: Civil AI paths use CE's own cloud connection only; ANTHROPIC_") on rel-20261022m; no robot or Codex result recorded
1. **BUG-552** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #954 (open, draft), #1225 (open, draft) not on the installed branch
1. **BUG-553** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-554** | OPEN (found by reading code; not | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-555** | OPEN (found by reading code; not | **2 built, not installed** | fix PR #1167 (open, draft) not on the installed branch
1. **BUG-556** | OPEN (found by reading code; not | **3 installed, not yet tested** **(status line wrong)** | fix 2c20c16d (2026-10-10, "BUG-556: delete the dead Azure upload code and its config so updates c") on rel-20261022m; no robot or Codex result recorded
1. **BUG-557** | OPEN (found by reading code; not | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | #1171 in Civil 3.0.63+; robot run 39 PASS with a limit
1. **BUG-558** | (no status line) | **3 installed, not yet tested** **(status line wrong)** | fixes #982, #994, #1002, #1007 on rel-20261022m (17 Oct); Codex W49 reproduced it before the fix; no test since
1. **BUG-559** | OPEN (seen by Codex W48, cause | **2 built, not installed** | fix PR #988 (open, draft) not on the installed branch
1. **BUG-560** | OPEN (seen by Codex W48, cause | **3 installed, not yet tested** **(status line wrong)** | fix 2f3f4df6 (2026-10-11, "BUG-560: CD makes CE's record this drawing's before picking, so a seco") on rel-20261022m; no robot or Codex result recorded
1. **BUG-561** | OPEN (seen by Codex W49, cause | **2 built, not installed** | fix PR #987 (open, draft) not on the installed branch
1. **BUG-562** | OPEN (seen by Codex W49). Never | **1 OPEN, no fix** | start-up "; error: syntax error" line; no fix found
1. **BUG-563** | OPEN (seen by the Claude driver | **2 built, not installed** | fix PR #989 (open, draft) not on the installed branch
1. **BUG-564** | OPEN (seen by Codex W57). Never | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-565** | OPEN (seen by Codex W58 on | **3 installed, not yet tested** **(status line wrong)** | PR #1090 (pit-number layer) on rel-20261022m; root cause found in run 15; no test since
1. **BUG-566** | OPEN (filed by controller 06 from | **2 built, not installed** | fix PR #1245 (open, draft) not on the installed branch
1. **BUG-567** | (no status line) | **1 OPEN, no fix** **(status line wrong)** | test-infrastructure item, no status line, no fix found
1. **BUG-568** | (no status line) | **1 OPEN, no fix** **(status line wrong)** | test-infrastructure item, no status line, no fix found
1. **BUG-569** | (no status line) | **1 OPEN, no fix** **(status line wrong)** | test-infrastructure item, no status line, no fix found
1. **BUG-570** | OPEN — screenshot-backed preview failure. No | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-571** | OPEN — confirmed export output defects; | **3 installed, not yet tested** **(status line wrong)** | fix d49e7026 (2026-10-16, "BUG-571: Pit Schedule Excel export: headings fit, numbers are numbers ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-572** | OPEN — real AutoCAD reproduced, MEDIUM | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-573** | OPEN — confirmed in real AutoCAD, | **3 installed, not yet tested** **(status line wrong)** | fix caa1db83 (2026-10-16, "Fix BUG-573 (precision): schedule Changes ignore trailing zeros on equ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-574** | OPEN — MEDIUM readback consistency, confirmed | **3 installed, not yet tested** **(status line wrong)** | fix da006db6 (2026-10-16, "Fix BUG-650: cancelling CDFW/CDSOURCE no longer blanks stored pit inve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-575** | OPEN — MEDIUM support/installation truth, confirmed | **3 installed, not yet tested** **(status line wrong)** | fix c64fa0c0 (2026-10-16, "Fix BUG-575: Settings Installed version shows the loaded version, with") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-576** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix PR #1261 merged on rel-20261022s2; no robot or Codex result recorded
1. **BUG-577** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix d153b3fc (2026-10-17, "BUG-577: re-pin the hand-written beam wording count 87 to 88; log the ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-578** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-579** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-580** | (no status line) | **5 FIXED** **(status line wrong)** | Codex look L3-01c PASS SURE on 18 and 19 Oct (Manager 1.1.54 and 1.1.56); entry has no status line
1. **BUG-581** | (no status line) | **1 OPEN, no fix** **(status line wrong)** | no fix commit or merged PR found on either installed branch
1. **BUG-582** | (no status line) | **3 installed, not yet tested** **(status line wrong)** | fix ea85e9ee (2026-10-17, "Fix BUG-582: New Pipe flow line uses the level it has already calculat") on rel-20261022m; no robot or Codex result recorded
1. **BUG-583** | OPEN - reproduced in real AutoCAD14October2026. | **3 installed, not yet tested** | fix 30e0270a (2026-10-16, "Fix BUG-583/638/636/637: ABS, DSET, DSET1, DUP leave locked-layer obje") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-584** | OPEN - reproduced in real AutoCAD14October2026. | **3 installed, not yet tested** **(status line wrong)** | fix 0629b5fd (2026-10-17, "BUG-584: R1, FJ1 and P1 say so when the placed block did not take the ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-585** | OPEN - reproducedinrealAutoCAD14October2026. | **3 installed, not yet tested** **(status line wrong)** | fix 8e87d666 (2026-10-16, "Fix BUG-585: Esc at the purlin lap question cancels the purlin placeme") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-586** | OPEN — the banked regression remains | **3 installed, not yet tested** | fix 13a77f38 (2026-10-17, "BUG-586/637 Civil half, Opus fix round (entry 1012 LOWs): the writer a") on rel-20261022m; no robot or Codex result recorded
1. **BUG-587** | (no status line) | **1 OPEN, no fix** **(status line wrong)** | no fix commit or merged PR found on either installed branch
1. **BUG-588** | OPEN, MEDIUM; Civil3.0.49+48662ddd, personallyobserved14October2026; Claude ownscommand/reportbehaviour. | **3 installed, not yet tested** **(status line wrong)** | fix 48f3480a (2026-10-16, "Fix BUG-588: CDCHECK saved list includes the FALL arrows that point aw") on rel-20261022m; no robot or Codex result recorded
1. **BUG-589** | OPEN,HIGH; Civil3.0.49+48662ddd,personallyobserved14October2026; Claude ownsChecks reader/drawing-recordservice. | **3 installed, not yet tested** **(status line wrong)** | fix 9c2e3d50 (2026-10-16, "Fix BUG-589: first CDCHECK after reopening reads the saved pit list (f") on rel-20261022m; no robot or Codex result recorded
1. **BUG-590** | OPEN — 14 October2026, real installed | **3 installed, not yet tested** | fix 116f4d7e (2026-10-17, "BUG-590/591 Opus fix round (entry 1009 LOW): a test proves the Print b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-591** | OPEN — 14 October2026, real installed | **3 installed, not yet tested** | fix 116f4d7e (2026-10-17, "BUG-590/591 Opus fix round (entry 1009 LOW): a test proves the Print b") on rel-20261022m; no robot or Codex result recorded
1. **BUG-592** | OPEN — Codex real AutoCAD, 14 | **3 installed, not yet tested** **(status line wrong)** | fix 7553cea9 (2026-10-16, "BUG-592: Pipe Flows shows Unknown, not 0.00, when the inputs give no r") on rel-20261022m; no robot or Codex result recorded
1. **BUG-593** | OPEN — Codex real AutoCAD, 14 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-594** | OPEN — Codex real AutoCAD2027,15October2026,Civil3.0.49+48662ddd; service | **3 installed, not yet tested** | fix be7827b8 (2026-10-16, "Fix BUG-594: rating report reader recognises Blue Factor reports") on rel-20261022m; no robot or Codex result recorded
1. **BUG-595** | OPEN / INVESTIGATE — native recovery | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-596** | OPEN — actualinstalledCivil3.0.49+48662ddd; windowrepaircandidatebuilt/tested,notinstalled. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-597** | OPEN — actualinstalledCivil3.0.49+48662ddd,15October2026. | **3 installed, not yet tested** | fix cfd179ea (2026-10-16, "BUG-597: Charged System shows Unknown (not the old figures) for result") on rel-20261022m; no robot or Codex result recorded
1. **BUG-598** | OPEN — Codex real AutoCAD 2027, | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-599** | OPEN — real installed AutoCAD2027,15October2026,Civil3.0.49+48662ddd. | **3 installed, not yet tested** | fix d95f2f55 (2026-10-16, "Fix BUG-599: CDPROFILE Preview names a missing DASHDOT2 linetype befor") on rel-20261022m; no robot or Codex result recorded
1. **BUG-600** | OPEN — real installed AutoCAD2027,Civil3.0.49+48662ddd,15October2026. | **3 installed, not yet tested** | fix c9509bda (2026-10-17, "Fix BUG-600: a wrapped long section title clears the scale note and th") on rel-20261022m; no robot or Codex result recorded
1. **BUG-601** | OPEN — installed AutoCAD2027/Civil3.0.49+48662ddd,15October2026. | **3 installed, not yet tested** | fix 365c287e (2026-10-17, "Fix BUG-601: a linked long section update redraws on screen without RE") on rel-20261022m; no robot or Codex result recorded
1. **BUG-602** | OPEN — installed Civil3.0.49+48662ddd,realAutoCAD2027,15October2026. | **3 installed, not yet tested** | fix f6389f40 (2026-10-16, "Fix BUG-605/604/602: LandXML import keeps supplied inverts, names its ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-603** | OPEN — installed Civil3.0.49+48662ddd,AutoCAD2027,15October2026. | **3 installed, not yet tested** | fix ad6e7f9e (2026-10-17, "BUG-603: a cancelled LandXML review opens no second window; review pag") on rel-20261022m; no robot or Codex result recorded
1. **BUG-604** | OPEN — sameinstalled/nativepositiveLandXMLbatch. | **3 installed, not yet tested** | fix f6389f40 (2026-10-16, "Fix BUG-605/604/602: LandXML import keeps supplied inverts, names its ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-605** | OPEN — realAutoCAD2027/Civil3.0.49+48662ddd,15October2026. | **3 installed, not yet tested** **(status line wrong)** | fix 8a54cef0 (2026-10-17, "Fix BUG-605 review finding: LandXML inverts go to the pipe they name; ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-606** | OPEN — installedCivil3.0.49+48662ddd,realAutoCAD2027,15October2026. | **3 installed, not yet tested** | fix 4f939b6e (2026-10-17, "BUG-606 review fix: create the CE report folder only inside the writin") on rel-20261022m; no robot or Codex result recorded
1. **BUG-607** | OPEN — realAutoCAD2027,installedCivil3.0.49+48662ddd,15October2026. | **3 installed, not yet tested** | fix c7dd9cda (2026-10-16, "Fix BUG-607: comparison report is not called overall when assets are m") on rel-20261022m; no robot or Codex result recorded
1. **BUG-608** | OPEN — Structural1.0.116+f180b349,realAutoCAD2027,15October2026. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-609** | OPEN — sameinstalledStructural1.0.116/realAutoCAD2027. | **2 built, not installed** | fix PR #1260 (open, draft) not on the installed branch
1. **BUG-610** | OPEN — observed in real AutoCAD | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-611** | OPEN — installedStructural1.0.116+f180b349, realAutoCAD2027,15October2026. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-612** | OPEN — MEDIUM. Observed15October2026, installedStructural1.0.116+f180b349. Claude | **3 installed, not yet tested** | only the failure wording (#1294) is installed in Structural; the read failure itself is not fixed
1. **BUG-613** | OPEN — MEDIUM,15October2026,installedStructural1.0.116+f180b349. Nativebehaviour/manageddetailClaude;Codexwindowpreviewacceptance. ApprovedST8-9/10requiresonecompounddetail. Thisisanevidencedexistingplan-gap,notaclaimrecentregression. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-614** | (no status line) | **3 installed, not yet tested** **(status line wrong)** | fix cfaa62ca (2026-10-16, "BUG-614 + BUG-628: hatches and the BL break line follow any drawing sc") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-615** | (no status line) | **1 OPEN, no fix** **(status line wrong)** | no fix commit or merged PR found on either installed branch
1. **BUG-616** | (no status line) | **1 OPEN, no fix** **(status line wrong)** | no fix commit or merged PR found on either installed branch
1. **BUG-617** | (no status line) | **3 installed, not yet tested** **(status line wrong)** | fix e877b453 (2026-10-16, "BUG-620 + BUG-617: FASTSAVE only saves (switch off), XRL names a locke") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-618** | (no status line) | **3 installed, not yet tested** **(status line wrong)** | fix 65a1f723 (2026-10-16, "BUG-577 + BUG-618 + BUG-612: failures name the real cause (beam units,") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-619** | (no status line) | **3 installed, not yet tested** **(status line wrong)** | fix 670da629 (2026-10-16, "Fix BUG-619: CEHATCHAUDIT and CEHATCHCHANGE read each hatch outside th") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-620** | MEDIUM OPEN — source finding at | **3 installed, not yet tested** | fix e877b453 (2026-10-16, "BUG-620 + BUG-617: FASTSAVE only saves (switch off), XRL names a locke") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-621** | MEDIUM OPEN. Native AD and LD | **3 installed, not yet tested** | fix 8a4bf682 (2026-10-17, "BUG-621 review fix (entry 1025 MEDIUM + LOW): restore copies the dimen") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-622** | MEDIUM OPEN. Structural annotation, approved ST-03 | **3 installed, not yet tested** | fix dc7dfe19 (2026-10-17, "Fix BUG-622 review HIGH: typing F in MLL/MLR repeats the drag so the t") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-623** | MEDIUM OPEN — investigation required. Observed | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-624** | OPEN / MEDIUM. Real AutoCAD2027,15October2026; installed | **3 installed, not yet tested** | fix d5d64fd3 (2026-10-17, "Fix BUG-622 and BUG-624: MLL/MLR accept F to swap the side; a note on ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-625** | OPEN / HIGH. Observed 15 October | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-626** | OPEN / MEDIUM. Real AutoCAD2027 / | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-627** | OPEN / MEDIUM. Real AutoCAD2027 / | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-628** | OPEN / MEDIUM. Observed15October2026 in actual | **3 installed, not yet tested** | fix cfaa62ca (2026-10-16, "BUG-614 + BUG-628: hatches and the BL break line follow any drawing sc") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-629** | OPEN / MEDIUM. Actual AutoCAD2027/Structural1.0.116+f180,15October2026. Approved | **3 installed, not yet tested** **(status line wrong)** | fix 661e9f78 (2026-10-17, "BUG-629 review fix follow-up: the sheet note follows the Settings labe") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-630** | OPEN / MEDIUM. Actual AutoCAD2027/installed Structural1.0.116+f180,15October2026. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-631** | OPEN / MEDIUM. Actual AutoCAD2027/Structural1.0.116+f180,15October2026; approved | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-632** | OPEN / MEDIUM. Actual AutoCAD2027/Structural1.0.116+f180,15October2026. Dark | **3 installed, not yet tested** **(status line wrong)** | fix bf33ad78 (2026-10-17, "S-38 finalizer: section mark letter in the clear half ships OFF until ") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-633** | OPEN / MEDIUM. Observed15October2026, actual AutoCAD2027/installed | **3 installed, not yet tested** | fix 7d9599b5 (2026-10-16, "Fix BUG-633: DSET accepts any kind of dimension (no exact match on the") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-634** | OPEN / MEDIUM. Observed15October2026, actual AutoCAD2027/installed | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-635** | OPEN / HIGH. Observed15October2026, actual AutoCAD2027/installed | **3 installed, not yet tested** | fix bf7a3e82 (2026-10-17, "Fix BUG-635 review LOWs: no dimension handle on the command line; name") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-636** | OPEN / HIGH. Actual AutoCAD2027/Structural1.0.116+f180,15October2026; approved | **3 installed, not yet tested** **(status line wrong)** | fix 30e0270a (2026-10-16, "Fix BUG-583/638/636/637: ABS, DSET, DSET1, DUP leave locked-layer obje") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-637** | OPEN / MEDIUM. Actual AutoCAD2027, Civil3.0.49/Structural1.0.116 | **3 installed, not yet tested** | fix 13a77f38 (2026-10-17, "BUG-586/637 Civil half, Opus fix round (entry 1012 LOWs): the writer a") on rel-20261022m; no robot or Codex result recorded
1. **BUG-638** | OPEN / HIGH. ActualAutoCAD2027/Structural1.0.116+f180,15October2026; approvedST3-12/14 and | **3 installed, not yet tested** **(status line wrong)** | fix 30e0270a (2026-10-16, "Fix BUG-583/638/636/637: ABS, DSET, DSET1, DUP leave locked-layer obje") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-639** | OPEN / LOW, documentation/authority-navigation audit only,15October2026. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-640** | MEDIUM OPEN. AutoCAD2027, installed Structural1.0.116+f180b349. Approved | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-641** | OPEN —15Oct2026;notfixed. | **1 OPEN, no fix** | no fix; Codex look L1-03a FAIL SURE (18 Oct, Civil 3.0.54)
1. **BUG-642** | OPEN —15Oct2026;notfixed. | **4 installed, FAILS in AutoCAD** **(status line wrong)** | fix #1293 (17 Oct) installed; Codex look L1-03b FAIL SURE (18 Oct, Civil 3.0.54): labels still overlap, partly improved
1. **BUG-643** | OPEN —15Oct2026, native numerical defect. | **3 installed, not yet tested** **(status line wrong)** | fix 137834ed (2026-10-16, "Fix BUG-643: CDCATCHMENT and CDPAVE measure a curved outline by its re") on rel-20261022m; no robot or Codex result recorded
1. **BUG-644** | OPEN —15Oct2026; observed installed route misses | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-645** | OPEN —15Oct2026; approved conversion review/position gap. | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-646** | OPEN —15October2026; native current-setting leak. | **3 installed, not yet tested** **(status line wrong)** | fix 1251b22f (2026-10-16, "BUG-621 + BUG-646: CE commands hand back the drafter's current colour,") on rel-20261022s2; no robot or Codex result recorded
1. **BUG-647** | OPEN / MEDIUM. Observed15October2026 in real | **3 installed, not yet tested** | fix fb04a578 (2026-10-16, "Fix BUG-647 (CDFW part): strip, AG and perimeter drains are not judged") on rel-20261022m; no robot or Codex result recorded
1. **BUG-648** | OPEN / MEDIUM. Real AutoCAD2027, Civil3.0.49+48662ddd; | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-649** | OPEN / HIGH, misleading grade verdict. | **3 installed, not yet tested** **(status line wrong)** | fix 72e2295f (2026-10-17, "BUG-649 review fix: one full stop after the grade sentence in the plac") on rel-20261022m; no robot or Codex result recorded
1. **BUG-650** | OPEN / HIGH, unexpected stored engineering-data | **3 installed, not yet tested** **(status line wrong)** | fix da006db6 (2026-10-16, "Fix BUG-650: cancelling CDFW/CDSOURCE no longer blanks stored pit inve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-651** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-652** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix c14f04c8 (2026-10-18, "Fix BUG-652 review HIGH: Edit Pipe's Recalculate downstream measures t") on rel-20261022m; no robot or Codex result recorded
1. **BUG-653** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 3373b6cd (2026-10-17, "Fix BUG-652..655: level cascade keeps pit drops, skips blank levels, c") on rel-20261022m; no robot or Codex result recorded
1. **BUG-654** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 3373b6cd (2026-10-17, "Fix BUG-652..655: level cascade keeps pit drops, skips blank levels, c") on rel-20261022m; no robot or Codex result recorded
1. **BUG-655** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 3373b6cd (2026-10-17, "Fix BUG-652..655: level cascade keeps pit drops, skips blank levels, c") on rel-20261022m; no robot or Codex result recorded
1. **BUG-656** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 4019cc7e (2026-10-18, "Fix BUG-656: the level cascade re-links only the pipes its preview lis") on rel-20261022m; no robot or Codex result recorded
1. **BUG-657** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 8caecdbf (2026-10-18, "Fix BUG-657: the cascade writes a pipe's two level texts together or n") on rel-20261022m; no robot or Codex result recorded
1. **BUG-658** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-659** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 2f6cfca5 (2026-10-18, "Fix BUG-659 review MEDIUM: relink orients by the record but only Edit ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-660** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix c0525699 (2026-10-17, "Fix BUG-660: a pipe the pit relink skipped stays on the pit's own list") on rel-20261022m; no robot or Codex result recorded
1. **BUG-661** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 503faf55 (2026-10-17, "Fix BUG-661: pipe end pick converts the click from the UCS to world fi") on rel-20261022m; no robot or Codex result recorded
1. **BUG-662** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix e857dedb (2026-10-17, "Fix BUG-662: CDUPGRADE Merge keeps every field of an existing pipe row") on rel-20261022m; no robot or Codex result recorded
1. **BUG-663** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix b675df6e (2026-10-17, "Fix BUG-663/695/696: millimetres used as drawing units in a metre draw") on rel-20261022m; no robot or Codex result recorded
1. **BUG-664** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-665** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6a45bf93 (2026-10-17, "Fix BUG-665/666: grip, ROTATE and SCALE copies get clean-up (switch, O") on rel-20261022m; no robot or Codex result recorded
1. **BUG-666** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6a45bf93 (2026-10-17, "Fix BUG-665/666: grip, ROTATE and SCALE copies get clean-up (switch, O") on rel-20261022m; no robot or Codex result recorded
1. **BUG-667** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 212ca77d (2026-10-17, "Fix BUG-667: an erased pit label no longer stops the link memory rebui") on rel-20261022m; no robot or Codex result recorded
1. **BUG-668** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-669** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix a1320ec6 (2026-10-17, "Fix BUG-669: the label-followed note is cleared at the start of every ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-670** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6b57f96c (2026-10-18, "Fix BUG-670/671/672: copy clean-up keeps every piece it can") on rel-20261022m; no robot or Codex result recorded
1. **BUG-671** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6b57f96c (2026-10-18, "Fix BUG-670/671/672: copy clean-up keeps every piece it can") on rel-20261022m; no robot or Codex result recorded
1. **BUG-672** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6b57f96c (2026-10-18, "Fix BUG-670/671/672: copy clean-up keeps every piece it can") on rel-20261022m; no robot or Codex result recorded
1. **BUG-673** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 5bc5a17b (2026-10-17, "Fix BUG-673: label displacement memory keyed by drawing identity and d") on rel-20261022m; no robot or Codex result recorded
1. **BUG-674** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix f100040a (2026-10-17, "Fix BUG-674 and BUG-679 (turn half): re-snap pipe ends after CDEDIT mu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-675** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 4a56a72d (2026-10-18, "Fix BUG-675 review MEDIUM: CD pit-fit check reads the pit's real turn ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-676** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 4e41ad56 (2026-10-17, "Fix BUG-676: Edit Pit Save and Upsize keep the lid wording") on rel-20261022m; no robot or Codex result recorded
1. **BUG-677** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 2b8ab057 (2026-10-17, "Fix BUG-677/680: pit number from the right place (CDEDIT batch, CD Ups") on rel-20261022m; no robot or Codex result recorded
1. **BUG-678** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 1a091ee5 (2026-10-17, "REGRESSION_LOG: BUG-675/678") on rel-20261022m; no robot or Codex result recorded
1. **BUG-679** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix f100040a (2026-10-17, "Fix BUG-674 and BUG-679 (turn half): re-snap pipe ends after CDEDIT mu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-680** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 3c539f02 (2026-10-18, "BUG-680 review LOW: drop 'Nothing was changed' from the label-mismatch") on rel-20261022m; no robot or Codex result recorded
1. **BUG-681** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix b26a8ef3 (2026-10-18, "Fix BUG-681: the Pit Schedule row follows the answer to CD's Uphill pi") on rel-20261022m; no robot or Codex result recorded
1. **BUG-682** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 60fcad04 (2026-10-18, "Fix BUG-682: Cancel in CD's Uphill box removes the schedule row and br") on rel-20261022m; no robot or Codex result recorded
1. **BUG-683** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 1b20cbfd (2026-10-20, "Merge PR #1437 (BUG-683 same-plan break real length, fix round) into C") on rel-20261022m; no robot or Codex result recorded
1. **BUG-684** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6db4dc78 (2026-10-18, "Fix BUG-684 review MEDIUM: a closed drawn line is kept and used as dra") on rel-20261022m; no robot or Codex result recorded
1. **BUG-685** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-686** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 2c21b843 (2026-10-17, "Fix BUG-686: flow arrow uses a given 0.00 level") on rel-20261022m; no robot or Codex result recorded
1. **BUG-687** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6e30fc50 (2026-10-17, "Fix BUG-687: Edit Pipe saves a Q-only (design flow) change") on rel-20261022m; no robot or Codex result recorded
1. **BUG-688** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 2644c197 (2026-10-18, "BUG-688 review fix: held end's level text is marked present but not dr") on rel-20261022m; no robot or Codex result recorded
1. **BUG-689** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 7a6b20b3 (2026-10-17, "Fix BUG-688/689: batch Design grade warns about outside arrivals and s") on rel-20261022m; no robot or Codex result recorded
1. **BUG-690** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-691** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 934dc9c0 (2026-10-17, "Fix BUG-691: a pit placed on one half of a broken pipe leaves the pipe") on rel-20261022m; no robot or Codex result recorded
1. **BUG-692** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-693** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-694** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix c9ee9843 (2026-10-17, "Fix BUG-694: Pit Schedule typed level reaches both halves of a split p") on rel-20261022m; no robot or Codex result recorded
1. **BUG-695** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 5af6ef3e (2026-10-18, "Fix BUG-695 review MEDIUM: metre drawings keep the downpipe junction w") on rel-20261022m; no robot or Codex result recorded
1. **BUG-696** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix b675df6e (2026-10-17, "Fix BUG-663/695/696: millimetres used as drawing units in a metre draw") on rel-20261022m; no robot or Codex result recorded
1. **BUG-697** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 1041f89b (2026-10-18, "BUG-697 review fix: CD E pick lets a real CE pipe object reach the alr") on rel-20261022m; no robot or Codex result recorded
1. **BUG-698** | OPEN | **5 FIXED** **(status line wrong)** | robot runs 30 to 35 PASS and Codex V2-04 PASS SURE (20 Oct, Civil 3.0.64): rows identical after CDSYNC; status still OPEN
1. **BUG-699** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 24e21a90 (2026-10-18, "Fix Opus review 1154 on BUG-699: a stray decimal text outside 0-500 is") on rel-20261022m; no robot or Codex result recorded
1. **BUG-700** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix cb770842 (2026-10-18, "Join BUG-704 (quad faces) with BUG-700 (survey XREF Z scale): all four") on rel-20261022m; no robot or Codex result recorded
1. **BUG-701** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix e9d3ebde (2026-10-18, "Fix BUG-701: survey duplicate-point check measures in the drawing's ow") on rel-20261022m; no robot or Codex result recorded
1. **BUG-702** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6332655f (2026-10-18, "Fix BUG-702 (attribute default): CDSURVEY skips a block attribute defa") on rel-20261022m; no robot or Codex result recorded
1. **BUG-703** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix d6abf468 (2026-10-18, "Fix BUG-703 review: survey spot pairing checked both ways; 0.002 m edg") on rel-20261022m; no robot or Codex result recorded
1. **BUG-704** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix cb770842 (2026-10-18, "Join BUG-704 (quad faces) with BUG-700 (survey XREF Z scale): all four") on rel-20261022m; no robot or Codex result recorded
1. **BUG-705** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 7250faf2 (2026-10-18, "Fix BUG-705 review: no-units drawing is read as metres only for an MGA") on rel-20261022m; no robot or Codex result recorded
1. **BUG-706** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 6b7c968e (2026-10-18, "Fix BUG-706: skipping the raw survey in CDSURVEY no longer records the") on rel-20261022m; no robot or Codex result recorded
1. **BUG-707** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-708** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 5084ff60 (2026-10-18, "Fix BUG-708: survey status counts suspect points, not whole-survey not") on rel-20261022m; no robot or Codex result recorded
1. **BUG-709** | OPEN | **3 installed, not yet tested** **(status line wrong)** | reading half #1438 installed, ships OFF; robot run 36/37 UNPROVEN
1. **BUG-710** | OPEN | **2 built, not installed** | fix PR #1341 (open, draft) not on the installed branch
1. **BUG-711** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix c4e7611b (2026-10-18, "Fix Opus review 1144 on BUG-711/713/714: TW and BW are not ground leve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-712** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fix #1344 installed; robot run 30 PASS
1. **BUG-713** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix c4e7611b (2026-10-18, "Fix Opus review 1144 on BUG-711/713/714: TW and BW are not ground leve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-714** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix c4e7611b (2026-10-18, "Fix Opus review 1144 on BUG-711/713/714: TW and BW are not ground leve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-715** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix eca3dbaf (2026-10-18, "BUG-715 log: reword no-breakline test step (Opus review 1148 LOW 1)") on rel-20261022m; no robot or Codex result recorded
1. **BUG-716** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 1379000c (2026-10-18, "Merge #1342 fix and the parallel review-1151 fix into BUG-716 (one sha") on rel-20261022m; no robot or Codex result recorded
1. **BUG-717** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix fba6f151 (2026-10-18, "Fix BUG-717: X-Civil import keeps TW/BW on wall levels") on rel-20261022m; no robot or Codex result recorded
1. **BUG-718** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 45758386 (2026-10-18, "Merge #1351 (BUG-718 rest) into the C-44 train by hand") on rel-20261022m; no robot or Codex result recorded
1. **BUG-719** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-720** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-721** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 4c27c0a6 (2026-10-18, "BUG-721: REGRESSION_LOG entry") on rel-20261022m; no robot or Codex result recorded
1. **BUG-722** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 47f4c257 (2026-10-18, "Fix BUG-722 review: a LandXML pipe that names a left-out pit leaves th") on rel-20261022m; no robot or Codex result recorded
1. **BUG-723** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-724** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-725** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-726** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 388fe5e9 (2026-10-18, "Fix BUG-726: CDIMPORTCOMPARE names the pipe that is really missing") on rel-20261022m; no robot or Codex result recorded
1. **BUG-727** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix e6de44ad (2026-10-18, "Fix BUG-727: CDIMPORTCOMPARE can read a reference DWG that is open in ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-728** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-729** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-730** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix ba9935b0 (2026-10-18, "Fix BUG-730: X-Civil import keeps the drawn pit schedule table") on rel-20261022m; no robot or Codex result recorded
1. **BUG-731** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix fff9fbed (2026-10-18, "Fix Opus review 1158 on BUG-731: measure the drawing without the earli") on rel-20261022m; no robot or Codex result recorded
1. **BUG-732** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix cde06b41 (2026-10-18, "Fix BUG-731/732: X-Civil Replace erases late, and never the drafter's ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-733** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix b2d2d8d2 (2026-10-18, "Fix BUG-733: X-Civil import keeps two close pits with different number") on rel-20261022m; no robot or Codex result recorded
1. **BUG-734** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 5beb2458 (2026-10-18, "Fix BUG-734: X-Civil import leaves the other invert blank on a pipe dr") on rel-20261022m; no robot or Codex result recorded
1. **BUG-735** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 9e0b391e (2026-10-18, "Fix BUG-735: X-Civil import puts each IL text at its own pipe end") on rel-20261022m; no robot or Codex result recorded
1. **BUG-736** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 62dbbffc (2026-10-18, "Fix BUG-736 (IL: wording): X-Civil import reads IL:12.34 as an invert ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-737** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 100db1f2 (2026-10-18, "Fix BUG-737 review: one summary line for pit floor levels instead of o") on rel-20261022m; no robot or Codex result recorded
1. **BUG-738** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 452f87c2 (2026-10-18, "Fix BUG-738 review (HIGH): drawn pit schedule table keeps its cover le") on rel-20261022m; no robot or Codex result recorded
1. **BUG-739** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 30db1214 (2026-10-18, "Fix BUG-739 (report half): X-Civil import report says how many warning") on rel-20261022m; no robot or Codex result recorded
1. **BUG-740** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fix #1355 installed; robot runs 31 and 32 PASS for the numbering; rename part is BUG-813
1. **BUG-741** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 98f605ea (Opus review 1157 on BUG-740/741) on rel-20261022m; robot runs 32 to 35 did not judge it
1. **BUG-742** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fix #1358 installed; robot run 34 PASS
1. **BUG-743** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 4b03ad1d (2026-10-18, "Fix Opus review 1147 on BUG-743: key the remembered cover level by fil") on rel-20261022m; no robot or Codex result recorded
1. **BUG-744** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix f15b6c1f (2026-10-18, "Fix BUG-744: CDFIXTAGS does not add a label to a source that had none") on rel-20261022m; no robot or Codex result recorded
1. **BUG-745** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 0ceb3ae3 (2026-10-18, "Fix BUG-745 (rest): CDTG numbers read in drawing units, recorded in mm") on rel-20261022m; no robot or Codex result recorded
1. **BUG-746** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 9bfc5cd8 (2026-10-18, "Fix BUG-746: removing a source tag erases its stored records too") on rel-20261022m; no robot or Codex result recorded
1. **BUG-747** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 34c23f03 (2026-10-18, "Fix BUG-747 review: name the real command CDPIPEOVERRIDE (there is no ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-748** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | #1498 in Structural 1.0.121; robot run 46: LBUH 50 and LBH 125 match the expected scales; Codex V9-02 BLOCKED
1. **BUG-749** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-750** | OPEN (18 Oct 2026 note: SUPERSEDED | **6 superseded** | superseded by Tim's CEMEMBER design (decision 18 Oct, D6); Codex look L3-06c still FAIL on SBEAM
1. **BUG-751** | OPEN | **2 built, not installed** | PR #1383 open; Codex look L3-06b FAIL SURE 19 Oct
1. **BUG-752** | OPEN | **2 built, not installed** | PR #1386 open; Codex look L3-04 FAIL SURE 19 Oct
1. **BUG-753** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 22921387 (2026-10-18, "Fix BUG-753: the Checks list names a pipe with no tag 'unnamed pipe', ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-754** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix df7d2a5a (2026-10-18, "Fix BUG-754: Manager tab names are readable in the Dark theme (tab fac") on rel-20261022m; no robot or Codex result recorded
1. **BUG-755** | OPEN | **2 built, not installed** | PR #1385 open; Codex look L3-06a observation
1. **BUG-756** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-757** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-758** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 5feab4a3 (2026-10-18, "BUG-758 write side: widen the Bug601 redraw-order test window (Opus re") on rel-20261022m; no robot or Codex result recorded
1. **BUG-759** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-760** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-761** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-762** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-763** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-764** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-765** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-766** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-767** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix d5115f0e (2026-10-18, "Fix BUG-767: the long section frame is widened by the existing-pipe st") on rel-20261022m; no robot or Codex result recorded
1. **BUG-768** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 9e20647e (2026-10-18, "Fix BUG-768: the pump-station radius counts only on pump-station pits ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-769** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 9a0024b3 (2026-10-18, "BUG-769 fix round: REGRESSION_LOG entry for the by-handle fix") on rel-20261022m; no robot or Codex result recorded
1. **BUG-770** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 920e7160 (2026-10-18, "BUG-770 fix round: full-flow row reads the Settings roughness; switch-") on rel-20261022m; no robot or Codex result recorded
1. **BUG-771** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-772** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 8324a299 (2026-10-18, "Fix BUG-772: the WSUD tab holds an impervious area to the site and say") on rel-20261022m; no robot or Codex result recorded
1. **BUG-773** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 04930ee3 (2026-10-18, "Fix BUG-773 (position half): CDRG records the true centre of the raing") on rel-20261022m; no robot or Codex result recorded
1. **BUG-774** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-775** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-776** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-777** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix d19500c9 (2026-10-18, "Fix BUG-777: CDTWL offers the highest obvert as CE's usual top water l") on rel-20261022m; no robot or Codex result recorded
1. **BUG-778** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-779** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix df125802 (2026-10-18, "Fix BUG-779: moving the drawn Pit Schedule writes no cell text into th") on rel-20261022m; no robot or Codex result recorded
1. **BUG-780** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 7a687e38 (2026-10-18, "Fix BUG-780: merged Pit Schedule inlet rows keep their own pipe (Setti") on rel-20261022m; no robot or Codex result recorded
1. **BUG-781** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 2d2e7b49 (2026-10-18, "Fix BUG-781: X-Civil schedule rows are paired to pits by order only wh") on rel-20261022m; no robot or Codex result recorded
1. **BUG-782** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fix #1400 installed; robot run 35 PASS; Codex V2-05 NOT TESTED twice
1. **BUG-783** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 5be02d8f (2026-10-18, "Fix BUG-783: a Delete cell stays blank in the drawn Pit Schedule (Sett") on rel-20261022m; no robot or Codex result recorded
1. **BUG-784** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix a086151a (2026-10-18, "Fix BUG-784: the Pit Schedule FROM column keeps a real pit's number (C") on rel-20261022m; no robot or Codex result recorded
1. **BUG-785** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 90cd6139 (2026-10-18, "Fix BUG-785: one depth rule for the Pit Schedule window, the drawn-tab") on rel-20261022m; no robot or Codex result recorded
1. **BUG-786** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 81da50b4 (2026-10-18, "Fix BUG-786: a new inlet added to a pit stays with its pit in the Pit ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-787** | OPEN | **2 built, not installed** | fix PR #1423 (open, draft) not on the installed branch
1. **BUG-788** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 73a63971 (2026-10-18, "Fix BUG-788: a Save As copy of an Xref is listed as its own source, no") on rel-20261022m; no robot or Codex result recorded
1. **BUG-789** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fix #1406 installed; robot run 32 PASS with one condition
1. **BUG-790** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix d321f4fd (2026-10-19, "BUG-790 fix round: the review reads a copy of the office Settings (Opu") on rel-20261022m; no robot or Codex result recorded
1. **BUG-791** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 717badf8 (2026-10-18, "Fix BUG-791: the Pit Schedule window marks only changed cells as overr") on rel-20261022m; no robot or Codex result recorded
1. **BUG-792** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 4289e35a (2026-10-18, "Fix BUG-792 (numbers half): a level or size typed into the drawn Pit S") on rel-20261022m; no robot or Codex result recorded
1. **BUG-793** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-794** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 45d28706 (2026-10-18, "Fix BUG-794: X-Civil preflight says the PDF schedule was not read, not") on rel-20261022m; no robot or Codex result recorded
1. **BUG-795** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix f4242a21 (2026-10-18, "Fix BUG-795: CDXREFREPAIR never offers the host drawing, prefers the m") on rel-20261022m; no robot or Codex result recorded
1. **BUG-796** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-797** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fix 5588c82d (BUG-782/797) installed; robot run 35 PASS but the locked-layer case untested; Codex V2-05 NOT TESTED
1. **BUG-798** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 55671710 (2026-10-18, "Fix BUG-798: a continuation sheet of the Pit Schedule repeats the pit ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-799** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-800** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 3736d219 (2026-10-18, "Fix BUG-800: the Checks list shows CE could not check when a source fa") on rel-20261022m; no robot or Codex result recorded
1. **BUG-801** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 165a12fa (2026-10-18, "Fix BUG-801: CE's own edit commands mark the automatic Project QA stal") on rel-20261022m; no robot or Codex result recorded
1. **BUG-802** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-803** | OPEN | **2 built, not installed** | fix PR #1419 (open, draft) not on the installed branch
1. **BUG-804** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-805** | OPEN | **2 built, not installed** | fix PR #817 (open, draft) not on the installed branch
1. **BUG-806** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-807** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 1be523c1 (2026-10-18, "Fix BUG-807 and BUG-809 item 3: level text rounds half away and never ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-808** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 834870f3 (2026-10-18, "Fix BUG-808 (outlet half): the outlet is compared with the pit's large") on rel-20261022m; no robot or Codex result recorded
1. **BUG-809** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 79a6948c (2026-10-18, "BUG-809 test: non-generic Enum.Parse so the net48 test lane compiles") on rel-20261022m; no robot or Codex result recorded
1. **BUG-810** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-811** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-812** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-813** | OPEN | **1 OPEN, no fix** | only the diagnostic (#1478, a draft whose own title says "not the rename fix") is installed; robot run 34 STILL SEEN on 3.0.58
1. **BUG-814** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | fixes #1429/#1439 installed; robot runs 32 to 34 wording PASS
1. **BUG-815** | FIXED (Codex-accepted, Civil 3.0.64, 20 Oct | **5 FIXED** | status line: FIXED (Codex-accepted, Civil 3.0.64, 20 Oct 2026) for the R-06 wording (the "not known" le
1. **BUG-816** | OPEN | **1 OPEN, no fix** | no fix; robot run 33 STILL SEEN on 3.0.57
1. **BUG-817** | OPEN | **1 OPEN, no fix** | no fix; robot run 32 STILL SEEN on 3.0.56
1. **BUG-818** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-819** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-820** | FIXED (Codex-accepted, Civil 3.0.64, 20 Oct | **5 FIXED** | status line: FIXED (Codex-accepted, Civil 3.0.64, 20 Oct 2026) for the totals-line half only; Tim's que
1. **BUG-821** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-822** | OPEN | **1 OPEN, no fix** | no fix; robot run 35 STILL SEEN on 3.0.59
1. **BUG-823** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 9db7cdf7 (2026-10-19, "Fix BUG-823: installer accepts Manager's staging receipt beside the si") on rel-20261022m; no robot or Codex result recorded
1. **BUG-824** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix fdd724fc (2026-10-19, "Fix BUG-824: installer treats a command-free .dbx like a command-free ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-825** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | step-iron half Codex-accepted 21 Oct (Civil 3.0.66) per the entry body; velocity half robot run 33 PASS through the settings guard only; status line still OPEN
1. **BUG-826** | OPEN | **2 built, not installed** | fix PR #1457 (open, draft) not on the installed branch
1. **BUG-827** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix f8ba8b90 (2026-10-19, "BUG-827 fix round (Opus 1298 LOW): the held-file warning names standar") on rel-20261022m; no robot or Codex result recorded
1. **BUG-828** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix a6707cef (2026-10-19, "BUG-828 fix round (Opus 1299): wrap the ribbon test in NET8_0_OR_GREAT") on rel-20261022m; no robot or Codex result recorded
1. **BUG-829** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix a690f36d (2026-10-19, "BUG-829 fix round (Opus 1291): never create the shared policies folder") on rel-20261022m; no robot or Codex result recorded
1. **BUG-830** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 0e13f2b2 (2026-10-19, "Fix BUG-830 and BUG-839: CEMANAGER Civil page resets only what it show") on rel-20261022m; no robot or Codex result recorded
1. **BUG-831** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 7e60a2b7 (2026-10-19, "Fix BUG-827 and BUG-831: locked settings file is read again and never ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-832** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix d79f8f10 (2026-10-19, "Fix BUG-832 and BUG-833: failed Civil stage stops Manager alone; one s") on rel-20261022m; no robot or Codex result recorded
1. **BUG-833** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix d79f8f10 (2026-10-19, "Fix BUG-832 and BUG-833: failed Civil stage stops Manager alone; one s") on rel-20261022m; no robot or Codex result recorded
1. **BUG-834** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 980d2f65 (2026-10-20, "Fix BUG-834: installer reads the office approval and refuses a build o") on rel-20261022m; no robot or Codex result recorded
1. **BUG-835** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix f0f770c5 (2026-10-19, "BUG-835: same-version check uses CompareVersions so v3.0.56 equals 3.0") on rel-20261022m; no robot or Codex result recorded
1. **BUG-836** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 49c930c6 (2026-10-19, "Fix BUG-835, BUG-836 and BUG-837: versions compare as numbers; same-ve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-837** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 49c930c6 (2026-10-19, "Fix BUG-835, BUG-836 and BUG-837: versions compare as numbers; same-ve") on rel-20261022m; no robot or Codex result recorded
1. **BUG-838** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix f2c6f848 (2026-10-20, "BUG-838 installer half only: drop the update-staging half (superseded ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-839** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 0e13f2b2 (2026-10-19, "Fix BUG-830 and BUG-839: CEMANAGER Civil page resets only what it show") on rel-20261022m; no robot or Codex result recorded
1. **BUG-840** | OPEN | **2 built, not installed** | fix PR #1460 (open, draft) not on the installed branch
1. **BUG-841** | OPEN | **2 built, not installed** | fix PR #1464 (open, draft) not on the installed branch
1. **BUG-842** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 7eaa55db (2026-10-19, "Fix BUG-842 and BUG-848: CE Blocks settings never overwritten after a ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-843** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 7309b265 (2026-10-19, "Fix BUG-843: administrator names match with DOMAIN prefix, spaces and ") on rel-20261022m; no robot or Codex result recorded
1. **BUG-844** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix e7b2dc74 (2026-10-19, "Fix BUG-844: the Admin Dashboard skips one unreadable report file inst") on rel-20261022m; no robot or Codex result recorded
1. **BUG-845** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix affdf4dc (2026-10-19, "Fix BUG-845: Create bundle and Mark as Investigated catch a failed sav") on rel-20261022m; no robot or Codex result recorded
1. **BUG-846** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 13dd7478 (2026-10-20, "BUG-847 only: drop the BUG-846 salt half (superseded by the shared-cod") on rel-20261022m; no robot or Codex result recorded
1. **BUG-847** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 13dd7478 (2026-10-20, "BUG-847 only: drop the BUG-846 salt half (superseded by the shared-cod") on rel-20261022m; no robot or Codex result recorded
1. **BUG-848** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 905e2dd0 (2026-10-19, "BUG-848 PR: trimmed upload test and REGRESSION_LOG entry") on rel-20261022m; no robot or Codex result recorded
1. **BUG-849** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 742f36cb (2026-10-19, "Fix BUG-849: an online-only administrator list says not downloaded, no") on rel-20261022m; no robot or Codex result recorded
1. **BUG-850** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 705c261b (2026-10-19, "BUG-850 first half: a status-dot change rebuilds only the CE Tools tab") on rel-20261022m; no robot or Codex result recorded
1. **BUG-851** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 09cbed4a (2026-10-19, "Fix BUG-851: Disable on Restart leaves the pipe-object file and native") on rel-20261022m; no robot or Codex result recorded
1. **BUG-852** | OPEN | **3 installed, robot PASS, awaiting Codex** **(status line wrong)** | Structural half #1503 robot run 43 PASS; Manager half #1493 in C-57; Codex V5-02 saw CE_VERSION open About from Manager (window clipped = BUG-090)
1. **BUG-853** | OPEN | **3 installed, not yet tested** **(status line wrong)** | fix 513059cf (2026-10-19, "Fix BUG-853: ribbon click log kept to a fixed size, no drawing names") on rel-20261022m; no robot or Codex result recorded
1. **BUG-854** | FIXED (Codex-accepted, Civil 3.0.64, 20 Oct | **5 FIXED** | status line: FIXED (Codex-accepted, Civil 3.0.64, 20 Oct 2026)
1. **BUG-855** | OPEN | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-856** | FIXED (Codex-accepted, Civil 3.0.67, 21 Oct | **5 FIXED** | status line: FIXED (Codex-accepted, Civil 3.0.67, 21 Oct 2026)
1. **BUG-857** | OPEN | **1 OPEN, no fix** | question for Tim (what the X on the Grade mismatch box does)
1. **BUG-858** | OPEN (fix drafted, not installed, not | **3 installed, not yet tested** **(status line wrong)** | #1510 in Structural 1.0.121 (S-41, installed 22 Oct 14:26); the status line says "not installed" (wrong); Codex V9-01 NOT TESTED: clean 12-corner preview seen, placed outline unreadable
1. **BUG-859** | OPEN (seen in V4 and V5: | **4 installed, FAILS in AutoCAD** **(status line wrong)** | #1520 in Civil 3.0.70 (C-60); Codex V10-01 DIFFERENT SURE (22 Oct 21:14): still opens AutoCAD's Enhanced Attribute Editor; round 2 #1522 open
1. **BUG-860** | OPEN (found; no fix; needs the | **2 built, not installed** | PR #1521 open draft, not installed
1. **BUG-861** | OPEN (diagnosis by code reading started | **1 OPEN, no fix** | no fix; Codex V10-05 SEEN (22 Oct): BUG-861 remains open
1. **BUG-862** | OPEN (fix drafted by Sonnet job | **2 built, not installed** | fix drafted 22 Oct 23:22 by the Sonnet fix job; not on rel-20261022m
1. **BUG-863** | OPEN (fix drafted, same job) | **2 built, not installed** | fix drafted 22 Oct by the Sonnet fix job; not on rel-20261022m
1. **BUG-864** | OPEN (fix drafted, same job) | **2 built, not installed** | fix drafted 22 Oct by the Sonnet fix job; not on rel-20261022s2
1. **BUG-865** | OPEN (to review with BUG-859 round | **1 OPEN, no fix** | performance finding; to be reviewed with BUG-859 round 2 (#1522)
1. **BUG-866** | OPEN — Codex building on cx/ignore-undo-c60 | **2 built, not installed** | PR #1524 (Codex) open, not installed; the entry exists twice with two different status lines
1. **BUG-867** | OPEN (Codex build cx_b07_real_length_c60 queued 22 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-868** | OPEN (Codex build cx_b08_pipe_material queued 22 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-869** | OPEN (Codex build cx_b09_pit_floor_depth queued 22 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-870** | OPEN (Codex build cx_b10_move_pit_grade queued 22 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-871** | OPEN (Codex build cx_b11_twl_units queued 22 | **1 OPEN, no fix** | no fix commit or merged PR found on either installed branch
1. **BUG-872** | OPEN (Codex build cx_b06_eng_small_c60 queued 22 | **6 superseded** **(status line wrong)** | same red Glen Eira back-test as BUG-095 and BUG-307; carries the queued Codex build

---

## 2. Contradictions inside one entry, and misfiled evidence

1. **BUG-023:** the entry has 2 status lines that disagree (✅ Built 2026-05-19. Implemented in three / PARTIAL — 2026-05-20. Mechanics confirmed working).
1. **BUG-024:** the entry has 3 status lines that disagree (✅ Built 2026-05-19. 78 grade tests / PARTIAL — most issues fixed this / IN PROGRESS — coded 2026-05-20, awaiting).
1. **BUG-180:** the body says "Codex-accepted" for at least one part while the status line does not.
1. **BUG-195:** the body says "Codex-accepted" for at least one part while the status line does not.
1. **BUG-216:** the body says "Codex-accepted" for at least one part while the status line does not.
1. **BUG-351:** the body says "Codex-accepted" for at least one part while the status line does not.
1. **BUG-825:** the body says "Codex-accepted" for at least one part while the status line does not.
1. **BUG-861:** the body says "Codex-accepted" for at least one part while the status line does not.
1. **BUG-866:** the entry heading appears 2 times (lines 11699, 11709).
1. **BUG-168:** the Status Summary table row says "IN PROGRESS — source fix in" but the entry says "FIXED for CDGRIPDIAG — Tim confirmed".
1. **BUG-162:** the Status Summary table row says "OPEN — stale check, not lost" but the entry says "FIXED — 2026-09-23 (test only: PR".
1. **BUG-074:** the Status Summary table row says "IN PROGRESS (2026-07-03) — coded, tests" but the entry says "IN PROGRESS (2026-07-03) — CODED (pure".
1. **BUG-001:** the Status Summary table row says "OPEN — C confirmed ✓ T19" but the entry says "FIXED (C only) — 2026-05-20; CR/MR".
1. **BUG-002:** the Status Summary table row says "FIXED 2026-05-13 — Tim confirmed "works" but the entry says "❌ STILL BROKEN — coded fix".
1. **BUG-005:** the Status Summary table row says "FIXED 2026-05-08 — ✅ T21 Pass" but the entry says "IN PROGRESS — coded 2026-05-08, awaiting".
1. **BUG-006:** the Status Summary table row says "FIXED 2026-05-08 — ✅ T20 Pass" but the entry says "IN PROGRESS — coded 2026-05-08, awaiting".
1. **BUG-008:** the Status Summary table row says "FIXED 2026-05-13 — Tim confirmed." but the entry says "IN PROGRESS — coded 2026-05-12, awaiting".
1. **BUG-009:** the Status Summary table row says "FIXED — 2026-05-20 (T17 ✓). Mirror-related" but the entry says "FIXED — 2026-05-20.".
1. **BUG-031:** the Status Summary table row says "IN PROGRESS — coded 2026-05-21 (round" but the entry says "IN PROGRESS — coded 2026-05-20 (Batch".
1. **BUG-141:** the Status Summary table row says "FIXED IN SOURCE — 2026-09-15 (REGRESSION_LOG" but the entry says "FIXED (Codex-accepted, both halves, Civil 3.0.65,".
1. **BUG-100:** the Status Summary table row says "typed A CONFIRMED by Tim 2026-09-14" but the entry says "typed A CONFIRMED by Tim 2026-09-14".
1. **BUG-861:** holds two misfiled paragraphs: a Codex V8 result for BUG-505 and a Codex V10 result for BUG-859; copy them to those entries.
1. **BUG-207:** status says "Codex-accepted for Structural 1.0.116" but this is the Civil Pit Schedule bug; the 14 Oct evidence is on Civil 3.0.49.
1. **BUG-195:** one entry holds BUG-195 to BUG-201; BUG-196 to BUG-201 have no heading of their own, so a search for them finds nothing.
1. **BUG-858:** status says "fix drafted, not installed"; #1510 has been installed in Structural 1.0.121 since 22 Oct 14:26.
1. **BUG-825:** status line OPEN while the body records the step-iron half as FIXED (Codex-accepted, 21 Oct).
1. **BUG-516:** status line OPEN while the body says FIXED (Codex-accepted, Civil 3.0.65, 20 Oct).
1. **BUG-164:** status says waiting for Tim while the body records a Codex-accepted pass 17.
1. **BUG-160:** status says ON HOLD (PR #352 not merged) while PR #354 and the part 2 commits are installed.
1. **BUG-001:** status says FIXED (C only) while CR and MR are handed to Tim: two bugs in one entry.
1. **BUG-014:** status says FIXED and "awaiting Tim's AutoCAD confirmation" on one line (BUG-015 and BUG-016 the same).

## 3. Duplicates and one-family groups

1. **BUG-095, BUG-307, BUG-872:** the one failing Glen Eira back-test (GE 24-115); keep BUG-095 as the engineering record, the queued Codex build sits on BUG-872.
1. **BUG-354, BUG-402:** the start-up line "CE_StrucPlus LISP not found"; keep BUG-402 (the desk edit of ce_suite_startup.lsp).
1. **BUG-435, BUG-455, BUG-562:** the start-up lines; BUG-435 Civil half is fixed, the remaining "; error: syntax error" line is BUG-562.
1. **BUG-192, BUG-256, BUG-558, BUG-861:** REDO lost after U; BUG-192 and BUG-256 are the old family, the open cases are BUG-558 (drawing switch) and BUG-861 (freshly opened drawing).
1. **BUG-248, BUG-258:** OOPS after erasing a perimeter drain loses the PD text; BUG-258 records the BUG-248 fix not working; keep BUG-258.
1. **BUG-393, BUG-406:** old metre-drawing records read 1000 times short; BUG-393 remainder fixed by #666, BUG-406 holds the leftovers.
1. **BUG-007 and BUG-017, BUG-022, BUG-023:** batch umbrellas whose open parts moved to their own ids (named in the per-bug list).
1. **BUG-436, BUG-440 and BUG-061:** Codex W25 and W29 result records for the BUG-061 re-import check.
1. **BUG-488 and BUG-552:** both cover CEMANAGERDIAG writing the real Windows login; BUG-552 adds the Civil fault text and the Desktop support zip.
1. **BUG-489 and BUG-847:** both cover the support-zip cleaner missing client names; BUG-847 (AppData and Temp) is fixed and installed, BUG-489 (names without .dwg, folder and PDF paths) has no fix.
1. **BUG-166, BUG-430, BUG-859, BUG-860:** one family: a double-click opens AutoCAD's own editor instead of CE's window (IL text, pit label, downpipe, DP label); separate objects, keep all four.
1. **BUG-141, BUG-372, BUG-816:** one family: the "no clear spot (on the block Drawing Border)" line; BUG-141 is accepted, BUG-816 (line prints with Tidy labels OFF) is still open.
1. **BUG-750 and the CEMEMBER design:** SBEAM inner flange lines: superseded by Tim's CEMEMBER design (18 Oct).

## 3b. Entries whose wording still asks Tim to test

Tim does no testing (his 20 Oct rule: robot PASS plus Codex PASS). These 102 entries still say "awaiting Tim's test", "Steps for Tim" or similar. Proposed rewording for each: replace the Tim step with "Robot then Codex check:" and keep the steps.

BUG-014, BUG-015, BUG-016, BUG-020, BUG-021, BUG-024, BUG-025, BUG-026, BUG-027, BUG-028, BUG-029, BUG-030, BUG-031, BUG-032, BUG-033, BUG-034, BUG-035, BUG-036, BUG-037, BUG-038, BUG-041, BUG-042, BUG-050, BUG-051, BUG-052, BUG-058, BUG-060, BUG-070, BUG-071, BUG-072, BUG-073, BUG-074, BUG-075, BUG-077, BUG-078, BUG-079, BUG-080, BUG-094, BUG-101, BUG-102, BUG-105, BUG-106, BUG-127, BUG-128, BUG-129, BUG-130, BUG-131, BUG-132, BUG-133, BUG-134, BUG-135, BUG-136, BUG-137, BUG-138, BUG-139, BUG-140, BUG-142, BUG-143, BUG-144, BUG-145, BUG-146, BUG-147, BUG-160, BUG-161, BUG-162, BUG-163, BUG-164, BUG-165, BUG-166, BUG-167, BUG-189, BUG-190, BUG-191, BUG-192, BUG-193, BUG-194, BUG-203, BUG-204, BUG-223, BUG-230, BUG-233, BUG-238, BUG-239, BUG-240, BUG-242, BUG-243, BUG-244, BUG-245, BUG-246, BUG-247, BUG-248, BUG-249, BUG-250, BUG-251, BUG-252, BUG-253, BUG-402, BUG-448, BUG-459, BUG-460, BUG-469, BUG-856

A further 158 status lines end "Never FIXED until Tim confirms in AutoCAD" or "Not fixed until Tim confirms". That rule changed on 27 Sep (Codex-accepted also counts); the replacement lines in section 4 drop it.

---

## 4. Ready-to-apply status-line replacements (427)

One block per bug: `@@ BUG-NNN (snapshot line L, reason)`, then `-` the exact old line and `+` the new line. "(no status line)" means insert the new line before the entry's closing `---`. FIXED lines are only proposed where the evidence column shows a Codex PASS or Tim's word.

```
@@ BUG-002 (line 7599, accepted but not marked FIXED)
- **Status:** ❌ STILL BROKEN — coded fix insufficient. CRITICAL: daily-use task.
+ **Status:** FIXED — 2026-05-13 (Tim confirmed "works for now"; a rare residual case is parked pending a repro; reconciled 23 Oct 2026 from the Status Summary table)
@@ BUG-005 (line 7652, accepted but not marked FIXED)
- **Status:** IN PROGRESS — coded 2026-05-08, awaiting AutoCAD Monday test
+ **Status:** FIXED — 2026-05-08 (Tim checklist T21 Pass; reconciled 23 Oct 2026 from the Status Summary table)
@@ BUG-006 (line 7666, accepted but not marked FIXED)
- **Status:** IN PROGRESS — coded 2026-05-08, awaiting AutoCAD Monday test
+ **Status:** FIXED — 2026-05-08 (Tim checklist T20 Pass; reconciled 23 Oct 2026 from the Status Summary table)
@@ BUG-007 (line 7756, does not name the surviving id)
- **Status:** PARTIAL — 9 ✅ Pass, 4 ❌ still failing (callout west BUG-111, CDEDIT callout needs retest, CDFALL direction needs block edit, TEXTEDIT), 2 ⏭ Skipped pending STRUC suite
+ **Status:** OPEN (umbrella record only; open parts tracked as BUG-002, BUG-011, BUG-012; reconciled 23 Oct 2026)
@@ BUG-008 (line 7682, accepted but not marked FIXED)
- **Status:** IN PROGRESS — coded 2026-05-12, awaiting AutoCAD test 241
+ **Status:** FIXED — 2026-05-13 (Tim confirmed; reconciled 23 Oct 2026 from the Status Summary table)
@@ BUG-011 (line 7802, says OPEN with no word of the installed fix)
- **Status:** OPEN — deferred to next update after v2.0 ship 2026-05-12.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #367; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-012 (line 7828, says OPEN with no word of the installed fix)
- **Status:** OPEN — first attempt reverted 2026-05-12 (commit `ca4f5aad`). Deferred to v2.0.1.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #367; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-014 (line 7862, says FIXED but only "awaiting" a test)
- **Status:** FIXED — 2026-05-13 (commit `13fc5acb`). Awaiting Tim's AutoCAD confirmation.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via code carried from before the monorepo import; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-015 (line 7889, says FIXED but only "awaiting" a test)
- **Status:** FIXED — 2026-05-13. Awaiting Tim's AutoCAD confirmation.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via code carried from before the monorepo import; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-016 (line 7919, says FIXED but only "awaiting" a test)
- **Status:** FIXED — 2026-05-13. Awaiting Tim's AutoCAD confirmation.
+ **Status:** OPEN (superseded by the CD window redesign, see the Status Summary row; reconciled 23 Oct 2026)
@@ BUG-017 (line 7945, does not name the surviving id)
- **Status:** PARTIAL — 2026-05-20. Tim confirmed T23 / T24 / T25 ✓; T22 surfaced a new regression where a PIT placed inside or right after CD rotates by itself in a rotated UCS. New entry BUG-035 captures the regression.
+ **Status:** OPEN (T23 to T25 Tim-confirmed; the rest is tracked as BUG-035; reconciled 23 Oct 2026)
@@ BUG-022 (line 8073, does not name the surviving id)
- **Status:** PARTIAL — 2026-05-20. Tim confirmed middle FWs ✓. End and corner FWs still need additional inward insets (50 mm for ends, 25 mm in each direction for corners) — captured as BUG-028, fixed in this batch. Fall-arrow restyle to QLeader (`25DIMS` style) deferred as BUG-029.
+ **Status:** OPEN (middle FWs Tim-confirmed; rest tracked as BUG-028 and BUG-029; reconciled 23 Oct 2026)
@@ BUG-023 (line 8106, does not name the surviving id)
- **Status:** ✅ Built 2026-05-19. Implemented in three pieces:
+ **Status:** OPEN (mechanics Tim-confirmed; UX parts tracked as BUG-030 to BUG-034; reconciled 23 Oct 2026)
@@ BUG-050 (line 8940, says FIXED but only "awaiting" a test)
- **Status:** FIXED 2026-06-09 — awaiting Tim's AutoCAD confirmation.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via code carried from before the monorepo import; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-062 (line 7137, says OPEN with no word of the installed fix)
- **Status:** OPEN.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #365; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-064 (line 7159, says OPEN with no word of the installed fix)
- **Status:** OPEN.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #366; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-065 (line 7171, says OPEN with no word of the installed fix)
- **Status:** OPEN.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #368; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-067 (line 7193, says OPEN with no word of the installed fix)
- **Status:** OPEN.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #363; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-076 (line 7305, says OPEN with no word of the installed fix)
- **Status:** OPEN (2026-07-03) — building alongside/after BUG-075.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via commit 509dc431; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-090 (line 8792, does not say it still fails)
- **Status:** SOURCE COMPLETE — exact combined candidate `8ac6a9cde1467a3e83eedb6a20aae4a9fa6b86a7`, tree
+ **Status:** OPEN (fix installed; still fails in real AutoCAD: Codex V5-02 DIFFERENT, 22 Oct 2026, rows clipped; reconciled 23 Oct 2026)
@@ BUG-100 (line 9518, accepted but not marked FIXED)
- **Status:** typed `A` CONFIRMED by Tim 2026-09-14 10:05 AEST on b312bf0f (the CDSTRIP preview accepted). The remaining doubled keyword list on the vertex prompt is tracked as BUG-101.
+ **Status:** FIXED — 2026-09-14 (Tim confirmed the typed A on b312bf0f; the doubled keyword list is BUG-101; reconciled 23 Oct 2026)
@@ BUG-158 (line 7071, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #347; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-160 (line 7041, says not installed or on hold; the fix is installed)
- **Status:** ON HOLD (28 Sep ~20:10) - PR #352 stays draft, NOT merged. Opus review DO-NOT-MERGE: (1) the "typed" flag is unreliable: pressing OK in Pipe Edit marks BOTH levels typed whenever the boxes are filled (`PipeEditCommand.Update.cs` ~1398-1399, ~1515-1516), even a level CE calculated or a diameter-only save, so after any Pipe Edit save the pipe would freeze its bottom level (this flag bug also affects master: the record refuses updates while plan text changes, widening the original symptom); (2) keeping the typed value with a message is the Claude proposal Tim SUPERSEDED on 23 Sep - he wants to see both numbers and pick; (3) the message repeats on every later update; (4) wrong grade in the message on cross-plan breaklines. **Next:** fix the typed flag first (only a level the user actually changed is typed); then design the pick step as a workflow card (a grip drag cannot stop to ask mid-drag, so the choice has to come at the end of the move, e.g. a small preview window) and ask Tim. Stop-gap question queued for Tim.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #354, #391; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-164 (line 6928, accepted but not marked FIXED)
- **Status:** IN PROGRESS — installed 23 Sep 12:18; Codex saw three clean closes; **waiting for Tim to confirm in AutoCAD**
+ **Status:** FIXED — 2026-09-29 (Codex-accepted, pass 17 B5; reconciled 23 Oct 2026)
@@ BUG-165 (line 6898, says not installed or on hold; the fix is installed)
- **Status:** IN PROGRESS — fix merged 23 Sep 2026 (PR #92, `c1d0b7db`; Manager tests 233/233); not installed on Tim's PC yet
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #92; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-166 (line 6878, says not installed or on hold; the fix is installed)
- **Status:** IN PROGRESS — fix merged 23 Sep; not installed; Codex re-runs B-L1 after the install; then Tim confirms
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #107; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-169 (line 6705, accepted but not marked FIXED)
- **Status:** IN PROGRESS — CODE COMPLETE, MERGED, AND ALREADY INSTALLED; only Tim's AutoCAD confirmation is outstanding. **PR #163** (`claude/struc-layer-restore`, tip `8d382ec0`, base `claude/struc-d1-prep`) merged 25 Sep 2026 — native commands now run REVCLOUD/MLINE inline via `Editor.Command` instead of the deferred `Document.SendStringToExecute`, and one shared helper (`LegacyToolCommon.RestoreCurrentLayer`) puts back the layer the drafter was on (only if it still exists and isn't frozen), used by RC, SFC/SFCT/SFCB/BSFC/BSFCT/BSFCB and the generic `CommandExecutionService.RestoreState` every other CeTextService command already runs through; CML's Enter-repeat fixed the same way (no layer change). **Installed on Tim's PC 25 Sep 18:19 as Structural `1.0.75+838f95ee`** (register #78) and still live in every later cumulative train off `struc-d1-prep` (confirmed present through at least `1.0.80`, 28 Sep) — this is not a pending deploy.
+ **Status:** FIXED — 2026-09-30 (Codex-accepted, pass 18, mostly; RC Undo part tracked as BUG-215; reconciled 23 Oct 2026)
@@ BUG-174 (line 6651, says not installed or on hold; the fix is installed)
- **Status:** IN PROGRESS — built, MERGED to master, not yet installed/Tim-confirmed. **PR #177** (`claude/bug-174-ce-tag-in-prompts`, merge commit `61b97c96`, merged 2026-09-24) — verified again 2026-09-28 by a fresh builder dispatched to fix this bug: the fix is already on `origin/master`, no further code change needed. `CivilDesignCommand.cs` (CDDESIGN's storm-report offer, the council-from-job-folder offer, both `AskYes` call sites), `SourceDestinationCommand.cs` (CDDEST's "record destinations" ask) and `PipeCrossingSplitService.cs` (the shared `AskOnce` helper) all carry the tag-free wording — confirmed by reading the current source; every remaining "[CE]" in Drainage/Manager is inside a plain `WriteMessage` line, never inside a keyword prompt's message. The general source guard added by that PR, `KeywordPromptBracketTagGuardTests.KeywordPromptMessages_CarryNoBracketTagThatIsNotARealKeyword` (`Modules/Drainage.Tests/Commands/KeywordPromptBracketTagGuardTests.cs`), still passes on current master: re-run 2026-09-28 on net10.0-windows with real AutoCAD 2027 (native `CE_TRANSFORM_2027.arx` built first) — 1/1 passed. Drainage (net48/net8.0-windows/net10.0-windows) and Manager (net48/net8.0-windows/net10.0-windows) both build 0 errors. Never mark fixed until Tim confirms in AutoCAD (his steps below).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #177; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-175 (line 6635, says not installed or on hold; the fix is installed)
- **Status:** IN PROGRESS — built, MERGED to master, not yet installed/Tim-confirmed. **PR #179** (`49ea9be0`, merge commit `25a6503a`, merged 2026-09-24) — verified again 2026-09-28 by a fresh builder dispatched to fix this bug: the fix is already on `origin/master`, no further code change needed. The true type is resolved once via `PipeTruthResolverService.ResolvePipeContext`, before `AnalyzeAttachmentState` (reverse-arrow) and `HydrateContextFromAttachments` (destination) run; the crude local `TryGetPipeTypeFromLayer` in `PipeEditCommand.DataCollection.cs` is deleted (confirmed absent from that file by search — it survives only as `PipeTruthResolverService`'s own internal fallback, which is fine per the fix brief). Full write-up: `REGRESSION_LOG.md` "BUG-175" (2026-09-24), including two dedicated test fixtures (`PipeEditCommandDataCollectionTests`, `PipeEditCommandDataCollectionOrderTests` — one is a literal source guard against the crude guess ever coming back). Builder's report: 3 lanes 0 errors; focused Pipe/PipeTruth/PipeEdit tests 2402 passed / 4 failed (pre-existing window-fit/DPI baseline, unrelated) / 6 skipped. Never mark fixed until Tim confirms in AutoCAD (his steps below).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #179; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-176 (line 6617, says not installed or on hold; the fix is installed)
- **Tim's ruling (UX-SRC-05, 26 Sep, via the V3 plan discussion chat):** "cdrg and dp are not pipe dependent if anything they are similar to pits which in most cases get placed prior to pipes connecting them" - none of the three options; the premise was wrong. CDRG and DP place anywhere, like pits, before any pipe exists; pipes drawn later connect TO them the way they connect to pits (auto-join UX-PIPE-02b). **Status:** OPEN - diagnostics only in **draft PR #251** (b26695d4); build to Tim's ruling queued. Also needs PR #249 (N8 read-back fix) before any inlet can land in a drawing like DWG-B. Never mark fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #346, #631, #656; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-180 (line 6504, says OPEN with no word of the installed fix)
- **Status:** OPEN (fix queued)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #296, #298; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-189 (line 6362, accepted but not marked FIXED)
- **Status:** IN PROGRESS (28 Sep evening) - Civil fix BUILT, draft PR #350 (`09e15a4a`, on top of timing PR #349): CE refreshes only the objects an edit touched at idle (full re-read kept as a logged safety net above 200 objects, after Undo/Redo, on open, or on error); the double back-to-back re-read removed; draw order re-applied only to touched objects; the endless idle save retry replaced by a proper document lock; Structural idle log only on idle/active changes. NOT changed: schedule-cell refresh (no index yet) and the start-of-command project sync (both still full passes; next round). Builds 0 errors (Civil + Structural, both lanes); full Civil net10 12,117 passed / 8 failed (known AddSystemCommand/Boyd family). Independent Opus review running. Structural speed fix builder running. Not installed, not tested in AutoCAD.
+ **Status:** FIXED — 2026-09-30 (Tim's word 29 Sep plus Codex pass 18 timing; reconciled 23 Oct 2026)
@@ BUG-190 (line 6310, accepted but not marked FIXED)
- **Status:** IN PROGRESS (28 Sep ~22:00) - PR #357 (`5c845164`) review fixes done: close now locks the drawing (Undo irrelevant at close) and marks it modified so the save prompt appears; autosave (.sv$ / unlocked) skipped; warning logged if a flush fails; net10 OutsideCommandUndoPolicy 43/43. Being combined into Civil 3.0.12 tonight; Codex pass 17 Part Q4 tests it.
+ **Status:** FIXED — 2026-09-29 (Codex-accepted, pass 17 Q4; reconciled 23 Oct 2026)
@@ BUG-191 (line 6290, says not installed or on hold; the fix is installed)
- **Status:** IN PROGRESS (28 Sep ~23:00) - built, draft PR #359: the button now runs a hidden command CDUSEPLANLABEL (one named Undo, no lock outside a command); guard test that no Inspector button takes a lock; Inspector tests 188/188, full Civil net10 no new failures. Banked for the next install (not in 3.0.12). Needs a light review first.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #359; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-192 (line 6270, does not name the surviving id)
- **Status:** OPEN (reproduce cleanly first).
+ **Status:** OPEN (tracked under BUG-256, BUG-558 and BUG-861; reconciled 23 Oct 2026)
@@ BUG-193 (line 6250, accepted but not marked FIXED)
- **Status:** IN PROGRESS (29 Sep ~05:30) - built, draft PR #362: the schedule treated a typed SIZE as a pending 'override' before the resize check ran, so the resize never fired and the cell blanked. SIZE now always goes straight to the same resize route PITEDIT uses. PitSchedule tests 531/531 both lanes. Note: builder's full-suite count (12,132 total, 5 failures) differs from the usual 12,231 / 7 - the next install gate re-checks by name. Banked for the next install.
+ **Status:** FIXED — 2026-09-30 (Codex-accepted, pass 18, ordinary pit only; P6 900 x 900 case not tested; reconciled 23 Oct 2026)
@@ BUG-194 (line 6232, says not installed or on hold; the fix is installed)
- **Status:** IN PROGRESS (29 Sep ~13:30) - fixed, draft PR #380: `CivilSelectionClassifier.ClassifyEntity` decided the tab by object type (any polyline = pipe; any non-pit block = source). Now it uses CE ownership like the Inspector (C7 pipe object / CE pipe record or data; twin barrels only with a real CE owner; a block is a Source only with CE's source tag). Pits still recognised by block name. CE_SHARED untouched. Watch: older downpipe blocks without CE's source tag will no longer bring up the Source tab. Banked for 3.0.14.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #380; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-195 (line -, no status line)
- (no status line)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #385; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-203 (line 5740, says not installed or on hold; the fix is installed)
- **Status:** OPEN (29 Sep 20:30) - built, draft PR #393 (`claude/bug203-quiet`, base rel-20260929c; one helper `ProjectDataService.HasCivilContent` used at open registration, `ReevaluateCivilActivity` and `IsCeOwnedDrawing`; empty record no longer written into a quiet drawing; focused 87 pass; full Civil net10 7 failures = the known 7; PR files verified). Opus review REQUIRED (LinkService, ProjectDataService). One existing test line changed (`CivilQuietModeTests` source-text guard: the string names `HasCivilContent(db)` instead of `IsDrawingActive(db)`; same rule, controller checked; Opus to confirm). Not tested in AutoCAD. Known gap: a CE pipe/pit object with NO project record at all is not detected at open (no model-space scan allowed); it wakes Civil at the next Civil command.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #393; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-204 (line 5758, says not installed or on hold; the fix is installed)
- **Status:** OPEN (29 Sep 23:10) - built, draft PR #399 (`claude/bug204-dedupe`, base rel-20260929c-struc). Root cause: the three rule lists start seeded with defaults and every load APPENDED the saved file onto them (about 24 per start); commit 34d8a295 had only fixed tie-down types. Fix: replace on load; remove exact duplicates on every load/save; nothing distinct is ever dropped; no cap. Sonnet review enough. Overlaps #392 in UserSettings.cs (same train). Back up Tim's CS_Settings.json before installing. Not tested in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #399; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-205 (line 5782, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18; not triaged for a fix).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #404; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-208 (line 5856, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #410; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-209 (line 5878, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #411; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-210 (line 5900, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #417; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-211 (line 5924, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #415; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-212 (line 5948, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #419; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-214 (line 5994, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex sweep C1; root cause Unknown).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #416; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-215 (line 6018, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #418; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-216 (line 6047, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #416; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-217 (line 6069, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #417; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-218 (line 6092, accepted but not marked FIXED)
- **Status:** OPEN (30 Sep 2026, found by Codex pass 18).
+ **Status:** FIXED — 2026-10-14 (Codex-accepted, narrow PASS on Structural 1.0.116; reconciled 23 Oct 2026)
@@ BUG-219 (line 6116, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex sweep C1).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #497; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-220 (line 6140, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex sweep C1).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #465; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-221 (line 6168, accepted but not marked FIXED)
- **Status:** OPEN (30 Sep 2026, found by Codex sweep C1).
+ **Status:** FIXED — 2026-10-19 (Codex-accepted, look L3-01a and L3-01b; reconciled 23 Oct 2026)
@@ BUG-223 (line 5722, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~08:05) - filed from the Opus review of #404; fix after #404 merges (lane F, next).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #404, #422; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-226 (line 5504, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex sweep C1).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #624; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-227 (line 5526, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex sweep C1).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #625; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-228 (line 5548, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep 2026, found by Codex sweep C1).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #622; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-230 (line 5696, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~08:50) - after #411 merges (lane F, Opus builder: calculation path).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #421; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-231 (line 5708, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~08:50) - carparked; fix together with the BUG-224 Codex probe result.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #636; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-232 (line 5682, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~09:00) - lane F after #409 merges.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #423; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-233 (line 5670, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~09:10) - lane F (calculation output: Opus review required).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #420; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-234 (line 5656, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~10:10) - lane F after #410 merges.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #645; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-236 (line 5632, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~10:20) - carparked.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #426; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-237 (line 5642, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~10:20) - carparked.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #428; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-239 (line 5409, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~10:35) - lane F, after #420 merges (stacked on its resolver). Calculation-adjacent wording: Opus review required.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #420, #629; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-242 (line 5381, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~10:55) - lane F, after #421 merges.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #635; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-243 (line 5395, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~10:55) - lane F.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #633; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-244 (line 5353, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~11:10) - lane F, after #422 and #410.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #410, #422, #654; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-246 (line 5337, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~11:25) - lane F, after #423 merges. Needs a small record of skipped cells (persistence: Opus review).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #658, #807; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-248 (line 5309, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~12:20) - lane F, after #426; do it together with BUG-237 (both are "OOPS restores the object, not its link/label"): reactor-adjacent, Opus review.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #426; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-250 (line 5273, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~12:50) - lane F after #428; first read whether the linking-on branch is reachable at all.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #466; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-251 (line 5259, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~14:50) - lane F after #433; add `psdAriBySiteCase` and `tcMinutesBySiteCase` to the profile model; needs a Tim card for the pre-development C rule.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #433, #803; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-252 (line 5245, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~15:50) - lane F after #434; needs Tim's roughness values (Stormpro, CMP) on the Settings page (R-00).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #632; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-253 (line 5231, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~16:05) - lane F after #437 merges; small.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #648; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-254 (line 5217, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~19:50) - verify first (Opus), then fix; Opus review required (native protection).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #469; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-255 (line 5201, says OPEN with no word of the installed fix)
- **Status:** OPEN (30 Sep ~19:50) - after #437 merges; Opus review required (engineering result).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #437, #470; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-256 (line 5185, does not name the surviving id)
- **Status:** OPEN - the top blocker (1 Oct 04:20). UPDATE 2 Oct 00:20: Codex control D (plain AutoCAD 2027, ALL CE bundles off, `CODEX_VERIFYC4D_2026-10-01.md`): plain AutoCAD keeps REDO only in the plain baseline (LINE, U, REDO) and LOSES it after U + wheel zoom + typed -PAN (with or without an automatic save), U + switch drawing tab and back, U + 136 s idle with an automatic save, U + hatch pick (native Hatch Editor ribbon), U + QSAVE. Those sequences (Codex A1c, A2 open g, A3, A4) are NATIVE AutoCAD behaviour, NOT a CE fault: drop them from CE re-tests. What is left for CE: the pick / copy / edit cases proven working in 3.0.18 stay as the pass list. Final closing waits for Tim's confirmation in AutoCAD.
+ **Status:** OPEN (general case passed Codex W35; residual REDO cases tracked as BUG-558 and BUG-861; reconciled 23 Oct 2026)
@@ BUG-257 (line 5157, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #442; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-258 (line 5141, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20) - the train fix did not work in AutoCAD; diagnose (Opus).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #443; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-259 (line 5129, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20) - check the job mode first.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #448; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-261 (line 5103, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #444; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-262 (line 5091, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #454; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-263 (line 5075, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #446; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-264 (line 5059, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20) - Codex window/ribbon item.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #456; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-266 (line 5035, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 04:20) - measure against the previous install (3.0.15) first.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #450; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-267 (line 5021, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 05:00) - measure first (Codex), then mirror the #443 approach.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #443, #460; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-268 (line 5009, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 05:00)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #444, #460; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-269 (line 4995, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 09:40)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #458; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-270 (line 4983, says not installed or on hold; the fix is installed)
- **Status:** IN PROGRESS (1 Oct 09:50): draft PR #453 (head 777845f3) built and unit-tested only, Opus review running, not yet in AutoCAD
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #453; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-271 (line 4969, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 09:50)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #470; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-273 (line 4917, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 12:00). Not a regression: with BUG-272 fixed (#455) it fires only on a real file problem.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #455, #467; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-274 (line 4901, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 12:40).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via commit cb17de15; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-275 (line 4953, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 11:55)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #464; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-277 (line 4873, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 11:50)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via commit 060fbd6c; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-278 (line 4861, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 12:15)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #469; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-279 (line 3052, says OPEN with no word of the installed fix)
- **Status:** OPEN (filed 1 Oct about 12:10 by the PC clock; an earlier stamp here read 18:40 by mistake). Updated 1 Oct 12:50 after the Opus review of #464: only the palette is fixed there; the footing lookup is item 0 above.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #471, #476, #480; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-281 (line 4835, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 13:00)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #491; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-282 (line 4823, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 13:00)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #470; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-283 (line 4811, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 13:00)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #489; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-284 (line 4799, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 13:00)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #489; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-285 (line 4787, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 15:10)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #490; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-289 (line 4745, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 15:10)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #492; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-290 (line 4735, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 16:05)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #473; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-292 (line 4713, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 16:05)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #437; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-299 (line 4637, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 19:55)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #493; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-302 (line 4615, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 21:25)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #495; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-303 (line 4605, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 21:25)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #494, #510; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-305 (line 4585, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 22:55)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #501; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-306 (line 4575, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 22:55)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #501, #638; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-307 (line 4565, does not name the surviving id)
- **Status:** OPEN (1 Oct 23:15)
+ **Status:** OPEN (duplicate of BUG-095; current fix work under BUG-872; reconciled 23 Oct 2026)
@@ BUG-308 (line 4553, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 23:25). Route (a)(b) with BUG-270/287, (c) to a CDDESIGN persistence builder, (d) ask Tim.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #497; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-309 (line 4543, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 23:55).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #503; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-312 (line 4513, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 23:55).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #503; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-313 (line 4503, says OPEN with no word of the installed fix)
- **Status:** OPEN (1 Oct 23:55).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #503; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-314 (line 4481, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 00:30).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #505; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-315 (line 4469, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 00:30).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #506, #509; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-316 (line 4457, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 00:30).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #504; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-317 (line 4493, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 00:40). Opus CONFIRM of #502 (2 Oct 03:10, MERGE at 84ff3116) leaves two traps: (a) typing a size in Edit Pit on a scaled pit that is NOT a units change (unitless drawing at 0.001, metre drawing at 0.002) still writes the number as drawing units (900 gives a 900 m pit): today's behaviour kept on purpose; (b) CDREBUILD's "not changed" line gives the wrong "block's own size" for pits scaled up 1.0 to 1.78 times (from #497's linework check including the wall). Added 2 Oct 01:00 from the Opus review of #497: (4) an offered council accepted from the job folder or letters, then Close, is silently not kept (no "not saved" line); (5) areas taken from the STORM report are saved by Save Draft as if typed, so where they came from is lost on reopen; (6) the Manager version guard (`ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets`) has been red since the missing `PrepareReleaseCandidateRoot` target; (7) two IL-shape tests (FinalLandingProducer..., RefusedNativeCallback...) fail on the base tip in a Debug build and are not on the known-failure list.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #497, #502; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-318 (line 4447, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 00:40).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #644, #649, #677; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-322 (line 4407, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 02:20).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #626; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-323 (line 4397, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 02:20).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #491, #507; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-324 (line 4387, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 02:20).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #507; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-325 (line 4377, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 02:20).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #507; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-328 (line 4357, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 02:36). Builder assigned (metre-unit sweep).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #508, #513; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-329 (line 4347, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 02:36).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #626; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-330 (line 4337, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 03:00). Opus review of #507 (2 Oct 03:20, MERGE-WITH-FIXES) adds: CDCALC prefill and Design Review read pit-to-pit distance as millimetres (`PipeGeometryHelper.TryComputePipeLengthM`): 1000 times short in metre drawings; tidy-up lines in metre drawings say "moved 1175 mm" (unit of that figure not checked); the CDPIPEOBJ message and the detention window / Pit Schedule charged main / imported-level review still unconverted. KEY FINDING already routed to the builder: CE pipe OBJECTS (every pipe CD draws on Tim's PC) have no MLINE band, so a units lookup through `MlineId.Database` falls back to mm.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #627; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-331 (line 4327, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 03:15). C-6 FINALIZER (2 Oct 06:40, GO at b4e075d8) adds: (1) a Pit Schedule edit in a "UNITS Metres, drawn in mm" drawing writes the plan label grade 1000 times too big (e.g. 1 IN 100000) after #508 (3.0.20 was right there by accident): the closed list says no hold pass is open there but one is; the writer just doesn't ask it (decision: user-started, agreed scope; PR #516 holds Edit Pipe Save and CD in mixed drawings but not this one); (2) CD's optional same-plan break end margin is 1 drawing unit (`CdCommand.SamePlanBreak.cs:85`, pre-existing); (3) the Pit Schedule pipe sync re-places the main label with mm offsets every time (pre-existing); (4) the `Services.P` tests (2,042) pass but the test host never exits when run as one chunk (also on base 266959ec): split it; (5) installer test `ManagerReleasePayload_HasTrackedManifestAndThreeLaneLocalAssets` fails with "no PrepareReleaseCandidateRoot target" (pre-existing). REAL OFFICE DRAWINGS ARE MILLIMETRE (Codex C5 saw INSUNITS 4 on DWG-B with 600 mm pit blocks): the mixed case matters only for templates Tim answers on. Opus CONFIRM rounds 2 and 3 of #508 (2 Oct 05:10): round 2 found `UpdateLinkedPipeGrades` unheld (fixed in c33ec47b); round 3 found the NATIVE STRAIGHT-PIPE EDIT route (STRETCH/LENGTHEN/TRIM/EXTEND/grip stretch/plain MOVE of a pipe: `NativeEdits.cs:368`) still rewriting length and grade text from the 1000x length in Metres-UNITS drawings drawn in mm (builder fixing, last round); LOW: a split triggered by placing or landing a source rewrites detention label lengths without the hold; one pass's decision comes from the first pipe's pits (mixed metre-scaled and mm pits). Earlier: Opus CONFIRM of #508 (2 Oct 04:15, MERGE-WITH-FIXES at e78efbc2, one fix with the builder: hold the label too): (MED) a Metres-UNITS drawing drawn in mm with NO sized CE pit block gives the guard no evidence (the 1000x reading goes ahead); (MED) in such drawings CD drawing and Edit Pipe Save still write "1 IN 100000" and "10000.00m"; (LOW) `LinkService.PitRelinks.cs:237` fixed 1.0 drawing-unit tolerance (1 m in a metre drawing); (LOW) the approved repair proposal's grade gained CD's rounding nudge in mm drawings. Opus review of #508 first round (2 Oct 03:40, MERGE-WITH-FIXES) adds: (HIGH) existing METRE jobs may already hold pipes the OLD grade lock FLATTENED (bottom reset to top on a pit move): nothing finds or repairs them (needs a repair command: in a command, one Undo, one line per pipe); (HIGH) a Metres-UNITS drawing drawn in mm gets 1000x lengths in every BUG-328 writer (builder adds a hold-and-warn guard); (HIGH) `TryApplyDetentionLengthConstraint` MovePit moves the end pit about 1000x too far in a metre drawing; (MED) Unitless drawings drawn in metres still flatten grade-locked pipes on a pit move; (MED) `DetentionCalcViewModel.GetEntityLength` 1000x too small in metre drawings; (MED) `SplitHalfRule.cs:187-199` rewrites "NN.NNm DETENTION" and `DetentionRequiredLength` from raw drawing units; (LOW) five more unfolded grade-rule copies (`InvertPropagation:1080`, `LevelsProposalEngine:813`, `UpstreamDownstreamSuggest:117`, `ProfileRouteEvidence:713`, `CdCommand:536`).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #516, #646; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-332 (line 4317, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 04:00).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #512; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-333 (line 4307, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 05:50). Item 1 goes to an Opus builder with the other S-4 adversarial HIGHs (S-5).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #536, #539, #541; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-334 (line 4297, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 05:50). Items 1-3 go to an Opus builder (S-5 batch with BUG-333 item 1).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #521, #522, #532; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-335 (line 4287, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 06:00). Items 1-3 to the S-5 builder (a40464c119283a752), 4-6 if time.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #529, #530, #531; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-336 (line 4275, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 07:30).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #523, #524, #525; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-337 (line 4265, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 10:50). Passed to the C-6 adversarial reviewers (a436397e83dff8b13) and the next Codex run.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #508; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-339 (line 4243, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 11:15). Opus builder started (claude/c7-batch-apply-cell).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #538; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-341 (line 4223, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 11:30). Items 1-4 (+5 if cheap) to Opus builder af1089cfa4ac7b0fd on `claude/rel-20261005s`.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via commit 1bf49237; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-342 (line 4213, says OPEN with no word of the installed fix)
- **Status:** OPEN (2 Oct 11:15). Items 1, 2, 5 and the LOWs to Opus builder (claude/c7-paste-ownership); ARRAY and drag-and-drop are Codex observations first.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #567; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-344 (line 4189, says OPEN with no word of the installed fix)
- **Status:** OPEN, queued for S-7. Decision recorded (decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md INT-026). Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #542, #547; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-346 (line 4167, says OPEN with no word of the installed fix)
- **Status:** OPEN, carpark. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #549, #591, #592; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-347 (line 4155, says OPEN with no word of the installed fix)
- **Status:** OPEN (observations). Codex waits for the Wed 7 Oct 20:52 reset (87%). Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via commit 5704b6ae; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-348 (line 4143, says OPEN with no word of the installed fix)
- **Status:** OPEN. Not fixed until Tim confirms in AutoCAD. PR head has since moved to 2d4a330f: the stage-2 assembler must merge the head and then claude/s7-opus-fixes and an Opus confirm follows.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #545; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-349 (line 4129, says not installed or on hold; the fix is installed)
- **Status:** OPEN. Items 1-4 are being fixed on claude/s7-s5s6-review-fixes (Opus builder a0c2f39c9169b2911, draft PR, base rel-20261005s) for the S-7 train; item 5 is a design note only. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #546; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-350 (line 4117, says OPEN with no word of the installed fix)
- **Status:** OPEN. Items 1-6 and PR #543 are in Opus builder ab3dca0d34ffd4f33's train C-8 (branch claude/c8-probe-fixes, base rel-20261006d). Items 7-11 carpark. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #550, #551; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-351 (line 4105, says OPEN with no word of the installed fix)
- **Status:** OPEN. Opus review of #548 running (a34208ea7350930ed). Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #660, #670, #805; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-352 (line 4081, says OPEN with no word of the installed fix)
- **Status:** OPEN. Codex checks (35 steps) are in section 5 of the report and feed verifyC8. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #553, #554; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-353 (line 4069, says OPEN with no word of the installed fix)
- **Status:** OPEN. Codex checks: the six in the PR body + read P3's inlet after batch Apply on IO8 -> P3 (18.10 or 18.29?); ERASE the array: labels left with no pit?; row P3 outlet 17.30: label still 1 IN 193? Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #577, #582, #589; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-354 (line 4057, does not name the surviving id)
- **Status:** OPEN (LOW), nothing changed. Not fixed until Tim confirms.
+ **Status:** OPEN (duplicate of BUG-402; reconciled 23 Oct 2026)
@@ BUG-355 (line 4035, says OPEN with no word of the installed fix)
- **Status:** OPEN (observations). Re-run S-05, S-06, S-07, C-03, C-04 after a modern pipe fixture. Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #555, #639; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-356 (line 4045, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW-MED). Candidate for the Team build worker (Manager). Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #556; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-357 (line 4021, says OPEN with no word of the installed fix)
- **Status:** OPEN (3 = MED to confirm). Driver plan updated with the exact one-line commands. Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #557; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-358 (line 3999, says OPEN with no word of the installed fix)
- **Status:** OPEN. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #558; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-360 (line 3072, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW-MED). Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #560, #1296; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-362 (line 3950, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW). Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #562, #563; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-363 (line 3936, says OPEN with no word of the installed fix)
- **Status:** OPEN. 10 driver/Codex checks in the report. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #561; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-364 (line 3924, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW wording bug). Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #561; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-365 (line 3906, says OPEN with no word of the installed fix)
- **Status:** OPEN. Candidates: Team build worker (Structural/Civil names), Settings Enter-saves question for Tim via the desk. Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #578, #579, #580; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-366 (line 3886, says OPEN with no word of the installed fix)
- **Status:** OPEN. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #567; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-367 (line 3088, says OPEN with no word of the installed fix)
- **Status:** OPEN. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #568; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-368 (line 3866, says OPEN with no word of the installed fix)
- **Status:** OPEN (MED). Team build worker job 46 items 16a/16b. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #558, #569; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-369 (line 3852, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW). Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #571; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-370 (line 3836, says OPEN with no word of the installed fix)
- **Status:** Structural 1.0.94 proofs done; LOW items open. Not accepted until Tim confirms.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #570, #571; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-372 (line 3818, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW). Team build worker (Civil, with other wording items). Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #572, #587, #1440; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-375 (line 3770, says OPEN with no word of the installed fix)
- **Status:** OPEN (items 1 and 2 are tidy-ups; not Tim-facing).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #601; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-376 (line 3744, says OPEN with no word of the installed fix)
- **Wanted:** the schedule falls back to the level the plan shows at that pipe end (the same figure the pipe's own invert text uses) when no stored level exists; never invent a level; if neither exists the cell stays blank with its plain-English reason. Settings-first, no hard block. **Status:** OPEN. Fix to Team build/02 (read first). Not fixed until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #584; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-377 (line 3750, says OPEN with no word of the installed fix)
- **Command / Area:** a raw `\U+2192` text shows in one warning line (driver run 17, Civil 3.0.26). An escaped arrow code instead of the arrow (or 'to') in a user-read line: find the string, print the plain word. **Status:** OPEN, LOW. Wording; no behaviour change. Not Tim-facing until located.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #583, #599, #609; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-378 (line 3756, says OPEN with no word of the installed fix)
- **Command / Area:** open of a drawing holding old pipes: the FIRST open of the FIX copy and of DRV17_B1 did not upgrade the old pipe polylines ("2 pipe objects"), a later fresh open of the same copy printed "49 pipe(s) upgraded to CE pipe objects" with a backup beside it (51 objects after). C4 was repeated on the upgraded state with the same result. Driver run 17. Cause unknown (the upgrade runs on open/draw/demand: maybe a timing race with the first drawing activation, or the driver's open route). **Status:** OPEN, LOW until reproduced. Next driver session: open once, check the pipe object count at once, then wait 10 s and check again.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #602; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-380 (line 3734, says OPEN with no word of the installed fix)
- **Status:** OPEN. Not accepted until Tim confirms.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #585; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-381 (line 3704, says OPEN with no word of the installed fix)
- **Command / Area:** Structural Foundations manager (FST / Foundations Manager): opening and closing it marks the drawing modified. Desk driver run 18 on installed Structural 1.0.95 (3 Oct, `DRIVER_RUN18_2026-10-03.md`): DBMOD goes 1 -> 5 across open + close, nothing edited. Same family as the Edit Pipe Cancel DBMOD finding (BUG-373, fixed by #581); a read-only window should leave the drawing unmodified. **Status:** OPEN (to Team after run 52; failing test first). Not Tim-facing yet.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #586; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-382 (line 3710, says OPEN with no word of the installed fix)
- **Command / Area:** FST status line (Structural 1.0.95): the plain line still ends with a log tail `elements=4 orphans=0 generated=4 issues=0 reason=PFC:PF4` (driver run 18). Plain-English rule: no log words in user-read lines. **Status:** OPEN, LOW wording.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #597; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-383 (line 3696, says OPEN with no word of the installed fix)
- **Command / Area:** a fresh open of a drawing marks it modified (Structural 1.0.96 loaded). Desk driver run 19 (4 Oct ~00:05, `DRIVER_RUN19_2026-10-03.md`): DBMOD already reads 1 shortly after every fresh open, BEFORE FST or any CE command is typed; so something writes at open (an object-level write: a CE/AutoCAD reactor, xdata, a layer or settings record). Not the Foundations manager: the BUG-381 proof holds on installed Structural 1.0.96 (open+close of the Foundations manager, Cancel, FREGEN, FREGENALL, FPFC, FDELETE, ERASE, Regenerate All never took DBMOD to 4 or 5; it reached 5 only after the agent's own -LAYER setup lines). Find which object or system variable changes at open (headless probe on a copy, with only Structural loaded, then Civil+Manager loaded). **Status:** OPEN, LOW. Not Tim-facing yet. (BUG-381 proof: PASS in driver run 19; still not Tim-accepted.)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #593; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-384 (line 3688, says OPEN with no word of the installed fix)
- **Command / Area:** Edit Pipe / batch write with the pipe layer LOCKED (desk driver run 20, installed Civil 3.0.27, 4 Oct ~00:50, `DRIVER_RUN20_2026-10-04.md`, item C6): the batch is refused with "label records do not match" and NO mention of the lock. Expected (BUG-364 style): a plain line saying the pipe layer is locked and nothing was changed ("Unlock it to edit, CE will not unlock it for you"). Wording only; no behaviour change (the refusal and the untouched drawing are correct, native locked-layer rule kept). **Status:** OPEN, LOW wording (to a Team sweep).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #589, #603, #611; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-385 (line 3672, says OPEN with no word of the installed fix)
- **Status:** OPEN, to Team (read-first, next round). Not accepted; not fixed.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #612, #617, #667; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-387 (line 3658, says OPEN with no word of the installed fix)
- **Command / Area:** CLAYER reads nil after a Pit Schedule Revert / U sequence (Codex verifyW5 W5-02, 4 Oct 03:1x, installed Civil 3.0.27; `CODEX_VERIFYW5_2026-10-04.md`, evidence `VERIFYW5\screenshots\W4-02-end-clayer-nil.png`). The OSMODE/CLAYER/DBMOD line was (5375 "BLOCKS" 17) at the start and after the edit; at the END of the item, after PITSCHEDULE -> cover edit -> Revert Row Override -> U (echo "PITSCHEDULE") -> PITSCHEDULE again, it read **(5375 nil 21)**: CLAYER nil. No layer was locked or set by the tester. Not isolated (which of Revert, U or the second PITSCHEDULE). The final U/reopen restored the row count to 30. A `(getvar "CLAYER")` returning nil is unusual; it may be a read made while AutoCAD was in a state where the variable could not be read (a document/transaction that ended with an error), or a real loss of the current layer. Needs a headless reproduction with the fixture (FIX_MODERN_PIPE_W1.dwg): same sequence, CLAYER before/after each step. **Status:** OPEN, to Team (read-first); the #604 fix (record bound to the drawing) may already change it.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #604, #683; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-388 (line 3650, says OPEN with no word of the installed fix)
- **Command / Area:** FDELETE question prints `[Yes/No]` TWICE on one line (desk driver run 21, installed Structural 1.0.98, 4 Oct ~04:35; `DRIVER_RUN21_2026-10-04.md`): `Delete footing system 'Footing Network' and its 4 footings? [Yes/No] <No>` shows the keyword hint twice. LOW wording (to build/02, one-line fix: AutoCAD adds the [Yes/No] hint itself, so the CE prompt text must not). **Status:** OPEN.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #619, #628, #647; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-389 (line 3642, says OPEN with no word of the installed fix)
- **Command / Area:** CDCHECK list on the COMMAND LINE still prints a raw `AGI\U+2192C1` for old pipe names (desk driver run 22, installed Civil 3.0.28, 4 Oct ~04:55; `DRIVER_RUN22_2026-10-04.md`, item C7): the saved list FILE has the real arrow, the command-line copy shows the escape text (BUG-377 family: an escaped arrow in a user-read line). Print "to" / ASCII "->" on the command line. LOW wording. **Status:** OPEN (to build/03 or build/04).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #634; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-390 (line 3636, does not name the surviving id)
- **Status:** result record; W6-03 to redo as W7 (Yes at the delete question) after the next installs.
+ **Status:** OPEN (Codex W6 result record; each finding is tracked under its own BUG id; reconciled 23 Oct 2026)
@@ BUG-393 (line 3587, says OPEN with no word of the installed fix)
- **Command / Area:** four places still read a METRE-drawing record saved before BUG-331 as 1000 times too short (found by the C-16 Opus finalizer, 4 Oct 09:28, `TRAIN_C16_FINALIZER_REPORT.md` item 5; not listed anywhere else in the carpark): `ProposalApplyService.PlanBuilders.cs:560` (CDRUNSOLVE's own solve), `PipeSizeNetworkReviewService.cs:608`, `NetworkRedesignDrawingProjector.cs:381`, `PitRenumberNetworkBuilder.cs:119`. Same family as BUG-330 / the dashboard "Fix all" invert fix (ProposalApplyService.cs:777). After train C-16 the invert write uses the true length, so CDRUNSOLVE on such a job now labels its near-flat levels honestly ("1 IN 100000") where 3.0.29 showed a misleading "1 IN 100" (the levels written are the same either way). **Fix:** read the pipe length through the same unit-aware helper the new code uses; tests first (a metre record, an old saved record); Team build/03 or build/04, read-first. **Status:** OPEN (MED, pre-existing, metre jobs only).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #659, #666; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-394 (line 3120, says OPEN with no word of the installed fix)
- **Command / Area:** CSREOBAR questions "Number of bars <8> <8>" and "Spacing (mm) <200> <200>" still print the default TWICE (desk driver run 26, 4 Oct ~10:40; `DRIVER_RUN26_2026-10-04.md`, installed Structural 1.0.100; BUG-388 / BUG-391 family: the keyword/default is printed by CE and again by AutoCAD). LOW wording. To Team build/02 (run 65 has it). **Driver run 26 (the last driver AGENT session for these lists; wedged early by the agent's own Enter-repeat test that left SFC at "Enter SF number:"; a quit -Kill test kill, one unclean-exit entry about 10:07 expected): 4 PASS, 0 FAIL, 3 BLOCKED, 15 NOT TESTED.** PASS roof-down: wind class (lists/defaults once, saved Hill top / Escarpment or ridge, Enter keeps saved), BEXTEND (list once, "at its end/start", plain refusal), CSREOBAR bar size / face lists once, SFC (MLINE on STRIP FOOTINGS scale 300, CLAYER back to 0). Not run: every footing-units case and all of C-16 (moved to Codex W8). **Status:** OPEN.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #686; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-395 (line 3581, does not name the surviving id)
- **Status:** result record. Re-run as W9 (separate budget day) with the brief fixed (FSF prompts, FPFC prompts, selection-preserving COPYCLIP).
+ **Status:** OPEN (Codex W8 result record; each finding is tracked under its own BUG id; reconciled 23 Oct 2026)
@@ BUG-396 (line 3563, says OPEN with no word of the installed fix)
- **Status:** OPEN (items 2-6 to the Team; 1 and the S-18 first checks to Codex W9).
+ **Status:** OPEN (fixes installed; item 1 still fails in real AutoCAD: Codex look L4-08 DIFFERENT, 19 Oct 2026; reconciled 23 Oct 2026)
@@ BUG-397 (line 3541, says OPEN with no word of the installed fix)
- **Command / Area:** Manager CE.Host load list (reviewer run 87, REVIEWLANE_LOG 584-586, 4 Oct 15:54): **#684 LOW 2** and #677 each carry a DIFFERENT wrong list of what the Manager loads (CE.Host's load list); Team build/03 run 19 is making ONE correct list (Manager list fix #684/#677). Filed so the item cannot be lost. To verify at the Monday C-18 train: the Manager status page's 'N of M installed CE tools running' and its load line must match what is really loaded in AutoCAD (Civil, Manager, Structural, AutoCADLink, Transform); Installer.Tests to be run once after both PRs (reviewer note). **Status:** OPEN (Team build/03 r19).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #670, #684; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-401 (line 3519, does not name the surviving id)
- **Command / Area:** Civil New Pit: cover level after a restart (Codex W9d W9-08, 4 Oct 19:31, installed Civil 3.0.31). Two pits placed (cover 21.00, then 12.340); CD_Settings.json stayed byte-identical (SHA256 ACD64E79..., 15,270 B, 08:22:30: **#638 PASS on that part**). `CD_RecentValues.json` (4,071 -> 4,072 B) holds `"coverLevel": "12.340"`, `"addCoverText": true`, `"coverTextPosition": "BR"` (I read the file). But after closing AutoCAD and reopening FIX_MODERN_PIPE_W1.dwg, PIT at 18000,-90000 opened New Pit P13 with the **cover box EMPTY**, warning 'Enter the cover level.' and 'Unknown. Cover text is on, but every text field is blank.' It did not propose 12.340. **Question for Tim (via desk):** should New Pit propose the last cover level, or is a blank cover (drafter must type it) the intended rule because a cover level belongs to one pit? If proposing is wanted: the value is saved but not read back into the window. **Status:** DECIDED 5 Oct (Tim, INT-059/060): New Pit cover after restart stays BLANK (default); #705/#715 keep the choice; no code change needed for the default. Other W9d results: W9-04 typed C2 reached the window (fields showed C2 and 21.00) but the brief's Esc-twice zoom cancelled the label prompts, plan label not verified; W9-06/W9-07 PASTECLIP showed no insertion-point prompt (test-driving problem, retest needed with typed point on the command strip).
+ **Status:** WONT FIX — Tim ruled 5 Oct 2026 (INT-059/060) that the New Pit cover stays blank after a restart; no code change needed (reconciled 23 Oct 2026)
@@ BUG-402 (line 3513, says OPEN with no word of the installed fix)
- **Command / Area:** AutoCAD start-up message (Codex W9d, 4 Oct 19:31): the command line prints '[CE_StrucPlus] LISP not found: C:\ProgramData\Autodesk\ApplicationPlugins\CE_STRUCPLUS.bundle\Contents\CE_StrucPlus.lsp' although no CE_STRUCPLUS bundle is installed (leftover loader reference). Noise for every drafter at start-up. Codex build bj6 item N-2 (4 Oct 19:40) looks for the printer; if it lives outside the repo (old autoload) it is reported. Also seen: four '[CE] Background not found: <xref> Type CDXREFREPAIR' lines when returning to the Civil fixture (xref paths in the fixture, expected). **Status:** AWAITING TIM CONFIRM (5 Oct 01:40: desk commented out line 76 of ce_suite_startup.lsp with Tim's yes, backup .bak-20261005-before-strucplus-removal beside it; check the next AutoCAD start is clean). UPDATE 4 Oct 19:40 (Codex bj6): the printer is OUTSIDE the repo: Tim's own support file ce_suite_startup.lsp in his AppData Roaming Autodesk AutoCAD 2027 R26.0 enu Support folder (acad.lsp loads it; line 76 calls the retired StrucPlus loader). Editing it needs Tim's separate authorisation (desk to ask), or the installer should own that file.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via code carried from before the monorepo import; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-405 (line 3481, says OPEN with no word of the installed fix)
- **Command / Area:** report privacy (S-19 Opus finalizer, 5 Oct 09:55). (1) PR #662 (Structural reports hash the user and computer names like Civil) leaves two fields of the machine report unscrubbed: `SourceRoot` and `StatusSummary` (AdminTelemetryService.cs:182, Structural): a colleague whose CE assets folder sits under OneDrive would have their Windows login in that field. (2) Civil is worse and is OLD code outside every train: its machine report's FILE NAME still carries the real login and computer name (Modules/Drainage AdminTelemetryService.cs:263). **Fix:** scrub or hash both fields in Structural and the Civil file name the same way. **Status:** OPEN (LOW-MEDIUM privacy; Team).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #748, #757; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-406 (line 3485, says OPEN with no word of the installed fix)
- **Command / Area:** old METRE drawings (C-18 Opus finalizer, 5 Oct 09:30). #666 fixed two of the six readers of an older metre record; four are STILL on the old reading (length 1000 times too short): `MarkupToChangePlanService.cs:229`, `:281`, `:373` and `GetProjectNetworkTool.cs:177` (the #659 review's other readers `RulebookEngine.cs:72` and `RuleFixPlanner.cs:42` are the two #666 fixed). The four are the markup-to-change plan and the AI project-network tool: not reachable by a drafter's normal commands today (markup/AI lanes), but they will give wrong grades on an old metre job. **Fix:** read each pipe length through the same unit-aware helper, test with a metre-saved record (0.020 for a 20 m pipe). **Status:** OPEN (MEDIUM; Team or Codex).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #666; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-407 (line 3489, says OPEN with no word of the installed fix)
- **Command / Area:** Structural CSFDNPROPOSE (PR #678, hidden OFF command), found by S-19 assembly 5 Oct 08:55: on top of #686 it fails three guards: `EveryClassWithACommandMethod_IsListedAsACommandClass` (FootingProposalCommands not registered with [assembly: CommandClass] in Plugin.cs, so AutoCAD would say Unknown command), and `EveryFoundationsKeywordQuestion_ShowsItsChoiceListOnce` + `NoOtherStructuralFile_SwitchesAutoCadsCopyOffItself` (FoundationService.Proposal.cs:142/:144: its 'accept which proposals' question switches AutoCAD's copy of the list off by hand instead of CeQuestion.OwnList). #678 was DROPPED from train S-19 (revert 6becb2a4). **Fix round for the Team:** register the class, use CeQuestion.OwnList, rerun after #686 is in. **Status:** OPEN (Team).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #738; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-408 (line 3475, says OPEN with no word of the installed fix)
- **Command / Area:** Pit Schedule 'Stop overriding' status sentence (#681, installed in Civil 3.0.32), Codex W10-03, 5 Oct 09:30: the menu item 'Stop overriding' is there and works (cover stays 18.82, row kept), the current layer is put back (CLAYER stayed BLOCKS after Close, U and reopening: #683 PASS part), but NO status sentence ('Stop treating this row as an override. The values you typed stay.') appeared anywhere in the captured window; the hover text could not be tested by Codex's tools. Either the sentence is only in the hover/status strip that Codex missed, or the status line is replaced by the header text. **To check:** a short driver or Tim's eyes; read the status line code in PitScheduleViewModel for the 'Stop overriding' command. Other W10 notes: W10-01 CEHEALTH printed a blank capture (IT-folder sentence not read); W10-02 placement log not fully captured (a second New Pit P13 window opened after the cover click) but no _Dot message and NOMUTT 0 throughout; W10-05 opened the wrong drawing (METRE-A grades unproven); the fixture's Pit Schedule is UNLINKED so #658's CURRENT/OUT OF DATE badge is unproven. **Status:** OPEN (observation; retest as W10b).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #758, #762, #763; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-409 (line 3465, does not name the surviving id)
- **Command / Area:** TEST INCIDENT on Tim's live Structural settings (Codex W11-03, 5 Oct 10:19): my W11 brief told Codex to answer ABFLIPAUTO 'ON' then 'OFF' assuming the setting started Off. The prompt showed `[ON/OFF] <On>` (Tim's own saved value is ON), so the pass ended with the setting OFF and the command itself saved `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json` (24,377 -> 24,378 bytes, SHA256 DA5B5B44B1F17C96... -> 7E9EF4FFF4720B8C...). The ORIGINAL file is copied aside by install 30: `C:\ce_rc_scratch\settings_pre_1030\CE_STRUC_SUITE_CS_Settings.json` (SHA256 starts da5b5b44b1f17c96 = the original hash). **Fix:** put the setting back to ON (run ABFLIPAUTO and answer ON, or copy the saved original over the live file with AutoCAD closed: needs the desk's/Tim's word because it is Tim's settings file). My brief error; future briefs must read the current value first and restore exactly that. **Status:** RESTORED 5 Oct ~10:50 by the desk (answer a): live file copied back from the saved original, 24,377 bytes, SHA256 DA5B5B44 = original; the changed copy kept as settings_pre_1030CE_STRUC_SUITE_CS_Settings.AFTER_W11_BUG409.json; only line that differed: SkipFlipPromptWhenAutoDetermined true -> false. Rule added to _CODEX_RUNNERbuilder_rules.txt (SETTINGS-WRITING COMMANDS RULE). Tim to be told by the desk.
+ **Status:** OPEN (test incident record; Tim's settings file restored 5 Oct; nothing to fix in the product; reconciled 23 Oct 2026)
@@ BUG-416 (line 3433, says OPEN with no word of the installed fix)
- **Command / Area:** Civil, small items from the C-19 finalizer (LOW): (1) right-click 'Select this run' straight after U, in a drawing whose CE record is not loaded yet, may lose REDO (rare; not reproduced); (2) the #731 test step in REGRESSION_LOG names 'CDSETTINGS' which does not exist: the Settings window command is CDS (controller fixes it in the C-19 Codex checklist); (3) the #705 test step is superseded by #731; (4) #667 open AutoCAD-only question: the save for drawing A runs while drawing B's command starts with no document lock on A (a lock clash is caught and retried at idle): Codex two-drawing test (edit a pit label in A, then at once in B) in block W14. **Status:** OPEN (LOW; W14).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #705, #1170, #1502; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-417 (line 3126, says OPEN with no word of the installed fix)
- **Command / Area:** NATIVE-PROTECTION BYPASS (HIGH), source audit 7 Oct (04_REFERENCE/release/SOURCE_AUDIT_2026-10-07.md, finding checked by me in the code): **CDIMPORTXCIVIL (X-Civil import, on the Civil ribbon) UNLOCKS locked layers**: `XcivilImportService.cs:1474-1501` `TemporarilyUnlockImportTargetLayers` sets `IsLocked = false` on about 13 named layers plus every pipe layer, writes, then relocks; `XcivilImportReportService.cs:602` erases earlier imported pits, pipes and labels. Only a debug line records the unlock. Breaks the rule 'never silently unlock'. **Fix needs a reviewed workflow (card): skip locked objects and say so, or ask once with a visible preview and explicit approval.** **Status:** OPEN (HIGH; Team; needs Tim's ruling on the import: ask/skip).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #765; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-418 (line 3130, says OPEN with no word of the installed fix)
- **Command / Area:** NATIVE-PROTECTION BYPASS (HIGH), source audit 7 Oct: **strip footing commands re-layer objects across the WHOLE drawing**: `CeTextService.cs:4301-4380`, run when SF, BSF or STRIPLAYERSMERGE starts, moves objects in EVERY block definition and erases old layers; failures are swallowed, so locked objects are skipped without telling the drafter. **Fix:** touch only the objects the command made, skip locked layers/Xrefs and say so. **Status:** RULED 7 Oct (INT-065, Tim: "some things are worth running in the background a layer tify up is one of those things if done properly"): the tidy-up STAYS in SF/BSF/STRIPLAYERSMERGE and runs quietly IF done properly: never touches locked-layer objects, Xref content or anything while REFEDIT is open; erases an old layer only when empty, unlocked and unused; speaks only when it skips (one plain line each); never swallows a failure. Draft #764 (build/02) does that: Opus review next, then S-22. BUG-417 (X-Civil import) is NOT decided by this: #765 stays DRAFT.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #764; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-420 (line 3140, says OPEN with no word of the installed fix)
- **Command / Area:** Pit Schedule window, bare pit number over an existing one (Codex W14-02, 7 Oct 22:20, installed Civil 3.0.33 with #723): `PITSCHEDULE` Rows, P1 selected, typed bare `2` (P2 exists), Enter: **the cell and the 'Selected pit' box showed `2`, the group header stayed P1, P2 stayed, and NO line appeared**: the C-19 finalizer expected '[CE] Pit number 2 is the same pit number as P2 (another pit), so this pit keeps P1...' and the row kept P1. Typing `p1` over P1 showed lower-case `p1` in the cell (expected: stays P1). Typing 77 did not change the cell at all in one attempt. **Possible causes:** the window's cell edit commits on another event than Enter (e.g. on leaving the cell or Close), or this unlinked-schedule fixture uses a path without the #723 check: needs a read of PitScheduleViewModel pit-number edit commit and a retest by Codex with Tab / click-away. **Status:** OPEN (FAIL, Team to read the code first).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #723, #766; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-422 (line 3152, says OPEN with no word of the installed fix)
- **Command / Area:** Civil Edit Pipe strip / pipe sizing (Settings rows plan, 8 Oct, `PipeSizingSolver.cs:365`): the solver treats a ground level of 0 or less as 'cover not assessed' and SKIPS the cover check, so an UNKNOWN ground level (stored/read as RL 0) lets the Edit Pipe strip say a pipe size 'works' with no cover check (a real ground level of exactly RL 0 is treated as unknown too). Related: unset cover treated as 600 mm, missing cover treated as 0 (cluster CL2 in SETTINGS_ROWS_PLAN_2026-10-08.md). **Fix:** Unknown stays Unknown and the strip says 'cover not checked' in plain words; keys for cover already exist. Also note from the plan: new Settings keys must NOT change the fingerprint of an unchanged job (the CDRULES 'Stale' marker fingerprints the whole DesignStandards object). **Status:** OPEN (MEDIUM, wrong 'works' answer; Team cluster CL2).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #769; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-423 (line 3158, says OPEN with no word of the installed fix)
- **Command / Area:** Opus finalizer of C-20 (8 Oct, TRAIN_C20_FINALIZER_REPORT.md), none block the install: **MEDIUM (release note, #722):** CDFIXFLATPIPES is NOT unchanged: with the new default 'no limit', a flattened pipe held at 1 in 5 is now offered with a 'steep ... check it' line where 3.0.33 said 'Check by hand' (the desk's reading of Tim's steep-pipe ruling, which was about the levels proposal): Tim should see it once. **MEDIUM (question for Tim, #745):** real names remain in three places: (1) old report files carrying the real login/computer name are KEPT (the log blames 'a Tim rule: never delete existing files' that the finalizer could not find; Structural deletes its own old real-named file: two rules for one thing); (2) the Manager report still has the real login and PC name INSIDE it; (3) support-bundle FILE NAMES still carry the real PC name. **LOW:** #740's window has no Undo button (its Undo fix is only reachable by one U after closing the window: takes back the whole Pit Schedule visit); the screen reader hears 'Last action' instead of the sentence; the steep and downpipe values are not on the Settings window yet messages tell users to look there; Edit Pit's refusal says 'press Update' but the button reads 'Save'; BUG-415 is NOT fixed by C-20 though the bug file says it would be; Civil and Manager must be installed together. **Status:** OPEN (Tim: release note + the three real-name places).
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #774; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-424 (line 3164, says OPEN with no word of the installed fix)
- **Command / Area:** S-21 Opus finalizer findings (8 Oct, TRAIN_S21_FINALIZER_REPORT.md; none blocks the install): (1) BTX with nothing picked: pressing Enter right away probably returns the same answer as an empty window, so it prints 'There is no TEXT or MTEXT in that window.' (the line quoted by earlier checklists says 'in that selection' and is effectively unreachable); it prints after Enter, following AutoCAD's '0 found'; (2) #759: the two footing-resize lines round differently (an inch-drawing 24-inch pad reads '609.6 x 609.6 mm' then '610 x 610 mm'); (3) STS1 on a support block on a locked layer prints raw '[CE_STRUC_SUITE] TS1 switch failed: eOnLockedLayer' (older than the train; nothing is unlocked or changed); (4) BT1: if the BRACING block fails to load the reason only shows with bracing debug on and goes nowhere in the CE log; (5) a login glued to letters/digits ('TimothyBrand2.dwg') is not hidden (Civil uses the same rule); (6) Tim's current Structural machine report says version '1.0.1.0' although 1.0.103 is installed (older, not investigated); (7) the real AutoCAD report folder is %APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox\machines ('admin-telemetry' is only a test-run folder): Codex briefs corrected. Civil's machine report on Tim's PC is still named with his real login and PC name until #745 (C-20) is installed. **Status:** OPEN (LOW; Team).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #778, #779, #780; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-425 (line 3174, says OPEN with no word of the installed fix)
- **Status:** OPEN. Filed 8 Oct 02:59 by the controller from the audit. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #783, #784, #811; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-426 (line 3182, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #786; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-427 (line 3194, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #789; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-428 (line 3211, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #787; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-429 (line 3221, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW, design question). Filed 8 Oct by the controller. Tim's file was NOT restored (no word from the desk or Tim).
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #799; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-430 (line 3233, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW-MED). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed; still fails in real AutoCAD with the double-click switch ON: Codex look L4-01a DIFFERENT, 19 Oct 2026; reconciled 23 Oct 2026)
@@ BUG-432 (line 3251, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM, advice only). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #809, #820; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-433 (line 3259, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #808; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-434 (line 3269, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #810; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-435 (line 3279, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #826; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-436 (line 3289, does not name the surviving id)
- **Status:** OPEN. Filed 8 Oct by the controller. BUG-061 NOT closed.
+ **Status:** OPEN (result record; tracked as BUG-061; reconciled 23 Oct 2026)
@@ BUG-437 (line 3297, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #810, #812; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-438 (line 3307, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #815; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-439 (line 3317, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #798; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-440 (line 3327, says OPEN with no word of the installed fix)
- **Status:** OPEN (zero-length pipe = Team item MEDIUM; BUG-061 closes only when Tim confirms). Filed 8 Oct by the controller.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #814; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-441 (line 3335, says OPEN with no word of the installed fix)
- **Status:** OPEN (release notes + Team items). Filed 8 Oct by the controller.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #794, #796; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-442 (line 3343, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM to confirm). Filed 8 Oct by the controller. Not fixed until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #816, #819; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-443 (line 3351, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOW). Filed 8 Oct by the controller.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #818; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-445 (line 3371, says OPEN with no word of the installed fix)
- **Status:** OPEN (#805 REDO proven in AutoCAD; marker layer, Edit Pipe removal still unseen). Filed 8 Oct by the controller.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via code carried from before the monorepo import; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-446 (line 3379, says OPEN with no word of the installed fix)
- **Status:** OPEN (MEDIUM). Filed 9 Oct by the controller.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #823; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-447 (line 3387, says OPEN with no word of the installed fix)
- **Status:** OPEN (end-matching cure = Team item). Filed 9 Oct by the controller.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #827; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-448 (line 3395, says OPEN with no word of the installed fix)
- **Status:** W39 (9 Oct 04:13) SEEN IN AUTOCAD on 1.0.109: C1 with a typed point and number 1 draws the column and the C1 label, no "DefaultValue is not set", no _Dot line; TS1 with number 2 draws TS2; Esc at the text prompt removes the half-placed column; one U / REDO takes the column and label together. Awaiting Tim's confirmation. Esc at the number question still needs Tim. Updated 9 Oct by the controller.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via code carried from before the monorepo import; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-449 (line 9526, accepted but not marked FIXED)
- **Status:** W40 (9 Oct 04:42 to 05:01, Structural 1.0.109, PASS 4, FAIL 0) re-ran the W39-02 case with the real prompts and it WORKS: bare Enter at the text question prints "Text placed at the right (CR1).", then "Enter a number to append to 'C' (or press Enter to exit):", number 2, "Specify insertion point:" 22600,300, then an extra "Top or Bottom [T/B] <T>:" (Enter) and the C2 label sits at the picked point; one U takes column and label together, REDO brings both back. A bare Enter at the number question exits and leaves the column without a label (by design, "or press Enter to exit"). After a remembered number the question reads "Enter text for 'C' or <2>:" and Enter accepts it. What is left is WORDING only: "Text placed at the right (CR1)." prints before the label is placed (S-27 carries #812 b7aaa225 for this step; the S-27 finalizer is tracing it). Filed 9 Oct by the controller; wording item stays OPEN. Never FIXED until Tim confirms in AutoCAD. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** FIXED — 2026-10-09 (Codex-accepted, W40; reconciled 23 Oct 2026)
@@ BUG-450 (line 9534, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOWs). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #848; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-452 (line 9552, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOWs). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #811, #1237; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-454 (line 9571, says OPEN with no word of the installed fix)
- **UPDATE 10 Oct 10:05, Codex W57 (item W57-03, read only): the pad labels PF5 and PF9 are TEXT on layer 25TEXT with height 2.5 mm; DIMSCALE 1.0, CANNOSCALE 1:1, INSUNITS 4, TEXTSIZE 2.5; at a zoom of 1500 in drawing units no legible label is visible next to the pad. So the cause predicted by the hunt is CONFIRMED: the label height is 2.5 x DIMSCALE (= 2.5 mm) and does not follow the drawing scale, so it cannot be read at plan scale. Fix = label height from the drawing scale through a Settings value (R-00).** **CODEX W51 ON STRUCTURAL 1.0.115 (Mon 12 Oct 03:04, sol, report CODEX_VERIFYW51_2026-10-12.md): the pad labels PF9 and PF5 are 2.5 mm high on 25TEXT with DIMSCALE 1: unreadable at a view height of 1500 (only a tiny white dot). Cause as the hunt predicted; still OPEN.** **Status:** OPEN (FSF Enter and FPFC label need a Team look; R1 needs a W45 with a third object). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #846; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-455 (line 9579, does not name the surviving id)
- **Status:** OPEN (start-up lines remain; #819 preview line to be looked at). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (duplicate; tracked as BUG-435 and BUG-562; reconciled 23 Oct 2026)
@@ BUG-456 (line 9587, says OPEN with no word of the installed fix)
- **Status:** OPEN (LOWs). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #827; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-457 (line 9595, says OPEN with no word of the installed fix)
- **Status:** OPEN (test gaps and unwalked routes; no defect found). Filed 9 Oct by the controller.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #870; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-459 (line 9611, says OPEN with no word of the installed fix)
- **CODEX W59b ON 3.0.48 (12 Oct 05:51): PASS, Edit Pit with 35TEXT locked is refused before any change (fix #1090). Awaiting Tim's confirmation.** **Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W50 will SEE it). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1090; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-460 (line 9619, says OPEN with no word of the installed fix)
- **CODEX W59b ON 3.0.48 (12 Oct 05:51): PASS, PIT with 35TEXT locked is refused before placing, no pit and no empty circle (fix #1090). Awaiting Tim's confirmation.** **Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W50 will SEE it). Filed 9 Oct by the controller from the Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1090; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-466 (line 9667, accepted but not marked FIXED)
- **UPDATE 10 Oct 10:05, Codex W57 on Structural 1.0.113 (CODEX_VERIFYW57_2026-10-10.md item W57-01 PASS): SEEN FIXED by Codex: FPFC with an already-used mark and Increment now asks for its OWN size; the new pad PF5 is 600 x 600, not PF9's 800 x 800 (PR #865, in 1.0.111). Not Tim-accepted.** **CODEX W51 ON STRUCTURAL 1.0.115 (Mon 12 Oct 03:04): DIFFERENT from the old fault. FPFC with the mark PF9 asked 'Enter X size' with no wrong inherited size; a second FPFC with the same mark became PF5 (auto-increment) and asked for sizes with a 600 mm default; the second pad came out 600 x 600. No silent inheritance of the 800 mm. Needs Tim to say this is the wanted behaviour (an existing mark gets the next free number).** **Status:** OPEN (found by reading code; not seen in AutoCAD yet; Codex W51 will SEE it). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** FIXED — 2026-10-10 (Codex-accepted, W57-01; reconciled 23 Oct 2026)
@@ BUG-468 (line 9683, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1203; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-504 (line 9978, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1272; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-505 (line 9986, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the second Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed; still fails in real AutoCAD: Codex V3b-04 FAIL 21 Oct, V8-01 DIFFERENT 22 Oct 2026; reconciled 23 Oct 2026)
@@ BUG-516 (line 10091, accepted but not marked FIXED)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the second Civil bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** FIXED — 2026-10-20 (Codex-accepted, V2b V2-03, Civil 3.0.65; reconciled 23 Oct 2026)
@@ BUG-518 (line 10118, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the cross-cutting bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1297; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-520 (line 10134, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the cross-cutting bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1312; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-521 (line 10142, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the cross-cutting bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1222; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-522 (line 10150, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the cross-cutting bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1165; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-523 (line 10160, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the cross-cutting bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1307; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-524 (line 10168, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the cross-cutting bug hunt. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1310; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-531 (line 10233, says OPEN with no word of the installed fix)
- **Status:** OPEN —15October2026; EBT now has scoped native evidence, the wider R00 label-height scope remains open.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1496; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-532 (line 10241, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Structural R-00 audit. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1227; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-542 (line 10327, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Civil R-00 audit. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1218; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-544 (line 10343, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the controller from the Civil R-00 audit. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1223, #1224; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-549 (line 10384, says OPEN with no word of the installed fix)
- **Status:** OPEN (HIGH; fix is build/02's first job; no change on Tim's PC today). Filed 9 Oct by the controller on the desk's request. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via commit d82424b9; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-551 (line 10400, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the carpark clerk from the off-PC calls audit (areas/release-v3-colleagues-OFF_PC_CALLS_2026-10-09.md, code read only at Structural 1.0.112 = 24238160 and Civil 3.0.43 / Manager 1.1.43 = e636e17d). Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #950, #951, #952; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-556 (line 10444, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the carpark clerk from the off-PC calls audit (areas/release-v3-colleagues-OFF_PC_CALLS_2026-10-09.md, code read only at Structural 1.0.112 = 24238160 and Civil 3.0.43 / Manager 1.1.43 = e636e17d). Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1169; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-557 (line 10455, says OPEN with no word of the installed fix)
- **Status:** OPEN (found by reading code; not seen in AutoCAD yet). Filed 9 Oct by the carpark clerk from the off-PC calls audit (areas/release-v3-colleagues-OFF_PC_CALLS_2026-10-09.md, code read only at Structural 1.0.112 = 24238160 and Civil 3.0.43 / Manager 1.1.43 = e636e17d). Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1171; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-558 (line -, no status line)
- (no status line)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #994, #1002, #1007; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-560 (line 10494, says OPEN with no word of the installed fix)
- **UPDATE 10 Oct 03:15, Claude driver run 5: NOT reproduced with TYPED pit centres (P10 54436.3,-69493.6 and P9 64028,-69576.4): New Pipe showed First end P10, Second end P9 and Start Pipe worked. So the fault is in how a pipe end is matched from a CLICK near or on a pit body (Codex clicked the pit bodies). Also from run 5: the 'Grade: FLAT (same inverts)' text (#819) was NOT in the window; with equal inverts a Design Warnings window opened ('Pipe is essentially flat, no measurable fall'); the held-grade marker was not seen (not clicked).** **Status:** OPEN (seen by Codex W48, cause unknown; the fixture copy may be at fault). W48-03, W48-04a and W48-04b remain NOT TESTED and must be re-queued after the cause is known. Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1244; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-565 (line 10558, says OPEN with no word of the installed fix)
- **ROOT CAUSE (Claude tester run 15, 10 Oct 10:55, AutoCAD closed, no Codex active; supersedes the two guesses above):** the pit NUMBER is an ATTRIBUTE inside the label block and the attribute DEFINITION is on layer 35TEXT (all 11 labels agree); the label block itself is on STORMWATER PIT LABEL; the cover text MTEXT is on 25TEXT; the pit is on STORMWATER PIT. PitAnnotationLockRule checks only the middle two (label block layer and cover text layer), so with 35TEXT locked there is no up-front refusal, and the write of the attribute then fails. The Pit Schedule theory is NOT needed. FIX TARGET: the resolver reads the layer of the attribute definition (not another fixed name) and includes it in the pre-check of PIT and of Edit Pit (NEXT_FIXES 10:50).** **RE-SEEN ON 3.0.47 (Codex W59 on sol, Mon 12 Oct 02:20 to 02:45, report CODEX_VERIFYW59_20261012_0220.md, gpt-6.1-sol, Civil 3.0.47 / Manager 1.1.47 = C-37, which contains the #880 to #885 protections): W59-02 Edit Pit with 35TEXT locked (the layer the typed lookup measured for the P2 label): '[CE] Error during PITEDIT - see CE log for details.', no early refusal, schedule P2 stays 900 x 900. W59-03 PIT with 35TEXT locked: '[CE] Pit retained without its number label: the label could not be written safely.' (P97 placed, number missing). W59-04 and W59-05 with 35TEXT locked by name: the same two faults (Edit Pit error, P96 placed without a number). So the gap is unchanged on 3.0.47 and no train fixes it yet. W59-01 (#870, PIT during REFEDIT) PASS again. Settings files unchanged, SAVETIME put back, acad.exe gone. BUG-459 and BUG-460 stay open until this is fixed.** **CODEX W59b ON CIVIL 3.0.48 (Mon 12 Oct 05:30 to 05:51, sol, report CODEX_VERIFYW59b_20261012.md): the fix #1090 WORKS. With 35TEXT locked: Edit Pit refuses before any change, '[CE] The pit number is on locked layer 35TEXT (unlock it, then run the edit again). Nothing was changed. Your entries have been kept - correct them and press Save again.' (no Error during PITEDIT line, P2 and its schedule row stay 900 x 900); PIT refuses before placing: '[CE] Pit not inserted - layer '35TEXT' is locked. Unlock the layer, then run PIT or PP again.' (no pit, no empty circle). Items W59b-02 to 05 PASS, W59b-01 (REFEDIT) PASS. Left as it is: Edit Pit adding a label to a pit that has none still fails late (the Opus finalizer's note). Status: FIX BUILT AND INSTALLED (3.0.48), Codex PASS; NOT FIXED until Tim confirms in AutoCAD.** **Status:** OPEN (seen by Codex W58 on sol). Never FIXED until Tim confirms in AutoCAD.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1090; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-567 (line -, no status line)
- (no status line)
+ **Status:** OPEN (no fix on the installed builds; reconciled 23 Oct 2026)
@@ BUG-568 (line -, no status line)
- (no status line)
+ **Status:** OPEN (no fix on the installed builds; reconciled 23 Oct 2026)
@@ BUG-569 (line -, no status line)
- (no status line)
+ **Status:** OPEN (no fix on the installed builds; reconciled 23 Oct 2026)
@@ BUG-571 (line 3013, says OPEN with no word of the installed fix)
- **Status:** OPEN — confirmed export output defects; content/row-count route passed separately.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1289; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-573 (line 2968, says OPEN with no word of the installed fix)
- **Status:** OPEN — confirmed in real AutoCAD, MEDIUM review accuracy. No production code started.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1283; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-574 (line 2950, says OPEN with no word of the installed fix)
- **Status:** OPEN — MEDIUM readback consistency, confirmed in AutoCAD; no production code started.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via commit da006db6; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-575 (line 2935, says OPEN with no word of the installed fix)
- **Status:** OPEN — MEDIUM support/installation truth, confirmed in AutoCAD; no production code started.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1273; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-576 (line 2921, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1261; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-577 (line 2907, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1294; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-580 (line -, no status line)
- (no status line)
+ **Status:** FIXED — 2026-10-19 (Codex-accepted, look L3-01c; reconciled 23 Oct 2026)
@@ BUG-581 (line -, no status line)
- (no status line)
+ **Status:** OPEN (no fix on the installed builds; reconciled 23 Oct 2026)
@@ BUG-582 (line -, no status line)
- (no status line)
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1292; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-584 (line 10638, says OPEN with no word of the installed fix)
- **Status:** OPEN - reproduced in real AutoCAD14October2026.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1295; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-585 (line 10702, says OPEN with no word of the installed fix)
- **Status:** OPEN - reproducedinrealAutoCAD14October2026.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1270; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-587 (line -, no status line)
- (no status line)
+ **Status:** OPEN (no fix on the installed builds; reconciled 23 Oct 2026)
@@ BUG-588 (line 10706, says OPEN with no word of the installed fix)
- 1. **Status:** OPEN, MEDIUM; Civil3.0.49+48662ddd, personallyobserved14October2026; Claude ownscommand/reportbehaviour.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1271; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-589 (line 10714, says OPEN with no word of the installed fix)
- 1. **Status:** OPEN,HIGH; Civil3.0.49+48662ddd,personallyobserved14October2026; Claude ownsChecks reader/drawing-recordservice.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1266; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-592 (line 10750, says OPEN with no word of the installed fix)
- **Status:** OPEN — Codex real AutoCAD, 14 October2026, Civil3.0.49+48662ddd.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1274; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-605 (line 10919, says OPEN with no word of the installed fix)
- **Status:** OPEN — realAutoCAD2027/Civil3.0.49+48662ddd,15October2026.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1276; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-614 (line -, no status line)
- (no status line)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1278; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-615 (line -, no status line)
- (no status line)
+ **Status:** OPEN (no fix on the installed builds; reconciled 23 Oct 2026)
@@ BUG-616 (line -, no status line)
- (no status line)
+ **Status:** OPEN (no fix on the installed builds; reconciled 23 Oct 2026)
@@ BUG-617 (line -, no status line)
- (no status line)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1287; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-618 (line -, no status line)
- (no status line)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1294; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-619 (line -, no status line)
- (no status line)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1265; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-629 (line 11254, says OPEN with no word of the installed fix)
- 1. **Status/severity:** OPEN / MEDIUM. Actual AutoCAD2027/Structural1.0.116+f180,15October2026. Approved ST3-11 requires current model or paper space.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1285; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-632 (line 11286, says OPEN with no word of the installed fix)
- 1. **Status/severity:** OPEN / MEDIUM. Actual AutoCAD2027/Structural1.0.116+f180,15October2026. Dark model-space owned metric sample at1:100; both bubbles have filled right half.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1298; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-636 (line 11324, says OPEN with no word of the installed fix)
- 1. **Status/severity:** OPEN / HIGH. Actual AutoCAD2027/Structural1.0.116+f180,15October2026; approved ST3-12 forbids accidental whole-drawing conversion and requires unknown styles unchanged/reported.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1264; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-638 (line 11343, says OPEN with no word of the installed fix)
- 1. **Status/severity:** OPEN / HIGH. ActualAutoCAD2027/Structural1.0.116+f180,15October2026; approvedST3-12/14 and normalAutoCADprotection. AutoCAD continued; no crash or data-corruption claim.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1264; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-642 (line 11410, says OPEN with no word of the installed fix)
- **Status:** OPEN —15Oct2026;notfixed.
+ **Status:** OPEN (fix installed; still fails in real AutoCAD: Codex look L1-03b FAIL, 18 Oct 2026; reconciled 23 Oct 2026)
@@ BUG-643 (line 11431, says OPEN with no word of the installed fix)
- **Status:** OPEN —15Oct2026, native numerical defect.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1269; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-646 (line 11490, says OPEN with no word of the installed fix)
- **Status:** OPEN —15October2026; native current-setting leak.
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1282; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-649 (line 11516, says OPEN with no word of the installed fix)
- 1. **Status / priority:** OPEN / HIGH, misleading grade verdict. Observed16October2026 in real AutoCAD2027, Civil3.0.49+48662ddd. Approved UX-SURF-04 grade check; no full hydraulics requested. Claude owns behaviour.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1268; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-650 (line 11525, says OPEN with no word of the installed fix)
- 1. **Status / priority:** OPEN / HIGH, unexpected stored engineering-data change. Observed16October2026,realAutoCAD2027/Civil3.0.49+48662ddd. Claude owns behaviour. Related290(pre-question refresh writes) and574(derived bottom disappears after EditPit Save), but this is a separately evidenced CDFW Escape trigger.
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1263; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-652 (line 2822, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1317; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-653 (line 2810, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1317; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-654 (line 2798, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1317; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-655 (line 2786, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1317; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-656 (line 2774, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1379; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-657 (line 2762, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1378; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-659 (line 2738, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1322; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-660 (line 2726, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1333; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-661 (line 2714, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1329; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-662 (line 2702, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1330; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-663 (line 2690, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1331; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-665 (line 2666, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1328; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-666 (line 2654, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1328; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-667 (line 2642, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1336; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-669 (line 2618, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1334; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-670 (line 2606, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1337; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-671 (line 2594, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1337; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-672 (line 2582, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1337; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-673 (line 2570, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1332; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-674 (line 2558, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1326; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-675 (line 2546, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1318; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-676 (line 2534, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1324; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-677 (line 2522, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1323; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-678 (line 2510, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1318; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-679 (line 2498, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1326; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-680 (line 2486, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1323; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-681 (line 2474, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1434; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-682 (line 2462, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1435; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-683 (line 2448, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1437; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-684 (line 2436, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1321; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-686 (line 2412, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1320; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-687 (line 2400, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1319; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-688 (line 2388, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1327; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-689 (line 2376, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1327; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-691 (line 2352, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1335; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-694 (line 2316, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1325; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-695 (line 2304, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1331; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-696 (line 2292, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1331; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-697 (line 11544, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1338; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-698 (line 11558, accepted but not marked FIXED)
- **Status:** OPEN
+ **Status:** FIXED — 2026-10-20 (Codex-accepted, V2-04, Civil 3.0.64; reconciled 23 Oct 2026)
@@ BUG-699 (line 2280, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1352; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-700 (line 2268, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1375; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-701 (line 2256, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1369; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-702 (line 2244, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1362; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-703 (line 2232, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1371; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-704 (line 2220, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1361; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-705 (line 2208, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1374; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-706 (line 2196, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1376; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-708 (line 2172, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1360; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-709 (line 2158, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1352, #1438; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-711 (line 2134, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1342; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-712 (line 2122, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1344; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-713 (line 2110, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1342; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-714 (line 2098, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1342; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-715 (line 2086, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1346; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-716 (line 2074, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1349; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-717 (line 2062, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1348; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-718 (line 2050, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1347, #1351; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-721 (line 2014, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1380; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-722 (line 2002, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1363; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-726 (line 1954, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1357; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-727 (line 1942, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1377; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-730 (line 1906, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1354; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-731 (line 1894, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1356; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-732 (line 1882, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1356; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-733 (line 1870, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1353; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-734 (line 1858, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1368; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-735 (line 1846, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1367; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-736 (line 1834, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1359; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-737 (line 1822, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1366; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-738 (line 1810, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1365; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-739 (line 1798, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1373; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-740 (line 1782, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1355; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-741 (line 1770, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1355; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-742 (line 1749, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1358; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-743 (line 1737, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1345; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-744 (line 1725, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1343; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-745 (line 1713, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1345, #1350; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-746 (line 1699, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1372; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-747 (line 1687, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1364; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-748 (line 1659, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1498; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-753 (line 1603, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1387, #1388; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-754 (line 1591, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1388, #1389; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-758 (line 1535, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1407, #1408; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-767 (line 1409, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1433; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-768 (line 1395, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1421; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-769 (line 1381, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1427; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-770 (line 1367, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1424; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-772 (line 1339, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1428; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-773 (line 1325, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1432; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-777 (line 1269, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1411; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-779 (line 1241, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1410; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-780 (line 1227, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1415; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-781 (line 1213, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1401; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-782 (line 1186, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1400; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-783 (line 1172, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1412; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-784 (line 1158, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1413; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-785 (line 1144, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1402; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-786 (line 1130, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1422; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-788 (line 1102, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1404; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-789 (line 1086, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1406; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-790 (line 1072, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1403; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-791 (line 1058, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1425; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-792 (line 1044, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1426; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-794 (line 1016, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1405; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-795 (line 1002, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1417; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-797 (line 961, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1400; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-798 (line 947, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1420; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-800 (line 919, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1414; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-801 (line 905, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1416; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-807 (line 821, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1409; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-808 (line 807, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1431; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-809 (line 793, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1409, #1418, #1430; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-814 (line 707, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1429, #1439; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-823 (line 532, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1442; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-824 (line 518, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1443; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-825 (line 500, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (step-iron half FIXED, Codex-accepted 21 Oct 2026 on Civil 3.0.66; velocity half installed, robot PASS run 33, awaiting Codex; reconciled 23 Oct 2026)
@@ BUG-827 (line 472, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1453; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-828 (line 458, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1458; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-829 (line 444, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1456; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-830 (line 430, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1476; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-831 (line 416, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1453; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-832 (line 402, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1461; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-833 (line 388, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1461; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-834 (line 374, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1444, #1492; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-835 (line 358, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1470; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-836 (line 344, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1470; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-837 (line 330, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1470; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-838 (line 316, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1446, #1475; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-839 (line 302, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1476; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-842 (line 260, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1459, #1469; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-843 (line 246, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1450; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-844 (line 232, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1452; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-845 (line 218, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1455; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-846 (line 204, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1449, #1474; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-847 (line 190, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1474; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-848 (line 176, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1469; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-849 (line 162, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1454; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-850 (line 148, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1448, #1463; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-851 (line 134, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1473; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-852 (line 120, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1503; robot or Codex observation PASS recorded, not yet Codex-accepted; reconciled 23 Oct 2026)
@@ BUG-853 (line 106, says OPEN with no word of the installed fix)
- **Status:** OPEN
+ **Status:** OPEN (fix installed in Civil 3.0.70 / Manager 1.1.70 via PR #1462; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-858 (line 11619, says not installed or on hold; the fix is installed)
- **Status:** OPEN (fix drafted, not installed, not accepted)
+ **Status:** OPEN (fix installed in Structural 1.0.121 via PR #1510; not yet tested by robot or Codex; reconciled 23 Oct 2026)
@@ BUG-859 (line 11633, says OPEN with no word of the installed fix)
- **Status:** OPEN (seen in V4 and V5: no part of the symbol opens the CE window)
+ **Status:** OPEN (fix #1520 installed in Civil 3.0.70; still fails in real AutoCAD: Codex V10-01 DIFFERENT, 22 Oct 2026; round 2 PR #1522 not installed; reconciled 23 Oct 2026)
@@ BUG-872 (line 11765, does not name the surviving id)
- **Status:** OPEN (Codex build cx_b06_eng_small_c60 queued 22 Oct)
+ **Status:** OPEN (duplicate of BUG-095 and BUG-307; the queued fix build is tracked here; reconciled 23 Oct 2026)
```

---

## 5. The 20 bugs that most block the 9 Nov release (Civil + Manager to Max)

Ranked against the acceptance backlog in `RELEASE_9NOV_GAP_PLAN_2026-10-22.md` section 3 (Structural stays on your PC, so no Structural bug is on this list).

1. **BUG-488 (1 OPEN, no fix):** Nothing leaves the PC (gate item 4): the fault report and CEMANAGERDIAG write the real Windows login into the office IT folder. No fix. Max must be told not to press them.
1. **BUG-517 (2 built, not installed):** No blue (gate item 5): the old blue is still in the windows and on the printed computations sheet. Fix PR #1029 built, not installed.
1. **BUG-505 (4 installed, FAILS in AutoCAD):** Import units safe (gate item 6): an X-Civil drawing in other units can come in 1000 times too big. Installed fix still FAILS (Codex V3b-04, V8-01).
1. **BUG-861 (1 OPEN, no fix):** REDO (gate item 8): REDO is lost in a freshly opened drawing with the Inspector showing. No fix; must go on Max's known-problems page if not fixed.
1. **BUG-862 (2 built, not installed):** Honest outcome log line (gate item 10): PIT, CD and DP ended with Esc are logged "cancelled". Fix drafted, not installed.
1. **BUG-867 (1 OPEN, no fix):** Engineering HIGH 1: CDRULES and CDCHECKS measure grade pit centre to pit centre (a dog-leg pipe passes at 1 in 170 when the label says 1 in 240). Build queued.
1. **BUG-868 (1 OPEN, no fix):** Engineering HIGH 2: the network solver assumes every pipe is UPVC (concrete capacity about 23 percent high). Build queued.
1. **BUG-869 (1 OPEN, no fix):** Pit Schedule depth to the pit floor (Tim 20 Oct ruling): schedule says 0.85 m and no step irons where CDRULES says 950 mm and step irons. Build queued.
1. **BUG-859 (4 installed, FAILS in AutoCAD):** Downpipe double-click opens AutoCAD's attribute editor, not CE's window. Installed fix #1520 still FAILS (Codex V10-01); round 2 #1522 not installed.
1. **BUG-860 (2 built, not installed):** Green DP label double-click opens TEXTEDIT. Fix PR #1521 built, not installed.
1. **BUG-863 (2 built, not installed):** CDCHECKIGNORE (switch OFF) still saves the drawing record while saying "Nothing was changed". Fix drafted, not installed.
1. **BUG-866 (2 built, not installed):** CDCHECKIGNORE: U after a re-list does not undo the Ignore. Codex PR #1524 building.
1. **BUG-872 (6 superseded):** The one red test (Glen Eira back-test), same as BUG-095 and BUG-307. Build queued; a red test blocks a clean release candidate.
1. **BUG-558 (3 installed, not yet tested):** REDO lost after switching drawings. Fixes installed 17 Oct, never re-tested since Codex W49 reproduced it.
1. **BUG-090 (4 installed, FAILS in AutoCAD):** About CE Suite (pack check C12): rows still clipped on Manager 1.1.68 (Codex V5-02 DIFFERENT).
1. **BUG-650 (3 installed, not yet tested):** HIGH: cancelling CDFW used to blank stored pit inverts. Fix installed 16 Oct, never tested by robot or Codex.
1. **BUG-829 (3 installed, not yet tested):** A colleague can still take the administrator role (BUG-476 hole). Fix installed 19 Oct, not tested; matters the day Max opens the Admin Dashboard.
1. **BUG-552 (2 built, not installed):** Privacy: the "office folder, coded" rule broken in the Civil fault text, CEMANAGERDIAG and the Desktop support zip. PRs #954 and #1225 not installed.
1. **BUG-489 (1 OPEN, no fix):** Privacy: the support-zip cleaner misses drawing names without .dwg and folder and PDF paths. No fix.
1. **BUG-490 (1 OPEN, no fix):** Privacy inside the DWG: confirming a pipe connection writes the Windows login into the drawing, which then goes to clients. No fix.

