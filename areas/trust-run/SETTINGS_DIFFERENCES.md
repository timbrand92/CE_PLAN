# Settings differences: Tim's saved setup, the colleague starting values, the built-in values

**Status: READ-ONLY FINDINGS, 12 Nov 2026 (lane trust-core-ribbon, queue item 2).** Nothing was changed. Values only: no folder paths, job names or file names are shown. Feeds card TRUST-03 (same settings for everyone).

**How it was read (corrected 13 Nov, after the review):** a copy of Tim's saved settings file (last saved 4 Oct 2026) was read the way the loader reads it, and the 62 "last used" fields from his second file (`CD_RecentValues.json`, the remembered values) were laid on top, as CE does at start-up. The first version of this note missed that second file, so the pit size, pit label corner and starting levels it listed were last-job values. The new colleague starting values and the built-in values were read the same way. Compared value by value, about 590 values each. Still a close copy of the real loading, not the real loading itself.

---

# FOR TIM

**Seven differences would change what a new colleague sees on a job. They are real office-type values. Your setup also differs on 13 "last used" values (pit size, pit type, label corner, starting levels, cover level), which are NOT office values: they are just what your last job used and must never be sent to anyone.** Your file also holds about 20 memory values (window positions, recent lists, tour flags) that are yours alone.

**The seven real differences:**

1. **Pipe grades for big pipes.** You: 225 pipe 1 in 200, 300 pipe 1 in 250, 375 pipe 1 in 300. Colleague: 1 in 100 for all three. *On a job:* the same 300 pipe draws at a different fall on the two PCs.
2. **Pit drop between pipes.** You: 5 mm. Colleague: 20 mm. *On a job:* the downstream invert at a pit is 15 mm lower on the colleague's drawing.
3. **Driveway lid class.** You: C. Colleague: B. *On a job:* the lid class on the pit schedule differs for a pit in a driveway.
4. **Steepest grade warning.** You: 1 in 20, marked "Assumed, office value to confirm", not confirmed. Colleague: no limit, warns above 1 in 10, marked confirmed. *On a job:* a 1 in 12 pipe warns on your PC and not on a colleague's.
5. **Default grade wording.** You: "100 MIN." Colleague: "100". *On a job:* the pipe label reads differently.
6. **Remember my pipe-window values.** You: off. Colleague: on. *On a job:* a colleague's New Pipe window reopens with the last size and material, yours always starts fresh.
7. **Pipe object upgrade wording.** You: Automatic. Colleague: On. Same result on AutoCAD 2027 since 29 Oct.

**The 13 "last used" values (not office values, shown only so you can see why the first version of this note was wrong):** pit size 600 x 600 and detention widths 1200 / 600 / 600, pit type "detention pit", lid strength A, cover text corner top left, starting inverts 18.15 and 18.05, pit cover level 5.40, charged-system destination tank, and the "create text" tick off. A new colleague starts from 450 x 450, a grated pit, lid C, bottom right, inverts 1.10 and 1.20. *On a job:* the first Place Pit click gives a different pit on each PC, and that is by design: CE remembers each person's last use. If you want colleagues to START from your usual pit size, that is the colleague starting file, not the office setup (decision for you).

**What this means for step 3:** items 1 to 5 look like real office values; the plan needs your word on which are office values (everyone gets them) and which are only yours. The office setup now never carries the last-used values or any folder.

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

---

## Correction log

1. **13 Nov 2026 00:20:** the review of the office-setup pull request found that the first version of this note never read `CD_RecentValues.json`. Re-read with it. Result: of the first top twelve, six (pit size, label corner, starting inverts, cover level, charged-system destination, detention widths) are last-used values and have been taken out of the real differences; the rest stand. The old text of sections 1 to 4 below was written before this correction; where it lists pit size, label corner, inverts or cover level as differences, read them as last-used values.
