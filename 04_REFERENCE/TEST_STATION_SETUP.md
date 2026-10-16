# CE Test Station — Tim's virtual machine: set-up and standing orders

> **17 Oct 2026 — the Test Station moves to a spare physical work PC** (ruling D5, `decisions\2026-10-17_V3_ALIGNMENT_RESET.md`).
> Tim: *"i have a spare pc with autocad on it already , happy with the rest"*. The VM below never got past set-up
> (nothing installed, no run). Changes from the VM plan: (1) the test PC also BUILDS (the C++/ObjectARX toolchain is
> installed there), so Tim's PC only drafts and receives installs; (2) acceptance is "Robot-accepted" (D7), not Tim's
> word; (3) set-up is started by Tim pasting `04_REFERENCE\TEST_PC_START_PROMPT.md` into Claude on the test PC.
> Everything else below (bridge files, never-list, client-data rules) still applies until the one plan rewrites it.

**Why:** Tim, 24 Sep 2026 about 11:40 (verbatim): *"I WANT TO MOVE THE TESTING OF THE CE ACAD PLUGIN AND EVERYTHING TO
ANOTHER VIRTUAL MACHINE SO IT CAN RUN REGARDLESS OF ME WORKING ON THIS CURRENT DEVICE"*. Written by the release chat on
Tim's PC. **Read `C:\TimOS\RULES.md` first; it is the only rulebook.** Then `C:\CE_PLAN\START_HERE.md` and
`C:\CE_PLAN\BUILD_TEST_LOOP.md`.

## 1. Who does what

1. **Tim's PC:** Tim drafts there all day. The release chat (`CE_ACAD / release-v3-colleagues`) merges, builds the
   one payload, installs it on Tim's AutoCAD (after hours, on his word), and writes **test requests**.
2. **The Test Station (this VM):** Claude (`CE_ACAD / test-station / 01`) and the Codex CLI. It **installs the payload
   named in a request into the VM's own AutoCAD**, runs Codex's AutoCAD passes, the performance soak and the install
   rehearsals, and writes **results**. It can run at any hour, because nobody drafts on the VM.
3. **The Test Station never:** builds a release payload (one payload, built once, on Tim's PC; the VM also lacks the
   C++/ObjectARX toolchain the Civil build needs), edits plugin code, merges a PR, touches Tim's PC, publishes to
   colleagues or the IT Admin folder, types a credential, or marks anything Tim-accepted. Codex produces evidence;
   only Tim accepts (RULES 4).

## 2. The bridge between the two machines

1. **Plan repo, `C:\CE_PLAN`** (GitHub `timbrand92/CE_PLAN`), pulled before every read, pushed after every write:
   - `TEST_STATION_REQUESTS.md`: **written only by the release chat.**
   - `TEST_STATION_RESULTS.md`: **written only by the Test Station.**
   - Two chats never edit the same file (RULES 6.4).
2. **Payloads and test drawings,** in Tim's own OneDrive (not IT Admin, which colleagues see):
   `%USERPROFILE%\OneDrive - Creative Engineering\CE_TEST_STATION\`
   - `payloads\<label>\`: the three `.bundle` folders plus `SHA256SUMS.txt`, put there by the release chat.
   - `test-copies\`: copies of real job drawings. **Client data: never into any repository**, never copied into
     CE_PLAN, and results refer to drawings by label only (DATA-01).
3. **Evidence** (screenshots, CE logs, Codex reports) stays on the VM under `C:\CE_TEST_STATION\evidence\<request>\`.
   Results cite the path. Screenshots of drawings can show addresses, so they never go into a repo.

## 3. One-time set-up check (look, change nothing, report)

Report each as present / missing. For anything missing, give Tim exact click steps and wait.

1. **Repos:** `C:\TimOS` (`gh repo clone timbrand92/TimOS C:\TimOS`), `C:\CE_PLAN` (`timbrand92/CE_PLAN`), and
   `C:\Lisp Files\CE_ACAD_PLUGIN` (`timbrand92/CE_ACAD_PLUGIN`; read-only use here: `REGRESSION_LOG.md`, test lists,
   `tools\headless-proof`). If `gh` is not signed in, Tim runs `gh auth login` himself.
2. **AutoCAD 2027** at `C:\Program Files\Autodesk\AutoCAD 2027\acad.exe`, opening signed in. **Not verified:** whether
   Tim's Autodesk licence lets AutoCAD run on the VM while it is also open on his PC. Test it once with both open;
   if Autodesk refuses, say so plainly.
3. **AutoCAD 2022** (present for Tim's own Tuesday check; Parts M and X of the Codex list are Tim's, not Codex's).
4. **Codex CLI 0.156.0 or later** (`codex --version`), signed in. **Same account as Tim's PC, so the same weekly
   allowance** (BUILD_TEST_LOOP.md, "Usage budget"). The same is true of Claude.
5. **OneDrive** signed in and the `CE_TEST_STATION` folder syncing.
6. **The VM stays awake and unlocked:** no sleep, no screen lock. Codex drives AutoCAD by looking at the screen, and
   a locked screen stops it.
7. **Existing CE bundles:** list any CE `.bundle` in `%APPDATA%\Autodesk\ApplicationPlugins` and in
   `C:\ProgramData\Autodesk\ApplicationPlugins` (REL-09 step 4: a live one in ProgramData loads first and must be
   reported, not removed).

## 4. Authority on the VM

Before the first install, ask Tim once, in this chat: *"May I install CE builds into this VM's AutoCAD and run Codex
there at any time, without asking each time? Nothing ever touches your own PC."* Record his exact words, dated, at the
top of `TEST_STATION_RESULTS.md`. Without that yes, install nothing.

## 5. Each request

1. `git pull` CE_PLAN; read the newest open request.
2. **Install by the REL-09 hand steps** (`areas\release-v3-colleagues.md`, "REL-09 How the hand install works"): close
   AutoCAD and check `acad.exe` / `accoreconsole.exe` are gone **twice, 10 s apart**; rename the three CE bundles to
   `*_<previous label>.backup`; copy the three bundles from `payloads\<label>\`; check every DLL's SHA256 against
   `SHA256SUMS.txt`; read each module DLL's product version. **If any hash or version differs from the request, stop
   and report.** Going back = the REL-09 going-back steps.
3. **Run what the request names:** Codex parts from
   `C:\CE_PLAN\archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md` (its S1 version gate must name this
   payload), performance runs, headless proofs. Codex model: `gpt-6-astra`, effort low, for AutoCAD tests. One Codex
   run at a time on the VM. Codex rules: BUILD_TEST_LOOP.md rules 1-6 (version gate; PASS / FAIL / BLOCKED / NOT
   TESTED, never a score; answer No to every save; copies only; never F2).
4. **Write results** to `TEST_STATION_RESULTS.md`: request ID; versions and hashes read back; per part the four counts
   and every FAIL (what was done, expected, seen, command-line text, CE log lines); the evidence path. Push.
5. **Say what was not tested.** Always.

## 6. Usage

Both machines draw on the same Claude and Codex weekly allowances. Read BUILD_TEST_LOOP.md "Usage budget" before every
Codex job and record usage before and after in the result. Keep this chat lean: short turns, delegate reading.
