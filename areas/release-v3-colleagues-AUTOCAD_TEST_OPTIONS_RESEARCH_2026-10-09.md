# Ways to test the CE plugin in AutoCAD besides Codex screen control (research, 9 Oct 2026)

Opus research helper, read-only. Nothing was built, installed, run in AutoCAD or changed in any repo. Written Fri 9 Oct 2026, about 22:00 Melbourne time, while the first Claude driver tester run (desk_jobs/tester01) was using AutoCAD, so nothing here touched AutoCAD.

## FOR TIM

1. **Answer:** yes. About eight tenths of what Codex clicks through by hand can be tested more cheaply by four other routes we already half own. Codex is then kept for what only a person can do: grips, hover, dragging, jigs, and "does it look right".
2. **Route 1, the typed driver (already built 3 Oct):** types complete commands into AutoCAD and fills CE windows by their names. It is the main daily tester. It costs no Codex points.
3. **Route 2, a "witness" (new, small):** a test-only recorder loaded into AutoCAD on test copies. It writes down every change to the drawing with the time. Example: after U it proves "nothing changed until REDO", instead of only "REDO still worked this once".
4. **Route 3, "what got drawn" checks:** the headless runs plus reading the saved test drawing and the printed PDF, compared with a saved good copy. Example: a pit label moved 2 mm or a sheet printed blank is caught without opening AutoCAD.
5. **Route 4, window pictures:** CE windows are already photographed outside AutoCAD in the tests. Comparing each new photo to the approved one catches a squashed or scrolling window overnight.
6. **Recommendation:** build Route 2 first, with one small trial: Pit Schedule level, U, wait, REDO, read the witness log.
7. **One decision for you (later, no rush):** AutoCAD 2022 to 2026 are not installed on this PC, so nobody can run CE on them here. Autodesk's cloud runner can. It needs an Autodesk developer account and costs a small amount per hour. Only made-up test drawings would ever go to it.

---

## How to read the details

Every claim carries one tag:

1. **[DOC]** documented fact, with a link.
2. **[SEEN]** observed on Tim's PC or in this project's own files (file named).
3. **[GUESS]** hypothesis, not yet checked. A pilot must prove it before anyone relies on it.

Autodesk's internals are closed. Where the documents say nothing, this file says **insufficient information** rather than guessing.

---

## 1. What already exists (read first)

1. **Typed-command and window driver** `C:\Lisp Files\_ACAD_DRIVER\acad_driver.ps1` (2,049 lines, README.md) [SEEN].
   - **What it does:** COM `SendCommand` of COMPLETE one-line commands into a running AutoCAD 2027, about 1 s per call. It reads the command history (LOGFILEMODE), reads system variables, and runs U, REDO and UNDO.
   - **CE windows:** the `ui` family drives them through Windows UI Automation by control name (`ui tree / read / type / click / close / scan / tabs`). It also runs timed journeys and the plain-English jargon scan.
   - **Guard rails:** test copies only, a deny list (SAVE, EXPORT, NETLOAD, PLOT, PUBLISH ...), a shared Claude/Codex lock, a wedge alarm, and `perf cpu`.
   - **Lessons:** a bare command left at a prompt wedged AutoCAD for 15 minutes. PostCommand queued text that never ran (run 4). COM is refused while a prompt waits.
2. **Headless proof** `tools\headless-proof\Run-HeadlessProof.ps1` and `Modules\Drainage.HeadlessProof` [SEEN].
   - **What it does:** runs CE Civil's real services inside `accoreconsole.exe` 2027. It gives 17 PASS/FAIL/BLOCKED checks plus the N1 sequence, on a blank template or a copy of a test drawing.
   - **Own list of what it cannot prove:** looks, mouse and keyboard, windows, Undo as a person uses it, AutoCAD 2022 to 2026.
3. **TH-01 harness** `Tests\CE.TestHarness*` [SEEN]. JSON scenarios with hash-locked fixtures run through accoreconsole. Output DWGs are checked with **ACadSharp 3.4.29** (`DwgAssertionRunner.cs`). It refuses to run while AutoCAD is open and records SKIPPED.
4. **Machine-wide lock** [SEEN, `docs\SMOKE_TEST_HARNESS_isolation_investigation.md`]. The core console cannot start while the full AutoCAD is open, even with `/isolate`. A machine-global Autodesk mutex holds the configuration file. Headless runs and driver runs must therefore take turns.
5. **Redo checker** `RedoSafeCallGraphTests` (Mono.Cecil call-graph scan) and the core-console REDO primitive checks [SEEN, `_TEST_COPIES_20260923\REDO_SAFETY_SECOND_REVIEW_20261009.md`].
   - **Blind spots:** async bodies, property sets, write-opens through helpers. The safe building blocks were measured only in the core console, which never fires Idle [SEEN, memory note accoreconsole-plugin-probe].
6. **WPF windows already render outside AutoCAD in unit tests** [SEEN].
   - **Examples:** `Modules\Drainage.Tests\Dialogs\WhatsNewWindowRenderTests.cs` and `CeNoScrollWindowProbe.cs` (RenderTargetBitmap to PNG). There are 87 test files touching windows. `Verify.NUnit` and `PdfPig` are already referenced.
   - **Missing:** no golden-image compare yet.
