# Settings differences: Tim's saved setup, the colleague starting values, the built-in values

**Status: READ-ONLY FINDINGS, 12 Nov 2026 (lane trust-core-ribbon, queue item 2).** Nothing was changed. Values only: no folder paths, job names or file names are shown. Feeds card TRUST-03 (same settings for everyone).

**How it was read:** a copy of Tim's saved settings file (last saved 4 Oct 2026) was laid over CE's built-in values the way the loader does; the shipped colleague starting values were laid over the built-ins the way a fresh login gets them. The two results were compared value by value, about 590 values each. This is a close copy of the real loading, not the real loading itself.

---

# FOR TIM

**Your setup differs from a new colleague's on 27 office-type values.** 10 values differ between a new colleague and CE's own built-in values (the colleague starting values were set to match your habits). Your file also holds about 20 memory values (window positions, recent lists, tour flags) that are yours alone and should never be sent to anyone.

**What a colleague gets today that you do not have:**

1. **Pipe grades for big pipes.** You: 225 pipe 1 in 200, 300 pipe 1 in 250, 375 pipe 1 in 300. Colleague: 1 in 100 for all three.
2. **Pit drop between pipes.** You: 5 mm. Colleague: 20 mm.
3. **Starting pit size.** You: 600 x 900. Colleague: 450 x 450.
4. **Detention pit widths and the SPS radius.** You: 0. Colleague: 450 each and 900.
5. **Driveway lid class.** You: C. Colleague: B.
6. **Pit label corner.** You: top right. Colleague: bottom right.
7. **Steepest grade warning.** You: 1 in 20, marked "Assumed, office value to confirm", not confirmed. Colleague: no limit, warns above 1 in 10, marked confirmed.
8. **Default grade wording.** You: "100 MIN." Colleague: "100".
9. **Starting inverts typed in the pipe window.** You: 19.00 and 18.50 (left from a job). Colleague: 1.10 and 1.20.
10. **Charged-system destination and pit cover level.** You: tank and 21.00 (left from a job). Colleague: blank.
11. **Remember my pipe-window values.** You: off. Colleague: on.
12. **Pipe object upgrade.** You: Automatic. Colleague: On. (Same result on AutoCAD 2027 since 29 Oct.)

**What this means for step 3:** items 1 to 3 and 5 to 6 look like real office or habit values. A colleague would draw different pits and grade pipes differently from you with no warning. The plan needs your word on which are office values (everyone gets them) and which are only yours.

---

## 1. Differences, colleague starting values against CE's built-in values (10)

1. **New pipe grade:** method "set my own" at 1 in 100 (built-in: default minimum, blank).
2. **Pipe object upgrade:** On (built-in: Automatic).
3. **Remember my pipe-window values:** on (built-in: off).
4. **Old starting values moved:** true (built-in: false). A marker, not a choice.
5. **Rising main destination:** tank (built-in: blank).
6. **Pit lid type:** Class A grate (built-in: Class C grated lid).
7. **Object-snap setting for drawing and for text:** 1151 and 0 (built-in: 5247 and 5887).
8. **Screen theme:** dark (built-in: follows AutoCAD).

## 2. Differences, Tim's saved file against CE's built-in values (53 values; 27 are office-type and listed in the top section)

1. **Also differs from the built-ins, and equals the colleague value:** pit lid type (Class A grate), object-snap values, screen theme dark, grade method "set my own" at 100, rising main destination tank.
2. **Memory values, yours alone, not office values:** window sizes and positions for the Civil Hub and the Pit Schedule, the Pit Schedule column layout, recent pipe sizes and materials and starting levels, last slab type, tour opened and tip counts, balloon and detection word lists, layer order rules, pavement types, install records.
3. **A kept note about job folders:** your file holds remembered pipe choices for about 8 job folders, all test folders. It should never be copied to others.

## 3. Values only in Tim's file (46 keys)

Larger-pipe minimum grades for 450 to 750 (5 values), an editor layout flag, two tip counts, three remembered tank plans, and the job-folder memory above. None is in the shipped colleague values or the built-ins.

## 4. Not known

1. **Whether Tim's differing grades are office policy or his habit.** The file does not say. The 225, 300 and 375 grades carry no source note.
2. **What other colleagues' files hold.** No colleague PC was read (probe P5).
3. **How much of Tim's file is stale.** Last saved 4 Oct, before the C-77 to C-79 trains added switches; those read as built-in values here.
4. **Whether the loader treats a missing value exactly as the built-in.** Read from code, not run on a colleague login.
