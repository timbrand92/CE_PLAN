# Independent Opus review B: Max build C and Team FB-06 / FB-07 draft PRs (23 Oct 2026, late evening, Melbourne)

Reviewer: Opus 5.5 (claude-opus-5-5), independent of the builders. Base for every PR: `origin/claude/rel-20261023m` @ `f7f7d551` (C-62, Civil 3.0.72 / Manager 1.1.72), re-fetched for this review; every PR branches straight from it (one commit each). I read the code, not the PR text. My one read-only worktree was `C:\ce-rv3\m7` (removed at the end). Nothing deployed, AutoCAD not started, no PR or branch closed, deleted or pushed to, Tim's settings and installed bundles not touched.

## ANSWER FIRST

1. **Verdicts, 7 PRs:** MERGE 5, MERGE-WITH-FIXES 2, HOLD 0, REJECT 0. All 7 belong on train **C-63 (Civil/Manager)**.
2. **Top 3 faults:**
   1. **#1692 (CDNEWDWG) does not cover the folder the window opens on.** The fix re-reads a record only after the folder text CHANGES. The starting folder (the job of the drawing you are in, the commonest case) is still read once by the command with the old "failed read = no record" reader, so a locked or still-downloading `CE_JobRecord.json` there still gives blank REF NO, the preview says "no job record exists yet", and "change the sheet size to read it again" does nothing. Small fix below.
   2. **#1682 (Edit Pit rename) gives up on every pipe if one pipe note is damaged, and tells only the log.** The pipe-note loop sits inside one try: one unreadable note stops the whole rewrite, the transaction is dropped, and the drafter sees nothing on the command line, so the BUG-664 jump can still happen. Small fix below.
   3. **The new pipe-note rename lives only in Edit Pit (design rule 1).** CDRENUMBER and the record's "same pit, new number" route (`ProjectDataService.AddPit` by handle) also rename pits in the pipe records and still leave the pipes' own notes on the old number. Not a reason to hold #1682; log it as the follow-up that makes `LinkService.RenameExplicitPitOwnership` the one route.
3. **Safe to merge today (any order; keep both sides of every `REGRESSION_LOG.md` clash):** #1676, #1687, #1689, #1694, #1688 now; #1692 and #1682 once their two small fixes are in (or merge now and land the fixes as a follow-up before Codex tests them). Each one is still "built and unit-tested"; none has been opened in AutoCAD.
4. **My one build:** all 7 merged into one tree on the base (code files joined with no conflict; only `REGRESSION_LOG.md` clashed), then the Civil net10 test project built once (Debug, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, C: had 15 GB free) and the touched areas run: **396 of 396 passed** (double-click, Blue Factor and STORM report, CDCALC detention, CDNEWDWG, Edit Pit, inline split, paired-pipe split, plan-edit words). The 60 new tests alone, re-run without rebuilding: **60 of 60 passed**. The Manager project was not built.

## Per PR

1. **#1676, BUG-859 follow-up: a downpipe inside a border, title block or Xref plan opens on double-click (fb/max-c-dp-dblclick @ dee2744f). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes. On the base, `DoubleClickHitTest.Decide` counted every visible block whose outline rectangle holds the pointer, so a sheet border or Xref plan around DP1 made it "2 blocks, ambiguous" and AutoCAD's attribute editor ran instead of the Edit source window.
   2. **Does only what it says?** Yes. One pure rule (`TryPickTaggedBlockInsideBackground`) runs only when more than one block is under the pointer: exactly one CE-tagged block, every other block untagged, not a pit, and strictly outside it on all four sides. Otherwise it stays ambiguous. 13 new tests; I checked by reading that 6 of them must fail on the base (they expect "one block" or "protected" where the base answers "ambiguous").
   3. **Xref / REFEDIT / locked layers:** nothing bypassed. The pointer hunt still runs only for the attribute editor started by a double-click with nothing picked (`CompoundEditModeService` line ~314), so a double-click on the Xref itself (REFEDIT) never reaches it. An Xref is only ever the "background"; a downpipe that is itself Xref content is still answered "protected" (the narrowed answer goes through the same Xref check). The hunt is read-only (open-close read transaction, nothing written or selected), so redo safety is unchanged.
   4. **Risk (low):** a title block that has attributes and a drawn line passing inside the downpipe's little rectangle: a double-click on that line near DP1 would open DP1's Edit source window instead of the title block's attribute editor. Rare, and it opens a window, it writes nothing.
   5. **No new switch** (sits under the existing Edit source switch, ON), no hard-coded engineering value, no CE_SHARED.

