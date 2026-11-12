# Review: PR 2085 `claude/trust04-b1320-retag-label-follows` (BUG-1320, a CDTAG retag never leaves the old tag on the label)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:40 PC clock. **Head reviewed:** `1f6774bb` (one commit on `cf059dcf`, the installed Civil 3.0.90, confirmed as its parent). Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **The idea is right:** when you retag DP1 as DP7 and answer No to "Show the tag label", a label already on the drawing should change to DP7 (or go), never keep saying DP1. The pull request keeps it and changes its text.
2. **But as built, that retag would now fail completely:** CE checks its own work twice after a retag, and only the first check was taught the new rule. The second still says "the label's words may change only if you answered Yes", so it would reject the change and undo the whole retag. Today the retag works and leaves the stale label; on this branch it would be refused.
3. **The fix is one line in the second check plus a test that runs it.** Keeping the label and updating it (rather than erasing it) is a default for you to confirm, as the pull request says.

**Verdict: FIX FIRST.**

---

# Findings (file and line at `1f6774bb` unless stated)

1. **The write and the first check use the new rule.** `Services/SourceTagService.SourceChangeApply.cs:32` writes the label when `LabelFollowsTheTag(plan.ShowLabel, plan.Before.LabelHandle)` (asked, or a label already there); `EnsureTagLabel` (installed `SourceTagService.cs:555-600`) changes an existing label's text in place, keeping its object, so the first check's "label object must stay the same" condition (line 74-77) still passes; line 78 checks the new text under the same rule.
2. **The second check was not changed (the reason for FIX FIRST).** The retag's `verifyAll` step (`Services/LinkService.SourceChangeApply.cs:158-172`) runs `SourceTagService.VerifySourceChange` (the first check) and then `VerifySourceChangeDrawing` (line 321 on). For a retag, every fact recorded before the change about the source's label and hitbox must be unchanged, with one exception at line 338: `if (plan.ShowLabel && child == plan.Before.LabelHandle && fact.Key == child + ":text") continue;`. The label's text is recorded as a fact (`LinkService.SourceChanges.cs:305` for single-line text, `310` for multiline). With No and an existing label, the text now changes from DP1 to DP7, `plan.ShowLabel` is false, so line 340 throws "An existing source child changed beyond its approved label text." and the whole retag transaction is abandoned. Use the same `LabelFollowsTheTag(plan.ShowLabel, plan.Before.LabelHandle)` at line 338.
3. **Why the tests did not see it.** `Trust04B1320RetagLabelTests`: the rule cases are real calls; `TheWriteAndTheReadBack_BothUseTheRule` searches the text of `SourceTagService.SourceChangeApply.cs` only, so it calls one check "the read-back" and never looks at `LinkService.SourceChangeApply.cs`. The lane's broken twin (existing label ignored on No) fails a text search, not a retag. Add a guard that both read-backs use the rule (or one test that runs `VerifySourceChangeDrawing` on a plan with No and an existing label whose text changed).
4. **Locked label layer.** CDTAG checks the GUIDELINES layer only when Yes is answered (installed `Commands/SourceTagCommand.cs:335`). With No, the existing label is now written; if it sits on a locked layer, `EnsureTagLabel` cannot open it, makes a new label instead, and the first check then refuses (new object), so the retag is refused with "The requested source label was not written" or "differs from the plan", words that speak of a label the drafter did not request. Nothing is unlocked; but check the existing label's layer up front for the No case too, with a plain line ("the tag label for this source is on a locked layer").
5. **No PENDING_TESTS row** yet. Needed: DP1 with its label, CDTAG to DP7 with No (the label reads DP7 and the retag is reported done); the same with Yes; with the label's layer locked (a plain refusal, nothing changed); a source with no label and No (still no label); one U after each.

# What I did not check

1. No build or test run; the lane's 357 of 357 and broken twin not re-run.
2. The window route of CDTAG (its "show label" tick box reaches the same plan, by reading `SourceTagCommand.cs:251` and `318`).
3. What the drafter sees when the retag is abandoned at finding 2 (the coordinator's failure line, not traced).
