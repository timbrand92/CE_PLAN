# Independent second review: class E, positions 31–45

1. **ANSWER FIRST — HIGH 0, MEDIUM 2, LOW 1 new or corrected findings.** The most important finding is in **#1225**: its repaired privacy filter still leaves the leading words of a drawing name containing brackets in the office fault report. A synthetic example is `REVIEWMARK (Stage 2) Plan.dwg`. This is verified by reading, not an observed AutoCAD run.

2. **Decisions: 0 MERGE, 2 MERGE-WITH-FIXES, 3 HOLD, 10 REJECT.** Fix #1167 and #1225; hold #1207, #1212 and #1234. The other ten duplicate work already present in the nominated Civil/Manager release. REJECT means do not integrate these branches; no PR was closed or changed.

3. **The earlier reviews need three corrections.** #1167 and #1225 have newer heads containing their requested repairs. #1212 still starts its bug fix OFF, and its full PR includes installer manifests. #1234 changes signed-update staging, so this brief requires HOLD even though much of its work is duplicated. Manager administrator work remains parked.

4. **What was done.** Read-only Git/GitHub review on 26 October 2026, Melbourne date. No build, test execution, AutoCAD, installation, sub-agent, code edit, branch or worktree creation. The filename retains 24OCT as requested. Every test below is a recipe for a later isolated test lane, not a PASS and not a task for Tim.

---

1. **Scope and evidence.** Class-E positions 31–45, counted within that section of `PR_PILE_TRIAGE_2026-10-24.md`: #1167, #1207, #1212, #1215, #1216, #1217, #1219, #1221, #1225, #1229, #1230, #1231, #1232, #1233, #1234. Read RULES, ROUTER and the plan entry points; consulted `AUDIT_C58_C60_S40_S41_2026-10-22.md` and the Civil, Structural and gate `CODEX_AUDIT_*_22OCT.md` reports to exclude their findings.

2. **Earlier coverage and deliberate limits.** The required filename search found all 15 covered by [Opus batch 4](REVIEW_PILE_B4_24OCT.md) or [Opus batch 5](REVIEW_PILE_B5_24OCT.md). Those reviews supersede the triage's “unreviewed” description. Unchanged, credible verdicts are retained, not presented as fresh independent audits. Fresh code review concentrates on changed heads #1167/#1225 and disputed decisions #1212/#1234. Known faults below are cross-references and do not increase the answer-first counts.

3. **Pinned comparisons.** After `git fetch origin`: nominated Civil/Manager `origin/claude/rel-20261022m` = `40ee0a36f7960145743954b39859eb6c3af92869`; nominated Structural `origin/claude/rel-20261022s2` = `2c9a96942a024888a5ab520600f2d5025de83036`; C-63 `origin/claude/rel-20261024m` = `5467f7053a2e9275cb450409c142ef9aa26dad53`. These are source baselines from the brief, not a claim about today's installed DLLs. C-63 contains the nominated Civil/Manager head. The earlier reviews used C-63 `28987b73` and newer installed baselines, so their integration statements needed updating.

4. **Method.** Used `gh pr view` for every head/base and `gh pr diff` for changed-file screening; read full relevant patches and pinned source for the rechecks. None of the 15 PR heads is an ancestor of either nominated installed head or C-63. “Already present” below means an alternative fix, not that the PR head was merged. Verified the cited alternative-fix commits are ancestors of `40ee0a36`. C-63 conflict lists come from read-only, three-argument `git merge-tree` with each merge base: textual screening, not an actual merge or compilation. Clean text does not establish semantic compatibility.

5. **Safety boundaries.** No requested PR diff changes `Shared/CE_SHARED`. #1212's complete GitHub diff does touch installer manifests; #1234 touches signed-update staging. Both are held. Separate Structural branch histories must not be merged wholesale into Civil C-63. The narrow help/privacy edits add no drawing transactions, layer writes or entity traversal. Native REDO, locked-layer, Xref and REFEDIT behaviour remains untested; the retained reviews are not upgraded to AutoCAD acceptance.