2. **#1687, BUG-967 follow-up: Blue Factor warns when the listed areas exceed the site; a garden-and-lawn-only report is no longer skipped (fb/max-c-bluefactor @ ddb583d9). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes, both halves. `AddNotes` only had the "less than the site" note, and `HasAnything` ignored garden and lawn (they never enter the roof-and-paved rows), so `StormReportReader.TryReports` skipped the newest report and offered an older one's roof figure.
   2. **Does only what it says?** Yes. A new `PerviousListedM2` figure feeds `HasAnything` and the new "more than the site" note. I followed it through: with no roof or paved rows the offer still gives "Roof and paved area" as no figure (`StormReportOffer.Build` uses NaN when there are no rows), so a garden-only report never puts 0 m2 into CDDESIGN. Warning only, no block.
   3. **Risk (cosmetic):** the "more than the site" note fires for any excess, even 0.1 m2 from rounding in the report. Acceptable as a warning; a tolerance would be a Settings value, not worth one now.
   4. **No new switch, no hard-coded engineering value, no CE_SHARED.**

3. **#1689, BUG-1019 follow-up: CDCALC no longer reads an older trench grate's 0.000 cover as a real level (fb/max-c-cdcalc-cover @ 324bec7c). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes. `DetentionSystemViewModel` set `CoverLevelKnown = IsRecordedLevel(pit.CoverLevel)`, which accepts the "0.000" placeholder an older CDTG stored when the cover prompt was skipped.
   2. **Does only what it says?** Yes, one line: it now uses `PitData.KnownCoverLevelRl()`, the reader every other cover check already uses (BUG-432), so this is design rule 1 (one reader) as well. A real 0.000 or a negative level on any other pit still counts. The placeholder test must fail on the base (base answers "known").
   3. **Tiny difference:** the old reader also tried the Windows number format; the shared one reads the invariant format only. On an Australian Windows both read "12.345" the same; no effect here.

4. **#1692, BUG-969 follow-up: CDNEWDWG re-reads a job record after a failed read (fb/max-c-newdwg @ 3fb83e9d). Verdict: MERGE-WITH-FIXES. Train C-63.**
   1. **Cause real?** Yes. `JobRecordService.Load` (CE_SHARED) turns any failed read into a blank record, and `NewJobDrawingRecordSource` remembered that blank for the folder and never read it again.
   2. **Does only what it says?** Yes for a CHANGED folder. It uses the existing `JobRecordService.TryLoad` and `Exists` (CE_SHARED read only, not changed), keeps a failed read un-remembered, and shows a plain preview line. Half-typed folder text is still "no record".
   3. **Fault (fault 1):** the starting folder is not covered. `NewJobDrawingCommand` (line ~54) still loads it with `JobRecordService.Load`, and the record source treats it as already loaded, so a failed read there is cached exactly as before and the new preview line never shows.
   4. **Exact small fix:** in `NewJobDrawingCommand`, pass `JobRecordService.TryLoad(guessedJobFolder, out JobRecord r) ? r : null`; in the `NewJobDrawingRecordSource` constructor, when `initialRecord` is null leave `_loadedFolder` null so the first `RecordFor` reads (and flags) it. Add one test: initial record null plus a locked file gives `LastReadFailed` true, then reads after release.
   5. **Minor risks:** a failed read is retried on every preview refresh (every keystroke in the file-name box). On a locked file that is instant; on a OneDrive file that will not download it may make the window sluggish. And Create with a failed read still makes the sheet with blank details (the preview says so); one command-line line on Create would make that visible. Neither blocks.

5. **#1694, BUG-1028 follow-up: CEMANAGERLOGS also opens the Manager's own log folder (fb/max-c-mgrlogs @ c9585bc8). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes. The Manager writes its warnings' detail to `%LOCALAPPDATA%\CE_SUITE_MANAGER\crash_trace.log` (`CeAdminTelemetryService.TraceLogPath`), and `LogFoldersToOpen` listed only Civil's (and Structural's) folders.
   2. **Does only what it says?** Yes. The Manager folder is added last, never twice, and the test redirect still wins alone. The folder lookup is wrapped so a failure still opens Civil's folder.
   3. **CE_SHARED:** not touched. Only `Modules/Manager/Services/CeSupportBundleService.cs` and a Manager test file change, so Civil and Manager stay byte-identical on CE_SHARED. Installer and signed-update gate not touched. The new tests are pure (no real folders opened).

