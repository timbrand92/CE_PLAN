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

## NOT YET DEPLOYED — nothing below is installed, so none of it can be tested yet

### Branch `claude/c7-one-object` @ `9058a405` — 52 ahead of live `10ac480d`, 0 behind

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
