# Independent review: the robot "More..." allow-list change (card D06, hide grade)

CE_ACAD / robot / review / 09. CE 02 Robot and Codex Testing, Thu 29 Oct 2026, 10:30 to 10:40 Melbourne. Team, Opus, headless, READ-ONLY.
Reviewed: `C:\ce-fx\more_button\more_button.diff`, the author's report `ROBOT_MORE_BUTTON_B5_29OCT.md`, drafts N35 and N35_BROKEN, card D06, and product commit 09126560 (read with git show only).
Nothing in AutoCAD was touched. No AutoCAD start, no run, no driver call, no lock, no settings guard. No live file was edited.

## ANSWER FIRST

**VERDICT: GO TO APPLY**, in a free window, with the conditions in section 5. Two small case fixes (section 4) can go in before the first run.

---

## FOR TIM

1. **Can the robot now be trusted to open that window? Yes, for this one job.** It can click More... on New Pipe, open the Drawing tab, flip "Show grade in pipe text" and click Back.
   I tried about 60 near-miss names ("Backup", "Go back", "More options", "Drawing breaks", "Include known grade"). Every one was refused.
2. **What it still cannot press in that window.** Any "Use recent ..." button, "Save as Line only" and the other preset buttons, Preferences, Send report, Export, Delete, Save.
   It cannot open the Pipe, Levels & Flow or Schedule & Preferences tabs either.
3. **One loose end, low risk.** While More options is open, the robot might be able to tick other boxes in it by naming the New Pipe window instead.
   It still cannot press any button that saves, sends or deletes. Those boxes are the same kind it can already change on New Pipe. I have asked for a follow-up fix.
4. **One thing to watch on your own PC.** If a test stops between its two pipes, your next CD pipe would be drawn without "AT 1 IN 200".
   The desk checks this after every run. If it ever happens: CD, More..., Drawing tab, turn "Show grade in pipe text" back on, draw one pipe.
5. **Nothing for you to do or test today.** It goes in after 5:30 pm, when nobody else is driving AutoCAD.

---

## 1. The live files still match what the diff was made against

