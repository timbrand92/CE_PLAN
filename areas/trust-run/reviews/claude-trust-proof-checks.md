# Review: draft PR 2050, `claude/trust-proof-checks` (four checks for the headless proof, trust plan steps 1, 5 and 6)

**Reviewer:** lane trust-review (seventh run), Fri 13 Nov 2026, 02:12 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** PR 2050's description; its one commit `c24af34e` (5 files: `Modules\Drainage.HeadlessProof\TrustChecks.cs` new, `ProofCommands.cs`, the project file, `tools\headless-proof\README.md`, `REGRESSION_LOG.md`); the step 5 door it calls (`ProjectDataService.ReadOnlyTools.cs`); the harness runner `Run-HeadlessProof.ps1`; `EVIDENCE_BRANCHES.md`.

---

# FOR TIM

1. **What it is:** four automatic checks, run in AutoCAD's background console on a made-up drawing, meant to prove steps 1, 5 and 6 without installing anything. Test tooling only; it changes nothing in the plugin and has not been run yet.
2. **It weakens nothing:** no existing check is changed or removed.
3. **But half of each check cannot fail:** the "drawing changed" test it relies on stays the same once the drawing has any unsaved change, and the checks make changes first; and no check has a deliberately broken version to show it would catch a write.

**Verdict: FIX FIRST** (three items in section 2). Built yes (proof project compiles, by its lane). Tested: not run (the core console cannot start while the full AutoCAD is open). Installed no (never installed; test tooling). Accepted no.

---

## 1. What the brief asked, answered

1. **What it is.** Four new checks in the repo's existing headless harness: TRUST-OPEN-01 (step 1's check changes nothing and counts one extra pipe-layer line), TRUST-READONLY-01 (step 5's door for CDGRAPH, CDDIAG, CDDASHBOARD changes nothing when the record is behind), TRUST-UPDATE-01 (step 5's count equals the real difference in CE's record), TRUST-UNKNOWN-01 (step 6: a line with no size gives 100 and UPVC with the switch off, blank with it on). CE's stored record is read straight from the drawing's own dictionary, never through a CE tool (`TrustChecks.cs` 297-320): good.
2. **Does it weaken or replace an existing test? NO.** One new file; four entries added to the check list, placed before C7-HOLD-01, which its comment says must stay last (`ProofCommands.cs` 54-61); four new commands; one project line. No existing check edited or deleted.
3. **Would the checks really catch a write? Only in part:**
   1. A write to CE's stored record in the drawing: YES, all four compare the stored text before and after.
   2. A change to CE's record in memory only: TRUST-READONLY-01 catches a change in the number of pipes, not a changed value; TRUST-OPEN-01 does not look at memory at all.
   3. Any other drawing write (a layer, a block, a pit symbol): NO. The only general detector is AutoCAD's DBMOD, and it cannot move here (section 2, item 1).
4. **Settings safety:** TRUST-UNKNOWN-01 turns "Show Unknown" on in memory and puts it back in a `finally` (`TrustChecks.cs` 211-243); nothing in it saves Settings. The harness already hashes the live CE settings file before and after a run (`Run-HeadlessProof.ps1` 218-221).

## 2. FIX FIRST

1. **The "changed counter" half of every check can never fail.** DBMOD is a set of flags (AutoCAD's documented values: 1 objects changed, 4 drawing settings changed, 8 window, 16 view, 32 fields), not a count. Every check draws first: `PipeChecks.DrawPipeForCheck`, then `BringRecordUpToDate` (which runs CE's full record update and writes the record), then the check's own plain line (`TrustChecks.cs` 48-61, 102-106, 143-149, 202-203). So the "objects changed" flag is already set before each "before" reading, and a write during the call leaves DBMOD exactly as it was. The PASS words "changed neither the drawing ..." therefore overclaim. Fix: count AutoCAD's own object events during the call (the database's object-modified, object-appended and object-erased events), or compare a fingerprint of every object, as the 12 Nov probe did (`TRUST_PROBES_13NOV.md` section 0 item 3).
2. **No broken twin.** Each check calls code that only exists on steps 1, 5 and 6 (`ReadForOpenLine`, `PrepareRecordForReadOnlyTool`, `LastRecordUpdate`, the trust settings). On the installed build they come out BLOCKED, not FAIL, so no run can show that a check fails when the plugin writes. Fix, cheap: TRUST-READONLY-01 run again with "Tools that only read never update the record" set OFF in memory must FAIL (the old update adds the line: pipes 1 to 2); TRUST-OPEN-01 with `SyncWithDrawing` called in place of the read must FAIL. Both inside the check, switch put back in `finally`.
3. **CE's record in memory is not compared properly.** TRUST-OPEN-01 never reads it; TRUST-READONLY-01 compares only the pipe count (`TrustChecks.cs` 113-117, 125), so a value filled into an existing pipe (the 100 and UPVC case) would pass. Fix: compare the whole record in memory as text before and after (the same serialiser CE uses to store it).

## 3. Worth knowing (not blocking once section 2 is done)

1. **The checks start from a record already attached and up to date** (`BringRecordUpToDate`, 251-255). The old code wrote on the first read-only tool after a drawing opened, when the record was not yet attached; that state is not covered here. The real-command run in `EVIDENCE_BRANCHES.md` (item 1, CDGRAPH and CDDIAG on a fresh open) covers it; keep both.
2. **TRUST-READONLY-01 drives one of the door's four old modes** (`AttachAndUpdateIfChanged`, the CDDIAG and dashboard one); CDGRAPH uses `MarkAttachAndFullUpdate`. With the switch ON the door returns before the mode matters (`ProjectDataService.ReadOnlyTools.cs` 42-53), so this is fine, but the README sentence "the door CDGRAPH, CDDIAG and CDDASHBOARD now use" should say so. The twin in item 2.2 should use `MarkAttachAndFullUpdate`, the mode that wrote in the probes.
3. **The harness reads the live settings file** (`%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`). If Tim's file ever has a trust switch saved OFF, TRUST-READONLY-01 fails, correctly but confusingly. Print the switch's value in the check's detail line.
4. **Stacked on step 6 at `68032c9b`;** step 6 moved to `e7b9ccdc` at 01:49. TRUST-UNKNOWN-01's expectations still hold at the new head by reading (the record update's size rule is unchanged in outcome), but build the checks on the new head before running.
5. **No client name, job number, street or suburb** in the diff.

## 4. Not checked

1. Not built, not run (by me or anyone): whether the harness finds these methods by reflection on the real build, whether DBMOD behaves in the core console as documented.
2. `PipeChecks.DrawPipeForCheck` itself (existing harness code, not in this diff).
