# B-017 BUG-1095 fix report: the council minimum runoff C is now applied

Thu 29 Oct 2026 (Melbourne), CE 01 Build, headless job.

## ANSWER FIRST

1. **PR:** #1852, DRAFT, `fb/bug1095-council-min-c` into `claude/rel-20261026z` (Civil 3.0.85). Not marked FIXED. Built and unit-tested only; nobody has opened it in AutoCAD.
2. **Switch:** `detention.councilMinimumRunoffCApplied` (the nearest convention to council.minimumRunoffCApplied: it sits with the other detention switches). Default ON. No Settings page row (see mistakes).
3. **Mistakes of my own, first:**
   1. A first run of my wait script lost about 10 minutes: it called `powershell` and `dotnet` by bare name, which this tool's PATH does not have, so it looped without building. Cost: time only, no wrong build.
   2. The job found an earlier attempt already in the worktree: a Codex branch merged onto 3.0.85 plus my own commit. I reused it and re-verified rather than rebuilding, so the red-first test commit (`746ae844`) was written by that earlier attempt, not re-run by me today.
   3. The Settings page has no row for this switch. The earlier attempt measured the row at 725 px against a 673 px limit and left it out. Tim can only turn it OFF by editing the saved settings. The neighbouring detention switches have no row either.
   4. The switch default is pinned in `CouncilMinimumCBug1095Tests`, not in `C75NewSwitchDefaultsTests` as the brief suggested.
4. **Not proven:** nothing was run in AutoCAD. The real CDDESIGN window, the computations sheet text, CDCHECK and CDRULES output on a Darebin job have not been looked at. The Boyd's tab was rendered off-screen in both themes (pictures in `docs/image/V3_WINDOWS/`), which is not a real AutoCAD window. I did not compute the actual tank volume before and after; only the inflow scaling is pinned.
5. **Robot case:** see the last section.

## FOR TIM

1. **What changes:** a Darebin job now sizes the tank on at least C 0.80, the council's own minimum. Before, CDDESIGN used the weighted figure from your areas (0.70 on a typical lot), so the tank came out too small. Maribyrnong (0.75) and Boroondara (0.65) get the same treatment. These figures were already stored from the council documents and your 4 Sep ruling; nothing about a council figure changed.
2. **Where you will see it:**
   1. **CDDESIGN result and the computations sheet notes:** a new line "[CE] council minimum C governs" and "[CE] Runoff C = 0.80 (calculated 0.70)."
   2. **CDCALC, Boyd's tab:** the runoff coefficient box and the effective area use the council minimum, and the tab's warning area shows the same two lines.
   3. **Automatic pump sizing:** the storm inflow uses the council minimum.
   4. **CDRULES and CDCHECK:** no change that I made. CDRULES still prints the council row as before.
   5. **Not changed:** the permitted discharge (the before-development figure), the pit and pipe drawing, any other council.
3. **Worked example (Darebin, 600 m2 lot, 400 m2 roof and paving, 200 m2 garden):**
   1. Before: C = (400 x 0.9 + 200 x 0.30) / 600 = 0.70. Effective area 420 m2.
   2. After: C = 0.80. Effective area 480 m2.
   3. Every storm inflow is 0.80 / 0.70 = 14.3 per cent higher, so the storage the sweep finds is bigger. Put the other way, the old inflow was 87.5 per cent of the council's. The permitted discharge stays the same, so the whole increase goes into the tank. The audit's figure for a 300/300 split was about 25 per cent small; I did not recompute that.
   4. A job whose own weighted C is already above the minimum (0.85, say) is unchanged and shows no council line.
4. **Past jobs:** CDDESIGN did not apply the floor before, so earlier Darebin, Maribyrnong and Boroondara detention designs by CE may be small. The desk should list them from the job records (open questions C16 and C19 are answered: the floor was not applied). I did not search the job records.
5. **Test in AutoCAD (one scenario):** on a Darebin test copy, 600 m2 site, 400 m2 roof and paving, 200 m2 garden, run CDDESIGN. Right looks like: C 0.80, the "council minimum C governs" line, and the same permitted discharge as before. Then open CDCALC Boyd's with the same areas: C 0.800, effective area 480 m2.
6. **Nothing blocks:** the line is a note. If the council figure is only assumed, you also get the existing "check the council requirement" warning, and the design still runs.

---

## TECHNICAL DETAIL

