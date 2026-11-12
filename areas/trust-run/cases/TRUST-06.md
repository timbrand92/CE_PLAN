# Cases for TRUST-06: guesses removed, Unknown shown as Unknown

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-06_GUESSES_REMOVED_CARD_DRAFT_2026-11-12.md`, the reader design (`areas\TRUST_READER_DESIGN_12NOV.md`), the test set (`areas\TRUST_TEST_SET_12NOV.md`) and installed Civil 3.0.90 (commit cf059dcf). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md`.
**Engineering judgement:** every fill-in is an engineering default. The robot proves the behaviour. Only Tim's word settles what each fill-in should be.
**Defaults taken for Tim (DRAFT, he confirms):** each fill-in becomes Unknown as the card proposes; Unknown shows nothing on the plan and "?" in the schedule and check list; a pit invert taken from the lowest pipe is kept but marked as worked out; two candidates mean Unknown; a plain line on a pipe layer is listed as a "possible pipe" and not added to the record. If Tim chooses otherwise the matching case flips and says so.

---

# FOR TIM

**These checks prove CE stops making things up. A line with no size shows no size. A pit with no label gets no number. A label two pits could own belongs to neither. And a metre drawing behaves like the same job in millimetres.**

1. **27 robot cases** (section 2).
2. **Each fill-in in the card has its own case and its own faulty twin,** including the "100 dia UPVC" the review warned about (G1, G2).
3. **The invented-value check runs on the whole made-up set** (G20), scored with the five marks from the test set: Right, Unknown, Wrong, Invented, and Proposed with a wrong value. Any Wrong, Invented or wrong Proposed fails.
4. **A limit that cannot be removed:** a "100" already written into an old drawing last month cannot be told from a real 100 pipe. G17 checks CE says "stored, source unknown" for it, and does not pretend to clean it.
5. **Not known, so only recorded:** how calculations, the rule checks and the long section behave with a blank size or material (the card says this is not traced). G23 records each.

---

## 1. What is being proven

1. **No value appears that the drawing does not hold:** no 100, no UPVC, no Class C, no next free pit number.
2. **Unknown stays Unknown** across save and reopen.
3. **The same job reads the same in millimetres and metres.**
4. **Reaches come from Settings, in millimetres, adjusted for units.**
5. **Two candidates are never settled by picking the nearer.**
6. **Each stored value says where it came from.**

## 2. The robot cases

### Group A: the fill-ins (card section 1)

**G1. Pipe size 100 gone**
1. **Drawing:** MD-23 (a pipe line with no CE size, no CE material, no drawn width).
2. **Do:** run Edit Pit (an update runs), then CDSYNC, on separate fresh copies.
3. **Read back:** record reading; Pit Schedule window; drawing reading.
4. **Right:** the pipe's size is blank in the record. The Pit Schedule shows "?" for it. No object text on the plan reads 100 and no field anywhere holds 100 for that pipe.
5. **Faulty partner:** the installed 3.0.90 build, which fills 100. This must fail. A second faulty partner fills 100 only in CDSYNC and not in Edit Pit.

**G2. Material UPVC gone**
1. **Drawing:** MD-23. **Do and read back:** as G1.
2. **Right:** material blank. Nothing reads UPVC.
3. **Faulty partner:** a build that blanks the size and still fills UPVC.

**G3. Size from drawn width, in millimetres and metres**
1. **Drawing:** MD-23-W: three plain polylines on the pipe layer with no CE data and drawn widths of 225, 237 and 0 (millimetres), and the same job in metres (0.225, 0.237, 0).
2. **Right:** in both copies the 225 line reads size 225, marked "from drawn width" and proposed. The 237 line reads Unknown (no pipe size matches, not rounded to 225). The 0 line reads Unknown. The two copies are identical item for item.
3. **Faulty partner:** a build that reads 0.225 as 0 (the fault today in a metre drawing), and a build that rounds 237 to 225. Each must fail.

