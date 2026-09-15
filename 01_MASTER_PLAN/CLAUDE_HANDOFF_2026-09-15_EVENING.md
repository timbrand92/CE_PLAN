# Handoff prompt — CE Civil behaviour, evening of 15 September 2026

**Paste everything below the line into a fresh Claude Code chat.**

---

## RUN CONFIG

- **Model:** strongest available (Opus), **high** reasoning.
- **Why:** Autodesk `.NET` + ObjectARX, live-bundle handling, and engineering rulings that end up drawn and built.
- **Downgrade:** Sonnet/medium is acceptable for docs-only steps. Never for anything touching `Autodesk.*`,
  a deployment, or an engineering value.

---

## START HERE, BEFORE ANYTHING ELSE

```bash
cd C:\CE_PLAN && git pull
```

Read **`START_HERE.md`** (two minutes), then
**`01_MASTER_PLAN/V3_CONSOLIDATED_RECORD_2026-09-15.md`** — **section 0 first**. That is the master plan,
council rules and drawing-intelligence record, and it lives outside every worktree deliberately.

**Do not ask Tim a question `C:\CE_PLAN` already answers. Say which document you checked.**

---

## WHO YOU ARE WORKING FOR

Tim Brand, **civil/structural engineer, not a coder**. He tests in AutoCAD; you cannot. Explain everything in
AutoCAD and drawing terms. **No software jargon anywhere he reads it** — windows, command-line messages and your
questions alike. Word every question with its context, in plain English.

---

## WHERE THE WORK IS

| | |
|---|---|
| **Branch** | `claude/c7-one-object` |
| **Tip** | `9058a405` |
| **Live Civil bundle** | `10ac480d` — **verify it yourself**, see below |
| **Position** | **0 behind live, 52 ahead** |
| **Deployed?** | **Nothing on this branch is deployed.** |
| **Worktree** | use your own; never edit, build or test inside another worktree |

**Verify what is live before you trust any document** — the deploy register was wrong twice today:

```
%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll
```

Its product-version string ends in the commit it was built from.

**Every build and test:**

```
-p:SkipDevBundle=true -p:SkipItAdminPublish=true -p:PrepareReleaseBundle=false
-p:PrepareRelease=false -p:PublishReleaseCandidate=false -nr:false --disable-build-servers
-p:_AcadRef48=C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2024-ref
-p:_AcadRefNet8=C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2026-ref
```

AutoCAD 2027 must be on `PATH` for net10 tests, or **zero tests are discovered and that is not a pass**.
**Baseline: 23 known failures.** Diff failure *names* against the previous run, never just the count.

---

## WHAT WAS DONE TODAY (all on the branch, none deployed, none tested in AutoCAD)

| Item | What it does |
|---|---|
| **BUG-154** | CDFW/CDSOURCE would not place **anywhere** while four blocks shared the name 'AGI'. A deliberate exclusion was being treated as missing evidence. Fixed, plus new **`CDFIXTAGS`** which offers to renumber repeated names |
| **Split on draw** | A pipe drawn **across** pits now splits at each one. Asks once, remembers. Reuses the existing pit-on-pipe splitter — no second implementation |
| **`CDTWL`** | Detention top water level and the storage check. **See the open ruling below — do not treat this as finished** |
| **`CDDESIGN`** | Design workflow behaviour + command. Window contract published at `docs/workflows/CDDESIGN_WINDOW_CONTRACT.md` for Codex |
| **C7 slice 3d** | A converted pipe can now be **split**. Removes the live hazard where `CDC7UPGRADE` + `CDFW` left two overlapping pipes with no warning |
| **Pit label on resize** | Tim's ruling locked as a testable rule; the resize log now names *which* annotation moved |
| **F2.1 — LPD** | The callout now writes **CE's real note**, and offers the connection types CE actually uses |

---

## DO THESE, IN ORDER

### 1. F2.2 — record where each downpipe goes

**Tim's ruling: a downpipe always has exactly ONE destination.**

Today `PipeData.chargedDestination` and `risingMainDestination` exist and are set on **zero** pipes across every
finished job; 25 of 33, 41 of 45, 25 of 25 and 50 of 52 pipes have **no destination recorded at all**. The chain
`DP1 → OF1` exists but `OF1 → ?` stops there — and that "?" is the tank-or-LPD answer.

