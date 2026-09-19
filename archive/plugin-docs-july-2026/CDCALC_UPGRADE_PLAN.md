# CDCALC Upgrade Plan — Council-smart calculations

**Status:** PLAN — awaiting Tim's approval. No code written yet.
Created 2026-06-09. Build is gated on confirming the current AutoCAD-pending items
(PL-072 discipline gate, R15/R15.2/R15.3 MOVE fixes) before deploy.

**Goal:** make CDCALC embody the CE Design Guidebook + the validated 1,900-job patterns — a council
picker that auto-loads the right rules, a quick "council provides PSD" path, a Soakage calculator, and
the Swinburne/OSD4W method. The council-profile catalogue built here is *also* the auto-design Phase-0
foundation (see `docs/AUTO_DESIGN_ROADMAP.md` §8) — built once, used twice.

---

## Build order (each shippable + AutoCAD-testable before the next)

| # | Feature | What you get | Effort |
|---|---|---|---|
| **1** | **Council picker + defaults** (FOUNDATION) | Pick a council → all tabs auto-fill its rules; remembered between sessions | M (2–3 d) |
| **2** | "Council provides PSD" quick mode | Type the council's PSD → stamps into detention + orifice, skips Boyd's | S (~1 d) |
| **3** | Soakage calculator (new tab) | Guidebook §6.5 soakage sizing + PASS/FAIL + PDF page | M (2–3 d) |
| **4** | Swinburne / OSD4W method (new tab) | The OSD4W method for Glen Eira/Darebin/Manningham/etc. | H (4–5 d) |

Council picker is first because features 2–4 all read from the selected council profile.

---

## The council-rule catalogue (shared brain)

- **Storage:** a bundled `CE_CVL_SUITE/Assets/Config/council-profiles.json` (15 councils), auto-deployed
  by the existing `Assets/Config/**` csproj copy rules — **no csproj change needed**.
- **Loader:** new `CouncilProfileService` copying the proven `CommandRegistryService` pattern
  (`Lazy<T>` singleton, lock, `RuntimePathService.GetPluginPath`, `JsonConvert` with empty-doc fallback).
- **Model:** `CouncilProfile` immutable record in `Models/CouncilProfileModels.cs`.
- **Last-selected council** persisted via one new `lastSelectedCouncilId` field on `UserSettings.OptionSettings`
  (backward-compatible; version stays 5.0).

Each profile holds: `psdMethod` (council-provided / boyds / swinburne), pre/post runoff coefficients,
PSD ARI (1:5 or 1:2), storage ARI (1:10), Tc rule, orifice Co, **orifice min** (Monash 65, Whitehorse 90,
Mornington 65), **% underground min** (Bayside 50, Monash 60…), reuse dispensation (Manningham formula,
Kingston 500/2000), standard drawings (D10A, SD999, MP244, STD015, DS8/DS14), submission/fees, notes &
hard warnings (Boroondara single-chamber + no-tanks-as-OSD; Banyule OSD if impervious ≥65%), and a
**`suburbs` list** for auto-detection (e.g. Bayside: Brighton, Sandringham, Hampton, Beaumaris, Black Rock…
— reuse the suburb→council map already built during the archive work). A new `CouncilDetector` parses the
project address to auto-select the council.

---

## Feature 1 — Council picker + per-council defaults (FOUNDATION)

**What you'll see in AutoCAD:** CDCALC opens and **auto-detects the council from the project address** —
it reads the suburb from the active drawing's folder name / Job Address (e.g. "Sandringham" → Bayside,
using the same suburb→council map proven on the 1,900-job archive) and pre-selects it. The **Council**
box across the top shows the detected council with a manual override dropdown. Selecting/confirming a
council fills the tabs with its numbers (runoff coefficients, ARI years, orifice settings) and shows a
notes line ("Min orifice 65 mm, ≥60% underground, std drawing D10A"). If no address is found it simply
waits for a manual pick. Remembers your last council between sessions.

**Council auto-detection:** add a `suburbs` list to each profile and a small `CouncilDetector` that reads
`Document.Name` (the DWG path) and/or the existing `JobAddress` field, extracts the suburb, and returns the
matching `CouncilProfile`. Graceful fallback chain: drawing folder → Job Address → manual dropdown. Manual
override always wins and is remembered.

- **Files:** NEW `Models/CouncilProfileModels.cs`, `Assets/Config/council-profiles.json`,
  `Services/CouncilProfileService.cs`; edit `Models/UserSettings.cs`,
  `ViewModels/CalculationsV2ViewModel.cs`, `Dialogs/CalculationsV2Dialog.xaml`.
- **Reuses:** `CommandRegistryService` loader pattern; the `Boyds.PropertyChanged → PushBoydsValueToSystems`
  observer wiring (becomes `SelectedCouncil → PushCouncilValuesToTabs`); existing ComboBox XAML pattern;
  `SettingsService.SaveSettings()`. No changes to the existing tab internals.
- **Unit tests:** loader loads 15 councils / GetById / missing-file→empty / JSON round-trip;
  `PushCouncilValuesToTabs(Kingston)` sets pervious C 0.3 + pre-dev 0.4; null council leaves tabs unchanged.
- **AutoCAD checklist:** dropdown lists 15 councils; Monash→65 mm + D10A note; Kingston→pre-dev C 0.4;
  Glen Eira→flags Swinburne; Boroondara→single-chamber warning; reopen remembers council; manual edits not
  wiped until you switch council; missing JSON → empty list, no crash.
- **Risks:** overwrite of typed values (open question); XAML row insertion shifting tabs; empty-list handling.

