# CODEX independent PR review — Group 07 — 24 October 2026

1. **ANSWER FIRST — six new findings: HIGH 2 · MEDIUM 4 · LOW 0.** All six are verified by reading the code, not by running AutoCAD. Seventeen draft PRs reviewed: nine MERGE, seven MERGE-WITH-FIXES, one HOLD, none REJECT. A previously reported pump-pit warning problem is retained separately and is not counted again.

2. **Most important — #1659 can put a branch connection on the wrong half of a split pipe.** It chooses the end nearest the main instead of the end the drafter actually connected. A branch touching the main at both ends exposes the mistake. Do not merge it until the recorded end is honoured.

3. **Other drawing faults.** #1711 can show another pipe's branch on the selected long section; #1663 still saves after typed PIPEEDIT is cancelled; #1701 can report protected, unregistered objects as successfully repaired; #1709 can omit a boundary crossing on a curved pipe; #1710 can show a gradient and flow where the displayed inverts are equal.

4. **Decision for the release.** Fix #1659, #1663, #1701, #1709, #1710 and #1711; retain Opus's required fix for #1717. Hold #1706 until its clicked-Close failure is demonstrated on the current code. These are review verdicts, not permission to merge, and none is a claim of AutoCAD acceptance.

5. **Read-only work completed.** No code changed, builds, tests, installations, AutoCAD sessions or sub-agents. Only this findings file is being saved in CE_PLAN. Civil and Manager remain the 9 November release; Manager administrator work remains parked.

---

1. **Evidence and limits.** Source was fetched and read through Git in detached worktree C:\ce-cx\review-group07-24oct. No branch was created. The requested installed baseline references resolve to Civil/Manager origin/claude/rel-20261022m at 40ee0a36f7960145743954b39859eb6c3af92869 and Structural origin/claude/rel-20261022s2 at 2c9a96942a024888a5ab520600f2d5025de83036. Installed binaries were not inspected.

2. **PR comparison.** The requested gh pr list --repo timbrand92/CE_ACAD_PLUGIN --state open --limit 300 --json number,title,headRefName,headRefOid,baseRefName was used. The thirteen named PRs plus four further fb/ PRs in FB-22 to FB-25 were reviewed. All seventeen were open drafts at discovery, targeting claude/rel-20261023m, whose fetched tip was f7f7d551552c21db3058ed839abacd1ec8a3b4d4. Reviews compare each exact head below with that actual base; they do not pretend these fixes are already installed.

3. **Prior review accounting.** Read AUDIT_C58_C60_S40_S41_2026-10-22.md and the Civil, Structural and Gate CODEX_AUDIT_*_22OCT.md records before judging new findings. Read REVIEW_MAX_AND_TEAM_PRS_A_23OCT.md and REVIEW_MAX_AND_TEAM_PRS_B_23OCT.md. Also found and read the newer, locally present REVIEW_CX4_AND_BATCH4_24OCT.md. Nine of the seventeen have an Opus review in those records. “No Opus review found” below means absent from the reviewed records, not proof that no private review exists.

4. **Meaning of verdict and test.** MERGE means no new blocking defect established in this source review. Every DETERMINISTIC TEST below is a proposed fixture and observable acceptance check, not an executed test. The review ran zero tests. Source-text assertions, helper tests and builder-reported green suites do not establish native command lifecycle, ribbon behaviour, Undo/Redo or real-window appearance.

5. **Checks applying to every PR below.** Each head's changed-file list leaves CE_SHARED, Manager and Structural source unchanged. No new engineering standard, design threshold or sizing default was found in these diffs. Existing defaults and already-audited hard-coded numbers are not recounted. Settings remain the authority under R-00; no proposed fix adds a new hard block beyond R-27. Where a PR only changes a reader or picture, that is not certification of all older writers it calls.

6. **Common integration issue.** All seventeen add at the top of REGRESSION_LOG.md: preserve every entry when resolving those conflicts. Same-file overlaps and the important semantic conflict are specified below. No trial merge, build or test was performed in the code repository. “No direct overlap” means source inspection found none among these seventeen, apart from the log; it does not promise a conflict-free future merge.

## PR-by-PR decisions

