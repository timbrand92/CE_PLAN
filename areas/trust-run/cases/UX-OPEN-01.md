# Cases for UX-OPEN-01: the opening line

**Status: DRAFT (second version, 12 Nov 2026), lane trust-test-cases.** Written from the card `04_REFERENCE\ux-plan\cards\UX-OPEN-01_DRAWING_STATE_LINE_CARD_2026-11-06.md` and installed Civil 3.0.90 (commit cf059dcf, read-only copy). **Nothing here was run.** Nothing is built, installed or accepted.
**Second version:** changed after two reviews of the first version and of the build (PR 2041, head 00c3baf5): `reviews\claude-trust-01-open-line.md` (FIX FIRST item 5) and `reviews\cases-UX-OPEN-01.md`. What changed is listed in section 6.
**Drawings and readings used:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD codes, record reading, drawing reading, changed counter, faulty partner, RECORD). MD-31 and MD-32 were added there for this file.

---

# FOR TIM

**These are the checks that prove the opening line tells the truth and changes nothing. Each has a deliberately faulty twin that the check must catch.**

1. **35 robot cases** (section 2), on made-up drawings only.
2. **One look by eye** from Codex on four drawings (section 5). Only a person can say whether the line reads clearly.
3. **Things the card does not say, so the robot only records them (RECORD):** how downpipes and tanks are counted in the line; whether a legend sample on a layout counts as a pit; what the line says when a pipe runs into another drawing of the same job; what a very large drawing with no CE record says; whether lines on the pipe layer with no pit blocks get a line; whether a script run inside a full AutoCAD gets the line. Each goes to you as a question, not a pass or fail.
4. **Cases the reviews asked for:** AutoCAD started by double-clicking a test drawing (O29); a good job with outlet and downpipe pipes must read "all linked" (O30); several drawings opened at once (O31); the switch off putting CDCHECKCURRENT back as it was (O32).
5. **Where the line can still lie, even after every case passes:** on a real old job nobody has opened. The made-up old jobs are only my guess at what old jobs hold. Your five-job look on real jobs is still needed.

---

## 1. What is being proven

1. **The line is true.** Its counts equal what is really drawn, read from the answer sheet made when the drawing was built.
2. **The line equals CDCHECKCURRENT.** The card says they share one check. The numbers must match.
3. **The line changes nothing.** Not the drawing, not CE's record, not the file, not the changed counter, and not Redo or Undo.
4. **The line stays quiet where it should,** and says "could not check" rather than a wrong number.

## 1b. How the robot waits and how it opens files (applies to every case)

1. **One fixed wait.** After a drawing opens, the robot waits for CE's own log entry for that drawing. The build writes a line starting `[OpenLine]` to the CE log every time it runs, including `[OpenLine] quiet (not a Civil drawing)`. The wait is 30 seconds.
2. **Quiet cases pass only on the log entry.** A "says nothing" case passes only when the `[OpenLine]` entry for that drawing is present and nothing was printed to the command line. No log entry within 30 seconds is BLOCKED, never PASS. This covers O4 (quiet half), O15, O16, O20, O24, O29 (blank start-up drawing), O33 and O34.
3. **How the robot opens a file.** The driver types OPEN at the command line for the fresh copy (as the driver does today; not re-checked here). It does not use a script unless a case says so, so the line is expected on every robot open. O20b is the only case that opens by script.
4. **A control run first where opening itself can change the drawing.** On 2027 a drawing whose pipes are not yet CE pipe objects is converted on opening and then asks to be saved whatever the line does, and an older pit symbol is swapped. So O10, O12 and O9 each run once with the line switched off as the control, and the line's effect is the difference between the two runs.

## 2. The robot cases

Each case: the drawing, what to do, what to read back, what right is, and the faulty partner that must fail.

### Group A: the line is true