## Feature 2 — "Council provides PSD" quick mode

**What you'll see:** for councils that email you a PSD (Bayside, Kingston, Monash, Boroondara) a small
"Council provides PSD" box appears — type the L/s value, click apply, and the Detention PSD + orifice fill
in immediately, skipping Boyd's/Swinburne. Hidden for method-calc councils.

- **Files:** `ViewModels/CalculationsV2ViewModel.cs`, `Dialogs/CalculationsV2Dialog.xaml`.
- **Reuses:** `DetentionSystemViewModel.Psd` stamp target; existing orifice formula; Phase-1 push;
  Boolean→Visibility converter.
- **Tests:** visible only when council-provided; apply sets PSD; non-numeric → warning, no change.
- **Effort:** Low (~1 d). Thin layer on Phase 1, no new engine.

## Feature 3 — Soakage / infiltration calculator (new tab)

**What you'll see:** a new **Soakage** tab. Enter catchment area, soil soakage rate (Kh from geotech),
unit type (single/double Atlantis), pit size → a duration table shows whether the soakaway copes, the
emptying time, and a clear PASS/FAIL with the worst-case duration. Tick to include in the PDF.

- **Files:** NEW `ViewModels/SoakageCalcViewModel.cs`; edit `CalculationsV2ViewModel.cs`,
  `CalculationsV2Dialog.xaml`.
- **Reuses:** `BoydsCalcViewModel` structure (string inputs, `SetProperty(…,Recalculate)`, StormRow
  collection, `CalculationBaseViewModel` warnings); Rational IFD lookup; `BuildDetentionPage`/`ExportDetention`
  PDF pattern.
- **Tests (pure math → TDD):** guidebook Fig 17 example (801 m², K 100, MF 0.45 → emptying 6.39 h,
  infiltration area 33.54 m², perimeter 23.49 m); moderating factor; critical-duration sweep; all-pass→PASS;
  one-fail reports duration; Kh<100 warning; circular geometry.
- **Risks:** IFD curve needs durations to 10080 min (open question); moderating factor list; emptying-time formula.
- **Effort:** Medium (2–3 d). Self-contained, ideal TDD.

## Feature 4 — Swinburne / OSD4W method (new tab)

**What you'll see:** a new **Swinburne** tab for OSD4W councils (Glen Eira, Darebin, Banyule, Manningham,
Maroondah, Mornington). Enter impervious/pervious areas, the council coefficients, and the two times of
concentration (Tc to outlet, Tso to site — defaults Tc 10/Tso 5) → required storage (m³), critical duration,
and a hydrograph table. Picking the council pre-fills these. Tick to include in the PDF.

- **Files:** NEW `ViewModels/SwinburneCalcViewModel.cs`, NEW `Services/Hydraulics.cs` (shared orifice/rational
  helpers, AutoCAD-free); edit `CalculationsV2ViewModel.cs`, `CalculationsV2Dialog.xaml`, and refactor
  `DetentionSystemViewModel.cs` + `DetentionDesignViewModel.cs` to call `Hydraulics` for Qo (DRY).
- **Reuses:** `BoydsCalcViewModel` template; Rational IFD interpolation; `CalculationBaseViewModel` warnings;
  PDF/export patterns; Phase-1 council push.
- **Tests:** rational Q=C·I·A/0.36; pre-dev Qp at Tc; post-dev Qa interpolated at ⅓ Tcs; storm sweep finds
  max storage + critical duration; Tc≥Tso validation; `Hydraulics.ComputeQo` locked + **matches legacy
  DetentionSystem result (regression guard)**.
- **Risks:** orifice refactor touches live detention sizing (mandatory regression test); Swinburne PSD source
  + Qa-at-⅓-Tcs rule need Tim's sign-off; IFD coverage.
- **Effort:** High (4–5 d).

**Cross-cutting (during 3/4):** extract the orifice formula `Qo = Co·A·√(2gh)` (currently duplicated in
`DetentionSystemViewModel` ~618–631 and `DetentionDesignViewModel` ~227–235) into the shared `Hydraulics`
class — one tested formula instead of three drifting copies.

---

## Open questions for Tim (decide before/with each phase)

**Phase-1 decisions — RESOLVED (Tim, 2026-06-09):**
1. ✅ Switching council **only fills blanks** — never overwrites a value Tim typed by hand.
2. ✅ Council is **auto-detected from the project address** (suburb→council), shown in the picker with a
   manual override; CDCALC-only for now (can extend to the CD/PIT path later).
3. ✅ **Print the chosen council + key parameters on the PDF calc cover page.**

**Greenlight:** plan approved — **build Phase 1 when the AutoCAD-pending items (PL-072, R15/R15.2/R15.3)
are confirmed tested.** Then dispatch the coding with unit tests + REGRESSION_LOG per the project discipline.

**Affect later phases (decide at Phase 2/3/4):**
4. PSD precedence: council default vs manual quick-mode value; clear manual PSD on council switch?
5. Swinburne PSD source: enter council PSD, or compute from Qp — by what formula?
6. IFD/rainfall data: extend the bundled Melbourne table (only goes to 1440 min / 1:100), add per-council
   IFD blocks in the JSON, or let the user type intensities? (Blocks full correctness of Soakage + Swinburne.)
7. Moderating-factor list: fixed Atlantis dropdown vs free-entry field for other devices.
8. Glen Eira/Banyule special pre-dev rules: enforce in logic, or show as warning text?
9. Council catalogue ownership: hand-edited JSON by Tim, or a small editor UI later?
10. Hydraulics orifice refactor now (DRY, one tested formula, touches live detention) or defer?
