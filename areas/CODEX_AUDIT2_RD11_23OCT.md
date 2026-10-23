**ANSWER FIRST — RD11: remaining window wording, 23 October 2026, Melbourne**

1. **Eight NEW findings: HIGH 0 / MEDIUM 7 / LOW 1.** All eight are SURE, verified-by-reading. None was run or seen in AutoCAD during this hunt. Previously recorded faults are excluded from these counts.

2. **Most important: Structural Settings gives two different answers about saving.** It says “CE never saves” but offers “Also autosave Civil-only drawings”. That tick concerns backup copies of already-saved drawings. A drafter could reasonably mistake it for protection of their unsaved changes.

3. **Second: an unreadable saved markup review gets an unusable explanation.** The command says “Failed to deserialize package.” It should say that CE cannot read the saved review and tell the drafter to choose another copy.

4. **Third: Manager hides software words in hover text.** Its main warning is plain, but hovering over it reveals words such as “bridge payload is incomplete”. Hover text is still something the drafter reads.

5. **What happens next.** The testing lane can use the exact checks below after the wording is changed. Tim is not being asked to test. No engineering values or drawing behaviour need changing for these wording fixes.

---

**Technical scope and evidence**

1. **Pinned source.** Fetched origin in `C:\Lisp Files\CE_ACAD_PLUGIN`. Civil/Manager: `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (source versions Civil 3.0.72 / Manager 1.1.72). Structural: `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9` (source version 1.0.122). These are Git identities, not a fresh inspection of installed DLLs. The later AREA references in the brief take precedence over its introductory 22 October references.

2. **Method.** Read RULES.md, ROUTER.md, the plan start/map, `AUDIT_UI_WORDING_2026-10-22.md`, `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the Civil, Structural and Gate `CODEX_AUDIT_*_22OCT.md` reports. Searched BUG_CARPARK first and again against candidate phrases, commands and files. Read source with `git grep` and `git show` from the detached worktree `C:\ce-cx\rd11`; Structural was read at its separate reference, not from the Civil tree's Structural copy. The clean worktree was removed. No branch or code-repository commit was made.

3. **Evidence meaning.** SURE means the displayed string and its route are established by source. It does not mean a native test passed. All deterministic tests below are proposed, NOT EXECUTED. Use synthetic drawings and an isolated test profile; repeat window/message checks in AutoCAD 2024 and 2027. No fixture was created during this hunt. MEDIUM means wording obscures an action, recovery or choice; LOW means an exposed software term with little immediate drafting consequence.

4. **Known findings excluded — BUG numbers only.** BUG-523; BUG-524; BUG-913; BUG-914; BUG-917; BUG-919; BUG-923; BUG-925; BUG-926; BUG-927; BUG-928; BUG-929; BUG-930; BUG-931; BUG-932; BUG-934; BUG-935; BUG-936; BUG-937; BUG-938; BUG-939; BUG-940; BUG-941; BUG-942; BUG-943; BUG-944; BUG-945; BUG-989; BUG-1024; BUG-1032; BUG-1033.

**Ranked new findings**

1. **RD11-01 — MEDIUM — SURE, verified-by-reading: a backup tick still promises autosave.**

   **File:line:** Structural `Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml:556`, `:576`, `:577`; setting binding `UI/Dialogs/CeSettingsDialog.xaml.cs:184`, `:399`; behaviour `Services/DrawingAutoSaveService.cs:603`, `:1112`, `:1292`.

   **What a drafter sees / exact scenario:** Type CESETTINGS, open System > Saving and diagnostics. The bold note says “CE never saves; AutoCAD's own automatic save still runs.” The tick says “Also autosave Civil-only drawings”; the line below describes Structural's backup copies. This contradicts the meaning of the tick on the same page. The idle loop no longer calls the timed save, and the backup writer copies the saved DWG bytes. This finding is the misleading label, not a claim that CE should start saving automatically.

   **Smallest fix:** Change the tick to “Also keep backup copies of Civil-only drawings”. Change its explanation to “Copies the last saved drawing only. Unsaved changes are not included.” Preserve the saved setting name and behaviour.

   **DETERMINISTIC TEST:** Fixture: any empty synthetic metric drawing with Structural loaded and a test settings profile. Type `CESETTINGS`; click **System**, then **Saving and diagnostics**. Assert the checkbox text is exactly “Also keep backup copies of Civil-only drawings”, and its explanation states that unsaved changes are excluded. Assert no checkbox on this page promises “autosave”. Cancel. The audited XAML fails the wording assertion without needing any drawing change or waiting for a timer.

