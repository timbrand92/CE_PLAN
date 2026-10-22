# TRAIN S-42 (Structural) assembly report, 23 Oct 2026

Branch `claude/rel-20261023s`, pushed. Built and unit-tested only. Nobody has opened this train in AutoCAD. I installed nothing, ran no AutoCAD or accoreconsole (acad.exe was not running at the start or the end of my runs), changed no version field, closed no PR, deleted no branch, marked no bug FIXED, did not edit DESK_LOG.md. Fri 23 Oct 2026, about 09:32 to 09:55 Melbourne (PC clock). Sonnet 5.5, Team, headless.

## ANSWER FIRST

1. **Branch `claude/rel-20261023s`, head `c490b3077da5c9a8044253778fa4f54674172912`**, pushed (local equals origin, checked again at the end). Base `origin/claude/rel-20261022s2` at `2c9a96942a024888a5ab520600f2d5025de83036` (installed Structural 1.0.121, train S-41): `git ls-remote` gave exactly that at the start. The name `claude/rel-20261023s` was free on origin.
2. **2 of 2 PRs merged, 0 skipped.** Plain `git merge --no-ff`, one merge commit each, no squash, rebase or cherry-pick.
   1. **#1547** live head `61ce20de2e5f7c87dfd7e7bf5855e11bdde3a3fc` (equals the fix-round head), merge `a3b2ff0b`.
   2. **#1533** live head `40c9a97735a7ff55f52568d796ba41d5c0d1997f` (equals the fix-round head), merge `c490b307`.
   3. Both heads were re-read with `gh pr view` immediately before each merge and again at the end: unchanged. Neither was already in the base (`merge-base --is-ancestor`).
3. **Left out, as ordered:** every Civil and Manager PR (train C-61), #1529, #1382, #1384, #1419, #1423, #1247, #1193, #1213, #1214, anything HOLD, REJECT or SUPERSEDED-BY, and anything not named.
4. **Shared / Civil / Manager touched: none.** Outside `Modules/Structural*`, the two PRs change only `REGRESSION_LOG.md`. Nothing under `Shared/`, `Installer/`, `CE.Host`, `Modules/Drainage`, `Modules/Manager`, and not `Assets/Config/ce-tool-register.json`. No `PackageContents.xml` and no command register changed.
5. **One thing the brief did not expect: `Modules/Structural/Plugin.cs` changed (+2 lines, from #1547).** `CommandOutcomeLogService.Subscribe()` right after `LoggingService.Initialize()` at start-up, and `CommandOutcomeLogService.Unsubscribe()` at shutdown. No command added or removed. This is the one that listens for each command finishing and writes the outcome line. The Plugin.cs pin guard still passes (it ran inside the net10 and net48 runs). The train against the base: 21 files, +766 -19.
6. **Settings values added: none.** `git diff 2c9a9694..HEAD` over `UserSettings.cs` and every `SettingsService*` file is empty. #1547 reuses Civil's outcome-line switch, ON by default: `CommandOutcomeSetting.Default = true`, key `Options.CommandOutcomeLines` (written as `options.commandOutcomeLines` in Civil's settings file). It adds no Structural Settings row. An unreadable or malformed settings file reads as OFF (an explicit OFF is never defeated); a missing file or missing key reads as ON. #1533 adds no switch or setting.
7. **Conflict: `REGRESSION_LOG.md` at #1533 only,** as expected. Kept every entry, the #1533 entry on top of the #1547 entries, zero markers, a blank line before each heading (checked with grep). Against the base the log is +26 -0 (#1547 +14, #1533 +12). No other file clashed.
8. **Build: 0 errors.** Whole solution Release 0 errors, 927 warnings (the same 927 as S-41). Structural standalone build 0 errors (4 warnings). All three Structural test projects built (net48, net8, net10).
9. **Tests at the final head:**
   1. **Structural net10: 5,704 passed, 0 failed** (15 chunks plus the 7 nested-class tests; the Sbeam evidence class left out). That is the S-41 finalizer's 5,212 plus the new tests (the fix round's own count was "about 5,703"; the chunk filters match by name prefix, so treat the total as about).
   2. **Structural net48: 4,961 passed, 39 failed, 698 not run (5,698).** Same 39 as the S-41 finalizer and the same 698 skipped. The 39 are the AutoCAD-stub / reference-drift reds (the two `ZcOutline_*` names, the `ZcProduction...` / `ProductionSectionMatrix...` family, the brace and move-repair tests, `ManagedPublicApiAndReferences_MatchAcceptedBase`, and so on). None of the 39 names belongs to #1547 or #1533 (searched: no Outcome, XclmTxt or Excel name). All the new #1533 and #1547 tests pass on net48 and net10. See the limit in item 6 of section 3.
   3. **DesignCore: 2,195 per lane (net48, net8, net10), 2,190 passed, 5 failed per lane,** the same five release-settings names as S-41 (`HostedAndStandaloneModernOutputs_AreIsolatedAndCompileOppositeRuntimeContracts`, `LoadOrder_CannotBindStandaloneStructuralToCeShared` x2, `StandaloneReleaseLanes_HaveNoCeSharedDependencyOrPayload`, `StandaloneReleaseLanes_KeepCommandClassesAndSbeam_LeaveCeVersionToManager`). Unchanged from S-41 (2,195).
   4. **CE.CommandTruth.Tests (net10): 22 of 23.** The one red is the standing `Structural_KnownRegistryDriftRemainsPinnedBacklog` ("Expected: 301, But was: 395", then "Expected: 272"), the same drift as S-39 to S-41. No new red.
   5. **Structural.ReleaseTests: 10 of 10 on net48, net8 and net10.**