6. **#1682, FB-06 BUG-664: Edit Pit rename also renames the pipes' own notes, one Undo step (fb/fb06-pit-rename-pipe-notes @ bc3e3817). Verdict: MERGE-WITH-FIXES. Train C-63.**
   1. **Cause real?** Yes. `PitEditCommand.RenamePitInPipes` renames From/To in the project record only; each pipe's own note (`ExplicitFromPitId` / `ExplicitToPitId`) keeps the old number, and the relink reads that note first.
   2. **Does only what it says?** Yes. A new writer (`LinkService.RenameExplicitPitOwnership`) rewrites only notes that name the old pit, and only on pipes `IsSpineWritable` allows (locked layer, Xref, overlay and REFEDIT all refused, nothing unlocked); protected pipes are counted and named in one command-line line.
   3. **Redo safety (checked):** the write runs inside PITEDIT itself (a modal command), after the window has closed, in its own transaction that commits before the command ends, with the passive link reactor already suspended by Edit Pit (`SuspendRuntimeLinking`), so it does not trigger a second writer. One U takes the pit, label, record and notes back together; nothing writes between U and REDO. The note writer queues only an in-memory cache refresh for command end. The dry-run preview that also calls `ApplyPitEdit` (`DryRunPitEdit`) has no caller in this tree (I searched the whole repo); if it is revived, its outer transaction is aborted so the notes would not reach the drawing (only the locked-pipe line would print).
   4. **Fault (fault 2), exact small fix:** in `RenameExplicitPitOwnership`, put a try/catch round each pipe's read and write (skip and count a pipe whose note will not read), so one damaged note cannot stop the rest; and in `RenamePitInPipeNotes`'s catch, also print one plain line, for example "[CE] The pipes' own pit names could not be updated; run CDREPAIR before placing a new pit with the old number."
   5. **Other risks:** (a) if the later "project record" step fails, the record goes back to the old number but the notes (like the pit label already did) stay renamed until U; old behaviour class, rare. (b) Design rule 1 follow-up (fault 3). (c) The writer itself has no unit test (it needs a drawing); the Codex FX-06 check covers it. No new switch (bug fix), no hard block, no CE_SHARED.

7. **#1688, FB-07 BUG-692 and BUG-693: a callout goes with the half its arrow points at; a curved pipe is left whole with one plain line (fb/fb07-inline-split-callout-curve @ 69451402). Verdict: MERGE. Train C-63.**
   1. **Cause real?** Yes. The inline split measured a callout from `GetEntityPosition` (an MLeader's text point), and both halves were rebuilt from points only; no bulge was read anywhere on that route.
   2. **Does only what it says?** Yes. The arrow point (the first point of the callout's leader line, the arrowhead) decides the half; without an arrow the old text-position rule stands. A pipe with any arc segment is refused in `TrySplitPipeAtCandidate` BEFORE the first write, exactly where the BUG-691 paired-pipe refusal already sits, and `PlanEditWordsRule.AutoSplitLine` prints "[CE] The pit was placed. The pipe under it has a curved segment, so CE did not split it. Split it by hand if needed." Warn and carry on; no new hard block.
   3. **Redo safety:** the refusal writes nothing; the callout change only picks which half a callout joins inside the existing split transaction.
   4. **Risks (low):** an arrow exactly at drawing 0,0 is treated as "no arrow" (old rule); older callouts that are plain text plus a separate leader still go by text. No switch (bug fix, so ON is right).

## Merge-order notes

1. No code file is touched by two of these seven PRs. Across this batch and review A's eight, the only shared code file is `Modules/Drainage/Services/LinkService.Split.cs` (#1688 and #1659); git joins them cleanly (I test-merged the pair), and they do not interact: #1688 refuses curved pipes before any write and #1659 moves decisions after the split is made.
2. `REGRESSION_LOG.md` clashes on every pair. Keep both entries each time.
3. None touch CE_SHARED, the installer or the signed-update gate. None adds a setting, so there is no Settings-page row to add.

## What I did NOT check

1. Nothing was opened in AutoCAD. Every PR is built and unit-tested only; none is Codex-accepted or Tim-accepted.
2. I did not rebuild each PR on its base with the fix removed; "fails without the fix" is from reading each test against the base code, plus the builders' red-first counts.
3. My one build was net10 Civil tests only, on a filter of the touched areas, in Debug. net48 and net8 were not built by me; the Manager test project was not run (#1694 relies on the builder's 938-test run; I read its six tests, which are pure).
4. I did not look at any window picture (only #1692's preview text changes) and did not check the CDNEWDWG window with a real OneDrive placeholder.
5. I did not re-review review A's eight PRs; only their file overlap with this batch.
