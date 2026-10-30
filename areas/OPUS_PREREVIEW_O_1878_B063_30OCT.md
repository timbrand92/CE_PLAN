# Opus pre-review: PR #1878 (B-063), CESUPPORT zip never takes a key or local settings file by name

Reviewed Fri 30 Oct 2026 (Melbourne time) by an independent Opus reviewer, read-only. Head f0500eda (checked: the branch tip on GitHub is f0500edae47894117f689918e87edd8a53c4edea), branch fb/support-zip-name-guard, draft against claude/rel-20261102a (tip 91963bd0, which is also the PR's merge base). I read the code at f0500eda and the base, the author's report and RULES.md. I built nothing, ran no test, opened no AutoCAD and opened none of Tim's key or settings files.

## FOR TIM

1. **Verdict: KEEP-WITH-NOTE, on the 2 Nov Manager train (claude/rel-20261102a).** It does what it says. When you press CESUPPORT, a copied key file or machine-only settings file is now left out of the zip, whichever folder it was copied into. Your normal logs still go in.
2. **What it does NOT catch:** a key saved under any other name, for example a "keys.txt" dropped on the Desktop CE Diagnostics folder, or a key pasted into a log line, would still go in. CE never puts one there, so this is unlikely. CE already has a key-spotting cleaner that could close this gap; that should be a separate small fix, not this one.
3. **Before merging, one quick check:** take the fix out, run the new zip test, and check it fails; put the fix back and check it passes. This takes about a minute. Nobody has done it yet, so we only know the test SHOULD fail without the fix, not that it does.
4. **Who sees the "left out" line:** only someone who opens the notes page inside the zip. The command line shows just the count. It shows the file's name, never what is in it. That is safe and actually helps support say "delete that stray copy".
5. **Civil and Structural:** Civil has no support zip at all. Structural has an old one in its code, with the same gap and worse (it puts your real login and PC name in), but nothing can start it: CESUPPORT is the Manager's. I recommend parking it as a bug, not fixing it here.
6. **Built and unit-tested only.** Nobody has run CESUPPORT on a real PC with this change. Merging it clashes only on the top line of the regression log, which is routine.

---

## DETAIL

### 1. Does the guard cover every route, and how robust is the match?

1. **Every route goes through AddFile.** In `Modules/Manager/Services/CeSupportBundleService.cs` at f0500eda the guard is line 214, inside `AddFile` (lines 205 to 236), after the private-book check (line 209) and the entry-name scrub (line 212), and before the file is opened (line 223). The routes:
   - CE_Admin\logs and CE_Admin\sessions: line 116 calls `AddFolder`, which calls `AddFile` at line 183.
   - Desktop "CE Diagnostics": line 117, same path.
   - Office diagnostics .txt: line 118 calls `AddLatestOfficeDiagnostics`, which calls `AddFile` at line 306.
   - Plugin log folders: line 125, through `AddFolder` then line 183.
   - Redirected log folder and its crash-trace sub-folder: lines 131 and 132, same path.
   - `AddNotes` (line 134) only writes text the code itself builds; it reads no file.
   So yes, all routes. In practice the guard only matters for the first two: the plugin log and redirected routes already keep only CE's own log names (line 171), and the office route keeps only `yyyy-MM-dd_HH-mm-ss_<code>.txt` names (line 303). The CE_Admin and CE Diagnostics routes walk every sub-folder (line 158, AllDirectories) and accept any .txt, .log, .json, .csv, .xml, .md or .ini (line 26), which is the real gap the PR closes.
2. **Case:** all three checks use OrdinalIgnoreCase (lines 198, 199, 201). BLOB-CONFIG.JSON, Blob-Config.Local.Json and ce_suite are all caught; the tests pin three of these.
3. **Trailing dots or spaces:** a name like `x.local.json ` or `x.local.json.` dodges the `.local.json` ending check, but then its extension is `.json ` or empty, which is not in the text list, so line 217 leaves it out as "not a text file" and it is never read. Any name starting `blob-config` is caught whatever follows. Such names can only be made with special Windows path prefixes in any case. Not a real hole.
4. **Alternate data streams:** `Directory.EnumerateFiles` lists files, not streams, so a hidden stream is never a route into the zip. Not a hole.
5. **8.3 short names (BLOBCO~1.JSO):** the folder walk returns long names for everything below the root it is given, so the file-name checks see `blob-config.local.json`, not the short alias. A short name could only appear in the root path itself, and the roots come from Windows' long-name folder lookups (Desktop, %APPDATA%, %LOCALAPPDATA%, the OneDrive IT Admin folder) or the CE_LOG_DIR_OVERRIDE test folder. Not a hole. Not tested on a real disk (the author says so too).
6. **A different casing of CE_SUITE, or one deeper in the path:** caught at any depth (loop at lines 200 and 201; test case `C:\x\ce_suite\deep\a.log`).
7. **Junction into %APPDATA%\CE_SUITE:** I believe .NET follows folder junctions when it walks sub-folders, but I have not verified it. If someone made a junction called, say, `settings` inside CE Diagnostics pointing at %APPDATA%\CE_SUITE, the path would read `CE Diagnostics\settings\...`, so the CE_SUITE folder rule would miss it. `blob-config*` and `*.local.json` would still be caught by name, but `manager-switches.json` (switches only, no key, per `CeOneGlanceStatus.cs` line 223) would go in. Nobody makes junctions in these folders. Not realistic.
8. **Over-catching (small note, not a blocker):** the CE_SUITE rule looks at the WHOLE path, including the folders above the one being collected. If a collected folder ever sat under a folder called CE_SUITE, the whole route would be silently emptied and each file labelled "key or local settings file". I checked every root: none does today (the office path is `...\Creative Engineering - IT Admin\CE Diagnostics`, `CePluginInstallerService.cs` line 66; the driver's redirect folders sit under `C:\ce_rc_scratch`). The same applies to the test itself if a test machine's TEMP sat under such a folder. Optional polish: check only the part below the collected folder (`relative`, already worked out at line 210).
9. **What can still slip through:** a key or token under any other name. Examples: `keys.txt` copied into CE Diagnostics; `copy of blob-config.json` (does not start with `blob-config`, does not end `.local.json`); a log line that contains a full storage link with its signature. The first two need a person to copy a key by hand into a CE support folder; unlikely. The third is the more realistic one, because an old trace from before SEC-001 could have logged a link. That is a content question, see section 2.

### 2. Is a name guard enough, or should the scrubber refuse key-like content?

1. **Name guard: right for this PR.** It is small, cheap, never opens the file and covers the one key file CE actually knows (`blob-config.local.json`, per the SEC-001 memory note).
2. **Content: sensible as a separate small follow-up, reusing what exists.** `Shared/CE.Diagnostics/CeSensitiveDataGuard.cs` already has `Redact` (line 769) and `ContainsCredentialMaterial` (line 61). They spot `sig=` and `token=` link values, `SharedAccessSignature=`, `AccountKey=`, `client_secret=`, Bearer and Authorization values, JWTs and the `AdminSasUrl` JSON field. The Manager already references CE.Diagnostics (`CE_SUITE_MANAGER.csproj` line 133; used in `CeAdminTelemetryService.cs` line 7). The follow-up is one wrapper at line 229, `CeSensitiveDataGuard.Redact(CeSupportBundleScrub.Scrub(...))`, plus a test with a dummy `sig=` line. It changes what is written for every file, so it deserves its own PR and test rather than being slipped into this one.
3. **Over-engineering:** a home-made "long base64 string" detector. CE logs carry SHA256 hashes of DLLs and bundle ids, so it would blank real support evidence and give false alarms. Do not do that; use the existing guard's specific patterns.

### 3. The 11 new tests: would they fail without the fix?

The fixture is `Modules/Manager.Tests/Services/B063SupportZipNameGuardTests.cs`: 1 zip test plus 1 name-rule test with 10 cases. On the code before the fix, the file does not compile at all, because `IsKeyOrLocalSettingsFile` does not exist. That is not a real failing twin. Taking each case on its merits:

1. **SupportZip_LeavesOutKeyAndLocalSettingsFilesByName_AndKeepsTheNormalLogs: WOULD FAIL.** Without line 214, the four dummy files are .json or .txt and tiny, so lines 217 to 230 zip them. The first entry check, "no entry name contains blob-config", fails, as do the dummy-text and left-out checks. This is the only case that proves the guard is wired into the zip.
2. **`C:\x\blob-config.local.json` true: would fail** against a helper that returns false.
3. **`C:\x\BLOB-CONFIG.JSON` true: would fail** in the same way.
4. **`C:\x\other.LOCAL.JSON` true: would fail** in the same way.
5. **`C:\x\CE_SUITE\a.txt` true: would fail** in the same way.
6. **`C:\x\ce_suite\deep\a.log` true: would fail** in the same way.
7. **`C:\x\CE_SUITE_MANAGER\crash_trace.log` false: cannot fail on the old code.** It guards against an over-broad fix (for example "contains CE_SUITE").
8. **`C:\x\CE_Admin\logs\ce.log` false: cannot fail.** Same purpose.
9. **`C:\x\local.json.txt` false: cannot fail.** Same purpose.
10. **`C:\x\CE_SUITE` false: cannot fail.** It pins "a FILE named CE_SUITE is not a folder".
11. **`null` false: cannot fail.** Null safety.

So 6 of 11 can fail on the old behaviour, and 5 are boundary guards that, by design, only fail on an over-broad fix. That is a sound shape. The weakness is that only case 1 proves the zip route.

**Smallest failing twin:** in a scratch copy, delete line 214 only (the helper stays, so the file compiles). Run only case 1 and expect FAIL on the "blob-config" assertion. Put line 214 back, run again, expect PASS. One line, one test, about a minute. Optional second twin to prove the boundary cases bite: change line 201 to `parts[i].StartsWith("CE_SUITE", ...)` and expect cases 1 and 7 to fail (the CE_SUITE_MANAGER trace would be left out).

Not checked: the test does not cover the CE_Admin\sessions route (the same `AddFolder` call as logs, so low risk). It also cannot tell "never opened" from "opened then thrown away"; "never opened" rests on reading the code (line 214 comes before line 223), which I confirm.

### 4. Is the "left out" line shown to the drafter, and could it leak?

1. **Where it shows:** only inside the zip, in WHAT_IS_IN_THIS_ZIP.txt (`CeSupportBundleService.cs` lines 250 and 251). The CESUPPORT command line prints only the count (`Modules/Manager/Commands/PluginManagerCommands.cs` line 298). The Administrator Dashboard button shows only the saved-file message (`Modules/Manager/UI/Dialogs/PluginAdminWindow.xaml.cs` lines 186 to 191). So the drafter sees the line only by opening the zip; support sees it if the drafter sends the zip.
2. **Leak:** it names the scrubbed path (login, PC and job names already removed at line 212), never the contents. The known key-file name is public in the repo anyway. Harmless.
3. **Inconsistency, cosmetic:** the administrator's name book (line 209) is listed by folder only, not by file name. B-063 lists the file name. I would keep the name, because it lets support tell the drafter "delete the stray copy in CE Diagnostics". Not worth a change.

### 5. Clashes with claude/rel-20261102a and #1868 to #1877 (read-only `git merge-tree`)

1. **With rel-20261102a:** clean. The base tip is the merge base.
2. **Code files:** none of #1868 to #1877 touches `CeSupportBundleService.cs` or the new test file. The nearest is #1876 (d30041c4), which changes `PluginManagerCommands.cs` and `CeOneGlanceStatus.cs`; it does not touch the CESUPPORT lines.
3. **REGRESSION_LOG.md, line 1:** #1878 clashes with every one of #1868, #1869, #1871 to #1877 here, because all of them add their entry at the top of the file. Routine: keep both entries.
4. **Already in the base:** #1870 (3a152ada) merged into rel-20261102a at 8ffa5380, so it does not clash.
5. **Not caused by #1878:** #1868, #1869, #1872 and #1874 also clash on `Modules/Drainage/Models/UserSettings.cs`, `RulebookEngineTests.cs`, `CouncilSweepParityTests.cs` and `KingstonStormFrequencyTests.cs`. I re-ran them against rel-20261102a alone and they clash there too: they are based on other branches (gb01-slice1-falls, cover-to-pipe-outside, rel-20261026z). #1876 and #1877 merge into the base cleanly and clash with #1878 only on the log.

### 6. Civil and Structural zip routes

1. **Civil:** no support zip exists on rel-20261102a. The only zip code in `Modules/Drainage` is the menu (CUIX) file writer, `Services/CuiMenuGeneratorService.cs` lines 497 and 575. No gap.
2. **Structural: the gap is present, but nothing can start it.** `Modules/Structural/Services/SupportBundleService.cs`:
   - line 80 copies every `*.log` in %APPDATA%\CE_STRUC_SUITE\logs;
   - line 103 copies every `*.json` in %APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox\failures, raw and unscrubbed (a `blob-config.local.json` copied there would go straight in);
   - lines 151 to 153 write the real `MachineName`, `UserName` and drawing path into `plugin_state.json`.
   Its only caller, `Modules/Structural/Commands/DiagnosticsCommands.cs` lines 44 to 51 (`GenerateSupportBundle`), has no command attribute. The comment there says Manager is the sole CESUPPORT owner, and the only `CESUPPORT` command is Manager's (`PluginManagerCommands.cs` line 287). It is dead code today. Recommend a carpark entry: delete it, or send any revival through the Manager builder. Do not fix it in this PR.
3. **Related gap, Manager, not a zip:** the office outbox upload (`Modules/Manager/Services/CeAdminStorageService.cs` lines 623 to 640, `UploadOutbox`) copies any file in the outbox to the office OneDrive folder. It skips only the name book, "private" folders and .tmp/.bak files, and has no key-name guard. The office folder is inside the company and CE writes only records there, so the risk is low. Worth one carpark line.

### 7. Verdict

**KEEP-WITH-NOTE, train claude/rel-20261102a (2 Nov Manager train).**

Notes to carry:
1. Run the one-line failing twin (section 3) before merging, and record the result in the PR.
2. Optional: check CE_SUITE only below the collected folder (line 210's `relative`), so a parent folder name can never empty a route.
3. Follow-up PR, separate: reuse `CeSensitiveDataGuard.Redact` on zip text (section 2).
4. Carpark: the dead Structural `SupportBundleService` (unscrubbed and raw names) and the outbox upload name gap.
5. Merge: keep both regression-log entries at the top; no code clashes.

### What I could not verify

1. I ran no test and no build, so the reported counts (105 of 106 focused, 1,095 of 1,096 full, net48 0 errors) rest on the author's report only.
2. The junction behaviour and the 8.3 behaviour are reasoned from how Windows and .NET normally behave, not tried on a disk.
3. Nothing was run in AutoCAD, and nothing was checked on a real %APPDATA%\CE_SUITE folder.