1. **Cause (confirmed on the shipping line origin/claude/rel-20261026z):** `Rules/CouncilRuleValues.cs:99` `PostDevelopmentC` (floor = `Math.Max(calculated, council figure)` when `PostDevCMode` is "floor") had no caller anywhere in `Modules/Drainage` (git grep on the base). Carpark lines moved since 3.0.72: `AutoDesignService.cs:309-321` is now the Step 2 block near line 100; `PumpSizingService.cs:211-212` is near line 217; `CouncilRuleValues.cs` unchanged at 99.
2. **Council data:** `Assets/Config/council-profiles.json`: Boroondara 0.65 (Sourced), Darebin 0.8 (OfficeRule, Tim CP-03 4 Sep), Maribyrnong floor mode. Fixed-C profiles keep their older treatment (`PostDevCMode` not "floor" returns the calculated C unchanged). Unknown profile or invalid C stays unset and the calculated C is used; there is no quiet zero.
3. **Change:** new `CouncilRuleValues.ApplyMinimumPostDevelopmentC(profile, calculatedC, notes, switchOn)` reuses `PostDevelopmentC`. Called from: `AutoDesignService` (the developed catchment is rebuilt as one surface at the governing C so every flow and the storage sweep use one C; before-development C and area untouched), `PumpSizingService` (council from `CouncilId`, else `FindByName(CouncilName)`), `BoydsCalcViewModel.Recalculate` (council from the loaded job; note kept in `CouncilMinimumCNote`), and `ComputationsRecordBuilder` (attaches that note to the Boyd's storage note only when a system actually uses that Boyd's volume).
4. **Known gap:** `PumpSystemCalcViewModel` (read-only Pump System calculator) also derives an effective catchment and is left unchanged; the brief named three places.
5. **Files:** `Models/UserSettings.cs`, `Rules/CouncilRuleValues.cs`, `Services/AutoDesignService.cs`, `Services/PumpSizingService.cs`, `Services/ComputationsRecordBuilder.cs`, `ViewModels/BoydsCalcViewModel.cs`, `REGRESSION_LOG.md`, tests `Services/CouncilMinimumCBug1095Tests.cs`, `Dialogs/Bug1095CouncilMinimumCRenderTests.cs`, two window pictures. CE_SHARED not changed. No drawing write, command, regen, view or system variable added (REDO-safe); no layer, Xref or REFEDIT handling touched.
6. **Switch tests:** default ON through `new DetentionSettings()`, `DeserializeSettings` and `DeserializeSettingsTolerant` (empty, empty detention block, explicit false); round trip; with OFF the Darebin result returns exactly 0.70 / the old effective area, same flows, no note, and the proposal report text is identical.
7. **Runs today (below-normal priority, SkipDevBundle, net10 with AutoCAD 2027 on PATH, placeholder arx untracked):** focused 59 passed, 0 failed (count not zero). Full Civil suite 20,809 passed, 0 failed, 32 skipped (20,841 total). net48 compile of `CE_CVL_SUITE.csproj`: 0 errors. bin/obj cleaned with `git clean -fdXq` in `C:\ce-fx\c78a` only.
8. **Red first (earlier attempt, not re-run today):** test-only commit `746ae844`: 9 cases, the 3 Darebin cases failed (expected 0.80, actual 0.70) with product code untouched.
9. **Not tested:** AutoCAD, real settings file, real Darebin job, CDCHECK, CDRULES output, past-job impact, the PumpSystemCalc calculator.

## ROBOT CASE (to add by CE 01)

**Case name:** N32_bug1095_council_c (switch-off control: N32_bug1095_council_c_off).

1. **Setup:** a fresh Example Job copy with the council set to Darebin; CDDESIGN inputs 600 m2 site, 400 m2 roof and paving, 200 m2 garden, 1 in 100 storage storm as the build's default.
2. **Types:** CDDESIGN with those areas, accept the result, then CDCALC, Boyd's tab, same areas.
3. **Checks:** the CE log / result text contains "[CE] council minimum C governs" and "[CE] Runoff C = 0.80 (calculated 0.70)."; Boyd's coefficient reads 0.800 and effective area 480; the permitted discharge line equals the OFF run's.
4. **Control (switch OFF):** set `detention.councilMinimumRunoffCApplied` to false in the settings before AutoCAD starts (settings are read at launch). Same inputs must show no "council minimum C governs" line, Boyd's coefficient 0.700 and effective area 420.
5. **Second control:** a council with no floor (generic-default) at the same areas shows 0.70 with the switch ON.
