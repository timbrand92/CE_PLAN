# Carpark re-check of the look briefs (read-only, Sonnet, Mon 2 Nov 2026)

Checked against the restored `C:\CE_PLAN\BUG_CARPARK.md` (17,976 lines, commit f9d3d4fc). Nothing was changed except this file. No brief was rewritten.

---

## FOR TIM

1. **Looks checked:** 10 brief files (the job said nine; there are ten `LOOKBRIEF_*_02NOV.md` files), about 75 looks, against 55 carpark entries.
2. **Looks with a problem:** 32 (list below). 3 of them are looks for bugs the carpark already marks FIXED: C78S-03 (BUG-1222), C78S-04 (BUG-856), C78S-06 (BUG-684).
3. **Biggest two:** HUBC-01 and HUBC-02 follow a "warn, do not stop" ruling that the carpark entries (BUG-1158 and BUG-1144) do not record, and the entries say the opposite ("outlets show as not yet approved", "Apply refuses").
4. **The overwrite did little harm here:** the LANE B, Export-box and EX1 briefs say they read the carpark from the old full copy (commit b498a968), so their claims were still checkable. The other briefs cite carpark lines I could confirm.
5. **Not checked line by line:** the wave-1 look text (it lives in `verifyA3_c88_full.txt`, not in these files), W234-05, LB2-09, LB3-01 to LB3-04, and the K1_02B and B2 steps beyond their bug wording. I found no disagreement in what I did read of those.

---

## PROBLEM LIST (one item per look)

1. **HUBC-01, LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md (BUG-1158):** The entry's "Right looks like" is "the outlets show as not yet approved" after a Save As copy, and its test is "a Save As copy does not inherit approved outlets". The brief expects the opposite: one warning line and the outlets "still shown as approved (not un-approved)". Nothing in the carpark records CE 04's "warn, do not un-approve" ruling. Exact fix: add this sentence to HUBC-01 EXPECTED: "NOTE: BUG-1158 (carpark) says a Save As copy should show the outlets as NOT approved; this look follows CE 04's later ruling 'warn, do not un-approve' (not recorded in BUG-1158). A PASS does not close BUG-1158 as written. Desk: copy CE 04's ruling into the BUG-1158 entry first."

2. **HUBC-02, LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md (BUG-1144):** The entry says "block Apply with a plain line when the record is damaged" and "Right looks like: Apply refuses with a plain line". The brief expects Apply to carry on with one warning and a kept copy. Exact fix: add to HUBC-02 EXPECTED: "NOTE: BUG-1144 (carpark) says Apply should refuse; this look follows CE 04's 31 Oct ruling 'warn, not stop' (R-27), which the entry does not record. A PASS does not close BUG-1144 as written. Desk: add the ruling to the entry."

3. **C78S-03, LOOKBRIEF_C78_PART_SEEN_AND_WAVE1_02NOV.md (BUG-1222, BUG-223, BUG-686):** Two faults. (a) BUG-1222 is already "FIXED (Claude-accepted, Civil 3.0.85, 29 Oct 2026)" and Tim-confirmed 29 Oct, so this look is not needed for BUG-1222 (BUG-223 stays OPEN). (b) The heading cites BUG-686 (a level of exactly 0.00 makes the arrow point uphill) but no step uses 0.00. Exact fix: either delete "BUG-686" from the heading, or add a step: "Pipe C: CD from 150000,-94000 to 170000,-94000, first level 0.00, second level 0.50, Start Pipe. Expected: the arrow follows the levels, so it points towards the LOWER level, the 0.00 end at the first point (west). Write which way it points; east would be the old fault."

4. **C78S-04, same file (BUG-856):** The carpark marks BUG-856 "FIXED (Codex-accepted, Civil 3.0.67, 21 Oct 2026)" (Codex V3b-04 PASS SURE; robot runs 41, 42, 44, 45). Exact fix: add to the look's first line: "ALREADY FIXED (Codex-accepted 3.0.67). This look is a repeat on 3.0.88 and records a regression check only." Wording matches the entry (pipe named, 275 mm, "Nothing was moved").

5. **C78S-06, same file (BUG-684):** The carpark marks BUG-684 "FIXED (Claude-accepted, Civil 3.0.75, 25 Oct 2026)" by runner case R39b. Exact fix: add "ALREADY FIXED (Claude-accepted 3.0.75); the 'picking an existing CE pipe still says already a CE pipe' half is not proved and not covered here. This look adds only the seen half (the warning words)."

