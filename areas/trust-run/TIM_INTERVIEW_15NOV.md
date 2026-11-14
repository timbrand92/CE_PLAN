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

**5.2 CE runs the check as you plot and finds 2 open warnings. What then?**

- **Tim, Sun 15 Nov 2026 01:57 PC clock, clicked:** "Show them, I choose". **This was NOT the recommended choice** (recommended was "List them, plot carries on").
- **Choice text he saw:** "a small list appears with two buttons, 'Plot anyway' and 'Show me', and waits for your click."
- **Not chosen:** "List them, plot carries on (Recommended)"; "Only stop for serious ones".
- **Ask chat's reading (mine):** at plot time he wants to be stopped long enough to choose, for every open warning, not only serious ones. This is not a hard block under his no-hard-blocks rule, because "Plot anyway" is always there. It is a new small window, so his screen rule applies: a mock-up and his OK before anything is built. NOT asked: whether the same list shows when the Pit Schedule is placed.

**5.3 Do you also want a quiet status line that is always there? OPEN, NOT A DECISION.**

- **Tim, Sun 15 Nov 2026 01:59 PC clock, typed instead of clicking a choice:** "think about this more".
- **Choices he was shown and did not pick:** "Yes, quiet, never pops up (Recommended)" (one line always reading '14 pits, 13 pipes, 2 Unknown, 1 warning'); "No, only at schedule and plot"; "Only when something is Unknown".
- **Ask chat's reading (mine):** not an answer. Either he wants time to think, or he wants the idea thought through better before he is asked again. Either way the next step is mine: bring it back with a picture of where the line would sit and what it would say on a clean drawing and on one with problems, then ask again. Until then nobody may treat the status line as wanted or as unwanted by Tim.

## 6. Getting it on the sheet

**6.1 The Pit Schedule is placed, then a pipe changes on the plan. What should the schedule do?**

- **Tim, Sun 15 Nov 2026 01:55 PC clock, clicked:** "Update itself". **This was NOT the recommended choice** (recommended was "Mark it out of date").
- **Choice text he saw:** "you change P4 to P5 from 150 to 225 and the schedule row changes by itself, with one line saying it did."
- **Not chosen:** "Mark it out of date (Recommended)" (changes only on Refresh); "Warn only at plot".
- **Ask chat's reading (mine):** he wants the schedule on the sheet to follow the plan without a Refresh click, and to be told in one line when it has. This differs from the controller's draft in `areas\TRUST_ONE_DRAFTER_CIVIL_DAY_14NOV.md` section 2 item 3 ("marked 'out of date' until refreshed"); Tim's answer is newer. NOT asked: the same question for the long section and the calculations; what happens to a schedule he has edited by hand. New behaviour, not a fix: a later idea, nothing to build now.

**6.2 Should the long section and the calculations also update themselves?**

- **Tim, Sun 15 Nov 2026 01:59 PC clock, clicked:** "Yes, all follow the plan (Recommended)".
- **Choice text he saw:** "you change P4 to P5 to 225; the schedule row, the long section pipe and the calc line all change, with one line saying '3 items updated'. They can never disagree."
- **Not chosen:** "Schedule only"; "Schedule and long section".
- **Ask chat's reading (mine):** the plan is the one source; schedule, long section and calculations all follow it by themselves and CE says so in one line. Still not asked: a schedule he has edited by hand. New behaviour, a later idea, nothing to build now.

## 7. Markup coming back

**7.1 You move pit P4 by 2 m with MR. What should happen to its pipes and levels?**

- **Tim, Sun 15 Nov 2026 01:55 PC clock, clicked:** "Pipes follow, ask about levels". **This was NOT the recommended choice** (recommended was "Pipes follow, levels kept, flagged").
- **Choice text he saw:** "the pipes stretch, then CE offers the solve preview for that run: Apply to update the levels or Esc to keep them."
- **Not chosen:** "Pipes follow, levels kept, flagged (Recommended)"; "Pipes follow, levels re-solved" (CE re-solves by itself and says which levels changed).
- **Ask chat's reading (mine):** pipes always stay joined to a moved pit; levels are never changed silently and never left silently stale: CE offers the same preview as 4.1 and he chooses. Consistent with 4.1 (preview first, then Apply). MR offering the solve preview is new behaviour: a later idea; MR's proof in the ten is unchanged by this.

