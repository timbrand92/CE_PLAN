# Review: draft PR 2043, `claude/trust-core-settings-e13111` (TRUST-03, the office setup, switch OFF)

**Reviewer:** lane trust-review (third run), Thu 12 Nov 2026, 23:59 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff cf059dcf...origin/claude/trust-core-settings-e13111` at head `b4d8a0ad` (one commit, 6 files), `gh pr view 2043`, card `TRUST-03`, `areas\trust-run\SETTINGS_DIFFERENCES.md`, and in the installed code at `C:\CE_WORK\scratch\audit_civil` (cf059dcf): the settings loader and saver (`Services\SettingsService.cs`, `SettingsService.RememberedValues.cs`), `ColleagueDefaultsService.cs`, `PluginInitialization.cs`, `Dialogs\CivilHubDialog.xaml.cs`.

---

# FOR TIM

1. **With the new switch off, nothing changes.** The only new start-up step stops at once when the switch is off, and nothing else in this change is called yet.
2. **The kept copy of the old settings file is a true copy, and putting it back works,** but if the drafter changes anything in the same AutoCAD session afterwards (even resizing the Civil Hub), the old values are quietly written back.
3. **The bigger problem:** CE keeps your last-used values (pit size, label corner, starting levels) in a second file that this code never reads. It could say "Office setup: yes" on a PC that is not on the office values, and it would send your last job's levels to every colleague.

**Verdict: FIX FIRST** (seven items below). Built yes (by its lane; net48 builds). Tested: unit tests only, by its lane (17 new; full net10 Drainage 22,183 passed, 2 IL-shape failures reported as not caused by it); I did not run them. Installed no. Accepted no.

---

## 1. What the brief asked, answered

1. **Switch off: behaviour unchanged? YES, by the code.**
   1. The one change on a running path is the start-up step `RunInit("OfficeSetupCheck", ...)` (`PluginInitialization.cs` 263). `LogAtStartup` returns straight after reading the switch from memory (`OfficeSetupService.cs` 463-468); `RunInit` writes nothing on success (cf059dcf `PluginInitialization.cs` 122-130).
   2. Compare, Apply, Not now, Put back and the CE Health line have no caller outside the tests.
   3. Two side effects with the switch off: the two new switches are written into `CD_Settings.json` the next time a real setting is saved (FIX FIRST 4), and a new `office-setup.json` sits in the bundle's config folder.
   4. The test meant to prove "switch off, nothing read" (`OfficeSetupTests.cs` 234) only checks that it does not throw. The code proves it; the test does not.
2. **Previous file kept and restorable byte for byte? YES, with one gap.** Apply copies the file before writing (374, never over an existing copy); Put back copies it back (417); the test compares bytes. The gap: FIX FIRST 5 (the same AutoCAD session can write the old values back). Smaller points in Worth knowing 1 to 3.
3. **Personal values and Tim's folder paths left alone? PARTLY.** Theme, window positions, recent lists, tour flags and install records are on the personal list, and a value that looks like a folder is never carried. But remembered last-used values are not personal (FIX FIRST 2), and a colleague's own folder can be blanked (FIX FIRST 3).
4. **Can Tim's own PC ever be overwritten? YES, if the switch is on and Apply is pressed there.** FIX FIRST 6.
5. **A settings file that cannot be read: handled honestly.** Apply refuses and changes nothing (365, test at `OfficeSetupTests.cs` 148-155); the CE Health line says "not known"; Not now only writes its own small state file. The messages carry software words (FIX FIRST 7).
6. **Anything written outside the settings folder? NO.** The kept copy, the temporary file and the state file all sit beside `CD_Settings.json`; with the switch on, one log line. No drawing, no registry.
7. **Plain words in what a drafter sees? NO for the error messages and the change list.** FIX FIRST 7.
8. **Shared settings file edited by lines added only? YES** (two properties added after `ShowClassicCeTabs`, nothing reordered). `Shared\CE_SHARED` not touched.

## 2. FIX FIRST

1. **"What this PC runs with" is a hand-made copy of the loader, and it differs from the loader.**
   1. `ReadEffective` (155) lays `CD_Settings.json` over the built-in values. The real loader also lays `CD_RecentValues.json` on top (`SettingsService.cs` 114; the 60 fields in `SettingsService.RememberedValues.cs` 34-60: pit size, pit type, cover level, label corner, starting inverts, pipe size and material, charged destination, grade method and value, and more). This code never reads that file.
   2. The loader replaces lists and dictionaries whole (`ObjectCreationHandling.Replace`, `SettingsService.cs` 771-777); `LayerOver` (167) merges dictionaries with the built-in entries, so for a value such as minimum grade by diameter it sees entries the PC does not have.
   3. A fresh login runs on the colleague starting values (`SettingsService.cs` 332-336); this code compares it with the bare built-in values.
   4. Result: on a PC whose remembered pit size is 450, an office value of 600 is written into `CD_Settings.json`, the next start lays 450 back on top, and CE Health reads only the first file and says "Office setup: yes". The tests' own examples (`pit.xWidth`, `pit.yWidth`, `pit.labelPosition`, `OfficeSetupTests.cs` 59, 114, 195) are exactly such remembered fields.
   5. Fix: one code path (design rule 1). Work out the PC's values with the loader's own read (the tolerant read, then the remembered-values file, or the colleague start for no file) and write each office value where the loader will read it back, or keep remembered fields out of the office setup (item 2). Add a test with a `CD_RecentValues.json` beside the settings file.
2. **Remembered last-used values are not personal, so the setup would carry your last job's levels.**
   1. The shipped personal list (`office-setup.json` 5-23) covers "*recent*" and the per-job pipe memory, but not the remembered fields above. "Make this the office setup" (`BuildOfficeValues`) would therefore carry, for example, the 19.00 and 18.50 starting inverts and the 21.00 cover level that `SETTINGS_DIFFERENCES.md` items 9 and 10 call "left from a job" to every colleague: the BUG-743 fault that card decision 4 recommends never carrying.
   2. Fix (DRAFT default, Tim to confirm per card decision 4): at least the levels are personal now (starting inverts, recent inverts, pit cover and invert level), with a test that checks the personal list against `SettingsService.RememberedValuePaths` so a new remembered field cannot slip through.
3. **A colleague's own folder can be blanked.**
   1. Folder detection looks only at the office value (`CarriesAPath`, 188, used in `Compare`, 246). If the office value for a folder setting is blank or not path-shaped (computations folder, Civil standard details folder, drawing templates folder, logo, menu file), `Compare` lists it and Apply writes it over the colleague's own folder. Nothing checks whether the value being replaced is a folder.
   2. A list is never looked inside, although the reused colleague rule does look inside lists (`ColleagueDefaultsService.cs` 120-139).
   3. Card section 3.2: "your own folder paths" stay personal. Fix: folder and file settings personal by name (the personal list can say "*folder*" and "*path*"), never replace a current value that looks like a folder, look inside lists; test an office blank against a colleague's real folder.
4. **The new switch will freeze itself off.**
   1. Saving Settings writes every value (plan finding 11; `TryWriteSettings`), so every PC that saves a real setting while this build is installed stores `followOfficeSetup: false`. The card wants it on by default; when a later release turns it on, those PCs stay off, and the office file cannot reach them because the switch is on its own personal list.
   2. This is the "frozen on the day you pressed Save" fault that step 3 exists to cure.
   3. Fix: do not write the switch while it holds its default (or store it so that "not written" means follow), with a test that saving settings at the default leaves it out of the file.
5. **Apply and Put back are undone by the next real save in the same session.**
   1. Apply rewrites the file while the running AutoCAD still holds the old values in memory (it only says a restart is needed, 393). Any later real settings save writes memory over the file: closing the Civil Hub after moving or resizing it does exactly that (`CivilHubDialog.xaml.cs` 486-490), as does any Settings window save. Put back has the same gap.
   2. The window is not built yet, so this is a contract the behaviour side must set now.
   3. Fix: after Apply or Put back, reload the settings in memory before anything else can save (or offer Apply only at start-up before settings load), with a test that a save after Apply keeps the office values.
6. **Your own PC is protected only by a flag that nothing sets.**
   1. The only guard is `options.thisPcIsOfficeSource` (`UserSettings.cs` 2322), default off, in the same file Apply rewrites; Apply does not check the follow switch itself (355-358). On your PC the flag is off today, so with the switch on, pressing Apply there would overwrite your values (with a kept copy). Putting back an older copy of your file, from before the flag existed, would silently remove the protection.
   2. The robot check for card 6.5 ("Tim's login: never overwritten") is proven only with the flag set by hand (`OfficeSetupTests.cs` 135-145).
   3. Fix: Apply refuses when the follow switch is off; the office file records which PC and login made it and Apply refuses there; "Make this the office setup" sets the flag. Test with the flag never set.
7. **Software words in what a drafter reads.**
   1. Error messages end with the program's exception name: "(JsonReaderException)", "(IOException)", "(UnauthorizedAccessException)" (78, 108, 399, 424; the start-up log line at 474 is fine).
   2. The "what will change" list is built from code key names (`Words`, 283): "pit: x width", "inverts: pit invert drop mm", "options: civil hub window left". The Settings page already has plain labels for its values (`ViewModels\SettingsValueCatalog.cs`); the list should use those, from one place.
   3. Apply's message does not say AutoCAD must be restarted for the values to take effect; Put back's does.
   4. Fix: plain reasons ("the file is open in another program", "the file is damaged"), the Settings page's own labels, and "Restart AutoCAD to use them" on Apply.

## 3. For the controller

1. **`SETTINGS_DIFFERENCES.md` may have the same blind spot as FIX FIRST 1.** It says Tim's file was "laid over CE's built-in values the way the loader does". If `CD_RecentValues.json` was not read, Tim's real starting pit size, label corner and starting levels may differ from what it lists (most of its top twelve are remembered fields). Worth one re-read before Tim is asked which values are office values.
2. **Card TRUST-03 decision 4 (remembered values) now has a concrete list:** the 60 fields in `SettingsService.RememberedValuePaths`. Tim can be shown them grouped (levels, sizes, tick boxes, filters).

## 4. Worth knowing (not blocking)

1. **A second Apply moves "Put back" on.** After the next release's Apply, Put back returns the file as it was before that Apply, not the colleague's own original; the original is still in the folder, by hand only.
2. **New login:** Apply creates a file and Put back then refuses ("nothing to put back") instead of removing the file it made.
3. **The write is not the existing safe writer.** `WriteWhole` (428) deletes the file and then moves the new one in; the existing `SettingsService.WriteFileViaTemp` swaps it in one step and retries antivirus locks (BUG-831). A crash in between leaves no settings file (the kept copy survives). Reuse the existing writer.
4. **Dotted names.** The comment at 212 says a name holding a dot is skipped; the code splits it instead. A remembered tank plan keyed by a tank name with a decimal point would be nested wrongly. Rare.
5. **Small numbers can show the same.** `Show` writes three decimals (294), so 0.0125 and 0.013 both read "0.013" and a row could say "now 0.013, office 0.013".
6. **"*recent*" also catches a real switch:** `recentInvertButtonsOnMainPage` (a layout choice) becomes personal.
7. **Shipped file found by a test flag.** `LoadShipped` behaves differently while the log-folder test redirect is set; harmless in AutoCAD, but production code reading a test switch is worth a comment.

## 5. Not checked

1. Did not build or run any test; the counts are the lane's.
2. Whether `office-setup.json` is copied into the bundle by the build (not read in the project file).
3. The window, the CE Health window and the support bundle (not built).
4. Manager's own switches and Structural's settings (not in this change).
5. net48 tests (the lane reports zero discovered there).
6. Tim's real settings files were not opened.
