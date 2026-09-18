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

_(awaiting)_

---

## Section 3 — K / L chat (CDLPD · pit resize · tanks · propagation)

_(awaiting)_
