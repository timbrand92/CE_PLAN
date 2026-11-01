# Carpark audit, chunk 6 of 21: entries 301 to 360 (BUG-365 down to BUG-304)

Written Mon 2 Nov 2026 by Sonnet (Team, read only). Changed nothing except this file.
Read: the 60 entries in full (Symptom, Expected, last Status line, every Note), plus git history on origin/claude/rel-20261102a (Civil/Manager, head 3fbb9da5, Civil 3.0.88) and a few checks on origin/claude/rel-20261026s (Structural).
Not built, not tested, not run in AutoCAD.

## FOR TIM

1. **Counts:** 60 entries. INSTALLED-WAITING-PROOF 45, NEEDS-TIM 5, UNCLEAR 5, CLOSED-OR-WONT-FIX 4, DUPLICATE 1, FIXABLE-NOW 0, ALREADY-FIXED 0, HAS-DRAFT 0.
2. **Plain finding:** nothing in this chunk is a clean "builder can fix it now". Almost every entry already has its fix in the installed line (Civil 3.0.70 / Structural 1.0.121 per the entries). What is missing is a robot or Codex run in real AutoCAD, not code.
3. **Five most pilot-critical, still to be proved in AutoCAD (stand-ins, as there is no FIXABLE-NOW):** BUG-351 (Pit Schedule typed levels and pit renames), BUG-350 (Edit 2+ Pipes batch Apply), BUG-340 (batch Carry downstream and held-back labels, status line is stale), BUG-339 (batch Apply failure), BUG-334 (Structural: one U takes back the footing redraw, not your edit).
4. **Your questions in this chunk (5):** BUG-354 (delete the old start-up line from your own AutoCAD profile file?), BUG-338 (should CE draw true size in a real metre drawing?), BUG-321 (same metre question, label offsets), BUG-315 (schedule text height when DIMSCALE is 0), BUG-311 (cancelled CDRUNSOLVE also rolls back a palette edit: accept or make palette edits wait?).
5. **Housekeeping:** BUG-354 says "duplicate of BUG-402" and BUG-402 says "duplicate of BUG-354". BUG-402 is the closed one, so BUG-354 is the live entry; its status line is wrong. Five entries (340, 319, 320, 310, 304) have status lines nobody updated after fixes landed.
6. **Not verified:** see the last section.

## THE LIST

"IWP" below means INSTALLED-WAITING-PROOF.

