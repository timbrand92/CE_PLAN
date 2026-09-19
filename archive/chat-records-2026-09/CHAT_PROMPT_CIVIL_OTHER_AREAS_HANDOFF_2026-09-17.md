# Handoff prompt — "other Civil areas" chat, continued in a fresh chat (17 Sep 2026)

Paste everything from RUN CONFIG down into a new chat.

---

## RUN CONFIG

- **Model: Claude Opus 5 (strongest). Thinking: high.**
- **Why:** this lane owns the CE pipe object (native C++ enabler + managed seam), label placement and the split-on-draw
  behaviour — all of it reaches issued drawings, and one wrong assumption about AutoCAD internals costs Tim a test day.
- **Downgrade option:** Sonnet + medium only for reading records and reporting state. Never for code on this lane.

---

## Step 0 — before anything

```bash
cd C:\CE_PLAN && git pull
```
Read `START_HERE.md`, then `01_MASTER_PLAN\TEST_DAY_RESULTS_2026-09-16.md` **§2 and §6a–6o** (6j–6o are the newest
rulings and the overnight result), then `01_MASTER_PLAN\MORNING_PACK_C7_2026-09-17.md`, then the plugin
`REGRESSION_LOG.md` entries **C7-POLY, IDENT-01, PLACE-01, C7-2024** (top of the file). Verify the live bundle yourself
(PowerShell, not bash):

```powershell
$p = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll'; (Get-Item $p).VersionInfo.ProductVersion
```
At handoff it read `3.0.0+6505fb5a…` (installed 16 Sep 16:06). If it differs, the window chat has deployed — read
GitHub issue #78 before claiming anything.

**Talk to Tim the way `~/.claude/rules/common/collaboration.md` says:** answer first, plain English with a real-world
example, dot points, every reply split into `▶ FOR TIM` then `▽ WORKING NOTES`. Built / tested / installed /
Tim-accepted are four separate facts. Tell Tim in one short message what you are about to work on before writing code.

## Where to work — reuse the existing worktree and branch

```bash
cd "C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\civil-other-areas-2026-09-16-1c1ae6"
git status --short          # must be clean
git log --oneline -1        # 812f868f (or later) on claude/civil-other-areas-2026-09-16-1c1ae6
git fetch origin && git status -sb
```
Do NOT cut a new worktree from `master` (it is docs-only, 1,100+ commits behind the code). If Tim wants a fresh
branch, cut it from **this branch's tip**, not from the trunk, or the overnight work is lost.

- Every build and test: `-p:SkipDevBundle=true -nr:false --disable-build-servers` plus
  `-p:_AcadRef48="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2024-ref" -p:_AcadRefNet8="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"`.
- Tests only run with AutoCAD 2027 on PATH (`PATH="/c/Program Files/Autodesk/AutoCAD 2027:$PATH"`); zero tests
  discovered is NOT a pass. **Baseline on this branch: 9812 run / 23 failed / 17 skipped** — the same 23 named trunk
  failures (list them from the trx before comparing; compare names, not counts).
- Native enabler: build Release and SelfTest flavours and run the self-test headless with the script pattern in
  `C:\Autodesk\CERef\C7-POLY-REBUILD-20260916` (`build-enabler.ps1` lived in the old chat's scratchpad — recreate it
  from the REGRESSION_LOG C7-POLY entry: msbuild via vswhere, `/p:SelfTest=true`, accoreconsole `/isolate`, env
  `CEC7_PROBE_OUT` / `CEC7_PROBE_DIR`). Never run accoreconsole while acad.exe is open.
- The `.arx` outputs the build wants: `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_*2027.{arx,pdb}`
  are already in this worktree.

## What is true right now (do not re-derive)

- **The CE pipe object is an `AcDbPolyline` subclass** (`CeCvlPipeObject`, DXF `CE_CVL_PIPE_OBJECT`, API 4). To every
  managed tool it IS a `Polyline` with its real handle and dictionary. **Never reintroduce a stand-in/proxy path for
  it**; the proxy code that remains is for the 16 Sep-morning legacy `CeCvlPipe` only, which `MigrateLegacyPipe`
  swaps in place. `PipeGeometrySeam.IsPipeObject` requires `obj is Polyline`.
- CE-only values (width, number, twin) are written through `CeCvlObjects_SetDataOnOpenObject` with the object the
  transaction already holds open — AutoCAD refuses a second open by handle inside a transaction.
- Upgrade runs on open (`PipeObjectUpgradeOnOpenService`, first Idle, one `_PRE_C7_` backup the first time, one
  line), on draw (`PipeCreationService` → `TryUpgradeNewPipe`), on demand (`CDC7UPGRADE`). Twins convert (root
  becomes a twin object; barrels/MLINEs erased). A pipe object never gets a paired MLINE or twin children
  (`UpdatePipeMline`, `RegisterPipe`, `ConfigureDetentionTwinPipeVisual`, split paths all stop for it).
- IDENT-01: `RegisterPipe` gives a pipe its `SPINE_ID` (`LinkService.NewPipeIdentity.cs`); `AddPipe` copies it to the
  row; the open-a-job upgrade checks every tracked pipe.
- PLACE-01: `Rules/LabelPlacementRule.cs` is the ONE placement rule; the tidy-up runtime asks it for spots; obstacles
  are text, blocks (pits by footprint), and other CE pipes as segments; callout TEXT moves, anchor stays. Runs at
  routes `draw`, `atomic-*` / `established*` (move/grip), `pit-boundary`, `split`. Settings: LABEL PLACEMENT group.
