# Train C-56 finalizer report (Civil + Manager), Tue 20 Oct 2026

## ANSWER FIRST

1. **Verdict: GO.**
2. **Final head:** `claude/rel-20261020j` at `8d0eb8f2540bf80d8000ce82b211e2ededebb229` (ls-remote equal to the assembly report at my start and at my end). Base: the installed line `claude/rel-20261020i` @ `6c2bc2c7` (Civil 3.0.65 / Manager 1.1.65, C-55).
3. **What I changed:** nothing on the train. No commit, no push to the plugin repo. No fix was needed.
4. **Manager must ship: NO.** No file under `Modules/Manager` or `Shared/` changed (0 files, checked with `git diff --name-only 6c2bc2c7 8d0eb8f2`). Civil and Manager keep the same CE_SHARED (the Manager release build below checked it against the Civil build's three CE_SHARED copies by hash).
5. **The installer PROGRAM must be rebuilt and published (BUG-834).** #1492 changes `Installer/`. The deploy/payload step must rebuild the Civil installer (`Installer/build_installer.ps1`) and publish it, or BUG-834 is not live on any PC. Rebuilding only the plugin DLLs is not enough.
6. **Tests (Release, head 8d0eb8f2):**
   1. **Whole solution:** 0 errors, 889 warnings (the usual count). Installer.Tests compiled, not run (rule).
   2. **Civil net10 full:** 19,035 total, 19,015 pass, 19 skipped, 1 failed (Glen Eira back-test, the known red).
   3. **Manager net10 full:** 832 of 832.
   4. **Civil net48 focused:** 288 of 288 (RedoSafe, DoubleClick, Bug825, Bug834, Bj33, Bj34, SettingsWindowV3, SettingsPersistence).
   5. **Civil installer build (`build_installer.ps1`):** completed, 0 errors; all three plugin lanes, the grip module and the object enabler verified by hash; the published `CE_CVL_SUITE_Installer.exe` contains the new office-approval code. **Proof of build only, not a shippable installer:** its payload carries the 0-byte transform placeholder, so it was deleted with my worktree.
   6. **Manager release build (PrepareReleaseBundle):** "Complete 75-file, three-lane release candidate verified", 0 errors (IT Admin publish skipped).
7. **What Tim will see in AutoCAD (once installed):**
   1. **Step irons (BUG-825):** a 1000 mm step-iron depth he types in CDS stays 1000 after closing and reopening AutoCAD. An old settings file that still holds CE's old 1000 shows one command-line line once: "CE moved the step-iron depth from 1000 mm to 900 mm ... This happens once." **His own file holds 900 today, so he sees no change.**
   2. **Installer (BUG-834):** nothing in AutoCAD. When CEMANAGER updates a PC, an update older than the office-approved version is refused with "This staged update is version X, which is older than version Y, the one the office approved for this PC. Nothing was changed." Anything newer installs as before.
   3. **Settings window (CDS and CEMANAGER > Settings > Civil):** a new eighth tab, **Fixes**, with ticked boxes under Pit Schedule fixes, Long section fixes, Drafting fixes and Tidy labels (more). One new box on Survey (unticked), one on Design (PIPE CHECKS, ticked), one on Advanced (heartbeat, ticked). Nothing behaves differently unless someone unticks a box.
8. **Do not mark FIXED:** BUG-825 (step-iron half), BUG-834. Both only unit-tested; neither driven in AutoCAD or through a real CEMANAGER update. The Fixes tab and the three new boxes (#1494, #1495) need a Codex look at the real window (a window is never accepted by a machine).
9. **Switches without a Settings row:** none known now. The two on the standing list (`linking.tidyIgnoresSheetFrame`, `fleetTelemetry.heartbeatEnabled`) got rows in #1495. This train adds no new switch.
10. **Risks:**
    1. **LOW installer not live until republished** (item 5).
    2. **LOW the installer's office-folder finder is a second copy of Manager's** (same three folder names, checked line for line). If Manager's ever changes, the installer's must too. A source guard tying them together is still owed (review 1500).
    3. **LOW wording:** the "Show the Older longitudinal tab" tooltip says "Tim decides when to hide it (ruling of 18 Oct ...)"; colleagues read this. Words only (review 1502). Not changed: ruling A is bug fixes only.
    4. **LOW looks:** on the CEMANAGER Civil page the new "Survey" group sits beside the existing "SURVEY" group, and "Detention" is not in capitals (review 1503).
    5. **Tim's `CD_Settings.json` was NOT unchanged during my run** (see section 5.5). It went back to the content it held before 21:03 (acd64e79). The likeliest writer is the Codex AutoCAD test (V2b) that had AutoCAD open from 21:03; I did not prove it.

## 1. Re-review of MERGE-WITH-FIXES PRs

1. **None on this train.** All four merged PRs had a MERGE verdict (Opus entries 1499, 1500, 1502, 1503), each with LOW notes only.
2. **Reviewed head = merged head for all four** (checked the second parent of each merge commit): #1491 d30aac59 (merge 5b01623c), #1492 980d2f65 (971fb3e3), #1494 e33719c6 (672baf2c), #1495 c7333338 (8d0eb8f2).
3. **No merged PR lacks a review entry.**
4. **Shared/:** unchanged (0 files). Modules/Manager: unchanged (0 files). Installer/: changed by #1492 only.

## 2. Adversarial review of each merge diff

1. **#1491 BUG-825: GO, 0 fixes.**
   1. **Runs once:** the step-iron move now sits behind `firstOldValueMove`, read before the once-only block sets `options.oldStartingValuesMoved`. Before, it ran at every start, outside that block.
   2. **A deliberate 1000 afterwards stays:** yes; with the flag saved, the move is skipped (test `A1000TypedAfterTheStepIronMove_SurvivesTheNextStart`).
   3. **First run on a fresh install / an old file still does today's move:** an old file with no flag and 1000 moves to 900 and says so once. A brand-new settings file is written with the flag set and the 900 default, so there is nothing to move.
   4. **Settings record of the one-time flag:** `options.oldStartingValuesMoved` in CD_Settings.json, written with the next real settings save (same as the velocity and label-height moves). Not an engineering value, so no Settings row is needed (R-00).
   5. **Edge, LOW, unchanged from before:** if nothing is ever saved after the first start, the flag is not on disk and the one-line message can repeat at the next start. Same as the existing velocity move; the value is not moved twice wrongly.
   6. **Tim's file:** read-only check: no flag, step iron 900. So on his PC nothing moves and nothing is said about step irons.
2. **#1492 BUG-834 INSTALLER: GO, 0 fixes.**
   1. **Reads approved.json itself:** only in the real entry point (`Run(string[] args)`); the test overload never reads the office folder (source guard test). Path: `<IT Admin>\CE Plugin Admin\releases\<plugin>\approved.json`, the same place Manager writes (checked `CeAdminStorageService`).
   2. **Refuses only a stage older than approved:** the refusal is `ApprovedVersionError`, which returns nothing when the approved version is blank or the stage is the same or newer. Only "Approved", "Rolled Back" or a blank status counts; "Canary", a missing, damaged or unsafe file gives "not known" and nothing is added.
   3. **Warns and continues otherwise:** the existing older-than-installed warning is unchanged and still only a warning.
   4. **Cannot delete anything:** the new code only reads two files (the stage record and approved.json); a plugin name with a slash, colon or ".." is refused. No delete, copy or write was added.
   5. **Signed-update gate (OfficialReleaseGate): cannot be affected.** `Shared/CE.Release` is untouched. The new check runs after `CeOfficialReleaseGate.Verify` has already passed and can only add a refusal. It changes no key, no hash, no signature check. The one other changed line (a version missing its last part reads as .0) is used only by the stage guard's own compare.
   6. **Installer.Tests:** compiled in the solution build, 0 errors; not run (rule).
3. **#1494 Codex Fixes tab: GO, 0 fixes.** 18 rows. Every row is bound to an existing key with the exact UserSettings.cs name (17 in LinkingSettings, `SchedulePairRowsByOrderOnlyWhenSafe` in XcivilImportSettings), all default ON in UserSettings.cs and unchanged. Load reads the saved value; Save writes only rows the user changed (I checked every Save pair by script: 18 of 18 write the property of the same name). No engineering number; not in the Design Standards group.
4. **#1495 Codex more rows: GO, 0 fixes.** 17 rows: 14 Linking, `Survey.SurveyReadsMTextAndMoreTags` (default OFF, shown unticked), `Detention.DetentionWithoutLengthNotDiameterChecked` (Design tab, PIPE CHECKS), `FleetTelemetry.HeartbeatEnabled` (Advanced, in FleetTelemetrySettings.cs). All exist with the exact names; Save pairs 17 of 17 by script; defaults unchanged (`git diff` of `Modules/Drainage/Models` is empty). No number added; not in Design Standards.
5. **Every XAML binding added** points at a property that exists in the view-model (checked by script).
6. **A window is never accepted by a machine:** a Codex look at the real Fixes tab, Survey, Design and Advanced tabs in AutoCAD is still needed.

## 3. New defaults

1. **Switches or defaults added by the train:** none. No key was added to UserSettings and no default changed.
2. **Behaviour change without a switch:**
   1. **Step-iron move once only (#1491):** old behaviour (moving 1000 back to 900 at every start) is itself the bug, BUG-825. No switch needed. Tim's PC: no visible change (his file holds 900).
   2. **Installer refuses an older-than-approved stage (#1492):** old behaviour (silently installing an older build) is itself the bug, BUG-834, Tim's "yes" (20 Oct item 7). No switch needed. Nothing in AutoCAD changes.
   3. **New Settings rows (#1494, #1495):** show existing values only; nothing changes until someone unticks a box.
3. **Nothing had to be turned OFF.**
4. **Switches without a row:** none known (both standing ones got rows in #1495).

## 4. Installer safety

1. **#1475 is not on this train** (landed earlier, entry 1481). The installer change on C-56 is #1492.
2. **OfficialReleaseGate: unchanged and cannot be affected** (section 2.2.5).
3. **Not live until the installer is rebuilt and published** by the deploy route.

## 5. Test evidence

1. **Environment:** private worktree `C:\ce-fin\c56` (detached at 8d0eb8f2), Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, 0-byte `CE_TRANSFORM_2027.arx` placeholder, AutoCAD 2027 folder and git on a short PATH, fresh TEMP and CE log folder (inside TEMP) per step, Below Normal. Build lock held only while each command ran (waits of 20 s to 2 min for other jobs). Every command in the foreground. Run 21:18 to 21:37.
2. **Timings:** solution 2.3 min; Civil net10 6.0 min; Manager under 1 min; net48 focused under 1 min; installer build 2.4 min; Manager release build under 1 min.
3. **Civil net10 failure:** only Glen Eira, the known red, in code none of these PRs touches. No new red, so no base comparison needed.
4. **Manager release build** needs the Civil CE_SHARED lane folder and its three hashes; I used the installer build's own payload (`Legacy 4C70A83A`, `Net8 1DCDE927`, `Modern D6530272`).
5. **Tim's settings files (before / after my run):**
   1. `TIM_CE_CADTOOLS\CS_Settings.json` 622a246f / 622a246f unchanged.
   2. `CE_CVL_SUITE\settings.json` efe307c4 / efe307c4 unchanged.
   3. `CE_STRUC_SUITE\CS_Settings.json` f68eeb5e / f68eeb5e unchanged.
   4. **`TIM_CE_CADTOOLS\CD_Settings.json` 9d27b04c (15,302 bytes) at 21:15 / acd64e79 (15,270 bytes) at 21:37: CHANGED, not by me.** It is now the same content as before 21:03 (the assembler's "before" hash), with a file time of 4 Oct 08:22, so it was put back from a copy. AutoCAD (acad.exe) was running from 21:03 (the Codex V2b test, committed 21:27) and had closed by 21:37. My runs touch only redirected test folders. Likeliest cause: the Codex test swapping Tim's file and restoring it. Not proven.
6. **Not run:** Installer.Tests (compile only), Structural, full net48, anything in AutoCAD or accoreconsole.

## 6. Hygiene

1. Worktree `C:\ce-fin\c56`, `c56logs` and `c56tmp` removed (`git worktree remove --force`, then prune). `C:\ce-fin\logs` is not mine and was left.
2. **The installer build writes a release archive outside the worktree** (`C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE\20261020_213551_v2026.1020.2133`). I confirmed it was mine (its record names my worktree) and deleted it, so nobody mistakes it for a real release. The older archives were left.
3. No PR closed, no branch deleted, no version bumped, nothing installed or deployed, DESK_LOG.md not edited. The plugin checkout's working tree is as found.
4. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.
