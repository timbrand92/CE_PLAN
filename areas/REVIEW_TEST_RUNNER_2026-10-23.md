# Review: the new AutoCAD test runner (driver v3 phase 1 and the testing spec), 23 Oct 2026

Written Fri 23 Oct 2026, about 00:00 to 00:30 Melbourne time, by an independent Opus review job. **Read-only review:** I did
not start AutoCAD or Codex and did not run the driver. A Claude job was using AutoCAD under the lock while I worked (lock
holder `Claude-driverv3` since 00:00:05, one acad.exe running), so I only read files.

Read: `TESTING_REBUILD_SPEC_2026-10-22.md`, `TESTING_RESEARCH_CODEX_2026-10-22.md`, `acad_driver_v3.ps1` (911 lines),
`acad_driver_v3_session.ps1` (273 lines), `acad_driver_v3.allowlist.json`, `README_V3.md`, `v3_selftest.ps1`,
`v3_selftest_item3.ps1`, `v3_cases\throwaway.case.txt`; in `acad_driver_witness_v2.ps1` the lock (lines 1351 to 1507), the
settings guard (3515 to 3944), `type` (4133 to 4171), `launch` (4172 on) and `quit` (4267 to 4315). Evidence on disk: 22
self-test folders and 4 session reports in `_TEST_COPIES_20260923\pack_runs`, the ui dumps, and `transcripts\v3_audit.jsonl`.
**The phase 1 report `release-v3-colleagues-DRIVER_V3_PHASE1_REPORT.md` does not exist yet**, so this reviews the code and the
self-test evidence on disk only.

---

## ANSWER FIRST

**Verdict: GO WITH FIXES.** The base is sound: it reuses driver v2 for the lock, the settings guard, start and quit; it works
out clicks from the drawing area's own rectangle (no guessed title-bar or ribbon offsets); it closed AutoCAD cleanly in every
recorded session; and it measured clicks within 1.2 pixels of the target. Phase 2 (the case parser and the reports) can be
built on it now. **No unattended or overnight run until fixes 1 to 3 below are in and re-reviewed.**

**The three worst problems, in plain words:**

1. **The clean-up can act on an AutoCAD that is not the test one.** If the runner gives up before it starts its own AutoCAD
   (Tim's hours, or it waited an hour for an AutoCAD that stayed open), its "always clean up" step still runs against
   whatever AutoCAD is open. It puts snap and pick settings into that AutoCAD and asks it to quit three times, the last time
   with "kill". Driver v2 refuses when a real drawing is open. But **if Tim's AutoCAD is sitting on the Start tab with no
   drawing open, v2 closes it, and on the third try kills it.** Example: Tim leaves AutoCAD open on the Start tab overnight.
   The 01:00 pack waits 60 minutes, gives up at 02:00, and closes his AutoCAD.
2. **A frozen AutoCAD can freeze the clean-up, and a crashed runner leaves everything held.** The end step talks to AutoCAD
   directly before it quits it, with no time limit. A frozen AutoCAD (run 47) can stop it there: AutoCAD stays open, the lock
   stays held for up to 90 minutes, and the settings stay changed. The lock also does not record the runner's process, so
   nothing notices when the runner itself dies.
3. **A click that misses is not caught, and the aim check is too weak.** The calibration measured one point, about 130 pixels
   from the centre of a small drawing area (1604 x 569 pixels on a 1920 x 1080 monitor). It never measured the 5120 x 1440
   screen the spec names. An error that grows towards the edges would pass. Earlier self-test runs missed by 118 to 180
   pixels and the click went ahead without complaint. Last night's double-click on the angled "DP" text hit empty space, and
   the self-test still logged it as "no window opened". That is a false fact headed into the BUG-859 decision.

**The acceptance proposal (spec section 4) has one real gap.** Two passing sessions prove the test gives the same answer
twice. They do not prove the answer is right, because both passes use the same test file and the same expected values,
written by the same AI. Fix: before a case's first acceptance, someone else (an Opus or Codex review) checks it against the
card or bug entry. For a bug, the case must also have FAILED on a build before the fix.

**What I did NOT test:** nothing was run. All behaviour claims come from reading the code and the reports already on disk.
Where I could not prove something by reading, I say so.

---

## Findings

Severity: **HIGH** = can touch something that is not a test copy, or can give a false PASS or false data. **MEDIUM** = will
cause BLOCKED or FAIL noise, or a broken rule, in the first week. **LOW** = tidy-up.

### A. Safety

1. **HIGH: clean-up runs against an AutoCAD this session never started.**
   - **Where:** `acad_driver_v3_session.ps1:204` (`if ($haveLock -or @(Get-Process -Name acad).Count -gt 0)`), then
     `Stop-V3Session` lines 109 to 119.
   - **What goes wrong:** the early exits (in-use hours at line 161; `Wait-V3Free` giving up after 3600 s at line 164)
     `return` inside the `try`, so the `finally` still runs whenever any acad.exe is open. `Stop-V3Session` then:
     - (a) walks that AutoCAD's window tree;
     - (b) runs `Restore-V3Setvars` (`acad_driver_v3.ps1:879` to 893), which has no lock or ownership check and calls
       `SetVariable` on that AutoCAD's active drawing whenever `C:\ce_rc_scratch\v3_state\v3_setvars.json` is left over (one
       exists right now, from the current job);
     - (c) calls v2 `quit` three times, the third with `-Kill`.
   - **The v2 path that makes (c) dangerous:** v2 `quit` (`acad_driver_witness_v2.ps1:4278` to 4305) checks ownership only
     when AutoCAD is busy, and checks the drawings only when one is open. With no lock held, Assert-LockOk passes. With AutoCAD
     idle on the Start tab, v2 calls `CloseMainWindow` and, given `-Kill`, `Stop-Process`, with no ownership check.
   - **What happens when Codex holds the lock:** v2 refuses the quit, but (a) and (b) still happen inside Codex's test
     AutoCAD.
   - **Fix:**
     - Run `Stop-V3Session` only when this session launched AutoCAD: record the pid and start time from the v2 `launch`
       result, and require that this exact process is still the one running and still named in our lock.
     - Make `Restore-V3Setvars` call `Assert-V3OwnedAcad` first.
     - Separately, flag the v2 quit gap to the v2 owner. v2 is frozen, so v3 must simply never call `quit` unless it owns
       the AutoCAD.

