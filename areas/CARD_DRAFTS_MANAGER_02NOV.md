# CARD DRAFTS 12 of 15: SUITE MANAGER (5 cards), Mon 2 Nov 2026, Melbourne

Written by Sonnet (Team, read-only) for CE 05 and CE 00. Nothing here is approved. Only this file was written. No build, no test, no AutoCAD, no robot, no settings file opened, no push.

## FOR TIM

1. **Five cards below**, one per command: Updates & Rollback (#1876), Refresh line and start-up line (#1936, #1935), CESUPPORT zip (#1878), "running now, off next start" (#1799) with the version-box names (#1691), and CEHEALTH plus fault reports (#1233, #941).
2. **Where the changes live:** #1876, #1936, #1935 and #1878 are NOT on `claude/rel-20261102a` (that line is the C-78 build, tip 3fbb9da5, Manager 1.1.88). They are on the C-79a train, `claude/rel-20261106a` (and the later 08a, 10a, 12a lines). #1799, #1691 and #941 are on no release line at all: drafts on old branches. #1233 is not needed: the fix has been on rel-20261102a since 9 Oct (commit 5a344c73).
3. **Could not pin down:** no screen text for #1799 was read from code on any current line (the code is only in the draft, so its wording comes from the Opus review and carpark). The old family card for the Manager screens does not exist (confirmed: no card in `areas\cards`; the only Manager card-style paper is the CE Blocks palette card of 24 Sep). I also could not run `gh`, so PR text came from the Opus reviews, the build register and the train list, not from GitHub.
4. **Questions that need you:** the "Rollback" button has no go-back step on the drafter's screen (card 1), whether Civil's own start-up line should also say Net8 (card 2), whether to close #1233 (card 5). Plain wording, with a recommendation, is in each card.
5. **Read:** the five Opus reviews (L, O, W, BACKLOG R8, BACKLOG2 R2), the build register, the train list, the finalizer report, the carpark entries for BUG-1247, 1244, 1172, 1181, 961, 484, decision 98, and the code on rel-20261102a and rel-20261106a with git.
6. **NOT proven:** all five are built and unit-tested by their authors at most. Nobody has installed or opened any of this in AutoCAD, and nobody has accepted any of it (not you, not Codex). I did not re-run any test.
7. **One wording fault found on #1936:** if one report file is held by OneDrive, the Refresh line wrongly says the office folder could not be reached (Opus W, point 3). Details in card 2.

---

# CARD 1 of 5: Updates & Rollback

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Updates & Rollback (`CEMANAGERUPDATES`): opens the screen that shows what CE version is running now, what starts next time, and whether an approved update is waiting.
2. **Ribbon or trigger.** CE Tools tab, panel "Updates", large button "Updates & Rollback" = `CEMANAGERUPDATES`. Beside it are "Refresh" (`CEMANAGERREFRESH`) and "Admin" (`CEMANAGERADMIN`). Read in `Modules/Manager/Services/CeToolsRibbonDefinitionService.cs`.
3. **Works today** (rel-20261102a, Manager 1.1.88). A drafter who is not a CE administrator gets the Manager window on its Updates tab (BUG-948). An administrator (today, you) gets the "CE Suite Manager | Admin Dashboard" on its Updates tab, with Approve Available Build, Roll Back Approved Release, Canary Rollout and Promote to All.
4. **What the train or PR changes.** PR #1876 (B-058, BUG-1247), head d30041c4, train C-79a. One line in `PluginManagerCommands.cs`: with switch `updatesButtonOpensOwnScreen` ON, every account, administrator or not, gets the Manager window's own Updates tab. Switch lives in `%APPDATA%\CE_SUITE\manager-switches.json`, default ON (missing, empty or broken file, or any value except a plain `false`, reads ON). OFF restores the 1.1.88 behaviour exactly. The Admin button is unchanged and still opens the dashboard (on its Overview tab). No installer, approval, signing or rollback code changed. CE_SHARED not touched. Opus L (30 Oct): KEEP-WITH-NOTE. **On rel-20261102a: NO. On rel-20261106a: YES.**
5. **Suggested class: Modify.** Same button, different window for administrators; colleagues see no difference. Suggestion only.
6. **Prompts and windows.** Window titled "CE Suite Manager" (not "Admin Dashboard"), Updates tab. Text on the tab, from the window file: "Running now", "Starts next time", "1 · Approved", "2 · Copied, waiting", "3 · Install" ("Close AutoCAD", "Then run the CE installer"), "Release notes", "Previous version", "Check before getting it ready". Buttons: "Review update", "What's ready", "Get update ready", "Cancel". The explanatory line reads: "This copies the approved update to a safe holding folder. Nothing you use now changes until you close AutoCAD and run the CE installer."
7. **Selection.** None. It needs a drawing open (with no drawing the command just returns; Opus L notes it does not mark the command as cancelled).
8. **Preview.** None. "Review update" shows what is approved before "Get update ready".
9. **Drawing output.** None. Nothing is drawn, no layer, no object touched. Locked layers, Xrefs and REFEDIT are not involved. "Get update ready" only copies a holding folder; it refuses unless a signed approved release exists for this PC.
10. **Cancel, Escape, Undo and Redo.** Closing the window or "Cancel" changes nothing. Nothing goes on AutoCAD's undo list, so Undo and Redo are not involved. GUESS on Escape: it is a modeless window, so Escape at the command line has nothing to cancel; not read in code.
11. **Save and reopen.** Nothing saved in the drawing. If the Manager window is already open on another tab, the command brings it forward and switches to Updates (code calls the reopen helper, then `ShowUpdatesPage`); not seen working.
12. **Assets, data and Settings.** Reads `manager-switches.json` (file only; no Settings page row exists for Manager switches), the approved-release record and the module list. Writes nothing by itself.
13. **Performance.** No cost found. On 29 Oct you saw the Admin Dashboard take about a minute to fill in; that was load time, not a fault (carpark update of 29 Oct). The own screen is lighter; not timed.
14. **Discovery.** The ribbon button and its hover text ("Review approved releases, staged updates and rollback status."). Command line: type `CEMANAGERUPDATES`. No Help page entry read.
15. **Example drawing and expected result.** Any open job drawing. On your PC, click Updates & Rollback. Expected: the Manager window on Updates. From your own 29 Oct screen the numbers would read CE_CVL_SUITE installed 3.0.85 and CE_STRUC_SUITE installed 1.0.125, with no Approve, Canary or Promote buttons. (The mixed approved/available/installed numbering styles on that screen are a separate open point in BUG-1247, not changed here.)
16. **Older family card.** None exists. `docs/MANAGER_PRODUCT_PLAN.md` is the only older paper (a plan, not a card); it does not describe this button. It says nothing about the administrator now getting the drafter's screen.
17. **Tim's AutoCAD checklist.**
    1. **Administrator, own screen:** click CE Tools > Updates & Rollback. See "CE Suite Manager" with the Updates tab selected and no Approve, Canary, Promote or Roll Back buttons.
    2. **Window already open:** open CEMANAGER, move to another tab, click Updates & Rollback. It comes forward on Updates.
    3. **Admin still works:** click CE Tools > Admin. The Admin Dashboard opens on Overview, and its Updates tab still has Approve, Roll Back Approved Release, Canary and Promote.
    4. **Old behaviour control (AutoCAD closed):** put `{"updatesButtonOpensOwnScreen": false}` in a test copy of the switch file, restart, click Updates & Rollback. The Admin Dashboard opens on Updates. Put your file back afterwards.
    5. **Drafter account (not a CE administrator):** Updates & Rollback opens the Manager Updates tab; `CEMANAGERADMIN` prints "not set up as a CE administrator" and opens nothing.
18. **Questions only Tim can answer.**
    1. **Go-back step.** Context: your 29 Oct answer (decision 98) said the drafter's own screen should let them "go back to the previous version". I understand the screen only SHOWS the previous version number; the "Roll Back Approved Release" button exists only on the Admin Dashboard. Recommendation: keep the button name as is for now, record BUG-1247 part 2 as open, and decide it with the Manager Help tab work (B-047). On a job: if you answer "drafter can roll back", a colleague with a bad update could go back without calling you; if "administrator only", the button should be renamed "Updates" so nobody expects a go-back.
19. **NOT proven.** **Built:** yes, by the author (Manager net10 suite 1,098 passed, 1 skipped, 0 failed, 13 new cases; Manager net48 0 errors), not re-run by me. **Tested:** unit tests only; no one has driven it in AutoCAD, and the order-guard test is source-text only. **Installed:** not on your PC; the code is on rel-20261106a, not rel-20261102a. **Tim-accepted:** no. Nobody has done the AutoCAD look (Codex or you).

---

# CARD 2 of 5: Refresh result line, and the Manager start-up line

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Two small wording changes. (A) Refresh (`CEMANAGERREFRESH`) now tells you on the command line what it did. (B) The Manager start-up line and status bar say "Net8" on AutoCAD 2025 and 2026 instead of "Modern".
2. **Ribbon or trigger.** (A) CE Tools tab, panel "Updates", button "Refresh" = `CEMANAGERREFRESH`. (B) No button: the line appears when AutoCAD starts and Manager loads, and in the status-bar box "CE MANAGER v... [lane] date".
3. **Works today.** (A) Refresh uploads waiting reports to the office folder, rebuilds the CE ribbon, and refreshes the Manager and Admin windows if open. It prints only "Command: CEMANAGERREFRESH" (your 29 Oct hand check H38: "thats all it did i have no idea what else it did"). (B) On 2025/2026 the line reads "[Modern]", the same as 2027.
4. **What the train or PR changes.** (A) PR #1936 (B-116, BUG-1244), head 4ebf367a: one extra command-line line. Switch `refreshPrintsResultLine`, default ON; only a plain `false` turns it off, and OFF prints nothing as before. What Refresh does is unchanged. (B) PR #1935 (B-116, BUG-1172), head d49842fe: label names Legacy (2022 to 2024), Net8 (2025/2026), Modern (2027). Switch `laneLabelNamesNet8`, default ON; OFF gives the old "Modern". The support-record build type is untouched. Both in the Manager switch file `%APPDATA%\CE_SUITE\manager-switches.json`. Opus W: KEEP-WITH-NOTE for both. **On rel-20261102a: NO. On rel-20261106a: YES.** #1936 and #1876 edit the same file (`PluginManagerCommands.cs`) and merged clean together.
5. **Suggested class: Modify** for both (words only). Suggestion only.
6. **Prompts and windows.** (A) The exact line from the code: "[CEMANAGER] Refreshed: the CE ribbon was rebuilt; " then one of "the Manager window was updated" or "the Manager window is not open, so nothing to update there"; then one of "no reports were waiting to send", "1 report was sent to the office folder", "N reports were sent to the office folder", or "the office folder could not be reached, so any waiting reports stay on this PC and go on the next Refresh"; then a full stop. (B) "[CE_SUITE_MANAGER] v1.1.89 [Net8] loaded." (version as named in the finalizer report for the train).
7. **Selection.** None.
8. **Preview.** None.
9. **Drawing output.** None. Command-line and status-bar text only. Nothing drawn, no layer, no system variable changed. Locked layers, Xrefs, REFEDIT not involved.
10. **Cancel, Escape, Undo and Redo.** Nothing to cancel; Refresh runs straight through. Not on the undo list.
11. **Save and reopen.** Nothing saved in the drawing. (A) The ribbon is rebuilt each time. (B) Appears at every AutoCAD start.
12. **Assets, data and Settings.** Reads the Manager switch file; (A) also moves waiting report files to the office IT folder (that part already existed). No Settings page row (Manager switches are file-only, same as the rest).
13. **Performance.** Refresh does the same work as before; the extra line costs nothing. Not timed.
14. **Discovery.** (A) The Refresh button's hover text: "Refresh CE product and release status." (B) Visible at start-up. No Help page entry read.
15. **Example drawing and expected result.** Any open drawing with the Manager window closed and no waiting reports: type `CEMANAGERREFRESH`. Expected last line: "[CEMANAGER] Refreshed: the CE ribbon was rebuilt; the Manager window is not open, so nothing to update there; no reports were waiting to send." On AutoCAD 2026 start-up: "[CE_SUITE_MANAGER] v1.1.89 [Net8] loaded."; on 2027 still "[Modern]".
16. **Older family card.** None exists. The carpark BUG-1244 asks for "one plain line saying what was refreshed and the result"; its example "3 modules loaded, no update waiting" is not what Refresh does, so the PR does not claim it.
17. **Tim's AutoCAD checklist.**
    1. **Refresh line:** click CE Tools > Refresh. Read the last line on the command line. It starts "[CEMANAGER] Refreshed:".
    2. **With the Manager window open:** open CEMANAGER, then Refresh again. The line says "the Manager window was updated".
    3. **Old behaviour control (AutoCAD closed):** set `{"refreshPrintsResultLine": false}` in a test copy of the switch file. Refresh prints no such line.
    4. **Start-up line:** needs a PC with AutoCAD 2025 or 2026. Start AutoCAD, read the Manager load line and the status-bar box: "[Net8]". On 2027 it must still read "[Modern]".
18. **Questions only Tim can answer.**
    1. **Civil's own start-up line.** Context: Civil's start-up line has the same fault and is NOT in #1935 (Opus W; BUG-1172 stays open until a small Civil change follows). I understand Manager now says Net8 on 2026 but Civil still says Modern. Recommendation: do the Civil line as a small follow-up so both lines agree. On a job: a colleague on 2026 reading "Net8" for Manager and "Modern" for Civil will think there is a mismatch.
    2. **Do you want the OneDrive wording fixed first?** Opus W found: if one report file is held by OneDrive, the line says the office folder could not be reached when some reports may have gone. Suggested words: "some waiting reports could not be sent; they stay on this PC and go on the next Refresh". Recommendation: ship as is, fix wording next.
19. **NOT proven.** **Built:** yes, by the authors (#1935: 12 new tests; net48 and net8.0-windows compile clean), not re-run by me. **Tested:** unit tests only; the Net8 branch compiles only in a net8 build while tests run on net10, so only the pure label rule is proven. **Installed:** no. **Tim-accepted:** no. Nobody has run Refresh with this change, or started AutoCAD 2025 or 2026 with it; I could not confirm a 2025/2026 PC exists for the test (Opus W).

---

# CARD 3 of 5: CESUPPORT zip never takes a key or local settings file by name

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** CESUPPORT (ribbon "Support Bundle"): makes a zip of CE logs on your PC to send to support. After this change it also refuses, by file name, any key or machine-only settings file that was copied into one of its folders.
2. **Ribbon or trigger.** CE Tools tab, panel "Health & Support", button "Support Bundle" = `CESUPPORT`. Also a "Create Support Bundle" button on the Admin Dashboard.
3. **Works today.** The zip is made on this PC only and is never uploaded (code comment, INT-069 item 12). It reads only: the `CE_CADTOOLS\CE_Admin\logs` and `\sessions` folders, the Desktop folder "CE Diagnostics", the latest diagnostics text for this PC in the office folder, and the plugin log folders (top level only, CE's own log names, last 14 days). Drawing paths in text become job numbers; login and PC name become codes. The administrator's private name book is never included.
4. **What the train or PR changes.** PR #1878 (B-063), head a9a0a4f5, train C-79a. A name check inside the single place every file passes through, done before the file is opened. No switch (it can only leave files out). **On rel-20261102a: NO. On rel-20261106a: YES.** Opus O (30 Oct): KEEP-WITH-NOTE. The carpark (BUG-1173 evidence note 2) says no path under `%APPDATA%\CE_SUITE` could reach the zip even before; this closes the one gap by name.
5. **Suggested class: Modify.** Privacy guard only. Suggestion only.
6. **Prompts and windows.** Command line: "[CESUPPORT] Creating support bundle...", then "[CESUPPORT] Support file saved: <path>. ..." and "The zip lists what it holds in WHAT_IS_IN_THIS_ZIP.txt (N files, M left out)." The message ends: "Drawing paths inside it are cut to job numbers and your login and computer name are coded." The "left out" file names are shown only inside the zip notes page, not on the command line.
7. **Selection.** None.
8. **Preview.** None. The notes page `WHAT_IS_IN_THIS_ZIP.txt` inside the zip is the list of what went in and what was left out.
9. **Drawing output.** None; no drawing is read or changed. **What goes into the zip:** text files (.txt, .log, .json, .csv, .xml, .md, .ini) and CE's own log names, each up to 5 MB, from the folders named in field 3, plus the notes page. **What is refused, listed as "left out":** (a) any file whose name starts with `blob-config`; (b) any file whose name ends `.local.json`; (c) anything under a folder named exactly `CE_SUITE`; (d) the administrator's private name book; (e) non-text files; (f) files over 5 MB; (g) plugin logs older than 14 days. Matching ignores upper or lower case. The notes page also says: never in it are drawings, update copies of CE, the queued reports folder, the administrator list, menu files or install ids. The left-out line shows the file's name only, never what is inside. **What it does NOT catch** (Opus O): a key saved under another name (for example `keys.txt` dropped into CE Diagnostics), or a key pasted into a log line. CE never puts one there; a separate content-cleaner follow-up is suggested. Locked layers, Xrefs and REFEDIT: not involved, no drawing access.
10. **Cancel, Escape, Undo and Redo.** No prompt to cancel. Not on the undo list. Nothing to undo; the zip is a file you can delete.
11. **Save and reopen.** The zip is saved on your Desktop or the local folder the switch picks (`SupportZipLocalFolderEnabled`); not read further. It tells you if the folder is inside OneDrive.
12. **Assets, data and Settings.** Reads the folders above; writes only the zip. Reads the Manager switch file for the output folder choice. No secret value is quoted in this card; only the public file-name pattern `blob-config*` is named.
13. **Performance.** Checks names only, so no extra file reads. Not timed.
14. **Discovery.** Ribbon "Support Bundle" (hover: "Collect truthful CE logs and diagnostics for support.") and the command name. No Help page entry read.
15. **Example drawing and expected result.** No drawing needed. Test copy: put a dummy file called `blob-config.local.json` with the words "TEST ONLY" and a dummy `a.local.json` into the Desktop "CE Diagnostics" folder, run CESUPPORT. Expected: the zip does not contain either; `WHAT_IS_IN_THIS_ZIP.txt` lists both under "Found but left out" as "key or local settings file, never included"; your normal logs are in.
16. **Older family card.** None exists. The related note is carpark BUG-1173 evidence note 2 (30 Oct): it says the Manager zip needed this name guard as defence in depth. Older text that the zip is "queued for upload" in the code comment on CESUPPORT is out of date (the zip is never uploaded; BUG-1261).
17. **Tim's AutoCAD checklist.**
    1. **Make the zip:** click CE Tools > Support Bundle (or type `CESUPPORT`). The command line shows the saved path and "N files, M left out".
    2. **Open the zip's notes page** (`WHAT_IS_IN_THIS_ZIP.txt`). It lists what went in and what was left out.
    3. **Stray-file test (dummy files only, never a real key):** put dummy `blob-config.local.json` and `a.local.json` in Desktop > CE Diagnostics. Run again. Both appear under "left out" and not in the zip.
    4. **Normal logs still go in:** the CE log files from the last 14 days are in the zip.
18. **Questions only Tim can answer.**
    1. **Content cleaner follow-up.** Context: a key under another name, or inside a log line, would still go in. I understand CE already has a key-spotting cleaner (`CeSensitiveDataGuard`) that could close this. Recommendation: yes, as its own small fix with its own test, not slipped into this one. On a job: without it, a key someone copied by hand into CE Diagnostics as `keys.txt` would be in a zip the drafter emails out.
    2. **Structural's own old zip.** Context: Structural has an older support zip with the same gap that also holds the real login and PC name; nothing can start it (CESUPPORT belongs to the Manager). Recommendation: park it as a bug (carpark has it, found 30 Oct). Not a decision for this card.
19. **NOT proven.** **Built:** yes, by the author (11 of 11 B-063 tests pass on the merged branch, per the build register); not re-run by me. **Tested:** unit tests only; 6 of the 11 can fail on the old behaviour; the "take the fix out and watch it fail" check Opus O asked for (one minute) was not done by anyone. **Installed:** no. **Tim-accepted:** no. Nobody has run CESUPPORT on a real PC with this change.

---

# CARD 4 of 5: "Running now, off next start" after Disable on Restart, and stable names on the version boxes

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** On CEMANAGER's Module page, after you click Disable on Restart for a tool that is running, the page says so plainly instead of going back to "Healthy". The second change (#1691) gives the four version boxes hidden fixed names so a robot reads the right number; you see no difference.
2. **Ribbon or trigger.** CE Tools tab, panel "Product", button "CE Manager" = `CEMANAGER`, then the Module page, then Disable on Restart / Enable on Restart. No new button.
3. **Works today.** After Disable on Restart for Civil, the refresh rescans from the manifest and shows "Loaded" or "Healthy" because the file is still in memory; it never says Civil will not start next time (BUG-1181). The window shows "Running now" and "Starts next time" version boxes (the heading was "Installed next start" before BUG-917; rel-20261102a already says "Starts next time").
4. **What the train or PR changes.** **#1799 (BUG-1181), head e1172154, base claude/rel-20261025r, DRAFT.** From two facts already in the manifest (loaded now, not set to start), the page says "It is running in this AutoCAD, but it will not start next time. Click Enable on Restart if it should.", the health line says "Running now, off next start", and the one-glance line turns amber with "Running now, off next start" and the existing "Switch on at next start" button. It survives refresh and closing and reopening Manager. An update waiting to install still wins. Switch `legacyStatusWhenSwitchedOffAtStart`, default OFF, which means the new words show; only a plain `true` brings back the old "Healthy" wording. **#1691 (BUG-961), head b1c1ab64, base claude/rel-20261023l, DRAFT:** four version boxes (running version, running build, installed version, installed build) get names such as `Manager.Status.CE_CVL_SUITE.Running.Version` plus a spoken name for screen readers. No switch. **On rel-20261102a: NEITHER. On any later release line (06a, 08a, 10a, 12a): NEITHER** (I searched the Manager code for the new switch and the new text; no hit). Opus R8: both KEEP-WITH-NOTE, Manager area plus smoke. #1799 changes default wording, so Opus says it must land by C-80 (Mon 9 Nov), the last build that changes defaults.
5. **Suggested class: Modify** (#1799, words and colour); **Keep** (#1691, nothing visible changes). Suggestion only.
6. **Prompts and windows.** The three sentences in field 4 (from the Opus review of the draft code; not seen on a running screen). No new window, question or refusal. For #1691 the only visible words are unchanged: "Running now" and "Starts next time". Opus suggests the spoken names say "starts next time version" and "starts next time build" to match the heading.
7. **Selection.** Select a tool (for example Civil) in the Module list on CEMANAGER.
8. **Preview.** None. The status line updates after the click and after Refresh.
9. **Drawing output.** None. No drawing is read or written. Locked layers, Xrefs and REFEDIT not involved. Disable on Restart only changes the tool's start-up setting; Enable on Restart reverses it.
10. **Cancel, Escape, Undo and Redo.** Closing Manager changes nothing. The real undo is the Enable on Restart button. Not on AutoCAD's undo list.
11. **Save and reopen.** The start-up setting is stored in the tool's manifest, so the new line returns every time you reopen Manager until you click Enable on Restart. That is the point of the fix; not seen in AutoCAD.
12. **Assets, data and Settings.** Reads the manifest and the Manager switch file (once each time Manager rescans, no write). A typo such as `"legacyStatusWhenSwitchedOffAtStart": "true"` in quotes turns off the other Manager switches in that file too and logs one line (Opus R8); a note for the switch help.
13. **Performance.** A small switch-file read per module each time Manager rescans. Not timed.
14. **Discovery.** On the Module page itself, no new Help page entry read.
15. **Example drawing and expected result.** No drawing needed. Click Disable on Restart for CE Civil, then Refresh. Expected: "It is running in this AutoCAD, but it will not start next time. Click Enable on Restart if it should." and an amber "Running now, off next start". Close and reopen Manager: still there. Click Enable on Restart: back to the normal wording.
16. **Older family card.** None exists. The older note is the carpark BUG-1181 text ("persistent window text that Civil is running now but will not automatically start next time, kept across refresh and reopening Manager; separate from an update waiting to install"). It does not mention the amber one-glance line.
17. **Tim's AutoCAD checklist** (on a copy or spare login; put Enable on Restart back afterwards).
    1. **CEMANAGER > Module > select Civil > Disable on Restart.** Read the next-step line and health line: they must say it will not start next time, not "Healthy".
    2. **Press Refresh.** Read again: same words.
    3. **Close Manager, type `CEMANAGER` again.** Read again: same words.
    4. **Click Enable on Restart.** Words return to normal; the real start-up setting is not left off.
    5. **Old-wording control:** put `{"legacyStatusWhenSwitchedOffAtStart": true}` in a test switch file, restart AutoCAD, repeat step 1: the old "Healthy" wording comes back.
    6. **For #1691:** nothing visible to check; confirm the four version boxes still read the same numbers.
18. **Questions only Tim can answer.**
    1. **Put #1799 on the 9 Nov build?** Context: it changes default wording and the deadline is C-80. I understand it is a draft on an old base that needs a rebase and one extra line in the Manager switch-defaults check. Recommendation: yes, rebase and include, because the bug is easy to hit and the wording is low risk with an OFF switch for the old words. On a job: if left out, a colleague who clicks Disable on Restart sees "Healthy" and wonders why the tool is gone after restarting AutoCAD.
    2. **#1691:** none; no visible change.
19. **NOT proven.** **Built:** both by their authors only. #1799: Manager net10 suite 1,035 total, 1,034 passed, 1 skipped, and 8 new checks failed red-first on old code (4 failed, 4 passed as designed). #1691: Manager 918 total, 917 passed, 1 skipped. Not re-run by me. **Tested:** unit tests and off-screen window pictures only (not a live AutoCAD check). **Installed:** no; not on any release line. **Tim-accepted:** no. Nobody has opened either in AutoCAD. How a tool loaded by another route (for example a Structural bundle outside the CE manifest) shows is not known.

---

# CARD 5 of 5: CEHEALTH Manager line and second-copy warning, and fault reports without street names

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** CEHEALTH checks your CE install and prints OK or WARN lines. It now includes a line for the Manager, a check that Civil and Manager carry matching copies of the shared file, and a warning if a tool is installed in two places. Separately, Manager fault reports saved for the office IT folder (#941) no longer carry drawing or job-folder names.
2. **Ribbon or trigger.** CE Tools tab, panel "Health & Support", large button "CE Health" = `CEHEALTH` (hover: "Check the CE installation and active drawing."). The command is owned by the Manager (`PluginManagerCommands.cs`). Fault reports have no trigger: they are written automatically when something fails.
3. **Works today** (rel-20261102a). CEHEALTH has had the Manager line, the matching-pair line and the "installed in two places" warning since 9 Oct (commit 5a344c73, HUNT-M-09). Exact lines from the code: "[OK]    CE Manager v<version>"; "[OK]    CE Civil and CE Manager are a matching pair."; "[WARN]  CE Civil and CE Manager carry different copies of the shared CE file, so they may not work together. Run the CE installer again."; "[WARN]  CE could not compare the shared CE file in CE Civil and CE Manager. Run the CE installer again if CE misbehaves."; "[WARN]  <tool> is installed in two places, so AutoCAD may load both: <folder> and <folder>. Remove one." Then the office IT folder check, and "[CEHEALTH] All checks passed." or "[CEHEALTH] N issue(s) found - see above." Fault reports today still use the older cleaner on rel-20261102a.
4. **What the train or PR changes.** **#1233 (BUG-484): no change wanted. Opus R8 (1 Nov): CHANGE-NEEDED, do not merge, close it as already done.** Merging it would print two Manager lines and two warnings for the same second copy. It conflicts with the line in `PluginManagerCommands.cs`. **#941 (privacy audit A6), head 50213ba6, base rel-20261009l, DRAFT:** a fault report's message and details go through the same cleaner as the support zip: drawing paths become "[job 25-123]" or "[drawing path removed]". CE's own places stay readable; the old login and PC-name cleaning still applies. No switch (a privacy protection). Opus BACKLOG2 R2: KEEP. **On rel-20261102a: #1233 not needed (already there); #941 NOT on it. On later lines (06a to 12a): #941 NOT there** (searched for the new function; no hit).
5. **Suggested class: Keep** (CEHEALTH as it is today); **Modify** (#941, fault reports). Suggestion only.
6. **Prompts and windows.** Command-line lines in field 3. Nothing to answer.
7. **Selection.** None. It checks the install, not the drawing.
8. **Preview.** None.
9. **Drawing output.** None. Nothing drawn, no layer, no object touched; locked layers, Xrefs and REFEDIT not involved. For #941: no drawing access either.
10. **Cancel, Escape, Undo and Redo.** Nothing to cancel; it prints and ends. Not on the undo list.
11. **Save and reopen.** Nothing saved by CEHEALTH. #941: the fault report JSON is written to `<IT Admin>\CE Plugin Admin\failures\<date>` only.
12. **Assets, data and Settings.** CEHEALTH reads the installed tool list, the shared file in Civil's and Manager's bundle folders, the plug-in bundle folders, and whether the office IT folder exists. #941 writes one JSON per failure.
13. **Performance.** Not timed; a few file reads.
14. **Discovery.** The "CE Health" ribbon button and `CEHEALTH`. No Help page entry read.
15. **Example drawing and expected result.** No drawing needed. Healthy PC: type `CEHEALTH`; expect OK lines per tool, "[OK]    CE Manager v1.1.88", "[OK]    CE Civil and CE Manager are a matching pair.", the office folder OK line and "All checks passed." With a spare copy of a tool in a second bundle folder: a WARN line naming both folders and "Remove one." For #941: a fault report for a failure while `...\25-123 Smith Street\Lot 4.dwg` is open now reads "[job 25-123]" where it used to show that path.
16. **Older family card.** None exists. The carpark BUG-484 text says CEHEALTH had no Manager line, no pair check and no second-copy report; that is now out of date (all three have been in since 9 Oct) but the carpark entry is still OPEN until you confirm it in AutoCAD.
17. **Tim's AutoCAD checklist.**
    1. **Type `CEHEALTH`.** Read every line. Expect "[OK]    CE Manager v..." and "[OK]    CE Civil and CE Manager are a matching pair." with exactly ONE Manager line.
    2. **Second-copy warning (spare PC or copy only):** copy one `CE_*.bundle` folder to a second plugin folder, run `CEHEALTH`. One "installed in two places ... Remove one." line for that tool, and the issue count goes up by one. Remove the spare copy afterwards.
    3. **Fault report (#941, only once it is built):** nothing to click; ask CE 05 to check one saved report in the office folder for "[job ...]" in place of a street name.
18. **Questions only Tim can answer.**
    1. **Close #1233 as already done?** Context: the Opus R8 pre-review says the release line has had the same fix since 9 Oct. I understand merging it would double the lines. Recommendation: yes, close the PR; the BUG-484 carpark line stays OPEN until you see the CEHEALTH output in AutoCAD. On a job: no change to what a colleague sees.
    2. **#941 on the train?** Context: nothing changes on screen; it only affects the files written to the office IT folder. Recommendation: yes, as a privacy protection, once cherry-picked onto the current line (it is about 1,750 commits behind). On a job: it stops a client's street name reaching the shared office folder in a fault report.
19. **NOT proven.** **Built:** the CEHEALTH Manager line has been built on rel-20261102a since 9 Oct (HUNT-M-09 tests exist); #941 is built by its author only (Manager 692 of 692 at its old base, not the tip). **Tested:** unit tests only. #941's four tests build the report without writing anything. **Installed:** CEHEALTH with the new lines: not confirmed installed on your PC (not checked; I read the repo, not the installed DLL). #941: no. **Tim-accepted:** no, for both. Nobody has run CEHEALTH and read the Manager and second-copy lines in AutoCAD, and nobody has written a real fault report from a running AutoCAD with #941.

---

Cross-check for CE 05: the PR-to-branch statements above come from code searches on `origin/claude/rel-20261102a` and `origin/claude/rel-20261106a` and from the Opus reviews and train list; the finalizer report names 37dc1e62 as the C-79a head and "1.1.89" as the version. I did not confirm the 06a tip commit's identity or whether 06a is the exact C-79a build Tim has installed.
