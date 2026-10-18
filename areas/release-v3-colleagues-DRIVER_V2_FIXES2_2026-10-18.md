# Driver v2 fix pass 2: the msgbox review fixes and the three robot pass 9 tooling problems (Sun 18 Oct 2026, PC clock 15:59 to 16:35 Melbourne)

## ANSWER FIRST

1. **All fixes are built and proven.** Offline self-test: 377 PASS, 0 FAIL, 0 NOTE. Live in AutoCAD 2027 on a fresh test copy: 60 PASS, 0 FAIL, 4 NOTE (the 4 NOTEs are the known AutoCAD alert box limit, unchanged). Nothing on a real drawing, no real settings file changed.
2. **The robot answers a box once, and checks the box itself.** The "blind" route and the key-post route are gone. After any send (even one that timed out) the verb only waits and looks; it never sends a second answer. The box must show exactly Yes and No and carry the Recalculate question, or it is refused with the box left open. Cancel is off the Recalculate entry.
3. **Apply no longer gives a false HARD TIMEOUT.** Live: `ui press "Cascade Preview" Apply` took 34.2 s with no `-TimeoutSec` and came back normally (watchdog 120 s). Before, it was cut off at 30 s.
4. **A HARD TIMEOUT no longer puts the real settings back in the middle of a test.** While the AutoCAD the driver launched is still running under the same lock, the settings stay as they are and `quit` restores them. Proven live with a scratch settings file: hash back to the original after `quit`.
5. **The cosmetic count is fixed.** One backed-up file now says "1 settings file(s)", not "12".
6. **Opus look is needed** on the fix pass (section F). Not Opus-reviewed, not Codex-accepted, not Tim-accepted.
7. **AUTOCAD CLOSED. SETTINGS UNTOUCHED** (the 4 real settings files have the same SHA-256 at the end of the live pass as at the start; the guard test used a scratch file only).

## A. New hashes (sha256, first 12 and full)

1. **acad_driver_witness_v2.ps1: 120EE24D15B2** (`120ee24d15b25da9d60288fd88881a49fb5945dbe22f55b1de00305fb154a8b9`). Before: BE91276539F9.
2. **acad_driver_witness_v2.allowlist.json: 5B542F2145F4** (`5b542f2145f48936bfe11463933da60ff9539927ab9aa0eafefb0169a1aaddb3`). Before: F2E7CCC6735E. The pin inside the driver (line 2371) holds the same full value.
3. **driver_v2_selftest.ps1: DDE1359D5A2A.** Before: C78EFF0EE70F.
4. **DRIVER_TESTER_GUIDE.md: 069936B40933.** Before: B5A98D085ECF.
5. **Old drivers untouched:** acad_driver.ps1 C9BA503D4636, acad_driver_witness.ps1 0B1116C64249.

## B. Fix 1: the three MEDIUM findings of the msgbox review

1. **MEDIUM 1, drop the "blind" route: done.** A box with no Button windows is refused ("the box shows no button windows, so its answer cannot be read"). The plan now presses only a visible Button-class window with the answer's caption. The "other class" route, the `Blind` property and `blind_standard_id_only` are removed.
   1. **Refusal tests (offline, pure):** no button windows gives no plan and no routes; a child of another class carrying the caption and the standard id is not pressed; buttons that are not visible are not pressed.
   2. **Refusal test (offline, REAL window):** a real window of class #32770 with no Button children (made in a child process) and the listed title is found, the verb refuses it, no route is tried, and the window is still open afterwards.
2. **MEDIUM 2, answer once: done.** Route 1 is BM_CLICK. Route 2 (WM_COMMAND) is used only if route 1 refused BEFORE sending (button not in the box, not a button, disabled). A send that returns `timeout_or_failed` counts as sent: the verb waits 5 s and looks, and if the box is still there it fails with "an answer was sent ... and may still arrive ... do NOT call msgbox-answer again on this box ... run quit". The accelerator route (native `MsgBoxAccelerator`) is deleted. `Wait-V2MsgBoxGone` now counts only a really gone box as closed ("hidden" is still open; review LOW 8).
   1. **Timeout test (offline, REAL box):** the box's process is frozen after the box is listed and planned. Exactly one route is tried (`BM_CLICK: timeout_or_failed`), `answer_sent` is true, the failure text carries "may still arrive" and "do NOT call msgbox-answer again", and nothing else is sent. The frozen box is then woken and killed.
   2. **Route meaning test:** 13 route results are checked for their class (sent, try next, stop), including timeout, gone, hidden and wrong process.
