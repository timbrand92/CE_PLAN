# R-008 Two wrong-figure bugs checked against the installed plug-in (BUG-866, BUG-1095)

Read-only check, Wed 18 Nov 2026 (D-207). Nothing was built, run, installed or opened in AutoCAD. Code was read straight out of git at the installed Civil commit. Jobs are named by code only: GE-A and GE-B are the two issued Glen Eira sheets the 22 Oct engineering audit opened (I did not open them); CIV-nn are the reference job codes.

## The short answer for Tim

1. **BUG-866 (rainfall note): REAL, and the fix is NOT installed.** CDDESIGN sizes storage on the office Melbourne rainfall curve unless the job has its own, and tells the drafter that curve "reads about 7 to 9 per cent high". It is high on Kingston jobs but LOW on Glen Eira jobs.
2. **How big, which way:** on a made-up 600 m2 two-unit Glen Eira site the plug-in's storage is 10 to 17 per cent SHORT (0.19 to 0.44 m3). That is the unsafe side. On a Kingston site it is about 16 per cent over (safe).
3. **Who, and what to do today:** every CDDESIGN detention job that has no rainfall of its own loaded, which is the normal case. Load the site's own rainfall first, or work the storage in the CDCALC Boyd's tab with the site's Bureau figures typed in. Never issue a storage figure that sits next to the sentence "This job has no rainfall curve of its own".
4. **BUG-1095 (council minimum C): REAL in older builds, FIXED IN THE INSTALLED BUILD (switch on), not yet proven in AutoCAD.** The floor has been applied since Civil 3.0.87 (30 Oct 2026). The installed 3.0.90.15 has it in CDDESIGN, pump sizing and the CDCALC Boyd's tab.
5. **How big, which way:** before 3.0.87, a 600 m2 Darebin lot (400 hard, 200 garden) got C 0.70 instead of 0.80 and storage of 2.84 m3 instead of 3.75 m3. That is 0.91 m3 (24 per cent) SHORT, the unsafe side.
6. **Who, and what to do today:** Darebin, Maribyrnong and Boroondara jobs sized in the plug-in before 30 Oct 2026 should be re-run on today's build. On every new job of those three councils, check that the computations say "council minimum C governs" with the right C.

## BUG-866: the office rainfall curve note

### A. What is claimed

1. **The tool:** CDDESIGN (detention design), and the computations sheet and pump sizing that follow it.
2. **The figure:** the detention storage (volume required), and the sentence printed beside it. If a job has no rainfall curve loaded with CDRAINFALL, the plug-in uses the office "Melbourne (office OSD4W zone)" curve. It then says: "against a real issued CE sheet it reads about 7 to 9 per cent high, which would size the storage about 7 to 9 per cent larger than the job CE issued."
3. **The complaint (22 Oct audit, finding 3):** on the two issued Glen Eira sheets the curve reads 6 to 8 per cent LOW, not high. Storage moves about 2.5 times as much as the rainfall, so for GE-A the plug-in gives 2.12 m3 where the sheet issued 2.58 m3 (about 18 per cent short), while the sentence says the drafter is on the safe side.
4. **Correcting the sorter's summary:** the ISSUED sheets are right; they used the site's own rainfall. The fault is that the plug-in, run on those jobs, would come out about 18 per cent short and say it was safe.

### B. Is it real in the installed code?

