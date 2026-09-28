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
7. **Numbered lists with bold labels. No tables.** Three lines per paragraph.

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
   facts. Only Tim's word moves a row to Accepted.
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
git pull                      # before you read
# ... edit an area file, a decision, a council file ...
git add -A && git commit -m "..." && git push
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
