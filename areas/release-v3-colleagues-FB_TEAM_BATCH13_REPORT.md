# Team fix batch 13: carpark BUG-1075 to BUG-1079 (Codex audit RD11 wording)

Sat 24 Oct 2026, about 07:27 to 09:15 Melbourne (PC clock). Opus 5.5, Team, headless. Built and unit-tested only. Nobody has opened any of this in AutoCAD. Nothing installed, no AutoCAD / Codex / accoreconsole started, no settings files, bundles or ProgramData touched, CE_SHARED unchanged, no PR closed, no branch deleted, no bug marked FIXED, BUG_CARPARK.md / DESK_LOG.md / QUEUE.md not edited.

## ANSWER FIRST

1. **BUG-1075 (CDSPINEUPGRADE preview wording), SKIPPED: already fixed.** Codex PR #1718 (`cx4/fa06-plain-words`, head `625d7a44`, base `claude/rel-20261023m`, draft, open) carries this fix (CODEX_FIXAUDIT_FA06_23OCT.md item 3). I commented on #1718 to say so. No duplicate made.

2. **BUG-1076 (Structural Settings "verbose diagnostics" not explained), FIXED in draft PR #1739, head `8218fe1c`.**
   - **What Tim will see:** CESETTINGS > System, first tab now "Saving and fault reports". Labels "Record fault and speed information", "Include extra detail in that log" with a grey line "The extra detail is for investigating a fault. Normal drafting does not need it.", "Report work taking longer than (ms)", "Show save messages on the command line". Values, defaults and bindings unchanged; the settings-recovery list uses the same names.
   - **Tests:** new `Bug1076FaultReportSettingsWordsTests`, 6 of 6 failed on the base, 6 pass after (opens the real Settings window and checks each label and the grey line sit inside it). The test render of the page was opened and looked at: nothing clipped.
   - **Real-AutoCAD check:** type CESETTINGS, click System, first tab. Read the four labels and the grey line, check nothing is cut off. Cancel without saving.

3. **BUG-1077 (BSET explained with an internal label), FIXED in draft PR #1740, head `ebf480f3`.**
   - **What Tim will see:** BSET hover "Pick a point inside the building so CE can put lintel labels outside." CEHELP: "CE remembers the point in this drawing and uses it to put lintel labels (L, RL) on the outside face of the wall. Pick another inside point for each separate building." No "seed", "persistent store" or "J11.2". Checked against the code: the point is stored in the drawing and several are kept.
   - **Tests:** new `Bug1077BsetHelpWordsTests`, 6 of 6 failed on the base, 6 pass after.
   - **Real-AutoCAD check:** hover the BSET button on the CE Structural ribbon; CEHELP, search BSET, open Beam Set Inside Point. No point needs placing.

4. **BUG-1078 (Markup Help explains implementation), FIXED in draft PR #1741, head `0eef8a25`.**
   - **What Tim will see:** CEHELP for Open Saved Markup Review, Set Drawing for Markup (with the note "Do this before applying markup changes.") and Apply Next Markup Group in the words from the carpark entry. Preview Next Markup Group and Undo Last Markup Group had the same "sub-batch"/"executor" words, so I cleaned them too. Approval and run paths unchanged.
   - **Left for Tim:** these tools sit under the "Administration" group heading. Moving them to a drafting group changes where they appear in Help, so I left it. Option A: keep Administration (no change). Option B: move the markup tools to a "Markup" drafting group. My recommendation is B, because they are drafting actions, but only on your word.
   - **Tests:** new `Bug1078MarkupHelpWordsTests` (26). 10 failed on the base, 26 pass after.
   - **Real-AutoCAD check:** CEHELP, search and open CEMARKUPLOAD, CEMARKUPREGISTER, CEMARKUPRUN (and Preview / Undo Last Markup Group). Do not click Run.

