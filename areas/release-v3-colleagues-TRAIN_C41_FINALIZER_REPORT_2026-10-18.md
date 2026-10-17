# Train C-41 finalizer report (Civil + Manager), Sat 17 Oct 2026 (evening, Melbourne time)

**Answer first: GO.** Train `claude/rel-20261018a`, final head `6ce675ef` (was a78b0388; one finalizer commit on top, pushed as a normal fast-forward). Built and unit-tested only. Nobody has opened any of it in AutoCAD; nothing was installed, deployed or version-edited. Every new switch ships OFF, and with them OFF the double-click, the Checks doors and the after-MOVE label tidy behave as installed Civil 3.0.51 (read line by line against `claude/rel-20261017c` @ 4e2bdfeb, not only the builders' tests).

**One thing the payload builder must do differently from the assembler's note:** ship Manager with Civil. CE_SHARED carries the central tool register inside it, and the assembly commit a78b0388 re-pinned that register, so CE_SHARED.dll is not the same file as the one installed with 3.0.51 / 1.1.51 (item 5.1).

## 1. What I changed (one commit, `6ce675ef`)

1. **net48 reds, test only (assembler flag 7.6):** the two Tidy labels tests that read the pick filter's AutoCAD TypedValues now read through one lane-aware reader. The AutoCAD 2027 lane must read the real values (the reader re-throws there, never falls back: no weakening). Only the AutoCAD 2022-2024 stub lane, whose reference DLLs have no method bodies, checks the two source lines that build the filter instead. Red on net48 at a78b0388 (2 failed, InvalidProgramException), green after on net48 and net10.
2. **Plain words (small product fix):** after a drafter types Yes to switch Tidy labels on, the line said "Turn it off again in Settings (Linking: Tidy labels) any time." That names a settings group and a Settings row that does not exist. Now: "Tidy labels is on for this computer. Your office administrator can switch it off again in CE Settings." (same wording as the Checks list's switched-off line). Red first (new test failed on the old wording), green after. Only seen after a typed Yes.
3. **Wrong folder in the switch-on notes:** three REGRESSION_LOG notes told Tim (and Codex) to edit `CD_Settings.json` in `%APPDATA%\TIM_CE_CADTOOLS\settings`. Civil reads it from `%APPDATA%\TIM_CE_CADTOOLS` itself (the `settings` subfolder exists only inside test runs). Editing the wrong file would have left the switch OFF and made a Codex run look like a fail. Corrected.
4. **Stale comments (assembler flag 4.5):** the `doubleClick` group summary in `UserSettings.cs` said the switch is ON (it is OFF); the Checks pointer-line class summary said its own value is OFF (it is ON, and only shows while the main Checks switch is ON).
5. **REGRESSION_LOG:** one finalizer entry (13 lines added); the file stays add-only against C-40 (192 added, 0 removed), stored LF, no control characters.

## 2. The four fix rounds, judged (not re-reviewed by anyone before me)

1. **#1313 (b673fe18, ed5680ba) with #1316 (884413df, 88b02d98), double-click:** right. One table lists, per kind of CE object, the AutoCAD commands 3.0.51 already redirects ("installed") and the ones only the new switch adds ("switched": only EATTEDIT). With `doubleClick.opensEditWindow` OFF the watched list is exactly the nine commands of 3.0.51 (BEDIT, DBLCLKTEDIT, PEDIT, MLEDIT, QUICKPROPERTIES, PROPERTIES, TEXTEDIT, MTEDIT, DDEDIT). Read against 4e2bdfeb: the PROPERTIES 1.5 s "a double-click started it" gate is unchanged; the inspect rule is unchanged for those nine; the owner search runs only the 3.0.51 walk (the tagged-source test and the recorded-owner proof run only when ON); the damaged-record sentence only when ON; stopping AutoCAD's editor is the same three steps (lock the block editor for BEDIT, empty the pick set for the text editors, post the cancel). One order change: the Properties-palette state is now read before those steps instead of after; it only matters for PROPERTIES, where neither step runs. The old key `pitLabelOpensEditPit` is read once and never written back.
2. **#1315 (399309e3), the one Checks list:** right. `checks.checksCommandEnabled` OFF: CDHUB opens Civil Hub, CDCHECKCURRENT opens What CE Found, the Review panel has the same buttons in the same order as 3.0.51 (Project Review, Checks, Check Current Drawing, Pit Schedule, Calculations, Top Water Level, Downpipe Destinations, Profile, Civil Hub, Solve Run); the registry entries for CDHUB, CDCHECKCURRENT and CDCHECK are unchanged against 4e2bdfeb; What's New is unchanged; the Help guide keeps every old entry and adds one "Checks (not switched on yet)". The switched-off and fold-in lines name no setting (the round-4 MEDIUM is fixed).
3. **#1314 (84c5f5e1), Tidy labels:** right. The Help count fix is in; the train resolved it to 81 with the command count at 145.
4. **`checks.typedAnswersPointToChecksPalette` false to true: keep it.** The pointer line needs it AND the main switch (`ChecksPointerLine.ForTypedAnswer`), so with the main switch OFF CDCHECK and CDRULES print exactly what 3.0.51 prints. Tim's settings file does not hold the key today. When Codex passes the list, the line comes on with the main switch in one flip.
5. **Assembly commit a78b0388 (register re-pin 137 to 139 rows, new hash): right as data, but see 5.1.** It is the test baseline following an intended change (two new registry rows); the runtime reads only the tool entries from the register, never the pins.

## 3. Tim's ruling I2: nothing pops up to block a quick edit

1. **No modal window, no blocking prompt on grips, MOVE or Properties, no document lock held while a window is open.** No added product line shows a modal dialog or a message box. The Checks list is a modeless palette that takes no document lock and has no timer, Idle or command-end handler: it checks only when CDCHECKS (or CDHUB / CDCHECKCURRENT while ON) runs or Check again is pressed. Tidy labels asks its questions on the command line inside the command the drafter typed or clicked. A double-click opens a window only when the drafter double-clicked (G2); PROPERTIES and EATTEDIT count only within 1.5 s of a double-click, so Ctrl+1, the ribbon and typed commands keep AutoCAD's own. The after-MOVE label tidy gains one Settings read (`tidyRearrangeNeighbours`, OFF) and is otherwise the same code path with the same messages.

## 4. Redo guard (Show where)

1. **The only watched call added:** `Editor.SetCurrentView` at `Modules/Drainage/Services/Checks/AutoCadShowWhereSurface.cs:60`. Reached only from `ChecksListPaletteService.ShowWhere`, which is only bound to the Show where button (no keyboard binding, no double-click on a row, no selection-changed trigger, no timer, no Idle). The scan's roots are hook events (Idle, drawing switch, selection, command events, timer Elapsed); none reaches it. So it cannot run between U and REDO unless the drafter presses the button, and then it ends REDO the way a typed ZOOM does. Redo guard green on net10 (full Civil run) and net48 (focused run). No baseline line needed; none added. Keep "U, Show where, REDO" in the Codex recipe.

## 5. Findings (none HIGH)

1. **MEDIUM (payload, not code): Manager must ship with Civil.** `Shared/CE_SHARED/CE_SHARED.csproj` embeds `Assets/Config/ce-tool-register.json`. a78b0388 changed that file, so the built CE_SHARED.dll now carries the new pin (checked in the built file: new hash present, old hash absent) and differs from the CE_SHARED installed with 3.0.51 / 1.1.51. CE_SHARED is one assembly identity for Civil and Manager (first loaded wins), so build both from `6ce675ef` and install them together. My build: CE_SHARED.dll byte-identical in the Shared, Drainage, Manager, Structural and CE.Host outputs on every lane (net48 12DBE03F, net8 0429FE7A, net10 9674EBA4). A drafter would not see a mismatch (the pins are not read at runtime), but the rule is byte-identical.
2. **LOW, behaviour changes that are bug fixes, not switches:** #982 (BUG-558, inside #1313) drops a queued Edit Pipe redirect, pipe-attachment grip action or pit cover-text flip when another drawing became current before AutoCAD's idle moment (3.0.51 would start it in the wrong drawing), and the set of registered drawings is now kept by drawing identity. Both differ from 3.0.51 only in the bug case. Allowed under ruling A.
3. **LOW, visible with everything OFF (by design):** a "Tidy labels" button on the Civil Edit panel, and two new Help entries. The button says it is switched off and asks "Switch Tidy labels on for this computer now?" (Enter is No).
4. **LOW, standing R-00:** none of the new switches has a Settings window row; the plain lines say "in CE Settings". One Settings-page card covers it.
5. **LOW:** `linking.tidyLeaderOut` and `tidyLeaderOutMaxMm` are read by nothing yet (engine only). **LOW:** CDCHECKS stays hidden in the command search even when switched on; the flip list in REGRESSION_LOG names it. **Carried, switch OFF:** #847's rearrange double count (fix before `tidyRearrangeNeighbours` goes ON); Tidy "All" inside a layout viewport finds no model-space pipes.
6. **Housekeeping:** the assembler's worktree is now 1 commit behind origin; whoever uses it next should fast-forward it. I accidentally overwrote a `build.ps1` in the desk's scratch folder (no other script there refers to it); my own scripts were moved to a subfolder.

## 6. Rules, re-verified

1. **Settings-first:** every new behaviour has a Settings key with a C# default; no engineering number hard-coded (1500 mm leader-out limit is a Settings value, unused while off).
2. **No hard blocks (R-27):** Tidy labels refuses only during REFEDIT (plain line); everything else is a question or a count.
3. **No blue:** the Checks palette uses theme brushes only (the light theme's accent is the existing theme colour).
4. **Plain English, command shown, no key names in user text:** after my fix none of the new drafter lines names a setting.
5. **Locked layers, Xref, REFEDIT:** Tidy labels never opens a locked-layer pipe or label for write (counted and left alone), never selects Xref content, refuses during REFEDIT; the double-click goes through CDEDIT's own refusals; Checks only reads. Nothing unlocks a layer.
6. **CE_SHARED:** no file under `Shared/` changed; see 5.1 for the embedded register.

## 7. Builds and tests (build lock around every run; Below Normal; skip-bundle, no node reuse, no build servers; log folder redirected to scratch)

1. **Whole solution, Release:** at a78b0388 0 errors, 885 warnings (assembler: 0 / 885); after my commit 0 errors (incremental build).
2. **Civil net10, whole suite:** 17,967 run, 17,947 pass, 19 skipped, 1 failed = `BackTest_GlenEira24115_Computed_WithinTolerance` (on the plain base too). Assembler: 17,966 / 17,946 / 19 / 1. The one extra is my wording test.
3. **Civil net48 focused** (the assembler's class list): 342 run, 342 pass. Assembler: 341 run, 2 failed (the two Tidy reds, now fixed); +1 is my test.
4. **Manager 751/751. CommandTruth 64/64. TestHarness 101/101. Spine 81/81. Diagnostics 19/19. AI.Core 42/42. ReleaseTests 16/16.** All equal to the assembler.
5. **Not run:** Installer.Tests, Structural tests, the net8 test lane, anything in AutoCAD.
6. **Tim's files, unchanged before, between every suite and after:** `CD_Settings.json` 15,270 bytes ACD64E79; Civil `CS_Settings.json` 351,713 bytes 622A246F; Structural `CS_Settings.json` 34,858 bytes 24D8E5F7; live CE folders CE_CVL_SUITE 99 files, CE_STRUC_SUITE 2,474 files, TIM_CE_CADTOOLS 22,173 files, byte totals identical. AutoCAD not running. Disk 20.8 GB free at the end; ignored build output cleaned.

## 8. The switches and their defaults

1. `doubleClick.opensEditWindow` **OFF** (old key `pitLabelOpensEditPit` read once).
2. `checks.checksCommandEnabled` **OFF**.
3. `checks.typedAnswersPointToChecksPalette` **ON** (was OFF; shows nothing while 2 is OFF).
4. `linking.tidyLabelsEnabled` **OFF** (the command offers to switch it on).
5. `linking.tidyMovesPitText` **OFF**; `linking.tidyRearrangeNeighbours` **OFF**; `linking.tidyLeaderOut` **OFF** (not wired yet); `linking.tidyLeaderOutMaxMm` **1500** (unused while off).

## 9. What Tim will see (plain English), with everything as shipped

1. **Double-click is the same as today:** a pit, a pipe, a DP / IO / OF / FO / TG source and their labels and level text open their Edit window; a pit number still opens AutoCAD's attribute editor.
2. **The Review panel, Civil Hub, Check Current Drawing, CDCHECK and CDRULES are the same as today.** Typing CDCHECKS says the new Checks list is switched off and nothing was changed.
3. **New: a Tidy labels button on the Edit panel.** It says it is switched off and asks whether to switch it on for this computer (Enter means No).
4. **Help has two new entries:** Tidy labels, and Checks (not switched on yet).
5. **Bug fix:** a double-click or grip action that was waiting for one drawing no longer starts in another drawing you switched to.

## 10. What Codex should check in AutoCAD (copies only; switch on per the corrected notes in REGRESSION_LOG first)

1. **Switches OFF (parity):** double-click a pit, a pipe, a pipe label and a pit number: the first three open Edit Pit / Edit Pipe, the pit number opens AutoCAD's attribute editor. Ribbon Review panel shows Checks, Check Current Drawing and Civil Hub. Type `CDCHECKS`: one switched-off line. Type `CDTIDYLABELS`, press Enter at the switch-on question: "switched off", nothing changed.
2. **Double-click ON:** double-click a pit number: Edit Pit opens and the attribute editor does not stay open; double-click a flow arrow: Edit Pipe; double-click a DP source block. Then grips, `MOVE` and Ctrl+1 on the same objects open no CE window.
3. **Checks ON (restart AutoCAD):** one Checks button; `CDHUB` and `CDCHECKCURRENT` open the same list; pick a row, Show where zooms; `U`, Show where, `REDO`: record whether REDO still works.
4. **Tidy labels ON:** on a crowded sheet copy, `CDTIDYLABELS`, Enter (All), read the count, `Yes`, then `U` once: every label returns. Put one pipe on a locked layer first: it is counted as left alone.

## 11. Not tested

No window, palette, ribbon or drawing was looked at; nothing ran in AutoCAD; Installer and Structural tests and the net8 test lane were not run.

OPUS SIGN-OFF train claude/rel-20261018a GO (6ce675ef7615b66b185485761ce0180ab6dcbe91)
