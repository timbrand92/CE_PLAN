# Independent review: pilot-critical batch 1 PRs (Sat 24 Oct 2026)

Reviewer: Opus 5.5, independent (did not build these). Base `origin/claude/rel-20261024m` at `5467f705` (installed Civil 3.0.73 / Manager 1.1.73). Each PR read at its head commit, not from its text. Batches 2 and 3: no report existed at 13:52; both appeared later and were already reviewed by sibling reviewers (ANSWER FIRST item 6), so they are NOT reviewed again here.

## ANSWER FIRST

1. **Counts:** MERGE 4, MERGE-WITH-FIXES 1, HOLD 0, REJECT 0 (five PRs).
2. **Safe to merge today into C-64:** #1747 (BUG-1135), #1750 (BUG-1206), #1751 (BUG-1165), #1754 (BUG-1167). #1748 (BUG-1138) after one wording change (item 2 below), about five minutes of work.
3. **Top faults found:**
   - **#1748 wording:** after a pit MOVE on a PC without the CE pipe add-on, the line says "nothing was changed" and "Run it on a PC with...". The pit DID move, and the drafter ran MOVE, not a relink. Fix the sentence (exact text in item 2).
   - **#1747 limit, not a fault:** only the top level of the job record keeps unknown parts. A newer field added INSIDE raingardens, slabs, rulebook, review approvals and so on would still be dropped by this build (pits and pipes were already safe).
   - **#1747 side effect on older builds:** 3.0.73 and older now see "2.3" and (a) print their existing "saved by a newer version" warning, and (b) their Pit Schedule refuses a CE XREF saved by this build ("requires a newer CE Civil plugin"). Harmless if every PC gets the same build, which is the colleague plan.
   - **Report claims corrected (RULES 6.2):** the BUG-1165 report says 9 new tests; there are 7 (5 plain + 2 cases). Everything else in the batch 1 report checked out.
4. **Protected files:** CE_SHARED, Installer, signing and deploy scripts are untouched by all five (checked on the combined tree).
5. **Already in C-64 (checked at the end, 15:45):** the C-64 branch `claude/rel-20261024n` (`f73755ee`) already holds #1747, #1750, #1751 and #1754 at exactly the heads reviewed here; #1748 is not in it. That matches these verdicts. #1748 can join C-64 once its one-line wording fix is pushed and re-read, or ride C-65.
6. **Batches 2 and 3:** their reports appeared while this review ran, and both already have independent reviews by sibling reviewers: `REVIEW_PILOT_CRITICAL_B2_24OCT.md` (batch 2: MERGE 5, MERGE-WITH-FIXES 1, train C-65) and `REVIEW_PILOT_CRITICAL_B2B3_24OCT.md` (batch 3: MERGE 5, train C-65). I did not review them again, to save usage.
7. **Conflicts:** the five PRs conflict with each other ONLY in `REGRESSION_LOG.md` (keep both sides). Against the C-64 candidates checked (28 open PRs on the 23l/23m/24m trains that touch the same files), none of the five adds a conflict of its own.

## Checks I ran

1. **Combined tree:** base + all five PRs merged locally (REGRESSION_LOG conflict resolved by keeping one side; build only, never pushed) in `C:\ce-rv5\m`.
2. **One build:** Civil tests, net10, `-p:SkipDevBundle=true -nr:false --disable-build-servers`; 0 errors. (First attempt stopped at the copy of the native `CE_TRANSFORM_2027.arx`, which a fresh worktree does not have; an empty stand-in file in my own worktree let the same build finish. No bundle written, nothing deployed.)
3. **Targeted tests:** 310 of 310 pass (the five new test files, 32 tests, plus the job-record freeze, quiet-record, endpoint planner, pit-block plan, held-back labels, rainfall storage, ProjectDataService, SettingsService and Pit Schedule Xref fixtures).
4. **Full Civil run on the combined tree:** 19,838 total, 19,814 passed, 22 skipped, 2 failed. Both failures are in `SourceAtomicCoordinatorDependencyTests`, which read the compiled instructions and say in their own comment they expect a Release build; my one build was the default Debug build. No PR touches that code. Not caused by these PRs, but I did not rerun them in Release (one-build limit).

