# Structural build batches, 30 Oct 2026

Made by a Haiku sorting job from the 24 Oct triage queue (BUG_REGISTER_TRIAGE_2026-10-24.md, TASK 3) and BUG_CARPARK.md on 30 Oct 2026. Keyword reading only, not verified against code. Nothing was built, run or opened in AutoCAD.

## Counts

1. **Structural BUG numbers in the queue:** 73 (S1 14, S2 33, S3 18, plus 8 tier-2 entries).
2. **Removed as already handled:** 10 (BUG-467, 495, 625, 1183, 1184, 1136, 1199, 472, 480, 451). BUG-822, 1218, 1220 and 1050 are not Structural entries, so nothing was removed for them.
3. **Left after removal:** 63 (S1 15 including BUG-529, S2 30, S3 18).
4. **NOT-A-BUILD:** 20 (listed below, not batched).
5. **Buildable:** 43, in 16 batches (BATCH S-1 to S-16). Tier 2 comes first (S-1), then S1, S2 and S3.

## Rules used

1. **Tier and group** come from the triage file and the carpark entry. BUG-1193 is a Civil command (CDPROFILE) that the triage lists under Structural, so it is kept here with the Structural queue.
2. **Batches** hold 2 or 3 entries that name the same source file. Where an entry names no file, it is batched with others in the same area and marked "none named".
3. **Shared files across batches** are listed after the batches. A builder should run the batches that share a file one after another, not at the same time.
4. **Status** is OPEN for all 43 buildable entries (found by reading code, not seen in AutoCAD), except BUG-1186, which the entry marks as protected by the native locked-layer rule.

## Batches

## BATCH S-1 (S1, tier 2)

1. **BUG-529:** Footing size 12000 is refused, typed stirrup cover 5 silently becomes 10, and spacing 40 or 1200 is refused. It should warn and carry on. Files: Modules/Structural/Services/FoundationService.cs; Modules/Structural/Commands/RebarCommands.cs. Status: OPEN.
2. **BUG-300:** After ERASE of a footing line, OOPS restores the line, but the footing stays set aside and its outline is not redrawn. Files: FoundationService.cs. Status: OPEN.
3. **BUG-474:** Renaming a pad in FEDIT to a mark that already exists silently overwrites that mark's saved size. Files: Services/FoundationService.cs. Status: OPEN.

## BATCH S-2 (S1, tier 3)

1. **BUG-1146:** The footing-size cache is keyed on file name, so a new drawing from the same template silently reuses the old size for THCL 81. Files: Services/CeTextService.cs; FoundationRegistryService.cs. Status: OPEN.
2. **BUG-1147:** The footing register and beam-link records do not refuse newer versions or catch unknown fields, so an older build can save over them. Files: Services/FoundationRegistryService.cs; Models/FoundationModels.cs; BeamLinkPersistenceCodec.cs; FstMemoryService.cs. Status: OPEN.
3. **BUG-1159:** Footing-size list entries that do not match the pattern are skipped, and an emptied list is erased on the next save. Files: Services/FstMemoryService.cs. Status: OPEN.

## BATCH S-3 (S1, tier 3)

1. **BUG-1139:** COPY of a beam keeps the original's label and column links, so a later beams-follow edit can move the wrong label. Files: Services/BeamLinkService.cs; Commands/SupportBlockCommands.cs; ConnectedFollowApply.cs. Status: OPEN.
2. **BUG-1204:** After an old drawing is opened and closed without saving, the link conversion is remembered, so the label no longer moves with its line on reopen. Files: Modules/Structural/Services/LinkMigrationService.cs; LinkService.cs; Models/LinkData.cs. Status: OPEN.
3. **BUG-1162:** CSPOINTLOAD skips a damaged load group, saves only the readable loads, and numbers the new load P1 again. Files: Core/Roofs/RoofPointLoadMarkers.cs; PointLoadMarkerService.cs. Status: OPEN.

## BATCH S-4 (S1, tier 3)

1. **BUG-578:** The footing-size library keeps two rows for one mark after a placement, and FPFC asks for the size again instead of using the saved row. Files: none named. Status: OPEN.
2. **BUG-613:** In an RC beam compound, plain MOVE moves only the outline; bars, cog ligature, labels and dimensions stay behind. Files: none named. Status: OPEN.
3. **BUG-616:** XRL counts and moves attached references at once, with no highlighted preview and no Apply step. Files: none named. Status: OPEN.

