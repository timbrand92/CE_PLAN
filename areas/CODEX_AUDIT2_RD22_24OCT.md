1. **ANSWER FIRST — 6 new findings: HIGH 0 / MEDIUM 3 / LOW 3.** Help and tooltip audit, 24 October 2026, Melbourne. All six are **SURE — verified by reading**, not observed in AutoCAD. No suspected findings are counted.

2. **Most important — Feedback Help promises a separate sending step that does not exist (RD22-01).** It says saving is separate from sending. On a PC with the office feedback folder available, the same action saves locally and copies the report to that folder.

3. **Next — Help can describe the previous command (RD22-02).** Open Settings, then Rainfall, then Help: Help still chooses Settings because Rainfall is missing from its command lookup list.

4. **Third — Calculations Help invites input to calculators that are read-only (RD22-03).** It lists Pump System and WSUD alongside the working calculators and tells the drafter to enter inputs and calculate. Those two pages deliberately refuse changes.

---

1. **Scope and evidence.** Civil 3.0.72 / Manager 1.1.72: `origin/claude/rel-20261023m`, pinned to `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. Structural 1.0.122: `origin/claude/rel-20261023s`, pinned to `e6d597c0fbc25e78118760887a70810e0890c9a9`. These are the requested source versions; this audit did not independently inspect the installed DLLs. All file:line references below belong to the relevant pinned version.

2. **Method.** Read Tim's rules, router, plan map, the earlier C58/C60/S40/S41 audit and the three `CODEX_AUDIT_*_22OCT.md` reports. Searched `BUG_CARPARK.md` before the code and again against each candidate. Used a detached reading worktree at `C:\ce-cx\rd22`, with `git show` and `git grep`; no code branch or code commit. Read the actual Help readers, content, registry normalisation and command handlers, so an unused description was not treated as live Help.

3. **Known findings excluded — BUG numbers only.** BUG-226, BUG-227, BUG-228, BUG-519, BUG-524, BUG-555, BUG-581, BUG-852, BUG-936, BUG-937, BUG-938, BUG-939, BUG-940, BUG-943, BUG-1033, BUG-1074, BUG-1077, BUG-1078, BUG-1079.

4. **Limits on conclusions.** MEDIUM means misleading guidance that changes the expected workflow or leaves the drafter at a dead end. LOW means a missing page or incorrect steps with an evident route back. These are guidance defects; no engineering calculation defect or release hard block is asserted. The tests below are instructions for a later tester, and were not run.

---

1. **RD22-01 — MEDIUM — SURE, verified by reading: Feedback Help incorrectly separates saving from sending.**

   **File:line:** `Modules/Drainage/Assets/Help/guide-content.js:98`. Actual button: `Modules/Drainage/Dialogs/FeedbackDialog.xaml:178`. Actual action: `Modules/Drainage/Commands/FeedbackCommand.cs:52`; `Modules/Drainage/Services/FeedbackService.cs:148`, `:152`, `:203`.

   **What the drafter sees:** Help says “saving is separate from sending it” and directs them to “Save report”. The window instead has **Send report**. Saving also attempts the office copy immediately; there is no later Send decision.

   **Exact failure scenario:** The office folder exists and is writable. The drafter follows Help expecting a saved draft, completes Feedback and clicks its primary button. The report is written locally and into the office feedback folder in the same call. The window itself discloses the extra copy; the false promise is in Help, not an allegation that the entire feature conceals it.

   **Smallest fix:** Change this Help entry to name **Send report**, explain the immediate office-copy attempt, and explain the local-only fallback when the office folder cannot be reached. No behaviour change is needed.

   **DETERMINISTIC TEST — fixture:** An isolated AutoCAD 2027 test account, blank synthetic drawing and a writable, non-synced test folder at the office-folder location that this service resolves. No real office destination or client text.

   **Typed steps and assertion:** `CDHELP`, search `CDFEEDBACK`, read Feedback. Close Help; `CDFEEDBACK`; enter title `RD22 sample` and description `Synthetic audit report`; click **Send report**. Assert the command line says `[CE] Report sent to the office feedback folder. Thank you!` and the CE log contains `FeedbackService: feedback mirrored to`. The Help acceptance assertion is that it names this immediate action and contains neither the separate-sending promise nor the nonexistent **Save report** instruction. Current source fails that Help assertion.

2. **RD22-02 — MEDIUM — SURE, verified by reading: Help retains the previous command for newer Civil tools.**

   **File:line:** `Modules/Drainage/Services/CdHelpService.cs:40`, `:227`, `:230`, `:125`; launcher `Modules/Drainage/Services/HelpLauncher.cs:39`. The Rainfall page does exist at `Modules/Drainage/Assets/Help/guide-content.js:52`.

   **What the drafter sees:** After asking for rainfall help, the reader opens Settings. Searching manually finds Rainfall, but the automatic destination is wrong.

   **Exact failure scenario:** Run `CDS`, close it, run `CDRAINFALL`, close it, then run `CDHELP`, all within ten minutes. `CDS` is in the tracked set; `CDRAINFALL` is not. The ignored command leaves the previous name and timestamp intact, so the launcher opens `#cds`. `CDDESIGN`, `CDCHECKS` and `CDRUNSOLVE` are also absent. This is separate from a missing Help page: Rainfall and Design already have pages.

   **Smallest fix:** Extend the tracked-command map to current commands and resolve aliases to their guide topic. Do not preserve a misleading previous topic when a recognised CE command has no guide destination. A window-specific context can be added separately where needed.

   **DETERMINISTIC TEST — fixture:** Blank synthetic Civil drawing, normal bundled Help files, AutoCAD 2027 and the pinned Civil build.

   **Typed steps and assertion:** `CDS`, close without saving; `CDRAINFALL`, close without saving; immediately `CDHELP`. Assert the displayed topic is **Rainfall · CDRAINFALL**, with **Current rainfall; Import coefficients; Review change** in the entry. Current source instead selects **Settings · CDS**. Use this typed sequence; it does not depend on F1 being wired into the Rainfall window.

