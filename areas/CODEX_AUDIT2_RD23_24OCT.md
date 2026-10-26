**ANSWER FIRST — RD23: first run and colleague install**

1. **Counts: HIGH 0 / MEDIUM 2 / LOW 1.** Three NEW findings, all **SURE — verified-by-reading** under the stated conditions. No AutoCAD reproduction is claimed. Audit performed 26 October 2026, Melbourne; the requested 24OCT filename is retained.

2. **Most important — RD23-01, MEDIUM:** one missing Structural palette file prevents **all CE Blocks** from opening. A colleague whose Civil block files have finished syncing cannot use them while an unrelated file, such as TIMBER.xtp, is absent. This affects the Civil + Manager handover on 9 November.

3. **Second — RD23-02, MEDIUM:** Structural's **Set up project** searches only Tim's personal template paths. A colleague can have the right office templates in their own profile and still get an empty list and a disabled Create button.

4. **Third — RD23-03, LOW:** Structural's **Steel Sections** reference list reads an old external text file that is not supplied by the inspected packaging rules. On a clean PC the list is empty, although the separate packaged catalogue is available to SBEAM.

5. **Release scope:** findings 02 and 03 concern the separately requested Structural audit, not additional requirements for the Civil + Manager delivery. Manager administrator development remains parked. The tests below are for the later test lane; none needs Tim to test it personally.

---

1. **Source and method.** Fetched the plugin origin and inspected Git objects from the audit-owned detached worktree `C:\ce-cx\rd23`. Civil + Manager: `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4`, source versions 3.0.72 / 1.1.72. Structural: `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9`, source version 1.0.122. Structural was read explicitly from that ref, not from the older Structural files in the Civil checkout. Line numbers below refer to those pinned versions. This does not identify what is installed today.

2. **Prior records and exclusions.** Read RULES, ROUTER, START_HERE, MASTER_PLAN, `AUDIT_C58_C60_S40_S41_2026-10-22.md`, the Civil, Gate and Structural `CODEX_AUDIT_*_22OCT.md` reports, and the directly relevant T5 colleague-install audit. Searched `BUG_CARPARK.md` before inspecting code and again against each candidate; its next-number banner was BUG-1221. No new bug numbers were allocated.

3. **Evidence rule.** SURE means the production call chain deterministically produces the described result with the stated files present or absent. It does not mean a window was observed. No suspected-only item is counted. All DETERMINISTIC TEST sections are **NOT RUN**. Fixtures are synthetic and belong in a disposable colleague profile, never Tim's settings or office masters.

**Numbered findings — ranked**

1. **RD23-01 — MEDIUM — SURE, verified-by-reading: one unavailable palette file removes every usable block group.**

   **File:line:** `Modules/Manager/Services/CeBlocksCatalog.cs:40`, `:47`, `:50`, `:52`, `:94`; `Modules/Manager/Services/CeBlocksPaletteService.cs:24`, `:27`, `:28`, `:33`; command entry `Modules/Manager/Commands/PluginManagerCommands.cs:16`. All at the Civil + Manager pin.

   **What the drafter sees:** typing `CEBLOCKS` gives a command-line error and no palette. The Civil blocks that are already available cannot be selected. A missing Timber export can therefore interrupt a drainage drafter who does not use Structural.

   **Exact failure scenario:** the correct palette folder exists and eleven of the twelve required exports are readable, but `TIMBER.xtp` has not arrived, or is unreadable during sync. `Read` unconditionally loads every name in its fixed list. The exception escapes before it can return the groups already read. `Show` catches that exception, prints `CE Blocks palette files are unavailable: ` plus the error, and returns before constructing or showing the palette. Discipline selection happens only afterwards, so Civil-only use does not avoid the dependency. A damaged single export has the same effect. This is a failure to retain healthy groups when one file fails; changing folder detection alone cannot fix it.

   **Smallest fix:** catch and record file-level failures inside the catalogue loop, return the readable groups, and display one plain warning naming the unavailable groups. Keep those groups unavailable and retry them on reopening; do not invent their contents or block unrelated Civil groups. This follows R-27's warn-and-carry-on rule.

   **DETERMINISTIC TEST — fixture:** in an isolated Windows profile with Manager 1.1.72, no `ce-blocks-settings.xml`, and a blank millimetre DWG, populate the default `Tool Palettes\NEW` folder under that profile's office Drafting root with twelve synthetic exports named `BLOCKS CIVIL`, `BLOCK CIVIL 2`, `FRAMING`, `GROUND`, `HATCHES`, `LABELS CIVIL`, `NOTES`, `SCHED`, `STEEL`, `TEXT`, `TIMBER`, `WALLS`, each ending `.xtp`. Each has one `PaletteContent/Palette`, its `Properties/ItemName`, and a `Tools` element. In BLOCKS CIVIL include one kind-1 tool with unique ItemID, ItemName `AUDIT-PIT`, BlockName `AUDIT-PIT`, and SourceFile pointing to a synthetic readable DWG containing that block. The other groups may have empty Tools. Use no ToolOrder element, so the reader takes the tool dictionary order. The default office block drawing may also be a synthetic file.

   **Typed steps and assertion:** first type `CEBLOCKS` with all twelve exports present and confirm the Civil group contains `AUDIT-PIT`; close the palette. In a fresh AutoCAD session using an otherwise identical fixture, omit only TIMBER.xtp and type `CEBLOCKS`. Require the CE Blocks window and `AUDIT-PIT` to remain available, with a warning naming Timber. Current code predicts no palette and the command-line prefix `CE Blocks palette files are unavailable: ` with TIMBER.xtp in the error. Restore that one fixture file and repeat in a fresh session: the palette must open again. A reader-level regression must assert eleven returned groups plus one diagnostic, rather than only asserting an exception. The existing `CeBlocksCatalogTests.cs:23` reads the complete local office folder; that happy-path fixture does not exercise this failure.

