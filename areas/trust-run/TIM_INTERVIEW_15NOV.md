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

**Older questions answered so far (this file, 15 Nov):** Q5 to Q15, Q17 to Q24, Q32, Q36, Q46. **Q31 asked, not answered as asked.** **Not asked yet:** Q0 to Q4, Q16, Q25 to Q30, Q33 to Q35, Q37 to Q45, Q47 to Q87, and the two added at the end of that file (the template one is now answered by queue item 6; the robot pressing CDLPD's "Continue in drawing" is not).

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

---

## Still to ask in the interview (not decisions)

1. **Starting a job:** what else belongs in the New Job window; whether New Job attaches the architect's xref.
2. **Checking:** where the status line sits on the screen (mock-up owed); whether the plot-time list also shows when the Pit Schedule is placed.
2a. **Reading values from the Pit Schedule (his idea, 02:02; pinned down 02:04 in section 11):** left over: a blank invert with both a schedule value and a pipe to work it out from.
3. **Sheet:** a schedule he has edited by hand.
4. **Then the older questions** in `areas\TRUST_QUESTIONS_FOR_TIM.md`, merged and most useful first.
