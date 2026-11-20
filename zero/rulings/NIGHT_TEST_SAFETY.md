# Current rulings: Night test safety (when a robot may start, drive and close a test AutoCAD)

Current rulings as of 20 Nov 2026 (Melbourne), from decisions D-001 to D-383 (this page holds D-302 to D-364 on its subject). If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

(Added subject, 20 Nov 2026: the safety rules for robot runs in a test AutoCAD. AUTOCAD_RULES keeps rule 1.9, its exception and the standing night yes, each marked where this page narrows it.)

**D-364 is the control room's call, NARROWING what a robot may do, Tim's to overturn.** It was asked for by the check room after it found the night scripts on the main line not safe to run: nothing read the clock, the stop flag or Tim's switch, and the launcher took a test AutoCAD as "its own" by start time and title instead of by having started it.

## What is decided now

### What counts as the robot's own AutoCAD

1. **Only one it created (D-364 item 1):** the launcher counts an AutoCAD as its own ONLY if it created that process itself and recorded its process number at the moment of creation; never by title or start time.
2. **The record must be whole (D-364 item 5, added 20 Nov, about 11:40 am):** the record of "its own" AutoCAD must be whole and sound to count; a damaged or partial record means NOT its own.
3. **The test drawing by its full path (D-364 item 6):** the test drawing is known by its FULL path, never its short name; nothing is closed without saving unless it is that exact file in the test folder.

### When it may start

4. **Never in his hours, never against the switch (D-364 item 2):** no start between 8:30 am and 5:30 pm on weekdays; none while the stop flag exists; none unless Tim's switch file can be read and does not say in use (a missing or unreadable switch means IN USE); none while any AutoCAD is already running.
5. **Finished by 8:00 am (D-364 item 3):** a night pass must be finished and its test AutoCAD closed by 8:00 am.
6. **No AutoCAD run on the night of 20 Nov (D-364 item 10):** with seven blockers the fix is not rushed to a 5:30 pm deadline; the first run is whenever the check room gives MERGE on both halves and the AutoCAD test room says go, at night or at the weekend.

### Stopping and closing

7. **Stop flag up or 8:00 am arrives mid-pass (D-364 item 4):** stop sending at once; try ONE normal close, without saving, of its own test AutoCAD, and only if no licence, sign-in or unknown window is showing; NEVER force in that situation; if it does not close, leave it open and write a note for Tim.
8. **Other drawings open (D-364 item 7):** no quit, close-all or force is ever made while any other drawing is open in that AutoCAD: stop and leave it with a note.
9. **"Still running" is not "jammed" (D-364 item 8):** a force under D-160 is allowed only when the test AutoCAD has not responded at all for three minutes on end, or has crashed; a busy PC or a lost front window means stop sending, wait, one normal close, never a force. The D-160 exception applies only at night, before 8:00 am, with no stop flag up (D-364 item 4).

### What counts as a pass

10. **Only what AutoCAD answered (D-364 item 9):** a command AutoCAD does not recognise is a FAIL in words; "sent" never counts as "done"; a pass reads green only from what AutoCAD answered.

### Tim's words on robot use

11. **Overnight testing allowed under the night yes (D-302):** "consider you can use codex and its weekly usage and you have access to autocad and whatever you need"; test copies, the standing night yes (D-159), rule 1.9 unchanged.
12. **Codex may drive the mouse (D-326):** "yes whenever it needs it and it doesnt interfere with my work". Planning chat's reading (his to widen): test copies only, in a test AutoCAD the robot started, never while his own AutoCAD is open or he is using the PC; rule 1.9 in full in every brief; a licence or sign-in window stops everything.
13. **No robot types PIT, PP or CD or presses function keys** until the supervised check is done (D-326); both hung or misfired on test copies (D-306 item 3). His supervised check was done on 20 Nov (D-325, D-351); whether that lifts this bar is not said.
14. **No AutoCAD in his working hours (D-307, D-342):** AutoCAD only after 5:30 pm on test copies under rule 1.9.

## Changed along the way

1. **The D-160 force exception (a robot may force-close its own jammed test AutoCAD) was narrowed by D-364 (20 Nov; control room's call):** only at night before 8:00 am, no stop flag, process created and recorded by the launcher, no response for three minutes or crashed, no other drawing open.
2. **The standing night yes, 5:30 pm to 8:30 am (D-159), was narrowed by D-364 (20 Nov; control room's call):** finished and closed by 8:00 am; not while any AutoCAD runs; not unless the switch file can be read and does not say in use.
3. **"The hours win over the switch file" (D-093) was superseded by D-364 item 2 (control room's call; D-364 does not name D-093).**
4. **D-364 was added to the same morning (about 11:40 am)** after the check room's second pass raised the blockers on the night scripts to seven: items 5 to 10.

## Still open on this subject

1. **MERGE on both halves of the night scripts from the check room, and "go" from the AutoCAD test room,** before the first run (D-364 item 10). Waits on: the check room, then the AutoCAD test room.
2. **Whether the supervised check of 20 Nov (D-351) lifts the bar on robots typing PIT, PP and CD** (D-326). Waits on: Tim.
3. **Tim has not confirmed D-364;** it is the control room's call. Waits on: Tim (to overturn only).

## Where the detail lives

1. `DECISIONS.md` D-302, D-306, D-307, D-325, D-326, D-342, D-351, D-364 (and its addition of 20 Nov, about 11:40 am); D-093, D-159, D-160 for what it narrows.
2. `C:\TimOS\RULES.md` rule 1.9 and its exception; `ROOMS.md` (the check room and the AutoCAD test room).
