# Carpark audit, chunk 13 of 21 (entries 721 to 780)

Written by Sonnet (Team), read-only, Mon 2 Nov 2026, Melbourne time. Covers BUG-555 to BUG-566, BUG-569/568/567, BUG-583 to BUG-627 (60 headings, counted from the top of C:\CE_PLAN\BUG_CARPARK.md; the file order is 555 to 566, then 569, 568, 567, then 583 upward with 586, 587, 585 out of order).

## FOR TIM

1. **Counts:** 33 INSTALLED-WAITING-PROOF, 13 HAS-DRAFT, 5 UNCLEAR, 3 NEEDS-TIM, 3 CLOSED-OR-WONT-FIX, 2 DUPLICATE, 1 FIXABLE-NOW, 0 ALREADY-FIXED. Total 60.
2. **FIXABLE-NOW is nearly empty:** only BUG-609 (closed drawing leaves the old checklist showing), and it is not pilot-critical. Almost everything else already has code in an installed build or a draft PR.
3. **Biggest group is waiting for a look in AutoCAD:** 33 entries have the fix in the Civil (3.0.51 or later) or Structural (1.0.118 or later) line, but the carpark still says OPEN because nobody has driven them in AutoCAD.
4. **Pilot-critical drafts not yet in any build:** BUG-561 (Edit Pit swaps grate and solid sides, PR #987), BUG-625 (Level Update overwrites ordinary notes, PRs #1885 and #1879), BUG-593 and BUG-598 (calculation window, PR #1259, old base).
5. **Three need you:** BUG-557 (stop job logs falling back to a personal OneDrive?), BUG-558 (confirm Redo loss after a view change is AutoCAD's own behaviour), BUG-615 (approve the live-preview card for concrete hatch).
6. **Not proven by me:** nothing was run in AutoCAD, and the ledger could not be matched to bug numbers (see the end).

---

## Class list (one line per entry)

1. BUG-555 | INSTALLED-WAITING-PROOF | pilot-critical no | CDHELP web fallback off by default: commit c2febcd4 (PR #1167), in Civil since 3.0.75, entry says installed 3.0.70; no AutoCAD look recorded.
2. BUG-556 | INSTALLED-WAITING-PROOF | pilot-critical no | Dead Azure upload code deleted in commit 2c20c16d (PR #1169), in Civil since 3.0.63; nothing visible to drive, proof is a search of the built DLL.
3. BUG-557 | NEEDS-TIM | pilot-critical no | Route 8 heartbeat switch is built (commit f835aafe, PR #1171) but route 12 (Structural time log falls back to the first OneDrive folder) is still in the code (SettingsManager.cs line 228); Tim to rule: remove the personal-OneDrive fallback?
4. BUG-558 | NEEDS-TIM | pilot-critical no | Entry's own final status says AutoCAD native behaviour (vanilla AutoCAD loses Redo after a view change); Tim to confirm; help-line commit a904d468 is in.
5. BUG-559 | UNCLEAR | pilot-critical no | CDIMPORTXCIVIL short P8 pipe explanation line missing; cause unknown, no commit, no PR; needs a re-run and a code read of the 3.0.41 path.
6. BUG-560 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 2f3f4df6 (CD binds CE's record before picking, Civil 3.0.50, PR #1244) matches hypothesis 2; the click-based cause was never proven, so confirm with a clicked pick on a second-opened drawing.
7. BUG-561 | HAS-DRAFT | pilot-critical yes | Fix commit e54b0aa5 is only on branch bug561-detention-sides (draft PR #987), not in the latest Civil line; entry warns the 30-degree square-to-0 case must also be tested.
8. BUG-562 | DUPLICATE-OF-BUG-435 | pilot-critical no | Entry's own last Status line says duplicate of BUG-435 (stale menus in Tim's acad.cuix), closed on Tim's yes, decision 178.
9. BUG-563 | HAS-DRAFT | pilot-critical no | Wording fix rides in draft PR #989 (with BUG-560); current code shows the dash in the window text, but I did not confirm the command-line text.
10. BUG-564 | DUPLICATE-OF-BUG-469 | pilot-critical no | Entry's own last Status line says duplicate of BUG-469 (FEDIT Esc leaves an undo step), closed on decision 178.
11. BUG-565 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 0c0c5153 (PR #1090) in Civil since 3.0.49; Codex W59b PASS on 3.0.48 recorded in the entry; Tim has not confirmed; the Edit Pit add-a-label case still fails late.
12. BUG-566 | HAS-DRAFT | pilot-critical no | Structural line still sets MENUBAR to 1 unchecked (CuiMenuGeneratorService.cs line 1419); fix is draft PR #1245 with a switch.
13. BUG-567 | CLOSED-OR-WONT-FIX | pilot-critical no | Test-only; entry's last Status says WONT FIX, closed on decision 178.
14. BUG-568 | CLOSED-OR-WONT-FIX | pilot-critical no | Test-only; entry's last Status says WONT FIX, closed on decision 178.
15. BUG-569 | CLOSED-OR-WONT-FIX | pilot-critical no | Test-guard only; entry's last Status says WONT FIX, closed on decision 178.
16. BUG-583 | INSTALLED-WAITING-PROOF | pilot-critical no | ABS on a locked layer: commit 30e0270a (PR #1264) in Structural since 1.0.118; mixed-selection case never tested.
17. BUG-584 | INSTALLED-WAITING-PROOF | pilot-critical no | R1/FJ1/P1 now say when the block did not take the span: commit 0629b5fd, Structural 1.0.118 (entry says installed 1.0.121, PR #1295); it discloses the failure but the block width cause is not fixed, so the entry may need to stay open.
18. BUG-585 | INSTALLED-WAITING-PROOF | pilot-critical no | Esc at purlin lap question: commit 8e87d666 (PR #1270), Structural since 1.0.118; no AutoCAD look recorded.
19. BUG-586 | INSTALLED-WAITING-PROOF | pilot-critical yes | Custom Pit Schedule note kept beside With Step Irons: commits b27c49d2 and 13a77f38 (PR #1286), Civil since 3.0.51; no AutoCAD look recorded.
20. BUG-587 | HAS-DRAFT | pilot-critical no | Pit Schedule row grows to fit long notes: draft PR #1881 (B-028); not in the Civil line.
21. BUG-588 | INSTALLED-WAITING-PROOF | pilot-critical no | CDCHECK saved list includes away FALL arrows: commit 48f3480a (PR #1271), Civil since 3.0.51.
22. BUG-589 | INSTALLED-WAITING-PROOF | pilot-critical yes | First CDCHECK after reopening reads the saved pit list: commit 9c2e3d50 (PR #1266), Civil since 3.0.51; HIGH in the entry.
23. BUG-590 | INSTALLED-WAITING-PROOF | pilot-critical no | Issue state on every printed page and Excel tab: commit 4b741083 (PR #1281), Civil since 3.0.51.
24. BUG-591 | INSTALLED-WAITING-PROOF | pilot-critical no | Excel numbers saved as numbers: commit 558d7666 (with PR #1281), Civil since 3.0.51.
25. BUG-592 | INSTALLED-WAITING-PROOF | pilot-critical yes | Pipe Flows shows Unknown not 0.00: commit 7553cea9 (PR #1274), Civil since 3.0.51; entry says installed 3.0.70.
26. BUG-593 | HAS-DRAFT | pilot-critical yes | Catchment stale flow after invalid rainfall: window fix in draft PR #1259 (old base rel-20261010b); no merged commit found; export side not integrated.
27. BUG-594 | INSTALLED-WAITING-PROOF | pilot-critical yes | Blue Factor rating report reader: commit be7827b8 (PR #1277), Civil since 3.0.51; HIGH in the entry.
28. BUG-595 | UNCLEAR | pilot-critical no | AutoCAD session would not close after the report-pick window; cause unproven, no commit; fresh-session workaround only.
29. BUG-596 | HAS-DRAFT | pilot-critical no | Whole-pipe loss labelled m/m: one-word label change in draft PR #1259; no merged commit found.
30. BUG-597 | INSTALLED-WAITING-PROOF | pilot-critical yes | Charged System shows Unknown for missing inputs: commit cfd179ea (PR #1275), Civil since 3.0.51.
31. BUG-598 | HAS-DRAFT | pilot-critical yes | Typed area still labelled Rating report: draft PR #1259 only; no merged commit found.
32. BUG-599 | INSTALLED-WAITING-PROOF | pilot-critical no | CDPROFILE names the missing DASHDOT2 before Apply: commit d95f2f55 (PR #1284), Civil since 3.0.51.
33. BUG-600 | INSTALLED-WAITING-PROOF | pilot-critical no | Long section title clears the scale note: commit c9509bda (PR #1291), Civil since 3.0.51.
34. BUG-601 | INSTALLED-WAITING-PROOF | pilot-critical no | Section update redraws without REGEN: commit 365c287e (PR #1290), Civil since 3.0.51.
35. BUG-602 | INSTALLED-WAITING-PROOF | pilot-critical no | LandXML that reads nothing now says so: commit f6389f40 (PR #1276), Civil since 3.0.51.
36. BUG-603 | INSTALLED-WAITING-PROOF | pilot-critical yes | LandXML Read source no longer writes: commit 2c490bca (PR #1308) plus ad6e7f9e, Civil since 3.0.51; HIGH in the entry.
37. BUG-604 | INSTALLED-WAITING-PROOF | pilot-critical no | LandXML results name their source: commit f6389f40 (same PR #1276), Civil since 3.0.51; later commits are tests only.
38. BUG-605 | INSTALLED-WAITING-PROOF | pilot-critical yes | LandXML inverts kept: commits f6389f40 and 8a54cef0 (PR #1276), Civil since 3.0.51; entry says installed 3.0.70, robot or Codex observation PASS noted in the carpark text.
39. BUG-606 | INSTALLED-WAITING-PROOF | pilot-critical no | CDCHECKDWG report goes to the CE report folder: commit 2b159615 (PR #1280), Civil since 3.0.51.
40. BUG-607 | INSTALLED-WAITING-PROOF | pilot-critical no | Comparison no longer says overall 100% with missing assets: commit c7dd9cda (PR #1279), Civil since 3.0.51.
41. BUG-608 | HAS-DRAFT | pilot-critical no | N/A on a checklist item asks why: draft PR #1606 (stacked on #1605); not in the Structural line.
42. BUG-609 | FIXABLE-NOW | pilot-critical no | Clear the checklist display when the last drawing closes; only a tests-only draft (PR #1260) exists, no design question open.
43. BUG-610 | INSTALLED-WAITING-PROOF | pilot-critical yes | Checklist survives N/A then Undo: commit eb7e41e0 (PR #1605), Structural since 1.0.124; HIGH in the entry.
44. BUG-611 | INSTALLED-WAITING-PROOF | pilot-critical no | Timber preview wording: commit 0bae4ef8 (PR #1262) is in the Structural line (checked); entry's own note says it needs a Codex look in AutoCAD.
45. BUG-612 | UNCLEAR | pilot-critical no | SBEAMEDIT cannot read a fresh 200PFC; commit 65a1f723 only names the real cause, the root cause was never found; needs a diagnosis run.
46. BUG-613 | HAS-DRAFT | pilot-critical no | Part-move warning in draft PR #1931 (Tim decision 158); full grouping (card ST-08) is after the pilot.
47. BUG-614 | INSTALLED-WAITING-PROOF | pilot-critical no | Hatches follow any scale: commit cfaa62ca (PR #1278), Structural since 1.0.118; Codex look 18 Oct saw no refusal at 1:50 on typed routes only, window route unlooked.
48. BUG-615 | NEEDS-TIM | pilot-critical no | Tim decision 166: command card first; Tim must approve the live-preview and Apply card before code (card queued, job z4).
49. BUG-616 | HAS-DRAFT | pilot-critical no | XRL waits for Apply: draft PR #1901 (B-080); not in the Structural line.
50. BUG-617 | INSTALLED-WAITING-PROOF | pilot-critical no | XRL names a locked layer before creating anything: commit e877b453 (PR #1287), Structural since 1.0.118.
51. BUG-618 | UNCLEAR | pilot-critical no | CXREF eInvalidKey; commit 65a1f723 only names the failing step, the copy still fails by the entry; needs a diagnosis run.
52. BUG-619 | INSTALLED-WAITING-PROOF | pilot-critical no | CEHATCHAUDIT and CEHATCHCHANGE read hatches outside the transaction: commit 670da629 (PR #1265), Structural since 1.0.118.
53. BUG-620 | INSTALLED-WAITING-PROOF | pilot-critical no | FASTSAVE only saves unless Settings FastSaveAlsoCleans is on: commit e877b453 (PR #1287), Structural since 1.0.118; I did not read the switch default.
54. BUG-621 | INSTALLED-WAITING-PROOF | pilot-critical yes | CE commands hand back colour, linetype, lineweight and dimension style: commits 1251b22f and 8a4bf682 (PR #1282), Structural since 1.0.118, switch default on.
55. BUG-622 | INSTALLED-WAITING-PROOF | pilot-critical no | MLL/MLR accept F: commits d5d64fd3 and dc7dfe19 (PR #1304), Structural since 1.0.118.
56. BUG-623 | UNCLEAR | pilot-critical no | Blank native text editor with Undefined shape; intermittent, font or style cause unproven, investigation entry; now seen in three places.
57. BUG-624 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit d5d64fd3 (PR #1304) reports a wrong-side note plainly; it may not move the note, so check the wrong-side placement itself.
58. BUG-625 | HAS-DRAFT | pilot-critical yes | Level Update only changes CE level marks: draft PRs #1885 and #1879 (B-065); not in the Structural line; HIGH in the entry.
59. BUG-626 | HAS-DRAFT | pilot-critical no | FFL Manual and Unknown with preview: draft PR #1933 (B-107); Tim decision 162 given.
60. BUG-627 | HAS-DRAFT | pilot-critical no | FFL triangle, tail and value move as one group: draft PR #1934 (B-108); Tim decision 163 given.

---

## What I could not verify

1. **Nothing was driven in AutoCAD.** Every "installed" claim means the fix commit is in the Civil or Structural line at the version shown (checked with git), not that it works on a drawing.
2. **Whether the installed bundle matches the line.** I did not read the installed DLL's version. I assumed Civil 3.0.70 or later and Structural 1.0.125 from the entries' own notes.
3. **The ledger (runner-reports\ledger.json) is keyed by robot case, not by bug number**, so I could not match robot results to bugs. Robot notes for 556, 557 and 605 exist only inside the carpark text.
4. **Partial fixes:** BUG-560, 584, 612, 618, 620 and 624 have commits that may only name the failure or add a switch, not remove the cause. I classed them by what the commit message says; the code was not read line by line.
5. **BUG-563:** I could not tell whether the command-line text now has its dash; the draft PR #989 is the named route.
6. **PR state:** every PR found is a draft, including ones whose commits are already in a train line (the drafts are the stacked originals). I used the train line, not the PR state, to decide "installed".
7. **Pilot-critical flags** are my reading of each entry's severity and how often a drafter hits the command; Tim's pilot list was not consulted.
8. **Housekeeping:** while checking, I briefly created two empty scratch files (chunk13_prs.json in C:\ce-fx and in my temp folder) by mistake and deleted both straight away. Nothing else outside this file was changed.
