# CE drainage vs Civil 3D 2027: side by side (10 Oct 2026)

**Why.** Tim, 10 Oct 2026: *"compare and also decomp"*. Research only; every item below is an IDEA for Tim's
command review, not a ruling, and nothing here changes the plugin. Engineering choices are Tim's.

**Sources.** CE: installed Civil 3.0.44 (`origin/claude/rel-20261009o`, b7eed253), read-only inventory with file
references (helper agent; key "not found" claims re-checked by hand: no HGL, clogging, weir calculation,
stage-storage, pit/junction loss, Bransby-Williams or Kirpich anywhere in `Modules/Drainage`). Civil 3D: official
`Civil3D.NET` 13.9.628 decompiled read-only (`C:\Tools\AcadDecomp\C3D2027\`), first look in
`CIVIL3D_API_FIRST_LOOK_2026-10-10.md`. Civil 3D's design-rule maths (cover/slope, drops) is native and not readable.

## 1. Both have it (CE already covers)

1. Pipe inverts, diameter, material, grade from inverts, flow direction (CE: `PipeData`, `FlowMode`; C3D: `Pipe`).
2. Manning's n by material (CE: Settings table + council override; C3D: per pipe).
3. Minimum cover check (CE R-04, cover to obvert; C3D min/max cover per pipe).
4. Rational method with catchment area and C (CE `RationalFlowService`; C3D `RunoffMethod.Rational`).
5. Time of concentration as an entered value (CE council/Settings default 5 min; C3D user-defined option).
6. Orifice outlet with discharge coefficient (CE `Hydraulics.OrificeFlowLps`, Co 0.6; C3D orifice flow control, Cd).

## 2. CE has it, Civil 3D does not (CE's strengths: keep)

1. Victorian council matrix: 22 councils with sourced/assumed provenance, PSD and storage ARI by site case.
2. OSD sizing: Boyd's storage sweep, PSD by council/Boyd's/Swinburne, SSR with critical duration.
3. Detention top-water-level solver across pipes, pits and tanks with freeboard and surcharge warning.
4. Tank library, soakage (Atlantis) sizing, pump/rising main (AS 3500.3), charged downpipe systems.
5. Melbourne IFD curve plus per-job rainfall curve; AS/NZS 3500.3 minimum grades; grated-pit catchment
   warnings by grate class; step-iron depth; pit drop rule.

## 3. Civil 3D has it, CE does not (the gap list to pick from)

Ranked by how often it would matter on a Melbourne residential / small commercial job (my ranking, for Tim to
correct):

1. **Hydraulic grade line through the network** (C3D: HGL/EGL at both ends of every pipe and at every pit, entry,
   exit, junction losses). Real job: shows whether a pit surcharges in the major storm before council asks.
2. **Pit inlet capacity** (C3D: grate length/width/type, kerb-opening length/height, throat angle, gutter width,
   cross and longitudinal slope, gutter Manning's n, **clogging factor**, **bypass to which pit**). CE today only
   warns on paved area per grate class. Real job: a sag grate on a driveway taking more flow than it can.
3. **Flow added up down the network** (C3D: known flow per part; CE: typed or per-calculation flow; automatic
   accumulation not found by search). Real job: the last pipe before the legal point of discharge sized from the
   sum of everything upstream without retyping.
4. **OSD outlet options beyond an orifice**: weir (crest level, width, Cd) and a stage-storage / stage-discharge
   table (C3D `Pond`, `StageStorageCollection`, `OutletDetailFlowControlWeir`). Real job: council asking for an
   overflow weir check or a stage-storage table in the OSD report.
5. **Calculated time of concentration** from flow path segments (C3D: sheet / shallow / channel flow; US methods
   TR-55, FAA, Kirpich). CE would want the Australian equivalents (e.g. kinematic wave, Friend's), not the US ones.
6. **ARR 2019 language**: AEP and initial/continuing losses (C3D has initial abstraction depth/fraction). CE stores
   ARI and an ARR-1987-style IFD approximation.
7. **Live maximum cover and pit spacing checks** (C3D rule sets; CE: max cover exists only in sizing, no CDRULES
   check; no pit-spacing setting found).
8. **Open channel / swale hydraulics** (C3D `Channel`, rectangular/trapezoidal/triangular sections).
9. **Clash check between pipes and other services** (C3D `InterferenceCheck`).

## 4. Not worth copying

Civil 3D's runoff models aimed at US practice (SCS curve number, Santa Barbara hydrograph, SWMM infiltration
methods) and its pressure-pipe network (water mains) are outside CE's drainage scope unless Tim says otherwise.
