# DRAFT FOR TIM. CARD B: installer and CEMARKUPRUN downloads (BUG-553, BUG-554)

**Status:** DRAFT FOR TIM. Tim said yes ("yes", decision 183, Sat 31 Oct 2026): CEMARKUPRUN's automatic software download OFF by default; the installer checks the WebView2 signature or bundles it; card first. Nothing is built, tested or installed by this job. Written 31 Oct 2026 (job n20).
**Classification:** MODIFY (CEMARKUPRUN: warn and record around a download that is already OFF by default). MISSING (installer: a WebView2 check with a plain warning; no download). Installer first-install route and repair: OUT OF THE PILOT (decision 182).
**Source:** BUG-553 and BUG-554 (C:\CE_PLAN\BUG_CARPARK.md), audit file areas\release-v3-colleagues-OFF_PC_CALLS_2026-10-09.md. Code read (read only): installer on Civil/Manager origin/claude/rel-20261102a (Civil 3.0.88 / Manager 1.1.88, head 3fbb9da5); CEMARKUPRUN worker and its Settings on Structural origin/claude/rel-20261026s (Structural 1.0.125, head 204dfad2); the CE Help window and the PDF markup reader on the Civil line.

## 1. Two things the carpark entries do not say (read first)
1. **BUG-554: the installer program does not download WebView2 today, and did not on 9 Oct either.** The download code is inside a block that is switched off and never built into the installer. It was switched off on 22 Jul 2026 (safe-installer work RS-01B2) and it was already switched off at the exact version the 9 Oct audit read. The audit read code that never runs. The daily and at-logon update tasks the entry also worries about sit in the same switched-off block. The code is still in the file, so it could be switched back on by mistake.
2. **BUG-553: the main fix is already installed.** Since 9 Oct (#949) a new PC starts with "Prepare local processing automatically" OFF, and Structural 1.0.125 (installed line) has it. With it OFF, CE does not download anything: it stops and names the three missing packages. What is left is listed in section 3.

## 2. What works now
1. **Pilot install = a hand install** (decision 182; colleague pack page 02: about 5 minutes, AutoCAD closed, copy the folders). No installer program runs, so nothing is downloaded at install time.
2. **CEMARKUPRUN with the switch OFF (new PCs):** if the three Python helpers (pyautocad, comtypes, pywin32) are missing, the batch step stops with: "The local markup worker needs three Python packages (pyautocad, comtypes, pywin32) and they are not installed. CE does not download them on its own: install them yourself, or tick 'Prepare local processing automatically' in Settings (that downloads them from the internet)."
3. **CE Help (CDHELP) without WebView2:** the Help window switches to a panel with an "Open in default browser" button. Windows 11 ships with WebView2.
4. **PDF markups without WebView2 (Civil):** the PDF page reader uses WebView2; my reading is the drafter gets "PDF rendering failed:" and the reason. Not seen in AutoCAD.

## 3. What is wrong or missing
1. **Old PCs keep the old value.** The code says so: a PC that already stored a value keeps it. Before 9 Oct the default was ON, so a PC whose Structural settings were saved before then may still download automatically. Not checked on any PC (I did not open anyone's settings file).
2. **With the switch ON, the download is silent.** A markup batch pauses up to 5 minutes while Python fetches the helpers from the internet; no line says it is happening, and success leaves no record. Only a failure shows a message.
3. **Nobody is told when WebView2 is missing.** Neither the hand-install steps nor the installer check it; the drafter finds out when Help opens in a browser or a PDF markup fails.
4. **The switched-off download code is still in the installer file.** Nothing stops it being switched back on without a signature check.
5. **Out of the pilot (decision 182, "yes, after the pilot"):** BUG-883, the installer has no first-install route (a PC with no CE cannot start from the installer), and BUG-888, an interrupted install can leave CE missing with no repair or uninstall. Both wait until after the pilot.

## 4. Tim's words
1. "yes" (decision 183, 31 Oct 2026): CEMARKUPRUN's automatic software download OFF by default; installer checks the WebView2 signature or bundles it; card first.
2. "yes, after the pilot. The pilot is a hand install." (decision 182, BUG-883 and BUG-888.)

## 5. Full experience (proposed)
**Part 1, CEMARKUPRUN (Structural)**
1. **Trigger:** unchanged (CEMARKUPRUN, and markup batches that use the local worker).
2. **Switch OFF (default):** unchanged. Plain stop message (section 2 item 2). CE also writes one line to the CE log: which helpers were missing. Nothing downloaded.
3. **Switch ON:** before anything is fetched, one command-line line: "CE is downloading three Python helpers (pyautocad, comtypes, pywin32) from the internet. This can take a few minutes." Then a CE log line with the result (downloaded, or failed and why). Never silent.
4. **On failure:** the existing message, plus the log line. The markup step stops; nothing in the drawing is changed by the worker.
5. **Old PCs that stored ON:** see question 2. Recommendation: leave the stored value, but the Settings page shows the line "This downloads software from the internet" beside the tick, so a drafter can see what it does.
6. **Undo, save and reopen, locked layers:** not affected (no drawing change in this step).
7. **Settings switch:** "Say and record before downloading Python helpers", shipped ON. OFF = today exactly (silent when ON).

**Part 2, WebView2 (installer and hand install)**
1. **Recommendation: no download at all.** Do not switch the old download back on.
2. **At install, a read-only check:** is WebView2 present? (It only reads the Windows register; nothing is fetched or run.)
   1. Present: one line, "WebView2 found." Recorded in the install record.
   2. Missing: one plain warning, recorded in the install record, and the install carries on: "WebView2 is not on this PC. CE Help will open in your web browser instead of inside AutoCAD, and PDF markups may not load. Ask IT to install Microsoft's WebView2 runtime." Never silently continue; never block (R-27).
3. **For the pilot (hand install):** the same check is one step in page 02 (open Windows Settings, Apps, look for "Microsoft Edge WebView2 Runtime"). The installer-program version of the check comes with BUG-883, after the pilot.
4. **If Tim prefers CE to install WebView2 itself (question 3):** ship Microsoft's own offline WebView2 installer inside the package (no internet), check its digital signature is Microsoft's before running it; if the check fails, do not run it, warn in plain words, record it, and finish the rest of the install.
5. **First use:** unchanged from section 2 items 3 and 4.
6. **Guard:** a test that fails if the installer ever contains an internet download again.

## 6. Example set-ups and expected results (copies and test logins only)
1. **New PC, Structural, CEMARKUPRUN, helpers missing, switch OFF.** Expected: the plain stop message; a log line; nothing fetched.
2. **Same with the switch ON.** Expected: the "downloading" line first, then a log line with the result.
3. **Hand install on a login with WebView2.** Expected: page 02 check passes.
4. **Installer program (after the pilot) on a PC without WebView2.** Expected: one warning line, a line in the install record, install finishes, Help opens in the browser.

## 7. Guard tests and the checklist (proposal)
1. **Guards without AutoCAD:** CEMARKUPRUN switch defaults OFF through both Settings start-up reads (already true); with the new switch ON a "downloading" line comes before any download and a log line after; the installer has no internet download in any built part; the WebView2 check is read-only and its missing-WebView2 wording.
2. **Robot:** none useful. Uninstalling WebView2 or Python helpers on Tim's PC is not allowed. Proof is the guard tests plus one install rehearsal on a spare login.
3. **Not provable here:** what an office PC with locked-down internet does.

## 8. Open questions for Tim (each with a recommendation)
1. **Approve this card?** Recommendation: yes.
2. **PCs that stored "download automatically" ON before 9 Oct:** leave them, or switch them OFF once at the next start-up? Recommendation: leave them and make the Settings line say it downloads from the internet. Switching a drafter's own choice off behind their back would break a markup batch they rely on.
3. **WebView2: check and warn only (no download), or bundle Microsoft's signed installer?** Recommendation: check and warn only. Windows 11 already has it, the pilot is a hand install, and a 150 MB extra in the package is not worth it.
4. **Is Structural (and so CEMARKUPRUN) in Max's pilot at all?** Page 02 says Max has no Structural (not confirmed). If not, Part 1 is after the pilot too. Recommendation: Part 1 after the pilot if Max has no Structural.
5. **Delete the switched-off download code from the installer file?** Recommendation: no change now; the guard test stops it coming back. Removal can go with BUG-883 after the pilot.
