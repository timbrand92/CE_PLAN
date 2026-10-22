**ANSWER FIRST — S16 Manager and Shared — 23 October 2026, Melbourne**

1. **Counts: HIGH 0 / MEDIUM 2 / LOW 1.** Three findings verified by reading the installed release's source. No AutoCAD test was run; the tests below are specifications for the test lane, not claimed passes or observed failures.

2. **Most important: a Manager button can feed its command name into the command already running.** Clicking Open Repair while AutoCAD is asking for a point does not reliably open Repair. At a text-entry prompt, the same mistake can put `CDREPAIR` into the drawing as text. The ribbon has a safeguard for this; these Manager buttons do not.

3. **The other two faults.** One missing Structural palette file prevents even the healthy Civil blocks from opening. New job drawing confuses paper size with drawing number: it learns names ending C01 and C02, then suggests a name ending A3.

4. **Scope respected.** Every one of the 183 nominated files was read. No plugin files, settings or drawings were changed; no build, test, AutoCAD session, installation or sub-agent was started. Manager administrator work remains parked. This report does not reopen the already-audited release problems or change the Civil + Manager handover date of 9 November.

---

1. **Technical evidence and coverage.** Source repository: `C:\Lisp Files\CE_ACAD_PLUGIN`. Fetched origin and read Git objects, using `git show origin/claude/rel-20261022m:<path>` for the nominated files. The audited commit is `40ee0a36f7960145743954b39859eb6c3af92869`, the supplied Civil 3.0.70 / Manager 1.1.70 release. All source line numbers below refer to that commit, not the working checkout. No claim is made about later fixes or actual loaded DLL bytes.

   The 183-file coverage comprises 101 Manager files, 60 CE_SHARED files, three CE.Diagnostics files, one CE.Release file, eleven CE.Spine files and seven CE.Spine.Tests files. Reading began with the largest central files: OfficialReleaseGate, the Manager window, approval/staging/installer services, SensitiveDataGuard, plugin registry and RibbonBuilder. The full files were read, including the small contracts, XAML, helpers and nominated tests. Additional Git reads followed production callers and the relevant existing tests. Structural's separate release was not needed to establish these findings.

2. **Earlier reports and evidence labels.** Checked against `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_GATE_22OCT.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`, and the available `CODEX_HUNT_MANAGER_22OCT.md` and `CODEX_HUNT_PRIVACY_22OCT.md`. Their findings are not counted again. VERIFIED-BY-READING means the failure path is present in the pinned code; the described native result still requires the specified AutoCAD run. No SUSPECTED item is included in the three-findings count. Potential library problems without an established installed-user route were excluded.

3. **F1 — MEDIUM — Manager sends command names into an unfinished AutoCAD prompt. VERIFIED-BY-READING.**

   **File:line:** `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:894` and `:899`; button caller `:534`; `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:149`. Related affected doorway: `Modules/Manager/Services/CeBlocksPaletteService.cs:44` and `:46`.

   **What happens in AutoCAD:** a drafter leaves CE Manager open, starts a drawing command, then clicks Open Repair. AutoCAD receives the word `CDREPAIR` as the answer to its current question. Repair is not started at the intended command boundary. A point prompt rejects the word; a text prompt can accept it as drawing content. Clicking a CE Blocks item has the same missing command-boundary protection for `CEBLOCKINSERT`.

   **Exact failure scenario and proof:** Manager is shown modelessly (`PluginManagerCommands.cs:45` to `:49`). Open Repair remains enabled according to whether Civil is loaded and declares a repair command, with no busy-command condition (`CePluginDescriptor.cs:196`; `PluginManagerWindowViewModel.cs:157`). Civil's repair command is assigned `CDREPAIR` (`CePluginRegistryService.cs:587`). The click calls `SendCommand`, which sends only the command name plus a newline, with no active-command check, cancellation prefix or deferred-until-idle queue. Its exception handler also suppresses dispatch errors. The shared ribbon already explicitly addresses this exact native input issue: `Shared/CE_SHARED/Services/RibbonBuilder.cs:24` to `:29` constructs two cancels when a command is active, and `:704` uses it. That corrected ribbon route is not the finding; the remaining Manager and Blocks routes are.

   **DETERMINISTIC TEST — fixture:** a fresh synthetic millimetre model-space drawing in AutoCAD 2027 with the nominated Civil and Manager pair loaded, unlocked current layer 0, world UCS and no other drawing command running. Type `CEMANAGER`, select the Civil module on Status, and confirm Open Repair is enabled. Keep the modeless window beside the drawing.

   **Typed/click steps:** return focus to AutoCAD; type `_.LINE`, then `0,0`. While the next-point prompt is active, click **Open Repair** in Manager. Capture the command history before pressing Escape.

   **Assertion:** the click must reach the Repair command, or remain pending with an explicit explanation until LINE finishes; `CDREPAIR` must not be consumed as a point answer. The present code predicts a rejected point input and no new Repair view. As a control, finish LINE with Escape and click the same button at an idle command line; Repair should open. This compares the same loaded module and same button, changing only the native prompt state.

   **Drawing-value variant:** on another fresh copy, use a non-annotative Standard text style with fixed height 0. With Manager already open, type `_.-TEXT`, insertion `0,0`, height `2.5`, rotation `0`. At the text-content prompt click **Open Repair**, then finish the text command with Escape. Inspect the resulting TEXT entities in Properties. Assert no entity has TextString `CDREPAIR` as a consequence of the click. The source predicts that literal content can be inserted. This native manifestation is unrun, not a claimed observation.

   **Correction direction:** route these modeless launches through a single command dispatcher that establishes the intended native command boundary. Reuse the already-reviewed ribbon rule where interruption is intended; otherwise defer the requested action visibly. Do not treat successful queueing of characters as proof that the CE command executed.

