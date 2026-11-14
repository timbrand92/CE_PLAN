# Tim's interview: how the finished product should work

**Started Sun 15 Nov 2026 by the ask chat (CE_ACAD / trust plan / ask / 01 queue and interviews), on Tim's word to the controller: "add a side session for the queue and all interviews to get to know what i want the final product to work".**

**How to read this file:**

1. **Grouped by the stages of a job**, in the order the work happens.
2. **Each answer is Tim's click or his typed words, in quotes,** with the date and PC clock time, and the choices he did not pick.
3. **Anything marked "ask chat's reading" is mine, not Tim's.**
4. **A question with no answer is not a decision.** It is listed as open.
5. **Nothing here is an instruction to build.** New screens still need a mock-up and Tim's OK first.

Queue answers (the controller's numbered items) are in `FOR_TIM_QUEUE.md`, not here.

---

## 1. Starting a job

**1.1 How should a new drainage job begin?**

- **Tim, Sun 15 Nov 2026 01:51 PC clock, clicked:** "New Job, one window (Recommended)".
- **Choice text he saw:** "you click New Job, pick the council and the sheet size, and CE opens the office template with that council's rainfall and rules already set."
- **Not chosen:** "From the architect's drawing" (CE adds the office layers and council set-up into the architect's site plan); "Copy a similar past job" (Save As last month's job, CE clears the old pits, pipes and levels); "My template, set up later" (pick the council only at the first check or calcs).
- **Ask chat's reading (mine):** one window, council and sheet size picked up front, rainfall and rules following from the council. What else belongs in that one window, and what happens with the architect's drawing, has not been asked yet.
- **Related, already recorded:** the usual job is a site stormwater plan for council (queue item 7, same sitting).

**1.2 How should the architect's site plan sit in the drainage drawing?**

- **Tim, Sun 15 Nov 2026 01:53 PC clock, clicked:** "As an xref, CE never touches it (Recommended)".
- **Choice text he saw:** "the architect sends revision B; you swap the xref and your pits and pipes stay where they are. CE reads the plan but never edits, binds or explodes it."
- **Not chosen:** "Pasted in, CE tidies it"; "Either, CE asks at New Job".
- **Ask chat's reading (mine):** agrees with the native AutoCAD protection rule already in the repo procedure (never bind, explode or edit foreign content). Whether New Job attaches the xref for him was not asked.

## 2. Marking where water comes from

**2.1 How should downpipes get onto the plan?**

- **Tim, Sun 15 Nov 2026 01:53 PC clock, clicked:** "Both: propose where it can". **This was NOT the recommended choice** (recommended was "I place each one").
- **Choice text he saw:** "on a plan with clear DP symbols CE proposes; on a hand-marked PDF underlay you place them yourself."
- **Not chosen:** "I place each one (Recommended)" (CE keeps a count, never guesses a position); "CE proposes, I tick" (CE finds the architect's DP symbols and places only the ones he ticks).
- **Ask chat's reading (mine):** he wants CE to find downpipes on the architect's plan where their symbols are clear and offer them, with placing by hand always available. Not yet asked, so NOT decided: whether a proposed downpipe needs his tick before it is placed (the "CE proposes, I tick" choice described ticking; the one he picked did not say), and what counts as a "clear" symbol. This is new work, not a fix, so under "prove, don't draft" it is an idea for later, not something to build now.

**2.2 When CE proposes downpipes from the architect's symbols, what happens next?**

- **Tim, Sun 15 Nov 2026 01:55 PC clock, clicked:** "Nothing placed until I tick (Recommended)".
- **Choice text he saw:** "12 ghost downpipes show on the plan with a list; you untick the 2 that are really vent pipes and press Apply. 10 are placed, one U takes them back."
- **Not chosen:** "Place all, I delete extras"; "Tick all in one click".
- **Ask chat's reading (mine):** this settles the open point in 2.1: a proposed downpipe is never placed without his tick. The example had the proposals shown ticked for him to untick; whether they start ticked or unticked was not asked as its own question. Still a later idea, not something to build now.

## 3. Laying the network

**3.1 How do you want to draw pits and pipes?**

- **Tim, Sun 15 Nov 2026 01:53 PC clock, clicked:** "Pits first, then pipes (Recommended)".
- **Choice text he saw:** "you place P1 to P6 with PIT, then run CD from pit to pit. Two tools, as today, each one proven separately."
- **Not chosen:** "One running tool" (a pit at each click with a pipe between); "Pipes first, pits at ends".

## 4. Setting levels

**4.1 When CE solves the inverts down a run, how should the result reach the drawing?**

- **Tim, Sun 15 Nov 2026 01:53 PC clock, clicked:** "Preview first, then Apply (Recommended)".
- **Choice text he saw:** "a short list shows each pit's invert, cover and fall, with the run lit up on the plan. Nothing is written until you press Apply; Esc writes nothing."
- **Not chosen:** "Write it, one U undoes"; "Preview only when it warns".
- **Ask chat's reading (mine):** for levels he prefers a preview over his general screen rule "Undo instead of 'Are you sure?'". I read that as: a preview of numbers is not an "Are you sure?" box. Whether the same holds for other tools has not been asked.

## 5. Checking

**5.1 When should CE check the drawing against the council rules?**

- **Tim, Sun 15 Nov 2026 01:55 PC clock, clicked:** "Before schedule or plot". **This was NOT the recommended choice** (recommended was "When I ask, plus a quiet line").
- **Choice text he saw:** "you draft undisturbed; when you place the Pit Schedule or plot, CE runs the check first and lists anything open."
- **Not chosen:** "When I ask, plus a quiet line (Recommended)" (a status line always showing counts, full check only on a click); "Live, as I draw" (a pipe turns amber as soon as it breaks a rule).
- **Ask chat's reading (mine):** he wants to draft without being interrupted, and the check to run by itself at the two moments the drawing leaves his hands. NOT asked, so NOT decided: whether he still wants the always-there status line (area 1 of `areas\TRUST_ONE_DRAFTER_CIVIL_DAY_14NOV.md`); whether an open warning at plot time stops the plot (his no-hard-blocks rule says it should warn and carry on); whether Check stays available on a click as well. CE running a check at plot time is new behaviour, not a fix: a later idea, nothing to build now.

## 6. Getting it on the sheet

**6.1 The Pit Schedule is placed, then a pipe changes on the plan. What should the schedule do?**

- **Tim, Sun 15 Nov 2026 01:55 PC clock, clicked:** "Update itself". **This was NOT the recommended choice** (recommended was "Mark it out of date").
- **Choice text he saw:** "you change P4 to P5 from 150 to 225 and the schedule row changes by itself, with one line saying it did."
- **Not chosen:** "Mark it out of date (Recommended)" (changes only on Refresh); "Warn only at plot".
- **Ask chat's reading (mine):** he wants the schedule on the sheet to follow the plan without a Refresh click, and to be told in one line when it has. This differs from the controller's draft in `areas\TRUST_ONE_DRAFTER_CIVIL_DAY_14NOV.md` section 2 item 3 ("marked 'out of date' until refreshed"); Tim's answer is newer. NOT asked: the same question for the long section and the calculations; what happens to a schedule he has edited by hand. New behaviour, not a fix: a later idea, nothing to build now.

## 7. Markup coming back

**7.1 You move pit P4 by 2 m with MR. What should happen to its pipes and levels?**

- **Tim, Sun 15 Nov 2026 01:55 PC clock, clicked:** "Pipes follow, ask about levels". **This was NOT the recommended choice** (recommended was "Pipes follow, levels kept, flagged").
- **Choice text he saw:** "the pipes stretch, then CE offers the solve preview for that run: Apply to update the levels or Esc to keep them."
- **Not chosen:** "Pipes follow, levels kept, flagged (Recommended)"; "Pipes follow, levels re-solved" (CE re-solves by itself and says which levels changed).
- **Ask chat's reading (mine):** pipes always stay joined to a moved pit; levels are never changed silently and never left silently stale: CE offers the same preview as 4.1 and he chooses. Consistent with 4.1 (preview first, then Apply). MR offering the solve preview is new behaviour: a later idea; MR's proof in the ten is unchanged by this.

## 8. What "ready for colleagues" means

Not asked yet.

## 9. What CE must never do by itself

Not asked yet.

## 10. What a good day with CE looks like

Not asked yet.
