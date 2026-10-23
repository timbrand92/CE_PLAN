1. **ANSWER FIRST — HIGH 0 / MEDIUM 3 / LOW 0 new findings.** Independent review of draft PR group 3, 23 October 2026, Melbourne. All three are verified-by-reading; none has been run in AutoCAD here. Previously reported defects are excluded from these counts.

2. **Most important: the garden/lawn fix can make CE choose an older report.** If the newest report lists only garden and lawn and its score cannot be read, CE discards its readable catchments and can offer an older report's roof area instead. The same change also stops the existing area check noticing when roof plus garden exceeds the whole site.

3. **The other fault is misleading evidence.** A completed hatch repair check is logged as cancelled when every hatch is already correct. The test lane could count a successful check as an abandoned command.

4. **Disposition.** Keep #1553 at MERGE-WITH-FIXES for the two report-handling defects below. Keep #1547 at MERGE-WITH-FIXES for the hatch result defect. #1544, #1550 and #1551 still deliver no drawing fix. No source, drawing, settings, installation or PR status was changed. Manager administrator work remains parked.

---

1. **Scope, selection and reproducibility.** Read C:\TimOS\RULES.md, ROUTER.md and CE_PLAN's start/map. This is CE_ACAD / independent draft review / group 03, under desk plan/03. The specific read-only brief overrides the appended worktree/build/PR instructions. Only this findings file is authorised for writing and committing.

   Ran `git fetch origin` in the plugin repo and read Git objects, not checkout edits. Ran exactly `gh pr list --state open --limit 200 --json number,title,headRefName,headRefOid,baseRefName,isDraft`, retained drafts beginning fw2/, cx/, cx2/, fix/ or b04/, and sorted numerically. The response contained 200 open PRs and 57 matching drafts. This partition deliberately uses the requested 200-result snapshot; it is not an exhaustive census of older open PRs.

   Split consecutively, with the remainder allocated to earlier groups: 10, 10, 10, 9, 9, 9. Group 3 is positions 21–30: #1544, #1545, #1546, #1547, #1548, #1549, #1550, #1551, #1552, #1553. Neighbouring boundaries are #1543 before and #1554 after. The frozen selection is not repartitioned when another chat changes a PR.

2. **Baseline and inherited work.** Nine PRs name `claude/rel-20261022m`, 40ee0a36f7960145743954b39859eb6c3af92869, as base. #1547 names `claude/rel-20261022s2`, 2c9a96942a024888a5ab520600f2d5025de83036. These are the brief's C-60/S-41 references, not a fresh claim about installed DLLs.

   #1552 and #1553 have since merged C-61, `claude/rel-20261023l` at 88bd62f704b66a7e156da572c212812dc4b0c61a, without changing their PR base. Their base diffs therefore include the train's inherited changes. I inspected the base comparison and separated each fix using a second diff against C-61: three files apiece. Do not mistake inherited train files or version changes for new spoon/report work, or count their previously reviewed defects again. This review is not a second certification of the entire C-61 train.

3. **Prior findings excluded.** Read AUDIT_C58_C60_S40_S41_2026-10-22.md, CODEX_AUDIT_CIVIL_22OCT.md, CODEX_AUDIT_GATE_22OCT.md and CODEX_AUDIT_STRUCTURAL_22OCT.md, plus the applicable entries in REVIEW_CODEX_PRS_A/B_2026-10-23.md and REVIEW_FIXWAVE2_A/B_2026-10-23.md. The original Civil event-only outcome error, missing pit-edit integrations, schedule close writers, CDRG colour mismatch, missing type-field default, unknown-survey wording and absent Settings rows are not new findings here.

4. **Evidence and limits.** File:line citations below refer to the stated PR head. Verified-by-reading establishes the control flow and calculated result; it does not claim native reproduction. Every deterministic test is a NOT RUN instruction for the later AI test lane on synthetic copies. No builds, unit tests, AutoCAD, accoreconsole, installations, sub-agents, code branches or code commits were run. Committed window images were not rendered or visually accepted. R-27 means an area inconsistency should be explained without inventing another hard block; R-00 remains the authority for engineering Settings.

**Numbered new findings**