1. **#1659 · FB-02 · MERGE-WITH-FIXES · HIGH F1 — split can move the wrong branch end.**

   **Head / Opus:** fb/fb02-inline-split-decisions, 62a8dea8bc01e2caaeefac30ff55e387c9f9b890. Opus: MERGE at this head in review A. This independent review changes that verdict.

   **Cause and scope:** The missing transfer of explicit connection decisions during an inline split is real. The new policy correctly transfers on-run distances and can change branch targets. The new geometry reader undermines that policy: Modules/Drainage/Services/LinkService.SplitDecisions.cs:56, especially :69, chooses the nearest branch endpoint. It never uses ConnectionDecision.EndIndex. Modules/Drainage/Services/InlineSplitDecisionPolicy.cs:74 trusts the resulting answer. SpineDecisionLedger defines endpoints 0 and 1 separately.

   **What Tim sees / exact failure:** Main A goes from (0,0) to (20000,0) mm. Branch B runs (2000,0), (2000,5000), (14000,5000), (14000,0). Explicitly connect B's end 1 to A at 14 m; end 0 is not that connection. Insert a pit at A's 8 m point. Both branch endpoints have zero distance to A, so the tie chooses end 0 at 2 m. The saved end-1 decision keeps the first-half target although its junction belongs to the second half. The intended connection can disappear from later junction reads.

   **Exact fix:** Resolve the branch vertex from the decision's EndIndex, validate 0/1, and measure that endpoint against the original main. Do not replace an explicit end choice with proximity. Preserve both connected and deliberately disconnected decisions. Unreadable evidence should be reported without inventing a connection.

   **DETERMINISTIC TEST:** Prepare the named A/B fixture with valid CE identities and the explicit end-1 decision. Type PIT, place the new pit at (8000,0), finish the placement and press Escape. Read the drawing's connection ledger: B/end 1 must target the new second-half pipe key, and its junction must be 6 m into that half. Current code retains A's first-half key. U must restore the original key; REDO must restore the second-half key. Repeat with separate decisions for both ends and with an explicit disconnected end.

   **Tests / safety / defaults:** Existing InlineSplitDecisionTests supply a fake branch predicate, so they can pass while the real endpoint reader is wrong. Add a test spanning the endpoint reader and policy. Ledger writes use the existing split transaction; no new idle writer is introduced. Branch geometry is read, not edited. Native locked-main, Xref and REFEDIT refusal/skip behaviour still needs the stated fixture check; this review does not certify inherited split protection. InlineSplitMovesDecisions defaults true, as a bug fix should. Opus already identified the missing Settings row and divergence from another split path: retain those follow-ups, do not count them as new findings.

   **Merge order:** Shares LinkService.Split.cs with #1688, in nearby but distinct additions. Preserve both the decision transfer and the curve/callout rules. F1 is verified-by-reading, not an AutoCAD reproduction.

2. **#1663 · FB-04 · MERGE-WITH-FIXES · MEDIUM F2 — typed PIPEEDIT Cancel still saves.**

   **Head / Opus:** fb/fb04-edit-pipe-cancel, 636e6c48b71488ca13e42913fc93446bd798d4d6. Opus: MERGE at this head in review A. Verdict changed here.

   **Cause and scope:** Holding the project refresh until the edit is accepted addresses a real premature-save route. It does not cover command completion. Modules/Drainage/Services/LinkService.cs:70 still includes PIPEEDIT in RecordFlushCommands. LinkService.Reactors.cs:2040 calls FlushPendingSave for a trigger regardless of pending work. ProjectDataService.Persistence.cs:454 creates pending work even when there was none, then :576 calls SaveToDrawing. SaveToDrawing at :1102 opens the named-object dictionary for write and writes the record. The command's hold is disposed in PipeEditCommand.cs:268 before normal command completion.

   **What Tim sees / exact failure:** In an already loaded, saved Civil drawing, type PIPEEDIT, select an ordinary CE pipe and click Cancel. The window rolls its temporary data back, but completion of the typed command creates a fresh save. Cancel can still mark the drawing changed and insert record work into Undo. This finding is the command-end route, not the previously audited SetDrawingPath-before-hold issue.

   **Second hole in the same acceptance boundary:** PipeEditCommand.cs:111 calls openHold.Accept() before checking whether the refusal is an older-pipe case and before the drafter answers its question. A refusal or No/Escape can therefore release pending refresh writes. Only an actual accepted writing action should accept the hold.

   **Exact fix:** Make typed PIPEEDIT completion flush only genuinely pending accepted edits, preserving saves for real edits. Move legacy-path acceptance to the actual accepted write, not before the eligibility check/question. Keep old typed aliases.

   **DETERMINISTIC TEST:** Start a synthetic saved DWG with P1, P2 and one linked pipe, already loaded in CE and with no pending save. Record DBMOD=0 and the CE log position. Type PIPEEDIT, select the pipe, click Cancel. Assert DBMOD remains 0 and there is no new “Project data saved to DWG successfully” line for this cancellation. In a second pass draw LINE, repeat Cancel and type U: the line must disappear immediately; REDO must restore it. Repeat through CDEDIT, double-click, and an older pipe followed by No/Escape. A real saved edit must still undo/redo together with its record.

   **Tests / safety / defaults:** The new hold/source tests miss the command-ended event. Add a lifecycle test which fails with the unconditional trigger still present. No new switch or engineering value. Existing protected-object checks remain; the defect is a drawing-record write even when no entity edit was accepted. Test Cancel on a locked pipe and during REFEDIT without loosening those protections.

   **Merge order:** #1671's new PitScheduleCloseFlushRuleTests explicitly require PIPEEDIT to remain a trigger. That assertion conflicts semantically with this correction even though the production-file edits need not conflict. Update the assertion to require accepted edits to persist and cancelled edits not to save. F2 verified-by-reading.

