# TOOL NOTE: CE Settings window (CESETTINGS)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Opens the CE Settings window** for Structural. Pages: General, Beam (four sub-pages), CJ / SSC, Supports, Bracing, Rafter / Joist, Timber subfloor, Rebar, Weld mark, Annotation, Xref Layer, System (Saving and fault reports, Installation, Drawing sheets) and Schedules / Markup (six sub-pages).
2. **Three buttons:** Save, Cancel and Reset Defaults. You edit a copy; nothing is kept until you press Save.
3. **Theme preview:** choosing a theme shows it at once and Cancel puts it back.
4. **Other typed commands open it on one page:** for example the Beam Settings and Rafter / Joist Settings commands.

## 2. What it changes in the drawing

1. **Nothing in the drawing.** It does not need a drawing open.
2. **It writes CE's settings file,** CS_Settings.json, in the CE_STRUC_SUITE folder under the Windows login's application data. The file belongs to the PC login, not to a drawing or a job: every drawing you open uses it.
3. **Save writes every box on every page,** including the remembered "last used" values (last rafter tag, last folders, last workbook).
4. **The same file also holds the required bracing figures** typed with the bracing panel command. Reset Defaults wipes those too.
5. **Theme and the logging level change at once** when you press Save. Everything else is read by each command the next time it runs.
6. **Separate from this command:** when AutoCAD starts, the file is rewritten if a newer build has added default rows. That is noted in CE's log only, never on the command line.

## 3. What it will not do

1. **Does not give each job its own values.** One set per Windows login.
2. **Does not show every value CE reads.** Whole groups have no box (see section 7).
3. **Does not ask before Reset Defaults.** It saves the factory values and closes at once.
4. **Does not keep a copy of your settings before Save or Reset.** A copy is kept only after a load that could not read the file.
5. **Does not refuse when it cannot read your file at start.** It uses standard values, says so in a banner and keeps your original file beside it. A Save is then refused until the file can be read.
6. **A text box that you blank can be ignored.** For some boxes (candidate positions, lintel prefixes, Xref layer patterns, the steel and timber notes) a blank box leaves the old text in place.

## 4. What it asks you, and what Enter means

1. **The window.** Save (the default button, so Enter is wired to it), Cancel (Esc closes the window as Cancel) and Reset Defaults.
2. **Save refuses a mistyped number** and names the box: "\"x\" is not a number. Check the box \"name\" and try Save again. Use digits and a decimal point, with no comma or letters." (a whole-number box says "Use a whole number with no comma or letters.")
3. **Save with a bad weld mark** says "Check the weld angle, layer name and new layer colour." and shows that page.
4. **A save CE refuses to protect the file** says "Not saved. Your entries remain in this window, and your settings file was left as it is." and the reason.
5. **A save that could not be confirmed** says "Saving could not be confirmed. Your entries remain in this window. Retry Save, or cancel editing. The settings file may have changed; Cancel does not restore that file."
6. **Reset Defaults asks nothing.** Cancel leaves the file as it was.

## 5. When it says Unknown or "needs checking"

1. **A banner at the top** appears when the file could not be read: "CE Structural could not read your settings file (CS_Settings.json), so it is using standard settings. Your original file is kept in the same folder as" and the kept name.
2. **On the command line** it can print "[CESETTINGS] CE could open your settings file now: your own settings are loaded."
3. **Installed version** shows the loaded version, and "(the setup record says ...)" when the record differs.
4. **The Drawing sheets page** says "Not available yet: the preview window is still being checked. Leave it off." beside a tick.

## 6. How to undo it

1. **Before Save:** Cancel or Esc. Nothing is kept.
2. **After Save:** no Undo. Type the old value back. There is no copy to restore from.
3. **After Reset Defaults:** the previous settings are gone for good, apart from values a newer build wrote that CE does not know about. The drawing is not touched, so U does nothing here.

## 7. Known faults

**Still open**
1. **BUG-826 (HIGH, loses values):** Reset Defaults sits beside Cancel, asks no question, wipes the whole file (including lists that have no page: favourites, recents, schedule rules, mark prefixes, the bearer span table) and keeps no copy. Not seen in AutoCAD.
2. **BUG-1203:** the "Background refresh enabled" tick is ignored at AutoCAD start. The only place the setting is read is when the schedule-reading command runs.
3. **BUG-520, BUG-526, BUG-535:** many values CE uses have no box on this window: footing widths, brace lengths, wind class steps, founding note wording, lintel values, and whole groups (the entry lists 29). The partial fix is a draft pull request only; the installed window has none of those names.
4. **BUG-530, BUG-536, BUG-537, BUG-534:** values with no Settings name, commands that ignore a Settings name that exists, and standards tables without their edition. These live in the commands, not this window. Not re-read here; open on the record.
5. **BUG-493:** the settings file is rewritten at AutoCAD start when a build adds rows. Logged, not shown.

