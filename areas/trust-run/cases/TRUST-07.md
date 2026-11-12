# Cases for TRUST-07: the LPD as the one stored start point

**Status: DRAFT (second version, 12 Nov 2026), lane trust-test-cases.** Rewritten against the rewritten card `04_REFERENCE\ux-plan\cards\TRUST-07_START_POINT_CARD_DRAFT_2026-11-12.md` (the card that says "rewritten 12 Nov 2026 after Tim's answer and the independent review"), and installed Civil 3.0.90 (commit cf059dcf) as read in `areas\trust-run\CODE_FACTS_13NOV.md` sections B and E. **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD-24 to MD-28 were added there for this card).

**What changed from the first version of this file** (the first version followed the controller's correction before the card was rewritten):
1. **No stand-in start point.** The first version offered "lowest invert, not proven" and "the one open-ended pipe". The card (decision 2) says no LPD drawn means CE asks you to place or pick it, and does not offer the lowest pit. Cases H2 and H28 now say so.
2. **Nothing is drawn.** The first version had a marker on a no-plot layer. The card (decision 5) says the LPD callout you already draw is the marker and nothing extra is drawn. The marker cases are gone; H23 now proves nothing is added.
3. **Escape** carries on in today's way and prints one warning line, "LPD not confirmed, order may differ" (decision 3). Case H8.
4. **No new store.** The card says "confirmed" is one extra fact on a record that already exists, added in a way older versions ignore, and that if this cannot be done it is BLOCKED and comes back as a design question. New cases H10 to H15 and H29 test exactly that.
5. **Two LPDs** are each confirmed once (decision 4), not "no proposal, pick one". Case H12 and H21.
6. **New from the card:** the plain reason when CDLPD cannot write (H14); "needs checking" when the LPD's pipe or pit is not in this drawing (H17, H19); the solver's pit-name search only when no LPD is stored (H7); the setting "Tools start from the confirmed LPD" (H22).
7. **Words are the card's words.** Where a case gives a line, it is the card's line. Where the card gives no words, the case says "words not fixed" and marks only the facts.

---

# FOR TIM

**These checks prove the LPD is asked about once per job, stored once in the drawing, used by every tool, never replaced by a guess, and that pressing Escape never stops your work.**

1. **32 robot cases** (section 2), each with a deliberately faulty partner that must fail, or marked RECORD.
2. **The proof that matters:** after you confirm once, CDRENUMBER, the solver and the long section all start from the LPD with no second question (H5), and a pit that happens to be renamed "LPD-3" does not fool the solver (H7, with a faulty twin built on exactly today's fault).
3. **No new stored thing, tested directly:** H10 to H15 list everything the drawing holds before and after confirming. The only difference allowed is one extra fact on a record that already exists. If CE has to make a third record, the case fails.
4. **Not known, so only recorded:** what one U does after confirming; whether the Pit Schedule order now follows the LPD; what happens to the confirmation if the LPD callout is moved; how many real jobs have two LPDs.

---

## 1. What is being proven

1. **The proposal is true and repeatable.** Same drawing, same question, same words, every time.
2. **Confirming is a deliberate act.** Nothing is stored without your yes.
3. **One stored fact per LPD,** on a record that already exists, read by every tool, in any AutoCAD year, after save and reopen.
4. **Escape never blocks.**
5. **Nothing is drawn, and neither old record form is converted.**
6. **A confirmation whose pipe or pit is not in this drawing is never shown as confirmed.**

## 2. The robot cases

### Group A: the question

**H1. A drawn LPD is proposed, in the card's words**
1. **Drawing:** MD-01 (the LPD drawn with CDLPD at the end of the outlet pipe).
2. **Do:** run CDRENUMBER (a tool that needs the start point). Read the command-line reading and the record reading.
3. **Right:** the question is "CE found the LPD on the pipe leaving P1. Is this the start point?" (card, "after"). It says LPD, not "outlet pit". Nothing is stored yet: record reading and drawing reading identical to before the question.
4. **Faulty partner:** a build that stores the answer before you say yes. The record reading differs and the case fails.

**H2. No LPD drawn: CE asks you to place or pick, and offers no stand-in**
1. **Drawings:** MD-19 (no LPD, no outlet pipe), MD-20 (no inverts, no LPD), and a copy of MD-01 with the LPD removed and the outlet pipe left.
2. **Do:** run CDRENUMBER on each.
3. **Right:** on all three the line is "No LPD in this drawing. Place it now, or press Esc to carry on without one." (card section 1, item 2). No pit is proposed as the start point. The words "lowest", "invert" and "not proven" never appear in the command-line reading. RECORD: on the copy with the pipe left, whether the question also points at the open pipe end (the card does not say).
4. **Faulty partner:** a build that proposes the lowest-invert pit when no LPD exists (the first version of the card did). It must fail on MD-01-without-LPD.

**H3. Nothing is asked on opening**
1. **Drawing:** MD-01, MD-24 and MD-03, each opened fresh.
2. **Do:** open and wait for CE's opening jobs to finish. Do not run any tool.
3. **Right:** no question about the start point (card, "Trigger": never on opening). Record reading identical before and after.
4. **Faulty partner:** a build that asks on opening. Must fail.

**H4. Same answer every time**
1. **Drawings:** MD-01, MD-08, MD-24, MD-25, MD-26.
2. **Do:** run the question twice on fresh copies on LOGIN-1, then on a second Windows login with different personal Settings.
3. **Right:** the same question word for word, naming the same pipe, in every run.
4. **Faulty partner:** a build that breaks a tie by the order objects were stored in the drawing. A shuffled copy would give a different answer and fail.

### Group B: confirming, and every tool starting from it

**H5. One question per job; three tools start from it**
1. **Drawing:** MD-01.
2. **Do:** answer Yes once. Save, close, reopen. Run CDRENUMBER (preview, then No), the solver (CDRUNSOLVE) and the long section (CDPROFILE). Count questions about the start point in the command-line reading.
3. **Right:** after "LPD confirmed on the pipe leaving P1." there is no second question. CDRENUMBER counts up from P1, the first pit upstream of the LPD (P1 first, then P2 and so on, from the answer sheet). The solver stops at the LPD. The long section begins at the LPD end.
4. **Faulty partner:** one build where CDRENUMBER still asks, one where the solver starts from a different pit, one where the long section starts from the lowest invert. Each must fail by tool.
5. **Also, when step 8 exists:** the LPD step inside Check this drawing asks once and a drawing already confirmed is not asked again. NOT RUNNABLE until TRUST-08 slice B is built.

**H6. The Pit Schedule order (RECORD)**
1. **Drawing:** MD-01 confirmed, MD-21 (pits P1, P2 and P10 to P17) confirmed, and a copy of MD-01 with one pit renamed LPD.
2. **Do:** open the Pit Schedule and read the row order.
3. **Right:** RECORD. The card's "before" lists "the Pit Schedule puts a pit literally named LPD first and ignores the LPD you drew" as a fault, but its "after" does not say the Schedule now follows the LPD. Installed order today: your dragged order, otherwise pits named LPD, then OG, then P numbers (CODE_FACTS section B). The robot writes down what the schedule does after confirming and puts it to Tim. Not a pass or a fail.
4. **Faulty partner:** none until there is a ruling.

**H7. The "LPD in the pit number" trap**
1. **Drawing:** MD-27 (pit P3 renamed LPD-3; the LPD drawn at P1).
2. **Do:** (a) confirm the LPD at P1, run CDRUNSOLVE. (b) On a fresh copy confirm nothing, run CDRUNSOLVE.
3. **Right:** (a) the solver starts from P1 and stops at the LPD; the pit named LPD-3 plays no part. (b) with no LPD stored the solver may use the pit-name search and then says it was "found by pit name, not confirmed" (card section 3, item 2). The pit-name text is a setting and is used only when no LPD is stored.
4. **Faulty partner:** the installed build, which finds the outlet by a pit whose number contains "LPD" even when an LPD is drawn. It would start at P3 in (a) and must fail.

**H8. Escape at the question**
1. **Drawing:** MD-01 (LPD drawn, not confirmed) and MD-19 (no LPD).
2. **Do:** run CDRENUMBER and press Escape at the question. Then run the solver and press Escape. Read the record reading, drawing reading and command line.
3. **Right:** nothing is stored (record reading identical). The tool carries on the way it does today: with the robot giving today's answer to today's own question, the result equals what the installed build gives for the same drawing. One warning line, "LPD not confirmed, order may differ", appears once per tool. Nothing stops.
4. **Faulty partner:** (a) a build that stores the proposal when Escape is pressed (card check 9); (b) a build that stops the tool dead; (c) a build that carries on without the warning line. Each must fail.

**H9. Confirm, then U (the promise is tested, not trusted)**
1. **Drawing:** MD-01.
2. **Do:** confirm. Read the drawing reading and record reading. Press U once. Read both again.
3. **Right:** the confirming line must not say or hint that U undoes it (card section 2, item 3). If one U returns both readings exactly to the state before confirming, that is written down as a finding and the words may be added later. If it does not, no words appear. RECORD which. Nothing else in the drawing changes.
4. **Faulty partner:** a build that says "U undoes it" while the confirmation stays stored. Must fail.

### Group C: one stored thing, and the two record forms

**H10. Confirming on the older record**
1. **Drawing:** MD-24 (the LPD held as the older single record only).
2. **Do:** confirm. Read the record reading.
3. **Right:** the only change is one extra fact on that record. Every other value is identical. No newer-form record is created.
4. **Faulty partner:** a build that converts the older record into the newer form. The older record is gone and the case fails.

**H11. Confirming on the newer record**
1. **Drawing:** MD-25 (the newer set, no older record).
2. **Right:** as H10 the other way round: one extra fact on the outlet confirmed, no older record created, every other value identical.

**H12. Both record forms present; two LPDs**
1. **Drawing:** MD-26 (both forms, naming the same LPD), and a copy where the two forms name two different LPDs.
2. **Right:** on MD-26 the question is asked once for the one LPD and confirming edits neither record beyond one extra fact. RECORD which record carries the fact (the card does not say). On the copy with two LPDs: two questions, one per LPD (decision 4, DRAFT default), each confirmed on its own.
3. **Faulty partner:** a build that tries to write one form while the other exists. Each form refuses today. The case fails if the write is attempted.

**H13. An older drawing's LPD is a proposal, never already confirmed**
1. **Drawing:** MD-24 and MD-03 (old LISP-style job with a hand-placed LPD block).
2. **Right:** on MD-24 CE asks, as H1. It is never read as already confirmed (card section 1, item 1). On MD-03, RECORD whether a hand-placed block is found at all, because the card speaks only of an LPD drawn with CDLPD.
3. **Faulty partner:** a build that reads an existing LPD record as confirmed. The opening and the first tool would print no question and the case fails.

**H14. CDLPD cannot write: a plain reason, not "see CE log"**
1. **Drawing:** MD-25 (the newer record exists).
2. **Do:** run CDLPD to draw or move an LPD.
3. **Right:** the command line says in plain words why CDLPD cannot do it and what to do (card section 1, item 6). Words not fixed. It does not print "Error during CDLPD - see CE log for details". The reason is also in the log. Nothing in the drawing changes.
4. **Faulty partner:** the installed build, which prints exactly "Error during CDLPD - see CE log for details". **Written to FAIL on today's build.**

**H15. No third store**
1. **Drawing:** MD-01, MD-24, MD-25.
2. **Do:** before and after confirming, read every named dictionary, every extension record and every block definition in the drawing, not only CE's project record.
3. **Right:** the only difference is the one extra fact. No new dictionary, entry or object of any kind. If the build says "confirmed" cannot be added without changing what older versions read, the case is BLOCKED (card section 4, item 3), not failed, and nothing is stored.
4. **Faulty partner:** a build that writes the confirmation to a new dictionary entry. Must fail.

### Group D: after confirming

**H16. Save, close, reopen, on another login**
1. **Drawing:** MD-01 confirmed.
2. **Do:** save, close, reopen on LOGIN-1; then on a second Windows login.
3. **Right:** every tool gives the same LPD and nobody asks again. Record reading identical after each reopening.

**H17. Save As keeps it; a new job copied from an old one shows "needs checking"**
1. **Drawing:** MD-09 (Save As copy of a confirmed MD-01), and a copy of it with the whole network erased and a new one drawn.
2. **Right:** MD-09 reads as confirmed, because a revision should. In the copy where the old pipe and pit are gone, the confirmation shows as "needs checking", never as confirmed (card section 2, item 4). No tool starts from it as if confirmed.
3. **Faulty partner:** a build that shows the old confirmation as confirmed on the new network. Must fail.

**H18. Pits copied from another job bring no confirmation**
1. **Drawing:** MD-09-X (two pits copied from MD-01 into MD-08 through WBLOCK).
2. **Right:** MD-08 keeps its own confirmations only. The two foreign pits bring none from MD-01 (card section 2, item 8).
3. **Faulty partner:** a build that carries the confirmation inside the copied pit. Must fail.

**H19. Erase the LPD's pipe or pit**
1. **Drawing:** MD-01 confirmed, then the pipe leaving P1 erased (and a second copy with P1 erased).
2. **Right:** the opening line says "needs checking: the LPD's pipe is no longer in the drawing" (card section 1, item 4). No tool picks a new LPD by itself. The next tool that needs one asks again. NOT RUNNABLE on the build alone until the opening line (UX-OPEN-01) carries this wording; until then only the second half is checked.
3. **Faulty partner:** a build that quietly proposes and stores a new one. Must fail.

**H20. Change it later, never silently**
1. **Drawing:** MD-01 confirmed.
2. **Do:** run CDLPDRESET (the existing command), choose another position, then run it again and press Escape.
3. **Right:** the same question as the first time. A changed LPD is a deliberate act and is stored. Escape leaves the old one. Nothing changes without CDLPDRESET.

**H21. Two outlets**
1. **Drawing:** MD-08.
2. **Do:** confirm each network's LPD. Run each tool on a pit in each network.
3. **Right:** two confirmations. CE tells the networks apart by which pits and pipes drain to each (decision 4). Each tool uses the right LPD for the pits in hand. A pit in network 1 is never numbered from network 2's LPD.
4. **Faulty partner:** a build that uses the first confirmation for every pit. Must fail on network 2.

**H22. The setting "Tools start from the confirmed LPD"**
1. **Drawing:** MD-01 confirmed.
2. **Do:** read the Settings reading (default). Turn it off and run CDRENUMBER. Turn it on and run it again. Read the record reading after each.
3. **Right:** default on. Off: CDRENUMBER behaves as the installed build, asking which pit is the outlet. On: it does not ask. Switching off removes nothing: the stored confirmation is still in the record reading (card section 3, item 1).
4. **Faulty partner:** a build that ignores the switch, and a build where off deletes the confirmation.

### Group E: where it can go wrong in a real drawing

**H23. Nothing is drawn, so locked and frozen layers are untouched**
1. **Drawing:** MD-01, MD-18 (pipe layer locked) and MD-18-V (pit layer frozen).
2. **Do:** confirm on each. Read the drawing reading before and after.
3. **Right:** the confirmation is stored. The drawing reading is identical: no object added, no layer changed, nothing unlocked or thawed (card section 2, item 6; decision 5).
4. **Faulty partner:** a build that draws a marker, and a build that unlocks the layer to do it. Each must fail.

**H24. An LPD inside an Xref**
1. **Drawing:** MD-10.
2. **Right:** CE says an LPD inside an attached drawing cannot be confirmed from the host (card section 2, item 7). Nothing is stored. The Xref is untouched.

**H25. Units**
1. **Drawing:** MD-05-MM, MD-05-M, MD-05-U.
2. **Right:** the same question naming the same pipe in all three. MD-05-U: RECORD any difference.

**H26. The LPD callout is moved (RECORD)**
1. **Drawing:** MD-01 confirmed, then the LPD callout moved 3 m with MOVE (the pipe and pit stay).
2. **Right:** RECORD. The card ties the confirmation to the LPD's pipe or pit (section 2, item 4), so the callout moving alone is not stated. The robot writes down whether the confirmation still reads as confirmed and puts it to Tim.

**H27. Read-only file and a file open elsewhere**
1. **Drawing:** MD-14 and MD-14-L.
2. **Right:** CE reads the LPD and uses it for this session, and says it could not store the confirmation (card section 2, item 5). File hash and saved time identical. Nothing new in the folder.
3. **Faulty partner:** a build that says "LPD confirmed" and is silent about not storing it. Must fail.

### Group F: the plan's standing cases

**H28. CDRENUMBER when no pipe leaves the network (BUG-1237)**
1. **Drawing:** MD-19.
2. **Right:** it asks for the LPD, as H2, instead of stopping with no help (decision 6). Escape: the warning line of H8. RECORD what today's behaviour prints on this drawing, because "carries on as today" is defined by it.
3. **Faulty partner:** the installed build, which stops with no help. **Written to FAIL on today's build.**

**H29. Another CE version opens a confirmed drawing**
1. **Drawing:** MD-01 confirmed, taken to a test login with the previous Civil build (3.0.90).
2. **Do:** open, run CDLPD (draws or reads), open the Pit Schedule, save a copy.
3. **Right:** CDLPD and the Pit Schedule still work there (card section 5, item 7). The saved copy still holds every earlier fact. RECORD whether the confirmation survives that save and whether the older build shows it. Never run on a real PC.
4. **Faulty partner:** a build whose extra fact makes the older build refuse to open the LPD record. Must fail.

**H30. Paper space, spoiled blocks, a job over two drawings**
1. **Drawing:** MD-11, MD-12, MD-16.
2. **Right:** a layout is never read for the LPD. In MD-12 the exploded P4 does not change the question. In MD-16 each file asks about its own LPD, or says there is none when the LPD is in the other file. RECORD the wording.

**H31. A hidden command typed from habit**
1. **Drawing:** MD-01 confirmed.
2. **Do:** type CDLPD, CDLPDRESET and CDRENUMBER.
3. **Right:** each reads the stored confirmation and none re-asks or re-proposes in a way that disagrees with it.

**H32. AutoCAD 2022 to 2024**
1. **Do:** H1, H5, H8, H10, H16 and H23 on 2024.
2. **Right:** the same question, the same stored fact, the same results.

## 3. The gaps the review found, answered

1. **Reading alone is not enough.** H5 runs three tools after confirming and reads where each really starts. H10 to H12 and H15 read every record after the one edit (the confirmation).
2. **The same jobs taught and tested.** The start point has fixed rules, nothing learned. MD-03 is for testing only.
3. **"Sent" is not "worked".** H5 reads where each tool started, not that a question was answered.
4. **Undo compared on linework.** H9 compares the full drawing reading after one U. H23 compares it after confirming.
5. **Twice, identical.** H4.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** H27.
2. **Save As and copied pits:** H17, H18.
3. **Units:** H25.
4. **Xref:** H24.
5. **Paper space:** H30.
6. **A hidden command typed from habit:** H31.
7. **Another CE version:** H29.
8. **Spoiled blocks:** H30.
9. **A job over several drawings:** H30.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** the question on MD-01, MD-19 and MD-08; the lines printed after confirming and after Escape.

**What to look at, and what right looks like:**
1. **The question** is one decision in drafting words, names the LPD and the pipe it is on, and has an obvious Yes. Right = no software word, nothing about records or stores.
2. **"No LPD in this drawing. Place it now, or press Esc to carry on without one."** reads as an offer, not a stop. No pit is suggested.
3. **After confirming** one line, "LPD confirmed on the pipe leaving P1.", and the next tool starts quietly. Right = you are asked once per job, not once per tool.
4. **The warning after Escape**, "LPD not confirmed, order may differ", is one calm line and the tool visibly carries on.
5. **Nothing new appears on the plan** after confirming.
6. **Two outlets:** the question names which network each LPD belongs to, so you can tell them apart.
7. **The refused-write line** (H14) says why and what to do in drafting words.

**Screenshots:** `START07_question_md01.png`, `START07_no_lpd_md19.png`, `START07_two_outlets.png`.

**Cannot be proven without Tim:** that the LPD CE proposes is the one he would have drawn on real jobs, that he is asked once per job and not once per tool, and the two-outlet rules on a real two-outlet job (none is known yet).
