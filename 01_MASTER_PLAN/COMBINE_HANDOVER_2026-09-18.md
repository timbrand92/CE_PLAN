# COMBINE handover — 18 September 2026

**One file, three sections, appended not overwritten.** Each chat with unreleased work writes its own
section here; the COMBINE chat merges from it.

**Installed right now:** `3.0.0+d0ffe1a2` — read it back from the DLL, never trust this line.

**Rules for every section (they exist because both went wrong on 17 September):**

1. **Verify your tip with git before you write it.** Both handover packs on 17 Sep named a stale tip
   and one of them shipped a build missing fixes Tim had already been told about.
2. **Re-run your tests now.** Do not quote an old result. Compare failing test **names** against the
   22 recorded in `PENDING_TESTS.md`, never counts.
3. **Say plainly what has never been opened in AutoCAD.** Built, tested, installed and Tim-accepted
   are four separate facts.

## Known conflict the COMBINE chat must resolve

`Modules/Drainage/Commands/PipeEditCommand.cs` is edited by **both** the windows chat (removed the
dry-run preview wiring) and the other-Civil-areas chat. **Keep both behaviours** and say which.

---

## Section 1 — windows / deploy chat

**Written 18 September 2026. Every number below came from running the thing, not from memory.**

### 1. Branch and tip — verified with git

| | |
|---|---|
| Branch | `claude/civil-combined-2026-09-17` |
| Tip | **`c9dac1bc63f7720da99c729c161fe4847072c04f`** |
| `git rev-parse HEAD` vs `@{u}` | **identical** |
| Pushed | **yes** |
| Working tree | **clean** (0 files) |
| Commits ahead of installed `d0ffe1a2` | **6** |

### 2. What changed since the installed build, in drawing terms

| Ref | What Tim would see |
|---|---|
| **W-06** | **The tank picker stops putting the wrong name on tanks.** On Tim's own master, FIVE different tanks were all tiled "KINGSPAN 6000 L SLIMLINE METAL TANK" — three of them are really 3500 L, 5000 L and 6000 L. Pick the 6000 L tile, get a 3500 L tank. Each title now belongs to one tank; a tank with no title of its own reads "Untitled tank plan" instead of borrowing someone else's. Also fixed a tile reading `xsm1;5500 lt MELRO...`. |
| **W-07** | **CDWT warns when it used a different standard detail.** The tank detail is found by an anonymous block name that moves whenever the master is resaved, and the fallback to "the biggest tank-ish block" was silent. It now says so at the command line, and a test fails the build the day the name moves. Checked against the current master: the right block is still there. |
| **W-08** | **The tank window explains an empty plan list.** With no plans found it was half a window of empty black and "Place tank" permanently greyed out, with nothing saying why. It now names the drawing CE opened, both likely reasons, and both ways to carry on. |
| **DRYRUN-01 withdrawn** | **The Edit Pit / Edit Pipe picture no longer redraws to show what Save WOULD do.** The plan preview stays. See section 6 — this is NOT the fix for P13 it was first claimed to be. |
| **Label-fit CONTRACT** | **A document, not a code change.** `docs/workflows/CD_LABEL_TAB_FIT_CONTRACT_2026-09-17.md`. Double-clicking a pipe LABEL opens the OLD editor because that view needs 823 pixels against an 820 cap — three pixels. The extra height lives in `CdDialog.xaml`, which is **Codex's** file under ruling B, so it was measured and handed over rather than changed. Building it clears **five** of the 22 known red tests. |

### 3. Files changed — 15 files, +1014 / -27

**Code (13):**

```
Modules/Drainage/Commands/PipeEditCommand.cs          <-- CONFLICT, see below
Modules/Drainage/Commands/PitEditCommand.cs
Modules/Drainage/Dialogs/WaterTankDialog.xaml
Modules/Drainage/Dialogs/WaterTankDialog.xaml.cs
Modules/Drainage/Rules/WaterTankPlanTitleAssignment.cs            (new)
Modules/Drainage/Rules/WaterTankPlanTitleRule.cs
Modules/Drainage/Services/WaterTankDetailDrafter.cs
Modules/Drainage/Services/WaterTankPlanBlockSource.cs
Modules/Drainage.Tests/Commands/DryRunWithdrawnTests.cs           (new)
Modules/Drainage.Tests/Commands/PitLabelAttributeProbeTests.cs    (new)
Modules/Drainage.Tests/Dialogs/WaterTankDialogFirstTests.cs
Modules/Drainage.Tests/Rules/WaterTankPlanTitleAssignmentTests.cs (new)
Modules/Drainage.Tests/Services/WaterTankDetailDrafterTests.cs
```