2. **HIGH: no time limit on the clean-up's own AutoCAD calls; a dead runner is not detected.**
   - **Where:**
     - `Stop-V3Session` lines 109 to 110: `Close-V3OpenWindows` (UI Automation) and `Restore-V3Setvars` (COM) run in this
       process, before any quit.
     - `Invoke-V2` (`acad_driver_v3.ps1:279`) takes `$TimeoutS` but never uses it.
     - The lock is acquired with no `-HolderPid` (line 76). The live lock file shows `"pid": 0`.
   - **What goes wrong:**
     - v2 child processes have their own hard-timeout watchdog, so they end. v3's in-process COM and UI Automation calls have
       no deadline. I have not proved on this PC that a COM call into a frozen AutoCAD blocks forever. Self-test runs show
       quick `RPC_E_CALL_REJECTED` when AutoCAD was merely busy, but a truly frozen AutoCAD is the case the end step exists
       for.
     - If the runner is killed (a job timeout, the PC asleep), no `finally` runs at all. AutoCAD stays open, our lock stays
       held for 90 minutes, and the next pack waits 60 minutes and then BLOCKS.
   - **Fix:**
     - Wrap every end-path COM and UI Automation call in a timed thread, like `CallVia`, with a 10 s budget. If AutoCAD does
       not answer, skip straight to `quit -Kill`.
     - Pass `-HolderPid $PID` on `lock acquire`, so a dead runner makes the lock stale.
     - Add a session-level deadline: a watchdog thread that, past the case's TIMEOUT plus the end budget, writes v2's
       abandoned mark and kills only the owned pid (pid and start time both matching).
     - Add a self-test item that proves this with a deliberately stuck case. Today only clean ends have been exercised.

3. **MEDIUM: the "clean" flag ignores the settings guard and the snap-setting restore.**
   - **Where:** `acad_driver_v3_session.ps1:147` reads `$end.guard_left`, which is never set anywhere. Lines 125 and 166
     store `settings-temp status` from `.output`, but v2 puts that answer in `data.summary`, so `guard_at_start` and
     `guard_status` are always `null` (both are null in `session_items_1_3.json` of the final run).
   - **What goes wrong:** a failed v2 restore or a failed profile-variable restore (`setvars_restored_ok = false`) can still
     report `clean = True`. Spec 1.4 item 12.1 ("the settings guard empty ... otherwise BLOCKED") is not implemented. The
     check that exists (`hash_unexpected_at_start`) is recorded and then ignored.
   - **Fix:**
     - Read `data.summary.entries` and `data.summary.unresolved`.
     - BLOCK at start if the guard holds entries.
     - Include `settings_restore_ok`, `setvars_restored_ok` and the guard summary in `clean`.