1. **Installed commit confirmed:** 2c8b7b1a exists ("Version: Civil 3.0.90.15", 16 Nov 2026).
2. **The sentence:** `Modules/Drainage/Rules/RainfallCurve.cs` lines 241 to 247 (method `CurveInUse`, lines 230 to 248). If the job has no curve, it returns the office Melbourne curve with the text "reads about 7 to 9 per cent high, which would size the storage about 7 to 9 per cent larger than the job CE issued."
3. **The storage uses that curve:** `Services/DetentionSizingService.cs` line 129 picks the curve (`CurveInUse(inputs.RainfallCurve)`) and line 133 takes every storm's intensity from it. Lines 136 to 140 do the Boyd's sum (inflow less permitted outflow, times the storm length). Lines 320 to 324 take the worked-out permitted discharge off the SAME curve.
4. **The sentence reaches the drafter:** `Services/AutoDesignService.cs` lines 195 to 196 add it to the CDDESIGN notes; `Rules/ComputationsSheetV3.cs` line 141 prints it on the computations sheet; `Services/PumpSizingService.cs` line 230 adds it to pump sizing.
5. **I checked the curve figures by hand from the coefficients in the code:** 1 in 10 year at 5, 10 and 15 minutes = 105.0, 78.7 and 64.6 mm/h. These match the audit exactly.
6. **Where the "high" claim came from:** the reference's Kingston job CIV-03 (SUMS S-003) has 98.6, 73.6, 60.1, 51.5, 45.5 and 40.9 mm/h for 5 to 30 minutes. The office curve is 6.5 to 8.6 per cent above those, which is exactly the "6.5 to 8.6 per cent high" in the code comment (lines 28 to 32). So the claim was true for one Kingston sheet and was then written as if true for every site.
7. **Evidence the other way:** Glen Eira jobs in the reference used 1 in 5, 5 minute rainfalls of 94.3 (CIV-12) and 95.3 or 113 (CIV-07). The office curve gives 88.8, which is 6 to 21 per cent LOW. GE-A's 1 in 10 figures (112, 85.0, 69.4) are 6 to 7 per cent above the curve.
8. **Fix status:** a wording-only fix exists: commit d6f6ac2b on branch `claude/b130-bug-866-rainfall-note` (draft PR #1948, 31 Oct 2026). It changes the note to "may be high or low by up to about 8 per cent, and the storage moves about 2.5 times as much" behind switch `detention.rainfallNoteHighOrLow`. It is NOT in the installed commit (`git merge-base --is-ancestor` says no), it is on no release branch, and the installed code still holds the old sentence. Even that fix changes no figure; Tim's ruling of 29 Oct (decision 16) was "leave them until you've checked the curve".
9. **Verdict:** the bug is real in the installed code. The carpark status "OPEN, needs Tim's ruling" is right.

### C. How big and which way: one made-up example by hand

**The site:** two units on 600 m2 in Glen Eira. Roofs and paving 400 m2, garden 200 m2. Every figure is made up except where a source is named.

1. **Runoff C (S-001):** (400 x 0.9 + 200 x 0.30) / 600 = 0.70. I used 0.30 for the garden in both methods so that only the rainfall differs. The reference still records a 0.30 against 0.35 conflict (Q-004).
2. **Permitted discharge, the office way (S-002, Glen Eira reference C-006: C 0.35, 1 in 5, 5 minutes):** I used the site rainfall of 94.3 mm/h from CIV-12, a Glen Eira job. 0.35 x 94.3 x 600 / 3600 = 5.50 L/s.
3. **Storage, the office way (S-003, 1 in 10, site rainfall from GE-A):**
   1. **5 minutes:** inflow 0.70 x 112 x 600 / 3600 = 13.07 L/s; (13.07 - 5.50) x 300 s = 2,270 L.
   2. **10 minutes:** inflow 0.70 x 85.0 x 600 / 3600 = 9.92 L/s; (9.92 - 5.50) x 600 s = 2,649 L.
   3. **15 minutes:** inflow 8.10 L/s; (8.10 - 5.50) x 900 s = 2,336 L.
   4. **Volume required:** 2.65 m3, at 10 minutes. The 20 to 30 minute figures for GE-A are not in what I read, but storage is already falling by 15 minutes, so they do not govern.
4. **Installed code, case 1: the council gives the discharge (5.50 L/s typed), office curve:**
   1. **5 minutes:** 0.70 x 105.0 x 600 / 3600 = 12.25 L/s; (12.25 - 5.50) x 300 = 2,025 L.
   2. **10 minutes:** 0.70 x 78.7 x 600 / 3600 = 9.18 L/s; (9.18 - 5.50) x 600 = 2,207 L.
   3. **15 minutes:** 7.54 L/s; (7.54 - 5.50) x 900 = 1,836 L.
   4. **Volume required:** 2.21 m3. That is 0.44 m3 (440 litres, 16.7 per cent) SHORT.
5. **Installed code, case 2: CDDESIGN works the discharge out itself.** The installed Glen Eira profile uses a 1 in 10 discharge storm, 5 minutes and C 0.35. This differs from reference C-006 (1 in 5), which itself records a conflict with a council discharge report that speaks of the 10 year storm.
   1. **Office curve:** permitted 0.35 x 105.0 x 600 / 3600 = 6.13 L/s. Storage at 5 minutes (12.25 - 6.13) x 300 = 1,837 L, at 10 minutes (9.18 - 6.13) x 600 = 1,834 L, so 1.84 m3.
   2. **The same storms on GE-A's site rainfall:** permitted 0.35 x 112 x 600 / 3600 = 6.53 L/s; storage at 10 minutes (9.92 - 6.53) x 600 = 2,030 L, so 2.03 m3.
   3. **Difference:** 0.19 m3 (190 litres, 9.5 per cent) SHORT. It is smaller because the low curve also lowers the permitted discharge, which partly cancels out.
6. **The other way round (Kingston, CIV-03 rainfall, council-given 5.00 L/s as on CIV-02):** the office way gives 2.15 m3 and the office curve gives 2.51 m3, so the plug-in is 16.5 per cent OVER. That is conservative. It is still not the "7 to 9 per cent" the note claims.
7. **Verdict on safety:** where the site's real rainfall is above the office curve (the Glen Eira evidence), the storage is too small and the note says the opposite: UNSAFE. Where the site's rainfall is below the curve (the Kingston evidence), the storage is too big: conservative. The note is wrong in both cases: the real error is about 2 to 2.5 times the rainfall gap, not equal to it.

### D. When it bites, and how a drafter would know

1. **Every CDDESIGN detention job with no rainfall loaded through CDRAINFALL:** that is the normal case, because the office works from the Bureau table for the site (S-002, S-003) and the plug-in only takes a 7 x 7 coefficient block. It is not limited to one council.
2. **Which way depends on where the site is:** the evidence shows the curve low for Glen Eira and high for Kingston. For every other council the direction is UNKNOWN until the curve is checked against that site's Bureau figures.
3. **Worst when the council gives the permitted discharge** (common: CIV-02, 03, 06, 09, 10), because then nothing cancels: about 17 per cent short in the example.
4. **Pump sizing** uses the same curve for its 2 hour storm, so the same doubt applies there.
5. **Not affected:** the CDCALC Boyd's tab works from rainfall rows the drafter types (it starts with sample rows 113 / 85.3 / 69.7 / 59.4 / 52 / 46.5 that must be replaced with the site's figures; that is a separate hazard, not this bug).
6. **How to tell on screen or on the sheet:** the CDDESIGN notes and the computations sheet carry the sentence "This job has no rainfall curve of its own, so CE is using the office Melbourne (office OSD4W zone) curve ...". The Boyd's rows on the office curve read 105.0, 78.7 and 64.6 mm/h at 5, 10 and 15 minutes for 1 in 10. If you see those numbers, it is the office curve, not the site.

