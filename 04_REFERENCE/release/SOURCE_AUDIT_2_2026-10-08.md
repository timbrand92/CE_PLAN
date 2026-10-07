# SOURCE AUDIT 2, 8 October 2026 (Structural and Manager, the eight categories the first audit left out)

**Read-only audit.** Nothing was built, run, installed or changed in any working copy. Written for Tim; the answer comes first.

## 1. THE ANSWER FIRST

1. **Total: 25 findings. 2 HIGH, 12 MEDIUM, 11 LOW.** None of them is a crash I could prove from source alone. The two HIGH ones are both in Manager's office update channel, which the pilot does not use yet (colleagues are installed by script), so they are dangers waiting for the day the channel is switched on.
2. **Signature checking is strong.** Manager only stages a build whose signed release record, signature, summary and every file hash match what the administrator approved, and it re-checks all of it before staging and before showing "ready to install". No way round it was found.
3. **Rollback and the Civil + Manager pair are the weak spots.** The admin "Roll Back Release" button changes the approval record but no PC ever goes back, and the channel can update Civil without Manager, which splits the shared CE_SHARED file (the "missing CE ribbon" case in the rollback guide).
4. **Manager does a lot of heavy file work every minute,** re-reading and re-fingerprinting whole plugin folders on OneDrive and on disk. It runs in the background, but the same work also runs on AutoCAD's own thread when CEMANAGER opens. This is a likely contributor to the lag Tim has measured.
5. **When the office folder cannot be reached, Manager degrades quietly.** Nothing blocks drafting (checked: every update path returns empty and the ribbon dot stays calm).

**The top five (detail in section 3):**
1. **S2-001 (HIGH):** Roll Back Release says "rolled back" but nobody's AutoCAD goes back, and their status dot turns green.
2. **S2-002 (HIGH):** the update channel stages Civil but can never stage Manager, so an approved Civil update splits the Civil/Manager pair.
3. **S2-006 (MEDIUM):** office files in the shared IT Admin folder are written in one go with no safe copy; one half-written file can hide every approval, and can stop the Manager window opening.
4. **S2-003 and S2-004 (MEDIUM):** the every-minute background check, and the same check on AutoCAD's own thread when the Manager window opens.
5. **S2-010 (MEDIUM):** sheet sync rewrites a closed drawing on disk without checking whether a colleague has it open on another PC.

**Need Tim's decision:** S2-001, S2-002, S2-008, S2-009, S2-010, S2-015 (section 6).

