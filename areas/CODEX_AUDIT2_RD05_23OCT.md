**ANSWER FIRST — RD05, Australian drainage standard check — 23 October 2026, Melbourne**

1. **Counts: HIGH 1 / MEDIUM 3 / LOW 1.** Five new findings, verified-by-reading at Civil 3.0.72. No AutoCAD reproduction or test was run. SURE refers to the code behaviour; the limits on verification of council requirements are stated below.

2. **Most important — floor clearance is not checked.** CDTWL can say the storage is enough when the chosen water level is only 100 mm below a habitable floor. Frankston requires 300 mm. The command does not obtain that floor level or say the floor check was omitted.

3. **Second — council velocity limits do not reach the checks.** For example, Banyule's recorded minimum is 1.0 m/s, but CE can pass a pipe at about 0.80 m/s against its office 0.6 m/s. Maroondah's recorded maximum is 5.0 m/s; the concrete-pipe check still uses 6.0 m/s.

4. **Third — Darebin pit spacing is missed.** A straight 40 m pipe receives no run-length warning because the default is 80 m, while the project's Darebin record says 30 m.

5. **Other findings.** Maroondah's recorded 150 mm pipe grade of 1 in 80 is not applied: 1 in 100 passes the grade row. A fresh profile also identifies the standard edition as 2021, although Victorian regulator guidance identifies 2025 for work commencing from 20 October 2025.

6. **Action for the office.** These checks need warnings naming the applicable council requirement, or an explicit statement that the requirement was not checked. Keep the engineer able to continue under R-27. Put any new engineering values and their sources on Settings under R-00. This report authorises no implementation or restart of parked work.

---

**Technical scope and evidence**

