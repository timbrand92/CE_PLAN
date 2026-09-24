# Test Station briefing — everything the VM chat needs to know (24 Sep 2026, 15:35)

Written by the release chat on Tim's PC (`CE_ACAD / release-v3-colleagues / plan / 02`) because Tim said the VM's Claude
"has no understanding of anything". Read this whole page, then `C:\TimOS\RULES.md`, then
`04_REFERENCE\TEST_STATION_SETUP.md`, then `TEST_STATION_REQUESTS.md`. Then start R-002.

## 1. Who and what

1. **Tim Brand** — civil/structural engineer in Melbourne, runs Creative Engineering (CE). Not a coder. He drafts in
   AutoCAD all day. Talk to him in AutoCAD terms, answer first, numbered lists with bold labels, no tables, short.
   `C:\TimOS\RULES.md` is the only rulebook.
2. **The CE plugin** is three AutoCAD plugins, each a folder in `%APPDATA%\Autodesk\ApplicationPlugins`:
   - **Civil** `CE_CVL_SUITE.bundle` — drainage: pipes (CD), pits (PIT), edit (CDEDIT / double-click), tanks (CDWT),
     calculations (CDCALC), design (CDDESIGN, CDRAINFALL, CDLPD), import (CDIMPORTXCIVIL), checks (CDCHECK), Project
     Review, Inspector. Ribbon tab **CE**. Three lanes inside: `Win64\Legacy` (AutoCAD 2022-24), `Net8` (2025-26),
     `Modern` (2027).
   - **Manager** `CE_SUITE_MANAGER.bundle` — CE Tools tab, CEMANAGER window, updates, settings. Shares one library
     (`CE_SHARED.dll`) with Civil; the two copies must be byte-identical.
   - **Structural** `CE_STRUC_SUITE.bundle` — CE STRUC tab: beams (SBEAM, RCBEAM), columns, footings, notes, sheets,
     legacy tools (RC cloud, CJ, SSC, REBAR, LU...). No CE_SHARED.
3. **Version string** = the DLL's product version, e.g. `3.0.1+7d85c40f...`: number + the exact code commit. It is the
   only reliable way to know what is installed. Always read it; never trust a document.
4. **The goal this week:** Version 3 to a first colleague (a pilot) on **Tuesday 29 Sep**. The release chat on Tim's PC
   builds and installs; **you test**, so testing runs while Tim drafts.

## 2. Where everything is

1. `C:\CE_PLAN` (git, pull before reading, push after writing): the plan. `START_HERE.md`; `areas\release-v3-colleagues.md`
   (today's log, items 44 onward); `BUG_CARPARK.md` (the one bug file); `PENDING_TESTS.md` (what waits for AutoCAD
   testing; the newest "LIVE since 24 Sep 14:46" block); `BUILD_TEST_LOOP.md` (how Codex tests and the usage budget).
2. `C:\Lisp Files\CE_ACAD_PLUGIN` — the code. You only READ it (REGRESSION_LOG.md has every change and Tim's AutoCAD
   checklist for it; `tools\headless-proof` runs CE headless). Never edit, build or push it.
3. `%USERPROFILE%\OneDrive - Creative Engineering\CE_TEST_STATION\` — `payloads\` (built plugin versions from Tim's PC),
   `test-copies\` (copies of real job drawings — client data: never into a repo), `inputs\` (office drawings to measure,
   Tim's screenshots).

## 3. What is true right now

1. **Tim's PC runs** (installed 14:46): Civil `3.0.1+7d85c40f`, Manager `1.1.1+7d85c40f`, Structural `1.0.74+8c077569`.
2. **The payload for you** (`payloads\0924-civil-7d85c40f-struc-488f6250\`): the same Civil and Manager bytes, plus
   Structural `1.0.75+488f6250` (a candidate; its full test suite is still to finish on Tim's PC tonight).
3. **Tim already confirmed on 3.0.1 today — do not re-test as new:** the version number, grips on plain rectangles
   (BUG-159), Off/On keyword choices in CDGRIPDIAG (BUG-168), one U after an Edit Pipe change, and that CDDESIGN,
   CDRAINFALL and CDLPD open their windows.
4. **Known faults being fixed right now — record what you see, but they are not new:** BUG-170 What's New window hard to
   read / untrue lines; BUG-171 an upgraded old pipe opens as Detention; BUG-172 Civil ribbon pictures misaligned;
   BUG-173 Pit windows and Edit Pipe should look like the CD / New Pipe window; BUG-174 "[CE]" inside a command-line
   question is offered as a choice (e.g. CDDESIGN shows Yes / CE).

## 4. Your job now

1. **R-002** (`TEST_STATION_REQUESTS.md`): install the payload by the REL-09 steps, check hashes and versions, then
   Codex pass 9, then the performance runs. **R-003**: measure three office drawings headless, any time there is a gap.
2. **Tim already said yes** to installs on the VM at any time (recorded in `TEST_STATION_RESULTS.md`).
3. **Codex** runs from the command line on the VM (`codex.cmd`; PowerShell scripts are disabled there). Pattern:
   ```
   codex.cmd exec --skip-git-repo-check --dangerously-bypass-approvals-and-sandbox -m gpt-6-astra -c model_reasoning_effort="low" -C C:\CE_TEST_STATION -o C:\CE_TEST_STATION\evidence\R-002\pass9.last.txt "<brief>" < NUL
   ```
   The brief = which parts to run, the S1 version gate from R-002, the rules from the Codex list
   (`C:\CE_PLAN\archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md` section 1 with the VM changes in
   R-002), and "report PASS / FAIL / BLOCKED / NOT TESTED per step with evidence; never a score". One Codex run at a
   time. Codex tests by looking at the screen: the VM must stay unlocked and awake.
4. **Pass 9 content** is listed in R-002. For each PR's steps, read "Tim's AutoCAD checklist" in the code repo's
   `REGRESSION_LOG.md` (pull first) and turn it into numbered steps for Codex.
5. **Report** in `TEST_STATION_RESULTS.md` after the install and after each part: versions read, four counts per part,
   every FAIL with what was done / expected / seen / command-line text / CE log lines, and what was NOT tested. Push.
   Tim reads a short FOR TIM summary; the release chat reads the detail and fixes what fails.

## 5. Never

1. Never touch Tim's PC, his AutoCAD, his settings or his drawings. Only this VM.
2. Never publish anything to colleagues or the IT Admin folder; never type a password or key.
3. Never save a drawing, a template or an AutoCAD profile during tests (answer No to every save); work on copies in
   `C:\CE_TEST_STATION\test-copies`; never press F2 (it runs a CE clean-up command on this profile).
4. Never mark anything accepted: only Tim's word in AutoCAD accepts. Codex produces evidence.
5. Never put a client name or site address in CE_PLAN or any repo; drawings are DWG-A, DWG-B, DWG-S by label.
6. Codex usage is shared with Tim's PC: stop at **14% weekly today**, carry on tomorrow.