1. **G03-F1 — MEDIUM — #1553 can discard the newest readable garden/lawn report and offer an older roof figure. VERIFIED-BY-READING.**

   **File:line:** at a51a9216112a73e833a9cee79a34a4d26d352405, `Modules/Drainage/Rules/BlueFactorReport.cs:91`, `Modules/Drainage/Rules/StormReport.cs:59`, `Modules/Drainage/Services/StormReportReader.cs:184`, `Modules/Drainage/Rules/StormReportOffer.cs:108` and `:19`; live offer at `Modules/Drainage/Commands/CivilDesignCommand.cs:485` and `:499`.

   **What the drafter sees:** CDDESIGN can offer an older roof/paved figure even though the newest PDF has readable site and garden areas. If the score is readable, the report survives, but CE still says its known zero roof/paved area is “not in the report”. This is beyond Opus's LOW about the sentence used for an all-garden report: the reader may discard the report before that sentence is shown.

   **Exact scenario:** the new `continue` removes every Garden/Lawn row from `Rows`. With no readable score, `HasAnything` is false, despite a recognised report, a site area and parsed pervious catchments. `TryReports` skips it and continues to older PDFs. With a readable score, `HasAnything` becomes true, but `StormReportOffer.Build` maps zero rows to NaN; even replacing NaN with zero would still fail `HasReportFigure`, which requires a positive number. The all-garden test added in this PR asserts only a note, not these consumers.

   **DETERMINISTIC TEST — fixture:** two text-bearing synthetic PDFs in a scratch job's `Civil/STORM Report - WSUD` folder. The newer file, `current-rating.pdf`, extracts exactly these separate lines: `Bluefactor report`; `Site area 1000 m2`; `FRONT GARDEN Garden, 600m2`; `BACK LAWN Lawn, 400m2`. Deliberately omit a readable score. The older `previous-rating.pdf` extracts `Bluefactor report`; `Site area 1000 m2`; `ROOF TO LPD Roof, 300m2`. Set their last-write times explicitly so current-rating is newer. Use a saved scratch host drawing below that job folder with no recorded design areas/council. PDFs are required: the live reader searches `*.pdf`; a plain .txt copy, as suggested in the earlier review, does not exercise this route.

   **Typed steps:** on AutoCAD 2027 with #1553, type `CDDESIGN`, answer Yes to looking for the rating report, and record the command line before accepting any figures. On a separate copy, give current-rating a readable `100%` line followed immediately by `SCORE`, then repeat. Also feed the extracted text through `ParseAnyRatingReport` and the real `StormReportOffer.Build` in a later integration test; do not hand-build corrected facts.

   **Assertions:** first case must identify current-rating as the newest readable catchment evidence, warn that its score is unknown, and must not offer previous-rating's 300 m2 as the current result. Source predicts it selects previous-rating and offers 300. Second case must distinguish a completely listed 1000 m2 pervious site / zero roof-paved area from a missing figure; source predicts “Roof and paved area: not in the report”. Preserve the user's choice and report uncertainty if the report is incomplete; do not assume every empty parsed list means a true zero.

   **Fix direction:** keep evidence that pervious rows were successfully read, including their total and whether the list accounts for the site. Use that in report eligibility and the zero-versus-unknown offer. Keep garden/lawn out of the impervious sum.

2. **G03-F2 — MEDIUM — #1553 no longer warns when listed roof plus garden exceeds the site. VERIFIED-BY-READING.**

   **File:line:** same head, `Modules/Drainage/Rules/BlueFactorReport.cs:93` and `:223`; `Modules/Drainage/Rules/StormReport.cs:97`; `Modules/Drainage/Rules/StormReportOffer.cs:176` (WhyTheOfferLooksWrong); `Modules/Drainage/Commands/CivilDesignCommand.cs:502`.

   **What the drafter sees:** a report saying site 1000 m2, roof 800 m2 and garden 500 m2 is offered without an area-conflict warning. CE repeats the 500 m2 garden note while the design receives only 200 m2 of remaining soft area. A transcription or overlapping-catchment error is concealed.

   **Exact scenario:** Opus's requested repair correctly changed the shortfall calculation to include pervious area, but it only tests `listedM2 < site`. No greater-than check was added. The existing offer validation sees only the reduced 800 m2 impervious sum, so it no longer catches the 1300 m2 listed total. `PerviousAreaM2` derives 1000 - 800 = 200, while the only stored account of the 500 m2 garden is prose. This is separate from F1: here a roof row exists, so report selection succeeds normally.

   **DETERMINISTIC TEST — fixture:** one synthetic text-bearing PDF with lines `Bluefactor report`, `Site area 1000 m2`, `ROOF TO LPD Roof, 800m2`, `FRONT GARDEN Garden, 500m2`, `100%`, `SCORE`. Put it in the scratch report folder above; start with no recorded design areas. Use an independent fresh drawing for each test.

   **Typed steps:** `CDDESIGN`, Yes to the report search; capture the offered figures and notes. In the later integration test, parse that exact text, then call `StormReportOffer.Build` and `WhyTheOfferLooksWrong`, preserving the original facts.

   **Assertions:** a plain warning must say the listed areas total 1300 m2 against a 1000 m2 site, a 300 m2 excess, and ask the drafter to check overlap or the report. Warn and carry on under R-27; no new compulsory refusal. Current source produces no excess warning, offers 800 m2 roof/paved and says 500 m2 garden/lawn is pervious. Control: 500 roof + 300 garden + 200 lawn on 1000 must retain the corrected no-shortfall behaviour. Do not revive the old mistake of counting all 1000 m2 as impervious.

   **Fix direction:** retain a separate total for all listed surfaces, compare it both ways with the site, and preserve that evidence for the offer. This requires no new engineering coefficient or Settings default.

