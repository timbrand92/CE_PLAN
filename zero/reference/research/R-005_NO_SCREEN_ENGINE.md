# R-005. The no-screen engine (accoreconsole), what it would touch (research, read-only)

**Asked by Tim, 18 Nov 2026:** "look into the no-screen engine". **Promise made:** this is written for Tim to approve first. **Nothing was run.** AutoCAD and the no-screen engine were not started, not even for a version check. The registry, every AutoCAD profile, settings file, licence file and sign-in file were not read or changed. Nothing was installed. The only files looked at were our own plan files, our own notes and the trial folder listing under C:\CE_WORK. Autodesk pages were read on the web.

Plain words: the **no-screen engine** is accoreconsole.exe, AutoCAD's core without its window. **CETEST** is our one-command check that runs inside full AutoCAD at night.

---

## The short answer for Tim

1. **Gain:** small for what we have. CETEST already takes about 2 min 20 s a pass. The engine might shave part of that, only for checks that need no screen, and I cannot give a real figure without a trial.
2. **What it would touch:** Tim's own current profile (it uses the most recently used one), possibly his saved settings at exit (not documented), and the live CE log and settings files unless "isolate" is used.
3. **Risk:** the licence. We do not know whether it shares the desktop licence, and a licence error followed the 16 Nov runs. The cause was never proven.
4. **It cannot run while his AutoCAD is open** (our own September note), so never in the day.
5. **Recommendation:** do not use it yet. Finish the no-AutoCAD options in R-004 (D and E) first. If a gap remains, approve only the yes-list below, one trial, at night.
6. **Nothing is needed from Tim today.**

## What Tim would be saying yes to

Each line is separate. He can accept or refuse each one.

