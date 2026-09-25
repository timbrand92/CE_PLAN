# EV-06 — Gold drawing benchmark

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-101`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# EV-06 — Gold Drawing Benchmark and automatic comparison

### Current state

| Evidence/testing area | What works | What is missing |
|---|---|---|
| Hydraulic replication | 14 approved jobs reproduced deterministically | Not complete drawing behaviour |
| Full-drawing backtest | 22 drawings across 9 councils produced readable results | Drawing-only inputs were insufficient |
| Structural snapshots | Useful object/style evidence | Limited relationships and incomplete era coverage |
| Regression testing | TH strategy approved | Not connected to complete issued projects |
| AutoCAD commands | Numerous useful individual behaviours | MOVE/COPY/EDIT/ERASE and contextual placement are not comprehensively compared |
| Timothy’s testing | Finds important real drafting problems | Far too many situations to test manually |

```text
Approved project inputs
        ↓
CE automatically recreates the work
        ↓
Compare with approved final
        ↓
Classify meaningful differences
        ↓
Timothy reviews exceptions only
```

## EV6-1 — What constitutes one benchmark case?

**Recommended:** One complete project is the primary benchmark unit, with smaller scenes used to diagnose failures.

A single beam-label scene cannot prove that the whole framing plan remains coordinated.

Approve?

## EV6-2 — Should there be two benchmark lanes?

**Recommended:**

1. **Reproduction lane:** Can CE reproduce an approved historical project?
2. **Command lane:** Do individual commands and editing operations behave correctly?

This separates whole-project quality from an isolated command fault.

Approve?

## EV6-3 — What inputs should CE receive?

**Recommended:** Use only information that would genuinely have been available when the drawing was produced:

- verified consultant inputs;
- survey and XREFs;
- approved calculations;
- project settings;
- engineering decisions available at that revision.

Do not secretly provide the final drawing as an input.

Approve?

## EV6-4 — How should drawings be compared?

**Recommended:** Compare engineering and drafting meaning—not AutoCAD entity numbers.

Example:

```text
Different internal entity number
+ same beam, support, label and position
= Pass
```

Approve?

## EV6-5 — What geometric tolerances apply?

**Recommended:** Retain the EV-02 gates:

- structural connections within 25 mm;
- label anchors within 100 mm with correct side/orientation;
- at least 99% free of newly introduced hard clashes.

Exact overlap is required only where engineering geometry demands it.

Approve?

## EV6-6 — How are legitimate alternative layouts treated?

**Recommended:** A different layout passes when it:

- obeys hard constraints;
- meets plotted readability requirements;
- retains correct ownership;
- matches an approved Atlas alternative;
- does not change engineering meaning.

CE should not fail merely because Timothy could have drawn it two valid ways.

Approve?

## EV6-7 — How are engineering results scored?

**Recommended:** Engineering comparisons require:

- correct value;
- correct units;
- correct source revision;
- correct status;
- 100% provenance;
- identical deterministic results on repeat runs.

A visually matching value with no authority fails.

Approve?

## EV6-8 — How is drafting presentation scored?

**Recommended:** Assess the issued sheet appearance:

- plotted text size and clearance;
- label side and orientation;
- leaders and alignment;
- viewport boundaries;
- line hierarchy;
- overlaps and hard clashes;
- readability in dense areas.

Model-space clearance alone is insufficient.

Approve?

## EV6-9 — How are object relationships scored?

**Recommended:** Test:

- beam-to-support relationships;
- shared supports;
- label ownership;
- brace connections;
- pit/pipe connectivity;
- parent/child annotations;
- cross-sheet and XREF references.

Wrong relationships fail. Missing relationships become safe `Unknown`.

Approve?

## EV6-10 — Which AutoCAD editing actions must be replayed?

**Recommended:** Every benchmarked command family includes:

| Action | Required behaviour |
|---|---|
| MOVE | Owned annotation follows; authored positions remain |
| COPY | Fresh identities and correct copied relationships |
| EDIT | Valid manual placement retained |
| ERASE | Owned children removed; shared objects protected |
| Rotate/mirror | Orientation and ownership remain correct |
| Reopen drawing | Relationships and approvals persist |

Approve?

## EV6-11 — How should cancel and Undo be tested?

**Recommended:**

- Esc at every prompt leaves nothing partial.
- A failed command leaves no hidden records.
- Apply creates one complete Undo step.
- Undo restores geometry, labels, relationships and project data together.
- Redo returns the same result.

Approve?

## EV6-12 — Which hostile AutoCAD situations are mandatory?

**Recommended:**

- rotated UCS;
- mirrored and rotated XREFs;
- multiple buildings;
- shared columns;
- crowded notes and dimensions;
- missing XREFs;
- conflicting revisions;
- unknown levels;
- copied compounds;
- older/newer CE drawing versions.

Safe `Unknown` passes; confident-wrong fails.

Approve?

## EV6-13 — How is drafting smoothness tested?

**Recommended:** Replay representative large drawings and measure:

- command start;
- cursor preview;
- placement;
- MOVE/COPY;
- project reopen;
- local QA refresh.

The benchmark must enforce the approved PD limits and detect whole-drawing rescans.

Approve?

## EV6-14 — What does Timothy review?

**Recommended:** Maximum 30 exception cards per batch:

```text
Approved final | CE result | highlighted difference | classification
```

Timothy selects:

- CE defect;
- intentional engineering difference;
- acceptable drafting alternative;
- historical drafting problem;
- Unknown.

No repetitive AutoCAD command driving during corpus acceptance.

Approve?

## EV6-15 — What happens when a benchmark fails?

**Recommended:**

- Common or safety-critical failure blocks that command/context.
- Rare unsupported context becomes Preview-only.
- Every confirmed defect receives a permanent regression case.
- Produce a bounded gap report.
- Do not expand the corpus indefinitely.
- Do not block unrelated commands that pass.

Approve?

### EV-06 target

```text
Old process:
Timothy manually tests hundreds of command situations

