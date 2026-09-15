# CE Civil — handoff, 15 September 2026 (night)

Paste everything from **RUN CONFIG** down into a new chat.

---

## RUN CONFIG

- **Model: Opus 5 (strongest).** **Thinking: high.**
- **Why:** this lane touches `Autodesk.*` behaviour, real engineering numbers that end up on issued
  drawings, and the deploy. All three are on the "strongest + high" list. A drainage figure that is
  quietly 8% wrong is worse than no figure.
- **Downgrade option:** the pure-rules work in `Modules/Drainage/Rules/**` (no AutoCAD types, fully
  unit-tested) can be done on **Sonnet + medium**. Anything that touches a `Command`, a `Service`, an
  overrule, the installer, or a number that reaches a sheet stays on Opus + high.

---

## Step 0 — do these four things before anything else

```bash
cd C:\CE_PLAN && git pull
```

1. Read **`C:\CE_PLAN\START_HERE.md`**, then **`01_MASTER_PLAN\AREA_D_F_CATCHMENTS_CDCALC_OSD_PLAN.md`**
   (this lane's plan) and **`01_MASTER_PLAN\IFD_RAINFALL_HOW_IT_WORKS.md`** (written 15 Sep — read it
   before touching any rainfall number).
2. **Refer back to the master plan constantly, not once.** Tim called this out directly on 15 Sep:
   *"why are you not referring back to the overall plan all the time?"* It was a fair hit. Before each
   piece of work, say which plan item it is.
3. **Verify the live bundle yourself** — do not trust any document for this, including this one:
   ```bash
   powershell -NoProfile -Command "(Get-Item \"$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll\").VersionInfo.ProductVersion"
   ```
   It ends in the commit it was built from.
4. Read `REGRESSION_LOG.md` in the worktree. Every entry from **TWL-01** down to **F2.9** is this lane.

---

## Where the work is

| | |
|---|---|
| **Worktree** | `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\ce-civil-behaviour-c93a90` |
| **Branch** | `claude/civil-f2-destinations` |
| **Tip** | `326c1303` — *"F2.9: Blue Factor is the tool from now on, and the words follow"* (pushed, tree clean) |
| **Full suite (net10)** | **8911 passed / 23 failed / 17 skipped** — this is the session baseline, not new damage |
| **Builds** | net48, net8.0-windows, net10.0-windows — **0 errors on all three** |
| **Deployed** | **Nothing from this branch.** |

### The live bundle moved during the last session — read this before you deploy

Live is now **`817d482c`** — *"Merge PERF-001/PERF-002/SHARED-001 onto the live trunk (10ac480d)"*.
It was **b136bbe2** when the last session started; someone else deployed in between. That is fine, but
it has one consequence you must understand:

**`817d482c` is a merge commit and is NOT an ancestor of this branch, so `Deploy-Local-AsAdmin.ps1` WILL
print its "this deploy would remove work that is already live" lineage warning.** On the evidence as of
`326c1303` **that warning is a false alarm**, and here is the check that proves it rather than assuming it:

```bash
git diff --diff-filter=D --name-only 817d482c HEAD     # must print NOTHING
```

Nothing is deleted, and all four live ingredients (`10ac480d`, `fb192ec3`, `15a6d535`, `a482892a`) are
already ancestors of this branch — the branch is a **strict content superset** of what is live. Re-run
that check yourself at the moment of deploying; if it ever prints a filename, **stop and tell Tim.**

---

## THE DEPLOY RULE — read it twice

> **Only ONE session may deploy: the one Tim has told, IN THAT CONVERSATION, "AutoCAD is closed, deploy".
> Not a previous conversation, not a message to another chat, not an inference from him saying he wants
> something live.**

**You are not that session** unless Tim types those words to *you*, in *this* new chat. Until then:

- Every `dotnet build` / `dotnet test` carries **`-p:SkipDevBundle=true -nr:false --disable-build-servers`**.
  No exceptions, not even a quick check — a build without the skip flag overwrites Tim's live bundle.
- The **only** thing that writes to `%APPDATA%` is `Installer\Deploy-Local-AsAdmin.ps1`.
- After a deploy, the bundle DLL's SHA256 must equal the just-built bin DLL. If it does not, AutoCAD is
  open or another session clobbered you — **say so, do not assume.**
- Read the CE_SHARED line in the deploy output: **`N upgraded, N already matching, 0 blocked, 0 skipped`**.
  Anything other than `0 blocked` means the bundles are on different CE_SHARED builds. **Say so. Do not
  report the deploy as clean.**
