# Cases for UX-OPEN-01: the opening line

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from the card `04_REFERENCE\ux-plan\cards\UX-OPEN-01_DRAWING_STATE_LINE_CARD_2026-11-06.md` and installed Civil 3.0.90 (commit cf059dcf, read-only copy). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings used:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD codes, record reading, drawing reading, changed counter, faulty partner, RECORD).

---

# FOR TIM

**These are the checks that prove the opening line tells the truth and changes nothing. Each has a deliberately faulty twin that the check must catch.**

1. **28 robot cases** (section 2), on made-up drawings only.
2. **One look by eye** from Codex on four drawings (section 4). It cannot be done by the robot, because only a person can say whether the line reads clearly.
3. **Three things the card does not say, so the robot only records them:** how downpipes and tanks are counted in the line; whether a legend sample on a layout counts as a pit; what the line says when a pipe runs into another drawing of the same job. Each is marked RECORD below and goes to you as a question, not a pass or fail.
4. **Where the line can still lie, even after every case passes:** on a real old job nobody has opened. The made-up old jobs are only my guess at what old jobs hold. Your five-job look on real jobs is still needed.

---

## 1. What is being proven

1. **The line is true.** Its counts equal what is really drawn, read from the answer sheet made when the drawing was built.
2. **The line equals CDCHECKCURRENT.** The card says they share one check. The numbers must match.
3. **The line changes nothing.** Not the drawing, not CE's record, not the file, not the changed counter, and not Redo.
4. **The line stays quiet where it should,** and says "could not check" rather than a wrong number.

## 2. The robot cases

Each case: the drawing, what to do, what to read back, what right is, and the faulty partner that must fail.

### Group A: the line is true

**O1. Clean current job, all linked**
1. **Drawing:** MD-01.
2. **Do:** open the fresh copy. Wait for the line.
3. **Read back:** command-line reading; record reading and drawing reading before and after; changed counter.
4. **Right:** the line says 6 pits and 6 pipes and "all linked" (wording from the card: `CE: 6 pits, 6 pipes, all linked.`). The outlet pipe that ends at the LPD does not count as "not linked" (card, not known item 4). Both readings identical before and after. Counter unchanged.
5. **Faulty partner:** a build that counts a pipe ending at the LPD as unlinked. It must print "needs checking" on MD-01 and fail.

**O2. One stray line on the pipe layer**
1. **Drawing:** MD-02.
2. **Do:** open. Then run CDCHECKCURRENT and read its palette.
3. **Read back:** the line, and the number of items the palette shows for "no CE record".
4. **Right:** the line says needs checking and names 1 item. The number equals the palette's number. The wording is not fixed by the card, so only the number and "needs checking" are marked.
5. **Faulty partner:** a build that counts only what is in CE's record and ignores what is drawn. It says "all linked" on MD-02 and must fail. (This is the review's hole 3: the existing check cannot see drawn lines that are not recorded.)

