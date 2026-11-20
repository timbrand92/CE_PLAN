# Current rulings: AutoCAD rules (rule 1.9 and its exception, when AutoCAD may be started, test copies, old plug-in beside the new, SECURELOAD)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (D-298 to D-383 filed 20 Nov 2026). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Rule 1.9

1. **Rule 1.9 "Hands off AutoCAD's profile and licence" is in `C:\TimOS\RULES.md` as written:** no chat, helper or robot may, without Tim's yes in words in that conversation, make, copy, rename, delete or switch a profile, start AutoCAD under another profile, force-close AutoCAD or its headless engine, touch licensing or sign-in, or change a saved AutoCAD setting or the registry; a licence or sign-in window stops everything; every brief to a helper that may start AutoCAD repeats the rule in full (D-120, D-121).
2. **One named exception:** a robot may close (normal close first, then force) a TEST AutoCAD that it started itself that night on a test copy when it jams or crashes, and carry on; never one of Tim's, never one it did not start; a licence or sign-in window still stops everything (D-160, written into rule 1.9 on 18 Nov). **Narrowed by D-364 (20 Nov; the control room's call, Tim's to overturn):** a force applies only at night, before 8:00 am, with no stop flag up, only to an AutoCAD whose process the launcher itself created and recorded, only when it has not responded at all for three minutes on end or has crashed, and never while any other drawing is open in it (see NIGHT_TEST_SAFETY).

### When AutoCAD may be started

