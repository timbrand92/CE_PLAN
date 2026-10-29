# Research Scout (CE 08): what others have built or documented that helps us (Thu 29 Oct 2026)

Job `CE 08 Research Scout`, Sonnet. Read-only research: web pages and files on this PC were read, nothing was downloaded, installed, run or built, and AutoCAD, the robot and Codex were not started. Each round is added below; the index is `RESEARCH_INDEX.md`. Rounds so far: round 1, testing without taking over the PC (29 Oct, about 11:50 to 12:50 Melbourne, PC clock).

How to read the tags: **[READ]** means I read it on a page or file this round; **[SEARCH]** means it comes from a search summary, not a page I opened; **[GUESS]** is my reading. Where nothing was found I say "not found".

---

## ANSWER FIRST (ROUND 1B, FREE ONLY): FOR TIM

**UPDATE 29 Oct, later (Tim): "we have as many licenses as we need dont worry about this, the rest i am happy with if you can implement".** So (a) the licence question is closed: find 1 below and G1 are withdrawn, the spare PC and the core-console experiment can use any seat they need, and the one-at-a-time worry is dropped; (b) Tim approves the rest in principle. I cannot build or run anything (my brief forbids AutoCAD, the robot, Codex and builds), so "implement" means: I did the read-only check of the six pointer cases myself (result below, **find 4 is mostly refuted**), CE 02 had already added the unlocked-desktop step to the test-PC prompt (step 4b), and the remaining trials are handed to CE 02 with Tim's go-ahead.