6. **Common later-test protocol.** Use synthetic drawings and an isolated settings/profile/bundle, never Tim's live files. For automatic activity, draw `_.LINE`, `0,0`, `1000,0`, Enter; type `_.U`; wait 12 seconds without another command; then `_.REDO`. Assert the line returns and the log contains no intervening drawing save/write. For an explicit placement, separately assert one U removes its complete output and REDO restores it. Repeat relevant placement cases with the target layer locked, an attached synthetic Xref and active REFEDIT: no modification of protected content and no unlocking. These are owed checks, not evidence of a newly found failure.

---

1. **PR #1167 — position 31 — MERGE-WITH-FIXES. LOW, new residual finding; verified-by-reading.** Head `1cc57d9d62d40c33fe8ba20eb44c20218119261c`, replacing the reviewed `f2669fa9`.

   **For Tim / exact failure:** Help no longer opens the external website by default, and the attribute log no longer includes the attribute value. However, after more than ten minutes without a recognised CE command, a missing guide silently falls through to the general Help window. The promised line explaining that the guide is missing never appears.

   **File:line:** `Modules/Drainage/Services/CdHelpService.cs:138`–`:140` returns when context is absent, before the new notice at `:162`. `GetCurrentContext` expires context after ten minutes. `HelpLauncher.cs:77`–`:82` calls that method then opens the fallback dialog; `Commands/CdCommand.cs:1513` reaches this launcher. The prior review's “file exists but will not open” wording repair is now present and is not repeated as an open fault.

   **Exact fixes:** Put local-guide failure reporting in the launcher, before the optional contextual URL lookup, so no recent-command context is required. Preserve missing versus could-not-open wording. Add no-context and expired-context coverage through the launcher. Keep both Settings groups in the C-63 conflict and both log entries.

   **Test assessment / deterministic test:** Existing rule and source tests would reject the old attribute-log line and old wording, but never exercise the early return. Later fixture: isolated test bundle with the HTML guide absent; `help.openWebFallback` absent; synthetic blank drawing. Run PIT and cancel, wait eleven minutes with no CE command, then type `CDHELP`. Assert command-line text contains `The CE help guide is missing`, the built-in Help window opens, and no external website opens. Repeat with recent PIT context as the control. An isolated launcher test with an existing but deliberately unopenable guide must instead contain `could not be opened`.

   **Integration / safety:** Not in either nominated installed head. C-63 conflicts: `Models/UserSettings.cs`, `REGRESSION_LOG.md`. The privacy fix is enabled by default because the opt-in web switch is OFF. No engineering value, new drafting block, installer, signed-update or Shared change. Only log text changed inside existing attribute setters; their drawing protection is not rewritten. No new automatic drawing writer.

2. **PR #1207 — position 32 — HOLD. Earlier verdict retained; no new counted finding.** Head `074cd368f65703e5bb9e09663d599e459bcad07e`.

   **For Tim / cause and failure:** The earlier review found that switching to drawing-held lintel tolerances loses existing side-file tolerances: the reader is connected, but the new writers are not. A colleague can therefore get office tolerances rather than the job's values. See batch 4 item 2; this is not a newly discovered fault.

   **File:line / test assessment:** `Modules/Structural/Services/LintelProposalService.cs:94`; `Core/JobRecord/JobRecordStorage.cs:165`, `:167`, `:169`; switch at `Models/UserSettings.cs:716` starts OFF. Codec tests do not prove a drawing save, migration or Save As. The prerequisite #1024 has since received further coverage in `CODEX_PR_REVIEW_GROUP10_24OCT.md`; the older statement that it had no review is stale. That does not supply the missing integration.

   **Deterministic later test:** Fixture: a synthetic lintel job with a side-file tolerance deliberately different from the office value and no drawing-held lintel record. Enable the proposed drawing-record mode on the isolated profile. Open the lintel proposal, record its tolerance, Save As to a second synthetic filename, then open on a second isolated profile. Assert the job tolerance is identical in both proposal windows and the saved record, and schedule placement records survive the same transfer. The present incomplete route cannot establish that result.

   **Required resolution / safety:** Complete explicit save and migration paths after resolving the job-record design dependency. Do not implement the earlier review's suggested migration as an automatic read-time drawing write: migration must be an explicit undoable action, never activity between U and REDO. Require REFEDIT/read-only admission checks and native evidence. Narrow PR diff has no Shared/installer changes or new engineering constants. Full-head C-63 textual screen has 164 conflicting paths across the separate histories: keep this on the Structural lane, not Civil C-63.

