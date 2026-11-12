# Cases for TRUST-05: the quiet update made visible

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-05_SYNC_MADE_VISIBLE_CARD_DRAFT_2026-11-12.md` and installed Civil 3.0.90 (commit cf059dcf). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md`.
**Defaults taken for Tim (DRAFT, he confirms):** the card's recommended answers: only the four read-only tools plus the first step of CDRECOVERINVERTS stop updating; one line on the command line, no window and no sound; CDRECOVERINVERTS works from what is stored and refuses a pipe whose size is not known.

---

# FOR TIM

**These checks prove two things: the tools that say they only read really change nothing, and every time CE does update its record the one line it prints is true, to the number.**

1. **24 robot cases** (section 2).
2. **The main check is an "oracle" case (Y11).** For about 14 everyday tools the robot reads CE's record before and after, works out for itself what really changed, and compares each number in CE's line with that. It also checks the opposite: a tool that changed something must print a line, and a tool that changed nothing must print none.
3. **The undo promise is tested, not trusted.** Today CDSYNC prints "One U undoes it" and nobody has proven it. Y12 compares the whole drawing after one U. If U does not put everything back, the line must not say it does.
4. **Three things the line has never counted** (pipes dropped, pipes re-joined to another pit, levels changed from drawing text) each get a case (Y9, Y10), because a change with no line is the exact fault Tim named.
5. **Not known, so only recorded:** how AutoCAD's U treats these updates (the plan's first Undo test); which of the 60 or so places in the code fire on real jobs.

---

## 1. What is being proven

1. **Read-only means read-only.** CDGRAPH, CE Health, CDDIAG and the dashboard change nothing: not the record, not the drawing, not the changed counter.
2. **A line when something changed, and only then.**
3. **The numbers in the line equal the real change.**
4. **The promise about U is true.**
5. **Today's tools are not otherwise changed.** CDSYNC and CDREBUILD do what they did.

## 2. The robot cases

**How the robot works out "what really changed":** it reads the record before and after (record reading) and compares them itself, item by item. Categories: pits added, pits removed, pipes added, pipes removed, pipe ends re-joined to a different pit, cover levels changed, invert levels changed, other values changed. This is independent of CE's own counting.

### Group A: the four tools that only read

**Y1. Each of the four leaves everything as it was**
1. **Drawing:** MD-01 and MD-02 (one stray line on the pipe layer).
2. **Do:** on a fresh copy each time, run CDGRAPH, then CE Health, then CDDIAG, then the dashboard (CDDASHBOARD). Read the record reading, drawing reading and changed counter before and after each.
3. **Right:** all three identical for every tool on both drawings. (Today CDGRAPH, CDDIAG and CDDASHBOARD run the update first, so this must fail on the installed build.)
4. **Faulty partner:** the installed 3.0.90 build. A second: a build that stops the update in three tools and forgets the fourth. Each must fail by tool name.

**Y2. If the record is behind the drawing, the tool says so and does not fix it**
1. **Drawing:** MD-02.
2. **Do:** run each of the four tools.
3. **Right:** each says "needs checking" in one line with the right number: 1 line on the pipe layer is not in the record (card wording: `CE: needs checking. 2 lines on the pipe layer are not in the record.`). The number equals the count in CDCHECKCURRENT. The tool shows the stored pits and pipes (6 and 6), not 7 pipes.
4. **Faulty partner:** a build that quietly shows 7 pipes without saying so. Must fail.

**Y3. A pit block drawn but not recorded**
1. **Drawing:** MD-01 with one extra PIT BLOCK 3 inserted by plain INSERT (no record).
2. **Right:** each of the four says needs checking with 1 pit block not in the record, shows 6 pits from the record, and changes nothing.

**Y4. Close with no save question**
1. **Drawing:** MD-01.
2. **Do:** for each of the four tools, run it, close the tool, close the drawing with CLOSE.
3. **Right:** AutoCAD asks nothing about saving, the file hash is unchanged, the changed counter stayed at 0. (If any of the four marks the drawing changed today, this fails on the installed build.)
4. **Faulty partner:** the installed build if it marks the drawing changed.

**Y5. Cancel and Escape**
1. **Do:** run each of the four and close or cancel straight away; then again pressing Escape while any progress shows.
2. **Right:** record reading and drawing reading identical.

**Y6. CDRECOVERINVERTS no longer updates first, and refuses an unknown size**
1. **Drawing:** MD-23 (one pipe line with no size, no material, no drawn width) and MD-01.
2. **Do:** run CDRECOVERINVERTS on each.
3. **Right:** on MD-23 it refuses that pipe in plain words (size not known) and the record still holds a blank size; nothing reads 100. On MD-01 it works from what is stored: the record reading is identical before and after, the drawing reading differs only by the new invert text, and each text equals the answer sheet (9.10, 9.45, and so on).
4. **Faulty partner:** the installed build, where the quiet update fills "100" just before the tool checks whether the size is known. Must fail on MD-23.

