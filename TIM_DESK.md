# TIM'S DESK: the one CE chat Tim talks to (from 29 Sep 2026)

**Owner:** `CE_ACAD / ideas / plan / 01` (Sonnet 5.5) and its successors (`/ 02` ...). **This file is yours; no other
chat edits it.**

**Why it exists (Tim, 29 Sep 2026, verbatim):** "ANOTHER CHAT THAT MANAGES MY IDEAS AND MANAGES ME SO I DONT INTERRUPT
THE MAIN CHAT AND I TALK TOT HAT INSTEAD OF THE MAIN CHAT, THAT WAY IT DOESNT GET DISTRACTED BY ME AND MY IDEAS, SUMMARY
MESSAGES AND ANYTHING ELSE" (`decisions/2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, 29 Sep about 17:15).

**The other chat:** the controller, `CE_ACAD / release-v3-colleagues / build + release / 06` (successors `/ 07` ...),
builds, tests, runs Codex and installs. Its plan is `areas/release-v3-colleagues-QUEUE.md`. **You never interrupt it**
except for the urgent cases in section 5.

## 1. Every session start, and after every compaction

1. `C:\TimOS\RULES.md` and `C:\TimOS\ROUTER.md`. Sync first: `git pull --ff-only` in `C:\CE_PLAN`.
2. This file.
3. The queue's sections 0 (who writes what) and 9 (questions for Tim, Friday facts). Read the rest only to answer him.

## 2. Your job

1. **Catch everything Tim says about CE** and file it in the same reply (ROUTER step 2: classify, file, confirm in one
   line).
2. **Tell him where it went and roughly when** it will be built, from the queue's wave order and checkpoints (section 6
   there): a week or a date, never a percentage of V3.
3. **Answer "how's it going"** from the files (section 6 below), never by asking the controller.
4. **Fridays:** the summary (section 7), with the controller's questions as tap-to-answer choices.
5. **Pass on the controller's alerts** (section 8).
6. **Manage Tim** (section 3).
7. **Route anything for another product or for TimOS** to its own file (ROUTER step 2.4).

## 3. Managing Tim (RULES 1, 2, 3 and 7)

1. **He is on holiday** until about Mon 26 Oct. Brief, calm, visual. Numbered lists with bold labels, no tables, three
   lines a paragraph, a real AutoCAD example in every explanation, clickable choices whenever you ask something.
2. **His new idea never stops the run.** File it, say when it fits, and mention what is in flight if it matters: "Pipe
   labels are being built this week; your idea follows in week C."
3. **If he asks for something that would disrupt the run** (an install now, reshuffling the whole order, publishing to a
   colleague, a big restructure): say what it costs in one line ("it would pause Structural for two days") and ask him
   to confirm with a clickable choice before passing it on. Publishing to colleagues: he ruled "No, ready for my return"
   (29 Sep); remind him of that before passing on any change to it.
4. **Bring parked items back** when they become relevant (RULES 7.5); every Friday, list what waits for his return.
5. **If he jumps ahead** (RULES 7.6), check the queue: if what he wants depends on something not yet Codex-tested, say
   so plainly.
6. **Never ask him a git, file-location or build question** (RULES 8.1).
7. **Say "I don't know"** when the files don't say (RULES 12); never fill a gap.
8. **Session end** (RULES 7.7): three short lists: what changed, what is his to test (usually nothing while he is away),
   what is parked.

## 4. The hand-over list (section 11 of this file: you write it, the controller only reads it)

1. Append only, newest last, one line per item:
   `INT-NNN — date time — class — Tim's words (short quote) — where filed — urgency`.
2. **Class:** bug / idea to build / ruling (an answer) / priority change / stop or undo / question for the controller.
3. **Where filed:** the IDEAS_INBOX line, the decisions file and section, or "carpark: the controller files it" for bugs.
4. **Urgency:** normal (the controller takes it at its next 06:00) / today / URGENT (you also send a `SendMessage`).
5. **Status:** the controller writes "taken" lines in the queue's section 13. An item not taken within 2 days: message
   the controller once.

## 5. What goes where

1. **An idea about CE:** `IDEAS_INBOX.md`, NEW section (date, his words). If he wants it built during the holiday, add an
   INT line (idea to build).
2. **A bug he saw:** an INT line (bug) with the five things of RULES 13.1 as far as he can give them: what he did, what
   he expected, what happened; add your best "test that catches it" and "steps to confirm". The controller files it in
   `BUG_CARPARK.md` (it owns that file). If it stops his work or puts data at risk: URGENT.
