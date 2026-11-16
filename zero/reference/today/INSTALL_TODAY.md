# What is installed today, and how it reaches a PC

What is installed on the owner's PC, how an update is meant to reach a colleague, and the observed facts that make it fragile. Re-filed from the evidence on Mon 16 Nov 2026. Read from one PC, the office shared drafting folder, the office IT folder and the plug-in's source at the installed versions; nothing was run. This describes the present, not the plan: the owner wants distribution, install and structure rethought from the core (D-007), AutoCAD 2027 only (D-008), with a new version offered at start-up, installed in one click with no administrator rights, and one click to go back (D-028).

Words: "bundle" = a folder ending in `.bundle` that AutoCAD looks for in its plug-in folders. "Lane" = one of three copies of the same program built for different AutoCAD years. Folder names that contain a staff first name are written masked (`<owner>_...`); exact spellings are in the evidence file.

## How to add to this file

1. Add a new numbered item at the END of the section it belongs to (never renumber), or a new section at the end of the file.
2. Give the date the fact was read and the PC or folder it was read from. Installed things go stale fastest: mark an old item "superseded" with the date rather than deleting it.
3. Keep observed facts and unknowns apart: an unknown goes in section 7 with its Q-number if there is one.
4. End every section with an "Evidence:" line.

## 1. What is installed on the owner's PC (read 16 Nov 2026)

1. **AutoCAD:** AutoCAD 2027 only.
2. **Seven bundles** across AutoCAD's three plug-in folders; six are the office's own (one of them switched off).
3. **CE Civil (`CE_CVL_SUITE.bundle`),** per-user folder `%APPDATA%\Autodesk\ApplicationPlugins`. Version 3.0.90.13, files dated 15 Nov 2026 10:44 pm. 832 files, 162 MB. Three lanes, each a full copy: Legacy (AutoCAD 2022 to 2024), Net8 (2025 and 2026), Modern (2027). AutoCAD 2027 loads: the main civil program (10.8 MB), the shared CE library (version 1.1.0), an AI library (1.0.0), 21 third-party helper libraries, plus two C++ parts at start-up (grips on CE pipes; the "object enabler" that teaches AutoCAD the CE pipe object). A third C++ file (Copy+Rotate, Move+Rotate) is in the folder but not named in the start-up list. Adds: a ribbon tab called CE (or CE Civil), three extra tabs when a pipe, pit or source is selected, a status bar item, 145 typed commands. No ribbon file; the ribbon is made by the program at start-up.
4. **Data files shipped in the Civil bundle:** 18 block drawings (pit block, pit label, pit schedule, downpipe, overflow, inspection opening, floor waste, riser, dropper, GIO, trench grate, source, spot level, fall symbols, flow arrow, on-site detention criteria), a line type file, the help guide (web pages), and nine data files: the command list, a ribbon layout list, council profiles (184 KB), Melbourne rainfall data, network catalogue, slab types, tank library, colleague starting settings, and a "what's new" text.
5. **CE Structural (`CE_STRUC_SUITE.bundle`),** same folder. Version 1.0.126.1, dated 14 Nov 2026. 2,007 files, 72 MB, three lanes. The only bundle with a ribbon file. 376 typed commands. Carries 14 block drawings, 2 old-style dialog files, 2 LISP files, a hatch pattern, catalogues and 1,773 small button pictures. (Structural is parked: D-006.)
6. **CE Suite Manager (`CE_SUITE_MANAGER.bundle`),** same folder. Version 1.1.89, dated 2 Nov 2026. 75 files, 8.7 MB, three lanes. Loads the Manager program, its own copy of the shared CE library, and a diagnostics library. Adds the CE Tools ribbon tab and 12 typed commands; re-assembles the CE ribbon tabs after start-up.
7. **CE AutoCAD Link 2027** (test bundle, version 0.3.0, 20 Jul 2026): loads at start-up; a leftover test piece (T-053).
8. **CE Transform Trial 2027** (test bundle, version 0.1.0, 7 Sep 2026): a leftover test piece (T-054).
9. **An old Manager in the all-users folder** (`C:\ProgramData\Autodesk\ApplicationPlugins`): version 1.0.0, dated 8 Jul 2026; switched off by renaming its contents file, not removed.
10. **Autodesk's own "AutoCAD MCP Server" bundle** in Program Files: not the office's.
11. **Old copies beside the live bundles:** 119 folders that are not live: 56 dated backups of Civil, 17 of Structural, 45 of Manager, one marked "removed". Together 10.2 GB. Oldest 23 Sep 2026; most from 10 Oct to 16 Nov 2026: roughly one install every day or two for five weeks.
12. **Scheduled tasks:** none with a CE name found, although older installers were written to create a daily 6 am update task.

