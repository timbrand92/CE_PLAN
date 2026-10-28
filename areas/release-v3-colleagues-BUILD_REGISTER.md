# Build register: one number per build item (B-001 and up)

Started Thu 29 Oct 2026 by CE 01 Build. Tim: "yes, build numbers" (29 Oct 2026, answering whether every build item should have its own number). Owner: CE 01 Build only; other sessions read it, they do not edit it.

**What a build item is:** one piece of work that ends in one draft PR (a bug fix, a plan card, a default change). The B number never changes. It sits beside the other labels and replaces none of them: the BUG number (if it came from the bug file), the card or ruling (D05, UX-SRC-03), the PR number (#1834) and the train (C-76).

**The four words** (RULES section 4, never merged into a percentage): Built, Tested (unit tests or the robot), Installed, Tim-accepted. A line says which are true today. "Claude-accepted" and "Codex-accepted" are written out in full where they apply; they are not Tim-accepted.

**Before 29 Oct:** earlier trains are not renumbered. C-75 (installed 29 Oct 00:21) was PR #1831 (BUG-665 and BUG-672), #1832 (BUG-1222) and #1833 (BUG-1223); see TRAIN_C75_PR_LIST_2026-10-28.md.

## Train C-76 (Civil 3.0.86 / Manager 1.1.86), assembling from 10:27

1. **B-001 BUG-859, double-click on a downpipe opens CE's Edit source window first.** PR #1834. Switch doubleClick.sourceStopsAttributeEditorFirst, ON. Built yes; tested unit only; installed no; Tim-accepted no. Robot proof R09 (twin R09_OFF_BROKEN).
2. **B-002 BUG-372, CDCHECK prints "an unnamed pipe", no raw handles.** PR #1835. Built yes; tested unit only; installed no; Tim-accepted no. Robot proof R22.
3. **B-003 BUG-090, the Manager About window grows to fit its rows.** PR #1836. Changes Manager code. Built yes; tested unit only; installed no; Tim-accepted no. Needs a Codex look.
4. **B-004 BUG-1228, DP takes about 30 s: each object is read once per landing read.** PR #1837. Switch linking.sourceLandingReadsEachObjectOnce ON (log-only linking.sourceLandingTimingLog OFF). Built yes; tested unit only (new time not measured); installed no; Tim-accepted no. Robot proof N31_dp_time with control C31.

## Next (fix agents and Team jobs running, one dotnet at a time)

5. **B-005 BUG-1229, grade shown flatter than the grade chosen (1 in 102 for 1 in 100).** Sonnet agent building, no PR yet. Not promoted to a train.
6. **B-006 BUG-1226, "Recent:" invert buttons back on the New Pipe window.** Team job team_fix_c77a. Tim: "yep bring back". Robot guard N30. Running.
7. **B-007 Raingarden RG1, RG2 label from CDRG.** Team job team_fix_c77b. Tim: "as recommended" (ruling UX-SRC-03, card D07). Queued.
8. **B-008 Tidy labels switch ON by default.** team_fix_c77c. Tim: "yes". Queued.
9. **B-009 Grip, ROTATE and SCALE copy clean-up ON by default.** team_fix_c77d. Tim: "yes", after a robot pass with it ON (CE 02 runs that pass); not for a train before then. Queued.
10. **B-010 BUG-505, no-units import keeps millimetres with one soft note.** team_fix_c77e. Tim: "yes". Queued.
11. **B-011 The two small extras of #1788 (comma figure refused, unset material speed falls back).** team_fix_c77f. Tim: "agreed to two small extras". The outbox switch stays OFF and is not part of this. Queued.
12. **B-012 Cover measured to the outside top of the pipe.** team_fix_c77g (Opus). Tim: "yes, add the pipe wall". Wall thickness from Settings or pipe data. Queued.
13. **B-013 Pit drop warning where the outlet pipe top sits above the inlet pipe top.** team_fix_c77h. Tim: "yes". Warn, never block. Queued.
14. **B-014 BUG-860, double-click on the green DP label opens Edit source.** team_fix_c77i, stacked on #1834. Tim: "yes". Queued.
15. **B-015 PR #1771, computations-sheet line (hydraulic grade line not calculated) on every council sheet.** Existing PR on an old base (rel-20261025o). Tim: "do as you recommend". Needs the usual review and a rebase onto the newest line before a train. Not started.

## Rules for this register

1. **New number = next free B number**, written the same moment the work is queued; never reused, never deleted (D6).
2. **A bug fix keeps its BUG number beside the B number.** Building never creates a BUG number; only a fault found by a test or by Tim does (bug file, next free number).
3. **Updated at every 20-minute check** by CE 01. If it disagrees with a PR, the PR is right: fix the register and say so in DESK_LOG.
