# MORNING PACK — 19 September 2026

**Written overnight by the COMBINE chat. Nothing was deployed.**

---

# ▶ FOR TIM

## The one thing to know

**All four chats' work is now one payload. It builds, it tests clean, and it is waiting for your word.**

**Nothing was installed.** You went to bed without saying AutoCAD was closed, so I held the gate. Your AutoCAD
is still on `3.0.0+d0ffe1a2` — the same build you had yesterday.

## To install it, say this to the COMBINE chat

> **"AutoCAD is closed, deploy"**

Then I will: check AutoCAD is really shut (twice), **back up your live bundle by hand and tell you the folder
name** — that is your one-action undo — build, install, and read all three versions back off the disk myself.

## What is in it

| Area | What you would see differently |
|---|---|
| **CDWT tanks** | **39 tiles, not 29.** Every tile has a picture. GRAF CARAT, AQUARIUS, WT1 and PLAN VIEW are back — they were silently dropped. No tile borrows another tank's name |
| **CDWT tanks** | Picking a tank makes a **ghost follow your cursor** again. It was asking your master for a block named after the tile caption — which can never exist |
| **Pit labels** | **The pit number moves with its circle.** This is the long-running "the label won't step out" — it *did* step out; the circle moved and the number stayed. It has been going to councils like that |
| **Pipe text** | Double-click pipe text on a job you have **just opened** and the Edit Pipe window opens. It used to need one edit first |
| **Levels** | Emptying a level box actually deletes it. The old number used to come back |
| **CDFIXTAGS** | Stops saying "Nothing to repair" after a run that failed, and tries every rename instead of stopping at the first |
| **Split pipes** | The split level lands at the pit it was split at, not back at the far end |
| **CDTWL** | Takes the level you designed to (18.54), not just a row number. Stops dropping 8 pits from the storage total |
| **Detention** | **The `0.00 m³ required` that reached a council drawing** now reads `NOT SET` |
| **Detention** | Permissible discharge starts empty instead of someone else's `5.24` |
| **CDLPD** | Typing `Council` gives COUNCIL PIPE, not COUNCIL STUB |
| **Edit windows** | The picture no longer redraws to show what Save would do — see the correction below |

## Three things I have to be straight with you about

### 1. The CDWT crash is NOT fixed

I told you last night the fixes chat carried "the CDWT crash fix". **That was wrong, and I got it from the
brief rather than from the chat's own record.** Its record says plainly that the crash's cause is **not
established** and **no fix was attempted** — CE's own error handling cannot see it and there is **no log line
for it at all**.

What *was* fixed is everything around it: the blank pictures, the ten missing tanks, the missing ghost.

**There is a 30-second probe for you** (it is step N9 on the Codex list): place a tank, and at the callout
prompt **press Enter instead of picking a point**. If it completes, the callout pick is the culprit. If it
still crashes, it is elsewhere and we need AutoCAD's own error report.

**Cost to you:** if you install this expecting the tank window to survive end-to-end, it may still fall over at
the callout point.

### 2. The preview you asked for is not back yet — I have written the plan, not the code

You chose **A — ghost on top**. The contract is written and published at
`01_MASTER_PLAN/CONTRACT_GHOST_PREVIEW_2026-09-18.md`.

**Nothing is built for it.** It needs a rule from me and the picture panel from Codex.

Also carried into it, because it was wrong before: **withdrawing the old preview did not fix the extra-Undo
fault.** That fault is still there and nobody knows what causes it. You lost the feature and did not get the
fix it was blamed for.

### 3. The split question — you were right, and it is already built that way

You asked whether split pipes should work like dropping a pit on a pipe. **They already use the identical
code** — same test for "is this sitting on the pipe", same splitting. The code even records your own words
from 15 September.

