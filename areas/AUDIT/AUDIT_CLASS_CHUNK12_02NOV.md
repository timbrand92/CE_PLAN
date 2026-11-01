# Carpark audit, chunk 12 of 21: BUG-495 to BUG-554 (60 entries)

Written Mon 2 Nov 2026, Melbourne time, by Sonnet (Team), read-only. Nothing was built, tested, installed or opened in AutoCAD. Only this file was written.

## FOR TIM

1. **Counts per class:** FIXABLE-NOW 7, NEEDS-TIM 12, DUPLICATE 1, ALREADY-FIXED 16, HAS-DRAFT 3, INSTALLED-WAITING-PROOF 16, CLOSED-OR-WONT-FIX 0, UNCLEAR 5. Total 60.
2. **Only two FIXABLE-NOW items are pilot-critical:** BUG-497 (Create Schedule makes every table one row too short) and BUG-498 (refreshing a schedule keeps erased braces and piers).
3. **Next three FIXABLE-NOW, not pilot-critical:** BUG-501 (C1/C2 ignore the floor), BUG-502 (made-up sub-floor sizes), BUG-503 (the four small items left over).
4. **Correction to a note in the carpark:** BUG-495 (Publish Issue stamps every sheet) is marked "probably still there" on the Structural line. But commit ee1fdecd (9 Oct, "Publish Issue stamps the new revision only on sheets in the issue") IS on that line. It only touches the Drawing Sheets window, not the Sheets Manager window or the preview. Filed as UNCLEAR.
5. **Pilot-critical items waiting on you:** BUG-496 (where the job record lives), BUG-499 (how bracing is totalled), BUG-505 (units rule), BUG-517 (exact colours), BUG-553 (Python download), BUG-554 (WebView2 download).
6. **Not proven:** nothing here was seen in AutoCAD by me. "Already fixed" and "installed" mean the code or a carpark line says so.

---

## Entries

