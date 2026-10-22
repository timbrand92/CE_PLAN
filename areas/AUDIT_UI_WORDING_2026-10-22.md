# UI wording audit: Civil 3.0.70 and Manager 1.1.70 (22 Oct 2026)

**What was read:** branch `origin/claude/rel-20261022m` (tip `40ee0a36`, the installed Civil 3.0.70 / Manager 1.1.70), by `git fetch` and reading the files only. Nothing was built, run or edited.
**Scope:** every user-visible string added since 20 Oct (#1494, #1495, #1499, #1507, #1511 to #1517, #1520 and the new Fixes tab), plus a sample of older strings in CD, Edit Pit, Inspector, CDREPAIR, CDCHECKS rows, the ribbon, Help and the Manager windows. Administrator-only items were skipped.
**Rules used:** plain English (no software words), the cockpit test, emphasis, the scroll rule, Settings-first, no hard blocks, and "a message must be true".
**Paths:** every file path below is inside the CE_ACAD_PLUGIN repo. `Modules/Drainage` is Civil and `Modules/Manager` is Manager. Line numbers are at `40ee0a36`.

---

## ANSWER FIRST

**Counts:** 68 findings. **HIGH 5** (the text is false or misleading), **MEDIUM 42** (software words, or no next step), **LOW 21** (polish).

**Keyword letters:** 0 real clashes. Seven prompts have two options that start with the same letter, and all seven already give the second one its own capital letter (cAncel, cLear, mIrror, coVer, sOurce, pReview).

**The five worst strings:**

1. **Manager tells colleagues to "run the CE installer", but colleagues cannot.** `PluginManagerWindow.xaml:177` and `:189` are fixed text. The code (`CeInstallWords.cs:6-15`) says only the administrator can run it. Everyone else is told to ask the administrator.
2. **CE_VERSION can say "Not loaded" for a tool that is loaded.** All three rows start as "Not loaded" (`CeVersionWindow.xaml:67/70/73`). If reading the versions fails, the error is only written to the log and the window still says "Not loaded".
3. **CE_VERSION shows the AutoCAD row as an internal number like "25.1", not the year.** If that read fails it shows "2022+", which is a guess. `CeVersionWindow.xaml.cs:35/39`.
4. **CDCHECKIGNORE: "... and 12 more (type their number to ignore one)".** Numbers 41 and up are never printed, so the drafter would ignore a finding they cannot see. `CheckIgnoreCommand.cs:93`, and the same at `:141` for Un-ignore.
5. **Two Ignore refusals contradict each other.** One says a finding "CE could not check" **can** be ignored (`IgnoredChecks.cs:90`). The next says a check CE could not run **cannot** be ignored (`:93`). The Checks header also uses "not known (CE could not check)" for a third, different thing.

**Where most of the problems are:** the Fixes tab tooltips (stored, records, runtime, identity, Project QA), the CDCHECKS rule rows ("provenance", "rulebook", "PitSelector"), older command-line messages (entity, handle, ProjectData, cache), and the same window having three names: **Preferences** on the ribbon, **Settings** in the title bar and **CE Settings** in messages.

---

## 1. Manager: CE Suite Manager window (updates)

1. **Install step tells colleagues to run the installer.** `Modules/Manager/UI/Dialogs/PluginManagerWindow.xaml:177` "Then run the CE installer", and `:189` "...until you close AutoCAD and run the CE installer."
   - **Why:** this contradicts `Services/CeInstallWords.cs:6-15`. A colleague cannot start the installer, so the status line already tells them "ask your CE administrator to finish the install". The window and the status line disagree.
   - **Better:** bind both lines to `CeInstallWords.FinishTheInstall`. A colleague reads "Close AutoCAD, then ask your CE administrator to finish the install." The administrator reads "Close AutoCAD, then run the CE installer."
   - **Severity: HIGH**

2. **Five names for one idea.** `PluginManagerWindow.xaml:50` "Installed next start", `:98` "Updates ready to get", `:99` "Ready next start", `:139` "Update ready", `:176` "2 · Ready".
   - **Why:** the same stage gets different words, so a drafter cannot tell whether "Ready" means approved, copied or installed.
   - **Better:** use three fixed words everywhere: **Approved** (the office has approved it), **Copied, waiting** (Get update ready is done), **Starts next time** (installed, loads at the next AutoCAD start).
   - **Severity: MEDIUM**

3. **Wrong noun.** `PluginManagerWindow.xaml:115` "Current drawing session".
   - **Why:** this panel is about the AutoCAD session and the CE tools, not a drawing.
   - **Better:** "This AutoCAD, right now"
   - **Severity: LOW**

4. **"Module" tab.** `PluginManagerWindow.xaml:122` Header "Module".
   - **Why:** "module" is a software word. Drafters say Civil, Structural, Manager.
   - **Better:** "CE tools"
   - **Severity: LOW**

5. **Finish-update messages (not shown to anyone yet, the code is not connected).** `Modules/Manager/Services/CeFinishUpdatePlanner.cs:47` "The update record for the ready update is missing." `:52` "A folder name for the update is blank or has a quote mark in it, so the update was not started." `:56` "The install record folder is inside an AutoCAD plug-in folder, so the update was not started."
   - **Why:** "record" is a software word. Two of the three give no next step.
   - **Better:** `:47` "The copied update is incomplete. Click Get update ready again." `:52` and `:56` "The update could not start from this PC's folders. Ask your CE administrator (CE has saved the details)."
   - **Severity: MEDIUM**

6. **A promise that nothing keeps yet.** `Modules/Manager/Services/CeFinishUpdateStartRule.cs:36` "The update is ready. It will finish when every AutoCAD window on this PC is closed."
   - **Why:** no code calls this rule, and nothing starts the installer when AutoCAD closes (`CeFinishUpdatePlanner.cs:31` says so). If this text is connected before the part that starts the installer, it becomes false.
   - **Better:** keep the text, and add a guard so the line can only appear once the part that starts the installer is built.
   - **Severity: MEDIUM**

## 2. Manager: CE_VERSION window (About CE Suite)

7. **False "Not loaded".** `Modules/Manager/UI/Dialogs/CeVersionWindow.xaml:67/70/73` start as "Not loaded". In `CeVersionWindow.xaml.cs:41-44`, if reading fails, the error goes only to telemetry.
   - **Why:** after a failure, a loaded Civil reads "Not loaded". A drafter would reinstall for nothing.
   - **Better:** start each row as "Checking…". On a failure show "CE could not read this. Type CEHEALTH."
   - **Severity: HIGH**

8. **AutoCAD shown as an internal number.** `CeVersionWindow.xaml.cs:35` shows `Major.Minor` (for example 25.1), and `:39` falls back to "2022+".
   - **Why:** drafters know AutoCAD by its year. "2022+" looks like a reading but is a guess.
   - **Better:** "AutoCAD 2027" (map the internal number to the year). If it cannot be read: "not read".
   - **Severity: HIGH**

9. **"Runtime: .NET".** `CeVersionWindow.xaml:78-79` shows text like ".NET 10.0.x" or ".NET Framework 4.8".
   - **Why:** this is a programmer fact. A drafter cannot act on it.
   - **Better:** remove the row, or label it "For CE support:" and put it in the hover text.
   - **Severity: MEDIUM**

10. **Two copies loaded, with no next step.** `Modules/Manager/Services/CeVersionReport.cs:97` "CONFLICT — 2 copies (v3.0.70 / v3.0.69)".
    - **Why:** it shouts in capitals and gives no next step.
    - **Better:** "Two copies loaded (3.0.70 and 3.0.69). Close AutoCAD and ask your CE administrator."
    - **Severity: MEDIUM**

11. **Programmer placeholder.** `CeVersionReport.cs:101` "<path unavailable>".
    - **Better:** "folder not known"
    - **Severity: LOW**

12. **Three names for one window.** Ribbon label "Version" (`Modules/Manager/Assets/Config/command-registry.json`, CE_VERSION entry). Window title "About CE Suite" (`CeVersionWindow.xaml:4`). Heading "Loaded CE versions" (`:34`). The tooltip also says "paths".
    - **Better:** title "CE versions". Tooltip: "Shows which CE version is running and which file it came from."
    - **Severity: LOW**

## 3. Civil: CDCHECKIGNORE (typed only, switch OFF)

13. **Numbers you cannot see.** `Modules/Drainage/Commands/CheckIgnoreCommand.cs:93` "  ... and N more (type their number to ignore one)." The same at `:141` "(type their number to bring one back)".
    - **Why:** only 40 rows are printed, so numbers 41 and up are blind picks. The drafter could ignore the wrong finding.
    - **Better:** print all of them, or say "and N more. Fix or ignore some of these first, then run CDCHECKIGNORE again to see the rest."
    - **Severity: HIGH**

14. **Contradicting refusals.** `Modules/Drainage/Services/Checks/IgnoredChecks.cs:90` "Only a finding to look at, or one CE could not check, can be ignored." `:93` "A check CE could not run cannot be ignored."
    - **Why:** "CE could not check" is the exact title of the rows that `:93` refuses (`ChecksResult.cs:305`). The first sentence tells the drafter they can do what the second forbids.
    - **Better:** `:90` "Only a finding to look at, or a not known one, can be ignored. Nothing was changed."
    - **Severity: HIGH**

15. **No path to the switch.** `CheckIgnoreCommand.cs:39` "Ignoring a finding is switched off in CE Settings. Nothing was changed." The same wording, without "CE", is at `IgnoredChecks.cs:88`.
    - **Why:** it gives no next step and does not say which tab.
    - **Better:** "Ignoring a finding is switched off. To use it: CDS > Newer tools > tick Allow a finding to be ignored. Nothing was changed."
    - **Severity: MEDIUM**

16. **"Project record".** `CheckIgnoreCommand.cs:46` "This drawing has no CE project record yet, so there is nothing to ignore."
    - **Better:** "This drawing has no CE pits or pipes yet, so there is nothing to ignore. Nothing was changed."
    - **Severity: MEDIUM**

17. **Symbols with no key.** `Modules/Drainage/Services/Checks/IgnoreFindingPicker.cs:36` puts "(!)" and "(?)" in front of each row.
    - **Better:** print one line first, "(!) = to look at   (?) = not known", or use the words "Look at:" and "Not known:".
    - **Severity: LOW**

18. **A wrong reason ends the command.** `CheckIgnoreCommand.cs:111` "Pick a reason: 1 Survey, 2 Council requirement, 3 Engineer's judgement, 4 Other. Nothing was changed."
    - **Why:** one typo and the drafter has to start again.
    - **Better:** ask again in place: "Type 1, 2, 3 or 4."
    - **Severity: LOW**

19. **Three wordings for when an ignored finding comes back.** The ribbon text says "returns if the pit, pipe or rule value changes" (`Modules/Drainage/Assets/Config/command-registry.json`, CDCHECKIGNORE). The Settings tooltip says "comes back when its pipe or pit changes" (`AdvancedSettingsDialog.xaml:1260`). The command says "until the pit, the pipe or the rule value changes" (`CheckIgnoreCommand.cs:128`).
    - **Better:** use one sentence everywhere: "It comes back if the pit, the pipe or the Settings value changes."
    - **Severity: LOW**

## 4. Civil: Checks rows (CDCHECK, CDCHECKCURRENT, CDRULES)

20. **"Could not check" means two things.** `Modules/Drainage/Services/Checks/ChecksResult.cs:153` header "312 not known (CE could not check)". `:305-307` row "CE could not check which layer each pit is on: it could not be read, so nothing is claimed about it. See the CE log."
    - **Why:** the same words cover "a value is missing" and "CE broke while reading". The row repeats its own title, "nothing is claimed" is legal-sounding, and it gives no next step.
    - **Better:** header "312 not known (a value is missing)". Row: "CE could not read which layer each pit is on. Run CDCHECK again. If it repeats, send a fault report from CE Suite Manager > Help."
    - **Severity: MEDIUM**

21. **"Provenance" is on Tim's banned list.** `Modules/Drainage/Rules/RulebookEngine.cs:69` title "Rule value provenance", and `:419` "Velocity input provenance" / "Velocity uses Assumed roughness".
    - **Better:** "Where this value came from". `:419`: "Speed worked out with an assumed pipe roughness. Set the material on the pipe."
    - **Severity: MEDIUM**

22. **"In the rulebook" instead of where to set it.** `RulebookEngine.cs:437` "no minimum in the rulebook", `:454` "no minimum cover in the rulebook", `:625` "no pit drop in the rulebook", `:650` "no step-iron depth in the rulebook", `:345` "no minimum grade in the rulebook ladder for DN225".
    - **Why:** Settings-first says these values live on the Settings page. The drafter needs the tab, not the word "rulebook".
    - **Better:** "No minimum cover set. Set it in CDS > Design." The same pattern works for each value.
    - **Severity: MEDIUM**

23. **Code name in a finding.** `RulebookEngine.cs:250-260` "Existing CE PitSelector size tier…" "This one-sided undersize screen is not proof of physical fit."
    - **Better:** "P3 is 600 x 600 mm. CE's pit-size table suggests 900 x 900 mm for these pipes and this depth. Check the pipes fit."
    - **Severity: MEDIUM**

24. **"Office seed" and "per-type catalogue selection".** `RulebookEngine.cs:321` "no diameter recorded; office seed shown for reference, per-type catalogue selection not checked here — set it on the pipe".
    - **Better:** "No pipe size set. The office default is 100 mm. Set the size on the pipe."
    - **Severity: MEDIUM**

25. **"Fallback".** `RulebookEngine.cs:411-412` "material roughness missing or ambiguous; no fallback velocity calculated".
    - **Better:** "Speed not worked out: the pipe has no clear material. Set the material on the pipe."
    - **Severity: MEDIUM**

26. **Pipe data shown as computer text.** `Modules/Drainage/ViewModels/CouncilSourceViewModel.cs:80` "Value used: " is followed by the raw saved data (JSON), which for `RulebookEngine.cs:134` "Observed pipe inputs (not evidence of validity)" includes EntityHandle and SpineKey. Also `:63` "Historical evidence shows where a retained value came from; it does not prove current council policy." and `:82` "This recorded finding has no retained input citations."
    - **Why:** it shows code text and handles in a window, and the sentences read like legal language.
    - **Better:** list the values in words ("Diameter 225 mm, upstream IL 10.250"). `:63`: "This shows where the value came from when the check ran. The council may have changed it since." `:82`: "This saved check has no sources attached."
    - **Severity: MEDIUM**

27. **"Unknown" and "not known" both used.** The Checks list says "not known". `AdvancedSettingsDialog.xaml:919` says "stays Unknown", `:1360` "the rows stay Unknown", `Rules/CouncilRuleValues.cs:333` "time of concentration: Unknown, the lot area is not known", and `Commands/LinkCommands.ReadOnlyAudit.cs:25/30/36` "- Unknown."
    - **Better:** use "not known" everywhere a drafter reads it.
    - **Severity: MEDIUM**

28. **"Unknown" again.** `RulebookEngine.cs:333` "pipe length unknown (pit positions missing)".
    - **Better:** "pipe length not known: a pit has no position"
    - **Severity: LOW**

29. **Progress line breaks the usual opening.** `Modules/Drainage/Rules/SlowWorkProgressTicker.cs:47-48` "CE: checking the drawing, 1234 objects read so far".
    - **Better:** "[CE] Still checking the drawing (1234 items read so far)…"
    - **Severity: LOW**

## 5. Civil: CDTAG and the new Edit source window (#1499, #1520)

30. **"Removed" when nothing was tagged.** `Modules/Drainage/Commands/SourceTagCommand.cs:311` "CDTAG removed."
    - **Why:** this path runs when the source had no tag and the drafter pressed Enter on an empty tag. It reads as if a tag was taken off. It also lacks [CE].
    - **Better:** "[CE] No tag typed. This block has no source tag."
    - **Severity: MEDIUM**

31. **Programmer formatting.** `SourceTagCommand.cs:391` "CDTAG applied: tag=DP2. Pipes linked to this block: 2."
    - **Better:** "[CE] Tagged DP2. 2 pipes are connected to it."
    - **Severity: MEDIUM**

32. **Three-line message with two commands.** `SourceTagCommand.cs:393` "No pipes found connected to this block. If a pipe endpoint is near the block, run CDREPAIR or use CDPIPEOVERRIDE to set the connection manually."
    - **Better:** "[CE] No pipe connects to DP2 yet. Draw or snap a pipe end to it."
    - **Severity: LOW**

33. **Two wordings for one choice.** The command line asks "Show tag label on screen?" (`SourceTagCommand.cs:322`). The window says "Show the tag label on the drawing" (`Dialogs/SourceEditDialog.xaml:39`).
    - **Better:** "Show the tag label on the drawing" in both.
    - **Severity: LOW**

34. **OK greys out with no reason.** `Dialogs/SourceEditDialog.xaml:55` OK is off when the tag has a space (`Rules/SourceEditWindowRule.cs:52`), and nothing says why.
    - **Better:** a red line under the box: "One word, no spaces (for example DP2)".
    - **Severity: LOW**

35. **Help does not mention the window.** `Modules/Drainage/Assets/Help/guide-content.js:42` "Source selection and tag prompts." "...check the identifier shown."
    - **Why:** a double-click on a downpipe now opens the Edit source window. "Identifier" is a software word.
    - **Better:** "Double-click a downpipe to open its Edit window, or type CDTAG and pick the block. Check the tag shown."
    - **Severity: LOW**

## 6. Civil: Settings (CDS) Fixes tab (#1494, #1495)

36. **Internal note on the colleague build.** `Modules/Drainage/Dialogs/AdvancedSettingsDialog.xaml:1375` (also `CivilSettingsView.xaml:400` and `ViewModels/SettingsValueCatalog.cs`) "Tim decides when to hide it (ruling of 18 Oct: it stays visible for now)."
    - **Why:** it names a person and an internal ruling in text that colleagues read.
    - **Better:** "Untick to hide the Older longitudinal tab. CDPROFILE then becomes the only way to draw a long section. Default: on."
    - **Severity: MEDIUM**

37. **A tick that changes nothing you can see.** `AdvancedSettingsDialog.xaml:1369` (`CivilSettingsView.xaml:394`) "...prepared for the auto-design long section... Nothing draws this row today."
    - **Why:** cockpit test. A tick with no visible effect is noise.
    - **Better:** hide it until something draws the row, or label it "(no effect yet)".
    - **Severity: MEDIUM**

38. **"Stored deletion word".** `AdvancedSettingsDialog.xaml:1338` (`CivilSettingsView.xaml:363`) "Deep-pit Remarks show only the step-irons wording, never the stored deletion word."
    - **Better:** "A cell you delete stays blank. Remarks on a deep pit show only the step-irons note."
    - **Severity: MEDIUM**

39. **"Records".** `AdvancedSettingsDialog.xaml:1340` (`:365`) label "Moving the Pit Schedule leaves pit and pipe records unchanged", and the tooltip "writes no cell text into pit or pipe records".
    - **Better:** label "Moving the Pit Schedule never changes the pits or pipes". Tooltip: "Moving or stretching the drawn table does not copy its text back onto the pits or pipes."
    - **Severity: MEDIUM**

40. **"Drawing identity".** `AdvancedSettingsDialog.xaml:1358` (`:383`) "Two XREF drawings with the same drawing identity but different pit data stay separate in the source list. The second is named and is not offered for selection."
    - **Better:** "Two Xrefs saved from the same drawing (SAVEAS copies) but with different pits are listed separately. The second is shown by name but cannot be picked."
    - **Severity: MEDIUM**

41. **"Point Order" and "stored levels".** `AdvancedSettingsDialog.xaml:1384` (`:409`) "Point Order keeps stored levels with the drawn labels."
    - **Better:** "Yes puts the upstream pit first. No marks a rising main and its discharge pit. The levels stay with their labels."
    - **Severity: MEDIUM**

42. **Programmer rounding words.** `AdvancedSettingsDialog.xaml:1390` (`:415`) "Off uses AutoCAD runtime rounding, which can round a half to even."
    - **Better:** "Off can print 10.125 as 10.12 instead of 10.13."
    - **Severity: MEDIUM**

43. **"Stores", "unlinked".** `AdvancedSettingsDialog.xaml:1392` (`:417`) "Missing drawn text is replaced even when the pipe stores a level. Older unlinked IL text can get a second text beside it."
    - **Better:** "Puts back missing invert text even when CE knows the level. Old invert text CE does not know about may get a second copy beside it. Undo removes it."
    - **Severity: MEDIUM**

44. **"Project record", "Project QA", "native".** `AdvancedSettingsDialog.xaml:1394` (`:419`) "CE commands that change the project record mark automatic Project QA out of date. Off only marks it after native AutoCAD commands."
    - **Better:** "After any CE command changes a pit or pipe, the check result shows as out of date. Off: only plain AutoCAD edits (MOVE, STRETCH) do this."
    - **Severity: MEDIUM**

45. **"Host drawing", "trailing folder names".** `AdvancedSettingsDialog.xaml:1398` (`:423`) "CDXREFREPAIR avoids the host drawing, prefers matching trailing folder names..."
    - **Better:** "CDXREFREPAIR never points an Xref at the drawing you have open. It prefers the file in the folder whose name matches, and lists any other copies it finds."
    - **Severity: MEDIUM**

46. **"CE text".** `AdvancedSettingsDialog.xaml:1342` (`:367`) "A comma, a slash or MText formatting makes the cell return to CE text with a reason at the command line."
    - **Better:** "If you type a comma, a slash or formatting, the cell goes back to CE's figure and the command line says why."
    - **Severity: LOW**

47. **The same sentence 32 times.** "Untick only to get the old behaviour back for a comparison; the old behaviour was a fault." It ends 32 tooltips in `AdvancedSettingsDialog.xaml` (first at `:754`) and the same in `CivilSettingsView.xaml`.
    - **Why:** cockpit test, no repeated hints.
    - **Better:** one bold line at the top of the Fixes tab, "**Leave these ticked.** Untick one only to compare with the old, wrong result." Then drop the sentence from each tooltip.
    - **Severity: LOW**

48. **Two names for one tab, and a heading that does not fit.** `AdvancedSettingsDialog.xaml:1376` "Show the Older longitudinal tab in CDCALC". Two rows up it is called "the older long-section tab" (`:1366-1367`). This tick also sits under the heading "Long section fixes", but it is not a fix.
    - **Better:** keep the tab's own name, "Older longitudinal", in both places, and move this tick under its own heading, "CDCALC".
    - **Severity: LOW**

49. **Vague heading.** `AdvancedSettingsDialog.xaml:1377` "Tidy labels (more)".
    - **Better:** "Tidy labels fixes"
    - **Severity: LOW**

## 7. Civil: Settings (CDS), other tabs

50. **Start-up message to CE Cloud.** `AdvancedSettingsDialog.xaml:1128-1129` (`CivilSettingsView.xaml:207`) "Send CE's start-up heartbeat (install ID, CE and AutoCAD versions only) to CE Cloud", and the tooltip "Only posts when both CE Cloud environment variables are set. Off queues and sends nothing at start-up."
    - **Why:** heartbeat, install ID, environment variables, posts and queues are all software words.
    - **Better:** label "At start-up, tell the CE office this PC is running CE (CE and AutoCAD versions and a PC code only)". Tooltip: "Sends only when your CE administrator has set this PC up for it. Off: nothing is sent. Takes effect next time AutoCAD starts. Default: on."
    - **Severity: MEDIUM**

51. **Which millimetres?** `AdvancedSettingsDialog.xaml:1215-1216` (also `:1286`, `CivilSettingsView.xaml:243/313`) "Furthest a label may move out (mm)", and the tooltip "Maximum distance in drawing millimetres... uses 1500 mm".
    - **Why:** it does not say whether this is millimetres on the plotted sheet or real-world millimetres. 1500 mm in the model is 7.5 mm on a 1:200 sheet.
    - **Better:** "Furthest a label may move out (mm in the model, 1500 = 1.5 m)".
    - **Severity: MEDIUM**

52. **New switches with no tick on the Settings page (Settings-first).** `Models/DoubleClickSettings.cs:34` doubleClick.sourceEditWindow (**ON** by default), `Models/UserSettings.cs:2757` checks.leaveOutRemovedPits, `:2764` checks.showProgressWhenSlow and the seconds after it, `:1985` layerChecks.wrongLayerRows.
    - **Why:** a drafter cannot see or change these in CDS. The Edit source window is on and cannot be switched off from Settings.
    - **Better:** add one tick each in CDS > Newer tools. For example: "Double-click a downpipe opens a small Edit window", "Checks leave out pits marked To be removed", "Show a progress line when a check is slow", "List CE items on the wrong layer in Checks".
    - **Severity: MEDIUM**

53. **Two descriptions of one tick.** CommandOutcomeLines has one text as the tooltip (`AdvancedSettingsDialog.xaml:1089`) and a different text in `ViewModels/SettingsValueCatalog.cs` (the "Log one line…" entry), which is the text Settings search shows.
    - **Better:** one text in both. "CE's log gets one line each time a CE command finishes, is cancelled or fails (command name and time only). Default: on."
    - **Severity: LOW**

54. **Two Survey boxes, and mixed capitals.** `Dialogs/CivilSettingsView.xaml:169` "SURVEY" and `:188` "Survey" sit one after the other. `:197` says "DEBUGGING", and the new boxes "Detention" and "Privacy" are not in capitals like the rest.
    - **Better:** put the new tick inside the first SURVEY box. Rename "DEBUGGING" to "FAULT-FINDING", which is what CDS > Advanced already says. Use one style of capitals.
    - **Severity: LOW**

## 8. Ribbon labels and tooltips (command-registry.json, ce_toolbar_layout.json)

55. **One window, three names.** The ribbon says "Preferences" (`Modules/Drainage/Assets/Config/ce_toolbar_layout.json:189`; `command-registry.json:327` "Preferences (CDS)"). The CD and Edit Pipe buttons say "Preferences" (`Dialogs/CdDialog.xaml:145`, `Dialogs/PipeEditWorkshopDialog.xaml:449`). The window title says "Settings" (`AdvancedSettingsDialog.xaml:4`). Messages say "CE Settings" or "Settings". Help says "Settings" (`guide-content.js:95`).
    - **Better:** use **Settings** everywhere, for example "Settings (CDS)".
    - **Severity: MEDIUM**

56. **Two different things called "CE Manager".** `command-registry.json:319` CDMANAGER "CE Manager" is the Drawing Standards Manager. `Modules/Manager/Assets/Config/command-registry.json:33` CESURVEYREVIEW says "Opens CE Manager at the survey…" and means Suite Manager.
    - **Better:** CDMANAGER becomes "Drawing Standards (CDMANAGER)". CESURVEYREVIEW says "Opens CE Suite Manager at the survey…".
    - **Severity: MEDIUM**

57. **Banned words in ribbon tooltips.** CDDASHBOARD `command-registry.json:252` "network topology… schedule drift in one filterable view". CDANNOTATIONEDIT `:314` "compound entity". CDEXPORTENTITIES label `:343` "Export Entities". CDSLABIMPORT `:147` and CDTAG `:198` "into the CE data model".
    - **Better:** CDDASHBOARD: "One list of pipe connections, names, cover depths and schedule differences." CDANNOTATIONEDIT: "...without moving the rest of the pipe's text." Label: "Export pits and pipes". Data model: "...so CE knows about it".
    - **Severity: MEDIUM**

58. **US spelling and "sync".** `command-registry.json:351` and `ce_toolbar_layout.json:222` "Repair Center". `command-registry.json:355` "Open the repair center for sync, rebuild, upgrade and diagnostics."
    - **Better:** "Repair Centre". Tooltip: "Fix a drawing whose pits, pipes or schedule look wrong."
    - **Severity: MEDIUM** (LOW for the spelling alone)

59. **Manager Refresh tooltip.** `Modules/Manager/Assets/Config/command-registry.json:27` "Refresh plugin discovery, upload queued telemetry, and reload dashboard data."
    - **Why:** software words, and it does not say that it sends data.
    - **Better:** "Look again for installed CE tools, send any waiting usage notes to the office, and refresh this screen."
    - **Severity: MEDIUM**

60. **Small polish on other tooltips.** CDINSPECTOR "Open the CE Inspector context palette." repeats the label. CDSTRIP "100mm-wide" should be "100 mm wide". CDSOURCE "user-typed source ID" should be "a name you type". CDPERIMETER "same AG-style engine… pipe property" should be "works like CDAGI".
    - **Severity: LOW**

## 9. Help Centre (guide-content.js)

61. **Help lists six Settings tabs. The window has eight.** `Modules/Drainage/Assets/Help/guide-content.js:95` "Settings pages: Drafting, Pipes & Pits, Design, Survey, Display and Advanced."
    - **Why:** it is missing **Newer tools** and **Fixes**, which is where the Ignore and Tidy switches are. It also says "Pipes & Pits", while the tab is "Pipes and Pits".
    - **Better:** "Settings tabs: Drafting, Pipes and Pits, Design, Survey, Display, Advanced, Newer tools and Fixes."
    - **Severity: MEDIUM**

62. **Help says only the administrator can switch Checks on.** `guide-content.js:58` "your office administrator can switch it on in CE Settings."
    - **Why:** CDS > Advanced says these values are "One file for your Windows login on this computer". Any drafter can tick it, so the help is wrong about who can.
    - **Better:** "Switch it on in Settings (CDS) > Newer tools. Ask first: it has not been tested in AutoCAD yet."
    - **Severity: MEDIUM**

## 10. Older Civil strings (sample)

63. **CD window, used all day.** `Dialogs/CdDialog.xaml:469` "Use single pipe entity". `:238` "...and validation rules." `:244` "no invert or grade validation".
    - **Better:** "Draw the pipe as one line". "...and which checks apply." "Levels and grade are not checked."
    - **Severity: MEDIUM**

64. **Inspector and Edit Pit.** `Controls/InspectorPanelControl.xaml:266` "Handle", `:321` "GIO Handle", `:89` "This is the full-detail snapshot." `Dialogs/PitEditWorkshopDialog.xaml:203` "reference evidence, not authority. The existing primary action accepts these options."
    - **Better:** hide the handle rows (keep them for CE support). "This is the full view." "Fills the Cover level box only. Check it against survey. Press OK to use it."
    - **Severity: MEDIUM**

65. **Repair Centre and the CD help page.** `Dialogs/CdRepairDialog.xaml:46` "Sync first, rebuild second, deeper repair only when…" `:75` "1. Sync Links". `Dialogs/CdHelpDialog.xaml:94` "Rebuild refreshes caches from drawing truth and preserves user-entered data."
    - **Better:** "1. Reconnect pits and pipes". "Rebuild reads the pits and pipes again from what is drawn, and keeps what you typed."
    - **Severity: MEDIUM**

66. **Command-line developer words.** `Commands/AnnotationEditCommand.cs:57` "That entity is a CE compound root - use CDEDIT to edit it." `Commands/RunSolveCommand.cs:288` and `:467` "Selected pit has no ProjectData record - cannot walk its connectivity." `Commands/SlabCommand.cs:1229` "Could not resolve slab boundary polyline handle." `Commands/RulebookCommand.cs:158` "is not a council profile id". `Commands/HubCommands.cs:654` "entity(ies) skipped due to read errors".
    - **Better:** "That is a CE pipe or pit. Use CDEDIT." "[CE] CE has no levels for this pit yet. Run CDREPAIR > Rebuild, then try again." "[CE] CE could not find the slab outline. Pick the slab boundary again." "[CE] 'XYZ' is not a council CE knows. Type CDRULEBOOK Council to see the list." "[CE] 3 items could not be read and were skipped."
    - **Severity: MEDIUM**

67. **CDAUDIT and Recover Inverts, written like a programmer's dump.** `Commands/LinkCommands.cs:403` "CDAUDIT: pits=12, pipes=14, pipes-without-handle=0, duplicate-handle-groups=1". `:405` "Duplicate pipe handle 2A3F x2". `:2379` "Invert values are now persisted on the pipe entities. They will survive MText deletion." `Commands/LinkCommands.ReadOnlyAudit.cs:36` "cached ownership Unknown". `:40` "checking a snapshot of the stored CE cache… Pending changes have not been synchronised".
    - **Better:** "[CE] CDAUDIT: 12 pits, 14 pipes. 2 pipes are copies of one another. Type CDREPAIR to fix them." "[CE] The levels are now kept on the pipes, so deleting the invert text will not lose them." "[CE] This drawing was copied or saved under a new name, so CE checks only what is in this file. Nothing was repaired."
    - **Severity: MEDIUM**

68. **Messages open five different ways.** "[CE] …" is used in 674 messages. Others open with "CE: …" (progress line), "[CDRUNSOLVE] …", "CDAUDIT: …", "CDTAG applied: …", "CopyRot: …", or have no opening word ("CDTAG removed.").
    - **Better:** start every message with "[CE]".
    - **Severity: LOW**

---

## Checked and fine

1. **Keyword letters:** in all seven prompts where two options share a first letter, the second option already has its own capital letter (CdCommand.PitFit Upsize / Continue / cAncel; CDDISCIPLINE; CDANNOTATIONEDIT mIrror; CDRULEBOOK coVer / sOurce; CDRULES pReview; CDCONFIRM cLear; CDDEBUG ON / OFF).
2. **CDCHECKIGNORE "Type U to take it back. Nothing else was changed."** This is true: it writes once inside the command, so one U undoes it.
3. **Edit source window Cancel, "Nothing was changed."** This is true: it returns before anything is written.
4. **Wrong-layer rows (#1511, #1512):** "Layer CE-PIT is locked: unlock it to fix." and "This object is in an Xref or being edited in place, so CE will not move it." These are plain, give a next step, and respect AutoCAD's protections.
5. **Spelling:** apart from "Repair Center", every user string checked uses Australian spelling (colour, behaviour, centre, metre, cancelled).