One consequence: there is a known gap in that shared code — when a pipe splits, **the pipe text is divided
between the two halves, so one half can end up with none.** Because it is shared, **dropping a pit on a pipe
has always had this same fault.** Not fixed, not in this payload. **Tell me if that is the one you have been
seeing** and I will take it next.

## What is ready for testing

**76 steps**, written for Codex to drive AutoCAD — `01_MASTER_PLAN/CODEX_TEST_RUN_2026-09-18.md`.

You said *"all 40 for codex so make sure it knows what to do"*. It is **76**, because four chats' work is in
this payload and the fixes chat landed after that number was given. **Nothing was dropped to make it tidier.**

It is written so it **refuses to start on the wrong build**, tells Codex about two things that would otherwise
look like new failures, and bans scores — four words only: PASS / FAIL / BLOCKED / NOT TESTED.

## Questions waiting on you — none were decided for you

1. **Three tiles read "PLAN VIEW (7560 x 4800 mm)", "… 2", "… 3".** Three genuinely different tanks in your
   master. Name them properly? *(That would be a change to your master, not to CE.)*
2. **Two tiles read "Untitled tank plan".** Leave them honest, or name them?
3. **The MELRO pair** — 4500 attaches to a 5600×1760 block, 5500 to a 4622×1760. A 5500 reading smaller than a
   4500 is odd. **The online check you asked for has still not been done.**
4. **`NOT SET`** in the ON SITE DETENTION CRITERIA block — my wording. What should it say?
5. **The street-note wrap width** — five versions were drawn for you on 17 September; you have not picked one.
6. **Should CDDESIGN outrank the Boyd's tab** when the two give different permissible discharges?
7. **CDTWL — should it become a window?** (your own question from Test Day, still open.)
8. **The computations sheet** — nobody has been given it. Do you want me on it?

---
---

# ▽ WORKING NOTES

## The payload

| | |
|---|---|
| Branch | `claude/civil-combine-2026-09-18` |
| Tip | **`0a84eb075baaf1609d6161faac0c487c8cd231fd`** |
| Pushed | yes — local == remote, tree clean |
| Installed | **not deployed.** Live remains `3.0.0+d0ffe1a2`, read back from the DLL |

### Merge trail

`c9dac1bc` (windows, base) → `c1302d82` (merge other-areas) → `ed5c7077` (merge K/L) → `0a84eb07` (merge fixes)

### Inputs, and the tips that moved

| Input | Handed | Merged | |
|---|---|---|---|
| windows/deploy `claude/civil-combined-2026-09-17` | `c9dac1bc` | `c9dac1bc` | — |
| other areas `claude/civil-other-areas-handoff-d747af` | `24d9230f` | `24d9230f` | forked **beside** the installed build at `e0cfe172` |
| K/L `claude/civil-k-l-2026-09-16` | `457bf032` | **`dc937001`** | **moved** — adds the K4 Council fix Tim asked for 18 Sep |
| fixes `claude/civil-fixes-2026-09-18` | `d95e7342` | **`c0ef58a6`** | **moved** — +2 commits while combining |

**Two of the four branches did not contain the installed build.** Building either alone would have dropped
fifteen commits Tim had already been told about — the 17 September failure mode, caught by checking.

## Proof held

1. **Builds:** net48, net8.0-windows, net10.0-windows — **0 errors**, rebuilt after **every** merge.
2. **Full net10 suite:** **10,052 run · 10,013 passed · 22 failed · 17 skipped** (2m38s,
   `combine-final-18sep.trx`). Failing **names** set-compared against the 20 recorded distinct names:
   **NEW failures: NONE · recorded failures now passing: NONE — identical.**
3. **Ancestry** (`git merge-base --is-ancestor … HEAD`): `c9dac1bc` ✓ `24d9230f` ✓ `dc937001` ✓ `c0ef58a6` ✓
   **and the installed `d0ffe1a2` ✓**.
4. **Pushed.**

