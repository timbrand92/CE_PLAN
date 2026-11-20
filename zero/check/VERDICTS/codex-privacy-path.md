# Verdict: codex/privacy-path at 7fd2859 (SECURITY, D-441)

**Verdict: HOLD. The control room's 7:10 am ruling already widens this branch.** Written Sat 21 Nov 2026, about 7:31 am. Both halves ran on Codex. Neither touched the real terms file, the private folders or the 18 drawings.
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pp_honest_REPORT.md`. It holds.
- **Adversarial half:** gpt-6.2-astra. It stopped before reviewing anything, because the check room's brief forbade the rule files it also asked it to read. That was the check room's slip; the brief is now corrected, and this half reruns on the next tip.

**What is right:** the dedicated reader of the real terms file is gone, at the default path, the environment variable and the disk read alike. The privacy check now uses a made-up terms list embedded in the test assembly. The check room's own read agrees: nothing at 7fd2859 names the file.

## Open, to fold into the same branch with the control room's ruling
1. **Remaining defaults outside the repository** (now ruled: none allowed).
   - `ShippedBlocksFileTests.cs:24,50` still defaults to the local supplied drawings folder.
   - `SavedDwgTests.cs:10-36` reads an outside saved-drawings folder.
   - `SeedBlockTests.cs:15-25` reads an outside trial fixture.
   - `TankBlockTests.cs:16-66` reads two outside template copies.
2. **Paths supplied through configuration are not kept inside.** The supplied folder can be anywhere, and `PluginFolder` climbs two levels above it (`:247`). Also check `TextGripAcceptanceTests.cs:564-570`, `Fake/CommandHostCompatibility.cs:141-144` and `TextGripCommandVisibilityTests.cs:20-40`. The night helper `acad/night_scripts/ce_safety.ps1:28-32,105-107` was read only, never run (D-388).
3. **The name guard can be dodged.** It only looks for the two names written out whole, so a name split across strings, a name built from variables, or a short 8.3-style name slips past (`PrivatePathSourceTests.cs:8-9,34-36,50-52`). It also skips `acad` and `tools`. The ruled source test, "no test file holds an absolute path outside the repository", must work by meaning.
4. **An empty supplied folder fails instead of WAITING.** The six ordinary supplied checks (`ShippedBlocksFileTests.cs:63-74`, `88-92`, `123-128`, `208-224`, `351-355`) would report a missing manifest. As ruled, an unset variable must show WAITING, and the release gate must FAIL on an unset variable or an empty folder.

**Next:** the build room hands over the new tip. Both halves check it with the corrected brief.