### Group B: the line, when the record is updated

**Y7. Edit Pit on a drawing with one stray line**
1. **Drawing:** MD-02.
2. **Do:** open Edit Pit on P3 and close it without changing anything.
3. **Read back:** the robot's own difference from the two record readings; the command line.
4. **Right:** the robot's difference is exactly 1 pipe added. The line says 1 pipe added, in plain words. No other number. (Whether that new pipe carries "100 UPVC" is step 6's matter, not judged here. Once TRUST-06 is built, the plain line is no longer added and this case expects 0 pipes added; case G16 in `TRUST-06.md` says so. The oracle in Y11 stays true either way.)
5. **Faulty partner:** a build whose line says 2 pipes when 1 was added. Must fail. This is the card's own broken version.

**Y8. Nothing to update: no line**
1. **Drawing:** MD-01.
2. **Do:** open Edit Pit and close; run CD and press Escape; run a spot level Escape.
3. **Right:** the robot's difference is empty and there is no line at all. Silence means nothing happened.
4. **Faulty partner:** a build that prints "CE updated its record: 0 pipes added." Must fail.

**Y9. Erase a pit, then run PIT**
1. **Drawing:** MD-01 with P4 erased by ERASE.
2. **Do:** run PIT and press Escape before placing.
3. **Right:** the robot's difference shows P4 removed and what happened to its two pipes (removed or re-attached). The line states 1 pit removed and the pipe change with numbers equal to that difference. If the record lost pipes and the line does not count them, the case fails.
4. **Faulty partner:** a build that counts the pit but not its pipes.

**Y10. Changes the code does not count today: re-joined pipe and level read from text**
1. **Drawing:** (a) MD-01 with P3 erased and a new PIT BLOCK 3 inserted at the same spot, then run PIT. (b) MD-01 with the P3 cover text edited from 11.10 to 11.15, then Edit Pit.
2. **Right:** (a) the robot's difference shows the pipe ends re-joined to the new pit; the line says so with the right number. (b) the difference shows the P3 cover level now 11.15; the line says 1 cover level read from the drawing.
3. **Faulty partner:** a build that updates the record but prints no line for these two kinds of change. It must fail, because a change with no line is the fault this card exists to remove.

**Y11. The oracle: every everyday tool**
1. **Drawing:** a fresh copy of MD-01, MD-02, MD-03 and MD-12 for each tool.
2. **Do:** run each of these once, finishing its normal work: PIT (place one), CD (draw one pipe), CDEDIT on a pit, CDEDIT on a pipe, a spot level (CDSL), DP (place a downpipe), CDRENUMBER (preview, answer No), Pit Schedule relink, CDCALC (calculations), CDPROFILE (long section), CDINSPECTOR, CDRUNSOLVE, CDRECOVERINVERTS, CDCHECKCURRENT.
3. **Read back:** the robot's own difference per tool; the line.
4. **Right:** for each tool: if the difference is not empty, a line is printed and each number in it equals the difference by category; if the difference is empty, no line. The tool's own intended edit (the pit placed, the pipe drawn) is subtracted before comparing, and listed.
5. **Faulty partner:** three builds: one that miscounts one category, one that prints no line for one tool, one that prints a line for a tool that changed nothing. Each must fail by tool and category.

