# BUGFIX fx1882: PR #1882 (BUG-1093), lid typed with a comma (31 Oct 2026)

## FOR TIM

1. **What changed:** in network design (CDRUNSOLVE and the proposal builder) and network redesign, a pit lid typed as "12,5" now reads as RL 12.5, the same as "12.5". Before this fix the pit could be told "lid known" while its level stayed at 0, which would have given a false COVER warning against RL 0.
2. **Text CE cannot read** ("abc", "1,012.500", "1,2,3", blank) stays Unknown, exactly as before the PR: no new warning, no new block (R-27). A real typed 0.000 on an ordinary pit is still a level; the old trench-grate "0.000" placeholder is still Unknown.
3. **Switch OFF** (`cover.zeroCoverLevelIsReal` false) reads the lid the old way exactly, comma and all.
4. **Status:** built and unit-tested only. Nobody has opened this in AutoCAD. BUG-1093 stays OPEN.
5. **What to check in AutoCAD (robot case C93 plus one):** a low pit with lid typed "12,5" on a deep pipe must give NO cover warning in CDRUNSOLVE; the same pit typed "12.5" must match it.

---

## Detail

1. **PR / branch:** #1882, branch fb/bug1093-cover-rl-zero, new head 84d5a659 (pushed normally, no force). The branch was already checked out in another worktree (C:/ce-fx/p9), so I worked in a detached worktree at C:\CE_WORK\build\fx1882 and pushed HEAD to the branch.
2. **Code:** new `CoverLevelKnownRule.TryReadLid` (one comma and no full stop = decimal comma, same rule as `SpotLevelText`, invariant culture otherwise). `ProposalApplyService.PlanBuilders` now uses the lid it reads itself as both the level and the known flag (ON), the old reader (OFF). `NetworkRedesignDrawingProjector` uses the same reader for the known flag.
3. **Tests (net10.0-windows, Bug1093CoverZeroTests, Bug393MetreRecordLengthTests, NetworkDesignService classes):** 57 of 57 pass with the fix. With the two service files put back to the previous head, 4 of 25 in the Bug1093 class failed, including "101,5" giving the false cover warning. New cases: dot and comma lids give the same level and no false finding; unreadable lids stay Unknown; real 0.000 known and TG placeholder Unknown; switch OFF old reading; truth table.
4. **Not tested:** net48 and net8 lanes; AutoCAD; a full redesign run; the full suite; Manager tests. The redesign path never reaches a comma lid (it already refuses an unreadable cover), so the fix there is for consistency only.
5. **REGRESSION_LOG.md:** item 7 added inside the existing BUG-1093 entry (not at the top of the file, so it will not clash with other PRs).
6. **Environment:** test runs used scratch folders under C:\CE_WORK\scratch\fx1882 (not the real AppData). I created an empty CE_TRANSFORM_2027.arx placeholder in the worktree (ignored build output).
