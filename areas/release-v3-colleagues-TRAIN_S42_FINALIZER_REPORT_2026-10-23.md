# S-42 Opus finalizer: Structural train claude/rel-20261023s

Independent check of what S-42 adds on top of S-41 (`claude/rel-20261022s2` = `2c9a9694`, Structural 1.0.121, the installed Structural line). Fri 23 Oct 2026, about 09:52 to 10:20 Melbourne time (PC clock). Opus 5.5, Team, headless, desk plan/03. Private worktrees `C:\ce-fin\s42` (train) and `C:\ce-fin\s42b` (base, for comparing net48 reds by name), both removed at the end. I did not start AutoCAD or accoreconsole (acad.exe was not running at the start or the end), deployed nothing, changed no version field, closed no PR, deleted no branch, merged no Civil or Manager PR, marked no bug FIXED, did not edit DESK_LOG.md.

## ANSWER FIRST

1. **GO at `c490b3077da5c9a8044253778fa4f54674172912`.**
2. **Branch `claude/rel-20261023s`, final head `c490b307` (unchanged).** `git ls-remote` at the start gave `c490b3077da5c9a8044253778fa4f54674172912`, equal to the assembly report. Base `2c9a9694` checked the same way.
3. **What I changed: nothing.** No commit, no push to the train. Both merges read correctly, no default needs turning off, and every test lane matches S-41's known results.
4. **Defaults:** the train adds or changes no Settings value. #1547 reuses Civil's existing switch "Log one line for each CE command that ends" (`options.commandOutcomeLines`), ON. Kept ON: it writes one line to the CE log and nothing to the drawing, and the missing line is the fault being fixed. #1533 has no switch: the old output named sections that do not exist (250 UB 26) or the wrong angle type, so the old behaviour is the bug.
5. **Tests at the head (Release, every command `-p:SkipDevBundle=true -nr:false --disable-build-servers`, Below Normal, foreground):**
   1. **Whole solution:** 0 errors, 927 warnings (same 927 as S-41).
   2. **Structural net10: 5,704 of 5,704 passed** (17 class chunks plus 7 nested; the Sbeam evidence class left out). Equal to the assembler's figure.
   3. **Structural net48: 4,961 passed, 39 failed, 698 not run (5,698).** I built the S-41 base `2c9a9694` and ran the same chunks: 39 failed there too, **the same 39 names exactly** (file compare). Nothing new fails.
   4. **DesignCore: 2,195 per lane on net48, net8 and net10; 2,190 passed, 5 failed per lane,** the same five release-settings names as S-40 and S-41.
   5. **CE.CommandTruth.Tests: 22 of 23.** The one red is the standing `Structural_KnownRegistryDriftRemainsPinnedBacklog` (expects 301, finds 395, the same 395 as S-40 and S-41).
   6. **Structural.ReleaseTests: 10 of 10 on net48, net8 and net10.**
6. **What Tim will see in AutoCAD after this train is installed (plain words):**
   1. **XCLMTXT member schedules keep the supplier's numbers:** "250UB25.7 BEAM" prints as "250 UB 25.7 BEAM" (it used to print 250 UB 26, a section that does not exist), "310UB32.0" keeps its ".0".
   2. **Angles read in full:** "150x90x10 L ]L LINTEL" prints "150 x 90 x 10 UA LINTEL"; "100x100x8 L ]L" prints "... EA". Before, every angle except 150x100x10 became EA, so a 150x90 unequal angle was labelled equal.
   3. **The CE log gets one line per Structural command,** for example "Command outcome: SBEAM completed 812 ms", or cancelled, refused or failed. Nothing changes in the drawing, the prompts or Undo.
