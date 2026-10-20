# S-39 Opus finalizer: Structural train claude/rel-20261020s

Independent check of what S-39 adds on top of S-38 (`claude/rel-20261017s` = `9a8e5d4e`, Structural 1.0.118, the installed Structural line). Tue 20 Oct 2026, about 22:47 to 23:20 Melbourne time (PC clock). Opus 5.5, Team, headless, desk plan/03. Private worktree `C:\ce-fin\s39`, removed at the end. I did not start AutoCAD or accoreconsole, deployed nothing, changed no version field, closed no PR, deleted no branch, marked no bug FIXED, did not edit DESK_LOG.md.

## ANSWER FIRST

1. **GO at `e3f581d2f4b358924657093cfe907f78720285cb`.** Nothing HIGH or MEDIUM left. Four LOWs, none blocking.
2. **Start head checked:** `git ls-remote` gave `3de4e748...` at the start, equal to the assembly report.
3. **One commit of mine, `e3f581d2` (test and log entry only, no production code):**
   1. **The problem:** a Structural release check still demanded that Structural registers CE_VERSION. It would have gone red the moment the release check ran with its settings, after #1503 rightly removed the command.
   2. **The fix:** it now demands the opposite. No Structural command registers CE_VERSION.
   3. **Red first, then green:** with the three real built DLLs it failed first ("Expected: True, But was: False"). At my head all 7 of 7 release-lane checks pass, including the hosted one.
4. **The assembler's commit `3de4e748` is right and kept.** The only change to Structural's start-up file in the whole train is the one deleted CE_VERSION help line, so re-pinning its fingerprint is correct.
5. **Tests at my head (Release):**
   1. **Whole solution:** 0 errors.
   2. **Structural net10:** 5164 of 5164 passed (5157 in 14 chunks, plus 7 nested).
   3. **Structural net48:** 4427 passed, 36 failed, 698 not run. These match the assembler and S-38 exactly. The 36 are the same nine old classes, and none comes from this train.
   4. **DesignCore:** 2121 per lane on net48, net8 and net10. 2116 passed and 5 failed per lane, all five only because the release settings were not set. With them set: 7 of 7.
   5. **CE.CommandTruth.Tests:** 22 of 23. The one red is also red on the base.
   6. **Structural.ReleaseTests:** 10 of 10 on all three targets.