2. **RD11-02 — MEDIUM — SURE, verified-by-reading: opening a damaged markup review says “deserialize”.**

   **File:line:** Structural `Modules/Structural/Services/MarkupAIWorkflowService.cs:102`, `:104`; file reader `Services/MarkupAIStorageService.cs:66`; command and output `Commands/MarkupAICommands.cs:113`, `:139`, `:151`.

   **What a drafter sees / exact scenario:** A saved markup review exists but is unreadable. `CEMARKUPLOAD` accepts the selected file, the reader catches the read/format failure, and the command prints “[CEMARKUP] Failed to deserialize package.” The drafter is told neither what failed in drawing terms nor what to do next. This is a fixed program-written sentence, not the already-recorded raw-exception-message family.

   **Smallest fix:** Return “CE could not read this saved markup review. Choose another saved copy.” Print the new message with `[CE]`. Keep the technical read failure in the support log; do not claim that every read failure proves a damaged file.

   **DETERMINISTIC TEST:** Fixture: a saved empty metric DWG and, outside repositories, `RD11_BAD_REVIEW.json` containing exactly `null`. Type `CEMARKUPLOAD`, choose that file, click **Open**, then inspect F2 command history. The reader deterministically returns no package. Assert the history contains “[CE] CE could not read this saved markup review. Choose another saved copy.” and does not contain “deserialize”. Do not apply any markup. Current source instead emits the quoted programmer sentence.

3. **RD11-03 — MEDIUM — SURE, verified-by-reading: Manager's plain warning exposes the original jargon on hover.**

   **File:line:** Manager `Modules/Manager/UI/Pages/SettingsWorkspacePage.xaml.cs:60`, `:64`, `:99`; original failure `Services/CeCivilSettingsBridgeSession.cs:514`; caller `UI/Dialogs/PluginManagerWindow.Settings.cs:331`. Same mechanism: `UI/Pages/HelpWorkspacePage.xaml.cs:28`, `:29`; `SurveyIntakePage.xaml.cs:20`; `ProjectSheetsWorkspacePage.xaml.cs:25`. Translation: `UI/ManagerScreenText.cs:24`.

   **What a drafter sees / exact scenario:** When Civil cannot supply a usable embedded Settings page, Manager correctly shows a plain recovery sentence. But it assigns the unaltered failure reason to the warning's tooltip and again to the footer's tooltip. Hovering can show “The Civil settings bridge payload is incomplete.” Help, Survey Intake and Project / Sheets repeat this pattern. This is a colleague-facing window, not Manager administrator work.

   **Smallest fix:** Use the same plain explanation in the tooltip, or remove that tooltip. Save the technical reason in the fault report/log. Retain the recovery instruction on screen.

   **DETERMINISTIC TEST:** Fixture: isolated Manager/Civil test session with a controlled fault at `CeCivilSettingsBridgeSession.TryCreate`: return false, null session and the exact error “The Civil settings bridge payload is incomplete.” This reproduces the existing incomplete-result branch without damaging installed files. Type `CEMANAGER`; click **Settings > Civil**; hover over the unavailable-page warning and footer. Assert both visible tooltip texts contain neither “bridge” nor “payload”, and the main warning still tells the user to close and reopen Manager and send a fault report if it persists. Current assignments deterministically expose the raw reason. The fault injection and AutoCAD check remain unrun.