**O1. Clean current job, all linked**
1. **Drawing:** MD-01.
2. **Do:** open the fresh copy. Wait for the log entry (section 1b).
3. **Read back:** command-line reading; record reading and drawing reading before and after; changed counter.
4. **Right:** the line says 6 pits and 6 pipes and "all linked" (card wording: `CE: 6 pits, 6 pipes, all linked.`). The outlet pipe that ends at the LPD does not count as "not linked" (card, not known item 4). Both readings identical before and after. Counter unchanged.
5. **Faulty partner:** a build that counts a pipe ending at the LPD as unlinked. It must print "needs checking" on MD-01 and fail.
6. **The other pipe ends that may be miscounted** (downpipe, tank, connection point) are tested in O30.

**O2. One stray line on the pipe layer**
1. **Drawing:** MD-02.
2. **Do:** open. Then run CDCHECKCURRENT and read its palette.
3. **Read back:** the line, and the palette's items by heading.
4. **Right:** the line says needs checking and counts the stray line under its own kind, as one line on a pipe layer that is not in CE's record (the build's words: "1 line on a pipe layer not in the CE record"; the card does not fix the words, so the facts are marked: one count of 1, in the own-kind item, not under "pipes not linked" or "pits with no object"). The palette shows a matching item under its own heading (the build's heading: "Line on a pipe layer is not in the CE record") and the count equals the line's.
5. **Faulty partner:** (a) a build that counts only what is in CE's record and ignores what is drawn. It says "all linked" on MD-02 and must fail (the review's hole 3). (b) A build that counts the stray line as "1 pipe not linked". It prints the right number under the wrong words and must fail.

