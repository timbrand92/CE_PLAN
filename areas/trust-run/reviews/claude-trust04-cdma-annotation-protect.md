# Review: PR 2060 `claude/trust04-cdma-annotation-protect` (TRUST-04 queue item 10, BUG-1283 and BUG-1284: CDMA moves only CE flow arrows, never an Xref, honest result; CDANNOTATIONEDIT refuses Xrefs)

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:12 PC clock. **Head reviewed:** `d761ccd6` (one own commit; base `cf059dcf` confirmed). Against the BUG-1283 and BUG-1284 entries in `BUG_CARPARK.md`. Read by a helper reader; the CDMA refusal, the closing lines and the CDANNOTATIONEDIT Xref refusal re-read by me. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Move arrow (CDMA) now refuses anything that is not CE's flow arrow, never touches an Xref or a locked-layer arrow, and says "Flow arrow moved." only when one moved; Esc at its level questions cancels.
2. CDANNOTATIONEDIT now refuses an Xref before asking anything. Before this, a whole consultant Xref could be moved, rotated or mirrored with it.
3. CDANNOTATIONEDIT still accepts any plain text or block (a title block, a north point), so BUG-1284 stays half open.

**Verdict: GO** for the robot on copies, for what it fixes. GO means fit for testing on copies, never merge or install.

---

## Findings

1. **BUG-1283 fixed.** Esc at the first level, second level and reverse questions cancels (`Commands\CdCommand.Arrows.cs` 410-415, 426-430, 453-458). The closing line now matches: "Flow arrow moved." or "Flow arrow placed." only when that happened, otherwise "Move arrow - nothing changed." (`CdCommand.Arrows.cs` 309-315, read by me; 340-355).
2. **BUG-1284 half fixed (the builder says so).** CDMA refuses any block that is not CE's one flow-arrow block (`CdCommand.Arrows.cs` 284-296, read by me; 491-501). CDANNOTATIONEDIT still accepts any text or block (`Commands\AnnotationEditCommand.cs` 36-41, read by me) and still does not mark a label as placed by hand, so Tidy labels can move it again. Keep BUG-1284 open for those.
3. **Native protection rule: met for what changed.** CDMA refuses an Xref arrow and a locked-layer arrow before asking anything; nothing is unlocked. CDANNOTATIONEDIT refuses an Xref before its first question (`AnnotationEditCommand.cs` 61-70, read by me) and keeps the existing locked-layer refusal (BUG-284).
4. **Gaps already there before this PR (for the controller, not this PR's fault):** CDMA has no reference-edit check; its pipe pick accepts any polyline and writes CE's link onto it; on a pipe on a locked layer the arrow is placed, the link write fails without a word, and CDMA says "Flow arrow placed." (helper's reading; not re-read by me).
5. **Words:** plain. "(unlock it, then run CDMA again)" reads oddly when started from Edit Pipe's Move arrow button; an arrow on an Xref-named layer in the drawing's own content is called "part of an external reference" (safe, not exact).

## Does the test fail without the change, through the real code path?

Yes for the refusal rule: `ArrowPickRefusal` is real product code tested directly. The rest of `Trust04CdmaProtectedTests.cs` reads source text and counts occurrences, which is weaker.

## Does it do only what the bugs need?

Yes; nothing extra.

## What I did not check

1. Built nothing, ran nothing.
2. Nothing in AutoCAD.
3. The locked-layer pipe path in item 4 beyond the helper's reading.