## One item per PR

1. **#1747 BUG-1135 (HIGH, data loss): older CE no longer deletes newer job data. Verdict MERGE. Train C-64.**
   - **Cause is real:** on the base, the job record had no catch-all for parts it did not know, and every save stamped the version marker back to "2.2" (`ProjectDataService.Mutations.cs` NormalizeProjectData). So a parts list written by a newer CE (ignored findings, paused features, review approvals, held-back labels) vanished silently when an older CE saved.
   - **The fix does only that:** a catch-all on the job record that writes unknown parts back unchanged; the marker is never lowered (a "9.4" record stays "9.4"; an older or blank one is raised to 2.3); the redesign apply copy keeps the catch-all too. The two "2.2" constants are now one.
   - **Every reader and writer of the marker checked:** load (warns if newer, then keeps the higher marker), the clone used on load (`CloneForApply`, now carries the catch-all), the redesign freeze, the empty-record path, the AI-access and rulebook direct writers (they edit the stored text in place, so unknown parts and the marker survive), the Pit Schedule XREF reader (refuses only a HIGHER marker), the "is this record empty" check (an empty catch-all counts as empty, a filled one as content, so a quiet drawing still writes no empty record). Nothing lowers the marker in this build.
   - **Tests:** 4 of the 5 new tests fail on the base (correct red); the freeze test that walks every field now forces the catch-all to be copied.
   - **Redo, locked layers, Xrefs:** no new drawing writes; nothing between U and REDO. No switch (a storage format fix, not a behaviour; correct).
   - **Limits to tell Tim:** builds already installed (3.0.73 and older) still drop and lower; nested parts other than pits and pipes still drop unknown sub-fields; older builds will refuse to schedule a CE XREF saved by this build. Any later PR that adds a job-record field must raise the marker again (the comment beside the constant says so).

2. **#1748 BUG-1138 (MEDIUM, data loss): CDSYNC and relinks stop on a PC that cannot read CE pipe objects. Verdict MERGE-WITH-FIXES. Train C-64.**
   - **Cause is real:** CE pipe objects are built on a polyline and are read only where the 2027 add-on (`CE_CVL_OBJECTS_2027.dbx`, 2027 lane only in `PackageContents.xml`) is loaded. Elsewhere AutoCAD holds them as proxy objects. CDSYNC cleared every pit's pipe list, then linked back only polylines; the full relink (CDREPAIR, CDUPGRADE, import, pit MOVE fallback) and the scoped pit MOVE relink cleared the lists the same way. Proxies were silently dropped from every pit.
   - **The fix:** each route counts CE pipe proxies in model space BEFORE clearing anything and stops with one plain line. Recognises both the current and the legacy pipe object names. On Tim's 2027 PC there are no proxies, so nothing changes (not a hard block on a normal PC).
   - **Is the stop the right kind:** yes. It protects data, says what happened and what to do, writes nothing, and only fires when this PC genuinely cannot read the pipes. It is not one of the two banned hard blocks: the drafter can still draw, edit and save; only the commands that would wipe the pit lists stop.
   - **Fix needed (one string, `Modules/Drainage/Rules/UnloadedPipeObjectRule.cs` RefusalLine):** for the automatic case the line says "nothing was changed ... Run it on a PC with...". After a MOVE the pit has moved, and the drafter ran MOVE. Keep the CDSYNC line as it is; for `what != "CDSYNC"` end the line with: "Your edit stands; every pit keeps its old pipe list. Run CDSYNC on a PC with the current CE suite on AutoCAD 2027 to relink." The existing test only checks the start of the line, so it still passes.
   - **Tests:** the 3 relink tests read the source order (check before clear) and fail on the base; 10 rule tests on the names and wording. A real proxy cannot be made in a unit test, so the stop itself is unproven until a PC without the add-on opens a drawing.
   - **Not done (as the PR says):** the one-line notice when such a drawing is opened.