### E. Which sheets could already be affected

1. **The curve itself:** in the plug-in since before the monorepo import (the coefficients are in the 2 Jul 2026 import, commit 416b22d4). Every plug-in storage figure on a job without its own curve has rested on it since then.
2. **The misleading sentence:** added 15 Sep 2026 (commit 514d4148, IFD-01). The first Civil version line after it is 3.0.2 (24 Sep 2026), and it is still in the installed 3.0.90.15.
3. **The jobs at risk:** detention jobs on Glen Eira sites, and any site where the Bureau rainfall is above the office curve, whose storage or pump figures came out of CDDESIGN on a build from that period and were not checked against the site's own rainfall.
4. **Not affected:** the two issued Glen Eira sheets in the bug (GE-A, GE-B) were worked in the office workbook with site rainfall. They are the correct figures the audit compared against.
5. **What I cannot tell:** whether any issued sheet actually used a CDDESIGN storage figure. Nothing I read records it, and I did not open the Projects folder.

### F. What a drafter should do TODAY

1. **Before CDDESIGN, load the site's own rainfall** (CDRAINFALL). Or work the storage in the CDCALC Boyd's tab with the site's Bureau 1 in 10 figures for 5 to 30 minutes typed over the sample rows, and the permitted discharge typed from the council letter or a hand sum.
2. **If the computations show "This job has no rainfall curve of its own", do not issue that storage.** Compare the 10 minute, 1 in 10 figure on the sheet (78.7 mm/h on the office curve) with the Bureau figure for the site. If the Bureau figure is higher, the storage is short by roughly 2 to 2.5 times that percentage. Redo it on the site's rainfall.
3. **Ignore the "7 to 9 per cent high" wording entirely.** It is not a safety margin.

