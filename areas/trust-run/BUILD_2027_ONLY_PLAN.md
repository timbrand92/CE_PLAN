# Civil batches with AutoCAD 2027 files only: the plan (READ ONLY, nothing changed)

Written Sun 15 Nov 2026 03:45 by lane trust-safety-fixes, on the controller's order after Tim's queue item 10 (02:32: "Take them out of the build"; "Yes, match what I said" for the rule text; his chosen option puts the check of what his own PC does with such a bundle FIRST). Records: `FOR_TIM_QUEUE.md` (Answered, item 10), `QUEUES.md` "AUTOCAD 2027 ONLY FOR NOW".

**Until the controller says otherwise every batch keeps all three sets (Legacy, Net8, Modern) exactly as now. No script, rule text or repo file was changed for this plan.** When the change comes it is one draft pull request on Tim's order, the one allowed new draft.

## Answer first

1. **The smallest change:** one switch, `-ModernOnly`, on the existing `Installer\build_installer.ps1` (no new script). With it, the script:
   - builds the AutoCAD 2027 lane only;
   - takes the shared config from the 2027 build instead of the 2024 one;
   - trims the bundle's `PackageContents.xml` to the 2027 entries;
   - checks only the 2027 lane.
2. **The tracked `PackageContents.xml`, the project file and every test stay as they are.** The official signed-release route also keeps all three lanes, so colleagues on older years keep the CE they have.
3. **What AutoCAD 2027 should do:** load the bundle exactly as today, because it only reads the entries whose year range matches 2027.
4. **Not proven:** that is reading, not proof. The evidence lane proves it on Tim's PC with one trial install of a Modern-only copy of an already-tested batch, with put-back (section C).

## A. What depends on the Legacy (2022-2024, net48) and Net8 (2025-2026) sets today

1. **`Installer\build_installer.ps1` (Civil):**
   - **Builds all three:** it always builds net48 (Legacy, line 199), net8 (line 204) and net10 (Modern, line 209), and makes `Win64\Legacy`, `Win64\Net8` and `Win64\Modern` (lines 177-188).
   - **Lane check:** it refuses to finish unless each of the three DLLs equals its build output (lines 250-270, "prevents a successful Modern build from hiding a stale/missing Legacy or Net8 lane").
   - **Shared config:** it copies the shared config (`Contents\Assets\Config`, 9 files) from the **Legacy (net48) output** (lines 273-298). This is the one hidden dependency: a Modern-only build has no net48 output to copy from.
   - **Reference folders:** its pre-check requires the 2024 and 2026 reference folders (lines 140-142).
2. **`Installer\PackageContents.xml` (tracked):**
   - **Five `<Components>` blocks:** Legacy (`SeriesMin="R24.1" SeriesMax="R24.9"`, `./Contents/Win64/Legacy/CE_CVL_SUITE.dll`), Net8 (`R25.0`-`R25.9`), Modern (`R26.0`-`R27.0`), and the two 2027 native modules (grips, object enabler; `R26.0`-`R26.9`).
   - **Copied twice:** the script copies it before the build (line 195), and the project's `CopyToBundleOutput` target copies it again after the Modern build and sets AppVersion. So any trimming has to happen after the Modern build.
3. **`Modules\Drainage\CE_CVL_SUITE.csproj`:** `TargetFrameworks` is `net48;net8.0-windows;net10.0-windows` (line 4). `CopyToBundleOutput` (line 393) writes each lane to its own `Win64` folder. It needs no change: the script simply does not ask for the two older frameworks.
4. **The batch install scripts** (`install_batch14*.ps1`, copies of the C-79b1 method):
   - **Lane checks:** each checks the version in Legacy, Net8 and Modern, and CE_SHARED against Manager in all three lanes.
   - **For a Modern-only batch:** those loops run over Modern only. The CE_SHARED rule still holds for Modern: Civil and Manager must carry byte-identical CE_SHARED, and in 2027 only the Modern one loads.
   - **The put-back scripts:** unaffected (they restore a full earlier bundle).