6. **C78S-14, same file (BUG-857):** The brief says "the review note says Esc places the pipe at the typed 1 in 100 in this old mode". The entry says the X (corner button) placed the pipe at the typed 1 IN 100 (Codex W4-02, 23 Oct); it says Esc did NOT close the box on 3.0.88 (A78c, 1 Nov). Nothing in the entry says Esc places a pipe. The look also never presses the X, which is the entry's actual symptom. Exact fix: replace the sentence with "BUG-857: closing with the X placed the pipe at the typed 1 IN 100 (W4-02); on 3.0.88 Esc did not close the box (A78c)." and add step: "After Esc, click the window's X once; write whether a pipe was drawn and at what grade." The entry's Expected is Tim's call, so do not write PASS or FAIL for the X.

7. **C78S-10, same file (BUG-859):** Three disagreements. (a) The brief says the shipped defaults of `doubleClick.sourceEditWindow` are NOT FOUND; the entry says it is ON by default (the C-58 default) and absent from Tim's settings. (b) PASS says "showing DP1" but the entry requires "Tag box NOT empty". (c) The entry's failing part was the outer (blue) circle; the look clicks only the red centre and the angled text. Exact fix: (a) write "default ON (BUG-859 entry); read it first"; (b) PASS: "...Edit source window opens with DP1 in a non-empty Tag box"; (c) add a third double-click on the outer (blue) circle. Also note the entry says R09 failed 2 of 3 runs on 3.0.88, so a PASS here is unproven for the fix.

8. **C78S-07, same file (BUG-672):** The brief calls the old wording "no label". The entry's quoted old sentence is "no label or cover text". Exact fix: FAIL line: "the message says 'no label or cover text' (the old wording)".

9. **C78S-08, same file (BUG-855):** The look judges "header count" but never names the line. The entry's line is "Drawing check: 95 data issues may affect this schedule" and the fault is 95 becoming 96 after CDSYNC; the "27 rows" figure is a different number. Exact fix: in S1 and S2 copy the line "Drawing check: <n> data issues may affect this schedule" and compare n; FAIL if n differs even when every row is identical. The "NOT SHOWN" DIFFERENT line must refer to this line, not to the row count.

10. **C78S-12, same file (BUG-1227):** The heading says "BUG-1227 part A"; the entry has no parts. The entry's symptom is "six to nine lines saying P3's pit schedule cells were not updated" for a copy sitting exactly on the original, and none for a copy 5 m away. The look never counts those lines. Exact fix: heading: "(BUG-1227)"; add after step 6: "Count the lines about pit schedule cells not being updated after the ROTATE copy and after the SCALE copy, and after the earlier COPY 5 m away (entry: 6 to 9, and none for 5 m)."

11. **Wave-1 summaries (BUG-786 and BUG-573), same file:** "rows stay with their pit" (BUG-786) omits the entry's "in invert order" and the primary-row-moves-to-bottom case. "trailing zeros give no false changes" (BUG-573) omits the entry's control "a genuine 21.000 to 21.010 change must still appear". Exact fix: W1-786 line: "...a pit's rows stay together, in invert order"; W1-573 line: "...and a genuine 21.000 to 21.010 change still shows". (All nine wave-1 bugs are OPEN in the carpark, not fixed.)

12. **B1-03, LOOKBRIEF_BATCHB_CIVIL_SCREENS_02NOV.md (BUG-816):** BUG-816 is "the automatic no clear spot label line prints even with Tidy labels off". The look checks only that the new Settings row fits. The entry expects the line to stay quiet, or the setting that controls it to be findable. Exact fix: add a step after the Settings visit: "With the Drafting-tab row UNTICKED (session B only) a typed MOVE of pit P3 prints no 'no clear spot among its usual positions' line; with it ticked the line prints." Until then write beside B1-03: "BUG-816 not tested; fit only".

13. **B1-06, same file (BUG-1092):** The entry's own steps are "draw a 1 m pipe, IL 10.000 start and 10.004 end, run CDRULES; right looks like 'flows uphill' in red". The brief says the line comes from CD placement and the Design Warnings window, not CDRULES, so the entry's steps cannot be followed as filed. The brief also omits the entry's second half: a 2 m pipe with a real 4 mm fall (1 in 500) must NOT be called "no measurable fall". Exact fix: desk to correct the BUG-1092 steps (route: CD or Edit Pipe Save), and add attempt 3: "2 m pipe, levels 10.000 then 9.996: expected no 'essentially flat' line."

14. **B1-05, same file (BUG-907):** The brief says "Tim 29 Oct decision 18 yes". The entry says "MEDIUM (needs Tim's word)" and "Needs Tim's word (after 9 Nov)"; no decision is recorded in it. Exact fix: write "BUG-907 entry still says needs Tim's word; decision 18 is recorded outside the carpark. A PASS shows the warning exists, it does not accept the rule."

15. **B1-04, same file (BUG-1094):** The entry is "UNSURE (the intent is not recorded; needs Tim's word on what amber means)". The brief PASS treats the red cross as the right answer. Exact fix: add "BUG-1094 needs Tim's word on the amber band; a PASS records what the Inspector shows and does not accept it. The entry says a 'near the limit' amber band just steeper than the minimum may be wanted."

