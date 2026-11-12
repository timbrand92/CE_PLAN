# Review: PR 2065 `claude/trust04-b1356-runsolve-preview-words` (BUG-1356: CDRUNSOLVE's preview says invert levels only)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:08 PC clock (written 05:05 to 05:08). **Head reviewed:** `cb133d67`, one own commit on `claude/rel-20261108a` = installed Civil `cf059dcf` (checked). **Against:** `BUG_CARPARK.md` BUG-1356. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. CDRUNSOLVE's preview used to read "DN225 at 1:150" beside each change although Apply only writes the two invert levels; it now says "invert levels only" first and gives the size and grade as a suggestion to set in Edit Pipe.
2. What Apply writes is unchanged.
3. One engineering point for you (not a blocker): the levels CE applies were worked out for the suggested size, which may not be the size drawn.

**Verdict: GO** (fit for testing on copies, never to merge or install). Two wording notes for Codex's look.

---

## Checked against BUG-1356 (by reading the code at `cb133d67`)

1. **Matches the bug's first expected answer** ("the preview says only what Apply writes and shows the proposed size and grade as advice"). Each line now reads "Whole-run solve: invert levels only. Suggested DN225 at 1:150 (1.05 m/s); size and grade are not changed - set them in Edit Pipe if you agree." and the title "Whole-run solve (invert levels only) — N pipe(s), M pit(s)" (`Services\ProposalApplyService.PlanBuilders.cs` 105-107, 126, 656-667).
2. **Apply still writes the two inverts only:** the plan builder adds only the upstream and downstream invert changes (108-111); nothing else in the run-solve plan. The material note is still added (666).
3. **No other place prints the old run-solve words** (searched "Whole-run solve" and the old DN/grade format across the Civil code).
4. **Tests:** the words function the builder really calls (exact text, material note) and a source guard that the builder uses it and still adds only the two invert changes. Putting the old words back fails the guard.

## Worth knowing (for Tim and Codex, not blocking)

1. **Engineering point for Tim:** the solver works out the inverts for the size and grade it suggests. When it suggests a bigger pipe than the one drawn (for example DN225 where DN150 is drawn), Apply writes levels designed for DN225 onto the DN150 pipe and keeps DN150. The preview now says so honestly, but it does not show the drawn size beside the suggested one. Suggested words (DRAFT): "Suggested DN225 (drawn DN150) at 1 in 150". Whether CE should apply levels for a size that is not drawn is Tim's call.
2. **"Grade is not changed" can read wrong:** the new invert levels DO set the fall of the pipe; what is not changed is the size and grade written in the pipe's label and record. Suggest "the size and grade in the pipe's label are not changed".
3. **"1:150" against CE's usual "1 in 150"** (used by the sizing advice next door, `PipeFlowSizingAdvisorService.cs` 233, 268). One wording for Codex's look.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD (the preview window itself).
3. Whether the second fix the bug offers (Apply writes size and grade too) is wanted; that is Tim's.
