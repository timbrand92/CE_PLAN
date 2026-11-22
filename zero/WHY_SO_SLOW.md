# Why building the plug-in is slow, and what to change

**Written Sun 22 Nov 2026, about 3:05 pm, by the research side session at Tim's request.** His words: "im confused because building this plugin is taking forever and i seem to think its quite a simple task ... can you see why its taking so long and what we can do to improve. there has to be stuff out there for this kind of development. literally anything!"

Marks: MEASURED (counted today from the files), REPORTED (said by others), MY JUDGEMENT.

## The short answer

1. **You are right: the tool itself is not hard.** A pit command, a pipe command, two windows, labels, grips and a few checks is normal AutoCAD plug-in work.
2. **The code is mostly written already.** MEASURED: in 7 days the plug-in has about 26,000 lines. That is about 4,900 for the sums, 6,200 for writing to the drawing, 4,900 for the AutoCAD link and 10,100 for the windows.
3. **But nothing has reached you.** MEASURED: installed 0, accepted 0.
4. **The time is going on paperwork and checking, not building.** MEASURED, 16 to 22 Nov:
   1. 460 written decisions, about 66 a day.
   2. 42 check verdict pages and 31 rulings pages.
   3. About 1.5 MB of plan, design and check text.
   4. Five chat rooms, with a seven-step relay for each piece of work.
   5. 282 branches.
   6. 64,000 lines of tests and test bench, 2.5 times the plug-in itself.
5. **A side project is taking a large share.** It is the "file safety checker": a gate that checks every file before it may be built or run. MEASURED: it has 490 tests of its own. Its latest design would have refused 108,084 pieces of ordinary code (D-458). Three of the last five decisions are about it, not about pits or pipes.
6. **Every build is judged against hundreds of written rules,** so it never passes first time. MEASURED: 0 of the last builds passed first time. The rules include 31 screen rules, 141 tool answers and 37 questions waiting on you.
7. **There is no real feedback.** Nothing has run in AutoCAD since 19 Nov. Arguments get settled by more reading instead of "open it and look".

## Why it got this way (MY JUDGEMENT)

1. **Every past failure added a rule and a check.** Each one made sense on its own. Together they are a toll gate on every change.
2. **The plan tries to settle everything before you touch anything.** Software goes faster the other way round: a rough working tool in your hands early, then fixes from what you see.
3. **AI builders write fast, so the system adds AI checkers, then checkers of the checkers.** The work becomes managing the robots.

## What other people do (things that exist)

1. **"Walking skeleton" or "thin slice".** REPORTED (standard software practice). Build the thinnest version that works from end to end on day one: type PIT, a pit lands with its label. Put it in the user's hands, then thicken it daily. It is the opposite of finishing each layer first.
2. **Small batches and fast feedback.** REPORTED (the DORA research programme, Google's yearly State of DevOps reports). Teams that ship small changes often are both faster and have fewer failures. Big hand-overs and long review queues predict slow and unstable work.
3. **Machines check, people decide.** REPORTED (common practice). Automated tests, the headless AutoCAD run and the mutation hunter replace most review rounds. A person looks only at what a machine cannot judge.
4. **One builder, one checker, one loop.** MY JUDGEMENT, from the research write-ups on AI agents. Agents do best with a tight loop: build, run the tests and headless AutoCAD, fix, repeat, inside one session. Relays between rooms lose hours; on 22 Nov, ten and a half hours were lost when the app restarted.
5. **Ready-made code libraries.** REPORTED. Linq2Acad (shorter drawing-reading code) and Autodesk's own project templates. They are a small gain; the code is not the bottleneck.
6. **Ready-made products that already do pits and pipes.** REPORTED. Civil 3D Pipe Networks, Civil Site Design (a Victorian product that runs in AutoCAD and BricsCAD) and InfoDrainage. Mentioned only because you said "literally anything". The office chose to build its own, and this page does not reopen that choice.

## What to change, biggest gain first

1. **Put a working Pit tool in your AutoCAD this week, rough edges and all.** Load it on a test copy, use it for 15 minutes, say what is wrong. Then a new build each day.
   - **Needs:** your yes to load a test build. This was already asked as "his own weekly half hour".
2. **Pause the file safety checker.** Keep only the protections that guard your drawings and your machine: the path guard, no AutoCAD settings, and the API key rule. Restart it at release time if wanted.
   - **Needs:** your yes, because it is the control room's call (D-456, D-458 are DRAFT and say you may overturn them).
3. **Freeze new rules for two weeks.** Your four blocking kinds (D-460) are the only gate. Everything else goes to a list.
   - **Needs:** your yes.
4. **Cut five rooms to two for building.** One build-and-check loop that runs its own tests and the headless AutoCAD run before hand-over, plus the control room. Your room stays for interviews.
   - **Needs:** the control room's call.
5. **Headless AutoCAD checks on every build.** Done today: your yes, recorded as D-461.

## What could go wrong

1. **A rough tool in your hands could annoy you.** It is on a test copy, never a job, so it cannot hurt a drawing.
2. **Pausing the gate removes a guard.** The path guard and rule 1.9 stay, and those are what protect your files and AutoCAD.
3. **Fewer checks may let small faults through.** Your four kinds still block anything that could reach a drawing wrong.
