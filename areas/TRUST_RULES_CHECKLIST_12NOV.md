# The five trust rules as a checklist, and the one-page tool note

**Status: DRAFT (12 Nov 2026).** The five rules are from `areas\V3_TRUST_PLAN_06NOV.md` section 6 (proposal). Part of area TRUST (`areas\trust-plan.md`).

---

# FOR TIM

**A tool is Core only when every box below is ticked. A tool with one box open stays off the ribbon, or stays on with that fault written on its note, and that is your call each time.**

## 1. The checklist

**Rule 1: nothing changes a drawing without showing you first**

1. [ ] The tool changes only what its name says it changes.
2. [ ] Anything else it would change (CE's record, links, labels, levels) is shown before it happens, or printed in one line as it happens.
3. [ ] Cancel or Escape, at every point, leaves the drawing and CE's record exactly as they were. Proven by the robot, not assumed.
4. [ ] One accepted action is one U. Proven by the robot.
5. [ ] It never saves the drawing.
6. [ ] It leaves locked layers, Xrefs and REFEDIT alone, and says so in a plain line.

**Rule 2: everyone runs the same thing**

1. [ ] The tool gives the same result on two Windows logins on the office setup.
2. [ ] The same result in a millimetre drawing and a metre drawing of the same job.
3. [ ] It works on AutoCAD 2027 and on 2022 to 2024, or it says plainly what it cannot do there.
4. [ ] No value it uses is fixed inside the tool; each is on Settings.
5. [ ] It does not carry a level from one drawing into another.

**Rule 3: guesses are never shown as facts**

1. [ ] Where the drawing gives no value, the tool shows Unknown.
2. [ ] Anything it works out or proposes is marked as worked out or proposed, with the reason.
3. [ ] Where two answers are possible it asks or shows Unknown; it does not pick the nearer.
4. [ ] Its messages use drafting words only.

**Rule 4: you have used it on real drawings**

1. [ ] Robot: every case passed, including a deliberately broken twin that failed.
2. [ ] Codex: everything that must be seen was looked at in real AutoCAD, on copies.
3. [ ] The test set read the same before and after this tool's change.
4. [ ] Tim: about three working days on real jobs, with no lost work, no crash, nothing unexplained.
5. [ ] Tim has said, in words, that it is in. The date and his words are on the note.

**Rule 5: the tool has its note**

1. [ ] The one-page note below is written and matches the installed build.
2. [ ] Every open fault on the tool is on the note with its bug number.
3. [ ] The note says how to undo what the tool does.

## 2. Who can tick what

1. **The robot** ticks only what is read from a drawing as a value.
2. **Codex** ticks only what it has seen on screen, with the screenshot kept.
3. **Tim** ticks rule 4 lines 4 and 5, and anything that is engineering judgement.
4. **Nobody** ticks a box from a build result.

## 3. The one-page tool note

One page per Core tool, kept in `04_REFERENCE\core-tool-notes\` and shipped in Help. When a colleague asks "why did it do that?", the answer is on this page.

```
TOOL NOTE: <plain name> (<command>)
Core since: <date>, on Tim's word: "<his words>"
Build this note describes: <version>

1. WHAT IT DOES
   Two or three lines, in drafting words.

2. WHAT IT CHANGES IN THE DRAWING
   What it draws. What it stores. What else it touches, if anything.

3. WHAT IT WILL NOT DO
   The limits a colleague is most likely to hit.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Each question and its default.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   What that means and what to do.

6. HOW TO UNDO IT
   U once, or the named steps.

7. KNOWN FAULTS
   Bug number, one line each, and the way round it. "None known" if none.

8. ON AUTOCAD 2022 TO 2024
   Same, or what differs.

9. PROVEN BY
   Robot cases: <n>. Codex looks: <n>. Tim's trial: <dates>.
```

## 4. Worked example (made up, to show the shape; not a real record)

```
TOOL NOTE: Place a pit (PIT)
Core since: not yet
Build this note describes: draft

1. WHAT IT DOES
   Places a stormwater pit, with its number and cover level label, and carries on placing until you press Esc.

2. WHAT IT CHANGES IN THE DRAWING
   Draws the pit and its label. Adds the pit to CE's record. Today it also updates the rest of CE's record without saying (plan step 5).

3. WHAT IT WILL NOT DO
   It does not join pipes to the pit. It does not choose the invert.

4. WHAT IT ASKS YOU, AND WHAT ENTER MEANS
   Pit size and type in the window. Then the point. Esc at the label places no label.

5. WHEN IT SAYS UNKNOWN OR "NEEDS CHECKING"
   Not applicable to placing.

6. HOW TO UNDO IT
   U once per pit.

7. KNOWN FAULTS
   To be listed from the bug file before this note is real.

8. ON AUTOCAD 2022 TO 2024
   Same, started from the CE CVL menu.

9. PROVEN BY
   To be filled from the records.
```

## 5. First use of the checklist

When the Civil sort is settled, each of the buttons on the two tabs gets this checklist run against it once, from the records, before any code. The result is a plain list: which boxes each tool already passes, which are open, and which have never been checked. That list, not the old percentages, is what "how far is the core" means.

## 6. Not known yet

1. How many of the core tools pass rule 1 line 3 (Cancel leaves everything as it was). BUG-650 shows at least one does not.
2. How many pass rule 2 line 2 (metre drawings). Several known faults say some do not.
3. Whether Help can carry the notes as they are, or needs its own layout.
