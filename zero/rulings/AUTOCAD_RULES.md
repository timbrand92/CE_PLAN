# Current rulings: AutoCAD rules (rule 1.9 and its exception, when AutoCAD may be started, test copies, old plug-in beside the new, SECURELOAD)

Current rulings as of 18 Nov 2026, 1:20 pm (Melbourne), from decisions D-001 to D-225. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Rule 1.9

1. **Rule 1.9 "Hands off AutoCAD's profile and licence" is in `C:\TimOS\RULES.md` as written:** no chat, helper or robot may, without Tim's yes in words in that conversation, make, copy, rename, delete or switch a profile, start AutoCAD under another profile, force-close AutoCAD or its headless engine, touch licensing or sign-in, or change a saved AutoCAD setting or the registry; a licence or sign-in window stops everything; every brief to a helper that may start AutoCAD repeats the rule in full (D-120, D-121).
2. **One named exception:** a robot may close (normal close first, then force) a TEST AutoCAD that it started itself that night on a test copy when it jams or crashes, and carry on; never one of Tim's, never one it did not start; a licence or sign-in window still stops everything (D-160, written into rule 1.9 on 18 Nov).

### When AutoCAD may be started

3. **Standing yes for testing:** AutoCAD may be started on TEST COPIES every night inside Tim's hours, 5:30 pm to 8:30 am weekdays and all weekend, without asking each day; never one of his drawings, never while his own AutoCAD is open (D-159, built on D-092).
4. **The hours win over the switch file** for the zero-plan trials, as long as no AutoCAD window of Tim's is open (D-093).
5. **Test copies only, never a live job** (D-092, D-159); **night tests take a copy of the office template under `C:\CE_WORK\civil_tests\`, and the template folder is read only** (D-197).
6. **Codex through its command line is allowed as the driver** (D-116).
7. **The brain-building chat never starts AutoCAD and never touches the installed plug-in** (D-127).
8. **One-off daytime windows Tim gave, now passed:** AutoCAD free from 12:15 pm for at least an hour on 18 Nov (D-207), and tests until 5:30 pm on 18 Nov with his approval (D-212). Neither is a standing yes.

### History of single words (one window each, not standing)

9. **Tim's force-close words covered one window each:** the stuck trial AutoCAD about 10:05 pm on 16 Nov (D-126); the jammed t1_seed run about 10:40 pm on 16 Nov, with "Keep trying tonight" and a changed method of short steps read back after each (D-130); the error window on t2_mouse, closed normally, on 17 Nov (D-155); the t2_mouse AutoCAD force-closed on 17 Nov (D-157).
10. **Trial restart after the licence incident:** "start the trials now" with limits added to the brief: no profiles, no force-closing, no licensing or sign-in, one AutoCAD at a time and none while Tim's is open, no registry writes, leftovers untouched (D-116).
11. **How the trial chat could open AutoCAD then:** by the double-click hand-off only (a made-up drawing handed to Windows), under his own profile, changing nothing, one at a time (D-122).

### The leftovers of the 16 Nov incident

12. **"Leave everything, I will look tomorrow":** the ZeroTrial profile, the load-safety setting (SECURELOAD) left at 0 in the unnamed profile, and the trial folder are not to be touched (D-111, restated in D-116).

## Changed along the way

1. **"NOTHING starts AutoCAD overnight" (D-137, 16 Nov) and the day-by-day yes for 17 Nov (D-139) were replaced by the standing yes every night in his hours (D-159, 18 Nov).**
2. **"If AutoCAD jams the trial stops and leaves it for Tim; nothing is force-closed" (D-139) was replaced for test AutoCADs the robot started by the named exception (D-160, 18 Nov).**
3. **The switch file `.timos\autocad.json` (mayStart false) no longer rules the zero-plan trials inside the hours (D-093, 16 Nov).**
4. **"No trial starts AutoCAD until Tim agrees how" (PARKING_LOT P-08; THE_PLAN section 4 "ON HOLD") was settled by D-116, D-122 and then D-159.**

## Still open on this subject

1. **The leftovers: the ZeroTrial profile, SECURELOAD at 0 in the unnamed profile, and the isolate folder** have waited on Tim since 16 Nov ("I will look tomorrow") (D-111, D-116, PARKING_LOT P-08). Waits on: Tim.
2. **UNCLEAR: whether the night runs must still open AutoCAD by the double-click hand-off only (D-122) or may start it "the normal way" (LOOPS loop 2);** D-159 does not say. Waits on: Tim.
3. **The cause of the 16 Nov licence error is not proven** (PARKING_LOT P-08); recorded so no cause is assumed. Waits on: Tim (to close the item).
4. **The headless engine stays BLOCKED for unattended runs** until Tim decides; R-005 recommends not using it yet (R-003, R-005, D-161). Waits on: Tim.
5. **The old plug-in beside the new one:** Tim's installed plug-ins were loaded during every trial and any interaction is unmeasured (THE_PLAN section 6a); old and new on one PC, and which owns CD, stops a job (SITUATIONS I4); PIT and CD may already answer before CE loads (OQ-09); compare native behaviour with the old plug-ins loaded (OQ-10). Waits on: the build chat.
6. **The Properties palette trial is blocked because showing the palette changes a saved interface setting** (trial 5), which rule 1.9 forbids without Tim's word. Waits on: Tim.
7. **TimOS rule 1.8 also lists 2:00 to 3:00 pm as a free window;** D-092 and D-159 do not include it for AutoCAD tests. Waits on: Tim (only if a midday test window is wanted).

## Where the detail lives

1. `C:\TimOS\RULES.md` rule 1.8 and rule 1.9 with its exception.
2. `DECISIONS.md` D-092, D-093, D-111, D-116, D-120 to D-122, D-126, D-127, D-130, D-137, D-139, D-155, D-157, D-159, D-160, D-197, D-207, D-212.
3. `PARKING_LOT.md` P-08; `stage4\TRIALS_BRIEF.md`; `stage4\TRIAL_RESULTS.md`; `reference\research\R-005_NO_SCREEN_ENGINE.md`.