**Already fixed in this build, not yet seen working in AutoCAD**
1. **BUG-299:** after a failed save the kept file is put back at the next start; "Not saved" and "could not be confirmed" now say different things; a refused save no longer repeats its words in the banner.
2. **BUG-575:** "Installed version" now shows the loaded version, with the older setup record beside it, labelled.
3. **BUG-840:** a routine save by a second AutoCAD (last-used values, recents) writes only what that AutoCAD changed, so your saved change is no longer put back.
4. **BUG-955:** window size is now worked out from the screen's scale and kept inside the screen, so a 150 per cent display should no longer push the buttons off screen.
5. **BUG-1072:** the tick now reads "Also keep backup copies of Civil-only drawings" and says it "Copies the last saved drawing only. Unsaved changes are not included."
6. **BUG-1076:** the fault-report choices have plain labels ("Record fault and speed information", "Include extra detail in that log", "Report work taking longer than (ms)", "Show save messages on the command line").
7. **BUG-752:** the long folder and file boxes on Installation, Workbook files and Markup service now wrap. Whether every page fits on screen is not seen.
8. **BUG-549:** the markup tools can no longer send a page to an outside AI service; the check always says no. The chat is off by default.

**Partly fixed**
1. **BUG-841:** a mistyped number now stops Save and names the box. A value below its minimum is still quietly raised (for example a backup copies count of 0 becomes 1).