4. **F2 — MEDIUM — one unavailable palette export removes every CE Blocks tab. VERIFIED-BY-READING.**

   **File:line:** `Modules/Manager/Services/CeBlocksCatalog.cs:39`, `:47` and `:50`; `Modules/Manager/Services/CeBlocksPaletteService.cs:23` to `:27`.

   **What happens in AutoCAD:** Civil blocks can be fully available on the colleague's PC, but one missing or damaged export from another discipline stops CE Blocks opening altogether. A partial OneDrive sync of `STEEL.xtp`, for example, also takes away the Civil and Common blocks.

   **Exact failure scenario and proof:** Read iterates twelve fixed filenames and calls `XDocument.Load` without a per-file recovery boundary. A missing ninth file, `STEEL.xtp`, throws after the earlier groups have been read. The accumulated groups are never returned. Show catches that exception, prints `CE Blocks palette files are unavailable: ` followed by the error, then returns before constructing or showing the palette. The separate missing-source-drawing message at line 29 is never reached. This is not a claim that an actually missing block can be inserted; the defect is discarding healthy, unrelated groups. If a palette was already visible, this path leaves its old contents in place; the deterministic case below starts with no visible palette.

   **DETERMINISTIC TEST — fixture:** use an isolated test profile and a synthetic folder outside all repositories. Prepare the twelve named exports: `BLOCKS CIVIL.xtp`, `BLOCK CIVIL 2.xtp`, `FRAMING.xtp`, `GROUND.xtp`, `HATCHES.xtp`, `LABELS CIVIL.xtp`, `NOTES.xtp`, `SCHED.xtp`, `STEEL.xtp`, `TEXT.xtp`, `TIMBER.xtp`, `WALLS.xtp`. Each must parse through the actual catalogue reader. Empty groups may use this minimal shape:

   ```xml
   <Root><PaletteContent><Palette>
     <Properties><ItemName>S16 fixture</ItemName></Properties>
     <Tools />
   </Palette></PaletteContent></Root>
   ```

   In `BLOCKS CIVIL.xtp`, replace `Tools` with the following. The source drawing contains a block named `S16_PROBE`, consisting of one 100 mm line on layer 0, and no external references. No image file is required.

   ```xml
   <Tools><Tool>
     <ItemID idValue="S16-PROBE" />
     <ToolType>1</ToolType>
     <Properties><ItemName>S16 Probe</ItemName></Properties>
     <Data>
       <Block>
         <BlockName>S16_PROBE</BlockName>
         <SourceFile>C:\S16_FIXTURE\office.dwg</SourceFile>
         <Scale>1</Scale><Rotation>0</Rotation>
         <PromptRotation>0</PromptRotation><Explode>0</Explode>
       </Block>
       <GeneralProperties><Layer><BasicPropInfo>
         <PropValue value="0" />
       </BasicPropInfo></Layer></GeneralProperties>
     </Data>
   </Tool></Tools>
   ```

   **Typed/click steps:** in the isolated profile, use `CEMANAGER` > Settings > Manager, set **Palette folder** to the synthetic export folder and **Office block drawing** to `C:\S16_FIXTURE\office.dwg`, then click **Save CE Blocks folders**. With all twelve exports present, type `CEBLOCKS`; assert **S16 Probe** appears in the Civil tab. Close the palette. Rename only the fixture's `STEEL.xtp` to `STEEL.xtp.hold`; type `CEBLOCKS` again. Restore it and repeat as the control. A second independent run can replace only STEEL's contents with malformed XML.

   **Assertion:** the available Civil tool must remain accessible, with a warning confined to the unavailable group. The present code predicts the command-line prefix `CE Blocks palette files are unavailable:` and no reopening of the palette in the missing-file run; restoring the single file allows it to reopen. No source DWG or Civil export has changed between runs.

   **Why the existing test misses it:** `Modules/Manager.Tests/Services/CeBlocksCatalogTests.cs:22` reads the complete office set and expects twelve groups. Its missing-source test at `:50` exercises only MissingSourceMessage for a DWG, not partial failure of the XTP collection. Those are distinct input paths.

   **Correction direction:** retain healthy groups when an individual export fails, and report which group could not be read. Do not require a colleague using Civil to have every Structural export available before showing any Civil tools.

