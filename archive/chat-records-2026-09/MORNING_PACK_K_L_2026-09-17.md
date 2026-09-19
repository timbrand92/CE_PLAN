# Morning pack — Civil sections K and L — 17 September 2026

**Branch `claude/civil-k-l-2026-09-16`, tip `0ed39495`. Pushed. NOTHING DEPLOYED — AutoCAD is exactly as you
left it (still `6505fb5a`, read back from the DLL).**

All six items you listed are **built and unit-tested**. **None has been opened in AutoCAD by anybody.**
Built · tested · installed · Tim-accepted are four separate facts, and only the first two are true of this.

---

## 1. BUILT — the six items, in your order

| # | What you asked for | What it does now |
|---|---|---|
| **61** | `CDLPD` has no "Council Pit" | **Council Pit is on the list.** And the list is now in ONE place — there were two copies, which is how it went missing. |
| **62** | The note should be an MLeader like the pipe callout | **It is.** Same arrow, dogleg and style, the leader points at the **pipe end**, and it **wraps to about five lines** instead of running across the sheet. |
| **63** | No invert set → no level in the note | **The level clause disappears completely.** No `IL`, no `0.00`. A zero, a dash or "Unknown" all now mean "not set". |
| **64** | Pit label steps out; pipe connections don't move | **The pipe ends now come back onto the new pit edge.** Root cause found and it was exact — see below. |
| **66** | Tank storage counted in the detention total | **Every tank is counted**, not just the first. A three-tank job was reporting one. |
| **67** | Hand-set invert, propagate, drawing and record agree | **Two more ways they could drift apart are closed**, and nothing is skipped in silence any more. |

### The two root causes worth knowing about

**Item 64 — why the pipes never moved.** The routine that pulls pipe ends onto a pit's outline could only be
reached when a pit was **MOVED**. Nobody ever called it when a pit was **RESIZED**. So a 450 pit grown to 1200
grew out over its own pipe ends and left them behind. **Your own log proves it** — the 09:32 resize of pit P8
on 16 September shows the block updating, both labels shifting, and no pipe adjustment at all.

**Item 67 — why the drawing and record disagreed.** Two things. The schedule was written *outside* the
drawing's transaction, so a cascade that failed rolled the drawing back and left the schedule holding the new
levels. And a **converted pipe** (the new CE pipe object) was dropped silently by the propagation, because the
code asked for an old-style pipe and got nothing back. On the drawing you tested, `CDC7UPGRADE` had converted
**51 pipes** — so a cascade there could move every pit and not one pipe, and say nothing.

---

## 2. TEST THIS — in AutoCAD, after it is installed

Full step-by-step for each item is in the plugin's `REGRESSION_LOG.md`, newest first. The short version, in
the order worth doing:

### A · `CDLPD` — 5 minutes

1. Open a drawing with a pipe running out to the street, **with a level on that end**.
2. `CDLPD` → Enter → click the pipe near the street end → pick a label point **well away from the pipe**.
3. At *"What does this discharge into?"* — **check `CouncilPit` is in the list**. Type it.
4. **Right looks like:** the note sits where you picked, **wrapped over about five lines**, with a leader and
   arrow running back to the **pipe end** — the same look as a CD pipe callout. Not one long line. The leader
   must not shoot off across the drawing.
5. **Now the important one:** do the same on a pipe end with **no invert set**.
   **Right looks like:** `CONNECT TO COUNCIL STUB TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS PRIOR
   TO THE COMMENCEMENT OF WORK.` — **no `IL`, no `0.00`, no gap where the level was.**
6. Run it once more and choose `CouncilPipe`. **Right looks like:** `CONNECT TO COUNCIL PIPE AT APPROX …` runs
   on as one sentence. It must **not** break the line straight after the word PIPE.

### B · `PITEDIT` resize — 5 minutes, and this is the one that was broken

1. Find a **450 pit with at least two pipes running into it**. Zoom in so you can see where each pipe meets
   the pit outline.
2. `PITEDIT` it. Set the plan size to **1200 × 1200** — **change both boxes.** Save.
3. **Right looks like:** the outline grows, **and every pipe now stops at the new bigger outline.** No pipe end
   stranded inside the pit, none poking through.
4. **Right looks like:** the label circle and the cover text have both stepped out, keeping the same clear
   distance from the pit edge.
5. **Undo once.** Size, label, cover text and pipe ends all go back.
6. Now shrink a 1200 back to 450 — label and cover come back **in**, pipe ends come back in with them.

### C · `CDTWL` tanks — 5 minutes

1. Open a job with **two or more water tanks on the same detention system**. Run `CDTWL`.
2. **Right looks like:** the storage total is **bigger** than before, and it says *"This system has 2 tanks
   (WT1, WT2). All of them are counted in the storage."* It must **not** say *"Only WT1 is counted"*.
3. Check a **one-tank** job as well — its total must be **unchanged**.

### D · Propagation — 10 minutes