**Six pointer cases checked by reading their STEPS (29 Oct, read only, `C:\Lisp Files\_ACAD_DRIVER\cases`):**
1. **N05, N20, N25:** the label, cover and callout points come after a CE window, and the case files say typed text is refused ("BUSY") while CE waits at that prompt, so they use real mouse clicks. A typed coordinate cannot reach that prompt, so my "type the pick" idea does not work for them.
2. **R08:** the real mouse pick is the thing being tested (a pick of pit P3 between U and REDO, with no runner read in between). Typing would change the test.
3. **R09:** a real double-click. **R01:** a hover. Neither can be typed.
4. **So 0 of 6 can drop the real mouse by typing.** The only way is a CE-side test hook that feeds prompt answers (a production-code change; not recommended without Tim's word). The real mouse stays for these six, so a second PC with its own screen remains the way to stop them disturbing Tim.

Tim, 29 Oct 2026, after round 1: "im not paying for anything else, we need to do proper research on open source and other options". From now on this scout recommends only free or already-owned things. Anything that costs money is listed as **parked (paid)** and not recommended. Round 1 below is kept, but its top five is **superseded** where it relied on a paid item (the developer membership and the cloud runner).

1. **The honest answer on your main wish (testing while you work, without touching your PC).** I found no free way to run a second real AutoCAD while yours is open. Autodesk's own terms, as quoted on its forums, let one subscription be installed on three PCs but used on **one at a time** [SEARCH]. So the real free questions are two: does the office already own a spare AutoCAD seat, and does the headless "core console" take a seat at all. Both are cheap to find out.

2. **Top five free finds, most helpful first.**

   1. **Ask the office admin (free) what AutoCAD licences exist and whether any seat is unassigned. Who: CE 04 asks you; the admin answers.**
      - **Why:** a spare seat, or the spare PC already having its own licence, answers the licence question for nothing. You said the spare PC "has AutoCAD on it already". Look in Autodesk Account, Products and Services, and User Management.
      - **If there is no spare seat:** the spare PC can still run the robot at night and on weekends on your own login, as long as your own AutoCAD is closed. That is what Autodesk's one-at-a-time rule allows. It gains no extra hours, but it frees your PC and its screen.

   2. **Run the "no screen" AutoCAD (core console) on the spare PC or a free virtual PC, and test whether it uses a licence seat. Who: CE 02, one 30-minute experiment.**
      - **Why:** on your own PC the core console cannot start while your AutoCAD is open. CE's old investigation found the block is one machine-wide Autodesk lock, not anything about your profile, and logging in as a different Windows user would not get round it [READ, `docs/SMOKE_TEST_HARNESS_isolation_investigation.md`; my reading of the second half]. A different PC, or a virtual PC, has its own lock.
      - **Free tools:** the spare PC (no virtual PC needed); or Hyper-V (built into Windows Pro, free, needs the admin to switch it on and restart); or VMware Workstation Pro, which Broadcom made free for commercial use from version 17.5.2 (needs a Broadcom sign-in) [SEARCH]. The core console needs no graphics card, so the earlier "slow virtual graphics" worry does not apply.
      - **The unknown:** nobody has established whether the core console takes a seat, and Autodesk's forums have two old questions with no answer [SEARCH]. The experiment settles it: run one headless check on the spare PC while your own AutoCAD is open, and see if either session is signed out.
      - **Effect:** the 9 typed-command cases and the saved-drawing checks could run any time, with no screen, mouse or keyboard.

   3. **Run many logic checks in one AutoCAD start with a test command (Autodesk's free sample, already on this PC). Who: CE 02 (it is the unfinished CCR-01 STEP 2).**
      - **Why:** every robot AutoCAD start costs about 33 seconds, and a third of the robot's clock is waiting. One typed command can run a whole group of checks inside AutoCAD, in seconds each, with no mouse and no real keyboard.
      - **Free:** the sample is at `C:\Autodesk\ADN-Samples\coreconsolerunner` (NUnit, which is open source). CE 01 reports the 15 Sep ruling is to use InternalsVisibleTo rather than reflection.

   4. **Replace the robot's mouse clicks with typed coordinates for the picks. Who: CE 02, a 15-minute probe first.**
      - **Why:** six cases need the real mouse, and 54 need a real Esc. Several of the six may be plain "pick this object" steps. At a "Select objects" prompt AutoCAD accepts a typed coordinate as a pick, and a typed `(handent "2C1")` picks an object by its permanent handle [SEARCH, Autodesk forum]. The driver's COM typing already works with no keyboard.
      - **Still needs the mouse:** dragging a grip, hovering for a tooltip, and anything that looks at a picture. I did not find a proven way to send Esc or a click to AutoCAD's drawing area without the keyboard or mouse: posted window messages are known to fail on custom-drawn windows and on windows that are not active [SEARCH, AutoIt and AutoHotkey forums]. So expect a probe, not an answer from the web.

   5. **Press ribbon buttons from inside AutoCAD instead of with the mouse. Who: CE 02 or CE 01, a trial.**
      - **Why:** the ribbon is built from Autodesk's `AdWindows` library, and each button has a handler that can be run directly (`CommandHandler.Execute`; this pattern is visible in the decompiled library at `C:\Tools\AcadDecomp\2027\AdWindows`). A small test-only command could find a CE button by its id and run it, with no mouse. This would prove "the right button runs the right command".
      - **Free and already on the PC.** Whether it works for CE's buttons is untested.

3. **A correction to the earlier research (RULES 6.2).** The 9 Oct note lists the ODA File Converter (installed here, version 27.1.0) as a way to turn DWG into DXF. ODA's own FAQ says the converter is for **non-commercial use only unless you are an ODA member** [SEARCH]. Using it in CE's test pipeline would be commercial use. Do not build anything that depends on it. The free replacement is **ACadSharp (open source, already used by the test harness) to read the DWG, then ezdxf (MIT licence) to draw it as a picture**; I believe ACadSharp can also write DXF, which I have not confirmed.

4. **What I need from you:** nothing today. One free item for Monday: ask the office admin the licence question in find 1. The paid developer-membership question I sent CE 04 earlier is **withdrawn**.

### Round 1b detail (free options)

**G1. Licence facts for a second AutoCAD**
1. **What Autodesk's terms say [SEARCH, quoted on forums; Autodesk's own page returned 403 to me]:** a subscription may be installed on up to three devices and used on one at a time; the account terms add that one named user may not be logged on to more than three computers at once.
2. **Free action:** the admin checks the licence type (named user, network or standalone), number of seats, and whether one is unassigned. Not a purchase.
3. **Recommendation:** **adopt now** (a question, not a tool).

**G2. Core console on a separate PC or free virtual PC**
1. **What:** accoreconsole.exe is installed with AutoCAD and runs without a screen. CE's May 2026 investigation SAW the failure on this PC: with Tim's AutoCAD open, it stops with "Configuration file may be locked by another process"; the object it contends for is a machine-wide named lock `{52813408-3561-4705-820a-2b3b78be92ba}_0` held twice by acad.exe, outside every per-user and per-session area [READ, 22 May update in the investigation doc]. Option C in that note (a second Windows account) was never tried; my reading is that a machine-wide object would still block it.
2. **Free hosts:** the spare PC; Hyper-V (a Windows Pro feature, free; admin switches it on, restart needed); VMware Workstation Pro (free for commercial use from 17.5.2 as of Nov 2024 per Broadcom [SEARCH]; Broadcom account sign-in); VirtualBox (open source, GPL for the base program [from my knowledge, not checked this round]). A virtual PC needs its own Windows licence; Microsoft's free evaluation images expire [from my knowledge, not checked].
3. **Unknown:** whether the core console takes a seat or needs a sign-in. Two old Autodesk forum questions (a 2017 licence-error thread and an unanswered service-account thread) have no answer [SEARCH].
4. **Steps for CE 02:** (a) on the spare PC, with Tim's AutoCAD open on his PC, run one headless check (N16, R19b or R23); (b) look whether either AutoCAD asks for a sign-in; (c) run it a second time with the spare PC's AutoCAD signed in as a different account if the admin has one.
5. **Effort and risk:** 30 minutes to answer. Risk: it could sign Tim out. Run it while he is away, as the robot rules already require.
6. **Recommendation:** **trial**.

**G3. CCR-01 STEP 2: the in-process test command**
1. **What and where:** see round 1, F3. CE 01 reports (not verified by me) that the plugin repo holds the 15 Sep approval of STEP 1 only.
2. **Licence:** NUnit and NUnitLite are open source (MIT-style); the sample has a LICENSE.txt that I did not read.
3. **Recommendation:** **trial** (CE 02's call).

**G4. Typed picks instead of mouse picks**
1. **What:** AutoCAD takes a typed `x,y` at a selection prompt as a pick at that point, and a typed `(handent "<handle>")` as a pick of that object. The `handent` part is supported by an Autodesk forum thread, which also warns that `SELECT` behaves differently inside a script file than at the keyboard [SEARCH]. The typed-coordinate part I did not find a source for; it is ordinary AutoCAD behaviour as I know it, unverified here.
2. **Solves:** some of the 6 pointer cases (N05, N20, N25, R01, R08, R09) may not need the mouse at all; also removes the 4-minute pixel calibration for those sessions.
3. **Steps:** CE 02 looks at those 6 cases' STEPS and marks each as "pick" (typed) or "drag/hover" (real mouse); tries one on a test copy.
4. **Recommendation:** **trial** (15 minutes of reading plus one probe).

**G5. Ribbon button from inside AutoCAD**
1. **What:** `Autodesk.Windows` (AdWindows) ribbon items expose `CommandHandler.Execute(item)`; the decompiled 2027 library shows menu items calling it [READ, `RibbonControl.cs` line 983] and a `FindItem(id)` helper that is internal [READ, `RibbonUtil.cs`]. Public ways to find an item by id exist in the API [GUESS].
2. **Licence:** Autodesk's, already referenced by CE; no new software.
3. **Recommendation:** **trial** later, after G3 gives a place to run test commands.

**G6. Free drawing checks without AutoCAD**
1. **ACadSharp** (reads DWG in plain .NET, MIT licensed per a mirror page [SEARCH]; used by TH-01). **ezdxf** (MIT [SEARCH, PyPI]; Python; draws DXF to PNG, SVG or PDF). **LibreDWG** (GPLv3 [SEARCH, secondary source]; reads DWG; not for shipped product use, a GPL concern; test-only use is probably fine but I have not checked). **ODA File Converter: non-commercial only, do not use.**
2. **Chain:** saved test DWG, ACadSharp reads and writes DXF [GUESS], ezdxf draws a picture, picture compared with an approved one. Python and ezdxf are downloads: need Tim's yes with name, source and size (not asked yet; ask only when the trial is scheduled).
3. **Recommendation:** **trial later.**

**G7. Free things looked at and rejected**
1. **Faking the AutoCAD API for unit tests:** no open-source in-memory fake of `DatabaseServices` exists that I could find. The only route is CE's own thin wrapper over AutoCAD calls (CE already does this for pure logic: 19,000 Civil tests). A NuGet interface pack by "Tum4ik" exists; its quality and licence are not checked [SEARCH]. **Ignore.**
2. **AutoHotkey / AutoIt `ControlClick`:** free, but posted clicks fail on custom-drawn windows, and AutoCAD's canvas is custom-drawn [SEARCH, inference]. **Ignore for the canvas.**
3. **GPU sharing for a virtual PC (Hyper-V GPU-P):** unofficial; not needed if the virtual PC only runs the core console. **Ignore.**
4. **Parked (paid):** Autodesk Developer Network membership; Design Automation cloud runs; Windows 365 Cloud PC; any cloud rental. Not recommended unless Tim says otherwise.

### Hand-offs (round 1b)
1. **CE 02:** G2, G3, G4, G5 and the ODA warning (check no test depends on the ODA converter).
2. **CE 04:** record Tim's "no paid tools" word; withdraw the developer-membership item from the Monday list; add the free licence question (G1).
3. **CE 07:** the spare-PC desktop notes in round 1 F2 still stand (free). Max's AutoCAD year is still unrecorded.

---

## Round 1 first answer (partly superseded by round 1b above; paid items parked)

1. **Round 1 in one line.** Most of the "how do we test without your keyboard and mouse" ground was already covered by CE 02's 9 Oct, 22 Oct and 29 Oct notes. What I add is the missing practical pieces for the spare test PC, a cheaper way to run many logic checks in one AutoCAD start, and a price for the cloud option.

2. **Top five finds, most helpful first.**

   1. **A paid Autodesk developer membership may answer the licence question for the spare PC. Who: CE 04 asks you; CE 02 uses it.**
      - **Why:** the open question from the testing note is whether the spare PC's AutoCAD would sign you out of your own. Autodesk's developer network sells a membership that includes AutoCAD "for development, support and demonstrations" [READ, aps.autodesk.com page]. It is a separate licence for a test seat, not your drafting seat.
      - **Cost:** the page lists 1,750 for one user, 3,000 for two to five users, in AUD for Australia, per calendar year (not part-years). Companies that join between 1 October and 31 December get the following year at no extra cost [READ]. I could not tell from the page whether that means the rest of 2026 plus all of 2027. Check with Autodesk before paying.
      - **Not known:** whether the licence can be used on an unattended PC, and whether your company is eligible. Your decision, not mine.

   2. **The spare PC needs a screen that is "on", or the robot's clicks and Esc keys do nothing. Who: CE 02 and CE 07 add it to the start prompt.**
      - **Why:** a robot that presses keys needs an unlocked desktop that Windows thinks has a monitor. A PC with no monitor attached, a locked screen, or a remote-desktop window that was closed will stop mouse and key input [SEARCH, test-tool vendor notes]. This detail is not in the test-PC prompt.
      - **Fix 1 (cheapest):** a "dummy HDMI plug" in the PC's video port. Hardware, no software, sold in Australia; testers use them for exactly this [SEARCH]. Price not found.
      - **Fix 2:** switch off screen lock and sleep, and set the PC to log in by itself at start-up.
      - **Fix 3 (if you work on it by remote desktop):** before closing the remote window, run one command that hands the session back to the PC's own screen, so it stays unlocked [SEARCH].
      - **Avoid:** an open-source "virtual monitor" driver exists but it is a driver install and a security setting; needs your yes. The plug is simpler.

   3. **Run many logic checks inside ONE AutoCAD start with a test command. Who: CE 01 builds a trial; CE 02 uses it.**
      - **What:** Autodesk's own sample (already on this PC at `C:\Autodesk\ADN-Samples\coreconsolerunner`) runs a whole set of NUnit checks when you type one command, `RunCADtests`, in normal AutoCAD, on an off-screen copy of a drawing [READ]. Today's robot starts AutoCAD for every few checks (about 33 seconds each start) and types each step.
      - **Effect [GUESS]:** the checks that only need drawing results (the 9 typed-command cases and many of the 10 window-by-name cases) could all run in one start, in seconds each, with no mouse and no real keyboard.
      - **Limit:** it cannot press ribbon buttons, drag, or look at a picture, and it cannot answer a prompt left waiting [READ].
      - **Note:** the 15 Sep board note says this "CCR-01" lane was approved; I found no mention of it in `C:\CE_PLAN` and did not search the repo, so whether it was built is unknown.

   4. **A rented AutoCAD in Autodesk's cloud costs about six US dollars per hour of work. Who: CE 07 and CE 04, once Max's AutoCAD year is known.**
      - **Why:** it is the only found way to run our older-AutoCAD builds (2022 to 2026) without installing those versions. Charged at 2 Flex tokens per processing hour [READ via search summary of the Autodesk pages]; Autodesk's 2021 price list puts a token at about 3 US dollars [SEARCH]. That is roughly 6 US dollars an hour, so a 100-second run is about 17 US cents [GUESS, 2021 price, check today's].
      - **Limit:** no windows, no ribbon, no Undo as you use it; made-up drawings only.
      - **Why not now:** it only matters if Max's AutoCAD is older than 2027, which nobody has recorded.

   5. **Skip the "second virtual PC inside your own PC". Who: CE 02 can close that option.**
      - **Why:** sharing your graphics card with a virtual machine is an unofficial, community-supported trick on Windows 11 [SEARCH]. One guide says it needs a newer graphics card than the GTX 1050 Ti in your PC (NVIDIA Turing or later) [SEARCH, not confirmed by Microsoft]. Without it, AutoCAD in the virtual PC runs on software graphics: slow and possibly different looking. The spare PC does the same job without that risk.

3. **What I need from you:** nothing today. One decision is queued for Monday: whether to buy the Autodesk developer membership (or ask the office admin what licence the spare PC already has). I have sent it to CE 04.

---

## Detail

### Round 1: testing AutoCAD plugins without taking over the PC

What was already known (so not repeated): accoreconsole, Design Automation, FlaUI and pywinauto, WinAppDriver, the witness recorder, golden images, core-console blocked by an open AutoCAD, idle mode, Hyper-V and cloud desktops as concepts. Sources: `release-v3-colleagues-AUTOCAD_TEST_OPTIONS_RESEARCH_2026-10-09.md`, `TESTING_RESEARCH_CODEX_2026-10-22.md`, `TESTING_SPEED_OPTIONS_29OCT.md`. Below only what is new or settles an open item.

**F1. Autodesk Developer Network (ADN) paid membership**
1. **What:** Autodesk's programme for companies that build plug-ins. The free tier ("ADN Open") has no software; the paid tier includes AutoCAD and most Autodesk desktop products for development and testing [READ and SEARCH].
2. **Link:** https://aps.autodesk.com/developer/overview/autodesk-developer-network-membership
3. **Licence:** a commercial agreement with Autodesk, terms not read.
4. **Solves:** the "can the spare PC's AutoCAD sign in without signing Tim out?" question from `TESTING_SPEED_OPTIONS_29OCT.md` section 5. Autodesk's rule for a normal named-user subscription is use on one device at a time [SEARCH, virtualization page returned a 403 error to my fetch, so I did not read it].
5. **Steps:** (a) Tim or the office admin checks first what the spare PC's own AutoCAD licence is (Autodesk Account, Products and Services); (b) if it is Tim's own, ask Autodesk or a reseller for the ADN price and confirm the licence may run on an unattended test machine; (c) join between now and 31 December to use the free following year if that is what the offer means.
6. **Effort and risk:** an hour of admin; money (AUD 1,750 a year for one user per the page); small risk that a developer licence has terms about unattended use [GUESS].
7. **Recommendation:** **trial** (ask first, buy only after the admin check says the spare PC has no seat).

**F2. Making the spare test PC's desktop stay usable for real keys and mouse**
1. **What:** hardware and Windows settings so a PC with nobody sitting at it keeps an unlocked, monitor-attached desktop. Sources are vendor and forum notes, not Microsoft pages: a test-tool vendor's note on running tests over remote desktop and the `tscon` command that moves a remote session to the PC's own console [SEARCH]; HDMI dummy plugs sold for exactly this [SEARCH]; an open-source Windows virtual-display driver project (VirtualDrivers/Virtual-Display-Driver on GitHub) [SEARCH].
2. **Links:** https://www.testarchitect.com/OnlineHelp/TA_FAQ/Topics/faq.tshoot.running.via.rdp.keeping_computer_unlocked.html ; https://github.com/VirtualDrivers/Virtual-Display-Driver
3. **Licence:** the virtual display driver is open source (licence not read); the plug has none.
4. **Solves:** the real Esc key and the six mouse cases (the "class (c)" cases) need an unlocked session; they fail silently or hang on a locked or disconnected one. The TEST_PC_START_PROMPT does not mention it.
5. **Steps:** (a) on the spare PC, set the screen never to lock or sleep and the PC to log in automatically (the office admin may need to do this); (b) fit a dummy plug if it runs without a monitor; (c) if Tim sets it up by remote desktop, use `tscon` on disconnect so the session is not left disconnected; (d) the robot's first step on every run checks the screen is unlocked and the AutoCAD window is on top, and stops with a clear message if not.
6. **Effort and risk:** an hour. Locking and auto-login are security settings on that PC, so Tim or the admin sets them, not us.
7. **Recommendation:** **adopt now** as three lines added to the test-PC prompt.

**F3. In-process test command (CoreConsoleRunner pattern)**
1. **What:** a sample from Autodesk's developer team: a tiny add-in with a command `RunCADtests`. Typed in normal AutoCAD, it runs NUnit tests against a drawing in a side copy; run from the core console, it runs with no screen. It writes an XML result and an optional HTML report [READ].
2. **Path:** `C:\Autodesk\ADN-Samples\coreconsolerunner` (cloned 15 Sep, read-only). Original: github.com/MadhukarMoogala/coreconsolerunner.
3. **Licence:** a LICENSE.txt is in the folder; I did not read it.
4. **Solves:** the cost of starting AutoCAD (33 seconds) and typing steps for every few checks. Many of the 9 typed-command cases and of the "window by name" cases check values in the drawing or in the CE log; those can be checked in-process.
5. **Steps:** (a) CE 01 writes a small test-only add-in beside the existing headless proof (outside the shipped bundle) that exposes one command per check group; (b) the driver types that one command (COM, no keyboard) and reads back the XML result; (c) a case that passes in two separate AutoCAD starts still counts under Tim's 24 Oct rule, because the starts are still real AutoCAD [GUESS: needs CE 00's ruling, because the rule says "AutoCAD sessions" and this runs inside one].
6. **Effort and risk:** about 2 to 3 days to prove with 3 cases (N16, R19b, R23, the same three as the headless trial); risk: the test code runs in the same process as CE, so a crash voids the whole group; keep groups under 8.
7. **Recommendation:** **trial**. It reuses the idea already approved as CCR-01.

