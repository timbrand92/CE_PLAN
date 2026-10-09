# Civil 3D 2027 API: first look (10 Oct 2026, decompile chat)

**Why.** Tim, 10 Oct 2026: *"Civil 3D yes"*, then *"Download it, dont worry about license"* (read as: work from
Autodesk's published package now; no full Civil 3D install for the moment). Research only; any build goes to the
desk. Plain AutoCAD must keep working (D9; L3 plan: a Civil 3D adapter is optional future work).

**Source.** NuGet `Civil3D.NET` 13.9.628 ("Civil 3D 2027 .Net API"), owner account "Autodesk", 3.5 MB.
`dotnet nuget verify`: author signature `CN="Autodesk, Inc."`, timestamped 3 Apr 2026 (DigiCert), repository
countersignature NuGet.org: **Successfully verified**. Package at `C:\Tools\AcadSdkC3D2027\`, decompiled read-only to
`C:\Tools\AcadDecomp\C3D2027\` (never into a repo). **Not stripped:** full managed wrapper code plus Autodesk's XML
comments, same depth as the AutoCAD wrappers (bodies call into native Civil 3D, which is not readable).

Assemblies: `AeccDbMgd` (3,604 files: pipe networks, surfaces, alignments, profiles, parts), `AeccDrainageDesignMgd`
(311), `AeccPressurePipesMgd` (428), `AecBaseMgd`, `AeccDataShortcutMgd`, `AecPropDataMgd`.

## What maps onto CE

1. **Gravity pipe (`Autodesk.Civil.DatabaseServices.Pipe`):** Manning coefficient, entry / exit / junction / average
   loss, return period, flow rate, HGL and EGL at both ends, cover at both ends, min/max cover, slope, inner/outer
   diameter or width, cross-section shape, flow direction method, start/end structure links.
2. **Pit (`Structure`):** rim, sump depth and elevation, pipe invert/centre/top depths, connected pipes, structure
   type, known capacity, HGL/EGL, catchment area / runoff coefficient / time of concentration, and full **inlet
   capacity inputs**: grate length/width/type, kerb-opening height/length, throat angle, local depression, gutter
   width, cross slope and Manning's n, road cross slope, longitudinal slope, clogging, and **bypass target** (where
   bypass flow goes).
3. **Detention (`AeccDrainageDesignMgd`):** `Pond` with contours and stage-storage (`StageStorageCollection`,
   `PondStageStorageCalculationMethod`), `UndergroundStorage`, `StormWaterControl` (infiltration, perimeter,
   velocity types), `OutletDetail` with flow control **orifice** (invert, diameter, Cd), **weir** (crest, width, Cd),
   free discharge; `InletDetail` (capacity type, destination); `OutfallDetail`; `Channel` with rectangular,
   trapezoidal, triangular and custom sections and longitudinal slope.

## Ideas for CE (for Tim's command review, not rulings)

1. **Compare CE's drainage rules with Autodesk's model**: CE already holds Victorian council values and its own
   pit/pipe/OSD rules (Settings-first). Civil 3D's field list is a ready checklist of what a pipe, pit or OSD
   "should know" (e.g. bypass target, clogging factor, junction loss, HGL at both ends) to spot gaps in CE.
2. **Optional CE ↔ Civil 3D adapter** (Level 3, only when CE runs inside Civil 3D): export a CE network to a Civil 3D
   pipe network (`Network.AddLinePipe` / structures, then `ConnectToStructure`), and read Civil 3D surfaces for
   cover. Needs a Civil 3D install to test; plain AutoCAD unaffected.
3. **OSD**: Civil 3D's pond / outlet / stage-storage objects are a reference for CE's detention tank outputs
   (orifice and weir with discharge coefficients, stage-storage table).

Not done: no Civil 3D install, nothing run inside Civil 3D, no comparison against CE's actual rule set yet.
