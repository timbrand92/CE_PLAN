1. **ANSWER FIRST — HIGH 0 / MEDIUM 3 / LOW 0.** Three new findings, all SURE and verified-by-reading. No AutoCAD run, build or test was performed. This is the RD07 Structural concrete and lap audit, 23 October 2026, Melbourne date.

2. **Most important — a rebated beam can have overlapping bars without a warning.** For a 200 mm deep beam with a 75 mm rebate, the window checks and previews the full 200 mm. The drawing puts the bars into the remaining 125 mm. The example below produces overlapping top and bottom bars.

3. **Second — making the beam narrower can remove its warning.** When cover and stirrups consume the entire width, CE stops checking whether the bars fit. The warning disappears at precisely the point where no internal width remains.

4. **Third — a correct bar spacing can attract a false warning.** Two N16 bars drawn 294 mm apart are reported as 310 mm apart, prompting an unnecessary crack-control warning.

5. **Standards limit.** The previously reported cover, lap and steel-grade concerns are excluded from these counts. I could verify the standard's edition/amendment information, but not certify its full numerical requirements from authoritative material accessed here. Unverified clause references stay UNVERIFIED. These three new findings are geometry and arithmetic faults; none depends on guessing a clause.

---

1. **Technical scope and pinned source.** Fetched origin in `C:\Lisp Files\CE_ACAD_PLUGIN`. Structural source: `origin/claude/rel-20261023s`, commit `e6d597c0fbc25e78118760887a70810e0890c9a9` (release commit labels Structural 1.0.122). Civil/Manager reference resolved to `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`. These are source identities, not an independent inspection of installed DLLs. All source paths below are relative to the plugin repository and line numbers refer to the pinned Structural commit.

2. **Read-only method.** Used an isolated detached worktree at `C:\ce-cx\rd07`, with no branch, source edit or source commit. Read source using git show/grep/diff. Checked BUG_CARPARK before the source hunt and again against the specific new symptoms. Consulted AUDIT_C58_C60_S40_S41_2026-10-22.md, the three CODEX_AUDIT_*_22OCT reports, and AUDIT_ENGINEERING_STRUCTURAL_2026-10-22.md. The audited catalogue, standards service, reinforcement service, RC member dialog and RC beam command have no diff from the previous Structural release reference. These are inherited defects, not claimed regressions in S-42.

3. **Known issues excluded.** BUG-534. BUG-537. BUG-613. BUG-956.

4. **Evidence meaning.** SURE / verified-by-reading establishes the reachable command path and arithmetic. Actual AutoCAD appearance and command execution remain untested. Every deterministic test below is a proposed test for the authorised test lane, NOT RUN here. Use synthetic copies on AutoCAD 2024/net48 and 2027/net10; no client drawing is needed. No new hard block is proposed: warn and allow continuation under R-27.

---

1. **RD07-01 — MEDIUM — SURE / verified-by-reading: rebated-beam warnings and preview use more depth than the placed reinforcement.**

   **File:line:** `Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.cs:251`, `:254`, `:532`, `:546`; actual placement `Modules/Structural/Commands/SectionDetailCommands.cs:126`, `:129`, `:143`, `:150`. The Type 6 and Type 7 routes also reduce the reinforcement depth.

   **What the drafter sees:** the beam window shows top and bottom reinforcement separated and gives no depth warning. After Place Section, those rows overlap in the drawing. Increasing the rebate does not update the window to show the space actually available for the bars.

   **Exact failure scenario:** Type 4 Edge + Rebate; width 300 mm, depth 200 mm, rebate width 100 mm, rebate depth 75 mm, slab thickness 100 mm; cover to ties 40 mm; N10 stirrups; bottom 3 N16; top 2 N12. The warning computes a required depth of 153 mm but compares it with 200 mm. The writer uses 200 - 75 = 125 mm. At DIMSCALE 20 and insertion 0,0, bottom bar centres are at y=58, and top bar centres at y=69. The left centres are (58,58) and (56,69); their distance is about 11.18 mm, less than the combined radii of 14 mm. The bars physically overlap. The preview instead puts the top row at y=144.

   **DETERMINISTIC TEST — fixture and typed/clicked steps:** new synthetic millimetre model drawing; World UCS, INSUNITS 4, DIMSCALE 20; relevant layers on, thawed and unlocked. Type RCBEAM. On Beam Types, click Type 4 Edge + Rebate; retain Single Cogged ligature and click Place Section. Enter the values above, tick Top bars, and select its size/count. Before placing, record the window text and preview. Click Place Section and enter 0,0.

   **Assertions:** the window must warn that only 125 mm remains for the reinforcement, less than the currently calculated 153 mm requirement; its preview must show the same reinforcement positions as the writer. Current code produces no such warning and previews the wrong top-row position. Read the placed bar centres and diameters to confirm the coordinates above. Do not assert that a fix silently changes the engineer's bar sizes or cover: the minimum correction is an accurate warning and preview while continuation remains available.

   **Smallest fix:** calculate the effective reinforcement bounds once for the selected beam type and pass those bounds to the existing warning, preview and writer. Subtract the rebate for these types before the depth check. Keep engineering spacing limits on the Settings page under R-00; no new fixed limit is needed for the geometry correction. AS 3600 clause for the minimum vertical gap: UNVERIFIED; the overlap proof is independent of it.

