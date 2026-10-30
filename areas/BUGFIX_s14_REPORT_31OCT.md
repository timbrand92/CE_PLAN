# BUGFIX s14 report: Structural batch S-14 (Sat 31 Oct 2026)

## ANSWER FIRST

1. **PR:** #1911 (draft, against claude/rel-20261026s), title starts B-090 (register item 148). It covers one part of BUG-536 only.
2. **BUG-470: ALREADY FIXED, no PR.** Fixed by commit 987ca9dd "HUNT-S-05: FSF refuses CE's own outline as a new centre line" (9 Oct). Code: `Services/FoundationService.cs` line 3912 (`RefuseCentrelinePick(...)`) and `Services/FoundationService.Identity.cs` line 94. Still OPEN until Tim confirms in AutoCAD.
3. **BUG-536: four parts were still open; one is built.** Built: the 50 mm pad round-up and the 450 mm size counted for a pier with no printed size now come from Settings.

---

## FOR TIM

1. **What you will see differently:** nothing today. CSLOADPATH still offers a pad rounded up to the next 50 mm and still counts a pier with no size as 450 mm. Now those two numbers can be changed in the settings file (`LoadPath.PadRoundUpMm`, `LoadPath.UnsizedPierDiameterMm`) and CSLOADPATH follows them. They are not on the Settings page yet (the other LoadPath numbers are not either).
2. **BUG-470 (FSF picking an existing footing outline):** already fixed on the installed line. FSF now refuses CE's own outline with a plain line. Nothing to build.
3. **Not built, and why (BUG-536 stays open):**
   1. **Member schedule sizes and footing schedule column widths:** these must match your office MEMBER SCHEDULE block. Question for CE 04: should the sizes and widths be editable numbers in Settings, or stay locked to the office block?
   2. **Label height read by only two commands (the BUG-531 overlap):** needs the same decision about which commands follow the label height.
   3. **Bored pier (BP) block:** the single block 450DIABPV2 carries the 300, 450 and 600 diameters as visibility states, so "always uses the 450 block" is by design, not a Settings gap. The Settings diameter is already read.
4. **To test in AutoCAD (robot case, see below):** edit the settings file so `LoadPath.PadRoundUpMm` is 100, run CSLOADPATH on a post with no footing, and read the offered pad size (it should round up to a multiple of 100, for example 500 not 450).

---

## Technical detail

1. **Mistakes of my own:** (a) first test run used `net10.0-windows` on the DesignCore tests, which only target `net10.0`, so it printed nothing; (b) first net48 build failed only because `powershell` was not on this shell's PATH (post-build CE_SHARED check, exit 9009); the C# itself compiled; re-run with it on PATH gave 0 errors. Neither affected the code.
2. **Files changed:** `Modules/Structural.DesignCore/LoadPathEngine.cs` (optional `unsizedPierDiameterMm` and `roundUpMm` parameters; new constants `DefaultUnsizedPierDiameterMm` 450 and `DefaultPadRoundUpMm` 50; zero or negative falls back), `Modules/Structural/Models/UserSettings.cs` (LoadPathSettings: three new members, inside that class only), `Modules/Structural/Services/FoundationService.LoadPath.cs` (pier footprint at about line 336 and OfferPadFooting at about line 765), `REGRESSION_LOG.md`, plus two new test files.
3. **Switch:** `LoadPath.ReadsPadRoundUpAndUnsizedPierFromSettings`, default ON, documented "Default: on.". OFF returns the built-in 50 and 450 exactly. Defaults of the two numbers equal the old built-in values, so behaviour is unchanged until edited.
4. **Tests run (net10, focused, one project per command, with a filter):**
   1. DesignCore: `LoadPathSettingsValuesTests` + `LoadPathEngineTests`: 32 passed, 0 failed.
   2. Structural.Tests (net10.0-windows): `S14LoadPathSettingsDefaultsTests` + `S45NewSwitchDefaultsTests` + `LoadPathUnlinkedPostsTests`: 14 passed, 0 failed.
   3. net48 compile of `CE_STRUC_SUITE.csproj` Release: 0 warnings, 0 errors.
   4. The switch-default test goes through `DeserializeSettingsTolerant` on the normal path and the value-by-value path. This line has no separate plain `DeserializeSettings`, so there is only that one start-up read.
   5. Not run, by the job's rule: the full Structural suite, Manager and Civil suites.
5. **Shared-file clashes seen (gh pr list, then `gh pr diff --name-only`):** UserSettings.cs is touched by open PRs 1909, 1908, 1898, 1899, 1905, 1906, 1895, 1886 and 1885 (all append elsewhere; mine is inside `LoadPathSettings`, expect a trivial textual merge at most). FoundationService.cs is touched by 1909 (BUG-579); I did not edit FoundationService.cs at all (my change is in `FoundationService.LoadPath.cs`). ScheduleService.cs is touched by 1886; not edited.
6. **NOT proven:** nothing opened in AutoCAD; the pad offer and the pier footprint under a post were only reasoned through the code and engine tests. The two call sites are guarded by a source-text test, not by a drawing run.
7. **Robot case proposal (name N90_lp_roundup):** with a drawing holding one post and no footing, set `LoadPath.PadRoundUpMm` to 100 in the (scratch) settings file before launch (settings are read at AutoCAD start), type `CSLOADPATH` and answer `No` to the pad offer; check the command-line line `[LOADPATH] Offered pad footing 500x500` (with the default 20 kN, 100 kPa, 450 min the side is 450, which a 100 step makes 500). Switch-off control: same file plus `ReadsPadRoundUpAndUnsizedPierFromSettings` false must print `450x450`. Second case N91_lp_unsized_pier: a bored pier with no size and a post 280 mm from its centre; with `UnsizedPierDiameterMm` 600 the post counts as supported (half-width 300), with 450 or the switch off it does not (half-width 225).
8. **Real-files compare:** the lists are in `C:\ce-scratch\s14\real_before.txt` (04:20) and `real_after.txt` (about 04:27), 32,533 and 32,538 rows. Differences are only live log and state files: CE_CADTOOLS\CE_Admin (manager-menu-state.json, sessions\CE_SUITE_MANAGER.json, the Manager menu .cuix), CE_CVL_SUITE (ledger\suggestions.jsonl, CE_CVL_SUITE.log, ce_cvl_structured log, native_grip_2027.log, telemetry\outbox.jsonl) and CE_STRUC_SUITE (logs\RuntimeDiagnostics runtime_20261031.jsonl and runtime_snapshot.json). No settings file (CS_Settings.json, CD_Settings.json or any name containing "settings") changed. My tests ran with CE_STRUC_SUITE_APPDATA_ROOT, CE_LOG_DIR_OVERRIDE, TEMP and TMP under C:\ce-scratch\s14, and the tests I ran (pure settings reads and engine maths) write nothing; the log changes line up with a live AutoCAD or robot session on the PC, not with my run, but I did not see which process wrote them.
9. **Worktree:** `C:\ce-fx\s14`, bin/obj cleaned with `git clean -fdXq`; branch `claude/s14-foundation-settings` pushed, nothing deleted or force-pushed.
