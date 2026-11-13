# Review: PR 2090 `claude/bug-1456d-refusal-said-on-screen` (BUG-1456, a refusal said on the command line), head `39e489e9`

**Reviewer:** lane trust-review (sixteenth run). **Written:** Fri 13 Nov 2026, 11:49 PC clock. **Base:** on PR 2089's head `e938d0d4` (one commit). Draft, auto-merge off. Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **It only adds a line on the command line** when CE refuses to record a change because it is holding another drawing's pits and pipes. It changes no decision, writes nothing into any drawing and adds no Undo step.
2. **The wording is a draft for you,** but it is not yet in your question list. The ask "please report which tool you were using" does not say who to tell or what to do next (U would undo the drawing change).
3. **Leaving it off your PC today is safe.** It sits on top of 2089, and today's trial is 2073 and 2083 without it. Without it, a refusal is only in CE's log, as 2083 already does.

**Verdict: GO** for its own change: the robot can run it with 2089 once 2089's two items are fixed. The wording is DRAFT for Tim.

---

# Findings (file and line at `39e489e9`)

1. **Only what it says.** Three product files:
   - `Rules/RecordOwnerRule.cs:102-117`: two line texts and a pacing rule.
   - `ProjectDataService.RecordChangeDoor.cs:81`: the call, inside the branch that already logs the refusal; and `:104-118`: `SayRefusalOnScreen`.
   - `ProjectDataService.SnapshotOwner.cs:123`: the call, after the refusal is logged.

   Both calls are inside branches that already return "refused". **No decision changes, so 2073, 2083 and 2089 are not weakened when it is left out.**
2. **Can a failure here turn a refusal into a write? No.** `SayRefusalOnScreen` catches every error itself (`RecordChangeDoor.cs:114-117`), so the refusal still returns true. It writes only to the front drawing's command line: nothing in any drawing, no Undo step.
3. **How often the line is said:**
   - The change-door line comes only with a logged line, which is already limited to one per interval, and then once more by its own 5-second limit.
   - Both lines share one timer, so a change refusal and a copy refusal within 5 seconds give one line.
   - It writes to the command line while CE's record is locked (`:81` is inside `lock (_lock)`). Low risk: the same thread, and writing to the command line does not run other CE code.
4. **The words (for Tim, DRAFT):**
   1. Plain: no "record", "database" or "snapshot". "CE is holding another drawing's pits and pipes" says what happened.
   2. "Please report which tool you were using" names no one to report to and no next step. Suggest, for example: "... Nothing in CE's data was changed. If the drawing changed, press U to undo it, then tell [office contact] which tool you used." It could also name the command, which CE knows at that moment.
   3. "CE: CE's own data in this drawing ..." says CE twice.
   4. In the batch edit the copy line is followed by the batch's own rolled-back line, whose last sentence is software words ("The saved CE project data differs from the accepted batch.", see the 2089 review item 2).
   5. **Not in `areas\TRUST_QUESTIONS_FOR_TIM.md`** (no BUG-1456 entry there at 11:45). It is listed only in the PR's "Decisions for Tim" and in `PENDING_TESTS.md` row 9. The controller should add it.
5. **Tests:** both lines plain, the pacing rule, and on the compiled plugin both refusals reach the command line, with the log-only build as the faulty version. Core console: both lines seen once each, and none in the cure check (`EVIDENCE_CROSS_DRAWING.md`, 09:50).

# What I did not check

1. No build, no test run, no AutoCAD.
2. How the line reads in a modal window's moment (Pit Schedule) or from a palette; robot rows 9 and 10.
