# Cases for TRUST-S3: support blocks with no silent sizes (DS, DS1, TS1, C1, C2)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-S3_SUPPORT_BLOCKS_NO_SILENT_SIZES_CARD_DRAFT_2026-11-12.md` and the card's own code references (Structural 1.0.126, commit 8de95c34; read in the card, **not re-read by this lane**). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD-34 and its variants; the schedule record reading is defined at its end).
**Defaults taken for Tim (DRAFT; the card's three decisions are OPEN, so the cases follow its recommended answers):** a mark on two floors gets a question showing both sizes; with no floor names on the sheet the question shows both sizes with row numbers; a timber stud pack asks for the block size and puts the schedule's wording in the support text.

---

# FOR TIM

**These checks prove a support block never gets a size you were not shown or did not choose: a mark used on two floors asks, a size the block cannot show asks, and a clear single row still goes straight through.**

1. **26 robot cases** (section 2), each with a deliberately faulty twin that must fail, or marked RECORD.
2. **Three are written to FAIL on today's installed build** (D2, D3 and D4): the first row's size is taken for a mark on two floors, and a timber pack is drawn as 90 x 90 while the line still says the schedule size.
3. **Two things only a look at real schedules can settle,** so they are recorded, not passed: whether the schedule sheet carries a floor name in a fixed place (card section 7, item 1), and what the label should say for a timber pack (decision 3 needs your word).
4. **Two fixes already installed in 1.0.121 and never tested** (BUG-437, BUG-438) get their first proof here (D13 and D14). If one fails, that is a finding, not a fault in the case.

---

## 1. What is being proven

1. **One clear row goes straight through** as today, and says where the size came from.
2. **An unclear schedule asks.** Two floors, two rows, or a size the block cannot show: a question, never a quiet default.
3. **Escape at the question changes nothing.**
4. **The schedule record is never altered** by placing a support.
5. **A copied beam keeps its own links** (BUG-1139).

## 2. The robot cases

### Group A: the size, or the question

**D1. One clear row: no question**
1. **Drawing:** MD-34-ONE.
2. **Do:** type C1, then C2, then DS on a clear row each. Read the command-line reading and the drawing reading (the placed block's size).
3. **Right:** no new question. The line names the size and where it came from, in the form "[CE] C1: size '89 SHS' from the schedule". The drawn block carries that size.
4. **Faulty partner:** (a) a build that always asks; (b) a build that draws the default size. Each must fail.

**D2. The same mark on two floors, floor names on the sheet**
1. **Drawing:** MD-34-F (C1 = 89 SHS on GROUND and 75 SHS on FIRST, floor names on the sheet), on a first-floor plan.
2. **Do:** type C1. Read the question. Answer "First". Repeat answering "Ground", then answering with a typed size.
3. **Right:** the question is "C1 is 89 SHS on GROUND and 75 SHS on FIRST. Which? [Ground/First/Type a size]" (card). Answering First draws 75 SHS; Ground draws 89 SHS; a typed size draws that size. The line then names which was chosen.
4. **Faulty partner:** a build that takes the first row's size without asking. It draws 89 SHS and says "from the schedule". **Written to FAIL on today's build.**
5. **Run only if** the floor names can be read from the sheet. If they cannot, this case is NOT RUNNABLE and D3 applies (see D3). RECORD which.

**D3. The same mark twice, no floor names**
1. **Drawing:** MD-34-NF (C1 at row 4 = 89 SHS, row 11 = 75 SHS, no floor names).
2. **Do:** type C1. Read the question. Answer with each row.
3. **Right:** the question is "C1 appears twice: row 4 = 89 SHS, row 11 = 75 SHS. Which?" (card, decision 2 recommended). The row numbers equal the sheet's. The chosen row's size is drawn.
4. **Faulty partner:** the first-row build. **Written to FAIL on today's build.**

**D4. A timber pack the block cannot show**
1. **Drawing:** MD-34-T (DS1 = "2 No 90 x 45 F17 KDHW").
2. **Do:** type DS1. Read the question. Answer with the default block size.
3. **Right:** the question is "The schedule says DS1 is '2 No 90 x 45 F17 KDHW'. The block cannot show that size. Size? [90 x 90/...]". Nothing is drawn before the answer. After the answer the block carries the answered size. RECORD whether the support text carries the schedule's wording (decision 3, recommended: yes; the drawing convention needs Tim's word). Never a quiet 90 x 90.
4. **Faulty partner:** the installed build, which draws 90 x 90 while the line names the schedule size. **Written to FAIL on today's build.**

**D5. TS1, a timber triple row**
1. **Drawing:** MD-34-T.
2. **Right:** as D4 for TS1, with its own row's wording in the question.

**D6. DS, no tag**
1. **Drawing:** MD-34-T with a DS row the block cannot show.
2. **Right:** as D4. RECORD if DS does not read the schedule at all (the card lists DS among the five tools that take a size from it).

**D7. A schedule row switched out**
1. **Drawing:** MD-34-EX (C1 has two rows, one switched out of the schedule).
2. **Right:** one included row, so no question, and the included row's size is drawn (only included rows are kept, since the BUG-974 fix). The excluded row is never offered.
3. **Faulty partner:** a build that offers the excluded row. Must fail.

**D8. No schedule in the drawing**
1. **Drawing:** MD-34-NS.
2. **Right:** C2 asks the size question it asks today (the card reuses it). C1, DS, DS1, TS1 behave as the installed build does. The robot compares the command-line reading with the installed build's.

**D9. The switch versions (RECORD)**
1. **Drawing:** MD-34-F and MD-34-T with supports already placed.
2. **Do:** run SC1, SDS1 and STS1 on them.
3. **Right:** RECORD. The card's class line includes "their switch versions" but its sections describe only the five placing tools. The robot writes down whether the switch tools read the schedule at all and whether they ask. No pass or fail.

### Group B: Escape, Undo, save

**D10. Escape at each new question**
1. **Drawing:** MD-34-F, MD-34-NF, MD-34-T.
2. **Do:** at each of the three new questions press Escape. Read the drawing reading and the schedule record reading.
3. **Right:** nothing placed, nothing written. Both readings identical to before (card section 2, item 3).
4. **Faulty partner:** a build that places the default size on Escape. Must fail.

**D11. Undo and the schedule record**
1. **Drawing:** MD-34-F.
2. **Do:** place C1 (answer First), read the drawing reading and the schedule record reading, press U once, read again.
3. **Right:** the schedule record is the same at every step (placing a support never changes it). One U removing one support and its text is RECORD (card: "to be proven"): the robot writes whether one U returns the drawing reading to exactly before. No on-screen words promise it.
4. **Faulty partner:** a build that rewrites the schedule record when it places a support. Must fail.

**D12. Save and reopen**
1. **Do:** after D11 place two supports, save, close, reopen.
2. **Right:** the placed supports are the same; the schedule record equals its first reading.

### Group C: the two installed fixes, and the copied beam

**D13. BUG-437: Enter at the support text question**
1. **Drawing:** MD-34-ONE.
2. **Do:** place a support, press Enter at the text question.
3. **Right:** it finishes cleanly: no error line, no stray text object, no half-placed block (drawing reading equals the answer sheet). Installed in 1.0.121 and never tested; a failure here is a finding.

**D14. BUG-438: a number at the append question**
1. **Drawing:** MD-34-ONE.
2. **Do:** at the append question type a number.
3. **Right:** it finishes cleanly, as D13, and the number is appended as the card's wording for the installed fix intends (RECORD the exact result).

**D15. COPY a beam, place a column under the copy (BUG-1139)**
1. **Drawing:** MD-34-B3.
2. **Do:** COPY beam B3. Place C1 under the copy. Read the links of beams and columns and every label before and after.
3. **Right:** B3 keeps its label and its other column. The copy keeps its own links. The new column links to the copy only.
4. **Faulty partner:** a build that moves the link to the original beam. B3 loses its label or its other column, and the case fails.

### Group D: protections and the trial switch

**D16. Locked layer: refused before anything is drawn**
1. **Drawing:** MD-34-ONE with the support layer locked.
2. **Right:** a plain refusal line before any block is drawn (card, verified at `Commands\SupportBlockCommands.cs:225-231`). Drawing reading identical. Layer states identical. Nothing unlocked. Unchanged from today.
3. **Faulty partner:** a build that unlocks the layer. Must fail.

**D17. The millimetre check**
1. **Drawing:** MD-34-ONE converted to metres.
2. **Right:** the same refusal as the installed build (card: already in place, `SupportBlockCommands.cs:216`). Nothing drawn. Unchanged.

**D18. The trial switch "Support blocks: old schedule behaviour"**
1. **Drawing:** MD-34-F.
2. **Do:** read the Settings reading (default). Turn it on and type C1. Turn it off and type C1 again.
3. **Right:** default off. On: C1 takes the first row's size without a question, exactly as the installed build does (compare the command-line reading). Off: the D2 question.
4. **Faulty partner:** a build that ignores the switch. Must fail.

**D19. No other switch**
1. **Do:** read the Settings reading for any new row about these questions.
2. **Right:** none besides the trial switch (card section 3, item 1).

### Group E: the standing cases

**D20. The ribbon button and the typed command are the same**
1. **Do:** run D2 by the ribbon button and by typing C1.
2. **Right:** the same question and the same drawing result.

**D21. Paper space (RECORD)**
1. **Drawing:** MD-34-ONE with a layout current.
2. **Right:** RECORD what C1 does in paper space. The card is silent. Right at the least = nothing is drawn in a way that changes model space.

**D22. An Xref**
1. **Drawing:** MD-34-ONE with the schedule in an attached drawing (MD-10 pattern).
2. **Right:** RECORD whether a schedule inside an Xref is read. Nothing in the Xref is changed.

**D23. Another CE version**
1. **Drawing:** MD-34-F with supports placed by the new build, opened by the installed build.
2. **Right:** it opens; the supports and the schedule record are intact (record reading). Never run on a real PC.

**D24. Two logins, twice identical**
1. **Do:** D2, D3 and D4 twice on fresh copies on login 1 and once on a second login with different personal Settings.
2. **Right:** the same questions, word for word.

**D25. AutoCAD 2022 to 2024**
1. **Do:** D1, D2, D4, D10 and D15 on 2024.
2. **Right:** the same questions and results.

**D26. A real-schedule look (not a robot case)**
1. **Do:** Codex opens made-up copies of a few schedule layouts (not real client sheets) and reads whether a floor name sits in a fixed place.
2. **Right:** RECORD only. The result settles D2 versus D3.

## 3. The gaps from the review, answered

1. **Reading alone is not enough.** D1 to D4 read the drawn block's size, not the line; D11 reads the schedule record after the edit.
2. **The same jobs taught and tested.** No learned list; MD-34 variants are for testing only.
3. **"Sent" is not "worked".** D1 and D4 compare the drawn size with the answer sheet, not with what the line said.
4. **Undo compared on linework.** D11 compares the full drawing reading after U.
5. **Twice, identical.** D24.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** not applicable (nothing is saved by placing a support); D12 covers save.
2. **Save As and copied pits:** D15 (copied beams); a plain Save As keeps the schedule record, read in D12.
3. **Units:** D17.
4. **Xref:** D22.
5. **Paper space:** D21.
6. **A hidden command typed from habit:** D20, and the switch tools in D9.
7. **Another CE version:** D23.
8. **Spoiled blocks:** D15 (a copied beam), and an exploded support: RECORD what C1 does when the block under it is exploded.
9. **A job over several drawings:** not applicable to supports; the schedule is per drawing.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** the three new questions on MD-34-F, MD-34-NF and MD-34-T.

**What to look at, and what right looks like:**
1. **Each question** is one decision in drafting words, shows both sizes (and floors or row numbers), and offers an obvious way to type a size.
2. **No software words.**
3. **The size line after the answer** says which size was chosen and where it came from.
4. **A clear row** is quiet: no question.
5. **The timber label** reads as the schedule reads, if decision 3 goes ahead.

**Screenshots:** `S3_two_floors.png`, `S3_no_floors.png`, `S3_timber.png`.

**Cannot be proven without Tim:** that every support size on a real plan is one he saw or chose; whether the schedule sheet carries a floor name (card section 7, item 1); how often a mark is reused across floors on real jobs; and the timber label convention (decision 3, engineering and drafting).
