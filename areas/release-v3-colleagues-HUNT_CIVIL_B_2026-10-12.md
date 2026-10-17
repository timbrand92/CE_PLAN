# HUNT — Civil B: survey, surfaces, levels and imports (read-only code audit)

**Run:** 18 Oct 2026 (Melbourne), headless Team usage-governor job, desk plan/03. File name carries the job's date (12 Oct) as briefed.
**Code audited:** the installed Civil lineage only, `origin/claude/rel-20261018b` @ `b06126db` ("Version: Civil 3.0.53 / Manager 1.1.53 (C-42)"), in a private read-only worktree `C:\ce-hunt\civilB` (removed at the end). Not master.
**Method:** five parallel read-only auditors, one per slice (survey intake; spot levels and surfaces; LandXML and import compare; X-Civil import; source tags). Every finding was checked against `BUG_CARPARK.md` (to BUG-651), the HUNT, HUNT2, HUNT3, HUNT_CIVIL_E, R00_CIVIL and AUDIT_01 files. The controller re-read the key lines of every HIGH below in the 3.0.53 tree.
**Status words:** nothing here is built, tested, installed or Tim-accepted. None of it has been seen in AutoCAD. No BUG numbers filed; the controller does that.
**Left out because already known:** BUG-505 (import units), BUG-512 (LandXML invented sizes), BUG-513 (sump as IL), BUG-516 (LandXML size units), BUG-602 to BUG-607 (LandXML review, Undo, compare score), BUG-058 to BUG-069, BUG-283/417 (X-Civil unlocking), BUG-436/440/456/551/559/651, BUG-243, BUG-281, BUG-541, BUG-582, BUG-625, BUG-627, and the R00_CIVIL number list (X-Civil 0–250 m range, pipe size list, distances).

---

## FOR TIM — the 10 worst, in plain English

1. **A real Civil 3D LandXML file imports pits only, with no pipes.** The standard LandXML file names a pipe's two ends `refStart` and `refEnd`. CE looks for `startRef` and `endRef`, so it skips every pipe without a word. The review then says "12 pits, 0 pipes". Every CE test file uses CE's own invented names, so the tests stay green.
2. **CDSURVEY throws away every level above RL 500 or below RL 0.** On a Daylesford or Canberra survey (RL 580 to 700) every spot level is dropped, and CDSURVEY says "No survey RL data found". On a Docklands survey, the spots at −0.35 vanish, and a pit there picks up the next nearest spot's level. "RL 12.34" and "12.34m" are dropped too.
3. **A metre survey XREF in a millimetre drawing gives ground levels 1000 times too high.** AutoCAD attaches it at scale 1000, and CE scales the heights as well as the positions. The intake then refuses the survey as "conflicting". If the skip-suspect-points setting is on, PIT offers a cover level of 102340.00 instead of 102.34.
4. **X-Civil "Replace", then Close on the schedule review, erases the old import and draws nothing.** The old pits, pipes, labels and IL text are deleted before the review appears. Only an immediate U gets them back.
5. **Re-importing deletes your own hand-drawn pipes.** Say you drew P20 to P3 by hand, and P3 came from the import. Running X-Civil Replace erases your pipe. LandXML import does the same, and also erases any earlier import, without asking at all.
6. **X-Civil merges two pits that have the same cover level and sit within 1.8 m of each other.** A grated pit 1.5 m from a junction pit in a flat car park (both CL 12.34) disappears. The report only shows a smaller count.
7. **X-Civil throws away a good pit schedule table.** When there is no PDF, CE reads the DWG schedule table correctly, then runs a weaker text guess that replaces it. The pits lose their levels worked out from the depth column.
8. **Roof drains and hot water units lose their names.** COPY, CDTAG, or a change to the numbering setting turns "ROOF DRAIN 1" into "ROOF", and "HOT WATER UNIT 2" into "HOT". This happens on the label and in the stored name.
9. **LandXML detention (control) pits are drawn twice as long.** A 900 x 900 pit is drawn 1800 x 900.
10. **LandXML pit numbers that clash take over your pits.** If the file has P1 and the drawing already has P1, your P1 block stays on the drawing, but its record is gone, and your pipes now join the imported P1. Two networks in one file that both have "Structure - (1)" do the same thing to each other.

**What I recommend first:** items 1 and 9 are one line each in the LandXML reader, and plain unit tests can prove them wrong. Item 2 is a single line too. Items 4 and 5 are the ones that delete real work, so fix them before colleagues re-import anything.

