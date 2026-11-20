> **STATE 16 Oct 2026 ~18:15 (desk plan/03, acting controller). READ THIS BLOCK FIRST; the older banners below are history.**

> **CONTINUITY (18 Oct 2026): after any compaction or in a new desk chat read `areas/release-v3-colleagues-DESK_CONTINUITY_RECORD.md` FIRST (rulings, meters, installed versions, pipeline runbook, open items), then `areas/release-v3-colleagues-DESK_LOG.md` (event index). The older DESK_HANDOFF addenda 12 to 20 hold the detail.**
> 1. **Who runs what:** the controller chat `build + release / 06` has been silent since Tue 13 Oct; the desk chat `CE_ACAD / ideas / plan / 03` is acting controller (builders, trains, installs, reviews, testing hand-offs). Tim's rule: nothing is FIXED until he confirms it in AutoCAD.
> 2. **Installed on Tim's PC (read the DLLs, never trust this line): UPDATED Tue 20 Oct 21:55: Civil 3.0.66 + Manager 1.1.66 (train C-56, 581b0e7b) and Structural 1.0.119 (train S-39, 063a6351, installed Wed 21 Oct 04:02); all verified file by file, not yet driven in AutoCAD. Older text follows:** Civil 3.0.50 + Manager 1.1.50 and Structural 1.0.117 (earlier: 3.0.49 / 1.0.116). Installed 16 Oct 17:47 and 17:52 (desk, verified file by file): Civil 3.0.50 / Manager 1.1.50 (C-39, d36f9545) and Structural 1.0.117 (S-37, 0dfbd1d6); not yet driven in AutoCAD.
> 2f. **TESTING-SETTINGS RULE (Tim 18 Oct):** a tester may change a setting to test a tool as long as it puts the original back afterwards, verified by hash (copy aside with SHA-256, change one key, restore exact bytes even on failure). See handoff addendum 16.
> 2e. **RULING F (Tim 17 Oct about 05:50):** Civil + Manager go to the pilot colleague Max on Mon 9 Nov 2026; Tim checks the one plan (visual) before it is executed; until then only bug fixes, testing and reading/measuring work; HOLD merging the Civil and Structural code lines, ribbon reorganisation, a hard robot gate and the Manager update channels.
> 2d. **RULING E1 (Tim 17 Oct about 05:25):** "im away from work until 29th so we can test and build as we need until that day" - AutoCAD testing and building may run at any hour on Tim's PC until Thu 29 Oct (one AutoCAD writer at a time; check Codex first).
> 2c. **RULINGS D (Tim 17 Oct about 05:00):** nothing is closed or deleted (every open PR and branch stays until the planning chat compiles them into the one plan); Tim no longer tests ("Robot-accepted" = automatic gates + Codex/driver check in real AutoCAD with screenshots + 5 working days on Tim's PC with no new bug; engineering judgement goes to the Monday session); the desk runs Claude + Codex autonomously inside the weekly limits and picks model and thinking per job; a spare work PC will be set up for AutoCAD testing.
> 2b. **More rulings (Tim 17 Oct about 04:20, RULINGS B, same decisions file):** Civil + Manager reach colleagues first, Structural only on Tim's PC until ready; Tim's PC always gets the newest passing build; a tool switches ON by default once Codex passes it in AutoCAD; questions wait for the Monday 08:40 session (desk queue: `QUESTIONS_FOR_MONDAY.md`).
> 2a. **PAUSE ON NEW ITEMS (Tim, Sat 17 Oct about 03:20, `decisions/2026-10-17_V3_ALIGNMENT_RESET.md` ruling A):** "pause building of new items, but let's continue the fixing of existing items. The bug fixes are really important." No builder starts a new plan item, new engine, or wiring of an already-built engine until the planning chat's one aligned V3 plan replaces the five overlapping ones. Carrying on: BUG_CARPARK fixes, review fixes on existing PRs, train assembly and finalizing, Codex/robot testing, installs under the charter. The desk's lane loops now say this in their brief (lane_loop.ps1) and the gap audit's wiring queues are ON HOLD.
> 3. **Usage (updated Sat 17 Oct 03:30):** Claude main (Max) reset Fri 16 Oct 13:00, next reset Fri 23 Oct 13:00, ceiling 95%; since Tim's word on 16 Oct (about 21:00) the desk runs 3 to 4 Sonnet builders plus Opus reviewers on Max (isolated worktrees, build lock `desk_jobs/build.lock`, claims in the TEAMLANE logs) and keeps the week on the pace line to 95% at the reset. Claude Team week is 100% used, resets Sat 17 Oct 14:00 (lane loops restart 14:03 by themselves; job files were un-bloated from 750 KB to 6 KB on 16 Oct). Codex week is 100% used, resets Thu 22 Oct 17:13. Codex wrote a heartbeat to restart its AutoCAD testing at 16:05 on 20/27 Oct: coordinate it, never run two writers.
> 3a. **The honest figures (gap audit 17 Oct, `areas/release-v3-colleagues-PLAN_GAP_AUDIT_2026-10-17.md`, replaces the old "built 60 / installed 53 percent" guess):** of 284 audited plan lines 238 are built as an engine, about 107 are wired to a command, 77 are installed, about 10 of the wired-and-installed ones have a Codex check (all on 3.0.49 / 1.0.116, none yet on the installed builds), and 0 are accepted by Tim. 131 items are ENGINE ONLY (nothing calls them). About 182 of the 10 Oct plan PRs have never had an Opus review. Almost everything installed that changes a drawing is switched OFF and its Settings page is still an uninstalled PR.
> 4. **Codex's native campaign (13 to 16 Oct):** 762 scoped native AutoCAD checks in 70 ledgers: 592 PASS, 139 FAIL, 7 BLOCKED, 24 UNPROVEN; 81 new open bugs BUG-570..650; ten draft PRs #1253..#1262. Handoff: `areas/release-v3-colleagues-CODEX_V3UX_VERIFICATION_2026-10-13.md` section 'Handoff 16 October 2026'. Desk check 16 Oct: all 1,698 evidence files present with matching sizes, recount of the index equals the stated totals, all 81 bugs are in `BUG_CARPARK.md`.
> 5. **Desk handoff (read after any compaction): `areas/release-v3-colleagues-DESK_HANDOFF_2026-10-16.md`.** Triage (16 Oct): `areas/release-v3-colleagues-CODEX_BUG_TRIAGE_2026-10-16.md` (fix queues per lane, questions for Tim) and the independent review of the ten PRs in `REVIEWLANE_LOG.md`.
> 6. **Open items for Tim:** `REMINDERS_FOR_TIM.md` (repeat at the top of the first morning report) and the question batches in `04_REFERENCE/ux-plan/cards/`.
> 7. **Machine safety (16 Oct):** a runaway background Python filled C: for 11 hours (12 Oct); `desk_jobs/desk_tick.ps1` now prints a disk alarm under 25 GB; lane loops wait 2 h after any run shorter than 15 min (400 empty runs per lane had burned the Team week); old `_PRE_` install backups were thinned to the newest five per product (log `desk_jobs/pre_backup_cleanup_2026-10-16.log`). The two old Codex AutoCAD sessions are closed (pid 12844 closed normally; pid 62380 was stopped by the desk on 16 Oct, log `desk_jobs/acad_cleanup_2026-10-16.log`); still check that no acad.exe or Codex run is live before any robot test. Do not run python from the desk shell (an empty python heredoc spun a process on 16 Oct and was killed).
>
> **29 Sep 2026 ~17:30 (plan/05 done): TWO chats run CE while Tim is away (Tim, 29 Sep).** (1) The controller `CE_ACAD / release-v3-colleagues / build + release / 06` builds, tests, runs Codex and installs: start at the OPERATING CHARTER at the top of `areas/release-v3-colleagues.md`, then `areas/release-v3-colleagues-QUEUE.md` sections 0-5. (2) Tim's desk `CE_ACAD / ideas / plan / 01` is the only chat Tim talks to about CE (ideas, bugs he sees, rulings, summaries): start at `TIM_DESK.md` (moved 20 Nov 2026 to `archive/chat-records-2026-10/`; history only). **Tim talks to the desk, never to the controller.**
> *(Superseded 29 Sep ~17:30: "the release chat is now build + release / 06 ... sections 0-4" - one chat became two on Tim's word.)*
> *(Superseded 29 Sep ~17:00: "next chat = plan/05 - start at the Handoff 29 Sep ~15:10 section".)*

> **Release chat (28 Sep 2026 on): read the OPERATING CHARTER at the top of `areas/release-v3-colleagues.md` first.** It is Tim's standing instruction for how the release chat runs.

> **Release chat handover (24 Sep 10:30):** start at `archive/chat-records-2026-09/HANDOVER_RELEASE_CHAT_2026-09-24_1030.md`.

# START HERE — read this before you do anything

**You are working on CE_ACAD, the CE AutoCAD plugin, for Tim Brand.** This repository is the one place its plan,
its area files, Tim's decisions, the council rules and the drawing-intelligence records live. It sits **outside
every worktree and every code repository on purpose**, so that no branch, rebase or merge can lose it.

**Two things to read before this page:** `C:\TimOS\RULES.md` (how to talk to Tim and how to work; the only
rulebook) and `C:\TimOS\ROUTER.md` (where every project lives). Then this page, two minutes.

**Since 19 September 2026 this repository follows the one shape every product uses.** It holds the plugin only.
The CE project manager, Hush, personal finance and the rest have their own plans, listed in ROUTER.

---

## 0. Who Tim is, and how to talk to him

1. Tim is a **civil/structural engineer, not a coder**. He describes problems in AutoCAD and drawing terms.
2. Explain every change in **AutoCAD terms**: what he will see or do differently on the drawing.
3. **No software jargon anywhere he reads it.** Not in a window, not in a command-line message, not in a question.
4. **Word every question with its context, in plain English.** "Should the label step out when the pit grows, the
   way the cover level text does?" Never "should annotation offsets be recomputed on resize?"
5. He tests in AutoCAD. **You cannot.** A green build is not an AutoCAD result.
6. Give him a **specific** test list: *"open a 375 pipe and check the Edit Pipe window shows 375"*, never
   *"test pipe editing"*.
7. **Numbered lists with bold labels. Tables allowed, 4 columns at most; questions and decisions stay lists**
   (RULES 2.2; "no tables" retired 20 Nov 2026, Tim: "Rest agreed", `areas\rules.md`). Three lines per paragraph.
8. **The rest of how to work with Tim is `C:\TimOS\RULES.md`** (talking 1 to 3, the four words 4, testing 5, git and
   installs 8, privacy 11). Testing is done by the AI and accepted under RULES 4.5; the lines above are the plugin's
   own examples of it.

---

## 1. What this repository holds, and where

1. **`MASTER_PLAN.md`** — the map: what Version 3 delivers, the delivery sequence, the list of areas, and the
   control framework text. **No status lives in it.**
2. **`areas\`** — one file per area. Items, status, bugs, parked ideas, test steps and the regression list for
   that area. Updated in the same reply as the work. The list of areas is section B of the master plan.
3. **`decisions\`** — Tim's words, in quotes, dated: the 16 Sep test-day results, decisions D1 to D10 and the
   design-pack rulings, the 4 Sep reconciliation, the drawing-intelligence decisions log.
4. **`PENDING_TESTS.md`** — everything built but not yet tested in AutoCAD, across every chat. Section 1b.
4b. **`TEST_STATION_REQUESTS.md`** / **`TEST_STATION_RESULTS.md`** — the bridge to the Test Station on Tim's virtual machine (from 24 Sep 2026): the release chat writes requests, the VM writes results. Set-up: `04_REFERENCE\TEST_STATION_SETUP.md`.
5. **`BUG_CARPARK.md`** — the one bug file. **`IDEAS_INBOX.md`** and `IDEAS_BACKLOG.md` — the one idea file
   and its sorted backlog.
6. **`ENGINEERING_RULEBOOK.md`** — the engineering rules (R-00 onward), the Autodesk API guardrails, and the
   three-deliverables rule for every plugin change. **`IMPLEMENTATION_ROADMAP.md`** — the delivery order.
7. **`02_COUNCIL_RULES\`** — every council write-up read from the councils' own documents, the CE design
   guidebook ruleset and its v1.3 supersession, the V3 integration spec, and the open questions Tim has not
   answered.
8. **`03_DRAWING_INTELLIGENCE\`** — the EV-03 evidence model, the project queue, the synthetic safety plan.
9. **`04_REFERENCE\`** — approved briefs, the whole-program overview and questionnaire map, contracts, the
   Structural, Manager and Level 3 plans, and the outputs of the 16 to 18 Sep automated planning run.
10. **`archive\`** — superseded plans and old chat records. **Never deleted.** Each folder has a README.

### What is deliberately NOT here

The bulk evidence store stays on disk at **`C:\CE_DrawingIntelligence`** and must never be copied into any
repository: the anonymised evidence (449 MB), the private scratch (7.4 GB), the visual review images, the
private index, and the three control packets that name real client addresses.

**DATA-01 rule:** office project folders and anything naming a client, an address or a job address are read for
evidence studies only, when Tim names the job. **Never copy a client name or address into any repository.**

---

## 1b. What is waiting for Tim to TEST

**`PENDING_TESTS.md`** is the one living list of everything built but not yet tested in AutoCAD, across every
chat. A chat ending must never take the test list with it.

1. **Built something? Add it there**, with its branch, commit and the exact steps Tim should follow.
2. **Never tick a row yourself.** A green build, a passing test run and an AutoCAD result are three different
   facts. Only Tim's word moves a row to Accepted (RULES 4.5, amended 27 Sep, also allows "Codex-accepted" for a
   Codex PASS in real AutoCAD on copies with screenshots; engineering-judgement items still need Tim).
3. Steps must be specific, and must say which lane: 2027 **and** 2024/net48, since 2022 to 2024 users are in
   scope.

---

## 2. The four facts that change most often — check them, do not assume

1. **What is actually installed in AutoCAD.** Read the bundle, not a document:
   `C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll`.
   Its product version string ends in the commit it was built from. The deploy register has been wrong before.
2. **The deploy register**: GitHub issue **#78** on the plugin repo. Read it fresh. Update it when you push.
3. **The status page**: GitHub issue **#24**. Tim's rulings land there.
4. **`REGRESSION_LOG.md`** in the plugin repo: every change, its evidence, and Tim's AutoCAD checklist.

---

## 3. The standing rules you must not break

**Ownership, Tim's ruling B, 15 September 2026:**
1. **Codex builds windows.** WPF, XAML, view models, controls, layout, appearance.
2. **Claude owns behaviour**: commands, services, rules, native objects and the enabler, project data and spine
   identity, **and every deployment.** (Exception, Tim, 16 Sep: Claude builds the CDWT window.)
3. A window never contains an engineering decision; it calls a rule. Where the two meet, the behaviour side
   publishes a written contract (`04_REFERENCE\contracts\`) and the window is built from it.

**Engineering:**
1. **Settings-first (R-00).** Every engineering and council value lives on the Settings page. Nothing hard-coded.
2. **No hard blocks (R-27).** Warn and record. Only two hard blocks exist: deleting spine IDs, and pushing an
   update on a failed build.
3. **The plan label is the authority.** The record follows the label; never rewrite plan text to match a record.
4. **Stable identity outranks proximity.** Touching may prove a connection; **crossing alone does not.**
5. **Unknown, Assumed, Manual/Pinned and Display Override stay distinct.** Never invent a value to fill a gap.
6. **One accepted operation = one AutoCAD Undo.** Engineering data and drawing presentation are **separate**.

**Working method:**
1. **Never deploy** without Tim's fresh, explicit instruction that AutoCAD is closed, and read the hashes back.
2. Every build and test: `-p:SkipDevBundle=true -nr:false --disable-build-servers`.
3. **Built / tested / installed / Tim-accepted are four separate facts.** Never merge them into a percentage.
4. **Zero discovered tests is not a passing test run.**
5. Before replacing any window or command, list every button, field, grip, prompt and route as
   Kept / Moved / Combined / Replaced / Retired. **Retired only with Tim's explicit approval.**
6. Never delete a working copy, chat or branch as housekeeping.
7. **Never work in the plugin's main checkout.** It carries unsaved files that are Tim's to decide. Use a worktree.

**Autodesk API guardrails** (the full text is in `ENGINEERING_RULEBOOK.md`):
1. Autodesk APIs are closed source. Only the documented contract is authoritative. **Never state what AutoCAD
   does internally.** Separate *documented fact* / *observed in the log* / *hypothesis*.
2. Database writes need an open transaction and a document lock. Autodesk APIs are **not thread-safe**.
3. If the documents do not cover it and the log does not show it, say **"insufficient information"** and propose
   the probe that would settle it.

---

## 4. How to use this repository

**Read it at the start of every chat. Update it the moment a decision is made.**

```bash
cd C:\CE_PLAN
git fetch; git merge --no-edit origin/main   # before you read (never git pull --rebase, never origin master)
# ... edit an area file, a decision, a council file ...
git add <the files you edited, by name>      # never git add -A: the repo carries other chats' uncommitted edits
git commit -m "..."; git push origin HEAD:main
```

Rules for editing:
1. **Status goes in the area file, never in the master plan.** The area file is updated in the same reply as
   the work, never "at the end".
2. **Record Tim's actual words in quotes, dated, under `decisions\`.** Mark anything else as a proposal or an
   interpretation.
3. When a later answer replaces an earlier one, **keep the earlier one and mark it superseded, with dates.**
4. **Never turn an unanswered question into a decision.** If nobody answered it, it stays on the open list.
5. If you could not reach a record, **say so** rather than filling the gap.
6. **Chat prompts, handoffs and morning packs go in `archive\chat-records-<month>\`**, not beside the plan.
7. Commit small and often. This repository is never rebased, so nothing here can be lost by a branch operation.

---

## 5. Where everything else lives

1. **The plugin code:** `C:\Lisp Files\CE_ACAD_PLUGIN` (worktrees under `.claude\worktrees\`). Its
   `docs\V3_0_PLAN.md` is a pointer back here; never read a plan from the code repo.
2. **Bulk drawing evidence:** `C:\CE_DrawingIntelligence`, read-only, never copied into a repo.
3. **Office project folders (client data):** `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Projects`.
4. **Standard details:** `...\Creative Engineering - Drafting\Standard Details` (and `\Civil`).
   **Drawing templates:** `...\Creative Engineering - Drafting\Drawings Templates`.
5. **STORM / ESD reports:** `<job>\Civil\STORM Report - WSUD\`, 533 jobs; use the **most recently dated** file.
6. **Keys and tokens:** `C:\Users\TimothyBrand\Keys\keys.txt`, **never in a repository**.
7. **Deploy register and status page:** GitHub issues **#78** and **#24**.
8. **Every other product** (CE project manager, Hush, personal finance, the shared evidence layer): `C:\TimOS\ROUTER.md`.
