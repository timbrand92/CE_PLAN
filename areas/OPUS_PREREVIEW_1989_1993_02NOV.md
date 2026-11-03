# Opus pre-review: draft PRs #1989 to #1993 as one group (Mon 2 Nov 2026, evening, Melbourne)

Read-only drafting job for CE 05, on the CE 00 order of Mon 2 Nov 20:45. Written by Opus. Nothing built, nothing tested, nothing installed, AutoCAD not opened.

## FOR TIM

1. **Verdict:** three are ready (#1989 Cascade Preview warnings, #1990 CDSYNC keeps IL 17.900, #1991 "Downstre" caption). Two need one small joint change first (#1992 shallow-fall wording, #1993 red error row).
2. **Why the two need a change:** each one makes its own Settings group called "validation", with different contents. Put both in one build and it will not build. Fix: one "validation" group holding both switches. About 15 minutes for one fix job, no change to what you see in AutoCAD.
3. **None of the five is in what you have installed** (Civil 3.0.89), nor in the next two candidate builds (3.0.90 and b2). They only reach AutoCAD once a later build takes them in.
4. **What each does on the drawing:** Cascade Preview lists its warnings before you press Apply; CDSYNC stops turning IL 17.900 into IL 17.90; Edit Pipe stops cutting "Downstream" to "Downstre"; a 4 mm fall on 2 m says "Very shallow fall: 4 mm over 2.0 m, 1 in 500"; an uphill pipe row in Design Warnings shows red.
5. **Every one has an off switch** that puts things back exactly as they were. All five ship ON.
6. **Not proven:** nobody has opened any of these in AutoCAD. The colours, the caption and the warning list need a Codex look; the CDSYNC cause is read from code, not watched.
7. **Still yours to decide (not new, already queued via CE 04):** should a downhill fall inside the 5 mm band be a warning at all; and the Design Warnings footer still says "Warnings are informational - the pipe has been saved." under a red error row. What wording do you want there?
8. **Nothing for you to do tonight.** CE 05 sends the one fix job for #1992 and #1993.

---

## What I did

1. **Read:** `C:\TimOS\RULES.md`; the five PR diffs (taken from the PR heads with `git diff` against `origin/claude/rel-20261102a`, because `gh` is not on this shell's path; PR file lists and titles confirmed with `gh pr view` by its full path); the five reports `areas\BUGFIX_w655/w1270/w1271/w1092d/w1092c_REPORT_02NOV.md`; the carpark entries for BUG-1269, BUG-1270, BUG-1271, BUG-1092 and the CE 05 notes under them (C:\CE_PLAN at 43d3f77a, 20:29); the surrounding product code for #1990 (`ApplyGradeLockToInverts`) and #1992 (`CheckReverseFall` on the base and on 3.0.89, `MathHelper.ActualGradeDenominator`); the Cascade Preview window's row layout; the theme files for `ErrorBrush`; each new test file's settings-read lines.
2. **Fetched first:** `git fetch origin` at the start of this job, then the five `refs/pull/N/head`.
3. **Merge check:** read-only `git merge-tree` (old form, writes nothing) of each PR into 3.0.90 (cf059dcf) and of the PRs against each other.
4. **Built:** nothing. **Tested:** nothing (no test run; I read the tests, I did not run them). **Installed:** nothing. **Opened AutoCAD:** no.

## Where the five sit (the build question)

1. **PR heads:** #1989 = 035d1976, #1990 = 5b6119d7, #1991 = a4c611eb, #1992 = 0aa753f7, #1993 = 2e3d74a4. Each is one commit on top of `origin/claude/rel-20261102a` = 3fbb9da5.
2. **The base is older than what is installed:** 3fbb9da5 is "Version: Civil 3.0.88 (C-78)". It is an ancestor of installed Civil 3.0.89 (61fd6fbc), which is in turn inside 3.0.90 (cf059dcf) and b2 (`origin/claude/rel-20261110a` = d4ce878e).
3. **In installed 3.0.89 (61fd6fbc):** none of the five (`git merge-base --is-ancestor` false for all five heads).
4. **In candidate b1 = 3.0.90 (cf059dcf):** none of the five. **In b2 (rel-20261110a, d4ce878e):** none of the five. I also searched those three trees for each new switch name: zero hits, so no copy came in by another route either.
5. **Consequence:** the five were written and unit-tested against 3.0.88, not against 3.0.89. The base lacks PR #1887 (the uphill rule, commits d7bfa1d4 and 0d5e3d98), which IS in 3.0.89. I checked how #1992 meets #1887 below.

## Per PR

### #1989 (B-161, BUG-1269): Cascade Preview lists the plan's warnings before Apply. Verdict: GO

1. **Does what the carpark says, nothing more:** yes. Adds one list bound to the already-built `Warnings`, in warning colour, under the errors list, never blocking Apply. No warning text changed. One `StackPanel` wrapper in the same row so the two lists do not overlap; row 4 is an Auto row with the pipe table in a star row above, so the 72-high list takes room from the table, not from the Apply footer. The window size (980 x 640) is unchanged.
2. **OFF gives the old behaviour exactly:** yes. The list is collapsed by its style unless `ShowPlanWarnings` is true, which needs the switch ON and at least one warning. The `Warnings` collection was already filled before; nothing else moved.
3. **Switch through both start-up reads:** yes, the test reads `{}`, a file without the group and an empty group through `DeserializeSettings` and `DeserializeSettingsTolerant` (read, not run by me).
4. **CE_SHARED:** none. **Locked layer / Xref:** nothing touches the drawing. **Hard-coded engineering value (R-00):** none (72 is a window height). **REDO:** display only, nothing written, safe.
5. **Merge note:** a plain "keep both" overlap in `UserSettings.cs` with #1993 (both add a group after `checks`) and in `REGRESSION_LOG.md` with 3.0.90. No code clash.
6. **Not proven:** the colour, that nothing is cut, and the scroll on a long list. Needs the Codex look the report asks for. The report admits the new window tests were not run against the unfixed window (no failing control).
7. **The one sentence for Tim:** "Edit Pipe, Recalculate downstream inverts now tells you in the preview, before Apply, when a lower pipe at a pit will set the outgoing level."

### #1990 (B-162, BUG-1270, decimals half only): CDSYNC keeps IL 17.900. Verdict: GO

1. **Does what the carpark says:** yes for the decimals half (the depth half, P8 1.00 to 1.10 m, stays OPEN and is not touched). One early stop before the held-grade write: if the worked-out levels are the same as the drawn ones at the Settings decimals, nothing is written.
2. **Slightly wider than the name:** the check sits in the held-grade re-work, which runs for any pipe marked changed (a pit move or a stretch as well as CDSYNC), not CDSYNC alone. I worked it through: at 2 decimals the old path would have written the same number cut to 2 decimals, so the only thing lost is that format change. A level that moves 5 mm or more still writes. Harmless, but the switch name `cdsync.keepsLevelTextFormat` undersells where it acts. No change asked; the report says so in its item 6.
3. **One edge to put in the robot case, not a blocker:** when it stops early it also skips `MirrorGradeLockToPartnerHalf`, the step that copies levels to the other half of a split pipe. If the other half's label was already out of step, the old path would have re-copied it (cut to 2 decimals) and the new one leaves it. Suggest CE 02's twin includes one split pipe.
4. **OFF gives the old behaviour exactly:** yes. `KeepsStoredLevelText` returns false at once when the switch is off, and the old write path runs unchanged.
5. **Switch through both start-up reads:** yes (`{}` and an empty `cdsync` group through both reads; typed false reads false).
6. **CE_SHARED:** none. **Locked layer / Xref:** it removes a write; the write path that remains is unchanged. **R-00:** none; the decimals come from Settings "Calculated decimals", and the 0 to 4 clamp copies the line already above it. **REDO:** safer than before (one write fewer).
7. **Merge note:** `LinkService.Utilities.cs` merges into 3.0.90 with no clash; plain "keep both" overlaps in `UserSettings.cs` (with #1992, same spot after `help`) and in `REGRESSION_LOG.md`.
8. **Not proven:** the cause is matched to the robot's reading by code reading only. The robot case (PROBE-CDSYNC-BA steps, ON twin `IL 18.100 | IL 17.900`, OFF twin `IL 18.100 | IL 17.90`, grade text still `1 IN 100`) is what proves it.
9. **The one sentence for Tim:** "CDSYNC will no longer turn a typed IL 17.900 into IL 17.90; the pit depth change you also saw is a separate fault and still open."

### #1991 (B-163, BUG-1271): Edit Pipe level caption keeps room for "Downstream". Verdict: GO, with one plan-record correction

1. **Does what the carpark says, nothing more:** yes. One minimum width (68) on the two level-tick captions, only when the switch is ON. No new row, no window size change, no wording change. New Pipe uses the same window and gets the same fix.
2. **Plan-record correction (CE 05, not code):** the carpark entry names the switch `edit.captionsKeepFullWidth`; the PR uses `pipe.editCaptionsKeepFullWidth` (there is no `edit` group; it sits beside `pipe.declutteredLayout`). The PR choice is right. Update the carpark entry so nobody sets the wrong key in the OFF twin.
3. **OFF gives the old behaviour exactly:** yes. With the switch off the MinWidth line is skipped and the branch does exactly what it did (Width NaN, no wrap, same margin); the test checks MinWidth 0 and Width NaN when off.
4. **Switch through both start-up reads:** yes, four file shapes through both reads, plus a missing settings file.
5. **CE_SHARED:** none. **Locked layer / Xref:** window only. **R-00:** 68 is a window measurement, not an engineering value; it is smaller than the 112 the window file first gave the caption. **REDO:** window only, safe.
6. **Merge note:** a real (but simple) overlap with 3.0.90: BUG-1091's `largePipeRedesignReadsMinFall` was added at the same place in the pipe settings. Resolve by keeping both lines. Plus `REGRESSION_LOG.md`.
7. **Not proven:** the first-open clip was never reproduced; the cause is read from Codex's picture (the cut word is exactly the width of "Upstream"). If the cause is something else, the ON twin will still show "Downstre". Needs the Codex look.
8. **The one sentence for Tim:** "The word beside the first level tick in Edit Pipe should read 'Downstream' in full the first time the window opens."

### #1992 (B-164, BUG-1092 downhill half): a real shallow fall states its figure. Verdict: CHANGE-NEEDED (joint with #1993)

1. **The change needed:** #1992 adds `UserSettings.Validation` of type `ValidationSettings` (JSON `validation`); #1993 adds `UserSettings.Validation` of type `ValidationDisplaySettings` (also JSON `validation`). Git merges them without a conflict marker (they sit in different places in the file), so the clash only shows at build: two members named `Validation`, and two classes claiming the same Settings key. Fix: ONE class `ValidationSettings` holding both `shallowFallStatesFigure` and `errorRowsShowRed`, one `validation` property. Recommended route: land #1992 as is; rebase #1993 onto it, move `ErrorRowsShowRed` into `ValidationSettings`, delete `ValidationDisplaySettings` and its property. Both test files already read `loaded.Validation.<switch>`, so they keep compiling.
2. **Otherwise does what the carpark (CE 00 ruling, 17:20) says:** wording only. Same severity (Warning), same code (`CodeGradeTooFlat`), same 5 mm tolerance from Settings, same count. The wording matches the ruling exactly ("Very shallow fall: 4 mm over 2.0 m, 1 in 500"); the 1-in-N comes from the existing shared `MathHelper.ActualGradeDenominator`.
3. **Meeting #1887 (already in 3.0.89):** #1887 changed the uphill branch just above; #1992 changes only the "flat" branch. The read-only merge into 3.0.90 is clean in `DesignValidationService.cs`. With #1887's switch ON, a tiny uphill (beyond 0.000000001 m) goes to the red error first; anything left in the flat branch with no real fall keeps "essentially flat" because `ShallowFallText` needs a positive fall of at least 1 mm when rounded. With #1887's switch OFF, a small uphill lands in the flat branch and keeps the old words. Both combinations behave. Not run.
4. **OFF gives the old behaviour exactly:** yes, the first line of `ShallowFallText` returns the old sentence character for character.
5. **Switch through both start-up reads:** yes (`{}`, `{"validation":{}}`, a file without the group, typed true and false).
6. **CE_SHARED:** none. **Locked layer / Xref:** nothing written. **R-00:** none new; the 1 mm "shows at all" threshold is display rounding matching the uphill line. **REDO:** message text only, safe.
7. **Small note, no change asked:** the switch read here has no `try/catch`, unlike #1887's `UphillSwitchOn` next to it. Same pattern as #1990 and #1991, so consistent with most of the code.
8. **The one sentence for Tim:** "A pipe with a real 4 mm fall on 2 m will say 'Very shallow fall: 4 mm over 2.0 m, 1 in 500' instead of 'no measurable fall'."

### #1993 (B-165, BUG-1092 window colour): Design Warnings shows an Error row in red. Verdict: CHANGE-NEEDED (joint with #1992)

1. **The change needed:** the same one as #1992 item 1: move `ErrorRowsShowRed` into the shared `ValidationSettings`, drop `ValidationDisplaySettings`. While there, put the class somewhere else: it was inserted between the existing `/// <summary> Grade settings </summary>` comment and `GradeSettings`, so that comment now describes the wrong class (the same slip the w655 report caught in its own work).
2. **Otherwise does what the carpark note (CE 05, 19:20) says:** one trigger reading the row's severity; red bullet and red words for an Error row only; warning rows unchanged. The footer wording was left alone, as told.
3. **OFF gives the old behaviour exactly:** yes. With the switch off the converter returns false, the trigger never fires, and the two text pieces keep their old amber bullet and normal text colour. Naming the two text pieces (`RowBullet`, `RowMessage`) changes nothing on screen.
4. **Switch through both start-up reads:** yes, three file shapes through both reads, typed false.
5. **CE_SHARED:** none. **Locked layer / Xref:** window only. **R-00:** none. **REDO:** window only, safe. `ErrorBrush` exists in both the dark and light themes.
6. **Small note, no change asked:** the converter reads the switch each time a row is drawn, not once at start. Settings are read at AutoCAD start anyway, so in practice it is the start-up value.
7. **Merge note:** clean into 3.0.90; "keep both" overlap with #1989 in `UserSettings.cs`.
8. **Not proven:** that it looks red. The robot cannot judge colour; needs the Codex look.
9. **The one sentence for Tim:** "In the Design Warnings window an uphill pipe now shows in red, so you can tell an error from a plain warning at a glance."

## Points that apply to the whole group

1. **All five rest on Civil 3.0.88, not 3.0.89.** Every one merges into 3.0.90 apart from routine "keep both" overlaps (the change log in all five, the pipe settings in #1991). The only real clash is #1992 against #1993 (above).
2. **Order suggestion for the train:** #1992 first, then the fixed #1993, then #1989, #1990, #1991 in any order. Each adds its own block in `UserSettings.cs`; keep every block.
3. **Real-file listings:** all five reports say Tim's AppData files changed during their runs and put it on another job's AutoCAD (robot or a live session). Each says it cannot fully prove it. I did not check this (read-only job). The w1270 report names `CD_Settings.json` changing 3 seconds before an AutoCAD start (12:03:22), the one file it could not separate by time. Worth CE 05 asking CE 02 whose AutoCAD that was.
4. **None marked FIXED,** correctly. All five bugs stay OPEN until the ledger accepts them by name.

## Skipped, and why

1. **Did not build or run any test** (read-only order). Every "yes" about tests above is from reading the test files.
2. **Did not read every line of each test file**, only the parts that read settings and the checks named in the reports.
3. **Did not read PR #1967 (B-119)**, which also touches `DesignValidationService.cs`; the w1092d report says it does not change `CheckReverseFall`. Not checked by me.
4. **Did not check the robot case drafts** (job 226, `areas\ROBOT_CASE_DRAFTS_FIXES_1989_1993_02NOV.md`); outside this order.
5. **Output path:** the order named `C:\CE_PLANreas\...`, which does not exist; read as `C:\CE_PLAN\areas\` (the backslash-a was lost). Written there. Not committed or pushed (CE 05 pushes).