### G. Confidence and limits

1. **That the sentence and the curve are in the installed code and feed the storage:** HIGH (read line by line at 2c8b7b1a).
2. **That the curve is low for Glen Eira and high for Kingston:** MEDIUM. It rests on the reference's Kingston and Glen Eira job figures and on the audit's reading of GE-A and GE-B, which I did not reopen. For any other council the direction is UNKNOWN.
3. **Not verified without AutoCAD:** the exact words a drafter sees in the CDDESIGN window and on a printed computations sheet; whether the Boyd's rows are printed on that sheet; and the plug-in's own result for my example (I worked it by hand with the code's formula and coefficients).

## BUG-1095: council minimum after-development runoff C

### A. What is claimed

1. **The tools:** CDDESIGN, pump sizing and the CDCALC Boyd's tab.
2. **The figure:** the after-development runoff coefficient C, and so every flow and the storage that follow from it.
3. **The rule missed:** Darebin's "greater of actual or 0.80" (reference C-003 and L-017, from the council's letter). The plug-in's council file also holds Maribyrnong 0.75 and Boroondara 0.65 as floors; those two are not in the zero reference, so by the reference they are UNKNOWN (the plug-in file cites the council write-ups in 02_COUNCIL_RULES).
4. **The complaint (24 Oct Team audit T2, finding 1, written on Civil 3.0.72):** the rule was stored but nothing called it, so a Darebin lot with C 0.70 was designed at 0.70, not 0.80, and the tank came out too small.

### B. Is it real in the installed code?

1. **It WAS real.** The fault is confirmed by the audit's reading of 3.0.72 and by the fix commits' own "reproduce" test (746ae844, 26 Oct).
2. **The fix is in the installed commit.** Commits 85bf767d (27 Oct, "apply the stored council minimum runoff C") and b531c85e (29 Oct) were merged as PR #1852 at 4a437b5e. `git merge-base --is-ancestor b531c85e 2c8b7b1a` says yes. The first Civil version line containing it is 3.0.87 (30 Oct 2026).
3. **The rule:** `Rules/CouncilRuleValues.cs` lines 103 to 119, `ApplyMinimumPostDevelopmentC`. If the switch is on and the council's mode is "floor", it takes the larger of the worked-out C and the council figure. It then adds the notes "[CE] council minimum C governs" and "[CE] Runoff C = 0.80 (calculated 0.70)", plus a warning if the council figure is only assumed.
4. **CDDESIGN:** `Services/AutoDesignService.cs` lines 102 to 111 pass the weighted C through that rule and rebuild the catchment at the higher C. The flows (line 120) and the Boyd's storage (lines 181 to 191) both use it. The permitted discharge keeps the before-development C, as it should. This is the only place the storage is sized (`SizeBoyds` has one caller).
5. **Pump sizing:** `Services/PumpSizingService.cs` line 225. **CDCALC Boyd's tab:** `ViewModels/BoydsCalcViewModel.cs` lines 245 to 249.
6. **The switch:** `councilMinimumRunoffCApplied` in Detention settings, default ON (`Models/UserSettings.cs` lines 3305 to 3306). Tim's Civil settings file on this PC does not mention it, so the default (ON) applies.
7. **Council data in the installed file:** Darebin 0.8 "floor" (council-profiles.json lines 581 and 630), Boroondara 0.65 (518, 545), Maribyrnong 0.75 (1175, 1217).
8. **Status mismatch:** the carpark still says OPEN, and the 2 Nov classification calls it "ALREADY-FIXED". By the rules it is neither FIXED nor accepted: it is "fix installed, not yet robot and Codex passed in AutoCAD".

### C. How big and which way: one made-up example by hand

