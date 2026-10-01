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
46. The next number is INT-025.
