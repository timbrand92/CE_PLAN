# Robot case drafts, set 10: Manager window and start-up lines (Mon 2 Nov 2026, read-only drafter, Sonnet)

**What this is.** Robot case drafts for six fix PRs on the Civil/Manager line `origin/claude/rel-20261102a`. Nothing was run, built, installed or opened in AutoCAD. No case file was created in the cases folder; this is the only file written. No git write (only `git fetch`, `gh pr view`, `gh pr diff`, all read-only).

**Sources read:** `C:\TimOS\RULES.md`; `README_CASES.md`; `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` and `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` (the style); cases R30, R06 and `variants\R09s_new_switch_off_broken`; the PR text and diff of #1935, #1936, #1876, #1877, #1878 and #1896; the carpark entries for BUG-1112, BUG-1172, BUG-1218, BUG-1220, BUG-1244 and BUG-1247; the Manager source on `origin/claude/rel-20261102a` (command names, window titles, the switch file path); the robot's settings allow-list code. The BUGFIX report for B-063 was found by name but not read in full: the PR text and diff were enough.

---

## FOR TIM

1. **Done.** Two robot tests written on paper, each with a deliberately wrong copy that must fail: W1936 (Refresh prints its one plain line) and W1876 (Updates and Rollback opens the drafter's own screen).
2. **Four fixes are Codex-only**, because the robot cannot reach what they change: #1935 (the Net8 label), #1877 (WSUD export), #1878 (support zip) and #1896 (Help pages). Exact steps for each are in section 4.
3. **The robot cannot prove #1935 at all, whoever looks.** The robot's AutoCAD is 2027, and 2027 reads "Modern" before and after the fix. Only a PC with AutoCAD 2025 or 2026 can show "Net8".
4. **Needs an Opus review before it is run:** W1936. Refresh also sends any waiting reports to the office folder, so a robot run would send real waiting reports. It does not touch Undo, REDO, a locked layer or an Xref.
5. **Neither case has a "switch off" twin.** The Manager switches live in `%APPDATA%\CE_SUITE\manager-switches.json`, and the robot's settings guard only accepts `CD_Settings.json`, `CS_Settings.json` and `settings.json`. The twins are wrong-on-purpose twins instead: they prove the check can fail, not that the old build fails.
6. **W1876 may pass on the old build too** if the robot's Windows account is not a CE administrator. The fix only changes what an administrator sees.
7. **Not proven:** every window word and printed line marked DERIVED came from the PR text or the source, not from a run. Nothing here is a FIXED claim.

---

## 1. How the drafts were written

1. **Format.** README_CASES.md format. Every `type` chain is one complete command with no `(` and no SAVE-type word. Both twins carry `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`.
2. **Case ids and order.** W1936 (790), W1936_BROKEN (791), W1876 (792), W1876_BROKEN (793). Fixture DRV1_B1, SLOT fresh. `REVIEWED_AGAINST` is empty in all four.
3. **Both are PART claims.** Each PLAN_ITEM line says which part.
4. **Checked again for an existing case.** The cases folder (including all `drafts_*` folders and `variants`), the ledger and every `ROBOT_CASE_DRAFTS_*.md` hold no case for these six PRs. The only text hits were old mentions of the bug numbers inside other cases' notes. N62 mentions one number in a comment only.
5. **Validate first, without AutoCAD:** copy each block to its file name in a new folder (suggested `cases\drafts_set10_02nov\`), then `pwsh -NoProfile -File case_runner.ps1 validate <folder>`.
6. **Build pending.** Neither #1936 nor #1876 is merged yet (both OPEN). The cases cannot pass until a Manager build with them is installed.

---

## 2. The case texts

### Case 1 of 2: W1936, Refresh prints one plain line (PR #1936, B-116, BUG-1244)

**Intended file:** `W1936_manager_refresh_prints_result_line.case.txt`

```
# W1936 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). Fix PR #1936 (B-116, BUG-1244). Manager switch refreshPrintsResultLine, ON by default, in %APPDATA%\CE_SUITE\manager-switches.json.
# Route: type CEMANAGERREFRESH alone. Before the fix it printed only 'Command: CEMANAGERREFRESH'. After it prints one more line (DERIVED from CeManagerRefreshSummary.Line in the PR diff): '[CEMANAGER] Refreshed: the CE ribbon was rebuilt; <window part>; <reports part>.'
# DERIVED, never seen on a run: the exact words; that no Manager window is open at the start of a fresh session (so the window part reads 'the Manager window is not open, so nothing to update there'); that history reads a line written by the Manager through the AutoCAD editor.
# The reports part depends on this PC: 'no reports were waiting to send', 'N reports were sent to the office folder' or 'the office folder could not be reached...'. The case only checks the fixed front of the line, and records the rest.
# No switch-off twin is possible: manager-switches.json is not on the settings guard list. The twin is a wrong-claim twin.
# SAFETY FOR THE DESK: Refresh sends any waiting reports to the office folder (TryUploadOutbox). Opus review before this is run.
CASE W1936
TITLE CE Tools Refresh (CEMANAGERREFRESH) prints one plain line starting [CEMANAGER] Refreshed, once, and changes nothing in the drawing
PLAN_ITEM PR #1936 (BUG-1244) PART: the command-line line, wording front and window part. NOT whole: the report-count half (how many were sent) depends on what is waiting on the PC and is only recorded; the switch-OFF behaviour (silent as before) is not driven
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 790
TIMEOUT 300
BUG BUG-1244
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED CEMANAGERREFRESH ends by itself (no prompt left waiting) and the command line holds exactly one line '[CEMANAGER] Refreshed: the CE ribbon was rebuilt; the Manager window is not open, so nothing to update there; <one of the three report endings>.'; the drawing file on disk is unchanged; no CE window is left open.
WHY_NOT_UNIT_TEST The unit tests check the sentence builder only; whether the real command prints it to AutoCAD's command line after a real ribbon rebuild needs the live session.
NOT_AUTOMATED The report-count wording is recorded, not judged. The switch-OFF path is not driven (no guard for manager-switches.json). The ribbon itself being rebuilt is a Codex look.
STEPS
  copy-info -> $copy0
  windows-snapshot -> $win0
  type "CEMANAGERREFRESH" -Force -TimeoutSec 120 -> $t
  sleep 5
  esc-prompt -> $e
  wait
  windows-snapshot -> $win_end
ASSERT
  history has "[CEMANAGER] Refreshed: the CE ribbon was rebuilt;"
  history has "the Manager window is not open, so nothing to update there;"
  history count "[CEMANAGER] Refreshed:" = 1
  copy-unchanged $copy0
  not-contains $win_end "CE Suite Manager"
  record $t "FULL what CEMANAGERREFRESH printed"
  record $e "last command-line lines after Esc"
  record $win0 "windows before"
```

**Twin:** `W1936_BROKEN_manager_refresh_wrong_window_claim.case.txt`

```
# W1936_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Wrong-claim twin: same route, but it claims the Manager window was updated although none was open. 'history has "the Manager window was updated"' MUST fail. It proves the window-part check can go red; it does NOT prove the old build fails (no switch-off route exists).
CASE W1936_BROKEN
TITLE BROKEN VARIANT of W1936: expects 'the Manager window was updated' when no Manager window is open (must FAIL)
PLAN_ITEM red-before-green proof (wrong-claim style) for W1936 (BUG-1244)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 791
TIMEOUT 300
BUG BUG-1244
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1936
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the line says 'the Manager window is not open', so the check for 'the Manager window was updated' fails; the front of the line check still passes.
WHY_NOT_UNIT_TEST It exists only to prove W1936's window check can go red.
STEPS
  type "CEMANAGERREFRESH" -Force -TimeoutSec 120 -> $t
  sleep 5
  esc-prompt -> $e
  wait
ASSERT
  history has "[CEMANAGER] Refreshed: the CE ribbon was rebuilt;"
  history has "the Manager window was updated;"
  record $t "FULL what CEMANAGERREFRESH printed"
```

---

### Case 2 of 2: W1876, Updates and Rollback opens the drafter's own Updates screen (PR #1876, B-058, BUG-1247)

**Intended file:** `W1876_updates_button_opens_own_screen.case.txt`

```
# W1876 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). Fix PR #1876 (B-058, BUG-1247). Manager switch updatesButtonOpensOwnScreen, ON by default, in manager-switches.json.
# Route: type CEMANAGERUPDATES (the command behind the CE Tools 'Updates & Rollback' button; source line 95 of PluginManagerCommands.cs). Old build, CE administrator: opens the window titled 'CE Suite Manager | Admin Dashboard' (PluginAdminWindow.xaml line 4). New build: opens the window titled 'CE Suite Manager' (PluginManagerWindow.xaml line 5) on its Updates tab.
# DERIVED, never seen on a run: both window titles (read from the .xaml source, not a run); that ui-dump can pick the title with ^CE Suite Manager$; that the word 'Updates' appears in the window dump; that this Windows account is a CE administrator (if it is not, the old build ALSO opens the own screen and this case cannot tell old from new).
# The case presses NOTHING inside the window: the Updates screen holds Install and Rollback buttons, and the robot never presses those. close-windows only closes by the window's own Close.
# No switch-off twin is possible (manager-switches.json is not on the guard list). The twin is a wrong-claim twin.
CASE W1876
TITLE CEMANAGERUPDATES opens the Manager window titled CE Suite Manager and not the Admin Dashboard window; nothing is pressed
PLAN_ITEM PR #1876 (BUG-1247) PART: which window opens (title only). NOT whole: that it lands on the Updates tab, the list contents, and the fact the screen still has no go-back step (decision 98) need a Codex look
KIND look
RIGHT_LOOKS_LIKE The window is titled CE Suite Manager (no Admin Dashboard in the title) and shows the Updates tab with the installed and available versions; nothing is cut off at the right or bottom edge.
RIGHT_LOOKS_LIKE No Approve, Canary or Promote to All button is visible anywhere in the window.
FIXTURE DRV1_B1
SLOT fresh
ORDER 792
TIMEOUT 400
BUG BUG-1247
PROVES_BUGS
REVIEWED_AGAINST
EXPECTED The command opens one window titled CE Suite Manager showing its Updates tab; no window with Admin Dashboard in its title opens; closing leaves the drawing file unchanged and no CE window open.
WHY_NOT_UNIT_TEST The unit test compares the condition line in the source; which window AutoCAD really opens, for this Windows account, needs the live session.
NOT_AUTOMATED The Updates tab being the one selected, the table contents, and every button (never pressed). Whether this robot account is a CE administrator (so that the old build would differ) is recorded, not known.
STEPS
  copy-info -> $copy0
  windows-snapshot -> $w0
  type "CEMANAGERUPDATES" -Force -TimeoutSec 120 -> $t
  sleep 5
  windows-snapshot -> $w
  ui-dump "^CE Suite Manager$" -Optional -TimeoutSec 30 -> $d
  ui-dump "Admin Dashboard" -Optional -TimeoutSec 5 -> $ad
  capture $d W1876_updates_window -> $pic
  close-windows -> $closed
  esc-prompt -> $e
  wait
  windows-snapshot -> $win_end
ASSERT
  contains $w "CE Suite Manager"
  not-contains $w "Admin Dashboard"
  control-text $d has "Updates"
  picture-ok $pic
  copy-unchanged $copy0
  not-contains $win_end "CE Suite Manager"
  record $t "FULL what CEMANAGERUPDATES printed"
  record $w "windows while the command's window was open"
  record $ad "what the Admin Dashboard look-up found (expected: nothing)"
  record $closed "FULL what close-windows did"
```

**Twin:** `W1876_BROKEN_updates_wrong_window_claim.case.txt`

```
# W1876_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Wrong-claim twin: the same route, but it claims the Admin Dashboard window opened. 'contains $w "Admin Dashboard"' MUST fail on the new build. It proves the title check can go red. On the OLD build, with an administrator account, it would PASS, so a pass here means 'this PC shows the old behaviour', which is itself worth knowing.
CASE W1876_BROKEN
TITLE BROKEN VARIANT of W1876: expects the Admin Dashboard window to open (must FAIL on the fixed build)
PLAN_ITEM red-before-green proof (wrong-claim style) for W1876 (BUG-1247)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
ORDER 793
TIMEOUT 400
BUG BUG-1247
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1876
REVIEWED_AGAINST
EXPECTED Wrong on purpose: the new build opens CE Suite Manager, so the Admin Dashboard check fails.
WHY_NOT_UNIT_TEST It exists only to prove W1876's title check can go red.
STEPS
  type "CEMANAGERUPDATES" -Force -TimeoutSec 120 -> $t
  sleep 5
  windows-snapshot -> $w
  close-windows -> $closed
  wait
ASSERT
  contains $w "CE Suite Manager"
  contains $w "Admin Dashboard"
  record $w "windows while the command's window was open"
```

---

## 3. What was read, built and tested

1. **Read:** the files listed at the top. **Built:** nothing. **Tested:** nothing. No AutoCAD was opened and the robot was not run.
2. **NOT proven:** that either case runs at all, that any DERIVED wording is right, that this PC's account is a CE administrator, and that either fix works in AutoCAD.
3. **Marked DERIVED:** the whole Refresh line; both window titles; the word "Updates" in the window dump; that the Manager window is closed in a fresh session.

---

## 4. Codex look notes (the four Codex-only fixes)

Each look is read-only for Tim's real settings and key files: **open none of them, list none of them.** Evidence goes under `C:\CE_WORK\codex\<note id>\`. Never capture or accept a folder or file box that the check opened.

### Look K10_01: #1935 (BUG-1172), start-up line says Net8 on AutoCAD 2025/2026

**Why not the robot:** the robot's AutoCAD is 2027, which reads "Modern" with the fix and without it. Needs a PC with AutoCAD 2025 or 2026 and the new Manager installed.

1. **Start** AutoCAD 2026 (or 2025). Watch the command line as it loads.
2. **Right looks like:** the line `[CE_SUITE_MANAGER] v<version> [Net8] loaded.` (DERIVED from the PR diff). It must not say `[Modern]`.
3. **Second place:** the Manager window's title bar or status pane reads `CE MANAGER v<version> [Net8] <date>` (DERIVED).
4. **Also check AutoCAD 2027** (if available) still reads `[Modern]`, and AutoCAD 2022 to 2024 still reads `[Legacy]`.
5. **Do not edit `manager-switches.json`** to test OFF: the unit tests cover it.
6. **Evidence:** a picture of the command line and one of the title bar, in `C:\CE_WORK\codex\K10_01\`.

### Look K10_02: #1877 (BUG-1112), CDCALC WSUD export says "not entered"

**Why not the robot:** it is an Export (a file is written) and the page's boxes are read-only (carpark note, Opus pre-review N).

1. **Open** a drawing with a calculation, type `CDCALC`, tick **WSUD / annual load reduction**, and press the package button that writes the computations package to a folder Codex chose under `C:\CE_WORK\codex\K10_02\` (never accept a folder the box opened in).
2. **Right looks like:** in the package, "Total site area" and both "Impervious area" cells read `not entered`, and the Annual Runoff Volumes lines read `not entered`; no `1000`, `200` or `700 m2` appears.
3. **Wrong looks like:** the package prints a 1000 m2 site with 200 / 700 m2 impervious.
4. **Known limits, not faults:** the 630 mm rainfall and the two C figures still print (BUG-1112 reading); a saved calculation that holds exactly 1000 / 200 / 700 also reads `not entered`.
5. **Evidence:** the package file and one picture of the WSUD tab, in `C:\CE_WORK\codex\K10_02\`.

### Look K10_03: #1878 (B-063), CESUPPORT zip never takes a key or local settings file by name

**Why not the robot:** it needs files created in folders the zip walks and the zip opened afterwards; the robot has neither step. Made-up files only.

1. **Create three made-up text files, each holding only the words MADE-UP NOT A KEY:** `blob-config.local.json`, `zz-test.local.json` and `CE_SUITE\note.txt`, all inside the Desktop folder `CE Diagnostics` (one of the folders the zip walks). Note the exact names so the same three can be deleted afterwards, and delete nothing else.
2. **In AutoCAD type `CESUPPORT`.** Note the zip path on the command line.
3. **Open the zip's file list only** (do not extract it, do not open any real file inside it).
4. **Right looks like:** none of the three made-up files is in the list. The report text inside the zip lists them under "Found but left out" as `<entry>: key or local settings file, never included` (DERIVED from the PR text).
5. **Also right:** a `CE Diagnostics\CE_SUITE_MANAGER\trace.log`, if present, is still in the zip (a different folder name).
6. **Afterwards** delete the three made-up files by exact name. **Evidence:** the zip's file list picture and the "left out" lines, in `C:\CE_WORK\codex\K10_03\`.

### Look K10_04: #1896 (BUG-1218, BUG-1220), Help pages

**Why not the robot:** window-only. The Help page text is not readable by the robot's window reader, and searching needs typed input into the Help window.

1. **Type `CDHELP`**, search `CDREVERSEFLOW`.
2. **Right looks like:** the card does not promise a preview window or an Apply button. It says the command prints a short explanation and asks Yes or No, and that Enter means No.
3. **Search `CDLABELSTYLE`**, then **`CDMA`**.
4. **Right looks like:** one card each, titled Label Styles and Move Arrow.
5. **Evidence:** three pictures, in `C:\CE_WORK\codex\K10_04\`.

---

## 5. Fixes skipped (no robot case) and why

1. **#1935 (BUG-1172):** robot AutoCAD is 2027, which reads "Modern" before and after the fix. Look K10_01.
2. **#1877 (BUG-1112):** an Export, with read-only boxes. BLOCKED-FOR-ROBOT. Look K10_02.
3. **#1878 (B-063):** needs files made in the zip's folders and the zip opened. BLOCKED-FOR-ROBOT. Look K10_03.
4. **#1896 (BUG-1218, BUG-1220):** window-only Help text. BLOCKED-FOR-ROBOT. Look K10_04.
5. **Not skipped:** #1936 and #1876 are drafted above.
