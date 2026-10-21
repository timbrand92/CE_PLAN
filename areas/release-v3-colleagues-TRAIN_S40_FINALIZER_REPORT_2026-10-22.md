# S-40 Opus finalizer: Structural train claude/rel-20261022s

Independent check of what S-40 adds on top of S-39 (`claude/rel-20261020s` = `063a6351`, Structural 1.0.119, the installed Structural line). Thu 22 Oct 2026, about 07:15 to 07:55 Melbourne time (PC clock). Opus 5.5, Team, headless, desk plan/03. Private worktrees `C:\ce-fin\s40` (train) and `C:\ce-fin\s40b` (base, for comparing net48 reds), both removed at the end. I did not start AutoCAD or accoreconsole, deployed nothing, changed no version field, closed no PR, deleted no branch, merged no Civil or Manager PR, marked no bug FIXED, did not edit DESK_LOG.md.

## ANSWER FIRST

1. **GO at `d051a2a9be06a2475459d020aa5a422b4b94ffce`.** Nothing HIGH or MEDIUM left open in the train. Five LOWs listed below, none blocking.
2. **Start head checked:** `git ls-remote` gave `1fd5b535...` at the start, equal to the assembly report. My push was a plain fast-forward `1fd5b535..d051a2a9`; leak scan clean (36 terms).
3. **Said loudly: only 6 of the 9 PRs in the brief are in this train.** #1510 (BUG-858 SBEAM Z purlin), #1498 (BUG-748 hatch density) and #1496 (BUG-531 tag height) are NOT merged: their heads moved after the Opus review (each to a small follow-up for an Opus LOW), and the assembler correctly stopped. So the three LOW fixes the brief asked me to settle (the TagHeightUnits duplicate, the "the waffle" comment, and the #1510 preview follow-up) are not in this train and there was nothing of theirs to fix here. They need a quick Opus look at the new heads (`1ea2517d`, `80f28581`, `48e4724b`) and then a train (S-41, or a fresh S-40 assembly).
4. **One commit of mine, `d051a2a9`, a real fix (small, said loudly):**
   1. **The problem:** the first CEMEMBER question read `View [Side/Top/Section/Reset]`. Side and Section both answer to S, so typing S did not say which view you meant. The keyword guard went red on the train for exactly this (the one new red the assembler left for me).
   2. **The fix:** the question now reads `View [SIde/Top/SEction/Reset]`: SI for side elevation, SE for a section. Same AutoCAD capital-letter style as CEHATCHAUDIT's `rEpair`. Nothing else in CEMEMBER moves.
   3. **The guard had a blind spot, now closed:** it did not treat a question wrapped in `CeQuestion.OwnList(...)` as a separate question, so it lumped CEMEMBER's questions together and reported false clashes (Top / Top and so on). It now sees those questions (33 other wrapped Structural questions also come under it: none clashes) and checks CEMEMBER's base-point and "how it sits" choice lists directly (all distinct).
   4. **Red first:** with the train's old question the guard is red with exactly one clash, Side / Section. With the fix it is green on net10 and net48.
5. **Tests at my head (Release, all `-p:SkipDevBundle=true -nr:false --disable-build-servers`):**
   1. **Whole solution:** 0 errors (serial build, `EnableUnifiedHostAdapters=true`).
   2. **Structural net10:** 5191 of 5191 passed (14 chunks plus 7 nested). One chunk first showed a "built lane older than source" red caused by my own red-first file swap; after rebuilding it passed.
   3. **Structural net48:** 4453 passed, 37 failed, 698 not run (5188). I built the S-39 base myself and ran the same chunks: 36 failed there, **identical names**. The one extra is the new CEMEMBER writer test `TheMoveAutoCADApplies_LandsEveryPointWhereTheEngineSays`, which cannot run on the net48 stub (it passes on net10); it does not exist on the base.
   4. **DesignCore:** 2173 per lane on net48, net8 and net10; 2168 passed and 5 failed per lane, the same five release-settings names as S-39. **With the release settings set** to my own x64 builds (all four DLLs read `1.0.119+d051a2a9...`): **7 of 7**, including the check that the command classes are all in the built DLLs.
   5. **CE.CommandTruth.Tests:** 22 of 23. The one red is the standing `Structural_KnownRegistryDriftRemainsPinnedBacklog` (expects 301, finds 395; red on S-39 too at 394).
   6. **Structural.ReleaseTests:** 10 of 10 on net48, net8 and net10.
