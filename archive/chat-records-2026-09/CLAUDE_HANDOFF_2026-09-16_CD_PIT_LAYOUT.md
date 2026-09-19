# CE Civil — handoff, 16 September 2026 (midday)

Paste everything from **RUN CONFIG** down into a new chat.

---

## RUN CONFIG

- **Model: Opus 5 (strongest). Thinking: high.**
- **Why:** this touches a window Tim uses 30× a day, `Autodesk.*` behaviour, and engineering values that reach
  issued drawings. A layout that looks fine in a screenshot but hides a control costs him a whole test cycle.
- **Downgrade option:** pure layout arithmetic in `PipeOnePageLayout.cs` / `PitOnePageLayout.cs` can be
  **Sonnet + medium**. Anything touching a command, a service, the save path or a number on a sheet stays
  Opus + high.

---

## Step 0 — do these before anything else

```bash
cd C:\CE_PLAN && git pull
```

1. Read **`START_HERE.md`**, then **`01_MASTER_PLAN\TEST_DAY_RESULTS_2026-09-16.md`** — that is the
   authoritative record of what Tim found and what is still broken. **It outranks any optimistic claim in
   `DEPLOY_AND_TEST_2026-09-16.md`, which is marked superseded.**
2. **Verify the live bundle yourself. Do not trust this document.**
   ```bash
   powershell -NoProfile -Command "(Get-Item \"$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll\").VersionInfo.ProductVersion"
   ```
3. Read `REGRESSION_LOG.md` in the worktree, newest entries first.
4. **Refer back to the plan constantly, not once.** Before each piece of work, say which item it is.

---

## Where things stand

| | |
|---|---|
| **Worktree** | `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\ce-civil-handoff-75-percent-671a19` |
| **Branch** | `claude/ce-civil-handoff-75-percent-671a19` |
| **Tip** | `5399ba14` — live `0737efa3` **+ one docs-only commit** |
| **LIVE and installed** | **`0737efa3`** · Modern `066FE6C3…` · Net8 `77DF522E…` · Legacy `2235873F…` |
| **Full suite (net10)** | 9709 executed / 9669 passed / **23 failed** / 17 skipped |
| **Builds** | net48, net8.0-windows, net10.0-windows — 0 errors |

**Everything approved is already installed.** `e09bb0d1` (CD/PIT), `170facae` (Codex window fixes),
`a4137569` (PERF) and the CDWT tank window are all ancestors of live. **There is nothing outstanding to
combine, and no reason to redeploy** unless you change code.

### The CD/PIT windows ARE now active

`editors.workshopLayout` is **true** in the file the plugin really reads:

```
%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json
editorShell.flags["editors.workshopLayout"] = true
```

**Rollback:** set `flags` back to `{}` — **do not delete `editorShell`**, it existed before. Backup:
`CD_Settings.json.PRE_WORKSHOP_20260916_121735.bak`.

> ⚠️ **Two chats got this wrong by writing to `%APPDATA%\CE_CVL_SUITE\settings.json`**, which the plugin does
> **not** read (`SettingsService.cs:50-55`). If you ever touch this flag, read it back **from the
> TIM_CE_CADTOOLS path** and show the value.

### Running the tests

**AutoCAD 2027 must be on PATH**, or `dotnet test` reports "no test is available" and runs nothing — a harness
condition, not a pass. Always check the discovered count.

```bash
PATH="/c/Program Files/Autodesk/AutoCAD 2027:$PATH" dotnet test Modules/Drainage.Tests/CE_CVL_SUITE.Tests.csproj \
  -f net10.0-windows -c Debug -p:SkipDevBundle=true -nr:false --disable-build-servers
```

Builds need the explicit reference paths from a worktree:
`-p:_AcadRef48="C:\Lisp Files\CE_STRUC_SUITE\lib\autocad-2024-ref" -p:_AcadRefNet8="…\autocad-2026-ref" -p:_AcadRefNet10="C:\Program Files\Autodesk\AutoCAD 2027"`

**On the 23 failures:** five of them (`AddSystemCommand_Execute_*`, `BoydsDetentionRequired_Changed_…`,
`PreviewPackage_AllSections_…`) throw `InvalidProgramException` at `Application.get_DocumentManager()`. That is
a **harness artefact** of the test csproj copying reference assemblies (which have no method bodies), not a
code defect, and the csproj does not ship. **Do not "fix" them by weakening anything.**

---

## JOB 1 — the CD and PIT windows waste most of the screen

**This is the priority.** Tim, seeing both: *"IT OPENS BUT LOOKS HORRIBLE AND WASTES SO MUCH SCREEN REAL
ESTATE"* and *"SAME THING WITH PIT"*.