3. **G03-F3 — MEDIUM — #1547 labels an entirely completed repair check “cancelled” when no hatch needs changing. VERIFIED-BY-READING.**

   **File:line:** at 61ce20de2e5f7c87dfd7e7bf5855e11bdde3a3fc, `Modules/Structural/Commands/HatchUpgradeCommands.cs:293`, `:455`, `:462`; `Modules/Structural/Services/CommandOutcomeLogger.cs:68`. Related missing refusal mark: `Modules/Structural/Commands/HatchCommands.cs:348` and `Modules/Structural/Services/ReoBarService.cs:153`.

   **What the drafter sees:** the command line says the hatch check finished and all hatches are correct, but the CE log says it was cancelled. Re-running Repair after a successful repair produces this result without pressing Escape. The log watcher receives the wrong result for the second run.

   **Exact scenario:** the command starts by setting Cancelled=true. In Repair mode it sets Done only when `repairCandidates.Count > 0`. With all hatches compliant, it completes its scan, prints the totals and `Repaired 0 verified hatch(es)`, then returns with Cancelled still set. The logger therefore emits cancelled even on a normal CommandEnded event. This is a newly introduced explicit-mark error, not a repetition of the old Civil Esc-finished-command finding. The test suite invokes logger flags directly; its compiled-name coverage test does not run the commands behind those names.

   **DETERMINISTIC TEST — fixture:** synthetic mm model-space drawing, unlocked output layers, DIMSCALE 50, LTSCALE 500, the S-41 paper-density switches ON, command outcome logging ON. One rectangular boundary, 5000 by 3000 mm, and one valid associative LBUH hatch created from that boundary. No other hatches.

   **Typed steps:** type `CEHATCHAUDIT`, `Report`; first verify `Total 1 | Correct 1 | Issues 0 | Custom/unmatched 0`. Then type `CEHATCHAUDIT`, `Repair` and let it finish; do not press Escape. Inspect the next `Command outcome: CEHATCHAUDIT` entry in `ce_struc_structured_YYYYMMDD.log`. Repeat Repair once more.

   **Assertions:** both Repair runs must report completion/no repair needed, with the hatch unchanged. Their log entries must be `completed <elapsed> ms` or an explicit successful no-change result, not cancelled. Source predicts cancelled on both. The command line must still say `Repaired 0 verified hatch(es)`. As a separate negative control, start CEHATCHAUDIT and press Escape at the mode prompt: that run must remain cancelled.

   **Related coverage to add, same finding:** `LBUH` with DIMSCALE 50 and LTSCALE 1 returns from ResolveScale without MarkRefused, retaining the new initial cancellation flag. A locked-layer return after accepting CSREOBAR's preview does likewise. Those must log refused, not a user cancellation. Do not treat marking every early return completed as the repair.

**Per-PR comparison with Opus — frozen heads, exact reasons**

1. **#1544 — cx/fb05-c60 — b2f24d0c66a2647c8c8619a4f0478e6a52da1cfa. AGREE that there is no drawing fix; DISAGREE with the reason for closing it.** The entire diff is eight lines of REGRESSION_LOG. It explicitly says BLOCKED/not implemented and names both known writers; it does not falsely claim a fix. Keep it held as routing evidence under the standing no-close ruling. Both the window Close flush and command-end unconditional flush remain the owner's work. No new fault counted. No code, defaults or tests added.

