1. **ANSWER FIRST — HIGH 1 / MEDIUM 4 / LOW 1.** Six new findings, all SURE / verified-by-reading. No AutoCAD test was run. The most important: AutoCAD 2022–2024 refuses a downpipe placed directly on a valid pit because it requires a component supplied only for AutoCAD 2027.

2. **Top three.** A valid downpipe-to-pit placement is blocked; the pipe and pit editors lose their real drawing previews and picture selection; restoring an unloaded Civil menu reports success without loading it again.

3. **What the office loses.** Older AutoCAD also loses the tank selection window and council-source viewer. Its markup file picker offers PDFs that it cannot open. Some omissions are explicit choices in the code; this audit records their practical effect rather than claiming every difference is an accidental regression.

4. **Outcome.** These are findings for the builders and later AI test lane, not requests for Tim to test. Civil + Manager on 9 November remains the priority. Manager administrator work remains parked. Only this report is changed; no plugin change, build, installation or test was made.

---

1. **Scope and pinned sources — 24 October 2026, Melbourne.** Read RULES.md, ROUTER.md, the CE_PLAN start/map, the specified earlier audits and BUG_CARPARK.md. Fetched origin, then used a detached, unmodified worktree at `C:\ce-cx\rd21`. No branch was created. Source reads used Git objects, not the main checkout's unsaved files.

   Civil/Manager: `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, source versions 3.0.72 / 1.1.72. Structural: `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9`, source version 1.0.122. The newer AREA refs govern this hunt, rather than the older refs in the introductory brief. Installed DLL identity was not measured.

2. **Earlier work and duplicate control.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md`, `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md` and `CODEX_HUNT_COMPAT_22OCT.md`. Searched the carpark before source review and again by candidate command, class, symptom and older-year terms. No existing matching entry was found for the six findings below. Known items are not counted again.

   **Known references only:** BUG-001, BUG-375, BUG-486, BUG-526, BUG-528, BUG-594, BUG-1029.

3. **Evidence and test conditions.** SURE / verified-by-reading proves the exclusion or control flow at the pinned source, not successful loading or observed screen behaviour. Every DETERMINISTIC TEST below is NOT RUN. Use separate disposable AutoCAD 2022, 2023 and 2024 profiles with the corresponding Legacy package, then a separate 2027 Modern control. Do not treat one year's result as all three years passing. Use synthetic drawings, metric units, isolated Settings and ordinary trust controls. No client files are needed.

4. **Severity.** HIGH means an ordinary supported drawing action is unavailable with no same-action recovery on that lane. MEDIUM means a useful daily workflow or recovery action is missing or misleading. LOW means a selectable route always fails but gives an actionable alternative. No new engineering value or hard block is proposed; R-00 and R-27 remain authoritative.

---

1. **RD21-01 — HIGH — a downpipe cannot be placed directly on a valid pit on AutoCAD 2022–2024. SURE / verified-by-reading.**

   **File:line:** Civil `Modules/Drainage/Services/SourceCloneMapNativeBridge.cs:35`, `:36`, `:48`, `:185`, `:226`; `Services/LinkService.cs:1598`; `Services/LinkService.SourceLanding.cs:457`; `Rules/SourceLanding.cs:114`; `Services/SourcePlacementService.cs:1579`; `Services/BlockService.cs:959`. Paths without the module prefix in this finding are relative to `Modules/Drainage`.

   **What happens in AutoCAD:** A drafter has one properly recorded pit P1 and picks its centre to place DP1. CE refuses the point and asks for another pick. Moving away can place an unjoined downpipe, but it cannot achieve the requested direct pit connection. This affects the placement path, even though the drafter has not used COPY.

   **Exact failure scenario:** On net48, native registration always calls `ledger.Disable("Exact source COPY receipts are unavailable on this AutoCAD version.")` and returns null. Disabled ledgers always return an empty SessionIdentity. The landing reader passes `pitAssociationReady: false` for an otherwise unambiguous pit. The rule returns AssociationRequired, which the preview converts to Refused; BlockService rejects the final pick. The native component used by the other branch is `CE_TRANSFORM_2027.arx`. This is a deterministic lane dependency, not a hypothesised DLL loading failure.

   **DETERMINISTIC TEST — fixture:** A blank Civil drawing in millimetres, World UCS, with one native CE pit P1 centred at `0,0,0`, 600 mm square, cover RL 20.000 m and bottom RL 19.000 m. Its pit identity and project row must agree. No pipes, other sources or overlapping objects; required source blocks available and relevant layers unlocked. Confirm ordinary DP placement works at a clear point in a separate control copy.

   **Typed steps and assertion:** Open the P1-only copy; type `DP`; at “Specify downpipe insertion point:” enter `0,0,0`. Capture the command history, then Esc. The predicted CE log line is exactly `[Source] The pick was refused: Source-to-pit placement is unavailable: Exact source COPY receipts are unavailable on this AutoCAD version.` Assert no new downpipe block or source record exists. On the 2027 control with the matching native component loaded, the same point must reach accepted joined placement. A corrected older lane must allow that same placement, retain P1's identity, and support one Undo/Redo without corrupting either record. A different refusal means the fixture has not reached this case.

   **Smallest fix:** Decouple ordinary source-to-pit placement from the 2027-only COPY session, using an older-lane association mechanism that also preserves identity through later copy operations. Do not merely force the readiness Boolean to true: the apply path checks the session again at `LinkService.SourceLanding.cs:497`. Route this protected change to its owner and retain identity checks. The current blanket refusal is outside Tim's two R-27 exceptions.