The windows now open in the right **shape** — Engineering left, Drafting right, plan preview underneath — but
the content occupies the top ~350 px and the preview strip at the bottom, leaving **roughly 700 px of dead
black space** in the middle on a wide monitor.

### Where it actually is — this was measured, do not re-hunt it

**Not the tabbed XAML.** `PipeEditWorkshopDialog.xaml` declares five tabs (Pipe / Levels & Flow /
Connections / Drawing / Schedule & Preferences) and is **not** what Tim is seeing.

The one-page Engineering/Drafting layout is **built in C#**:

| File | Lines |
|---|---|
| `Modules/Drainage/Dialogs/PipeOnePageLayout.cs` | 284 |
| `Modules/Drainage/Dialogs/PitOnePageLayout.cs` | 318 |

Relevant points in `PipeOnePageLayout.cs`:

- **lines 130-131** — `Body` gets two plain `ColumnDefinition()`s (Engineering | Drafting), equal width.
- **line 158** — the preview is a `GroupBox { Header = "PLAN PREVIEW", MinHeight = 150 }`.
- **line 180-181** — the diagram is pinned to `Height = 108` with 36-px rows.

The window is sized to roughly 90% of the AutoCAD window, but **nothing in the body stretches**, so all the
slack collects as empty space between the top content and the bottom preview.

### What Tim wants

- **CD:** Engineering left, Drafting right, **wide horizontal preview underneath**.
- **PIT:** Engineering left, **large centre preview**, Drafting right.
- Roughly **90% of the AutoCAD window**, **main actions always visible**.
- **No scrolling** — CE windows do not scroll; everything visible on open (standing rule).
- `More…` must **preserve typed entries** through Back/reopen.

### Suggested direction (not a decision — check with Tim)

The honest fix is to make the slack go somewhere useful rather than nowhere: let the **preview row take the
star height** so it grows with the window, instead of a fixed `MinHeight`/`Height`. On PIT the preview is meant
to be a **large centre column**, so it should be the growing column, not a bottom strip.

**Do not** solve it by shrinking the window to the content — Tim asked for ~90% of the AutoCAD window.

### An open design question you must put to Tim, not decide

On **2 September 2026** Tim approved **three slim text tabs per editor** —
`Pipe / Levels & Connections / Drawing & Schedule` — plus *"D5: no miniature pipe schematic"*, Save and Close
on every tab, and the repeat-use premise (quiet healthy screens, issues expand).

What shipped is a **one-page Engineering/Drafting layout with no tabs**, and `PipeEditWorkshopDialog.xaml`
separately carries **five** differently-named tabs. **Ask him which he wants before restyling anything** —
one-page as now (just proportioned properly), or the approved three tabs.

*(An earlier chat told Tim the shipped CD window "contradicts your approved design" after reading
`CdDialog.xaml`. That was the **old fallback** window, shown because activation had failed. The criticism was
aimed at the wrong file — do not repeat it.)*

### Guards you must not break while doing this

1. **`PreviewAvailable` / `CanShowReadOnlyPlanPreview` must stay separate from preset permission**
   (`Available` / `CanUseDrawingPresets` / `PresetLimitation`). Showing a preview must never enable a
   greyed-out preset.
2. **Exactly two `TryUpdatePipeAttachmentDisplay` call sites** — no second save, no second Undo.
3. **`PitEditCommand`: `TryMovePitAnnotation` OR `ShiftAnnotation`, never both.** Keep the **five-argument**
   `ShiftAnnotation` with its BUG-151 `[what]` diagnostic and **both** `SetAttribute` refusal checks.
4. **The fit fallback is an engineering protection — do not bypass it.** If a workshop window does not fit the
   work area, `DialogService` deliberately opens the shipped window and says so on the command line
   (*"The tabbed editor does not fit this AutoCAD work area at the current display scaling"*). If Tim sees
   that line, fix the sizing, do not remove the guard.

---

## JOB 2 — the computations sheet is unusable (BUG-158 / F1-01..05)

Tim: *"THE REPORT IS MESSY, NOT FORMATTED IN ORDER, DOESNT HAVE CE BRANDING AND HONESTLY A MASSIVE
DISAPPOINTMENT, NOT ACCEPTABLE."*

Root cause, already diagnosed: the V3 sheet's text was pushed into the export section's **`Notes`** collection,
and the PDF writer renders every note as `Note: <text>`. **So the entire sheet — the CREATIVE ENGINEERING
header, the basis of design, every figure — prints as a list of lines beginning `Note:`.** Page 1 is also still
the old blank "CALCULATIONS PACKAGE" cover.

