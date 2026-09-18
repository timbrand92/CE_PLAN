# CE Civil — test run for Codex, 18 September 2026

**This is the ONE list for the 18 September payload.** It replaces nothing: the 17 September run
(`CODEX_TEST_RUN_2026-09-17.md`) covered the build that is installed **today**. This list covers the build that
replaces it.

**Tim's instruction, 18 September:** *"all 40 for codex so make sure it knows what to do"* — the whole list goes
to Codex in one run, not fed one area at a time.

**It is 76 steps, not 40.** Four chats' work is in this payload, and the fixes chat landed after the first
count was given. Nothing has been dropped to reach a tidier number.

---

## 0. DO NOT START UNTIL THIS IS TRUE

**This payload is NOT installed at the time of writing.** Step **S1** below tells you which build you are on.

| | |
|---|---|
| Build under test | `claude/civil-combine-2026-09-18` — the merge of **all four** Civil chats: windows/deploy, other-Civil-areas, K/L, and fixes |
| Its commit | recorded in `PENDING_TESTS.md` under **COMBINED 18 September 2026** |
| Build it replaces | `3.0.0+d0ffe1a2…` — that is what the 17 September run tested |
| Lane | **AutoCAD 2027 (net10 / Modern)** unless a row says **2024** |

**If S1 reports `3.0.0+d0ffe1a2…`, the new build is not installed. STOP.** Every step below is
**BLOCKED — payload not installed**. Do not test the old build against this list; that is how a pass gets
recorded against code that is not there.

---

## 1. Rules for this run — follow them exactly

1. **Work on COPIES of drawings.** Never the original. Many steps below deliberately change the drawing.
2. **Record one of four words per step: PASS · FAIL · BLOCKED · NOT TESTED.** Nothing else. **No score, no
   percentage, no "mostly working"** — a score is the one output that lets a real failure hide.
3. **A step with no observation recorded is NOT TESTED**, even if it obviously works. **Never infer one step's
   result from another.**
