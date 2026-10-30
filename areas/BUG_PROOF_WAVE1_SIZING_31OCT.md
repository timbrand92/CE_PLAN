# Wave 1 of the bug-proof cases: which bugs, and the sizing (CE 02, Sat 31 Oct 2026 08:40, read-only preparation)

## ANSWER FIRST

1. **Wave 1 = 50 Civil bugs from the lane A list, in four groups, all on the drawings the robot already has (no new fixture, no client data).** Every one is a lane A bug (the robot proves it) that is runnable on a plain test copy, and none needs a consultant package, another PC or the install route.
2. **Sizing for the Team budget:** about 10 writer runs (Team Opus), about 6 review runs (Opus), about 3 repair rounds (Sonnet, mechanical), and about 150 robot case-runs (pass a, pass b, one broken twin per bug) = about 7 to 9 robot hours.
3. **Robot time is not the limit:** the robot has about 30 free hours from Sun 1 Nov 02:00 to Mon 2 Nov 08:30. Writing and review are.
4. **What I did and did not do:** I only read `BUG_PROOF_LANES_31OCT.md` and the case files. No writing job, no AutoCAD, no build. I wait for your GO at 14:05.

## The four groups (bug ids from the lane A list; 50 in all)

1. **Group P, pits and pipes: erase, undo, copy, move (14):** BUG-210, 234, 244, 248, 258, 267, 285, 325, 330, 665, 666, 667, 671, 672. One drawing with a few pits and pipes (the DRV1 style drawing the cases use today). Typed commands: ERASE, OOPS, U, COPY, MOVE, ROTATE, then read what the drawing and the command line say. Existing cases to build on: R19, R24, R34, N27, N71v87.
2. **Group E, Edit Pipe and CDPROPAGATE cascade (16):** BUG-223, 261, 278, 292, 324, 339, 652, 653, 654, 655, 656, 657, 687, 688, 689, 682. Same drawing, one two-pipe junction for the "more than one pipe arriving" and "one end blank" cases. Existing cases: R17, R32v87, R32bv87, N18v87, N23v87.
3. **Group S, Pit Schedule (12):** BUG-246, 312, 385, 573, 779, 780, 782, 783, 784, 785, 786, 791. The schedule window and the drawn schedule on the same drawing. Existing cases: R33, R38, N40, N44, N67v87.
4. **Group T, tags and source labels (8):** BUG-216, 740, 741, 742, 743, 744, 746, 713. A drawing with a few source blocks (downpipes, perimeter drain), typed CDTAG, CDFIXTAGS, CDTG, CDFALLSUGGEST. Existing cases: R37, R37b, N04, N90 family.

**Left for later waves, on purpose:** CDSURVEY (10) needs a survey file; the imports (LandXML, compare, X-Civil, about 12) need consultant data; metre and scaled drawing bugs (about 14) need a metre fixture; the Structural 33 plain-copy bugs need the Structural fixture and a second setup; the 43 bundles must be split first; 35 lane A bugs need real job data or the install route.

## Sizing (counts to set the Team cap)

1. **Writer runs: about 10.** One Team Opus job per about 5 bugs (a case, its broken twin and the setup note); the Team agent that wrote 21 files for C-78 took about 25 minutes, so about 4 hours of Team writing in total, run one at a time.
2. **Review runs: about 6.** One Opus paper review per about 8 to 10 cases (the C-78 review of 30 files took 23 minutes and found 20 files to fix; so expect roughly half of the first drafts to need a fix).
3. **Repair rounds: about 3.** Mechanical edits from the review (Sonnet, or me).
4. **Robot case-runs: about 150** (50 bugs x pass a, pass b, one twin); at the measured 18 to 26 runs an hour that is 7 to 9 hours, in two or three nights.
5. **Pass record:** every result is stored with the case hash, the build and the commit; `carried from <build>` is written when the train's changed files do not touch the case's area (RETEST_AREA_MAP).

## Risks I can already see (from this morning's runs)

1. A case whose setup types a level flatter than 1 in 100 is blocked by the Grade mismatch window on 3.0.87 and later: the writers must use the 1 in 100 setups (SETUP-R47v, P8v, P8x2v).
2. Words in assertions must be copied from the source at the build's commit, not written from memory (N41v87's end level reads IL 17.78 after a stretch, not 17.800).
3. A case that reads a handle from a selection that may be empty stops with a step error (the FPFC case); the writers must read counts first.
4. The driver refuses the word print; briefs and cases use princ.
5. Pit and pipe ends move 225 mm into the pit wall: lengths in assertions are wall to wall.