1. BUG-495 | UNCLEAR | pilot-critical yes | Fix ee1fdecd is on the Structural train (rel-20261026s), not on the Civil line; it covers the Drawing Sheets window only, and the Sheets Manager window and the preview-before-plot are untouched; carpark note says "probably still there", which this contradicts; needs a read of CeSheetsManagerWindow plus the S31 Codex look.
2. BUG-496 | NEEDS-TIM | pilot-critical yes | Job record is saved per PC; the entry itself says "Tim's call which" (travel with the drawing or with the job folder).
3. BUG-497 | FIXABLE-NOW | pilot-critical yes | ScheduleService.cs on rel-20261026s still sizes bracing and pier tables "count + 1" while items start at row 2; the fix is "count + 2", no judgement needed.
4. BUG-498 | FIXABLE-NOW | pilot-critical yes | No commit found; refresh never clears leftover rows (tie-down already does); a schedule that overstates bracing is the dangerous direction.
5. BUG-499 | NEEDS-TIM | pilot-critical yes | Codex confirmed roof trusses (BT1) count in the wall total; the entry says how A and B lengths combine against required is Tim's engineering call (BUG-950 only covers differing types).
6. BUG-500 | NEEDS-TIM | pilot-critical no | Required bracing is stored per PC; the fix depends on Tim's choice on BUG-496 (one job-record fix covers 496, 500, 533).
7. BUG-501 | FIXABLE-NOW | pilot-critical no | C1/C2 take the first schedule row by mark; right result (ask which size, say which floor) is stated; no commit found.
8. BUG-502 | FIXABLE-NOW | pilot-critical no | CSSUBFLOORGRID still carries "150x50 F17" and "90x90 F17" defaults in UserSettings.cs on the Structural line; right result is "no default, blank shows Unknown" (R-00); typed command only.
9. BUG-503 | FIXABLE-NOW | pilot-critical no | Seven small items; S-13 (PR #1792) and S-15 (PR #1796) are merged on the Structural train, S-11 became BUG-504; S-09, S-10, S-12 and S-14 have no commit and each states the right result.
10. BUG-504 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 8a1aec7c on the Structural train (carpark: PR #1272, Structural 1.0.121); Codex reproduced the blank-class fault on 1.0.116, nobody has re-driven it since.
11. BUG-505 | NEEDS-TIM | pilot-critical yes | Still fails in real AutoCAD (Codex V3b-04, V8-01); draft PR #1926 (scale sentence) and merged #1853 (no-units note) are partial; the units rule (drawing UNITS versus CE's size guess) is with CE 04 for Tim.
12. BUG-506 | ALREADY-FIXED | pilot-critical yes | Commit 3112aa54 "HUNT2-C-02: connection pipe grade printed as 1:N, not 1:0" on rel-20261102a; not yet seen in AutoCAD.
13. BUG-507 | ALREADY-FIXED | pilot-critical no | Commit 4d3a07f5 (Boyd's starts blank) and merge of #1257 (window warning) on the Civil line; the Codex "Unknown shown as zero" remainder is not re-checked.
14. BUG-508 | ALREADY-FIXED | pilot-critical no | Commit 555374da (flows use the job curve, sentence plus Settings value) is on rel-20261102a but the switch ships OFF, so default behaviour is unchanged until it is turned on.
15. BUG-509 | ALREADY-FIXED | pilot-critical no | Commit 9793b9e7 "summary prints the before-development C used" on rel-20261102a.
16. BUG-510 | ALREADY-FIXED | pilot-critical no | Commit 2b95a21e (hard-ground C in Settings) and b780b732 (CDCALC Boyd's uses it) on rel-20261102a.
17. BUG-511 | ALREADY-FIXED | pilot-critical no | Commit 6ae16dde "CDDESIGN detention pipe limits read the Settings figures CDRULES checks" on rel-20261102a.
18. BUG-512 | ALREADY-FIXED | pilot-critical no | Commit ae64971a (HUNT2-C-08/09: LandXML placeholders marked and listed); LandXmlParser.cs now carries placeholder markers for 375 mm and 600 x 600.
19. BUG-513 | ALREADY-FIXED | pilot-critical no | Same commit ae64971a ("sump level not the invert").
20. BUG-514 | ALREADY-FIXED | pilot-critical no | Commit 499b97c8; RulebookEngine.cs now only warns when roughness.IsAssumed.
21. BUG-515 | ALREADY-FIXED | pilot-critical no | Commit 6ab18018 (storm-still-rising sentence, CDCALC and CDDESIGN) plus merged #1257 (window shows the warning); needs the Codex retest.
22. BUG-516 | ALREADY-FIXED | pilot-critical no | Status already FIXED (Codex-accepted, V2b V2-03); (a) by 380020a2 (switch OFF) and (c) by 372541b4; sub-item (d) LandXML size units has no commit found.
23. BUG-517 | NEEDS-TIM | pilot-critical yes | Part (g) done (5396cf9c, black printed sheet); the rest (four theme files, help, ribbon icons) needs Tim to pick the exact charcoal, gold and soft-grey colours; Codex W2 FAIL on build 3.0.87.
24. BUG-518 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 8d11531c; carpark says installed in Civil 3.0.70 / Manager 1.1.70 via PR #1297, not tested by robot or Codex.
25. BUG-519 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit ec7ef8a0 (one plain start-up line) is on the Structural train, so it is in 1.0.125; carpark status line not updated.
26. BUG-520 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed in Structural 1.0.121 via PR #1312; commit d4c9ef30 covers part (c); Civil rows (a)(b) and lintel override not confirmed.
27. BUG-521 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed 3.0.70 via PR #1222; commit 0bdbd536 says "display half", switch OFF, needs Opus review.
28. BUG-522 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit d2af210f; run 40 PASS for the equal-copies case only, the mismatch case is unproven.
29. BUG-523 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PR #1307; commit af6a9d14 covers the Civil half of 1.11; Structural and Manager halves unconfirmed.
30. BUG-524 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PR #1310; commits 42716215, 3962334d cover Civil titles; Structural ribbon labels (2.4) unconfirmed.
31. BUG-525 | NEEDS-TIM | pilot-critical no | The entry says to ask Tim with a picture about the water line (3.2) and the snap glow (3.14); the rest depends on the BUG-517 colours.
32. BUG-526 | UNCLEAR | pilot-critical no | Tim said "7yes" (five groups that print on drawings first) but the five group names are not written in the entry; draft card job z4 queued.
33. BUG-527 | UNCLEAR | pilot-critical no | Item 5.2 (pipe speed) merged as #1822 (bea97ec2); items 5.3 (fall-back numbers) and 5.4 (two job timers) have no commit found, so the entry is part fixed.
34. BUG-528 | FIXABLE-NOW | pilot-critical no | 6.3 is a one-line comment fix and 6.2 is a package version alignment for the 2022-2024 lane; no commit found.
35. BUG-529 | INSTALLED-WAITING-PROOF | pilot-critical no | Evidence note: all three refusals now warn and carry on on the Structural train (204dfad2 = 1.0.125) behind switches; but Tim's two Rebar switches were found True after the 30 Oct incident (BUG-1257).
36. BUG-530 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge of PR #1793 (b1fcf22f) on the Structural train, unknown-pad-size warning ON; the Settings box for the offered size was not confirmed.
37. BUG-531 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed 1.0.121 via PR #1496; scoped to EBT and the label helper; the other 22 places and tie-down, pit and pier labels not confirmed.
38. BUG-532 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PR #1227; commit 6d903f98 covers the joist layer only; the four double-ups still need Tim to say which layer name is right.
39. BUG-533 | DUPLICATE-OF-BUG-500 | pilot-critical no | Entry says "same fault as BUG-500", fix together with 500 and 496, "do not fix it separately"; Tim said "8talk later".
40. BUG-534 | NEEDS-TIM | pilot-critical no | Entry says "Tim to rule on editions" for five standards tables (AS 3600, AS/NZS 4671, AS 2870, AS 1684.2, AS 4055).
41. BUG-535 | HAS-DRAFT | pilot-critical no | Draft PR #1910 (B-089) shows footing widths and brace lengths on CESETTINGS; the rest is parked by Tim ("8talk later").
42. BUG-536 | HAS-DRAFT | pilot-critical no | Draft PR #1911 (B-090) wires CSLOADPATH; SCREWPILE, REBAR and beam shorten already read Settings on the train; schedule and label sizes parked by Tim.
43. BUG-537 | NEEDS-TIM | pilot-critical no | Entry says to go through the list with Tim's command cards and mark each "drafter changes this" or "internal" before adding rows.
44. BUG-538 | NEEDS-TIM | pilot-critical no | Entry says Tim's word is needed on each council source and edition; partly built (a405ea64 reuse credits, 472cf28e pump settings) with today's numbers as defaults.
45. BUG-539 | ALREADY-FIXED | pilot-critical no | Commit 2b95a21e (hard-ground C in Settings) is read by CDDESIGN; the other tabs (Rational, Charged system, Detention Design 0.85, WSUD) not checked.
46. BUG-540 | ALREADY-FIXED | pilot-critical no | Commits 8729ae8e and ab44939c (step irons 900 mm office-wide); the after-command refresh remainder was split off as BUG-785.
47. BUG-541 | ALREADY-FIXED | pilot-critical no | Merge of PR #1786 (597f05de) and PR #1824 (3e3478ac) on rel-20261102a; the source of each fall is still Tim's word.
48. BUG-542 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit bdc70c03; carpark: installed via PR #1218, switch OFF, not tested by robot or Codex.
49. BUG-543 | ALREADY-FIXED | pilot-critical no | Merge of #1825 (1e741585) tests the Detention tab's council-coefficient switch on rel-20261102a.
50. BUG-544 | INSTALLED-WAITING-PROOF | pilot-critical no | Carpark: installed via PRs #1223 and #1224; commits 0018b393, 03913e47 cover items 21, 29, 30 behind switches OFF.
51. BUG-545 | ALREADY-FIXED | pilot-critical no | Merge of #1823 (pit drop warning, 04687536) and #1785, plus the freeboard fix from BUG-516 (b).
52. BUG-546 | FIXABLE-NOW | pilot-critical no | No commit found; the entry lists the keys and labels for a Codex window-row job, no engineering value is needed.
53. BUG-547 | UNCLEAR | pilot-critical no | Grouped list of about 30 values; only merge #1819 (2785f072) appears; needs a per-item split before a builder can take it.
54. BUG-548 | NEEDS-TIM | pilot-critical no | The one MEDIUM waits on Tim's BUG-496 choice (lintel and schedule-placement values stored per PC); the seven LOWs are small but stay with the entry.
55. BUG-549 | INSTALLED-WAITING-PROOF | pilot-critical yes | Merge of PR #949 (d82424b9) on the Structural line; carpark: installed in 1.0.121; blocks colleague install until proven off by default.
56. BUG-550 | HAS-DRAFT | pilot-critical yes | PR #1794 (BUG-550/557 MarkupAI switch) was merged into train S-45 then reverted (8be5beec) after a Codex HOLD; the PR stays open for the next Structural train.
57. BUG-551 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 4b4f68b3 (Civil AI paths use CE's own connection only); carpark: installed via PRs #950, #951, #952.
58. BUG-552 | UNCLEAR | pilot-critical yes | Merge of PR #1225 (d06da987) covers part (a) Civil fault reports; (b) the diagnostics report, (c) Desktop zips and Structural drawing-name coding have no commit found.
59. BUG-553 | NEEDS-TIM | pilot-critical yes | "Tim's rules do not cover this"; the entry asks Tim to rule on turning the automatic pip install OFF versus shipping the packages.
60. BUG-554 | NEEDS-TIM | pilot-critical yes | The entry asks Tim to rule on signature check versus shipping the WebView2 installer; whether the scheduled-task update source honours signed approval is not established.

---

## What I could not verify

1. **GitHub PR state:** the `gh` command is not on the tool path here, so PR numbers come from commit messages and carpark notes. I did not check whether any PR is open, closed or merged beyond what git shows.
2. **Installed versions:** "installed" means the carpark line says so, or the commit is on the Structural train (rel-20261026s, head 204dfad2 = 1.0.125). I did not read any DLL version.
3. **Civil line install state:** commits found on rel-20261102a are not proven installed. Switches shipped OFF (BUG-508, BUG-542, BUG-544) change nothing until turned on.
4. **The ledger:** `ledger.json` has no BUG-495 to BUG-554 ids that I could match, so no robot PASS or FAIL was used beyond what the carpark entries quote.
5. **Entries that read as a group** (BUG-503, 516, 527, 539, 547, 552): the class is for the whole entry; the sub-items still open are named on the line.
6. **Nothing seen in AutoCAD:** no entry here was proven in AutoCAD by me.
