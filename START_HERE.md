# START HERE — read this before you do anything

**You are working on the CE AutoCAD plugin for Tim Brand.** This repository is the one place the master plan,
the council rules and the drawing-intelligence decisions live. It sits **outside every worktree and every code
repository on purpose**, so that no branch, rebase or merge can lose it or leave a stale copy behind.

**If you are a new chat, read this page, then §1–§4 below. It takes two minutes and it will stop you asking Tim
things he has already answered.**

---

## 0. Who Tim is, and how to talk to him

Tim is a **civil/structural engineer, not a coder**. He describes problems in AutoCAD and drawing terms.

- Explain every change in **AutoCAD terms** — what he will see or do differently on the drawing.
- **No software jargon anywhere he reads it.** Not in a window, not in a command-line message, not in a question.
- **Word every question with its context, in plain English.** "Should the label step out when the pit grows, the
  way the cover level text does?" — not "should annotation offsets be recomputed on resize?"
- He tests in AutoCAD. **You cannot.** A green build is not an AutoCAD result.
- Give him a **specific** test list: *"open a 375 pipe and check the Edit Pipe window shows 375"*, never
  *"test pipe editing"*.

---

## 1. What this repository holds

| Folder | What is in it | Use it for |
|---|---|---|
| `01_MASTER_PLAN/` | `V3_0_PLAN.md` (the master control framework), the consolidated V3 record, the implementation roadmap, the engineering rulebook, the editor and drawing-intelligence briefs, the cards index | **What Version 3 is, what is decided, what is left** |
| `02_COUNCIL_RULES/` | Every `COUNCIL_*.md` write-up read from councils' own documents, the CE design guidebook ruleset, the v1.3 supersession note, and the council-rules V3 integration specification | **What each council actually requires** |
| `03_DRAWING_INTELLIGENCE/` | The EV-03 evidence model, the decisions log, the project queue and the deliverable handover documents | **What CE has learned from real drawings, and the rules for learning safely** |

### What is deliberately NOT here

The bulk evidence store stays on disk at **`C:\CE_DrawingIntelligence`** and must never be copied into any
repository:

| Folder | Why it stays out |
|---|---|
| `02_Anonymised_Evidence` | 799 files, 449 MB |
| `90_Private_Scratch` | 24,230 files, 7.4 GB |
| `07_Visual_Review` | 41 MB of images |
| `01_Private_Index` | private by definition |
| Three `00_Control` packets | they name real client addresses (**DATA-01**) |

**DATA-01 rule:** office project folders and anything naming a client, an address or a job address are read for
evidence studies only, when Tim names the job. **Never copy a client name or address into any repository.**

---

## 2. The four facts that change most often — check them, do not assume

1. **What is actually installed in AutoCAD.** Read the bundle, not a document:
   `C:\Users\TimothyBrand\AppData\Roaming\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll`
   — its product version string ends in the commit it was built from. The deploy register has been wrong before.
2. **The deploy register** — GitHub issue **#78**. Read it fresh. Update it when you push.
3. **The status page** — GitHub issue **#24**. Tim's rulings land there.
4. **`REGRESSION_LOG.md`** in the plugin repo — every change, its evidence, and Tim's AutoCAD checklist.

---

## 3. The standing rules you must not break

**Ownership — Tim's ruling B, 15 September 2026:**
- **Codex builds windows.** WPF, XAML, view models, controls, layout, appearance.
- **Claude owns behaviour** — commands, services, rules, native objects and the enabler, project data and spine
  identity — **and every deployment.**
- A window never contains an engineering decision; it calls a rule. Where the two meet, the behaviour side
  publishes a written contract and the window is built from it.

**Engineering:**
- **Settings-first (R-00).** Every engineering and council value lives on the Settings page. Nothing hard-coded.
- **No hard blocks (R-27).** Warn and record. Only two hard blocks exist: deleting spine IDs, and pushing an
  update on a failed build.
- **The plan label is the authority.** The record follows the label; never rewrite plan text to match a record.
- **Stable identity outranks proximity.** Touching may prove a connection; **crossing alone does not.**
- **Unknown, Assumed, Manual/Pinned and Display Override stay distinct.** Never invent a value to fill a gap.
- **One accepted operation = one AutoCAD Undo.**
- Engineering data and drawing presentation are **separate**.

**Working method:**
- **Never deploy** without Tim's fresh, explicit instruction that AutoCAD is closed — and read the hashes back.
- Every build and test: `-p:SkipDevBundle=true -nr:false --disable-build-servers`.
- **Built / tested / installed / Tim-accepted are four separate facts.** Never merge them into a percentage.
- **Zero discovered tests is not a passing test run.**
- Before replacing any window or command, list every button, field, grip, prompt and route as
  Kept / Moved / Combined / Replaced / Retired. **Retired only with Tim's explicit approval.**
- Never delete a working copy, chat or branch as housekeeping.

**Autodesk API guardrails:**
- Autodesk APIs are closed source. Only the documented contract is authoritative. **Never state what AutoCAD
  does internally.** Separate *documented fact* / *observed in the log* / *hypothesis*.
- Database writes need an open transaction and a document lock. Autodesk APIs are **not thread-safe**.
- If the documents do not cover it and the log does not show it, say **"insufficient information"** and propose
  the probe that would settle it.

---

## 4. How to use this repository

**Read it at the start of every chat. Update it the moment a decision is made.**

```bash
cd C:\CE_PLAN
git pull                      # before you read
# ... edit the plan, a council file, or a decision ...
git add -A && git commit -m "..." && git push
```

Rules for editing:

- **Record Tim's actual words in quotes.** Mark anything else as a proposal or an interpretation.
- When a later answer replaces an earlier one, **keep the earlier one and mark it superseded, with dates.**
- **Never turn an unanswered question into a decision.** If nobody answered it, it stays on the open list.
- If you could not reach a record, **say so** rather than filling the gap.
- Commit small and often. This repository is never rebased, so nothing here can be lost by a branch operation.

---

## 5. Where everything else lives

| What | Where |
|---|---|
| The plugin code | `C:\Lisp Files\CE_ACAD_PLUGIN` (worktrees under `.claude/worktrees/`) |
| Bulk drawing evidence | `C:\CE_DrawingIntelligence` — read-only, never copied into a repo |
| Office project folders (**client data**) | `C:\Users\TimothyBrand\Creative Engineering\Creative Engineering - Projects` |
| Standard details | `...\Creative Engineering - Drafting\Standard Details` (and `\Civil`) |
| Drawing templates | `...\Creative Engineering - Drafting\Drawings Templates` |
| STORM / ESD reports | `<job>\Civil\STORM Report - WSUD\` — **533 jobs**; use the **most recently dated** file |
| Keys and tokens | `C:\Users\TimothyBrand\Keys\keys.txt` — **never in a repository** |
| Deploy register · status page | GitHub issues **#78** and **#24** |
