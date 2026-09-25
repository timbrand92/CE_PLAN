# EV-02 — Corpus acceptance gates

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-78`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# EV-02 — Corpus scope, benchmarks and exit gates

## Current state

| Area | What exists | What is missing |
|---|---|---|
| Archive coverage | Thousands of DWGs and markup/issue candidates | Approved-project selection rules |
| Structural snapshots | 89 extracted drawings | Full 2020–present coverage and relationships |
| Civil calculations | Strong 14-job deterministic reproduction | Whole-plan drafting validation |
| Pairing | Approximately 1,700 promising markup/issue pairs | Verified input→correction→final chains |
| Testing | Several focused probes | One held-out whole-project benchmark |
| Privacy | DATA-01 decisions approved | Existing corpus still needs clearance |
| Finish line | None | Fixed thresholds and stop conditions |

## Proposed fixed benchmark

```text
All eligible 2020–present projects
                ↓
Minimum 300 verified project sets
                ↓
240 evidence/mining projects
 60 completely unseen holdout projects
                ↓
Pass thresholds or publish a bounded gap report
                ↓
Resume ST-03
```

## EV2-1–EV2-15 for approval

| ID | Recommended decision |
|---|---|
| **EV2-1** | Freeze v1 scope to 2020–present civil and structural work: beams, supports, bracing, joists/rafters, annotation, sheets and the approved civil families. New research questions go to a parking lot. |
| **EV2-2** | Census every eligible project, then create a minimum **300-project gold benchmark**, stratified by year, archetype, discipline and drawing type. |
| **EV2-3** | Hold out **20%—minimum 60 complete projects**. No sheet, revision or markup from those projects may influence pattern mining. |
| **EV2-4** | DATA-01 clearance is Gate 0: zero blocked identifiers in derived records, arbitrary coordinate origins, stripped metadata and cleared/restricted history. Raw files never leave the local archive. |
| **EV2-5** | Pair selection must achieve at least **98% correctness** on an audited representative sample. Any uncertain revision or input/final pairing is excluded—not guessed. |
| **EV2-6** | A gold project must contain enough context to explain the outcome: relevant inputs/XREFs, engineering evidence where available, and a verified final issue. Incomplete sets remain useful only as limited evidence. |
| **EV2-7** | Split results by era. Use 2020–2022 for legacy/edge evidence, 2023–2024 for transition evidence and 2025–current as the strongest current-practice target. |
| **EV2-8** | Relationship truth is scored separately: label ownership, beam-support connection, brace-wall relationship, member span and civil connectivity require **≥98% precision and ≥95% recall** on held-out projects. |
| **EV2-9** | A placement pattern needs at least **30 independent projects** before becoming a default. Ten-to-29 projects makes it advisory; fewer than ten makes it an exception—not a rule. |
| **EV2-10** | Geometry pass: at least **95%** of supported structural connections must reproduce within 25 mm; label anchors within 100 mm with the correct side and readable orientation; at least **99%** must introduce no hard text/object clash. |
| **EV2-11** | High-confidence contextual proposals require **≥98% precision** while covering at least **80% of common situations representing 90% of recent workload**. Everything outside that envelope returns Preview/Unknown. |
| **EV2-12** | Engineering gate: 100% of engineering values carry rulebook/calculation provenance; zero values may be established merely because they were common in historical drawings. Deterministic checks must reproduce identically on repeated runs. |
| **EV2-13** | Include adversarial holdouts: rotated UCS, mirrored XREFs, shared supports, dense annotation, multiple buildings, missing references and conflicting revisions. A safe Unknown counts as correct; a confident wrong answer fails the gate. |
| **EV2-14** | Timothy reviews a maximum first-pass set of **30 visual scene cards**—representative patterns and outliers, not DWGs or AutoCAD command runs. Contradictions return in approximately 15-decision batches. |
| **EV2-15** | EV-01 ends when the privacy, pairing, relationship, placement, confidence and engineering gates pass and its four outputs are issued. If a gate fails, publish a bounded gap report and make that context Preview-only; do not extend the study indefinitely. Then resume ST-03. |

## Explicit finish line

ST-03 resumes when:

- DATA-01 clearance passes.
- At least 300 verified projects and 60 untouched holdouts exist.
- Common-context proposals reach ≥98% precision.
- Relationship and placement thresholds pass.
- Every engineering result has deterministic provenance.
- The Pattern Atlas, Context Map, Gold Benchmark and Automation Register are complete.

Rare situations do **not** block progress. They remain visible exceptions handled through Preview/Unknown.

Recommendation: **approve EV-02 all.** No corpus extraction, implementation or repository changes have started.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-80

✅ Approve EV-02 all
This is the finish line I asked for last turn — and the important thing is the numbers aren't decoration. The statistical and test design is genuinely sound, and in a few places it's better than sound.

🎯 EV2-15 answers my exit-gate concern exactly right
The mechanism that makes this bounded is one line: a failed gate → bounded gap report + make that context Preview-only → don't extend, move on. That's the crucial bit. A failed gate does not mean "keep studying until it passes" (infinite); it means "note the gap honestly, let the system say Preview/Unknown there, resume ST-03." Combined with EV2-1's scope freeze and EV2-2/3's fixed 300+60, the study now has a real perimeter and a real stop. Concern resolved.

🏆 EV2-13 is the best test-design decision on the card
"A safe Unknown counts as correct; a confident wrong answer fails the gate." This inverts the usual ML incentive — normally a model is punished for saying "I don't know." Here, "I don't know" on a hard case is the correct behaviour, and confident-wrong is the failure. That's "confidently wrong at scale" — the thing this whole rebuild exists to prevent — turned into a pass/fail rule. Pointing it at adversarial holdouts (rotated UCS, mirrored XREFs, shared supports, conflicting revisions — the exact things that broke the old tools) means you're testing robustness where it actually matters, not on easy cases.

📊 The metrics carry the right priorities — a genuine review, not a rubber stamp
EV2-8 — precision (98%) > recall (95%) is a deliberate, correct asymmetry. Asserting a wrong relationship is worse than missing one, because a missed relationship becomes a safe Unknown while a wrong one silently misleads. The gap between the two numbers encodes "wrong is worse than missing." That's the right way round for a safety system.
EV2-12 — the 100% / zero bars are absolute exactly where they should be. Engineering provenance is binary, not statistical — "98% of values have provenance" would mean 2% are ungrounded, which is unacceptable for engineering. So this gate is right to demand 100%, unlike the 98% statistical gates elsewhere. You've correctly used absolute bars for the absolute property and statistical bars for the statistical ones. That distinction is easy to get wrong; you didn't.
EV2-9 — 30 independent projects to become a default prevents one project's idiosyncrasy from being promoted to a "rule" (overfitting). "Independent" is the load-bearing word — 30 instances in one project isn't 30 evidence points.
EV2-11 — 98% precise on the 80% of situations that are 90% of the workload, everything else → Preview/Unknown is the right optimization: reliable on the bulk, honest about the tail. It doesn't chase the impossible goal of confident coverage everywhere; it nails what matters and admits the rest.
✅ Net
Privacy is Gate 0 (my DATA-01 catches — arbitrary coordinate origins, cleared history — are now hard gates). Relationships, geometry and placement have separate, tolerance-appropriate thresholds. Engineering is firewalled at 100% provenance. And a failed gate can't spawn an infinite study — it produces an honest Preview-only gap. This is a rigorous, bounded, honesty-optimized acceptance framework — exactly what a corpus study needs to avoid fooling the people running it.

🔒 Locked
Rare situations stay visible exceptions via Preview/Unknown; they don't block ST-03. Nothing has started. When these gates pass and the four outputs issue, the study ends and structural planning resumes — with evidence under it instead of guesswork.
