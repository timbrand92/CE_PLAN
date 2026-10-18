# Opus review of driver v2 fix pass 2 (Sun 18 Oct 2026)

## VERDICT: GO-WITH-CONDITIONS for robot pass 10 on test copies

1. **For Tim:** the robot may use the new driver in pass 10. It answers the "Recalculate downstream inverts?" box once and only that box. A slow Apply no longer cuts the robot off. Your four real settings files are still put back and hash-checked at `quit`.
2. **Main condition:** the robot must never ask the same box twice (condition 1). The code tells it not to, but it does not yet stop it.
3. **Nothing for you to do.** I read the code; I did not run AutoCAD, accoreconsole or the self-test.

**Hashes on disk equal the expected values:** driver 120EE24D15B2, allow-list 5B542F2145F4, self-test DDE1359D5A2A. Reviewed with read-only commands only.

## Conditions for pass 10

1. **MEDIUM (procedure now, code before any second `message_boxes` entry): "answer once" holds within one call, not across calls.** `Invoke-V2MsgBoxAnswer` (2969-3053) keeps no record of the boxes it has already answered. After the "may still arrive ... do NOT call msgbox-answer again" failure (3037), a second `msgbox-answer` on the same box (state `ok`/`hidden`) passes every check and sends again. **For pass 10:** after any msgbox-answer failure with `answer_sent: true`, the robot's next driver call on that AutoCAD must be `quit` (then `quit -Kill` only if needed). Any other call is a protocol breach. **Code fix:** store the box handle and the process id in the V2 state when `answer_sent` is true, and refuse a later msgbox-answer on the same handle and process.
2. **LOW (same later edit): a box that changes between plan and send may still get route 2.** `Get-V2MsgBoxSendClass` (2939) makes `button_disabled` and `button_wrong_process` "try next", so WM_COMMAND (2776-2780) can be posted for a button that the box has just disabled. The plan already refuses a disabled button (2915), so this needs a change within milliseconds. Make both `stop`. Keep `button_not_in_dialog` and `not_a_button_class` as try-next.
3. **LOW (procedure): end every pass with `quit` and read the pass-end hash line.** The deferral (section 4) means that after a hard timeout the real settings stay changed until `quit`, an expired lock (90 min, line 140) or AutoCAD ending. If the robot stops without `quit`, nothing restores them until the next driver call. The pass is not finished until `quit` reports the four settings hashes equal the start (`Invoke-V2PassEnd`, 3837) and `settings-temp status` shows 0 entries.
4. **LOW (procedure): keep `-TimeoutSec` at 120 or less on `ui press`, except for named slow buttons.** See section 3.2.

## 1. The three MEDIUM findings: closed within one call

1. **MEDIUM 1, blind route: closed.** `Get-V2MsgBoxPlan` (2906-2920) presses only a visible `Button` window whose caption, with the `&` removed, equals the answer. A box with no visible buttons is refused (2911). The other-class route, the accelerator and `Blind` are gone. The native code is left with only `MsgBoxBmClick` and `MsgBoxWmCommand` (2763-2780).
2. **MEDIUM 2, answer once: closed for one call (see condition 1 for two calls).** The route loop (3019-3031) breaks on the first `sent` or `timeout_or_failed` (2938) and then only waits (`Wait-V2MsgBoxGone`, 2960-2968, which treats `hidden` as still open). It never reaches route 2. Route 2 runs only after a refusal that happened before any send. Before each route the loop re-checks the live box (3020) and its exact title (3021).
3. **MEDIUM 3, check the box: closed.** `Get-V2MsgBoxShapeProblem` (2922-2934) runs before the plan and requires all three of these:
   1. The visible buttons are exactly {Yes, No}.
   2. The Static text matches `*Recalculate downstream pipe inverts*`.
   3. The entry has a buttons list (an entry without one is refused).
4. **The entry is tight.** The title is anchored as `CE ? Recalculate downstream inverts?` and the answers are Yes and No only (allow-list 119). Never-touch and read-only titles beat it (2877-2882). The `ui press` entry of the same window (allow-list 50-54) is also Yes and No only.
5. **No route to another box.** Every send checks process, class #32770 and visibility (2731-2741). Only the driver's own acad.exe is listed (2983-2985). No SendKeys, mouse or focus change appears in the new code.

## 2. LOW 4 and LOW 5: accept for pass 10, fix in the next edit

