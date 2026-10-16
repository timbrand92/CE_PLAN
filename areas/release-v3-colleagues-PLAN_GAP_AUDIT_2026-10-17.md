# V3 plan gap audit: built, wired, installed, tested (desk plan/03 auditor, Opus, Max account, Sat 17 Oct 2026, about 02:30 to 03:30 Melbourne)

**What this is.** A read-only check of every item in the two 10 Oct build queues (`release-v3-colleagues-BUILD_QUEUE_V3_2026-10-10.md` and `..._RUN2_2026-10-10.md`, 150 items plus their "after these" lines) and the 53 UX cards in `04_REFERENCE\ux-plan\cards` (question files left out), against the code that is actually installed. No code was edited, built or run. Nothing was opened in AutoCAD.

**What "installed" means here.** I read the DLLs at 02:40: Civil 3.0.50 and Manager 1.1.50 (both +d36f9545, line `origin/claude/rel-20261010e`) and Structural 1.0.117 (+0dfbd1d6, line `origin/claude/rel-20261010d`). Every open PR was tested for ancestry against those two lines with `git merge-base --is-ancestor` (897 open PRs, fetched 02:30).

**How each item was judged.** Three read-only Opus helpers (one per lane) grepped the two lines for each engine's class, its callers outside its own file and tests, its command and its Settings key. I re-checked the headline claims myself (CDTIDYLABELS and CDCHECKS are absent from the Civil line; `ReadableTextRule` has no caller; `Hydraulics.Gravity` is still 9.8; `CeAzurePublishService.cs` still ships; CSMEMBERSCHED exists but no CSMEMBERSCHEDULE). Items a helper marked "log only" rest on the builder logs, not on a code check.

---

## 1. The honest figures (four words kept apart, RULES 4)

### 1a. Answer first

