# Cases for TRUST-S2: Structural safety fixes (CLEAN, save reminder, SBEAM, Reset Defaults)

**Status: DRAFT (12 Nov 2026), lane trust-test-cases.** Written from card `04_REFERENCE\ux-plan\cards\TRUST-S2_STRUCTURAL_SAFETY_FIXES_CARD_DRAFT_2026-11-12.md`, `BUG_CARPARK.md` (BUG-1275 and BUG-1276 entries) and the card's own code references (Structural 1.0.126, commit 8de95c34; read in the card, **not re-read by this lane**). **Nothing here was run.** Nothing is built, installed or accepted.
**Drawings and readings:** `areas\trust-run\cases\_MADE_UP_DRAWINGS_AND_READINGS.md` (MD-33 and its variants for this card).
**Defaults taken for Tim (DRAFT; the card's three decisions are OPEN, so the cases follow its recommended answers):** CLEAN skips a locked object, lists it, carries on and saves; the reminder is 20 minutes then every 10; one small Structural safety build with S2 and S4 together.

---

# FOR TIM

**These checks prove CLEAN only says "Saved" when the drawing really was saved, that a locked object never stops CLEAN or gets unlocked, that the reminder speaks once and saves nothing, and that Reset Defaults asks first and keeps a copy.**

1. **24 robot cases** (section 2), each with a deliberately faulty twin that must fail, or marked RECORD.
2. **Five are written to FAIL on today's installed build** (F1, F4, F6, F8 and F20): they prove the faults exist before the fix.
3. **SBEAM cannot be proven fixed by any robot.** The crash dump says the crash comes from AutoCAD's own code, and that the stale-object guard drafted earlier does NOT stop it. The robot case (F18) only proves "a stale object does not crash", and the card itself says SBEAM stays typed-only if the lifted fix does not cover the 5 Nov crash.
4. **The card and the held build differ,** so the robot records, not passes: the held reminder fix uses 25 minutes and also copies AutoCAD's own automatic-save file into a CE backup folder every 10 minutes, but this card says 20 minutes, reminder only, and CE writes nothing (F13).

---

## 1. What is being proven

1. **CLEAN's words equal what it does.**
2. **"Saved" is only said when the saved time moved.** Otherwise "NOT SAVED: save the drawing yourself."
3. **A locked object is skipped, listed and never unlocked.**
4. **The reminder speaks and does nothing else.** No save, no file, no change flag.
5. **Reset Defaults asks, and keeps a copy.**
6. **Escape never leaves a half-saved file.**

## 2. The robot cases

### Group A: CLEAN's words

**F1. The three texts agree**
1. **Do:** read CLEAN's tooltip, its long help (`Assets\Config\command-registry.json`, entries cited in the card) and the Settings page text about saving.
2. **Right:** all three say CLEAN cleans up, then saves and says so. The tooltip reads "Cleans up, then saves the drawing and says so." (card). No text anywhere says CLEAN does not save. The Settings page no longer says "CE never saves" in a way that contradicts CLEAN (RECORD the new wording; the card does not give it).
3. **Faulty partner:** the installed build. The tooltip says "Does not save: save the drawing yourself." while the long help says it saves. **Written to FAIL on today's build.**

### Group B: CLEAN says "Saved" only when it was

**F2. CLEAN on a made-up copy**
1. **Drawing:** MD-33.
2. **Do:** run CLEAN. Read the file reading before and after, the command-line reading, the drawing reading and the changed counter.
3. **Right:** the saved time and file hash change, the changed counter is back to 0, and the command line says "Saved." The drawing reading differs from before only by what CLEAN is meant to do (the answer sheet). A backup or temp file is not left in the folder.

**F3. Reopen shows the cleaned drawing**
1. **Do:** after F2, close and reopen.
2. **Right:** the drawing reading equals the after-CLEAN reading.

**F4. CLEAN on a read-only copy**
1. **Drawing:** MD-33-RO.
2. **Do:** run CLEAN.
3. **Right:** "NOT SAVED: save the drawing yourself." The file hash and saved time are unchanged. Nothing new beside the file.
4. **Faulty partner:** (a) a build that says "Saved" anyway must fail (card check 2); (b) the installed build, which sends QSAVE and counts the save as done without checking (card, verified at `Services\CleanPipelineService.cs:167-169`). **Written to FAIL on today's build.**

**F5. A save that does not move the saved time**
1. **Drawing:** MD-33 open in a second AutoCAD session so the save cannot complete.
2. **Do:** run CLEAN in the first session.
3. **Right:** the saved time read back has not changed, so the line says "NOT SAVED". Never "Saved".
4. **Faulty partner:** a build that trusts QSAVE and says "Saved". Must fail.

### Group C: locked layers and Xrefs

**F6. One locked text**
1. **Drawing:** MD-33-L.
2. **Do:** run CLEAN. Read the drawing reading before and after.
3. **Right:** the locked text is identical in the drawing reading. Every other text is cleaned as the answer sheet says. The line names it, in the card's words: "1 text on locked layer TITLE left as it was." Then "Saved." Layer states identical (nothing unlocked).
4. **Faulty partner:** (a) a build that unlocks the layer to clean it; (b) the installed build, which fails the whole text step on one locked object (card, carried, `CleanPipelineService.cs:409, 526`). **Written to FAIL on today's build.** Each must fail.

**F7. A locked ByLayer object**
1. **Drawing:** MD-33-L (the ByLayer object on the locked layer).
2. **Right:** the ByLayer step skips it, lists it, and carries on. The object is unchanged in the drawing reading. Same faulty partners as F6.

**F8. The CLEAN locked-layer step as a whole**
1. **Do:** F6 and F7 on two builds: the installed build and the fixed one.
2. **Right:** installed: the step fails (finding recorded). Fixed: both pass. This case exists to keep the "fails today" evidence.

**F9. Xrefs are skipped, never detached**
1. **Drawing:** MD-33-X.
2. **Do:** run CLEAN.
3. **Right:** the attached drawing's own content is skipped as today. The Xref stays attached, with the same layer states and path. Nothing is bound, detached or unlocked.

**F10. A reference edit open**
1. **Drawing:** MD-33-X with REFEDIT open on the Xref.
2. **Right:** RECORD. The card says Xref drawings are skipped as today and says nothing about REFEDIT. The robot writes what CLEAN does and whether the drawing reading shows any change to the edited reference.

### Group D: Escape and Undo

**F11. Escape during CLEAN**
1. **Drawing:** MD-33-BIG (CLEAN runs several seconds).
2. **Do:** run CLEAN and press Escape in the middle. Read the file reading and drawing reading.
3. **Right:** the file hash and saved time are unchanged and no half-written file or temp file is left in the folder (card section 2, item 1). RECORD how much of the cleaning was done. If Escape cannot be sent mid-run reliably, the case is BLOCKED, never a pass.
4. **Faulty partner:** a build that saves after Escape or leaves a half-written file. Must fail.

**F12. CLEAN, then U (one U is tested, not trusted)**
1. **Drawing:** MD-33.
2. **Do:** run CLEAN; read the drawing reading; press U once; read again.
3. **Right:** RECORD whether one U returns the drawing reading to exactly the state before CLEAN. No on-screen words say "one U" until it is proven (card: "to be proven, never assumed"). The saved file on disk is not changed by U.

### Group E: the save reminder

(The robot sets the reminder time to 2 minutes in Settings so the case is short, and reads the Settings reading to confirm the value. The default is read separately in F16.)

**F13. One reminder, then every 10 minutes, and CE writes nothing**
1. **Drawing:** MD-33, edited (one LINE added) and not saved.
2. **Do:** wait past the set time. Read the command-line reading, the file reading, the folder listing, and AutoCAD's changed counter before and after each reminder.
3. **Right:** exactly one line at the set time, in the card's words: "CE: 2 minutes of work not saved in this drawing." (the number is the set time). A second line 10 minutes after the first. The changed counter is the same before and after each reminder. No file is written or copied by CE: file hash unchanged, folder listing identical.
4. **Faulty partner:** (a) a build that saves the drawing (hash changes); (b) a build that repeats every minute; (c) a build that copies AutoCAD's automatic-save file into a CE backup folder. Each must fail. (c) is what the held BUG-1276 build does, so the robot records that the held build differs from this card.

**F14. A save stops it; an untouched drawing never gets one**
1. **Drawing:** MD-33.
2. **Do:** (a) edit, save, wait past the set time. (b) open a drawing and make no edit, wait past the set time.
3. **Right:** no reminder in either case.
4. **Faulty partner:** a build that reminds about an untouched drawing. Must fail.

**F15. Several drawings open**
1. **Drawing:** MD-33 and MD-34, each edited and unsaved.
2. **Right:** RECORD. The card does not say whether the line names the drawing or whether each gets its own. The robot writes down what is printed. A reminder never goes to a drawing with no edits.

**F16. The setting**
1. **Do:** read the Settings reading for the reminder.
2. **Right:** default on, 20 minutes (decision 2, recommended). Off: no lines (use 2 minutes with the switch off). The robot also reads that the setting row names minutes.
3. **Faulty partner:** a build that ignores the switch. Must fail.

**F17. The reminder while a command is running**
1. **Do:** start a command that waits for a point (for example LINE) and wait past the set time.
2. **Right:** RECORD. The card does not say whether the line waits or prints into the prompt. Right at the least = the command is not cancelled and the drawing reading is unchanged.

### Group F: SBEAM

**F18. SBEAM with a stale object (the guard only)**
1. **Drawing:** MD-15.
2. **Do:** place a steel beam section after erasing something the placement plan refers to, as the BUG-1275 entry's steps say ("erasing or replacing something the plan refers to").
3. **Right:** no crash and a plain line saying the placement was refused. The drawing reading equals the one before the command, except for beams already placed earlier in the same run (the review notes earlier beams are kept, so the wording must not say "Nothing was changed" if some were kept).
4. **Faulty partner:** a build that opens the stale object without checking. If AutoCAD closes, the case fails; AutoCAD is allowed to close on a test copy.
5. **What this case cannot prove:** the 5 Nov crash. The crash-dump reading in the BUG-1275 entry says it came from AutoCAD's own drawing-database code, and that the stale-id guard "does NOT stop this crash". So a pass here must be worded "the guard works", never "BUG-1275 fixed". BUG-1275 stays OPEN until a different evidence says otherwise.

**F19. If the lifted fix does not cover the 5 Nov crash, SBEAM is typed-only**
1. **Do:** read the SBEAM ribbon button against the core list file (TRUST-S1 T1).
2. **Right:** SBEAM is on the tab only when the fix is recorded as covering the crash (card section 1, item 5). Until then it is typed only. RECORD which.

### Group G: Reset Defaults

**F20. Reset Defaults asks, and No changes nothing**
1. **Do:** change two Structural settings. Run Reset Defaults and answer No. Read the settings file (SHA256 and values) and the folder listing.
2. **Right:** the question is "Put every Structural setting back? A copy of your current settings is kept." with Yes and No (card). On No: the settings file is byte-identical and no new file appears.
3. **Faulty partner:** the installed build, which saves brand-new settings and closes at once with no question (card, verified at `UI\Dialogs\CeSettingsDialog.xaml.cs:475-478`). **Written to FAIL on today's build.**

**F21. Reset Defaults, Yes, keeps a copy**
1. **Do:** answer Yes. Read the settings file, the folder, the copy.
2. **Right:** every value equals the shipped default. A copy of the earlier settings sits beside the file and its values equal the two changed settings. Nothing else in the folder changes.
3. **Faulty partner:** a build that keeps no copy, or a copy that is the new defaults. Must fail.

**F22. Escape at the question**
1. **Do:** press Escape at the Reset question.
2. **Right:** the same as No: the settings file is byte-identical.

### Group H: the standing cases

**F23. Two logins, twice identical**
1. **Do:** run F2, F6, F13 and F20 twice on fresh copies on login 1 and once on a second login with different personal Settings.
2. **Right:** the same lines, word for word (the reminder time is set the same on both).

**F24. AutoCAD 2022 to 2024**
1. **Do:** F1, F2, F4, F6, F13 and F20 on 2024 (card section 2, item 5).
2. **Right:** the same lines and the same results. A step that cannot run on 2024 says so in the result and is not skipped silently.

## 3. The gaps from the review, answered

1. **Reading alone is not enough.** F2, F6 and F12 read the drawing after the edit and compare with the answer sheet, not with CE's own output.
2. **The same jobs taught and tested.** CLEAN's answer sheet comes from its shipped help; no learned list.
3. **"Saved" is not "worked".** F2, F4 and F5 read the file's saved time and hash, not just the word on the command line.
4. **Undo compared on linework.** F12.
5. **Twice, identical.** F23.

## 4. The nine cases every card must answer

1. **Read-only or open elsewhere:** F4, F5.
2. **Save As and copied pits:** not applicable (CLEAN and the reminder do not copy objects). A Save As in the middle of a reminder wait: RECORD inside F14.
3. **Units:** not applicable.
4. **Xref:** F9, F10.
5. **Paper space:** RECORD inside F6: run CLEAN with a layout current and read what it does to text on the layout.
6. **A hidden command typed from habit:** run CLEAN by typing it as well as by the button in F2. The same result.
7. **Another CE version:** after F2 a drawing cleaned by the new build is opened by the installed build: it opens, nothing is lost (RECORD).
8. **Spoiled blocks:** MD-15's blocks are untouched by CLEAN's text step; read in F2.
9. **A job over several drawings:** F15.

## 5. The look by eye (Codex, real AutoCAD 2027, copies only)

**What to open:** CLEAN on MD-33 and on MD-33-L; the Reset question; one reminder line.

**What to look at, and what right looks like:**
1. **CLEAN's lines** read as plain drafting words, name the layer and the count, and end with "Saved." or "NOT SAVED: save the drawing yourself." in a way a tired drafter cannot miss.
2. **The reminder** is one calm line. It does not look like an error.
3. **The Reset question** is one decision, says a copy is kept, and Yes and No are obvious.
4. **The tooltip, help and Settings page** read the same story about saving.

**Screenshots:** `S2_clean_lines.png`, `S2_reset_question.png`, `S2_reminder.png`.

**Cannot be proven without Tim:** that CLEAN at the end of each session always says Saved or NOT SAVED and you never lose work (your three working days); why CE made no backup for hours on 5 Nov (BUG-1276's cause is not known); and that SBEAM no longer crashes on a real job.
