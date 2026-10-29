# Area CR — Council rulebook workstream: every council value on the Settings page, nothing hard-coded (R-00)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Council rulebook workstream: every council value on the Settings page, nothing hard-coded (R-00). (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `02_COUNCIL_RULES\COUNCIL_RULES_V3_INTEGRATION.md`
2. `02_COUNCIL_RULES\OPEN_QUESTIONS.md` (questions Tim has not answered, never decisions)
3. `02_COUNCIL_RULES\CE_DESIGN_GUIDEBOOK_RULESET.md` and `CE_GUIDEBOOK_V1_3_SUPERSEDES.md`
4. `ENGINEERING_RULEBOOK.md`

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "see the source documents". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **CR-D1b/c, 26 Sep 2026 — Built and automated-tested; not installed or Tim-accepted.** PR #259 ready for review on codex/cr-d1-council-sweep at 8d1538ce retains all 284 unsourced council values as **Assumed - no council source**, with a warning on use (Tim's 4 Sep CP-01..08 ruling and 26 Sep CR-D1b). Tim said “Include it” in Tuesday's pilot, subject to this comparison. All 22 pre-sweep profiles were compared on the same inputs: exactly 24 profile-value differences, all source-backed CR-D1 corrections; no other value changed. Whitehorse 90 mm stays Assumed - source not found. Civil Release net48/net8/net10: 0 errors; focused checks 65/65; full Civil suite 11,135 passed, the same six baseline failures, 19 skipped. No AutoCAD opened. The full change record is 02_COUNCIL_RULES/CR-D1_SWEEP_2026-09-26.md.

2. **Guidebook v1.3 audit, 29 Oct 2026 (Tim's standing ruling, decisions/2026-10-29_TIM_ANSWERS.md item 23) — read-only audit done; nothing built, installed or Tim-accepted.** `areas/GUIDEBOOK_V1_3_VS_CE_AUDIT_2026-10-29.md` (gap list, computations-sheet comparison, plugin changes needed as Settings values and cards) and `areas/GUIDEBOOK_ENGINEER_QUESTIONS_DRAFT_2026-10-29.md` (16 DRAFT questions, Tim to review before any go to engineers). Cards in `04_REFERENCE/guidebook-cards/`: GB-01, GB-02, GB-03, GB-04 approved by Tim 29 Oct (GB-01 slice 1 building); GB-05 draft; GB-06 (update the guidebook, stage 4) planned, not started. Build list: `BUILD_LIST.md` in that folder, kept by the desk.

3. **GB-01 slice 1, the flattest fall, 29 Oct 2026 (Tim's decisions 24 and 26) — Built and unit-tested; not installed, not Codex-tested, not Tim-accepted.** Branch `claude/gb01-slice1-falls`. R-03 minimum grade is now 1 in 100 at every ordinary size (Settings ladder seed; a saved file with exactly the old ladder moves once); 450 mm and larger gravity pipes read their own Settings row `largeGravityMinGradeN`, left blank (Unknown, no warning, "No minimum fall set for this size"); R-32 detention 1 in 200 now comes from the council profile field `detentionGuideGradeN`, set for Darebin, Banyule, Manningham, Maroondah only (Manningham 200 per Tim; the council's own 2021 checklist says 180, still held in `detentionMinGradeN` for R-30; Maroondah's own Table 6 says 250 and 400). Every other council: detention pipes held to 1 in 100 at every size. The old ladder (R-03) and the every-council R-32 figure are retired. Every saved CDRULES run shows Stale once. Card: `04_REFERENCE/guidebook-cards/GB-01_PIPE_AND_PIT_CHECKS.md` section 9. Codex steps: `PENDING_TESTS.md`. Window rows still needed: see card section 9 item 3. Open: who names the 450 mm and larger figure.

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. **CR-D1:** A council figure needs its own source, not a copied office or neighbouring-council value. Verify Banyule 100% below ground / 40 mm orifice, Maribyrnong 10-year storage / 40 mm orifice, and Whitehorse 90 mm marked Assumed. Assumed values must warn on use and must not be shown as sourced council requirements. Use the after-install checklist in `PENDING_TESTS.md`; no result is accepted until Tim confirms it in AutoCAD.