1. On a drawing with **no** converted pipes: open a pipe, type an invert by hand, save. Run `CDPROPAGATE` from
   the downstream pit.
2. **Right looks like:** it tells you which levels you set by hand and asks whether to keep them; after Apply,
   **the level on the drawing and the level in the schedule are the same number.** Check two or three pipes by
   opening them.
3. **Undo once.** Everything goes back together — and the schedule goes back with it.
4. On a drawing where you have run `CDC7UPGRADE`: run `CDPROPAGATE`. **Right looks like:** if any pipe could
   not be updated, a line at the top **names those pipes**. It must not quietly report success.
   **Send me that line** — it is the evidence for the one part that is not finished (see §3).

**Both lanes.** Everything above should be done in **2027** first. **2024 (net48)** builds clean but has not
been run; do a pass when you are ready.

---

## 3. NEEDS TIM — decisions and one unfinished piece

### Five questions. Each has my recommendation; none has been decided for you.

| # | Question | My recommendation |
|---|---|---|
| 1 | **Should the drawing say `COUNCIL PIT` or `EXISTING COUNCIL PIT`?** Your finished drawings have no example of this note — the two I recovered are COUNCIL STUB and EXISTING STUB. Your council write-ups say *"existing Council pit"*. | I used **`COUNCIL PIT`** — your own words on Test Day. One line to change. |
| 2 | **What layer should the LPD note be on?** It is one MLeader on `25DIMS`, the layer the code already used. Your finished drawing has the note text on `25TEXT` and the leader on `25DIMS` — one object can only be on one layer. | Leave it on `25DIMS` unless it looks wrong to you. |
| 3 | **Is the note the right width?** It wraps at 18.7 text heights, measured off your own job 2648 (width 4671 at text height 250, about five lines). It is a Settings number. | Look at it and tell me wider or narrower. |
| 4 | **Two tanks on one detention system are now added together.** The old code had a note saying *"a second tank needs its own outlet"*, so somebody once doubted this. | Add them — they both hold water. But it is an engineering call and it is yours. One line back if you disagree. |
| 5 | **`PITEDIT` — did you change both size boxes or one?** Both resizes in your 16 Sep log show the **Y side growing and the X side not changing**. | Nothing to decide — just tell me when you test B above. The log now records the size **from** and **to**, so it will answer itself next time. |

### One piece is NOT finished, and it needs the other Civil chat

Item 67 reaches converted pipes now, but **writing each pipe's own stored record** still goes through code
that belongs to the other Civil chat (`LinkService.Persistence.cs`), and reading it, that write does not reach
a converted pipe. **I have not proved it in AutoCAD and I have not touched their file.**

**What that means for you:** on a drawing whose pipes have been converted, a propagation will update the pit
levels, the drawing text and the project record, and **may** leave each pipe's own stored record on its old
levels. It is no longer silent — the pipes get named — but it is not complete. Written up for them in
`FLEET_STATUS.md` on my branch.

### Honest note — the thing most worth your eye

The LPD note is now a **wrapped** MLeader. The pipe callout's leader-landing geometry has never been drawn
with a wrapped block of text before. The code is documented to measure the block and adjust, and the wrap is
applied where that measuring happens — **but I have not watched it happen.** If the leader lands oddly against
the five-line note, that is why, and it is a small fix.

---

## 4. What I got wrong overnight, and caught

The block ended with an audit over its own work. **Three faults in my own changes**, all fixed before you saw
them, all written up in `REGRESSION_LOG.md` under `AUDIT-K-L`:

1. The pit-resize re-snap would have fired **on every preview keystroke**, dragging pipe ends about while you
   were still typing in the window. Moved onto the Save path only.
2. The propagation fix changed how an ordinary pipe is opened, which could have **broken propagation for
   everybody** to fix the converted case. Put back to exactly the old behaviour for ordinary pipes.
3. A comment of mine stated AutoCAD behaviour I had not actually verified. Reworded to what is known.

One test (`CivilHelpHostTests.AcceptedCommandContextFailure…`) failed **once in four full runs** and passes on
its own and on the next run. Nothing to do with this work — recorded rather than ignored.

---

## 5. Numbers, for the record

| | |
|---|---|
| Branch / tip | `claude/civil-k-l-2026-09-16` @ `0ed39495`, pushed |
| Cut from | `origin/claude/ce-civil-handoff-sept-16-5623ca` @ `595c8672` |
| Tests | **9,876 run · 9,836 passed · 23 failed · 17 skipped** |
| Those 23 | The **same 23 pre-existing names** as the trunk baseline, compared **by name**, not by count |
| New tests written | **64**, across 5 new files |
| Builds | **net48 · net8.0-windows · net10.0-windows — 0 errors**, every round, `SkipDevBundle=true` |
| Live bundle | `3.0.0+6505fb5a…`, written 16 Sep 16:05:47 — **never touched by this block** |

**To hand this to the window chat:** branch `claude/civil-k-l-2026-09-16`, tip `0ed39495`.
