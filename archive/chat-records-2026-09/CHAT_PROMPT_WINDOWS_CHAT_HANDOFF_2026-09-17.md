# Handoff — the CE Civil windows / deploy chat (written 17 September 2026, morning)

Paste everything from **RUN CONFIG** down into a new chat.

---

## RUN CONFIG

- **Model: Claude Opus 5 (strongest). Thinking: high.**
- **Why:** this chat owns the CD and PIT windows Tim uses 30× a day, the CDWT window, the computations sheet that
  goes to councils, and it is the ONLY chat that deploys the Civil bundle. A wrong deploy invalidates everyone's
  testing; a wrong level reaches an issued drawing.
- **Downgrade option:** Sonnet + medium only for reading records back. Never for a deploy, a merge, or anything
  touching `Autodesk.*`.

---

## How to talk to Tim (this travels with every handoff — do not change it)

Tim is a civil/structural engineer, not a coder, a visual learner, fast-moving. Follow
`~/.claude/rules/common/collaboration.md` exactly: answer first; plain English with a real-world example; dot points;
every reply split into `▶ FOR TIM` (complete on its own) then a line then `▽ WORKING NOTES`. **Built · Tested ·
Installed · Tim-accepted are four separate facts** — never a percentage. Look at the real thing (open the PDF, render
the window, read the DLL). Own mistakes out loud, first. One task at a time; the AI keeps the parking lot. Record
every decision Tim makes in `C:\CE_PLAN` in his words, in quotes, the moment he makes it.

## Step 0 — before anything

