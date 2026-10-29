# Hand-over plan: install rehearsal, frozen copy, old-files move, final go checklist

**Owner:** CE 07 Release. Written Thu 29 Oct 2026, 12:05 Melbourne. **DRAFT. Nothing in this file has been done, published, copied or sent.** Every step that copies a file to an office folder, a USB stick or Max's PC needs Tim's word in chat first (RULES, publishing).
**Read for this plan:** colleague-pack page 02, TEAM_AUDIT_T5_24OCT.md, RELEASE_9NOV_TODO_FROM_T5_2026-10-24.md, ROLLBACK_GUIDE_2026-10-07.md, BUG-483, BUG-1165 to BUG-1170, the gap plan, and (read-only today) Tim's installed bundle folders and the all-users plug-in folders.

---

# FOR TIM

1. **The route is a hand copy.** The desk copies two folders (Civil and Manager) into Max's own AutoCAD plug-in folder with AutoCAD closed. No administrator rights are needed for that copy (the Team audit read the code and agrees). About 10 to 20 minutes on the day.
2. **It has never been tried on a normal login.** I need one spare standard Windows login to practise it twice, and the going-back steps once. Without that, 9 Nov is a guess. Recommendation: a new standard user on the spare work PC you offered on 17 Oct.
3. **A fact I found today that matters.** Your PC runs two other CE add-ins beside Civil and Manager (CE.AutoCADLink.2027 and CE.Transform.Trial.2027). Max's PC will not have them unless we put them there. Every robot and Codex test so far ran WITH them. So we are testing a setup that Max will not have. The rehearsal login shows what Max's setup does. This goes to the build session as a question (item 3 below).
4. **Old-files move (BUG-483).** The old July install scripts and builds still sit in the IT Admin folder, and a normal user would hit them first. Moving them to an OLD folder needs your yes, and one check first: does anyone still install from them today?
5. **Questions for you** (each as a numbered item for CE 04): Max's AutoCAD year and rights, the spare login, the frozen-copy folder, the old-files move, the pack approval. Nothing is sent to Max by me.

---

# DETAIL

## 1. What goes to Max (the package)

