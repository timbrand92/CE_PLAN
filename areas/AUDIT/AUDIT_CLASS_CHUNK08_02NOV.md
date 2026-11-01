# Carpark audit, chunk 8 of 21 (entries 421 to 480)

Written Mon 2 Nov 2026, Melbourne time, by a read-only Sonnet audit. Nothing was changed, built, tested or run in AutoCAD. Civil/Manager line read: origin/claude/rel-20261102a (3fbb9da5). Structural line read: origin/claude/rel-20261026s (204dfad2).

## FOR TIM

1. **Answer:** of 66 lines (60 entries; BUG-195 to 201 count as seven), 43 are fixed and installed but waiting for proof, 12 are already fixed, 4 can be built now, 2 need your decision, 2 are closed, 2 are unclear, 1 is a duplicate and none has a draft PR that I could see.
2. **Counts:** INSTALLED-WAITING-PROOF 43, ALREADY-FIXED 12, FIXABLE-NOW 4, NEEDS-TIM 2, CLOSED-OR-WONT-FIX 2, UNCLEAR 2, DUPLICATE 1, HAS-DRAFT 0.
3. **Pilot-critical FIXABLE-NOW:** only one, BUG-213 (an older pit schedule has no way to be replaced). The other three, BUG-225 (Pit tab Close button), BUG-229 (duplicate Draw Order rows) and BUG-235 (a copied pit can steal a pipe end), are not pilot-critical.
4. **Biggest worry:** BUG-224, the crash on closing a drawing. A fix is on the release line but nobody has re-run the crash or read the crash dump.
5. **Your questions:** BUG-222 (which Civil settings go on which tab) and BUG-172 (six commands have no ribbon picture; supply or approve some).
6. **Mistake in the carpark:** BUG-229 points at a fix that is really for BUG-228, so its duplicate Draw Order rows are not fixed at all.

---

## What I could and could not verify

1. **Read:** every entry from BUG-239 to BUG-172 in `C:\CE_PLAN\BUG_CARPARK.md` (60 headings; BUG-195 to 201 share one heading and get seven lines).
2. **Checked in git:** whether a fix commit exists on the two release lines, by searching commit messages for each bug number. A commit existing is NOT proof it works.
3. **Not verified:** which build Tim's PC actually has installed today. "Installed" below repeats what the carpark entry says (Civil 3.0.70 / Manager 1.1.70, Structural 1.0.121) and nothing newer.
4. **Not verified:** pull request status. The `gh` command is not available in this shell, so I could not list draft or open PRs. No entry was classed HAS-DRAFT for that reason; PR numbers come from the carpark text and merge commits.
5. **Not verified:** the runner ledger (`ledger.json`) holds case ids, not bug numbers, so it could not confirm any of these by name.
6. **Carpark slip found:** BUG-229 says its fix was installed via PR #622, but #622 is the CDDIAG wording fix (BUG-228). The 27 Oct Codex look shows the duplicate Draw Order rows still on 3.0.80. So BUG-229 has no fix at all.
7. **BUG-224 (the crash):** the carpark entry still says "cause Unknown" but commits c3e3cc48 (Civil no longer writes into a closing drawing) and #753 (a guard test) are on the release line. Nobody has re-run the crash sequence, and the crash dump was never opened.

---

## One line per entry

