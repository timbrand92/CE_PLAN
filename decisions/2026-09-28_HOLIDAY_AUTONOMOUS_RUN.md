# Holiday autonomous run: Tim's rulings, 28 Sep 2026 (release chat 04)

Context: Tim is on holiday from after Tuesday 29 Sep 2026 for about 4 weeks. He asked how
`CE_ACAD / release-v3-colleagues / build + release / 04` can run on its own to get V3 done while
managing Claude and Codex weekly usage and leaving him room to code elsewhere.

Answers given through clickable choices, 28 Sep 2026 about 17:30 Melbourne time:

1. **Installs while away:** "Yes, my PC only". This chat may install new builds on Tim's own PC,
   with AutoCAD closed, a backup made and the files read back every time. Publishing to colleagues
   still needs Tim's word. This extends the 23 Sep standing override ("from now until tuesday we build,
   test and deploy whenever we need") for the holiday, for Tim's PC only.
2. **Claude usage split:** *(SUPERSEDED for the holiday, 29 Sep 2026: "90%", see the 29 Sep section at the end)* "75% chat, 25% me". This chat uses at most about 75% of each weekly
   Claude allowance. The other 25% is kept for Tim's own work.
3. **Merging:** "Yes, review + Codex pass". A fix may merge to master once a stronger-model review
   AND a Codex pass in real AutoCAD have both passed. Items needing engineering judgement (council values,
   sizing, design rules) still wait for Tim (RULES 4.5).
4. **Codex:** one full AutoCAD test pass a day, about 7% of Codex's week each (Tim's 28 Sep ruling,
   memory `usage-management-scope`).
5. **BUG-189 clue:** asked what ends a slow phase, Tim answered "Waiting a while".

Not yet set up (Claude's list, not Tim's decisions): the daily scheduled start at 6:00 pm, the weekly phone report,
and Tim leaving the PC on, logged in, with sleep off and Windows Update paused.

---

## Tim's standing charter for the release chat, 28 Sep 2026 about 17:45 (verbatim)

> THIS CHAT NEEDS TO:
> * MANAGE CODEX AND CLAUDE WEEKLY USAGE AS A FIRST PRIORITY
> * BE CONTINUOUSLY BUILDING OR MAXIMISE AS MUCH AS POSSIBLE WITHIN THE WEEKLY USAGE PARAMETERS, IT DOESNT MATTER WHICH AREAS ITS WORKING ON
> * IF TIM SENDS A MESSAGE REGARDING SOMETHING ELSE, IT DOEST STOP WHAT IS CURRENTLY BEING DONE AND IT IS ADDED TO THE PLAN AS AN ITEM TO BUILD WHENEVER MAKES SENSE. GIVE TIM A ROUGH TIMELINE/PERCENTAGE TO COMPLETION
> * CONSTANTLY READS, UPDATES AND MANAGES THE PLAN ENSURING THAT WE ARE ALWAYS PROVIDING CONTEXT TO THE NEXT CHAT OR THE NEXT PROJECT
> * MANAGE CONTEXT EFFICIENTLY
> * SHOULD PROVIDE UPDATES TO TIM IN A BRIEF, VISUAL AND EASY TO UNDERSTAND, REAL WORLD EXAMPLES
> * BANKS AS MUCH BUILT ITEMS FOR CODEX TO RUN AT LEAST ONCE DAILY IN A BIG PASS (MANAGING CODEX WEEKLY USAGE WE CASN DO MORE THAN ONE PASS IF NECESSARY)
> * V3 UX PLAN IS PART OF THE OVERALL V3 PLAN AND NEEDS TO BE DELIVERED AT THE SAME TIME
> * PROVIDE A COLLEAGUE READY VERSION FOR OTHER USERS UPON COMPLETION OF V3, WITH CODEX TESTING TO MAKE SURE IT WORKS FOR HUMAN USE AND MAKES SENSE FROM A UX PERSPECTIVE
> * ENSURE TIMos IS UPDATED, READ, LISTENED TOO AND ACTED ON
> * WHILST CODEX IS TESTING BUILD CAN PROCEED
> * DEPLOYMENT CAN BE DONE ANYTIME AT YOUR PEROGATIVE
> * HANDOFFS TO NEW CHAT NEED TO KEEP THESE RULES OR THEY NEED TO BE SAVED IN V3 PLAN TO CONTINUE PROGRESS DOWN THE LINE
> * ENSURE CODE / PLANS ARE WELL WRITTENT O ENSURE THAT BUILDING, INSTALLATING AND DEALING WITH CODEX / CLAUDE AND IT FINIDNG THE CORRECT INFORMATION IS EASY AND CAN BE DONE IN AN EFFICIENT MATTER TO REDUCE USAGE
> * MACHINE LEARN TO GET BETTER AND ENSURE THAT THIS IS WRITTEN INTO THE PLAN FOR CONSTANT EVOLUTION
> * IF IT FINDS A BETTER WAY TO DO SOMETHING OR ONLINE RESOURCE THAT COULD EHLP, MAKE THIS SUGGESTIONS WHEN TIM IS AROUND AS THERE MIGHT BE PERIODS HE CAN WORK WITH YOU WHILST YOU WORK IN THE BACKGROUND
> * IF YOU THINK CERTAIN THINGS NEED UPGRADES, IMRPOVEMENTS OR FEATURE ADDITIONS THEN PLEASE ALSO MAKE TIM AWARE OF THIS
> * ENSURE BUG CARPARK IS UP TO DATE, CONSIDERED AND CONSTANTLY BEING REDUCED TO ENSURE END USER FUNCTIONALITY IS MET
>
> IN REGARDS TO THE SLOWDOWN:
> * WE MUST RESOLVE THIS ISSUE AS A MATTER OF PRIORITY, LETS FIND A BETTER WAY TO ENSURE FUNCTIONALITY STILL WORKS WHILST ENSURING THAT THE PROBLEM IS RESOLVED, IS THERE ANY OTHER AREAS LIKE THIS. I WANT PRODUCTIVITY, SPEED AND RELAIBILITY TO BE THE MAIN FRAMEWORK OF THIS PLUGIN

