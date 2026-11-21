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

---

# Second verdict: b97fcba (round 1 of 2)

**Verdict: HOLD. Both halves hold it.** Written Sat 21 Nov 2026, about 11:32 am. Both halves ran on Codex, with every outside-input variable unset and no variable pointed at a real folder:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pp2_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `pp2_adv_REPORT.md`.

**Closed:**
- The real terms reader is gone, with no reference to the file or its old variable in src, bench, tests or acad.
- The four drawing defaults are gone; each class now has its own variable.
- The eight supplied-drawing checks show WAITING in an ordinary run and FAIL in a release run with the variable unset or the folder empty, as the control room ruled.
- The whole solution and the whole branch suite ran.

## Blockers (D-441: no test or helper opens a folder outside the build's own folders)

1. **A configured root is never required to be inside the build** (both halves). `tests/TestInputPath.cs:20-35` accepts any normal absolute path as the root. It checks that a child sits inside the root, but never that the root belongs to the build; a made-up sibling path was returned unchanged. A path that starts with one backslash and one forward slash normalises to a network share after the share check, and `HasSafeAttributes` (lines 70-80) can then reach the share. **The fix:** the root must be inside the checkout or a named build folder, with no network paths at all.
2. **Helpers still read files named by a variable** (both halves).
   - `acad/night_scripts/ce_safety.ps1:29` reads the file named by `CE_FAKE_WORLD`.
   - Lines 32 and 107 read `CE_RUNNER_RECORD`, which defaults at line 14 to a path outside the checkout. Both reads happen before any JSON check.
   - `bench/CeCivil.Bench.Clicks/Program.cs:58-66` reads a scenario path unchecked.

   All were read only, never run (D-388).
3. **The source guard misses configuration and indirect names** (both halves). Each of these went unreported:
   - an outside path in a test `.config` file (the file-type list at `SemanticPrivatePathSourceTests.cs:108` omits it);
   - a JSON-escaped private name, because JSON is scanned as raw text (lines 119-137);
   - the retired variable `A4C_LEAK_TERMS_FILE` named in a JSON setting (the name matcher at `TestInputPath.cs:9` does not know it);
   - a name built from a constant in another file, because each file is compiled alone (lines 164-175);
   - a literal absolute path in an ordinary helper under acad (lines 112-117).
4. **The configured-source release check can never pass** (honest half). `ShippedBlocksFileTests.cs:61-64, 263-279` keeps only those copies under `blocks/supplied` that sit inside the configured path. But `tools.csv:55` makes that path the single file `office_blocks.dwg`, so no copy can match. In a correct release run the check would fail.

## Follow-ups
1. **Missing grip inputs:** the grip tests (76 in `TextGripAcceptanceTests`, 2 in `TextGripCommandVisibilityTests`, 1 at `Stage1PipeRunEntryTests.cs:392`) report FAILED, not WAITING, when their two variables are unset. They were already targets before this branch; make them WAITING with the rest.

**Next:** the builder closes these four in round 2 of 2, the last. Each comes over as a failing test first.
