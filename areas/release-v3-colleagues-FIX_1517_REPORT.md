# FIX #1517 (CDCHECKIGNORE) after Opus review 1575 — report, 22 Oct 2026 about 17:00

## ANSWER FIRST

1. **Done. PR #1517 now sits on the C-59 line and is ready for the finalizer.** Base retargeted from `claude/rel-20261020l` to `claude/rel-20261022l`.
2. **Old head:** `bd84d3cf` (the head Opus reviewed). The PR was already at `9621f604` when this job started: an earlier Sonnet fix round (12:51 today) had fixed both MEDIUMs and LOW 1. I verified that commit by reading its diff and by running the tests, not by trusting its note.
3. **New head:** `440b13fa` (a merge of `claude/rel-20261022l` into the PR branch; only `REGRESSION_LOG.md` clashed, both sides kept, 0 markers). Pushed normally, no force.
4. **Tests added by this job:** none new. The two MEDIUM fixes are proved by the two existing red guards that Opus named, which now pass: `KeywordPromptBracketTagGuardTests.KeywordPromptMessages_CarryNoBracketTagThatIsNotARealKeyword` and `CrossModuleGuardTests.DuplicateCommandScan_CommandCounts_MatchStudyEvidence` (expects 146). LOW 1 and LOW 2 had no separate new test from me.
5. **Build and test totals (private worktree `C:\ce-fx\w`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, AutoCAD 2027 on PATH, 0-byte arx placeholder, own TEMP):** Civil test project net10 build 0 errors. Civil net10 full: **19,135 total, 19,115 passed, 19 skipped, 1 failed**. The one failure is the known `BackTest_GlenEira24115_Computed_WithinTolerance`. Civil net48 compile 0 errors.
6. **Dry merge with #1520** (`b04/bug-859-dp1-doubleclick`, 9daa061d) onto the merged #1517: clean, no conflicts (aborted afterwards, nothing pushed).

## What was fixed (Opus entry 1575)

1. **MEDIUM 1, keyword prompt:** the Ignore or Un-ignore question adds its two choices the house way (`Keywords.Add`, default Ignore, `AppendKeywordsToMessage`), so the BUG-174 guard can see them. Guard passes.
2. **MEDIUM 2, command count:** Civil count 145 to 146 in `CrossModuleGuardTests.cs`, with the CDCHECKIGNORE comment. Guard passes.
3. **LOW 1:** Un-ignore now lists 40, then says "... and N more", and accepts any number in the list, the same as Ignore.
4. **LOW 2:** no change needed. The store already trims a note and turns a blank one into none (`IgnoredChecks.cs` line 106), and `IgnoredChecksTests` covers whitespace.
5. **REGRESSION_LOG.md:** the 22 Oct fix-round entry is in (from 9621f604) and survives the merge.

## What was NOT done or tested

1. Not run in AutoCAD, accoreconsole or Codex. Not installed. Four words: built and unit-tested only.
2. The combined #1517 + #1520 result was dry-merged only, not built or tested.
3. Structural, Manager and Installer tests not run (nothing touched).
4. Merge order note: Opus said merge #1517 last in C-59 so the command-count line is right.

## Hygiene

1. No PR closed, no branch deleted, no bug marked FIXED, `DESK_LOG.md` and `BUG_CARPARK.md` not edited. Tim's settings files, installed bundles and ProgramData not touched. No version edits.
2. PR comment posted with the new head. Worktree `C:\ce-fx` removed after this report is pushed.