16. **B3-03, LOOKBRIEF_BATCHB_DRAWING_MANAGER_02NOV.md (BUG-1172):** The entry covers both the Civil line ("CE CVL SUITE v3.0.72 [Modern]", `Modules/Drainage/PluginInitialization.cs`) and the Manager line (`Modules/Manager/Plugin.cs`). The brief reads only the Manager line and pane. Exact fix: B3-03 step 2 adds "also read the Civil start-up or status line and write its lane word", and the NOT TESTABLE line covers both.

17. **B3-01, same file (BUG-1247):** The entry's title says "for an ordinary user" and its Expected includes "how to go back to the previous version". The brief says the old fault shows only on an administrator account and judges nothing on go-back. Exact fix: add to RESULT: "A PASS covers only the first half of BUG-1247. The carpark evidence note says the own screen still has no go-back (rollback) step; BUG-1247 stays OPEN (Tim's verdict 'failed')." Desk: correct the entry title if only administrators ever saw the Dashboard.

18. **B3-02, same file (BUG-1244):** The entry's example line is "Refreshed: 3 modules loaded, no update waiting" (matching the Status tab). The brief expects "ribbon rebuilt; Manager window; reports sent". The brief's line says nothing about modules or waiting updates. Exact fix: add "The entry's example also names modules loaded and any update waiting; write whether the real line does. A PASS here is Tim's call, not a machine pass."

19. **EDTC-01, LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md (BUG-658):** The entry's symptom is a refused save (for example a locked label layer) after which "[CDEDIT-CASCADE] Updated N pipes" had already printed and is false. EDTC-01 cannot reach that case. Exact fix: add to EDTC-01 RESULT: "THIS LOOK CAN NEVER MAKE BUG-658 'Codex-accepted' ON ITS OWN: the refused-save case in the entry is not tested (no route known)." (EDTC-03 already says this for BUG-1892's twin.)

20. **EDTC-05 and EDTC-06, same file (BUG-430):** The entry has two items: the pit-label double-click (covered) and "(2) Override tick still checked after Stop overriding" in the Pit Schedule window (not covered). Exact fix: add to EDTC-06 RESULT: "A PASS covers item (1) of BUG-430 only; item (2) (override tick after Stop overriding) is not tested and BUG-430 stays OPEN."

21. **W234-01, LOOKBRIEF_W234_BLOCKED_CASES_02NOV.md (BUG-234):** The entry's test has two halves: MOVE a flat pipe onto two other pits, and grip-drag one end from P2 onto P3. The look does only the MOVE. Exact fix: add "NOT TESTED: the grip-drag half of BUG-234 (one end gripped from one pit onto the next). A PASS does not close BUG-234."

22. **W234-02, same file (BUG-1239 not cited):** The brief says "NO BUG NUMBER FOUND". BUG-1239 (Tim, D06 hand check, 29 Oct) is "pipe text placed about 450 units off the middle of the pipe, at right angles" found while checking "Show grade in pipe text" switched off. Its steps are to measure the label's distance from the pipe line with Pipe text On plan, Above, Below, grade text off and on. The look only reads the label words. Exact fix: heading: "(card D06, UX-PIPE-05; related BUG-1239)"; add to steps (3) and (4): "also measure the distance from the label's middle to the pipe line (DIST or LIST) and write it; entry: 'On plan' should sit on the line."

23. **W234-03, same file (BUG-859):** The brief cites "PR #1834" and "OLD FAULT before PR #1834". The entry names #1520 (installed 3.0.70, still failing) and #1522 (round 2, not installed as of 23 Oct); #1834 appears nowhere in the carpark. The entry also says R09 failed 2 of 3 runs on 3.0.88. Step 3 double-clicks "the outer circle's red centre", mixing two parts the entry keeps apart (outer blue circle and red centre). Exact fix: "BUG-859 (fix PRs in the carpark: #1520 installed, #1522 not installed; the brief's #1834 is not recorded there)"; split step 3 into outer (blue) circle first, then red centre.

24. **W234-04, same file (BUG-1238, BUG-1226):** The entry's steps place TWO pipes with different sizes and materials; the brief places one. BUG-1226 (robot N30, 3.0.84 and 3.0.85) found the New Pipe window is one page with no tabs and no Recent buttons; the brief expects a "Levels & Flow" page and a "Pipe" tab. "PR #1839" is not in the carpark. Exact fix: heading "(BUG-1238; related BUG-1226)"; add "Write first whether the window is one page (BUG-1226) or tabbed"; place a second pipe with a different size and material before pipe B so more than one recent value exists.

