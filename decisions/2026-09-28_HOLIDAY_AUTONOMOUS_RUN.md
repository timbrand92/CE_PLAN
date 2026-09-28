# Holiday autonomous run: Tim's rulings, 28 Sep 2026 (release chat 04)

Context: Tim is on holiday from after Tuesday 29 Sep 2026 for about 4 weeks. He asked how
`CE_ACAD / release-v3-colleagues / build + release / 04` can run on its own to get V3 done while
managing Claude and Codex weekly usage and leaving him room to code elsewhere.

Answers given through clickable choices, 28 Sep 2026 about 17:30 Melbourne time:

1. **Installs while away:** "Yes, my PC only". This chat may install new builds on Tim's own PC,
   with AutoCAD closed, a backup made and the files read back every time. Publishing to colleagues
   still needs Tim's word. This extends the 23 Sep standing override ("from now until tuesday we build,
   test and deploy whenever we need") for the holiday, for Tim's PC only.
2. **Claude usage split:** "75% chat, 25% me". This chat uses at most about 75% of each weekly
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
