# Tim, Thu 5 Nov 2026 (PC clock 16:32): what to do about the whole plugin (talk session, not yet a decision)

STATUS: THREE DECISIONS MADE (see Decisions, bottom). The plan under "Plan proposed 16:40" is treated as approved by interpretation (decision 3); Tim's tick list marks are still open. Follows `2026-11-05_TIM_STRIP_BACK_PROPOSAL.md` (CE 00's first proposal, Structural only), which this widens to the whole plugin.

## Tim's exact words

1. First message: "I THINK IVE GOTTEN TO A POITN WHERE IM KIND OF SICK OF HAVING 1000S OF BUGS AND WANT TO STRIP IT ALL BACK, KEEP WHAT IS ACTUALLY WORKING FROM STRUCTURAL AND THEN GO ONE TOOL AT A TIME, IT FEELS LIKE WERE GOING NOWHERE AND EVERYTIME I GIVE SOMEONE A RELEASE IT MAKES THEIR EXPERIENCE WORSE"
2. Clarifying: "i meant the whole plugin, it feels like weve added so much and it works alright but its so much to manage and then i end up letting people down. what should we do"

## Evidence read (PC clock 16:32; read from files, not remembered)

1. **Size.** Registered commands: CORRECTED 5 Nov 23:1x: about 144 Civil, 377 Structural, 12 Manager at the installed commits cf059dcf and 8de95c34 (first count of 137, 288, 11 was from a stale copy about 1,800 to 2,800 commits behind). 1,251 distinct bug numbers in BUG_CARPARK.md; only 17 lines carry a named "Codex-accepted" or "Claude-accepted" fix.
2. **What is actually in daily use.** Tim's ribbon-click log (Civil, 154 clicks, 7 Sep to 4 Nov): CDEDIT 27, CD 14, PIT 9, CDHELP 7, CDS 5, then a long tail of 1 to 4 clicks. About 20 different buttons ever clicked. This log counts ribbon clicks only, not typed commands, and it is Tim's PC only. No colleague usage record was found.
3. **The core already exists.** The plan has 40 "everyday tools" (30 daily cards plus named checks). Headline 28 of 40 accepted on 30 Oct (RELEASE_SCOREBOARD).
4. **Plan size vs proof.** Whole plan 548 items: 300 built, 14 tested strictly (RELEASE_SCOREBOARD, Rule 16 note).
5. **This week's real harm** (continuity record item 64): about 3 hours of drawing work lost on 25-131 P3 because CLEAN had stopped saving since UX-STD-03 and no autosave exists by the 25 Sep ruling; an AutoCAD crash in SBEAM (BUG-1275 open); a hatch fault (BUG-1278, fixed itself, cause unknown, also seen on Silvia's PC). The CLEAN loss came from a change that REMOVED working behaviour, not from too few tools.
6. **Earlier ruling already says this.** 16 Sep Test Day (memory test-day-16-sep-failed): "I NEED TO GO ONE AREA AT A TIME YOU CANT BE TRUSTED TO BUILD MORE THAN THAT". Candidate trains since then are big again: C-80 is nine PRs, S-46 is five.
7. **Installed / held.** Tim's PC: Civil 3.0.90, Manager 1.1.89, Structural 1.0.126. Colleague V3 PILOT folder: Civil 3.0.89, Manager 1.1.89, Structural 1.0.125 (Silvia installed). Candidates C-79c, S-46, C-80 built, NOT installed. CE 00's HOLD on installs, builds and colleague publishing stands.

## Proposals from this talk (NOT decisions, Tim has not answered yet)

