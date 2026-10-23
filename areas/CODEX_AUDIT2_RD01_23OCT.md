1. **ANSWER FIRST — HIGH 0 / MEDIUM 1 / LOW 1.** Two NEW findings, both SURE and verified-by-reading. No AutoCAD reproduction is claimed. Known bugs are excluded from these counts.

2. **Most important — RD01-01, MEDIUM:** the Pit Schedule decides whether a pit is shallow using a hidden, fixed 300 mm depth. A 290 mm pit reads "Shallow" and a 310 mm pit reads "OK"; the office cannot change that threshold on the Settings page.

3. **Second — RD01-02, LOW:** Pipe Flows tells the drafter that concrete roughness is 0.013 and PVC is 0.010, explicitly calling them "office Settings values". Those words stay fixed when the real office values change. A selected pipe can therefore show a different, correctly loaded value beside contradictory advice.

4. **Top-three limit:** only two new findings qualified. No third new finding was established. No separate engineering-value fault was established in Manager's inspected code.

5. **Outcome:** findings only. No code, live settings, drawings or installed files changed; no build, test, installation or AutoCAD session. The tests below are instructions for a later AI tester on synthetic copies, not a request for Tim to test.

---

1. **Scope and evidence — 23 October 2026, Melbourne.** RD01, Settings-first audit for the Civil + Manager colleague release on 9 November. Read RULES.md, ROUTER.md, the CE plan/map and council-rulebook area. Searched BUG_CARPARK.md first and checked the supplied C58/C60/S40/S41 and CODEX_AUDIT_*_22OCT reports before accepting new findings. Followed the older R00 Civil inventory and the 22 October engineering audit to resolve duplicates.

   Fetched the plugin repository and pinned Civil + Manager to `origin/claude/rel-20261023m`, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (source version Civil 3.0.72 / Manager 1.1.72). Read Git objects using `git show`, `git grep` and `git ls-tree` from an isolated detached worktree at `C:\ce-cx\rd01`. No branch was created. All code references below belong to that commit, with paths relative to the plugin repository. Installed DLLs were not inspected: the installed-version description comes from the brief, not this audit.

   The Structural reference resolved to `e6d597c0fbc25e78118760887a70810e0890c9a9`; Structural implementation was outside this Civil + Manager audit. The later, area-specific release references take precedence over the earlier 22 October references in the brief.

2. **Finding RD01-01 — MEDIUM — SURE — verified-by-reading: the Pit Schedule's shallow-depth decision is fixed at 300 mm.**

   **File:line:** `Modules/Drainage/ViewModels/PitScheduleViewModel.cs:38`; `Modules/Drainage/ViewModels/PitScheduleViewModel.Data.cs:2183`, `:2196`; `Modules/Drainage/ViewModels/PitScheduleRow.cs:505`; `Modules/Drainage/Dialogs/PitScheduleDialog.xaml:620`, `:628`.

   **What the drafter sees:** PITSCHEDULE applies a caution background and the STATE word "Shallow" below 300 mm, then changes to "OK" at 300 mm. The office cannot set its own shallow-pit threshold. The engineering number behind this judgement is absent from Settings.

   **Exact failure scenario:** an office wants to review pits shallower than 450 mm. A pit with a known depth of 310 mm receives "OK" in the schedule's STATE column. There is no shallow-pit-depth field to change. The 450 mm here is a synthetic test requirement, not a proposed Australian Standard or an approved office value.

   **Proof:** `ShallowDepthThreshold = 0.30` is a private constant. `UpdateWarning` compares the effective depth directly with it; `HealthStateLabel` maps that result to "Shallow" or "OK". The XAML binds both the row caution colour and STATE to these results. No Settings reader participates in this threshold. Searches of the standalone Settings page, Civil's embedded Settings view, their view model, UserSettings and Manager's Settings surface found no shallow-depth field. Manager hosts Civil's supplied view through `Modules/Manager/Services/CeCivilSettingsBridgeSession.cs:145`, `:165`; it provides no alternate editor for this number.

   **DETERMINISTIC TEST — NOT RUN:** use a new synthetic millimetre Civil drawing with no linked pits. Type `PITSCHEDULE`. Untick "Auto-calculate depth". Click "+ Add Row" three times; name the manual rows AUDIT-A, AUDIT-B and AUDIT-C. Leave Cover, inlet and outlet levels empty. Enter Depth 0.29, 0.30 and 0.31 m respectively, committing each cell with Tab. Assert the STATE window text is "Shallow", "OK", "OK" respectively. This follows the manual-row path, so no pipe level or pit geometry needs to move. Close the window; type `CDS` and inspect Pipes and Pits and Design: assert that an editable shallow-pit-depth threshold is available. That last assertion fails by reading the current page definitions.

   **After-fix assertion:** with the proposed Settings row set to the test value 450 mm, reopen PITSCHEDULE and require all three manual rows to say "Shallow". Restore the original setting and verify the original bytes/hash after the later test. A focused regression should also drive `AddRowCommand` and the real Depth-change handler, not test a copied comparison.

   **Smallest fix:** add one named shallow-pit-depth value and a plain-English Settings row, persist it through the existing Settings view model, and have `UpdateWarning` read it. Preserve 300 mm as the migration seed until Tim approves another value. Do not silently reuse minimum PIPE cover: pit depth and soil cover over a pipe are different measurements. Keep the result advisory, consistent with R-27.