Evidence: STUDY_C section 1.

## 2. Where settings, logs and working files live on that PC

1. **`%APPDATA%\<owner>_CE_CADTOOLS`** (the civil program's settings folder): civil settings (`CD_Settings.json`, 15 KB), recent typed values, civil project data file, parts catalogue, label styles, theme, two dated settings backups, a 352 KB structural settings file dated March, auto-save backups (1,270 files, 1.0 GB), logs (276 files), caches, exports, Excel import sessions, markup files, an admin folder with 32,866 small files, a per-PC identity file.
2. **`%APPDATA%\CE_CVL_SUITE`:** a second, small civil settings file (`settings.json`, 672 bytes), logs (383 files, 36 MB, mostly check reports named after the drawing checked), a suggestions record (14 MB), feedback, usage counts, dated roll-back files, two small switch files for pipe grips.
3. **`%APPDATA%\CE_STRUC_SUITE`:** structural settings (`CS_Settings.json`, 36 KB, about 800 entries) plus a dated backup; auto-save backups 2,176 files, 2.0 GB; caches; logs (342 files, 45 MB); Excel sessions; project files.
4. **`%APPDATA%\CE_SUITE_MANAGER`:** Manager logs (14 files) and usage counts.
5. **`%APPDATA%\CE_CADTOOLS`:** an install identity file, a Manager menu file, another admin folder (1,019 files, 105 MB).
6. **`%APPDATA%\<owner>_CETOOLS`:** 23 checklist templates (the same 23 as in the shared folder).
7. **`%APPDATA%\CE_ACAD_PLUGIN`, `CE_BEAM_DESIGNER`, `Creative Engineering\CE Suite Manager`:** one small file or empty.
8. **`%LOCALAPPDATA%`:** further install and release working folders: `CE Suite` (36,441 files, 1.3 GB, July), `CE_CADTOOLS` (717 MB, July to August), `CE_ACAD_PLUGIN` (234 MB, August), `CE_SUITE` (300 MB), `CE_CVL_SUITE` (152 MB), `CE_SUITE_MANAGER` (a crash trace written 16 Nov and an older start-up failure log), nine folders from a July experiment (two of them 421 MB each), and a 19 GB e-mail archive audit that is not plug-in related.
9. **`%APPDATA%\CE_SUITE`:** does not exist on this PC.
10. **Civil settings:** 577 separate settings in 49 groups, 250 of them on/off switches; the saved file has about 400 entries. A small "colleague starting settings" file in the bundle sets 9 values on a PC that has no settings file yet; its own note says it is a draft waiting for the owner's answer.

Evidence: STUDY_C section 1 "Where settings, logs and working files live", section 3 "Civil settings".

## 3. How it is put together today

1. **Program files:** Civil: 3 office-written .NET program files + 21 third-party + 3 C++ parts. Structural: 2 office-written + 19 third-party + 1 C++ part. Manager: 3 office-written. That is 8 office-written .NET program files (two of them the same shared library shipped twice), 4 C++ parts, about 40 third-party libraries, per lane. Across all three lanes the three bundles hold 169 program files.
2. **Languages:** C# for almost everything (Civil about 1,570 source files and 68 window layouts; Structural about 680; Manager about 100). C++ for five parts. LISP: two small files shipped in bundles; 181 loose files in the shared folder.
3. **AutoCAD years built for:** three lanes (2022 to 2024, 2025 to 2026, 2027). All C++ parts are 2027 only. Several civil commands say "AutoCAD 2027 only". Settled going forward by D-008: AutoCAD 2027 only.
4. **The repository:** one repository holding all modules, 27 projects in the solution, 11 of them not tests. Its checked-out main line is from 28 Sep 2026 and is far behind what is installed; the installed versions come from other branches.
5. **What is stored inside the drawing (Civil):** named record stores in the drawing's own dictionary: project data, pipe-to-pit links, permanent identities for pits and pipes, slabs, survey levels, legal point of discharge, discipline, multi-plan, repair quarantine, the next source-tag number. Extra data is also attached to individual objects. Pits, labels and sources are ordinary blocks and text. Pipes are ordinary polylines and multilines, or, when the one-object switch is used on 2027, a CE pipe object.
6. **What is stored outside the drawing:** settings, recent values, parts catalogue, label styles and theme per user; auto-save backups; logs and check reports named after the drawing; suggestion and usage records; office-wide usage, machine and failure records in the IT folder; time logs and weekly reports in the shared drafting folder.
7. **A drawing opened on a PC without the plug-in (as documented):** ordinary CE drawings (pipes as polylines, pits as blocks): everything shows and plots as normal AutoCAD objects. Drawings with one-object pipes: a PC with the enabler part but no ribbon "sees and can move the pipe"; a PC with nothing installed "sees the saved proxy graphics only (walls and band) and cannot edit the pipe"; "there is no enabler for AutoCAD 2022 to 2024 today".
8. **Conflict:** the documented behaviour in item 7 ("sees the saved proxy graphics") against the owner's report that on a live drawing made with the plug-in "the people with no plugin cant see anything at all". Not explained; nothing has been looked at (parked as P-04; Q-017, Q-202). Settled as a requirement by D-015: a drawing must look and plot identical without the plugin, and this must be proven.

Evidence: STUDY_C section 6; INTERVIEW item 8x; DECISIONS D-008, D-015.

## 4. The install / update path as designed today, as steps

There is not one route. Four were found: three older ones still sitting in the office folders, and one current design. Evidence that the current design has completed end to end on a colleague's PC was not found.

1. **A version is made.** On the owner's PC the three programs are built, each in three lanes. Every build must carry a "do not touch the live bundle" switch, because building one lane without it overwrites the live Civil bundle on that PC (this happened on 3 Jul 2026 one minute before a field test).
2. **A prepared bundle is assembled** for each module in a folder outside AutoCAD's plug-in folders. Civil's and Manager's copies of the shared library must be identical byte for byte in every lane; checked by hand-run steps.
3. **Four evidence files are required:** Build, Automated Tests, Command Truth, Release Safety.
4. **Pre-flight.** A "release authority" program checks the prepared bundle, the clean source and an approval file, and answers READY or NOT READY.
5. **Signing.** The same program makes a new package folder holding the bundle, a release record, a signature file and a summary. The signing key is held in the owner's Windows login and cannot be exported. Only that login can sign.
6. **Publishing.** The package is placed in the office IT folder, a SharePoint library synced by OneDrive. The Manager searches that folder, four folders deep, for any bundle and treats the highest version number of each module as "available".
7. **Approval.** In the Admin Dashboard an administrator presses Approve Available Build. Options: Canary Rollout (named pilot PCs first), Promote to All, Roll Back.
8. **On the colleague's PC, OneDrive must have synced the IT folder.** If not, the Manager says so and asks them to sync it and press Refresh.
9. **The colleague opens the Manager, Updates page, and presses "Get update ready".** The Manager re-checks the signature and every file, then copies the build to a waiting area on the PC. Status becomes "Copied, waiting".
10. **The colleague closes every AutoCAD window.**
11. **The CE installer program is run.** It asks Windows for administrator rights. The Manager's own wording for a colleague is "ask your CE administrator to finish the install". The installer re-checks that AutoCAD is closed, re-checks the signature and file hashes, keeps the whole old bundle for roll-back, swaps the whole folder, and puts the old one back if the swap cannot finish.
12. **The colleague reopens AutoCAD.** AutoCAD's own plug-in loader reads each bundle's contents file, picks the lane that matches the AutoCAD year, and loads what that lane lists for start-up. The programs then build the ribbon.
13. **Version checks after start.** The Manager shows installed, available and waiting versions; `CEHEALTH` checks the shared library copies match.

**What needs AutoCAD closed:** step 11. **What needs administrator rights:** the installer in step 11; being a "CE administrator" for approval in step 7 is a separate list kept in the IT folder. **What does not:** steps 8 to 10.

**How many separate things must agree for a colleague to end up working:** at least 12: (1) three lanes built from one source point, (2) the shared library identical in Civil and Manager, (3) four evidence files, (4) the approval file, (5) the signing key in the owner's login, (6) the signature and record, (7) OneDrive sync on the owner's PC, (8) OneDrive sync on the colleague's PC, (9) the administrator's approval and pilot list, (10) the waiting copy matching the approval, (11) AutoCAD closed plus administrator rights for the installer, (12) the bundle contents file choosing the right lane. For AutoCAD 2027 add the three C++ parts, which are tied to that one AutoCAD year.

**When it fails (the program's own messages):** OneDrive not synced ("CE cannot find the update files in the office IT folder"); signature, hash, file count or version does not match (refused, nothing changed); AutoCAD still open (the installer refuses); installer not on the PC ("Ask your CE administrator"); swap cannot finish (the old bundle is restored); a module loads but its commands are missing (`CEHEALTH` says restart AutoCAD or run the installer again).

Evidence: STUDY_C section 5A.

## 5. What is actually in the office IT folder, the older routes, and how the owner's PC is really updated

1. **`CE V3 PILOT`** (4 Nov 2026): three plain bundles (Civil 3.0.89, Structural 1.0.125, Manager 1.1.89) and one file listing a checksum for every file. No signature file or release record, so it is not in the signed-package shape. How a colleague is meant to use it: Unknown.
2. **A Manager test folder** (25 Aug 2026): the only folder found in the signed shape (bundle, release record, signature, summary). Beside it a half-made folder starting `.preparing-`.
3. **`CE CVL SUITE`:** a Civil bundle at 2.1.14 (July), an installer program dated May, a version 2.0.0 package with a readme, an install script.
4. **`CE STR SUITE`:** a Structural bundle at 1.0.41 (August), an installer dated June, an install script, a release-history folder.
5. **`CE SUITE MANAGER`:** a Manager bundle at 1.0.0 (July), an installer dated May, an install script and an "apply update" script.
6. **Top level:** a Civil installer named for version 2.1.11 (June) and a script "Install-All-CE-Plugins".
7. **`Software\CE CVL SUITE`:** a Civil bundle at 2.0.0 with a payload zip, an installer, a readme and several "update available" notes from March and April.
8. **`CE Plugin Admin\releases`:** folders for Civil and Structural dated April. The same admin folder holds usage, machines (9 entries), failures, policies and support bundles.
9. **Newest against installed:** newest Civil in the IT folder 3.0.89, the owner's PC runs 3.0.90.13; newest Structural 1.0.125 against 1.0.126.1; Manager matches at 1.1.89.
10. **Older route 1, single installer program (version 2.0, May 2026):** close AutoCAD, double-click the installer, click Yes on the administrator prompt, wait 30 seconds, reopen AutoCAD. It copied the bundle to the per-user plug-in folder, set an AutoCAD security setting in the Windows registry for every AutoCAD year, created a daily 6 am update task and a log-on task, and installed Microsoft's web-view component. Sent by e-mail or link. Switched off in today's source.
11. **Older route 2, payload zip beside the installer (early 2026):** "On AutoCAD start, the plugin checks this folder for a newer payload.zip. If a newer version exists, it updates automatically."
12. **Older route 3, "Install-All-CE-Plugins" script (April 2026):** right-click, run, accept the administrator prompt; copies all three bundles to the all-users folder. A later note says colleagues' PCs with AutoCAD 2027 were not picking the plug-in up from that folder, which is why the per-user folder is used now.
13. **Older route 4, the first Structural installer (March 2026):** installs to the all-users folder and creates the daily and log-on update tasks.
14. **How the owner's PC is actually updated:** not by the designed route. The 119 dated backup folders show the live bundles being replaced directly and often, with the old one renamed beside it. The tool that does this: Unknown.

Evidence: STUDY_C sections 5B, 5C, 5D, section 4 "What it does behind the scenes".

## 6. The fragility facts (observed facts only)

1. Three generations of the same helpers are live at once: loose LISP, tool palettes and plug-in commands, with many identical typed names.
2. 486 LISP typed names, 330 of them only in superseded copies; the same LISP file exists up to six times.
3. Very large command counts: 145 Civil + 376 Structural + 12 Manager = 533 typed names. 78 of Civil's 143 listed commands are hidden; 20 are repair or audit commands.
4. Very large setting counts: 577 civil settings (250 on/off), about 800 structural entries.
5. General drafting helpers live inside the Structural program; a civil-only PC does not get them from the plug-ins.
6. Move+Rotate / Copy+Rotate exists in five places, including a trial bundle still installed.
7. At least four install routes have been used in eight months; files for all four are still in the office IT folder.
8. Two plug-in folders have been used (all-users and per-user); an old Manager still sits in the all-users folder, switched off by renaming one file.
9. The office IT folder holds seven different Civil builds or installers, and the Manager picks "newest version number found anywhere four folders deep".
10. The one folder named for the pilot has no signature, while the design says only signed packages may be installed.
11. Version mismatches on the owner's PC: the Civil bundle's main program and its two companion libraries come from different source dates; "what's new" says 3.0.1 against 3.0.90.13; the IT folder is one step behind for Civil and Structural; the installed Civil is marked in its own source note as not for colleagues.
12. The bundle contents files under-report commands: 51 of 145 (Civil), 36 of 376 (Structural). The Manager's own notes say "8 commands"; it has 12.
13. Two different ribbon layouts for Civil ship in one bundle.
14. The same shared library is shipped twice (in Civil and in Manager) and must be identical; the first one AutoCAD loads wins.
15. Finishing an update needs administrator rights and AutoCAD closed.
16. Only one Windows login can sign a release.
17. Everything depends on OneDrive having synced a SharePoint library on both PCs.
18. Settings and logs are spread over at least seven folders under two different roots, with two civil settings files, two structural settings files and two admin folders.
19. Working files are large: 10.2 GB of old bundle backups inside AutoCAD's plug-in folder, 2.0 GB + 1.0 GB of auto-save backups, about 3 GB of old release and staging folders.
20. All C++ parts are for AutoCAD 2027 only, while the bundles still carry full copies for 2022 to 2026 (two thirds of each bundle's size).
21. A drawing with one-object pipes cannot be edited on a PC with nothing installed, and there is no enabler for 2022 to 2024.
22. Two leftover test bundles load on the owner's PC (one at every start-up).
23. Staff names appear in a comment at the top of two bundle contents files and in several file and folder names; client and job names appear as hundreds of log file names.
24. No civil "issue" command exists; the long list is weighted to drawing, checking and repair.
25. Tool palettes exist in three sets (17 current, 12 "NEW", 43 old), and two of the "NEW" civil palettes are identical.

What the August notes add about the old plug-in: too many pieces (99 commands, 18 buttons on one panel, about 133 settings in one place, background behaviour hard to predict); parked template blanks read as live design; tanks and agricultural drains stored as pits.
26. **Loose LISP is loaded from private copies:** Each PC's start-up suite lists LISP files one by one pointing at a personal folder, an old lettered network drive and `C:\Lisp Files`: a fix to a shared LISP file does not reach a PC that loads a private copy. Nothing auto-loads the shared folder (no acaddoc.lsp or acad.lsp) (STUDY_D section 6.5 items 4 and 5)
27. **Palettes and plot style table are local copies:** The palette path is the PC's own local folder; the plot style table is a local copy in the PC's plot styles folder, not read from the shared folder, so PCs can plot with different versions. Templates: no office template is set for "new drawing"; jobs are started by copying the template drawing. Menus: the stock menu plus the bought-in structural toolkit's menu; no office menu on the colleague's PC (STUDY_D section 6.5 items 7 to 10)
28. **Trusted locations grow at each install:** On this PC the trusted-locations setting lists the same Civil plug-in folder at least 15 times over (it is appended at each install) (STUDY_D section 6.5 item 11)
29. **Reporting gaps:** Usage records exist for April (1,442), then almost nothing May to September (66), then October (624) and November (505). No record shows any PC other than this one running a Civil newer than April's (STUDY_D section 6.1 item 2, section 6.2 item 8)

Evidence: STUDY_C section 7; DIGEST section 7; STUDY_D section 6.1, 6.2, 6.5.

## 7. Unknowns

1. What a colleague's PC has today (only the owner's PC was read; 9 machine records exist but were not opened): Q-105. Superseded by STUDY_D section 6.2 (seven PCs identified from the machine, usage and failure records), 16 Nov 2026.
2. Whether any colleague has been updated by the signed route from start to finish.
3. How `CE V3 PILOT` is meant to be used, and by whom.
4. How the owner's PC's bundles are replaced day to day.
5. How the loose LISP files and tool palettes are loaded on each colleague's PC, and which colleagues still use them: Q-105. Superseded by STUDY_D section 6.5 (mechanism read; which colleagues use them: still Unknown), 16 Nov 2026.
6. Which tool answers when a typed name exists in both a loaded LISP file and a plug-in.
7. How the Copy/Move+Rotate C++ part is loaded, since the bundle's start-up list does not name it.
8. What the ribbon and windows really look like on screen today.
9. Whether the old menu file and the bought-in structural toolkit are still in use.
10. Whether CE data inside a drawing survives editing and saving on a PC without the plug-in: Q-201.
11. Exact count of structural settings a user can change.
12. Cloud-only files were not opened.
13. The Windows registry was not read, so trusted-folder and security settings for plug-in loading are unknown.
14. The old plan repository was not read, so plan-level decisions about install routes are not reflected.
15. Which everyday helpers are really used: Q-015. How to install and update with no administrator rights and no manual OneDrive step: Q-203.

Evidence: STUDY_C section 8; OPEN_QUESTIONS Q-015, Q-105, Q-201, Q-203.


## 8. What colleagues' PCs report (read 16 Nov 2026 from the IT folder records)

Seven distinct PC names appear. PC-2 is the PC the study ran on. Names were deliberately not interpreted.

1. **PC-1:** AutoCAD 2022 in April (one record from AutoCAD 2027 in October). Last reported Civil 1.1.0.0 and Structural 1.0.91 (machine record) on 30 Apr 2026; Manager 1.0.0 on 5 Oct 2026. 746 usage records, 745 of them in April. A real drafting PC in April. (STUDY_D section 6.2 item 1)
2. **PC-2 (the owner's PC):** AutoCAD 2022 in April, AutoCAD 2027 later. Civil 1.1.0.0 and Structural 1.0.79 on 28 Apr 2026; Manager 1.1.34 on 7 Oct 2026. 786 usage records; 941 of the 1,029 failure records. (STUDY_D section 6.2 item 2)
3. **PC-3:** AutoCAD 2026. Manager 1.0.0, last seen 26 Aug 2026. 11 failure records, no usage records. (STUDY_D section 6.2 item 3)
4. **PC-4:** AutoCAD 2027. Manager 1.1.1, last seen 24 Sep 2026. No usage or failure records. (STUDY_D section 6.2 item 4)
5. **PC-5:** AutoCAD 2026. Manager 1.0.0, last seen 21 Apr 2026. Nothing else. (STUDY_D section 6.2 item 5)
6. **PC-6:** AutoCAD 2027. Manager 1.1.89, last seen 16 Nov 2026. 1,103 usage records in October and November, 985 of them one command (the block library window), plus version and health checks. Looks like an automated test PC or account, not a drafter: Unknown which. (STUDY_D section 6.2 item 6)
7. **PC-7:** AutoCAD 2027. Manager 1.1.89, last seen 15 Nov 2026. Two usage records (a health check and a version check). (STUDY_D section 6.2 item 7)
8. **Reading:** AutoCAD 2022, 2026 and 2027 are all in the records. Only two PCs ever reported Civil or Structural through this channel, both at the April versions (Civil 1.1.0.0). No record shows any PC other than this one running a Civil newer than April's. What Civil and Structural versions the colleagues run today cannot be told from these records. Civil was loaded from the per-user plug-in folder on both April PCs. (STUDY_D section 6.2 items 8 and 9)
9. **Conflict (versions):** Section 1 gives this PC's installed versions (Civil 3.0.90.13, Manager 1.1.89) and section 5 item 9 gives the newest in the IT folder; the records give older versions for the same PC (Civil 1.1.0.0, Structural 1.0.79, Manager 1.1.34). Not reconciled. (STUDY_D section 6.2 items 2 and 8)
10. **Unknown:** What Civil and Structural versions colleagues run today; whether PC-6 is a person or a test robot and which PCs belong to which colleague; whether "did not close cleanly" records are crashes or ordinary shut-downs; how often colleagues use plain AutoCAD commands, loose LISP tools and palettes (not recorded); the start-up suite's full 17 entries (only those visible in the package text were read); the 2015 instruction documents and the other four settings packages (not opened). (STUDY_D Still unknown items 6 to 11)

Evidence: STUDY_D section 6.1 to 6.5, Still unknown items 6 to 11.
