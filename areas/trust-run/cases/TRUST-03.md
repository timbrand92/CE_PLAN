# Cases for TRUST-03: the same settings for everyone

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-03_SAME_SETTINGS_CARD_DRAFT_2026-11-12.md` and installed Civil 3.0.90 and Manager 1.1.89 (commit cf059dcf). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md`. Most cases here need no drawing: they use test Windows logins and the settings file (CD_Settings.json).
**Default taken for Tim (DRAFT, he confirms):** the cases are written on the card's recommended answers: Tim's PC is the source; a colleague's own changes are replaced after they press Apply with the old file kept; no finished-but-off feature comes on in this step; a level is never carried from one drawing into another; Manager's own switches travel in the office setup.

---

# FOR TIM

**These checks prove that two people on the same build get the same result from the same clicks, that your own PC is never overwritten, and that you can put a colleague's old settings back exactly.**

1. **24 robot cases** (section 2), on test logins, no real job.
2. **The example from the card is a case:** a colleague's Pit Schedule ordering P1, P10, P2 and yours P1, P2, P10 (case S11). The faulty partner makes exactly that happen and the check must catch it.
3. **The ones the robot cannot do:** whether the window reads clearly (Codex, section 5), and whether your own tools behave as before on your own PC (your three days).
4. **Not known, so the robot only records:** what each colleague's settings file holds today (no colleague PC was read); which values are read once at start-up, so Apply needs a restart.

---

## 1. What is being proven

1. **Same values.** After the office setup is applied, every office value equals the office file, value by value.
2. **Personal values stay.** Theme, window positions, folders, snap choices and tips are never changed.
3. **Nothing is lost.** The old settings file is kept, byte for byte, and can be put back exactly.
4. **Same result.** Two logins on the office setup give the same output from the same tool on the same drawing.
5. **Tim's PC is never overwritten.**
6. **Quiet when nothing changed.**

## 2. The robot cases

