# How to go back to the previous CE version (written 7 Oct 2026)

**Read this first.** Every CE install keeps the version it replaced, untouched, as a `_PRE_` backup folder. Going back is two folder renames per bundle, about two minutes. Nothing is deleted and your settings are not touched.

## 1. THE FIVE STEPS IN PLAIN WORDS

1. **Close AutoCAD.** All of it, and no Codex test running in AutoCAD.
2. **Move the new version aside.** Rename the live bundle folder to a `...ROLLEDBACK...backup` name. Never delete it.
3. **Bring the old version back.** Rename the `_PRE_` backup you want to the live name (`CE_CVL_SUITE.bundle` and so on).
4. **Check the version.** Read the version off the DLL file (one line, below). It must be the older number.
5. **Start AutoCAD** and read the CE version on the status bar (or CEMANAGER, Module page).

Two rules that matter:

1. **Civil and Manager go back together.** They share one file (CE_SHARED) and the first one AutoCAD loads wins. One new and one old gives a missing CE ribbon.
2. **Structural goes back alone.** It does not use CE_SHARED, so it never has to match Civil or Manager.

## 2. WHEN TO ROLL BACK, AND WHEN NOT TO

**Roll back when the install itself is broken:**

1. **No CE ribbon at all** after AutoCAD starts (the CE tab is missing).
2. **AutoCAD crashes or hangs** on start-up, or on a command that worked yesterday (CD, CDEDIT, PIPE_OBJECT).
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

**How to read a backup name.** `CE_CVL_SUITE_PRE_b72029d9_20261007-211609.backup` means: the version that was live (commit `b72029d9`) until 7 Oct 2026 at 21:16:09 (PC clock), when the next install took it out. The date is when it was REPLACED, not when it was built. Pick by the version number inside, using the list in section 4, and check it first (next block).

**Step 3. Check the backup really is the version you want.** Example: the Civil backup that should read 3.0.32.

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_PRE_b72029d9_20261007-211609.backup\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion
```

**Step 4. Civil and Manager: move the new ones aside (worked example: back from 3.0.33 / 1.1.33 to 3.0.32 / 1.1.32).** The new name must NOT end in `.bundle`, or AutoCAD loads it as well.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle" -NewName "CE_CVL_SUITE_ROLLEDBACK_3.0.33.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle" -NewName "CE_SUITE_MANAGER_ROLLEDBACK_1.1.33.backup"
```

**Step 5. Civil and Manager: bring the matching pair back.** Both names carry the same commit and stamp. Do both, never one.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_PRE_b72029d9_20261007-211609.backup" -NewName "CE_CVL_SUITE.bundle"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER_PRE_b72029d9_20261007-211609.backup" -NewName "CE_SUITE_MANAGER.bundle"
```

**Step 6. Structural only (worked example: back from 1.0.103 to 1.0.102).** Skip this step if Structural is fine.

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle" -NewName "CE_STRUC_SUITE_ROLLEDBACK_1.0.103.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE_PRE_a3513ddd_20261007-212133.backup" -NewName "CE_STRUC_SUITE.bundle"
```

**Step 7. Read the version off each live DLL.** Expected after the example: 3.0.32, 1.1.32 and 1.0.102 (the text after the `+` is the build code, ignore it).

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Modern\CE_CVL_SUITE.dll").VersionInfo.ProductVersion
```

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle\Contents\Win64\Modern\CE_SUITE_MANAGER.dll").VersionInfo.ProductVersion
```

```powershell
(Get-Item "$env:APPDATA\Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle\Contents\Win64\Modern\CE_STRUC_SUITE.dll").VersionInfo.ProductVersion
```

`Modern` is the AutoCAD 2027 copy. Colleagues on AutoCAD 2025 to 2026 read the `Net8` folder, and 2022 to 2024 the `Legacy` folder. The version number is the same in all three.

**Step 8. Start AutoCAD.** Read the CE version on the status bar, or type CEMANAGER and open the Module page. Both must show the older number. Then open one drawing and run one command you trust (CD, then CDEDIT on a pipe).

## 4. WHICH PAIRS GO TOGETHER, AND WHAT EACH BACKUP RESTORES

Read from the DLLs in each backup folder on 7 Oct 2026, not from memory. Live today: Civil 3.0.33, Manager 1.1.33, Structural 1.0.103.

**Civil + Manager (always the pair with the SAME commit and stamp):**

1. **Back to 3.0.32 and 1.1.32.** `CE_CVL_SUITE_PRE_b72029d9_20261007-211609.backup` and `CE_SUITE_MANAGER_PRE_b72029d9_20261007-211609.backup`. This is the one to use for "the last install misbehaves".
2. **Back to 3.0.31 and 1.1.31.** `..._PRE_88bf32d8_20261005-091304.backup` (both).
3. **Back to 3.0.30 and 1.1.30.** `..._PRE_88e63589_20261004-121606.backup` (both).
4. **Back to 3.0.29 and 1.1.29.** `..._PRE_fe9c22ac_20261004-095043.backup` (both).
5. **Back to 3.0.28 and 1.1.28.** `..._PRE_909f4bbd_20261004-070617.backup` (both).
6. **Older pairs exist down to 3.0.16 and 1.1.16** (1 Oct). Read the version first (Step 3) before using one.

**Structural alone:**