**F4. Design Automation for AutoCAD: price and one limit**
1. **What:** Autodesk's cloud core console (`Autodesk.AutoCAD+26_0` for 2027; engines for 2022 to 2026 are still live).
2. **Pricing [SEARCH]:** 2 Flex tokens per processing hour; fractions are added up and charged whole when a full hour has built up. Autodesk's rate sheet, dated September 2021, uses 3 US dollars as the standard price of a token; resellers list 2.63 to 3.00 US dollars depending on volume (2022). My arithmetic: about 5 to 6 US dollars per processing hour. Tokens expire after 365 days. I did not find the 2026 price.
3. **Links:** https://www.autodesk.com/buying/flex/flex-rate-sheet ; https://aps.autodesk.com/node/2561
4. **Licence:** Autodesk platform terms and an APS developer account; not read.
5. **Solves:** running our net48 build in real AutoCAD 2022 to 2024 when the colleague's AutoCAD is not 2027.
6. **Hard limits [from the 9 Oct note]:** no windows, no ribbon, no Undo as a drafter uses it, 100 seconds default per run, only made-up drawings.
7. **Recommendation:** **keep an eye on** until Max's AutoCAD year is recorded; then **trial** with one run of the headless proof.

**F5. Hyper-V virtual PC with the real graphics card (GPU-P)**
1. **What:** an unofficial way to share the host graphics card with a Windows 11 virtual machine, using PowerShell commands (`Add-VMGpuPartitionAdapter`) and copying the host graphics driver into the guest. Community guides only; one 2026 guide gives NVIDIA Turing or later as the supported range [SEARCH]. Microsoft documents it as a Windows Server feature [SEARCH].
2. **Solves:** the "no proper graphics card in the virtual PC" problem in section 5 of the 29 Oct note.
3. **Problem for us:** Tim's PC has a GTX 1050 Ti (Pascal, older than Turing) [from the 29 Oct note], Hyper-V is switched off, and it would still need a second AutoCAD licence.
4. **Recommendation:** **ignore**. The spare PC is simpler and carries no unofficial driver risk.