2. **#1545 — cx/fb10-c60 — 8ed032335cc9b85bb5e0db9b4cbc6f65257b1f34. AGREE with the main MERGE verdict, with the known wording reservation still open.** The loaded/disk save-time and version comparison, advisory Unknown revision and independent observed disk hash are present. The second hash prevents a same-size replacement during review escaping detection. The guard holds the file against writers while hashing/reading its header; there is no explicit drawing write in the added reader. Opus's extra read cost and unreadable-header concern remain unmeasured, not new faults.

   The LOW 3 wording was changed, but still says “and it has changed on disk” when an unchanged disk file becomes a known revision after Reload. The test supplies a different disk hash, so it does not prove that wording for an unchanged reload. Keep the old finding open; do not count it again. Native header behaviour, timing, approval and REDO remain untested here.

3. **#1546 — cx/fb08-c60 — eb6133251cf8f14ac5d8b7371bdc1a1c62bc8d05. AGREE: MERGE, subject to normal native verification.** The existing read-only transaction reads valid PIPE_LINK type first and legacy XData only if no valid recorded type is returned. The helper maps defined values without guessing. Opus's missing-field-to-Stormwater caveat is now documented, not repaired; it remains the known LOW. Tests cover precedence, each legacy type and Unknown, plus the actual call's presence. No new transaction, setting or writer was added. No additional defect established in this change.

4. **#1547 — cx/outcome-struct — 61ce20de2e5f7c87dfd7e7bf5855e11bdde3a3fc. AGREE with MERGE-WITH-FIXES, but the outstanding code fix is now G03-F3.** Opus MEDIUM 1 is repaired: Structural now uses JsonReaderWriterFactory, like Manager. LOW 1 is repaired: LoadableTypes retains surviving types after ReflectionTypeLoadException, with a test. I did not run the full Structural suite, so Opus MEDIUM 2 is not independently cleared. The nested-native-mark limitation and Structural-only lack of a Settings row remain known, uncounted items.

   The listeners themselves use memory/event hooks and log output, with no drawing transactions or system-variable writes. The shared Civil setting remains ON by default; no extra switch was added. Explicit CEMEMBER/SBEAM placement completion marks address their Esc-to-finish routes by reading. However, checking that every compiled command name yields a synthetic log line does not prove every actual exit has the right mark: F3 demonstrates the missed case.

5. **#1548 — cx/outcome-mgr — 41d921d9f8323d158fb0cec5b12b67fdf3a7977f. AGREE with the intent and the remaining support-log reservation; the reported duplicate has been repaired.** CommandOutcomeRegistry now suppresses CEBLOCKS while Civil is loaded. Civil's registry contains CEBLOCKS, and its logger owns that remaining line. Manager-alone retains its line. The safe saved-settings reader is present, and block-placement/refusal/failure marks are on the host-thread route. No new drawing writer was added by the marks.

   Opus's LOW about the support zip missing the new Manager outcome file still applies to this standalone PR head; the synchronous small append is unchanged. Neither is counted again. Retain MERGE-WITH-FIXES until the known support collection is accounted for in the receiving train. No new administrator work is requested. The quoted earlier 901/901 result is not a result from this review.

6. **#1549 — cx/eng-small-c60 — 5f37da1b18d8d4499b3e9c80402cda480adf2afa. AGREE with Opus's requested corrections; all three are present in this head.** R-03 actual grade uses at most one decimal and says “just flatter” when rounded text hides the difference. The discharge-only regression has been restored with its 20% comparison, and the issued-discharge test names no longer say Computed. The storage comparison keeps its existing 30% band. Setup reads the same draft/fallback soft-ground coefficient as CivilDesignService.Run. The council rounding question remains held, not silently decided. No new runtime defect established; source disposition MERGE, without claiming the reported test totals were rerun.

7. **#1550 — cx/fb06-c60 — 6c2e90f5f7e50373845a0ce6104e40aff93b1e51. AGREE: HOLD.** A production-tree search finds the new PitRenameOwnership declaration only, no caller. Its whole-name, case-insensitive replacement preserves unrelated ends and avoids repeat changes, but it cannot update a drawing on its own. The known protected writer and Edit Pit integration are still absent. Its pure tests cannot close BUG-664. No new defect counted; no switch or drawing write added.