Evidence and the full analysis: `docs/workflows/ROOF_AREAS_DOWNPIPES_AND_WHERE_THEY_GO.md`.

Once a downpipe's destination is a recorded fact, `DetentionBranchCollector.WalkUpstream` (already written and
tested) answers *"what drains to this tank"* for free.

### 2. F2.3 — tank plan size and orifice level into the drawing record

**This is what stops `CDTWL` counting a tank today**, so any tank-heavy job under-counts its storage.

Tim's answers, 15 Sep, already recorded in `02_COUNCIL_RULES` / `CDWT_DETENTION_TWL_PLAN.md`:
- **T-01: stretch the blocks** to the library's real L × W. Five blocks, 34 real sizes.
- **Trafficable is a property of the specified tank, not of its material.** Some poly tanks have trafficable
  lids. Carry a flag; **never infer it from concrete-vs-poly**.
- The two unreadable block names (`A$C1cba1a13`, `A$C72c6940a`) **can be renamed** — Tim still owes the names.

### 3. Step 6 — grade-driven inverts

Tim: *"implement properly, feels glitchy"* — and he clarified it is **the UI interaction** (when levels are set,
what set them, what you end up with), **not the arithmetic**. Downstream follows an override but **asks first**.

### 4. Step 7 — OVR-01 (#77), read-only report first

Grips must match `docs/workflows/C7_GRIP_CONTRACT.md` exactly. Tim ruled **AutoCAD 2022–2024 users are in
scope**, so this lands via overrules and Test Days need a **2024 (net48) pass**.

---

## OPEN RULINGS — ASK TIM, DO NOT DECIDE THESE YOURSELF

1. **THE TWL RULE — blocks the most work.** CE's rulebook says *"TWL = obvert of highest pipe"*. Tim, 15 Sep:
   *"the TWL could be something other than the obvert of the highest detention pipe… we had a trench grate which
   was a higher level"*. So the rulebook figure is a **default, not a law**. `CDTWL` must present the candidates
   and let Tim confirm — it must never assert one. **It does not do that yet.**
   This matters because the TWL is the **baffle wall crest**, and the baffle height is the **head that sizes the
   orifice**. Get it wrong and the orifice is wrong.
2. **Which number drives the orifice** when CDCALC's figure and the volume check disagree, and what CDCALC shows.
3. **Where the required detention volume lives**, and **what unit** CDCALC's `volumeRequired` is in — litres or
   cubic metres. A wrong unit is out by 1000×.
4. **Split-on-draw memory** — currently per settings file, so answering Yes once carries into every later job.
   Tim may have meant per drawing.
5. **New names** for the two unreadable tank blocks.

---

## STANDING RULES

- **Ownership (ruling B, 15 Sep):** Codex builds windows; you own behaviour, spine, commands, services, rules,
  native objects, and **every deployment**. Never edit `Dialogs/`, `Controls/` or `ViewModels/`.
- **Settings-first (R-00)** · **no hard blocks (R-27), warn and record** · **the plan label is the authority** ·
  **stable identity outranks proximity; crossing alone does not prove a connection** · **one accepted edit = one
  Undo** · Unknown / Assumed / Pinned / Display-Override stay distinct.
- **Never deploy** without Tim's fresh explicit "AutoCAD is closed, deploy", and read the hashes back.
  **The enabler is API v3 on this branch — it MUST be rebuilt and shipped with it.**
- **Batch the work.** Tim's ruling: fix everything on the branch, **one payload, one consolidated tick-list**.
  No one-fix-one-deploy during acceptance.
- **Autodesk guardrails:** never state what AutoCAD does internally. Separate *documented fact* / *observed in
  the log* / *hypothesis*. If the docs do not cover it and the log does not show it, say **"insufficient
  information"** and propose the probe.
- **After any rebase or history rewrite:** `git log --oneline --no-merges --cherry-pick --right-only HEAD...<old
  tip>` must be empty. A rebase today silently dropped 284 lines of council specification while three build
  lanes were green and the test count was unchanged.
- **Update `C:\CE_PLAN` the moment a decision is made** — not only in the chat or the branch.

---

## FIRST THING TO SAY TO TIM

Tell him the branch position, that nothing is deployed, and ask **the TWL question** (open ruling 1) in plain
English with its context — it blocks the most work. Then start F2.2.
