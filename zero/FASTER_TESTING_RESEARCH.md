# Faster testing: deep research, and what to do

**Written Sun 22 Nov 2026 by a research session for the control room. It follows on from `FASTER_TESTING.md` and does not repeat it.** Every claim is marked: CONFIRMED (read in a primary source or in this project's own records), REPORTED (said by others, not checked), or MY JUDGEMENT.

## Summary for Tim (ten lines)

1. **Nobody has a magic tool.** Teams that make AutoCAD plug-ins prove them the way this project already does: sums tested on their own, then tests run inside AutoCAD. No official Autodesk method exists.
2. **This project is closer than it feels.** CETEST already ran inside real AutoCAD on 18 Nov: 24 of 25 checks passed in about one minute.
3. **The slow part is people, not machines.** Each build waits for a night run, then for check rounds that hunt for faults by reading.
4. **Biggest gain: run the drawing checks headless, every build, in minutes.** AutoCAD's Core Console has no window, no mouse and no ribbon. It can also answer a command's prompts from a script.
5. **Second: a sealed test PC inside your PC (a Hyper-V virtual machine) for full-AutoCAD robot runs.** If AutoCAD jams there, the robot throws the machine back to a clean copy. Your profile, drawings and AutoCAD are never touched.
6. **Third: machines hunting for weak tests and wrong figures,** so check rounds stop finding them by reading.
7. **Fourth: each night, a PDF picture of every test drawing, sent to your phone,** plus a "what changed since last night" drawing.
8. **What only your eyes can prove:** how a window feels, how a grip drag feels, and whether the sheet looks right to a council engineer.
9. **Licence:** Autodesk allows a single-user subscription in a virtual machine, but only one person, on one device, at a time. So robot runs go at night, unless you buy a second seat.
10. **Needs your yes:** headless runs (the current night rules ban them), and the virtual machine. Neither touches your profile or licence settings.

## 1. Proving what lands in the drawing, with no person and no mouse

1. **Tests hosted inside the Core Console.** CONFIRMED (Autodesk 2026 help): it opens one drawing and runs a script.
   1. It refuses any command that opens a dialog or palette.
   2. It has no COM access.
   3. Plug-ins must not load AutoCAD's screen library (AcMgd), or the console can crash.
   4. Plug-in files must sit in a trusted place.
   - **Proves:** objects written and read back, which covers block attributes, layers, text, masks, polylines, extension data, the UNDO command and save. Reopening is a second run on the saved file. CONFIRMED in this project: a probe measured leader geometry this way on 14 Sep.
   - **Command prompts:** REPORTED (Autodesk forum): the editor's prompts still work, and a script can answer them line by line. So a whole command conversation with typed answers can run headless.
   - **Dynamic block states:** MY JUDGEMENT. They should read and set the same way as in full AutoCAD, but no source confirms it.
   - **Cannot prove:** windows, grips, mouse picks, previews that follow the cursor (jigs), the ribbon, or anything AutoCAD does when idle. CONFIRMED in this project's records: the console never fires Idle.
   - **Speed:** REPORTED (Autodesk's own cost blog): "launches fairly quickly", because there is no screen to draw. MY JUDGEMENT: seconds per drawing, so a few minutes for every scenario.
   - **Traps:**
     1. It will not start while full AutoCAD is open on the same PC (machine-wide lock). CONFIRMED in this project's records.
     2. Loading the old plug-in once wrote to your live log and settings. CONFIRMED (23 Sep). The new code's path guard exists for exactly this reason.
     3. Its start switches include a profile switch and a sandbox-user-folder switch (`/isolate`). Under rule 1.9 these need your yes.
2. **Tests hosted inside full AutoCAD.** CONFIRMED in this project: CETEST does this, using NUnitLite, with recordings compared against known-good copies.
   - **Proves:** everything the console proves, plus real dynamic blocks and things that need the screen library. Grip behaviour can be proven by calling the grip code directly. That is MY JUDGEMENT; it is not a real mouse drag.
   - **Needs:** a signed-in AutoCAD, your profile today, and a person or robot to start it. That is what made it risky.
3. **Side databases (a drawing opened in memory, never shown on screen).** CONFIRMED in this project: CETEST already saves and reads drawings this way. Your test bench also reads saved drawings without AutoCAD at all (the drawing-reading tests). This is the cheapest proof of "saved and reopened correctly".
4. **Script files on their own.** CONFIRMED (Core Console help and CADtest's notes): the same `.scr` loads the plug-in in either AutoCAD (switch `/s` for the console, `/b` for full AutoCAD). Scripts are the glue, not the test.
5. **Autodesk's cloud service (Design Automation).**
   - **What it does:** CONFIRMED (Autodesk docs). It runs AutoCAD's engine in the cloud and can plot to PDF.
   - **Limits:** CONFIRMED. 100 seconds per job by default, up to one hour if raised. It must print something at least once a minute. The bundle may be at most 500 MB. It cannot run AutoCAD verticals.
   - **Cost:** CONFIRMED that it is billed per second of run time. The current AutoCAD rate could not be confirmed (old figure, 2020: 4 cloud credits an hour).
   - **Verdict:** MY JUDGEMENT. It is a safe place with no licence on your PC. But each run means packaging and uploading, so it suits a release check, not everyday use.
6. **Named open-source runners.**
   1. **CADtest:** CONFIRMED. It runs NUnitLite inside AutoCAD or the Core Console. It is a 2016 / .NET 4.5 example rather than a library, and its author has called it "probably broken". It is the pattern this project already follows.
   2. **RxBim AutoCAD test packages:** CONFIRMED. These are alive: last release 10 Nov 2026, built for .NET 8, with 2025 and 2026 packages. There is no 2027 package yet. How they start AutoCAD is not stated.
   3. **cadwiki NUnit runner:** CONFIRMED. Alive, last updated May 2026. It is built for .NET Framework 4.8 only, so it does not suit AutoCAD 2025 to 2027.
   4. **JPP AutoCAD NUnit tester:** CONFIRMED abandoned. An unlisted 2018 trial version.
   5. **ricaun RevitTest (Revit, for comparison):** CONFIRMED. It is the nicest design seen: an ordinary test command opens Revit, runs the tests inside, and closes it afterwards. Nothing like it is maintained for AutoCAD 2027.
   - **Verdict:** MY JUDGEMENT. Keep this project's own runner. Nothing ready-made beats it for AutoCAD 2027 on .NET 10.

## 2. Proving the drafting experience: prompts, clicks, windows, grips, Escape

1. **Sending command strings into a running AutoCAD.** CONFIRMED in this project: the desk's driver typed a circle, U and REDO correctly, at about one second per call.
   - **Trap:** a command left waiting at a prompt jammed AutoCAD for 15 minutes. CONFIRMED (3 Oct). Always send a complete command.
2. **The editor's own command calls from code.** REPORTED (forum): code can run a command and wait for its prompts to finish. Some command types cannot do this in one step.
3. **Windows UI automation (FlaUI, WinAppDriver, Microsoft's UI Automation).**
   - **This plug-in's own windows:** CONFIRMED in this project. Its WPF windows can be driven by element name.
   - **AutoCAD's own screen:** CONFIRMED (this project's 3 Oct run, 19 of 19 BLOCKED). Driving AutoCAD and Explorer by element name failed. The drawing area has no named parts.
   - **The tools:** FlaUI is alive and handles WPF (CONFIRMED, its listing). MY JUDGEMENT: use it for the Pit and Pipe windows only.
4. **Grips and the mouse.** MY JUDGEMENT; no source shows a reliable automated grip drag in AutoCAD. Screen coordinates change with zoom, screen scaling and window size, which is the known flaky part.
   - **Plan:** prove grip sums and grip code by calling them directly, and leave the feel of a real drag to you.
5. **AutoCAD's Action Recorder.** REPORTED, not checked. It replays commands but stops for user input, so it is not a test tool.
6. **Keeping the robot away from your drawings, profile and licence.**
   1. **A Hyper-V virtual machine:** a separate Windows computer running inside yours, with snapshots ("checkpoints"). MY JUDGEMENT: the best fit. Windows 11 Pro includes Hyper-V.
      - **Licence:** REPORTED (Autodesk's virtualisation page, seen only through search, because the page refused the fetch). It is allowed for single-user subscriptions. Autodesk supports AutoCAD in it, but not the virtual machine itself.
      - **Trap:** REPORTED (forums, older). If the virtual machine's network address changes, it asks for sign-in again. Fix the address once.
   2. **A second PC:** the same benefits, but more hardware.
   3. **Windows Sandbox:** CONFIRMED (Microsoft). It wipes everything when closed, allows only one at a time, and supports a virtual graphics card.
      - **Verdict:** MY JUDGEMENT, unsuitable. AutoCAD would need installing and signing in every time, and sign-in is yours under rule 1.9.
   4. **A second Windows user on your PC:** MY JUDGEMENT, weaker. It still shares the machine-wide lock, and a jam still lands on your PC.
   5. **One device at a time:** REPORTED (Autodesk support, through search). A single-user subscription may be installed on up to three computers, but used on one at a time. So the virtual machine's AutoCAD and yours cannot both run under your one seat.

## 3. Seeing the result as a drafter would

1. **Plotting a test drawing to PDF or PNG.** REPORTED (forums): it works from the Core Console's `-PLOT` with background plotting off. But Autodesk "does not support plotting" there, and some runs gave blank PNGs or rotated Civil 3D labels. MY JUDGEMENT: plot in full AutoCAD in the virtual machine, not in the console.
2. **AutoCAD's own drawing compare.** REPORTED (forum, with a working script): the compare command plus the compare-export command, run in the Core Console, writes a "what changed" drawing against a known-good drawing. CONFIRMED (Autodesk help): the export is a new drawing showing the differences.
3. **Comparing drawing content as text.** MY JUDGEMENT: the strongest golden check. Write every object's layer, handle, text, attributes, levels and points to a text file, rounded to 0.001 m. Compare it with the approved file. Round-off and handle numbers are the usual noise. Rounding fixes the first; matching by the plug-in's own tags fixes the second.
4. **Comparing pictures pixel by pixel.** MY JUDGEMENT: keep it for your eye, not as a pass or fail. Font smoothing and line weights change pixels when nothing is wrong.

## 4. Finding weak tests and wrong figures by machine

1. **Mutation testing (Stryker.NET).** CONFIRMED (its release notes): version 5.0.0 of 11 Sep 2026 targets .NET 10, and 5.1.0 came out 10 Nov 2026.
   - **Settings:** CONFIRMED. `since` checks only changed code. `mutate` limits it to chosen files. `break-at` fails the run below a score. By default it runs one worker per two processor cores.
   - **Speed:** REPORTED (a user): about an hour for 1,300 tests even with two changed files. So limit it to the sums part, changed files only.
   - **Gain:** it finds "a cheat could pass this test" (99 mentions in the verdict pages) by machine.
2. **Property-based testing (CsCheck, FsCheck).** CONFIRMED: CsCheck 5 is current and shrinks any failure to the simplest example.
   - **Gain:** it throws thousands of random levels, grades, covers and mm, cm and m drawings at each sum. That is the 122 units mentions.
3. **Snapshot or approval testing (Verify).** CONFIRMED: it supports .NET 10 and NUnit.
   - **Licence:** REPORTED (one secondary site): commercial users must pay a small subscription for official releases from Aug 2026. Check before adopting.
   - **Gain:** every label and note written to a drawing becomes an approved file. A changed word shows as a highlighted difference, not a review finding.
4. **Architecture tests (ArchUnitNET).** CONFIRMED: maintained, version 0.13.5.
   - **Gain:** one rule, such as "only the sums part may work out a level", fails the build when a second place appears. That is the 21 mentions.

## 5. How other plug-in teams cut the time

1. **Splitting off the sums.** CONFIRMED (forum answers): this is the universal advice. Code that calls AutoCAD cannot be tested outside AutoCAD.
2. **Wrapping tests as commands and running them from a batch script, with a time limit that kills a hung session.** REPORTED (forum). This is the same as CETEST.
3. **Grouping tests by drawing.** REPORTED (Revit test framework fork). Opening a new model for each test slows runs badly.
4. **Revit's journal-driven runner.** REPORTED (forum). It "often crashed". In-app robots are fragile everywhere, which is why the safe place matters.
5. **Conference material.** Several Autodesk University classes exist on plug-in CI and testing (Revit 2019, Azure DevOps 2022, an AI spec-driven class in 2026). Their pages refused the fetch, so nothing in them is confirmed.

## 6. What agent-driven teams do

1. **Autodesk ships preview connection points (MCP servers) for Revit, with AutoCAD and Civil 3D listed.** REPORTED (search results, Nov 2026). They let an agent read and change a live model. None was found that tests a plug-in.
2. **Microsoft's guidance for agents testing Windows apps.** REPORTED: the agent reads the app's element tree, acts, and checks in plain words. It needs a real desktop session. This matches this project's window bench and desk driver.
3. **Research benchmarks.** REPORTED: computer-use agents complete about 20% of Windows tasks, against about 75% for people. MY JUDGEMENT: screen-clicking agents are too unreliable to be the main proof. Use them for a final look, not for the pass or fail.
4. **No write-up was found of an agent closing the loop inside AutoCAD itself.** This project would be early.

## RECOMMENDATION (the part to read)

**Change 1: Headless drawing checks on every build, run by the builder before hand-over (biggest gain).**

1. **What you would see:** each hand-over arrives with a line such as "Drawing checks in AutoCAD's engine: PASS 112 / FAIL 0", plus a saved test drawing for every scenario.
2. **What it proves:** pits, pipes, labels, levels, attributes, layers, masks and extension data really land in a drawing. It also proves Undo, and save then reopen. Typed prompts can be answered too.
3. **What it does not prove:** windows, grips, mouse picks, cursor previews and the ribbon.
4. **What it needs from you:** a yes to use the Core Console on test copies, with its own user-data folder, outside your hours or while your AutoCAD is closed. The current night rules ban it. Nothing changes your profile, licence or settings. Whether `/isolate` writes anything to the registry could not be confirmed, so a read-only check comes first.
5. **Confidence:** high. It is proven on this PC (Sep) and CETEST already exists.
6. **What could go wrong:** the console's lock means it cannot run while your AutoCAD is open. The plug-in's start-up could touch live files; the new path guard is there for that.

**Change 2: A sealed test computer, a Hyper-V virtual machine, for full-AutoCAD robot runs.**

1. **What you would see:** each morning, a one-page result plus a PDF of every test drawing on your phone.
2. **What it proves:** the real plug-in in real AutoCAD: windows opened and filled in by name, dynamic blocks, real typed EXPLODE and COPY, plots, and a "what changed" compare drawing.
3. **What it does not prove:** how a grip drag feels, or real job drawings.
4. **What it needs from you:**
   1. A yes.
   2. About an hour once to install AutoCAD and sign in yourself. Nobody else may sign in.
   3. Disk space: about 60 to 100 GB, MY JUDGEMENT. C: is tight, so it may need a second drive.
   4. A second seat if you want daytime runs. With one seat, runs happen only while your AutoCAD is shut.
5. **Confidence:** medium. Licensing is allowed per Autodesk but was seen only through search. Graphics speed inside the virtual machine is untested.
6. **What could go wrong:** sign-in prompts after network changes, slow graphics, and a disk that fills up.

**Change 3: Machine hunters at the builder's desk.** Stryker on changed sums files, CsCheck for the units and level sums, ArchUnitNET for "one place works out a number", and Verify for drawing text.

1. **What you would see:** fewer check rounds. Hand-overs list "weak tests found: 0".
2. **What it proves:** that the tests catch wrong figures. It does not prove the figures are right for council rules.
3. **What it needs from you:** nothing, apart from Verify's possible licence cost.
4. **Confidence:** high for ArchUnitNET and CsCheck; medium for Stryker's speed.
5. **What could go wrong:** long Stryker runs if not limited to changed files.

**Change 4: Golden drawings as text.** Approved test drawings are dumped to text and compared every run. Any difference goes to you as a picture.

1. **What you would see:** "3 drawings changed since you approved them", each with before and after pictures.
2. **What it needs from you:** to approve each golden drawing once.
3. **Confidence:** high.

**"How do we check that it works in AutoCAD from the drafting standpoint?" A ladder:**

1. **The machine alone, in seconds:** every sum, every unit case, every window at both sizes on the bench, every test strong enough to catch a wrong figure.
2. **The machine in AutoCAD's engine, in minutes, every build:** what lands in the drawing, Undo, save and reopen, typed prompt answers.
3. **The machine in full AutoCAD in the sealed test computer, nightly:** the windows filled in for real, real blocks and typed commands, PDFs and change drawings for you.
4. **Your eyes only, half an hour a week:** a grip drag, the feel of a window, and one real-style drawing plotted and read as a council engineer would.

**Looked for and could NOT confirm:**

1. **AutoCAD in Windows Sandbox:** no source found either way.
2. **Autodesk's virtualisation page:** read only through search snippets, because the page refused the fetch.
3. **The current Design Automation price for AutoCAD:** not found.
4. **Whether `/isolate` writes to the registry:** not found.
5. **Dynamic block state changes in the Core Console:** no source found.
6. **Any reliable automated grip drag in AutoCAD:** none found.
7. **What the Autodesk University classes on plug-in testing actually say:** their pages refused the fetch.
8. **How the RxBim runner starts AutoCAD:** not stated in its own pages.
9. **Verify's licence fee:** one secondary source only.

## Sources

1. AutoCAD Core Console help, 2026 — Autodesk Help — https://help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-Core-Console/files/AUTOCAD_CORE_CONSOLE.html
2. CADtest — GitHub (CADbloke) — https://github.com/CADbloke/CADtest
3. CADtest fork — GitHub (AHepker-HOB) — https://github.com/AHepker-HOB/CADtest
4. RxBim.AutocadTests.Cmd.2025 — NuGet — https://www.nuget.org/packages/RxBim.AutocadTests.Cmd.2025
5. RxBim.AcadTests — GitHub (ReactiveBIM) — https://github.com/ReactiveBIM/RxBim.AcadTests
6. cadwiki.NUnitTestRunner — NuGet — https://www.nuget.org/packages/cadwiki.NUnitTestRunner
7. JPP.AutocadNUnitTester.IntegratedRunner — NuGet — https://nuget.org/packages/JPP.AutocadNUnitTester.IntegratedRunner
8. RevitTest — GitHub (ricaun-io) — https://github.com/ricaun-io/RevitTest
9. Design Automation overview — Autodesk Platform Services — https://aps.autodesk.com/en/docs/design-automation/v3/developers_guide/overview
10. Design Automation rate limits and quotas — Autodesk Platform Services — https://aps.autodesk.com/en/docs/design-automation/v3/developers_guide/rate-limits/da-rate-limits
11. Estimate Design Automation costs — Autodesk Platform Services blog — https://aps.autodesk.com/blog/estimate-design-automation-costs
12. Virtualisation for admins — Autodesk (search snippets only) — https://www.autodesk.com/support/account/admin/manage/virtualization
13. How to use AutoCAD in a virtual environment — Autodesk AutoCAD blog (search result only) — https://blogs.autodesk.com/autocad/how-to-use-autocad-or-autocad-lt-in-a-virtual-environment
14. Single-user subscription on multiple computers — Autodesk Community — https://forums.autodesk.com/t5/installation-licensing/single-user-subscription-accessing-multiple-computers/td-p/7704100
15. Windows Sandbox overview — Microsoft Learn — https://learn.microsoft.com/en-us/windows/security/application-security/application-isolation/windows-sandbox/windows-sandbox-overview
16. How do you test commands? — Autodesk Community .NET forum — https://forums.autodesk.com/t5/net-forum/how-do-you-test-commands/m-p/12551471
17. accoreconsole, CommandMethod and user input — Autodesk Community — https://forums.autodesk.com/t5/net/accoreconsole-commandmethod-and-userinput/td-p/8568048
18. AcCoreConsole COMPAREEXPORT does not do anything — Autodesk Community — https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/accoreconsole-compareexport-does-not-do-anything/m-p/11212403
19. Different behaviour between accoreconsole and AutoCAD (PNG plot) — Autodesk Community — https://forums.autodesk.com/t5/visual-lisp-autolisp-and-general/different-behavior-with-same-scr-code-between-accoreconsole-exe/m-p/11233863
20. accoreconsole plotting Civil 3D objects — Autodesk Community — https://forums.autodesk.com/t5/autocad-forum/accoreconsole-plotting-civil-3d-objects/td-p/9144122
21. Stryker.NET releases — GitHub — https://github.com/stryker-mutator/stryker-net/releases
22. Stryker.NET configuration — stryker-mutator.io — https://stryker-mutator.io/docs/stryker-net/configuration/
23. Stryker.NET since vs baseline discussion — GitHub — https://www.github.com/stryker-mutator/stryker-net/discussions/2860
24. CsCheck — NuGet — https://www.nuget.org/packages/CsCheck
25. Verify — GitHub — https://github.com/VerifyTests/Verify
26. Verify review (licence note) — dev.co — https://dev.co/testing/open-source/verify
27. TngTech.ArchUnitNET — NuGet — https://www.nuget.org/packages/TngTech.ArchUnitNET
28. FlaUI — GitHub — https://github.com/FlaUI/FlaUI
29. Testing for DynamoRevit — Dynamo developer docs — https://developer.dynamobim.org/04-Testing/4-1-revit-testing.html
30. Revit Test Framework improvements — Autodesk Community — https://forums.autodesk.com/t5/revit-api-forum/revit-test-framework-improvements/m-p/8187537
31. AI-assisted testing of Windows apps — Microsoft Learn — https://learn.microsoft.com/en-us/windows/apps/develop/ai-assisted/testing
32. Windows Agent Arena — arXiv — https://arxiv.org/abs/2409.08264
33. Introducing the Revit Public MCP Server — Autodesk AEC blog — https://www.autodesk.com/blogs/aec/2026/06/17/revit-public-mcp-server/
34. Autodesk University class listings (pages refused the fetch) — Autodesk — https://www.autodesk.com/autodesk-university/class/Deploy-Better-Plugins-Faster-Through-CICD-and-Unit-Testing-Azure-DevOps-2022
35. This project's own records — `C:\CE_CIVIL\acad\NIGHT_TEST.md`, `C:\CE_CIVIL\BUILD_LOG.md` (entries 22 to 25), and the memory notes on the Core Console probe and the AutoCAD driver.
