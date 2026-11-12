# Review: card TRUST-08, Check this drawing (DRAFT, 12 Nov)

**Reviewer:** lane trust-review, Thu 12 Nov 2026, about 23:50. Read only. Card at `04_REFERENCE\ux-plan\cards\TRUST-08_CHECK_THIS_DRAWING_CARD_DRAFT_2026-11-12.md`. Checked against `areas\trust-plan.md` (review holes and the nine real-job cases), `areas\TRUST_PLAN_REVIEW_12NOV.md` and the code where marked.

---

# FOR TIM

1. **What the card would do:** one button lists everything in three groups, Sure, Proposed and Unknown; you tick, CE backs up and applies, and U takes it back.
2. **Two holes could make a wrong value look Sure:** pits copied from another job carry CE's identity and would show as Sure, and single-answer proposals appear to come pre-ticked, so one Apply could turn a whole old job's guesses into facts.
3. **Verdict: FIX FIRST** (tighten what counts as Sure, nothing pre-ticked for sizes, levels or numbers, and prove that U really takes it all back).

---

## Findings

1. **FIX FIRST: "Sure" is defined as the case the plan says can be wrong.** Section 1 item 2: Sure = matched by CE's stored identity. Plan case 2: Save As jobs and copied or WBLOCKed pits carry CE's identity "and can look Sure when they are wrong". Repeated identities are only handled in slice D ("repeated tags"), so slice A would list copies as Sure. Sure should need: identity found, identity used once in the drawing, and the stored values agreeing with the drawn label. Anything else is Proposed with the reason.
2. **FIX FIRST: pre-ticking.** Section 1 item 3, "Nothing is ticked for you where two answers were possible", reads as single-answer rows ARE ticked for you. On an old job with no record every row is Proposed, so one Apply would make them all facts: the review's hole 1. State that sizes, levels and pit numbers are never pre-ticked; links only if Tim agrees (already a question for him).
3. **FIX FIRST: Undo must also undo CE's working copy.** U may put the drawing's stored record back while the copy CE holds in memory keeps the applied values and writes them back at the next update or save. Robot case 3 ("Apply, then U once") should continue: run a tool that updates the record, or save and reopen, then compare.
4. **FIX FIRST: zooming from the list adds Undo steps.** AutoCAD records zoom and pan in its Undo list unless the drafter has combined them (the UNDO command's documented option). Click a row after Apply and U undoes the zoom, not the Apply, so "U undoes it" becomes untrue. Put this in probe P2 and word the after-Apply line so it stays true.
5. **The backup misses unsaved work (section 2 item 4), and no restore is proven.** Two options for the card: write a copy of the drawing's current state to the backup folder without saving or renaming the drawing (needs a timing probe on a large job), or use the BUG-1276 copy of AutoCAD's own automatic-save file. And add a restore rehearsal to the proof list: the plan's foundation 2 says step 8 proves a restore, but section 6 never restores anything.
6. **Read-only drawing (plan case 1) is not answered.** Apply there changes the drawing in memory but cannot be saved. Say so before Apply, in one plain line.
7. **Frozen or turned-off layers.** A row for an object on a hidden layer zooms to nothing. List it as "on a layer that is turned off" and never change the layer.
8. **AutoCAD 2022 to 2024 (section 2 item 10).** Correct only for the pipe conversion rows: the native pipe object is 2027-only, but Tim's 15 Sep ruling keeps pipe drawing, grips and moves in scope on 2022 to 2024. Link and record rows must work there; only conversion rows should say "needs AutoCAD 2027".
9. **Placed schedules and split jobs (plan cases 5 and 9)** are not answered: a Pit Schedule on a layout, and a job whose pits and pipes sit in different drawings.
10. **Minor:** "Nothing to do ... the window does not open" leaves no way to see the Sure count or the outlet on a clean drawing. Consider opening it anyway when the button is pressed.

## What I did not check

1. Whether one scanner can reproduce the five existing ones (section 8 item 5).
2. How long the list takes on a large job.
3. Nothing was run; the Undo points are from the code and documented AutoCAD behaviour, not seen.
