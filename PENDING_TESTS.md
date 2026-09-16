# PENDING TESTS — what is built and waiting for Tim in AutoCAD

**This is the one living list, across every chat.** A chat ending must never take the test list with it.

## Rules for every chat

- **When you build something**, add it here with its branch, commit and the exact steps Tim should follow.
- **When Tim confirms a pass**, move it to "Accepted" at the bottom with the date and the build he tested.
- **When Tim reports a failure**, say so here — do not delete the row.
- **Never tick anything yourself.** A green build, a passing test run and an AutoCAD result are three different
  facts. Only Tim's word moves a row to Accepted.
- Steps must be **specific**: *"open a 375 pipe and check the Edit Pipe window shows 375"*, never *"test pipe
  editing"*. Include the failure paths — Cancel, Escape, a refused save, one accepted edit = one Undo.
- Say which **lane**: AutoCAD 2027, and separately 2024/net48 — Tim ruled 2022–2024 users are in scope.

---

## TESTED 16 September 2026 — MOSTLY FAILED. Read `01_MASTER_PLAN/TEST_DAY_RESULTS_2026-09-16.md` FIRST

`c1af9781` is live and Tim has tested it. **The deploy worked; most of what it carried does not.** Do not use
the 77-step list as a to-do — use the failure register in
**`01_MASTER_PLAN/TEST_DAY_RESULTS_2026-09-16.md`**, which is the authoritative record of what he found.

**Tim's instruction, 16 Sep:** ONE AREA AT A TIME. Priorities **`CDWT`, `CD`, `PIT`**, then test sections
**H, I, J, K, L**, then **M**. He has withdrawn trust in large batches.

### Original deploy note (kept for the record)

**Live bundle is `c1af9781`.** Deployed after Tim said "AutoCAD is closed, deploy". All three lane SHA256s
matched the staged payload and the lineage check printed nothing. **Nothing below has been tested in AutoCAD
by anyone** — that is the whole point of the list.

Use `01_MASTER_PLAN/DEPLOY_AND_TEST_2026-09-16.md` section 3: **77 steps, A to O**, covering the whole
69-commit payload. Restart AutoCAD first.

### LIVE since 16 Sep 16:06 — `6505fb5a` on `claude/ce-civil-handoff-sept-16-5623ca` (LAYOUT-01 · PIT-PREVIEW-01/02 · CD-PREVIEW-01 · BUG-159 CDGRIPDIAG)

Tim: *"AUTOCAD IS CLOSED, DEPLOY"*. All three lanes read `3.0.0+6505fb5a`. Backup: `CE_CVL_SUITE_PRE_0737efa3_20260916_160353.backup`.
**Installed, NOT tested.** Rows L1–L7 below are the list, plus the BUG-159 rectangle test in the plugin repo `docs/workflows/BUG159_DEPLOY_HANDOVER.md`.

Full entries: plugin `REGRESSION_LOG.md` LAYOUT-01, PIT-PREVIEW-01, PIT-PREVIEW-02, CD-PREVIEW-01.