1. BUG-365 | INSTALLED-WAITING-PROOF | pilot-critical no | Status says fix installed via PR #578-580; git has 11 BUG-365 commits (driver run 15 names); one leftover (Structural telemetry carries real UserName/MachineName, Civil anonymises) should be checked against the privacy rule.
2. BUG-364 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #561 installed; the raw-handle wording on first locked move is listed as fixed by the finalizer in a later entry; the CPU part is the driver, not CE.
3. BUG-363 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #561 installed; item 1 (old copy pit MOVE rewords the original's labels) already PASSED in real AutoCAD, driver run 14, nothing Tim-accepted; items 2 to 4 are LOW.
4. BUG-362 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #562, #563 inside Structural 1.0.114/1.0.121; item 2 (reo bar units) says "settle before CSREOBAR is un-hidden", a hidden command.
5. BUG-361 | CLOSED-OR-WONT-FIX | pilot-critical no | Two dumps and the Codex and driver CPU runs show the 1 core is the screen-reading client, not CE; the Status line still says OPEN, so a closing "not CE" needs Tim's yes like BUG-326 got.
6. BUG-359 | CLOSED-OR-WONT-FIX | pilot-critical no | Status says "closed as driver" (confirmed by the BUG-361 dump); only LOW side items remain.
7. BUG-358 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #558 (git: "ERASE + FREGENALL is two U") and the driver run 6 in BUG-364 shows two U passing; finding 2 (pipe left detached when pit layer locked) is an unanswered design question.
8. BUG-357 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #557; the driver run in BUG-364 shows the line printed and labels staying "1 IN 100" with the pipe layer locked; nothing Codex-accepted.
9. BUG-356 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #556, 6 git commits; What's New is modeless and first-launch only per BUG-364; the acceptance ledger still notes it opens at every robot start because of the settings guard.
10. BUG-355 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #555, #639; Structural line has "FEDIT on CE's outline edits the nearest footing" (fa79444f, bc636eea), decided by Tim INT-042.
11. BUG-354 | NEEDS-TIM | pilot-critical no | The fault is in Tim's own AutoCAD profile file (ce_suite_startup.lsp), not in the repo; question: may the old (ce:load-strucplus-lisp) call be removed from your profile, and do colleagues' PCs get the same clean-up at rollout?
12. BUG-353 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #577, #582, #589; git has the C-9 item 1 fix (78e254b2) and the ARRAY line fix (c4ba9b6c); LOW items 4 to 6 not individually checked.
13. BUG-352 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #553, #554; Structural line has items 1 and 3 (85ff8893, 50d7d27f); items 2, 4, 5 are speed notes.
14. BUG-351 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #660, #670, #805, 27 git commits; narrow connected-end write PASSED Codex 14 Oct, but the entry itself says it does not close 351 (C2 rename, unconnected end, ARRAY remain); Tim answered (a) and (b).
15. BUG-350 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #550, #551, 9 git commits (items 7 and 9 visible); items 8, 10, 11 (PIT scale in metre drawings, older-pipe prompts, tooling) are not confirmed fixed.
16. BUG-349 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #546 inside Structural 1.0.114; items 1 to 4 fixed, item 5 is a design note and item 6 LOWs stay open.
17. BUG-348 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #545 inside Structural 1.0.114; Tim's INT-026 ruling already met; open items are MED/LOW unit-detection edge cases.
18. BUG-347 | INSTALLED-WAITING-PROOF | pilot-critical no | Commit 5704b6ae; entry is mostly Codex blocks, and its ARRAY item is the BUG-342/350 family.
19. BUG-346 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #549, #591, #592, 6 git commits (copy-label fixes visible).
20. BUG-345 | CLOSED-OR-WONT-FIX | pilot-critical no | Status: WONT FIX test tooling, closed on Tim's yes 31 Oct (decision 178).
21. BUG-344 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #542, #547 inside Structural 1.0.114; Tim's INT-026 "Convert units automatically".
22. BUG-343 | INSTALLED-WAITING-PROOF | pilot-critical no | Status line was never updated (still "OPEN 2 Oct"), but git has the split-pipe grade lock fix (027a8b51), the Repair Center regroup (e8916136) and the flat-pipe repair (760aded0), all in PR #513/#508; items 2 and 3 not individually checked.
23. BUG-342 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #567 (quiet paste), 3 git commits, Tim said "PASTE - YEP" (INT-048); a later entry (BUG-403) found it failing into a Structural drawing, and items 2 to 6 are separate.
24. BUG-341 | INSTALLED-WAITING-PROOF | pilot-critical yes | Commit 1bf49237 in Structural 1.0.121; HIGH item is a corner grip turning a pad into a kite; nothing driven in AutoCAD.
25. BUG-340 | UNCLEAR | pilot-critical yes | Status says "items 1-6 (+9) to builder" and no PR is named; BUG-350's "passed" list shows the lowest-arrival Carry downstream, so some are fixed; needs a per-item read against C-7/C-8 commits before anyone builds.
26. BUG-339 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #538 (1 git commit); BUG-350's reviewer saw batch Apply working for most grades headless, no real-AutoCAD proof.
27. BUG-338 | NEEDS-TIM | pilot-critical no | Items 1 to 3 have fixes in git (027a8b51, 6bdde2c1); item 4 is marked "RULING FOR TIM": should CE draw true size in a real metre drawing (a DN300 pipe is a band 300 m wide today); all four office templates read mm, so the office is not hit.
28. BUG-337 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #508; metre drawing only, attribution unresolved by Codex.
29. BUG-336 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #523-525 inside Structural 1.0.114; items are Escape-undo, locked-outline wording, speed.
30. BUG-335 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #529-531; same family as BUG-334 and BUG-333, which carry the proof.
31. BUG-334 | INSTALLED-WAITING-PROOF | pilot-critical yes | PR #521, #522, #532; item 1 (one U takes back CE's redraw not the edit) was measured as one U in the 2027 core console, full AutoCAD not driven.
32. BUG-333 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #536, #539, #541; item 3 (LOADPATH in a metre drawing) says "Tim decides" measure nothing or convert.
33. BUG-332 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #512; LOW leftovers.
34. BUG-331 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #516, #646, 16 git commits covering items 1 to 5; metre drawings only.
35. BUG-330 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #627 merged (bab2dcaf); metre drawings only.
36. BUG-329 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #626; git has items 2 and 3 (4d78cd6f, 4f2430e3).
37. BUG-328 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #508, #513, 17 git commits (23fe830f and the repair); metre drawings only.
38. BUG-326 | CLOSED-OR-WONT-FIX | pilot-critical no | WONT FIX, AutoCAD's own fatal error from a Codex LAYER script, closed on Tim's yes 31 Oct.
39. BUG-325 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #507, 2 git commits; OOPS line wording.
40. BUG-324 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #507; BUG-339 says the older pipe is now left out with a plain line.
41. BUG-323 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #491, #507, 7 git commits; metre drawing display.
42. BUG-322 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #626; git has item 2 (4f2430e3); item 1 is metre-drawing label offsets.
43. BUG-321 | NEEDS-TIM | pilot-critical no | Status OPEN, no PR; label offsets in a metre drawing wait on the same true-size ruling as BUG-338 item 4 (the BUG-287 question); plus test-tooling leftovers that belong with BUG-318.
44. BUG-320 | UNCLEAR | pilot-critical no | Items 1 and 4 have fixes (PR #501 PasteCheck lines, PR #638); items 2 and 3 (CDREPAIR leaves the old pit number on a pasted label, wording of the locked-layer sentence) have no commit I could find and the status line was never updated.
45. BUG-319 | UNCLEAR | pilot-critical no | No PR named; commit 7f8e2249 (BUG-308) makes CDCALC's areas win, which may cover item 1; items 2 and 3 are hypothetical.
46. BUG-318 | INSTALLED-WAITING-PROOF | pilot-critical no | Test tooling; PR #644, #649, #677 named, and the Structural line's RibbonPresentationTests.cs now only writes to docs when CE_UPDATE_DOC_SCREENSHOTS=1 (I did not find the commit); proof is a clean git diff after a test run.
47. BUG-317 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #497, #502, 6 git commits; scaled pits in metre drawings.
48. BUG-316 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #504; Structural line has item 2 (c126f1df).
49. BUG-315 | NEEDS-TIM | pilot-critical no | Items 2 and 3 are fixed in the Structural line (d72c574a, e07e99b3); item 1 is still Tim's question: with DIMSCALE 0 and CANNOSCALE 1:1, keep the schedule text at 2.5 units or fall back to a 1:100 sheet height?
50. BUG-314 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #505 merged into train S-7 (bd920fbc); LOW footing-memory items.
51. BUG-313 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #503, 4 git commits; native locked-layer check still never run in a real drawing per BUG-322 item 4.
52. BUG-312 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #503; commit 7a47f825 keeps held-back labels in the drawing's CE record.
53. BUG-311 | NEEDS-TIM | pilot-critical no | Status OPEN, no PR; the entry itself says it needs Tim's decision: when CDRUNSOLVE/CDPROPAGATE is cancelled, accept that a palette edit made meanwhile is rolled back too, or make palette edits wait?
54. BUG-310 | UNCLEAR | pilot-critical no | The entry says "edge, not confirmed possible" (two objects sharing one identity key); needs a probe to show whether it can happen before anyone builds.
55. BUG-309 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #503; git 0a1271c8 labels the grade in the drawing's own units.
56. BUG-308 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #497, 5 git commits; items (b) pipe landing at pit centre and (d) which tabs carry Save Draft are still "check or Tim's ruling".
57. BUG-307 | DUPLICATE-OF-BUG-095 | pilot-critical no | Status says duplicate of BUG-095 (red Glen Eira back-test), closed on Tim's yes 31 Oct; the engineering cause is tracked under BUG-095/BUG-872.
58. BUG-306 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #501, #638 (git d4c78c61): pit placing leaves CD_Settings.json byte-identical; a W8-09 partial PASS is recorded in a later entry.
59. BUG-305 | INSTALLED-WAITING-PROOF | pilot-critical no | PR #501, 7 git commits (one [PasteCheck] summary per paste).
60. BUG-304 | UNCLEAR | pilot-critical no | Status OPEN 1 Oct and the entry's own correction says it is stale since S-4; what is missing is a check on AutoCAD 2024/2025/2026 (no 2024 on this PC) and real-window grip edits.

## WHAT I COULD NOT VERIFY

1. **"Installed" is taken from each entry's Status line** (Civil 3.0.70 / Manager 1.1.70 / Structural 1.0.121, reconciled 23 Oct). I did not read the installed bundle's DLL version or hash.
2. **No AutoCAD proof was read for most entries.** The ledger file areas\runner-reports\ledger.json contains no BUG-30x to 36x ids at all; the Claude acceptance ledger of 24 Oct mentions only BUG-356. So no entry here has a ledger-accepted FIXED.
3. **Pull requests:** the gh command is not available on this machine, so I could not check PR state, drafts or merge status. PR numbers come from the entries and from commit messages; "HAS-DRAFT" could not be tested for any entry.
4. **Git checks:** the grep on the Civil/Manager line (origin/claude/rel-20261102a) covers every id. On the Structural line (origin/claude/rel-20261026s) I only grepped a subset of ids, so Structural entries may have more commits than I saw. I matched commit subjects to items, not code to items.
5. **One search was still running when I finished** (when the Structural ribbon-picture opt-in first appeared); BUG-318 is classified without it.
6. **Per-item reading:** for multi-item entries I gave one class for the whole entry. A single class hides leftovers; the notes on each line name the main ones, but I did not check every LOW item against code.
7. **"Pilot-critical yes"** is my judgement: HIGH-risk items in everyday drainage editing or footing undo. I do not know the exact pilot scope, so treat it as a flag, not a ruling.
