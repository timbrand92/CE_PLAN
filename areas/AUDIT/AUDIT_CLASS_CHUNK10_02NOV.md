# Carpark audit, chunk 10 of 21 (entries 541 to 600, BUG-016 to BUG-131)

Written Mon 2 Nov 2026, Melbourne time, by the Sonnet audit session. Read only. Nothing in the carpark was changed.

## FOR TIM

1. **Counts (60 entries):** 1 fixable now, 6 need your word, 2 duplicates, 6 already fixed, 0 with a draft, 35 installed and waiting for proof, 7 closed or won't fix, 3 unclear.
2. **Fixable now:** only one, and it is a grade label. BUG-027 (the "MIN." wording on the pipe label). Your ruling of 26 Sep (UX-CPLAN-05, "Keep the May rule: no MIN.") is written inside the entry, so a builder can do it. Robot case K02 is already drafted to prove it. A pilot user would see this on almost every pipe label.
3. **The other four "most critical" slots are empty.** There are no other fixable-now entries in this chunk. The pilot-critical ones are all installed and waiting for a robot or Codex look: BUG-024 and BUG-025 (grade and invert labels), BUG-085 and BUG-088 (beam placement and lintels), BUG-094 (CDEDIT opening from the pipe's MLINE or PLINE).
4. **Your questions (6):** BUG-029 (which fall arrow style is final), BUG-031 and BUG-034 (do the in-dialog toggles replace the popup and the auto-pick), BUG-042 (where the break toggle sits), BUG-052 (still remove PIT BLOCK 2 now the automatic migration exists), BUG-095 (the Glen Eira detention storage is 30.07% off the fixture, which basis is right).
5. **Closing proposals for you (7):** BUG-016, 023, 030, 037, 040, 096, 097. All are overtaken or not product faults. Nothing was closed by this audit.
6. **Not verified:** see the last section. In short, I did not find or search pull requests, I did not open AutoCAD, and the ledger holds results by case number, not by bug number.

## The list

Class meanings: FIXABLE-NOW, NEEDS-TIM, DUPLICATE-OF-BUG-NNN, ALREADY-FIXED, HAS-DRAFT, INSTALLED-WAITING-PROOF, CLOSED-OR-WONT-FIX, UNCLEAR. "Pilot-critical" means a pilot user would meet it in normal drawing work.

1. BUG-016 | CLOSED-OR-WONT-FIX | pilot-critical no | The Custom grade box was replaced by the CD window redesign (entry and the 23 Oct reconciliation say so); proposal only, Tim has not said it.
2. BUG-017 | DUPLICATE-OF-BUG-035 | pilot-critical no | T23 to T25 were Tim-confirmed and the one remaining failure (T22) is BUG-035; the World-UCS guard is in place.
3. BUG-018 | ALREADY-FIXED | pilot-critical no | Last Status line says FIXED 20 May with Tim confirming T18; pre-monorepo, no commit found by search; PIT BLOCK 2 is later overtaken by PIT BLOCK 3.
4. BUG-019 | ALREADY-FIXED | pilot-critical no | Last Status line says FIXED 20 May with Tim confirming T7; pre-monorepo, no commit found by search.
5. BUG-020 | INSTALLED-WAITING-PROOF | pilot-critical no | Code writes R and D tags and sweeps all attributes (round 3); CDWT was rebuilt in CV4-9/15 (7831f74a); listed in the Codex look batch, no V3 evidence yet.
6. BUG-021 | INSTALLED-WAITING-PROOF | pilot-critical yes | Three rounds of code for the IL text side near 92 to 96 degrees; the 24 Oct triage found no V3 evidence, so it needs a robot look with a pipe at those angles.
7. BUG-022 | DUPLICATE-OF-BUG-028 | pilot-critical no | Middle floor wastes were Tim-confirmed; ends and corners are BUG-028 and the arrow is BUG-029.
8. BUG-023 | CLOSED-OR-WONT-FIX | pilot-critical no | Mechanics Tim-confirmed 20 May and the leftover UX points were split into BUG-030 to BUG-034; proposal only, the last Status line still says OPEN.
9. BUG-024 | INSTALLED-WAITING-PROOF | pilot-critical yes | Grade label rules are installed from May to July code; the 24 Oct triage says never tested by robot or Codex; the "CDEDIT rising main destination hard-coded WT" leftover is not checked.
10. BUG-025 | INSTALLED-WAITING-PROOF | pilot-critical yes | The 1.10 to 1.11 invert drift was fixed in two rounds (rounding noise, then keep the typed end) with tests; no V3 robot or Codex run found.
11. BUG-026 | INSTALLED-WAITING-PROOF | pilot-critical no | Inspector rounding now matches the label and the 1:94 cause was BUG-025; it is in the Codex look batch.
12. BUG-027 | FIXABLE-NOW | pilot-critical yes | The 29 Oct retest triage inside the entry says the installed code still adds "MIN." against Tim's UX-CPLAN-05 ruling (CdCommand.Grade.cs 212 to 221); a builder can fix it from that note, and the entry's older band rule (round 2) must be replaced by the ruling.
13. BUG-028 | INSTALLED-WAITING-PROOF | pilot-critical no | The 50 mm end and 25 mm corner insets were coded with 8 tests, then reshaped by R5 and R6; the 31 Oct lane plan puts it in the robot look-around.
14. BUG-029 | NEEDS-TIM | pilot-critical no | The entry asks for a QLeader on 25DIMS, then R6 changed it to a Leader with the TIM LEADER dimstyle on the STRIP DRAIN layer: which arrow style and layer is final?
15. BUG-030 | CLOSED-OR-WONT-FIX | pilot-critical no | The "[Yes/Ce]" command-line prompt was replaced by a popup (comment at CdCommand.Breakline.cs line 37 on the latest line), so the prompt no longer exists; proposal only.
16. BUG-031 | NEEDS-TIM | pilot-critical no | The popup is coded, but R5 and R6 later moved continuation to an in-dialog banner and a manual toggle; does Tim want the popup kept or retired?
17. BUG-032 | INSTALLED-WAITING-PROOF | pilot-critical no | The "Linked half" badge is coded for the Inspector; the 31 Oct lane plan puts it in the robot look-around; no V3 evidence.
18. BUG-033 | INSTALLED-WAITING-PROOF | pilot-critical no | Small-pipe arrow offset fixed by a clash radius that scales with pipe size, 9 tests; no V3 look.
19. BUG-034 | NEEDS-TIM | pilot-critical no | Only the "remember last choice" half was built; the auto-detect half (BUG-034b) is deferred, and R6.1 added a manual continuation toggle: is auto-pick still wanted?
20. BUG-035 | INSTALLED-WAITING-PROOF | pilot-critical yes | PIT is forced to rotation 0 after insertion as a defensive fix that masks the cause; the T22 retest (rotated UCS, CD then PIT) has not been done on V3.
21. BUG-036 | INSTALLED-WAITING-PROOF | pilot-critical no | CDREFRESHLINKS, R5 and R6.5 cover the MIRROR and MOVE cover-text case; the triage notes the entry carries a sub-heading and needs a robot look.
22. BUG-037 | CLOSED-OR-WONT-FIX | pilot-critical no | The installer audit of PIT BLOCK 2 found it staged, and PIT BLOCK 2 is now overtaken by PIT BLOCK 3; proposal only, colleague-machine check never done.
23. BUG-038 | INSTALLED-WAITING-PROOF | pilot-critical no | The combined SPS to breakline to destination invert line is coded in the Inspector; the 31 Oct lane plan puts it in the robot look-around.
24. BUG-040 | CLOSED-OR-WONT-FIX | pilot-critical no | Last Status line is WONT FIX, closed on Tim's yes (decision 178, 31 Oct); CDWT is water tanks only.
25. BUG-041 | INSTALLED-WAITING-PROOF | pilot-critical no | The two-point limit on Custom grade was removed and coded 21 May; no V3 evidence in the 24 Oct triage.
26. BUG-042 | NEEDS-TIM | pilot-critical no | The entry itself says where to put the gravity breakline toggle needs Tim's UX answer; R6.2 then made Cross-plan break the toggle for all pipe types, so confirm that is the intended place.
27. BUG-087 | ALREADY-FIXED | pilot-critical no | Last Status line is FIXED 14 Aug with Tim confirming "HATCH WORKS HOWEVER" on Structural 1.0.72 (source 9af408a5).
28. BUG-086 | INSTALLED-WAITING-PROOF | pilot-critical yes | The C2 Upgrade or Cancel workflow was built and audited in Structural 1.0.67 (ff36a304), and C2 is in the Codex look batch of 31 Oct; no result found.
29. BUG-085 | INSTALLED-WAITING-PROOF | pilot-critical yes | The beam command 1 endpoint repair (d44c7b42) is in later Structural trains and the command is in the Codex look batch; no result found.
30. BUG-088 | INSTALLED-WAITING-PROOF | pilot-critical yes | The L4 midpoint fallback and RB9 label offset were fixed in 1.0.73 (4a5927a1, with abaa565a on the Structural line); in the Codex look batch, no result found.
31. BUG-089 | UNCLEAR | pilot-critical yes | No commit names this bug and the 1.0.73 work targets BUG-088's different error; missing: whether LINTEL_BOUNDARY_MISSING still appears for L2 and L4 on the current Structural build, which a Codex look would show.
32. BUG-090 | ALREADY-FIXED | pilot-critical no | Fixed by PR 1836 (3db30bfe, window grows to fit its rows); Codex G4-02 and A1-01 PASS on 30 Oct at 100% display, the 150% half was BLOCKED; the carpark Status line is stale and Tim also wants the version window moved into CE Manager.
33. BUG-091 | UNCLEAR | pilot-critical yes | The refusal wording from the entry no longer appears in the current Drainage code, and no commit names DR-CD-01 or this bug; missing: which commit carried the approved fix, and a live free-point CD and CDEDIT Apply check.
34. BUG-084 | INSTALLED-WAITING-PROOF | pilot-critical no | Drawing close now releases project data (tests 2 of 2 on net48 and net10); the entry itself says it still needs an AutoCAD open, close and reopen memory check.
35. BUG-083 | INSTALLED-WAITING-PROOF | pilot-critical no | PIT window cleanup on close is built and tested; the entry itself says it still needs an AutoCAD open and close memory check.
36. BUG-082 | ALREADY-FIXED | pilot-critical no | Last Status line is FIXED 27 Jul with 10 of 10 build-safety tests and no AutoCAD test needed; no commit found by the bug-number search.
37. BUG-050 | INSTALLED-WAITING-PROOF | pilot-critical yes | The beam label side fix (same side whichever end was clicked first) is installed in Structural 1.0.121; the triage says no robot case or Codex evidence yet.
38. BUG-052 | NEEDS-TIM | pilot-critical no | The automatic PIT BLOCK 3 migration was built and tested, but the entry's last step (drop PIT BLOCK 2 from the install) was gated on a rollout test: does Tim still want PIT BLOCK 2 removed? Follow-up problems sit in BUG-793.
39. BUG-093 | INSTALLED-WAITING-PROOF | pilot-critical no | The faulting grip class is no longer registered and PR 655 deleted it (bf2ff1f2); the triage says it needs a Codex retest of the Slide, Offset and Flip grips.
40. BUG-092 | UNCLEAR | pilot-critical yes | The 60-retry constants named in the entry are no longer in the Manager ribbon code on the latest line and no commit names this bug; missing: which commit changed it and whether the start-up lag is gone.
41. BUG-094 | INSTALLED-WAITING-PROOF | pilot-critical yes | The CDEDIT shared-picker correction was deployed (96e7d76a on 7 Sep); the entry says it awaits Tim's MLINE and PLINE check.
42. BUG-095 | NEEDS-TIM | pilot-critical yes | The Glen Eira detention storage is 1.80 m3 against 2.58 m3 in the fixture; which calculation basis (Boyd's sheet or the Swinburne profile) is right is an engineering call, and tolerances must not be widened.
43. BUG-096 | CLOSED-OR-WONT-FIX | pilot-critical no | Last Status line is WONT FIX, a test packaging file only, closed on Tim's yes (decision 178).
44. BUG-097 | CLOSED-OR-WONT-FIX | pilot-critical no | Last Status line is WONT FIX, a stale test count only, closed on Tim's yes (decision 178).
45. BUG-098 | INSTALLED-WAITING-PROOF | pilot-critical yes | The label-versus-ID mismatch warning is in the code (813b4672, 4a79f5ee, 5efae400); Codex pass 18 was BLOCKED because the mismatch could not be created, and the plan label is the authority.
46. BUG-099 | INSTALLED-WAITING-PROOF | pilot-critical no | The glyph fix is in (813b4672); Codex pass 18 was BLOCKED because no symbol showed on screen, so neither the old nor the new result was seen.
47. BUG-144 | INSTALLED-WAITING-PROOF | pilot-critical no | Survey Approve keyword fixed in 38842c9c; the lane plan notes there is no runner case yet for CDSURVEY.
48. BUG-145 | INSTALLED-WAITING-PROOF | pilot-critical yes | Pit grip-move labels following once, fixed in 38842c9c; awaiting a robot or Codex look.
49. BUG-146 | INSTALLED-WAITING-PROOF | pilot-critical no | The tidy-up after MOVE now sees the established route's pipes (38842c9c); awaiting a robot or Codex look.
50. BUG-147 | INSTALLED-WAITING-PROOF | pilot-critical yes | The duplicate-tag refusal on CDFW and CDSOURCE was fixed (38842c9c, later 69852255 for BUG-152); awaiting a robot or Codex look.
51. BUG-139 | INSTALLED-WAITING-PROOF | pilot-critical no | Water tanks leave the identity gate (8c9f6833); awaiting a robot or Codex look.
52. BUG-140 | INSTALLED-WAITING-PROOF | pilot-critical yes | Labels follow a grip-moved pit once (8c9f6833, later 38842c9c); awaiting a robot or Codex look.
53. BUG-141 | ALREADY-FIXED | pilot-critical no | Last Status line is FIXED, Codex-accepted both halves on Civil 3.0.65 on 20 Oct (PRs 1482 and 1484, b56839b8); the leftover "no clear spot" on P3 to P2 is a real overlap and Tim said "yes leave it".
54. BUG-142 | INSTALLED-WAITING-PROOF | pilot-critical no | CDSURVEY approves at the command line when CESURVEYREVIEW is missing (8c9f6833); no runner case yet.
55. BUG-143 | INSTALLED-WAITING-PROOF | pilot-critical no | The CDPIPEOBJ look was fixed (8c9f6833) and kept true after the twin fix (42362023); it sits in the labels and drawn output look list.
56. BUG-127 | INSTALLED-WAITING-PROOF | pilot-critical no | Callout picks use NEAREST only (3197e3d4); BUG-106 shares the lane and there is no D card.
57. BUG-128 | INSTALLED-WAITING-PROOF | pilot-critical no | West callout text left-justified (3197e3d4); it is on the labels and drawn output look list.
58. BUG-129 | INSTALLED-WAITING-PROOF | pilot-critical no | The wrapped pipe label mask is tight (3197e3d4); it is on the labels and drawn output look list.
59. BUG-130 | INSTALLED-WAITING-PROOF | pilot-critical no | Tidy-up after MOVE now runs on the established route (3197e3d4); later tidy work (BUG-141) built on it.
60. BUG-131 | INSTALLED-WAITING-PROOF | pilot-critical no | The P9 pit grip-move left-behind text was fixed (3197e3d4); later grip-move bugs 140 and 145 followed.

## What I could not verify

1. **Pull requests:** the GitHub tool was not on the path in this session, so I did not search pull requests by bug number. A draft pull request could exist for any entry, so HAS-DRAFT shows 0 only because I could not look. Please treat that as unknown.
2. **Git search by bug number:** I searched the latest Civil and Manager line (rel-20261102a) and, for Structural, rel-20261026s. Bugs 016 to 038 and 082 to 089 return nothing because that work was committed before the monorepo or under other wording. That is why several ALREADY-FIXED lines have no commit.
3. **The ledger:** `ledger.json` is keyed by robot case number (R09, K02 and so on), not by bug number, so I could not read a result straight from it. I used the 24 Oct, 29 Oct and 31 Oct triage files in `C:\CE_PLAN\areas\` for the proof state instead.
4. **Not run or opened:** AutoCAD, the robot, builds and tests. "Installed" here means the entry or a triage file says the code is in a build; I did not read the installed DLL's version string.
5. **Code checks made:** only for BUG-030, 089, 091, 092 and BUG-027 (by reading the entry). The other classes rest on the entry text, the later Status lines and the triage files.
6. **Entry scope:** the Round 5 and Round 6 tables sit inside BUG-042's block and BUG-087's neighbours. I counted only the `## BUG-` headings, as asked, so those table rows were not classed separately.