| # | What | Steps | Lane |
|---|---|---|---|
| L1 | **CD window uses the whole window** | Double-click a stormwater pipe. Engineering left, Drafting right, PLAN PREVIEW reaching from just under the fields to just above the buttons. No empty black band. All five buttons visible, no scrolling. | 2027 |
| L2 | **Nothing pushed off on the busy cases** | Same on a detention pipe with twin pipes on, and on a pipe with a linked IL label. Type a value → More… → Back: value still there. | 2027 |
| L3 | **PIT centre preview is the wide column** | Double-click a pit. Centre PLAN PREVIEW clearly wider than either side column. Both "Bottom right" position lists on the right fully readable, not cut off. | 2027 (and 150% scaling if you can) |
| L4 | **Fit guard** | If the command line prints "The tabbed editor does not fit this AutoCAD work area", report which window and your monitor/scaling. | 2027 |
| L5 | **PIT preview shows every connected pipe (PIT-PREVIEW-01, `d5f41362`+)** | Double-click a pit with 2+ pipes: each pipe is a grey stub on the wall it enters, square to the wall, with "size · Entering/Leaving · IL" at its end. Pick another pipe in the list: its stub goes gold. A pipe with no IL reads "IL Unknown". A pipe CE cannot place is listed top-left as "Not placed: … – reason" with no stub. Change the pit size: stubs stay on the walls. | 2027 only |
| L6 | **PIT preview is the real plan around the pit (PIT-PREVIEW-02)** | Double-click a pit on a real drawing: the centre picture is the actual plan, north up, pit centred, ~3 pit-widths across, sharp. Tags (no stub lines) at each placed pipe's wall point with "size · Entering/Leaving · IL"; picked pipe goes gold. Change pit size: redraws. Opening must not feel slower; say by how much if it does. Try a drawing with an xref underneath and report whether it shows. A NEW unplaced pit shows the block + stubs instead. | 2027 only |
| L7 | **CD preview is the real plan along the pipe (CD-PREVIEW-01)** | Double-click a pipe between two pits: the PLAN PREVIEW band is the actual plan along it, north up, both pits in view, sharp. Gold ring + caption "pit · IL" at each end; type a new invert and the caption changes at once. A pipe ending at an IO/DP/LPD shows the real symbol. A 3+ vertex pipe shows the whole run. A NEW pipe still shows the old schematic. Opening must not feel slower. NOT yet shown: where pipe text / invert text / arrow will land (next item). | 2027 only |
| L8 | **PIT-CONN-01 - pit lists its pipes again** (built, NOT installed) | Edit Pit P10 on the same drawing: Connected pipes shows the P10→P9 pipe with size and IL, and its tag sits on the picture at the wall. Edit Pit P9: same pipe, Entering. A pit with no pipes still says so. | 2027 |
| L9 | **CD-PREVIEW-01a - New Pipe shows the real plan** (built, NOT installed) | CD, pick the route: the window opens with the plan along the picked points and End 1 / End 2 captions. | 2027 |
| L10 | **POLISH-01 - CD/PIT windows tidied** (built, NOT installed) | Edit Pipe: level row on one line ("Set Upstream 19.45 m AHD"), header chip one line, plain wording under the levels. Edit Pit: label row + one status line under it, two readout lines under the picture, no duplicate "no pipes". Say what still looks wrong. | 2027 |
| L11 | **PIT-TYPE-01 - stormwater pipe no longer called CHARGED in the pit list** (built, NOT installed) | Edit Pit P10: list reads "P10 → P9 · Entering/Leaving · IL 19.450" and the pit IL suggestion strip appears. Save the pipe unchanged, reopen the pit: still not charged. A real Charged pipe still reads CHARGED. | 2027 |
| L12 | **CLICK-01 - click the picture to select** (built, NOT installed) | Edit Pit with 2+ pipes: click a pipe tag on the picture, the list changes and the tag goes gold. Edit Pipe: click the downstream ring, the cursor lands in the downstream level box with its value selected. | 2027 |
| L13 | **DRAG-01 - drag the corner badge** (built, NOT installed) | Edit Pit: drag the gold badge to the top-left of the picture and release: badge sits top-left, the Pit label corner list reads Top left, cover-text list unchanged. Pick "Cover text" in the footer list, drag to top-right: only the cover-text corner changes. Cancel: nothing moved on the drawing. | 2027 |
| L14 | **DRYRUN-01 - the picture shows what Save would do** (built, NOT installed) | Edit Pit: 450→1200, wait 1 s: bigger pit + stepped-out label in the picture; change label corner: label moves. **Cancel, then `U` once: only your previous real edit undoes - anything else, stop and report.** Edit Pipe: change diameter + text side, wait: text reads the new size on the new side, arrow where Save puts it; type a new IL: it changes. Type fast: no per-keystroke flicker. Blank the pit size: falls back to the plan as-is, no error. | 2027 |
| L15 | **PIT-TWEAKS-01 - tick, size drop-down, sump tick** (built, NOT installed) | Edit Pit: Plan size is a drop-down of your ladder (450/600/900/1200/1500); pick 900 → picture redraws; type 700 → accepted. Bottom row tick reads "Sump pit · own bottom IL": unticked = grey box; ticked = box opens. Save, reopen: kept. **Confirm "Sump pit" is what you meant.** | 2027 |
| L16 | **CDWT-W01 - tank window first, and it opens** (built, NOT installed) | `CDWT`: the window appears IMMEDIATELY (no "Adopt or Insert" at the command line first). Above ground ticked; list smallest first with dimensions; tick Underground → list changes. Pick tank, detention, plan → Place tank → insertion point with ghost → callout/riser/dropper → Base RL. "Tag a block already in the drawing" closes the window and asks for the block. Cancel: nothing placed. If the command line asks Adopt/Insert first, paste the [CE] line. | 2027 |
| L17 | **BUG-158 / F1 - the computations sheet is a CE sheet** (built, NOT installed) | `CDCALC` → Export PDF → print to PDF → **open the PDF**. Page 1 = CE letterhead sheet: logo top-left, CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS top-right, job strip, then BASIS OF DESIGN → ON SITE DETENTION → STORAGE PROVIDED → VOLUME tables → ORIFICE → WHERE THESE FIGURES CAME FROM. No "Note:", no blank cover, no repeated detention page. Export XLSX: "Computations" tab reads the same. | 2027 |