3. **A ruling or an answer:** `decisions\`, his words in quotes, dated (the holiday decision file for run matters, or a
   new dated topic file), plus an INT line (ruling) naming the question it answers in the queue's section 9, so the
   controller can unblock that work.
4. **A priority change:** an INT line (priority), plus a `SendMessage` if it changes today's work.
5. **"Stop" or "undo":** a `SendMessage` marked URGENT to the controller at once, then the INT line; tell Tim when the
   controller confirms.
5b. **"Wake the controller", or no Friday summary arrived, or the controller looks stopped** (its last activity in
   `list_sessions` is hours old): the Claude app has probably restarted and wiped the timers. Send the controller
   "WAKE: re-run your section 1 and re-create your timers" (`SendMessage` to its `local_...` session id), re-create your
   own Friday timer, and tell Tim in one line.
6. **A status question:** answer from the files (section 6).
7. **Something for another product** (CE_PM, Hush, finance): its idea or bug file per ROUTER (repositories: a worktree,
   never the main checkout's unsaved files); tell him where.
8. **Something about how the AI works** (rules, skills, this set-up): TimOS `IDEAS_INBOX.md` or `BUGS.md`, through a
   TimOS worktree.

## 6. Answering "how's it going" (read only)

1. **Installed now:** read the ProductVersion of the three Modern DLLs under `%APPDATA%\Autodesk\ApplicationPlugins\`,
   then GitHub #78.
2. **Built and tested:** the queue's ticks (sections 5 and 6), `PENDING_TESTS.md`, the Codex reports
   `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_*.md`.
3. **Bugs:** `BUG_CARPARK.md`.
4. **Usage:** `get_usage`; `bash "C:/Lisp Files/_CODEX_RUNNER/codex_usage.sh"`.
5. **This week:** the queue's section 9 (Friday facts) and the Lessons at the top of `areas/release-v3-colleagues.md`.
6. **Always the four words separately:** built, tested (Codex or Tim), installed, Tim-accepted (RULES 4).
7. **Verify before you relay** (RULES 6): if the controller's file says "installed 3.0.17", read the DLL yourself first.

## 7. The Friday summary

**When:** after the controller messages "Friday facts ready", or at 15:00 on Friday if it hasn't.
1. **Spot-check four claims first:** the installed version (read the DLL), one Codex PASS (open the report), one merge
   (git log of master), and **the Opus rule**: pick one merged PR that touches a LinkService, schedule, installer or
   Structural link file and check it carries an `OPUS REVIEW` comment whose stamp names an Opus model
   (`gh pr view <N> --comments`). If it doesn't, tell Tim plainly and send the controller one message.
2. **Write FOR TIM in the chat,** in this order:
   1. The four words, separately.
   2. Three things he would notice in AutoCAD, each with a real example.
   3. Up to three problems, plainly.
   4. The Claude and Codex meters.
   5. Next week in three lines, and whether the checkpoint was met (if not, the new date).
   6. Up to five tap-to-answer questions from the queue's section 9 (AskUserQuestion), each marked "ignore if busy: this
      item just waits".
3. **One line to his phone** (`PushNotification`, under 200 characters), e.g. "CE week 2: 48 items built, 41 passed
   Codex, 3.0.21 installed. 3 quick questions waiting."
4. **His answers:** into `decisions\` and INT lines (ruling) in the same reply.

## 8. Alerts from the controller

Verify with one check (#78 or the DLL), then one phone line: what happened, what was done, and whether he needs to do
anything (usually nothing). Never send routine progress.

## 9. Budget and limits

1. **You run on Tim's 10% share.** Stay small: no sub-agents except one `Explore` (model sonnet) for a big status
   question; no heartbeat except the Friday timer.
2. **Never** build, install, merge, run Codex or dispatch builders, and never edit the controller's files (the queue's
   section 0, item 3).
3. **Never** publish to colleagues, turn an unanswered question into a decision, or write a client name or address in
   any repository.
4. **Handoff** at 85-90% context (TimOS `handoff` skill): the next chat is `CE_ACAD / ideas / plan / 02`; write the
   handoff at the end of this file.

## 10. First tasks (29 Sep)

1. **Ask Tim to approve Remote Control** for this chat, so he can reach you from his phone and your Friday line reaches
   it.
2. **Set the Friday timer** as a one-shot (`CronCreate`, `recurring: false`) for Fri 2 Oct 15:07. Timers live only in
   this session (an app restart removes them) and recurring ones expire after 7 days, so **each Friday, after the
   summary, set next Friday's one-shot**, and at every session start run `CronList` and re-make it if it is missing.
3. **File three TimOS bugs** (TimOS `BUGS.md`, through a TimOS worktree; ROUTER, TIMOS). Don't change the skills
   yourself.
   1. The `deploy` skill's trigger and hard limit 4.1 don't mention Tim's 28 Sep holiday override (installs on his PC at
      the release chat's discretion), so a chat following the skill word for word could refuse to install.
   2. The `deploy` skill's section 1.4 "signing key mismatch" was corrected by the deploy chat on 24 Sep (there is no
      mismatch).
   3. The `delegate` skill's "never more than two workers" against the release charter's "up to 3": the skill needs a
      line naming the charter as the exception.
4. **Tell Tim in one line** that the desk is ready and that everything about CE now comes here.

## 11. Hand-over list

1. INT-001 — 29 Sep 18:10 — priority change + ruling — "TEMPORARY MIDDLE GROUND WHERE BUILDING STARTS AND TESTING HAPPENS OVERNIGHT" (up to 3 builders overnight, run to the limit; installs only in free windows; until Wed 30 Sep 17:40) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 18:10" — today (SendMessage sent)
2. INT-002 — 29 Sep 18:17 — bug (evidence for BUG-202 and BUG-189, not a new bug) — "CURRENT AUTOCAD SESSION IS STARTING TO LAG, THIS ALWAYS HAPPENS, WHY?" — carpark: the controller adds it to BUG-202. Desk read of his session at 18:16: AutoCAD started 17:06, 1.8 GB in use (2.7 GB private), 32 of 64 GB PC memory free, AutoCAD idle at that moment (0.1 of a core) — so not the PC running short; what he was doing when it lagged is not recorded — normal
3. Desk error, 29 Sep 18:11 (told to Tim 29 Sep evening): a stray `python3 -` in a desk command spun one CPU core at 100% for about 45 minutes, starting 5 minutes before Tim's 18:16 lag report. Found by `CE_ACAD / structural / fix / 01`; stopped by the desk at about 18:58. Lesson: never leave an empty `python3 -` in a command on Tim's PC; check for stray processes after any timed-out command.
3b. INT-003 — 29 Sep 21:15 — priority change + ruling — "I WILL RESET USAGE ONCE 100% IS REACHED SO FOR NOW BUILD UNTIL 100%" (weekly stop line 97% to 100%) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 21:15" — today (SendMessage sent)
4. Waiting for Tim (morning of 30 Sep; NOT yet a hand-over item, because each needs his yes): from `structural/fix/01` measuring 18:20-18:55: AutoCAD's own thread was starved by builds and tests running at the same time, and the graphics card was over-full. (a) Turn the NVIDIA in-game overlay OFF; (b) update the NVIDIA driver (Feb 2025); (c) close ChatGPT, Firefox and Revu while drafting; (d) the decisive test: the controller pauses all builds and tests for 20 minutes while he drafts. (d) costs about 20 minutes of the run, so it needs his click before it goes to the controller. The CE fix (Civil wakes in Structural drawings on an empty Civil record) is proposed to the controller by the investigator.
4b. Controller's addition, 29 Sep night (source: the investigator's measurements, not re-measured by the controller): builders are now on Below Normal priority, max 2 at once while AutoCAD is open. Two real CE defects found: BUG-203 (Civil wakes inside Structural drawings that hold an empty Civil record; being fixed tonight; also the likely cause of "Nothing to redo" there) and BUG-204 (Structural settings file grown to 2.4 MB of duplicate rules; fix queued for Friday). Extra Tim action: one test session with AutoCAD command GRAPHICSCONFIG > Hardware acceleration OFF, to see if the lag goes. The controller offers to stop builds entirely while AutoCAD is open if Tim prefers; ask him. Desk checked: the graphics driver is dated 15 Feb 2025 (verified, version 32.0.15.7247, GTX 1050 Ti). NOT verified: the "blue screen at 18:16" and the "43 GPU-timeout reports" - I found no crash or graphics-driver events in the Windows System log for the last 6 hours; the investigator may have read them from another log.
4c. Investigator's clean measurement, 29 Sep 18:54 (AutoCAD closed 18:52; not re-measured by the desk): the split of about 9.4 busy cores at 18:41 while Tim drafted was builds and tests about 5.5 to 6, background apps about 2.5 to 3 (OneDrive 1.7, NordVPN 0.9, ChatGPT 0.7, iCloud, nvcontainer 0.9), and the stray python about 1. AutoCAD itself used 0.43 of a core on average. Extra Tim items for the morning: NordVPN and OneDrive are heavy; OneDrive may be syncing build output or a project folder (unverified). Ask him before touching either.
5. INT-004 — 29 Sep 21:40 — ruling — "if other chat has questions for me then send them through in this chat" + four clicks (queue s9 questions 1, 2, 5 (S names; Excel pair still open), 9 all answered as recommended) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 21:40" — today (SendMessage sent); standing rule: the desk asks Tim the controller's section 9 questions whenever he wants them
7. INT-005 — 29 Sep 22:15 — ruling — clickable answers to queue s9 questions 10 (all four parts as recommended) and 11 (all three as recommended) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 22:15" — normal (SendMessage sent)
9. INT-006 — 29 Sep 22:25 — ruling (how to ask) — "theres a plan, questions should only be if the chat is unsure against the plan" — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 22:25" — today (SendMessage sent)
11. INT-007 — 29 Sep 22:50 — ruling — clickable answers to the four real gaps in queue s9 item 12: Q3 keep XCLMTXT text at 300/200 (against the recommendation), Q6 Keep/Automatic also on MOVE and STRETCH, Q7c quiet grey, Q8c this drawing only — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 22:50" — normal (SendMessage sent)
13. INT-008 — 29 Sep 23:10 — stop or undo (a hold is undone) + priority change — "i never asked for anything to stop" (resume builders and Opus reviews now, no hold at 99%; Tim resets usage himself) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 23:10" — URGENT (SendMessage sent)
15. INT-009 — 29 Sep 23:55 — priority change (pace) — "usage has been reset ... work a little faster to use 90% by that date, then once it resets it goes back to the regular cycle" (weekly 0% verified; aim near 90% by Fri 2 Oct 12:00) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 23:55" — today (SendMessage sent)
17. INT-010 — 30 Sep 00:05 — priority change (standing) — "please do not stop building unless i stop you, manage the weekly usage and throttle up/down as possible" — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "29 Sep 2026 about 00:05 (Wed 30 Sep)" — today (SendMessage sent)
19. INT-011 — 29 Sep 23:15 — priority change + ruling — "can we do a codex run tongiht also, making sure we manage codex weekly usage?" (one Codex pass 04:07 Wed 30 Sep; stop line no higher than 66%; borrows Thursday's share) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (still Tue night, about 23:15)" — today (SendMessage sent)
21. INT-012 — 29 Sep 23:30 — priority change + ruling — "stop at 90% usage, i want you to get codex to test every part of the v3 ux plan and also go above and beyond with other testing, this shouldnt be surface level" (deep multi-part sweep tonight, Codex stop line 90%, replaces the 66% of INT-011) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Tue night, about 23:30)" — URGENT (SendMessage sent; the launch is at 04:07 or earlier)
23. INT-013 — 29 Sep 23:45 — ruling (how progress is reported) — "when i ask for percentage its always built, and tested by codex, my plan is to barely test and let codex do that but it needs to be tested well by codex" (relayed by plan/05; two figures, Built % and Codex-tested %; Codex testing is the main quality gate) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Tue night, about 23:45)" — normal (SendMessage sent)
25. INT-014 — 29 Sep 23:55 — priority change (adds to INT-012) — "get it to also think about the user experience of all of these things" (Codex judges and ranks the UX of every item in tonight's sweep, with improvement suggestions) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Tue night, about 23:55)" — URGENT (SendMessage sent; the launch is after 00:37)
27. INT-015 — 30 Sep 00:10 — ruling — clickable answers to queue s9 items 13 (C4 card, four questions) and 14 (S4 card, four questions), all eight as recommended — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Tue night, about 00:10)" — normal (SendMessage sent)
29. INT-016 — 30 Sep 08:40 — ruling — clickable answers to queue s9 items 15 (a: one shared notes file with path in Settings; b: the office's STEP TAG block) and 16 (storm frequency filled from the council profile with its source) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 08:40)" — normal (SendMessage sent)
31. INT-017 — 30 Sep 11:10 — idea to build (a decided item, handed over) — Tim pointed the desk at `C:\CE_PLAN\CHAT_PROMPT_MANAGER_SETTINGS_TRANSFER_01.md` (M-SET-01 Move My Settings; his words are in `decisions\2026-09-30_SETTINGS_TRANSFER_IN_PLUGIN.md`: "yes ship it inside the plugin, write the prompt") — the controller queues it in the Manager lane and dispatches a builder with that prompt as the brief — normal (SendMessage sent)
33. INT-018 — 30 Sep 12:15 — ruling + priority note — usage note ("theres some of my own usage in there, so manage how youre using it and i will work within the 10% buffer", "5 hour window is fine") plus three clicks: Kingston storm frequency 5 years with source (queue s9 item 17), Move My Settings folder "CE Settings Transfer", button visible to everyone — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 12:15)" — normal (SendMessage sent)
35. INT-019 — 30 Sep 13:45 — priority change (more capacity) — Tim opened a second Claude on his Team account ("Team chat is open") to work beside the run while he is away — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 13:45)"; brief `C:\CE_PLAN\CHAT_PROMPT_TEAM_LANE_01.md` — today (SendMessage sent): name a build lane for it
37. INT-020 — 30 Sep 14:00 — ruling — Kingston 5 years confirmed after seeing the 26 to 30% less storage on issued sheets; a per-job "Land use" field in job setup (CDSETUP) that CDCALC reads — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 14:00)" — normal (SendMessage sent)
39. INT-021 — 30 Sep 16:10 — priority change + ruling — "I WILL USE A RESET TOKEN FOR CODEX AND WHEN I FINISH TODAY YOU HAVE FREE REIN TO USE MY COMPUTER TO TEST AS MUCH AS YOU NEED WITHIN THE USAGE LIMITS" (Codex reset by Tim; back-to-back sweeps on his PC after he finishes today; stop line 90%) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 16:10)" — today (SendMessage sent)
41. INT-022 — 30 Sep 16:20 — priority change — "CAN YOU GET CODEX TO DO SOME BUILDING AS WELL, I NEED TO GET IT TO 100% USED BEFORE MY FLIGHT TONIGHT AT 8:15PM" (Codex builds windows now to drain 84% to 100% by about 17:30; stop line 100% for this drain; Tim resets before he leaves) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 16:20)" — URGENT (SendMessage sent; the drain must finish before he leaves)
43. INT-023 — 30 Sep 16:35 — ruling (model) — "IN FUTURE IF WE NEED TO BUILD WITH CODEX OR HAVE SPARE WEEKLY USAGE THEN WE CAN USE GPT SOL 6.1" — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 16:35)" — normal (SendMessage sent)
45. INT-024 — 30 Sep 19:40 — status + ruling reminder — "codex usage reset ill be on the plan for the next 24 hours": Codex reset done; Tim is on the flight, unreachable about 24 hours; questions wait — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "30 Sep 2026 (Wed, about 19:40)" — today (SendMessage sent)
4d. Parked for Tim's return (not blocking; filed 1 Oct by the desk, from the controller's review of PR #466 BUG-250): after the older beam-linking "Yes" answer, should OOPS bring everything back by itself like the Civil drains do, or keep the confirmation line? Beam linking is OFF by default, so nothing waits on it.
4e. Parked for Tim's return (design question, filed 1 Oct by the desk, from the controller's adversarial review ADV 4 of the Civil batch): in a drawing whose UNITS are Metres but whose CE pits are millimetre-sized (the PIT command always inserts at scale 1), PR #453 (BUG-270) makes every reach 1000 times tighter than 3.0.17 and nothing warns. The controller files it as a carpark entry. Not asked of Tim now.
4f. Parked for Tim's return (design decision, filed 1 Oct by the desk, from the controller): Structural footing commands expect millimetre drawings; today a drawing in cm, metres or inches passes the "FST expects millimetres" check silently, so pads, schedules and load paths come out 10 or 1000 times wrong. The controller is building: refuse with one plain line for cm / m / inch drawings; millimetre and unitless drawings unchanged. Tim's decision to review (he can also choose "convert units automatically").
4g. Parked for Tim's return (command-review item per the AGENTS.md review gate, filed 1 Oct by the desk, from the controller): BUG-283, CDIMPORTXCIVIL: a design note only, no code; Tim's review of that command is needed before any change (the controller wrote the note in the C-5 G4 PR).
4h. Parked for Tim's return (three design questions, filed 2 Oct by the desk, from the controller's return-page list; none blocks the run): (1) BUG-311: a palette change is rolled back when CDRUNSOLVE or CDPROPAGATE is cancelled: accept this, or make palette edits wait until the command ends; (2) a 17-degree wall landing ends about 1 mm off centre: should it land at the pit centre or at the wall; (3) do the Save Draft and Confirm buttons belong on all five CDDESIGN tabs (Setup and Results lack them today).
4i. WARNING for Tim's return page (filed 2 Oct 03:00 by the desk, from the controller): BUG-328 (HIGH): a grade-locked pipe's invert is worked out 1000 times too short in a METRE drawing. It is in the installed 3.0.20 and in every earlier release (old code, not caused by the C-5 batch); found by the Opus review of #503. Millimetre drawings are unaffected. Fix: Opus builder on branch claude/c6-metre-grade (one helper for every place that treats drawing units as mm), to install in C-6. Until C-6 is installed: do not rely on grade-locked pipes in a metre drawing.
4j. UPDATE to 4i (2 Oct 03:50, from the Opus review of #508): the BUG-328 fault is WORSE: in a METRE drawing one pit MOVE reset a grade-locked pipe's bottom level to its top level, i.e. FLATTENED the pipe; pipes in existing metre jobs may already be flat and nothing finds or repairs them (a repair command is needed, see carpark BUG-328 notes). In the installed 3.0.20 and every earlier release; millimetre drawings unaffected. QUESTION FOR TIM (blocks nothing; the fix warns and holds levels): do his office templates have UNITS = Metres but pits drawn as millimetre blocks (scale 1)? Such "mixed units" drawings get one line naming the pipe instead of a guess.
4k. Fri 2 Oct 11:20 (from controller adversarial reviews, for Tim on return): (a) the one real exposure left in C-6 is an office template with UNITS = Metres but drawn in millimetres: drafter-started writers (batch editor, CDPROPAGATE, Pit Schedule, repair proposal, split labels) can write 1000x numbers (BUG-338, builder widening the guard); Tim should say which templates are Metres vs mm. (b) BUG-337: the CD arrow shows flow P1 to P2 but Edit Pipe shows P2 to P1 on a Codex test copy: which is the right flow direction on that pipe? unresolved. (c) BUG-341: the Structural corner grip makes a kite and the record stays 600x600 (S-6 builder).
4l. Sat 3 Oct 00:15 (reconfirm with Tim, from controller 06): (1) INT-030 "pipe lands at the pit centre" REVERSES his 29 Sep ruling "Snap automatically + note" (new pipe ends go to the inside WALL of the pit). The 1 mm that raised it (BUG-308 b) was the 0.6 mm pit-size fault already fixed by #497, so centre may rest on a mistaken premise. PR #544 is built but stays OUT of the next train until Tim reconfirms and an Opus review passes. (2) PR #543 CDDESIGN buttons on all five tabs: on the four non-Start tabs Confirm LPD stays GREY with a plain hover reason until an outlet is picked on Start; alternative is to hide it there. Default grey; rides the next Civil train.
4m. WARNING for Tim on return (Sat 3 Oct 03:40, from the controller headless probe BUG-350, installed Civil 3.0.22): (1) Pit Schedule edit then "Revert override" renames a pit whose number does not start with P (C1 becomes PC1 on label, record and both pipes From/To): until the C-8 fix installs, do not use Revert override on non-P pits. (2) The batch Edit of 2+ pipes (Apply) is refused on the real route for almost every grade (label shows achieved grade, check wants the typed one); rolled back, nothing damaged; when it succeeds it is one undo and correct. (3) ARRAY of a pit/pipe is treated as ERASE (label, CL text, band deleted; U restores) = BUG-347. (4) PIT always draws at scale 1 (mm size) whatever UNITS says, so every UNITS-Metres drawing using PIT is "mixed units" to CE: ties to INT-025 ("some are"). Train C-8 (fixes 1-4 plus CDDESIGN buttons #543, not #544) is being built.
4n. Sat 3 Oct 01:55 (plain questions for Tim, from controller 06, BUG-351): (a) typing a NEW pit number such as C2 in the Pit Schedule still renames the pit PC2 (the old "P" rule): keep the number exactly as typed? (b) a level typed in the Pit Schedule on a pipe with a FIXED grade changes only that end, so the label keeps "1 IN 100" while the levels give about 1 in 67 (how schedule edits have always worked): or move the far end to keep the grade, as Edit Pipe does? Pending with 4l: wall vs centre (#544) and Confirm LPD grey vs hide (#543).
4o. Sat 3 Oct 05:10 (command card, needs Tim before #547 is added to a train): S7_FOOTING_DRAW_UNITS_CARD (footing DRAWING commands PFC, SF, THC, FADOPT, CSLOADPATH, CSPIER convert in a cm / metre / inch drawing; schedule commands already convert in 1.0.91): the AGENTS.md review gate says Tim approves the card before code ships. Desk section-8 rulings (hold wording, quick tools convert, depth stays mm, CSPIER keeps picking) are desk interpretations. PR #547 is held OUT of train S-8 until Tim approves. Asked Tim in text 3 Oct 05:10.
4p. Sat 3 Oct 08:35 (plain questions for Tim): (a) Settings window: Enter inside a number box saves the WHOLE window: change it so Enter only commits that box (recommended) or keep? (b) pasting CE pits/pipes into a drawing with NO drainage: should it wake the Civil tool for that paste (one plain line "run CDREPAIR", nothing else) even though Civil stays silent in Structural drawings? Default yes, only when the pasted objects are CE pits/pipes (BUG-366, BUG-342 part 1). Also: driver sessions 5-8 killed AutoCAD several times (3 Oct 02:00-07:00): the CE Admin outbox will show those as "did not close cleanly" crashes (they were test kills).
4q. Sat 3 Oct 13:00 (FYI for Tim, no action): to free disk the controller deleted the 20 OLDEST of 36 installer archives in C:Lisp FilesSUPERSEDEDCE_CVL_SUITE (about 370 MB each, regenerable from git by build_installer.ps1; list in C:_rc_scratchsuperseded_deleted_list.txt; the 16 newest kept) plus old payload candidates in C:_rc_scratch. C: free is 22.7 GB.
46. INT-025 to INT-040 taken 2-3 Oct (see decisions file and IDEAS_INBOX). The next number is INT-041.

## 12. Handoff notes (written Fri 2 Oct 00:45 by `CE_ACAD / ideas / plan / 01`, context 90%; successor `CE_ACAD / ideas / plan / 02`)

1. **State:** Tim is on holiday, travelling (flights), back about 26 Oct; he reads the desk chat on his phone. Installed on his PC at 00:22 Fri 2 Oct: Civil 3.0.20, Manager 1.1.20, Structural 1.0.88 (read the DLLs to confirm). Move My Settings (#424 MERGE, #425) not installed. Codex week resets Wed 7 Oct 20:52 (about 58% used at 00:40); the main Claude week resets Fri 2 Oct 12:00 (66% at 00:40; Tim's rule: use about 90% by then); the Team account week resets Sat 3 Oct about 13:00.
2. **Standing rulings (decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md, newest at the bottom):** never stop building unless Tim says; questions only when the plan is silent; build until pace; Codex builds on gpt-6.1-sol; Codex stop line 90% and the budget in queue item 55; the desk manages the controller, the Team workers and all three meters (INT-001 to INT-025, this file section 11).
3. **The controller** is the Desktop chat `CE_ACAD / release-v3-colleagues / build + release / 06` (session `local_2a42adbe-e1ed-4689-9133-1f2c71250d96`): message it with `SendMessage` to that local session id (the old uds pipe address goes stale after an app restart); wake it the same way if `get_session` shows it idle for hours. It stamps clock times ahead; trust `date`.
4. **The Team workers** (Tim's Claude Team account, config folder `C:\Users\TimothyBrand\.claude-team`, Remote Control allowed): run them HEADLESS and BOUNDED, the only reliable way: `claude -p --model opus --permission-mode bypassPermissions --output-format text < jobfile > outfile`, started with `Start-Process cmd.exe /c ...` (hidden, working directory C:\Lisp Files\CE_ACAD_PLUGIN, priority Below Normal) with `CLAUDE_CONFIG_DIR` set to the Team folder; job files live in the desk scratchpad (`review_headless_N.txt`, `build_headless_N.txt`); check `Get-CimInstance Win32_Process -Filter "Name='cmd.exe'"` for a command line containing `build_headless` or `review_headless`: if absent, the run has ended, so relaunch with a new job file (new PRs to review, review items to apply, next carpark items). The build worker is "build/02" with its ONLY log `areas/release-v3-colleagues-TEAMLANE2_LOG.md` (the old TEAMLANE_LOG.md is poisoned: interactive sessions kept "standing down" because they mistook the controller's builder agents for a peer; never restart it interactively); the reviewer logs to `areas/release-v3-colleagues-REVIEWLANE_LOG.md`. Interactive Team sessions and the resume path stopped producing output; the Team usage can be read with `claude -p "/usage"` under the Team config folder.
5. **Keep-alive:** the desk's own timers are unreliable; the working pattern is a background `sleep 1500` Bash command whose completion notice wakes the desk (restart it each time) plus a check cycle: meters (`get_usage`; Team via `claude -p /usage`; `codex_usage.sh`), the controller's and workers' logs, installed DLL versions, whether AutoCAD or `*.off_ctrl` renamed bundles exist (never read DLL versions while the bundles are renamed for a control test; wait for 'GUARD VERIFIED' in `C:\Lisp Files\_CODEX_RUNNER\out\ctrl_bundles.log`).
6. **Timers:** CronList shows a one-shot Friday summary at Fri 2 Oct 15:07 (session-only; recreate if missing). The Friday routine (section 7) is due: four-word summary, two figures (Built %, Codex-tested %), meters, questions the plan does not answer.
7. **NEVER block on a question (Tim, Fri 2 Oct 23:20, "cant have the question problem again"):** do NOT use AskUserQuestion while Tim is away: it held the desk turn about 8 hours (15:40 to 23:20) and building stopped (keep-alive, Team-worker relaunches and controller wakes all queue behind a blocked turn). Ask as a short numbered text list he can answer by typing ("1a 2b"), marked "ignore if busy", and keep the keep-alive running. Friday summary questions too.
7. **Waiting for Tim's return (section 11 items 4 to 4h):** the OOPS-after-Yes design, the metre/millimetre pit question, the Structural units guard (ask, default No), CDIMPORTXCIVIL design note (BUG-283), BUG-306 (New Pit writes CD_Settings.json), BUG-311, the 17-degree wall landing, Save Draft/Confirm buttons on all CDDESIGN tabs, BUG-276 "Assumed", the Structural palette reopen idea (IDEAS_INBOX).
8. **Lessons this run:** Redo failures after pan / drawing switch / autosave / hatch pick / QSAVE are NATIVE AutoCAD (control D, all CE bundles off); Structural 1.0.87 lacked a redo guard (fixed in 1.0.88); a test run once rewrote Tim's real CS_Settings.json (BUG-294, additive, copy kept); the Claude app restarts stop the Team workers and the controller: after any restart, relaunch the workers and wake the controller by session id.
9. **Lesson (2 Oct 03:00):** the desk's PowerShell and the controller's shell read a SANDBOX copy of the registry (BUG-238), not Tim's real profile; the desk's 02:21 "profile Tim exists and is current" was a sandbox read. The REAL check is a process started through WMI (the controller's investigator did it: Tim's real profile is INTACT, acad.CUIX unchanged since 00:34, nothing written since 30 Sep 16:43). The real read-only export is `C:\ce_rc_scratch\acad_profile_backup_REAL_20261002` (local only); the 02:25 backup in `acad_profile_backup_20261002_0225` is the sandbox copy and is marked DO NOT IMPORT. Codex must start AutoCAD only through launch_app or the Start-menu shortcut, never Start-Process or /p. The AcSmNav crash was probably AutoCAD's own (a .NET out-of-memory in Sheet Set Manager after an autosave), not CE code.

## 12b. Handoff addendum (written Sat 3 Oct about 08:45 by `CE_ACAD / ideas / plan / 01`, context about 70%)

10. **Installed on Tim's PC (read the DLLs, never trust this line):** Civil 3.0.24, Manager 1.1.24, Structural 1.0.92 (installed Sat 3 Oct 06:32-06:38). Tim has accepted NOTHING in AutoCAD yet. Codex stood at 89-90% (stop line 90); Tim said a Codex reset is expected "today or tomorrow" and will type "Codex reset done" in this chat; until then NO Codex fresh probe (a probe costs a point). When he says it: message the controller, one fresh reading, then the window-only pass verifyW1 (18 items, ceiling 88).
11. **Own AutoCAD driver (Tim INT-035..040):** `C:\Lisp Files\_ACAD_DRIVER\acad_driver.ps1` (README.md, UI_MAP_PLAN.md, UI_MAP_2026-10-03.md, UI_MAP_SESSION7_2026-10-03.md, TESTPLAN_C8_S7.md, TYPED_FORMS_S8_C9.md; ~650 offline tests). Typed commands through COM `-Route Send` with COMPLETE one-line chains is the proven path; NEVER leave a prompt waiting (that wedged AutoCAD twice: driver fault, proven by a full dump, CE cleared); `ui` family drives CE windows by Windows UI Automation; shared lock C:\ce_rc_drv\ACAD_LOCK.json; launch AutoCAD only by `launch` (explorer hand-off). Driver sessions 1-9 done (reports DRIVER_RUN1..9 in C:\Lisp Files\_TEST_COPIES_20260923). Sonnet agents write/run it (ids change per session); tell the controller BEFORE and AFTER each session (it holds installs and consoles).
12. **Team workers:** the headless job files are in the desk scratchpad (`...\scratchpad\build_headless_N.txt`, `review_headless_N.txt`, current N = 43 / 52); relaunch snippet in section 5; they are cheap when idle (the reviewer only when a PR is waiting).
13. **Waiting for Tim (plain, typed answers, nothing blocks):** pipe landing wall vs centre (#544); Confirm LPD grey vs hide (#543); new pit number C2 renamed PC2 keep as typed? (BUG-351 a); typed level on a fixed-grade pipe (BUG-351 b); #547 footing drawing-units CARD approval (item 4o); which templates are Metres with mm pits (verifyTPL); Settings Enter saves the whole window (item 4p a); paste of CE pits/pipes into a drawing with no drainage prints one CDREPAIR line (item 4p b, default yes). Also parked: BUG-354 (his own ce_suite_startup.lsp prints a CE_StrucPlus 'LISP not found' line: patch file prepared, NOT applied, his profile).
14. **Pace:** main Claude weekly 19% at 08:18 (resets Fri 9 Oct 12:00, plan about 13 points a day, controller throttled to idle at the desk's request); desk checks every 25 minutes (keep-alive pattern, section 5). Usage-launch watch: a Sonnet sweep once a day (USAGE_LAUNCH_WATCH_2026-10-03.md first sweep): never spend on a rumour alone.

## 12c. Handoff update (Sat 3 Oct about 14:25 by `CE_ACAD / ideas / plan / 01`, context 82%; successor `CE_ACAD / ideas / plan / 02`)

15. **Installed (read the DLLs):** Civil 3.0.25, Manager 1.1.25, Structural 1.0.94 (Civil C-10 at 13:28, Structural S-10 at 12:07). Everything testable by the driver passes in REAL AutoCAD (driver runs 1-14, reports `C:\Lisp Files\_TEST_COPIES_20260923\DRIVER_RUN*_2026-10-03.md`): undo counts (BUG-358/368), layer rules (BUG-367), label keep (BUG-363/361), locked-layer lines (BUG-357/364), CSREOBAR (BUG-366). Tim has accepted NOTHING yet. Still needs a mouse/human: grip-drag of a pad corner / pipe end, FEDIT strip-near-pad pick, palette/ribbon look: Codex verifyW1 (19 items + the hover on grey Confirm LPD, cap 88, waits for Tim's "Codex reset done" in this chat; NO Codex probe before that).
16. **Open Team PRs / holds:** HOLD (need Tim): #544 pit-centre landing (wall vs centre), #567 quiet paste catcher (card + draft; ships after his yes on the paste question), #547 footing drawing-units conversion CARD, #424 settings tool (Team fixed its HIGHs, reviewer re-reads; source only, no release). Team build worker is on BUG-372 (raw handle wording); anything MERGE gets assembled by the controller into C-11 / S-11 (controller idles until then).
17. **Driver sessions:** the pattern is: tell the controller BEFORE and AFTER (it holds installs and consoles), launch a fresh Sonnet agent with the full rules (copies only, complete one-line chains, STOP rule, wedge rule, no python, lock name exact), write the report, then send "DRIVER SESSION ENDED". The controller must send "INSTALL VERIFIED" before any session after an install; read the DLLs yourself too.
18. **Waiting for Tim (typed answers, never a blocking tool):** see item 13 plus the Codex reset message. Meter: main Claude weekly 23% at 14:20 (resets Fri 9 Oct 12:00; plan about 13 a day; Sun 12:00 line about 26).
47. INT-041 — Sat 3 Oct 16:20 — priority change + ruling — "you can fire up the codex testing again" (restart Codex verifyW2b; hover and CPU items skipped) — `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`, section "Sat 3 Oct 2026 about 16:35" — today (SendMessage sent). Desk plan/02 took over at 16:08; the next number is INT-042.
19. Sat 3 Oct 17:15 (verifyW2b result, for Tim's return page): Codex verifyW2b 16:13-17:06: 4 PASS (footing corner grip + one undo + redo; CDDESIGN Save Draft; New Pit cover level + one undo), 2 FAIL (Edit Pipe Cancel marks the drawing modified, fix #581; scaled-pit Edit label position unclear), 5 BLOCKED. TEMPLATES (INT-031 answered): all four office templates Codex read are INSUNITS 4 (millimetres); NONE is Metres. Tim's "some are Metres" is not found in these four: the mismatch must come from real job drawings. Report `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFYW2B_2026-10-03.md`. Tim has accepted nothing.
20. Sat 3 Oct 17:45 (driver run 16, BUG-361, for Tim's return page): clean CPU test on a test copy. AutoCAD idle uses about 0.05 cores. One screen-reading call does not raise it and nothing stays raised after the call returns. A reader that keeps scanning (a 13 s loop of `ui scan "CE Inspector"`) raised AutoCAD to about 1.1 cores while each scan ran (readings averaged 0.4 to 0.7). So a screen-reading tool attached and polling costs about 1 core while it reads: this fits the lag Tim saw while screen-control tools were running. Codex's own computer-control was NOT attached in this test. Report `C:\Lisp Files\_TEST_COPIES_20260923\DRIVER_RUN16_CPU_2026-10-03.md`. Suggested: no screen-control tool runs while Tim drafts (already the rule); worth one more test with Codex attached if the lag persists.
21. Sat 3 Oct 19:50 (driver run 17, first check of the installed Civil 3.0.26 / Manager 1.1.26, copies only, real AutoCAD): 8 PASS, 0 FAIL, 2 BLOCKED (layer-change + Save half of Edit Pipe; Manager Drawing Repair / Project QA pages: the driver cannot see the window titled "CE Suite Manager"), 1 NOT TESTED (rising-main fixture missing). PASS: Quiet start wording, Edit Pipe Cancel leaves DBMOD alone, Edit 2 Pipes on a 249 m pipe (no rollback, label 1 IN 100, one U), clean-up line names "pipe P8 -> P11" not a handle, Manager footer and buttons, plain accessibility names, Structural-only drawing quiet, versions 3.0.26 / 1.1.26. REAL FINDING (C9, #580 reviewer's warning confirmed): Pit Schedule row P3 shows IL (Inlet) and IL (Outlet) BLANK while the plan shows IL 18.10. Report `C:\Lisp Files\_TEST_COPIES_20260923\DRIVER_RUN17_2026-10-03.md`. Tim has accepted nothing.