2. **RD23-02 — MEDIUM — SURE, verified-by-reading: sheet setup is tied to Tim's template paths even with fresh settings.**

   **File:line:** `Modules/Structural/Services/CeProjectSetupProfileService.cs:21`, `:22`, `:33`, `:45`; `Services/CeProjectSetupService.cs:13`, `:16`; `UI/Dialogs/CeProjectSetupDialog.xaml.cs:24`, `:47`, `:49`; `UI/Dialogs/CeSheetsManagerWindow.xaml.cs:419`, `:430`. All at the Structural pin.

   **What the drafter sees:** in the classic Sheets window, **Set up project** opens with no drawing templates and says `No drawing templates were found. Check that the office template files are available.` Create remains disabled. Re-syncing the colleague's own templates cannot repair the coded lookup.

   **Exact failure scenario:** a clean colleague profile has no folder for Tim's Windows account. The colleague's office templates are present under their own normal Drafting folder, including `A1 Templates\CE_A1_S01 - VERTICAL.dwg` and `1CE_TITLE BLOCK VERTICAL.dwg`. Every built-in setup profile instead holds an absolute path under Tim's profile. `GetAvailableProfiles` filters exclusively by `File.Exists` on those paths; it does not substitute the current user, read an office template-root setting, or use `CeInstallPaths`. Therefore it returns zero profiles. This happens without copying any settings from Tim.

   **Reachable route:** `Commands/SheetsCommands.cs:39` exposes `CESHEETSCLASSIC`; `UI/Palette/PaletteManager.cs` forwards OpenSheetsManager to `MainPalette.xaml.cs:454`; `SheetsPanel.xaml.cs:91` constructs `CeSheetsManagerWindow`. Its XAML line 40 wires **Set up project** to the failing route. This is not an unused template helper, and the ordinary `CESHEETS` window is not the test doorway.

   **Smallest fix:** retain the profile names and relative template filenames, but resolve both TemplatePath and SharedTitleXrefTemplatePath from the current user's office template root, with an explicit Settings override. A missing template should be named at the resolved location; do not ask a colleague to create Tim's profile directory.

   **DETERMINISTIC TEST — fixture:** disposable colleague Windows account, Structural 1.0.122, no prior CE settings or Tim-profile directories. Create synthetic valid DWGs with the two filenames above under the colleague's own office `Drawings Templates\A1 Templates`. Use a separate empty local job folder `C:\CE-Audit-Fixtures\RD23-02`. No client information is needed.

   **Typed steps and assertion:** open a blank metric drawing; type `CESHEETSCLASSIC`; in CE Sheets Manager use **Browse...** to select the synthetic job folder, then click **Set up project**. Assert the template list offers **A1 Structural Title Sheet - Vertical** and Create is enabled when that profile is selected. Current code predicts an empty list, disabled Create and the exact missing-templates sentence above. Do not press Create: the availability assertion fully exposes this fault without producing sheets. A reader-level regression should resolve the same relative profile under two distinct synthetic user roots and assert that each uses its own two template paths.