2. **RD07-02 — MEDIUM — SURE / verified-by-reading: the no-room warning disappears when available width reaches zero.**

   **File:line:** `Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.cs:206`, `:210`, `:218`, `:228`, `:235`, `:264`, `:349`; placement `Modules/Structural/Commands/SectionDetailCommands.cs:142`; bar distribution `Modules/Structural/Services/StructuralDetailService.cs:1447`.

   **What the drafter sees:** increasing cover can remove a red warning, even though it makes the reinforcement less able to fit. CE still offers Place Section. The missing warning, rather than the ability to continue, is the defect.

   **Exact failure scenario:** Plain beam 150 x 500 mm; N10 stirrups; 3 N16 bottom bars; top bars off. At cover 64 mm, available width is 2 mm and CE warns. At cover 65 mm, it is 0 mm and every horizontal-fit check is skipped because each requires available width greater than zero. Cover and depth checks add no other warning, so the entire Design Checks panel disappears. Placement at scale 20 uses bottom-bar centres x=83, 75 and 67 mm: the order reverses and adjacent 16 mm bars overlap.

   **DETERMINISTIC TEST — fixture and typed/clicked steps:** use a fresh copy of the fixture from RD07-01. Type RCBEAM, select Plain Beam (no slab), click Place Section. Set width 150, depth 500, N10 stirrups, bottom 3 N16, Top bars unticked, cover 64. Record the warning. Change only cover to 65, then 66.

   **Assertions:** a no-room warning must remain visible at both 65 and 66 mm. A suitable corrected text is "Cover and stirrups leave no room for the bottom bars." Current code shows no warning at either value. Optional placement at cover 65 and 0,0 confirms the x coordinates above; the test does not require refusal. Control: width 300, depth 500, cover 40, same bars should remove this no-room warning.

   **Smallest fix:** explicitly report zero/negative available width, then run the existing spacing calculation only when its inputs are meaningful. Do the equivalent for the top row. This is a sign/geometry correction and introduces no new engineering number. AS 3600 clause: UNVERIFIED and unnecessary to prove that zero width cannot contain three bars.