New process:
CE replays approved projects automatically
→ Timothy reviews ≤30 meaningful exceptions
→ every confirmed defect becomes a permanent guard
```

**Recommendation: approve EV-06 all. Nothing starts until approved.**

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-102

✅ Approve EV-06 all
This operationalizes the auto-compare model — and the comparison methodology is genuinely well-designed, because it dodges the traps that make benchmarks lie. Four decisions carry it.

🔑 EV6-3 is the validity condition — everything else depends on it
"Do not secretly provide the final drawing as an input." Reproducing a drawing you were shown proves nothing — it's memorization, not capability. CE must produce the final from only the inputs genuinely available before it was drawn (consultant files, survey, calcs, decisions-at-that-revision). Get this wrong and the whole benchmark is theatre: 100% "reproduction" that means zero. This is the no-leakage rule at the input level, and it's the single thing that makes the exercise real. (Your own flagged history — "full-drawing backtest: drawing-only inputs were insufficient" — is exactly why: a true reproduction needs the real inputs, not the final to reverse-engineer.)

🎨 EV6-6 is the test-design maturity most benchmarks lack
Engineering drawing has legitimate degrees of freedom — you yourself might draw the same plan two valid ways on two different days. A benchmark that demanded pixel-identical reproduction would fail CE for correct choices, generating noise that buries real defects. EV6-6 accepts a different-but-valid layout when it obeys the hard constraints, plots readably, keeps ownership, matches an approved Atlas alternative, and preserves engineering meaning. The Atlas knowing the valid alternatives (EV4-7) is what makes "is CE's choice one of the acceptable ones?" checkable. This is the line between a fair benchmark and one that punishes legitimate variation.

🔬 EV6-7 scores the reasoning, not just the result
"A visually matching value with no authority fails." Even a correct number fails the engineering gate if it has no provenance — because a right answer for the wrong reason means the value was guessed or laundered, not derived, and next time it'll be wrong. Drafting is scored on the result; engineering is scored on result plus reason. That asymmetry is the EV5 firewall turned into a pass/fail rule, and it's what stops a lucky guess from sneaking through.

💎 EV6-14's fifth option is the subtle gem — "historical drafting problem"
A CE difference from the gold doesn't always mean CE is wrong. Sometimes the old drawing had the mistake and CE correctly didn't reproduce it. Giving you that classification means the benchmark can improve on history, not just replicate it — and those cases get captured as "the gold was flawed," not miscounted as CE defects. That's mature: the goal is a correct drawing, not a faithful copy of a possibly-imperfect one.

✅ Two quick affirms
EV6-2 (two lanes) cleanly separates system failures (CE can't reproduce a whole coordinated project) from unit failures (one command misbehaves) — so a whole-project miss can't mask a command bug, or vice versa.
EV6-10 + EV6-11 are where the shared-support, copy-identity and atomicity fixes finally get their permanent guards — MOVE/COPY/ERASE ownership, one-Undo, "no hidden records after a failed command," reopen-persistence, all replayed and verified.
🔒 Approve — nothing starts
Project-level unit, no input leakage, semantic comparison, valid-alternative tolerance, provenance-strict engineering, honesty scoring (safe Unknown passes, confident-wrong fails), and every confirmed defect becomes a permanent regression case. This is the auto-compare model built with the rigor that keeps it honest — the route from "test hundreds of situations by hand" to "review thirty meaningful exceptions." Approved.
