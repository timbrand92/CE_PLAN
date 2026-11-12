# Trust plan: the autonomous run (started Thu 12 Nov 2026, about 22:45 PC clock)

**Controller:** chat CE_ACAD / trust plan / plan / 01. Every side session started for this run reads this file first and obeys it.

## 1. Tim's words (12 Nov 2026, in order)

1. "can you work autonomously until tomorrow midday on anything you think is worthwhile"
2. "you can test, get evidence, fix, build, anything else you deem necessary"
3. "you can create side sessions to do seperate things, i need you to use all weekly usage before reset then complete everything before continuing to work but managing usage based on a smooth week of usage 12-13% per day"
4. "i cant respond after this message so please dont get stuck"
5. "tell me when i can leave you to it"

## 2. How the controller reads them (INTERPRETATION, for Tim to correct)

1. **The HOLD is lifted for building, testing, fixing and gathering evidence.** Tim said so himself in line 2.
2. **The HOLD is NOT lifted for three things,** because he did not name them and each can hurt his real work or a colleague's:
   1. **Installing on Tim's PC** (his live AutoCAD bundle). He drafts real jobs on it from 8:30am. RULES 8.7 still needs his word.
   2. **Anything to colleagues:** no release, no pilot folder change, no message.
   3. **Merging into the lines that ship.** Work stays on its own branches as draft pull requests.
