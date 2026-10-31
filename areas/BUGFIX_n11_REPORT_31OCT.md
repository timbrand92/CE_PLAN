# Batch 11 report (B-125, key n11): Tidy labels command internals

Written Sun 1 Nov 2026 (Melbourne), headless job n11, Team. Four draft PRs, one per bug. Built and unit-tested only. Nobody has opened any of this in AutoCAD. No bug is marked fixed.

## FOR TIM (read this part only)

1. **What was built:** four small fixes to the Tidy labels command (CDTIDYLABELS), each behind its own Settings switch that ships ON. Each is a separate draft PR, so you can take or leave each one.
   1. **#1977, BUG-873:** answering No or pressing Esc in Tidy labels no longer touches the drawing. Before, the command stamped the drawing as a CE drawing and could save CE's record into it before it even asked you anything (a REDO costs and a drawing that looks edited). Now that happens only after you type Yes.
   2. **#1978, BUG-890:** only matters when "move a crowded label out with a leader" is on. A callout is no longer sent onto a plain label that stays where it is.
   3. **#1979, BUG-891:** a pipe drawn in a layout is now tidied against that layout's own text (before it was checked against the model-space text at the same coordinates), and the leader-out search now reaches as far as the leader-out distance in Settings.
   4. **#1980, BUG-962:** on a big drawing (thousands of survey texts, hundreds of pipes) Tidy labels starts counting sooner. It moves nothing differently; it only skips far-away text faster.
2. **What a drafter will see differently:** only 873 and 891 are visible. 873: after Tidy labels with No, the drawing has no "edited" mark. 891: a layout pipe's labels are no longer shifted for text that is only in model space. 890 and 962 are rare or invisible (890 needs leader-out on; 962 is speed).
3. **Mistakes of my own, first:**
   1. My first test command passed the AutoCAD 2027 folder (it has a space in its name) the wrong way and failed in a second. No harm; I removed it because the build finds that folder by itself.
   2. I lost about two hours waiting: C: sat at 22 GB (below the 27 GB floor) from about 01:10 to 02:35, then recovered by itself to 58 GB. I deleted nothing. My own worktree was only 0.6 GB; the space was held by something else on the PC.
   3. My first wait command was cut off at its 30-minute limit and I had to start it again with a longer limit.
4. **Real settings files (RULE: stop and say so first):** the before and after listings of Tim's real folders are NOT identical. 161 files are new or changed and 20 files are listed in the old state only because they changed. I checked whether my runs could have written any of it: they did not. Evidence: (a) every settings-touching test class I ran (the tidy gate and leader-out tests) builds its settings inside a test scope redirected to the test work folder; the new B-125 tests only read settings from text; (b) I ran no Manager tests and no AutoCAD; (c) the changes include the CE menu file (`CE_SUITE_MANAGER_MENU.cuix`), the Manager menu state, the usage outbox and the session files, which only a running AutoCAD with CE writes; (d) another job's `acad.exe` started at 03:14:40, three seconds after `TIM_CE_CADTOOLS\CD_Settings.json` was last written (03:14:37) and the changes run on to 03:15:33, which is the pattern of a robot case that sets a switch and then launches AutoCAD (the robot lane, CE 02). **`CD_Settings.json` did change (15,357 to 15,315 bytes, last write 03:14:37), so you should know:** I believe it is the robot lane's own settings write, but I cannot prove who wrote it; I have not read its contents. Nothing under `CE_STRUC_SUITE` or `CE_SUITE` settings changed (only log files under `CE_STRUC_SUITE\logs`, from the same AutoCAD session).
5. **What you need to do:** nothing yet. Each PR needs a robot pass (cases below), and 873 and 891 want a Codex look. They are stacked on #1975 (B-124), which must merge first.

---

## ANSWER FIRST (technical)

