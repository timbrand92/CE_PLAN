# BUGFIX w235 report: BUG-235 (a copied pit must not steal a pipe end) — 3 Nov 2026

**Result: ALREADY FIXED in code. No PR opened. Nothing built, nothing tested, no AutoCAD.**

## FOR TIM

1. **What you will see:** copy a pit so its outline touches a pipe end that belongs to another pit. The pipe end stays with the original pit. If the copy lands exactly on top of the original, the end still stays with the original, and CE prints one plain line, for example "P11 sits on pipe ends already joined to P3; they stay joined to P3."
2. **Why no new work:** this is the same fault as BUG-1227 Part A (robot N35 / R34). That fix is already on the release branch. The old pit keeps its pipe ends and the copy is not offered them. It never blocks the copy (R-27).
3. **My own mistakes:** none. I did not run any build or test, so the disk and settings-folder listings were not needed.
4. **NOT proven:**
   1. Nobody has seen this in AutoCAD for BUG-235's exact case (a copy placed slightly nearer than the original, not on top). The code handles it by the same rule, but the robot case N35 covered the on-top case.
   2. The second half of BUG-235 (one Undo reverses all the copy's link writes) is not checked by any test I can find. It needs the robot to run COPY, then U, then compare the pipe ends.
5. **Robot case that would prove it (with switch-off control):** type COPY on pit P3 with a displacement of 50 mm, so the copy's outline touches P3's pipe ends. Check that P3 still lists every pipe. Then type U once and check P3 and the pipes read as before the copy. Control: set linking.pitCopyKeepsOriginalPipeEnds to false before launching AutoCAD, repeat, and expect the copy to take the ends it is nearer to.

## TECHNICAL

1. **Base:** origin/claude/rel-20261102a at 3fbb9da5 (C-78). Commit 28d8b972 ("BUG-1227 Part A: a pit copied on top of a pit keeps off the original's pipe ends") is an ancestor of it. The 61fd6fbc named in the task is not an ancestor of the current release head (or is unknown here), so I read the current head instead.
2. **Stable identity beats proximity:** `Modules/Drainage/Rules/CopiedPitEndOwnerGuard.cs`, `Decide` (about line 70). A pit that is already joined to the end and still touches it is the keeper. Every pit not joined to it yields, copy or not. Ties break as before.
3. **Wiring:**
   1. `Services/LinkService.PitRelinks.cs:57` and `:97` pass the copied pit handles (`PendingCopiedPitHandles`).
   2. `Services/LinkService.RepairAudit.Relink.cs:691` builds the guard.
   3. `Services/LinkService.RepairAudit.Relink.cs:852` and `:1100` print the plain warning.
   4. `Services/LinkService.Geometry.cs` carries `copyGuard` through the owner picker.
4. **Switch:** `linking.pitCopyKeepsOriginalPipeEnds`, `Models/UserSettings.cs:971`, default true. Pinned in `Drainage.Tests/Services/C78NewSwitchDefaultsTests.cs:107` and in `Bug1227PitCopyKeepsPipeEndsTests.cs` (lines 173 to 193).
5. **Locked layers, Xref and REFEDIT:** the guard changes who is offered an end, not what is written. The existing locked-layer rule for relinks is untouched.
6. **Gap left open:** one-Undo of the copy's separate link-write steps. I did not read the transaction structure in depth. I did not change it, so I cannot say whether it is one step. This needs a robot Undo case, or a separate card if the robot shows two Undos are needed.
7. **Cleanup:** worktree C:\CE_WORK\build\w235 removed. Nothing was built, so almost no disk moved (C: free 68 GB).