## BATCH S-5 (S2, tier 3)

1. **BUG-1121:** CEMEMBER maps "114.3x6" to 114.3x6.4 CHS because no 6.0 wall is listed, so the wrong wall is drawn. Files: Modules/Structural.DesignCore/SteelSections/CeMemberPrompts.cs; Commands/CeMemberCommands.cs. Status: OPEN.
2. **BUG-1132:** After the BUG-818 rename, grip-editing an old CEMEMBER beam refuses to redraw it, because its old section name is no longer in the list. Files: CeMemberReplanner.cs. Status: OPEN.

## BATCH S-6 (S2, tier 3)

1. **BUG-611:** The Timber preview says "No local steel sections match that search" while the valid 90x240 preview is live. Files: SteelSectionPickerDialog (named without folder or extension in the entry). Status: OPEN.
2. **BUG-1126:** The picker rounds small values: 40x40x3 EA shows Ix 0, and a 1.12 kg/m angle shows 1.1 kg/m. The stored record keeps the full figure. Files: UI/Dialogs/SteelSectionPickerDialog.xaml.cs. Status: OPEN.
3. **BUG-1131:** The picker's "Optional member length (m)" box accepts 6000 and shows 192000 kg, with no sense check. Files: UI/Dialogs/SteelSectionPickerDialog.xaml; SbeamSelectionPlanner.cs. Status: OPEN.

## BATCH S-7 (S2, tier 3; includes BUG-1123 from S1)

1. **BUG-1122:** The section list rounds some UB masses differently from the XCLMTXT spelling table, so typed names such as 410UB59 do not resolve. Files: Assets/Config/section-catalogue.json; SbeamSelectionPlanner.cs; CeMemberPrompts.cs; Services/ExcelMTextService.cs. Status: OPEN.
2. **BUG-1123 (triage group S1):** XCLMTXT locks every UB/UC size before the office spelling list runs, so a typo row such as 250UB26 is skipped and "250 UB 26" is printed. Files: Services/ExcelMTextService.cs. Status: OPEN. Moved here because it shares ExcelMTextService.cs with BUG-1122 and BUG-1128.
3. **BUG-1128:** XCLMTXT prints "TOP PL & BOT PL" as "TOP PLATE & BOT PL", and a trailing "PL" stays while "PL WITH" becomes "PLATE WITH". Files: Services/ExcelMTextService.cs. Status: OPEN.

## BATCH S-8 (S2, tier 3)

1. **BUG-1185:** CSTAGBEARERS on a hand-drawn bearer adds a duplicate line, and on a bent polyline adds a straight chord across the bend. Files: Services/TimberSubfloorService.cs. Status: OPEN.
2. **BUG-1193:** CDPROFILE boundary marks ignore polyline bulge and arcs, so a curved boundary is marked at 5 m instead of 10 m. Files: ViewModels/LongitudinalSectionViewModel.cs. Status: OPEN.
3. **BUG-1200:** Escape at the THCL centre prompt still saves size 81 as 600/600, and Escape at the text prompt leaves a 900 x 900 outline. Files: Commands/CeTextCommands.cs; Services/CeTextService.cs; FstMemoryService.cs; CommandExecutionService.cs. Status: OPEN.

## BATCH S-9 (S2, tier 3)

1. **BUG-626:** FFL placement runs point, side, value, then draws at once, with no source or Manual choice and no preview before placement. Files: none named. Status: OPEN.
2. **BUG-627:** A normal MOVE of a level mark's triangle moves only the triangle, leaving the tail and value behind. Files: none named. Status: OPEN.

## BATCH S-10 (S2, tier 3)

1. **BUG-630:** SM asks for points and direction before the identifier and sheet, then writes at once with no final preview. Files: SectionMarkCommands (named without extension in the entry). Status: OPEN.
2. **BUG-631:** A normal MOVE of a section cut line moves only the line; both end markers and the A/S02 labels stay. Files: none named. Status: OPEN.

## BATCH S-11 (S2, tier 3)

1. **BUG-634:** DSET converts a dimension with an unrecognised style at once, changing its scale factor, with no preview or Apply. Files: none named. Status: OPEN.
2. **BUG-640:** RD asks for the dimension type before it asks for the arc or circle, the reverse of the approved card. Files: none named. Status: OPEN.

## BATCH S-12 (S2, tier 3)

