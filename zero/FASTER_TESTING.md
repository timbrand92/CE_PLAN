# Faster testing: what is slow, and what to change

**Why this page exists.** Tim, Sun 22 Nov 2026: "ok so the testing takes forever essentially, lets focus really hard on this and see what we can do to best improve this as much as we possibly can, do research do whatever it takes to find improvmeentn". Written by the control room at 2:50 pm the same day. Measured figures are marked MEASURED; everything else is the control room's judgement.

## 1. What was measured (Fri 20 Nov 11 am to Sun 22 Nov 2 pm)

1. **MEASURED: no build passed its check first time.** The check room wrote 10 "final verdict" sections, 9 "second verdict" sections and 11 "read-back" sections. Every build went: check, fix, check, fix, final check, control-room ruling, one more fix, read-back. Four passes each.
2. **MEASURED: three builds merged in that time** (rounding, settings store, privacy fix). The Pit window was first built at 11:30 am Saturday and is still not merged.
3. **MEASURED: the same kinds of fault come back in every build.** Lines in the verdict pages that mention each kind: units (mm, cm, m drawings) 122; "a cheat could pass this test" 99; something cut off in a window 37; a restated test 36; a second place that works out a number 21.
4. **MEASURED: nothing has run in AutoCAD since Thu 19 Nov 9:02 pm.** Every judgement since has been made from code, tests and pictures.
5. **MEASURED: about ten and a half hours on Sunday were lost** because finished jobs sat unread after the desktop app restarted.
6. **Not measured:** how long one full test run takes, and how much Codex usage is left this week.

## 2. Why it is slow (the control room's reading)

1. **Every finding blocks.** A cut-off caption stops a merge the same way a wrong invert level does.
2. **The checker finds new things each round.** It is asked to hunt, so it always finds something, one round at a time.
3. **The builder does not run the checker's known tests before handing over.** The same five kinds of fault are found by a person reading, round after round, when a machine could find them in minutes at the builder's desk.
4. **Builds are too big.** The Pit window arrived with 70 restated tests in one hand-over.
5. **No AutoCAD in the loop.** Without "open it and look", arguments are settled by more reading.
6. **A guard rail took the lanes.** The file safety checker (which only the night route, block drawings and release need) took most of Saturday night and all of the control room's rulings.

## 3. What to change, biggest gain first

1. **Only four kinds of finding may block a merge.** A wrong figure that would reach a drawing; an edit that can damage a drawing; a breach of Tim's security rule; something built against one of Tim's own answers. Everything else merges and goes on a follow-up list that the next build clears. Expected: most builds merge after one or two passes, not four. NEEDS TIM'S YES (it changes the gate).
2. **A pre-flight the builder must pass before hand-over.** One command that runs: compile; all tests; "nothing cut off" for every window, every state, both approved sizes; the mm, cm and m cases; "only one place works out a number"; and a list of any test whose expected answer changed, each with the ruling that allows it. The check room reads the pre-flight result first and refuses a hand-over without it. ORDERED TODAY.
3. **Let a machine hunt for weak tests.** "A cheat could pass" is found today by a checker reading code. Mutation testing does this automatically: it makes small wrong changes to the code and reports which ones no test catches. Stryker.NET is the standard tool for C#. Its documents list support for .NET 5 and later; support for .NET 10 is not confirmed, so a one-hour trial on the rounding routine comes first. TRIAL ORDERED TODAY.
4. **Put AutoCAD's engine back in the loop, with no robot.** AutoCAD ships a headless engine (the Core Console) that opens a drawing and runs commands with no window, no mouse and no profile. Other plug-in makers run their tests inside it (the open-source CADtest project does exactly this), and this project already has the part that hosts tests inside AutoCAD. It would prove the things that matter most (pits, pipes, levels and labels really written to and read from a drawing) in minutes, on drawings the tool itself makes. It cannot prove windows or grips. NEEDS TIM'S YES, because AutoCAD testing is stopped and rule 1.9 applies in full.
5. **Tim's own half hour, once a week.** He loads the current build in a blank test drawing and clicks. NEEDS TIM'S YES (it loads the new plug-in into his AutoCAD once, on a drawing that is not a job).
6. **Smaller builds.** No hand-over bigger than one window or one command, and none that restates more than ten tests. ORDERED TODAY.
7. **The guard rail gets one lane.** The file safety checker keeps one Codex lane; the Pit, Pipe and grips work gets the rest. ORDERED TODAY.
8. **Nothing waits on a chat being alive.** The build room's new watcher writes every finished job to a file. A Windows scheduled task that wakes the rooms would close the gap fully, but it is a standing change to the PC, so it NEEDS TIM'S YES.

## 4. What research found

1. **Testing AutoCAD plug-ins:** there is no official Autodesk guide. The common practice is the one this project already follows (sums in one part with no AutoCAD in it, AutoCAD writing in another) plus running tests inside AutoCAD or its Core Console. Sources: Autodesk .NET forum threads on NUnit and testing commands; the CADtest project.
2. **Mutation testing:** Stryker.NET; Microsoft documents it for .NET. .NET 10 support unconfirmed.
3. **A throwaway place with AutoCAD in it:** Autodesk's cloud service (Design Automation) runs the same Core Console on Autodesk's machines. It needs the plug-in packaged and uploaded for each run and has a cost; it does not allow opening other drawings from inside a run. Worth knowing for Tim's choice of where the guard-removal proof may run; not recommended for everyday tests.

## 5. Honest limits

1. No figure here predicts a date. The gain from item 1 is a judgement, not a measurement.
2. Items 2, 3, 6 and 7 are within the control room's say and are ordered. Items 1, 4, 5 and 8 wait for Tim.
