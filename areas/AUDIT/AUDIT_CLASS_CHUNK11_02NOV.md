# Carpark audit, chunk 11 of 21: entries 601 to 660 (BUG-132 to BUG-494)

Written Mon 2 Nov 2026 (Melbourne) by the Sonnet audit worker. Read-only: no file changed except this one, nothing built, no test run, no AutoCAD, no robot.

## FOR TIM

1. **Counts (60 entries):** 33 INSTALLED-WAITING-PROOF, 12 ALREADY-FIXED, 6 NEEDS-TIM, 3 CLOSED-OR-WONT-FIX, 2 DUPLICATE, 2 HAS-DRAFT, 1 FIXABLE-NOW, 1 UNCLEAR.
2. **Plain meaning:** almost nothing in this chunk still needs building. 45 entries are already fixed in the code and are only waiting for someone to look at them in AutoCAD. Most of them still say OPEN in the carpark only because that is how they were filed on 9 Oct.
3. **FIXABLE-NOW, most pilot-critical:** only one, BUG-491 (the leftover privacy tidy-ups: Manager failure reports, file names carrying drawing names, the dormant old Structural support zip). It is not pilot-critical. There are no other FIXABLE-NOW entries in this chunk.
4. **Your questions (NEEDS-TIM):** BUG-454 (pad label height), BUG-466 (next-free-mark wording), BUG-475 (BT1 longest brace; R1 click), BUG-483 (old install scripts), BUG-492 (time-log name), BUG-493 (start-up writes). BUG-483 and BUG-492 are the two that matter for colleagues.
5. **Still broken and pilot-critical:** BUG-467 (BT1/AB/BB second point wrong in a rotated UCS). The fix is a draft, PR #1921, not merged, not opened in AutoCAD.

## What I read, built, tested, and did NOT prove

1. **Read:** every Symptom, Expected, last Status line and Note for all 60 entries. Checked commits on origin/claude/rel-20261102a (Civil/Manager) and origin/claude/rel-20261026s (Structural) by git log and git grep; checked PRs with gh.
2. **Built / tested / opened in AutoCAD:** none of it, by me.
3. **Not verified, in plain words:** I did not read any installed DLL. "Installed" below is inferred from dates, the Structural line head (204dfad2 = 1.0.125 per the carpark notes) and what the entries themselves say. I did not open the office folder, so BUG-479 (the April approval file) and BUG-483 (old install scripts) were not checked on disk. The ledger (runner-reports\ledger.json) names cases, not BUG numbers, so it gave no per-entry result. gh found only some PRs by title; merged PR numbers come from the commit messages.
4. **Class rule I used:** INSTALLED-WAITING-PROOF = the fix is in a line at or before the installed build and nobody has proved it in AutoCAD. ALREADY-FIXED = the fix is on the Civil/Manager line (rel-20261102a) but I could not show it is in the installed 3.0.87 or Manager 1.1.87.

## The 60 entries (in carpark order)

