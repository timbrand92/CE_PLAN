# What AutoCAD 2027 itself writes when it is started and quit (and what Tim would notice)

**Kept by:** the AutoCAD test room. **Written:** Fri 20 Nov 2026, evening, on the control room's 6:27 pm request (D-420). **Part of the gate; to be told to Tim before any first night.**
**How it was made:** by reading only. No AutoCAD was started. Nothing was changed. Two sources:
1. **SEEN** = looked at on this PC tonight: file names and dates in Tim's AutoCAD folders, and the NAMES of registry keys (no values that could hold a job name were printed). AutoCAD last ran today from about 3:37 pm to 3:52 pm, so the file dates show what a start and a quit touch.
2. **AUTODESK** = read tonight in Autodesk's own help pages (listed in section 7).
3. Everything else is marked **GUESS**. A guess stays a guess until section 6 is done.

## 1. The answer in short

1. **A test AutoCAD started the way the night launcher starts it (by opening `open_me.dwg`) runs as Tim, under Tim's own profile "Tim".** Everything AutoCAD saves on quit goes into Tim's own settings. There is no separate place for a test run today.
2. **Autodesk documents no switch that names a different recent-files place or a different settings place for full AutoCAD.** None was found. The only documented way to keep settings apart is a different profile (the `/p` switch), and rule 1.9 forbids that without Tim's yes in words.
3. **If the scripts change no setting, use no file box, move no window and quit normally, the things Tim would notice are few:** the test drawing in his recent lists, and possibly the order of command suggestions. That is a GUESS until measured.
4. **The one thing Tim would certainly notice is after a forced close:** his next AutoCAD start shows the Drawing Recovery panel naming the test drawing.
5. **Recommended gate step:** the first night takes a read-only "before" and "after" list of these places and this room reports every difference to Tim. That turns the guesses on this page into facts.

## 2. Where AutoCAD 2027 keeps Tim's settings (SEEN)

| Place | What is in it | Shared by all profiles? |
|---|---|---|
| Registry, `HKCU\Software\Autodesk\AutoCAD\R26.0\ACAD-A101:409\Profiles\Tim` | Saved settings: object snap, coordinates display, attribute boxes, plotter last used, save folder, log folder, SECURELOAD, options window state | No, per profile |
| Registry, same product key, `FixedProfile` | AutoCAD window position, text window position, file-box setting (FILEDIA), command-box setting, dynamic input (DYNMODE) | **Yes** |
| Registry, same product key, `Recent File List` and the value `LastRunTime` | Recent drawing entry; time of last run | **Yes** |
| Roaming folder `AutoCAD 2027\R26.0\enu\Support\Profiles\tim\profile.aws` and `FixedProfile.aws` | Palette and tool palette positions; which "do not show again" boxes are hidden | First no, second **yes** |
| Roaming folder `...\Support\acad.CUIX` | Ribbon, toolbars, workspaces | **Yes** |
| Roaming folder `...\Recent\<name of each file box>` | Shortcuts to the last folders and files used in each file box (19 boxes, 939 shortcuts) | **Yes** |
| Roaming folder `...\Support\AcCommandWeight.xml`, `AutoCorrectorCounterfile.xml`, `CommandAutoCorrectDic.cus` | How often each command is typed (drives the suggestion list at the command line) | **Yes** |
| Roaming folder `...\RecentBlocks` | The Blocks panel's recent list | **Yes** |
| Roaming folder `...\.WebView2` | The Start page's own browser data | **Yes** |
| Local folder `AutoCAD 2027\R26.0\enu` | `acad.startup`, plot and publish log, drawing-compare backups, graphics cache | **Yes** |

**Three profiles exist in the registry: "Tim" (the current one), "<<Unnamed Profile>>" and "ZeroTrial".** This room did not make ZeroTrial and has never used it; who made it and when is not known to this room. It is named here because rule 1.9 is about profiles.

## 3. What a start and a normal quit write (SEEN from today's 3:37 pm to 3:52 pm session)