8. **#1551 — cx/eng-move-pit-grade-c60 — 356ca792c1b402c59bcf2cb150607f6a62acb225. AGREE: HOLD and correct the future default instruction before wiring.** A production-tree search finds only HeldGradeLevelCalculator's declaration. The audit's 15.30 m / 1 in 100 / top 10.00 m calculation gives 9.84 m as intended, in either recorded direction. The log still directs an OFF-by-default gate; Opus correctly identifies that as leaving the bug active. No gate exists yet, so this is the known routing item, not an installed default defect.

   One precision qualification to Opus's “up to 10 mm” wording: with top 10.006 m, the helper first rounds 0.153 m fall to 0.160 m, then floors 9.846 m to 9.84 m. That is 13 mm below the raw 9.853 m target. It preserves minimum fall but the future integrator must describe both rounding steps accurately. No extra finding counted: the helper is inactive and its documented test deliberately expects this result. Do not change an engineering rounding convention through this audit.

9. **#1552 — fw2/bug-966-cdspoon-bylayer-readback — 277ca0de5e409026e456a07013d5f04d66766df4. AGREE: MERGE for the spoon correction.** Both writer colours are 256/ByLayer; both readback predicates now require 256. Layer, owner, closed outline, vertices, normal, hatch type and boundary association checks remain. It is always on with no unnecessary new switch. Opus's CDRG fault is a separately known issue and not solved by this head; do not imply the spoon fix covers it. The real-entity test gap remains: pure predicate/source-pin tests do not prove hatch readback in AutoCAD. The default hatch layer is HATCH 35; the outline is SLAB PERIMETER. C-61 is inherited in this branch, not an extra spoon implementation.

10. **#1553 — fw2/bug-967-bluefactor-garden-lawn — a51a9216112a73e833a9cee79a34a4d26d352405. AGREE with MERGE-WITH-FIXES; DISAGREE that Opus's listed text corrections are sufficient.** The contradictory shortfall note is repaired for the mixed 1000 m2 fixture, and the all-garden parser note now says no roof/paved catchments. “Other” is still included with its warning, leaving Tim's interpretation open. No default, coefficient or drawing write changes. G03-F1 and F2 expose the missing hand-off to eligibility/offer/whole-site checks; the newly added parser-note tests do not cover them. Add the exact downstream tests above, without reinstating garden/lawn as impervious area.

**Cross-PR and delivery checks**

1. **Clashes and bases.** #1545, #1546, #1548 and #1549 changes are also present in the C-61 history inherited by #1552/#1553; those large old-base diffs are not ten independent patches to replay blindly. Compare ancestry when assembling. The two small wave-2 changes touch separate product files. Shared REGRESSION_LOG entries must all survive any future authorised assembly. No merge simulation, code merge or train build was performed here.

2. **Read-only and REDO.** The new outcome listeners and Inspector type lookup contain no explicit drawing writer. Survey header reads are read-only; native behaviour has not been driven. No blanket REDO acceptance is inferred from these facts. The known notes/helper-only PRs remain incapable of repairing their drawing workflows until their protected owners integrate them.

3. **Deterministic-test boundary.** F1/F2 native PDF checks require the 2027 PDF-capable lane; parser/offer checks can be added independently. F3 requires the actual Structural command plus its log, not a made-up Completed/Cancelled flag sequence. All later fixtures must use synthetic documents and isolated/restored settings. This review ran zero tests and made no acceptance claim.

4. **Save scope.** Only `areas/CODEX_PR_REVIEW_GROUP03_23OCT.md` is authored. Existing unrelated CE_PLAN changes are left to their owners. CE_PLAN is fetched and merged with origin/main, without rebase, before saving; this report is staged and committed by name and pushed through the existing leak-scan hook. No code PR is opened, edited, closed, merged or marked ready.

**Summary — under 100 words**

Reviewed ten draft PRs against their named bases and current heads. Three new MEDIUM findings: all-pervious reports can be skipped or lose a known zero, oversized combined catchments lose their warning, and an already-correct hatch repair check logs cancellation. Several Opus corrections are present, but these integration gaps remain. Preserve the held notes/helper-only work; it is not a drawing fix. Existing audit findings were not recounted. No builds, tests, AutoCAD runs or installations occurred. Only this findings file was authored.
