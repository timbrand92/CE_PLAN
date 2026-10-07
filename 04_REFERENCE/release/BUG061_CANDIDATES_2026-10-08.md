# BUG-061 candidate drawings: job numbers and counts only

Thu 8 Oct 2026. Design run 3 (headless, Opus), under INT-071 15a ("look through them all yourself"). Read-only: index files and entity dumps; no drawing opened or copied. File names and folders are in the local-only list `C:\CE_DrawingIntelligence\BUG061_CANDIDATES_LOCAL.md`.

## FOR TIM

1. **Answer:** five candidate consultant drawings were found, all 2026 warehouse jobs. Best first: **W26-26**.
   - In the April import check, that job's consultant schedule had 45 pipes and the import made 63.
2. **Finding:** in the three drawings already checked, the consultant drew every pipe as ONE line. No pipe was drawn as straight pieces meeting end to end.
   - So the extra pipes most likely came from the import doubling pipe walls. That is BUG-059, fixed in July and awaiting your re-import.
   - This is a reading of the files, NOT yet proven in AutoCAD.
   - If a re-import on a copy shows no split runs, BUG-061 can close as "gone".
3. **Nothing for you to do.** Codex runs the test on a copy (below).

---

## Candidates (job number, year, consultant file pattern, counts)

1. **W26-26 (2026), file `<consultant no.>_XCivil.dwg`:**
   - **April import:** 45 pipes on the schedule, 63 made by the import.
   - **19 Aug test:** 328 raw candidates, 53 pipes reported, 63 stored, 1 pipe joined to the same pit at both ends.
   - **Source drawing:** 32 centreline pieces, 0 straight end-to-end joins, 16 joins at a bend.
2. **W26-15 (2026), file `<no.>_XCivil_Design.dwg` (also used as an Xref):**
   - **April import:** 52 scheduled, 69 made.
   - **Source drawing:** 38 centreline pieces, 0 straight joins within 0.5 m.
3. **W26-14 (2026), file `<no.>_XCivil.dwg`:**
   - **April import:** 33 scheduled, 39 made. 2 pipes joined to the same pit at both ends.
   - **Source drawing:** 10 centreline pieces, 0 straight joins, 5 joins at a bend.
4. **W26-19 (2026), file `<no.>_XCivil.dwg` with a LandXML pipe list beside it:** never import-checked. A fresh test.
5. **W26-19 related, a second `<no.>_XCivil` file:** seen only as Xref layer names (pipe layers present). Its folder was not found. Weakest candidate.

Not a candidate: 25-06. Its import gave fewer pipes than scheduled (11 of 25), and its source file is architectural.

## What the Codex test-copy run needs

1. Copy the W26-26 consultant drawing (candidate 1) into `C:\Lisp Files\_TEST_COPIES_20260923\BUG061\`. Never use the original.
2. On a blank CE test copy, run **CDIMPORTXCIVIL** and pick the copy.
3. Count:
   - (a) CE pipes made vs 45 scheduled;
   - (b) same-size pipes meeting end to end in a straight line with no pit (BUG-061 proper);
   - (c) the same at a bend;
   - (d) pipes with the same pit at both ends;
   - (e) duplicate pipes lying on top of each other (BUG-059).
4. If (b) and (e) are both 0: report "061 gone on W26-26", then repeat on W26-14 (33 scheduled), then W26-15.
