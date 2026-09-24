# Test Station results — written ONLY by the Test Station (Tim's VM)

The release chat reads this. Requests: `TEST_STATION_REQUESTS.md`. Set-up and rules: `04_REFERENCE/TEST_STATION_SETUP.md`.
Newest first. Drawings by label only; evidence stays on the VM.

## Authority on the VM

**Question (24 Sep 2026, in chat `CE_ACAD / test-station / 01`):** *"May I install CE builds into this VM's AutoCAD and
run Codex there at any time, without asking each time? Nothing ever touches your own PC."*
**Tim, 24 Sep 2026 about 12:45 (verbatim):** *"yes"*
**Tim, 24 Sep 2026 about 13:00 (verbatim):** *"now that you have your own machine all testing can be done at any
time"*. So the RULES AutoCAD-hours window (8:30–2:00, 3:00–5:30) applies to Tim's PC only, not to this VM.

## R-002 — install and pass 9 (status 24 Sep 2026, 15:40)

**FOR TIM:** installed and the version gate passes. Codex pass 9 is running (second try; the first could not see the
screen because the Codex desktop app was not open on the VM).

1. **Payload** `0924-civil-7d85c40f-struc-488f6250`: 1,542 files, every hash matches `SHA256SUMS.txt` on OneDrive and
   again after install (0 mismatches, 0 missing).
2. **Install (REL-09):** AutoCAD closed, checked twice 10 s apart (14:11:11, 14:11:24: none running). Nothing to rename:
   the VM had no CE bundles. ProgramData ApplicationPlugins does not exist. Tim ran the copy (Claude's copy was blocked
   by the app's safety check). Going back: close AutoCAD, delete the three bundles.
3. **Versions read back (S1 gate): PASS.**
   - Civil Legacy / Net8 / Modern: `3.0.1+7d85c40f7908b45f6d07343f6520477529628d14`
   - Manager Legacy / Net8 / Modern: `1.1.1+7d85c40f7908b45f6d07343f6520477529628d14`; CE_SHARED.dll identical to
     Civil's in all three lanes (version `1.1.0+inspector-contract.1.7d85c40f…`)
   - Structural Modern: `1.0.75+488f6250445206c754d51e71d1f8cdcc00b65d44`; `CE_STRUC_NATIVE_2027.arx` present; no
     CE_SHARED.dll. Legacy and Net8 lanes absent from this payload (by its SHA256SUMS).
4. **Codex attempt 1 (15:17):** S1–S4 PASS; S5 BLOCKED: computer-use native pipe unavailable (Codex desktop app not
   running). All later steps BLOCKED, nothing in AutoCAD tested. Evidence:
   `C:\CE_TEST_STATION\evidence\R-002\attempt1_cli_no_computer_use\`.
5. **Codex attempt 2:** S5 BLOCKED again: the CLI's config names an old computer-use pipe; the live one differs. Fixed
   per run with `-c mcp_servers.node_repl.env.SKY_CUA_NATIVE_PIPE_DIRECTORY='<live pipe>'` (launched from PowerShell;
   Git Bash mangles `\\.\pipe\`). **Attempt 3:** screen control worked, but `launch_app` timed out on AutoCAD's slow start.
   **Attempt 4 (15:45):** station started AutoCAD first; Codex found the window. **S5 BLOCKED by a real finding:**
   AutoCAD shows **"Security - Unsigned Executable File"** for `ce_cvl_native_grip_2027.arx` (Publisher: Unknown
   Publisher; location `%APPDATA%\Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\...\Modern`; buttons Always Load /
   Load Once / Do Not Load). Codex correctly did not answer a security prompt. **For the pilot:** a colleague's fresh
   AutoCAD 2027 will show this same prompt unless the ARX is signed or the bundle folder is trusted. Waiting for Tim's
   choice on the VM. Evidence: `evidence\R-002\P9_S5_modal2.png`. Usage 7% weekly.
6. **Not tested yet:** every AutoCAD step of pass 9; performance Parts 2 and 3; R-003.

## R-001 — set up and prove the station (24 Sep 2026, 12:48)

1. **Repos:** present. TimOS, CE_PLAN and CE_ACAD_PLUGIN cloned; `gh` signed in as timbrand92; Git 2.55.0 installed.
2. **AutoCAD 2027:** present, R26.0.60.0.0, opened to the Start tab. Licence: Tim confirms AutoCAD open on his PC at
   the same time and the VM copy opened signed in. Both running at once works.
3. **AutoCAD 2022:** missing. Only needed for Tim's Tuesday check; not requested yet.
4. **Codex CLI:** present, 0.156.1, logged in using ChatGPT (Tim's account). Run as `codex.cmd`; PowerShell script
   execution is disabled on the VM and was left that way.
5. **OneDrive:** present and signed in ("OneDrive - Creative Engineering"). **`CE_TEST_STATION` folder: missing.**
   Tim is asking the release chat to create it. **Update 24 Sep:** now syncing on the VM (Tim ticked it in Choose
   folders). `test-copies\` holds 881 files (online-only until opened); `payloads\` is empty, as expected before R-002.
6. **Stay awake:** screen turn-off is Never. **Sleep on mains still reads 15 minutes (STANDBYIDLE 0x384) at 12:48**
   after Tim changed it; not yet fixed. Screen-lock setting not confirmed. **Update 24 Sep:** not a problem —
   `powercfg /a` shows the VM firmware supports no sleep or hibernate state at all, so the 15-minute value never
   fires (Windows hides the sleep option for this reason).
7. **Existing CE bundles:** none. `%APPDATA%\Autodesk\ApplicationPlugins` is empty;
   `C:\ProgramData\Autodesk\ApplicationPlugins` does not exist.

**Not tested:** nothing installed, no Codex run, no AutoCAD command run. `START_HERE.md` and `BUILD_TEST_LOOP.md`
not yet read. Waiting for R-002.