3. **Finding RD01-02 — LOW — SURE — verified-by-reading: Pipe Flows presents hard-coded roughness advice as live office Settings.**

   **File:line:** `Modules/Drainage/Dialogs/CalculationsV2Dialog.xaml:588`, `:590`; actual reader `Modules/Drainage/Services/CdCalcPrefillService.cs:85`; `Modules/Drainage/Services/DesignValidationService.cs:243`; field population `Modules/Drainage/ViewModels/PipeFlowCalcViewModel.cs:209`.

   **What the drafter sees:** CDCALC > Pipe Flows can load the office's PVC roughness as 0.015, while the note beside it still says "0.010 = PVC" and the hover text calls 0.010 the office Settings value. A drafter trying to reconcile them can replace the correct loaded number with the fixed advice. This is incorrect engineering information, not a wording preference.

   **Exact failure scenario:** the test office's `designStandards.manningsNByMaterial` sets UPVC and PVC to 0.015. Pick a registered UPVC pipe in a fresh Pipe Flows panel whose roughness is still at the factory starting value. The selected pipe fills Roughness with 0.015 through the real Settings reader. Neither the visible material note nor its tooltip has a binding; both continue to give PVC as 0.010. The calculator itself uses the field value. This finding does not claim that the tooltip automatically changes a result.

   **Proof:** both advice strings are literal XAML text. `CdCalcPrefillService` resolves the pipe material through `DesignValidationService.GetManningsN`; its lookup reads the live `ManningsNByMaterial` dictionary. `ApplyCdCalcPrefill` writes that result into Roughness. Thus the advice and the calculation have separate sources. The test value 0.015 is within the reader's accepted 0.009 to 0.030 range (`Modules/Drainage/Models/UserSettings.cs:1878`).

   **DETERMINISTIC TEST — NOT RUN:** prepare a synthetic drawing with one registered pipe AUDIT-P, material UPVC, diameter 300 mm, positive length and known falling inverts; no saved calculation workspace. In an isolated test settings profile, set both UPVC and PVC Manning n entries to 0.015 before loading Civil. The later tester must back up and hash the settings file and restore it exactly afterwards. Type `CDCALC`, open "Pipe Flows", then choose AUDIT-P under "SELECT FROM DRAWING". Assert the Roughness box reads `0.015`. Hover "Manning's n:" and assert that text explicitly labelled "office Settings values" gives PVC as `0.015`, matching the input; also assert the adjacent PVC advice agrees. Current source yields `0.015` in the box but `0.010` in both advice strings. No second pipe pick is needed.

   **Smallest fix:** remove the fixed numbers from the advice, or bind a clearly labelled office-reference note to the same Settings lookup used by prefill. Keep manually typed roughness separate from office reference values. This can be corrected without changing hydraulic calculations or choosing a new engineering value.

4. **Already known — excluded; BUG numbers only.**

   **BUG-004, BUG-252, BUG-255, BUG-282, BUG-419, BUG-521, BUG-538, BUG-539, BUG-540, BUG-541, BUG-542, BUG-543, BUG-544, BUG-545, BUG-546, BUG-547, BUG-785, BUG-790, BUG-825, BUG-908, BUG-980.**

5. **Coverage and exclusions.** Searched Civil and Manager for engineering constants and material/grade/cover/velocity/spacing/colour readers; traced candidate values through Settings definitions and reachable commands or windows. Checked the older R00 inventory before ranking. This is a targeted source audit, not proof that every engineering literal has been found. Known numbers are not new findings merely because a later file has another copy.

   No new numerical rule was assigned to Manager merely because it hosts Civil Settings. Manager administration and release work stayed parked. Uncalled generators, illustrative geometry, AutoCAD protocol numbers, unit conversions and numerical precision guards were not counted as engineering faults.

   Surface-overlay colours explicitly cite Tim's fixed-colour ruling in `Modules/Drainage/Models/SurfaceColourMap.cs:50`; those were not treated as an unapproved value on the strength of a literal alone. WSUD's older read-only page and treatment coefficients were examined but are not counted as a newly demonstrated editable workflow fault here.

6. **What I did NOT check.** No AutoCAD command was run; no window was opened or rendered; no fixture was created; no unit test, build, calculation export, installer or runtime setting change was performed. Drawing persistence, Undo/Redo, plotted appearance, native tooltip behaviour and the proposed acceptance tests remain unverified. No current council document or Australian Standard was independently validated. No engineering value is approved by this report. The source proves the paths and displayed strings, not that Tim or a colleague has encountered them.

7. **Delivery boundary.** The only authored repository file is `areas/CODEX_AUDIT2_RD01_23OCT.md` in CE_PLAN. BUG_CARPARK.md, DESK_LOG.md, QUEUE.md and all code were left untouched. The detached audit worktree is disposable and will be removed at completion. No source commit, branch or PR is required by this read-only brief. Unrelated existing changes in the shared folders were not staged.

8. **Summary — under 100 words.** Two new Settings-first defects were established by reading: a fixed 300 mm shallow-pit threshold controls schedule warnings, and Pipe Flows calls fixed roughness advice the office Settings even when the loaded value differs. The earlier audits already cover most engineering constants, so those appear only as BUG numbers. No separate Manager engineering fault was established. Both findings have deterministic future tests and small correction directions. No code, settings or drawings changed, and no tests ran.