- 2024 enabler: `Modules/Drainage.NativeObjects2024/CE_CVL_OBJECTS_2024.vcxproj` builds (v142 + ObjectARX 2024),
  **never loaded, not staged, net48 bridge still names the 2027 module**.

## Done / half-done / untested

- **Done (built, unit-tested, pushed):** everything in the morning pack table (rows 1–9).
- **Half-done:** 2024 enabler (built only). Pits' identity on draw (not started — Tim's call).
- **Untested in AutoCAD:** ALL of it. Rows O1–O15 in `C:\CE_PLAN\PENDING_TESTS.md`. Nothing is accepted.

## Root causes already found — do not re-hunt

- C7-01/03: the object was an `AcDbCurve`; 252 sites say "a pipe is a polyline"; the stand-in had no handle so
  writes were silently lost. Fixed by construction (rebuild).
- IDENT refusal on fresh pipes: only `CDSPINEUPGRADE` ever wrote a pipe's `SPINE_ID`; `CD` never did.
- The self-test lied twice because C++ evaluates the parts of one line in unspecified order — call first, log after.

## Ownership — do not cross

- **Window chat** (`claude/ce-civil-handoff-sept-16-5623ca`): `PipeOnePageLayout`, `PitOnePageLayout`,
  `PitConnectionSelector`, `Controls/Pit*Preview*`, `CdPlanPreviewControl`, `PlanAreaRenderer`, `PitConnectionStub*`,
  `PitCornerGuide`, preview parts of `PitEditCommand.cs` / `PipeEditCommand*.cs`, `CdViewModel*`, `PitViewModel*`,
  **all of CDWT**, and every deploy.
- **K/L chat** (`claude/civil-k-l-2026-09-16`, prompt `C:\CE_PLAN\01_MASTER_PLAN\CHAT_PROMPT_CIVIL_K_L_2026-09-16.md`):
  `LpdCommand`, `LpdService`, `PitAnnotationShift`, `PitEditCommand.Resize.cs`, `DetentionBranchCollector`,
  `StormReport`, `PropagationPlan`, `RepairAudit.InvertPropagation/Apply/Relink`. Read its morning pack
  (`MORNING_PACK_K_L_2026-09-17.md`) before touching anything near those files.
- **BUG-159 chat:** the pipe grip guard.
- **This chat owns:** `Modules/Drainage.NativeObjects2027/*`, `NativeObjects2024/*`, `Services/NativeObjects/*`, every
  `LinkService.*` partial not listed above, `Rules/LabelPlacementRule.cs`, `Rules/TextClashTidyUp*`,
  `Commands/NativePipeObjectCommands.cs`, `Commands/CdCommand*.cs`, `Commands/SourceTagRepairCommand.cs`,
  `Commands/LinkCommands.cs`, `PipeCreationService.cs`, `SourcePlacementService.cs`, `PipeOverruleService.cs`.
- Never touch `Shared/CE_SHARED` without telling Tim. **Never deploy.**

## Next block (Tim's order — confirm with him before starting)

1. **H — `CDFIXTAGS` (T-01):** it proposed 3 renames, was answered Yes, said both "nothing to repair" and "3 renames
   were not made", and changed 1. Make it do what it says, once, and say what it did. Files:
   `Commands/SourceTagRepairCommand.cs`, `Rules/DuplicateSourceTagPolicy.cs`, `Rules/SourceFamilies.cs`.
2. **I — split on draw (P-01..P-05):** asks at the wrong time (after the CD window), inverts land wrong after a split,
   a pipe with more than one bend breaks it, each segment between pits needs its own pipe text, split pipes must come
   back as pipe objects (they now do via the clone path — verify). Files: `CdCommand*.cs`, `LinkService.Split.cs`,
   `SourcePlacementService.cs`. Steps 52–56 of the 16 Sep list are the acceptance.
3. **P-07 — changing an invert does nothing / double-click will not edit it:** behaviour side only (the window is the
   window chat's) — find why the invert write does not land and why the second edit is refused.
4. **Pits' identity on draw** (only if Tim says yes) and **PLACE-01 on open** (only if Tim says yes).
5. **2024 enabler staging** only after Tim has loaded it on a real AutoCAD 2024 (row O15).

For every item: failing test → fix → passing test → `REGRESSION_LOG.md` entry with exact AutoCAD steps → commit → push.
Synthetic fixtures only (DATA-01: Tim's job folder path names a client address — never paste it). Record any decision
Tim makes in `C:\CE_PLAN` in his words, in quotes, the moment he makes it. Add built items to `PENDING_TESTS.md`.

## Parking lot (captured, not yours unless Tim says)

- PIT window ticks / drop-downs / sump-pit IL — window chat. Computations sheet BUG-158 / F1 — nobody; ask first.
- `PipeEditCommand.Update.cs:517` still makes an MLINE per save; `RegisterPipe` removes it for a pipe object.
- The class app-name string inside the 2024 enabler is still `CE_CVL_OBJECTS_2027`.

## When you finish (or at 85% context)

Update `FLEET_STATUS.md` in the worktree (built / untested / parked + branch and tip) and tell Tim:
"Send this to the window chat: branch `claude/civil-other-areas-2026-09-16-1c1ae6`, tip `<sha>`."