3. **MEDIUM 3, check the box, not only the title: done.** Each `message_boxes` entry now lists `buttons` and `text_like`. The verb reads the box (visible Button captions with the & removed, and the Static text) and refuses unless the buttons are exactly the entry's set and the text matches. The Recalculate entry is now: title `CE ? Recalculate downstream inverts?` (anchored; the `?` is the dash), buttons Yes and No, text containing "Recalculate downstream pipe inverts", answers Yes and No. Cancel is removed from that entry, and from the `ui press` entry of the same window.
   1. **Refusal tests (offline, REAL boxes, each left open afterwards):** the listed title with Yes/No/Cancel buttons; the listed title with an OK-only box; the listed title and Yes/No but a different question ("Delete the whole drawing now?"); Cancel and OK asked of a correct box.
   2. **Also from the review's missing-test list:** two real boxes with the same listed title in two processes, only the owned one answered, the other still open; a real box titled "Save changes - Recalculate downstream inverts?" refused and left open.
4. **Review LOW items done in the same edit:** LOW 6 (read-only windows also never match a message box entry), LOW 7 (anchored title), LOW 8 (hidden is not closed), LOW 9 (comments corrected: Yes/No only, no accelerator, status line). **Not done:** LOW 4 (pass the expected title into the native check) and LOW 5 (compare the process id read at line 2970 with the owned AutoCAD). The send-once rule makes LOW 4 much less important; LOW 5 needs the live process list and I left it for the reviewer to decide.
5. **Live (AutoCAD 2027, test copy):** with the anchored title, the new buttons check and the text check the real box was answered No (route BM_CLICK, one entry in `routes_tried`) and Yes (BM_CLICK, Cascade Preview opened). Cancel and OK were refused on the real box with the box still open.
6. **"AutoCAD Message" is still NOT on the list.** The review says to add it only after these fixes are reviewed. I did not add it.

## C. Fix 2: `ui press` of slow buttons and the false HARD TIMEOUT

1. **How it works.** A window entry in the allow-list may carry `slow_press`, a map of button name to seconds. Today: Cascade Preview Apply 120, New Pit Continue placement 120. The driver reads the pinned allow-list BEFORE the watchdog starts (no AutoCAD call), matches the window words you typed (full name, part of a name, any case) and the button name, and sets the watchdog to the larger of that value and `-TimeoutSec` + 15, never more than 300 s. Every other press stays at 30 s. The 60-minute stop and the per-verb call cap are unchanged. The result shows `watchdog_sec` and `slow_press_watchdog`.
2. **Evidence, offline:** 20 argument shapes (partial names, upper case, wrong button, other windows with an Apply button, `ui set`, missing words) give 120 or 0 as expected; a value over the cap is cut to 300; a bad value (text, negative, zero, empty, huge) counts as 0; a longer value in the JSON is refused by the pin. Through the real driver (no AutoCAD): Cascade Preview Apply 120, New Pit Continue placement 120, Apply with `-TimeoutSec 90` 120, Apply with `-TimeoutSec 200` 215, Edit Pit Save pit and close 30, Cascade Preview Cancel 30, Edit Pit Cancel with `-TimeoutSec 90` 105, `ui set` 30, `status` 30.
3. **Evidence, live:** `ui press "Cascade Preview" Apply` with no `-TimeoutSec` took 34.2 s (over the old 30 s), came back `ok` with `watchdog_sec` 120, the preview closed, and AutoCAD went idle. The leaving pipe 109E23 then read 17.45, as the preview had shown.
4. **Not proven live:** New Pit "Continue placement" (only the 120 s value is proven, not a real 30 s plus press), and a real hung press that hits the full 120 s.

## D. Fix 2: a HARD TIMEOUT must not restore the settings mid-test

