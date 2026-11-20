# The everyday run (what every night must do and photograph in a test AutoCAD)

**Kept by:** the AutoCAD test room ("CE_ACAD / acad test / 01"). **Written:** Fri 20 Nov 2026, 11:30 am.
**Measure:** `stage6\STAGE1_TIMS_EYES.md`, line by line, and rulings D-340, D-348, D-352, D-354 to D-359.
**Why:** thousands of bench tests passed while real AutoCAD showed plain squares, no pipe and the wrong windows (D-351). A step counts only when a picture taken inside the test AutoCAD shows it.

## 0. Rules of the run (never bent)

1. **Rule 1.9 of `C:\TimOS\RULES.md`, in full:** "Hands off AutoCAD's profile and licence. No chat, helper or robot may, without Tim's yes in words in that conversation: make, copy, rename, delete or switch an AutoCAD profile; start AutoCAD under another profile; force-close AutoCAD or its headless engine (if it is stuck, leave it, stop, tell Tim); touch Autodesk licensing or sign-in in any way; or change a saved AutoCAD setting or the registry. If a licence or sign-in window appears: do nothing to it, stop, tell Tim. Every brief handed to a helper that may start AutoCAD must repeat this rule in full." **One exception (D-160):** a robot may close (normal close first, then force) a TEST AutoCAD that it started itself that night on a test copy, when it jams or crashes, and then carry on; never an AutoCAD of Tim's, never one it did not start; a licence or sign-in window still stops everything.
2. **When:** never 8:30 am to 5:30 pm on weekdays. Never while any AutoCAD is already running; look again every 15 minutes. `C:\CE_WORK\civil_tests\STOP_ACAD.flag` present means no run. `C:\Users\TimothyBrand\.timos\autocad.json` is read just before starting.
3. **What:** ONE test AutoCAD, started by the safe runner (`C:\CE_CIVIL\acad\night_scripts\`), exactly one confirmed after launch, on a test copy only. 60 seconds with no answer stops the pass. PC in use (last input under 10 seconds) or any unexpected window stops the pass. Closed without saving.
4. **Typed names:** PT and PIPE only. Never PIT, PP or CD (the old plug-in also claims them). No function keys, no keyboard shortcuts; undo is the typed word U.
5. **Nothing installed.** The new plug-in is loaded by NETLOAD into the test AutoCAD for that run only. No setting, profile or registry change. SECURELOAD left as it is.
6. **The test drawing** is made fresh each night from `C:\CE_WORK\civil_tests\templates\office_master_copy.dwg` (office blocks and layers). Never a real job. No client names, addresses or job numbers in any drawing, picture or file name.
7. **Marking:** PASS only when the picture shows every "must be seen" point. FAIL says in words what the picture shows instead. NOT RUN gives the reason. A step is never marked from a log line alone.

8. **A "sent" line proves nothing** (check room, 20 Nov: the sender reports a command as sent even when AutoCAD did not know the word). Every step is marked from its picture and the plug-in's own result file, never from the pass line.
9. **The build under test is proven, not assumed** (check room, 20 Nov: the staging folder NETLOAD reads holds two differing plug-in files, neither shown to be the main line's). Each night the page gives the commit built, and the file fingerprint (SHA256) of the plug-in file that was loaded beside that of the file just built. If they differ, or the staging folder was not filled by that night's own build, every step is NOT RUN.

## 1. The steps

Pictures go to `C:\CE_WORK\civil_tests\pictures\<date>\` under the names given. "Window" pictures are of the window as it opens; "drawing" pictures are of the drawing area after the step.

1. **Start from the test copy.**
   - **Do:** the runner opens the night's test copy.
   - **Must be seen:** one AutoCAD, its title showing the test copy; the office layers present; no licence, sign-in or other box.
   - **Picture:** `01_start.png`.
   - **PASS:** the test copy is open and nothing else is showing. **FAIL:** any other drawing, a second AutoCAD, or a box.

2. **Load the new plug-in.**
   - **Do:** NETLOAD of the night's build.
   - **Must be seen:** the command line shows it loaded, with no error text, and the plug-in's own line naming its build, which matches the commit under test (rule 9).
   - **Picture:** `02_loaded.png`.
   - **PASS:** loaded, no error. **FAIL:** any error line or a security box.

3. **PT, first pit: click, then the window** (D-354, lines 1, 2, 3, 7a, 7b).
   - **Do:** type PT, click an empty spot.
   - **Must be seen:** the Pit window opens AFTER the click, for that pit. Approved style: rose OK, three numbered steps, not the old four cards, not a blue OK. Size fitted to its content, about 1100 by 700 at most, not four fifths of the screen. The preview shows the real pit with its tag and cover text, never "Bench preview". The real pit shows on the drawing where clicked while the window is open.
   - **Pictures:** `03_pit1_window.png`, `03b_pit1_live_on_drawing.png`.
   - **PASS:** all of the above. **FAIL:** names which point is missing (for example "blue OK, four groups, empty preview").

4. **OK: the first pit goes in** (line 4, D-352).
   - **Do:** type a cover level in the window (D-358), OK.
   - **Must be seen:** the OFFICE pit block, never a plain square; its tag reading P1; its cover text with the level typed; right layers. The number sits flat, straight above, below or beside the pit; the cover level sits at 45 degrees off a corner of the pit (D-363). PT then asks for the next click.
   - **Picture:** `04_pit1_drawn.png`.
   - **PASS:** office block, tag and cover text. **FAIL:** a square outline, a missing tag or text, or "level not known" after a level was typed.

5. **Second pit.**
   - **Do:** click a second spot about 10 m along; OK.
   - **Must be seen:** the window opens holding the last pit's choices; the pit goes in as P2.
   - **Pictures:** `05_pit2_window.png`, `06_pit2_drawn.png`.
   - **PASS:** last choices shown, P2 drawn as the office block. **FAIL:** blank window or wrong number.

6. **Third pit, Cancel first** (D-357).
   - **Do:** click a third spot, press Cancel in the window; then click again and OK.
   - **Must be seen:** after Cancel the live pit is gone and nothing is left on the drawing; after OK the pit goes in as P3.
   - **Pictures:** `07_pit3_cancelled.png`, `08_pit3_drawn.png`.
   - **PASS:** Cancel leaves nothing; three pits P1, P2, P3. **FAIL:** anything left behind after Cancel, or a skipped number.

7. **PIPE from anywhere to anywhere, through the pits** (D-355, lines 5, 6, 7, 7a).
   - **Do:** type PIPE; click from open ground short of P1, through P1, P2 and P3, with one bend between two pits; finish the run.
   - **Must be seen:** the Pipe window opens AFTER the run, knowing the run. It opens with a size (what it joins, else 100 dia.), never "Not known". The preview runs across the top and shows the pipe between its pits with its label. The pipes show live on the drawing.
   - **Pictures:** `09_pipe_run_clicked.png`, `10_pipe_window.png`.
   - **PASS:** all of the above. **FAIL:** "Not known" size, "unknown DIA" in the label, an empty preview, or the window before the clicks.

8. **OK: the pipes go in.**
   - **Do:** set a grade and a level, OK.
   - **Must be seen:** what was clicked is drawn. One pipe per pit-to-pit length; the bend kept inside its pipe. Each pipe has its label as ruled; invert levels are written at each pipe end where known; labels land clear of the pipe and the pits. The pipe label sits above the pipe, centred, 75 mm clear, and slides along the pipe if something is in the way (D-361). The invert levels sit on the other side of the pipe from the label, 200 mm from the pit (D-362).
   - **Picture:** `11_pipes_drawn.png`.
   - **PASS:** every length drawn and labelled with inverts. **FAIL:** nothing drawn, one long pipe through the pits, missing inverts, or a label on top of a pit.

9. **A picked polyline replaced by pipes** (D-356).
   - **Do:** draw a plain polyline with one corner clear of the pits; type PIPE and pick it; OK in the window.
   - **Must be seen:** before: the polyline. After: the polyline is gone and a pipe takes its exact path with the corner as a bend, with its label.
   - **Pictures:** `12_polyline_before.png`, `13_polyline_window.png`, `14_polyline_replaced.png`.
   - **PASS:** polyline gone, pipe on the same path. **FAIL:** polyline still there under the pipe, a straightened path, or nothing drawn.

10. **Undo the polyline pipe.**
    - **Do:** type U once.
    - **Must be seen:** the pipe and label are gone and the polyline is back, in one undo.
    - **Picture:** `15_polyline_undone.png`.
    - **PASS:** exactly as picture 12. **FAIL:** needs more than one U, or leaves a label behind.

11. **Change a pit size.**
    - **Do:** open P2 for editing, change 450 to 900, OK.
    - **Must be seen:** the same Pit window, showing P2's own figures. After OK the pit is larger; the pipe ends stop at the new wall; the pipe labels step out; tag and cover text stay with the pit.
    - **Pictures:** `16_pit_size_window.png`, `17_pit_size_changed.png`.
    - **PASS:** all followed. **FAIL:** pipe runs through the wall, or a label left where it was.

12. **Undo the size change.**
    - **Do:** type U once.
    - **Must be seen:** exactly as picture 11.
    - **Picture:** `18_pit_size_undone.png`.
    - **PASS / FAIL:** as step 10.

13. **Move a pit** (D-348, line 8).
    - **Do:** AutoCAD's own MOVE on P2: 1,200 across, 500 up.
    - **Must be seen:** the tag and cover text go with the pit; both pipe ends follow to the pit wall; pipe labels re-seat; lengths and grades in the labels are the new ones.
    - **Picture:** `19_pit_moved.png`.
    - **PASS:** everything followed. **FAIL:** a tag, text or pipe end left behind.

14. **Undo the move.**
    - **Do:** type U once.
    - **Must be seen:** pit, tag, text, pipes and labels all back, in one undo.
    - **Picture:** `20_pit_move_undone.png`.
    - **PASS / FAIL:** as step 10.

15. **Copy a pit** (D-340).
    - **Do:** AutoCAD's own COPY on P2 with its tag and cover text, to clear ground.
    - **Must be seen:** the copy is its own pit with the next free number (P4), its own tag reading P4. P2 is untouched. Then MOVE P2 by 500: the copy does not move.
    - **Pictures:** `21_pit_copied.png`, `21b_original_moved_copy_stays.png`.
    - **PASS:** P4 stands alone. **FAIL:** a second P2, or the copy follows the original.

16. **Undo the copy.**
    - **Do:** type U for each command back to before the copy.
    - **Must be seen:** the copy gone, P2 where it was.
    - **Picture:** `22_pit_copy_undone.png`.
    - **PASS / FAIL:** one U per command, nothing left behind.

17. **Erase a pipe.**
    - **Do:** AutoCAD's own ERASE on the pipe P2 to P3.
    - **Must be seen:** the pipe, its label and its invert texts are gone; both pits, their tags and the other pipe stay.
    - **Picture:** `23_pipe_erased.png`.
    - **PASS:** only that pipe's parts went. **FAIL:** an orphan label or invert text, or a pit changed.

18. **Undo the erase.**
    - **Do:** type U once.
    - **Must be seen:** pipe, label and inverts back, still joined (a move of P3 by 500 takes the pipe end with it; then U).
    - **Pictures:** `24_pipe_erase_undone.png`, `24b_still_joined.png`.
    - **PASS / FAIL:** as step 10, and still joined.

19. **The typed EXPLODE of a pipe** (line 12; no ruling yet).
    - **Do:** type EXPLODE, pick one pipe.
    - **Must be seen:** whatever happens, recorded plainly: what the pipe became, what happened to its label and inverts, what the command line said. Then U once and a picture.
    - **Pictures:** `25_explode_before.png`, `26_explode_after.png`, `27_explode_undone.png`.
    - **Marked:** SEEN (with what was seen, for Tim's ruling) or NOT RUN. Only step 27 is PASS or FAIL: one U puts the pipe back whole.

20. **Owed in AutoCAD, from merged work.**
    - **Do:** each item in `OWED.md` whose work is on the main line that day, in its listed order.
    - **Pictures:** `30_<plain name>.png` onward, one before and one after each.
    - **PASS / FAIL:** against the words in `OWED.md`.

21. **Close.**
    - **Do:** the runner closes its own test AutoCAD without saving.
    - **Must be seen:** in the runner's log: closed normally, no force; no AutoCAD left running; the test copy on disk unchanged.
    - **Picture:** none. Recorded from the log and a process count, said as such.

## 2. What the night page reports

`NIGHT_<date>.md` lists steps 1 to 21, each with its picture name, what the picture shows against the measure, and PASS, FAIL, SEEN or NOT RUN, then "PASS n / FAIL n / NOT RUN n", the build run (commit), the start and end times by the clock, and what was not tested.

## 3. Honest state on 20 Nov 2026, 11:30 am (read from the night scripts, nothing run)

1. **The runner can only type command lines.** It sends text to AutoCAD and waits for it to go idle. It has no way yet to click a point, press OK or Cancel in a window, or take a picture. Steps 3 to 19 need all three.
2. **A CE window would stop the pass.** The safety file treats any window of our AutoCAD it does not know as a stop for Tim. The Pit and Pipe windows are not on its known list, so step 3 would halt and write a note for Tim.
3. **The test copy is not from the office master.** `open_me.dwg` is a 31 KB bare drawing; the last wrapper copied a trial seed over it. The office master copy is 1.85 MB.
4. **The wrappers are outside the safe set.** `C:\CE_WORK\civil_tests\night_1119*.ps1` were not in the safety review; one reaches for "the active AutoCAD" directly and opens a drawing in it.
5. **No clock or stop-flag check in the launcher.** `ce_launch.ps1` refuses when an AutoCAD is running, but does not read the time, the stop flag or Tim's switch.

These five are asked of the build room; any change to a night script needs a check-room verdict before it runs.
