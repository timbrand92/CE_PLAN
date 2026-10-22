# Fix wave 2, batch 3 of 5: ledger top-25 fixes 11 to 15 (Fri 23 Oct 2026, 07:40 to 08:20 Melbourne)

## ANSWER FIRST

Four of the five are built, tested and open as DRAFT PRs. One (BUG-885) is skipped because it needs Tim's word first. Nothing is installed, nothing was run in AutoCAD, no bug is marked FIXED, no PR or branch was closed or deleted.

1. **#11 F-011, BUG-878 (import gives a pipe a level the file names for another pipe):** PR #1586, head `fca3e025`, branch `fw2/bug-878-named-level-outranks-shortcut`, base `claude/rel-20261022m`. New test red on the base, green after. Civil net10 total 19,155: 19,134 passed, 19 skipped, 2 failed (GlenEira detention back-test, a known failure on the train; the PDF render test, a flake that passes alone). No switch (bug fix).
2. **#12 F-158, BUG-968 (CDRENUMBER closes AutoCAD on a looped pipe record):** PR #1591, head `ffd8e500`, branch `fw2/bug-968-renumber-loop-guard`, base `claude/rel-20261022m`. Red proven: with the guard removed the renumber test run aborts on a stack overflow ("Test Run Aborted"); with it, all 44 renumber tests pass. Civil net10 total 19,157: 19,137 passed, 19 skipped, 1 failed (the same GlenEira back-test). No switch. F-202 (same-pass item) was not included.
3. **#13 F-019, BUG-885 (installer packaging rebuilds instead of sealing the accepted candidate): SKIPPED, needs Tim's word.** Options below.
4. **#14 F-122, BUG-946 (CEHEALTH says OK when Civil is installed but not loaded):** PR #1594, head `fc12426c`, branch `fw2/bug-946-cehealth-not-loaded`, base `claude/rel-20261022m`. Manager net10 855 of 855 pass. The new tests cannot compile without the fix. No switch.
5. **#15 F-124, BUG-948 (Updates & Rollback button refuses a colleague):** PR #1595, head `a388870b`, branch `fw2/bug-948-updates-button-colleague`, base `claude/rel-20261022m`. Manager net10 855 of 855 pass; the two new guards fail on the base. No switch.

**Totals note:** the Manager suite is 855 tests at this base (the train showed 903 to 916 after more PRs merged), so "thousands" holds for Civil only. Civil is 19,155 and 19,157, so the wrong-reference-name trap is not in play.

**Four words:** Built and unit-tested. Not installed. Nobody has opened any of these in AutoCAD. Not Tim-accepted.

## What each fix does, in AutoCAD terms

1. **BUG-878 (#1586):** a LandXML pit with one level that the file names for a different pipe used to hand that level to the one pipe joined there (pipe B got 9.75 m that belongs to pipe A). Now that pipe end stays Unknown and the import log says `no-level-names-this-pipe`. A single unnamed level, or a single level that names this very pipe, lands as before. Cause verified at the base: `XcivilPipeInsertionService.TryAssignNamedInverts` returned "old rule applies" for any one-level, one-pipe pit without checking the level's pipe name.
2. **BUG-968 (#1591):** two pipes recorded opposite ways between the same two pits (or a pit joined to itself) used to close AutoCAD at CDRENUMBER. Now CDRENUMBER says in plain words that the pipe records loop back on themselves at those pits, then shows the usual list and Yes/No. Nothing is blocked (R-27). Cause verified: `PitRenumberPlanner.Compute`'s `LongestUpstreamPathLength` recursed with no in-progress guard, and a .NET stack overflow cannot be caught.
3. **BUG-946 (#1594):** CEHEALTH now prints a `[WARN]` line for an installed tool that is not loaded in this AutoCAD session, counts it, and the last line says "1 issue(s) found" instead of "All checks passed". Cause verified: the NotLoaded status fell through to the `[OK]` branch.
4. **BUG-948 (#1595):** for a colleague who is not a CE administrator, the CE Tools Updates & Rollback button now opens the CE Manager window on its own Updates tab; an administrator still gets the administrator Updates tab. Opening the page grants no role. Cause verified: `CEMANAGERUPDATES` always went to `ShowAdminWindow`, which refuses non-administrators. One existing guard test (it counted exactly two "bring the open window back" calls) was raised to three on purpose.

## Skipped: BUG-885 (F-019), needs Tim's word

Cause checked. `Installer/build_installer.ps1` clears `payload_build`, rebuilds net48, net8 and net10, rebuilds the 2027 grip and object-enabler natives, then zips that tree. Its hash checks compare against those same fresh builds, not an accepted candidate. The 23 Oct Opus check found the installer EXE never unpacks that payload (all extraction is inside `#if false`, `Installer/Program.cs`), so the live risk is a hand install that copies this script's freshly built bundle.

Why I did not guess: "seal the accepted candidate" needs a decision on what the accepted candidate is and how the script receives it. It sits next to Tim's open install-route questions (F-016, F-017, F-023, F-025, F-026 in the Monday batch), and the script cannot be run here without writing to `C:\Lisp Files\SUPERSEDED` and rebuilding natives. The options:

1. **Recommended: add a "seal only" mode to the existing script.** Give it the frozen candidate folder as a parameter, and make it copy files from that folder only, with no `dotnet build` or MSBuild step, and refuse any file whose SHA-256 differs from the candidate's manifest. Keep today's full rebuild only for making a new candidate. Example on a job: Max's hand install can only ever contain the files Codex tested.
2. **Remove the rebuild path from the hand-install route** and make the hand install run the signed release-authority route (`ReleaseAuthorityPackaging.cs`) only. Safer, but it changes how Tim installs by hand.
3. **Leave the script and add a post-build check** that compares the zipped payload with the accepted candidate and fails on any difference. Smallest, but the rebuild still happens, so it only detects the fault.

Questions for Tim (batch, Monday): is "the accepted candidate" the folder the Codex run tested, and where does it live? Should the hand-install route refuse to rebuild at all?

## What was not tested

1. Nothing was opened in AutoCAD or accoreconsole; AutoCAD, Codex and the installed bundle were not touched.
2. net48 was not built for any of the four. Structural was not touched.
3. Base re-run of the two Civil failures was not done: the GlenEira failure matches the desk's known list (train notes record it as the 1 known failure); the PDF test passed when run alone.
4. The red-before proof for BUG-946 and BUG-948 is "does not compile" and "guard fails on the base" respectively, not a run against the old behaviour in AutoCAD.

## Housekeeping

1. Each fix had its own private worktree under `C:\ce-fx` (w878, w968, w885, w946, w948); all five were removed at the end. Each build and test ran in the foreground, always `-p:SkipDevBundle=true -nr:false --disable-build-servers`, with the C-57 reference paths, a fresh TEMP and the shared `desk_jobs\build.lock` held only while each command ran.
2. A local branch `fw2/bug-885-tmp` (empty, at the base, never pushed) was left because no branch is deleted.
3. REGRESSION_LOG.md has an entry on top of each PR. DESK_LOG.md and BUG_CARPARK.md were not edited.
