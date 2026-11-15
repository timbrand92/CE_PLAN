# Morning, Fri 13 Nov: what ran overnight

**Finished 07:55 PC clock, Fri 13 Nov. Written by lane trust-struc-mgr-plan; every number below was checked by the controller against its file or GitHub at 07:52 to 07:55 (draft count, bug count 1280 to 1456, tool notes, question count, BUG-650 in two sessions, BUG-968, installed Civil version, no AutoCAD running). The evidence itself was not re-run by the controller.**

## First: a fault that can mix two jobs, and two safe habits until it is fixed

1. **What happens:** you work in one job, open or switch to a second drawing, and as the very first CE thing run Help (CDHELP) or Settings (CDS). CE can write the first job's pits and pipes into the second drawing, with nothing on screen (BUG-1456).
2. **Seen in real AutoCAD on your installed build,** on copies only, 6 times in 11 tries, both ways round. A blank drawing gained a whole job and then asked to save; another job's own record was replaced.
3. **Switching tabs is enough:** with both drawings open, going back to the other tab and then running Help or Settings does it.
4. **Only Help and Settings do it,** of everything tried: Check Current Drawing, the Inspector, CE Blocks, the two managers, the Pit Schedule, Edit and Move and Rotate did not. Report a problem (CDFEEDBACK) could not be tested.
5. **Safe habit 1:** in a drawing you have just opened or switched to, do not make Help or Settings the first CE thing you run. Any plain AutoCAD command first (even a circle, then U) avoided it every time.
6. **Safe habit 2:** if a drawing you did not edit asks to save when you close it, answer No.
7. **If the mixed-up drawing is saved, reopening it gives no warning,** and its Pit Schedule lists the OTHER job's pits (seen: 17 rows of another job where the drawing's own shows 1). A schedule printed for council could carry another job's pits.
8. **How to spot one today:** the Pit Schedule shows pits that are not on the plan, or Check Current Drawing shows far more items than you expect (seen: 82 against 48).
9. **How to get your own data back:** one U straight after closing Help or Settings puts it back. The file on disk is untouched until you save over it.
10. **No .bak to fall back on:** AutoCAD keeps no .bak files on this PC (ISAVEBAK is 0), but CE's own `_PRE_C7_` copy beside the drawing held the original.
11. **The fix, pull request 2073,** is drafted and has GO for testing on copies, and so does the last door, pull request 2083 (a change to CE's record is refused when it belongs to another drawing). Neither has run in AutoCAD; neither is installed. **Overtaken, Fri 13 Nov afternoon:** with Tim's word for that day only, both were installed on his PC as Civil 3.0.90.2 and the robot passed 20 of 20; not yet accepted. See `areas\trust-run\INSTALL_TRIAL_RESULT_13NOV.md`.

## Second: CLEAN and FASTSAVE can save over a template

1. **What happens:** in a new drawing made from a template and never saved, CLEAN or FASTSAVE saves straight into the template file with no question, so later drawings from that template start with that job's content (BUG-1457).
2. **Seen in real AutoCAD on your installed build,** on a copy of a template only; your real template was not touched (same fingerprint).
3. **Safe habit:** save a new drawing with its own name before running CLEAN or FASTSAVE.

## What ran overnight

1. **Builders:** 74 trial changes built as drafts (counted on GitHub at 18:33), none merged, none set to merge by itself; 17 of them are inside the trial builds on your PC (Civil 3.0.90.11 since Sun 15 Nov 16:03, Structural 1.0.126.1), under your standing trial approval; tools accepted 4 of 10 (see the status board).
2. **Reviewer:** 53 are fit for the robot to test, 4 need fixing first (2053, 2089, 2096, 2100), 17 are not reviewed yet; 18 have changed since their last review and wait to be re-checked.
3. **AutoCAD robot:** tested on copies outside your hours, then closed AutoCAD.
4. **Code readers:** wrote a one-page note for each of your 47 Civil and 32 Structural core tools, and filed 177 new faults.
5. **Planning:** your questions gathered in one file: 87, the first one matters most.

## Proven in real AutoCAD (on copies)

1. **Cancelling the floor waste tool no longer wipes pit inverts** (BUG-650). Seen fixed in two separate AutoCAD sessions.
2. **Renumber no longer closes AutoCAD** when two pipes run opposite ways between two pits (BUG-968). Seen fixed.
3. **The new "read only" tools really only read** (trial build of step 5): CDGRAPH and CDDIAG left CE's record exactly as it was.

## The three faults that matter most to you

1. **Edit Pit changes CE's record even when you press Cancel,** and quietly turns a plain pipe-layer line into "100 dia UPVC" and an unlabelled pit into a numbered 350 x 350 plastic pit. Seen in AutoCAD.
2. **The Pit Schedule leaves plastic pits out without saying** (BUG-1274). Found on a real council drawing; a fix is drafted, not installed.
3. **Structural bracing numbers can be wrong on a sheet:** the bracing schedule is one row short and keeps erased braces, and roof trusses count as wall bracing. Fixes are drafted, not installed.

## Not done or not proven

1. **Nothing has been seen with a window, the ribbon or the opening line in real AutoCAD.** That needs the trial build loaded (your one decision below).
2. **No Structural fix has been seen in AutoCAD.**
3. **The Excel export and Edit Pit's Save button could not be tested** by the robot.
4. **No real job was opened, and no colleague's PC was read.**

## Not touched

1. **Your installed CE** (Civil 3.0.90, Manager 1.1.89, Structural 1.0.126): nothing was installed. The controller re-checks the files before 8am. **Overtaken, Fri 13 Nov afternoon:** Civil is now 3.0.90.2 (the mix-up fix only, installed with Tim's word); Manager and Structural unchanged.
2. **Colleagues:** nothing sent, no pilot folder changed.
3. **The lines that ship:** nothing merged.
4. **Your working hours:** from 8:20am to 2:00pm and 3:00pm to 5:30pm on weekdays, no lane builds, tests or runs AutoCAD on this PC (run file section 3b).

## The one decision that unblocks the most

**Where may trial builds be seen in real AutoCAD?** Recommended: **the spare work PC** (your 17 Oct ruling), which needs 30 minutes of yours, once. Second choice: your own PC overnight, put back by 8:10am, but a mistake costs you a morning. Question 0 in `areas\TRUST_QUESTIONS_FOR_TIM.md`.

---

## Where these numbers come from

0. **BUG-1456, 6 in 11, both ways, the two habits, 17 rows against 1, 82 against 48, one U, tab switch, only Help and Settings, ISAVEBAK 0, the _PRE_C7_ copy:** `areas\trust-run\EVIDENCE_CROSS_DRAWING.md` (parts 1 to 3) and the BUG-1456 entry at the end of `BUG_CARPARK.md`; GO for pull request 2073 (05:53) and the note that 2064 no longer carries the cure (06:21), from `areas\trust-run\trust-review.md`; the check that comes first: `PENDING_TESTS.md` (CEPROOFCROSSDRAWING).
1. **74 trial changes, 53, 4, 17 and 18:** GitHub's open draft pull requests with "trust" or "bug-1456" in the branch name (2038 to 2111, counted at 18:33), with the latest verdict per pull request in `areas\trust-run\trust-review.md`; the list, with each one's head, is `areas\trust-run\STATUS_BOARD.md`.
2. **47 and 32 tool notes:** the files in `04_REFERENCE\core-tool-notes\` (47 plus a README) and `04_REFERENCE\core-tool-notes\structural\` (32).
3. **177 new faults:** bug numbers BUG-1280 to BUG-1456 in `BUG_CARPARK.md`, counted by this lane at 06:27.
4. **87 questions:** `areas\TRUST_QUESTIONS_FOR_TIM.md`.
5. **BUG-650, BUG-968:** `areas\trust-run\EVIDENCE_STALE_BUGS.md`.
6. **CDGRAPH and CDDIAG on the trial build:** `areas\trust-run\EVIDENCE_BRANCHES.md`.
7. **Edit Pit on Cancel, the made-up values:** `areas\TRUST_PROBES_13NOV.md`.
8. **Plastic pits, BUG-1274:** `areas\TRUST_CORE_TOOLS_SECOND_CHECK_13NOV.md`, tool 31.
9. **Bracing faults:** `areas\trust-plan-structural.md` section 4 (BUG-497, 498, 499).
10. **Excel export and Edit Pit Save not testable:** `areas\trust-run\EVIDENCE_STALE_BUGS.md` and `areas\TRUST_PROBES_13NOV.md`.
11. **The spare PC, 30 minutes:** `areas\trust-run\HOW_TO_SEE_TRIAL_BUILDS.md`.
12. **Working hours:** `areas\TRUST_AUTONOMOUS_RUN_12NOV.md` section 3b (added 07:40).