3. **Cards are built on the recommended answers, marked DRAFT** (Tim's standing 9 Oct rule: builds never wait on his answers; his answer replaces the default later). No open question is recorded as decided.
4. **Usage:** spend freely until the weekly reset (Fri 13 Nov 13:00 Melbourne; 7% used at 22:40 on 12 Nov). From the reset, hold a straight line of 12 to 13% a day. Work is not invented to burn usage; if useful work runs out, the run says so.
5. **Never stuck:** no question is put to Tim. A session that meets a decision takes the recommended answer, writes "DRAFT default, Tim to confirm" beside it, and carries on. A session that meets a refusal or a safety check does not work round it: it records it and moves to its next item.

## 3. Rules every session in this run obeys

1. **Read first:** `C:\TimOS\RULES.md`, this file, `C:\CE_PLAN\areas\trust-plan.md`, and your own card.
2. **Code truth:** what ships is NOT `master`. Civil and Manager installed = commit `cf059dcf` (Civil 3.0.90, Manager 1.1.89). Structural installed = `8de95c34` (1.0.126). Cut your branch from the installed commit, in your own worktree. Read-only copies for reference: `C:\CE_WORK\scratch\audit_civil`, `C:\CE_WORK\scratch\audit_struc`.
3. **Every build and test:** `-p:SkipDevBundle=true -nr:false --disable-build-servers`. Building without it overwrites Tim's live AutoCAD bundle. Never do that.
4. **One build at a time on this PC.** Before a build or test run, create `C:\CE_WORK\scratch\trust_build.lock` containing your session name; delete it when done. If one exists and is younger than 40 minutes, wait and re-check; older than that, treat it as stale and replace it.
5. **Disk:** check C: free space before each build. Under 25 GB: stop building, `git clean -fdXq` only inside your OWN worktree, and report.
6. **AutoCAD:** only the session named "trust-acad-evidence" starts AutoCAD. Tim's hours are weekdays 8:30am to 2:00pm and 3:00pm to 5:30pm Melbourne: no AutoCAD then. Re-read `C:\Users\TimothyBrand\.timos\autocad.json` before starting or closing it. Never close an AutoCAD you did not start. Test copies only.
7. **No client data.** Never open `C:\CE_DrawingIntelligence` or the office Projects folder. No client name, street address or job address in any file, commit, branch name, screenshot name or log line. Test drawings are made-up or the existing labelled test copies.
8. **Tests:** check tests for writes to `%APPDATA%` or Tim's real files before running them; skip the Installer tests named in the repo notes (RetiredRivalDeployRoutes, StructuralPreparation). Zero tests found is not a pass. Never weaken, skip or delete a test to get a green result.
9. **Native AutoCAD protection:** nothing unlocks a layer, touches an Xref, or works round REFEDIT.
10. **Every change = code + a `REGRESSION_LOG.md` entry + tests.** Explain it in drafting words.
11. **Where work lands:** push your branch, open a DRAFT pull request, never merge, never enable auto-merge. Add a row to `C:\CE_PLAN\PENDING_TESTS.md` and a status line under section 5 below.
12. **Saving in `C:\CE_PLAN`:** `git fetch; git merge --no-edit origin/main`, add files BY NAME, commit, `git push origin HEAD:main`. Never `git add -A`. The leak scan runs on push; if it refuses, stop and record what and where.
13. **The four states:** say Built / Tested / Installed / Accepted separately. Nothing in this run is Installed or Accepted.
14. **Never delete** a working copy, branch or file you did not create.
15. **Report format when you finish a piece:** Done or not done. Changed: files. Tests: n ran, n passed. Not tested: list. Found: one line each. Defaults taken for Tim to confirm: list.

## 4. The sessions

1. **trust-foundations:** builds step 1 (opening line, card UX-OPEN-01), then step 5 (card TRUST-05), then step 6 (card TRUST-06), one after another on stacked branches.
2. **trust-safety-fixes:** step 4 (card TRUST-04). Starts by reading the fix branches that already exist; lifts or rebuilds each fix as its own small piece.
3. **trust-core-ribbon:** step 2 (card TRUST-02), built as DRAFT on the Civil sort proposal.
4. **trust-acad-evidence:** the probes in `trust-plan.md` section 5 that need AutoCAD, on made-up and existing test copies, on the installed build. Later, evidence for the builders' branches where that can be done without installing.
5. **trust-struc-mgr-plan:** the Structural and Manager part of the plan, written from the 6 Nov audit and the tick list. Planning only.

## 4b. Controller continuity note (written Fri 13 Nov 05:45 PC clock; read this first after any compaction or in a new controller chat)

1. **How the run works now:** nine lanes, queues and models in `areas\trust-run\QUEUES.md` (newest "Refill" block wins). Five side sessions (trust-foundations, trust-safety-fixes, trust-core-ribbon, trust-acad-evidence, trust-struc-mgr-plan) each with their own 40-minute check-in. Four helper lanes (reader, review, test-cases, records) are started by the controller with the Agent tool. The controller has an hourly check at 23 minutes past, and a one-off at 7:52am Friday to finish the morning page and send Tim one phone notification about BUG-1456.
2. **Where to read state:** each lane's own file in `areas\trust-run\`; every review in `areas\trust-run\reviews\` with the list in `trust-review.md`; the board `areas\trust-run\STATUS_BOARD.md`; real AutoCAD evidence in `areas\TRUST_PROBES_13NOV.md` and `areas\trust-run\EVIDENCE_*.md`; the event log is the tail of `areas\release-v3-colleagues-DESK_LOG.md`.
3. **The most important finding:** BUG-1456, seen on the INSTALLED build: Help or Settings run first in a second drawing writes the previous drawing's CE data into it. Fix drafted (pull request 2064 and a split-out branch), reviewed FIX FIRST, not installed. Tim to be told first thing with the two safe habits.
4. **What is never done without Tim:** install on his PC, merge, anything to colleagues, AutoCAD in his hours (weekdays 8:30am to 2pm, 3pm to 5:30pm). All pull requests stay drafts with auto-merge off; the controller checks that and reads the installed versions every hour (Civil 3.0.90 cf059dcf, Structural 1.0.126 8de95c34).
5. **Usage:** 42 percent of the week at 05:40 Friday; reset Friday 13:00; after the reset hold 12 to 13 percent a day by pausing the cheapest lanes first.
6. **For Tim when he is back:** `areas\TRUST_MORNING_BRIEF_13NOV.md`, then `areas\TRUST_QUESTIONS_FOR_TIM.md` (batch 0 first: the spare work PC for seeing trial builds). Questions go to him through the question interface, four related ones at a time.
7. **Clock:** every time written must be read from the PC clock. Several lanes and the controller wrote estimated times early in the run; the order of events is right, some times are not.

## 5. Status (each session adds dated lines here; newest last)

- 2026-11-12 22:45: run opened by the controller. Nothing built yet.
- 2026-11-12 23:20 trust-core-ribbon: step 2 built as DRAFT, switch OFF. Branch `claude/trust-core-ribbon-e13111`, draft PR https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/2038 (base rel-20261108a = installed cf059dcf). Built net48 + net10: yes (0 errors). Tested: 17 new tests pass; full net10 Drainage suite 22,183 passed, 3 failed, 1 mine (fixed, re-run green), 2 are IL-shape tests in SourceAtomicCoordinatorDependencyTests in code not touched (not yet compared with baseline). Installed no. Accepted no. CE_SHARED unchanged. Pull-down menu for 2022 to 2024 not changed.
- 2026-11-13 00:52: trust-safety-fixes (TRUST-04). Built / Tested (unit only) / Installed NO / Accepted NO for every item. Draft PRs, none merged: BUG-1274 #2039 and BUG-1276 Civil #2042 (base claude/rel-20261108a = cf059dcf); BUG-497 #2044, BUG-498 #2046, BUG-499 #2047, BUG-1276 Structural #2048 (base claude/trust04-base-struc-1.0.126 = 8de95c34, a pointer branch). No PR, with reasons: BUG-650 (fix da006db6 already in installed Civil since 3.0.70; unit twin 3 of 8 fail without it) and BUG-1255 (fix PR #1871 already in installed Civil since 3.0.88; Codex K1-01/K1-03 PASS SURE 1 Nov); BUG-1275 STALLED (cause not proven; crash inside AutoCAD's own code; a guard would be a guess). Defaults taken: no off switch on 497/498/499 (card section 2); BUG-499 rule (trusses out of wall totals) needs Tim's engineering word. Own mistake: pushed a branch whose test file held a real job number and street name (already on GitHub in the 5 Nov branches); cleaned and force-pushed my branch within minutes; the 5 Nov branches and rel-20261026s still hold them (repo private). Findings: side-session note trust-safety-fixes_findings_12nov.md. PENDING_TESTS rows added (section "TRUST-04 core safety fixes").
- 2026-11-13 01:11 trust-reader (second run): review FIX FIRST eight items fixed (3eb415c9), queue item 6 read-only copy-filler with call-graph proof (ab4fc1f7), old palette blocks taught (222a303e), all on `claude/trust-reader`, draft PR 2040, pushed. Built yes. Tested unit only: 155 of 155 trust-reader tests on net10 and net48; RedoSafeCallGraph + RedoWindowGuard 70 of 70. Installed no. Accepted no. 35 DRAFT defaults listed in `areas\trust-run\trust-reader.md`.