4. **RD11-04 — MEDIUM — SURE, verified-by-reading: Civil's typed drawing-upgrade preview speaks in storage terms.**

   **File:line:** Civil `Modules/Drainage/Commands/SpineUpgradeCommand.cs:40`, `:41`, `:43`, `:82`, `:83`, `:180`; shared summary `Shared/CE.Spine/SpineUpgradePlan.cs:85`, `:86`.

   **What a drafter sees / exact scenario:** Type `CDSPINEUPGRADE` during support-guided repair and accept its default preview. The prompt says “CE spine upgrade” with “DryRun” and “Rollback”; the output starts “[CE] DRY RUN: ... new identities”. Per-object rows contain “handle” and “new identity”. A pit number is already available, but the message makes the drafter interpret CE's storage machinery. This command is typed-only and hidden from the ribbon; it is nevertheless registered and callable without an administrator gate. This finding concerns the ordinary preview text, not either previously recorded upgrade behaviour fault.

   **Smallest fix:** Describe the task as preparing older pits and pipes for CE, offer **Preview / Apply / Undo upgrade** as display wording, and name the affected pit/pipe. For example, “[CE] Preview: 2 older drawing objects would be prepared for CE. Their numbers, levels, sizes and positions would stay the same.” Keep stored IDs and old command/option shortcuts unchanged; keep handles in the log. Preserve AutoCAD keyword parsing when changing display labels.

   **DETERMINISTIC TEST:** Fixture: a saved synthetic legacy Civil drawing with named pits P1/P2 and one P1–P2 pipe lacking permanent CE identities. Type `CDSPINEUPGRADE`, then Enter for preview only. Assert the command history describes a preview in plain words, names P1/P2, and contains none of “spine”, “DRY RUN”, “handle” or “new identity” in the user-facing result. Assert it still says numbers/levels/sizes/positions are unchanged. Do not choose Apply or Rollback. Current prompt/summary/row formatting fails the wording assertion.

5. **RD11-05 — MEDIUM — SURE, verified-by-reading: Structural Settings offers “verbose diagnostics” without explaining the choice.**

   **File:line:** Structural `Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml:538`, `:547`, `:573`, `:574`, `:578`; live bindings `UI/Dialogs/CeSettingsDialog.xaml.cs:175`, `:176`, `:394`, `:395`; consumers `Services/RuntimeDiagnosticsService.cs:274`, `:279`.

   **What a drafter sees / exact scenario:** On System > Saving and diagnostics, the user must choose between “Enable diagnostics” and “Enable verbose diagnostics”. Nearby labels say “Slow operation threshold (ms)” and “Echo saves to command line”. These are live controls, not unused design text. There is no explanation of what the two log levels mean. The neighbouring “Record detailed troubleshooting for all Structural tools” does not explain their difference.

   **Smallest fix:** Use “Record fault and speed information”, “Include extra detail in that log”, “Report work taking longer than (ms)”, and “Show save messages on the command line”. Rename the tab “Saving and fault reports”. Explain that extra detail is for investigating a fault; preserve every value and binding.

   **DETERMINISTIC TEST:** Fixture: empty synthetic drawing, Structural loaded. Type `CESETTINGS`; open **System > Saving and diagnostics** (the tab will have the new name after the fix). Assert the two log checkboxes have the proposed plain labels, the extra-detail option explains its purpose, and neither “verbose diagnostics” nor “Echo saves” appears. Cancel without saving. Current XAML fails those assertions. This is separate from the misleading Civil-backup checkbox in RD11-01.

6. **RD11-06 — MEDIUM — SURE, verified-by-reading: the inside-point tool is explained with an internal project label.**

   **File:line:** Structural `Modules/Structural/Assets/Config/command-registry.json:2164`, `:2165`; ribbon reader `Services/RibbonCommandHubService.cs:1031`; Help reader `UI/Dialogs/CommandHelpWindow.xaml.cs:334`, `:335`.

   **What a drafter sees / exact scenario:** The BSET ribbon tooltip says “Click a point inside the building to seed the lintel outside-flip.” Its Help details say “persistent inside-point store” and “Used by J11.2”. These words describe the implementation instead of explaining why an inside point affects a lintel label. The command is not hidden or expert-only.

   **Smallest fix:** Short description: “Pick a point inside the building so CE can put lintel labels outside.” Details: “CE remembers the point in this drawing. Pick another inside point for each separate building.” Remove the internal J11.2 reference from user text.

   **DETERMINISTIC TEST:** Fixture: empty drawing with the Structural ribbon and Help available. Type `CEHELP`, search `BSET`, select **Beam Set Inside Point**. Assert its summary/details contain the proposed explanation and none of “seed”, “persistent”, “store” or “J11.2”. Hover over the BSET ribbon button and assert its short description is the same plain sentence. No point needs placing. The registry-to-Help/ribbon routes are direct, so current source fails both text assertions.