1. **PRs (all DRAFT, base = `claude/b124-n10-bug1253-pit-move-label-strip`, the branch of draft #1975, because the plan says batch 10 runs before 11 and both change `LinkService.TextClashTidyUp.cs`):**
   1. **#1977** `claude/b125-n11-bug873-tidy-start-writes-after-yes`, switch `linking.tidyLabelsWritesNothingUntilYes`.
   2. **#1978** `claude/b125-n11-bug890-leaderout-plain-labels-stay`, switch `linking.tidyLeaderOutKeepsPlainLabelsPut`.
   3. **#1979** `claude/b125-n11-bug891-tidy-scan-own-space-and-reach`, switch `linking.tidyScanCoversOwnSpaceAndFullReach`.
   4. **#1980** `claude/b125-n11-bug962-tidy-scan-window-index`, switch `linking.tidyScanUsesWindowIndex`.
2. **Independent of each other:** all four branch from the same #1975 head, so they merge in any order; the only overlaps are additive lines in `UserSettings.cs` and `REGRESSION_LOG.md` and one call site in `LinkService.TextClashTidyUp.cs` (keep both sides). Each has its own new test file (`B125N11*Tests.cs`); none edits `C75NewSwitchDefaultsTests` (the new-switch-defaults pin lives inside each new test file, through both start-up reads).
3. **All four faults were confirmed to exist on the Civil 3.0.88 line** (file and line below). None was already fixed, none needed a window change, a decision or a design card.
4. **Shared files:** `UserSettings.cs` (one new switch per PR), `REGRESSION_LOG.md` (one entry per PR), `LinkService.TextClashTidyUp.cs` (873: none; 890, 891, 962: small edits). **CE_SHARED unchanged. `CeCommandBase.cs` unchanged** (873 was fixed in the command, so no other command is touched and no separate Opus review of the base class is needed). No Settings-engine or loader change, so no N91 tag. Windows: none.
5. **Tests (focused classes only, never the full suite, never Manager; `-m:2`, one project, one `--filter`, below-normal priority, AutoCAD 2027 on PATH):** every run showed a non-zero test count on both net48 and net10. The net48 test build also proves the net48 compile of the Drainage project.
   1. 873: 111 passed, 3 skipped (the existing ignores), 0 failed.
   2. 890: 35 passed, 0 failed.
   3. 891: 108 passed, 0 failed.
   4. 962: 71 passed, 0 failed.
6. **Full suite NOT run:** the job brief said both "full suite once at the end" and "focused classes only, never the full suite"; I followed the later, stricter line. The wider Drainage suite has not been run on these four branches.
7. **One existing assertion changed (873):** `C60AuditSourcePinGuardTests.KnownDefectQuarantines_StillIdentifyTheirExactSourceSites` pinned the old start-up helper by name (`InitServices(`); with the fix the writes sit in the switch-OFF branch, so it now pins `MarkDrawingActive(` there. The ignored test beside it (`TidyLabelsPreview_ReachesTheYesQuestionWithoutWritingInitialisation`) stays ignored, because the switch-OFF branch still contains the writes by design.

## Per bug: cause, fix, what is NOT proven

1. **BUG-873 (#1977).**
   1. **Cause:** `Modules/Drainage/Commands/TidyLabelsCommand.cs` line 35 (before the change) called `InitServices(doc)`, which calls `ProjectDataService.MarkDrawingActive` and `SetDrawingPath` (that one saves the record: `ProjectDataService.Mutations.cs` 151 to 190, `Persistence.cs` 903) before the REFEDIT check, switch check, pick, count and Yes/No.
   2. **Fix:** with the switch ON the command calls `InitServicesCore()` (logging, settings, theme: no drawing write), reads the switch, and binds CE's in-memory record with `ProjectDataService.BindToDrawingWithoutSaving` (the existing no-write bind that CD, CDDEST and PITSCHEDULE use; the preview reads pipe records, so the record must still be this drawing's). The two writes run after Yes, before `SuspendRuntimeLinking`. OFF = the old two calls at the start, none after Yes.
   3. **Not proven:** that the drawing's change count (DBMOD) really stays put after No in AutoCAD. The preview pass itself still opens a normal transaction that commits with no change (the ignored test `TidyCountPass_UsesNoNormalTransaction`, BUG-863 area): whether that alone bumps DBMOD is not known from the source. If the robot case below still sees DBMOD move with the fix, that transaction is the next suspect, and it is a separate change.
2. **BUG-890 (#1978).**
   1. **Cause:** `Rules/TidyLeaderOutRule.cs` `Rescue`, stage 2: every crowded label that found a clear space further out had that space recorded as its new place for the labels planned after it. A plain text is only listed afterwards (`SplitByLeaderSupport`, CE draws no new leader), so it never moves; its real place was treated as free and a later callout could be sent onto it. (The bug entry's lines 426 to 437 are `PlanWithLeaderOut`; the recording is at `TidyLeaderOutRule.cs` around line 120.)
   2. **Fix:** `Rescue` takes the set of labels that really move out (the callouts) and records a new place only for those; the plain text's clear space is still found and still reported as before.
   3. **Not proven:** real drawing; needs `linking.tidyLeaderOut` true (it is OFF by default).
3. **BUG-891 (#1979).**
   1. **Cause:** `Services/LinkService.TextClashTidyUp.cs` `ScanNearby` always opened `BlockTableRecord.ModelSpace`; the search area was the pipe plus the fixed `TidyUpSearchMarginMm` (lines 28, 584 to 623 before the change) whatever the leader-out distance.
   2. **Fix:** the scan opens the common owner space of the pass's pipes (model space for model pipes: no change); two spaces or no pipes fall back to the old scan. With leader-out on, the margin is never below the Settings leader-out distance (converted to drawing units); it never shrinks.
   3. **Not changed:** `TidyPitText.cs` (pit cover level text) and `CollectTextBoxesNear` (live words) still scan model space; they were not in the entry.
   4. **Not proven:** a layout pipe in a real drawing. Whether CE pipes can sit in a layout on a colleague's drawing is not recorded here; the Tidy labels pick already filters by the current layout, so the code path exists.
4. **BUG-962 (#1980).**
   1. **Cause:** `ScanNearby` called `windows.Any(...)` (every pipe's area) twice per object in model space: 9,000 x 500 = 4.5 million tests.
   2. **Fix:** a grid index over the areas (`Rules/TidyWindowIndex.cs`); same answer as the old test, checked on 20,000 random boxes and edge-touching boxes.
   3. **Not changed, said plainly:** the Yes pass still scans again (the drawing could have changed between the question and the answer); the per-pipe filter over the scanned texts is unchanged. If a large drawing is still slow after this, those two are the next places. The real time saved is NOT measured.

## Robot cases (named in the N31_dp_time / C31 style; each has a switch-off control)

Each needs a copy of a CE drawing; settings set before launch (the guard is read at AutoCAD start).

1. **N11_tidy_no_write (proves 873; control C11_tidy_no_write):** open a copy of a CE drawing that has pipes and has never had Tidy labels run, with `linking.tidyLabelsWritesNothingUntilYes` left ON and `linking.tidyLabelsEnabled` true. Read `DBMOD`, type `CDTIDYLABELS`, answer `All`, answer `No` at "Move these labels now?", read `DBMOD` again. Right: `DBMOD` is the same before and after and the CE log has no "Project data switched to" save line for this drawing. Control: set the switch false before launch; the same keystrokes give a changed `DBMOD`. Also a second variant that presses Esc at the Yes question.
2. **N11_tidy_leaderout_plain (proves 890; control C11_tidy_leaderout_plain):** needs `linking.tidyLeaderOut` true. A crowded pit group with one callout and one plain text on the same pipe, the plain text half under a fixed text. Type `CDTIDYLABELS`, `All`, `Yes`. Check the callout's final text box against the plain text's box. Right: no overlap. Control: `linking.tidyLeaderOutKeepsPlainLabelsPut` false gives the callout on the plain text.
3. **N11_tidy_layout_space (proves 891; control C11_tidy_layout_space):** a pipe drawn in a layout with a text in model space at the same coordinates as one of its invert texts. Type `CDTIDYLABELS` in that layout, `All`, `Yes`. Right: the invert text is not moved for the model text. Control: `linking.tidyScanCoversOwnSpaceAndFullReach` false moves it.
4. **N11_tidy_time (proves 962; control C11_tidy_time):** a large copy (thousands of texts, hundreds of pipes). Type `CDTIDYLABELS`, `All`, `No`; read the CE log line `[PERF] CDTIDYLABELS count: N ms for M picked pipe(s)`. Right: the same "will move" count as the control and a smaller N. Control: `linking.tidyScanUsesWindowIndex` false gives the same moves and the longer time.

## Questions for CE 05 / CE 04

None. No bug needed Tim's word, a design card or a window change.

## Real-folder listings (RULE: before the first test and after the last)

Listed (names, sizes, last-write; no contents) for `%APPDATA%\TIM_CE_CADTOOLS` (including `CE_Admin\outbox` and `logs`), `CE_STRUC_SUITE`, `CE_CVL_SUITE`, `CE_CADTOOLS` (including `CE_Admin`) and `CE_SUITE`. The two full listings are 33,690 and 33,831 lines and were kept in the scratch folder, which is removed with this job; the compared result is below.

1. **Before the first test:** 33,690 files, listed at about 00:25.
2. **After the last test:** 33,831 files (141 more).
3. **Difference:** 161 new or changed, 20 changed-from. By group: 139 new files in `TIM_CE_CADTOOLS\CE_Admin\outbox\usage`, 2 in `outbox\failures`; changed: `TIM_CE_CADTOOLS\CD_Settings.json`, `CD_RecentValues.json`, `CE_Admin\sessions\CE_CVL_SUITE.json`, `CE_Admin\sessions\CE_STRUC_SUITE.json`, the two `outbox\machines` files, `CE_CADTOOLS\CE_Admin\manager-menu-state.json`, `TIM_CE_CADTOOLS\logs\ce_struc_structured_*.log`, `CE_STRUC_SUITE\logs\*` (log, runtime snapshot), `CE_CVL_SUITE\telemetry\outbox.jsonl`, `CE_CVL_SUITE\logs\*`, `CE_CVL_SUITE\ledger\suggestions.jsonl`.
4. **Conclusion:** see FOR TIM item 4. Not from my runs (evidence listed there); the one file I cannot clear beyond that evidence is `CD_Settings.json`.

## Housekeeping

1. **C: free space:** 45.7 GB at the start; 22 GB during the wait (not caused by me); 57.7 GB just before cleanup and 58.4 GB after it. My worktree cleanup moved 0.63 GB.
2. **Cleaned:** `git clean -fdXq` in `C:\CE_WORK\build\n11`, then `git worktree remove` (path gone); scratch `C:\CE_WORK\scratch\n11` removed after this report was pushed. The four branches are kept (local and origin); nothing was closed, retargeted, merged, force-pushed or deleted.
3. **Not touched:** `BUG_CARPARK.md`, `DESK_LOG.md`, Tim's settings files, installed bundles, ProgramData. No AutoCAD, Codex or accoreconsole was started by me. The 0-byte `CE_TRANSFORM_2027.arx` placeholder was created inside my worktree only (gone with it).
4. **The B-008 draft #1847 (Tidy labels switch ON by default) is still open;** while it is not merged these four fixes only matter to someone who has switched Tidy labels on.