**G4. Lid class**
1. **Drawing:** MD-01 with one PIT BLOCK 3 inserted by plain INSERT (CE did not place it).
2. **Do:** read it on LOGIN-1 with the Settings lid class "Class C" and on LOGIN-2 with "Class D".
3. **Right:** lid Unknown on both. A pit CE did place keeps its stored lid. The two logins give the same reading.
4. **Faulty partner:** a build that takes the lid from the opening login's Settings. The two readings differ and the case fails.

**G5. Pit type and label switches**
1. **Drawing:** the same unplaced pit.
2. **Right:** type Unknown, not "grated pit". The label corner and label switches are held as display choices and are not offered as facts about the pit.
3. **Faulty partner:** a build that writes "grated pit".

**G6. Pit number**
1. **Drawing:** MD-23 (a pit block with no label).
2. **Do:** run Edit Pit and CDSYNC.
3. **Right:** the pit's number is Unknown. The check list shows "?" for it. **No new label text appears on the plan** (the drawing reading has no new object). It is not renumbered P7.
4. **Faulty partner:** the installed build, which hands out the next free number. Must fail.

**G7. Plastic pit rule needs a known size**
1. **Drawing:** MD-07 and MD-07 with one pit block whose size cannot be read (MD-07-S).
2. **Right:** P3 to P5 (350 x 350) are plastic and left out of the schedule, as ruled on 5 Sep. The pit of unknown size is not called plastic and not called concrete. RECORD whether it is scheduled or named as left out: the card does not say.
3. **Faulty partner:** a build that treats unknown size as plastic. It disappears from the schedule and the case fails.

**G8. Flow direction**
1. **Drawing:** (a) MD-03, one plain line drawn from A to B with no inverts. (b) MD-01 and a copy where the P2 to P1 pipe was drawn in the uphill order (from P1 to P2) with inverts present.
2. **Right:** (a) direction Unknown. The drawn order is offered as a proposal with its reason ("drawn from A to B"), and is not stored as a fact. After inverts are typed at both ends the direction is known from them. (b) in both copies the direction follows the inverts (downhill to the LPD), not the drawing order.
3. **Faulty partner:** a build that stores the drawn order as the direction. It fails on (b).

**G9. Pit invert worked out from the pipes**
1. **Drawing:** MD-01 with the P3 invert blank.
2. **Do:** run Edit Pit.
3. **Right:** the P3 invert reads 9.80, the lowest connected pipe invert, and is marked "worked out from the pipes". The TRUST-05 line mentions it. If Tim instead rules it stays Unknown, the case flips: P3 reads Unknown.
4. **Faulty partner:** a build that fills 9.80 with no mark, and one that fills the highest pipe's invert (10.20 or 9.80 from the wrong pipe). Each must fail.

### Group B: the reaches (card section 2)

**How the robot tests a reach without knowing its value:** it reads the reach S in millimetres from Settings. It places the item at 0.8 times S (must be matched) and at 1.2 times S (must not be matched), once in the millimetre drawing and once in the metre drawing of the same job.

**G10. Pit to its label (was pit width plus 2000)**
1. **Drawing:** MD-05-MM and MD-05-M, P3's label moved to 0.8 S and then 1.2 S from P3.
2. **Right:** matched at 0.8 S and not at 1.2 S, in both. Identical results.
3. **Faulty partner:** a build with the reach fixed at 2000 drawing units. In the metre copy 1.2 S is "in reach" and the case fails.

**G11. Pit to its CL and IL text (was pit width plus 2500, CDUPGRADE)**
1. **Do and right:** as G10 with the cover level text, using CDUPGRADE.
2. **Faulty partner:** the fixed 2500.

**G12. Restoring typed values by position (was 200)**
1. **Do and right:** as G10 for the restore distance.

**G13. Re-attaching a pit record to a block (was 50, already unit-safe)**
1. **Do and right:** as G10. The value now lives on Settings; the reading must change when the Setting is changed on the test login.

**G14. Label to pit (5,000, already a Setting)**
1. **Do and right:** as G10. No change from today: same matches in both units.

### Group C: two candidates, plain lines, sources