```bash
cd C:\CE_PLAN && git pull
```
Read `START_HERE.md`; then `01_MASTER_PLAN\TEST_DAY_RESULTS_2026-09-16.md` **sections 2 and 6a–6p** (Tim's rulings
of 16 Sep, in his words); then `01_MASTER_PLAN\MORNING_PACK_WINDOWS_2026-09-17.md`; then `PENDING_TESTS.md` rows
L1–L18. Then the plugin `REGRESSION_LOG.md`, newest entries first (LAYOUT-01 down to CD-TICKS-01 are this chat's).

**Verify the live bundle yourself** (PowerShell):
```powershell
$p = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll'; (Get-Item $p).VersionInfo.ProductVersion
```
At handoff it read `3.0.0+6505fb5a…`. If it does not, someone deployed — read issue #78 before touching anything.

## Where things stand

| | |
|---|---|
| **Worktree** | `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\autocad-ui-ux-design-dd0dcf` — work ONLY here |
| **Branch / tip** | `claude/ce-civil-handoff-sept-16-5623ca` @ `17847985`, pushed |
| **Live and installed** | `6505fb5a` (deployed 16 Sep 16:06 by this chat; backup `CE_CVL_SUITE_PRE_0737efa3_20260916_160353.backup`) |
| **On the branch, NOT installed** | LAYOUT-01 · PIT-PREVIEW-01/02 · CD-PREVIEW-01/01a · PIT-CONN-01 · POLISH-01 · PIT-TYPE-01 · CLICK-01 · DRAG-01 · PERF-003 (merged from the lag chat) · BUG-159 `CDGRIPDIAG` (merged) · DRYRUN-01 · PIT-TWEAKS-01 · CDWT-W01 · BUG-158/F1 · CD-TICKS-01 |
| **Full suite** | net10: 9,810 run / 9,771 passed / **22 failed** (known names, listed in REGRESSION_LOG PERF-003 merge note; one of the old 23 now passes) / 17 skipped. net48, net8, net10 builds 0 errors. |

**Done (built + unit-tested, pictures/PDF opened):** everything in the table above.
**Half-done:** nothing. **Untested in AutoCAD:** everything above except what Tim saw on `6505fb5a` (LAYOUT-01
proportions, PIT-PREVIEW-02 real plan, CD-PREVIEW-01 real plan — he saw those and said the PIT looked great).

## Root causes already found — do not re-hunt

- **W-01 (CDWT window missing):** `WaterTankDialog.OnPositionChanged` fired during `InitializeComponent` and
  dereferenced a radio that did not exist yet; CDWT caught it as "window could not be opened" and fell back to the
  command line. Plus `PromptMode` ran before the window. Both fixed (CDWT-W01).
- **CHARGED pipe in the pit list (PIT-TYPE-01):** the window stored a charged-destination name on every pipe; the pit
  reader let it outrank the drawing's own type. Fixed both ends via `PipeRecordTypeResolver`.
- **"No connected pipes" (PIT-CONN-01):** the pit trusted only the record's From/To names; now truth → record →
  geometry, plus drawing-only pipes.
- **Computations sheet (BUG-158):** sheet blocks poured into Notes; generic cover always first; logo looked for on
  disk while it ships as a WPF resource under `Resources\Branding\`. Fixed.
- **PERF-003's claims:** "zero tests discovered" was the PATH trap (AutoCAD 2027 must be on PATH); "no behaviour
  change" is false by one test — a refused xref check now waits ≤5 s. Recorded in its log entry.

## Your standing jobs

1. **You are the only deployer.** Only when Tim says **"AutoCAD is closed, deploy"** in YOUR conversation. Check
   `acad.exe` yourself. Back up the live bundle first (the script does not) and tell Tim the folder name. Build with
   `Installer\build_installer.ps1`, deploy with `Installer\Deploy-Local-AsAdmin.ps1` **in a normal shell (not
   elevated)**, then read the installed DLL version back. **PERF-003 changes CE_SHARED:** Civil is the only bundle
   you install, so say plainly that the Structural half is not live and Manager's CE_SHARED copy must be brought
   into step by hand (one assembly identity 1.1.0.0, first loaded wins). Record on issue #78.
2. **Merge the other overnight chats before deploying:** the C7/PLACE-01 chat and the K/L chat each hand Tim a branch
   and tip. Verify their claims yourself (ancestry, conflicts, executed test counts, failure NAMES). Two pending
   payloads must be combined and installed once.
3. **Hold the gate.** After the deploy, give Tim the ONE combined test list (PENDING_TESTS L1–L18 + theirs) and do
   not start new work until he has tested. Test 4 in the morning pack (dry-run preview: Cancel then `U`) decides
   whether DRYRUN-01 stays; if it undoes more than the previous real edit, remove the two `vm.DryRunPreview = …`
   lines in `PitEditCommand` / `PipeEditCommand`.

## Ownership fences (ruling B, with Tim's 16 Sep overrides)

- **Yours:** `Dialogs/PipeOnePageLayout.cs`, `PitOnePageLayout.cs`, `PitConnectionSelector.cs`; `Controls/*Preview*`,
  `PlanAreaRenderer`, `PitConnectionStub*`, `PitCornerGuide`; `ViewModels/CdViewModel*`, `PitViewModel*`; the preview
  parts of `Commands/PitEditCommand.cs` / `PipeEditCommand*.cs`; **all of CDWT**; the computations sheet files
  (`Rules/ComputationsSheetV3.cs`, `Services/CalculationExportPackage.cs`, `CalculationsV2ViewModel` export part);
  polish of the CD/PIT windows (Tim: "YOU DO THE POLISH YOURSELF").
- **Not yours:** `CdCommand*`, `LinkService*`, NativeObjects, `PipeTruthResolverService*`, PLACE-01 (C7 chat);
  `LpdCommand`, `LpdService`, `PitAnnotationShift`, `PitEditCommand.Resize`, detention totals, propagation (K/L chat);
  the CDDESIGN window (Codex); BUG-159 fix (its own chat). `Shared/CE_SHARED`: tell Tim before touching.

## Build and test — the traps

- Every build/test: `-p:SkipDevBundle=true -nr:false --disable-build-servers` +
  `-p:_AcadRef48="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2024-ref" -p:_AcadRefNet8="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"`.
- Tests need `PATH="/c/Program Files/Autodesk/AutoCAD 2027:$PATH"` or NUnit finds ZERO tests and exits 0. Quote
  executed counts; compare failure names, not counts.
- The test fixtures render PNGs beside the test DLL (`cd-one-page-100.png`, `pit-one-page-100.png`,
  `cdwt-window.png`, `computations-sheet-page1.png`…). **Open them.**
- Long python heredocs in bash mangle backslashes and quotes — write a `.py` into the scratchpad and run it.
- Never edit while `dotnet test` runs in the same worktree; never build in another chat's worktree.

## Parking lot / next work (Tim asked "what would you work on next"; not started)

1. Finish CDWT: Base RL in the window, real plan-block pictures from the PLANS master, tank details from the Civil
   Standard Details folder (13 Sep ruling), adopted block keeps typed values.
2. A "show me" command that opens each CE window on a test drawing and saves real AutoCAD screenshots.
3. Leftovers: header fit at 125/150%, dry-run for a New Pit, rainfall warning shown twice on the sheet.

## Open questions only Tim can answer (do not decide them)

- Is **"Sump pit · own bottom IL"** what he meant by the sump tick? (PIT-TWEAKS-01)
- Does the **dry-run leave an Undo step**? (his test 4)
- Rainfall warning twice on the sheet — keep or once?
- Which lanes Structural should ship, and whether one joint release script or two (STRUCTURAL_PACKAGING_DIAGNOSIS).

## Rules actually broken recently (by others) — so you check, not trust

- Another chat claimed "zero tests discovered, pre-existing" — it was PATH. Another claimed "no behaviour change" —
  a test disagreed. Two earlier chats set a flag in a file the plugin does not read. A "new script with a sync" was
  byte-identical to the old one. **Verify, then act; say plainly when a claim is wrong.**
