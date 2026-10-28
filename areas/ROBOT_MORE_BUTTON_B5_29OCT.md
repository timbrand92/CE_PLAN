# Robot: allow the "More..." window for D06 (hide grade), and draft batch 5

CE_ACAD / robot / draft / 05. CE 02 Robot and Codex Testing, Thu 29 Oct 2026, 10:17 to 10:35 Melbourne. Team, Opus, headless.
Product: Civil 3.0.85, commit 09126560 on origin/claude/rel-20261026z (read with git show / git grep only).
Scope correction applied (CE 02, 10:27, decisions/2026-10-29_TIM_ANSWERS.md item 2): D05 is dropped from this job. The Recent buttons go back onto the main New Pipe page (BUG-1226, Tim: "yep bring back") and N30 is their guard. No D05 case and no N36 were drafted.
Nothing in AutoCAD was touched: no AutoCAD start, no run or run-pack, no driver call, no settings guard, no lock. Tim's AutoCAD (W26-26_C01...) was the only acad.exe the whole time. The live driver, runner and allow-list files were only copied; their hashes are unchanged (checked at 10:26).

## ANSWER FIRST

1. **The change is written, not applied.** A 65-line diff against copies (`C:\ce-fx\more_button\more_button.diff`) lets the robot press More... in New Pipe, open the Drawing tab of the "More options" window, set the Show grade toggle, and press Back. Nothing else in that window can be pressed.
2. **Offline test: 73 of 73 checks pass, plus 4 of 4 on the case pattern.** Use recent ..., Send report, Export, Save as ... and Delete are still refused, in both windows.
3. **One draft robot check, N35, with its must-fail twin,** is in `cases\drafts_opus_29oct_b5\`. Both pass the runner's format check. Neither can run until the diff is applied and reviewed.
4. **New finding:** the toggle sits on a tab of the More window that is closed when it opens, so "press More..." alone was never enough. The diff adds one narrow "open this named tab" route.
5. **Card D06 point 3 disagrees with the product.** Hiding the grade is remembered in a file the robot's settings guard does not protect. The case puts it back itself. Recommendation below.

---

## FOR TIM

1. **What this unlocks: hide grade (card D06).** The robot will be able to open New Pipe, click More..., turn "Show grade in pipe text" off, and check the pipe label reads "225 DIA. UPVC PIPE" with no "AT 1 IN".
   It then draws a second pipe with the toggle back on and checks "... AT 1 IN 200" comes back.
2. **What the robot will still refuse in that window.** Every "Use recent ..." button, every "Save as ..." preset button, Send report, Export, Delete and anything not named.
   It can press only More..., Back, open the Drawing tab, and set that one toggle.
3. **The recent-level buttons (D05) are not part of this.** You said "yep bring back": they go onto the main New Pipe page in the build.
   Robot check N30 already guards them there, so no More... permission is needed for them.
4. **One thing to know (no action today).** When the robot hides the grade, CE remembers "hide" for your next pipe. The check turns it back on at the end.
   If a run stops half way, your next CD pipe would be drawn without "AT 1 IN". The desk checks this after every run.
5. **Nothing for you to test or decide now.** The change still needs a second review and must be applied in a free window (after 5:30 pm).

---

## 1. Where the press list lives, and why it is shaped this way

1. **Two press lists, both pinned.** Driver v2 (`acad_driver_witness_v2.ps1`) reads `acad_driver_witness_v2.allowlist.json`; it is used only if its SHA-256 equals the pin on line 2371 of the driver ("A wider list needs ONE reviewed edit of this line"). Driver v3 (`acad_driver_v3.ps1`) has its own list (`acad_driver_v3.allowlist.json`, pinned on line 45) AND checks the first 12 hex of the v2 script and v2 list (lines 42 and 43); if either differs, v3 stops ("Someone edited v2 without the review: v3 stops").
2. **What is forbidden and why (recorded in the files).** `never_buttons` (contains-patterns): Publish, Send, Email, Install, Uninstall, Roll back, Restore, Repair, Reset, Upload, Download, Sign out, Remove, Delete, Erase, Purge, Overwrite, Replace, Exit, Quit, Export, Close without saving, Apply to all drawings, Save As, Save Draft and other bulk or outward actions. Line 117 to 121 whole-word deny list: Save, Delete, Update, Send, Continue placement and others, "these act outside the test copy (send, publish, install, roll back, profile)". A window or button that is not listed is refused. The never list beats every entry.
3. **Which route a case uses.** `ui2-press` and `ui2-set` go to v2 (`ui press`, `ui set`); `ui-press` and `ui-dump` go to v3. Runner step names: `case_runner_lib.ps1` lines 15 to 19.
4. **Why the change is in v2.** The toggle is a toggle button: it has no "press" (Invoke) pattern, so only v2 `ui set` can change it (`Invoke-V2Set`, TogglePattern). v2 `ui set` needs the window to have a v2 entry. v3 can already READ the More window: its entry `Creative Engineering*` covers the title. v3's list is not changed.

## 2. What the product does (09126560)

1. **The button.** `CivilMoreOptions.cs` line 26: `Content = "More…"` with ONE ellipsis character (Codex cx_cr25 item 7 said the same). No automation id. Added to the New Pipe footer by `PipeOnePageLayout.cs` lines 149 to 151.
2. **The window.** Title `Creative Engineering | More options` (line 33). Opened with ShowDialog, owned by New Pipe (line 94): it is modal. Its only button of its own is `Back`, `IsCancel = true`, which only closes it (lines 40 to 44); the closed window hands its content back. The pipe draft stays in the New Pipe window.
3. **What is inside it: the old tabs.** It shows the leftover `TabControl` of the old window: Pipe, Levels & Flow, Drawing, Schedule & Preferences (Connections is removed by `PipeOnePageLayout`). New Pipe starts on tab 0 (`PipeEditWorkshopDialog.xaml.cs` line 53, `WorkshopEditorSession.Open(..., 0)`), so the window opens on **Pipe**.
4. **Where the toggle is.** `PipeEditWorkshopDialog.xaml` line 368, on the **Drawing** tab (line 310). Its row is not one that `PipeOnePageLayout` moves (`MoveRow` climbs only to the CreatePipeText row's own Grid). The tab content of a tab that is not open is not in the UI Automation tree, so the robot can neither read nor set the toggle until Drawing is opened. **This corrects the batch 4 spec** (ROBOT_NEXT_CASES_SPEC_B4_29OCT.md item 1 in "findings": "there are no tabs"): true for the New Pipe page, not for the More window.
5. **Other things in that window** that must stay refused: the recent diameter / material row and the recent levels row (BUG-1226), the preset buttons "Save as Line only" and similar (line 371), the other tabs' fields.

## 3. The diff (against copies; NOT applied)

Copies: `C:\ce-fx\more_button\orig\` (as live at 10:20) and `C:\ce-fx\more_button\new\` (edited). File: `C:\ce-fx\more_button\more_button.diff`.

New hashes after the edit: v2 script D3430548BBD0FCD2..., v2 list 04B26704E02758CF..., v3 script 1C262C226EFE0FE3... (full values in `step2_offline_test.out.txt` and below the diff).

```diff
diff --git a/orig/acad_driver_v3.ps1 b/new/acad_driver_v3.ps1
--- a/orig/acad_driver_v3.ps1
+++ b/new/acad_driver_v3.ps1
@@ -39,8 +39,8 @@ Add-Type -AssemblyName System.Drawing
 $script:V3Here = $PSScriptRoot
 $script:V2Script = Join-Path $PSScriptRoot 'acad_driver_witness_v2.ps1'
 $script:V2AllowFile = Join-Path $PSScriptRoot 'acad_driver_witness_v2.allowlist.json'