**G15. Two pits in reach of one label**
1. **Drawing:** MD-06 (label 600 from P3 and 900 from P4). Then the label moved to 100 from P3 and still 900 from P4.
2. **Right:** in both positions the label is Unknown, listed with both candidates ("P3 at 600, P4 at 900"), and attached to neither. The record link for that label is blank. Same in the metre copy. The plain rule is: two in reach means Unknown even when one is far nearer (the earlier ruling, CV8-7).
3. **Faulty partner:** a build that picks the nearer. Must fail in both positions.

**G16. A plain line on a pipe layer**
1. **Drawing:** MD-02.
2. **Do:** run Edit Pit, then the check.
3. **Right:** the stray line is listed as a possible pipe with its reason ("on the stormwater pipe layer"). The record still holds 6 pipes, not 7. (After this step the TRUST-05 case Y7 expects 0 pipes added on this drawing, not 1.) If Tim chooses to add it as a pipe of Unknown size, the case flips: 7 pipes, size blank.
4. **Faulty partner:** a build that adds it with size 100.

**G17. Stored values say where they came from, and old ones are marked**
1. **Drawing:** MD-01 plus MD-23-OLD (a pipe with a stored size of 100 and no note of where it came from).
2. **Do:** place a pipe with CD typing 150; read a pipe size from a label (MD-03's "150 DIA." text); let G9's invert be worked out; let G3's width be proposed.
3. **Right:** the sources read: typed, read from a label, worked out, proposed. The old 100 reads "stored, source unknown" and is not marked Sure and not changed to Unknown (the card cannot clean old drawings).
4. **Faulty partner:** a build that stores the sizes with no source.

**G18. Save, close, reopen**
1. **Drawing:** MD-23 after G1, G2 and G6.
2. **Do:** save, close, reopen, read.
3. **Right:** the same Unknowns; nothing newly filled in; the record reading before saving and after reopening are identical.
4. **Faulty partner:** a build that re-fills the blanks when the drawing reopens.

**G19. The switch, and the limit of the switch**
1. **Do:** turn "Show Unknown where the drawing gives no value" off. Read MD-23 on a fresh copy. Turn it on again and read the same copy.
2. **Right:** off gives today's fill-ins for the new reading (100 and UPVC). Turning it back on does **not** change the values already written (the card says so). Settings reading shows the four reach values in millimetres on Settings.
3. **Faulty partner:** a switch that rewrites old values.

### Group D: the whole set, units, and other tools

**G20. Zero invented values across the made-up set**
1. **Drawing:** MD-01, MD-03, MD-04, MD-12, MD-23, MD-08.
2. **Do:** read each, and mark every item against the answer sheet with the five marks: Right, Unknown, Wrong, Invented, Proposed with a wrong value.
3. **Right:** zero Wrong, zero Invented, zero Proposed-wrong. Unknown is allowed where the drawing lacks the information, and the count of Unknowns is written. MD-04 (hand-drawn) claims nothing as Sure and invents nothing. Two of the made-up old drawings are kept back and never used to build a rule (review gap 2). When Tim's real test-set jobs T01 to T10 exist, this case runs on them too and the result is written as the test set's pass line.
4. **Faulty partner:** a build that fills 100 on one pipe (Invented or Wrong), and one that proposes a wrong size.

**G21. Millimetre and metre read the same, item for item**
1. **Drawing:** MD-05-MM and MD-05-M, and MD-23 in both.
2. **Right:** the two full readings are identical item for item. MD-05-U (units not set): RECORD what CE assumes and whether it says so.
3. **Faulty partner:** any reach or width read in raw drawing units.

**G22. Two logins, different personal settings**
1. **Do:** G1, G4, G6 and G15 on a second login with different personal Settings.
2. **Right:** identical readings (the reader's first rule: what a thing is never depends on who opens the drawing).

**G23. Tools that meet a blank size**
1. **Drawing:** MD-23.
2. **Do:** run CDCALC, CDRULES, CDPROFILE, CDRUNSOLVE, CDRECOVERINVERTS, and the Pit Schedule.
3. **Right:** no crash. No number is worked out from a size of 100. Each says in plain words that a size is not known. RECORD what each does. The card says this is not traced and must be read before the switch defaults on, so any tool that quietly uses a made-up size fails.
4. **Faulty partner:** a build where CDCALC substitutes 100.

**G24. A blank lid class in the schedule**
1. **Drawing:** MD-01 with the unplaced pit from G4.
2. **Right:** the schedule shows "?" or a blank in the lid column. No crash. RECORD which. The card lists this as not known.

### Group E: the nine cases every card must answer

**G25. Read-only, Save As, copied pits**
1. **Drawing:** MD-14, MD-09, MD-09-X.
2. **Right:** MD-14 reads the same and its file is unchanged. MD-09 reads the same as MD-01. In MD-09-X, nothing from the other job's record fills a blank here; RECORD what the two foreign pits' stored values are read as.

**G26. Xref, paper space, one job in two drawings, spoiled blocks, another version**
1. **Drawing:** MD-10, MD-11, MD-16, MD-12, MD-17-OLD, MD-17-NEW.
2. **Right:** a label in the host is never matched to a pit that lives in an Xref or in another file. A label on a layout is not matched to a model pit by distance. The exploded pit is not read as a pit. MD-17-OLD reads like MD-01. MD-17-NEW is not rewritten as older.

**G27. AutoCAD 2022 to 2024 and a hidden command**
1. **Do:** G1, G6, G15 and G21 on 2024. Run CDUPGRADE Merge (a command folded into Check this drawing) on MD-03.
2. **Right:** the same behaviour on 2024. CDUPGRADE Merge follows the same Unknown rules: no 100, no new number, no nearer-of-two.

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** G9, G6 and G1 run an update (Edit Pit, CDSYNC) and then read the result. G18 reads again after save and reopen.
2. **The same jobs taught and tested.** G20 keeps two made-up old drawings back and never builds a rule from them.
3. **"Sent" is not "worked".** Not a button case. The values are read from the record and the plan.
4. **Undo compared on linework.** This card changes what is written, not when. Add one check inside G6: after a tool runs, U once and compare the full drawing reading to before. Nothing new may remain, including no label text.
5. **Twice, identical.** G22 and G21.

## 4. The nine cases every card must answer

1. **Read-only:** G25.
2. **Save As, copied pits:** G25.
3. **Units not set or wrong:** G21 (MD-05-U is RECORD).
4. **Xref:** G26.
5. **Paper space:** G26.
6. **A hidden command typed from habit:** G27 (CDUPGRADE Merge, and CDSYNC in G1).
7. **Another version:** G26.
8. **Spoiled blocks:** G26 and G20.
9. **A job over several drawings:** G26.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** the Pit Schedule window, Edit Pit and Edit Pipe on MD-23; the check list; the plan of MD-23.

**What to look at, and what right looks like:**
1. **Unknown reads as Unknown.** In the Pit Schedule a blank size shows "?" and is easy to see. In Edit Pipe and Edit Pit a blank field says Unknown in plain words, or is clearly empty with its source, never a typed-looking value.
2. **The plan shows no "?"** and no invented number. Right = a council print cannot carry a "?" by accident.
3. **The check list shows the Unknowns** with "?" and the reason ("number Unknown: pit block with no label"), in drafting words.
4. **Colour and weight** make Unknown stand out where attention is needed (the UI emphasis rule), without making the window look broken.
5. **Edit Pipe on a pipe of Unknown size** can be filled in by typing, and the source then reads "typed".
6. **A worked-out or proposed value looks different** from a typed one. Right = a drafter can tell at a glance.
7. **Nothing reads 100 or UPVC** that the drawing did not give.

**Screenshots:** `GUESS06_schedule_question_marks.png`, `GUESS06_edit_pipe_unknown.png`, `GUESS06_plan_clean.png`.

**Cannot be proven without Tim:** engineering judgement on each fill-in (size, material, lid class, pit number, flow direction, invert from the pipes), whether the Unknowns on a real job are the ones he expects, and whether anything he knows is shown as Unknown.
