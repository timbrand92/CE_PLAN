# Train C-76 assembly report (Civil + Manager, bug-fix train of four PRs: #1834 BUG-859, #1835 BUG-372, #1836 BUG-090, #1837 BUG-1228), Thu 29 Oct 2026 (real clock 10:27 to about 11:45 Melbourne)

Sonnet 5.5, headless assembler. Built and unit-tested only. Not installed. Nobody has opened any of these four PRs in AutoCAD. No PR closed or retargeted, no branch deleted, no bug marked FIXED, no version bumped, `DESK_LOG.md` and `BUG_CARPARK.md` not edited. None of the four PRs has had an independent read.

## ANSWER FIRST

1. **GO to the finalizer.** Branch `claude/rel-20261029a`, head `dced33cf79c25732d4768882a0a721cdd0438451`, pushed (normal push, never forced). Four merge commits, one per PR, no squash, no rebase.
2. **Base used:** `claude/rel-20261026z` tip `09126560f98acc4fd6ca4be298d087307a89a259`, the C-75 version commit "Version: Civil 3.0.85 / Manager 1.1.85 (C-75)". It is a descendant of the finalizer's signed head `1dec83de` (checked with `merge-base --is-ancestor`); the only commit above `1dec83de` is that version commit. The four version places on my branch still read 3.0.85 / 1.1.85 (not bumped; the payload builder stamps 3.0.86 / 1.1.86). The C-75 finalizer report's first block reads "1. **GO at `1dec83dedb60267c4fbc238b5ba30d69ca3b14b5`.**".
3. **Installed (read-only .ps1 FILE):** all six DLLs (Civil and Manager, Legacy, Net8 and Modern) read product version `3.0.85+09126560...` (Civil) and `1.1.85+09126560...` (Manager). That is the acceptable assembler state. Structural is not in this train.
4. **PR list read:** `C:\CE_PLAN\areas\TRAIN_C76_PR_LIST_2026-10-29.md`, last commit `fb28f181`. Its LATE ADDITIONS section had **BUG-1228 PROMOTED** (PR #1837, merge after #1836) and **BUG-1229 NOT PROMOTED** (skipped: no PR, no report). So this is a train of FOUR, not three.
5. **Merge record (each live head equal to the list's reference head, none moved, all OPEN, all draft, base `claude/rel-20261026z`; gh, `ls-remote refs/pull/<n>/head` and `ls-remote refs/heads/<branch>` agreed):**
   1. #1834 head `9b2da5c323e396f07976f8426a66604339b93076` -> merge `ba960c95b3ee6149c69d0916f7176af1da408d4c`. Clean, no clash.
   2. #1835 head `96a7b65ebe35dd44cbc863ce8e59ca18c3b260b0` -> merge `8d5421d45230f654c8fb929f1181325aa0da2620`. Clash in `REGRESSION_LOG.md` only.
   3. #1836 head `3db30bfeeb2430c3ba7249179c36dbcd06470833` -> merge `77c11854c2fe08d703c8bff5c6e7fa637e3f089b`. Clash in `REGRESSION_LOG.md` only.
   4. #1837 head `157013c4a3d3a6d37dd2877f76935e4c4e184eec` -> merge `dced33cf79c25732d4768882a0a721cdd0438451`. Clash in `REGRESSION_LOG.md` only; `UserSettings.cs` **auto-merged with no clash**.
   5. The second parent of each merge equals the live head merged (checked after each). The PR's own numstat equalled the merge's own numstat for all four, so the merges carry nothing else.
6. **Clash blocks:** only `REGRESSION_LOG.md` (three times). Resolved by keeping every entry, newest merge on top (order now #1837, #1836, #1835, #1834, then C-75 entries), zero conflict markers, and the count of headings with no blank line before them is 97 on the base and 97 after (equal). Each resolved commit adds exactly 14/0, 14/0, 15/0 lines to the log (57/0 in total against the base). No code logic was hand-resolved.
7. **Settings (differs from the job text because of #1837):** **four Civil keys and one Manager switch** were added, nothing else. ON: `doubleClick.sourceStopsAttributeEditorFirst` (#1834), `checks.cdcheckLinesShowNoInternalIds` (#1835), `linking.sourceLandingReadsEachObjectOnce` (#1837), Manager `aboutWindowFitsItsRows` (#1836). OFF (diagnostic, writes one CE log line per read, changes nothing in the drawing): `linking.sourceLandingTimingLog` (#1837). `UserSettings.cs` is 29/0 (10 from #1835 plus 19 from #1837, two separate properties each), `DoubleClickSettings.cs` 13/0, `DiagSettings.cs` EMPTY diff. All the other defaults listed in the job text read as expected (see item 11 of the scope check).
8. **Manager code IS changed (#1836): Manager 1.1.86 is a real change, not a re-stamp.** `git diff --stat <base>..HEAD -- Modules/Manager Modules/Manager.Tests` lists exactly three files: `Modules/Manager/Services/CeOneGlanceStatus.cs` (35 added), `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs` (14 added) and `Modules/Manager.Tests/UI/Bug090AboutWindowRowsTests.cs` (121 added, new): 170 added in all. (The job text's "14 added" for the window file is the number I read.)
9. **Shared and Installer:** nothing under `Shared/`, `Installer`, `Installer.Tests`, `Modules/Manager/Installer`, `Modules/Arch.Tests` or `Modules/Arch.Tests.Structural` changed (all empty). Civil and Manager still ship a byte-identical CE_SHARED. No `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx`, `.xaml`, `.github`, `PackageContents.xml`, `command-registry.json`, `ce_toolbar_layout.json`, `ce-tool-register.json` or any sign/Release/deploy file changed. The Manager bundle file-count guard stays 75 (no bundle file added; the Manager DLL changes in content only).
10. **Build:** whole solution Release, `-m:1`, **0 errors**, 910 warnings (the known NU1903 package warnings), 27 min 58 s. Built: Drainage and Manager for net48, net8.0-windows and net10.0-windows; Drainage.Tests net48, net8.0-windows and net10.0-windows; Manager.Tests net10.0-windows; `Tests\CE.TestHarness.Tests` net10.0-windows built (it links only a few Manager helper files, **not** `CeOneGlanceStatus.cs`, so #1836 does not touch it); `Installer.Tests` (net9.0-windows) and its fixtures COMPILED, not run.
11. **Tests:**
    1. **Civil net10 Release full: 20,888 total, 20,856 passed, 32 skipped, 0 failed** (12 m 36 s). That is the C-75 floor 20,806 plus 29 + 29 + 24 = 20,888 exactly (#1837 adds 24 tests). Nothing went missing. The PDF page test and the Bug960 palette test both PASSED (nothing to re-run).
    2. **Manager net10 full: 1,056 total, 1,055 passed, 1 skipped, 0 failed** (22 s), exactly the expected size.
    3. **Manager net48:** build 0 errors, 0 warnings (the solution build had already built it; my separate build was incremental, 2 s).
    4. **Civil net48 focused (class-name filters, 3,684 total): 3,437 passed, 141 skipped, 106 failed, all 106 `InvalidProgramException`** from the reference-only AutoCAD DLL. 84 of them are exactly the C-75 assembler's 84 names. The other 22 are in seven classes my wider filter picked up that the C-75 filter did not (Bug270ReachUnitsTests 6, PipeEndJoinTests 6, Bug271ReachUnitsTests 5, LpdNotePlacementTests 2, StripDrainFallArrowReadbackTests 1, R3BatchGuardTests 1, Bug1000XcivilTranslateSpotFallTests 1). **I built the C-75 base (`09126560`) for net48 and ran those seven classes: 26 reds on the base, a superset of the 22.** So there is no red on the merged head that is not red on the base. The new classes pass on net48: `Bug859AttributeEditorStoppedFirstTests` 29/29, `Bug372CdCheckNoInternalIdsTests` 29/29, `Bug1228DpSpeedTests` 24/24, `CdCheckCommandLineArrowTests` 9/9, all `C70` to `C75NewSwitchDefaultsTests`, `SettingsWindowV3Tests` 34/34. Reds in the 84: `Bug260ArrowTurnTests` 10, `PipeEditCommandDataCollectionTests` 8, `C5RefreshDirectionTests` 4, `Bug1222EditPipeArrowReadTests` 7, `C5MixedUnitsTests` 4, and the older 55 names (all fail on the base too).
    5. **Named classes on net10 (all passed):** `RedoSafeCallGraphTests` 25/25 (baseline file untouched; the net48 run shows 25 passed and 2 not executed), `PickHandlerProbeTests` 7/7, `InspectorPalette*` 13 + 5 + 22 passed, `Bug861RedoFirstClickTests` 4/4, `Bug861DiagSwitchesTests` 36/36, `Bug861Diag2SwitchesTests` 25/25, `Bug1225ReopenedDrawingRecordTests` 17/17, `Bug859AttributeEditorStoppedFirstTests` 29/29, `Bug372CdCheckNoInternalIdsTests` 29/29, `Bug1228DpSpeedTests` 24/24, `OvernightLabelDoubleClickAndCopyTests` 5/5 (including `ProductionTextRoute_UsesCacheBeforeAnyCommandStartTransaction`), `C75NewSwitchDefaultsTests` 24, `C74` 11, `C73` 11, `C72` 7, `C71` 6, `C70` 25 (all passed, no count changed), `C60AuditSourcePinGuardTests` 42 (39 passed, 3 skipped, includes `NewSettingsKeys_NeedADocumentedDefault` PASSED), `CivilAutomationTests` 28/28, the back-test `BackTest_GlenEira24115_IssuedDischarge_WithinTolerance` and `GlenEira24115_EnginesOwnDischargeSum_WithinTwentyPerCentOfTheIssuedSheet` PASSED. `SettingsWindowV3Tests` 34/34 on net10 including `EveryTab_FitsTheScreen_AtOneFixedHeight` (no Settings window change in this train).
    6. **Manager by name (net10, all passed):** `Bug090AboutWindowRowsTests` 15/15, `TestHygieneAppDataGuardTests` 10, `TestHygieneOfficeFolderGuardTests` 4, `CeAdminPluginOutboxDrainTests` 19, `CeAdminPolicyServiceTests` 21, `CeAdminUploadTempFilesTests` 1, `ManagerSwitchFileTests` 49, `C69ManagerSwitchDefaultsTests` 9, `CeRunningVersionTests` 2.
    7. **Arch smoke (Civil half, net10):** `CE_ARCH.Tests` 14 of 14 passed (restored alone first, 78 s). The Structural half is KNOWN RED 3 of 4 on this Structural line and was not run.
    8. No test needed a re-pin. I made no commit of my own on the branch beyond the four merges.
12. **For the finalizer:** (a) #1837 is bigger than the other three and rewrites most of `LinkService.SourceChangeCapture.cs` (121/104), `LinkService.SourceLanding.cs` (79/62) and `LinkService.Geometry.cs` (101/15): the Civil product diff is 14 files, not the eight in the job text. Read it against the C-75 text of `SourceLanding.cs` (a file C-75's #1833 changed). The author did not measure the new DP time; only the robot can. (b) The hit list below includes #1834's one `DocumentLockModeChanged +=` with its `-=`, one `Veto()`, `try`/`catch`, an open-close ForRead transaction and a `GetSystemVariable("REFEDITNAME")` read. I do not judge them. (c) `UserSettings.cs` has two separate additions (#1835 and #1837) and the finalizer's `C76NewSwitchDefaultsTests` must pin all four Civil keys.
13. **Not tested:** AutoCAD. Nobody has run #1834, #1835, #1836 or #1837 in AutoCAD. Whether AutoCAD honours #1834's veto is the one thing only the robot case R09 can prove. The Manager About window (#1836) needs a Codex look. The Structural About window is unchanged on purpose. The time DP takes after #1837 is unmeasured. `Installer.Tests` were compiled, never run. Display scaling above 100 percent was not measured.

## 1. Mistakes and notes first

1. **No fault in the merges.** My first attempt to build a base-compare script used sed on a Windows path and mangled the backslashes (the known trap); I rewrote it with the Write tool before using any of its output. The first net48 compare I ran against a missing file printed wrong "not in C-75" numbers; I discarded it and the final compare (a script file) reads: C-76 reds 106, reds not in either base list 0.
2. **Manager net48 build:** my separate build did nothing new (2 s) because the solution build had already built it; the net48 evidence is the solution build.
3. **AutoCAD (`acad.exe`) was open** during every test step from Civil net10 onwards (count 1; not during the solution build). I did not touch it, took no lock but the desk build lock, and ran no AutoCAD.
4. **Desk build lock:** the lock FILE was taken by me for every step (sln build, civil10, mgr10, named10, sfit, arch10, mgr48build, civil48f: "lock taken") and removed after each; it did not exist at the end. My base net48 build and test (7 classes) ran without the lock, in my own worktree, with its own TEMP for the test step.
5. **Builds used the normal TEMP**; test steps used a fresh TEMP and CE log folder under `C:\ce-asm\t76_<step>` (backslash form, long names). Free space on C: was 57 GB at the start, 79 GB after restores, 88 GB after the build and 90 GB at the end.
6. **Settings files, hashes before and after (CD_Settings.json `ACD64E79A33B`, CS_Settings.json in TIM_CE_CADTOOLS `622A246F7D3B`, CE_STRUC_SUITE CS_Settings.json `B3B5A004B929`, CE_CVL_SUITE settings.json `EFE307C4FC74`): unchanged** (same sizes and times, 10:31 and 11:34). `%APPDATA%\CE_SUITE\manager-switches.json` does not exist (nor the folder), before or after.

## 2. Merge record and scope check

1. **Heads read at merge time:** see answer item 5. No PR moved since the reference; no extra change to read.
2. **Numstat per merge (the PR's own diff equals the merge's own diff each time):** #1834 5 files 414/0; #1835 8 files 403/16; #1836 4 files 184/0; #1837 9 files 1,071/181.
3. **Whole branch against the base `09126560`: 22 files changed, 2,072 added, 197 removed.** The list expected 15 distinct files for three PRs (1,001 added, 16 removed) plus #1837's eight non-log files (1,071 added, 181 removed less the log's 15): consistent. `REGRESSION_LOG.md` 57/0 (14 + 14 + 14 + 15), `UserSettings.cs` 29/0, `DoubleClickSettings.cs` 13/0.
4. **Civil product files (14, not eight, because of #1837):** `Commands/SpineCheckCommand.cs`, `Models/DoubleClickSettings.cs`, `Models/UserSettings.cs`, `Rules/CdCheckLineWordingRule.cs`, `Rules/DoubleClickAttributeEditorStopRule.cs`, `Rules/OwnerScanMemo.cs`, `Rules/SourceLandingSpeedRule.cs`, `Services/CompoundEditModeService.cs`, `Services/FallArrowDirectionReviewService.cs`, `Services/LinkService.Geometry.cs`, `Services/LinkService.SourceChangeCapture.cs`, `Services/LinkService.SourceLanding.cs`, `Services/LinkService.SourceScanMemo.cs`, `Services/PipeEndReviewService.cs`. Civil tests: `Bug372CdCheckNoInternalIdsTests.cs`, `CdCheckCommandLineArrowTests.cs`, `Bug1228DpSpeedTests.cs`, `Bug859AttributeEditorStoppedFirstTests.cs`.
5. **Scope check results:** Shared empty; Installer, Installer.Tests and Manager Installer empty; Arch projects empty; `DiagSettings.cs` empty; config and PackageContents files unchanged (so no CrossModuleGuard count change); no sign, Release or deploy file; no `.csproj`, `.props`, `.targets`, `.ps1`, `.slnx`, `.xaml` or `.github` file; Manager exactly the three files above.
6. **Defaults read from the merged code (unchanged by the train):** `doubleClick.sourceEditWindow` true; the four C-75 keys `linking.rotateScaleCopyLikeCopy`, `pitCopyLineNamesOnlyWhatIsMissing`, `pipe.editPipeReverseArrowReadsDrawnEnds`, `linking.sourcePickComparesPipeRecordLikeForLike` all true; `linking.reopenedDrawingLoadsItsOwnRecord` true; `pipeSpeedChecks.useMaterialLimit` false; `detention.orificeUsesRuledGravity` true; `detention.detentionTabUsesCouncilOrificeCo` true; `sharedValues.pitDropFollowsBox` false; `linking.pasteLineForDrawingWithNoRecord` true; `linking.inspectorPickWaitsAfterUndo` true; `linking.cleanUpGripRotateScaleCopies` false; `linking.copyCleanUpKeepsEveryPiece` true; `surface.slabMinimumFalls` 100 (concrete) / 50 (pavers) / 67 (asphalt, per the class text); Manager `drainPluginOutbox` OFF (documented default in `CeAdminStorageService`). The nineteen `diag.redo` keys: all load OFF (`Bug861DiagSwitchesTests` 36 and `Bug861Diag2SwitchesTests` 25 passed). New: `doubleClick.sourceStopsAttributeEditorFirst` true, `checks.cdcheckLinesShowNoInternalIds` true, `linking.sourceLandingReadsEachObjectOnce` true, `linking.sourceLandingTimingLog` false, Manager `aboutWindowFitsItsRows` ON (no file, broken file, missing key or non-boolean value reads ON; only `false` turns it off).
7. **Worktrees removed at the end** (`C:\ce-asm\c76`, `C:\asm76\w`, `C:\asm76\b`, and my scratch TEMP folders under `C:\ce-asm\t76_*`). The scripts and logs stay under `C:\ce-asm` (`logs76`).

## 3. Read-the-merged-code appendix (diffs against the base, `09126560..dced33cf`)

1. **UserSettings.cs, added lines (all PRs: #1835 10 lines, #1837 19 lines):**
```diff
diff --git a/Modules/Drainage/Models/UserSettings.cs b/Modules/Drainage/Models/UserSettings.cs
index 267778e3..d8aa17f6 100644
--- a/Modules/Drainage/Models/UserSettings.cs
+++ b/Modules/Drainage/Models/UserSettings.cs
@@ -638,4 +638,23 @@ namespace CE_CVL_SUITE.Models
         public bool SourcePickComparesPipeRecordLikeForLike { get; set; } = true;
 
+        /// <summary>
+        /// BUG-1228 (MEDIUM): ON = when DP, OF, CDFW or another source reads the drawing to find where it lands, CE looks at each
+        /// drawing object in full once per read and remembers what it found (not a pit, not a source, or the pit's outline and the
+        /// source's connection), instead of re-reading every object in the drawing for each end of each pipe. The same pit, pipe
+        /// end or refusal is found; it is only found faster (on the robot's test drawing each read took about 5 seconds, and a
+        /// downpipe makes four). Nothing is written and nothing is unlocked. OFF = the old behaviour (every look reads every
+        /// object again). Fixes a fault, so ships ON. Not a block (R-27). Default: on.
+        /// </summary>
+        [JsonProperty("sourceLandingReadsEachObjectOnce")]
+        public bool SourceLandingReadsEachObjectOnce { get; set; } = true;
+
+        /// <summary>
+        /// BUG-1228 diagnostic (log only): ON = each source landing read (DP, OF, CDFW and the other sources) writes one CE log
+        /// line "[BUG-1228] ... in N ms" with how many drawing objects it read in full, passed over and reused, so the robot can
+        /// see where a slow placement spends its time. Changes nothing in the drawing or on the command line. Default: off.
+        /// </summary>
+        [JsonProperty("sourceLandingTimingLog")]
+        public bool SourceLandingTimingLog { get; set; } = false;
+
         [JsonProperty("pitLabelMaxDistanceMm")]
         public double PitLabelMaxDistanceMm { get; set; } = 5000.0;
@@ -3291,4 +3310,14 @@ namespace CE_CVL_SUITE.Models
         [JsonProperty("checksCommandEnabled")]
         public bool ChecksCommandEnabled { get; set; } = ChecksCommandEnabledDefault;
+
+        /// <summary>
+        /// BUG-372 (MEDIUM): ON = CDCHECK's command line names objects in words, never by a drawing handle or CE's internal id: a FALL
+        /// arrow line no longer says "handle 1197BB", a pipe end line no longer says "(handle 2A3)", and a connection row names a pipe
+        /// with no name "an unnamed pipe" instead of "CE-CIV-PIPE-6A33BA73-...". The saved list file keeps the handles and ids for
+        /// tracing. OFF = the old lines. Read only; nothing in the drawing changes. Fixes a fault, so ships ON. Not a block (R-27).
+        /// Default: on.
+        /// </summary>
+        [JsonProperty("cdcheckLinesShowNoInternalIds")]
+        public bool CdcheckLinesShowNoInternalIds { get; set; } = true;
     }
 
```
2. **DoubleClickSettings.cs, added lines (#1834):**
```diff
diff --git a/Modules/Drainage/Models/DoubleClickSettings.cs b/Modules/Drainage/Models/DoubleClickSettings.cs
index fe13ee34..7d06ce9a 100644
--- a/Modules/Drainage/Models/DoubleClickSettings.cs
+++ b/Modules/Drainage/Models/DoubleClickSettings.cs
@@ -42,4 +42,17 @@ namespace CE_CVL_SUITE.Models
         public const bool SourceEditWindowDefault = true;
 
+        /// <summary>
+        /// BUG-859 (MEDIUM): ON = a double-click on a downpipe (or any other block carrying a CE source tag) stops AutoCAD's Enhanced
+        /// Attribute Editor before it opens, so CE's Edit source window is the only window the drafter sees. Works only with
+        /// <see cref="SourceEditWindow"/> ON. A block on a locked layer, an Xref block and anything during an in-place block or Xref
+        /// edit (REFEDIT) keep AutoCAD's own answer. OFF = the old behaviour (AutoCAD's editor opens first; CE's window may follow
+        /// after it is closed). Fixes a fault, so ships ON. Not a block (R-27). Default: on.
+        /// </summary>
+        [JsonProperty("sourceStopsAttributeEditorFirst")]
+        public bool SourceStopsAttributeEditorFirst { get; set; } = SourceStopsAttributeEditorFirstDefault;
+
+        /// <summary>Fresh-install default of <see cref="SourceStopsAttributeEditorFirst"/>, in ONE place (design rule 1).</summary>
+        public const bool SourceStopsAttributeEditorFirstDefault = true;
+
         /// <summary>
         /// The switch's first name (#1176, pit labels only). A drawer who turned THAT off asked for AutoCAD's own double-click, so the
```
3. **DoubleClickAttributeEditorStopRule.cs (in full):**
```csharp
using System;
using CE_CVL_SUITE.Models;

namespace CE_CVL_SUITE.Rules
{
    /// <summary>
    /// BUG-859 (29 Oct 2026): a double-click on a placed downpipe (or any other block carrying a CE source tag) starts AutoCAD's
    /// attribute editor (EATTEDIT), which receives its block inside the command and opens its window at once. CE's earlier rounds
    /// stopped it from the command-start notice by posting a cancel, but that cancel only lands after AutoCAD's window is closed, so
    /// the drafter saw AutoCAD's Enhanced Attribute Editor first and CE's Edit source window (if at all) half a minute later (robot
    /// case R09, Civil 3.0.75 to 3.0.85). AutoCAD tells add-ins about a command's document lock just before the command runs, and an
    /// add-in may refuse that lock, which stops the command before it starts. This rule decides, without AutoCAD, when CE refuses it.
    /// Headless, so the net48 and net10 test lanes run it.
    /// </summary>
    internal static class DoubleClickAttributeEditorStopRule
    {
        /// <summary>The switch doubleClick.sourceStopsAttributeEditorFirst; a missing settings file or group reads ON (R-27).</summary>
        internal static bool IsOn(DoubleClickSettings doubleClick) =>
            doubleClick?.SourceStopsAttributeEditorFirst ?? DoubleClickSettings.SourceStopsAttributeEditorFirstDefault;

        /// <summary>
        /// The lock notice that comes as the attribute editor STARTS carries its plain name. The notice at its end carries a leading
        /// '#', and every other command's notice another name, so neither is ever looked at.
        /// </summary>
        internal static bool IsAttributeEditorStarting(string globalCommandName) =>
            string.Equals(globalCommandName?.Trim(), "EATTEDIT", StringComparison.OrdinalIgnoreCase);

        /// <summary>
        /// Whether CE looks under the pointer at all: this switch ON, the source Edit window switch ON (the window this opens instead),
        /// a double-click a moment ago (so the ribbon button, a typed EATTEDIT and Ctrl+1 keep AutoCAD's editor) and its position known.
        /// </summary>
        internal static bool ShouldLook(bool switchOn, bool sourceEditWindow, bool startedByDoubleClick, bool positionKnown) =>
            switchOn && sourceEditWindow && startedByDoubleClick && positionKnown;

        /// <summary>
        /// Whether the attribute editor is stopped for the block found under the pointer: only a block carrying a CE source tag, and
        /// never one on a locked layer or while a block or Xref is being edited in place (REFEDIT). Those keep AutoCAD's own answer, so
        /// CE never reaches past a protection (native protection rule). Anything else (a pit, a pit label, a plain block) is left alone
        /// here and decided by the command-start path exactly as before.
        /// </summary>
        internal static bool ShouldStop(bool isTaggedSource, bool onLockedLayer, bool editingInPlace) =>
            isTaggedSource && !onLockedLayer && !editingInPlace;

        /// <summary>REFEDITNAME holds the name of the block or Xref being edited in place; empty (or unreadable as text) means none.</summary>
        internal static bool IsEditingInPlace(object refEditName) =>
            refEditName is string name && name.Trim().Length > 0;

        /// <summary>The one log line written when the attribute editor is stopped (no handle shown to the drafter: log only).</summary>
        internal static string StoppedLogLine(string sourceTag) =>
            "TryRedirectToCdEdit: EATTEDIT stopped before AutoCAD's attribute editor opened (BUG-859, doubleClick.sourceStopsAttributeEditorFirst); source "
            + (string.IsNullOrWhiteSpace(sourceTag) ? "(no tag)" : sourceTag.Trim());
    }
}
```
4. **CdCheckLineWordingRule.cs (in full):**
```csharp
using System;
using System.Text.RegularExpressions;
using CE.Spine;
using CE_CVL_SUITE.Models;

namespace CE_CVL_SUITE.Rules
{
    /// <summary>
    /// BUG-372 (29 Oct 2026): CDCHECK's command line still showed the drafter a raw drawing handle and CE's internal id (robot case
    /// R22, Civil 3.0.84 and 3.0.85): "[CE] Fall 1. FALL arrow, handle 1197BB, points away ..." and
    /// "1. CE-CIV-PIPE-6A33BA73-044F-4489-AC73-78E75527B461 flows to WT4: Unresolved ...". A connection row printed the record's key
    /// whenever the pipe had no name (the shared listing falls back to the key), and the FALL arrow and pipe end lines carried the
    /// handle in their message. This rule words the command line only; the saved list file keeps the handles and ids for tracing.
    /// Headless, so the net48 and net10 test lanes run it.
    /// </summary>
    internal static class CdCheckLineWordingRule
    {
        /// <summary>The switch checks.cdcheckLinesShowNoInternalIds; a missing settings file or group reads ON (R-27).</summary>
        internal static bool IsOn(ChecksSettings checks) => checks?.CdcheckLinesShowNoInternalIds ?? true;

        // CE's internal id: "CE-" discipline "-" kind "-" a GUID (SpineKey.Text).
        private static readonly Regex InternalId = new Regex(
            @"^CE-[A-Z]+-[A-Z]+-[0-9A-Fa-f]{8}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{12}$",
            RegexOptions.CultureInvariant);

        /// <summary>True when the text a row would print for an object is not a name: empty, its own key, or any CE internal id.</summary>
        internal static bool IsNoName(string mark, SpineKey key)
        {
            string text = (mark ?? string.Empty).Trim();
            return text.Length == 0
                || (key != null && string.Equals(text, key.Text, StringComparison.OrdinalIgnoreCase))
                || InternalId.IsMatch(text);
        }

        /// <summary>The words for an object with no name, by its kind: "an unnamed pipe", "an unnamed pit" and so on. Never an id.</summary>
        internal static string UnnamedWords(SpineObjectKind? kind)
        {
            switch (kind)
            {
                case SpineObjectKind.Pipe: return "an unnamed pipe";
                case SpineObjectKind.Pit: return "an unnamed pit";
                case SpineObjectKind.Source: return "an unnamed source";
                case SpineObjectKind.Slab: return "an unnamed slab";
                case SpineObjectKind.Attachment: return "an unnamed label";
                case SpineObjectKind.Member: return "an unnamed member";
                default: return "an unnamed object";
            }
        }

        /// <summary>The name a row prints for one side: the mark when it is a name, otherwise the words for its kind.</summary>
        internal static string Readable(string mark, SpineKey key) =>
            IsNoName(mark, key) ? UnnamedWords(key?.Kind) : mark.Trim();

        /// <summary>
        /// The connection row as the command line prints it. ON: each side is its name, or "an unnamed pipe" and so on (first letter
        /// upper-case at the start of the row). OFF: <see cref="SpineConnectionRow.Text"/> exactly as before.
        /// </summary>
        internal static string RowText(SpineConnectionRow row, bool switchOn)
        {
            if (row == null)
                return string.Empty;
            if (!switchOn)
                return row.Text;
            string from = IsNoName(row.FromMark, row.FromKey) ? UpperFirst(UnnamedWords(row.FromKey?.Kind)) : row.FromMark.Trim();
            string to = Readable(row.ToMark, row.ToKey);
            return from + " " + SpineRelationshipRules.Describe(row.Kind) + " " + to + ": " +
                SpineRelationshipRules.Describe(row.State) +
                (string.IsNullOrEmpty(row.Reason) ? string.Empty : " (" + row.Reason + ")");
        }

        /// <summary>Removes ", handle 1197BB" and " (handle 1197BB)" from a line; everything else is left as it was.</summary>
        internal static string WithoutHandles(string line)
        {
            string text = line ?? string.Empty;
            text = Regex.Replace(text, @",\s*handle [0-9A-Fa-f]+(?:,(?=\s))?(?=[,.;:)\s]|$)", string.Empty);
            text = Regex.Replace(text, @"\s*\(handle [0-9A-Fa-f]+\)", string.Empty);
            return text;
        }

        private static string UpperFirst(string text) =>
            string.IsNullOrEmpty(text) ? string.Empty : char.ToUpperInvariant(text[0]) + text.Substring(1);
    }
}
```
5. **CompoundEditModeService.cs, the new lines (hook, unhook, OnDocumentLockModeChanged):**
```diff
diff --git a/Modules/Drainage/Services/CompoundEditModeService.cs b/Modules/Drainage/Services/CompoundEditModeService.cs
index 2f7788ce..c5fa437d 100644
--- a/Modules/Drainage/Services/CompoundEditModeService.cs
+++ b/Modules/Drainage/Services/CompoundEditModeService.cs
@@ -73,6 +73,8 @@ namespace CE_CVL_SUITE.Services
             // C7-REG-C3: only the TIME of the last double-click is noted here; the one dispatch path stays
             // OnCommandWillStart (the separate BeginDoubleClick editor was retired on Test Day 3).
             Application.BeginDoubleClick += OnBeginDoubleClick;
+            // BUG-859: the attribute editor a double-click starts on a downpipe is stopped at its document lock, before it opens.
+            docMgr.DocumentLockModeChanged += OnDocumentLockModeChanged;
 
             LoggingService.Info("CompoundEditModeService initialized.");
         }
@@ -87,6 +89,7 @@ namespace CE_CVL_SUITE.Services
             docMgr.DocumentActivated     -= OnDocumentActivated;
             docMgr.DocumentToBeDestroyed -= OnDocumentToBeDestroyed;
             Application.BeginDoubleClick -= OnBeginDoubleClick;
+            docMgr.DocumentLockModeChanged -= OnDocumentLockModeChanged;
             _lastDoubleClickUtc = null;
 
             _initialized = false;
@@ -196,6 +199,7 @@ namespace CE_CVL_SUITE.Services
             catch { _lastDoubleClickPoint = null; }
         }
 
+
         private static void OnCommandWillStart(object sender, CommandEventArgs e)
         {
             string cmd = e?.GlobalCommandName?.Trim();
@@ -890,6 +894,86 @@ namespace CE_CVL_SUITE.Services
             }
         }
 
+        /// <summary>
+        /// BUG-859 round 4 (29 Oct 2026): AutoCAD's double-click on a downpipe starts EATTEDIT with the block handed over inside the
+        /// command, and its window opens at once; the cancel posted from the command-start notice (rounds 1 to 3) only lands after that
+        /// window is closed (robot R09 on 3.0.75 to 3.0.85). AutoCAD tells add-ins about a command's document lock just before the
+        /// command runs (the REDO-DIAG lines show the lock notice a few ms before the command-start notice) and lets them refuse it,
+        /// which stops the command before it runs. Here, and only for an attribute editor started by a double-click on a block that
+        /// carries a CE source tag, CE refuses that lock and schedules CDEDIT on the block, so the Edit source window is the only one.
+        /// Read only: the block under the pointer is found with the existing hit-test, nothing is written, selected or changed (REDO
+        /// safe). A block on a locked layer, an Xref block (the hit-test never returns one) and anything while REFEDIT is open keep
+        /// AutoCAD's own answer. Anything not stopped here keeps the double-click note, so the command-start path decides it as before.
+        /// </summary>
+        private static void OnDocumentLockModeChanged(object sender, DocumentLockModeChangedEventArgs e)
+        {
+            try
+            {
+                // Fires at every command start and end: the name test comes first and reads nothing else.
+                if (e == null || !Rules.DoubleClickAttributeEditorStopRule.IsAttributeEditorStarting(e.GlobalCommandName))
+                    return;
+                Models.DoubleClickSettings doubleClick = SettingsService.Current?.DoubleClick;
+                bool switchOn = Rules.DoubleClickAttributeEditorStopRule.IsOn(doubleClick);
+                bool sourceEditWindow = doubleClick?.SourceEditWindow ?? Models.DoubleClickSettings.SourceEditWindowDefault;
+                bool startedByDoubleClick = IsFromDoubleClick(_lastDoubleClickUtc, DateTime.UtcNow);
+                Point3d? clickPoint = _lastDoubleClickPoint;
+                if (!Rules.DoubleClickAttributeEditorStopRule.ShouldLook(switchOn, sourceEditWindow, startedByDoubleClick, clickPoint.HasValue))
+                {
+                    if (!switchOn && startedByDoubleClick)
+                        Serilog.Log.Information("TryRedirectToCdEdit: EATTEDIT left to start: doubleClick.sourceStopsAttributeEditorFirst reads OFF");
+                    return;
+                }
+                Document doc = e.Document;
+                if (doc == null)
+                    return;
+
+                ObjectId hit = TryFindBlockUnderDoubleClick(doc, clickPoint.Value);
+                if (hit.IsNull)
+                    return;
+
+                bool isTaggedSource = false;
+                bool onLockedLayer = false;
+                string tag = null;
+                using (Transaction tr = doc.Database.TransactionManager.StartOpenCloseTransaction())
+                {
+                    if (tr.GetObject(hit, OpenMode.ForRead, false, true) is BlockReference br && !br.IsErased)
+                    {
+                        isTaggedSource = IsTaggedSourceBlock(br, tr);
+                        if (isTaggedSource && SourceTagService.TryGetTag(br, tr, out string foundTag))
+                            tag = foundTag;
+                        onLockedLayer = tr.GetObject(br.LayerId, OpenMode.ForRead, false, true) is LayerTableRecord layer && layer.IsLocked;
+                    }
+                    tr.Commit();
+                }
+                bool editingInPlace = false;
+                try { editingInPlace = Rules.DoubleClickAttributeEditorStopRule.IsEditingInPlace(Application.GetSystemVariable("REFEDITNAME")); }
+                catch { editingInPlace = true; } // unreadable: assume an in-place edit and leave AutoCAD's own answer
+                if (!Rules.DoubleClickAttributeEditorStopRule.ShouldStop(isTaggedSource, onLockedLayer, editingInPlace))
+                {
+                    Serilog.Log.Information(
+                        "TryRedirectToCdEdit: EATTEDIT not stopped at its start (tagged source {Tagged}, locked layer {Locked}, in-place edit {RefEdit}); the command-start path decides",
+                        isTaggedSource, onLockedLayer, editingInPlace);
+                    return;
+                }
+                if (!HubCommands.RegisterPreselectedEdit(doc, hit))
+                    return;
+
+                // The double-click is answered here: the note is used up, so a command-start notice for this EATTEDIT (if AutoCAD
+                // still sends one) does nothing more.
+                _lastDoubleClickUtc = null;
+                _lastDoubleClickPoint = null;
+                _closePropertiesPaletteBeforeCdEdit = false;
+                e.Veto();
+                Serilog.Log.Information("{Line:l}", Rules.DoubleClickAttributeEditorStopRule.StoppedLogLine(tag));
+                Serilog.Log.Information("TryRedirectToCdEdit: target registered; CDEDIT scheduled at Idle");
+                ScheduleCdEditAtIdle(doc);
+            }
+            catch (System.Exception ex)
+            {
+                LoggingService.Warning($"CompoundEditModeService.OnDocumentLockModeChanged failed — {ex.Message}");
+            }
+        }
+
         // -------------------------------------------------------------------------
         // Testable dispatch classifier (no AutoCAD API calls)
         // -------------------------------------------------------------------------
```
6. **SpineCheckCommand.cs, FallArrowDirectionReviewService.cs, PipeEndReviewService.cs (old and new):**
```diff
diff --git a/Modules/Drainage/Commands/SpineCheckCommand.cs b/Modules/Drainage/Commands/SpineCheckCommand.cs
index fb6a68dc..3df86d80 100644
--- a/Modules/Drainage/Commands/SpineCheckCommand.cs
+++ b/Modules/Drainage/Commands/SpineCheckCommand.cs
@@ -103,5 +103,9 @@ namespace CE_CVL_SUITE.Commands
 
+                // BUG-372: with checks.cdcheckLinesShowNoInternalIds ON (the default) the command line names objects in words, never by a
+                // drawing handle or CE's internal id; the saved list below keeps them for tracing.
+                bool noInternalIds = CdCheckLineWordingRule.IsOn(SettingsService.Current?.Checks);
+                s_noInternalIds = noInternalIds;
                 int number = 0;
                 foreach (SpineConnectionRow row in shown.Take(MaximumListedRows))
-                    editor.WriteMessage($"\n {++number,3}. " + CommandLineText.Plain(row.Text)); // BUG-389: old names hold a real arrow
+                    editor.WriteMessage($"\n {++number,3}. " + CommandLineText.Plain(CdCheckLineWordingRule.RowText(row, noInternalIds))); // BUG-389: old names hold a real arrow
                 if (shown.Length > MaximumListedRows)
@@ -114,5 +118,5 @@ namespace CE_CVL_SUITE.Commands
                     editor.WriteMessage("\n[CE] " + CommandLineText.Plain(line));
-                foreach (string line in FallArrowDirectionReviewService.ToCdCheckOutputLines(fallAwayFindings, MaximumListedRows))
+                foreach (string line in FallArrowDirectionReviewService.ToCdCheckOutputLines(fallAwayFindings, MaximumListedRows, withoutHandles: noInternalIds))
                     editor.WriteMessage("\n[CE] " + CommandLineText.Plain(line));
-                foreach (string line in PipeEndReviewService.ToCdCheckOutputLines(endFindings, MaximumListedRows))
+                foreach (string line in PipeEndReviewService.ToCdCheckOutputLines(endFindings, MaximumListedRows, withoutHandles: noInternalIds))
                     editor.WriteMessage("\n[CE] " + CommandLineText.Plain(line));
@@ -216,2 +220,5 @@ namespace CE_CVL_SUITE.Commands
 
+        // BUG-372: the switch as this CDCHECK read it at its start, so the "show where" lines word an item the same way as its row.
+        private static bool s_noInternalIds = true;
+
         /// <summary>HUNT-C-15 (needs Opus review): clear the jump selection when CDCHECK ends, unless nothing was jumped to or Edit was chosen.</summary>
@@ -308,3 +315,3 @@ namespace CE_CVL_SUITE.Commands
             editor.SetImpliedSelection(new[] { id });
-            editor.WriteMessage($"\n[CE] Item {number}: {CommandLineText.Plain(row.Text)}."); // BUG-372 sweep: it is selected and zoomed to; never the handle
+            editor.WriteMessage($"\n[CE] Item {number}: {CommandLineText.Plain(CdCheckLineWordingRule.RowText(row, s_noInternalIds))}."); // BUG-372 sweep: it is selected and zoomed to; never the handle
             ActOnItem(editor, db, row, records);
@@ -323,3 +330,3 @@ namespace CE_CVL_SUITE.Commands
             DrawingCheckPaletteService.ZoomToObject(editor, db, id);
-            editor.WriteMessage("\n[CE] " + CommandLineText.Plain(finding.Message));
+            editor.WriteMessage("\n[CE] " + CommandLineText.Plain(s_noInternalIds ? finding.PlainMessage : finding.Message));
         }
@@ -406,4 +413,5 @@ namespace CE_CVL_SUITE.Commands
             done = LinkService.TryRecordConnectionDecisionByIds(db, pipeId, endIndex, targetId, connect, DrawingPersonName.Current(), out reason);
-            string targetMark = records.FirstOrDefault(record => string.Equals(record.HostHandle,
-                targetId.Handle.ToString(), StringComparison.OrdinalIgnoreCase))?.Mark ?? targetId.Handle.ToString();
+            SpineObjectRecord targetRecord = records.FirstOrDefault(record => string.Equals(record.HostHandle,
+                targetId.Handle.ToString(), StringComparison.OrdinalIgnoreCase));
+            string targetMark = TargetMarkFor(targetRecord, targetId.Handle.ToString(), s_noInternalIds);
             editor.WriteMessage(done ? ConnectionDecisionLine(endIndex, connect, targetMark) : $"\n[CE] {reason}");
@@ -419,2 +427,19 @@ namespace CE_CVL_SUITE.Commands
 
+        /// <summary>BUG-372: the same, with an unnamed pit or source worded ("an unnamed pit") instead of CE's internal id when the switch is ON.</summary>
+        internal static string PitMarkOf(SpineConnectionRow row, bool noInternalIds) =>
+            !noInternalIds
+                ? PitMarkOf(row)
+                : CommandLineText.Plain(row.FromKey.Kind == SpineObjectKind.Pipe
+                    ? CdCheckLineWordingRule.Readable(row.ToMark, row.ToKey)
+                    : CdCheckLineWordingRule.Readable(row.FromMark, row.FromKey));
+
+        /// <summary>
+        /// BUG-372: the other object's name in the Connect/Disconnect confirmation. OFF: its mark, or the drawing handle when it has no
+        /// record (as before). ON: its mark, "an unnamed pit" (and so on) when it has none, or "the other object" when it has no record.
+        /// </summary>
+        internal static string TargetMarkFor(SpineObjectRecord targetRecord, string targetHandle, bool noInternalIds) =>
+            !noInternalIds
+                ? targetRecord?.Mark ?? targetHandle
+                : targetRecord == null ? "the other object" : CdCheckLineWordingRule.Readable(targetRecord.Mark, targetRecord.Key);
+
         internal static string MainOutletRemovedLine(string pitMark) =>
@@ -451,3 +476,3 @@ namespace CE_CVL_SUITE.Commands
                 ProjectDataService.SetRulebookSettingsInDrawing(db, current.WithMainOutlet(pitKey.Text, null));
-                editor.WriteMessage(MainOutletRemovedLine(PitMarkOf(row)));
+                editor.WriteMessage(MainOutletRemovedLine(PitMarkOf(row, s_noInternalIds)));
                 return;
@@ -455,3 +480,3 @@ namespace CE_CVL_SUITE.Commands
             ProjectDataService.SetRulebookSettingsInDrawing(db, current.WithMainOutlet(pitKey.Text, pipeKey.Text));
-            editor.WriteMessage(MainOutletRecordedLine(PitMarkOf(row)));
+            editor.WriteMessage(MainOutletRecordedLine(PitMarkOf(row, s_noInternalIds)));
         }
diff --git a/Modules/Drainage/Services/FallArrowDirectionReviewService.cs b/Modules/Drainage/Services/FallArrowDirectionReviewService.cs
index d91cd79d..f232968b 100644
--- a/Modules/Drainage/Services/FallArrowDirectionReviewService.cs
+++ b/Modules/Drainage/Services/FallArrowDirectionReviewService.cs
@@ -48,2 +48,5 @@ namespace CE_CVL_SUITE.Services
                 "Check the fall direction or move the arrow.";
+
+            /// <summary>BUG-372: the same line without the drawing handle, for the command line (the saved list keeps <see cref="Message"/>).</summary>
+            internal string PlainMessage => Rules.CdCheckLineWordingRule.WithoutHandles(Message);
         }
@@ -210,3 +213,4 @@ namespace CE_CVL_SUITE.Services
         /// <summary>Same "Fit N. ..." style CDCHECK already uses for pipe-to-pit fit warnings.</summary>
-        internal static List<string> ToCdCheckOutputLines(IReadOnlyList<AwayFinding> findings, int maximumListedRows = 60)
+        /// <remarks>BUG-372: <paramref name="withoutHandles"/> true (the command line with checks.cdcheckLinesShowNoInternalIds ON) leaves the handle out.</remarks>
+        internal static List<string> ToCdCheckOutputLines(IReadOnlyList<AwayFinding> findings, int maximumListedRows = 60, bool withoutHandles = false)
         {
@@ -220,3 +224,3 @@ namespace CE_CVL_SUITE.Services
             foreach (AwayFinding finding in list.Take(maximumListedRows))
-                lines.Add($"Fall {++number}. {finding.Message}");
+                lines.Add($"Fall {++number}. {(withoutHandles ? finding.PlainMessage : finding.Message)}");
             return lines;
diff --git a/Modules/Drainage/Services/PipeEndReviewService.cs b/Modules/Drainage/Services/PipeEndReviewService.cs
index 9f2cd6f3..2f4363d6 100644
--- a/Modules/Drainage/Services/PipeEndReviewService.cs
+++ b/Modules/Drainage/Services/PipeEndReviewService.cs
@@ -345,3 +345,5 @@ namespace CE_CVL_SUITE.Services
         /// <summary>The CDCHECK lines, numbered like the fit warnings: "Pipe end 1. Pipe 100 UPVC (handle 2A3): ...".</summary>
-        internal static List<string> ToCdCheckOutputLines(IReadOnlyList<PipeEndFinding> findings, int maximumListedRows = 60)
+        /// <remarks>BUG-372: <paramref name="withoutHandles"/> true (the command line with checks.cdcheckLinesShowNoInternalIds ON) prints each
+        /// finding's <see cref="PipeEndFinding.PlainMessage"/>; the saved list keeps the handles.</remarks>
+        internal static List<string> ToCdCheckOutputLines(IReadOnlyList<PipeEndFinding> findings, int maximumListedRows = 60, bool withoutHandles = false)
         {
@@ -356,3 +358,3 @@ namespace CE_CVL_SUITE.Services
             foreach (PipeEndFinding finding in list.Take(maximumListedRows))
-                lines.Add("Pipe end " + (++number) + ". " + finding.Message);
+                lines.Add("Pipe end " + (++number) + ". " + (withoutHandles ? finding.PlainMessage : finding.Message));
             return lines;
```
7. **Manager: CeOneGlanceStatus.cs and CeVersionWindow.xaml.cs (all new):**
```diff
diff --git a/Modules/Manager/Services/CeOneGlanceStatus.cs b/Modules/Manager/Services/CeOneGlanceStatus.cs
index 03119244..991db13e 100644
--- a/Modules/Manager/Services/CeOneGlanceStatus.cs
+++ b/Modules/Manager/Services/CeOneGlanceStatus.cs
@@ -252,4 +252,39 @@ namespace CE_SUITE_MANAGER.Services
         internal const string ShortStagingFoldersKey = "shortStagingFolders";
 
+        /// <summary>
+        /// BUG-090 (MEDIUM): ON = the About CE Suite window (CE_VERSION) grows to fit all its rows, so the AutoCAD and Runtime rows
+        /// are readable; OFF = the old fixed 390-pixel-high window, which cut them off. Fixes a fault, so ships ON (R-27): a missing
+        /// or broken switch file, a missing key or a value that is not plain true or false all read ON. Window size only; nothing in
+        /// the drawing changes. Default: on.
+        /// </summary>
+        internal const string AboutWindowFitsItsRowsKey = "aboutWindowFitsItsRows";
+
+        /// <summary>BUG-090: true unless the switch file says <c>"aboutWindowFitsItsRows": false</c>. Never throws; anything wrong reads ON.</summary>
+        internal static bool AboutWindowFitsItsRowsEnabled(string path = null)
+        {
+            try
+            {
+                path = string.IsNullOrWhiteSpace(path) ? DefaultPath() : path;
+                if (!File.Exists(path) || new FileInfo(path).Length > CeSwitchJsonReader.MaxChars)
+                    return true;
+                return AboutWindowFitsItsRowsFromText(File.ReadAllText(path));
+            }
+            catch (Exception)
+            {
+                return true; // R-27: an unreadable switch file keeps the fix
+            }
+        }
+
+        /// <summary>BUG-090: the same answer from the file text (pure, for tests). Only a plain <c>false</c> turns it off.</summary>
+        internal static bool AboutWindowFitsItsRowsFromText(string json)
+        {
+            if (!CeSwitchJsonReader.TryReadObject(json, out Dictionary<string, object> values, out _) || values == null)
+                return true;
+            foreach (KeyValuePair<string, object> pair in values)
+                if (string.Equals(pair.Key, AboutWindowFitsItsRowsKey, StringComparison.OrdinalIgnoreCase))
+                    return !(pair.Value is bool on) || on;
+            return true;
+        }
+
         /// <summary>
         /// Tests only: when set, <see cref="DefaultPath"/> returns this instead of the real %APPDATA% file, so a test
diff --git a/Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs b/Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs
index 3675e56d..61cf9c3e 100644
--- a/Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs
+++ b/Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs
@@ -17,7 +17,21 @@ namespace CE_SUITE_MANAGER.UI.Dialogs
         {
             InitializeComponent();
+            FitToRows(this, CeManagerSwitches.AboutWindowFitsItsRowsEnabled());
             LoadVersionInfo();
         }
 
+        /// <summary>
+        /// BUG-090 (Codex V5-02 and D8-01): the window was fixed at 470 x 390 and could not be resized, but its header, five
+        /// version rows, hint line and footer need about 480 pixels, so the AutoCAD row showed only its top and the Runtime row
+        /// none. Switch aboutWindowFitsItsRows ON: the window takes the height of its rows (the width stays 470). OFF: the old
+        /// fixed height, as before. Window size only.
+        /// </summary>
+        internal static void FitToRows(Window window, bool switchOn)
+        {
+            if (window == null)
+                return;
+            window.SizeToContent = switchOn ? SizeToContent.Height : SizeToContent.Manual; // Manual = the XAML's own fixed 470 x 390
+        }
+
         private void LoadVersionInfo()
         {
```
8. **Hit list of added product lines (file:line: text), by PR:**
```
Modules/Drainage/Rules/DoubleClickAttributeEditorStopRule.cs:44:         /// <summary>REFEDITNAME holds the name of the block or Xref being edited in place; empty (or unreadable as text) means none.</summary>
Modules/Drainage/Services/CompoundEditModeService.cs:77:             docMgr.DocumentLockModeChanged += OnDocumentLockModeChanged;
Modules/Drainage/Services/CompoundEditModeService.cs:92:             docMgr.DocumentLockModeChanged -= OnDocumentLockModeChanged;
Modules/Drainage/Services/CompoundEditModeService.cs:908:         private static void OnDocumentLockModeChanged(object sender, DocumentLockModeChangedEventArgs e)
Modules/Drainage/Services/CompoundEditModeService.cs:910:             try
Modules/Drainage/Services/CompoundEditModeService.cs:944:                         onLockedLayer = tr.GetObject(br.LayerId, OpenMode.ForRead, false, true) is LayerTableRecord layer && layer.IsLocked;
Modules/Drainage/Services/CompoundEditModeService.cs:949:                 try { editingInPlace = Rules.DoubleClickAttributeEditorStopRule.IsEditingInPlace(Application.GetSystemVariable("REFEDITNAME")); }
Modules/Drainage/Services/CompoundEditModeService.cs:950:                 catch { editingInPlace = true; } // unreadable: assume an in-place edit and leave AutoCAD's own answer
Modules/Drainage/Services/CompoundEditModeService.cs:966:                 e.Veto();
Modules/Drainage/Services/CompoundEditModeService.cs:968:                 Serilog.Log.Information("TryRedirectToCdEdit: target registered; CDEDIT scheduled at Idle");
Modules/Drainage/Services/CompoundEditModeService.cs:969:                 ScheduleCdEditAtIdle(doc);
Modules/Drainage/Services/CompoundEditModeService.cs:971:             catch (System.Exception ex)
Modules/Drainage/Services/CompoundEditModeService.cs:973:                 LoggingService.Warning($"CompoundEditModeService.OnDocumentLockModeChanged failed — {ex.Message}");
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:41:             try
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:55:                     throw new InvalidOperationException(reason ?? "The selected source facts are unreadable.");
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:59:                     throw new InvalidOperationException("The selected source has no exact Civil source identity.");
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:69:                 if (source.OwnerId != model.ObjectId) throw new InvalidOperationException("Source changes require model space.");
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:76:                     // index keeps it (LinkService.SourceLanding.cs, outside its try) - attachments are not in the pipe-set
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:83:                     try
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:88:                         context.Geometry(pipe);
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:96:                     catch (System.Exception readFault) when (CE_CVL_SUITE.Rules.SourcePlacementReadbackRule.MayLeaveOutOfReadback(
Modules/Drainage/Services/LinkService.SourceChangeCapture.cs:129:                     { Handle = layer.Handle.ToString(), layer.IsLocked, layer.IsDependent, layer.IsPlottable, layer.IsOff, layer.IsFrozen }));
Modules/Drainage/Services/LinkService.SourceLanding.cs:253:             try
Modules/Drainage/Services/LinkService.SourceLanding.cs:282:                         try
Modules/Drainage/Services/LinkService.SourceLanding.cs:308:                         catch (System.Exception ex) when (!PipeAttachmentActionFailurePolicy.IsFatal(ex))
Modules/Drainage/Services/LinkService.SourceLanding.cs:324:                     throw new InvalidOperationException("The drawing and project do not describe the same complete pipe set.");
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:3: using Autodesk.AutoCAD.Geometry;
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:71:             try { return SourceLandingSpeedRule.ReadsEachObjectOnce(SettingsService.Current?.Linking); }
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:72:             catch { return true; }
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:78:             try { return SourceLandingSpeedRule.TimingLogOn(SettingsService.Current?.Linking); }
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:79:             catch { return false; }
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:82:         /// <summary>BUG-1228: one CE log line for one drawing read, only when the timing switch is on. Never throws.</summary>
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:87:             try
Modules/Drainage/Services/LinkService.SourceScanMemo.cs:92:             catch (Exception ex)
Modules/Manager/Services/CeOneGlanceStatus.cs:262:         /// <summary>BUG-090: true unless the switch file says <c>"aboutWindowFitsItsRows": false</c>. Never throws; anything wrong reads ON.</summary>
Modules/Manager/Services/CeOneGlanceStatus.cs:265:             try
Modules/Manager/Services/CeOneGlanceStatus.cs:270:                 return AboutWindowFitsItsRowsFromText(File.ReadAllText(path));
Modules/Manager/Services/CeOneGlanceStatus.cs:272:             catch (Exception)
Modules/Manager/UI/Dialogs/CeVersionWindow.xaml.cs:33:             window.SizeToContent = switchOn ? SizeToContent.Height : SizeToContent.Manual; // Manual = the XAML's own fixed 470 x 390
```