3. **RD22-03 — MEDIUM — SURE, verified by reading: Help offers editable Pump System and WSUD calculations that this release does not provide.**

   **File:line:** `Modules/Drainage/Assets/Help/guide-content.js:63`; actual controls `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml:780`, `:788`, `:1005`, `:1013`, `:1024`.

   **What the drafter sees:** Help lists **Pump System** and **WSUD**, then instructs them to enter inputs on the relevant tab, calculate and prepare the sheet. The real tabs are **Older calculators — Pump System** and **Older calculators — WSUD**; their inputs cannot be edited.

   **Exact failure scenario:** A drafter uses Help to start a new pump or water-quality calculation. They open the described page and try to enter the job's values, but the text boxes are read-only. “Results can need review” does not disclose that new input is unavailable. The existing missing-banner bug is excluded; this finding concerns the separate Help instructions for both calculators.

   **Smallest fix:** Use the current tab names and explicitly say these two calculators are for reading existing calculations only, pending review. Limit the enter-and-calculate instruction to editable pages. Do not enable the parked calculators as a documentation fix.

   **DETERMINISTIC TEST — fixture:** Synthetic Civil drawing, pinned Civil build, existing/default calculator values.

   **Typed steps and assertion:** `CDHELP`, search `CDCALC`, read Calculations. Then `CDCALC`, open **Older calculators — Pump System**; note **Pump flow rate (L/s)**, select its text and attempt to type a different number. Repeat **Annual rainfall (mm)** on **Older calculators — WSUD**. Assert both displayed values remain unchanged and Help explicitly identifies both pages as read-only. Current source passes the read-only behaviour and fails the Help disclosure.

4. **RD22-04 — LOW — SURE, verified by reading: Label Styles has a Help destination with no page.**

   **File:line:** `Modules/Drainage/Services/CdHelpService.cs:49`, `:125`; `Modules/Drainage/Commands/LabelStyleCommands.cs:20`, `:33`; `Modules/Drainage/Assets/Help/guide-content.js:93`, `:135`; `Modules/Drainage/Assets/Help/help-pages.js:20`, `:24`, `:64`, `:68`.

   **What the drafter sees:** F1 from Label Styles opens the general Civil guide instead of explaining label formats. Searching the exact command gives no matching topic.

   **Exact failure scenario:** `CDLABELSTYLE` is registered and tracked, so Help asks for `#cdlabelstyle`. The current guide creates cards only from its panel entries, which contain no CDLABELSTYLE card. The search file still has a `cdlabelstyle` keyword entry, but keywords alone create neither a page nor a search topic. The missing target falls back to the first reading section. CDMA has the same missing-card pattern; it is grouped here rather than counted twice.

   **Smallest fix:** Add a short current Label Styles page and a Move Arrow page, retaining these established command destinations. Alternatively route each to a genuinely equivalent existing explanation, with its command searchable.

   **DETERMINISTIC TEST — fixture:** Blank synthetic Civil drawing with bundled Help intact.

   **Typed steps and assertion:** `CDLABELSTYLE`; with **Creative Engineering | Label Styles** open, press F1. Assert Help shows a **Label Styles · CDLABELSTYLE** topic. Search `CDLABELSTYLE`; assert at least one matching topic. Current source falls back to the general page and displays `No matching topic. Try a command name or a shorter word.` for the search. No label style needs saving.