3. **#1671 · FB-05 · MERGE — Pit Schedule close/save boundary.**

   **Head / Opus:** fb/fb05-pit-schedule-open-no-write, 920e8995ede2c969fdfbd158a23465346010e737. Opus: MERGE at this head in review A; retained.

   **Cause and scope:** Real double source of unconditional writes: window close and PITSCHEDULE command completion. Modules/Drainage/Dialogs/PitScheduleDialog.xaml.cs:159 now checks pending work for the captured opening database; Services/LinkService.cs:69 removes the unconditional command trigger. Actual pending changes still flush. The “opening database unavailable” fallback deliberately retains old saving behaviour, so this is not a universal proof that all exceptional openings are read-only.

   **DETERMINISTIC TEST:** With a saved CE drawing and no waiting edit, draw LINE, type PITSCHEDULE, click Close, then U. The line must disappear, with no intervening PITSCHEDULE record-only step; REDO restores it. Repeat using the window X. Separately change one schedule level, save it, and confirm one U/REDO restores both the level in the drawing record and the displayed schedule.

   **Tests / safety / defaults:** Pure close-rule cases would detect the old unconditional rule; source assertions check both call sites. They do not exercise native Undo. No new geometry writer, switch or engineering constant; the opening database is captured rather than retargeted at close. Locked/Xref/REFEDIT handling of real edits is inherited, not bypassed by this diff.

   **Merge order:** Apply the #1663 test-assertion correction when integrating that PR. Do not retain an unconditional PIPEEDIT save merely to satisfy this PR's overly broad assertion. No new finding counted here.

4. **#1682 · FB-06 · MERGE — renamed pit ownership notes, with Opus follow-up present.**

   **Head / Opus:** fb/fb06-pit-rename-pipe-notes, 19f02107844622b48430354bf82f02f991c3404b. Opus reviewed older bc3e3817 in review B as MERGE-WITH-FIXES. Current head contains per-pipe guarded processing and damaged/protected counts; this is a review of those corrections, not a claim Opus reviewed this exact tip.

   **Cause and scope:** Real stale ownership: relinking prefers each pipe's explicit pit note. Changing only the project pit name leaves that note behind. Modules/Drainage/Services/LinkService.PitRenameOwnership.cs:24 now updates matching endpoint names inside the caller's transaction. :40 isolates each pipe's failure; :61 checks IsSpineWritable before writing.

   **DETERMINISTIC TEST:** Fixture P5 has two healthy connected CE pipes and a third on a locked layer. Include a damaged pipe note encountered before the second healthy pipe. Double-click P5, change its number to P9, Save. Assert both healthy pipes' ExplicitFromPitId/ExplicitToPitId notes now name P9; protected notes remain unchanged and the protected/damaged counts are visible. Add an unrelated distant P5 and run CDREBUILDLINKS: healthy connections must stay with P9. Undo/redo the original rename on a clean copy and assert pit plus healthy notes move together.

   **Tests / safety / defaults:** Name-matching and guarded-failure tests exercise the new policy and would fail without it; they do not prove every native persistence failure is surfaced. Model-space enumeration, IsSpineWritable, and no independent transaction provide the intended locked-layer/Xref/REFEDIT boundaries. No unlocking, new switch or engineering number. The current scope is Edit Pit rename, not a claim that every older renaming entry point is repaired.

   **Merge order:** No direct code overlap with these other PRs. Existing Opus scope limitations are retained, not rediscovered or counted.

5. **#1688 · FB-07 · MERGE — callout half follows its arrow; curved pipe left whole.**

   **Head / Opus:** fb/fb07-inline-split-callout-curve, 69451402decf98431d98a2bfce15a29a6f4830d0. Opus: MERGE at this head in review B; retained.

   **Cause and scope:** Real attachment ownership error when text lies across the split but its arrow points to the other half. The new InlineSplitHalfRules uses the arrow anchor first. LinkService.Split.cs rejects a bulged candidate before the split writes, rather than rebuilding it as straight pieces. The pit placement can continue; this is not an additional general hard block.

   **DETERMINISTIC TEST:** On a straight 20 m CE pipe, put a callout arrow at 5 m and its text at 15 m. Type PIT and insert at 10 m. Erase the second half: the callout belonging to the first half must remain. U must restore the erased half; another U must restore the original unsplit pipe and original attachment. In a separate fixture with bulge 0.3, place PIT on the curve: assert the pit exists, the original pipe is still one curved entity with the same bulge, and the command line explains that it was left whole.

   **Tests / safety / defaults:** Pure anchor-choice and curve-rule tests would fail without the change. They are not a substitute for actual child ownership after erase/undo. No new switch or engineering setting. Early curve handling reduces mutation; existing split protection remains responsible for locked layers, Xrefs and REFEDIT. The world-origin anchor limitation was already noted by Opus and is not counted again.

   **Merge order:** Reconcile LinkService.Split.cs with #1659; preserve both behaviours.

