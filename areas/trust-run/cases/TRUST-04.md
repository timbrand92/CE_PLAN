# Cases for TRUST-04: core safety fixes

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-04_CORE_SAFETY_FIXES_CARD_DRAFT_2026-11-12.md`, the bug records (BUG-1276, 650, 1274, 1255, 497, 498, 499, 1275), and installed Civil 3.0.90 (commit cf059dcf) and Structural 1.0.126 (8de95c34). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md`. Extra made-up drawings for Structural are described in section 1.
**No client data:** the bug records name a real job. None of that appears here. Every drawing below is invented.
**Defaults taken for Tim (DRAFT, he confirms):** reminder minutes are read from Settings, never fixed in a case (the card recommends 15, the built draft says 25; Tim has not chosen); BUG-1255 is treated as a blocker, so its cases are required; the Civil fixes are one small build.

---

# FOR TIM

**These checks prove each safety fix does its job and that each fault the card names would be caught if it came back.**

1. **25 robot cases** (section 2): 14 Civil, 8 Structural, 3 across both.
2. **Six of the cases are expected to FAIL on today's installed build,** and that is the point. They are F4, F5, F12, F17, F18 and F19. If one passes on today's build, the case cannot see the fault and is rewritten. The faults are real: cancelling CDFW clears pit inverts; Excel export fails on 2027; the bracing tables are one row short; erased braces stay in the table; the roof trusses add into wall bracing. (The reminder and the schedule note also fail today, simply because they do not exist yet.)
3. **BUG-1255 has no fix yet.** Its cases are written for when one exists.
4. **BUG-1275 (the AutoCAD crash) cannot be proven fixed by any robot run.** The crash has never been made to happen on demand. F21 and F22 give evidence, not proof, and say so.
5. **Three things the card leaves open and the robot only records:** untagged braces, adding A and B brace lengths together, and whether the schedule note should count pits switched off or marked To be removed.

---

## 1. What is being proven

1. **The reminder** speaks once, only when work is unsaved, and never saves.
2. **Cancelling CDFW** leaves every stored pit invert exactly as it was.
3. **The Pit Schedule** names every pit it leaves out, and the plastic pit rule is unchanged.
4. **Export Excel** writes the same rows as the window.
5. **Structural:** CLEAN saves; the bracing tables have the right rows and totals; trusses stay out of wall totals; placing beams does not crash.

**Extra made-up Structural drawings:**
1. **MD-15-C:** a Structural drawing with 3 unused blocks, 2 extra text styles, and one beam coloured by hand (not by layer).
2. **MD-15-S:** a floor plan with 4 type A and B wall braces (lengths 2.7 m, 2.7 m, 3.0 m, 2.4 m), 2 bored piers and 3 tie-downs.
3. **MD-15-T:** MD-15-S plus two 4 m roof trusses placed with BT1.
4. **MD-15-U:** MD-15-S plus one brace with no type tag.

## 2. The robot cases

### Civil: the unsaved-work reminder (BUG-1276, Civil half)

**F1. The reminder speaks once**
1. **Drawing:** MD-01.
2. **Do:** set the reminder to 1 minute in the settings file (read the value back to be sure). Open the copy. Draw one LINE. Do not save. Wait 70 seconds, then 3 more minutes.
3. **Read back:** command-line reading; file reading; changed counter.
4. **Right:** exactly one reminder line appears, in plain words, after the set time. No second line in the next 3 minutes. The line states the minutes from Settings, not a fixed number.
5. **Faulty partner:** a build that repeats every minute. Must fail on the second line.

**F2. Silent when nothing is unsaved; clock starts again after a save**
1. **Drawing:** MD-01.
2. **Do:** (a) open and make no edit; wait 3 minutes. (b) edit at time 0, save at 30 seconds, edit again at 40 seconds, with the reminder at 1 minute.
3. **Right:** (a) no reminder. (b) no reminder at 60 seconds; the reminder comes about 100 seconds after the start (a minute after the edit that followed the save).
4. **Faulty partner:** a build that counts from opening the drawing. It fires in (a) and fails.

