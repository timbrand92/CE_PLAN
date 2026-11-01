# W1 review F report (wave 1 bug-proof cases, list w1rev_list_2.txt), Sun 1 Nov 2026

1. **Answer:** 13 cases: 3 ACCEPT FULL (W671, W672, W742), 10 ACCEPT PART, 0 NOT YET, 0 ALREADY. 13 slips written.
2. **Weakest 1, W667:** the twin only flips the expected line, so the old PITDELETE error has never been seen. The pipe-label and schedule symptoms of the bug are not driven.
3. **Weakest 2, W713:** CDSL's "blank" spot actually reads P__.__, so the unreadable-text path is proved, not the empty-text skip. The twin moves the spot out of reach and also fails a stale check.
4. **Weakest 3, W741:** the twin removes the WT1 set-up instead of turning the fix off. The "never WT1 1" checks have never been seen red.
5. **Hashes:** every case file's sha256 matched its list line. No slip existed before, so nothing was copied to .old.
6. **Untouched:** no case, setup, spec, driver or settings file was edited. Nothing was run, built, committed or pushed.
7. **Time:** clock read 17:53:46 at start and 17:57:30 when the slips were finished (Melbourne, AUSEST). That is about 4 minutes by the PC clock. The clock looks low for this much work, so treat the figure with care.
8. **Report name:** the job message named this file. The brief's pattern (C78_REVIEW_F_REPORT.md) was not used.
9. **Twins:** 9 of 13 twins turn the fix off or reproduce the fault. W665, W667, W713 and W741 have weaker twins (see each entry).
10. **Word check:** every asserted CE line was found in source at 3fbb9da5 or seen on a run. Nothing is UNSOURCED.
11. **For Codex:** look at W743's other-drawing half, W784's drawn table and W665's scaled pit block.
12. **Slips:** each is next to its case in drafts_wave1_31oct, named <case>.review.txt.

---

## Cases

1. **W656, ACCEPT PART.**
   - **Proves:** the Edit Pipe cascade from P3 re-links only the preview's pipes. The log has exactly one endpoint line (1094BE) and none for 10B083, 10A942, 10A243 or 10A8C7.
   - **Twin:** switch off, 25 endpoint lines, checks 4 to 8 red (tW05). Strong.
   - **Not proved:** the bug's own picture (a stale stored From that gets rewritten). The fresh-copy endpoint lines stand in for it. CDPROPAGATE is not driven.
   - **UNSOURCED:** none. The RE review's worry ("would pass without the fix") is answered by the twin.

2. **W657, ACCEPT PART.**
   - **Proves:** the end text is on locked layer E3LOCK, so neither level text of P82 -> P83 is written (IL 18.150 and IL 18.050 stay, no IL 18.25). The "Nothing was changed ... (P82 -> P83)" line and both log lines appear.
   - **Twin:** layer left unlocked, checks 6 to 12 red, texts rewritten to IL 18.25 / 18.15. Strong.
   - **Not proved:** the start-text-locked order, CDPROPAGATE, and the stored record and schedule (these rest on CE's own words).
   - **Gap:** "E3LOCK unlocked at the end" is in EXPECTED but has no check. This is harmless because the disk copy is unchanged.

3. **W665, ACCEPT PART.**
   - **Proves:** ROTATE Copy and SCALE Copy of P3 each get their own pit, PIT LABEL (P8, and a number that is not P3 or P8) and cover text, with two copy lines. P3 stays P3.
   - **Twin:** expectation flip only (check 8). The switch-off red is control C34, which was not re-read on this build.
   - **Not proved:** grip Ctrl-drag, PITDELETE on a copy, the schedule row, and the look of the scaled block (Codex).

4. **W665p, ACCEPT PART.**
   - **Proves:** a ROTATE Copy of a pipe is numbered as new and gets its own label, IL 18.000 and IL 17.800 at the right ends, and an arrow.
   - **Twin:** switch off, checks 2 and 4 to 9 red. Strong.
   - **Not proved:** the bug's stated pipe symptom (a later MOVE of the original's label refused as "conflicting"), SCALE Copy of a pipe, and grip Ctrl-drag.

