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
