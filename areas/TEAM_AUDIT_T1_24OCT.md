# Team Opus audit T1 — Civil hydraulics correctness, Sat 24 Oct 2026

Read-only audit. Code read: `origin/claude/rel-20261023m` at `f7f7d551` (installed Civil 3.0.72 / Manager 1.1.72), in a
detached worktree `C:\ce-ta\t1m`. No build, no test run, no AutoCAD, no code or settings changed. Structural
(`rel-20261023s`) was not needed: it holds no drainage hydraulics.

## ANSWER FIRST

1. **Counts:** 7 new findings: 1 HIGH, 3 MEDIUM, 3 LOW. No new unit mix-up found. 14 hydraulics bugs already
   known, listed by number only (section "Already known").
2. **The core formulas are right.** Manning full-bore, the orifice equation, Hazen-Williams for charged lines,
   the rational method and the minor-loss term all match my own working to within 0.3 per cent on every pipe I
   checked. Seven pipes are worked by hand below.
3. **Top 3:**
   1. **HIGH: the automatic sizer picks the smallest pipe that works at ANY grade, up to 6 m/s.** CDDESIGN's
      connection pipe for 40 L/s comes out DN100 at about 1 in 3, where DN225 at 1 in 200 does the job. Network
      redesign and auto-design use the same sizer.
   2. **MEDIUM: CDCALC Pipe Flows warns at its own 0.5 and 3.0 m/s.** It ignores the Settings 0.6 m/s minimum and
      the per-material speed limits. So CDCALC and CDRULES give opposite answers on the same pipe.
   3. **MEDIUM: CE never works out a hydraulic grade line (HGL) or pit losses, and no screen says so.** Frankston,
      Banyule and Whitehorse ask for an HGL (recorded in `02_COUNCIL_RULES/COUNCIL_RULES_V3_INTEGRATION.md` G). The
      gap is known. What is new: nothing tells the drafter "HGL not checked".

---

## Hand calculations (my own working, then what the code gives)

Formula used: V = (1/n) × R^(2/3) × S^(1/2), with R = D/4 for a pipe flowing full and Q = V × A. D is the nominal
size, as the code uses it. n comes from the Settings table: UPVC 0.010, concrete (RCP) 0.013.

1. **DN375 concrete at 1 per cent (1 in 100):** A 0.1104 m², R 0.0938 m, **V 1.59 m/s, Q 175 L/s.** Code: same
   formula, same numbers (CDRULES, Edit Pipe, CDCALC Pipe Flows with n 0.013). Difference 0.0 per cent.
