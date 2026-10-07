# How to go back to the previous CE version (written 7 Oct 2026, corrected 8 Oct 2026)

**Read this first.** Every CE install done the release chat's way keeps the version it replaced, untouched, as a `_PRE_` backup folder. Going back is two folder renames per bundle, about two minutes. Nothing is deleted and your settings are not touched.

**Which PC this is for.** The folder names in sections 3 to 5 are the ones on **Tim's PC**, read on 8 Oct. A colleague's PC only holds the backups its own installs made. The colleague hand install (REL-09 in the release area file) is still PROPOSED; its backups would be named `..._PRE_V3.backup`. Read your own list with Step 2 before you rename anything.

## 1. THE FIVE STEPS IN PLAIN WORDS

1. **Close AutoCAD.** All of it, and no Codex test running in AutoCAD.
2. **Move the new version aside.** Rename the live bundle folder to a `...ROLLEDBACK...backup` name. Never delete it.
3. **Bring the old version back.** Rename the `_PRE_` backup you want to the live name (`CE_CVL_SUITE.bundle` and so on).
4. **Check the version.** Read the version off the program file (one line, below). It must be the older number.
5. **Start AutoCAD** and read the CE versions on the status bar ("CE CVL SUITE v...", "CE MANAGER v...", "CE STRUC SUITE v..."), or type CEHEALTH.

Two rules that matter:

1. **Civil and Manager go back together.** They share one file (CE_SHARED) and the first one AutoCAD loads is used by both. One new and one old has stopped the CE ribbon loading before; from 3.0.34 a mixed pair also breaks the Civil and Manager machine reports. Always move them as a pair.
2. **Structural goes back alone.** It does not use CE_SHARED (its bundle has no CE_SHARED file), so it never has to match Civil or Manager.

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

**How to read a backup name.** `CE_CVL_SUITE_PRE_d2575455_20261008-005047.backup` means: the version that was live (build code `d2575455`, Civil 3.0.33) until 8 Oct 2026 at 00:50:47 (PC clock), when the next install took it out. The date is when it was REPLACED, not when it was built. Pick by the version number inside, using the list in section 4, and check it first (next block).

**Step 3. Check the backup really is the version you want.** Example: the Civil backup that should read 3.0.33.

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_PRE_d2575455_20261008-005047.backup\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion
```

**Step 4. Civil and Manager: move the new ones aside (worked example: back from 3.0.34 / 1.1.34 to 3.0.33 / 1.1.33).** The new name must NOT end in `.bundle`, or AutoCAD loads it as well.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle" -NewName "CE_CVL_SUITE_ROLLEDBACK_3.0.34.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle" -NewName "CE_SUITE_MANAGER_ROLLEDBACK_1.1.34.backup"
```

**Step 5. Civil and Manager: bring the matching pair back.** Both names carry the same build code and stamp. Do both, never one.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_PRE_d2575455_20261008-005047.backup" -NewName "CE_CVL_SUITE.bundle"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER_PRE_d2575455_20261008-005047.backup" -NewName "CE_SUITE_MANAGER.bundle"
```

**Step 6. Structural only (worked example: back from 1.0.104 to 1.0.103).** Skip this step if Structural is fine.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle" -NewName "CE_STRUC_SUITE_ROLLEDBACK_1.0.104.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE_PRE_6f2e9763_20261008-005612.backup" -NewName "CE_STRUC_SUITE.bundle"
```

