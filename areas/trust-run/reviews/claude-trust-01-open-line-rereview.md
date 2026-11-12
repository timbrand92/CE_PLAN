# Re-review: draft PR 2041, `claude/trust-01-open-line` (step 1, the opening line, card UX-OPEN-01)

**Reviewer:** lane trust-review (fifth run), Fri 13 Nov 2026, 00:59 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff 00c3baf5 31f426ab` (the one review-fix commit since my last review; 5 files), the earlier review `reviews\claude-trust-01-open-line.md`, the lane's status `trust-foundations.md` (00:45 line). Line numbers are at `31f426ab`.

---

# FOR TIM

1. **A drawing you open by double-clicking it in Explorer now gets its line too.** Before, only drawings opened after CE had loaded did.
2. **Good jobs should not say "needs checking" because of outlet or downpipe pipes,** as long as those pipe ends carry a name, which only a robot run on a real current job can prove.
3. **The words now say "pit blocks" everywhere.**

**Verdict: GO** for the robot on copies. Before the robot runs cases O18 and O20 the controller must settle the three wording disagreements with the case file (item 5). Not a merge or install decision. Built yes (lane: net48 and net10). Tested unit only (lane: whole Civil test project, Release, 22,235 ran, 22,203 passed, 32 skipped, 0 failed; not re-run here). Installed no. Accepted no.

---

## 1. The last review's FIX FIRST items

1. **The drawing already open when CE loads: FIXED for the drawing in front.** `Initialize` now puts AutoCAD's active drawing on the waiting list as well (`DrawingStateLineOnOpenService.cs` 40-49). It only adds to the waiting list; no read or write happens there, so the "writes nothing" proof is unaffected. Gap: only the drawing in front is queued. If AutoCAD starts with several drawings (several selected in Explorer, or reopening a set), the others still get no line until something else opens them. Robot case: start AutoCAD by opening one test copy.
2. **"Pipes not linked" on good jobs: rule PINNED, real data still unproven.** `APipeEndNamedForAnOutletADownpipeOrAConnectionPoint_IsLinked_NotAFault` (`DrawingStateLineOpenTests.cs` 167) pins that an end named LPD, DP1 or CP1 is linked and a blank end is open. Whether CD and CDLPD really store a name at a downpipe or connection-point end on a current job is not shown by any unit test; the lane lists the robot case on a current job as still needed. That is honest and right.
3. **The silent large drawing listed as a default: DONE** (change log item 11 (i), and (j) for a no-record drawing with pipe-layer lines and no pit blocks).
4. **One word: DONE.** Every line, the second line and the CDCHECKCURRENT items now say "pit block(s)" (`DrawingStateLineRule.cs` 41 and 69; `CurrentDrawingCheckService.cs` 627-628 and 635); a test bans "symbol" from the item words. The only "pit symbols" left is in a code comment.
5. **The case file disagreements: HANDED to the controller,** as asked (the unreadable-record wording against case O18; scripts in full AutoCAD against case O20; the look brief's ban on "record"). Not code. The robot should not run O18 and O20 until the controller has settled them.

## 2. New findings

1. **A pipe end stored as "-" reads two ways.** The lane found the opening line's check treats "-" as linked, while Edit Pipe, the Inspector, CDLPD and step 5's count treat it as "no owner". So on the same drawing step 1 can say "all linked" while step 5 says "1 pipe end no longer joined". Left as it is on purpose (existing CDCHECKCURRENT behaviour). For the controller: one reading for both (design rule 1), or a listed default.

## 3. Not checked

1. Did not build or run tests; the counts are the lane's.
2. Nothing opened in AutoCAD: the line for a drawing opened from Explorer, the moment the line appears, "save changes?" on close, Redo, counts on real jobs.
3. AutoCAD 2022 to 2024 (compiles per the lane; not run).
