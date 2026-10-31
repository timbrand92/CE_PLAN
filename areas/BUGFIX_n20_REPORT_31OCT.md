# Job n20 report: two draft card batches, no code (Sat 31 Oct 2026)

## FOR TIM

**Answer first:** five draft cards are written and waiting for your yes. No PR, nothing built, nothing installed. Index: C:\CE_PLAN\areas\cards\INDEX_DRAFT_CARDS_BATCH6_31OCT.md.

1. **Mistakes of my own:** none that cost a run or a test. I started no AutoCAD and ran no build or test.
2. **CEMEMBER, four cards (your "yes to all four").** All four faults are still there on the installed Structural 1.0.125. I read them in the code; nobody has seen them in AutoCAD.
   1. **UCS (BUG-909):** a section always stands square to World, and every line drops to height 0. Rotate the UCS 30 degrees and a 310UB section comes out tilted 30 degrees on screen.
   2. **Layouts (BUG-910):** on a layout sheet at DIMSCALE 50 the break kink is 100 mm on the sheet instead of 2 mm.
   3. **Unequal angle (BUG-1124):** a 150x90x10 UA always stands on the 150 leg. CE will ask "Upright leg [Long/Short] <Long>".
   4. **RHS flat (BUG-1125):** a 150x50 RHS always stands 150 high. CE will ask "RHS sits [Standing/Flat] <Standing>". **GUESS on the card:** you are happy to drop your earlier "one orientation" rule for RHS. Please confirm.
3. **Downloads card: two things were not as the bug entries said.**
   1. **WebView2 (BUG-554):** the installer has not downloaded WebView2 since 22 Jul. That code is switched off and never built. The 9 Oct check read switched-off code by mistake. So the card recommends no download at all: check WebView2 is there, and if not, warn, record it and carry on.
   2. **CEMARKUPRUN (BUG-553):** the download has been OFF by default on new PCs since 9 Oct, and that is installed. What is left: a PC that saved "ON" before then keeps it, and when it is ON the download happens without a word.
   3. **The installer's first-install route and repair (BUG-883 and BUG-888)** are marked after the pilot, as you ruled. The pilot is a hand install.
4. **What you need to answer (about 19 short questions, each with my recommendation):** all are in the index file. The three that matter most:
   1. RHS: drop "one orientation"? (I recommend yes.)
   2. WebView2: check and warn only, or bundle Microsoft's signed installer? (I recommend check and warn only.)
   3. Is Structural in Max's pilot? If not, the CEMARKUPRUN part waits until after the pilot.
5. **Not proven:** none of this has been looked at in AutoCAD. The "top of member flips in a 90 degree UCS" point is my reading of the code only.

---

## Technical detail

### Files written (C:\CE_PLAN, pushed by name)
1. areas/cards/CARD_CEMEMBER_UCS_BUG909_DRAFT_31OCT.md
2. areas/cards/CARD_CEMEMBER_LAYOUT_BREAKS_BUG910_DRAFT_31OCT.md
3. areas/cards/CARD_CEMEMBER_UA_LEG_BUG1124_DRAFT_31OCT.md
4. areas/cards/CARD_CEMEMBER_RHS_FLAT_BUG1125_DRAFT_31OCT.md
5. areas/cards/CARD_INSTALLER_DOWNLOADS_BUG553_554_DRAFT_31OCT.md
6. areas/cards/INDEX_DRAFT_CARDS_BATCH6_31OCT.md
7. this report

### Code read (read only, via git show; no worktree created)
1. Structural origin/claude/rel-20261026s, head 204dfad2 (Structural 1.0.125).
2. Civil/Manager origin/claude/rel-20261102a, head 3fbb9da5 (Civil 3.0.88 / Manager 1.1.88).

