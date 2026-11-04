# BUGFIX ff2001b report, 4 Nov 2026 (PR #2001, B-182, BUG-648)

**Result: STOPPED. Nothing built, nothing pushed, no PR touched.** The change Tim asked for in decision 194 is not small.

## FOR TIM

1. **What you will see differently:** nothing. PR #2001 is unchanged. It still draws the "1:50" text under the AG drain, but the text is NOT tied to the drain.
2. **Your decision 194 (yes: the "1:50" text moves, copies and erases with the drain) is NOT built.** Today, if you MOVE, COPY or ERASE the drain, the "1:50" stays behind. That is exactly what you said you do not want.
3. **Why I stopped:** the tie-in lives in the part of CE that keeps pit and drain labels with their objects (about 924 lines). It was built for exactly one text per drain (the PD tag) and it checks for exactly one. Adding a second text means changing how CE handles ERASE, OOPS, MOVE, COPY (with the new drain's number), renumber and REDO for that text. That is a design job with real AutoCAD behaviour to prove, not one small change. You told me to stop in that case.
4. **The review (3 Nov) had no "fix first" item.** It said GO with no change required. Its only must-do-later item was one line of wording: CDPERIMETER drains get the "1:50" text too (below the line, PD tag above). I did not do it, because you asked me to fix only the fix-first finding, and decision 194 is the real gap.
5. **My own mistakes:** none that cost anything. I ran no build and no test, so there is nothing to un-run.
6. **NOT proven:** everything about how the text looks and behaves in AutoCAD. I did not open AutoCAD.
7. **What I suggest next:** a small design card for "linked grade text" first (Rule: command review gate). It should say what happens on COPY (the copy gets its own "1:50"), ERASE then OOPS, MOVE, and a perimeter drain that has both a PD tag and a "1:50".

## Technical detail

1. **Branch:** `claude/w648-ag-grade-label`, one commit `90037740` on `3fbb9da5` (rel-20261102a). Worktree `C:\CE_WORK\build\ff2001b`, branch `ff2001b-work` (local only, now removed).
2. **Current code:** `AgiCommand.GradeLabel.cs` `AppendGradeLabel` adds a plain MText on the AG layer inside the Accept transaction. `AgiCommand.Apply.cs` links only `staged.LabelId` (the PD tag) via `LinkService.RegisterSurfaceDrainTagInTransaction`. `staged.GradeLabelId` is never linked.
3. **Why the link is not a one-line add:** `LinkService.SurfaceDrainTags.cs` (924 lines) `WriteSurfaceDrainTagLink` writes `Attachments = { tag.Handle }` and one offset per text. `IsSurfaceDrainTagLinkExactInTransaction` (line 113) requires `Attachments.Count == 1`. The erase, OOPS, follow-on-move, copy-pairing and renumber paths all assume one PD text (`SurfaceDrainTagPolicy`, `CopiedTagCandidates`, `PairCopiedText`). A grade text would need its own marker so renumber does not overwrite it, and its own copy rule. Also, a CDAGI drain has no PD tag at all, so the "one text" case there is a new case.
4. **Rules that make this a gate item:** it touches ERASE/COPY/MOVE/OOPS/REDO behaviour (REDO-safety, Opus-owned), and the command review gate wants a card first. I judged it more than one small change and stopped, as ordered.
5. **Switch:** unchanged, `agDrainGradeLabel`, Default: on.
6. **Robot case (for when it is built):** name suggestion `ff2001_ag_grade_link`. It should type CDAGI with levels 10.00 and 9.00 on a 50 m drain, Accept, then MOVE the drain and read that the "1:50" MText insertion point moved by the same vector; COPY and read a second "1:50" at the copy; ERASE and read zero "1:50" MText on the AG layer; then U and read it back. Switch-off control: set `agDrainGradeLabel` false before launch and read that no "1:50" MText exists. Also a CDPERIMETER run, reading both the PD tag and the "1:50".
7. **Isolation rule (common rule 1):** no test or build ran, so no APPDATA listings were taken and nothing could have written to them.
8. **Cleanup:** worktree and local branch removed; `C:\CE_WORK\scratch\ff2001b` did not exist.
