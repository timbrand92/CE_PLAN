# Carpark audit, chunk 5 of 21: entries 241 to 300 (Mon 2 Nov 2026, Melbourne time)

Read-only. Nothing was changed except this file. Entries are the 60 headings from BUG-436 (line 3350) down to BUG-366 (line 3959) of C:\CE_PLAN\BUG_CARPARK.md. The file has 1,218 headings now; I went by heading id.

## FOR TIM

1. **Counts:** 26 installed and waiting for proof, 14 already fixed in the code, 9 closed or won't fix, 5 unclear, 3 need Tim, 2 duplicates, 1 fixable now, 0 with a draft.
2. **Only one entry is fixable now:** BUG-396 (double-click on a placed Pit Schedule cell opens AutoCAD's own text editor instead of the CE window; the design is already approved). It is pilot-critical.
3. **Needs Tim, pilot-critical:** BUG-411 (the F2 key runs the CE CLEAN command and rewrites the open drawing: keep it with a confirmation, or move it off F2?).
4. **Other needs Tim:** BUG-386 (typed cover level stays after "Stop overriding", or CE puts its own figure back?) and BUG-443 (wording of two switched-off floor setout lines).
5. **Biggest waiting-for-proof group (pilot-critical):** Undo/Redo items BUG-416, BUG-445, BUG-368; the import items BUG-440 and BUG-447; the paste line BUG-403 and BUG-366; the pit schedule rows BUG-385 and BUG-376.
6. **Paperwork gap:** BUG-385 and BUG-414 have a Codex PASS or a merged fix recorded elsewhere, but their own Status lines still say OPEN.

## Key for the classes

- INSTALLED-WAITING-PROOF means: the fix is merged on the release line (or the entry says it is installed) and no Codex-accepted PASS is written on the entry. I did not check which build is installed on each PC.
- ALREADY-FIXED means a commit or PR exists on the release line that does what the entry asks. It is NOT "FIXED" in the carpark sense (that still needs robot plus Codex PASS, or Tim's word).

## The 60 entries

1. BUG-436 | DUPLICATE-OF-BUG-061 | pilot-critical no | Status line already says duplicate of BUG-061 (a Codex result record), closed on Tim's yes 31 Oct.
2. BUG-437 | INSTALLED-WAITING-PROOF | pilot-critical yes | C1/TS1 "Enter means auto" fixed by PR #812 (merge c1c4cf81, Structural line) and the layer fix by #810; Codex W31 saw #810 pass, the Enter part not yet re-tested. The start-up "Menu item failed to load" lines are a separate profile problem, not fixed here.
3. BUG-438 | INSTALLED-WAITING-PROOF | pilot-critical yes | "DefaultValue is not set" fixed by PR #815 plus the finalizer commit 1fd75ab6; Codex W39 (the proof) is not written on the entry.
4. BUG-439 | INSTALLED-WAITING-PROOF | pilot-critical no | Two MEDIUMs fixed in 37a99f27 and installed (Structural 1.0.121, #798); the 350 mm lintel tolerance is a Settings value Tim was asked to confirm; a LOW wording fix 74a1f2d3 sits on a side branch awaiting review.
5. BUG-440 | INSTALLED-WAITING-PROOF | pilot-critical yes | Zero-length pipe on import fixed by PR #814 (commits 9c89763c, 36758ff0); Codex W38 saw it work on 3.0.39 but it is not Codex-accepted on the entry. Tim's AutoCAD template path pointing at a bisect test copy needs Tim or the desk (not CE code).
6. BUG-441 | INSTALLED-WAITING-PROOF | pilot-critical no | Finalizer record; fixes #794/#796 installed; "Roll Back" must not be offered to colleagues until one PC proves it, which is not proven.
7. BUG-442 | INSTALLED-WAITING-PROOF | pilot-critical yes | Support zip (856 bytes, one file) fixed by PR #816 and the FLAT window by #819 (merges 51353ad2, 793f0d8b); no AutoCAD retest recorded.
8. BUG-443 | NEEDS-TIM | pilot-critical no | Question for Tim: is the floor arrow order "Joists/Bearers/Subfloor" right, and is "DENOTES POST UNDER" the legend wording he wants? The feature is switched off and hidden.
9. BUG-444 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (finalizer LOW record), closed on Tim's yes 31 Oct; the rebuilt marker is tracked in BUG-445.
10. BUG-445 | INSTALLED-WAITING-PROOF | pilot-critical yes | Codex W35 and W36 PASS the one-U, 12-second wait, REDO case, but it is not recorded as Codex-accepted on the entry; "typed level waits for Stop overriding" is already Tim's ruling (9 Oct).
11. BUG-446 | INSTALLED-WAITING-PROOF | pilot-critical no | Stale red marker after Edit Pipe Save fixed by PR #823 (merge 800cab61); no AutoCAD retest. The 79 missing log lines are unexplained.
12. BUG-447 | INSTALLED-WAITING-PROOF | pilot-critical yes | Import keeps a short branch pipe open at its far end via PR #827 (merge 1a14029d, finalizer 319ba688); the real cure (the end-matching step) still needs its own reviewed change.
13. BUG-448 | INSTALLED-WAITING-PROOF | pilot-critical yes | Column label fix is commit 1fd75ab6, installed; Codex W39 not recorded. One side question (should Esc at "Enter a number" remove the column?) is for Tim.
14. BUG-414 | ALREADY-FIXED | pilot-critical no | Edit Pit now refuses a rename onto an existing number: commit a2d765af, PR #758 (merge edaa82d9, labelled BUG-408b). The Status line still says OPEN.
15. BUG-415 | UNCLEAR | pilot-critical no | Missing: whether PR #758 or the BUG-351 follow-up already covers the bare "8" wording and the "C 2" warning (the entry says "fix with BUG-414"); needs one code read.
16. BUG-416 | INSTALLED-WAITING-PROOF | pilot-critical yes | Right-click "Select this run" losing REDO: PR #1502 merged into train C-57 (863828c1); never proven by Codex (V1 was FAIL UNSURE on 3.0.65).
17. BUG-413 | INSTALLED-WAITING-PROOF | pilot-critical no | Hashed machine-report file name merged (PR #745, merge 2e8b8f34); the "Tim's call on the name" part is answered by the build, so Tim only needs to confirm.
18. BUG-412 | UNCLEAR | pilot-critical no | Four observations from an old run (3.0.32), never retested; missing: a fresh run on the current build (unsaved-record line after Esc, CDRULES METRE-A grade check).
19. BUG-411 | NEEDS-TIM | pilot-critical yes | Question for Tim: keep F2 running CLEAN with a visible name and a confirmation, or move it off F2? (The Team also still has to find where F2 is bound.)
20. BUG-409 | CLOSED-OR-WONT-FIX | pilot-critical no | Test incident; Tim's Structural settings file was restored on 5 Oct (hash matches the original) and a rule was added to the test briefs.
21. BUG-410 | UNCLEAR | pilot-critical no | Old W11 observations (BTX with nothing found is silent, typing BEAM runs BEAMLINKDEBUG, and others); missing: a retest with a corrected brief. The _Dot message item belongs with BUG-400.
22. BUG-408 | INSTALLED-WAITING-PROOF | pilot-critical no | "Stop overriding" sentence now shown in the fixed footer: commit db03f411 on the release line; not retested.
23. BUG-405 | ALREADY-FIXED | pilot-critical no | Structural scrub of SourceRoot/StatusSummary is PR #748 (be36a4fc), the usage-report drawing name is PR #757, and the Civil file name is commit 31721cc5 (BUG-413).
24. BUG-406 | ALREADY-FIXED | pilot-critical no | Markup-plan length readers fixed by PR #1781 and #1820 (merge 1f4f2633); not reachable from a drafter's normal commands.
25. BUG-407 | ALREADY-FIXED | pilot-critical no | CSFDNPROPOSE registered and OwnList used: commit dd1a784b, PR #738 (hidden, switched off).
26. BUG-404 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (PC housekeeping, not a drafter command), closed on Tim's yes 31 Oct. Tim's own Windows Search setting is still his to change.
27. BUG-403 | INSTALLED-WAITING-PROOF | pilot-critical yes | Paste from a drainage drawing into a Structural drawing now prints the CDREPAIR line: PR #1782 and #1821 merged (5bcb1f65, d4f0a85c); no Codex PASS on the entry.
28. BUG-402 | DUPLICATE-OF-BUG-354 | pilot-critical no | Status line says duplicate of BUG-354 (same start-up line), closed on Tim's yes 31 Oct.
29. BUG-401 | CLOSED-OR-WONT-FIX | pilot-critical no | Tim decided 5 Oct (INT-059/060): New Pit cover stays blank after restart; a "propose last cover" switch exists, off by default (commit a9334dfd).
30. BUG-399 | UNCLEAR | pilot-critical no | Observation only; missing: a probe at a known pick point, and Tim's pick-tolerance value (the FEDIT edge-pick rule itself was decided in INT-042).
31. BUG-400 | INSTALLED-WAITING-PROOF | pilot-critical no | Duplicate _Dot message on pit placement: PR #671 merged (de9a2d57); Codex W10c saw none but did not certify it.
32. BUG-398 | ALREADY-FIXED | pilot-critical no | Preview and issue now share one revision/date decision: commit a730f2fb, test 94da56da (Structural line).
33. BUG-397 | INSTALLED-WAITING-PROOF | pilot-critical no | Manager load list fixed by PR #684 (merge 4120f03c); Codex W3-01 saw "3 of 3 tools running"; the "must match what is really loaded" check is not written down.
34. BUG-396 | FIXABLE-NOW | pilot-critical yes | Item 1: double-click on a placed schedule cell must open the Pit Schedule window at that cell (approved design); Codex L4-08 still saw AutoCAD's own editor on 3.0.56; no fix commit found. Item 6 is already fixed (PR #747).
35. BUG-395 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed on Tim's yes 31 Oct.
36. BUG-393 | ALREADY-FIXED | pilot-critical no | The four metre-length readers fixed by PR #659 and the remainder by #666 (0f07a2ec, 929b013b). BUG-406 covers a different four.
37. BUG-392 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed 31 Oct; its findings are tracked under their own ids.
38. BUG-391 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (desk driver run record), closed 31 Oct; its seven findings are meant to live under their own ids (I did not check each one has an entry).
39. BUG-390 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed 31 Oct.
40. BUG-389 | ALREADY-FIXED | pilot-critical no | CDCHECK list prints plain arrows: PR #634 (merge 507ca294). Status line still says OPEN.
41. BUG-388 | ALREADY-FIXED | pilot-critical no | Beam, FDELETE and related prompts show the default once: commits 1c2361fd and 8efbc89a (Structural line).
42. BUG-387 | ALREADY-FIXED | pilot-critical no | Current layer put back: PR #683 (merge 6637535e); driver run 22 did not reproduce it and Codex W10-03 saw the layer kept.
43. BUG-385 | INSTALLED-WAITING-PROOF | pilot-critical yes | Revert Row Override made a row vanish; fixed by PR #612/#617/#667 and Codex W6-02 and W7-03 saw PASS in AutoCAD (BUG-390, BUG-392), but the entry's own Status was never updated to Codex-accepted.
44. BUG-386 | NEEDS-TIM | pilot-critical no | Question for Tim: after "Stop overriding", does the typed cover level stay (recommended, and what is built) or does CE put its own figure back? CE 05 sent this to CE 04 on 1 Nov.
45. BUG-384 | ALREADY-FIXED | pilot-critical no | Status says FIXED (Claude-accepted, Civil 3.0.75, runner case R23); not Tim-confirmed.
46. BUG-383 | UNCLEAR | pilot-critical no | A fresh open marks the drawing changed; missing: a probe that finds which object or setting changes at open (cause unknown, LOW).
47. BUG-381 | ALREADY-FIXED | pilot-critical no | Opening and closing the Foundations manager no longer marks the drawing changed: PR #586 (d9149dc3), driver run 19 PASS. A leftover extra undo step is noted in BUG-391 item 4.
48. BUG-382 | ALREADY-FIXED | pilot-critical no | Structural plain-wording sweep: PR #597 (merge 5d692738).
49. BUG-380 | INSTALLED-WAITING-PROOF | pilot-critical yes | The pipe batch edit left Tim's snaps changed; fixed by e3ffe44b (PR #585, installed); the FEDIT edge pick is decided (INT-042), the other W3 notes are brief errors.
50. BUG-376 | INSTALLED-WAITING-PROOF | pilot-critical yes | Blank IL cells in the Pit Schedule now fall back to the plan level: dd307761 and 59aeb250 on the release line; no clean Codex PASS recorded.
51. BUG-377 | ALREADY-FIXED | pilot-critical no | Raw arrow code printed plain: commit 1a059b6d; driver run 22 saw CDRUNSOLVE plain.
52. BUG-378 | INSTALLED-WAITING-PROOF | pilot-critical no | First-open pipe upgrade race: PR #602 merged (32ef6d35); driver run 22 C4 PASS, no Codex PASS.
53. BUG-375 | ALREADY-FIXED | pilot-critical no | Item 1 (register and registry one list) is commit fac19d70; item 2 (an old runner brief file) is housekeeping I did not check.
54. BUG-374 | CLOSED-OR-WONT-FIX | pilot-critical no | Status WONT FIX (Codex run record), closed 31 Oct; the Edit Pipe Cancel finding lives in BUG-373.
55. BUG-373 | INSTALLED-WAITING-PROOF | pilot-critical no | Edit Pipe then Cancel no longer marks the drawing changed: PR #1663 (merge cd2cabb8); unnamed-control leftovers belong to the BUG-365 family.
56. BUG-372 | INSTALLED-WAITING-PROOF | pilot-critical no | Handle half passed on 3.0.57 (run 33) and PR #1835 merged; the "(on the block Drawing Border)" half is still seen and is tracked under BUG-141 and BUG-816.
57. BUG-370 | INSTALLED-WAITING-PROOF | pilot-critical no | Kind column plain English: PR #570 (merge 7b353319); undo counts all passed in driver run 11.
58. BUG-369 | INSTALLED-WAITING-PROOF | pilot-critical no | Frozen-layer plain line: PR #571 (merge af6eebf5); remaining notes are LOW.
59. BUG-368 | INSTALLED-WAITING-PROOF | pilot-critical yes | Extra Undo step inside typed Structural commands removed: PR #569 (merge 30c7c72b); driver run 11 saw one U work, no Codex-accepted entry.
60. BUG-366 | INSTALLED-WAITING-PROOF | pilot-critical yes | Quiet paste catcher is PR #567 (merge 0eff93d4); the CSREOBAR missing-layer fault fix is not confirmed by me (commit e2be93ab is about undo marks, not layers).

## What I could not verify

1. **GitHub:** the `gh` tool is not installed on this PC's shell paths, so I could not list open or draft PRs. That is why HAS-DRAFT is zero; some FIXABLE or UNCLEAR entries may have a draft I could not see.
2. **Installed builds:** I did not read which Civil, Manager or Structural build is installed on each PC, so INSTALLED-WAITING-PROOF means "merged on the release line", not "confirmed installed" (except where the entry itself says installed).
3. **Merge membership:** I searched commit messages for the entry id on origin/claude/rel-20261102a (Civil/Manager) and origin/claude/rel-20261026s (Structural). A fix committed without the id in its message would be missed (BUG-414 was only found through a different id, BUG-408b).
4. **Ledger:** C:\CE_PLAN\areas\runner-reports\ledger.json is keyed by case, not by bug, so it gave nothing for these entries.
5. **Not run:** no AutoCAD, no tests, no builds; all code claims come from commit messages, not from reading the changed code.
