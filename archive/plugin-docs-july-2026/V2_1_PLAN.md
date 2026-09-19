# CE CVL Suite v2.1.0 — Plan

**Status:** Planning · **Created:** 2026-05-13 · **Updated:** 2026-05-14 · **Target ship:** TBD

## v2.1 in one paragraph

A "polish + grow" release. Fix the remaining v2.0 bugs, modernise CD and Pit dialogs to Tim's button pattern (driven by his markups, not a pre-built package), build the design-confirmed parking-lot features, add 8 new commands + entities, and migrate older drawings forward. Modern UI is shaped incrementally in this release — no Classic/Modern toggle, no wholesale rewrite.

## How to use this plan

- **One phase at a time.** Don't start the next phase until Tim has confirmed the current one works in AutoCAD.
- **Every phase ends with a deploy + test gate.** Build → deploy → Tim tests → Tim reports → next phase.
- **TDD for every code change.** Failing test → fix → confirm pass → commit.
- **One thing at a time inside a phase.** If a phase has sub-steps, finish each sub-step before starting the next. Resist the urge to bundle.

## Estimated effort

~15–18 working days across 10 phases. No single phase exceeds 5 days of focused work.

---

## Phase status snapshot (2026-05-15)

| Phase | Status | Notes |
|---|---|---|
| Phase 1 — Quick wins | ✅ Code complete | BUG-001 migrated to pure LSP (`C:\Lisp Files\Copy Rotate.lsp`, autoloaded via `ce_suite_startup.lsp`); PARK-034 layout rules implemented; PARK-014 + PARK-015 have diagnostic logs awaiting Tim's repro logs. |
| Phase 2 — CD dialog button conversion | ✅ Code complete | All 8 sub-items shipped; pipe-type mutual exclusion added; Above/Below pill `ContentPresenter` fixed twice. Awaiting confirmed end-to-end test. |
| Phase 3 — Pit dialog redesign | ✅ Code complete | Right column removed; Remarks+Notes merged; secondary controls converted to buttons; preset library + preview pane placeholders in place. |
| Phase 4 — Above/below MText + breakline | 🟡 In flight | PARK-033 + PARK-013 + PARK-032 dispatched 2026-05-15 (subagent in progress). PARK-032 multi-plan workflow incl. data-model extension. |
| Phase 5 — Insert-and-tag commands | 🟡 In flight | CDFW (in flight with block-fixes agent), CDSOURCE, CDSRZ, CDTPZ dispatched 2026-05-15. |
| Phase 6 — Source-linked commands | 🟡 In flight | CDAGI, CDLPD extension, trench grate extension dispatched 2026-05-15. CDWT shipped in earlier round. |
| Phase 7 — CDSTRIP + CDINSPECTOR sweep | ✅ Code complete | CDSTRIP shipped (layer name + filled arrow per segment + open polyline + inspector registration added by 2026-05-15 fix round). |
| Phase 8 — Pit copy identity | 🟡 In flight | ForkPit reactor work dispatched 2026-05-15. |
| Phase 9 — Old drawing migration | ❌ Deferred to v2.2 (2026-05-20) | Tim's decision: ship v2.1 without migration. Move PARK-031 scope into v2.2 plan. |
| Phase 10 — Release prep | ⏸ Next up after test queue clears | AC2022 smoke test, fusion bind log, csproj comment pass, version bump, changelog, installer build. |

**New / cross-cutting work landed this session (not in original plan):**