5. **F3 — LOW — the shared new-drawing planner substitutes paper size for drawing number. VERIFIED-BY-READING.**

   **File:line:** `Shared/CE_SHARED/Services/NewJobDrawingPlanBuilder.cs:105` to `:106`; `Shared/CE_SHARED/Services/JobDrawingNamingPatternService.cs:182` to `:190` and `:294` to `:295`.

   **What happens in AutoCAD:** in a job whose drawings are named `99-001 Civil C01.dwg` and `99-001 Civil C02.dwg`, New job drawing says it learned the naming pattern but suggests `99-001 Civil A3.dwg`. A3 is the chosen paper size, not the next drawing's identity. A drafter can correct the visible filename, so this is LOW rather than a silent data-loss finding.

   **Exact failure scenario and proof:** Build has a `sheetSize` argument used correctly for template selection, then passes that same argument into SuggestFileName's `sheetCode` parameter. The naming service classifies C01/C02 as Sheet tokens and substitutes the supplied A3. The live AutoCAD 2027 route reaches this composition through `Modules/Drainage/Commands/NewJobDrawingCommand.cs:56` and `Modules/Drainage/Dialogs/NewJobDrawingDialog.xaml.cs:127` to `:128`. The latter supplies SelectedSheetSize and has no independent sheet-number input. The result is shown in File name with the confident `Learned from 2 of the 2 existing drawing name(s) in this job.` message. This is an argument-meaning error in the nominated shared planner, not a request for a different naming style.

   **DETERMINISTIC TEST — fixture:** AutoCAD 2027 with the nominated Civil/Manager pair; synthetic folder `C:\S16_FIXTURE\99-001` containing exactly two ordinary DWGs named `99-001 Civil C01.dwg` and `99-001 Civil C02.dwg`, with no job-record file. The isolated profile's office templates folder contains a valid `Civil A3.dwg` template. Open the C01 fixture; the bare folder name 99-001 is recognised by the existing job-folder rule.

   **Typed/click steps:** type `CDNEWDWG`. In **New job drawing**, confirm Job folder is the fixture folder, Discipline is Civil and Sheet size is A3. Read **File name** and its explanation without editing them. Cancel after recording those two window values; no drawing needs to be created to prove this fault.

   **Assertion:** a name described as learned from C01/C02 must not replace that drawing-code slot with A3 merely because A3 paper was selected. If the next drawing number is unknown, the window must ask for it or describe that part as unresolved. The pinned code predicts File name `99-001 Civil A3.dwg` alongside the learned-from-two explanation. The test does not demand automatic C03 numbering; it demands separation of drawing identity and paper size.

   **Why the existing test misses it:** `Modules/Drainage.Tests/Services/NewJobDrawingPlanBuilderTests.cs:15` supplies the same C01/C02-versus-A3 combination, but at `:25` checks only that the suggested name ends in `.dwg`. It does not assert the drawing-code portion. Reading that test is not a claim that it was run in this audit.

   **Correction direction:** pass paper size only to template selection. Supply a separately chosen drawing code to naming, or explicitly leave that decision unresolved. Retain the editable filename and existing-file protection.

6. **Summary.** Three additional faults were found across all 183 nominated files: two MEDIUM and one LOW. Prioritise Manager's command dispatch because a button can answer the wrong native prompt and can become drawing text. Preserve healthy CE Blocks groups when one export is unavailable. Separate paper size from drawing number in the shared new-drawing planner. All three are verified by reading; their deterministic AutoCAD checks remain unrun. Only this findings file was authored.
