# CONTRACT — split-on-draw moves into the CD window as a tick (P-01)

**Written 18 September 2026 by the "other Civil areas" chat (behaviour side).**
**Codex builds the window from this. This chat builds the behaviour behind it and does not touch the window.**

---

## 1. Tim's ruling

Test Day, 16 September, P-01:

> *"Split-on-draw asks at the wrong time — only after the CD window, and the question and answer are messed up."*

Question put to him 17 September with the recommendation below. Tim, 18 September 2026:

> **"ask inside the CD window as a tick"**

## 2. What changes, in one line

The command-line question **"split this pipe at the pits it runs across?"** stops being asked. The same choice
is made **before** the pipe is drawn, as a **tick in the CD window**. The splitting itself still happens after
the pipe exists — that part does not move, and §6 says why.

## 3. Kept / Moved / Retired — nothing is retired without Tim's word

| Today | What happens to it |
|---|---|
| Command-line question *"Split at the N pit(s) it crosses? [Yes/No]"* | **MOVED** into the CD window as a tick. Not retired — the same decision, asked earlier. |
| `Yes` / `No` answer | **MOVED** — the tick is the answer. |
| Enter = Yes (the default) | **KEPT** as the tick's starting state (see §4). |
| **Escape at the question = nothing split, pipe left whole** | **NEEDS TIM'S WORD — see §7 question 2.** With a tick there is no separate Escape moment. |
| "Remember for this drawing" | **KEPT** exactly as it is — the tick's state is remembered for that drawing only. |
| Settings page default for a new drawing | **KEPT** — `Settings ▸ Pipe ▸ SplitAtCrossings`. |
| The one summary line on the command line after a split | **KEPT.** R-27: warn and record, never go silent. |

## 4. The tick itself — what Codex builds

- **Where:** the CD window (new pipe), in the same group as the other drawing choices (pipe text, flow arrow).
- **Wording (recommended, Tim can change it):** **`Split where it crosses pits`**
  With the quieter second line: *"Each length between pits becomes its own pipe, with its own levels and its
  own schedule row."*
  No software words — plain-English UI rule.
- **Starting state when the window opens** — resolved by the behaviour side and handed to the window, so the
  window never works it out itself:

  | Stored value for this drawing, else the Settings page | Tick opens as |
  |---|---|
  | `Always` | **ticked** |
  | `Never` | **unticked** |
  | `Ask` (today's factory default) | **ticked** — because Enter at the old question meant Yes, so this keeps today's behaviour |

- **The tick is always visible and always enabled.** It is never greyed out, even when CE cannot yet know
  whether the route crosses anything — the route may not be picked yet. R-27: no hard blocks.
- **No-scroll rule:** it is one line; it must not push anything off the window.

## 5. What the behaviour side does with it (this chat owns all of this)

1. The window returns the tick's state with the rest of the pipe's choices.
2. `CdCommand` draws the pipe exactly as it does now.
3. `PipeCrossingSplitService.SplitNewPipeAtCrossings` is then called as it is now, **but never asks anything**.
   The tick is the answer:
   - **ticked** → split at every pit the pipe crosses;
   - **unticked** → do not split.
4. The tick's state is written to **this drawing only** (`ProjectData.SplitAtCrossings`, as `Always` / `Never`),
   so the next pipe in the same job opens with the tick where he left it. **The Settings file is not touched** —
   that is the existing SPLIT-01 ruling and it stands.
5. **The pipe crosses nothing** → nothing is split and **nothing is said**. (Acceptance step 55.)
6. **Batch mode:** the window is shown once and several pipes are drawn. The tick applies to **every pipe in
   that batch**, and is not asked again between them. (Acceptance step 53.)
7. **Only `CD` uses the tick.** Pipes made by the import, by `CDFW`, or by a pit being dropped onto a pipe are
   unaffected — none of them calls this service today and none should start.
8. The command line still prints **one** line saying what happened, and names anything it could not split and
   why, in plain English.

## 6. Why the splitting itself does NOT move earlier

The halves are linked to the pits they now end at. That linking needs the pipe to exist in the drawing first.
Moving the split before the pipe is drawn would leave the halves unlinked — one schedule row instead of three,
and no levels at the pits in between, which is the very fault split-on-draw was built to cure (15 Sep).
**So: the decision moves; the work does not.**

## 7. Open — needs Tim before Codex builds

1. **The wording on the tick.** Recommended: **`Split where it crosses pits`**. One word from Tim settles it.
2. **What replaces Escape?** Today, Escape at the question leaves the pipe whole and splits nothing
   (acceptance step 56). With a tick there is no separate moment to escape — Cancel on the window means no pipe
   at all. **Recommendation: accept that, because the tick can simply be left unticked**, and retire step 56 as
   written. **That is a retirement, so it needs Tim's explicit word. Not assumed.**

## 8. One thing the behaviour side must prove before this ships

**One accepted operation = one Undo.** The split currently runs as a separate step after the pipe is drawn, so
a single `U` may undo only the split and leave the pipe behind, or vice versa. **I have not verified which, and
I am not claiming it works.** Before this is called done, this chat must check that one `U` after a ticked draw
removes **the pipe, its halves and all their labels together**, and fix it if it does not.

## 9. Acceptance — replaces steps 52–56 of the 16 Sep list

| # | Test | Expect |
|---|---|---|
| 1 | Three pits in a line. `CD`, tick **on**, draw one pipe through all three | **No question at the command line.** Four pipes, four schedule rows, middle pits have a pipe in and out |
| 2 | Draw another across pits in the same job | Tick is still on, still no question |
| 3 | Untick it, draw another across pits | Stays one pipe. Nothing said beyond the one summary line |
| 4 | Close and reopen the job, `CD` | Tick opens where he left it |
| 5 | A brand-new drawing | Tick opens from the Settings page value |
| 6 | A pipe that starts and ends on pits but crosses nothing, tick on | Nothing split, nothing said |
| 7 | Batch mode, tick on, three pipes | All three split, asked once |
| 8 | `U` once after a ticked draw | **Pipe, halves and labels all go together** (see §8) |
