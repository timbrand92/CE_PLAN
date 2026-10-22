**ANSWER FIRST — independent imports hunt, 22 October 2026, Melbourne**

1. **Counts: HIGH 3 / MEDIUM 3 / LOW 0.** Six new findings, all VERIFIED-BY-READING. None was run in AutoCAD. The tests below are instructions for the test lane, not passing results.

2. **Most important: Replace can remove a pit and leave nothing in its place.** If the replacement adds a cover level on a locked text layer, CE deletes the old pit before deciding it cannot draw the new one. For example, updating a pit with no cover level to CL 12.00 can make that pit disappear.

3. **Two other serious faults.** Choosing another file on the review page can import the previously read file instead. A LandXML pipe can receive an invert that the file explicitly assigns to another pipe.

4. **The results window is not reliable evidence of placement.** It can say Recorded for a pit that was skipped. Replacement imports can also move because CE includes the old import when deciding the new position, and PDF schedules spanning multiple sheets lose all but one sheet's rows.

---

1. **Scope and evidence.** Read Git objects in `C:\Lisp Files\CE_ACAD_PLUGIN` after `git fetch origin`. Civil/Manager source: `origin/claude/rel-20261022m`, commit `40ee0a36f7960145743954b39859eb6c3af92869`. Structural reference: `origin/claude/rel-20261022s2`, commit `2c9a96942a024888a5ab520600f2d5025de83036`. The nominated import commands and helpers are Civil code; all source line numbers below refer to the Civil commit. Installed DLL identity was not independently checked.

2. **Earlier evidence and exclusions.** Consulted `START_HERE.md`, `MASTER_PLAN.md`, `areas/civil-B-survey-surfaces-imports.md`, `areas/AUDIT_C58_C60_S40_S41_2026-10-22.md`, the Civil, Structural and Gate `CODEX_AUDIT_*_22OCT.md` reports, and relevant import entries in `BUG_CARPARK.md`. Existing scale, schema-reference, placeholder, material, detention-size, large-file, cancellation-initialisation and schedule-pairing defects are not counted again. Findings about new failure paths in existing fixes identify the distinction below.

3. **Limits and ownership.** Only this findings file was authored. No source edit, branch, worktree, build, test, AutoCAD launch, installation or sub-agent. No client files or live Settings were read. No bug is marked fixed. The six counted items are verified control-flow defects; their native appearance and recovery remain unverified. Engineering defaults stay on Settings, R-27 remains warn-and-carry-on, Civil + Manager delivery remains 9 November, and Manager administrator work remains parked.

4. **Test conventions.** Every test uses synthetic files and disposable drawing copies in model space, World UCS, `INSUNITS 4`, a Civil-tagged target, ordinary unlocked layers unless specified, and the packaged CE pit blocks. Use office-default layer names or record their Settings mappings. For window tests, remove test-process import-path environment overrides so the interactive route is used. Enable the existing LandXML review and replacement questions in the isolated test profile. Restore test Settings afterwards. Repeat on AutoCAD 2024/net48 and 2027/net10. No fixture files were created by this audit.

**Numbered findings — six counted items**