4. **Screenshot every window step and every step that says "looks like" or "reads".** Name the file by step ID.
5. **On a FAIL capture all five:** what you did · what you expected · what happened · the **exact command-line
   text** · the CE log lines from `%APPDATA%\CE_CVL_SUITE\logs\` for that minute.
6. **If AutoCAD crashes, say which step caused it, stop that section, carry on with the next.**
7. **Do not fix anything.** Report it and move on. You are producing evidence, not acceptance.
8. **Only Tim's word accepts anything.** Built · tested · installed · Tim-accepted are four separate facts.
9. **If you are stopped part-way** (usage limit, crash, time), **save the partial report** and mark every
   unreached step **NOT TESTED**. A partial honest report is worth more than a complete guessed one.

### Turn diagnostics ON before you start

Several steps below depend on log lines that are written only with diagnostics on
(`LoggingService.Diagnostic`). On 17 September a whole section could not be settled because they were off.
**Turn diagnostics on first and say in your report that you did.**

---

## 2. Test drawings

**The paths are NOT in this file on purpose.** They name real job folders, and client names and addresses never
go into a repository (**DATA-01**). They are in:

> **`C:\Users\TimothyBrand\CE_TEST_DRAWINGS_2026-09-17.md`**

**Work on COPIES, in a scratch folder, never in the job folders.**

If a drawing is not supplied, mark its steps **BLOCKED — no drawing**, **not FAIL**.

**Two drawings you will need that may not be listed:**

- **A drawing with three pits in a straight line** for the split steps (O37–O40). If none exists, **draw one** —
  three pits, one pipe through all three.
- **The real detention job from Test Day** for T5 — the one whose storage total came out **17,948 L** against
  **25,060 L** required. T5 is the only step that produces a number Tim can compare against something he has
  already seen.

---

## 3. Two things that are ALREADY KNOWN — do not report them as new failures

These are recorded faults with established causes. If you meet them, **note them and move on**; they are not
what this run is testing.

### 3a. The LPD note comes out short — it is a SETTINGS fault, not a code fault

Tim's live settings file `%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json` holds:

```json
"lpdStandardNote": "LPD - {connection}, IL {invert} m AHD"
```

That is the **old short template**, saved before the default changed on 15 September. The code only falls back
to the new default when the stored template is **blank**, so **a stored old value wins forever**.

**What this means for section T (T16–T21):** the note will read as **one short line**, e.g.
`LPD - COUNCIL PIPE, IL18.65mAHD`. **That is expected and is NOT the bug those steps test.** Those steps test
**which connection type is chosen** — whether the words say `COUNCIL PIPE` or `COUNCIL STUB`. Judge the
**connection wording only**, and ignore the line's shortness.

If you want the long wording for a screenshot, clearing the LPD note box on the Settings page restores it.
**Do not do this silently** — if you clear it, say so in the report, because it changes what later steps show.

### 3b. P13 — a cancelled editor window still costs one Undo

Open any CE editor window, **change nothing**, Cancel, press `U`: the Undo is still spent. First `U` reports
`CDEDIT`, a second reports your real edit.

**This is OPEN and its cause is NOT established.** It was previously blamed on the dry-run preview; that
diagnosis was **wrong** and has been corrected. The dry-run has been withdrawn in this payload for a different
and narrower reason (it was running the real writer and writing project data to the drawing while Tim typed).

**So: expect P13 to still happen. Do not record it as a regression, and do not record the dry-run withdrawal as
having fixed it.** If it behaves any differently from the above, that *is* worth reporting.

---

# PART S — start up (these gate everything below)

| ID | Step | What "right" looks like |
|---|---|---|
| **S1** | In PowerShell: `(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion` | **Record the full string.** It must **NOT** be `3.0.0+d0ffe1a2…` — that is the build this payload replaces. If it is, **STOP**: everything below is BLOCKED. |
| **S2** | Start AutoCAD 2027. Open a COPY of a drainage job. | CE ribbon tab appears. No error dialog, nothing reading "unable to load" on the command line. |
| **S3** | Type `CDINSPECTOR`. | It runs and reports. **If any CE command is "unknown command", stop — the plugin has not loaded and every step below is BLOCKED.** |
| **S4** | Turn diagnostics ON. | Say in your report that you did, and how. Several steps below need `LoggingService.Diagnostic` lines. |

---

# PART N — CDWT, the water-tank window (Tim's first priority)

**What changed — two separate fixes, and they interact.**

- **W-06** (windows chat): tank tiles were carrying **each other's names**. Five tiles all read
  `KINGSPAN 6000 L SLIMLINE METAL TANK` when three were really 3500 L, 5000 L and 6000 L.
- **W-09 / W-10** (fixes chat): CDWT was asking the master for a tank **by the caption printed under the
  tile**, which is not a block name and can never be found — so **every tile picture was blank**, **ten plans
  were missing**, and **no ghost followed the cursor**. The picker was also filtering to captions containing
  the word TANK, against Tim's 14 September ruling that it shows **everything** in his master.

> ⚠️ **The CDWT CRASH IS NOT FIXED.** Tim's 16 September run ended in *"AutoCAD cannot continue"* when he
> picked the callout point. The fixes chat states plainly that its cause is **not established** and that no
> fix was attempted — CE's own error handling cannot see it and **no CE log line exists for it**.
> **Step N9 is a 30-second probe to narrow it. If it crashes, that is expected, not a new fault — record it
> and move on.**

| ID | Step | What "right" looks like |
|---|---|---|
| **N1** | Type `CDWT`. **Count the tiles.** | **39 tiles**, not 29. **Record the number you actually see.** |
| **N2** | Look at every tile picture. | **Every tile has a picture. None blank.** (All were blank on 16 September.) |
| **N3** | Look for **GRAF CARAT**, **AQUARIUS**, **WT1** and **PLAN VIEW**. | All present. These were silently dropped before. **Say which, if any, are still missing.** |
| **N4** | Read every tile caption. | **No two tiles carry the same tank name at different sizes.** Exactly **one** reads `KINGSPAN 6000 L SLIMLINE METAL TANK`. **No caption starts with a code** like `xsm1;`. **List every caption in your report.** |
| **N5** | Find the three tiles reading **"PLAN VIEW (7560 x 4800 mm)"**, **"… 2"** and **"… 3"**. | All three present and numbered. They are three genuinely different tank plans in Tim's master — **not** duplicates. (Tim is deciding whether to name them properly; that would be a change to his master, not to CE.) |
| **N6** | Find the **4500 MELRO** and **5500 MELRO** tiles. Note the block dimensions each is attached to. | Expected: 4500 → **5600×1760**, 5500 → **4622×1760**. **Report what you actually see.** A 5500 L tank measuring smaller than a 4500 L one is odd and Tim needs the numbers. **Do not judge which is right — just report.** |
| **N7** | **The tile that failed on 16 September.** Pick **2510L UNDERDECK WATER TANK**, set a detention share, press **Place tank**, pick an insertion point. | **A ghost of the real tank follows the cursor.** This is the exact tile whose log read *"The master drawing no longer contains the plan block …"*. |
| **N8** | Finish that placement: callout point, Base RL, riser, dropper. | **The tank block that lands is the one in the picture.** |
| **N9** | **THE CRASH PROBE — do this one carefully.** Place a tank again, but at the callout prompt press **Enter** instead of picking a point. | **If it completes:** the callout pick is implicated — say so clearly, that is the finding. **If it still crashes:** the cause is elsewhere — **attach the AutoCAD error report from that run**, which is the only evidence that exists. Either way this is **not a new fault**. |
| **N10** | Settings → point the Standard Details folder at an **empty** folder → `CDWT`. | Reads **"No tank plans found"**, **names the drawing** CE opened, offers **both** ways to carry on. **No empty black panel.** "Tag a block already in the drawing" still asks for the block. **Put the folder back and confirm the tiles return.** |
| **N11** | Nothing to do in normal use. **If** `CDWT` prints a warning about the tank detail: | *"The usual water tank detail was not in … CE used the biggest tank detail it could find instead"*. **Quote it exactly if it appears.** Silence is also a pass. |

---

# PART P — the pit number that stayed behind (P12 / P14 / BUG-151)

**What changed, and why it has been so hard to catch.** The pit label is a block holding a **wipeout** (that is
the circle you see) plus the number as an **attribute**, which carries **its own position**. All three CE
movers moved the block and never touched the attribute — so **the circle stepped out and the number stayed
put**, and the drawing read as a label that had not moved. **This is the long-running "the pit label won't
step out" report.** It did step out. Nobody was looking at the number.

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **P1** | Open a job. Note where **P10**'s number sits inside its circle. | — | 2027 |
| **P2** | `CDEDIT` on **P10**. Change **450×450 → 1200×1200**. **Save.** | **The circle AND the number move together**, number still centred in the circle. | 2027 **and 2024** |
| **P3** | Undo. `CDEDIT` **P10** again, change **only the label corner** (Top right → Bottom right). **Save.** | **The number goes with the circle.** No resize at all in this one — that is the point. | 2027 **and 2024** |
| **P4** | Do the same on a pit whose label uses the **other** block (`PIT LABEL`, e.g. **P1** or **C1**). | Same result. Both label blocks must behave. | 2027 |
| **P5** | **Resize two pits at once** (the batch path). | **Both** numbers travelled. | 2027 |
| **P6** | After any one of the above: one accepted change = **one Undo**. | *(The separate cancelled-window Undo fault — §3b — may still appear. Record what you see; it is not this fix's job.)* | 2027 |
| **P7** | **A lead worth checking, NOT a claimed fix.** **MOVE** a pipe that has a `FALL` or `LEVEL` tag on it, and separately **grip** one. Watch the text inside those blocks. | **Report exactly what the text does.** A probe found **240 of 387** blocks on that drawing carry their text as attributes the same way the pit label did — so the same fault may affect FALL / LEVEL / DP / WT tags. **This is a hypothesis, not a finding, and it is NOT fixed.** Your observation is what turns it into one. | 2027 |

---

# PART O-A — double-clicking pipe text (O16–O23)

**What changed:** on a job you had **just opened**, double-clicking a pipe's own text gave AutoCAD's plain text
editor instead of the Edit Pipe window. It only started working after you had edited that pipe once in the same
session.

> **The whole point of O16 is that you have edited nothing yet. Open the drawing and go straight to it.**

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **O16** | Open a **fresh copy** of a job with pipes. **Edit nothing first.** Double-click an `IL 19.40` text. | The **Edit Pipe window** opens on that pipe, with **19.40** in the level box. Previously: AutoCAD's plain text editor. | 2027 **and 2024** |
| **O17** | Escape out. Double-click the **same** IL text again. | The window opens again. Not a refusal, not the text editor. | 2027 |
| **O18** | Double-click a pipe text such as `225 DIA. UPVC PIPE AT 1 IN 100`. | Edit Pipe window opens. | 2027 |
| **O19** | Double-click a pit's `CL 19.65` cover text. | **Edit Pit** window opens, exactly as before. (Pits must be unchanged.) | 2027 **and 2024** |
| **O20** | Double-click a note in the title block that **CE did not draw**. | **AutoCAD's own text editor** opens. **If the Edit Pipe window opens on it, STOP and report** — CE would be claiming text that is not its own. | 2027 **and 2024** |
| **O21** | Double-click the **pipe itself**. | Edit Pipe window, as before. | 2027 |
| **O22** | Open a drawing with **no CE pipes**. Double-click any text. | AutoCAD's editor. **Also say whether opening the drawing felt slower**, and by how much if so. | 2027 |
| **O23** | **Evidence step — nothing is claimed fixed here.** Open a pipe, **change a level**, press **OK**. | **Whatever happens, record it:** the exact command-line text, and the log for that minute. Two new log lines now record *Cancel/Escape* and *"OK pressed but nothing changed"*, with both levels as held and as read in. This step is how the open question *"changing an invert does nothing"* gets settled. **PASS/FAIL is less important than the log — send the log either way.** | 2027 |

---

# PART O-B — blanking a level actually deletes it (O24–O29)

**What changed:** emptying a level box did not delete the level. The old number came back — from the pipe's own
record **and** from the schedule row.

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **O24** | Pick a pipe with **both** levels. Note them in `PITSCHEDULE`. Double-click it, **empty the downstream box**, OK. | The IL text leaves the plan **AND** `PITSCHEDULE` shows that level **blank** — not the old number. **Re-open the pipe: the box is still empty.** All three must be true. | 2027 **and 2024** |
| **O25** | Press `U` **once** after O24. | The level returns **on the plan and in the schedule**. | 2027 |
| **O26** | Empty **both** boxes, OK. | Both gone from plan and schedule. The pipe **still runs between the same two pits** and its pipe text still reads size and material. | 2027 |
| **O27** | **The guard.** Type `19.4O` — **letter O, not zero** — in a level box, OK. | **Nothing is deleted.** The stored levels stay exactly as they were. **Say what the command line said.** A mistyped level must never be read as "delete this". | 2027 |
| **O28** | **The other guard.** On a pipe with both levels, tick **simple pipe only**, OK. | The texts come off the plan but `PITSCHEDULE` **still shows both levels**. Untick: still there. "Just draw the pipe" must never delete a level. | 2027 **and 2024** |
| **O29** | On a pipe that has **only ONE** level, run `CDLPD`, then a pit move, then `CDREPAIR`. | The other level must **not** be wiped by any of the three. | 2027 |

---

# PART O-C — CDFIXTAGS stops contradicting itself (O30–O36)

**What changed:** it printed *"Nothing to repair"* **after a run that had failed**, and it stopped at the first
awkward block instead of trying the rest.

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **O30** | Same drawing as 16 September. `CDFIXTAGS` → **Yes**. | The words **"Nothing to repair" must NOT appear anywhere** after a Yes. | 2027 **and 2024** |
| **O31** | Read the summary it prints. | **One** summary: either *"N blocks were renamed: …"* or *"No block was renamed."*, then *"N was/were not renamed:"* and **one line per block**, each with the block number and a plain-English reason **ending in what to do** (`CDTAG` or `CDREPAIR`). **Quote it in full.** | 2027 |
| **O32** | Count the renames. | One awkward block used to stop all the rest. **Count how many of the three get renamed now and report the number.** | 2027 |
| **O33** | Do what the reason line says (usually `CDTAG` the other block), then run `CDFIXTAGS` again. | It renames the rest. | 2027 |
| **O34** | `CDFIXTAGS` on a drawing with **no repeated names**. | *"Every source name in this drawing already names one block. Nothing to repair."* — **that sentence is correct here** and must stay. | 2027 |
| **O35** | Run it and answer **No**. | *"Nothing was renamed."* and nothing changes. | 2027 |
| **O36** | **Send the log.** | A new `[SourceClaims] refused:` line names **which piece of text is claimed twice and by which blocks**. **This decides whether the refusal is right or whether it is the next bug.** Needs diagnostics ON (step S4). | 2027 |

---

# PART O-D — split levels land at the right pit (O37–O40)

**What changed:** when a pipe drawn across several pits was split, one of the two split levels was drawn back at
the **far end** of the pipe, on top of a different level.

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **O37** | Three pits in a line, left to right. `CD` **ONE** pipe through all three (19.45 → 19.25). Answer **Yes** to the split. | **Both `IL 19.35` texts beside the MIDDLE pit** — one just above the pipe, one just below. **Not** one back at the first pit. | 2027 **and 2024** |
| **O38** | Same run drawn **right to left**. Split it. | Levels still at the middle pit. | 2027 |
| **O39** | A **north–south** run through three pits. Split it. | Levels at the middle pit. | 2027 |
| **O40** | Look at the two split levels together. | They are on **opposite sides** of the pipe and do not overlap. | 2027 |

---

# PART T-A — CDTWL takes the engineer's own level (T1–T5)

**What changed:** asked which level is the top water level, `CDTWL` only accepted a **row number**, so typing the
level the job was designed to (18.54) got *"1 or 2 only"* and the engineer was stuck.

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **T1** | `CDTWL` → outlet → volume → at *"Which level is the top water level?"* type **`18.54`**. | **Accepted.** It must **NOT** say *"1 or 2 only"*. The report says *"your own level, not one CE measured off the drawing"*. | both |
| **T2** | Run again, type **`1`**. | Picking by row number works exactly as before. | both |
| **T3** | Type a level **above the lowest lid**. | **Accepted**, plus a warning: *"Careful: that is ABOVE the lowest lid in this system (…), so water would come up out of it."* **Warned, not blocked.** | both |
| **T4** | Type **`banana`**. | *"neither one of the numbers above nor a level. Nothing was worked out."* — refused cleanly, nothing written. | both |
| **T5** | **The important one.** On the **real detention job from Test Day**, run `CDTWL`. | Far fewer pits left out. Pits that are now counted say *"…so its floor was taken from the pipes that meet it (19.200)"*. Storage total **higher than the 17,948 L** Tim saw. **Report the new number, and how many pits and how many pipes are STILL left out.** (Pipes are expected to still be left out — that part is knowingly unfinished.) | both |

---

# PART T-B — the zero that reached a council drawing (T6–T11)

**What changed, and why it matters:** a new detention system was born with its required-volume box holding the
text `"0.0"`. The ON SITE DETENTION CRITERIA block then printed **`VOLUME REQUIRED  0.00 m3`** — **a figure, on a
block a council reads, saying the system is required to hold nothing.** A reviewer comparing storage against
"required 0.00" would find it passes trivially.

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **T6** | `CDCALC` → Detention → **add a system**. | Volume required box is **empty**, not `0.0`. Status reads *"Enter required volume to compare."* | both |
| **T7** | Type `25.06`, save, run `CDTWL`. | *"CDCALC records the volume required for this system as 25.06 m3. Press Enter to use it…"* — and **Enter actually accepts it**. | both |
| **T8** | `CDTWL` on a system with **no** volume. | *"CDCALC has no volume recorded for this system yet…"*. **Must NOT say "not a plain number"** — that was untrue and unhelpful. | both |
| **T9** | Pick an outlet that **no** CDCALC system names. | *"CDCALC has no detention system recorded against this outlet…"*. **It must not go quiet** — silence was the old behaviour. | both |
| **T10** | **The drawing block.** Insert ON SITE DETENTION CRITERIA for a system with **no** volume. | Reads **`VOLUME REQUIRED   NOT SET`**. **Must NOT read `0.00 m3`.** **Screenshot this one.** (`NOT SET` is proposed wording, not recovered from a CE drawing — Tim is deciding it.) | both |
| **T11** | Open a job **already filled in**. | Its volume still reads exactly what Tim typed. **CE must not rewrite an engineer's records.** | both |

---

# PART T-C — the permissible site discharge stays empty (T12–T15)

**What changed:** every new detention system started with a PSD of **5.24 l/s hard-coded** — a real figure from
somebody else's job, indistinguishable on screen from one worked out for this one, **and it sizes the orifice**.

⚠️ **Jobs saved before 17 September still hold `5.24`.** CE does not rewrite an engineer's records, so any job
not checked since is worth a look. **That is expected behaviour, not a failure of these steps.**

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **T12** | `CDCALC` → Detention → add a system. | PSD box **empty**. **Must NOT read `5.24`.** | both |
| **T13** | Fill the Boyd's tab so it works out a PSD. | The Detention PSD box is **still empty**. CE **offers**, never applies. (The one-click "use it" button is Codex's window work and is **not built** — its absence is not a failure.) | both |
| **T14** | Type your own PSD, then change the Boyd's figure. | **Yours stays.** A typed figure is never overwritten. | both |
| **T15** | Save and reopen. | An empty PSD is still empty; a typed one still reads what you typed. | both |

---

# PART T-D — CDLPD, typing `Council` (T16–T21)

**What changed:** typing `Council` produced **COUNCIL STUB**, not COUNCIL PIPE. The command handed the choice to
AutoCAD's own keyword matcher, which matched the typed text **before CE ever saw it** — `Council` is a prefix of
four offered words, so the right branch was unreachable. CE now reads the raw text and decides for itself.

> **Read §3a first.** The note will come out as one short line because of the stuck settings template. **Judge
> the connection wording only** — `COUNCIL PIPE` vs `COUNCIL STUB` — not the line's length.

> **Known trade, not a fault:** this question **loses AutoCAD's right-click keyword menu**. The choices are still
> printed and shortenings still work. **Do not report the missing right-click menu as a failure.**

| ID | Step | What "right" looks like | Lane |
|---|---|---|---|
| **T16** | **The bug.** `CDLPD` → pipe end → label point → type **`Council`**. | Note says **COUNCIL PIPE**. **Must NOT say COUNCIL STUB.** | both |
| **T17** | Type `CouncilStub`, then `CouncilPit`, then `CouncilPipe` — each in a separate run. | Each gives **its own** wording. | both |
| **T18** | Type **`CouncilP`**. | *"CouncilP could mean CouncilPit or CouncilPipe. Nothing was written…"* — **and nothing is placed.** An ambiguous shortening is **refused, not guessed**. | both |
| **T19** | Type **`K`**. | KERB & CHANNEL. Unambiguous shortenings still work. | both |
| **T20** | Press **Enter** with nothing typed. | KERB & CHANNEL — the default still works. | both |
| **T21** | Type `Other`, then your own wording. | Your words go on the note. | both |

---

# PART X — the 2024 lane

**Tim ruled that 2022–2024 users are in scope.** Every row marked **2024** above must also be run on AutoCAD
2024, on a copy.

| ID | Step | What "right" looks like |
|---|---|---|
| **X1** | On **AutoCAD 2024**, repeat: **O16, O19, O20, O24, O28, O30, O37**, and **T1, T6, T10, T12, T16**. | Same results as 2027. **Report each separately** — do not write "same as 2027" without running them. |
| **X2** | Say plainly whether the 2024 lane loaded at all. | If the plugin does not load on 2024, **X1 is BLOCKED, not FAIL**, and say so at the top of your report. |

---

# PART Z — regression sweep (do this last, it is the most valuable section)

**The 16 September Test Day failed because a large batch was installed and most of what it carried did not work.
These steps are here to catch that shape of failure early.**

| ID | Step | What "right" looks like |
|---|---|---|
| **Z1** | Open a job you know well. **Change nothing.** Look at it. | Nothing has moved. No label has jumped, no text has doubled, no pipe has lost its outline. |
| **Z2** | `PITSCHEDULE` on that untouched job. | Reads the same as it did before the install. **Any movement at all is a fault** — report the before and after. |
| **Z3** | Draw one new pipe with `CD` between two pits, with levels. | Pipe, text, arrow and levels all land. One `U` removes the whole thing. |
| **Z4** | Double-click that new pipe, change the diameter, OK. | The pipe text reads the new size. One `U` puts it back. |
| **Z5** | `CDCALC` → Export PDF → **open the PDF and look at it.** | Page 1 is the CE letterhead sheet. **No `Note:` in front of every line, no blank first page.** (This is the fault that had 27 green tests against text nobody had ever printed — **open the PDF, do not trust the export succeeding.**) |
| **Z6** | Run `CDINSPECTOR` on a job with CE records. | Reports without error. |

---

# HOW TO REPORT

One file. One row per step ID, in order, with **exactly one** of PASS · FAIL · BLOCKED · NOT TESTED, and the
observation you actually made.

```
| ID  | Result     | What you observed                                    | Evidence |
|-----|------------|------------------------------------------------------|----------|
| S1  | PASS       | ProductVersion read: 3.0.0+<...>                     | -        |
| N1  | FAIL       | Two tiles both read "KINGSPAN 6000 L SLIMLINE..."    | N1.png   |
| N3  | NOT TESTED | Did not reach this step                              | -        |
```

**At the top of the report, state:**

1. The **exact ProductVersion string** from S1.
2. Whether **diagnostics were ON**.
3. Which **drawings** you used (by their label in the drawings file — **never the job address**).
4. Whether the **2024 lane** loaded.
5. A plain count: **how many PASS, how many FAIL, how many BLOCKED, how many NOT TESTED.** Four numbers.
   **Not a percentage and not a score.**

**Do not summarise the run as "mostly working" or give it a mark out of ten.** Tim needs to see which specific
things failed, because he tests the failures himself.

---

## What this run does NOT cover, stated so nobody assumes it does

- **The pipe import (`CDIMPORTXCIVIL`)** has had no code change since 3 July, was not in the 16 September Test
  Day, and is on **no** pending test list — yet every imported pipe now goes through the same path `CD` uses and
  becomes a CE pipe object. **Nobody has run an import since that change.** It is a standing risk, not part of
  this payload.
- **`CDIMPORTLANDXML` reads 0 pipes** from a real Civil 3D export. That finding is on a different branch and was
  not re-verified.
- **The CDWT crash (W4).** The fixes chat's own record states its cause is **not established** and **no fix was
  attempted**. **N9 is a probe to narrow it, not a test of a fix.** A crash there is expected, not a regression.
- **The FALL / LEVEL / DP / WT tags losing their text when moved or gripped.** Named in **P7** as a lead only.
  Not diagnosed against those symptoms, not fixed.
- **The pipe import (`CDIMPORTXCIVIL`)** — see above. Still a standing risk, still not in this payload.