### Branch `claude/ce-civil-handoff-75-percent-671a19` — IFD-01 · D2 · F1/F2 · BUG-156 (built overnight 15–16 Sep 2026)

Owner: the Civil behaviour chat. **Use `01_MASTER_PLAN/DEPLOY_AND_TEST_2026-09-16.md` section 3 — it is the
ONE consolidated list for the whole 69-commit payload, including everything in the folded-in table above.
The rows below are a summary of this chat's own part only.**

| # | What | Steps | Lane |
|---|---|---|---|
| R1 | **`CDRAINFALL` — a job carries its own rainfall** | New command. Run it on a job with no curve: it must SAY it is using the office Melbourne curve and warn that it reads 7–9% high. Load `SAMPLE_2_lighter_place.txt`, answer No (nothing changes), then Yes. Reopen the drawing — the curve is still there. | Both |
| R2 | **A bad block is refused, nothing stored** | `SAMPLE_4_BROKEN_only_three_rows.txt` → "needs 7 rows… 3 rows found. Nothing has been stored." `SAMPLE_5_BROKEN_wrong_order.txt` → refused for being out of order. The previously stored curve must be untouched. | Both |
| R3 | **The rainfall actually changes the design** | `CDDESIGN` with no curve, note the storage required. Set the 18%-lighter curve, run again — **storage required must go DOWN**. Set the same-as-office curve — it must return to the original figure. | 2027 |
| R4 | **CDCALC produces the computations sheet** | `CDCALC` → Export PDF / XLSX. The export now LEADS with a CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS sheet (XLSX tab "Computations"): header, basis of design naming the rainfall curve, PSD and storage required with the council in brackets, the storage split, VOLUME OF PIPE and VOLUME OF PIT tables, an ORIFICE block, and WHERE THESE FIGURES CAME FROM. | 2027 |
| R5 | **The sheet warns, never blocks** | Leave the council unset and export: the sheet still comes out, PSD reads **"not known"** and never `0`, and the last block names it as not established. Make the storage short on purpose — it must say **by how much**. | 2027 |
| R6 | **Plate height says "not known"** | On the ORIFICE block, plate height is deliberately "not known" — CDCALC holds the head, not the plate height, and CE will not work one backwards. Confirm the head, diameter, Co and flow are all present. | 2027 |
| R7 | **BUG-156 — a redesign stops forgetting** | Record a downpipe destination (`CDDEST`), answer the split question, set a rainfall curve. Run a network redesign and apply it. All three must survive. Before this fix all three were lost. | 2027 |
| R8 | **Nothing that already worked has moved** | A job you know well with NO rainfall curve set must produce **exactly the same** detention numbers as before. Any movement at all is a fault. | Both |
| R9 | **The 2024 lane** | R1 and R8 on AutoCAD 2024 — 2022–2024 users are in scope. | **2024** |


### FOLDED IN — `claude/c7-one-object` @ `9058a405` is inside the batch below