2. **DN600 concrete at 0.5 per cent (1 in 200):** A 0.2827 m², R 0.150 m, **V 1.54 m/s, Q 434 L/s.** Code the same.
3. **DN225 UPVC at 2 per cent (1 in 50):** A 0.0398 m², R 0.0563 m, **V 2.08 m/s, Q 82.6 L/s.** Code the same in
   CDRULES and Edit Pipe. **But the Inspector palette shows 1.60 m/s** (it uses n 0.013 for every material).
   That is 23 per cent low. Known, and done on purpose (PR #642); same family as BUG-542.
4. **DN150 UPVC at 1 in 100:** **V 1.12 m/s, Q 19.8 L/s.** Code the same. Inspector shows 0.86 m/s (same cause
   as item 3).
5. **DN450 concrete at 1 in 300:** **V 1.04 m/s, Q 165 L/s.** Code the same.
6. **DN900 concrete at 0.3 per cent:** **V 1.56 m/s, Q 992 L/s.** Code the same.
7. **DN300 UPVC at 1 in 250:** **V 1.13 m/s, Q 79.5 L/s.** Code the same. CDRUNSOLVE would treat a concrete DN300
   the same way (UPVC n). That is BUG-868, about 23 per cent over-stated on concrete.
8. **Orifice, 57 mm under 0.428 m head, Co 0.6:** A 0.002552 m², √(2 × 9.8 × 0.428) = 2.896 m/s, **Q 4.43 L/s.**
   `Services/Hydraulics.cs:53-64` gives the same.
9. **Charged line, CDCALC starting values** (C 0.9, 126 mm/h, 390 m², DN150, 48.5 m, Hazen-Williams C 150, K 2.95):
   Q = 0.9 × 126 × 390 / 3600 = **12.29 L/s**. Friction = 10.67 × Q^1.852 / (C^1.852 × D^4.87) × L = **0.1435 m**.
   Minor = 2.95 × 0.695² / (2 × 9.81) = **0.0727 m**. Codex saw 0.1438 and 0.0727 on screen (carpark line
   about 10817). Difference 0.2 per cent, which is my rounding.
10. **Manning against Colebrook-White (for information; CE has no Colebrook code):** with ks 0.6 mm for concrete
    and 0.015 mm for UPVC (both typical values, **UNVERIFIED**), Manning gives 9 to 18 per cent LESS capacity on
    all seven pipes. That is the safe side, so no change is needed. Example: DN225 UPVC at 1 in 50 gives Manning
    82.6 L/s against Colebrook 100.5 L/s.

**Result:** between my working and the code, no difference above 2 per cent on any formula. The differences above
2 per cent are between screens (items 3, 4, 7), and all of those are already known.

---

## New findings, ranked

1. **HIGH — SURE (read end to end, and worked by hand) — the automatic sizer chooses the smallest pipe at any
   grade, up to 1 in 1.**
   - **Where:** `Modules/Drainage/Services/PipeSizingSolver.cs:168-186` (the sizes are tried smallest first and
     the first one that works is returned). The comment at `:136` says "prioritizes the shallowest grade", but
     that holds only within one size. `:131` lets a grade go as steep as 1 in 1. Nothing limits steepness, only
     the speed limit, which is 6 m/s here (`Services/SettingsSizingStandards.cs:67-74`, `PipeSizingStandards.CreateDefault`).
   - **Who uses it:** CDDESIGN's connection pipe (`Services/AutoDesignService.cs:656-680`); network redesign,
     CDRUNSOLVE and auto-design (`Services/NetworkDesignService.cs:290`, via `NetworkRedesignSolverService.cs:23`
     and `AutoDesignOrchestrator.cs:212`).
   - **What the drafter would see (UPVC, my run of the same logic):**
     - 10 L/s: **DN100 at 1 in 45**. DN150 at 1 in 100 would carry 19.8 L/s.
     - 25 L/s: **DN100 at 1 in 7**. DN225 at 1 in 200 carries 41.3 L/s.
     - 40 L/s: **DN100 at 1 in 2.8** (5.1 m/s). DN225 at 1 in 200 carries 41.3 L/s.
     - 100 L/s: **DN150 at 1 in 3.9**. DN375 at 1 in 300 carries 132 L/s.
   - **On a real job:** in a network redesign preview, a 30 m pipe proposed at 1 in 3.9 falls 7.7 m. The pits
     below would be metres deep, and a council connection could not be reached. The preview offers this as a
     feasible design.
   - **Why it does not show today in CDRUNSOLVE:** that command feeds no flow (BUG-999), so every pipe falls back
     to DN100 at 1 in 100. Once real flows are fed in, this sizer behaviour will show there too.
   - **Smallest fix:** this needs Tim's ruling on the preferred design grade. Then, in `TrySize`, take the smallest
     size that works at or flatter than that grade (for example, the size's own ladder minimum, or a Settings value
     "steepest grade the sizer may propose"). Only go steeper when no size on the ladder works.

2. **MEDIUM — SURE (read) — CDCALC Pipe Flows warns at its own fixed 0.5 and 3.0 m/s.**
   - **Where:** `Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs:268-271`. Settings holds the minimum
     (`minimumVelocityMs` 0.6) and the material caps (UPVC 3, concrete 6, `scourVelocityByMaterial`). CDRULES and
     Edit Pipe read those; Pipe Flows does not.
   - **What the drafter would see:**
     - DN300 concrete at 1 in 600 runs at 0.56 m/s. CDCALC shows no warning, but CDRULES warns "below 0.6 m/s".
     - DN375 concrete at 1 in 20 runs at 3.55 m/s. CDCALC says "Velocity is high; check for scour risk", but
       CDRULES passes it (concrete cap 6 m/s).
   - **Not the same as BUG-1036** (that one is the roughness note on the same tab) and not R00 item 25 (the
     starting roughness).
   - **Smallest fix:** compare against `DesignStandards.MinimumVelocityMs` and
     `RulebookValues.ScourVelocityFor(material)`. When no material is known, use `MaximumPipeVelocity`.

3. **MEDIUM — SURE (searched the whole Civil module) — no HGL or pit losses anywhere, and no line saying so.**
   - **Where:** there is no HGL, energy-line, pit-loss (K) or surcharge-routing code in `Modules/Drainage` (searched
     for HGL, hydraulic grade, headloss, pressure change, surcharge). Every pipe is checked full-bore on its own
     grade only.
   - **On a real job:** on a Frankston job, the long section and the computations sheet show pipes passing. Nothing
     says the HGL was not checked, so a reviewer could take the sheet as a complete hydraulic check. That breaks
     R-27 ("say Unknown").
   - **Already recorded as a missing feature:** `04_REFERENCE/CE_VS_CIVIL3D_DRAINAGE_COMPARE_2026-10-10.md` item 1
     and `02_COUNCIL_RULES/COUNCIL_RULES_V3_INTEGRATION.md` section G. The new part is the missing "not checked"
     line.
   - **Smallest fix:** add one Unknown row to CDRULES and to the computations sheet: "Hydraulic grade line and
     pit losses: not calculated by CE". Make it a Warn when the job's council profile asks for an HGL.

4. **MEDIUM — SURE (read) — CDDESIGN, network redesign and auto-design drop the minimum grade for DN450 and up.**
   - **Where:** `Modules/Drainage/Services/SettingsSizingStandards.cs:72` keeps the Settings grade ladder only for
     `StandardGradeSizesMm` (DN90 to DN375, `:13-14`). Settings holds 1 in 200 for DN450 to DN750
     (`Models/UserSettings.cs`, `minGradeByDiameter`), and Edit Pipe uses it. The comment at
     `Models/PipeSizingModels.cs:38-39` says sizes not listed "fall back to the office rule", but no fallback exists.
   - **On a real job:** network redesign with "preserve existing sizes" (`NetworkDesignService.PreserveExistingSizes.cs:114-127`)
     on an existing DN450 carrying 30 L/s. The flow needs only 0.19 m/s, so the 0.6 m/s minimum decides the
     grade: **1 in 1,509** with UPVC n (1 in 893 with concrete n). Edit Pipe would say 1 in 200.
   - **Partly known:** the code comment lists it as a "disagreement for Tim", and `AUDIT_ENGINEERING_CIVIL_2026-10-22.md`
     item 25 covers the exact-size lookup. I found no BUG number, and that audit does not give this consequence.
   - **Smallest fix:** after Tim's ruling on the ladder (that audit's question 5), pass the whole Settings ladder
     (`GradeLadder(office, null)`, as `ForMaterial` already does).