1. **HIGH — replacement deletes an old pit before checking whether its replacement can be drawn. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/XcivilImportService.cs:1921`, `:1950`; X-Civil equivalent `:975`, `:986`. Cleanup: `Services/XcivilImportReportService.cs:725`, `:747`, `:803`, `:815`. Required layers: `Rules/XcivilImportLockedLayers.cs:51`. Cover creation: `Services/XcivilPitInsertionService.cs:119`, `:184`.

   **What happens in AutoCAD:** an existing imported pit disappears when the new version needs a locked layer that the old pit did not use. The drawing is left with an incomplete replacement, although CE knew the required layer was locked before erasing anything.

   **Exact failure scenario:** old P11 has a block and number label, but no cover text. Both old components are unlocked. The new XML supplies `elevRim="12.00"`, making `25TEXT` a required layer. Lock only `25TEXT`. Cleanup checks the OLD components, finds none on the locked layer, erases them and commits. Only afterwards does `PitLayers(..., withCoverText: true)` make insertion skip NEW P11. Removing the old record is also completed before this skip. There is no restoration of that pit on this path.

   **DETERMINISTIC TEST:** make `old.xml` from the single-pit fixture below with the `elevRim` attribute removed; make `new.xml` with it present. Import old.xml and confirm one P11 block, one number label and no cover text. Record their handles. Type `-LAYER`, Make, `25TEXT`, Enter; set `CLAYER` to `0`; type `-LAYER`, Lock, `25TEXT`, Enter. Run `CDIMPORTLANDXML`, Choose LandXML, new.xml, Read source, type Replace at the earlier-import question, then click Import to drawing. Assert the old P11 block/label and record remain when the replacement is skipped, and `25TEXT` remains locked. Current source instead produces `cleanup previous-xcivil: pits=1` in the import debug log, `Pits created:        0` in the report, and a locked-layer sentence saying CE did not draw 1 pit. The old handles are erased and no replacement P11 exists. On a separate copy type U and then REDO and record actual recovery; no Undo outcome is claimed here.

   **Distinction and correction direction:** BUG-731 moved erasure after the reading/acceptance step, and BUG-417 protects old objects already on locked layers. Neither handles NEW required layers. Determine which replacements can be drawn before deleting their predecessors; retain affected old items and warn while importing the other items. This needs no new hard block.

2. **HIGH — changing the source during review accepts and imports the old source. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Commands/LinkCommands.ImportXcivil.cs:73`, `:164`, `:175`, `:179`; LandXML `:400`, `:418`, `:427`, `:467`. `Dialogs/CivilImportWindow.xaml:70`, `:94`, `:98`; `Dialogs/CivilImportWindow.xaml.cs:37`, `:49`, `:73`; `ViewModels/CivilImportWindowViewModel.cs:53`, `:60`.

   **What happens in AutoCAD:** the drafter notices the wrong file, goes back to Source and chooses the correct one. Clicking Read source can draw the earlier file immediately. The visible source name and button promise a fresh read, but the accepted data still belongs to the old file.

   **Exact failure scenario:** the command captures `sourcePath` or `xmlPath` before parsing. The review is a second window sharing the mutable view model. Its Source tab and chooser remain active. `ChooseSource` changes the displayed path, empties the review and resets the button to Read source. `OnContinue` still sets the same Boolean `ContinueRequested`. The pending review callback takes that Boolean as permission to insert its already-parsed lists; it never compares the new path, rereads it or requires `HasReading` to remain true.

   **DETERMINISTIC TEST:** make A.xml from the single-pit fixture below. Make B.xml by changing P11 to P21, width/length to 0.9, easting to 20 and cover to 13.00. Run `CDIMPORTLANDXML`, Choose LandXML, A.xml, Read source. In the review window click Source, Choose LandXML, B.xml. Assert the source now reads B.xml and the footer button reads Read source. Click that button. Acceptance: a review of P21, with no P11 or P21 drawn yet. Current code instead resumes A's insertion; the report names A.xml and the drawing contains P11, not P21. Repeat the same flow with two recognised X-Civil DWGs with disjoint pit labels, using Choose DWG on the schedule window. Close/Escape immediately after choosing B is the control: neither source should be inserted.

   **Why green tests miss it:** `Modules/Drainage.Tests/Dialogs/CivilImportWindowRenderTests.cs:120` checks that choosing another source clears the view model. It never resumes the waiting import command. The reset itself passes while creating the misleading Read source state.

   **Correction direction:** bind acceptance to the exact parsed source and review state. A source change must return a distinct read-again action to the command, or source selection must be unavailable during that acceptance step.