| Item | Status |
|---|---|
| BUG-017 UCS guard (`Services/UcsGuardService.cs`) — auto-swap UCS to World for CE commands | ✅ Built + working for CD; PIT diagnostic logs added; full audit found no static bugs |
| BUG-018 PIT BLOCK 2 rollout + `CDREFRESHBLOCKS` command | 🟡 EnsureBlockDefinition fixed twice; legacy-name short-circuit being patched in current round |
| Phase 7's CDINSPECTOR sweep extended to cover Strip Drain, Water Tank, Floor Waste, AGI, SRZ/TPZ entities | 🟡 In flight |
| CDPROPAGATE rewrite — preview/diff dialog, per-pit-drop preservation, IL 2dp format, flat-grade block, per-pipe override, downstream cascade (PARK-010), single undo group, WPF cascade prompt | 🟡 Round 1 shipped, refinement round in flight |
| `Copy Rotate.lsp` bundled inside CVL bundle's `Assets/Lisp/`; autoload via `ce_suite_startup.lsp` with 3-path fallback (Modern/Legacy/dev) | ✅ Working |
| STRUC Serilog 4.2 → 4.0.0 pin in `CE_STRUC_SUITE.csproj` | ✅ Pin in place; awaiting Tim's STRUC WIP to clear before next STRUC build |

---

## Phase 1 — Quick wins (1 day)

**Goal:** clear the backlog of "already coded / nearly there" items so the rest of v2.1 starts from a clean baseline.

1. **BUG-001** — `C` / `CR` / `MR` commands support pickfirst selection (objects can be selected BEFORE the command runs).
2. **PARK-014** — SPS invert text offset (add SPS radius to the clearance calc). Code-ready in the parking lot.
3. **PARK-015** — verify CD callout redesign in AutoCAD for **west placement only** (already built; narrow re-test).
4. **PARK-034** — confirm how PITSCHEDULE custom notes flow into the AutoCAD table (already working; Tim walks through it once and confirms the insertion path).

**Deploy + test gate.** Tim confirms each item; we move on.

---

## Phase 2 — CD dialog button conversion (2 days)

**Goal:** rebuild the CD dialog around Tim's button pattern (from the markup image). Also resolves BUG-014 / BUG-015 / BUG-016 because the new pattern replaces the radio+disabled-textbox combo that was misbehaving.

1. **GRADE section:** Default / From Inverts / Custom as three toggle buttons. Custom button has an inline textbox using the **same pattern as Charged Pipe's "Charged to"** field.
2. **Auto-calc:** toggle button with inline grade input visible when on.
3. **Flow basis:** By Flow / By Pick Order as two side-by-side buttons.
4. **Upstream / Downstream / Mask invert text / Show grade in Existing Pipe text:** buttons.
5. **Pipe text on/off, Insert Flow Arrow, Reverse Arrow, Pipe text layout (Auto / Inline / Callout):** all buttons.
6. **Simple Pipe with Arrow** → button. **Plus add a new Simple Pipe (no arrow)** button alongside.
7. **Right column polish:** Schedule / Batch + Quick Mode laid out cleaner.
8. **Verify BUG-014 / BUG-015 / BUG-016** with the new pattern. Typing into the Custom inline textbox should auto-engage Custom mode and accept `80`, `1:80`, `100 MIN.`, etc.

**Files:** `Dialogs/CdDialog.xaml`, `ViewModels/CdViewModel.cs`.

**Deploy + test gate.** Test sequence: type `80` → expect `1 IN 80`. Type `1:80` → expect `1 IN 80`. Type `1:100 MIN.` → expect `1 IN 100`. Auto-calc with two inverts → expect correct ratio. Round-trip via CDEDIT.

---

## Phase 3 — Pit dialog redesign (1 day)

**Goal:** Pit dialog matches Tim's 2-column markup.