1. **One start, no profile switch:** I may start the engine once, after 5:30 pm with his AutoCAD closed, with no /p, so it uses his current profile as it already is.
2. **Isolate switch:** I may use the isolate switch, which sends the engine's temporary files to a folder under C:\CE_WORK, so it does not write to his live CE files.
3. **Read-only look before and after:** I may read his profile list and the SECURELOAD value (not change them) before and after, to prove nothing moved.
4. **No saved-setting change:** nothing is set, added or removed. SECURELOAD stays as he leaves it, no trusted folder is added.
5. **Stop rule:** if a licence or sign-in window appears, or the process jams, I stop, touch nothing and tell him. I never force-close it (the 18 Nov exception covers only a test AutoCAD the robot started itself; it is Tim's call whether it covers the engine).
6. **Later, only if asked:** a trusted folder, a signed test DLL, or the Program Files plug-in folder each need their own separate yes (section D).

---

## A. What it is

1. **Plain description:** accoreconsole is AutoCAD with the screen removed. It opens a drawing, runs a list of typed commands from a script file, and prints text, so it can run our checks without a window.
2. **What Autodesk says it cannot do:** anything that opens a dialog or palette, and managed code must not reference the main AutoCAD window library (AcMgd.dll) or it can crash the console (Autodesk's AutoCAD Core Console help page).

## B. Licence

1. **Does it check out or need a licence, does it share the desktop licence?** Autodesk's Core Console page says nothing about licensing. Forum posts are conflicting and none is an Autodesk statement. My search for a named-user sign-in rule for the console found nothing. **Not documented; unknown.**
2. **Can it trigger a sign-in or licence window?** Not documented. A licence window very likely appeared on 16 Nov (see item 5), but that was the full AutoCAD, so it tells us nothing certain about the engine.
3. **Can it run while full AutoCAD is open?** Autodesk's page says nothing. Our own note from 23 Sep 2026 says on this PC it cannot start while the full AutoCAD is open (a machine-wide lock). The local fact wins.
4. **Known about it and licence errors:** only forum reports (a licence error from a program that launched it; mixed reports on running several at once). Not verified by Autodesk.
5. **What most likely caused the 16 Nov error, from our own files:**
   1. P-08 records a licence error at 21:05:08 for the trial's **full AutoCAD** (network licence path, vendor error -95), and licensing-agent window files at 21:05 to 21:06. That is the one hard fact.
   2. The same evening the trial chat also made the ZeroTrial profile, started AutoCAD under two other profiles, switched SECURELOAD, force-closed one AutoCAD and one engine run, and ran the engine four times (trial 10 and P-08).
   3. **The profile, the isolate switch, the force-kill, the overlap of runs, or something else: all unproven. Cause is unknown.** The only thing the evidence leans toward is that it was around a full-AutoCAD start made soon after a forced close, but that is a timing link, not a cause.
   4. For balance: our notes show the engine run many times in September and October (about 10 seconds a run, with isolate) and I found no licence error recorded then. That is a lack of a record, not proof.

## C. Profile and settings

1. **Which profile with no /p?** Autodesk's page implies the one most recently used in AutoCAD but does not state it outright. Here that is Tim's profile.
2. **Can a run write to the profile, registry or saved settings?** Autodesk's page does not say. Ways it could, none verified: a script that sets a system variable (SECURELOAD is saved in the registry per Autodesk's SECURELOAD page), AutoCAD's normal exit housekeeping, a crash, and loading our plug-in (the office's 23 Sep note: our Civil plug-in's start-up wrote to the live log and rewrote the live telemetry file when loaded without isolate).
3. **How to run it so it only reads:** the best available is no /p, /readonly on the drawing (Autodesk page: opens the drawing read-only), a script that sets no system variable, and a before-and-after check. **I cannot promise it writes nothing**, because exit behaviour is not documented.
4. **What /isolate does and why it was used:** Autodesk's page lists it in the usage line only and does not describe it (UNVERIFIED). Our own use, from the 10 Oct note: it sends the engine's temporary and settings work to a folder we name, so the engine does not load and write to the live CE bundle's files. On 10 Oct it first failed for want of a TempDirectory value in the "Tim" profile, which was added with Tim's word. What isolate writes into the registry, if anything, is not known.

## D. Loading our test code

1. **How an unsigned .NET 10 DLL gets in:**
   1. **NETLOAD in the script.** Autodesk's page says the console supports .NET assemblies, but "custom programs ... must be located in a trusted location".
   2. **/ld:** not on the Core Console page at all. For full AutoCAD it is documented for ARX and DBX files, not .NET (R-004 section 4; search summary).
   3. **Bundle folder (ApplicationPlugins):** the autoloader checks those folders at start. Our September note says the console does load the live bundle this way.
2. **What SECURELOAD does** (Autodesk's SECURELOAD page, a 2024 LT version): saved in the registry, default 1. **0** loads from anywhere with no warning (not recommended). **1** loads only from trusted folders and warns otherwise. **2** loads only from trusted folders. **What the console does at the warning** (a prompt nobody can answer, a silent refusal) is **not documented**.
3. **Every way to make our DLL trusted:**
   1. **Leave SECURELOAD at 0.** It is 0 in Tim's profile today (per trial results, not re-read by me). Needs nothing new, but it is the leftover of the first trial and weakens his normal AutoCAD. Tim may set it back (section G); doing so breaks CETEST's silent load unless one of the routes below is used.
   2. **A trusted folder (TRUSTEDPATHS).** Saved in the registry (TRUSTEDPATHS page, LT 2027). **Saved-setting change: needs Tim's yes under rule 1.9.** Reversible by removing the folder in Options, Files, Trusted Locations. Autodesk's console page says it is added through the Options dialog and the console restarted. From 2026, when PROJECTAWARE is 1 the variable is read-only (same page).
   3. **Sign the DLL.** The plug-in folder page says each loaded program is checked for a digital signature and the user is warned if missing or invalid. It does not say a signature satisfies SECURELOAD for NETLOAD. A self-made certificate would also need trusting in Windows. **Not verified that this works; skip.** Using the release signing key for test builds is Tim's decision.
   4. **The Program Files ApplicationPlugins folder.** Autodesk's page: plug-ins there are trusted and not checked for a signature. Needs administrator rights and puts our test files inside the AutoCAD install area. Reversible by deleting the folder. It changes the PC, so it needs Tim's yes. Our own normal bundle folders (per-user and all-users) are not trusted by default: "must be trusted as part of the application's preferences".
   5. **Per-process switch or variable for these two:** none found.

## E. What it can and cannot test of our plug-in

1. **Can:** the hands logic that needs no screen: move, copy, mirror, rotate, erase, scale, undo, redo gave the same events and drawing as full AutoCAD in trial 10 (R-004 option A), and notes, records, saves and reopens.
2. **Cannot:** selection by window, grips, palettes, ribbon, windows, the idle event (0 firings in trial 10), live preview, and the overrule "close" count (65 against 83).
3. **Which night checks could move:** only the database-level ones inside CETEST. I have not opened CETEST's list in this write-up, so I cannot say how many. Anything touching the face stays in full AutoCAD.
4. **Gain over 2 min 20 s:** most of that time is probably AutoCAD starting, then our checks (the trials measured plug-in work in milliseconds). The engine start is about 10 seconds per our probe notes, so the most it could save is roughly two minutes a pass, and only if every check can go headless. Against that: the extra licence, profile, isolate and trust questions above, and that it is a second route to keep true. **The gain is small, and nights are free anyway.** It matters only if the queue, not the clock, is the limit.
5. **In the daytime while Tim drafts:** no. It cannot start beside his AutoCAD (our note). If it could, the risks would be a shared profile, a shared licence, CPU and disk contention (his PC is already starved by builds), and a crash or lock taking his session with it.

## F. The safest first trial

**No trial can promise "nothing saved" because exit behaviour is undocumented. The smallest needed change is Tim's yes to the isolate switch (yes-list item 2); with it, the run touches no saved AutoCAD setting that we know of.**

1. **When:** after 5:30 pm, Tim's AutoCAD closed (Tim says so, and I check no acad.exe or accoreconsole.exe is running, twice). No other test running.
2. **Before:** with Tim's yes, record read-only: his profile list, the current profile name, SECURELOAD, and a hash of the live CE log, settings and telemetry files (so we can show they did not change). Note the licensing log's latest line.
3. **Command line (one run, one made-up drawing copy under C:\CE_WORK\scratch):** the engine with /i the copy, /s a script, /isolate with a new folder name under C:\CE_WORK, /readonly, and **no /p**. In Git Bash set MSYS_NO_PATHCONV so the switches are not rewritten.
4. **The script (first run):** print one line, then QUIT. **No NETLOAD and no SECURELOAD line.** This tests only whether it starts, shows no licence window and exits. A second run, only after a clean first, would NETLOAD a harmless test DLL.
5. **After:** profile list and current profile unchanged; SECURELOAD unchanged; live CE file hashes unchanged; no licence or sign-in window; no leftover process; the licensing log has no new error line.
6. **Stop at once if:** any window appears (licence, sign-in, error report), the engine has not exited in 5 minutes (leave it, do not kill it, tell Tim), or any "after" check differs.
7. **Undo:** delete the isolate folder and the scratch copy. If a setting moved, I do not put it back myself; I tell Tim what moved and he decides.

## G. The 16 Nov leftovers

1. **The ZeroTrial profile.** A copy of his "Tim" profile made in the registry by the trial chat. It does nothing unless chosen; the current profile was written back to "Tim". It is clutter, and a risk only if someone starts AutoCAD under it. **Tim would:** open AutoCAD, type OPTIONS, go to the Profiles tab, make sure "Tim" is current, select ZeroTrial and click Delete.
2. **SECURELOAD 0.** (a) In Tim's own profile, per trial results. It lets any DLL load without a warning in his everyday AutoCAD, which is the setting CETEST relies on. (b) In the built-in "Unnamed Profile", which he does not use. **Tim would:** in his normal AutoCAD type SECURELOAD, press Enter, type 1, Enter. Warning: after that, NETLOAD of CETEST will ask a question each night until a trusted folder is agreed (D.3.b). The "Unnamed Profile" one does not matter unless he uses that profile.
3. **The isolate folder.** C:\CE_WORK\trials\zero\isolate is an ordinary folder of temporary files, including a log that names AutoCAD's device id (also in copies under the trial evidence and scripts folders). It affects nothing. **Tim would:** delete the folder in Windows Explorer when he is ready; the evidence copies are ours to tidy with his yes.
4. **Older, already agreed:** a TempDirectory value was added to his "Tim" profile on 10 Oct so isolate would work (from our memory note; not re-read).

---

## Not verified

1. **Licence behaviour of the engine:** whether it takes a licence, shares his, or can show a licence or sign-in window. Not stated on any Autodesk page I read.
2. **Whether it runs beside an open AutoCAD:** only our own September note says no. Not an Autodesk fact.
3. **What /isolate and /loadmodule do:** the Core Console page gives the usage line only.
4. **What the engine writes to the profile or registry at exit or on a crash:** not documented.
5. **What the console does at a SECURELOAD 1 warning with no one to answer,** and whether SECURELOAD is per profile: the SECURELOAD and TRUSTEDPATHS pages I read are the AutoCAD LT help; the full AutoCAD pages were not read. A search summary of an Autodesk security page says TRUSTEDPATHS sits under the profile in the registry; I did not open it.
6. **Whether a signed DLL satisfies the NETLOAD check:** the plug-in folder page speaks of signatures only for loaded program files and bundles.
7. **The current state of SECURELOAD, the profile list and ZeroTrial:** taken from our trial files, not re-read (rule 1.9 and this brief forbid it).
8. **The real time saved:** not measured; "about 10 seconds a run" is from our September notes. CETEST's own check list was not opened.
9. **The 2027 help pages:** the command-line switches page for 2027 was read; it says switches and environment variables do not alter the registry, and does not mention /p or /nologo. The Core Console page read was the 2026 one.
10. **What caused the 16 Nov licence error:** unknown.

**Sources, by title and site (all Autodesk help, read this session):** "AutoCAD Core Console" (2026 help); the command-line switches page (2027 help, title not shown to me); "SECURELOAD" (AutoCAD LT 2024 help); "TRUSTEDPATHS" (AutoCAD LT 2027 help); "About Installing and Uninstalling Plug-In Applications" (AutoCAD 2025 Customization help). Search summaries only, not opened: an Autodesk security page for the registry location and /safemode, and the Autodesk forum posts on licensing.

**Local files read:** C:\TimOS\RULES.md; R-004_TESTING_FASTER.md; stage4\TRIAL_RESULTS.md (trial 10 and the header); PARKING_LOT.md P-08; stage6\THE_PLAN.md (first 80 lines); memory notes accoreconsole-plugin-probe and autocad-decompiled-source; a folder listing and one script line from C:\CE_WORK\trials\zero.