---

## Full findings

Paths are relative to `Modules/Drainage` in the 3.0.53 tree. Each finding gives: where, trigger, wrong vs right, severity, confidence, fix idea, and whether a unit test can show it RED.

### A. Survey intake (CDSURVEY, Manager survey review)

A1. **Survey levels outside 0 to 500 m dropped silently** (re-read)
- **Where:** `Services/SurveyService.cs:627-638` `TryParseRl`: `if (v < 0 || v > 500) return false;`, and it needs a bare decimal (no "RL", no "m").
- **Trigger:** a survey XREF with spot text "616.250" (Daylesford, Trentham, Canberra) or "-0.350" (coastal). Run CDSURVEY.
- **Wrong vs right:** high sites: every spot is rejected, and the message is "No survey RL data found… Ensure the XREF contains RL text labels" (`:119`). Low sites: the negative spots vanish, and the pit takes another point's level. Right: read any finite level, keep its sign, and let the existing outlier check (BUG-134) flag strange ones.
- **Severity:** HIGH (refuses real work, or gives a wrong cover level). **Confidence:** CONFIRMED.
- **Fix:** remove the range check, allow "RL" and "m" around the number, and report how many labels were dropped.
- **Unit test RED:** yes. `TryParseRl("616.250")` returns false. The existing `SurveyServiceTests.TryParseRl_VariousInputs` cases for "-1.5" and "500.01" encode the wrong answer.

A2. **Metre survey XREF in a millimetre drawing: TIN heights multiplied by 1000** (re-read)
- **Where:** `Services/SurveyService.cs:107`, `:160`, `:201-213` `TryCollectFace` puts each 3DFACE corner through the XREF's `BlockTransform`, so the 1000 scale reaches Z too. Spot text levels are not scaled.
- **Trigger:** INSUNITS = mm. Attach a metre survey DWG that still holds its 3DFACE TIN (AutoCAD inserts it at 1000). Run CDSURVEY.
- **Wrong vs right:** with default settings every spot "conflicts with the TIN", so the intake is blocked with a misleading reason. With `loadSurveySkipSuspectPoints` on, the spots are marked Unknown, the survey is approved, and PIT, CDSL and the cover-level offer give 102340.00 for 102.34. Right: divide Z by the XREF's Z scale, or block with a plain units message.
- **Severity:** HIGH. **Confidence:** CONFIRMED (code path); not seen in AutoCAD.
- **Fix:** after the transform, divide Z by `blockRef.ScaleFactors.Z` (or keep the untransformed Z).
- **Unit test RED:** not as pure code (AutoCAD types). Needs an AutoCAD scenario, or a pure helper for the Z rule.

A3. **Survey intake checks treat millimetre drawings as metres**
- **Where:** `Services/SurveyIntakeSanityService.cs:84` grid cell 25.0, `:420-437` one list entry per cell a triangle touches, `:46-47` duplicate distance 0.05, `:70-71` and `:303` RMS limit 0.25 "m".
- **Trigger:** a TIN in millimetre coordinates (A2, or the raw-DWG route) with more than 2000 triangles.
- **Wrong vs right:** the grid cell becomes 25 mm, and a 100 m sliver triangle fills millions of cells, so AutoCAD can hang or run out of memory in CDSURVEY. The duplicate check shrinks to 0.05 mm (effectively off). The transform limit becomes 0.25 mm, so the intake is blocked as "low-confidence transform", and the review shows mm values labelled "m". Right: convert every tolerance by INSUNITS.
- **Severity:** HIGH (hang or refusal). **Confidence:** CONFIRMED for the arithmetic; the hang is PLAUSIBLE.
- **Fix:** pass INSUNITS into `CheckSurvey` and convert with `DrawingAreaUnits.MillimetresToDrawingUnits`.
- **Unit test RED:** yes. In `CheckSurvey`, two mm-scale spots 30 mm apart with RLs 0.5 m different give no `DUPLICATE_POINT_CONFLICT` today.