3. **PR #1212 — position 33 — HOLD. MEDIUM, corrected review conclusion; verified-by-reading.** Head `55f22a3f8e80bb2ec4654d0fcd388c50f1f692ba`.

   **For Tim / exact failure:** This bug fix promises to identify the standard's edition on founding notes and wind-class text. With ordinary existing settings it changes neither: the switch starts OFF. Passing tests explicitly require that unchanged behaviour. Batch 4 called this an optional wording preference; that contradicts this brief's requirement that a bug fix starts ON.

   **File:line:** `Modules/Structural/Models/UserSettings.cs:107` initialises `NameEditionOnNotes=false`; `:135` and `:148` return the old wording. `Modules/Structural.Tests/Services/StandardCitationTests.cs:76`–`:82` asserts the default is false. `Commands/SoilAndWindCommands.cs:200` onward prints the suggested class through the helper; `Core/Notes/GeneralNotesAssembler.cs:115` uses it for founding notes. This is a default-path defect, not a claim that a particular edition is the correct engineering choice.

   **Exact fixes:** Make missing-key/default behaviour ON, preserving an explicit saved preference under an agreed migration. Keep an unknown edition explicitly unknown. Test deserialisation without the switch and the actual command output. Retain the earlier fixes for editable Settings rows and the saved `As3600` copy at `UserSettings.cs:98`; do not claim those already-known issues as new findings.

   **Deterministic later test:** Isolated profile: one synthetic wind region `REVIEWREGION` starting at N2, default Typical terrain and Flat topography; `StandardEditions.As4055="2021"`, but omit `NameEditionOnNotes`. Blank synthetic drawing with no confirmed wind class. Type `CSWINDCLASS`, `REVIEWREGION`, `Typical`, `Flat`; inspect the suggestion, then Esc at `Use N2?`. Assert the suggestion contains `AS 4055-2021` and cancellation saves no class. The current default omits the citation. Repeat with As4055 blank: require `edition not set`, never an invented year. The year here is a test string, not an engineering endorsement.

   **Additional mandatory HOLD / scope:** The complete GitHub diff against base `afe77cf9` includes `CE.Host/Installer/PackageContents.xml` removing CE_VERSION declarations, and `Modules/Structural/Installer/PackageContents.xml:12` changing 1.0.113 to 1.0.119 plus command declarations. These are inherited branch changes, not evidence that the citation helper itself broke installation. Nevertheless “no installer files touched” is false for the PR being reviewed, and the brief requires HOLD. Separate the small citation changes from the unrelated Structural train history and review the resulting package.

   **Integration / safety:** No Shared change in the requested PR diff. Full-head C-63 screen has 167 conflicting paths; do not integrate it into Civil. No fresh certification of the unrelated inherited writers, layer guards or engineering changes is made. The citation edits themselves change text, not calculation values or new hard blocks. Their pure-text tests cannot certify native prompts, REDO or output placement.

4. **PR #1215 — position 34 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `86991a3be023378e90b87e2866a76f0a97e40ad1`.

   **Cause / evidence:** The old calculation summary could show office runoff C while discharge used council C. PR `Services/DesignProposalReport.cs:115` adds another chooser; the nominated release already uses `PreDevCText` at `:177`, via ancestor `9793b9e7`. Batch 4 also identified differing area inputs. Do not duplicate that fix.

   **Test assessment / deterministic later test:** `Bug509PreDevCPrintedTests` exercises report text and the helper, not the window. Fixture: 500 m² site, 300 m² impervious area, office pre-development C 0.35, synthetic council fixed C 0.40. Run `CDDESIGN` and open the calculation summary. Assert `Before-development C` is 0.40 and matches the discharge basis; changing only the office value must not override the council value. Use synthetic council data, not an asserted council rule.

   **Integration / safety:** Alternative fix is in C-60 and therefore C-63. C-63 conflicts: `Services/DesignProposalReport.cs`, log. Scope is report/calculation helpers; no new automatic drawing writer or protection change, no new switch or hard block, no Shared/installer change. Existing numeric policy must remain with the shared rule/Settings.