**F6. Cloud Windows desktop (Windows 365 Cloud PC with GPU)**
1. **What:** a Windows PC rented by the month, GPU tiers named "Max", "Standard" and "Super" in reseller listings [SEARCH].
2. **Not found:** an Australian price. Microsoft says Australian customers must buy through a partner [SEARCH]. Also not established: whether a robot's synthetic input works reliably on a disconnected cloud session (same issue as F2).
3. **Recommendation:** **keep an eye on**, only if the spare PC falls through.

**F7. ezdxf with the ODA converter: draw a saved DWG as a picture without AutoCAD**
1. **What:** ezdxf is a free Python library that reads DXF files and can draw them to PNG, SVG or PDF with a one-line command (`ezdxf draw -o file.png file.dxf`) [SEARCH]. Pair with the ODA File Converter already installed here (27.1.0) to turn a saved DWG into DXF. I believe ezdxf is MIT-licensed but did not confirm it this round.
2. **Link:** https://ezdxf.readthedocs.io/en/stable/tutorials/image_export.html
3. **Solves:** "did the label move" checks on the saved test drawing, with AutoCAD open or closed, and a picture a human can look at. Complements ACadSharp, which reads objects but draws nothing.
4. **Limits:** CE's custom pipe object is a proxy that other readers cannot draw faithfully (memory note c7-pipe-object-is-a-polyline says the pipe is now a polyline, which would help; untested).
5. **Steps (needs Tim's yes to install Python packages):** copy a finished test drawing; convert; draw; compare with a stored picture at a tolerance.
6. **Effort and risk:** about a day for a trial; risk: font and hatch differences between this and AutoCAD; use for "moved or missing", not for exact looks.
7. **Recommendation:** **trial later**, after F3.

**F8. Other items looked at**
1. **CADtest (community, CADbloke / AHepker-HOB on GitHub):** NUnitLite inside AutoCAD or the core console; the author calls it a how-to example, not a framework. One forum user says it works on Civil 3D 2023 [SEARCH]. **Recommendation: ignore**; the Autodesk sample in F3 is newer (AutoCAD 2026, .NET 8) and already here.
2. **JPP.AutocadNUnitTester.IntegratedRunner (NuGet):** targets .NET Framework only, no AutoCAD 2025 or later claim [SEARCH]. **Ignore.**
3. **Sending Esc without the keyboard:** forum threads say `SendStringToExecute` with an escape fails when a prompt is already waiting, and `acedPostCommand("CANCELCMD")` is not supported since AutoCAD 2015 [SEARCH]. I found no source for sending Esc to AutoCAD by window message without focus. **So the "keyboard-free Esc" in the 29 Oct plan has no ready-made answer on the web; it needs a 15-minute probe on a test machine.** That is CE 02's.
4. **FlaUI on a second Windows session:** nothing found that makes UI Automation reach into another logged-in user's session. A different user's session on the same PC keeps running when switched away but has no active input, the same limit as a locked screen [GUESS]. **Ignore.**
5. **GitHub Actions with a licensed AutoCAD:** nothing found. A self-hosted runner on the spare PC is possible but would still be the same unlocked-desktop machine as F2 [GUESS]. **Keep an eye on.**
6. **Autodesk AutoCAD in virtual machines (licensing):** Autodesk's page says it depends on the plan; a named user can sign in on several devices but only one at a time; changing the virtual network card's address can force repeated sign-ins [SEARCH]. Page itself not read (403).

### Things Tim already owns that we may not use (item e, partly done)
1. `C:\Autodesk\ADN-Samples` (30 Autodesk sample repos with a README map). Not used for testing yet: `coreconsolerunner` (F3), `FDA_PlotToPdf_v3` and `dwfout` (headless plot, listed for Structural Level 3), `acad-com-events-external-monitor` (COM events seen from outside AutoCAD; could back the witness idea), `MgdDbg` (an inspector for objects).
2. `C:\Tools\AcadProbe` (the accoreconsole probe), `C:\Tools\AcadDecomp`, `C:\Tools\ArxDocs`: already recorded in memory.
3. Skills `acad-dotnet` and `autocad-net-api`: accoreconsole flags, bundle loading with `/al`, and the rule "do not reference `AcMgd.dll` in code meant for accoreconsole or Design Automation". Round 3 (plugin practice) will read their reference folders in full.
4. Not yet looked at: the plugin store under `~/.claude\plugins`.

### What I did not verify this round
1. Everything tagged [SEARCH] is from search-result summaries, not pages I opened. Pages that refused my fetch (403): Autodesk's virtualization page and the Autodesk forum thread "How do you test commands?".
2. Whether ADN's licence can run on an unattended machine, and the current 2026 price of a Flex token.
3. Whether the spare PC has a monitor, auto-login, or its own licence.
4. Whether the CoreConsoleRunner sample builds against AutoCAD 2027 and .NET 10 (it targets 2026 and .NET 8).
5. ~~Whether CCR-01 exists anywhere in the repo.~~ **Corrected (CE 01 told me, 29 Oct, not re-checked by me):** CCR-01 is in the plugin repo on branch `claude/rel-20261026z`: `docs/workflows/CLAUDE_HANDOFF_2026-09-15_PM.md` line 30 (Tim approved STEP 1, the audit; STEP 2 belongs to another chat; ruling: InternalsVisibleTo, not reflection) and `docs/workflows/C7_STEP1_AUDIT_2026-09-15.md` section e. No record that STEP 2 was done. So F3 is the unfinished STEP 2, and it belongs to the testing lane (CE 02), not CE 01.
6. Licences of ezdxf, the virtual display driver and the CoreConsoleRunner sample.

### Hand-offs (round 1)
1. **CE 02 (`local_cd568cde-a11d-47bb-8f0b-50d431e0bd09`) and CE 07 (`local_1c1741bd-d338-4eb4-94ab-2c7351d13092`):** F2 (add to TEST_PC_START_PROMPT), F3, F1 as the licence route, F7, and the Esc probe in F8.3.
2. **CE 01 (`local_2214c743-c21c-477e-a02b-f94537c38188`):** F3 (build the in-process trial), nothing urgent.
3. **CE 04 (`local_670b1ff9-0cc3-488c-af9b-3bd7101d4daa`):** Tim's decisions: F1 (ADN membership or licence check) and Max's AutoCAD year for F4.
4. **CE 05, CE 06:** nothing this round.

### Next rounds (queue, newest need first)
1. **Round 2:** installing and updating for colleagues: bundle packaging, signed updates, rollback (what others do; matches the pilot's open items).
2. **Round 3:** plugin speed (the 30-second DP, slow PIT) and Overrule and WPF patterns, using the two installed skills and the ADN samples.
3. **Round 4:** Australian drainage design content: AS/NZS 3500.3, Melbourne Water, ARR2019 data hub, council checking tools, LandXML pipe networks.
4. **Round 5:** AI reading of council RFI letters and marked-up drawings.
