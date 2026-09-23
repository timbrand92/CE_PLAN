# CE Civil — test run for Codex, 23 September 2026

**Run this yourself, start to finish. Tim does not need to be at the desk.**

> **INSTALLED AND READY.**  went live 23 September 11:26. S1 will pass.

---

## 0. STOP IF THIS IS NOT TRUE

Step **S1** tells you which build you are on. **If it does not read `3.0.0+b02f3ec7…`, the payload is not
installed. Stop.** Mark every step below **BLOCKED — payload not installed** and say so at the top of your
report. Testing the old build against this list is how a pass gets recorded against code that is not there.

---

## 1. Rules for this run

1. **Work on COPIES of drawings.** Never an original. Several steps deliberately change the drawing.
2. **One of four words per step: PASS · FAIL · BLOCKED · NOT TESTED.** Nothing else. **No score, no
   percentage, no "mostly working"** — a score is the one output that lets a real failure hide.
3. **A step with no observation recorded is NOT TESTED**, even if it obviously works. **Never infer one
   step's result from another.**
4. **Screenshot every step that says "looks like" or "reads".** Name the file by step ID.
5. **On a FAIL capture all five:** what you did · what you expected · what happened · the **exact
   command-line text** · the CE log lines from `%APPDATA%\CE_CVL_SUITE\logs\` for that minute.
6. **If AutoCAD crashes, say which step caused it, stop that section, carry on with the next.**
7. **Do not fix anything. Do not deploy.** You are producing evidence, not acceptance.
8. **Only Tim's word accepts anything.** Built · tested · installed · Tim-accepted are four separate facts.
9. **If you are stopped part-way**, save the partial report and mark every unreached step NOT TESTED.

### Turn diagnostics ON first, and say that you did.

---

## 2. Drawings

Paths are **not** in this file on purpose — office folders are named after client addresses (DATA-01).
They are in `C:\Users\TimothyBrand\CE_TEST_DRAWINGS_2026-09-17.md`. **Work on copies, in a scratch folder.**
If a drawing is not available, mark its steps **BLOCKED — no drawing**, not FAIL.

---

## 3. Known, already recorded — do NOT report these as new

1. **A cancelled editor window still costs one Undo (P13).** Open any CE editor, change nothing, Cancel,
   press `U` — the Undo is spent. **OPEN, cause not established.** Expected; not a regression.
2. **The CDWT crash (W4)** at the callout point. **Cause not established, no fix attempted.** If it
   crashes there, that is expected. **Step N9 is a probe to narrow it**, not a test of a fix.
3. **The CD window still scrolls.** The plan preview can slide out of view while you type. Known, not fixed.

---

# PART S — start up (these gate everything)

| ID | Step | What "right" looks like |
|---|---|---|
| **S1** | PowerShell: `(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion` | **Record the full string.** It must read `3.0.0+b02f3ec7…`. If it reads `3.0.0+d90659cf…` the payload is NOT installed — **stop**, everything below is BLOCKED. |
| **S2** | Start AutoCAD 2027, open a COPY of a drainage job. | CE ribbon appears. No error dialog, nothing reading "unable to load". |
| **S3** | Type `CDINSPECTOR`. | Runs and reports. **If any CE command is "unknown command", stop — the plugin has not loaded** and everything below is BLOCKED. |
| **S4** | Turn diagnostics ON. | Say in your report that you did, and how. |

---

# PART T — the tank finds its own plan drawing (NEW — test this first)

**What changed.** The tank list and the plan grid came from different places and nothing tied a row to a
picture, so picking a tank left 37 plans to scan by eye. Picking a tank now matches on the **litres printed
in the plan caption** — not on the tank's size, because those are different numbers.

| ID | Step | What "right" looks like |
|---|---|---|
| **T1** | `CDWT`. Answer **Above ground**. Pick **3000 L Round** in the list. | **The 3000-litre plans jump to the front of the grid**, and a **gold line** under "Which plan drawing?" says how many were found. **Count them and quote the line exactly.** |
| **T2** | Count the tiles still in the grid. | **Nothing has disappeared** — the full list is still there, only reordered. Say the total. |
| **T3** | Click the plan you want. Press **Cancel**. Run `CDWT` again and pick **3000 L Round** again. | **That plan is already selected**, with no hunting. This is the part that saves the time. |
| **T4** | Switch question 1 to **Underground**, pick a tank. | The **underground** plans now come first instead. |
| **T5** | Pick **2510 L** (it has exactly one plan). | It is **selected outright** — CE does not make you choose when there is only one answer. |
| **T6** | Pick **7000 L** (no plan in the master is marked 7000). | The gold line **says so plainly**, and the **full list is left exactly as it was**. Quote the line. |
| **T7** | Pick a tank, then place it end to end: detention share → **Place tank** → insertion point → callout → Base RL. | The tank that lands is **the one in the picture you chose**. *(If it crashes at the callout point, see §3.2 — expected, not new.)* |
| **T8** | **THE CRASH PROBE.** Place a tank again, but at the callout prompt press **Enter** instead of picking a point. | **If it completes:** the callout pick is implicated — say so, that is the finding. **If it still crashes:** attach AutoCAD's own error report. Either way **not a new fault**. |

---

# PART R — the CD window's "Recent:" strip (NEW)

**What changed.** The strip offered ten buttons when only three or four were different values. Read from
Tim's settings on 23 Sep: 10 diameters with **4** distinct, 10 materials with **3** distinct.

| ID | Step | What "right" looks like |
|---|---|---|
| **R1** | `CD`, draw a route, and look at the **Recent:** strip under the **diameter** box. | **Four buttons, not ten**, and **no two the same**. Count them and list what they read. |
| **R2** | Same under the **material** box. | **Three buttons, not ten.** No repeats. |
| **R3** | Use a diameter you have not used lately. Close CD, reopen it. | It is there, **at the front**. |
| **R4** | Use a diameter that is **already** in the strip. | It moves to the front and **does not appear twice**. |
| **R5** | Look at the **invert** recent strip. | It has ten genuinely different values, so **ten is correct there**. Do not report it as a failure. |

---

# PART P — the pit number travels with its circle

**What changed.** A pit label is a block holding the circle as a wipeout and the number as an *attribute*,
which carries its own position. CE moved the block and never the attribute — so the circle stepped out and
the number stayed. This is the long-running "the label won't step out" report: it **did** step out; nobody
was watching the number.

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **P1** | Open a job. Note where **P10**'s number sits inside its circle. Screenshot. | — | 2027 |
| **P2** | `CDEDIT` on **P10**. Change **450×450 → 1200×1200**. **Save.** | **Circle AND number move together**, number still centred. | 2027 **and 2024** |
| **P3** | Undo. `CDEDIT` P10 again, change **only the label corner** (Top right → Bottom right). Save. | **The number goes with the circle.** No resize at all here — that is the point. | 2027 **and 2024** |
| **P4** | Same on a pit using the other label block (**P1** or **C1**). | Same result. Both blocks must behave. | 2027 |
| **P5** | **Resize two pits at once.** | **Both** numbers travelled. | 2027 |
| **P6** | **A lead, NOT a claimed fix.** **MOVE** a pipe carrying a `FALL` or `LEVEL` tag, then **grip** one. Try a **diagonal** pipe too. | **Report exactly what the text does.** A probe found 240 of 387 blocks carry text as attributes the same way. **This is a hypothesis.** Your observation settles it. | 2027 |

---

# PART L — levels, splits and tags

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **L1** | Open a **fresh copy** of a job with pipes. **Edit nothing first** — that is the point. Double-click an `IL 19.40` text. | The **Edit Pipe window** opens on that pipe with 19.40 in the box. Previously: AutoCAD's plain text editor. | 2027 **and 2024** |
| **L2** | Double-click a note in the title block that **CE did not draw**. | **AutoCAD's own text editor.** If the Edit Pipe window opens, **stop and report**. | 2027 **and 2024** |
| **L3** | Pick a pipe with both levels; note them in `PITSCHEDULE`. Double-click, **empty the downstream box**, OK. | Text leaves the plan **AND** `PITSCHEDULE` shows that level **blank**. Reopen the pipe: **still empty**. All three. | 2027 **and 2024** |
| **L4** | `U` once after L3. | The level returns **on the plan and in the schedule**. | 2027 |
| **L5** | **The guard.** Type `19.4O` (**letter O**) in a level box, OK. | **Nothing is deleted.** Stored levels unchanged. **Quote the command line.** | 2027 |
| **L6** | **The other guard.** On a pipe with both levels, tick **simple pipe only**, OK. | Texts come off the plan but `PITSCHEDULE` **still shows both levels**. | 2027 **and 2024** |
| **L7** | **Lock the layer the IL texts sit on.** Run the repair that cascades levels. | It **names the pipes it could not update**. `PITSCHEDULE` must **NOT** show the new levels for them. | 2027 **and 2024** |
| **L8** | Unlock, run again. | Drawing and schedule move together. A pipe with **no** IL text still updates normally. | 2027 |
| **L9** | Three pits in a line. `CD` **one** pipe through all three (19.45 → 19.25). Answer **Yes** to the split. | **Both `IL 19.35` texts beside the MIDDLE pit** — one above the pipe, one below. | 2027 **and 2024** |
| **L10** | Same run **right to left**, and again **north–south**. Split each. | Levels at the middle pit both times. | 2027 |
| **L11** | After L9: do **both halves carry their own pipe text**? | **Report what you see.** If one half has none, say so — known gap; the fix refuses to copy a *block*-type label on purpose. | 2027 |
| **L12** | `CDFIXTAGS` → **Yes** on a drawing with repeated names. | **"Nothing to repair" must NOT appear** after a Yes. One summary, one line per block, each reason ending in what to do. **Quote it.** | 2027 **and 2024** |
| **L13** | Count the renames. | One awkward block used to stop the rest. **Report how many of the three get renamed now.** | 2027 |
| **L14** | `CDFIXTAGS` on a **tidy** drawing. | *"Every source name in this drawing already names one block. Nothing to repair."* — correct **there**. | 2027 |

---

# PART D — detention and CDLPD

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **D1** | **Settings page: read the standard LPD note.** | The **full sentence** — `CONNECT TO … TO COUNCIL SATISFACTION. BUILDER TO CONFIRM…` — **not** `LPD - {connection}, IL {invert} m AHD`. That stale setting is why every note came out short. | both |
| **D2** | `CDLPD` → pipe end → label point → type **`Council`**. | The note says **COUNCIL PIPE**. **Must NOT say COUNCIL STUB.** | both |
| **D3** | Type **`CouncilP`**. | *"CouncilP could mean CouncilPit or CouncilPipe. Nothing was written…"* and **nothing is placed**. | both |
| **D4** | Type **`K`**; on another run press **Enter** with nothing typed. | KERB & CHANNEL both times. | both |
| **D5** | **Type your own wording** into the Settings note box, save, close AutoCAD, reopen, run `CDLPD`. | **Your wording is still there.** CE must never overwrite it. | both |
| **D6** | `CDCALC` → Detention → **add a system**. | Volume box **empty**, not `0.0`. PSD box **empty**, not `5.24`. | both |
| **D7** | Insert **ON SITE DETENTION CRITERIA** for a system with no volume. | Reads `VOLUME REQUIRED   NOT SET`. **Must NOT read `0.00 m3`.** **Screenshot.** | both |
| **D8** | `CDTWL` → outlet → volume → at *"Which level is the top water level?"* type **`18.54`**. | **Accepted.** Must **NOT** say *"1 or 2 only"*. | both |
| **D9** | Type a level **above the lowest lid**; on another run type **`banana`**. | Above-lid: accepted **with a warning**. `banana`: refused cleanly, nothing written. | both |
| **D10** | On the **real detention job from Test Day**, run `CDTWL`. | Storage total **higher than the 17,948 L** seen before. **Report the new number, and how many pits and pipes are still left out.** | both |

---

# PART X — the 2024 lane

| ID | Step | What "right" looks like |
|---|---|---|
| **X1** | On **AutoCAD 2024**, repeat: **P2, P3, L1, L2, L3, L6, L7, L9, L12, D1, D2, D6**. | Same results. **Report each separately** — never write "same as 2027" without running it. |
| **X2** | Say plainly whether the plugin loaded on 2024 at all. | If not, **X1 is BLOCKED, not FAIL**, and say so at the top. |

---

# PART Z — has anything that worked stopped working?

**The 16 September test day failed because a large payload was installed and most of it did not work. This
section catches that shape early. Do it even if you are short of time.**

| ID | Step | What "right" looks like |
|---|---|---|
| **Z1** | Open a job you know. **Change nothing.** Look at it. | Nothing moved. No label jumped, no text doubled, no pipe lost its outline. |
| **Z2** | `PITSCHEDULE` on that untouched job. | Reads the same as before. **Any movement at all is a fault** — report before and after. |
| **Z3** | `CD` one new pipe between two pits, with levels. | Pipe, text, arrow, levels all land. **One `U` removes the whole thing.** |
| **Z4** | Double-click that pipe, change the diameter, OK. | Pipe text reads the new size. One `U` puts it back. |
| **Z5** | `CDCALC` → Export PDF → **open the PDF and look at it.** | Page 1 is the CE letterhead sheet. **No `Note:` before every line, no blank first page.** *(This is the fault that had 27 green tests against text nobody had printed.)* |
| **Z6** | `CDINSPECTOR` on a job with CE records. | Reports without error. |

---

# HOW TO REPORT

One file. One row per step ID, in order, **exactly one** of PASS · FAIL · BLOCKED · NOT TESTED, and the
observation you actually made.

```
| ID | Result     | What you observed                                  | Evidence |
|----|------------|----------------------------------------------------|----------|
| S1 | PASS       | ProductVersion read: 3.0.0+b02f3ec7...              | -        |
| T1 | FAIL       | No gold line appeared; grid order unchanged        | T1.png   |
| T3 | NOT TESTED | Did not reach this step                            | -        |
```

**At the top of the report, state:**

1. The **exact ProductVersion** from S1.
2. Whether **diagnostics were ON**.
3. Which **drawings** you used — by their label in the drawings file, **never the job address**.
4. Whether the **2024 lane** loaded.
5. Four numbers: **how many PASS, FAIL, BLOCKED, NOT TESTED.** **Not a percentage, not a score.**

**Do not summarise as "mostly working" or give it a mark out of ten.** Tim needs to see which specific
things failed, because he tests the failures himself.

---

## What this run does NOT cover

1. **`CDIMPORTXCIVIL`** — no code change since 3 July, never re-run since every imported pipe became a CE
   object. A standing risk, not part of this payload.
2. **`CDIMPORTLANDXML`** reads 0 pipes from a real Civil 3D export. Different branch, not re-verified.
3. **The CD window layout** — the preview still scrolls away; invert boxes and labels unchanged. That window
   was rebuilt since those fixes were written, so they are a redesign, not a patch.