2. **RD21-02 — MEDIUM — Edit Pipe and Edit Pit lose the real plan and picture selection on the older lane. SURE / verified-by-reading.**

   **File:line:** Civil `Modules/Drainage/Dialogs/PipeOnePageLayout.cs:241`, `:244`, `:251`; `Dialogs/PitOnePageLayout.cs:96`, `:101`, `:102`; `Dialogs/PipeEditWorkshopDialog.xaml.cs:95`; `Dialogs/PitEditWorkshopDialog.xaml.cs:47`; `Commands/PipeEditCommand.Update.cs:58`; `Commands/PitEditCommand.cs:235`. The real preview classes, including `Controls/CdPlanPreviewControl.cs:1` and `Controls/PitBlockPreviewControl.cs:1`, are entirely under the same NET10 guard.

   **What happens in AutoCAD:** Editing a bent pipe shows a generic diagram instead of its real route. Editing a pit shows a schematic instead of the actual block and connected-pipe picture. A drafter cannot click the real pipe end to reach its level box, or click a pipe tag in the pit picture to select that connection. The numerical editors still exist.

   **Exact failure scenario:** Both production workshop windows call these layouts on net48. The pipe layout retains its schematic because the entire real-plan replacement and EndPicked handler are omitted. The pit layout explicitly builds CePitPreviewControl instead of PitBlockPreviewControl; the PipePicked handler exists only in the omitted branch. This is not a missing PlanAnchor in the fixture: the command supplies it on both lanes.

   **DETERMINISTIC TEST — fixture:** A valid CE network in a millimetre drawing: P1 at `0,0`, P2 at `10000,5000`, and a bent 225 mm pipe routed through `10000,0`, with distinct end inverts 19.000 m and 18.850 m. Use the one-page workshop presentation and a 1920 × 1080 display at 100% scaling, so a size fallback cannot mask the comparison.

   **Typed steps and assertion:** Type `PIPEEDIT`, select that pipe and inspect PLAN PREVIEW. The 2027 control shows the actual bent route and the sentence beginning “Real plan, north up.” Click an end ring: keyboard focus must enter that end's level box. Cancel. Type `PITEDIT`, select P1 and click the connected pipe tag in the picture: its connection row must become selected. On net48 the actual-route caption and controls are absent and those picture actions cannot be completed. Record the window text, focus/selection and screenshots; Cancel must leave the drawing values unchanged.

   **Smallest fix:** Make the existing plan controls/renderers and their click handlers available to net48, adapting only actual framework/API differences. Keep the schematic for genuinely unavailable drawing evidence. Do not invent replacement engineering values or a separate editor layout.

3. **RD21-03 — MEDIUM — CDMENU says the Civil menu is loaded after the menu has been unloaded, but does no recovery. SURE / verified-by-reading.**

   **File:line:** Civil `Modules/Drainage/Services/WorkspaceMenuInstallerService.cs:30`, `:35`, `:127`; `Services/StandaloneCivilRibbonService.cs:34`; `Commands/HubCommands.cs:780`, `:790`; `Dialogs/CdRepairDialog.xaml.cs:45`, `:53`.

   **What happens in AutoCAD:** The Civil menu disappears after the drafter unloads its partial menu. Typing CDMENU prints a successful result, but the menu stays absent. “Restore CE Civil Tools” in Repair uses the same ineffective route; its older-year status tests whether the menu file exists, not whether AutoCAD has loaded it.

   **Exact failure scenario:** A successful initial load sets the static `_installed` flag. Every later EnsureInstalledAndLoaded returns true immediately while that flag is set. RequestRebuild on net48 calls this method without invalidating the flag or checking the loaded menu groups. The modern branch has a separate rebuild path. This finding concerns reloading a previously loaded menu, not the known missing menu entries.

   **DETERMINISTIC TEST — fixture:** AutoCAD 2024 with Civil's partial menu initially loaded and auto-install enabled; synthetic blank drawing. First type CDMENU and record its successful status. Type `CUILOAD`, select the loaded group `CE_CVL_SUITE_MENU`, click Unload, then Close. Confirm the group is absent by reopening CUILOAD; close it again.

   **Typed steps and assertion:** Type `CDMENU`. Current source predicts `[CE] The Civil menu is loaded. If it is still hidden, restart AutoCAD.` Reopen CUILOAD and assert the group remains absent: this is the false-success result. A corrected command must restore that exact group in the same session. Repeat through `CDREPAIR` > “Restore CE Civil Tools”; “Installed menu: OK” alone is not a pass. Repeat on 2022/2023 separately.

   **Smallest fix:** Give the explicit restore action a force/recheck path that verifies the actual loaded group and reloads it when missing. Preserve the startup optimisation that avoids reloading a menu on every document activation. Only report loaded after checking that outcome.

