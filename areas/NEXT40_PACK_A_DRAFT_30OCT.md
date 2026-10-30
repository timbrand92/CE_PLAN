# Robot cases drafted for top-40 items 5 to 15 (CE_ACAD / robot / draft / 33, Fri 30 Oct 2026, about 12:10 to 12:30 Melbourne, Team Opus)

**What this is.** A drafting job. Nothing was run in AutoCAD, nothing was built, no driver or runner call was made. Only the offline validate ran (it reads the case files and starts no AutoCAD). Cases sit in `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_next40_a_30oct\`; the chain spec is `C:\ce-fx\retest\spec_next40_a.txt`.

---

## ANSWER FIRST

1. **Written: 11 cases and 10 twins, 21 files, all valid offline (0 invalid).** N45 to N54 as the list names them, plus N52b, because two of the four "carry on" commands behave differently from the other two.
2. **8 items are ready for the robot** (items 5, 6, 7, 9, 11, 12, 14, 15).
3. **2 items can only be part-proved with today's robot tools** and need a Codex look or a robot change: item 8 (job timer) and item 10 (Enter repeats CD, one unproven step).
4. **Item 13 is split.** Downpipe and overflow carry on (robot-ready, N52). Raingarden and floor waste do NOT carry on in the installed build, so N52b is written to fail today on purpose.
5. **Three things the installed source shows that Tim or the desk should know.**
   1. No command starting with CS exists yet, so "new Structural commands are named CS" cannot be tested.
   2. The trench drain (CDTG), raingarden (CDRG), floor waste (CDFW) and AG drain (CDAGI) commands each stop after one item.
   3. The plan says only "deleting CE link records" may ask a question, but the source has no such question at all.

---

## FOR TIM

1. **Item 5 and 6, new command names and the CDWT / CDLPD short codes: N45. Robot.** It types CDWT, CDLPD, CDDIAG, CEFIND and CE_VERSION in turn. It checks that each one opens its window or prints its line, and that AutoCAD never says "Unknown command". No command name starting with CS exists yet, so that half is not built.
2. **Item 7, old typed names keep working: N46. Robot.** It types four old names: PITEDIT, PIPEEDIT, CDSETUP and TG. Each must still reach its command, for example PITEDIT on pit P3 opens the Edit Pit window. One thing for you: CDSETUP prints "CDSETUP is now Design (CDDESIGN)", but the plan says old names should work silently.
3. **Item 8, the job timer starts per job drawing: N47. Part robot, the rest needs a Codex look or a robot change.** The robot can prove a drawing outside any job folder is not timed, even after it sits idle past the limit. It cannot yet open a drawing saved inside a job-numbered folder such as "25-12 ...". That is the half that proves a real job drawing starts its timer.
4. **Item 9, every pipe labelled, never "TYP.": N48. Robot.** It draws three identical 20 m pipes side by side, the case where someone might be tempted to write "TYP.". Each pipe must carry its own "225 DIA. UPVC PIPE AT 1 IN 200" style label.
5. **Item 10, Enter repeats CD with the last size: N49. Robot, but one step is unproven.** It draws a 150 mm pipe, then presses Enter at the empty command line. The next New Pipe window must already show 150. If the robot cannot press a bare Enter that way, the step fails as a tool problem and Codex needs to add an Enter key.
6. **Item 11, no "Are you sure?" after a preview: N50. Robot.** It runs Tidy labels with the switch on and answers Yes, then checks the label really moves straight away. It runs CDPERIMETER and Accepts, then checks the drain is placed. Each command must ask exactly one question and never "Are you sure".
7. **Item 12, trench drain by two points: N51. Robot.** CDTG with two typed points 4 m apart, width 300, class C. It checks the trench grate block, its tag note "300 WIDE TRENCH WITH CLASS C GRATE", the 4000 mm length, and that one U takes it all back.
8. **Item 13, every placing command carries on until Esc.**
   1. **N52: downpipe and overflow. Robot, needs the mouse.** It places two of each in one run. It needs an unlocked screen and nobody at the PC.
   2. **N52b: raingarden and floor waste. Robot, written to fail today.** The installed CE stops after one raingarden or one floor waste. Example on a job: you place a floor waste in each wet area and have to retype CDFW every time.
9. **Item 14, the drafter draws the downpipe's pipe: N53. Robot.** It places DP1, then draws a pipe starting on it. The command line must say the flow runs from DP1 to the open end, so the pipe has joined the downpipe and only its far end is left free.
10. **Item 15, AG drain as a simple CE run: N54. Robot.** CDAGI, 2 m long with levels 18.000 and 17.900. The preview must read 1:20, it lands on layer AGI DRAIN, and one U takes it back. It runs on the millimetre test drawing because the metre-drawing fault (BUG-1052) is not fixed yet.
11. **Nothing for you to test.** When AutoCAD is free, the robot runs the spec tonight or over the weekend.

---

## Per case: what it proves and why it is built this way

1. **N45 (items 5, 6).** Sources: CDWT and CDLPD command registrations and their windows at commit 5888ee75 (installed 3.0.86). Both windows close with Cancel or Close, which are on the robot's press list for "Creative Engineering*". Twin N45_BROKEN types the made-up name CDWTZ, so the "no Unknown command" check goes red while every real-name check stays green.
2. **N46 (item 7).** The old names come from `command-registry.json`. Each has its own command registration, not a LISP alias. PITEDIT takes the pit picked first, with no question. PIPEEDIT asks the same older-pipe question as CDEDIT, answered Y as R11 and R20 do. Twin N46_BROKEN types PIPEEDITX.
3. **N47 (item 8).** The timer service starts for every drawing. A drawing is timed only inside a job folder: within 8 folders up, one named like "25-12" or holding the STORM report folder. The case sets the idle limit to 1 minute, idles 100 s and checks no "JobTime: auto-paused" line is written. The twin is a deliberately wrong expectation (it expects that line), because no real action can make the robot's copy a job drawing today.
4. **N48 (item 9).** No "TYP" text exists anywhere in the Civil source. Each CD pipe builds its own label. Twin N48_BROKEN switches the label off (`options.createText false`): run k6V1 showed that key removes only the pipe label, so the three pipes are still drawn with no labels.
5. **N49 (item 10).** CD has no "no repeat" flag. A new pipe window always takes the size, material and type last drawn in this job, even with "Remember settings" off. Twin N49_BROKEN draws the first pipe at 225, so the repeated window is not on 150.
6. **N50 (item 11).** This is R16's proven clash, with the spot level moved onto P8's start invert text, answered Yes as in N27, then R37's CDPERIMETER chain. Twin N50_BROKEN answers No, so nothing moves and the moved-label checks go red.
7. **N51 (item 12).** The command is CDTG. CDTD, CDTRENCH and TD do not exist; TG is the old name. Prompts, defaults and the placed line come from the source. Twin N51_BROKEN types width 450, so the 300 mm checks go red.
8. **N52 (item 13, DP and OF).** The second item cannot be typed, because typed text is lost while CE waits. So the case uses R01's and SETUP-P8x2's real-click route and ends each run with the Esc key. Twin N52_BROKEN leaves out the second click, so the two-of-each counts go red.
9. **N52b (item 13, CDRG and CDFW).** Neither command calls the carry-on service. N04 and R36 on 3.0.86 both show the command ending after one item. It is tagged EXPECT-FAIL UX-STD-01, so a later pass is reported as a candidate. It has no twin: a twin of a case meant to fail proves nothing until the feature is built.
10. **N53 (item 14).** CE resolves a pipe end within 150 mm of a downpipe to that downpipe and prints "Flow: DP1 -> Open end". Twin N53_BROKEN starts the pipe 2 m away, built like R02_BROKEN.
11. **N54 (item 15).** It is CDPERIMETER's engine, so it uses R37's chain, which passes twice on 3.0.86. An AG drain gets no tag text. Twin N54_BROKEN draws it 4 m long, so the preview reads 1:40, not 1:20.

---

## Missing robot tools or permissions (each needs a Codex look; nothing was invented)

1. **N47, a log read from the AutoCAD start.** "JobTime: session created" is written when the drawing opens, before the case's log start (case_runner.ps1 line 134). Needed: a "from session start" option on `log civil` or `log-read civil`.
2. **N47, a job-folder fixture.** Needed: a runner permission to place the session copy inside a job-numbered folder (for example under `C:\ce_rc_scratch\99-001 ROBOT\`).
3. **N49, a bare Enter key.** If driver v2 drops a leading Enter in a typed chain, a `v3 enter-key` verb (like `v3 esc-key`) is needed.
4. **N47, the status-bar pane "CE TIMER - not in a job folder".** It sits on AutoCAD's own window, which the robot may not read. A Codex look.

---

## What I did NOT verify (RULES 5.9)

1. **Nothing was run in AutoCAD.** Every CE line marked DERIVED in a case header comes from reading the installed source at commit 5888ee75 (Civil 3.0.86), not from a run.
2. **Window titles and buttons for CDWT, CDLPD and PITEDIT** are read from the XAML only. The robot has not opened them.
3. **Whether CDTG finds its TRENCH GRATE block** in the test drawing is unknown. CDFW refuses when its block is missing, and CDTG may do the same.
4. **Whether the size carries over** on the robot's copy, which is not in a job folder, is not confirmed for N49.
5. **The second DP and OF tags (DP2, OF2)** and the click landing within 300 mm are assumed.
6. **Source facts came from three read-only search agents and spot checks.** I re-read the PITEDIT selection path, the two window XAML files, the job-timer early return and the allow-list myself. The rest I took from the agents' file and line references without opening every line.
7. **One AutoCAD was running at 12:20.** It was started from the Windows desktop (explorer), not by this job: the validate runs only in PowerShell and launches nothing.

---

## Summary (under 100 words)

11 robot cases (N45 to N54 plus N52b) and 10 twins drafted for top-40 items 5 to 15, all valid offline. 8 items are robot-ready. The job timer (N47) and Enter-repeat (N49) need a Codex look or a new robot tool for their full proof. Raingarden and floor waste do not carry on in 3.0.86, so N52b is meant to fail. Not built: CS command names. Spec: `C:\ce-fx\retest\spec_next40_a.txt`, 9 a-lines and 6 b-lines. Nothing was run in AutoCAD.
