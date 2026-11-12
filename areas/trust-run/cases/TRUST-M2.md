# Cases for TRUST-M2: going back a version, written and rehearsed

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-M2_GOING_BACK_REHEARSED_CARD_DRAFT_2026-11-12.md` and the card's own code references (Manager 1.1.89, commit cf059dcf; read in the card, **not re-read by this lane**). **Nothing here was run, and nothing may be run until Tim approves the card and names where the rehearsal happens.**
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD-01, MD-15 and MD-35, the pair saved by the newer build).
**This card is a procedure, not code.** The "cases" here are the checks the robot makes at each step of the rehearsal, and the faulty partner is a deliberate slip in the steps that the checks must catch. The colleague pack, page 2, sections 2 and 7, is the written procedure under test.
**Defaults taken for Tim (DRAFT; all four decisions are OPEN, so the cases follow the card's recommended answers):** it happens on a second Windows login on a spare office PC, never Tim's own login; the release keeper goes back, not the colleague; AutoCAD 2027 only; Manager's own Roll Back button stays hidden and is tried once only after this hand rehearsal has passed twice.

---

# FOR TIM

**These checks prove that going back one version, by the written steps, returns the PC to exactly where it started, that a drawing saved on the newer build still opens on the older one, and that the steps fit on one page and take about two minutes.**

1. **22 robot checks** (section 2).
2. **Safety first:** G1 makes the robot confirm it is on the spare login, and it refuses to run if it finds itself on yours. G20 checks your own login was not touched.
3. **The deliberate slip (G12):** the rehearsal is done once with a step left out, and the checks must catch it. It is the card's own example: Civil put back and Manager left new, so the CE ribbon is lost.
4. **Three answers the card says this rehearsal produces, recorded not passed:** does a drawing saved on the newer CE open cleanly on the older one (G9); does the older CE read the settings the newer one wrote (G10); does AutoCAD's security prompt appear on a login that has never loaded CE 3.0 (G18).
5. **Not known yet:** whether a spare office PC exists. If there is none, nothing runs (G2).

---

## 1. What is being proven

1. **The way back is complete.** Every file's fingerprint after going back equals the starting fingerprint.
2. **Drawings are never touched by going back.** Only made-up drawings are used.
3. **Old folders are renamed, never deleted.**
4. **The page is enough.** The second run, from a clean start, follows only the written page and takes about two minutes.
5. **The page is corrected** wherever reality differed.

## 2. The robot checks

### Group A: before anything is changed

**G1. The robot is on the spare login**
1. **Do:** before any step read the Windows user name, the machine name and the CE bundle folder path.
2. **Right:** they equal the spare login and spare PC the controller named in the run record. If they match Tim's own login, the run stops with BLOCKED and changes nothing.
3. **Faulty partner:** run the check once on Tim's login (read only, nothing else done). It must refuse.

**G2. A spare PC exists**
1. **Right:** the run record names a spare office PC with AutoCAD 2027 and a second login. If not, every case below is BLOCKED. The robot never substitutes Tim's login.

**G3. The starting point is written down**
1. **Do:** record the SHA256 of every file in the Civil and Manager bundles, the contents of CE_VERSION, the CEHEALTH reading, and a copy of the settings folders the pack names. The card says "the five CE settings folders" and the pack must name them. Hash each copy and its original.
2. **Right:** every file listed; every copy's hash equals its original's. If the pack does not name exactly five folders, RECORD the number and the names, and the case is not failed.
3. **Faulty partner:** a record taken after the first change. The later check against it would pass wrongly, so the robot checks the record's saved time is before the first step.

**G4. AutoCAD is closed, checked twice**
1. **Do:** read the process list for AutoCAD twice, a minute apart, before each swap.
2. **Right:** no AutoCAD process at either read before a swap. The robot refuses to swap while one is present.
3. **Faulty partner:** start a harmless AutoCAD and try the first rename. RECORD whether Windows lets the rename happen. The page must say stop at this point, whatever Windows does.

### Group B: the newer build goes in, is used, and goes back out

**G5. Newer build in, by the pack's steps**
1. **Do:** follow the pack: rename the old Civil and Manager folders to `.backup`, copy in the new ones (Civil and Manager together).
2. **Right:** both bundles' fingerprints equal the newer build's. Both `.backup` folders exist and their fingerprints equal the starting record. The all-users plugin folder holds no older CE copy that would load first (page 2, step 5); if one exists, RECORD it.
3. **Faulty partner:** G12.

**G6. Use it on made-up drawings**
1. **Drawing:** MD-01 and MD-15.
2. **Do:** open MD-01, place a few pits and pipes; open MD-15, place a few supports; change one named setting (a value only, named in the run record); save both. Take the record reading and drawing reading of each.
3. **Right:** the commands ran and the readings were taken. These become MD-35.

**G7. Go back, by the pack's steps**
1. **Do:** close AutoCAD; rename the new folders aside; take `.backup` off the old ones; put the settings copies back only if the page says so.
2. **Right:** every file's fingerprint equals the starting record, exactly. No extra file in either bundle. No folder deleted at any point (G15).

**G8. The ribbon and CEHEALTH after going back**
1. **Do:** start AutoCAD; take the ribbon reading; read CE_VERSION and run CEHEALTH.
2. **Right:** CE_VERSION equals the starting value. CEHEALTH shows nothing marked as a problem (the card says "clean"; RECORD the words it prints). The CE ribbon is present with the same tabs as at the start.

### Group C: what the older build does with what the newer one made

**G9. A drawing saved on the newer build opens on the older one**
1. **Drawing:** MD-35 (both drawings).
2. **Do:** open each on the older build; read the pits, pipes and supports; close with no edits.
3. **Right:** no error dialog and no recovery prompt. The pits, pipes and supports read equal the readings taken in G6 (counts and values; if CE's stored format number differs, RECORD it). The file hash after open and close is unchanged (the older build writes nothing on open).
4. **Faulty partner:** G12's slip. And a made-up drawing whose format number is edited to one far above the newer build's (MD-17-NEW pattern): the older build must say plainly it cannot read it, not show wrong numbers.

**G10. The older build and the settings the newer one wrote**
1. **Do:** read the Settings reading for the setting changed in G6.
2. **Right:** the value is either kept or plainly reset. A silent reset (a different value, no line saying so) is a fail.
3. **Faulty partner:** a settings file with a key the older build does not know. The older build must still open, with no crash and no lost values; RECORD what it does with the unknown key.

**G11. Fingerprints equal each other across runs**
1. **Do:** the fingerprints from the first going back and the second.
2. **Right:** identical, and equal to the starting record.

### Group D: the deliberate slip

**G12. One step left out on purpose**
1. **Do:** once, from a clean start, go back with Civil put back and Manager left on the newer build (the card's decision 2 example).
2. **Right:** the checks catch it: the fingerprints do not equal the starting record for Manager, CE_VERSION or the ribbon is wrong, and CEHEALTH or the missing ribbon shows it. The robot reports exactly which check failed.
3. **Faulty partner:** the slip itself. If every check still passes, the checks prove nothing and are rewritten before they are trusted.
4. **After it:** a full clean start before the real second run.

### Group E: the second run, timed

**G13. The second run follows only the written page**
1. **Do:** from a clean start, follow only the page (page 2 as corrected), timed.
2. **Right:** the steps fit on one page. The robot needed no step that is not on the page; every step it had to add is listed and the page corrected. RECORD the time. The card expects about 2 minutes the second time; the time is a note, not a pass or fail, until Tim sets a limit.

**G14. The pack's open marks are answered**
1. **Do:** count the "[CHECK]" marks on the pack's going-back page before and after.
2. **Right:** none left after. Each answer is written beside the mark.

### Group F: what must not happen

**G15. Old folders are never deleted**
1. **Do:** list the bundle parent folders after every step.
2. **Right:** at every step the older folders exist (as `.backup` or in place). No deletion at any point.

**G16. Drawings are never touched by going back**
1. **Do:** hash the made-up drawings before the first step and after the last, and the folder holding them.
2. **Right:** the only files that changed are the ones G6 saved on purpose. No drawing outside the made-up folder was opened or changed.

**G17. The installer's own kept copy (noted, not relied on)**
1. **Do:** read whether the installer keeps a copy of the old plugin (card section 4, item 2).
2. **Right:** RECORD whether it exists and where. The rehearsal never uses it.

**G18. The security prompt (RECORD)**
1. **Do:** on the first start after the newer build goes in, Codex records whether AutoCAD shows a security prompt, with a screenshot.
2. **Right:** RECORD. The card says it is not known. If it appears, the page needs a line telling the colleague what to press.

**G19. Manager's own Roll Back button stays hidden**
1. **Do:** take the ribbon reading on a normal colleague profile and on the administrator one.
2. **Right:** hidden on the colleague profile; administrator only. Trying it once on the spare login is NOT RUNNABLE until G7 and G13 have passed twice (decision 4).

**G20. Tim's own login was not touched**
1. **Do:** hash Tim's own bundle folders and settings folders before the rehearsal begins and after it ends (read only; nothing else on his login).
2. **Right:** identical. If the robot cannot read them without opening anything on his login, the case is RECORD, never an assumption.

### Group G: the record, and years

**G21. The one-page record is complete**
1. **Right:** the record has a date, the spare login, the AutoCAD year, the two builds, the steps, the second run's time, the fingerprint match, the made-up drawing result, CEHEALTH and the setting result. Nothing blank. No client name, no real drawing name, no real address (the robot searches the file for any name not in the run record).
2. **Faulty partner:** a record with one field removed. Must fail.

**G22. Other AutoCAD years: not in this rehearsal**
1. **Right:** the record says plainly that AutoCAD 2022 to 2024 were not rehearsed (decision 3). Nothing is claimed for them.

## 3. The gaps from the review, answered

1. **Reading alone is not enough.** G7 compares every file's fingerprint; G9 reads the drawings under both builds and compares them.
2. **The same jobs taught and tested.** Not applicable; no rules are learned. MD-35 is made by the rehearsal and used once.
3. **"Sent" is not "worked".** G8 runs CEHEALTH and reads the ribbon, instead of trusting that the steps ran.
4. **Undo compared on linework.** Not applicable; no drawing edit is made by going back.
5. **Twice, identical.** G11 and G13.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** G4 (AutoCAD open blocks the swap); G9 reads drawings read-only by hash.
2. **Save As and copied pits:** not applicable.
3. **Units:** not applicable.
4. **Xref:** not applicable.
5. **Paper space:** not applicable.
6. **A hidden command typed from habit:** not applicable.
7. **Another CE version:** this card is the case (G9, G10).
8. **Spoiled blocks:** not applicable.
9. **A job over several drawings:** G9 reads two drawings; a job split across drawings is not part of this.

## 5. The look by eye (Codex, real AutoCAD 2027, spare login only)

**What to open:** the ribbon and CEHEALTH after each swap; the first start after the newer build goes in.

**What to look at, and what right looks like:**
1. **The CE ribbon** is present and complete after going back, with the same tabs as at the start.
2. **CEHEALTH** reads as clean in plain words.
3. **Any security prompt** is photographed, not clicked, unless the page says what to press.
4. **The page itself:** the steps fit on one page and read in plain words a colleague could follow.

**Screenshots:** `M2_ribbon_start.png`, `M2_ribbon_new.png`, `M2_ribbon_back.png`, `M2_cehealth_back.png`, `M2_security_prompt.png` (only if it appears).

**Cannot be proven without Tim:** that the page works for a colleague who is not a coder; where the rehearsal happens and who may go back (decisions 1 and 2); and AutoCAD 2022 to 2024.
