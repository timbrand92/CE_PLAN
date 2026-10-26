BUG-1191 — BUILD IN PROGRESS (full-suite comparison running)

1. **ANSWER FIRST:** BUG-1191 only. Built and tested off-screen; nothing installed. Draft PR not created yet. Final full-suite result and delivery remain pending.

2. **Heads:** Branch cx4/bug-1191-survey-intake-all-findings. Saved head bd0586b70b6b85b371036c7fbed00fd318563691. Base used at the first fetch: d8840a0920f97fedc3b94f98e56eb5a4eb6b663e, matching the brief's head. Latest fetch gives the same release head; merge reports already up to date. No master merge, rebase or force-push.

3. **What Tim will see after installation:** CDSURVEY on a survey Xref with eleven doubtful spot levels: the Survey Intake page lists all eleven, including the one at RL 100.000 and (31.0, 0.0), instead of ten and 'and 1 more'.

4. **Red first:** With product code unchanged and only the test file edited, three requested cases ran: two passed, one failed. Actual failure:

   Failed SurveyIntakePendingReview_Bug1191_ElevenFindings_AllElevenAreListed [94 ms]
   The eleventh detail, Spot RL 100.000 at (31.0, 0.0), must be available before approval.
   Expected: some item String containing "Spot RL 100.000 at (31.0, 0.0)"

5. **Green:** All 18 added BUG-1191 cases pass. The latest expanded run also passed all 78 selected Settings, route and finding cases. Actual latest passing lines:

   Passed SurveyIntakePendingReview_Bug1191_ElevenFindings_AllElevenAreListed [2 ms]
   Passed SurveyIntakePendingReview_Bug1191_SwitchOff_KeepsTheOlderTenAndMoreLine [6 ms]
   Passed SurveyIntakePendingReview_Bug1191_TenFindings_StillListedWithoutAMoreLine [1 ms]

6. **Full suite before:** Untouched-base console total 20,380: passed 20,347, failed 1, skipped 32. Only failure: Diagnostic_MessagesReachTheLogFile, 'Queued diagnostic never reached the log file'. Duration 27 m 26 s. The TRX includes 28 additional unexecuted cases: total 20,408, not executed 60. The final after run is currently active; do not treat its partial output as a result.

7. **Exact real-AutoCAD check — NOT RUN:** Use a survey Xref with 32 text spot levels: 21 values 10.000 to 10.200 at 0.010 m steps, then eleven at 100.000; last point at (31.0, 0.0). Run CDSURVEY, open Survey Intake, scroll and count eleven descriptions including 'Spot RL 100.000 at (31.0, 0.0)'. Cancel intake so nothing is stored. Without Manager, check all eleven descriptions print before the approval choice, then cancel. Switch off and repeat to check the older ten-and-more list returns.

8. **Not run:** AutoCAD, the Manager window on screen, NETLOAD, installation or deployment. No real-AutoCAD pass or acceptance is claimed. Tim's settings files were not accessed.

---

9. **What changed:** The pending review captures one ordered description list for both routes. The page receives every finding. The Manager command-line summary stays at ten and names the page for the rest. If the page will not open, including blocked intake, the command line lists everything. Newly printed lines start [CE]. Finding rules, verdict, Approve, Cancel and stored survey data are unchanged.

10. **Switch:** survey.surveyIntakeListsEveryFinding starts on. Older files load it on; a typed off is kept. Off returns the older ten-and-more list. The Settings > Survey row uses the existing load, save, reset, search and changed marks. The new persistence test writes settings in memory only. The existing whole-suite setup also redirects settings and logs to test-owned folders.

11. **Window fit and pictures:** The whole Settings window measures 670 px in ordinary and warning states, below 673 px. Existing 100%, 125% and 150% screen checks pass. The switch fits in the existing purpose row; the original Survey wording, theme, typography, header and footer remain. No layout scrolling or expander added.

   Six real-markup/control pictures were rendered off-screen on an STA thread at 96 DPI, then opened and inspected. The warning state also checks the 150% screen budget. No clipping or overlap; all eleven descriptions are visible. These are not Manager or AutoCAD on-screen evidence.

   docs/image/V3_WINDOWS/bug1191-settings-dark-survey.png
   docs/image/V3_WINDOWS/bug1191-settings-light-survey.png
   docs/image/V3_WINDOWS/bug1191-settings-dark-survey-warnings.png
   docs/image/V3_WINDOWS/bug1191-settings-light-survey-warnings.png
   docs/image/V3_WINDOWS/bug1191-survey-intake-dark-review.png
   docs/image/V3_WINDOWS/bug1191-survey-intake-light-review.png

12. **Latest builds:** Release net48: zero errors, 242 warnings, 7 m 24.50 s. Release net8.0-windows: zero errors, 216 warnings, 6 m 5.09 s. Release net10.0-windows: zero errors, two warnings, 15.77 s. The product source has not changed since these builds.

   Every .NET build/test used -p:SkipDevBundle=true -nr:false --disable-build-servers and the following reference parameters:
   -p:_AcadRef48="C:\TimOS\refs\autocad\autocad-2024-ref"
   -p:_AcadRefNet8="C:\TimOS\refs\autocad\autocad-2026-ref"
   -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"

13. **Setup and count checks:** C: had 51,147,239,424 bytes free before setup. The first untouched-base build lacked the native transform file; built the existing production native project inside this worktree, with zero errors and no source edits. A zero-test discovery attempt is NOT counted. Adding AutoCAD 2027's library folder to the test process PATH allowed the real suite to run; AutoCAD was not started.

14. **Corrections kept in the evidence:** An incomplete comparison caught an existing source guard that expected the older inline Manager condition; it now checks the shared condition and page route while retaining command-definition and fallback assertions.

   The first completed after run had 20,398 cases: 20,355 passed, 11 failed, 32 skipped. Nine Settings height checks were mine: the extra row made the whole window 691 px. I had measured only the Survey page. Moving the row into the existing heading row and checking the whole window resolved all nine; the limits were not changed.

   That completed run also had the baseline log failure and a PDF busy-resource error (0x800700AA). The unchanged PDF check passed in isolation; no PDF code or test was edited. A later incomplete run caught my unnecessary shortening of the Survey purpose text; its original wording is restored. The whole downpipe Settings fixture and all 78 selected checks now pass.

15. **Safety and scope:** Display only; no drawing write. Undo/REDO, locked layers, Xrefs and REFEDIT protection are unaffected. The survey Xref remains read only. No protected file, Structural file, CE_SHARED source, save/undo handler, placement service or protected window was edited. No client names, site addresses or secrets were introduced; all six pictures use synthetic inputs.

16. **Evidence on disk:** C:\ce-cx\bd11-evidence holds base.log/base.trx; red.log/red.trx; complete-settings-checks.log/.trx (78 passed); verified-pictures.log/.trx (18 passed); verified-build-*.log (latest three builds); pdf-resource-retry.log/.trx; and earlier comparison evidence. The current full run writes after.log/after.trx. Worktree: C:\ce-cx\bd11.

17. **Remaining delivery:** Finish and compare the full run; update only the top BUG-1191 regression entry with actual totals; commit, scan and push the source branch; create a DRAFT PR against claude/rel-20261025r; replace this report's pending fields and push it by name; remove only the owned worktree. Do not report DONE if any additional failed name remains. BUG_CARPARK.md, DESK_LOG.md and QUEUE.md remain untouched.
