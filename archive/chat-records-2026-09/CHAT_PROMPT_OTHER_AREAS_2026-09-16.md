# Prompt for Tim's second chat — other Civil areas while the window chat builds (16 Sep 2026)

Paste everything from RUN CONFIG down into a new chat.

---

## RUN CONFIG

- **Model: Claude Opus 5 (strongest). Thinking: high.**
- **Why:** these items touch AutoCAD behaviour and engineering values that reach issued drawings (CDLPD notes,
  CDDEST, CDFIXTAGS, CDTWL levels). A wrong level or a wrong note costs Tim a test cycle or a drawing.
- **Downgrade option:** Sonnet + medium only for reading records back and reporting state. Not for code.

---

## Step 0 — before anything

```bash
cd C:\CE_PLAN && git pull
```
Read `START_HERE.md`, then `01_MASTER_PLAN\TEST_DAY_RESULTS_2026-09-16.md` (sections 2 and 6a–6i). Then the
plugin `REGRESSION_LOG.md`, newest entries first. Verify the live bundle yourself:

```bash
powershell -NoProfile -Command "(Get-Item \"$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll\").VersionInfo.ProductVersion"
```

**Talk to Tim the way `~/.claude/rules/common/collaboration.md` says:** answer first, plain English with a
real-world example, dot points, every reply split into `▶ FOR TIM` then `▽ WORKING NOTES`. Built / tested /
installed / Tim-accepted are four separate facts.

## Where to work

- Repo: `C:\Lisp Files\CE_ACAD_PLUGIN`. **Make your own worktree** off the window chat's trunk:
  ```bash
  cd "C:\Lisp Files\CE_ACAD_PLUGIN"
  git fetch origin
  git worktree add .claude/worktrees/civil-other-areas -b claude/civil-other-areas-2026-09-16 origin/claude/ce-civil-handoff-sept-16-5623ca
  ```
  Then work ONLY inside `.claude/worktrees/civil-other-areas`. Never build or test in another worktree.
- Every build and test: `-p:SkipDevBundle=true -nr:false --disable-build-servers` plus
  `-p:_AcadRef48="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2024-ref" -p:_AcadRefNet8="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"`.
- **Tests only run with AutoCAD 2027 on PATH.** Without it `dotnet test` discovers ZERO tests and exits 0 — that
  is not a pass. Always quote the executed count:
  ```bash
  PATH="/c/Program Files/Autodesk/AutoCAD 2027:$PATH" dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj -f net10.0-windows -c Debug -p:SkipDevBundle=true -nr:false --disable-build-servers ...
  ```
  Baseline on the trunk: 23 known failures (names in the window chat's REGRESSION_LOG entries). New failures
  are yours; compare names, not counts.
- **Copy the native `.arx` outputs** the build wants:
  `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_*2027.{arx,pdb}` from
  `.claude/worktrees/autocad-ui-ux-design-dd0dcf` into the same path in your worktree (read the sibling, never
  edit it).

## Ownership — do not cross this line

**The window chat owns and is actively editing:** `Modules/Drainage/Dialogs/PipeOnePageLayout.cs`,
`PitOnePageLayout.cs`, `PitConnectionSelector.cs`, everything in `Modules/Drainage/Controls/` named
`Pit*Preview*`, `CdPlanPreviewControl`, `PlanAreaRenderer`, `PitConnectionStub*`, `PitCornerGuide`; the preview
parts of `Commands/PitEditCommand.cs` and `Commands/PipeEditCommand*.cs`; `ViewModels/CdViewModel*.cs` and
`PitViewModel*.cs`. **Do not touch them.** If an item needs a change there, write what you need in
`FLEET_STATUS.md` in your worktree and stop that item. Do not touch `Shared/CE_SHARED` without telling Tim first
(one assembly identity for every CE plugin; first loaded wins).

**Never deploy.** The window chat is the only deployer. When you are done, Tim brings your branch name and tip
back to the window chat and it merges and installs everything as one payload with one test list.

## What to do — Tim's order, ONE AREA AT A TIME, each finished and committed before the next

From `TEST_DAY_RESULTS_2026-09-16.md` section 2 (his exact words are there):

1. **L — `CDLPD`:** add the **Council Pit** connection option (L-01); use the note wording CE actually uses and
   place it as an **MLeader like the pipe callout** (L-02); never show an invert level that is not set (L-03).
2. **T — `CDFIXTAGS`:** it proposed 3 renames, was answered Yes, then said both "nothing to repair" and "3 renames
   were not made" while 1 changed (T-01). Make it do what it says, once, and say what it did.
3. **D — `CDDEST`:** "No downpipes were found" on a drawing full of DP labels (D-01). Find them.
4. **TWL — `CDTWL`:** offer the drawing's own criteria level (18.54 on his drawing, TWL-03); accept a typed level
   (TWL-04); CDCALC must store the required volume as a number, not `"0.0"` (TWL-05); stop dropping pits and
   pipes that plainly have levels (TWL-06). TWL-07 (window?) is a question for Tim — record, do not decide.
5. Only then, if time: **G — `CDDESIGN`** behaviour side: search every folder in the job (G-02) and find the council
   without asking (G-04). The window (G-03) is Codex's — publish a contract, do not build it.

For every item: failing test → fix → passing test → `REGRESSION_LOG.md` entry with **exact AutoCAD steps Tim
can follow** → commit → push. Synthetic fixtures only (DATA-01: no client names or addresses anywhere).
Record any decision Tim makes in `C:\CE_PLAN` in his words, in quotes, the moment he makes it.

## Parking lot (already captured, not yours unless Tim says)

- PIT window: tick on/off instead of Set; drop-down for pit sizes; sump-pit bottom IL tick — window chat.
- BUG-159 grip fix — the BUG-159 chat (Tim's test answer was YES, recorded in its handover doc).
- Computations sheet BUG-158 / F1-01..05 — not started by anyone; ask Tim before taking it.

## When you finish (or at 85% context)

Write `FLEET_STATUS.md` in your worktree with three lists — **built / untested / parked** — plus branch and tip,
and tell Tim: "Send this to the window chat: branch `claude/civil-other-areas-2026-09-16`, tip `<sha>`."
