# Prompt for Codex — C0 to C7 handover

**Paste everything below the line into a fresh Codex chat.**

---

## RUN CONFIG

- **Model:** strongest available, **high** reasoning.
- **Why:** this is a recall-and-reconcile task across eight work chunks, several branches and a year of
  decisions. Getting it wrong quietly is worse than getting it slowly. It touches AutoCAD behaviour, deployment
  state and acceptance evidence.
- **Downgrade option:** none for the reconciliation itself. If you split the work, a mid-tier model may do the
  mechanical branch/commit listing, but the *"what is genuinely finished"* judgement stays on the strongest model.
- **Mode:** **read-only.** Do not edit code, change branches, merge, build or deploy.

---

## WHO YOU ARE WRITING FOR

Tim Brand is a **civil/structural engineer, not a coder**. He does every AutoCAD test himself; you cannot.
Write every answer in **AutoCAD and drawing terms**, in plain English, with **no software jargon**. If a
technical term is unavoidable, explain it in brackets the first time.

---

## READ THESE FIRST

**The single source of truth now lives outside every worktree:**

```
C:\CE_PLAN          →  github.com/timbrand92/CE_PLAN   (private)
```

```bash
cd C:\CE_PLAN && git pull
```

Read `START_HERE.md`, then:

- `01_MASTER_PLAN/V3_0_PLAN.md` — the master control framework: the V3 outcome, the authority order, the data
  spine, the **eight completion gates**, the workstream status table and the thirteen guided-workflow areas.
- `01_MASTER_PLAN/V3_CONSOLIDATED_RECORD_2026-09-15.md` — the consolidated decision register, feature register,
  ownership map, conflicts and gaps, and the one AutoCAD acceptance checklist. **Read section 0 first.**
- `02_COUNCIL_RULES/` — the council write-ups and the council-rules V3 integration specification.
- `03_DRAWING_INTELLIGENCE/` — the EV-03 evidence model and the decisions log.

Then, in the plugin repo `C:\Lisp Files\CE_ACAD_PLUGIN`:

- `REGRESSION_LOG.md`
- GitHub issues **with all comments**: **#24** (status page and Tim's rulings), **#78** (deploy register),
  and the chunk issues **#26 C0, #27 C1, #28 C2, #29 C3, #30 C4, #32 C5, #74 C7** — plus C6 wherever it is
  recorded, which you must locate rather than assume.

---

## CURRENT-STATE CAUTION — check, do not assume

The deploy register has been **wrong within the last few hours**. Read what is actually installed rather than
what a document says:

```
%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll
```

Its product-version string ends in the exact commit it was built from. On 15 September that read `10ac480d`
while #78 still said `6a6d6bc7`, and two deployments had gone unrecorded.

Also note: **a green build is not an AutoCAD result**, **zero discovered tests is not a passing test run**, and
**built / tested / installed / Tim-accepted are four separate facts**.

---

## WHAT TIM ACTUALLY WANTS FROM YOU

> *"A lot of the Codex lanes are applicable to our behaviour stuff. Can we get a prompt for Codex discussing
> what it did in its build of C0–C7 and where we need to take it to complete it and test it."*

So: **an honest handover of your own work on C0 to C7**, written so the behaviour side can pick up every loose
end, and so Tim can test it.

Tim's ownership ruling B (15 September 2026) is binding: **you build windows; Claude owns behaviour, spine,
commands, services, rules, native objects and every deployment.** Much of what you built sits directly on top of
behaviour that is not yours — that seam is exactly what this handover is for.

---

## PRODUCE ONE REPORT, IN THIS SHAPE

### 1. Chunk by chunk — C0, C1, C2, C3, C4, C5, C6, C7

For each, in a table:

| Question | Answer |
|---|---|
| What was this chunk meant to deliver, in AutoCAD terms? | |
| What did you actually build? | name the windows, controls and view models |
| Where is it? | exact branch and commit, and whether it is merged, and into what |
| Is it **connected** — reachable and working in the running product, not merely compiled? | |
| Is it **deployed**? | check the installed bundle, not a document |
| Has **Tim accepted it in AutoCAD**? | if you do not know, say you do not know |
| What is **left** to finish it? | |
| What does it **need from the behaviour side** before it can work? | be specific: the exact call site and the outcome you need |

### 2. The seam — what you need from the behaviour side

The single most useful part of this report. For every place your window depends on behaviour that is missing,
incomplete or dishonest, give:

- the **window and control** involved;
- the **exact existing call site** (`file.cs:line`) and the operation already there;
- **what outcome you need** — not a new service, but the truthful result of the existing one;
- what breaks today without it, **described as Tim would see it on screen**.

Known examples already recorded, which you should verify and extend rather than repeat blindly:
`CDEDIT` Pipe Update discards its `false` result and prints "Pipe updated" regardless · `PITEDIT` Update has no
truthful outcome for the complete edit · the parts catalogue Reset wrote to disk before Save (now fixed in
`10ac480d` — confirm) · Source draft/preview/identity · durable catalogue save and scope identity.

### 3. What is genuinely finished versus what merely compiles

Be blunt. List anything you have previously reported as done that has **not** been through AutoCAD on a real
drawing. Tim would rather read an honest short list than a long optimistic one.

### 4. The UI recovery candidate and the Structural blocker

State plainly where this stands. Specifically:

- which of the 71 original commits are recovered, which are not, and which were superseded;
- the PIT no-scroll failure — still open or not;
- the installed-baseline audit: the candidate **deletes** `SbeamCommandRunner.cs`, `SbeamEditCommandRunner.cs`
  and `ArchitecturalChangeReviewCommands.cs` relative to the installed Structural source, and installed
  Structural `5d723d41` is **not** an ancestor of the candidate;
- the shared `CE_SHARED.dll` hashes that differ between the Manager and Civil bundles on disk;
- **what decision you are waiting on from Tim**, in one sentence he can answer.

### 5. Your AutoCAD test list for Tim

One consolidated list, not per-commit instructions. Each item must be a **specific action with a specific
expected result** — *"open PIT on a 450 pit, change it to 1200, and check the label circle steps out and keeps
its distance from the pit"*, never *"test the pit editor"*. Include the failure paths: Cancel, Escape, a refused
save, switching drawing mid-edit, and **one accepted edit = one Undo**.

Tim ruled on 15 September that **AutoCAD 2022–2024 users are in scope**, so say which items need a **2024
(net48)** pass as well as 2027.

### 6. What you would do next, in order, with dependencies

Short. Ordered. Each item says what must happen before it.

---

## RULES FOR THIS REPORT

- **Read-only.** No edits, no branch changes, no merges, no builds, no deployment.
- Separate **Tim's words** (quote them) from your own proposals and interpretations.
- Separate **documented fact** / **observed in the log** / **hypothesis**. Never state what AutoCAD does
  internally — Autodesk APIs are closed source and only the documented contract is authoritative.
- Never turn an **unanswered question** into an approved decision.
- If a record is missing or you could not reach it, **list it as a gap**. Do not fill it in.
- Do not claim a chunk is complete because it compiles, because tests pass, or because it is merged.
- Where you disagree with something in `C:\CE_PLAN`, **say so and give your evidence** — that repository is
  meant to be corrected, not defended.

---

## WHEN YOU ARE DONE

Commit your report to **`C:\CE_PLAN\01_MASTER_PLAN\`** as
`CODEX_C0_C7_HANDOVER_<date>.md`, and push. That repository is never rebased, so nothing there can be lost by a
branch operation — which is exactly why it exists.

Then give Tim a short summary in the chat: what is finished, what is not, what you need from the behaviour side,
and the one decision you are waiting on from him.