5. **The stamp check** (`b3_stamp_civil.ps1` and its copies) compares CE_SHARED and CE.AI.Core in all three lanes. It becomes Modern only. The file-by-file compare and manifest scripts need no change: they would simply list the Legacy and Net8 files as removed.
6. **Manager's bundle (1.1.89) and Structural's bundle (1.0.126.1):** both are separate, built by their own scripts, three lanes each.
   - **Not touched by a Civil Modern-only batch.**
   - **Manager reads Civil's bundle** (`CePluginRegistryService.cs` 456-467) by the entry for the running lane. In 2027 that is the Modern entry, which stays.
   - **Manager's installer** (`CePluginInstallerService.cs` 300-310) treats a bundle with a Legacy or a Modern folder as dual-binary; a Modern-only folder still qualifies.
   - **Taking the older sets out of Manager and Structural too:** a separate decision for later; not in this plan.
7. **The official signed-release route** (`Installer\ReleaseAuthorityPackaging.cs` line 311, `RequiredRuntimeLanes = { "Legacy", "Net8", "Modern" }`, and the release gate tests): refuses a package without all three lanes. That is right for now. Colleagues on older years keep the CE they have, and trial batches never go through that route.

## B. The smallest change (for the one draft pull request, when ordered)

1. **`build_installer.ps1` gains `[switch]$ModernOnly`.** Default off, so every existing call behaves exactly as now. With it on:
   1. **Builds:** skip the net48 and net8 builds, and skip the 2024 and 2026 reference-folder checks.
   2. **Folders:** make only `Win64\Modern`.
   3. **Shared config:** take it from the net10 output (`bin\x64\Release\net10.0-windows\Assets\Config`), and check it the same way. Before relying on this, compare the two sources byte for byte on one build; they are built from the same tracked files.
   4. **Lane check:** verify only the Modern DLL against its build output.
   5. **Manifest:** after the Modern build (once `CopyToBundleOutput` has written the bundle's `PackageContents.xml`), remove the two `<Components>` blocks whose `ModuleName` points at `/Win64/Legacy/` or `/Win64/Net8/`. Then check the result parses as XML, still holds the Modern and two native blocks, and keeps AppVersion. The tracked file is not edited.
   6. **Release routes:** do not create the official release package (the release minter would refuse it anyway); the trial-batch payload only.
2. **A Modern-only version of the batch install script:** the version and CE_SHARED loops over Modern only, plus one extra check that no `Win64\Legacy` or `Win64\Net8` folder is left in the live bundle after the copy.
   - **Why that check:** robocopy without /MIR leaves old folders. The install renames the live bundle aside first, so a fresh copy has none, but the check proves it.
3. **The stamp check:** Modern only.
4. **Tests:** no test needs changing for the switch.
   - **Stays true:** `BundleManifestTests` pins the tracked `PackageContents.xml`, which stays three-lane. The Installer release tests pin the official route, which stays three-lane.
   - **New tests for the draft:** the switch's two pure parts. Trimming a manifest keeps exactly the Modern and native blocks. The config source path is chosen by the switch.
5. **Rule text, on Tim's "Yes, match what I said", in the same draft:**
   - **`AGENTS.md`:** line 93 ("verify net48 + net10.0-windows are 0-error") becomes AutoCAD 2027 (net10) only for batches, with the older lanes still built only for the official release route while that route keeps them.
   - **`C:\CE_PLAN\START_HERE.md`:** section 1b, item 3 ("must say which lane: 2027 and 2024/net48") becomes 2027 only.
   - **Memory note:** "net48 users in scope 2026-09-15" is marked superseded with the date.
   - **Process:** the controller does these when ordered; I changed none of them.

## C. What AutoCAD 2027 should do, and how the evidence lane proves it

1. **By reading the bundle format** (Autodesk app-bundle schema, as the tracked file's own header comment explains): AutoCAD reads `PackageContents.xml` and acts only on the `<Components>` whose `RuntimeRequirements` year range matches the running product. 2027 is R26.0.
   - **Trimmed (option B.1.5):** 2027 sees the same three matching blocks as today (Modern DLL, grips, object enabler), and nothing else changes.
   - **Listed but missing** (not recommended): 2027 should also be fine, because it never looks at the R24 and R25 blocks. But an AutoCAD 2024 or 2026 on the same PC would then try to load a file that is not there and could show a load error. Trimming avoids that: an older AutoCAD simply finds no CE entry for itself.
   - **Unknown:** whether Tim's PC has an older AutoCAD installed and still started. No test is aimed at older years (Tim's ruling), so this is stated, not tested.
2. **Proof on Tim's PC (the evidence lane, AutoCAD closed, outside his hours, put-back ready):**
   1. **Candidate:** a Modern-only copy of a batch already installed and tested (for example batch 3's code), so the only difference is the missing older sets and the trimmed manifest. Check it file by file against that batch: only `Win64\Legacy\*` and `Win64\Net8\*` removed, and `PackageContents.xml` changed.
   2. **Backup and install:** as for every batch (rename the live bundle aside; BEFORE copy with hashes; settings hashed).
   3. **First start of AutoCAD 2027 on a scratch copy:**
      - "CE_CVL_SUITE v<version> Started" in the CE log.
      - "Standalone CE Civil ribbon built", with the same panel count as before.
      - CE Civil, Manager and Structural menu groups load.
      - No load error, no "unable to load", no missing-file or version-mismatch line in the CE logs or the AutoCAD text window.
      - Manager's plugin list shows Civil with the right version.
   4. **Smoke list:** the BUG-1456 smoke list once, PIT placed, saved and reopened, CDHELP, CDS, CDEDIT with Esc, one Pit Schedule open.
   5. **Second start:** AutoCAD closed and started again (bundle loading is also cached between starts), with the same checks.
   6. **Put back:** with that batch's restore script, then the live state checked against its manifest, as for every batch. Or keep the bundle, if the controller decides so.
3. **What would count as a failure:** any load error, a missing ribbon or command, Manager reporting Civil wrong, or settings changed. Then put back at once.

## D. What else reads the older sets

1. **Tests that pin both builds:**
   - **`Modules\Drainage.Tests\Services\BundleManifestTests.cs`:** pins the tracked manifest's Legacy entry (R24.1 to R24.9, `Win64/Legacy`). It stays valid while the tracked file is unchanged.
   - **`Installer.Tests`:** `BuildSafetyTargetTests`, `OfficialReleaseGateTests`, `ReleaseAuthorityPackagingTests`, `ReleaseAuthorityMatrixTests`, `ReleaseRuntimeIdentityPreflightTests`, `SafeBundleInstallerTests` and the two release-profile tests pin the official route's three lanes. They stay valid while that route is unchanged.
   - **`CeSharedCopyCheckTests`:** reasons about net48 in a comment only.
2. **Checks:**
   - **The stamp check** (A.5) loops over three lanes.
   - **The leak scan** (push hook) scans text, not lanes: unaffected.
   - **The batch manifests:** plain file lists, unaffected.
3. **Rule text:** `AGENTS.md` line 93; `START_HERE.md` section 1b item 3; the memory note "net48 users in scope". QUEUES.md already records that this text is older than Tim's ruling.
4. **The dev build** (`dotnet build CE_ACAD_PLUGIN.slnx`) still builds all three frameworks while the project file lists them. That is harmless for batches. Dropping them from `TargetFrameworks` would be a bigger change (tests, Structural and Manager share the pattern), and is not part of the smallest change.

## E. Not checked (so not to be relied on)

1. **AutoCAD's behaviour:** read from the bundle format and the tracked file's own notes, not seen. Section C proves it.
2. **Whether the shared config from net10 is byte-identical to the one from net48:** expected (same tracked files), not compared.
3. **Whether an older AutoCAD is installed on Tim's PC:** not checked (no work aimed at older years).
