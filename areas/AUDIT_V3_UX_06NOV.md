# V3 UX audit: ribbon, windows, prompts, messages, first start, help (written Thu 5 Nov 2026, Melbourne, for the 6 Nov audit set)

Read-only. I read the plan, the cards, the code in `C:\CE_WORK\scratch\audit_civil` (cf059dcf: Civil, Manager, shared) and `C:\CE_WORK\scratch\audit_struc` (8de95c34: Structural), and Tim's own settings file (values only). I built nothing, ran nothing, opened no AutoCAD. I cannot see windows. A window that exists in code is not a window that looks right.

**Tag key:** [C] = checked in code by me. [K] = carried from a CE_PLAN file, not re-checked. Status words are Tim's list: WORKS-INSTALLED, INSTALLED-BUT-OFF, ENGINE-ONLY, CANDIDATE-ONLY, NOT-BUILT, NEEDS-FIXING.

---

## FOR TIM (8 lines)

1. **Plain answer:** a new colleague meets a wall of buttons and no front door. There is no "start a job" button, and the three things that make drafting feel polished are switched OFF.
2. **Plan size:** 472 numbered UX items (the plan's 151 headline codes, ranges counted one by one). 244 of 472 have code in the build. 228 of 472 have no trace in the code.
3. **Of the 244 with code:** 137 are connected to a command, window or ribbon button; 107 are engine or settings only (no connection I could find). At least 39 sit behind a Settings switch that ships OFF.
4. **Cards:** 46 cards. 4 WORKS-INSTALLED (by code), 12 INSTALLED-BUT-OFF, 5 mixed, 5 ENGINE-ONLY, 11 NOT-BUILT, 9 not checked or not a product card.
5. **Ribbon for a Civil colleague:** 2 tabs (CE, CE Tools), 13 panels, about 60 buttons, plus 27 more hidden inside drop-downs. Structural adds a third tab with about 37 buttons and about 270 more in folders.
6. **Switched OFF on your own PC right now** (read from your settings file): join pipe ends automatically, AutoCAD-style prompts, join glow, pipe-size suggestions, and the CE bell. Colleagues start with these OFF too.
7. **CANDIDATE-ONLY:** none. The latest candidate (a6809594) has the same set of UX codes as this build; its 120 extra commits are bug fixes.
8. **Not proven:** nothing here is tested in AutoCAD by me. Also the "installed" Civil I read is cf059dcf (3.0.90 candidate b1), not 61fd6fbc (3.0.89) that CE_PLAN names as installed. 54 commits apart.

### The 10 worst experience gaps for a new colleague

1. **No front door.** There is no New job or Open job button anywhere on the ribbon. New job drawing (CDNEWDWG) is typed only; its registry note says "ribbon spot assumed, Tim to confirm" [C]. "Start Here" is a 2-minute picture tour of five tools, not a way to start a job.
2. **The Civil tab is a wall.** One tab, 9 panels, 49 buttons plus 27 inside drop-downs. Review alone has 10 buttons, three of which overlap (Checks, Check Current Drawing, Civil Hub) [C].
3. **The tab does not follow the drawing.** The plan says the middle panels switch for Civil or Structural drawings. Every panel carries a Civil/Structural tag, but nothing in the code reads the tag [C]. A Structural drawing still shows all Civil panels.
4. **Structural is the old 298-tool pile.** The "about 40 families" ribbon (UX-STRUC-02..05, 07) is built but OFF. By default a drafter gets about 37 buttons and about 30 folders holding roughly 270 more commands [C].
5. **The polish is OFF.** Auto-join of pipe ends, AutoCAD-style prompts, glow on the join target, pipe-size suggestions, windows reopening where you left them, labels staying where you put them, the CE bell, the one Checks list: all ship OFF [C]. The colleague starting file turns on only a few New Pipe values [C].
6. **First start is a pop-up, not a welcome.** On the first ever start the What's New window opens by itself, and the Start Here button is lit [C]. No welcome card (UX-FIRST-01), no splash (UX-START-01), no first-use tip card (UX-FIRST-02) are in the code. Structural prints "First run... Type CEADMIN SYSTEM INSTALL" on the command line [C].
7. **AutoCAD 2022 to 2024 colleagues get no ribbon at all.** They get the old pull-down menu. The Manager says so in its own code: the unified ribbon is skipped on net48 [C]. So UX-RIBBON-03 (retire the pull-down once the one tab works on 2022) cannot happen yet.
8. **When something fails there is no failure window.** UX-FAIL-01 exists only as a message type inside the bell, and the bell is OFF [C]. No "Send to admin" window. The Feedback tool saves a file; Help promises a send step that does not exist (BUG-1215).
9. **Help is behind the tools.** Wrong Help page for CDRAINFALL, CDDESIGN, CDCHECKS, CDRUNSOLVE (BUG-1216), no page for Label Styles or Move Arrow (BUG-1218), Reverse Flow Help promises a preview that does not exist (BUG-1220), Markup Help uses developer words (BUG-1078). No short clips (UX-HELP-06, 07).
10. **Software words are still on screen.** See section 3. Examples: "Running Xrecord cross-validation", "Install metadata not found... active DLL and asset paths", "snapshot(s) cleared", "Exception-first Excel to schedule", "Wrote ground_truth.json".

---

## 1. Answers to the new-colleague questions

### 1.1 What is the first thing they see

1. **Command line:** the CE load banner (Civil) and the Structural banner. Structural's banner prints a first-run line with typed commands and may list commands (option ShowFullStartupList) [C].
2. **A window:** What's New opens by itself, once, on the first ever start and after each update. It does so unless the switch "quiet first start" is on, and that switch is OFF in code and in your file [C]. It is not on the plan's list for a first start (the plan wants one welcome card, UX-FIRST-01, not built).
3. **The ribbon:** a lit Start Here button on the CE tab, first panel. It stays lit until the tour is opened once [C]. The tooltip says "Five things to know: Pipe, Pit, Edit, Checks and Help".
4. **Starting values:** a PC with no settings file gets the colleague starting values: New Pipe in "Custom, 1 in 100", dark theme, Class A grate lid, pipe-object upgrade On, remember New Pipe settings On. That file is still marked DRAFT waiting on QUESTIONS item 40 [C].
5. **Not there:** welcome card, splash, practice job in Help, first-use tip beyond the tip counter (tip service exists, UX-HELP-08), Switches page for the new on/off options (brief written 31 Oct, no tab in this build) [C].

### 1.2 What the ribbon shows (default settings, 2025 to 2027)

1. **Civil, tab "CE", 9 panels, 49 buttons [C]:** CE 5, Draw 6, Sources 5, Edit 5, Design 3, Review 10, Site 8, Import 2, Settings 5. Plus 27 inside drop-downs: Pit gallery 6, More sources 9, Slab 4, Joints 2, Tree zones 1, Import 5. Plus about 10 buttons on three pop-up tabs (Pipe, Pit, Source) that open when you select a CE object (jump on select is ON, in code and in your file).
2. **Manager, tab "CE Tools", 4 panels, 11 buttons [C]:** CE Manager, Version, CE Health, Support Bundle, Diagnostics, Open Logs, Updates and Rollback, Refresh, Admin, Move + Rotate, Copy + Rotate.
3. **Structural, tab "CE Structural", 7 panels [C]:** about 37 direct buttons (Beams 3, Columns and Footings 2, Rebar 2, Annotate 2, Schedules 2, about 22 Line styles, CE 4). The command list has 312 visible commands; the remainder sit in about 30 folders. The one-name-per-tool and beam-family options are OFF.
4. **So a Civil-only colleague sees:** 2 tabs, 13 panels, about 60 buttons, 27 more in drop-downs. With Structural installed: 3 tabs, 20 panels, about 97 buttons, about 270 more in folders.
5. **Order of tabs:** Civil 15, Structural 20, Tools last [C]. The plan wants a single CE tab; today the disciplines are separate tabs and none hide.

### 1.3 Is there one obvious place to start a job or a drawing

**No [C].** The nearest things, none of them a front door:
1. Start Here (tour only).
2. Design setup (CDDESIGN) in the Design panel: opens the job's design window and suggests From-markup or Design-from-scratch. It assumes you already have a drawing and a job.
3. New job drawing (CDNEWDWG): typed only, not on any tab.
4. Structural Sheets button: the nearest to a job-level tool for Structural.
5. The CE panel with job name, mode, recent jobs, health light, bell count and find box (UX-PANEL-01, UX-RECENT-01) is not in the code.

### 1.4 Messages that still use software words

Found by search of the text sent to the command line and message boxes [C]. Some are rare debug commands, but several are on everyday paths. (The 22 Oct wording audit found 68 more in Civil and Manager windows [K]; I did not re-check those.)

1. **Everyday Civil:** "CDAUDIT: Running Xrecord cross-validation" (LinkCommands.cs:427). "Wrote ground_truth.json / source_meta.json / entity_dump_ce_final.json" and "entity dump failed (non-fatal)" (ImportXcivil.cs:626, 668, 704, 708). "no valid entities selected", "Selected entity is not a valid pit block" (CdMoveCommands.cs:53, LinkCommands.cs:538). Plain AutoCAD word "entity" is borderline; it fails Tim's list.
2. **Everyday Structural:** the first-run line and "Install metadata not found... active DLL and asset paths" (Plugin.cs:188). "Exception-first Excel to schedule workflow with corpus-backed review" in the command list (Plugin.cs:230). "Unsupported entity combination" (BeamService.cs:754). "Failed to create driver entity" (FoundationScrewPileService.cs:85). "Selected entity is not linked" (FoundationService.cs:1143, 1206, 1486). "Recovery note: n incomplete command(s)... snapshot(s)" (Plugin.cs, DiagnosticsCommands.cs:89, 110).
3. **Debug commands that show handles and payloads:** BEAMLINKDEBUG ("BeamLinkData payload", "Beam handle on entity") and CE_INSPECT. They are developer tools, but they are in the shipped build.
4. **Carpark items on wording, all OPEN:** BUG-1074 (Manager warning shows original wording on hover), BUG-1078, BUG-1079 (Help names code classes), BUG-1175 (leftover wording points at Tim's own folders), BUG-1245 (MR and CR stop with a code word).
5. **A word-check that exists:** the plain-line rules (CommandLineText.Plain, AuditWording) are used on newer messages. Older paths were not swept.

### 1.5 Hiding ribbon buttons to leave a small core

**Short answer: there is no per-button hide in Civil or in CE_SHARED. Structural already has one in its command list. The natural place is the one loop that builds every tab.**

1. **Structural has a switch already [C]:** each command in `command-registry.json` carries `Hidden` (63 are hidden now) and `Expert` (11 more visible expert ones). The ribbon asks for the visible list. Setting the ribbon to leave out Expert commands, or adding a "core" flag, is a data change plus a Settings row.
2. **Civil has none [C]:** the buttons are written in code, panel by panel (CeCvlRibbonContributor.cs). The only switches are "Show the old CE tabs" and the one Checks list. Civil's own command list has 0 hidden flags in the ribbon sense.
3. **Panels carry a Civil/Structural tag nobody reads [C].** This is the same hook a "Core / Full" choice would use. It is the cheapest start.
4. **The common choke point is `RibbonBuilder.BuildTabPanels` (CE_SHARED) [C],** called by Manager's `CeUnifiedRibbonService.BuildUnifiedRibbon` for every tab. A hide list applied there would cover Civil, Structural and Tools at once.
5. **The catch:** CE_SHARED must ship byte-identical in Civil and Manager (memory note), so a change there is a coordinated release. The lower-risk route is a small filter in each contributor's `GetPanels` that reads one list from Settings (Settings-first rule), plus the Manager's strict JSON switch file (`manager-switches.json`, CeSwitchJsonReader) to carry an office-wide "core" list.
6. **Things a hide must respect:** typed commands keep working forever (UX-NAMES-01), so hiding a button never removes the tool. The ribbon is built once at start-up, so a change needs a restart. AutoCAD 2022 to 2024 has no ribbon, so a hide list would not reach those colleagues; their pull-down menu is a separate file (`ce_toolbar_layout.json`).
7. **How to pick the core:** the plan (UX-RIBBON-07) says choose from office use counts. A click log exists (CeRibbonClickLog) but BUG-853 says it grows forever and records drawing names, OPEN with a fix installed [C].
8. **Nothing like this is in the plan as a card.** UX-RIBBON-05..07 (icons, large buttons for about five daily tools, fixed layout from use counts) are not in the code [C].

---

## 2. The plan, told as the drafter's journey

Each line: plan item, status, tag. "(wired)" means I found a command, window or ribbon connection. "(code only)" means the code exists but I found no connection. "OFF" means the setting ships OFF.

### 2.1 First start and finding your way (plan sections 1.26, 1.32, 1.33, 1.39, 2)

1. **One CE tab, middle panels switch by discipline (2.1, UX-PANEL-02):** NOT-BUILT as described. Two tabs with separate disciplines; the panel tag is never read. NEEDS-FIXING for the discipline button tooltip, BUG-226 OPEN [C].
2. **Contextual tab jumps on select (UX-RIBBON-01):** WORKS-INSTALLED by code, ON [C]. Whether the jump feels right: unseen.
3. **Plain labels, typed command at the end of the tooltip (2.2):** WORKS-INSTALLED (wired); a Settings switch shows the command name after the plain name, ON during the transition [C].
4. **Toolbars kept, CE CVL pull-down retired once one tab works on 2022 (UX-RIBBON-03):** NOT-BUILT. Cannot be done until 2022 to 2024 gets a ribbon [C].
5. **Structural families, 40 tools (UX-STRUC-02..05, 07, 08):** INSTALLED-BUT-OFF [C].
6. **CESTRUC launcher retires (UX-STRUC-10):** NOT-BUILT [C].
7. **First run lit Start Here, 2-minute tour (UX-HELP-02, 03):** WORKS-INSTALLED by code [C]. Role question removed as ruled (UX-HELP-05).
8. **What's New once after an update (UX-HELP-04):** WORKS-INSTALLED (wired) [C]. It also opens on a first ever start. BUG-822 (opened by itself part-way through a session) is OPEN.
9. **F1 opens help for what you are doing (UX-HELP-04 text):** WORKS-INSTALLED (HelpLauncher) but NEEDS-FIXING for wrong pages, BUG-1216, 1218, 1219, 1220, 1217, 1215 (all OPEN).
10. **Learning help: short clips (UX-HELP-06, 07):** NOT-BUILT [C]. Tips on first three uses (UX-HELP-08): WORKS-INSTALLED (tip service, switchable). Faster-way suggestion once (UX-HELP-09): INSTALLED-BUT-OFF.
11. **Welcome card, first tip, practice job (UX-FIRST-01..03):** NOT-BUILT [C].
12. **Splash while AutoCAD loads (UX-START-01):** NOT-BUILT [C].
13. **CE panel: job, mode, recent jobs, health, bell, find box (UX-PANEL-01, UX-RECENT-01):** NOT-BUILT [C].
14. **Ribbon look: line icons, large buttons for about five tools, fixed layout (UX-RIBBON-05..07):** NOT-BUILT as designed. Icons exist (228 command icons) but the keytip-style two-letter codes are the only identity I can confirm [C].
15. **Comfort: scaling, symbols as well as colour, keyboard access (UX-ACC-01..03):** NOT-BUILT [C].
16. **Naming: CD, CS, CE prefixes, aliases (UX-NAMES-01..06):** NAMES-01 WORKS-INSTALLED; 02, 04 wired; 03, 05, 06 NOT-BUILT [C]. Alias editor dialog exists.

### 2.2 Open a job (plan 8.1, 4.1, 1.15)

1. **Job mode per job and discipline, switchable (UX-MODE-01..04):** MODE-01, 03 WORKS-INSTALLED (CDDESIGN, CDSETUP); MODE-02 code only; MODE-04 (late markup switch) NOT-BUILT [C]. Not shown on a CE panel because the panel is not built.
2. **Design opens on a known job, area colours, "During" (UX-DES-01..03, UX-STD-07):** WORKS-INSTALLED (wired) [C].
3. **One job record, title blocks in sync, New job drawing, learned file names, shared changes shown (UX-JOB-01..05):** wired in code [C]. The New job drawing command is typed only (see gap 1). NEEDS-FIXING for the missing ribbon spot (registry note).
4. **Job notes, hours, checklist (UX-TIME-01..04, UX-CHK-01..03, UX-NOTES-01):** TIME-01..04 and CHK-02 present (a timer toast window exists) [C]; CHK-01, 03 and NOTES-01 NOT-BUILT.
5. **Recent jobs, palettes and last sizes come back next day (UX-RECENT-01, UX-RESUME-01):** RESUME-01 WORKS-INSTALLED; RECENT-01 NOT-BUILT [C]. Windows reopen where left (UX-WIN-02): INSTALLED-BUT-OFF.
6. **Xrefs: background changes, broken paths (UX-XREF-01..03):** 01 and 03 wired; 02 NOT-BUILT [C].
7. **Other people's drawings: review offer, upgrade on open, clean linework (UX-DWG-01..03):** 01, 03 engine only; 02 NOT-BUILT [C].
8. **Mixed versions: V3 visible to colleagues without V3, 2027-only greyed, upgrade held (UX-MIX-01..03):** 01 and 03 wired; 02 NOT-BUILT [C]. Ties to BUG-1151 and BUG-1212 (OPEN: 2022 to 2024 moves leave pipe ends behind; CDWT loses pictures on 2022 to 2024).
9. **Drawing open by a colleague, read-only, Notify me (UX-SHARE-01):** ENGINE-ONLY (message kind only) [C].

### 2.3 Draw (plan 3, 1.1 to 1.4, 1.20, 1.21)

1. **Placing commands carry on until Enter or Escape; window every item (UX-STD-01, 01b):** WORKS-INSTALLED (wired) [C]; one flag tagged STD-01 ships OFF (single-pipe-object), so confirm which lane this is before calling it done.
2. **Preview is enough, no "Are you sure?" (UX-STD-02):** WORKS-INSTALLED [C]. **CE never saves for you (UX-STD-03):** WORKS-INSTALLED [C]. **Override reasons, fix-list defaults, selection (UX-STD-04, 05, 06, 08):** WORKS-INSTALLED [C].
3. **Auto-join within 75 mm, Keep separate, recent buttons, Escape at third point, Hide grade, one grade for several pipes (UX-PIPE-01..08):** 02, 04, 05, 06, 08 wired; 07 code only; 01, 03 untagged. **INSTALLED-BUT-OFF for auto-join (linking.autoJoinPipeEnds False in your file).** NEEDS-FIXING: BUG-1238 (recent diameters, materials and inverts not seen as one-click buttons), BUG-1233 (grade silently switches to "Set my own") OPEN.
4. **Command line like AutoCAD, size beside the cursor, glow, snap marker (UX-CMD-01..04):** 01, 04 INSTALLED-BUT-OFF (OFF in your file); 02 wired; 03 NOT-BUILT [C].
5. **Pits catch pipe ends, plastic pits keep label (UX-PIT-01, 02):** untagged; the pit tool and Edit Pit exist [C]. Status unconfirmed.
6. **Sources DP, CDRG, OF/FO, strip drain, trench grate (UX-SRC-01..05):** 03, 04, 05 wired; 01, 02 untagged [C].
7. **Labels: hand-placed stay, re-tidy, Tidy labels, only CE labels move (UX-LBL-01..04):** 01, 02 INSTALLED-BUT-OFF; 03 wired (Tidy labels button, command ON in code); 04 NOT-BUILT [C]. BUG-1161 OPEN (moved label forgets kept wording).
8. **Layers and colour (UX-LYR-01..04):** 02 engine only; 01, 03, 04 NOT-BUILT [C].
9. **Placement carry-down: Civil and Structural together (UX-XDISC-01..04):** 02 wired; 03, 04 engine; 01 NOT-BUILT [C].
10. **Tanks, site, slab, survey (UX-TANK, SITE, SLAB, SURV):** TANK-04, SITE-03, SURV-01, 03 wired; TANK-01..03, SITE-01, 02, 04, SLAB-01, SURV-02, 04 NOT-BUILT (CDPITDETENTION is absent in both this build and the candidate) [C].
11. **Pump stations (UX-SPS-01..04):** NOT-BUILT as one tool. Pump sizing code exists inside CDCALC [C].
12. **WSUD (UX-WSUD-01..04):** NOT-BUILT as the plan describes. WSUD calculation code is present (22 files) [C].
13. **Overland flow (UX-OLF-01..04):** NOT-BUILT [C].
14. **Retaining walls, pools (UX-RW-01..11, UX-POOL-01, 02):** RW-04 present as a setting only; the rest NOT-BUILT. The Civil import reads retaining-wall layers from the other consultant's file; that is not the plan item [C].
15. **Downpipes, trench drains, surface drains, paving (UX-DP, SURF, PAVE):** DP-01 engine, DP-03 wired, DP-02 NOT-BUILT; SURF-01..05 wired, SURF-06 NOT-BUILT; PAVE-01, 03 wired, PAVE-02 engine [C].
16. **Pit numbers, labels, notes on the sheet (UX-CPLAN-01..34):** 06, 07, 09, 14, 18 to 20, 28 to 30, 34 present; 01 to 05, 08, 10 to 13, 15 to 17, 21 to 27, 31 to 33 NOT-BUILT or untagged [C]. Outfall code exists in model files (plan says outfall drains are their own run).
17. **Surface levels from survey, interpolation (UX-RL-01..06):** 02, 03 engine; 01, 04, 05, 06 NOT-BUILT [C]. Long sections for site runs (UX-LSEC-01): INSTALLED-BUT-OFF.
18. **Lid class suggested (UX-LID-01):** wired [C].
19. **Details sheet C02 (UX-DET-07, 08, 09, UX-SHEETS-03, 04):** NOT-BUILT [C].

### 2.4 Edit (plan 1.16, 1.19, 1.23)

1. **Everyday AutoCAD edits: erase, copy, mirror, explode, one Undo (UX-EDIT-01..04):** 02 wired; 01, 04 engine; 03 INSTALLED-BUT-OFF (keep text readable after rotate or mirror) [C]. NEEDS-FIXING: BUG-1151 (2022 to 2024 move leaves pipe-object ends).
2. **Windows: Enter applies, Esc cancels, reopen where left, live preview, editors hold AutoCAD (UX-WIN-01..04):** 01 wired; 02 INSTALLED-BUT-OFF; 03 present (settings and helpers); 04 NOT-BUILT [C].
3. **Right-click CE group, Ctrl+1 values, failure reports to admin (UX-RCLICK-01, UX-PROP-01, UX-FAIL-02):** RCLICK-01 present (settings and start-up hook, engine side); PROP-01, FAIL-02 NOT-BUILT [C].
4. **Selection (UX-SEL-01 nothing selected: ask to pick, filtered):** NOT-BUILT [C]. NEEDS-FIXING: CDTAG with nothing selected (PR #209 built it on a draft [K]).
5. **Finding your way: find box, click a row to zoom, arrows walk the network (UX-NAV-01..05):** 01, 02, 04 wired; 03, 05 NOT-BUILT [C].
6. **Undo with plain names (UX-UNDO-01):** engine and settings [C].
7. **After ordinary AutoCAD edits CE re-checks quietly (UX-DI-01..04):** 03 wired; 01, 02, 04 engine [C].
8. **Edit group: the Edit and Inspector windows, Edit 2 pipes, workshops:** exist (about 46 Civil windows, 38 Structural) [C]. Looks: unseen.

### 2.5 Check (plan 1.8, 4, 5, 6.1)

1. **Quiet when OK, one green line (UX-STD-08):** WORKS-INSTALLED [C].
2. **One Checks list (decision H4):** INSTALLED-BUT-OFF. `checks.checksCommandEnabled` default OFF, so the ribbon still shows three overlapping check buttons [C]. NEEDS-FIXING: BUG-800 (says "Network OK" when a source failed), BUG-809, BUG-808 (OPEN, wording).
3. **The CE bell (UX-MSG-01..03):** INSTALLED-BUT-OFF. `messages.enabled` False in code and in your file [C].
4. **Calculations card (UX-CALC-01..04):** CALC-02 wired; 03 engine; 01, 04 NOT-BUILT [C]. NEEDS-FIXING: BUG-1033 (Pump System tab read-only with no banner), BUG-1103 (metres with no sense check), BUG-1268 (Excel export writes no file).
5. **Council tools (UX-CR-01..17):** NOT-BUILT as tagged; a council profile file and council checks exist [C]. Council RFI reader (UX-RFI-01..03): code only, no connection found.
6. **Pipe-size suggestions (UX-SIZE-01..03):** INSTALLED-BUT-OFF (`pipeSizeProposalsEnabled` False in your file) [C].
7. **Proposals, Level 3 (UX-L3-01..26):** L3-01, 03 to 06, 14 engine; 24 engine; the rest, including the side-by-side chooser (L3-19), NOT-BUILT. A preview dialog and a Project Review Proposals window exist [C].
8. **Project Review, one for both disciplines (UX-REV-01..05):** 01, 05 wired; 02 to 04 NOT-BUILT [C].
9. **Learning (UX-LEARN-01..04):** 01 wired; 03, 04 engine; 02 NOT-BUILT [C]. Nothing shows "why" on screen that I could find.
10. **Speed and progress (UX-PERF-01, 02):** 01 wired; 02 not tagged [C].

### 2.6 Issue and hand over (plan 6, 7.4)

1. **Issue, register, revisions, combined PDF, council pack, snapshots (UX-REG-01..15):** 04, 05, 09, 12 present; 05 and 12 INSTALLED-BUT-OFF; the rest NOT-BUILT [C]. UX-REG-06 (any engineer approves, named) NOT-BUILT.
2. **Standards at issue (UX-STDS-01..03):** NOT-BUILT [C].
3. **Pit Schedule matches printed schedule; Excel check sheet (UX-SCHED-02, 03):** 02 wired; 03 NOT-BUILT [C]. NEEDS-FIXING: BUG-1274 (plastic pits left out with no message), BUG-785, BUG-791 (OPEN).
4. **Import and repair (UX-IMP-01..04, UX-REP-01..03):** IMP-02 wired; REP-01 present only in tests; the rest NOT-BUILT, including "Decide later" [C].
5. **Layouts, viewports (UX-LAY-01..04):** 01, 02, 04 present; 03 NOT-BUILT [C].
6. **Approvals (plan 1.13):** REV-05, CALC-03 present; REG-06, STRUC-11 NOT-BUILT [C].

### 2.7 Structural journey (plan 7, roof down)

1. **Beams D1 and D2 (UX-D2-01..06, UX-BEAM-01..03):** 01, 02, 04, 05 present; 03, 06 NOT-BUILT; BEAM-01..03 present (failure wording) [C].
2. **Whole-plan proposal (UX-SL3-01, 02):** NOT-BUILT [C].
3. **QA against markup (UX-QA-01..08):** 04 to 08 engine; 01 to 03 NOT-BUILT [C]. Open design question: which drawing a loaded markup belongs to (10 Oct, Rec "per drawing, in memory"). Builders go on the Rec (INT-073), so it does not block [K].
4. **Detail library, sections, details sheets (UX-DET-01..05, UX-SEC-01..03):** SEC-01 present (offer next identifier OFF); the rest NOT-BUILT [C].
5. **General notes S01 (UX-NOTES-02..04, 10):** 02 wired; 03, 04 engine; 10 NOT-BUILT [C].
6. **Computations in CE (UX-SCALC-01..08):** 01 INSTALLED-BUT-OFF; 05 to 08 engine; 02 to 04 NOT-BUILT [C].
7. **Foundations, rafts, loads (UX-FDN-01..05, UX-RAFT-01..04, UX-LOAD-01..03, UX-STRUC-13):** FDN-01, 02, 04, RAFT-01..04, LOAD-03 wired; FDN-03, LOAD-01, 02 INSTALLED-BUT-OFF; FDN-05 NOT-BUILT [C].
8. **Framing plans (UX-FRM-01..15):** FRM-01, 04, 05, 11, 12 INSTALLED-BUT-OFF; 13, 15 OFF settings; 08 OFF; 14 wired; 02, 03, 06, 07, 09, 10 NOT-BUILT [C].
9. **Schedules and marks (UX-MARK-01, UX-SSCHED-01..13, UX-SCHED-04..06):** MARK-01, SSCHED-05, SCHED-04 wired; SSCHED-02, 03, 07, 10, 12 engine; SSCHED-01, 04, 06, 08, 09, 11, 13 NOT-BUILT [C].
10. **Plan notes, levels, symbols (UX-NOTES-07..09, UX-LEVEL-01, 02, UX-SYM-01..03):** 07, 08, LEVEL-01, SYM-01, 02 wired; NOTES-09, SYM-03 engine; LEVEL-02 INSTALLED-BUT-OFF [C].
11. **Basements, timber, load paths, soil, steel (UX-BSMT, SUB, LOADP, SOIL, STEEL):** all present; SUB-03, 04 OFF; SUB-02, SOIL-02, 04, BSMT-03 engine; the rest wired [C]. Steel catalogue picker has a window (SteelSectionPickerDialog) [C].
12. **Multi-unit jobs (UX-UNIT-01..04):** 01 to 03 wired; 04 engine [C].
13. **2022 colleagues get Structural, 2027-only greyed (UX-STRUC-12):** engine only [C].
14. **Architect's drawing (UX-ARCH-01..03):** 01 engine; 02, 03 NOT-BUILT [C].
15. **Ask CE (UX-AI-01..07):** the Ask CE button and palette command exist on both tabs [C]. UX-AI-05..07 (palette, chips, ASKCE) NOT-BUILT; AI-01..04 untagged, unconfirmed.

### 2.8 Manager and settings (plan 8)

1. **Manager one-glance status, quiet updates, rollback, one Report a problem (UX-MGR-01..10, UX-ADMIN-01):** MGR-01, 02, 03 wired; MGR-04, ADMIN-01 engine; MGR-05 to 13 NOT-BUILT [C]. NEEDS-FIXING for "run the CE installer" shown to colleagues who cannot (22 Oct audit, HIGH [K]).
2. **Settings: search, history, tags (UX-SET-01..09):** SET-07 search wired; SET-04 history wired; SET-01, 09 engine; SET-02, 03, 05, 06, 08 NOT-BUILT [C]. Switches page: NOT-BUILT in this build (brief 31 Oct) [C]. NEEDS-FIXING: BUG-839 (Manager Settings page can undo a change just saved).
3. **Settings-first (R-00) and "no hard blocks":** respected in the code I read; nothing hard-coded found on the paths checked [C].
4. **Voice and timing, units (UX-LIVE-01, UX-VOICE-01, UX-UNIT-04):** wired or engine; the voice rule is the one the 22 Oct audit measures; not every message follows it (section 1.4) [C].
5. **Themes:** dark and light themes exist. BUG-754 (Manager dark theme pale tab text) is OPEN with a fix installed [C].

---

## 3. The cards (46), one status each

1. **BATCH1 Day-1 plan labels:** INSTALLED-BUT-OFF (hand-placed labels stay and re-tidy both OFF) [C].
2. **BATCH2 checking the network:** INSTALLED-BUT-OFF (one Checks list OFF); network checks engine present [C].
3. **BATCH3 how every window feels:** mixed. Enter/Esc present; reopen-where-left OFF; editors-hold-AutoCAD and comfort items NOT-BUILT [C].
4. **BATCH4 first start and help:** mixed. Start Here, What's New, tips built; welcome card, clips, tooltip style NOT-BUILT [C].
5. **BATCH5 layers and around the object:** ENGINE-ONLY (right-click, layers engines; Ctrl+1 and splash NOT-BUILT) [C].
6. **BATCH6 surface levels and long sections:** ENGINE-ONLY; long section layout switch OFF [C].
7. **BATCH13 Structural roof-down framing:** INSTALLED-BUT-OFF [C].
8. **BATCH14 Structural schedules:** mixed (engine plus half the items NOT-BUILT) [C].
9. **BATCH15 markup QA:** ENGINE-ONLY [C].
10. **C4 calc size design:** mixed; sizing OFF [C].
11. **CARD UX-FRM-01 framing legend:** INSTALLED-BUT-OFF [C].
12. **CARD UX-FRM-04-06 lintel and support proposals:** INSTALLED-BUT-OFF (04); 06 NOT-BUILT [C].
13. **CARD UX-FRM-05 roof area setout:** INSTALLED-BUT-OFF [C].
14. **CARD UX-FRM-11 floor span arrow:** INSTALLED-BUT-OFF [C].
15. **CARD UX-LEVEL-02 over and under items:** INSTALLED-BUT-OFF [C].
16. **CD-BRANCH-01 branch and open ends:** WORKS-INSTALLED by code (CDBRANCH in 32 files) [C]; default not checked.
17. **CV-02A sizing:** INSTALLED-BUT-OFF [C].
18. **DESIGN_BUG-061, -246, -251, -351B, L3-DETENTION-WRITER, L3-NETWORK-SLICES-3-5-6:** not checked (engineering lane, other agents).
19. **DESIGN L3-PLACEMANY:** NOT-BUILT (0 hits in code or candidate) [C].
20. **DETENTION-PIT-ANNOTATE (CDPITDETENTION):** NOT-BUILT, also not in the candidate [C].
21. **FEDIT-OUTLINE-PICK:** code present, not checked further [C].
22. **I-WSUD-02 check against rating report:** NOT-BUILT [C].
23. **K-REQ-01 CDPROFILE plus schedule rows:** code present (1 file), not checked further [C].
24. **L3-DETENTION:** NOT-BUILT (the top-water-level tool is separate) [C].
25. **L3-LEVELS:** ENGINE-ONLY [C].
26. **L3-NETWORK:** NOT-BUILT [C]. **L3-SOURCES:** NOT-BUILT [C].
27. **REPAIR-DECIDE-LATER:** NOT-BUILT; no "Decide later" text in this build or the candidate [C].
28. **S4 foundations and walls:** mixed (foundations built; walls NOT-BUILT) [C].
29. **STRUC-ROOF-DOWN-PRODUCTION:** INSTALLED-BUT-OFF [C].
30. **UX-CR-08 pipe class from council, UX-CR-09 refused storage items:** NOT-BUILT [C].
31. **UX-DES-01 CDSETUP job mode:** WORKS-INSTALLED by code [C].
32. **UX-LEARN-01:** ENGINE-ONLY (ledger and learning folder; nothing shows a "why") [C].
33. **UX-MGR-01-03:** WORKS-INSTALLED by code [C].
34. **UX-MSG bell:** INSTALLED-BUT-OFF [C].
35. **UX-OVERNIGHT-01 routine:** a process card, not a product item; not assessed.
36. **UX-PIPE-01-03-07:** INSTALLED-BUT-OFF (auto-join OFF) [C].
37. **UX-RIBBON-01:** WORKS-INSTALLED by code [C].
38. **UX-RIBBON-04 Structural admin merge:** NOT-BUILT [C].
39. **UX-SPS-01-04 pump station:** NOT-BUILT [C].
40. **Reference items (not cards):** CIVIL_DRAWING_PRACTICE, DESIGN_PACK_QUESTIONS, PROPOSAL_CHOOSER_SKETCH (side-by-side chooser NOT-BUILT), STRUC-ROOF-DOWN controller review, REVIEW_BATCHES.

**Tally of the 46:** WORKS-INSTALLED 4 (16, 31, 33, 37); INSTALLED-BUT-OFF 12 (1, 2, 7, 11, 12, 13, 14, 15, 17, 29, 34, 36); mixed 5 (3, 4, 8, 10, 28); ENGINE-ONLY 5 (5, 6, 9, 25, 32); NOT-BUILT 11 (19, 20, 22, 24, 26 twice, 27, 30 twice, 38, 39); not checked or not a product card 9 (18 six, 21, 23, 35).

**Open questions that block a card:** none block building (INT-073: builders go on the recommended answer). I did not check which of the 8 to 10 Oct questions were answered on 29 Oct.

---

## 4. Candidate and install notes

1. **Installed versus this audit:** the audit tree is cf059dcf (Civil 3.0.90, candidate b1). CE_PLAN's 5 Nov count names 61fd6fbc (3.0.89) as installed. 61fd6fbc is an ancestor of cf059dcf; 54 commits apart. The brief called cf059dcf installed. One of the two is wrong, and I read no installed DLL.
2. **Latest candidate a6809594 versus cf059dcf:** 120 commits, same set of UX codes in Civil and Manager source. So CANDIDATE-ONLY is zero for this plan. The candidate adds 431 lines to the Civil settings file (new switches and fix settings).
3. **Structural:** audit_struc is 8de95c34; CE_PLAN desk notes name Structural 1.0.126 installed. Not reconciled.
4. **Your own settings file** (read for values only) matches the code defaults for the switches above. It differs from the colleague starting file on "remember New Pipe settings" (yours False, colleagues True). Not necessarily a fault.

---

## 5. What I did not check

1. **Anything in a real window.** No screen, no AutoCAD, no layout, colour, spacing, scrolling, tab fit, scaling, or keyboard order. The cockpit test, emphasis rule and no-scroll rule can only be judged by looking.
2. **Whether a wired item works.** "Wired" means a command, window or ribbon button reaches the code, not that it does the right thing. No test was run.
3. **Defaults on colleagues' PCs.** I read the code defaults, the shipped colleague file and your settings file only. Any manager switch file or admin policy on a colleague PC could change this.
4. **The 228 items with no code tag.** Some are built without the tag (council profile checks, pump sizing, WSUD calculations, outfall model, Ask CE). I spot-checked families, not every line. Treat "NOT-BUILT" on those as "no sign in code", not proof.
5. **The 107 engine or settings-only items.** My wiring test was a folder search (Commands, Dialogs, UI, Controls, Windows, ViewModels, command list). A feature wired through a Service or the ribbon contributor can be missed.
6. **Tooltips against Autodesk style, icon quality, help page content.** Not read page by page. Help wrong-page bugs come from the carpark.
7. **The 17 TIM question files and the reference documents.** Skipped as instructed, except the two I opened.
8. **Structural windows and the second discipline in one install.** I counted its ribbon from code; I did not trace the Structural-only flows end to end.
9. **Engineering items.** Left to the Civil and Structural audits.
10. **The 22 Oct wording audit's 68 findings.** Carried, not re-checked.
