# Prompt for Tim's third Civil chat — sections K (`CDLPD`) and L (pits, tanks, levels), 16 Sep 2026

Paste everything from RUN CONFIG down into a new chat.

---

## RUN CONFIG

- **Model: Claude Opus 5 (strongest). Thinking: high.**
- **Why:** these items write notes and levels that go on issued drawings (LPD note wording, invert propagation,
  detention totals). A wrong level or a wrong note costs Tim a test cycle or a drawing.
- **Downgrade option:** Sonnet + medium only for reading records back and reporting state. Not for code.

---

## Step 0 — before anything

```bash
cd C:\CE_PLAN && git pull
```
Read `START_HERE.md`, then `01_MASTER_PLAN\TEST_DAY_RESULTS_2026-09-16.md` — **all of section 2 and sections 6a to 6l**
(6j–6l are the newest rulings; they change how labels must be placed). Then the plugin `REGRESSION_LOG.md`, newest
entries first. Verify the live bundle yourself (PowerShell, not bash):

```powershell
$p = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll'; (Get-Item $p).VersionInfo.ProductVersion
```

**Talk to Tim the way `~/.claude/rules/common/collaboration.md` says:** answer first, plain English with a
real-world example, dot points, every reply split into `▶ FOR TIM` then `▽ WORKING NOTES`. Built / tested /
installed / Tim-accepted are four separate facts.

## THIS IS AN OVERNIGHT BLOCK (Tim, 16 Sep evening: "OVERNIGHT SEQUENCE FOR BOTH THIS CHAT AND KL CHAT AS WELL")

Reply with ONE short confirmation naming the items you are taking, then **build through the night without waiting
for Tim**: items 1 to 6 below in order, each one failing test → fix → passing test → REGRESSION_LOG entry → commit →
push. Park anything that needs Tim's decision (write the question down, do not decide it) and keep moving. When the
block is done, or by **8 am on 17 Sep at the latest**, run an audit pass over your own claims (re-run the tests,
re-read the diffs, open any artefact you produced) and write the morning pack to disk:
`C:\CE_PLANCE_PLAN_MASTER_PLAN1_MASTER_PLAN\MORNING_PACK_K_L_2026-09-17.md` — one page, three lists: **built** / **test this**
(exact AutoCAD steps a stranger could follow, what "right" looks like, both lanes) / **needs Tim** (decisions,
parked items). Commit it to `C:\CE_PLAN`. **Never deploy.** If you run out of unblocked work, stop and say so in
the pack. If you must stop early (usage limit, a blocker), the pack still lands, saying where you stopped and why.

## Where to work

- Repo: `C:\Lisp Files\CE_ACAD_PLUGIN`. Make your own worktree off the window chat's trunk:
  ```bash
  cd "C:\Lisp Files\CE_ACAD_PLUGIN"
  git fetch origin
  git worktree add .claude/worktrees/civil-k-l -b claude/civil-k-l-2026-09-16 origin/claude/ce-civil-handoff-sept-16-5623ca
  ```
  Then work ONLY inside `.claude/worktrees/civil-k-l`. **Check `git log --oneline -1` shows a code commit from
  16 Sep, not a docs-only merge** — a worktree cut from `master` is 1,100 commits behind the code and useless.
- Every build and test: `-p:SkipDevBundle=true -nr:false --disable-build-servers` plus
  `-p:_AcadRef48="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2024-ref" -p:_AcadRefNet8="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"`.
- **Tests only run with AutoCAD 2027 on PATH.** Without it `dotnet test` discovers ZERO tests and exits 0 — that
  is not a pass. Always quote the executed count:
  ```bash
  PATH="/c/Program Files/Autodesk/AutoCAD 2027:$PATH" dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -f net10.0-windows -c Debug -p:SkipDevBundle=true -nr:false --disable-build-servers ...
  ```
  Baseline on the trunk `0774329d`: 9,795 run / 9,755 passed / **23 failed** / 17 skipped. New failures are yours;
  compare names, not counts. The 23 names are in the "other Civil areas" chat's scratch and in the window chat's
  REGRESSION_LOG entries.
- **Copy the native `.arx` outputs** the build wants:
  `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_*2027.{arx,pdb}` from
  `.claude/worktrees/autocad-ui-ux-design-dd0dcf` into the same path in your worktree (read the sibling, never
  edit it).

## Ownership — do not cross these lines

**The window chat (`claude/ce-civil-handoff-sept-16-5623ca`) owns:** `Modules/Drainage/Dialogs/PipeOnePageLayout.cs`,
`PitOnePageLayout.cs`, `PitConnectionSelector.cs`, everything in `Modules/Drainage/Controls/` named `Pit*Preview*`,
`CdPlanPreviewControl`, `PlanAreaRenderer`, `PitConnectionStub*`, `PitCornerGuide`; the preview parts of
`Commands/PitEditCommand.cs` and `Commands/PipeEditCommand*.cs`; `ViewModels/CdViewModel*.cs` and `PitViewModel*.cs`;
**and the whole of `CDWT` (step 65 is theirs, not yours).**