-$script:V2ExpectedSha = '120EE24D15B2'            # acad_driver_witness_v2.ps1 (first 12 hex)
-$script:V2AllowExpectedSha = '5B542F2145F4'       # its allow-list
+$script:V2ExpectedSha = 'D3430548BBD0'            # acad_driver_witness_v2.ps1 (first 12 hex); 29 Oct 2026 More options change (was 120EE24D15B2)
+$script:V2AllowExpectedSha = '04B26704E027'       # its allow-list (was 5B542F2145F4)
 $script:V3AllowFile = Join-Path $PSScriptRoot 'acad_driver_v3.allowlist.json'
 $script:V3AllowPinnedSha = 'B8B4951312839CF54E14E8AF8A12E9354FE4AB0D55BCCCEBB7CF1B58FFE9662C'     # SHA-256 (full) of acad_driver_v3.allowlist.json; one reviewed edit per allow-list change (spec 6.6)
diff --git a/orig/acad_driver_witness_v2.allowlist.json b/new/acad_driver_witness_v2.allowlist.json
--- a/orig/acad_driver_witness_v2.allowlist.json
+++ b/new/acad_driver_witness_v2.allowlist.json
@@ -35,10 +35,17 @@
     {
       "title": "*New Pipe*",
       "deny_exceptions": ["Continue placement"],
-      "press": ["Continue placement", "Start pipe", "Start Pipe", "Cancel without saving", "Cancel", "Close", "OK"],
+      "press": ["Continue placement", "Start pipe", "Start Pipe", "Cancel without saving", "Cancel", "Close", "OK", "More…", "More..."],
       "press_ids": ["C2.OkCommand", "C2.PlaceCommand", "C2.CancelCommand"],
       "set": ["*"], "set_ids": []
     },