5. **PR #1216 — position 35 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `d6af41f38ba108499cbe88fbd8f8aa4099602b52`.

   **Cause / evidence:** A last-row governing storm needs a warning that longer storms were not tried. PR `ViewModels/BoydsCalcViewModel.cs:272` gates it on `WarnWhenLongestStormGoverns`; C-60 already calls `StormStillRisingSentence` there without that gate, from ancestor `6ab18018`. The earlier review already rejected the OFF-default regression.

   **Test assessment / deterministic later test:** `Bug515BoydsLastRowTests` explicitly tests both ON and OFF; that proves its switch behaviour, not compliance with the required default. Fixture: its `ForNewJob(false)` defaults, permitted discharge 0.1 L/s, no switch key. Open `CDCALC`, Boyd's page. Assert the governing duration is 30 min for this fixture and the warning contains `longest storm tried`; record storage and verify the warning does not change it.

   **Integration / safety:** Alternative fix is in both Civil baselines. C-63 conflicts: `BoydsCalcViewModel.cs`, log. Text-only view-model addition; no drawing writes, Xref/layer mutations, installer/Shared changes or new hard block. Do not put an existing warning behind an OFF default.

6. **PR #1217 — position 36 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `a6c2dfb012df6be5383c2dc088d8010a6a043d62`.

   **Cause / evidence:** Detention sizing used a separate size/run rule. PR `Services/AutoDesignService.cs:604`–`:609` reads Settings itself; C-60 `AutoDesignService.cs:598` already calls `Rules.DetentionPipeLimitsRule.Resolve`, from ancestor `6ae16dde`. Keep that one rule.

   **Test assessment / deterministic later test:** `Bug511DetentionPipeSettingsTests` covers nondefault limits but uses a calculation hook. Fixture: required storage 8.0 m³, allowed run 60 m and normal 225–600 mm size range. Run the detention-pipe proposal in `CDDESIGN`; assert proposed diameter 450 mm. Reset run to 40 m: the corresponding fixture proposes 525 mm. Also set minimum diameter 300 mm with 1.0 m³ storage: no 225 mm proposal. Confirm CDRULES reads the same limits.

   **Integration / safety:** Alternative fix is in C-60/C-63. C-63 conflicts: `AutoDesignService.cs`, log. No new automatic drawing writer, Xref/layer traversal, switch, hard block, Shared or installer change in the small PR. R-00 is served by the already-installed common Settings reader, not a second set of fallback constants.

7. **PR #1219 — position 37 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `1e877e4b5b8cac9cf32987a1acee53240157d024`.

   **Cause / evidence:** Counting existing SPS pits can duplicate SPS3 when SPS1 and SPS3 exist. PR `Commands/PitCommand.cs:1018` uses its new path only when `Models/UserSettings.cs:1054`'s OFF switch is enabled. C-60 `PitCommand.cs:1044` already chooses an unused number, via ancestor `cbe41302`. “Never duplicate” is fixed; gap-fill versus highest-plus-one remains a separate numbering-policy question from the earlier review.

   **Deterministic later test / coverage:** Synthetic drawing with genuine CE SPS1 and SPS3, both unlocked, with no SPS2. Type `PIT`, select SPS and place a third pit. Assert three different numbers; C-60's documented policy yields SPS2. Repeat the common protection and Undo/Redo cases, checking both the new pit and any existing bare-SPS rename. The arithmetic unit tests do not prove those drawing writes.

   **Integration / safety:** C-63 conflicts: `PitCommand.cs`, log. No installer/Shared change or new hard block. Existing explicit placement protections must survive; this review did not re-audit the entire writer. Rejecting the duplicate also avoids introducing its OFF-default regression.