25. **LB1-01, LOOKBRIEF_LANEB_PART1_02NOV.md (BUG-011, BUG-128):** The brief gives "east end" only to look E11 and tells the look not to fail the leader side. The carpark records the east-end landing as Tim's ruling 1 in BUG-128 ("FIXED IN SOURCE, awaiting Tim's retest"), while BUG-011 says the leader meets the left edge. Exact fix: "Tim's ruling 1 (BUG-128): the landing meets the block at its EAST end. BUG-011 text says LEFT edge. Write where it meets; DIFFERENT (not PASS) if it is not the east end; desk to reconcile the two entries."

26. **LB1-04, same file (BUG-226):** The entry's confirm step is "hover on a fresh drawing: it says the drawing is not set and lists Civil, Structural, Clear", and its test hovers on an Unknown, a Civil and a Structural drawing. The brief's expected tooltip is static text that never states the drawing's state, and the look hovers only a Civil drawing and an Unknown (after Clear) one. Exact fix: add "If the tooltip does not say the drawing is not set while Unknown, write DIFFERENT FROM ENTRY with the words (the entry asks for the real state)", and note the Structural case is not hovered.

27. **LB2-01 and LB2-06, LOOKBRIEF_LANEB_PART2_02NOV.md (BUG-233):** The entry's test and steps are "every source reads as a document name and page" (no path separator, .md, github, "](#" in any source line). The brief checks only the orifice discharge-coefficient line. Exact fix: add "scroll every source line in the preview (and the PDF) and write any that holds a slash, .md, github or a link code".

28. **LB2-04, same file (BUG-524):** EXPECTED says the Profiles window "(CDPROFILE)" not "(CDCALC)" is "the carpark's right result". The BUG-524 entry has no Profiles item (2.5 and 2.6 list other titles). Exact fix: "EXPECTED (carpark 2.5/2.6): 'Calculations (CDCALC)', 'Check consultant drawing (CDCHECKDWG)', 'Markup review (CEMARKUP)'. The Profiles (CDPROFILE) title comes from commit 3962334d, not the carpark."

29. **LB2-05, same file (BUG-571):** The entry also expects "Unknown stays unavailable rather than zero", "keep the exact 31-row export" and a test with a missing invert and a real zero. The brief covers headings, numbers and owners only. Exact fix: add "(d) a pit with a missing invert shows blank or Unknown, never 0 (write any 0 found); the export row count equals the window's 'rows listed' figure".

30. **LB2-08, same file (BUG-264):** The entry's expected result is "bounded, scrollable task lists with one visible entry per action". The brief FAILs a list that is not fully on screen. Exact fix: PASS also if a list is bounded and a working scroll arrow shows (write the arrow); FAIL only when a list runs off the screen and cannot be scrolled.

31. **EX1-02, LOOKBRIEF_EXPORT_SAVE_BOX_02NOV.md (BUG-877):** The entry's Expected is "a source change starts a fresh read; acceptance is bound to the file reviewed" and its symptom is pressing "Read source". The brief's PASS is a stop with nothing drawn. Step 6 also presses "the main button, its caption as written in step 5", which may read "Import to drawing", a button rule (EX-e) forbids. Exact fix: add "BUG-877 expects a fresh read; the fix as built refuses instead. A PASS records the refusal only"; step 6: "if the caption reads 'Import to drawing', do not press it: BLOCKED".

32. **EX1-03, same file (BUG-1255 Structural half):** The carpark entry for BUG-1255 is about Pit Schedule Export Excel only. It says Structural's Excel exports "very likely fail the same way but this has NOT been seen... before it gets its own entry (not filed)". The brief calls this "BUG-1255 Structural half" as if filed. Exact fix: heading: "STRUCEXPORTCSV (BUG-1255 related; the carpark says the Structural half is unfiled and unseen)". Desk: file an entry if EX1-03 shows the fault.

---

## LOOKS CHECKED WITH NO PROBLEM FOUND

K1b (BUG-1268, matches the entry and the 1 Nov approval), B2-01 (BUG-1195), B2-02 (BUG-505, the "not claimed" lines are right), EDTC-02, EDTC-03, EDTC-04 (BUG-1141, matches), LB1-02, LB1-03 (BUG-227, BUG-228), LB1-06 (BUG-050), LB2-02 (BUG-239), LB2-03 (BUG-518), LB2-07 (BUG-263), LB3-02, LB3-05, LB3-06, LB3-07 (BUG-576, 678, 858, 748), LB3-04 (BUG-850), EX1-01 (BUG-1198, apart from the disclosed "Save changes?" gap).

## STATUS CHECK

Bugs the carpark marks FIXED (Claude- or Codex-accepted): BUG-1222, BUG-856, BUG-684 only. BUG-128 is "FIXED IN SOURCE, awaiting retest". Every other bug in these briefs is OPEN. No cited bug is CLOSED.