**F3. The reminder never saves and writes no new file**
1. **Drawing:** MD-01.
2. **Do:** as F1, then read the file reading and the folder listing when the reminder has printed.
3. **Right:** the file's SHA256 and saved time are unchanged. The changed counter is still non-zero (the drawing is still marked changed). No new file in the drawing's folder (any copy CE makes goes to its own backup folder; RECORD whether it makes one, because the built draft also copies AutoCAD's own automatic-save file, which the card does not mention). In a script or headless run no reminder is printed. With the switch off, none is printed.
4. **Faulty partner:** a build that calls save when it reminds. File hash changes and the counter returns to 0. Must fail.

### Civil: cancelling CDFW (BUG-650)

**F4. Escape at every prompt leaves the inverts alone (expected to fail today)**
1. **Drawing:** MD-01 (inverts P1 9.10 and P2 9.45, all six on the answer sheet). Plus MD-01 with one pit that has an explicit sump bottom and one with a derived one.
2. **Do:** read the record reading. Run CDFW. Walk the prompts: for each prompt n, give valid answers up to n-1 and press Escape at n. The robot finds the number of prompts by walking until CDFW places something. Read the record reading and drawing reading after each Escape.
3. **Right:** after every Escape, the record reading and drawing reading are identical to before, field by field. Every invert is as the answer sheet says. No floor waste and no tag remains. The two bottoms are checked separately and neither moves.
4. **Faulty partner:** the installed 3.0.90 build, which clears the inverts. This case **must fail** on it. A second faulty partner: a fix that restores the inverts after an Escape at the first prompt only.

**F5. Placing a floor waste, U, REDO, save and reopen (expected to fail today)**
1. **Drawing:** MD-01.
2. **Do:** run CDFW and place one floor waste. Read. Press U once, read. REDO, read. Save, close, reopen, read.
3. **Right:** after the placement every pit invert still equals the answer sheet. After U the full drawing reading and the record reading equal the starting ones. After REDO, they equal the placed state. After reopening, inverts are as before. This compares the linework too, not just CE's record.
4. **Faulty partner:** the installed build (it also clears the inverts on placement, from the bug record). Must fail.

**F6. Locked layer, frozen layer, Xref**
1. **Drawing:** MD-18, MD-18-V, MD-10.
2. **Do:** run CDFW and place on each.
3. **Right:** nothing is unlocked, thawed or detached. Where CDFW cannot place, it says so plainly. The inverts and the drawing reading are identical to before.
4. **Faulty partner:** a build that unlocks the layer to place. Layer state would differ and it must fail.

### Civil: the Pit Schedule (BUG-1274, BUG-1255)

**F7. The note names exactly the pits left out**
1. **Drawing:** MD-07 (P3, P4 and P5 plastic).
2. **Do:** open the Pit Schedule window. Export CSV.
3. **Read back:** the note; the CSV rows; the drawing's pits (answer sheet).
4. **Right:** the note says 3 plastic pits are not scheduled and names P3 to P5, with how to include one (words from the bug record: open PIT and press "Number and schedule this one anyway"). The robot works the left-out set itself: pits drawn (6) minus pits exported (P1, P2, P6). The note's set equals that set exactly.
5. **Faulty partner:** a note that says 2 or says P3 to P6. Must fail against the independent set.

**F8. Other reasons a pit is left out**
1. **Drawing:** MD-07 with one more pit switched off for scheduling and one marked To be removed.
2. **Right:** the independent set (drawn minus exported) is 5 pits. RECORD whether the note names all 5. The card names plastic pits; the built draft names all three reasons. If the note names fewer pits than the independent set, the schedule is silently short, and the case fails.

**F9. Include one anyway**
1. **Drawing:** MD-07.
2. **Do:** open PIT on P4, press "Number and schedule this one anyway", close, reopen the Pit Schedule.
3. **Right:** P4 is now in the rows; the note names P3 and P5 only (2 pits). The plastic rule is unchanged for the others.
4. **Faulty partner:** a build that leaves P4 in the note after it is scheduled.

**F10. Nothing left out: no note; the note is not saved into the drawing**
1. **Drawing:** MD-01 and MD-07.
2. **Do:** open the schedule on each, close it, read the drawing.
3. **Right:** MD-01 shows no note at all. On MD-07, after closing, the drawing reading holds no object with text like "not scheduled" or "not in this schedule" (the card: the note is not stored in the drawing). Place the schedule on a layout (MD-11 style): the placed schedule has its rows only.
4. **Faulty partner:** a build that writes the note as text into the drawing. Must fail.

**F11. The plastic rule uses the real size, in metres too**
1. **Drawing:** MD-07 in millimetres and in metres (MD-07 converted).
2. **Right:** the same pits (P3 to P5) are called plastic in both, and the note names the same ones. A 350 x 350 pit in a metre drawing is 0.35 wide and must still be plastic.
3. **Faulty partner:** a build that compares width 0.35 against 350. In the metre copy no pit is plastic and the case fails.

**F12. Export Excel writes the same rows as the window (expected to fail today on 2027)**
1. **Drawing:** MD-21 (10 pits). Also MD-07.
2. **Do:** on AutoCAD 2027 press Export Excel. The robot types a file name in a scratch folder in the Windows save box. Then it opens the .xlsx with a reader that is not CE's library (Excel itself, or a separate spreadsheet reader), never with ClosedXML.
3. **Right:** the Windows save box opens; a file is written; it opens; its column headings and every row equal the window's rows, cell by cell, in the same order. No FileLoadException for ClosedXML in the log reading.
4. **Faulty partner:** the installed build, which fails with the library clash. Must fail. Plus a build that writes only the headings, and a build that sorts P1, P10, P2 when the window shows P1, P2, P10.

**F13. Export Excel: Cancel and a file that is open**
1. **Do:** press Export Excel and Cancel at the save box. Then export to a name, open it in Excel, and export to the same name again.
2. **Right:** Cancel writes no file and prints no error, and the drawing reading is identical. With the file open elsewhere, CE says plainly it cannot write over it, no crash, no half file.
3. **Faulty partner:** a build that writes an empty file on Cancel.

**F14. Export on AutoCAD 2024 still works as before**
1. **Do:** F12 on 2024.
2. **Right:** works as it did. The 2024 file equals the 2027 file cell by cell.

### Structural (after Civil)

**F15. CLEAN saves (the one run still owed)**
1. **Drawing:** MD-15-C.
2. **Do:** run CLEAN. Read the file reading and the drawing reading.
3. **Right:** the four jobs happened as the answer sheet says: the 3 unused blocks are gone, only one text style is in use, the hand-coloured beam is now by layer, and the Xref layers are as they were. The file was saved: saved time and hash changed, and the changed counter is 0 after CLEAN. (CLEAN saving is Tim's order, so it is not a breach of "CE never saves for you".)
4. **Faulty partner:** a build that does the cleaning and skips the save. Hash unchanged, counter non-zero. Must fail.

**F16. The reminder on a Structural drawing**
1. **Drawing:** MD-15.
2. **Do:** as F1, F2 and F3 with Structural's own Settings.
3. **Right:** the same: once, only when unsaved, never saves. The reminder reads the Structural minutes value. Structural's earlier fault (the autosave that made no copy of unsaved edits) is not claimed fixed; the reminder is a guard. RECORD whether CE copies AutoCAD's own automatic-save file and where.

**F17. Bracing tables have the right rows (BUG-497) (expected to fail today)**
1. **Drawing:** MD-15-S.
2. **Do:** run STRSCHEDCREATE. Read the drawing reading for the three tables.
3. **Right:** the bracing table has 6 rows (title, heading, 4 braces), the bored pier table 4, the tie-down table 5, and the last item of each is present. Every length in the bracing table equals the answer sheet (2.7, 2.7, 3.0, 2.4). The sum of the table equals the sum of the braces drawn. No AutoCAD error.
4. **Faulty partner:** the installed build (one row too short). Must fail.

**F18. Erased braces leave the table (BUG-498)**
1. **Drawing:** MD-15-S.
2. **Do:** create the schedule. Erase the 3.0 m brace. Run STRSCHEDREFRESH and pick the bracing schedule. Then draw a new 2.1 m brace, refresh again.
3. **Right:** after the first refresh the table lists 3 braces (2.7, 2.7, 2.4), total 7.8 m, and no cell anywhere in it reads 3.0. After the second, 4 braces, total 9.9 m. The table total always equals the braces drawn. A leftover row is blank or removed, never the old brace.
4. **Faulty partner:** the installed build (rows rewritten from the top, the old last row stays). It overstates bracing, which is the dangerous direction, and must fail.

**F19. Roof trusses stay out of wall bracing (BUG-499) (expected to fail today)**
1. **Drawing:** MD-15-T.
2. **Do:** open the bracing panel (CSBRACINGPANEL). Read the east-west and north-south totals. Then erase the two trusses and read again.
3. **Right:** the wall totals come from wall braces only, as the answer sheet says, and are the same with and without the trusses. (Today two 4 m trusses add 8 m.)
4. **Faulty partner:** the installed build. Must fail.

**F20. Untagged brace, and A plus B added together**
1. **Drawing:** MD-15-U.
2. **Right:** RECORD. The bug record says an untagged brace is read as type A and A and B lengths are added as if equal. The card fixes only the trusses. The robot writes down what the panel shows for the untagged brace and the A plus B total and puts it to Tim, since that is an engineering ruling. Not a pass or a fail.

**F21. Placing many steel beams in a row does not crash (BUG-1275)**
1. **Drawing:** MD-15, then two more made-up Structural drawings.
2. **Do:** run SBEAM 30 times in one session, mixing: placing after switching between three drawings, after a new drawing, after U and REDO, and after closing one drawing.
3. **Right:** 30 beams exist (answer sheet), AutoCAD is still running, and no crash file appears. **This is evidence, not proof.** The crash has never been reproduced on demand, and the dump showed AutoCAD failing inside its own database code, so a pass here does not show the stale-id guard fixed it.
4. **Faulty partner:** not a robot case. The code lane's own test for the guard must fail when the guard is removed. The robot cannot make that fault.

**F22. A long run, like the day it happened**
1. **Do:** outside Tim's hours, leave AutoCAD open for 24 hours on a made-up drawing, placing one beam every 10 minutes by script.
2. **Right:** 144 beams, no crash, no unexplained slowing (record the time of each placement). The original crash came after AutoCAD had been open about 24 hours. Again evidence, not proof.

### Across both

**F23. No new switches beyond the reminder**
1. **Do:** settings reading before and after the build.
2. **Right:** the only new values are the reminder on or off and its minutes (card section 2). A fix to a wrong result gets no off switch.
3. **Faulty partner:** a build that adds an off switch for the schedule note.

**F24. AutoCAD 2022 to 2024**
1. **Do:** run F1, F4, F5, F7, F10, F11 and F14 on 2024.
2. **Right:** same results. BUG-1255 is a 2027 fault, so on 2024 the check is only that export works as before (F14).

**F25. Saved and reopened, and a Save As copy**
1. **Drawing:** MD-07 and MD-09 (a Save As copy of MD-01).
2. **Do:** save, close, reopen. Run the schedule and CDFW Escape on the copy.
3. **Right:** the note and the rows are the same after reopening. The copy gives the same note as the original job. CDFW Escape still leaves the copy's inverts unchanged.

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** F9 edits a pit then reads the schedule again. F18 erases and adds a brace then refreshes. F5 places then reads.
2. **The same jobs taught and tested.** Not applicable: no reader is taught. The answer sheets are made when each drawing is built.
3. **"Sent" is not "worked".** F12 opens the real file and compares cells; it does not accept "the button ran". F17 and F18 read the table cells, not the absence of an error.
4. **Undo compared on linework.** F5 compares the whole drawing reading after U, not only the record.
5. **Twice, identical.** F7 run twice on fresh copies gives the same note; F12 run on two logins gives the same file cells.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** F13 (a file open elsewhere). Run F7 on MD-14 as well: the note shows and the file is unchanged.
2. **Save As and copied pits:** F25. Run F7 on MD-09-X: the two pits that came from another job are scheduled or named as left out like any other.
3. **Units:** F11.
4. **Xref:** F6.
5. **Paper space:** F10 (the placed schedule). RECORD whether pits in paper space are counted: they should not be.
6. **A hidden command typed from habit:** not applicable. These fixes sit inside tools that are on the ribbon.
7. **Another CE version:** F25 covers a copy. The Excel fault depends on the AutoCAD version, so F12 and F14 are the version cases.
8. **Spoiled blocks:** run F7 on MD-12: the exploded pit is not a pit and must be named as left out or absent, not scheduled as a number.
9. **A job over several drawings:** run F7 on MD-16's two files: each schedule covers its own drawing. RECORD whether the note says so.

## 5. The look by eye (Codex, real AutoCAD, copies only)

**What to open:** the Pit Schedule window on MD-07 and MD-01; the reminder line; the saved Excel file opened in Excel; the bracing panel on MD-15-T.

**What to look at, and what right looks like:**
1. **The reminder:** one line in plain words, that does not stop you working and does not repeat. It tells you how long it has been. Right = you notice it without being nagged.
2. **The schedule note on MD-07:** reads like the bug record's example ("3 plastic pits are not in this schedule: P3 to P5. Open PIT on each ..."). Right = the headline is **not cut off with "..."** at the normal window width (the bug record found the headline was cut). The note is visible in the window, not only in a hover or another tab.
3. **No note on MD-01.** The window looks as it does today.
4. **The Excel file, opened in Excel:** rows and columns look like the window; column widths readable; no blank first sheet; no error box on opening.
5. **The Windows save box** opens on its own and has a sensible file name.
6. **The bracing panel on MD-15-T:** the totals look right to someone who knows the plan: wall bracing only.
7. **The Structural tables on the plan:** title row, heading row, one row per item, no dead row at the bottom.

**Screenshots:** `FIX04_schedule_note_md07.png`, `FIX04_excel_open.png`, `FIX04_reminder.png`, `FIX04_bracing_panel.png`.

**Cannot be proven without Tim:** whether the reminder minutes feel right; whether the schedule note matches what he knows of a real job; whether the A plus B brace rule is what he wants (F20); and that the crash is gone (F21 and F22 only give evidence).
