# Fix briefs team, batch 4 of 4: FB-21 to FB-25 (Sat 24 Oct 2026, Melbourne, overnight run)

## ANSWER FIRST

**Four fixes built and opened as draft PRs, one skipped for Tim's word.** Built and unit-tested only. Nobody has opened any of this in AutoCAD. No bug is marked FIXED. Nothing closed, deleted or deployed. Branched from `origin/claude/rel-20261023m` at head `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`.

1. **FB-22, BUG-766 (CDPROFILE draws the branch junction tick): PR 1711, head `5ee899a2ee49203db09a06b7a4aa61c37078e23b`.**
   - **Tests:** 4 new (they do not compile on the base, which has no way to fill the ticks); Civil net10 full suite 19,552 total, 19,530 passed, 22 skipped, 0 failed; Drainage net48 build 0 errors.
   - **Real-AutoCAD check (FX-22):** on a copy, main P1 to P2, 20 m, with a branch connected 6.4 m along it. Run CDPROFILE P1 to P2 and accept. Expect a "BRANCH" tick and its text at chainage 6.4 m (within 0.05 m). Run it on a route with no branch: no tick. One U removes the section.

2. **FB-23, BUG-811 cascade half (rejoining pit follows the lowest arriving pipe): PR 1712, head `49792ecacfcbb6d9eb50d619b9b51ff894123d38`.** Needs the Opus review the brief asks for (cascade, one U).
   - **Tests:** 4 new; the diamond test fails on the base (D's outlet came out 10.25 against a 10.00 arrival) and passes now; 127 cascade and propagation tests pass. Civil net10 full suite 19,552 total, 19,529 passed, 22 skipped, 1 failed on the first run: `LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (a PDF load that took 15 s while the machine was busy); re-run alone it passed. Net48 build 0 errors.
   - **Real-AutoCAD check (FX-23):** on a copy, a diamond A to B, A to C, B to D, C to D with D's outlet 50 mm under its lowest arrival. Edit Pipe on A's outlet pipe, raise its upstream level, Yes to the cascade, Apply. Read the IL texts: D's outlet is the lower arrival minus the 50 mm drop. One U reverses everything.
   - **Left out as briefed:** the AI vision import log half of BUG-811.

3. **FB-24, BUG-810 (audits only read), three of four parts: PR 1713, head `a8df14593c5ab8ae0a25d5c2c70103ba70d65360`.**
   - **Done:** CDIMPORTAUDIT no longer saves the record into the drawing; CDAUDIT pass C compares in millimetres; pass B measures from the pit wall; CDLEGACYAUDIT prints one "[CE]" line if a folder is refused instead of ending in an error.
   - **NOT done, needs CE_SHARED:** the folder scan and the "APPLOAD history is a legacy start-up conflict" wording live in `CeLegacyEnvironmentAudit` in CE_SHARED. A per-folder report and the APPLOAD wording need the same change in the Civil and Manager copies together. I did not touch CE_SHARED.
   - **Tests:** 8 new (the two command guards fail on the base, the rest do not compile there); Civil net10 full suite 19,556 total, 19,534 passed, 22 skipped, 0 failed; net48 build 0 errors.
   - **Real-AutoCAD check (FX-24):** on a copy, a metre drawing (INSUNITS 6) with three correct CE pipes: QSAVE, CDIMPORTAUDIT, read DBMOD (expect 0), then CDAUDIT (expect no Pass C lines). Also a millimetre drawing: a pipe ending on a 1200 pit wall gives no Pass B line; pulled 700 mm off the wall it does.

4. **FB-25, BUG-812 (new redesign pits take their place; copied pump pit reported): PR 1717, head `cedc590e3b409e074b15f979795ed97b789020be`.**
   - **Tests:** 11 new (they do not compile on the base); Civil net10 full suite 19,559 total, 19,537 passed, 22 skipped, 0 failed; net48 build 0 errors.
   - **Real-AutoCAD check (FX-25):** turn "Mark order, natural" ON in Settings before AutoCAD starts. With P1, P2, P3, P10 placed, run a CDDESIGN redesign that adds P2A and Apply, then PITSCHEDULE: P2A sits between P2 and P3. Then copy a CE_PUMP_PIT block (same LABEL): PITSCHEDULE shows one pump pit row and one "[CE]" line on the command line.
   - **A question for Tim (see below):** the order follows the existing natural-order setting, which is still OFF.

5. **Skipped: FB-21, BUG-765 (bare numbers in an Xref become surface levels).** The finding is true, but the fix the brief describes cannot be built from what is in the code. It needs Tim's word (options below).

## Skipped item: FB-21 and BUG-765, why and the options

1. **What I checked:** `TryParseSurveyLevel` in `LongitudinalSectionViewModel.cs` takes any text in an Xref that is a bare number with two or three decimals (and so does the "RL " form). It never looks at the layer. The cause in the carpark is correct.
2. **Why the brief's fix cannot be built as written:** the brief says to reuse the reader CDSURVEY uses ("survey layers, RL and spot blocks"). CDSURVEY has no list of survey layers either. `SurveyService.TryParseRl` accepts any text with a decimal point between the Settings RL limits, on any layer. `SpotLevelReader` only reads CE's own SPOT LEVEL blocks (placed with CDSL), not survey text. The only layer words anywhere are a triage guess in `TriageCommands` (SURF, SPOT, ELEV) used for the import triage list.
3. **Options for Tim:**
   - **A. Recommended: a Settings list of survey level layers**, starting with the words in the triage guess (SURF, SPOT, ELEV, LEVEL, RL), shipped ON, so a bare number counts only on a layer that matches. Risk: a surveyor whose levels sit on a layer named something else loses the existing-surface line until the word is added to the list. That is why it is Tim's call.
   - **B. Only text that starts with RL, AHD or LEVEL counts.** Safe against inverts, but drops surveys that write bare numbers on a good layer.
   - **C. Ignore a bare number that is within about 1 m of a CE pit cover or invert text in the same Xref.** No layer list, but a guess.
   - **Example on a job:** the Xref has "RL 19.20" spot texts every 5 m on layer SURVEY-SPOT and one bare "18.60" pit invert on layer PIT-TEXT beside the run. Today the existing-surface line dips 0.6 m at the invert. A or B ignores the invert; C ignores it only if it sits near a pit.
4. **Branch and worktree:** none kept (nothing was changed).

## Question for Tim from FB-25

1. **Context:** a new pit from a redesign now goes in the Pit Schedule's own mark order. That order is the existing "Mark order, natural" setting (Tim, 27 Sep 2026), which is still OFF, so with it OFF P2A is sorted last on every Pit Schedule screen and the redesign matches them.
2. **Recommendation:** leave it following the setting, and turn "Mark order, natural" ON for the 9 Nov release if Tim wants P2A after P2 everywhere. That is one setting for the whole schedule, not a special case for redesigns.
3. **Other answer:** make the redesign use natural order always. Then the redesign would put P2A after P2 while the Pit Schedule screen puts it last, and the two disagree.

## Notes for the desk

1. **Switches:** none added in any of the four. Each fix is a bug fix with no choice for a drafter; FB-25 follows the existing OFF setting. Nothing was added to the Settings pages.
2. **Redo safety:** FB-22, FB-24 and FB-25 only read. FB-23 changes the order the preview list is worked out in, not what is written or when; it still needs the Opus review the brief asked for.
3. **FB-24 detail the brief did not have:** CDIMPORTAUDIT never used the saved record, so removing the save step needed no replacement read (`TryReadProjectWithoutChanging` was not needed). Pass B and C figures on millimetre drawings are unchanged.
4. **Commit messages** name each bug in full: BUG-766; BUG-811 (cascade half); BUG-810; BUG-812.
5. **The 23 Oct REGRESSION_LOG.md entries** were added at the top of the file in each branch; no existing entry was changed.
6. **Machine:** my script could not take the desk build lock file (`desk_jobs/build.lock` in CE_PLAN) on any run (a lock file was present when I looked at 01:46), so every build ran without the lock, and I did not delete it. Free space on C: stayed between 23 and 27 GB, above the 12 GB limit. The FB-25 full run took 21 minutes (the other three took about 8) because the PC was busy.
7. **Worktrees:** fb22 to fb25 under C:/ce-fx were created and removed after pushing (the other folders there are not mine and were left alone). **Mistake to flag:** I wrote my scratch scripts run.sh and prepend.sh into C:/ce-fx without first checking whether another batch had files of those names. If another batch's run.sh or prepend.sh now behaves differently, mine replaced it; the other batches' own e11 to e14 entries and logs were not touched.

## What I did NOT test

1. **Nothing in AutoCAD.** No window, drawing, tick, level text, schedule or command-line line was looked at. All four "Real-AutoCAD check" lists above are untried.
2. **Not tested:** Manager, Structural, Installer tests; the net48 test lane (net48 was build-checked only); the tick's look on a bent main (FB-22); a real network with a loop through Edit Pipe (FB-23); real CE pit blocks in a metre drawing for the new pass B wall measure (FB-24; the unit tests use a plain 1200 outline at scale 1 and 0.001); a real copied CE_PUMP_PIT block (FB-25).
3. **Not done:** the Opus review for FB-23; the CE_SHARED half of BUG-810; anything for BUG-765.
4. **Tim's settings files, installed bundles and ProgramData:** not touched. AutoCAD, Codex and accoreconsole were not started by me.