**Overrides of TimOS RULES.md this creates (RULES 14.6: Tim's word overrides, written down with scope). Scope: the CE_ACAD release chat and its successors, until Tim withdraws it.**
1. RULES 7.1/7.2 (one task per chat, small batches): the release chat builds continuously across areas in daily batches. Tim's testing load stays small because Codex tests the batches (RULES 4.5).
2. RULES 8.7 ("only install when Tim says AutoCAD is closed, deploy"): installs on **Tim's own PC** at the chat's discretion, still only with AutoCAD checked closed twice, no Codex run active, backup, read-back and undo named. **Publishing to colleagues still needs Tim's word.**
3. **Supersedes** the 28 Sep morning ruling that Claude does not manage Codex usage (memory `usage-management-scope`): the release chat now manages both budgets, first priority.

The working version of this charter, turned into procedure, is at the top of `areas/release-v3-colleagues.md` ("Operating charter").

---

## 29 Sep 2026 about 16:20: Tim's answers to plan/05 (clickable choices, `CE_ACAD / release-v3-colleagues / plan / 05`)

Context given to Tim first: Claude weekly at 94% (reset Fri 2 Oct 12:00); about 160 of the ~505 V3 UX plan items appear
in commit messages, about 345 do not; four weeks will not finish all of them properly.

1. **What a colleague gets first:** "Everything first". No colleague copy until every V3 item (V3 plan + V3 UX plan) is
   built and passes. The holiday run builds the whole of V3; the colleague release follows completion and Tim's word.
   (The recommended "Everyday tools first" was NOT chosen.)
2. **Claude allowance while Tim is away:** "90% (Recommended)". The release chat may use up to 90% of each weekly Claude
   allowance during the holiday; 10% is kept for Tim's phone questions. Supersedes the 28 Sep "75% chat, 25% me" for the
   holiday only; 75/25 returns when Tim is back unless he says otherwise.
3. **Colleague publishing while away:** "No, ready for my return (Recommended)". Nothing is published to any colleague
   while Tim is away. The tested copy waits, staged, with a one-page summary for his 15-minute look.
4. **Four pending recommendations, all ticked (approved):**
   1. **BUG-160 pick window:** after letting go of a grip drag on a grade-held pipe end whose bottom level was typed, a
      small window asks "Keep your 10.30 / Use automatic 10.25" (Codex builds the window, Claude the behaviour).
   2. **"Unknown" in the Pit Schedule FROM column** where CE genuinely cannot tell where a pipe comes from (BUG-067 wording stands).
   3. **XCIVIL imported pipes keep their imported levels** at the pit wall; anything suspect is flagged in Project Review,
      nothing changes silently (BUG-065 follow-up).
   4. **Structural wakes by itself** on any Structural command in a Civil drawing, no Yes/No question; CSWAKE by hand
      (PERF-DISCIPLINE-01 Structural side stands as built).

Assumption stated to Tim, not yet confirmed by him: he is back about **Mon 26 Oct 2026**.
The execution queue built from these answers: `areas/release-v3-colleagues-QUEUE.md`.

## 29 Sep 2026 about 17:15: two chats, not one (Tim, verbatim, to plan/05)

> IF I WAS TO LEAVE THIS PLAN TO SONNET 5.5 WOULD IT BE ABLE TO MANAGE IT PROPERLY? MAKE SURE THIS PLAN IS WELL BUILT,
> CLEAR WITH CORRECT RULES AND STRUCTURES, REFER TO TIMOS AS WELL. ALSO WE NEED ONE BUILDING, TERSTING, CODEX LAYOFF
> CONTROLLER AND PROCEEDING TOWARDS THE GOAL, THEN ANOTHER CHAT THAT MANAGES MY IDEAS AND MANAGES ME SO I DONT INTERRUPT
> THE MAIN CHAT AND I TALK TOT HAT INSTEAD OF THE MAIN CHAT, THAT WAY IT DOESNT GET DISTRACTED BY ME AND MY IDEAS,
> SUMMARY MESSAGES AND ANYTHING ELSE

Interpretation (plan/05, not Tim's words): "CODEX LAYOFF" read as "Codex hand-off" (sending work to Codex and taking its
results back).
1. **The controller** `CE_ACAD / release-v3-colleagues / build + release / 06`: builds, tests, runs Codex, installs,
   merges, and moves the queue towards the goal. Tim does not talk to it.
2. **Tim's desk** `CE_ACAD / ideas / plan / 01`: the only chat Tim talks to about CE while the run builds. It takes his
   ideas, bug reports, rulings and questions, sends the summaries, and manages the flow so the controller is never
   interrupted. Charter: `TIM_DESK.md` at the root of this repository.
3. Charter items 3 ("Tim's side messages never stop the work") and 10 ("Tell Tim ...") are now carried out by the desk.
   The controller forwards anything Tim sends it to the desk and carries on.

## 29 Sep 2026 about 17:40: Opus where it is needed (Tim, verbatim, to plan/05)

> CAN YOU MAKE SURE THE FIRMER GUARDRAILS ARE SETUP ENSURING THAT ANYHTING THAT NEEDS OPUS USES OPUS, ALSO DO YOU THINK
> THIS IS THE RIGHT APPROACH?

Built as "The Opus rule", section 4 item 0 of `areas/release-v3-colleagues-QUEUE.md`: a fixed Opus list, a file-path
risk check that decides it (it flagged 14 of the 25 PRs #362-#386), an explicit `model: "opus"` on every call, a stamp
line and PR comment as proof, three hard gates (train contents, install GO, merge), Opus first in the budget, an Opus log
(section 14), and two independent checks (the weekly rules check; the desk's Friday spot-check).

## 29 Sep 2026 about 18:05: Codex tests everything, and the watchdog (Tim, to plan/05)

1. Tim, verbatim: "AT SOME POINT I WANT CODEX TO TEST EVERY BUTTON, TOOL, FUNCTION, SYSTEM, AND USER EXPERIENCE FOR BOTH
   CIVIL AND STRUCTURAL MODULES AND TEST THE MANAGER AS WELL". Built into the queue's section 7: the Civil sweep (C1-C8),
   the Structural sweep (S1-S6), a new Manager sweep (MG1-MG3), a coverage count in every sweep part, and a final full
   sweep of all three modules before the candidate is staged.
2. Tim, clickable: "Yes, daily at 7am" to a daily watchdog task in the Claude app that keeps the run going if the app
   restarts. Found by testing on 29 Sep: a scheduled run is refused when it messages another chat ("Messaging another
   session is unavailable in unattended sessions"), and it stalls on an approval prompt when it writes a file, so it
   cannot take over the work either. The watchdog therefore wakes the controller through the task's own completion
   notice (see the queue, section 3).

## 29 Sep 2026 about 18:10: Temporary middle ground until Wed 30 Sep 5:40pm (Tim, to the desk, via the controller's question)

1. Tim to the controller, verbatim: "CAN WE START THE PROCESS, I NEVER ASKED FOR YOU TO STOP". The controller replied that the run has started and building is held only by the meters (Claude weekly 95% against Tim's own 90% cap; Codex 55% against today's cap of 44%). The desk read the meter itself: Claude weekly 95%, resets Fri 2 Oct 12:00 Melbourne.
2. Tim, verbatim: "SO FOR NOW TEMPORARILY UNTIL WEDNESDAY 5:40PM WHEN BUILDERS START I NEED A SORT OF TEMPORARY MIDDLE GROUND WHERE BUILDING STARTS AND TESTING HAPPENS OVERNIGHT BUT I WILL STILL BE WORKING DURING WORK HOURS, DOES THAT MAKE SENSE?"
   Interpreted (desk, confirmed by Tim's two clicks below): "Wednesday 5:40pm" is Wed 30 Sep 2026, 17:40 Melbourne, tomorrow. Until then, building and Codex testing run overnight and Tim keeps working in AutoCAD in his work hours.
3. Tim's clicks, asked with the risk stated (the meter has 5% left; it could lock him out of Claude until Fri 12:00, including Wed work hours):
   1. **Builders:** "Up to 3 builders, run to the limit". This overrides his own 90% weekly cap (RULES 14.6), scope: from tonight until Wed 30 Sep 17:40 only. The controller stops builders at the limit and keeps Codex going (queue section 10, item 1).
   2. **Installs:** "Only in your free windows". During this middle ground the release chat installs only after 5:30pm, before 8:30am, or 2:00 to 3:00pm, never while AutoCAD is in use.
4. After Wed 30 Sep 17:40 the run continues under the existing charter and the queue's calendar; the 90% cap applies again to Tim's own use.

## 29 Sep 2026 about 21:15: Build until 100% (Tim, to the desk)

1. Situation the desk read at 21:09: Claude weekly 98% (resets Fri 2 Oct 12:00), the controller's last note (19:03) says builders paused at 97%, and no build processes were running.
2. Tim, verbatim, to the clickable question "try builders on Fable, or wait for Fri 12:00?": "i will reset usage once 100% is reached so for now build until 100%".
   Interpreted (desk): the weekly stop line moves from 97% to 100% for now; Tim resets the usage himself when it is reached. Not a Fable ruling: builders stay as they are. Everything else in the 18:10 ruling still holds (installs only in his free windows until Wed 30 Sep 17:40).
3. Supersedes, for the stop line only, the queue's 97% pause of 29 Sep 19:03. Scope: until Tim says otherwise; the desk will ask him again if the meter reaches 100% and he hasn't reset.

## 29 Sep 2026 about 21:40: Four answers to the controller's questions (Tim, clickable, via the desk)

Tim, 29 Sep: "if other chat has questions for me then send them through in this chat". Questions are the queue's section 9, item 1 (numbers as there). All four answers took the recommendation.
1. **Question 1, A6 tolerance:** "Keep 50 mm". The allowance stays at 50 mm (Settings, tagged Assumed).
2. **Question 2, A6 hand-typed levels:** "Leave it out". A level Tim typed by hand is not listed.
3. **Question 5, Structural front door names:** "The S names". Where two typed names do the same job (SDS/TDS, SDS1/TDS1, STS1/TTS1, SC1/TC1), the S names win. CL1/PCL and CR1/PCR stay as both. NOT answered: the Excel pair question (keep the card's long EXCELCAPTURE names or the shortest name); it stays open.
4. **Question 9, what CE learns about a person:** "Yes, all four". (a) Numbers only, on the person's own PC. (b) Kept until the person removes it (they can see it, remove it or everything). (c) Learning starts the day it is switched on, not from old drawings. (d) Pressing Cancel does not count as declining a suggestion.
Still waiting for Tim: questions 3, 4, 6, 7, 8 and the Excel-names part of 5.

## 29 Sep 2026 about 22:15: Answers to questions 10 and 11 (Tim, clickable, via the desk)

Questions are the queue's section 9, item 1, numbers 10 and 11. All answers took the recommendation.
1. **Question 10, Structural units (UX-UNIT, PR #397):** Tim first answered "No, ask me one at a time" to accepting all four, then answered each:
   1. (a) "Window, then base points": a window round the unit's framing, then one base point per target.
   2. (b) "Yes, pick a mirror line": mirrored units use a mirror line.
   3. (c) "A new link group": linked copies get a new group, not the original's beam links.
   4. (d) "Inside each floor's block": unit headings sit inside each floor's schedule block, not replacing the per-floor blocks.
2. **Question 11, CD drawing helpers (UX-CMD/UX-UNDO, PR #398):** "Yes, all three". (a) A Codex probe first on naming the Undo step; if AutoCAD can't, print one plain sentence after each CE Undo ("Undid: <what>"). (b) Size and grade typed at the command line as an option in CD, not in draw-first CD. (c) The glow while pointing starts on pits only until Tim has judged the look, then pipes.
3. Meter, told to Tim: the controller holds new builders at 99% so the Codex run can start at 04:07 Thursday; Opus reviews (#387, #388, #391, #393, #397, #390, #396) wait for Fri 12:00 unless Tim resets usage sooner. Tim said earlier (21:15) "i will reset usage once 100% is reached".
Still waiting for Tim: questions 3, 4, 6, 7, 8, the Excel names in 5.

## 29 Sep 2026 about 22:25: Questions only when the plan doesn't answer (Tim, to the desk)

1. Tim, verbatim: "theres a plan, questions should only be if the chat is unsure against the plan".
2. Meaning (desk, plain): before a chat puts a question in the queue's section 9, it checks the plan (the area file, the card, the decisions, the engineering rulebook). If the plan answers it, the chat follows the plan and does not ask; if the plan is silent or two parts of it disagree, the chat asks. This matches RULES 3.1 ("not for things the plan or the code already answer") and the existing rule "do not ask Tim something the plan already answers, and say which document you checked".
3. What it does NOT change: an unanswered question still never becomes a decision (RULES 3.4), and Tim's word is still needed where the plan itself leaves an engineering value or a privacy choice open.
4. Applies to: the controller, all builders, and the desk. The still-open section 9 questions (3, 4, 6, 7, 8, the Excel names in 5) are to be re-checked against the plan by the controller; those the plan answers are closed with the document named, and only the rest come back to Tim.

## 29 Sep 2026 about 22:50: The four real gaps (Tim, clickable, via the desk)

After INT-006 the controller re-checked section 9 against the plan and closed five questions with the document named (the desk verified one: "Open Hub" retired, `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` line 553). Four real gaps remained (queue section 9, item 12). Tim's answers:
1. **Q3, Structural MEMBER SCHEDULE text (XCLMTXT):** "No, keep 300 and 200". This is AGAINST the recommendation. The text keeps its fixed sizes 300 and 200; do not size it by the other schedules' rule. (BUG-196 residual: the fixed sizes are the accepted behaviour.)
2. **Q6, grip-drag Keep or Automatic (PR #391):** "Yes, on MOVE and STRETCH too". The Keep/Automatic question also appears on a plain MOVE or STRETCH of a pipe with a typed level (recommendation carried: once per pipe, Enter keeps the typed level).
3. **Q7c, Manager status for a module that is not installed:** "Quiet grey".
4. **Q8c, "Keep as a free end":** "This drawing only". Stored in the drawing; the whole-job version is not built now.

## 29 Sep 2026 about 23:10: Nothing stops (Tim, to the desk)

1. Tim, verbatim, after the desk relayed that the controller was holding new builders at 99%: "i never asked for anything to stop".
2. Tim, earlier (21:15, still standing): "i will reset usage once 100% is reached so for now build until 100%". At 22:15 the desk offered three choices for the night; Tim chose "You reset usage now", meaning he resets the weekly usage himself and everything runs.
3. Meaning (desk): no hold. Builders, Opus reviews and Codex all carry on; the controller does not pause anything to protect a meter, because Tim resets it. If the meter reaches 100% before he has reset, the controller tells the desk and the desk tells Tim; the controller does not stop by itself. Desk error, told to Tim: the desk agreed to the 99% hold too quickly on 29 Sep about 22:15, against his 21:15 word.

## 29 Sep 2026 about 23:55: Usage reset, use about 90% by Fri 2 Oct (Tim, to the desk)

1. Tim, verbatim: "usage has been reset, weekly usage resets on oct 2 so you can probably work a little faster to use 90% by that date, then once it resets it goes back to the regular cycle".
2. Verified by the desk at 23:55: Claude weekly 0%, 5-hour 0%, Fable weekly 0%; the weekly window resets Fri 2 Oct about 12:00 Melbourne.
3. Meaning: from now until Fri 2 Oct 12:00 the controller may run faster (up to 3 builders, the Opus reviews first as the Opus rule says) so that the weekly Claude meter lands near 90% at the reset, not sooner (his own 90% cap stands as the stop line) and not far below it (unused usage is wasted at the reset). After the reset the regular weekly cycle and the charter's normal pacing apply. This supersedes the 21:15 "build until 100%" and the 99% hold (both were about running out; the reset removed the problem).

## 29 Sep 2026 about 00:05 (Wed 30 Sep): Sleep instructions (Tim, to the desk)

1. Tim, verbatim: "going to sleep, wake me with the summary, please do not stop building unless i stop you, manage the weekly usage and throttle up/down as possible, before i sleep what percentage are we to the final goal?"
2. **Do not stop building unless Tim stops it.** The controller has standing authority to throttle up or down to keep the weekly meter on the pace plan (about 1.5% an hour, near 90% at the Fri 2 Oct 12:00 reset). It pauses only if Tim says so. Meter troubles go to the desk, not to a stop.
3. **Wake-up summary:** the desk sends the morning summary at 07:27 Wed 30 Sep (a one-shot timer; the desk chose the time, Tim gave none), with one push line.
4. **The percentage:** answered with the checkpoints, not a percentage (RULES 4.1, TIM_DESK 2.2): the next checkpoint is Fri 9 Oct.

## 30 Sep 2026 (just after midnight): Correction, no Codex pass on Wednesday morning (desk error)

The desk told Tim (29 Sep, evening) that a Codex test would run at 04:07 that night. The controller's first message said Codex launches are armed for "Thu/Fri/Sat 04:07", and the desk misread that as Wednesday. The first Codex pass is Thu 1 Oct 04:07; Wednesday's Codex share is spent (55% used against a cap of about 58%; a pass costs about 8%). Tim's wake-up summary must say builders and Opus reviews ran overnight, not Codex. Tim was asleep; nothing he decided depended on this (his reset decision was about the Claude meter, which is right either way).

## 30 Sep 2026 (still Tue night, about 23:15): A Codex pass tonight (Tim, to the desk)

1. Tim, verbatim: "can we do a codex run tongiht also, making sure we manage codex weekly usage?"
2. Read by the desk at 23:10: Codex weekly used 55.0%, resets Sun 4 Oct 04:01 (the queue says 05:01 after daylight saving). The controller had ruled "no Codex on Wednesday" because Wednesday's even share (cap 58%) was spent and a pass costs about 8% (the controller's estimate).
3. Ruling (Tim's word, RULES 14.6): one Codex pass in the early hours of Wed 30 Sep (the queue's early-launch one-shot, 04:07), borrowing from Thursday's share. Sum by the desk: 55% plus about 8% is about 63%; Thursday's cap is about 72%, so a Thursday pass at about 71% still fits; Friday about 79%, Saturday about 87%, leaving about 13% spare. Thin if a pass costs more than 8%. Managing the meter: the pass's STOP line is set by the controller from `daily_cap.sh`, the desk recommends no higher than 66% for this pass (so Thursday keeps a full pass); the run stops at its stop line, closes AutoCAD without saving and copies the logs (queue section 7). Tim's PC: AutoCAD is closed and he is asleep, copies only.
4. Supersedes the queue's W0-3 "Wed 30 Sep: no Codex" for tonight only.

## 30 Sep 2026 (Tue night, about 23:30): A far deeper Codex sweep tonight, stop at 90% (Tim, to the desk)

1. Tim, verbatim: "i reckon there will be a codex reset tomorrow morning, is there anyway that you could get codex to do a massive sweep of the entire plugin tonight? far far deeper than normal". Then, to the clickable question on how sure he is of the reset: "stop at 90% usage, i want you to get codex to test every part of the v3 ux plan and also go above and beyond with other testing, this shouldnt be surface level, tell me what itll do".
2. Facts the desk read (23:13, not confirmed by Tim's belief): the Codex meter reads 55.0% used and says it resets Sun 4 Oct (04:01 or 05:01). The reading is from 14:14, 9 hours old; a manual reset only shows in the next run's reading (`codex_usage.sh fresh-pct` takes a fresh one, which is the controller's job). Tim's belief that it resets tomorrow morning is unverified.
3. Ruling (Tim's word, RULES 14.6): the stop line for tonight is **90% Codex weekly usage** (supersedes the 66% of the 23:15 entry, INT-011). As many back-to-back parts as fit before 08:20 Wed 30 Sep, the free window, with AutoCAD closed and nobody on the PC; coverage far deeper than a normal pass, and every part of the V3 UX plan that is testable plus extra tests. Risk stated to Tim and accepted: if no reset comes, Codex is short or empty for Thu to Sat.
4. Limit told to Tim: Codex can only test what is INSTALLED (Civil 3.0.15, Manager 1.1.15, Structural 1.0.86 at 23:00); the newer V3 UX items (the ~40 draft PRs) are built but not installed, so they cannot be tested tonight unless the controller installs a reviewed train in a free window first; anything not installed is reported NOT TESTED with the reason, per the sweep rule (queue section 7, item 3c).

## 30 Sep 2026 (Tue night, about 23:45): How progress is reported (Tim, to plan/05; relayed to the desk by that chat)

1. Tim, verbatim, as relayed by `CE_ACAD / release-v3-colleagues / plan / 05` (the desk did not hear it directly; it was not found in any file before this entry): "when i ask for percentage its always built, and tested by codex, my plan is to barely test and let codex do that but it needs to be tested well by codex".
2. Rule for every progress answer and the Friday summary: give TWO figures, **Built X%** and **Codex-tested Y%** of the V3 plan (UX items plus open bugs), each an estimate with what was counted (queue ticks, the UX plan card list, PENDING_TESTS, the Codex reports). Do not headline "Tim-accepted 0%". The four words (built, tested, installed, accepted) stay separate in the detail (RULES 4.1); this supplies the two he wants as the headline. This supersedes the desk's "never a percentage" line in TIM_DESK.md section 2.2 for this purpose; the desk gave Tim no percentage at 00:05 and told him so.
3. The controller treats thorough Codex testing (coverage counts, Part Z) as the main quality gate. Tim: he barely tests, Codex does it, so it must be tested well.
4. Tim to confirm the wording when awake; nothing in it is engineering judgement.

## 30 Sep 2026 (Tue night, about 23:55): Codex thinks about the user experience of everything (Tim, to the desk)

1. Tim, verbatim: "get it to also think about the user experience of all of these things".
2. Meaning: tonight's deep sweep (INT-012) must not only test that each thing works; for every command, button, window and message in scope Codex also judges the user experience as a drafter, and reports it as its own ranked list, not a line lost among the fails. The brief already scores wording and clicks; this asks for real UX thinking on every item, including suggestions for how to make it better.

## 30 Sep 2026 (Tue night, about 00:10): Eight answers, C4 and S4 cards (Tim, clickable, via the desk)

Queue section 9, item 13 (C4 card, design and calculations) and item 14 (S4 card, foundations and walls). All eight took the recommendation.
1. **C4 (a) engineer list:** "Office list in Settings". An office list of engineer names on the Settings page, shared with Structural issue; a typed name is marked "typed".
2. **C4 (b) Accept all vs sign-off:** "Built, switch OFF until you sign". Build it; the Pipe sizes group ships behind a Settings switch that stays OFF until Tim signs the sizing rule values.
3. **C4 (c) markup reading:** "Only when a size is stated". "Different" only where the supplied design states a size; everything else "Can't verify", never inferred.
4. **C4 (d) when Design opens:** "Start, During, Finish by tab". Start when no agreed design exists; During whenever one exists; Finish only by its tab.
5. **S4 (a) retaining walls:** "Settings table, Unknown until filled". A Settings table by height band with a "fence on top" column; Unknown until Tim fills it; a real wall calculation later in S5.
6. **S4 (b) fence post footings:** "Settings table, Unknown until filled". By fence type and height.
7. **S4 (c) bar length rounding:** "Settings value, exact until set". Exact length shown until Tim sets the rounding.
8. **S4 (d) bar shapes:** "Straight first, others Unknown". Other shapes Unknown until Tim confirms the office shapes.
Kept from the cards, not a question: CSLOADPATH's "assumed size" pad must NOT be reused for the footing proposal (CE never invents a footing size, ST6-4).

## 30 Sep 2026 07:30: Morning desk note (desk)

1. The desk's 07:27 timer fired. Found: Claude weekly 3% (pace plan about 10% by now), the controller's last activity 00:48, none of its overnight timers ran, and Remote Control on the desk had gone off (the Claude app most likely restarted overnight). The desk sent the controller "WAKE" at 07:30 and switched its own Remote Control back on.
2. Codex overnight: pass 18 finished 05:57 (PASS 47 / FAIL 18 / BLOCKED 21 / NOT TESTED 17 of 103 checks); sweep C1 was running at 07:27 (PASS 9 / FAIL 5 / BLOCKED 4 / NOT TESTED 501 of 519 in scope so far); Codex weekly 81.0% (stop line 90%).

## 30 Sep 2026: Design note, Structural COPY versus the new unit copy (from the controller, Opus-confirmed; recorded by the desk; no question for Tim)

"Structural COPY versus the new unit copy (CSUNITCOPY, PR #402): a plain COPY leaves a copied beam without supports (ST1-14) because it cannot tell which copy came from which original; CSUNITCOPY can, so it links each copied beam to its own copied supports in a NEW link group, which is Tim's 29 Sep answer 'A new link group'. Deliberate difference, Opus-confirmed."
Also for the record: the unit copy command had a real blocker caught by the Opus review (copying a beam would have moved the ORIGINAL unit's supports and text); it is split onto PR #402 and being fixed; the confirmed part of the unit work (PR #397) is unaffected.

## 30 Sep 2026 (Wed, about 08:40): Three answers to items 15 and 16 (Tim, clickable, via the desk)

Queue section 9, item 15 (Structural notes, PR #405) and item 16 (storm frequency on the computations sheet, PR #403). All three took the recommendation.
1. **15(a) master notes library:** "One shared file, path in Settings". One shared file, its path on the Settings page (R-00); an EXAMPLE library ships so nothing is invented.
2. **15(b) STEP symbol (UX-SYM-02):** "Use the office's STEP TAG block". Ship the office's own "STEP TAG" block (Tim's, or the standard details library's), never a CE-invented symbol.
3. **16 storm frequency:** "Fill from the council profile". Fill it from the council profile's sourced storage return period, shown as "from <council> profile" with its source, never silently; otherwise NOT SETTLED until the drafter sets it.
Also read by the desk (not a ruling): Codex sweep C1 finished 08:14 (PASS 11 / FAIL 11 / BLOCKED 5 / NOT TESTED 604 of 631 in scope; incomplete) and its report records one AutoCAD crash (exception 0xc0000005, acad.exe with coreclr.dll, about 07:55, on a scripted COM Document.Close after a SaveAs); the report says correlation, not CE root cause. The controller diagnosed it from the crash file (BUG-224): CE Civil writes project data into the drawing at close, when AutoCAD is already taking it apart; fix started; Codex repeats the close 3 times by script and 3 by X/CLOSE before and after.

## 30 Sep 2026 (Wed, about 09:00): Hourly watchdog (Tim, clickable, via the desk)

1. Tim asked whether the run stopped overnight because the desk asked him questions ("i see why you stopped overnihgt, its cause you asked me questions? is that right? unbelievable i even told you"). Desk finding (evidence: the controller's last commit was 00:48 and its own lesson 13/section 10 say its timers did not fire): NOT the questions. Nothing was waiting on Tim after 00:10 (his last answers were taken and section 9 was empty); the controller went idle at 00:48 and no timer woke it. Desk fault to own: none proven, but the desk's questions between 22:00 and 00:10 did not stop it (the controller took each answer and kept building until 00:48).
2. Tim, clickable, to "May I set up an hourly night-time wake-up task": "Yes, hourly wake-up (Recommended)". Done by the desk: the existing app task `ce-holiday-watchdog` (was daily 07:20) now runs hourly at about 17 minutes past the hour, its completion notice still wakes the controller (the subscription was not touched), the prompt says "if you are already working, ignore". It runs while the Claude app is open; if the app is closed it runs on next launch.