1. **Most of the V3 plan work is built but not installed.** 408 of the 897 open PRs are on neither installed line. Of the PRs numbered #1008 and up (everything the three lanes built from the 10 Oct queues onward), only 11 are installed: Civil #1090, #1218, #1222, #1223, #1224, #1237, #1244 and Structural #1203, #1206, #1209, #1227.
2. **What is installed is mostly invisible.** Nearly every installed feature that changes what a drafter sees has its Settings switch OFF. The Settings page rows that would let anyone turn them on are themselves uninstalled open PRs (Codex #1063, #1208, #1246, #1248, #1250, #1251, #1252).
3. **The review pipe is the wall.** About 182 of the 228 uninstalled PRs numbered #1008 to #1249 have no entry in `REVIEWLANE_LOG.md` at all. About 130 uninstalled PRs do carry an Opus MERGE or MERGE-WITH-FIXES verdict, and 34 of them have a merge order ready for the next trains (REVIEWLANE entries 1020 and 1038).

### 1b. The audited plan items (284 audit lines: 101 Structural, 76 Civil engine and Manager, 107 Civil drafting; some card lines repeat a queue line)

1. **Built (an engine exists anywhere, installed or on an open PR): 238 of 284.** NOT BUILT: 46 (Structural 17, Civil engine 13, Civil drafting 16).
2. **Wired (a command, ribbon button or window reaches it): about 107 of 284.** 59 are wired on the installed lines. About 48 more are wired to a command only on an open PR that is not installed (Structural about 15, Civil engine 13, Civil drafting about 20).
3. **ENGINE ONLY, the "no caller" group: 131 of 284.** 18 are on the installed lines with nothing calling them (Structural 5, Civil engine 6, Civil drafting 7). About 113 are on open PRs with no caller even there.
4. **Installed (on 3.0.50 and 1.0.117): 77 of 284.** That is the 59 wired plus the 18 no-caller engines. Of the 59 wired, almost every one that changes the drawing is behind a switch that defaults OFF. The exceptions are beam linking (ON, INT-078), the contextual tab jump (UX-RIBBON-01, ON), the grade-check plan marker (BUG-351B, ON) and the closed-drawing wording (UX-STRUC-01, ON).
5. **Codex-tested: about 10 of the 59 wired and installed items have any Codex native check.** This is an estimate from matching IDs, not a count. The ones I can match are UX-FRM-05 (CSROOFSETOUT), UX-FRM-11 (CSFLOORSETOUT), the Batch 6 survey and long-section cards (UX-SURF-03/04, UX-LSEC-01/02), the bracing panel (UX-FRM-14), BUG-558 REDO and beam linking. Every one of those checks ran on 3.0.49 / 1.0.116 or earlier. **None has run on the installed 3.0.50 / 1.0.117 yet.** The Claude robot pass run 22 is due Sat 14:08. Many checks saw the feature with its switch at the OFF default ("not switched on in this version"), which proves the guard, not the feature.
6. **Tim-accepted: 0.** No plan item is recorded as accepted in AutoCAD. Codex-accepted plan items (RULES 4.5): none recorded as whole items. The coverage index marks every case `wholeItemAccepted: false`.

### 1c. Cross-check on the whole UX plan (492 IDs expanded from `V3_UX_PLAN.md`, matched by name in commit messages, a text-match floor)

1. **Named in a commit on an installed line: 231 of 492.**
2. **Named only on an uninstalled open PR: 79 more**, so 310 of 492 are named anywhere. Examples: UX-CPLAN-01/02/03/08/09/11/12/15/16/17/33/34, UX-CR-01 to 17, UX-MGR-05 to 13, UX-OLF-01 to 04, UX-SURV-01/02/04, UX-RFI-01 to 03, UX-L3-25/26.
3. **Named in no commit: 182.** Some are built under another name: UX-LSEC-01/02 and UX-LOOK-01 have Codex checks but no commit names them. Most really are unbuilt and uncarded: UX-AI-01 to 07, UX-QA-01 to 08, UX-RW-01 to 11, UX-RL-01 to 06, UX-SSCHED-01 to 13 (most), UX-XDISC-01 to 04, UX-L3-01 to 24 (the Level 3 user-facing set), UX-REG-01 to 15 (most), UX-ACC, UX-FIRST, UX-PANEL, UX-LYR, UX-TANK, UX-WIN-01/04.
4. **Codex native coverage: 17 of 492 UX IDs** (762 checks: 592 PASS, 139 FAIL, 7 BLOCKED, 24 UNPROVEN; 94 bug IDs). Codex's own record: 12 of 39 approved cards audited in full (180 of 600 numbered requirements).
5. **This replaces "Built about 60 percent, Installed about 53 percent"** (triage file section 6, 12 Oct estimate). That pair mixed open bugs with UX IDs and counted an uninstalled draft as built. On the plan alone the honest pair is: named in a commit 63 percent (310 of 492); installed by name 47 percent (231 of 492); installed and reachable by a drafter with default settings well under 10 percent.

---

## 2. Per-lane wiring queues (ordered; each is one DRAFT PR, failing test first, Settings switch OFF where it changes the drawing, Opus review, REGRESSION_LOG in AutoCAD words)

### 2.0 Desk and trains first (no new code; this moves the most items)

1. **Run the two ready trains.** Civil on C-39: the 22-PR list in REVIEWLANE entry 1038, hand-resolving `UserSettings.cs` at #1286, #1289 and #1291. Structural on S-37: the 12-PR list in entry 1038. Risk: medium (Settings-file merge clashes are named in entry 1037).
2. **Review the 10 Oct plan PRs in lane batches, oldest first.** About 182 uninstalled PRs numbered #1008 to #1249 have no review entry. Start with the ones that already reach a command, because one review there makes a feature reachable. Civil: #1009, #1017, #1020, #1031, #1034, #1047, #1053, #1079, #1086, #1138, #1144, #1147, #1150, #1152, #1156, #1159, #1161, #1165, #1167, #1170, #1176, #1305 and #837/#847 (CDTIDYLABELS). Structural: #1008, #1011, #1012, #1024, #1052, #1066, #1068, #1071, #1135, #1201, #1202, #1157, #1164, #1168. Risk: low per PR, high in total.
3. **Close the duplicates before review.** Civil #1036 (duplicates #1031) and #1021, #1023, #1028 (duplicate the installed #1218, #1224, #1223). Structural #851 and #1045 when #1201 merges. Risk: low.
4. **Install the Settings pages with the next trains.** Codex #1208, #1246, #1251, #1252 (Civil) and #1063, #1248, #1250 (Structural). Without them every OFF feature can only be switched on by editing a settings file. Risk: low (no engineering change; the source-text tests exist).

### 2.1 Lane 02, Structural (roof down where it applies)

1. **13.2 CSMEMBERSCHEDULE placement.** Next step: after CSMEMBERSCHED's command-line list, add "Place it [Here/Last place/Sheet]" calling `MemberSchedulePlacementRule` (#860, installed, no caller) and the existing XCLMTXT block writer to fill the office MEMBER SCHEDULE block. Switch `MemberSchedule.Enabled` OFF. Tim number: none. Risk: medium, needs an AutoCAD driver window for the block fill.
2. **13.3 per-wall-line bracing totals.** Next step: train #1078 (CSBRACINGLINES), then have the bracing panel read `BuildWallLineSnapshot` (#999, installed, no caller). The panel list is a Codex window. Tim number: none. Risk: low.
3. **15.7 CEMARKUPCLARIFY.** Next step: add the command calling the prompt flow (#1172) and the PDF writer (#1057), then open the PDF; the engine #1006 is installed with no caller. Nothing is sent anywhere. Tim number: none. Risk: low.
4. **15.8 CEMARKUPCOMPARE and the compare record.** Next step: train #1071 (wired there) and add the on-save record hook; `CeMarkupCompare` (#995) is installed with no caller. Tim number: none (100 mm default). Risk: medium (save hook, check REDO).
5. **Batch 15 slice 8, warning before issue.** Next step: `CeSheetsIssueService` calls the #1060 engine before publishing, "3 markup items are still open (P2). Issue anyway?". Switch `MarkupAI.WarnBeforeIssue` OFF. Tim number: none. Risk: low.
6. **STRUC-REGISTER-ISSUE slices 3, 4, 11 and issue hardening.** Next step: Publish Issue calls #1074 (suggest changed sheets and wording), #1085 (check plot) and #1182 (interrupted issue ends "incomplete"). Switches `CeSheets.IssueSuggestEnabled` and `CheckPlotEnabled` OFF. Slice 10 (Civil and Structural issue state apart) is NOT BUILT. The Sheets window rows are Codex's. Tim number: none. Risk: medium.
7. **Bracing tags and schedule (BUG-503 S-09, UX-FRM-14).** Next step: STRSCHEDCREATE's bracing table and BT1 tagging call `BracingScheduleWords` (#1205). Tim number: yes, default "wall line plus type plus count". Risk: low.
8. **S4 retaining walls (CSRW).** Next step: a hidden CSRW command calling `RetainingWallLayoutEngine` (#1102), then the tag and schedule row, one Undo. Sizes stay "Unknown, engineer to fill". Tim number: yes, the band table, default Unknown. Risk: medium.
9. **S4 fences, waffle pod, screw piles.** Next step: one command each, or CSFDNPROPOSE options, calling #1106, #1105 and #1103. Tim number: fence table yes (Unknown until filled); the rest no. Risk: medium.
10. **"(O)" mark reader.** Next step: send the XCLMTXT reader through `PlanMarkSuffix` (installed, no caller); guard tests are on #1184. Tim number: none. Risk: low.
11. **14.3 fill the office Block Wall Schedule block.** NOT BUILT. Next step: read the 28-shape dynamic block in a driver window, then write the fill step in `WallScheduleService`. Tim number: none. Risk: medium (AutoCAD-bound).
12. **14.4 strength band heading row.** Next step: after #1055 and #1164 train, draw the "40 MPa CONCRETE" heading row in `ScheduleService`. The FEDIT field is Codex's. Tim number: none. Risk: low.
13. **15.2 faded markup underlay.** NOT BUILT. Next step: a CEMARKUPSHOW toggle that attaches the PDF underlay on a non-plotting layer, lined up by the sheet border, and removes it before any plot. Tim number: none (recommended answers 11 and 12). Risk: high (plot path, AutoCAD-bound).
14. **Register slice 5, revision clouds.** Next step: the cloud-drawing step for the #1083 planner. Tim number: none. Risk: medium (AutoCAD-bound).
15. **UX-STRUC-02/05 ribbon families.** Next step: the Text family in `RibbonCommandHubService`, then the Legacy sort. Hatch gallery and Legacy sort are NOT BUILT; the Beam and Tag drop-downs are installed, OFF. Tim number: none for the sort; retiring CESTRUC waits for Tim. Risk: low.
16. **UX-SUB-04 arrow on the member below.** NOT BUILT. Next step: add the arrow to `PointLoadCommandService`. Tim number: none. Risk: low.
17. **CSSLABSTEP offers the step.** NOT BUILT, and there is no slab-level record. Next step: a card for the slab-level record first. Tim number: none. Risk: medium.
18. **UX-TITLEBLOCK-NEWJOB.** NOT BUILT. Next step: Settings key `CeProjectSetup.AskTitleBlockAtCreation` OFF, plus a Codex window. Tim number: the card's questions. Risk: low.
19. **Small NOT BUILT leftovers.** UX-STEEL-01/02 catalogue (edition "not set"), the D2 QA leftovers, CSMARKSRENUMBER report, the Sheets "Update drawings" registered command, BUG-527 job timer, footing outlines reader (shared with lane 03). Risk: low to medium.

### 2.2 Lane 03, Civil engine and Manager

1. **K-REQ-01 slices 2 and 3.** Next step: the CDPROFILE preview lists the `ProfileScheduleRowPreview` lines (installed, no caller); the combined long-section and Pit Schedule write as one Undo comes after, proven in AutoCAD. Tim number: none. Risk: medium (one Undo).
2. **Batch 2 cards 2.1 and 2.3 feeders.** Next step: the command-ended watcher calls `PipeEndOffPitRecorder` after MOVE, and the Checks reader takes its records. An "Ignore" on a CDCHECK row calls `WriteIgnoredChecksInDrawing`; nothing calls it today. Switches `checks.recordPipeEndsOffPit` and `checks.allowIgnoreFinding` OFF. Codex owes the Ignore button. Tim number: none. Risk: medium (MOVE hook, check REDO).
3. **Batch 2 card 2.7 pause a slow feature.** Next step: wrap label tidy and the QA refresh in `SlowdownMonitor` (installed, no caller), then train #1064. Manager needs a machine-level mirror of the paused list. Tim number: none. Risk: low.
4. **Card 6.8 crossing services.** Next step: the long-section writer draws the crossing marks from the #1125 list, using `CrossingServiceRule` (installed, no caller). It reads "clearance not set, not checked" until Tim types a number. Tim number: yes, mm, default blank. Risk: low.
5. **UX-DES-01 "Not in markup".** Next step: CDDESIGN Show calls `NotInMarkupChecker` (installed, no caller) and lists the extras quietly. Tim number: none. Risk: low.
6. **UX-MGR-01-03 one-glance status.** Next step: Codex binds the Manager Status tab to `OneGlanceSummary`; it is computed today and shown nowhere. Switch `oneGlanceStatus` OFF. Tim number: none. Risk: low.
7. **DETENTION-PIT-ANNOTATE slice 3.** Next step: keep #1031, close #1036, then make the Pit Schedule and the OSD criteria block count the detention record. Tim number: none (approved 25 Sep). Risk: medium.
8. **C4 B6 Apply to drawing (UX-CALC-02).** Next step: the Detention tab's "Apply to drawing" runs the #1123 plan, then `OnSiteDetentionCriteriaService` in one transaction, preview first, one Undo. Codex window. Tim number: none. Risk: high (it unblocks the L3-DETENTION writer).
9. **C4 B7 Issue and B8 whole-set catchment review.** Next step: a Print tab "Issue..." window writes the #1042 record and fixes "unknown ARI becomes 10 years"; "Add from rating report" opens the #1121 review. Codex windows. Tim number: the engineer list from Settings, default blank. Risk: medium.
10. **UX-CR-09, UX-CR-08, I-WSUD-02.** Next step: CDCHECK adds the findings of #1046, #1048 and #1054, merged one after the other (both edit `CouncilProfileModels.cs`). Tim number: council values blank. Risk: low.
11. **REPAIR-DECIDE-LATER.** Next step: CDREPAIR's preview gets "Decide later" per finding, calling `RepairDecideLaterBook.Park` (#1035). Codex builds the tab. Tim number: none. Risk: low.
12. **UX-SPS-01 duty point.** Next step: a hidden CDPUMP that prints the duty point from typed flow, lift and main (#1058). Tim number: yes, where the SPS master detail lives, default "detail not set". Risk: low.
13. **UX-OLF-01/04, UX-CPLAN-11 clash, UX-SITE-02, UX-POOL-01.** Next step: CDCHECK lists the findings of #1137, #1140, #1180, #1185 and #1183, each saying "not checked" until its number is set. Tim number: freeboard, service clearance, saw-cut spacing and pool angle, all default blank. Risk: low.
14. **UX-CPLAN-33/34 outfall run.** Next step: run numbering calls `OutfallRunPlanner` (#1177), and lane 04's Pit Schedule half reads it. Tim number: none. Risk: low.
15. **UX-STDS-01 to 03 and Checks Explain / UX-CHK-02.** Next step: the issue preview lists off-standard items (#1186); Checks rows show the explanation (#1190); the issue step records the ticked checklist (#1309). STDS-03 is NOT BUILT. Tim number: none (builder numbers 3 jobs and 50 percent stay DRAFT). Risk: low.
16. **Manager reporting and pages (UX-MGR-05 to 13, M03 to M07).** Next step: CESUPPORT and the Report button call #1075; CEHEALTH calls #1195, #1197 and #1194; the update path writes the #1198 outcome. The pages are Codex's. Tim number: none. Risk: medium.
17. **BUG-478 the real update route.** NOT BUILT. Next step: an Opus design read, then Manager runs the existing activator when AutoCAD next closes. Tim number: yes, route, default (a). Risk: high (installer path).
18. **Civil speed.** Next step: AcadProbe before-and-after numbers with AutoCAD closed (free window), then one pit index per command end on top of #991. Tim number: none. Risk: medium.
19. **NOT BUILT, need a card or research first.** UX-REG Civil half (move build/02's #1074, #1083 and #1088 into Shared); council rulings 02, 03, 04, 06, 07, 10 and 16 sourced values (read-only research); UX-DWG-02 and UX-ARCH-01; UX-OVERNIGHT-01 slices 2 to 7; UX-LEARN-01 slice 5 (needs the corpus import); UX-SPS slice 2; BUG-061 evidence study. Risk: medium.

### 2.3 Lane 04, Civil drafting (windows are Codex's)

1. **CDTIDYLABELS is not installed.** Next step: get #837/#847 reviewed and into a train, then #1009 (pit labels in tidy) and #1017. `TidyLeaderOutRule` has no caller even on its branch: CDTIDYLABELS should call it when the clear-spot planner fails. Switches `linking.tidyMovesPitText` and `linking.tidyLeaderOut` OFF. Tim number: none (INT-074 Q6 and Q12 answered). Risk: low.
2. **CDCHECKS palette and progress line.** Next step: train #1034 (CDCHECKS command) and #1020 (progress wired into CDCHECK); `SlowWorkProgressRule` (#1003) is installed with no caller. The palette list is Codex's. Tim number: none. Risk: low.
3. **5.2 wrong-layer finding with Fix.** Next step: the CDCHECK result adds rows from the reader (#960 / #1022) through `WrongLayerRule` (installed, no caller), pre-ticked, one Undo. Codex owes the Fix button. Tim number: none. Risk: low.
4. **1.9 ROTATE and MIRROR keep CE text readable.** Next step: a command-ended hook for ROTATE and MIRROR calls `ReadableTextRule` (installed, no caller) on CE text. Switch `linking.keepTextReadableAfterRotateMirror` OFF. Tim number: none. Risk: high (REDO; needs a driver window).
5. **L3-LEVELS proposals page (INT-071 12c answered).** Next step: train #1059 (`Level3ProposalsFeed`) so `LevelsProposalEngine` (installed, no caller) feeds Project Review > Proposals; Codex builds the page. Tim number: none. Risk: medium.
6. **L3-SOURCES, L3-DETENTION and L3-NETWORK front door.** Next step: one hidden entry per proposal from the same Proposals page: CDPROPOSESOURCES calling `SourcesProposeFlow` (#751, #755, #821, #1065); the detention chooser (#1050 on #694); the network chooser (#754, #1067, #1181) after #682's CDLAYOUTGAPS. The choosers are Codex's. Tim number: PlaceMany Q1 (recommended "place the rest"), network options (recommended A fewest pits / B shortest pipe / C usual set-off). Risk: high.
7. **L3-DETENTION writer.** NOT BUILT (only the #756 plan half). Next step: after lane 03's C4 B6, Accept an option writes the CDWT tank, the storage pipes and the Apply preview as one Undo. Tim number: writer card Q1, recommended OSD block beside the orifice pit. Risk: high.
8. **C01/C02 sheet assembly (one card unblocks ten engines).** The legend #1141, notes #1143, LPD note, sheet rule #1153, C02 title #1155, packing #1158, charged pipes #1160, details needed #1163, existing grey #1151 and service labels #1148 have nothing to plug into. Next step: the design lane writes one card for a "Set up C01 and C02" command that places these on the existing layouts from the CE A1 template, preview then Apply, one Undo. Meanwhile three small hooks need no card: CDCHECK lists "used but not in legend" (#1141); CDSURVEY's confirm step calls `ExistingItemStyleRule` (#1151) and the service labels (#1148); CDLPD places the LPD note. Tim number: legend and notes source file, default the CE A1 template; charged linetype name, default blank. Risk: medium.
9. **5.4 existing and demolished status.** Next step: train #948 and #1027; Codex's Edit Pit status field calls `PitStatusDrawingService`. Tim number: none (INT-077 4). Risk: low.
10. **5.7 zone of influence and the footing plan.** Next step: a hidden command attaches the Structural footing plan as a read-only Xref (option a) and calls `FootingPlanReader` (#1061); CDCHECKS then calls `FootingInfluenceCheck` (#1038). Tim number: yes, the angle, default blank. Risk: medium (Xref protections rule).
11. **UX-MSG producers.** Next step: train #1053 so a CE command failure reaches the bell (the bell host is installed with no producer at all); the colleague-holds-the-drawing (.dwl read) and update-ready producers are NOT BUILT. Tim number: save-reminder minutes, default none. Risk: low.
12. **UX-PIPE-07 free end for the whole job.** Next step: Codex's "Keep as a free end" button writes `FreeEndLedger` (#1069, #1179) through lane 03's CDSETUP job record. Tim number: return distance 500 mm to confirm. Risk: medium.
13. **Transition names (INT-075).** Next step: train #1040 and #1101. The PR defaults `options.showAutoCadCommandNames` OFF, but the queue says ON: settle it (question 9 below). Overlaps lane 03's #1297. Risk: low.
14. **Area E (New Pit anchor, Edit Pit pending preview, Inspector Edit hand-off), 2.1 quiet re-check, 5.6 Ctrl+1, UX-UNDO-01.** NOT BUILT. Next step: a card for Area E and 5.6; 2.1 as a slice for lane 03's watcher; UX-UNDO-01 needs the tester probe of what AutoCAD's Undo list shows. Risk: medium.
15. **Run 2 item 17 (CDSTRIP corner inset 0, 25, 50 mm).** Do not build. It contradicts the pinned ruling CV4-5 (corner floor waste exactly on the centreline). The desk re-words the queue line; no Tim question is needed.

### 2.4 Codex windows (after the Codex reset, Thu 22 Oct 17:13), in the order that makes installed engines visible

1. **Install the Settings pages that already exist** (#1208, #1246, #1251, #1252, #1063, #1248, #1250), then add one row per new switch the trains above bring in.
2. **The Checks palette list** (CDCHECKS host #1034) with the Ignore and Fix buttons: lanes 03 and 04 items 2.2-2 and 2.3-2/3.
3. **The Level 3 Proposals page and the three choosers**: lane 04 items 5 and 6.
4. **Detention "Apply to drawing" preview, Issue window, whole-set catchment review**: lane 03 items 8 and 9.
5. **Manager Status tab one-glance, approval page, colleague view, report view**: lane 03 items 6 and 16.
6. **Structural markup QA list, bracing panel per-wall-line list, Sheets issue rows**: lane 02 items 2, 5 and 6.
7. **Drawing Repair "Decide later" tab, Edit Pit status field, "Keep as a free end" button, CE panel health line and the "Levels: ASSUMED" line.**
8. **The preview-then-Apply windows from the Codex bug triage** (BUG-615, 616, 625, 626, 630, 634, 636, 645).

---

## 3. Questions only Tim can answer (builders do not wait: each recommendation is built now as a DRAFT behind a switch, and his answer replaces it)

1. **Can Claude build the simple windows while Codex is out until 22 Oct?** Today only Codex builds windows (ruling B, 15 Sep). Settings page rows, the Checks list and the Proposals page are holding back about 40 installed or nearly installed features. Recommend: yes for Settings rows and plain lists, in Codex's style; Codex checks how they look after 22 Oct. On a job, this means you could switch on Tidy labels or the footing legend from Settings next week instead of the week after.
2. **Who switches a finished feature ON?** Today almost everything installed is OFF, so you see little change after each install. Recommend: once a feature passes a Codex check in AutoCAD and an Opus review, the desk turns it ON on your PC only. Colleagues get your exact setup later, and you can turn any feature off in Settings.
3. **C01 and C02 sheet set-up: one command or many?** CE can already work out the legend, note blocks, LPD note, tank callout and the C02 details list, but nothing places them on the sheets. Recommend: one "Set up C01 and C02" command that previews every block on your existing layouts from the CE A1 template and places them with one Undo. Example: on a new job you type it once and C01 gets the CIVIL WORKS LEGEND, the four note blocks and the council's block.
4. **Level 3 network options: what makes A, B and C different?** Recommend: A fewest pits, B shortest total pipe, C your usual set-off from the boundary. Each row shows pit count, total pipe length and deepest invert.
5. **Level 3 detention writer: where does the OSD criteria block go when you accept an option?** Recommend: beside the orifice pit, the way you place it by hand today.
6. **Proposed downpipes when a few fail: place the rest, or place none?** Recommend: place the rest and name the ones left out ("DP4 not placed: layer locked").
7. **Clearances, in one batch.** None is invented: each feature says "not set, not checked" until you type a number.
   1. **From a footing to a detention pipe or tank, in metres.** Example: with 0.6, a storage pipe 0.4 m from a footing is flagged.
   2. **From an existing service to a detention pipe or tank, in metres.**
   3. **Zone of influence angle, in degrees from the horizontal.** Example: at 45 degrees, a pipe 1 m below a footing is flagged within 1 m of it.
   4. **Minimum clearance to a crossing service on the long section, in mm.** Example: with 150, a sewer crossing at 120 mm turns red.
   5. **Pool zone-of-influence angle and slab saw-cut spacing.**
8. **Office minimum cover: 300 or 600 mm?** (Set C Q5, still open.) This changes which pipes CDCHECK flags as shallow.
9. **Show the AutoCAD command name beside the plain name?** For example "Tidy labels (CDTIDYLABELS)" on the ribbon and window titles. The queue said ON by default; the built PR has it OFF. Recommend ON while the office learns the new names.
10. **Colleague update route (BUG-478).** Recommend (a): Manager finishes the update the next time AutoCAD is closed, using the existing installer step. Nobody has to run a separate installer.
11. **Retaining wall sizes by height band and fence post footing sizes.** Recommend: build the layout now with every size reading "Unknown, engineer to fill" until you type the table in Settings.
12. **Where the pump station master detail lives, and the storage rule** (UX-SPS Q1, Q3). Recommend: "detail not set" for now; the duty-point working still runs.
13. **New job title block (UX-TITLEBLOCK-NEWJOB) and the Structural/Manager ribbon card (UX-RIBBON-04, questions 1, 3, 4, 5).** Both cards are waiting on your answers. Recommend you answer them in one sitting with the card open.
14. **Office learning: how many people before CE suggests something office-wide?** Recommend 3 (built as a DRAFT).
15. **Still open from earlier batches, not repeated here:** the 12 questions in `release-v3-colleagues-CODEX_BUG_TRIAGE_2026-10-16.md` section 4, Batch 6 Q1 and Q5, the markup same-place distance (15 mm recommended) and the WSUD runoff coefficient (0.85 or 0.9).

---

## 4. Corrections to stale claims in START_HERE.md (and related files)

1. **START_HERE state block item 7:** "Two Codex AutoCAD sessions (pids 12844 and 62380) are still open". Stale. The desk handoff (section 6, item 7) says 12844 closed normally and 62380 was stopped on 16 Oct (log `desk_jobs\acad_cleanup_2026-10-16.log`).
2. **START_HERE state block item 3 (usage):** it does not say that two Sonnet builders now run on the Max account (handoff addendum 8.3, Tim's word 16 Oct). The Max week resets Fri 23 Oct 13:00 with a 95 percent ceiling. "Max is the only budget until Sat 14:00" is still true.
3. **START_HERE section 4 command block:** it says `git pull` and `git add -A && git commit`. Both contradict the desk rule (handoff section 6, item 4): fetch, then `git merge --no-edit origin/main`, and add files by name, because the plan repo carries other chats' uncommitted edits. Replace the block.
4. **START_HERE state block item 4 (Codex campaign):** true as written, but the 762 checks ran on Civil 3.0.49 / Structural 1.0.116 (Codex handoff item 4). Nothing has yet been checked on the installed 3.0.50 / 1.0.117.
5. **"Built about 60 percent, Installed about 53 percent"** (triage file section 6, desk handoff 5.4): replace with section 1 above. Plan work named in a commit is 63 percent (310 of 492) and installed by name 47 percent (231 of 492). Nearly all of the 10 Oct queue work is uninstalled: 11 of the PRs numbered #1008 and up are installed. Most installed features are OFF with no Settings row to turn them on.
6. **START_HERE section 1b:** "Only Tim's word moves a row to Accepted". RULES 4.5 (amended 27 Sep) adds "Codex-accepted" for a Codex PASS in real AutoCAD on copies with screenshots; engineering-judgement items still need Tim.
7. **Build queue run 1 section 3 item 3** says CDTIDYLABELS (#837) exists. It is not installed: `TidyLabelsCommand.cs` is absent from `rel-20261010e`, and #837/#847 are open.
8. **Build queue run 1 section 3 item 24** says transition names default ON; the built PR #1040 defaults OFF (question 9).
9. **Build queue run 2 section 3 item 17** (CDSTRIP corner inset) contradicts ruling CV4-5 and must not be built (lane 04 already refused it, TEAMLANE4 run 82).
10. **Lane logs and the Civil helper** say "none of the 10 Oct PRs has had an Opus review". That is nearly right but not exactly: REVIEWLANE entries 976 to 977 reviewed about 46 of them (C-38 and S-38 lists), and those are still uninstalled too. About 182 remain unreviewed.
11. **`release-v3-colleagues-QUEUE.md`** has two entries numbered 267 (Mon 12 Oct and Fri 16 Oct). Renumber the second one 269 when the desk next writes there.
12. **Shipped privacy item:** `Modules/Manager/Services/CeAzurePublishService.cs` is still on the installed Civil/Manager line (BUG-556 fix #1169 is uninstalled). Colleague release gate item 11 should not be read as closed for Manager until #1169 installs.

---

## 5. What I did not check

1. Nothing was run in AutoCAD, and no window was looked at. "Wired" means a command path exists in code, not that it works.
2. About a quarter of the audit lines are "log only" (builder log, no grep). The worst case is that a few ENGINE ONLY items are really wired under another name.
3. The Codex-tested figure for the audited items (about 10) matches IDs by hand; the coverage index tags only 17 UX IDs, so some features Codex exercised under a bug ID may be missed.
4. Review verdicts were found by text search of `REVIEWLANE_LOG.md`; the "about 130 with MERGE verdicts" and "about 182 never reviewed" counts are approximate.
5. The 492-ID expansion of the UX plan is close to, but not the same script as, the old recount's 501-ID expansion.
6. No PR body was read; PR titles and branch ancestry only, plus the code on the two lines.
