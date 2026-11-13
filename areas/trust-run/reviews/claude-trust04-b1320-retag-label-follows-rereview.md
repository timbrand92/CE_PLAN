# Re-review: PR 2085 `claude/trust04-b1320-retag-label-follows` (BUG-1320), head `9eb5f87b` (since `1f6774bb`)

**Reviewer:** lane trust-review (sixteenth run). **Written:** Fri 13 Nov 2026, 11:49 PC clock. **Diff read:** `1f6774bb..9eb5f87b`, one commit, four files. `cf059dcf` still its base. Draft, auto-merge off. Read only.

---

# FOR TIM

1. **The serious fault from the last review is fixed in the code.** Answering No to the label question when a source already has a label no longer throws the whole retag away. The label now follows the new tag, as the first fix meant it to.
2. **New:** if that existing label is on a locked layer, CDTAG now refuses in plain words and changes nothing. Today it would retag and leave the label showing the old tag.
3. **Not built yet:** the builder's own log says the build waits for the 2:00pm window. So this is a reading only.

**Verdict: GO** for the robot on copies **once it is built and its unit tests pass**. Not for Tim's PC today.

---

# Findings (file and line at `9eb5f87b`)

1. **FIXED: both checks now use one rule.** The second read-back (`LinkService.SourceChangeApply.cs:338-343`) now uses `SourceTagService.LabelFollowsTheTag(plan.ShowLabel, plan.Before.LabelHandle)`. That is the same rule as the write (`SourceTagService.SourceChangeApply.cs:32`) and the first read-back (`:78`). The rule is: Yes, or an existing label (`:46-47`). So with No and a label already there, the label's text may change, and the retag stands.
2. **FIXED: a locked label layer is checked first.**
   - Before anything is written: `SourceTagCommand.cs:341-347`, `TryCheckExistingLabelLayer` `:561-574`.
   - It finds the label with the same lookup the write and the read-back use (`SourceTagService.TryGetLabelId`, `SourceTagService.cs:806`; used at `:574` and `SourceChangeApply.cs:80`), reads only, and unlocks nothing.
   - The line: "[CE] CDTAG cannot change this source - the tag label for this source is on locked layer <name> (unlock it, then run CDTAG again). Nothing was changed." Plain, and it names the layer.
3. **For Tim (small, DRAFT default):** with No and a locked label layer, a retag that works today, though it leaves a stale label, is now refused. The other answer would be to retag and say "the label on locked layer <name> still shows the old tag". The refusal follows the native protection rule; list it as his choice.
4. **Tests:** two text searches (both checks use the rule; the layer check comes first). Still no real-path case that runs a No retag of a labelled source through both read-backs. The robot case is the proof.
5. **Not built or unit-tested** at this head (commit text and REGRESSION_LOG: "BUILD WAITING FOR 2:00pm").

# What I did not check

1. No build, no test run, no AutoCAD.
2. The hit-box child's read-back (unchanged).
3. Behaviour of 2085 and 2086 together. A dry run (`git merge-tree`, this head with 2086's `12e27bc1`) merges `SourceTagCommand.cs` on its own; only `REGRESSION_LOG.md` conflicts.
