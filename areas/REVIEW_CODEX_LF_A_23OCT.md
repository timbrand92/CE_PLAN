# Review — Codex ledger-fix batches 01 to 04 (23 October 2026, Melbourne)

Independent Opus review of the seven draft PRs from `CODEX_LEDGER_FIX_BATCH01_23OCT.md` to `..._BATCH04_23OCT.md`.
Read-only: no PR, branch, setting or installed bundle was changed. Code was read at the exact commits named below.

## ANSWER FIRST

1. **Verdicts:** MERGE 1 (#1653). MERGE-WITH-FIXES 1 (#1650). HOLD 4 (#1647, #1648, #1649, #1652). REJECT 1 (#1646, documentation only).
2. **Safe to merge today, into C-63 (Civil/Manager):** #1653 and #1650, together, once retargeted. #1650's small wording fix (item 1 below) can come in the same train.
3. **Top fault 1 — #1652 (BUG-887) would stop normal updates.** Manager's "Finish update" installs one bundle at a time. With this PR, installing new Civil is refused while the old Manager is still there (their shared support file differs), and installing new Manager is refused while the old Civil is there. Every release that changes the shared file would be stuck. It is also a new hard block, against the two-block rule (R-27).
4. **Top fault 2 — #1649 (BUG-885) removes the way Civil is built for release.** The C-62 train built Civil with `Installer/build_installer.ps1`. This PR deletes every build step in that script (three program lanes, native grip and object files, blocks, config, installer EXE) and replaces it with a pack-only step. The next train could not build Civil. It also adds a new operation to the release-signing tool and deletes an unrelated safety guard.
5. **Top fault 3 — the batch 03 PRs on GitHub are not what was tested.** Corrected commits for #1647, #1648 and #1649 exist only on the builder's PC, not pushed. Of the four batch 03 PRs, only BUG-886 has a green run (19 of 19 focused tests, at the unpushed head). BUG-884 has only its "before" red run; BUG-885 has no runs; BUG-887 has only a red run its builder says was invalid. The batch 03 report still reads "in progress".
6. **All seven target the wrong base.** They target `claude/rel-20261023l` (Civil 3.0.71). Installed Civil 3.0.72 is `claude/rel-20261023m`, which already contains `23l`. A test merge onto `23m` conflicts only at the top of `REGRESSION_LOG.md` for all seven (the normal train-assembly conflict). No file these PRs change was changed between `23l` and `23m`.

---

## Per PR

1. **#1650 — BUG-875 and BUG-802: ignored Checks warnings come back when what they depend on changes.**
   1. **Head checked:** `6b0a09da` (matches GitHub). Civil only, five files. Nothing in CE_SHARED, the installer or Structural.
   2. **What the drafter will see (only with Ignore switched on, which stays OFF by default):** an ignored pipe-to-pit fit warning returns as "Asked again" when the pit's clear size, base, lid, opening size, a neighbouring opening or any fit clearance on the Settings page changes. An ignored cover warning returns when either end pit's cover level changes. An ignored wrong-layer warning returns when the actual or required layer, or the layer colour, changes. Moving a label or editing remarks leaves it hidden.
   3. **Is the cause real?** Yes, read in the code. The saved fingerprint for a pipe row held the pipe's own record only, not its end pits. So changing a pit cover from RL 10.700 to 10.650 left the hash unchanged and the warning stayed hidden. Fit rows carried no pit sizes or clearances. Wrong-layer rows carried no layer names.
   4. **Does it do only what it says, with a test that fails without it?** Yes. 19 new cases. The builder's red log shows 14 failed and 2 passed on the untouched base (`C:\Temp\cx2-875\red.log`). Green: focused 99 of 99 on both net10 and net48. Full Civil net10 run: 19,448 passed, 0 failed, 22 skipped (log read by me, not rerun).
   5. **Risks checked:** read-only fingerprint maths; no drawing write, Undo or Redo path touched. Fit values come from the Settings page; nothing hard-coded. No new switch. No new block.
   6. **Side effects not mentioned in the PR:** (a) the fit row now records the pit as well as the pipe, so the Checks window's "Show where" now frames both. That helps, but it should be written in the log. (b) Existing ignored pipe, fit and wrong-layer findings will all return once after install, because their old fingerprint lacked these inputs. The PR says so. But an old wrong-layer ignore will return saying "the rule value changed", which is untrue. That happens because the row now carries the required layer as its rule value, and the old saved record has none.
   7. **Verdict: MERGE-WITH-FIXES, train C-63.** Fixes: (1) in `IgnoredChecks.cs` Evaluate, treat a saved record with an empty `ValueUsed` as "changed", not "rule value changed"; one condition. (2) Add one line to the regression entry about "Show where" now framing the pit. (3) Retarget to the C-63 branch and keep both log entries.

2. **#1653 — BUG-889: an "Asked again" finding can be ignored again straight away.**
   1. **Head checked:** `98115e67` (matches GitHub). Civil only, four files.
   2. **What the drafter will see (Ignore switched on):** after a pit changes, CDCHECKIGNORE > Ignore lists the returned finding directly. Before, it had to be Un-ignored first. Choosing a new reason replaces the old one. Findings that have not changed stay out of the list.
   3. **Is the cause real?** Yes. The command excluded every saved key, regardless of whether the finding had come back.
   4. **Test:** four new cases; red 3 failed and 1 passed, green 4 of 4 on net48 and 77 of 77 focused on net10. Full Civil net10 run: 19,433 passed, 0 failed (logs in `C:\cx2\b04logs`, read by me). One caution: the red run was taken with a stand-in helper that copied the old behaviour, not the untouched base. The real old line is plainly the same, so I accept it.
   5. **Risks checked:** the list is read-only. The save still goes through the existing write gate, which runs as its own AutoCAD command, so one U and REDO cover it. No new switch, block or hard-coded value. It works with #1650, which changes the fingerprint this calls; the two PRs touch no common file except the log.
   6. **Small wish, not blocking:** the numbered list does not say which rows are "Asked again". The drafter cannot tell they are replacing an earlier reason.
   7. **Verdict: MERGE, train C-63,** in the same train as #1650.

3. **#1647 — BUG-884: office approvals work on every colleague's PC, not just the one that approved.**
   1. **Head checked:** GitHub `066f8e09`. The builder also has a newer local commit `3a179e73`, not pushed, which only strengthens a test.
   2. **What the drafter will see:** after Tim approves a build, a colleague's Manager finds the same approved build and roll-back build under their own synced OneDrive folder. Before, it looked in Tim's own folder path, which does not exist on their PC, and refused.
   3. **Is the cause real?** Yes. `approved.json` stored full folder paths from the approving PC.
   4. **Code read:** the file is now saved with folder paths relative to the office IT Admin folder. Reading joins them back onto this PC's folder. Both ends use the same root. Fingerprint hashes are unchanged. The installer reads only the version number from this file, so it is unaffected. Paths that leave the office folder are refused. Manager only; CE_SHARED untouched.
   5. **Risk:** an old approval written by another PC with a full path cannot be re-saved; the save fails with "approve this build again". If that happens during the paired put-back step (`CeApprovedReleaseService.cs` around line 147), the put-back fails quietly. Low risk, but say so in the log.
   6. **Evidence gap:** only the red run exists (1 failed of 1). No green run of these six tests and no Manager suite run.
   7. **Verdict: HOLD.** Needed: push `3a179e73`; run the focused tests green, then the Manager suite; then MERGE in C-63. This is a Manager release.

4. **#1648 — BUG-886: the installer cannot be told to accept an out-of-date build, and it warns when it cannot read the office approval.**
   1. **Head checked:** GitHub `76e81d44`. The tested head is `dddd45a6`, three commits ahead, not pushed. The published head is missing the part that saves the "could not check" warning in the install record.
   2. **What the drafter will see:** nothing in normal use. A blank, broken or older `--approved-version=` value no longer gets round the office's approved version. If the office approval file has not synced, the install goes ahead but the result says "CE could not check the office approval for this PC" (warn, not block, per R-27).
   3. **Is the cause real?** Yes. On the base, any caller value, even an empty one, skipped the office floor.
   4. **Risks checked:** no product code passes this value (searched `23m`), so Manager's own update and roll-back are unchanged. The refusal of an older build is the BUG-834 rule Tim approved ("yes", 20 Oct); this PR only closes a loophole in it. New refusal: a malformed version value is refused. That is input checking, not a new engineering block. It changes the installer EXE, so the train must re-sign it.
   5. **Evidence:** 19 of 19 selected installer tests green at `dddd45a6` (`C:\cx2\b03logs\bug886-after.log`). Full Installer suite not run.
   6. **Verdict: HOLD, then MERGE in C-63.** Needed: push `dddd45a6`, and run the Installer suite. Exclude `RetiredRivalDeployRoutes` and `StructuralPreparation`, which run live deploy scripts on Tim's PC.

5. **#1649 — BUG-885: package only the frozen, accepted signed files.**
   1. **Head checked:** GitHub `eee85186` and the unpushed local `ba575541`.
   2. **Cause real?** Yes. The old script rebuilt everything and zipped the fresh build, not the tested one.
   3. **What goes wrong if merged:** `build_installer.ps1` loses all its build steps. The C-62 job (`desk_jobs/payload95_c62_job.txt`) says "build Civil with Installer/build_installer.ps1 unchanged", so C-63 would have no Civil release build. The ledger asked to edit the existing script, but it meant adding a seal step, not removing the build route.
   4. **Other problems:** (a) it adds a `--pack-frozen` operation to the release-signing tool (ReleaseAuthority), which is the signing gate; that needs Opus and release-owner sign-off. (b) It deletes the guard test `RetiredRivalDeployRoutes_ContainOnlyDeterministicHardFail`, which only reads script text. It keeps the guard that actually runs those scripts, the one we exclude on Tim's PC. That is the wrong way round, and out of scope. (c) No test has run at either head.
   5. **What is good:** the new C# packer (`Installer/FrozenCandidatePackaging.cs`) reuses the existing signature gate, holds every file locked while it checks hashes, and never overwrites an earlier archive. Keep it.
   6. **Verdict: HOLD (redesign).** Needed: keep the existing build route and add "seal the accepted candidate" as a second mode of the same script. Restore the deleted guard. Get the release owner's agreement to the new signing-tool operation. Then run tests. Not for C-63 unless that is done first.

6. **#1652 — BUG-887: refuse a Civil/Manager pair whose shared support file differs.**
   1. **Head checked:** `3ce97d64` (matches GitHub; no newer local head).
   2. **Cause real?** Yes. Civil could be activated alone while an older Manager stayed, leaving two different CE_SHARED copies.
   3. **What goes wrong if merged:** Manager's "Finish update" (`CeFinishUpdatePlanner.cs`) runs one `--activate-staged` for one bundle. Civil and Manager must ship the same CE_SHARED, so every coordinated release changes it in both. The first half is refused because the other half is still old, and the second half is refused for the same reason. Updates through Manager would never complete. The builder's own report says "No paired activation feature".
   4. **Rules:** this adds a new hard block. R-27 allows only two. The carpark entry allows "refused, or the pair completed", but that needs the paired route to exist first.
   5. **Evidence:** only a red run that its builder says failed for the wrong reason (incomplete test fixture). No green run.
   6. **Verdict: HOLD (do not merge).** Needed: first build paired activation (both halves in one installer run, with recovery). Alternatively, change this check to warn and record, and keep the refusal only when the pair is offered together. Needs Tim's word on the block.

7. **#1646 — batch 02 routing note (BUG-878 to BUG-882).**
   1. **What it is:** only a `REGRESSION_LOG.md` entry saying five bugs were skipped. No code.
   2. **Problem:** the product log is for changes. The CE_PLAN batch file already holds this record. The note is already out of date: #1586 (BUG-878), which it calls a draft, has since merged into `23m`.
   3. **Verdict: REJECT (do not merge).** Leave the PR for the desk to close; I did not close it.

---

## What I did NOT check

1. **No builds or tests run by me.** Every pass/fail figure above is read from the builders' own logs. I did not re-run any.
2. **Nothing opened in AutoCAD.** Undo/Redo, save/reopen and the Checks window were not driven. All bugs stay OPEN.
3. **Not read in full:** the test files for #1647, #1648, #1649 and #1652, and the batch 03 local heads beyond their production code.
4. **Not checked:** whether a fingerprint saved in AutoCAD 2024 (net48) matches one computed in AutoCAD 2027 (net10) for #1650's new fit values. Both use the same JSON library, but I did not prove it.
5. **Not checked:** BUG-888 (blocked, owned by batch 03's installer files), BUG-890, BUG-891, BUG-873, BUG-879 (protected files), and the already-covered drafts #1557, #1558, #1562, #1577, #1586, #1592, #1604 and #1609. Most of these have since merged into `23m`.
6. **Worktree collision:** my read-only worktree `C:\ce-rv` was also written into by another session at 19:28 and 19:30, which added `885.diff` and `xis.cs`. To stay safe I switched to reading fixed commits straight from git. I left `C:\ce-rv` in place rather than force-delete another session's files. Whoever owns those two files should remove the worktree with `git worktree remove C:\ce-rv` when done.