**New in code, no bug covers it**
1. **"CE never saves; AutoCAD's own automatic save still runs."** still stands in bold on the Saving and fault reports page, but CLEAN saves (by Tim's decision of 5 Nov).
2. **Blanking a note or list box is ignored** (see section 3).
3. **"Share learning data" is ticked by default and nothing in the code reads it.** The page does not say where anything goes.
4. **The Markup service page still offers "API key environment variable name", "Service URL" and "AI model"** though the page-send is blocked in this version, so they do nothing.
5. **The required bracing figures sit in the same file** as the office settings (they belong to a job), and Reset Defaults deletes them.
6. **The Help entry says only "CE Settings."** and has no description.

## 8. On AutoCAD 2022 to 2024

1. **Same code.** No version-specific lines were found in the window or settings files. The screen-scale call is wrapped to survive an older Windows; whether the window sits the same over 2022 to 2024 is not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1:** `UI\Dialogs\CeSettingsDialog.xaml:23, 84-306, 306-343, 355-536, 536-838` (page headers listed in the file).
2. **1.2:** `UI\Dialogs\CeSettingsDialog.xaml:18-20`; `CeSettingsDialog.xaml.cs:31, 244-495`.
3. **1.3:** `CeSettingsDialog.xaml.cs:497-500, 568-573`.
4. **1.4:** `Commands\CeSettingsCommands.cs:8-12`; `Commands\AdminCommands.cs:128-153`.
5. **2.1:** `Services\CeSettingsUiService.cs:27-57` (no drawing call).
6. **2.2:** `Services\SettingsService.cs:68, 623-624, 962-972`; `Services\SettingsService.LoadRecovery.cs:973-1056`.
7. **2.3:** `CeSettingsDialog.xaml.cs:260-466` (every box copied; 361-363 last tags, 420-422, 442-444 last folders).
8. **2.4:** `Commands\BracingPanelCommands.cs:93, 123`; `CeSettingsDialog.xaml.cs:477` (a new settings object).
9. **2.5:** `Services\CeSettingsUiService.cs:43-47, 69-83`.
10. **2.6:** `Services\SettingsService.cs:675-704`; `SettingsService.LoadRecovery.cs:95`.
11. **3.1:** `Services\SettingsService.cs:110-123`.
12. **3.2, 7 BUG-520/526/535:** `UI\Dialogs\CeSettingsDialog.xaml.cs` and `.xaml` contain none of FootingWidth, BraceLength, LintelProposal, WindClass, FoundingNote, SbeamPicker, LoadPath, BoredPierPlan or FramingLegend; carpark entries for the lists.
13. **3.3, 7 BUG-826:** `CeSettingsDialog.xaml:18`; `CeSettingsDialog.xaml.cs:475-478`.
14. **3.4:** `Services\SettingsService.cs:110-123`; `SettingsService.LoadRecovery.cs:1004-1010` (a copy only when `_protectBeforeNextSave`), `1045-1052` (leftovers deleted after a good save).
15. **3.5:** `SettingsService.LoadRecovery.cs:940-955, 957-964, 991-1003`; `Services\CeSettingsUiService.cs:34-37`.
16. **3.6, 7 new 2:** `CeSettingsDialog.xaml.cs:294-296, 325-337`.
17. **4.1:** `CeSettingsDialog.xaml:19-20` (`IsCancel`, `IsDefault`).
18. **4.2:** `CeSettingsDialog.xaml.cs:246-259`; `UI\Dialogs\CeSettingsNumberBoxes.cs:11-70`.
19. **4.3:** `CeSettingsDialog.xaml.cs:381-392`.
20. **4.4, 4.5:** `UI\Dialogs\SettingsSaveAttempt.cs:24-38`.
21. **5.1:** `SettingsService.LoadRecovery.cs:949-954`; `CeSettingsDialog.xaml.cs:33-37`.
22. **5.2:** `Services\CeSettingsUiService.cs:34-35`.
23. **5.3:** `CeSettingsDialog.xaml.cs:190-191`; `Services\VersionInfoService.cs:287-299`.
24. **5.4:** `CeSettingsDialog.xaml:626-630`.
25. **6.3:** `CeSettingsDialog.xaml.cs:477`; `Services\SettingsService.cs:117-121`; `SettingsService.LoadRecovery.cs:987` (unknown newer values carried).
26. **7 BUG-1203:** `Models\UserSettings.cs:1137`; the only read is `Services\XclmTxtService.cs:33`; start-up call `Plugin.cs:156` (`XclmTxtCorpusIndexService.cs` never reads it).
27. **7 BUG-530/536/537/534:** carpark entries; command files not re-read.
28. **7 BUG-493:** `SettingsService.cs:675-704`.
29. **7 BUG-299:** `SettingsService.cs:641, 669-670`; `UI\Dialogs\SettingsSaveAttempt.cs:24-37`; `SettingsService.LoadRecovery.cs:1000-1007`.
30. **7 BUG-575:** as 5.3.
31. **7 BUG-840:** `SettingsService.cs:133-137, 933-937`; `Services\SettingsRoutineMerge.cs:8-27`; `SettingsService.LoadRecovery.cs:984-986`.
32. **7 BUG-955:** `UI\AutoCadWindowHostHelper.cs:49-68, 241-243, 147-158`.
33. **7 BUG-1072:** `CeSettingsDialog.xaml:578-579`.
34. **7 BUG-1076:** `CeSettingsDialog.xaml:538, 547, 572-576, 580`.
35. **7 BUG-752:** `CeSettingsDialog.xaml:605, 609, 615, 619, 647, 651, 655, 778` (`TextWrapping="Wrap"`).
36. **7 BUG-549:** `Services\MarkupAIOffPcPolicy.cs:32-35`; `Services\MarkupAIVisionParser.cs:44-55`; `Services\MarkupAIChatService.cs:32-40`; `Models\MarkupAIModels.cs:240`.
37. **7 BUG-841:** `CeSettingsDialog.xaml.cs:246-259`; clamps at `409, 416, 579-588`.
38. **7 new 1:** `CeSettingsDialog.xaml:557`; `Assets\Config\command-registry.json:4151`.
39. **7 new 3:** `Models\MarkupAIModels.cs:231`; `CeSettingsDialog.xaml:827`; the only other mentions are `CeSettingsDialog.xaml.cs:234, 457` and `SettingsService.LoadRecovery.cs:1413`.
40. **7 new 4:** `CeSettingsDialog.xaml:781-790`; `MarkupAIOffPcPolicy.cs:32-35`; `MarkupAIVisionParser.cs:44-57` (the key is read after the check).
41. **7 new 5:** as 2.4.
42. **7 new 6:** `command-registry.json:75-83`.
43. **8.1:** no `#if` in `CeSettingsDialog.xaml.cs`, `CeSettingsUiService.cs`, `SettingsService.cs`; `UI\AutoCadWindowHostHelper.cs:53-55, 66-67` (catch for missing screen-scale call).

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 03:35. Nothing was run in AutoCAD.