6. **What Tim will see in AutoCAD after this train is installed (plain words):**
   1. **CEMEMBER is a new typed command** (not on the ribbon). It asks: View (SI side / T top / SE section / R reset), a section name such as 310UB32 or 380PFC, how an odd shape sits (channel, angle, Z purlin), then for an elevation where the two points sit (centreline, top, bottom) and which ends get a break line, then two picks per member. It draws the member between the two points with 25CONT edges, 18CONT for lines you can see, 18HIDDEN for lines behind, and break lines on 18CONT sized 1.5 mm and 2 mm on paper times DIMSCALE. For SE it draws the cross-section at one picked base point: in front = outline plus hatch on HATCH 10, beyond = 9HIDDEN2 outline only. Pick again for more; Esc finishes; one U removes the whole run. In a rotated UCS the member lands between the picked points.
   2. **SBEAM Z purlin shape: no change.** #1510 is not in this train, so SBEAM still draws the old crossed Z.
   3. **AD, LD, Q (and QD) at 1:50:** they now work at any DIMSCALE above zero instead of saying "Only DIMSCALE 20 or 100 is supported". 1:20 and 1:100 behave exactly as before.
   4. **LBUH dots: no change.** #1498 is not in this train.
   5. **EBT tag height at other scales: no change.** #1496 is not in this train (still 250).
7. **Do not mark FIXED:** BUG-858 and its SBEAM-window preview follow-up; BUG-748; BUG-531 (none of their fixes is in this train); CEMEMBER (b) to (h), including the new SI / SE shortcuts (each needs a robot PASS plus a Codex PASS in AutoCAD); the AD / LD / Q any-scale change (needs a Codex look at 1:50: dimension text and arrows the right size).
8. **Values and switches without a Settings page row (I built none):**
   1. **The CeMember group, 9 values:** break overshoot 1.5 mm on paper, kink 2 mm on paper, fallback scale 100, and six layer names (25CONT, 18CONT, 18HIDDEN, 9HIDDEN2, HATCH 10, 18CONT for break lines). Defaults are today's numbers and names, so nothing changes for Tim; they can only be changed in the settings file until the Codex window lane adds rows (R-00).
   2. **`Layouts.FollowAnyDrawingScale`:** not new, but it now also covers AD, LD and Q. It has a recovery label but no Settings page row.
9. **Risks:**
   1. **The three held PRs:** the brief and the desk expected nine PRs; Tim's three bug fixes in them (Z purlin, LBUH dots, tag height) will not arrive with this install.
   2. **The CEMEMBER help text is stale:** its row in the command list still says "The section view and the window are not built yet, so use SBEAM for sections" and "Elevations only", but #1505 built the section view. Wording only; changing it moves two register fingerprints, so I left it (LOW).
   3. **Nobody has seen CEMEMBER draw.** Everything above is unit tests and code reading.
10. **Tim's four settings files:** unchanged before (07:18) and after (07:45) my run.
11. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Review of the merged PRs

