# Save, partial placement and consumer audit

FOR TIM

Checklist saving and drawing saving are correctly separated. Cancelling the template selector can still save changes already accepted in its editor. Four details need correction in the Structural recovery record before it is treated as reviewed.

---

Clock captured 2026-09-16 13:25:06 UTC / 23:25:06 Sydney. Bounded source/document audit only; no runtime, AutoCAD, build, installed-version or acceptance claim.

## Material findings sent to root

| ID | Severity / evidence | Required correction |
|---|---|---|
| SAVE-01 | Medium. ExcelMTextService.cs:3460–3493 catches per-section placement exceptions without a per-section rollback, then commits the enclosing transaction. Writer supplement currently describes skipped/placed versus unplaced sections. | A failed section can itself contain partial geometry. Classify complete / partial / absent / unknown placement, with actual identities. Inspect before retrying that floor; do not equate skipped with empty or silently duplicate partial rows/frames. Source risk, not an executed failure. |
| SAVE-02 | Medium. MemberScheduleService.cs:120–156 returns void, may return early on missing NOD, and catches/logs write exceptions. XclmTxtService.cs:293–319 calls it and then prints snapshot saved. | Record separate placement and snapshot persistence receipts. The saved message is not proof; failed snapshot persistence must remain visible and must not authorise downstream support size selection. Source risk, not proof of an observed failure. |
| SAVE-03 | Low source-claim precision. LegacyPortCommands.cs:212–235 tries Erase for every non-Standard, non-dependent, non-erased style; there is no explicit usage test. | Replace source description “unused styles” with the actual attempted candidate set and caught exceptions. Proposed reviewed unused-style cleanup remains a target, not evidence of current eligibility. |
| SAVE-04 | Low navigation/status. Earlier structural_control_semantics_supplement still directs next work to MTS/writer/template persistence traces now supplied. | Add direct governing follow-up links to writer supplement and root22; mark those source traces completed while native qualification remains pending. Avoid sending the next owner to repeat completed work. |

INT-01 is closed by actual read-back: root20 step1 now leaves ambiguous identity unresolved without guessed-job writes, links the existing decision bank; root21 explicitly labels the exceptional recovery interaction unapproved. No invented identity picker.

## What was verified

- Root22 checklist caller: ChecklistPanel.xaml.cs:741–780 saves edited templates before testing selector result. TemplateManager.cs:1290–1320 clears cache, deletes JSON files and saves individually without aggregating outcomes. ChecklistStorage.cs:107–180 commits drawing data; :303–310 creates a fresh instance. The record correctly avoids a library atomicity, completion-preservation or DWG disk-save claim.
- Root22 Civil SaveToDrawing: direct read of ProjectDataService.Persistence.cs:514–557 shows dictionary serialisation/transaction commit, not a DWG disk write. Close/reactor timing rows were not independently reread in this delta; remain bounded attributed observations.
- Layer Manager: direct handler reads :137–204 and LayerService.cs:318–392 support immediate drawing mutation versus grid staging and Close not rollback. Full native protection/Undo remains unverified.
- MTS: direct LegacyPortCommands.cs:111–243 supports broad non-Xref-record sweep, Standard property writes, independent dimstyle changes, current style change and one commit. ST4-11 explicitly applies to R2LTXT, so it does not independently approve the proposed MTS redesign. No native safety claim.
- XCL: ExcelMTextService.cs:500–541 and3460–3493; XclmTxtService.cs:245–329; MemberScheduleService.cs:9–35,120–156; SupportBlockCommands.cs:198–233. Writer success triggers snapshot from all marked result rows, not verified placement. Optional learning also follows that success. Matching stored support size bypasses the ordinary size prompt. No automatic existing-member rewrite was established or claimed.
- Root23 complete read: proposed handoff information, candidate/adopted separation, presentation-only edits, explicit independent Structural scope, allocation conservation, no automatic share redistribution, and included-versus-revised sheet sets are consistent with retained approved boundaries. Arbitrary units are expressly accounting examples. No new engineering defaults or implementation claim found.

## Remaining planning versus implementation gates

Root23 now supplies useful concrete state and failure contracts for earlier broad seams. Exact allocation tolerance and copy/reassignment interaction remain openly unsettled; do not answer them with synthetic 60/40 examples. Matching fingerprints, consumed-version persistence, exact all-selected PDF grouping and revised-only dates are owner implementation/qualification gates, not reasons to invent runtime proof during planning.

The material source and authority corrections above and navigation correction require read-back. The source-to-target MTS review change and XCL placement/snapshot receipt need an explicit owner handoff before implementation. Current review does not require implementing them tonight. INT-02 rounding consumer reconciliation remains independently tracked. Final whole-plugin coverage reconciliation and morning pack are still pending; this bounded audit is not an overall pass.

## Additional direct authority finding — SAVE-05, medium

ST-04_TEXT_PLACEMENT.md:60 states **ST4-11 applies to R2LTXT**. Both planner supplements attribute MTS eligibility/preview target to that approval. This is overbroad unless a separate later MTS approval exists. General native-protection and command-review requirements remain binding, but label the specific MTS Preview/Apply/cleanup redesign proposed pending its reviewed card, or cite the exact later scoped approval. Root notified. The initial audit sentence was corrected immediately after this canonical read; no MTS approval is certified here.

## Correction read-back during the same audit

Actual writer supplement reread after planner edits: SAVE-01 now distinguishes partial same-section entities and duplication risk; SAVE-02 now says snapshot write attempt, early return/logged failure and separate persistence state; SAVE-03 now names actual erase candidate set and absent unused-style test. Root22 link added. These three source corrections are closed for planning wording. SAVE-04 companion navigation substantially corrected; historical next-batch text should still be understood as earlier-pass scope. SAVE-05 authority correction remains pending at this checkpoint.