**Docs (2):** `REGRESSION_LOG.md`, `docs/workflows/CD_LABEL_TAB_FIT_CONTRACT_2026-09-17.md`

### CONFLICT — read this before merging

**`Modules/Drainage/Commands/PipeEditCommand.cs` is edited by this chat AND by the other-Civil-areas
chat.** My change there is small and contained: at the point where `vm.DryRunPreview` used to be
assigned, **the assignment is gone** and a block comment explains why. **Nothing else in that file was
touched.** The separate `IsDryRunPreview` flag further down (around line 385) is a different thing and
is **untouched** — do not delete it while resolving.

**How to resolve:** take the other chat's version of the file wholesale, then delete only the
`vm.DryRunPreview = ...` assignment from it. `DryRunWithdrawnTests` will tell you if you missed it.
The same assignment must also be gone from `PitEditCommand.cs`.

### 4. Test result — re-run on 18 September, not quoted from yesterday

| | |
|---|---|
| net48 | **0 errors** |
| net8.0-windows | **0 errors** |
| net10.0-windows | **0 errors** |
| Full net10 suite | **9,921 run · 9,882 passed · 22 failed · 17 skipped** |

The 22 failing **names** were compared against the 22 recorded in `PENDING_TESTS.md`: the lists are
**byte-identical**. **No new failures, none fixed.** 19 tests added since the installed build.

**One caveat to carry:** `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`
appeared once as a 23rd failure on 16 September ("the PDF renderer produced only blank page(s)"). It
passes 15/15 on its own and has not reappeared in four full runs since. Recorded as **flaky under
full-suite load, not a regression** — if it shows in the combined run, it is not new.

### 5. What is untested in AutoCAD

**All of it. Nobody has opened any of this in AutoCAD.** Built and unit-tested only.

The rendered window picture was opened and looked at (`cdwt-window-no-plans.png`), and Tim's real tank
master was read through the production code path with every tile name printed — but neither of those is
an AutoCAD result. Test steps are rows **N1-N6** in `PENDING_TESTS.md`.

### 6. Corrections — do NOT re-import the wrong story

Two diagnoses from this chat were stated too confidently and are corrected in the plugin
`REGRESSION_LOG.md` under **"CORRECTION (2026-09-18)"**, at the very top. Read those before the
entries beneath them.

- **The DRYRUN-01 withdrawal does NOT fix P13.** I said it did. Codex's control test — open Edit Pit,
  **change nothing**, Cancel, press `U` — leaves the marker line anyway (first `U` reports `CDEDIT`,
  second reports `LINE`). The extra Undo appears with or without the dry-run. **P13 is still OPEN and
  its cause is not established.** The withdrawal stands on the narrower ground that the preview ran the
  real writer and the log shows `Project data saved to DWG successfully` six times while it was only
  redrawing.
- **P12 is not preview-only.** Codex's **P14** reproduces the circle-and-number separation with **no
  resize at all** — just changing the label corner. The label block holds a **wipeout** (that is the
  circle) plus the number as an **attribute with its own position**, and
  `PitEditCommand.ShiftAnnotation` assigns `br.Position` and never touches `br.AttributeCollection`.
  **So a real Save separates them on the drawing too.** Not fixed here — it is in the K/L chat's fence
  and is item 2 on Tim's repair list.

### 7. Half-done, and what only Tim can answer

**Nothing is half-done.** Every change is committed, tested and logged.

**Deliberately not done, with the reason:**

