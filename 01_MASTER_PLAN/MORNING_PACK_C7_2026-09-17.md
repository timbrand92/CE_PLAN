# Morning pack — 17 September 2026 — the C7 pipe object, identity, and label placement (overnight block)

**Chat:** "other Civil areas" · **Branch:** `claude/civil-other-areas-2026-09-16-1c1ae6` · **Tip:** `812f868f` (pushed)
**Nothing deployed. Nothing installed. Live is still `6505fb5a`.** The window chat merges and installs as one payload.

> Send this to the window chat: branch `claude/civil-other-areas-2026-09-16-1c1ae6`, tip `812f868f`.

---

## 1. BUILT (committed, pushed, unit-tested — nobody has opened any of it in AutoCAD)

| # | What you asked for | What it does now | Proof on disk |
|---|---|---|---|
| 1 | **Probe first** (your call, 6m) | A pipe object built on AutoCAD's own polyline class reads as a real polyline with its real handle. Measured headless, not guessed. | `C:\Autodesk\CERef\PROBE-C7-POLY-20260916\FINDINGS.md` |
| 2 | **Rebuild the pipe object** | `CE_CVL_PIPE_OBJECT`: one object, draws its own band + walls, vertex grips only, TRIM/BREAK keep it a pipe. The 16 Sep morning object is kept and migrated in place, so your test copy is not lost. | `docs/verification/c7-poly/claude-c7-poly-selftest-accoreconsole2027.txt` (every line as expected) |
| 3 | **"Converted pipe fell apart"** (C7-01) | The watcher now sees the object as a polyline again, so text and arrows follow a MOVE or grip. No code in the watcher changed — that is the point of the rebuild. | REGRESSION_LOG C7-POLY |
| 4 | **CDFW refused** (C7-03) | The source pre-scan sees a polyline again, so CDFW runs and splits. | REGRESSION_LOG C7-POLY |
| 5 | **Upgrade everywhere** | Every job upgrades on open (one line, one dated `_PRE_C7_` backup the first time only), `CD` draws the object straight away, `CDC7UPGRADE` is the manual trigger. **Twins upgrade too.** | REGRESSION_LOG C7-POLY |
| 6 | **Ordinary pipes refusing** (item 2) | Root cause: a `CD` pipe never got its CE identity (only `CDSPINEUPGRADE` wrote it). Now given at draw and checked on open. | REGRESSION_LOG IDENT-01 |
| 7 | **The placement rule** (PLACE-01, your words) | ONE rule: slide along the pipe (step and limit on the Settings page, never more than 500 mm from the pipe end), then flip; obstacles are pits (by footprint), other pipes, sources, CE text; callout text moves and the leader stays on the pipe. Runs on draw, after a move/grip, after a pit move/resize, after a split. | REGRESSION_LOG PLACE-01 |
| 8 | **2022–2024 enabler** (your call) | Builds clean with the 2024 SDK. **Never loaded** — this PC has AutoCAD 2027 only. Not staged. | REGRESSION_LOG C7-2024 |
| 9 | Doubled outline risk | The managed border overrule now leaves a pipe object alone. | audit commit `812f868f` |

**Test counts (honest):** native self-test green; net10 focused fixtures 30/30, 64/64, 33/33, 71/72 (the 1 is a known
trunk failure); **final full net10 suite 9812 run / 9772 passed / 23 failed / 17 skipped — the same 23 known trunk failures, zero new**; net48 / net8 / net10
builds 0 errors, SkipDevBundle throughout.

## 2. TEST THIS — AutoCAD 2027, on a COPY of a job, after the window chat installs the payload

Full steps with "what right looks like" are in `C:\CE_PLAN\PENDING_TESTS.md` rows **O1–O15** and the plugin
`REGRESSION_LOG.md` entries C7-POLY / IDENT-01 / PLACE-01. The six that matter most:

1. **Open a copy of a job.** One line: `[CE] N pipe(s) upgraded to CE pipe objects ... Backup: <file>`. The
   `_PRE_C7_` file is beside the drawing. Close and reopen: no second line, no second backup.
2. **Click a pipe.** One object: band + magenta walls, grips on the vertices only. LIST reads `CE pipe P3: 3 points,
   225 mm wide`. **No doubled magenta outline.**
3. **MOVE a pipe 2 m, then grip-drag a pipe end.** Pipe text, both IL texts and the arrow follow both times.
4. **`CDFW` on a converted pipe.** It splits into two pipe objects; move one half aside — nothing left underneath.
5. **`CD` a new pipe, then grip-drag its end straight away.** Labels follow; the log has no "identity" line. One U
   removes pipe + labels together.
6. **`PITEDIT` a 450 pit to 1200 on a pipe.** The IL text slides in along the pipe; once 500 mm is used it flips to
   the other side. The command line says what moved and why.

Also: a twin detention pipe after open is ONE object drawing two barrels; `CDEDIT` 100→150 widens the walls with no
MLINE appearing; the 16 Sep test copy's 51 morning-objects open with "migrated" in the line.

## 3. NEEDS TIM

- **2022–2024:** the 2024 enabler needs an AutoCAD 2024 to load on (row O15). Whether one build serves 2022 and
  2023 too is not asserted. Until then nothing upgrades on 2022–2024 lanes (by design).
- **Pits' identity:** `CDPIT` pits still get their identity only from `CDSPINEUPGRADE` (IDENT-01 covers pipes).
  Want the same treatment for pits?
- **PLACE-01 on open:** I did NOT run the placement rule on open — an old job's labels would be rearranged behind
  your back. Say if you want it.
- **Slide step default:** 125 mm (one text height). Change it on the Settings page if you prefer 100 or 150.
- **Window chat merge note:** its `PipeEditCommand.Update.cs` still makes an MLINE on every save; `RegisterPipe` now
  takes it away for a pipe object, so nothing to change there — but they should know why no MLINE appears.

## 4. Where I stopped and why

Ran out of unblocked work in the block: every item of the overnight list is built; the only open items need an
AutoCAD 2024 or your decision. Sections H and I from the earlier list (CDFIXTAGS, split-on-draw) were not part of
tonight's block and are untouched. Log: `REGRESSION_LOG.md` (four entries), `FLEET_STATUS.md` in the worktree.
