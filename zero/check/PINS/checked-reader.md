# Toolchain pin: the checked reader and the source gate

This file is held by the check room alone (D-445, amended by D-446; D-448; D-451). The host reads this one file, read only, as a named exception to D-441; the build room never writes it. Its pushed git history is the tamper evidence: a copy that differs from the pushed history is not this pin. A pin changes only on a control-room D-number.

## Pinned revision
- **Repository revision:** `edb95c1b01f16c001534a1c9b5046946cef9c547` (branch codex/checked-read-write). This revision holds the D-451 tests guarding the compiler-metadata reader's second entry point.
- **First shown on:** the 25-of-25 byte match was first shown on `29d15b7687f6ad4ee71ce85cc8b49014eba80fdd`. The diff from that revision to the pinned one changes no pinned input: nothing in src/CeCivil.IO, tools/CeCivil.SourceGate, the fingerprint record or .gitattributes.
- **Recorded:** Sun 22 Nov 2026, 02:27 Melbourne time.

## SHA-256 of the pinned files
1. `src/CeCivil.IO` output `CeCivil.IO.dll`: BCD221B1EA3D90227F2996856ABF4A72D9C31E522DA0B0B86060BCA911850AF6
2. `tools/CeCivil.SourceGate` output `CeCivil.SourceGate.dll`: 4774B82C33C96FF3070381A26D67EE0DB3820930EC8DF33811ADDD0CE86CAA04
3. Policy `src/CeCivil.IO/checked-io-roles.json`: A91A5D8593AEBB88321D8C28D091ADC4B92265D19885783B7AEF46593BD828C7
4. Dependency `Microsoft.CodeAnalysis.CSharp.dll` (package Microsoft.CodeAnalysis.CSharp 4.8.0): 2A3B34CE70DB9896A3E34B8A5620C3C437B2B246E90645DED5CA09F4FB597D60
5. Dependency `Microsoft.CodeAnalysis.dll` (package Microsoft.CodeAnalysis.Common 4.8.0): 57994F7FA7ABCC571A31C4E98B02C3EB573DAE8F581F0C264CDEC97F38CF1560

**The full output manifest:** 35 gate files and 3 reader files. The sorted manifest has SHA-256 A14959A5ADEB41146540E64FC439662E9B8A32615D50D44AC14AB98E8A18D39B, identical across all five rebuilds.

## Locked package content hashes (from the committed lock files, matched in restore)
- **Microsoft.CodeAnalysis.CSharp 4.8.0:** `+3+qfdb/aaGD8PZRCrsdobbzGs1m9u119SkkJt8e/mk3xLJz/udLtS2T6nY27OTXxBBw10HzAbC8Z9w08VyP/g==`
- **Microsoft.CodeAnalysis.Common 4.8.0:** `/jR+e/9aT+BApoQJABlVCKnnggGQbvGh7BKq2/wI1LamxC+LbzhcLj4Vj7gXCofl1n4E521YfF9w0WcASGg/KA==`
- **Microsoft.CodeAnalysis.Analyzers 3.3.4:** `AxkxcPR+rheX0SmvpLVIGLhOUXAKG56a64kV9VQZ4y9gR9ZmPXnqZvHJnmwLSwzrEP6junUF11vuc+aqo5r68g==`

**PowerShell:** no PowerShell assembly is referenced or staged (D-448 b).

## How the bytes were made (so anyone can reproduce them)
- **SDK and settings:** SDK 10.0.303, target net10.0, Release.
  - **Deterministic build:** Deterministic and ContinuousIntegrationBuild on, source paths mapped.
  - **Source-control details off:** source-control queries and revision stamping are off in the projects themselves (D-448 a).
  - **Line endings:** fixed to lf for src/CeCivil.IO/**, tools/CeCivil.SourceGate/** and the 18-drawing fingerprint record, by `.gitattributes` (git 2.51.1).
- **Command:** `dotnet build tools/CeCivil.SourceGate/CeCivil.SourceGate.csproj -c Release --configfile <offline config> -p:UseSharedCompilation=false -m:1`, with an offline restore into a fresh package folder against the committed lock files.
- **Independent rebuild:** five clean builds, all byte-identical:
  - twice in a worktree;
  - two fresh clones, with core.autocrlf true and false;
  - one plain copy with no git folder.

  They were made by Codex gpt-6.2-astra, a different model from the builder (gpt-6.2-sol).

## Approval
- **Formal source review:** APPROVE FOR PINNING (Codex gpt-6.2-sol, clean run) against rules 18, 32 (as amended by D-450) and 33 of design CHECKED_READ_WRITE.md.
- **Evidence:** both reports are kept in the check room's report folder (pin6_review, pin6_rebuild). The verdict page is `zero\check\VERDICTS\pin-checked-reader.md`.