- **`master` is NOT the trunk.** The real code trunk is `10ac480d`. Never build, deploy or branch from
  `master`, and never merge this branch into `master` to deploy from there.
- **Civil and Structural must ship from the same commit.** Structural currently has **no release script**
  and its bundle carries no `CE_SHARED.dll` — see Open items.

---

## What was built in the last session (all on the branch, none tested in AutoCAD)

One payload, one tick-list — per Tim's ruling of 14 Sep: *"fix everything on the branch, ONE payload,
ONE consolidated tick-list; no one-fix-one-deploy."* Every item below is pure rules code
(`Modules/Drainage/Rules/**`, no AutoCAD types) plus its own unit tests, with the AutoCAD-side wiring
kept thin and deliberate.

| Item | What it does | Tests |
|---|---|---|
| **TWL-01** | Gathers every candidate top-water level with **where each came from**; the rulebook default is labelled *not applied* rather than silently used | 13 |
| **F2.2** | Walks drawn pipes downstream to a tank or LPD, so CE can state where each downpipe goes; names where the trail went cold; reports `Split` when more than one pipe leaves a source | 16 |
| **F2.3** | Water-tank facts: re-use = total − detention, orifice level, tank top | 15 |
| **OVR-01** | Shared pipe-grip words + the Z-flatten / 1 mm-minimum decisions, for net48 users | 29 |
| **F2.4/2.6** | Reads Melbourne Water STORM rating reports — inline **and** stacked header layouts | 23 |
| **F2.5** | Climbs from the drawing up to the job folder and **offers** the report; never opens a client folder unasked | 20 |
| **F2.7** | Computations sheet: PSD, SSR, the detention split, orifices | 13 |
| **F2.8/2.9** | **Blue Factor** reader into the same shape, and the words changed to match | 14 |

### Five real defects this found — each one would have reached a drawing

1. **BUG-155.** `CDTWL` asked for **litres** and offered `CDCALC`'s **m³** figure as the default — a
   **1000×** error, one Enter key away.
2. **Step 6.** `CDPROPAGATE` wrote new invert levels to the **drawing** while the record writer refused
   them. The sheet and the record disagreed, silently. One decision now drives both.
3. **F2.3.** `DetentionBranchCollector` took a tank parameter that **nothing ever built** — every
   tank-heavy job under-counted its storage.
4. **F2.6.** The STORM parser silently dropped any row whose name wrapped onto two lines (57 m² of
   bypass area lost on one real job), and read numbers out of 34 documents that were not STORM reports
   at all. Site-area read rate went **27.5% → 98.8%** across 194 real reports.
5. **F2.8.** **CE moved to Blue Factor in 2026** — the parser read **0%** of current work. Found only
   because Tim said *"test against recent projects in 2026."* Everything F2.4–F2.7 built would have
   quietly done nothing on a current job.

### Evidence produced (read-only, against real office jobs)

- Orifice head `h = plate height − d/2` — confirmed on **43 / 43** real orifices.
- The plugin's Boyd's detention formula is **algebraically identical** to CE's sheet.
- **The plugin's rainfall intensity reads 6.5% → 8.6% HIGH** against a real issued sheet. Pinned by a
  characterisation test so it cannot drift further unnoticed. **This is the biggest open engineering
  item.** See below.

---

## The next piece of work: per-job rainfall coefficients

**Tim's ruling, 15 Sep: *"yes, hold the coefficients per job."*** Read
`C:\CE_PLAN\01_MASTER_PLAN\IFD_RAINFALL_HOW_IT_WORKS.md` first — it is the whole picture in one page.
The short form:

- Rainfall intensity for a location is a **7 × 7 block**: seven coefficients for each of seven ARIs
  (1, 2, 5, 10, 20, 50, 100), fed to `I = exp(A + B·lnT + C·lnT² + … + G·lnT⁶)` with **T in HOURS**.
- CE's own `RS_Rain Intensity Spreadsheet.xlsx` is a **paste tool, not a station library** — "Paste
  Coefficient Values Below". Its surviving external reference points at a named range `MORN`
  (Mornington) in `C:\Users\RS2\Desktop\MORN.txt`, a former colleague's desktop file. **Those
  per-location files are gone**, which is why the workbook is full of `#REF!`.
- **The plugin ships exactly one block (Melbourne) and uses it for every job in every council.** That is
  the measured 6.5–8.6% gap.
- Tim's earlier ruling **D-Q3** — *"rainfall station per job, read it from the storm report"* — worked
  for STORM reports (which name a `Rainfall Station`) but **cannot survive Blue Factor**, which names a
  municipality instead. Per-job coefficients is what replaces it.

