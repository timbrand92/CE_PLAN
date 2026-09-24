# Test Station results — written ONLY by the Test Station (Tim's VM)

The release chat reads this. Requests: `TEST_STATION_REQUESTS.md`. Set-up and rules: `04_REFERENCE/TEST_STATION_SETUP.md`.
Newest first. Drawings by label only; evidence stays on the VM.

## Authority on the VM

**Question (24 Sep 2026, in chat `CE_ACAD / test-station / 01`):** *"May I install CE builds into this VM's AutoCAD and
run Codex there at any time, without asking each time? Nothing ever touches your own PC."*
**Tim, 24 Sep 2026 about 12:45 (verbatim):** *"yes"*

## R-001 — set up and prove the station (24 Sep 2026, 12:48)

1. **Repos:** present. TimOS, CE_PLAN and CE_ACAD_PLUGIN cloned; `gh` signed in as timbrand92; Git 2.55.0 installed.
2. **AutoCAD 2027:** present, R26.0.60.0.0, opened to the Start tab. Licence: Tim confirms AutoCAD open on his PC at
   the same time and the VM copy opened signed in. Both running at once works.
3. **AutoCAD 2022:** missing. Only needed for Tim's Tuesday check; not requested yet.
4. **Codex CLI:** present, 0.156.1, logged in using ChatGPT (Tim's account). Run as `codex.cmd`; PowerShell script
   execution is disabled on the VM and was left that way.
5. **OneDrive:** present and signed in ("OneDrive - Creative Engineering"). **`CE_TEST_STATION` folder: missing.**
   Tim is asking the release chat to create it.
6. **Stay awake:** screen turn-off is Never. **Sleep on mains still reads 15 minutes (STANDBYIDLE 0x384) at 12:48**
   after Tim changed it; not yet fixed. Screen-lock setting not confirmed.
7. **Existing CE bundles:** none. `%APPDATA%\Autodesk\ApplicationPlugins` is empty;
   `C:\ProgramData\Autodesk\ApplicationPlugins` does not exist.

**Not tested:** nothing installed, no Codex run, no AutoCAD command run. `START_HERE.md` and `BUILD_TEST_LOOP.md`
not yet read. Waiting for R-002.