> **Do not test from this table.** Every row of it is now part of
> `01_MASTER_PLAN/DEPLOY_AND_TEST_2026-09-16.md` section 3, which is ONE list covering the whole payload
> (Tim's ruling, 14 Sep). `9058a405` is an ancestor of `d6aa4dbf`, so deploying that batch installs all of
> this too. The rows are kept below only so nothing is lost; the steps in the deploy document are the
> current ones.
>
> **Row 14's hold is lifted.** `CDTWL` was held because it asserted a top water level instead of offering
> candidates. It now offers them (commit `a5dce440`), so it is testable — see section E of the deploy
> document.

#### Original rows, superseded by that document

Owner: the Civil behaviour chat. **Requires the API-v3 enabler to be rebuilt and shipped with it.**

| # | What | Steps | Lane |
|---|---|---|---|
| 1 | **BUG-154 — CDFW/CDSOURCE place again** | In the job that failed: `CDFW` at a free point, then on a pipe run, then on a free pipe end. Each must place. | Both |
| 2 | **The repeated-name offer** | After each placement the command line names the repeated source name, says **nothing was stopped by it**, and offers `CDFIXTAGS`. | Both |
| 3 | **`CDFIXTAGS`** | It lists the repeated names and their blocks, proposes renames, changes nothing on **No**. Run again, answer **Yes**, check the renamed blocks show their new labels. | Both |
| 4 | **Split on draw** | Three pits in a line; draw ONE pipe through all three. It asks once — answer Yes. You get four pipes, four schedule rows, and the middle pits have a pipe in and out. | Both |
| 5 | Split on draw — memory | Draw another across pits: **it must not ask again**. In a NEW drawing answer **No** first time; it stays one pipe and does not ask again. | Both |
| 6 | Split on draw — edge cases | A pipe that starts and ends on pits but crosses nothing: says nothing, splits nothing. **Escape** at the question: nothing split, pipe intact. | Both |
| 7 | **Converted pipe split (C7 3d)** | `CDC7UPGRADE` a pipe, then `CDFW` on it. Both halves must be CE pipe objects. **Move the top half aside and check there is no stray pipe underneath** — that is the whole point. | 2027 |
| 8 | Converted split — annotations | Labels and invert texts end on the correct halves; the new invert appears both sides of the floor waste. A **twin barrel** still draws as twins after the split. | 2027 |
| 9 | Ordinary pipe unchanged | Do the same on an unconverted pipe and confirm nothing about it changed. | Both |
| 10 | **Pit label on resize** | PITEDIT a 450 pit to 1200. The label circle steps out and **keeps its distance from the pit**, like the cover text. Check the CE log line `ShiftAnnotation [pit label]`. | Both |
| 11 | **`CDDESIGN`** | Asks only for what is missing; makes you confirm the legal point of discharge; refuses a roof area larger than the site **without shrinking your number**; finishes saying nothing was drawn. **Confirm the drawing is untouched.** | Both |
| 12 | **LPD note** | `CDLPD`, pick the street pipe end. The list now offers **CouncilStub, ExistingStub, Easement** as well as Kerb/CouncilPipe/SideEntry. Choose CouncilStub — the callout must read `CONNECT TO COUNCIL STUB AT APPROX IL<level>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK.` with the level to **two decimals**. | Both |
| 13 | LPD — unknown level | Run it on a pipe end whose invert is **not set**. The note still appears and simply leaves the level clause out — no `IL m`, no zero. | Both |
| 14 | **`CDTWL`** | ⚠️ **Hold** — the TWL rule was reopened 15 Sep (a trench grate can sit above the highest pipe obvert). Do not test until the command offers the candidates rather than asserting one. | — |

### Codex window candidates — not installed

| # | What | Status |
|---|---|---|
| 15 | PIT input pages / no-scroll | **Measured failure open**: detention at 900 × 600 overflows by ~5.4 layout units. Not committed, not deployed. |
| 16 | UI connection recovery (`af0cd66a`) | 19 of 25 wanted corrections recovered. **Not a Structural replacement** — it deletes the installed SBEAM runners. |
| 17 | Structural preservation (`60c41228`) | Built and checked, **not installed**. Preserves SBEAM commands. |

---

## ALREADY LIVE AND STILL UNTESTED — `10ac480d`, installed 15 Sep 14:46

| # | What | Steps | Lane |
|---|---|---|---|
| 18 | PIT block preview, taller pane (`63bc7207`) | Open PIT. **Check nothing scrolls** and everything is visible on open. Tim has reported a scrollbar is present — Codex owns this. | 2027 |
| 19 | PIT preview in 2024 | Old schematic/text remains usable; no renderer error. | **2024 — never tested** |

---

## ACCEPTED — keep the record, do not re-test without a reason

| What | Build tested | Date |
|---|---|---|
| CDPARTS Save and Reset to Defaults (BUG-152/153) | `10ac480d` | 15 Sep 2026 — recorded on #78 |
| PIT block preview, original rendering — **7 of 8 checks** | `6a6d6bc7` | 15 Sep 2026 — #75. The 2024 check stays open |
| C0 managed Slide/Offset/Flip grips and twin/MLINE selection, bounded Test Day 2 | `9050f497` | recorded on #26 |
