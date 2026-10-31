# Hand-over plan: install rehearsal, frozen copy, old-files move, final go checklist

**Owner:** CE 07 Release. Written Thu 29 Oct 2026, 11:17 Melbourne. **DRAFT. Nothing in this file has been done, published, copied or sent.** Every step that copies a file to an office folder, a USB stick or Max's PC needs Tim's word in chat first (RULES, publishing).
**Read for this plan:** colleague-pack page 02, TEAM_AUDIT_T5_24OCT.md, RELEASE_9NOV_TODO_FROM_T5_2026-10-24.md, ROLLBACK_GUIDE_2026-10-07.md, BUG-483, BUG-1165 to BUG-1170, the gap plan, and (read-only today) Tim's installed bundle folders and the all-users plug-in folders.

---

# FOR TIM

1. **The route is a hand copy.** The desk copies two folders (Civil and Manager) into Max's own AutoCAD plug-in folder with AutoCAD closed. No administrator rights are needed for that copy (the Team audit read the code and agrees). About 10 to 20 minutes on the day.
2. **It has never been tried on a normal login.** I need one spare standard Windows login to practise it twice, and the going-back steps once. Without that, 16 Nov is a guess. Recommendation: a new standard user on the spare work PC you offered on 17 Oct.
3. **A fact I found today that matters.** Your PC runs two other CE add-ins beside Civil and Manager (CE.AutoCADLink.2027 and CE.Transform.Trial.2027). Max's PC will not have them, and CE 01 recommends we do not add them (they are test bundles). Every robot and Codex test so far ran WITH them, so we are testing a setup Max will not have. CE 02 will re-run the key cases once with both moved aside, and the rehearsal login shows what Max's setup does.
4. **Old-files move (BUG-483).** The old July install scripts and builds still sit in the IT Admin folder, and a normal user would hit them first. Moving them to an OLD folder needs your yes, and one check first: does anyone still install from them today?
5. **Questions for you** (each as a numbered item for CE 04): Max's AutoCAD year and rights, the spare login, the frozen-copy folder, the old-files move, the pack approval. Nothing is sent to Max by me.

---

# DETAIL

## 1. What goes to Max (the package)

