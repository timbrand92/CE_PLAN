# Cases for TRUST-08: Check this drawing

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-08_CHECK_THIS_DRAWING_CARD_DRAFT_2026-11-12.md`, the reader design, the test set and installed Civil 3.0.90 (commit cf059dcf). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD-29 and MD-30 are added there for this card).
**The card builds Check this drawing in four parts:** A the list (read only), B Apply for links, C Apply for the record, D bringing an old drawing up to date. The cases are grouped the same way. A case for a part is only run when that part is built.
**Defaults taken for Tim (DRAFT, he confirms):** CDSYNC and CDREBUILD stay typed and direct until part C is accepted (card decision 1); everyday tools on a drawing that needs checking say so and carry on, never block (2); one Apply does only what is ticked, and part D is always its own Apply (3); with unsaved changes CE warns and lets you carry on (4); opening a drawing only reads, and the pipe conversion and pit symbol update become rows here (answered 12 Nov, B5).

---

# FOR TIM

**These checks prove the list tells the truth, that Apply does only what you ticked, that one U puts it all back, and that nothing wrong can be passed off as Sure. They are the gate for the first colleague release, so they are the longest set.**

1. **40 robot cases written** (section 2), and one (K26) deliberately not written, on made-up drawings and, when you pick them, your test jobs T01 to T10.
2. **The single most important case is K41:** every job in the set is read before and after the step, and anything that read right before must read the same after. One item that got worse blocks the step.
3. **"Nothing changes on open" is a case (K27).** Today's build swaps pit symbols and converts pipes when a drawing opens. That case is written to fail on today's build.
4. **The backup is tested by using it** (K18): the robot opens the backup and compares it with the drawing as it was saved. It also tests the case where the backup cannot be made.
5. **Not written yet, on purpose:** the three "fix" rows in part D (repeated tags, flattened pipes, swapped pipe ends). The card does not say exactly what each does, so no honest case can be written. K26 says so.
6. **Not known, so only recorded:** what U does after an Apply from a window; how many rows a typical revision produces; what a real old drawing holds.

---

## 1. What is being proven

1. **The list is true.** Nothing wrong is shown as Sure, every Proposed has a true reason, every Unknown is really not in the drawing.
2. **Reading changes nothing.**
3. **Apply does exactly what was ticked,** is backed up first, and one U takes it back, linework included.
4. **Protected things are left alone:** locked layers, Xrefs, REFEDIT.
5. **Two answers are never settled for you.**
6. **Opening a drawing only reads.**

## 2. The robot cases

### Part A: the list (read only)

**K1. Nothing to do: no window**
1. **Drawing:** MD-01.
2. **Do:** press Check this drawing.
3. **Right:** the line `CE: all linked. Nothing to check.` and the window does not open. Record reading and drawing reading identical before and after.
4. **Faulty partner:** a build that opens an empty window. Must fail.

**K2. A stray line**
1. **Drawing:** MD-02.
2. **Right:** Sure holds the 6 pits and 6 pipes. Proposed holds 1 row: the plain line, with the reason "on the stormwater pipe layer". Nothing ticked. The count in each group equals the answer sheet.

**K3. Old LISP-style job: nothing is Sure**
1. **Drawing:** MD-03.
2. **Right:** Sure is 0. The 4 pit blocks are Proposed or Unknown, each with a reason. The pipe that has exactly one pipe text in the fixed pattern is Proposed as 150 dia UPVC at 1 in 100, reason "read from its label". A pipe with no text, or with two texts that could both belong to it, has size Unknown. Every row is marked against the answer sheet with the five marks (Right, Unknown, Wrong, Invented, Proposed with a wrong value). Zero Wrong, zero Invented, zero wrong Proposed.
3. **Faulty partner:** a build that fills 100 on a pipe with no text, and a build that picks the nearer of two texts. Each must fail.

**K4. Hand-drawn job with no CE tools**
1. **Drawing:** MD-04.
2. **Right:** nothing is Sure. Nothing is invented: the five PIT blocks are not turned into pits. RECORD whether they and the lines on DRAIN-LINES are listed as unrecognised or not listed. The card says the reader should list what it met and did not recognise.

**K5. A label two pits could own**
1. **Drawing:** MD-06.
2. **Right:** an Unknown row naming both candidates (P3 at 600, P4 at 900). No tick box is ticked, and Apply cannot attach it to either by itself.
3. **Faulty partner:** a build that ticks the nearer. Must fail (the card's own broken version, check 8).

**K6. Spoiled blocks**
1. **Drawing:** MD-12.
2. **Right:** P4 (exploded) is a row "pit with no object". P5 (mirrored), P6 (rotated) and the scaled pit are Sure and linked. The block PIT_SUMP_OTHER is listed as an unrecognised block on a drainage layer, not as a CE pit and not ignored.

**K7. Opening the list and closing it changes nothing**
1. **Drawing:** MD-01, MD-02, MD-03, MD-12, MD-28.
2. **Do:** open the list. Close it.
3. **Right:** changed counter unmoved, drawing reading and record reading identical, no file written. (Card check 2.)
4. **Faulty partner:** a build that stamps "checked" into the drawing, or one that updates the record while building the list. Must fail.

**K8. Twice, identical, on two logins**
1. **Do:** build the list twice from fresh copies, then on a second login with different personal Settings.
2. **Right:** identical, row for row. (Card check 5.)
3. **Faulty partner:** a build that orders rows by memory address, or whose reach depends on the login.

**K9. Clicking a row**
1. **Drawing:** MD-01.
2. **Do:** click the row for P3.
3. **Right:** the view moves to P3 (P3 is inside the view and centred within a small tolerance). What lights up equals what P3 is linked to by the answer sheet: the P4 to P3 and P3 to P2 pipes and P3's label. The lighting is temporary: the drawing reading after is identical to before.
4. **Faulty partner:** a build that lights by adding real objects, and a build that zooms to the wrong pit. Each must fail.

**K10. A large job, and a heavy revision**
1. **Drawing:** MD-13 and MD-30.
2. **Do:** build the list. Press Escape while it builds. Build again and let it finish.
3. **Right:** a progress line shows. Escape stops cleanly with the drawing unchanged. RECORD the build time, the row count, and whether the window groups rows (the card says 200 rows needs grouping it does not yet describe). No pass or fail on time until a limit is set.

**K11. Score the list against the answer sheets**
1. **Drawing:** MD-01, MD-02, MD-03, MD-04, MD-06, MD-08, MD-12, MD-23, MD-28.
2. **Do:** mark every row with the five marks. Two of the made-up old drawings are kept back and were never used to make a rule.
3. **Right:** nothing wrong as Sure; every Proposed has a true reason and a right value; every Unknown is genuinely not in the drawing. Zero Wrong, Invented or wrong Proposed.
4. **Faulty partner:** a build with one wrong Sure, one invented pipe and one proposal with a wrong value. Each must fail with its mark.

### Part B and C: Apply

**K12. What Apply says before it acts**
1. **Drawing:** MD-29 (two pipe ends touch pits but are not linked).
2. **Do:** tick both rows. Read the statement before Apply.
3. **Right:** it says it will change 2 items in the drawing's CE data and move 0 objects, and that a backup will be made first (card wording). The robot checks the counts against its own planned difference.
4. **Faulty partner:** a statement that says 0 objects when Apply moves one. Must fail.

**K13. Apply the two links**
1. **Drawing:** MD-29.
2. **Do:** press Apply.
3. **Read back:** record reading and drawing reading before and after; file reading; changed counter.
4. **Right:** the two ends are linked to the right pits (answer sheet). The drawing reading differs by no geometry (nothing moved). The line says "Applied. Not saved yet." The changed counter is now non-zero and the file's hash is unchanged (CE does not save).
5. **Faulty partner:** a build that moves a pit to meet the pipe. Geometry differs, case fails.

**K14. Apply, then U once**
1. **Drawing:** MD-29, MD-02.
2. **Do:** Apply, press U once, compare the **full drawing reading** and the record reading with before. Then REDO.
3. **Right:** after U both readings equal the starting ones, exactly. After REDO they equal the applied state. The words "U undoes it" appear only if this is what the robot sees. (This is the plan's Undo question, answered here for Apply from a window.)
4. **Faulty partner:** a build that does an Apply in two steps, so one U leaves half of it. Must fail.

**K15. Apply, save, reopen**
1. **Drawing:** MD-29.
2. **Do:** Apply, save, close, reopen, build the list.
3. **Right:** the applied items are Sure. The list holds only what was not applied. Record reading equals the applied state.

**K16. Only what is ticked**
1. **Drawing:** MD-28 (several differences).
2. **Do:** tick one of three Proposed rows, Apply.
3. **Right:** only that row's change appears in the record difference. The other two are still Proposed in a new list. An unticked row never changes.
4. **Faulty partner:** a build that applies all rows.

**K17. Rows with one answer: tick state**
1. **Drawing:** MD-02, MD-29.
2. **Right:** RECORD whether single-answer link rows are ticked by default. The plan asks Tim whether "tick all" is allowed for links only. Two-answer rows are never ticked (K5).

**K18. The backup, used**
1. **Drawing:** MD-29 saved, then one unsaved edit E made.
2. **Do:** Apply. CE says "Save first so the backup is complete". Choose to carry on. After Apply, open the backup file the robot finds in the backup folder.
3. **Right:** a backup was made before Apply. Opened, its drawing reading equals the drawing **as last saved**, and does not contain E. CE said so before it went ahead. Save the drawing first and repeat: the backup now contains everything, and the warning does not appear. RECORD the backup's name, and where it is. The setting "Back up before Apply" is on and is not offered as off.
4. **Faulty partner:** a build that makes no backup, one whose backup is a different drawing, and one that stays silent about E.

**K19. The backup cannot be made**
1. **Do:** make the backup folder read-only, then Apply.
2. **Right:** Apply is refused with a plain line that the backup could not be made. Nothing is changed. (Back up first is not optional.)
3. **Faulty partner:** a build that applies anyway.

**K20. A stale row**
1. **Drawing:** MD-29 with the list open.
2. **Do:** erase one of the two pits the rows refer to. Then press Apply with both ticked.
3. **Right:** Apply re-checks, refuses the stale row with a plain line, and applies or refuses the other as the card says (RECORD which). It never links to an object that no longer exists or to a different object that took its place.
4. **Faulty partner:** a build that applies the stale row. Must fail.

**K21. Two drawings open**
1. **Drawing:** MD-02 and MD-01 both open.
2. **Do:** build the list on MD-02. Switch to MD-01. Try Apply.
3. **Right:** the list closes or re-reads for MD-01. MD-01's readings are identical. It never applies to the wrong drawing.
4. **Faulty partner:** a build that applies to whichever drawing is active.

**K22. REFEDIT**
1. **Drawing:** MD-10 with REFEDIT started on a block.
2. **Do:** open Check this drawing. Try Apply.
3. **Right:** the list can be read. Apply refuses with a plain line. Drawing reading identical.
4. **Faulty partner:** a build that applies inside REFEDIT.

**K23. Locked and frozen layers**
1. **Drawing:** MD-18 and MD-18-V.
2. **Right:** rows on the locked layer read "locked, left alone" and cannot be ticked. Layer states are identical after any Apply. Nothing is unlocked, thawed or turned on.
3. **Faulty partner:** a build that unlocks to apply.

**K24. An Xref**
1. **Drawing:** MD-10 with a fault inside the Xref.
2. **Right:** the row is listed for information and cannot be ticked. The Xref is not reloaded, detached, or edited.

**K25. A drawing with no CE record: Apply**
1. **Drawing:** MD-03.
2. **Do:** accept the Proposed rows, confirm the outlet, Apply.
3. **Right:** the record equals the answer sheet where the drawing gave a value, and Unknown where it did not. No 100. Each value carries its source. No geometry moves. One U returns everything.

### Part D: bringing an old drawing up to date

**K26. The three fix rows (not written yet)**
1. **Not written.** The card names repeated tags, flattened pipes and swapped pipe ends as rows but does not say what each does or looks like. No honest case can be written until part D is carded. Each row will then get a drawing, a read-back, a right answer and a faulty twin in the same shape as K13 and K14.

**K27. Nothing changes on open (expected to fail today)**
1. **Drawing:** MD-03 (older pit blocks and, on 2027, a pipe form that converts).
2. **Do:** open the fresh copy. Before touching anything read the changed counter and the block definitions.
3. **Right:** the changed counter is 0 and the block definitions equal the file as saved. No pit symbol was swapped and no pipe converted on open. The list has a row for each (pit symbols to update; pipes to convert on 2027). Tick them and Apply: now the symbols are swapped and the pipes converted. One U returns both.
4. **Faulty partner:** the installed 3.0.90 build, which swaps and converts on open. It must fail.

**K28. Mixing is not allowed**
1. **Drawing:** MD-03 plus MD-29-style link rows.
2. **Do:** tick one link row and one up-to-date row. Press Apply.
3. **Right:** the window runs two Applies or refuses to mix, as the card says (decision 3: part D is always its own Apply). U twice returns both. The record difference after each shows only that part's items.
4. **Faulty partner:** a build that does both in one step.

### Settings, old commands, and where the door sits

**K29. The typed commands keep working until Tim says**
1. **Drawing:** MD-02, MD-29.
2. **Do:** type CDSYNC, CDREBUILD, CDREBUILDLINKS, CDUPGRADE (Merge) and CDFIXPIPEENDS, each on a fresh copy, on the installed build and the new build.
3. **Right:** the record and drawing readings after the new build equal those of the installed build, value for value. The stay-separate commands (CDUPGRADE Replace, CDREFRESHBLOCKS, CDRECOVERINVERTS, CDXREFREPAIR, CDREFRESHLINKS, CDLEGACYAUDIT) are still there, typed only, unchanged. The button on the ribbon does not move.
4. **Faulty partner:** a build that removes CDSYNC.

**K30. "Tools update CE's record by themselves", off**
1. **Do:** when part C is accepted, turn it off on MD-02. Run Edit Pit.
2. **Right:** the record reading is identical after (no quiet update) and the tool says needs checking instead. Turn it on: today's behaviour returns. Settings reading shows both.

**K31. The outlet question inside the door**
1. **Drawing:** MD-01 unconfirmed.
2. **Do:** open Check this drawing, confirm, then Escape in a second run.
3. **Right:** the same question as TRUST-07 (cases H1 and H6). Escape stores nothing and carries on with a warning line.

**K32. Cancel at every point before Apply**
1. **Do:** press Escape or close at: the list; the outlet question; the "Before Apply" statement; the Save-first warning.
2. **Right:** record reading, drawing reading and changed counter identical to before each time.

### The plan's nine cases

**K33. Units**
1. **Drawing:** MD-05-MM, MD-05-M, MD-05-U.
2. **Right:** the lists are identical, row for row, for MM and M. MD-05-U: RECORD.

**K34. Paper space**
1. **Drawing:** MD-11.
2. **Right:** the legend pit on the layout is not listed as a model pit. RECORD whether it is listed as unrecognised.

**K35. Copies carrying another job's identity**
1. **Drawing:** MD-09-X.
2. **Right:** the two foreign pits are **not Sure**, even though they carry CE identity. They are Proposed ("pit block carries an identity from another drawing") or Unknown, with no tick by default. A plain Save As copy (MD-09) reads like MD-01.
3. **Faulty partner:** a build that trusts the identity alone. It lists them Sure and must fail.

**K36. A drawing last written by another version**
1. **Drawing:** MD-17-OLD and MD-17-NEW.
2. **Right:** OLD reads like MD-01. NEW says plainly that CE could not read the record and shows no wrong rows. Apply on NEW is refused.

**K37. One job over two drawings**
1. **Drawing:** MD-16.
2. **Right:** RECORD. Each file's list covers that file only. The P3 to P4 pipe, which ends at a pit in the other file, is listed as an end in another drawing, or as unlinked. The card does not say which.

**K38. Read-only file and a file open elsewhere**
1. **Drawing:** MD-14 and MD-14-L.
2. **Right:** the list builds. Apply works in memory only if CE says the file cannot be saved; RECORD the wording. The backup is made from the file as it is. File hash unchanged.

**K39. AutoCAD 2022 to 2024**
1. **Drawing:** MD-03 and MD-02 on 2024.
2. **Right:** the same window. The pipe conversion row says "needs AutoCAD 2027" and cannot be ticked. Everything else works.

**K40. Two logins**
1. **Do:** K2, K3 and K13 on a second Windows login.
2. **Right:** identical lists and results.

### The gate

**K41. The whole set, before and after (the gate)**
1. **Drawing:** every made-up drawing above and, when Tim has picked them, T01 to T10 (copies only).
2. **Do:** read every job with the step switched off, then on. For each job also make one ordinary edit on a fresh copy (open Edit Pit and close it; place one pit; draw one pipe) and read again.
3. **Right:** every item that read Right before reads Right after. Anything that changed in the drawing and was not the edit is a fault. Pass rules for the set are in `areas\TRUST_TEST_SET_12NOV.md` section 5: zero Wrong, zero Invented, zero wrong Proposed on every job; the drawing unchanged by reading; the same answer twice; on 2027 and on 2024. A result reads: "T03: pits 11 of 11 Right; pipes 13 of 14 Right, 1 Unknown, 0 Wrong, 0 Invented; ... PASS".
4. **Faulty partner:** a build that makes one Right item worse. It must stop the step.


## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** K41 makes an edit on every job and reads again. K14 and K15 read after an Apply and after a reopen.
2. **The same jobs taught and tested.** K11 and K3 keep two made-up old drawings back. Two of Tim's test jobs are held back for testing only (test set, section 4).
3. **"Sent" is not "worked".** K13 reads the link in the record after Apply; it does not accept that the button ran.
4. **Undo compared on linework.** K14 compares the full drawing reading after one U. K27 does the same for the pipe conversion and symbol swap.
5. **Twice, identical.** K8 and K40.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** K38.
2. **Save As and copied pits:** K35.
3. **Units:** K33.
4. **Xref:** K24.
5. **Paper space:** K34.
6. **A hidden command typed from habit:** K29.
7. **Another CE version:** K36.
8. **Spoiled blocks:** K6.
9. **A job over several drawings:** K37.

## 5. The look by eye (Codex, real AutoCAD 2027 and 2024, copies only)

**What to open:** the list on a small job (MD-01 with one stray line) and a large one (MD-30).

**What to look at, and what right looks like:**
1. **One glance tells you if the job is OK.** Sure is a count you can open, not a list to read. Right = you do not read 30 lines to learn nothing is wrong.
2. **Proposed rows read as sentences,** such as "Line on the Stormwater layer, 150 wide. Proposed: 150 pipe from P3 to P4, because both ends touch." Right = drafting words, a true reason, a tick box.
3. **Unknown rows say what is missing** and are easy to fill in.
4. **The window never scrolls its layout** (the high-use window rule): groups sit in tabs or regroup; the long row list may scroll.
5. **Locked rows look locked** and cannot be ticked; Xref rows read "for information".
6. **The Before Apply statement** is one clear sentence with counts, and Apply is not the default button.
7. **After Apply** one line with counts, "Not saved yet", and what U does (only if true).
8. **The Save first warning** is one decision.
9. **Colour and emphasis:** Unknown and the next action stand out; the window is calm at rest. Dark and light themes both read.
10. **2024:** the same window, with the 2027-only row greyed and the reason shown.
11. **No software words** anywhere in the window.

**Screenshots:** `CHECK08_list_small.png`, `CHECK08_list_large.png`, `CHECK08_before_apply.png`, `CHECK08_after_apply.png`, `CHECK08_locked_rows.png`.

**Cannot be proven without Tim:** that the Sure group is right on real jobs, that each proposal's reason is one he agrees with, and that the schedule matches the plan after Apply. That is the three days, then colleagues.
