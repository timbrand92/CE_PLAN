1. **List used.** C-19 / S-20 second-opinion sweep, 5 October 2026, Melbourne time. Authority: C:\CE_PLAN\areas\release-v3-colleagues-REVIEWLANE_LOG.md, newest readiness entry 676, Monday 5 October 10:03 (physical line 705), re-read before writing. That entry calls these Tuesday trains, not Monday trains.

2. **Membership.** C-19: #667 #695 #670 #723 #734 #687 #705, with #734 strictly after #723; #710 is conditional and was included for review. S-20: #673 #665, with #690 reviewed only as the listed alternative to #673. Explicit open additions: #722 and #715, although the newest list places neither in C-19. Structural issue/register/revision title search adds #692 #704 #702 #700 #721 #719 #726; literal title matching also includes #607 (FADOPT Issues wording). Total: 21 distinct PRs. Entry 677's wider unassembled Structural list is not an S-20 membership list. #731 is expressly outside C-19 and was not reviewed.

3. **Authority and limits.** Read RULES.md, ROUTER.md, the product plan and INT-059 through INT-062. INT-060 concerns Windows Search and INT-061 Team usage; neither defines a change in these PRs. INT-062 concerns point loads and member schedules, whose PRs are outside this membership. No claim is made here that the train implements every INT-059 item: title-block choice, Settings Enter, grip-flip messages, pinned pit levels and unknown clearances are not delivered by these reviewed diffs. OK means no identified defect within criteria (a)-(g) in the stated change, not ready to install or AutoCAD-accepted.

4. **Evidence.** Read gh pr diff and gh pr view --json title,headRefName,body,files for every listed PR; inspected relevant branch source where the diff lacked context. References below are paths and line numbers at the reviewed PR head, not local checkout lines. Conditional changes and disabled engines remain conditional or disabled. No builds, tests, AutoCAD, trial merges, downloads to disk, source edits, git writes, settings-file access, bundle access or AppData access were performed; this report is the sole file written.

5. **Reviewed heads.** #667 de7fd4ab; #695 71518af3; #670 c4e20023; #723 1ad62262; #734 c14344c3; #687 308d8c08; #705 a9334dfd; #715 ac4f8d24; #722 e7c0ce97; #710 ef6937f6; #673 a09ece3e; #665 35f8e097; #690 190ed5cf; #692 3e55d788; #704 6c5c4972; #702 b63f5ecd; #700 bd59b328; #721 e4a8aeb2; #719 ffbe8e62; #726 4aed12f2; #607 aaf8b8b8.

6. **One line per PR.**

#667 | OK | Modules/Drainage/Commands/SourceDestinationCommand.cs:47 | RULES 12.4; scope (e) | Uses the open drawing's own record, with no new engineering limit, invented zero or native-protection bypass in the diff.

#695 | OK | Modules/Drainage/Rules/RecoverInvertsCertaintyRule.cs:32 | RULES 12.2 "Unknown stays Unknown" | Keeps an unreadable diameter unknown and removes the guessed 150 mm size when recovering invert labels.

#670 | OK | Modules/Drainage/Services/ScheduleLinkService.cs:3314 | INT-059.18 "Warn and accept" | Accepts C 2 beside C2 and supplies the warning for the placed-cell and plan-label readers, despite the stale refusal wording in the PR title.

#723 | OK | Modules/Drainage/Rules/PitNumberAsTyped.cs:51 | INT-059.17 "Refuse" | Refuses 8 beside P8 through the shared rename rule and makes renumbering skip reserved bare numbers, with New Pit supplied separately by #734.

#734 | OK | Modules/Drainage/ViewModels/PitViewModel.cs:979 | INT-059.17 "Refuse"; INT-059.18 "Warn and accept" | Checks New Pit before saving, refuses 8 beside P8 and lets C 2 beside C2 continue after its warning.

#687 | CHECK | Modules/Drainage/Helpers/LinkedTextEditParser.cs:485; Modules/Drainage/Services/LinkService.LinkedTextEdits.cs:628 | INT-059.16 "Restore P5"; INT-059.18 "Warn and accept" | Restores capitals-only edits, but the double-click reader still rejects C 2 before the shared decision and the successful rename path does not print that decision's warning.

#705 | CHECK | Modules/Drainage/Rules/NewPitCoverProposalRule.cs:15 | INT-059.14 "Blank" | An unset cover choice still follows Remember last pit settings, so reopening New Pit can propose the previous cover instead of leaving it blank.

#715 | CHECK | Modules/Drainage/ViewModels/AdvancedSettingsViewModel.cs:89; Modules/Drainage/ViewModels/AdvancedSettingsViewModel.cs:992 | INT-059.14 "Blank" | Keeps an undecided choice and resets to #705's unset default, so Tim's chosen blank starting behaviour is still missing.

#722 | CHECK | Modules/Drainage/Models/LevelsProposalSettings.cs:74; Modules/Drainage/Services/LinkService.FlatPipeRepair.cs:36 | INT-059.4 "No limit, warn only"; R-00 | Turns the no-limit starting value back into a hard-coded 1-in-20 limit for flat-pipe repair, while the new steepest-grade and warning values still have no Settings-page controls.