1. **Back to 1.0.102.** `CE_STRUC_SUITE_PRE_a3513ddd_20261007-212133.backup`. The one to use for "the last install misbehaves".
2. **Back to 1.0.101.** `CE_STRUC_SUITE_PRE_8e88af4e_20261005-100626.backup`.
3. **Back to 1.0.100.** `CE_STRUC_SUITE_PRE_f9366a50_20261004-120517.backup`.
4. **Back to 1.0.99.** `CE_STRUC_SUITE_PRE_5807a1a9_20261004-094518.backup`.
5. **Older ones exist down to 1.0.87** (2 Oct).

**Not covered by this guide:** `CE.AutoCADLink.2027.bundle` (last changed 23 Jul) and `CE.Transform.Trial.2027.bundle` (last changed 7 Sep). The last three installs did not touch them and no `_PRE_` backups exist for them.

**Your settings are not part of the bundles.** A rollback leaves these alone: `%APPDATA%\CE_CVL_SUITE`, `%APPDATA%\CE_STRUC_SUITE`, `%APPDATA%\TIM_CE_CADTOOLS`. Before each install a copy was taken: `C:\ce_rc_scratch\settings_pre_1031` (before Civil 3.0.33 and Manager 1.1.33) and `C:\ce_rc_scratch\settings_pre_1032` (before Structural 1.0.103). Only copy a file back from there if the older version refuses to read a setting. Do not restore settings by default.

## 5. HOW TO UNDO THE ROLLBACK

Close AutoCAD first (Step 1 again). Then reverse each rename: the live folder goes back to its `_PRE_` name, and the `ROLLEDBACK` folder becomes the live bundle. Example, Civil and Manager back to 3.0.33 and 1.1.33:

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle" -NewName "CE_CVL_SUITE_PRE_b72029d9_20261007-211609.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER.bundle" -NewName "CE_SUITE_MANAGER_PRE_b72029d9_20261007-211609.backup"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_CVL_SUITE_ROLLEDBACK_3.0.33.backup" -NewName "CE_CVL_SUITE.bundle"
```

```powershell
Rename-Item -LiteralPath "$env:APPDATA\Autodesk\ApplicationPlugins\CE_SUITE_MANAGER_ROLLEDBACK_1.1.33.backup" -NewName "CE_SUITE_MANAGER.bundle"
```

For Structural, the same pattern: live `CE_STRUC_SUITE.bundle` back to `CE_STRUC_SUITE_PRE_a3513ddd_20261007-212133.backup`, then `CE_STRUC_SUITE_ROLLEDBACK_1.0.103.backup` to `CE_STRUC_SUITE.bundle`. Read the versions again (Step 7).

## 6. WHAT TO WRITE DOWN FOR THE NEXT FIX

A fix can only be built if we know what went wrong. Before you roll back, if you can, write down:

1. **Version before and after.** For example "3.0.33 / 1.1.33 / 1.0.103 to 3.0.32 / 1.1.32 / 1.0.102" (from Step 7).
2. **What you did in AutoCAD.** The command, what you clicked, what you expected, what happened. One drawing name is enough.
3. **A screenshot** of any error box or of the missing ribbon.
4. **Copy the CE logs before you start AutoCAD again.** Civil: `%APPDATA%\CE_CVL_SUITE\logs` (file `CE_CVL_SUITE.log`). Shared tools: `%APPDATA%\TIM_CE_CADTOOLS\logs` (files `CE_CVL_SUITE.log` and `CE_STRUC_SUITE.log`). Structural also writes `%APPDATA%\CE_STRUC_SUITE\logs\ce_struc_suite.log`. Copy the whole `logs` folders to your desktop.
5. **Put it in the bug file** `C:\CE_PLAN\BUG_CARPARK.md` (or tell the release chat). A bug is only closed when you have confirmed the fix in AutoCAD.

## 7. DO NOT DO THIS

1. **Do not use `Install-CECvlSuite.ps1` or `Deploy-Local-AsAdmin.ps1`.** Both are retired. The old deploy script does not make a backup and does not keep CE_SHARED matched.
2. **Do not roll back Civil without Manager** (or Manager without Civil). Missing CE ribbon.
3. **Do not delete the new bundle.** Rename it. It is the evidence for the fix.
4. **Do not name the moved-aside folder with `.bundle` on the end.** AutoCAD loads every `.bundle` folder it finds.
5. **Do not copy files from one version into another by hand** (one DLL or one lane). Rename whole folders only.
6. **Do not do this with AutoCAD open**, or while Codex is running a test in AutoCAD.
7. **Do not mix backups from different stamps** (a Civil 3.0.31 with a Manager 1.1.32).
8. **Do not restore settings by reflex.** They are separate from the version.

---

**Technical notes (nothing here is needed to roll back):**

1. **How the backups are made.** Each install script renames the live folder to `<name>_PRE_<shortsha>_<yyyyMMdd-HHmmss>.backup`, copies the new bundle in, then checks every file against a manifest (Civil 822 files, Manager 78, Structural 2007) and that Civil and Manager hold an identical CE_SHARED. If the copy fails the script renames the backup straight back.
2. **Why the pair.** Civil and Manager each carry CE_SHARED.dll at assembly version 1.1.0.0. AutoCAD loads every CE plugin in one process, so the first copy loaded is used by all. The file differs from one release to the next (hash starts B617D42F for Legacy in 3.0.33 and 5A902C2D in 3.0.32).
3. **Sources.** `C:\ce_rc_scratch\install_c27.log` to `install_c31s.log`, the two install scripts in the session scratchpad, and the memory note `ce-shared-one-assembly-identity`.
