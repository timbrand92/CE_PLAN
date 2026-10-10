# Claude driver run 16 (FIX_3046): the decisive A/B for BUG-558, Saturday 10 Oct 2026 (PC clock 20:58 to 21:08)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 16, Sonnet, headless. Before the first call: `Get-Process acad` showed nothing, no Codex verifyW run was active (the Codex runner's last entry was `END bj25_cesettings_rows_civil` at 18:42), and the driver lock was free. Driver copy `acad_driver_witness.ps1` only, through a counting wrapper. Test copies only. Nothing was saved. I did not go round the driver at any point.

## Installed versions (readdll.ps1, 10 Oct 20:58)

1. **Civil CE_CVL_SUITE 3.0.46+2388c329:** Legacy 63804716F6C2, Net8 55602FDA2981, Modern 214E8E193EEE.
2. **Manager CE_SUITE_MANAGER 1.1.46+2388c329:** Legacy F30FA61E4595, Net8 2791C1DD69BE, Modern 562C5DBD5BC2.
3. **Structural CE_STRUC_SUITE 1.0.114+0f00f5fb:** Legacy 1483F48B2337, Net8 E0C1E50F360B, Modern 25262A382560.
4. Recorder: `witness check` ok_to_load, SHA256 49E79D6D... (equals the pin in the driver copy and the DLL in `witness_bin`). `witness load` took 1.4 s, SECURELOAD 0, no prompt.

## Answer first

1. **A (CD pipe placed through the New Pipe window, then Structural circle, U, 15 s, switch to the Civil copy and back, REDO): REDO LOST. Echo: "Nothing to redo".**
2. **C (A repeated once, circle radius 20): REDO LOST again. Echo: "Nothing to redo".** So A is 2 of 2 lost on this build (Civil 3.0.46, which should hold the BUG-558 cluster).
3. **B (control: the same steps, but the switch goes to a fresh Civil copy with nothing done): REDO KEPT. Echo: "CIRCLE"** (this build prints the name of the redone command, not "Everything has been redone").
4. **The expected result ("REDO kept after the CD pipe") did NOT happen.** BUG-558 is not fixed by this build for the CD-pipe route. Per the brief, the finalizer lead (the CD and PIT editor windows borrowing the live graphics manager) is still open.
5. **PIT-only case: the brief's method is BLOCKED by the driver.** The New Pit window's only way to place a pit is "Continue placement" (`C2.PlaceCommand`), which the driver never presses. I could not place a pit through it. What I did instead (D): PIT with a typed point opened the New Pit window, I pressed Cancel (the command ended "PIT command cancelled.", nothing placed), then the walk. **REDO KEPT (echo "CIRCLE").**
6. **Extra narrowing (E), not in the brief:** CD with the New Pipe window opened and Cancel pressed (the command ended "CD command cancelled.", no pipe placed), then the walk. **REDO KEPT (echo "CIRCLE").**
7. **So far the loss needs a pipe actually placed.** Opening CD and its window and cancelling does not cause it (E), opening the PIT window and cancelling does not (D), and an untouched copy does not (B). What a placed pipe adds, in AutoCAD terms: the pipe and its text and flow arrow are written to the drawing, and the Design Warnings window opens and is closed.
8. **The witness shows the same signature as run 10, in both lost walks and in no kept walk:** three `SysVarChanged VIEWBACKSTATUS` events on the Structural drawing between the U and the REDO (section 3). The three events appear on both drawings when the pipe drawing is switched to or from, 28 to 62 ms apart. None appear in B, D or E.
9. **System variables unchanged:** OSMODE 5375 and SAVETIME 5 read on both drawings before and after; CLAYER BLOCKS (Civil) and 0 (Structural) before and after. No `setvar` used. LOGFILEMODE restored to 1 by `quit`.
10. **Driver calls: 64 counted** (cap 75), no driver refusals. Every call, including the wrapper's own, is counted.
11. **AutoCAD closed cleanly** with the driver `quit` (not killed), 5 drawings closed without saving, lock released, `Get-Process acad` shows nothing.

## 1. Copies

1. `CLD25_B1` (from DRV1_B1, hash 34BBE37C2EA4): the Civil copy with the pipe (case A and C).
2. `CLD25_S1` (from DRV2_S1, hash 950AFDF6E523): the Structural copy for every circle.
3. `CLD25_B2`, `CLD25_B3` and `CLD25_B4` (each from DRV1_B1, 34BBE37C2EA4): the untouched control (B), the PIT-window copy (D) and the CD-cancelled copy (E). I made B3 and B4 as extra fresh copies so each case had its own Civil drawing.
4. Order: launch B1, `witness load`, then open S1, so the recorder attached to both. B2, B3 and B4 were opened later in the same session, after the recorder was loaded, and each has a log.

