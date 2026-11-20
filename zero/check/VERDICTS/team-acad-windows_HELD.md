# HELD: team/acad-windows at b645b43 (Stage 1 items A1 to A3, the Pit and Pipe windows): the one-page open list

**Verdict: HOLD, and held.** Written Fri 20 Nov 2026, about 1:39 pm, by the check room. This was the branch's last fix round under D-346. Checked on the bench only. The first verdict is `team-acad-windows.md`.

**Who checked this round.** Honest re-check: Team helper, Claude Opus 5.5, with its own pictures of 15 states at 5 screen sizes: `C:\CE_WORK\check\reports\acad-windows2_honest_REPORT.md`, `acad-windows2_pics\`. Adversarial re-pass: Codex gpt-6.2-astra, 493 cases (335 passed, 158 failed): `C:\CE_WORK\check\reports\acad-windows2_adv_REPORT.md`, `acad-windows2_adv_tests\`. The two agree on every point below.

**Suite seen.** Brain 750, hands 687, reader 19 passed and 2 skipped (main's own), bench 468 of 468 after one on-screen list test, not touched by this branch, failed once and passed 9 of 9 twice when run alone. Style check 1,136 facts, 0 faults. Main 22993fa is merged in. Tim's real window-size file was never created or touched.

## What closed in this round (stays on the branch)

1. **The windows open.** All five Pit and Pipe tool windows were built the way the commands build them and placed, 70 times by one helper and on this PC's screen sizes by the other: none failed. With the old file put back, 18 of 18 new tests fail with the old error: the tests bite. The resize is saved and tested.
2. **Most pictures now show only what is on the drawing.** A pipe end that is not joined shows no pit; the pipe strip no longer draws a pipe leaving the last pit; a free far end is "from an open end", not a made-up "P4"; "unknown DIA." is gone.
3. **Inspect is back** in the footer of all five windows and does what D-065 says: the window hides, the choices are kept, Back returns it.
4. **The Pit window's clipped row of sizes is fixed;** a new window is never larger than four fifths of the work area; a resize is remembered per window.

## The open list

1. **Blocker 2 stands in these places** (the control room ruled it is fixed everywhere, not in one place):
   - **The Pit window's small label picture in step 3** still draws a dashed pipe stub each side of every pit, including a new pit with no pipes (`src/CeCivil.Window/Parts/Std/StdPictures.cs:155-159`). No test looks at that picture. Both helpers found it.
   - **The Pipe window's answer text names pits that do not exist:** on a pipe from one named pit to another the answer under the strip reads "IL 9.37 at P3" (and "P4" working uphill), even with both ends free (`bench/CeCivil.Bench.Core/windows/pipe.csv:62`).
   - **A pit with a 100 pipe in and a 300 out shows "100 DIA." on both sides** in the left drawing, and with only a 300 outlet reads "TBC DIA." (`src/CeCivil.Window/Parts/Std/StdPreviewDraw.cs:115`). Step 2 beside it reads 300. A wrong size in a picture, not on the plan.
   - **A pit given a size for the first time shows a dashed 450 "old size" it never had** (`StdPreviewDraw.cs:89`).
2. **The fault ruled into this round, "nothing cut off at 1920 by 1080 usable and above", is not met, and this round made it worse.** The new four-fifths cap makes the Pipe window 832 high on a 1920 by 1040 work area where its content needs 838 to 894: with both ends joined the last line of step 3 is sliced through; with a size typed, the line "Pit schedule: rows ... show 150 dia." is lost; there is no scroll (`bench/CeCivil.Bench.Core/WindowPlacement.cs:46`). With the label set "Below the pipe" the label in the top strip is cut off altogether. A long pit name is clipped in the Pit window. Before this round the Pipe window opened at 894 high with nothing lost. The builder's "nothing cut off" test cannot see a part squeezed by the layout (`bench/CeCivil.Bench.Tests/AcadWindowHostTests.cs:202-239`).
3. **The size rule the branch was built to has been replaced.** D-386 (Tim, from a picture): the Stage 1 Pit window has two set sizes, 1000 by 620 and 1240 by 780, picked from the size of the AutoCAD window, with the plan panel about 40 per cent of the width, live (D-382), and it opens where it was left (D-385). This branch opens the Pit window at 1517 by 792 on a 1920 by 1080 screen with a small sketch at the left. So even with items 1 and 2 fixed, these windows are not the windows Tim approved.

## For the control room to rule

1. **What happens to this branch.** D-346: two rounds, then held. D-347: a design page before more patching. A way forward that fits both: build the Pit window to the picture Tim approved in D-386 as one build, carrying over what closed here (the window opening, Inspect, pictures that show only what is drawn), with the open list above as its tests; the Pipe window follows the same pattern once its mock-up is passed.
2. **A typed mistake in a box.** Type letters over the size or grade: the box is flagged while the cursor is in it, then on leaving it the old figure comes back, the flag clears, and OK draws the pipe at the old figure ("150 DIA. ... AT 1 IN 62.5"). The adversarial pass graded this a blocker; the check room did not, because the box visibly shows the figure that is drawn, and it is how the window behaved before this branch. But the standing brief says a bad input reads Wrong and what depends on it reads "Cannot check yet". Which is wanted: keep the last good figure and say so, or keep the box Wrong until he fixes it?
3. **The builder's three open calls:** "TBC DIA." in the top strip while the small picture reads "PIPE AT 1 IN 100" (two wordings for one pipe in one window); a remembered resize is not capped (D-386 now allows a larger remembered size); "from an open end" where the office list says "free end" and the Pipe window says "not joined yet" (three wordings for one thing).

## Follow-ups

`FOLLOW_UP\part2-pit-and-pipe.md` items 16 to 30: 23 is closed (Inspect); 27 partly (better tests; the style check still passes a wrong label); the rest stand, proven again: a turned pit drawn unturned; bends not shown; "Work downhill" and three padlocks that do nothing; the window opens on the main monitor when AutoCAD is on another; two windows saving a size at once lose one; an untouched pipe says its choices changed; the same window object placed twice fails (the commands make a new one each time, so no ordinary route reaches it).

## Owed in AutoCAD, when a build of these windows is merged

The 10 steps of the first verdict, section 7, with these changes: sizes are checked against D-386; add Inspect (type a figure, press Inspect, pan and zoom the drawing, Back: the figure is still there; then Cancel draws nothing); add a pit with no pipes (no stubs in any picture) and a pipe with "Below the pipe" (the label shows in the strip); the light theme, the second monitor and the rose against a real drawing remain things only AutoCAD can show.
