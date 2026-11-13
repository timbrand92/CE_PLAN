# Finding: the installer build fails at the native step since Thu 12 Nov 22:04 (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, 12:10 PC clock. **Found by:** the Trial A payload build (INSTALL_TRIAL_13NOV.md). **Nothing in the repository was changed for this.**

## FOR TIM

1. **The build that makes an install package for Civil now stops part-way, on this PC.** Visual Studio updated itself on Thursday night (12 Nov, 22:04) and removed the exact C++ compiler version two of CE's small native parts ask for by number. The CE code itself still builds; only the native grip and object-enabler parts stop.
2. **Nothing you use is affected.** What is installed in AutoCAD is unchanged by this. It only matters the next time anyone builds an install package.
3. **The fix is one line in each of two project files** (ask for the newer compiler, or any compiler of that family). It is for whoever makes the next release, through the normal review; not done here.

## DETAIL

1. **The pin:** `Modules\Drainage.NativeGrip2027\CE_CVL_NATIVE_GRIP_2027.vcxproj` line 21 and `Modules\Drainage.NativeObjects2027\CE_CVL_OBJECTS_2027.vcxproj` lines 27 and 35 set `<VCToolsVersion>14.50.35717</VCToolsVersion>` (pin added with the grip module, commit a74714bf, 2 Sep 2026).
2. **On this PC now:** `C:\Program Files\Microsoft Visual Studio\18\Community\VC\Tools\MSVC\` holds only `14.51.36231` (folder dated Thu 12 Nov 2026, 22:04). 14.50.35717 is gone.
3. **The failure:** `Installer\build_installer.ps1` line 215/216, `error MSB8070: Cannot find MSVC toolset version '14.50.35717'`, then "Native action-grip build (AutoCAD 2027) failed." The three managed lanes (Legacy, Net8, Modern) had already built.
4. **The work-around used for the trial only:** an uncommitted `Directory.Build.rsp` containing `/p:VCToolsVersion=14.51.36231` in the two native project folders of the trial's staging worktree (`C:\CE_WORK\build\wtA13`). MSBuild reads that file automatically. It is never committed or pushed and is removed with the worktree. The trial package then carries the INSTALLED native files anyway (pull request 2073 changes no native source), so the trial does not depend on the newer compiler's output.
5. **Choices for the real fix (for the release owner, not decided here):** pin `14.51.36231`; or remove the `VCToolsVersion` line so the project takes the newest v145 compiler installed; or install the 14.50 component again through the Visual Studio Installer. A native binary built with a different compiler is a new binary: the #78 native policy (byte-identical natives unless the release ships new natives on purpose) still applies.
