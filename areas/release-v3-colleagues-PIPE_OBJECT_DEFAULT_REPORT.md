# B-046: one-piece pipe object on for every login (report, Thu 29 Oct 2026, CE 01 Build)

## FOR TIM

1. **Answer:** built as a DRAFT, PR #1846 (`fb/pipe-object-on-for-everyone`, against `claude/rel-20261026z`). With CE's "Upgrade pipes" setting left on Automatic, every Windows login on AutoCAD 2027 now draws the one-piece pipe, not just yours. Max's login will get it.
2. **What a drafter sees differently:** on Max's PC, CD draws a one-piece CE pipe, opening a job upgrades its pipes, and CDPIPEOBJ and CDC7UPGRADE work. Before, they got ordinary polylines and the line "Pipe upgrade is held on this PC until it is proven on AutoCAD 2022-2024."
3. **Your question: is any existing setting edited?** No. Nobody's settings file is changed. A file that says Automatic (yours, Max's, a colleague's) now simply reads as On. Anyone who picks Off on the Settings page keeps Off. Anyone who picks On keeps On.
4. **How to switch it back:** one new setting, `options.pipeObjectAutomaticIsOnForEveryone`, ships ON. Setting it to false gives back exactly the old rule (Automatic on only for your login).
5. **AutoCAD 2022 to 2024 PCs:** nothing changes. The one-piece pipe lives in the 2027 add-on and cannot load there, so they keep ordinary pipes. CE already checks that first on every path.
6. **Built, tested, installed, accepted:** built and unit-tested. Not installed. Nobody has opened it in AutoCAD. B-046 is not marked fixed.
7. **Mistakes of my own:** (a) I first dropped an edit script into the shared C:\ce-fx folder and removed it straight away (it was mine, nothing else touched). (b) My first test run failed on one of my own new tests (a null-settings test); fixed and re-run. (c) A shell edit mangled a backslash path in my run script; no effect on the product.
8. **What is NOT proven:** anything in AutoCAD. The unit tests prove the decision (Tim's login, another login, no login; Automatic, On, Off; new switch on and off). They do not prove that CD then draws a one-piece pipe on a clean non-Tim install. That is the robot case below.
9. **Clash with PR #1844 (F023 colleague defaults):** the code does not clash (`UserSettings.cs` merges cleanly). Only `REGRESSION_LOG.md` conflicts, and the fix is to keep both entries. Its two robot cases F23s and F23x change meaning (see section 3 below).

---

## TECHNICAL DETAIL

## 1. Entry point and cause

1. **Cause:** `Modules/Drainage/Services/NativeObjects/PipeObjectUpgradeGate.cs`, `Resolve`: the default branch for Automatic returned `IsTestBedAccount(accountSid)`, a fixed Windows identifier (Tim's AzureAD sign-in). `IsUpgradeAllowed` is the one question every path asks (CDPIPEOBJ, CDC7UPGRADE, the open-a-job pass, CD's new pipe, split halves, the legacy migration; `CeCvlObjectsBridge` doors, `PipeObjectUpgradeService`, `PipeCreationService:591`).
2. **The 2027-only rule is not in the gate.** It is `CeCvlObjectsBridge.IsAvailable` (the enabler `CE_CVL_OBJECTS_2027.dbx`, loaded from the Modern folder). The open-a-job pass checks it before it asks the gate (`PipeObjectUpgradeService.UpgradeDrawing`), `OnDocumentCreated` only queues a drawing when it is true, and the three bridge doors answer "The CE pipe object enabler is not loaded (AutoCAD 2027 only)." On 2022 to 2024 nothing is created, so ordinary pipes stay. Kept unchanged and pinned by a source test.
3. **Settings page:** the row is Settings > Advanced > "ONE-PIECE PIPES" > "Upgrade pipes" (Automatic, On, Off). I changed two sentences that said "only the CE test PC": the Automatic tooltip and the hint line. The one-line "On this PC:" sentence and the start-up `[C7]` log line now say which way it went (`... options.pipeObjectAutomaticIsOnForEveryone on`). The new switch itself has no Settings-page row (the other recent R-27 switches, `pipe.editPipeReverseArrowReadsDrawnEnds` and `linking.sourcePickComparesPipeRecordLikeForLike`, have none either).

## 2. What changed (commit 23e63061)

1. `PipeObjectUpgradeGate.cs`: new `Resolve(storedMode, sid, automaticIsOnForEveryone)`; the old two-argument `Resolve` is kept and equals the new one with the switch OFF; new `AutomaticIsOnForEveryone()` (unreadable Settings reads ON); `IsUpgradeAllowed`, `DescribeForThisPc`, `DescribeForLog` use it.
2. `Models/UserSettings.cs`: `OptionSettings.PipeObjectAutomaticIsOnForEveryone`, JSON key `pipeObjectAutomaticIsOnForEveryone`, "Default: on."
3. `Dialogs/AdvancedSettingsDialog.xaml`: two sentences.
4. Tests: new `Services/B046PipeObjectOnForEveryoneTests.cs` (90 tests: the default through both start-up reads `DeserializeSettings` and `DeserializeSettingsTolerant`, four file shapes; typed false through both reads; the stored word never rewritten; a 40-row grid of five words by four sign-ins (Tim, other, missing, blank) by switch ON and OFF, once through the pure rule and once through the real gate with a test sign-in; OFF equals the old two-argument rule over every word and sign-in; the old "held until it is proven on AutoCAD 2022-2024" sentence word for word with the switch OFF; unreadable Settings reads ON; source guards: the gate does no drawing work, the 2027 checks still stand). `PipeObjectUpgradeHoldTests` and `SettingsWindowV3Tests` now set the switch OFF, because they pin the 26 Sep wording.
5. `REGRESSION_LOG.md`: entry at the top. CE_SHARED, Manager, Structural untouched. Redo-safe: the gate reads Settings and the Windows account and does nothing else; no new write, command, regen, view or system variable change. Locked layers, Xrefs and REFEDIT are not touched; the upgrade paths it opens for more logins are the existing ones with their own protection.

## 3. Which robot cases and Codex looks change meaning

1. **The 20 cases in `TEST_PC_2027_ROUTE_29OCT.md` section 3 that name the pipe object:** N06, N17, N18, N19, N20, N23, N28, R01, R02, R02b, R17, R19, R19b, R20, R23, R31, R32, R32b, R39, R39b. On a non-Tim login they previously read differently (ordinary polylines on Automatic). With this build they behave as on Tim's PC with no per-PC set-up, so the section 3 recommendation (set On by hand on the test PC, plus a separate Automatic pass) is no longer needed: one pass on Automatic is the Max experience and the Tim-comparable one. They still need the 2027 add-on loaded.
2. **F023 cases from PR #1844 (`release-v3-colleagues-F023_BUILD_REPORT.md`):** F23s (switch-off control, expects `held (setting Automatic; ...` on the `[C7]` line) and F23x (existing profile, expects `held` on a non-Tim login) read `allowed` once this PR is in. Their intent (the shipped file never overrides an existing file) is still checkable through `'OSMODE` echo 5247, but their `[C7]` held check must be dropped or re-pointed (set `options.pipeObjectAutomaticIsOnForEveryone` false in the F23x profile to keep it).
3. **Codex looks:** any look that was held back because a non-Tim login "would get ordinary pipes" now gets one-piece pipes on Automatic. I did not open the queue to list them; CE 02 owns it.
4. **Test PC set-up:** the "set pipe upgrade to On by hand" step is not needed.

## 4. Robot case for CE 02 (with switch-off control)

1. **Case `B46_pipe_default_other_login` (proof):** clean install of the build carrying this PR, AutoCAD 2027, an ordinary non-Tim Windows login, `CD_Settings.json` absent or with `options.pipeObjectUpgrade` "Automatic" and no `pipeObjectAutomaticIsOnForEveryone` key. It types `CD`, picks two points and a pipe size to draw one pipe, then types `CDC7UPGRADE`. Checks: (a) the CE log start-up line contains `pipe upgrade on this PC: allowed (setting Automatic; this Windows sign-in is not the CE test-bed account; options.pipeObjectAutomaticIsOnForEveryone on)`; (b) the drawn pipe is the one-piece CE pipe object, not an LWPOLYLINE (read it the same way the existing N17 case reads a pipe object; I have not looked at how N17 reads it); (c) the command line does NOT contain `Pipe upgrade is held on this PC`.
2. **Control `B46x_pipe_default_switch_off`:** the same, but `options.pipeObjectAutomaticIsOnForEveryone` is false in that profile's settings file. Checks: the log line says `held (setting Automatic; ... pipeObjectAutomaticIsOnForEveryone off)`, the drawn pipe is an ordinary polyline, and `CDC7UPGRADE` prints exactly `[CE] Pipe upgrade is held on this PC until it is proven on AutoCAD 2022-2024.`
3. **Second control `B46y_pipe_explicit_off`:** switch on (default), `options.pipeObjectUpgrade` "Off": ordinary polyline and the held line. Shows a drafter can still switch it off.
4. **Hazard:** the profile is the robot's own on its test PC. Never Tim's settings file.

## 5. Evidence

1. **Focused, Civil net10, Release:** B046 90 of 90 passed (single class run); the first focused run of 193 tests across the gate, Settings window, C75 switch defaults, C7 draw-time and split classes had 1 failure, my own null-settings test, fixed.
2. **Full Civil net10 suite:** Total 20,896, Passed 20,864, Skipped 32, Failed 0 (10 m 25 s). The count is not 0. The PDF page test passed in the full run (no separate re-run needed).
3. **net48 compile of `CE_CVL_SUITE.csproj`:** 0 errors, 242 warnings.
4. **Environment:** worktree `C:\ce-fx\bpipedef`, Release, `-p:SkipDevBundle=true -nr:false --disable-build-servers`, below normal priority, free-slot check before each dotnet command, AutoCAD 2027 on PATH, a 0-byte placeholder arx (untracked), per-run CE log folder. No deploy; nothing under Tim's settings, bundles or ProgramData touched; AutoCAD not started.
5. **Not tested:** anything in AutoCAD; Structural and Manager suites (no change there); Settings window picture; a 2022 to 2024 PC.

## 6. Open points for the desk

1. **PR #1844:** merge order does not matter for the code. Whoever merges second keeps both `REGRESSION_LOG.md` entries. Its shipped colleague-defaults file already says `pipeObjectUpgrade` "On", which is now redundant but harmless.
2. **Existing files that say Automatic now read On** (stated in FOR TIM item 3): this is the deliberate meaning of Tim's "default on for everyone". Recorded here for the re-test rule (decision 35): re-test what the fix touches, that is the pipe-object cases in section 3.
3. B-046 stays open (D6).