#710 | OK | Modules/Drainage/Rules/CloneOriginRule.cs:254 | RULES 12.2 "Unknown stays Unknown" | Distinguishes a proven empty Civil record from an unreadable one and adds only the paste advice, although its separate build-readiness condition remains unresolved.

#673 | OK | Modules/Structural/Services/FoundationService.cs:397 | Native locked-layer/Xref protection; scope (e) | Checks locked layers, Xrefs and REFEDIT before writing a footing link and does not unlock or alter protected content.

#665 | CHECK | Modules/Structural/Services/FoundationService.Grips.cs:191; Modules/Structural/Assets/Config/command-registry.json:2317 | Sweep criterion (f), unrelated changes | Combines footing size and drawing-unit corrections with a separate wind-class help change, which should be separated for this review.

#690 | OK | Modules/Structural/Services/CeTextService.cs:123 | UX-NAMES-01 "Old typed names work forever" | Removes the unused second FST route while the registered FST command remains with FoundationService, so this is an alternative to the same cleanup in #673.

#692 | CHECK | Modules/Structural/Services/CeIssuePreviewBuilder.cs:139 | INT-059.22 "Allow"; R-27 | Still stops the preview whenever the new revision is blank even with no sheet ticked, so the train needs #721's correction.

#704 | CHECK | Modules/Structural/Services/CeIssuePreviewBuilder.cs:140 | INT-059.22 "Allow"; R-27 | Shares the revision-and-date decision but retains #692's blank-revision refusal at this branch head, so #721 is still required.

#702 | CHECK | Modules/Structural/Services/CeIssueJobWidePdfService.cs:127; Modules/Structural/Services/CeIssueJobWidePdfService.cs:137 | INT-059.2 "Replace earlier set" | Replaces only the combined PDF on success and falls back to per-drawing PDFs on failure, leaving earlier issue files alongside the new set instead of replacing the whole set.

#700 | CHECK | Modules/Structural/Services/CeIssueSetReplacer.cs:42; Modules/Structural/Services/CeSheetsIssueService.cs:283; Modules/Structural/Services/CeSheetsIssueService.cs:311 | INT-059.2 "Replace earlier set" | Makes whole-set replacement depend on the optional snapshot switch, checks only PDFs before discarding the earlier snapshot, and expects per-drawing filenames even when #702 produces one job-wide PDF.

#721 | CHECK | Modules/Structural/Services/CeIssuePreviewBuilder.cs:143; Modules/Structural/Services/CeIssuePreviewBuilder.cs:166 | INT-059.22 "Allow"; INT-059.2 "Replace earlier set" | Correctly allows a blank revision with no sheet ticked, but promises that today's earlier issue will be replaced although this branch has no whole-set replacement and #700 makes it optional.

#719 | OK | Modules/Structural/UI/Dialogs/CeSettingsDialog.xaml.cs:68 | R-00; plain-English scope (g) | Adds a plainly named saved preview switch without new engineering values or blocks, but remains preparatory because no issue window calls the preview yet.

#726 | OK | Modules/Structural/Services/CeOfficePlotCheck.cs:50 | INT-059.11 "Warn on any departure"; RULES 12.2 | The disabled check returns warnings for differing plot settings and explicitly reports unreadable facts, with its drawing reader and Settings-page fields still to come.

#607 | OK | Modules/Structural/Models/FoundationStatusWords.cs:93 | RULES 2.4, plain English; scope (g) | Changes footing issue messages to drawing words while keeping object handles and class names in the log.

7. **Count.** 11 OK / 10 CHECK, 21 reviewed; builds and tests run: 0.

8. **Most important finding — issue sets can disagree.** INT-059.2 says "Replace earlier set". #700 makes replacement optional and does not check that all new drawing snapshots were copied before removing the old set. Combined with #702, its completeness check expects per-drawing PDFs that the new join removes, so it can restore the old drawings beside the new combined PDF. #702 also leaves stale issue files when used alone; #721's unconditional replacement promise is therefore premature. These are source-path findings, not a trial-merge or AutoCAD result.

9. **Most important finding — New Pit can recall the wrong cover.** INT-059.14 says "Blank". #705 and #715 still let the old Remember last pit settings tick refill the cover after restart, for example proposing the previous pit's 12.340 m cover on a different pit. Neither PR supplies the chosen blank default; #731's title suggests a follow-up, but its implementation was outside this sweep.

10. **Most important finding — hidden steep-pipe limit.** INT-059.4 says "No limit, warn only" and R-00 requires editable Settings values. #722 changes the proposal default but explicitly substitutes 1 in 20 for flat-pipe repair; its own added tests expect a 1-in-5 held pipe to remain "Check by hand". The reviewer comment limiting Tim's ruling to proposals is not present in Tim's recorded answer, and neither new value is exposed on the Settings page.