4. **MEDIUM: the end step decides "AutoCAD has gone" by counting every acad.exe.**
   - **Where:** `Stop-V3Session` lines 122, 126 and 137.
   - **What goes wrong:** if Tim opens his own AutoCAD during a free-window run, `acad_left` stays at 1 or more. The settings
     are then never restored, the lock is never released and the copies are never removed, even after the test AutoCAD has
     gone. Worse, Tim's AutoCAD read the TEST settings when it started (CE reads them only at start).
   - **Fix:**
     - Test for the owned pid, not the count.
     - Shrink the exposure: call v2 `settings-restore` straight after the ready check. CE has read its settings by then.
       v2 already handles a restore while AutoCAD runs (`restored_while_running`) and restores again after quit.
     - Prove with one case that CE does not re-read the file later. The Settings window (CDS) does read it, which is fine.

5. **MEDIUM: a case file can call any v2 verb.**
   - **Where:** `acad_driver_v3_session.ps1:253` (`v2 <anything>`).
   - **What goes wrong:** a case can run `v2 lock release`, `v2 settings-restore -Force`, `v2 quit -Kill` or `v2 launch`
     mid-session, or nest `session-run`.
   - **Fix:** give cases an allow-list of v2 verbs: `type`, `esc-prompt`, `msgbox-answer`, `pick-first`, `save-copy`,
     `reopen-copy`, `history`, `getvar`, `wait`, `shot`, `dismiss-modal`. Refuse `session-run` inside a case.

6. **MEDIUM: `ui-dump -Out` can overwrite a master drawing.**
   - **Where:** `acad_driver_v3.ps1:514` to 516.
   - **What goes wrong:** `Test-V3TestPath` allows anything under `C:\ce_rc_` and `C:\Lisp Files\_TEST_COPIES`, including
     `C:\ce_rc_drv\DRV1_B1.dwg`.
   - **Fix:** `-Out` must sit under the run folder or `C:\ce_rc_scratch` and end in `.json`.

7. **LOW: the case parser's SAVE filter misses the underscore forms.**
   - **Where:** `acad_driver_v3_session.ps1:233`. `\bSAVE\b` does not match `_SAVE`, `_QSAVE` or `_WBLOCK`, because `_` is a
     word character.
   - **Why it is only LOW:** v2's own deny list tokenises from the first letter (`acad_driver_witness_v2.ps1:223`), so a typed
     `_SAVE` is still refused by v2.
   - **Fix:** use the same tokeniser as v2.

8. **Checked and found sound:**
   - **Settings files:** v3 never writes Tim's four settings files. Only v2's guard does, and only before launch, because v2
     `settings-temp set` refuses while any AutoCAD it did not start is running.
   - **Bundles:** no v3 file touches `ApplicationPlugins` or any installed bundle.
   - **Deletions:** only the session's own `CLD*` copies and their `.dwl`, `.dwl2`, `.bak` and `_PRE_*` files, and only after
     a name check.
   - **Pins:** the v2 and allow-list pins are checked at the start of every verb (`Assert-V3Pins`).

### B. Where the mouse lands (world point to screen pixel)

9. **The formula, derived independently.**
   - **Setting:** plan view of the world, no twist, one tiled Model viewport, and the drawing area's client rectangle
     (left L, top T, width W, height H) in physical pixels.
   - **Scale:** s = H / VIEWSIZE pixels per drawing unit.
   - **Point:** X = L + W/2 + (x - VIEWCTR.x) * s and Y = T + H/2 - (y - VIEWCTR.y) * s.
   - **Pixel:** the pixel whose centre is nearest is floor(X), floor(Y) when pixel i covers i to i+1.
   - **Match with the code:** `ConvertTo-V3Pixel` (line 624) is the same formula, except that it rounds rather than floors,
     so it depends on AutoCAD's own half-pixel convention. AutoCAD's convention is closed, so it must be measured.
   - **The measurement already shows it:** every self-test run has a steady **+0.83 px east and +0.9 px north** at three zoom
     levels and two canvas widths. That is a convention offset, not noise. Measure it once and subtract it, which leaves
     about 0.3 px.