7. **Codex screen runner** `C:\Lisp Files\_CODEX_RUNNER` (queue3.sh, briefs, daily cap) [SEEN].
   - **Cost:** about 5 usage points a day, as the caller states. The memory note gives about 7% per test run.
   - **Lesson (3 Oct, verifyW1 19 of 19 BLOCKED):** Codex's click-by-accessibility-name does not work on AutoCAD windows on this PC, while screenshots plus coordinates do [SEEN, memory codex-autocad-test-runner].
   - **Foreground only:** Codex computer use on Windows takes over the foreground window. Nobody can use the PC during a pass [DOC, [Neowin](https://www.neowin.net/news/openai-rolls-out-major-codex-for-windows-update-with-computer-use-and-mobile-access/)].
8. **Installed on this PC** [SEEN, `C:\Program Files`]:
   - AutoCAD 2027 only. No 2022 to 2026, so the net48 and net8 lanes can only be built and unit-tested here, never run.
   - **ODA File Converter 27.1.0** is installed.

---

## 2. Autodesk's own supported routes

### 2.1 accoreconsole plus scripts

1. **Switches [SEEN]:** read straight from the usage text inside `C:\Program Files\Autodesk\AutoCAD 2027\accoreconsole.exe`, without running it:
   `AcCoreConsole.exe [/i <input dwg>] /s <script> [/product <product>] [/l <language>] [/isolate <userid> <userDataFolder>] [/readonly] [/p[rofile] <profile>] [/loadmodule <module>] [/supportfilesmap <file>]`.
   - **Undocumented extras:** the same binary also holds `autoisolate`, `presetautoisolate`, `cleanautoisolate` and `cleanisolate` strings. Their behaviour is **insufficient information**.
   - **Other sources:** the same list is given by Autodesk forum posts and ARKANCE [DOC, [Autodesk forum](https://forums.autodesk.com/t5/net-forum/accoreconsole-isolate-arguments/m-p/11320856), [ARKANCE tip 8551](https://www.cadforum.cz/cadforum/spusteni-autocadu-bez-grafickeho-okna-tip8551)]. ADN's skill notes an undocumented `/al` bundle-load switch that works locally with `/isolate` [DOC, ADN acad-api-skill, installed as the `autocad-net-api` skill].
2. **`/isolate`:** gives a separate HKCU root so system-variable changes do not leak into normal AutoCAD [DOC, forum above]. It does not beat the machine-wide lock [SEEN, 4 above].
3. **`/readonly`:** listed in the usage text. Its exact behaviour is **insufficient information** (the forum thread is also unclear).
4. **`/product`:** selects a vertical such as C3D. Not needed for CE, which runs on plain AutoCAD.
5. **What it can prove:** drawing-database results of CE's own services (geometry, layers, XData, labels, records, DXF and proxy graphics), fast and with no screen. **Measured** 54 s for a full headless run on a quiet PC, 5 to 11 minutes when busy [SEEN, headless README].
6. **What it cannot prove:**
   - **Windows:** none; AcMgd (the desktop UI assembly) is desktop-only [DOC, ADN skill: "acad.exe ONLY"].
   - **Ribbon, grips, jigs, previews:** none.
   - **Idle:** never fires [SEEN].
   - **Undo:** not as a person uses it, for the reason above. The REDO review found core-console results do not settle full-AutoCAD behaviour [SEEN].
   - **Layouts CE creates:** cannot be plotted. A layout made in the core console is not initialised for printing; only layouts made earlier plot [DOC, [ADN Japan DA notes](https://blog.autodesk.io/notes-on-using-da4a/)].

### 2.2 The AutoCAD .NET API test pattern (tests inside AutoCAD)

1. **Autodesk position:** code that touches the AutoCAD .NET API must be hosted in the AutoCAD process. Tests of it are integration tests run by an in-AutoCAD runner [DOC, [Autodesk forum: how to create unit testing for AutoCAD add-in](https://forums.autodesk.com/t5/net/how-to-create-unit-testing-for-autocad-add-in/td-p/10724527)].
2. **Community runners:** CADtest, `cadwiki.NUnitTestRunner` and `RevitDevTool.NUnit` host NUnit inside AutoCAD [DOC, [NuGet cadwiki.NUnitTestRunner](https://www-1.nuget.org/packages/cadwiki.NUnitTestRunner/1.0.0), [NuGet RevitDevTool.NUnit](https://www.nuget.org/packages/RevitDevTool.NUnit)]. Their 2027 / .NET 10 support is **insufficient information**.
3. **For CE:** the headless proof already is a home-made in-process runner (core console). The missing piece is the same idea inside the **full** AutoCAD: see the witness in section 4 and section 5, item 2.

### 2.3 COM automation (AcadApplication)

1. **Status [SEEN]:** this is what the driver already uses (`SendCommand`, `GetVariable`).
2. **Rejected calls [DOC]:** COM calls are rejected with RPC_E_CALL_REJECTED while AutoCAD is busy. Autodesk support recommends an IMessageFilter retry, and the behaviour dates from AutoCAD 2010 Update 1 [DOC, [Autodesk forum "AutoCAD busy"](https://forums.autodesk.com/t5/net-forum/autocad-busy/m-p/3241164/highlight/true)]. That matches the driver's `busy` handling [SEEN].
3. **Limits:**
   - It cannot see inside CE's windows; that needs UI Automation.
   - It cannot drag, grip or hover.
   - A command left waiting at a prompt blocks every later COM call [SEEN].

### 2.4 Design Automation for AutoCAD (Autodesk's cloud core console)

1. **What it is [DOC]:** Activities, AppBundles, Engines and WorkItems; the engine is accoreconsole in the cloud [DOC, [APS field guide](https://aps.autodesk.com/en/docs/design-automation/v3/developers_guide/field-guide), [Task 4 publish an activity](https://aps.autodesk.com/en/docs/design-automation/v3/tutorials/autocad/task4-publish-activity)].
2. **Engines [DOC]:** AutoCAD 2027 = `Autodesk.AutoCAD+26_0`, released 30 Mar 2026, needs .NET 10. Older engines **24_1 to 25_1 (AutoCAD 2022 to 2026)** are still live, the earliest until 29 Mar 2027 [DOC, [APS blog 9 Apr 2026](https://aps.autodesk.com/blog/end-autocad-2021-engine-new-autocad-2027-engine-released)].
   - **Why it matters:** this is the **only route found that runs CE's net48 and net8 code in real AutoCAD 2022 to 2026 engines** without installing those versions.
3. **Limits [DOC]:**
   - No ActiveX/COM.
   - No OPEN or NEW.
   - Default 100 s per WorkItem, 900 s at most, upload and download included.
   - Only pre-initialised layouts plot.
   - Fonts must be bundled.
   - Damaged DWGs fail.
   - No custom software or drivers [DOC, [ADN DA notes](https://blog.autodesk.io/notes-on-using-da4a/)].
   - Plugins must not depend on AcMgd [DOC, ADN skill].
4. **Cost [DOC]:** 2 Flex tokens per processing hour [DOC, APS pricing per search summary of [APS full access](https://aps.autodesk.com/node/2561)]. The Australian dollar price of a Flex token is **insufficient information** here.
5. **CE-specific risks:**
   - [GUESS] CE_CVL_SUITE.dll references AcMgd. Locally it loads in the core console because the reference resolves from the install folder and only the methods that touch it fail. In the cloud, acmgd.dll may be absent; the headless probe's reflection pattern would need proving there.
   - **Data:** under DATA-01, only synthetic drawings may ever be uploaded, never a client job.
6. **Use:** a nightly "does the 2022 to 2026 lane still draw the right thing" regression. It is no use for windows, Undo, ribbon or looks.

### 2.5 AutoCAD 2027 specifics

1. **Runtime [DOC]:** .NET 10, VS 2026 toolset v145, R26.0 registry series [DOC, APS blog above].
2. **Already seen in this project [SEEN]:**
   - Model space is spelt differently, which once refused every label (MODELSPACE-CASE-01).
   - Loading Civil by name runs its start-up, so the headless runner flips the unified-host switch.
   - The 2027 install has a machine-wide config lock.
3. **DWG format:** AC1032 has been the format since AutoCAD 2018 [DOC, [ARKANCE DWG versions](https://www.cadforum.cz/cz/qaid.asp?ID=253)]. Whether AutoCAD 2027 introduced a newer format is **insufficient information**. ACadSharp lists AC1032 as its newest [DOC, [ACadSharp GitHub](https://github.com/DomCR/ACadSharp)]. TH-01 already reads 2027 output with it, so it is at least AC1032-compatible [SEEN].

### 2.6 Built-in AutoCAD helpers worth knowing

1. **Action Recorder (ACTRECORD):** records typed commands for playback but **not dialog-box input**; the hyphen command forms are recommended [DOC, [Autodesk blog: action macros](https://www.autodesk.com/blogs/autocad/action-macros-in-autocad/)]. It adds nothing over the driver and cannot drive CE windows. Not recommended.
2. **DWG Compare (COMPARE):** highlights added, changed and removed objects between two drawings with revision clouds [DOC, [AutoCAD 2027 help: To work with comparing drawings](https://help.autodesk.com/cloudhelp/2027/ENU/AutoCAD-LT/files/GUID-744D8A49-D582-4C06-80B1-6B0313E92CA2.htm)].
   - **Good for:** a human "what changed" picture.
   - **Not good for:** automated pass/fail. It opens a file dialog, and its result lives in the drawing.
3. **System variables useful as oracles:**
   - **DBMOD:** 0 means no unsaved changes. `Document.PushDbmod/PopDbmod` exist [DOC, forum summary of [Autodesk forum: check if user has done something](https://forums.autodesk.com/t5/net-forum/check-if-user-has-done-something-after-opening-a-drawing/m-p/12766669/highlight/true)].
   - **UNDOCTL:** a read-only bit code: 1 on, 2 one, 4 auto, 8 group active [DOC, [AutoCAD help U system variables (2015 page)](https://help.autodesk.com/cloudhelp/2015/ENU/AutoCAD-MAC-Core/files/GUID-C637D698-046C-4B58-93D0-B1DD72C8284D.htm)]. Tim's PC reads 53 [SEEN, memory acad-driver-cli]. The 2027 meaning of bits 16 and 32 is **insufficient information** (the 2027 page was not reachable).
   - **UNDOMARKS:** counts UNDO Mark marks [DOC, same page].

---

## 3. UI automation of Windows apps

1. **Microsoft UI Automation (UIA)** [DOC, [Microsoft Learn: UI Automation overview](https://learn.microsoft.com/dotnet/framework/ui-automation/ui-automation-overview), [Using UI Automation for automated testing](https://learn.microsoft.com/dotnet/framework/ui-automation/using-ui-automation-for-automated-testing)].
   - **What it is:** the Windows accessibility tree, used by test tools.
   - **WPF:** controls provide it natively, and a WPF button's Content maps to the UIA Name. Win32 controls get it through operating-system proxies.
   - **Limit:** it cannot cross "Run as" user boundaries.
   - **Fit for CE:** CE windows are WPF, so they expose names, values and patterns. That is why the driver's `ui` commands work [SEEN, UI_MAP_2026-10-03].
2. **The AutoCAD ribbon is visible to UIA** [SEEN, `_ACAD_DRIVER\ui_map\ribbon_maintabs.txt`].
   - **Found:** the tab buttons carry real ids `CE_CVL_SUITE_TAB`, `CE_STRUC_SUITE_COMMANDS_TAB` and `CE_TOOLS_TAB`.
   - **Snag:** panel buttons all share the id `mButton`, so they must be found by Name. Inactive-tab panels are not in the tree until the tab is selected [SEEN, UI_MAP lines 106-111].
   - **What it allows:** reading the ribbon (labels, enabled state, which contextual tab shows when a pit is selected) without a screen agent. Pressing ribbon buttons through UIA is [GUESS]: the Invoke pattern on AdWindows buttons has not been tried.
3. **Where UIA is weak:**
   - **Drawing area:** it is one opaque window, so objects, grips and the jig preview are not in the tree.
   - **Hidden settings:** default/Enter button and Esc behaviour are not readable [SEEN, driver README].
   - **No ids:** Pit Schedule cells and TabItems have no AutomationId [SEEN].
   - **Fix on our side:** add `AutomationProperties.AutomationId` (and Name) to every CE control a test needs. Microsoft recommends checking the full set of Names as part of testing [DOC, Microsoft Learn UIA testing page above].
4. **Libraries** (the driver needs none of them; it uses .NET's built-in `System.Windows.Automation`) [SEEN, 38 references in acad_driver.ps1]:
   - **FlaUI:** MIT, wraps UIA2 and UIA3. UIA3 is better for WPF, UIA2 for WinForms; active project [DOC, [FlaUI GitHub](https://github.com/FlaUI/FlaUI)].
   - **pywinauto:** win32 and uia back ends [DOC, [pywinauto getting started](https://pywinauto.readthedocs.io/en/latest/getting_started.html)]. Python adds a second language for no gain here.
   - **WinAppDriver:** Microsoft no longer maintains it. Appium's Windows driver still proxies through it [DOC, [AutomateThePlanet migration guide](https://www.automatetheplanet.com/winappdriver-to-appium-migration-guide/)]. Not recommended.
   - **Accessibility Insights for Windows:** 60+ automated UIA rule checks with a saved snapshot and screenshot [DOC, [Accessibility Insights automated checks](https://accessibilityinsights.io/docs/windows/getstarted/automatedchecks/)]. A command-line mode was not confirmed (**insufficient information**). The driver's `ui scan` already covers the CE-specific jargon rules.
5. **Golden images: window pictures**
   - **Already there:** CE windows render to PNG outside AutoCAD in unit tests [SEEN, section 1 item 6].
   - **What to add:** a stored approved PNG per window and theme, and a pixel-difference check with a small tolerance. Verify.NUnit is already referenced; its image-compare plug-ins are [GUESS] untested here.
   - **Stability:** rendering outside AutoCAD is deterministic. Screenshots of the live AutoCAD screen are not (GPU, anti-aliasing, cursor, DPI, client names in the Recovery Manager [SEEN, memory acad-driver-cli]). Use live screenshots as evidence only, never as pass/fail.
6. **Golden images: plotted PDFs**
   - **Text level:** PdfPig, already referenced, reads text and positions. The computations sheet tests use it [SEEN].
   - **Raster compare:** render each page to PNG and compare with diff-pdf or ImageMagick `compare` [DOC, [diff-pdf](https://vslavik.github.io/diff-pdf/) via [linuxcommandlibrary](https://linuxcommandlibrary.com/man/diff-pdf), [diff-pdf-visually](https://github.com/bgeron/diff-pdf-visually)].
   - **Warning [DOC]:** Windows' built-in renderer `Windows.Data.Pdf` can **drop dashed lines** (it uses Edge Legacy features). Microsoft points to PDFium instead [DOC, [Microsoft Learn troubleshoot](https://learn.microsoft.com/troubleshoot/windows/win32/converting-pdf-file-to-bitmap-image)]. Engineering sheets are full of dashed linetypes, so do not use it for drawing PDFs.
7. **"What got drawn" checks on DWG**
   - **ACadSharp:** reads DWG and DXF AC1014 to AC1032 in plain .NET, with AutoCAD open, in seconds [DOC, ACadSharp GitHub; SEEN, TH-01].
   - **ODA File Converter (installed, 27.1.0):** batch DWG to DXF/DWG with audit and recursion [DOC, [ODA converter page](https://www.opendesign.com/guestfiles/oda_file_converter.md)]. The exact command-line syntax was not on that page (**insufficient information**). Licence: ODA describes a trial ("free for 60 days"); permanent free terms were not confirmed here.
   - **Use:** a fallback when ACadSharp cannot read an object, and a neutral "can another reader open it" check for colleagues without CE.
   - **CE custom objects:** the C7 pipe object is invisible to both readers. Read its proxy graphics (DXF 97/310), which headless check UX-MIX-01 already does [SEEN].
8. **Event recording and replay:** Windows Steps Recorder is retired, and ACTRECORD cannot record dialogs. For CE the "recording" should be the driver's journey files (`journeys\*.json`) plus the AutoCAD log. Replay = `journey run`.

---

## 4. Computer-use agents (Codex screen control, Claude computer use)

1. **Cheaper and more reliable [DOC, [Anthropic best practices for computer use](https://claude.com/resources/articles/best-practices-for-computer-and-browser-use-with-claude)]:**
   - downscale screenshots to about 1280x720;
   - zoom into dense areas before clicking;
   - prefer keyboard shortcuts over tiny targets;
   - batch mechanical steps that need no look;
   - keep only recent screenshots;
   - use medium thinking for mechanical work;
   - log a screenshot per step;
   - teach by a recorded successful run.
2. **For CE specifically:**
   - **Scripted setup, not clicking:** the driver opens the test copy, sets the system variables, places the pit with typed coordinates and opens the CE window. The agent then does only the one human-only action (grip drag, hover, ribbon look) and the driver reads back the result. Each pass shrinks from dozens of screen steps to a handful. [GUESS] at a third to a half of today's points per item.
   - **Coordinates from a fresh screenshot:** Codex accessibility-name targeting failed on AutoCAD [SEEN].
   - **Evidence by the driver:** history lines, system variables, `ui read` values, witness log. Screenshots are only for looks.
   - **Wake-the-display rule:** keep the display on for the pass. The runner can ask Windows to keep the display on for its own process (`SetThreadExecutionState(ES_DISPLAY_REQUIRED)`) instead of changing power settings [DOC, [Microsoft Learn SetThreadExecutionState](https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-setthreadexecutionstate)]. [GUESS] a locked screen stops screenshots and input for both agents, so the PC must stay unlocked and nobody may use it [SEEN, memory: Codex loses window control if Tim uses the PC].
   - **One AutoCAD driver at a time:** use the shared lock, and run Codex after the driver releases it [SEEN, driver lock].
3. **Division of labour (recommended):**
   - **Logic and data:** unit tests and the Cecil guards. Free, every build.
   - **"What got drawn":** headless proof, TH-01 and ACadSharp. Runs only when AutoCAD is closed.
   - **Typed commands, U/REDO, system variables, CE window values, ribbon labels, timing:** the driver plus UIA plus the witness. Full AutoCAD, no Codex points.
   - **Window looks:** offscreen PNG golden images. Free, every build.
   - **Human-only:** Codex or Claude computer use, a few items a day: grips, hover tooltips, jigs and live previews, right-click menus, drag and drop, ribbon icon look, "does the sheet look right". Tim only for engineering judgement and final acceptance.

---

## 5. Testing Undo/Redo and "nothing written between U and REDO" more strongly

1. **Today's oracle is the outcome only** [SEEN]: U, wait, REDO, then read the command history for "Everything has been redone". It proves that one walk worked. It does not show a write that happened and was harmless, a write that would break REDO under other timing, or which code did it.
2. **Add a witness: a test-only in-process recorder** [GUESS for the design; DOC for each event]. It is a tiny separate DLL with no reference to CE, loaded into the full AutoCAD on test copies only, never shipped. It only listens and writes a JSONL line per event with a high-resolution timestamp:
   - `Document.CommandWillStart / CommandEnded / CommandCancelled / CommandFailed` [DOC, offline 2027 API reference `C:\Autodesk\ObjectARX2027\docs-html\arxmgd\Autodesk_AutoCAD_ApplicationServices_Document_CommandEnded.html`];
   - `DocumentCollection.DocumentLockModeChanged`: "given every time a lock is established or removed". Unlocks carry a command name prefixed `#`. It reports the global command name, which shows who locked the drawing outside a command [DOC, offline page `..._DocumentCollection_DocumentLockModeChanged.html`];
   - `Database.ObjectAppended / ObjectModified / ObjectErased` [DOC, offline `..._Database_ObjectModified.html`, "Wraps AcDbDatabaseReactor::objectModified"];
   - `Application.SystemVariableChanged` [DOC, offline `..._Core_Application_SystemVariableChanged.html`];
   - `Application.Idle` count, and `Document.LispWillStart`;
   - read-only snapshots at each command end: `Database.UndoRecording` ("true if undo recording is enabled") [DOC, offline `..._Database_UndoRecording.html`], DBMOD, UNDOCTL and UNDOMARKS.
3. **The assertion:** between the CommandEnded of U (or UNDO/MREDO) and the CommandWillStart of REDO, the log must hold zero ObjectAppended/Modified/Erased events, zero lock events, zero system-variable changes and no LISP start. Anything found names the event and time, so it can be matched to the CE log.
   - **Why it is stronger:** it is independent of CE's own code and of the Cecil guard, so it does not share their blind spots (async, property sets, helper write-opens). It sees what AutoCAD actually did.
   - [GUESS] Object events also fire for reads that do not modify. The AutoCAD documentation is silent on whether an open-for-write that changes nothing raises ObjectModified (**insufficient information**). The pilot must calibrate this with a known-harmless and a known-harmful action.
4. **Undo-stream hooks:** ObjectARX has editor reactor notifications for UNDO subcommands (Mark, Back, Auto, Control, Number). ODA's equivalent class documents them [DOC, [ODA OdEditorReactor undoSubcommand*](https://docs.intellicad.org/files/oda/2022_12/oda_drawings_docs/OdEditorReactor__undoSubcommandNumber@int@int.html)], and AutoLISP's `vlr-undo-reactor` exposes them [DOC, [AutoCAD AutoLISP vlr-undo-reactor](https://help.autodesk.com/cloudhelp/2016/ENU/AutoCAD-AutoLISP/files/GUID-184F011B-8B61-4D3F-82F3-06A75C4459AE.htm)]. A managed .NET equivalent was not found in the 2027 reference (**insufficient information**). Command-name events cover U, UNDO, REDO and MREDO well enough.
5. **Undo-mark inspection:** UNDOMARKS and UNDOCTL read through `getvar` do not touch the undo stack [SEEN, driver README]. Reading them before and after each CE command shows whether CE leaves a group open (bit 8) or changes the mark count.
6. **Loading the witness:** the driver deliberately refuses NETLOAD [SEEN, deny list line 46]. Options, all needing Tim's OK because they change a safety rule:
   - **(a)** a driver sub-command `witness load` that NETLOADs exactly one hash-checked DLL from one fixed folder, test copies only (FILEDIA is already on the setvar allow-list);
   - **(b)** start AutoCAD for test sessions with a start-up script (`acad.exe /b`, a documented switch [DOC, [AfraLISP command-line switches](https://www.afralisp.net/autocad/tutorials/command-line-switches.php)]) through a shortcut handed to Explorer.
   - **Risk:** SECURELOAD may show a trust prompt for an untrusted folder, and a prompt left waiting wedges COM [SEEN, wedge lesson]. The pilot must prove there is no prompt first.
7. **An instrumented CE build instead?** Optional. CE's own `RedoWindowGuard` already knows when the window opens and closes [SEEN, REDO review]. A Settings switch "Record redo-window activity" (Settings-first rule) could log every guarded deferral. It complements the witness but shares CE's blind spots, so the witness comes first.
8. **Routes to walk with driver plus witness:** section 4 (a) to (i) of the REDO review. The typed ones are (c), (d), (e), (f), (g); (b) and (h) need a click or hover, so Codex. Tonight's tester01 job covers part of the typed set with outcome-only evidence [SEEN, desk_jobs/tester01_job_latest.txt].

---

## 6. Ranked recommendation for this project

### 1. Witness recorder plus driver for Undo/Redo and "what CE did between commands" (adopt first)

1. **Effort:** small to medium. One DLL of about 200 lines (events and JSONL only), one driver sub-command or start-up script, one log reader that prints PASS/FAIL.
2. **What it proves:** in full AutoCAD, on Tim's real setup (all three modules loaded), that nothing changed the drawing, took a lock or set a system variable between U and REDO, for every typed route. It also gives a timestamped "who wrote what" record for any CE command, usable for all later acceptance runs.
3. **What it cannot prove:**
   - routes that need a click, hover or grip (those still need Codex, but Codex then only does the click while the witness records);
   - why a write happened (pair it with the CE log);
   - AutoCAD 2022 to 2026.
4. **Risks:**
   - loading test code into Tim's AutoCAD profile (keep it per session, never in a bundle);
   - a trust prompt wedging COM;
   - event handlers adding main-thread work (keep them to one append per event, no drawing reads);
   - mis-calibration of "read versus write" events (calibrate first).
5. **First pilot:** on a copy of DWG-B, in a free window, with the lock:
   - load the witness;
   - PITSCHEDULE route as W35 (driver plus `ui type` for the level, close);
   - U, wait 12 s, REDO;
   - also one deliberate spoiler (`_.REGEN` in the wait, which W35 showed gives "Nothing to redo") to prove the witness catches a known breaker.
   - **PASS** = clean log on the first walk AND the spoiler is visible in the log.

### 2. "What got drawn" golden checks: headless proof plus ACadSharp plus PDF compare

1. **Effort:** medium, spread out. Each new check is one method in the headless proof or one JSON scenario; the PDF compare is one helper.
2. **What it proves:**
   - geometry, layers, labels, XData records, proxy graphics, schedules and criteria tables in the saved drawing;
   - sheet text and layout in the PDF against an approved copy.
   - It runs with no screen, and the ACadSharp side runs even with AutoCAD open.
3. **What it cannot prove:** windows, Undo, Idle behaviour, plotting of layouts CE creates in the core console [DOC], or looks beyond pixel difference.
4. **Risks:**
   - the core console refuses while AutoCAD is open [SEEN], so schedule runs in free windows;
   - golden copies go stale when Tim changes a standard, so each needs a dated owner;
   - Windows.Data.Pdf drops dashes [DOC];
   - CE custom objects are opaque to outside readers.
5. **First pilot:** the CDCALC criteria table.
   - The headless proof already places it. Add one TH-01 scenario that saves the output DWG, and assert with ACadSharp the table's top-left point, row count and NOT SET wording.
   - Then plot that sheet once in full AutoCAD by hand (the driver refuses PLOT) and store the PDF as golden. Compare text with PdfPig and pages with diff-pdf at a stated fuzz.

### 3. Window pictures and ribbon contract (cheap, every build)

1. **Effort:** small. The PNG renders exist; add an approved PNG per window and theme, a pixel-difference check, and a UIA ribbon read in the driver (`ui tree` on `mMainTabs` and each CE tab).
2. **What it proves:**
   - each CE window opens at the right size, does not scroll, has no clipped text and matches the approved look;
   - the ribbon shows the expected CE tabs and button labels, and the contextual tab appears when a pit is selected.
3. **What it cannot prove:** that a window behaves right inside AutoCAD (owner window, focus, Enter/Esc), real icons at real DPI, or that a ribbon button runs the right command (that needs a press, [GUESS] via UIA Invoke).
4. **Risks:**
   - noisy diffs from font or DPI changes on the build machine (pin the render size and theme);
   - golden images approved by nobody (only Tim or a Codex-accepted pass approves a new golden).
5. **First pilot:** the Edit Pit and Edit Pipe one-page windows, light and dark.
   - Store today's PNGs as golden. Change one label length on a branch and confirm the compare fails with a picture of the difference.
   - Separately, one driver `ui tree "Autodesk AutoCAD 2027" ` read of the CE tabs, compared with the ribbon list in the plan.

### 4. Later, each needing Tim's decision

1. **Design Automation for AutoCAD 2022 to 2026:**
   - the only found way to run the net48 and net8 lanes in real engines [DOC];
   - needs an APS developer account and Flex tokens [DOC], synthetic drawings only, and proof that CE loads without AcMgd in the cloud [GUESS].
   - Effort medium to large.
2. **A second test machine or virtual machine with AutoCAD 2027 and the driver:** overnight runs without taking Tim's PC. Whether Tim's Autodesk subscription allows it is **insufficient information** (licence terms not checked).
3. **Screen agents:** keep Codex for the human-only list in section 4.3, with driver-scripted setup and driver-read evidence. Target a handful of items a day within the current points.

---

## 7. I did not check

1. Any behaviour by running it: no AutoCAD, accoreconsole, FlaUI, ODA converter, diff-pdf or Design Automation was run. The accoreconsole switches were read from the binary's text only.
2. Whether `/readonly`, `autoisolate`, `presetautoisolate` or `/al` behave as named on AutoCAD 2027.
3. The 2027 help page for UNDOCTL and UNDOMARKS (the 2027 URL returned 404; the 2015 page was used). The meaning of UNDOCTL bits 16 and 32.
4. Whether ObjectModified fires for an open-for-write with no change, or for open-close reads, in AutoCAD 2027.
5. Whether NETLOAD of a test DLL from a non-trusted folder shows a SECURELOAD prompt on Tim's profile, and what TRUSTEDPATHS holds.
6. Whether UIA Invoke presses AutoCAD ribbon buttons, and whether inactive-tab panels can be read without selecting the tab.
7. Whether CE_CVL_SUITE.dll can be loaded in the Design Automation cloud engines, the Australian price of a Flex token, and whether CE's net48 build loads in engines 24_1 to 24_3.
8. ODA File Converter's exact command-line syntax and licence terms for this installed copy.
9. Whether Verify.NUnit's image-compare add-ons work with the repo's NUnit 3.14 and the three target frameworks.
10. Autodesk licence terms for a second machine or virtual machine.
11. Codex's own internal targeting method on Windows. The public articles do not say whether it uses screenshots, the accessibility tree or both.
12. The result of tonight's Claude driver tester run (tester01). It was still running when this was written.

## Sources (all links used above)

1. Autodesk forum, accoreconsole isolate arguments: https://forums.autodesk.com/t5/net-forum/accoreconsole-isolate-arguments/m-p/11320856
2. ARKANCE, AutoCAD without a graphics window: https://www.cadforum.cz/cadforum/spusteni-autocadu-bez-grafickeho-okna-tip8551
3. ADN Japan, notes on Design Automation for AutoCAD: https://blog.autodesk.io/notes-on-using-da4a/
4. APS Design Automation field guide: https://aps.autodesk.com/en/docs/design-automation/v3/developers_guide/field-guide
5. APS tutorial, publish an activity: https://aps.autodesk.com/en/docs/design-automation/v3/tutorials/autocad/task4-publish-activity
6. APS blog, AutoCAD 2027 engine released: https://aps.autodesk.com/blog/end-autocad-2021-engine-new-autocad-2027-engine-released
7. APS full access and Flex: https://aps.autodesk.com/node/2561
8. Autodesk forum, unit testing an AutoCAD add-in: https://forums.autodesk.com/t5/net/how-to-create-unit-testing-for-autocad-add-in/td-p/10724527
9. NuGet cadwiki.NUnitTestRunner: https://www-1.nuget.org/packages/cadwiki.NUnitTestRunner/1.0.0
10. NuGet RevitDevTool.NUnit: https://www.nuget.org/packages/RevitDevTool.NUnit
11. Autodesk forum, AutoCAD busy (COM rejected): https://forums.autodesk.com/t5/net-forum/autocad-busy/m-p/3241164/highlight/true
12. ARKANCE, DWG format versions: https://www.cadforum.cz/cz/qaid.asp?ID=253
13. ACadSharp: https://github.com/DomCR/ACadSharp
14. Autodesk blog, action macros: https://www.autodesk.com/blogs/autocad/action-macros-in-autocad/
15. AutoCAD 2027 help, comparing drawings: https://help.autodesk.com/cloudhelp/2027/ENU/AutoCAD-LT/files/GUID-744D8A49-D582-4C06-80B1-6B0313E92CA2.htm
16. Autodesk forum, DBMOD and PushDbmod: https://forums.autodesk.com/t5/net-forum/check-if-user-has-done-something-after-opening-a-drawing/m-p/12766669/highlight/true
17. AutoCAD help, U system variables (UNDOCTL, UNDOMARKS): https://help.autodesk.com/cloudhelp/2015/ENU/AutoCAD-MAC-Core/files/GUID-C637D698-046C-4B58-93D0-B1DD72C8284D.htm
18. Microsoft Learn, UI Automation overview: https://learn.microsoft.com/dotnet/framework/ui-automation/ui-automation-overview
19. Microsoft Learn, using UI Automation for automated testing: https://learn.microsoft.com/dotnet/framework/ui-automation/using-ui-automation-for-automated-testing
20. FlaUI: https://github.com/FlaUI/FlaUI
21. pywinauto: https://pywinauto.readthedocs.io/en/latest/getting_started.html
22. WinAppDriver to Appium migration: https://www.automatetheplanet.com/winappdriver-to-appium-migration-guide/
23. Accessibility Insights automated checks: https://accessibilityinsights.io/docs/windows/getstarted/automatedchecks/
24. diff-pdf: https://linuxcommandlibrary.com/man/diff-pdf
25. diff-pdf-visually: https://github.com/bgeron/diff-pdf-visually
26. Microsoft Learn, Windows.Data.Pdf drops dashed lines: https://learn.microsoft.com/troubleshoot/windows/win32/converting-pdf-file-to-bitmap-image
27. ODA File Converter: https://www.opendesign.com/guestfiles/oda_file_converter.md
28. Anthropic, best practices for computer and browser use: https://claude.com/resources/articles/best-practices-for-computer-and-browser-use-with-claude
29. Neowin, Codex computer use on Windows: https://www.neowin.net/news/openai-rolls-out-major-codex-for-windows-update-with-computer-use-and-mobile-access/
30. Microsoft Learn, SetThreadExecutionState: https://learn.microsoft.com/windows/win32/api/winbase/nf-winbase-setthreadexecutionstate
31. ODA OdEditorReactor undo subcommands: https://docs.intellicad.org/files/oda/2022_12/oda_drawings_docs/OdEditorReactor__undoSubcommandNumber@int@int.html
32. AutoLISP vlr-undo-reactor: https://help.autodesk.com/cloudhelp/2016/ENU/AutoCAD-AutoLISP/files/GUID-184F011B-8B61-4D3F-82F3-06A75C4459AE.htm
33. AfraLISP, AutoCAD command-line switches: https://www.afralisp.net/autocad/tutorials/command-line-switches.php
34. Offline AutoCAD 2027 managed API reference on this PC: `C:\Autodesk\ObjectARX2027\docs-html\arxmgd` (Document_CommandEnded, DocumentCollection_DocumentLockModeChanged, Database_ObjectModified, Database_UndoRecording, Core_Application_SystemVariableChanged pages).