**The "other Civil areas" chat (`claude/civil-other-areas-2026-09-16-1c1ae6`) owns the one-object pipe (C7) and the
label placement rule (PLACE-01):** `Modules/Drainage.NativeObjects2027/*`, `Services/NativeObjects/*`,
`Services/LinkService.PipeWriteSeam.cs`, `LinkService.Reactors.cs`, `LinkService.Cache.cs`,
`LinkService.SourceChanges.cs`, `LinkService.Compound.cs`, `LinkService.NetworkEdits.cs`, `LinkService.Split.cs`,
`LinkService.PipeUpdates.cs`, `LinkService.PartnerInverts.cs`, `LinkService.Utilities.cs`, `LinkService.Persistence.cs`,
`LinkService.NativeEdits.cs`, `CompoundEditModeService.cs`, `PipeTruthResolverService*.cs`, `Rules/TextClashTidyUp*.cs`,
`Commands/NativePipeObjectCommands.cs`, `Commands/CdCommand*.cs`, `PipeCreationService.cs`. **Do not touch them.**

**You own for this work:** `Commands/LpdCommand.cs`, `Services/LpdService.cs`, `Helpers/PitAnnotationShift.cs`,
`Commands/PitEditCommand.Resize.cs` (non-preview), `Rules/DetentionBranchCollector.cs`, `Rules/StormReport.cs`,
`Rules/TankLibrary.cs` (read only unless needed), `Models/PropagationPlan.cs`, `Dialogs/PropagationPreviewDialog.xaml.cs`
(logic only — the window itself is Codex's under ruling B), `Services/LinkService.RepairAudit.InvertPropagation.cs`,
`LinkService.RepairAudit.Apply.cs`, `LinkService.RepairAudit.Relink.cs`. If an item needs a change outside these, write
what you need in `FLEET_STATUS.md` in your worktree and stop that item.

**One rule that reaches into your files — the one-object pipe.** Tim ruled on 16 Sep that every pipe becomes the CE
pipe object (`CE_CVL_PIPE`, an `AcDbCurve`, NOT a `Polyline`) on every open. Inside any `LinkService` partial, **read a
pipe with `TryGetPolyline(tr, pipeId)`** (it hands back the polyline, or a stand-in for a pipe object), **never
`tr.GetObject(id, …) as Polyline`** — that line returns null for a converted pipe and silently skips it.
`RepairAudit.InvertPropagation.cs` has 28 such lines today; item 67 must not add a 29th, and should fix the ones it
touches. Do not touch `Shared/CE_SHARED` without telling Tim first.

**Never deploy.** The window chat is the only deployer. When you are done, Tim brings your branch name and tip back
to the window chat and it merges and installs everything as one payload with one test list.

## What to do — Tim's order, ONE ITEM AT A TIME, each finished and committed before the next

From `TEST_DAY_RESULTS_2026-09-16.md` section 2 (his exact words are there) and the 16 Sep test list:

**K — `CDLPD`**
1. **61.** The connection list offers **CouncilStub, ExistingStub, Easement** as well as Kerb / CouncilPipe /
   SideEntry (Tim's L-01 asked for "Council Pit" — check the records for which names CE actually uses before
   adding; if the records do not settle it, ask Tim ONE batched question with a recommendation).
2. **62.** CouncilStub → `CONNECT TO COUNCIL STUB AT APPROX IL<level>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM
   ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK.` with the level to **two decimals**; placed as an **MLeader like the
   pipe callout** (L-02), not as it is now.
3. **63.** On a pipe end with **no invert set** → the note appears with the level clause left out entirely — no
   `IL m`, no zero (L-03: it still showed the invert; check the logs).

**L — pits, tanks, levels** (skip 65, it is the window chat's)
4. **64.** `PITEDIT` a 450 pit to 1200 → the label circle steps out and **keeps its distance from the pit**, like the
   cover text. Log line `ShiftAnnotation [pit label]`. (P-08: still wrong on Test Day, and it does not move the
   connections of existing pipes — the pipe-end re-snap is `AdjustLinkedPipesToPitBoundary`, which is seam-wired;
   read `docs/workflows/C7_PIPE_LINKAGE_MODEL_2026-09-16.md` §3 before touching placement.)
5. **66.** A tank's storage is counted in the detention total — tank-heavy jobs used to under-count.
6. **67.** Set an invert level by hand, run the propagation → drawing and record agree (they used to disagree
   silently).

For every item: failing test → fix → passing test → `REGRESSION_LOG.md` entry with **exact AutoCAD steps Tim can
follow and what "right" looks like** → commit → push. Synthetic fixtures only (DATA-01: no client names or
addresses anywhere — Tim's job folder path names a client address; never paste it). Record any decision Tim makes in
`C:\CE_PLAN` in his words, in quotes, the moment he makes it. Add every built item to `C:\CE_PLAN\PENDING_TESTS.md`
with branch, commit and steps, both lanes (2027 and 2024).

## Parking lot (already captured, not yours unless Tim says)

- CDWT window and behaviour — window chat. PIT window ticks/drop-downs — window chat.
- BUG-159 grip fix — the BUG-159 chat.
- Computations sheet BUG-158 / F1-01..05 — not started by anyone; ask Tim before taking it.
- Sections H, I, J, PLACE-01, C7 auto-upgrade, 2024 enabler — the "other Civil areas" chat.

## When you finish (or at 85% context) — in addition to the morning pack

Write `FLEET_STATUS.md` in your worktree with three lists — **built / untested / parked** — plus branch and tip,
and tell Tim: "Send this to the window chat: branch `claude/civil-k-l-2026-09-16`, tip `<sha>`."
