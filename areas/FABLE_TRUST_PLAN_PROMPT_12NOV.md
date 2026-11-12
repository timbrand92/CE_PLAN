═══ RUN CONFIG ═══
MODEL:     Claude Fable 5.1 (claude-fable-5-1)
THINKING:  max
WHY:       Planning the rebuild of trust in the whole plugin. A wrong plan costs weeks, so it is worth the strongest model and long thinking.
DOWNGRADE: Claude Opus 5.5 at high. Use Opus if this runs on the Team account (Tim's 12 Oct rule: Team uses Opus, not Fable).

NAME THIS CHAT: CE_ACAD / trust plan / plan / 01

Run this in the Claude Code desktop app with the folder C:\Lisp Files\CE_ACAD_PLUGIN open, so the chat can read C:\CE_PLAN and the code.

---

You are planning, not building. Your job is to turn the trust plan for the CE AutoCAD plugin into a complete plan that Tim can approve one step at a time. Tim is a civil and structural engineer in Melbourne, not a coder.

## 1. Read first, in this order

1. C:\TimOS\RULES.md (the only rulebook) and C:\TimOS\ROUTER.md.
2. C:\CE_PLAN\START_HERE.md, then `git pull` in C:\CE_PLAN.
3. C:\CE_PLAN\decisions\2026-11-05_TIM_PLUGIN_STRATEGY_TALK.md. These are Tim's decisions in his own words, including decisions 1 to 6.
4. C:\CE_PLAN\areas\V3_TRUST_PLAN_06NOV.md, the proposal you are turning into a full plan.
5. C:\CE_PLAN\areas\CIVIL_COMMAND_SORT_06NOV.md (questions 1 and 2 are answered) and CORE_TICK_LIST_05NOV.md (the Structural and Manager parts).
6. C:\CE_PLAN\04_REFERENCE\ux-plan\cards\UX-OPEN-01_DRAWING_STATE_LINE_CARD_2026-11-06.md, the first card. All three of its decisions are answered.
7. The four audits in C:\CE_PLAN\areas\: AUDIT_FOUNDATIONS_CIVIL_06NOV.md, AUDIT_V3_CIVIL_06NOV.md, AUDIT_V3_STRUC_MGR_06NOV.md and AUDIT_V3_UX_06NOV.md.
8. C:\CE_PLAN\BUG_CARPARK.md, the Design Guidebook v1.3 notes in CE_PLAN, and the AGENTS.md review gate in the plugin repo.

## 2. Where things stand

1. **Tim's words:** "I want something that works. If it's going to take time to make that happen, then let's take the time."
2. **Decided:** colleagues get a small core, Civil comes first, and the colleague pilot date is off. The first colleague release waits for Check this drawing, which comes after the safety fixes. The order of testing is Codex on a test set, then Tim on real jobs for about 3 days, then colleagues. There are two always-visible tabs, CE Drainage and CE Design, and CE tools stay available on every drawing.
3. **HOLD:** no installs, builds or colleague releases until Tim lifts the hold himself.
4. **Code truth:** the repo's master branch is thousands of commits behind what ships. Read only the installed commits, in the read-only copies C:\CE_WORK\scratch\audit_civil (Civil and Manager, cf059dcf) and C:\CE_WORK\scratch\audit_struc (Structural, 8de95c34). Check the installed DLL versions before trusting this line.

## 3. What to produce, all in C:\CE_PLAN

1. **The full plan:** V3_TRUST_PLAN_06NOV.md becomes one section of the one plan, not a second plan (RULES 9.1). Give each step its goal, what the drafter sees, what it depends on, how it is proven (robot, then Codex, then Tim), how to undo it, and its risk.
2. **Draft cards for steps 2 to 8,** in the same shape as UX-OPEN-01: what you would see, the full experience (trigger, Cancel, Undo, save and reopen, locked layers and Xrefs, 2022 to 2024 users), settings, what gets reused, how it is proven, decisions for Tim, and what is not yet known. Mark each card DRAFT.
3. **The test set:** the pass criteria for about 10 real past jobs (pits, pipes, downpipes, tanks, LPD), and what Tim must pick at his PC. Never copy client names or addresses into any file.
4. **The fixed-rule reader:** a design for recognising every older version of each CE block, with Unknown for anything it cannot match. It uses no AI.
5. **The release process:** who looks after each colleague release, how problems come back, and what one release contains. Draft this from evidence. It is not decided.
6. **The five trust rules** as a checklist each core tool must pass, and a one-page note format per core tool.
7. **A dependency picture:** one mermaid flowchart of the steps, with at most 8 boxes.

## 4. Interview Tim to fill the gaps

Tim may be on his phone, so send questions in chat.

1. **One question at a time.** Answer first, give one recommendation and why, then the question. No menus.
2. **Questions still open:** Civil sort questions 3 to 11 (start with New Job at the left end of CE Drainage), the Structural and Manager marks on the tick list, who looks after each release, how problems get reported, and any card decision you add.
3. **Don't ask what CE_PLAN already answers,** and say which document you checked.
4. **Record each answer straight away:** Tim's exact words in quotes, your reading of them marked as an interpretation, and a line in areas\release-v3-colleagues-DESK_LOG.md. Never turn an unanswered question into a decision.

## 5. Limits

1. **No code:** no code changes, builds, tests, installs, AutoCAD, or messages to colleagues. Don't lift the hold.
2. **Writes go in C:\CE_PLAN only.** Commit and push C:\CE_PLAN as you go. Never put a secret or client data in any file.
3. **Subagents are welcome.** Tim has usage to spend. Use them to read code and to check claims independently, but verify any key claim yourself before it goes into the plan, and say which claims you checked.
4. **Separate the four states:** built, tested, installed and accepted are different things, and a green build proves nothing in AutoCAD.

## 6. How to write for Tim

Australian English and metric, with Melbourne time. Use numbered lists with bold labels, and NO TABLES. Answer first, in short plain sentences. Use AutoCAD and drafting words, never software words. Use pictures where they help (mermaid, before and after). Don't offer to stop; Tim says when he's done.

Start by reading, then tell Tim in five lines what you found and what you will produce. Then ask your first question.