1. **Do not rebuild from an old baseline.** Strip what colleagues SEE and what SHIPS, not the code. A rebuilt baseline would throw away the installed fixes and would not stop the kind of fault that hit this week (a change breaking a working tool).
2. **Small trusted core.** Colleagues get only the tools on the 40 everyday list that Tim has used himself on a real drawing. Everything else is switched off or hidden, still in the code and the carpark, nothing deleted.
3. **One tool joins at a time**, after Tim has used it on real drawings for a few days. Robot and Codex evidence alone does not let a tool in.
4. **Smaller, slower releases.** One small change per release to colleagues, one named person who can roll back, a "what changed" line colleagues can read.
5. **Keep the carpark and every old build.** Deleting nothing.

## Further evidence read at 16:40

1. **The 40 everyday tools are all Civil.** 38 are named (areas\EVERYDAY_TOOLS_STATUS_29OCT.md); 25 are hand-accepted by Tim (RELEASE_SCOREBOARD). Structural has no such list.
2. **Structural use, from Tim's own command log** (59 log days from 3 Jun 2026, real job drawings): about 23 different commands out of 377. DS, BEAM, BB, DS1, AB and C1 are nearly all of it. This log does not cover every command (CLEAN and SBEAM never appear in it), so it is a starting list, not the whole truth.
3. **No simple way to hide tools was found.** A search of the code by likely names found no switch that hides ribbon buttons. "Civil OFF" is a different thing (it turns Civil behaviour off for one drawing). Not proven absent: name search only.
4. **Colleague roll back is by hand.** The colleague pack says never use Manager's Roll Back Release button (BUG-441, BUG-477).
5. **Colleague risk (by dates, Silvia's PC NOT read):** the pilot folder was made Wed 4 Nov at Structural 1.0.125. The fix that makes CLEAN save again is 1.0.126, Thu 5 Nov. So Silvia's CLEAN probably does not save. BUG-1276 (unsaved-work reminder) is built but on no one's PC.

## Plan proposed 16:40 (PROPOSAL, waiting for Tim's approval, RULES 15.2)

1. **Tonight: protect Silvia.** Tim tells Silvia to save by hand; CLEAN may not save on her version.
2. **Stop.** HOLD stays. No new builds, no trains, night testing paused.
3. **Tick list.** One page, about 15 minutes. Civil from his 25 hand-accepted tools, Structural from the log list, Manager only as install and update. Tim ticks what is in.
4. **Core build.** One small build: the ticked tools on the ribbon, the rest hidden not deleted, plus the CLEAN save fix and the BUG-1276 reminder. Needs its own card and Tim's approval first (review gate).
5. **Tim first.** Tim runs exactly that build on real jobs for a week. Colleagues get it only after that.
6. **One tool at a time.** One tool in trial at a time, on Tim's PC. It joins after about three real working days with no fault, on Tim's word. Robot and Codex still check it first but cannot let it in.
7. **Colleague releases.** One small change per release, a plain "what changed" line, one named person, hand roll back written down and rehearsed once.
8. **Three numbers replace the percentages:** tools in the core; working days since lost work or a crash; colleague problems since the last release. Only bugs touching core tools are worked on; the rest wait in the carpark.

Consequences to be confirmed by Tim, NOT yet decided:
1. The Mon 16 Nov Max date comes off; Max gets the core when Tim's week is clean.
2. C-79c, S-46 and C-80 are not installed as trains; only the pieces core tools need are lifted out, the rest stay on their branches.
3. The 17 Oct ruling that a tool switches ON once Codex passes it, Rule 15 (AutoCAD never idle) and the percentages in every message would be replaced or paused. All stay in force until Tim says so.

## Open questions (unanswered)

1. Tim's marks on `areas\CORE_TICK_LIST_05NOV.md`.
2. Who is the named person for each colleague release?

## Tim's later words (recorded 22:10 PC clock)

1. "do everything in this chat". INTERPRETATION, not his words: run this plan from this chat rather than hand it to the desk. He did not say the plan is approved or answer the Mon 16 Nov question, so both stay open.
2. "so far cr/mr work but not on all objects, civil is main priority it kind of works but still needs lots of work"

Tick list for Tim to mark: `areas\CORE_TICK_LIST_05NOV.md` (suggestions only, not marked by Tim yet).

## Decisions

3. **Thu 5 Nov 2026. Max's date comes off.** Asked: "Do you approve the plan, including taking the Mon 16 Nov date off for Max, or do you want to keep 16 Nov?" Tim: "nah we can delay". No new date set: Max gets the core when Tim's week on it is clean. INTERPRETATION, not his words: he chose the plan side of that question, so the 16:40 plan is treated as approved, and its waiting builds consequence applies. Rule text (the 17 Oct Codex switch-on ruling, Rule 15, percentages in every message) is unchanged until he says so; only the plan's pause on night testing applies. He can correct any of this.
2. **Thu 5 Nov 2026. Civil comes first.** Tim: "civil is main priority". Structural follows Civil in the core work.
1. **Thu 5 Nov 2026, about 16:40 PC clock. Small core for colleagues.** Asked: "do you want colleagues on a small core only (the everyday tools you've used yourself on real drawings), with everything else switched off for them until you've used it for a few days on a real drawing?" Tim: "yep lets do that, can you devise the best way to go about this so we can feel like were on the right track"

## Tim's overnight request (recorded Thu 5 Nov 2026, late evening, PC clock)

"Can you go through overnight, check through literally every single part of the entirety of our V3 plan, UI and X plan? That's UI and UX plan. And can you also check what is built, what is not built, what needs building, what needs fixing? Can we sort out a sort of a plan on how we can truly reliably trust what we're using? And it feels like we've got like rebuild, sync, all of these other commands, which could just all be folded into one and just super simple and useful. And also the problems I have is other users, when they use our plugin, it does random stuff for them and I can't explain why it does it. So, for example, with the civil, and we open an existing drawing, it doesn't automatically sync and rebuild. It wildly guess what's what because of the old versions, and it also doesn't really make it clear where the start point of the entire system is. It just integrates so poorly and it's so bad for the end user experience that no one can rely on it, and it feels like the foundations aren't set properly. There's got to be a better way."

Correction: command counts in this file were first taken from a stale copy. Installed commits are Civil and Manager cf059dcf, Structural 8de95c34.

## Card asked for (2026-11-06 06:41 PC clock)

Asked: "Shall I write the card for the first step, the read-only line on opening a drawing, or do you want to change the plan first?" Tim: "Yes, write the card". Written: 04_REFERENCE\ux-plan\cards\UX-OPEN-01_DRAWING_STATE_LINE_CARD_2026-11-06.md. The card is NOT approved and nothing is built; its three decisions are open.

## Voice talk, Fri 6 Nov 2026 (summary pasted by Tim 2026-11-06 07:41 PC clock; written by the voice chat, which could not open the project folders, so nothing in it was checked against them)

**4. Tim's decision, his words:** "I want something that works. If it's going to take time to make that happen, then let's take the time." Quality before speed, no quick partial release.

**Agreed on the call. The summary says these are agreed but not formally recorded as decisions, so they are recorded here as agreed direction, not as his quoted rulings:**
1. Design CE around how a drafter or engineer uses it, not how it is built.
2. Handling old and revised drawings is core: about every second job is a revision. Check this drawing is the goal for the first colleague release, after the safety fixes underneath it.
3. The reader uses fixed rules with the same answer every time, no AI inside the plugin. It must recognise every older version of each CE block; anything unrecognised shows as Unknown.
4. Test set of about 10 real past jobs, messy ones included. Pass = correctly reads pits (number, invert, inlet and outlet pipes, including multiple), pipes (diameter, inverts each end, flow direction), downpipes and the pipes leaving them, tanks (size, feeding pipes, overflow destination), and the LPD (CE proposes, Tim confirms once, stored in the drawing, more than one LPD handled).
5. Two ribbon tabs, both always visible, no toggle. CE Drainage, left to right: pits, downpipes and tanks, pipes, Check this drawing, schedules. CE Design for the engineering.
6. Unknowns are fine. Simple and familiar: same blocks, same layers, a schedule that looks like theirs. Clicking a pit lights up what it is linked to.
7. Testing order: Codex on the test set, then Tim on real jobs for about 3 days, then Silvia.
8. Opening line wording: "all linked", not "up to date".

**Still open:** the rest of the opening line card; the tick list (next job: sort every Civil command into keep, fold in or hide); how problems get reported after a release; telling Silvia to save by hand.

**What changed his thinking:** faults are spread across the whole plugin, so a small core makes more sense than fixing a few tools; half the jobs are revisions, so reading old drawings properly moved up.

**5. 2026-11-06 18:54 PC clock. Silvia and the CLEAN fix.** Asked whether Silvia should get the CLEAN save fix on its own or save by hand. Tim: "forget silvia the clean and save fix is for me". INTERPRETATION: no separate release for Silvia, and the to-do to warn her is dropped. Earlier mentions of warning her are superseded by this line. CLEAN 1.0.126 is on Tim's PC; its smoke test on a copy has not been run.

## Decision 6 (7 Nov 2026): opening line card UX-OPEN-01

Asked whether CE should stay silent on non-Civil drawings and say when pit symbols were updated on opening, Tim said: "yes but some of the commands are useful in all drawings as ce tools".

Interpretation, for Tim to correct: both card choices are agreed. Only the opening line stays silent on non-Civil drawings; CE tools stay available on every drawing. The HOLD stands and nothing is built. Which tools count as all-drawing tools has not been listed.

## Decisions 7 to 12 (Thu 12 Nov 2026, trust plan interview)

Given through the question interface, so these are the options Tim chose, as worded to him. Full record with the interpretations: areas\TRUST_PLAN_INTERVIEW_12NOV.md.

7. **Finish line for the first colleague release:** "Zero wrong, all 10 (Recommended)": no wrong value shown as fact on any of the 10 test jobs, Unknowns allowed where the drawing lacks the information, plus three clean working days.
8. **Faults that take a step or release off the same day:** "Lost work", "AutoCAD crash", "Wrong value shown as fact", "Changed without telling".
9. **First colleague's AutoCAD year:** "2027". Not read from their PC.
10. **Trials:** "Group the safe ones (Recommended)": steps 1 to 3 share one trial, steps 4 to 8 one each.
11. **Start point of a network:** "The LPD itself (Recommended)".
12. **On opening a drawing:** "Nothing changes on open (Recommended)". SUPERSEDES for the core: 16 Sep 2026 "IT NEEDS TO BE IMPLEMENTED EVERYTIME YOU OPEN AN EXISTING JOB" (and 29 Oct "defualt on for everyone") and 4 Nov 2026 "ASK USER WHEN OPENS". Both stay on record, superseded 12 Nov 2026. Today's behaviour is unchanged until Check this drawing can do the job (interpretation).

Also 12 Nov, typed by Tim: old LISP tools and block files are "on my work pc"; and "can you work autonomously until tomorrow midday on anything you think is worthwhile" (read as: reading and planning only; the HOLD stands).

## Decision 13 (Thu 12 Nov 2026, about 22:40 PC clock): autonomous run, hold lifted for building and testing

Tim: "you can test, get evidence, fix, build, anything else you deem necessary"; "you can create side sessions to do seperate things, i need you to use all weekly usage before reset then complete everything before continuing to work but managing usage based on a smooth week of usage 12-13% per day"; "i cant respond after this message so please dont get stuck".

INTERPRETATION: the HOLD is lifted for building, testing, fixing and evidence. It is NOT lifted for installing on Tim's PC, anything to colleagues, or merging into the lines that ship; he named none of those. Scope, rules and status: areas\TRUST_AUTONOMOUS_RUN_12NOV.md.