5. **RD22-05 — LOW — SURE, verified by reading: Structural Settings commands have drawing-placement instructions.**

   **File:line:** `Modules/Structural/Assets/Config/command-registry.json:2080`, `:2681`; actual handlers `Modules/Structural/Commands/BeamSettingsCommand.cs:22` and `Modules/Structural/Commands/RafterJoistCommands.cs:90`. Help displays these prompt strings at `Modules/Structural/UI/Dialogs/CommandHelpWindow.xaml.cs:306`, `:337`.

   **What the drafter sees:** **Beam Settings (8)** tells them to pick Start point, End point and Text/suffix options. **Rafter/Joist Settings (RJSET)** tells them to select Direction, Extent and Tag text. Neither command asks any of those questions.

   **Exact failure scenario:** Enable **Show advanced commands** in CEHELP and open either entry. The published instructions describe placing a member, whereas the handlers only open **CE Settings**, on **Beam** or **Rafter / Joist**. The older private CLI helper in the beam file is not called by command 8.

   **Smallest fix:** Replace both prompt lists with the actual Settings-page route and current save/close instructions. Keep the old typed commands.

   **DETERMINISTIC TEST — fixture:** Blank synthetic Structural drawing with the pinned Structural build.

   **Typed steps and assertion:** `CEHELP`; tick **Show advanced commands**; search `RJSET`, select **Rafter/Joist Settings**, read its steps. Close Help and type `RJSET`; assert **CE Settings** opens on **Rafter / Joist**, without a direction or extent prompt. Repeat Help for **Beam Settings**, then type `8`; assert **CE Settings > Beam**. Help must describe those pages and contain none of the placement steps above. Current source fails the Help assertion.

6. **RD22-06 — LOW — SURE, verified by reading: Reverse Flow Help promises a change preview and Apply step that do not exist.**

   **File:line:** `Modules/Drainage/Assets/Help/guide-content.js:101`; actual interaction `Modules/Drainage/Commands/RibbonContextCommands.cs:46`, `:54`, `:56`, `:63`.

   **What the drafter sees:** Help says **Change preview and confirmation** and tells them to check every proposed change before **Apply**. AutoCAD instead displays a general command-line explanation followed by **Continue? Yes/No**. There is no preview showing that selected pipe's actual before/after levels, and no Apply button.

   **Exact failure scenario:** The drafter selects a pipe and starts Reverse Flow expecting to inspect its proposed values in a review window. Answering Yes to the only question immediately calls the reversal. The confirmation is present and defaults to No; this is an inaccurate preview promise, not an unconfirmed write.

   **Smallest fix:** Describe the existing command-line Yes/No confirmation, what is swapped and what stays put. Remove the promise of an item-specific preview and the nonexistent Apply step.

   **DETERMINISTIC TEST — fixture:** Synthetic Civil drawing with one recognised CE pipe, distinct end inverts 10.00 m and 9.90 m, unlocked layers.

   **Typed steps and assertion:** `CDHELP`, search `CDREVERSEFLOW`, read the entry. Close Help, select that pipe and type `CDREVERSEFLOW`. Assert the command line explains **Reverse Flow swaps From/To and their end values, and flips the arrow**, then asks **Continue?** with Yes/No. Press Enter; assert `[CE] Nothing was changed.` and the two stored inverts are unchanged. Help must describe this sequence and not promise a preview window or Apply button. Current source fails the Help assertion.

---

1. **What I did NOT check.** No AutoCAD session, builds, unit tests, rendered windows, mouse interactions, installed files, external Help website, live logs or drawing edits. No claim about appearance, Undo/Redo or accepted behaviour. No exhaustive execution of every registry command or alias, and no review of parked Manager administration. Structural commands not shipped to the colleague remain Structural-only findings.

2. **Other scope checks.** Read the Civil HTML entry point and topic/search generation, Civil ribbon descriptions, Manager Help host/fallback paths, Structural command-list reader and registry filtering. In particular, the stale standalone BEXTEND prompt entry is hidden by alias normalisation; it was not reported as a visible fault. No new nonexistent command was established beyond previously recorded issues.

3. **Changes and follow-up.** Only this findings file is authored. No change to code, BUG_CARPARK, DESK_LOG or QUEUE; no code PR, build, install or acceptance claim. The six small fixes and their pending deterministic checks are above. The detached reading worktree is removed at completion. Undo for the report is to revert its named-file commit in CE_PLAN.

4. **Summary.** Six new guidance faults: three MEDIUM and three LOW. Correct Feedback's sending promise first, then command-context routing and the read-only calculator instructions. Restore missing command pages and correct the Structural Settings and Reverse Flow steps. Each finding is proven from the requested source versions and has a pending AutoCAD check. No code was changed, no test was run and nothing was marked fixed or accepted.