A4. **Attribute default values in survey point blocks read as spot levels** (re-read)
- **Where:** `Services/SurveyService.cs:162-164` (`obj is DBText`) together with the recursion into each nested block's definition at `:188-189`. `AttributeDefinition` is a kind of `DBText`.
- **Trigger:** a survey point block whose RL attribute default is "0.000" or "100.00".
- **Wrong vs right:** every insert adds a phantom spot at the definition's offset, carrying the default level. With half the spots at 0.00, the outlier check flags nothing, and PIT nearest-spot can offer cover 0.00. Right: ignore attribute definitions and use only the attribute on the insert.
- **Severity:** HIGH. **Confidence:** PLAUSIBLE (depends on the surveyor's block); the code path is confirmed.
- **Fix:** `if (obj is AttributeDefinition) continue;` before the DBText branch.
- **Unit test RED:** no (AutoCAD types).

A5. **Coordinate transform pairs spot levels by level only, not by position**
- **Where:** `Services/SurveyService.cs:298-314`: the first candidate with an equal RL wins, every pair goes into the least-squares solve, and no bad pair is rejected. `diff < bestDiff` with `bestDiff = rlTolerance` also drops a pair exactly 0.002 apart (floating point).
- **Trigger:** a flat site where 12.34 appears five times, listed in a different order in the XREF and in the raw DWG.
- **Wrong vs right:** a large RMS blocks the intake, or a small one lets the TIN through, shifted or rotated, and wrong ground levels are read at pits. Right: pair only levels that are unique in both sets, or drop pairs with large residuals and solve again.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED (matching); impact PLAUSIBLE.
- **Unit test RED:** yes, `MatchSpotLevelsByRl` with two equal RLs in reverse order.

A6. **Four-corner 3DFACEs lose half their area**
- **Where:** `Services/SurveyService.cs:201-203` and `:409-411` read three corners only.
- **Trigger:** a survey or grid DTM made of quad 3DFACEs.
- **Wrong vs right:** half of every quad is missing, so pits there fall back to the nearest spot with no warning. Right: split each quad into two triangles.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Unit test RED:** once the split is a pure helper.

A7. **Unitless metre drawings: survey reach limit ignored and the distance shown as "0.0 m"**
- **Where:** `Services/SurveyService.cs:521-536`. With INSUNITS 0, `DrawingAreaUnits.MillimetresToDrawingUnits` returns its input unchanged (`DrawingAreaUnits.cs:105-108`).
- **Trigger:** INSUNITS 0, MGA metre coordinates, reach 20 m, nearest spot 15 m away.
- **Wrong vs right:** the limit becomes 20 km, and the PIT note reads "nearest spot (0.0 m)". Right: "15.0 m", and the limit applies.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Fix:** use `DrawingAreaUnits.LooksLikeMetresWhileUnitless`.
- **Unit test RED:** yes, `TryGetRlAtPoint(15.0, 0, …, insunits 0)` returns "nearest spot (0.0 m)".

A8. **Skipping the raw survey file records the XREF as the raw survey**
- **Where:** `Commands/CdSurveyCommand.cs:117-120`, `:258-260`, `:321-322`.
- **Trigger:** flattened XREF; at Step 2, press Continue or Close without choosing a file.
- **Wrong vs right:** the XREF is listed twice in provenance and Sheets Issue evidence, and the result window claims "Raw 3D survey drawing used to derive the coordinate transform". Right: no raw source.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Fix:** treat `SourcePath == xrefPath`, or zero triangles, as skipped.

A9. **XREF fingerprint taken from disk, but levels from the loaded copy**
- **Where:** `Commands/CdSurveyCommand.cs:87` reads the loaded XREF; `:317-318` hashes the file on disk; the staleness check is at `Services/SurveyIntakeStalenessService.cs:373-375`.
- **Trigger:** the surveyor overwrites the XREF with Rev B, which shows "needs reloading" and has not been reloaded. Run CDSURVEY.
- **Wrong vs right:** Rev A levels are stored under Rev B's fingerprint. Right: refuse, or mark the revision Unknown.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.

A10. **"Suspect points" count includes notes that are not points** — `Services/SurveyIntakeApplyCoordinator.cs:95` counts all findings, so a single LOW_TIN_COVERAGE note shows as "1 suspect points". LOW, CONFIRMED. Fix: `SurveyOutlierMarkingPolicy.CountUnknown`. Unit test RED: yes, `BuildMeta`.

A11. **CDSURVEY reads only single-line TEXT and attributes tagged exactly "RL"** — `Services/SurveyService.cs:162-173`. MText levels and LEVEL / ELEV / EL tags are ignored, though X-Civil already accepts that list (`Services/XcivilEntityScanner.cs:1350`). MEDIUM, CONFIRMED (gap rather than a fault). Also any 0–500 decimal is taken as a level, so lot dimensions like "30.48" become spots.

### B. Spot levels, fall arrows and design-level offers

B1. **CDFALLSUGGEST writes a nonsense grade on Metres drawings** (re-read)
- **Where:** `Rules/FallArrowGeometry.cs:112` (`distanceMm` is in drawing units) and `:188` `runM = distanceMm / 1000.0`; no units are passed in.
- **Trigger:** a Metres drawing, a spot at 12.30, a grated pit 20 m away with cover 12.10. CDFALLSUGGEST, Accept.
- **Wrong vs right:** FALL_GRADE reads "1:0.1". Right: "1:100".
- **Severity:** HIGH on metre drawings. **Confidence:** CONFIRMED.
- **Unit test RED:** yes, once units are a parameter of `TrySuggestNearestDownhillPit`.

B2. **CDSL accepts any text and puts "P" in front** (re-read)
- **Where:** `Commands/SpotLevelCommand.cs:100-123`: `GetString`, then `SetAttribute(blockId, "LEVEL", "P" + levelValue)`; there is no number check.
- **Trigger:** type "P18.6", "18,6", "18600" or "18.6m".
- **Wrong vs right:** the drawing shows "PP18.6", "P18,6" or "P18600", and the command says "placed". CDFALLSUGGEST, the pit offer and CDSLAB then cannot read it, or read 18 600 m. Valid input stays as typed ("P18.6"), while CDSLAB writes 3 dp. Right: accept a number in metres (with an optional P or RL), ask again on bad input, and write P plus 3 dp.
- **Severity:** MEDIUM-HIGH. **Confidence:** CONFIRMED.

B3. **CDSL can leave a half-placed spot level on a locked layer** — `Commands/SpotLevelCommand.cs:111-123`. The block is committed first, then the level is set through `BlockService.SetAttribute` (`rejectLockedLayer: false`), and its result is ignored. MEDIUM, PLAUSIBLE. Fix: write the block and its level in one transaction, and check the layer first.

B4. **The spot-level finder gives up when the nearest spot is blank or unreadable** — `Services/SpotLevelReader.cs:48-58` picks the nearest block, and `:66-74` fails on it with no fallback. A blank CDSL 20 mm away hides a valid P12.800 40 mm away, so the result is "No spot level here", and no pit design level is offered. MEDIUM, CONFIRMED. Fix: rank only the candidates that read as a level.

B5. **Two rules for reading the same LEVEL attribute** — `Commands/SlabCommand.cs:440-463` strips P, RL and m; `Services/SpotLevelReader.cs:69-74` strips only P. "PRL 18.600" is a control level for CDSLAB, but invisible to CDFALLSUGGEST and the pit offer. MEDIUM, CONFIRMED. This breaks design rule #1. Fix: one shared pure parser (it also fixes B2).

B6. **The pit's design-level offer uses the plain slab triangulation, not the surface CDSLAB draws** — `Services/DesignLevelService.cs:43` uses `SlabService.Triangulate`, with no breaklines and no spoon islands, while CDSLAB and SlabFlow use `SlabConstrainedSurfacePlan`. With a valley breakline it can offer 10.2 where the falls show 10.0. MEDIUM, PLAUSIBLE. Unit test RED: yes (pure).

B7. **The pit offer reads the slab's stored levels, not the edited spot text** — `Services/DesignLevelService.cs:28-49`. ATTEDIT a CDSLAB spot from P12.500 to P12.450, and the pit is still offered about 12.50. MEDIUM, PLAUSIBLE.

B8. **X-Civil import strips TW / BW / RL / FL from spot levels** — `Services/XcivilEntityScanner.cs:1294-1296` (unanchored pattern) and `:1331`. "TW 12.450" becomes a bare "12.450", which CDSLAB then takes as a slab control level. "DL 19.146 (TBC)" loses "(TBC)". MEDIUM, PLAUSIBLE impact. Unit test RED: yes, `ApplySpotLevelPrefixMapping("TW 12.450")`.

B9. **Lower:** in a unitless metre drawing the 3 m design-offer reach becomes 3 km (`Services/DesignLevelService.cs:104-106`). `Services/ImportedLevelReviewService.cs:133` assumes mm. `Services/PitConnectedLevelAnalysisService.cs:240` formats levels with the PC's culture, so a decimal-comma PC would show "12,345".

### C. LandXML import and import compare

C1. **Every pipe in a standard LandXML file is skipped** (re-read)
- **Where:** `Helpers/LandXmlParser.cs:322-326` reads `startRef` / `endRef`. The LandXML schema and Civil 3D exports use `refStart` / `refEnd` (`<Pipe name="Pipe - (1)" refStart="S1" refEnd="S2" slope="-0.01">`). If either is blank, the parser returns null with no report line.
- **Trigger:** CDIMPORTLANDXML on any Civil 3D or 12d LandXML export.
- **Wrong vs right:** the review says "N pits, 0 pipes", and the import goes ahead with pits only. Right: every pipe is read.
- **Evidence the tests hide it:** every fixture uses CE's names: `Drainage.Tests/Helpers/LandXmlParserTests.cs:131,229,303`, `LandXmlUnknownsTests.cs`, `Bug605NamedInvertTests.cs:41-42`, `LandXmlNativeInvertRegressionTests.cs`. The Codex BUG-605 runs on 15 Oct used a hand-made XML, so they would not have exposed this.
- **Severity:** HIGH (refuses real work). **Confidence:** CONFIRMED from the code. The schema attribute names are from the LandXML 1.2 schema as I know it; confirm against one real export before fixing.
- **Fix:** read `refStart` / `refEnd`, fall back to the old names, and write a "pipe not drawn" line when a reference is blank.
- **Unit test RED:** yes. `TryParse` on two Structs and one Pipe with `refStart` / `refEnd` should give `pipes.Count == 1`.

C2. **Detention (control) pits drawn at double length** (re-read)
- **Where:** `Helpers/LandXmlParser.cs:246-250` sets both `DetentionSolidWidth` and `DetentionGratedWidth` to the full width. The drawn length is solid plus grated (`Services/XcivilPipeInsertionService.cs:1110-1111`, where every other route uses half the width).
- **Trigger:** a Struct named as a control pit with `<RectStruct width="0.9" length="0.9"/>`.
- **Wrong vs right:** 1800 x 900 drawn. Right: 900 x 900.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** solid = width / 2, grated = width − solid.
- **Unit test RED:** yes, via `TryParse`.

C3. **CDIMPORTLANDXML erases earlier imports without asking**
- **Where:** `Services/XcivilImportService.cs:1903` calls `ClearPreviousXcivilImportArtifacts`, with no Replace/Abort question (X-Civil asks, at `Commands/LinkCommands.ImportXcivil.cs:124-151`). The review says "Nothing has been drawn yet" (`Services/LandXmlImportReview.cs:46`).
- **Trigger:** import network A.xml, then run CDIMPORTLANDXML on B.xml.
- **Wrong vs right:** network A is gone, and so are pipes you drew to its pits (see D3). Right: ask Replace or Keep, and list what will be removed.
- **Severity:** HIGH (data loss). **Confidence:** CONFIRMED.
- **Unit test RED:** the missing warning, via `DetectPreviousImport` and the review lines.

C4. **A clashing pit number takes over an existing pit**
- **Where:** `Services/ProjectDataService.Mutations.cs:374-380` ("Remove any remaining pit that already uses this ID"), called from `Services/XcivilImportService.cs:1957`. `Helpers/LandXmlParser.cs:137-146` keeps `structById` per network, but one shared pit list.
- **Trigger:** the drawing has your own P1, and the file has `<Struct name="P1">`. Or two PipeNetworks each have "Structure - (1)".
- **Wrong vs right:** your P1 block stays on the drawing with no record, and your pipes now join the imported P1. With two networks, network 2's inverts land on network 1's pipes. Right: list the clashes as Check items before drawing.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Unit test RED:** yes for the in-file clash, via `TryParse`.

C5. **Box culverts become round pipes marked "read from the file"** — `Helpers/LandXmlParser.cs:346-351`: `diamMm = Math.Max(w, h)` with `HasExplicitDiameter = true`. A 1200 x 600 RectPipe becomes "1200 RCP, Read". EggPipe and ElliPipe fall to the 375 placeholder (BUG-512 wording). HIGH, CONFIRMED. Fix: carry the box size, or mark it Check. Unit test RED: yes.

C6. **The material class in the file is overwritten** — `Helpers/LandXmlParser.cs:466-484`. "uPVC SN10" becomes "UPVC SN8". "Stormpro sn16" becomes "STORMPRO SN12", because `Contains("SN")` is case-sensitive (`:473`). "Fibre reinforced concrete" becomes "RCP". MEDIUM-HIGH, CONFIRMED. Unit test RED: yes.

C7. **Position scale ignores the file's own millimetres, and is decided per pit** — `Helpers/LandXmlParser.cs:189`, `:446-460`. With `linearUnit="millimeter"` and local coordinates, positions are still multiplied by 1000. With no Units element, a pit at E=95 is not scaled but one at E=105 is, so the network is scattered. MEDIUM, CONFIRMED. This is the file's own unit, not the drawing's (BUG-505). Unit test RED: yes.

C8. **CDIMPORTCOMPARE names the wrong pipe as missing** — `Commands/LinkCommands.ImportXcivil.Corpus.cs:246-268`. The fallback match runs inside the same loop as the exact match. With expected P1→P2 and P1→P3 (both 375), and only P1→P3 drawn, P1→P2 grabs P1→P3 as a DIFF, and P1→P3 is then reported MISSING. MEDIUM, CONFIRMED. Unit test RED: yes, `BuildComparisonReport`.

C9. **CDIMPORTCOMPARE probably refuses a reference DWG that is open** — `Services/CdImportCompareSnapshotService.cs:267`, `:332` open with `FileShare.Read`. MEDIUM, PLAUSIBLE. Fix: `FileShare.ReadWrite | FileShare.Delete`.

C10. **Falling pipe grades dropped from labels** — `Helpers/LandXmlParser.cs:371-373` `if (slopeVal > 0.0)`. If the export writes a negative slope for falling pipes (believed, not checked against a real file), "1:100" is lost. MEDIUM, PLAUSIBLE. Fix: `Math.Abs`.

C11. **Lower:** `elevRim` is copied verbatim into "CL …" (`Helpers/LandXmlParser.cs:236`), so "45.2299999" reaches the drawing unrounded (breaks the 2 dp rule). `XDocument.Load` reads the whole file, so an export that also carries large surfaces can use up memory.

### D. X-Civil import (CDIMPORTXCIVIL)

D1. **A good DWG pit schedule table is replaced by the weaker text guess** (re-read)
- **Where:** `Services/XcivilScheduleService.cs:169` and `:176` repeat the same condition, `if (!pdfResolved || scheduleEntries.Count == 0)`. When there is no PDF, the second fallback always runs.
- **Trigger:** an X-Civil DWG with no PDF and a schedule table on GN-ANNO-TABL with a depth column.
- **Wrong vs right:** the depth-derived inverts are lost, and pre-flight shows "DWG text (DEGRADED)". If the text guess finds nothing, the data is wiped but the source still says "DWG block". Right: keep the block reading.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** line 176 becomes `if (scheduleEntries.Count == 0)`.
- **Unit test RED:** yes, public `ApplyXcivilScheduleData(pits, texts, null, null, …)` with GN-ANNO-TABL texts; assert source "DWG block".

D2. **Replace, then decline the review: the old import is erased and nothing is drawn** (re-read)
- **Where:** `Services/XcivilImportService.cs:240` runs `ClearPreviousXcivilImportArtifacts` before the scan. The pre-flight gate comes much later (about `:848-872`).
- **Trigger:** run CDIMPORTXCIVIL twice; the second time choose Replace, then Close or No at the schedule review. A crash during the scan does the same.
- **Wrong vs right:** every earlier imported pit, pipe and label is erased, and the report says "no entities were inserted". Right: nothing changes until the review is accepted.
- **Severity:** HIGH (data loss). **Confidence:** CONFIRMED.
- **Fix:** move the cleanup to the start of the insert phase in `ContinueXcivilImportAfterPreflight`.
- **Unit test RED:** no; needs AutoCAD or headless.

D3. **Replace also erases hand-drawn pipes that touch an imported pit** (re-read)
- **Where:** `Services/XcivilImportIdempotencyService.cs:128-136`: a pipe is removed if its From or To names an imported pit, even with no ImportBatch. The erase is at `Services/XcivilImportReportService.cs:690-747`. LandXML uses the same cleanup (C3).
- **Trigger:** import; draw P20→P3 by hand (P3 imported); re-import with Replace.
- **Wrong vs right:** your pipe, its mline and its text are erased. Right: only batch-tagged pipes go.
- **Severity:** HIGH (data loss). **Confidence:** CONFIRMED.
- **Fix:** apply the pit-connected rule only on legacy drawings with no batch-tagged pipes.
- **Unit test RED:** yes, `BuildPreviousImportPipeRemovalKeys_HandDrawnPipeToImportedPit_WhenBatchTaggedPipesExist_Excluded`.

D4. **Two pits with the same cover level within 1.8 m are merged** (re-read)
- **Where:** `Services/XcivilEntityScanner.Pits.cs:474-482`. When the CL text matches, the check returns "same pit" without testing that the pit numbers differ.
- **Trigger:** P1 and P2 1.5 m apart, both "CL 12.34" (or both picking up the same CL text).
- **Wrong vs right:** P2 is never drawn. Right: both pits drawn.
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** return false when both pit numbers are set and differ.
- **Unit test RED:** yes, `ConsolidateXcivilPitCandidates_DifferentPitIdsSameCoverWithin1800_KeepsBoth`.

D5. **Inverts worked out from grade assume the drawn start is the high end** — `Services/XcivilPipeInsertionService.cs:1497-1513` `knownValue - drop`. The flow arrow is fixed to the drawn direction (`:133, 140, 188`). A 1 in 100, 20 m pipe drawn from the downstream pit (IL 10.00) gives the upstream end 9.80 and an uphill arrow; it should be 10.20. MEDIUM-HIGH, PLAUSIBLE. Fix: get the direction from the covers or known inverts, or leave the level Unknown.

D6. **IL text can be drawn at the wrong ends** — `Services/XcivilPipeInsertionService.Annotations.cs:80-92` always puts FromInvert at the first vertex, while `:172-184` knows From can be at the last vertex and swaps only the stored values. MEDIUM, PLAUSIBLE.

D7. **Common IL and CL wordings are dropped, and (IN)/(OUT) is ignored** — `Helpers/XcivilImportPatterns.cs:13`, `:16`. "IL:12.34", "IL=12.34", "I.L. 12.34" and "INV 12.34" give no level. A single MText "IL 12.34 (IN)\PIL 12.30 (OUT)" gives both values the same position (`Services/XcivilEntityScanner.Pits.cs:755`). The in/out choice then depends on an unstable sort (`Services/XcivilPipeInsertionService.cs:379`). MEDIUM, CONFIRMED (patterns). Unit test RED: yes, `ExtractInvertLevels(new[]{"IL:12.34"})`.

D8. **"Cover minus pit depth" used as every pipe's invert at that pit** — `Services/XcivilScheduleService.cs:1082` and `Services/XcivilPipeInsertionService.cs:339`. Depth runs to the pit floor, so every inlet is labelled with the floor level, drawn as a normal IL. MEDIUM, PLAUSIBLE. Unit test RED: yes, `ApplyDerivedInvertsFromSchedule` then `AssignInvertsForPit`.

D9. **Text schedule row with no "CL": the first 2 dp number is taken as cover** — `Services/XcivilScheduleService.cs:698-713`. In "P1 GP 600x600 1.20 12.34 11.14" the cover is read as 1.20. MEDIUM, PLAUSIBLE.

D10. **The report keeps only the first 30 warnings, and the PDF reader runs twice** — `Services/XcivilImportService.cs:1459` (no "and N more" line); `ApplyXcivilScheduleData` is called at `:469` and `:505`, so a slow PDF can cost up to 90 s. LOW, CONFIRMED.

### E. Source tags (downpipes, roof drains, trench grates)

E1. **Multi-word source names cut to their first word** (re-read)
- **Where:** `Rules/SourceFamilies.cs:211-219` `CategoryOf` takes the letters before the first non-letter, and a space counts, so "ROOF DRAIN 1" is family "ROOF". `Rules/SourceNumbering.cs:49` writes the family as the label. Reached from `Services/SourceTagService.cs:153-182` (numbering setting change), `Services/SourceTagService.SourceChangeApply.cs:32-33` (CDTAG Set), and `Services/LinkService.SpineClones.cs:157` (COPY: `AllocateNextTag`).
- **Trigger:** CDSOURCE a Roof Drain ("ROOF DRAIN 1"), then COPY it, CDTAG Set it, or change the source numbering setting.
- **Wrong vs right:** the label reads "ROOF" (or "HOT", "AC"), and a copy is stored as "ROOF1". Right: "ROOF DRAIN 2".
- **Severity:** HIGH. **Confidence:** CONFIRMED.
- **Fix:** keep multi-word names whole, and number copies with `GenericSourceTypes.NextNumberedName`.
- **Unit test RED:** yes, `SourceNumbering.LabelFor("HOT WATER UNIT 1", SourceFamilies.CategoryOf(...), OnlyWhenScheduled)` returns "HOT".

E2. **CDFIXTAGS proposes "WT1 1" instead of WT2** — `Rules/DuplicateSourceTagPolicy.cs:96` appends " n" to the whole tag. "ROOF DRAIN 1" becomes "ROOF DRAIN 1 1". MEDIUM, CONFIRMED. Unit test RED: yes, `ProposeRepairs`.

E3. **CDTAG on an untagged block never checks the name is free** — `Commands/SourceTagCommand.cs:306` calls `SetTag` with no owner check, so two blocks can both be "DP3" (the BUG-154 situation). Re-tagging does check. MEDIUM-HIGH, CONFIRMED. Fix: route through `SourcePlacementService.ResolvePlacementTag`.

E4. **CDTG "enter to skip" cover level reuses the last grate's level, even in another drawing** (re-read) — `Commands/SourceBlockInsertCommands.cs:32`, `:742-759`. The value is held for the whole AutoCAD session, and Enter returns it. Job B gets "PCL 45.200 m AHD" from job A. Once a level has been typed, Enter can never mean Unknown again. MEDIUM-HIGH, CONFIRMED. Fix: remember the level per drawing, and add an Unknown keyword.

E5. **CDFIXTAGS adds a label to sources that had none** — `Commands/SourceTagRepairCommand.cs:163` passes `showLabel = true`. If the GUIDELINES layer is missing, the rename is refused. LOW-MEDIUM, CONFIRMED.

E6. **Trench drains in Metres drawings** — `Commands/SourceBlockInsertCommands.cs:188` refuses runs of 1 unit or less ("same point"). Width defaults to 300, and `TgLengthMm` stores drawing units (`:370`). MEDIUM, PLAUSIBLE.

E7. **Tag removal leaves orphan records in the file** — `Services/SourceTagService.cs:488-497`: `dict.Remove` without `Erase`. LOW, PLAUSIBLE.

E8. **X-Civil skips unnumbered endpoints such as AGI and LPD without reporting them** — `Services/XcivilSourceTagPitRegistrationService.cs:94`. LOW, PLAUSIBLE. Unit test RED: yes.

---

## Checked and found sound

1. **LandXML:** `<Center>` is read northing then easting, numbers use InvariantCulture, the 1.0/1.1/1.2 and namespace-free files are detected, and inverts match pipes by `refPipe`.
2. **Survey:** the Manager bridge, the review page and the Apply transaction (roll back on failure, then exact read-back) traced clean.
3. **Surfaces:** zero-area triangles are skipped, and there is no inverse-distance divide-by-zero. Typed and automatic levels are compared rounding half away from zero. The "Assumed" cover state is defined but never written, so nothing shows an assumed level as real.
4. **Source tags:** DP1 and DP10 match exactly, never by prefix. The highest-used number is kept and tags are not recycled. Locked label layers are refused.

## Not covered

The X-Civil corpus comparison command, the AI vision lane, the PDF PowerShell script, slab boundary editing beyond its level reading, and Structural and Manager outside the survey bridge.

---

## Summary

On the installed Civil 3.0.53 tree, this read-only hunt found about 45 new defects in survey intake, spot levels, LandXML, X-Civil and source tags. About 17 are HIGH, and none repeats a parked bug. The three most serious problems: a standard LandXML file imports with no pipes at all, because CE reads the wrong attribute names and its tests use the same wrong names. CDSURVEY silently drops every level above RL 500 or below RL 0, and multiplies TIN heights by 1000 when a metre survey is attached to a millimetre drawing. And both importers can erase earlier imports and the drafter's own hand-drawn pipes, before or without a review. A run of smaller faults put wrong or invented text on the drawing: double-length LandXML control pits, merged X-Civil pits, discarded schedule tables, "ROOF DRAIN 1" cut to "ROOF", "1:0.1" fall grades on metre drawings, and a trench grate cover level carried from one job into the next. About half can be shown RED with plain unit tests, starting with the LandXML reader (C1, C2, C5, C6, C7), the survey level reader (A1) and the X-Civil schedule fallback (D1). Nothing here has been seen in AutoCAD, and the controller still has to file BUG numbers.
