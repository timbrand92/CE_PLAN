# Verdict: team/acad-windows at 53442d4 (Stage 1 items A1 to A3, the Pit and Pipe windows in AutoCAD)

**Verdict: HOLD. Two blockers, and one fault the control room has ruled must be fixed in the same round.** Written Fri 20 Nov 2026, 11:50 am, by the check room. Checked on the bench only; nothing here says anything works in AutoCAD. The build room held this branch once already and it has had one fix round, so **this is its last fix round** (D-346).

**The claim.** A1: the AutoCAD Pit and Pipe tools show the approved-style window, the old layout gone. A2: sized to content, centred on AutoCAD, a resize remembered. A3: the preview shows the real thing; no "Bench preview" caption.

**Who checked.** Honest check: Team helper, Claude Opus 5.5, `C:\CE_WORK\check\reports\acad-windows_honest_REPORT.md`, pictures in `acad-windows_pics\`. Adversarial pass: Codex gpt-6.2-astra, `C:\CE_WORK\check\reports\acad-windows_adv_REPORT.md`, proofs and three pictures in `acad-windows_adv_tests\`. The check room read both, read the two lines of blocker 1, and looked at two of the pictures itself (`pit_tool_opens_on_timscreen.png`, `pipe_tool_down_not_joined.png`).

## 1. Suite counts seen

1. **At the tip (53442d4):** brain 750, bench 438, hands 667, saved-drawing reader 9; 0 failed, 0 skipped. Log `C:\CE_WORK\check\reports\acad-windows_honest_test1.log`.
2. **Merged with main (22993fa), not committed:** clean, no conflict. Brain 750, bench 438, hands 687, reader 19 passed and 2 skipped (main's own, waiting on the office blocks file); 0 failed. Log `acad-windows_honest_test2.log`.
3. **Style check:** 1,136 facts, 0 faults. With the earlier fix undone, 3 facts fail: that check bites.
4. **Why green is not enough here:** the code that puts the window on screen runs only inside AutoCAD. No test, picture or style check calls it.

## 2. Blockers

1. **Neither window can open.** Found by both helpers separately.
   - **Kind:** a ruling built the opposite way (D-295 and Stage 1 line 1: the approved window is what shows in AutoCAD; as built none shows, which is worse than main).
   - **Where:** `src/CeCivil.Window/WindowHost.cs:101` puts the window's frame into a new grid while the frame is still the window's content (set at line 41). Windows refuses: "Specified element is already the logical child of another element." Only caller: `src/CeCivil.Acad/PitCommand.cs:113`, which every Pit and Pipe window goes through.
   - **What the drafter would see:** type PT, click a point; the command line says the command stopped with that error; no window; nothing can be drawn. The same for PP and CD.
   - **Proof:** thrown on the bench with the branch's own built files, for the Pit and the Pipe window, by each helper (`acad-windows_adv_tests\Review.cs` line 79).
   - **The fix must bring, failing first:** a bench test that builds the window, places it with a temporary size file, and checks its content and size; and a test of the resize being saved.
2. **The pictures still draw things that are not on the drawing as if they were real.** The cause of the build room's own blocker, closed for the top strip's downstream end only.
   - **Kind:** a ruling built the opposite way (screen rule 25 and Stage 1 A3: the preview shows the real thing; made-up scenery is labelled as made up).
   - **Step 3's small pipe picture, "How the pipe will read on the drawing"** (`src/CeCivil.Window/Parts/Std/StdPictures.cs:205-228`): a pit box at BOTH ends even when one or both ends are not joined, under the words "unknown DIA. PIPE AT 1 IN 100". Seen by the check room in `pipe_tool_down_not_joined.png`: the strip at the top says "not joined yet" while the picture below it shows a pit there.
   - **The top strip** (`src/CeCivil.Window/Parts/Std/StdPreviewDraw.cs:186`): a pipe is drawn leaving the downstream pit whether or not one leaves it.
   - **The Pit window** (`bench/CeCivil.Bench.Core/windows/pit.csv:34`, `ToolWindow.cs:68`): with the far end of the inlet pipe free, step 2 names a pit "P4" that does not exist; the small "In / Out" picture shows a pipe in and a pipe out when the pit has none (`StdPictures.cs:130`).
   - **On a job:** the drawing may well hold a real P4. The drafter reads "this pit takes the pipe from P4" when the pipe comes from nothing.
   - **Proof:** `acad-windows_adv_tests\Review.cs` lines 94, 161, 273, 316; `open-pipe.png`.
   - **The fix must show:** in every picture on both windows, an end that is not joined shows no pit, no name, no level and no onward pipe; a pit with no pipe shows none; no name appears that is not on the drawing; never "unknown DIA." (Stage 1 line 7).

## 3. To fix in the same round (control room's ruling, about 12:05 pm by its clock)

1. **Nothing is cut off or needs scrolling at 1920 by 1080 and above.** Today the Pit window's row of pit sizes in step 3 is cut at the right at 1100 wide on a 5120 by 1440 screen (the 900 shows as "90"; seen by the check room in `pit_tool_opens_on_timscreen.png`). Content wraps or the layout changes.
2. **The size rule until Tim rules:** sized to content; never larger than four fifths of the work area of the monitor it opens on; a resize remembered per window. "About 1100 by 700" is withdrawn. The exact size is not a blocker. Measured today: Pit 1517 by 792 and Pipe 1536 by 894 at 1920 by 1080; Pit 1100 by 988 on a 5120 by 1440 screen.
3. **To Tim through Tim's room (not for this round):** the 1366 laptop, where step 3 is cut off with no scroll; whether the left preview panel is still wanted now the part shows live on the drawing (D-357). The adversarial pass also found content lost at 2560 by 1440 with text at 200 per cent: the control room to say whether that falls inside "1920 by 1080 and above".

## 4. A1, A2, A3 on the bench

1. **A1: met on the bench as built data; cannot open until blocker 1 is fixed.** All five Pit and Pipe tool names give three numbered steps and a rose OK; the old layout cannot be reached from them (by file name, not by a switch: `bench/CeCivil.Bench.Core/WindowSpec.cs:156-162`); no "Bench preview" words in either tool window.
2. **A2: not met as first written; now governed by section 3.** Centring, staying on screen, a remembered size larger than the screen, and a damaged size file all behave in the sums. The resize itself is unproven (it sits inside the code that fails). No test writes to Tim's real size file; the file did not exist before or after the runs.
3. **A3: the build room's blocker is fixed for the top strip; blocker 2 remains.** A pit of unknown size is drawn dashed and says "Size not known".

## 5. Not blockers

Kept in `FOLLOW_UP\part2-pit-and-pipe.md` (items 16 onward). The larger ones: a refused figure (a grade or size typed as letters) leaves the old confident label in the top strip; the Pit picture shows a 100 pipe both sides when a 300 leaves; a turned rectangular pit is drawn unturned; bends do not show in the strip; "Work downhill" does nothing when neither invert is known; the Inspect button is gone from the footer (D-065: the control room to say whether it is wanted); with AutoCAD on a second monitor the window opens on the first; two windows saving a size at once lose one; the style check would pass a wrong label ("999 DIA. WRONG"); the Pipe picture beside the inputs (D-313) sits in step 3, not step 1.

**On main already, not caused by this branch, passed to the control room:** a charged pipe is labelled with a grade, a suspended pipe loses "SUSPENDED" and "MIN.", a detention pipe loses its length and "DETENTION" (`bench/CeCivil.Bench.Core/GradeLabel.cs:30`; D-268, D-312; a wrong wording that reaches the plan); with cover not known the Pit tool leaves the cover text off the drawing where D-178 asks for "TBC" (`src/CeCivil.Hands/Pit/PitTool.cs:246`); a depth the drafter typed and held is lost on OK and reopen (`src/CeCivil.Brain/data/tools.csv:36`, `ToolWindow.cs:137`).

## 6. The 31 screen rules, from the check room's pictures and the helper's

Rule by rule in the honest report, section 5. Meets: 4, 5 (dark, on the bench), 7 to 15, 20, 21, 26, 27, 29. Fails: 6 (cut off at 1100 wide and on a laptop), 23 (the window cannot open; a button that does nothing), 24 in one place ("unknown DIA."), 25 (blocker 2). Cannot be judged on the bench: 16 (the rose against a real drawing's colours), 18 (budgets, one undo), 28 (motion), AutoCAD's light theme. Not applicable: 1 to 3, 17, 19, 22, 30.

## 7. Owed in AutoCAD (for the AutoCAD test room, after the fix; test copy from the office template, outside Tim's hours)

1. **The window opens and is the approved style:** type PT, click a point. Right: a window titled "Pit · P1" with the drawing at the left, the answer band, steps 1 to 3, Cancel and a rose OK. Wrong: an error line, the old four-card layout, "Bench preview". The same for PP and CD.
2. **Size:** with AutoCAD maximised, record each window's width and height; nothing cut off, no scroll.
3. **Centred on AutoCAD:** make AutoCAD a smaller window on the left half of the screen; PT again. Right: centred on AutoCAD's window. Repeat with AutoCAD on a second monitor and record which monitor the window lands on.
4. **Resize remembered:** drag the corner about 200 px wider, Cancel, PT again. Right: opens at the new size; Pipe keeps its own size. Use the test room's own Windows user or a test settings file only.
5. **Damaged size file** (test user only): put broken text in the size file, PT. Right: opens at content size, no error.
6. **Pipe, an end not joined:** CD from a pit to open ground. Right: every picture in the window shows the pit, the pipe and an open end marked "not joined yet"; no second pit anywhere.
7. **Pipe, both ends joined:** right: both pits named as on the drawing, with their cover levels; no pipe drawn leaving the downstream pit unless one does.
8. **Pit of unknown size:** select an older pit with no size held, PT. Right: a dashed outline and "Size not known".
9. **Cancel, the X and Escape** each leave the drawing unchanged.
10. **Over a real test drawing:** a picture of each window, so the rose can be judged against the drawing's colours (screen rule 16), in AutoCAD's dark and light themes.
