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

**Needs Tim — P-01, when should split-on-draw ask?** Today the question *"split this pipe at the pits it runs
across?"* comes **after** the Edit Pipe window has closed, at the command line. Tim on Test Day: *"asks at the
wrong time ... the question and answer are messed up."* The splitting itself has to happen after the pipe exists
or the halves do not link. **Recommendation (not decided): keep the split where it is, but ask inside the CD
window as a tick — "split where it crosses pits" — so the answer is given before he commits.** The window is
Codex's to build, so this needs a written contract from this lane and Tim's word first. Recorded in
`PENDING_TESTS.md`.

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

_(awaiting)_