## 8. What "ready for colleagues" means

**8.1 What does "ready for colleagues" mean for the Civil tools?**

- **Tim, Sun 15 Nov 2026 01:57 PC clock, clicked:** "Both of those". **This was NOT the recommended choice** (recommended was "Ten proven, clean days on my PC").
- **Choice text he saw:** "the ten proven, five clean days, and one real job start to finish, before the first colleague gets it."
- **The two parts, as he saw them in the other choices:** (a) "all ten tools accepted in AutoCAD, then five working days of your own drafting with no lost work, no crash and no wrong value"; (b) "you take one council stormwater job from blank drawing to submission using only CE, and nothing had to be fixed by hand."
- **Ask chat's reading (mine):** three conditions, all needed before the first colleague: the ten accepted; five clean working days on his own PC; one real council stormwater job done start to finish on CE alone with nothing fixed by hand. The third is new and is stricter than the earlier "Robot-accepted plus 5 working days" wording of 17 Oct (ruling D); his 15 Nov answer is newer. NOT asked: whether the five days and the real job may overlap, and who judges "nothing had to be fixed by hand".

**8.2 Can the five clean days and the one real job happen at the same time?**

- **Tim, Sun 15 Nov 2026 01:59 PC clock, clicked:** "Yes, they can overlap (Recommended)".
- **Choice text he saw:** "you draft one real council job on CE during a normal week; if the week is clean and the job needed no hand fixes, both boxes are ticked on Friday."
- **Not chosen:** "No, days first, then the job".

## 9. What CE must never do by itself

**9.1 Which of these must CE never do by itself, without showing you first?** (He was told these are already ruled: it never saves for him, never unlocks a layer, never changes a drawing just by opening it.)

- **Tim, Sun 15 Nov 2026 01:57 PC clock, ticked all four:** "Change a level or size", "Renumber pits", "Move or delete my labels", "Change layers or colours".
- **Examples he saw:** an invert or pipe diameter never changes unless he typed it or pressed Apply on a preview that showed it; deleting P3 never turns P4 into P3 by itself, numbers only change when he runs Renumber; a label he dragged clear of a hatch stays exactly there after any CE tool runs; CE never switches a layer off, freezes it or changes its colour unless he asked in Layer Manager.
- **Ask chat's reading (mine):** together with 6.1 this draws the line: the schedule on the sheet may follow the plan by itself (saying so), but the plan's own levels, sizes, pit numbers, his label positions and his layers never change without his action. Points to check against today's tools, not asked of Tim: CLEAN and the label-tidy tools change layers or labels, but only when he runs them, which I read as "he asked".

## 10. What a good day with CE looks like

**10.1 What matters most for a good day with CE?**

- **Tim, Sun 15 Nov 2026 01:57 PC clock, clicked:** "Nothing wrong reaches council (Recommended)".
- **Choice text he saw:** "every level, size and pit number on the submitted sheet is one you saw or chose; no made-up 100 dia, no label on the wrong pit."
- **Not chosen as the most important:** "No lost work, no crash"; "Fewest clicks"; "Colleagues don't need me". He was asked for the one that matters most; the others are not rejected.

---

## Still to ask in the interview (not decisions)

1. **Starting a job:** what else belongs in the New Job window; whether New Job attaches the architect's xref.
2. **Checking:** the always-there status line (5.3, he said "think about this more": bring a picture, then ask again); whether the plot-time list also shows when the Pit Schedule is placed.
3. **Sheet:** a schedule he has edited by hand.
4. **Then the older questions** in `areas\TRUST_QUESTIONS_FOR_TIM.md`, merged and most useful first.
