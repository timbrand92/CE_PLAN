# Re-review 2: draft PR 2045, `claude/trust-05-sync-visible` (step 5), head moved `faa4d7d5` to `d0cf644c`

**Reviewer:** lane trust-review (eighth run), Fri 13 Nov 2026, 03:40 PC clock. Read only.
**What was read:** the one new commit `d0cf644c` (diff since `faa4d7d5`, the head of the last re-review): `ReadOnlyToolRecordRule.cs`, `LinkService.RepairAudit.Analysis.cs`, `RecordUpdateSummaryTests.cs`, `REGRESSION_LOG.md`; the step 5 door CDGRAPH calls; `EVIDENCE_BRANCHES.md` FOR TIM item 3.

---

# FOR TIM

1. **One change since the last look:** CDGRAPH and the design check window now work on the pipes CE has stored, not every line drawn on a pipe layer, and CDGRAPH's next line says what the record holds and how many drawn lines it left out ("CE's record holds 11 pits and 49 pipes. 1 line on a pipe layer is not in the record, so it is left out of this trace."). This fixes the one fault the AutoCAD core console saw (50 drawn against 49 stored). Only with the read-only switch on; off is as before.
2. **CDDIAG needed nothing:** the earlier report was the evidence lane's own filter mistake, corrected in `EVIDENCE_BRANCHES.md`.
3. **Verdict: GO** for the robot on copies, as before. One new item for the controller (section 3) found while reviewing PR 2053. Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## 1. The new commit, checked

1. **The trace is trimmed in memory only, before anything is counted.** The left-out step runs before the node and pipe counts are taken (`LinkService.RepairAudit.Analysis.cs` 33-35, counts below them) and removes the left-out pipes from the trace's own lists only (234-252). Nothing in the drawing or the record is touched.
2. **The record it compares with is this drawing's.** CDGRAPH goes through the step 5 door first, which attaches the drawing's own record without writing (`ProjectDataService.ReadOnlyTools.cs` 62-66). The design check window uses the drawing's record only when it is already this drawing's (`TryPeekCurrent`, then 285).
3. **The new line** is inserted straight after the summary (220-222); wording is plain. The window gets one warning row with the same count.
4. **Tests:** the trim on a hand-made trace (stray line out and counted, pits and record untouched, a second call finds nothing), the wording for none, one and several, and source checks that both tools do it only with the switch on and that the count is taken after the trim. Fine for what they claim; the walk of a real drawing is the robot's (row added to `PENDING_TESTS.md`).

## 2. Worth knowing

1. **A decision taken as a default:** `EVIDENCE_BRANCHES.md` item 3.1 listed "drawn count or stored count" for the controller to decide. The builder took "stored". Record it as a DRAFT default for the controller and Tim to confirm.
2. **Pipes are matched by their drawing handle only,** the same as step 1's "not in the CE record" count (`CurrentDrawingCheckService.cs` 608-615), so the two counts agree. A record row that holds the handle only in its name field and leaves the handle field blank would be counted as left out by both (the record tidy-up fills the name from the handle, not the other way: `ProjectDataService.Mutations.cs` 2019-2021 at `cf059dcf`). One robot case on an old job would show whether such rows exist.
3. **Leaving lines out changes CDGRAPH's orphan and disconnected counts:** a plain line joining two pits on the plan is no longer part of the traced network. The new line says so; worth one look in the robot run.
4. **CDPROPAGATE,** which shares the trace, is untouched (the commit says so).
5. **Stacking:** step 6 (`claude/trust-06-guesses-removed`) moved to `98d81717` by merging this commit; the merge resolves only `REGRESSION_LOG.md`. PR 2050 now sits on that. PR 2051 still sits on the older step 6.

## 3. For the controller (from the PR 2053 review, by reading, not seen)

1. **Two more "tools that only read" still write: CDHELP (Help) and CDS (CD Settings).** Both are on CE's list of commands after which the whole record is written at the command's end (`LinkService.cs` 61-81 at `cf059dcf`, unchanged on this branch), and neither attaches the record to its drawing first. So in a second drawing they can write the first drawing's record into it. Step 5's card names CDGRAPH, CDDIAG, CDDASHBOARD and Edit Pit only; this list is outside it. Detail: `reviews\claude-trust04-cancel-guards.md` section 3.

## 4. Not checked

1. Not built or run by me. The earlier FIX FIRST items were closed at `faa4d7d5` (last re-review); not re-read.
2. Whether every graph edge CDGRAPH traces is on a pipe layer (the new line says "line on a pipe layer").
