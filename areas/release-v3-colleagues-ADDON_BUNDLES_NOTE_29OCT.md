# Do Civil 3.0.85 / Manager 1.1.85 need CE.AutoCADLink.2027 and CE.Transform.Trial.2027? (CE 01 Build, Thu 29 Oct 2026)

Answer to the Control Room's question relayed from CE 07. **Read from code and manifests only. Nothing was run, nothing was measured in AutoCAD.**

## FOR TIM

1. **My recommendation: do NOT put either of the two extra bundles in Max's package.** Both are isolated test bundles, not part of the product, and nothing in Civil or Manager calls them.
2. **What each one is (read from its own manifest on your PC):**
   1. **CE.Transform.Trial.2027** (7 Sep): a trial of two test commands, CETESTCR and CETESTMR (Copy-Rotate and Move-Rotate). It loads only if one of those two commands is typed; it does not load at AutoCAD start. Civil ships its own finished version of the transform code inside its own bundle (CE_TRANSFORM_2027.arx), so Civil does not use the trial.
   2. **CE.AutoCADLink.2027** (23 Jul): a "synthetic-only read-only test adapter", marked "no network or central connection". It does load at AutoCAD start. Its commands are all test commands (for example CEW03TESTEXTRACT). Nothing in the Civil or Manager source mentions it.
3. **What is NOT known:** whether REDO, selection, the UCS or the transform behaviours come out the same on a PC without them. By reading, Civil does not depend on either, so I expect the same. I cannot prove it without running AutoCAD.
4. **How it gets proven:** the BUG-861 control run you approved moves these bundles aside on your PC and re-runs the REDO test; the dry run on a spare standard Windows login is the other proof (a PC that never had them). If either run behaves differently, I reopen this and the bundle question.
5. **Why it matters for testing:** every robot and Codex result so far was taken with both bundles in the folder. The control run and the rehearsal login are what tell us whether those results hold on Max's setup.

## DETAIL

1. **Transform.Trial manifest:** PackageContents.xml, AppVersion 0.1.0, "isolated Copy and Move Rotate acceptance trial", commands CETESTCR and CETESTMR only, LoadOnCommandInvocation True, LoadOnAutoCADStartup False. Source: Modules/Shared.Transform.Native2027 (trial define CE_TRANSFORM_TRIAL_2027 registers those two commands; the production define CE_TRANSFORM_PRODUCTION is what Civil's bundle carries).
2. **Civil's own transform:** Modules/Drainage/CE_CVL_SUITE.csproj lines 328 to 332 and 408 copy CE_TRANSFORM_2027.arx into the Civil bundle ("AutoCAD 2027 uses the tested native transform module, never Copy Rotate LISP"). So the shipping path does not use the trial bundle.
3. **AutoCADLink manifest:** AppVersion 0.3.0, ".NET" component, LoadOnAutoCADStartup True, "Synthetic-only read-only AutoCAD Link test bundle". A git search of the C-75 branch found no non-markdown source file that mentions AutoCADLink, so Civil and Manager do not reference it. A desk note says it has no event hooks (I did not verify this). Because it is a .NET add-in loaded at startup, it is a neighbour in the same AutoCAD process; it could only affect REDO if it hooks events, which is exactly what the control run tests.
4. **The 2022 to 2024 "enabler" question (BUG-1137, BUG-1138, BUG-1151):** I found no statement that either bundle is an enabler for those years, and both manifests ask for AutoCAD 2027 only (SeriesMin and SeriesMax R26.0). So they cannot help a 2022 to 2024 PC at all. Max's AutoCAD year is still unknown.
5. **What I did not do:** no AutoCAD run, no bundle moved, no search of Tim's other bundles. The Installer build script mentions the Transform trial bundle by name; I did not read what it does with it.