421. BUG-239 | INSTALLED-WAITING-PROOF | pilot-critical no | Council sources in words fixed by #629 (5d3dc9a9, 2d420688), in Civil 3.0.70; no robot or Codex run yet.
422. BUG-202 | UNCLEAR | pilot-critical no | Lag was mostly Tim's PC and AutoCAD itself; the two real CE faults were split into BUG-203 and BUG-204; missing: a fresh lag report on a current build to decide whether to close it.
423. BUG-224 | INSTALLED-WAITING-PROOF | pilot-critical yes | Crash on closing a drawing after Save As: fix c3e3cc48 and guard test #753 are on the release line, but the crash was never reproduced or re-run and the dump was never read; installed state not checked.
424. BUG-225 | FIXABLE-NOW | pilot-critical no | Pit tab Close button leaves the pit selected while the typed command works; expected result is clear and no fix commit exists.
425. BUG-226 | INSTALLED-WAITING-PROOF | pilot-critical no | Discipline button hover text fixed by #624 (511e9b20), Civil 3.0.70.
426. BUG-227 | INSTALLED-WAITING-PROOF | pilot-critical no | Settings hover text fixed by #625 (8520fa12), Civil 3.0.70.
427. BUG-228 | INSTALLED-WAITING-PROOF | pilot-critical no | CDDIAG words and tooltip fixed by #622 (222232ef), Civil 3.0.70.
428. BUG-229 | FIXABLE-NOW | pilot-critical no | Duplicate Draw Order rows still seen on 3.0.80 (Codex look F5); the carpark's "installed via #622" is a wrong link; expected is each layer once, so a builder can remove repeats on load.
429. BUG-240 | CLOSED-OR-WONT-FIX | pilot-critical no | Closed WONT FIX on Tim's yes (decision 178, 31 Oct 2026): a record of his AutoCAD profile, not a product fault.
430. BUG-238 | CLOSED-OR-WONT-FIX | pilot-critical no | WONT FIX: the finding was read from a private copy of the registry, Tim's real profile was fine.
431. BUG-235 | FIXABLE-NOW | pilot-critical no | A copied pit can steal a pipe end from the original; the plan already says stable identity beats proximity and the rule for an exact overlap is a plain warning; no fix commit found.
432. BUG-236 | INSTALLED-WAITING-PROOF | pilot-critical no | PD1 tag now follows its drain: #426 (a1489b44, d2c90661), Civil 3.0.70.
433. BUG-237 | INSTALLED-WAITING-PROOF | pilot-critical no | OOPS after erasing a column relinks beams: #428 (010b5acc, 05028608) in Structural 1.0.121.
434. BUG-234 | INSTALLED-WAITING-PROOF | pilot-critical no | Moved or gripped flat pipe records the new pits: #645 (f98ccde8), Civil 3.0.70.
435. BUG-233 | INSTALLED-WAITING-PROOF | pilot-critical no | Orifice line source in words: #420 (4c85a268, cd18a9eb), Civil 3.0.70.
436. BUG-232 | INSTALLED-WAITING-PROOF | pilot-critical no | Schedule refresh skips locked, Xref and REFEDIT cells: #423 (89ad7a0e), Civil 3.0.70.
437. BUG-230 | INSTALLED-WAITING-PROOF | pilot-critical no | PAVE and site-area readers use drawing units: #421 (2ac8999a), Civil 3.0.70; the open question of what INSUNITS Tim's office templates use is still unanswered.
438. BUG-231 | INSTALLED-WAITING-PROOF | pilot-critical no | AutoCAD shutdown no longer forces a write: #636 (d96b721b), Civil 3.0.70.
439. BUG-223 | INSTALLED-WAITING-PROOF | pilot-critical no | CDEDIT between two open ends follows the levels: b99851bd, #404 and #422, Civil 3.0.70.
440. BUG-203 | INSTALLED-WAITING-PROOF | pilot-critical no | Civil stays quiet in a Structural drawing: #393 (e51920d9); Codex was blocked because the test drawing was a Civil one.
441. BUG-204 | INSTALLED-WAITING-PROOF | pilot-critical no | Structural settings file stops growing: #399 (4e88c6e5), Structural 1.0.121.
442. BUG-205 | INSTALLED-WAITING-PROOF | pilot-critical no | Pipe between two open ends goes downhill: #404, Civil 3.0.70.
443. BUG-206 | UNCLEAR | pilot-critical no | OSMODE ended at 0 after a long run and no command was blamed; BUG-380 (e3ffe44b) fixed one snap-restore leak but nobody shows it is this one; missing: a repeat that names the command.
444. BUG-207 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 15 Oct 2026, Codex-accepted for the original one-Undo defect (commits 0ffa1231, 3868e1c9); grip and open-end routes were not retested.
445. BUG-208 | INSTALLED-WAITING-PROOF | pilot-critical yes | Pipe end grip refused linked records: #410 plus later rounds (f1f9fa43, 82abe627), Civil 3.0.70; wrong links on a stretched pipe would reach a job.
446. BUG-209 | INSTALLED-WAITING-PROOF | pilot-critical yes | Catchment area was a million times too big and gave a false overload warning: fixed by 17b88211 (#411), Civil 3.0.70.
447. BUG-210 | INSTALLED-WAITING-PROOF | pilot-critical yes | Copied pit onto an erased pit's junction now links at once: #417 (06aaf868), Civil 3.0.70.
448. BUG-211 | INSTALLED-WAITING-PROOF | pilot-critical no | Erasing a column tells its beam: #415 (dbceb3d4, e03fafb3), Structural 1.0.121; Tim's workflow question (ask per beam) was part of the design check.
449. BUG-212 | INSTALLED-WAITING-PROOF | pilot-critical no | Placing a schedule on an older pit: #419 (f44f4d2d, 6e2aeda4), Civil 3.0.70.
450. BUG-213 | FIXABLE-NOW | pilot-critical yes | Older schedule has no enabled "replace" button (Codex FAIL again on 3.0.49); expected is a Replace older schedule action with preview and one U, and no fix commit found, only the legacy-cell commits 9cf10ffd and 4c433dbf.
451. BUG-214 | INSTALLED-WAITING-PROOF | pilot-critical no | CEFIND then Esc no longer marks the drawing changed: #416 (2dd5d47b, ae62eb2d), Civil 3.0.70.
452. BUG-215 | INSTALLED-WAITING-PROOF | pilot-critical no | RC needs one U: #418 (2c832e96, 4fc3d542), Structural 1.0.121; Codex saw a PASS on 15 Oct but the entry is not marked accepted.
453. BUG-216 | INSTALLED-WAITING-PROOF | pilot-critical no | CDFALLSUGGEST Enter finishes: f85c1f9e (#416), Civil 3.0.70; Codex accepted only one narrow Enter route on 14 Oct.
454. BUG-217 | INSTALLED-WAITING-PROOF | pilot-critical no | Perimeter drain draws its own PD tag: #417 (3ed1def2), Civil 3.0.70.
455. BUG-218 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 14 Oct 2026, Codex-accepted narrow PASS on Structural 1.0.116 (b0806aed); docked-Hub route not covered.
456. BUG-219 | INSTALLED-WAITING-PROOF | pilot-critical no | Manager status bar shows the running version: #497 (31689f09), Civil 3.0.70.
457. BUG-220 | INSTALLED-WAITING-PROOF | pilot-critical no | Structural launcher no longer pops up at start: #465 (e6ceb972, b4ddbdb4), Structural 1.0.121.
458. BUG-221 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 19 Oct 2026, Codex-accepted look L3-01a and L3-01b (2f855c9c).
459. BUG-222 | NEEDS-TIM | pilot-critical no | Civil settings form scrolls the whole way; Tim's rule says use tabs but nobody has settled which settings go on which tab.
460a. BUG-195 | INSTALLED-WAITING-PROOF | pilot-critical no | XCLMTXT no longer invents floors: ccd31d62 on the Structural line, in 1.0.86; no Codex re-test recorded.
460b. BUG-196 | INSTALLED-WAITING-PROOF | pilot-critical no | Schedule table text size fixed in ccd31d62 and 4a0bc721; Tim ruled "keep 300 and 200" for the member-schedule block, so that part is closed.
460c. BUG-197 | INSTALLED-WAITING-PROOF | pilot-critical no | Branch labels overlapping the main's: b0fb61d8 (#388) on the release line; Opus review fixes e3be258b merged; no Codex run.
460d. BUG-198 | INSTALLED-WAITING-PROOF | pilot-critical yes | Size-only CDEDIT changed 1 IN 100 to 1 IN 99; Codex saw it still failing on 3.0.15, then 67ddfde8 and b3381e43 re-fixed it; no re-run since.
460e. BUG-199 | INSTALLED-WAITING-PROOF | pilot-critical no | Calculated level labelled "Staff entered": the open-ends preview fix is in 67ddfde8; the earlier Codex run passed the existing-pit route and failed the two-open-ends route, not re-run.
460f. BUG-200 | INSTALLED-WAITING-PROOF | pilot-critical no | CDCHECK Enter finishes: 8d92c5d0 and c39be4e6 (#387) on the release line; never tested in AutoCAD by name.
460g. BUG-201 | INSTALLED-WAITING-PROOF | pilot-critical no | PIT command line jargon removed: 8d92c5d0 (#387) on the release line; never tested in AutoCAD by name.
461. BUG-194 | INSTALLED-WAITING-PROOF | pilot-critical no | Pipe tab only for real CE pipes: #380 (381405f1), Civil 3.0.70.
462. BUG-193 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 30 Sep 2026, Codex-accepted for an ordinary pit only; the P6 900 x 900 case was not tested.
463. BUG-192 | DUPLICATE-OF-BUG-256 | pilot-critical yes | The entry's own status says it is tracked under BUG-256, BUG-558 and BUG-861; v2 proof work (#414) is on the release line; REDO after U is still the open symptom.
464. BUG-191 | INSTALLED-WAITING-PROOF | pilot-critical no | Use plan label is one named Undo: bb472399 (#359), Civil 3.0.70.
465. BUG-190 | ALREADY-FIXED | pilot-critical yes | Carpark status FIXED 29 Sep 2026, Codex-accepted (pass 17 Q4: Ctrl+S, close and reopen kept the data).
466. BUG-189 | ALREADY-FIXED | pilot-critical yes | Carpark status FIXED 30 Sep 2026 on Tim's word plus Codex timing; Structural timing is a separate lane.
467. BUG-188 | INSTALLED-WAITING-PROOF | pilot-critical no | CE Blocks attribute tags: PR #333 (33593742), installed 28 Sep; Tim's own check (place a tagged block, then explode it) is still outstanding.
468. BUG-187 | INSTALLED-WAITING-PROOF | pilot-critical no | Grade survives switching pipe type: 73c7d402 and 223c49f8; Codex tested an older build, not re-run on one with the fix.
469. BUG-186 | INSTALLED-WAITING-PROOF | pilot-critical no | Carry downstream refusal fixed (73c7d402), the reopened grade case fixed by 677dd6a5 (#361) in 3.0.13; Codex has not re-run it.
470. BUG-185 | INSTALLED-WAITING-PROOF | pilot-critical no | 45-degree beam on a rectangular column in a metre drawing: PR #295 shipped in Structural 1.0.78 per the entry; no commit message with this number was found, and it still needs an AutoCAD check.
471. BUG-184 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
472. BUG-183 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
473. BUG-182 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
474. BUG-181 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
475. BUG-180 | INSTALLED-WAITING-PROOF | pilot-critical no | Pipe or Pit tab comes to the front: 947a00c2 (#296, #298); Codex could not run the Home-tab step because the workspace has no Home tab, twice.
476. BUG-179 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
477. BUG-178 | ALREADY-FIXED | pilot-critical no | Carpark status FIXED 27 Sep 2026, Codex-accepted pass 13.
478. BUG-177 | INSTALLED-WAITING-PROOF | pilot-critical no | CDPIPEOBJ hidden from the ribbon as Tim ruled (UX-PIPE-08): PR #291 (64c5e3cc), Civil 3.0.7; status still "in progress", nothing left to build.
479. BUG-171 | INSTALLED-WAITING-PROOF | pilot-critical yes | Upgraded stormwater pipe opening as Detention: round 2 d6a02dcb (draft #196, merged into the train as a5443b8b); the Codex FAIL was on the older build and has not been re-run.
480. BUG-172 | NEEDS-TIM | pilot-critical no | Three Civil ribbon icons fixed (206ac2ba); six commands (CDPERIMETER, CDTWL, CDDEST, CDPAVE, CDKERB, CDSPOONDRAIN) have no artwork and Tim has to supply or approve pictures.
