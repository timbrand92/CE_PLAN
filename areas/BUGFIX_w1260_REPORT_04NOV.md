# BUGFIX w1260 (B-204, decision 195, item 123.5): New Pipe label after a stretch, Wed 4 Nov 2026

## FOR TIM

1. **Answer: ALREADY FIXED in the code. No PR opened.** After you stretch a pipe, CE already rewrites its label from the real levels and the real drawn length, so a "Set my own 1 in 100" pipe that is really 1 in 99 reads 1 IN 99. That is what decision 195 asks for.
2. **What you will see:** draw a pipe at Set my own 1 in 100, stretch its far end, and the label reads 100 DIA. UPVC PIPE AT 1 IN 99 (the real grade). Codex saw exactly this on Civil 3.0.90 (look S9-01, 3 Nov). The 4 Nov reading (READING_S9_01_04NOV.md) reached the same answer.
3. **One thing still differs, and it is not the stretch:** at the moment the pipe is first drawn, the label shows the 1 IN 100 you typed, even if the real grade is 1 in 99. I did NOT change that. Decision 195 is about the stretch, and the draw-time label is a separate choice for you.
4. **Question for you (one line):** should the label on a newly drawn "Set my own" pipe also show the real grade straight away (so it reads 1 IN 99 at draw time), or keep your typed 1 IN 100 until the pipe is edited? Recommendation: show the real grade, so the label never says a grade the levels do not have. If yes, it becomes a new item with its own switch.
5. **My own mistakes:** none that cost anything. I started by looking for a bug entry for this and found none: the carpark has no entry for it, and BUG-1229 is a different fault (the 1 in 102 rounding on typing the first level). Do not read BUG-1229 as this item.
6. **NOT proven:** I opened no drawing, ran no build, no test and no robot. The evidence is the code on the release branch plus the Codex S9-01 report text quoted in the 4 Nov reading. I did not look at Codex's pictures.

---

## Technical detail

1. **Base:** origin/claude/rel-20261102a at 3fbb9da5 (Civil 3.0.88). Commit 61fd6fbc (Civil 3.0.89) is not an ancestor of it, but `git diff` of the four label files between the base and 61fd6fbc is empty (LinkService.Utilities.cs, MathHelper.cs, PipeAnnotationTextFormatter.cs, CdCommand.Grade.cs), so the finding is the same on both.
2. **Where it is done:** `Modules/Drainage/Services/LinkService.Utilities.cs` line 1941, `UpdatePipeGradeFromInverts(db, pipeId, fromInvert, toInvert, excludedAttachmentHandle)` writes `PipeAnnotationTextFormatter.ActualGradeLabel(distanceMm, from, to)` (PipeAnnotationTextFormatter.cs line 35) over the real drawn length. One rule: `MathHelper.ActualGradeDenominator` (length divided by fall, rounded half up).
3. **When it runs:** line 1592 calls it from the label-refresh path at the end of any command that changed a pipe level (stretch, move). Comment at 1580: "GradeMode records how the design was chosen, not whether the displayed result is allowed to stay stale", so a typed or held grade is not kept.
4. **History:** BUG-329 (23fe830f, 2 Oct 2026) made it one rule; BUG-427 fix round (beec8f57, 8 Oct 2026) made flat pipes one shared decision. Older driver evidence in the carpark (line 3166, 3.0.25): STRETCH of the far end changed the label to 1 IN 101 and one U restored it.
5. **Only exception in the path:** the open mixed-units hold pass (`HeldByOpenHoldPass`, BUG-328 confirm 4) leaves the label alone and names the pipe in one line. That is a separate, reviewed rule, not touched.
6. **Unit coverage that exists:** `Modules/Drainage.Tests/Commands/BreaklineGradeTests.cs` (ComputeActualGradeLabel cases). I added no test and no Settings switch, because no behaviour changes.
7. **Robot case that would prove it (already described in the 4 Nov reading, N41-style):** set up pit P8 and a 20 m pipe with levels 18.000 and 17.800, grade Set my own 1 in 100; STRETCH the far end 2000 mm east; read the pipe label line. Expect `1 IN 99` (21.775 m over a 0.22 m fall = 98.98). A switch-off control does not apply because there is no switch.
8. **Isolation and git listings:** no dotnet command was run, so the before-and-after listings of the CE folders under APPDATA were not needed. No worktree, branch or scratch folder was created, so C: free space did not move. CE_SHARED untouched. No file in the repo changed.
