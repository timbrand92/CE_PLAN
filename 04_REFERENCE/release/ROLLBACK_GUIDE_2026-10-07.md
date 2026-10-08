# How to go back to the previous CE version (written 7 Oct 2026, corrected 8 Oct 2026, brought up to date 9 Oct 2026)

**Read this first.** Every CE install done the release chat's way keeps the version it replaced, untouched, as a `_PRE_` backup folder. Going back is two folder renames per bundle, about two minutes. Nothing is deleted and your settings are not touched.

**What is installed today (read from the program files and the install logs on 9 Oct 2026):**

1. **Civil 3.0.38 and Manager 1.1.38**, build code `3e59c62a` (installed 8 Oct, 12:36 pm by the install log).
2. **Structural 1.0.108**, build code `d7879e79` (installed 8 Oct, 12:28 pm by the install log).
3. **Not checked:** whether AutoCAD has been started on these versions. AutoCAD was running on Tim's PC when this was read, so do not roll back until it is closed.

**Which PC this is for.** The folder names in sections 3 to 5 are the ones on **Tim's PC**, read on 9 Oct. A colleague's PC only holds the backups its own installs made. The colleague hand install (REL-09 in the release area file) was still PROPOSED when this was last written on 8 Oct (not checked again on 9 Oct); its backups would be named `..._PRE_V3.backup`. Read your own list with Step 2 before you rename anything.

## 1. THE FIVE STEPS IN PLAIN WORDS

1. **Close AutoCAD.** All of it, and no Codex test running in AutoCAD.
2. **Move the new version aside.** Rename the live bundle folder to a `...ROLLEDBACK...backup` name. Never delete it.
3. **Bring the old version back.** Rename the `_PRE_` backup you want to the live name (`CE_CVL_SUITE.bundle` and so on).
4. **Check the version.** Read the version off the program file (one line, below). It must be the older number.
5. **Start AutoCAD** and read the CE versions on the status bar ("CE CVL SUITE v...", "CE MANAGER v...", "CE STRUC SUITE v..."), or type CEHEALTH.

Two rules that matter:

1. **Civil and Manager go back together.** They share one file (CE_SHARED) and the first one AutoCAD loads is used by both. One new and one old has stopped the CE ribbon loading before; from 3.0.34 a mixed pair also breaks the Civil and Manager machine reports (carried over from the 8 Oct version, not checked again). Always move them as a pair.
2. **Structural goes back alone.** It does not use CE_SHARED (its live Modern folder has no CE_SHARED file, checked 9 Oct; the Legacy and Net8 folders were not checked), so it never has to match Civil or Manager.

