# Robot: the four small runner changes and the four test drawings for 8 pilot-critical bugs

CE_ACAD / robot / plan / 29. CE 02 Robot and Codex Testing, Thu 29 Oct 2026, 16:26 to 16:55 Melbourne (PC clock). Team, Opus, headless.
Product read: Civil 3.0.85, commit `09126560` (git show / git grep only). Method: the approved "More..." method (`ROBOT_MORE_BUTTON_B5_29OCT.md`, `OPUS_REVIEW_MORE_BUTTON_29OCT.md`).
Nothing in AutoCAD was touched: no AutoCAD start, no run or run-pack, no driver call, no settings guard, no lock. Your AutoCAD (one acad.exe, pid 30056) was the only one before and after.
No live file was edited. The live driver, runner and press-list files were copied and still hash as before (read at 16:48: v2 `120EE24D15B2`, v2 list `5B542F2145F4`, v3 `4CD773B85EC5`, v3 list `B8B495131283`, runner `13955AAA60D1`, runner library `8F9B8DCBB473`).

## ANSWER FIRST

1. **All four runner changes are written and tested on copies, not applied.** One diff, 48 lines added and 6 changed: `C:\ce-fx\pilot_runner\pilot_runner.diff`.
2. **Offline test: 224 of 224 checks pass.** Send, Export, Save as, Delete and every "Use recent" button stay refused in all seven windows a case drives. All 184 existing cases pass the format check, word for word the same as before.
3. **Only two of the four needed a press-list change.** The LandXML file chooser and the Pit Schedule remarks only needed new robot reading steps (the driver already allowed the rest).
4. **The four test drawings are written as recipes for Codex** (section 3). Two of them cannot be made with plain AutoCAD commands alone: the damaged pit record needs one typed LISP line on a copy, and the survey must be approved by Codex because approval happens in a CE Manager window the robot may never press.
5. **After both pieces, the robot can prove 6 of the 8 on its own** (BUG-1196, BUG-1049, BUG-1188, BUG-540, BUG-1150, BUG-1145). BUG-1142 needs the reviewer to accept a weaker "must fail" twin. BUG-1190 needs Codex for the survey approval.
6. **About 4 to 5 working days** from review to Claude-accepted, if Codex has two sessions free (section 5).
7. **This change and the More... change touch the same lines.** Neither is applied yet. I built and tested a combined set, so the desk installs both together once (section 2.7).

---

## FOR TIM

1. **What this unlocks.** Eight pilot-critical fixes that the robot could not reach today. For example, the robot will be able to tick "Change Diameter" in the Edit 2 Pipes window, type 375, and check both pipe labels say 375 and kept their own material (BUG-1049).
2. **What the robot still cannot press.** Send, Export, Save as, Delete, every "Use recent ..." button, Inspect Drawing, "Carry downstream", and anything in a CE Manager window.
   The new presses are exactly: Save in Edit Pit, "Apply to Selected" and Cancel in Edit 2 Pipes, and Open in the LandXML file chooser.
3. **What Codex must make (once, on copies).** A pasted network saved without CDREPAIR. A network with one damaged pit record. A turned survey Xref with a nested level block. A stage drawing with a placed Pit Schedule, plus a sheet that Xrefs it.
4. **Nothing for you to decide or test today.** The diff needs its own review first. It goes in after 5:30 pm, together with the More... change, in one install.
5. **One thing I found that you may want later.** CE's pit size suggestion still decides "step irons" from a fixed size step, not from your Settings step-iron depth (900 mm). No action now; it is noted for the BUG-540 card.

---

## 1. The eight bugs and what each needed (checked in the source and the driver, not taken from the list)