1. BUG-132 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 3197e3d4 (R2 batch F1-F8, 15 Sep); carpark says awaiting Tim's retest.
2. BUG-133 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 3197e3d4 (live words on object picks); awaiting retest.
3. BUG-134 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 3197e3d4 (survey outlier now a warning); awaiting retest.
4. BUG-135 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (CDPIPEOBJ look, colour, lag); awaiting retest.
5. BUG-136 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (twin envelope on CDEDIT); awaiting retest.
6. BUG-137 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (Base RL into the tank record); awaiting retest.
7. BUG-138 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 8e52bb56 (pipe wider than pit asks to upsize); awaiting retest.
8. BUG-106 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 0b94f379 (callout landing) and 3197e3d4 (NEAREST-only picks, left-justified west callouts); awaiting retest.
9. BUG-105 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 598b4eec (twin arrow offset, single and twin values on Settings); awaiting retest.
10. BUG-104 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 813b4672 (linked text edit now says what it stored); awaiting retest.
11. BUG-103 | UNCLEAR | pilot-critical no | The MLeader refusal was fixed in 813b4672, but "riser and dropper blocks wrong, same with wt block" was never explained: needs Tim's screenshot of which block looks wrong.
12. BUG-102 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed in rounds 2, 4 and 7 (a53eec0a, 5efae400, 2c6072cf); awaiting retest.
13. BUG-101 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by 7c3be5a3 (fall-arrow shaft 610 mm) and a2c1d060 (live words); awaiting retest.
14. BUG-100 | CLOSED-OR-WONT-FIX | pilot-critical no | Status is FIXED, Tim confirmed the typed A on b312bf0f (reconciled 23 Oct).
15. BUG-449 | CLOSED-OR-WONT-FIX | pilot-critical no | Status FIXED, Codex-accepted W40 (9 Oct, reconciled 23 Oct).
16. BUG-450 | INSTALLED-WAITING-PROOF | pilot-critical no | LOW 1 wording fixed by b448275f (PR #848, in the Structural line); the six other LOWs were not each checked here and LOW 2 (Esc keeps the column) needs Tim's choice.
17. BUG-451 | DUPLICATE-OF-BUG-454 | pilot-critical no | This is a list of what Codex saw; its two open points (FSF Enter, pad label not visible) are exactly BUG-454, and FSF Enter was fixed by 9520b54d.
18. BUG-452 | INSTALLED-WAITING-PROOF | pilot-critical no | The MEDIUM (login in the Manager trace) is fixed, and 9a7d9610 scrubs every trace line; carpark says installed in Civil 3.0.70 / Manager 1.1.70, untested; LOWs 2 to 10 not checked here.
19. BUG-453 | INSTALLED-WAITING-PROOF | pilot-critical no | Wording fix is on the Structural line (merge 620eb896 of PR #1797, c1533e67); gh still lists #1797 as a draft, and a "still to be built" sentence remains on the member-schedule lines (not in this entry's three commands).
20. BUG-454 | NEEDS-TIM | pilot-critical yes | FSF Enter is fixed (9520b54d, PR #846), but in a millimetre drawing at DIMSCALE 1 the pad label is still 2.5 mm high; question: should the pad label follow the annotation scale (for example 250 mm at 1:100) like the schedules do?
21. BUG-455 | DUPLICATE-OF-BUG-435 | pilot-critical no | Status line already says DUPLICATE OF BUG-435 and BUG-562, closed on Tim's yes (decision 178).
22. BUG-456 | INSTALLED-WAITING-PROOF | pilot-critical no | MEDIUM fixed in #827 (installed Civil 3.0.70 per the carpark); not tested by robot or Codex; the main LOWs are open and not individually checked.
23. BUG-457 | INSTALLED-WAITING-PROOF | pilot-critical yes | Redo-guard hardening landed as 4708690f / 6fb18124 (PR #870) on the Civil line and 9508e3f0 on the Structural line; the unwalked U/REDO routes in section 4 still need a Codex pass.
24. BUG-458 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-C-01 fixed by 980b10c6 (PR #880, merged into rel-20261009l) and tidied by b5e15dda; nobody has watched REFEDIT then PIT in AutoCAD.
25. BUG-459 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-C-02 fixed by 0d3ccb24 (PR #882, #1090); Codex W59b PASS on 3.0.48 (12 Oct), awaiting Tim's confirmation.
26. BUG-460 | CLOSED-OR-WONT-FIX | pilot-critical no | Status FIXED (Claude-accepted, Civil 3.0.84, runner case R33 passed twice, Opus review agrees); fix 0d3ccb24.
27. BUG-461 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-C-04 fixed by 10999597 (PR #883, merged into rel-20261009l); not seen in AutoCAD.
28. BUG-462 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-C-05 fixed by d687c15d (PR #884): New Pipe reads the Settings tolerance; not seen in AutoCAD.
29. BUG-463 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-C-06 fixed by 5792a99c (PR #885): schedule levels use the Settings decimals; not seen in AutoCAD.
30. BUG-464 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-C-07 fixed by 354be3b6 (PR #881): Pit Schedule off on a read-only drawing and during REFEDIT; Codex W50 was meant to see it, no pass recorded here.
31. BUG-465 | INSTALLED-WAITING-PROOF | pilot-critical no | Items 08/09 ee2d9e4d, 10 67b63a74, 11 cbe41302, 13 adff5b45, 14 d3250e90, 15 dc4f3772 are fixed; I found no commit for item 12 (CE puts a layer's colour back on every draw), so that one may still be open.
32. BUG-466 | NEEDS-TIM | pilot-critical no | HUNT-S-01 fixed (23a4f832, PR #865; Codex W57 saw it); Codex W51 asks Tim: when a mark already exists, is "next free mark, ask its size, 600 default" the wanted behaviour?
33. BUG-467 | HAS-DRAFT | pilot-critical yes | Robot FAIL 31 Oct (second point of BT1, AB and BB turned twice by the UCS); draft PR #1921 (B-109, no switch) is open; PR #1883 was closed.
34. BUG-468 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixed by a77eeec9 (columns count as posts with beam linking off); carpark says installed in Structural 1.0.121, untested.
35. BUG-469 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-04 fixed by 300a6a3e (PR #867); Codex W57 and W51 saw Esc cancel cleanly; the leftover undo step is filed as BUG-564.
36. BUG-470 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-05 fixed by 987ca9dd (PR #899), already in the Structural head 204dfad2; no AutoCAD proof.
37. BUG-471 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-06 fixed by 95488c6a (R1, BT1, C1, TS1 stop in non-millimetre drawings) and f6a24386 (AB, BB); no AutoCAD proof.
38. BUG-472 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-S-07 fixed by 906e3792 (PR #887): layout tab and REFEDIT stop with one line; not tried in AutoCAD (BTX on a layout was the worst case).
39. BUG-473 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-S-08 fixed by 06af5e65 (locked-layer guard for BT1, C1, TS1, AB, BB, BTX); no AutoCAD proof.
40. BUG-474 | INSTALLED-WAITING-PROOF | pilot-critical no | HUNT-S-11 fixed by 8c46a8de and 81fcc357 (FEDIT asks Change / Leave / Another before a rename changes a saved size); needs an AutoCAD look.
41. BUG-475 | NEEDS-TIM | pilot-critical no | Most sub-items are fixed (S-10 cca118b9, S-12 a4e70908, S-14 ce31b395, S-15 6cf2add8), but S-13 says never decide without Tim: should BT1 obey the Settings "Longest wall brace" like AB and BB? and S-09: should a click at R1's first question pick directly?
42. BUG-476 | ALREADY-FIXED | pilot-critical yes | Wording fixed in b7619d9e and 0d06273f; 111e1505 (BUG-829) stops a colleague seeding their own list; Codex saw Tim's PC set up (W53); run 39 could not read the wording; a real "add an administrator" control was not found.
43. BUG-477 | INSTALLED-WAITING-PROOF | pilot-critical yes | HUNT-M-02 fixed by 41874359 (PR #868): Roll Back hidden behind the Manager switch showRollBack, OFF; no AutoCAD proof.
44. BUG-478 | HAS-DRAFT | pilot-critical yes | Wording fixed by 1db45965 (HUNT-M-03); the real "finish the update" step is draft PRs #1508 and #1515 (pure, switch OFF, nothing starts); the carpark says the route needs Tim's word.
45. BUG-479 | ALREADY-FIXED | pilot-critical no | HUNT-M-04 fixed by 4c4134fd (PR #869): status counts only valid approvals; the April approval file in the office folder was not checked by me.
46. BUG-480 | ALREADY-FIXED | pilot-critical no | HUNT-M-05 fixed by 4c4134fd (CeReleaseStatusService.cs line 158); carpark note says it needs a PC without the office folder to see it.
47. BUG-481 | ALREADY-FIXED | pilot-critical no | HUNT-M-06 fixed by 342baa37 and 622cd75f: Manager no longer forces MENUBAR unless forceMenuBar is on.
48. BUG-482 | ALREADY-FIXED | pilot-critical no | HUNT-M-07 fixed by dd6713f7: CESUPPORT says where the zip really goes, with a local-only folder switch (OFF).
49. BUG-483 | NEEDS-TIM | pilot-critical yes | Old install scripts in the office folder install old builds and promise automatic updates; question: may the old scripts and builds be moved into an "OLD - do not use" folder, with one pilot install note beside the real package? (Office folder not checked by me.)
50. BUG-484 | ALREADY-FIXED | pilot-critical no | HUNT-M-09 fixed by 5a344c73: CEHEALTH checks Manager, the Civil/Manager pair and duplicate installs.
51. BUG-485 | ALREADY-FIXED | pilot-critical no | HUNT-M-10 fixed by 3fdea24a: office-folder copy keeps failed reports waiting and never throws.
52. BUG-486 | ALREADY-FIXED | pilot-critical no | HUNT-M-11 fixed by b71d1139 behind the shortStagingFolders switch, which is OFF, so it does nothing until turned on.
53. BUG-487 | ALREADY-FIXED | pilot-critical no | HUNT-M-12/13 f31c325f, HUNT-M-14 280e7681, HUNT-M-15 4d8ce52a cover the four LOWs; items (a) to (d) are already listed under other BUGs.
54. BUG-488 | ALREADY-FIXED | pilot-critical yes | 97651f93: fault report and CEMANAGERDIAG now use coded names and the shared scrub (CeDiagnosticsService.cs lines 56-57, 286, 289); no AutoCAD proof; this was the privacy blocker.
55. BUG-489 | ALREADY-FIXED | pilot-critical yes | 0827bb32: the support zip cleaner now cuts names without .dwg, CD_ProjectData names and folder/PDF paths; the Civil log still writes DrawingName in JobTimeTracker.cs, so the clean zip relies on the cleaner; not tested.
56. BUG-490 | ALREADY-FIXED | pilot-critical yes | fefe6b1f: the Windows login is no longer written inside the drawing (DrawingPersonName: coded id or Settings value); no Environment.UserName left in the named files; not proven in a saved DWG.
57. BUG-491 | FIXABLE-NOW | pilot-critical no | Only A8 is done (f2669fa9); A6 (Manager failure report keeps paths), A9 (file names carrying drawing names) and A10 (dormant old Structural support zip) have no fix; A7 in Civil I could not confirm either way.
58. BUG-492 | NEEDS-TIM | pilot-critical yes | Time-log files and the weekly export are named by Windows login (CivilJobTimeSettings.cs 34, 38 still use Environment.UserName); question: default the name to blank and ask once, or to a coded name?
59. BUG-493 | NEEDS-TIM | pilot-critical no | An audit list of start-up writes, not a single fault; question: which start-up writes need a line in the CE log saying what was saved and why?
60. BUG-494 | INSTALLED-WAITING-PROOF | pilot-critical yes | The test's blind spots were addressed by the redo-guard port (9508e3f0, 4708690f); Codex still has not walked TS1, R1, FSF, FPFC, grip edits, Sheets update, drawing switch, or autosave between U and REDO.

## Counts

1. **INSTALLED-WAITING-PROOF:** 33
2. **ALREADY-FIXED:** 12
3. **NEEDS-TIM:** 6
4. **CLOSED-OR-WONT-FIX:** 3
5. **DUPLICATE-OF-BUG-NNN:** 2
6. **HAS-DRAFT:** 2
7. **FIXABLE-NOW:** 1
8. **UNCLEAR:** 1
