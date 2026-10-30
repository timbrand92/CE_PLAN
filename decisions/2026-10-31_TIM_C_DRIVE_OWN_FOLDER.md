# Tim's ruling: no clutter at the root of C:, everything in its own folder, 31 Oct 2026

Recorded by CE 00 (desk chat), Sat 31 Oct 2026 about 07:40 Melbourne time.

> "in my c drive folder there are heaps of cluttered test folders or something like that can you clean that up and in future can you put all of this stuff in its own folder rather than just dumping in c drive"

## What was done (31 Oct, 07:2x to 07:4x)

1. 196 idle folders (old test, scratch, evidence and git working copies; 246 folders were at the root, 50 stayed) were MOVED, not deleted, into `C:\CE_WORK\old_clutter_31oct\`. The list is `MANIFEST_moved_from_C_root.txt` in that folder; the undo is moving a folder back to `C:\<name>`.
2. 140 of them were git working copies. They were moved with `git worktree move` and the 26 nested ones repaired with `git worktree repair`, so no repository lost track of them (checked: 0 broken links afterwards in the plugin repo, CE_PLAN and TimOS).
3. NOT moved: system folders, the main folders (CE_PLAN, TimOS, Lisp Files, ce_evidence_local, CE_DrawingIntelligence), and every live working area: `ce_rc_*`, `ce-fx`, `ce-scratch`, `ce-asm`, `ce-fin`, and anything touched in the last 3 days or named in a recent robot/builder script. Moving those now would break running lanes.

## The rule from now on (every chat, Claude and Codex)

1. **Nothing new goes at the root of C:.** Every new working folder, scratch folder, test copy, evidence folder or worktree goes under `C:\CE_WORK\<kind>\<name>`, with kinds: `build` (builder worktrees), `robot` (robot and driver scratch), `evidence` (local evidence work), `scratch` (anything throwaway), `codex` (Codex runs).
2. Keep paths short (native builds fail on long paths): `C:\CE_WORK\build\s12`, not a sentence.
3. A job text or lane script that creates a folder must clean it up at the end, or say in its report why not.
4. Deleting is a separate step and needs Tim's yes (RULES 10.4): old_clutter stays until he says.
5. The live root folders listed above move into `C:\CE_WORK\` at a quiet moment (no robot run, no builder), by the desk, using `git worktree move` for working copies. Their owners change the path constants in the same step.