**What was audited.**
1. **Structural** at `origin/claude/rel-20261008w` (Structural 1.0.104, head `ebc1654d914f0305f198b273639cecdf07fad8b5`): `Modules/Structural`, `Modules/Structural.DesignCore`, `Modules/Structural.Native2027` (C# only).
2. **Manager** at `origin/claude/rel-20261008c` (Manager 1.1.34, head `62514a67a79fec12e167206ecb7ad20bce3f48ab`): `Modules/Manager`, `CE.Host`, and `Shared/CE.Release/OfficialReleaseGate.cs` for the signature check.
3. **Method.** Read through `git show` / `git archive` of those two heads into a scratch folder (the c20asm worktree was not checked out or touched). Each finding below was confirmed by reading the code around it. Line numbers are as at those heads.
4. **Overlap.** The first audit's 49 findings were not repeated. Where a finding extends one of them, or a carpark entry, it says so. Known items left out: BUG-367 (STR unlock), BUG-368/358 base fix, BUG-334 (background drawing work, fixed in `AsyncCommandService.cs`), BUG-405/413 file names, BUG-206 (OSMODE), first audit P4-1 to P4-6.

---

## 2. COUNTS

**Per category**
1. **Native AutoCAD protections:** 2 (S2-014, S2-023)
2. **Undo integrity:** 3 (S2-012, S2-013, S2-022)
3. **Swallowed errors:** 2 (S2-016, S2-021 part)
4. **AutoCAD thread rules:** 2 (S2-004, S2-005)
5. **Data loss:** 5 (S2-006, S2-007, S2-010, S2-011, S2-020)
6. **Privacy:** 3 (S2-008, S2-009, S2-021)
7. **Manager update delivery:** 6 (S2-001, S2-002, S2-003, S2-017, S2-018, S2-019)
8. **Settings-first (R-00):** 1 (S2-015)
9. **Other (latent / dead code):** 2 (S2-024, S2-025)

**Per area**
1. **Manager:** 17
2. **Structural:** 8

---

## 3. HIGH FINDINGS

1. **S2-001. HIGH. Roll Back Release does not roll anyone back, and the status dot then says "CE is current".**
   - **Where:** `Modules/Manager/Services/CeApprovedReleaseService.cs:131-162` (rollback rewrites `approved.json` with the older version), `:175` and `:195-196` (staging only ever accepts a NEWER build via `IsNewerBuild`), `Modules/Manager/Services/CePluginInstallerService.cs:129-145` (`IsNewerBuild`), `Modules/Manager/Services/CeReleaseStatusService.cs:86` (amber only when approved is newer than installed), `Modules/Manager/Services/CeStagedRollout.cs:238` (promises "Everyone goes back to X the next time AutoCAD starts"), `Modules/Manager/UI/Dialogs/PluginAdminWindow.xaml.cs:185-204` (button, no confirmation).
   - **What a drafter sees:** Tim approves Civil 3.0.35, three colleagues get it, it is bad, Tim clicks Roll Back Release and is told "rolled back to 3.0.34". Next morning the three colleagues still run 3.0.35, their ribbon dot is green ("CE is current"), and CEMANAGER tells them "the current approved OneDrive release is not newer than the installed build". A rollback of a canary release also becomes an all-machines record (`AppliesToThisMachine` is true for anything not "Canary", `CeReleaseStatusService.cs:101-107`).
   - **Reproduce:** on a test copy of the IT Admin folder, approve version N+1 over N, stage and install it on one PC, press Roll Back Release, restart: the PC stays on N+1 and shows green.
   - **Fix owner:** Opus builder (Manager lane). Needs Tim's ruling on what "roll back" must do (section 6).

2. **S2-002. HIGH (latent). The update channel can update Civil but can never update Manager, so an approved Civil update splits the Civil/Manager CE_SHARED pair.**
   - **Where:** `Modules/Manager/Services/CePluginRegistryService.cs:53` (Manager removes itself from the plugin list), `:157` (and from the office build list), `Modules/Manager/Services/CeApprovedReleaseService.cs:164-178` (`StageManagedUpdates` stages each approved plugin on its own), `:61-118` (approval is one plugin at a time; no pair check anywhere in Manager: searched for CE_SHARED and pairing).
   - **What a drafter sees:** per the rollback guide (`ROLLBACK_GUIDE_2026-10-07.md` items 1.1 and 7.2) Civil and Manager must move together because they share one CE_SHARED file. Through the channel, Civil 3.0.35 would be staged and shown as "ready to install" while Manager stays 1.1.34, so after the install the CE ribbon can go missing.
   - **Reproduce:** approve a Civil build whose CE_SHARED differs from the installed Manager's; watch CEMANAGER offer only Civil.
   - **Fix owner:** Opus builder. The closed-process installer that does the actual install was not audited; it may or may not add Manager itself (section 7).

---

## 4. MEDIUM FINDINGS

1. **S2-003. MEDIUM. Every 60 seconds Manager re-checks signatures and re-fingerprints whole plugin folders, in the background, on every PC.**
   - **Where:** `Modules/Manager/Services/CeReleaseStatusService.cs:124-136,145-166` (timer every 60 s, first at 20 s) calls `CePluginRegistryService.DiscoverAll()` (`CePluginRegistryService.cs:30-77`), which (a) walks the whole IT Admin OneDrive tree four folders deep looking at every entry, including the usage, failures and diagnostics folders (`CePluginInstallerService.cs:538-565`), and reads every `*_Update_*.txt` (`:630-666`); (b) for each approved plugin re-runs the full signed-release check, which reads and hashes every file in the OneDrive bundle (`CeApprovedReleaseService.cs:200-207,262-292`, `Shared/CE.Release/OfficialReleaseGate.cs:879-907`); (c) re-hashes the staged copy (`CeUpdateStagingService.cs:111-214,483-582`) and the installed bundle (`:238-258`).
   - **What a drafter sees:** nothing on screen, but disk and processor load every minute for as long as AutoCAD is open, and on OneDrive "files on demand" it can pull whole bundles down. This is a plausible contributor to the lag in Tim's PC measurement (29 Sep).
   - **Reproduce:** with one approved release present, watch AutoCAD's disk reads in Resource Monitor for five minutes with nothing happening in the drawing.
   - **Fix owner:** Team. Cache by file size and time, verify once per new approval, not every minute.

2. **S2-004. MEDIUM. The same heavy check runs on AutoCAD's own thread when the Manager window opens, and for CEMANAGERDIAG.**
   - **Where:** `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml.cs:329` (in `LoadPlugins`, called from the window's Loaded event at `:62`), `:584`; `Modules/Manager/Commands/PluginManagerCommands.cs:94-95` (CEMANAGERDIAG). The admin window does it off the thread correctly (`PluginAdminWindow.xaml.cs:62`).
   - **What a drafter sees:** typing CEMANAGER freezes AutoCAD for as long as it takes to fingerprint the approved, staged and installed bundles (seconds; longer on OneDrive placeholders).
   - **Reproduce:** time CEMANAGER from Enter to window with and without an approved release in the IT Admin folder.
   - **Fix owner:** Team.

3. **S2-005. MEDIUM. The ribbon status change is hooked onto AutoCAD's Idle event from a background timer thread.**
   - **Where:** `Modules/Manager/Services/CeReleaseStatusService.cs:135,163` (timer thread raises `Changed`), `Modules/Manager/Plugin.cs:146` (handler), `Modules/Manager/Services/CeUnifiedRibbonService.cs:59-65` (`Application.Idle +=` and writes to the static `_built` / `_idleHandler` with no lock, while `OnIdle` reads them on AutoCAD's thread, `:79-88`).
   - **What a drafter sees:** usually nothing. In a race the ribbon rebuild can be skipped (status dot stuck on the old colour) or an extra Idle handler left attached. AutoCAD API calls belong on AutoCAD's thread.
   - **Reproduce:** not reliably; a Codex soak with approvals flipped every minute would show a stuck dot.
   - **Fix owner:** Team. Marshal `RequestRebuild` to AutoCAD's thread (as `AsyncCommandService` does in Structural).

4. **S2-006. MEDIUM (could be worse). Office files in the shared IT Admin folder are written in one go with no safe copy, and one damaged file is not survived.**
   - **Where:** `Modules/Manager/Services/CeJsonService.cs:25-40` (`File.WriteAllText` straight onto the real file) is used for `approved.json` (`CeApprovedReleaseService.cs:309`), `admin-users.json` (`CeAdminPolicyService.cs:135,153`), acknowledgements (`CeAdminAcknowledgmentService.cs:43`) and the staging receipt. Readers: `CeApprovedReleaseService.cs:30-43` has its try/catch OUTSIDE the loop, so one unreadable `approved.json` ends discovery and every approval after it disappears; `CeAdminPolicyService.cs:43-45,167-175` lets a damaged `admin-users.json` throw, and that is called without protection in the Manager window's Loaded event (`PluginManagerWindow.xaml.cs:53`), in the admin buttons (`PluginAdminWindow.xaml.cs:119-122`) and inside `async void RefreshData` which has `finally` but no `catch` (`PluginAdminWindow.xaml.cs:56-75`).
   - **What a drafter sees:** after a OneDrive hiccup half-writes `admin-users.json`, every colleague who types CEMANAGER gets an error instead of the window; an unhandled error in a window's open event can end the AutoCAD session (needs a Codex test on a copy before anyone states it). A half-written `approved.json` makes approved updates vanish with no message.
   - **Reproduce:** on a TEST copy of the IT Admin folder (never the real one), truncate `CE Plugin Admin\policies\admin-users.json` to half its length, then type CEMANAGER.
   - **Fix owner:** Team (write to a temporary file then swap, as `CeBlocksSettings.cs:82-84` already does; read each file in its own try).

5. **S2-007. MEDIUM. The "starts with AutoCAD" switch rewrites the installed plugin's own PackageContents.xml in place.**
   - **Where:** `Modules/Manager/Services/CePluginRegistryService.cs:219-257` (`XmlWriter.Create(descriptor.ManifestPath)` empties the live file before writing; `catch { return false; }`), called from `PluginManagerWindow.xaml.cs:514`. This also contradicts the note at `CePluginInstallerService.cs:195` ("no compiled path ... edits a live manifest").
   - **What a drafter sees:** if the write fails part way (antivirus, OneDrive, disk), the plugin's manifest is left empty and Civil or Structural does not load at the next start. The message says the files are "locked or read-only" whatever the real cause was.
   - **Reproduce:** on a test PC, make the manifest read-only half way through (or fill the disk), toggle the switch, restart.
   - **Fix owner:** Team (use the same temp-file-then-swap `SaveXDocument` already in `CePluginInstallerService.cs:763-780`).

6. **S2-008. MEDIUM (privacy and size). CESUPPORT zips the whole CE_CADTOOLS folder and uploads it to the shared office folder by itself.**
   - **Where:** `Modules/Manager/Services/CeSupportBundleService.cs:12-44,54-57` zips all of `%APPDATA%\CE_CADTOOLS`, which holds `CE_Admin\update-staging` (full copies of every staged plugin bundle, `CeAdminStorageService.cs:33,49`), `CE_Admin\outbox` (including earlier support zips, `:92-100`), sessions and logs. `CeAdminStorageService.cs:102-129` then copies the zip into the shared IT Admin folder at the next start. The zip name carries the computer name (`CeSupportBundleService.cs:21`, already in KNOWN_LIMITATIONS).
   - **What a drafter sees:** "Bundle saved ... will be uploaded to the IT Admin folder". The upload can be hundreds of MB, and the logs inside carry full drawing paths, which name client job addresses (RULES 11.1: local only). A second CESUPPORT in the same session zips the first.
   - **Reproduce:** run CESUPPORT twice on a PC with one staged update; check the zip size and contents.
   - **Fix owner:** Team, after Tim decides what a support bundle may contain and whether it uploads by itself (section 6).

7. **S2-009. MEDIUM (privacy). Manager's office reports still carry real Windows logins, computer names and full error traces.**
   - **Where:** `Modules/Manager/Services/CeAdminTelemetryService.cs:92-93` (machine report fields), `:125-126,132-133` (failure record: real names, unscrubbed `Message`, `Details = ex.ToString()` with local file paths), `:223-224` (command usage record); `Modules/Manager/Services/CeDiagnosticsService.cs:54-55,95,279,291` (CEMANAGERDIAG: report file named `<time>_<login>.txt` in a folder named after the computer, inside the shared IT Admin folder, and it prints the OneDrive path, which contains the login); `CeApprovedReleaseService.cs:97,126,151` and `CeAdminAcknowledgmentService.cs:25` (`ApprovedBy`, `AckedBy`).
   - **What a drafter sees:** nothing; the office folder holds every colleague's login and PC name and raw error traces. Extends KNOWN_LIMITATIONS 8 Oct item 2 (which names only the machine report) and BUG-405/413 (file names). Civil hashes these fields; Manager does not (BUG-365 noted the same split).
   - **Reproduce:** run CEMANAGERDIAG and force one Manager failure; open the files in the IT Admin folder.
   - **Fix owner:** Team, after Tim's call (section 6). The admin dashboard and canary list need a machine identity, so the choice is "hashed everywhere" or "real names on purpose".

8. **S2-010. MEDIUM (data loss). Sheet sync rewrites a closed drawing on disk without checking whether a colleague has it open.**
   - **Where:** `Modules/Structural/Services/CeSheetsSyncService.cs:851-869` (side-loads the drawing and `SaveAs` over the same file), `:1798-1815` (the only check is an exclusive file open on THIS PC). No `.dwl` lock-file check exists anywhere in Structural (searched).
   - **What a drafter sees:** Tim syncs title blocks; a colleague has S03.dwg open on their own PC through OneDrive. CE writes S03 on Tim's side; when the colleague saves, OneDrive makes a conflict copy or one person's changes are lost.
   - **Reproduce:** two PCs, same synced project; open a sheet on PC B; run the sheets sync on PC A.
   - **Fix owner:** Team (refuse that one sheet with a plain line when a `.dwl`/`.dwl2` exists beside it, carry on with the rest).

9. **S2-011. MEDIUM (data loss). The sheet register file is written in one go; a damaged file reads as "no register", and the rescan then drops typed sheet titles and revisions.**
   - **Where:** `Modules/Structural/Services/CeSheetsManifestService.cs:36-50` (`File.WriteAllText` on the real file), `:18-34` (any read error returns "no manifest", logged only), `:83` ("Manifest not found. Scan Project to build the sheet list.").
   - **What a drafter sees:** the Drawing sheets window says to scan the project; after the scan, the sheet titles, revisions and title mappings typed earlier are gone (nothing to merge them from).
   - **Reproduce:** on a test project, cut the manifest file in half, open Drawing sheets, rescan.
   - **Fix owner:** Team (temp file then swap; keep the previous copy; on a read error say the register is damaged and keep the old file).

10. **S2-012. MEDIUM (undo). After TEXTEDIT then MOVE, Structural rewrites the moved text's anchor at an idle moment, outside any command.**
    - **Where:** `Modules/Structural/Services/DrawingAutoSaveService.cs:1101-1105` (called from AutoCAD's Idle event) into `TryRepairMovedDbTextAnchors` `:881-1030`, which locks the drawing (`:916`) and writes `AlignmentPoint` or `Position` (`:959,966`). The code's own note at `:888-892` says a write from idle "is its own step in AutoCAD's Undo list". It applies to ANY single-line text the drafter edited and then moved, not only CE text.
    - **What a drafter sees:** edit a centred note, move it, press U: the first U only undoes CE's quiet anchor fix and the text does not go back; a second U is needed. The drawing is also marked changed after the move settles.
    - **Reproduce:** Structural drawing, DTEXT with Justify Center, TEXTEDIT it, MOVE it, wait two seconds, U once.
    - **Fix owner:** Team (do the check inside the MOVE's CommandEnded, or only log the mismatch).

11. **S2-013. MEDIUM (undo). CLEAN and FASTSAVE still open their own Undo mark inside the typed command (the BUG-358/368 pattern).**
    - **Where:** `Modules/Structural/Services/CleanPipelineService.cs:81` and its own private `StartUndoGroup` `:661-676` (not `ClaimUndoMark`), commands at `Modules/Structural/Commands/LegacyPortCommands.cs:11-15`. BUG-368 moved BATTER, LBW and the rafter tools to `StartCommandUndoGroup`; CLEAN was not moved and has no Cancel clean-up that needs the mark.
    - **What a drafter sees:** after CLEAN, the first U is an empty step and only the second U undoes the clean-up (as BUG-358 measured for FREGENALL).
    - **Reproduce:** CLEAN on a test drawing, then U, then check whether anything changed.
    - **Fix owner:** Team.

12. **S2-015. MEDIUM (R-00 and "Unknown stays Unknown"). A footing or raft beam with no known width is drawn 300 mm wide; a screw pile with no size is drawn 150 mm.**
    - **Where:** `Modules/Structural/Services/FoundationService.cs:25-26` (`DefaultBeamWidth = 300`, `DefaultStripWidth = 300`), used at `:3221-3223` (redraw), `:4381-4410` (`ResolveWidthFromLabelOrDefault`, used by footing adoption at `:1452,1533,1576`), `:4077` (prompt default) and `FoundationService.Identity.cs:155`; screw pile `FoundationService.cs:3211` (`150.0 * unitsPerMm`). Not in the first audit (its P1-10 covered the proposal engines only).
    - **What a drafter sees:** adopting an existing raft whose beam lines carry no readable size label gives every beam a 300 mm width, and the outline is redrawn at 300 with no "size unknown" line.
    - **Reproduce:** FADOPT on a raft drawn with plain lines and no beam labels; LIST a redrawn beam outline.
    - **Fix owner:** Team, once Tim says whether these become Settings rows or stay Unknown and ask (section 6).

---

## 5. LOW FINDINGS

1. **S2-014. LOW (native protection). CLEAN's text-style and ByLayer stages fail as a whole if one object sits on a locked layer.** `Modules/Structural/Services/CleanPipelineService.cs:412,529` open every object for write with no locked-layer skip; the exception ends the stage (`:218-247`) and the summary shows AutoCAD's raw error. Protection is respected (nothing is unlocked), but the drafter gets "stage failed" and no list. Reproduce: lock one layer holding a dimension, run CLEAN. Owner: Team.
2. **S2-016. LOW (swallowed error). A background staging failure leaves no trace.** `Modules/Manager/Services/CeApprovedReleaseService.cs:176` ignores the result of `InstallOrUpdate`; only success is traced (`CePluginInstallerService.cs:186-190`). The dot stays amber "New version approved" and nobody learns why staging failed until someone clicks it. Owner: Team.
3. **S2-017. LOW. Staged copies are never removed.** `Modules/Manager/Services/CeUpdateStagingService.cs:328-413` keeps every staged version under `%APPDATA%\CE_CADTOOLS\CE_Admin\update-staging`; the only delete is the failed `.preparing-` folder (`:775-790`). Each approved release adds a full bundle per PC, and S2-008 zips them all. Owner: Team.
4. **S2-018. LOW. Version comparison falls back to text order for any version that is not plain numbers.** `Modules/Manager/Services/CePluginInstallerService.cs:101-115`: "1.0.104-hotfix" would read as older than "1.0.99". Current release numbers are plain, so this is latent. Owner: Team.
5. **S2-019. LOW. Roll Back Release acts on one click with no "are you sure".** `Modules/Manager/UI/Dialogs/PluginAdminWindow.xaml.cs:185-204` (Promote to All asks, `:253-258`). Owner: Team, with S2-001.
6. **S2-020. LOW. The crash trace log is trimmed by reading it and writing half back, from two threads.** `Modules/Manager/Services/CeAdminTelemetryService.cs:150-169`; the background update thread and AutoCAD's thread both call it; errors are swallowed, so lines can be lost exactly when a crash is being diagnosed. Owner: Team.
7. **S2-021. LOW (privacy, swallowed errors). Structural's support bundle holds the real login, computer name and full drawing path, and each part fails silently.** `Modules/Structural/Services/SupportBundleService.cs:150-152` (not passed through `StructuralPiiHash`), `:89,109,133,160` (`catch { }`), so "bundle created" can be an empty zip. It goes to the Desktop, not the office folder. Owner: Team, with S2-009.
8. **S2-022. LOW (undo, needs a Codex test). Palettes and windows write into the drawing outside any command.** Checklist ticks (`Modules/Structural/Core/Checklist/ChecklistStorage.cs:115-150,323`, from `UI/Palette/ChecklistPanel.xaml.cs:857`), notes (`Core/Notes/NoteStorage.cs:90-148`) and the Drawing sheets sync into an open drawing (`Services/CeSheetsSyncService.cs:817-832`) lock the drawing from a window. By the code's own notes (S2-012, BUG-191) each becomes its own Undo step, so a drafter's U can silently take back a checklist tick or a title-block update. Owner: Team.
9. **S2-023. LOW (native protection). Sheet sync freezes or thaws the title-block Xref layers by discipline and revision without listing which.** `Modules/Structural/Services/CeSheetsSyncService.cs:2091-2153,2269-2277`. A layer the drafter froze on purpose can come back. It only touches Xref title layers matched by keyword, and the drafter started the sync, so LOW. Owner: Team.
10. **S2-024. LOW (latent, not deployed). Under CE.Host, Manager would do nothing.** `Modules/Manager/CeManagerModule.cs:35-38` calls `new Plugin().Initialize()`, which returns at once when the host guard is active (`Modules/Manager/Plugin.cs:44`), so a hosted Manager gets no telemetry, update staging, menu or status pane. CE.Host is marked "NOT DEPLOYED ANYWHERE" (`CE.Host/CE.Host.csproj` header). Owner: Team, before any CE.Host work.
11. **S2-025. LOW. Dead Azure download and publish code is still compiled into Manager.** `Modules/Manager/Services/CeAzureBlobService.cs` (writes downloaded files at `:82`) and `CeAzurePublishService.cs` have no callers (searched). V3 never uses Azure (SEC-001). Owner: Team (remove).

---

## 6. QUESTIONS FOR TIM (batched, each with a recommendation)

1. **S2-001, what Roll Back must do.** Today it only changes the record. **Recommend:** at the next AutoCAD start, a PC on a rolled-back version stages the older approved build and shows amber "Going back to 3.0.34: close AutoCAD and use the approved installer", and the button asks "Roll back Civil to 3.0.34 for everyone?" first. On a job: a bad Civil release is pulled the same day without anyone running PowerShell.
2. **S2-002, the Civil + Manager pair.** **Recommend:** approving Civil also approves the Manager build with the same stamp, and staging one without the other warns and records it (R-27: warn, never block). On a job: nobody ever gets a Civil update with a missing ribbon.
3. **S2-008, support bundles.** **Recommend:** logs and settings only (no staged bundles, no outbox), drawing paths cut to the file name, and it stays on the PC until the drafter chooses to send it. On a job: a client address never lands in the office folder by accident.
4. **S2-009, real names in office reports.** **Recommend:** hash login and computer name like Civil does, and show Tim a "who is this?" lookup on his own PC only. Say if you would rather see real names in the admin dashboard on purpose.
5. **S2-010, sheet sync and colleagues' open drawings.** **Recommend:** skip a sheet that someone has open (AutoCAD's lock file is present) and list it at the end. On a job: no OneDrive conflict copies after a title-block update.
6. **S2-015, footing width when unknown.** **Recommend:** Unknown stays Unknown: adoption marks the beam "width unknown" and asks once for all unknown beams, rather than a hidden 300 mm. Say if you would rather have a Settings row "default raft beam width".

---

## 7. SUSPECTED (seen in source, not confirmed, so not counted)

1. **Beam records written after ERASE.** `Modules/Structural/Services/BeamLinkService.SupportErased.cs:31-63` locks the drawing and writes beam link records after a plain ERASE (BUG-237 family). I did not trace whether this runs inside ERASE's own Undo step or after it; if after, ERASE then U needs two U.
2. **FASTSAVE leaves the drawing marked changed.** `CleanPipelineService.cs:81,148-166,184` saves while its own Undo mark is still open and closes the mark after the save; closing the mark may set DBMOD again.
3. **A rolled-back version already staged on a PC.** After S2-001, the bad version's staged copy stays in `update-staging`. Manager no longer shows it, but I did not read the closed-process installer, so whether it could still install it is unknown.
4. **Exploded block pieces on locked layers.** `Modules/Manager/Services/CeBlocksInsertService.cs:165-186` appends the pieces of an exploded office block on whatever layers they carry inside the block, which may be locked in the drafter's drawing. The insertion layer itself is checked (`:53-57,142-143`).

---

## 8. CHECKED AND CLEAN

1. **Signed releases.** RSA-PSS signature against the embedded trusted keys, exact record/signature/summary hashes pinned at approval, every file hash re-checked at staging and again before "ready to install" (`OfficialReleaseGate.cs:717-927`, `CeApprovedReleaseService.cs:251-292`, `CeUpdateStagingService.cs:260-420,483-582`). Linked folders, `_pending.dll` and paths outside the bundle are refused. Staging never writes into AutoCAD's plugin folders (`CeUpdateStagingService.cs:299-303`).
2. **Office folder unreachable.** Approvals, staging, status and upload all return quietly (`CeApprovedReleaseService.cs:27`, `CeAdminStorageService.cs:108-109`, `CeReleaseStatusService.cs:155-158`). Nothing blocks drafting.
3. **Administrator set-up.** No longer grants admin to whoever opens Manager first (`CeAdminPolicyService.cs:40-80`).
4. **Manager block insert.** Refuses locked or frozen target layer, Xref-containing blocks and an open reference edit (`CeBlocksInsertService.cs:28-57,140-143`); one placement per transaction inside one command.
5. **Structural settings file.** Saved through `WriteSettingsFileProtected` with a kept copy (`SettingsService.cs:617-655,890-894`).
6. **Structural background work.** File-only work on worker threads; drawing reads stay on AutoCAD's thread (`AsyncCommandService.cs`, BUG-334 fixed). No `IsLocked = false` anywhere in Structural except the drafter-driven Layer Manager and Xref paste (first audit P4-4, P4-5).
7. **Structural idle auto-save.** The idle save of the drafter's drawing is gone (UX-STD-03, `DrawingAutoSaveService.cs:1112-1118`); only the rolling backup copy of the last saved file remains.
8. **Support block upgrade.** Asks Upgrade/Cancel and proves every existing support is unchanged (`SupportBlockDefinitionUpgradeService.cs:186-243`).
9. **Manager tests.** No Manager test found that writes to the real `%APPDATA%` or to the real IT Admin folder (`TestHygieneAppDataGuardTests.cs` guards it).

---

## 9. NOT AUDITED

1. **The closed-process installer (RS-01B)** that actually installs a staged update: not read. Partial-install and rollback behaviour at install time is unknown.
2. **Structural, every `OpenMode.ForWrite` site.** 89 files write; I read the ones that edit existing objects or run outside commands (CLEAN, sheets sync, auto-save idle, notes, checklist, support upgrade, beam erase). About 40 files with no lock check of their own were listed but not traced one by one (for example `BeamService.cs`, `ScheduleService.cs`, `MLeaderCalloutService.cs`, `LevelMarkCommands.cs`).
3. **Structural.Native2027 C++ and the ObjectARX bridge.** Not read.
4. **Structural tests and their %APPDATA% writes.** BUG-294 and BUG-348 cover known ones; not re-swept.
5. **Numbers inside method bodies** in Structural (only named constants were searched, as in the first audit).
6. **Nothing was run in AutoCAD.** Every finding is from source. S2-006, S2-012, S2-013 and S2-022 need a Codex test before anyone relies on the exact symptom.
