# Morning pack — windows chat — overnight 17 September 2026

**Nothing was deployed. AutoCAD is exactly as you left it.** Live is still `3.0.0+d0ffe1a2` — read back from
the DLL at the end of the night. Codex is testing that build; nothing I did tonight can disturb it.

Branch `claude/civil-combined-2026-09-17`, tip **`28464fbd`**, pushed.
Builds: **net48 / net8 / net10 — 0 errors.** Full net10 suite: **9,918 run · 9,879 passed · 22 failed ·
17 skipped** — the **same 22 names** as the recorded baseline, compared name by name. No new failures, none
fixed. 19 new tests written.

---

## 1. What I built — three real faults, all found by opening the real thing

| | What you would have hit | State |
|---|---|---|
| **W-06** | **The tank picker was putting the wrong name on tanks.** Five different tanks were all tiled "KINGSPAN 6000 L SLIMLINE METAL TANK" — three of which are actually 3500 L, 5000 L and 6000 L tanks. **Pick the tile that says 6000 L, get a 3500 L tank.** | Fixed |
| **W-07** | **CDWT could quietly draft the wrong standard detail** and say nothing. | Fixed (it warns now) |
| **W-08** | **CDWT was a dead end when no tank plans were found** — half the window empty and black, Place tank permanently greyed out, nothing telling you why. | Fixed |

### W-06 — how it was found, and what it means

I opened **your own master**, `CE Civil WATER TANKS PLAN.dwg`, through the plugin's own reading code and
printed every tile name. The picker takes the title text nearest each tank — but nothing stopped **one title
being used over and over**, so a tank with no title of its own quietly borrowed its neighbour's.

Now each title belongs to **one** tank. A tank with no title of its own uses its own name if it has a real
one, otherwise it reads **"Untitled tank plan"** with its size and picture. **It is never given someone
else's name.**

| | Before | After |
|---|---:|---:|
| Tiles offered | 40 | 40 |
| Tanks wrongly called "KINGSPAN 6000 L" | **5** | **1** (the real one) |
| Tiles with a raw formatting code (`xsm1;5500 lt MELRO…`) | 1 | 0 |
| Honestly "Untitled tank plan" | 0 | 2 |

### W-07 — a trap, not a report. Nobody has hit this yet

CDWT finds your standard tank detail by an **anonymous** block name (`A$Ccf03b551`). Anonymous names **move
when you resave the master**. If that happened, CDWT fell back to "the biggest tank-ish block I can find" —
a possibly different detail — and **said nothing at all**.

It now says so at the command line, and a test fails the build the day the name moves. **I checked your
current master (16 September): the right block is still there**, so CDWT is drafting the detail it should be.

### W-08 — see the picture

The "no tank plans" panel now names the drawing CE opened, gives both likely reasons, and names **both ways
to carry on**. The rendered window is at
`Modules\Drainage.Tests\bin\Debug\net10.0-windows\cdwt-window-no-plans.png` — I opened it and looked at it.

---

## 2. One thing I found and deliberately did NOT fix

**Double-click a pipe's LABEL and you get the old editor, not the new one-page window.** Double-click the
pipe itself and the new window opens. Same command, two different windows.

I measured it rather than guessed: the pipe needs **760** pixels of height, the label case needs **823**, and
the code refuses anything over **820**. **Three pixels.** Even on a 1080p screen at 100%, with 1016 pixels of
room, it refuses.

**Why I left it:** the extra height comes from `CdDialog.xaml`, which is **Codex's file** under your ruling B
of 15 September. Raising the limit from my side would fix two screen sizes but **not 125%, which is yours**,
and would loosen a shipped guard on a hunch. So I wrote the measurement and the contract instead:
`docs/workflows/CD_LABEL_TAB_FIT_CONTRACT_2026-09-17.md` in the plugin repo. **Fixing it clears five of the
22 red tests.**

---

## 3. TEST THIS — after the next deploy, in AutoCAD 2027

These are **new** rows. Codex's current run is on the build already installed and does not cover them.

| # | What | Steps |
|---|---|---|
| **N1** | **Tank names are right** | `CDWT`. Look at the tile panel on the right. **No two tiles carry the same tank name at different sizes.** There must be exactly **one** "KINGSPAN 6000 L SLIMLINE METAL TANK". No tile starts with something like `xsm1;`. |
| **N2** | **Untitled tiles are honest** | Two tiles read **"Untitled tank plan"** with a size and a picture. That is deliberate — those two plans have no title beside them in your master. **Tell me if you would rather they were named, and what from.** |
| **N3** | **Worth your eye — the MELRO pair** | The 4500 and 5500 MELRO titles now attach to **different blocks than before** (4500 → 5600×1760, 5500 → 4622×1760). That is what the spacing in the master says, but a 5500 L tank reading smaller than a 4500 L one is odd. **Check those two against the master.** If the titles need moving, that is a change to your master, not to CE — CE can only take the nearest title. |
| **N4** | **Empty folder message** | Settings page → point the Civil Standard Details folder at an empty folder. `CDWT`. **Right looks like:** "No tank plans found", the drawing named, and both ways out offered. **No empty black panel.** Press "Tag a block already in the drawing" — it should still ask you to pick the block. Put the folder back and check the tiles return. |
| **N5** | **Nothing else about CDWT changed** | Place a tank the normal way — pick a tank, a detention share, a plan, Place tank, insertion point, callout/riser/dropper, Base RL. Same as before. |

---

## 4. NEEDS TIM — questions, none of them decided for you

1. **"Base RL in the window" — I did not build it, and I want to check that was right.** It was on my list
   from an earlier chat's parking lot, but **you never asked for it.** The code deliberately asks the base
   level *after* placement, with the tank on screen, and the test list Codex is running expects it there.
   **Do you want Base RL asked inside the window as well? If you say yes I will build it.**
2. **The two "Untitled tank plan" tiles** (N2) — leave them honest, or name them from something?
3. **The MELRO pair** (N3) — do the titles in your master need moving?
4. **The selected-item wording on the Edit Pipe window** reads like software: *"This item reads the CE field
   'X'. Change the linked field here to coordinate every linked location; custom displayed wording remains
   separate."* Shorter and in your words would save a line **and** read better — for example *"Change the
   pipe's value and every label showing it changes too. Custom wording is separate."* **Your call.**
5. **Still open from before:** the street-note **wrap width**. Five widths were drawn for you on 17 Sep and
   you have not picked one.

---

## 5. Parked (written down, not started)

- **The orifice standard detail has the same trap as W-07** — `OrificeStandardDetailDrafter` also finds its
  block by an anonymous `A$C…` name with a silent fallback. Same fix, ten minutes. Not touched tonight
  because the orifice detail is outside this chat's fence.
- **A "show me" command** that opens every CE window and saves real AutoCAD screenshots. Considered and
  **dropped for now**: Codex can already screenshot AutoCAD directly, so it buys less than it did a week ago,
  and adding a new command in the middle of a test night is a poor trade.
- **The CDWT footer** names the first missing thing, so with no tank chosen *and* no plans it says "Choose a
  tank…" while the panel explains the plan problem. Correct, but say if you want the plan named first.

## 6. Where I stopped and why

Ran out of work I could do without either your decision or Codex's file. The remaining CDWT items are
question 1 above; the label-fit fix is Codex's; the orifice trap is outside the fence. Nothing was left
half-finished — every change is committed, tested and logged.

**Full detail:** plugin `REGRESSION_LOG.md`, entries **W-06**, **W-07**, **W-08** and the label-fit
**FINDING**, newest first.