**The site:** two units on 600 m2 in Darebin. Roofs and paving 400 m2, garden 200 m2. Darebin figures from reference C-003: before-development C 0.4, time of concentration 10 minutes, 1 in 5 discharge, 1 in 10 storage, Melbourne rainfall zone. The rainfall is the plug-in's office Melbourne curve, which is labelled as that zone. It is not a Bureau figure for a real Darebin site.

1. **A caution about method:** the office works Darebin in OSD4W (C-003, S-026), an outside program I cannot work by hand. The example uses Boyd's (S-003), which is what CDDESIGN does, to show the size of the C error. The floor applies the same way in either method.
2. **Permitted discharge (S-002):** 1 in 5, 10 minute rainfall 66.75 mm/h; 0.4 x 66.75 x 600 / 3600 = 4.45 L/s. The same in both methods.
3. **C, the office way (council floor applied):** worked-out (400 x 0.9 + 200 x 0.30) / 600 = 0.70, raised to the council's 0.80.
4. **Storage, the office way, C 0.80 (1 in 10: 105.0 / 78.7 / 64.6 / 55.6 mm/h at 5 / 10 / 15 / 20 minutes):**
   1. **10 minutes:** 0.80 x 78.7 x 600 / 3600 = 10.49 L/s; (10.49 - 4.45) x 600 = 3,624 L.
   2. **15 minutes:** 0.80 x 64.6 x 600 / 3600 = 8.61 L/s; (8.61 - 4.45) x 900 = 3,748 L.
   3. **20 minutes:** 7.41 L/s; (7.41 - 4.45) x 1200 = 3,560 L.
   4. **Volume required:** 3.75 m3, at 15 minutes.
5. **Installed code today (3.0.90.15, switch on):** the same as the office, C 0.80 and 3.75 m3, with "council minimum C governs" in the notes.
6. **Builds before 3.0.87 (the fault), C 0.70:**
   1. **10 minutes:** 0.70 x 78.7 x 600 / 3600 = 9.18 L/s; (9.18 - 4.45) x 600 = 2,838 L.
   2. **15 minutes:** 7.54 L/s; (7.54 - 4.45) x 900 = 2,780 L.
   3. **Volume required:** 2.84 m3. That is 0.91 m3 (about 910 litres, 24 per cent) SHORT of 3.75.
7. **A more garden-heavy lot (300 hard, 300 garden), old builds:** C 0.60 against 0.80 gives 2.05 m3 against 3.75 m3, which is 45 per cent short. The carpark's "25 per cent" is the C being 25 per cent low on that lot, not the storage. Storage moves much more than C, because the permitted discharge does not change.
8. **Verdict:** in the old builds, UNSAFE: storage too small and flows understated. In the installed build the figure matches the office method.

### D. When it bites, and how a drafter would know

1. **Councils:** only Darebin, Maribyrnong and Boroondara (the three whose council record carries a "floor").
2. **When:** only when the worked-out C is below the floor. With roof and paving at 0.9 and garden at 0.30, that is under about 83 per cent hard area for Darebin, 75 per cent for Maribyrnong and 58 per cent for Boroondara. That covers nearly every two-unit job in Darebin. The CDCALC Boyd's tab counts roofs at 1.0 (BUG-539), so it falls below the floor less often.
3. **Tools:** CDDESIGN, pump sizing and the CDCALC Boyd's tab. On builds before 3.0.87 there was nothing on screen to tell; the C shown was the worked-out one.
4. **On today's build:** the notes and computations should say "[CE] council minimum C governs" and "[CE] Runoff C = 0.80 (calculated 0.70)". If a Darebin job shows a C below 0.80 with no such line, the switch has been turned off or the job is not on the Darebin profile.

### E. Which sheets could already be affected