3. **RD23-03 — LOW — SURE, verified-by-reading: the Structural steel reference list needs an unshipped legacy file.**

   **File:line:** `Modules/Structural/Services/CeInstallPaths.cs:10`, `:24`; `Services/InstallMetadataService.cs:71`, `:75`; `Services/StandardsService.cs:118`, `:132`, `:255`, `:259`; `UI/LayerManagerWindow.xaml.cs:38`; `UI/LayerManagerWindow.xaml:196`. All at the Structural pin.

   **What the drafter sees:** `CEADS`, **Structural Defaults**, shows concrete grades and bar sizes but an empty **Steel Sections** grid. Closing and reopening the window does not help. This is the reference list only; it does not establish a failure of SBEAM placement or a wrong engineering number.

   **Exact failure scenario:** no Structural settings, install metadata or legacy `C:\Lisp Files` library on the colleague PC. The default reader requests `C:\Lisp Files\CE_StrucPlus\data\aus_steel_sections.txt`. Missing file returns an empty list without a diagnostic, and a static Lazy retains it for the AutoCAD process. The UI binds that empty UB list directly. No tracked `aus_steel_sections.txt` exists at the audited ref, and the inspected Structural project packaging does not supply it. The startup asset copier deploys only DWGs and DCL files, not this text catalogue.

   **Available alternative:** `Services/SectionDatabaseService.cs:155` reads the separate packaged `Assets\Config\section-catalogue.json`; `CE_STRUC_SUITE.csproj:257` copies that Config folder. That catalogue is already used by SBEAM. The reference window never calls it. A settings-path change after the first empty read would also remain ineffective until the static cache is refreshed or AutoCAD restarts.

   **Smallest fix:** populate the reference grid from the existing packaged section catalogue, adapting designation, family and mass fields; preserve unknown mass as unknown. Avoid maintaining another per-PC catalogue. If an office override remains supported, make its location visible in Settings and invalidate the reference cache when it changes. An actually unavailable catalogue needs a plain message instead of an unexplained empty grid.

   **DETERMINISTIC TEST — fixture:** disposable profile, Structural 1.0.122, no install metadata or legacy steel text file, packaged section-catalogue.json present. Use a blank millimetre drawing. First note one UB designation and its recorded mass from the supplied JSON; use that entry as the comparison, without inventing a section property.

   **Typed steps and assertion:** type `CEADS`, click **Structural Defaults**, read **Steel Sections**. Require at least one UB row and matching designation/mass for a packaged UB included in the displayed subset. Current code predicts zero rows, while **Concrete Grades** and **Rebar Sizes** remain populated. Close; type `SBEAM`, choose UB, and confirm the packaged UB list is available, then Cancel. Repeat CEADS: its list remains empty on the current code. The SBEAM control distinguishes a missing legacy dependency from a damaged whole installation. After repair, compare the reference rows directly with the same packaged source; no placed member is required.

**Known findings excluded — identifiers only**

1. **BUG-493; BUG-825; BUG-827; BUG-831; BUG-842.**
2. **BUG-882; BUG-883; BUG-884; BUG-885; BUG-887; BUG-888.**
3. **BUG-1165; BUG-1166; BUG-1167; BUG-1168; BUG-1171; BUG-1173; BUG-1174; BUG-1175; BUG-1176; BUG-1177; BUG-1178; BUG-1202; BUG-1212.**

**What I did NOT check**

1. **No execution:** no build, tests, AutoCAD, installer, deployment, screenshots or sub-agents. No findings were marked fixed or accepted. Proposed fixtures were not created.
2. **No live-PC certification:** no inspection of today's loaded DLLs, Tim's settings, the colleague's PC, corporate permissions, OneDrive availability, installed fonts, actual support-file contents or frozen delivery bytes. Source packaging is not a hash check of the delivered bundle.
3. **No binary drawing inspection:** the Git asset inventory establishes which block files are tracked, not whether their internal text styles or font dependencies are portable. No missing-font defect is asserted. A personal fallback path alone was not counted where shipped alternatives exist.
4. **No wider scope:** no Manager administrator work, broad engineering review, new standard values, source edits or bug-register edits. Only this findings file is authored and committed in CE_PLAN. The audit-owned detached worktree is removed at completion; other working copies and unrelated pending files are left alone.

**Summary — under 100 words**

1. **Three new faults:** a missing palette export hides all usable CE Blocks; Structural sheet setup only searches Tim's template paths; and Structural's steel reference grid depends on an absent legacy catalogue. Prioritise the palette failure for the Civil + Manager colleague handover. The two Structural findings remain separate from that delivery. All three are proven by source reading under explicit conditions, with deterministic tests supplied but not run. No code was changed, no AutoCAD session was opened, and no release acceptance is claimed.
