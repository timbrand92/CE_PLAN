# Driver v2: `msgbox-answer`, a narrow verb that answers the Edit Pipe "Recalculate downstream inverts?" message box (Sun 18 Oct 2026, PC clock 14:01 to 14:47 Melbourne)

## ANSWER FIRST

1. **It works in AutoCAD 2027.** On a fresh copy of DRV1_B1 the Edit Pipe Save opened the plain Windows message box "CE - Recalculate downstream inverts?", and `msgbox-answer "*Recalculate*" No` and `msgbox-answer "*Recalculate*" Yes` both closed it, by the first route (BM_CLICK sent to the box's own button). The cascade fix tests are no longer blocked by this box.
2. **Which answers work:**
   1. **No: works.** The box closed, Edit Pipe closed, AutoCAD went idle. Nothing downstream moved: the leaving pipe 109E23 still started at 17.25 afterwards (read back in Edit Pipe), and the arriving pipe 10A98D kept its own new level 17.60.
   2. **Yes: works.** The box closed and the Cascade Preview window opened ("Anchor: P3, IL 17.70, 4 pipes, 5 pits - ready to apply"; leaving pipe P3 to P2 shown going from 17.25 to 17.45, +0.20 both ends). I read it with `ui tree`, took a picture, and cancelled it with `ui press "Cascade Preview" Cancel` (nothing applied, window closed, AutoCAD idle).
   3. **Cancel: refused, correctly.** The real box has only a Yes and a No button (ids 6 and 7), no Cancel. Cancel is on the allow-list as the brief asked, but the verb sees there is no such button and sends nothing ("no button named Cancel").
   4. **OK: refused** for this box (not on its entry).
3. **Refusals tested for real, each time with the box still open afterwards:** an answer not on the entry (OK), an unknown answer word (Maybe), a title that matches no open box (the message names the boxes that are open), a drawing that is not a test copy (live, see section C.5), no lock, somebody else's lock, a box of another process, a listed box with no matching button, and a box whose title is not on the list (AutoCAD's own alert box "AutoCAD Message", opened for the test).
4. **Hashes (sha256, first 12 and full):**
   1. **acad_driver_witness_v2.ps1: BE91276539F9** (`be91276539f92c728e6b372241c047af349e4737e1c6bd9c06b3e4df085084f4`). Before this work: C97491233294.
   2. **acad_driver_witness_v2.allowlist.json: F2E7CCC6735E** (`f2e7ccc6735eb7429822b41b07b3fd28582b0ad30c6e0afa04b22cf7daa33858`). Before: 628876B92760. The pin inside the driver (line 2370) holds the same full value.
   3. **driver_v2_selftest.ps1: C78EFF0EE70F**, **DRIVER_TESTER_GUIDE.md: B5A98D085ECF**.
   4. **Old drivers untouched:** acad_driver.ps1 C9BA503D4636, acad_driver_witness.ps1 0B1116C64249 (same as run 29).
5. **Still impossible or unproven:** see section D. The main one: AutoCAD's own alert box ("AutoCAD Message", for example from a LISP alert) is also a plain message box, `ui press` still cannot press its OK, and `msgbox-answer` refuses it because it is not on the new list. It needs `quit -Kill`. Listing it is one more reviewed edit; I did not do it.
6. **Opus has not reviewed this change.** Review points are in section E.
7. **AUTOCAD CLOSED. SETTINGS UNTOUCHED** (no setting was changed; the four real settings files hash the same at the start and the end of every pass, section C.7).

## A. What was built (all in the driver folder `C:\Lisp Files\_ACAD_DRIVER`)