4. **RD21-04 — MEDIUM — CDWT loses both tank-selection pictures and the first window on AutoCAD 2022–2024. SURE / verified-by-reading.**

   **File:line:** Civil `Modules/Drainage/CE_CVL_SUITE.csproj:269`, `:272`, `:275`; `Commands/WaterTankCommand.cs:92`, `:99`, `:333`, `:425`, `:436`, `:562`, `:614`.

   **What happens in AutoCAD:** Instead of seeing the Water tank window with the tank choices and plan picture, the drafter answers a succession of command-line questions. Where the library does not already name a plan block, the drafter chooses from text names without the plan pictures available on 2027. This removes the requested “window comes first” workflow; it does not mean all tank placement is impossible.

   **Exact failure scenario:** The older build removes both WaterTankDialog and WaterTankPlanBlockPickerDialog. TryChooseTankInWindow unconditionally returns WindowUnavailable, and TryChoosePlanBlock uses keywords. Valid master drawings and settings do not enable either window on this lane. The project comments explicitly preserve the old prompts, so this is a deliberate compatibility gap, not an unexplained window crash.

   **DETERMINISTIC TEST — fixture:** Isolated Civil Standard Details setting pointing to a synthetic master named `CE Civil WATER TANK PLANS & DIAGRAMS Details.dwg`. Put two distinct named plan blocks in model space, one round and one rectangular, with all normal CDWT resources available. Give the test tank no recorded PlanBlockName so the separate picker must be reached. Use the identical fixture and tank catalogue on both lanes.

   **Typed steps and assertion:** Type `CDWT`. On 2027 the first selection surface must be the window titled “Creative Engineering | Water tank”. On net48 the first choice is the command-line sentence “Water tank: Adopt a block already in the drawing, or Insert a plan block from the office master?” Choose Insert, then typed capacity 4500 L and detention 1000 L where asked. At the plan-block choice, assert that the two shapes are presented as text choices with no picture picker. Cancel before placing anything. The corrected lane must offer the existing window and both plan pictures before an insertion point is accepted; Cancel leaves no tank.

   **Smallest fix:** Port the existing two WPF windows and their supporting preview/choice classes to net48 and remove their conditional exclusions once compatible. Keep command-line fallback for an actual window-opening failure. Do not change capacities or add new engineering defaults.

5. **RD21-05 — MEDIUM — older AutoCAD cannot open the council evidence behind a current value or saved rule finding. SURE / verified-by-reading.**

   **File:line:** Civil `Modules/Drainage/Commands/RulebookCommand.cs:43`, `:70`, `:96`; `Commands/RulesCommand.cs:49`, `:61`, `:134`; `CE_CVL_SUITE.csproj:269`, `:270`; `ViewModels/CouncilSourceViewModel.cs:1`; `Services/CouncilSourcePageRenderer.cs:1`.

   **What happens in AutoCAD:** A colleague can see the rule values and run checks, but cannot use the Source route to inspect the council evidence or the retained evidence for a previous check. Opening the same drawing in 2027 provides that route. The older-year menu does not explain why Source has vanished.

   **Exact failure scenario:** Both the Source keyword and its handler are conditionally omitted from CDRULEBOOK and CDRULES. The source window, model and renderer are omitted too. Values/Explain do not call the saved-finding source viewer. The missing route is proved without assuming that a PDF renderer could simply be loaded into net48.

   **DETERMINISTIC TEST — fixture:** A synthetic drawing with a valid configured council profile and one saved rule-check finding whose source page and retained evidence open successfully in the 2027 control. Use the same drawing and readable synthetic evidence files in the older-year profile.

   **Typed steps and assertion:** Type `CDRULEBOOK`; capture the listed choices, type `Source`, then Esc. Type `CDRULES`; repeat. On net48 neither list includes Source and neither opens the council-source window. On 2027 CDRULEBOOK Source opens the current profile's evidence; CDRULES Source offers the recorded check/finding and then its retained evidence. Corrected older-year behaviour must preserve read-only access and leave saved check counts and engineering values unchanged.

   **Smallest fix:** Keep Source registered on every supported lane. If the exact PDF renderer cannot be shared, provide a read-only fallback showing the retained source text, file/page reference and an explicit open-source action, with a clear statement that the in-window PDF picture is unavailable. Never substitute today's values for a saved finding's evidence or rerun the check to answer this request.

