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

---

# Final verdict: 68eff92 (the LAST round)

**Verdict: HOLD, final. Both halves hold it. Under D-346 it goes to the control room with this open list.** Written Sat 21 Nov 2026, about 4:42 pm. Both halves ran on Codex:
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pp3_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `pp3_adv_REPORT.md`.

**Closed:**
- **The defaults:** the saved, seed, tank and supplied tests have lost their outside defaults; the one outside drawing input is chosen by a single variable.
- **The checked paths:** the package folder, the grip DLL and the grip release are checked against the checkout.
- **The safety helper:** `ce_safety.ps1` checks and confines its variable-named reads, and has no outside default (read only, never run).
- **The guard:** it now covers .config and .xml files, JSON-escaped names, the retired variable name and cross-file constants within one area.
- **The release check:** the impossible comparison is gone.
- **The grip tests:** the 79 grip cases show WAITING.

## Open list (one page)

1. **Bench and plug-in routes still unchecked** (both halves).
   - **The click runner:** `bench/CeCivil.Bench.Clicks/Program.cs:60-89, 229, 465, 486` takes `--exe` (it checks the file exists, then starts it), `--shots` (it creates the folder) and the screenshot file names, all unchecked.
   - **The bench app:** `bench/CeCivil.Bench/App.xaml.cs:22-62` takes report destinations unchecked.
   - **The test-only plug-in commands:** they still open drawings through the old outside `TestFolder.Root`, which checks the prefix's spelling but not where links lead (`src/CeCivil.Acad/TestFolder.cs:9-23`, `PitSeedCommand.cs:30-39`, `OfficeBlocksCommand.cs:31-42`).
2. **Older tests follow directory links, and the drawing-folder exception is too broad.**
   - **Links (adversarial):** `ListsAtStartTests.cs:55,60` and `ScalabilityTests.cs:28,31` enumerate recursively, without the checked reader, so they follow a junction.
   - **The exception (honest):** any fixed-disk folder that holds a `SOURCE_FINGERPRINTS.md` counts as the drawings folder (`TestInputPath.cs:165-182`). It is checked against itself, not against one named place.
3. **The guard still misses decoded and expanded forms** (both halves): XML character references in .config and .xml files; home-directory and environment-variable paths expanded by the code that reads them; and names built from constants in different areas (each area is compiled separately). Files: `SemanticPrivatePathSourceTests.cs:155-206, 237-240, 292-303, 379-390`.
4. **The release check no longer checks the drafter's configured drawing** (both halves).
   - **What it does:** it checks the 18 packaged fingerprints and opens the four Stage 1 copies.
   - **What it misses:** it never reads `office_blocks_file` (`tools.csv:55`), and the expected hashes come from the same configurable folder, not from an independent record of the originals (D-404, D-427, D-433).

**Recommended for the control room:** MERGE this tip now, with the four items above as a separate follow-up branch.
- **Why:** main STILL holds the default path to the real terms file. Holding this branch keeps that danger on main and the filter on every run.
- **The incident is closed:** the reader is gone and the guard is in. What is open is hardening against routes that need someone to supply an outside path on purpose, and the release check's link to the configured drawing.
- **The alternative:** one bounded round, with main kept filtered meanwhile.

---

# MERGE: codex/privacy-path at 68eff92 (control room ruling)

**Verdict: MERGE.** Written Sat 21 Nov 2026, about 4:43 pm. The control room took the check room's recommendation: merge now. This removes the default path to the real terms file from main and closes the incident's routes.

