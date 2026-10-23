# RD15 — LandXML import and survey audit — 24 October 2026, Melbourne

1. **ANSWER FIRST — HIGH 3, MEDIUM 1, LOW 0.** Four new findings, all SURE / verified by reading. None has been run in AutoCAD in this audit. These counts exclude the existing BUG numbers below.

2. **Most important — a missing pipe grade becomes a printed 1 in 100.** A LandXML pipe with neither a slope nor invert levels can acquire an ordinary-looking grade label. The review does not identify that grade as invented. A drafter could issue a fall the consultant never supplied.

3. **Second — moving the survey leaves its old levels in use.** After an approved survey XREF moves, New Pit can still offer the ground level at the old location, without a stale-survey warning. For example, the drawing shows RL 12.00 here but CE offers the old RL 20.00.

4. **Third — levels inside a rotated survey block land in the wrong places.** The survey reader combines nested block movements in the wrong order. A level visibly at (0,10) can be stored at (10,0), causing New Pit to offer another nearby level.

5. **Fourth — the review hides everything after the tenth finding.** Scrolling cannot reveal the remaining suspect points: the page only receives ten descriptions and an “and more” line.

6. **Next action.** Give the builder the four smallest fixes and the unrun checks below. No engineering threshold needs a new ruling. Keep manual drafting available with a clear warning wherever the survey cannot be trusted. Nothing is fixed or accepted by this report.

---

1. **Scope and ownership.** Independent, read-only review for desk plan/03, Civil area B / survey and imports. Sole authored repository file: `areas/CODEX_AUDIT2_RD15_24OCT.md` in `C:\CE_PLAN`. No source edits, branch, source commit, build, tests, installation, AutoCAD session or sub-agents. The brief's explicit read-only exception overrides its appended worktree-branch/build/PR boilerplate.