The test logins: **LOGIN-NEW** (never run CE), **LOGIN-OLD** (a made-up file with every value saved, three office values changed and two personal values changed), **LOGIN-SRC** (stands in for Tim's PC: where the office setup is made), **LOGIN-B** (a second login with different personal choices). A drawing is named only where one is needed.

### Group A: applying the office setup

**S1. A new login ends up on the office setup**
1. **Do:** first start of AutoCAD on LOGIN-NEW after an update that carries the office setup.
2. **Read back:** settings reading of LOGIN-NEW against the office file, value by value.
3. **Right:** every office value equals the office file. Every personal value is the built-in default. The file holds no folder path from LOGIN-SRC and no user name from it (privacy, and the earlier rule that keeps Tim's paths away from colleagues).
4. **Faulty partner:** a build that leaves one office value at its default, and a second that copies LOGIN-SRC's folder paths. Each must fail by name.

**S2. A login with an old file: the window lists exactly what differs**
1. **Do:** first start on LOGIN-OLD. Read the window's rows.
2. **Read back:** the robot works out the difference itself (office file against LOGIN-OLD's file, office values only), without asking CE.
3. **Right:** the rows equal that difference, exactly: the 3 changed office values, each with old and new in plain words. The 2 changed personal values are not listed.
4. **Faulty partner:** a build that lists all 5 changed values, and a build that lists only 2 of the 3. Both must fail.

**S3. Apply**
1. **Do:** press Apply on LOGIN-OLD.
2. **Right:** settings reading: all office values equal the office file; the 2 personal values are as they were; the old file exists beside the new one with a dated name, and its SHA256 equals LOGIN-OLD's file from before the update.
3. **Faulty partner:** a build whose Apply also resets the theme; a build that keeps the old file but re-saves it (same values, different bytes). Both must fail.

**S4. Not now**
1. **Do:** press Not now on LOGIN-OLD.
2. **Right:** settings file SHA256 unchanged. CE Health reads "Office setup: no, 3 values differ" with the right count (the robot's own count). The window does not return in the same session. RECORD whether it returns at the next start (the card says "first start after a release", so it may not).
3. **Faulty partner:** a build whose Not now applies anyway.

**S5. Escape and closing the window**
1. **Do:** press Escape, then separately close the window with the corner X, on LOGIN-OLD.
2. **Right:** identical to S4: no change, file unchanged.
3. **Faulty partner:** a build where closing the window counts as Apply.

**S6. Quiet when nothing changed**
1. **Do:** restart AutoCAD on LOGIN-NEW after S1, with no new release.
2. **Right:** no window. CE Health reads "Office setup: yes". The settings file's SHA256 and saved time are unchanged (CE did not touch it).
3. **Faulty partner:** a build that rewrites the file at every start.

### Group B: Tim's PC, the maker, and going back

**S7. The maker is never overwritten**
1. **Do:** on LOGIN-SRC, change two office values, run "Make this the office setup", then start a release that carries that setup.
2. **Right:** LOGIN-SRC's file SHA256 is unchanged by the update. No window appears on LOGIN-SRC.
3. **Faulty partner:** a build that applies the office file to the maker as well. Must fail.
4. **Not known:** how CE knows a PC is the maker's. RECORD the mechanism the builder uses.

**S8. Making the office setup shows what differs first**
1. **Do:** on LOGIN-SRC press "Make this the office setup" and Cancel at the preview.
2. **Right:** the preview lists exactly the values that differ from the last office setup (the robot's own difference). After Cancel, the shipped office file's SHA256 is unchanged. Then confirm: the new file holds office values only, no personal value, no folder path, no user name.
3. **Faulty partner:** a build that writes the file before showing the preview. Cancel then changes the file and the case fails.

**S9. Put my previous settings back, exactly**
1. **Do:** after S3, press "Put my previous settings back".
2. **Right:** the settings file's SHA256 equals the kept copy's SHA256 (byte for byte). CE Health goes back to "no, 3 values differ". Press it a second time: nothing breaks, and the kept copy is not overwritten.
3. **Faulty partner:** a build that rebuilds the file from values (same values, different order or spacing). The SHA256 differs and it must fail.

**S10. Two releases in a row keep two backups**
1. **Do:** Apply one office setup, then a second one a day later (clock moved on the test login).
2. **Right:** two dated kept copies exist, each equal to the file it replaced. The first is not overwritten.
3. **Faulty partner:** a build that reuses one backup name.

### Group C: same result for everyone

**S11. The Pit Schedule order (the card's own example)**
1. **Drawing:** MD-21 (pits P1, P2 and P10 to P17).
2. **Do:** on LOGIN-NEW and on LOGIN-B (with different personal settings) after both have applied the office setup, open a fresh copy of MD-21, run the Pit Schedule and export CSV.
3. **Right:** the two CSV files are byte-equal. The row order is the office setup's order (the answer sheet says P1, P2, P10 in natural order or P1, P10, P2, whichever the office file says).
4. **Faulty partner:** LOGIN-B keeps its own order switch. The files differ in order, and the case fails. This is the fault the card describes.

**S12. Three more tools give the same output**
1. **Drawing:** MD-01, MD-07 (plastic pits).
2. **Do:** on both logins run the CDRENUMBER preview, the Pit Schedule note on what it leaves out, and CDCHECKCURRENT. Read the command line and windows.
3. **Right:** identical text and numbers on both. MD-07 names the same plastic pits left out.
4. **Faulty partner:** one login with the plastic-pit switch changed.

**S13. The test-set reading before and after Apply**
1. **Drawing:** every made-up drawing used for step 1 (MD-01, MD-02, MD-03, MD-12).
2. **Do:** read each drawing on LOGIN-OLD before Apply and after.
3. **Right:** every difference is explained by one of the 3 changed values, named. An unexplained difference fails the case. (The office values change reaches and tolerances, so a reading can honestly differ; it must say why.)
4. **Faulty partner:** a build whose Apply changes a fourth value without listing it.

**S14. A level is not carried from one drawing to another**
1. **Drawing:** MD-01, then MD-05-MM.
2. **Do:** in MD-01 place a pit and type cover level 12.34. Close. Open MD-05-MM and place a pit, pressing Enter at the cover level.
3. **Right:** Enter does not give 12.34 (the BUG-743 fault). A size or material typed earlier may be remembered. This rests on the card's recommended answer (decision 4), so it is a DRAFT default.
4. **Faulty partner:** the current behaviour, where Enter reuses the old level. Must fail.

**S15. Choices that live in a drawing stay there**
1. **Drawing:** MD-01 with its stored rulebook choice and one paused feature set.
2. **Do:** Apply the office setup on LOGIN-OLD, then open the drawing.
3. **Right:** the drawing reading and record reading are identical to before. Those choices are not listed in the window and not in the office file.
4. **Faulty partner:** a build that puts a per-drawing choice in the office file.

**S16. Manager's own switches travel**
1. **Do:** change one Manager switch on LOGIN-SRC, make the office setup, apply on LOGIN-OLD.
2. **Right:** the same switch value on LOGIN-OLD (card decision 5, DRAFT default). The robot reads Manager's file, not Civil's.
3. **Faulty partner:** a build that carries Civil's values but forgets Manager's.

### Group D: things that can go wrong

**S17. A settings folder that cannot be written**
1. **Do:** make LOGIN-OLD's settings folder read-only, then start after the update.
2. **Right:** CE says plainly that it could not apply, nothing is half-written (file SHA256 unchanged, no partial file), and AutoCAD still starts. (This is the settings version of the card's "drawing read-only" case.)
3. **Faulty partner:** a build that writes the new file and then fails to keep the old one.

**S18. A damaged settings file**
1. **Do:** cut LOGIN-OLD's settings file in half, then start.
2. **Right:** CE sets the damaged file aside under a ".bad" name (the installed code already does this for unreadable files), applies the office setup to a fresh file, and says so plainly. The damaged file's SHA256 is kept.
3. **Faulty partner:** a build that deletes the damaged file.

**S19. Follow the office setup is off**
1. **Do:** set "Follow the office setup" to off on LOGIN-OLD, then start after an update.
2. **Right:** no window. CE Health says this PC keeps its own values and shows the count that differ. File unchanged.
3. **Faulty partner:** a build that applies anyway.

**S20. A previous build reads a file the new build wrote**
1. **Do:** after S3 install the previous Civil build on the test login (never on a real PC) and start it.
2. **Right:** it starts. It does not rename the file to ".bad", reset the values or crash. If it cannot read a new value it ignores it. RECORD what it shows. This is the review's hole 5 for settings.
3. **Faulty partner:** a build that adds a value the previous build treats as damage.

**S21. A value read only at start-up**
1. **Do:** pick ten values from the diff that change what a tool does. Apply, then without restarting run the tool that uses each.
2. **Right:** RECORD for each whether the effect is immediate. Where it is not, the window must have said "restart AutoCAD". Not known which values behave this way.

**S22. On AutoCAD 2022 to 2024**
1. **Do:** repeat S1, S2, S3 and S9 on 2024.
2. **Right:** same window, same CE Health line, same file results. Values that apply only to 2027 are carried and have no effect.

**S23. The three places show the same list**
1. **Do:** on LOGIN-OLD after Not now, read the window, the CE Health line with its list button, and the support bundle.
2. **Right:** the same count and the same value names in all three.
3. **Faulty partner:** a build whose support bundle lists a stale set.

**S24. No drawing is touched**
1. **Drawing:** MD-01 open during an update start.
2. **Right:** drawing reading, record reading and changed counter identical; the window never appears mid-command or mid-session (card section 2, item 1).

## 3. The four gaps from the review, answered

1. **Reading alone is not enough.** S11 to S14 do an ordinary action after Apply (export a schedule, place a pit) and read the result.
2. **The same jobs taught and tested.** Not applicable: nothing is learnt.
3. **"Sent" is not "worked".** S3 reads the file after Apply, not that Apply was pressed. S9 compares bytes.
4. **Undo on linework.** Not applicable: Apply does not touch a drawing (S24).
5. **Twice, identical.** S11 and S12 compare two logins; S1 run on two new logins must give the same file.

## 4. The nine cases every card must answer

1. **Read-only or locked:** S17 (settings folder read-only). A read-only drawing is not touched by this card (S24 on MD-14).
2. **Save As, copied pits:** not applicable.
3. **Units not set or wrong:** not applicable to settings. S14 uses a millimetre drawing after a metre-free one on purpose.
4. **Xref:** not applicable.
5. **Paper space:** not applicable.
6. **A hidden command typed from habit:** not applicable.
7. **Another CE version:** S20.
8. **Spoiled blocks:** not applicable.
9. **One job over several drawings:** not applicable.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** the update window on LOGIN-OLD (3 changed values, then a larger set of 20), the CE Health line, and the version window.

**What to look at, and what right looks like:**
1. **Plain words.** Each row is in drafting words with units, such as "Pit label reach: was 600 mm, now 800 mm". Right = no setting key name, no file path, no software word.
2. **One decision.** The window asks one thing: Apply or Not now. Both buttons are visible without scrolling. Right = it fits at 100 percent and 150 percent display scaling.
3. **Changed values stand out** (colour or bold, per the UI emphasis rule). Right = the eye goes to old and new, not to the chrome.
4. **The CE Health line** reads "Office setup: yes" or "no, 3 values differ", in the same place every time, with a button that lists them.
5. **It never appears at the wrong moment.** Not mid-command, not after AutoCAD has been running a while.
6. **Dark and light themes** both read well. Gold on dark, CE deep blue on light.
7. **The restore button** says what it does in one line and does not look like the primary action.

**Screenshots:** `SETTINGS03_window_3rows.png`, `SETTINGS03_window_20rows.png`, `SETTINGS03_health.png`.

**Cannot be proven without Tim:** that his own tools behave exactly as before on his own PC, and whether the office values are the ones he means. That is engineering judgement, and the three days.
