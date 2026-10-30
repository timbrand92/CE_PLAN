# Colleague pack: known issues and workarounds, this week's faults (DRAFT)

**DRAFT, Fri 30 Oct 2026 (Melbourne), written by a read-only drafting job.** Not published, not copied into `areas\colleague-pack\`, not shown to Max. Tim approves before any of it goes on page 04. For the pilot with Max on Mon 16 Nov 2026.

---

## FOR TIM (read this, then stop)

1. **Answer:** 26 known issues below, written for a drafter, most likely first. Each says what you see, what happens to your drawing, what to do instead, and which build fixes it. This page covers the faults found from 25 to 30 Oct. The older items stay in the 25 Oct page 04 draft and the 97-change approval list. My recommendation: add this as a new section of page 04 when you approve the pack.
2. **One piece of advice from the brief is not safe, so I changed it.** The brief said "use a small offset" for the ROTATE or SCALE Copy fault (BUG-1227). The diagnosis shows a copy only 0.1 mm off the pit still took its pipes. The page says "place the copy well clear of the pit". A copy 5 m away was proven safe.
3. **Only one fault on this list is a real risk to drawing data:** a ROTATE or SCALE Copy landing on a pit (item 17). Its fix is built and unit-tested, but it is NOT in C-77. It goes in C-77b or C-78. A copied downpipe keeping the same tag (item 18) also leaves two downpipes with one tag.
4. **What "fixed in" means here.**
   1. **C-76** is Civil 3.0.86, installed on your PC Thu 29 Oct 17:51.
   2. **C-77** is Civil 3.0.87. Its final check was running at 12:15 today and the install is planned for about 16:00 to 16:30 today. It is not installed as I write.
   3. Nothing on this page is accepted by you or by Codex. "Built" never means "works".
5. **Two things for you to know, not decide today.**
   1. **REDO workaround:** the 29 Oct change list suggests "close the CE Inspector first". The robot test of 27 Oct switched every Inspector piece off and REDO was still lost. So I left that advice out.
   2. **Raingarden label clash:** C-77 (#1845) draws RG1, RG2 on a raingarden. Your 29 Oct ruling (item 77) says a label never carries the number, so RG. The desk should settle this before C-77 is called finished.
6. **What I did not check:** I did not read the installed DLL versions, open AutoCAD, or run anything. Build and install facts come from the C-76 runner report, the C-77 assembly report, the build register and the desk log.

---

# Known issues and what to do instead (draft for colleagues)

**For:** the CE Civil version Tim gives you for the pilot. Tim fills in the exact version number before this goes out. [CHECK: the frozen build number]

**How to read each item:**

1. **You see:** what happens on screen.
2. **Your drawing:** whether anything in the drawing is lost or changed.
3. **Do this:** what to do instead.
4. **Fixed in:** the CE build that fixes it, or "not yet".

---

## A. Things you will meet every day

1. **Placing a downpipe or a pit takes a while.**
   - **You see:** after you click, nothing seems to happen for several seconds. PIT can take a few seconds to open the New Pit window.
   - **Your drawing:** nothing is lost. The downpipe or pit is placed when CE finishes.
   - **Do this:** wait. Do not click again.
   - **Fixed in:** downpipes are faster from C-76 (about 8 seconds in the test runs, down from about 30). PIT: not yet.

2. **New Pipe works out the second level a little flatter than the grade you chose.**
   - **You see:** you type the upstream level and New Pipe fills in the downstream one. On a 9.2 m pipe at 1 in 100 it gave 1 in 102.
   - **Your drawing:** nothing is lost, but the pipe is drawn flatter than you meant if you accept it.
   - **Do this:** type both levels yourself. Read the grade before you press Start Pipe.
   - **Fixed in:** C-77 (the worked-out level is never flatter than the grade you chose). Built, not yet seen working.

3. **New Pipe changes "Pipe grade" to "Set my own" without telling you.**
   - **You see:** you chose Standard and typed the upstream level. The Pipe grade choice jumps to "Set my own" with a number you did not type.
   - **Your drawing:** nothing is lost, but the pipe can be drawn at a grade you did not choose.
   - **Do this:** after you type the first level, look at Pipe grade. Set it back if it moved.
   - **Fixed in:** not yet. It is planned with the New Pipe window tidy-up.

4. **New Pipe has no one-click buttons for your recent sizes, materials and levels.**
   - **You see:** empty boxes. You retype the same size and material each time.
   - **Your drawing:** nothing is lost.
   - **Do this:** type the values.
   - **Fixed in:** C-77 adds a "Recent" line to New Pipe and Edit Pipe. Built, not yet seen.

5. **REDO stops working after your first click.**
   - **You see:** you press U, then click anything in the drawing, and REDO does nothing or says there is nothing to redo.
   - **Your drawing:** U still works. Only the REDO is lost.
   - **Do this:** after U, type REDO straight away, before you click anything. If REDO is lost, do the step again by hand.
   - **Fixed in:** not yet. The cause is not found yet.

6. **CDCHECK straight after reopening a drawing shows many false "Unresolved" joins.**
   - **You see:** you reopen a drawing and CDCHECK is the first CE command. It reports far too many Unresolved joins (44 instead of 4 on the test drawing). Pipes show as unnamed and pits as long codes.
   - **Your drawing:** not harmed. CDCHECK writes nothing. Only its answer is wrong.
   - **Do this:** after you open a drawing, run any CE drawing command first (for example PITEDIT on a pit, then Cancel). Then run CDCHECK.
   - **Fixed in:** C-77, if it passes the final check today. Built and partly tested, not yet seen working.

7. **The CE Inspector says a pit's values are "Unknown" after you reopen a drawing or use Save As.**
   - **You see:** the Inspector says "This pit is not in CE's recorded project data yet. Values below are Unknown", while the Pit Schedule lists the same pit correctly.
   - **Your drawing:** the values are still there. The Pit Schedule shows them, and the Inspector shows them once CE has read the drawing's record.
   - **Do this:** after you reopen a drawing or Save As, type CDSYNC (or open PITSCHEDULE) before you use the Inspector or CDCHECKDWG.
   - **Fixed in:** not yet.

8. **The pipe description sits well away from the pipe.**
   - **You see:** the pipe text lands about 450 mm to the side of the pipe's middle. In Edit Pipe, "On plan" and "Above" can both look selected.
   - **Your drawing:** only the label position is affected.
   - **Do this:** move the label by hand where it matters on the sheet.
   - **Fixed in:** not yet.

9. **Where two pipes leave one pit close together, level text can sit on the pit and the flow arrow can run through the pipe label.**
   - **You see:** the IL text on top of the pit symbol, or the arrow through the word PIPE. Seen with two pipes about 300 mm apart.
   - **Your drawing:** only text positions are affected.
   - **Do this:** zoom in at each pit before you issue and move the text by hand.
   - **Fixed in:** not yet.

10. **The silting warning says "Grade 1:200 is shallower than minimum 1:200".**
    - **You see:** both numbers are the same.
    - **Your drawing:** the pipe is placed. The pipe is a hair flatter than 1 in 200 and CE rounds both figures to 200. A pipe at exactly 1 in 200 gets no warning.
    - **Do this:** read it as "just under the minimum". Steepen the pipe slightly if that matters on the job.
    - **Fixed in:** not yet. Wording only.

11. **After EXPLODE, ERASE or COPY of a pit, a run of lines about another pit appears.**
    - **You see:** several lines like "Pit schedule cell for C1 (outlet pipe size) not updated". They name a different pit from the one you changed. The useful line about your pit comes last.
    - **Your drawing:** the change to your pit worked. Some cells on the drawn Pit Schedule were left as drawn.
    - **Do this:** read the last line for your pit. Then run PITSCHEDULE and use "Update existing schedule".
    - **Fixed in:** not yet. A one-line-per-pit version is planned.

12. **Double-click on a downpipe opens CE's Edit source window, but leaves a stray line.**
    - **You see:** the window opens correctly, then one extra command-line line: Unknown command followed by the click point numbers.
    - **Your drawing:** nothing changes.
    - **Do this:** ignore the line.
    - **Fixed in:** the double-click itself is fixed in C-76 (seen working in test runs, not yet by a person). The stray line: not yet.

13. **Double-click on a pit's number opens AutoCAD's attribute editor, not Edit Pit.**
    - **You see:** AutoCAD's Enhanced Attribute Editor with the pit number in it.
    - **Your drawing:** Cancel leaves the drawing unchanged. Do not change the number there.
    - **Do this:** select the pit and type PITEDIT. Renumber pits only in Edit Pit.
    - **Fixed in:** not yet. It will be switched on only after it is seen working.

14. **Double-click on the green downpipe label opens plain text editing.**
    - **Your drawing:** typing there changes only the label text, not the downpipe.
    - **Do this:** select the downpipe symbol and type CDEDIT.
    - **Fixed in:** C-77. Built, not yet seen.

---

## B. Things you will meet sometimes

15. **A front overflow (FO) symbol reads "OF".**
    - **You see:** the FO block's symbol text says OF. The command line says "Front overflow placed. Tag: FO1" and the green plan label says FO.
    - **Your drawing:** the tag is right (FO1). Only the symbol text is wrong.
    - **Do this:** go by the green label and the Inspector. Check the symbol text on the issued sheet.
    - **Fixed in:** not yet. Tim has ruled that FO places with FO as its label.

16. **A pipe label you moved by hand shifts when you move its pit.**
    - **You see:** you moved a pipe description, then moved the pit 500 mm sideways. The label shifted 250 mm. Tidy labels then counts no hand-placed labels.
    - **Your drawing:** only the label position is affected.
    - **Do this:** move pits first, then place labels by hand. After a pit move, check the labels you placed.
    - **Fixed in:** not yet. Waiting on a design decision by Tim.

17. **A ROTATE Copy or SCALE Copy that lands on top of a pit takes that pit's pipes.**
    - **You see:** a run of "Pit schedule cell for P3 ... not updated" lines. In the test run, the original pit was left with 1 of its 5 pipes. The copy had the rest.
    - **Your drawing:** this one DOES change your drawing. The original pit's pipes are joined to the copy.
    - **Do this:** never put the copy on the original pit. Place it well clear (a copy 5 m away was safe). A tiny offset is NOT enough: a copy 0.1 mm off still took the pipes. If it happens, press U at once and check the original pit's pipes in the Inspector. If in doubt, close the drawing without saving. [CHECK: that one U puts the pipes back has not been proven]
    - **Fixed in:** not yet in your build. The fix is built and unit-tested and goes into the update after C-77 (C-77b or C-78).

18. **A downpipe copied with Copy + Rotate (CR) keeps the original's tag.**
    - **You see:** CE says the copied downpipe "could not be given its own link" and was left as AutoCAD copied it. The copy shows the same tag as the original (for example two DP2s).
    - **Your drawing:** two downpipes carry one tag, so they cannot be told apart.
    - **Do this:** use DP to place each new downpipe. Do not copy downpipes with CR.
    - **Fixed in:** not yet. Tim has ruled that every copied CE item gets its own next number.

19. **Move + Rotate (MR) and Copy + Rotate (CR) refuse a raingarden with a code word.**
    - **You see:** "CE transform stopped (eNotApplicable). Drawing changes rolled back ...". It does not say which object stopped it.
    - **Your drawing:** nothing was changed.
    - **Do this:** leave the raingarden out of the selection. Move and rotate it with AutoCAD's own MOVE and ROTATE.
    - **Fixed in:** not yet.

20. **CDRENUMBER stops with "No pit discharges outside the network".**
    - **You see:** that one line, and nothing else.
    - **Your drawing:** nothing is renumbered.
    - **Do this:** draw the pipe that leaves your last pit to open ground or an outfall, then run CDRENUMBER again.
    - **Fixed in:** not yet. Wording only.

21. **The Inspector's "On plan" tab gives the wrong pit label position.**
    - **You see:** "Label position: bottom right" when the pit number is drawn above the pit.
    - **Your drawing:** the drawing is right. The Inspector's header already says recorded values may differ.
    - **Do this:** go by the drawing.
    - **Fixed in:** not yet.

22. **Two copies of a Pit Schedule in one drawing: updating one can change the other's depth heading.**
    - **You see:** an older copy (even on a locked layer) gets the heading "PIT DEPTH (m)" but keeps its old depth-to-outlet figures.
    - **Your drawing:** the old copy's figures now sit under the wrong heading.
    - **Do this:** keep one Pit Schedule per drawing. Delete or check any old copy before issue.
    - **Fixed in:** not yet.

23. **A floor waste cannot be placed on an inspection opening.**
    - **You see:** CE refuses with a sentence naming the inspection opening already at that point.
    - **Your drawing:** nothing is placed.
    - **Do this:** place the floor waste beside the inspection opening. This refusal is intended.
    - **Fixed in:** intended behaviour (Tim's ruling, 29 Oct). [CHECK: the exact sentence on the frozen build]

---

## C. CE Manager and survey

24. **"Updates & Rollback" opens the company-wide Administrator Dashboard.**
    - **You see:** a window titled Admin Dashboard with buttons Approve Available Build, Canary Rollout and Promote to All. The figures can stay blank for a while as it loads.
    - **Your drawing:** not affected.
    - **Do this:** close it. Never press any button in it. Tim does your updates by hand.
    - **Fixed in:** not yet. Tim has ruled that this button opens your own update screen. Planned for C-79.

25. **CE Tools > Refresh prints only its own name.**
    - **You see:** "Command: CEMANAGERREFRESH" and nothing else.
    - **Your drawing:** not affected. What it refreshes is not recorded yet.
    - **Do this:** you do not need it. If CE looks wrong, close and restart AutoCAD and tell Tim.
    - **Fixed in:** not yet.

26. **The CDSURVEY review is written in survey-software words.**
    - **You see:** lines such as "sha256", "TIN triangles", "units code 4" and "modified z-score".
    - **Your drawing:** levels marked as outliers are kept as Unknown and never used for a level suggestion.
    - **Do this:** read the listed spot levels and their positions. Check them against the survey before you approve. Ignore the rest.
    - **Fixed in:** not yet.

---

## After an update (note, not a fault)

1. **After C-77, every CDRULES result you saved before shows "Stale" once.** The minimum-fall rules changed. Run CDRULES again once on each drawing.

---

## [DESK ONLY: remove before publishing] Where each item comes from

Read on Fri 30 Oct 2026. Bug file: `C:\CE_PLAN\BUG_CARPARK.md`. Every bug below is OPEN there; none is FIXED.

1. **Item 1:** BUG-1228 (Tim 29 Oct H1, "pit command takes a while"); fix B-004 #1837 in C-76; `areas\release-v3-colleagues-RUNNER_C76_PROOFS_REPORT.md` FOR TIM item 5 (8.1 s, 11.3 s cold, 28.9 s with the fix off); PIT is B-031, after the pilot.
2. **Item 2:** BUG-1229; fix B-005 #1838 merged into C-77 (`release-v3-colleagues-TRAIN_C77_ASSEMBLY_REPORT_2026-10-29.md` merge 6).
3. **Item 3:** BUG-1233; B-041 / B-043c, not started; the register says both C-79 and "after the pilot" (line 67 and line 129 disagree).
4. **Item 4:** BUG-1226 and BUG-1238; #1839 (B-006) and #1861 (B-043a, the Recent line, switch `pipe.declutteredLayout` ON) both merged into C-77. Window: needs a Codex look.
5. **Item 5:** BUG-861; 27 Oct bisect (all 14 diag switches ON still lost, 6 of 6; also on a plain AutoCAD line); 28 Oct gap watch (AutoCAD or another add-in suspected). Controlled run waits on QUESTIONS_FOR_MONDAY item 14.
6. **Item 6:** BUG-1251 ("CDCHECK writes nothing, so the drawing data is not harmed"); #1866 B-055 PROMOTED LATE into C-77, the finalizer merges it only if clean (`TRAIN_C77_PR_LIST_2026-10-29.md` item 3a); desk log 30 Oct 12:15 for the install time.
7. **Item 7:** BUG-1240 (H22, H53: "i always have to cdsync when i reopen drawing"); related BUG-1241. No fix job found.
8. **Item 8:** BUG-1239; decisions 2026-10-29 item 78 (default `pipeTextOffsetMm` 200, measured about 450).
9. **Item 9:** BUG-1234 (H9, H9b screenshots).
10. **Item 10:** BUG-1235 and its H9b update (exactly 10.000 m pipes gave no warning).
11. **Item 11:** BUG-1231 (H4, H5, H6: "the EXPLODE itself worked"); B-049b Part B planned, no PR found.
12. **Item 12:** BUG-859 fix #1834 in C-76 (R09s 2 clean PASS, RUNNER_C76_PROOFS_REPORT item 2; not Claude-accepted, ledger review "READY (part)"); stray line BUG-1250.
13. **Item 13:** BUG-430 (Codex L4-01a 18 and 19 Oct, "Cancel left the drawing unchanged"); decisions 2026-10-29 item 94.
14. **Item 14:** BUG-860, #1862 B-014 merged into C-77.
15. **Item 15:** BUG-1236 (H12); decisions 2026-10-29 item 76. BUG-1242 left out: Tim ruled the plan label never carries the number (item 77), so letters only is intended.
16. **Item 16:** BUG-1252 (Codex G7, 30 Oct 06:27, FAIL); ON HOLD for QUESTIONS_FOR_MONDAY item 19.
17. **Item 17:** BUG-1227; `release-v3-colleagues-BUG1227_DIAGNOSIS_29OCT.md` (P3 kept 1 of 5; copy 0.1 mm off; 5 m away fine); `release-v3-colleagues-BUG1227_FIX_REPORT.md` (#1867 built, 14 unit tests pass, nothing in AutoCAD); NOT in C-77 (desk log 12:15: "C-77b candidates").
18. **Item 18:** BUG-1246 (H39, H40, H44, H56 "for 5th time the original was dp2"); decisions 2026-10-29 item 80.
19. **Item 19:** BUG-1245 (H38, H39: the refused selection included the raingarden); decisions item 79.
20. **Item 20:** BUG-1237 (H13).
21. **Item 21:** BUG-1249 (H53, H55).
22. **Item 22:** BUG-1197 (Codex audit RD17-02, shared-definition fixture; not seen on a real job).
23. **Item 23:** BUG-1223 (OPEN in the carpark); decisions 2026-10-29 item 4 (refusal stays); `RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md` 4C N10 for the sentence. I did not see the sentence myself.
24. **Item 24:** BUG-1247 (H44, H45, H47 "failed"); decisions item 98; B-047 target C-79 (`RELEASE_SCOREBOARD.md` gate item 2).
25. **Item 25:** BUG-1244 (H38).
26. **Item 26:** BUG-1248 (H49).
27. **After an update note:** desk log 29 Oct 13:45 and C-77 assembly report RULE 14 item 4.4 (#1841, every saved CDRULES run Stale once).
28. **Left out on purpose:** BUG-1230 (preview, on hold, Tim reviewing the whole window); BUG-1232 (suspected only, not seen by hand); BUG-1225 (Tim confirmed fixed 29 Oct on 3.0.85); BUG-1243 (CE Blocks, parked, no description); BUG-1242 (now intended, see 15).