7. **Do not mark FIXED (each needs a robot PASS plus a Codex PASS in AutoCAD, on copies):**
   1. **#1533 XCLMTXT:** a schedule with 250UB25.7, 410UB59.7, 310UB32.0, 150x90x10 L ]L, 100x100x8 L ]L and 150x100x10 L ]L: decimals kept, UA/UA/EA/UA as above. Add the review's LOW 1 row: "L ]L 150x90x10" (symbol before the size) now stays as typed "L ]L"; it used to become EA.
   2. **#1547 outcome lines:** with the CDS > Advanced tick ON, run CEMEMBER, SBEAM, a CE hatch command and CSREOBAR: one line each in the Structural log; press Esc in one: "cancelled"; untick it (settings changed before AutoCAD starts): no lines.
8. **Values and switches without a Structural Settings page row (I built none):** the outcome-line switch has a row in Civil's CDS > Advanced only. On Tim's PC Civil is installed, so that row works. Carried from S-41: `Layouts.HatchDensityFollowsPaper`, `Layouts.TagTextFollowsLabelHeight`, `Layouts.FollowAnyDrawingScale`, the CeMember group (9 values).
9. **Risks:**
   1. **The outcome word can be wrong in a rare case** (review LOW 11): if a native AutoCAD command runs inside a CE command at the moment the CE command marks its result, that mark is dropped and the line says "cancelled" or "completed" by default. Log wording only; the drawing is never affected. Does not matter for shipping.
   2. **Settings read on every Structural command:** when Civil's settings are not already loaded, Structural reads `CD_Settings.json` (about 15 KB) at the start and end of each CE command. Small. If the file cannot be read at that moment, that one line is skipped (an explicit OFF is never defeated).
   3. **Nobody has seen any of it in AutoCAD.**
10. **Tim's four settings files: unchanged** between my start (09:54) and end (10:11): `TIM_CE_CADTOOLS\CD_Settings.json` 15,270 bytes `acd64e7`; `TIM_CE_CADTOOLS\CS_Settings.json` 351,713 bytes `622a246`; `CE_CVL_SUITE\settings.json` 672 bytes `efe307c`; `CE_STRUC_SUITE\CS_Settings.json` 35,259 bytes `2972ce7` (first seven hex of SHA-256; same as the assembler's).
11. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Review of the merged PRs