1. **BUG-579:** An explicit FPFC depth of 350 is lost after Undo and Redo, so FEDIT offers 0 and the schedule shows UNKNOWN. Files: none named. Status: OPEN.
2. **BUG-615:** CH creates the hatch at once, with no live preview and no Apply step to adjust scale or angle. Files: none named. Status: OPEN.
3. **BUG-1129:** BARWEIGHT and the bar schedule give slightly different masses for the same bars, and N40, R6 and R10 show UNKNOWN on the schedule. Files: Services/StandardsService.cs; RebarService.cs; Assets/Config/rebar-catalogue.json; ReoBarService.cs. Status: OPEN.

## BATCH S-13 (S3, tier 3)

1. **BUG-526:** Twenty-nine Structural Settings groups are never read by CESETTINGS, so some values cannot be seen or changed in that window. Files: UI/Dialogs/CeSettingsDialog.xaml.cs; Modules/Structural/Models/UserSettings.cs. Status: OPEN.
2. **BUG-533:** The required bracing lengths (north-south and east-west) are one value for the whole PC, not saved with the job. Files: Modules/Structural/Models/UserSettings.cs; Commands/BracingPanelCommands.cs; Structural.DesignCore/BracingPanelCalculator.cs. Status: OPEN.
3. **BUG-535:** Six values already in CS_Settings.json have no box on CESETTINGS, so they can only be changed by editing the file. Files: CS_Settings.json; Models/UserSettings.cs; Services/FoundationService.cs; Structural.DesignCore/BracingLengthPolicy.cs; Commands/BracingPanelCommands.cs. Status: OPEN.

## BATCH S-14 (S3, tier 3)

1. **BUG-470:** FSF accepts any line as a footing centre line, so picking an existing footing outline may lose the new strip at once. Files: Services/FoundationService.cs. Status: OPEN.
2. **BUG-536:** Eight commands ignore an existing Settings name, or read it for only part of the job. Files: Services/FoundationScrewPileService.cs; Models/UserSettings.cs; Services/FoundationService.cs; Services/NativeTimToolsService.cs; Commands/BeamPlacementCommands.cs; Services/ExcelMTextService.cs; Services/ScheduleService.cs; Services/FoundationScheduleService.cs; Structural.DesignCore/LoadPathEngine.cs. Status: OPEN.

## BATCH S-15 (S3, tier 3)

1. **BUG-473:** BT1, C1, TS1 and BTX lack the locked-layer check that CSREOBAR uses. Files: LayerService.cs; ReoBarService.cs; BracingService.cs; BracingCommands.cs; BeamTextConvertCommands.cs; SupportBlockCommands.cs. Status: OPEN.
2. **BUG-1186:** CSTAGBEARERS still adds labels to a locked 25TEXT layer and says "Tagged 1 bearer(s)". The fix is to refuse, never to unlock. Files: Services/TimberSubfloorService.cs; LegacyToolCommon.cs; LayerService.cs. Status: OPEN. Protected: yes (native locked-layer rule).
3. **BUG-1187:** A mistyped Lineweight cell is replaced by the default with no error, and ByLayer linework changes thickness. Files: UI/LayerManagerWindow.xaml.cs; LayerService.cs. Status: OPEN.

## BATCH S-16 (S3, tier 3)

1. **BUG-1134:** CSMEMBERSCHED compares sizes as typed, so "310UB32" and "310 UB 32" show as different sizes. Files: Core/Schedules/MemberScheduleFromPlan.cs. Status: OPEN.
2. **BUG-1203:** Background refresh ignores its own switch, so with it unticked AutoCAD still scans folders and loads the cache at start-up. Files: Modules/Structural/Plugin.cs; Services/XclmTxtCorpusIndexService.cs; Models/UserSettings.cs; UI/Dialogs/CeSettingsDialog.xaml; XclmTxtService.cs. Status: OPEN.
3. **BUG-1219:** CEHELP describes prompts for BEAM and RJSET that the commands do not ask; both open CE Settings instead. Files: Assets/Config/command-registry.json; Commands/BeamSettingsCommand.cs; RafterJoistCommands.cs; UI/Dialogs/CommandHelpWindow.xaml.cs. Status: OPEN.

## Shared files across batches

