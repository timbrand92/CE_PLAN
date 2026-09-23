# Area REL — Version 3 to colleagues (the staff release, Stage 6 of the master plan)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

**Two chats work this area (agreed 23 Sep):** `CE_ACAD / release-v3-colleagues / deploy / 01` does the installs Tim orders; `CE_ACAD / release-v3-colleagues / plan / 01` keeps this file, the decision file and the one Codex list. Neither edits the other's Codex list.

**Codex (23 Sep, 12:02):** the deploy chat drives Codex from the command line (`codex exec`, first run started 11:53, session `01a0cbf7-9dc0-71b3-bd5b-4d54dc73e0d1`), **one run at a time**, because installs and tests share one AutoCAD. The plan chat does not post into Codex sessions: Tim's desktop Codex session `01a0cbcd…` is him setting up a virtual machine. Tim allowed the plan chat to post into the test session; it is not needed while the deploy chat drives. **Log of messages this chat posted to Codex: none.**

Getting a Version 3 build from Tim's PC onto colleagues' PCs safely: which build, which colleagues, how it is packaged and installed, how it is rolled back, and what they are told. Opened 23 Sep 2026 for Tim's Tuesday 29 Sep target (`decisions\2026-09-23_V3_COLLEAGUE_RELEASE.md`).

The master plan's own definition of done for Version 3 (a standalone Civil install, a controlled pilot, help and rollback) is the long goal. **Tuesday is a first step towards it, not the whole of it.**

**Standing override until Tuesday 29 Sep (Tim, 23 Sep):** *"from now until tuesday we build, test and deploy whenever we need"*. Limits, confirmed by Tim (*"keep going, drop none of the limits"*): AutoCAD really closed, never under a Codex run, backups and read-back every time, publishing to colleagues still needs Tim's word.

**Working without Tim until Tuesday (Tim, 23 Sep: *"keep going WITHOUT MY INVOLVEMENT"*).** Claude's calls are recorded in the decision file. Things that need Tim wait in the list below, for Monday.

### Queued for Tim, Monday 28 Sep (do not ask before then)