3. **#1750 BUG-1206 (MEDIUM): CE Tools tab appears when Manager loads before Civil. Verdict MERGE. Train C-64.**
   - **Cause is real:** `CeUnifiedRibbonService.Initialize` returned before hooking the start-up build when no Civil or Structural tab had registered yet.
   - **The fix:** removes that early return only. Checked the double-tab risk: Civil's own start-up tab and Manager's build use the same tab id (`CE_CVL_SUITE_TAB`) and the builder finds-or-creates the tab and clears its panels before filling, so no second Civil tab and no doubled buttons. This is the same path that already runs when Civil loads first.
   - **Tests:** 2 new source-order tests fail on the base; one older test that pinned the removed return was rewritten to pin "remember AutoCAD's thread before the build is queued", which keeps its original purpose.
   - **Not checked by me:** Manager was not built or tested in this review (one-build limit); the batch report says Manager net10 951 of 952 pass (1 skipped).

4. **#1751 BUG-1165 (MEDIUM): CE blocks come from the running CE copy, not an old all-users copy. Verdict MERGE. Train C-64.**
   - **Cause is real:** the block search looked in ProgramData, then Program Files, before the user's own bundle.
   - **The fix:** the running bundle's own `Contents\Blocks` goes first and is not searched twice; when the switch is off, or the DLL is not running from a bundle, the order is unchanged. The security check on block files (BLK-001) still runs on whatever is found.
   - **Switch:** `pits.blocksFromRunningBundleFirst` starts ON, and a test proves an older settings file with no such line loads it ON. No Settings-page row, like the other bug-fix switches.
   - **Tests:** 7 new (report said 9). They use new members, so they cannot run on the base; one wiring test checks the real block search calls the rule.

5. **#1754 BUG-1167 (MEDIUM): office folders in a copied settings file follow this PC. Verdict MERGE. Train C-64.**
   - **Cause is real:** Tim's settings file holds `C:\Users\TimothyBrand\Creative Engineering\...` for Standard Details, Drawing Templates, Computations and job-time data; a colleague given that file got Tim's folders.
   - **The fix:** at start-up, one of those four folders that sits inside ANOTHER person's profile AND does not exist on this PC moves to the same place in this PC's profile. A folder that exists, one in Public or Default, one outside `C:\Users`, or one in this person's own profile is left alone; never throws; one CE log line per change. On Tim's PC nothing changes.
   - **Switch:** `linking.otherUsersFoldersFollowThisPc`, starts ON, no Settings row.
   - **Limits:** the logo path on computation sheets (`options.brandLogoPath`) is not covered; profiles on a drive other than the one in the file are not matched; whether the office OneDrive folder sits at `C:\Users\<name>\Creative Engineering` on Max's PC is BUG-1166's open question.

## Train

All five go in **C-64**, one install (RULES 8.5); four are already on `claude/rel-20261024n`, #1748 follows after its wording fix (or C-65 if C-64 is sealed). Merge order does not matter; keep both sides of `REGRESSION_LOG.md` each time. The C-64 new-switch defaults test should pin `pits.blocksFromRunningBundleFirst` and `linking.otherUsersFoldersFollowThisPc` ON.

## What I did NOT check (RULES 5.9)

1. Nothing opened in AutoCAD; no PC without the CE pipe add-on, no Manager-first NETLOAD, no second Windows login, no all-users bundle folder.
2. Manager and Structural were not built or tested; net48 was not built.
3. The two skipped batch 1 bugs (BUG-1166, BUG-1169) have no PR and were not reviewed.
4. Batches 2 and 3: not reviewed by me (sibling reviews exist, ANSWER FIRST item 6).
5. C-64 conflict check covered the 28 open PRs on the 22m/23l/23m/24m trains that touch the same files (by merge simulation); semantic clashes with C-64 PRs that add job-record fields were searched for (none add to `ProjectData.cs`) but not exhaustively.
6. Built and unit-tested only. Nobody has seen any of these work in AutoCAD.
