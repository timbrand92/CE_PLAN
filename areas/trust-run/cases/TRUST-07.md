# Cases for TRUST-07: the start point (the LPD), confirmed once and stored

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-07_START_POINT_CARD_DRAFT_2026-11-12.md`, the review (`areas\TRUST_PLAN_REVIEW_12NOV.md`, hole 8) and installed Civil 3.0.90 (commit cf059dcf). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD-24 to MD-28 are added there for this card).

**The card is marked TO BE REWRITTEN, so these cases follow the correction, not the old text.** The old text proposes a pit, falls back to the lowest invert and adds a third stored record. The correction, from Tim's answer B4 and the review, is:
1. **The start point is the LPD itself.** Pit numbers count up from the first pit upstream of it. One stored thing.
2. **CE confirms the LPD's position.** It keeps one stored record, reading the two that exist and converting neither.
3. **Escape at the question** stores nothing and lets the tool carry on in today's order with a warning line. It is never a hard block (no-hard-blocks rule).
4. **"One U undoes it" is promised only once the Undo test proves it.**

Where the old card text and the correction disagree, a case says which it follows. If the controller's rewritten card differs, the case is changed, not the drawing.
**Defaults taken for Tim (DRAFT, he confirms):** two outlets get one start point per network, each confirmed (card decision 2, recommended); "lowest invert, not proven" is offered as a proposal (decision 3); the marker sits on a no-plot layer (decision 4); CDRENUMBER with no outlet pipe asks you to pick the outlet pit (decision 5).

---

# FOR TIM

**These checks prove the start point is asked once per job, stored in the drawing, read by every tool, and never guessed, and that pressing Escape never stops your work.**

1. **28 robot cases** (section 2).
2. **The proof that matters:** after you confirm once, CDRENUMBER, the solver, the Pit Schedule order and the long section all start from the same LPD, with no second question (H4). And a pit that happens to be renamed "LPD-3" does not fool the solver (H5, a faulty twin built on exactly today's fault).
3. **The trap in the design is tested directly:** two stored forms of the LPD exist and each refuses to be written while the other is there. H8 to H10 check that confirming adds one thing, edits neither old record, and converts nothing.
4. **Not known, so only recorded:** what U does after confirming; what happens to the confirmation if the LPD object is moved; how many real jobs have two outlets.

---

## 1. What is being proven

1. **The proposal is true and repeatable.** Same drawing, same proposal, with its reason, every time.
2. **Confirming is a deliberate act.** Nothing is stored without it.
3. **One stored start point per network,** read by every tool, in any AutoCAD year, after save and reopen.
4. **Escape never blocks.**
5. **The old stored forms are left alone.**

## 2. The robot cases

### Group A: the proposal

**H1. A drawn LPD is proposed, with its reason**
1. **Drawing:** MD-01 (LPD drawn at the end of the outlet pipe).
2. **Do:** run CDRENUMBER (the first tool that needs the outlet). Read the question.
3. **Right:** CE proposes the LPD at the end of the P1 outlet pipe and gives the reason "the LPD is drawn at its outlet pipe". The question says LPD, not "outlet pit P1". Nothing is stored yet: record reading identical to before.
4. **Faulty partner:** a build that stores the proposal before the answer. Record reading differs, case fails.

**H2. The fixed order of proposals**
1. **Drawing:** MD-19 (no LPD; the open-ended outlet pipe removed), MD-20 (no inverts, no LPD), and a copy of MD-01 with the LPD removed but the outlet pipe left.
2. **Right:** with the outlet pipe left and no LPD: CE proposes the end of that pipe, reason "the one pipe leaving a pit to something that is not a pit". With no outlet pipe but inverts: the lowest-invert pit, said as "lowest invert, not proven" (decision 3 default). With neither (MD-20): no proposal, and CE asks you to pick. The order never varies.
3. **Faulty partner:** a build that swaps the second and third rules. It must give a different answer on the copy and fail.

**H3. Same answer every time**
1. **Drawing:** MD-01, MD-08, MD-19, MD-24, MD-25, MD-26.
2. **Do:** run the proposal twice on fresh copies on LOGIN-1, then on a second login with different personal Settings.
3. **Right:** identical proposal and reason, word for word, in all runs.
4. **Faulty partner:** a build that breaks a tie by the order objects were stored in the drawing. Different runs on a shuffled copy would disagree.

### Group B: confirming, reading, and the second question

**H4. One question per job; every tool starts from it**
1. **Drawing:** MD-01.
2. **Do:** confirm once. Save, close, reopen. Run CDRENUMBER (preview, No), the solver (CDRUNSOLVE), the Pit Schedule, and the long section (CDPROFILE). Count the questions in the command-line reading.
3. **Read back:** which pit each tool begins from; the questions asked.
4. **Right:** no question after the first confirmation. All four start from the LPD at the P1 outlet and number or solve up from P2. P1 is numbered first, P2 next (the answer sheet).
5. **Faulty partner:** a build where one tool still asks, and a build where the long section starts from a different pit. Each must fail by tool.

**H5. The "LPD in the pit number" trap**
1. **Drawing:** MD-27 (P3 renamed LPD-3; the LPD drawn at P1).
2. **Do:** confirm the LPD at P1, run CDRUNSOLVE.
3. **Right:** the solver starts from P1, not P3. The pit number text is only one more way to make a proposal.
4. **Faulty partner:** the installed build, which finds the outlet by a pit whose number contains "LPD". It would start at P3 and must fail.

**H6. Escape at the question**
1. **Drawing:** MD-01.
2. **Do:** run CDRENUMBER and press Escape at the question. Then run the solver and press Escape. Read the record reading and the command line.
3. **Right:** nothing is stored (record reading identical). The tool carries on in today's order, so it still does its work as today, and prints one plain warning line that the outlet is not confirmed. It is not blocked. (The old card text said the tool would stop; the correction says carry on, because of the no-hard-blocks rule.)
4. **Faulty partner:** a build that stores the proposal when Escape is pressed (card check 9), and a build that stops the tool dead. Each must fail.

**H7. Confirm, then U (the promise is tested, not trusted)**
1. **Drawing:** MD-01.
2. **Do:** confirm. Read the full drawing reading and record reading. Press U once. Read both again.
3. **Right:** two outcomes are allowed. If one U returns both readings to exactly the state before confirming, the words "U undoes it" may appear. If it does not, they must not. RECORD which. The marker, if drawn, is part of the full drawing reading.
4. **Faulty partner:** a build that says "U undoes it" while the confirmation stays stored. Must fail.

### Group C: the two stored forms (the trap)

**H8. Confirming on the older form**
1. **Drawing:** MD-24.
2. **Do:** confirm. Read the record reading.
3. **Right:** the only change is the one added confirmation. The older record is identical. No newer-form record is created.
4. **Faulty partner:** a build that converts the older record into the newer. The older record is gone, and the case fails.

**H9. Confirming on the newer form**
1. **Drawing:** MD-25.
2. **Right:** as H8, the other way round: no older record is created and the newer set is unchanged.

**H10. Both forms present**
1. **Drawing:** MD-26.
2. **Right:** the proposal reads both and agrees (same LPD). Confirming adds the one confirmation and edits neither old record. If the two forms name different LPDs (copy MD-26 and move one), the proposal is two candidates: no proposal, CE asks you to pick.
3. **Faulty partner:** a build that tries to write one form while the other exists (each refuses today). The case must fail if the write is attempted or refused with an error.

**H11. An older drawing's LPD is a proposal, never already confirmed**
1. **Drawing:** MD-24 and MD-03 (old LISP-style, a hand-placed LPD block).
2. **Right:** CE proposes with the reason, and asks. The drawing is not read as confirmed. Opening it prints nothing about an outlet being confirmed.

### Group D: after confirming

**H12. Save, close, reopen, on another login**
1. **Drawing:** MD-01 confirmed.
2. **Do:** save, close, reopen on LOGIN-1; then on a second Windows login.
3. **Right:** every reader gives the same LPD and nobody asks again. Record reading identical after reopening.

**H13. A Save As copy keeps it; pits copied from another job do not bring theirs**
1. **Drawing:** MD-09 (Save As copy of a confirmed MD-01) and MD-09-X (two pits copied into MD-08).
2. **Right:** MD-09 keeps the confirmed LPD. MD-08 with the two foreign pits keeps its own confirmations, and the foreign pits do not bring in a confirmation from MD-01. RECORD what the copy does with two LPDs.

**H14. Erase the confirmed LPD**
1. **Drawing:** MD-01 confirmed, then the LPD object (or its pit) erased.
2. **Right:** the opening line (UX-OPEN-01) says needs checking and that the outlet is no longer in the drawing. No tool picks a new LPD by itself. The next tool that needs one asks again.
3. **Faulty partner:** a build that quietly proposes and stores a new one. Must fail.

**H15. Change it later, never silently**
1. **Drawing:** MD-01 confirmed.
2. **Do:** run CDLPDRESET, choose a different position, then run it again and press Escape.
3. **Right:** the same question as the first time. A changed LPD is a deliberate act and is stored. Escape leaves the old one. Nothing changes without CDLPDRESET.

**H16. Two outlets**
1. **Drawing:** MD-08.
2. **Do:** confirm each network's LPD. Run each tool on a pit in each network.
3. **Right:** two confirmations, each tool uses the right one for the pits it is working on. Pit numbering counts up from the first pit upstream of each LPD. A pit in network 1 is never numbered from network 2's LPD.
4. **Faulty partner:** a build that uses the first confirmation for every pit. Must fail on network 2.

**H17. The setting "Tools read the confirmed outlet"**
1. **Do:** turn it off on MD-01 (confirmed). Run CDRENUMBER.
2. **Right:** CDRENUMBER behaves as today: it asks which pit is the outlet. Turn on: it does not ask. Settings reading shows the default on.
3. **Faulty partner:** a build that ignores the switch.

### Group E: where it can go wrong in a real drawing

**H18. A locked layer and a frozen layer**
1. **Drawing:** MD-18 (pipe layer locked) and a copy with the layer the marker would go on locked.
2. **Right:** the confirmation is stored; the marker is not drawn; one plain line says why. Nothing is unlocked (layer states identical in the drawing reading).
3. **Faulty partner:** a build that unlocks the layer to draw the marker.

**H19. An LPD inside an Xref**
1. **Drawing:** MD-10.
2. **Right:** CE says an outlet inside an attached drawing cannot be confirmed from the host drawing. Nothing is stored, and the Xref is untouched.

**H20. The marker**
1. **Drawing:** MD-01 and MD-05-M.
2. **Right:** the marker sits on a layer set not to plot (decision 4 default), at the LPD. Its real size is the same in the millimetre and metre drawings (compare in millimetres). It does not appear in a plot preview. In paper space nothing is drawn.
3. **Faulty partner:** a marker on a plotting layer. Must fail.

**H21. Units**
1. **Drawing:** MD-05-MM, MD-05-M, MD-05-U.
2. **Right:** the same proposal and reason in all three. MD-05-U: RECORD.

**H22. The LPD is moved**
1. **Drawing:** MD-01 confirmed, then the LPD object moved 3 m by MOVE.
2. **Right:** RECORD. The card does not say whether the confirmation follows the object or stays at the old place. The robot writes down the result and puts it to Tim.

### Group F: the plan's standing cases

**H23. No outlet pipe drawn (BUG-1237)**
1. **Drawing:** MD-19.
2. **Do:** run CDRENUMBER.
3. **Right:** it asks you to pick the outlet pit instead of stopping with no help (decision 5, DRAFT default). Escape: the warning line and today's behaviour, not a hard block.

**H24. Another CE version opens a confirmed drawing**
1. **Drawing:** MD-01 confirmed, taken to a test login with the previous Civil build.
2. **Do:** open, run Edit Pit, save a copy.
3. **Right:** the previous build does not delete or reset the confirmation (record reading still holds it). RECORD what it ignores. (This is the review's hole 5: an older version quietly undoing the core's work.) Never run on a real PC.

**H25. Read-only file and a file open elsewhere**
1. **Drawing:** MD-14 and MD-14-L.
2. **Right:** confirming holds in memory and CE says plainly that the file cannot be saved. File hash unchanged. Nothing is written beside it.

**H26. Paper space, spoiled blocks, a job over two drawings**
1. **Drawing:** MD-11, MD-12, MD-16.
2. **Right:** a layout is never read for the LPD. In MD-12 the exploded P4 does not change the proposal. In MD-16 each file proposes its own LPD, or none if the LPD is in the other file (RECORD the wording).

**H27. A hidden command typed from habit**
1. **Drawing:** MD-01.
2. **Do:** type CDLPD, then CDLPDRESET, then CDRENUMBER.
3. **Right:** each reads the stored confirmation and does not re-ask or re-propose in a way that disagrees with it.

**H28. AutoCAD 2022 to 2024**
1. **Do:** H1, H4, H6, H12 and H20 on 2024.
2. **Right:** the same question, the same store, the same results.

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** H4 runs four tools after confirming and reads which pit each starts from. H8 to H10 read the record after an edit (the confirmation).
2. **The same jobs taught and tested.** The proposal has fixed rules, not learnt ones. The made-up old drawing (MD-03) is test-only.
3. **"Sent" is not "worked".** H4 reads where each tool really started, not that a question was answered.
4. **Undo compared on linework.** H7 compares the full drawing reading after one U, marker included.
5. **Twice, identical.** H3.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** H25.
2. **Save As and copied pits:** H13.
3. **Units:** H21.
4. **Xref:** H19.
5. **Paper space:** H26.
6. **A hidden command typed from habit:** H27.
7. **Another CE version:** H24.
8. **Spoiled blocks:** H26.
9. **A job over several drawings:** H26.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** the question on MD-01, MD-19 and MD-08; the marker on the plan; the lines printed.

**What to look at, and what right looks like:**
1. **The question** is one decision in drafting words, names the LPD, gives the reason, and has an obvious Yes and an obvious way to pick. Right = no software word, no mention of records or stores.
2. **The reason reads as a reason,** such as "the LPD is drawn at its outlet pipe", not a rule name.
3. **"Lowest invert, not proven"** is plainly marked as less certain than a drawn LPD.
4. **The marker** is small, clear, in a colour that shows it is a guide and not part of the issued drawing, and at the right place. It does not cover other text.
5. **After confirming,** the next tool starts quietly. Right = you are asked once per job, not once per tool.
6. **The warning line after Escape** says what happens next in one line and does not alarm.
7. **Two outlets:** the marker for each network is distinguishable.

**Screenshots:** `START07_question_md01.png`, `START07_marker.png`, `START07_two_outlets.png`.

**Cannot be proven without Tim:** that the proposal is the LPD he would have picked on real jobs, and the two-outlet rules on a real two-outlet job (none is known yet).