**Y12. The undo promise**
1. **Drawing:** MD-02 and MD-12.
2. **Do:** run Edit Pit (an update runs). Press U once. Compare the record reading and the **full drawing reading** with those from before the tool.
3. **Right:** two outcomes are allowed, and the case checks the line matches the outcome. If one U puts both readings back exactly, the line may say "U undoes it". If one U does not, the line must **not** say it. RECORD which outcome occurs, tool by tool (this is the plan's Undo test, run for real).
4. **Faulty partner:** a build whose line says "One U undoes it" while U leaves the record changed. Must fail. The installed CDSYNC is run through the same case and its result recorded: if its promise is false, it fails today.

**Y13. Two switches, both ways**
1. **Do:** (a) turn off "Tools that only read never update the record" and run CDGRAPH on MD-02. (b) turn off "Say what changed whenever the record is updated" and run Edit Pit on MD-02. Then turn both on.
2. **Right:** (a) the record reading after CDGRAPH now differs from before, as today. (b) the record changes and no line is printed. Both on: Y1 and Y7 results. Settings reading shows both default on.
3. **Faulty partner:** a build that ignores either switch.

**Y14. CDSYNC and CDREBUILD do what they did**
1. **Drawing:** MD-02, MD-03, MD-12 (fresh copy each).
2. **Do:** run CDSYNC, then in a second fresh copy CDREBUILD, on the installed build first and on the new build.
3. **Right:** the record reading and drawing reading after the new build equal those after the installed build, value by value. (The new build may add the line; the data must be the same.)
4. **Faulty partner:** a build that changes CDSYNC's result. Must fail.

### Group C: the same cases the plan asks of every card

**Y15. Units**
1. **Drawing:** MD-05-MM, MD-05-M, MD-05-U with one stray line each.
2. **Right:** the same difference and the same line numbers in all three. A cover level of 11.10 is read as 11.10 in each.
3. **Faulty partner:** a build with a reach fixed in drawing units.

**Y16. Locked layer and Xref**
1. **Drawing:** MD-18 and MD-10.
2. **Do:** run Edit Pit and PIT.
3. **Right:** nothing on the locked layer is changed (drawing reading identical for those objects), and the line never claims it was. In MD-10 the Xref's pits are not added to the host's record and not counted.
4. **Faulty partner:** a build that counts Xref pits as "added".

**Y17. Paper space and saved schedules**
1. **Drawing:** MD-11.
2. **Do:** with a layout current, open the Pit Schedule and place it.
3. **Right:** the robot's difference equals the line. The legend pit block on the layout is not added to the record. RECORD if it is.

**Y18. Copied pits from another job**
1. **Drawing:** MD-09-X.
2. **Do:** run Edit Pit.
3. **Right:** RECORD what the update does with the 2 pits that carry another job's identity. Whatever it does, the oracle holds: the line equals the difference. If the 2 pits are quietly accepted as part of this job, that is a finding for Tim.

**Y19. A drawing written by another version**
1. **Drawing:** MD-17-OLD and MD-17-NEW.
2. **Do:** run Edit Pit on each.
3. **Right:** RECORD whether the stored format number changes. If it changes, that is a change to the record and the oracle requires the line to say so; the card does not say how. On MD-17-NEW CE must not rewrite a newer record as an older one.

**Y20. Exploded, mirrored, scaled blocks**
1. **Drawing:** MD-12.
2. **Right:** Y11 on MD-12 holds. The exploded pit shows as 1 pit removed; the other blocks are not removed.

**Y21. Read-only file**
1. **Drawing:** MD-14.
2. **Do:** run Edit Pit.
3. **Right:** the line says what it changed in memory. File hash unchanged, no new file.

**Y22. Same on two logins**
1. **Do:** run Y7 on a second Windows login with different personal settings.
2. **Right:** identical line, word for word.

**Y23. AutoCAD 2022 to 2024**
1. **Do:** Y1, Y7, Y8 and Y11 on 2024.
2. **Right:** same lines, no ribbon needed.

**Y24. Speed of the read-only tools**
1. **Drawing:** MD-13 (large).
2. **Do:** time each of the four tools on the installed build and the new build.
3. **Right:** RECORD. The card expects the read-only tools to be faster. Not a pass or a fail.

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** The oracle (Y11) is a read after a real edit by each tool, compared against the robot's own difference.
2. **The same jobs taught and tested.** Not applicable: nothing is taught.
3. **"Sent" is not "worked".** The line printing is never accepted as proof. Each number in it is compared with the robot's difference (Y7, Y9, Y10, Y11).
4. **Undo compared on linework.** Y12 compares the full drawing reading after one U.
5. **Twice, identical.** Run Y11 twice per tool on fresh copies; the lines and differences must repeat. Y22 for two logins.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** Y21.
2. **Save As and copied pits:** Y18.
3. **Units:** Y15.
4. **Xref:** Y16.
5. **Paper space:** Y17.
6. **A hidden command typed from habit:** not applicable here. Y14 runs CDSYNC and CDREBUILD, the two hidden commands this card keeps working.
7. **Another CE version:** Y19.
8. **Spoiled blocks:** Y20.
9. **A job over several drawings:** run Y11 on MD-16's two files. RECORD whether a pipe whose pit is in the other file is counted as dropped. The oracle still holds.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** MD-02 and MD-01, doing a short normal drafting run: place a pit, draw a pipe, open Edit Pit, run CE Health.

**What to look at, and what right looks like:**
1. **The line reads as a plain sentence.** Right = like the card's example: "CE updated its record: 2 pipes added, 1 pit removed, 3 cover levels read from the drawing." No software word.
2. **One line, not a block of lines.** It does not wrap badly and does not scroll the useful lines away.
3. **Silence is silence.** Run Edit Pit and close with no change. Right = nothing printed.
4. **The "needs checking" line from a read-only tool** reads as a pointer, tells you what to type (CDCHECKCURRENT), and is not alarming.
5. **The line promises only what is true.** If the words "U undoes it" are on screen, the robot's Y12 result says that is true.
6. **Not a window and not a sound.**

**Screenshots:** `SYNC05_line_edit_pit.png`, `SYNC05_needs_checking.png`, `SYNC05_silent.png`.

**Cannot be proven without Tim:** whether the lines match what he knows of his own jobs, and whether any tool he uses now shows older information because it no longer updates first.