6. **#1693 · FB-11 · MERGE — typed pit number and cover in the picture.**

   **Head / Opus:** fb/fb11-pit-preview-live, ae1566c6451ec4d4bb82fcb71095335fbc4decb6. No Opus review found.

   **Cause and scope:** Real gap when the dry-run picture is unavailable: changes to the number/cover do not redraw their pending wording. Modules/Drainage/Controls/PitBlockPreviewControl.cs:191 calls ShowPendingText in that case. PitPreviewPendingText uses current fields and the existing exact cover readout; PitFootprintOverlay displays them. It also distinguishes an existing saved pit from an unsaved new one. This is a text overlay on the saved picture, not a regenerated drawing preview.

   **DETERMINISTIC TEST:** On the modern AutoCAD lane, double-click saved P13 with cover 21.00 m. Type P77 and cover 21.10 m without saving. Assert the preview's visible text shows P77 and the enabled cover wording 21.10, with “Saved pit — changes waiting for Save”. Toggle number/cover labels off and assert the respective pending wording disappears. Cancel; drawing labels and stored cover must still be P13/21.00. Repeat in dark and light themes and inspect for overlap.

   **Tests / safety / defaults:** The new tests exercise text/caption and overlay state, so the extracted behaviour has a negative control; they do not drive the real property-change/window chain. This diff is WPF-only and NET10_0_OR_GREATER, with no entity write, document lock or idle save. Locked-layer/Xref/REFEDIT and redo protection are not weakened. No switch or engineering constant. No pictures were rendered or visually accepted in this review.

   **Merge order:** No direct code overlap.

7. **#1700 · FB-13 · MERGE — finish the raingarden outline on Enter.**

   **Head / Opus:** fb/fb13-cdrg-enter-finishes, 78e889613b0de2c609b26438693a040666084b56. No Opus review found.

   **Cause and scope:** Real prompt-flow error. SourceBlockInsertCommands already permits a null response, but the old loop does not treat it as a completed outline. The new RaingardenOutlineStep distinguishes Finish, Undo and Cancel, allowing Enter after three points and keeping the prompt alive after Undo at the first point.

   **DETERMINISTIC TEST:** In a millimetre drawing type CDRG and enter (0,0), (4000,0), (4000,3000), (0,3000), then Enter. Assert the command proceeds to its next input rather than cancelling; complete the remaining ordinary inputs and assert one closed raingarden outline exists. U/REDO must remove/restore that result. Start again, pick one point, choose Undo and assert the point prompt is still active; Escape must leave no outline. For right-click, explicitly set/use AutoCAD's Enter shortcut behaviour and repeat.

   **Tests / safety / defaults:** Decision tests distinguish null response from cancellation and exercise the first-point Undo rule; source guards check their use. Native prompting remains untested. Only input interpretation changes; established writer/locked-layer/Xref/REFEDIT protections remain. Three points is a geometry minimum, not a new engineering design value. No switch; fix active.

   **Merge order:** No direct code overlap.

8. **#1701 · FB-14 · MERGE-WITH-FIXES · MEDIUM F3 — skipped registration counted as success.**

   **Head / Opus:** fb/fb14-repair-report-counts, aaaa7ff4f38b992da834624e4368c336a3096190. No Opus review found.

   **Cause and scope:** Reporting attempted work as finished work is real. The dangling-pipe path improves this by reading back its record. The roots path still counts a method returning normally as success: Modules/Drainage/Services/LinkService.RepairAudit.Relink.cs:172 and :179 increment rootsRegistered immediately after RegisterPit/RegisterSourceBlock.

   **Exact failure chain:** LinkService.Registration.cs:432 calls WritePitLinkData; :680 contains the source registration path and its local exception handling. LinkService.Persistence.cs:936 calls SkipRecordWriteOnLockedLayer and can return null; :1215 WriteXrecordString then returns without writing. RegisterSourceBlock also catches errors internally. Neither path provides the caller a success receipt. The new failure count consequently misses ordinary protected skips.

   **What Tim sees / exact scenario:** A recognised CE pit block is on an existing locked layer and has no CE link record. Rebuild links leaves it unregistered, correctly respecting the lock, yet counts it as registered. The headline can say the repair succeeded while the drawing still lacks the link.

   **Exact fix:** Return a committed registration result or read back and validate the expected record/ownership. Increment success only when the intended registration exists; count protected and failed writes separately and explain them. An unrelated or stale existing record is not sufficient evidence of a successful repair. Do not unlock layers.

   **DETERMINISTIC TEST:** Synthetic DWG contains recognised PIT BLOCK 3 pit P1 on locked layer TEST-LOCK and healthy PIT BLOCK 3 pit P2 on an unlocked layer, with their valid labels; both start without CE link records. Type CDREBUILDLINKS. Assert P1 still has no link record, TEST-LOCK remains locked, P2 has its expected record, and the CE “CDREPAIR complete” line reports 1 compound root registered and 1 could not be linked. Current counter logic reports both as registered. Add a protected source on the recognised CE downpipe layer and an injected registration failure as separate cases. Undo/redo the successful P2 registration must not create a P1 record.

   **Tests / safety / defaults:** RepairReportCountsTests mainly supply numbers to the wording and inspect source; they do not cause the registration writer to skip. Add a writer-result test with a protected skip and caught failure. The change does not bypass protection; it misreports its result. No new switch or engineering value; grade-application counting now uses effective applied endpoints. F3 verified-by-reading.

   **Merge order:** Shares LinkService.RepairAudit.InvertPropagation.cs with #1712 in separate application/planning regions. Preserve both.