1. **BUG-1196 (Edit Pit Save, then the drawn schedule).** v2 already allows "Save pit and close", but the runner's format check refuses any `ui2-press` holding the word Save, and v3 lists only Cancel for Edit Pit. Today's robot presses Edit Pipe's save as "Edit pipe, Save" on 3.0.85 (runs RUN-20261029-0624, -0659, -0708). The drawn schedule is loose MText cells, one row at one Y. Needs: a v3 press-list entry (pinned) and a new drawn-row reading step.
2. **BUG-1049 (Edit 2 Pipes).** Correction to the pilot list: the window IS readable today. Its real title is "Creative Engineering | Edit 2 Pipes" (seen in the runner reports), which v3's `Creative Engineering*` entry covers. What is missing is setting the ticks and pressing "Apply to Selected" (v2 has no entry). Needs: one v2 entry (pinned).
3. **BUG-1188 (LandXML file chooser).** Correction: v2 already has a `dialog-path` verb that types a path into a Windows Open dialog and presses Open (never a Save dialog). The case runner just has no step for it. Needs: a runner step only (not pinned). I also gave the chooser a Cancel-only v3 entry so a left-open chooser is closed at the end.
4. **BUG-540 (remarks cell).** Correction: the remarks are not out of reach. The Pit Schedule window opens on the "Pit and pipes" column view; "Lid and remarks" is a radio button the robot may already set. Also the Depth figure sits in a text block under its cell, which the old reader (`ui-cells`) skips: it read "Depth=" with nothing. Needs: a reading step only (not pinned).
5. **BUG-1150, BUG-1142, BUG-1190, BUG-1145:** test drawings (section 3). BUG-1196 and BUG-540 also need a drawing with a placed schedule; I folded that into drawing 4 so Codex makes it once.

## 2. The diff (against copies; NOT applied)

Folder `C:\ce-fx\pilot_runner\`: `orig\` (copies of the live files at 16:27), `new\` (edited), `pilot_runner.diff` (SHA-256 `1D401F686EDD...`).

New hashes (SHA-256): v2 script `830245C24EF3F6B7C3575E090DD2E71AC5AE79BF3AD091E8E076A47973BE205B`; v2 list `285568F1613D04526022E0E8A17FAC4D14BAF0E93781BDA59F3FF62459CD7A14`; v3 script `8AE36078F3E5A104BE40ECD12878C391FFC4FFED5B3E9D4F9205988C1CC5B398`; v3 list `6F208EE33781FC7E8DD165355D7CEA176AD94BEDCBBB4318D586C929C0EEDB5F`; runner library `BC96085274EE25A4A0C891C6C5F1A305B10712386326178FDAB87A16E20333DC`. `case_runner.ps1` and `acad_driver_v3_session.ps1` are unchanged.

### 2.1 The press lists and pins (BUG-1049, BUG-1196, BUG-1188 clean-up)

```diff
--- orig/acad_driver_v3.allowlist.json
+++ new/acad_driver_v3.allowlist.json
-  "never_exceptions": ["Edit pipe, Save"],
+  "never_exceptions": ["Edit pipe, Save", "Edit pit, Save", "Save pit and close"],
-    { "title": "*Edit Pit*",                        "press": ["Cancel without saving", "Cancel", "Close"] },
+    { "title": "*Edit Pit*",                        "press": ["Edit pit, Save", "Save pit and close", "Cancel without saving", "Cancel", "Close"] },
     { "title": "Select File*",                      "press": ["Cancel"] },