2. **Pinned source.** Fetched origin and created the detached worktree `C:\ce-cx\rd15` at `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (release commit labelled Civil 3.0.72 / Manager 1.1.72). All source reads used Git objects at that HEAD. The separately requested Structural ref resolves to `e6d597c0fbc25e78118760887a70810e0890c9a9`; Structural implementation is outside this area. Installed binaries were not inspected; the release labels are source identity, not independent installation evidence.

3. **Prior evidence and duplicate check.** Read Tim's RULES and ROUTER, the CE start/master plan and area B record; consulted `AUDIT_C58_C60_S40_S41_2026-10-22.md`, the three `CODEX_AUDIT_*_22OCT.md` reports, `CODEX_HUNT_IMPORT_22OCT.md`, and the earlier Civil B hunt. Searched `BUG_CARPARK.md` before source review and again for each candidate, including later RD findings through BUG-1087. No changes to the bug register, desk log or queue.

4. **Known findings excluded — BUG numbers only.** BUG-505, BUG-512, BUG-513, BUG-516, BUG-602, BUG-603, BUG-604, BUG-605, BUG-699, BUG-700, BUG-701, BUG-702, BUG-703, BUG-704, BUG-705, BUG-706, BUG-707, BUG-708, BUG-709, BUG-719, BUG-720, BUG-721, BUG-722, BUG-723, BUG-724, BUG-725, BUG-728, BUG-729, BUG-732, BUG-876, BUG-877, BUG-878, BUG-898, BUG-899, BUG-1053.

5. **Evidence language and fixtures.** SURE / verified by reading means the defect is traceable in the pinned implementation, not observed in AutoCAD. All deterministic tests below are specifications, NOT RUN. Fixture drawings and XML are synthetic and must be created outside repositories by the later tester, in disposable copies and an isolated test profile. Coordinates are world coordinates; levels are metres. Cancel any New Pit window after reading its offer unless the step explicitly requires placement.

1. **RD15-01 — HIGH — SURE / VERIFIED BY READING: LandXML with no grade prints an invented 1 in 100.**

   **What Tim would see:** a 300 mm pipe is labelled `AT 1 IN 100` even though the source gives no slope and no invert levels from which to calculate one. The review lists it as a pipe read from the LandXML file, without a missing-grade check.

   **File:line:** `Modules/Drainage/Helpers/LandXmlParser.cs:369` leaves `GradeText` empty without a positive slope. `Modules/Drainage/Services/XcivilImportService.cs:1887` prepares every parsed pipe. `Modules/Drainage/Services/XcivilEntityScanner.Pipes.cs:1145` builds its display text. `Modules/Drainage/Services/XcivilLayerRecognition.Visual.cs:195` substitutes `100` when grade is blank, and `:216` prints it for an ordinary stormwater pipe. `Modules/Drainage/Services/XcivilPipeInsertionService.cs:127` passes the empty grade and fabricated display text separately; `Modules/Drainage/Services/PipeCreationService.cs:319` draws the latter. Review rows at `Modules/Drainage/Commands/LinkCommands.ImportXcivil.cs:292` check diameter and endpoint names, not grade.

   **Exact failure scenario:** two fully sized pits and a fully sized/materialled pipe, with the source's slope attribute absent and both invert lists empty. There is no engineering evidence for any fall. The display builder independently supplies the constant 100. The record builder at `XcivilPipeInsertionService.cs:181` meanwhile saves default grade mode, empty custom grade and `ShowGradeInText=false`; its flag does not prevent this initial label because insertion takes the separately supplied display string. This finding uses an absent slope, not a signed-slope case.

   **Deterministic test — fixture:** save `RD15_GRADE.xml` with the XML below. It deliberately uses the parser's accepted `startRef`/`endRef` spellings to isolate this finding; it is not a claim that those spellings are the standard schema. Use an empty millimetre drawing (`INSUNITS` 4), unlocked output layers and sufficient space for a 30 m pipe label.

   **Deterministic test — typed steps:** type `CDIMPORTLANDXML`; if offered a previously found file, choose No. Click **Choose LandXML**, select `RD15_GRADE.xml`, then **Read source**. Read P1-to-P2's review row and click **Import to drawing**. Inspect the text attached to the only pipe. Read the pipe record as a second oracle.

   **Assertions:** the pipe exists; its label must not contain `AT 1 IN 100` or any other invented grade. The review must identify grade as Unknown, or explicitly identify a separately accepted assumption before using it. The source has no grade and the record's `CustomGrade` is empty. Current source predicts an ordinary 1-in-100 display label with no grade warning in that review row. Positive control: add `slope="0.005"` to the Pipe element in a fresh fixture; the label must say `AT 1 IN 200`.

   **Smallest fix:** make the display builder omit the grade clause when grade is absent, and add a missing-grade check to the review. Preserve an explicit source grade. Do not replace Unknown with a new default or block the import. The shared builder also serves X-Civil; check its blank-grade call sites with the same rule.

```xml
<LandXML>
  <Units><Metric linearUnit="meter" /></Units>
  <PipeNetworks><PipeNetwork name="SYNTHETIC">
    <Structs>
      <Struct name="P1" desc="Grated pit" easting="10" northing="10" elevRim="12.00">
        <RectStruct width="0.6" length="0.6" />
      </Struct>
      <Struct name="P2" desc="Grated pit" easting="40" northing="10" elevRim="12.00">
        <RectStruct width="0.6" length="0.6" />
      </Struct>
    </Structs>
    <Pipes>
      <Pipe name="A" startRef="P1" endRef="P2">
        <CircPipe diameter="0.3" material="RCP" />
      </Pipe>
    </Pipes>
  </PipeNetwork></PipeNetworks>
