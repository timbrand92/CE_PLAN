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

**5.3 Do you also want a quiet status line that is always there? ANSWERED 02:02, see the second entry below. (First asked 01:59: open.)**

- **Tim, Sun 15 Nov 2026 01:59 PC clock, typed instead of clicking a choice:** "think about this more".
- **Choices he was shown and did not pick:** "Yes, quiet, never pops up (Recommended)" (one line always reading '14 pits, 13 pipes, 2 Unknown, 1 warning'); "No, only at schedule and plot"; "Only when something is Unknown".
- **Ask chat's reading (mine):** not an answer. Either he wants time to think, or he wants the idea thought through better before he is asked again. Either way the next step is mine: bring it back with a picture of where the line would sit and what it would say on a clean drawing and on one with problems, then ask again. Until then nobody may treat the status line as wanted or as unwanted by Tim. *(Superseded Sun 15 Nov 2026 02:02 by his answer below.)*
- **Asked again with a picture. Tim, Sun 15 Nov 2026 02:02 PC clock, clicked:** "Yes, as pictured (Recommended)".
- **The picture he saw:** clean drawing: "CE  14 pits  13 pipes   OK". Drawing that needs him: "CE  14 pits  13 pipes   2 Unknown   1 warning   Schedule updated 10:42", amber word plus number, click it to see the list. He was told: it only reads the drawing, never pops up, never changes anything, sits in one fixed place.
- **Choice text he saw:** "on a clean job it reads 'CE 14 pits 13 pipes OK' and you never think about it; with a missing pipe size it shows '1 Unknown' in amber until you fix it. A proper mock-up comes before any build."
- **Not chosen:** "Only when something needs me"; "No line"; "Ask me later".
- **Ask chat's reading (mine):** he wants the always-there line, shown on clean drawings too. Where on the screen it sits was not asked. It is a screen element: a proper mock-up and his OK before any build.

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

**8.3 "The entirety of Civil and Manager", pinned down. THE CURRENT ANSWER FOR "READY FOR COLLEAGUES". Tim, Sun 15 Nov 2026 02:18 PC clock.**

Starts from his own typed words of 02:16 (section 11, Q31): "lets get the entirety of civil and manager working as we intend only then can we release to colleagues". He was shown the 5 Nov small-core decision and his 8.1 answer beside those words, then asked four questions.

1. **How much of Civil?** Tim clicked: "Every tool on the Civil ribbon (Recommended)". Choice text he saw: "all 47 core tools colleagues can click, not just the ten, each seen working in AutoCAD. Typed-only repair tools and unfinished ideas do not hold it up." Not chosen: "Everything Civil, typed tools too"; "The ten, done properly".
2. **Does this replace the 5 Nov "small core first" decision for colleagues?** Tim clicked: "Yes, no small-core release (Recommended)". Choice text he saw: "colleagues keep the CE they have now until the whole of Civil and Manager is ready, then get it in one release." Not chosen: "No, small core still goes first".
3. **What does "working as we intend" mean for Manager?** Tim clicked: "Everything in the Manager plan". **This was NOT the recommended choice** (recommended was "Send, see, and take back"). Choice text he saw: "sending, taking back, the dashboard of every PC, the office setup check and the 'you are behind' notice are all working before the first release." Not chosen: "Send, see, and take back (Recommended)"; "Send only".
4. **Are five clean days and one real job still part of "ready"?** Tim clicked: "Yes, on top of this (Recommended)". Choice text he saw: "once the whole of Civil and Manager works, you still do a clean working week and one real council job on it before the first colleague." Not chosen: "No, working as intended is enough".