1. **The window:** the Darebin floor has been in the plug-in's council file since 4 Sep 2026 (commit f701421a), and Boroondara and Maribyrnong since 26 Sep 2026 (afa5435c). Before that there was no floor at all, so the outcome was the same. The fault ends with Civil 3.0.87 (30 Oct 2026).
2. **The jobs at risk:** detention or pump jobs in Darebin, Maribyrnong or Boroondara whose C, storage or pump figures came from CDDESIGN, pump sizing or the CDCALC Boyd's tab on any build before 3.0.87, and where nobody raised the C by hand.
3. **Probably not affected:** Darebin jobs worked by hand in OSD4W (the office's normal method for that council, C-003), where the engineer types the 0.80 into OSD4W. Darebin also re-runs the sums itself (C-003 item 1.3), which may have caught it.
4. **What I cannot tell:** whether any such sheet was issued. Nothing I read records it, and I did not open the Projects folder.

### F. What a drafter should do TODAY

1. **On every Darebin, Maribyrnong or Boroondara job, check the runoff C on the computations** against a one-line hand sum: (hard x 0.9 + garden x 0.30) / site, then the larger of that and 0.80 (Darebin). For Maribyrnong (0.75) and Boroondara (0.65), confirm the figure from the council's own document first. The sheet must show "council minimum C governs" whenever the floor is the larger.
2. **Re-run on today's build any job of those three councils sized in the plug-in before 30 Oct 2026,** and compare the storage. If it went up, the issued figure was short.
3. **Leave the Detention setting "council minimum runoff C applied" switched on.**

### G. Confidence and limits

1. **That the fault was real in builds before 3.0.87:** HIGH (audit reading, reproduce test, fix commits).
2. **That the installed 3.0.90.15 applies the floor in all three tools with the switch on by default:** HIGH (read line by line at 2c8b7b1a; one storage path only).
3. **Not verified without AutoCAD:** that the notes actually show in the CDDESIGN window, on the computations sheet and in the Boyd's tab; and that a real Darebin test drawing picks the Darebin profile. The carpark's own AutoCAD steps (Darebin test copy, 600 m2, expect C 0.80 with the note) are still to be run by the robot and Codex.
4. **Council figures:** Darebin 0.80 is sourced in the zero reference. Maribyrnong 0.75 and Boroondara 0.65 are UNKNOWN by the zero reference (not filed there).

## Would the new plug-in repeat either fault?

1. **BUG-866 (rainfall): YES, and worse, as the data stands today.** `src/CeCivil.Brain/data/tables/rain_1in10.csv` holds one column, the Kingston job CIV-03's rainfall. `sums.csv` works rain_5 to rain_30 from it as one-way sums, so they cannot be typed over, and the Detention window's Boyd's card shows no rainfall row (the rain zone row shows only for OSD4W). Every Boyd's job would get Kingston rainfall. On the Glen Eira example that gives 1.85 m3 against 2.65 m3, 30 per cent short. The table is marked "window value, Tim to confirm; the Bureau table for the site's place replaces it", so it is known as a draft, but nothing on screen says so. **Test that catches it:** a Glen Eira site with the site rainfall 112 / 85.0 / 69.4 mm/h typed must give 2.65 m3. Also, a check that turns amber ("rainfall is the office sample, not this site's") whenever the rain facts still come from the sample table.
2. **BUG-1095 (council minimum C): YES, as the data stands today.** `runoff_coefficients.csv` gives per-surface defaults (0.90 and 0.35 or 0.30) and says a council's fixed coefficient "is typed over". There is no sum or check that raises the weighted coefficient to a council floor. `combine.csv` "larger" compares authorities for one key, not a worked-out sum against a council figure, and checks.csv only checks 0 to 1. **Test that catches it:** a Darebin site of 600 m2, 400 hard and 200 garden, must give coefficient 0.80 with words that the council minimum governs. Also a check "coefficient below the council's minimum" that is never silent.

Evidence: BUG_CARPARK.md BUG-866, BUG-872, BUG-1095; areas\AUDIT_ENGINEERING_CIVIL_2026-10-22.md findings 3 and 16; areas\TEAM_AUDIT_T2_24OCT.md finding 1; areas\BUGFIX_n16_REPORT_31OCT.md (BUG-866, PR #1948); decisions\2026-10-29_TIM_ANSWERS.md items 16 and 32; zero\reference\design\SUMS.md S-001 to S-003, S-026; LIMITS.md L-017; councils C-003 Darebin and C-006 Glen Eira; zero\DECISIONS.md D-207; git at 2c8b7b1a (Civil 3.0.90.15), d6f6ac2b, b531c85e, 85bf767d, 514d4148, f701421a, afa5435c; C:\CE_CIVIL data files named above.
