# Colleague pack: one approval sheet for Tim (pages 01 to 06)

**DRAFT, Fri 30 Oct 2026 (Melbourne). Written by a read-only drafting job.** Nothing in `areas\colleague-pack\` was edited. Nothing was published, sent, built or run.

**Built from:** `areas\RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md` (the 97 changes), `areas\colleague-pack\06_COLLEAGUE_QUESTIONS_FOR_TIM.md`, `decisions\2026-10-29_TIM_ANSWERS.md` (all 117 entries), `decisions\2026-10-29_TIM_RELEASE_FREEZE.md`, `areas\COLLEAGUE_KNOWN_ISSUES_DRAFT_30OCT.md` and the BUG-861 entry in `BUG_CARPARK.md`.

---

# FOR TIM

1. **Answer:** the 97 pack changes fit into **12 batches**. My recommendation is to approve all 12. Seven need one small change each, listed in the batch. Then **10 questions** from page 06 need your answer. The other 3 of the 13 you already answered yesterday.
2. **How to answer:** reply with the batch numbers you approve, for example "approve 1 to 12". For the questions, reply with the number and your pick, for example "Q1 yes, Q2 A".
3. **Five things changed after the 97-change list was written (yesterday morning).** The batches already take these into account:
   1. **Hand-over is Mon 16 Nov, not Mon 9 Nov.** The pilot gets the newest tested build on Fri 13 Nov (your items 69 and 70). Every "9 Nov", "Mon 2 Nov" and "Fri 6 Nov" in the pack moves.
   2. **The REDO tip "close the CE Inspector first" does not work.** On 27 Oct the robot switched off every Inspector piece and REDO was still lost, 6 times out of 6. I took that tip out of batches 1 and 8.
   3. **The raingarden label is plain "RG", with no number.** Your item 77 says the number lives only in the tag. The list said "RG1, RG2".
   4. **The three "decisions Tim has not made yet" on page 04 are now all made:** survey Xref detach (item 52), stage drawing BIND (item 53) and how a colleague finishes an update (item 99, point 15). That page 04 section can go.
   5. **You approved the Manager Help tab (items 84 and 90).** It saves the support zip outside OneDrive. Until that tab is in Max's build, the pack still warns about OneDrive.
4. **The one safety change, in batch 5:** page 02 says "your drawings are safe either way" after going back to the old version. That is not true. The old version deletes the newer parts of CE's record when it saves a drawing (BUG-1135).

---

## How each batch reads

1. **Summary:** one line.
2. **For Max:** what changes for the drafter.
3. **Recommend:** approve, or approve with a change.
4. **Follows your rulings:** item numbers in `decisions\2026-10-29_TIM_ANSWERS.md`. "None" means it is wording only.
5. **TRUE ONLY IF:** if a sentence needs a fix that is not yet in Max's build, the old wording stays. On Fri 13 Nov the desk reads the installed build and swaps each sentence that is now true. (This is approve item 2 of the 97-change list. Batches 8 and 9 rest on it.)

---

# PAGES 01 TO 05: THE 97 CHANGES IN 12 BATCHES

## Page 01: Start here for Max (12 changes)

### Batch 1: what CE is and how it behaves (6 changes: 01-1, 01-2, 01-3, 01-4, 01-6, 01-7)

1. **Summary:** correct the version line and the "it never stops you" line. Say where Max's starting settings come from. Drop the Checks list from his 10 commands. Fix the REDO habit.
2. **For Max:**
   1. **Version:** "the version Tim gives you. Type `CE_VERSION` to read it." The number is filled in on Fri 13 Nov.
   2. **Refusals:** he is told the three things CE refuses, so a refusal does not look like a fault: a locked layer, a pit number that clashes, and a floor waste on an inspection opening.
   3. **Starting settings:** he starts with your switches but not your folder paths. If that file is not ready, he starts on CE's standard values and the page says so.
   4. **AutoCAD year:** "For AutoCAD 2027." The check mark goes.
   5. **Checks list:** `CDCHECKS` comes out of his 10 commands. He uses `CDRULES` instead.
   6. **REDO:** "After `U`, type nothing and pick nothing, then type `REDO`. If REDO says 'Nothing to redo', do the step again by hand."
3. **Recommend: approve, with two changes.**
   1. **01-4:** the year is now settled (your items 25 and 40), so drop the [CHECK].
   2. **01-7:** leave out the "close the CE Inspector" sentence. The 27 Oct robot test disproved it.
   3. **Also:** "ready by Fri 6 Nov" for the settings file becomes "ready by Wed 11 Nov", when packaging starts (item 70).
4. **Follows your rulings:**
   1. **Item 4:** a floor waste on an inspection opening is refused.
   2. **Item 99, point 6:** a locked layer stops CE up front, with one sentence naming the layer.
   3. **Item 63:** the one-piece pipe goes into Max's starting settings. That confirms the settings file.
   4. **Items 25 and 40:** Max will be on AutoCAD 2027.
   5. **Item 5:** the REDO control run.
   6. **Items 69 and 70:** the release dates.
   7. **Also covers:** approve items 5, 6 and 10 of the 97-change list.

### Batch 2: the first 10 minutes and day one (6 changes: 01-5, 01-8, 01-9, 01-10, 01-11, 01-12)

1. **Summary:** make the practice script match what CE really does on screen today. Add a day-one block.
2. **For Max:**
   1. **DP:** the exact prompts, and "a downpipe can take up to half a minute; wait, do not click again."
   2. **Units:** "type `UNITS` first and check Millimetres."
   3. **PIT:** "the New Pit window can take a few seconds to appear." PIT keeps offering the next pit until Esc.
   4. **Practice pipe:** he types both levels himself, 18.000 and 17.880 (about 1 in 167). That keeps his first pipe off the 1 in 200 boundary, where a self-contradicting warning appears.
   5. **Help:** "Type `CDHELP` and read the first page." No section name until Codex has looked.
   6. **Day one:** a 30-minute sit-down with you, then a daily check-in for the first week.
3. **Recommend: approve, with one change.** The sit-down is **Mon 16 Nov**, not Mon 9 Nov. The practice drawing and the reply time come from questions Q10 and Q6 below. The new levels are run once on a test copy before the pack goes out (approve item 9).
4. **Follows your rulings:**
   1. **Item 10:** a drawing with no units is read as millimetres.
   2. **Item 2:** the "Recent:" level buttons come back.
   3. **Item 47:** levels are held to 10 mm and the grade stays as asked.
   4. **Items 69 and 70:** the dates.

---

## Page 02: Install and update (19 changes)

### Batch 3: before the install (7 changes: 02-1 to 02-7)

1. **Summary:** fix the date and the install time. Show how to read the AutoCAD year. Deal with old CE copies. Say exactly where the files come from.
2. **For Max (and whoever installs):**
   1. **Time:** "about 20 minutes", not 5, until a practice install measures it.
   2. **Year:** type `ABOUT` to read the AutoCAD year. The status bar is not reliable for this.
   3. **Old Structural:** before install day, any old Structural folder holding a shared CE file is renamed to `.backup`. This depends on your answer to Q3.
   4. **Old copies:** two all-users folders are checked, ProgramData **and** Program Files.
   5. **Where the files come from:** the `CE V3 PILOT` folder or a USB stick, never an emailed or Teams zip. The desk then checks every file against the release list.
   6. **Settings:** copy the colleague settings file, never your own.
3. **Recommend: approve, with two changes.**
   1. **02-6:** the folder question is answered (`CE V3 PILOT`, shared "can view" to Max only), so drop its [CHECK].
   2. **02-1:** the header date becomes the date the pack is finalised, for Mon 16 Nov.
4. **Follows your rulings:**
   1. **Item 28:** the `CE V3 PILOT` folder.
   2. **Items 25 and 40:** AutoCAD 2027.
   3. **Item 65:** Max can install programs.
   4. **Item 63:** the settings file.
   5. **Item 29:** Structural stays on your PC only.
   6. **Also covers:** approve items 7 and 12.

### Batch 4: first start, checks and support (8 changes: 02-8 to 02-15)

1. **Summary:** tighten the first-start checks. Add the OneDrive warning for the support zip and two more "do not press" buttons. Fix the update-route sentence.
2. **For Max:**
   1. **After `CEHEALTH`:** "also look at the ribbon. CEHEALTH can say OK when Civil did not load."
   2. **Version:** check the version numbers.
   3. **OneDrive:** "if your Desktop is in OneDrive, the support zip uploads itself."
   4. **Do not press:** add the Manager fault report and `CEMANAGERDIAG`.
   5. **Shared-file message:** "you do not have the installer, ask Tim."
   6. **"Menu item failed to load":** "you may not see this line at all."
   7. **Still open:** the security prompt and the ribbon panel names stay marked until a practice install and a Codex look fill them in.
3. **Recommend: approve, with one change.** Three sentences become TRUE ONLY IF:
   1. **Help tab in the build (items 84 and 90):** the OneDrive warning becomes "the zip is saved in a CE Support folder outside OneDrive". Typing `CEMANAGERDIAG` only opens the Help tab, so it comes off the "do not press" list.
   2. **Update-on-close in the build (item 99, point 15):** the update sentence says "Manager finishes an update the next time you close AutoCAD". Otherwise it stays "updates by hand".
4. **Follows your rulings:**
   1. **Items 84 and 90:** the Help tab, with the IT-copy tick box unticked.
   2. **Item 99, point 15:** colleague updates finish on the next close.
   3. **Item 98:** the Updates & Rollback button opens the user's own screen.
   4. **20 Oct ruling, item 5:** updates by hand. That is in another file.
   5. **Also covers:** approve item 3.

### Batch 5: going back to the old version (4 changes: 02-16 to 02-19), SAFETY

1. **Summary:** keep "rename, never delete" and the menu name. Say the Roll Back button is still visible. Replace "your drawings are safe either way" with a warning.
2. **For Max:** "A drawing you worked on in 3.0 is not safe to save with the old version. The old version can delete the newer parts of CE's record (for example, a check you chose to ignore comes back). After going back, open 3.0 drawings only to look, do not save them, and tell Tim."
3. **Recommend: approve as written.** 02-19 is the one sentence in the pack that could lose work. On the Roll Back button: if the item-98 change is in the build, the line becomes "the Updates & Rollback button shows your own screen; still do not press Roll Back."
4. **Follows your rulings:**
   1. **Item 98:** the Updates & Rollback button.
   2. **No ruling needed for 02-19:** it is a fact, BUG-1135.
   3. **Also covers:** approve item 8.

---

## Page 03: What's in this release (16 changes)

### Batch 6: correct what the page claims is built and seen (12 changes: 03-1 to 03-8, 03-11 to 03-14)

1. **Summary:** set the base version. Add a "Seen by Tim" label. Correct five claims that are wrong for today's build. Take out one line Max does not need.
2. **For Max:**
   1. **Seen by Tim:** PIT and CD keep placing, and U names what it undid (your 29 Oct hand checks).
   2. **Off in his version:** the Checks list and Tidy labels are both OFF. CDCHECKIGNORE now changes nothing when it is off.
   3. **Recover Inverts:** it keeps the levels and reports counts. It does **not** redraw missing level text, as your own 29 Oct run showed.
   4. **Fresh install:** it starts on CE's standard values, not "exactly Tim's PC".
   5. **Not yet proven:** the first-run tour, until Codex sees it. The ribbon-tab jump has a known fault.
   6. **Removed:** the "command outcome log line", which only matters to you.
   7. **Double-click on a downpipe:** TRUE ONLY IF the fix is in the build.
3. **Recommend: approve, with one change.** Under 03-3, once item 76 is built, say "double-click a downpipe, OF, FO or RG and one window edits both its printed label and its tag." Until then, keep the old wording.
4. **Follows your rulings:**
   1. **Items 22 and 76:** double-click on the green DP label, and label plus tag on every source block.
   2. **Item 8:** "names the pipe" is ON. That is narrower than Tidy labels itself, which stays OFF.
   3. **Item 63:** starting settings.
   4. **Also covers:** approve item 10.

### Batch 7: privacy lines and the two new sections (4 changes: 03-9, 03-10, 03-15, 03-16)

1. **Summary:**
   1. **Support zip:** say it may sync through OneDrive.
   2. **Job time:** tell Max what job-time logging records.
   3. **New section 10:** about 40 fixes installed since 3.0.70.
   4. **New section 11:** your 29 Oct rulings, each shown only if it is in his build.
2. **For Max:**
   1. **Job time:** "CE writes your Windows login and job numbers to the shared Drafting folder. A weekly export includes job addresses. You cannot turn this off yet."
   2. **Fixes list:** a plain list of fixes he now has, each marked "built, installed, not seen" unless a check says more.
3. **Recommend: approve, with three changes.**
   1. **Raingarden label (section 11):** write it as a plain "RG", with no number (item 77). The list said "RG1, RG2".
   2. **The 300 mm head line (section 10):** "warns under a 300 mm head, on the head you type" becomes, TRUE ONLY IF built, "on the head left after pipe losses" (item 31).
   3. **New lines for section 11, each TRUE ONLY IF in the build:**
      1. Hard-ground runoff 0.9 switched on (item 30).
      2. The pipe sizer steps up a size before going steeper (item 37).
      3. The one-piece pipe is on for everyone (item 63).
      4. AG drains show no text (item 46).
4. **Follows your rulings:**
   1. **Section 11 rulings:** items 2, 3, 10, 15, 17, 18 and 20 (the same list), plus items 30, 31, 37, 46, 63 and 77.
   2. **Job-time logging:** no ruling. The policy question (BUG-492) stays yours. This batch only tells Max what is recorded.
   3. **Also covers:** approve item 4.

---

## Page 04: Known problems (40 changes)

### Batch 8: base page 04 on the 25 Oct draft, and update 15 of the 30 old items (15 changes)

1. **Summary:**
   1. **One base page:** the 25 Oct draft, written in drafter's words, with no bug numbers.
   2. **15 old items:** 6 reworded, 7 that change only if their fix is in the build, and 2 removed. The other 15 old items stay as they are.
2. **For Max:**
   1. **Reworded:**
      1. Pipe grade now uses the real pipe length.
      2. Pipe material now reaches the design. Keep hand-checking concrete sizes until it is confirmed.
      3. Pit Schedule depth now goes to the pit floor.
      4. The start-up lines may not appear at all.
      5. F2: "on Tim's PC F2 runs CLEAN. If yours does too, save with Ctrl+S."
   2. **Only if the fix is in the build:**
      1. Downpipe double-click.
      2. Green DP label.
      3. Rainfall note wording.
      4. Cover to the outside of the pipe.
      5. Pit drop warning.
      6. No-units line.
      7. A figure typed with a comma is refused.
   3. **Removed:** the log-line item, and the CDCHECKIGNORE item (no longer true).
3. **Recommend: approve, with two changes.**
   1. **Item 4 (REDO):** no Inspector tip. Keep only "type nothing between U and REDO".
   2. **Move two items from "keep" to "only if built":**
      1. Item 2, the pit label double-click: ON only after a Codex look (item 94).
      2. Item 15, hard-ground runoff 0.9: switch ON in the next train (item 30).
4. **Follows your rulings:**
   1. **Item 22:** the green DP label.
   2. **Item 16:** the curve is unchanged and the note is a draft.
   3. **Items 17 and 50:** cover to the outside, with the wall table on Settings.
   4. **Item 18:** the pit drop warning.
   5. **Item 10:** the no-units line.
   6. **Item 6:** the comma figure.
   7. **Item 20:** roughness 0.013 for an unknown material.
   8. **Item 94:** the pit label double-click.
   9. **Item 30:** hard-ground runoff 0.9.
   10. **Also covers:** approve items 1, 2 and 11.

### Batch 9: correct 14 statements in the 25 Oct draft that are now false (14 changes: FS1 to FS14)

1. **Summary:** the 25 Oct draft says "next update" or "Tim is deciding" for things already installed or already decided.
2. **For Max:**
   1. **Wording:** about 15 lines change from "no fix yet" or "next update" to "fixed in your build, not yet confirmed".
   2. **Decided items:** these lose "Tim is deciding": the green DP label, the computations sheet line, detention with no length, "Unknown" wording, cover, pit drop, no units and rainfall.
   3. **Removed:** the Structural section and "do not copy Tim's settings file" (that moves to page 02).
3. **Recommend: approve, with two changes.**
   1. **FS11:** delete the whole "Decisions Tim has not made yet" list. The last three are now decided (items 52, 53 and 99 point 15).
   2. **FS12 (remarks crossing the row lines):** the list said "the row grows a third line". Your item 43 says that is wrong: first a tighter line spacing, then a full double-height row with a mask behind the text. For Max: "a long remark can cross the row lines; fix not in your version."
4. **Follows your rulings:**
   1. **Items 22, 15, 21, 17, 18, 10 and 16:** the decided items.
   2. **Item 43:** schedule rows.
   3. **Items 52, 53 and 99, point 15:** the last three open decisions.
   4. **Item 29:** Structural is out.
   5. **Plus:** the 20 Oct ruling, item 3, in another file.

### Batch 10: add 11 new problems found after 25 Oct (11 changes: N1 to N11)

1. **Summary:** add the faults found this week, in drafter's words.
2. **For Max:**
   1. **Slow commands:** DP and PIT are slow; wait, do not click again.
   2. **Pipe grade:**
      1. Type both levels yourself, because the filled-in level is rounded.
      2. Check Pipe grade after typing the first level, because CE can switch it to "Set my own".
      3. The preview can show old values.
      4. A pipe at exactly the minimum grade can say "shallower than minimum".
   3. **Labels and schedule:**
      1. Two pipes at one pit can leave text over the pit symbol.
      2. After EXPLODE, ERASE or COPY many "schedule cell not updated" lines may print; run Update existing schedule.
      3. A label near the border may say "no clear spot".
   4. **ROTATE or SCALE Copy:** do not let the copy land on the original pit.
   5. **Floor waste:** cannot go on an inspection opening (intended).
   6. **New Pipe window:** no "Recent:" buttons yet.
3. **Recommend: approve, with two changes.**
   1. **N9:** say "place the copy well clear of the pit". The 30 Oct diagnosis showed even a copy 0.1 mm off still took the pipes; 5 m away was proven safe. That is the only item on page 04 that can damage drawing data.
   2. **Add one line you asked for (item 48):** "check the pit after pasting from a stage drawing."
   3. **Also, separately:** `areas\COLLEAGUE_KNOWN_ISSUES_DRAFT_30OCT.md` has 26 newer issues. They are not part of the 97; approve them as their own page 04 section when you have time.
4. **Follows your rulings:**
   1. **Item 4:** the floor waste refusal.
   2. **Item 2:** the "Recent:" buttons.
   3. **Item 48:** the stage drawing paste line.
   4. **Item 71:** New Pipe window v2 approved, which covers the preview fault later.

---

## Page 05: How to report a problem (10 changes)

### Batch 11: the support zip, what it holds and where it goes (6 changes: 05-1 to 05-6)

1. **Summary:**
   1. **Main route:** keep the support zip (`CESUPPORT`) as Max's main way to report.
   2. **Short notes:** add `CDFEEDBACK`.
   3. **Wording:** drop the unchecked "drawing paths are cut back" claim and add the OneDrive warning.
   4. **Logs:** name both log folders.
2. **For Max:**
   1. **What the zip holds:** "No login or PC name appears in the zip's file names. What is written inside the logs has not been checked."
   2. **OneDrive:** "If your Desktop is in OneDrive, the zip uploads itself."
   3. **Which logs:** "send today's log file and yesterday's."
3. **Recommend: approve, with one change.** TRUE ONLY IF the Help tab is in Max's build (items 84 and 90): 05-3 and 05-5 become "the zip is saved in a CE Support folder outside OneDrive; tick 'Also copy it to the office IT folder' only if you want IT and Tim to get it straight away."
4. **Follows your rulings:**
   1. **Items 84 and 90:** the Help tab.
   2. **Item 14:** client and drawing names do not leave the PC. That ruling was for Manager's fault reports, but the same aim applies here.
   3. **Also covers:** approve item 3.

### Batch 12: where reports land, reply time, and two safety lines (4 changes: 05-7 to 05-10)

1. **Summary:** keep the pilot results folder line until Max can save into it. Fill in the reply time. Add two lines.
2. **For Max:**
   1. **"Saved on this PC":** "If CDFEEDBACK says the report was saved on this PC, it did not reach the office. Put it in the pilot folder."
   2. **A drawing looks wrong:** "do not save over it. Close without saving and tell Tim the file name."
3. **Recommend: approve as written.** The folder and the reply time come from questions Q5 and Q6 below.
4. **Follows your rulings:** none from 29 Oct. Your 8 Oct "yes" to Max writing to the pilot results folder is in `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`.

---

# PAGE 06: THE 13 OPEN QUESTIONS

## 10 to answer now, in this order

The order is: what blocks the install plan first, then what fills in the pack, then the pack's look.

1. **Q1 Who installs on Max's PC, and when?** (page 06 Q1)
   1. **Pick one:** A) you, at 8:40 Mon 16 Nov, following page 02 with the desk on the line; B) someone else (name them).
   2. **Recommend: A.** About 20 minutes of Max's morning. The desk cannot reach his PC.

2. **Q2 Old Manager in Max's all-users folder: will you (or IT) check Max's PC in the week of Mon 9 Nov?** (page 06 Q4)
   1. **Yes or no.**
   2. **Recommend: yes, you.** An old Manager there can hide the CE ribbon. Max's login can install programs (your item 65). The desk removes nothing without your word.

3. **Q3 Max's old July Structural: what happens to it?** (page 06 Q3)
   1. **Pick one:** A) rename its folder to `.backup` before install day; B) leave it installed but switch it off in CEMANAGER; C) leave it as it is.
   2. **Recommend: A.** Its shared CE file could load before the new Civil's and break the help and linetype lookups. Renaming is undone by renaming back, and it does not rely on the old Manager working. (Page 06 recommended B; the newer audit points to A.)

4. **Q4 Real jobs, or copies only?** (page 06 Q7)
   1. **Yes or no:** copies only for the first week, then real jobs once Codex has passed the pilot build and there have been 5 working days with no new bug?
   2. **Recommend: yes.** On a job, Max practises on a copy of a live job; nothing he issues comes from an untested build.

5. **Q5 Will you share the "CE Plugin Pilot Results" folder with Max as "can edit" this week?** (page 06 Q11)
   1. **Yes or no.** In SharePoint: Share, then Max Mishchenko, then "can edit". The desk has no tool to do this.
   2. **Recommend: yes.** You said yes on 8 Oct, but nobody has confirmed it works. Then Max saves one test file there.

6. **Q6 Reply time for Max's reports?** (page 06 Q12)
   1. **Pick one:** A) the same working day for anything that stops him, and the weekly Monday session for the rest; B) another time (say it).
   2. **Recommend: A.**

7. **Q7 Inspector and CDRULES disagree: which one does Max trust?** (page 06 Q18)
   1. **Pick one:** A) CDRULES, council first, with the Inspector changed to match; B) the Inspector.
   2. **Recommend: A.** CDRULES carries the council rule, and your approved guidebook cards (GB-01, GB-02) feed it. Build item B-022 is already queued to make them agree.

8. **Q8 Print pages 01 and 05 as one-page sheets beside Max's monitor?** (page 06 Q19)
   1. **Yes or no.** Page 02 stays on screen for whoever installs.
   2. **Recommend: yes.**

9. **Q9 Screenshots on page 02: Codex takes them during packaging (Wed 11 to Fri 13 Nov) on a test copy of the pilot build?** (page 06 Q20)
   1. **Yes or no.**
   2. **Recommend: yes.** Pictures taken earlier could show a window that changes before Fri 13 Nov.

10. **Q10 Practice drawing for Max's first 10 minutes.** (page 06 Q13)
    1. **Pick one:** A) a blank office template, A1 horizontal; B) a blank office template, A3 classic; C) another drawing (name it).
    2. **Recommend: A or B, whichever you prefer.** A blank template has no client data. These are the two templates your new-job card puts first (item 101). The choice between them is yours; I have no record of a preference.

## 3 already answered yesterday (no answer needed)

1. **Page 06 Q2, is Max on AutoCAD 2027:** you said "he will have 2027, currently has 2022", then "yes" to having it by about Fri 13 Nov (items 25 and 40). The desk asks for the exact date near the pack stage.
2. **Page 06 Q5, where the release copy sits:** a separate `CE V3 PILOT` folder, shared "can view" to Max only, with the July copies untouched (item 28).
3. **Page 06 Q6, old install files in the IT Admin folder:** move them to an OLD folder before the pilot, and delete them later on a timeline. No colleague installs from them (items 54 and 64). Deletion still needs your yes on a file list. The proposed review date is Mon 14 Dec.

---

## What you are NOT being asked here

1. **Partly answered, left alone:**
   1. **Page 06 Q8:** design tools for drafting only.
   2. **Q9:** tools switched off.
   3. **Q14:** rainfall wording, which is built as a draft.
   4. **These three stay as the pack already handles them.**
   5. **Q17, the minimum grade:** now settled by GB-01 (items 24 and 26). Page 04 says it only once that work is in Max's build.
2. **Engineering items with their own chats** are not repeated here, for example the Hazen-Williams C value and the CEMEMBER sizes.

---

---

# Notes for the desk (nothing here for Tim)

1. **Counts.**
   1. **The 97:** page 01 has 12, page 02 has 19, page 03 has 16, page 04 has 40 and page 05 has 10. Page 04's 40 are the 15 old items that change (6 CHANGE, 7 COND, 2 REMOVE), plus FS1 to FS14 and N1 to N11.
   2. **Batches:** 6 + 6 + 7 + 8 + 4 + 12 + 4 + 15 + 14 + 11 + 6 + 4 = 97.
   3. **The 15 KEEP items on old page 04 are not counted as changes.**
2. **The 13 open questions are page 06 Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q11, Q12, Q13, Q18, Q19 and Q20**, as listed in section 6 of the 97-change list. Q2, Q5 and Q6 were answered later on 29 Oct (items 25, 40, 28, 54 and 64), so 10 need Tim.
3. **Corrections to the 97-change list, made here and checked against the files:**
   1. **REDO tip:** the "close the Inspector" tip (01-7 and 4A item 4) is contradicted by `BUG_CARPARK.md` (BUG-861 evidence, 27 Oct robot bisect: all 14 `diag.redo` switches ON, REDO lost 6 of 6).
   2. **RG label:** B-007 "RG1, RG2" is contradicted by item 77.
   3. **Dates:** Fri 6 Nov and Mon 9 Nov are superseded by items 68 to 70 and the freeze addendum.
   4. **FS11's last three items:** decided by items 52, 53 and 99 point 15.
   5. **FS12 wording:** contradicted by item 43.
   6. **02-13:** item 99 point 15 is now relevant to it.
   7. **4A items 2 and 15:** moved by items 94 and 30.
   8. **03-15 head check:** changed by item 31.
4. **Not verified:**
   1. **No DLL version read:** I did not read any installed DLL version.
   2. **C-76 and C-77:** "C-76 = Civil 3.0.86, installed 29 Oct 17:51" and "C-77 = 3.0.87" are taken from `COLLEAGUE_KNOWN_ISSUES_DRAFT_30OCT.md`, not checked.
   3. **B-items:** whether any B-item, the Help tab (items 84 and 90), update-on-close (item 99.15) or Updates & Rollback (item 98) will be in the Fri 13 Nov build is unknown.
   4. **Q10 practice drawing:** the A1 horizontal and A3 classic names come from item 101. Whether either is free of client data in Tim's template folder was not checked.
   5. **Q3 recommendation A:** it rests on `TEAM_AUDIT_T5` finding 5 (load order UNVERIFIED).
   6. **Q7 recommendation A:** "GB-01 and GB-02 feed CDRULES" is my reading of the cards, not checked in code.
5. **Page 06 itself needs a refresh when the pack is finalised:**
   1. **Dates:** the "Desk, Thu 22 Oct" header and "9 Nov".
   2. **Install time:** "about 5 minutes".
   3. **Old install files:** Q6's "July copies other colleagues use" is contradicted by item 64.
   4. **Desk reading 2:** it cites "ruling F2" for updates; no such ruling exists (see 02-13).