1. **New verb:** `msgbox-answer "<title wildcard>" Yes|No|Cancel|OK`. It looks only at dialog boxes (window class #32770) of the AutoCAD process the driver launched, finds the one whose title matches your wildcard, and then needs that title to match an entry in the NEW allow-list section `message_boxes`, with the answer on that entry's list. Today the section has one entry: title `*Recalculate downstream inverts*`, answers Yes, No, Cancel.
2. **How it answers (stops at the first that closes the box):**
   1. **BM_CLICK** sent (SendMessageTimeout, 2.5 s) to the box's own Button window, found by walking the box's child windows and matching the caption with the `&` removed, case-insensitive.
   2. **WM_COMMAND** (button clicked) with the button's own id (6 Yes, 7 No, 2 Cancel, 1 OK) posted to the box. Added when the button's own id is 1 to 7.
   3. **The accelerator letter** (WM_SYSCHAR with the Alt flag) posted to the Button window itself. Measured offline: posted to the box it did nothing, posted to the button it clicked it.
   4. **A box with no button windows at all** (a TaskDialog style box) gets the standard-id WM_COMMAND only, and the result says `blind_standard_id_only`. A box that has buttons but none with the wanted caption gets nothing sent.
3. **Before each route** the box is checked again (still there, still the same process, still the same title), so it can never answer twice and never answer a different window that reused the handle. After each route the verb waits up to 2.5 s for the box to close. If no route closes it, the call fails loudly and says to mark the check BLOCKED and run `quit`.
4. **Safety, all in code and unit-tested:**
   1. The lock is yours (checked first), exactly one acad.exe and it is the driver's, and the active drawing is a test copy: the same `Assert-UiWrite` check that `ui press` uses, run BEFORE any window is looked at.
   2. The title must be on the `message_boxes` list; the old never-touch window titles (Save, Sign In, Windows Security, the AutoCAD main window) never match; the never-press list and the Settings gate are applied to the answer.
   3. No SendKeys, no keyboard event, no mouse, no bring-to-front, no focus change anywhere in the new code (a test scans the new code text for those words).
   4. Counted (cap 20 per pass), written to the audit log (`transcripts\v2_audit.jsonl`: title pattern, answer, dialog title and handle, process id, the question text, the buttons seen, routes tried, result), covered by the hard timeout watchdog, and lock-checked like the other write verbs.
5. **Detection:** `ui windows` and `ui press` now print `message box waiting: use msgbox-answer "<title>" Yes|No|Cancel  (a plain Windows message box: ui press cannot reach its buttons)` when such a listed box is open (one line, even though UI Automation and Win32 both list the window). `ui windows` also sets `message_boxes_waiting` in the data. An UNLISTED box still produces the older STOP line.
6. **Allow-list and pin:** `message_boxes_note` and `message_boxes` added to the JSON; the SHA-256 pin in the driver is updated to the new file (section A hashes). No other entry changed. The existing `*Recalculate downstream inverts*` entry in `windows` stays, so the box can still be read with `ui tree`.
7. **Guide:** `DRIVER_TESTER_GUIDE.md` section 9: new item 9.1.11 (how, guards, measured facts, the Edit Pipe example), the lock list, the cap list and the 9.4 limits updated.

## B. Tests

1. **Offline part of the self-test (`driver_v2_selftest.ps1 -Stage 0`): 286 PASS, 0 FAIL, 0 NOTE** (was 226 on run 29; 60 new lines, all with "msgbox" in their name). Includes:
   1. The allow-list holds exactly the one entry; the real title with the em dash matches; eight other titles (Save Drawing As, the AutoCAD main window, AutoCAD Message, Edit Pipe, Windows Security, and so on) have no entry.
   2. Answer decisions: Yes, No, Cancel allowed; OK refused; Maybe, Delete, Overwrite, Yes to all and an empty answer refused; no entry refused; the never list beats an entry.
   3. The plan for a box: routes in the right order, caption `&` handling, a disabled button not pressed, two buttons with one caption refused, no OK button gives no plan, a box with no button windows gets the standard-id route only.
   4. A widened `message_boxes` entry is refused by the pin.
   5. **Real Windows message boxes in a child process** (no AutoCAD): the whole verb end to end for No, Yes and Cancel (the child process reports exactly which button it received), all three routes on real boxes (BM_CLICK, WM_COMMAND, accelerator: all closed the box and returned the right answer), then the refusals above with the box confirmed still open each time, a box of another process never touched (the native routes return wrong_process), no lock, somebody else's lock, an unlisted box, an OK-only box, and no box at all.
   6. Command-line refusals through the real driver: no lock, no AutoCAD, unknown answer word, no arguments.
   7. The audit log shows every attempt (12 lines in that run: answered 3, refused 5, failed 4).
   8. The first full run had one failure outside this change: "ClassifyPoint ok" (an older click-canvas test that puts a form on screen and asks Windows what is under a point; Explorer was under it, so the PC desktop was not showing the form). It passed on the next run. Environment, not the driver.
2. **AutoCAD part (`-Stage 8 -Tag CLD97`, new): final run 50 PASS, 0 FAIL, 4 NOTE** (the 4 NOTEs are the known alert-box limit, section D.1). The stage ran four times in all (fixing two faults of my own along the way, section C.6).
   1. Pre-flight each time: `Get-Process acad,accoreconsole` empty; `queue.log` last line END, no START open; no cmd.exe with tester_run (the stage's own pre-flight now checks the last one too).
   2. Fresh copy of DRV1_B1 (hash 34BBE37C2EA4 before, still 34BBE37C2EA4 after); lock acquired; AutoCAD launched by the driver.
   3. `pick-first "10A98D"`, `type "CDEDIT`nY" -Enter -Force -ExpectWindow "Edit Pipe"`, baseline read 17.40 / 17.30, `ui set` 17.60 and 17.50, `ui press "Edit Pipe" "Save pipe and close"`. The press result listed the new window and printed the "message box waiting" line. `ui windows` printed it too. `ui tree` read the question: "The downstream invert on pipe 10A98D changed from 17.30 to 17.50. Recalculate downstream pipe inverts at each pipe's current grade? You will see a preview of every affected pipe before anything is applied." Picture taken (`robot_shots\V2_SELFTEST_20261018\m1_question_4.png`: the box shows Yes and No).
   4. Refusals with the box open (C.5), then `msgbox-answer "*Recalculate*" No`: route BM_CLICK, box closed, Edit Pipe closed, idle. Leaving pipe 109E23 opened and read: first invert 17.25 (unchanged). Arriving pipe reopened: 17.60 (its own edit kept).
   5. Second edit to 17.80 / 17.70, Save, `msgbox-answer "Recalculate downstream inverts" Yes`: route BM_CLICK, box closed, "Cascade Preview" opened. Read, pictured (`m1_cascade_preview_4.png`), cancelled, closed, idle.
   6. The unlisted-box test (AutoCAD alert), then `quit` (refused to close because the alert box was open), then `quit -Kill` (allowed: the AutoCAD named in the lock). Nothing was saved.
3. **Everything AutoCAD printed or showed is recorded** in `C:\ce_rc_scratch\v2_selftest\results.jsonl` and the audit log. The Opus reviewers can replay the stage with `pwsh -NoProfile -File "C:\Lisp Files\_ACAD_DRIVER\driver_v2_selftest.ps1" -Stage 8 -Tag CLD98` when AutoCAD, Codex and robot jobs are free.

## C. Conditions, proofs and honest notes

1. **Clock:** Sunday, free window (RULES 1.8). Tim not involved.
2. **Lock:** `lock acquire "Claude" -TimeoutSec 0` by the stage each time; released by `quit` each time (checked `lock status` = none after each). No `-Force` anywhere.
3. **Settings:** no setting changed, no `settings-temp`, no `arm`, no Settings window. The four real settings files hash ACD64E79A33B, 622A246F7D3B, 24D8E5F7D87B, EFE307C4FC74 at the start and the end of the passes (the `quit` output printed "the 4 settings files have the same SHA-256 as at the start of the pass" every time, including after both `quit -Kill`).
4. **Fixture and copies:** DRV1_B1 hash 34BBE37C2EA4 unchanged. My copy CLD97_M1 and its leftovers (`_PRE_C7_`, `.dwl`, `.dwl2`) are deleted. The older CLD95/CLD96 leftovers from run 29 are not mine and are still there for the desk to delete.
5. **Live "not a test copy" refusal:** while the box was open (AutoCAD busy, so the driver uses its remembered drawing), I pointed the remembered drawing at a real folder in the driver's own `state.json` for ONE call, then put the file back byte for byte (hash checked). The call was REFUSED: "AutoCAD is busy (a command is active) and the last known drawing cannot be trusted: the remembered drawing is not an approved test copy". The box stayed open. A remembered drawing older than 10 minutes is refused the same way, so a box left open for more than 10 minutes must be dealt with by `quit`.
6. **My two faults along the way (cost: two extra AutoCAD sessions):**
   1. The first live run listed the box twice in `ui windows` (UI Automation and Win32 both list it), so my stage skipped the No step and the later steps failed against an open box. Fixed in the driver (one row per window) and the test.
   2. My expectation said the box has Yes, No and Cancel buttons (as run 29 reported); it has Yes and No only. Test corrected; this is a finding, not a driver fault.
   3. The third run opened AutoCAD's alert box for the unlisted-box test and could not dismiss it; I ended that AutoCAD with `quit -Kill` by hand (allowed, the lock named it, no settings entry live). The stage now ends with `quit`, then `quit -Kill` if the alert box is still open.
7. **Calls:** every msgbox-answer call is counted and audited. The final stage used 51 driver calls (7 of them msgbox-answer: 5 refusals or failures and 2 answers).

## D. What is still impossible, unproven, or a decision

1. **AutoCAD's own alert box** ("AutoCAD Message", opened for example by a LISP alert): a plain message box too. `ui press` says "no button named OK" (the `AutoCAD Message*` window entry with OK in the JSON cannot work for that reason), `msgbox-answer` refuses it (not listed), and only `quit` then `quit -Kill` clears it. Adding `AutoCAD Message*` with answer OK to `message_boxes` would fix it, but it needs a reviewed edit and a new pin; the brief said start with the one box. **Recommendation:** add it after the Opus look, because any CE or LISP alert would otherwise strand a robot pass the same way.
2. **Routes 2 and 3 were not needed in AutoCAD** (route 1 closed the box both times). They are proven on real Windows boxes, not on AutoCAD's.
3. **A TaskDialog or WPF window** (the "blind" standard-id route): built, unit-tested on a fake child list only, never seen in AutoCAD. Opus may prefer to drop it.
4. **Cancel and OK on the Recalculate box:** Cancel is listed but the box has no Cancel button (refused with "no button named"); the answer to a closed-by-X box is not covered.
5. **A box that stays open more than 10 minutes** is refused by the test-copy check (C.5).
6. **Not tested:** other CE message boxes (none listed); a message box in a Structural drawing; the box while a second drawing is open; the cascade Apply, U and REDO after Yes (the preview was cancelled on purpose; nothing was applied).
7. **For the desk:** the cascade tests that were BLOCKED in run 29 (Yes path, No path, U and REDO after Apply) can now be run with this verb. Ask the next robot to press Apply in the preview only on a test copy and to read the leaving pipe 109E23 afterwards (expected first invert 17.45, shown in the preview).

## E. Please ask Opus to look at

1. **The new native code** (`AcadV2Native.MsgBoxCheck`, `MsgBoxChildren`, `MsgBoxBmClick`, `MsgBoxWmCommand`, `MsgBoxAccelerator`) and **`Invoke-V2MsgBoxAnswer`**, `Get-V2MsgBoxPlan`, `Get-V2MsgBoxEntries` in `acad_driver_witness_v2.ps1`: is a message sent to a button window of a dialog of the driver's own AutoCAD, after the lock, the owned-AutoCAD, the test-copy and the allow-list checks, narrow enough?
2. **The "blind" route** for a box with no button windows (D.3): keep or drop.
3. **The `message_boxes` JSON section and the new pin** (`F2E7CCC6...`).
4. **The two output additions** in `ui windows` and `ui press`.
5. **Whether `AutoCAD Message*` / OK should be added** (D.1).
6. **The inherited weakness the new verb shares with `ui press`:** while a box has AutoCAD busy, the test-copy check uses the remembered drawing (checked for age, process and name in the window title), not a live read.

**Built, tested, installed, accepted:** driver change built; 286 offline checks pass and the live stage passed (50 PASS, 0 FAIL, 4 NOTE) on a test copy by a Claude robot; a tool, not installed anywhere; not Opus-reviewed; not Codex-accepted; not Tim-accepted.

AUTOCAD CLOSED
SETTINGS UNTOUCHED
