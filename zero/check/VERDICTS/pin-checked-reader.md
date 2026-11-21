# The toolchain pin (D-445, amended by D-446): codex/checked-read-write at 051a831

**Answer: NO PIN. The pin file `zero\check\PINS\checked-reader.md` is NOT written.** Written Sat 21 Nov 2026, about 10:56 pm. Both halves ran on Codex:
- **Rebuild:** gpt-6.2-astra, a different model from the builder's (gpt-6.2-sol). Report: `C:\CE_WORK\check\reports\pin_rebuild_REPORT.md`, with proofs in `pin_rebuild_proofs\`.
- **Source review:** gpt-6.2-sol. Report: `pin_review_REPORT.md`.

The two halves stop the pin for different reasons. Neither report contains a login name (checked by count). The source reviewer noted that one of its tool reads displayed a login identifier in its own working output; by the standing brief, that run does not stand as formal review evidence. Its findings are kept as observations, and the next revision gets a clean review.

## The rebuild: NO MATCH (nothing loosened)

1. **`CeCivil.IO.dll` differs because of git metadata.** Two clean builds from the tracked checkout gave `7E59E5C8...136E`. With the identical sources and git metadata switched off, three controls gave the builder's `8A7889B8...FA9C`. The builder built in workshop copies without git, so the image carries the source-control details only when built from a checkout.
2. **The gate DLL could not be built.** The gate needs `System.Management.Automation.dll` (the builder's 7.6.0.500), which the builder copies into `tools/CeCivil.SourceGate/obj/gate-refs` after each clean. It comes from outside the repository and the package cache, so the rebuilder had no permitted copy and the gate build stopped with one error. The gate image (`2CDA7394...A722`) and the PowerShell file (`A689B32A...3C01`) have nothing independent to compare against.
3. **What matched:**
   - **The policy:** `checked-io-roles.json` 90F84FEB555ECCCBC5C104D26E8E6FFCFA6CD10FBB28D8603831550FED41611C (the file, and the resource extracted from the reader).
   - **The Roslyn 4.8.0 inputs:** `Microsoft.CodeAnalysis.CSharp.dll` 2A3B34CE70DB9896A3E34B8A5620C3C437B2B246E90645DED5CA09F4FB597D60, `Microsoft.CodeAnalysis.dll` 57994F7FA7ABCC571A31C4E98B02C3EB573DAE8F581F0C264CDEC97F38CF1560, and all 28 restored Roslyn files.

   The SDK was 10.0.303, with a fresh offline restore from the lock files.

## The source review: DO NOT PIN (rule 32 holes)

**What holds:** the reader itself is sound.
- **Before opening:** it refuses shares, mapped drives, reparse points, mounts and a link count other than one before reading.
- **Holding the file:** it holds the parent and file handles and rechecks after use.
- **Writing:** it never writes.

**The holes:**
1. **The supplied drawings:** the direct read takes the caller's list. Nothing checks for an immediate child, one of the 18 approved names, or an independent fingerprint before the bytes are returned (`CheckedReader.cs:75-90, 104-111, 125-127, 173-195, 212-256`; `checked-io-roles.json:12-13`).
2. **The shipped package and other roots:** the shipped role, and the producer, run, checkout-record and toolchain roles, accept caller-supplied roots and members. Nothing binds them to the verified plug-in DLL, its single office drawing, or a host record (`checked-io-roles.json:15-18, 22-25`).
3. **The checkout and live roles:** the checkout-source role skips the member check for direct reads and probes, and the live-record role takes any declared member. They can read or probe a staged live drawing or plug-in file (`checked-io-roles.json:10, 28-29`; D-445).
4. **Rule 33:** some night scripts under system temporary storage still get past the gate. Details are in the report.

## What the control room needs to decide (recommended)
1. **The pin image:** pin the image built FROM THE EXACT COMMIT, with its git metadata. It is reproducible per revision, and the host verifies that same image. Or rule that pins are built with source-control details switched off. Either is honest; the builder and the rebuild must use the same one.
2. **The PowerShell reference:** designate a permitted, locked source, for example the matching NuGet package restored through the lock file, in place of a copy from an installed PowerShell.
3. **Then:** the builder closes the four holes, and the check room rebuilds and reviews again before any pin is written.

**Ruled since (D-448, 22:57):** git metadata OFF in the project; the PowerShell reference from Microsoft's NuGet package under a locked restore (or dropped); the four holes fixed with failing-first tests; then a new rebuild and review.


---

# Second attempt: c27f6ef (after D-448)

**Answer: NO PIN. The pin file is still NOT written.** Written Sat 21 Nov 2026, about 11:44 pm.
- **Source review:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pin2_review_REPORT.md`. It says DO NOT PIN, on three blockers.
- **Rebuild:** gpt-6.2-astra. Its first run stopped itself before building, because a tool echoed an account name while it read the general rules files (it judged that run invalid). It was relaunched with those reads skipped, then stopped by the check room once the review had said DO NOT PIN, so as not to spend a rebuild on a revision that cannot be pinned.
- **The reviewer's own run:** it also displayed login identifiers in its tool output while reading the rules and router. It counts as diagnostic, not formal, evidence. Neither report contains a login name (checked by count).
- **Next time:** every pin brief skips the general rules and router reads.

**Diagnostic, not formal:** the reviewer reproduced all five of the builder's hashes from the detached worktree AND from a plain copy, offline: CeCivil.IO.dll 4C0FE267...50C9, CeCivil.SourceGate.dll 9B41A667...6E67, checked-io-roles.json F8F03F0A...D85D, and the two Roslyn 4.8.0 libraries. So D-448(a) works, and the git metadata is out. The PowerShell reference is gone (D-448(b)). The embedded record is the existing 18-drawing fingerprint list, byte for byte. It holds no gate pin and gives no fallback for D-446.

## Blockers (rule 32)
1. **The night-source role can still read the live drawing and DLL.** `checked-io-roles.json:11` accepts declared members without any script-only or reserved-folder limit, and `CheckedReader.cs:93-115, 144-147, 247-278, 377-389` checks reserved folders only for roles that list exclusions. Rule 32 holds both live hand-offs and limits night-source to script text. No test covers night-source (`tests/CeCivil.SourceGate.Tests/Program.cs:17-43`).
2. **The supplied-set check is optional on a direct read.** Each read checks the member's name, size and hash, but the full set of 18 is compared only in `List` (`CheckedReader.cs:329-368`). A direct read can return a genuine original while others are missing or extra drawings are present (rules 8 and 32).
3. **The compiler metadata has a root outside the policy.** `checked-io-roles.json:17-19`, `CheckedReader.cs:155-164` and `CSharpScan.cs:28-30` read the running .NET core library, chosen by the running assembly. Rule 32 (design line 249) puts compiler metadata under the host's package-staging record in the checkout.

## Follow-up (not a blocker)
1. **The shipped office drawing:** it still needs the product host binding of rule 32 (design line 254). Today the caller-root offers refuse, which is a closed starting state.


---

# Third attempt: bbf16bd, and 88f5f04 for the line endings

**Answer: NO PIN. The pin file is still NOT written.** Written Sun 22 Nov 2026, about 12:49 am.
- **Source review:** gpt-6.2-sol. Report: `C:\CE_WORK\check\reports\pin3_review_REPORT.md`. It says DO NOT PIN, on one blocker. It ran with the general rules files skipped, and has no login name (checked by count).
- **Rebuild:** gpt-6.2-astra, on 88f5f04. It was stopped once the review said DO NOT PIN, because the fix will change the reader's bytes.

**Closed:**
- **The night-source role:** it reads named `.ps1` files only, and refuses the live drawing and DLL and reserved folders. It is tested.
- **The set of 18:** it is required on a direct read.
- **Compiler references:** they come only from the locked checkout stage.
- **The rule 32 table:** it matches the passed page in all 651 cells, compared independently.
- **The reader itself:** its writes, links, handles and NTFS checks are unchanged and sound.
- **Line endings:** fixed by `.gitattributes` (eol=lf for src/CeCivil.IO/**, tools/CeCivil.SourceGate/** and the 18-drawing fingerprint file). The build room's two fresh clones, with autocrlf true and false, gave identical bytes. Not yet independently confirmed.

## Blocker (rule 32)
1. **The seed and tank fixture role can reach the live hand-off files.** The policy's reserved-folder list applies to the selected directory at bind time, but not to the role's MEMBER rules. With an allowed directory above the live-run area, a declared member inside the reserved area passes, and a direct probe or read reaches the staged live drawing and DLL through an ordinary fixture reader. Rule 32 refuses probing the live hand-offs (design lines 246, 260-265, 308-309). Files: `checked-io-roles.json:14, 32-41, 48, 71`; `CheckedReader.cs:95-107, 121-127, 148-153, 288-328, 458-470`. The same gap existed at c27f6ef; the second review did not name it.
   - **The fix:** apply the reserved-folder exclusions to the members of EVERY role, not only night-source, with a failing-first test per role. A table-driven check over all roles would stop a fourth such gap.


---

# Fourth attempt: 29d15b7 (the one fix under the amended rule 32)

**Answer: NO PIN YET. The bytes MATCH, but the review holds on one TEST gap, which goes to the control room under D-450. The pin file is still not written.** Written Sun 22 Nov 2026, about 1:46 am.

**The rebuild (gpt-6.2-astra) matches.** Report: `C:\CE_WORK\check\reports\pin4_rebuild_REPORT.md`, with proofs in `pin4_rebuild_proofs\`.
- **The builds:** five clean builds: twice in the worktree, two fresh clones (one per line-ending setting), and a plain copy.
- **The pins:** 25 of 25 pin comparisons MATCH:
  - CeCivil.IO.dll BCD221B1EA3D90227F2996856ABF4A72D9C31E522DA0B0B86060BCA911850AF6;
  - CeCivil.SourceGate.dll 4774B82C33C96FF3070381A26D67EE0DB3820930EC8DF33811ADDD0CE86CAA04;
  - checked-io-roles.json A91A5D8593AEBB88321D8C28D091ADC4B92265D19885783B7AEF46593BD828C7;
  - Microsoft.CodeAnalysis.CSharp.dll 2A3B34CE70DB9896A3E34B8A5620C3C437B2B246E90645DED5CA09F4FB597D60;
  - Microsoft.CodeAnalysis.dll 57994F7FA7ABCC571A31C4E98B02C3EB573DAE8F581F0C264CDEC97F38CF1560.
- **The manifest:** all 38 output files are identical byte for byte across the five builds.
- **The toolchain:** SDK 10.0.303. Source-control queries and revision stamping are off.

**The source review (gpt-6.2-sol) says DO NOT PIN.** Report: `pin4_review_REPORT.md`.
- **The earlier gap is closed:** every role now checks reserved components on each declared member, by physical identity on the held NTFS handle.
- **The reader itself:** unchanged and sound.
- **The test gap:** the compiler-metadata reader has a second working entry point, and its only reserved-member test covers an asset under `obj`, not `.git`. A later change that dropped the `.git` member refusal on that entry point alone would pass every test (`ReservedMemberTests.cs:41-56`, `Program.cs:104-112`, `CheckedReader.cs:167-218`). The amended rule 32 requires a test for every reserved folder. The CODE is right today.
- **The run itself:** a git ownership message printed account names in its local tool output, so by the standing brief this run is diagnostic, not formal, evidence. Its report holds no login name (checked by count).

**For the control room (D-450: a further rule 32 blocker comes to you before any work). Recommended:**
1. **One test-only addition** (a `.git` member case on the compiler-metadata entry point). It lives in `tests/CeCivil.SourceGate.Tests`, outside the pinned images, so the five pinned hashes should not change. The rebuild confirms they don't.
2. **A clean formal re-review** with the rules reads and git diagnostics captured, and no account names echoed.
3. **Then the pin page,** with the five values above and revision 29d15b7.

---

# PINNED: edb95c1 (D-451)

**Answer: PIN WRITTEN.** Written Sun 22 Nov 2026, 2:27 am. The pin is at `zero\check\PINS\checked-reader.md`, committed by name and pushed.

1. **The rebuild (gpt-6.2-astra, `pin6_rebuild_REPORT.md`):** 25 of 25 values MATCH across five builds (twice in the worktree, two fresh clones with autocrlf true and false, and a plain copy). All 38 output files are identical; the sorted manifest is A14959A5...D39B. None of the five values moved from 29d15b7. The three locked package content hashes match. There is no PowerShell reference.
2. **The clean formal review (gpt-6.2-sol, `pin6_review_REPORT.md`):** APPROVE FOR PINNING.
   - **The tests:** the five D-451 tests reach the compiler-metadata reader's second entry point, one for each reserved member.
   - **Rules 18 and 32:** they hold unchanged, since no pinned input changed.
   - **Clean:** no account names in the report.
3. **The five pinned values** (copied here so a changed pin shows against this pushed page):
   - CeCivil.IO.dll BCD221B1EA3D90227F2996856ABF4A72D9C31E522DA0B0B86060BCA911850AF6
   - CeCivil.SourceGate.dll 4774B82C33C96FF3070381A26D67EE0DB3820930EC8DF33811ADDD0CE86CAA04
   - checked-io-roles.json A91A5D8593AEBB88321D8C28D091ADC4B92265D19885783B7AEF46593BD828C7
   - Microsoft.CodeAnalysis.CSharp.dll 2A3B34CE70DB9896A3E34B8A5620C3C437B2B246E90645DED5CA09F4FB597D60
   - Microsoft.CodeAnalysis.dll 57994F7FA7ABCC571A31C4E98B02C3EB573DAE8F581F0C264CDEC97F38CF1560

**What follows (D-445 step c):** the build continues. At each later verdict on that branch, the check room confirms the host reads this pushed pin, and nothing else.
