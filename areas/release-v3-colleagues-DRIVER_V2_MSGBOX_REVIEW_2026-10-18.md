# Opus review of the driver v2 `msgbox-answer` verb (Sun 18 Oct 2026)

## FOR TIM

1. **Verdict: GO-WITH-CONDITIONS.** The robot may use the new "answer the message box" step in real test passes, but only for the one box it was built for: Edit Pipe's "Recalculate downstream inverts?" question.
2. **What it means on a job:** the cascade tests that got stuck on that Yes/No box can now run. On a test copy, the robot answers Yes or No the way you would click it, and nothing else.
3. **What it cannot touch:** a box from another program, a Windows security prompt, or AutoCAD's own "Save changes?" box. I checked that in the code, not in the report.
4. **AutoCAD's own "AutoCAD Message" OK box:** yes, add it, but only after three small fixes (section 3). It can carry bad news such as "drawing is read-only" or "save failed", so the robot must copy the text out and report it every time.
5. **Nothing for you to do.** This is robot plumbing. Nobody has run the fixed version yet.

---

**Reviewed by reading the code:** `acad_driver_witness_v2.ps1` (sha256 BE91276539F9..., equal to the builder's figure), `acad_driver_witness_v2.allowlist.json` (sha256 F2E7CCC6735E..., equal to the pin at line 2370), `driver_v2_selftest.ps1` (C78EFF0EE70F...), `DRIVER_TESTER_GUIDE.md` section 9, the builder's report `release-v3-colleagues-DRIVER_V2_MSGBOX_2026-10-18.md`, and the audit log `transcripts\v2_audit.jsonl`. Only read-only commands were run (hashes, text search, git). I did not run the driver, the self-test, AutoCAD or accoreconsole, and I did not edit any driver file.

## 0. Checks that came out right

1. **The old drivers are untouched.** `acad_driver.ps1` C9BA503D463610D0F370... and `acad_driver_witness.ps1` 0B1116C64249BF18759C..., as in every earlier review.
2. **The pin is real.** `Read-V2AllowListFile` (2378-2390) hashes the bytes on disk and throws unless they equal the pin at 2370. The only way round it is `$script:V2AllowListTestOverride` (2371), which no command-line switch or environment variable sets. The file path is fixed to the script's own folder (2368). An edited JSON therefore stops every V2 verb, not just this one. The self-test tampers with the `message_boxes` entry and sees the refusal (selftest 410-414).
3. **Only the driver's own AutoCAD.** Order in `Invoke-V2MsgBoxAnswer` (2954-3034): lock held by me (2959), lock not someone else's (2967), `Assert-UiWrite` (2968: exactly one acad.exe, launched by this driver or named in the lock, active drawing a test copy), then the windows are listed for that one process id only (2973). Every native send re-checks that the dialog is alive, is class `#32770`, is visible and belongs to that process id (`MsgBoxCheck`, 2730-2740); the button routes also check that the button is a child of that dialog and of that process (2765-2766, 2785-2786).
4. **Other programs and Windows prompts are out of reach.** A Windows UAC prompt runs in another process on the secure desktop, and another program's boxes have another process id: neither is ever listed (2973) and every send refuses them (`wrong_process`). AutoCAD's own "Save changes" and main-window titles are killed by the never-touch list before any allow-list entry is read (`Get-V2MsgBoxEntries` 2885, list at 115).
5. **Every call is counted and logged, refusals included.** `Register-V2Call` runs before anything else in `Invoke-Main` (4440), the cap is 20 (2374), the verb writes its own audit line in both the success and the catch path (3028, 3031), and `Invoke-Main` writes a second `call_end` line after every V2 call (4492-4494). The watchdog covers the verb (4436). The audit log holds 37 msgbox-answer lines; the live stage lines match the report (refusals for OK, Maybe, missing arguments, a title that matches nothing, the not-a-test-copy drawing and the unlisted "AutoCAD Message" box; answers No and Yes, both by BM_CLICK).
6. **No keyboard, mouse or focus change in the new code.** The native block (2728-2788) uses only `SendMessageTimeout`, `PostMessage`, `EnumChildWindows` and read calls. No SendKeys, no `keybd_event`, no `mouse_event`, no `SetForegroundWindow`.
7. **Defender hygiene and secrets.** The new C# sits inside the driver file's existing `Add-Type` block, not in an inline `-Command`; no reflection loading, no base64, no web address in the new code. The allow-list holds only window titles, button words and test-folder paths. No key or token anywhere in the change.

## 1. Findings

### HIGH

None. I found no route by which the verb can answer a box of another process, a box on the never-touch list, or a box whose title is not on the pinned list.

### MEDIUM

1. **MEDIUM 1: the "blind" route answers a box whose buttons it cannot read. DROP it.** `Get-V2MsgBoxPlan` 2926: when the box shows no `Button` windows at all, it posts `WM_COMMAND` with the standard id (6 for Yes, 7 for No) to the dialog without reading any caption. On a TaskDialog-style box the meaning of id 6 or 7 is whatever the author gave it (custom buttons can use any id), so a "Yes" could land on a button that says something else. It is also reached by accident: `$anyBtn` counts only VISIBLE buttons (2914), so a box listed while it is being built or torn down, or an `EnumChildWindows` that returns nothing, also looks button-less. It has never been seen in AutoCAD and no listed box needs it. **Fix:** replace line 2926 with `elseif (-not $anyBtn.Count) { return & $fail "the box shows no button windows, so its answer cannot be read; nothing was answered" }`; remove the `Blind` property and `blind_standard_id_only` (2996); change selftest line 398 to expect a refusal. Also drop the "other class" route (2923-2925): it needs a non-Button child with the caption AND the standard id, has no known use, and was never exercised on a real box.
2. **MEDIUM 2: after a timed-out or unclosed first try, a second answer is sent.** Route loop 3000-3013: when `BM_CLICK` returns `timeout_or_failed` (2771), the loop goes straight to route 2 without waiting, and posts `WM_COMMAND` too. A `SendMessageTimeout` that timed out can still be processed later, so the box may receive the answer twice, and the result then names the wrong route. When `BM_CLICK` was really processed and the box still did not close, `WM_COMMAND` with the same id and the accelerator go to the same handler, so they add nothing except more posted messages that can land after the verb has reported "still open" and the robot has moved on to `quit`. Today the damage is limited (same answer, same box, test copy), but the evidence would be wrong. **Fix:** treat `timeout_or_failed` like `sent`: wait for the box to close (`Wait-V2MsgBoxGone`, 5 s). Once any message has been sent, never try another route. Use route 2 only when route 1 refused BEFORE sending (`button_not_in_dialog`, `not_a_button_class`, `button_disabled`). Drop route 3 (`MsgBoxAccelerator`, 2779-2788, and plan line 2929): it posts a keyboard message into AutoCAD's thread, it was never needed in AutoCAD, and once the "send once" rule applies it can never be reached. If the box is still open, say in the failure text: "an answer was sent and may still arrive; mark BLOCKED, do not call msgbox-answer again on this box, run quit."
3. **MEDIUM 3: the entry trusts the title only, not the question.** `Get-V2MsgBoxEntries` (2883-2887) matches the title, and the plan then presses any button whose caption equals the answer. If CE later reuses the same title for a different question, or changes Yes/No to Yes/No/Cancel, the robot keeps answering without anyone noticing. The entry also lists Cancel, which the real box does not have (measured: Yes id 6 and No id 7). **Fix:** add `"buttons": ["Yes", "No"]` to each `message_boxes` entry and refuse when the set of visible `Button` captions (with `&` removed) is not exactly that set. Add an optional `"text_like"` (for this box `"*Recalculate downstream pipe inverts*"`) checked against the joined `Static` text (2990). Remove Cancel from the Recalculate entry's `answers`. The pin is updated in the same reviewed edit.

### LOW

1. **LOW 4: the title re-check and the send are not one step.** The title is compared in PowerShell (3004) and the native call re-checks only the process, class and visibility. Re-use of a window handle in that short gap is practically impossible, but the fix is cheap: pass the expected title into `MsgBoxCheck` and compare it there, so every send checks process, class, visibility and title together.
2. **LOW 5: the process id is read twice.** `Assert-UiWrite` (2968) proves that the single acad.exe is ours. Line 2970 then calls `Get-UiPids` again and uses that id without comparing it. **Fix:** compare the id from 2970 with `Get-AcadProcInfo` and the launch record or lock (`Test-OwnedAcad`), and refuse if they differ.
3. **LOW 6: `Get-V2MsgBoxEntries` skips the never-touch titles but not the read-only titles.** `Find-V2Entries` (2399-2400) checks both lists, but the new function (2885) checks only `$script:UiWindowDeny`. **Fix:** add the same `$script:UiReadOnlyWindows` loop, so a Manager-style read-only window can never become answerable through a future entry.
4. **LOW 7: anchor the title.** `*Recalculate downstream inverts*` cannot match "Save changes?" or any AutoCAD box today. Still, anchor it to the measured title, `CE ? Recalculate downstream inverts?` (the `?` stands for the dash and the question mark). A future CE box that merely contains the phrase then cannot ride on this entry.
5. **LOW 8: "hidden" counts as closed.** `Wait-V2MsgBoxGone` (2949) treats any check result other than `ok` as closed, including `hidden`. **Fix:** count only `gone` as closed; report `hidden` as "the box is hidden but still exists" and fail.
6. **LOW 9: the comments do not match the code.** Line 2874 says the box has Yes / No / Cancel, but it was measured as Yes and No. Line 2878 says the accelerator is posted to the dialog, but the code posts it to the button (2787). Line 2365 still says "NOT REVIEWED BY OPUS YET". Update these with the fixes.
7. **LOW 10: the inherited busy-AutoCAD weakness (report E.6) is acceptable.** While the box is open, AutoCAD refuses COM, so the test-copy check uses the remembered drawing (age 10 minutes or less, same process, name in the window title). The live refusal in report C.5 shows it works. A box left open longer must be ended with `quit`, as the guide says.

## 2. Did the tests exercise the refusals with a real second dialog? Partly.

1. **Wrong title: yes, for real.** Live in AutoCAD, the unlisted "AutoCAD Message" box was refused and stayed open (audit 14:43:57). Offline, a real "Some Other Question" box in a child process was refused (selftest 492-495).
2. **Wrong process: only one box at a time.** Offline, a real listed-title box was put in a child process while the driver was told that the AutoCAD is the self-test's own process (478-481). The verb never listed it, and each native route returned `wrong_process`. That proves the filter, but there was never a decoy open at the SAME time as a genuine box.
3. **Missing tests (add with the fixes; none needs AutoCAD):**
   1. Two real boxes with the same listed title, one in the "owned" process and one in another process: only the owned one is answered, and the other is still open afterwards.
   2. A real box titled "Save changes - Recalculate downstream inverts?" (a listed phrase plus a never-touch phrase): refused.
   3. A real box with the listed title but buttons Yes/No/Cancel (wrong button set, MEDIUM 3): refused.
   4. A box with no button windows (MEDIUM 1): refused.
   5. A send that times out (a child whose UI thread sleeps after the box is listed): exactly one route tried, failure text says the answer may still arrive (MEDIUM 2).

## 3. Conditions

**A. For real robot passes now, before the code fixes (procedure only):**

1. Use `msgbox-answer` only on the "Recalculate downstream inverts?" box, only Yes or No, and only on a test copy with the lock held. Never use it with Cancel or OK.
2. Read the box first: `ui tree` (or the `message_text` in the result). Answer only if the text is the downstream-invert question.
3. If the result says the box is still open: mark the check BLOCKED, do NOT call `msgbox-answer` again on that box, then run `quit` (and `quit -Kill` only if `quit` says AutoCAD did not close).
4. Record `route_used` in the evidence. Anything other than `BM_CLICK` is a NOTE for the desk.
5. The allow-list stays exactly as pinned (F2E7CCC6735E). No new entry before B is done and reviewed.

**B. Code fixes required before any second `message_boxes` entry, including "AutoCAD Message":**

1. MEDIUM 1, 2 and 3 fixed, and the five tests in section 2.3 added and passing.
2. LOW 4 to 9 fixed in the same edit (small).
3. One new pin, one Opus look at the diff only.

## 4. Should "AutoCAD Message" / OK be added? Yes, after condition B, in this exact form

1. **Why add it:** any LISP `(alert ...)` or AutoCAD alert would otherwise strand a robot pass with no way out except `quit -Kill`, which throws away the rest of the pass.
2. **The risk:** OK is the only choice, so pressing it decides nothing. The danger is that the robot hides the MESSAGE. "Drawing is read-only" means later saves silently go nowhere. "Save failed" makes a save test meaningless. "Customization file load failed" means a missing ribbon or menu, and later tests fail for the wrong reason. The answer must never make the problem disappear.
3. **The entry:** `{ "title": "AutoCAD Message", "answers": ["OK"], "buttons": ["OK"] }`. Use the exact title with no wildcard, and require exactly one visible button, OK. A box with that title and Yes/No buttons is refused, because we do not know what AutoCAD would do with the answer.
4. **What the verb must do for it:**
   1. Take a picture of the box before pressing (the existing PrintWindow route, saved into the robot shots folder), and put the picture path in the result and the audit line.
   2. Print the full box text as its own output line, `AutoCAD said: "<text>"`. Raise the 400-character cut (2991) to 2000 characters for this entry.
   3. If the text contains any of read-only, failed, fail, error, cannot, unable, not found, corrupt, recover, denied, invalid or missing, add `WARNING: AutoCAD reported a problem; the check that opened this box cannot PASS on its own`. This is warn and record (R-27), not a block.
5. **Robot rule in the guide (section 9):** the text of every answered "AutoCAD Message" box goes into the check's evidence. A check that opened one is reported as NOTE (or FAIL if the warning line appears), never as a clean PASS, until the desk has read the text.

## 5. Status in the four words

**Built:** yes, by the builder (driver BE91276539F9, allow-list F2E7CCC6735E). **Tested:** 286 offline checks and one live AutoCAD stage, per the report; I read the audit log, which agrees, but did not re-run anything. **Installed:** not applicable (a tool on this PC). **Accepted:** Opus-reviewed with conditions here; not Codex-accepted, not Tim-accepted. Nothing in section 3 B has been built yet.