9. **#1706 · FB-12 · HOLD — clicked Pit-tab Close needs a demonstrated cause.**

   **Head / Opus:** fb/fb12-pit-tab-close, 65d77570f8302553ab788933020774ad69e268b5. No Opus review found.

   **Cause and scope:** Not established on the current base. The brief requires reproducing the clicked-ribbon failure first; the builder's account says that was not done. The original observation came from an older installation, and ribbon dispatch has since changed. The PR adds an idle second attempt to clear selection and hide the tab.

   **Suspected, not counted:** Modules/Drainage/Commands/RibbonContextCommands.cs, FinishClose, returns when CommandInProgress is non-empty. Services/OneShotIdleAction.cs consumes/unsubscribes its action before invoking it. If the first idle delivery occurs while a command remains active, the follow-up is lost. Whether that occurs in the actual clicked-Close path requires a host reproduction; it is not a verified AutoCAD defect here. It also uses the active document at idle rather than explicitly retaining the originating document.

   **Exact requirement before MERGE:** Demonstrate old-base failure and head success with a real click. If the extra action is required, retain the intended drawing/selection and explicitly handle “not yet idle” without discarding necessary work or clearing a newer selection. If the base already works, remove the speculative extra behaviour.

   **DETERMINISTIC TEST:** In a copy containing CE pit P1, select P1 to show its contextual Pit tab, then click that tab's named Close button with the mouse. Assert implied selection count 0 and tab hidden; repeat twice. Run the same clicks on the PR base. For redo: draw LINE, U, select P1, click Close, type REDO; assert the line returns. Add a new selection and switch drawings before any deferred callback; assert neither the new selection nor the other drawing's contextual tab is cleared by the old Close.

   **Tests / safety / defaults:** One-shot tests prove the helper schedules/runs once; they cannot prove Autodesk ribbon dispatch or idle timing. No drawing writer, layer unlock, new switch or engineering number; shared ribbon source remains unchanged. The modern-only follow-up does not imply a missing net48 contextual-ribbon fix. No direct code overlap. HOLD is an evidence gap, not a seventh confirmed finding.

10. **#1707 · FB-16 · MERGE — faithful LandXML field reading.**

   **Head / Opus:** fb/fb16-landxml-import, f9eebcfb36257eaae09d25830fa16acdf05bf1f9. No Opus review found.

   **Cause and scope:** Real parser gaps in Modules/Drainage/Helpers/LandXmlParser.cs: canonical refStart/refEnd were not accepted alongside the old aliases; detention width needs the agreed half-width fields; rectangular pipe shape needs visible checking; unfamiliar material/class text should survive instead of being silently replaced. The parser/model/report changes match those cases. The factor 0.5 splits a total width into two halves, not a design allowance.

   **DETERMINISTIC TEST:** Use a synthetic LandXML file with two named structures, a circular 300 mm pipe using refStart/refEnd, material uPVC/class SN10, a 900 mm detention width and a separate 1200 by 600 mm rectangular pipe. Type CDIMPORTXCIVIL and choose the file. Assert the circular pipe appears between the named structures, the stated material/class survives, the two width halves total 900 mm, and the rectangular item has a visible Check warning rather than silently becoming a confirmed round pipe. Cancel the review: no entities added. Import a clean circular-only control, then U/REDO: the import is removed/restored together.

   **Tests / safety / defaults:** Tests drive the actual parser/review data, with cases the old parser cannot satisfy. They do not run the AutoCAD importer. No new switch; fixes active. Existing diameter/pit/material fallback constants are not introduced by this PR and are already audit territory. Writer protection and target-layer behaviour are inherited, including any existing import-specific handling; this review does not certify that importer as universally locked-layer-safe. No additional hard block is requested.

   **Merge order:** LandXmlParser.cs overlaps #1708 and the separate units PR #1716 (cx4/fa02-units). Merge the parser corrections together deliberately, preserving canonical aliases, shape/material fidelity and units. Do not resolve by taking one whole side.