1. **FoundationService.cs:** S-1 (BUG-529, 300, 474), S-13 (BUG-535), S-14 (BUG-470, 536). Run S-1 before S-13 and S-14.
2. **UserSettings.cs:** S-13 (BUG-526, 533, 535), S-14 (BUG-536), S-16 (BUG-1203).
3. **CeTextService.cs and FstMemoryService.cs:** S-2 (BUG-1146, 1147, 1159) and S-8 (BUG-1200).
4. **ExcelMTextService.cs:** S-7 (BUG-1122, 1123, 1128) and S-14 (BUG-536).
5. **ReoBarService.cs:** S-12 (BUG-1129) and S-15 (BUG-473).
6. **TimberSubfloorService.cs:** S-8 (BUG-1185) and S-15 (BUG-1186).
7. **SupportBlockCommands.cs:** S-3 (BUG-1139) and S-15 (BUG-473).
8. **CeMemberPrompts.cs:** S-5 (BUG-1121) and S-7 (BUG-1122). **SbeamSelectionPlanner.cs:** S-6 (BUG-1131) and S-7 (BUG-1122).
9. **CeSettingsDialog.xaml:** S-13 (BUG-526, its .cs file) and S-16 (BUG-1203).

## NOT-A-BUILD (20, not batched)

1. **BUG-202 (S1):** "OPEN - investigating (mostly environment". Lag investigation, not a fix.
2. **BUG-304 (S2):** "Untested (no 2024 on this PC)". Needs a run on AutoCAD 2024.
3. **BUG-383 (S3):** "so something writes at open". The cause is not found; needs an AutoCAD run to find the writer.
4. **BUG-399 (S3):** "OPEN (observation)". Observation only.
5. **BUG-409 (S3):** "needs the desk's/Tim's word because it is Tim's settings file". Test incident.
6. **BUG-411 (S3):** "Tim's decision needed on the binding". Decision first.
7. **BUG-469 (S1):** "the old saved-and-redrawn fault did NOT occur (PR #867, in 1.0.112)". Needs Tim's acceptance on a current build, not a build.
8. **BUG-493 (S3):** Audit umbrella with "(C16, observation)". Split and decide before any build.
9. **BUG-537 (S3):** Audit umbrella with "do not change without consulting Tim" (item 55 colour numbers). Tim's word first.
10. **BUG-623 (S2):** "MEDIUM OPEN - investigation required". The cause is not separated yet.
11. **BUG-749 (S2):** "stays OPEN until a second run either reproduces it". May be a Codex typing error, not CE.
12. **BUG-819 (S2):** "Not to be built before Tim has reviewed the corr[ected drawing]". Tim's review first.
13. **BUG-1084 (S2):** "has not been seen" in AutoCAD (REFEDIT hatch). Needs an AutoCAD look first.
14. **BUG-1124 (S2):** "needs Tim's word". The card does not say which UA leg may be upright.
15. **BUG-1125 (S2):** "a question for Tim". "Not a bug until he says so."
16. **BUG-1127 (S2):** "supplier drawings from memory, UNVERIFIED". Needs the real supplier data.
17. **BUG-1130 (S2):** "from memory, UNVERIFIED". The real radius needs checking first.
18. **BUG-1133 (S2):** "not known whether any sheet puts the symbol elsewhere". Needs a fact check.
19. **BUG-1154 (S2):** "is untested" (DXFOUT and older DWG splitting). Needs a test first.
20. **BUG-1224 (S3):** "Tim's answer replaces it". The triage marked it build-on-recommended; it waits on Tim's choice of default for locked layers.

## What I could not read

1. **Every line of each entry:** I read the Command/Area, Symptom, Expected, Steps and Status fields, and ran keyword checks for Tim, decision, untested and unverified. The long umbrella entries (BUG-493, 529, 536, 537) were read in part only.
2. **Entries BUG-611 to 640:** these have no Command/Area line, so I used their numbered steps.
3. **Source code:** nothing was opened. File names are the ones the entries name. Some are named without folder or extension, as shown.
4. **PR cover:** I did not check whether PRs already fix BUG-611, 819, 1084, 533, 535 or 536. The triage flagged them as named in PR bodies.
5. **Installed build:** not checked. Entries cite Structural 1.0.116 to 1.0.124.
6. **Office and supplier files:** the office MEMBERS.csv (BUG-1123) and supplier data (BUG-1127, 1130) sit outside the repo and were not opened.
7. **PR #480:** BUG-300 relates to PR #480, which its entry says is held out of the train. I did not check whether #480 has since merged.