**Confirmed by outcome, not by absence** (both were flagged "must confirm, do not write off"):
`PreviewPackage_AllSections_RetainsStatusAndUsesAdvisoryWsudAuthority` → **Passed** (both B and C predicted
BUG-158 `308ea803` would clear it once merged — upheld); `LoadAsync_ValidSinglePagePdf…` (known flaky) →
**Passed**.

**All eight of the fixes chat's new guard tests ran and passed**, including
`NoPitLabelMoverAssignsBlockPositionOnItsOwn` and `EveryPitLabelPathCallsTheSharedMover`.

## Conflicts, and how they went

- **`PipeEditCommand.cs` never conflicted** — the two chats edited different regions. Verified by hand anyway:
  `vm.DryRunPreview =` absent from both editors ✓, the separate `IsDryRunPreview` flag surviving ✓,
  `LevelBoxesAreAuthoritative` present ✓.
- **`REGRESSION_LOG.md` (×2) and `FLEET_STATUS.md`** — all chats prepend to a shared tail. **Both sides kept in
  full every time**; entries from all four verified present afterwards. One stray mid-file BOM stripped.
- **The fixes chat merged with no conflicts at all.**

## The fixes chat's claims — verified here, not taken on trust

It never wrote a Section 4 into `COMBINE_HANDOVER_2026-09-18.md`; Tim said it had finished. Its claims were
checked from the diff:

- **W-09 confirmed:** `SelectTankPlanBlocks` rebuilt each plan as `new PlanBlock(name, count)`, so the
  constructor's fallback put the **tile caption** into `SourceBlockName`. Now passed through as read.
- **W-10 confirmed:** de-duplication is now on the job block name, not the caption.
- **BUG-151 confirmed:** `applyPos = p => br.Position = p` (which never touched `AttributeCollection`) is now
  `AnnotationMoveService.MoveWithAttributes`, using `TransformBy(Matrix3d.Displacement(...))` so justified
  attributes carry their alignment point. Exactly the fix the K/L chat diagnosed and handed over.
- **Its own record contradicts the combine brief on the crash.** The brief said W-09/W-10 "fixes the CDWT
  crash"; the chat says the crash is **not claimed fixed**. **The chat is right and the brief was wrong.**

## A lead worth chasing — recorded, not claimed

The fixes chat's second probe reports **240 of 387** non-pit-label blocks on that drawing carry their text as
**attributes**, including `FALL`/`FALL_GRADE`, `LEVEL`, `DP`, `WT`. Two CE paths move those blocks the same way
the pit label was moved (`LinkService.AttachmentTransforms.ApplyAttachmentTransform`,
`PipeEditCommand.Attachments`) — **but they also set `Rotation`, so carrying the text needs a full transform,
not a displacement.**