3. **RD07-03 — MEDIUM — SURE / verified-by-reading: the centre-spacing warning adds one extra bar diameter.**

   **File:line:** `Modules/Structural/UI/Dialogs/RCMemberDialog.xaml.cs:244`, `:247`; placement `Modules/Structural/Commands/SectionDetailCommands.cs:142`, `:144`; distribution `Modules/Structural/Services/StructuralDetailService.cs:1447` to `:1451`.

   **What the drafter sees:** CE warns that the bars are more widely spaced than they actually are. A drafter can unnecessarily change a correct detail in response to the warning.

   **Exact failure scenario:** Plain beam 410 x 500 mm, cover 40 mm, N10 stirrups, bottom 2 N16, top bars off. Available width inside the ties is 310 mm. Centres are at x=58 and x=352, giving 294 mm centre spacing. The warning computes (310 - 16)/(2 - 1) + 16 = 310 mm. It therefore exceeds its own 300 mm trigger despite the actual 294 mm spacing.

   **DETERMINISTIC TEST — fixture and typed/clicked steps:** use another fresh copy of the fixture. Type RCBEAM, select Plain Beam (no slab), click Place Section. Enter the values above. Record the bottom-bar c/c warning, then click Place Section and enter 0,0. Measure between the two bar centres.

   **Assertions:** the drawing centre distance is 294 mm and the window must not claim it is 310 mm. With the existing 300 mm threshold, this fixture must not receive the over-300 spacing warning. Current code prints the warning beginning "Bottom bar c/c spacing 310mm is more than 300mm". Positive control: change width to 430 mm; actual spacing is 314 mm, so the current threshold should warn and report 314, not 330.

   **Smallest fix:** remove the final addition of botDia, giving (availW - botDia)/(botN - 1), or derive the distance from the same bar centres the writer uses. This corrects the reported measurement without certifying the hard-coded threshold. Its AS 3600 clause and general applicability remain UNVERIFIED; treatment of that engineering limit belongs with the existing standards/Settings issue.

---

1. **Table and calculation coverage.** Read `Modules/Structural/Assets/Config/rebar-catalogue.json:3` to `:15`, its fallback and data mapping in `Services/ReinforcementService.cs:105` to `:130`, and `Services/StandardsService.cs:71` to `:149`. Followed callers of StandardLapLength, MinCoverConcrete, MinCoverExposed, GetMinCover, GetSteelGrades and GetConcreteGrades. Also read the live RCBEAM cover/spacing warnings and the note cover block at `Core/Notes/GeneralNotesAssembler.cs:145`. The shipped notes file explicitly contains example wording, not a certified office design table.

2. **Runtime reach.** Searches found no command consumer of the stored lap/cover properties or the GetMinCover/GetSteelGrades methods. GetConcreteGrades feeds the Layer Manager list. Searches of both Modules/Structural and Modules/Structural.DesignCore found no active reinforcement development-length solver. Consequently this audit does not claim a drafter currently receives an undersized calculated lap from those dormant values. Their previously reported defects are not new findings.

3. **AS 3600 verification boundary.** The publisher/distributor's [AS 3600:2018 preview](https://i2.saiglobal.com/mpc2v/preview/863153887416.pdf?sku=98877_SAIG_AS_AS_207930), pages 1 to 4 of the PDF, confirms the edition and incorporation of Amendments 1 and 2, including the May 2021 reissue. It is only a six-page sample and does not supply the numerical cover/lap provisions needed to certify these tables. The [SRIA October 2025 technical note](https://www.sria.com.au/wp-content/uploads/2025/10/Tech-Note-6-25-10-2025-Final-Document.pdf), page 2, distinguishes reinforcement material requirements under AS/NZS 4671 from concrete design under AS 3600; its Class L mesh example is not a substitute for verifying this code's Class N bar laps or structural-section grades. Exact normative table values and clause references not independently obtained here are UNVERIFIED. No remembered standard values have been promoted to verified facts.

4. **What I did NOT check.** No AutoCAD, accoreconsole, builds, unit tests, rendered windows, installation, settings edits or sub-agents. No inspection of the live DLLs, live office master notes or project-specific exposure/strength/fire requirements. No certified comparison against the complete amended AS 3600 text or complete steel supplier catalogues. No Civil/Manager functional review or release-gate decision. Native test instructions above remain pending; no bug is marked fixed or accepted.

5. **Repository boundary.** Only this report is authored in CE_PLAN. The detached source worktree is removed at the end. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md are untouched. No source branch, source commit, PR, build or deployment is part of this hunt.

---

1. **Summary — 76 words.** Three new MEDIUM faults affect RCBEAM: rebated details are checked and previewed using too much depth, no-room warnings vanish at zero available width, and centre spacing is overstated by one bar diameter. Each has a synthetic, deterministic AutoCAD test and a small correction that preserves warn-and-continue behaviour. Previously reported table issues are excluded. Development-length calculation was not found on an active path. Standard-value certification and all native checks remain unverified. Only the findings report was changed.