11. **#1708 · FB-17 · MERGE — file scale, falling-pipe grade and cover precision.**

   **Head / Opus:** fb/fb17-landxml-scale-grade-rim, 2ed82768e914cf30060db339f145a911471e614c. No Opus review found.

   **Cause and scope:** Real inconsistent scaling and negative slope handling in LandXmlParser.cs. Explicit metre/millimetre units now choose the file scale; falling slopes retain a positive grade magnitude; cover rounding reads Settings precision. Undeclared-unit heuristics remain heuristics. This is not a claim that all other elevation-unit faults are solved: #1716 owns the separate units correction already identified in other reviews.

   **DETERMINISTIC TEST:** Make equivalent explicit-metre and explicit-millimetre XML fixtures with two structures 20 m apart, a 300 mm pipe and slope -0.01. CDIMPORTXCIVIL must show the same 20 m length and 1 in 100 grade in both. Use cover 21.126 m with Settings at two decimals: preview/import must show 21.13, and at three decimals 21.126. In the millimetre file encode elevations according to the reconciled #1716 unit handling; this PR alone must not be claimed to fix that separate defect. Cancel adds nothing; U/REDO restores an accepted import.

   **Tests / safety / defaults:** Parser tests provide real negative-slope and unit-declaration inputs, not just source-text checks; they would expose the old paths. No new switch or engineering setting. Existing writer protection is unchanged and subject to the same import limitation as #1707.

   **Merge order:** Integrate #1707, #1708 and #1716 using merges, never rebase. #1716 touches the same unit/report/structure parsing regions; conversion must precede cover rounding. Opus's 24 October review records actual merge conflicts for that combination; this review independently confirms source overlap but did not perform a merge.

12. **#1709 · FB-20 · MERGE-WITH-FIXES · MEDIUM F4 — a curved pipe can lose a boundary crossing.**

   **Head / Opus:** fb/fb20-boundary-along-pipe, 32d8a1556c4d177d4a9bf463cbf4c71f53962050. No Opus review found.

   **Cause and scope:** Measuring a dogleg by its pit-to-pit chord is a real fault, and the new piecewise-straight path corrects ordinary bends. Curves are converted into fixed five-degree chords in Modules/Drainage/ViewModels/LongitudinalSectionViewModel.cs:903, with the step at :917. Modules/Drainage/Helpers/LongSectionBoundaryProjector.cs:76 intersects those chords, not the actual arc. There is no bound preventing a real crossing from falling between the arc and chord.

   **What Tim sees / exact scenario:** A short title-boundary segment genuinely crosses a curved pipe but its BOUNDARY mark is missing from the long section. This is a missing drawing feature, not merely a small chainage rounding difference.

   **DETERMINISTIC TEST:** Use a millimetre DWG with a valid CE pipe from (0,0) to (200000,0), bulge +1: a semicircle below the endpoints, radius 100 m. Use known pipe/pit data, 600 mm pits and no other boundaries. Draw LINE on BOUNDARY from (50,-4361.9387365) to (140,-4361.9387365). Type CDPROFILE, choose this route, review and apply. Assert one BOUNDARY mark at chainage 4.363323 m, within 0.05 m. The true arc crosses at x=95.177842 mm; the first five-degree chord crosses at x=190.446358 mm, outside the boundary segment. Thus the new projector returns no crossing. The boundary is more than 4 m from the start pit, and is on the inward side, so the endpoint fallback does not supply the missing mark.

   **Exact fix:** Intersect the boundary with the actual curve and measure actual curve distance. If approximation is retained, it must reliably find crossings and refine against the curve; merely reducing a fixed angle does not prove a finite segment cannot be missed. Keep geometric accuracy distinct from engineering settings.

   **Tests / safety / defaults:** Current tests supply already-built straight point lists; they never drive the real bulged-polyline reader. Add the arc fixture and a near-miss control through the capture path. These readers do not write source pipes, including locked/Xref geometry; profile placement retains its existing protected-target/REFEDIT checks. No new bug-fix switch or engineering default. U/REDO must remove/restore the generated section without changing source entities. F4 verified-by-reading and analytic geometry, not by executing code or AutoCAD.

   **Merge order:** Shares ProfileRouteEvidenceCaptureService.cs with #1710 in distinct display/grade regions. Preserve both.

13. **#1710 · FB-19 · MERGE-WITH-FIXES · MEDIUM F5 — level detection depends on which way the tiny fall goes.**

   **Head / Opus:** fb/fb19-level-pipe-grade, b46f0c3251aeceab6a224bd4ef793dcafef16164. No Opus review found.

   **Cause and scope:** Treating a truly level pipe as missing grade is real. The new LEVEL evidence and blank hydraulic rows address it. But Modules/Drainage/Services/ProfileRouteEvidenceCaptureService.cs:615 accepts any calculated positive grade before :618 checks IsLevelPipe. The helper at :755 compares inverts to Settings precision, as the brief requires, but is skipped on a small positive fall.

   **What Tim sees / exact failure:** With two-decimal Settings, a 20 m pipe from 10.004 to 10.001 m displays 10.00 at both ends but gets approximately 1 in 6667 and calculated velocity/flow. Reverse those two levels and the same rounded pair becomes LEVEL with blank hydraulic rows. No authoritative grade label/custom grade is present in this fixture.

   **Exact fix:** In the fallback from known inverts, test equality at Settings precision before computing a positive gradient. Preserve the established precedence of an actual authoritative grade label. Exercise the complete capture-to-review-to-section path, not only IsLevelPipe.

   **DETERMINISTIC TEST:** Fixture: 20 m, 300 mm CE pipe, known material and inverts 10.004/10.001 m, no grade text, no recorded/custom grade, CalculatedDecimals=2. Type CDPROFILE, select the route and review/apply. Assert grade text LEVEL and blank velocity/full-flow in both review and section. Reverse the levels and require the same result. At three decimals the original falling pair must be non-level; at exactly equal inverts it must remain LEVEL. U/REDO must remove/restore only the section.

   **Tests / safety / defaults:** Existing tests include rounded-equal values and test the level helper, but do not catch the positive-grade branch taking precedence for the falling order. Some real zero-grade review coverage is useful but insufficient. Settings are correctly read; the defect is ordering, not a new hard-coded tolerance. No switch; no source entity writer or protection bypass. F5 verified-by-reading.

   **Merge order:** Reconcile capture changes with #1709 and section-service changes with #1711. Their regions differ, but an integrated section fixture must exercise all three.

