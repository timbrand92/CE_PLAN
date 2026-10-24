# FB Team batch 10 report: BUG-1060 to BUG-1064 (Sat 24 Oct 2026, about 2:30 to 3:25 pm Melbourne PC clock)

Team, Sonnet 5.5, headless. Built and unit-tested only. Nobody has opened anything in AutoCAD. I installed nothing, ran no AutoCAD, Codex or accoreconsole, touched no Settings file, bundle or ProgramData, closed no PR, deleted no branch, marked no bug FIXED, and did not edit DESK_LOG.md, QUEUE.md or BUG_CARPARK.md.

## ANSWER FIRST

1. **BUG-1060 (R-24 shows 2021): SKIPPED.** Needs Tim's word. The cause is confirmed (the default string is 2021 and nothing else uses it). The fix is not a string change: it is a design choice about office Settings versus an issued-job record. Options are below. Codex's FA03 report (PR #1715 on `cx4/fa03-drainage`) reached the same disposition, so there is no duplicate to comment on.
2. **BUG-1061 (rebated beams use full depth): FIXED IN DRAFT PR #1762**, head `f5cd021473307d8d40b0cb687c11fc293870ade6`, branch `fb/b10-bug1062-bar-room-warning`, base `claude/rel-20261023s` (head `e6d597c0fbc25e78118760887a70810e0890c9a9`). Not installed; AutoCAD check owed.
3. **BUG-1062 (no-room warning vanishes at zero width): FIXED IN THE SAME DRAFT PR #1762.** Same head.
4. **BUG-1063 (spacing overstated by one bar diameter): FIXED IN THE SAME DRAFT PR #1762.** Same head. One PR for three bugs because all three are the same window and the same rule; the commit message names BUG-1061, BUG-1062 and BUG-1063 in full.
5. **BUG-1064 (two installers at once): SKIPPED.** Protected Installer code (`Installer/SafeBundleInstaller.cs`). Codex's FA04 (PR #1714, `cx4/fa04-rd08-desk`) also skipped it and routed it to the protected Installer owner. No fix exists to comment on. Options below.

## Tests and totals (PR #1762)

1. **New tests:** `RcBeamBarRoomTests`, 17 cases, 17 passed on net10. They cover: spacing 294 at 410 wide and 314 at 430 wide; no-room at cover 65 and 66 (true), cover 40 on 300 wide (false); the Type 4, 6 and 7 rebate zones; the 153 mm needed versus 125 mm remaining case; and a source guard that the window (twice, warning and preview) and the section writer all call the shared rule and the old spacing arithmetic is gone.
2. **Structural net10 run in chunks** (excluding the Sbeam, Window and Sheets name groups): Core, Models, Rules, Build and UI 1,636 passed, 1 failed; Services A to C plus the git test 1,469 passed; D to M 798 passed; N to Z (not S) 1,052 passed; S excluding Sbeam 514 passed; Commands excluding Sbeam 178 passed (1 failed). The two failures were the same test, `ManagedPublicApiAndReferences_MatchAcceptedBase`, which failed only because `git` was not on my PATH; it passed once git was on the PATH (inside the 1,469 run). The chunks overlap slightly, so do not add them blindly; the total is well over 5,000 with 0 real failures.
3. **net48 Release compile of Structural:** 0 errors, 0 warnings (needs Windows PowerShell on PATH for its post-build step).
4. **RED on the base:** not in the usual sense. The helper the tests call does not exist on the base, so the test project does not compile there. I did not run a stash-style RED.
5. **One earlier whole-suite run** (filter excluding Sbeam, Window, Sheets) ran past 25 minutes and was stopped by me; that is why the run was chunked.
6. **Regenerated window PNGs** under `docs/image` from the UI chunk were reverted and not committed.

## What changed in PR #1762

1. **New `Services/RcBeamBarRoom.cs`:** the rebate zone, the bar spacing and the no-room test in one place.
2. **`UI/Dialogs/RCMemberDialog.xaml.cs`:** warnings and preview use it. Rebate depth is read from the rebate box for Types 4, 6 and 7 only.
3. **`Commands/SectionDetailCommands.cs`:** the writer reads the same zone (same numbers as before, now from the shared rule, so the drawing is unchanged).
4. **No Settings switch:** only warning wording and the preview picture change; the placed drawing is the same. If Opus wants a switch for the preview, it is a small addition, but it would need the dialog to read Settings, which it does not today.
5. **Boundaries:** Shared, Installer, signing and Settings files untouched. No document write added, so Undo and Redo are unaffected. Locked layers, Xrefs and REFEDIT untouched.

## Real-AutoCAD check (from PR #1762)

Synthetic mm drawing, DIMSCALE 20.
1. **BUG-1062:** RCBEAM, Plain Beam, 150 wide, 500 deep, N10, bottom 3 N16, Top bars off, cover 64, then 65, then 66. The "Cover and stirrups leave no room for the bottom bars" warning stays on at 65 and 66. Place Section still works.
2. **BUG-1063:** Plain Beam 410 x 500, cover 40, N10, bottom 2 N16, top off. No over-300 warning. Place Section at 0,0 and measure the two bar centres: 294 mm. At 430 wide the spacing is 314.
3. **BUG-1061:** Type 4 Edge + Rebate, 300 x 200, rebate 100 x 75, slab 100, cover 40, N10, bottom 3 N16, tick Top bars 2 N12. The window says only 125 mm remains against 153 mm needed, and the preview top and bottom bars are close together as drawn. Place Section at 0,0 and LIST the circles: top and bottom bar centres match the preview and the warning.
4. Also check Type 6 (rebate at the bottom): the preview bars shift up the same way the placed bars do.

## What I did NOT test

1. Nothing was run in AutoCAD. The window text and the preview picture are WPF and were not rendered.
2. The Sbeam, Window and Sheets name groups were not run (known slow, and the Window group regenerates PNGs).
3. net8.0-windows build not run.
4. The AS 3600 clause numbers in the existing warnings were not checked (BUG-1063's 300 mm trigger is a separate standards question and was not touched).

## BUG-1060: options for Tim

1. **Recommended:** keep an office reference edition in Settings plus an explicit edition on each issued job. New jobs ask "confirm the edition for this job"; jobs already issued under 2021 keep 2021 with a "current edition is newer" notice.
2. **Alternative:** job-only edition, with no implied office compliance. Simpler, but every new job starts with a blank to fill.
3. Either way: the Victorian regulator's page says work starting on or after 20 October 2025 must comply with the 2025 edition. Changing the string does not make any calculation 2025-compliant, and needs Tim's word on how it applies. It also needs a Settings-page layout decision (the Civil Settings page has no edition editor today).

## BUG-1064: options for the protected Installer owner

1. **Recommended:** one machine-wide installation lock (a named system mutex) taken before the final checks and held until recovery finishes. A second run waits with a plain message and re-checks the target once it owns the lock. No new permanent block.
2. **Alternative:** keep OPEN until the Installer owner can act. A Manager-only lock would leave direct installer runs exposed.
3. **Test to use:** two real processes with controlled checkpoints, not a nested same-thread run (a re-entrant mutex would pass without proving anything). Fixtures in disposable folders only; never the live plugin folders.

## Housekeeping

1. **Duplicate search:** `gh pr list --state all --search` for each bug id and finding id. BUG-1060: #1715 (Codex disposition, no fix). BUG-1061: #1560 and #1385 are different bugs (BUG-976 notes, BUG-755 thumbnail crop). BUG-1062, BUG-1063: nothing. BUG-1064: #1714 (Codex routing only, no fix). `git ls-remote origin cx4/*` listed fa01 to fa07; none touch the RCBEAM window.
2. **Base heads recorded:** `claude/rel-20261023m` `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (Civil, not changed); `claude/rel-20261023s` `e6d597c0fbc25e78118760887a70810e0890c9a9` (Structural, the PR base). The Structural base is the S-42 train; a newer S-43 assembly report exists, so the PR may need a rebase onto that train when it is built.
3. **Cleanup:** worktree `C:\ce-fx\b10a` and scratch folder `C:\ce-fx\b10` removed after this report; nothing else in `C:\ce-fx` was touched.