5. **BUG-1079 (PDF export Help names a code class), FIXED in draft PR #1742, head `6fb92d11`.**
   - **What Tim will see:** "Plots the current layout to a PDF file you name, using the DWG To PDF plotter, scaled to fit the sheet and centred. AutoCAD's plot progress window shows while it plots, with a Cancel button." Note: "The command finishes when the PDF has been written. If another plot is still running, wait for it to finish first."
   - **Finding:** the old "runs in the background ... returns immediately" was **untrue as well as jargon**. The command plots on AutoCAD's main thread (the code says the plot engine must never go to a background task). So the Help no longer promises background plotting.
   - **Tests:** new `Bug1079PdfExportHelpWordsTests` (6), including a source guard that fails if the export ever moves to a background task. 4 failed on the base, 6 pass after.
   - **Real-AutoCAD check:** CEHELP, search STRUCEXPORTPDF, open Export Layout to PDF and read it. Do not run the export.

6. **Totals (all four fixes combined in one working copy):** Structural net10 **5,747 passed, 0 failed** (19 class chunks: 293, 363, 249, 239, 333, 219, 248, 100, 378, 263, 370, 292, 576, 317, 291, 251, 463, 495, 7). That is the S-42 figure of 5,704 plus the 44 new tests, give or take one from the chunk filters and the newer base head. Structural.Tests net48 compiles with 0 errors.

7. **What I did NOT test:** nothing was opened in AutoCAD; nothing was plotted. net48 tests were not run, only compiled. Structural net8, DesignCore, Drainage and Manager were not run. The Sbeam evidence class was left out (it hangs, as in S-42). Each branch got its own build plus RED-then-GREEN on its own tests. The full suite ran once, on the four combined, not once per branch.

## Detail

1. **Bases:** `origin/claude/rel-20261023m` was at `f7f7d551` after `git fetch` (Civil base; BUG-1075 only, skipped). The four Structural bugs used `origin/claude/rel-20261023s` at `e6d597c0` ("Version: Structural 1.0.122 (S-42)"), with the build refs from the S-42 report (`_AcadRef48` autocad-2024-ref, `_AcadRefNet8` autocad-2026-ref, `_AcadRef100` autocad-net8-ref) and AutoCAD 2027 on PATH.
2. **Duplicate check:** `gh pr list --state all --search` for each BUG id and its key words (CDSPINEUPGRADE, "verbose diagnostics", BSET, "lintel inside point", "markup help", AsyncCommandService, RD11). The only real fix found was #1718 (BUG-1075). Other hits were unrelated (#630 is BSET command-line words, not the Help; #515 is BUG-334 behaviour). `cx4/*` branches listed (fa01 to fa07). FA06 skipped BUG-1076 to BUG-1079 as protected in the Civil brief; this batch's brief puts Structural bugs on the Structural train, so they are done here.
3. **Cause verified in code before each fix:** the registry lines named in each entry contain the quoted words; the Settings page and the recovery list contain the old labels. For BUG-1079 the export source shows main-thread plotting.
4. **Protected files:** none touched (no CE_SHARED, Installer or signing). BUG-1076 adds one grey line under an existing tick box and renames labels in place, the same pattern as the line already under "Also autosave Civil-only drawings". It is not a Settings layout redesign. The rendered page shows it fits.
5. **Settings switch:** none. These are wording fixes to existing text. No behaviour changes.
6. **Environment notes:** the shared `C:\CE_PLAN\desk_jobs\build.lock` was busy for 8 minutes at the start while several other lanes built without it. My later builds waited 60 s for it, then went ahead at Below Normal with `-m:1`. One chunk first failed `ManagedPublicApiAndReferences_MatchAcceptedBase` because git was not on my script's PATH (the test calls git). With git on PATH it passes. The window-picture tests regenerated `docs/image` files; they were discarded, not committed. C: free space stayed at 17 to 21 GB.
7. **Cleanup:** worktrees `C:\ce-fx\b1076`, `b1077`, `b1078`, `b1079` removed. Branches stay on origin for the PRs.
8. **Undo:** each PR is one commit on its own branch; revert the commit or leave the draft unmerged.