**At the start (3:37 pm):**
1. `acad.startup` and the Template folder (local folder).
2. `acad.CUIX` and `acad.bak.cuix` (the ribbon file is re-saved at every start; whether by AutoCAD or by the old CE plug-in is not known).
3. The old CE plug-in's own folder `ce_struc_suite` (the installed plug-in loads in every AutoCAD, a test one too, and writes its own files).
4. Licence check: `C:\ProgramData\Autodesk\AdskLicensingService\` (logs, `nlm-server-info.json`, `adlm-err.log`).
5. Autodesk's crash-report log (`CER\...\cer.log`) and `Logs`.
6. `CommandAutoCorrectDic.cus` (seen at the morning session's start, 10:01 am).

**While open:** the Recent shortcut for any file box used; `RecentBlocks`; the Start page's browser data.

**At the quit (3:52 pm):**
1. `Profiles\tim\profile.aws` and `FixedProfile.aws` (re-saved at every quit).
2. Licence service data (`AdskLicensingService.sds`) and licence logs.
3. The Start page's browser data (about 20 files).
4. `AcCommandWeight.xml` and `AutoCorrectorCounterfile.xml` (seen at the morning session's quit, 11:31 am).

**Six minutes after the quit (3:58 pm):** usage reports for Autodesk are written to `Roaming\Autodesk\ADPSDK\JSON\Upload` and sent.

**Registry at quit:** which values are re-written could not be seen (key dates were not read). AUTODESK says profiles are "user-defined registry profile" settings, and that REMEMBERFOLDERS and the roaming folder path are "Saved in: Registry". That AutoCAD writes the window position, the recent drawing and the profile's settings at quit is a **GUESS** from the key names.

## 4. What Tim would notice in his own next session, and how a test start avoids it

| # | What changes | Would Tim notice? | How a test start avoids it |
|---|---|---|---|
| 1 | The test drawing `open_me.dwg` joins AutoCAD's recent drawings and the Start page. Opening by double-click route also puts it in Windows' own recent list and AutoCAD's taskbar list (GUESS for the Windows part) | **Yes, small:** one extra name, and with only one entry kept in the registry list it may push his last drawing off that list (GUESS) | Not avoidable by a documented switch. Either accept and tell Tim, or Tim's yes for another route (section 5) |
| 2 | Saved settings: object snap, file boxes on or off, dynamic input, attribute boxes, SECURELOAD | **Yes, badly,** if a script ever set one: it stays set for Tim | Scripts never set a system variable. Already a rule (picture route condition 4); the check room verifies it |
| 3 | AutoCAD window position and size | Only if the test AutoCAD was moved, sized or opened on another screen | The runner never moves or sizes a window. Where Windows first puts it is a GUESS |
| 4 | Palette and ribbon layout (`profile.aws`, `acad.CUIX`) | Only if the test session ended with a palette opened or closed differently | Open and close no palette. A GUESS that an unchanged session re-saves the same layout |
| 5 | Last folder in a file box (Open, Save, NETLOAD) | Yes: his next Open would start in the test folder | Use no file box. NETLOAD is sent from a typed LISP line, which takes the path with no box (GUESS until run: not re-read tonight) |
| 6 | Command suggestion order (command weights) | Maybe: night commands such as CEPIT1 could show in his suggestions, and PT rise in the list | Not avoidable under his profile. Whether commands sent by the runner are counted at all is a GUESS |
| 7 | Blocks panel recent list | Maybe, if a block placed by the plug-in counts as a recent block (GUESS) | Not avoidable under his profile |
| 8 | Drawing Recovery panel at his next start | **Yes, certainly,** after any forced close or crash of the test AutoCAD | Normal quit first, always. After a forced close (D-160) the note for Tim says it will appear and that it only names the test copy |
| 9 | Plot log and "last plotter used" | Yes, a line in his plot log, if a night step ever plots (owed item O-6) | Keep plotting out of the night, or Tim's yes for that step |
| 10 | Autosave and backup files of the test drawing in his autosave folder | Unlikely | Quit without saving; short runs |
| 11 | Licence check and sign-in | No, unless the sign-in has run out: then a sign-in window shows | Nothing to avoid. A licence or sign-in window stops everything (rule 1.9) |
| 12 | Usage reports and crash reports sent to Autodesk under Tim's account | No. A crash may show Autodesk's "send report" window | That window is an unknown window: halt for Tim |
| 13 | The old installed CE plug-in loads in the test AutoCAD and writes its own files | Possibly (its logs and settings are his real ones) | Not avoidable without changing what is installed, which is not this room's to do |

## 5. Ways to keep a test start apart, and what each needs

1. **Discipline only (no new permission).** As rows 2 to 5 and 8 above. Leaves rows 1, 6, 7, 12 and 13 touching Tim's settings. This is what the scripts can do today.
2. **A before-and-after look (no new permission).** Read-only lists of the places in section 2, taken before the start and after the quit; differences reported. It avoids nothing, but it tells Tim exactly what a night changed.
3. **Another profile through the `/p` switch (FORBIDDEN without Tim's yes in words, rule 1.9).** AUTODESK: the profile named is "in effect only for the current session", and switches "do not alter the system registry". It would keep rows 2 and 4 apart. It would NOT keep apart the shared items: window position, file-box and dynamic-input settings, recent drawing, command weights, recent blocks, licence, reports (SEEN: those sit outside the Profiles key). Starting under "ZeroTrial" is starting under another profile and needs the same yes.
4. **The headless engine with its `/isolate` switch.** AUTODESK lists `/isolate <userid> <userDataFolder>` in the engine's syntax line but gives no meaning on that page. That it keeps registry and settings apart is a **GUESS** from memory of Autodesk's developer notes. It has no windows, so it cannot show a Pit or Pipe window; it could only serve the typed checks. Whether it counts as "another profile" is Tim's to rule.
5. **A separate Windows user for tests.** All of section 2 is per Windows user, so this keeps everything apart (GUESS that nothing else leaks). It needs Tim to set it up and to sign in to Autodesk there himself; sign-in is never touched by a robot.
6. **Putting things back afterwards (FORBIDDEN).** Removing the test drawing from the recent list or restoring a setting is changing the registry or a saved setting.

## 6. What must be done to turn the guesses into facts

1. On the first allowed night, option 2 above: before and after lists, read only, and this room writes the differences into that night's page.
2. Tim's ruling on options 3, 4 and 5 if the differences are more than he accepts.

## 7. Autodesk's own pages read tonight

1. About Customizing Startup (2027): https://help.autodesk.com/cloudhelp/2027/ENG/AutoCAD-Core/files/GUID-7FDC500C-E04A-432D-A73D-EB1B6C6728B1.htm
2. Command Line Switch Reference (2022 edition; the 2027 table itself was not reached): https://help.autodesk.com/cloudhelp/2022/ENU/AutoCAD-Core/files/GUID-8E54B6EC-5B52-4F62-B7FC-0D4E1EDF093A.htm
3. AutoCAD Core Console (2026 edition): https://help.autodesk.com/cloudhelp/2026/ENU/AutoCAD-Core-Console/files/AUTOCAD_CORE_CONSOLE.html
4. ROAMABLEROOTPREFIX (2022 edition): https://help.autodesk.com/cloudhelp/2022/ENU/AutoCAD-Core/files/GUID-17F7BD8A-98B1-4A9B-8724-D96105B5F6E7.htm
5. REMEMBERFOLDERS (2022 edition, read as a search summary only): https://help.autodesk.com/cloudhelp/2022/ENU/AutoCAD-LT/files/GUID-6CA42228-7F27-4217-8F70-F1C2AF644740.htm

**Not found in Autodesk's pages:** what a profile stores item by item; what is written at quit; anything on the recent drawings list; the meaning of `/isolate`; the Drawing Recovery panel (row 8 is from long-standing AutoCAD behaviour, not re-read tonight).

**Rule 1.9 in full, as it stands for any brief or script made from this page:** "Hands off AutoCAD's profile and licence. No chat, helper or robot may, without Tim's yes in words in that conversation: make, copy, rename, delete or switch an AutoCAD profile; start AutoCAD under another profile; force-close AutoCAD or its headless engine (if it is stuck, leave it, stop, tell Tim); touch Autodesk licensing or sign-in in any way; or change a saved AutoCAD setting or the registry. If a licence or sign-in window appears: do nothing to it, stop, tell Tim. Every brief handed to a helper that may start AutoCAD must repeat this rule in full."
