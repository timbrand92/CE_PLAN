# B-063: the CESUPPORT zip never takes a key or local settings file by name (Fri 30 Oct 2026, Manager only)

## ANSWER FIRST

Done and built. Draft PR #1878, head f0500edae47894117f689918e87edd8a53c4edea, branch fb/support-zip-name-guard, against claude/rel-20261102a. Built and unit-tested only. Nobody has opened it in AutoCAD.

## FOR TIM

1. **What changed for you:** when you press CESUPPORT, the zip now skips any file called blob-config something, any file ending .local.json, and anything inside a folder called CE_SUITE. It checks the file's name first and never opens it. The skipped file shows in the "Found but left out" list in the notes page of the zip, with the words "key or local settings file, never included".
2. **Why:** nothing in CE copies a key into the folders the zip walks, so this was not leaking. But those folders accept any .json file and the scrubber only removes names (your login, PC, job), not keys. If a key file ever got copied into one by hand, it would have been zipped. Now it cannot be.
3. **No Settings switch needed:** the change only makes the zip smaller. It adds nothing and changes no behaviour you rely on. CE 00 approved that.
4. **Your normal logs are unaffected:** the Manager's own trace folder (CE_SUITE_MANAGER) is a different name and is still collected. The test proves the normal logs are still in.
5. **To test in AutoCAD (later, when convenient):** run CESUPPORT on your normal setup and open WHAT_IS_IN_THIS_ZIP.txt inside the zip. Right looks like: the usual CE logs listed under "In this zip". Nothing to do with keys should appear in the "In this zip" list. Nothing is expected to appear under "left out" for keys on a normal PC.

## MY MISTAKES FIRST

1. **First test run wasted:** I passed the AutoCAD 2027 folder path to the build without quote marks around the space, so the build tool read it as a second project and stopped at once. Nothing ran. The cost was about 15 minutes, mostly waiting for a free build slot, then a second wait for the retry.
2. **A stuck command early on:** I ran a pointless command in the shell that hung until I stopped it. No files were touched by it.

## WHAT I DID

1. **Code:** `Modules/Manager/Services/CeSupportBundleService.cs`: a small helper `IsKeyOrLocalSettingsFile` (internal static) called from `AddFile` before the file is opened. Entry name used in the left-out line is the already-scrubbed one.
2. **Test:** `Modules/Manager.Tests/Services/B063SupportZipNameGuardTests.cs`. Dummy files named blob-config.local.json, other.local.json, blob-config.json and one under a CE_SUITE sub-folder, plus normal files, in a temporary CE_Admin\logs and a temporary CE Diagnostics folder. The normal files are in the zip, none of the four are, each is listed as left out, no dummy text is anywhere in the zip. A second test pins the name rule case by case (upper and lower case, CE_SUITE_MANAGER not caught).
3. **Regression log:** entry at the top of REGRESSION_LOG.md.

## NUMBERS

1. **Focused Manager support tests:** 105 passed of 106, 1 skipped (a palette test, nothing to do with this). The 11 new B-063 cases all passed.
2. **Full Manager test project, once:** 1095 passed of 1096, 1 skipped. Test count was not 0.
3. **net48 compile of the Manager project:** 0 warnings, 0 errors.
4. **Control characters:** none in the two code files; REGRESSION_LOG.md has 6, all already in the base file, none in my section.

## TIM'S REAL SETTINGS FOLDER, BEFORE AND AFTER (read-only)

1. **Folder:** %APPDATA%\TIM_CE_CADTOOLS\CE_Admin.
2. **Before (20:13):** 26754 files, newest change 20:13:09.
3. **After (20:42):** 26767 files, newest change 20:42:24.
4. **What the 13 new files are:** all under `outbox` (usage records, one failure record, and the Civil and Structural machine reports). AutoCAD itself was started by another session at 20:34, and three usage files are stamped 20:21, before any of my tests ran. My test runs each used their own fresh temporary folders (set for the temp folder, the CE log folder and the Structural settings root), and the Manager tests build their own folders. I did not see any of my runs write there, but I cannot prove none of the 13 came from them: the record files carry no field naming which program wrote them.

## WHAT IS NOT PROVEN

1. **Not opened in AutoCAD.** CESUPPORT was not run on a real PC.
2. **No before-the-fix check:** I did not run the new test against the code without the fix to see it fail. The fix is small and the test asserts the files are absent from the zip and listed as left out, but a failing twin was not run.
3. **Not tested:** a key file under a real %APPDATA%\CE_SUITE (the name rule is tested by path text and with real temporary files, not on Tim's folders). Windows path edge cases such as short (8.3) names were not tried.
4. **Not checked:** the Civil and Structural zip routes. Only the Manager zip builder changed, and CE_SHARED is unchanged.

## FILES

1. `Modules/Manager/Services/CeSupportBundleService.cs`
2. `Modules/Manager.Tests/Services/B063SupportZipNameGuardTests.cs`
3. `REGRESSION_LOG.md`

**Undo:** revert commit f0500eda (or close the draft).