**"Ready for colleagues" now reads (ask chat's summary, mine; every line rests on a click above):**

1. **Every tool on the Civil ribbon** seen working in AutoCAD and accepted, not only the ten.
2. **Everything in the Manager plan** working: sending, taking back, the dashboard of every PC, the office setup check, the "you are behind" notice.
3. **Then** five clean working days on his PC and one real council stormwater job start to finish on CE (these two may overlap, 8.2).
4. **Only then** the first colleague, in one release. Until then colleagues keep the CE they have.

**Superseded by this, kept on record:**

1. **The colleague-release half of the 5 Nov 2026 small-core decision** ("colleagues get a small core, Civil first"), superseded 15 Nov 2026 02:18. Ask chat's reading (mine): the small core as the ORDER OF WORK is not touched; the ten are still proven first, one at a time. Only the release of a small core to colleagues is replaced.
2. **8.1 as the whole definition of ready** (01:57 today): it is now item 3 of the list above, not the full list.
3. **Any dated colleague release still on record** (for example the 9 Nov date in the 17 and 20 Oct rulings): his words set a condition, not a date.

**Points of care (mine, not Tim's):**

1. **"47"** in the choice text is the count of core tool notes in `04_REFERENCE\core-tool-notes\`. I did not check that it equals the number of buttons on the Civil ribbon. His click was on "Every tool on the Civil ribbon"; the ribbon is the measure, the number is not.
2. **Which tools are on the ribbon** is itself not settled: older Q37 to Q44 and queue item 8 (ribbon mock-up) are open. A tool taken off the ribbon would leave this list; that must be his choice each time, never a way to shorten the list.
3. **"Everything in the Manager plan"** was described to him by five named parts. The Manager plan file may hold more; anything beyond those five should be shown to him, not assumed in or out.
4. **Structural** was not asked. His 17 Oct ruling holds it to his own PC until ready.
5. **Q31's actual question** (which switched-off features come on) is still unanswered. Asked next.

## 9. What CE must never do by itself

**SUPERSEDED IN PART the same night: all four ticked lines of 9.1 below were replaced at 03:31 by 13.5 and 13.6 (CE does more by itself, marked and easy to override; what he changes by hand stays his). 9.1 is kept as he gave it at 01:57. The three already-ruled points in the bracket still stand.**

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

## 11. Older questions from `areas\TRUST_QUESTIONS_FOR_TIM.md`

Numbers are that file's Q numbers. That file itself is not edited by the ask chat; answers live here.

**Q9. A pipe with no size or material** (today: 100 and UPVC filled in; CDPROPAGATE assumes 225).

- **Tim, Sun 15 Nov 2026 02:02 PC clock, clicked:** "Unknown everywhere (Recommended)".
- **Choice text he saw:** "a line on the pipe layer with no text reads 'size Unknown'; Edit Pipe opens with the boxes blank; CDPROPAGATE stops at it and asks for the size instead of assuming 225."
- **Not chosen:** "Keep 100 UPVC, marked assumed"; "Keep today's fill-ins".
- **Added by Tim in the same sitting (his words, typed under Q12):** "same as last question and apply to first as well". Ask chat's reading (mine): "first" is this question, so his schedule idea under Q10 below applies to pipe size and material too. Engineering judgement, his own word.

**Q10. A pit CE did not place, with no lid class or pit type** (today: "Class C" and "grated pit" from the settings of whoever opens the drawing). **NOT YET A DECISION.**

- **Tim, Sun 15 Nov 2026 02:02 PC clock, typed instead of clicking a choice:** "can you get this information from schedule its always formatted the same way?"
- **Choices he was shown and did not pick:** "Unknown (Recommended)"; "Keep Class C, grated pit".
- **Ask chat's reading (mine):** a question back, carrying an idea: where the drawing has a Pit Schedule, CE should read the lid class and pit type from it, because the office schedule always has the same layout. He did not say what happens when there is no schedule.
- **Honest state, told to Tim:** not known whether CE can read a drawn Pit Schedule today. `areas\trust-run\trust-reader.md` does not mention reading one; the code was not checked by the ask chat. One caution, mine: a schedule CE itself placed earlier may carry CE's own fill-ins (100 UPVC, Class C), so reading it back could turn an old guess into a "known" value. Older Q3 raised the same caution for the test answer sheets.

**Q12. A pit with a blank invert** (today: silently takes the lowest connected pipe invert). **NOT YET A DECISION.**

- **Tim, Sun 15 Nov 2026 02:02 PC clock, typed instead of clicking a choice:** "same as last question and apply to first as well".
- **Choices he was shown and did not pick:** "Keep it, marked worked out (Recommended)"; "Unknown until I confirm".
- **Ask chat's reading (mine):** read the invert from the Pit Schedule too. What happens with no schedule (keep "worked out from the pipes", or Unknown) is not answered.

**Tim's schedule idea, pinned down. Four follow-ups, Sun 15 Nov 2026 02:04 PC clock.** Before answering he was shown a five-box flow picture and this caution: "a schedule that CE itself placed earlier may already carry CE's old fill-ins (100 UPVC, Class C). Reading those back would turn an old guess into a 'known' value."

1. **A value read from the Pit Schedule on the drawing: how sure is it?** Tim clicked: "Proposed, I tick it (Recommended)". Choice text he saw: "P3 has no lid class; CE shows 'Class D, proposed from the Pit Schedule' and it becomes P3's value when you tick it. An old CE guess sitting in a schedule can never slip through as fact." Not chosen: "Taken as fact"; "Fact, unless CE made the schedule".
2. **No Pit Schedule, or the pit is not in it: lid class, pit type and pipe size?** Tim clicked: "Unknown (Recommended)". Choice text he saw: "a hand-drawn pit on a job with no schedule shows lid '?' until you set it, the same on every PC. No Class C, no 100 UPVC made up." Not chosen: "Today's fill-ins, marked assumed".
3. **No Pit Schedule, and a pit has a blank invert?** Tim clicked: "Worked out from pipes, marked (Recommended)". Choice text he saw: "P5 shows 'IL 1.20 (worked out from pipe P5 to P6)'. The lowest connected pipe invert is used, but you can always see it was not typed." Not chosen: "Unknown until I confirm".
4. **The Pit Schedule and the plan label disagree: which wins?** Tim clicked: "Neither: Unknown, show both (Recommended)". Choice text he saw: "'P4 invert: schedule says 9.60, plan label says 9.45. Which?' Nothing is used until you pick." Not chosen: "The plan label wins"; "The schedule wins".

**What this settles (ask chat's summary, mine; each line rests on the clicks above):**

1. **Q9, pipe size and material:** Unknown everywhere, never 100, UPVC or 225. Where a Pit Schedule on the drawing gives the value, it is offered as Proposed for his tick.
2. **Q10, lid class and pit type of a pit CE did not place:** ANSWERED. Proposed from the Pit Schedule where it lists the pit, for his tick; otherwise Unknown. Never Class C or grated pit from a person's settings.
3. **Q12, blank pit invert:** ANSWERED. Proposed from the Pit Schedule where it lists the pit; with no schedule, worked out from the lowest connected pipe and marked as worked out.
4. **Schedule against plan label:** Unknown showing both, until he picks. Same shape as older Q72's recommendation (record against label), which itself is still not asked.
5. **Not decided, not asked:** whether a blank invert that has BOTH a schedule value and a pipe to work it out from shows the schedule proposal, the worked-out value, or both; what CE does when its own worked-out invert disagrees with the schedule.
6. **Not known:** whether CE can read a drawn Pit Schedule today (see the honest state under Q10). Reading one is new work, so under "prove, don't draft" it is a later idea. The parts that need no schedule reading (Unknown instead of 100, UPVC, 225, Class C and grated pit; a worked-out invert marked as worked out) are his word now, and match the existing step 6 draft (pull request 2049) as its questions described it.

**Q11. A pit with no number, and a pipe with no proven flow direction** (today: next free number; drawn order decides upstream).

- **Tim, Sun 15 Nov 2026 02:06 PC clock, clicked:** "Both Unknown, drawn order proposed (Recommended)".
- **Choice text he saw:** "an unlabelled pit shows '?' and is never given a number until you give one; the pipe into it shows 'direction proposed from drawing order' for you to tick."
- **Not chosen:** "Number Unknown, keep drawn order"; "Keep today's behaviour". Engineering judgement, his own word.

**Q8. A label between two pits, both within reach** (today: the nearer one).

- **Tim, Sun 15 Nov 2026 02:06 PC clock, clicked:** "Unknown, show both (Recommended)".
- **Choice text he saw:** "an invert label halfway between P2 and P3 reads 'Unknown: could be P2 or P3' until you pick. 'Nearer' is how labels ended up on the wrong pit."
- **Not chosen:** "The nearer one"; "Nearer, but as Proposed".

**Q7. Where Unknown shows.**

- **Tim, Sun 15 Nov 2026 02:06 PC clock, clicked:** "Not on the plan; '?' in windows (Recommended)".
- **Choice text he saw:** "a pipe with no size has no size label on the plan; the schedule window and check list show '?'. Before a schedule is placed CE warns '3 pipes have no size; the schedule will show ?' and lets you carry on."
- **Not chosen:** "A visible '?' on the plan too".
- **Ask chat's reading (mine):** the status line he approved (5.3) is where an Unknown is visible while drafting; nothing with "?" is drawn on the plan itself.

**Q6. What may be ticked all at once in Check this drawing on an old job.**

- **Tim, Sun 15 Nov 2026 02:06 PC clock, clicked:** "Links together; values one by one (Recommended)".
- **Choice text he saw:** "30 proposed pipe-to-pit links ticked in one click; 12 proposed sizes, levels and pit numbers ticked one at a time, nothing pre-ticked. A wrong size or level is what reaches council."
- **Not chosen:** "Everything at once"; "Everything one by one".
- **Ask chat's note (mine):** "nothing pre-ticked" here is about sizes, levels and pit numbers. In 2.2 the downpipe example showed proposals ticked for him to untick; whether proposed downpipes start ticked is still not asked, so the two do not conflict yet, but it needs one question before any proposal list is designed.

**Q13. A bare line on a pipe layer, in Check this drawing on an old job.** (He was reminded of his queue item 2 answer of 01:47 today.)

- **Tim, Sun 15 Nov 2026 02:07 PC clock, clicked:** "Listed as possible pipes, I tick (Recommended)".
- **Choice text he saw:** "a hand-drawn job shows '22 possible pipes'; each becomes a CE pipe with size Unknown only when you tick it. Nothing enters the record by layer alone."
- **Not chosen:** "Ignored". (The older file's third choice, "a pipe with Unknown size straight away", was not offered again because his queue item 2 answer had already ruled it out.)
- **Ask chat's note (mine):** this settles the two drafts that disagree, as the older file described them: the reader's "possible pipe, Proposed" (pull request 2040) is his answer; the step 6 draft that adds the line to the record with Unknown size (pull request 2049) is not.

**Q14. A pipe's drawn width used as its size.**

- **Tim, Sun 15 Nov 2026 02:07 PC clock, clicked:** "Proposed if it matches a listed size (Recommended)".
- **Choice text he saw:** "a 0.225 wide line in a metre drawing proposes '225, from drawn width' for you to tick. A width that matches no standard size stays Unknown."
- **Not chosen:** "Never use the width"; "Treat it as sure".
- **Not asked:** the 0.5 mm match figure in the older file; that is a number and belongs on the Settings page under his settings-first rule.

**Q15. A drawing whose units were never set** (today: treated as millimetres).

- **Tim, Sun 15 Nov 2026 02:07 PC clock, clicked:** "Ask once, keep in the drawing (Recommended)".
- **Choice text he saw:** "on the first check of an old LISP job CE asks 'Is this drawing in millimetres or metres?' and never asks again for that drawing."
- **Not chosen:** "Assume mm and say so"; "Work it out from the drawing".
- **Ask chat's note (mine):** this sits beside queue item 3 (reaches follow the drawing's units, kept on today). Item 3 covers drawings whose units ARE set; this covers drawings where they are not. The older file says the reader draft (pull request 2040) assumes millimetres; his answer replaces that default.

**Q5. What makes an item "Sure" in Check this drawing.**

- **Tim, Sun 15 Nov 2026 02:07 PC clock, clicked:** "Tag found once, values agree (Recommended)".
- **Choice text he saw:** "pit P3 copied in from last year's job, with a different label, shows as Proposed, not Sure. Sure needs CE's tag used once in the drawing and stored values matching the drawn label."
- **Not chosen:** "The tag alone". ("Tag" was my plain word for what the older file calls CE's stored identity.)

**Q21. A tool needs the LPD and none is drawn yet.**

- **Tim, Sun 15 Nov 2026 02:09 PC clock, clicked:** "Ask me to place or pick it (Recommended)".
- **Choice text he saw:** "CDRENUMBER on a new job asks 'Pick the LPD'. CE never offers the lowest pit as a stand-in, because a stand-in is a guess shown as fact."
- **Not chosen:** "Offer the lowest pit as a proposal".

**Q22. Esc at the LPD question.**

- **Tim, Sun 15 Nov 2026 02:09 PC clock, clicked:** "Carry on with a warning (Recommended)".
- **Choice text he saw:** "the Pit Schedule is still made, in today's order, with one line 'LPD not confirmed, order may differ'. Nothing stops."
- **Not chosen:** "Stop the tool".
- **Ask chat's note (mine):** older Q83 (Esc cancels at CDWT's and CDAGI's questions) is a different case and is not answered by this; here Esc at the LPD question lets the tool carry on.

**Q23. A job with two networks and two discharge points.**

- **Tim, Sun 15 Nov 2026 02:09 PC clock, clicked:** "One per network (Recommended)".
- **Choice text he saw:** "front and rear networks each number and solve from their own LPD, matching two council connections. CE tells them apart by which pits and pipes drain to each."
- **Not chosen:** "One per drawing".

**Q24. An extra marker drawn at the confirmed LPD.**

- **Tim, Sun 15 Nov 2026 02:09 PC clock, clicked:** "Yes, draw a small marker too". **This was NOT the recommended choice** (recommended was "No, my LPD callout is enough").
- **Choice text he saw:** "a small CE symbol sits at the confirmed LPD on its own layer, so anyone can see CE knows it."
- **Not chosen:** "No, my LPD callout is enough (Recommended)" (CE adds nothing more to the plan).
- **Ask chat's reading (mine):** he wants to SEE on the plan that CE knows the LPD. What the marker looks like, its size, its layer name, and whether it plots were not asked. It is something drawn that he will see, so his screen rule applies: a picture and his OK before it is built. The other half of the older Q24 (CDRENUMBER with no outlet pipe asks for the LPD instead of stopping) was in both of the older file's choices and matches his Q21 answer above; my wording put that sentence only under the choice he did not pick, so I am reading it from Q21, not from this click.
- **Note for the builders (mine):** the older file says the TRUST-07 test cases were written for "no extra marker". His answer is newer.

**Q17. CDSYNC and CDREBUILD once Check this drawing exists.**

- **Tim, Sun 15 Nov 2026 02:12 PC clock, clicked:** "Removed once the new door exists". **This was NOT the recommended choice** (recommended was "Typed for me; pointer for colleagues").
- **Choice text he saw:** "typing CDSYNC says 'use Check this drawing' and does nothing else."
- **Not chosen:** "Typed for me; pointer for colleagues (Recommended)"; "Unchanged for everyone".
- **Supersedes:** his 25 Sep 2026 ruling UX-REP-01, which kept both as direct typed commands (as the older questions file describes it). The 25 Sep ruling is kept on record, superseded on this point from 15 Nov 2026.
- **Ask chat's reading (mine):** one door for repairs. "Once the new door exists" means nothing is removed today: CDSYNC and CDREBUILD stay exactly as they are until Check this drawing can do their job and has been accepted. Retiring a command is covered by the standing rule "Retired only with Tim's explicit approval"; this click is that approval in principle, and the moment of removal should still be shown to him.

**Q18. An everyday tool on a drawing that "needs checking".**

- **Tim, Sun 15 Nov 2026 02:12 PC clock, clicked:** "Carry on, say it once (Recommended)".
- **Choice text he saw:** "PIT places the pit and prints 'This drawing needs checking (3 pipes not linked)' once. It never blocks you."
- **Not chosen:** "Ask first each time"; "Say nothing; status line shows it".

**Q19. What one Apply may change in Check this drawing.**

- **Tim, Sun 15 Nov 2026 02:12 PC clock, clicked:** "Only ticked items; upgrade separate (Recommended)".
- **Choice text he saw:** "you tick 30 links and press Apply: one step, one U. Upgrading an old drawing's pipes is always its own Apply, so one U takes back exactly one kind of change."
- **Not chosen:** "Everything ticked, in one go".

**Q20. Unsaved work before Apply.**

- **Tim, Sun 15 Nov 2026 02:12 PC clock, clicked:** "Warn and allow (Recommended)".
- **Choice text he saw:** "'Unsaved work since 10:42 is not in the backup. Carry on?' You choose. CE never saves for you."
- **Not chosen:** "Just say it in a line, no question"; "Save first, then apply".

**Q32. Remembered last-used values between drawings.**

- **Tim, Sun 15 Nov 2026 02:16 PC clock, clicked:** "Never a level; sizes may be (Recommended)".
- **Choice text he saw:** "opening a new job, the cover level box is blank, but the pipe size box still shows the 150 you used last. A carried level is a wrong value shown as fact."
- **Not chosen:** "Nothing remembered"; "Everything, as today".

**Q36. Overflow (OF) and front overflow (FO) splitting the pipe they sit on.**

- **Tim, Sun 15 Nov 2026 02:16 PC clock, clicked:** "Keep the split, say it (Recommended)".
- **Choice text he saw:** "placing FO on the run prints 'FO split pipe P4 to P5 in two', and one U takes back both the symbol and the split."
- **Not chosen:** "Never split"; "Ask each time".
- **Ask chat's note (mine):** this confirms the split is intended, which the tool notes could not find written down.

**Q46. Is the Pit Schedule Excel fault a blocker for the first colleague release?**

- **Tim, Sun 15 Nov 2026 02:16 PC clock, clicked:** "Yes, a blocker until seen working (Recommended)".
- **Choice text he saw:** "no colleague release until Export Excel opens a file with the same rows as the schedule window. The schedule is what goes to council."
- **Not chosen:** "Ship with CSV only and a note".

**Q31. Finished features that are switched off: do any come on in the first colleague release? NOT ANSWERED AS ASKED; he gave a wider ruling instead.**

- **Tim, Sun 15 Nov 2026 02:16 PC clock, typed instead of clicking a choice:** "lets get the entirety of civil and manager working as we intend only then can we release to colleagues"
- **Choices he was shown and did not pick:** "None now; each joins later (Recommended)"; "Turn on the ones I use"; "Turn on all ten".
- **What his words say, read plainly (mine):** nothing goes to colleagues until the whole of Civil and Manager works as intended.
- **What this may change, flagged, NOT decided by the ask chat:**
  1. **The 5 Nov small-core decision** (colleagues get a small core, Civil first; `decisions\2026-11-05_TIM_PLUGIN_STRATEGY_TALK.md`, as `areas\V3_TRUST_PLAN_06NOV.md` line 5 records it). "The entirety of civil and manager" reads wider than a small core. Whether it replaces the small core, or means "the whole of the small core, plus Manager", is not known.
  2. **His own 8.1 answer of 01:57 today** (ready = the ten accepted, five clean days, one real job). His 02:16 words are newer and may add to it or replace it.
  3. **Which switches colleagues get (the question actually asked):** unanswered. One reading is that it falls away: if everything works as intended before release, the features are on because they are intended. That is a reading, not his answer.
  4. **Structural** is not named in his words; his 17 Oct ruling already holds Structural to his own PC until ready.
- **Does not change (mine):** the run's present work. The ten are still proven one at a time; nothing was going to colleagues yet.
- **Asked next:** what "the entirety" covers, and whether it replaces the small core and 8.1.

**Q31, asked again after 8.3: which switched-on features do colleagues get in the one full release?**

- **Tim, Sun 15 Nov 2026 02:20 PC clock, clicked:** "My exact switches, once proven (Recommended)".
- **Choice text he saw:** "a colleague's Pit Schedule comes out in natural order, the same as yours, because each switched-on feature was seen working as part of 'every tool works as intended'. Matches your rule that colleagues get your exact setup."
- **Not chosen:** "Everything off, turned on later".
- **Ask chat's note (mine):** the older file's recommendation ("none now; my trial switches left out of the office setup") was written for a small first release and is replaced by this. "Once proven" is the condition: a switch he runs that has not been seen working does not go out switched on.

**Q57. When Structural reaches colleagues.**

- **Tim, Sun 15 Nov 2026 02:20 PC clock, clicked:** "After Civil and Manager, its own release (Recommended)".
- **Choice text he saw:** "a wrong column size after the Structural release is clearly a Structural fault, not a Civil one, because the two never changed on the same day."
- **Not chosen:** "Same rule, same release"; "Decide later".
- **Not asked:** whether Structural's own release needs the same "every ribbon tool works" test as Civil (8.3).

**Q29. Which values become the office setup.**

- **Tim, Sun 15 Nov 2026 02:20 PC clock, clicked:** "Only the ones that differ (Recommended)".
- **Choice text he saw:** "you see a list of about 30 values where your PC differs from what colleagues start with today, each in plain words, such as 'pipe label height 2.5, colleagues have 2.0'."
- **Not chosen:** "None, take my PC as it is"; "All 570".
- **Owed to Tim:** that list of differences, in plain words. "About 30" and the label heights in the example were illustrations, not counted figures.

**Q30. A colleague's own changes at a release.**

- **Tim, Sun 15 Nov 2026 02:20 PC clock, clicked:** "Replaced after Apply, old kept (Recommended)".
- **Choice text he saw:** "their label height goes back to the office value when they press Apply on the update, and their old file is kept beside it in case it is needed."
- **Not chosen:** "Kept unless they choose".

**Q25. Which tools stop changing CE's record now.**

- **Tim, Sun 15 Nov 2026 02:22 PC clock, clicked:** "Those four stop changing it now (Recommended)".
- **Choice text he saw:** "opening CE Health changes nothing in the drawing, so closing afterwards never asks 'save changes?'. Everyday tools like PIT keep updating the record, with a line saying so." The four named in the question: CE Health, CDGRAPH, CDDIAG, the dashboard.
- **Not chosen:** "Every tool stops now".

**Q26. CDRECOVERINVERTS's hidden first step.**

- **Tim, Sun 15 Nov 2026 02:22 PC clock, clicked:** "Remove the hidden step (Recommended)".
- **Choice text he saw:** "a pipe with no size is skipped with 'size not known' instead of having its inverts recovered from a made-up 100 dia. Matches your 'Unknown everywhere' answer tonight."
- **Not chosen:** "Keep it".

**Q27. What the record line says.**

- **Tim, Sun 15 Nov 2026 02:22 PC clock, clicked:** "One line, guesses counted (Recommended)".
- **Choice text he saw:** "'CE updated its record (PIT): 1 pit added, 1 pipe size filled in as 100.' On the command line, no window, no sound. The guesses are what you most need to see."
- **Not chosen:** "One line, adds and removes only"; "A small window".
- **Ask chat's note (mine):** the example wording was an illustration, not approved wording. Once Q9 is built (no size is ever filled in as 100) the "filled in" part of the line has nothing left to count for sizes; until then it tells him about each guess.

**Q28. The Pit Schedule writing a drawn pipe size back into the record when it opens.**

- **Tim, Sun 15 Nov 2026 02:22 PC clock, clicked:** "Say it in a line (Recommended)".
- **Choice text he saw:** "opening the schedule prints 'CE updated its record (Pit Schedule): 2 pipe sizes read from the drawing.' The write still happens, but never silently."
- **Not chosen:** "Stop the write-back" (shown to him as "closest to 'CE never changes a size by itself'"); "Leave it silent".
- **Ask chat's note (mine):** he chose to keep the write-back with a line even with the stricter choice in front of him. So 9.1 ("CE never changes a level or size by itself, without showing you first") is read as: a size read off the drawing into CE's record, and said in a line, counts as shown. It does not cover changing what is drawn.

**Q49. Who looks after each release.**

- **Tim, Sun 15 Nov 2026 02:24 PC clock, clicked:** "The release chat, I am told". **This was NOT the recommended choice** (recommended was "Me, for the first three").
- **Choice text he saw:** "the chat sends, watches and takes back by its own checks, and gives you one line a day on how it is going."
- **Not chosen:** "Me, for the first three (Recommended)"; "Someone else in the office".
- **Ask chat's reading (mine):** the release chat sends, watches and may take a release back by its own checks; he gets one line a day. Not asked: who a colleague's report goes to first (see Q50), and whether the chat may take a release back without asking him. The choice text said "by its own checks", which I read as yes; worth confirming before the first release, since it acts on colleagues' PCs.

**Q50. How a colleague reports a problem.**

- **Tim, Sun 15 Nov 2026 02:24 PC clock, typed instead of clicking a choice:** "all of above"
- **The three choices he was shown:** "A message to me with the support zip (Recommended)" (Teams or in person: drawing name, what they did, the CESUPPORT zip); "CE's own feedback button" (one button sends the drawing name, what they typed and the zip without leaving AutoCAD; he was told "It does not send yet, so it would have to be built and proven first"); "An email address" (they email a CE support address with the zip).
- **Ask chat's reading (mine):** all three routes are open to a colleague. The message route exists today. The feedback button sending is new work. The email address does not exist yet as far as the record shows; which address was not asked. Under 8.3 ("Everything in the Manager plan" working before release) it is not settled whether the feedback button must work before the first release; not asked.

**Q51. How going back a version is first proven.**

- **Tim, Sun 15 Nov 2026 02:24 PC clock, clicked:** "Trust the Roll Back button". **This was NOT the recommended choice** (recommended was "Rehearsed on a spare login first").
- **Choice text he saw:** "no rehearsal; the button is switched on and first used when a release goes wrong."
- **Not chosen:** "Rehearsed on a spare login first (Recommended)"; "Rehearsed on my PC out of hours".
- **Ask chat's reading (mine):** he does not want a rehearsal exercise; Manager's own Roll Back button is the way back, not renaming folders by hand.
- **A tension I am flagging, not resolving:** at 02:18 (8.3) he chose that "taking back" must be WORKING before the first release. The older questions file says going back has never been tried and the button is hidden and admin-only. A button that has never been pressed is not known to work. Whether the robot may press it once on a spare login or scratch set-up, so that "working" is seen without any rehearsal by Tim, is asked next.

**Q52. How the one full release reaches the office.**

- **Tim, Sun 15 Nov 2026 02:24 PC clock, clicked:** "One colleague, two clean days, then all (Recommended)".
- **Choice text he saw:** "the colleague who drafts drainage most gets it first; after two clean days everyone else moves on the same day, so two people never work one job on different CE versions for long."
- **Not chosen:** "Everyone the same day"; "One at a time, two days apart".
- **Ask chat's note (mine):** the first colleague is described, not named (older Q53 is not asked). The older file's "at most one release a week" was not put to him.

**Q51 follow-up. May the robot press Roll Back once, away from his PC and colleagues' PCs?**

- **Tim, Sun 15 Nov 2026 02:25 PC clock, clicked:** "Yes, robot proves it once (Recommended)". He was told first, plainly: the button has never been pressed, it is hidden today, and an unpressed button is not known to work.
- **Choice text he saw:** "on a spare Windows login the robot installs CE version A, then B, presses Roll Back, and checks file by file that A is back. Nothing from you; you get one line saying it worked or what broke."
- **Not chosen:** "No, first press is a real one"; "Yes, and by hand too".
- **Ask chat's reading (mine):** this resolves the tension flagged under Q51: no rehearsal by Tim, but the button is seen working once by the robot before a real release depends on it. He did not ask for the by-hand way to be proven. Where the "spare Windows login" is (which PC) was not asked; it must not be his own login or a colleague's.

**Q49 follow-up. May the release chat take a bad release back by itself?**

- **Tim, Sun 15 Nov 2026 02:25 PC clock, clicked:** "By itself, then tells me (Recommended)".
- **Choice text he saw:** "a colleague's CE fails to load at 8:45; the chat rolls that PC back within minutes and you get a line: 'rolled back, here is why'. Nobody waits on you to keep working."
- **Not chosen:** "Asks me first"; "By itself only for load failures".
- **Ask chat's note (mine):** this is a standing word for taking a release BACK. It is not a word for sending one; sending anything to colleagues still needs him each time, as the controller's own standing rules say.

**Q53. Who is the first colleague.** *(Ask chat's mistake: this was already on record and should not have been asked cold.)*

- **Already on record:** Tim, 17 Oct 2026, `decisions\2026-10-17_V3_ALIGNMENT_RESET.md` line 224: "lets issue to max on monday 9th novermber"; line 228 records the pilot colleague as "Max" from 8 Oct.
- **Tim, Sun 15 Nov 2026 02:25 PC clock, clicked:** "I will name them". Choice text he saw: "you tell me who (type a first name or role under Other); no name goes in any plan file, only a code." No name was given in this sitting.
- **Not chosen:** "The one who drafts drainage most (Recommended)"; "The most careful one".
- **State:** OPEN. Whether it is still the colleague named on 17 Oct is asked next. The date in that ruling is superseded by 8.3 (a condition, not a date).

**Q54. Seeing what each colleague's PC runs.**

- **Tim, Sun 15 Nov 2026 02:25 PC clock, clicked:** "One row per PC, coded names (Recommended)".
- **Choice text he saw:** "the dashboard reads 'PC-03: Civil 3.0.89, Manager 1.1.89, AutoCAD 2027, office setup yes'. Names are codes in the office folder; the key to who is who stays on your PC only."
- **Not chosen:** "Real names on the dashboard"; "Only on their own PC".
- **Ask chat's note (mine):** a dashboard row is a screen: mock-up and his OK before it is built.

**Q53, asked again: is the first colleague still the pilot named on 17 Oct?**

- **Tim, Sun 15 Nov 2026 02:27 PC clock, clicked:** "Someone else".
- **Choice text he saw:** "you have another person in mind now; type a first name or role under Other and I record it as a code only." He clicked the choice and typed no name.
- **Not chosen:** "Yes, still Max (Recommended)"; "Decide nearer the time".
- **State:** the 17 Oct 2026 naming of the pilot colleague is superseded from 15 Nov 2026 02:27, kept on record. WHO the first colleague is: OPEN, his to name. Nobody may assume a person.

**Q55. What counts as "office setup: yes".**

- **Tim, Sun 15 Nov 2026 02:27 PC clock, clicked:** "Office values match; personal ignored (Recommended)".
- **Choice text he saw:** "a colleague who moved a window or has different recent choices still shows 'yes'. One who changed the pipe label height shows 'no, 1 value differs'."
- **Not chosen:** "Every value, personal ones too".

**Q56, first half. How a colleague finds out a newer CE is approved.**

- **Tim, Sun 15 Nov 2026 02:27 PC clock, clicked:** "CE_VERSION says so, all years (Recommended)".
- **Choice text he saw:** "a colleague on AutoCAD 2024 types CE_VERSION and reads 'A newer CE is approved; ask Tim'. Nothing pops up while they draft."
- **Not chosen:** "A line when AutoCAD starts"; "Only on the dashboard, for me".
- **Ask chat's note (mine):** "ask Tim" in the example was written before he handed releases to the release chat (Q49); the wording of that line is not approved and needs his eye.

**Q56, second half. Do colleagues on AutoCAD 2022 to 2024 get the first release with those on 2027?**

- **Tim, Sun 15 Nov 2026 02:27 PC clock, typed instead of clicking a choice:** "autocad 2027 only for now"
- **Choices he was shown and did not pick:** "2027 first; older years after (Recommended)"; "All years in the same release".
- **Ask chat's reading (mine):** the first colleague release goes to AutoCAD 2027 PCs only. "For now" leaves the older years open: he did not say when, or whether, 2022 to 2024 colleagues follow.
- **What I am NOT reading into it:** that work on the older years stops. The 15 Sep 2026 position on record (2022 to 2024 users are in scope; every batch builds and loads for them too) is not withdrawn by these five words. Whether proving the ribbon tools on an older year may wait until after the 2027 release is a real question and is not answered.

**Q56 follow-up. What "autocad 2027 only for now" means for the work on AutoCAD 2022 to 2024. A RULING THAT CHANGES SCOPE.**

- **Tim, Sun 15 Nov 2026 02:28 PC clock, clicked:** "Stop work on older years". **This was NOT the recommended choice** (recommended was "Keep building for them; prove on 2027 only").
- **Choice text he saw:** "nothing is built or checked for 2022 to 2024 until you say; colleagues on those years stay on the CE they have."
- **Not chosen:** "Keep building for them; prove on 2027 only (Recommended)" (he was shown its reason: "so nothing has to be redone later"); "Prove on both, release 2027 first".
- **Supersedes, kept on record:** the 15 Sep 2026 position that AutoCAD 2022 to 2024 users are in scope and every batch must build and load for them too. Superseded from Sun 15 Nov 2026 02:28 "until you say" (the words of the choice he clicked).
- **Ask chat's reading (mine):** all effort goes to AutoCAD 2027. Colleagues on older years keep the CE they have now and are not part of the first release.
- **Points of care for whoever acts on this (mine, not Tim's, and not asked of him because they are not his kind of question):**
  1. The plugin repository's own procedure (`AGENTS.md`, "verify net48 + net10.0-windows are 0-error") and the test list rule in `START_HERE.md` 1b ("2027 and 2024/net48") still say both. Those texts now disagree with his word and need reconciling by their owners; I have changed neither.
  2. He was told the cost only in one phrase (later rework). If stopping the older-year build can break something he has on his own PC today, that is a fact to check and bring back to him, not to assume either way. I have not checked.
  3. "Until you say" means this comes back as a question after the 2027 release, not never.

**Q53, third ask. Who the first colleague is.**

- **Tim, Sun 15 Nov 2026 02:28 PC clock, clicked:** "I'll tell you later (Recommended)".
- **Choice text he saw:** "it stays open; I ask again when the release is close, and nobody assumes a person meanwhile."
- **State:** OPEN by his choice. Not the 17 Oct pilot. To be asked again when the release is close. From his 02:28 answer above, it will be someone on AutoCAD 2027.

**Q33. Where Manager's own switches live.**

- **Tim, Sun 15 Nov 2026 02:28 PC clock, clicked:** "In the office setup (Recommended)".
- **Choice text he saw:** "a colleague cannot switch Roll Back on for themselves; Manager behaves the same on every PC because the office setup carries its switches."
- **Not chosen:** "Leave them per PC".

**Q48. CLEAN meets an object on a locked layer.**

- **Tim, Sun 15 Nov 2026 02:28 PC clock, clicked:** "Skip it, list it, carry on (Recommended)".
- **Choice text he saw:** "'1 text on locked layer TITLE left as it was. Saved.' CE never unlocks a layer, and one locked title block does not stop the clean-up."
- **Not chosen:** "Stop CLEAN and say why".

**Q83. Esc and Enter at a tool's question.**

- **Tim, Sun 15 Nov 2026 02:30 PC clock, clicked:** "Esc cancels, Enter skips (Recommended)".
- **Choice text he saw:** "pressing Esc at the tank's detention question ends the tank command with nothing drawn, like Esc everywhere else in AutoCAD. Enter still skips that one question and carries on (your 14 Sep ruling)."
- **Not chosen:** "Esc skips, as today".
- **Ask chat's note (mine):** Q22 stands beside this as his one stated exception: Esc at the LPD question lets the tool carry on with a warning.

**Q35. Plastic pits left off the schedule: how loud the note is.**

- **Tim, Sun 15 Nov 2026 02:30 PC clock, clicked:** "Numbered loud, unnumbered quiet (Recommended)".
- **Choice text he saw:** "'6 numbered pits are not scheduled: P3 to P8' in amber; '4 unnumbered plastic pits' as a plain grey count. A loud line that shows on every job gets ignored."
- **Not chosen:** "All in the attention colour" (he was told: "This is how the current draft is built").
- **Ask chat's note (mine):** this bears on queue item 4 (the Pit Schedule's new top line, "3 plastic pits are not in this schedule: none of them has a number…"): by this answer a line about UNNUMBERED plastic pits should be the quiet count, not the attention colour. The wording of the line is still his to see with the screenshot. The older file's third part (pits marked To be removed are not counted as left out) was not put to him.

**Q65. The five trust rules as the gate. ASKED WRONGLY BY THE ASK CHAT; HIS CLICK IS NOT A VALID ANSWER TO Q65.**

- **Tim, Sun 15 Nov 2026 02:30 PC clock, clicked:** "Yes; exceptions signed by me (Recommended)".
- **What he was shown:** "a tool counts as proven only when it passes all five trust rules (right drawing, protections respected, one U, nothing on Cancel, says what changed)".
- **The mistake (mine):** that bracket is NOT the five trust rules. It is the "one door for every change" list from `areas\TRUST_ONE_DRAFTER_CIVIL_DAY_14NOV.md` section 4 item 6. The five trust rules, as written in `areas\TRUST_RULES_CHECKLIST_12NOV.md`, are: 1. nothing changes a drawing without showing you first; 2. everyone runs the same thing; 3. guesses are never shown as facts; 4. you have used it on real drawings; 5. the tool has its note. I checked the file only after he had clicked.
- **What his click does show:** he agrees that the five "one door" points are a gate for a tool, with exceptions signed by him by name. That much is his.
- **State of Q65 itself:** NOT ANSWERED. Asked again with the right five.

**Q66, the percentages part only. What a status message leads with.**

- **Tim, Sun 15 Nov 2026 02:30 PC clock, clicked:** "Three plain counts (Recommended)".
- **Choice text he saw:** "'Ribbon tools accepted: 12 of 47. Days since lost work or a crash: 9. Open problems: 0.' A percentage hid how little was proven."
- **Not chosen:** "Keep the percentages" (shown to him as what he asked for on 29 Sep and 20 Oct); "Both".
- **Supersedes, kept on record:** his 29 Sep and 20 Oct 2026 requests for percentages in every message, from 15 Nov 2026 02:30.
- **Ask chat's notes (mine):** the first count follows 8.3 (ribbon tools, not "tools in the core" as the older file worded it); "47" is the example figure with the same caution as in 8.3. The other two parts of the older Q66 (keep Rule 15, AutoCAD never idle; replace the 17 Oct "switch on once Codex passes" ruling with the trust gate) were NOT asked.

**Q65, asked again with the right five rules.** He was shown the five as written in `areas\TRUST_RULES_CHECKLIST_12NOV.md`: 1. nothing changes a drawing without showing you first; 2. everyone runs the same thing; 3. guesses are never shown as facts; 4. you have used it on real drawings; 5. the tool has its note. He was told plainly that the first ask had listed the wrong five.

- **Tim, Sun 15 Nov 2026 02:32 PC clock, clicked:** "Yes; exceptions signed by me (Recommended)".
- **Choice text he saw:** "a tool that still fills in a guessed 100 dia as if it were fact stays off the ribbon until fixed, unless you sign that tool off by name."
- **Not chosen:** "Yes, with no exceptions"; "I want to change the rules".
- **State:** Q65 ANSWERED. The five trust rules are the gate; any exception is signed by him, by tool name.

**Rule 4 of the five ("you have used it on real drawings"): what it means now.** (New question from the ask chat, because he has ruled that he no longer tests tool by tool.)

- **Tim, Sun 15 Nov 2026 02:32 PC clock, clicked:** "Robot on copies of real jobs is enough". **This was NOT the recommended choice** (recommended was "The clean week and real job cover it").
- **Choice text he saw:** "rule 4 is ticked when the robot has run the tool on copies of your past real drawings, with no step by you at all."
- **Not chosen:** "The clean week and real job cover it (Recommended)"; "I use each tool myself once".
- **Ask chat's reading (mine):** rule 4 no longer needs his own hands on each tool; the robot running the tool on copies of his past real drawings ticks it. This changes "who can tick what" in the checklist file (it gives rule 4 lines 4 and 5 to Tim); that file's owner should reconcile it, I have not edited it. His five clean days and one real job (8.1, 8.3) still stand as a separate condition for release; he was not asked to drop them and did not.
- **Private-data care (mine, binding on whoever does it):** past real drawings are client data. Copies stay on his PC outside every repository; no client name, address or job number goes into any file, log, screenshot name or commit. The standing DATA-01 rule says office project folders are read "only when Tim names the job"; WHICH past jobs the robot may copy has not been asked (older Q2 is still open) and must be his choice.

**Queue item 10 (older-year files out of the build; rule text to match):** answered in the same sitting, recorded in `FOR_TIM_QUEUE.md` under "Answered".

**Q2. Which past real jobs the robot may copy and run the tools on.** (Asked in a new form because of his rule 4 answer and the evidence study. He was told: copies stay on his PC only; no client name, address or job number in any plan file.)

- **Tim, Sun 15 Nov 2026 02:34 PC clock, clicked:** "Any finished council stormwater job". **This was NOT the recommended choice** (recommended was "I pick from a list by type").
- **Choice text he saw:** "the robot may copy any completed stormwater job from the office folder without asking each time, still never writing a name or address anywhere."
- **Not chosen:** "I pick from a list by type (Recommended)"; "The robot picks, I approve the list".
- **What this is (mine):** a standing word. It widens the DATA-01 rule in `START_HERE.md` ("office project folders ... are read for evidence studies only, when Tim names the job") for one class of job: finished council stormwater jobs may be copied by the robot without his naming each one. DATA-01 is otherwise unchanged and its text is kept.
- **Limits that come from his own click and the standing rules (mine to state, binding on whoever acts):**
  1. **Copies only, on his PC, outside every repository and outside OneDrive.** The originals are never opened for editing.
  2. **No client name, address or job number** in any plan file, log, commit, branch, folder name or screenshot name. Jobs are known by a code.
  3. **Finished council stormwater jobs only.** Not live jobs, not other Civil work, and NOT Structural jobs: he was not asked about those. The evidence study's Structural half (12.1, "both structurally and civil") therefore has no job permission yet.
  4. **The ask chat itself still does not open the office Projects folder**; its brief forbids it.
- **Not decided:** the test set of "about 10, messy ones included" from the older file. His answer gives permission, not a chosen set; without his pick nobody knows which jobs were trouble.

**Q1. How many Unknowns one test job may have before CE's reading of it has failed.**

- **Tim, Sun 15 Nov 2026 02:34 PC clock, clicked:** "At most 10% of items". **This was NOT the recommended choice** (recommended was "No number; only ones I agree with").
- **Choice text he saw:** "40 pipes may have up to 4 Unknown sizes; a fifth fails the job."
- **Not chosen:** "No number; only ones I agree with (Recommended)"; "At most 5 per job".
- **Ask chat's reading (mine):** a measurable pass line: more than 10% of items Unknown fails that job's reading. Under his settings-first rule the 10% is a number that belongs on the Settings page, not fixed in a tool. His standing "zero wrong values" ruling for the test jobs is untouched: a wrong value still fails outright; this limit is only about Unknowns.
- **A caution I owe him (mine):** the recommended choice warned that a fixed number can be met by hiding hard items, and the reverse also holds: a truly bare hand-drawn job, where more than 10% of values are simply not on the drawing, will fail through no fault of CE. If that shows up on the first jobs it should come back to him with the count, not be worked around.
- **Not asked:** what "items" counts (pits, pipes, or each value on them). The example counted pipes.

**Q47. Anything missing from the safety list.**

- **Tim, Sun 15 Nov 2026 02:34 PC clock, clicked:** "Nothing to add (Recommended)".
- **What he was shown as "on it now":** two jobs mixed up, CLEAN saving over a template, floor waste Cancel clearing inverts, plastic pits left off the schedule silently, the Excel export.
- **Honest limit (mine):** those five were my summary from the files I had read (the day draft and older Q39 and Q46). I did not read the safety list in card TRUST-04 itself, so I cannot say my five are the whole list. His click means: of what he was shown, nothing is missing from his side. It is not his sign-off of the full TRUST-04 list.

**Q66, remaining part. Does the trust gate replace the 17 Oct "switch on once Codex passes" ruling?**

- **Tim, Sun 15 Nov 2026 02:34 PC clock, clicked:** "Yes, the trust gate decides (Recommended)".
- **Choice text he saw:** "a tool comes on only when all five trust rules are ticked for it; a single Codex pass on its own is no longer enough to switch it on."
- **Not chosen:** "Keep the Codex switch-on" (on his own PC a tool still comes on when Codex passes it).
- **Supersedes, kept on record:** the 17 Oct 2026 ruling (RULINGS B) that a tool switches ON by default once Codex passes it in AutoCAD, from 15 Nov 2026 02:34. Applies to his own PC as well, since he passed over the choice that kept it there.
- **Still not asked from Q66:** whether Rule 15 (AutoCAD never idle when he is away) stays. It stays in force until he says otherwise.

**Q2 follow-up. May the robot also copy finished Structural jobs for the evidence study?** (He was told: same limits, copies on his PC only, no names or addresses anywhere.)

- **Tim, Sun 15 Nov 2026 02:36 PC clock, clicked:** "Yes, any finished Structural job (Recommended)".
- **Choice text he saw:** "the study reads copies of completed framing and bracing plans to learn how beams, columns and brace tags were drawn in past years. Same standing word as for stormwater jobs."
- **Not chosen:** "Civil only for now"; "Only Structural jobs I name".
- **What this is (mine):** the same standing word as Q2, extended to finished Structural jobs, for the evidence study. The same four limits apply word for word (copies only, on his PC, outside every repository and OneDrive; no client name, address or job number anywhere; finished jobs only; the ask chat does not open the folder). The question was framed for the evidence study; whether the robot may also RUN Structural tools on those copies was not asked.

**Q3. Where the "right answer" for each test job comes from.**

- **Tim, Sun 15 Nov 2026 02:36 PC clock, clicked:** "Both; differences flagged". **This was NOT the recommended choice** (recommended was "Plan labels, not the old schedule").
- **Choice text he saw:** "the robot reads the plan label and the schedule row; where they differ, the job shows 'P4: label 9.45, schedule 9.60' for you. Fits your idea of reading the schedule."
- **Not chosen:** "Plan labels, not the old schedule (Recommended)"; "The old Pit Schedule".
- **Ask chat's reading (mine):** consistent with his schedule idea (Q10 and Q12 follow-ups, 02:04): the schedule is a source, and a disagreement with the plan label is shown to him, never settled by the robot. Where label and schedule agree, that value is the answer. Where they differ, the answer for that value is his to give; until then the robot cannot mark CE right or wrong on it.
- **Not asked:** the older file's third source, a print he marks up by hand.

**Q59. BT1 roof bracing trusses in the wall bracing totals. ENGINEERING JUDGEMENT, HIS OWN WORD. No recommendation was given.**

- **Tim, Sun 15 Nov 2026 02:36 PC clock, clicked:** "Count them".
- **Choice text he saw:** "the same wall reads 6700 provided, because the office's own layer name files these trusses with wall bracing. The panel says in one line what it counted." (The case: one 2700 type A brace plus one 4000 BT1 truss, both north-south.)
- **Not chosen:** "Leave them out" (2700 provided); "Show both figures".
- **This reverses a draft:** the older file says the draft under card TRUST-04 (draft pull request 2047) leaves the trusses OUT, with no line saying so, "until you answer". He has answered: they count, and the panel says in one line what it counted. That draft now disagrees with his word.
- **Follows from this, not asked:** older Q78 recommended making the truss rule a Settings value ("Bracing trusses (BT) count toward wall bracing"), set to whatever he answered here. By his answer its value would be yes. Q78 itself is still not asked.

**Q69. A brace with a blank type tag.** (Engineering, his own word.)

- **Tim, Sun 15 Nov 2026 02:36 PC clock, clicked:** "Type '?', panel amber (Recommended)".
- **Choice text he saw:** "a brace pasted from an older job with its tag cleared stops being counted as type A; the bracing panel turns amber, not green, until you give it a type. Same rule as Unknown everywhere in Civil."
- **Not chosen:** "Keep counting it as type A".

**Q78, the truss part. Should the truss rule be a Settings value?**

- **Tim, Sun 15 Nov 2026 02:38 PC clock, clicked:** "Yes, on Settings, set to 'count' (Recommended)".
- **Choice text he saw:** "Settings has 'Bracing trusses (BT) count toward wall bracing: Yes'. If the office ever decides otherwise the value changes and nothing is rebuilt. Matches your settings-first rule."
- **Not chosen:** "Fixed in the tool".
- **Not asked from Q78:** whether the two schedule-row fixes (BUG-497, BUG-498) go in with no off switch. The older file recommended no switch, as fixes to a wrong result.

**Q61. Where the required bracing figures are kept.**

- **Tim, Sun 15 Nov 2026 02:38 PC clock, clicked:** "In the drawing (Recommended)".
- **Choice text he saw:** "opening job B shows job B's required bracing, not job A's, and the same drawing shows the same figures on any PC."
- **Not chosen:** "Keep on the PC".

**Q71. Which way is north-south on the bracing panel.**

- **Tim, Sun 15 Nov 2026 02:38 PC clock, clicked:** "Ask once, keep in the drawing (Recommended)".
- **Choice text he saw:** "you pick one wall line once per drawing; a house drawn at 30 degrees to fit an A3 sheet then gets the same totals as the same house drawn square."
- **Not chosen:** "Use the drawing's axes, say so".

**Q60, the mark-twice part. A support mark that appears twice in the member schedule with different sizes.**

- **Tim, Sun 15 Nov 2026 02:38 PC clock, clicked:** "Ask, showing both sizes (Recommended)".
- **Choice text he saw:** "'C1 is 89 SHS on GROUND and 75 SHS on FIRST. Which?' Every size on the plan is then one you saw or chose."
- **Not chosen:** "Take the first row, as today"; "Match the floor by itself".
- **Not asked from Q60:** the timber stud pack part (DS1 naming a timber size from the schedule but drawing 90 x 90).

**Q70. Old beam links converted when a Structural drawing opens.**

- **Tim, Sun 15 Nov 2026 02:39 PC clock, clicked:** "Move it out of opening (Recommended)".
- **Choice text he saw:** "an old Structural job you open only to print no longer asks 'save changes?' when you close it. The conversion happens when you first use a beam tool, and says so in one line."
- **Not chosen:** "Keep it on opening, say so".
- **Ask chat's note (mine):** "when you first use a beam tool" was my example of where it moves to; the older file only says "move it out of opening, as Civil step 8 does". Where it moves to is a design point for the builders, to be shown to him.

**Q62. SBEAM, which crashed AutoCAD on 5 Nov.**

- **Tim, Sun 15 Nov 2026 02:39 PC clock, typed instead of clicking a choice:** "fix before release"
- **Choices he was shown and did not pick:** "Typed only until proven (Recommended)"; "On the tab with a warning".
- **Ask chat's reading (mine):** the SBEAM crash is to be fixed, meaning reproduced on a copy and shown not to happen, before Structural is released to colleagues. That makes it a release blocker for Structural, in the same way Q46 is for Civil. He did not say where the button sits in the meantime; since nothing Structural reaches colleagues before its own release (Q57), that only matters on his own PC and was not asked.
- **Related, on record, not re-asked:** his 18 and 20 Oct design decisions that CEMEMBER replaces SBEAM. Whether "fix" means fixing SBEAM itself or finishing its replacement is not answered by these three words.

**Q72. CE's record and the drawn label disagree** (the pit-number case).

- **Tim, Sun 15 Nov 2026 02:39 PC clock, clicked:** "Neither: Unknown, show both (Recommended)".
- **Choice text he saw:** "'Unknown: record says P3, label says P4' until you pick. Same answer you gave for the schedule against the label."
- **Not chosen:** "The label wins"; "The record wins".
- **Not asked from Q72:** the other three parts of the older question (oldest block names with nothing of CE's on them are Proposed; the same CE tag on two blocks makes both Proposed; a pit scaled by hand is Unknown in size). The second of these matches his Q5 answer ("tag found once").

**Q84. Start-up checks on the tools that write.**

- **Tim, Sun 15 Nov 2026 02:39 PC clock, clicked:** "Add it to the three that write (Recommended)".
- **Choice text he saw:** "CDTWL on a read-only drawing says so before asking you anything, instead of failing after you have answered its questions." The three: CDRAINFALL, CDTWL, CDRULES.
- **Not chosen:** "Add it to all seven"; "Leave them as built".

**Q62 follow-up. SBEAM or CEMEMBER: which has to be working before Structural goes to colleagues?**

- **Tim, Sun 15 Nov 2026 02:41 PC clock, typed instead of clicking a choice:** "cemember replaces it but make sure the ui window is built for it as per plan"
- **Choices he was shown and did not pick:** "Fix SBEAM's crash now; CEMEMBER later (Recommended)"; "CEMEMBER replaces it before release"; "Both".
- **Ask chat's reading (mine):** CEMEMBER replaces SBEAM, and CEMEMBER's window must be built as the plan describes it; a CEMEMBER without its planned window does not satisfy him. Together with 02:39 ("fix before release") I read: Structural reaches colleagues with CEMEMBER in place of SBEAM, window included. That is closest to the choice "CEMEMBER replaces it before release", but he typed his own words instead of clicking it, so the "before release" part is my joining of his two answers, not one sentence of his.
- **Standing rules that bear on it (not his words tonight):** a new window needs a mock-up and his OK first (his 15 Nov screen rules); by ruling B of 15 Sep, Codex builds windows; and his 18 Oct note says the draft section list stays out of the repository until he has reviewed it. "As per plan" points at the recorded CEMEMBER design decisions of 18 and 20 Oct; I have not re-read them tonight and am not restating them from memory.
- **Not answered:** whether the 5 Nov SBEAM crash still needs reproducing and fixing in the meantime on his own PC. By this answer SBEAM is being replaced, not repaired, for colleagues.

**Q85. CDGRAPH's pipe count.**

- **Tim, Sun 15 Nov 2026 02:41 PC clock, clicked:** "Recorded pipes, stray line named (Recommended)".
- **Choice text he saw:** "CDGRAPH says '49 pipes' and adds '1 line on a pipe layer is not in the record', pointing at it. Matches your ruling tonight that a bare line is not a CE pipe."
- **Not chosen:** "Drawn pipes".

**Q86. "One U undoes it" on CDSYNC and CDREBUILD. NOT ANSWERED; he said something else.**

- **Tim, Sun 15 Nov 2026 02:41 PC clock, typed instead of clicking a choice:** "these tools are confusing"
- **Choices he was shown and did not pick:** "Keep on CDSYNC; drop on CDREBUILD until seen (Recommended)"; "Keep both, as I ruled on 25 Sep"; "Prove CDREBUILD's now".
- **Ask chat's reading (mine):** not an answer about the wording. It is a statement about CDSYNC and CDREBUILD themselves, and it agrees with his Q17 answer of 02:12 (both removed once Check this drawing can do their job). I take it as: do not spend his attention on the fine print of two tools he finds confusing and has already said should go. The 25 Sep wording therefore stays as it is, by default and not by a new ruling, until the tools are retired.
- **Worth more than the question (mine):** "confusing" from the person who uses them is a finding about the tools. Recorded for whoever designs Check this drawing: the repair door must not be confusing in the same way. What exactly confuses him was not asked; asked next.

**Q67. Clicking a pit lights up what it is linked to: where first.**

- **Tim, Sun 15 Nov 2026 02:41 PC clock, clicked:** "In the Check this drawing window (Recommended)".
- **Choice text he saw:** "in the check window, picking P4 highlights its two pipes and its downpipe on the plan. It reuses what the window has already read."
- **Not chosen:** "In the Inspector, no window open"; "Both from the start".

**Q86 follow-up. What is confusing about CDSYNC and CDREBUILD.**

- **Tim, Sun 15 Nov 2026 02:44 PC clock, ticked all four:** "I can't tell which one to use", "I can't see what it changed", "I don't know when I need it", "The names mean nothing".
- **Examples he saw:** something looks wrong and it is not clear which of the two fixes it; a line scrolls past and he cannot tell which pits or pipes are different afterwards; nothing tells him the drawing needs it; "sync" and "rebuild" are software words that do not say what happens to the drawing.
- **What this gives the designers of Check this drawing (mine, as four tests the new door must pass, each from one tick of his):**
  1. **One door, not two:** he never has to choose between repair tools.
  2. **It shows what changed:** which pits and pipes, before anything is written (already his Q19 and 4.1 answers: ticked items, preview, Apply).
  3. **The drawing tells him when it is needed:** the status line he approved (5.3) and the "needs checking" line (Q18).
  4. **A plain name:** no "sync", no "rebuild". "Check this drawing" is the working name on record; whether he likes that name was not asked.
- **Not a decision:** these four are my turning of his ticks into tests. They are his ticks, my wording.

**Q62, second follow-up. Does Structural wait for CEMEMBER and its window before going to colleagues?**

- **Tim, Sun 15 Nov 2026 02:44 PC clock, clicked:** "Yes, Structural waits for it (Recommended)".
- **Choice text he saw:** "colleagues never get SBEAM again; the Structural release happens only once CEMEMBER and its window are built to the plan, proven, and you have OK'd the window mock-up."
- **Not chosen:** "No, CEMEMBER can follow later".
- **State:** this confirms the reading under the first follow-up. CEMEMBER with its planned window, proven, and the window mock-up OK'd by him, is a condition of the Structural release to colleagues. SBEAM does not go to colleagues again.

**Q87. The new pit warning wording for a blank cover level.**

- **Tim, Sun 15 Nov 2026 02:44 PC clock, clicked:** "I see the wording first (Recommended)".
- **Choice text he saw:** "a real AutoCAD screenshot of the warning is put in your queue, like the Pit Schedule line, and it counts only on your OK. Matches your rule that wording you see needs your eye."
- **Not chosen:** "Codex reads it, that is enough".
- **Ask chat's note (mine):** this is the opposite of the older file's recommendation ("accept, Codex reads it"), which was written before his 15 Nov screen rules. He did not object to the behaviour (place the pit and warn, no hard block); only the wording waits on him. Owed to Tim: the screenshot, in the queue.

**Q42. Preset pit size commands.**

- **Tim, Sun 15 Nov 2026 02:44 PC clock, clicked:** "I never use them".
- **Choice text he saw:** "they can go from the ribbon and be left out of the tools that must be proven."
- **Not chosen:** "Typed only, no buttons (Recommended)"; "Buttons on the ribbon".
- **Ask chat's reading (mine):** no preset pit buttons on the ribbon, and they are not among the ribbon tools that must be proven before release (8.3). He was not asked whether the typed commands should be removed altogether; under the standing rule a command is retired only with his explicit approval, so they stay typed until he says otherwise.

**Which machine the robot may use to prove Roll Back once** (follows the Q51 follow-up; touches older Q0).

- **Tim, Sun 15 Nov 2026 03:09 PC clock, clicked:** "Ask me later".
- **Choices he was shown and did not pick:** "The spare work PC (Recommended)" (about 30 minutes of his, once); "A second login on my PC" (out of hours, his own login and CE never touched).
- **State:** OPEN by his choice. The Roll Back proof he approved at 02:25 has no machine yet and waits for one. Nobody may pick a machine for him; in particular a second login on his own PC was offered and NOT chosen.

**Q43. CDCHECKDWG, PITDELETE and CDBREAK.**

- **Tim, Sun 15 Nov 2026 03:09 PC clock, clicked:** "CDCHECKDWG on the ribbon; other two typed". **This was NOT the recommended choice** (recommended was "All three typed only").
- **Choice text he saw:** "you use the consultant drawing check on real jobs, so it gets a button; pit delete and pipe break stay typed."
- **Not chosen:** "All three typed only (Recommended)"; "All three on the ribbon".
- **Ask chat's reading (mine):** CDCHECKDWG is a ribbon tool, so under 8.3 it is one of the tools that must be seen working before the release. PITDELETE and CDBREAK stay typed and do not hold the release up.

**Q40. Which CE tools show on every drawing.**

- **Tim, Sun 15 Nov 2026 03:09 PC clock, clicked:** "CE Tools tab plus CLEAN, levels, text (Recommended)".
- **Choice text he saw:** "on a Structural drawing you still have CE Blocks, Move + Rotate, Copy + Rotate, CLEAN, level marks and the text tools, because none of them carries drainage meaning."
- **Not chosen:** "Only the CE Tools tab as it is"; "I will list them".
- **Ask chat's note (mine):** which commands "the text tools" and "level marks" are, by name, was not listed to him; the list should be shown on the ribbon mock-up.

**Q64, the footings part. Footings when Structural goes to colleagues.**

- **Tim, Sun 15 Nov 2026 03:09 PC clock, clicked:** "Footings included". **This was NOT the recommended choice** (recommended was "Not in the first Structural release").
- **Choice text he saw:** "Structural waits until the footing tools are proven too, so a colleague can take a job from roof to footings on CE."
- **Not chosen:** "Not in the first Structural release (Recommended)".
- **Ask chat's reading (mine):** consistent with his Civil ruling (8.3): the whole thing working before colleagues get it. The Structural release now has at least these conditions from tonight: after Civil and Manager (Q57); CEMEMBER and its window in place of SBEAM; footing tools proven.
- **Not asked from Q64:** tie-downs, wind class and soil report, the hatch button, sheets and issue.

**Queue item 8, the ribbon mock-up: first showing FAILED. NOT ANSWERED.**

- **What happened:** at about 03:15 the ask chat showed a mock-up of the CE Drainage tab in job order as an in-chat picture and asked whether the layout was right.
- **Tim, Sun 15 Nov 2026 03:18 PC clock, typed:** "cant see it"
- **State at 03:18:** queue item 8 still open. The picture did not reach him; my fault for not checking it had. The same mock-up became a file, `04_REFERENCE\mockups\RIBBON_JOB_ORDER_15NOV.html`, sent to him, and the question was asked again.
- **Asked again. Tim, Sun 15 Nov 2026 03:20 PC clock:** he confirmed he could see it ("Yes, the file") and clicked "Yes, OK as shown (Recommended)". Queue item 8 is ANSWERED; the full record, with what is and is not approved, is in `FOR_TIM_QUEUE.md` under "Answered". This also confirms "one tab" below, now given with the picture seen.
- **Honest limit:** I could not view the rendered file myself (the Browser pane does not allow a screenshot of a local file). His "Yes, the file" is the only evidence that it rendered as written.

**One tab or two (CE Design folded into CE Drainage). GIVEN WITHOUT SEEING THE PICTURE; to be confirmed with the mock-up.**

- **Tim, Sun 15 Nov 2026 03:18 PC clock, clicked:** "One tab, as pictured (Recommended)".
- **Choice text he saw:** "Calculations and Council check sit under Check, and Solve a run under Levels, on the same tab as pits and pipes; you never switch tabs mid-job."
- **Not chosen:** "Keep CE Design separate".
- **Care (mine):** the choice said "as pictured" and he could not see the picture. The words of the choice describe the idea fully, so I read it as agreement to one tab in principle; it is not approval of the layout. It touches older Q44 (tab order), which listed CE Design as its own tab.

**Where Edit pit or pipe (CDEDIT) sits.**

- **Tim, Sun 15 Nov 2026 03:18 PC clock, clicked:** "Network, beside Pit and Pipe". **This was NOT the recommended choice** (recommended was "Levels, plus the pop-up tab on pick").
- **Choice text he saw:** "Edit sits right next to the two tools whose objects it edits."
- **Not chosen:** "Levels, plus the pop-up tab on pick (Recommended)"; "First button on the tab".
- **Not asked:** whether the pop-up tab when a pit or pipe is picked stays (older Q44). The mock-up file has been changed to put Edit in Network.

**Q39. Buttons with an open fault that can lose or hide a value (Floor waste, Pit schedule).**

- **Tim, Sun 15 Nov 2026 03:18 PC clock, clicked:** "Off the ribbon until seen fixed (Recommended)".
- **Choice text he saw:** "on your own PC you type PITSCHEDULE meanwhile; each button comes back when its fix has been seen working. Colleagues never see either unfixed, because nothing goes out until everything works."
- **Not chosen:** "On the ribbon with a note".
- **Not asked from Q39:** cosmetic faults (such as the FO symbol reading "OF") staying on with a note.

**Queue item 11** (added by the controller at about 02:40): the same CDRUNSOLVE negative-cover case as item 9, which he answered at 01:59. Not asked again; marked in `FOR_TIM_QUEUE.md`.

**Older questions answered so far (this file, 15 Nov):** Q1, Q2 (permission, not the chosen set), Q3, Q5 to Q15, Q17 to Q33, Q35, Q36, Q46 to Q52, Q54 to Q57, Q59, Q60 (mark twice), Q61, Q62 (his words), Q65, Q66 (all but Rule 15), Q67, Q69 to Q71, Q72 (pit-number case), Q78 (truss part), Q83 to Q85, Q87, Q39 (data faults part), Q40, Q42, Q43, Q64 (footings part). **Q86 asked, not answered as asked ("these tools are confusing"; his four reasons are recorded).** **Count: 66 of the 87 have an answer in whole or in part; 5 held for the evidence study.** **Q53 open by his choice ("I'll tell you later"): not the 17 Oct pilot.** **Held back for the evidence study (12.2):** Q16, Q73, Q80 to Q82. **Not asked yet:** Q0 to Q4, Q33 to Q35, Q37 to Q45, Q47 to Q56, Q58 to Q72, Q74 to Q79, Q83 to Q87, and the two added at the end of that file (the template one is now answered by queue item 6; the robot pressing CDLPD's "Continue in drawing" is not).

---

## 11a. Mock-ups shown and his choices (Sun 15 Nov 2026)

Rule: a mock-up OK is approval of the picture. It is not a go-ahead to build, and the real thing in AutoCAD still needs his eye when it exists.

**The ribbon in job order:** file `04_REFERENCE\mockups\RIBBON_JOB_ORDER_15NOV.html`. OK'd 03:20. Full record in `FOR_TIM_QUEUE.md`, item 8, under "Answered".

**Three more, one file:** `04_REFERENCE\mockups\STATUS_LINE_LPD_MARKER_PLOT_LIST_15NOV.html`. He did not pick "Can't see it" on either question that offered it, and chose between lettered pictures, so I take it that the file showed. I could not view the rendered file myself.

1. **Where the status line sits** (follows 5.3). Tim, Sun 15 Nov 2026 03:25 PC clock, clicked: "B: top left of the drawing". **This was NOT the recommended choice** (recommended was "C: bottom left, above the command line"). Choice text he saw: "always in view at the top, near the view controls; it sits over the drawing but never plots." Not chosen: C; "A: right end of the CE Drainage tab". What the picture showed: a small pill at the top left of the drawing area reading "CE 14 pits 13 pipes OK" (green word) on a clean drawing, and "CE 14 pits 13 pipes 2 Unknown 1 warning Schedule updated 10:42" (amber words) on one that needs him.
2. **The marker at the confirmed LPD** (follows Q24). Tim, 03:25, clicked: "A: ring with a dot (Recommended)". Choice text he saw: "a small ring sits exactly on the discharge point beside your own LPD callout; it marks the point without adding words to the plan." Not chosen: "B: triangle pointing out"; "C: boxed 'LPD' tag"; "None of these". Not asked: its size, colour and layer name. The blue in the picture was for the picture only; under his colour rule a marker colour would need a meaning, or it takes the layer's colour.
3. **Does the LPD marker print?** Tim, 03:25, clicked: "No, screen only (Recommended)". Choice text he saw: "you see it while drafting so you know CE has the LPD, but the council print shows only your own LPD callout." Not chosen: "Yes, it plots".
4. **The list when plotting with open warnings** (follows 5.2). Tim, 03:25, clicked: "Yes, OK as shown (Recommended)". What the picture showed: a small card, "Before you plot", the big figure "2 warnings", one row per warning with an amber "Needs you" pill, the item, the figure found in bold and the figure required ("P4 cover 280 under 300 mm"; "P6 to P7 fall 0.8% under 1%"), "Click a row to zoom to it", and two buttons: "Show me" (the main, blue one) and "Plot anyway". Not chosen: "Right idea, change it"; "Can't see it".

**Still owed as pictures (not yet drawn):** the dashboard row per PC (Q54); the New Job window (1.1); the CEMEMBER window (which has its own recorded design and is Codex's to build).

---

## 12. Tim's own ideas raised in this chat (his words; not decisions, not builds)

**12.1 Teach CE and Claude what old drawings are made of, from the evidence model.**

- **Tim, Sun 15 Nov 2026 02:12 PC clock, typed while answering the old-drawing questions:** "can we not through the evidence model teach the plugin and or claude what old drawings are made up of and how they work? both structurally and civil"
- **What the record shows (checked by the ask chat, 02:13):** the evidence model exists as a design, `03_DRAWING_INTELLIGENCE\EV-03_EVIDENCE_MODEL.md`, and covers Civil and Structural; it is written to learn "the whole local arrangement, not an isolated block", and it says "Frequency alone can never promote a drafting pattern into an engineering rule". The trust run's drawing reader does not use it: `areas\trust-run\trust-reader.md` and `OLD_BLOCKS_FOUND.md` never mention the evidence model, and the older questions file says the reader's distances and text patterns came from CE's own starting figures, the old blocks found on 13 Nov and made-up jobs.
- **Not known (not checked):** how much of the real evidence has been gathered and cleared for use; the ask chat is not allowed to open `C:\CE_DrawingIntelligence`.
- **Ask chat's reading (mine):** he is asking why CE's rules for reading old drawings are being guessed and put to him one by one (Q13 to Q16, Q72, Q73, Q80 to Q82) when his own past drawings could show what the office actually drew. That is the purpose the evidence model was designed for. Whether to do it, when, and how a learnt pattern becomes a rule are his to decide and are asked next.

**12.2 Three follow-ups on 12.1. Tim, Sun 15 Nov 2026 02:13 PC clock.** Before answering he was told: the evidence model is a written design; the trust run's reader rules were written by hand and do not use it; how much real evidence is gathered and cleared is not known to this chat; and a common pattern never becomes an engineering rule without his word. He was shown a five-box picture: past drawings, the evidence model finds patterns, patterns shown to him in a batch, then on his tick into the office setup and into notes Claude reads.

1. **Who should learn from the old drawings?** Tim clicked: "Both CE and Claude (Recommended)". Choice text he saw: "CE reads an old job and proposes 'IL text 2.2 m along the pipe belongs to this pipe end' because your old jobs show that. Claude reads the same patterns before changing a tool, so it stops guessing how the office drew." Not chosen: "CE only"; "Claude only, for now".
2. **How does a pattern become a rule CE uses?** Tim clicked: "Shown to me in batches, I tick (Recommended)". Choice text he saw: "'On 40 of 46 old jobs the invert text sits within 2.5 m of the pipe end. Use 2.5 m?' with a picture of three real cases. Nothing is used until you tick it." Not chosen: "Used as Proposed straight away"; "Only for things I named".
3. **When?** Tim clicked: "Now, reading only, beside the ten (Recommended)". Choice text he saw: "a side chat studies the evidence and writes up patterns while the ten tools are still being proven; no tool changes until the ten are done and you have ticked the patterns." Not chosen: "After the ten are proven"; "Now, and build it into the reader".

**What this is (ask chat's reading, mine):**

1. **Approved by Tim:** a reading-only study of the evidence, starting now, beside the ten, for Civil and Structural (his 12.1 words: "both structurally and civil"), writing up patterns for him to tick in batches.
2. **Not approved:** any change to a tool, the reader or the office setup from those patterns before the ten are done and he has ticked the pattern. "Prove, don't draft" is unchanged.
3. **Still binding on whoever does the study:** the private-data rules (no client name, address or job number in any repository; the evidence folder's own privacy classes), and the evidence model's own line that frequency alone never makes an engineering rule.
4. **Not decided:** which chat does the study, and how many patterns make a batch. The ask chat does not start it; the controller has been told his words.
5. **Effect on the older questions (mine):** Q16, Q73 and Q80 to Q82 ask him for distances and text patterns from memory. They are better answered by the study with pictures of real cases than asked cold, so the ask chat holds them back unless he wants them now.

**12.3 Tim's direction for the whole product. HIS WORDS, typed Sun 15 Nov 2026 03:27 PC clock, unedited:**

> i want to type or input things once and that is saved everywhere and i want to make the way we do the design of this plugin smarter, more efficient and well designed, considering all aspects of design and drawing standards whilst presenting a well considered and consistent platform that is easy to use for all levels of ability and experience
> the issue i have now with the plugin is it feels complex and feels like it was built by ai with no considerarion for how its used by humans, the logic to things is over complicated and rough for the end user so they dont know what to use and when its fomplex. think about this make it a key focus in the plan and think about and interview me as to what the final product in its entirety should be with manager, strucutral and civil. i want you to do your best first and then interview me. consider how we have lots of commands that could just run automatically but considered well. understand how the whole process of desigm and drafting works and what the best way to help automate and improve the quality, speed and process of it all
> how many questions left?
> tell me when were done with questions so i can go to bed
> https://griffinwooldridge.com/ai-for-designers

**What he asked for, listed (ask chat's reading, mine):**

1. **Type once, saved everywhere.** A value entered in one place is never asked for again anywhere else.
2. **A key focus in the plan:** the plugin must stop feeling complex and "built by ai with no consideration for how its used by humans". Users must know what to use and when.
3. **One consistent platform** across Manager, Structural and Civil, easy for every level of ability and experience, respecting design and drawing standards.
4. **Fewer commands to run by hand:** many could "just run automatically but considered well".
5. **Understand the whole design and drafting process** first, then automate to lift quality, speed and process.
6. **Method:** the ask chat does its best first, then interviews him.

**The page he linked** (read 03:28; it is a sign-up page for a guide that is not out yet): its argument is that AI output looks generic "because the model is working blind", and that the fix is not the prompt but giving the model real references, the design rules, and a way to check its own work. Ask chat's reading (mine) of why he sent it: the same three things for CE: his real drawings as references (the evidence study, 12.2), his screen rules and the Design Guidebook as the rules, and looking at the real screen before calling anything done. I did not join the waitlist or enter anything on the page.

**The ask chat's best-first draft** is `areas\trust-run\FINAL_PRODUCT_DRAFT_15NOV.md`. It is a DRAFT for the controller to fold into the one plan on Tim's word; it is not a second plan and nothing in it is decided until he says so. His answers to the interview on it are in section 13 below.

---

## 13. Interview on the whole-product draft (`FINAL_PRODUCT_DRAFT_15NOV.md`)

Before these he was shown, in the chat: the problem in numbers (145 Civil commands, 47 buttons, 35 checks and repairs, about 7 things a drafter does), the one-job-record picture, the seven rules, a before and after (145 commands to know about; about 43 buttons in 6 panels, about 10 needed on a simple job, 1 Check door), and what the ask chat does not know yet.

**13.1 Do the seven rules describe the product you want?**

- **Tim, Sun 15 Nov 2026 03:30 PC clock, clicked:** "Yes, make them the plan's focus (Recommended)".
- **Choice text he saw:** "before any tool is kept or built, it is checked against the seven: does it ask for something already typed? Does its name say what it does? A tool that fails does not get a button."
- **Not chosen:** "Mostly; something is missing"; "Not quite right".
- **The seven as he saw them:** 1. Type once (council, job details, rainfall, datum, sheet size and revision go in at New Job; nothing asks again). 2. The ribbon is the method (left to right is the job, for Civil and, roof down, for Structural). 3. Few buttons, plain names (named for the thing, never for the software). 4. CE does its own housekeeping, and says so in one line. 5. One place to look, one place to fix. 6. Never guesses, never surprises. 7. Same look, words and behaviour across Civil, Structural and Manager.
- **State:** his word that the seven are the plan's focus. Folding them into the one plan is the controller's to do; this file is the record, not the plan.

**13.2 Which things do you enter more than once today?**

- **Tim, Sun 15 Nov 2026 03:30 PC clock, ticked all four:** "Job details for the title block", "Council and rainfall", "Levels and sizes", "The same across Civil and Structural".
- **Examples he saw:** job number, site address, client, drawn by and revision typed on each sheet, then again in the schedule heading or the calcs; the council picked for the rules, again for rainfall, again in the calculations; a pit's cover level in the pit window, then typed again on a label, in the schedule or the long section; on a job with both, the address, job number and revision entered once in the drainage drawing and again in the structural one.
- **Ask chat's reading (mine):** all four kinds of double entry are real for him. He added nothing under Other. These were my examples of where it might happen; the exact places each value is asked for today have not been listed from the tools and should be, so "type once" can be checked off place by place.

**13.3 Which test decides what CE does by itself?**

- **Tim, Sun 15 Nov 2026 03:30 PC clock, typed instead of clicking a choice:** "more automatic but with ability for overridding easily"
- **Choices he was shown and did not pick:** "Changes nothing I drew, undoable, says so (Recommended)"; "More automatic: also propose and apply levels" (CE works out an invert when a pipe joins a pit and writes it, with a line and one U); "Less automatic: always ask".
- **Ask chat's reading (mine):** he wants CE to do more by itself than my draft's cautious test allowed, and wants overriding a result to be easy. His wording is closest to the second choice, with easy override added.
- **A tension I am flagging, NOT resolving:** at 01:57 tonight (9.1) he ticked that CE must never, by itself and without showing him first, change a level or size, renumber pits, move or delete his labels, or change layers or colours; and at 01:53 (4.1) he chose preview first, then Apply, for solved levels. "More automatic" may reach into those. Which of the two wins for levels, sizes and pit numbers is asked next. Until he answers, 9.1 stands as written.

**13.4 How this fits with "prove, don't draft".**

- **Tim, Sun 15 Nov 2026 03:30 PC clock, clicked:** "Build it alongside the ten now". **This was NOT the recommended choice** (recommended was "Design it now on paper; build after the ten").
- **Choice text he saw:** "'prove, don't draft' is lifted for this work and builders start on the simpler layout straight away."
- **Not chosen:** "Design it now on paper; build after the ten (Recommended)"; "Stop the ten; redesign first".
- **What this is (mine):** his word lifting "prove, don't draft" (his rule of 14 Nov) FOR THIS WORK: the simpler, human-first design of the whole product. The ten continue alongside; he did not choose to stop them.
- **What it does not lift (standing rules he did not touch tonight):** a new or changed screen still needs a mock-up and his OK first (his 15 Nov screen rules; he used that rule four times tonight); nothing merges into shipped lines or goes to colleagues without his word; installs on his PC stay under his existing standing approval for trial batches; the five trust rules are still the gate (Q65, tonight).
- **Not decided:** what is built first. Asked next.

**13.5 "More automatic, easy to override" against the "never by itself" list: levels and sizes.** He was shown his 01:57 answer and his 03:30 words side by side first.

- **Tim, Sun 15 Nov 2026 03:31 PC clock, clicked:** "CE fills them in, marked, I can overtype (Recommended)".
- **Choice text he saw:** "you join a pipe to P4 and CE writes the invert it works out, shown as 'worked out' in the pit window. Type over it and yours sticks for good; CE never changes a value you typed. One U takes any of it back."
- **Not chosen:** "Keep preview then Apply for all levels"; "Fully automatic, re-solves as I draft".
- **Supersedes, kept on record:** the "Change a level or size" line of 9.1 (01:57 tonight), from 03:31. New rule in his click: CE may fill in a level or size by itself, always marked as worked out; a value he typed is never changed by CE.
- **Not settled (mine):** 4.1 (01:53: preview first, then Apply, when he asks CE to solve a run) and 7.1 (moving a pit offers the level preview). He passed over "re-solves as I draft", so I read: CE fills a BLANK level when it can; it does not re-work levels already there without the preview. That reading needs his confirmation before anything is built on it.

**13.6 The same for pit numbers, his labels and his layers.**

- **Tim, Sun 15 Nov 2026 03:31 PC clock, clicked:** "All automatic, all overridable". **This was NOT the recommended choice** (recommended was "No, those stay mine").
- **Choice text he saw:** "CE renumbers, tidies labels clear of each other and sets layers as it goes; anything you then change by hand is left alone afterwards."
- **Not chosen:** "No, those stay mine (Recommended)"; "Numbers automatic too".
- **Supersedes, kept on record:** the "Renumber pits", "Move or delete my labels" and "Change layers or colours" lines of 9.1 (01:57 tonight), from 03:31. So all four lines of 9.1 are now superseded by 13.5 and 13.6. The three things he was told were already ruled stay: CE never saves for him, never unlocks a layer, never changes a drawing just by opening it.
- **The one rule that replaces 9.1, as his two clicks put it (my wording):** CE does it by itself; what CE did is visible and easy to change; **whatever he changes by hand is his from then on and CE leaves it alone.**
- **Tensions I am flagging, NOT resolving (each needs a question before a build):**
  1. **Q11 (02:06 tonight):** a pit with no number stays Unknown "and is never given a number until you give one". Automatic renumbering would give it one. Which holds for a pit that has never had a number?
  2. **Renumbering after the schedule is on the sheet or the job has been issued:** pit numbers on a council submission changing by themselves is the kind of thing that "reaches council". Not asked.
  3. **How CE remembers "this one is mine":** the standing record already has "Manual/Pinned" as a state. Whether a hand-changed number, label or layer shows a mark, and how he hands it back to CE, was not asked.
  4. **"Sets layers as it goes"** against the native protection rule: CE still never unlocks, thaws or edits a locked layer or an xref's layers. He was not asked to change that and did not.

**13.7 The Structural tab in the same shape as Civil.**

- **Tim, Sun 15 Nov 2026 03:31 PC clock, clicked:** "Start, Roof, Upper floors, Ground, Footings, Check, Sheet (Recommended)".
- **Choice text he saw:** "a colleague starts at the left with the job details, works roof down as you do, runs the bracing and schedule checks, then sets up the sheets. Same idea as the Civil tab you OK'd."
- **Not chosen:** "By kind of member instead"; "Show me a mock-up before I answer".
- **State:** the panel names and order are his. Which tool sits in which panel has not been drawn or shown; a mock-up file like the Civil one is owed before it is built. This replaces the older draft panels (Roof, Floors, Bracing, Tools) in older Q63, which was not asked.

**13.8 What is built first.**

- **Tim, Sun 15 Nov 2026 03:31 PC clock, clicked:** "Type once: the New Job record (Recommended)".
- **Choice text he saw:** "one New Job window takes the job details, council and sheet size once; the title block, rainfall, rules and calcs all read it. It removes the double entry you ticked and everything else builds on it."
- **Not chosen as first:** "The one Check door"; "The ribbon in job order"; "The automatic housekeeping". They are not rejected, only later.
- **Next step that is owed before any build (his screen rule):** a mock-up of the New Job window, and the list of every place each job value is asked for today.

**End of the sitting, 03:31.** Tim asked to be told when the questions were done; he was told.

---

## Still to ask in the interview (not decisions)

1. **Starting a job:** what else belongs in the New Job window; whether New Job attaches the architect's xref.
2. **Checking:** where the status line sits on the screen (mock-up owed); whether the plot-time list also shows when the Pit Schedule is placed.
2a. **Reading values from the Pit Schedule (his idea, 02:02; pinned down 02:04 in section 11):** left over: a blank invert with both a schedule value and a pipe to work it out from.
3. **Sheet:** a schedule he has edited by hand.
4. **Then the older questions** in `areas\TRUST_QUESTIONS_FOR_TIM.md`, merged and most useful first.