1. **Rule now.** The watchdog still leaves its "abandoned" mark when the guard holds backups. The next call restores first only if the pass is over: the lock is gone, expired or taken over, OR the AutoCAD the driver launched has ended or crashed. While the same lock is held AND that AutoCAD is still running (exactly one acad.exe, the one the driver launched or the lock names), the settings stay as they are and the call says `settings_recovery_deferred`. `quit` puts them back after AutoCAD has ended and re-hashes. An acad.exe that is not ours does not defer anything (restored as before).
2. **Evidence, offline (function level, scratch file, fake process list):** recovery decision for 7 situations (running under the same lock: not recovered; AutoCAD ended: recovered; lock released, expired, taken over: recovered; no mark rules unchanged); mark plus owned AutoCAD running: file stays changed over two calls, manifest and mark kept, deferral stated; foreign acad.exe: restored; AutoCAD gone: restored, hash equal the original, manifest and mark gone.
3. **Evidence, live (scratch settings file, real AutoCAD running):** `settings-temp set` changed the scratch file; a hand-written abandoned mark; `status` did NOT restore (file hash unchanged, mark and manifest kept, "deferred" reported); a second call also left it; after `quit -Kill` (the AutoCAD alert test forced it) the scratch file hash equalled the original and the mark and the manifest were gone. The hard-timeout watchdog itself (leaves the mark) is covered by the existing child-process tests; I did not force a real hung AutoCAD.
4. **Counting slip fixed.** The cause: a single backed-up file was unrolled into the entry itself, and its key count (12) was printed. Tests: 0, 1 and 2 files count 0, 1, 2; through the real driver, one `settings-temp set` shows "SETTINGS GUARD ACTIVE: 1 settings file(s)"; live, the same.

## E. What was run and what it did not cover

1. **Offline stage 0:** 377 PASS, 0 FAIL, 0 NOTE (run three times; the first run had one failure of my own, a wrong assertion about an unset field, fixed; the second had the older ClassifyPoint test fail because another window was on top of the test form, which passed on the next run). About 150 lines concern this work. Real Windows message boxes in child processes: answer No and Yes by BM_CLICK, WM_COMMAND on a real box, then the refusals above.
2. **Live stage 8 (tag CLD98), 61 driver calls:** pre-flight met (no acad, no accoreconsole, Codex queue.log last line END, no tester_run job, no lock). Fresh copy of DRV1_B1 (hash 34BBE37C2EA4 before and after), driven by the driver-launched AutoCAD. 60 PASS, 0 FAIL, 4 NOTE. The 4 NOTEs are the known limit: AutoCAD's own "AutoCAD Message" box cannot be pressed or answered, so `quit` fails and `quit -Kill` is used.
3. **Cleanup:** my copy CLD98_M1 and its backup and lock leftovers are deleted; the fixture hash is unchanged; the lock is released; no acad.exe; no guard file left. Older CLD95 to CLD99 leftovers are not mine.
4. **Not tested:** other CE message boxes; a message box in a Structural drawing; the WM_COMMAND fallback in AutoCAD itself; the cascade U and REDO after Apply; New Pit Continue placement live.

## F. Please ask Opus to look at (diff only)

1. `Get-V2MsgBoxPlan`, `Get-V2MsgBoxShapeProblem`, `Get-V2MsgBoxSendClass`, `Wait-V2MsgBoxGone` and the route loop in `Invoke-V2MsgBoxAnswer`: is "send once, then only look" airtight, and is "try next only after a refusal before sending" right?
2. The `message_boxes` entry (title pattern with `?`, buttons, text_like) and the new pin 5B542F2145F4.
3. `Get-V2SlowPressForArgs` (title matching is by the typed words, not the real window) and the 120 s values.
4. `Get-V2RecoveryDecision` and `Invoke-V2StartupRecovery`: the "AutoCAD still running" test uses the owned-AutoCAD check; is deferring until `quit` safe when a call is cut off by a real hang?
5. Open LOW items 4 and 5 from the msgbox review.

## G. The four words

**Built:** yes (driver 120EE24D15B2, allow-list 5B542F2145F4). **Tested:** 377 offline checks and one live AutoCAD stage by a Claude robot on a test copy, as above. **Installed:** not applicable (a tool on this PC). **Accepted:** not Opus-reviewed, not Codex-accepted, not Tim-accepted.

AUTOCAD CLOSED
SETTINGS UNTOUCHED