**O3. Old LISP-style job, no CE record**
1. **Drawing:** MD-03.
2. **Do:** open.
3. **Read back:** command-line reading; drawing reading before and after (allowing only the pit symbol swap that opening does today, see O22).
4. **Right:** a line appears that says 4 pit blocks were found and there is no CE record, and says nothing has been changed by this check (card line 3). It does not say "all linked". Whether it also counts the 3 pipe lines is not stated by the card: RECORD what it prints. If it prints a number for them, the number must be 3.
5. **Faulty partner:** a build that prints nothing for a drawing with no record. Must fail (the review's hole 3).

**O4. Hand-drawn job, no CE tools**
1. **Drawing:** MD-04.
2. **Do:** open. Wait for the log entry.
3. **Read back:** command-line reading; the `[OpenLine]` log entry; record reading (there is none).
4. **Right:** the line never says "all linked". It never counts the five PIT blocks as CE pits. If it says nothing, that is allowed, and then it counts only if the log entry is present (section 1b). If it says something, no count is higher than what CE can recognise (0 CE pits).
5. **Faulty partner:** a build that counts any block with PIT in its name as a pit. Must fail with "5 pits".

**O5. Pits copied from another job**
1. **Drawing:** MD-09-X. The two pits are brought into MD-08 by COPYCLIP in MD-01 and PASTECLIP in MD-08, then the paste is exploded one level so the pits are separate blocks (not left inside one wrapper block).
2. **Do:** save the result as a fresh copy, then open it.
3. **Read back:** the line; the record reading (the 2 pits are not in this drawing's record).
4. **Right:** needs checking, counting 2 pit symbols that are not in the CE record. The line gives counts, not names, so the case checks the count of 2. The line does not say "all linked".
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
3. **Right:** MD-08 counts its pits and pipes across both networks. MD-07 counts all 6 pits, plastic ones included (the plastic pit rule is about the schedule, not about whether a pit exists). RECORD the pipe count for MD-08, because the card does not say whether a two-network job gets one line or two.
4. **Faulty partner:** a build that leaves plastic pits out of the count. Must fail on MD-07 with 3 pits.

**O8. Downpipes and tanks: how they are counted (RECORD)**
1. **Drawing:** MD-01-DP.
2. **Do:** open.
3. **Right:** RECORD. The card counts "pits, pipes" only. The installed check treats a water tank like a pit. The robot writes down what the line says for 2 downpipes and 1 tank and puts it to Tim. Not a pass or a fail. (Whether the line says "all linked" on this job is a pass or fail, in O30.)

### Group B: the line changes nothing

**O9. Nothing written to the drawing (a pair of runs)**
1. **Drawing:** MD-01, MD-02, MD-03.
2. **Do:** for each drawing, run A with "Say what state a drawing is in when it opens" switched off, then run B with it on, each on a fresh copy and with the same fixed wait. On MD-01 first confirm in run A that the changed counter stays 0.
3. **Read back:** the changed counter, the drawing reading and the record reading after opening, in both runs.
4. **Right:** the counter and both readings are identical between run A and run B. (The old wording "read the counter when CE's opening jobs finish" is dropped: the robot cannot see that moment.) On MD-03 opening itself changes pit symbols today, and it does so in both runs, so it cancels out.
5. **Faulty partner:** a build that stamps "checked" into the drawing. The counter or a reading differs between runs and the case fails.

**O10. Open and close, no questions**
1. **Drawing:** MD-01.
2. **Do:** control run with the line off: open, close with CLOSE, no edits; note whether AutoCAD asks about saving. Then the same with the line on.
3. **Right:** if the control run asks nothing, the line-on run must ask nothing, and the file reading is identical (same hash, no new file in the folder). If the control run itself asks (a pipe conversion on opening), the line-on run must ask the same and no more.
4. **Faulty partner:** the stamping build. It leaves the drawing marked changed, AutoCAD asks "save changes?" where the control did not, and the case fails.

**O11. Redo survives, and the line takes no Undo step (the guard for BUG-256)**
1. **Drawing:** MD-01 and MD-03.
2. **Do, in this exact order:**
   1. Open MD-01. Draw one test LINE, press U (the line goes). Do not press REDO yet.
   2. Straight away open MD-03. A drawing opened just after a U can have its opening jobs held back, which is when the line can run after your own U (card section 9, item 2; the build waits up to 5 seconds).
   3. In MD-03 draw one test LINE and press U **before** the opening line appears. Check the command-line reading: the opening line must not have printed yet. If it already has, the run does not count and is repeated.
   4. Wait for the `[OpenLine]` log entry for MD-03 (30 seconds).
   5. Press REDO. Count objects.
   6. Then press U once more and count objects again.
3. **Right:** at step 5 REDO brings the test LINE back (count up by 1). At step 6 U removes exactly that LINE and nothing else, and nothing in the undo list is labelled as the line's own step. The same in MD-01: REDO there still brings back its LINE.
4. **Faulty partner:** (a) a build whose check starts a normal transaction or clears the redo list: REDO does nothing and the case fails. (b) A build whose check takes an Undo step: step 6 removes nothing or something else and the case fails. If the timing in step 3 cannot be made to work, the case is BLOCKED, never a pass.

**O12. The line adds no Undo step**
1. **Drawing:** MD-01.
2. **Do:** control run with the line off: open and press U once at once; note what AutoCAD says. Then the same with the line on, pressing U after the log entry.
3. **Right:** both runs say the same (nothing to undo, or the same step as the control's). No object is removed.
4. **Faulty partner:** a build that makes its check a numbered undo step. U would undo "something" and the drawing reading would differ from the control.

**O13. Read-only file**
1. **Drawing:** MD-14.
2. **Do:** open.
3. **Read back:** the line; file reading before and after; folder listing.
4. **Right:** the line shows. File hash and saved time identical. No new file next to it.
5. **Faulty partner:** a build that tries to write a note into the file. It either errors or changes the folder, and fails.

**O14. Drawing locked by another session**
1. **Drawing:** MD-14-L (open in a second AutoCAD session first).
2. **Do:** open the second copy read-only when AutoCAD offers it, once with the line switched off and once with it on, comparing the folder listing between the two runs. (AutoCAD itself makes the lock files, so the case compares, not "no lock file".)
3. **Right:** the line shows. The folder listing and file hash are identical between the off run and the on run.

### Group C: the line stays quiet or says "could not"

**O15. Structural drawing: nothing**
1. **Drawing:** MD-15. **First state in the case whether MD-15 is untagged and not named Structural.** The question below only appears on an untagged drawing; if MD-15 is tagged Structural, PIT refuses with a different line and the case records that line instead.
2. **Do:** open. Wait for the log entry. Then type PIT.
3. **Right:** no CE line in the command-line reading, and the `[OpenLine]` log entry is present (otherwise BLOCKED). Then PIT asks "This drawing isn't tagged yet. Is this a Civil drainage drawing?" (the gate stays, TRUST-02 section 1). Press Escape (Enter means Yes and would tag the drawing Civil): drawing reading identical.
4. **Faulty partner:** a build that prints a Civil line on a Structural drawing. Must fail.

**O16. CE tools stay available on a quiet drawing (Tim, 7 Nov)**
1. **Drawing:** MD-15-B (blank).
2. **Do:** open. Wait for the log entry. Type three CE tools that are useful on any drawing (for example CDHELP, CDS, CEBLOCKS).
3. **Right:** no line on open (log entry present). Each of the three starts and opens its window. (The earlier check that the registered command list equals MD-01's is dropped: commands are registered once for AutoCAD, not per drawing, so it could never fail.)
4. **Faulty partner:** a build that switches off CE commands where it stays quiet. A tool would not start, and the case fails.

**O17. Large drawing above the size limit**
1. **Drawing:** MD-01 with the Settings limit set to 10 objects (so the drawing is "large"); then MD-13 at the real limit.
2. **Right:** with the low limit, MD-01 prints `CE: large drawing, not checked on opening. Type CDCHECKCURRENT to check it.` and nothing is counted. With the limit high, it prints the counts. For MD-13 at the real limit: RECORD the open time with the line on and off, and which line is printed. The limit has no value yet (card, not known 1), so MD-13 gives no pass or fail until it is set.
3. **Faulty partner:** a build that counts anyway when above the limit. It prints counts instead of the large-drawing line, and the text check fails it. (Open time is not used: on a small drawing it cannot differ.)

**O18. The check cannot run**
1. **Drawing:** MD-22 (damaged record).
2. **Do:** open.
3. **Right:** the drawing opens normally and is usable. The only CE line is `CE: could not check this drawing.` (card section 1, item 7, the approved words). No count. The reason is in the CE log. Drawing reading before and after identical. Two parts are marked separately: the no-count and no-change part passes or fails under any wording; the exact words pass or fail against the card.
4. **Faulty partner:** a build that prints counts from a half-read record. Must fail.
5. **One inference, stated:** the card says the line is this when "the check itself fails". It does not say outright that a half-read record counts as the check failing. The case treats it that way, because the check cannot finish. If the controller rules that an unreadable record is a finding ("needs checking"), this case is changed.
6. **Settled (section 6, item 1):** the card's words win. The build as reviewed prints "needs checking. The CE record in this drawing could not be read. Type CDCHECKCURRENT to see more." so on that build the wording part FAILS and the build changes, not the case.

**O19. Switch off**
1. **Drawing:** MD-01.
2. **Do:** set "Say what state a drawing is in when it opens" to off in the settings file, restart AutoCAD, open. Wait for the log entry.
3. **Right:** no line. Settings reading shows the value off. Turn it on again: the line returns. (What the switch off does to CDCHECKCURRENT is O32.)
4. **Faulty partner:** a build that ignores the switch.

**O20. Batch work: a headless run with no one at the screen**
1. **Drawing:** MD-01.
2. **Do:** open it in a headless run (accoreconsole). Wait for the log entry.
3. **Right:** no line (card section 4, item 8: skipped when AutoCAD has no one at the screen), and the log entry is present (otherwise BLOCKED).
4. **Faulty partner:** a build that prints in a headless run. Must fail.
5. **Settled (section 6, item 2):** the build skips accoreconsole only, which agrees with this case.

**O20b. A script run inside full AutoCAD (RECORD)**
1. **Drawing:** MD-01.
2. **Do:** open it from a script (SCRIPT with OPEN) in a full AutoCAD session with someone at the screen.
3. **Right:** RECORD. The card says "batch work and scripts: skipped when AutoCAD has no one at the screen". A script in a full session has someone at the screen, so the card does not say whether the line prints. The build as reviewed does print it. The robot writes down what it prints and puts it to Tim. Not a pass or a fail.

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
3. **Faulty partner:** a build that reads the size limit or a reach as if the drawing were always in millimetres. In the metre copy the counts or the large-drawing line would differ, and it fails. (The earlier partner, a reach fixed at 2000 drawing units, is dropped: the line matches by object identity, not distance, so it had nothing to act on.)

**O24. An attached drawing (Xref)**
1. **Drawing:** MD-10.
2. **Do:** open. Wait for the log entry.
3. **Right:** the host has no CE pits, so no pits are counted from the Xref and no fault is raised about it (a quiet or no-record result, with the log entry present). The Xref layers' states are identical before and after (drawing reading). Nothing is detached, reloaded or unlocked.
4. **Faulty partner:** a build that counts the Xref's pits. It prints 6 pits on a host that has none.

**O25. Paper space**
1. **Drawing:** MD-11.
2. **Do:** open, then make a layout current, then run CDCHECKCURRENT.
3. **Right:** the counts equal MD-01's model-space counts. Whether the legend sample on the layout counts as a pit is not stated by the card: RECORD which, and put it to Tim.

**O26. A job over two drawings (RECORD)**
1. **Drawing:** MD-16, both files.
2. **Right:** RECORD. The pipe from P3 to P4 ends at a pit that is in the other file. The card (not known item 4) does not say whether that is "not linked". The robot writes down what each file's line says. Nothing is marked pass or fail.

**O27. A drawing last written by another version**
1. **Drawing:** MD-17-OLD and MD-17-NEW.
2. **Right:** OLD gives the same counts as MD-01. NEW says `CE: could not check this drawing.` or the same counts if it can read them; it never gives a different count as if it knew. Drawing reading identical in both. The installed CE writes nothing back into either.
3. **Faulty partner:** a build that reads a newer record as an empty one and says "no CE record". Must fail on MD-17-NEW.

**O28. Same answer twice, on two logins**
1. **Drawing:** MD-01, MD-02, MD-03, MD-12.
2. **Do:** open each twice from fresh copies on login 1; then on a second Windows login with the dark theme and a different workspace. **Both logins have the same size limit in Settings.**
3. **Right:** the line text is identical in all runs, word for word.
4. **Faulty partner:** a build whose line wording or counts depend on the theme or workspace. (The earlier partner, a size limit from a per-login value, is dropped: the card puts the limit on each person's Settings page, so that is the design. Whether two people with different limits get different lines is a Step 3 question, not tested here.)

### Group E: the cases the reviews added

**O29. AutoCAD started by double-clicking a test drawing**
1. **Drawing:** MD-01, MD-02, MD-03 (each on its own fresh copy).
2. **Do:** with AutoCAD closed, start AutoCAD by opening the copy from Explorer (the driver's Explorer hand-off, the same as a double-click). CE loads after the drawing is already open. Wait for the `[OpenLine]` log entry. Then start AutoCAD on its own, with no file, and wait for the entry (or note there is none for a blank start-up drawing).
3. **Read back:** command-line reading; record reading and drawing reading before and after; changed counter; for MD-01 also whether its pipe lines were converted on opening, compared with the same drawing opened after AutoCAD was already running.
4. **Right:** exactly one line per drawing, with the same words that O1, O2 and O3 give when the same drawing is opened inside a running AutoCAD. The blank start-up drawing gets no line (card section 1, item 6), with the log entry present or BLOCKED. Both readings identical, counter unchanged. The pipe conversion result equals the one from a normal open (RECORD any difference; the review says nothing proves it today).
5. **Faulty partner:** (a) the build as reviewed (head 00c3baf5). The review says it listens only for drawings created after CE starts, so a drawing already open when CE loads gets no line. If that is right, this case FAILS on that build, which is a finding for the builder and not a fault in the case. If it passes, the review's worry is closed with evidence. (b) A copy that adds the start-up drawing to the waiting list but also keeps the old listener, so it prints twice. Must fail on the one-line rule.
6. **Why the card covers it:** the card says "you open a Civil drawing" and "once per drawing per session" with no exception for the drawing AutoCAD opened first.

**O30. A good job with outlet and downpipe pipes reads "all linked"**
1. **Drawing:** MD-31 (MD-01 plus: two downpipes each draining through a short pipe that starts at the downpipe and ends at a pit; a water tank whose overflow pipe starts at the tank; and one pipe that starts at a connection point). Also MD-01-DP and MD-29 (two pipe ends touch their pits but are not linked).
2. **Do:** open each. Read the line. Run CDCHECKCURRENT and read what it lists as not linked.
3. **Right:** on MD-31 and MD-01-DP the line says "all linked". The outlet pipe that ends at the LPD, the pipes that start at downpipes, the tank overflow and the pipe from the connection point are not counted as "not linked" (card section 9, item 4: those must not count as faults). The line's pit and pipe numbers equal CDCHECKCURRENT's. RECORD, not pass or fail: the exact pipe and pit counts printed for downpipes and the tank, as in O8. On MD-29 the line says "needs checking" and counts the 2 pipes not linked, so the fix for good jobs cannot hide real unlinked ends.
4. **Faulty partner:** (a) a build that counts any pipe end with no pit name as unlinked. It prints "needs checking" on MD-31 and must fail. The review suspects the build as reviewed does this (open-end rule, `CurrentDrawingCheckService.cs` lines 384 to 395). (b) A build that treats every unnamed end as linked. It says "all linked" on MD-29 and must fail.

**O31. Several drawings opened at once**
1. **Drawing:** MD-01, MD-02, MD-03 selected together and opened in one go (from Explorer, and once from OPEN with all three selected).
2. **Do:** after they open, make each current in turn: MD-03, then MD-01, then MD-02, then MD-03 again. Wait for each drawing's `[OpenLine]` log entry.
3. **Right:** one line per drawing, printed when that drawing becomes current, with the same words as when each is opened alone (O1, O2, O3). MD-03 printed the first time and not again on the last switch. Counter and readings unchanged in each.
4. **Faulty partner:** a build that prints only for the first drawing, and a build that prints for all three on the first one. Each must fail.

**O32. The switch off puts CDCHECKCURRENT back as it was**
1. **Drawing:** MD-02.
2. **Do:** run CDCHECKCURRENT with the switch on and note its items. Switch it off, restart, run CDCHECKCURRENT again. Compare with the installed build's list for the same drawing.
3. **Right:** with the switch off, CDCHECKCURRENT lists no "not in the CE record" item and its output equals the installed build's exactly (card section 5: the undo covers both the line and the extra items). With it on, the stray line shows as in O2.
4. **Faulty partner:** a build where the switch removes the line but leaves the extra items. Must fail.

**O33. A very large drawing with no CE record (RECORD)**
1. **Drawing:** MD-03 and MD-04, with the size limit set to 10 objects.
2. **Right:** RECORD. Card section 1, item 5 says a large drawing prints "large drawing, not checked on opening" and item 6 says a drawing that is not Civil prints nothing. A large drawing with no CE record could be either, and the card does not say. The build as reviewed prints nothing in that case. The robot writes down what each drawing prints (with the log entry) and puts it to Tim. The review also notes it is missing from the build's list of defaults.

**O34. Lines on the pipe layer, no pit blocks, no CE record (RECORD)**
1. **Drawing:** MD-32 (three plain polylines on the stormwater pipe layer, no pit blocks, no CE record).
2. **Right:** RECORD. Card section 3, item 3 counts "pit blocks and pipe-layer polylines with no CE record", but the only no-record line in section 1 (item 3) is for a drawing with pit blocks. The build as reviewed prints nothing here. The robot writes down what is printed (with the log entry) and puts it to Tim.

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** O11 and O12 make an edit (draw a line, U, REDO) after or around the line and read the drawing again. Anything that moved besides that edit fails.
2. **The same jobs taught and tested.** The line has no list of old block versions to teach. MD-03 and MD-04 are kept back for testing only. If a later rule is added to count old pits, two new made-up old drawings are held back for it.
3. **"Sent" is not "worked".** O2 and O5 read the numbers in the line and compare them with the answer sheet, not just whether a line printed. Quiet cases need the log entry, not just silence (section 1b).
4. **Undo was not compared on linework.** O11 and O12 compare the whole drawing reading, and O11 counts objects after REDO and after U.
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
9. **One job over several drawings:** O26 (RECORD), O31 (several files opened together).

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** MD-01, MD-02, MD-03, and MD-01 with the low size limit.

**What to look at, and what right looks like:**
1. **One clean line each,** in the command line, in drafting words. Right = none of these words: handle, dictionary, object ID, xrecord, database. The word "record" is allowed only inside the card's own approved lines (for example "no CE record"), because Tim approved those lines. Right = the words match the card's wording.
2. **It does not wrap** at the normal command-line width, and it is not buried: it is the last CE line after opening, or near it.
3. **Needs checking reads as a call to act,** not an error: it says what (for example "1 line on a pipe layer not in the CE record") and says to type CDCHECKCURRENT.
4. **The old LISP drawing line** says nothing has been changed by this check.
5. **The second line** (pit symbols updated) appears on MD-03 only.
6. **One word for one thing.** The card says "pit blocks" in the no-record line and "pit symbols" in the second line. Note whether a drafter would take them for the same thing. Not a fail: Tim approved both lines as written. It is passed to the controller as one wording question.
7. **Opening speed:** the drawing opens without a pause the eye can notice on MD-01. Write down the pause on a large drawing if there is one. A pause is a note, not a fail, until the size limit is set.

**Screenshots:** kept as `OPEN01_MD01_line.png` and so on, never a job name.

**Cannot be proven without Tim:** whether the counts match what he knows of five real jobs, and whether the line is read or ignored by the third day. That stays his three working days.

## 6. What changed from the first version, and how each disagreement was settled

Rule used: the card's approved wording wins; where the card is silent the case is RECORD and says so. Nothing was run; the build's behaviour is as the reviews read it.

1. **An unreadable record (O18): the card's words win.** The card says `CE: could not check this drawing.` when the check fails. The build prints "needs checking. The CE record in this drawing could not be read." The build's line may be more useful, but it is not the approved wording. O18 keeps the card's words and states its one inference. If the controller wants the build's line, the card changes first.
2. **Scripts (O20, O20b):** the card's rule is about "no one at the screen". Headless runs are silent (O20, agrees with the build). A script inside a full AutoCAD has someone at the screen, so the card does not say: RECORD (O20b). Section 1b says how the robot opens files, so it knows to expect the line.
3. **The word "record" in the look brief:** the card's own approved line 3 says "no CE record". The look brief bans handle, dictionary, object ID, xrecord and database, and allows "record" inside the card's approved lines.
4. **The reviews' other fixes, all applied:** "say nothing" cases wait for the log entry (section 1b); O11 rewritten so it fails if the line clears Redo or takes an Undo step; O2 counts the stray line under its own kind; O9 is a pair of runs; O5 steps made exact; O10, O12 and O14 compare against a switched-off control; O15 states MD-15's tag and presses Escape; O16, O17, O23 and O28 lose the faulty partners that could not fail for the reason given; O1 and O8 point to O30 for the pipe ends that may be miscounted.
5. **Added:** O29 (AutoCAD started by double-clicking a test drawing), O30 (a good job reads "all linked"), O31 (several drawings at once), O32 (switch off puts CDCHECKCURRENT back), and two RECORD cases found while settling these, O33 and O34, because the card is silent and the build prints nothing there.
6. **Passed to the controller as one wording question:** the card uses "pit blocks" (section 1, item 3) and "pit symbols" (item 4) for the same objects.