## 2. The steps, as typed

1. **CD pipe on B1:** `type "CD`n54436.3,-69493.6`n64028,-69576.4`n" -Enter -Force -ExpectWindow "New Pipe"`. CD printed "Pipe end moved to the inside wall of P10 (was 225 mm inside the pit)." and the New Pipe window appeared in 6.7 s. (The brief's "each point its own type call" is impossible: while CD waits at a question AutoCAD refuses typed text. I used the proven one-call form, as the tester guide section 4.1 says. Not a deviation from the driver; a deviation from the brief's wording.)
2. `ui type "New Pipe" "C2.FirstInvert" "18.500"`, `ui type ... "C2.SecondInvert" "18.500"` (value_after 18.500 both), `ui click "New Pipe" "C2.OkCommand"` (Start Pipe, InvokePattern).
3. `ui click "Design Warnings" "OK"` (the window title in this build is "Creative Engineering | Design Warnings", the click found 2 matches and invoked it).
4. `esc`: `esc_sent 1`, `ce_prompt_waiting true`, `command_ended true`, `cmdactive_after 0`. AutoCAD printed "[CE] Pipe placed. Pick the next pipe's first point, or press Esc to stop." then "Specify first point or [Existing line] [Existing]: *Cancel*" then "[CE] Stopped. Everything placed stays; U takes back the last one." The pipe warning line was "[CE] Warning: Pipe is essentially flat  no measurable fall" (both inverts 18.500, as the brief says).
5. **Each walk on the Structural copy:** `open S1 -Writable`, `type "_.CIRCLE 0,0 <r>" -Enter` (radius 10, 15, 20, 25, 30 for A, B, C, D, E), `type "U" -Enter` (echo "CIRCLE" each time), sleep 15 s, `open <Civil copy> -Writable`, `open S1 -Writable`, `type "REDO" -Enter`.

## 3. The witness, per walk (read from the logs after `quit`, with my own small reader script that lists the events between `CommandEnded U` and `CommandWillStart REDO`)

1. **A, Structural log:** U seq 249 at 21:01:16.970, REDO seq 256 at 21:01:37.809. Between: HookCounts 1, LockModeChanged 2, SysVarChanged 3. **VIEWBACKSTATUS = 3 at 21:01:35.898, .925, .954.** The Civil log (B1) shows the same three at 21:01:34.228, .256, .288. **REDO said "Nothing to redo".**
2. **B, Structural log:** U seq 301 at 21:01:59.208, REDO seq 305 at 21:02:19.338. Between: HookCounts 1, LockModeChanged 2. **VIEWBACKSTATUS = 0.** The control Civil log (B2) has no VIEWBACKSTATUS event at all. **REDO kept ("CIRCLE").**
3. **C, Structural log:** U seq 371 at 21:02:29.866, REDO seq 378 at 21:02:50.425. Between: HookCounts 1, LockModeChanged 2, SysVarChanged 3. **VIEWBACKSTATUS = 3 at 21:02:48.563, .600, .662.** Civil log (B1): 21:02:46.915, .953, .982. **REDO said "Nothing to redo".**
4. **D, Structural log:** U seq 428 at 21:03:39.793, REDO seq 432 at 21:03:59.540. Between: HookCounts 1, LockModeChanged 2. **VIEWBACKSTATUS = 0.** B3's log has none. **REDO kept ("CIRCLE").**
5. **E, Structural log:** U seq 510 at 21:04:37.330, REDO seq 514 at 21:04:57.285. Between: HookCounts 1, LockModeChanged 2. **VIEWBACKSTATUS = 0.** B4's log has none. **REDO kept ("CIRCLE").**
6. Nothing else sat between any U and its REDO: no command, no object event, no autosave, no LISP.
7. **The first and last switches also show the burst** (not part of a walk): B1 had one VIEWBACKSTATUS at 21:00:51.682 (at the Start Pipe click) and three at 21:05:07 (the final switch to B1, for the "after" reads); S1 had three at 21:01:13 (the first open of S1 from B1) and one at 21:05:11. B2, B3 and B4 never raised one.
8. Logs kept: `release-v3-colleagues-CLAUDE_DRIVER_RUN16_witness_B1.jsonl` and `release-v3-colleagues-CLAUDE_DRIVER_RUN16_witness_S1.jsonl` in this folder. The B2, B3 and B4 logs stay in `C:\ce_rc_scratch\witness` (`CLD25_B2_*`, `CLD25_B3_*`, `CLD25_B4_*`).

