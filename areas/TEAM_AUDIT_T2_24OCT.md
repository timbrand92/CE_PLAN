# TEAM OPUS AUDIT T2 — Water-sensitive design and council rules — Sat 24 Oct 2026, Melbourne

**Desk:** plan/03, headless Team job, Opus. **Read-only:** no code changed, nothing built, nothing run in AutoCAD.
**Code read:** `origin/claude/rel-20261023m` at f7f7d551 (installed Civil 3.0.72 / Manager 1.1.72), read-only worktree `C:\ce-ta\t2m`. Structural `origin/claude/rel-20261023s` at e6d597c0 (1.0.122) holds no water-sensitive-design code, only reference CSV/JSON in its markup corpus, so every finding below is Civil.
**Documents checked against:** `ENGINEERING_RULEBOOK.md` (sections E, F, R-00 to R-29, CP-01..08), `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` (CR-A1, A2, A3, A5), `02_COUNCIL_RULES\` (council files, CR-D1 sweep, OPEN_QUESTIONS, FINDING_PERVIOUS_C_SPLIT), the R-00 Civil audit `areas\release-v3-colleagues-R00_CIVIL_2026-10-09.md`.
**Known-bug check:** every finding was grepped against `BUG_CARPARK.md` (to BUG-1087), `CODEX_AUDIT2_RD01..RD22` and `QUESTIONS_FOR_MONDAY.md`. Known ones are listed by number only (section C).
All file paths are under `Modules/Drainage/`. Every standard or council clause is from CE_PLAN's own records; the council PDFs themselves were not re-read (UNVERIFIED).

---

## ANSWER FIRST

1. **Counts:** 26 new findings: 5 HIGH, 10 MEDIUM, 11 LOW. 21 SURE, 5 UNSURE. 21 known bugs and 3 open questions matched (section C). 11 calculations hand-checked and found to match the code, plus the council data (section D).
2. **Top 3:**
   1. **The council "minimum after-development C" is never applied.** Darebin 0.8, Maribyrnong 0.75 and Boroondara 0.65 are stored and sourced, but CDDESIGN never uses them. A Darebin lot works out at C 0.70 instead of 0.80, so the inflow is 12.5% low and the tank comes out too small.
   2. **The rainwater-tank reuse credit never runs on a real job.** The formulas exist and pass their unit tests, but CDDESIGN never passes them a tank. R-10 does not work for any council, and the Kingston formula it would use over-credits big tanks.
   3. **R-13 (300 mm minimum head on a charged downpipe system) is never checked.** CDRULES prints "R-13 charged minimum head: 300 mm" as if it were enforced. A 250 mm head passes the Charged System tab with no warning.
3. **Settings page (R-00), still true on 3.0.72:** none of the runoff numbers has a box on the Settings page. That covers before-development C 0.35, soft-ground C 0.30, hard-ground C 0.9, office Tc 5 min, office PSD storm 1-in-5 and charged minimum head 300 mm. They live only in the settings file (known: BUG-546). No council value can be edited anywhere in the product (new finding 15).
4. **What is right:** the rainfall curve, the Rational Method sum, the orifice sizing (rounded DOWN to the whole mm, CR-A3), Casey's K, the Boyd's sum, Manningham's credit sum, Tim's two C values (CR-A1) and the one-tank reuse/detention split all match hand calculations (section D). The Blue Factor fix for garden and lawn (BUG-967) is in this build.

---

## A. New findings, ranked

1. **The council "minimum after-development C" is never applied (Darebin, Maribyrnong, Boroondara)**
   - **Where:** the rule is `Rules/CouncilRuleValues.cs:99-114` (`PostDevelopmentC`), but nothing in the product calls it, only tests. CDDESIGN builds C with no floor at `Services/AutoDesignService.cs:309-321`. Pump sizing (`Services/PumpSizingService.cs:211-212`) and the CDCALC Boyd's tab do the same. The data is correct and sourced (`Assets/Config/council-profiles.json:518/545` Boroondara 0.65, `:581/628` Darebin 0.8, `:1167/1209` Maribyrnong 0.75, mode "floor").
   - **What the office would see:** on a Darebin job (600 m² lot, 400 m² roof and paving, 200 m² garden), CDDESIGN uses C = (400 × 0.9 + 200 × 0.30) ÷ 600 = **0.70**. Darebin requires at least **0.80**, so the inflow is 0.70 ÷ 0.80 = 87.5% of the council's. The permitted discharge does not change, so the storage shortfall is larger than 12.5%. On a 300/300 split it is worse: C 0.60 against 0.80, 25% low. This also answers open questions C16 and C19 ("is the floor being applied?"): no.
   - **Severity:** HIGH. **SURE** (the code path has no caller, and the hand calculation is shown).
   - **Smallest fix:** pass the weighted C through the existing `PostDevelopmentC` in those three places, and print "council minimum C governs" on the sheet.

2. **The rainwater-tank reuse credit never runs on a real job (R-10)**
   - **Where:** `Services/AutoDesignOrchestrator.cs:156-157` only works the credit out when `inputs.ReuseTank` is set. Nothing in the product sets it: the only caller, `Services/CivilDesignService.cs:145-174`, never fills it, and the CDDESIGN window has no reuse box.
   - **What the office would see:** a Manningham job (gross storage 10 m³, 300 m² of roof to a 3,000 L plumbed tank, 500 m² impervious) should show a credit of 0.25 × 10 × (300 ÷ 500) = 1.50 m³, net 8.50 m³. The computations show no reuse-credit section at all. BUG-538 assumes the credit reaches the storage result; it does not.
   - **Severity:** HIGH. **SURE** (traced end to end).
   - **Smallest fix:** add tank litres, connected roof and "plumbed for reuse" to the CDDESIGN inputs and pass them through. The connected roof can be pre-filled from the rating report's tank-connected area.

3. **R-13: the 300 mm minimum head on a charged downpipe system is never checked**
   - **Where:** the value is `Models/UserSettings.cs:1980` (`ChargedMinHeadMm = 300`). It is only read by `Rules/RulebookValues.cs:245` (office figure only, no project override) and printed by `Commands/RulesCommand.cs:252`. `Rules/RulebookEngine.cs:44` lists R-13 as "not evaluated here". The Charged System tab warns only on "inputs must be greater than zero" and "capacity less than design flow" (`ViewModels/ChargedSystemCalcViewModel.cs:211-218`). `Services/Proposals/LevelsProposalEngine.cs:956` tells the drafter to "Check the head against the charged minimum head in Settings", but that box does not exist.
   - **What the drafter would see:** take a 100 m² roof (C 0.9, I 126 mm/h), a 150 mm pipe 48.5 m long, K 2.95, a 100 mm downpipe and **250 mm available head**. The flow is 0.9 × 126 × 100 ÷ 3600 = 3.15 L/s. The losses are 0.0164 m. The capacity is 0.82 × 0.007854 × √(2 × 9.81 × 0.2337) × 1000 = 13.79 L/s. 13.79 is more than 3.15, so there is no warning at all, although the head is 50 mm under the house rule.
   - **Severity:** HIGH. **SURE.** The missing Settings box is known (BUG-546); the missing check is new.
   - **Smallest fix:** a Settings box with a project override, and one warning in the Charged System tab and CDRULES when the head is under it. Warn and record, never block (R-27).

4. **The Kingston reuse credit follows the wrong rule and over-credits big tanks**
   - **Where:** `Services/ReuseCreditService.cs:166-183` gives 500 L for every COMPLETE 2,000 L of tank.
   - **The council rule** (`02_COUNCIL_RULES\COUNCIL_KINGSTON_ISSUE5_2025.md` §3): 500 L for a 2,000 L tank, **or 1,000 L for a tank of 2,500 L or more**. Separate single dwellings only, not shared tanks. Minimum 2,000 L and 50 m² of roof.
   - **Hand check, code against council:**
     - 2,500 L tank: code 1 block = 0.50 m³; council 1.00 m³ (code too low).
     - 6,000 L tank: code 3 blocks = 1.50 m³; council 1.00 m³. The code **over-credits by 0.5 m³**, the unsafe side.
     - 8,000 L tank: code 2.00 m³; council 1.00 m³.
   - Also missing: the 50 m² roof check, single-dwelling only, and no credit for a shared apartment tank.
   - **Severity:** HIGH once finding 2 is fixed; today it never runs. **SURE.**
   - **Smallest fix:** 500 L under 2,500 L, 1,000 L at 2,500 L and over, none for shared tanks or under 50 m² of roof. Store it as council-profile data (R-00), not in code.

5. **Maroondah (and Yarra Ranges): the council's own before-development C and lot-size Tc table are stored but never used**
   - **Where:** CDDESIGN chooses the before-development C at `Services/DetentionSizingService.cs:277-287` and the Tc at `:309` (also `Services/AutoDesignService.cs:404,408`). The council rules `PreDevelopmentC` (`Rules/CouncilRuleValues.cs:116-140`, with the 35% impervious cap) and `TimeOfConcentration` (`:142-159`, the lot-size table) have no production caller.
   - **What the office would see:** a bare 600 m² Maroondah lot, 1-in-5.
     - Council method: C 0.30, Tc 8 min (the 500–750 m² band). I = 73.63 mm/h. PSD = 0.30 × 73.63 × 0.06 ÷ 0.36 = **3.68 L/s**.
     - CE: office C 0.35 and the profile's Tc 5 min (tagged Assumed). I = 88.80 mm/h. PSD = 0.35 × 88.80 × 0.06 ÷ 0.36 = **5.18 L/s**.
     - CE's permitted discharge is **41% high**, so the tank is too small and the orifice too big.
   - **Severity:** HIGH on Maroondah jobs. **SURE** on the code. The council figures are from CE's council record, not re-read from Maroondah's PDF.
   - **Smallest fix:** call the two existing rules when a profile carries the cap or the table. **This needs Tim's word first:** the same Tc also sizes the outlet pipe, which is why Maribyrnong's Tc was held (open question C17).

6. **R-10 "ask on every job" is not built**
   - **Where:** `Services/ReuseCreditService.cs:61-63` returns only "has no reuse-credit rule in the rulebook". There is no "Needs confirmation" state, no question for the engineer and no saved answer.
   - **What the office would see:** on a Monash or Bayside job nothing asks how the tank is credited, and nothing is recorded as a learning example (R-10, R-LEARN).
   - **Severity:** MEDIUM (rule missing; nothing runs anyway, see finding 2). **SURE.**
   - **Smallest fix:** when no council rule exists, mark the credit "Needs confirmation", ask for the basis in CDDESIGN and save the answer on the job.

7. **The CDCALC Catchments (Rational Method) tab opens with a made-up catchment and a 15-minute storm**
   - **Where:** `ViewModels/RationalMethodViewModel.cs:37-38` (default 1-in-5, 15 min), `:157` (a seed catchment C1), and `:391-392` (every new row starts at 500 m² and C 0.9).
   - **What the drafter would see:** a new job opens CDCALC, Catchments, and already sees "C1, 500 m², C 0.9" and a total. 1-in-5 at 15 min: I = 55.08 mm/h, so Q = 0.9 × 55.08 × 0.05 ÷ 0.36 = **6.89 L/s** for a catchment nobody typed. A drafter who types only the area keeps the 15-minute storm. That gives 38% less flow than the office Tc of 5 min (88.80 mm/h, 11.1 L/s for the same 500 m²). The 5 min is the Settings value `DefaultTcMinutes`, which this tab ignores. The storm also ignores the council's PSD storm (Glen Eira is 1-in-10). The tab can go onto the computations sheet ("Rational method catchments" export).
   - **Severity:** MEDIUM. **SURE.** The C 0.9 part alone is known (BUG-544, R-00 item 26); the made-up area and the 15-minute default are new.
   - **Smallest fix:** start with no rows (Unknown stays Unknown, R-12), and start the storm at the Settings Tc and the job's council PSD storm.

8. **The council "minimum % of detention underground" is never checked**
   - **Where:** `MinUndergroundPct` is read only by the council-source viewer label (`ViewModels/CouncilSourceViewModel.cs:25`) and by tests. CDWT still offers "Tank goes [AboveGround/Underground] <AboveGround>" (`Commands/WaterTankCommand.cs:628`).
   - **What the drafter would see:** on a Banyule or Boroondara job (100% underground) an above-ground detention tank goes through with no warning. Glen Eira 50%, Monash 60%, Mornington 50% and Frankston 50% are the same.
   - **Severity:** MEDIUM (council rejection). **SURE.**
   - **Smallest fix:** CDWT and CDDESIGN warn when the above-ground detention share is more than 100 minus the council %. Default to Underground when the council asks for 100%.

9. **The Charged System tab takes pipe and downpipe sizes in METRES with no sense check**
   - **Where:** `Dialogs/CalculationsV2Dialog.xaml:726` "Pipe diameter (m)" and `:734` "Downpipe dia (m)". The sum is at `ViewModels/ChargedSystemCalcViewModel.cs:160-202`. Every other CE window uses mm.
   - **What the drafter would see:** typing 150 instead of 0.15 makes a pipe 150 m across. The losses show 0.0000 m, and the capacity comes out at 0.82 × 0.007854 × √(2 × 9.81 × 0.84) × 1000 = 26.15 L/s, a comfortable-looking pass. Typing 100 for the downpipe gives about 26 million L/s, also with no warning.
   - **Severity:** MEDIUM. **SURE.**
   - **Smallest fix:** take mm (divide by 1000 inside), or warn on any diameter over 2 m.

10. **R-22 local tank orifices: the tank minimum and the "sum of tank flows ≤ site PSD" check are never used**
    - **Where:** the tank minimum is stored (`council-profiles.json:802,834`: Manningham 25 mm, Maroondah 20 mm). `MinimumOrifice(profile, tankLocal: true)` (`Rules/CouncilRuleValues.cs:534-536`) has no production caller. `Rules/RulebookEngine.cs:47` lists R-20..23 as "not evaluated here".
    - **What the drafter would see:** a 15 mm tank orifice on a Manningham job gets no warning. Two tanks whose orifice flows add up to more than the site PSD get no warning either.
    - **Severity:** MEDIUM. **SURE.**
    - **Smallest fix:** until R-22 is built, CDRULES says "tank orifice minimum not checked"; then call the existing lookup when a tank orifice is sized.

11. **R-11, R-12 and R-21: the STORM / Blue Factor result is not carried with its source, and nothing compares the report's tank with the drawn reuse share**
    - **Where:** the rating is only printed (`Rules/StormReportOffer.cs:162-163`). The tank volume read from each report row (`Rules/StormReport.cs:271-273`) is used by nothing. The tank record (`Models/PitData.cs:272-310`, written at `Commands/WaterTankCommand.Apply.cs:343-357`) has no link to its report.
    - **What the office would see:** a report that relies on a 3,000 L tank, against a drawn tank with only 2,000 L of reuse below the outlet, passes silently. A reuse-only job carries no STORM result with its source. No override reason is recorded.
    - **Severity:** MEDIUM. **SURE.**
    - **Smallest fix:** store the rating, report file and date, and each tank size on the job. Warn when the report's tank litres differ from the drawn reuse litres. Allow an override with a typed reason.

12. **A rating report that names a two-word council sets a council CE cannot find**
    - **Where:** `Commands/CivilDesignCommand.cs:600-608` offers both council IDs and names. `Rules/StormReportOffer.cs:125-141` can match the NAME. `Commands/CivilDesignCommand.cs:576-579` saves that name as the council ID, and `Services/CouncilProfileService.cs:233` looks up IDs only.
    - **What the drafter would see:** a report saying "Municipality Glen Eira" prints "Council set to Glen Eira, from the rating report". The profile's ID is "glen-eira", so the lookup fails and the design still says the council is outstanding. The same applies to Mornington Peninsula, Yarra Ranges and every other two-word council. One-word councils such as Kingston are fine.
    - **Severity:** MEDIUM. **SURE** by reading; not driven in AutoCAD.
    - **Smallest fix:** turn the match into the profile's ID (look up by ID, then by name) before saving it.

13. **The raingarden outlet pit is never recorded**
    - **Where:** `Models/RaingardenData.cs:38-43` has the outlet fields. CDRG (`Services/RaingardenPlacementPlan.cs:235-243`) and nothing else ever fills them; the only writers are for spoon drains.
    - **What the drafter would see:** the Inspector (`Services/InspectorPaletteService.cs:2247-2248`) always says "No outlet registered", even after CDRG has placed the grated inlet and pipe.
    - **Severity:** MEDIUM. **SURE.**
    - **Smallest fix:** fill the outlet when the inlet or pipe lands on a pit, or change the words to "Outlet not tracked".

14. **Manningham's 2,000 L minimum is tested against the whole tank, not the reuse share**
    - **Where:** `Services/ReuseCreditService.cs:140`. The tank input (`Models/ReuseCreditModels.cs:20-25`) has no reuse/detention split.
    - **What the office would see:** a 3,000 L tank with 1,500 L of detention has only 1,500 L of reuse, so Manningham gives no credit. The code would still credit 0.25 × SSR × roof ratio. The "majority of the tank must be reuse" check is not warned anywhere.
    - **Severity:** MEDIUM (latent while finding 2 stands). **SURE** by reading.
    - **Smallest fix:** pass the reuse litres (total minus detention, as CDWT already works out) and test those.

15. **No council value can be edited anywhere in the product (R-00: "same for council values")**
    - **Where:** `Services/CouncilProfileService.cs` is read-only. The Settings page has no council section. `Rules/CouncilRuleValues.Confirm` (`:81`) has no caller. The only route is editing the shipped `council-profiles.json`, which the next install overwrites.
    - **What the office would see:** if Kingston changes its PSD storm tomorrow, nobody in the office can change it; it needs a new plugin build.
    - **Severity:** MEDIUM. **UNSURE** whether this is a fault or planned work not yet built (the provenance notes say "editable with recorded reason").
    - **Smallest fix:** a "Confirm / change value" action in CDRULEBOOK that writes to an office overlay file, with the reason recorded.

16. **CDDESIGN warns about council C values it never uses, and the council's own soft-ground C never wins (CR-A1 point 4)**
    - **Where:** the warning field list is `Services/AutoDesignService.cs:701-707`. The council `perviousC` and `imperviousC` are read by no calculation (CDDESIGN at `:316-318`, pump at `Services/PumpSizingService.cs:75,78`).
    - **What the office would see:** "Whitehorse / perviousC: Assumed - no council source" against 0.35, while the design actually used the Settings 0.30, which gets no source line. Tim's CR-A1 point 4 says a council's published figure wins; it never does. There is no numeric difference today, because the three councils that publish 0.30 (Banyule, Maroondah, Yarra Ranges) equal Settings.
    - **Severity:** LOW-MEDIUM (misleading sheet). **SURE.**
    - **Smallest fix:** warn only on fields the design read. Read the council's soft-ground C when it is Sourced.

17. **The pre-development "formula" text still says 0.3 while the number beside it is worked from 0.35**
    - **Where:** `council-profiles.json`, `preDevCFormula` = "(0.3*pervious + 0.9*impervious)/site" in 17 profiles (most of which hold `perviousC` 0.35). `Rules/CouncilRuleValues.cs:127-135` attaches that text as evidence beside a result worked from 0.35. The model default is `Models/CouncilProfileModels.cs:113`.
    - **What the office would see:** CDRULES or the source viewer shows a before-development C of 0.35 with "(0.3*pervious + …)" as its working. A checker reproducing it by hand gets 0.30. CR-A1 point 3 says "the printed working must show the number actually used".
    - **Severity:** LOW (this route is display only; CDDESIGN's own C is right). **SURE.** The split was first written up 15 Sep in `FINDING_PERVIOUS_C_SPLIT.md`, which was answered by CR-A1, but this text was never corrected and has no BUG number.
    - **Smallest fix:** rebuild the text from the numbers actually used, or drop the formula string.

18. **WSUD export prints a sample site nobody typed**
    - **Where:** `ViewModels/WsudViewModel.cs:19-24` (site 1,000 m², 200 m² and 700 m² impervious, 630 mm rain). The tab is read-only on 3.0.72, but the "WSUD / annual load reduction" export box (`Dialogs/CalculationsV2Dialog.xaml:1309`) still works. The export is `Services/CalculationExportPackage.cs:503-530`.
    - **What the office would see:** ticking the box on a new job puts "Total site area 1000 m², Impervious 200 / 700 m²" into the computations package as if they were the job's figures (Unknown stays Unknown, R-12). The tab cannot be typed in, so the drafter cannot correct them.
    - **Severity:** LOW. **SURE.**
    - **Smallest fix:** blank starting values, or untick and disable the export while the tab is read-only.

19. **A Blue Factor catchment that shares its name with another is dropped**
    - **Where:** `Rules/BlueFactorReport.cs:98` keeps one row per catchment NAME. This is needed because the report lists each catchment twice (see the test fixture at `Drainage.Tests/Rules/BlueFactorReportTests.cs:48-55`).
    - **What the office would see:** a two-townhouse job with "ROOF TO WT" 120 m² and "ROOF TO WT" 110 m² keeps only 120 m², so the tank-connected roof is 110 m² short.
    - **Severity:** LOW. **UNSURE:** I do not know whether Blue Factor allows two catchments with the same name.
    - **Smallest fix:** treat a repeat as a duplicate only when the name, surface and area all match.

20. **The office tank library has no Settings page box**
    - **Where:** `Models/UserSettings.cs:1829` (`TankLibrary`); no screen anywhere in Modules.
    - **What the office would see:** adding a new supplier tank means editing the settings file by hand (R-00).
    - **Severity:** LOW. **SURE.** **Smallest fix:** a tank list on the Settings page.

21. **CDWT on the command line ignores a typed detention of 0**
    - **Where:** `Commands/WaterTankCommand.cs:501` replaces a typed 0 with the library tank's figure. This is the AutoCAD 2022–2026 route.
    - **What the drafter would see:** nothing today, because every shipped library tank has 0 detention. Once an office tank carries a detention share, "0" can no longer be typed.
    - **Severity:** LOW. **SURE.** **Smallest fix:** treat a typed 0 as an answer.

22. **Lots of 1,000 m² and over get Tc 5 min with no note**
    - **Where:** `Services/RationalFlowService.cs:57` declares the 1,000 m² small-lot limit, but nothing uses it. `ResolveTcMinutes` (`:384-390`) returns the council Tc for every lot size.
    - **What the office would see:** the office rule is "Tc 5 min for lots < 1000 m²". A 2,500 m² residential lot also gets 5 min (except Kingston commercial, which warns, BUG-251). A longer Tc lowers the intensity: at 10 min it is 66.75 mm/h against 88.80 at 5 min. So the permitted discharge, and with it the storage, depends on a choice nobody is told about.
    - **Severity:** LOW. **UNSURE** (engineering judgement; Q7 rules out a routed Tc for STORAGE only).
    - **Smallest fix:** add a note on lots of 1,000 m² and over: "Tc 5 min used; the office rule covers lots under 1000 m²; confirm".

23. **`Assets/Config/ifd-melbourne.json` ships but is never read**
    - **Where:** it is mentioned only in a comment (`Services/RationalFlowService.cs:33`). The live curve is `Rules/RainfallCurve.cs:158-171`. The coefficients are identical today.
    - **What the office would see:** an engineer who edits the JSON to update the rainfall changes nothing.
    - **Severity:** LOW. **SURE.** The curve being in code is known (BUG-547, R-00 item 16); the dead file is new.
    - **Smallest fix:** delete the file, or read it.

24. **Downpipe placement preview is a fixed 100 drawing units**
    - **Where:** `Services/SourcePlacementService.cs:1594-1596` (±100 units, label 150 units away).
    - **What the drafter would see:** in a metre drawing the preview marker would be 200 m long. Not seen in AutoCAD.
    - **Severity:** LOW. **UNSURE.** **Smallest fix:** scale through `DrawingAreaUnits.MillimetresPerUnit`.

25. **The background downpipe detector matches layer words by "contains"**
    - **Where:** `Services/BackgroundDownpipeSymbolReader.cs:94-114`, `Services/XrefDownpipeDetectionService.cs:88`.
    - **What the drafter would see:** "DP" matches an architect's A-WALL-DPC layer, and "STORMWATER" matches any block on that layer. Pits and damp-course blocks would be offered ticked as downpipes. No command calls this code yet.
    - **Severity:** LOW. **SURE** (not reachable yet). **Smallest fix:** whole-word matching, and untick layer-only block matches by default.

26. **Wording and citations to confirm (Tim's call)**
    - **STORM "None":** `Rules/StormReportOffer.cs:154-156` says area with no treatment "goes straight out … only the part that reaches the tank is detained". In a STORM report "None" means no water-quality treatment; an untreated driveway may still drain to the detention system. The areas are not affected, only the note. **UNSURE.**
    - **Bayside reuse formula:** R-10 says a Bayside formula is known, but `COUNCIL_BAYSIDE_2026.md` states none and the profile entry is empty (`council-profiles.json:236`). Needs Tim's word. **UNSURE.**
    - **Downpipe coefficient comment:** `ViewModels/ChargedSystemCalcViewModel.cs:200` calls 0.82 "well-rounded pipe inlet"; 0.82 is usually quoted for a short square-edged tube (UNVERIFIED). The tab tooltip's "NCC H2P1" is UNVERIFIED. The value itself is known (BUG-547).
    - **Severity:** LOW.

---

## B. Settings page check (R-00), on 3.0.72

1. **No box on the Settings page** (grep of every XAML file, `AdvancedSettingsViewModel.cs` and `SettingsValueCatalog.cs` in all Modules, Manager included). Each of these is in the settings file only:
   - `PreDevWholeSiteC` 0.35
   - `PostDevSoftGroundC` 0.30
   - `Detention.HardGroundRunoffC` 0.9
   - `DefaultTcMinutes` 5
   - `DefaultPsdAriYears` 5
   - `ChargedMinHeadMm` 300
   - `WetWellReviewM3`
   - `BoydsUsesHardGroundC` (OFF, so the Boyd's tab counts roofs at 1.0)
   - `TankLibrary`

   Known: BUG-546. Still OPEN on this build.
2. **On the Settings page:** `WsudAreasHeldToSite` (`Dialogs/CivilSettingsView.xaml`), the raingarden setting (`CivilSettingsView.xaml:433`) and minimum cover.
3. **Still fixed in code, known:**
   - WSUD targets and the 630 mm rain (BUG-547 item 22)
   - Charged System 0.82 / 150 / 2.95 (BUG-547 item 23)
   - Boyd's fixed intensities (BUG-249)
   - Detention Design tab before-development C 0.30 (BUG-544 item 21)
   - Rational tab C 0.9 (BUG-544 item 26)
4. **Council values:** none editable anywhere (finding 15).

---

## C. Known bugs and open questions that matched (number only)

BUG-967 (Blue Factor garden and lawn; the fix is in 3.0.72 source, see D9), BUG-594, BUG-772, BUG-773, BUG-249, BUG-507, BUG-509 (looks fixed in source), BUG-515, BUG-538, BUG-539, BUG-544, BUG-546, BUG-547, BUG-596, BUG-597, BUG-1033, BUG-1057, BUG-1058, BUG-1059, BUG-1081, BUG-1083. Open questions: QUESTIONS_FOR_MONDAY H1 (IJK-18, WSUD series credit); OPEN_QUESTIONS C15 (Boroondara Tc 15) and C17 (Maribyrnong Tc 10 / tso 6: `tsoMinutes` is stored and read by nothing but the source viewer, as expected while C17 is open).

---

## D. Hand calculations that match the code

1. **Rainfall, office Melbourne curve, 1-in-5:**
   - 5 min: T = 0.0833 h, ln T = −2.48491, exponent 4.48643, I = **88.80 mm/h**. This matches `Rules/RainfallCurve.cs` and BUG-249's 88.8.
   - 15 min: exponent 4.00876, I = 55.08 mm/h.
   - 8 min: I = 73.63 mm/h.
   - 6 min: I = 82.85 mm/h.
2. **Rational Method** (`ViewModels/RationalMethodViewModel.cs:272`): Q (L/s) = C × I × A(ha) ÷ 0.36. For 0.9 × 55.08 × 0.05 ÷ 0.36 = 6.89 L/s. Correct form (Q in m³/s = CIA ÷ 360).
3. **Kingston PSD**, 600 m² site, C 0.4, 1-in-5, Tc 5: 0.4 × 88.80 × 0.06 ÷ 0.36 = **5.92 L/s**. CE leaves the Kingston PSD Unknown until it is typed (council-provided method, `Services/DetentionSizingService.cs:101-113`), which is the documented behaviour.
4. **CR-A1 two numbers**, 600 m² site, 400 hard / 200 soft: (400 × 0.9 + 200 × 0.30) ÷ 600 = **0.70**. CDDESIGN (`Services/AutoDesignService.cs:309-321`) and pump sizing agree. Before development: 0.35 office, 0.40 Kingston, Darebin and Maribyrnong (`DetentionSizingService.cs:277-287`). The Boyd's tab gives 0.767, because roofs count at 1.0 (known, BUG-539).
5. **Orifice, CR-A3**: PSD 4.27 L/s, head 0.428 m, Co 0.6. Area = 0.00427 ÷ (0.6 × √(2 × 9.8 × 0.428)) = 0.002457 m². d = 55.9 mm, adopted **55 mm** (rounded down, `Services/OrificeSizer.cs:116`). Then raised to the council minimum (`AutoDesignService.cs:559-567`).
6. **Casey formula K**: 1000 × √(4 ÷ (π × 0.6 × √(2 × 9.81)) ÷ 1000) = **21.89**, so K = 21.9 is the ordinary orifice equation with Co 0.6. Consistent.
7. **Boyd's sum** (`ViewModels/BoydsCalcViewModel.cs:247-252`), with 414 m² hard at 1.0 and 332 m² soft at 0.30: effective area 513.6 m². At 10 min: inflow 85.3 × 513.6 ÷ 3600 = 12.17 L/s; S = 12.17 × 600 − 7.9 × 600 = **2.56 m³**. This is the usual S = V(1 − PSD/Q) form. Not checked against the Kingston Boyd's spreadsheet itself.
8. **Manningham credit**: 0.25 × 10 × min(1, 300 ÷ 500) = **1.50 m³**, net 8.50 m³ (`Services/ReuseCreditService.cs:153-154`). The formula is right; it is simply never called (finding 2).
9. **Blue Factor, BUG-967**: 400 m² roof, 100 m² drive, 300 m² garden, 200 m² lawn, site 1,000 m². Roof and paved = **500 m²**; pervious = 1,000 − 500 = **500 m²** (`Rules/BlueFactorReport.cs:91-95`, `Rules/StormReport.cs:97`).
10. **Charged System** (`ViewModels/ChargedSystemCalcViewModel.cs:177-202`), the tab's starting values:
    - Flow: Q = 0.9 × 126 × 390 ÷ 3600 = **12.285 L/s**.
    - Hazen-Williams friction: 2.966 × 10⁻³ × 48.5 = 0.1439 m.
    - Minor loss: 2.95 × 0.6952² ÷ 19.62 = 0.0727 m.
    - Capacity: Qmax = 0.82 × 0.007854 × √(2 × 9.81 × 0.6235) × 1000 = **22.53 L/s**.

    These match the code and Codex's BUG-596 figures.
11. **One tank, two volumes (R-12)**: a 4,500 L tank with 1,500 L detention, 2,000 mm high. Working area 2.25 m². Reuse 3.0 m³, so the outlet sits 1.333 m above the base. Detention = 0.667 × 2.25 = **1.50 m³** (`WaterTankFacts.cs:46-72`).
12. **Council data** matches the CE_PLAN record for:
    - **Kingston:** 1-in-5 / C 0.4
    - **Glen Eira:** 1-in-10 / 50%
    - **Darebin:** 0.4 / 0.8 / Tc 10
    - **Manningham:** 40 / 25 mm
    - **Monash:** 65 mm / 60%
    - **Mornington:** 1-in-2 / 65 mm / 50%
    - **Whitehorse:** 90 mm, Assumed and warned
    - **Casey:** 50 mm
    - **Frankston:** 1-in-5 / 50% / 250 mm cover
    - **Maribyrnong:** 5 / 10 / 0.4 / 0.75 / 40 mm
    - **Banyule:** 100% / 40 mm
    - **Boroondara:** 100%
    - **Co:** 0.6 on all 22 profiles

    Note: the office minimum cover in code is 300 mm (Tim's 24 Sep COLLEAGUE-DEFAULTS-01). The rulebook's R-04 "450 mm" line is stale text, not a code fault.

---

## E. What I did NOT check

1. Nothing was run: no build, no tests, no AutoCAD. Every finding is from reading code and hand calculation.
2. The council PDFs and Blue Factor or STORM reports themselves. Council figures are compared with CE_PLAN's records only; every clause is UNVERIFIED.
3. Whether the office rainfall curve matches current Bureau of Meteorology data for any site (UNVERIFIED).
4. Raingarden sizing: no rule is documented in the rulebook, guidebook or code, so there was nothing to check. The 12 m downpipe spacing (Tim 5 Oct, INT-059) is not in the code; it is noted as not built, not as a bug.
5. Pump-station rules (R-14 to R-17, R-23) and detention TWL/orifice-head geometry (R-18): outside this brief except where they touch council values.
6. The Manager module's own screens beyond a name search; the CDCALC Pump System tab; the old `CalculationsDialog`.
7. Kingston's per-dwelling rule on multi-unit jobs; Casey's rule in detail; Boroondara Tc 15 (open C15).
8. Structural 1.0.122 beyond confirming it has no water-sensitive-design code.
9. Fix branches and PRs (for example #1687 "max-c-bluefactor"): only the installed release branches were read.

*Written by TEAM OPUS AUDIT T2 (Claude, Opus), 24 Oct 2026, with three Opus read-only sub-reviewers whose top claims were re-verified in the code before inclusion.*