3. **HIGH — the single-level shortcut assigns an explicitly named invert to the wrong pipe. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Helpers/LandXmlParser.cs:260`, `:277`, `:328`; `Services/XcivilPipeInsertionService.cs:325`, `:337`, `:352`, `:445`, `:503`; LandXML caller `Services/XcivilImportService.cs:2065`.

   **What happens in AutoCAD:** a pipe receives a believable but unsupported invert. For example, B gets 9.75 m even though the file says that level belongs to A. The mistake can then appear in pit levels and schedules.

   **Exact failure scenario:** P31 supplies just `<Invert elev="9.75" refPipe="A"/>`. Pipe A is absent or skipped because its other pit is missing; B is the only successfully inserted pipe at P31. The parser correctly retains `refPipe`. However, `TryAssignNamedInverts` returns false when there is one level and one endpoint BEFORE comparing the names. The caller then assigns the sole level using `single-text`. The later normal unmatched-name rule, which would leave the level Unknown, is bypassed.

   **DETERMINISTIC TEST:** use the named-invert fixture below, containing P31, P32, valid B and A referring to absent P99. Run `CDIMPORTLANDXML`, choose that XML, Read source, Import to drawing. Assert the report identifies A as not drawn, B exists, and B's P31-end invert remains Unknown. Assert the latest import debug log contains an unresolved P31 endpoint with reason `no-level-names-this-pipe`, and contains no resolved B/P31 entry with value 9.75. Current source instead writes a line containing `end=start owner=P31 value=9.75 source=single-text`. Read B's stored FromInvert as the drawing-value oracle; do not rely only on a rounded label. Control: change refPipe to B, reimport on a separate copy, and require 9.75 at that end.

   **Distinction and correction direction:** this is a residual hole in the named-invert fix for BUG-605, not the already-known sump-as-invert or ambiguous co-located-level problems. An explicit mismatching pipe name must outrank the single-level shortcut. A one-level case with no name can retain its separately approved rule.

4. **MEDIUM — the results page calls skipped items Recorded and can call a zero-placement import complete. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Commands/LinkCommands.ImportXcivil.cs:219`, `:222`, `:229`; LandXML `:508`, `:513`, `:518`. `Services/XcivilImportService.cs:1950`, `:2082`; `Services/LandXmlImportReview.cs:107`.

   **What happens in AutoCAD:** the command history says a pit was not drawn, but the results window lists that same pit as Recorded. This can conceal a missing part of the network from someone reviewing the import window.

   **Exact failure scenario:** a fully specified source pit receives a Read row. A locked output layer then causes insertion to skip it. X-Civil creates results from the PRE-insertion review rows; LandXML returns all parsed pits and pipes, including those skipped. Both commands convert every clean Read row into Recorded. Neither uses the created handles or actual placement outcomes. LandXML's result decision only looks for cancelled/aborted wording, so an ordinary locked-layer skip reaches the completion page.

   **DETERMINISTIC TEST:** fresh target with no earlier import; create and lock `STORMWATER PIT`, then set current layer 0. Import the single-pit XML below with its cover level present. Click Import to drawing. Assert there is no new pit block and the report says `Pits created:        0`. The window must list P11 as Not drawn or equivalent, explain the locked layer, and must not list it as Recorded. Current source lists P11, cover 12.00 m, Recorded, under `Import complete. Check the listed drawing items.` Repeat X-Civil using a recognised P11 source with a known cover. Also test one successful item and one skipped item, requiring different per-item outcomes.

   **Correction direction:** generate result rows from insertion results, with separate read, drawn, retained and skipped states. This is distinct from finding 1: it also fails on a fresh drawing where nothing was erased.

