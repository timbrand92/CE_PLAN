# Train C-46 assembly report (Civil + Manager), Mon 19 Oct 2026 night (21:30 to 22:25, Melbourne time)

**ANSWER FIRST**

1. **Branch:** `claude/rel-20261019b`, pushed with a normal push. Head `9638622b84b6327bf51593c35c614a010a07b90d` (local equals origin). Base `origin/claude/rel-20261019a` @ `21462f9c` (the installed Civil 3.0.56 / Manager 1.1.56 line).
2. **Merged: 25 PRs** (25 first-parent merge commits, no squash, no rebase): #1439, #1440, #1441, #1442, #1443, #1444, #1446, #1447, #1448, #1449, #1450, #1452, #1453, #1454, #1455, #1456, #1458, #1459, #1461, #1462, #1463, #1469, #1470, #1473, #1476. Every merged head equals the live PR head (re-checked with gh immediately before each merge).
3. **Left out, with reasons:**
   1. **Superseded (Opus entries 1314 to 1321, 1334):** #1445 (by #1470), #1451 (by #1474), #1465 (by #1450), #1467 (by #1452), #1468 (by #1455), #1471 (by #1454), #1472 (by #1462).
   2. **MERGE-WITH-FIXES, but no fix round has been pushed yet** (live head is still the reviewed head, so the rule "newer head from the lanes" is not met): **#1474** (head `5bdd424b`, needs its CePiiHash half dropped), **#1475** (`db257bb6`, needs its Manager half dropped), **#1477** (`ccf5d1de`, needs the early-exit log lines). Same wording as the reviews: nothing was changed by me. **Consequence:** BUG-847 (support-zip scrub) has no PR in this train (its first PR #1451 is superseded by #1474), the installer half of BUG-838 is not in, and the BUG-430 diagnostic is not in. They go in C-47 once their fix rounds land.
   3. **Not in this train by Tim's list:** #1419 and #1423 (no newer review says MERGE), #1382, #1384, and every Structural PR (#1457, #1460, #1464, #1466). Checked by ancestry: none of the 18 numbers above is in the branch.
4. **Which PRs touch Shared/:** #1449 (`CE_SHARED/Services/CePiiHash.cs`), #1458 (`CE_SHARED/Services/RibbonBuilder.cs`), #1462 (`CE_SHARED/Services/RibbonBuilder.cs` and the new `CeRibbonClickLog.cs`). **#1442 also touches `Shared/CE.Release/OfficialReleaseGate.cs`** (the installer's release gate, not CE_SHARED). Civil and Manager are built from this one commit, so CE_SHARED is identical for both. Ship Civil and Manager (and the Installer, for #1442 to #1444) together.
5. **Build:** whole solution Release, **0 errors**, 889 warnings (C-45 finalizer: 885). 16 min 22 s.
6. **Tests:**
   1. **Civil net10 full suite:** 18,830 run, 18,810 pass, 19 skipped, **1 failed**: the known Glen Eira back-test. (A second full run, made by accident, had one extra red: a blank-PDF render test; see section 4.3. It passes alone, 15 of 15.)
   2. **Manager net10:** 815 of 815.
   3. **Civil net48 focused** (the 12 changed test classes plus RedoSafe and DoubleClick, CERef 24.3.0): 256 of 256, 0 failed.
7. **For the finalizer:**
   1. **Three merged heads are NEWER than the head the Opus MERGE verdict names** (each is a one-commit fix round that descends from the reviewed head): #1441 `95054f66` (reviewed `ab133f78`), #1453 `f8ba8b90` (reviewed `7e60a2b7`), #1470 `f0f770c5` (reviewed `49c930c6`). Read these three diffs.
   2. **Four MERGE-WITH-FIXES PRs merged on their pushed fix round, to be re-reviewed:** #1439 `eb8a23e3`, #1456 `a690f36d`, #1458 `a6707cef`, #1469 `905e2dd0`.
   3. **Three hand merges** (sections 2 and 3): #1444 (installer test file), #1454 (`CeAdminPolicyService.cs`), #1462 (`RibbonBuilder.cs`). Read the merged files.
   4. **Merged PRs with no Opus review at all: none.** Every one of the 25 has an entry in the review log (1279 to 1334).
   5. Nothing was installed, deployed, version-bumped or opened in AutoCAD: **built and unit-tested only.** Installer.Tests were compiled, never run (rule).
