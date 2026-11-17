# Speed: the plug-in and the PC (part of the plan, draft 1)

**Why this file exists.** Tim, 18 Nov 2026: "THE OTHER THING TO CONSIDER IN THE FULL PLAN IS COMPUTER AND PLUGIN SPEED AND SMART, EFFICIENT WAYS TO MAKE PERFORMANCE STRONGER AND BETTER". Written by the planning chat. **Status: draft.** The time limits in section 2 are the planning chat's proposals, not Tim's rulings.

## 1. The rule

Speed is a requirement, checked like a sum. Every tool has a time limit for each thing a drafter feels. The night run measures them every night and a tool that goes over its limit is a fault, the same as a wrong figure. Nothing is called faster or slower without a measured figure.

## 2. The time limits (DRAFT, for Tim to change)

1. **AutoCAD starts:** the plug-in adds no more than 1 second, and loads its tools only when first used.
2. **A drawing opens:** the self-check takes no more than 1 second on a 500-object job, and never holds up the drawing appearing.
3. **A window opens:** within 0.3 of a second of the command.
4. **Typing in a window:** every figure and the preview follow within 0.1 of a second.
5. **Moving a pit with its pipes:** within 0.1 of a second on a 2,500-object drawing.
6. **Idle:** when you are not using a CE tool, the plug-in does nothing at all. No timers, no watching every command.
7. **Plotting, saving, panning and zooming:** no measurable change with the plug-in loaded.

## 3. What is already measured

1. The brain works out and checks a 200-pit job in about 16 thousandths of a second (slowest 38).
2. A real AutoCAD preview picture redraws in 21 to 39 thousandths of a second (trial 6).
3. Moving joined objects costs about 40 thousandths of a second on 2,500 objects (trial 4).
4. Not measured yet: AutoCAD start with the plug-in, drawing open on a big real job, a window opening inside AutoCAD, and the plug-in beside Tim's other installed plug-ins.

## 4. The smart ways (how the build keeps it fast)

1. **Work out only what changed.** A change to one pipe re-works its run, not the whole job.
2. **Do nothing until asked.** Tools load on first use; the open-drawing check runs once, quietly, after the drawing is on screen.
3. **Never watch every command.** Joined pipe ends move at the end of a command, once (trial 1), not on every mouse move.
4. **Ordinary objects only.** No special objects for AutoCAD to redraw the slow way; a sheet with no plug-in is as fast as plain AutoCAD.
5. **One undo step per action,** so undo is instant and never replays many small steps.
6. **Standards read once** at start, from the lists, then held in memory.
7. **The preview is AutoCAD's own picture** of a small area round the object, not a second drawing engine.
8. **Notes on objects stay small,** so drawings do not swell and save times do not grow.

## 5. Tim's PC during the working day

1. Building and testing use the PC's power. Recorded on 29 Sep 2026: builds and tests starved his AutoCAD.
2. Rule: between 8:30 am and 5:30 pm on weekdays the build chat runs one helper at a time, no full test passes back to back, no click tests on screen, no AutoCAD. Heavy runs happen at night.
3. If AutoCAD feels slow while a side chat is working, Tim says "slow" and the build work stops until 5:30 pm.

## 6. How it is checked

1. Each night run records every time in section 2 that it can measure, in `BUILD_LOG.md`, beside the last night's figure.
2. A real job (coded name, section 3 of `LOOPS.md`) gives the big-drawing figures.
3. The director's summary carries one line: slowest thing measured, and whether it is inside its limit.