8. **PR #1221 — position 38 — REJECT. Earlier duplicate-property finding retained; no new counted finding.** Head `7aeacc6b2b301a953a44f27a2e3552c0800f10a5`.

   **Cause / evidence:** The small PR moves SPS label heights into Settings. Its `Models/UserSettings.cs:1051` and `:1055` duplicate properties already present in C-60 at `:1558` onward, with the reader `Commands/PitCommand.cs:1023`, from ancestor `ee2d9e4d`. Batch 4 already explained why a text-clean merge can still fail compilation; no build was run here.

   **Deterministic later test / coverage:** Isolated profile with bare SPS height 320 mm and numbered SPS height 270 mm. In a synthetic millimetre drawing, place one SPS with `PIT`, then a second. Read the attributes in Properties: bare SPS is initially 320; after numbering, SPS1 and SPS2 are 270. Repeat with the existing pit's layer locked and verify no silent unlock or partial rewrite. Helper tests alone do not establish that result.

   **Integration / safety:** Only the log has text conflict markers, which is not permission to merge. Keep the existing two properties and existing height reader. No new bug switch, hard block, Shared or installer change. Heights are drafting Settings values; no new engineering limit is introduced. Native writer/REDO coverage remains owed, not accepted by reading.

9. **PR #1225 — position 39 — MERGE-WITH-FIXES. MEDIUM, new residual privacy finding; verified-by-reading.** Head `6ace3ae193ca644401bf434fa98feea49766497d`, replacing reviewed `e7793d29`.

   **For Tim / exact failure:** The latest repair handles simple space-separated names, but brackets inside a drawing name defeat it. A fault containing `REVIEWMARK (Stage 2) Plan.dwg could not be opened` retains `REVIEWMARK (Stage 2)` in the report sent to the office. That prefix can contain a job or client description. REVIEWMARK is a synthetic marker, not a real client.

   **File:line / proof:** `Services/FaultReportTextScrub.cs:64`–`:66` lets a match start at the line start or an opening delimiter, but forbids internal parentheses and square brackets. Neither the initial run nor the run beginning at `(` can reach `.dwg` across `)`. `BareName` at `:68`–`:70` then removes only `Plan.dwg`. The ordered replacements at `:103`–`:104` leave the prefix. The final shared scrub only removes login/machine/profile identity, not arbitrary drawing words. `AdminTelemetryService.cs:175`–`:176` places this result in the fault Message and Details. This is a different input from batch 4's simple-space case, which the new head repairs.

   **Exact fixes:** Redact the complete filename including valid embedded parentheses/square brackets, preferably by passing a known filename separately and redacting it before free-text processing. Where the filename boundary is ambiguous, remove the whole filename-bearing message span rather than preserving possible identifying words. Keep job-number-only output and ordinary diagnostic text tests. Add bracketed, nested and quoted bracketed filenames to both message and exception coverage; retain the new wiring guards.

   **Deterministic later test:** First call the actual scrub with `REVIEWMARK (Stage 2) Plan.dwg could not be opened`, then `Could not open 'REVIEWMARK [Stage 2] Plan.dwg'`. Assert neither output contains REVIEWMARK, Stage, Plan or a filename. To prove the AutoCAD route, a later test-only command must call the real `AdminTelemetryService.RecordFailure` with those exact strings as message and exception message, using a redirected synthetic outbox. Flush the queued report writes, read the emitted failure JSON and print the captured Message/Details to the AutoCAD command line. Assert the same absences there and in the report. This requires a test harness; no such command was created or run here. Control: the simple unbracketed name covered by the PR must remain fully removed.

   **Test assessment / safety:** The added source guards now cover wiring, correcting the old review's missing-test observation. Current fixtures never put brackets inside the filename. The helper tests therefore miss this failure. No switch: privacy repair is always active. No drawing writes, locked-layer/Xref/REFEDIT changes, engineering values, drafting blocks, Shared or installer changes. C-63 has only a log conflict. The nominated releases do not contain this helper; do not interpret a clean code merge as privacy acceptance.

