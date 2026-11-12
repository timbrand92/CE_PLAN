# Re-review: draft PR 2043, `claude/trust-core-settings-e13111` (TRUST-03, the office setup, switch OFF)

**Reviewer:** lane trust-review (fifth run), Fri 13 Nov 2026, 00:55 PC clock. Read only: nothing built, run, installed or merged by this lane.
**What was read:** `git diff b4d8a0ad ee76f4c7` (the one review-fix commit since my last review; 6 files), the whole of `OfficeSetupService.cs`, `SettingsService.OfficeSetup.cs`, `office-setup.json` and `OfficeSetupTests.cs` at `ee76f4c7`, my earlier review `reviews\claude-trust-core-settings-e13111.md`, and in the installed code at `C:\CE_WORK\scratch\audit_civil` (cf059dcf): the loader (`SettingsService.cs` 105-343, 470-513), the saver (600-764), the remembered-values file (`SettingsService.RememberedValues.cs`), the Civil Hub close (`CivilHubDialog.xaml.cs` 478-491) and the settings model. Line numbers in `OfficeSetupService.cs` are at `ee76f4c7`.

---

# FOR TIM

1. **Your three worries, answered:** last-used levels can no longer become office values; your own PC is never changed by Apply; and after an ordinary save the old settings file can still be put back exactly.
2. **One gap left:** when CE works out "what this PC runs with", it skips the corrections CE makes at every start (for example CE's old minimum grade table moved to 1 in 100). So CE Health could say "no, 1 value differs" on a PC that really is on the office values.
3. **One small one:** "Make this the office setup" rewrites your own settings file to mark your PC, without keeping a copy first.

**Verdict: FIX FIRST** (two items, 2.1 and 2.2). The switch is off and no window is built, so nothing reaches a drafter yet. Built yes (lane). Tested unit only (lane: 32 office-setup tests; not re-run here). Installed no. Accepted no.

---

## 1. The three questions asked

1. **Can last-used levels ever become office values? NO, by the code.**
   1. `IsPersonal` (`OfficeSetupService.cs` 151-166) treats every one of CE's 60 remembered last-used fields (`SettingsService.RememberedValuePaths`, `SettingsService.RememberedValues.cs` 34-60), and anything under one, as personal, whatever the office file says. The levels are all in that list: `pit.coverLevel`, `pit.invertLevel`, `inverts.firstValue`, `inverts.secondValue`, `inverts.recentValues`.
   2. Both doors use it: "Make this the office setup" builds the office values only from non-personal, non-path values (`BuildOfficeValues`, 244-254), and the change list skips personal values before anything else (`Compare`, 341). Apply writes only what `Compare` lists (478-479).
   3. Pinned: `EveryRememberedLastUsedField_IsPersonal_EvenWithAnEmptyPersonalList` walks the real list, so a new remembered field added later is personal at once; `RememberedValues_AreNeverListed_AndNeverCarriedByMakeThisTheOfficeSetup` uses the 21.00 cover level and 19.00 / 18.50 starting inverts.
   4. One hole only by hand-editing: an office file holding a whole section as blank (for example `"pit": {}`) would be one value at the section level, not caught by the remembered list, and Apply would reset that section. "Make this the office setup" never writes one. Worth knowing 4.
2. **Can Tim's PC ever be overwritten? Not by Apply.**
   1. Apply refuses when following is switched off (450), when this PC carries the maker's mark, or when the office file's fingerprint of PC and Windows login matches this one (452-453). The fingerprint is a hash, not the names (`ThisPcAndLogin`, 51-56). The fingerprint check holds even if the mark is lost with an older settings file (`Apply_NeverChangesThePcThatMadeTheFile_EvenIfItsOwnFlagWasNeverSet`).
   2. Until the office file is made it has no values (`office-setup.json` line 28), so Apply has nothing to change and refuses.
   3. The one write to your file is "Make this the office setup" setting the mark (283-286): see 2.2.
3. **Is the previous file restorable byte for byte after a later ordinary save in the same session? YES.**
   1. Apply copies the file byte for byte, never over an existing copy (474-475), then writes the office values through CE's own safe writer (480), then reads the settings again at once (489; `ReloadAfterOfficeSetup` runs the same start-up load under the same lock).
   2. An ordinary save afterwards (closing the Civil Hub reads `SettingsService.Current` fresh, `CivilHubDialog.xaml.cs` 482-490) writes the office values, not the old ones: proven with the real settings service in `Apply_ThenAnOrdinarySettingsSaveInTheSameSession_KeepsTheOfficeValues`, which first checks it is pointed at the test's own folder, not yours.
   3. The ordinary save writes only `CD_Settings.json` (through `.tmp` and a swap with no backup name, `SettingsService.RememberedValues.cs` 109-133) and `CD_RecentValues.json`; nothing in Civil prunes `.bak` files in that folder (searched). So the kept `.before-office-<date>.bak` survives, and Put back copies it over byte for byte (529, tested by bytes).
   4. Put back then also undoes any setting changed since Apply, without saying so (Worth knowing 2).

## 2. FIX FIRST

1. **"What this PC runs with" still skips the start-up corrections (earlier item 1, partly fixed).**
   1. Fixed: the tolerant read is now the loader's own (`ReadEffective`, 199-214, calls `SettingsService.DeserializeSettingsTolerant`); a PC with no file is compared with the colleague starting values, as the loader does; the remembered-values file no longer matters because those fields are never office values.
   2. Not fixed: the real loader then makes seven once-only or every-start corrections before CE uses the values (`SettingsService.cs` 171-313 at cf059dcf): maximum pipe velocity 3.0 to 6.0, SC and CJ label height under 200 to 250, CE's old standard LPD note to the current one, step-iron depth 1000 to 900, the old 1 in 20 steepest grade, the retired minimum grade ladder, and the retired lid class table. `ReadEffective` does none of them, so the builder's line "the loader's own read (one code path), not a copy of it" (`OfficeSetupService.cs` 29) is not yet true.
   3. On a job: a colleague whose file still holds CE's old minimum grade ladder (1 in 200 at 225 and so on) runs 1 in 100, because CE moves it at every start (`SettingsService.cs` 288). The office setup reads the unmoved ladder, so CE Health says "no, 1 value differs" and the list shows "now: the old table", which that PC is not using. The other way: if your own file still holds CE's old LPD note wording, "Make this the office setup" would put the old wording into the office file.
   4. Fix: move the seven corrections into one function that both the loader and `ReadEffective` call (design rule 1), with a test that uses the old ladder.
2. **"Make this the office setup" rewrites your own settings file without a kept copy.**
   1. To set the maker's mark it reads your `CD_Settings.json`, adds one value and writes the whole file back (283-286). Values are kept, but unlike Apply no copy is made first, and it is the one write this feature makes to your PC.
   2. Fix: keep a dated copy first, the same way Apply does, and say where it is in the message.

## 3. The other earlier items

1. **Item 3, a colleague's folder blanked: FIXED.** `Compare` never lists a setting whose current value is, or holds, a folder or file (344-345), looks inside lists and groups (`HoldsAPath`, 227-237), and the shipped personal list now covers names ending Folder, Path, Paths and Dir. Test with a blank and a "not a path" office value against a real folder.
2. **Item 4, the switch freezing itself off: FIXED.** Both new switches are written only when on (`DefaultValueHandling.Ignore`, `UserSettings.cs`); the real saver uses the same plain serialiser (`TrySerializeDetached`, `SettingsService.cs` 752), so the test's serialiser is the right one. Side effect for the controller: a drafter who turns following off cannot stay off once a later release makes "on" the default; "Not now" (per version) becomes the only lasting no. A DRAFT default worth listing.
3. **Item 5, Apply undone by the next save: FIXED** (section 1, item 3). The reload is a parameter, so the window still to be built must pass `SettingsService.ReloadAfterOfficeSetup`; passing nothing brings the fault back. Better: Apply calls it itself when the file is the live settings file.
4. **Item 6, your PC protected only by a flag: FIXED** (section 1, item 2).
5. **Item 7, software words: FIXED.** Reasons are plain (`Plain`, 61-68: "the file is open in another program, or CE cannot get at it", "the file is damaged"); setting names come from the Settings page's own labels (`SettingsService.SettingLabel`); Apply now says "Restart AutoCAD to use them". The group heading is still the section name in lower case ("options", "design standards"), which is acceptable.

## 4. Worth knowing (not blocking)

1. **A table on a colleague's PC with an extra row is never seen.** The office values for a table (for example a minimum grade by pipe size) are compared entry by entry; an entry the colleague has and the office does not is never listed or removed, so CE Health can say "yes" while that table differs.
2. **Put back also undoes later changes.** It returns the file as it was before Apply, so a setting changed after Apply is lost too. The window should say so. It copies with a plain file copy, not CE's safe writer (529).
3. **An open Settings window keeps its own copy.** The Settings window works on a detached copy and saves it whole (`TryReplaceAndSave`, `SettingsService.cs` 635-674). If Apply ran while it was open, its later Save would write the old values back. Offer Apply only when the Settings window is closed.
4. **A hand-edited office file can reset a section** (section 1, item 1.4).
5. **The shipped office file still has no values,** so nothing can be offered yet; CE Health says "not known".

## 5. Not checked

1. Did not build or run any test; the counts are the lane's.
2. Manager's own clean-up of the settings folder (Civil searched only).
3. The window, the "Make this the office setup" button and the CE Health window (not built).
4. Whether `office-setup.json` is copied into the bundle by the build.
5. Tim's real settings files were not opened; `SETTINGS_DIFFERENCES.md` (corrected 13 Nov by its lane) was not re-read.
