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

## 30 Sep 2026 (Wed, about 12:15): Usage note and three answers (Tim, to the desk)

1. **Usage, Tim, verbatim:** "1. theres some of my own usage in there, so manage how youre using it and i will work within the 10% buffer  2. 5 hour window is fine  i can answer questions now if you need". Meaning: the weekly meter includes Tim's own Claude use, so the controller paces on the METER READING (not on its own spend); the 90% target for Fri 2 Oct 12:00 stands and Tim's own use lives inside the last 10%; the 5-hour window is not a constraint to protect.
2. **Kingston storm frequency (queue section 9 item 17, PR #413):** "5 years, with source (Recommended)". Kingston residential jobs use 5 years, shown with its source (council document K02); an office ruling is not a council source. This supersedes the 4 Sep ruling's stored 10 for residential (kept, marked superseded 30 Sep 2026); commercial stays 10 per K02.
3. **Move My Settings folder name (M-SET-01):** "CE Settings Transfer (Recommended)". A folder named `CE Settings Transfer` in the user's OneDrive for Business, in one constant; Documents is the fallback. It is no longer "assumed"; Tim chose it.
4. **Move My Settings who sees the button:** "Everyone (Recommended)". Every staff member sees Move My Settings on the Manager tab.

## 30 Sep 2026 (Wed, about 13:45): A second worker on Tim's Claude Team account (Tim, to the desk)

1. Tim, verbatim: "if i have a claude team account premium how can i get it to work in the same way on the same task, simultaneously as you" ... "whilst i am away you can both work no?" ... "Team chat is open". Clickable: "Yes, start with no prompts (Recommended)".
2. What was set up (desk): a launcher `Claude Team.cmd` on Tim's real Desktop (`C:\Users\TimothyBrand\OneDrive - Creative Engineering\Desktop`) starts a second Claude Code (2.1.185) in its own settings folder `C:\Users\TimothyBrand\.claude-team` (only the global CLAUDE.md copied), with `--permission-mode bypassPermissions` so it works unattended. Read by the desk: that folder's account is organisation "Creative Engineering", type claude_team, billing stripe_subscription (not the main app's account); its usage meter and reset day are unknown until the chat reports them.
3. Its brief: `C:\CE_PLAN\CHAT_PROMPT_TEAM_LANE_01.md` (name `CE_ACAD / release-v3-colleagues / build / 01`): safe default lane until the controller names one is independent read-only Opus review of open draft PRs; it owns one file, `areas/release-v3-colleagues-TEAMLANE_LOG.md`; hard limits as the run (own worktree, SkipDevBundle, never install/merge/Codex, one build at a time at Below Normal, never stops).
3b. Unknown, not filled: whether that program can message the controller; the brief says to use files if it cannot.

## 30 Sep 2026 (Wed, about 14:00): Kingston 5 years confirmed, and where land use is set (Tim, clickable, via the desk)

1. Controller's measurement (relayed, not re-measured by the desk): on CE's 14 issued sheets, 1 in 5 gives 26 to 30% less storage than the issued sheets (which used 1 in 10). Example given to Tim: an issued 10 m3 tank would come out about 7.2 m3.
2. Tim, clickable: "Yes, 5 years stands (Recommended)". Confirms the 12:15 ruling (Kingston residential 5 years with source, K02). Older issued sheets are not changed.
3. Tim, clickable, where land use (residential or commercial) is set per job: "Job setup, one Land use field (Recommended)". One "Land use" field in job setup (CDSETUP) that CDCALC reads; nothing filled in for the drafter; until set, the sheet says NOT SETTLED for councils where it matters. A Kingston job that is actually commercial then uses 10 years per K02.

## 30 Sep 2026 (Wed, about 14:20): The desk manages the Team worker (Tim's word overrides the desk charter, scope stated)

1. Tim, verbatim, after being asked to paste a start prompt into the black window: "CAN YOU MANAGE IT NOT ME?"
2. Override (RULES 14.6), scope: the desk chat may LAUNCH, WATCH and RELAUNCH the Team-account worker as a hidden non-interactive Claude Code run (`claude -p`, model opus, `--permission-mode bypassPermissions`, started from the Team settings folder, Below Normal priority) using `C:\CE_PLAN\CHAT_PROMPT_TEAM_LANE_01.md`. This departs from TIM_DESK.md section 9 item 2 ("never dispatch builders") for this one worker only. The desk still never builds, installs, merges or runs Codex itself; the worker's own limits (own worktree, SkipDevBundle, never install/merge/Codex, one build at a time) are unchanged.
3. Started 14:15 (PID recorded in the desk's notes); its lane is Structural S4 slices 1 and 2 (queue section 0A). Tim's open interactive window on the Team account is left idle and can be closed.
Correction (desk, same day): the section above is stamped "about 14:20" and says "Started 14:15" from the desk's own guess of the clock; the real Melbourne clock read 13:50 when the worker started (process start 13:50:29). The worker's first log line also says 14:20 because the desk's start prompt gave it that wrong time; its later lines use the file times.

## 30 Sep 2026 (Wed, about 14:15): The Team worker restarted watchable; the Team meter (Tim, via screenshot and one click)

1. Tim sent a screenshot of the Team account's usage page (about 14:08): Current session 3% used, resets in 4 h 34 min; Weekly, all models 0%, resets Sat 1:00 PM; Weekly, Fable 0%, resets Sat 1:00 PM. So the Team account's week ends Sat 3 Oct 13:00 (not Fri 12:00 like the main account).
2. Tim, clickable, to whether he could watch the worker in the Team account's browser: "Restart it watchable (Recommended)". Done by the desk at 14:12: the hidden run was stopped and a visible interactive Claude Code was started on the Team account with Remote Control (`--remote-control "CE Team lane 01"`), Below Normal, bypassPermissions, resuming from the same working copy (`s4sch`, branch `claude/s4-schedules`). NOT verified by the desk: that it appears at claude.ai/code on the Team account (Tim to check). If its window is closed the desk restarts it.
3. Pacing for the Team worker: aim near 90% of the Team weekly by Sat 3 Oct 13:00 (about 1.3% an hour from now if it starts at 0%); it reads its own usage with /usage now.

## 30 Sep 2026 (Wed, about 14:35): The Team worker does not show in the browser, and why (desk finding)

1. Tim, verbatim, with a screenshot of his first (idle) black window where he had typed "Team": "NOT SHOWING IN BRIWSERE".
2. Desk finding, read from the Team account's own settings folder (`C:\Users\TimothyBrand\.claude-team\policy-limits.json`): the organisation policy for the Team account says `allow_remote_control: allowed false` (and `remote_control_at_startup: false`). So the worker cannot appear at claude.ai/code until the organisation setting is changed. The worker itself is alive and working (process 14816, its session file still growing at 14:12, working copy `s4sch`). Changing an organisation setting is Tim's (he is the organisation's primary owner), not the desk's.
3. Until then, the worker is watched through its log file, its PRs on GitHub and the desk's process checks; the visible window on the PC still shows it working.

## 30 Sep 2026 (Wed, about 14:20): Remote Control switched on for the Team organisation (Tim)

Tim, verbatim: "REMOTE CONTROL IS ON". Desk check: the Team account's `policy-limits.json` was refreshed at 14:19:52 and no longer lists `allow_remote_control: false`. The desk restarted the Team worker twice (resume of its own session `39370bc7-277f`, working copy `s4sch`, Remote Control on, Below Normal, bypassPermissions); the first restart had no prompt and would have sat idle, so it was relaunched with a "carry on" prompt (final worker PID 25088 at 14:20). Not yet verified by the desk that it appears in the browser at claude.ai/code (Tim to look for "CE Team lane 01").

## 30 Sep 2026 (Wed, about 15:10): The desk manages everything and all the usage (Tim)

1. Tim, verbatim: "CAN YOU MANAGE EVERYTHING FROM HERE NOW?" and "WILL YOU MANAGE TEAM WORKER USAGE AS WELL AS YOURSELF AND CLAUDE". Answer given: yes, all three meters.
2. Scope: (a) the main Claude account (desk, controller, builders, Tim's own use in the last 10%): target near 90% at Fri 2 Oct 12:00, read with `get_usage`; (b) the Team account (the Team worker): the desk can read it itself with `claude -p /usage` from the Team settings folder; at 15:07 it read session 5%, week 1%, resets Sat 3 Oct about 13:00; target near 90% by then (about 1.3% an hour), so it is far under pace and the desk asks the controller for more Team-lane work or starts a second Team worker (total builds across both accounts stay at 3); (c) the desk's own use: kept small (no sub-agents, batched checks). Codex meter as before.
3. Standing check: the app task `ce-desk-hourly-check` (created 15:06, hourly at about 54 past) wakes the desk each hour, like the controller's watchdog. It only runs while the Claude app is open.
4. Unchanged: the desk still never builds, installs, merges or runs Codex itself; Tim's override for the Team worker (launch, watch, relaunch) stands.

## 30 Sep 2026 (Wed, about 15:25): A second Team worker as the reviewer (controller's request, desk started it under Tim's "manage everything")

The controller (real clock 15:23) asked for a second Team-account worker as an independent read-only REVIEWER (queue section 0B; name `CE_ACAD / release-v3-colleagues / review / 01`; own log `areas/release-v3-colleagues-REVIEWLANE_LOG.md`; builds nothing, so it uses no build slot; self-polls open PRs every 10 minutes). The desk wrote its brief `C:\CE_PLAN\CHAT_PROMPT_TEAM_REVIEW_01.md` and started it (visible, Remote Control name "CE Team review 01", Below Normal, bypassPermissions) under Tim's "CAN YOU MANAGE EVERYTHING FROM HERE NOW?" (15:05). It shares the Team account's meter with Team build worker 1. Limits as worker 1: read-only, never installs/merges/Codex.

## 30 Sep 2026 (Wed, about 16:10): Codex reset and free rein on the PC after work (Tim)

1. Tim, verbatim: "I WILL USE A RESET TOKEN FOR CODEX AND WHEN I FINISH TODAY YOU HAVE FREE REIN TO USE MY COMPUTER TO TEST AS MUCH AS YOU NEED WITHIN THE USAGE LIMITS" (spelling as typed: "FREE REIGN").
2. Meaning (desk, plain): Tim resets the Codex week himself (a reset token), which takes Codex from 84% back to about 0%; he will tell the desk when it is done, and the controller takes a fresh reading (`codex_usage.sh fresh-pct`) before launching. From when Tim finishes work today (his own words: "when i finish today"; the desk's reading of his free window: after 17:30) until he says otherwise, the run may use his PC for as many Codex tests as it needs, back to back, within the usage limits. The Codex stop line stays 90% of the weekly usage (his 30 Sep 00:00 ruling) unless he says otherwise; the Claude side keeps its own pacing (near 90% at Fri 2 Oct 12:00).
3. What "free rein" still does NOT allow (unchanged rules): Codex works on copies only, never opens an office file in place, closes AutoCAD without saving, restores the profile check, never approves/publishes/installs/rolls back from a test; installs stay the controller's (hard blocks unchanged); nothing of Tim's private data is touched (`C:\CE_DrawingIntelligence` never).
4. Consequence for the plan: Codex can only test what is installed, so the reviewed train should be installed first (a free window after 17:30, controller's discretion under the holiday charter), then the sweeps run back to back overnight.

## 30 Sep 2026 (Wed, about 16:20): Codex builds too, drain to 100% before the flight (Tim)

1. Tim, verbatim: "CAN YOU GET CODEX TO DO SOME BUILDING AS WELL, I NEED TO GET IT TO 100% USED BEFORE MY FLIGHT TONIGHT AT 8:15PM". Flight: tonight 20:15 (Melbourne).
2. Meaning (desk): Tim wants the Codex weekly usage taken from 84% to 100% before he leaves for the flight, then he uses his reset token (he must do that himself, before he leaves) so the new week is fresh for the holiday. Codex can spend usage NOW without touching AutoCAD by BUILDING (the "W, windows" lane: Codex builds the XAML windows from Claude's contracts through `queue3.sh`, queue section 3 lane W and section 7). For this drain only, the Codex stop line is 100% (supersedes 90%). After the reset, the 90% line applies again to the tests overnight.
3. Sequence: (a) Codex builder jobs now, low priority, own working copies, no AutoCAD; (b) at 100% the desk tells Tim; (c) Tim resets before he leaves (his action); (d) the controller takes a fresh Codex reading; (e) after Tim has left the PC free, the reviewed train is installed and the sweeps run overnight (INT-021).
4. Open: what time Tim leaves for the airport (asked).

## 30 Sep 2026 (Wed, about 16:30): Finish time and the PC stays on (Tim, clickable)

1. Tim closes AutoCAD for the day at "About 5:30pm" (Wed 30 Sep). The install (needs AutoCAD closed) can start after that: earliest about 18:00, then the Codex tests once Tim has used his Codex reset token and a fresh reading is taken.
2. The PC stays on, signed in and connected while Tim is away: "Yes, on and signed in".
3. Controller's plan (16:21, relayed): train candidates being built now, Civil+Manager `claude/rel-20260930t1` (33 PRs) and Structural `claude/rel-20260930t1-struc` (10 PRs); left out on purpose: #414, #427 and #433 (no Land use window field yet), #424 and #425 (Manager settings tool, Tim-only tests), #437; full suites after 17:30, then Opus sign-off, version bump, package, install, hash check. Note: #427 (Kingston 5 years) is the release-gate item Tim ruled on; it waits for the Land use field.

## 30 Sep 2026 (Wed, about 16:35): Codex model for building and spare usage (Tim)

Tim, verbatim: "IN FUTURE IF WE NEED TO BUILD WITH CODEX OR HAVE SPARE WEEKLY USAGE THEN WE CAN USE GPT SOL 6.1". Meaning: for Codex BUILDING, and whenever Codex weekly usage is spare, use the model Tim calls "GPT Sol 6.1". The three Codex builders launched at 16:23 run on `gpt-6-sol`; the controller confirms the exact Codex model identifier for "GPT Sol 6.1" (the desk does not guess it) and uses it for the next launches.

## 30 Sep 2026 (Wed, about 16:45): Codex command-line update approved (Tim, clickable)

1. The controller could not find "GPT Sol 6.1" (codex-cli 0.156.0 lists gpt-6-astra, gpt-6-sol "previous generation", gpt-6-luna, gpt-5.6-sol/terra/luna, gpt-5.5).
2. Tim, clickable: "Yes, update it (Recommended)": the controller may update the Codex command-line tool on his PC in a free window (after 17:30 while AutoCAD is closed), check Codex still works, then look for Sol 6.1 again. Tim also picked "I'll type the name in Other" for the exact model name but no name arrived with the answer: the exact name is STILL UNKNOWN; the desk asks him to type it. Builders stay on gpt-6-sol meanwhile.

## 30 Sep 2026 (Wed, about 16:50): The exact Codex model name (Tim, screenshot of his Codex app)

Tim sent a screenshot of the Codex app's model picker: the model reads "GPT-6.1 Sol" (mode "Light", effort slider, "Select effort"). So the display name is **GPT-6.1 Sol**. The command-line slug is NOT shown and is not guessed (a likely form is `gpt-6.1-sol`, unverified); the controller finds it after the CLI update. Builders stay on `gpt-6-sol` until then.

## 30 Sep 2026 (Wed, about 19:40): Codex reset done, Tim unreachable for about 24 hours (Tim)

Tim, verbatim: "codex usage reset ill be on the plan for the next 24 hours" (read by the desk as "on the plane": his flight left at 20:15 Wed 30 Sep). So: (1) the Codex usage reset was done by Tim at about 19:40; the controller takes the fresh reading (`codex_usage.sh fresh-pct`) and notes the new week's reset time; the desk has not verified the number; (2) Tim cannot be reached until about Thu 1 Oct evening; questions wait (the desk asks only what the plan does not answer, and holds them); (3) unchanged: free rein on the PC (INT-021), Codex stop line 90% on the fresh week, the Claude pace plan near 90% at Fri 2 Oct 12:00 (Team worker: Sat 3 Oct about 13:00), installs by the controller with the hard blocks.

## Fri 2 Oct 2026 about 07:22 — desk answer to controller 06: install C-6 now

Controller proposed installing Civil 3.0.21 / Manager 1.1.21 (b4e075d8, Opus-finalized GO) now, skipping a separate adversarial pass so Codex can start verifyC6. Desk answered YES (desk interpretation, not Tim's words; Tim has no ruling against it). Conditions: Tim's install rules unchanged (AutoCAD closed twice, backups, hash verify, Structural untouched); the known mm-drawing Pit Schedule grade label 1000x goes in the install note and verifyC6 as an expected FAIL case and is fixed before colleagues/Tim see it; the C-6 adversarial reviews are DEFERRED to after the 12:00 weekly reset, not waived. For Tim's return page: he may want to say whether that deferral was acceptable.

## Fri 2 Oct 2026 about 14:20 — Tim answered four parked questions (clickable, Tim's chosen options in quotes)

1. **INT-025 Template units:** "Yes, some are" — some office Civil templates are UNITS = Metres with millimetre-size pits. So the mixed-units hold-and-warn guard (BUG-338, C-7) is needed, not optional; which templates is still to be named.
2. **INT-026 Structural footings in a non-mm drawing:** "Convert units automatically" — NOT the controller's current build (refuse with one plain line). Supersedes parked item 4f's recommendation. Desk read: convert and carry on, with one plain line saying it converted (R-27: warn and record, no hard block).
3. **INT-027 Palette edit when CDRUNSOLVE/CDPROPAGATE is cancelled:** "Accept the rollback (Recommended)" — Cancel returns to before the command, edits included (BUG-311 stays as built).
4. **INT-028 Beam linking OOPS:** "Keep the confirmation line (Recommended)" — one question first; beam linking is off by default.

## Fri 2 Oct 2026 about 15:40 — Friday summary: Tim answered three more parked questions

1. **INT-029 CDDESIGN buttons:** "Yes, all five tabs (Recommended)" — Save Draft and Confirm on all five tabs (Setup and Results gain them).
2. **INT-030 17-degree wall landing:** "At the pit centre" — landing sits exactly on the pit centre.
3. **INT-031 Which templates are Metres with mm pits:** "Ask Codex to read them on copies" — Codex reads the template units from COPIES (never the originals) and reports; fits inside the combined pass if budget allows, else the next Codex window after the Wed 7 Oct reset. Desk read: Codex-read-only, no edits.
Friday checks done at 15:21-15:30: installed DLLs Civil 3.0.21 / Manager 1.1.21 / Structural 1.0.90 (read); Codex PASS S4-04 in CODEX_VERIFYS4 report; #484 merged 1 Oct into claude/rel-20261003a (master unchanged since 28 Sep); Opus stamps present on #494/#480/#481 (claude-opus-5-5). Figures last counted Wed 30 Sep: Built 42% (273/657), Codex-tested 3% (18/657); controller asked for a fresh count.

## Sat 3 Oct 2026 about 00:50 — Tim asked about testing AutoCAD through a GitHub MCP/CLI

Tim: "how hard would it be for you to test autocad with a cli or dcp from github?" (read as MCP). Desk found several open-source AutoCAD MCP servers (descriptions only). Tim's answers: 1. "a" (yes, vet it read-only, no download or install) and asked for it to be an Opus agent with a brief summary of findings; 2. "a" (if it passes vetting, ask him before installing).
- **INT-032:** vetting by an Opus agent, read-only; report at C:\Lisp Files\_TEST_COPIES_20260923\MCP_AUTOCAD_VETTING_2026-10-03.md.
- **INT-033:** NO install without asking Tim first; test copies only; never his real drawings or settings.

## Sat 3 Oct 2026 about 01:05 — Tim: Codex could use the MCP and its own screen driving, with Claude / the Team chat testing too

Tim: "i was thinking we could get codex to use the mcp and its own depending on what its testing whilst you can also test or the team chat".
- **INT-034 (design direction, not an install approval; INT-033 still applies):** split the test lanes by what is being tested. (1) Typed-command / U-REDO / data checks go through the MCP (once vetted and Tim says install); (2) CE windows, palettes, ribbon clicks stay on Codex's screen driving; (3) headless accoreconsole probes (no UI, parallel-safe) stay with Claude / the Team chat. Desk caution recorded: ONE interactive AutoCAD session at a time on the PC (one real profile, shared settings files; the S4 "occupied" run showed the collision), so interactive testers (Codex screen, MCP by Codex, MCP by Claude) take turns through the controller's schedule; only the headless lane runs alongside. To check after vetting: that Codex (CLI 0.159.2) can load the chosen MCP server.

## Sat 3 Oct 2026 about 01:35 — Tim: licence is not a worry; use/modify/mix whatever is best

Tim: "dont worry about it, even though its for our business its for my personal testing only so dont worry about it, lets use and modify it as we need. or you can mix the two or you can use whatever you think is best."
- **INT-035:** licence concern waived by Tim for personal testing; desk chooses the approach. Desk decision (not Tim's words): do NOT download and run third-party code on Tim's PC even with the licence waived (standing safety rule: no downloading or executing files from sources we have not read line by line). Instead a Sonnet agent READS the MIT acad-cmd source and the christiannp design notes and WRITES our own small driver, a PowerShell CLI (`acad_driver.ps1`) in C:\Lisp Files\_ACAD_DRIVER (outside every repo): typed command, history, GETVAR/SETVAR allow-list, open/new/closeonly, path guard to test copies only, deny list for save/export/purge, LOGFILEMODE restore. CLI first (works for Claude and Codex through a shell); wrap as an MCP later only if Codex needs it. INT-033 (ask before any install) stands for anything beyond this own-authored tool. First supervised run in a real AutoCAD 2027 on a test copy comes after the build, when Codex is not driving AutoCAD.

## Sat 3 Oct 2026 about 03:20 — desk rulings on the S7 footing-units card (Tim reviews on return)

The Team build worker's card S7_FOOTING_DRAW_UNITS_CARD section 8 asked the desk four things (all follow Tim's INT-026 "Convert units automatically"): 1. mixed-units hold wording: ACCEPTED "Check what the drawing is really drawn in (LIST one footing) before changing anything" (no UNITS advice); 2. PFC / SF / THC DO convert (no retirement without Tim's command review); 3. depth stays millimetres in the record (a schedule number, never drawn): confirmed; 4. CSPIER centres keep picking, a picked distance read as drawing units, no typed-only restriction. These are desk interpretations, not Tim's words; listed for his return.

## Sat 3 Oct 2026 about 05:25 — Tim: "can we upgrade our mcp to work on the ui windows as well"

- **INT-036:** Tim asked to extend the own-authored AutoCAD driver (C:\Lisp Files\_ACAD_DRIVER) so it can also drive CE's own windows. Desk reading: yes, through Windows UI Automation (the accessibility tree, built into Windows; no third-party code), separate from the typed-command COM path. Sonnet driver agent building it with deny lists (never Save/Delete/Purge etc.), acad.exe-only windows, test-copy rule for writes, offline tests on a toy window. A supervised mapping session (UI_MAP_PLAN.md) follows to record the control names of the CE windows. No install of anything beyond our own script.

## Sat 3 Oct 2026 about 05:30 — Tim: Codex reset expected today or tomorrow

Tim: "codex should get a reset today or tomorrow". Desk: the Wed 7 Oct 20:52 reset date is OPEN (earlier reset possible). Controller told to have the window-only Codex pass ready, check the meter fresh at most every 2 hours, treat a reading below about 30% as reset, install any pending build first, then run the pass; 90% stop line and a reserve of about 10 points for the last two days of the new window unchanged.

## Sat 3 Oct 2026 about 16:35 — Tim: restart the Codex testing (recorded by desk plan/02)

Tim, verbatim, in the old desk chat (plan/01) about 16:20: "you can fire up the codex testing again". The desk plan/02 read this in the old desk's transcript before passing it on. Meaning: restart the Codex mouse pass (verifyW2b) from the first unfinished item, 20-point ceiling, skipping the real hover (Codex cannot hover) and the CPU read (invalid while a computer-control tool is attached; the old desk will run a clean test later). Controller told "Tim agreed" at 16:35. Codex BUILD run stays paused until C: free is above 20 GB (12 GB at 16:30). Finding to follow up: idle AutoCAD used about 1 core while Codex computer-control was attached and 0.03 without (possible cause of Tim's lag).

## Sun 4 Oct 2026 about 06:30 — Tim answered four typed questions (desk plan/02; Tim's words verbatim, then the desk reading)

Tim, verbatim: "fedit yep click outlien edit / revert row override i think stop overriding / pipe landing, pit wall / pit numbers , yes"

1. **INT-042 FEDIT (BUG-380 / BUG-355 item 1):** "fedit yep click outlien edit". Desk reading: YES, clicking the outline (edge) of a pad or strip with FEDIT edits that pad or strip; CE no longer answers "That is a CE outline, not a footing". Where CE cannot tell which pad or strip the outline belongs to, it says so plainly and changes nothing (R-27, no hard block). Needs the usual command card (review gate) before code ships; the answer is the intended result.
2. **INT-043 Revert Row Override (BUG-386):** "revert row override i think stop overriding". Desk reading (interpretation, marked as such): the menu item is renamed to say what it does, "Stop overriding"; its behaviour (the row stops being tracked as an override, the typed value stays, one U undoes it) stays as built. NOT "put the original value back". If Tim meant the opposite he will say so on return.
3. **INT-044 Pipe landing (#544):** "pipe landing, pit wall". Desk reading: a new pipe end lands on the pit WALL (inside wall), as in his 29 Sep ruling "Snap automatically + note". This SUPERSEDES INT-030 (30 Sep/3 Oct: "At the pit centre", superseded 4 Oct 06:30 by Tim). PR #544 (pit-centre landing) is therefore NOT to be merged; it is dropped.
4. **INT-045 Pit numbers (BUG-351 a):** "pit numbers , yes". Desk reading: YES, keep the number exactly as typed (C2 stays C2, not PC2). Applies to the Pit Schedule and every place a typed pit number is stored or shown.

## Sun 4 Oct 2026 about 07:00 — Tim answered the five remaining typed questions (desk plan/02; verbatim, then the desk reading)

Tim, verbatim: "BUG 351B - ONLY CHANGE THAT END / SETTINGS WINDOW - YES / PASTE - YEP / #547 - SHOW IN THIS CHAT PLEASE / CONFIRM LPD BUTTON - WHATEVER YOU RECOMMEND"

1. **INT-046 BUG-351 (b):** "ONLY CHANGE THAT END". Desk reading: a level typed in the Pit Schedule on a pipe with a FIXED grade changes only that end (how schedule edits have always worked); the far end is NOT moved to keep the grade. Open design point for the builder (not a Tim question): the label then still reads the typed grade (1 IN 100) while the levels give about 1 in 67: show the achieved grade or a plain note (R-27 warn and record, no block). Nothing to change in behaviour.
2. **INT-047 Settings window Enter:** "SETTINGS WINDOW - YES". AMBIGUOUS, recorded literally: the desk's last wording was "should Enter in a number box save the whole window?", so YES = keep as built (Enter saves the whole window). The older wording (TIM_DESK 11 item 4p a) offered "change it so Enter only commits that box (recommended)". NO CHANGE is queued (safe default); the desk asks Tim one line to confirm.
3. **INT-048 Paste (BUG-366 / BUG-342 part 1):** "PASTE - YEP". Desk reading: YES: pasting CE pits/pipes into a drawing with no drainage wakes Civil for that paste with one plain line ("run CDREPAIR"), only when the pasted objects are CE pits/pipes; Civil stays silent in Structural drawings otherwise. #567 (quiet paste catcher) may ship once its review fixes pass (it is on HOLD until now).
4. **INT-049 #547:** "SHOW IN THIS CHAT PLEASE". The card (docs/workflows/S7_FOOTING_DRAW_UNITS_CARD.md on branch claude/s7-footing-draw-convert) is shown to Tim in this chat in plain words; #547 stays HELD until he says approve.
5. **INT-050 Confirm LPD button (#543):** "WHATEVER YOU RECOMMEND". Desk recommendation, applied: GREY with a plain hover reason on the four non-Start tabs until an outlet is picked on Start (same layout every open, per the cockpit rule; hiding would move the other buttons). That is the default already built in #543.

## Sun 4 Oct 2026 about 07:30 — Tim approved #547 and repeated the top-down rule (desk plan/02)

Tim, verbatim: "APPROVE 547 / IM NOT SURE HOW MANY TIMES I NEED TO SAY THIS BUT WE NORMALLY DRAFT AND DESIGN FROM ROOF DOWNWARDS, HOW CAN OUR PLUGIN HELP TO SPEED UP THE ENTIRE DRAFTING PROCESS . HOW CAN AI, MCP, API, CLI HELP TO PRODUCER DRAWINGS?"

1. **INT-051 #547 APPROVED:** the footing drawing-units card (docs/workflows/S7_FOOTING_DRAW_UNITS_CARD.md on claude/s7-footing-draw-convert) is approved by Tim; the card status line gets "approved by Tim 4 Oct (INT-051)". #547 may join the next Structural train after its Opus review of the current head and the Codex check list. Desk rulings of section 8 of the card (hold wording, quick tools convert, depth stays mm, CSPIER keeps picking) stand as read by Tim in this chat.
2. **Top-down reminder (already recorded as UX-STRUC-13, 26 Sep 10:10 in `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`):** Structural jobs are drafted and designed top down: roof, upper floors, ground floor, footings LAST; the footing plan is the last plan. The desk's 4 Oct walkthrough listed footings before beams and rebar: WRONG ORDER, the desk's error. Every Structural walkthrough, test order and ribbon explanation follows roof-down from now on.
3. **Question, answered in chat (INT-052, a request not a ruling):** how the plugin, AI, MCP, API and CLI can speed up producing drawings roof-down. The answer and the recommended next step are in the desk reply of 4 Oct about 07:30.

## Sun 4 Oct 2026 about 08:00 — Tim: go with the recommendation (roof-down production card), study previous jobs, assistant drives only the boring end (desk plan/02)

Tim, verbatim: "LETS GO WITH YOUR RECOMMENDATION, MAKE SURE FROM PREVIOUS JOBS IN JOBS FOLDER THAT YOU UNDERSTAND THE PROCESS AND HOW IT WORKS THEN SEE HOW YOU CAN IMPLEMENT AI or MCP assistant drives only that boring end, and never the design decisions. WHAT ABOUT HELPING PLACEMENT AND LOGIC AND DRAFTING STANDARDS FROM CURRENT CE DRAWINGS?"

1. **INT-053 roof-down production card: GO.** A read-only study of recent jobs in `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Projects` (the folder Tim named; read-only, DATA-01: no client names, addresses or job numbers in any repo; real names only in `C:\ce_rc_study\`, outside every repo), plus the office masters (Standard Details, Drawing Templates), then the card `STRUC-ROOF-DOWN-PRODUCTION_CARD_2026-10-04.md` (status DRAFT until Tim approves) and the anonymised study `04_REFERENCE\structural\JOBS_PROCESS_STUDY_2026-10-04.md`. Done by Team worker study/01 (headless Opus, no AutoCAD, no console), job `desk_jobs\study01_job_latest.txt`, log `areas\release-v3-colleagues-STUDY1_LOG.md`.
2. **INT-054 boundary for AI / MCP / CLI:** the assistant drives ONLY the boring end (mechanical, repeatable, reversible steps on copies or on a job the drafter handed over; one report; native locks, Xrefs and REFEDIT respected) and NEVER makes design decisions (sizes, spans, load assumptions, footing sizes, bracing counts).
3. **INT-055 placement, logic and drafting standards learned from current CE drawings:** Tim asked; the card proposes a phased plan (P1 read-only layer/block/tag study from copies by headless console, P2 standards catalogue proposed to Tim, P3 proposals in the plugin, P4 the assistant), every number on the Settings page (R-00), proposals only, client evidence local-only (R-LEARN, EV-03). The DWG-level study (P1) is scheduled by the desk when no install is waiting for the AutoCAD console to be absent.

## Sun 4 Oct 2026 about 14:30 — Tim: get the Team chats and Codex moving within their own usage (desk plan/02)

Tim, verbatim: "you cant get team chats and codex moving within their usage?" Desk reading: YES. The slowdown of 13:00 (trains held to Monday 08:00, no driver agent sessions) protects the MAIN Claude meter only (37% against about 29% planned). The Team account (separate, about 16% of its week at 08:00) and Codex (separate; window Sat 3 Oct 14:37 to Sat 10 Oct 08:15, 25% used) have room and Tim's standing rules apply: INT-010 do not stop building unless Tim stops it, INT-012 Codex stop line 90% (keep about 10 points reserve for the last two days), INT-021 free rein on his PC for testing, INT-023 spare Codex usage may build on gpt-6.1-sol. INT-056: Codex W9 starts now (not Monday) and Codex plus Team keep working continuously; the main-meter savings stay (one Civil and one Structural train per day, Sonnet assemblers, no driver agent sessions).

## Sun 4 Oct 2026 about 14:40 — Tim: the desk must manage all three usage allowances every day (desk plan/02)

Tim, verbatim: "you were meant to manage and control all three and make sure you use the usage of all each day weith their own allowances seriously!" and then "need a handoff soon". INT-057 (priority, standing, supersedes the 13:00 slowdown reading): the desk MANAGES AND CONTROLS ALL THREE allowances (main Claude, the Team account, Codex) and makes sure EACH is USED EVERY DAY against its OWN allowance, seriously: at every check it reads the three meters, compares each with its day target, and dispatches work so none sits idle (Team: at least three build workers plus the reviewer running whenever PRs wait; Codex: always a queued test pass or build run up to its day target; main Claude: finalizers, trains and the desk itself, held to its own day target). The desk's error on 4 Oct: it protected the main meter and let the Team and Codex idle for hours.

## Sun 4 Oct 2026 about 23:20 — Tim: clean the C drive as needed (desk plan/01)

Tim, verbatim: "clean c drive as you need and dont remove important stugg". INT-058 (ruling, answers the disk question asked at 21:45 and 22:30): the desk and the controller may CLEAN C: as needed, but must not remove anything important (no drawings, projects, code, keys, worktrees of other chats, Codex history or settings). Scope as the desk applied it at 23:20: deleted the 1,384 background-task output files older than 24 h in the old session folder (about 8.4 GB; newer files, scratchpad and transcript left) and the old %TEMP% items o3wb5cfc, lestw1e0 (Visual Studio installer temp) and bug160_master_check; C: went from 14 GB to 27 GB. NOT covered by these words, still asked separately: excluding the work folders from Windows Search indexing (a system setting; the indexer was writing 120 to 330 MB/s and made C: swing 2 to 14 GB) and pruning Codex's own history (7.2 GB sqlite, a 3.7 GB rollout). Builds resume with the gate: Team builders stop below 13 GB, Codex builds hold at 15 GB.

## Mon 5 Oct 2026 about 01:30 — Tim answers the 24 return questions (typed choices in the desk chat; desk plan/01)

Tim answered by tapping options (his choices in quotes). INT-059 (ruling, all items; answers the questions in `04_REFERENCE\ux-plan\cards\TIM_RETURN_QUESTIONS_2026-10-04.md`, `STRUCT_QUESTIONS_FOR_TIM_2026-10-04.md`, `L3_QUESTIONS_FOR_TIM_2026-10-04.md` and the roof-down card section 7):

1. **First overnight jobs:** "All three (Recommended)": schedule refresh + checks + PDF set, on copies only, one morning report.
2. **Same-day re-issue:** "Replace earlier set (Recommended)": drawings and PDFs always match; the old same-day set is replaced as a whole.
3. **Old Pit Schedule table:** "Accept the first edit (Recommended)".
4. **Steepest proposed pipe:** Tim: "we can allow very steep pipes make it a setting"; starting value "No limit, warn only (Recommended)" (plain warning above 1 in 10; never a block); the value is a Settings value. (Supersedes the 1 in 20 recommendation.)
5. **Downpipe spacing:** "12 m (Recommended)" (low corners and valleys included; Settings value).
6. **Architect's downpipe symbols:** "Broad search (Recommended)" (DP / DOWNPIPE / RWDP names; each confirmed by the drafter).
7. **Layout choices:** "Pits / pipe / set-off (Recommended)" (A fewest pits, B shortest pipe, C usual set-off).
8. **Learning before layouts are offered:** "5 networks (Recommended)" (Settings value).
9. **Repeated markup comments:** "Place and meaning (Recommended)".
10. **Compare an engineer's edits with:** "Latest saved copy (Recommended)" (falls back to the last issue and says which was used).
11. **Print differences:** "Warn on any departure (Recommended)" (never stops the issue).
12. **Default title block for new jobs:** Tim: "both options are needed". There is NO single default: a new job asks which title block (A1 horizontal or A3 classic) at creation; old jobs keep theirs.
13. **Handing work over:** "Drafter button, copies first (Recommended)" (copies only for the first month, then a separate decision before originals).
14. **New Pit cover level after a restart:** "Blank (Recommended)" (Recall last settings stays available; answers BUG-401 / #705).
15. **Markers from the floor above:** "Trial 1 week (Recommended)" (on Tim's PC only, after each plan's level is set with CSPLANLEVEL).
16. **Typed pit numbers, capitals only (p5 over P5):** Tim chose "Restore P5": capitals ARE tidied back to the existing number (so #687 matches Tim; the reviewer's #687 objection is withdrawn).
17. **A pit typed as "8" beside an existing P8:** Tim chose "Refuse" (a hard refusal; his own ruling, overrides the desk's warn-and-accept recommendation; BUG-396 a).
18. **"C 2" (with a space) beside an existing C2:** "Warn and accept (Recommended)" (BUG-396 b; so #670 must be a warning, not a refusal: build/03 run 23/24 made it so).
19. **Charged rising pipe flips on a grip drag:** "Keep, with a message (Recommended)" (one plain line saying it flipped; BUG-396 c).
20. **Settings window, Enter:** "Yes, save all (Recommended)" (INT-047 settled).
21. **Support file ce_suite_startup.lsp, StrucPlus lines:** "Yes, remove (Recommended)". Done by the desk 5 Oct: backup `ce_suite_startup.lsp.bak-20261005-before-strucplus-removal` beside it; line 76 `(ce:load-strucplus-lisp)` in `s::startup` is now a comment (the defun stays, never called). Takes effect at the next AutoCAD start; closes BUG-402.
22. **Issue with no sheet ticked and a blank new revision:** "Allow (Recommended)" (#692/#704 preview).
23. **A level typed in the Pit window:** "Never move it (Recommended)" (same as a level typed in Edit Pipe).
24. **Clearances (footing and service distances in metres):** NOT answered yet: Tim has not typed the numbers; stays Unknown, on the Settings page, never a quiet default.

Also INT-060 (done by Tim in the same chat): Tim said "yes search as you need" about the Windows Search indexing; this is a Windows system setting, so the desk did NOT change it and gave Tim the click steps (Settings > Privacy & security > Searching Windows > Find my files > Classic, or exclude the work folders); still Tim's to do at the PC.

## Mon 5 Oct 2026 about 06:35 — Tim: use the Team account to 100% every week (desk plan/01)

Tim, verbatim: "you can use team to 100% every werk". INT-061 (priority, standing; supersedes the 90% Team target of 12f and 12g item 34): the Team account (separate allowance, headless Opus/Sonnet workers) is to be used up to 100% by every weekly reset. Today's reading (Tim's screenshot 06:15): 47% used, resets Sat 10 Oct 5:00 AM.

## Mon 5 Oct 2026 about 06:50 — Tim answers the UX-SUB-04 and UX-SSCHED-05 card questions (desk plan/01)

INT-062 (ruling; answers `UX-SUB-04_POINT_LOAD_CARRY_DOWN_CARD_2026-10-04.md` section 5 and `UX-SSCHED-05_MEMBER_SCHEDULE_FROM_PLAN_CARD_2026-10-04.md` section 5; Tim tapped options; his words in quotes):
1. **How a roof point load is marked:** "New CE marker (Recommended)": a new CE marker you place (CSPOINTLOAD) with the kN typed, or Unknown.
2. **Roof and the floor below:** Tim chose "Separate drawings" (NOT the recommended one drawing first): roof and floors are separate drawings from the start, so the carry-down must work across drawings with the plan levels (CSPLANLEVEL); the matcher today works in one drawing only: this is a build prerequisite.
3. **Arrow symbol:** Tim: "look at how we show point loads atm": use the existing way point loads are drawn today (find the current point-load symbol in the Structural plugin and the drawing standards); do NOT invent a new arrow.
4. **Into its computation:** "List now, calc later (Recommended)".
5. **Member schedule groups:** "Recommended grouping" (Structural Supports = C, PC, SC, DS, TS; First Floor Members = FB, L, OR, PB ...; Common Members = FJ, trimmers, wall plates, anything repeated across floors).
6. **Order inside a group:** "By mark number (Recommended)".
7. **Roof plan:** "Yes (Recommended)": same command, title ROOF MEMBER SCHEDULE from the plan level.
8. **Excel route (XCLMTXT):** "Keep both (Recommended)".
Both cards are now answered: S1 (UX-SUB-04) and S3 (UX-SSCHED-05) are UNBLOCKED for the Team (Sonnet builders), with Tim's variations in items 2 and 3.

## Mon 5 Oct 2026 about 06:55 — Tim: do not ask questions with a blocking tool (desk plan/01)

Tim, verbatim: "asking the quesrions stopped building ive said this too many times now". INT-063 (standing rule, repeated): the desk NEVER uses AskUserQuestion (or any tool that blocks the turn), not even when Tim asks for selectable questions; questions go as a plain numbered list in the message, answered by number; the keep-alive and the Team never wait on an answer. The desk broke this at 01:00 and 06:45 on 5 Oct (the tool blocks the whole turn until answered). Also Tim asked for a short pause to update the Claude desktop app (Mon 5 Oct about 06:55).

## Wed 7 Oct 2026 about 16:35 — Tim: the whole process feels stretched; use both Claude levels to 100% of the weekly (desk plan/01)

Tim, verbatim: "for me the whole process has shifted and changed since i first started it last week feels like youre stringing things out a lot more" and "can we get things moving so we use usage effectively , you can run both claude usage levels to 100% of the weekly ensuring you dont use it all at once". INT-064 (priority, standing; supersedes the 11-run daily cap and the 85% line of TIM_DESK 12g, and the one-install-a-day pacing of INT-061/12i): (1) the MAIN Claude and the TEAM Claude weekly allowances are each to be used up to 100% by their own reset (main Fri 9 Oct 12:00, Team Sat 10 Oct 5:00 AM), paced across the whole window, never all at once; (2) builders and reviewers run continuously (two builders plus a reviewer at a time; Sonnet builders, Opus reviewer), no idle gaps, no daily run cap, no waiting for time blocks; only real AutoCAD mouse tests need the PC alone; (3) installs happen as soon as a batch is reviewed (small batches, several a day), not once a day; (4) the PC was off from Mon 5 Oct about 21:00 to Wed 7 Oct 16:10 (43 hours lost), so the Tuesday assembly and installs did not happen. Main meter 41% and Codex 52% at Wed 16:17.

## Wed 7 Oct 2026 about 23:55 (real PC clock) — Tim: a layer tidy-up is worth running in the background if done properly (desk plan/02)

Tim, verbatim: "some things are worth running in the background a layer tify up is one of those things if done properly". **INT-065** (answers the desk's open question on BUG-418 draft #764: should SF / BSF run the layer tidy-up at all, or only STRIPLAYERSMERGE; the desk had recommended only STRIPLAYERSMERGE). **Interpretation (desk, not Tim's words):** the tidy-up STAYS in SF and BSF (and STRIPLAYERSMERGE) and runs quietly in the background, provided it is done properly: it never touches objects on a locked layer, Xref content or anything while REFEDIT is open; erases an old layer only when it is empty, unlocked and not in use; says nothing unless it skips something, and then one plain line per skip; never swallows a failure. That is the draft #764 behaviour. **The desk's earlier recommendation (only STRIPLAYERSMERGE) is SUPERSEDED by this answer.** Not decided by this answer: BUG-417 (CDIMPORTXCIVIL skip-or-ask on locked layers) and the other open questions (A/B/C speed limit, wall gap, brace length; BUG-420 free pit number).

## Wed 7 Oct 2026 about 00:05 Thu by the desk's clock (real PC clock about 23:58 Wed) — Tim's answers to the Settings-rows questions A, B, C (desk plan/02)

Tim, verbatim: "A lets go with whatever the design document from creative engineering says. B & C as recommended". **INT-066.** (A) UPVC speed limit (Edit Pipe 3 m/s vs Civil Design 6 m/s): **whatever Creative Engineering's own design guide says**; the desk is reading the guide for it; until it names a figure the Settings table value (3 m/s, "unconfirmed") stays the single value everywhere and the answer is NOT filled by the desk (RULES 12). (B) Widest wall pair gap: **350 mm kept** (so double-brick cavity walls pair). (C) A brace over 2700 mm: **keep the drawn length and warn** (never cut it to 2700). Recommendations were the desk's; Tim confirmed B and C "as recommended" in those words.

## Thu 8 Oct 2026 about 00:10 — INT-066 item A: the Creative Engineering design guide was read (desk plan/02)

Tim (verbatim, 00:00 Thu): "engineering folder of creative engineering sharepoint". The guide is `...\Creative Engineering - Engineering\Civil Stuff\CIVIL AND DRAINAGE DESIGN GUIDEBOOK.pdf` (964 KB, 33 pages, the 2024 Version 1 that `02_COUNCIL_RULES\CE_DESIGN_GUIDEBOOK_RULESET.md` summarises). The desk extracted the text of all 33 pages and searched it. **Finding: the guide names NO maximum pipe speed (velocity / scour) for UPVC or any other material** (no "m/s" or "velocity" anywhere; its only PVC mention is the underground detention pipes, "STORMPRO or equivalent PVC", and page figures that are pictures were not readable as text). So Tim's ruling "whatever the design document says" gives **no figure for A**: the UPVC speed limit stays UNCONFIRMED. What the desk does meanwhile (interpretation): one value everywhere (the Settings table's 3 m/s, flagged unconfirmed) and a plain warning, never a silent default; the other candidate documents to check are the CPAA Hydraulics Design Manual (`Civil Stuff\CPAA_Hydraulics_Design_Manual.pdf` and `books\cpaa_design_manual_hydraulics_jan13.pdf`) and the AS/NZS 3500.3 clause the guide refers to: Tim to say if one of those is the authority. **Evidence recorded (RULES 9.9):** the guide also says "Min pipe grade of detention pipe 1:200 for pipes 225 and greater" (repeated on 5 council pages) and "Orifice required only for flowrates more than 12L/s" (one council page): check these two are Settings values (CL3 detention).

## Thu 8 Oct 2026 about 00:25 — Tim: "B" (authority for the UPVC speed limit); the standard was read (desk plan/02)

Tim, verbatim: "B". **INT-067 (interpretation, desk: Tim answered the desk's last question, which offered a. CPAA Hydraulics Design Manual, b. AS/NZS 3500.3, c. something else; "B" is read as option b = AS/NZS 3500.3. If Tim meant his own earlier B (the 350 mm wall gap), that was already answered in INT-066).** The desk read `...\Engineering\Australian Standards\Babak\1- Australian Standards\AS-3500-Plumbing and drainage\3500.3-2003(+A3).pdf` (189 pages, text extracted). **Findings (paraphrased, not quoted): (1) Clause 7.3.5 (site stormwater drains): a minimum gradient is given (Table 7.2) and NO maximum gradient is specified, with a note that designers should be aware of scour by rapid or sediment-laden flows: so the standard gives NO material-specific scour speed cap for UPVC or any pipe. (2) Clause 5.4.11.2 step (d) (design of pipe drains): to reduce overflow from stormwater pits caused by increased energy losses, the full-pipe velocity in the OUTLET pipe of a pit is recommended not to exceed 1.5 m/s and shall not exceed 2.0 m/s; the worked-example note (Column 12) says that, other than for steep gradients, a full-pipe velocity above 1.5 m/s means selecting a larger pipe.** So: the 3 and 6 m/s caps in the plugin are CE house rules (R-01), not the standard's; the standard's own speed limit is a different, stricter check on the pipe leaving a pit. **The UPVC scour cap (3 vs 6 m/s) therefore stays UNCONFIRMED**; nothing is changed. **Open question put to Tim (recommendation, not a decision):** add the standard's pit-outlet check (1.5 m/s recommended, 2.0 m/s shall-not-exceed) as a WARNING (never a block, R-27) with both figures as Settings rows, separate from the 3/6 m/s scour table.

## Thu 8 Oct 2026 about 04:10 (real PC clock) — Tim answers questions 1 to 4 of the open list (desk plan/02)

Tim, verbatim: "1. as recommended 2. as recommended 3. as recommended 4. as recommended". **INT-068.** The numbered list is `04_REFERENCE\ux-plan\cards\TIM_ALL_OPEN_QUESTIONS_2026-10-08.md` as re-sent in chat (the chat copy numbers 1-20; items 1-4 are the same as items 1-4 of the file). (1) **uPVC speed limit authority = the CPAA Hydraulics Design Manual** (`...\Engineering\Civil Stuff\CPAA_Hydraulics_Design_Manual.pdf`, and `books\cpaa_design_manual_hydraulics_jan13.pdf`): the desk is having the manual read for its maximum-velocity figures by material; the figures read become PROPOSED Settings values for Tim to tick "Confirmed" (an engineering value needs his word); until then 3 m/s stays the single unconfirmed value and Civil Design stays at 6. (2) **Add the AS/NZS 3500.3 pit-outlet speed check (Clause 5.4.11.2(d): 1.5 m/s recommended, 2.0 m/s shall not exceed) as a WARNING only (never a block, R-27) with both figures as Settings rows**, separate from the scour table. (3) **Detention (CE guide): warn on a detention pipe flatter than 1 in 200 for pipes 225 mm and larger; show "orifice not required" at 12 L/s or less; warnings only, both figures on Settings.** (4) **A steep pipe held at 1 in 5 is offered with the "steep, check it" line** instead of "Check by hand" (confirms INT-059 item 4: warn above 1 in 10, never block).

## Thu 8 Oct 2026 about 04:30 (real PC clock) — Tim answers questions 5 to 20 of the open list (desk plan/02)

Tim, verbatim: "5. as recommended 6. as recommended 7. as recommended 8. as recommended 9. leave as is for now, commonly used by me to save 10. as recommended 11. as recommended 12. as recommended 13. as recommended 14. as recommended 15. as recommended 16. as recommended 17. as recommended 18. as recommended 19. send through to me 20. as recommended". **INT-069.** The numbering is the chat list of Thu 8 Oct (file `04_REFERENCE\ux-plan\cards\TIM_ALL_OPEN_QUESTIONS_2026-10-08.md` has the same questions on other numbers). Rulings (each with the desk's recommendation that Tim accepted): **(5)** a FREE pit number typed in the Pit Schedule window WAITS as a pending override until Review / Update / Stop overriding (no change). **(6)** Pilot ground rule: colleagues renumber pits only in Edit Pit, never in the Pit Schedule window, until the window fix is installed (it is, in 3.0.35). **(7)** Real login and computer names: delete the old real-named Civil report files (Civil and Manager at start-up, as Structural already does), scramble the names inside the Manager report, keep PC names out of support-bundle file names. **(8)** CDIMPORTXCIVIL on a locked layer: SKIP and say so (BUG-417: PR #765 may now go to a train once Opus MERGE on its current head). **(9)** F2 / CLEAN: **LEAVE AS IS FOR NOW; Tim uses F2 to save** (desk note: BUG-411 stays open, nothing moves; the desk will check what F2 does for him before anyone changes it). **(10)** Manager 'Roll Back Release': PCs actually go back at their next AutoCAD start, with an 'are you sure'. **(11)** Approving a Civil update also approves the matching Manager update. **(12)** Support bundle (CESUPPORT): never uploads by itself; drawing paths replaced by job numbers. **(13)** Sheet sync skips sheets a colleague has open, and says which. **(14)** Unknown footing width: ask for it, with the Settings value (today 300 mm; screw pile 150 mm) pre-filled. **(15)** Tim runs the Day 1 checklist himself on one real job copy before any colleague pilot. **(16)** Pilot: a colleague on AutoCAD 2027 first, hand install (old folder renamed to _PRE_V3.backup, new copied in); **the colleague's NAME and the results channel were NOT supplied: still open.** **(17)** Flat pipe label (BUG-427): "as recommended": the chat list said (b) ask/keep held grade, a later message the same hour revised the recommendation to (a) the label reads FLAT with no grade figure when both ends are typed the same; **desk interpretation: (a), the later recommendation; the Team builds (a) as a DRAFT and the desk asks Tim to confirm in one line.** **(18)** The five Structural framing cards (A to E) are APPROVED as recommended (15 questions): roof area setout, floor joist span arrow, framing legend, lintel/support proposals, level above and below (O)/(U). **(19)** Design cards (the seven cards, 19 questions): "send through to me": **Tim wants to answer these himself: the desk sends the questions to him in chat; NOT approved yet.** **(20)** Markup words: as recommended (no missing words).

## Thu 8 Oct 2026 about 05:25 (real PC clock) — Tim answers the re-sent list, items 1 to 5 (desk plan/02)

Tim, verbatim: "1. as recommended 2. as recommended 3. as recommended 4. as recommended 5. yes". **INT-070.** Numbering is the chat list of Thu 8 Oct 05:18 (16 items; 6 to 16 still open). **(1) Orifice at 12 L/s or less:** the 'orifice not required' rule is made a BLANK per-council value and is NOT applied office-wide (five real issued CE sheets drew orifices at 4 to 12 L/s: Bayside 24-01 56 mm, Manningham 23-08 70 mm, Kingston 24-100 71 mm, Glen Eira 24-115 63 mm, an 11.94 L/s job 90 mm); the guide's sentence sat on one council's page. **(2) uPVC speed limit (CPAA C1):** keep 3 m/s as a WARNING labelled 'unconfirmed, no standard found' until a source is named. **(3) Concrete pipe speed (C2):** keep CE's 6 m/s labelled 'CE office rule (CPAA allows 8 m/s)'. **(4) Minimum speed (C3):** keep 0.6 m/s, source CPAA 4.1.2. **(5) Flat pipe label (BUG-427): yes: the label reads FLAT with no grade figure when both ends are typed the same** (confirms the desk's reading of INT-069 item 17).

## Thu 8 Oct 2026 about 05:50 (real PC clock) — Tim answers items 6 to 16 of the re-sent list (desk plan/02)

Tim, verbatim: "6. as recommended 7. as recommended 8. Max - IDK 9. not sure what youre talking about 10. answers below 1. yes 2. yes 3. warning on plan implenmented well would be good 11. answers below 1. yes 2. yes 12. answers below 1. yes 2. as recommended 3. yes 13. answers below 1. yes 2. what do you mean? 3. give options 14. answers below 1. yes - should also provide improvements after design complete 2. yes 3. no 15. answers below 1. look through them all uyourself there should be a list somehwere 2. yes 16. answers below 1. no idea 2. yes 3. yes". **INT-071.** Numbering is the chat list of Thu 8 Oct 05:18. **(6)** New settings defaults: the version keeps writing its new default rows at start AND logs ONE line when it changes an existing file ('Settings file updated with new default rows (CS_Settings.json). No value you set was changed.'): PR #799. **(7)** The Manager administrator MAY look up a coded id's real login and PC name (office administrator only). **(8)** Pilot colleague: **'Max'** (surname not given); **the results channel is NOT decided ('IDK')**: stays an open blank. **(9)** Tim did not understand the column-with-an-attached-beam drawing request: no action from Tim; the controller/Codex draws its own test column with a beam on a test copy. **(10) Design card A (pit label grade, BUG-351b): (a) YES update the label grade when a level is typed on a held-grade pipe; (b) YES warn when a held-grade label is more than 10 % off (Settings value); (c) 'warning on plan implemented well would be good'**: desk interpretation: YES show the warning on the plan too, but done cleanly (a non-plotting marker so issued sheets stay clean; Tim's words are conditional on it being well implemented). **(11) Card B (locked-layer schedule cells, BUG-246): (a) YES Refresh may change out-of-date schedule text, with Undo; (b) YES look at the cells each time the window opens.** **(12) Card C (downpipes, Level 3): (a) YES place what can be placed and name each one left out; (b) as recommended: a front-wall downpipe numbers LAST in the clockwise order; (c) YES one 'Level 3 proposals' place in Project Review.** **(13) Card D (detention, Level 3): (a) YES the detention block beside the orifice pit, unticked until ticked; (b) 'what do you mean?': the clearance distances question is re-asked in plain words (NOT answered); (c) 'give options': re-asked with options (NOT answered).** **(14) Card E (network layout): (a) YES learn from each person's own drawings first, office-wide later, 'should also provide improvements after design complete'** (new idea: after a design is complete the layout tool offers improvements: filed in IDEAS_INBOX); **(b) YES a layout may propose changing a pit already drawn as a separate unticked row; (c) NO the layout does not see an un-accepted downpipe or tank proposal.** **(15) Card F (BUG-061): (a) 'look through them all yourself, there should be a list somewhere'**: Tim authorises the desk/Team to look through the drawing evidence list themselves for a consultant drawing where a run imports as several pipes: SCOPE (desk interpretation under RULES 14.6): read-only, copies only, results with JOB NUMBERS ONLY in the repo, anything naming a client or address stays in the local-only C:\CE_DrawingIntelligence store; **(b) YES join same-size, end-to-end, straight pieces with no pit between; list bends.** **(16) Card G (Kingston commercial, BUG-251): (a) 'no idea' where the K02 PDF is: the desk found it: `...\Creative Engineering - Engineering\Civil Stuff\Councils\Kingston\` holds 'Civil-Design-requirements-for-Developers-Part-A.pdf' (7 Apr 2020), '...Part-A-Integrated-Stormwater-Management-Version-4-4.pdf' (7 Apr 2021) and 'kingston-stormwater-guide-for-developers-2025_v2.pdf' (21 Mar 2025): a Team reader checks which holds the commercial page-14 values; (b) YES commercial lot under 1000 m²: Tc 7 minutes on Settings; (c) YES pre-development C = the lower of the existing site C and 0.7, Unknown until typed.**

## Thu 8 Oct 2026 about 06:30 (real PC clock) — Tim answers the desk's reply of 06:00 (nine points; desk plan/02)

Tim, verbatim: "1. a need to set it up though and make sure it happens 2. thanks 3. yep 4. d 5. c 6. yep 7. yep 8. yep 9. yep". **INT-072.** Numbering is the desk's reply list of Thu 8 Oct about 06:00. **(1) Pilot results channel = option (a): a shared 'CE pilot results' folder on SharePoint; Tim: 'need to set it up though and make sure it happens'**: the desk sets the folder up (via the SharePoint connector, if it reaches) and makes sure colleagues are told where to save; sharing/access for Max is Tim's to grant (the desk does not change sharing). **(3) card A 10c:** the desk's reading confirmed ('yep'): show the label-grade warning on the plan too, as a non-plotting marker. **(4) card D 13b = option (d): 'your own two numbers'**: Tim did NOT give the numbers: the footing clearance and the service clearance (metres) are STILL OPEN; until typed CE says 'clearance not set'. **(5) card D 13c = option (c): show BOTH the fully underground tank and the split (part-underground) option side by side** for a council such as Glen Eira (50 %). **(6) idea (after a design is complete, offer improvements) confirmed 'yep'**; **(7) the desk finds the BUG-061 candidate drawing itself, job numbers only: 'yep'; (8) the desk finds the Kingston document itself: 'yep'; (9)** builders start on the approved cards A, B, C, E: 'yep'.

## Fri 9 Oct 2026 about 05:50 (real PC clock) — Tim: builds must not wait on his answers (desk plan/03)

Tim, verbatim (after the desk said the builders were idle and waiting on his 35 questions): "the builds should not be hung on me answering questions should it and can you send then through". **INT-073.** Desk interpretation (not Tim's words): "send them through" = push the builds through now, on the desk's recommended answers; the question lists were already sent to him. **OVERRIDE of the AGENTS.md command review gate, with scope:** Team builders MAY build the Batch 1, 2 and 3 cards (`04_REFERENCE/ux-plan/cards/BATCH*_CARD_2026-10-09.md`) on the RECOMMENDED answers in `TIM_BATCH_QUESTIONS_2026-10-09.md` and `TIM_BATCH_QUESTIONS_2_3_2026-10-09.md`, as DRAFT PRs, tests RED first, every new behaviour behind a Settings value and OFF or hidden where it changes what a drafter sees until Tim says so (R-00, R-27), nothing retired, no old behaviour removed, native locks/Xref/REFEDIT protection unchanged. Tim's later answer by number replaces any recommended default (the builders then change the Settings default or the behaviour in a follow-up). Windows stay Codex's. Nothing is ever marked accepted without Tim or a Codex PASS in AutoCAD. Questions that are Tim's engineering call (Set A items 1 to 6: the Settings tick, default template, Kingston Tc, typed pit levels, grade warning, Esc on C1) are not covered by this override.

## Fri 9 Oct 2026 about 07:35 (real PC clock) — Tim answers the 14 Batch 1 questions (labels on the Civil plan; desk plan/03)

Tim, verbatim: "1. ce standards are that plastic pits are labelled just using the pp in cover level text 2. as recommended 3. keep as per standard but upgrade to work within system 4. as recommended 5. as recommended 6. as recommended 7. as recommended 8. as recommended 9. as recommended 10. as recommended -do you mean the flip that we have on cover level text? 11. as recommended 12. as recommended - or rearrange evrything to fit or move it out to suit 13. as recommended 14. i will check and send". **INT-074.** Numbering is `TIM_BATCH_QUESTIONS_2026-10-09.md`. Rulings and the desk's interpretation of each (interpretations marked):
1. **OVERRIDES the recommendation.** A plastic pit is labelled on the plan ONLY by "PP" in its cover level text (CE standard). NO separate P-number plan label for plastic pits. Card 1.1 becomes KEEP (already the standard): nothing to build except keeping it. Supersedes the 26 Sep ruling UX-PIT-01 for the label (marked superseded, 9 Oct).
2. Esc at the label pick: as recommended (label goes at the usual office spot; no pit left without a label). For a plastic pit the "label" is the PP cover text, so Esc there leaves the PP cover text in its usual place.
3. Interpretation (desk): plastic pits stay as the standard has them (PP in the cover text, off the schedule), "upgraded to work within the system": they take part in CE's tidy, flip and checks like any other cover text; nothing is added to old drawings by itself.
4 to 9, 11, 13: as recommended (Edit Pipe re-tidies a clashing label in its preview with the same U; the Tidy labels command CDTIDYLABELS; Tidy also moves pit labels and cover levels; avoid text, blocks and hatches but not plain lines; long label stays two lines; P1A sorts straight after P1; Enter = All in the current space; Batch 1 card approved).
10. As recommended: after ROTATE or MIRROR a hand-placed label turns to read the right way up and stays where Tim put it. Tim asked: "do you mean the flip that we have on cover level text?" Desk answer: it is the same idea as the cover-level flip (CDPITCOVERFLIP) but automatic; today CE only makes text readable when a label is first placed or flipped by hand (KeepFlippedTextReadable), not after ROTATE/MIRROR of a whole group.
12. As recommended, widened by Tim: when there is no clear spot for a label, FIRST try to rearrange the neighbouring CE labels to make room, OR move the label out (with a leader) to suit; only if neither works leave it and list it. Never put it on top of something.
14. Tim will check Batches 2 and 3 (and 4/13) and send them later. Builders continue on the recommended answers (INT-073).

## Fri 9 Oct 2026 about 08:05 (real PC clock) — desk plan/03 extends INT-073 to Batches 4 and 13 (interpretation, not Tim's words)

Tim's INT-073 words ("the builds should not be hung on me answering questions") were general. The desk reads them as covering EVERY design batch card that carries recommended answers, not only Batches 1 to 3: builders may build `BATCH4_FIRST_START_AND_HELP_CARD_2026-10-09.md` and `BATCH13_STRUC_ROOF_DOWN_FRAMING_CARD_2026-10-09.md` on the recommended answers in `TIM_BATCH_QUESTIONS_4_5_2026-10-09.md`, with the same safeguards (DRAFT PRs, Settings-backed, OFF or hidden, nothing retired, native locks unchanged, Tim's later answer replaces the default; Set A engineering calls stay excluded). If Tim says this is wrong, builders stop and the PRs are parked, not merged.

## Fri 9 Oct 2026 about 08:30 (real PC clock) — Tim answers Set A, Batches 2 and 3, Batches 4 and 5 (desk plan/03)

Tim, verbatim. **SET A** (numbering = `TIM_SET_A_QUESTIONS_2026-10-09.md`): "1. as recommended 2. just the regular acad iso 3. as recommended 4. as recommended 5. as recommended 6. as recommended 7. yep 8. its different depending on the job 9. Mishchenko, yes 10. idk what this means 11. fix or let me know wht you need from me 12. clean up when you can 13. yes disk". **BATCHES 2+3** (`TIM_BATCH_QUESTIONS_2_3_2026-10-09.md`): "1. as recommended 2. as recommended 3. as recommended 4. as recommended 5. as recommended 6. as recommended - send this report back to tim / admin for fixing or improving 7. as recommended 8. ideally no blue please our colours are gold, black and white /grey 9. as recommended 10. as recommended 11. as recommended 12. as recommended 13. as recommended 14. lets complete final images before colleague release 15. answers above". **BATCHES 4+5** (`TIM_BATCH_QUESTIONS_4_5_2026-10-09.md`): "1. as recommended 2. as recommended 3. as recommended 4. as recommended 5. as recommended 6. as recommended 7. as recommended 8. as recommended 9. p1 for purlins p1 for timber posts both apply, typically they dont appear on the same jobs 10. depends on project and layouts 11. as recommended 12. as recommended 13. as recommended 14. as recommended 15. as recommended". And: "it feels like some stuff has been renamed to its real world names but i think it would be good if we could have a combo in some areas for the transiiton period that shows the autocad functionality". **INT-075.** Rulings and the desk's interpretation of each (interpretations marked):

SET A
1. YES: the one-tick exception for Codex W30 (beam linking ON for the test only, then back OFF, SETTINGS-WRITING RULE: fresh byte copy first, hashes before and after).
2. Default template for File > New = AutoCAD's regular metric template `acadiso.dwt` (interpretation of "the regular acad iso"). Tim authorised changing it: Codex sets it through AutoCAD's Options > Files > Template Settings > QNEW, records the old path first, verifies File > New afterwards.
3. Kingston lots of 1000 m2 and over: (a) calculate on 5 minutes AND warn on the flows too.
4. Typed pit levels wait for Stop overriding, clearer wording. 5. Held-grade pipe: keep the warning, label unchanged. 6. Esc at 'Enter a number to append' on C1 removes the column.
7. "yep" does NOT give the two clearance distances in metres: STILL UNANSWERED (Tim's number needed; never invent).
8. Lintel tolerances (150 / 350 / 300 mm, 2 degrees, largest opening): "its different depending on the job" - interpretation: they are per-job Settings values (office default 150 / 350 / 300 / 2 degrees, job override), and NO built-in largest-opening limit.
9. Max's surname is Mishchenko; YES to write access to the SharePoint folder 'CE Plugin Pilot Results'. The desk has no tool that sets SharePoint permissions: Tim does it (Share > Max Mishchenko > can edit) or says how.
10. "idk what this means" (floor arrow member order Joists / Bearers / Subfloor, legend wording 'DENOTES POST UNDER'): NOT answered; builders leave both as they are; the desk restates it plainly in a later short question.
11. BUG-061: "fix or let me know wht you need from me" - desk: nothing needed now; fix is in C-27; Codex re-runs the import after install; Tim only if a real job shows a wrong run.
12. "clean up when you can": the three stale start-up menu entries in Tim's AutoCAD profile (CE_CVL_SUITE_MENU, CE_STRUC_SUITE_MENU, CE_SUITE_MANAGER_MENU): Tim authorised the clean-up: back up acad.CUIX first, remove the three entries through AutoCAD's own CUI (DAY1 click steps), verify the start-up lines, rollback = restore the backup. The '; error: syntax error' source stays a read-first item.
13. YES DISK: delete the old install candidates (keep the newest Civil/Manager and Structural candidate and anything an installed PRE_ backup needs), the SUPERSEDED release archives, and the two old Temp folders. The PRE_*.backup bundles stay. Desk deleted the two Temp folders at 08:25 (C: free 14.06 to 19.07 GB); the controller does the rest and logs every path.

BATCHES 2+3
1-5, 7, 9-13, 15: as recommended (Batch 2 and Batch 3 cards approved). 6: as recommended AND when the drafter pauses a slow feature CE sends a report to Tim/admin (the Send-to-admin path, a count with the feature name and the measured delay, no drawing names) so it can be fixed or improved. 8: OVERRIDES the recommendation: NO BLUE: "our colours are gold, black and white /grey": the light-theme accent is not blue (gold, black, white/grey); supersedes the deep blue #1E5AA8 of 4 Sep (marked superseded). 14: ribbon tooltip pictures are made as FINAL images before the colleague release, not as a rough first pass.

BATCHES 4+5
1-8, 11-15: as recommended. 9: OVERRIDES: 'P1' is used for BOTH purlins and timber posts, they typically do not appear on the same job: NO separate purlin letter; if both appear on one job warn (R-27), do not block. 10: 'depends on project and layouts': the member schedule position is not fixed: ask each time per layout and remember it per project (interpretation).

TRANSITION NAMES (Tim's closing remark): where a plain-English name replaces an AutoCAD-style name, show BOTH during the transition (e.g. 'Tidy labels (CDTIDYLABELS)'): ribbon labels, menus, tooltips, window titles, help; a Settings switch 'Show AutoCAD command names' defaulting ON for the transition; the plain name stays the main name. Filed in IDEAS_INBOX and given to the builders.