+    {
+      "title": "Creative Engineering | More options",
+      "note": "29 Oct 2026 (daily card D06): the window New Pipe's More... button opens (CivilMoreOptions.cs). Back is its Cancel button and only closes it; the pipe draft stays in New Pipe. Only the Drawing tab may be opened and only the Show grade toggle set. Every Use recent ... button, every Save as ... preset button and every other control in it stays refused.",
+      "press": ["Back"],
+      "press_ids": [],
+      "set": ["Drawing", "Show grade in pipe text"], "set_ids": []
+    },
     {
       "title": "*Pit Schedule*",
       "deny_exceptions": ["Update", "Update existing schedule", "Continue to Place / update"],
diff --git a/orig/acad_driver_witness_v2.ps1 b/new/acad_driver_witness_v2.ps1
--- a/orig/acad_driver_witness_v2.ps1
+++ b/new/acad_driver_witness_v2.ps1
@@ -2368,7 +2368,7 @@ function Invoke-WitnessSub($r, $state) {
 $script:V2Version = '2.2 fix pass 2 18 Oct 2026 (msgbox review MEDIUM 1-3, slow ui press watchdog, hard timeout keeps settings while the test AutoCAD runs) on acad_driver_witness.ps1 (sha256 0b1116c6...); fix pass 2 NOT re-reviewed by Opus yet'
 $script:V2AllowListFile = Join-Path $PSScriptRoot 'acad_driver_witness_v2.allowlist.json'
 # THE PIN for the allow-list file (same idea as the recorder DLL pin): the file next to the script is used ONLY if it hashes to this value. A wider list needs ONE reviewed edit of this line.
-$script:V2AllowListPinnedSha256 = '5B542F2145F48936BFE11463933DA60FF9539927AB9AA0EAFEFB0169A1AADDB3'
+$script:V2AllowListPinnedSha256 = '04B26704E02758CF97252DDFE148EE19B960742CAC202EF8489E1C37F93E995C'      # 29 Oct 2026: New Pipe More... and the More options window (Back; Drawing tab; Show grade toggle), daily card D06
 $script:V2AllowListTestOverride = $false      # offline tests only: the command line has no way to set it
 $script:V2AllowCache = $null
 # Per-session caps per verb (a refused call is counted too). The tester's own brief cap (40 / 60 / 70 calls) is a separate total cap: set $env:ACAD_DRIVER_CALL_CAP to let the driver enforce it.
@@ -2670,6 +2670,13 @@ function Invoke-V2Set($r, $state) {
             $r.data.value_after = $(try { [string]$vp.Current.Value } catch { $null })
         } elseif ($sp -and $s.type -eq 'RadioButton') {
             [void][AcadNative]::CallVia($sp, 'Select', @(), 3000); $r.data.pattern_used = 'SelectionItemPattern'; $r.data.value_after = [string]$sp.Current.IsSelected
+        } elseif ($sp -and $s.type -eq 'TabItem') {
+            # 29 Oct 2026 (daily card D06, the More options window): a tab is only ever OPENED, and only a tab its window entry names EXACTLY in "set" (a "*" entry never opens a tab)
+            if (@(@($row.Entry.set) | Where-Object { $_ -and ([string]$_ -notmatch '[\*\?\[]') -and ([string]$_ -ieq $s.name) }).Count -eq 0) { Refuse "tab '$($s.name)' is not named exactly in the set list for windows like '$($row.Entry.title)'; nothing was set" }
+            if ($val.Trim().ToLowerInvariant() -notmatch '^(on|true|1|yes|select)$') { Refuse "a tab can only be opened (value on); '$val' was refused" }
+            [void][AcadNative]::CallVia($sp, 'Select', @(), 3000); Start-Sleep -Milliseconds 300
+            $r.data.pattern_used = 'SelectionItemPattern'; $r.data.value_after = [string]$sp.Current.IsSelected
+            if ($r.data.value_after -ne 'True') { throw "tab '$($s.name)' did not open" }
         } else {
             throw "control '$($s.name)' (type $($s.type)) has no writable value, toggle or radio pattern; nothing was set (the driver never uses the mouse or SendKeys here)"
         }
```

Full new hashes: v2 script `D3430548BBD0FCD2281C17F346CED59CA58F8E7CBE760FA7719243DDB7865C04`; v2 list `04B26704E02758CF97252DDFE148EE19B960742CAC202EF8489E1C37F93E995C`; v3 script `1C262C226EFE0FE3CAC77114DBEF90684CD456D81987ED6D28FCFEBF6F57D77C`. The v3 list is unchanged (`B8B495131283...`).

### How a case addresses each control

1. **More...:** `ui2-press "New Pipe" "More*"`. The key with a star matches the button by name (`Find-V2Buttons` wildcard, line 2549), so the case file stays plain text without the ellipsis character; the driver then checks the button's REAL name ("More…") against the list, which names it exactly. A second button starting "More" would make the press ambiguous and it would be refused.
2. **Opening the Drawing tab:** `ui2-set "More options" "Drawing" "on"`. The control is found by its exact name (Find-UiControl). Only a tab named exactly in the entry's set list can be opened; "off" is refused; the windows whose set list is `"*"` (Edit Pit, New Pit, Edit Pipe, New Pipe, Pit Schedule and others) still cannot open any tab.
3. **The toggle:** `ui2-set "More options" "Show grade in pipe text" "off"` (or "on"). Existing TogglePattern code: it toggles at most three times and fails if the state is not reached.
4. **Reading:** `ui-dump "More options"` (v3, already allowed). The dump records each control's toggle state.
5. **Back:** `ui2-press "More options" "Back"`, then `await-window-gone "More options" -Secs 30`.

### How the window can never be left open

1. **Back is the window's Cancel button** (IsCancel) and only closes it; nothing is saved by it.
2. **If a case stops with it open,** the session end (`Close-V3OpenWindows`, `acad_driver_v3_session.ps1` lines 150 to 169) goes round every listed window up to three times. The More window matches v3's `Creative Engineering*` entry, whose list holds `Close`: the title-bar Close is pressed (it closes the window the same way as Back). New Pipe is then closed with `Cancel without saving`. DERIVED: this clean-up path has never met the More window.
3. **A further fallback that already exists:** `ui2-close "More options"` (v2 `ui close`, WindowPattern.Close; the title is on the old `Creative Engineering*` allow pattern).

### To apply (desk, after review, in a free window)

1. Copy the three files from `C:\ce-fx\more_button\new\` (acad_driver_witness_v2.ps1, acad_driver_witness_v2.allowlist.json, acad_driver_v3.ps1) over the live ones, together, and read the three hashes back.
2. **Undo:** copy the same three from `C:\ce-fx\more_button\orig\` back (hashes 120EE24D15B2, 5B542F2145F4, 4CD773B85EC5).
3. Update the cosmetic "expected" text in `case_runner.ps1` line 367 at the same time (it prints the old v2 hashes; it checks nothing). Not in the diff.

## 4. Offline test result

1. **Method.** `C:\ce-fx\more_button\step2_offline_test.ps1` dot-sources the COPIED drivers. I read both first: v2's last line runs nothing when dot-sourced (`if ($MyInvocation.InvocationName -ne '.') { Invoke-Main }`), v3 `-Library` defines functions only (line 1154). It calls only pure functions: the pin loader, `Find-V2Entry`, `Test-V2ButtonAllowed`, `Test-UiControlDenied`, `Assert-V3Pins`, `Get-V3WindowEntry`, `Test-V3NeverButton`. No AutoCAD, no lock, no settings, no UI Automation call. Output: `step2_offline_test.out.txt`.
2. **Result: 73 checks, 73 passed, 0 failed (10:25:41).** In short:
   1. **Allowed after the change:** press More… and More... in New Pipe; press Back in More options; set Show grade in pipe text; open the Drawing tab.
   2. **Still refused, in More options AND in New Pipe:** Use recent invert 18.19 / 18.190 m AHD, Use recent diameter 225, Use recent material UPVC, Use recent 225 (not on the list); Send report, Send, Export, Export CSV, Save as Line only, Save as Full pipe, Delete, Reset, Remove (never list); Save (whole-word deny list).
   3. **Set refused in More options:** Use recent ..., Diameter, Material, the tabs Pipe, Levels & Flow, Schedule & Preferences, Include known grade, Save as Line only, Send report.
   4. **Tab rule:** Drawing may be opened in More options; Pipe may not; no tab may be opened in a window whose list is "*" (New Pipe, Edit Pit).
   5. **Pins:** the new list matches the new pin; the old list is refused by the new pin; the new v3 accepts the new v2 files; the OLD v3 refuses them (which is why the two v3 lines are in the diff).
   6. **Before the change (original copies):** More… is refused in New Pipe and More options has no v2 entry.
   7. **v3 unchanged:** v3 ui-press still refuses Use recent ..., Send report, Export, Back and More…; its clean-up can still press Close.
3. **The case's toggle-state pattern** (`step2b_regex_test.ps1`, output `.out.txt`): a fake window read built field by field like `Get-V3WindowDump`, written to JSON and read back as the runner does, then turned to text by the runner's own `ConvertTo-CaseText`. The Off check matched only the Off state and the On check only the On state, with a second toggle of the opposite state on the same tab. 4 of 4.
4. **Runner format check** (`case_runner.ps1 validate`, offline: parse and check only; I read the `validate` branch first): both drafts "ok", with the COPIED runner and with the live runner (read-only). N35: 41 steps, 20 checks. N35_BROKEN: 18 steps, 5 checks.
5. **What I could not test offline:** the new TabItem branch of `Invoke-V2Set` itself (it needs live UI Automation; the same filter expression was tested on the entries, a copy, not the call); the real names in the live window; whether pressing More… returns while its modal window is up (v2 waits up to 3 s and reports "pending" if not, as for Start Pipe); `driver_v2_selftest.ps1` stage 0 was NOT run (it also drives the driver as a separate process, and Tim's AutoCAD was open); the v3 self-tests were not run.

## 5. The drafts (batch 5)

Folder `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_opus_29oct_b5\`. N35 is the next free number (N31 to N34 are batch 4). N36 is not used (D05 dropped). Both files start with the line "DEPENDS ON THE ALLOW-LIST CHANGE ... DO NOT RUN BEFORE THEN".

1. **N35_hide_grade_through_more_options** (SHA-256 17268407...). Card D06. Pipe 1: CD 150000,-85000 to 170000,-85000, levels 18.000 / 17.900, More..., open Drawing, toggle Off (read back Off), Back, Start Pipe. Checks: one label matching `^\d+ DIA\. \S+ PIPE$`, no "AT 1 IN", no "FLAT", two IL texts IL 18.000 and IL 17.900; New Pipe still open after Back and the More window gone. Pipe 2 (150000,-88000 to 170000,-88000): toggle back On (its opening state recorded), label `... PIPE AT 1 IN 200`. No CE window left at the end.
2. **N35_hide_grade_through_more_options_BROKEN** (SHA-256 4FA312A4...). The same route for one pipe with the toggle set ON: the "no AT 1 IN" and "PIPE only" checks must FAIL; the route checks (toggle shown, Back closes, New Pipe stays) must pass, so the red is the label.
3. **DERIVED values** (marked in the header): the window title, the four control names as UI Automation sees them, the toggle reading Off / On, and that the drawing area is empty in DRV1_B1. Everything else is from the source lines named in the header.
4. **N10 (27 Oct) is replaced** by N35 in intent; N10 was not edited. Its SETTING route cannot work (preflight 27 Oct).

## 6. Findings and open questions

1. **For Tim (recommendation, no answer needed today): card D06 point 3 is wrong for 3.0.85.** The card says the hide-grade value goes into the settings file and the robot's guard puts it back. By the source it goes into CD_RecentValues.json (`SettingsService.RememberedValues.cs` line 53), which the guard never backs up. **Recommend:** reword point 3 to "the check turns the toggle back on before it ends, and the desk compares CD_RecentValues.json before and after". Not: widening the settings guard to that file now (a bigger, separately reviewed change). Example: if a run stops after pipe 1, your next real CD pipe is drawn as "225 DIA. UPVC PIPE" with no grade until you turn it back on.
2. **Batch 4 spec correction:** the More window does have tabs, and the toggle is on a closed one (section 2 item 4). Without the tab route the D06 check would fail for a robot reason.
3. **Safety observation, not changed here:** the OLD `ui click` of driver v2 already treats every `Creative Engineering*` window and `New Pipe*` as clickable, and "Use recent" is not on the whole-word deny list. So a person driving v2 by hand (not the case runner, which has no click step) could already press More… and a Use recent ... button today. **Recommend** a later reviewed edit adding "Use recent" to the whole-word deny list (`acad_driver_witness_v2.ps1` line 117), once N30 no longer needs the buttons pressed (it only reads them).
4. **Remembered-value hazard:** N35 changes Tim's remembered hide-grade value during the run (header line 2). Desk: read `pipe.nonExistingPipeShowGrade` in `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` and the file SHA-256 before and after each N35 run.
5. **Open:** the diff needs an independent review (the pins say "one reviewed edit"). Suggested: add the 73 checks to `driver_v2_selftest.ps1` stage 0 at the same time, so the pin change is covered by the standing self-test.

## 7. What I did NOT verify

1. Nothing was seen in AutoCAD: not the More… button, the More window, its tabs, the toggle, Back, or any label.
2. The TabItem route in `Invoke-V2Set` has never run against a real window.
3. That the More window opens on the Pipe tab (from the source: tab 0), and that the toggle row shows for Tim's remembered pipe type (Stormwater by R18's window header).
4. That the runner's end clean-up closes a left-open More window (section 3, DERIVED).
5. That the fixture area 150000,-85000 to 170000,-88000 is empty.
6. `driver_v2_selftest.ps1` and the v3 self-tests were not run on the new copies.
7. Built: the diff and two drafts. Tested: offline only. Installed: no (live files unchanged). Tim-accepted: no.