This is a **strong candidate for register items O3 / O4 / O10 / O17** ("labels and arrows stay behind when a
pipe is moved or gripped") — which the other-areas chat investigated and explicitly **could not** explain.
**It is a hypothesis; nobody has reproduced those items against this cause.** Step **P7** on the Codex list is
what would turn it into a finding.

## Not merged, and why — stated so the gate is honest

Fourteen other branches carry commits not in this payload. **None was in my brief and none was assessed.** The
only one with substantial Claude-side Drainage work is **`claude/ce-autocad-civil-90-percent-db893b`** (18
commits, 10 touching Drainage, last commit **15 Sep 13:53**). It predates the installed build by a day and its
themes have been **redone since** — its C7 slices were superseded by the polyline rebuild (`C7-POLY`), and its
`9142a0da "BUG-151: the pit number sits inside its label circle again"` is an **earlier attempt at the very bug
the fixes chat has now root-caused and fixed differently**.

**Merging a 15 September branch over 18 September work would be actively dangerous**, so I did not. Flagging it
rather than silently leaving it out. The rest are Codex window branches (`codex/v3-windows-pipe-20260915`,
`codex/v3-ui-connections-20260915`) — Codex's lane under ruling B, not mine to merge.

## Deploy readiness (checked, not performed)

- `Installer/build_installer.ps1` and `Installer/Deploy-Local-AsAdmin.ps1` both present.
- **Native transform module already built in this worktree** —
  `Modules/Shared.Transform.Native2027/bin/x64/Release/CE_TRANSFORM_2027.arx` (75 KB, correctly named, built
  with `/p:ProductionIntegration=true`). Without it the net10 lane dies with `MSB3030`.
  **New detail for issue #78:** it must be built through **PowerShell** — Git Bash rewrites `/t:` and `/p:`
  into paths and MSBuild fails `MSB1008`.
- `acad.exe` **not running** at 22:41. **This is not authorisation** — it will be re-checked twice at deploy
  time, in Tim's presence, on his words.
- Remaining manual steps at deploy: **hand backup of the live bundle** (the script does not back up),
  **CE_SHARED sync into Manager** (the script does not sync it), and **Structural is not redeployed** — say so
  plainly.

## CE_PLAN commits tonight

| | |
|---|---|
| `6717852` | `PENDING_TESTS.md` — the combined payload, its proof, the moved K/L tip |
| `72eae8f` | `CODEX_TEST_RUN_2026-09-18.md` — the test pack |
| `ae73488` | `CONTRACT_GHOST_PREVIEW_2026-09-18.md` + pack updated for the fixes chat |

`PENDING_TESTS.md` still needs its COMBINED section updated from `ed5c7077` to `0a84eb07` — done in the same
commit as this pack.

---

## OVERRIDE RECORDED — 18 September 2026, ~23:00

**Tim:** *"overnight sequence for all fixes, improvements and completion of all tasks from all 4 chats"*, then
**"Go — all 8 items"** and **"No — just build"** (no deploy).

**Rule overridden and its scope:** the COMBINE chat's brief says *"YOU WRITE NO PRODUCT CODE. If you find a
fault, you record it and tell the owning chat."* Tim has overridden that **for this overnight block only**.
Scope: the eight behaviour items listed below, on branch `claude/civil-overnight-2026-09-19`. The gate-keeping
rules are **not** overridden — nothing is deployed, every claim is still proven by name, and windows remain
Codex's under ruling B.

**The frozen payload stays recoverable:** `claude/civil-combine-2026-09-18` @ `0a84eb07` is pushed and is NOT
moved by the overnight work. If the overnight branch goes wrong, that tip is still the deployable one.

**The eight items (Tim's order: all of them):**

| # | Item | Why it matters on a drawing |
|---|---|---|
| 1 | LPD note template stuck in saved settings (the R-00 hole) | Every LPD note on Tim's machine comes out short no matter what the code says |
| 2 | L13 — a locked layer lets the schedule run ahead of the drawing | Schedule says 19.50, drawing says 19.60. A wrong drawing goes out |
| 3 | P-05 — pipe text on **both** halves after a split | One length left with no size/material on it. Tim raised this himself on 18 Sep |
| 4 | L12 — a refused pipe does not say **which** pipe | Tim cannot find what to fix |
| 5 | Orifice standard detail carries the same anonymous-block trap W-07 fixed for tanks | A different detail drafted silently |
| 6 | Ghost preview **rule** (Tim's ruling A, 18 Sep) | Restores the preview he asked for, without a writer. Panel is Codex's |
| 7 | L10 — converted pipes write their record where it cannot be read back | Drawn level 17.35, schedule IL blank |
| 8 | FALL / LEVEL / DP / WT tags losing their text when moved — **probe first** | Candidate for register O3/O4/O10/O17. Hypothesis, not a finding |

**Not in scope, said plainly:** Codex's windows (label-fit, the PSD button, the CDWT rebuild); anything needing
AutoCAD open (the CDWT crash probe N9, the P-07 invert evidence run, L1/L4 with diagnostics on).