- The **label-fit fix** — handed to Codex as a written contract (Codex's file, ruling B).
- **`ShiftAnnotation` attributes** — K/L's fence; the FIXES chat now carries it as repair 2.
- **`OrificeStandardDetailDrafter` has the same anonymous-block-name trap** that W-07 fixed for tanks.
  Ten minutes of work, outside this chat's fence. **Parked, not fixed.**
- A **"show me" screenshot command** — dropped, because Codex can now drive AutoCAD directly.

**Open for Tim — none of these were decided for him:**

1. Two tiles read **"Untitled tank plan"**. Leave them honest, or name them from something?
2. The **4500 / 5500 MELRO** titles now attach to different blocks (4500 -> 5600x1760,
   5500 -> 4622x1760). A 5500 L tank reading smaller than a 4500 L one is odd. Tim said *"check online
   to confirm and go with what you think"* — **that research has NOT been done yet.** It belongs with
   the tank-library work (FIXES chat, repair 3).
3. **Tim's instruction of 17 September is NOT built:** *"cdwt add rl base in window, make sure the
   window has update tanks and sizes and ability to select from sorted list with visuals showing them."*
   That is repair 3 in the FIXES chat, and it also covers the blank tile pictures and the W4 crash.

**Answer to Tim's question "you were checking from my templates no?":** no — the Standard Details
masters (`Standard Details\Civil\CE Civil WATER TANKS PLAN.dwg`; the window itself reads the `.dxf`
twin of the same name). The Drawing Templates folder was never touched.

---

## Section 2 — other Civil areas chat (C7 / labels / sources)

Written 18 September 2026. Everything below was checked with git and a fresh test run, not remembered.

### 1. Branch and tip — verified with git

| | |
|---|---|
| Branch | `claude/civil-other-areas-handoff-d747af` |
| Tip | **`24d9230fd89c6944e84aae67e2e60ad5f5111ad0`** |
| `git rev-parse HEAD` vs `@{u}` | **identical** |
| Pushed | **yes** |
| Working tree | **clean** (0 files) |

### 1a. READ THIS BEFORE MERGING — my branch does NOT contain the installed build

`git merge-base --is-ancestor d0ffe1a2 HEAD` → **NO**. This branch is **not ahead of the installed build; it
is beside it.** It forked at **`e0cfe172`** and never took the later work.

- **7 commits** are on this branch and not installed (4 code + 3 `FLEET_STATUS.md`).
- **15 commits are in the installed build `d0ffe1a2` and are NOT on this branch** — including
  `CDWT-W01`, `DRYRUN-01`, `BUG-158/F1-01..05`, `CD-TICKS-01`, `PIT-TWEAKS-01`, `PERF-003`, and the K/L chat's
  `L-01/L-02`, `P-08/item 64`, `item 66`, `item 67`, `AUDIT-K-L`, `L-02c`, `F1-06`.

**Therefore: this branch must be MERGED into the combined line. It must never be built or deployed on its own —
doing so would remove fifteen commits' worth of work Tim has already been told about.** That is precisely the
failure mode of 17 September; this is what it looks like when you check for it.

### 2. What is on this branch that is not installed

Four pieces of behaviour. **None of them has ever been opened in AutoCAD by anyone — not by me, not by Tim, not
by Codex. Built and unit-tested only.**

| Commit | In drawing terms | Opened in AutoCAD? |
|---|---|---|
| `0b3f17bd` **IDENT-02 / P-07** | On a job you have just opened, double-clicking a pipe's own IL text or pipe text now opens the **Edit Pipe window**. It used to open AutoCAD's plain text editor until you had edited that pipe once in the same session. | **No. Nobody has opened it.** |
| `d63a29f3` **BLANK-01** | Emptying a level box in the Edit Pipe window now **deletes** the level. The old number used to come back — from the pipe's own record *and* from the schedule row. Two guards: "just draw the pipe" and a mistyped level never delete anything. | **No. Nobody has opened it.** |
| `acfb38f6` **T-01** | `CDFIXTAGS` stops contradicting itself (it used to print "Nothing to repair" after a run that failed), **tries every rename** instead of stopping at the first awkward block, and gives each failure a plain-English reason with what to do next. | **No. Nobody has opened it.** |
| `24d9230f` **P-02** | When a pipe drawn across pits is split, the split level now sits **at the pit it was split at**. One of the two copies used to be drawn back at the far end of the pipe, on top of a different level. | **No. Nobody has opened it.** |

Doc-only: `6abcdfc9`, `60b3a46a`, `96219ec0` (`FLEET_STATUS.md`).

Full write-ups: plugin `REGRESSION_LOG.md` entries **IDENT-02**, **BLANK-01**, **T-01**, **P-02** (top of file).
Tim's test steps: `PENDING_TESTS.md` rows **O16-O23**, **O24-O29**, **O30-O36**, **O37-O40**.

### 3. Files changed (vs the fork point `e0cfe172`) — and the PipeEditCommand conflict

```
Modules/Drainage/Commands/PipeEditCommand.cs               +43  -0   << CONFLICT, see below
Modules/Drainage/Commands/PipeEditCommand.Update.cs        +26
Modules/Drainage/Commands/SourceTagRepairCommand.cs        +44
Modules/Drainage/Helpers/ConnectedPipeFlowResolver.cs      +25
Modules/Drainage/Rules/DuplicateSourceTagPolicy.cs         +83
Modules/Drainage/Services/LinkService.Cache.cs             +97
Modules/Drainage/Services/LinkService.Persistence.cs       +54
Modules/Drainage/Services/LinkService.Split.cs             +28
Modules/Drainage/Services/SourceTagRemovalClaims.cs        +11        (diagnostic line only)
Modules/Drainage.Tests/... 4 new test files               +572
REGRESSION_LOG.md, FLEET_STATUS.md                         (docs)
```

> ### WARNING — `Modules/Drainage/Commands/PipeEditCommand.cs`, the known conflict
>
> The windows chat also edited this file (it **removed the dry-run preview wiring**). **Keep both.** That should
> be easy, because **my change to this file is purely additive: 43 insertions, 0 deletions.** It adds exactly
> two things and touches nothing else:
>
> 1. **Two diagnostic lines** at the Edit Pipe window's two silent exits — Cancel/Escape, and "OK pressed but
>    nothing changed". Both used to write **nothing at all**, which is why "changing an invert does nothing"
>    could be neither confirmed nor refuted from Tim's 16 Sep log.
> 2. **One new pure method, `LevelBoxesAreAuthoritative(...)`** — the BLANK-01 rule that decides whether this
>    save may speak for the pipe's levels. Nothing calls it except `PipeEditCommand.Update.cs`.
>
> **I did not touch the dry-run preview wiring in any file.** A merge that keeps the windows chat's deletions
> and my two additions is correct and complete.
>
> I also changed **`PipeEditCommand.Update.cs`** (BLANK-01 wiring: compute the authority flag from the raw boxes
> before auto-calc or "simple pipe only" rewrite them, pass it to `UpdatePipeSchedule`, and relax the guard so a
> both-blank save still reaches the pipe as a deletion). The windows chat has **not** listed that file, so it
> should come across cleanly — but check.

### 4. Test result — re-run on 18 September, not quoted from yesterday

| | |
|---|---|
| Builds | **net48 0 errors, net8.0-windows 0 errors, net10.0-windows 0 errors** (`-p:SkipDevBundle=true -nr:false --disable-build-servers`) |
| Test project build | 0 errors |
| Full net10 suite | **9,844 run / 9,804 passed / 23 failed / 17 skipped** (`handover-18sep.trx`) |

**Compared by NAME against the 22 recorded in `PENDING_TESTS.md`** (which are 20 distinct names once the
parameterised cases are collapsed):

- **Nothing from the recorded list is missing** — every recorded failure still fails here, none has silently
  "gone away".
- **One name fails here that is not on the recorded list:**
  **`PreviewPackage_AllSections_RetainsStatusAndUsesAdvisoryWsudAuthority`** (`CalculationsV2ViewModelTests`).

**Why, and it is not a regression from my work — but the COMBINE chat must confirm it:** that test exercises
`CalculationsV2ViewModel`, and commit **`308ea803` (BUG-158 / F1-01..05, the computations sheet)** — which **is
in the installed build and is NOT on my branch** — changes that exact class (+129 lines) and
`CalculationExportPackage.cs`. So the most likely explanation is that the windows chat's sheet work already
fixed it on the combined line and my branch simply predates that fix. **Stated as the best-supported reading,
not as a proven fact: I cannot run their branch from here. After the merge this test should pass; if it does
not, that is a real finding and must be raised, not written off.**

### 5. Open questions for Tim, and what is half-built

**ANSWERED 18 September — P-01.** Tim: ***"ask inside the CD window as a tick"***. The command-line question is
**moved, not retired**; the splitting itself still runs after the pipe is drawn (the halves cannot link to their
pits until the pipe exists). **Codex builds the tick** (ruling B); this lane published the contract it is built
from: `01_MASTER_PLAN/CONTRACT_SPLIT_ON_DRAW_TICK_2026-09-18.md`. Ruling at `TEST_DAY_RESULTS_2026-09-16.md`
§6s. **Nothing is built for it yet — no code on this branch changes because of this ruling.** Two items still
need Tim (the tick's wording, and what replaces the old Escape route — a retirement, so his word is required),
and one thing this lane must prove before it ships: that one `U` after a ticked draw removes the pipe, its
halves and their labels together. Not verified, not claimed.

**Not started, and openly unfinished in this area:**

- **P-05** — each pipe between pits needs its own pipe text. The split **partitions the one existing pipe text**
  between the two halves (`LinkService.Split.cs` ~1452-1493), so one half is left with none. Diagnosed, not built.
- **P-04** — a pipe with more than one bend. Not diagnosed.
- **P-07 first half** — *"changing an invert does nothing"*. `HasDialogChanges` **does** compare both invert
  values, so the obvious explanation is ruled out and I have **no evidence for another**. The two new diagnostic
  lines are what will settle it on the next run (row **O23**). **Not claimed fixed.**
- **T-01's underlying refusal** — the guard that stops a rename when a label is claimed by two sources was **not
  bypassed**, and whether it is right on Tim's drawing is **not established**. A new `[SourceClaims] refused:`
  log line records the evidence (row **O36**).

**A standing risk I could not check from here:** the **pipe import** (`CDIMPORTXCIVIL`) has had no code change
since **3 July**, was **not** in the 16 Sep Test Day, and is **on no pending test list** — yet every imported pipe
now goes through the same path `CD` uses and therefore becomes a CE pipe object. **Nobody has run an import since
that change.** Also recorded: `CDIMPORTLANDXML` reads 0 pipes from a real Civil 3D export — that finding
(**C5-LXML-01**) is on a **different branch** (`1801d1ce`, not an ancestor of this one) and was **not re-verified**.

### 6. Codex's failure register — what I actually close

Read: `C:\Lisp Files\_TEST_COPIES_20260917\package\FAILURE_EVIDENCE_REGISTER_2026-09-17.md`.

**I close NO register ID outright. I am not claiming any of the O-series.** O1, O3, O4, O5, O6, O10, O12 and O17
are all C7 / label-follow / upgrade behaviours that were **already in the installed build** before my four
commits; none of my four commits touches them.

**One partial, stated precisely:**

- **K7** — its headline finding is the `CDLPD` note wording, which is **the K/L chat's, not mine**. But the last
  sentence of K7 records: *"Earlier blanking a connected pipe did not establish Unknown after save (19.35
  returned)."* **That observation is exactly what BLANK-01 (`d63a29f3`) fixes** — a blanked level used to be
  refilled from the pipe's own record and from the schedule row. **So: K7's blanking sentence should now behave;
  K7 itself stays OPEN on its wording.** Retest with `PENDING_TESTS.md` rows **O24-O29**.

**One thing I checked and must report as a NEGATIVE, so nobody merges it expecting a win:** I looked at whether
IDENT-02 also explains **O3 / O4 / O17** (labels and arrows staying behind when a pipe is moved or gripped),
because the watcher reads a per-drawing cache and IDENT-02 fixed a per-drawing cache. **It does not.** The
watcher matches a *pipe's* label through `PipeMemberOwners` (`LinkService.Reactors.cs:75, 81`), which was
**already** warmed when a drawing opens. IDENT-02 fixed `AttachmentPositions`, which is the *double-click* route
only. **O3 / O4 / O17 remain open and unexplained by anything on this branch.**

---


---

## Section 3 — K / L chat (CDLPD · pit resize · tanks · propagation)

### 1. Branch, tip, pushed — verified with git just now, not remembered

| | |
|---|---|
| Branch | `claude/civil-k-l-2026-09-16` |
| `git rev-parse HEAD` | `457bf032ec6a02d370619a5df02870cf0afbafad` |
| `git rev-parse @{u}` | `457bf032ec6a02d370619a5df02870cf0afbafad` |
| **Pushed** | **yes** — HEAD and upstream identical |
| Worktree | **clean**, `git status --porcelain` empty |
| Installed build read from the DLL | `3.0.0+d0ffe1a281808c1837375785351581610dcc9c51`, written 16 Sep 22:41 |

**Checked with `git merge-base --is-ancestor`, not assumed:** my first **eight** commits (`8a2b946c` … `26432227`)
**are** in the installed build. My last **three are NOT**:

| Commit | In `d0ffe1a2`? |
|---|---|
| `b8d827b8` TWL-04 / TWL-06 | **NOT installed** |
| `b8e234f9` TWL-05 | **NOT installed** |
| `457bf032` PSD-01 | **NOT installed** |

### 2. The three uninstalled commits, in drawing terms

**`b8d827b8` — CDTWL takes the engineer's own level, and stops losing the system.**
Asked which level is the top water level, CDTWL only accepted a row number — so typing the level the job was
designed to (18.54) got *"1 or 2 only"* and the engineer was stuck. It now takes a row number **or** a level
(a decimal point means a level; a whole number inside the list means a row; outside it means a level), warns
without blocking if that level is above the lowest lid, and no longer stops dead when it can measure nothing.
Separately, **8 pits were being dropped from the storage total** because a pit's level is usually not typed
into the pit — it is on the pipes that meet it, which is where the pit schedule has always read it. A pit
with no level of its own now takes the lowest invert of its connected pipes and **says so**.

**`b8e234f9` — TWL-05. The required volume was born as `"0.0"`, and that zero reached a council drawing.**
One line: a new detention system started with the volume box holding the text `"0.0"` instead of empty.

> **What a wrong figure looked like on a drawing — asked for explicitly.**
> The ON SITE DETENTION CRITERIA block printed **`VOLUME REQUIRED    0.00 m3`**. Not blank, not "unknown" — a
> **figure**, on the block a council reads, saying this system is required to hold **nothing**. Any system
> nobody had typed a volume into printed that, and the block gives no hint it was never worked out. A
> reviewer comparing "required 0.00" against a storage total would find the system passes trivially.
> It now prints **`NOT SET`**. (`NOT SET` is my wording — **not** recovered from a CE drawing. Tim has not
> confirmed it. See §7.)
> CDTWL also told Tim `"0.0"` was *"not a plain number"*, which is untrue and unhelpful; and when no CDCALC
> system matched the chosen outlet it offered nothing **and said nothing**. Both fixed.

**`457bf032` — PSD-01. The permissible site discharge stays empty until entered or found.**
Every new detention system started with a permissible site discharge of **5.24 l/s hard-coded in code** — a
real figure from somebody else's job, indistinguishable on screen from one worked out for this one, and it
**sizes the orifice**. Tim, 17 Sep: *"stay empty until inputted or found in cddesign"*. Both halves built: the
box starts empty, and the PSD the calculation already holds (`BoydsDraftData.PsdDischarge`, which nothing was
reading across) is now **offered** like Boyd's volume already is — offered, never applied, and a typed figure
is never overwritten. **The one-click button itself is window work (ruling B) and is NOT built**; the command,
its label and its enabled state exist and are tested.
⚠️ **Jobs saved before 17 Sep still hold `5.24`.** CE does not rewrite an engineer's records, so any job not
checked since is worth a look.

### 3. Files changed (`git diff --name-only 595c8672 HEAD`)

18 production files, all under `Modules/Drainage/`:

```
Commands/DetentionTwlCommand.cs          Rules/TopWaterLevelChoice.cs          (new)
Commands/LpdCommand.cs                   Rules/WaterTankFacts.cs
Commands/PitEditCommand.Resize.cs        Services/DetentionTwlService.cs
Commands/PitEditCommand.cs               Services/LinkService.PitMoves.cs
Models/UserSettings.cs                   Services/LinkService.RepairAudit.InvertPropagation.cs
Rules/DetentionBranchCollector.cs        Services/OnSiteDetentionCriteriaService.cs
Rules/DetentionVolumeRequired.cs  (new)  Services/TextService.cs
Rules/LpdNotePlacement.cs         (new)  ViewModels/CalculationsV2ViewModel.cs
Rules/SourceFamilies.cs                  ViewModels/DetentionSystemViewModel.cs
```

Plus `REGRESSION_LOG.md`, `FLEET_STATUS.md` and 8 test files.

**I did NOT touch `PipeEditCommand.cs` or `PipeEditCommand.Update.cs`** — I am not part of that conflict.
**I DID edit `PitEditCommand.cs`**, but only outside its preview parts (`DryRunPitEdit` untouched).

**Shared files I touched, declared:** `TextService.cs` (two **optional** parameters, both defaulting to prior
behaviour — no pipe callout changes), `LinkService.PitMoves.cs` (one new internal entry point; the pit MOVE
path unchanged), `DetentionTwlService.cs`, `OnSiteDetentionCriteriaService.cs`,
`CalculationsV2ViewModel.cs` (one new push method + a hook, mirroring the existing Boyd's one).

### 4. Test result — re-run just now at `457bf032`, not quoted from earlier

- **Builds: net48, net8.0-windows, net10.0-windows — 0 errors** each, `-p:SkipDevBundle=true`.
- **Full net10 suite: 9,936 run · 9,896 passed · 23 failed · 17 skipped.**
- **By name**, the failures are the 20 recorded names (with `EveryTabFitsOrUsesExplicitFallbackAtOfficeScaling`
  ×3 cases = 22 executions) **plus one**:

  **`PreviewPackage_AllSections_RetainsStatusAndUsesAdvisoryWsudAuthority`**

  **It is not mine.** It was already failing in the baseline I captured at my branch point `595c8672` **before
  I changed anything** — the file is `ViewModels/CalculationsV2ViewModelTests.cs`, which I never edited. It is
  a difference between my branch's base and whichever branch the 22 were recorded on. I did edit the
  production `CalculationsV2ViewModel.cs` for PSD-01; that change neither caused nor cleared it.
  **The COMBINE chat should expect 23, not 22, and confirm this name after merging.**

### 5. NOTHING here has been opened in AutoCAD by me

Built and unit-tested. **Not installed, not Tim-accepted.** Codex opened the first eight commits (they are in
`d0ffe1a2`) — see §6. **The last three commits have never been run by anybody.**

### 6. Codex's evidence — what my commits address, and what they do not

**I read the register rather than the summary, and two of the IDs I was asked about do not exist.**

> **L6, L7 and L8 are NOT in `FAILURE_EVIDENCE_REGISTER_2026-09-17.md`.** Its L-series is L1, L2, L3, L4, L5,
> L10, L12, L13 only, and **the register never mentions CDTWL at all.** I am not going to answer for evidence
> I cannot find. If those IDs live in another file, point me at it.

**What a drawing must contain for CDTWL to work — asked for, and answerable from the code regardless:**

1. **CE drainage records.** CDTWL reads the CE data saved in the drawing. A plain DWG with no CE pits or
   pipes gives *"This drawing has no CE drainage records yet"*. Drawing lines is not enough — the pits and
   pipes must have been made or adopted by CE commands.
2. **At least one pit whose type contains the word DETENTION** — that is the outlet CDTWL works upstream
   from. Without one: *"No detention pit was found in this drawing."* A tank alone is not enough.
3. **Pipes whose From and To name pits that exist**, because the branch is walked upstream through those
   names, and a pipe's length is measured from where its two pits sit.
4. **Levels** — a pit's own level, or a level on a pipe that meets it (that second route is `b8d827b8`, and
   is **not installed**).
5. **A volume required**, on CDCALC's Detention tab, for the storage check to mean anything.

   **In short, for Tim: a job that already has a detention pit, its pipes drawn with CD, levels on them, and
   CDCALC filled in.** Best candidate is the job whose figures he quoted on Test Day — 17,948 L found against
   25,060 L required.

| ID | Does my work address it? |
|---|---|
| **L1 / L4** — pipe ends still short of the enlarged outline; shrinking leaves the end out at the old position | **No — and this is the important one.** My pit-resize re-snap (`6f986c93`) **IS in the installed build Codex tested**, and the gap is still there. So the fix is installed and not working, and I do not know why. **L5 says diagnostics were off, so the two log lines that would have told us — `PITEDIT Resize:` and `gapBefore=`/`gapAfter=` — were never written.** They are `LoggingService.Diagnostic`, so **diagnostics must be ON to see them**; that is why L5 found them missing, not because they are absent from the code. Candidates I could not test: the re-snap only runs when the retry policy returns `Finish`; `AdjustLinkedPipesToPitBoundary` gives up when it cannot read the pit outline, and L1 itself notes *"Text tidy skipped unreadable outline 1041DE"*. **Hand to the FIXES chat with diagnostics ON as the first step.** |
| **L10** — converted pipes, drawn level 17.35 but schedule IL cells blank | **Corroborates the gap I handed over and did not fix.** Writing a converted pipe's own stored record goes through `WritePipeLinkData` → `GetOrCreateLinkDictionary`, which reads `entity.ExtensionDictionary` **directly** instead of through `PipeGeometrySeam.ResolveExtensionDictionary` — for a converted pipe that is the stand-in's dictionary, not the real object's. I predicted blank records from reading the code; **L10 is that prediction showing up on a drawing.** The file is `LinkService.Persistence.cs`, the other-areas chat's. Still not fixed. |
| **L13** — locked label layer: *"Updated 2 pipes 1 pit"*, drawing stays 19.60/19.35, schedule advances to 19.50/19.25 | **A real gap in my own item-67 fix, which Codex found and I had not.** My restore only fires when the whole transaction throws **or** zero pipes were written. Here the pipes **did** write and only the annotation write failed on the locked layer — so nothing triggered, and the schedule ran ahead of the drawing. **This is exactly the fault item 67 was meant to close, in a case I did not cover.** Needs: an annotation write that fails must count as a pipe that could not be updated. |
| **L12** — locked converted pipe refused with *"Nothing was changed — the drawing could not be written: eOnLockedLayer. The levels on the drawing and in the schedule are as they were."* | **That is my code, running and doing its job** — the record was put back and the refusal explained. **But it "did not name the failed pipe".** Correct: on the exception path I restore and explain but never list `couldNotWrite`. Small, specific fix. Codex also notes the **preview said ready to apply despite a locked pipe** — the preview does not test writability. Not mine, not built. |
| **L2** — *"Circle and cover step out, but P10 number stays and separates from circle"* | **This is the answer to §6 below, and to BUG-151 / P-08.** See next. |
| **K2 / K3 / K5 / K7** — the LPD note comes out as `LPD - COUNCIL PIT, IL18.65mAHD` | **ROOT CAUSE FOUND — see the box below. Not a code fault; a settings one.** |

#### ROOT CAUSE, proven, that the COMBINE / FIXES chat must have: the old note template is stuck in Tim's settings

Codex photographed the note as `LPD - COUNCIL PIT, IL18.65mAHD` — the **short** callout, not the sentence.
I read Tim's live settings file, `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`:

```json
"lpdStandardNote": "LPD - {connection}, IL {invert} m AHD"
```

That is `LpdStandardNote.ShortCalloutTemplate`, saved before the default changed on 15 September.
`Render` only falls back to the new default when the stored template is **blank** — so **a stored old value
wins forever**, and every note on Tim's machine comes out short no matter what the code says.

**This explains K2, K3, K5 and K7 in one go, and it clears my own work of two of them:**
- **K3** — the MLeader and its arrow **did work** (*"Leader has arrow at downstream end"*). It reads as "one
  short line" because the short template **is** one line; there is nothing to wrap. The wrapping is untested,
  not broken.
- **K7** — *"correctly omits IL and zero"* — **my L-03 fix is proven working on a drawing.**

**Fix needed (NOT built — I am stopping):** a settings migration, so a stored template that is exactly the old
short one is treated as "not customised" and gives way to the current default. Changing a default does nothing
for anyone whose settings were already saved — that is a general hole in settings-first (R-00) and it will bite
again. **Until it is fixed, Tim can clear the LPD note box on the Settings page and the correct wording
returns.**

#### K4 — a defect of mine that my own unit test could not catch

Codex: typing `Council` produced **COUNCIL STUB**, not COUNCIL PIPE. My rule maps the retired word `Council`
→ COUNCIL PIPE and the test passes — **but AutoCAD resolves the ambiguous keyword first.** `Council` is a
prefix of `CouncilStub`, `CouncilPit` and `CouncilPipe`, so the prompt hands my code `"CouncilStub"` and my
retired-keyword branch is never reached. **I tested the rule, not the prompt** — the exact trap the rules warn
about. Needs either a non-ambiguous retired alias or the prompt handling it explicitly.

### 6b. ⚠️ ShiftAnnotation and the pit label — MY FENCE, and my answer on ownership

**Documented fact, from our own code, not inferred:**
- The pit number is a **block attribute** named `PIT_LABEL` (`BlockService.SetAttribute(labelId, "PIT_LABEL", …)`,
  `ReadBlockAttribute(blockRef, tr, "PIT_LABEL")`).
- `PitEditCommand.ShiftAnnotation`, for a `BlockReference`, does **`applyPos = p => br.Position = p;`** and
  **never touches `br.AttributeCollection`**.

**Observed on a drawing (Codex L2):** *"Circle and cover step out, but P10 number stays and separates from
circle."* That is precisely the predicted symptom: the block geometry moves, the attribute does not.

**This is very likely the answer to BUG-151 / P-08**, the long-running *"the pit label will not step out"*
puzzle — and it explains why my own analysis on 16 September kept concluding the rule was working. It **was**
working: the numbers in the log are the block's, and the block did move. **Nobody was looking at the number.**
It is on the drawing, not only in the preview (Codex P12 and P14).

> **OWNERSHIP ANSWER, so two chats do not edit it at once: I am HANDING IT TO THE FIXES CHAT and RELEASING MY
> FENCE over `PitEditCommand.ShiftAnnotation`, `PitAnnotationShift` and `PitEditCommand.Resize.cs`.**
> I have been told to stop building, so taking it myself would hold up the second repair on Tim's list. The
> diagnosis above is complete enough to act on without re-hunting it. **I will not touch those files again
> unless Tim says otherwise.**
> What the fix needs: move every `AttributeReference` in the block's `AttributeCollection` by the same
> displacement as the block (and do the same wherever else CE moves a label block by setting `Position`). Then
> re-run L1–L5 **with diagnostics ON**.

### 7. Open, and only Tim can settle them

1. **The street-note wrap width.** Five versions were drawn for him on 17 September; **he has not picked one.**
   Carried forward as his. The current value (19.4696 text heights) is a **starting width, not a standard** —
   his words on 17 Sep: *"width isnt a standard"*. **Note this is moot until the settings fault above is
   fixed**, because the short template does not wrap at all.
2. **`NOT SET`** in the ON SITE DETENTION CRITERIA block — my wording, not CE's. What should it say?
3. **CDTWL — should it become a window?** (his own TWL-07, asked on Test Day, still unanswered).
4. **Should CDDESIGN outrank the Boyd's tab** as the PSD source when the two differ?
5. **The computations sheet (F1-01..05 / BUG-158)** — unclaimed; he has not said whether I take it.
6. **A number, not a decision:** the new CDTWL storage total and how many pits/pipes are still left out, once
   `b8d827b8` is installed.

### 8. Half-done, named

- **The 18 dropped pipes in CDTWL.** `PipeData` records **no length and no geometry**, only a handle, so the
  pure collector can only measure a pipe from its two pits' positions. Fixing it means recording a measured
  length or letting the service supply one — a change of shape I did not guess at. **On Tim's drawing the
  pipes were the bigger half of the loss.**
- **The converted-pipe record write** (L10 above) — other-areas chat's file, untouched by me.
- **The "Use the calculated PSD" button** — window work, ruling B.
- **L13's locked-annotation case** — named above, not fixed.