1. **Merge integrity:** the six merges plus the two assembly commits change 32 files, all under `Modules/Structural*` except `REGRESSION_LOG.md` and `Assets/Config/ce-tool-register.json`. `REGRESSION_LOG.md` against the base: 0 lines removed, no conflict markers, so every keep-both resolution kept both sides. `UserSettings.cs` only gains the CeMember group (+28, nothing removed); `SettingsService.LoadRecovery.cs` changes one line, the FollowAnyDrawingScale label (now names AD, LD and Q); no recovery line was lost. The expected #1496 / #1498 clash in those two files did not arise (both held).
2. **#1500, #1501 (CEMEMBER placement and section-name prompts):** engine files in DesignCore only; Opus MERGE at the same heads (entries 1523, 1553 batch); nothing new from the merge.
3. **#1504 (CEMEMBER registered):**
   1. **Registration:** one added line in `Plugin.cs`, `[assembly: CommandClass(typeof(CE_STRUC_SUITE.Commands.CeMemberCommands))]`, and one row in Structural `command-registry.json` (+25 lines, one object: CEMEMBER, hidden, expert, not on the ribbon). No other row changed. `ce_toolbar_layout.json`, ribbon files and both `PackageContents.xml` files are untouched.
   2. **The assembler's two re-pins are right and kept:** the Plugin.cs fingerprint (the only Plugin.cs change is that one line) and the central register row (`rowCount` 374 to 375 plus its fingerprint), which is the one CEMEMBER row.
   3. **Nothing on load:** registering a command class only tells AutoCAD the command exists. `CeMemberCommands` has no start-up hook; its one static field (the remembered answers) is created on first use.
   4. **Layers are Settings values** with today's names as defaults; a blank name falls back to today's.
   5. **Picks converted from the UCS:** both elevation picks (`CeMemberCommands.cs` lines 124 to 126) and the section base point (line 190) go through `TransformBy(editor.CurrentUserCoordinateSystem)`.
   6. **Esc and Undo:** each member is its own short drawing change inside the one command, so one U removes the whole run; Esc at any question prints "Nothing changed".