**O3. Old LISP-style job, no CE record**
1. **Drawing:** MD-03.
2. **Do:** open.
3. **Read back:** command-line reading; drawing reading before and after (allowing only the pit symbol swap that opening does today, see O22).
4. **Right:** a line appears that says 4 pit blocks were found and there is no CE record, and says nothing has been changed by this check (card line 3). It does not say "all linked". Whether it also counts the 3 pipe lines is not stated by the card: RECORD what it prints. If it prints a number for them, the number must be 3.
5. **Faulty partner:** a build that prints nothing for a drawing with no record. Must fail (the review's hole 3 says an old job may get no line at all).

**O4. Hand-drawn job, no CE tools**
1. **Drawing:** MD-04.
2. **Do:** open.
3. **Read back:** command-line reading; record reading (there is none).
4. **Right:** the line never says "all linked". It never counts the five PIT blocks as CE pits. If it says nothing, that is allowed. If it says something, no count is higher than what CE can recognise (0 CE pits).
5. **Faulty partner:** a build that counts any block with PIT in its name as a pit. Must fail with "5 pits".

**O5. Two answers possible: copied pits from another job**
1. **Drawing:** MD-09-X (two pits from MD-01 brought into MD-08 through WBLOCK).
2. **Do:** open.
3. **Read back:** the line; the record reading (the 2 pits are not in this drawing's record).
4. **Right:** needs checking, naming 2 pits that have CE identity but no entry in this drawing's record. The line does not say "all linked".
5. **Faulty partner:** a build that trusts the block's identity alone. It says "all linked" and must fail.

**O6. Pits with no object, one pit exploded**
1. **Drawing:** MD-12.
2. **Do:** open.
3. **Read back:** the line against the MD-12 answer sheet: P4 exploded, P5 mirrored, P6 rotated, one pit scaled, one block not CE's.
4. **Right:** needs checking, 1 pit with no object (P4 exploded). P5, P6 and the scaled pit still count as pits and are linked. The block named PIT_SUMP_OTHER is not counted as a pit.
5. **Faulty partner:** a build that counts every block with "PIT" in its name. It would count the other company's block and fail.

**O7. Counts equal the answer sheet on three sizes**
1. **Drawing:** MD-01, MD-08 (two networks), MD-07 (plastic pits).
2. **Do:** open each.
3. **Right:** MD-08 counts 6 pits and the right pipes across both networks. MD-07 counts all 6 pits, plastic ones included (the plastic pit rule is about the schedule, not about whether a pit exists). RECORD the pipe count for MD-08, because the card does not say whether a two-network job gets one line or two.
4. **Faulty partner:** a build that leaves plastic pits out of the count. Must fail on MD-07 with 3 pits.

**O8. Downpipes and tanks: how they are counted**
1. **Drawing:** MD-01-DP.
2. **Do:** open.
3. **Right:** RECORD. The card counts "pits, pipes" only. The installed check treats a water tank like a pit. The robot writes down what the line says for 2 downpipes and 1 tank and puts it to Tim. It is not a pass or a fail.

### Group B: the line changes nothing

**O9. Nothing written to the drawing**
1. **Drawing:** MD-01, MD-02, MD-03.
2. **Do:** record the changed counter at the moment CE's opening jobs finish, then again straight after the line.
3. **Read back:** counter before and after; drawing reading and record reading before and after the line.
4. **Right:** counter identical. Both readings identical. (On MD-03, opening itself changes pit symbols today; the check is of the line, so the counter is read at the end of the opening jobs, not at open.)
5. **Faulty partner:** a build that stamps "checked" into the drawing. It moves the counter and must fail.

**O10. Open and close, no questions**
1. **Drawing:** MD-01.
2. **Do:** open, wait for the line, close with CLOSE and no edits.
3. **Right:** AutoCAD asks nothing about saving. File reading identical (same hash, no new file in the folder).
4. **Faulty partner:** the same stamping build. It leaves the drawing marked changed, AutoCAD asks "save changes?", and the case fails.

**O11. Redo survives (the guard for BUG-256)**
1. **Drawing:** MD-01.
2. **Do:** open, wait for the line, draw one test LINE, press U (the line goes), then REDO.
3. **Read back:** object count after each step.
4. **Right:** REDO brings the line back (count up by 1). Then switch to MD-02, open it, switch back, repeat U and REDO. Same.
5. **Faulty partner:** a build whose check takes an undo step or clears the redo list. REDO does nothing, and the case fails.

**O12. Undo does not remove the line's effect, and adds no step**
1. **Drawing:** MD-01.
2. **Do:** open, wait for the line, press U once straight away.
3. **Right:** AutoCAD says there is nothing to undo (or the undo list is as before). No object is removed.
4. **Faulty partner:** a build that makes its check a numbered undo step. U would undo "something" and the drawing reading would differ.

**O13. Read-only file**
1. **Drawing:** MD-14.
2. **Do:** open.
3. **Read back:** the line; file reading before and after; folder listing.
4. **Right:** the line shows. File hash and saved time identical. No new file next to it.
5. **Faulty partner:** a build that tries to write a note into the file. It either errors or changes the folder, and fails.

**O14. Drawing locked by another session**
1. **Drawing:** MD-14-L (open in a second AutoCAD session first).
2. **Do:** open the second copy read-only when AutoCAD offers it.
3. **Right:** the line shows. No lock file is created or removed by CE. File hash identical.

### Group C: the line stays quiet or says "could not"

**O15. Structural drawing: nothing**
1. **Drawing:** MD-15.
2. **Do:** open.
3. **Right:** no CE line in the command-line reading. Then type PIT: CE asks "Is this a Civil drainage drawing?" (the gate stays, TRUST-02 section 1). Press Escape: drawing reading identical.
4. **Faulty partner:** a build that prints a Civil line on a Structural drawing. Must fail.

**O16. CE tools stay available on a quiet drawing (Tim, 7 Nov)**
1. **Drawing:** MD-15-B (blank).
2. **Do:** open. Type three CE tools that are useful on any drawing (for example CDHELP, CDS, CEBLOCKS).
3. **Right:** each starts. No line appears on open. The command list registered in MD-15-B equals the list registered in MD-01.
4. **Faulty partner:** a build that switches off CE commands where it stays quiet. Must fail.

**O17. Large drawing above the size limit**
1. **Drawing:** MD-01 with the Settings limit set to 10 objects (so the drawing is "large"); then MD-13 at the real limit.
2. **Right:** with the low limit, MD-01 prints `CE: large drawing, not checked on opening. Type CDCHECKCURRENT to check it.` and nothing is counted. With the limit high, it prints the counts. For MD-13 at the real limit: RECORD the open time with the line on and off, and which line is printed. The limit has no value yet (card, not known 1), so MD-13 gives no pass or fail until it is set.
3. **Faulty partner:** a build that counts anyway when above the limit. The time with the low limit would not drop, and the case fails.

**O18. The check cannot run**
1. **Drawing:** MD-22 (damaged record).
2. **Do:** open.
3. **Right:** the drawing opens normally and is usable. The only CE line is `CE: could not check this drawing.` No count. The reason is in the CE log. Drawing reading before and after identical.
4. **Faulty partner:** a build that prints counts from a half-read record. Must fail.

**O19. Switch off**
1. **Drawing:** MD-01.
2. **Do:** set "Say what state a drawing is in when it opens" to off in the settings file, restart AutoCAD, open.
3. **Right:** no line. Settings reading shows the value off. Turn it on again: the line returns.
4. **Faulty partner:** a build that ignores the switch.

**O20. Batch work and scripts**
1. **Drawing:** MD-01.
2. **Do:** open it from a script (SCRIPT with OPEN) and again in a headless run (accoreconsole).
3. **Right:** no line (skipped when no one is at the screen).
4. **Faulty partner:** a build that prints in a script. Must fail.

### Group D: the second line, and the other real-job cases

**O21. Once per drawing per session**
1. **Drawing:** MD-01 and MD-02 both open.
2. **Do:** switch tabs three times.
3. **Right:** the command-line reading holds one line per drawing, not more.
4. **Faulty partner:** a build that prints on every tab switch.

**O22. The pit swap line, only when something was swapped**
1. **Drawing:** MD-03 (older pit blocks) and MD-01 (current).
2. **Do:** open each.
3. **Read back:** the block definitions before and after (drawing reading); the command line.
4. **Right:** on MD-03, if the pit symbols were swapped, a second line says so (`CE: pit symbols were updated when this drawing opened.`). On MD-01, nothing is swapped and no second line appears. The line is printed if and only if a block definition really changed.
5. **Faulty partner:** a build that prints the line every time. It fails on MD-01.

**O23. Units: millimetres, metres, not set**
1. **Drawing:** MD-05-MM, MD-05-M, MD-05-U.
2. **Right:** the same counts on all three, identical to MD-01's. In particular the metre copy does not leave a pit "with no object" because a reach was read in the wrong unit.
3. **Faulty partner:** a build with a reach fixed at 2000 drawing units. In the metre copy it would see every label as in reach. It must give different counts and fail.

**O24. An attached drawing (Xref)**
1. **Drawing:** MD-10.
2. **Do:** open.
3. **Right:** the host has no CE pits, so no pits are counted from the Xref and no fault is raised about it. The Xref layers' states are identical before and after (drawing reading). Nothing is detached, reloaded or unlocked.
4. **Faulty partner:** a build that counts the Xref's pits. It prints 6 pits on a host that has none.

**O25. Paper space**
1. **Drawing:** MD-11.
2. **Do:** open, then make a layout current, then run CDCHECKCURRENT.
3. **Right:** the counts equal MD-01's model-space counts. Whether the legend sample on the layout counts as a pit is not stated by the card: RECORD which, and put it to Tim.

**O26. A job over two drawings**
1. **Drawing:** MD-16, both files.
2. **Right:** RECORD. The pipe from P3 to P4 ends at a pit that is in the other file. The card (not known item 4) does not say whether that is "not linked". The robot writes down what each file's line says. Nothing is marked pass or fail, and no number is claimed wrong without a ruling.

**O27. A drawing last written by another version**
1. **Drawing:** MD-17-OLD and MD-17-NEW.
2. **Right:** OLD gives the same counts as MD-01. NEW says `CE: could not check this drawing.` or the same counts if it can read them; it never gives a different count as if it knew. Drawing reading identical in both. The installed CE writes nothing back into either.
3. **Faulty partner:** a build that reads a newer record as an empty one and says "no CE record". Must fail on MD-17-NEW.

**O28. Same answer twice, on two logins**
1. **Drawing:** MD-01, MD-02, MD-03, MD-12.
2. **Do:** open each twice from fresh copies on login 1; then on a second Windows login with the dark theme, a different workspace and different personal Settings.
3. **Right:** the line text is identical in all runs, word for word. Check this after the settings are different, because the card says the check ignores personal settings.
4. **Faulty partner:** a build whose size limit comes from a per-login value. The two logins would differ on MD-13 (or on a low limit) and fail.

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** O11 and O12 make an edit (draw a line, press U, REDO) after the line has printed and read the drawing again. Anything that moved besides that line fails.
2. **The same jobs taught and tested.** The line has no list of old block versions to teach. For O3 and O4 the made-up old drawings (MD-03, MD-04) are kept back for testing only. If any later rule is added to count old pits, two new made-up old drawings are held back for it.
3. **"Sent" is not "worked".** O2 and O5 read the numbers in the line and compare them with the answer sheet, not just whether a line printed.
4. **Undo was not compared on linework.** O11 and O12 compare the whole drawing reading, not only CE's record.
5. **Twice, identical.** O28.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** O13, O14.
2. **Save As and copied pits:** O5. (A plain Save As copy of MD-01, MD-09, gives the same line as MD-01: run it inside O1.)
3. **Units not set or wrong:** O23.
4. **Xref:** O24.
5. **Paper space:** O25.
6. **A hidden command typed from habit:** not part of the line. O16 proves CE tools still run where the line stays quiet.
7. **Another CE version last touched it:** O27.
8. **Exploded, scaled, mirrored or rotated blocks; other people's blocks named like pits:** O6.
9. **One job over several drawings:** O26 (RECORD).

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** MD-01, MD-02, MD-03, and MD-01 with the low size limit.

**What to look at, and what right looks like:**
1. **One clean line each,** in the command line, in drafting words. Right = no word like record, handle, dictionary, object ID or xrecord. Right = the words match the card's wording.
2. **It does not wrap** at the normal command-line width, and it is not buried: it is the last CE line after opening, or near it.
3. **Needs checking reads as a call to act,** not an error: it says what (for example "1 line on the pipe layer is not in CE's record") and says to type CDCHECKCURRENT.
4. **The old LISP drawing line** says nothing has been changed by this check.
5. **The second line** (pit symbols updated) appears on MD-03 only.
6. **Opening speed:** the drawing opens without a pause the eye can notice on MD-01. Write down the pause on a large drawing if there is one. A pause is a note, not a fail, until the size limit is set.

**Screenshots:** kept as `OPEN01_MD01_line.png` and so on, never a job name.

**Cannot be proven without Tim:** whether the counts match what he knows of five real jobs, and whether the line is read or ignored by the third day. That stays his three working days.