### Fault still present? (the "confirm first" rule)
1. **BUG-909: present.** Modules/Structural/Commands/CeMemberCommands.cs: the elevation picks are turned to World and only X and Y are passed on (`new CePoint(firstWorld.X, firstWorld.Y)`, line 138); the section pick likewise (line 209). CeMemberPlacement.PlanElevation orders "west to east" by World X (`point2.X < point1.X`), and CeMemberSection draws in World axes with quarter turns only.
2. **BUG-910: present.** CeMemberCommands.cs reads DIMSCALE with no paper-space test (line 106) and the break line multiplies BreakOvershootPaperMm and BreakKinkPaperMm by it (CeMemberEngine.cs, the break-line Build method, lines 217 to 220). The paper rule already exists for CE text: Modules/Structural/Core/Units/PaperSpaceSizeRule.cs (ScaleFor) with Services/CurrentSpaceReader.IsPaperSpace. LBUH and LBH not traced.
3. **BUG-1124: present.** Structural.DesignCore/SteelSections/CeMemberCatalogue.cs case "UA": `CeMemberDims.Angle(row.DepthMm, row.WidthMm, ...)`; Depth is the upright leg; section-catalogue.json holds 150x90x10UA as depth 150, width 90.
4. **BUG-1125: present.** CeMemberElevation.cs `CeMemberDims.Rhs` "depth standing vertical"; CeMemberCatalogue.NeedsOrientation excludes RHS.
5. **BUG-554: the WebView2 download is NOT in the compiled installer.** Installer/Program.cs lines 21 to 619 are inside `#if false` on both branches; it was added by 3089c3bb (22 Jul 2026, "feat(release): bind staged safe installer", RS-01B2) and was already there at e636e17d, the commit the 9 Oct audit read. The scheduled-task code (EnsureUpdateTask) is in the same block. Main now calls CeInstallerApplication.Run; grep of CeInstallerApplication.cs, SafeBundleInstaller.cs, ReleaseAuthorityPackaging.cs and the two .ps1 files found no HttpClient, URL, schtasks or WebView2. Not ALREADY FIXED in the usual sense: the code is dead but still in the file, and no WebView2 presence check exists.
6. **BUG-553: default fixed, remainder open.** b5dafba6 (9 Oct 2026, #949) set `MarkupAI.AutoBootstrapPyAutocadWorker = false` (Modules/Structural/Models/MarkupAIModels.cs line 238) with the comment "a PC that already stored a value keeps it"; MarkupAIPyAutocadWorkerService.TryEnsurePythonReady (about lines 340 to 377) stops with WorkerPackagesMissing when OFF; when ON it runs `python -m pip install` with a 300 s limit, says nothing first and logs nothing on success.
7. **Side finding:** the CEMEMBER entry in Modules/Structural/Assets/Config/command-registry.json (longDesc and notes) still says the section view is not built; the code has it. Stale help text, not filed (do not edit carpark from this job).

### Proposed robot cases (all need the build first; none exists)
1. S909_cemember_ucs: UCS Z 30, CEMEMBER, SEction, 310UB32, Front, Centre, pick 1000,1000; checks the outline's longest edge angle is 30 or 120 degrees; switch OFF control gives 0 or 90. S909_cemember_height: UCS origin 0,0,3000; every line at Z 3000.
2. S910_cemember_layout_break: Layout1 paper space, DIMSCALE 50, side elevation 310UB32 Both; break kink height 2.0; switch OFF control 100.
3. S1124_cemember_ua_short: 150x90x10UA, LeftBottom, Short, side elevation; outline height 90; switch OFF control 150.
4. S1125_cemember_rhs_flat: 200x100x6RHS, Flat, side elevation; outline height 100; switch OFF control 200.
5. Card B: no robot case (cannot remove WebView2 or Python helpers on Tim's PC); guard tests plus an install rehearsal on a spare login.

### What is NOT proven
1. Nothing seen in AutoCAD. All "what happens today" lines come from reading code.
2. The UCS 90 degree top/bottom flip (card A1, section 2 item 3) is inferred.
3. The PDF markup message without WebView2 is inferred from the catch block in MarkupPdfImageRenderer.cs.
4. Whether any real PC still has the CEMARKUPRUN download stored ON: not checked (I did not open settings contents).

### Real-files listing (names, sizes, last-write only; no contents)
No dotnet build or test was run, so no test could write anything. An AutoCAD session (process started 23:41, not mine; I started none) was running during the job; it rewrote the three CE_Admin session files and the Structural runtime snapshot between the two listings. No settings file changed: CS_Settings.json (both), CD_Settings.json, CD_RecentValues.json and CE_CVL_SUITE settings.json have the same time and size in both listings.

Before (23:46):
```
TIM_CE_CADTOOLS: CS_Settings.json 2026-03-31 13:18 351713 | CD_Settings.json 2026-10-31 23:41 15357 | CD_RecentValues.json 2026-10-31 23:38 12220 | CE_Admin/sessions/CE_CVL_SUITE.json 23:41 233 | CE_Admin/sessions/CE_STRUC_SUITE.json 23:41 235 | CE_Admin/manager-menu-state.json 2026-04-28 204 | label_styles.json 2026-04-28 526 | parts_catalogue.json 2026-09-15 5910
CE_STRUC_SUITE: CS_Settings.json 2026-10-30 19:54 35613 | logs/RuntimeDiagnostics/runtime_snapshot.json 2026-10-31 23:42 885 | Caches and projects files unchanged dates (latest 2026-10-14)
CE_CVL_SUITE: settings.json 2026-09-16 12:13 672 | feedback and spine-rollback files (latest 2026-09-14)
CE_CADTOOLS: CE_Admin/manager-menu-state.json 2026-10-31 23:42 224 | CE_Admin/sessions/CE_SUITE_MANAGER.json 23:45 228
CE_SUITE: no files
```
After (23:50):
```
TIM_CE_CADTOOLS: same as before except CE_Admin/sessions/CE_CVL_SUITE.json 23:49 232 and CE_STRUC_SUITE.json 23:49 234
CE_STRUC_SUITE: same except logs/RuntimeDiagnostics/runtime_snapshot.json 23:49 885
CE_CVL_SUITE: same
CE_CADTOOLS: same except CE_Admin/sessions/CE_SUITE_MANAGER.json 23:49 261
CE_SUITE: no files
```

### Clean-up
No worktree was created (code read with git show). Scratch C:\CE_WORK\scratch\n20 removed at the end. Carpark and DESK_LOG not edited.

### Summary
No PR (planning job). Five DRAFT FOR TIM cards plus index under C:\CE_PLAN\areas\cards: CEMEMBER UCS (BUG-909), layout break marks (BUG-910), UA leg (BUG-1124), RHS flat (BUG-1125), and installer/CEMARKUPRUN downloads (BUG-553/554). Proposed switches, all shipped ON: "CEMEMBER draws in the current UCS", "break lines at paper size on layouts", "asks which UA leg stands upright", "asks how an RHS sits", "say and record before downloading Python helpers". Key finding: the WebView2 download has been switched-off code since 22 Jul; BUG-553's default-OFF is already installed.
