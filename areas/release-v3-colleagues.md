# Area REL — Version 3 to colleagues (the staff release, Stage 6 of the master plan)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Getting a Version 3 build from Tim's PC onto colleagues' PCs safely: which build, which colleagues, how it is packaged and installed, how it is rolled back, and what they are told. Opened 23 Sep 2026 for Tim's Tuesday 29 Sep target (`decisions\2026-09-23_V3_COLLEAGUE_RELEASE.md`).

The master plan's own definition of done for Version 3 (a standalone Civil install, a controlled pilot, help and rollback) is the long goal. **Tuesday is a first step towards it, not the whole of it.**

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
3. **Structural 1.0.74+5d723d41 — AutoCAD 2027 only.** No 2024 or 2025/26 lane, and no common library of its own (it uses whichever one AutoCAD loaded first).
4. **Common library 1.1.0** in Civil and Manager.

### How colleagues receive updates today

1. Their Manager 1.0.2, at AutoCAD start, quietly copies any **approved** build from the IT Admin folder and switches it on at their **next** AutoCAD start (`Plugin.cs` and `CeApprovedReleaseService.cs` at the imported 1.0.2 source, `c5250a11`).
2. It can approve a build for **named machines only** (a "canary") and later promote it to everyone. So a one-colleague pilot is possible with the existing machinery.
3. **Whether their automatic update still works is Unknown.** When the storage keys were reset for SEC-001 (July), a Manager configured for online storage would find no approved builds. Needs a check.
4. The certain route is the installer or `Install-CECvlSuite.ps1`, run by the colleague with AutoCAD closed.
5. Currently approved in `CE Plugin Admin\releases\`: Civil `2026.0420.1549` (approved 28 Apr) and Structural `1.0.117.0001` (28 Apr).

### What Tim has accepted in AutoCAD — recorded

Three items, all before 16 Sep (`PENDING_TESTS.md`, Accepted section). The 16 Sep test day mostly failed. **Nothing since has been recorded as accepted.** `d0ffe1a2` (16 Sep) and `d90659cf` (23 Sep) are installed and in daily use by Tim, which is evidence of use, not acceptance.

## 4. The risks that decide the plan

1. **The shared common library.** Every CE plugin carries the same library and the first copy AutoCAD loads wins for all of them. A colleague given Civil 3.0 while keeping Manager 1.0.2 and Structural 1.0.41 (library 1.0.0) risks the CE ribbon silently not loading. **All three must move together, carrying the same library.**
2. **Mixed versions on one job.** Version 3 upgrades pipes into its own pipe object when a drawing is opened or drawn in. A colleague still on 2.1.14 opening that drawing has no enabler for that object. What they see is **not yet established** — probe first, then decide.
3. **AutoCAD 2022.** Colleagues run 2022 and 2027 (Tim, 23 Sep). The 2022 to 2024 lane of Civil 3.0 has no recorded AutoCAD check (PENDING_TESTS rows 18 and 19: "2024, never tested"), and this PC has AutoCAD 2027 only. Tim's Structural 1.0.74 has no 2022 lane at all.
4. **Known hazards on the installed build.** The CDWT crash (W4) has no established cause. The CD window layout fixes are not in it.
5. **The release script.** `build_installer.ps1` was broken until DEPLOY-01 (23 Sep) and still does not build the transform module (`CE_TRANSFORM_2027.arx`); it is built by hand.

## 4a. What stands between Tuesday and "most of Version 3" — checked 23 Sep 2026, about 11:10am

Tim asked: *"whats stopping us from getting the large majority of version 3 by tuesday?"*

1. **Not unfinished building on a shelf.** Every one of 17 built pieces named in `PENDING_TESTS.md` (branches of 16 to 19 Sep) was checked with `git merge-base --is-ancestor`: all 17 are already in `master` `b02f3ec7`, so all ship on Tuesday under Tim's "newest saved work" answer. The other branches not in `master` are 19 to 20 Sep rescue copies marked unfinished and unbuilt, 1,150 to 1,570 changes behind.
2. **Tim's AutoCAD check is the limit.** The 16 Sep test day recorded **37 faults** (`decisions\2026-09-16_TEST_DAY_RESULTS.md`, sections R, W, P, C7, L, T, D, G, TWL, F1). Fixes for many have been built and installed since. **None has been re-checked by Tim.** Until he has looked, whether they work is Unknown.
3. **Some areas have nothing recorded as built for Version 3.** The area files for H (pump stations), I (WSUD), J (overland flow) and others were opened 19 Sep with no items. This is "not recorded", not proof of "not built".
4. **The 2022 lane cannot be checked on this PC.** `C:\Program Files\Autodesk` holds **AutoCAD 2027 only** (read 23 Sep). No AutoCAD check of Civil 3.0 in 2022 is recorded anywhere.
5. **Proposed (not decided):** Claude pre-checks the 37 faults with AutoCAD running without a screen (the accoreconsole probe) in the free windows, so Tim only opens what passes; Tim then re-checks area by area in the order he set on 16 Sep (CDWT, CD, PIT, then H to L, then M). The Tuesday pilot colleague is on 2027; 2022 colleagues follow after one check on a real 2022 machine.

## 5. Items and status — the plan after Tim's answers of 23 Sep (proposed timings, not decisions)

Say Built / Tested / Installed / Tim-accepted separately, never a percentage.

1. **REL-00 Codex AutoCAD run, pass 1** — on the installed `3.0.0+d90659cf`: start-up, release checks (three plugins, one common library), the never-run 18 Sep list, the 19 Sep overnight fixes V1 to V18, and the 37 faults of 16 Sep by name. List: `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md`. **Status:** list written 23 Sep; not started.
2. **REL-01 Freeze** — Civil is the saved main line (`master`) at the freeze, per Tim's *"Newest saved work"*. Proposed: **Thursday 24 Sep, 5:30pm**, announced on register #78. Manager and Structural: **open question** (see the decision file). **Status:** Proposed.
3. **REL-02 Fix what pass 1 finds** — one area at a time, CDWT, CD, PIT first (Tim, 16 Sep). Each fix lands on `master` before the freeze. **Status:** waiting on pass 1.
4. **REL-03 Package** — Thursday night: build all three plugins, all three AutoCAD lanes, one matching common library; full automated suite; package audit (hashes, every file present). **Status:** Proposed.
5. **REL-04 Install the package on Tim's PC** — Friday 25 Sep, 2:00 to 3:00pm, **only on Tim's "AutoCAD is closed, deploy"**, using the colleague installer route so the installer itself is tested. Backups first; one-action undo named. **Status:** Proposed.
6. **REL-05 Codex pass 2** — Part Z of the list: the tank change and every fix since pass 1, on the package. Friday evening and the weekend. **Status:** Proposed.
7. **REL-06 AutoCAD 2022** — Monday 28 Sep, 30 minutes on a colleague's 2022 PC (Tim: *"Yes, Monday"*). Five steps written by Claude once the package exists. **Status:** Proposed.
8. **REL-07 Colleague notes** — one page: what is new, what not to use yet, how to get help, how to roll back to 2.1.14. **Status:** Proposed.
9. **REL-08 Pilot** — Tuesday 29 Sep: the named colleague (Tim to name; 2027 recommended) installs with AutoCAD closed. **Publishing to the IT Admin folder or approving a build for any colleague happens only on Tim's explicit word for that exact package.** **Status:** Proposed.

### Holds

1. **PR #88 (`CDMOVETEST`, the E-HOLD-01 probe) stays OFF `master` until the colleague package is cut** (Thursday 5:30pm). It is a test tool and must not reach a colleague. It goes onto Tim's PC only after Codex pass 2 finishes, so it does not change the build under test. Decided by this chat, 23 Sep, as the deployment controller.

## 6. Bugs

`BUG_CARPARK.md` is the one bug file. Release blockers found in this area are listed here by ID. _(none yet)_

## 7. Parked

`IDEAS_INBOX.md` is the one idea file. _(none yet)_

## 8. Test steps

Written at REL-05 from the frozen package. Both lanes named: 2027, and 2024/net48 if any colleague runs it.

## 9. Regression list

_"These things must still work" on a colleague install:_

1. The CE ribbon loads, with Civil, Manager and Structural all present.
2. Every CE plugin's common library is the same version and the same file.
3. Rolling back returns the colleague to exactly what they had before.
