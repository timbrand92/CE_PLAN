# CE Civil — test run for Codex, 17 September 2026

**This is the ONE list.** It covers everything installed in the combined payload from the three overnight
Claude chats. Work top to bottom. Tim's priority order (his ruling, 16 Sep): **CDWT, CD, PIT first**, then the
pipe object and labels, then CDLPD / pit-resize / tanks / propagation, then the computations sheet.

## What is installed

| | |
|---|---|
| Branch | `claude/civil-combined-2026-09-17` (merge of the windows chat, the C7/labels chat and the K/L chat) |
| Installed build | **`3.0.0+d0ffe1a281808c1837375785351581610dcc9c51`** — deployed 16 Sep 22:57, all three lanes read the same string |
| Previous build | `3.0.0+6505fb5a…` — backup at `%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE_PRE_6505fb5a_20260916_222407.backup` |
| Lane | **AutoCAD 2027 (net10 / Modern)** unless a row says 2024 |

## Rules for this run — please follow them exactly

1. **Work on COPIES of drawings.** Never the original. Several tests deliberately change the drawing.
2. **Record one of four words per step: PASS · FAIL · BLOCKED · NOT TESTED.** Never leave a step blank and
   never infer a result from another step.
3. **A step with no observation recorded is NOT TESTED**, even if it "obviously" works.
4. **Screenshot every window step and every step that says "looks like".** Name the file by the step ID.
5. **On a FAIL, capture:** what you did, what you expected, what happened, the exact command-line text, and
   the CE log lines from `%APPDATA%\CE_CVL_SUITE\logs\` for that minute.
6. **If AutoCAD crashes, say which step caused it and stop that section** — carry on with the next section.
7. **You are producing evidence, not acceptance.** Only Tim's word accepts anything.
8. **Do not fix anything.** Report it.

## Test drawings needed — Tim must name these

**The paths are NOT in this file on purpose** — they name real job folders, and client names and
addresses never go into a repository (DATA-01). They are in:

> **`C:\Users\TimothyBrand\CE_TEST_DRAWINGS_2026-09-17.md`**

That file lists candidates for DWG-A, DWG-B and DWG-E found from what was opened on 16 September, and
says plainly that **DWG-C (two tanks on one system)** and **DWG-D (twin-barrel pipe)** are **not
identified** — Tim must name those. Nothing in it has been opened or verified; Tim confirms first.

**Work on COPIES**, in a scratch folder, not in the job folders.

If a drawing is not supplied, mark its steps **BLOCKED — no drawing**, not FAIL.

---

# PART S — start up (do these first, they gate everything)

| ID | Step | What "right" looks like |
|---|---|---|
| **S1** | Read the installed version. In PowerShell: `(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion` | Record the full string in your report. It must NOT be `3.0.0+6505fb5a…` — that is the old build. |
| **S2** | Start AutoCAD 2027. Open DWG-A (a copy). | The CE ribbon tab appears. No error dialog, no "unable to load" on the command line. |
| **S3** | Type `CDINSPECTOR`. | It runs and reports. If any command is "unknown command", stop — the plugin has not loaded, and every step below is BLOCKED. |

---

# PART W — CDWT, the water-tank window (Tim's first priority)

| ID | Step | What "right" looks like |
|---|---|---|
| **W1** | Type `CDWT`. | **The window appears immediately.** If the command line asks "Adopt or Insert" FIRST, this is a FAIL — copy the `[CE]` line from the command line into your report. |
| **W2** | Look at the list in the window. | "Above ground" is ticked; tanks listed **smallest first** with their dimensions. |
| **W3** | Tick "Underground". | The list changes to underground tanks. |
| **W4** | Pick a tank, set it as detention, pick a plan, press **Place tank**. | It asks for an insertion point with a ghost preview following the cursor, then asks about callout / riser / dropper, then Base RL. |
| **W5** | Press **"Tag a block already in the drawing"**. | The window closes and it asks you to pick the block. |
| **W6** | Run `CDWT` again and press **Cancel**. | Nothing is placed in the drawing. Nothing else is asked. |

---

# PART C — CD / the Edit Pipe window (second priority)

| ID | Step | What "right" looks like |
|---|---|---|
| **C1** | Double-click a stormwater pipe between two pits. | Window fills the space: Engineering left, Drafting right, **PLAN PREVIEW reaching from just under the fields to just above the buttons — no empty black band.** All five buttons visible. **Nothing scrolls.** |
| **C2** | Look at the PLAN PREVIEW. | It is the **actual plan along that pipe**, north up, both pits in view, sharp — not a schematic. |
| **C3** | Look at each end of the preview. | A gold ring with a caption "pit · IL" at each end. |
| **C4** | Type a new invert level. | The caption at that end changes **at once**. |
| **C5** | Look at the level row. | Two **tick boxes** (not "Set" buttons): "☐ Upstream 19.45 m AHD". Untick → the box greys. Tick → it opens. |
| **C6** | Save, reopen the pipe. | The ticks are as you left them. |
| **C7** | Click the **downstream gold ring** on the picture. | The cursor lands in the downstream level box with its value selected. |
| **C8** | Change the diameter and the pipe-text side. Wait one second. | The picture redraws: pipe text reads the **new size** on the **new side**, arrow where Save would put it. |
| **C9** | Type fast into a box. | **No flicker per keystroke** — one update after you pause. |
| **C10** | Open a **detention pipe with twin pipes turned on**, and a pipe with a linked IL label. | Nothing is pushed off the window. Type a value → **More…** → **Back**: the value is still there. |
| **C11** | Run `CD` and pick a route for a NEW pipe. | The window opens showing the **real plan along the points you picked**, with End 1 / End 2 captions. |
| **C12** | A pipe ending at an IO / DP / LPD. | The real symbol is drawn in the preview, not a generic blob. |
| **C13** | A pipe with 3 or more vertices. | The whole run is shown. |
| **C14** | Open DWG-E (xref underneath). | Report whether the xref shows in the preview. Either answer is information — just say which. |
| **C15** | Overall. | Opening the window must not feel slower than before. **If it does, say roughly by how much.** |

---

# PART P — PIT / the Edit Pit window (third priority)

| ID | Step | What "right" looks like |
|---|---|---|
| **P1** | Double-click a pit that has 2+ pipes. | Centre PLAN PREVIEW **clearly wider** than either side column. Both "Bottom right" position lists on the right fully readable, not cut off. Nothing scrolls. |
| **P2** | Look at the picture. | The **real plan** around the pit, north up, pit centred, about three pit-widths across, sharp. |
| **P3** | Look at the **Connected pipes** list. | Every connected pipe is listed, e.g. "P10 → P9 · Entering · IL 19.450". A pit with no pipes says so **once**, not twice. |
| **P4** | **The CHARGED bug.** Look at a plain stormwater pipe in that list. | It reads **Entering / Leaving** — **NOT "CHARGED"**. Save it unchanged, reopen the pit: still not charged. |
| **P5** | Open a pit that has a genuinely **charged** pipe. | That one still reads CHARGED. |
| **P6** | Look at each placed pipe on the picture. | A tag at the wall point reading "size · Entering/Leaving · IL". A pipe with no level reads "IL Unknown" — never a zero. |
| **P7** | Pick a different pipe in the list. | Its tag on the picture goes **gold**. |
| **P8** | Click a pipe **tag on the picture**. | The list selection follows it and the tag goes gold. |
| **P9** | A pipe CE cannot place. | Listed top-left as "Not placed: … – reason", with no tag. |
| **P10** | **Plan size.** Open the size box. | It is a **drop-down** of the ladder: 450 / 600 / 900 / 1200 / 1500. Pick 900 → the picture redraws. |
| **P11** | Type **700** into the size box. | Accepted (a typed size is allowed, the drop-down is a convenience). |
| **P12** | **Dry run.** Change 450 → 1200 and wait one second. | The picture shows a **bigger pit** and the label **stepped out**. |
| **P13** | **THE CRITICAL ONE.** Now press **Cancel**, then type `U` once. | **Only your previous real edit undoes.** If anything else changes, **STOP, screenshot, and report immediately** — Claude removes the dry-run before Tim uses it. |
| **P14** | Change the label corner in the list. | The label moves in the picture. |
| **P15** | **Drag** the gold corner badge to the top-left of the picture and release. | The badge sits top-left and the **Pit label** corner list reads "Top left". The **cover-text** list is unchanged. |
| **P16** | Pick "Cover text" in the footer list, drag the badge to top-right. | **Only** the cover-text corner changes. |
| **P17** | Press Cancel after a drag. | **Nothing moved on the drawing.** |
| **P18** | **Sump tick.** Look at the bottom row. | A tick reading "**Sump pit · own bottom IL**". Unticked = grey box. Ticked = the box opens. Save, reopen: kept. **Tim must confirm this is what he meant.** |
| **P19** | Blank the pit size entirely. | The picture falls back to the plan as it is. **No error dialog.** |
| **P20** | Run `CDPIT` for a NEW pit. | The preview shows the **block with stubs** (there is no real plan yet) — this is correct, not a fault. |
| **P21** | Change the pit size with several pipes connected. | The tags stay on the walls as the pit grows. |
| **P22** | If the command line ever prints **"The tabbed editor does not fit this AutoCAD work area"** | Report **which window**, your monitor resolution and your Windows scaling %. Also try 150% scaling if you can. |

---

# PART O — the CE pipe object (from the C7 chat)

**Do PART O on a COPY. `CDC7UPGRADE` changes pipes permanently.**

| ID | Step | What "right" looks like |
|---|---|---|
| **O1** | Open a **copy** of DWG-A. | ONE line: `[CE] N pipe(s) upgraded to CE pipe objects … Backup: <file>`. A `_PRE_C7_` file appears beside the drawing. Close and reopen: **no second line, no second backup**. |
| **O2** | Click a pipe. `LIST` it. | ONE object: band + magenta walls, grips on the **vertices only**. LIST reads `CE pipe P3: 3 points, 225 mm wide`. **No doubled magenta outline.** |
| **O3** | `MOVE` a pipe 2 m. | Pipe text, **both** IL texts and the arrow all move with it. |
| **O4** | Grip-drag a pipe end. | Same — all the text follows when the command ends. |
| **O5** | `CDFW` on a converted pipe. | It splits into **two pipe objects**. Move one half aside: **nothing left underneath.** |
| **O6** | `CD` a new pipe. | One object straight away. One `U` removes pipe **and** labels together. |
| **O7** | Open DWG-D (twin barrel), after the upgrade line. | It is **ONE object drawing two barrels**. Grip-move it: no stray barrels left behind. |
| **O8** | `CDEDIT` a pipe 100 → 150. | The walls widen. **No MLINE appears.** |
| **O9** | Open DWG-B (the 16 Sep test copy, 51 morning objects). | The open line says "**migrated**". The pipes still work normally. |
| **O10** | `CD` a pipe, then grip-drag its end **straight away**. | Labels follow. **No "identity" line in the CE log.** |
| **O11** | `CD` a pipe whose start lands ~100 mm from a big pit's edge. | The start IL text sits **one step further in**. The log line reads `route=draw … in from the pipe end (1)`. |
| **O12** | `PITEDIT` a 450 pit to 1200 where a pipe meets it. | The IL text **slides in along the pipe**; once 500 mm is used it **flips** to the other side. Log line `route=pit-boundary`. |
| **O13** | `MOVE` a pipe so its label crosses another pipe. | The label slides clear. The report **names the pipe** (e.g. `pipe P9`). |
| **O14** | `MOVE` a pipe so its callout text lands on IL text. | The text moves; the **leader still starts on the pipe**. |
| **O15** | `CDSETTINGS` → LABEL PLACEMENT. Try **900**. | **Refused** (the cap is 500). |
| **O16** | Same setting, set the step to **300**. | The IL text **flips** instead of sliding a second time. |
| **O17** | Do O3–O5 on an **ordinary, unconverted** pipe. | Nothing about it has changed. |

---

# PART K — CDLPD, the street connection note (from the K/L chat)

| ID | Step | What "right" looks like |
|---|---|---|
| **K1** | `CDLPD` → Enter → click a pipe near the street end **that has a level** → pick a label point **well away from the pipe**. At "What does this discharge into?" look at the list. | **`CouncilPit` is in the list** (it was missing). |
| **K2** | Choose `CouncilPit`. | Note reads `CONNECT TO COUNCIL PIT AT APPROX IL<level>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK.` — level to **two decimals**. |
| **K3** | Look at the note itself. | It is a **leader with an arrow** (an MLeader), **wrapped over about five lines**, arrow running back to the **pipe end** — the same look as a CD pipe callout. **Not one long line. The leader must not shoot across the drawing.** |
| **K4** | Run `CDLPD` again and type `Council`. | Still gives COUNCIL PIPE (the old word still works). |
| **K5** | Choose `CouncilPipe`. | `CONNECT TO COUNCIL PIPE AT APPROX …` runs on as one sentence. It must **NOT** break the line straight after the word PIPE. |
| **K6** | Run `CDLPD` and type `Banana`. | "not recognised", and **nothing is written**. It must NOT quietly write a kerb note. |
| **K7** | `CDLPD` on a pipe end with **no invert set**. | `CONNECT TO COUNCIL STUB TO COUNCIL SATISFACTION. BUILDER TO…` — **no `IL`, no `0.00`, no gap** where the level was. |
| **K8** | Run `CDLPD` twice on the same end. | **One** note, not two. `U` once removes note **and** leader. |
| **K9** | Check the list also offers | `CouncilStub`, `ExistingStub`, `Easement`, Kerb, `CouncilPipe`, SideEntry. |

---

# PART L — pit resize, tanks, propagation (from the K/L chat)

| ID | Step | What "right" looks like |
|---|---|---|
| **L1** | **The one that was broken.** Find a 450 pit with **2+ pipes running in**. Zoom so you can see where each pipe meets the outline. `PITEDIT` → set **1200 × 1200** (**change BOTH boxes**) → Save. | The outline grows **and every pipe now stops at the new bigger outline.** No pipe end stranded inside the pit; none poking through. |
| **L2** | Same resize, look at the text. | The label circle and the cover text have both **stepped out**, keeping the same clear distance from the pit edge. |
| **L3** | `U` once. | Size, label, cover text **and pipe ends** all go back together. |
| **L4** | Now shrink a 1200 back to 450. | Label and cover come **in**; pipe ends come in with them. |
| **L5** | Open `%APPDATA%\CE_CVL_SUITE\logs\` for that minute. | `PITEDIT Resize:` names the size **from** and **to**. Each `ShiftAnnotation` line prints `gapBefore=` / `gapAfter=`. **Copy those lines into the report** — same numbers means the rule held. |
| **L6** | **Tanks.** Open DWG-C (2+ tanks on one detention system). `CDTWL`. | The storage total is **bigger** than before, and it says *"This system has 2 tanks (WT1, WT2). All of them are counted in the storage."* It must **NOT** say *"Only WT1 is counted"*. |
| **L7** | `CDTWL` on a **one-tank** job. | Total **unchanged** from before. |
| **L8** | A re-use tank on a **different** system. | It must **not** appear in this branch's total. |
| **L9** | **Propagation.** On a drawing with **no** converted pipes: open a pipe, type an invert by hand, save. `CDPROPAGATE` from the downstream pit. | It tells you which levels you set by hand and **asks whether to keep them**. |
| **L10** | After Apply, open 2–3 pipes and compare with the schedule. | The level **on the drawing** and the level **in the schedule** are the **same number**. |
| **L11** | `U` once. | Pipes, pits **and the schedule** all go back together. Reopen a pipe and check. |
| **L12** | Now on DWG-B (converted pipes): `CDPROPAGATE`. | If any pipe could not be updated, a line at the top **names those pipes**. It must **not** quietly report success. **Copy that line into the report** — it is the evidence for a known unfinished piece. |
| **L13** | If a cascade is refused for any reason. | The schedule still shows the **old** levels (it must not run ahead of the drawing). |

---

# PART F — the computations sheet

| ID | Step | What "right" looks like |
|---|---|---|
| **F1** | `CDCALC` → **Export PDF** → print to PDF → **OPEN THE PDF and look at it.** | Page 1 is a **CE letterhead sheet**: logo top-left, CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS top-right, job strip, then **BASIS OF DESIGN → ON SITE DETENTION → STORAGE PROVIDED → VOLUME tables → ORIFICE → WHERE THESE FIGURES CAME FROM**, in that order. |
| **F2** | Read every line of page 1. | **No line starts with "Note:".** **No blank cover page.** **No repeated detention page.** |
| **F3** | Check the logo. | The CE logo is actually there, not a missing-image box. |
| **F4** | Export **XLSX**. | A tab called "**Computations**" reads the same as the PDF. |
| **F5** | Leave the council **unset** and export. | The sheet still comes out. PSD reads "**not known**" — **never `0`** — and the last block names it as not established. |
| **F6** | Make the storage short on purpose and export. | It says **by how much** it is short. It warns; it must not block the export. |
| **F7** | On the ORIFICE block. | Head, diameter, Co and flow are all present. Plate height deliberately reads "**not known**". |
| **F8** | Count the rainfall warning. | Note whether it appears **once or twice** (basis of design and provenance). Either way just report the count — Tim decides. |

---

# PART R — rainfall (built earlier, still untested)

| ID | Step | What "right" looks like |
|---|---|---|
| **R1** | `CDRAINFALL` on a job with no curve set. | It **says** it is using the office Melbourne curve and **warns it reads 7–9% high**. |
| **R2** | Load `SAMPLE_2_lighter_place.txt`, answer **No**. | Nothing changes. |
| **R3** | Same, answer **Yes**, then close and reopen the drawing. | The curve is still there. |
| **R4** | Load `SAMPLE_4_BROKEN_only_three_rows.txt`. | "needs 7 rows… 3 rows found. **Nothing has been stored.**" The previously stored curve is untouched. |
| **R5** | Load `SAMPLE_5_BROKEN_wrong_order.txt`. | Refused for being out of order. Previous curve untouched. |
| **R6** | `CDDESIGN` with no curve — note the storage required. Set the 18%-lighter curve, run again. | **Storage required goes DOWN.** Set the same-as-office curve → it returns to the original figure. |
| **R7** | **Nothing that worked has moved.** A job you know well with **no** rainfall curve set. | **Exactly the same** detention numbers as before. **Any movement at all is a FAIL.** |
| **R8** | `CDDEST` a downpipe destination, answer the split question, set a rainfall curve. Run a network redesign and apply it. | **All three survive.** (Before this fix all three were lost.) |

---

# PART M — the 2024 lane

| ID | Step | What "right" looks like |
|---|---|---|
| **M1** | On **AutoCAD 2024**: open a normal job. | The plugin loads. No error. |
| **M2** | 2024: `CDLPD` — steps K1, K5, K7. | Same results as 2027. |
| **M3** | 2024: `PITEDIT` resize — step L1. | Same result as 2027. |
| **M4** | 2024: `CDRAINFALL` — steps R1 and R7. | Same results as 2027. |
| **M5** | 2024: open a pit — the preview. | The older schematic/text view is usable. **No renderer error.** |
| **M6** | 2024: the pipe object. | **Expected NOT to work** — the 2024 enabler is built but has never been loaded on a 2024. If a drawing with CE pipe objects is opened on 2024 and shows proxy warnings, record it as **known / expected**, not a new fault. |

---

# How to report back

Save the report on disk and give Tim the path. One row per step ID:

```
| ID | Result | What I saw | Evidence file |
|----|--------|------------|---------------|
| S1 | PASS   | ProductVersion = 3.0.0+<commit> | s1-version.txt |
| W1 | FAIL   | Command line asked "Adopt or Insert" before any window | w1-cmdline.png |
```

Then three short lists at the end:

1. **FAILED** — step ID, one line each, worst first.
2. **BLOCKED** — step ID and what was missing (usually a drawing).
3. **NOT TESTED** — step ID and why.

**Do not summarise as a percentage or a score.** Tim asked for four separate facts, not one number.

**Screenshots** go in a folder beside the report, named by step ID.

---

*Compiled by the Civil deploy chat, 17 September 2026, from `PENDING_TESTS.md` rows L8–L18 (windows chat),
O1–O15 (C7/labels chat), K1–K7 and L1–L11 (K/L chat), plus the R rows from the rainfall batch and the
computations-sheet entries in the plugin `REGRESSION_LOG.md`.*