8. **Your settings files:** unchanged (size and checksum read before and after, section 5).

---

## 1. Rule checks

1. **Verdicts read (entries 1279 to 1334, newest wins):** #1445 and #1451 were changed to SUPERSEDED by entries 1318 and 1321; #1465, #1467, #1468, #1469 (BUG-842 half), #1471, #1472, #1474 (BUG-846 half), #1475 (Manager half) are superseded halves or whole PRs. No HOLD or REJECT exists in the set.
2. **Live bases checked:** every open PR with base `claude/rel-20261019a` was listed (#1439 to #1477 minus #1457, #1460, #1464, #1466, which are Structural on another base).
3. **Fix-round check:** for #1439, #1441, #1453, #1456, #1458, #1469, #1470 the live head is a descendant of the reviewed head (`git merge-base --is-ancestor`), and the diff stats were read.
4. **Merge method:** `git merge --no-ff` one merge commit per PR, ancestry checked before each. After each merge `git diff --numstat HEAD~1 HEAD` was compared with `gh pr view N --json files`: **identical for all 25** (the three hand merges and the REGRESSION_LOG additions included).

## 2. Merges, in order (second parent = PR head used, merge commit)

1. #1443 `fdd724fc` (merge `8e76ffe6`), clean
2. #1442 `9db7cdf7` (`4d1f0fa5`), REGRESSION_LOG only
3. #1444 `5881da68` (`9964b584`), **hand merge** of `Installer.Tests/SafeBundleInstallerTests.cs`: #1444's tests, plus #1443's `Install_WithSignedCommandlessNativeDbx_AllowsOwnershipProof` (its `AddNativeComponent(bool includeCommand, string fileName = ...)` change merged by itself). No interleaved blocks.
4. #1470 `f0f770c5` (`0f15b4ea`) (replaces #1445)
5. #1446 `19aba075` (`71e511c1`)
6. #1461 `d79f8f10` (`ad5352cf`)
7. #1473 `09cbed4a` (`d285e4b8`)
8. #1450 `7309b265` (`075de137`)
9. #1454 `742f36cb` (`64300e5a`), **hand merge** in `CeAdminPolicyService.cs`: #1450's `ReadUsersWhateverTheKeyIsCalled` and #1454's `IsOnlineOnly` with the three-argument `TryLoadDocument`, both kept.
10. #1456 `a690f36d` (`319e38f4`) (its fix round compiles in this order)
11. #1452 `e7b2dc74` (`567807b5`)
12. #1455 `affdf4dc` (`6e614045`)
13. #1459 `5d0cfe9a` (`f15815c0`)
14. #1469 `905e2dd0` (`9d451388`) (BUG-848 half only, as fixed; no conflict with #1459)
15. #1449 `9c9aefda` (`648295b5`) CE_SHARED
16. #1458 `a6707cef` (`08f6e07b`) CE_SHARED
17. #1462 `513059cf` (`89b1a736`) CE_SHARED, **hand merge** in `RibbonBuilder.cs`: #1458's `BuildSendString` line, then #1462's `ClickLog(cmd + ": sent"); // BUG-853 ...`
18. #1447 `10f90719` (`0eff6c13`)
19. #1453 `f8ba8b90` (`6e9df968`)
20. #1448 `d65d3f37` (`aeea66a3`)
21. #1463 `705c261b` (`e6aa7512`) (after #1461 and #1448, as entry 1313 asks)
22. #1439 `eb8a23e3` (`3b4148c5`), clean
23. #1440 `283e013f` (`fadbd6e1`)
24. #1441 `95054f66` (`ec6494dc`)
25. #1476 `0e13f2b2` (`9638622b`)

## 3. Conflicts and how they were met

1. **REGRESSION_LOG.md** conflicted on 24 of 25 merges (every PR adds at the top). Resolved each time by keeping the base and inserting that PR's own added block at the same place, so **every entry is kept** and the newest merge sits on top. (My first attempt used a union merge, which glued two entries together; I discarded that merge and redid it.)
2. **One slip, fixed before the push:** on #1462 my re-run of the log step wrote an empty log into the merge commit. I rebuilt that file from the first parent and the PR, amended the local merge commit (never pushed), and re-checked: the numstat matches the PR's file list.
3. The three hand merges are listed in section 2 (items 3, 9, 17). No other conflict.

## 4. Build and test evidence

1. **Build:** `dotnet build C:\ce-asm\c46\CE_ACAD_PLUGIN.slnx -c Release -p:SkipDevBundle=true -nr:false --disable-build-servers -m:1`, Below Normal, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `GitExecutable` set to the Git cmd path (the C-45 trap), net10 off AutoCAD 2027. **0 errors, 889 warnings, 16 min 22 s.** The build lock folder was taken only while each command ran and is released.
2. **Civil net10 (Release, `--no-build`, AutoCAD 2027 on PATH, 0-byte placeholder for the transform file):**
   1. Run 1: **18,830 total, 18,810 pass, 19 skipped, 1 failed** (`BackTest_GlenEira24115_Computed_WithinTolerance`, 34.6 % against 30 %, the known red). Total is in the thousands, so the `_AcadRefNet8` trap is not in play. C-45 finalizer had 18,800 run: the extra 30 are this train's new tests.
   2. Run 2 (made by accident when my framework switch was not applied; see item 4): 18,830 total, 18,809 pass, 19 skipped, **2 failed**: Glen Eira, and `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` ("PDF renderer produced only blank page(s)", took 15 s). **Run alone on net10: 15 of 15 pass.** It is a machine-load or rendering flake in a PDF test this train does not touch (no PR here changes the markup loader); it did not fail in run 1. I did not run it on the base.
3. **Manager net10:** 815 of 815 (C-45: 757; the extra are #1442 to #1476's new classes). **Trap met:** the Manager hygiene tests require the log override folder to sit inside the real Temp folder, written with the long profile name; my first two runs used a folder elsewhere and then the short 8.3 name and failed 8 and then 5 of them (environment, not code). The third run, with the long Temp path, is the one reported.
4. **Civil net48 focused:** `-f net48`, filter = Bug357PitMoveLockedPipeTests, Bug825StartingValuesOnceTests, Bug827Bug831SettingsFileSafetyTests, Bug828RibbonCancelFirstTests, Bug830Bug839CivilSettingsPageTests, Bug853RibbonClickLogTests, CeCivilSettingsBridgeTests, CeCvlRibbonContributorTests, CivilSpineProjectorTests, RecoverInvertsTextCheckTests, RulebookPipeMarkWordsTests, SpineHoldPointTests, RedoSafe, DoubleClick: **256 run, 256 pass, 0 failed.** (The two accidental runs in item 2 used no filter and ran the whole net48 lane as well: 18,681 run, 370 failed, 333 of them `InvalidProgramException` from the reference stubs and the rest stub-driven assertion failures. That is the known net48 stub lane trap on the full lane, which is not a gate; the gate is the focused run above. I did not compare the full net48 lane with the base.)
5. **Not run:** Installer.Tests (compile only, rule), CommandTruth, TestHarness, Spine, Diagnostics, AI.Core, ReleaseTests, Structural, Manager on net48, each PR alone, anything in AutoCAD or accoreconsole, the base on net48.

## 5. Hygiene

1. **Tim's settings files, size and first 8 characters of the checksum, read at 21:38 and 22:19, unchanged:** `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 bytes `acd64e79`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 `622a246f`; `CE_STRUC_SUITE\CS_Settings.json` 34,858 `24d8e5f7`; `CE_CVL_SUITE\settings.json` 672 `efe307c4`.
2. AutoCAD and accoreconsole were not running at any point (checked with tasklist at the end); nothing was deployed, nothing written to the application plugins folder, no version edited. CE logs were redirected to scratch folders under Temp and `C:\ce-asm\logs`.
3. No PR was closed, no branch deleted. Nothing in `DESK_LOG.md` was edited.

## 6. For the finalizer

1. Read the three LOW fix rounds on MERGE verdicts (#1441, #1453, #1470) and re-review the four MERGE-WITH-FIXES rounds (#1439, #1456, #1458, #1469).
2. Read the three hand merges (section 2 items 3, 9, 17).
3. Decide whether C-46 waits for #1474, #1475 and #1477 fix rounds or ships without them (BUG-847, installer half of BUG-838, BUG-430 diagnostic stay open).
4. The C-46 merge entry in `REGRESSION_LOG.md` and the version commit are not added by the assembler.
5. **Do not mark FIXED** anything in this train without a real AutoCAD pass; entries 1308 and 1333 of the review log list the bugs that stay OPEN even after merge.
