# TRUST-07: the start point, confirmed once and stored in the drawing

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card and lifts the HOLD for it.
**Class:** Modify (CDLPD and the tools that need the outlet). Nothing is retired.
**Source:** Tim, 5 Nov: "it also doesn't really make it clear where the start point of the entire system is". Voice talk 6 Nov: the LPD, "CE proposes, Tim confirms once, stored in the drawing, more than one LPD handled". Step 7 of `areas\trust-plan.md`.

---

## FOR TIM

**Today each tool works out the outlet its own way, and none of them remembers your answer. This card makes one start point per network: CE proposes it with a reason, you confirm once, it is stored in the drawing, and every tool reads it from there.**

```before
CDRENUMBER asks which pit is the outlet. Every time. Then forgets.
The solver looks for a pit whose number contains "LPD".
The Pit Schedule reads the LPD that CDLPD drew.
The same drawing can give a different answer on a different day.
```

```after
First time: "CE proposes P1 as the outlet: the LPD is drawn on its outlet pipe. Confirm?"
You confirm once. A marker shows it on the plan.
CDRENUMBER, the solver, the schedule and the long section all start from P1.
The opening line can now say: "14 pits, 22 pipes, all linked, outlet P1."
```

## 1. What you'd see

1. **When CE needs the outlet and none is confirmed:** one question, with the proposal and its reason.
2. **How CE proposes, in this fixed order, same answer every time:**
   1. the pit and pipe end where an LPD is already drawn;
   2. otherwise, the one pit with a pipe leaving it to something that is not a pit;
   3. otherwise, the pit with the lowest invert, said plainly as "lowest invert, not proven";
   4. otherwise no proposal: "CE cannot tell. Pick the outlet pit."
3. **After you confirm:** a small marker at the outlet, and one line: "Outlet confirmed: P1."
4. **A job with two or more outlets:** one start point per network, each confirmed once. CE tells them apart by which pits and pipes drain to each (decision 2).
5. **Changing it later:** a named command (CDLPDRESET today), with the same question. Never changed silently.
6. **If the confirmed outlet is later erased:** "needs checking: the outlet pit is no longer in the drawing". No tool picks a new one by itself.

## 2. The full experience

1. **Trigger:** the first tool that needs the outlet (CDRENUMBER, the solver, the schedule's order, the long section), or the step in Check this drawing (step 8). Not on opening.
2. **Cancel and Escape:** nothing is stored; the tool that asked stops with a plain line. It does not carry on with a guess.
3. **Undo:** confirming is one U.
4. **Save and reopen:** the start point is in the drawing. Reopen on any PC and it is the same. A copy made with Save As keeps it.
5. **Locked layers:** if the marker's layer is locked, the confirmation is stored and the marker is not drawn, with one line saying why.
6. **Xrefs:** an outlet inside an Xref cannot be confirmed from the host drawing; CE says so.
7. **AutoCAD 2022 to 2024:** same question, same store.
8. **Old drawings with an LPD drawn the old way:** read as a proposal with its reason, never as already confirmed.

## 3. Settings

1. **"Tools read the confirmed outlet":** on or off. Default on. Off returns each tool to today's behaviour. This is the undo for the readers.
2. **The solver's "pit number contains LPD" text** stays as a Setting but only as one more way to make a proposal.

## 4. What it reuses

1. **CDLPD's stored record,** which already links to a pipe end and a pit.
2. **The newer record that holds several outlets,** written from Design.
3. **The existing "which pipe leaves this pit" logic,** for the second way of proposing.

**The trap to design around:** those two records each refuse to be written while the other exists. This card does not convert one into the other. It adds one reader that understands both and one confirmation that sits beside them, so old and new work side by side (RULES 15.4). Converting comes later, if at all, as its own card.

## 5. How it gets proven

**Robot, in real AutoCAD on copies:**

1. A job with an LPD drawn: proposal is that pit, reason given. Confirm, save, close, reopen: CDRENUMBER, the solver and the schedule all start there without asking.
2. A job with no LPD and one open-ended pipe: proposal is that pit.
3. A job with no inverts and no LPD: no proposal; CE asks you to pick.
4. Two-outlet job: two confirmations; each tool uses the right one for the pits it is working on.
5. Escape at the question: nothing stored; no renumbering happened.
6. U after confirming: the confirmation is gone.
7. Erase the confirmed outlet pit: the opening line says needs checking.
8. The same drawing, run twice from a fresh copy: identical proposal both times.
9. A deliberately broken version that stores a proposal without the confirmation must fail check 5.

**Codex:** looks at the question, the marker and the lines.

**Tim, about three working days:** on real jobs, the proposal is the pit you would have picked, and you are asked once per job, not once per tool.

## 6. Decisions for Tim

1. **Is the LPD the start point,** or the last pit before it? ANSWERED 12 Nov (interview B4). Tim chose "The LPD itself": "The start point is the legal point of discharge. Pit numbers count up from the first pit upstream of it. One stored thing, matching what council calls the outlet." Sections 1 and the before/after above were written before this answer and still say "outlet P1"; they are to be reworded to "LPD" when the card is next revised.
2. **Two outlets on one job:** one start point per network, each confirmed. Recommended. OPEN.
3. **When CE can only offer "lowest invert":** propose it, or make no proposal and ask you to pick? Recommended: propose it, labelled "not proven". OPEN.
4. **Should the marker print?** Recommended: on a no-plot layer, so it guides the drafter and never reaches council. OPEN.
5. **CDRENUMBER with no outlet pipe drawn** (BUG-1237): with this card it asks you to pick the outlet pit instead of stopping. Confirm that is what you want. OPEN.

## 7. Not known yet

1. Whether the Pit Schedule's row order uses the LPD today, or only treats that one row specially.
2. Whether calculations need the outlet at all. No LPD read was found in them.
3. How the pipe system tags (Property, Outfall, Council) relate to outlets. No link was found.
4. How many real jobs have two outlets. The test set should include at least one.

Written from reading Civil 3.0.90 (commit cf059dcf). Nothing here was run in AutoCAD.
