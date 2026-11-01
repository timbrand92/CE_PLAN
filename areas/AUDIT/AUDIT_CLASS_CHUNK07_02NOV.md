# Carpark audit, chunk 7 of 21 (entries 361 to 420), Mon 2 Nov 2026, Melbourne time

Written by Sonnet (Team), read-only. Only this file was created. Nothing was built, tested, deployed or run in AutoCAD.

## FOR TIM

1. **Counts (60 entries):** 0 fixable-now, 2 needs-Tim, 2 duplicate, 1 already-fixed, 0 has-draft, 51 installed-waiting-proof, 4 unclear, 0 closed.
2. **Fixable now:** none. Every entry a builder could fix from the entry alone already has its fix built, and the carpark says it is installed in Civil 3.0.70 or Structural 1.0.121.
3. **Needs your word (2):** BUG-245 (pit to open end: when the drawn order and the levels disagree, which wins?) and BUG-249 (the Boyd's rainfall rows are still fixed numbers; they need a command card and your approval before anyone changes them).
4. **Most pilot-critical waiting on proof in AutoCAD:** BUG-260 and BUG-261 (wrong flow direction and false uphill warning on Edit Pipe), BUG-268 (pipes copied wrong stay wrong until the repair command runs), BUG-270 and BUG-287 (search reaches 1000 times out in metre drawings), BUG-254 (locked layers).
5. **Unclear (4):** BUG-300, BUG-295, BUG-283, BUG-280. Each line below says what is missing.
6. **Not verified:** the `gh` command is not on this PC's shell, so I could not list pull requests. Every PR and commit named comes from git history on the two release lines. Whether each fix is really in the installed DLL was not checked.

---

## What I read, built and tested

1. **Read:** all 60 entries (BUG-303 down to BUG-243, carpark lines 4694 to 5490), `git log` on `origin/claude/rel-20261102a` (3fbb9da5) and `origin/claude/rel-20261026s` for every id, the triage and tranche notes in `C:\CE_PLAN\areas`, and three code spot-checks on the 2 Nov Civil line.
2. **Built:** nothing. **Tested:** nothing. **Installed DLL version:** not read.
3. **Not proven:** that any fix works in AutoCAD. "Installed-waiting-proof" is taken from the carpark's own status line and the git commits, which match by id. I did not open the ledger entry for each id.
4. **Pilot-critical** is my judgement: a wrong level, wrong flow direction, wrong unit reach, a lost setting or a wrong figure on a calc sheet that a colleague could issue.

---

## The 60 entries

361. BUG-303 | INSTALLED-WAITING-PROOF | no | Several small items; commits 2e6d5e27 and 54be6df6 on the Structural line and PRs #494, #510 installed in 1.0.121; each item still needs checking against the PR.
362. BUG-302 | INSTALLED-WAITING-PROOF | no | Commit 2ead5192 (PR #495) makes the FADOPT label search 1.5 m in any unit; it says "code half", so the wording half (ruling not in decisions) is unchecked.
363. BUG-300 | UNCLEAR | no | Code redraws on the next footing command only; a tranche-3 batch (t3) waits on a robot check to see if OOPS needs its own redraw, and that result is not in the folder.
364. BUG-299 | INSTALLED-WAITING-PROOF | yes | Commit 93e3f3b0 (PR #493): an unfinished settings save is put back at start; a lost settings file would hit colleagues.
365. BUG-298 | INSTALLED-WAITING-PROOF | no | CDFIXPIPEENDS atomic repair is in commit 71980a7f (PR #490), though the carpark line still says OPEN.
366. BUG-297 | INSTALLED-WAITING-PROOF | no | Pit lookup reach is in commit 337b56ce (C-5, PR #491), though the carpark line still says OPEN.
367. BUG-296 | INSTALLED-WAITING-PROOF | no | Remaining millimetre distances are covered by commit 337b56ce (C-5); the full list is in the PR #478 body, not re-checked.
368. BUG-295 | UNCLEAR | no | Entry says all items need measuring in AutoCAD first; the 24 Oct triage lists it as a close candidate (test-tool item), so Tim or CE 00 must decide to close or measure.
369. BUG-294 | INSTALLED-WAITING-PROOF | no | Shared temp-folder fixture is in commit 26321e13 (PR #483); entry says not closed until a test run leaves Tim's real settings file untouched.
370. BUG-293 | INSTALLED-WAITING-PROOF | yes | Grade strip in metre drawings fixed by commits 337b56ce and 8866b09a (BUG-323); a wrong grade shows on every Edit Pipe in a metre drawing.
371. BUG-292 | INSTALLED-WAITING-PROOF | yes | Record-order fill is in commit 8eb5b113 (C-5); a plain Save reversing a downstream-first pipe is a wrong-level risk.
372. BUG-291 | INSTALLED-WAITING-PROOF | yes | Direction-aware Design grade is in commit 8eb5b113; a pipe turning round on Design grade is a wrong-level risk.
373. BUG-290 | INSTALLED-WAITING-PROOF | no | Refresh respects typed levels in commit 8eb5b113, plus BUG-650 commit da006db6; the five commands named in the entry were not each checked.
374. BUG-289 | INSTALLED-WAITING-PROOF | no | Repair refreshes the schedule in commit 8eb5b113 (PR #492).
375. BUG-288 | INSTALLED-WAITING-PROOF | no | Open-end rescan is back in commit 71980a7f (PR #490), and a later guard commit a6969702 keeps it wired.
376. BUG-287 | INSTALLED-WAITING-PROOF | yes | Mixed-units warning built in 337b56ce and 6bdde2c1 (works both ways); Tim's ruling on what the office does with such drawings is not recorded.
377. BUG-286 | INSTALLED-WAITING-PROOF | no | Locked-pit CD is in commit 71980a7f (PR #490).
378. BUG-285 | INSTALLED-WAITING-PROOF | yes | Pipe OOPS comes back with its record in commit 71980a7f (PR #490); a pipe returning bare looks like data loss.
379. BUG-284 | INSTALLED-WAITING-PROOF | no | Locked-layer write audit is commit 116ac434 (PR #489).
380. BUG-283 | UNCLEAR | no | Carpark says installed (PR #489), the 24 Oct triage says not installed; the 2 Nov Civil code no longer unlocks layers (BUG-417 comment at XcivilImportService.cs:1580), so check BUG-417 and the DLL; the skip-or-ask rule was queued as a question for Tim.
381. BUG-282 | INSTALLED-WAITING-PROOF | no | One rulebook cover value everywhere is in commit 337b56ce (PR #470).
382. BUG-281 | INSTALLED-WAITING-PROOF | no | Downpipe radius stored in millimetres is in commit 337b56ce (PR #491).
383. BUG-280 | UNCLEAR | no | Controller accepted two copies until the V3 cutover (1 Oct); the triage says it needs an Opus plan, so it is not due and no builder brief exists.
384. BUG-278 | INSTALLED-WAITING-PROOF | yes | Edit Pipe Save keeps the recorded direction in commits eb28feca and 1ef0fcaa (PR #469); a rewritten flow direction is a wrong-level risk.
385. BUG-277 | INSTALLED-WAITING-PROOF | no | Live bar length on grip stretch is in commits 060fbd6c and 64b57efc (Structural line).
386. BUG-276 | INSTALLED-WAITING-PROOF | no | Commits 841c35ec and 1c86ac7d on the Structural line; the carpark line still says built, not installed, so install state is unconfirmed.
387. BUG-274 | INSTALLED-WAITING-PROOF | no | U/REDO no longer re-queue footing drivers, commit cb17de15 (Structural line).
388. BUG-273 | INSTALLED-WAITING-PROOF | no | Plain job-file save failure line is in commits 61f2b1ad and 9dda7272 (PR #455, #467).
389. BUG-272 | INSTALLED-WAITING-PROOF | no | Newtonsoft method-not-found fix with a source guard is in commit a7833986 (PR #455).
390. BUG-275 | INSTALLED-WAITING-PROOF | no | Palette compares the document, not the database, commits f57033d6 and 2e6e730b (PR #464).
391. BUG-271 | INSTALLED-WAITING-PROOF | yes | Remaining millimetre reaches converted in commit 28d41fd9 (PR #470); a wrong reach in metre drawings gives missed links.
392. BUG-270 | INSTALLED-WAITING-PROOF | yes | Pit search reach converted to drawing units, commits 777845f3 and a4c48912 (PR #453); a metre drawing searched 100 m before.
393. BUG-269 | INSTALLED-WAITING-PROOF | no | Batched clean-up for -ARRAY with timing line, commits dfed4d03 and b7fc3dc8 (PR #458); the 48.8 s gain was not measured.
394. BUG-268 | INSTALLED-WAITING-PROOF | yes | CDFIXPIPEENDS repairs already-wrong copied pipes, commits 10fb2ba4 and 9020c48a (PR #444, #460); wrong pipes stay wrong until it is run.
395. BUG-267 | INSTALLED-WAITING-PROOF | no | OOPS returns a pit with labels and record, commit 10fb2ba4 (PR #443, #460).
396. BUG-266 | INSTALLED-WAITING-PROOF | no | Far pit COPY no longer rescans every open-end pipe, commit 146e2bf3 (PR #450).
397. BUG-265 | INSTALLED-WAITING-PROOF | no | Structural commits bc7b86b6 and 757ed4cf (PR #445) cover the debug lines; the "RESTART RECOMMENDED" text still exists in code, so that part is unproven.
398. BUG-264 | INSTALLED-WAITING-PROOF | no | Annotate flyouts fit a 1080-pixel screen, commit 62323dee (PR #456).
399. BUG-263 | INSTALLED-WAITING-PROOF | no | XCLMTXT review shows its waiting issue, commit 057883e0 (PR #446).
400. BUG-262 | INSTALLED-WAITING-PROOF | no | Locked and skipped items are named, commit 56501175 (PR #454).
401. BUG-261 | INSTALLED-WAITING-PROOF | yes | One upstream rule for Edit Pipe, commit 7bad3dfb (PR #444); the false uphill warning would mislead colleagues.
402. BUG-260 | INSTALLED-WAITING-PROOF | yes | Fix in commits 56501175 and 181d69cb (PR #454); the carpark status line still says OPEN and was never updated.
403. BUG-259 | INSTALLED-WAITING-PROOF | no | CDDESIGN Confirm setup keeps the outlet, commit c20f10d7 (PR #448).
404. BUG-258 | INSTALLED-WAITING-PROOF | no | PD text restored on OOPS, commit 0f0feb1b (PR #443).
405. BUG-257 | INSTALLED-WAITING-PROOF | yes | No write at close unless the record is the only unsaved change, commits d8b0b727 and 0e52afc3 (PR #442).
406. BUG-256 | DUPLICATE-OF-BUG-558 | no | Entry says the general case passed Codex W35 and the residual REDO cases are tracked as BUG-558 and BUG-861.
407. BUG-255 | INSTALLED-WAITING-PROOF | no | Edit Pipe cover comes from the rulebook, commit 28d41fd9 (PR #437, #470).
408. BUG-254 | INSTALLED-WAITING-PROOF | yes | Layer unlock removed from record writes, commits eb28feca and 3d0859b2 (PR #469); changing a locked layer breaks the native protection rule.
409. BUG-253 | INSTALLED-WAITING-PROOF | no | One pipe batch preflight, commit 7e756b07 (PR #648); behaviour unchanged, no AutoCAD step.
410. BUG-252 | INSTALLED-WAITING-PROOF | no | Roughness matches whole words, commit 65a842de (PR #632); whether any silent 0.013 fallback remains was not checked.
411. BUG-251 | INSTALLED-WAITING-PROOF | yes | Kingston commercial PSD 1 in 10, Tc 7 min, pre-development C, commit 000bc604 (PR #433, #803); a wrong council figure on a sheet.
412. BUG-250 | INSTALLED-WAITING-PROOF | no | Beam relink after OOPS with linking ON, commits 4dbc3820 and 73229f5e (PR #466); Tim's answer on whether OOPS should also bring the beam back (match Civil) is not recorded.
413. BUG-249 | NEEDS-TIM | yes | Boyd's rows are still fixed (BoydsCalcViewModel.cs:120 on the 2 Nov line); needs a command card and Tim's approval before any change.
414. BUG-248 | DUPLICATE-OF-BUG-258 | no | Same fault (OOPS after erasing a perimeter drain loses the PD text), same fix, PR #443.
415. BUG-247 | ALREADY-FIXED | no | Commit e8dd6631 (tests only) rewrote the two Manager payload tests; I did not run them.
416. BUG-246 | INSTALLED-WAITING-PROOF | no | Pit Schedule window finds cells kept as drawn, commits 50e14003 and 2175f147 (PR #658, #807).
417. BUG-244 | INSTALLED-WAITING-PROOF | yes | Automatic relink reads levels like Edit Pipe, commit 6282634c (PR #654); an open-end pipe could run uphill after an IL edit.
418. BUG-245 | NEEDS-TIM | yes | Which wins for a pit-to-open-end pipe when the drawn order and levels disagree; no commit and the triage lists it for Tim.
419. BUG-242 | INSTALLED-WAITING-PROOF | no | Inspector re-measures the raingarden area, commit 11c6d234 (PR #635).
420. BUG-243 | INSTALLED-WAITING-PROOF | no | Overlay label height in drawing units, commit 01bd5b91 (PR #633).

---

## Could not verify

1. **Pull requests:** `gh` is missing in this shell, so no PR state (open, merged, draft) was read. There is no HAS-DRAFT line for that reason; PR numbers come from commit text.
2. **Installed DLL:** not read, so "installed" means what the carpark status line says.
3. **Ledger:** `ledger.json` was not parsed (no Python on the shell); no robot PASS or Codex PASS was read for these ids.
4. **Carpark status lines out of date:** BUG-298, 297, 296, 288, 260 and 276 still say OPEN or built although commits exist; CE 05 may want to refresh them.