**Manager Roll Back (the button) must NOT be offered to colleagues. The hand rollback in this guide is the only supported way to go back.** (This is the release controller's instruction. Not checked against the program.)

## 2. WHEN TO ROLL BACK, AND WHEN NOT TO

**Roll back when the install itself is broken:**

1. **No CE ribbon at all** after AutoCAD starts (the CE tab is missing).
2. **AutoCAD crashes or hangs** on start-up, or on a command that worked yesterday (CD, CDEDIT, PIT).
3. **Pipes or pits you already drew will not open or edit** (a drawing that was fine on the previous version).
4. **A whole command family is gone** (every CD command says "Unknown command").
5. **You cannot work on a live job** and the fix is not ready.

**Do NOT roll back for:**

1. **One wrong message or label** (for example a pit label that steps out the wrong way). That is a bug report, not a rollback. Write it down (section 6) and carry on.
2. **A setting that looks different.** Settings are separate from the version. Check Settings first.
3. **A slow first start** after an install. AutoCAD rebuilds its caches once.

If unsure: ask whether you can still do today's job on the new version. If yes, report it. If no, roll back.

## 3. THE EXACT STEPS

Use a normal PowerShell window (no administrator needed). The CE folders are in your own profile. All paths below start at `%APPDATA%\Autodesk\ApplicationPlugins`.

**Step 1. Check AutoCAD is closed.** This must print nothing. If it lists `acad`, close AutoCAD and run it again.

```powershell
Get-Process acad, accoreconsole -ErrorAction SilentlyContinue
```

**Step 2. List the backups, newest first.**

```powershell
Get-ChildItem "$env:APPDATA\Autodesk\ApplicationPlugins" -Directory -Filter "CE_*_PRE_*.backup" | Sort-Object LastWriteTime -Descending | Select-Object -First 12 Name
```

**How to read a backup name.** `CE_CVL_SUITE_PRE_8946e185_20261008-123615.backup` means: the version that was live (build code `8946e185`, Civil 3.0.37) until 8 Oct 2026 at 12:36:15 (PC clock), when the next install took it out. The date is when it was REPLACED, not when it was built. The build code in the name belongs to the version INSIDE the folder, not to the version that replaced it. Pick by the version number inside, using the list in section 4, and check it first (next block). Do not pick by the order of the list: the order follows the folder's own date, not the date in its name.

A few older folders (mostly 15 to 28 Sep) have a different shape, for example an underscore in the date, `_PRE_CESHARED_`, or `_RIBBON_FAIL_`. They are listed by Step 2 too. Do not use them for a rollback.

**Step 3. Check the backup really is the version you want.** Example: the Civil backup that should read 3.0.37.

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_PRE_8946e185_20261008-123615.backup\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion
```

It should print `3.0.37+8946e185c3e31f1a0f87369ee3d9f376563a6fdd` (read this way on 9 Oct).

**Step 4. Civil and Manager: move the new ones aside (worked example: back from 3.0.38 / 1.1.38 to 3.0.37 / 1.1.37).** The new name must NOT end in `.bundle`, or AutoCAD loads it as well.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle" -NewName "CE_CVL_SUITE_ROLLEDBACK_3.0.38.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle" -NewName "CE_SUITE_MANAGER_ROLLEDBACK_1.1.38.backup"
```

**Step 5. Civil and Manager: bring the matching pair back.** Both names carry the same build code and stamp. Do both, never one.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_PRE_8946e185_20261008-123615.backup" -NewName "CE_CVL_SUITE.bundle"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER_PRE_8946e185_20261008-123615.backup" -NewName "CE_SUITE_MANAGER.bundle"
```

**Step 6. Structural only (worked example: back from 1.0.108 to 1.0.107).** Skip this step if Structural is fine.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle" -NewName "CE_STRUC_SUITE_ROLLEDBACK_1.0.108.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE_PRE_90ce00bc_20261008-122853.backup" -NewName "CE_STRUC_SUITE.bundle"
```

**Step 7. Read the version off each live program file.** Expected after the example: 3.0.37, 1.1.37 and 1.0.107. The text after the `+` is the build code: `8946e185` for Civil and Manager, `90ce00bc` for Structural. Before the rollback it reads `3e59c62a` (Civil, Manager) and `d7879e79` (Structural).

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion
```

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle\Contents\Win64\Modern\CE_SUITE_MANAGER.dll").VersionInfo.ProductVersion
```

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle\Contents\Win64\Modern\CE_STRUC_SUITE.dll").VersionInfo.ProductVersion
```

`Modern` is the AutoCAD 2027 copy. Colleagues on AutoCAD 2025 to 2026 read the `Net8` folder, and 2022 to 2024 the `Legacy` folder (which year uses which folder: carried over from the 8 Oct version, not checked). All three folders exist in the live Structural bundle and in the 3.0.37 Civil and 1.0.107 Structural backups (checked 9 Oct); the install logs show the same version in all three folders for the live Civil, Manager and Structural. Whether the very old Structural backups (older than 1.0.76) hold only the `Modern` copy was not checked again.

**Step 8. Start AutoCAD.** Read the CE versions on the status bar, or type CEHEALTH (it lists Civil and Structural; Manager's version is on the status bar). All must show the older numbers. Then open one drawing and run one command you trust (CD, then CDEDIT on a pipe).

**What you may see after going back (not checked, stated by the release controller):**

1. **The first start after going back may print a settings log line.** It is a message in the log file, not a fault with your drawing. Copy the log (section 6) if you want it looked at.
2. **Structural 1.0.106 and later write new default rows into your `CS_Settings.json` the first time they start.** Going back to an older Structural does not remove those rows. That is harmless: older versions ignore rows they do not know. Going back from 1.0.108 to 1.0.107 keeps them too, because 1.0.107 is also "1.0.106 or later".

## 4. WHICH PAIRS GO TOGETHER, AND WHAT EACH BACKUP RESTORES (Tim's PC)

Read from the program files in each backup folder on 9 Oct 2026, not from memory. Live today: Civil 3.0.38, Manager 1.1.38, Structural 1.0.108 (Civil and Manager installed 8 Oct 12:36 pm, Structural 8 Oct 12:28 pm, by the install logs).

**Civil + Manager (always the pair with the SAME build code and stamp):**

1. **Back to 3.0.37 and 1.1.37.** `CE_CVL_SUITE_PRE_8946e185_20261008-123615.backup` and `CE_SUITE_MANAGER_PRE_8946e185_20261008-123615.backup`. This is the one to use for "the last install misbehaves".
2. **Back to 3.0.36 and 1.1.36.** `..._PRE_86aa7e2a_20261008-105736.backup` (both).
3. **Back to 3.0.35 and 1.1.35.** `..._PRE_49730bfb_20261008-063137.backup` (both).
4. **Back to 3.0.34 and 1.1.34.** `..._PRE_62514a67_20261008-035945.backup` (both).
5. **Back to 3.0.33 and 1.1.33.** `..._PRE_d2575455_20261008-005047.backup` (both).
6. **Back to 3.0.32 and 1.1.32.** `..._PRE_b72029d9_20261007-211609.backup` (both).
7. **Back to 3.0.31 and 1.1.31.** `..._PRE_88bf32d8_20261005-091304.backup` (both).
8. **Back to 3.0.30 and 1.1.30.** `..._PRE_88e63589_20261004-121606.backup` (both).
9. **Back to 3.0.29 and 1.1.29.** `..._PRE_fe9c22ac_20261004-095043.backup` (both).
10. **Back to 3.0.28 and 1.1.28.** `..._PRE_909f4bbd_20261004-070617.backup` (both).
11. **Older pairs exist** down to 3.0.0 and 1.1.0 (read from the folders on 9 Oct). There is no 3.0.19 or 1.1.19 backup. Read the version first (Step 3) before using one. There is also one old Civil 2.x backup; it is not part of a pair, do not use it.

**Structural alone:**

1. **Back to 1.0.107.** `CE_STRUC_SUITE_PRE_90ce00bc_20261008-122853.backup`. The one to use for "the last install misbehaves".
2. **Back to 1.0.106.** `CE_STRUC_SUITE_PRE_7ff53894_20261008-094538.backup`.
3. **Back to 1.0.105.** `CE_STRUC_SUITE_PRE_2f30d176_20261008-070646.backup`. This is the newest version from before the new settings rows (see the note under Step 8).
4. **Back to 1.0.104.** `CE_STRUC_SUITE_PRE_ebc1654d_20261008-042112.backup`.
5. **Back to 1.0.103.** `CE_STRUC_SUITE_PRE_6f2e9763_20261008-005612.backup`.
6. **Back to 1.0.102.** `CE_STRUC_SUITE_PRE_a3513ddd_20261007-212133.backup`.
7. **Back to 1.0.101.** `CE_STRUC_SUITE_PRE_8e88af4e_20261005-100626.backup`.
8. **Back to 1.0.100.** `CE_STRUC_SUITE_PRE_f9366a50_20261004-120517.backup`.
9. **Back to 1.0.99.** `CE_STRUC_SUITE_PRE_5807a1a9_20261004-094518.backup`.
10. **Older ones exist back to 1.0.74.** There is no 1.0.83 backup. Read the version first.

**Not covered by this guide:** `CE.AutoCADLink.2027.bundle` (last changed 23 Jul) and `CE.Transform.Trial.2027.bundle` (last changed 7 Sep), by the folder dates on 9 Oct. The installs did not touch them and no `_PRE_` backups exist for them.

**Your settings are not part of the bundles.** A rollback leaves these alone: `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\TIM_CE_CADTOOLS` (and Manager's `%APPDATA%\CE_CADTOOLS`; these four folders were not opened or checked, listed from the 8 Oct version). On Tim's PC a copy was taken before each install, kept in `C:\ce_rc_scratch` (the folders exist, their contents were not opened):

1. `settings_pre_1043`: before Civil 3.0.38 and Manager 1.1.38.
2. `settings_pre_1042`: before Structural 1.0.108.
3. `settings_pre_1041`: before Civil 3.0.37 and Manager 1.1.37.
4. `settings_pre_1040`: before Structural 1.0.107.
5. `settings_pre_1038`: before Structural 1.0.106, so it holds the settings as they were before the new rows were written.

A colleague's PC has no such copies (not checked). Only copy a file back from there if the older version refuses to read a setting, and only with Tim's word. Do not restore settings by default.

## 5. HOW TO UNDO THE ROLLBACK

Close AutoCAD first (Step 1 again). Then reverse each rename: the live folder goes back to its `_PRE_` name, and the `ROLLEDBACK` folder becomes the live bundle. Example, Civil and Manager back to 3.0.38 and 1.1.38:

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle" -NewName "CE_CVL_SUITE_PRE_8946e185_20261008-123615.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle" -NewName "CE_SUITE_MANAGER_PRE_8946e185_20261008-123615.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_ROLLEDBACK_3.0.38.backup" -NewName "CE_CVL_SUITE.bundle"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER_ROLLEDBACK_1.1.38.backup" -NewName "CE_SUITE_MANAGER.bundle"
```

For Structural, the same pattern: live `CE_STRUC_SUITE.bundle` back to `CE_STRUC_SUITE_PRE_90ce00bc_20261008-122853.backup`, then `CE_STRUC_SUITE_ROLLEDBACK_1.0.108.backup` to `CE_STRUC_SUITE.bundle`. Read the versions again (Step 7): they must show 3.0.38 / 1.1.38 (`3e59c62a`) and 1.0.108 (`d7879e79`).

The worked examples in this guide were written from the folder names and logs. None of these exact rename commands was run on 9 Oct (the guide is read-only on Tim's PC).

## 6. WHAT TO WRITE DOWN FOR THE NEXT FIX

A fix can only be built if we know what went wrong. Before you roll back, if you can, write down:

1. **Version before and after.** For example "3.0.38 / 1.1.38 / 1.0.108 to 3.0.37 / 1.1.37 / 1.0.107" (from Step 7).
2. **What you did in AutoCAD.** The command, what you clicked, what you expected, what happened. One drawing name is enough.
3. **A screenshot** of any error box or of the missing ribbon.
4. **Copy the CE logs before you start AutoCAD again.** Civil: `%APPDATA%\CE_CVL_SUITE\logs` (file `CE_CVL_SUITE.log`). Shared tools: `%APPDATA%\TIM_CE_CADTOOLS\logs` (files `CE_CVL_SUITE.log`, `CE_STRUC_SUITE.log` and the daily Structural command logs). Structural also writes `%APPDATA%\CE_STRUC_SUITE\logs\ce_struc_suite.log`. Copy the whole `logs` folders to your desktop. (These log locations are carried over from the 8 Oct version, not checked on 9 Oct.)
5. **Put it in the bug file** `C:\CE_PLAN\BUG_CARPARK.md` (or tell the release chat). A bug is only closed when it has been confirmed fixed in AutoCAD.

## 7. DO NOT DO THIS

1. **Do not use the old install files** (`Install-CECvlSuite.ps1`, `Install-CESuiteManager.ps1`, `Install-CEStrucSuite.ps1` in the IT Admin folder) **or `Deploy-Local-AsAdmin.ps1` to go back.** The install files delete the old plugin folder with no backup and no check that AutoCAD is closed; the deploy script is Civil only and does not keep CE_SHARED matched. (Carried over from the 8 Oct version, not checked again.)
2. **Do not roll back Civil without Manager** (or Manager without Civil).
3. **Do not use Manager's Roll Back button, and do not offer it to colleagues.** Use this guide.
4. **Do not delete the new bundle.** Rename it. It is the evidence for the fix.
5. **Do not name the moved-aside folder with `.bundle` on the end.** AutoCAD loads every `.bundle` folder it finds. Folders ending `.backup` are not loaded (observed on Tim's PC on 8 Oct, not documented by Autodesk, not checked again).
6. **Do not copy files from one version into another by hand** (one program file or one lane). Rename whole folders only.
7. **Do not do this with AutoCAD open**, or while Codex is running a test in AutoCAD.
8. **Do not mix backups from different stamps** (a Civil 3.0.31 with a Manager 1.1.32).
9. **Do not restore settings by reflex.** They are separate from the version.

---

**Technical notes (nothing here is needed to roll back):**

1. **How the backups are made (Tim's PC).** Each install script checks AutoCAD, accoreconsole and Codex are not running (the logs show two checks, five minutes apart), renames the live folder to `<name>_PRE_<shortsha>_<yyyyMMdd-HHmmss>.backup` (the short build code of the version being replaced), copies the new bundle in, then checks every file against a manifest (Civil 822 files, Manager 78, Structural 2007, as logged for the 3.0.38, 1.1.38 and 1.0.108 installs) and that Civil and Manager hold an identical CE_SHARED. If the copy fails the script removes the half-copied folder and renames the backup straight back (carried over from the 8 Oct reading of the script, not checked again). The wrapper copies Tim's settings aside first (`settings_pre_10xx`, shown in the logs).
2. **Why the pair.** Civil and Manager each carry CE_SHARED.dll at assembly version 1.1.0.0 (carried over, not checked again). AutoCAD loads every CE plugin in one process, so the first copy loaded is used by all (carried over from the memory note `ce-shared-one-assembly-identity`, not checked). The file differs from one release to the next. The start of its hash for the Legacy copy, as logged at install: 675A7B50 in 3.0.38, 64F4DD05 in 3.0.37 and 41B5BECD in 3.0.36.
3. **The colleague installer is different.** The CE installer program keeps its rollback copy outside the AutoCAD plugin folder, named `<plugin>_<operation>.bundle.rollback`, at a folder given when it runs. This guide does not cover it (not checked again).
4. **Sources.** `C:\ce_rc_scratch\install_c36.log` to `install_c41.log` (the 3.0.36 to 3.0.38, 1.1.36 to 1.1.38 and 1.0.106 to 1.0.108 installs), a read of every backup folder's program-file version and of the three live bundles on 9 Oct, the folder list of `C:\ce_rc_scratch` (names only), `Installer\SafeBundleInstaller.cs` at 62514a67 (8 Oct, not checked again) and the memory note `ce-shared-one-assembly-identity`.
5. **What was not checked on 9 Oct.** No rename in this guide was run. No settings file was opened. Nothing here says a version has been started or tested in AutoCAD, or accepted by Tim.