1. Remove right column; redistribute the remaining content across 2 columns equally spaced.
2. Add **Preset / Quick Pick Library** card under Pit Basics.
3. Add **pit preview pane** at the bottom (mirrors CD dialog's pipe preview).
4. Convert Secondary Controls checkboxes (Add cover level text, Include in schedule, Plastic pit (PP), Show pit invert) to buttons.
5. Add a **Step-by-Step** section to the Pit dialog.
6. Add new button to **CDS** that opens the Step-by-Step (same pattern will extend to CD and CDCALC in v2.2).

**Files:** `Dialogs/PitDialog.xaml`, `ViewModels/PitViewModel.cs`, `Dialogs/AdvancedSettingsDialog.xaml`.

**Deploy + test gate.**

---

## Phase 4 — Above/below MText + breakline (2 days)

**Goal:** PARK-033 first, then PARK-032 (which depends on it), then PARK-013.

1. **PARK-033** — Pipe MText above/below toggle on CD and CDEDIT. Saved per pipe in `PipeLinkData`. Dual-side supplementary text (one side main, other side note). Flow-arrow placement dodges both text blocks. Default = above. New CDS setting "default pipe text position".
2. **PARK-032** — Rising main breakline (basement↔ground floor crossover). Two half-pipes linked logically; uses PARK-033's dual-side text for "CONT. FROM BASEMENT PLAN" continuation note.
3. **PARK-013** — Rising main: auto-detect destination, uphill arrow, grade skip in PITSCHEDULE.

**Files:** `Services/TextService.cs`, `Commands/CdCommand.cs`, `Commands/PipeEditCommand.cs`, `Models/PipeLinkData.cs`.

**Deploy + test gate.**

---

## Phase 5 — New commands batch 1 — insert-and-tag (2 days)

**Goal:** 4 new commands that are mostly "insert a block, tag it, register in schedule".

1. **CDFW** — single floor waste (uses `C:\Lisp Files\FLOOR WASTE.dwg`). Source ID assignment.
2. **CDSOURCE** — generic source block (uses `C:\Lisp Files\SOURCE.dwg`). User-assigned source ID.
3. **CDSRZ** — circle on `SRZ` layer (colour 233, HIDDEN linetype). No hatch.
4. **CDTPZ** — circle on `TPZ` layer (yellow, HIDDEN). Associative hatch on `HATCH 70` (colour 70, ANSI31, scale 100).

**Files (new):** `Commands/FloorWasteCommand.cs`, `Commands/SourceCommand.cs`, `Commands/SrzCommand.cs`, `Commands/TpzCommand.cs`. Update `command-registry.json` + `ce_toolbar_layout.json`. Stage FLOOR WASTE.dwg + SOURCE.dwg into `Installer/source_blocks/`.

**Deploy + test gate.**

---

## Phase 6 — New commands batch 2 — source-linked (3 days)

**Goal:** 4 source-linked commands integrating with the schedule.

1. **CDAGI** — polyline-as-source. AGI DRAIN layer (yellow, AG_LINE linetype). The polyline itself is the source entity — no separate block.
2. **CDWT** — water tank. Tags existing WT blocks already in user drawings. Prompts for total / detention / reuse litres. Two callout formats based on values:
   - Detention + reuse > 0: three-line callout (`WT1 — N lt WATER TANK / N lt FOR DETENTION / N lt TO BE USED FOR TOILET FLUSHING…`)
   - Reuse only: single-line callout
   - **Riser + Dropper as linked sub-blocks** under each WT umbrella — each tank gets one Riser + one Dropper, all three tagged `WT1`, CDINSPECTOR sees them as one logical entity.
3. **Trench grate callout extension** — extend existing `TRENCH GRATE` block with Tag / Width / Grate Class / Cover Level attributes. Two callout formats (ACO FlowTHRU / `TG1 - N WIDE TRENCH WITH CLASS X GRATE, CL ___.___`).
4. **CDLPD callout extension** — extend existing command. Connection-type picker (Kerb & Channel / Council Pipe / etc.). IL auto-pulled from the connected pipe end (infrastructure already there — just need the picker UI + callout text).

**Files (new):** `Commands/AgiCommand.cs`, `Commands/WaterTankCommand.cs`. **Extend:** `Commands/LpdCommand.cs`, the trench grate service. Stage DROPPER.dwg + RISER.dwg into `Installer/source_blocks/`.

**Deploy + test gate.**

---

## Phase 7 — CDSTRIP + CDINSPECTOR sweep (2 days)

**Goal:** the most complex new command, plus making sure every entity from phases 5 + 6 is first-class in the inspector.

1. **CDSTRIP** — strip drain. 100mm wide closed MLINE, top/bottom justification user-pick. Auto-places `FLOOR WASTE` blocks at every corner AND at maximum 12000mm centres along straight runs. External flow-direction arrow.
2. **CDINSPECTOR data-model sweep** — every new entity (Floor Waste, Source, SRZ, TPZ, AGI, Water Tank + Riser + Dropper, Trench Grate extension) becomes first-class in:
   - Inspector palette (appears when selected)
   - Inspector data sheet (shows tag, levels, source ID, parent WT, etc.)
   - Pit schedule linking (where applicable)

**Files (new):** `Commands/StripDrainCommand.cs`. **Update:** `Services/InspectorPaletteService.cs`, `Services/SourceTagService.cs`, `Services/PitScheduleBuilder.cs`.

**Deploy + test gate.**

---

## Phase 8 — Pit copy identity (1 day)

**Goal:** copying a pit in AutoCAD produces a NEW pit with its own identity. CDEDIT on the copy gives it a fresh label / cover / etc. independent of the original.

1. **Investigation:** what does AutoCAD's native COPY currently do with pit XData? Does the copy share an ID with the source?
2. **Fix:** if shared, fork the XData on copy reactor (new GUID, new pit slot in schedule).
3. **Test:** CDEDIT the copy → confirm it's independent (changing P1 to P2 with new cover level doesn't affect the original P1).

