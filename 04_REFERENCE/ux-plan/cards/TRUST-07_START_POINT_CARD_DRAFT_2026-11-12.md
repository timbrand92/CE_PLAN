# TRUST-07: the LPD as the one stored start point

**Status: DRAFT, rewritten 12 Nov 2026 after Tim's answer and the independent review.** Not approved, not built, not tested, not installed.
**Class:** Modify (CDLPD and the tools that need the start point). Nothing is retired.
**Source:** Tim, 5 Nov: "it also doesn't really make it clear where the start point of the entire system is". Tim, 12 Nov (interview B4), chose: "The LPD itself": "The start point is the legal point of discharge. Pit numbers count up from the first pit upstream of it. One stored thing, matching what council calls the outlet." Step 7 of `areas\trust-plan.md`.

---

## FOR TIM

**The start point of a network is its LPD. You confirm it once, it is stored in the drawing, and every tool starts from it. No tool works it out its own way any more.**

```before
CDRENUMBER asks which pit is the outlet. Every time. Then forgets.
The solver looks for a pit whose number contains the letters LPD.
The Pit Schedule puts a pit literally named "LPD" first, and ignores the LPD you drew.
```

```after
First time a tool needs it: "CE found the LPD on the pipe leaving P1. Is this the start point?"
You confirm once.
CDRENUMBER counts up from the first pit upstream of the LPD. The solver stops at the LPD.
The opening line can say: "14 pits, 22 pipes, all linked, LPD confirmed."
```

## Decisions for Tim (recommendation first; all OPEN unless marked)

1. **The start point is the LPD itself.** ANSWERED 12 Nov, as quoted above.
2. **No LPD drawn yet:** CE asks you to place or pick the LPD point. It does not offer "the lowest pit" as a stand-in. Recommended. (Interview J8.)
3. **Esc at the question:** the tool carries on the way it does today and prints one warning line, "LPD not confirmed, order may differ". Nothing stops. Recommended, to keep the no-hard-blocks rule. (Interview J9.)
4. **Two LPDs on one job:** each network has its own, each confirmed once. CE tells them apart by which pits and pipes drain to each. Recommended.
5. **Should the confirmation show on the plan?** The LPD callout you already draw is the marker; nothing extra is drawn. Recommended.
6. **CDRENUMBER when no pipe leaves the network** (BUG-1237): it asks for the LPD instead of stopping with no help. Recommended.

## 1. What you'd see

1. **An LPD already drawn with CDLPD:** CE reads it and asks you to confirm it once. It is read as a proposal, never as already confirmed.
2. **No LPD:** "No LPD in this drawing. Place it now, or press Esc to carry on without one."
3. **After confirming:** one line, "LPD confirmed on the pipe leaving P1."
4. **Later, if the LPD's pipe or pit is erased:** the opening line says "needs checking: the LPD's pipe is no longer in the drawing". No tool picks a new one by itself.
5. **Changing it:** the existing named command for moving the LPD, with the same question. Never changed silently.
6. **When CDLPD cannot write** because the drawing holds the newer kind of LPD record: today the drafter sees only "Error during CDLPD - see CE log". This card replaces that with the plain reason and what to do.

## 2. The full experience

1. **Trigger:** the first tool that needs the start point (CDRENUMBER, the solver, the long section), or the LPD step inside Check this drawing (step 8). Never on opening.
2. **Cancel and Escape:** nothing is stored. The tool carries on in today's way with the warning line (decision 3).
3. **Undo:** confirming is meant to be one U. That is not promised on screen until the Undo test on a copy has proved it.
4. **Save and reopen:** the confirmation is in the drawing. Any PC, same answer. A drawing made by Save As keeps it, which is right for a revision and wrong for a new job copied from an old one: so a confirmation whose pipe or pit is not in this drawing shows as "needs checking", not as confirmed.
5. **Read-only drawing:** CE reads the LPD and uses it for this session; it says it could not store the confirmation.
6. **Locked layers:** nothing is drawn by this card, so nothing is touched.
7. **Xrefs:** an LPD inside an attached drawing cannot be confirmed from the host; CE says so.
8. **Pits copied from another job:** they do not bring an LPD confirmation with them.
9. **AutoCAD 2022 to 2024:** same question, same store.

## 3. Settings

1. **"Tools start from the confirmed LPD":** on or off. Default on. Off returns each tool to today's behaviour. This is the way back for the tools; it does not remove a stored confirmation.
2. **The solver's "pit number contains LPD" text** stays on Settings, used only when no LPD is stored, and reported as "found by pit name, not confirmed".

## 4. What it reuses (no new store)

1. **The LPD records that already exist.** There are two forms, an older one written by CDLPD and a newer one written from Design that can hold several outlets. This card adds no third.
2. **The one reader that already returns the LPD from either form.** Every tool is pointed at that reader.
3. **Where "confirmed" is kept (settled as a DRAFT default, 13 Nov; Tim to confirm).** The builder checked the installed build: both LPD records are read strictly, so an extra value inside either makes the LPD read as damaged on a colleague's PC. So "confirmed" is kept as one small separate item beside the two records, in the same LPD group in the drawing, the way the drawing's path is already kept there. It holds only "this LPD was confirmed, on this pipe end, on this date". It never holds the LPD's position, and no tool reads it instead of the LPD. If the LPD or its pipe changes, it counts as not confirmed. The installed build must still read both records as healthy with it present; that is a required test.

**The trap:** each of the two record forms refuses to be written while the other exists. This card does not convert one into the other.

## 5. How it gets proven

**Before the "one U" wording goes on screen:** the Undo test on a copy.

**Robot, in real AutoCAD on made-up copies** (step-by-step checks: `areas\trust-run\cases\TRUST-07.md`, to be redone against this rewrite):

1. LPD drawn with CDLPD: asked once; confirm; save, close, reopen: CDRENUMBER, the solver and the long section all start from it without asking.
2. No LPD: CE asks for it; Esc: the tool carries on in today's order with the warning line, and nothing is stored.
3. Two-LPD job: two confirmations; each tool uses the right one for the pits in hand.
4. Erase the LPD's pipe: the opening line says needs checking; no tool substitutes another.
5. Save As to a new name, erase the network, draw a new one: the old confirmation shows as needs checking.
6. Read-only drawing: used for the session, not stored, and CE says so.
7. An older CE version opens the drawing after confirmation: CDLPD and the Pit Schedule still work there.
8. The same drawing, twice from fresh copies: the same proposal both times.
9. A deliberately faulty version that stores the confirmation without the drafter's yes must fail check 2.

**By eye (Codex):** the question and the lines read as plain drafting words.

**Tim, on real jobs:** the LPD CE proposes is the one you drew, and you are asked once per job, not once per tool.

## 6. Not known yet

1. Whether "confirmed" can be added to both record forms without upsetting older versions (section 4, item 3).
2. How the Property / Outfall / Council pipe tags relate to LPDs. No link was found in the code.
3. How many real jobs have two LPDs.
4. What one U does after confirming.

Written from reading Civil 3.0.90 (commit cf059dcf) and `areas\trust-run\CODE_FACTS_13NOV.md` sections B and E. Nothing here was run in AutoCAD.