**Step 7. Read the version off each live program file.** Expected after the example: 3.0.33, 1.1.33 and 1.0.103 (the text after the `+` is the build code, ignore it).

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion
```

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle\Contents\Win64\Modern\CE_SUITE_MANAGER.dll").VersionInfo.ProductVersion
```

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle\Contents\Win64\Modern\CE_STRUC_SUITE.dll").VersionInfo.ProductVersion
```

`Modern` is the AutoCAD 2027 copy. Colleagues on AutoCAD 2025 to 2026 read the `Net8` folder, and 2022 to 2024 the `Legacy` folder. The version number is the same in all three (read from the bundles on 8 Oct). Some Structural backups older than 1.0.76 hold only the `Modern` copy.

**Step 8. Start AutoCAD.** Read the CE versions on the status bar, or type CEHEALTH (it lists Civil and Structural; Manager's version is on the status bar). All must show the older numbers. Then open one drawing and run one command you trust (CD, then CDEDIT on a pipe).

## 4. WHICH PAIRS GO TOGETHER, AND WHAT EACH BACKUP RESTORES (Tim's PC)

Read from the program files in each backup folder on 8 Oct 2026, not from memory. Live today: Civil 3.0.34, Manager 1.1.34, Structural 1.0.104 (installed 8 Oct 00:50 and 00:56).

**Civil + Manager (always the pair with the SAME build code and stamp):**

1. **Back to 3.0.33 and 1.1.33.** `CE_CVL_SUITE_PRE_d2575455_20261008-005047.backup` and `CE_SUITE_MANAGER_PRE_d2575455_20261008-005047.backup`. This is the one to use for "the last install misbehaves".
2. **Back to 3.0.32 and 1.1.32.** `..._PRE_b72029d9_20261007-211609.backup` (both).
3. **Back to 3.0.31 and 1.1.31.** `..._PRE_88bf32d8_20261005-091304.backup` (both).
4. **Back to 3.0.30 and 1.1.30.** `..._PRE_88e63589_20261004-121606.backup` (both).
5. **Back to 3.0.29 and 1.1.29.** `..._PRE_fe9c22ac_20261004-095043.backup` (both).
6. **Back to 3.0.28 and 1.1.28.** `..._PRE_909f4bbd_20261004-070617.backup` (both).
7. **Older pairs exist back to 3.0.0 and 1.1.0** (24 Sep). There is no 3.0.19 pair. Read the version first (Step 3) before using one.

**Structural alone:**

1. **Back to 1.0.103.** `CE_STRUC_SUITE_PRE_6f2e9763_20261008-005612.backup`. The one to use for "the last install misbehaves".
2. **Back to 1.0.102.** `CE_STRUC_SUITE_PRE_a3513ddd_20261007-212133.backup`.
3. **Back to 1.0.101.** `CE_STRUC_SUITE_PRE_8e88af4e_20261005-100626.backup`.
4. **Back to 1.0.100.** `CE_STRUC_SUITE_PRE_f9366a50_20261004-120517.backup`.
5. **Back to 1.0.99.** `CE_STRUC_SUITE_PRE_5807a1a9_20261004-094518.backup`.
6. **Older ones exist back to 1.0.74** (23 Sep). Read the version first.

**Not covered by this guide:** `CE.AutoCADLink.2027.bundle` (last changed 23 Jul) and `CE.Transform.Trial.2027.bundle` (last changed 7 Sep). The installs did not touch them and no `_PRE_` backups exist for them.

**Your settings are not part of the bundles.** A rollback leaves these alone: `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\TIM_CE_CADTOOLS` (and Manager's `%APPDATA%\CE_CADTOOLS`). On Tim's PC a copy was taken before each install: `C:\ce_rc_scratch\settings_pre_1033` (before Civil 3.0.34 and Manager 1.1.34) and `C:\ce_rc_scratch\settings_pre_1034` (before Structural 1.0.104); older ones are `settings_pre_1031` and `settings_pre_1032`. A colleague's PC has no such copies. Only copy a file back from there if the older version refuses to read a setting. Do not restore settings by default.

## 5. HOW TO UNDO THE ROLLBACK

Close AutoCAD first (Step 1 again). Then reverse each rename: the live folder goes back to its `_PRE_` name, and the `ROLLEDBACK` folder becomes the live bundle. Example, Civil and Manager back to 3.0.34 and 1.1.34:

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle" -NewName "CE_CVL_SUITE_PRE_d2575455_20261008-005047.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle" -NewName "CE_SUITE_MANAGER_PRE_d2575455_20261008-005047.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_ROLLEDBACK_3.0.34.backup" -NewName "CE_CVL_SUITE.bundle"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER_ROLLEDBACK_1.1.34.backup" -NewName "CE_SUITE_MANAGER.bundle"
```