## 4. What this says, and what it does not

1. **What it says:** a pipe placed with CD and the New Pipe window leaves the Civil drawing in a state where a switch to or from it makes AutoCAD change VIEWBACKSTATUS three times, and the Structural drawing's redo history is lost. Neither opening-and-cancelling the CD window (E) nor opening-and-cancelling the PIT window (D) does it.
2. **What it does not say:** whether the cause is the pipe objects, the Design Warnings window, the Start Pipe path, or something the pipe placement leaves in the view (the single VIEWBACKSTATUS at the Start Pipe click is the first sign). I did not do the split the next run needs: place the pipe, then U it in the Civil copy, then repeat; or place a pipe by another route that skips the Design Warnings window.
3. **The brief's finalizer lead (CD and PIT editor windows borrowing the live graphics manager) is NOT supported on its own:** D and E opened the same editor windows and kept REDO. The borrowed manager would have to matter only when a pipe is actually written. That is a lead for the Opus/Codex side to read in the code; I cannot see it from the driver.
4. **Not proven:** PIT placed through the New Pit window (BLOCKED: only the never-click "Continue placement" places a pit; the driver is right to refuse it). I did not try the click, because the guide says the refusal is the answer.
5. **One thing the brief expected and I did not see:** the REDO echo "Everything has been redone". This build prints the redone command's name ("CIRCLE") when REDO works and "Nothing to redo" when it does not. Run 10 recorded "Everything has been redone"; the wording differs from the installed 3.0.46 build or the pairing differs. I report what AutoCAD printed.
6. Two lost walks, three kept walks. With run 10 (2 lost) and run 5 (4 lost) that is 8 lost of 8 with a placed pipe, against 18 kept of 18 without one.

## 5. Driver findings

1. **Nothing new refused.** `ui windows` lists the New Pipe window and Design Warnings correctly; "Creative Engineering | What's New" stays open all session and is closed by `quit`. It never blocked a call.
2. `esc` worked on the CD "Pick the next pipe's first point" prompt, as in run 10.
3. The three logs of the later copies (B2, B3, B4) exist because the recorder attaches to any drawing opened after it is loaded: no reload needed.
4. Logs are 0 bytes while AutoCAD runs (the recorder writes at close), so a mid-session read is not possible. Read them after `quit`.

## 6. What I did not test

1. A pit placed through the New Pit window (BLOCKED, section 4.4).
2. Pipe then U of the pipe, then the switch.
3. A pipe placed without the Design Warnings window, or by a route other than CD.
4. Case D with an existing pit opened in Edit Pit and closed with OK.

## 7. Recommendation

1. **Next run (one case each, about 10 calls):** (a) the same pipe, then `U` it in the Civil copy, then the walk (does an undone pipe still cost REDO?); (b) a pipe placed with a one-segment CD that makes no Design Warnings window (give it a fall) then the walk. If (b) keeps REDO the Design Warnings window is the cause; if (a) keeps it the pipe objects are.
2. **Desk:** BUG-558 stays open on Civil 3.0.46; do not mark it fixed. Tim should know the test is still failing with a pipe in the drawing.

## Summary

Claude ran run 16 in about ten minutes with 64 of 75 driver calls on fresh copies in AutoCAD 2027 (Civil 3.0.46, Manager 1.1.46, Structural 1.0.114, witness pin matching). With a CD pipe placed through the New Pipe window (P10 to P9, inverts 18.500, Design Warnings closed, Esc at the next-pipe prompt), a Structural plain circle, U, 15 s, switch to that Civil copy and back lost REDO in both cases tried, A and its repeat C ("Nothing to redo"), with three VIEWBACKSTATUS events between the U and the REDO each time. The control on a fresh Civil copy kept REDO (echo "CIRCLE"), and so did two extra cases: the New Pit window opened and cancelled (placing a pit was BLOCKED because the driver never presses "Continue placement"), and CD with the New Pipe window cancelled before any pipe was placed. So the loss follows a pipe actually placed, not the CD or PIT windows being opened, and BUG-558 is not fixed in this build. System variables are unchanged and nothing was saved.

AUTOCAD CLOSED
