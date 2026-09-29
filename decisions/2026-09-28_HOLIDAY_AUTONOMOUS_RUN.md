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