5. **MEDIUM — LandXML replacement uses the old import to decide the new coordinate offset. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/XcivilImportService.cs:1879`, `:1921`; compare the corrected X-Civil caller at `:694`. `Services/XcivilPitInsertionService.cs:806`, `:866`, `:878`; `Services/XcivilImportReportService.cs:604`.

   **What happens in AutoCAD:** the same new consultant network can land in different positions depending on where the previous import sits. CE measures the old pits and labels to decide the new location, then deletes those very objects. An earlier misplaced import can therefore move the replacement away from the base drawing.

   **Exact failure scenario:** the source is far away in survey coordinates, so the centre-based translation is triggered. The target contains local base linework and an earlier imported pit some distance away. LandXML calls `TryGetImportTargetExtents` without the exclusion list; null means include every measured model-space object. Its target centre includes the old import. X-Civil passes `CollectPreviousXcivilImportErasableIds` expressly to avoid this, but LandXML omits it. This is the call-site omission, not a new complaint about the general centre-alignment policy already covered by BUG-068.

   **DETERMINISTIC TEST:** create two targets. Target A contains only `RECTANG` from `0,0` to `10000,10000`. To prepare target B, first import a single P90 at easting/northing 50/50 metres into an empty drawing, then draw that identical rectangle; verify the old pit is at 50000,50000 mm. Use the same new XML in both: two 600 mm pits at E/N 400000/5800000 and 400010/5800000 metres. In A import normally; in B explicitly choose Replace. Record the pre-import extents of B and the post-import new pit insertion points in both targets. Assert A and B's corresponding new pit positions agree within 0.01 mm, and P90 is gone from B. Current source translates B towards the centre of rectangle-plus-P90-and-labels, roughly tens of metres away from A's placement. The exact failure oracle is the unequal insertion points, not the approximate distance. The two reports' `Translation applied:` lines will also differ. Restore identical defaults in both fixtures.

   **Correction direction:** use the same prospective-erasure exclusion as the X-Civil lane, retaining genuinely protected old objects in the measured target. Add a test through the LandXML caller; a unit test of the exclusion helper alone cannot catch an omitted argument.

6. **MEDIUM — a PDF schedule spanning multiple pages is reduced to one page. VERIFIED-BY-READING.**

   **File:line:** `Modules/tools/Extract-XcivilPdfSchedule.ps1:480`, `:485`, `:538`, `:685`, `:819`; consumer `Modules/Drainage/Services/XcivilScheduleService.cs:308`, `:347`, `:361`; application `Services/XcivilImportService.cs:733`.

   **What happens in AutoCAD:** pits or pipes listed on a continuation sheet lose their PDF sizes and levels. The helper can successfully read the PDF yet return only the first equally well-labelled schedule page. A later page with a higher header score replaces the earlier page instead of adding its rows.

   **Exact failure scenario:** two pages each have PIT SCHEDULE and the same complete column headings, with different pit rows. Equal header scores make page 2 hit `continue`; only page 1's `$scheduleRows` is parsed. Pipe schedules repeat the same selection pattern. Assignment uses the returned subset, so a missing continuation row is not a failed OCR row counted by the downstream pairing guard. This is independent of BUG-781's incorrect pairing after dropped rows and BUG-804's separate AI page limit.

   **DETERMINISTIC TEST:** synthetic two-page PDF with identical headings on both pages: PIT SCHEDULE; PIT No, TYPE, WIDTH, LENGTH, COVER, PIT DEPTH, COMMENT. Page 1 has P11 / GP / 600 / 600 / 12.00 / 1000 / GRATED PIT. Page 2 has P12 / GP / 900 / 900 / 13.00 / 1000 / GRATED PIT. Put a readable single-page PIPE SCHEDULE on page 1 as a separate positive control if needed. Supply a recognised X-Civil DWG with P11 and P12, no competing cover/size schedule text, and choose this PDF. Turn the optional AI fallback off in the isolated test profile. Run `CDIMPORTXCIVIL`, Read source; inspect the schedule and latest import debug log before accepting. Assert both named PDF rows are returned and P12's review shows cover 13.00 m. Current helper selects page 1 only when both header scores are 7; expect candidate log lines for pages 1 and 2 but one returned pit row. After acceptance, P12 must carry the supplied 900 x 900 mm size and 13.00 m cover, not a fallback.

   **Deterministic isolation of OCR:** for the later regression, replay fixed OCR results into `Invoke-PdfPageOcr` in a disposable test copy: each page has BitmapWidth 2400, BitmapHeight 1800, title at (100,100); the seven headings at Y=200 and X=100,400,700,1000,1300,1600,1900; its row at the same X positions and Y=400. These coordinates satisfy the helper's row and column windows. Assert the emitted JSON includes P11 and P12. For the native PDF run require logs showing both candidates with headerScore=7; otherwise report an OCR-fixture failure rather than attributing it to page selection. Repeat with two equally scored PIPE SCHEDULE pages and disjoint From/To pairs, requiring both pairs.

   **Correction direction:** collect schedule rows across continuation pages with page/row provenance and explicit duplicate handling. Do not choose one entire page as the complete document.

**Exact synthetic XML fixtures for the later tester**

1. **Single-pit fixture.** Save the following text outside all repositories as the named XML for the relevant test. Numbers are synthetic. P11 is a grated pit, not a control/detention pit.

```xml
<LandXML>
  <Units><Metric linearUnit="meter" /></Units>
  <PipeNetworks><PipeNetwork name="SYNTHETIC">
    <Structs>
      <Struct name="P11" desc="Grated pit" easting="10" northing="10" elevRim="12.00">
        <RectStruct width="0.6" length="0.6" />
      </Struct>
    </Structs>
  </PipeNetwork></PipeNetworks>
