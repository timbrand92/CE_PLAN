# BUGFIX ff2000b report: PR 2000 (B-179, BUG-806 orifice size) fix-first (written Thu 5 Nov 2026, Melbourne)

## FOR TIM

1. **Nothing was pushed to PR 2000.** The 5 Nov ruling (`RULING_CODEX_VS_OPUS_SIX_PRS_05NOV.md`, block for PR 2000) says "ship it as it is, no fix needed". My brief says that in this case I push nothing.
2. **What a drafter sees:** no change from what PR 2000 already does. The orifice diameter on the detail is never drawn larger than the sized diameter, to within one millionth of a millimetre.
3. **Why no fix:** Codex's worry is that 55.9999995 mm could draw as 56. That is under a millionth of a millimetre and no drill, plate or flow calculation can tell the two apart. Codex's fix (a plain round-down) would turn a true 56 mm, held by the computer as 55.9999999, into 55. That is a whole millimetre too small on the drawing.
4. **Mistakes of my own:** none. I built nothing, so there was nothing to get wrong.
5. **NOT proven:** nobody has seen this in AutoCAD. BUG-806 stays OPEN for the `PIT_IL_CENTRE` level question, which is Tim's call. The optional wording line for the regression entry ("never above the sized diameter, to within one millionth of a millimetre") was not added, because that would need a new commit and the ruling says none is needed.
6. **Robot case:** no new case needed. The existing unit test `On_OrificeIsNeverRoundedUp` (55.9999999 gives 56) pins the allowance. Switch-off control is the PR's own: with the orifice switch OFF the old behaviour returns.

## Technical detail

1. **Head confirmed:** `git fetch origin pull/2000/head` gives bb594ff4, unchanged since Codex's review and the ruling.
2. **Line confirmed:** `Modules/Drainage/Services/OrificeDetailFieldMap.cs` line 123 at bb594ff4 reads `(int)Math.Floor(inputs.OrificeDiaMm + 0.000001)`. The allowance is deliberate.
3. **Actions:** no worktree created, no build, no test, no commit, no push to the PR branch, no new PR. No AutoCAD, Codex or accoreconsole started.
4. **Isolation listings (rule 1):** no test was run, so no real file could have been written by this job. The before and after listings of the `%APPDATA%` folders were not taken, as there was nothing to compare.
5. **Disk:** no worktree or scratch folder created, so C: free space did not move.