3. **Standing yes for testing:** AutoCAD may be started on TEST COPIES every night inside Tim's hours, 5:30 pm to 8:30 am weekdays and all weekend, without asking each day; never one of his drawings, never while his own AutoCAD is open (D-159, built on D-092). **Narrowed by D-364 (20 Nov; control room's call, Tim's to overturn):** no start between 8:30 am and 5:30 pm on weekdays, none while the stop flag exists, none unless Tim's switch file can be read and does not say in use, none while any AutoCAD is already running; a night pass is finished and its test AutoCAD closed by 8:00 am; no AutoCAD run on the night of 20 Nov.
4. **The hours win over the switch file** for the zero-plan trials, as long as no AutoCAD window of Tim's is open (D-093). **Superseded by D-364 item 2 (20 Nov; control room's call, Tim's to overturn; D-364 does not name D-093):** no start unless Tim's switch file can be read and does not say in use; a missing or unreadable switch means IN USE.
5. **Test copies only, never a live job** (D-092, D-159); **night tests take a copy of the office template under `C:\CE_WORK\civil_tests\`, and the template folder is read only** (D-197).
6. **Codex through its command line is allowed as the driver** (D-116).
7. **The brain-building chat never starts AutoCAD and never touches the installed plug-in** (D-127).
8. **One-off daytime windows Tim gave, now passed:** AutoCAD free from 12:15 pm for at least an hour on 18 Nov (D-207), and tests until 5:30 pm on 18 Nov with his approval (D-212). Neither is a standing yes.

### History of single words (one window each, not standing)

9. **Tim's force-close words covered one window each:** the stuck trial AutoCAD about 10:05 pm on 16 Nov (D-126); the jammed t1_seed run about 10:40 pm on 16 Nov, with "Keep trying tonight" and a changed method of short steps read back after each (D-130); the error window on t2_mouse, closed normally, on 17 Nov (D-155); the t2_mouse AutoCAD force-closed on 17 Nov (D-157).
10. **Trial restart after the licence incident:** "start the trials now" with limits added to the brief: no profiles, no force-closing, no licensing or sign-in, one AutoCAD at a time and none while Tim's is open, no registry writes, leftovers untouched (D-116).
11. **How the trial chat could open AutoCAD then:** by the double-click hand-off only (a made-up drawing handed to Windows), under his own profile, changing nothing, one at a time (D-122).

### The leftovers of the 16 Nov incident

12. **"Leave everything, I will look tomorrow":** the ZeroTrial profile, the load-safety setting (SECURELOAD) left at 0 in the unnamed profile, and the trial folder are not to be touched (D-111, restated in D-116). **SECURELOAD part: D-254 ("You set it to 1 for me") was superseded by D-255,** which leaves it at 0 everywhere (items 13 and 14).

### Added 18 Nov 2026, D-230 to D-297

13. **SECURELOAD stays 0 everywhere; nothing is changed (D-255, which supersedes D-254):** told it reads 0 in three profiles including the one named after him, Tim said: "WHAT DOES IT DO, IM HAPPY TO MAKE IT WHATEVER YOU NEED MOST? I THINK THERES SOME TESTING GOING ON AT THE MOMENT". The planning chat's call under that answer (planning chat's call from his rulings; his to overturn): leave it at 0 everywhere. Why: it is most likely his own long-standing setting, the night tests load the test plug-in without a prompt at 0, and at 1 his own LISP folders would start asking. It is to be looked at again before colleagues get the plug-in (their PCs should run at 1 with the CE folder trusted). In the same answer the AutoCAD running at 3:35 pm is "Not mine": it is the trials chat's fresh test copy.
14. **Before D-255: "You set it to 1 for me" (D-254)** was his yes in words for that one setting. **Superseded by D-255:** it was never done (an AutoCAD was running, and the read-only look found 0 in three profiles), and the call became "leave it at 0".
15. **The old plug-in and the new one together (D-258, not the recommended answer):** "New tools take PIT and CD now". The new Pit and Pipe tools answer to PIT and CD (PT and PIPE as well) straight away and the old ones stop answering to those names when both are loaded; how AutoCAD chooses when two plug-ins register the same name is not proven, so the build must make the new one win and prove it in the night run, or say plainly that it cannot. **Proven for one load order by D-351 (20 Nov):** with the new plug-in loaded after the old one by NETLOAD, PIT, PP and CD were answered by the new plug-in; CEWHOSE listed all three as declared by both.
16. **His alias file was edited once at his word (D-250, D-251):** the eleven aliases and the second spelling SERIAL were removed from his AutoCAD 2027 alias file on 18 Nov on his words (D-250; done, board item 20), a dated copy beside the file; Pp removed the same way (D-251); nothing else touched (see RIBBON_AND_NAMES item 19) and the plug-in still never edits the file. Whether the alias file counts as a "saved AutoCAD setting" under rule 1.9 is not said. **His "q" alias was put back by D-306 (19 Nov):** one line from the dated copy.

### Added 20 Nov 2026, D-298 to D-383

17. **Overnight, 18 to 19 Nov (D-302):** "can you keep things moving overnight test and maybe fix as many bugs as possible or doing something else useful whilst managing weekly usage i will do a reset tomorrow just use the time in a useful manner and consider you can use codex and its weekly usage and you have access to autocad and whatever you need". AutoCAD may be used on test copies under the standing night yes (D-159), rule 1.9 unchanged. Planning chat's reading (his to overturn): "whatever you need" does not lift rule 1.9, the no-install rule or the client-data rules.
18. **Installing the tools the work needs (D-304):** "you can test and build and install whatever you need to, to keep progress going. you might need to update codex to get it working if not use 6.1 but try to update it first". Planning chat's reading (his to widen): this covers tools such as Codex and test or build tooling; it does NOT install the new plug-in into his own AutoCAD, does not touch the old plug-in, does not lift rule 1.9. **Widened by D-306 (19 Nov)** (item 19).
19. **The held-back things, on the planning chat's judgement (D-306):** on installing into his AutoCAD, touching his AutoCAD or the old plug-in, typing PIT, PP or CD, retiring the old desk robot and putting q back: "i think you should be able to if you think you need it to keep work progressing". The planning chat may do any of them WHEN it judges the work needs it and must say what it did and how to undo it. Its use on 19 Nov, 12:10 am (planning chat's record): DONE the old desk robot's two AutoCAD lanes retired with their own stop flags, the stale flags moved to `desk_jobs\retired_19nov`, the disk guard left running, no scheduled task changed (undo: delete the two stop flags, move the two flags back, run `start_lanes.ps1`); DONE his "q" alias put back; NOT done: installing the new plug-in into his AutoCAD (not through the gate), changing any AutoCAD setting, profile or licence, touching the old plug-in, or letting a robot type PIT, PP or CD or press function keys (both hung or misfired on test copies). In D-305 he had asked "why cant you do the things nobody will do?"; that question alone gave no yes.
20. **No AutoCAD in his working hours (D-307):** while usage was tight to Fri 20 Nov midday, Codex did the building and testing and no AutoCAD ran in his working hours; AutoCAD only after 5:30 pm on test copies under rule 1.9 (D-342).
21. **The supervised check (D-325, D-351):** "i can do it snytime today when im in the office" (D-325); done by him on 20 Nov in his own AutoCAD on the test copy `check_copy.dwg` with the build staged on 19 Nov, by NETLOAD (D-351): PIT, PP and CD were answered by the new plug-in; the typed EXPLODE could not be checked because no pipe was drawn.
22. **Codex may drive the mouse in AutoCAD (D-326):** "yes whenever it needs it and it doesnt interfere with my work". Planning chat's reading (his to widen): only on test copies, only in a test AutoCAD the robot started, never while his own AutoCAD is open or he is using the PC, rule 1.9 in full in every brief, a licence or sign-in window stops everything, no PIT, PP or CD typed and no function keys until the supervised check is done.
23. **Night test safety (D-364, added to the same morning; the control room's call, NARROWING what a robot may do, Tim's to overturn):** see NIGHT_TEST_SAFETY for all ten items.
24. **Lighting up the real drawing saves nothing into his profile** must be proven before D-301 is built (R-012).

## Changed along the way

1. **"NOTHING starts AutoCAD overnight" (D-137, 16 Nov) and the day-by-day yes for 17 Nov (D-139) were replaced by the standing yes every night in his hours (D-159, 18 Nov).**
2. **"If AutoCAD jams the trial stops and leaves it for Tim; nothing is force-closed" (D-139) was replaced for test AutoCADs the robot started by the named exception (D-160, 18 Nov).**
3. **The switch file `.timos\autocad.json` (mayStart false) no longer rules the zero-plan trials inside the hours (D-093, 16 Nov).**
4. **"No trial starts AutoCAD until Tim agrees how" (PARKING_LOT P-08; THE_PLAN section 4 "ON HOLD") was settled by D-116, D-122 and then D-159.**
5. **"You set it to 1 for me" (D-254, SECURELOAD) was superseded by "leave it at 0" (D-255, 18 Nov; planning chat's call from his rulings; his to overturn).**
6. **The D-160 force exception was narrowed by D-364 (20 Nov; control room's call, Tim's to overturn).**
7. **"The hours win over the switch file" (D-093) was superseded by D-364 item 2 (20 Nov):** an unreadable or missing switch means in use.
8. **The standing night yes (D-159) was narrowed by D-364 (20 Nov):** finished by 8:00 am, not while any AutoCAD runs, not while the stop flag exists.
9. **The planning chat's reading of D-304 (no install into his AutoCAD) was widened by D-306 (19 Nov).**
10. **The removal of q (D-250) was undone by D-306 (19 Nov).**

## Still open on this subject

1. **The leftovers: the ZeroTrial profile, SECURELOAD at 0 in the unnamed profile, and the isolate folder** have waited on Tim since 16 Nov ("I will look tomorrow") (D-111, D-116, PARKING_LOT P-08). Waits on: Tim. D-255 leaves SECURELOAD at 0 everywhere for now; the ZeroTrial profile and the isolate folder are not mentioned.
2. **UNCLEAR: whether the night runs must still open AutoCAD by the double-click hand-off only (D-122) or may start it "the normal way" (LOOPS loop 2);** D-159 does not say. Waits on: Tim.
3. **The cause of the 16 Nov licence error is not proven** (PARKING_LOT P-08); recorded so no cause is assumed. Waits on: Tim (to close the item).
4. **The headless engine stays BLOCKED for unattended runs** until Tim decides; R-005 recommends not using it yet (R-003, R-005, D-161). Waits on: Tim.
5. **The old plug-in beside the new one:** Tim's installed plug-ins were loaded during every trial and any interaction is unmeasured (THE_PLAN section 6a); old and new on one PC, and which owns CD, stops a job (SITUATIONS I4); PIT and CD may already answer before CE loads (OQ-09); compare native behaviour with the old plug-ins loaded (OQ-10). Waits on: the build chat. **PIT and CD part answered by D-258 (18 Nov):** the new tools take them; not proven.
6. **The Properties palette trial is blocked because showing the palette changes a saved interface setting** (trial 5), which rule 1.9 forbids without Tim's word. Waits on: Tim.
7. **TimOS rule 1.8 also lists 2:00 to 3:00 pm as a free window;** D-092 and D-159 do not include it for AutoCAD tests. Waits on: Tim (only if a midday test window is wanted).
8. **SECURELOAD is to be looked at again before colleagues get the plug-in** (their PCs should run at 1 with the CE folder trusted) (D-255). Waits on: the planning chat, then Tim.

9. **The first night run after D-364** waits until the check room gives MERGE on both halves of the night scripts and the AutoCAD test room says go (D-364 item 10). Waits on: the check room and the AutoCAD test room.
10. **The typed EXPLODE question** stays open after the supervised check (D-351). Waits on: a test.

**Closed (D-298 to D-383):** which plug-in wins PIT and CD when both are loaded (open item 5, proven for one load order by D-351); the supervised check of PIT, PP, CD (done, D-351).

**Closed (D-230 to D-297):** whether to set SECURELOAD to 1 (D-254 superseded by D-255, left at 0); whether the AutoCAD running at 3:35 pm was Tim's (D-255, "Not mine", the trials chat's test copy).

## Where the detail lives

Added 20 Nov 2026: `DECISIONS.md` D-302, D-304 to D-307, D-325, D-326, D-342, D-351, D-364; see NIGHT_TEST_SAFETY and ROOMS_AND_HELPERS.

Added 18 Nov 2026: `DECISIONS.md` D-250, D-251, D-254, D-255, D-258.

1. `C:\TimOS\RULES.md` rule 1.8 and rule 1.9 with its exception.
2. `DECISIONS.md` D-092, D-093, D-111, D-116, D-120 to D-122, D-126, D-127, D-130, D-137, D-139, D-155, D-157, D-159, D-160, D-197, D-207, D-212.
3. `PARKING_LOT.md` P-08; `stage4\TRIALS_BRIEF.md`; `stage4\TRIAL_RESULTS.md`; `reference\research\R-005_NO_SCREEN_ENGINE.md`.
