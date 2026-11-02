# BUGFIX w396 REPORT, 3 Nov 2026 (B-178, BUG-396 double-click opens Pit Schedule)

## FOR TIM
1. **Result: NOT BUILT, and no PR opened.** The double-click on a placed Pit Schedule is still unbuilt on the release branch, and building it needs two things I am not allowed to do alone.
2. **What you see today:** double-click a cell in the placed schedule and AutoCAD's own text editor opens (blank, "Undefined shape" lines), as Codex saw on 18 and 19 Oct.
3. **Why I stopped:**
   1. It is a new double-click route, so it needs the command card first.
   2. The Pit Schedule window has no way to open at a chosen pit; that is a window change, which is Codex's.
4. **Mistakes of my own:** none; I changed no code, built nothing, ran no tests, started no worktree.
5. **Not proven:** that the table's double-click is an AutoCAD table edit (taken from Codex L4-08 evidence, not re-run).
6. **Needs your word (two one-line questions):** in `areas\BRIEF_W396_DOUBLECLICK_02NOV.md` section 5.
7. **Robot case:** named in the brief section 6 (types a double-click on the P2 cell; checks the window opens on P2 and no MTEDIT; switch-off control expects MTEDIT).

## Technical detail
1. Confirmed on origin/claude/rel-20261102a 3fbb9da5: `Modules/Drainage/Services/DoubleClickEditTable.cs` ~line 124, NoWindow("pit-schedule", ...) saying it needs its own workflow card (G5). No start-at-pit entry in PitScheduleDialog / schedule commands.
2. `git log --grep=396` shows only item 6 (diagnostic wording) and 7a (bare 8 rename) commits.
3. Not ALREADY FIXED. No open draft PR checked (gh not on this PATH); none expected since nothing built.
4. Isolation listings (APPDATA folders before/after): not taken, because no test or build ran and nothing wrote anywhere.
5. Disk: C: 28 GB free at start; no worktree, so nothing to release.
