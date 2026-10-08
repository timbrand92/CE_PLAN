**Code read on rel-20261009c 446162c2** (installed Civil 3.0.39; re-checked by design run 6, Fri 9 Oct 2026 about 05:45 PC clock).

# Batch 3 card: how every CE window feels, 9 Oct 2026

## Re-check on the release commit (run 6, 9 Oct 2026)

1. **CONFIRMED on 446162c2:** Pit Schedule minimum width 1440, not resizable, centred on the screen (`Dialogs/PitScheduleDialog.xaml:7-9`)
   and blocking (`Commands/PitScheduleCommand.cs:34`); Settings and Project Review not resizable (`Dialogs/AdvancedSettingsDialog.xaml:8`,
   `Dialogs/DesignCheckDashboardDialog.xaml:8`); only the Civil Hub remembers its position (`Dialogs/CivilHubDialog.xaml.cs:456-460`);
   the Pit Schedule position settings exist and are unused (`Models/UserSettings.cs:857-862`); preview waits 0.5 s
   (`Helpers/PreviewDebounce.cs:13`); the Edit Pipe dry-run preview is still not switched on (`Commands/PipeEditCommand.cs:145`); accent
   blue `#1E5AA8` in light and gold `#C9A84C` in dark (`Themes/LightTheme.xaml:14`, `Themes/DarkTheme.xaml:15`); Inspector palette
   420 x 820 (`Services/InspectorPaletteService.cs:339`); workshop editors centred on AutoCAD, others on the screen
   (`Services/DialogService.cs:76, 109, 166`); the ribbon tooltip "Type:" line (`Shared/CE_SHARED/Services/RibbonBuilder.cs:455`); the
   Structural tooltip builder (`Modules/Structural/Services/RibbonCommandHubService.cs:208`).
2. **CONFIRMED, "the shared frame is unused":** `Controls/CeEditorShell.xaml` is placed in no window. Other files mention only its
   settings store and the "workshopLayout" switch (`Commands/PipeEditCommand.cs:129`, `Services/DialogService.cs:43`,
   `Services/InspectorPaletteService.cs:65`); these are not the frame itself.
3. **CONFIRMED, "XCLM text is the only window with Alt shortcuts":** a wider search on the release found one more match,
   `CeSharedTitleMappingWindow.xaml:92`, but that is the file name "CS_Settings.json" in a label, not a shortcut.
4. **New since master, does not change the card:** both themes gained a readable error-text colour and screen-reader names for blank
   table cells (BUG-360), which helps UX-ACC-01. `Services/InspectorPaletteService.cs` (+329 lines) and `Services/DialogService.cs`
   (+90 lines) changed, but the palette size and centring the card quotes are the same.
5. The "detail from local master" files (`Controls/StatusChip.xaml`, `Helpers/WorkshopEditorFocus.cs`, `Services/WindowSizingService.cs`,
   `CeCvlRibbonContributor.cs`) are **unchanged** between master and 446162c2, so what was read there holds for the release.

**Status: DRAFT. Not approved. No code may start until Tim answers `TIM_BATCH_QUESTIONS_2_3_2026-10-09.md` (questions 8 to 14) and
approves this card.**
Written by design lane run 5 (headless, Opus), Fri 9 Oct 2026 about 05:45 Melbourne (PC clock). Read-only on plugin code: "today"
below is read from the Civil release commit `446162c2` (train C-25, 9 Oct; spot-checked by git grep) with detail from the local
`master` checkout (`650c0c19`, 28 Sep, weeks behind the installed builds: used only where the release commit agrees), and from the Codex
reports in `C:\Lisp Files\_TEST_COPIES_20260923`. Not seen in AutoCAD. File references are at the end.