10. **PR #1229 — position 40 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `cb71824f7a3d72a292de847205fe63d1f3d34430`.

   **Cause / evidence:** A LandXML sump level must not become a pipe invert, and missing dimensions must not be called supplied values. PR `Helpers/LandXmlParser.cs:39` and `:42` add those report markers. Alternative fix `ae64971a` is already in C-60, followed by other parser fixes identified in batch 4. Retain the newer parser.

   **Deterministic later test / coverage:** Export the synthetic `StructWithSumpOnly` and `NothingButPositions` fixtures from `LandXmlParserTests.cs` into the isolated test input folder. Type `CDIMPORTXCIVIL` and select each LandXML input in turn. Assert the first fixture's P1 has no invert inferred from its sump; P2 retains IL 49.10. The report must say `pit floor level kept as a note, not used as the invert`. For the second fixture, the report must say `not in the file, CE default used` for pipe size/material and pit size. Inspect both the report and resulting drawing records; parser-only tests cannot establish placement protection.

   **Integration / safety:** C-63 conflicts: `LandXmlParser.cs`, log. No new switch/Shared/installer change or hard block. Defaults are not newly authorised engineering values; this patch labels their provenance. The importing writer, cancellation, locked layers and REFEDIT are outside this narrow parser patch and still require native checks if further work is taken.

11. **PR #1230 — position 41 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `a656036ac963606f9b8402265030d9da761c4eaf`.

   **Cause / evidence:** Confirmed roughness should not produce the assumed-roughness warning. PR `Rules/RulebookEngine.cs:418` adds `if (roughness.IsAssumed)`, already present through ancestor `499b97c8`. Batch 4 identified equivalent installed tests.

   **Deterministic later test / coverage:** Synthetic valid gravity pipe with known diameter, grade and a roughness explicitly confirmed in the isolated Settings. Run `CDRULES`. Assert no `Velocity uses Assumed roughness` finding for that pipe. On a separate copy mark the same roughness assumed and repeat: require that exact warning and unchanged hydraulic input numbers. The PR's rule tests address this branch; native report presentation remains unrun.

   **Integration / safety:** C-63 text conflicts: `RulebookEngine.cs` comment area and log. No switch, numeric change, new block, automatic drawing writer, layer/Xref mutation, installer or Shared change. Keep the installed equivalent.

12. **PR #1231 — position 42 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `5a61f9d09f4925704e642ee6564f43eb8ed79871`.

   **Cause / evidence:** Manager could turn MENUBAR back on against the drafter's choice. PR adds an OFF-default `leaveMenuBarAlone`; C-60 already has the `forceMenuBar` policy (`Services/CeOneGlanceStatus.cs:240`; `CeSuiteManagerMenuService.cs:831`) through ancestor `342baa37` and later handling. Preserve the installed policy, including its ribbon-availability distinction; do not assume all AutoCAD lanes show a ribbon.

   **Deterministic later test / coverage:** On the 2027 test profile with Manager ribbon visible, no force-menu override and MENUBAR 0, start Manager and let its menu load once. Query `MENUBAR`: require 0. Repeat after `U` without typing diagnostic commands until REDO; the common protocol must pass. Separately verify the older-lane menu access policy with no ribbon. The PR's source/rule tests do not prove startup timing.

   **Integration / safety:** C-63 conflicts: `CeOneGlanceStatus.cs`, log. No installer/Shared or engineering change; no new hard block. This is a system-variable startup route, so native REDO evidence matters. The already-recorded Structural menu issue is not repeated or repaired here.

13. **PR #1232 — position 43 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `604931f94edb03a29fbb9c61be79d3eb39abe691`.

   **Cause / evidence:** An unavailable office folder could expose a raw error and interrupt report upload. C-60 `Services/CeAdminStorageService.cs:123` onward already retains queued files and supplies `Could not reach the office folder; reports will wait on this PC.`, from ancestors `3fdea24a` and `c88d3bdb`. Batch 5 did not audit every administrator button; neither does this review.

   **Deterministic later test / coverage:** Isolated local outbox with two synthetic reports and an office destination whose write permission is denied for the test user. Open `CEMANAGER` and use `Send waiting reports`. Assert the plain unavailable-folder sentence appears, both unsent source reports remain, and no raw exception/path appears in window text. Restore permission and repeat; both upload once. Existing failure tests address copying, not the full button path.

   **Integration / safety:** C-63 conflicts: storage service, `PluginManagerWindow.xaml.cs`, log. File I/O only in this patch, no drawing/layer/Xref writer, engineering value, new block, Shared or installer change. Administrator feature development stays parked; this rejection authorises no replacement work.