1. **Two folders only, taken from the frozen candidate:** `CE_CVL_SUITE.bundle` (Civil) and `CE_SUITE_MANAGER.bundle` (Manager). They go in together every time; they share one file (CE_SHARED) and one new with one old stops the CE ribbon loading.
2. **Today's candidate matches Tim's installed bundle exactly:** `C:\ce_rc_scratch\c1071`, Civil 3.0.85 and Manager 1.1.85, commit 09126560, 903 files, the six main DLLs (Legacy, Modern, Net8 for each) have identical SHA-256 to the installed ones (read 29 Oct about 11:15). The real frozen folder will be the Fri 6 Nov freeze candidate (C-76, C-77 and the pilot-critical builds), not this one.
3. **Not in the package:** Structural (stays on Tim's PC, ruling B3), the old July scripts, Tim's settings file as it stands (it carries his folder paths, BUG-1167).
4. **The two extra add-ins on Tim's PC (answered by CE 01, ADDON_BUNDLES_NOTE_29OCT.md, from manifests and source only, nothing run): do NOT add them to Max's package.** `CE.Transform.Trial.2027` is a two-command test bundle (CETESTCR, CETESTMR) and Civil ships its own `CE_TRANSFORM_2027.arx`. `CE.AutoCADLink.2027` is a synthetic read-only test adapter that loads at start; no Civil or Manager source mentions it. Both are AutoCAD 2027 only. **Not proven:** whether REDO, selection, UCS or transform behave the same without them. Only the BUG-861 control run (Tim said yes 29 Oct) and the spare-login rehearsal prove it. All robot and Codex results so far had both loaded. A Max-like re-run is a line in the test plan (check B9). If a 2022 to 2024 "enabler" is needed (BUG-1137, BUG-1138, BUG-1151) that is a separate question for CE 01.
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
2. **R2 (Tue 3 Nov on the current build; again Sat 7 or Sun 8 Nov on the freeze candidate):** the same; then **R3 rollback once on each.**
3. **Who drives:** a person following the steps, or Codex driving the spare login (a new standard user can be signed in on the spare PC by Tim; I do not set this up). Evidence is the screenshots and the command lines, saved to the results folder.
4. **If Max is not on 2027:** repeat R2 on his year if a PC with that year exists; otherwise the pack says so in plain words and BUG-1209 and BUG-1210 go on page 04.
5. **Windows Sandbox** is a possible fallback (T5 to-do 12: switch the feature on). I believe the Sandbox user holds administrator rights and has no AutoCAD licence, so it would test the copy and the folder only, not a standard user's AutoCAD. **I have not verified this.** Tim's call if the spare login falls through.
6. **Not done by me:** creating the login, switching on any Windows feature, or touching Tim's bundles. I ask; Tim or IT does it.

## 6. Frozen release copy

1. **Source:** the candidate folder of the freeze build (Fri 6 Nov), for example `C:\ce_rc_scratch\c1072`. Never rebuilt for Max; the seal (#1649, built, not installed) would refuse any file whose hash differs.
2. **Make the frozen copy on Tim's PC first (not publishing):** copy the candidate's two bundles to a new local folder, set it read-only, write a manifest of every file with its SHA-256 (`SHA256SUMS.txt`, made with Get-FileHash, one command, no new script), and read the six DLL version strings back. The manifest is the proof for the Fri 6 Nov go checklist.
3. **Compare with the installed bundle:** the installed bundle on Tim's PC (the version he has used during the soak) must hash equal to the frozen copy, file for file, on Fri 6 Nov and again on Fri 13 Nov. A difference means a deploy changed it and the soak is invalid (HARD RULE in the repo notes).
4. **Where the shared copy sits (publishing, Tim's word):** recommended `CE V3 PILOT`, a new folder separate from the IT Admin folder, shared "can view" to Max only. USB stick is the alternative. Placing the folder is publishing: I do not do it. Tim says the folder and "yes, copy it".
5. **Undo:** delete the `CE V3 PILOT` folder (one folder; nothing else references it). The local frozen copy stays as the record.
6. **Hash record kept in:** `C:\CE_PLAN\areas\RELEASE_FROZEN_MANIFEST_<build>.md` (the manifest summary only, not the files).

## 7. Old-files move (BUG-483)

1. **What is there (read 29 Oct):** the IT Admin folder holds `Install-All-CE-Plugins.ps1`, folders `CE CVL SUITE`, `CE STR SUITE`, `CE SUITE MANAGER`, and `CE_CVL_SUITE_Installer_v2.1.11.exe`, with bundles at Civil 2.1.14, Structural 1.0.41 and Manager 1.0.0 (carpark BUG-483, 9 Oct; I listed folder names today and did not open the files).
2. **Why it matters:** a script there asks for administrator rights, installs old copies into the all-users folder, and says updates are automatic (false). Max running one would put an old Manager that loads first.
3. **Proposed move:** those items into `IT Admin\OLD`, nothing deleted. **Tim's yes first,** plus one check he alone can make: **does any colleague still install from them today?** Page 06 question 5 says other colleagues use the July copies; moving them would stop that route.
4. **Undo:** move them back; the folder contents are unchanged.
5. **Done by:** Tim, or the desk after his written yes. Not today.

## 8. Final go checklist for Fri 13 Nov (pilot Mon 16 Nov)

Each line is ticked by the owner named, with the evidence filed in RELEASE_SCOREBOARD.md.

1. **Frozen copy hashes equal the installed bundle** (CE 07).
2. **Civil and Manager CE_SHARED identical in all three lanes** (CE 07).
3. **Rehearsals R1, R2 and R3 done;** times and prompt text recorded (CE 07 / spare login).
4. **Pass line in RELEASE_TEST_PLAN_29OCT.md section 3 all met** (CE 02 reports the robot and Codex lines).
5. **No new serious bug on Tim's PC since the freeze install on Fri 6 Nov** (Tim's soak; CE 05 carpark check).
6. **Known-problems page final from the frozen build's results** (CE 07 drafts, Tim approves).
7. **Pack approved by Tim in one pass** (CE 04).
8. **Max's facts recorded** (year, rights, folders, Structural, Manager, OneDrive, results folder) (CE 07).
9. **Old-files move decided** (Tim). **Frozen-copy folder decided** (Tim).
10. **Opus freeze report: what passed, what is known, how to roll back** (CE 07 asks CE 00 to run it).
11. **Tim's words in chat: "yes, hand it to Max"** and the date. Nothing is copied or sent before that.
12. **Mon 16 Nov:** AutoCAD closed, hand install by Tim with the desk on the line, five-step walk, page in Max's hand, daily check-in for the first week.

## 9. What I did NOT verify

1. I read folder names and DLL versions only; no file was copied, renamed or opened for write.
2. The no-administrator claim for the hand copy rests on the Team audit's reading of the code and on %APPDATA% being the user's own folder; it is not rehearsed.
3. I did not open any old script in the IT Admin folder.
4. Whether Max's PC runs the two extra add-ins, WebView2, or which Windows rights, is Unknown.

## 10. Update 29 Oct: rollback and drawings (from the pack change list job)

1. The pack's line "Your drawings are safe either way" after a rollback is not true (BUG-1135: an older CE deletes newer parts of the job record when it saves). Until the pack says otherwise, step 7 of the rollback section 4 gains: "Do not open and save a drawing in the old version that you worked on in the new version."
2. Rehearsal R3 therefore includes: work a drawing copy in the new build, roll back, open and save that copy in the old build, return to the new build, and note what is missing from the record.

## 11. Test laptop with AutoCAD 2026 (Tim, 29 Oct: "can i do on a laptop with 2026 installed?")

**Status:** an assessment only. Nothing is installed on any other PC without Tim's word. The robot-driver half is CE 02's; the install-rehearsal half is mine. Questions go to CE 04 only.

1. **Which part of CE a 2026 laptop runs (read from the installed Civil bundle's PackageContents.xml, 29 Oct):** AutoCAD 2022 to 2024 load the `Legacy` folder; AutoCAD 2025 and 2026 load the `Net8` folder (series R25.0 to R25.9); AutoCAD 2027 loads the `Modern` folder, and only 2027 also loads the two native files (`CE_CVL_NATIVE_GRIP_2027.arx`, `CE_CVL_OBJECTS_2027.dbx`). I read the file; I did not run anything. I believe 2026 is series R25.1 but the laptop's own `ACADVER` or About will say.
2. **So the laptop tests the Net8 lane, not Tim's 2027 lane.** The gap plan (22 Oct) and the Team audit say nothing on these builds has been driven in AutoCAD 2022 to 2026. Expect new findings; some may be 2026-only (no native pipe object files there). That is valuable if Max is on 2025 or 2026, and a warning if he is not, because green results on the laptop would not carry to a 2027 Max.
3. **What the laptop gives the release:** the real hand-install rehearsal (R1 to R3) on an ordinary profile, the first start on a fresh profile with a clean CE log (A4), whether AutoCAD asks "Load / Always Load", whether WebView2 windows open, and the rollback including the BUG-1135 drawing-record check.
4. **What it needs (my side):** a Windows login that is NOT an administrator (a standard user, even if the laptop has an administrator for setup); AutoCAD 2026 signed in and licensed for that user; Microsoft Edge WebView2 present (check, do not assume); the frozen or candidate folder delivered by USB or a synced folder (not a downloaded zip); a way to read back files and the CE log (CEMANAGERLOGS) and to copy screenshots to the results folder. **No Tim settings file** (it carries folder paths, BUG-1167) and no keys; the write keys never leave Tim's PC (RULES 11.6a).
5. **What it needs (CE 02's side, to be confirmed by them):** the robot driver, case runner and settings guard were built against 2027 (AutoCAD path, window names, the pointer calibration, the allow-lists); each would have to be checked against 2026 before a case runs there; a Claude session on the laptop with read access to C:\CE_PLAN (a private repository) and to the driver folder, which means a GitHub login and a Claude login on that laptop. I do not know how long that takes; CE 02's estimate decides whether the laptop does the robot's job or only the install rehearsal and Codex looks.
6. **Private data:** client drawings never go to the laptop (RULES 11). Test fixture drawings only; Tim's own CE settings and log files stay on his PC.
7. **Questions for CE 04 (sent):** whose laptop; Windows user type (is there an administrator and can a standard user be added); AutoCAD 2026 sign-in (whose Autodesk account, and does a second sign-in sign anyone out elsewhere); when it is available (free windows), and for how many nights; can it stay powered on, awake, with the lid open overnight; network access (internet, OneDrive for "Creative Engineering - Drafting", GitHub for the plan repository); may a Claude session run on it, and under whose login; whether the laptop also has AutoCAD 2027 or any older CE copy.
8. **Rehearsal use if the answer is yes:** R1 on the current 3.0.85 build as soon as the laptop is ready; R2 and R3 on the freeze candidate Sat 7 or Sun 8 Nov.

### 11a. CE 02's answer on the laptop (29 Oct; TESTING_SPEED_OPTIONS_29OCT.md addendum and TEST_LAPTOP_STEPS_29OCT.md)

1. **Yes, as a 2026-only test machine, never a 2027 pass** (every result labelled "2026 / Net8 lane"). About 3 working days after Tim says yes, plus about 45 minutes of his time; earliest ready **Tue 3 Nov** if he answers on Fri 30 Oct.
2. **Stop at step 1 if the licence check fails:** the name at the top right of AutoCAD 2026. If it is Tim's own Autodesk login, a robot start could sign him out of his 2027. The office admin checks seats at manage.autodesk.com.
3. **For now the laptop does:** my install rehearsal R1 (and R2, R3 when the freeze candidate exists), a first 2026 check, and Codex looks. The robot runs there nightly only once Max's AutoCAD year is known and about 1 day of reviewed runner changes is done (the runner refuses anything but 2027, its working-hours stop applies on any PC, and its build check would log a 2026 run as 2027).
4. **A difference that matters to the pack:** on 2026 the pipes stay ordinary polylines (what colleagues on 2025/2026 get); about 20 of the 85 robot checks read differently. If Max is on 2025 or 2026 the pack must say so.
5. **Setup steps for the laptop** (a standard login "CE Test", power settings, auto sign-in, installs) are security settings: the office admin does them, never a chat. Client-identifying fixture drawings go by USB only, never a synced folder.
6. **What I add to the release plan:** (a) Tim's word "yes, install CE on the laptop" is needed before any copy; (b) rehearsal evidence from the laptop counts for the Net8 lane only; (c) if Max is on 2027, one more rehearsal is still needed on a 2027 machine with a normal login (Tim's own PC cannot show that); the hand-copy steps are the same, and the cheapest 2027 option is to do it on Max's own PC on the day before the hand-over, with the pack's rollback ready.

## 12. UPDATE after Tim's afternoon answers (29 Oct, decisions\2026-10-29_TIM_ANSWERS.md items 24 to 34). This section overrides anything above that says otherwise.

1. **Max's AutoCAD year:** 2022 today; he "will have 2027" before the pilot (Tim). **The pilot is 2027 only.** The pack stays on 2027. Nothing is installed on Max's PC before his 2027 is in. His install rights and the date of the upgrade are Unknown: new question 36 for Tim (through CE 04). If his 2027 is not in by about Fri 13 Nov, the hand-over on Mon 16 Nov cannot be done on his own PC. BUG-1209 and BUG-1210 stay on page 04 only as a note for anyone on an older year.
2. **The 2026 laptop (section 11 and 11a) is DROPPED** (Tim: "i will get 2027 on another pc"). Do not act on 11 and 11a; the licence and sign-in checks there still apply to whichever machine it becomes. The rehearsal machine is a PC with AutoCAD 2027 and an ordinary (non-administrator) login that Tim organises ("i will organise"). **No rehearsal starts until Tim says the login exists and which PC it is** (new question 37). The robot driver was built for 2027, so this machine can also run the robot at night. It needs an unlocked live desktop with no lock or sleep (CE 08 / CE 02's step 4b). The office has spare AutoCAD licences (year and who assigns them are not stated).
3. **This closes the "no 2027 normal-login rehearsal" gap** in principle (R1 to R3 on a 2027 machine), once the PC and login exist. R1 on the current 3.0.85 build as soon as it is ready; R2 and R3 on the freeze candidate Sat 7 or Sun 8 Nov.
4. **Frozen build:** "the latest version ideally" = the latest reviewed build installed on Fri 6 Nov; nothing frozen early.
5. **Frozen copy folder (section 6 item 4): APPROVED as the place** (Tim: `CE V3 PILOT`, shared "can view" to Max only, July copies untouched). It is created and shared only at the packaging step after the freeze (planned Tue 10 Nov), with the desk saying so first. Until then nothing is placed there. Sharing "can view" to Max needs his account name: Tim to give it at that step.
6. **Gate list (section 8):** Tim confirmed the administrator set-up (gate 1) and ruled Structural out, so gate items 6 and 7 are out. Go checklist item 9 now reads: old-files move decided (Tim) only; the frozen-copy folder is decided.
7. **Build list, from Tim's rulings:** BUG-905 ON (0.9), BUG-1097 head left after losses (still a warning), BUG-1095, 1091 and 1088 all built before the freeze. They sit in CE 01's list.
8. **Still open for Tim:** the old-files move (item 25), Max's old July Structural (item 30; moot until 2027 goes in), the pack approval (item 29), Max's install rights and upgrade date (item 36), the rehearsal PC (item 37).

## 13. UPDATE 29 Oct, after Tim's item 69 (cut-off Fri 13 Nov; this section overrides earlier dates)

1. **The pilot build** is the newest build that has passed review and testing on Fri 13 Nov. The earlier "freeze Fri 6 Nov" in sections 6 and 8 is superseded.
2. **Frozen copy (section 6):** made at packaging from about Wed 11 Nov from the build then installed and tested; rebuilt and hash-checked after any later fix (about 1 hour), so it always equals the newest tested build. The hash manifest is dated and versioned each time. The compare with the installed bundle on Tim's PC is repeated on Thu 12 and Fri 13 Nov. The `CE V3 PILOT` folder is created and shared "can view" to Max only after Tim's word on Fri 13 Nov.
3. **Rehearsals (sections 3 to 5):** R1 on the current build as soon as the second 2027 PC and ordinary login exist; R2 and R3 on a build from Wed 11 Nov (the package build), repeated if the package changes by more than an area fix.
4. **Final go checklist (section 8) is ticked Fri 13 Nov;** item 5 reads "no new serious bug on Tim's PC since the last full-class install". Each item in the pilot carries "tested" or "not tested" in the release note (Tim's item 68). Hand-over Mon 16 Nov.

## 14. Addition Fri 30 Oct 12:16: pilot risk items in the final go checklist (from PILOT_RISK_PLAN_30OCT.md, via CE 00 12:50)

1. Add to the §8 go checklist: for BUG-1227, BUG-1088, BUG-1095, BUG-1251 and BUG-1255 the shipping build either has a passed named proof (robot case or Codex look, two clean starts where robot) or page 04 names the fault with its workaround. Page 04 wording for BUG-1227 is "place the copy well clear (5 m was safe; 0.1 mm was not)", not "a small offset". Status of each is in RELEASE_SCOREBOARD section 2, item 3a.
2. Max's AutoCAD year stays a gate: if it is not 2027 by Fri 13 Nov, BUG-1209 and BUG-1210 apply and the pilot waits.

## 15. Addition Sat 31 Oct 07:33: Tim's spoken answers (decisions 130 to 139) change the hand-over (CE 07)

Source: decisions\2026-10-29_TIM_ANSWERS.md items 130 to 140 (Tim's words in quotes there). Nothing below is sent to Max; everything below is for Tim.

1. **Install on Max's PC, Mon 16 Nov 08:40: Tim does it** ("1me"), about 20 minutes, following page 02, the desk on the line. **I owe:** page 02 rewritten as the exact steps for Tim (not for Max), with the one-line undo; Tim's own settings are not touched.
2. **Old Manager in Max's all-users folder: Tim checks** ("2me but youll need to run me through it"). **I owe:** a plain step-by-step with exact clicks, ready by Mon 9 Nov, for the check in the week of Mon 9 Nov. Remember BUG-1165: the old copies in the all-users folder must go before the install.
3. **Max's July Structural: rename its folder to .backup before install day** ("3yep"). **I owe:** the rename as a step in Tim's install-day list, and the undo (rename back).
4. **First week on COPIES of live jobs** ("4yes"); real jobs only after Codex has passed the pilot build and 5 working days with no new bug. **I owe:** one line on page 01 and page 05.
5. **Share 'CE Plugin Pilot Results' with Max as 'can edit', with a walk-through on the day** ("5yes run me through on the day what i need to do"). **I owe:** the exact SharePoint steps (Share, Max's name, can edit) for Mon 16 Nov. This is separate from the 'CE V3 PILOT' folder (can view) that carries the build copy; that one is created only after Tim's word on Fri 13 Nov.
6. **Reply time** ("6yes"): same working day for anything that stops him, a weekly Monday session for the rest. One line on page 05.
7. **CDRULES wins over the Inspector** ("7cdrules"): page 04 tells Max to trust CDRULES.
8. **Pages 01 and 05 printed as one-page sheets; page 02 stays on screen** ("8yes").
9. **Screenshots on page 02 by Codex on a test copy, Wed 11 to Fri 13 Nov, on the pilot build** ("9yes"): part of packaging.
10. **Max's first 10 minutes: he does nothing but use it** ("10dont make max do anything else apart from use it he is busy"): no practice drawing, no setup steps.
11. **NOT answered: the pack approval (129) and the pack wording (140): the 97 changes in RELEASE_PACK_CHANGES_FOR_APPROVAL_29OCT.md and the CE 00 approval sheet stay DRAFT.** I do not edit pages 01 to 06 until Tim says.
12. **Product facts for page 04 (from decisions 118 to 128): the Grade mismatch window is to be replaced by a plain warning line (build not started in C-78); colleagues' New Pipe starts in Custom 1 in 100; the raingarden label is plain 'RG' (in C-78); a What's New window opens on the first start after an update (seen in C-78); the Checks window changes (gold banner, one grey line for passes) and a new Settings tab 'Switches' arrives; cover is measured to the outside top of the pipe everywhere.** Each is in the pilot build only if built and tested by the Fri 13 Nov cut.

## 16. Addition Sat 31 Oct 22:07: release note with per-item tested / not tested (Tim's item 68)

1. Source of each line: the ACCEPTANCE_LEDGER (a case accepted by name = robot PASS plus Codex PASS, on a named build), the run reports for the pilot build, and each PR's own 'what is NOT proven' lines.
2. Each pilot-build item is listed as **tested** (named case, build), **partly tested** (what part), or **not tested** (and the page 04 workaround where one exists), in Tim's plain words, no case ids on the page Max reads.
3. Produced by the Opus release report on Thu 12 Nov, refreshed on Fri 13 Nov when the cut names the build; part of the pack Tim reads only if he wants (decision 140). Nothing in it is sent to Max without Tim's word.