</LandXML>
```

2. **RD15-02 — HIGH — SURE / VERIFIED BY READING: approved survey levels remain usable after their XREF moves, with no freshness check.**

   **What Tim would see:** moving a survey to correct its alignment changes the visible ground levels, but CE continues offering levels at their old positions. Typing CDSURVEY again initially describes the stored survey as approved; cancelling at the pick leaves that old survey in use.

   **File:line:** `Modules/Drainage/Services/SurveyIntakeApplyCoordinator.cs:47` is the production caller of the staleness check, only while applying an intake. `Modules/Drainage/Services/SurveyService.cs:813` loads the stored geometry and `:830` returns it without comparing current source files, XREF position or drawing units with the saved provenance. `Modules/Drainage/Commands/PitCommand.cs:150` consumes that payload and `:157` offers its level. `Modules/Drainage/Services/SurveyService.cs:868`/`:881` describes the stored approval, and `Modules/Drainage/Services/SurveyProvenanceEvidenceService.cs:64` maps any stored provenance to Approved without rechecking the sources.

   **Exact failure scenario:** intake is read, approved and committed successfully. Later the same XREF is moved 10 m using AutoCAD MOVE. The stored payload is a separate set of coordinates in the drawing dictionary; it is not transformed by moving the XREF. The next PIT reads that payload directly. Repository call-site searches found the source/transform revalidation only at Apply, not on lookup or provenance publication. This concerns a change AFTER successful approval, not a mismatch between disk and loaded XREF during capture.

   **Deterministic test — fixture:** `RD15_STALE.dwg`, metres (`INSUNITS` 6), World UCS, containing only two single-line TEXT levels: `12.000` at (0,0,0) and `20.000` at (10,0,0), with no surface faces. Attach it at the origin, scale 1, rotation 0 to an empty metre host. Use Design workflow, no CE slab/design spots, design-first offers OFF and nearest-spot reach 0 (unlimited).

   **Deterministic test — typed steps:** `CDSURVEY`, click this XREF; on the optional raw-file page choose no other file and continue with spots only. In **Survey Intake**, click **Approve and store with drawing**. Require the CE log line beginning `[CDSURVEY] Survey approved and stored:`. Type `MOVE`, select that XREF, Enter, base `0,0,0`, second point `10,0,0`. Type `PIT`, pick `10,0,0` and read **Survey level nearby**. Cancel. Finally type `CDSURVEY`, read **Current survey**, and Esc at the XREF pick.

   **Assertions:** the XREF's visible text at (10,0) is now `12.000`; CE must not silently offer `20.00` there as usable current survey evidence. It must identify the survey as needing a reread and leave the offer unavailable, or first explicitly re-read/review the moved source. Current source predicts `20.00` with `nearest spot (0.0 m)` and an approved stored status without a movement warning. Control: rerun CDSURVEY and approve after the move; the new offer should be `12.00`. This proves the stale coordinate copy, independently of disk hashes or file reload timing.

   **Smallest fix:** centralise a read-only currency check against saved source identity, XREF transform and units before offering stored survey levels or publishing a current status. Flag stale evidence and permit typed levels; do not hard-block PIT. Use invalidation/caching so the fix does not hash large survey files on every cursor movement. A saved historical approval may remain in provenance, clearly distinguished from present currency.

3. **RD15-03 — HIGH — SURE / VERIFIED BY READING: nested survey transformations are applied in reverse order.**

   **What Tim would see:** the survey TEXT visibly sits at one location, but CE reads that level at another. The fault needs a nested block plus a non-commuting outer move, rotation or scale; a simple origin-aligned test does not expose it.

   **File:line:** `Modules/Drainage/Services/SurveyService.cs:105` supplies the outer XREF transform; `:169` transforms TEXT coordinates with the supplied matrix; `:199` combines the child as `nestedRef.BlockTransform * parentTransform`, before recurring. The same combined matrix reaches faces at `:210`. The separate X-Civil reader provides a useful source comparison: `Modules/Drainage/Services/XcivilEntityScanner.cs:359` prepends the child, then `:372` applies each transform sequentially, child first and parent afterwards.

   **Exact failure scenario:** an inner block is translated 10 m along X inside a survey XREF rotated 90 degrees about the world origin. A TEXT insertion at the inner block origin should become (10,0) in the survey and then (0,10) in the host. The survey product applies the outer rotation before the child's displacement, yielding (10,0). The comment claiming row-vector ordering at line 198 does not make the matrix product equivalent to the required sequential point transformations. Direct RL attributes follow a different branch at line 186; this fixture deliberately uses TEXT inside the block.

   **Deterministic test — fixture:** in a metre source drawing, create block `RD15_LEVEL` with base point (0,0,0) and one single-line TEXT `12.000` whose insertion point is (0,0,0). Insert it at (10,0,0), scale 1, rotation 0. Add top-level TEXT `15.000` at (11,0,0) and `19.000` at (20,0,0). No faces, attributes, extra numeric text or other blocks. Save as `RD15_NESTED.dwg`. Attach to an empty metre host at (0,0,0), scale 1, rotation 90 degrees. World UCS; nearest-spot reach unlimited and Design workflow as in RD15-02.

   **Deterministic test — typed steps:** `CDSURVEY`, select this XREF, skip the optional raw DWG, approve in **Survey Intake**. Type `PIT`, pick `0,10,0`, read **Survey level nearby**, then cancel. For the drawing-value oracle, decode `CE_CVL_SURVEY` / `SURVEY_DATA` and read the point with Rl=12.000.

   **Assertions:** that point must be X=0, Y=10 within 0.000001 m, matching the visible TEXT insertion. New Pit must offer `12.00` at zero distance. Current source predicts stored X=10, Y=0 and the offer `15.00`, whose correctly transformed top-level TEXT is only 1 m from the pick. Control: put the `12.000` text directly into source model space at (10,0), removing its block wrapper; repeat and require identical stored positions and offers. A later isolated regression should compare the recursive reader to explicit `point.TransformBy(child).TransformBy(parent)`, not another copy of the same matrix multiplication.

   **Smallest fix:** compose `parentTransform * nestedRef.BlockTransform`, retaining the existing outer transform. Cover rotated, scaled and translated nesting with a sequential-point oracle. Do not change the direct attribute branch or apply the parent a second time.

4. **RD15-04 — MEDIUM — SURE / VERIFIED BY READING: Survey Intake cannot show the eleventh suspect point before approval.**

   **What Tim would see:** the review says there are more suspect points, but scrolling to the end only shows `... and 1 more`. The omitted point cannot be identified from this approval page or the command history.

   **File:line:** `Modules/Drainage/Services/SurveyIntakeReviewSession.cs:25` constructs the page's entire line list using `snapshot.Findings.Take(10)` at `:26`. `Modules/Drainage/Survey/SurveyIntakeReviewView.cs:59` displays that already-truncated list. `Modules/Drainage/Commands/CdSurveyCommand.cs:174` independently truncates command-line details to ten. Full findings exist in the snapshot; no expansion or all-findings action exists in this view.

   **Exact failure scenario:** eleven advisory outliers are retained as Unknown. The page permits approval but exposes only ten individual positions. It is not a scrollbar/layout problem: the missing descriptions never reach the scrollable list. The non-Manager result window's later full list does not fix the colleague Manager approval route.

   **Deterministic test — fixture:** a metre survey source with 32 top-level single-line TEXTs, inserted in this order, all at Y=0. For integer i=0..20, position (i,0) and value `10.000 + 0.010*i`, formatted to three decimals. For i=21..31, position (i,0) and text `100.000`. No TIN, other numeric text or duplicate coordinates. The non-zero median absolute deviation makes the last eleven statistical outliers; this avoids the optional skip-suspect setting and its separate refusal behaviour.

   **Deterministic test — typed steps:** attach that source at scale 1/rotation 0 in a metre host. Type `CDSURVEY`, pick it, skip the optional raw DWG. Open the Manager **Survey Intake** page and scroll its list fully. Read F2 command history too. Do not approve just to find the missing detail; click **Cancel intake** after checking.

   **Assertions:** the review must expose all eleven outlier descriptions, including `Spot RL 100.000 at (31.0, 0.0)`. Current source predicts the eleven-finding count, ten detail lines and `... and 1 more`; the (31.0,0.0) detail is absent from both surfaces. Control: remove the final TEXT and require all ten remaining descriptions. The omitted point must remain Unknown in the snapshot; this finding is about the inability to review it, not incorrect outlier marking.

   **Smallest fix:** supply all finding descriptions to the existing bounded scrolling list. The command-line summary can remain capped if it directs the drafter to the complete page. No whole-window scrolling or new approval step is needed.

---

1. **What I did not check.** No build, test execution, WPF render, AutoCAD run, drawing creation, installed DLL inspection, live Settings inspection, real consultant file, performance measurement or native Undo/Redo/save/reopen check. The XML and DWG recipes above were not created or executed. No claim about exact runtime label refresh timing, displayed layout, installation state or acceptance is made.

2. **Other scope limits.** This was a bounded LandXML/CDSURVEY/Survey Intake review, not a whole Project Review or X-Civil audit. Structural implementation, Manager administrator work, deployment and the colleague installer were not investigated. Large-file cancellation, schema variants beyond the read parser paths, Civil 3D proxy contents, hidden external dependencies and all AutoCAD-year combinations remain untested. Existing faults are excluded from the new counts even where the pinned source still contains them.

3. **Delivery record.** Only this findings file is to be staged and committed by name in CE_PLAN, followed by fetch, merge of origin/main without rebase, the normal leak-scanned push and a no-ahead status check. The detached source worktree is removed after its clean status is checked. No code PR is appropriate for this read-only brief.

4. **Summary — under 100 words.** Four new source-proven faults: a missing LandXML grade prints as 1 in 100; survey offers can use old coordinates after an XREF moves; nested survey transforms misplace levels; and the approval page hides findings beyond the first ten. The first three are HIGH; the review-list omission is MEDIUM. Each has an isolated synthetic fixture, exact user actions, expected evidence and a small fix. Existing BUG entries were excluded. Nothing was built, tested, installed or accepted, and AutoCAD was not opened.