4. **#1505, #1506 (section placement, remembered choices):** right. Choices are remembered only after the first member or section is actually drawn; Enter on an empty first name asks again.
5. **#1497 (FollowAnyDrawingScale reaches AD, LD, Q):** AD, LD, Q and QD all pass through the one check `ValidateDimScale`, which now asks `DrawingScaleRule.IsAcceptedDimensionScale` (any finite DIMSCALE above zero when the switch is on; only 20 and 100 when off).
6. **Open LOWs from entries 1550 to 1557:**
   1. **TagHeightUnits duplicate (`CeTextService.cs`) and the "the waffle" comment (`UserSettings.cs`):** not in this train (#1496, #1498 held); already fixed at their moved heads.
   2. **`CeMemberLineWriter.cs` line 92:** an office-renamed hidden or section-beyond layer that does not exist yet is created Continuous 0.18, so hidden lines would draw solid on it. Defaults are unaffected. Not a wording fix: listed, carpark.
   3. **No Settings rows for the CeMember group:** listed (ANSWER FIRST item 8).

## 2. New defaults judged

1. **`Layouts.FollowAnyDrawingScale` (existing switch, default ON, now also AD, LD, Q):** changes what Tim sees by default (AD at 1:50 works instead of refusing). Kept ON: the old refusal is the bug. Tim, 20 Oct item 12 (`decisions/2026-10-20_TIM_ANSWERS.md`): "all scales should be managed with all scales based off drawing scale controlled by ltscale and dimscale"; the desk reading names "AD accepts every DIMSCALE (1:50 included, no 'only 20 or 100' refusal)". OFF gives back the 20 / 100 only rule with a line naming the switch.
2. **The CeMember group (9 values, no switch):** a brand-new typed command; defaults are today's card numbers and layer names; changes nothing Tim already uses. No switch needed.
3. **`Layouts.TagTextFollowsLabelHeight` and `Layouts.HatchDensityFollowsPaper`:** not in this train (their PRs are held), so not judged here. For the train that takes them: Tim's 20 Oct answers item 9 (BUG-531, "yes") and item 12 support ON for both, as the Opus entries say.
4. **Nothing turned OFF by me; no default changed by me.**

## 3. Installer and update safety

1. **Signed-update gate (`OfficialReleaseGate`, `Shared/CE.Release`):** the train touches nothing under `Shared`, `Installer`, `CE.Host`, `Modules/Manager` or `Modules/Drainage`. It cannot change the gate. The gate checks the signed package, not the commands inside it.
2. **Installer command-ownership check (`SafeBundleInstaller.VerifyCommandOwnership`):** it reads only the `<Command>` entries of each bundle's `PackageContents.xml` and refuses when another enabled CE bundle claims the same command. #1504 adds CEMEMBER to neither `Modules/Structural/Installer/PackageContents.xml` nor `CE.Host/Installer/PackageContents.xml`, and no other bundle lists CEMEMBER, so the check sees no change and there is nothing to overlap.
3. **Does CEMEMBER still load without a PackageContents entry?** Yes: the Structural bundle loads at AutoCAD start (`LoadOnAutoCADStartup="True"`, `LoadOnCommandInvocation="False"`), so the CommandClass registration makes CEMEMBER available. Other hidden commands (SBEAM, for example) are also not listed. This is not the S-39 CE_VERSION kind of finding: no release check demands a CEMEMBER manifest entry, and the release-lane gate passes 7 of 7 with CEMEMBER in the built DLLs.
4. **Version:** all four built DLLs read 1.0.119 (no bump by me; the payload job bumps).

## 4. Test evidence

1. **Environment:** worktree `C:\ce-fin\s40`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 first on a short PATH, scratch `CE_LOG_DIR_OVERRIDE`, NUnit workers 1, Below Normal, every command in the foreground. Build lock folder `C:\CE_PLAN\desk_jobs\build.lock` taken only while a command ran; never left behind.
2. **Build method:** restore with `EnableUnifiedHostAdapters=true`; Structural standalone build copied to `bin\Release`; whole solution with `EnableUnifiedHostAdapters=true`. A first parallel solution build hit a file-in-use race between two projects writing the same Structural DLL (my own build only); the serial (`-m:1`) build gave 0 errors.
3. **Structural net10 chunks:** 366, 336, 216, 284, 356, 281, 362, 350, 375, 713, 384, 314, 334, 513 plus 7 nested = 5191, all passed (419 class names from source, the hanging Sbeam evidence class left out as in S-38 and S-39). 5191 equals the assembler's 5190 + 1 (the keyword guard, now green).
4. **Structural net48:** 37 failed: the 36 base names (compared one by one with my own base run of `063a6351`, 36 failed, `diff` shows only the new writer test) plus `TheMoveAutoCADApplies_LandsEveryPointWhereTheEngineSays`.
5. **Release-lane gate with release settings:** `StandaloneRuntimeCompatibilityTests` 7 of 7 (net10), with `CE_STRUCTURAL_EXPECTED_SOURCE_HEAD` = my head and the four x64 lane DLLs.
6. **Not run:** Structural net8 tests (built only, as S-39), the Sbeam evidence class (hangs), Drainage, Manager, Installer.Tests, anything in AutoCAD or accoreconsole. #1510, #1498 and #1496 were not built or tested (not in the train).
7. **Pictures:** test runs rewrote about 70 files under `docs/image/V3_WINDOWS`; restored before the commit. The commit holds three files only.

## 5. For the desk

1. **The three held PRs:** Opus look at the moved heads (#1510 `1ea2517d`: the SBEAM window picture now uses the shared Z outline, which would also close the BUG-858 preview follow-up; #1498 `80f28581`: comment only; #1496 `48e4724b`: deletes the unused helper), then merge in the order #1510, #1498, #1496 (keep both in `UserSettings.cs` and `SettingsService.LoadRecovery.cs`).
2. **Codex in AutoCAD (copies only), after install:** CEMEMBER at View: SE goes to the section questions, SI to side elevation, S alone is not accepted; a 310UB32 side elevation between two picks at 1:100; a section in front and beyond; a rotated UCS; Esc at each question; one U after three members. AD, LD and Q at DIMSCALE 50: dimension text and arrows look right on paper.
3. **Carpark candidates (LOW):** CeMemberLineWriter renamed-layer linetype; the stale CEMEMBER help text; Settings rows for the CeMember group and FollowAnyDrawingScale.