**Files:** Likely `Services/LinkService.Reactors.cs` (copy reactor), `Services/PitEntityService.cs`, `Commands/PitEditCommand.cs`.

**Deploy + test gate.**

---

## Phase 9 — Old drawing migration (PARK-031) — DEFERRED TO v2.2 (2026-05-20)

**Tim's call:** Ship v2.1 without migration. Old drawings aren't currently blocking
anyone, and Phase 9 is the largest unknown in the plan (needs real archive drawings
to even scope). Phase 9 work moves to v2.2.

Original scope below for reference when v2.2 planning begins.

---

### Original Phase 9 scope (deferred)

**Goal:** pre-Phase 2 drawings (made with the old LSP plugin or early v1.x versions) open and operate cleanly in v2.1.

1. **Investigation (Day 1):** Tim opens a sample of 3–5 old drawings. We catalogue what XData / attribute schemas they use. Identify mismatches vs the current Phase 2 schema.
2. **Strategy decision (Day 1 end):**
   - **Lazy migration:** on-open, scan and silently re-tag entities into the new schema.
   - **Eager migration:** new `CDMIGRATE` command Tim runs once per old drawing.
   - **Hybrid (recommended):** detect old schema on open, prompt once "Migrate this drawing? Yes / No / Don't ask again".
3. **Build migrator (Days 2–3):** map every old field to its new equivalent. Preserve user data. Log a per-drawing migration report.
4. **Test on real archive (Day 4):** Tim provides 3–5 real old drawings. Confirm pit schedule, pipe network, sources all round-trip cleanly.
5. **User-visible (Day 5):** status banner / log entry: "Drawing migrated from v1.x to v2.1 — N entities updated. See log for details."

**Files (new):** `Services/DrawingMigrationService.cs`, `Commands/MigrateCommand.cs`.

**Deploy + test gate.** Tim tests against his real archive.

---

## Phase 10 — Release prep (1 day)

**Goal:** ship-ready v2.1.0 EXE.

1. **AC2022 smoke test** — install on a real AC2022 machine. `CD` opens, places a pipe. **NO SHIP UNTIL THIS PASSES.**
   - *Also run the headless smoke harness* (`dotnet msbuild CE_CVL_SUITE/CE_CVL_SUITE.csproj /t:Smoke`, or `scripts\Run-Smoke.ps1`) on the dev machine — 5 scenarios cover CD/PIT/PITSCHEDULE/CDFALL. Known limitation: requires AutoCAD to be closed (cfg-mutex gate — see `docs/SMOKE_TEST_HARNESS_isolation_investigation.md`); parallel/AC-open execution is deferred to a future release.
