# S-45 Opus finalizer: Structural train claude/rel-20261026s

Independent review of the six round-2 Structural PRs the assembler merged on top of S-44 (`claude/rel-20261025s` at `3a3caac5`, Structural 1.0.124, the installed Structural line). Tue 27 Oct 2026, 03:45 to about 05:10 Melbourne time (PC clock; inside Tim's free window). Opus 5.5, Team, headless, desk plan/03. Private worktrees `C:\ce-fin\s45` (train), `C:\ce-fin\s45b` (bare base) and `C:\ce-fin\s45r` (release build), all removed. I did not start AutoCAD or accoreconsole, deployed nothing, changed no version field, closed no PR, deleted no branch, changed no PR base, merged no Civil or Manager PR, marked no bug FIXED, did not edit DESK_LOG.md or BUG_CARPARK.md.

## ANSWER FIRST

1. **GO at `b721a445b0b8c5f930868212e1a32face2eaa969`.**
2. **Branch `claude/rel-20261026s`.** Start head `90f2688e09df98dbb4d86492f3316c9822e5e7da` (`git ls-remote` at 03:45, equal to the assembly report). Final head `b721a445` after a normal fast-forward push of my two commits (leak scan clean, 36 terms). All six PR heads read live on GitHub at about 04:55 still equal the merged heads; all six are open, base `claude/rel-20261025s`.
3. **What I changed (two commits, each with a REGRESSION_LOG entry):**
   1. **`8be5beec`: #1794 DROPPED from S-45** with a visible `git revert -m 1 523af5ba` (the train's merge of #1794). The only conflict was the log; I removed exactly #1794's 23 log lines (checked identical to what its merge added) and kept every other entry. MarkupAI is back to installed 1.0.124 behaviour. The PR is open and untouched.
   2. **`b721a445`: tests only.** `S45NewSwitchDefaultsTests` (4): the three remaining new switches load at their defaults from a blank file, from a 1.0.124-shaped file without the keys (with an existing FootingWidth and Diagnostics group), and from a file with one bad value (the value-by-value read); values a drafter typed stay as typed.
4. **Verdicts (6 PRs reviewed; 5 kept, 1 dropped; no other PR in the train):**
   1. **#1792 (BUG-503 S-13, FADOPT raft EB label): MERGE.** All three review fixes are in: the nearer of the IB and EB label is used when the switch is ON (`TryFindBestBeamLabel`), the question reads exactly "Some beam lines in this raft have no label. Are they External or Internal beams? [External/Internal] <Internal>:", the switch ships ON with `{}` and OFF tests. Escape at the question leaves before the adoption is committed and says "Nothing was adopted." **Agree with Codex (cx_rv19, MERGE).**
   2. **#1793 (BUG-530, old pad with no size): MERGE.** Ships ON, the warning says "mm" and FEDIT, it shows in FST. It only adds a warning: the pad is drawn exactly as before at the 600 mm placeholder. The warning is cleared and rebuilt on every redraw, so it never piles up. **Agree with Codex (MERGE, warning-only part of BUG-530; BUG-530 itself is not finished).**
   3. **#1794 (BUG-550/557, MarkupAI switch): HOLD, dropped.** I confirmed Codex's first reason by reading: with "Enable MarkupAI" unticked, a markup review window that is already open still applies markup to the drawing ("Run next" in `MarkupAIPanel.xaml.cs` line 263 calls the same work as CEMARKUPRUN, with no switch check). Codex's second reason is also true: CEMARKUPUNDO sends a plain AutoCAD U and does not check that the last change was a markup change (an older fault, on the base too, but the desk asked for that assurance before it ships). **Agree with Codex (cx_rv20, HOLD).** It needs: the switch checked where the window's buttons do their work, and a markup undo that only takes back its own markup change (cx_rv20 fixes 1 and 2), then a fresh review. **List it for the next Structural train.**
   4. **#1795 (BUG-519, start-up line): MERGE.** `Plugin.cs` changes only the start-up message: one `using` line, the 43 old `WriteMessage` lines removed, the banner printed instead. No command, ribbon, event, mutex or registration line changed. The banner is printed after the ribbon and commands are set up, inside the existing start-up error catch, so it cannot stop or delay AutoCAD loading. The "full list" switch brings back a shorter, corrected list of 23 lines (not the old 44 word for word). CE_VERSION is out. **Agree with Codex (cx_rv20, MERGE).**
   5. **#1796 (BUG-503 S-15, plain words): MERGE.** The three reviewed sentences word for word; each is true against the code (CSGENNOTES and CSBRACINGREQUIRED exist and do what the sentence says). The STRSCHEDREFRESH line "Nothing was changed" is true: the table update is one drawing change that is thrown away on any error. **Agree with Codex (cx_rv21, MERGE).**
   6. **#1797 (BUG-453, off commands): MERGE.** Five message lines changed, one line per file, nothing else; the lintel and roof point-load lines read as plurals. **Agree with Codex (cx_rv21, MERGE).**
5. **Defaults (read from the merged code, pinned by my test):**
   1. **`FootingWidth.AdoptAsksUnlabelledBeamKind` ON, kept ON.** An old file without the key loads ON. It changes what Tim sees: FADOPT Raft asks one question when beam lines have no label, and an EB label now counts as External. The old behaviour (every unlabelled and every EB-labelled raft beam quietly made Internal) is the logged bug.
   2. **`FootingWidth.UnknownPadSizeIsNotInvented` ON, kept ON.** Old file loads ON. It only adds an FST warning; the old silence is the bug.
   3. **`Diagnostics.ShowFullStartupList` OFF, kept OFF.** Old file loads OFF. OFF is the fix (one line); the long list was the bug.
   4. **MarkupAI (`Enabled`, `LearningDataOptIn`): no change in this train** (#1794 dropped). A new PC still starts with "Share learning data" ticked, exactly as installed 1.0.124. Nothing leaves the PC either way (the off-PC send is always refused).
6. **Tests at the final head `b721a445` (Release, -p:SkipDevBundle=true -nr:false --disable-build-servers):**
   1. **Structural net10 full suite: 5,981 passed, 0 failed** (469 classes in 16 chunks of 30 plus the 7 nested-class tests, `SbeamEditAutoCadEvidenceReaderTests` left out, 5-minute hang guard on every chunk). S-44 gave 5,923: **+58** = the five kept PRs' new classes (`AdoptBeamKindAskTests`, `UnknownPadSizeTests`, `StartupBannerTests`, `StructuralPlainWordsTests`, `OffEngineWordingTests`, 54 tests) plus my 4. No chunk went quiet; the slowest took 4.5 minutes.
   2. **Structural net48: 5,218 passed, 53 failed, 704 not run.** I built the bare base `3a3caac5` and ran the same chunks: **the same 53 failing names, name for name, on the base** (52 are the AutoCAD-stub `InvalidProgramException` family; the 53rd is the standing `ManagedPublicApiAndReferences_MatchAcceptedBase`). These are S-44's 39 standing names plus its 14 stub-only tests. **No new red. None of the new tests fails on net48.**
   3. **The Structural full-suite stall, placed:** the class left out, `SbeamEditAutoCadEvidenceReaderTests`, **hangs on the bare S-44 base too**, identically: 116 tests pass, then `CompiledProductionRoute_R10EveryUnsignedOpcodeHonoursAllInt64Boundaries("Bne_Un")` goes quiet for 5 minutes and the hang guard stops it. Same test, same count, on train and base. It is not caused by this train, and it is very likely what stalled the 26 Oct full run (a run that does not leave that class out).
   4. **Whole solution Release: 0 errors.** Standalone Structural build on all three lanes (net48, net8, net10): 0 errors, each DLL stamped `1.0.124+b721a445...`.
   5. **DesignCore: 2,207 per lane on net48, net8 and net10** (2,202 passed, 5 failed per lane), the same five names: `HostedAndStandaloneModernOutputs_AreIsolatedAndCompileOppositeRuntimeContracts`, `LoadOrder_CannotBindStandaloneStructuralToCeShared` x2, `StandaloneReleaseLanes_HaveNoCeSharedDependencyOrPayload`, `StandaloneReleaseLanes_KeepCommandClassesAndSbeam_LeaveCeVersionToManager`.
   6. **CE.CommandTruth.Tests: 22 of 23.** The one red is the standing `Structural_KnownRegistryDriftRemainsPinnedBacklog`; **drift 395 did not move** (no command added or removed).
   7. **Structural.ReleaseTests: 10 of 10 on net48, net8 and net10.**
   8. **Settings-fit and window guards (net10): 23 of 23** (`StructuralSettingsFitAt150Tests`, `IssuePreviewSettingsRowTests`, `AutoCadWindowHostScrollTests`, `AutoCadWindowHostMathTests`, `AutoCadWindowHostGuardTests`, `UncitedEngineeringTablesGuardTests`). No PR touches the Settings window markup; the window did not change.
   9. **Focused (net10): 82 of 82** (the five new classes, my class, `S44NewSwitchDefaultsTests`, `Stage3ConnectedDesignBoundaryTests`).
7. **Official release build RUN (the existing `build_installer.ps1`, three-lane, from `Q:` via subst, `-ReleaseCandidateRoot C:\ce_rc_scratch\s45fin -ReleaseCandidateId s45fin01`, the S1042 reference values): EXIT 0, 0 errors**, "Complete three-lane unsigned release candidate verified". **`struc: manifest 2007 files, verified 2007, bad 0, extra 0`.** Against installed 1.0.124 (read only): **added 0, removed 0**; changed = the three main DLLs, the three DesignCore DLLs (version stamp) and the freshly built native ARX (the payload builder copies the installed ARX bytes over it, as for S-44). `command-registry.json` and `PackageContents.xml` identical to installed. Scratch candidate deleted.
8. **What Tim will see in AutoCAD after this train is installed:**
   1. **FADOPT Raft:** if beam lines on the raft have no label, CE asks once "Some beam lines in this raft have no label. Are they External or Internal beams?". Enter keeps Internal (today's answer); Escape stops with "Adoption cancelled at the beam question. Nothing was adopted." A line next to an EB label is now taken as an External beam without asking.
   2. **FREGEN on an old pad with no recorded size:** the pad looks the same (600 square); FST now lists "PF3: size not recorded. Drawn at the 600 mm placeholder size. Set its size with FEDIT."
   3. **AutoCAD start:** one line, "[CE_STRUC_SUITE] CE Structural 1.0.125 loaded. Type CE_HELP, or click the CE Struc ribbon tab.", instead of about 44 lines.
   4. **CSSOILREPORT, CSWINDCLASS:** plain sentences naming CSGENNOTES and CSBRACINGREQUIRED. **STRSCHEDREFRESH** on a schedule on a locked layer: "The schedule's layer is locked, so the schedule was not updated. Nothing was changed. Unlock the layer and run it again."
   5. **CSROOFSETOUT, CSFLOORSETOUT, CSLEVELCARRY, CSLINTELPROPOSE, CSPOINTLOAD (still off):** "... is not switched on yet, so nothing was drawn. It is still being tested; CE switches it on ... once it is approved." (plural for the lintel and point-load lines).
   6. **Markup tools: unchanged** from today.
9. **Do not mark FIXED.** Each needs a robot PASS plus a Codex PASS in AutoCAD on copies (steps in section 5): BUG-503 S-13, BUG-530 (and it stays open: the placeholder pad is still drawn), BUG-519, BUG-503 S-15, BUG-453. **BUG-550 and BUG-557 are not in this train** (stay open with #1794).
10. **Four words:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD.

## 1. Review method and merge integrity

1. **Each merge diff** (`git diff <merge>^1 <merge>`) read in full and compared with the PR's file list: equal for all six; `<merge>^2` equals the live head for all six.
2. **Scope:** the 22 files the final train changes are all under `Modules/Structural*` plus `REGRESSION_LOG.md`. Nothing under `Shared/`, `Installer/`, `CE.Host`, `Modules/Drainage*`, `Modules/Manager*` or `Assets/`; `command-registry.json` and `PackageContents.xml` unchanged; no `[CommandMethod]`, `CommandClass` or `LispFunction` line added or removed.
3. **Files touched by two PRs:** `FoundationService.cs` (#1792 adoption block and helpers, #1793 redraw warning: separate places, both present); `UserSettings.cs` (#1792 and #1793 switches next to each other, each with its own summary; #1795 in the Diagnostics group); all three switches present.
4. **REGRESSION_LOG.md:** every line each kept PR added is present (0 missing for #1792, #1793, #1795, #1796, #1797 and the assembler's pin entry), no conflict marker, a blank line before every heading in the train's part. Net +138 lines against the base. Note: only #1797's and the pin entry have an "Undo" line; the other PRs' entries never had one (their text is intact).
5. **Each new test against the base (by reading, not run there):** `AdoptBeamKindAskTests`, `UnknownPadSizeTests`, `StartupBannerTests`, `StructuralPlainWordsTests` and my `S45NewSwitchDefaultsTests` use types or settings that do not exist on the base, so they cannot compile there; `OffEngineWordingTests` reads the five source lines and would fail on the base ("still to be built").
6. **Per PR, AutoCAD paths:**
   1. **#1792:** Escape or Cancel at the question breaks the line loop, prints the cancel line, forgets the cached footing register and leaves before `tr.Commit()`; nothing is written. Enter gives Internal. One answer is used for every unlabelled line of the run. A completed adoption is one command, so one U takes back the whole result (no change to how the command starts or ends its drawing change). Metre drawings: the label reach and the nearer-label comparison are both in drawing units, so unit-safe.
   2. **#1793:** adds a warning line to the redraw's issue list only; no new drawing write. In a metre drawing the pad is drawn at 600 x (units per mm) as before and the note still says "600 mm", which is right.
   3. **#1795, #1796, #1797:** text only; no prompt, drawing write or protection change.
   4. **Locked layers, Xrefs, REFEDIT:** no added line unlocks, thaws, detaches or edits a reference. Older gap noted by Codex (not caused by this train): FADOPT and FREGEN are not in the REFEDIT check list (`LayoutCheckFirstFootingCommands`). For the desk.

## 2. Redo safety (U and REDO)

1. **Whole final train diff scanned** (added `.cs` lines, product and test) for `SetCurrentView`, `SetSystemVariable`, `SendStringToExecute`, `Regen`, UCS, `+=`, `-=`, Idle, `DocumentManager`, timers, window `Loaded`/`SizeChanged`/`Closing`, `StartTransaction`, `Commit`, mutexes and waits. **Hits:** one `GetKeywords` (#1792's question, inside FADOPT's own command, before its existing commit); four comment or text lines containing "Regenerate". Nothing else.
2. **No added line can clear the redo list.** Nothing sets a system variable, the view or the UCS; no event, idle or timer hook; no command's transaction start or end changed. (#1794's eleven switch checks would also have been harmless, but they are reverted.)

## 3. Installer and update safety

1. **Signed-update gate (`OfficialReleaseGate`) and command-ownership check (`SafeBundleInstaller.VerifyCommandOwnership`): the train cannot affect either.** No file under `Shared`, `Installer`, `CE.Host`, Manager or Civil; `Plugin.cs` changes only the start-up message; the command register and `PackageContents.xml` unchanged; CommandTruth drift still 395.
2. **Bundle: 2007 files, verified 2007, bad 0, extra 0; added 0, removed 0** against installed 1.0.124 (ANSWER FIRST 7). The new source files compile into the existing DLLs.

## 4. Settings page

1. **Values and switches without a Settings page row (no rows built):** the three new switches `FootingWidth.AdoptAsksUnlabelledBeamKind`, `FootingWidth.UnknownPadSizeIsNotInvented`, `Diagnostics.ShowFullStartupList` (no window tick and no recovery label either; nothing breaks without a label). Carried from S-44: the five S-44 switches, `Layouts.HatchDensityFollowsPaper`, `Layouts.TagTextFollowsLabelHeight`, `Layouts.FollowAnyDrawingScale`, the CeMember group.
2. **Settings window:** unchanged (no XAML in the train); `StructuralSettingsFitAt150Tests` passes. That is a test, not a look.

## 5. Codex checks in AutoCAD (copies only, after install of 1.0.125)

1. **BUG-503 S-13 (FADOPT raft):** on a copy, a raft outline with three beam lines on the raft draft layer: one with an "EB" label beside it, one with an "IB" label, one with no label. FADOPT Raft. Expect one question "Some beam lines in this raft have no label. Are they External or Internal beams? [External/Internal] <Internal>:"; type E. Check in the footing manager: EB line External, IB line Internal, the unlabelled line External. U once: the whole adoption gone. Run again and press Escape at the question: "Adoption cancelled at the beam question. Nothing was adopted.", drawing unchanged. Once in a metre drawing.
2. **BUG-530 (old pad, no size):** an older job with a pad that has no recorded size and no closed outline of its own. FREGEN: a 600 square is drawn; FST lists "PF3: size not recorded. Drawn at the 600 mm placeholder size. Set its size with FEDIT." FREGEN again: still one such line. U once after FREGEN.
3. **BUG-519 (start-up):** start AutoCAD: one CE Structural line, ribbon tab present, CE_HELP works. With AutoCAD closed, set `Diagnostics.ShowFullStartupList` to true in `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json`, start again: the 23-line list. Set it back.
4. **BUG-503 S-15:** CSSOILREPORT and CSWINDCLASS (confirm): read the plain lines. Lock the layer of a bracing schedule, STRSCHEDREFRESH, pick it: the locked-layer line; the table and the lock unchanged.
5. **BUG-453:** type CSROOFSETOUT, CSFLOORSETOUT, CSLEVELCARRY, CSLINTELPROPOSE, CSPOINTLOAD: each says "not switched on yet, so nothing was drawn/placed"; the lintel and point-load lines are plural; nothing drawn.

## 6. Risks and carry-over

1. **#1794 (BUG-550/557)** out of S-45, needs cx_rv20 fixes 1 and 2 and a fresh review. Until then "Enable MarkupAI" still does nothing and "Share learning data" still starts ticked on a new PC (as today).
2. **FADOPT with the switch OFF** still files every EB-labelled raft edge as Internal (carried from the review; for the desk).
3. **REFEDIT:** FADOPT and FREGEN have no REFEDIT check (older gap, Codex cx_rv19 2.6; for the desk).
4. **BUG-530 is not finished:** the plan still shows a 600 square nobody entered; a visible "SIZE NOT RECORDED" tag needs Tim's ruling.
5. **The Sbeam evidence hang** (`CompiledProductionRoute_R10EveryUnsignedOpcodeHonoursAllInt64Boundaries("Bne_Un")`) is on the base too; any "full suite" run must leave that class out or it stalls. Carpark candidate for the desk.
6. **Base net48 count:** my bare-base net48 run counted 5,916 tests, one fewer than the S-44 report's 5,917 for the same code; the train's count (5,975) matches the assembler's exactly, and the failing names are identical, so this is a counting difference in the base run, not a code difference. Not chased.

## 7. Method, environment and slips

1. **References:** `_AcadRefNet8` = `C:\TimOS\refs\autocad\autocad-2026-ref`, `_AcadRef48` = `C:\Autodesk\CERef\AutoCAD2024-24.3.0\refs`, AutoCAD 2027 first on PATH; restore with `EnableUnifiedHostAdapters=true`; standalone build with `=false`, copied into `bin\Release`; forced restore; whole solution `-m:1`. Release build with the S1042 values (`autocad-2024-ref`, `autocad-2026-ref`, `C:\Program Files\Autodesk\AutoCAD 2027`).
2. **Priority, say it plainly:** tests ran at Below Normal. The standalone build started at Below Normal and crawled when another job's build started at 04:02 (22 minutes in all); I raised my own build processes to Normal at about 04:14, and ran the solution, base and release builds at Normal. Outside Tim's AutoCAD hours.
3. **AutoCAD:** none at my start (03:50). An AutoCAD 2027 (`acad.exe`, plain launch, not mine) ran from 04:09 and had closed by 05:01. **Tim's four settings files unchanged** from 03:50 to 05:01 (SHA-256 first 8, size): `TIM_CE_CADTOOLS\CD_Settings.json` `acd64e79` 15,270; `TIM_CE_CADTOOLS\CS_Settings.json` `622a246f` 351,713; `CE_STRUC_SUITE\CS_Settings.json` `0791b07e` 35,467; `CE_CVL_SUITE\settings.json` `efe307c4` 672.
4. **Build lock:** taken as a folder only while a command of mine ran; when it was present (my own parallel run held it) the other run went ahead in its own worktree with its own TEMP. It does not exist now.
5. **Disk:** C: 39 GB free at the start, 37 GB at the end (stop line 8 GB).
6. **Slips (cost minutes, no harm):** two scratch-script launches failed at once (`pwsh` and `subst` not on the tool's PATH); a `sed` edit mangled backslashes in my scratch release script, fixed with the editor before it ran.
7. **Cleanup:** worktrees `s45`, `s45b`, `s45r` removed (`git worktree remove --force`, prune), `Q:` unmapped (subst list empty), scratch candidate `C:\ce_rc_scratch\s45fin` and scratch `C:\ce-fin\s45x` deleted (hang dumps included). The local helper branch `fin-s45` in the shared clone stays (nothing deleted). Window PNGs regenerated by the tests were never committed. The main checkout shows the same five old untracked entries as S-44 reported.
8. **Installed Structural** still reads `1.0.124+3a3caac5...` in all three lanes, 2007 files.

## 8. What I did NOT test

1. Anything in AutoCAD; no window looked at.
2. Structural net8 tests (built only); Drainage, Manager, Installer.Tests (Installer.Tests compiled in the solution only).
3. The new tests run on the base (by reading only, section 1.5); the base net10 suite (only the Sbeam class on the base).
4. The Sbeam evidence class beyond its first 116 tests (it hangs on train and base).
5. The payload strings proof (the payload builder's job), and no version bump (Structural 1.0.125 is the payload builder's).

## Summary

GO at `b721a445` on `claude/rel-20261026s`. Five PRs kept (#1792, #1793, #1795, #1796, #1797), #1794 dropped by a visible revert (agreeing with Codex: an open markup window ignores the switch). One test commit pins the three new switches. net10 5,981 passed, 0 failed; net48 the same 53 names as the bare base; DesignCore, CommandTruth (drift 395), ReleaseTests unchanged; release build 2007 files, added 0, removed 0. The Sbeam evidence hang is on the base too. Built and tested only; not installed.
