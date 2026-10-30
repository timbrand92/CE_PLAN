# Plan: who writes the missing test cases and fixtures first (DRAFT, Sat 31 Oct 2026)

**Status:** DRAFT for Tim's yes. Nothing started. Written by CE 04 from areas\BUG_PROOF_LANES_31OCT.md (335 installed bugs: 241 lane A, 27 lane B, 11 lane C, 56 unclear; only 9 have a passing robot case) and the build chat's case-writing report areas\CASE_WRITING_C78_REPORT_30OCT.md. Follows Tim's decisions 141 to 146 and 160 in decisions\2026-10-29_TIM_ANSWERS.md.

## FOR TIM

1. **Answer:** the most bugs unlock fastest if we write cases for what needs NO new test drawing first, then build two synthetic test drawings (a metre drawing, a survey Xref with a LandXML file), then Structural. Everything that needs your real consultant package, a second PC or the install route waits.
2. **Who:** cheap Sonnet writers write the cases, one wave at a time. One Opus review per wave checks the expected numbers. CE 02 runs the cases in the robot's AutoCAD slots. Codex gives the independent second pass. CE 05 marks bugs FIXED when the ledger accepts them. You do nothing except the weekly spot-check and the few lane C calls.
3. **Time (an estimate, not measured):** a full run of 66 cases took about 8 h 15 min, so about 7.5 minutes a case. If one case covers one bug, 257 new cases is about 32 hours of robot time. If one case covers about three bugs (a guess), about 11 hours. Writing the first 21 cases (the C-78 batch) took one evening. So roughly one to two weeks of mostly overnight running, not months.

## Waves, in order

1. **Wave 1: cases only, the standard test drawing, no new fixture.** At least 35 named lane A bugs from the biggest groups: locked pipe layer 7, Edit Pipe cascade 7, Edit Pipe single save 5, ERASE and OOPS 6, CD direction 5, command-line wording 5. Likely many more from pits (29) and pipes and levels (39); that part is not counted yet. Fastest wins.
2. **Wave 2: two synthetic fixtures, then their cases.**
   1. **Metre drawing** (a blank drawing set to metres): unlocks about 16 bugs (metre drawings and sources, pit and Edit Pipe in metres).
   2. **Survey Xref plus a small LandXML file:** unlocks CDSURVEY intake (10), survey and spot levels (14) and part of imports (25).
   3. **Both fixtures are made-up:** no client data, nothing copied from your OneDrive projects. Built by the desk, checked once.
3. **Wave 3: Structural (62 bugs).** Structural stays on your PC for the pilot. First check whether the robot can drive Structural at all (Codex native looks have, per BUG-215). Cases on your PC in off-hours.
4. **Wave 4: needs you or something outside the desk:**
   1. **35 lane A bugs** need a real consultant package (DWG plus PDF), the install route, or the second 2027 PC.
   2. **56 unclear bugs:** 43 are bundles that a cheap job splits first; 13 have no AutoCAD route.
   3. **27 lane B bugs:** robot pictures, Codex look, you glance at one picture sheet.
   4. **11 lane C bugs:** a short list of one-line questions to you.
   5. **4 installed fixes still fail:** BUG-430, 505, 642, 788 go back to a builder, not to a tester.

## Who does what

1. **Case writers:** background Sonnet jobs, one wave at a time (not many in parallel; keeps usage light). Each writes cases from the bug entries, each with a "must fail on the old build" twin, validated offline (`case_runner.ps1 validate`, 0 invalid).
2. **Reviewer:** one Opus pass per wave, reading each case against its bug entry. It catches wrong expected values (for example the 19.40 versus 18.95 question in the C-78 report).
3. **Runner:** CE 02 runs the cases in AutoCAD slots (Rule 15, never idle), on Tim's PC out of hours and on the second 2027 PC once Tim names it.
4. **Second pass:** Codex re-checks lane A fixes independently and does the lane B looks.
5. **Statuses:** CE 05 marks a bug FIXED only when the ledger accepts it by name (decision 145), with the build hash (decision 146).
6. **Schedule and usage:** CE 00 slots the waves into the calendar.

## Quality guards (from decisions 141 to 146)

1. **Every case has a twin that must fail on the old build.** A case that passes on both proves nothing.
2. **Robot PASS plus Codex PASS before FIXED.**
3. **A pass is kept until the tool's code changes** (decision 146); the area plus smoke re-test catches breakage.
4. **Tim's weekly spot-check** of about 5 accepted fixes.

## Needs Tim's word before anything starts

1. Is the wave order right?
2. Are made-up test drawings (no client data) OK?
3. One Sonnet writer per wave plus one Opus review, OK?
4. CE 02 owns the pipeline, OK?
5. The consultant package: give one scrubbed real example later, or leave those 35 bugs until after the pilot?