14. **#1711 · FB-22 · MERGE-WITH-FIXES · HIGH F6 — another pipe's branch appears on the chosen long section.**

   **Head / Opus:** fb/fb22-cdprofile-junction-marks, 5ee899a2ee49203db09a06b7a4aa61c37078e23b. Opus: MERGE at this exact head in REVIEW_CX4_AND_BATCH4_24OCT.md. Verdict changed here.

   **Cause and scope:** The reviewed CDPROFILE apply path really omitted branch marks. The new call at Modules/Drainage/Services/LongitudinalSectionService.cs:807 attaches all drawing branch facts. The helper at :921 passes only nodes and those facts to the placer. Modules/Drainage/Rules/BranchJunctionDisplay.cs:407 matches a fact using its main's two pit marks, not MainHandle. The fact reader in Services/LinkService.BranchJunctionDisplay.cs:23 reads decisions across the project. Consequently an unselected parallel pipe is not filtered out.

   **Reachability checked:** Rules/PipeSystems.cs:110 enumerates each downstream pipe, and :218 onwards emits separate routes; HashRoute includes pipe handles. Distinct pipes between the same two pits are valid separate choices, not automatically rejected as the same route. Ordinary non-existing-type parallel pipes with valid records are not external-cut ambiguities.

   **What Tim sees / exact failure:** Select the long section for main A between P1 and P2. A has no branch. Main B also connects P1 to P2 but follows a different alignment and has a 100 mm branch. A's generated section wrongly says “100 DIA. BRANCH”. Its location is scaled from B's length onto A, so it even looks like a plausible connection.

   **DETERMINISTIC TEST:** P1=(0,0), P2=(20000,0) mm. A is the straight 20 m main. B is a separate proposed CE main through (0,5000) and (20000,5000), length 30 m. Give both distinct valid handles/keys and the same P1/P2 endpoint identities. Branch C, diameter 100 mm, runs from P3=(10000,10000) to B=(10000,5000), with its explicit end-1 connection to B at chainage 15 m. Give every required level/material/diameter a known value. Type CDPROFILE at P1; choose the 20 m A route, review and apply. Assert no “100 DIA. BRANCH” text exists in A's section. Current code adds it at A's 10 m chainage. Choose B's route: assert exactly one such mark at 15 m. U/REDO must remove/restore each section without changing A, B or C.

   **Exact fix:** Carry accepted route pipe identities into marker placement and match each fact.MainHandle to the actual selected segment. At minimum filter facts by the accepted route handles before placing; retain exact segment identity so duplicate pit labels cannot retarget a fact. Do not change or infer the stored connection to make the picture fit.

   **Tests / safety / defaults:** Bug766ReviewedSectionJunctionMarksTests cover a single main and supplied facts, so they cannot expose cross-route contamination. Add two mains sharing the same endpoints and a branch on only the unselected main. Reads remain in the caller's transaction; no branch geometry writes, no layer unlock, no new switch or engineering constant. The wrong output survives those otherwise useful protections. F6 verified-by-reading, not an AutoCAD reproduction.

   **Merge order:** Shares LongitudinalSectionService.cs with #1710; preserve the LEVEL projection and exact route identity together.

15. **#1712 · FB-23 · MERGE — wait for both arrivals before continuing a level cascade.**

   **Head / Opus:** fb/fb23-cascade-rejoin-order, 49792ecacfcbb6d9eb50d619b9b51ff894123d38. Opus: MERGE at this exact head in the 24 October review; retained.

   **Cause and scope:** Real traversal-order problem at a diamond/rejoin. The previous walk could process the outlet after the first arrival and never revisit it when a lower arrival appeared. LinkService.RepairAudit.InvertPropagation.cs now orders downstream work by remaining arrivals, then uses the lowest arrival. Upstream behaviour remains separate; the cycle fallback prevents an unending wait.

   **DETERMINISTIC TEST:** Synthetic diamond A-B-D and A-C-D, then D-E; each pipe is 20 m long, with its recorded grade matching the following initial fall and no pinned endpoint overrides. Initial pipe levels: AB 10.0/9.9; AC 10.0/9.6; BD 9.9/9.8; CD 9.6/9.5; DE 9.45/9.35 m. Type CDPROPAGATE, select A as the anchor and enter 10.5 m. With no upstream pipe at A, the command chooses its downstream cascade; review the preview and choose Apply. Assert arrivals at D are 10.3 and 10.0, and DE starts 9.95 m, preserving its 0.05 m junction drop. Reverse input pipe enumeration and require the same preview/result. U/REDO must restore/reapply all changed pipe levels together. Add a loop control and confirm the preview returns rather than hanging.

   **Tests / safety / defaults:** New pure network tests exercise the traversal and would fail on the old first-arrival ordering. They do not execute the native Apply writer. Changes are planning/order logic, with existing pinned/protected handling retained. No new layer/Xref/REFEDIT bypass, switch or engineering drop: the fixture's existing offset is preserved, not imposed as a universal value.

   **Merge order:** Shares the propagation file with #1701 in different regions. Keep planning correction and truthful application reporting.