6. **RD21-06 — LOW — the older-year markup picker offers PDF files that it will always reject. SURE / verified-by-reading.**

   **File:line:** Civil `Modules/Drainage/Services/MarkupFileImageLoader.cs:40`, `:68`, `:203`, `:212`; `Controls/CeAssistantControl.xaml.cs:322`, `:332`, `:349`; `Controls/CeAssistantControl.xaml:162`.

   **What happens in AutoCAD:** A drafter clicks From file, sees PDFs explicitly offered, selects a valid redline PDF and receives “PDF support requires AutoCAD 2025 or later.” The file never reaches markup analysis. PNG/JPG remains available. This is an unusable advertised choice, rather than a general claim that markup analysis fails on net48.

   **Exact failure scenario:** FileDialogFilter is unconditional and includes PDF in both the combined filter and its own PDF filter. LoadAsync routes every .pdf to LoadPdfFileAsync; the net48 implementation always returns Failure. The assistant propagates that error before calling AnalyzeImagesAsync.

   **DETERMINISTIC TEST — fixture:** A one-page synthetic redline PDF and an equivalent PNG. Use an isolated profile with the existing AI master switch and normal access checks already passing, so the test can reach the picker. No real job content. Stop after the local file-loading result; do not require an external AI response to establish this fault.

   **Typed steps and assertion:** Type `CDASK`, click “From file…”, choose the PDF filter and the synthetic PDF. Assert the assistant displays the sentence beginning “PDF support requires AutoCAD 2025 or later.” and produces no analysis from that file. The corrected picker must identify image-only support before selection and omit the PDF-specific filter on net48. The existing rejection can remain for a PDF manually supplied through All files. A future PDF backport would instead need to prove valid page loading on all three older hosts.

   **Smallest fix:** Make the picker filter and adjacent guidance match the compiled lane; offer PNG/JPG on net48. This fixes the false offer but does not claim PDF feature parity. Adding a compatible PDF reader is separate work.

---

1. **Other lane differences checked, not counted as new defects.** Civil/Manager's net48 ribbon builders defer to their older menu routes; contextual ribbon consumers are excluded. CDNEWDWG is explicitly advertised as 2027-only and is covered by the known-reference list. CDHELP has an external-browser fallback; absence of its embedded browser alone is not a loss of all help. STORM/council-letter reading and X-Civil vision extraction have explicit older-lane exclusions. No additional duplicate finding is assigned to those paths here.

2. **Structural boundary.** Read the nominated Structural head, not the Structural directory at the Civil head. `Services/FootingGripOverrule.cs:48` and `Services/StructuralFrameGripOverrule.cs:61` omit CE grip registration below net10. `Services/DrawingIntelligence/ArchitecturalChangeReviewCommandRunner.cs:62` returns its 2027-required message on older lanes; `Services/RibbonCommandHubService.cs:599` disables CEARCHREVIEW with an explanatory tooltip. These explicit capability limits were identified; no separate new corruption or misleading enabled-ribbon finding was proved. Ordinary AutoCAD grips are not proved absent.

3. **What I did NOT check.** No builds, unit tests, off-screen renders, native AutoCAD sessions, installations, live Settings, installed file hashes, actual 2022/2023/2024 assembly binding, API execution or loader ordering. No proof of 2027 success beyond the source's available path; each positive control remains owed. No complete audit of every command, third-party dependency, long path, plotting result, Undo/Redo sequence or security boundary. Manager administrator work was not pursued. No sub-agents were used.

4. **Handoff and undo.** The six tests are reproducible instructions for the later AI test lane, all NOT RUN. No item is fixed or accepted. Only this report is to be committed by name in CE_PLAN; the temporary detached worktree is removed after checking it is clean. Undo of this deliverable is a subsequent report-only revert. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md are untouched.

5. **Summary.** Six source-proven findings: older AutoCAD blocks a valid source-to-pit placement, loses interactive real-plan previews, falsely reports menu recovery, omits tank-selection windows and council-source access, and offers unsupported markup PDFs. Counts: one HIGH, four MEDIUM, one LOW. Known issues were excluded. The report distinguishes deliberate capability omissions from faulty control flow. All AutoCAD checks remain unrun; no code, setting, installed bundle or bug status changed.