2. **Fusion bind log capture** — enable on the test machine, restart AutoCAD. No new failed binds vs v2.0 baseline.
3. **csproj dependency-pin comments** — every strong-name NuGet (Serilog, AdWindows, etc.) gets a comment explaining why the version is pinned.
4. **Bump version:** 2.1.0.0 in csproj + assembly attributes.
5. **Update docs:**
   - `CHANGELOG.md` — full v2.1 entry
   - `REGRESSION_LOG.md` — close out the v2.1 session
   - `BUG_CARPARK.md` — sweep all closed items
   - `audit_report.md` — v2.1 closeout section
6. **Build EXE installer** via `Installer/build_installer.ps1`.
7. **Deploy to OneDrive** (`CE_CVL_SUITE_v2.1_Installer.exe`).
8. **Staff email** in plain English — what's new in v2.1.

**Deploy + test gate.** Tim signs off on the AC2022 smoke test before the EXE ships.

---

## Carryover from v2.0 — status summary

| Item | Status |
|---|---|
| BUG-002 TEXTEDIT/DDEDIT | FIXED 2026-05-13 ("works for now") — BUG-002 residual (10% edge case) still parked, needs repro |
| BUG-008 PITSCHEDULE row sort | FIXED 2026-05-13 |
| BUG-010 CDCALC crash on open | FIXED 2026-05-13 |
| BUG-011 west callout justify | FIXED (commit `25d3e005`) |
| BUG-012 CDFALL left-justify | FIXED (commit `4168238e`) |
| BUG-013 Serilog pin | FIXED (commit `e4546f6b`) — kept as documentation |
| BUG-014 grade parser | Coded — verify under Phase 2 button conversion |
| BUG-015 grade display | Coded — verify under Phase 2 button conversion |
| BUG-016 Custom textbox UX | Deferred → resolved by Phase 2 button conversion |
| PARK-010 invert propagation cascade | DONE — already working |
| PARK-011 grade/velocity popup | DONE 2026-05-08 |
| PARK-012 per-invert above/below toggle | DONE — Tim confirmed 2026-05-14 |
| PARK-CG CD grade warning | DONE 2026-05-08 |
| IMP-011 CDHELP fallback | FIXED |

---

## Process gates (no negotiation, every release)

1. **AC2022 smoke test.** Install on a real AC2022 machine, type `CD`, dialog opens. NO SHIP UNTIL THIS PASSES.
2. **Fusion bind log clean.** Enable Fusion logging, restart AutoCAD. No new failed binds vs v2.0 baseline.
3. **csproj dependency-pin comments.** Every NuGet PackageReference part of a strong-name chain gets a comment explaining why the version is pinned.
4. **Test suite green.** net48 ≥ 730/0/10, net10 ≥ 700/0/36 (current baseline + new tests).

---

## What's NOT in v2.1

- **CE Standard Orifice Pit Detail** → v3.0. See `V3_0_PLAN.md`.
- **BUG-003 / BUG-004** — already tagged for v3.0 in BUG_CARPARK.
- **Pre-built Modern UI package** — discarded. Tim is shaping the UI through markups; no Classic/Modern toggle, no dispatcher architecture, no bulk dialog replacement.

---

## Reference paths

| What | Where |
|---|---|
| Source | `C:\Lisp Files\CE_CVL_SUITE\` |
| CE_SHARED source | `C:\Lisp Files\CE_SHARED\` |
| Bug carpark | `C:\Lisp Files\BUG_CARPARK.md` |
| Regression log | `C:\Lisp Files\CE_CVL_SUITE\REGRESSION_LOG.md` |
| Parking lot | `C:\Lisp Files\CE_CVL_SUITE\docs\PARKING_LOT.md` |
| v3.0 plan | `C:\Lisp Files\CE_CVL_SUITE\docs\V3_0_PLAN.md` |
| New block files | `C:\Lisp Files\DROPPER.dwg`, `FLOOR WASTE.dwg`, `RISER.dwg`, `SOURCE.dwg` |
| Installer | `C:\Lisp Files\CE_CVL_SUITE\Installer\` |
| Staff distribution | `C:\Users\<user>\Creative Engineering\Creative Engineering - IT Admin\` |
| Last commit at planning | `fe521d72` (BUG-015) + uncommitted BUG-016 work in working tree |

---

End of plan.