5. **LOW — SURE (read) — a pipe running up to 5 mm uphill is reported as "essentially flat", not "flows uphill".**
   - **Where:** `Modules/Drainage/Services/DesignValidationService.cs:296-317` (`ReverseFallToleranceMm` 5 is
     applied on both sides of level).
   - **On a real job:** a 1 m pipe whose downstream end is 4 mm higher (an adverse grade of 1 in 250) gets an
     amber "Pipe is essentially flat — no measurable fall". The red "Pipe flows uphill" error never shows. The other
     way round, a 2 m pipe with a real 4 mm fall (1 in 500) is told it has "no measurable fall".
   - **Smallest fix:** any negative fall gives the uphill error. Keep the tolerance only for the "flat" wording.

6. **LOW — SURE (read) — CDRUNSOLVE and network redesign skip the cover check when a pit lid is exactly RL 0.000.**
   - **Where:** `Modules/Drainage/Services/NetworkDesignService.cs:387` and `:399` (`CoverLevelM != 0.0`);
     `NetworkRedesignSolverService.OutputValidation.cs:84`.
   - **On a real job:** rare. A coastal or low-lying site on AHD with a lid at RL 0.000 gets no cover finding, and
     a lid at RL 0.001 does. This is the same "zero means unknown" family as BUG-1019, in a different file.
   - **Smallest fix:** carry "cover known" as its own yes/no, as `PipeSizingSolver.IsLevel` already does.