**The four open items become ONE follow-up branch, queued now, and each is a merge condition for later work:**
1. **Items 1 to 3** (unchecked bench and plug-in routes; links and the too-broad drawing exception; the guard's decoded and expanded forms) must close before any night-route or bench-runner work merges.
2. **Item 4** (the release check covers the drafter's configured drawing, and its hashes come from an independent record, D-433) must close before the block drawings branch or any release merges.

**The filter:** the filter on ShippedBlocksFileTests (and the other three outside-reading classes) comes off only after the check room has confirmed on main that nothing names the terms file.

---

# Main confirmed: the filter may come off (main 1e1534a)

Written Sat 21 Nov 2026, about 4:46 pm. Checked by the check room by reading only; nothing was run.

1. **The merge is on main:** origin main is 1e1534a1, and it contains 68eff92.
2. **The tree is clean:** a search of main's whole tree (every folder, not only src, bench and tests) for the terms file's name, the private folder's name and the retired variable finds only the three guard files.
   - **`PrivatePathSourceTests.cs:9`** builds the folder name in memory to match against it.
   - **`SemanticPrivatePathSourceTests.cs:91`** builds an escaped name as a planted case.
   - **`TestInputPath.cs:13`** holds the refusal pattern.

   None of the three opens, reads or points at the file.
3. **ShippedBlocksFileTests on main** reads only its embedded made-up terms (`SyntheticPrivacyTerms.txt`) and has no supplied-folder default.

**So:** the D-441 filter on ShippedBlocksFileTests, SavedDwgTests, SeedBlockTests and TankBlockTests may come off on main and on any branch cut from 1e1534a or later. A branch cut BEFORE 1e1534a still carries the old file and keeps the filter until it is rebased or merged up. The follow-up branch codex/privacy-path2 is queued (q0105).


---

# The follow-up branch: codex/privacy-path2 at f5f41b0 (round 1 of 2)

**Verdict: HOLD. Both halves hold it.** Written Sat 21 Nov 2026, about 6:02 pm. The branch is cut from main 1e1534a; outside-input variables were kept unset.
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pq_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `pq_adv_REPORT.md`, with proofs in `pq_adv_proofs\`. It built the whole solution, CeCivil.Acad included, with 0 errors, and all 19 new cases pass.

**The incident stays closed.** The fixture terms are read from the embedded resource.

**Item 4 (the release condition) is met in the code.**
- **The configured drawing:** `ShippedBlocksFileTests.cs:263` checks the configured `office_blocks_file`.
- **The independent record:** the 18 drawings are checked against `Fixtures/SuppliedBlockFingerprints.txt`, which holds file names, sizes and hashes only (D-433).
- **Not yet proven:** a release run with the real drawings, which only the release itself will show.

**Also closed:**
- **The click runner:** it checks its executable, scenario and screenshot paths before use.
- **The bench app:** it checks its shoot and report destinations.
- **The test drawing commands:** both use the checkout.
- **The two source loops:** they use the checked enumerator.

## Open (items 1 to 3: needed before any night-route or bench-runner merge)

1. **Other reads still follow links or take unchecked paths** (both halves).
   - **Hands tests:** `ListsAtStartTests.cs:14, 55, 84`; `ScalabilityTests.cs:45-52, 72-76` (CopyDir); `PitBlock3Tests.cs:388` and `ShouldFixTests.cs:250` (AllDirectories).
   - **Other source readers:** the recursive readers in `RoundingSourceTests.cs:78, 489, 522, 548` and `StyleKitTests.cs:173`.
   - **The three bench test launchers:** `FifthPassLayoutTests.cs:20-36`, `ListControlsTests.cs:17-33` and `StyleKitTests.cs:212-227` start an executable whose path they only check exists.
   - **Plug-in helpers:** `AcadHost.cs:73-76` reads a saved DWG through the legacy `TestFolder.Saved` (prefix only, links unchecked); `CeTestRunner.cs:40`; the csproj's overridable `RunToolsCsv` (`CeCivil.Acad.csproj:52-57`).
2. **The shared file check accepts hard links** (honest half). `HasSafeAttributes` (`TestInputPath.cs:86-140`) refuses folder links but accepts a hard link, which can give an outside file a name inside the checkout. The click runner and the test drawing commands rely on it.
3. **The guard misses four forms** (both halves): .resx resource files; WSL absolute paths; an MSBuild property taken from the environment; and a direct C# environment value (`SemanticPrivatePathSourceTests.cs:14-22, 313-320, 392-396, 447-459, 532-537`).

## Follow-ups
1. **An unreviewed format:** the rounding source test flags the screenshot step's numeric format at `Program.cs:482` as unreviewed. Add the review entry. That test also fails on main for night-script findings outside this diff.

**Next:** round 2 of 2, the last.


---

# Final verdict: codex/privacy-path2 at 77e4fdd (the LAST round)

**Verdict: HOLD, final. Both halves hold it. Under D-346 it goes to the control room with this open list.** Written Sat 21 Nov 2026, about 7:12 pm. Both halves ran on Codex; the branch is cut from 1e1534a.
- **Honest half:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pq2_honest_REPORT.md`.
- **Adversarial half:** gpt-6.2-astra. Report: `pq2_adv_REPORT.md`, with proofs in `pq2_adv_proofs\`, including the 138-entry review of every raw read and write.

Neither half could restore packages for a full build this time. The builder and the build room report 0 errors, and every main result matching.

**Closed this round:**
- **The named readers:** every reader named in round 1 now uses the checked reader or enumerator.
- **Hard links:** the shared C# checker refuses them (the fixture was replayed).
- **The guard:** the four named forms are caught (.resx, WSL, MSBuild environment property, C# environment value), and 52 to 54 guard cases replayed clean.
- **The review entry:** `Program.cs:482` has its review entry.
- **The incident:** the original real-list reader stays removed.
- **Item 4:** still met in the code (the packaged setting, plus a separate record of the 18 fingerprints). Proof with the real drawings is still owed at release.

## Open list (one page; items 1 to 3 are merge conditions for night-route and bench-runner work, D-443)

1. **Reads and writes still choose their own place** (both halves).
   - **Tests:** ordinary C11 tests read source and CSV files without checking links. The older privacy readers open files unchecked.
   - **Bench and Brain:** they accept folders the caller chooses, the system temporary folder included.
   - **Plug-in helpers:** the native test report writer checks only its path's spelling, and the command generator takes an output file name from the caller.
   - **Where:** the call sites are in `pq2_adv_proofs\raw-io-review.md`.
2. **The hard-link rule is not applied to the night helper or the older privacy readers** (both halves). `acad/night_scripts/ce_safety.ps1:50-55` checks only the reparse attribute; lines 65 and 146 read JSON and lines 66 and 133 write it, without counting links. Found by reading only (D-388).
3. **The guard misses three forms:**
   - an MSBuild property function that reads an environment value (honest half);
   - a plain absolute Linux path (honest half);
   - an ordinary launch-settings JSON under src, which skips the general absolute-path check (adversarial half; `SemanticPrivatePathSourceTests.cs:359, 391-399`). No such file is tracked today.

**Recommended for the control room:**
1. **MERGE this tip:** it is strictly safer than main. Nothing regresses, it closes most of the routes, and it settles the release condition in code.
2. **Keep the open items:** items 1 to 3 stand as the merge conditions for night-route and bench-runner work, as D-443 already says, in a short design page for "every read and write goes through one checked reader and writer". Each round so far has found new raw calls one at a time.
3. **The alternative:** hold, and go straight to that design page.
