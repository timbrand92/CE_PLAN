# CODEX WINDOW ORDER, Tue 3 Nov 2026, 18:00 evening batch

Drafted Tue 3 Nov 2026 about 10:30 Melbourne time by Sonnet (Team), read-only. The file name in the order was spelt `C:\CE_PLANreas\...` (a lost backslash); I wrote it to `C:\CE_PLAN\areas\OPEN_ITEMS_FOR_CODEX_WINDOW_03NOV.md`.

## FOR TIM

1. **Answer:** run five groups of looks on the installed Civil 3.0.89, in this order: the Checks tab look (8 minutes), the Cascade Preview look (25), the five Inspector and Edit Pipe looks (70), the three New Pipe, New Pit and LandXML looks (65), the five tidy-up looks (90). About 4 hours 20 minutes in all, so 18:00 to about 22:20.
2. **They are all "before" looks.** Not one of the fixes behind groups 2 to 5 is in any build that exists. I checked with git after a fresh fetch. The looks photograph the faults as they are today. Nothing from them can count as a fix passing.
3. **If Civil 3.0.90 (candidate b1) is installed before 18:00, the order changes.** The 17 fixes in b1 are the first thing to look at then, because they are real shipped code. Today the installed build is 3.0.89 (commit 61fd6fbc), so they wait. Someone must read the installed version before the batch starts.
4. **The Checks tab look is CE 02's and is already written** (8 minutes). It settles whether the red Grade line (BUG-1094) shows on the Checks tab. Two earlier looks never clicked that tab.
5. **Looks that cannot run at all tonight:** the orifice detail (#2000, no command uses it), office folders on OneDrive (#1998, needs a second PC), the multi-sheet PDF (#1999, needs a made-up sample PDF). Five more b1 fixes cannot be seen on screen. They are listed at the end.
6. **Needs your word:** one thing. Question 3 of the 2 Nov batch (count only the pits that change, or keep all five) decides whether the Cascade Preview fix (#1994) is the right fix. Codex only reports the facts.
7. **Not proven:** nothing here was run, built or tested. Every screen word in the briefs is from code and reports, not from a screen. Minutes are the briefs' own figures, except where I say they are my guess.
8. **Nothing for you to test or click.** All of it is Codex, on copies, in the free window.

---

## WHAT I READ, BUILT, TESTED, NOT PROVEN

1. **Read:** `C:\TimOS\RULES.md`. The tail of the desk log (the file is `C:\CE_PLAN\areas\release-v3-colleagues-DESK_LOG.md`, last entry Tue 08:18; there is no `C:\CE_PLAN\DESK_LOG.md`). The head of `PENDING_TESTS.md` (2046 lines; its newest sections are 29 Oct, so it has nothing for tonight). The "FOR TIM" part of eight look-brief files written 2 and 3 Nov. CE 02's launcher `verifyB1g_c88.txt`. I did not read `CODEX_NEXT` (it is not in the runner folder I listed) or any report written after 08:18.
2. **Checked with git and the GitHub tool (read-only):** `git fetch origin` ran first and clean. Branch tips: rel-20261102a 3fbb9da5, b1 rel-20261108a cf059dcf, b2 rel-20261110a now aa3b92ac (the 2 Nov briefs say d4ce878e; the branch moved on 3 Nov 01:23), Structural rel-20261026s 204dfad2.
3. **Installed 61fd6fbc is inside b1, and b1 is inside b2** (git ancestor check, both yes).
4. **PRs #1989 to #2005 (all 17 open drafts):** none is inside 61fd6fbc, b1 or b2. Heads match those the briefs name. PRs #2006 to #2010 do not exist yet.
5. **The 17 b1 fixes:** #1868, #1880, #1891, #1892, #1923, #1940, #1943, #1945, #1950, #1951, #1952, #1953, #1955, #1958, #1969, #1970, #1972 are inside b1 and b2 and NOT inside the installed 61fd6fbc. Only #1887 and #1962 are installed.
6. **Built:** nothing. **Tested:** nothing. **NOT proven:** what any of these looks will show, that the brief files run as written, and that the minutes hold.

---

## THE ORDER (build installed: 3.0.89; all groups BEFORE looks)

1. **Checks tab look, BUG-1094 (#1962, installed).** Brief: `C:\Lisp Files\_CODEX_RUNNER\verifyB1g_c88.txt` with `verifyB1g_c88_full.txt` (CE 02 wrote it Tue 07:40; reference only, not copied here). About 8 minutes. Lock Codex-B1g. Why first: it is the only look that tests something installed, and it settles the open finding from B1e and B1f (no Grade line seen in the Inspector).
2. **Cascade Preview pit count, BUG-1273 (#1994).** Brief: `C:\CE_PLAN\areas\LOOKBRIEFS_W1094_1272_1273_02NOV.md`, looks K3-01 and K3-02. About 25 minutes. K3-03 (switch-off look) runs only if the flag `C:\Lisp Files\_CODEX_RUNNER\K3_OFF_GO.flag` exists, which would add about 12. Why second: its facts feed your open question (item 6 above).
3. **Five Inspector and Edit Pipe looks (#1989 to #1993).** Brief: `LOOKBRIEFS_FIXES_1989_1993_02NOV.md`. About 70 minutes: caption 10, red row 15, Cascade Preview 20, downhill wording 10, CDSYNC 15. The red-row switch-off look (about 10 more) runs only with `F1_REDROW_OFF_GO.flag`. Warning: #1992 and #1993 both add a settings group called `validation` and clash. This is for the release desk.
4. **LandXML levels, blank cover level, MIN. on the pipe label (#1995, #1996, #1997).** Brief: `LOOKBRIEFS_PR1995_1999_03NOV.md` (this one replaces the earlier `LOOKBRIEFS_W1052_W900_02NOV.md`). About 65 minutes: LandXML 25, New Pit and Edit Pit 25, label 15. #1998 and #1999 in the same file stop at NOT TESTED on purpose.
5. **Five tidy-up looks (#2001 to #2005).** Brief: `LOOKBRIEFS_FIXES_316_323_03NOV.md`. About 90 minutes: AG drain grade text 15, Tidy labels after a slide 25, windows reopen in the middle 20, pipe object file "not loaded" 15, CDPARTS on a layout 15. Least certain: #2003 (windows are moved by dragging) and #2004 (may need the file unloaded by hand). Why last: lowest value per minute and the shakiest to run.

**If time runs short:** cut from the bottom. Groups 1 and 2 are the minimum.

---

## IF CIVIL 3.0.90 (b1) IS INSTALLED BEFORE 18:00: THEN RUN THESE FIRST, AHEAD OF GROUPS 2 TO 5

1. **Inspector no longer "Unknown" after reopen, #1880 (your own "I always have to CDSYNC" complaint).** `LOOKBRIEFS_B1_PART2_02NOV.md`, LB-B1-10. Needs a test settings copy with one switch OFF for its control run: needs CE 00's GO.
2. **Two-drawings pair: #1953 (Inspector shows the newer list) and #1955 (Undo in drawing A after a pick in B).** PART2 LB-B1-12 and PART3 LB-B1-13, one shared session. #1953 has no way to make the failed save yet: CE 00 decides.
3. **#1972 Recalculate downstream question after the change is accepted.** PART3 LB-B1-17. Robot case W658 goes first; Codex looks at the drawing behind the box.
4. **#1945 CDDESIGN warns for a Save As copy.** PART2 LB-B1-07.
5. **#1891 copied downpipe gets its own tag.** PART1 LB-B1-02, after robot case W1246.
6. **#1868 big-pipe minimum fall.** PART1 LB-B1-01. Needs a test copy with `designStandards.largeGravityMinGradeN` = 200: needs CE 00's GO. Ships blank, so changes nothing on your drawings if not set.
7. **#1923 double-click on a pit label** (ships OFF). PART3 LB-B1-18. Only with two switches on in a test copy.
8. **Minutes:** the three B1 files do not state minutes per look. My guess is 15 to 25 each, so about 2 to 3 hours for the seven above. This is a guess, not from the briefs.

---

## CARRIED OVER FROM THIS MORNING (briefs need fixing first, so not in tonight's order)

1. **Looks that ended BLOCKED or NOT TESTED in the 06:10 to 07:37 window:** S3d (second pit out of view, pipe 2 never placed), B1e and B1f CDRULES (an option prompt the brief did not cover), L1b LB1-05 and LB1-06, L2a LB2-02 and LB2-03, L2b LB2-08. S4 and S7 have no brief at all. These are CE 02's briefs to repair; I have not seen any repaired version.
2. **Passed but waiting for a robot case before they can count:** BUG-233 (L2a LB2-01, PASS SURE), B2-02, B3-01, BUG-1195 pieces.

## SKIPPED AND WHY

1. **#2000 orifice detail:** no command or window calls it in b1 or b2. Its one question (which level the centre IL tag shows) is yours and stays in the carpark.
2. **#1998 office folders on OneDrive:** the plain folders are on your disk, so the code never fires here. Needs a second Windows account or test PC.
3. **#1999 X-Civil PDF every page:** needs a made-up two-sheet PDF schedule with a matching X-Civil drawing. None exists in the repo.
4. **#1943, #1950, #1969:** need a damaged LPD record, an old twin detention pipe, and a comma-decimal PC. None available; #1969 would mean changing the Windows region, which we must not do.
5. **#1958, #1970, #1951, #1922:** nothing on screen to see. #1892 and #1940 are briefed in `LOOKBRIEF_BATCHC_HUB_EDITS_02NOV.md` (the 2 Nov morning file I did not reread).
6. **BUG-1052 and BUG-396:** BUG-1052's fix is only on a local branch, no PR. BUG-396 stopped for a command card.
7. **The 2 Nov morning files** (`LOOKBRIEF_BATCHB_*`, `LANEB_*`, `K1_02B`, `C78_*`, `W234_*`, `EXPORT_SAVE_BOX`, `RIBBON_TWO_DRAWINGS`): written for the C-78/C-79a build and run since as the B, L and S looks (see the log). I did not reread them.
8. **Structural (rel-20261026s):** no Structural look brief is in the files I read, so none is ordered.
9. **Settings warning for every group above:** the fix reports say `CD_Settings.json` was reset to a 4 Oct copy and nobody has found what writes it. Each brief records its fingerprint at start and end. Codex must not read or change Tim's real settings files.