7. **LOW — UNSURE (the intent is not recorded) — the Inspector shows a pipe up to 20 per cent flatter than the
   minimum as amber, not red.**
   - **Where:** `Modules/Drainage/Services/InspectorPaletteService.cs:3293-3302` (`warningThreshold = minGradeDenom * 1.2`).
   - **On a real job:** against 1 in 200, a pipe at 1 in 235 fails the minimum but shows amber "⚠". Only 1 in 241
     and flatter shows red "✗". CDRULES warns on both.
   - **Smallest fix:** red for anything flatter than the minimum. If Tim wants a "near the limit" band, make amber
     the band just steeper than the minimum. Needs Tim's word on what amber is meant to mean.

---

## Already known (BUG numbers only)

1. **BUG-868:** every pipe is treated as UPVC in CDRUNSOLVE, network redesign and proposals.
2. **BUG-999:** CDRUNSOLVE feeds no flow.
3. **BUG-964:** network redesign pit levels.
4. **BUG-542:** the long section's own roughness list.
5. **BUG-543:** orifice 0.6 / 0.61 and gravity 9.8 / 9.81.
6. **BUG-544:** Settings values ignored.
7. **BUG-1036:** the Pipe Flows roughness note.
8. **BUG-980:** Pipe Flows second pick.
9. **BUG-903:** different minimum grades per screen.
10. **BUG-907:** pit drop is checked invert to invert only.
11. **BUG-806:** orifice mapper head and rounding.
12. **BUG-1057:** council velocity limits.
13. **BUG-1059:** Maroondah DN150 grade.
14. **BUG-825:** maximum velocity reset to 6.0.

**Listed in `AUDIT_ENGINEERING_CIVIL_2026-10-22.md` with no BUG number found:**

1. **Item 17:** nominal size used, not the bore.
2. **Item 18:** CDTWL orifice head.
3. **Item 19:** Casey banker's rounding.
4. **Item 25:** grade ladder lookup.
5. **Item 26:** 600 mm cover default.
6. **Item 28:** the self-cleansing check uses full-bore speed.

---

## What I did NOT check

1. **AutoCAD:** I opened nothing and ran nothing. Every finding is from reading the code and working by hand. No
   window was looked at.
2. **No build or test run.** Finding 1 is proven by reading the code path and running the same arithmetic in a
   shell script, not by running the solver itself.
3. **Standards:** no AS/NZS 3500.3 or ARR clause was checked against its text. The ladder values, the speed caps
   and the Colebrook ks values above are **UNVERIFIED**.
4. **Pipe bores:** not checked against real catalogues (AUDIT item 17 covers this).
5. **Boyd's storage, rational-method areas and Tc, and the pump tab:** spot-read for units only. The 22 Oct audit
   verified them.
6. **Metre-drawing length handling** (the BUG-330/1052/1055 family): not traced again.
7. **Structural branch `rel-20261023s`:** not read; it has no drainage hydraulics.
8. **The orifice head between screens:** CDCALC's Detention tab measures head to the orifice centre
   (`DetentionSystemViewModel.cs:1063`), but CDDESIGN uses the typed head as it is. On a 60 mm orifice under
   450 mm this gives 1 mm (about 1.7 per cent), which is below the 2 per cent threshold, so it is not reported.

## Summary

The Civil hydraulic formulas are correct. Manning, orifice, Hazen-Williams and rational all match my hand
calculations within 0.3 per cent on seven pipes, an orifice and a charged line. The serious problem is choice,
not arithmetic. The automatic sizer always takes the smallest pipe and lets the grade run steep, so CDDESIGN and
network redesign can propose DN100 at 1 in 3 for 40 L/s. CDCALC Pipe Flows also uses its own speed limits, and no
screen admits that the HGL and pit losses are not checked. Seven new findings; fourteen known.