1. **Merge integrity:** train against `2c9a9694`: two merge commits (`a3b2ff0b` #1547, `c490b307` #1533), 21 files, +766 -19. Everything is under `Modules/Structural*` except `REGRESSION_LOG.md` (+26 -0). Nothing under `Shared/`, `Installer/`, `CE.Host`, `Modules/Drainage` (Civil), `Modules/Manager` or `Assets/`. No file is touched by both PRs except `REGRESSION_LOG.md`, where the keep-both is correct: the #1533 entry on top, then the two #1547 entries, then S-41's; no conflict markers.
2. **#1547 against its review (`REVIEW_CODEX_PRS_A_2026-10-23.md` section 8), item by item:**
   1. **MEDIUM, safe JSON reader: closed.** `CommandOutcomeSetting.Parse` uses the `JsonReaderWriterFactory` reader. I compared it with Manager's (`41d921d9`, #1548): the `Parse` method is identical, line for line. Its tests came with it: ten JSON cases (empty, no options, true, false, broken, capitalised keys, "true" as text, duplicate key, options not an object, an array).
   2. **MEDIUM, full Structural run: closed by this finalizer** (section 4; the hanging Sbeam evidence class left out, as ordered).
   3. **LOW 10, one type that fails to load: closed.** `CommandOutcomeRegistry.LoadableTypes` catches `ReflectionTypeLoadException` and keeps the types that did load, so one bad type cannot switch every line off. Test `OneTypeThatCannotLoad_KeepsTheOthers_SoOutcomeLinesStayOn`.
   4. **LOW 11 (nested native commands) and LOW 12 (no Structural Settings row): left open by the fix round. Neither matters for shipping.** LOW 11 can only change the outcome word in the log in a rare case (risk 9.1). LOW 12 matters only on a PC with Structural and no Civil; Structural is on Tim's PC only, where Civil's CDS > Advanced tick works.
3. **#1547, the switch is read the way Civil reads it:** Civil reads `SettingsService.Current.Options.CommandOutcomeLines`, default `true` (`UserSettings.cs`, `[JsonProperty("commandOutcomeLines")] ... = true` on the Civil train). Structural first reads Civil's already-loaded settings (the same `_currentSettings` field behind `Current`, without calling `Current`, so it never starts or migrates Civil's settings), then the same file Civil saves (`%APPDATA%\TIM_CE_CADTOOLS\CD_Settings.json`, same folder rule), then ON when the file or the key is missing. So a tick change in CDS > Advanced reaches Structural immediately when Civil is loaded. Tim's own `CD_Settings.json` has no `commandOutcomeLines` key today, so it reads ON.
4. **#1547, what the line carries:** exactly "Command outcome: NAME WORD N ms" (`CommandOutcomeLogger.Finish`), written through the Structural log's INFO line (which carries its own time stamp). No drawing name, path, prompt answer or message text; `CommandHistoryService` reads only its own result word (OK / CANCELLED / FAILED).
5. **#1547, nothing written to the drawing, no command behaviour change:** every added line in the command files is a one-line mark (`MarkCompleted`, `MarkCancelled`, `MarkRefused`, `MarkFailed`, `MarkException`) placed beside an existing return or message; no condition, return or prompt changed. The listener only subscribes to command and prompt events; it opens no transaction, sets no system variable, sends no command and changes no selection (guard `ListenerIsReadOnly_AndRemovedOnShutdown` pins this and that every event is removed). Marks run only on AutoCAD's own thread. `Plugin.cs` gains exactly two lines: subscribe after the log starts, unsubscribe at shutdown; the Plugin.cs fingerprint re-pin is commented and the guard passes.
6. **#1547, a command that throws:** AutoCAD's command-failed event writes "failed"; the CE catch blocks also mark failed (or cancelled for an Esc), and a failed mark always wins over completed.
7. **#1533 against its review (`REVIEW_CODEX_PRS_B_2026-10-23.md` section 7, "MERGE as is"): agreed, after reading the diff myself.**
   1. **Decimals:** `NormalizeUcUbWholeNumbers` (which rounded 25.7 to 26) is replaced by a spacing-only rule that keeps every digit. The member-protection pattern now also protects "250UB25.7" with no "x", so the abbreviation expander cannot touch it.
   2. **Against the supplier tables:** every UB and UC in the tests is a real AS/NZS 3679.1 designation (250UB25.7, 410UB59.7, 310UB32.0, 360UB56.7, 200UB29.8, 250UC89.5, 250UC72.9, 310UC96.8). The angle family comes from CE's own `section-catalogue.json`: 38 EA sizes (40x40x3 to 200x200x26) and 18 UA sizes (65x50x5 to 150x100x12), including 150x90x10UA and 150x100x10UA. A size not in the catalogue is called EA when both legs are equal, UA when not; no size is invented.
   3. **Millimetre and metre drawings:** the change is to the label wording only; the text height and placement code is untouched, so both behave as before.
   4. **Protection, U and REDO:** no change to how the text is written (same transaction path, no new system variable or command), so locked layers, Xrefs and REFEDIT are handled exactly as before and U / REDO are unchanged.
   5. **LOW 1 (symbol before the size stays as typed) stands; listed in 7.1 for the robot.**
8. **No command added or removed:** `Plugin.cs` +2 lines (the subscribe pair, no `CommandMethod` or `CommandClass`), no `[CommandMethod]` added or removed in the diff, no command register or `PackageContents.xml` changed. CommandTruth still counts 395 Structural commands, as S-40 and S-41.

## 2. New defaults judged

1. **`options.commandOutcomeLines` (Civil's, reused), default ON in the merged code: kept ON.** An old settings file with the key missing reads ON (`if (flag == null) return Default;`, test case `{"options":{}}` gives true); a missing file reads ON; an unreadable file reads OFF so an explicit OFF is never defeated. It does not change anything Tim sees in a drawing or at the command line: it adds one line to the CE log, a diagnostic aid for the desk. The old behaviour (no line at all for a Structural command, AUDIT_C58_C60) is the defect. ON is acceptable on Tim's PC.
2. **#1533: no switch, no Settings value.** The old wording is itself the bug (wrong section names).
3. **Nothing turned OFF by me; no default changed by me.**

## 3. Installer and update safety

1. **Signed-update gate (`OfficialReleaseGate`):** the train touches nothing under `Shared`, `Installer`, `CE.Host`, Manager or Civil. It cannot change the gate.
2. **Installer command-ownership check (`SafeBundleInstaller.VerifyCommandOwnership`):** it reads the `<Command>` entries of each bundle's `PackageContents.xml`. No `PackageContents.xml` changed, no command register changed, and `Plugin.cs` changed only by the two listener lines. No command is added or removed. The check sees nothing new.

## 4. Test evidence

1. **Environment:** worktree `C:\ce-fin\s42`, Release, `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs` (as the assembly report), AutoCAD 2027 first on PATH, own `TEMP` and `CE_LOG_DIR_OVERRIDE` under `C:\ce-fin\s42x`, Below Normal, every command in the foreground.
2. **Build lock:** `C:\CE_PLAN\desk_jobs\build.lock` was absent at 09:54, then held by other jobs' numbers (325647, 105828, 108052, 327033 and others) at every one of my 62 commands. I never took it and never deleted it; every build and test ran in my own worktree with my own TEMP.
3. **Build method (as S-41):** solution restore with `EnableUnifiedHostAdapters=true`; Structural standalone restore and build (0 errors, 4 warnings), copied to `bin\Release`; restore again; whole solution with `EnableUnifiedHostAdapters=true -m:1`: 0 errors, 927 warnings, 3 min 26 s.
4. **Structural chunks:** class names read from every test file with a test in it (510 names including helpers; the hanging `SbeamEditAutoCadEvidenceReaderTests` left out), 17 chunks of 30, each filter `FullyQualifiedName~.Name.` (exact class, so no class is counted twice), plus the nested filter. Net10: 289, 386, 216, 213, 407, 189, 200, 185, 404, 309, 312, 413, 507, 317, 312, 313, 725, 7 = 5,704, 0 failed. Net48 failures per chunk: 3, 10, 3, 0, 2, 0, 6, 0, 0, 1, 0, 0, 12, 0, 2, 0, 0, 0 = 39.
5. **Base comparison:** S-41 base `2c9a9694` built (Structural.Tests net48, 0 errors) and run with the same chunk lists: 4,471 passed, 39 failed, 698 not run (5,208). The 39 failed names are identical to the train's. They are the standing AutoCAD-stub and reference-drift reds (brace, move-repair, `ProductionSectionMatrix...`, `ZcOutline_*`, `ZcProductionVertexBuilder...`, `SegmentIntersectsRect_*`, `ManagedPublicApiAndReferences_MatchAcceptedBase` and so on). The train adds 490 tests on net48 (5,698 against 5,208), all passing.
6. **Not run:** Structural net8 tests (built only, as S-39 to S-41), the Sbeam evidence class (hangs), DesignCore with release settings set, Drainage, Manager, Installer.Tests, anything in AutoCAD or accoreconsole.
7. **Pictures:** test runs rewrote 76 files under `docs/image/V3_WINDOWS` in my worktree; nothing committed, the worktree was removed.
8. **Cleanup:** both worktrees removed (`git worktree remove --force`, folders deleted, `git worktree prune`), `C:\ce-fin\s42x` (scripts, logs, TEMP) deleted. The main checkout's state is unchanged from the start.

## 5. For the desk

1. **Codex in AutoCAD (copies only), after install:** the two checks in ANSWER FIRST item 7. Change the outcome tick only with AutoCAD closed (CE reads settings at start).
2. **Carpark candidates (LOW):** a Structural Settings row for the outcome switch, only if Structural ever ships without Civil; XCLMTXT "L ]L" before the size (robot row).
3. **Carryover:** version field still 1.0.121 (the payload builder bumps it); the CommandTruth drift (301 expected, 395 found) and the 39 net48 stub reds are standing.