10. **HIGH (bundled into worst problem 3): the calibration cannot see an error that grows towards the edges.**
    - **Where:** `v3_selftest.ps1:119` measures one point, 0.2 x VIEWSIZE east and 0.1 x VIEWSIZE south of centre. That is
      about 114 and 57 pixels on a 569-pixel-high area. Spec C02 also adds "the cursor read-back agrees within 2 pixels",
      which only proves Windows moved the cursor, not that AutoCAD read the right world point.
    - **What goes wrong:** a wrong window picked by the "same shape" fallback, a DPI ratio, or a viewport border would scale
      the error with distance from the centre. At 114 px a 0.5 percent scale error is 0.6 px, so it passes. At the edge of a
      1604 px area it is 4 px. On a wide area it is more.
    - **Fix:**
      - Keep the `_.ID` plus LASTPOINT method (it is the right one).
      - Measure 9 points: the centre, the four edge midpoints and four corners at 45 percent of W and H.
      - Fit offset and scale, and fail if the scale differs from 1 by more than 0.1 percent or any residual is over 1 px.
      - Update spec C02 to this method and drop the cursor read-back as evidence.

11. **HIGH (bundled into worst problem 3): a stale stored view gives a silent miss.**
    - **Where:** `Invoke-V3Pointer` with `-UseStoredView` (lines 725 to 732) accepts a stored view up to 300 s old.
    - **Evidence:** self-test runs 22:17 to 22:23 recorded misses of 118 to 180 px (for example "asked 2000,500, AutoCAD
      LASTPOINT 2508.7,1404.2"). The pointer verb clicked anyway. Only the self-test's own LASTPOINT check noticed.
    - **Fix:**
      - Store the view immediately before the command that will wait for a point. Cap the age at 15 s.
      - After any click at a point prompt, read LASTPOINT and fail the step if it is more than 2 px from the target.
      - Before a `pt-dblclick` on an object, do a `pt-click`, then `pick-read` must hold the target handle, then `deselect`
        (an "aim check"). Only then double-click.

12. **HIGH (data quality): the angled-text target is a guess, and a miss is logged as a result.**
    - **Where:** `acad_driver_v3.ps1:691` (`attrmid:`) guesses the text centre as 0.7 x height x letters. The
      `GetBoundingBox` call at line 668 throws its result away, because out-parameters do not come back through
      `InvokeMember` that way.
    - **Evidence:** `v3_selftest_final_run1\item3_windows.txt`: the double-click on "DP1 angled DP text" started a selection
      window ("Specify opposite corner ... *Cancel*"), meaning it hit empty space. `v3_selftest_item3.ps1:37` still marks it
      ok as "no window".
    - **Fix:**
      - Read the attribute's real bounding box. The centre of the box around a rotated text is the centre of the text.
      - Add the aim check from finding 11.
      - Make ITEM 3 FAIL on a miss.
      - **Do not use the 22 Oct item 3 line for the DP text in any BUG-859 decision.**

13. **MEDIUM: the "same shape" fallback can pick the wrong window.**
    - **Where:** `Find-V3Canvas` lines 614 to 621. It accepts any visible child within 0.01 of the drawing area's
      width-to-height ratio and keeps the LARGEST.
    - **What goes wrong:** a parent frame a few pixels bigger than the drawing area also passes, and it would win. The point
      check (`ClassifyPoint`) cannot catch this, because the real drawing area is a child of the wrong one.
    - **Fix:** in the fallback, choose the smallest match that contains no other match, and require the ratio H / SCREENSIZE.h
      to equal the monitor's DPI / 96 to within 0.5 percent. This path has never run: every recorded canvas was an exact match
      at 96 dpi.

14. **MEDIUM: the test screen is not the screen the spec names, and it changes between runs.**
    - **Evidence:**
      - The live `ui-windows` line shows the AutoCAD frame at `1920,-4` and `1920 x 1080`, so AutoCAD is maximised on a
        second, 1920 x 1080 monitor at 96 dpi.
      - The drawing area was 1604 x 569 in some runs and 1330 x 569 in others. A docked palette ("Workspace", 1608 x 573) was
        open in some.
      - AutoCAD is started through Explorer with Tim's own profile, so the window, monitor and docked palettes come from his
        last session. Tests that open CE palettes leave them docked for the next session, and for Tim.
    - **Fix:**
      - Record the frame rectangle, the monitor, its DPI and the drawing-area size in every report header (spec 2.3.2 asks
        for this; it is not in phase 1).
      - Refuse a session whose drawing area is under 1200 x 500.
      - At session end, close the CE palettes a case opened.
      - A dedicated test profile is the clean answer, but it is a v2 `launch` change and needs its own review.

15. **MEDIUM: things inside the drawing area that are not the drawing.**
    - **What goes wrong:** the ViewCube, the navigation bar, the viewport label ("[-][Top][2D Wireframe]") and the UCS icon may
      be drawn inside the same window. If so, `ClassifyPoint` cannot tell them apart from the drawing (not verified). A world
      point that lands under the ViewCube would rotate the view.
    - **Other things that will swallow clicks in week one:**
      - **Quick Properties (QPMODE)** pops up a floating panel after a selection. The point check then refuses the next click
        as "other window", giving BLOCKED.
      - **Selection cycling (SELECTIONCYCLING)** opens a pick list where objects overlap, which is the downpipe: circle,
        hatch and attribute.
      - **PICKAUTO and PICKDRAG** change what a click on empty space does.
      - **SNAPMODE** (a drawing variable) would snap the LASTPOINT calibration.
    - **Fix:**
      - Refuse targets within 40 px of the drawing area's edges and in the top-right 160 x 160 px.
      - Add QPMODE, SELECTIONCYCLING, PICKAUTO, PICKDRAG, NAVVCUBEDISPLAY and NAVBARDISPLAY to the `profile` list, and
        SNAPMODE to the `drawing` list. Set and record them for every pointer session.

16. **LOW: DPI awareness is recorded but not enforced.**
    - **Where:** `acad_driver_v3.ps1:254` and 712.
    - **Fix:** re-read the thread's awareness inside every pointer verb and refuse unless it is 2.

17. **LOW: block geometry ignores the block's base point.**
    - **Where:** `Get-V3BlockParts` (lines 634 to 656) maps definition points without subtracting the block's `Origin`.
    - **What goes wrong:** any CE block whose base point is not 0,0 gets wrong targets. The aim check (finding 11) would catch
      it.

### C. Mouse, keys and focus

18. **Sound as built:**
    - **Mouse events:** the SendInput structure is 40 bytes (checked by the self-test).
    - **Double-click:** two down/up pairs about 135 ms apart on the same pixel, inside the 500 ms double-click time, so
      distance does not matter. Proven: the double-click opened the Enhanced Attribute Editor.
    - **Safety before every click:**
      - AutoCAD must be the front window before and after the cursor moves.
      - The window under the pixel must be the drawing area.
      - The cursor goes back afterwards in a `finally`.
    - **Keys:** v3 sends no typed text at all, only one Esc (`keybd_event`). Commands go through v2's COM `SendCommand`, which
      lands on the command line whatever has the focus. **So the PASTECLIP fault cannot happen through v3.**
    - **Keep it that way:** the coming `ui-set` must use the window's own value setting (ValuePattern.SetValue), never
      keystrokes.

19. **MEDIUM: a locked screen at 01:00.**
    - **What goes wrong:** on a locked or disconnected session, SendInput and SetForegroundWindow do not reach AutoCAD. Every
      pointer case would come back "would not come to the front", and the nightly pack (spec 6.4) would give 20 BLOCKED
      lines with no clear cause.
    - **Fix:** at session start, check whether the input desktop is the locked screen (LogonUI running, or OpenInputDesktop
      fails). If it is, mark the pointer cases BLOCKED "PC locked". Check the power plan does not lock the PC before 01:00.

20. **LOW: the human-at-the-PC guard has a 2.5 s blind spot.**
    - **Where:** `Assert-V3PcFree`, line 383. Input within 2.5 s of the runner's own counts as the runner's.
    - **Also:** the 2:00 to 3:00 pm window will often BLOCK pointer cases when Tim is at the desk. That is correct
      behaviour, but plan the packs for after 5:30 pm.

### D. Reading windows (UI Automation)

21. **Fixed:** UI Automation is now loaded on line 29, before any use, and the self-test proves it in a fresh process. The 20
    Oct "Unable to find type" fault cannot recur in v3.
22. **MEDIUM: the Settings window's protection never switches on.**
    - **Where:** allow-list lines 15 and 16 (`*| Settings`, `Settings*`).
    - **Evidence:** the real title is **"Creative Engineering | Settings (CDS)"** (see
      `ui_dumps\Creative_Engineering_Settings_CDS_*.json`). That matches neither pattern, so it falls to `Creative
      Engineering*`, and the `requires_settings_guard` check at `acad_driver_v3.ps1:563` never fires. The press list is still
      only Cancel and Close, so it is harmless today. It stops being harmless when `ui-set` arrives for C14.
    - **Fix:** use the pattern `*| Settings*`, and make `ui-press` and `ui-set` in a guarded window refuse unless v2's guard
      is armed.
23. **MEDIUM: speed.**
    - **What goes wrong:**
      - `Get-V3UiWindows` walks up to 1000 docked elements on every call (lines 428 to 445).
      - `ui-press` calls it in its 8-second "did the window close?" loop (line 574).
      - `ui-dump` reads about 15 cross-process properties per control with no cache.
    - **Estimate (not measured):** 2 to 20 s per call, which threatens the spec's "40 cases in under an hour".
    - **Fix:** use a UI Automation `CacheRequest` for the dump; pass `-NoDocked` in the close loop; time every verb in the
      report.
24. **LOW: one dump at 21:47 came out as a two-item title.** The title read "About CE Suite About CE Suite" with 0 controls,
    and the file was named `System.Object[]`. It did not happen again, and the cause is not known. Guard that a window title
    is a single string.
25. **Proven:** AutoCAD's own Enhanced Attribute Editor is readable (29 to 30 controls, including OK and Cancel), which
    retires part of spec risk 6.5.1. The right-click menu is still unproven (C33).

### E. Failure modes

26. **MEDIUM: COM refusals make the self-test flaky.**
    - **Where:** `Get-ComV` and `Invoke-ComV` (lines 333 to 334) retry 3 or 4 times over about 0.6 s.
    - **Evidence:** 8 of the 22 self-test runs failed on `RPC_E_CALL_REJECTED` (AutoCAD busy, not broken).
    - **Fix:** wait for idle first (`Wait-V3Idle`), then retry for up to 10 s with backoff. Report a rejection that lasts past
      that as BLOCKED "AutoCAD busy", never as FAIL.
27. **What happens in each failure situation, read from the code:**
    - **A modal dialog open at the end:** only listed windows get closed. An unlisted alert falls through to quit, then kill.
      After a kill, AutoCAD's recovery files are not cleaned up, so the next start may show the Recovery Manager with copy
      names on it (spec 6.5.8 covers only `.dwl` files).
    - **A wedged AutoCAD:** see finding 2.
    - **A second AutoCAD:** every v3 verb refuses (correct). The end step then leaves everything held (finding 4).
    - **A lock held by Codex:** v3 waits 60 minutes, then BLOCKS. The clean-up still touches Codex's AutoCAD (finding 1).
    - **A settings guard left over:** v2 recovers it at the next call when that pass is over (sound, in v2). v3 does not
      refuse to start (finding 3).
28. **MEDIUM: sessions cannot run past 60 minutes.**
    - **Where:** v3 `PassStopSec` (lines 52 and 308) and v2's own 60-minute write stop both count from the moment the lock
      was taken.
    - **What goes wrong:** a session over 60 minutes BLOCKS every later case. The 150-case overnight pack (about 2 hours) must
      take a new lock per session.
    - **Fix:** cap one session at about 45 minutes in the runner's grouping (spec 1.5).
29. **LOW:**
    - `hashes_start` is read before the up-to-60-minute wait for the lock (`acad_driver_v3_session.ps1:162`). Read it after
      the lock is taken.
    - The copy is always named `_B1`, even for the Structural fixture (line 175).
    - Copies are deleted even after a FAIL (lines 137 to 145), so the evidence drawing is lost. Phase 2 should move FAIL
      copies into the run folder instead.

### F. The test-file format (things phase 2 will trip on straight away)

30. **MEDIUM: no line breaks inside a typed command chain.** A backtick-n written in a case file reaches v2 as two characters.
    I searched v2 and found no conversion. Every chained case in spec section 5 needs this: CDTWL, CDCHECKIGNORE Unignore,
    CHPROP, CDEDIT Y. **Fix:** define one escape (for example `\n`) in the parser, or pass chains through v2 `-InputFile`.
31. **MEDIUM: the code and the spec describe different formats.**
    - **The code:** the phase 1 parser knows only `CASE`, `FIXTURE`, `SET` and `STEPS`, with no step numbers.
    - **The spec:** section 1.3 has numbered steps, `PROOF`, `PROFILE`, `TIMEOUT` and `ASSERT`. Its target syntax is
      `ent $var part=`, while the code takes `ent <handle> -Part`.
    - **Other gaps:**
      - A failed `v2` step does not stop the case (line 253), while a failed v3 step does.
      - A refusal is reported as FAIL, not BLOCKED (spec 2.2.2).
      - A `#` inside quotes is cut off as a comment.
    - **Fix:** settle one format in phase 2 and validate it with `pack validate`.

### G. The acceptance proposal (spec section 4)

32. **HIGH: two passes show the test is repeatable, not that it is right.**
    - **Why:** both sessions run the same case file with the same expected values, the same fixture and the same runner. A
      wrong expected value would pass twice, for example one copied from today's behaviour, or a check that reads the wrong
      object or the wrong log bytes. RULES 13.3's two proofs were meant to be independent; this pair is not. A runner miss
      like finding 12 would also be "accepted" twice.
    - **Fix (keeps the proposal, closes the gap):**
      - **Independent review:** a case counts towards acceptance only after an Opus or Codex review has checked it against
        the command card or bug entry it names, once. Add a `CARD` line to the format, with the reviewer's run id.
      - **Red before green:** for a bug, the case must have FAILED on an earlier build (shown in a pack report) before its
        PASS counts.
      - **Two separate starts:** the two passes must be two separate AutoCAD starts, not two copies in one session. Read the
        product version of each loaded DLL in each session.
      - **No FAIL on that build:** any FAIL or FLAKY for that case on that build, in any run, blocks acceptance.
33. **MEDIUM: looks.**
    - **What goes wrong:**
      - The "right looks like" lines Codex judges against are written by the same case author.
      - DUPLICATE detection by SHA-256 misses a picture of the wrong window (a cursor blink or a clock changes the hash).
      - Pictures taken at 96 dpi on a 1920 x 1080 monitor will not show clipping that appears at 125 or 150 percent scaling
        on a colleague's PC.
    - **Fix:**
      - Put the window's title, handle and `ui-dump` text from the same moment in each look card, and have Codex check that
        the picture matches the text.
      - Take the "right looks like" lines from the card, not the case author.
      - Record the scale factor in the card.
      - Tim should know that "Codex-accepted from a picture" is narrower than today's rule 4.5 (no driving, no exact steps
        seen). The spec already says it needs his yes.

