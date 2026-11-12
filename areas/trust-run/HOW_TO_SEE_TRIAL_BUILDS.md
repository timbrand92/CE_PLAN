# How a trial build could be seen in real AutoCAD without touching Tim's installed bundle

**Written:** Fri 13 Nov 2026, 02:20, lane trust-acad-evidence. **Research only.** I did not install, change any setting, start a second AutoCAD for this, or send a request to the test station. Facts marked **seen** I read tonight from files or the PC; **record** means the plan files say so; **not proven** means nobody has tried it.

---

# FOR TIM

**The question:** the opening line, the windows, the ribbon, Undo on the new builds and all the Structural fixes cannot be seen without a trial build loaded in a real AutoCAD. Loading it on your PC means installing it. Is there a way that never touches your bundle?

1. **Short answer: yes, but only on a second machine or a second login. On your own login, no.** Every AutoCAD you start as yourself loads your installed CE bundles first. Loading a trial beside them would clash (the first CE_SHARED loaded wins, and the commands would be doubled). I know of no safe switch for that.
2. **What works tonight, with nothing from you:** the AutoCAD core console (no ribbon, no windows, no idle). It loads a trial build from its own folder and never sees your bundle. That is how I proved step 5. It cannot show windows, the ribbon, or anything that happens when a drawing opens.
3. **The virtual machine test station is not alive as far as the records show.** It never got past set-up. Its last entry is 24 Sep ("paused until Monday"). On 17 Oct the plan moved the test station to your spare work PC (ruling D5). No result has been recorded from either since. I cannot see either machine from here.
4. **My recommendation: the spare PC.** It is the only option that gives a real AutoCAD, with windows and the ribbon, running all day, with your own PC never touched, and it is already your ruling (D5; 29 Oct: "on the other one testing all day"). It needs one thing from you: the one-off 30-minute set-up, by pasting `04_REFERENCE\TEST_PC_START_PROMPT.md` into Claude on that PC. You said on 29 Oct you could not do it then.
5. **If the spare PC cannot be set up soon:** the next best is the AutoCAD 2026 laptop you offered on 29 Oct. Nobody has assessed it. It is a different AutoCAD year, so it would be a first look, not the 2027 proof.
6. **What I would not do:** install trial builds on your own PC at night and put the old ones back (your option (a) in the question for the controller). It is workable, but it is the one choice that touches your bundle, and a mistake costs you a morning.

**What each option needs from you, in one line each**
1. **Core console (now):** nothing.
2. **Spare PC:** 30 minutes, once, and the PC on and awake at work.
3. **Laptop with AutoCAD 2026:** whose laptop, its Windows login, its Autodesk sign-in, and when it can stay on. Then an assessment first.
4. **A second Windows login on this PC:** you would create the account; the robot would then need you logged out or locked, because the robot drives the screen. Possible, clumsy.
5. **Autodesk cloud runner:** a developer account and a small cost per hour; you said no paid tools on 29 Oct.

---

# DETAIL

## 1. Why your own login cannot do it

1. **seen:** AutoCAD loads CE from three folders: your own `%APPDATA%\Autodesk\ApplicationPlugins` (CE Civil, Structural, Manager, AutoCADLink, Transform trial), `C:\ProgramData\Autodesk\ApplicationPlugins` (a CE Manager bundle of version 1.0.0, dated 8 Jul 2026) and `C:\Program Files\Autodesk\ApplicationPlugins` (an AutoCAD-MCP-Server bundle). Any AutoCAD that starts under your login loads the first group. The footer of the AutoCAD window on 13 Nov read Manager 1.1.89, Civil 3.0.90, Structural 1.0.126, so the copy in your own folder is the one that loads.
2. **seen:** the ProgramData Manager 1.0.0 is a second CE bundle. The release notes (REL-09) say a live one in ProgramData loads first and must be reported, not removed. In practice your footer shows 1.1.89, so it did not win. I did not touch it. It is worth a look by the release chat.
3. **record:** the "first CE_SHARED loaded wins" rule (memory note on CE_SHARED) means a trial NETLOADed after the installed one would run on the installed one's shared code.
4. **not proven:** AutoCAD may be told not to load apps at start (the system variable APPAUTOLOAD, and the profile). Changing either is a setting change and writes to your AutoCAD profile, so I did not try it. Do not do this on your login.

## 2. What the core console can and cannot do