For Structural, the same pattern: live `CE_STRUC_SUITE.bundle` back to `CE_STRUC_SUITE_PRE_6f2e9763_20261008-005612.backup`, then `CE_STRUC_SUITE_ROLLEDBACK_1.0.104.backup` to `CE_STRUC_SUITE.bundle`. Read the versions again (Step 7).

## 6. WHAT TO WRITE DOWN FOR THE NEXT FIX

A fix can only be built if we know what went wrong. Before you roll back, if you can, write down:

1. **Version before and after.** For example "3.0.34 / 1.1.34 / 1.0.104 to 3.0.33 / 1.1.33 / 1.0.103" (from Step 7).
2. **What you did in AutoCAD.** The command, what you clicked, what you expected, what happened. One drawing name is enough.
3. **A screenshot** of any error box or of the missing ribbon.
4. **Copy the CE logs before you start AutoCAD again.** Civil: `%APPDATA%\CE_CVL_SUITE\logs` (file `CE_CVL_SUITE.log`). Shared tools: `%APPDATA%\TIM_CE_CADTOOLS\logs` (files `CE_CVL_SUITE.log`, `CE_STRUC_SUITE.log` and the daily Structural command logs). Structural also writes `%APPDATA%\CE_STRUC_SUITE\logs\ce_struc_suite.log`. Copy the whole `logs` folders to your desktop.
5. **Put it in the bug file** `C:\CE_PLAN\BUG_CARPARK.md` (or tell the release chat). A bug is only closed when it has been confirmed fixed in AutoCAD.

## 7. DO NOT DO THIS

1. **Do not use the old install files** (`Install-CECvlSuite.ps1`, `Install-CESuiteManager.ps1`, `Install-CEStrucSuite.ps1` in the IT Admin folder) **or `Deploy-Local-AsAdmin.ps1` to go back.** The install files delete the old plugin folder with no backup and no check that AutoCAD is closed; the deploy script is Civil only and does not keep CE_SHARED matched.
2. **Do not roll back Civil without Manager** (or Manager without Civil).
3. **Do not delete the new bundle.** Rename it. It is the evidence for the fix.
4. **Do not name the moved-aside folder with `.bundle` on the end.** AutoCAD loads every `.bundle` folder it finds. Folders ending `.backup` are not loaded (observed on Tim's PC, not documented by Autodesk).
5. **Do not copy files from one version into another by hand** (one program file or one lane). Rename whole folders only.
6. **Do not do this with AutoCAD open**, or while Codex is running a test in AutoCAD.
7. **Do not mix backups from different stamps** (a Civil 3.0.31 with a Manager 1.1.32).
8. **Do not restore settings by reflex.** They are separate from the version.

---

**Technical notes (nothing here is needed to roll back):**

1. **How the backups are made (Tim's PC).** Each install script checks AutoCAD, accoreconsole and Codex are not running, renames the live folder to `<name>_PRE_<shortsha>_<yyyyMMdd-HHmmss>.backup` (the short build code of the version being replaced), copies the new bundle in, then checks every file against a manifest (Civil 822 files, Manager 78, Structural 2007) and that Civil and Manager hold an identical CE_SHARED. If the copy fails the script removes the half-copied folder and renames the backup straight back. The wrapper copies Tim's settings aside first (`settings_pre_10xx`).
2. **Why the pair.** Civil and Manager each carry CE_SHARED.dll at assembly version 1.1.0.0. AutoCAD loads every CE plugin in one process, so the first copy loaded is used by all. The file differs from one release to the next (Legacy copy hash starts 9F0A0A79 in 3.0.34, B617D42F in 3.0.33 and 5A902C2D in 3.0.32).
3. **The colleague installer is different.** The CE installer program keeps its rollback copy outside the AutoCAD plugin folder, named `<plugin>_<operation>.bundle.rollback`, at a folder given when it runs. This guide does not cover it.
4. **Sources.** `C:\ce_rc_scratch\install_c30.log`, `install_c31s.log`, `install_c32.log` and `install_c33s.log`, the install scripts `install_c32_civil_manager.ps1` and `install_c33_structural.ps1` in the release chat's scratchpad, a read of every backup folder's program-file version on 8 Oct, `Installer\SafeBundleInstaller.cs` at 62514a67, and the memory note `ce-shared-one-assembly-identity`.