16. **#1713 · FB-24 · MERGE — audit reads and measurement corrections.**

   **Head / Opus:** fb/fb24-audit-read-only, a8df14593c5ab8ae0a25d5c2c70103ba70d65360. Opus: MERGE at this exact head in the 24 October review; retained.

   **Cause and scope:** The import audit was unnecessarily calling SetDrawingPath before reading, potentially writing a record. LinkCommands.cs removes that call. RepairAudit.AuditPasses.cs converts metre-drawing measurements consistently and compares pipe ends against pit outline rather than the pit centre. The legacy-audit catch reports a top-level failure; it is not proof that every older audit now continues after every individual corrupt item.

   **DETERMINISTIC TEST:** Synthetic metre DWG has a 300 mm pipe represented at 0.3 m width and a 1200 mm pit with a pipe ending at its wall. Type CDAUDIT: assert no false size mismatch for that pipe and no false pit-gap finding for the wall connection. Move a control endpoint 700 mm beyond the wall and require a gap finding using the current Settings tolerance. On a saved copy with DBMOD=0, type CDIMPORTAUDIT: assert DBMOD stays 0 and no new project-record-save log line. Draw LINE before a read-only audit, then U/REDO: the line must disappear/reappear immediately.

   **Tests / safety / defaults:** Measurement tests have meaningful old-code negative controls; source guards check the removed setter. No new writer, idle callback, switch or engineering value. Existing tolerance remains the setting; millimetre conversion is a units correction. Locked layers and Xrefs remain readable without unlock; REFEDIT inspection must not become a write. No direct code overlap.

17. **#1717 · FB-25 · MERGE-WITH-FIXES — retain Opus's repeated-warning correction.**

   **Head / Opus:** fb/fb25-schedule-order-pump, cedc590e3b409e074b15f979795ed97b789020be. Opus: MERGE-WITH-FIXES at this exact head in the 24 October review. Same verdict; no new finding counted.

   **Cause and scope:** New redesign pits were simply appended rather than placed in natural mark order. PitScheduleNewRowPlacement now inserts them relative to existing rows without re-sorting a deliberately arranged list. PumpPitScheduleReader distinguishes a duplicate pump label from a label already represented by a real Civil pit and surfaces incomplete reads.

   **Previously found remaining fix:** Modules/Drainage/Services/PumpPitScheduleReader.cs:55 creates a new warning list on every read; :113 writes it every time. Repeated schedule loads repeat the same command-line warning. Opus already identified this. Report unchanged duplicate/read-failure conditions once per appropriate drawing/window lifetime, reset when the condition changes, and retain the CE log detail. Do not suppress the first useful warning.

   **DETERMINISTIC TEST:** With natural sorting enabled, start P1/P2/P10 and add P2A through the redesign schedule review: assert P2A is inserted between P2 and P10. With deliberately arranged P10/P1/P2, assert existing rows retain their relative order. Add two pump blocks labelled SPS1, open PITSCHEDULE and assert one SPS1 row plus one duplicate warning. Reload the schedule three times: assert no three additional identical warnings. Fix the duplicate, reintroduce it, and require a new warning. U/REDO of the drawing edit must not be disturbed by a schedule read.

   **Tests / safety / defaults:** Helper tests prove insertion/duplicate classification but not repeated window loading. Existing natural-sort preference remains optional and unchanged; this is not a new bug-fix switch defaulted off. Pump scanning is read-only; no layer unlock or Xref/REFEDIT write introduced. No engineering constant or CE_SHARED change. No direct code overlap.

## Summary

1. **Under 100 words.** Six new source-proven faults remain across the seventeen drafts: two HIGH and four MEDIUM. Three earlier Opus MERGE verdicts change. Nine PRs are MERGE, seven MERGE-WITH-FIXES and one HOLD. The highest risks are wrong branch ownership after a split and branch marks drawn on an unselected pipe's long section. Retain the already-known pump warning fix and resolve the PIPEEDIT/Pit Schedule test conflict. These are read-only findings with deterministic future acceptance checks: zero builds, zero tests, no AutoCAD, no code changes.