**Items (8):** UX-LOOK-01, UX-WIN-01, UX-WIN-02, UX-WIN-03, UX-WIN-04, UX-ACC-01, UX-ACC-03, UX-TIP-01.
**Windows touched:** New Pipe / Edit Pipe (CD, CDEDIT), New Pit / Edit Pit (PIT, PITEDIT), Pit Schedule (PITSCHEDULE), Settings (CDS),
Project Review (CDDASHBOARD), Drawing Repair (CDREPAIR), Water Tank (CDWT), Report a problem (CDFEEDBACK), the Structural and Manager
windows, the CE Inspector and What CE Found palettes, and every ribbon button's tooltip.
**Why now:** every Day 1 step from 3 to 13 opens one of these windows. These are the rules the builders need before they touch any
window (UX-LOOK-01 was planned "window by window" on 25 Sep and never carded).
**How to build it:** window by window, never all at once (the incremental rule in the plugin's `AGENTS.md`). Order proposed: Pit
Schedule, Project Review / Checks, Settings, Tank, Repair, Feedback, then Structural, then Manager. One window per pull request, with a
before-and-after picture for Tim.

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` lines 391-404 (UX-LOOK-01, 25 Sep 14:08), 1833-1840 (UX-WIN-01..04,
26 Sep 12:05), 1985-1990 (UX-ACC-01..03, 27 Sep 01:50), 1812-1813 (UX-TIP-01), 2016-2018 (UX-NAMES-03: plain words on buttons, the typed
code in the tooltip); `V3_UX_PLAN.md` section 1 rules 1 and 19. The 5 Sep Settings review stands for colours, type and buttons
(UX-LOOK-01 point 3); the 17 Sep DRYRUN-01 decision (what the Edit Pipe preview shows) is NOT reopened here.

**Related open bugs:** BUG-226, BUG-227, BUG-228 (ribbon tooltips that describe things the installed window does not do);
Codex UI/UX review items 15, 17, 18, 20, 24, 25 (scrolling and clipped windows: CDCALC, Project Review, Pit Schedule, Civil Hub, Settings,
Standards); Codex Explore 1 item 12 (Manager and Structural show different version numbers).

---

## Card 3.1 — UX-LOOK-01: one header and footer on every CE window

1. **Tim ruled (25 Sep):** "New Pipe's." CE logo, one-line summary of what you're working on, status top right; tools bottom left, Cancel
   and the gold button bottom right. Tabs only where a window has separate topics (Settings keeps its tabs).
2. **Today:**
   - **Have the look:** New Pipe, Edit Pipe, New Pit and Edit Pit (the "workshop" windows). Each copies the header and footer by hand and a
     layout helper rearranges it when the window opens. If the window does not fit the screen, CE falls back to the OLD tabbed Pipe or
     Pit window, which does not have the look.
   - **Do not have it:** Pit Schedule, Settings, Project Review, Drawing Repair, Water Tank, Report a problem (it borrows the colours
     only), every Structural window and every Manager window (none show the CE logo in the header).
   - A shared ready-made header-and-footer frame exists in the code (logo, summary, "Preview — changes not saved" banner, status, footer
     with Save and Close / Cancel and a progress bar with Cancel) but **no window uses it**.
   - **The "gold button" is gold only in the dark theme.** In the light theme the same button is blue (`#1E5AA8`); dark uses gold
     (`#C9A84C`). Structural and Manager follow the same pair.
3. **What works:** the four workshop windows; the shared colours; status shown as a shape plus colour (UX-ACC-02 already holds in the
   status chip).
4. **Wrong or missing:** the look on the other windows; one shared frame instead of four hand copies; the fallback window.
5. **Classification: MODIFY** (four windows done), **REBUILD** the header/footer of the other windows onto the one shared frame.
6. **Proposed:**
   - Every CE window is built on the one shared frame. Header: CE logo, the window's name, one line saying what it is working on ("Pit
     P4 · Grated pit 600 × 600 · DWG-B"), status top right (tick, triangle or cross with words).
   - Footer: tools bottom left (for example Help, Export, Review changes), Cancel, then the one primary button bottom right with a verb
     ("Save", "Apply", "Place", "Close" only where nothing is changed).
   - Tabs only for separate topics (Settings, CDCALC). No hidden content: what was in a collapsed section moves to a tab or stays shown
     (Codex UI/UX review: Pit Schedule's collapsed "Schedule setup", Civil Hub's expander).
   - Light theme primary button: question 8 (keep blue, or gold in both).
   - The tabbed fallback windows stay only until each workshop window fits at 150% scaling (card 3.6), then are retired with Tim's yes.
7. **Discovery:** nothing to learn; every window looks the same.
8. **Order and pictures:** one window per pull request, with a light and a dark picture, before and after.

## Card 3.2 — UX-WIN-01: Enter applies, Esc cancels

1. **Tim ruled (26 Sep):** "Enter = Apply, Esc = Cancel." As in AutoCAD's own dialogs; Tab runs top to bottom, left to right; Enter
   inside a multi-line box adds a line.
2. **Today:**
   - **Right:** New/Edit Pipe, New/Edit Pit, the old Pipe and Pit windows, Settings, Slab, Water Tank, Report a problem, What's New and
     Start Here all have Enter = the main button and Esc = Cancel. Remarks and note boxes take Enter as a new line.
   - **Different:** Pit Schedule has no Enter button (Enter on a row zooms to that pit; Esc closes). Project Review has none (Enter on a
     finding jumps to it). Drawing Repair has none found. The "grade does not match" question uses Esc for "keep what I typed"; the
     "continue rising main" question uses Esc = No, Enter = Yes. In Settings, Enter in the search box jumps to the first match and Esc
     clears the search. Manager's small windows close on Esc.
   - **Tab order:** no window sets an order by hand; three windows (Pipe, Pit, Settings) wrap Tab round at the end.
3. **Classification: MODIFY (small).**
4. **Proposed:**
   - Every window: Enter = the primary button, Esc = Cancel (or Close where nothing changes).
   - In a list window, Enter on a highlighted list row does the row's action (Pit Schedule: show that pit; Project Review: Show where),
     Enter anywhere else = the primary button (question 9).
   - In a search box, the first Esc clears the search, the second Esc cancels the window.
   - Small yes/no questions: Esc = the safe answer that changes nothing (today's "keep what I typed" and "No" already are).
   - Tab runs top to bottom, left to right, in every window (a test walks the order).

## Card 3.3 — UX-WIN-02: each window opens where you last left it

1. **Tim ruled (26 Sep):** "Where you last left it." Per PC and monitor; if that monitor is gone it opens centred on AutoCAD. Personal,
   never copied to colleagues.
2. **Today:** only the Civil Hub remembers its spot (and size), in the personal Civil settings file; it checks only the main monitor and
   re-centres on the screen, not on AutoCAD. Pit Schedule has saved-position settings that nothing reads or writes. One Structural window
   (the XCLM text window) remembers its spot. Every other window opens centred (on AutoCAD for the workshop editors, on the screen for others).
3. **Classification: MODIFY.**
4. **Proposed:** every CE window and palette remembers its spot and size for each monitor layout, in the personal settings only (never in
   office or job settings). If that monitor is no longer connected (a laptop off its dock), the window opens centred on AutoCAD and fully
   on screen. A window that would open partly off screen is pulled back on.
5. **Example:** on the office dock you drag Pit Schedule to the right-hand monitor; next time it opens there. At home on the laptop alone
   it opens in the middle of AutoCAD; back on the dock it goes to the right-hand monitor again.

## Card 3.4 — UX-WIN-03: the preview follows typing

1. **Tim ruled (26 Sep):** "As you type." The drawing preview updates about 0.3 s after typing stops; nothing is written until Apply.
2. **Today:**
   - The previews are small pictures INSIDE the window (pipe plan sketch, pit outline), not ghosts in the drawing.
   - They redraw half a second (0.5 s) after typing stops; the old picture stays until the new one is ready.
   - Edit Pipe's picture shows the drawing as it is now, not what Save would draw (the "what Save would draw" preview exists in the code
     but is switched off, by the 17 Sep DRYRUN-01 decision). Edit Pit redraws the outline at once for size, type and rotation, captioned
     "Pit — not yet saved".
   - Pit Schedule has no drawing preview; its search waits 0.3 s.
3. **Classification: MODIFY (small).**
4. **Proposed:** 0.3 s after typing stops in every window with a preview (question 10). Nothing is written to the drawing until the
   primary button. Whether Edit Pipe's picture shows the result is DRYRUN-01's question, not this card's.
5. **Test:** typing fast redraws once after the pause (an existing test covers 0.5 s; change it to 0.3 s).

## Card 3.5 — UX-WIN-04: editors block AutoCAD; palettes stay open

1. **Tim ruled (26 Sep):** "Editors block, palettes don't." Edit windows (Pipe, Pit, Tank and the like) hold AutoCAD until Apply or Cancel;
   Civil Properties, Checks and Proposals are palettes that stay open while drafting.
2. **Today:**
   - **Block AutoCAD (right):** Edit Pipe, Edit Pit, Water Tank, Settings, Drawing Repair, Report a problem, Civil Hub.
   - **Block AutoCAD (ruling says palette):** Project Review (it is the nearest thing to "Checks" today) and Proposals / Drafting fixes.
   - **Block AutoCAD (not named in the ruling):** Pit Schedule.
   - **Palettes (stay open):** CE Inspector (Civil Properties), What CE Found, CE Assistant, CE Blocks (Manager).
3. **Classification: MODIFY.**
4. **Proposed:**
   - Checks becomes a palette (Batch 2 card 2.2). Proposals becomes a palette: the list stays open; "Apply" on one proposal opens its
     blocking preview, as an editor.
   - Project Review stays a blocking window for the full pre-issue review (question 11).
   - Pit Schedule stays blocking: it writes on Close and one U takes back the whole visit (Day 1 steps 10 and 11), which a palette would
     break (question 12).

## Card 3.6 — UX-ACC-01: windows follow Windows display scaling and stay sharp on 4K

1. **Tim ruled (27 Sep):** "Follow Windows scaling." No separate CE text-size setting.
2. **Today:** CE windows take AutoCAD's own scaling (no CE setting of its own; none wanted). Most windows are a FIXED size that cannot be
   resized: Pit workshop 1680 × 920, Pit Schedule 1440 × 800 (minimum width 1440), Settings 1100 × 620, Project Review 1216 × 800,
   Pipe workshop 680 × 820. The workshop windows measure the screen and, if they do not fit, fall back to the old tabbed window. The palettes
   are a fixed size in pixels (the Inspector 420 × 820). Text sharpening settings are set only in the Structural and Manager themes.
3. **Wrong or missing (worked out, not seen):** at 150% scaling a 1680-wide window needs 2520 screen pixels, wider than a 1920 × 1080
   laptop, so Edit Pit would fall back to the old window there; Pit Schedule would run off the screen.
4. **Classification: MODIFY.**
5. **Proposed:** every window can be resized down to a minimum that fits a 1920 × 1080 screen at 150% (about 1280 × 720 usable), with
   no clipped buttons and no hidden content; tables page or scroll inside their own panel, never the whole window. Sharp text on 4K at
   200%. Codex checks each window at 100%, 125%, 150% and 200% (question 13).

## Card 3.7 — UX-ACC-03: every control reachable by Tab; Alt shortcuts on main buttons

1. **Tim ruled (27 Sep):** "Yes." Every window control reachable by Tab, with underlined Alt shortcuts on main buttons (for example
   Alt+A Apply). Extends UX-WIN-01.
2. **Today:** no Civil or Manager window has an underlined Alt shortcut. One Structural window (XCLM text) has them (Undo Auto-fix,
   Change Source, Change Sheet, Refresh Past Jobs, Re-analyze, Insert Selected, Close). Tab reaches the controls in the order they were
   laid out; three windows wrap round.
3. **Classification: MODIFY.**
4. **Proposed:** the shared footer (card 3.1) carries the shortcuts so every window gets them at once: **S**ave / **A**pply / **P**lace on
   the primary button, Cancel on Esc (no letter needed), **H**elp on F1 (already works in every Civil window), **R**eview changes. Each
   window's own tools get a letter not used by its footer. A test fails if two buttons in one window share a letter.

## Card 3.8 — UX-TIP-01: ribbon tooltips, Autodesk style

1. **Tim ruled (26 Sep):** "Autodesk style." Short line first; a longer hover shows a small picture of the result plus the typed command
   name, like AutoCAD's own buttons. UX-NAMES-03: buttons say plain words ("New Pit"); the typed code appears in the tooltip.
2. **Today:**
   - **Civil and Manager** (shared ribbon builder): title "Pipe (CD)", a short line ("Draw a new drainage pipe."), and on a longer hover
     a longer text ending "Type: CD". **No picture anywhere** (no button sets one).
   - **Structural** (its own builder): title is the bare command name ("BT1"), then "Alias: ...", the short description, and
     "Prompts: ..." listing up to three prompts. No picture, no plain-word title.
   - BUG-226, 227, 228: three Civil tooltips describe things the installed window does not do.
3. **Classification: MODIFY** (Civil text and "Type:" line done), **REBUILD** the Structural tooltip onto the shared builder.
4. **Proposed:**
   - Every ribbon button, Civil, Structural and Manager, uses the one shared builder: title in plain words ("Bracing truss"), one short
     line, then on a longer hover a small picture of the drawn result and "Type: BT1".
   - Pictures: cropped from Codex's test-copy screenshots of the real result (job numbers only, never a client drawing), about 300 × 180,
     light and dark (question 14).
   - The tooltip text comes from the one command list (`command-registry.json`), and a test fails when a tooltip names a window page, an
     option or a command that does not exist (the BUG-226..228 family).
5. **Order:** the Day 1 buttons first (PIT, CD, PITEDIT, CDEDIT, PITSCHEDULE, CDCHECK, CDRULES, BT1, R1, 1, C1, BTX, CSREOBAR, FSF, FPFC,
   FEDIT, CESUPPORT), then the rest.

---

## Tests (automated, before Tim)

1. Every window opened by its command shows the shared header and footer (a test lists every CE window and fails on one without the frame).
2. Every window: Enter presses the primary button, Esc cancels, except the list-row and search-box cases in card 3.2.
3. Tab order walk: top to bottom, left to right; every control reached.
4. Position memory: save on one monitor layout, reopen with that monitor gone, the window is centred on AutoCAD and fully on screen.
5. Preview waits 0.3 s after the last keystroke and redraws once.
6. Each window at 100%, 125%, 150%, 200% on 1920 × 1080: nothing clipped, no fallback window (Codex screenshots).
7. No two buttons in a window share an Alt letter.
8. Every ribbon button has a title in words, a short line, "Type: <command>" and (Day 1 buttons) a picture; tooltip words name only real things.

## Example drawings

1. `C:\Lisp Files\_TEST_COPIES_20260923\DWG-B.dwg` (Civil windows) and `DWG-S` fixtures (Structural windows), copied to a new name per run.
2. No new drawing needed: this batch is about the windows themselves.

## Tim's AutoCAD checklist (about 10 minutes, on a copy)

1. **Same look:** open `PITSCHEDULE`, `CDS`, `CDDASHBOARD` and `PITEDIT` one after the other. **Should see:** the same logo, one-line summary and status at the top; Cancel and the main button bottom right in each.
2. **Keys:** in Edit Pit, change the cover level and press Enter: it saves. Open again and press Esc: nothing changes. Alt+S saves.
3. **Position:** drag Pit Schedule to your second monitor, Close, open it again. **Should see:** it opens there.
4. **Preview:** in Edit Pit type a new width. **Should see:** the outline picture follow a moment after you stop typing.
5. **Palettes stay open:** open the Checks palette and keep drafting with it open.
6. **Laptop scaling:** on a laptop at 150%, open Edit Pit and Pit Schedule. **Should see:** both fit, nothing cut off.
7. **Tooltips:** hover over New Pit, then keep hovering. **Should see:** a short line, then a small picture and "Type: PIT". The same on a Structural button such as BT1.

## Code references (release commit 446162c2 unless marked)

Under `Modules\Drainage\`: `Dialogs/PipeEditWorkshopDialog.xaml`, `Dialogs/PitEditWorkshopDialog.xaml`, `PipeOnePageLayout.cs`,
`PitOnePageLayout.cs`, `Services/DialogService.cs` (owner, centring, fallback to the tabbed window), `Controls/CeEditorShell.xaml`
(the unused shared frame), `Themes/LightTheme.xaml` / `DarkTheme.xaml` (accent blue / gold), `Themes/CivilEditorShellTheme.xaml`,
`Dialogs/PitScheduleDialog.xaml:7-9` (minimum width 1440, not resizable), `Dialogs/AdvancedSettingsDialog.xaml:8`,
`Dialogs/DesignCheckDashboardDialog.xaml:8`, `Commands/PitScheduleCommand.cs:34` (blocking), `Dialogs/CivilHubDialog.xaml.cs:456-489`
(position memory), `Models/UserSettings.cs:857-870` (Pit Schedule position settings, unused), `Helpers/PreviewDebounce.cs:13` (0.5 s),
`Controls/CdPlanPreviewControl.cs:69`, `Commands/PipeEditCommand.cs:145, 443-475` (dry-run preview present, not switched on),
`Services/DrawingCheckPaletteService.cs:65`; `Shared/CE_SHARED/Services/RibbonBuilder.cs:455` ("Type:" line); 
`Modules/Structural/Services/RibbonCommandHubService.cs:208-231` (Structural tooltip); `Modules/Structural/UI/Dialogs/XclmTxtDialog.xaml:198-255`
(the only Alt shortcuts). Detail from local master 650c0c19 (agreeing): `Controls/StatusChip.xaml`, `Helpers/WorkshopEditorFocus.cs`,
`Services/WindowSizingService.cs`, `Services/InspectorPaletteService.cs` (palette size), `CeCvlRibbonContributor.cs` (tooltip texts).
Codex: `CODEX_CIVIL_UIUX_REVIEW.md` items 15-25; `CODEX_EXPLORE1_REPORT_2026-09-29.md` items 11-12; `CODEX_SWEEPC1_2026-09-30.md` items
550-551 (tooltips read, "no illustrated extension observed").