**Build:** a job carries its own 7 × 7 block, stored on the drawing with the rest of the project record,
with **provenance beside it** (which location, where it came from). CE asks once per job and remembers.
A job with **no** block of its own must **say which curve it is using** — never fall back to Melbourne
quietly, because quiet fallback is the exact fault being fixed.

**The one genuine unknown, recorded rather than guessed:** how CE originally fitted those seven
coefficients to the Bureau's published IFD data is not recorded anywhere CE still has. **Do not invent a
fitting method.** A block pasted by hand per job — exactly what the spreadsheet already did — makes the
plugin correct per job without needing that answer, so build that first and leave the fitting question
open for Tim.

---

## Rulings in force (Tim's own words where quoted)

| Ref | Ruling |
|---|---|
| **TWL-01/02** | Every candidate crest level is offered **with its source**; the rulebook default is shown as *not applied*, never silently used |
| **SPLIT-01** | When more than one pipe leaves a source, report a **Split** — never pick one |
| **STORM-01** | Climb up from the drawing to find the job folder |
| **STORM-02** | **Offer, never read unasked** — nothing in a client job folder is opened until Tim says yes |
| **STORM-03** | Where the report and what is typed disagree, **show both and Tim picks**; keeping what is entered is the default |
| **STORM-04** | Fill the council in on an **exact match only** — a near-miss must never load a rulebook |
| **Blue Factor** | *"we use blue factor from now onwards"* — the words in the UI say **"rating report"**, not "STORM report" |
| **Coefficients** | *"yes, hold the coefficients per job"* |
| **CDCALC** | *"cdcalc should handle everything"* / *"it should do everything automatically and just ask for confirmation from end user"* — **CDCALC does all the computations and produces the computations sheet. That has been the plan the whole time.** |
| **F-Q3** | Computations sheet: **clean V3 with Creative Engineering branding and a logical layout** |
| **F-Q4** | The sheet is produced **directly through CDCALC** |
| **F-Q5** | Where a figure cannot be established: **warn** (never block — see R-27) |
| **R-00** | Settings-first: every engineering and council value lives on the Settings page, nothing hard-coded |
| **R-27** | **No hard blocks.** Only two exist (deleting spine IDs, pushing an update on a failed build). Everything else warns and records |
| **DATA-01** | Never copy a client name, address or job address into any repository. Every test fixture stays synthetic |
| **Ownership B** | **Codex builds windows. Claude owns behaviour, the spine and deploys.** Never prompt Claude to build a window |
| **Plan label** | The plan label wins over the stored pit ID; never rewrite plan text to match a record |
| **Undo** | One accepted edit = one Undo |
| **net48** | 2022–24 users **are** in scope for pipe behaviour via overrules. Batches must build **and load** on net48 |

---

## Open — needs Tim, do not decide these yourself

1. **Q-GRIP-1** — when a pipe end grip is dragged off its pit: leave it, or ask? *(Q-GRIP-2 was withdrawn
   — see the correction note below.)*
2. **Two tank block names are unreadable** — `A$C1cba1a13` and `A$C72c6940a`. Tim needs to say what they are.
3. **Structural packaging** — no release script, and its bundle carries no `CE_SHARED.dll`. Civil and
   Structural must ship from the same commit, so this blocks a joint release.
4. **Where new IFD coefficient blocks come from** — see above.

## Still to build in this lane

- **F1** — the computations sheet itself: clean V3, CE branding, produced by CDCALC.
- **D2** — provenance: every figure says where it came from.
- **F2** — one record behind all three outputs (drawing, schedule, sheet).

---

## Two process lessons from the last session — they cost real time

1. **Presence of code is not evidence of behaviour.** The first OVR-01 gap report credited
   `CompoundGripOverrule` with suppressing wall grips — it is registered inside `if (false)`. It also
   treated pipe walls as MLINE entities; they are *drawn* by `PipeDrawableOverrule.WorldDraw`. Both were
   wrong, both are corrected in a CORRECTION section in
   `docs/workflows/OVR-01_NET48_GRIP_GAP_REPORT_2026-09-15.md`, and **Q-GRIP-2 was withdrawn** as a
   result. If you have not seen it run or seen it in a log, say "I have not verified this".
2. **Do not write C# through shell heredocs.** `\n` and `\r\n` inside a heredoc become real newlines
   inside the C# string literal and break the build — this happened six times. Use a scratchpad `.py`
   file or the Edit tool.

Add a `REGRESSION_LOG.md` entry for **every** change, and keep test fixtures synthetic (DATA-01).
When Tim makes a decision, commit it to `C:\CE_PLAN` **the moment he makes it** — in his own words, in
quotes — not only in the chat.