1. **Pinned code.** Fetched origin in C:\Lisp Files\CE_ACAD_PLUGIN. Created only a detached, read-only review worktree at C:\ce-cx\rd05 from origin/claude/rel-20261023m, commit `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (Civil 3.0.72 / Manager 1.1.72 source). All source references below are relative to that commit. The later, explicit 23 October instruction supersedes the earlier 22 October baseline. Structural reference resolved to `e6d597c0fbc25e78118760887a70810e0890c9a9`; Structural was not audited.

2. **Method.** Used git show, git grep, git ls-tree and a scoped git diff. Read the requested rules/router, CE plan and engineering rulings; screened the specified 22 October audits, the Civil engineering audit and findings ledger; searched BUG_CARPARK before reviewing and again for each candidate. Findings describe active command paths, not test-only engines. Existing plan documents already identify several missing council data categories; these findings establish their concrete consequences in the pinned commands.

3. **Source limits.** AS/NZS 3500.3:2025 full normative text was not available in this audit. Every AS/NZS numerical clause/table attribution is **UNVERIFIED** here. No clause number is asserted. The regulator's edition guidance and Frankston's own OSD PDF were read online. Maroondah's official PDF returned HTTP 403 and Darebin's linked PDF could not be retrieved; their comparisons below use the project's recorded council extracts, not a claim of renewed primary-document verification. No commercial calculator or third-party copy was used as authority.

4. **Test status.** Every DETERMINISTIC TEST below is a proposed test for a later AI test lane, **NOT RUN**. Use synthetic DWGs, millimetre geometry with INSUNITS 4, levels in metres, World UCS, isolated default Settings and the pinned build. Preserve test fixtures independently from Tim's working drawings/settings. A fixture may be prepared by the later test harness; no fixture was created in this audit.

5. **Severity.** HIGH: missing protection against an unsafe water-level decision. MEDIUM: a named engineering check can pass against the wrong council threshold. LOW: an incorrect reference/default without a demonstrated numerical design change. SURE means control flow and values are verified-by-reading, not Robot-accepted.

**Numbered new findings**

1. **RD05-01 — HIGH — CDTWL has no effective habitable-floor freeboard check. SURE; verified-by-reading.**

   **File:line.** `Modules/Drainage/Commands/DetentionTwlCommand.cs:57` calls Prepare without lowestFloorLevel; `Services/DetentionTwlService.cs:165` defaults it to NaN; `Rules/DetentionTwlSolver.cs:208` checks only water ABOVE a supplied floor, with no clearance allowance. `Services/DetentionTwlService.cs:277` and `:352` check lids for the chosen level. `Models/UserSettings.cs:1972` supplies 150 mm water-to-lid clearance, not water-to-floor clearance. The comparison description at `Rules/DetentionTwlSolver.cs:85` does not include its Warnings collection.

   **What Tim would see.** The command reports the chosen water level, how much storage it holds, and “That is enough.” A building floor only 100 mm above that water receives no warning. The volume statement is about volume; the fault is that the missing floor check is not disclosed.

   **Exact failure scenario.** A Frankston below-ground detention system has chosen TWL 10.100 m, pit lid 10.600 m and habitable floor 10.200 m. The lid has ample clearance, but the floor has only 100 mm. The native command supplies no floor to the solver. Even a caller supplying 10.200 would not trigger the solver's strict water-above-floor test. Its comparison is also against the solved volume level, not necessarily the user's chosen level.

   **Authority.** The project's `docs/workflows/COUNCIL_FRANKSTON_OSD_2021.md:57` records 300 mm. Independently verified in [Frankston OSD Guidelines, September 2021, printed page 4](https://www.frankston.vic.gov.au/files/assets/public/v/1/planning-and-building/pdfs/on-site-detention-guidelines.pdf). This is a council requirement; AS/NZS clause **UNVERIFIED**. Tim's 150 mm pit-lid rule remains valid for its separate purpose.

   **DETERMINISTIC TEST.** Fixture: one CE detention pit P1, Main schedule set, internal dimensions 1000 by 1000 mm, floor/invert 9.600 m, lid 10.600 m; no upstream pipes/tanks; habitable floor evidence FFL-A = 10.200 m. Select Frankston using `CDRULEBOOK`, `Council`, `frankston`. Type `CDTWL`; enter required volume `0.5` m3; at the top-water-level question type `10.10` explicitly. This pit holds 500 L at that level.

   **Assertion.** Command text and the CE log's `[TWL]` line must report either “100 mm below the habitable floor; 300 mm required” when accepted floor evidence is available, or “Habitable-floor freeboard not checked: floor level is not recorded” when it is unavailable. Current source predicts neither sentence, alongside “That is enough.” No parsing of an arbitrary FFL text is assumed. Companion deterministic call: Prepare with lowestFloorLevel 10.200 and the same storage, then Describe with the chosen 10.100 level; assert a floor-clearance warning reaches Lines, not merely an internal result.

   **Smallest fix.** Immediately disclose the missing floor check. Resolve a separately sourced council floor-clearance value and accepted floor evidence, and warn against the CHOSEN water level. Keep the pit-lid value separate. Never set TWL from the floor or block the command.

2. **RD05-02 — MEDIUM — council velocity bands are ignored by R-01/R-02. SURE against the recorded practice; verified-by-reading. Current council-document applicability beyond those records is UNSURE.**

   **File:line and values.** `Modules/Drainage/Models/UserSettings.cs:1836`: minimum 0.6 m/s. `Services/MaterialVelocityLimits.cs:40`: concrete maximum 6.0 m/s. `Rules/RulebookValues.cs:181` builds the office scour table; `:195` reads only office minimum velocity. `Rules/RulebookEngine.cs:448` computes full-bore velocity; `:463` compares the office maximum and `:472` compares the office minimum. Council selection is available to Resolve but does not change these limits.

   **What Tim would see.** Picking the council changes the named council and some other rules, but the velocity rows retain the office limits. A passing R-02 or R-01 is therefore not a pass against that council's recorded band. Other rows can still warn; this finding does not claim the whole drawing is reported clean.

   **Exact failure scenarios.** Banyule: DN225 RCP, Manning n 0.013, 20 m long, fall 0.100 m, full-bore speed approximately 0.80 m/s. R-02 passes 0.6; the recorded council minimum is 1.0. Maroondah: DN600 RCP, n 0.013, 17 m long, fall 1.000 m, speed approximately 5.27 m/s. R-01 passes 6.0; the recorded full-flow maximum is 5.0. Both are full-bore comparisons, so this is independent of the already-audited part-full issue.

   **Authority.** `docs/workflows/COUNCIL_BANYULE_2019.md:68` records 1.0–6.0 m/s. `docs/workflows/COUNCIL_MAROONDAH_GUIDELINES.md:142` records minimum 0.75 m/s at half full or greater, 1.0 below half full, maximum 5.0. `docs/workflows/COUNCIL_FRANKSTON_DEV_GUIDELINES.md:65` records 0.7 / 1.0 / 6.0. These are council records, not one universal Australian limit. AS/NZS clauses **UNVERIFIED**. The office source-label helper attributes 0.6 to a concrete-pipe manual; that attribution was not independently verified and does not override a council rule.

   **DETERMINISTIC TEST.** Fixture A: CE pits P1 at (0,0), P2 at (20000,0), a straight DN225 RCP gravity pipe P1-P2 with inverts 10.100/10.000; ample cover. In isolated Settings confirm RCP n = 0.013 to remove the unrelated roughness warning. Type `CDRULEBOOK`, `Council`, `banyule`; then `CDRULES`, `All`. Read the saved full listing as well as the command line.

   **Assertion A.** P1-P2's R-02 must warn that about 0.80 is below 1.0 m/s, or explicitly say the council velocity check was not performed. Current source predicts R-02 Pass with 0.6 m/s as its value. Fixture B: separate drawing, P1/P2 17000 mm apart, DN600 RCP, inverts 11.000/10.000, council `maroondah`. Repeat `CDRULES All`. Assert R-01 warns that about 5.27 exceeds 5.0 m/s; current source predicts Pass against 6.0. Judge those specific rows, not unrelated pit-outlet-speed warnings.

   **Smallest fix.** Resolve applicable council bands as sourced, editable Settings data, with their flow condition. Until supported, identify that the row checks the office rule only and that the council band remains unchecked. Do not replace every council with one stricter global value.

3. **RD05-03 — MEDIUM — 80 m run-length default misses Darebin's recorded 30 m pit spacing. SURE against the recorded practice; verified-by-reading. Current council PDF not reverified.**

   **File:line and value.** `Modules/Drainage/Models/UserSettings.cs:1851`: MaxPipeRunLengthM = 80.0 m. Its preceding comment claims it covers most councils, without a source. `Services/DesignValidationService.cs:424` warns only above that value. `Services/DesignReviewService.cs:63` resolves office standards; `Commands/DashboardCommands.cs:73` supplies pits/pipes, not council requirements.

   **What Tim would see.** A 40 m Darebin pipe is absent from the Design Review's long-run warnings. The drafter misses the instruction to add an intermediate pit or seek an approved exception.

   **Exact failure scenario.** The job has Darebin selected, office defaults unchanged, and a straight 40 m gravity pipe between two pits with no intermediate access pit. It is below 80 m, so CheckPipeRunLength adds no warning. This remains true with the current office-settings reader ON; it is not the earlier fixed Settings-reader fault.

   **Authority.** `docs/workflows/COUNCIL_DAREBIN_LPD_2025.md:69` records a maximum 30 m between pits; `docs/workflows/COUNCIL_RULES_V3_INTEGRATION.md:96` repeats that requirement. [Darebin's current drainage-plan page](https://www.darebin.vic.gov.au/Planning-and-building/Building-and-renovations/Building-step-1-gather-information/Types-of-building-permits/Non-building-applications-and-permits/Stormwater-drainage-plans) directs applicants to its legal-point-of-discharge guidelines. The linked PDF was not retrievable here. AS/NZS clause **UNVERIFIED**; no universal AS/NZS 30 m limit is asserted.

   **DETERMINISTIC TEST.** Fixture: P1 (0,0), P2 (40000,0), straight DN225 RCP pipe, inverts 10.200/10.000, adequate cover, no intermediate pits, office MaxPipeRunLengthM 80. Set `CDRULEBOOK Council darebin`. Type `CDDASHBOARD`; clear filters to show every issue and inspect the pipe's design warnings.

   **Assertion.** Window text must identify P1-P2 as 40 m against Darebin's 30 m maximum, or explicitly mark council spacing unchecked. Current source predicts no RUN_LENGTH issue. Repeat with 29 m and adjusted fall preserving 1 in 200: it should not receive that spacing warning. Separately use 81 m to confirm the existing office-length warning is functioning.

   **Smallest fix.** Pass the job's applicable maximum pit interval to the existing run-length check, stored with its source in Settings. Label the 80 m fallback as an office assumption unless a source is established. Warn and continue.

4. **RD05-04 — MEDIUM — Maroondah's ordinary DN150 minimum grade is not applied. SURE against the recorded practice; verified-by-reading. Current council PDF not reverified.**

   **File:line and value.** `Modules/Drainage/Models/UserSettings.cs:1956` seeds DN150 at 1 in 100. `Rules/RulebookValues.cs:200` copies only the office grade ladder. `Rules/RulebookEngine.cs:368` chooses that ladder step and `:389` returns Pass. The council field at `Models/CouncilProfileModels.cs:87` represents a detention minimum, not this general DN150 rule.

   **What Tim would see.** On an ordinary Maroondah gravity drain, R-03 says “actual 1:100, ladder minimum 1:100” and passes. The project's council document calls for 1 in 80.

   **Exact failure scenario.** A straight DN150 ordinary gravity pipe runs 20 m with 0.200 m fall. It is not marked Detention. Selecting Maroondah does not change the ordinary grade ladder, and the separate detention check cannot rescue this case. This finding is the missing council-specific rule, not another report of the known larger-size ladder anomaly.

   **Authority.** `docs/workflows/COUNCIL_MAROONDAH_GUIDELINES.md:145` records DN100 at 1 in 100 and DN150 at 1 in 80, with other diameters controlled by velocity. Maroondah's official guideline page still links the design document, but retrieval of its PDF returned 403. AS/NZS numerical clause and any claim that the office ladder itself violates AS/NZS are **UNVERIFIED**.

   **DETERMINISTIC TEST.** Fixture: P1/P2 20000 mm apart, DN150 UPVC ordinary gravity pipe, inverts 10.200/10.000, ample cover. Type `CDRULEBOOK`, `Council`, `maroondah`; then `CDRULES`, `All`. Assert the R-03 row warns that actual 1 in 100 is flatter than the council's 1 in 80, or identifies the council grade as unchecked. Current source predicts Pass at 1 in 100. Control: change the upstream invert to 10.250, preserving the downstream 10.000; assert the council minimum-grade warning clears at exactly 1 in 80.

   **Smallest fix.** Resolve ordinary council grade requirements by size/use before the office fallback, with both values and source shown. Keep separate detention and outlet requirements separate; expose the council rule on Settings.

5. **RD05-05 — LOW — fresh Settings still identify the current standard as 2021. SURE; verified-by-reading and regulator guidance.**

   **File:line and value.** `Modules/Drainage/Models/UserSettings.cs:1999`: AsNzs3500Edition = “2021”. `Rules/RulebookValues.cs:249` copies the office string. `Commands/RulesCommand.cs:255` prints it under R-24. `Rules/RulebookEngine.cs:48` explicitly lists edition checking as not evaluated; this is not proof that the calculations implement either edition.

   **What Tim would see.** On a new October 2026 job, CDRULES Values prints “R-24 AS/NZS 3500.3 edition: 2021”. An office relying on that reference can start a new job against the wrong edition.

   **Exact failure scenario.** A fresh isolated Settings profile, no manually selected legacy edition, and new Victorian plumbing work commencing after the regulator's transition date. The default remains 2021 because it was copied from the older office ruling. CE_PLAN's R-24 also still says “2021 today”; this is a stale source/default chain, not an unexplained builder choice.

   **Authority.** [Victorian regulator: updated stormwater drainage standard](https://www.vba.vic.gov.au/plumbing/plumbing-regulatory-framework/updated-plumbing-and-drainage-standards-asnzs-3500-series/part-3-stormwater-drainage) identifies the 2025 edition and commencement from 20 October 2025. No numerical clause is inferred from that change notice.

   **DETERMINISTIC TEST.** Fixture: new synthetic job and clean isolated default Settings. Type `CDRULES`, `Values`. Assert the edition line identifies the applicable current edition or expressly says the job's edition needs confirmation. Current source predicts the exact 2021 line above. Regression control for the eventual fix: an old job with an explicitly retained 2021 issued edition must retain that edition and receive an appropriate current-edition notice, not be silently relabelled.

   **Smallest fix.** Correct the fresh-profile reference after confirming applicability, preserve old issued-job editions, and warn when the job edition is unknown or differs. Do not claim 2025 compliance merely by changing the string.

**Default-value coverage and remaining source questions — not additional proven faults**

1. **Minimum cover.** `Models/UserSettings.cs:1770`: 300 mm, expressly supported by Tim's 24 September fresh-install ruling. It is an office starting value, not a verified universal AS/NZS minimum. `Assets/Config/council-profiles.json:362`: Frankston 250 mm; the primary OSD PDF verifies that number for storage pipes, not every pipe/location. No new cover finding is counted.

2. **Minimum grade.** `Models/UserSettings.cs:1752`: global drafting warning 1 in 200. `:1956`: DN90/100/150 = 1 in 100; DN225 = 1 in 200; DN300 = 1 in 250; DN375 = 1 in 300. `:1957`: DN450/525/600/675/750 = 1 in 200. Numerical AS/NZS attribution remains **UNVERIFIED**; `Rules/RulebookValues.cs:343` itself labels an unconfirmed ladder that way. The distinct new council omission is RD05-04.

3. **Maximum grade.** `Models/LevelsProposalSettings.cs:34`: 0 = no maximum; `:48`: warn steeper than 1 in 10. These are sourced to Tim's 5 October INT-059 ruling and are not defects for being permissive. The proposal is OFF by default (`:21`); its warning is not proof every drawing check examines steep pipes. No universal Australian maximum grade is asserted.

4. **Velocity defaults.** `Models/UserSettings.cs:1836`: minimum 0.6 m/s. `Services/MaterialVelocityLimits.cs:39`: plastics 3.0; `:40`: concrete 6.0; `:41`: metals 4.0; `:42`: unknown 6.0 m/s. `Services/PipeSpeedLimitSources.cs:19` identifies plastics/metals/unknown as unconfirmed; concrete is labelled an office rule, and the minimum is attributed to a concrete-pipe manual. That manual attribution is **UNVERIFIED** here. No authoritative basis was found in the inspected evidence for treating all these as AS/NZS limits. The new fault is using the office band without the applicable council band, RD05-02; the unconfirmed labels themselves are honest.

5. **Pit spacing.** `Models/UserSettings.cs:1851`: 80 m general run-length limit, source not established in the inspected records; RD05-03. `:1966`: detention maximum run 40 m is Tim's R-06 house rule, not a general council spacing rule. One cannot substitute for the other.

6. **Pipe size steps.** `Models/PipeSizingModels.cs:75`: 100, 150, 225, 300, 375, 450, 525, 600, 675, 750 mm. `Services/SettingsSizingStandards.cs:40` uses the office list or this fallback. `Assets/Config/network-catalogue.json:69` onwards seeds 225 mm for its listed pipe types; `Models/UserSettings.cs:1976` supplies a separate 100 mm missing-size reference. These are selection/default figures, not proof of hydraulic adequacy or product availability. An authoritative material/product source for the complete shared size sequence was not established: **UNSURE / sourcing gap**, not a counted claim that a particular size is unmanufacturable. Manufacturer bore/outside-diameter and stock-range validation was not done.

7. **Freeboard.** `Models/UserSettings.cs:1055` and `:1972`, `Rules/DetentionTwlSolver.cs:109`: 150 mm pit-lid starting clearance. Tim's R-06 supplies its office authority. It is not a habitable-floor clearance. The council comparison for the latter is RD05-01. Other council distinctions are recorded in `docs/workflows/COUNCIL_RULES_V3_INTEGRATION.md:116`; they were not collapsed into a new universal number.

**Known findings excluded — BUG numbers only**

1. **BUG-080; BUG-255; BUG-282; BUG-431; BUG-516; BUG-520; BUG-521; BUG-527; BUG-545; BUG-546; BUG-547; BUG-790; BUG-825; BUG-867; BUG-868; BUG-870; BUG-871; BUG-901; BUG-902; BUG-903; BUG-1021.**

**What I did NOT check**

1. **Native behaviour.** No AutoCAD launch, screenshots, command execution, Undo/Redo exercise, build, test, installation, live DLL inspection or live Settings read. None of these findings is marked fixed or accepted.

2. **Standards completeness.** No full AS/NZS 3500.3:2025 text, licensed clause-by-clause audit, manufacturer certification, pressure/charged-system design, full hydraulic-grade-line analysis or review of every council. Council records must be checked against the applicable job conditions before design changes. Full AS/NZS numerical compliance remains **UNVERIFIED**.

3. **Other work.** No Manager administrator work, Structural review, code edits, branches, PR, sub-agents or changes to BUG_CARPARK, DESK_LOG or QUEUE. Only this findings file is authored and committed by name in CE_PLAN. The temporary detached review worktree is removed at completion.

**Summary**

1. **Five new findings: one HIGH, three MEDIUM, one LOW.** CDTWL omits habitable-floor freeboard; council velocity, spacing and ordinary pipe-grade requirements do not reach their checks; the fresh standard-edition reference is stale. Office defaults were distinguished from council requirements and unsupported standards claims. Known bugs are excluded. The source paths are verified by reading, with deterministic future tests; no AutoCAD, build or tests were run. Full AS/NZS numerical compliance remains unverified.

