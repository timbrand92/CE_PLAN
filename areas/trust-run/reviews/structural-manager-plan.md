# Review: the Structural and Manager parts of the trust plan, for holes

**Reviewer:** lane trust-review (fifth run), Fri 13 Nov 2026, 01:06 PC clock. Read only. Done the way `areas\TRUST_PLAN_REVIEW_12NOV.md` did it for Civil: find the holes, not praise.
**What was read:** `areas\trust-plan-structural.md` (as of 00:47 on 13 Nov), `areas\trust-plan-manager.md`, `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`, and the four cards `04_REFERENCE\ux-plan\cards\TRUST-S1_*`, `TRUST-S2_*`, `TRUST-S3_*`, `TRUST-M2_*` (all dated 12 Nov). Code claims spot-checked in `C:\CE_WORK\scratch\audit_struc` (Structural 1.0.126, `8de95c34`) and `C:\CE_WORK\scratch\audit_civil\Modules\Manager` (Manager 1.1.89, `cf059dcf`). Paths below are inside `Modules\Structural\` or `Modules\Manager\` unless given in full.

---

# FOR TIM

1. **The code facts in these plans are good:** I re-read 29 of them in the installed code and 28 match; one line number had drifted.
2. **The biggest hole:** "same settings for everyone" would send your last job's required bracing figures to every colleague, the Structural twin of the Civil starting-levels problem.
3. **The bracing fixes now have two owners and two different answers,** and the support block fix is smaller than the card thinks, because the schedule import already knows each row's floor and then throws it away.

**Verdict: FIX FIRST** (twelve plan corrections, listed worst first). Nothing here is built; these are corrections to the plan and cards before any of them is approved or built. Nothing in this review is a decision by you.

---

## 1. The holes, worst first

1. **Step S6 would carry one job's required bracing to every colleague.**
   1. Structural keeps the required bracing figures in the PC's settings file, not in the drawing (BUG-500): CSBRACINGREQUIRED reads them from `SettingsService.Current.Bracing` and saves the settings file (`Commands\BracingPanelCommands.cs` 93 and 123; re-read).
   2. S6 says "the same office settings changed window and CE Health line as Civil step 3". Built the Civil way, the office setup would take these figures from your PC as office values, so every colleague's panel would read "/ 12000 mm required" from your last job.
   3. Fix in the plan: S6 needs its own personal list for Structural's per-job and last-used values (required bracing first), or S6 waits for BUG-500 to move the figures into the drawing. Add a robot case: your PC's figures never reach a colleague's file.
2. **The bracing fixes have two owners and the built one does not do what the plan recommends.**
   1. The plan puts BUG-497, 498 and 499 in step S4 (no card yet), and card TRUST-S2 says "the bracing fixes are card S4". But the trust-safety-fixes lane has already built all three under card TRUST-04 (draft PRs 2044, 2046, 2047).
   2. The plan's decision 5 and S4 say roof trusses are "shown on their own line" and a brace with no type "shows type ? and the panel goes amber". PR 2047 leaves trusses out with no line at all and does not touch the blank type.
   3. Fix: the controller names one card for these three bugs now (TRUST-04, since that is what was built), and S4, when written, covers only what is left: the trusses' own line, the blank type, and item 3 below.
3. **S4 misses three more ways the bracing panel's totals go wrong.**
   1. The panel ignores drawing units: a 2.7 m brace on a metre drawing reads about "3 mm provided" (BUG-503 item 2, filed 9 Oct). New braces cannot be placed on such a drawing, but braces already there are read.
   2. North-South and East-West are split by the drawing's own X axis, with a brace at exactly 45 degrees counted East-West, so a plan drawn turned to fit the sheet gets the two totals swapped or mixed (same entry). That can overstate one direction, which is the very thing S4's goal says must never happen.
   3. Older bracing drawn with the office's type C label blocks is probably not counted at all (the plan's own section 9 item 8, an inference).
   4. Fix: add all three to S4, or list them on the bracing panel's tool note as known faults before any colleague sees the panel.
4. **Card S3's starting fact is only half right, and the fix is smaller than it thinks.**
   1. The plan says "the schedule has no floor field at all" (section 4 line 1) and card S3 lists "whether the schedule sheets XCLMTXT reads carry a floor name" as not known.
   2. In the code, the schedule import already works out a floor for each row from the group titles (`Models\ExcelWorkbenchModels.cs` 32, `Floor` on each preview row; set from the title rows in `Services\ExcelMTextSourcePreviewLoader.cs` 430-456). The saved schedule then drops it: `XclmTxtService.BuildMemberScheduleSnapshot` (`Services\XclmTxtService.cs` 308-319) keeps only mark, size, group and note (`Services\MemberScheduleService.cs` 16-22).
   3. So S3 can keep the floor at save time and ask "which floor" by name in most cases; decision 2 (no floor names) becomes the fallback. Drawings already holding a saved schedule have no floor, so they need a re-import or the row-number question.
   4. Fix: correct section 4 line 1 and card S3 "Not known yet" item 1, and add "keep the floor when the schedule is saved" to S3.
5. **Card S1 assumes things the Civil ribbon build does not provide.**
   1. S1 says it reuses "the Civil core list file from card TRUST-02" and makes the ribbon and the pull-down menu read "one office core list file". As built (PR 2038), the Civil list is written into the plugin's code, not an office file, and the Civil menu does not read it (card TRUST-02 item 3.2 is not done).
   2. S1's "not known" item 1 (which of the two Structural ribbon builders draws today) can be answered from the code: the shared "CE Structural" contribution is compiled in only when the build sets `EnableUnifiedHostAdapters` (`CE_STRUC_SUITE.csproj` 96-98); without it only the own "CE STRUC" tab is built (`Plugin.cs` 196-204). With it, both are set up. Which way 1.0.126 was built can be read from its build script or DLL.
   3. Fix: S1 either builds the shared list itself or follows PR 2038's in-code list and drops the menu claim; and it pins whichever builders the installed build really runs.
6. **The plan and card S2 disagree about switches.** Plan S2 "Undo" says "Each change also has a switch"; card S2 section 3 says there is no switch for the wording, the save check or the SBEAM guard ("a fix to a wrong result does not get an off switch"). One must change.
7. **Card S2's read-only CLEAN case may stall the robot.** CLEAN does not refuse a read-only drawing (`Services\CleanPipelineService.cs` 59-78), so its own save fails and it falls back to sending QSAVE (167-168). On a read-only file QSAVE can open AutoCAD's Save As window. Fix: run the case with AutoCAD's file dialogs off, or make the save fail another way (a copy locked by another program), and say which.
8. **S5 only reports a change your B5 answer may want stopped.** For Civil you chose "Nothing changes on open" (B5, `areas\trust-plan.md` line 249). Structural converts old beam links when any drawing opens and writes a marker into it (`Services\LinkMigrationService.cs` 20 and 29-33), so a drawing that was only opened then asks "save changes?". S5 makes it say a line; it does not say whether B5 applies to Structural. Fix: put that question to you, with "move it out of opening, as Civil step 8 does" as the recommended answer.
9. **Structural's colleague condition has no Manager step that meets it.** The Structural plan requires "Manager can send Structural on its own and take it back on its own" (section 6 item 5), and Manager decision 3 recommends Structural as its own release. None of M1 to M6 builds a Structural-only release route (the signed profiles are "Coordinated CE", "Standalone Manager" and "Standalone Civil", `Shared\CE.Release\OfficialReleaseGate.cs` 160-165; re-read). Fix: add the step, or change the condition.
10. **The Structural test set names real past jobs with no privacy rule.** Section 6 item 3 asks for "about five real past jobs, roof to footings". The run's rule 7 forbids client data in any file, and the Civil test set takes answers from the issued plan's labels, on copies. Fix: same rules for Structural, written in the plan.
11. **Where the going-back rehearsal may run is said two ways.** Plan M2 allows your PC outside your hours if no spare PC exists; card M2 says never your own login. A second login on your PC still shares the all-users plugin folder that card M2 section 2 item 4 checks, so a slip there would change your AutoCAD too. Fix: one rule; if your PC is ever the fallback, the rehearsal must not touch the all-users folder.
12. **Card M2's drawing check needs a reader that does not exist for Structural.** It says the robot reads "the same pits, pipes and supports" under both builds. The reader (PR 2040) reads Civil only. Fix: say how supports are compared (for example block names, counts and attribute values read by the robot), or narrow the check to pits and pipes.

## 2. Smaller corrections

1. **Manager plan status is stale:** section 12 says "Steps M1 to M6: no cards yet", while section 5 links the M4 card and the M2 card exists.
2. **"On 2022 to 2024 nothing tells the colleague"** is verified only as far as the ribbon status hook sitting inside a 2025-and-later block (`Plugin.cs` 159-161). Whether the menu bar or the command line says anything was not searched. Mark it partly verified.
3. **"Send a fault report" writes into the office folder:** now verified for where it goes (`Services\CeDiagnosticsService.cs` 300-311: the IT Admin folder, "CE Diagnostics", one folder per PC). Whether names and paths are taken out of what it writes is not checked; it decides whether colleague data reaches the office folder, so check it before M5.
4. **Line drift:** BT1's block and layer are at `Commands\BracingCommands.cs` 323-324, not 318-320.
5. **Decision 5 wording against PR 2047:** the PR's layer finding should go into your question: BT1 draws on the layer "WALL BRACING TYPE BT1" (`Commands\BracingCommands.cs` 250 and 324), so the office layer standard files these trusses with wall bracing.

## 3. Code claims spot-checked (29; 28 match)

Structural (`8de95c34`):
1. The ribbon skips hidden rows and asks for expert rows too: `Services\RibbonCommandHubService.cs` 176-179, `Services\CeStrucRibbonContributor.cs` 29. MATCH. (The shared builder also skips hidden rows, inside `GetVisible`, `Services\CommandRegistryService.cs` 86.)
2. MR, MOVEROT, CR and COPYROT kept off the Structural tab: `CeStrucRibbonContributor.cs` 53. MATCH.
3. CLEAN sends QSAVE and counts the save done without checking: `CleanPipelineService.cs` 167-169. MATCH.
4. CLEAN's step ends on any error: 232-236; objects opened for change with no locked-layer allowance: 409. MATCH.
5. C1 and C2 take the first schedule row by mark and say "from the schedule": `Commands\SupportBlockCommands.cs` 249-255. MATCH.
6. A size the block cannot show falls back to the default with a log line only: 1470-1480. MATCH.
7. Every BRACING block is collected: `Services\ProjectDataService.cs` 282-283; a blank type is read as A: 316-320. MATCH.
8. Required bracing kept in the PC settings: `Commands\BracingPanelCommands.cs` 93, 123. MATCH.
9. Reset Defaults saves new settings with no question: `UI\Dialogs\CeSettingsDialog.xaml.cs` 475-478. MATCH.
10. Settings page says "CE never saves": `UI\Dialogs\CeSettingsDialog.xaml` 557. MATCH.
11. CLEAN's short and long descriptions disagree; FASTSAVE is both another name of CLEAN and its own entry: `Assets\Config\command-registry.json` 4136-4157. MATCH.
12. Settings file written at start-up: `Services\SettingsService.cs` 675-684. MATCH (it skips the write when nothing changed).
13. Text anchors repaired on idle; timed save removed, interval settings unused: `Services\DrawingAutoSaveService.cs` 1098-1105, 1112-1118. MATCH.
14. The schedule saved in the drawing keeps only included rows: `Services\XclmTxtService.cs` 308-319. MATCH.
15. Old beam links converted on every open drawing with a marker: `Services\LinkMigrationService.cs` 20, 29-33. MATCH.
16. BT1 inserts the BRACING block on "WALL BRACING TYPE BT1": `Commands\BracingCommands.cs` 318-320 claimed, found at 323-324. LINE DRIFT.

Manager (`cf059dcf`):
17. Waits 15 seconds, then prepares updates: `Plugin.cs` 141-147. MATCH.
18. Ribbon status hook only in the 2025-and-later block: 159-161. MATCH (see 2.2).
19. Civil prepared first; Manager not prepared alone: `Services\CeApprovedReleaseService.cs` 626-647. MATCH.
20. Roll Back rewrites the approval record, swaps current and previous (one step back only): 384-402. MATCH.
21. "ask your CE administrator to finish the install": `Services\CeInstallWords.cs` 12. MATCH.
22. CEHEALTH prints Manager OK always; no pair line when Civil is not found: `Services\CeHealthChecks.cs` 28-29, 36-39. MATCH.
23. Manager switches per PC: `Services\CeOneGlanceStatus.cs` 344-352. MATCH.
24. Roll Back shown only when the switch file says so: 389-390. MATCH.
25. Support zip never uploaded: `Services\CeSupportBundleService.cs` 48-50. MATCH.
26. Local administrator fallback when the office folder cannot be reached: `Services\CeAdminPolicyService.cs` 247-256. MATCH.
27. Only failure reports are sent; usage and machine reports never: `Services\CeAdminStorageService.cs` 438-439. MATCH.
28. Signed release profiles have no Structural-only route: `Shared\CE.Release\OfficialReleaseGate.cs` 160-165. MATCH.
29. Manager's report carries Manager's own version only, coded user and PC: `Services\CeAdminTelemetryService.cs` 86-104. MATCH.

## 4. Not checked

1. The command log counts (DS 211 and the rest) and the 375 / 63 / 39 row counts were not re-counted.
2. Cards S4 to S6 and M1, M3 to M6 do not exist yet (M4 exists and was not read).
3. Nothing was run; no drawing was opened; AutoCAD 2022 to 2024 not looked at.
4. `areas\TRUST_STRUCTURAL_TOOLS_FIRST_CHECK_12NOV.md` and `areas\TRUST_QUESTIONS_FOR_TIM.md`, if they now exist, were not read.