7. **RD11-07 — MEDIUM — SURE, verified-by-reading: Markup Help explains implementation choices instead of the drawing actions.**

   **File:line:** Structural `Modules/Structural/Assets/Config/command-registry.json:678`, `:746`, `:749`, `:763`; Help display `UI/Dialogs/CommandHelpWindow.xaml.cs:335`, `:338`.

   **What a drafter sees / exact scenario:** A drafter seeking instructions for **Open Saved Markup Review**, **Set Drawing for Markup** or **Apply Next Markup Group** reads “live runtime”, “native and pyautocad execution”, “geometric execution batches”, “sub-batch” and “planned executor”. All three entries are visible and not expert-only. Their registry group says Administration, but these are markup drafting actions; they are not Manager administrator controls.

   **Smallest fix:** Replace the three explanations with, respectively, “Open a saved markup review and its review decisions”; “Read this drawing to suggest where the reviewed markups should go”; and “Show the next group of reviewed drawing changes and ask before applying them.” Replace the preparation note with “Do this before applying markup changes.” Do not alter the approval or execution paths.

   **DETERMINISTIC TEST:** Fixture: empty drawing with Structural loaded. Type `CEHELP`; search and select `CEMARKUPLOAD`, then `CEMARKUPREGISTER`, then `CEMARKUPRUN`. Inspect each details/notes area. Assert the corresponding plain explanation is shown and that “runtime”, “pyautocad”, “executor”, “sub-batch” and “execution batches” do not occur. Do not click Run. This test checks Help text, independently of the damaged-file message in RD11-02.

8. **RD11-08 — LOW — SURE, verified-by-reading: PDF Help names a code class.**

   **File:line:** Structural `Modules/Structural/Assets/Config/command-registry.json:4219`, `:4224`; Help display `UI/Dialogs/CommandHelpWindow.xaml.cs:335`, `:338`.

   **What a drafter sees / exact scenario:** Search Help for STRUCEXPORTPDF. The details say plotting runs “via AsyncCommandService”; the notes say “runs asynchronously”. Neither helps the drafter choose the layout, PDF destination or plotting settings. This entry is visible and not expert-only. The long description is displayed by Help; the ribbon uses its separate short description, so this finding does not claim the code-class name appears in the ribbon tooltip.

   **Smallest fix:** Remove “via AsyncCommandService” and replace “runs asynchronously” with “runs in the background”. Keep any responsiveness promise only if its existing behaviour remains verified; this wording hunt did not test plotting.

   **DETERMINISTIC TEST:** Fixture: any synthetic drawing with Structural loaded. Type `CEHELP`, search `STRUCEXPORTPDF`, select **Export Layout to PDF**. Assert the details and notes contain neither “AsyncCommandService” nor “asynchronously”, and still identify the current layout, PDF output and DWG To PDF plotter. Do not run the export. Current Help prints both software terms.

**What was NOT checked**

1. **No execution or visual acceptance.** No builds, unit tests, AutoCAD launches, window renders, screenshots, drawing edits, installations or sub-agents. No dark/light, screen-size, keyboard or native-tooltip behaviour was observed. The tests above are instructions for later execution, not passing results.

2. **No exhaustive claim.** This was a targeted source sweep of visible strings and their callers across Civil/Manager windows, Structural windows, command output, registry descriptions and Help. It was not a line-by-line audit of every command or every possible operating-system error. Manager administrator controls, development-only tools, private drawing data and live logs/settings were excluded. CDLINK's old window was excluded after its command was found removed. General missing `[CE]` prefixes were already covered by the earlier wording audit's item 68 and are not counted again; all proposed new result messages here use `[CE]`.

3. **No design or engineering changes.** R-00 engineering settings, R-27 blocking policy and the Civil + Manager 9 November release boundary remain outside these text-only recommendations. Structural findings are for its separate source line. No bug register, desk log, queue or code file was edited. Only this findings file is authorised for the CE_PLAN commit and push.

**Summary — under 100 words**

1. **Eight new wording faults remain: seven MEDIUM and one LOW.** The clearest risk is a backup option labelled as autosave. Other gaps include an unreadable markup review explained with “deserialize”, Manager hover text that restores hidden jargon, Civil upgrade storage terms, unexplained Structural log controls and software words in Help. Each finding has a source trace, a small text fix and a deterministic future check. All are verified-by-reading only; no AutoCAD or automated tests were run. Known findings were excluded and the temporary worktree was removed.