5. **W667, ACCEPT PART.**
   - **Proves:** a pit label is erased on its own, then U (the link rebuild), then PITDELETE. The result is a clean "Pit deleted (block + label/cover).", nothing left behind, and no [ERR] in the log.
   - **Twin:** expectation flip (check 7). It shows the check can tell the two lines apart, but the old fault itself was never reproduced.
   - **Not proved:** an erased cover text, a pipe MOVE after the rebuild, and dangling schedule rows.
   - **Weak check:** contains $u1 "LINE" is a common word. It only confirms the U echo.

6. **W671, ACCEPT FULL.**
   - **Proves:** a COPY of a pipe plus only its size label gets both level texts and an arrow, with one label and not two. This is the bug's exact picture.
   - **Twin:** switch off, checks 6 to 9 red (no texts, no arrow). Strong.
   - **Side branch not driven:** level texts copied without the label.

7. **W672, ACCEPT FULL.**
   - **Proves:** COPY of P3 was tested both ways round (25TEXT locked, then STORMWATER PIT LABEL locked). The open-layer piece is kept, only the missing piece and its layer are named, and U takes the copy back.
   - **Line check:** the line matches CloneCleanupMessages.cs 148-171.
   - **Twin:** switch off, 8 checks red across both halves. Strong.

8. **W713, ACCEPT PART.**
   - **Proves:** CDFALLSUGGEST reads P19.020 at 40 mm past a nearer spot that has no level typed. It suggests FALL toward the new pit at 1:100, and Skip places nothing.
   - **Not proved:** the nearer spot's LEVEL reads "P__.__" (seen on both passes), not empty. So SpotLevelReader's empty-text skip (lines 60-61) is not exercised. The ranking of only readable levels is what is proved, which still covers the bug ("blank or unreadable"). The case header and the record label ("must be empty") are inaccurate, though the checks are right.
   - **Twin:** moves the valid spot out of reach (a different fault, not the fix off), and also fails check 5 on a stale pattern. It breaks two things, but it fails on checks.
   - **Not driven:** the pit design-level offer.

9. **W740, ACCEPT PART.**
   - **Proves:** a COPY of ROOF DRAIN 1 is labelled ROOF DRAIN (never ROOF or ROOF1). The next CDSOURCE gives ROOF DRAIN 3.
   - **Twin:** removes the COPY (checks 4, 5, 8 and 9 red). It proves ROOF DRAIN 3 comes from the copy, not from a fix-off build.
   - **Not proved:** CDTAG Set, the "Number sources" setting, and other multi-word names. The copy's stored tag is inferred from the next number, not read directly.

10. **W741, ACCEPT PART.**
    - **Proves:** a doubled WT1 (3 blocks) gets the proposals WT13 and WT14, with no "WT1 1". Answering No renames nothing.
    - **Twin:** removes the set-up only (switch on refuses the WT1 tags). The absent-checks for "WT1 1" and "WT1 2" have never been red.
    - **Not proved:** the "ROOF DRAIN 1 1" half and the rename after Yes (BUG-813).

11. **W742, ACCEPT FULL.**
    - **Proves:** CDTAG with WT2 on untagged P10 is refused in one plain line, and the object count is unchanged.
    - **Twin:** switch off, which is the pre-fix route. "Tagged WT2." appears and one object is added. Strong.
    - **Out of scope:** the retag and Edit Source routes belong to BUG-814.

12. **W743, ACCEPT PART.**
    - **Proves:** in one drawing, Enter with no earlier level gives no PCL, 45.2 gives PCL 45.200, Blank gives no PCL, and Enter after 45.2 gives PCL 45.200.
    - **Twin:** grate C answers Enter instead of Blank, check 16 red. Good.
    - **Not proved:** the bug's main case (Enter in another drawing), because it needs a second drawing. Codex should look at it.
    - **Weak check:** grate A cannot tell a fixed build from an unfixed one in a fresh AutoCAD. The Blank grate is the real discriminator, because an unfixed build has no Blank keyword ("Requires numeric value" check).

13. **W784, ACCEPT PART.**
    - **Proves:** the Pit Schedule window shows P11's group with FROM C5 and FROM C6 on two rows, and no row FROM C or Cs.
    - **Twin:** switch off, checks 7 to 9 red. Strong.
    - **Not proved:** the drawn table's refresh (Codex look), the names CP3, SPS1 and GP4, a DP1 still reading DP, and the inlet levels.