1. **LOW 4 (title checked in PowerShell, not in the native send): ACCEPT.** The exact title is re-read just before each send (3021), and with send-once only one message ever goes out. To hit the wrong window, the box would have to close and a new #32770 in the same AutoCAD would have to take the same handle within microseconds. The worst case is one Yes or No to our own test AutoCAD. Fold the title into `MsgBoxCheck` when condition 1 is coded.
2. **LOW 5 (process id read twice): ACCEPT, cheap fix later.** `Assert-UiWrite` (2983) proves that exactly one acad.exe runs and that it is ours. `Get-UiPids` (2985) reads the id again without re-proving that. For a gap, our AutoCAD would have to exit and another start within milliseconds, and that one would have to show the exact Recalculate box with Yes/No and its text. Every later send is pinned to that id (2731). Next edit: run `Test-OwnedAcad` against `$procId` and refuse on a mismatch.

## 3. slow_press watchdog

1. **The 300 s cap and the call cap are intact.** `Get-V2SlowPressSec` (4461-4472) clips to `V2SlowPressMaxSec` 300 and treats bad values as 0. The pinned allow-list holds only 120 (allow-list 22, 57). `Register-V2Call` and the cap decision run as before (4499, 4521-4523). `msgbox-answer` stays capped at 20 (2375).
2. **Yes, typed words can raise the watchdog on a press that should stay at 30 s. Timing only, LOW.** `Get-V2SlowPressForArgs` (4475-4485) matches when the typed window words are any substring of an entry title. So `ui press e Apply` or `ui press Pre Apply` gets 120 s, even if the window that `ui press` really finds is another window with an Apply button. Only the time limit grows. What is pressed is still decided by the normal allow-list. This is not a new kind of risk: `-TimeoutSec` (line 42) has no upper limit and already sets any verb's watchdog to TimeoutSec + 15 (4455-4457), so the 300 s cap binds slow_press only. **Later:** require the typed words to name one slow_press window uniquely (or at least 4 characters), and clamp `-TimeoutSec` to 300 for V2 verbs.

## 4. Settings guard after a HARD TIMEOUT

1. **AutoCAD still running under the same lock: deferred, correctly.** `Get-V2RecoveryDecision` (3645-3657) defers only when both of these hold:
   1. The lock is held by the same who/since as the manifest.
   2. Exactly one acad.exe runs and it is ours (`Invoke-V2StartupRecovery`, 3780).

   A second acad.exe (Tim's own) breaks the "exactly one" test, so the settings are restored at once (fail-safe).
2. **AutoCAD gone: restored at the next call.** `$running` is false, so `Invoke-V2SettingsRestoreAll` (3697) runs with no AutoCAD. Each file is written back from a backup whose hash is checked first. The file is re-hashed against the original, and only then is the backup deleted and the mark removed (3754-3758).
3. **Lock expired or taken over: restored at the next call.** `sameLock` is false. If the test AutoCAD still runs, the file is restored but the backup is kept (`restored_while_running`). A later `quit` re-hashes it and, if AutoCAD rewrote it while closing, copies the changed file aside and restores (3667).
4. **`quit` restores and verifies.** It restores after AutoCAD has ended (4307), then prints the four real settings hashes against the start (`Invoke-V2PassEnd`, 4308). The `finally` restores again (4540). If quit itself times out after clearing `state.launched` (4296), the lock's `acad_pid` still marks AutoCAD as ours, so the next `quit -Kill` does the restore.
5. **Remaining ways a real file stays changed (none silent):**
   1. **Somebody else's change.** If something other than the guard changed the file during the deferral (for example CE in the test AutoCAD saving a preference into the same file), the restore reports CONFLICT. Both copies are kept, the failure is loud and `launch` is refused (3669, 3789-3792). This is by design; `settings-restore -Force` resolves it after the changed file is copied aside.
   2. **No later call.** See condition 3.

## 5. Real drawings, real settings, the Settings window, -Force

1. **No new path found.** `msgbox-answer` has no `-Force` branch and requires the lock, the owned AutoCAD and a test-copy drawing (2983).
2. **The Settings window is unchanged.** It is still gated by `Assert-V2SettingsGate` (2519-2529, must be armed). The gate is also called by msgbox-answer.
3. **`-Force` uses are unchanged.** They are reopen-copy discard (4047), settings-restore conflict (3668) and lock release; none was added in this pass.
4. **"AutoCAD Message" is still not in `message_boxes`.** Adding it needs condition 1 coded first, plus the conditions in section 4 of the earlier review.

## Four words

**Built:** yes (120EE24D15B2 / 5B542F2145F4). **Tested:** by the builder (377 offline, one live stage); not re-run by me. **Installed:** not applicable. **Accepted:** Opus-reviewed GO-WITH-CONDITIONS here; not Codex-accepted, not Tim-accepted.
