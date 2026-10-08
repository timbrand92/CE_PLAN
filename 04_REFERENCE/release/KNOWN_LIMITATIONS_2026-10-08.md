# Known limitations, Friday 9 October 2026, updated 07:30 (installed now: Civil 3.0.40, Manager 1.1.40, Structural 1.0.110)

**Answer first.** Tim has accepted nothing. Codex watched part of this work in real AutoCAD on test copies, up to its W45 run on Fri 9 Oct (Civil 3.0.40, Manager 1.1.40, Structural 1.0.110). Never a real job yet. **SEEN** = Codex watched it on the version and run shown. **NOT SEEN** = built only.
**A ruling is not a fix.** Section 4 says what Tim ruled and whether it is built. Companion pages: `DAY1_FOR_TIM_2026-10-09.md` (your 24 steps) and `STAFF_HELP_2026-10-08.md`.

---

## 1. Gaps you WILL meet (stated once, here; none is a stop rule)

1. **Column label (BUG-438): FIXED and SEEN on Structural 1.0.110 (W43, 9 Oct 06:05 to 06:09).** C1 with a pick, C1 with Enter and TS1 now place the label. A bare Enter at the number question exits and leaves the column without a label. A cancelled or finished C1 leaves your current layer as it was (SEEN 1.0.107).
2. **Enter at the support-text spot (BUG-437): works on 1.0.110.** It printed "Invalid point." on 1.0.106 (W26). On 1.0.110 click a point or press Enter; with Enter you then type the number and click where the label goes, and answer "Top or Bottom" with Enter. SEEN 1.0.110 (W43).
3. **Start-up lines (BUG-435, BUG-437): STILL THERE on 3.0.40 (seen W45, 9 Oct).** "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL", "Menu item failed to load: CE_SUITE_MANAGER_MENU:CE Manager" and "; error: syntax error". Harmless; the CE tabs and menus are there. The menu lines can be cleared by hand (steps on the Day 1 page, your call, backup first). The source of "; error: syntax error" is NOT found; nothing has been changed.
4. **Manager Roll Back Release does nothing (BUG-425, BUG-441).** Do not press it. Go back a version by hand with the rollback guide.
5. **Flat pipe: the Edit Pipe window STILL shows the "1 in 100" grade selector beside two equal inverts (BUG-442).** The plan label reads FLAT (SEEN 3.0.37, W32; window seen again on 3.0.40, W45). 3.0.40 adds a read-only preview line "Grade: FLAT (same inverts)": built, NOT SEEN (Codex found only the grade selector).
6. **CESUPPORT zip: FIXED and SEEN on 3.0.40 (W45, 9 Oct).** It holds 10 files plus its index; the 8 items left out are listed with reasons; no real login or computer name is inside. It holds the CE logs of the last 14 days. (On 3.0.37 it held only the index, 856 bytes.)
7. **Typed Pit Schedule levels only wait.** The plan changes at Stop overriding, not at Enter. One U takes back the visit. REDO works only straight after U: any typed command in between ends it (REGEN seen; AutoCAD's rule, BUG-445). REGEN, LIST, TEXTSCR, GRAPHSCR and a wheel zoom each leave their own undo step, so check the U line. SEEN 3.0.38 (W35, W36).
8. **Double-clicking a pit's plan label opens AutoCAD's attribute editor, not Edit Pit (BUG-430).** Use PITEDIT. The override tick also stays ticked on the pit-number cell. SEEN 3.0.35 (W20).
9. **The import can make a zero-length pipe (BUG-440).** CDIMPORTXCIVIL made a pipe from P8 to P8 whose two ends are the same point. SEEN 3.0.36 (W29). The import's single U and REDO passed.
10. **Structural rewrites CS_Settings.json once per install that adds rows (BUG-429).** None of your values change. 1.0.110 added 13 new default rows at its first start (28,361 to 28,872 bytes); the CE log says so. 1.0.108 did it 8 Oct 12:39 (26,901 to 28,361 bytes). The command line does not say it.
11. **File > New opens a test template (BUG-440).** Your profile's default template points to a test copy. Not CE code.
12. **FSF strip footing: Enter at the first question ends the command silently (BUG-454).** At "Select centerline (Line/Polyline/Arc) or press Enter for 2-point line:" Enter ended the command with no "Specify start point:" on 1.0.110 (seen twice). Pick a line or polyline instead.
13. **FPFC pad footing: no label text seen (BUG-454).** The pad is drawn and numbered (PF5) and no size questions are asked, but no label text was visible at the zoom Codex used.
14. **Hidden commands CSLEVELCARRY, CSROOFSETOUT and CSFLOORSETOUT print "switched off in Settings" sentences ending "The Settings page for it is still to be built." (wording, BUG-453).** They are OFF on purpose.
15. **Esc at the support text step keeps the column and prints "Support text command failed: Command cancelled."** This needs Tim's choice. A different Esc result (the half-placed column removed) was reported in the same run set; the two have not been reconciled.

## 2. Switched OFF in these versions

1. **Level 3 engines.** Levels proposals, detention banner, new-level labels and profile schedule preview have no caller.
2. **Structural, roof first.** CSROOFSETOUT (roof area setout) and CSPOINTLOAD (roof point loads) are hidden and OFF. SEEN 1.0.107 (W31): "switched off in Settings ... The Settings page for it is still to be built."
3. **Structural, upper floors.** CSFLOORSETOUT (floor setout) and CSFRAMINGLEGEND (framing legend) are hidden and OFF, new in 1.0.108: NOT SEEN. CSLINTELPROPOSE (lintel proposals) is OFF: SEEN 1.0.107.
4. **Structural, footings last.** CSFDNPROPOSE prints "Propose footings is not switched on in this version." SEEN 1.0.104 (W17).
5. **Issue-preview window** is not in these versions. Its switches are off.
6. **Also off by default:** auto-join of pipe ends and the CE bell. Other new tools (CD cursor glow, notes commands) were not re-confirmed.
7. **Structural 1.0.110: CSLEVELCARRY** (carry a level from the other drawing) is a hidden expert command, OFF by default; typed, it prints a switched-off sentence. NOT SEEN.

## 3. Built but NOT SEEN in AutoCAD

1. **A brace over 2700 mm keeps its drawn length and warns (1.0.105 and later; BB warns too from 1.0.106).** Read in code by the finalizers. NOT SEEN.
2. **Steep pipe wording in CDFIXFLATPIPES (3.0.34).** No test drawing has had a pipe flattened the old way. The 1 in 10 warning is not on the Settings window.
3. **Pit-outlet speed warning 1.5 and 2.0 m/s (3.0.37).** The two figures sit in the settings file, not yet a row on the Settings window. Detention pipe flatter than 1 in 200 and the per-council orifice figure (3.0.38): NOT SEEN.
4. **Kingston commercial: 1 in 10 storm, Tc 7 minutes under 1000 m2 (3.0.37).** NOT SEEN. Saved Kingston CDRULES runs show Stale once.
5. **Skips a locked layer and says so:** CDIMPORTXCIVIL (3.0.36); strip-footing layer tidy-up (1.0.106); sheet sync skipping a drawing a colleague holds open (1.0.106). NOT SEEN.
6. **Unknown footing width now ASKS in FADOPT (1.0.107),** with 300 mm pre-filled (screw pile 150 mm). NOT SEEN.
7. **Old real-named Civil and Manager report files deleted at start-up (3.0.36, 3.0.37).** NOT SEEN.
8. **The CHECK marker's layer and that it does not plot; Edit Pipe Save removing the marker.** Not read. The marker, U and REDO themselves are SEEN 3.0.38.
9. **Same-day re-issue replaces the earlier PDF set (1.0.105).** NOT SEEN.
10. **Never opened:** AutoCAD 2022 to 2024; CESETTINGS (Structural); beams 2, 4, 5 and BDL; STS1 on a real support block; REDO after switching drawing tabs; the Admin Dashboard Machines page; changing a value in Edit Pipe and pressing Save.
11. **uPVC and steel speed-limit wording (3.0.40).** It says "your Settings value" only when someone set one. NOT SEEN.
12. **Damaged administrator list handling, and the real Windows login kept out of the Manager trace file (1.1.40).** NOT SEEN.
13. **Civil no longer patches `acad.cuix` (3.0.40).** NOT SEEN. The start-up menu lines are still there (section 1, item 3).
14. **The framing legend title height comes from Settings (1.0.110).** NOT SEEN.
15. **R1 to the end (1.0.110).** R1 asks for three objects (left, right, top/near side) and draws nothing without the third; finishing it is NOT SEEN. BT1 prompts, U/REDO and Esc: SEEN 1.0.110 (W41).

## 4. Tim has ruled (INT-065 to INT-072): built or not

1. **UPVC speed authority = the CPAA manual (INT-068).** The manual names NO UPVC figure, so 3 m/s stays the one unconfirmed value and Civil Design stays at 6. Not changed.
2. **Flat pipe label reads FLAT: BUILT 3.0.37, SEEN (W32).** Label "100 DIA. UPVC PIPE FLAT"; Edit Pipe Save keeps it.
3. **Label grade on a held-grade pipe (INT-071 item 10).** Built 3.0.38 as a CHECK marker and a command-line line. SEEN (W35, W36). The line says the label grade is STILL 1 IN 100; whether that is what you meant is for you to judge.
4. **Pit numbers.** Renumber only in Edit Pit. The window's refusals SEEN 3.0.35 (W20); BUG-426 (a typed number, then p1) not reached.
5. **Privacy.** CESUPPORT never uploads: BUILT, SEEN 3.0.37 ("It has not been sent anywhere."); zip name coded: SEEN. Drawing paths cut to job numbers: stated by CE. No real login or computer name inside the zip: SEEN 3.0.40 (W45). Old report files deleted: section 3, item 7.
6. **Manager updates.** Roll Back and Approve act on Civil and Manager as one pair (3.0.37): NOT SEEN and Roll Back changes nothing today (gap 4).
7. **Wall pair gap 350 mm kept.** **F2 left as is** ("commonly used by me to save"); F2 runs CLEAN in a CE drawing, so use QSAVE; BUG-411 open.
8. **Five Structural framing cards, roof first:** roof area setout and floor setout (OFF), framing legend (OFF), lintel proposals (OFF), level above and below (O)/(U) (not reported built).

## 5. Still open for Tim

1. **W30 settings tick:** yes or no for the column grip with beam linking ON.
2. **Default template** in your AutoCAD profile points to a test copy (gap 11).
3. **BUG-061 gone?** Codex could not reproduce it on the W26-26 copy (zero-length pipe aside). Closes only when you say.
4. **Tc a, b or c** for big Kingston commercial lots; **the two clearance distances** (footing, service; metres); **lintel tolerance 350 mm.**
5. **Floor-arrow order** (Joists, Bearers, Subfloor is not quite roof-down) and the legend words "DENOTES POST UNDER".
6. **Max's write access** to the Engineering library, folder CE Plugin Pilot Results. Not known to work.
7. **UPVC speed authority:** the CPAA manual gives no figure (item 4.1). **Label-grade ruling:** item 4.3.
8. **The seven design cards** are with you; not approved. **Tim runs Day 1 himself first.** That has not happened.
9. **Esc at the support text step (section 1, item 15):** which result do you want, the column kept or removed?
10. **Start-up menu lines:** whether you want to clear them by hand (Day 1 page) or leave them. The desk can try the steps on a COPY of your profile first with Codex.