**The lesson that caused it, stated so it is not repeated:** the sheet had **27 green unit tests** asserting on
`ComputationsSheetV3.ToPlainText`, and **nobody ever opened the PDF**. A test that cannot fail the way the user
experiences the thing is not coverage. **Open the actual PDF before claiming this fixed.**

Relevant: `Rules/ComputationsSheetV3.cs`, `Rules/ComputationsRecord.cs`,
`Services/ComputationsRecordBuilder.cs`, `Services/CalculationExportPackage.cs`.

---

## JOB 3 — the rest of Test Day, in Tim's priority order

He said: **ONE AREA AT A TIME**, priorities **CDWT → CD → PIT**, then sections **H, I, J, K, L**, then **M**.
Full detail and his exact words are in `TEST_DAY_RESULTS_2026-09-16.md`. Summary:

| Ref | What |
|---|---|
| **P-01..P-08** | Split asks at the wrong time; invert levels land wrong; multi-vertex pipes unhandled; **each segment between pits needs its own pipe text**; CDPIPEOBJ style lost on split; changing an invert does nothing and cannot be re-edited; pit label on resize does not move existing pipe connections |
| **C7-01..03** | Converted pipes lose compounding with pipe text / invert text / arrows; `CDFW` fails on them |
| **L-01..03** | `CDLPD` has no **Council Pit** option; wrong note text; should use an **MLeader like the pipe callout**; still shows the invert level when it should not |
| **T-01** | `CDFIXTAGS` contradicts itself — proposes 3 renames, answered Yes, then says both "nothing to repair" and "3 renames were not made"; only 1 changed |
| **D-01** | `CDDEST` says "No downpipes were found" on a drawing full of DP labels |
| **G-01..04** | `CDDESIGN` searches one folder — must search **every folder in the job**; must become a WPF window; *"I WILL ONLY TEST WHEN YOUR PROGRAM CAN FIND AND INPUT DATA WITHOUT ME"* |
| **TWL-03..07** | Offers 18.75 / 18.05 when the drawing's own criteria block says **18.54**; refuses a typed level; drops 8 pits and 18 pipes as "invert not set" on a drawing that has levels |
| **R-01/R-02** | Ribbon icons render in the wrong place; toolbar icons need the same treatment |
| **W-01** | CDWT window built but **never opened in AutoCAD by anyone** |

---

## Open questions only Tim can answer — do not decide these

1. **CD/PIT layout:** one-page as now (proportioned properly), or the **three approved tabs** from 2 Sep?
2. **Where do new IFD rainfall coefficient blocks come from?** How CE fitted the seven coefficients is not
   recorded anywhere CE still has. **No fitting method has been invented, and none should be.**
3. **Structural packaging** — which lanes should it ship, and one joint release script or two with a commit
   check? Structural references `CE_SHARED` and ships **no copy**, so it borrows Civil's. **No script has been
   written; that needs his approval.** See `STRUCTURAL_PACKAGING_DIAGNOSIS_2026-09-15.md`.
4. **Q-GRIP-1** — pipe end grip dragged off its pit: leave it, or ask?
5. **Two unreadable tank block names** — `A$C1cba1a13`, `A$C72c6940a`.

---

## Standing rules that have actually been broken recently — read these

- **Only ONE session may deploy**, and only when Tim says **"AutoCAD is closed, deploy"** *in that
  conversation*. Check `acad.exe` yourself; it has twice been mid-shutdown and still running.
- **Two pending payloads must be MERGED, not deployed one after the other.** The bundle is replaced wholesale,
  so the second overwrites the first.
- **CE_SHARED is one assembly identity (1.1.0.0) and first-loaded-wins across all CE plugins.** **No `.ps1` in
  the repo syncs it** — when it genuinely changes, Manager's copy must be upgraded by hand or Civil's new
  method throws `MissingMethodException` into a `try/catch` and the feature silently does nothing. This
  happened on 16 Sep; Manager's copies were upgraded manually and backed up as `*.PRE_SYNC_*.bak`.
- **Never build or test in another session's worktree.** Never edit source or start a second build in the same
  worktree while `dotnet test` is running there — they share `obj/` and the run then tests a tree that never
  existed.
- **Built / tested / installed / Tim-accepted are four separate facts.** Never merge them into a percentage.
- **Verify claims before acting on them.** In the last day: a "new deploy script with a CE_SHARED sync" turned
  out byte-identical to the existing one; an activation "verified correct" had been read from the wrong file;
  and "those 23 also fail on live" was untrue for five of them. **Check, then act.**
- Every change: a `REGRESSION_LOG.md` entry, synthetic fixtures only (**DATA-01**), and the moment Tim decides
  something, commit it to `C:\CE_PLAN` **in his own words, in quotes**.