+    { "title": "Choose LandXML*",                   "press": ["Cancel"] },
--- orig/acad_driver_v3.ps1
+++ new/acad_driver_v3.ps1
-$script:V2ExpectedSha = '120EE24D15B2'            # acad_driver_witness_v2.ps1 (first 12 hex)
-$script:V2AllowExpectedSha = '5B542F2145F4'       # its allow-list
+$script:V2ExpectedSha = '830245C24EF3'            # ...; 29 Oct 2026 Edit N Pipes entry, BUG-1049 (was 120EE24D15B2)
+$script:V2AllowExpectedSha = '285568F1613D'       # its allow-list (was 5B542F2145F4)
-$script:V3AllowPinnedSha = 'B8B4951312839CF5...'     # SHA-256 (full) of acad_driver_v3.allowlist.json; ...
+$script:V3AllowPinnedSha = '6F208EE33781FC7E...'     # ...; 29 Oct 2026: Edit Pit save (Edit pit, Save / Save pit and close), BUG-1196; Choose LandXML file chooser closable by Cancel, BUG-1188 (was B8B495131283)
--- orig/acad_driver_witness_v2.allowlist.json
+++ new/acad_driver_witness_v2.allowlist.json
+    {
+      "title": "Creative Engineering | Edit * Pipes",
+      "note": "29 Oct 2026 (BUG-1049): the CDEDIT batch editor for two or more selected pipes ... Only the Diameter and Material ticks and the Diameter box may be set, and only Apply to Selected and Cancel pressed. Inspect Drawing, the per-pipe 'Take ... out of the batch' buttons, Carry downstream, every other field and every Material pill stay refused. ...",
+      "press": ["Apply to Selected", "Cancel"],
+      "press_ids": [],
+      "set": ["Change Diameter", "New Diameter", "Change Material"], "set_ids": []
+    },
--- orig/acad_driver_witness_v2.ps1
+++ new/acad_driver_witness_v2.ps1
-$script:V2AllowListPinnedSha256 = '5B542F2145F48936BFE11463933DA60FF9539927AB9AA0EAFEFB0169A1AADDB3'
+$script:V2AllowListPinnedSha256 = '285568F1613D04526022E0E8A17FAC4D14BAF0E93781BDA59F3FF62459CD7A14'      # 29 Oct 2026: Edit N Pipes batch editor (...), BUG-1049
```

(Shortened here only where marked "..."; the full text is in `pilot_runner.diff`.)

1. **Why both Save names for Edit Pit.** The source names the button "Save pit and close" (`WorkshopEditorFocus.cs` line 285, id `C2.PlaceCommand`), yet the same source names Edit Pipe's "Save pipe and close" while the robot presses it as "Edit pipe, Save" on 3.0.85 and it works. I could not find where "Edit pipe, Save" comes from. So both exact names are allowed, nothing wider: "Edit pit, Save as", "Save pit", "Save pit and close all" and a button typed "Edit pit, Save" whose real name differs are all refused (tests).
2. **The never-exception is exact.** It excuses only those two names from the "Save*" rule; the press list still decides the window, so "Save pit and close" is refused in New Pit, Pit Schedule, Edit Pipe, Edit 2 Pipes and every other window (tests).
3. **The Edit 2 Pipes entry has no wildcard in its lists.** The title pattern needs the "Creative Engineering | " start and the word Pipes, so "Edit 2 Pits" (the pit batch) and the single "Edit Pipe" are not covered (tests).

### 2.2 The runner steps (not pinned; `case_runner_lib.ps1` only)

1. **`dialog-path "<file>"` (BUG-1188).** Calls v2 `dialog-path`; retries up to three times, 2 s apart, ONLY when v2 says no Open dialog is open yet; any refusal is not retried. The format check accepts only a written-out `.xml` file directly in `C:\ce_rc_drv` or `C:\ce_rc_scratch`: no variable, no sub-folder, no `..`, no DRV or CLD name. v2 then applies its own rules (allowed roots and types, file must exist, default button must be Open, Select or Choose).
2. **`ui-rows <dump> ["<row name>"]` (BUG-540, BUG-1196).** Each grid row as "row name: cell=text | ...", taking the cell's own value, else the texts under it. It stops at the end of the grid. A named row that is not there makes the step fail (no silent empty pass). `ui-cells` is unchanged.
3. **`sched-row <ms-new list> "<pit no>"` (BUG-1196, BUG-540).** The drawn row = the MText on layer 35TEXT whose whole text is the pit number, plus every MText at the same Y (within 0.01) up to 20 000 units to its right, in X order; `\P` line breaks become spaces. A pit not on the schedule makes the step fail.

### 2.3 How a case addresses each control

1. **Edit Pit save:** `ui-press "Edit Pit" "Edit pit, Save" -> $sv`, then `await-window-gone "Edit Pit" -Secs 120`. The first run should `ui-dump "Edit Pit"` before the press and record the button's real name; if it reads "Save pit and close", the case uses that name (also allowed).
2. **Drawn schedule row:** `ms-new 0 -> $m1`, `sched-row $m1 "P2" -> $row2`, check `matches $row2 "\| 1\.10 \| [^|]*With Step Irons"`.
3. **Edit 2 Pipes:** `pick-first "<h1>,<h2>"`, `type "CDEDIT" -Force -ExpectWindow "Edit 2 Pipes" -TimeoutSec 120`, `ui2-set "Edit 2 Pipes" "Change Diameter" "on"`, `ui2-set "Edit 2 Pipes" "New Diameter" "375"`, `ui2-set "Edit 2 Pipes" "Change Material" "on"`, `ui-dump "Edit 2 Pipes" -> $b`, check `control $b "Apply to Selected" enabled`, then `ui2-press "Edit 2 Pipes" "Apply to Selected"` and `await-window-gone "Edit 2 Pipes"`.
4. **LandXML:** `type "CDIMPORTLANDXML" -Force -ExpectWindow "LandXML import" -TimeoutSec 120`, `ui2-press "LandXML import" "Choose LandXML*"` (the real name ends in one ellipsis character; the star keeps the case file plain text), `dialog-path "C:\ce_rc_drv\RD15_GRADE.xml"`, `ui2-press "LandXML import" "Read source"`, then `"Import to drawing"`, then `"Close"`.
5. **Remarks:** `type "PITSCHEDULE" ... -ExpectWindow "Pit Schedule"`, `ui2-set "Pit Schedule" "Lid and remarks" "on"`, `ui-dump "Pit Schedule" -> $d`, `ui-rows $d "Pit P5" -> $r5`, checks `contains $r5 "Depth=0.95"` and `not-contains $r5 "With Step Irons"`.

### 2.4 Offline test

1. **Method.** `C:\ce-fx\pilot_runner\step2_offline_test.ps1` dot-sources the COPIED files. I read them first: v2's last line runs nothing when dot-sourced; v3 `-Library` defines functions only; the runner library defines functions only. The one call that would start a driver process (`Invoke-V2`) is replaced by a dummy that records its arguments. No AutoCAD, no lock, no settings, no UI Automation call. Output: `step2_offline_test.out.txt`.
2. **Result: 224 checks, 224 passed, 0 failed (16:43:14).** In short:
   1. **Allowed after the change:** Edit Pit "Edit pit, Save" and "Save pit and close" (v3); Edit 2 Pipes "Apply to Selected" and "Cancel" (press), "Change Diameter", "New Diameter", "Change Material" (set); Cancel in the LandXML file chooser (v3 clean-up).
   2. **Still refused in all seven windows a case drives** (New Pipe, Edit Pipe, Edit Pit, New Pit, Pit Schedule, LandXML import, Edit 2 Pipes): Send report, Send, Export, Export CSV, Export Excel, Save as Line only, Save As, Delete, and four "Use recent ..." names.
   3. **Still refused in Edit 2 Pipes:** Inspect Drawing, "Take ... out of the batch", Carry downstream, Only these pipes, New Material, every other field and tick, Apply, Close, OK, Save, Reset, Remove, and a name with a trailing space.
   4. **The file chooser:** a `.dwg`, `.exe`, Windows file, relative path, `..` path or wildcard path is refused by v2; the dialog's button must be Open, Select or Choose, never Save; nine bad `dialog-path` lines are refused by the format check.
   5. **The reading steps on real data:** `ui-rows` on the REAL Pit Schedule read from this morning's run (06:36) gives "Pit P8: ... | Depth=1.00" and 28 rows, where `ui-cells` still gives "Depth=" with nothing. On a made-up "Lid and remarks" read it gives "Pit P2: P2=P2 | Depth=1.10 | Remarks=With Step Irons". `sched-row` picks only its own row's Y.
   6. **Before the change (original copies):** Edit 2 Pipes has no v2 entry; "Edit pit, Save" is refused by v3; the three new steps are "unknown step".
   7. **Pins:** the new v3 accepts the new v2 files; the old v3 refuses them; the old v2 list is refused by the new v2 pin.
   8. **No AutoCAD started or stopped** (acad.exe before and after: 30056 only).
3. **Format check of every existing case** (`case_runner.ps1 validate`, offline: parse and check only; I read its branch first), on scratch copies of `cases`: old runner "184 file(s) checked, 0 invalid", new runner the same, outputs byte-identical. A probe case using all the new steps: "ok".
4. **Not tested offline:** the real UI Automation names in the windows; whether pressing "Choose LandXML…" returns while its modal chooser is up (v2 reports "pending", as for Start Pipe); `driver_v2_selftest.ps1` and the v3 self-tests were not run (they drive the driver as a separate process; your AutoCAD was open).

### 2.5 To apply (desk, after the independent review, in a free window)

1. Check the live hashes are still `120EE24D15B2`, `5B542F2145F4`, `4CD773B85EC5`, `B8B495131283`, `8F9B8DCBB473`; anything else: stop.
2. Back up the five files to `C:\ce_rc_scratch\driver_backup_pilot_runner_29oct\`, copy the five from `C:\ce-fx\pilot_runner\new\` (or `combined\`, see 2.7) together, read the hashes back.
3. **Undo:** copy the five back from the backup and read the original hashes back.
4. Then: v2 self-test stage 0, v3 offline self-test, `case_runner.ps1 validate` (expect 184 ok). The cosmetic hash text on `case_runner.ps1` line 367 can be updated as its own small edit.

### 2.6 Safety notes for the reviewer

1. **The "Choose LandXML*" v3 entry also makes the chooser readable** by `ui-dump` (read only). Its press list holds only Cancel; Open, Save and Choose are refused there (tests).
2. **The More... review's open finding (2.3.1) applies here too:** v2 searches every control under the window it is given. Edit 2 Pipes is modal, so while it is open a case naming "Edit Pipe" cannot reach it (different title, and "Edit Pipe" is not open at the same time). Nothing new is opened by this change.
3. **Apply to Selected writes to the open copy.** One Ctrl+Z undoes it ("[CE] 2 pipes updated. One Ctrl+Z undoes all of it.", `PipeEditCommand.Batch.cs` line 1090).

### 2.7 Combined with the More... change (one install, RULES 8.5)

1. **Both diffs edit the same three pin lines**, and neither is applied. Installing one after the other would make the second refuse to load.
2. **Built: `C:\ce-fx\pilot_runner\combined\`** = the More... `new` files plus this change, re-pinned. Diff: `pilot_runner_combined_with_more_button.diff` (SHA-256 `249ADEC5E9B2...`). Hashes: v2 script `32CF778DB2F9...`, v2 list `02D90D72DE0F...`, v3 script `AA5363681F87...`, v3 list `6F208EE33781...` (full values: `sha256sum` of the folder).
3. **Tested:** my 224 checks AND the More... job's own 73 checks, both run against the combined set: 224 of 224 and 73 of 73 (16:47). The pin they loaded was the combined one (`02D90D72DE0F`), so they really tested the combined files.
4. **Recommendation:** the reviewer reviews `combined.diff` against the live files, and the desk installs `combined\` once.

## 3. The test drawings (recipes for Codex, on COPIES only)

General rules for every drawing: work in `C:\ce_rc_drv` on a COPY, never on a `DRV*` master that exists already; robot fixtures must be named `DRV...` (the runner refuses any other name); an Xref target must sit in `C:\ce_rc_drv` next to the fixture and be attached with a RELATIVE path (the robot's session copy is made in the same folder, `CLDV3<time>_B1.dwg`). No file name may contain `_CVL_`, `_STR_` or a sheet token like `_C01` (CE reads those as "this is a Civil drawing" and wakes up; `DrawingDisciplinePolicy.cs` lines 51 to 64). Record the SHA-256 of each new file in the area file, and take a screenshot of each in AutoCAD.

### 3.1 Drawing 1: a pasted-and-saved network without CDREPAIR (BUG-1150)

1. **Make.** Open a copy of `DRV1_B1.dwg`. Select pits P1, P2, P3, the two pipes between them and their labels (a crossing window). Type `COPYCLIP`.
2. **New drawing from `acadiso.dwt`** (plain AutoCAD template, not a CE template), `INSUNITS` 4 (millimetres). Type `PASTECLIP`, insertion point `0,0`.
3. **Do not run ANY CE command** in this drawing: no CDREPAIR, no CD, no PIT, no CDEDIT, no MOVE of a pit (DERIVED: the first CE command marks the drawing Civil and writes a record, which hides the bug).
4. **SAVEAS** `C:\ce_rc_drv\DRV30_PASTED.dwg`, then CLOSE. Reopen it once and type `LIST` on one pit and one pipe (record the pit's insertion point and the pipe's two end points in the area file). Close without saving.
5. **What the case reads.** The robot opens a copy, records the pipe ends touching P2, does `pick-first <P2>` and `MOVE` by 2000,0, then reads the pipe ends again: they must have moved 2000 with the pit. Twin: `SETTING CD_Settings.json linking.civilWakesForPitsWithoutRecord false`; the pipe end must stay behind (the check fails).
6. **DERIVED:** that the pipes are read as pipe objects with their ends (a CE pipe object gives its box corners; a polyline its first vertex); that a fresh paste gives each pit its own identity but no project record (BUG-1150 log entry).

### 3.2 Drawing 2: one pit with a damaged link record (BUG-1142)

1. **Plain AutoCAD commands cannot make this.** The record is text inside the pit (extension dictionary `CE_CVL_SUITE_LINKS`, record `PIT_LINK`); COPY, PASTE, WBLOCK, ATTEDIT, EXPLODE and RENAME never damage it (source read; the fix's own test says "needs a drawing with a damaged record").
2. **Make, on a copy of `DRV1_B1.dwg` saved as `C:\ce_rc_drv\DRV31_BADLINK.dwg`.** Codex types one LISP line at the AutoCAD command line, picks pit P3 when asked, and checks the reply ends in the record list (not nil):

```lisp
(progn (vl-load-com) (setq e (car (entsel "\nPick the pit to damage: "))) (setq x (cdr (assoc 360 (entget e)))) (setq d (cdr (assoc -1 (dictsearch x "CE_CVL_SUITE_LINKS")))) (setq r (dictsearch d "PIT_LINK")) (entmod (append (vl-remove-if '(lambda (p) (= (car p) 1)) r) (list (cons 1 "{\"Pipes\":[{\"PipeHandle\":\"2A0\",")))))
```

3. **Then QSAVE and close.** Reopen, draw nothing, close. Record which pit was damaged (P3) and its handle.
4. **This LISP is for making the fixture only, by Codex, once.** Robot cases never type LISP (it wedged AutoCAD in run 47).
5. **What the case reads.** The robot draws a new pipe with CD between P1 and P2 (both good) through New Pipe, then MOVEs P2 by 2000,0: the new pipe's end follows; the command line shows once "[CE] The CE link record on pit P3 could not be read, so CE left that pit as it is and linked the pipe to the other pits." (`LinkService.Persistence.cs` lines 812 to 814).
6. **The weak spot: no switch.** The fix has no switch and the build before the fix (3.0.74) is not on your PC. The only "must fail" twin is a deliberately broken variant (for example, expecting the damaged P3 to follow when moved). The reviewer must agree that is enough, or BUG-1142 stays a Codex look.
7. **DERIVED:** the LISP line (never run); that the first 360 group of a pit is its extension dictionary; that text group 1 holds the JSON chunks.

### 3.3 Drawing 3: a turned survey Xref with a nested level block (BUG-1190, later BUG-1189)

1. **Survey file `C:\ce_rc_drv\RD15_NESTED.dwg`** (not DRV: it is never opened by the robot, only Xref'd). New drawing, `acadiso.dwt`, units metres to match your survey Xrefs (DERIVED: follow the units of a real survey Xref you use).
   1. Make a block `RD15_LEVEL` containing ONE TEXT `12.000` at `0,0` (TEXT, not MTEXT; it must contain a full stop).
   2. INSERT `RD15_LEVEL` at `10,0`, scale 1, rotation 0.
   3. Put a loose TEXT `15.000` at `0,12` (DERIVED: anywhere nearer to `0,10` than about 14 m; this is the wrong answer the old code picked).
   4. SAVE, close.
2. **Host drawings.** Two copies, each a new `acadiso.dwt` drawing with `XATTACH RD15_NESTED.dwg`, relative path, Overlay, insertion `0,0`, scale 1, rotation 90:
   1. `DRV32_SURVEY_ON.dwg`: with your normal settings, Codex runs CDSURVEY, clicks the Xref, skips step 2, and APPROVES (in CE Manager > Survey Intake, "Approve and store with drawing"). SAVE.
   2. `DRV32_SURVEY_OFF.dwg`: the same, but first Codex sets `survey.nestedSurveyBlocksKeepTheirPlace` to false (Settings, or the settings guard), approves, saves, and sets it back to true.
3. **Why Codex approves.** With CE Manager loaded, approval opens the Manager's Survey Intake window (`CdSurveyCommand.cs` lines 190 to 196). Manager windows are read-only to the robot by design. I do not recommend opening them to the robot.
4. **What the case reads.** The robot opens `DRV32_SURVEY_ON`, types PIT, gives the point `0,10`, and reads the New Pit window: the "Survey RL" row must read 12.00 m AHD at "nearest spot (0.0 m)". Twin: the same on `DRV32_SURVEY_OFF`, which must offer 15.00 (the check fails).
5. **BUG-1189 later** (built, not installed): the same `DRV32_SURVEY_ON`; the case MOVEs the Xref 5 m, then PIT at `0,10`: no level offered and the "has been moved, turned or scaled" line.
6. **DERIVED:** the units, the 15.000 position, the PIT window row text, and that New Pit shows the survey row in Design mode (the default).

### 3.4 Drawing 4: a stage drawing with a placed schedule, Xref'd into a sheet (BUG-1145; also serves BUG-1196 and BUG-540)

1. **Stage drawing `C:\ce_rc_drv\DRV33_STAGE.dwg`.** New `acadiso.dwt` drawing, mm. With CE (PIT and CD), draw this network (values from the BUG-1196 fix's own test, `Bug1196RefreshSecondOutletTests.cs`; positions DERIVED):
   1. P1 at `0,0`, cover 11.20. P2 at `20000,0`, cover 11.00 (pit floor 10.20 if the window asks). P3 at `40000,0`, cover 11.00. P4 at `20000,-20000`, cover 11.00. P5 at `60000,0`, cover 11.00.
   2. Pipes (CD, 225 mm): P1 to P2, inverts 10.60 / 10.50. P2 to P3, 10.40 / 10.30 (the chosen outlet). P2 to P4, 9.90 / 9.80 (the lower second outlet). P3 to P5, 10.25 / 10.05.
   3. PITSCHEDULE, Place the schedule at `0,-60000`.
   4. **Check before saving:** the drawn P2 row reads depth 1.10 and "With Step Irons"; P5 reads 0.95 and "With Step Irons" (default step-iron depth 900 mm). If not, stop and report: the layout is wrong.
   5. SAVE.
2. **Xref target `C:\ce_rc_drv\RD33_STAGE.dwg`.** A plain file copy of `DRV33_STAGE.dwg` (Windows copy, not SAVEAS).
3. **Sheet `C:\ce_rc_drv\DRV34_SHEET.dwg`.** New `acadiso.dwt` drawing. `XATTACH RD33_STAGE.dwg`, relative path, Overlay, at `0,0`. PITSCHEDULE, choose the Xref'd stage drawing as the source, Place the schedule at `0,-90000`. The window badge must read CURRENT. SAVE, close.
4. **Then change the stage drawing in a way that does not touch the schedule.** Open `RD33_STAGE.dwg`, CDCHECKS, ignore ONE finding, SAVE, close. (This changes the whole job record but nothing on the schedule.)
5. **What the cases read.**
   1. **BUG-1145:** the robot opens a copy of `DRV34_SHEET`, PITSCHEDULE, reads the status badge: must say CURRENT and not "OUT OF DATE". Twin: `SETTING ... linking.pitScheduleFingerprintScopedToSchedule false`: "OUT OF DATE" (the check fails).
   2. **BUG-1196:** on a copy of `DRV33_STAGE`: read the drawn P2 row (`sched-row`), CDEDIT P2, change its plan length (900 to 1050), "Edit pit, Save", read the drawn P2 row again: 1.10 and "With Step Irons" both times. Twin: `linking.pitScheduleRefreshCountsAllConnectedPipes false`: 0.80 and no note after the save (the check fails).
   3. **BUG-540:** on a copy of `DRV33_STAGE` with `SETTING CD_Settings.json designStandards.stepIronMinDepthMm 1000`: the Pit Schedule window ("Lid and remarks") row P5 reads Depth 0.95 without "With Step Irons"; Edit Pit P5's advice has no "requires step irons" line; after Edit Pit Save the drawn P5 row has no "With Step Irons". "Must fail" variant: the same checks with the setting left at 900.
6. **The robot never opens `RD33_STAGE.dwg`** (only through the sheet's Xref) and never saves anything.
7. **DERIVED:** the coordinates, "pit floor", the field name for plan length, that P2's chosen outlet is P2 to P3, and the badge text place in the window.

### 3.5 The LandXML test file (BUG-1188), already written

`C:\ce-fx\pilot_runner\fixtures\RD15_GRADE.xml` (SHA-256 `51F7AB76D6F4...`). Two pits 20 m apart, one 225 mm UPVC pipe with NO slope, metre units (without the Units line the 20 m pipe would come in as 20 mm). Copy it to `C:\ce_rc_drv\RD15_GRADE.xml` when the change is applied. DERIVED from the parser; never imported. The case imports into an EMPTY drawing (Codex: confirm one, or make `DRV35_EMPTY.dwg` from `acadiso.dwt`), then checks one label reads "225 DIA. UPVC PIPE" and none holds "AT 1 IN". Twin: `xcivilImport.importedPipeNoInventedGrade false` gives "... AT 1 IN 100".

## 4. What the robot can prove after both pieces

1. **Robot alone (Claude-accepted possible; drawing values and window text, nothing to SEE):** BUG-1196, BUG-1049, BUG-1188, BUG-540, BUG-1150, BUG-1145. Each has a switch twin, except BUG-540 (no switch: a deliberately broken variant).
2. **Robot with a reviewer's yes:** BUG-1142 (no switch and no older build: only a broken-variant twin).
3. **Robot plus Codex:** BUG-1190. Codex runs CDSURVEY and approves in CE Manager when making the drawings; the robot proves the New Pit offer (12.00 on the ON drawing, 15.00 on the OFF one). The approval step itself stays a Codex look.
4. **Tim's word:** none of the eight needs an engineering judgement. BUG-540's step-iron depth (900 mm) is already your setting.
5. **Bug entries whose check needs rewording (RULES 6.2):** BUG-1188's step says "the review shows grade as Unknown", but the review never mentions grade (`LinkCommands.ImportXcivil.cs` lines 284 to 297; REGRESSION_LOG.md line 881); the check is the drawn label. BUG-1145's "fails Project QA" is checked in CDCHECKDWG or CDDASHBOARD, not CDCHECKS.

## 5. Days of work

1. **Independent review of the combined diff (Opus):** half a day.
2. **Apply in a free window, self-tests, validate:** about 1 hour.
3. **Codex makes the drawings:** about 1 day in total (drawing 4 is the biggest; drawing 3 needs two approvals).
4. **Draft 8 cases and their twins (Opus):** about 1.5 days.
5. **Two separate robot sessions per case, after 5:30 pm:** two to three evenings.
6. **Reviewer's "reviewed_against" lines:** half a day.
7. **Total: about 4 to 5 working days**, assuming Codex time on days 2 and 3.

## 6. Findings for the desk

1. **Pilot list corrections (RULES 6.2):** Edit 2 Pipes is already readable; Edit Pit "Save pit and close" is already allowed in v2 (the runner's format check blocks it); the file chooser already has a v2 verb; the remarks were behind a column-view radio button; two of the four "pinned allow-list edits" needed no pin at all.
2. **PitSelector does not read the step-iron setting** (`PitSelector.cs` line 159 uses a fixed size step; its own comment, lines 47 to 56, says so). Note it on the BUG-540 card; the robot case above does not cover pit size suggestions.
3. **"Edit pipe, Save" is not in the source** at `09126560` (the source names the button "Save pipe and close"), yet it is pressed by that name on 3.0.85. Unknown origin; the reviewer may want to look.
4. **The LandXML "Use x.xml?" prompt can never appear**: `XcivilImportService.LastImportSourcePath` is never set anywhere (source reader's finding, `XcivilImportService.cs` line 37). Product, not robot; for the carpark if Tim wants it.

## What I did NOT verify (RULES 5.9)

1. Nothing was seen in AutoCAD: no window, button, tick, file chooser, drawn schedule or label.
2. The real names "Edit pit, Save", "Change Diameter", "New Diameter", "Change Material", "Apply to Selected" and "Lid and remarks" as UI Automation sees them on 3.0.85 (from the source, except Edit Pipe's save name from runs).
3. That pressing "Choose LandXML…" returns while the chooser is open, and that v2 `dialog-path` finds this WPF chooser (it looks for the standard File name box, id 1148, and the Open button, id 1).
4. That drawn schedule cells of one row share one Y after a refresh (read in the Place code only).
5. All four drawing recipes, the LISP line and the LandXML file: written from the source, never run.
6. `driver_v2_selftest.ps1` and the v3 self-tests were not run.
7. Installed versions are from git on `09126560`, not from the DLL strings on your PC.
8. Built: a diff, a combined diff, a test file. Tested: offline only. Installed: no (live files unchanged). Accepted: no.

## Summary (under 100 words)

The four runner changes for 8 pilot-critical bugs are written against copies in `C:\ce-fx\pilot_runner\`, not applied: an Edit Pit Save press, an Edit 2 Pipes tick-and-Apply entry, a LandXML file-chooser step and two new reading steps. Offline: 224 of 224 checks pass; refused buttons stay refused; all 184 existing cases unchanged. A combined set with the More... change also passes both test sets. Four drawing recipes are ready for Codex. Afterwards the robot can prove 6 alone, BUG-1142 with a reviewer's yes, BUG-1190 with Codex. About 4 to 5 days. Nothing ran in AutoCAD.