### H. Self-test status (spec 6.1: "must PASS twice in a row")

34. **Not met on disk at 00:15.**
    - **Passed once each:** OFFLINE 21:42, ITEM1 22:12, ITEM2 23:20 (largest error 1.224 px), ITEM3 23:36, ITEM4 23:40 to
      23:44 (three clean starts and ends, each closed on the first quit).
    - **The "final" run (23:44 to 23:55)** left no `selftest.md`. A later run was still using AutoCAD when I stopped.
    - **ITEM3's single PASS includes the missed DP-text click** (finding 12).
    - **No error path has been exercised:** stuck AutoCAD, modal dialog at the end, kill, second AutoCAD.

### I. Fix order before phase 2 runs unattended

35. Findings 1, 2, 11 and 12, plus 10's 9-point calibration, then a re-review of that diff.
36. Findings 3, 4, 22, 26 and 30, during phase 2.
37. The rest when convenient. Finding 32 goes to Tim with the section 4 question, with the "independent review" and "red
    before green" conditions added to the recommended YES.

---

## Summary

Go with fixes. Driver v3 is a sound base: it reuses v2's lock, guard, start and quit, aims from the real drawing area, ended
cleanly every time and clicked within 1.2 pixels. The three worst:

1. The always-run clean-up can act on an AutoCAD it never started, and can close Tim's AutoCAD on the Start tab.
2. No time limit or crash detection around the clean-up's own AutoCAD calls.
3. Missed clicks pass silently: one-point calibration, and the DP-text miss was logged as data.

The acceptance rule needs an independent case review and "fails before the fix". Nothing was run.