1. **Two folders only, taken from the frozen candidate:** `CE_CVL_SUITE.bundle` (Civil) and `CE_SUITE_MANAGER.bundle` (Manager). They go in together every time; they share one file (CE_SHARED) and one new with one old stops the CE ribbon loading.
2. **Today's candidate matches Tim's installed bundle exactly:** `C:\ce_rc_scratch\c1071`, Civil 3.0.85 and Manager 1.1.85, commit 09126560, 903 files, the six main DLLs (Legacy, Modern, Net8 for each) have identical SHA-256 to the installed ones (read 29 Oct 11:20). The real frozen folder will be the Sat 31 Oct candidate (C-76 plus C-77), not this one.
3. **Not in the package:** Structural (stays on Tim's PC, ruling B3), the old July scripts, Tim's settings file as it stands (it carries his folder paths, BUG-1167).
4. **Open question for CE 01 (also to CE 00):** do `CE.AutoCADLink.2027.bundle` (dated 23 Jul) and `CE.Transform.Trial.2027.bundle` (7 Sep) belong in Max's package? One note in the Desk records says the first has no event hooks and the second was examined for the REDO bug, but I found no statement that a Max install works without them. The BUG-861 control run (Tim said yes today) moves them aside on Tim's PC; its result answers whether REDO behaves without them. If they are needed for a 2022 to 2024 year ("enabler", BUG-1137, BUG-1138, BUG-1151) that must be in the package list too.
5. **WebView2:** the installer program installs the Microsoft WebView2 runtime and sets AutoCAD's trust setting; a hand copy does neither (T5 to-do item 9). I have not found a statement of which CE windows need WebView2. The rehearsal must open every window Max uses and note any blank one. Rehearsal check, not a claim.

## 2. Facts to gather about Max's PC (all Unknown today)

1. **AutoCAD year.** Max types ABOUT in AutoCAD (or reads the title bar) and tells Tim. The pack says 2027 (INT-069); nobody has looked. 2022 to 2024 have never been driven with this build, and BUG-1209 and BUG-1210 apply there.
2. **Windows rights.** Can he install programs? The hand copy does not need it, but removing an old copy in the all-users folder does.
3. **His plug-in folders.** `%APPDATA%\Autodesk\ApplicationPlugins`, `C:\ProgramData\Autodesk\ApplicationPlugins` and `C:\Program Files\Autodesk\ApplicationPlugins`: names of any `CE*` folder and whether each holds a file named exactly `PackageContents.xml` (T5 finding 1, BUG-1165).
4. **His old Structural (July 1.0.41):** version, date, whether it holds its own CE_SHARED. Recommended: switch it off (CEMANAGER, Disable on Restart) or move it aside before the first start (BUG-1169).
5. **His Manager version** (older than 22 Jul means a rollback needs the ProgramData check, BUG-1170).
6. **OneDrive:** where "Creative Engineering - Drafting" lands on his PC and that it shows fully synced before his first AutoCAD start (BUG-1166, BUG-1168).
7. **WebView2 runtime present** (Settings, Apps). Rehearsal compares.
8. **Write access** to the CE Plugin Pilot Results folder (page 06 question 11).
9. **How:** one 3-line message from Tim to Max (Tim's to send; a draft goes in the pack changes file). I send nothing.

## 3. Hand install, step by step (for an ordinary Windows login, no administrator)

**Who:** Tim or the desk person, at Max's PC. AutoCAD closed (check Task Manager for acad.exe, twice). **Time:** 10 to 20 minutes.

1. **Before you sit down:** the frozen folder is on a USB stick or the synced pilot folder (not a downloaded zip, BUG-1176). Note the build numbers Tim gave you.
2. **Check AutoCAD is closed** (Task Manager, Details, no `acad.exe`). Wait a minute and look again.
3. **Read Max's facts (section 2),** especially the all-users folders. If a CE `.bundle` there still has a file named exactly `PackageContents.xml`, **stop and tell Tim** (on Tim's own PC the stale Manager 1.0.0 copy has that file renamed `PackageContents.xml.DISABLED-duplicate-appdata-wins`, so it does not load; the same renamed file is the safe state on Max's PC if he has one).
4. **Copy the settings aside:** each of `%APPDATA%\TIM_CE_CADTOOLS`, `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_CADTOOLS`, `%APPDATA%\Creative Engineering\CE Suite Manager`, `%APPDATA%\CE_SUITE_MANAGER\logs` to the same place with `_PRE_V3` on the end (skip any that do not exist).
5. **Open** `%APPDATA%\Autodesk\ApplicationPlugins` in File Explorer.
6. **Rename any existing** `CE_CVL_SUITE.bundle` and `CE_SUITE_MANAGER.bundle` by adding `_PRE_V3.backup` to the end. The `.backup` name keeps AutoCAD from loading it. (Tim's PC uses names like `CE_CVL_SUITE_PRE_<commit>_<date>.backup`; either works, Manager ignores `.backup` folders, T5 item 21.)
7. **Leave the Structural folder alone** unless Tim says otherwise (section 2 item 4).
8. **Copy in the two new folders from the frozen folder** (both, in one go).
9. **Read back:** compare the file count and the SHA-256 of the six main DLLs and CE_SHARED.dll with the manifest in the frozen folder. Any difference: stop, copy again, tell Tim.
10. **Start AutoCAD.** If it asks whether to load the CE files, write down the exact wording and choose "Always Load" (the choice is Tim's to confirm on the rehearsal, T5 item 12).
11. **Check:** CE ribbon tab appears; type `CEHEALTH` (every line `[OK]`); type `CE_VERSION` (About shows Civil and Manager at the numbers Tim gave); Structural shows "Not loaded". Open the CE log folder (`CEMANAGERLOGS`) and read the first start for error lines.
12. **Five-step walk with Max:** PIT, CD, Edit Pipe, Pit Schedule, CDFEEDBACK, on a COPY of a drawing, not a real job.
13. **Tell Max** the three rules on page 01: copies only for the first week, which buttons not to press (Roll Back, update, Set up CE administrator, Admin Dashboard, CEMANAGERDIAG, the support bundle), and how to report (CDFEEDBACK).
14. **Write down** the time, the build numbers, any prompt text and anything odd in a short note for the results folder.

## 4. Rollback (for the same login)

1. Close AutoCAD; check Task Manager.
2. In `%APPDATA%\Autodesk\ApplicationPlugins`, add `.REMOVED.backup` to the end of the two new folders (rename, do not delete).
3. Take `_PRE_V3.backup` off the two old folder names (if there were none, there is nothing to restore; the machine goes back to no CE).
4. If settings look wrong, put the five `_PRE_V3` settings folders back, all five, so no 3.0 folder is left.
5. If the CE Manager pull-down menu stays with no commands behind it (BUG-1173): `MENULOAD`, find `CE_SUITE_MANAGER_MENU`, unload it.
6. Start AutoCAD; `CEHEALTH`.
7. **Never press Manager's Roll Back Release button.** Rollback by hand is the only supported route.

## 5. Rehearsal plan (needs the spare standard login)

1. **R1 (target Fri 30 Oct):** steps 2 to 11 of section 3 on the spare login with the CURRENT candidate (3.0.85 equals c1071), no administrator rights, AutoCAD 2027. Record: whether a Load prompt appears, the exact wording, WebView2 windows, CEHEALTH, CE log, time taken.
2. **R2 (Sun 1 Nov or Tue 3 Nov):** the same on the frozen candidate; then **R3 rollback once.**
3. **Who drives:** a person following the steps, or Codex driving the spare login (a new standard user can be signed in on the spare PC by Tim; I do not set this up). Evidence is the screenshots and the command lines, saved to the results folder.
4. **If Max is not on 2027:** repeat R2 on his year if a PC with that year exists; otherwise the pack says so in plain words and BUG-1209 and BUG-1210 go on page 04.
5. **Windows Sandbox** is a possible fallback (T5 to-do 12: switch the feature on). I believe the Sandbox user holds administrator rights and has no AutoCAD licence, so it would test the copy and the folder only, not a standard user's AutoCAD. **I have not verified this.** Tim's call if the spare login falls through.
6. **Not done by me:** creating the login, switching on any Windows feature, or touching Tim's bundles. I ask; Tim or IT does it.

## 6. Frozen release copy

1. **Source:** the candidate folder of the freeze build (Sat 31 Oct), for example `C:\ce_rc_scratch\c1072`. Never rebuilt for Max; the seal (#1649, built, not installed) would refuse any file whose hash differs.
2. **Make the frozen copy on Tim's PC first (not publishing):** copy the candidate's two bundles to a new local folder, set it read-only, write a manifest of every file with its SHA-256 (`SHA256SUMS.txt`, made with Get-FileHash, one command, no new script), and read the six DLL version strings back. The manifest is the proof for the Fri 6 Nov go checklist.
3. **Compare with the installed bundle:** the installed bundle on Tim's PC (the version he has used during the soak) must hash equal to the frozen copy, file for file, on Mon 2 Nov and again on Fri 6 Nov. A difference means a deploy changed it and the soak is invalid (HARD RULE in the repo notes).
4. **Where the shared copy sits (publishing, Tim's word):** recommended `CE V3 PILOT`, a new folder separate from the IT Admin folder, shared "can view" to Max only. USB stick is the alternative. Placing the folder is publishing: I do not do it. Tim says the folder and "yes, copy it".
5. **Undo:** delete the `CE V3 PILOT` folder (one folder; nothing else references it). The local frozen copy stays as the record.
6. **Hash record kept in:** `C:\CE_PLAN\areas\RELEASE_FROZEN_MANIFEST_<build>.md` (the manifest summary only, not the files).

## 7. Old-files move (BUG-483)

1. **What is there (read 29 Oct):** the IT Admin folder holds `Install-All-CE-Plugins.ps1`, folders `CE CVL SUITE`, `CE STR SUITE`, `CE SUITE MANAGER`, and `CE_CVL_SUITE_Installer_v2.1.11.exe`, with bundles at Civil 2.1.14, Structural 1.0.41 and Manager 1.0.0 (carpark BUG-483, 9 Oct; I listed folder names today and did not open the files).
2. **Why it matters:** a script there asks for administrator rights, installs old copies into the all-users folder, and says updates are automatic (false). Max running one would put an old Manager that loads first.
3. **Proposed move:** those items into `IT Admin\OLD`, nothing deleted. **Tim's yes first,** plus one check he alone can make: **does any colleague still install from them today?** Page 06 question 5 says other colleagues use the July copies; moving them would stop that route.
4. **Undo:** move them back; the folder contents are unchanged.
5. **Done by:** Tim, or the desk after his written yes. Not today.

## 8. Final go checklist for Fri 6 Nov

Each line is ticked by the owner named, with the evidence filed in RELEASE_SCOREBOARD.md.

1. **Frozen copy hashes equal the installed bundle** (CE 07).
2. **Civil and Manager CE_SHARED identical in all three lanes** (CE 07).
3. **Rehearsals R1, R2 and R3 done;** times and prompt text recorded (CE 07 / spare login).
4. **Pass line in RELEASE_TEST_PLAN_29OCT.md section 3 all met** (CE 02 reports the robot and Codex lines).
5. **No new serious bug on Tim's PC since Mon 2 Nov** (Tim's soak; CE 05 carpark check).
6. **Known-problems page final from the frozen build's results** (CE 07 drafts, Tim approves).
7. **Pack approved by Tim in one pass** (CE 04).
8. **Max's facts recorded** (year, rights, folders, Structural, Manager, OneDrive, results folder) (CE 07).
9. **Old-files move decided** (Tim). **Frozen-copy folder decided** (Tim).
10. **Opus freeze report: what passed, what is known, how to roll back** (CE 07 asks CE 00 to run it).
11. **Tim's words in chat: "yes, hand it to Max"** and the date. Nothing is copied or sent before that.
12. **Mon 9 Nov (or 16 Nov):** AutoCAD closed, hand install by Tim with the desk on the line, five-step walk, page in Max's hand, daily check-in for the first week.

## 9. What I did NOT verify

1. I read folder names and DLL versions only; no file was copied, renamed or opened for write.
2. The no-administrator claim for the hand copy rests on the Team audit's reading of the code and on %APPDATA% being the user's own folder; it is not rehearsed.
3. I did not open any old script in the IT Admin folder.
4. Whether Max's PC runs the two extra add-ins, WebView2, or which Windows rights, is Unknown.
