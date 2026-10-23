# Opus review of the unreviewed Team fix PRs, batches 5 to 15 (Sat 24 Oct 2026, 07:07 to 07:50 Melbourne)

Reviewer: Opus 5.5 (claude-opus-5-5), headless, desk plan/03. Independent of the builders. I read the code at the exact heads named below, not the PR text. Read-only: no PR or branch closed, deleted or pushed to; nothing deployed or installed; AutoCAD and Codex not started; Tim's settings and bundles not touched; DESK_LOG, QUEUE and BUG_CARPARK not edited; nothing marked FIXED.

Input: `PR_PILE_TRIAGE_2026-10-24.md` (present at the start, 04:36). Bases: Civil/Manager `claude/rel-20261023m` @ f7f7d551 (Civil 3.0.72 / Manager 1.1.72); Structural `claude/rel-20261023s` @ e6d597c0 (1.0.122). Every PR below branches straight from its base.

## ANSWER FIRST

1. **Four PRs reviewed. MERGE 4, MERGE-WITH-FIXES 0, HOLD 0, REJECT 0.**
   1. **#1730** (BUG-1085, BUG-1086: looking at CEMANAGER or About CE Suite no longer uses up the next U). MERGE, Civil/Manager train C-64. This is the Opus review its builder asked for (it touches Undo).
   2. **#1733** (BUG-1087: About CE Suite heading readable, dark grey instead of white on a pale band). MERGE, C-64.
   3. **#1728, new follow-up commit only** (BUG-1036: the Pipe Flows Roughness box now starts from the office Settings value). The earlier Opus review gave #1728 MERGE-WITH-FIXES; the fix it asked for is now in and correct. MERGE, C-64.
   4. **#1736** (BUG-1082: FFL, RL, SSL, NGL and LM draw nothing onto a locked 25DIMS or 25TEXT, and stop during REFEDIT). MERGE, next Structural train (S-44; `claude/rel-20261024s` is already cut).
2. **Top faults found:** none that stops a merge. Three small notes, none needing a fix before merging:
   1. **#1730's guard checks the command, not the whole Manager window.** The test proves CEMANAGER's own lines never change the drawing, but the Manager window's start-up code (which also runs inside CEMANAGER) is not covered. I read that start-up code: it changes nothing in the drawing today. A later edit could add a drawing change there without the test noticing. Worth widening the guard one day.
   2. **#1733 leaves one stored picture out of date:** `docs/image/V3_WINDOWS/automation-about-light-main.png` still shows the old white heading. The next picture refresh fixes it.
   3. **#1728: the box shows three decimals.** If an office ever sets concrete to 0.0125, the box would show and use 0.013. The pipe pre-fill already did the same before this PR; not new.
3. **Safe to merge today:** #1730, #1733 and #1728 (both commits) into C-64; #1736 into S-44. The only clash between any of them, and with C-63 (`claude/rel-20261024m`) or S-43 (`claude/rel-20261024s`), is the top of `REGRESSION_LOG.md`: keep every entry. All four are "built and unit-tested". Nobody has opened any of them in AutoCAD.
4. **Already covered elsewhere (not re-reviewed):** batch 5's #1722, #1729, #1731, #1732 and #1728's first commit, in `REVIEW_CX4_AND_BATCH4_24OCT.md`. #1722 and #1731 still owe the fixes that review asked for (heads unchanged: 544022b8, 115a5c19).
5. **Skipped, no batch report:** batches 6 to 13. Batch 6 has three branches on GitHub with no report: `fb/b6-bug1040-keep-flat-warning`, `fb/b6-bug1041-sheets-sync-scoped`, `fb/b6-bug1043-blank-invert-warns`. Not reviewed. Batches 7 to 13 have neither a report nor a branch.
6. **My one build:** #1730, #1733 and #1728 joined into one copy of the C-62 base (only `REGRESSION_LOG.md` clashed), net10, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, C: had 19 GB free. Manager tests on the touched areas: **40 of 40 passed**. Civil tests on Pipe Flows, roughness and calculations: **607 of 607 passed**. I listed the built test files: every new test of the three PRs is in them.

---

## Per PR