6. **What Tim will see in AutoCAD:**
   1. **CEMEMBER:** nothing. It is not a command yet, only the drawing rules behind it.
   2. **CE_VERSION:** "Unknown command" (and the CE Tools > Version button does the same) until the Manager half (#1493) is installed AFTER this train. Then it opens the version window again.
   3. **The About window:** still opens from the About button in the Structural settings window.
   4. **CXREF:** if a copy fails for a program reason, the line says "an unexpected problem" instead of raw program text. File problems (locked or denied) still name the cause.
   5. **Footing widths:** the start-up or recovery line names them in plain words, for example "Strip footing width offered when the width is unknown (mm)".
7. **Do not mark FIXED:**
   1. **BUG-852:** needs this train AND the Manager half installed, then a robot PASS and a Codex PASS in AutoCAD.
   2. **BUG-520 part c.**
   3. **The CXREF raw-text LOW** (S-38 finalizer LOW 1).
   4. **CEMEMBER:** not a command, nothing to accept.
8. **Values without a Settings page row:**
   1. **CEMEMBER break overshoot, 1.5 mm on paper.**
   2. **CEMEMBER kink, 2 mm on paper.**
   3. **CEMEMBER fallback scale, 1:100** (used when DIMSCALE is not set).
   4. **The three FootingWidth values** (strip 300, beam 300, screw pile 150). These are older; #1312 only names them.
   5. **The standing S-38 switches** (LOW 3 there).
   6. **Why none of this blocks:** CEMEMBER has no command yet, so these values reach nobody. They need rows when the command is wired (R-00).
9. **Risks:**
   1. **Install order:** S-39 first, Manager half second. The other way round, the installer refuses the Manager on every PC with Structural.
   2. **The gap between the two installs:** CE_VERSION is an unknown command.
   3. **Two lines still tell the drafter to "Type CE_VERSION":** the first-run line in Plugin.cs and one VersionInfoService line. They are right again once the Manager half is in (LOW).
10. **Tim's four settings files:** unchanged before (22:47) and after (23:14) my run.
11. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Review of the merged PRs

1. **#1487, #1488, #1489, #1490 (CEMEMBER engine, Opus MERGE at the same heads, entries 1504 to 1507): still right after the merge.**
   1. **What the merges changed:** only their own 6 files under `Modules/Structural.DesignCore/SteelSections` and the DesignCore tests, plus REGRESSION_LOG lines. No JSON file changed, so the section list stays out of `section-catalogue.json`.
   2. **No command:** no `CommandMethod`, no start-up hook and no file read anywhere in the new code. Nothing outside DesignCore refers to it. `CeMemberCatalogue` in the Structural models is an older, unrelated class.
   3. **Nothing runs on load.**
   4. **Line rules match** `decisions\2026-10-18_CEMEMBER_DESIGN.md` and `2026-10-19_CEMEMBER_ANSWERS.md`:
      1. **Layers:** 25cont, 18cont, 18hidden, and break lines on 18CONT.
      2. **Break line:** 1.5 mm overshoot and 2 mm kink on paper, times the scale. That is 150/200 at 1:100.
      3. **Scale:** read from DIMSCALE, 100 when unset.
      4. **LTSCALE not 10 x DIMSCALE:** warns and carries on (Tim 19 Oct: "yes as per recommeneded").
   5. **Settings values:** the break sizes sit in `CeMemberSettings` (a plain class, not in the settings file) and are ready for a row.
   6. **Earlier LOWs stand:** BL has its own copy of the shape; 18CONT vs 18cont spelling; C purlin flanges-up lip question for Tim; vertical member tie-break.
2. **#1503 @ 05dd3a88 (BUG-852 Structural half): MERGE, right, 1 LOW (plus the latent red I fixed).**
   1. **What is removed:** CE_VERSION goes from `AdminCommands.cs`, `command-registry.json` (375 to 374 rows), `ce_toolbar_layout.json`, all three load lists of `Modules/Structural/Installer/PackageContents.xml`, all three lists of `CE.Host/Installer/PackageContents.xml`, the start-up help line, the ribbon-routing test file and the release/lane tests (37 to 36 commands).
   2. **Central register:** `Assets/Config/ce-tool-register.json` Structural row now reads 374 rows with the new fingerprint, and the central-register test passes.
   3. **No leftover owner:** a search of the whole tree finds no other place that registers CE_VERSION in Structural.
   4. **The Structural installer will no longer list CE_VERSION, so the Manager can own it.**
   5. **Tim's PC today:** the installed Structural bundle is the only bundle there listing CE_VERSION (3 lists). Civil, Manager, CE.AutoCADLink and CE.Transform.Trial list none.
   6. **The latent red:** `StandaloneRuntimeCompatibilityTests` still demanded CE_VERSION. Fixed by my commit.
   7. **LOW:** `Plugin.cs:246` (first-run line) and `VersionInfoService.cs:339` still say "Type CE_VERSION". This is wrong only between the two installs.
3. **#1312 @ d4c9ef30 (S-38 LOWs wording): MERGE, right.**
   1. **CXREF:** only IO and access-denied errors pass their own sentence to the command line. Anything else reads "an unexpected problem", with the full text still in the CE log. AutoCAD status words keep their own wording.
   2. **Footing widths:** the three labels match the real setting names (`FootingWidth.StripWidthMm`, `BeamWidthMm`, `ScrewPileDiameterMm`, UserSettings.cs:53 and 1327 to 1336). They are marked "not on the Settings page", which is true. Lookup ignores case, and the page-label lookup still wins first.
   3. **Changes nothing else:** no value and no drawing change.
4. **Redo-safe and protection:** no added line in the train has `StartTransaction`, `SetSystemVariable` or `SetCurrentView` (assembler scan; my review of the diffs agrees). Nothing is unlocked, nothing touches Xrefs or REFEDIT.

## 2. The new defaults

1. **No Settings value or switch is added to the Structural settings file by this train.** The Models folder is unchanged.
2. **CeMemberSettings (1.5, 2.0, scale 100):** engine values only. No command uses them, so nothing changes for Tim.
3. **Behaviour changes without a switch:**
   1. **CE_VERSION leaves Structural.** This is Tim's ruling (20 Oct item 8, "move version into manager"). The old behaviour, two owners of one command, is the bug.
   2. **CXREF wording.** The raw program text was the S-38 LOW.
   3. **Footing-width labels.**
   4. **Verdict:** all three follow the rule "on by default only if the old behaviour is the bug". Nothing needs turning OFF.
4. **Values without a row:** see ANSWER FIRST item 8. I built no rows.

## 3. Installer and update safety

1. **The signed-update gate (OfficialReleaseGate) cannot be affected.** No file under `Shared/`, `Installer/` or `Modules/Manager` is in the train.
2. **The installer command-ownership check (SafeBundleInstaller.VerifyCommandOwnership) is affected only by Structural listing one command fewer.**
   1. **Why that is safe:** the check refuses a bundle whose commands another enabled CE bundle also lists. A shorter list can only remove a clash, never add one.
   2. **What it makes possible:** this is exactly what lets the Manager half install later.
   3. **The flip side:** installing the Manager half BEFORE this train would be refused.

## 4. Builds and tests (Release, my head e3f581d2)

1. **Method:**
   1. **Flags:** `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal, every command in the foreground.
   2. **Build lock:** taken and released per command. No lock left.
   3. **AutoCAD refs:** `_AcadRefNet8=C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48=C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 on a short PATH.
   4. **Logs and workers:** `CE_LOG_DIR_OVERRIDE` at a scratch folder, NUnit workers 1.
   5. **Build order:** restore with `EnableUnifiedHostAdapters=true`; Structural standalone first, copied to `bin\Release` for CommandTruth (assembler's step 2.2); then the solution.
2. **Whole solution:** 0 errors (999 warnings; the assembler counted 269 by a different route, and I did not reconcile the count).
3. **Structural net10:** 414 classes in 14 chunks (Sbeam evidence class left out): 5157 passed, 0 failed. Nested classes: 7 of 7. **Total 5164, all passed.**
4. **Structural net48:**
   1. **Result:** 4420 plus 7 nested = **4427 passed, 36 failed, 698 not run.**
   2. **Where the 36 sit:** beam-wall clash geometry, Sbeam placement adapter, text-move anchor, beam prompt adapter, bracing length, window render, CE_SHARED binary compatibility, hatch background, and the footing-memory undo tests.
   3. **None is new:** not one is in a file this train touches.
5. **DesignCore, 3 lanes:** 2121 each, 2116 passed, 5 failed. The 5 need the release settings (`CE_STRUCTURAL_EXPECTED_SOURCE_HEAD` and the lane DLL paths), same names as S-38 except my renamed test.
6. **Release-lane class with the release settings set to my own x64 builds (product version `1.0.118+e3f581d2...` on all four DLLs):** 7 of 7, net10.
7. **Red first:** at `3de4e748` with the same settings, 5 of 7. The CE_VERSION check failed for the real reason; the hosted one failed only because no hosted DLL path was given.
8. **CE.CommandTruth.Tests:** 22 of 23.
   1. **The red:** `Structural_KnownRegistryDriftRemainsPinnedBacklog`, which expects 301 and 272 but finds 394.
   2. **Why it is also red on the base:**
      1. Its pins are far older than the base (base 395).
      2. Its file is not touched by the train.
      3. The assembler ran the base and saw the same failure.
   3. **What I did not do:** I did not build the base myself.
9. **Structural.ReleaseTests:** 10 of 10 on net48, net8 and net10.
10. **Guards:** ran inside the full runs on both lanes. The Plugin.cs pin (Stage3B6), Bug852VersionOwnerTests, the doubled-question guard and the redo guard all pass on net10. None is in the net48 failing list.
11. **Not run:** Structural net8 tests, the Sbeam evidence class (it hangs), Drainage, Manager, Installer.Tests, anything in AutoCAD.

## 5. Hygiene

1. **Tim's settings files, first 16 hex of SHA-256, before (22:47) and after (23:14), all unchanged:**
   1. **`CE_CVL_SUITE\settings.json`:** 672 bytes, `efe307c4fc74b0f`.
   2. **`CE_STRUC_SUITE\CS_Settings.json`:** 34,856 bytes, `f68eeb5e343cc39`.
   3. **`TIM_CE_CADTOOLS\CS_Settings.json`:** 351,713 bytes, `622a246f7d3b162`.
   4. **`TIM_CE_CADTOOLS\CD_Settings.json`:** 15,270 bytes, `acd64e79a33be9c`.
   5. **The assembler's change:** the assembler's "CD_Settings changed" note covers a time before my run.
2. **Processes:** acad.exe and testhost were not running at the end.
3. **Pictures:** test runs rewrote 76 pictures under `docs/image/V3_WINDOWS`. I restored them before the push, so the train changes no picture.
4. **Push:** `3de4e748..e3f581d2` fast-forward. Leak scan clean, 36 terms. No `--no-verify`.
5. **Cleanup:** worktree `C:\ce-fin\s39` and my logs and log folder are removed.
   1. **Left in place:** older files in `C:\ce-fin\logs`, dated 19 Oct, are another job's.
   2. **Main checkout:** unchanged.

## 6. Findings

1. **LOW 1:** `Plugin.cs:246` and `VersionInfoService.cs:339` say "Type CE_VERSION". This is wrong only between this install and the Manager half. Plugin.cs is fingerprint-pinned, so a wording fix needs a re-pin.
2. **LOW 2:** `Structural_KnownRegistryDriftRemainsPinnedBacklog` is a standing red on the base, with pins 301/272 against 394 real. Someone should re-pin it with the backlog list. Not this train's.
3. **LOW 3:** the CEMEMBER values and the three FootingWidth values have no Settings page rows (R-00). This must be done before CEMEMBER becomes a command.
4. **LOW 4 (carried):** entries 1504 to 1507 LOWs (BL shape copy, 18CONT spelling, C purlin lips with flanges up, vertical member tie-break).

## 7. What Codex should check in AutoCAD (copies only), after S-39 is installed

1. **CE_VERSION:** type `CE_VERSION`. AutoCAD says Unknown command. This is expected until the Manager half is in.
2. **About:** type `CESETTINGS` and click About. The About window opens with the Structural version.
3. **Other commands:** `CEADMIN` and `CE_HELP` open as before.
4. **CXREF:** try it on an Xref while its clipboard file is held open by another program. The line names the file problem and says "Nothing was changed".
5. **After the Manager half is installed:** `CE_VERSION` opens the version window, and CE Tools > Version does the same.

OPUS SIGN-OFF train claude/rel-20261020s GO (e3f581d2f4b358924657093cfe907f78720285cb)