1. **seen tonight:** `accoreconsole.exe` with `/isolate` loads only what the script names. CE's live log did not grow while it ran. The repo's harness (`tools\headless-proof\Run-HeadlessProof.ps1`) loads a Civil build from a scratch folder; I built five branch heads this way tonight.
2. **Can show:** any command that works without a window or an idle moment (CDGRAPH, CDDIAG, CDSYNC, CDREBUILD), and the drawing's data before and after through DXF exports.
3. **Cannot show:** the opening line (fires on idle), every window (Edit Pit, Edit Pipe, the dashboard, Pit Schedule), the ribbon, and Undo as a person sees it (the console's U differed from real AutoCAD tonight).
4. **A machine-wide lock:** the console cannot start while the full AutoCAD is open (record, 9 Oct research), so the two take turns.

## 3. The test station

1. **record, `TEST_STATION_SETUP.md`:** a virtual machine plan of 24 Sep. First result: AutoCAD 2027 present, CE bundles none, Codex present, OneDrive folder syncing, "paused until Monday" on 24 Sep at 17:17. R-002 (install and run pass 9) was started and partly recorded (Part S: 7 pass, 1 fail). R-004 was started. No later commit touches the request or result files.
2. **record, the same file's top note, 17 Oct (ruling D5):** the virtual machine "never got past set-up" and the station moves to a spare physical work PC that already has AutoCAD, which also builds; set-up starts by pasting `04_REFERENCE\TEST_PC_START_PROMPT.md` into Claude on that PC.
3. **record, `decisions\2026-10-17_V3_ALIGNMENT_RESET.md` line 218:** the spare PC is at work, so its set-up waits until you are back. **record, 29 Oct:** you said you could not do the set-up then ("i cant do it now") and asked about a laptop with AutoCAD 2026; the desk was to assess it; I found no assessment. Also 29 Oct (answers batch 10): "no only my computer, on the other one testing all day".
4. **How a request is made (record):** the release chat writes `TEST_STATION_REQUESTS.md` in CE_PLAN; the station writes `TEST_STATION_RESULTS.md`; payloads and test copies travel in a OneDrive folder `CE_TEST_STATION`. I did not write to either file.
5. **Is it alive?** Not seen. The newest entry in either file is 24 Sep, and no later file records a result from the spare PC or the virtual machine. I cannot check the machines from here, so this is "no record of life", not proof it is down.

## 4. The options, in order of my preference

1. **Spare work PC (D5).** Real AutoCAD 2027 with its own seat (your 29 Oct ruling that no licence blocks it), runs outside your drafting. Shows everything the console cannot. Needs your 30-minute set-up, then the trial build is installed there, never on your PC. Open: whether its graphics and screen scale match yours (your 29 Oct answer says compare three cases).
2. **A laptop with AutoCAD 2026.** Not assessed. The 2026 line uses the net8 build folder (the bundle carries one); the robot driver was built for 2027; the laptop needs a Claude session, repo access and an install through the real route (which doubles as an install rehearsal).
3. **A second Windows login on this PC.** `ApplicationPlugins` is per login, so the trial build could live in the other login with no CE of yours. **Seen:** the only local logins are BACKUP and two Codex sandbox accounts; none is a drafting login. Needs an account (a Windows setting, so only you). The robot drives the screen, so the other login must be the one on screen: your own session would have to be locked, which makes it an out-of-hours option only. Licence sign-in per login. **Not proven.**
4. **The virtual machine.** Not alive as far as the records show; superseded by D5. Reviving it needs its set-up finished (nothing installed on it ever). **seen:** this PC runs a hypervisor (it reports one present) and Windows 11 Business, but neither Hyper-V's `vmms.exe` nor Windows Sandbox is installed here, so a new virtual machine would first need a Windows feature turned on (a setting; yours to approve).
5. **A launch with a different `APPDATA`.** AutoCAD started with its own scratch application-data folder would not find your bundles. **Not proven.** AutoCAD also keeps its profile in the registry under your login, so a launch like this could still write to your profile. I did not try it and would not without your word.
6. **The driver's `launch -Env CE_LOG_DIR_OVERRIDE`.** Moves CE's logs and settings only; it does not hide the bundle. Not an answer to this question.
7. **Autodesk's cloud runner.** Needs a developer account and costs per hour (record, 9 Oct research); you ruled out paid tools on 29 Oct.
8. **Install on your PC between 5:30pm and 8:10am and put the old build back.** This is the controller's option (a). It works, but it is the only choice that changes your bundle; each night would need a file-by-file restore check. Not recommended while one of the other machines can be used.

## 5. What I recommend, step by step

1. **Tonight and every night, no cost:** keep running the core console A/B for everything callable. It is done for step 5; item 10 (the reader) runs the same way.
2. **Ask Tim, once, in batch 0:** "Can the spare work PC be set up (30 minutes), and if not this week, may the AutoCAD 2026 laptop be assessed?" Recommendation first: the spare PC.
3. **Meanwhile:** nothing is installed on your PC and no setting changes.
4. **To tidy, by the release chat, not me:** the 111 backup folders (about 8 GB) sitting inside your own `ApplicationPlugins` folder, and the old Manager 1.0.0 in ProgramData.

## 6. Not done and not known

1. I did not read the spare PC's state, or whether anyone ever pasted its start prompt. Nothing in the records says it was done.
2. I did not test APPDATA override, APPAUTOLOAD or a second login.
3. I did not check the AutoCAD 2026 laptop at all.