10. **Re-pins by me: none.** No fingerprint or count was changed by a merged PR (the command-name count did not move: #1547 adds no command), so I made no assembly commit. The branch head is the #1533 merge commit.
11. **Tim's four settings files: unchanged** between my start (09:32) and end (09:51), all four. The Structural `CS_Settings.json` is `2972ce7` / 35,259 bytes, last written 22 Oct 18:54 (AutoCAD wrote it at its own start the evening before); the S-41 reports logged `f682929` / 35,180 bytes at about 13:00 on 22 Oct. So it changed between S-41 and this job, not during it, and not by me.
12. **Do not mark FIXED:** nothing here closes a bug. The XCLMTXT decimals and angle labels (#1533) and the outcome lines (#1547) each need a robot PASS plus a Codex PASS in AutoCAD.
13. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Merge list, in order, with heads

1. **#1547 `61ce20de`** (Structural: log one command outcome line using the Civil setting; base `claude/rel-20261022s2`). Merge `a3b2ff0b`. Clean, no conflict (REGRESSION_LOG.md auto-merged). `git diff --numstat HEAD~1 HEAD` equals the PR's own `gh pr view --json files` list (19 files, same additions and deletions on every line, REGRESSION_LOG.md +14).
2. **#1533 `40c9a977`** (XCLMTXT: preserve supplier decimals and unequal-angle labels). Merge `c490b307`. Conflict in `REGRESSION_LOG.md` only, resolved by keeping both. Numstat equals the PR's file list: `ExcelMTextService.cs` +31 -18, `XclmTxtSteelDesignationTests.cs` +144, `REGRESSION_LOG.md` +12.
3. **Redo-killer scan (standing rule):** nothing in #1547 or #1533 adds `SetCurrentView` or `SetSystemVariable` to a command path. The only start-up addition is the Plugin.cs subscribe line above.

## 2. Settings and scope

1. **`UserSettings.cs`, `SettingsService*.cs`:** no change (empty diff 2c9a9694..HEAD).
2. **The one switch in play:** Civil's `options.commandOutcomeLines`, default ON, read by `CommandOutcomeSetting` (Structural reads the Civil settings file; it does not own a Structural row).
3. **Files outside `Modules/Structural*`:** `REGRESSION_LOG.md` only.
4. **`Plugin.cs`:** changed, +2 lines (section ANSWER FIRST item 5). **`PackageContents.xml`:** unchanged. **Command register / `command-registry.json` / `ce-tool-register.json`:** unchanged.

## 3. Test evidence

1. **Environment:** private worktree `C:\ce-asm\s42` (short path), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers -m:1` on every build; every test command in the foreground, Below Normal, own `TEMP` and `CE_LOG_DIR_OVERRIDE` under `C:\ce-asm`. `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 folder on PATH. Nothing deployed.
2. **Build lock:** at 09:33 `C:\CE_PLAN\desk_jobs\build.lock` was held (a live number, another job). I did not delete it. I polled and it was free at 09:39:37; from then I wrote my own number into it only while a command ran and removed it only if it still held my number. Later runs showed no "lock write failed".
3. **Whole solution method (as S-41):** restore with `EnableUnifiedHostAdapters=true`; separate restore and build of `CE_STRUC_SUITE.csproj` standalone, copy of `bin\Standalone\Release` to `bin\Release`; restore again; the solution with `EnableUnifiedHostAdapters=true`. 0 errors, 927 warnings. Installer.Tests compiled in the solution build, not run.
4. **Structural.Tests chunks:** 425 class names read from source, `SbeamEditAutoCadEvidenceReaderTests` removed (hangs), 15 chunks of 30 plus the nested filter. Net10 chunk passes: 366, 336, 216, 284, 358, 275, 387, 374, 321, 724, 427, 305, 320, 504, 500, 7 = 5,704, 0 failed. The first three equal S-41's finalizer chunks exactly (366, 336, 216). Net48 chunk failures: 3, 10, 3, 0, 2, 6, 0, 1, 0, 0, 12, 0, 2, 0, 0, 0 = 39; skipped 698.
5. **Totals are in the thousands** for both Structural runs and DesignCore (2,195), so the `_AcadRefNet8` name was right (no zero-test run).
6. **What I did NOT do:** I did not build and run the S-41 base `2c9a9694` for a name-by-name comparison of the net48 reds (the S-41 name lists were not kept and the worktrees were removed). Instead: the count (39), the skipped count (698) and the DesignCore and CommandTruth reds equal the S-41 finalizer's figures exactly, and the total grew by 490, all passing, which is the new #1533 and #1547 tests. If the finalizer wants the by-name proof, a base build is needed. Also not run: Structural net8 tests (built only, as S-39 to S-41), the Sbeam evidence class, DesignCore with release settings set, Drainage, Manager, Installer.Tests, anything in AutoCAD.
7. **Pictures:** test runs rewrote files under `docs/image/V3_WINDOWS` in my worktree (76 changed files); none committed, the branch holds merge commits only.

## 4. Hygiene

1. **Tim's settings files, first 7 hex of SHA-256 (my hash script prints seven), before (09:32) and after (09:51), all unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 bytes `acd64e7`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes `622a246`; `CE_CVL_SUITE\settings.json` 672 bytes `efe307c`; `CE_STRUC_SUITE\CS_Settings.json` 35,259 bytes `2972ce7`.
2. **Leak scan:** clean on the push, no `--no-verify`. No PR closed, no branch deleted, no version edited, DESK_LOG.md untouched, no bare python.
3. **Cleanup:** worktree `C:\ce-asm\s42`, the temp folders `s42tmp` `s42celog`, my runner scripts (`s42*.sh`) and logs and the `refs/tmp/pr*` helper refs removed after this report was written (the logs I quote are summarised here).

## 5. For the finalizer

1. **Judge the two merges together.** #1547 puts a listener on every compiled Structural command (395 names) from `Plugin.cs` start-up: check that a command that throws still logs one line and that the listener is removed at shutdown. #1533 changes how `ExcelMTextService` formats steel designations (`250UB25.7` keeps its decimal, angles keep EA/UA).
2. **Values and switches without a Settings page row:** the outcome-line switch (Civil's, shared). Codex window lane.
3. **Carryover:** version field is still 1.0.121 (payload builder bumps to 1.0.122); the CommandTruth drift (301 expected, 395 found) and the net48 stub reds are standing.
4. **What Codex should look at in AutoCAD (copies only), after install:** with the switch ON, run a few Structural commands (CEMEMBER, SBEAM, a hatch command, CSREOBAR) and check one outcome line appears per command in the Command log; cancel one and check it reads as cancelled. XCLMTXT on a schedule with `250UB25.7 BEAM`, `410UB59.7` and an unequal angle: the decimals and the angle labels print as supplied.
