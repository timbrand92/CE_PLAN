# Morning, Fri 13 Nov: what ran overnight

**DRAFT, written 04:45 PC clock by lane trust-struc-mgr-plan, BUG-1456 added first at 05:26. The controller checks and finishes it before 8am.**

## First: a fault that can mix two jobs, and two safe habits until it is fixed

1. **What happens:** you work in one job, open or switch to a second drawing, and as the very first CE thing run Help (CDHELP) or Settings (CDS). CE can write the first job's pits and pipes into the second drawing, with nothing on screen (BUG-1456).
2. **Seen in real AutoCAD on your installed build,** on copies only, 6 times in 11 tries, both ways round. A blank drawing gained a whole job and then asked to save; another job's own record was replaced.
3. **Safe habit 1:** in a drawing you have just opened or switched to, do not make Help or Settings the first CE thing you run. Any plain AutoCAD command first (even a circle, then U) avoided it every time.
4. **Safe habit 2:** if a drawing you did not edit asks to save when you close it, answer No.
5. **If the mixed-up drawing is saved, reopening it gives no warning,** and its Pit Schedule lists the OTHER job's pits (seen: 17 rows of another job where the drawing's own shows 1). A schedule printed for council could carry another job's pits.
6. **How to spot one today:** the Pit Schedule shows pits that are not on the plan, or Check Current Drawing shows far more items than you expect (seen: 82 against 48).
7. **How to get your own data back:** one U straight after closing Help or Settings puts it back. The file on disk is untouched until you save over it.
8. **The fix, pull request 2073,** is drafted and has GO for testing on copies; it has never run in AutoCAD and is not installed.

## What ran overnight

1. **Builders:** 47 trial changes built as drafts, none merged, none installed.
2. **Reviewer:** 42 are fit for the robot to test, 3 need fixing first, 2 are not reviewed yet; 7 have changed since their last review and wait to be re-checked.
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

1. **Your installed CE** (Civil 3.0.90, Manager 1.1.89, Structural 1.0.126): nothing was installed. The controller re-checks the files before 8am.
2. **Colleagues:** nothing sent, no pilot folder changed.
3. **The lines that ship:** nothing merged.

## The one decision that unblocks the most

**Where may trial builds be seen in real AutoCAD?** Recommended: **the spare work PC** (your 17 Oct ruling), which needs 30 minutes of yours, once. Second choice: your own PC overnight, put back by 8:10am, but a mistake costs you a morning. Question 0 in `areas\TRUST_QUESTIONS_FOR_TIM.md`.

---

## Where these numbers come from

0. **BUG-1456, 6 in 11, both ways, the two habits, 17 rows against 1, 82 against 48, one U:** `areas\trust-run\EVIDENCE_CROSS_DRAWING.md` (parts 1 and 2) and the BUG-1456 entry at the end of `BUG_CARPARK.md`; GO for pull request 2073 (05:53) and the note that 2064 no longer carries the cure (06:21), from `areas\trust-run\trust-review.md`; the check that comes first: `PENDING_TESTS.md` (CEPROOFCROSSDRAWING).
1. **47 trial changes, 42, 3, 2 and 7:** GitHub's open draft pull requests with "trust" or "bug-1456" in the branch name (2038 to 2084, counted at 07:25), with the latest verdict per pull request in `areas\trust-run\trust-review.md`; the list, with each one's head, is `areas\trust-run\STATUS_BOARD.md`.
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