1. **Hashes read at 10:31 (SHA-256).** The live files in `C:\Lisp Files\_ACAD_DRIVER` equal the copies in `C:\ce-fx\more_button\orig\` for all seven files.
   1. `acad_driver_witness_v2.ps1` live = orig = `120EE24D15B25DA9D60288FD88881A49FB5945DBE22F55B1DE00305FB154A8B9`
   2. `acad_driver_witness_v2.allowlist.json` live = orig = `5B542F2145F48936BFE11463933DA60FF9539927AB9AA0EAFEFB0169A1AADDB3`
   3. `acad_driver_v3.ps1` live = orig = `4CD773B85EC5D5A4697EA85D62FBF443D9A2764622FED99F214B74A66F15C8F7`
   4. `acad_driver_v3.allowlist.json`, `acad_driver_v3_session.ps1`, `case_runner.ps1`, `case_runner_lib.ps1`: live = orig = new (unchanged by the diff).
2. **The new copies contain exactly the diff and nothing else.** `git diff --no-index orig new`: 3 files, 18 lines added, 4 removed, the same 22 lines as `more_button.diff`.
3. **The new pins agree with the new files.** v2 list `04B26704E027...` equals the pin in the new v2 script; v2 script `D3430548BBD0...` and list `04B26704E027...` equal the two short pins in the new v3. Checked by loading the patched copy (section 2.1).

## 2. Trying to break it

### 2.1 How the driver matches (read in the patched copy)

1. **Window entry** (`Find-V2Entries`, line 2398): the real window title is matched with `-like` against each entry, case-insensitive, first entry wins. The new entry has no wildcard, so only the exact title `Creative Engineering | More options` (any letter case) gets it.
2. **Press and set check** (`Test-V2ButtonAllowed`, line 2408): the never list (contains-patterns) on the REAL name and id, then the whole-word deny list, then the entry's list with `-like` on the REAL name. A control found by its id must still have a listed name. Entries with no wildcard match only the whole name.
3. **Finding a control** (`Find-UiControl`, line 1191) can fall back to "name contains the key". That does not widen anything: the real name is what is checked in step 2.
4. **The new tab route** (Invoke-V2Set, new lines 2673 to 2679) is reached only for a TabItem control, only for a name listed EXACTLY (no `*`, `?` or `[`) in the entry's set list, and only with the value on. It throws if the tab did not open.

### 2.2 Probes on the patched copy (my own script, offline)

`C:\ce-fx\review09\probe.ps1`, output `probe.out.txt`. It dot-sources the patched v2 copy (its last line runs nothing when dot-sourced; I read its top-level lines first) and calls only `Get-V2AllowList`, `Find-V2Entry`, `Test-V2ButtonAllowed` and the tab-rule expression. Results:

1. **Window titles.** `Creative Engineering | More options` and the same in capitals: the new entry. With a trailing space, or `More options` alone: no entry (refused). A made-up title `... More options - New Pipe`: the New Pipe entry (no such window exists in 3.0.85).
2. **Press in More options.** ALLOWED: `Back`, `back`, `BACK`. REFUSED: `Back ` and ` Back` (spaces), `Go back`, `Backup`, `Back to list`, `Feedback`, `More…`, `Close`, `OK`, `Cancel`, `Use last settings`, `Preferences`, `Existing creation controls`, `Adjust Arrow Position`, `Save as Line only` (never list, Save As), `Use recent diameter 225 mm`. A button named Back whose id contains Send: REFUSED (never list beats it). A button with id Back but another name: REFUSED.
3. **Set in More options.** ALLOWED: `Drawing`, `drawing`, `Show grade in pipe text` (any case). REFUSED: `Drawing ` (space), `Drawings`, `Drawing preset`, `Drawing breaks`, `Show grade`, `Include known grade` (the toggle's name on an Existing pipe), `IL text`, `On plan`, `Remember this setup for the next pipe`, `Auto-zoom to pipe`, `Extra text`, the tabs `Pipe`, `Levels & Flow`, `Schedule & Preferences`, and a control with id Drawing but another name.
4. **Press in New Pipe.** ALLOWED: `More…` (one ellipsis character), `More...`, and the old `Start Pipe`, `Continue placement`. REFUSED: `More`, `More options`, `More… ` (space), `More……`, `Review changes`, `Use last settings`, `Inspect Drawing`, `Use recent invert 18.190 m AHD`, `Back`.
5. **Tab rule.** Opens `Drawing` in More options only. Refuses `Pipe` there, and refuses `Drawing` in New Pipe and Edit Pit (their set list is `*`).
6. **Product names agree** (09126560): the button is `Content = "More…"` (`CivilMoreOptions.cs` line 26), Back is `Content = "Back", IsCancel = true` (lines 40 to 44), the tab is `Header="Drawing"` (`PipeEditWorkshopDialog.xaml` line 310), the toggle text is `GradeToggleLabel` = "Show grade in pipe text" or "Include known grade" on Existing (`CdViewModel.cs` line 151). No other control in that window is named exactly "Drawing" or "Back".

### 2.3 Findings

1. **MEDIUM-LOW, follow-up (not a blocker): the New Pipe `"set": ["*"]` may reach into the More window.** The press and set routes search every control BELOW the window they are given (`FindAll Descendants`). UI Automation commonly shows a modal owned window as a child of its owner (FlaUI finds modal windows that way). If that is true here, `ui2-set "New Pipe" "Remember this setup for the next pipe" "on"` would be ALLOWED while More options is open (probe: New Pipe's set list allows it).
   1. **What it can and cannot do.** Only set ticks, toggles and text boxes in the pipe draft. No button can be pressed this way (New Pipe's press list has no name that is in the More window), and tabs stay refused. Values persist only when Start Pipe is pressed, the same as every New Pipe field the robot already sets.
   2. **So the author's claim "only that one toggle" holds for the `More options` title, not for every route.** Not seen in AutoCAD.
   3. **Fix later, one reviewed edit:** in `Invoke-V2Set` and `Invoke-V2Press`, refuse a control whose nearest Window ancestor is not the target window. Until then, the desk refuses any case that names a More-window control with the New Pipe title.
2. **LOW: the tab rule also accepts a toggle name.** Any name in the set list counts as a tab name, so `Show grade in pipe text` would be accepted as a tab if a tab had that name. None does. Harmless; a separate `"tabs"` key would be cleaner next time.
3. **LOW, cosmetic:** `$script:V2Version` is not updated, and `case_runner.ps1` line 367 still prints the old v2 hashes (it checks nothing; the author said the same).

### 2.4 Is anything left open if a case stops half way?

1. **The hide-grade value is written only by Start Pipe** (`CdViewModel.Commands.cs` line 43 `SaveSettings()` inside `ExecuteOk`; `CdViewModel.Settings.cs` lines 290 to 293). Closing or cancelling the windows writes nothing.
2. **So the only bad stop is between pipe 1's Start Pipe and pipe 2's Start Pipe.** That leaves `pipe.nonExistingPipeShowGrade` false in `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json` (confirmed: `SettingsService.RememberedValues.cs` line 53 routes it there). The settings guard does not cover that file. Hence condition 5.6.
3. **Window clean-up** (`Close-V3OpenWindows`, `acad_driver_v3_session.ps1` lines 150 to 169): the More window matches v3's `Creative Engineering*` entry, whose list tries Cancel without saving, Cancel, then Close (the title-bar Close). New Pipe then gets Cancel without saving. NOT checked: which window the loop reaches first, and whether pressing New Pipe's Cancel while More options is still up behaves. Fallback: `ui2-close "More options"`.
4. **Escape:** the robot's Esc (`esc-prompt`) acts on the command line, not the More window. Back is the window's Cancel button, so Esc in the window would also close it, but the robot does not send Esc to windows.

### 2.5 Behaviour of existing cases

1. **Format check, whole cases folder, run on two scratch copies** (`C:\ce-fx\review09\live` and `\patched`, each with its own copy of `cases`; `validate` only parses and prints, I read its branch first, lines 422 to 425): both "184 file(s) checked, 0 invalid", outputs byte-identical.
2. **Drafts folder b5:** both copies "2 file(s) checked, 0 invalid" (N35: 41 steps, 20 checks; N35_BROKEN: 18 steps, 5 checks).
3. **No existing case uses More, a tab name, or a More-window control** (search of `cases`). The only change for an old case: a `ui2-set` on a tab in a `*` window now says REFUSED instead of "no writable pattern". No case does that.

## 3. Verdict on the diff itself

1. **Sound.** The two new press names, the new window entry and the new tab route are as narrow as the author says, for the More options title. The pins move together: v2 list pin, v2 script short pin and v2 list short pin in v3.
2. **The one gap** is finding 2.3.1. It is not new in kind (New Pipe has always been `set *`), cannot press anything, and is a reasonable follow-up.

## 4. Drafts N35 and N35_BROKEN against card D06

### N35: SOUND, two small fixes recommended

1. **Card assertion 1 (label, no AT 1 IN, no FLAT):** covered. The regex is `^\d+ DIA\. \S+ PIPE$`; the card's is `.+ PIPE$`. **Fix:** use `.+` so a two-word material cannot fail it. DRV1_B1 gives UPVC (R18), so it is not urgent.
2. **Card assertion 2 (IL 18.000, IL 17.900):** covered (`count $ils1 = 2` and both texts).
3. **Card assertion 3 (file value):** honestly moved to NOT_AUTOMATED with the reason. The card is wrong for 3.0.85 (CD_RecentValues.json, not the guarded file). Agree with the author's recommendation to reword the card.
4. **Card step 2 "expect on":** NOT checked; only recorded. **Fix:** add `matches $more1_before "\{(?=[^{}]*Show grade in pipe text)(?=[^{}]*toggle\W+On)[^{}]*\}"`. If an earlier run left the value off, this check turns red first: an alarm for the hazard in 2.4.
5. **Puts the toggle back on at the end:** YES (pipe 2: set On, `matches $more2_after ... On`, label ends `PIPE AT 1 IN 200`).
6. **Lists CD_RecentValues.json as rewritten:** YES, in header line 2 (and the NOT_AUTOMATED line). The runner has no header key for it, so a comment is the only place.
7. **Route checks are good:** New Pipe still open after Back, More window gone, no CE window at the end.

### N35_BROKEN: NEEDS FIX (small)

1. **Fails on a CHECK:** yes. `matches $lt1 "^\d+ DIA\. \S+ PIPE$"` and `not-contains $lt1 "AT 1 IN"` fail when the label carries the grade. The runner counts a red only when the first failure is a check, not a step (`case_runner.ps1` line 406).
2. **Weak spot:** it never proves the label EXISTS with the grade. **Fix:** add `count $label1 = 1` and a must-pass `matches $lt1 "AT 1 IN 200$"`, so the red can only be the grade, not a missing label.
3. **Leaves the toggle on:** yes (Tim's normal value). Header lists the file write: yes.

## 5. Conditions for GO, and the exact commands

1. **When:** a free window (after 5:30 pm, or 2 to 3 pm), with the driver lock free and no robot AutoCAD running.
2. **Check the live hashes first.** In PowerShell:

```powershell
$live = 'C:\Lisp Files\_ACAD_DRIVER'; $src = 'C:\ce-fx\more_button'
$files = 'acad_driver_witness_v2.ps1', 'acad_driver_witness_v2.allowlist.json', 'acad_driver_v3.ps1'
foreach ($f in $files) { '{0}  {1}' -f (Get-FileHash -LiteralPath "$live\$f").Hash.Substring(0, 12), $f }
# must print 120EE24D15B2, 5B542F2145F4, 4CD773B85EC5. Anything else: STOP, someone changed the driver.
foreach ($f in $files) { '{0}  {1}' -f (Get-FileHash -LiteralPath "$src\new\$f").Hash.Substring(0, 12), $f }
# must print D3430548BBD0, 04B26704E027, 1C262C226EFE. Anything else: STOP, the copy was changed after review.
```

3. **Back up, then apply all three together:**

```powershell
$bk = 'C:\ce_rc_scratch\driver_backup_more_button_29oct'
New-Item -ItemType Directory -Force -Path $bk | Out-Null
foreach ($f in $files) { Copy-Item -LiteralPath "$live\$f" -Destination "$bk\$f" }
foreach ($f in $files) { Copy-Item -LiteralPath "$src\new\$f" -Destination "$live\$f" -Force }
foreach ($f in $files) { '{0}  {1}' -f (Get-FileHash -LiteralPath "$live\$f").Hash.Substring(0, 12), $f }
# must print D3430548BBD0, 04B26704E027, 1C262C226EFE
```

4. **Undo (same window):**

```powershell
foreach ($f in $files) { Copy-Item -LiteralPath "$bk\$f" -Destination "$live\$f" -Force }
foreach ($f in $files) { '{0}  {1}' -f (Get-FileHash -LiteralPath "$live\$f").Hash.Substring(0, 12), $f }
# must print 120EE24D15B2, 5B542F2145F4, 4CD773B85EC5
```

5. **Right after applying:** run the v2 self-test stage 0 and the v3 offline self-test (free window only), then `case_runner.ps1 validate` on `cases` (expect 184 ok, 0 invalid). Optionally update the cosmetic hashes on `case_runner.ps1` line 367 as its own small edit.
6. **First live run of N35, alone:** before and after, read `pipe.nonExistingPipeShowGrade` and the SHA-256 of `%APPDATA%\TIM_CE_CADTOOLS\CD_RecentValues.json`. If it ends false, put it back (CD, More..., Drawing, toggle on, one pipe in a test copy) before Tim's next CD.
7. **Same first run, read only:** add `ui-dump "New Pipe" -> $np_with_more` while More options is open and record whether "Show grade in pipe text" appears inside New Pipe. That settles finding 2.3.1.
8. **Desk rule until the follow-up fix:** refuse any case that names a More-window control with the New Pipe title.

## 6. What I did NOT check

1. Nothing in AutoCAD: not the More… button, the window, its tabs, the toggle, Back, the labels, or the clean-up at session end.
2. The new TabItem branch of `Invoke-V2Set` never ran (it needs live UI Automation). I read it and tested its filter on the entries only.
3. Whether UI Automation shows More options inside New Pipe (finding 2.3.1): reasoned, not seen.
4. `driver_v2_selftest.ps1` and the v3 self-tests: not run (they drive the driver as a separate process; Tim's AutoCAD was open).
5. Whether the fixture area 150000,-85000 to 170000,-88000 is empty in DRV1_B1.
6. The author's 73-check script was read in part, not re-run; I ran my own probes instead.
7. Built: a diff (by the author). Tested: offline only, by the author and by me. Installed: no. Tim-accepted: no.