</LandXML>
```

2. **Named-invert fixture.** This intentionally uses the parser's accepted startRef/endRef spelling to isolate finding 3 from the separately registered BUG-719. It is a deterministic parser fixture, not a claim about the LandXML schema. A is deliberately incomplete; B is the remaining valid pipe.

```xml
<LandXML>
  <Units><Metric linearUnit="meter" /></Units>
  <PipeNetworks><PipeNetwork name="SYNTHETIC">
    <Structs>
      <Struct name="P31" desc="Grated pit" easting="10" northing="10" elevRim="12.00">
        <RectStruct width="0.6" length="0.6" />
        <Invert elev="9.75" refPipe="A" />
      </Struct>
      <Struct name="P32" desc="Grated pit" easting="20" northing="10" elevRim="12.00">
        <RectStruct width="0.6" length="0.6" />
        <Invert elev="9.50" refPipe="B" />
      </Struct>
    </Structs>
    <Pipes>
      <Pipe name="A" startRef="P31" endRef="P99">
        <CircPipe diameter="0.375" material="RCP" />
      </Pipe>
      <Pipe name="B" startRef="P31" endRef="P32">
        <CircPipe diameter="0.375" material="RCP" />
      </Pipe>
    </Pipes>
  </PipeNetwork></PipeNetworks>
</LandXML>
```

**Remaining scope — checked, excluded or unproven**

1. **Units and BUG-505 — not recounted.** `XcivilSourceUnitsCheck.cs:16` warns for guessed x1000 with source INSUNITS 0 or 4; x1000 with 6 is silent. Guessed x1 with 6 warns; x1 with 0 or 4 is silent. The helper warns but never changes scale. `XcivilImportService.cs:325` still applies the geometry guess. The command writes summary lines before opening the modal review, but its callback does not display `summary.Lines`. The bug register already explicitly records that hidden CHECK THE SCALE warning. Target metre/unitless handling and LandXML's per-pit heuristic are existing BUG-505/725. They remain open, not additional findings here.

2. **Cancel and missing files — bounded claims only.** Source Close/Escape returns before insertion. Replacement Abort/Escape returns before service cleanup. LandXML review cancellation returns the cancelled report; X-Civil normal review cancellation returns the pre-flight abort marker. Missing selected paths have explicit existence checks. Both commands nevertheless initialise/synchronise drawing records before their first window, the already-audited shared write-before-cancel family; no claim of a byte-identical drawing on those early exits. PDF-picker Cancel resolves to no PDF and continues towards review, not immediate import. No native cancellation or REDO test was performed.

3. **Malformed and huge inputs.** LandXML XML loading prohibits DTDs and disables external resolution (`LandXmlParser.cs:97`); malformed XML returns a parse failure before the replacement erase. Missing pit coordinates are reported and skipped, and missing referenced pits leave the pipe out. Unbounded whole-document loading and unrounded rim text are already BUG-729. Per-item insertion catches can retain earlier successful work; this audit proves the specific normal skip/partial replacement in finding 1, not every possible allocation failure or forced cancellation. Escape during synchronous reading, forced host cancellation and recovery from an interrupted partial import remain untested.

4. **Culture.** LandXML coordinate/dimension/invert parsing explicitly uses invariant culture. Under ordinary en-AU both that path and decimal-point source values agree. The PDF script's derived-invert parse/format at lines 575–577 uses the current culture, but no decimal-comma PC run was performed and no additional observed culture failure is claimed. Fixture tests must use decimal points and must record effective culture rather than assume it from the Windows display language.

5. **Other unproven boundaries.** X-Civil catches exceptions around its acceptance gate and proceeds (`XcivilImportService.cs:889`), unlike LandXML's fail-closed acceptance helper. Without a reproducible normal-user trigger this is not a seventh finding. The LandXML schedule tab header is bound to IsXcivil; whether programmatic selection still displays its content needs a real WPF/AutoCAD check, so no hidden-content defect is asserted. Actual latency, huge-file memory limits, cross-release native exceptions and complete Undo/Redo behaviour remain unknown.

**Summary — under 100 words**

Six new faults were proven by reading: replacement can erase a pit it cannot redraw; changing source during review can import the old file; a named invert can reach the wrong pipe; skipped items appear Recorded; LandXML replacement offsets include soon-to-be-erased geometry; and multi-page PDF schedules lose continuation rows. Prioritise the three HIGH findings and test the real command-to-window-to-drawing path. Existing units and other registered defects were excluded. No build, tests or AutoCAD session ran. Only this report was authored; nothing is fixed or accepted.