14. **PR #1233 — position 44 — REJECT. Earlier superseded verdict retained; no new counted finding.** Head `64a8d952c652ef3d446ea766c38c144e835dd8fe`.

   **Cause / evidence:** CEHEALTH lacked Manager and duplicate-copy information. PR `Commands/PluginManagerCommands.cs:209` onward adds it, but ancestor `5a344c73` already provides the alternative in C-60 and also addresses the pair line. Batch 5's reject remains sound.

   **Deterministic later test / coverage:** On a disposable AutoCAD profile, prepare two synthetic scan-root manifests for the same CE tool, then run `CEHEALTH`. Assert a Manager running-version line and a duplicate-copy warning; neither folder is changed. Repeat with one manifest and require no duplicate warning. The preparation belongs to the later isolated harness, not Tim's actual plugin folders. Pure line-format tests cannot establish discovery across the real scan roots.

   **Integration / safety:** C-63 conflicts: `PluginManagerCommands.cs`, log. The PR adds read-only discovery and text, no new switch, engineering number, block or automatic drawing write; Shared and installer files are unchanged. Full native command/REDO behaviour was not rerun.

15. **PR #1234 — position 45 — HOLD. Corrected disposition under this brief; no new counted defect.** Head `bac3a16dd633136f1a42eface501d5f417421f0d`.

   **For Tim / cause and limit:** Long temporary update paths remain relevant to older AutoCAD lanes, but the original real-PC path-limit failure was never demonstrated. The earlier review already recorded that the nominated release's short final folder is switched OFF and that the PR also shortens the temporary preparation folder. Those are not new findings here.

   **File:line:** PR `Services/CeUpdateStagingService.cs:638` makes the preparation name 23 characters; `:647` makes the final name 29. C-60 has the alternative `ReleaseFolderName` at `:111`, a 43-character preparation name at `:342`, and reads `ShortStagingFoldersEnabled` at `:374`. Ancestor `b71d1139` is present. The full-hash verification remains distinct from the abbreviated directory name.

   **Why HOLD instead of batch 5's REJECT:** This is a signed-update file, explicitly a HOLD category in this brief. The useful preparation-folder change is not entirely duplicated. Do not resume parked update/administrator work or merge this old branch. If separately authorised later, extract only the missing change, preserve current full-hash/approval checks and C-63's damaged-stage recovery, and address the already-known OFF default.

   **Deterministic later test / coverage:** Use an isolated net48 AutoCAD test profile and authentic synthetic signed package, choosing a staging-root length that makes the longest final file 240 characters with the PR's 29-character final directory. Click `CEMANAGER` → `Get update ready`. Capture preparation paths during copy: with a 23-character temporary name the corresponding file is 234 characters; with the existing 43-character name it is 254. Assert successful staging, exact approved full hashes and a ready status. Separately change one candidate byte and require the existing signature/hash failure, not success. The PR's arithmetic/string tests do not prove Windows long-path behaviour; actual failure remains suspected until this native exercise.

   **Integration / safety:** C-63 conflicts: `CeUpdateStagingService.cs`, log; C-63 additionally changes damaged-stage recovery. No CE_SHARED change or new engineering number. No new drawing writer/layer/Xref change. Existing signed-update refusals are not new drafting hard blocks. The HOLD is a release-scope decision, not a claim of a newly demonstrated AutoCAD crash.

---

1. **Summary.** Fifteen PRs covered: two require fixes, three are held, ten rejected as superseded. Three new or corrected findings: bracketed filenames escape the privacy filter, the standards citation bug fix defaults OFF, and missing Help notices depend on recent command context. Earlier defects are referenced without recounting them. Installer and signed-update changes stay held. No code, drawing, settings, build or test was changed or run. Only this findings file is the session's deliverable.