1. **The pilot colleague's name** (on AutoCAD 2027) — Tim: *"I'll tell you Tuesday"*.
2. **Where the pilot copy sits**: a separate `CE V3 PILOT` folder in IT Admin is proposed. Placing it there is publishing, so it needs his word — part of Tuesday's 15-minute look.
3. **The 2022 check** — **Tim runs it himself on Tuesday, on his virtual machine with AutoCAD 2022** (replaces "Monday on a colleague's PC").
4. **Tuesday morning, 15 minutes** (Tim's choice): one page from Claude — what passed, what is hidden or not ready, a five-step check — then his yes.

## 2. Where the detail is

1. `decisions\2026-09-23_V3_COLLEAGUE_RELEASE.md` — Tim's goal and the open questions.
2. `MASTER_PLAN.md` Stage 6 (staff release) and section 13 (definition of 100%).
3. Plugin repo `docs\workflows\FIRST_COLLEAGUE_BUILD_2026-09-07.md` and `FIRST_COLLEAGUE_ISSUE_2026-09-07.md` — the 7 to 13 Sep colleague-release attempt by Codex. Never shipped. Its percentages are estimates, not acceptance.
4. Deploy register: GitHub issue #78. Status page: #24.

## 3. The facts, read from the drive on 23 Sep 2026 about 10:45am (not from any document)

### What colleagues are offered today — the shared "IT Admin" folder

Read from `Creative Engineering - IT Admin\` (OneDrive-synced), DLL product versions:

1. **Civil 2.1.14** (`049c4da1`, built 13 Jul 2026), all three AutoCAD lanes.
2. **Manager 1.0.2** (`6f835126`, 13 Jul 2026).
3. **Structural 1.0.40** (2024 and 2025/26 lanes) and **1.0.41** (2027 lane, 11 Aug 2026).
4. **Common library (CE_SHARED) 1.0.0** in all of them.
5. An older installer `CE_CVL_SUITE_Installer_v2.1.11.exe` (24 Jun) sits at the folder root.

**What each colleague actually has installed is Unknown.** No colleague PC is visible from Tim's.

### What Tim runs — `%APPDATA%\Autodesk\ApplicationPlugins\`

1. **Civil 3.0.0+d90659cf**, installed 23 Sep 09:36, all three lanes.
2. **Manager 1.1.0+96e7d76a**, with its common library hand-copied from Civil at each deploy.
3. **Structural 1.0.74+5d723d41 — AutoCAD 2027 only** as installed (its source builds all three lanes). **It does not use the common library at all** — isolated on 25 Aug (`isolate standalone runtime from CE_SHARED`). *Corrected 23 Sep: this line first said it used whichever copy AutoCAD loaded first; that was wrong.*
4. **Common library 1.1.0** in Civil and Manager.

**The saved main line's Structural is 1.0.42**: older than Tim's 1.0.74 by 128 changes, and it still uses the common library.

### How colleagues receive updates today

1. Their Manager 1.0.2, at AutoCAD start, quietly copies any **approved** build from the IT Admin folder and switches it on at their **next** AutoCAD start (`Plugin.cs` and `CeApprovedReleaseService.cs` at the imported 1.0.2 source, `c5250a11`).
2. It can approve a build for **named machines only** (a "canary") and later promote it to everyone. So a one-colleague pilot is possible with the existing machinery.
3. **Whether their automatic update still works is Unknown.** When the storage keys were reset for SEC-001 (July), a Manager configured for online storage would find no approved builds. Needs a check.
4. The certain route is the installer or `Install-CECvlSuite.ps1`, run by the colleague with AutoCAD closed.
5. Currently approved in `CE Plugin Admin\releases\`: Civil `2026.0420.1549` (approved 28 Apr) and Structural `1.0.117.0001` (28 Apr).

### What Tim has accepted in AutoCAD — recorded

Three items, all before 16 Sep (`PENDING_TESTS.md`, Accepted section). The 16 Sep test day mostly failed. **Nothing since has been recorded as accepted.** `d0ffe1a2` (16 Sep) and `d90659cf` (23 Sep) are installed and in daily use by Tim, which is evidence of use, not acceptance.

### Colleagues' automatic update — read 23 Sep, saved 11:13

1. **The Manager 1.0.2 bundle offered in the IT Admin folder carries an online-storage config with both a read link and an admin link filled in** (`Contents\Win64\Assets\Config\blob-config.json`; values not printed or used here).
2. **With that config present, Manager 1.0.2 looks for approved builds ONLY in online storage, never in the IT Admin folder** (`CeApprovedReleaseService.GetApprovedReleases` at `c5250a11`).
3. **Both storage keys were regenerated for SEC-001 in July**, and the admin link was confirmed dead then (memory record `sec-001-azure-sas-leak`). So colleagues' automatic updates are **very likely dead**. Not tested from here: that would mean using the link.
4. **Consequence for Tuesday — ruled:** the pilot colleague installs by hand, with AutoCAD closed (Tim, 23 Sep: *"By hand, AutoCAD closed"*). The canary route is not relied on; fixing automatic updates comes after Tuesday.
5. **Online storage, checked by the deploy chat 23 Sep (its message to this chat):** the read link in Tim's key drawer is **alive** (read and list only, expires 22 Sep 2027; a list returned 193 files). **What is published there is from 28 April and in the old single-version layout** (no 2022/2025/2027 split, no native modules). The deploy chat switched the read link on in Tim's installed Manager on Tim's word, found this, and on Tim's ruling **switched it off again** (all three lanes blanked, read back). **The online channel stays off until the current build is published there** — that needs the admin link (Tim's PC only) and Tim's word on the exact package. After Tuesday.
6. **The new Manager refuses old unsigned approvals** (read 23 Sep, `CeApprovedReleaseService` on `master`): an approval without the signed, pinned identity is rejected (*"This approval predates exact signed-content verification"*). So the pilot colleague's new Manager will **not** pull the April or July builds back over Version 3. **Latent flaw logged as BUG-165:** its version comparison would rank the old-style number `2026.0420.1549` as newer than `3.0.0`; only the signature check stops it.
7. **Who reads online storage at all (read from source 23 Sep):** only the OLD Managers (colleagues' 1.0.2 and Tim's installed `96e7d76a`), and only with a live read link. **The new Manager on `master` never reads it** (removed 8 Sep, `17748872`, "align runtime delivery with OneDrive"): it reads signed approvals in the OneDrive IT Admin folder only. Colleagues' 1.0.2 link was signed 28 Apr with the key replaced in July. **So publishing to online storage reaches no Version 3 user.** Tim told the deploy chat *"publish the current build so the channel can go back on"*; the two release chats agreed to **hold the upload** and put these facts to Tim first.
8. **Tim's own Manager tries to "update" Civil to the April build at every AutoCAD start** — `crash_trace.log` shows it 54 times since 7 Sep, last at 11:09 today — because `2026.0420.1549` sorts above `3.0.0` (BUG-165). **Observed to do nothing:** Civil stayed on Version 3 across those restarts (`d0ffe1a2` still installed at 09:34 today after the 08:45 attempt) and the queue folder holds no such entry. Friday's new Manager ends it.
9. **What would really give Version 3 an update channel:** a **signed** approval in the IT Admin folder, which needs the release signing key (not yet created). After Tuesday.
10. **Housekeeping, not urgent:** a dead admin link still sits in a folder every colleague syncs. It grants nothing once the key is rotated, but it should not be there. For Tim to decide after Tuesday.

### The packaging routes that already exist — no new script needed (read 23 Sep)

1. **Civil:** `Installer\build_installer.ps1` builds all three lanes and the installer. The transform module `CE_TRANSFORM_2027.arx` is still built by hand first.
2. **Manager:** its own project file packages a release bundle when built with `PrepareReleaseBundle=true` and `ApprovedCeSharedRoot` pointing at Civil's common library, and **stops if the library's hash differs**. That is the lane-matched library guarantee, built in.
3. **Structural:** `Modules\Structural\Installer\build_installer.ps1` exists at `60c41228` (not on `master`). Without its `-AutoCad2027OnlyTrial` switch it is meant to build all three lanes.
4. **Install on a colleague PC:** the existing `Install-CECvlSuite.ps1`, `Install-CESuiteManager.ps1` and `Install-CEStrucSuite.ps1` in the IT Admin folder copy each bundle into the user's plugin folder.
5. **Local install on Tim's PC:** `master`'s `Deploy-Local-AsAdmin.ps1` is **Civil only and does not sync the common library** (the three-plugin `-Module` version, `6f67f8ed`, exists only on `claude/perf001-on-live-trunk`; `master` took a different script on 15 Sep, `d4158953`). Friday's install therefore follows the 23 Sep method: backups by hand, library copied lane for lane, every hash read back.

## 4. The risks that decide the plan

1. **The shared common library.** Every CE plugin carries the same library and the first copy AutoCAD loads wins for all of them. A colleague given Civil 3.0 while keeping Manager 1.0.2 and Structural 1.0.41 (library 1.0.0) risks the CE ribbon silently not loading. **All three must move together, carrying the same library.**
2. **Mixed versions on one job.** Version 3 upgrades pipes into its own pipe object when a drawing is opened or drawn in. A colleague still on 2.1.14 opening that drawing has no enabler for that object. What they see is **not yet established** — probe first, then decide.
3. **AutoCAD 2022.** Colleagues run 2022 and 2027 (Tim, 23 Sep). The 2022 to 2024 lane of Civil 3.0 has no recorded AutoCAD check (PENDING_TESTS rows 18 and 19: "2024, never tested"), and this PC has AutoCAD 2027 only. Tim's Structural 1.0.74 has no 2022 lane at all.
4. **Known hazards on the installed build.** The CDWT crash (W4) has no established cause. The CD window layout fixes are not in it.
5. **The release script.** `build_installer.ps1` was broken until DEPLOY-01 (23 Sep) and still does not build the transform module (`CE_TRANSFORM_2027.arx`); it is built by hand.

## 4a. What stands between Tuesday and "most of Version 3" — checked 23 Sep 2026, saved 10:48

Tim asked: *"whats stopping us from getting the large majority of version 3 by tuesday?"*

1. **Not unfinished building on a shelf.** Every one of 17 built pieces named in `PENDING_TESTS.md` (branches of 16 to 19 Sep) was checked with `git merge-base --is-ancestor`: all 17 are already in `master` `b02f3ec7`, so all ship on Tuesday under Tim's "newest saved work" answer. The other branches not in `master` are 19 to 20 Sep rescue copies marked unfinished and unbuilt, 1,150 to 1,570 changes behind.
2. **Tim's AutoCAD check is the limit.** The 16 Sep test day recorded **37 faults** (`decisions\2026-09-16_TEST_DAY_RESULTS.md`, sections R, W, P, C7, L, T, D, G, TWL, F1). Fixes for many have been built and installed since. **None has been re-checked by Tim.** Until he has looked, whether they work is Unknown.
3. **Some areas have nothing recorded as built for Version 3.** The area files for H (pump stations), I (WSUD), J (overland flow) and others were opened 19 Sep with no items. This is "not recorded", not proof of "not built".
4. **The 2022 lane cannot be checked on this PC.** `C:\Program Files\Autodesk` holds **AutoCAD 2027 only** (read 23 Sep). No AutoCAD check of Civil 3.0 in 2022 is recorded anywhere.
5. **Proposed (not decided):** Claude pre-checks the 37 faults with AutoCAD running without a screen (the accoreconsole probe) in the free windows, so Tim only opens what passes; Tim then re-checks area by area in the order he set on 16 Sep (CDWT, CD, PIT, then H to L, then M). The Tuesday pilot colleague is on 2027; 2022 colleagues follow after one check on a real 2022 machine.

## 5. Items and status — the plan after Tim's answers of 23 Sep (proposed timings, not decisions)

Say Built / Tested / Installed / Tim-accepted separately, never a percentage.

1. **REL-00 Codex AutoCAD run, pass 1** — *Codex started 23 Sep around 11:10 on `d90659cf` (before the 11:26 install), recorded 2 PASS, 0 FAIL, 23 BLOCKED, the rest not reached, and paused while Tim prepares a virtual machine. Its report: `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_2026-09-23.md`. Its note: on this AutoCAD profile F2 runs `CLEAN` (it saved a test copy), so command history must be read another way.* — on the installed `3.0.0+b02f3ec7` (deployed 23 Sep 11:26 by `CE_ACAD / release-v3-colleagues / deploy / 01`; read back by this chat at 11:27, all three lanes, common library matching Civil and Manager lane for lane): start-up, release checks (three plugins, one common library), the never-run 18 Sep list, the 19 Sep overnight fixes V1 to V18, and the 37 faults of 16 Sep by name. List: `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md`. **Status:** list written 23 Sep; not started.
2. **REL-01 Freeze** — Civil and Manager are the saved main line (`master`) at the freeze, per Tim's *"Newest saved work"* and *"Newest saved for all three"*. Proposed: **Thursday 24 Sep, 5:30pm**, announced on register #78. **Structural = `codex/structural-ui-preservation-20260915` @ `60c41228`** (Tim, 23 Sep: *"Yours + Codex's 4 window fixes"*). **Status:** Proposed.
3. **REL-02 Fix what pass 1 finds** — one area at a time, CDWT, CD, PIT first (Tim, 16 Sep). Each fix lands on `master` before the freeze. **Status:** waiting on pass 1.
4. **REL-03 Package** — Thursday night: build all three plugins, all three AutoCAD lanes, one matching common library; full automated suite; package audit (hashes, every file present). **Status:** practice build done 23 Sep, started 11:36, last build finished by 11:42 — nothing installed, installed plugins read identical before and after:
   - **Civil** `b02f3ec7`: built and installed by the deploy chat at 11:26 (all three lanes). Its own `build_installer.ps1` needs the transform module built first with `/p:ProductionIntegration=true`.
   - **Manager** `master`: first attempt **failed** on the 2022 lane (reference folder order, REL-BUILD-01). Fixed, merged as PR #89 (`c66fc481`). Rebuilt without the `Platform=x64` flag (the package check looks in `bin\Release`): *"Complete 72-file, three-lane release candidate verified"*, 0 errors, Manager `1.1.0+b02f3ec7` in all three lanes, common library **identical to installed Civil in all three lanes**.
   - **Structural** `60c41228`: its own `build_installer.ps1`, three lanes, refs from `C:\TimOS\refs\autocad`: *"Complete three-lane unsigned release candidate verified"*, 0 errors, version 1.0.74. Candidate in this chat's scratchpad; worktree `rel-structural-60c41228` created by this chat.
   - **Automated tests, `master` `c66fc481`, 23 Sep:** Civil 10,125 run, 20 failed, 19 skipped. Every failing name is in the known list (18 distinct names); two known failures now pass (`FinalLandingProducer…`, `RefusedNativeCallback…`). Manager 225/225. Spine 81/81. Command truth 55/57 (`Civil_HasNoCompiledOrRegistryOnlyCommandDrift`, `CentralRegister_OwnsApprovedFoundationToolsAndRecordsLegacyInputs`). Installer 225/269 (44 failed; the 13 Sep record said 43; no by-name baseline existed, so today's 44 names are the baseline, kept in this chat's scratchpad). Installer failures concern the activation installer and release packaging checks, not the hand install used on Tuesday.
   - **Not yet done:** a package audit of all three together on the frozen line.
5. **REL-04 Install the package on Tim's PC** — Friday 25 Sep, 2:00 to 3:00pm, **only on Tim's "AutoCAD is closed, deploy"**, using the colleague installer route so the installer itself is tested. Backups first; one-action undo named. **Status:** Proposed.
6. **REL-05 Codex pass 2** — Part Z of the list: the tank change and every fix since pass 1, on the package. Friday evening and the weekend. **Status:** Proposed.
7. **REL-06 AutoCAD 2022** — Monday 28 Sep, 30 minutes on a colleague's 2022 PC (Tim: *"Yes, Monday"*). Steps M1 to M9 written 23 Sep in the run list, Part M: install by hand, check, mixed-version probe, then go back (the first real run of REL-09 both ways). **Status:** steps written; not run.
8. **REL-07 Colleague notes** — one page: what is new, what not to use yet, how to get help, how to roll back to 2.1.14. **Status:** Proposed.
9. **REL-08 Pilot** — Tuesday 29 Sep: the named colleague (Tim to name; 2027 recommended) installs with AutoCAD closed. **Publishing to the IT Admin folder or approving a build for any colleague happens only on Tim's explicit word for that exact package.** **Status:** Proposed.

### REL-09 How the hand install works — PROPOSED, read from the files 23 Sep

**What exists, read today:**

1. **The three install files in the IT Admin folder** (`Install-CECvlSuite.ps1`, `Install-CESuiteManager.ps1`, `Install-CEStrucSuite.ps1`) **delete the old plugin folder, then copy the new one. No backup, and no check that AutoCAD is closed.** Not safe for a pilot on their own.
2. **The new Civil installer program is not a double-click installer any more.** Since RS-01B2 it only activates an update that Manager has already staged (it needs `--stage-record`, `--target`, `--rollback-root`, `--result-root`). It does refuse while `acad` or `accoreconsole` is running and keeps a rollback copy, but a colleague cannot run it by hand.
3. **A folder in the plugins folder whose name ends in `.backup` is not loaded by AutoCAD.** Observed, not documented: Tim's own `%APPDATA%\Autodesk\ApplicationPlugins` holds 19 such folders (counted 23 Sep) and his AutoCAD loads normally.

**Proposed steps — no new script, every step visible:**

1. **Close AutoCAD.** Check Task Manager: no `acad.exe`, no `accoreconsole.exe`.
2. Open File Explorer at `%APPDATA%\Autodesk\ApplicationPlugins`.
3. **Rename** `CE_CVL_SUITE.bundle`, `CE_SUITE_MANAGER.bundle` and `CE_STRUC_SUITE.bundle` by adding `_PRE_V3.backup` to the end.
4. **Check `C:\ProgramData\Autodesk\ApplicationPlugins`** for any CE folder. If one is there, stop and tell Tim: AutoCAD would load two copies. (Tim's own PC has an old Manager 1.0.0 there, switched off on 17 Jul by renaming its `PackageContents.xml` to `PackageContents.xml.DISABLED-duplicate-appdata-wins`; a colleague may have one that is still live.)
5. **Copy the three new `.bundle` folders** from the pilot folder into `%APPDATA%\Autodesk\ApplicationPlugins`.
6. Open AutoCAD. The CE ribbon loads. `CEMANAGER` shows the three new versions.

**Going back (one step each):** close AutoCAD; delete the three new folders; remove `_PRE_V3.backup` from the three old names; open AutoCAD.

**Still open:**

1. **Settings.** Version 3 may rewrite the colleague's CE settings files (`%APPDATA%\TIM_CE_CADTOOLS`, `%APPDATA%\CE_CVL_SUITE`). Whether 2.1.14 still reads them after going back is **not established**. Proposed: copy those two folders to a `_PRE_V3` copy at step 3 as well.
2. **Where the pilot package sits.** Putting it in the shared IT Admin folder is publishing and needs Tim's word; a separate `CE V3 PILOT` subfolder keeps the 2.1.14 copies other colleagues use untouched.
3. **Rehearsal (changed 23 Sep):** Friday's install on Tim's PC uses **exactly these steps**, then the going-back steps, then the install again, so both directions are proven in real AutoCAD before Tuesday. A spare Windows user profile was the first idea; creating a Windows account is not something a chat does, so it is dropped.

### Holds

1. **PR #88 (`CDMOVETEST`, the E-HOLD-01 probe) stays OFF `master` until the colleague package is cut** (Thursday 5:30pm). It is a test tool and must not reach a colleague. It goes onto Tim's PC only after Codex pass 2 finishes, so it does not change the build under test. Decided by this chat, 23 Sep, as the deployment controller.

## 6. Bugs

`BUG_CARPARK.md` is the one bug file. Release blockers found in this area are listed here by ID.

1. **BUG-163** — CDWT "AutoCAD cannot continue" at the callout point. Brief: `archive\chat-records-2026-09\CHAT_PROMPT_CDWT_CRASH_2026-09-23.md`. OPEN.
2. **BUG-164** — AutoCAD crashed on closing: **cause proven** (CE's palette shutdown, 18 closes in the Windows event log); **fix merged** PR #90 `aeb03763`; not installed, not tested in AutoCAD.
3. **BUG-165** — latent: Manager's version check ranks `2026.0420.1549` above `3.0.0`; held back only by the signed-approval check. Not a Tuesday blocker. OPEN.

## 7. Parked

`IDEAS_INBOX.md` is the one idea file. _(none yet)_

## 8. Test steps

Written at REL-05 from the frozen package. Both lanes named: 2027, and 2024/net48 if any colleague runs it.

## 9. Regression list

_"These things must still work" on a colleague install:_

1. The CE ribbon loads, with Civil, Manager and Structural all present.
2. Every CE plugin's common library is the same version and the same file.
3. Rolling back returns the colleague to exactly what they had before.
