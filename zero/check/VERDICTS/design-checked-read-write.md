# Answer: design\CHECKED_READ_WRITE.md at bc38a3b (one checked reader and writer for every read and write, D-444)

**Answer: FIX THE PAGE FIRST, on seven short edits. Both readers say so.** Written Sat 21 Nov 2026, about 7:59 pm. By reading only, on Codex, each reader in its own folder:
- **Honest reader:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\crw_honest_REPORT.md`.
- **Adversarial reader:** gpt-6.2-astra. Report: `crw_adv_REPORT.md`.

**What holds:**
- All 138 review rows are in the register, matched by file and line at 77e4fdd. The honest reader traced 57 of them, and the adversarial reader all 138.
- Both ends of all 16 explicit copies are named.
- There are no caller exemptions.
- The shape is right: one reader, one writer, and links refused before use.

## The edits

1. **One list of roots** (both readers). One role-to-root authority covering:
   - checkout inputs;
   - run-owned outputs;
   - the installed package's own shipped inputs (the plug-in opens the office blocks drawing beside its own DLL, `AcadTemplate.cs:28`, and needs a rule that keeps it usable while refusing a linked substitute);
   - the exact supplied-drawings exception.

   Every other selection is refused.
2. **The gate comes first** (adversarial reader). A trusted, read-only source check must run BEFORE the candidate project or script is evaluated or copies anything, with a planted outside sentinel proving nothing happens early. A red test after compilation cannot undo a copy the build has already made.
3. **A complete register** (both readers). It must add, each with both ends, its root and a failing-first case:
   - the six SDK `CopyToOutputDirectory` items (`CeCivil.Bench.Core.csproj:12`, `CeCivil.Brain.csproj:12`, `CeCivil.Acad.csproj:42, 44, 47`, `CeCivil.Hands.Tests.csproj:27`);
   - embedded resources;
   - the probes of project-selected references;
   - the archive and assembly opens;
   - the three bench launches (`FifthPassLayoutTests.cs:22`, `ListControlsTests.cs:20`, `StyleKitTests.cs:218`), with the checked identity kept until use, and starts from the temporary folder refused;
   - script imports and child script loads (`ce_launch.ps1:4`, `ce_pass.ps1:15, 25-26`, the `ce_safety.ps1` import);
   - incremental and clean build paths.
4. **Indirect file access fails unless proven** (both readers). Any file-capable operation without proof of its target and effect fails by default: dynamic calls, reflection, native interfaces (P/Invoke), child commands, and implicit MSBuild tasks. Plant one independent negative per family.
5. **Mount points on the same disk** (adversarial reader). Refuse an unproven move into a mounted folder, even on a trusted volume. The same rule applies to reads, writes and clean-up.
6. **The integration contract** (both readers).
   - **The settings audit:** the page must say how the audit recognises a drawing-settings read and accepts the checked report XML, with a passing report case beside a failing wrong-drawing or wrong-setting case. (This is the case that broke the first privacy merge.)
   - **References:** keep the package-reference route for Roslyn and the native references, refusing any path chosen from outside, with paired positive and negative controls.
7. **Night-script safety** (honest reader). The stop flag gets a read-only role: no script may write, delete or rename it (D-420). Prove that a fixture write cannot escape its own sandbox or reach the real launcher. The scripts are read only, never run (D-388).

**Next:** the page's writer makes the seven edits, and both readers read it back. One build follows the page (D-444). Until that build merges: no night-route or bench-runner merges, and no block drawings or release.
