# BATCH S-9 report (Structural, key s9, Sat 31 Oct 2026)

## ANSWER FIRST — FOR TIM

1. **No PR opened. Both bugs are still real on Structural 1.0.125, but neither is a small safe fix.** Both need a design decision from you first.
2. **BUG-626 (FFL has no source or Manual choice, no preview):** still true. FFL still asks point, side, value, then draws at once. The approved flow (pick trusted source or Manual, see the whole mark follow the cursor, F flips side, click to place) needs a "trusted level source" record that does not exist in CE yet.
3. **BUG-627 (MOVE on the triangle leaves tail and value behind):** still true. FFL draws three separate loose objects (triangle, tail line, text) with nothing tying them together. To move as one, they need a shared identity. That choice touches Undo/REDO, copy and erase.
4. **Mistakes of my own:** none. No code was edited, no build or test was run, so nothing could touch your settings files.
5. **Not proven:** I did not run AutoCAD. Both faults are confirmed by reading the code only.

## QUESTIONS (for CE 04 via CE 05)

1. **BUG-626 — what is a "trusted source" for a level?** Example: when you type FFL, should the list offer (a) Manual, (b) a level read from a survey or an earlier mark in the drawing, or (c) Unknown? My recommendation: ship Manual + Unknown only first (preview, F flip, click to place, with a "Manual" or "Unknown" tag saved with the mark), and add a real source list later. That fixes the "no preview" half now without inventing a source.
2. **BUG-627 — how should the three pieces be tied together?** Example: you MOVE the triangle and the tail and 12.345 follow. My recommendation: put the three objects in one named group (a normal AutoCAD group), so MOVE, COPY and ERASE treat them as one, with a Settings switch (on by default) and a warning only, never a block. Alternative: a hidden tag on each piece and a watcher that moves the rest, which is riskier for REDO.
3. **Approval:** the review gate in AGENTS.md also needs a command card approved for the FFL/RL/SSL/NGL family before code. The card exists (structural_level_mark_daily_card.md, in CE_PLAN reference) but I found no recorded Tim approval of the move-compound or source steps.

---

## TECHNICAL

1. **Start point:** origin/claude/rel-20261026s, head 204dfad2 (Structural 1.0.125). Worktree C:\ce-fx\s9w created and removed; branch claude/s9-ffl has no commits (not deleted, per D6).
2. **Fault evidence, BUG-626:** Modules/Structural/Commands/LevelMarkCommands.cs `RunDirect` lines 151-263. Point (166), side keyword (170-177), value string (179-185), then one transaction (211-251). No jig, no source prompt. Empty value just returns (184), so the "blank invents zero" worry does not arise.
3. **Fault evidence, BUG-627:** same file, lines 215-248: `CreateLevelSymbol` Polyline, `Line` tail, `DBText` label appended separately; no group, XData, extension dictionary or reactor. Nothing links them. (The BUG-1082 locked-layer/REFEDIT stops, lines 157 and 198-204, already exist and must be kept.)
4. **Related, already fixed, not these bugs:** f25ddba1 / PR 1736 (BUG-1082, locked layer and REFEDIT).
5. **Shared-file check:** gh is not on this tool PATH, so open Structural draft PRs touching LevelMarkCommands.cs could not be listed. Not checked. The batches file lists no other batch for this file.
6. **Settings switch design if approved:** `annotation.levelMarkGroupsComponents` (ON), documented "Default: on.", pinned in the new-switch-defaults test through SettingsService.DeserializeSettings and DeserializeSettingsTolerant; switch OFF restores the current three loose objects.
7. **Robot case if built:** N-style `S9_ffl_move` — type FFL, pick, Right, 12.345, then MOVE picking the triangle by click; check the tail and text entities moved by the same delta (switch-off control: only the triangle moves).
8. **Real-files listings:** no dotnet test was run, so before/after listings were not needed and none were taken.
