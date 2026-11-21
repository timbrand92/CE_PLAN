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
