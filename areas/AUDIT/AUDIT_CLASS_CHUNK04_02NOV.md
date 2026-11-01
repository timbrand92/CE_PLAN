# Carpark audit, chunk 4 of 21: entries 181 to 240 (BUG-673 to BUG-435)

Written Mon 2 Nov 2026 by Sonnet (Team, read-only). Read RULES.md first. Latest Civil/Manager line: origin/claude/rel-20261102a. Latest Structural line: origin/claude/rel-20261026s. Nothing was changed except this file.

## FOR TIM

1. **Counts (60 entries):** 35 INSTALLED-WAITING-PROOF, 11 ALREADY-FIXED, 5 NEEDS-TIM, 4 HAS-DRAFT, 2 UNCLEAR, 2 CLOSED-OR-WONT-FIX, 1 FIXABLE-NOW, 0 DUPLICATE.
2. **Plain meaning:** almost every entry in this block already has a fix built. What is missing is proof in your AutoCAD (or the robot plus Codex), not more building.
3. **FIXABLE-NOW (only one qualifies):** BUG-658 (Edit Pipe cascade question asked inside the open edit; low, not pilot-critical). The other four slots do not exist: nothing else in this block is a clean builder job with no ruling.
4. **Most pilot-critical, still needs a builder (not a tester):** BUG-668 (moving pits and pipes together puts callouts in the wrong place; only a blocked preparation draft, PR #1539, exists) and BUG-430 (double-click on a pit label opens AutoCAD's attribute editor, not Edit Pit; draft PR #1923 waits for Codex).
5. **Most pilot-critical, need your word:** BUG-417 (X-Civil import and locked layers: code now skips and says so, is that your answer?) and the pilot-critical proof list: BUG-652 to BUG-655 (levels written by Edit Pipe downstream), BUG-659, BUG-666, BUG-667.
6. **Not verified:** nothing was run in AutoCAD; "installed" comes from the carpark Status lines, not from reading the installed DLL; the ledger file was not opened for these entries.

## ENTRIES

1. BUG-673 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 5bc5a17b on the 02a line, installed in Civil 3.0.70 via PR #1332; no robot or Codex result.
2. BUG-672 | ALREADY-FIXED | pilot-critical no | Commit 6f7736c5 (PR #1831) on the 02a line makes the locked-layer copy line name only what is missing, which answers the 25 Oct runner finding; not installed yet and not proven.
3. BUG-671 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 6b57f96c, installed in Civil 3.0.70 via PR #1337; the runner case R34 only mentions it.
4. BUG-670 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 6b57f96c, installed in Civil 3.0.70 via PR #1337; no robot case.
5. BUG-669 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix a1320ec6, installed via PR #1334; no robot case.
6. BUG-668 | HAS-DRAFT | pilot-critical yes | DRAFT PR #1539 is preparation only and says it is blocked (the real fix is in LinkService, which the brief forbade); the complete fix is not written.
7. BUG-667 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 212ca77d, installed via PR #1336; no robot case (needs the headless harness for a test).
8. BUG-666 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix in PR #1328 (installed in Civil 3.0.70 per Status); robot case R34 mentions it but does not prove it.
9. BUG-665 | ALREADY-FIXED | pilot-critical yes | Commit 6f7736c5 (PR #1831) on the 02a line fixes the ROTATE/SCALE Copy gap the 25 Oct runner still saw, with the switches pinned ON; the installed 3.0.75 build still fails with the tick OFF, so not installed or proven there.
10. BUG-664 | ALREADY-FIXED | pilot-critical no | Merge edc3fb97 (PR #1682, fix 19f02107) is on the 02a line; the Status still reads OPEN with no note.
11. BUG-663 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix b675df6e, installed via PR #1331; no robot case.
12. BUG-662 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix e857dedb, installed via PR #1330; the command is hidden from the ribbon.
13. BUG-661 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 503faf55, installed via PR #1329; no robot case (needs a rotated UCS drawing).
14. BUG-660 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix c0525699, installed via PR #1333; no robot case.
15. BUG-659 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fixes 255338cd and 2f6cfca5, installed via PR #1322; wrong flow direction in the Pit Schedule, no robot case.
16. BUG-658 | FIXABLE-NOW | pilot-critical no | No fix or draft exists; Expected is clear (ask and apply after the edit commits, one Undo) and it names the code lines.
17. BUG-657 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 8caecdbf, installed via PR #1378; no robot case.
18. BUG-656 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 4019cc7e, installed via PR #1379; no robot case.
19. BUG-655 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 3373b6cd (BUG-652 to 655 together), installed via PR #1317; an engineering-level risk, no robot case.
20. BUG-654 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 3373b6cd and finalizer 1bd133b9, installed via PR #1317; an engineering-level risk, no robot case.
21. BUG-653 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix 3373b6cd and finalizer 1bd133b9, installed via PR #1317; an engineering-level risk, no robot case.
22. BUG-652 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fixes 3373b6cd and c14f04c8 (Opus review HIGH), installed via PR #1317; an engineering-level risk, no robot case.
23. BUG-651 | ALREADY-FIXED | pilot-critical no | Commit 2c35de86 (PR #1311, Esc at "Proceed with import?" cancels) is on the 02a line; the Status still reads OPEN.
24. BUG-582 | ALREADY-FIXED | pilot-critical no | Commit ea85e9ee ("New Pipe flow line uses the level it has already calculated") is on the 02a line; Status was never updated.
25. BUG-581 | UNCLEAR | pilot-critical no | Cause not proven (Manager hand-off to AutoCAD prompts is only a hypothesis) and the entry itself asks for a reviewed workflow card before repair.
26. BUG-580 | INSTALLED-WAITING-PROOF | pilot-critical no | Codex look L3-01c PASS on installed Manager 1.1.54 and 1.1.56 (Light header readable); draft PR #1255 is not on the 02a line, so the fix that did it is not named; left OPEN for the desk.
27. BUG-579 | HAS-DRAFT | pilot-critical no | DRAFT PR #1909 (B-088) keeps the typed depth on a new footing; the Undo/Redo part is not traced and nothing was opened in AutoCAD.
28. BUG-578 | HAS-DRAFT | pilot-critical no | DRAFT PR #1930 (B-104) names the footing PF1 everywhere, after Tim's decision 157; built and unit-tested only.
29. BUG-577 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix 65a1f723 on the 26s line, installed in Structural 1.0.121 via PR #1294; no robot case.
30. BUG-576 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #1261, installed in Structural 1.0.121 per the Status line; the 24 Oct triage disagrees, so the install is not confirmed.
31. BUG-575 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix c64fa0c0 on the 26s line, installed via PR #1273; no robot case.
32. BUG-574 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix da006db6 (same commit as BUG-650) on the 02a line, installed in Civil 3.0.70; no robot case.
33. BUG-573 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix caa1db83 (trailing zeros), installed via PR #1283; the later "actual placed values" extension is not shown fixed, and the native case SCHED-DIFF-02 still reads FAIL from 15 Oct.
34. BUG-572 | ALREADY-FIXED | pilot-critical no | Commit 6f0423d7 (Inspector pipe type from the recorded pipe) is on the 02a line; the first-selection "all Unknown" and heading parts of the entry are not shown fixed.
35. BUG-571 | INSTALLED-WAITING-PROOF | pilot-critical no | Fix d49e7026, installed via PR #1289; Codex case E9-02 was NOT TESTED (setup blocked).
36. BUG-570 | ALREADY-FIXED | pilot-critical no | Merge 01734d59 (PR #1693, fix ae1566c6, Edit Pit picture shows the typed number) is on the 02a line; Status still reads OPEN.
37. BUG-279 | INSTALLED-WAITING-PROOF | pilot-critical no | Items 0 to 2 fixed in PRs #471, #476, #480 (commit b9b30a46 on the 26s line); items 3 and 4 were never measured; mixed entry, needs splitting.
38. BUG-360 | INSTALLED-WAITING-PROOF | pilot-critical no | PRs #560 and #1296 installed, plus 5ce92c32 (no handle in the schedule footer); the plan-level, CDCATCHMENT and locked-layer wording extensions are not shown fixed.
39. BUG-367 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #568 and fix 8595a6d2 (layers made inside the undo) installed in Structural 1.0.121; driver run 10 confirmed the fault on 1.0.93 only.
40. BUG-371 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX on Tim's yes (decision 178, 31 Oct): finalizer LOW findings, a record not a fault.
41. BUG-394 | ALREADY-FIXED | pilot-critical no | Merge 9ba5d9f6 (PR #686, one shared helper for the doubled default text) is on the 26s line; Status still reads OPEN.
42. BUG-417 | NEEDS-TIM | pilot-critical yes | X-Civil import: should it skip locked layers and say so, or ask once with a preview (his question list item 13)? Code already skips and says so (7e097226, PR #765) but the carpark says his ruling is pending.
43. BUG-418 | ALREADY-FIXED | pilot-critical no | Merge 035256a7 (PR #764, ruled by Tim 7 Oct, INT-065) is on the 26s line; not yet proven in AutoCAD.
44. BUG-419 | NEEDS-TIM | pilot-critical no | A bundle of 49 audit findings; several need his numbers (built-in velocity, cover, grade, council values) typed into Settings rows.
45. BUG-420 | ALREADY-FIXED | pilot-critical no | Merge f86bfadd (PR #766, fix ad231728) is on the 02a line; the 3.0.33 FAIL predates it; later follow-up is BUG-426.
46. BUG-421 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (decision 178): not a CE fault, stray text came from Codex brief wording.
47. BUG-422 | ALREADY-FIXED | pilot-critical no | Merge 09e1ccd1 (PR #769, fix 58c70165: unknown ground level now says cover not checked) is on the 02a line.
48. BUG-423 | NEEDS-TIM | pilot-critical no | Three places still carry his real login or PC name (old report files kept, Manager report contents, support-bundle file names): keep or change? The LOWs were fixed by #774 (032e9f44).
49. BUG-424 | UNCLEAR | pilot-critical no | Bundle of seven items; items 4 and 5 are merged (5f62039b, bd4c5363) and item 6 is covered by BUG-575, but items 1 to 3 and 7 were not traced.
50. BUG-425 | INSTALLED-WAITING-PROOF | pilot-critical no | Fixes via PRs #783, #784, #811 and tests on the 02a line; the pilot does not use the Manager update channel, and the six Tim decisions listed are not shown as answered here.
51. BUG-426 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 93585d67 (PR #786) installed; no robot case.
52. BUG-427 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 9b234835 (PR #789, one shared FLAT label rule) installed; the Structural STRETCH-on-a-footing note was never investigated.
53. BUG-428 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 5beeb384 (PR #787) on the 26s line, installed in Structural 1.0.121; no robot case.
54. BUG-429 | NEEDS-TIM | pilot-critical no | Should an upgrade ever write new default rows into the settings file, or only when he changes a value? PR #799 only touched the start-up log line.
55. BUG-430 | HAS-DRAFT | pilot-critical yes | Installed but still fails (Codex look 19 Oct); DRAFT PR #1923 (B-110) stops the attribute editor first; the double-click feature stays OFF until Codex looks.
56. BUG-431 | NEEDS-TIM | pilot-critical no | Kingston rulebook: the file says "Issue 5, 2025, AS/NZS 3500.3:2021" but the council document on disk is Version 5 of Sept 2018 citing the 2015 edition; which is current needs checking against the source.
57. BUG-432 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 14253b67 (PR #820) and PR #809 installed; no robot case.
58. BUG-433 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge 3fa0dcdc (PR #808) on the 26s line, installed in Structural 1.0.121; no robot case.
59. BUG-434 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge b664bb2c (PR #810, layer comes back after C1/TS1 cancel) installed; no robot case.
60. BUG-435 | INSTALLED-WAITING-PROOF | pilot-critical no | Merge b2d8d14a (PR #826, Civil half) on the 02a line; the start-up "syntax error" line was never traced to its source.

## WHAT I COULD NOT VERIFY

1. **Not run in AutoCAD:** nothing here is proven on screen; I read carpark text, git history and open PRs only.
2. **"Installed" is taken from the carpark Status lines** (reconciled 23 Oct), not from reading the installed DLL.
3. **Ledger not read per entry:** I used the proof-lane list (areas\BUG_PROOF_LANES_31OCT.md) for what has a robot case; I did not open ledger.json.
4. **Draft state:** GitHub marks almost every PR here as draft, so a draft flag alone did not decide a class. I used HAS-DRAFT only where the Status line does not say the fix is installed or merged.
5. **ALREADY-FIXED means "the commit is on the 02a or 26s line", not "installed" or "proven".** Several of those (BUG-665, BUG-672) are newer than the installed build.
6. **Mixed entries** (BUG-279, 360, 424, 572 and 573) hold several findings; I gave one class, and the caveat is on the line.
