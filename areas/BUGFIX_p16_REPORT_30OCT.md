# BUGFIX p16 report, Fri 30 Oct 2026 (B-074: BUG-822, BUG-1218, BUG-1220)

## ANSWER FIRST
1. **PR:** draft **#1896** "B-074 BUG-1218 BUG-1220 ..." on base claude/rel-20261102a, branch fb/bug1218-1220-help-wording-b074, head 6c6f0db1. B-074 is in the build register, so it is in the title.
2. **BUG-822 skipped, question below.**
3. Wording only. Built and unit-tested. Nobody has opened it in AutoCAD. Nothing marked FIXED.

## FOR TIM
1. **Reverse Flow Help (BUG-1220):** it no longer promises a preview window or an Apply button. It now says what really happens: CE prints one line, asks "Continue? Yes or No" (Enter = No), swaps From and To with their end levels and flips the arrow, and leaves the pipe route and label positions alone. One Undo puts it back.
2. **Label Styles and Move Arrow Help (BUG-1218):** both commands now have a Help page, so searching CDLABELSTYLE or CDMA in Help finds one. Both are marked "typed only" because the ribbon has no button for either.
3. **What to check in AutoCAD:** open Help (CDHELP), search CDREVERSEFLOW: no preview or Apply wording. Search CDLABELSTYLE and CDMA: a card each. Then run CDREVERSEFLOW on a pipe and press Enter: "[CE] Nothing was changed."
4. **BUG-822 (What's New palette opening by itself): not built.** It is not a wording fault: nobody knows what opens it. The What's New window in the code is a plain window shown once at start-up after an update, not a docked palette, so the docked one in the robot's list may be a different thing. Question for CE 04: "Has Tim ever seen a docked 'Creative Engineering | What's New' panel open by itself while drafting? If not, shall we leave this as a robot-only oddity until a test lists the windows after each step?" Recommendation: leave it parked until that test exists.

## My own mistakes
1. First focused run failed 2 tests: a Help test pins the number of Help cards (81). I added two, so it needed 83. Fixed in the same PR.
2. I made one PR for both BUG-1218 and BUG-1220 rather than two: both edit the same Help file lines, so two PRs would conflict. CE 01 can split if wanted (nothing closed).

## NOT proven
1. Nothing seen in AutoCAD: how the new cards look in the Help window, and that search finds them. Window pictures need a Codex look.
2. I did not compare the 2 full-suite failures with the base by name (see below).
3. Manager tests not run (not touched).

## Technical detail
1. **Files:** `Modules/Drainage/Assets/Help/guide-content.js` (CDREVERSEFLOW card rewritten; new CDLABELSTYLE card in Settings list; new CDMA card in Edit list); `Drainage.Tests/Services/HelpGuideCoverageTests.cs` (typed-only list now CEFIND, CDRENUMBER, CDLABELSTYLE, CDMA); `Drainage.Tests/Dialogs/HelpGuideWindowRenderTests.cs` (81 to 83); new `Drainage.Tests/Services/B074HelpWordingTests.cs`; `REGRESSION_LOG.md`.
2. **Cause (BUG-1220):** card text in guide-content.js line 101 on this base; the command (`Commands/RibbonContextCommands.cs` ReverseFlow) asks the Yes/No keyword prompt, default No. **Cause (BUG-1218):** guide cards come only from the panel lists; CDLABELSTYLE and CDMA had none (they have no ribbon button, CdHelpService's context list already names them).
3. **Switch:** none, no behaviour change. No Settings value touched.
4. **Tests:** Civil net10 focused (B074, HelpGuide*, CdDiagWording, DisciplineButtonWording, FeedbackHelpWording) 31 of 31 pass. Full Civil net10: 21,628 total, 21,594 passed, 32 skipped, 2 failed: `SourceAtomicCoordinatorDependencyTests.FinalLandingProducer...` (IL instruction shape, "Expected dup but was stloc.s") and `RefusedNativeCallbackInvalidatesTheManagedSession...` (IL shape, Brtrue vs Brfalse_S). Both read compiler output, not Help; they match the "known IL-shape failures" recorded in memory for net10. net48 compile of the Drainage project: 0 errors. All runs used -m:2, below-normal, -p:SkipDevBundle=true -nr:false --disable-build-servers, fresh scratch TEMP, CE_LOG_DIR_OVERRIDE and CE_STRUC_SUITE_APPDATA_ROOT under C:\ce-scratch\p16.
5. **Settings file listings (name, size, last write), before my first test and after my last:**
   - CE_CVL_SUITE\settings.json 672, 2026-09-16 12:13:17: same before and after.
   - CE_STRUC_SUITE\CS_Settings.json 35613, 2026-10-30 19:54:14: same (that stamp is the earlier BUG-1257 run, not mine).
   - CE_SUITE: folder does not exist.
   - TIM_CE_CADTOOLS: **CD_Settings.json 15270, 2026-10-04 08:22:30: same.** CS_Settings.json, CD_ProjectData.json, label_styles.json, parts_catalogue.json, theme.json, jobtime_resume.json: same.
   - **One change: TIM_CE_CADTOOLS\CD_RecentValues.json (remembered last-typed values, not CD_Settings.json): same size 11948, last write 21:53:36 before, 23:11:34 after.** It falls inside my full test run (23:10 to 23:17), but a robot AutoCAD session also started at 23:13 and the tests that touch that file use their own work-folder copy (Bug306RememberedValuesFileTests). I cannot prove which wrote it. Flagging per the brief.
6. **Robot case (proposed, name in the N31 / C31 style): `H31_help_reverseflow_wording`.** Types CDHELP, then CDREVERSEFLOW in the search box, reads the card text and checks it contains "Yes or No" and not "Apply" or "preview"; then CDREVERSEFLOW, picks a pipe with inverts 10.00 and 9.90, Enter at "Continue?", checks the line "[CE] Nothing was changed." and the inverts still read 10.00 and 9.90. Switch-off control: none exists (wording only); the broken twin is the same case run against the 3.0.85 install, where the card still says "Apply" and the check goes red. A second case `H32_help_labelstyle_cdma_cards` searches CDLABELSTYLE and CDMA and checks each returns a card.
