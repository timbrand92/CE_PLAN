# Control room set-up (desk plan/03, Sun 18 Oct 2026): keeping the main chat's memory small

Why: the main desk chat reached 80 percent of its memory in about two days because every agent report and every test result came back into it. Rule from now on: the control room holds DECISIONS and ONE-LINE STATUS only. Detail lives in files; stages run inside sub-chats ("captains") that return one short paragraph.

## 1. What can and cannot be a separate chat
1. The desk chat has no tool to open a NEW top-level chat (the session-start tool is not present in this session). Tim can open a new chat himself at any time; every chat below reads ONE file to start.
2. Sub-chats the control room CAN start: background agents (Agent tool). They run on the Max account, cost Max usage, and report back once. Nested agents (an agent starting agents) are allowed only one at a time per captain, because of the 2026 history of runaway nested workers racing on shared files.
3. Team-account jobs (launch_job.ps1) and the Codex queue run with no chat at all and report by files.

## 2. The map
1. **Control room (this chat, CE_ACAD / ideas / plan / 03, then 04):** reads desk_tick, decides, answers Tim. Never reads a full report: reads the first 20 lines (the "answer first" block) only.
2. **Pipeline captain (Max agent, Sonnet, one per train):** owns one release train end to end: review the open fix drafts -> fixes -> assemble -> finalize -> payload. It starts the stage agents ONE AT A TIME with the proven briefs (see the stage prompts below), reads their short reports, and returns to the control room a paragraph of at most 100 words: branch, head, GO/NO-GO, candidate folder, open risks. The install and the robot pass stay with the control room (they touch Tim's PC; a few tool calls).
3. **Robot lane (Team jobs):** tester_runNN.txt files, one pass at a time; each report has an "answer first" block.
4. **Codex lane (queue):** QUEUE_18OCT_PLAN.md style queue files; results in CODEX_LOOK_*.md; filed as bugs by a Team filing job.
5. **Filing lane (Team jobs):** triage_hunt_job.txt and triage_look_job.txt turn hunt and look reports into BUG_CARPARK entries and fix queues.
6. **Builder lanes (Team loops):** lane_loop.ps1, bug fixes only.

## 3. Stage prompts (the proven briefs; the captain copies the newest one and renumbers)
1. Opus review of a set of draft PRs: the C-42/C-44 review prompts (agents "Opus review of Hunt E fix drafts", "Opus review of fix drafts 1342 to 1360 / 1361 to 1381" in this chat's history; text also in the REVIEWLANE_LOG entries' headers).
2. Fixers for MERGE-WITH-FIXES: "Fix review findings on ..." prompts.
3. Assembler: TRAIN_C4x_ASSEMBLY_REPORT briefs; finalizer: TRAIN_C4x_FINALIZER_REPORT briefs; payload: PAYLOAD_C10xx_REPORT briefs (candidate folder next free c10NN).
4. Install: desk scratchpad script desk_install_c44.ps1 is the model (copy, renumber: candidate folder, versions, prior head). Gates: no acad/accoreconsole, no robot cmd, no settings_guard.json, no Codex START without END, ACAD_LOCK.json expired or absent.

## 4. Reporting rules that keep the control room small
1. Every agent prompt ends with: "Final report under 100 words" (stage agents) and "write detail to the named CE_PLAN file".
2. The control room never pastes a report: it reads the "answer first" block of the file, and answers Tim in the FOR TIM block (at most 8 lines) plus a 3-line technical block.
3. The 2-hourly tick runs desk_tick.ps1 only and reports ONLY changes.
4. State lives in files: DESK_HANDOFF (sections 12 to 19+), QUEUE.md entries, START_HERE state block, QUESTIONS_FOR_MONDAY.md, REVIEWLANE_LOG. A fresh chat reads START_HERE.md then DESK_HANDOFF and is back in business in minutes.

## 5. Next chat (name CE_ACAD / ideas / plan / 04)
Start it when this chat passes about 85 percent: the first message is "read C:\CE_PLAN\START_HERE.md then the DESK_HANDOFF file addenda 12 to the last; recreate the 2-hourly desk tick; check for the desktop computer-use tool". Tim turned computer use ON on 18 Oct.
