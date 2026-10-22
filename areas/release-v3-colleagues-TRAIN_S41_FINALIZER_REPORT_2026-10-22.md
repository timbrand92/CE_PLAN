# S-41 Opus finalizer: Structural train claude/rel-20261022s2

Independent check of what S-41 adds on top of S-40 (`claude/rel-20261022s` = `329691b7`, Structural 1.0.120, the installed Structural line). Thu 22 Oct 2026, about 12:58 to 13:20 Melbourne time (PC clock). Opus 5.5, Team, headless, desk plan/03. Private worktrees `C:\ce-fin\s41` (train) and `C:\ce-fin\s41b` (base, for comparing net48 reds), both removed at the end. I did not start AutoCAD or accoreconsole, deployed nothing, changed no version field, closed no PR, deleted no branch, merged no Civil or Manager PR, marked no bug FIXED, did not edit DESK_LOG.md.

## ANSWER FIRST

1. **GO at `871ad9716fa2996fb7cbd5a76c0e52be94defc05`.**
2. **Branch `claude/rel-20261022s2`, final head `871ad971`.** Start head checked: `git ls-remote` gave `7fcbdd4b33895fc0f3d9aa48adc2c4775cfd2f06` at the start, equal to the assembly report. My push was a plain fast-forward `7fcbdd4b..871ad971`; leak scan clean (36 terms). No version bump.
3. **One commit of mine, `871ad971`, a real fix (small, said loudly):**
   1. **The problem (introduced by #1518 in this train):** the brief and the PR said "an existing layer, locked or not, is never changed". That is not true as merged. CEMEMBER now asks the shared layer helper for a HIDDEN (or HIDDEN2) layer under the office's own hidden-layer name, and that helper, when the layer already exists, re-sets its linetype (`StructuralDetailService.EnsureLayerInTransaction`, the "Layer already exists, upgrade its linetype" branch). So an office that renamed the hidden layer to its own layer already in the drawing (say S-HID, DASHED) would have S-HID silently switched to HIDDEN, and everything already on it would change look. Before #1518 the office name was asked for as Continuous, which the helper leaves alone. (A locked layer is refused earlier by the existing protection check, so the locked case was safe.)
   2. **The fix:** an office name that is already in the drawing is used exactly as it is; only a missing one is created dashed (colour 8 HIDDEN, or colour 9 HIDDEN2), which is what #1518 meant. CE's own names (18HIDDEN, 9HIDDEN2 and the rest) take the unchanged SBEAM path. Four lines in `CeMemberLineWriter.cs`.
   3. **Test:** source guard `AnOfficeLayerThatAlreadyExists_IsNeverChanged` (red on `7fcbdd4b`: the skip is not there). Passes on net10 and net48.
   4. **Also in the same commit, comment only:** the SBEAM window Z purlin picture comment said the lowest-left corner sits at 0, 0; it sits one web thickness in. Now says so (Opus LOW, entry 1577).
   5. **REGRESSION_LOG.md:** one entry with the AutoCAD check.
4. **Tests at my head (Release, every command `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal, foreground):**
   1. **Whole solution:** 0 errors (927 warnings), serial, `EnableUnifiedHostAdapters=true`.
   2. **Structural net10: 5212 of 5212 passed** (14 chunks plus 7 nested). That is the assembler's 5211 plus my one guard.
   3. **Structural net48: 4472 passed, 39 failed, 698 not run (5209).** I built the S-40 base `329691b7` myself and ran the same chunks: 37 failed. Compared by name: the train adds exactly `ZcOutline_IsACleanZ_ItNeverCrossesItself` and `ZcOutline_WebIsOneThicknessThick_AndTheFlangesPointOppositeWays` (new #1510 tests, the net48 AutoCAD-stub failure; both pass on net10). No other difference. The assembler's claim checks out.
   4. **DesignCore: 2195 per lane on net48, net8 and net10; 2190 passed, 5 failed per lane**, the same five release-settings names as S-40. I did not re-run them with the release settings set.
   5. **CE.CommandTruth.Tests: 22 of 23.** The one red is the standing `Structural_KnownRegistryDriftRemainsPinnedBacklog` (expects 301, finds 395, the same 395 as S-40).
   6. **Structural.ReleaseTests: 10 of 10 on net48, net8 and net10.**
5. **What Tim will see in AutoCAD after this train is installed (plain words):**
   1. **SBEAM Z purlin (ZC):** draws as a clean Z that hatches properly (no edge cutting through the bottom flange), and the picture in the SBEAM window is the same Z.
   2. **LBUH dots:** at 1:100 they are separate dots, not a solid pink blob, and look the same on paper at 1:20, 1:50 and 1:100. At 1:20 nothing changes.
   3. **LBH (load bearing wall over, ANSI31 lines on layer HATCH 11) also changes at 1:50 and 1:100:** the lines are now as far apart on paper as at 1:20 (pattern scale 125 at 1:50, 250 at 1:100, was 50). Nobody has looked at this one; it follows Tim's 20 Oct "all scales based off drawing scale".
   4. **Waffle pods:** unchanged, still the real-size 1190 grid at every scale.
   5. **CEHATCHAUDIT** now expects the new scales, so an LBUH or LBH hatch drawn at 1:100 before this install will show as "wrong scale"; it only changes if the drafter chooses repair.
   6. **EBT tags (and EBB, BEBT, IBT, SFT and the rest of that family):** at 1:50 a tag is 125 high, the same as a 25C note (was 250); at 1:100 with 2.5 mm nothing changes.
   7. **CEMEMBER:** with the hidden-layer name changed in Settings to a new office name, the hidden lines come out dashed on that new layer, not solid. If that office layer is already in the drawing, CE uses it as it is and does not touch its linetype or colour.
6. **Do not mark FIXED:** BUG-858 and its SBEAM-window preview follow-up; BUG-748 (including the LBH side effect); BUG-531; CEMEMBER (b) to (h) including slice (h) (#1509, no caller) and the renamed-hidden-layer fix (#1518 plus my fix). Each needs a robot PASS plus a Codex PASS in AutoCAD. Codex looks owed (RULES 5.7): the SBEAM window Z purlin picture; LBUH and LBH at 1:20, 1:50, 1:100 on paper.
7. **Values and switches without a Settings page row (I built none):** `Layouts.HatchDensityFollowsPaper`, `Layouts.TagTextFollowsLabelHeight` (both new here, both with a recovery label), `Layouts.FollowAnyDrawingScale` (from S-40) and the CeMember group (9 values, S-40).
8. **Risks:**
   1. **LBH changes at 1:50 and 1:100 with no look yet** (item 5.3). Covered by Tim's 20 Oct rule; if Tim wanted LBH fixed, the switch turns both off, so a separate LBH value would be needed.
   2. **25C now reads the label-height Setting** (`Layouts.LabelPlotHeightMm`) instead of a fixed 2.5. Default 2.5, so no change unless that value was changed. Tim's "yes" on 20 Oct (one Settings value for 25C and EBT) supports it.
   3. **Nobody has seen any of it in AutoCAD.**
9. **Tim's four settings files: unchanged** between my start (13:01) and end (13:16): `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 bytes `acd64e7`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes `622a246`; `CE_CVL_SUITE\settings.json` 672 bytes `efe307c`; `CE_STRUC_SUITE\CS_Settings.json` 35,180 bytes `f682929` (first seven hex of SHA-256; same as the assembler's).
10. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Review of the merged PRs

1. **Merge integrity:** the train against `329691b7` (before my commit) is 30 files, +1011 -92, all under `Modules/Structural*` except `REGRESSION_LOG.md`. Nothing under `Shared/`, `Installer/`, `CE.Host`, `Modules/Drainage`, `Modules/Manager` or `Assets/`; `Plugin.cs` and the Structural `command-registry.json` untouched. `REGRESSION_LOG.md`: +74 -0, no conflict markers. `UserSettings.cs`: +15 -0 (both new switches, each with its comment). `SettingsService.LoadRecovery.cs`: +2 -0 (both new recovery lines); S-40's `FollowAnyDrawingScale` label naming AD, LD and Q is still there. Nothing from #1496 or #1498 was lost in the keep-both. No added line contains `SetCurrentView` or `SetSystemVariable`.
2. **#1510 (BUG-858):** `StructuralDetailService.BuildZcSectionVertices` traces a clean 12-corner Z (web one thickness thick, top flange right from the web's left face, bottom flange left from the web's right face, 2W - t wide); I walked the 12 corners: no edge crosses another. `SteelSectionPickerDialog.Preview.cs` `BuildZCOutline` now calls that same builder (one code path). `SbeamPlacementPlanner` sizes the Z the same way and refuses a Z with no usable thickness (a catalogue fault, never guessed). Comment LOW fixed by me.
3. **#1498 (BUG-748):** `DrawingScaleRule.HatchPatternScale` gains the paper rule (1:20 value x DIMSCALE / 20) only when the switch is on and the old rule gives an answer; placement, preview, CEHATCHCHANGE and CEHATCHAUDIT all go through it (one code path). Presets that change by default: LBUH (DOTS 20/20) and LBH (ANSI31 50/50). Earth (8/40) and concrete (1/5) are already in proportion: unchanged. Every fixed-scale preset is untouched; the waffle is now a fixed 1.0 (it used to go through the scale pair at 1.0/1.0, which the paper rule would have grown).
4. **#1496 (BUG-531):** the 14 EBT-family cases now read `GetBeamTagTextHeight()`: switch on gives `Get25TextHeight()` (the 25C path, which already handles paper space), off gives the earlier 250. `Get25TextHeight` now uses the label-height Setting instead of a literal 2.5 (risk 8.2).
5. **#1509 (CEMEMBER slice h):** three DesignCore files (`CeMemberRecord`, `CeMemberReplanner`, a small engine addition). No caller anywhere in `Modules/Structural` (searched); no command, ribbon, registry or `PackageContents.xml` change.
6. **#1518:** the look of a new renamed layer is right; the existing-layer case was not (my fix, ANSWER FIRST item 3). LOW still open: the look of 18HIDDEN and 9HIDDEN2 is written in two places (the SBEAM layer switch and `NewLayerLook`); it is code, not wording, so listed, not changed.
7. **Protection, undo, units:** no change adds a write outside the existing transactions; CEMEMBER keeps its protection check before writing (locked layers refused); nothing touches Xref or REFEDIT handling; no added `SetSystemVariable`, so U and REDO behave as before. Millimetre and metre drawings: the hatch and tag heights follow DIMSCALE through the same rules as 25C and the existing hatch rule; the Z outline is drawn from the catalogue numbers times the existing unit scale.

## 2. New defaults judged

1. **`Layouts.HatchDensityFollowsPaper`, default ON: kept ON.** It changes what Tim sees (LBUH and LBH at 1:50 and 1:100). The old behaviour is the bug: BUG-748 records the solid blob at 1:100 from a Codex look; Tim, 20 Oct item 12: "all scales should be managed with all scales based off drawing scale controlled by ltscale and dimscale"; the desk reading there names hatch density "the same dots per square cm of paper at every scale (BUG-748)". LBH is the same fault in line form under the same rule.
2. **`Layouts.TagTextFollowsLabelHeight`, default ON: kept ON.** It changes EBT-family tags at any scale other than 1:100. The old behaviour is the bug: BUG-531 records EBT at 250 (5 mm on paper) beside 25C at 125 (2.5 mm) at DIMSCALE 50; Tim, 20 Oct item 9: "25C and EBT text heights follow one Settings value", Tim: "yes".
3. **#1509 and #1518 add no Settings value.** #1518 has no switch: a solid line on a hidden layer is the bug.
4. **Nothing turned OFF by me; no default changed by me.**

## 3. Installer and update safety

1. **Signed-update gate (`OfficialReleaseGate`):** the train touches nothing under `Shared`, `Installer`, `CE.Host`, Manager or Civil. It cannot change the gate.
2. **Installer command-ownership check (`SafeBundleInstaller.VerifyCommandOwnership`):** it reads the `<Command>` entries of each bundle's `PackageContents.xml`. Neither `PackageContents.xml` changed, `Plugin.cs` did not change, the command register did not change. No command is added or removed (CEMEMBER was registered in S-40). The check sees nothing new.

## 4. Test evidence

1. **Environment:** worktree `C:\ce-fin\s41`, Release, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs` (as the assembly report), AutoCAD 2027 first on a short PATH, scratch `CE_LOG_DIR_OVERRIDE`, NUnit workers 1, Below Normal, every command in the foreground. Build lock folder taken only while a command ran; gone at the end.
2. **Build method:** solution restore with `EnableUnifiedHostAdapters=true`; Structural standalone build copied to `bin\Release`; whole solution with `EnableUnifiedHostAdapters=true -m:1`.
3. **Structural chunks:** 420 class names read from source (the hanging `SbeamEditAutoCadEvidenceReaderTests` left out), 14 chunks of 30 plus the nested filter. Net10: 366, 336, 216, 284, 358, 281, 362, 361, 376, 718, 382, 314, 332, 519, 7 = 5212, 0 failed. The new guard ran and passed on both targets (read from the result files).
4. **Not run:** Structural net8 tests (built only, as S-39 to S-41), the Sbeam evidence class (hangs), DesignCore with release settings set, Drainage, Manager, Installer.Tests, anything in AutoCAD or accoreconsole.
5. **Pictures:** test runs rewrote 76 files under `docs/image/V3_WINDOWS`; restored before the commit. The commit holds four files only.
6. **Cleanup:** both worktrees, logs, runner scripts and my temporary local branch removed; main checkout unchanged.

## 5. For the desk

1. **Codex in AutoCAD (copies only), after install:** SBEAM with a ZC: drawn section and window picture are the same clean Z, hatch fills it. LBUH and LBH at 1:20, 1:50, 1:100: same density on paper. EBT at DIMSCALE 50: 125 high, beside a 25C note. CEMEMBER: (a) hidden layer renamed to a name not in the drawing: created HIDDEN colour 8; (b) renamed to an existing layer S-HID (DASHED, colour 3): hidden lines on S-HID, S-HID still DASHED colour 3. Settings changed BEFORE starting AutoCAD.
2. **Carpark candidates (LOW):** the two places that write the 18HIDDEN / 9HIDDEN2 look; Settings rows for the four items in ANSWER FIRST item 7; the stale CEMEMBER help text (from S-40); the SBEAM top elevation of a Z is one flange wide (from 1557).