1. **#1730, BUG-1085 and BUG-1086: CEMANAGER and CE_VERSION leave no Undo step of their own (fb/b15-bug1085-bug1086-no-undo-step @ c9b41484). Verdict: MERGE. Train C-64.**
   1. **Cause real?** Yes. In `Modules/Manager/Commands/PluginManagerCommands.cs` both commands were plain `CommandFlags.Modal`, so AutoCAD wraps each in its own Undo step even though it only opens a window. A drafter who draws a circle, looks at Manager and types U gets "CEMANAGER" back, not the circle.
   2. **Does only what it says?** Yes. Two attribute lines gain `CommandFlags.NoUndoMarker` (the flag CDCHECKIGNORE already uses, which I confirmed in `CheckIgnoreCommand.cs`). Nothing else in the code changes.
   3. **Is the flag safe here?** It is only safe if nothing in the command changes the drawing. I read what runs inside each command:
      1. **CE_VERSION:** the About window only reads version numbers and has a Close button. No drawing change.
      2. **CEMANAGER:** the command opens (or brings back) the Manager window. The window's start-up code wires up pages, events and fills in text; I found no transaction, write-open, system variable change, document lock or sent command in it. Settings, updates and repair work done later from the open window run as their own steps and are unaffected.
      3. **Other drawing writers in Manager:** only CEBLOCKINSERT (which keeps its Undo step, and the test pins that) and the menu-bar setting, which runs at AutoCAD idle, not in these commands.
   4. **Test fails without it?** Yes for three of four: both attribute tests and the "only two commands drop the marker" count fail on the base. The fourth (no drawing writes) passes on the base by design; it is the guard that keeps the flag safe.
   5. **Redo safety:** nothing is written at all, so nothing can sit between a U and its REDO. Whether AutoCAD lets REDO work after a look-only command is AutoCAD's own Undo engine and is not proven; before this PR a normal command always broke REDO, so it cannot be worse.
   6. **Other risks:** no locked-layer or Xref question (nothing is drawn); CE_SHARED, installer and signed-update files untouched; no engineering value; no new hard block; no C-63 clash.
   7. **Small note, not a fix:** widen the "never writes" guard to cover the Manager window's start-up code (see ANSWER FIRST 2.1).
   8. **Left for others (builder's own note, agreed):** CESURVEYREVIEW, CEMANAGERUPDATES, CEMANAGERADMIN and CEBLOCKS open the same kind of window and probably leave the same Undo step. Not reported, not changed here.

2. **#1733, BUG-1087: the "CE SUITE" heading in About CE Suite is readable (fb/b15-bug1087-about-heading @ 02508426). Verdict: MERGE. Train C-64.**
   1. **Cause real?** Yes. `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml` had the heading fixed white on the header band `UiHeroHeaderBrush`, which is #F5F5F1 (near white) in the light theme: white on near white.
   2. **Does only what it says?** Yes. One line: the heading now uses `UiHeroHeaderTextBrush` (#242B31, dark grey), the same colour the Manager and Admin window headings already use. The line under it ("Loaded CE versions") already used the matching subtle colour and is unchanged.
   3. **Test fails without it?** The heading test does (it reads "White" on the base). The two contrast checks also pass on the base; they guard the colour pair, as the builder says.
   4. **Risks:** none of the listed kinds. The About window always loads the light theme itself, so the dark theme does not apply to it.
   5. **Small note:** the stored picture `automation-about-light-main.png` is now out of date (see ANSWER FIRST 2.2). It still needs a real look (Codex or Tim): a visible change is never accepted by tests.

3. **#1728 follow-up commit, BUG-1036: the Pipe Flows Roughness box starts from the office Settings value for concrete (fb/b5-bug1036-roughness-note @ 115eeaf0, on top of the already-reviewed 7620849b). Verdict: MERGE (the earlier MERGE-WITH-FIXES is now met). Train C-64.**
   1. **The fault it fixes was real:** the new note says the number is "from the pipe material, per office Settings", but with no pipe picked the box still started at a fixed 0.013 in `PipeFlowCalcViewModel.cs`.
   2. **The fix:** the starting value now comes from `DesignValidationService.GetManningsN("CONCRETE")`, the same table the pipe pre-fill reads. With the office defaults it is still 0.013, so nothing a drafter sees changes until Settings are edited. That lookup never fails: an unknown or broken entry falls back to the Settings "not recognised" roughness.
   3. **Typed values are still safe:** the "has the drafter typed anything?" check compares against the same starting value, so picking a pipe still fills an untouched box and never overwrites a typed one.
   4. **Test fails without it?** Yes: the new test sets concrete to 0.015 in Settings and expects the box to start at 0.015 (the base gives 0.013), then puts the value back.
   5. **Risks:** none of the listed kinds; no switch needed (it removes a fixed engineering number). Small note on three decimals in ANSWER FIRST 2.3.
   6. **Test run:** the builder recorded no run for this commit; mine covers it (607 of 607, above).

4. **#1736, BUG-1082: level marks never draw onto a locked 25DIMS or 25TEXT and stop during REFEDIT (fb/b14-bug-1082-level-mark-locked @ f25ddba1, base rel-20261023s). Verdict: MERGE. Train S-44 (S-43 is already cut as `claude/rel-20261024s`).**
   1. **Cause real?** Yes. `RunDirect` in `Modules/Structural/Commands/LevelMarkCommands.cs` (used by FFL, RL, SSL, NGL and LM) made sure the layers existed and then drew the triangle, tail and text with no lock check and no REFEDIT check. A drafter with 25DIMS locked got a level mark on it anyway.
   2. **Does only what it says?** Yes, 51 lines in one file:
      1. **Locked layer:** after the three questions and before anything is created or drawn, `LayerService.FirstLockedLayer(db, "25DIMS", "25TEXT")`. If one is locked: one "[CE] Layer … is locked" line, nothing drawn, nothing unlocked. This is the same check the rebar and bracing commands already use (BUG-367, HUNT-S-08), so one behaviour across the module.
      2. **REFEDIT:** the existing notes-tools rule (`NotesDrawingGuards.ShouldStopForRefEdit`) runs before any question in RunDirect and before LM's type question, and also stops if REFEDITNAME cannot be read.
   3. **Refuse, not warn:** right. This is the native protection rule (locked layers stay locked), not an engineering value, so "warn, never block" does not apply. It is not a new hard block in that sense.
   4. **Redo safety:** nothing is written before either stop. The only thing saved before the REFEDIT stop is moved after it (the "last level mark type" setting, a Settings file write, not a drawing write).
   5. **Test fails without it?** Yes: the four new cases do not compile on the base. They check the lines, and the order in the source (lock check before the first layer is made and the first object drawn; REFEDIT check before the first question). A real drawing test is not possible on this PC (a real AutoCAD database stops the test host), so the AutoCAD check in the PR is needed.
   6. **Other risks:** no CE_SHARED, installer, signed-update or Settings file; no engineering value; clashes with S-43 and the three batch 5 Structural PRs only in `REGRESSION_LOG.md`.
   7. **Not in scope (builder's note, agreed):** LMU (Level Update) still edits a picked text with no lock check. A separate carpark item if wanted.
   8. **Not built by me:** I reviewed #1736 by reading and test-merging. The builder reports Structural net10 5,684 passed, 0 failed, and a net48 build with 0 errors.

## Real-AutoCAD checks still owed (from the PRs, unchanged)

1. **#1730:** blank drawing copy. CIRCLE, CEMANAGER, close with X, U: the U must echo CIRCLE and the circle goes. Repeat with CE_VERSION and Close.
2. **#1733:** type CE_VERSION: "CE SUITE" reads dark grey on the pale band.
3. **#1728:** CDCALC > Pipe Flows with no pipe picked: Roughness 0.013 on office defaults; the note says "(from the pipe material, per office Settings)".
4. **#1736:** lock 25DIMS and 25TEXT, FFL at 0,0, Right, 10.000: nothing drawn, the line names 25DIMS. Unlock both: the normal mark. REFEDIT a block, type LM: the REFEDIT line, nothing drawn.

## What I did NOT check

1. **Anything in AutoCAD.** No command was run; REDO after CEMANAGER or CE_VERSION is unproven.
2. **The About window's look.** I did not open the window or any picture.
3. **#1736 was not built or tested by me** (read and test-merged only).
4. **Full test suites.** My runs were filtered to the touched areas (Manager 40, Civil 607). No net48 test lane, no Structural run.
5. **Batch 6** (three branches with no report) and **batches 7 to 13** (nothing on GitHub).
6. **Batch 5's #1722, #1729, #1731, #1732** were not re-reviewed (covered by `REVIEW_CX4_AND_BATCH4_24OCT.md`; their heads have not moved).
7. **The main checkout** `C:\Lisp Files\CE_ACAD_PLUGIN` shows an untracked `.codex/` folder that was not there when this job started. I did not create it and did not touch it.

## Environment

1. One read-only worktree `C:\ce-tr\b15` (detached at f7f7d551, the three PRs joined locally, never pushed), removed at the end. Scratch script and log `C:\ce-tr\b15run.ps1`, `C:\ce-tr\b15build.log`; TEMP and the CE log folder redirected to `C:\ce-tr\b15tmp`.
2. The shared `build.lock` was taken for the run. AutoCAD 2027 folder on PATH; refs as in the C-62 assembly report; the 0-byte `CE_TRANSFORM_2027.arx` placeholder in the worktree only.
