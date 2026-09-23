# PENDING TESTS — what is built and waiting for Tim in AutoCAD

## Feedback window — FEEDBACK-UI-01 (24 September 2026, awaiting release)

1. **Branch:** `codex/ui-feedback`, takeover merge `741051b7`; final code tip and PR will be recorded in the release area. Code only: no installation and no AutoCAD acceptance. Automated compiled-window pictures are being checked in dark/light at 1080p scale 1.
2. **One representative session after Claude installs, AutoCAD 2027 and 2024/net48:** open CDFEEDBACK. Details opens first; title, description and Save/Cancel fit without a scrollbar in dark and light themes. Choose Idea, write a synthetic title and multiline description, visit Included information and return: the draft and type stay. Save enables only with both fields filled, and Enter in the description adds a line.
3. **Save/cancel remainder:** save that synthetic report and check the file named in AutoCAD's command line; it contains the chosen type, title and description. Repeat with Cancel, Escape and the title-bar close: no new feedback file. Reopen on Details. A draft over 2,000 characters warns that the file is shortened; editing below the limit clears that warning. Check normal and 150% display scaling.
4. **Routed to Claude-owned behaviour:** automatic screenshot attachment, shared delivery/receipt and an in-window save-failure retry require FeedbackCommand/FeedbackService work. The window accurately describes the existing local-file route; it does not claim those design-pack capabilities are implemented.

**This is the one living list, across every chat.** A chat ending must never take the test list with it.

## Rules for every chat

- **When you build something**, add it here with its branch, commit and the exact steps Tim should follow.
- **When Tim confirms a pass**, move it to "Accepted" at the bottom with the date and the build he tested.
- **When Tim reports a failure**, say so here — do not delete the row.
- **Never tick anything yourself.** A green build, a passing test run and an AutoCAD result are three different
  facts. Only Tim's word moves a row to Accepted.
- Steps must be **specific**: *"open a 375 pipe and check the Edit Pipe window shows 375"*, never *"test pipe
  editing"*. Include the failure paths — Cancel, Escape, a refused save, one accepted edit = one Undo.
- Say which **lane**: AutoCAD 2027, and separately 2024/net48 — Tim ruled 2022–2024 users are in scope.

---

## CDWT-LAYOUT-02 — code built; release gate blocked — 24 Sep 2026

1. **Candidate:** draft [PR #135](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/135), `codex/ui-cdwt` at `24dde703`. Three build lanes: 0 errors. Focused Water Tank: 192/192. Full Civil: 10,353 passed, 12 failed, 19 skipped; the extra failure above the 11 known is the unrelated PDF resource-in-use test. Master subsequently advanced; integration has a regression-log-only conflict. Not installed or accepted.
2. **Already automated:** both themes, every bounded page, minimum/opening dimensions, fixed footer, captions, paging/selection, matched-first plans, gold/blue next action, typed capacity, empty lists and page-button double clicks. Twenty real-window off-screen pictures inspected and committed. No AutoCAD launch in this build session.
3. **Remaining after separately authorised combined installation — AutoCAD 2027:** open CDWT, choose a tank and check its matching plan is first; visit the last capacity and Plan pages, choose a plan, switch tabs and confirm capacity/selection and footer stay fixed. Check dark/light once, typed litres and detention/reuse. Complete representative Place/double-click and Tag existing flows; Cancel/Escape draw nothing; one Undo and save/reopen retain the established behaviour.
4. **AutoCAD 2024/net48:** confirm the existing CDWT entry still works; this WPF window change compiles only in the 2027 lane. Tim's native acceptance remains pending. See `areas/civil-G-water-tanks-cdwt.md` section 10 for the handoff.

---
## COLLEAGUE RELEASE, Tuesday 29 Sep — Codex runs the AutoCAD testing (Tim, 23 Sep)

**The one run list:** `archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md`. Pass 1 covers the installed
`aeb03763` (installed 12:18 by the release chat), including the 18 Sep list, V1 to V18 below and the deploy chat's
`CODEX_TEST_RUN_2026-09-23.md` folded in as Part B. All of it is **installed now**, even where headings still say NOT INSTALLED. Area: `areas\release-v3-colleagues.md`.

---

## LIVE since 23 Sep 2026 11:26 — `3.0.0+b02f3ec7` built from **master**

Tim: **"AUTOCAD IS CLOSED, DEPLOY"**. **The first release built from `master`**, now that PR #87 has made the
main line equal what is installed.

**Read back by hand from all three lane DLLs, not from the installer's output — all three identical:**

1. **Legacy** (net48, AutoCAD 2022–2024) — `3.0.0+b02f3ec7988e9666199aab5bbd16dee482acd09b`
2. **Net8** (AutoCAD 2025–2026) — same
3. **Modern** (net10, AutoCAD 2027) — same

Lane SHA256: Legacy `B1666539…5826A1` · Net8 `54337DB6…D4D517` · Modern `BAB029FC…6800FA8`.
Native modules staged in Modern: grip `.arx` 82 KB, objects `.dbx` 108 KB, transform `.arx` 74 KB.

**Tim's one-action undo** — the deploy script does not back up, so both were taken by hand first:

1. `CE_CVL_SUITE_PRE_d90659cf_20260923-110557.backup` — 133 MB, 806 files
2. `CE_SUITE_MANAGER_PRE_CESHARED_20260923-110557.backup` — 75 files

**CE_SHARED** — the script does not sync it. All three Manager lanes differed and were copied from Civil,
each hash-verified after the copy: Legacy `B35FEE12…`, Net8 `F98CE4C0…`, Modern `41DD9367…`.
Independently re-read afterwards and confirmed identical lane for lane.
**STRUCTURAL IS NOT REDEPLOYED** — still `1.0.74+5d723d41`.

### What this carries beyond `d90659cf`

1. **CDWT-LINK-01** — a tank finds its own plan drawing, matched on the litres in the plan caption.
2. **CD-RECENT-01** — the CD window's "Recent:" strip trimmed (four diameter buttons, not ten).
3. **DEPLOY-01** — the release script's reference paths, and a preflight over eleven inputs.
4. Two client addresses out of the saved code; the command-count guard corrected for `SML`/`CHECKML`.

### Testing

**`CODEX_TEST_RUN_2026-09-23.md`** (55 steps, mine) is folded into the release chat's single list as **Part B**.
That list is the one Tim uses. **Part X needs an AutoCAD 2024 machine** and is carried to Monday's colleague check.

### The first attempt was refused, and it is worth recording

At 11:07 the installer stopped: `ERROR: AutoCAD is running (PID 8616)` — AutoCAD had been opened between the
two checks. **Nothing was copied or removed.** On the retry the first check caught AutoCAD **still shutting
down** (a process at 64 K), so **four** checks were made before installing. `accoreconsole.exe` was also
running; its loaded modules were inspected and it was not holding the bundle. **The deploy script checks only
`acad.exe`, never `accoreconsole`.**

---

## LIVE since 23 Sep 2026 23:45 on Tim's PC — Civil `3.0.0+6eec48af`, Manager `1.1.0+6eec48af`, Structural `1.0.74+5ca35054`

1. **Installed by the release chat.** Civil + Manager 23:42-23:44 from master `6eec48af`; Structural 23:45 from candidate
   `5ca35054` (`claude/struc-ribbon-organised`, Modern SHA256 `F608578A...92783CB7E`). CE_SHARED is identical in Civil and
   Manager in all three lanes (D7E6BFC5 / 4DEA942A / 01ACC18C); Structural carries none. Modern natives: grip ARX,
   transform ARX, object DBX.
2. **Civil was deployed from `Installer\payload_build` without the release zip**, because `build_installer.ps1` hung
   twice at `Compress-Archive` (BUG-167). Every lane was built and checked before the hang, and all three read `6eec48af`
   before the copy.
3. **Carries, beyond 19:10:**
   - #117 HEADLESS-PROOF-01
   - #118 LAYER-CASE-01
   - #119 SPLIT-HALVES-01
   - #120 PIT-OUTLINE-01
   - #122 HELP-V3-01
   - #123 RIBBON-02
   - #124 CDWT-CONTRAST-01
   - #128 C7-DRAW-01
   - Structural's organised ribbon
4. **Backups:** `CE_CVL_SUITE_PRE_19c77126_20260923-234112.backup`, `CE_SUITE_MANAGER_PRE_19c77126_20260923-234112.backup`,
   `CE_STRUC_SUITE_PRE_bf264cbb_20260923-234521.backup` (all in `%APPDATA%\Autodesk\ApplicationPlugins`). Two earlier
   Civil backups from the hung attempts (`..._20260923-214427`, `..._20260923-231539`) are identical copies of 19c77126.
5. **Codex pass 6** (launched 23:50 by the release chat): re-runs X1-X8 for the items above; report
   `_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS6_2026-09-24.md`.
6. **INVALIDATES:** pass 5 results for CDWT's status line, the ribbon, Help and the Structural ribbon (their code
   changed). Pass 5's R-B (Manager) and R-C (criteria labels) stand: that code did not change. R-A-4 is still a
   known FAIL.
7. **Merged after this build, NOT installed:** #121 SPLIT-LEVEL-02, #129 UC behaviour (New Pipe readiness, CDCALC Unknown
   wording, drafting words, CDFALL/Spot Level Escape).

## LIVE since 23 Sep 2026 19:10 on Tim's PC — Civil `3.0.0+19c77126`, Manager `1.1.0+19c77126`, Structural `1.0.74+bf264cbb`

Adds, on top of 17:11 (none Tim-accepted; Tim's new rule: Codex-proven first, then his short final check). Installed at 18:01 and Codex PASS in pass 4: new pit labels and batch resize (Z8d), SBEAM (Z8a), older-pipe wording (Z8e). New at 19:10:

1. **CDEDIT-LEGACY-01** (PR #115): on a copy of an older drawing, double-click a pipe's level text. CE highlights the pipe's label and asks whether it is this pipe's label; Yes records it and opens Edit Pipe; next time it opens straight away; No changes nothing.
2. **MGR-STATUS-01** (PR #113): CEMANAGER shows Structural once, installed and running; Manager's own "Installed next start"; the footer "3 of 3 installed CE plugins running".
3. **CRITERIA-LABELS-01** (PR #114): CDCALC, Detention, Insert Criteria Block: the labels sit down the left beside their values; nothing at 0,0.
4. **P06-MESSAGES-01** (PR #116): the detention length prompt says "drawn length"; Enter keeps the drawn length.
5. **MODELSPACE-CASE-01 + IDENT-02** (PR #112): PIT twice: both number labels; both pits resize together; one Undo.

Pilot **candidate 4** at `_RELEASE_V3_PILOT\candidate-4-civil-19c77126`, 0 files differing from the live set.

---

## LIVE since 23 Sep 2026 17:11 on Tim's PC — Civil `3.0.0+9df46d7b`, Manager `1.1.0+9df46d7b`, Structural `1.0.74+4cb3c938`

Adds, on top of the 16:01 set (none Tim-accepted; Codex pass 3 re-runs them first):

1. **SBEAM-DBID-01** (Structural `4cb3c938`, branch `claude/struc-sbeam-fingerprint`): SBEAM places a steel beam on 2027. Steps: SBEAM on a copy of a structural drawing, any section, Place, one point. The section, hatch and label appear. One Undo removes the whole beam. Escape at the point leaves nothing.
2. **MGR-RUN-01** (PR #109): CEMANAGER, then Drawing Repair, then Project QA. Both pages open and show their counts and status line; AutoCAD stays open.
3. **CDWT-MATCH-02** (PR #110): CDWT, Underground, pick 3000 L Round after choosing a plan for it once. That plan comes first and the other 3000 L plans follow it. Then type 2510 in "or type litres": the 2510 L underdeck plan is selected and the gold line says one plan matches.
4. **D-01** (PR #108): CDDEST on a copy of an older drawing with DP labels. It says how many DP labels and downpipe blocks it can see and points to CDTAG. Nothing changes.

Read back by hand: CE_SHARED identical in Civil and Manager in all three lanes. Pilot **candidate 3** is at `_RELEASE_V3_PILOT\candidate-3-civil-9df46d7b`, 0 files differing from the live set.

---

## LIVE since 23 Sep 2026 16:01 on Tim's PC — Civil `3.0.0+a2f56f43`, Manager `1.1.0+a2f56f43`, Structural `1.0.74+aad3fe02`

Everything in the BUILT list below is now **installed**, plus **BUG-166** (double-click a level label) and **STRUC-TEXT-ORDER-01** (SBEAM places steel beams on 2027; the 25R/25L text from the same builder). Read back by hand: CE_SHARED identical in Civil and Manager in all three lanes; the Civil 2027 natives are present; Structural has its native module and no CE_SHARED. Backups: `CE_CVL_SUITE_PRE_aeb03763_20260923-155243.backup`, `CE_SUITE_MANAGER_PRE_aeb03763_20260923-155243.backup`, `CE_STRUC_SUITE_PRE_60c41228_20260923-160046.backup`. Pilot candidate 2: `C:\Lisp Files\_RELEASE_V3_PILOT\candidate-2-civil-a2f56f43` (0 files differ from the live set). Codex pass 2 runs Z8 first (SBEAM first).

---

## BUILT 23 Sep 2026 — on `master`, NOT installed yet (goes in at the next install, after Codex's current run)

1. **BUG-165** (PR #92): Manager never treats the old `2026.0420` build number as newer than 3.0. Nothing to click; Manager's trace log stops showing *"staging CE_CVL_SUITE → 2026.0420.1549"*.
2. **BUG-162** (PR #93): test only.
3. **G-02 / G-04** (PR #94, `db5c8517`): CDDESIGN looks through every folder in the job for the rating report, and offers the council from the job folder's suburb. Steps: `REGRESSION_LOG.md` G-02/G-04 and Codex list Part G.
4. **RIBBON-01** (PR #95, `45bec4be`): CE tab, Review panel, **Rainfall Curve** runs CDRAINFALL.
5. ~~CD-ESC-01~~ **WITHDRAWN, do not test** (PR #100). CD keeps its 10 Sep rule: Escape at point 3 cancels the pipe.
7. **MGR-OPEN-01** (PR #99, `26285f0f`): `CEMANAGER` opens the Manager window. Drawing Repair and Project QA open, with grey buttons like the rest.
6. **C7-LOG-01** (PR #98, `e3b95b50`): nothing to click. After a drawing says pipes were left as drawn, the CE log lists each one with its reason.
8. **G-04b** (PR #101, `8e17ab6e`): CDDESIGN finds the council in a council letter or permit in the job when the folder's suburb does not settle it. AutoCAD 2027 only. Steps: Codex list Part G, G3, G5 and G6.
9. **R-02** (PR #102, `40a1e509`): on AutoCAD 2022-2024, the CE CVL toolbar's Rules and Rulebook buttons show the ribbon's pictures. Tim's VM check, Part M6b.
10. **PIT-BATCH-01 + PIPE-EDIT-WHY-01** (PR #103, `659b6540`): select two pits, Edit Pit, and the batch editor opens (B-P5 again). Edit Pipe on a pipe with doubled labels says why in plain words (B-L3 again).
11. **LPD-NOWRITE-01** (PR #105, `e7a0af71`): `CDLPD`, type `CouncilP`: the message, and nothing on the drawing. Escape at the connection question: nothing on the drawing.
12. **CRITERIA-ANCHOR-01** (PR #106, `2a22c381`): CDCALC, Insert Criteria Block, pick a clear point: the table's top-left corner is at the pick.
13. **BUG-166** (PR #107, `a2f56f43`): double-click a pipe's IL label: Edit Pipe opens on that pipe. Ordinary text still opens AutoCAD's editor.

---

## LIVE since 23 Sep 2026 12:18 — `3.0.0+aeb037639f628e64a98e1cde4d86d2df38c45fcc` (master, PRs #89 + #90)

Installed by the release chat under Tim's standing override (*"from now until tuesday we build, test and deploy whenever we need"*), AutoCAD checked closed at 12:12:29 and 12:12:40 (Tim: *"AutoCAD is closed"*) and again by the script before build and before install.

**Read back by hand from all three lanes:** Legacy `DF49FD6C…`, Net8 `13A4C69E…`, Modern `9572839E…`, each `3.0.0+aeb03763…`. CE_SHARED copied into Manager lane for lane and hash-verified (Legacy `98ECCF14…`, Net8 `C3A92910…`, Modern `B746E17A…`). Natives in Modern: `CE_CVL_NATIVE_GRIP_2027.arx`, `CE_TRANSFORM_2027.arx`, `CE_CVL_OBJECTS_2027.dbx`. Manager `1.1.0+96e7d76a` and Structural `1.0.74+5d723d41` unchanged.

**Undo:** close AutoCAD; delete `CE_CVL_SUITE.bundle` and rename `CE_CVL_SUITE_PRE_b02f3ec7_20260923-121346.backup` back to it; do the same for Manager with `CE_SUITE_MANAGER_PRE_CESHARED_20260923-121346.backup` (both in `%APPDATA%\Autodesk\ApplicationPlugins`).

**What it adds over `b02f3ec7`:** BUG-164 (AutoCAD no longer crashes on close) and REL-BUILD-01 (build-file only). **Test:** Codex list Part C; Tim's steps in `REGRESSION_LOG.md` BUG-164.

**Note:** the existing `Deploy-Local-AsAdmin.ps1` also sets SECURELOAD=1 in the user registry for AutoCAD 2025-2027, as on every earlier install.

**12:32 — the shipping Manager and Structural installed too** (release chat's call: test what ships, from the start). By the REL-09 hand steps: old bundle renamed to a `.backup` name, new bundle copied in.

1. **Manager `1.1.0+aeb03763`**, all three lanes, 72 files (its own verified release candidate). Replaces `1.1.0+96e7d76a` (7 Sep). Backup `CE_SUITE_MANAGER_PRE_96e7d76a_20260923-123202.backup`.
2. **Structural `1.0.74+60c41228`** (Tim's 1.0.74 plus Codex's four window fixes), AutoCAD 2027 only, **built by the 2027 trial route so it keeps `CE_STRUC_NATIVE_2027.arx`** (the three-lane route leaves it out). Replaces `1.0.74+5d723d41`. Backup `CE_STRUC_SUITE_PRE_5d723d41_20260923-123202.backup`.
3. **CE_SHARED 1.1.0.0, byte-identical in Civil and Manager in all three lanes**; Structural carries none. The ProgramData Manager copy has no live manifest.

**Tests:** Codex list Part R (versions), Part Z steps Z9-Z21 (Manager and Structural) now run in pass 1.

---

## LIVE since 23 Sep 2026 09:36 — `3.0.0+d90659cf` on `claude/civil-merge-2026-09-23`

Tim: **"AUTOCAD IS CLOSED, DEPLOY"** (23 Sep, 09:34). AutoCAD checked twice, eight seconds apart, before
anything was touched: not running either time.

**Read back from all three lane DLLs by hand, not from the script's own output:**

1. **Legacy** (net48, AutoCAD 2022–2024) — `3.0.0+d90659cf25cee1bac8e9e106deb4a006f4e9fe7d`
2. **Net8** (AutoCAD 2025–2026) — same
3. **Modern** (net10, AutoCAD 2027) — same

Native modules staged in Modern: `CE_CVL_NATIVE_GRIP_2027.arx` (82 KB), `CE_TRANSFORM_2027.arx` (74 KB),
`CE_CVL_OBJECTS_2027.dbx` (108 KB).

### Tim's one-action undo — the backups

The deploy script does **not** back up. Both were taken by hand first:

1. **Civil:** `CE_CVL_SUITE_PRE_d0ffe1a2_20260923-093445.backup` — 133 MB, 806 files
2. **Manager:** `CE_SUITE_MANAGER_PRE_CESHARED_20260923-093445.backup` — 75 files

Both sit beside the live bundles in `%APPDATA%\Autodesk\ApplicationPlugins\`.

### CE_SHARED brought into step

The deploy script does **not** sync it, and every CE plugin shares one assembly identity — the first copy
AutoCAD loads wins for all of them. All three Manager lanes differed from Civil's and were copied across,
each hash-verified after the copy.

**STRUCTURAL IS NOT REDEPLOYED.** Its bundle still carries whatever CE_SHARED it was built with.

### What this build carries, beyond the previous live `d0ffe1a2`

1. All four September Civil chats — tanks, pipe text, levels, `CDFIXTAGS`, splits, CDTWL, the detention
   zero, the Council keyword.
2. The eight overnight fixes of 19 Sep, and the audit that corrected them.
3. The trunk's documents and the DATA-01 privacy clean-up (PRs #79/#80/#81).
4. **CD-RECENT-01** — the "Recent:" strip trimmed.
5. **DEPLOY-01** — the release script's reference paths, and a preflight that checks eleven inputs.

### What is NOT in it, said plainly

1. **The CD window layout fixes** — pipe preview still scrolls away, invert boxes and labels unchanged.
   That window was rebuilt since the branch they came from, so they are a redesign, not a patch.
2. **The pit-on-pipe preview programme** — 35,700 product lines and 108,990 test lines, never opened in
   AutoCAD. Deliberately not taken.
3. **The CDWT crash (W4)** — cause still not established.

### Still open on this register

`build_installer.ps1` does **not** build `CE_TRANSFORM_2027.arx`. It was built by hand before this release,
as every release has needed. The new preflight checks the project exists, which is not the same as building
it. Unchanged gap.

---

## BUILT 23 Sep 2026 — **CDMOVETEST** (E-HOLD-01 probe), branch `claude/e-hold-01-move-test` @ `42766dd9`, PR #88 — NOT installed, NOT tested

**Install decision (release chat, 23 Sep):** PR #88 stays off `master` until the colleague package is cut
(Thursday 24 Sep, 5:30pm), so this test tool never reaches a colleague. It goes onto Tim's PC after Codex's
second pass on the colleague package finishes, so it does not change the build under test. Area:
`areas\release-v3-colleagues.md`, Holds.

**What it is:** a test command, not a feature. It answers two questions before the hold-grade / hold-levels
work is built: (1) can CE's preview window open by itself right after a MOVE, STRETCH or grip drag, and
(2) can Cancel take the move back in one step, and what does one U take back after Apply. Built and
unit-tested (33/33 on net10); both lanes compile. **Use a TEST drawing — the test uses Undo.**

**Who installs it:** the release chat only (Tim, 23 Sep 2026: *"CE_ACAD / release-v3-colleagues / plan / 01 this chat controls deployment"*). **Tim's PC only — a test tool, never in the colleague build.** Release chat: note here when it goes in.

**Steps (AutoCAD 2027):**
1. **Setup:** a test drawing with two CE pits joined by one CE pipe.
2. **Run A — MOVE a pit, Cancel.** Type `CDMOVETEST`, Enter. Then `MOVE`, pick one pit, move it about 2 m.
   **Right looks like:** a window opens by itself, headed "MOVE TEST - nothing in this window is written"
   (ignore "IL 0.00"). Click **Cancel**: the pit and its pipe end jump back, and the command line says
   `Result 2 ... YES`.
3. **Run B — drag a pipe-end grip, Apply, then U.** `CDMOVETEST`, Enter. Click the pipe, drag one end grip
   about 2 m. The window opens; click **Apply**. Type `U`, Enter, once. Read `Result 3`. If it asks, `U` once
   more and read `Result 4`.
4. **Run C — STRETCH, Cancel.** `CDMOVETEST`, Enter. `STRETCH` with a crossing window over one pit and its
   pipe end, move 2 m. Window opens; **Cancel**. Read `Result 2`.
5. **Send Claude every line starting `[CE move test]`** (F2 shows them). A NO is a useful answer, not a failure.

**Steps (AutoCAD 2024):** Run A only, then send the lines.

---

## BUILT overnight 18→19 Sep — `claude/civil-overnight-2026-09-19` @ `07325a2b` — NOT INSTALLED, NOT TESTED

**Eight items, on top of the frozen combined payload `0a84eb07`.** Tim: *"overnight sequence for all fixes,
improvements and completion of all tasks from all 4 chats"*, then **"Go — all 8 items"** and **"No — just
build"**.

**`claude/civil-combine-2026-09-18` @ `0a84eb07` is UNMOVED and still deployable on its own** if any of the
overnight work proves wrong.

| ID | What Tim would see | Lane |
|---|---|---|
| **V1** | **Settings page: the standard LPD note now reads the full sentence**, not `LPD - {connection}, IL {invert} m AHD`. That stale setting is why every note came out short no matter what the code said | both |
| **V2** | `CDLPD` → type `Council` → the note reads **CONNECT TO COUNCIL PIPE AT APPROX IL…m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM…** — a sentence, not one short line | both |
| **V3** | **Type your OWN wording** into the Settings note box, save, close AutoCAD, reopen. **Your wording is still there.** CE must never overwrite it | both |
| **V4** | **Lock the layer the IL texts sit on**, run the invert propagation. It **names the pipes it could not update**, and `PITSCHEDULE` must **NOT** show the new levels for them — schedule and drawing must agree | both |
| **V5** | Unlock, run again: drawing and schedule move together. A pipe with **no** IL text still updates normally | both |
| **V6** | Make a write fail outright (lock the pipe's own layer): the refusal **names the pipe** it stopped on | 2027 |
| **V7** | Draft an orifice standard detail. **It must look exactly as always, with no new message.** If a message ever appears saying CE used the closest orifice detail it could find, tell me — the master was resaved | 2027 |
| **V8** | Convert a job's pipes (`CDC7UPGRADE`), set a converted pipe's level to **17.35**, Save. `PITSCHEDULE` shows **17.35**, **not a blank cell**. Reopen the drawing: still 17.35 | 2027 |
| **V9** | Same on an **ordinary** pipe: nothing about it has changed | 2027 |
| **V10** | **MOVE** a pipe that has `FALL` / `LEVEL` tags. The tag box **and its text** travel together. Then **grip** one. Then try a **turned** (diagonal) pipe | both |
| **V11** | Open Edit Pipe, change something, **Cancel**. The tag text goes back with its box, not left where the edit put it | 2027 |
| **V12** | **Then say whether O3 / O4 / O10 / O17 still happen.** If they do, this was not their cause and I will say so | 2027 |
| **V13** | Three pits in a line, `CD` one pipe through all three, **Yes** to the split. **BOTH lengths carry their own pipe text**, each mid-way along its own length, same side as before | both |
| **V14** | Same the other way: draw the pipe, then **drop a pit onto it**. Same result — that is the route Tim asked about, and it shares this code | both |
| **V15** | A **bent** pipe (3+ points), split it: the copied text sits **on** the pipe, not out in space | 2027 |
| **V16** | A pipe drawn with **simple pipe only** (no text): split it. **Neither half gains a text** | 2027 |
| **V17** | **One Undo** after a split removes the whole thing, copied text included | 2027 |
| **V18** | Check a copied text reads the right size and material. **If a half shows the wrong GRADE, say so** — that is the known limit of copying rather than re-rendering | 2027 |

### Ghost preview — NOTHING to test yet

`GHOST-01` built the **rule** only (Tim's ruling A, 18 Sep). **The picture panel is Codex's under ruling B and
is NOT built**, so Tim will see no change in AutoCAD. Contract:
`04_REFERENCE/contracts/CONTRACT_GHOST_PREVIEW_2026-09-18.md`.

---

## COMBINED 18 September 2026 — `claude/civil-combine-2026-09-18` @ `0a84eb07` — BUILT, NOT INSTALLED, NOT TESTED

**All FOUR Civil branches merged into one payload by the COMBINE chat. Nothing here is in AutoCAD.**
Morning pack: `archive/chat-records-2026-09/MORNING_PACK_COMBINE_2026-09-19.md`. Codex test list (76 steps):
`archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-18.md`.
Installed is still `3.0.0+d0ffe1a2`, read back from the DLL.

| Input | Tip merged | Note |
|---|---|---|
| windows / deploy `claude/civil-combined-2026-09-17` | `c9dac1bc` | base of the merge |
| other Civil areas `claude/civil-other-areas-handoff-d747af` | `24d9230f` | **forked beside the installed build at `e0cfe172`** — had to be merged, never built alone |
| K / L `claude/civil-k-l-2026-09-16` | **`dc937001`** | **NOT the handed-over `457bf032`** — that tip had already moved; `dc937001` adds the K4 Council-keyword fix Tim asked for on 18 Sep |
| fixes `claude/civil-fixes-2026-09-18` | **`c0ef58a6`** | merged 18 Sep after Tim said that chat had finished; its claims were verified from the diff, not from a handover (it never wrote a Section 4) |

**Proof held (§6 of the combine brief):**

- `git merge-base --is-ancestor` — `c9dac1bc`, `24d9230f`, `dc937001` **and the installed `d0ffe1a2`** are all
  ancestors of `ed5c7077`.
- Builds: **net48, net8.0-windows, net10.0-windows — 0 errors** each.
- Full net10 suite (final, all four merged): **10,052 run · 10,013 passed · 22 failed · 17 skipped.** Failing
  **names** set-compared against the 20 recorded distinct names: **identical — no new failures, none silently
  fixed.** All eight of the fixes chat's new guard tests ran and passed.
- `PreviewPackage_AllSections_RetainsStatusAndUsesAdvisoryWsudAuthority` — reported as a 23rd failure by BOTH
  the other-areas and K/L chats, both predicting it would clear once merged with BUG-158 (`308ea803`).
  **Confirmed by evidence: it RAN and PASSED on the combined line.** Prediction upheld.
- `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully` (the known flaky one)
  also **ran and passed**.

**Conflict resolution, stated so nobody has to re-derive it:**

- `Modules/Drainage/Commands/PipeEditCommand.cs` **auto-merged with no conflict** — the two chats edited
  different regions. Verified by hand, not trusted: the `vm.DryRunPreview =` assignment is **gone** from both
  `PipeEditCommand.cs` and `PitEditCommand.cs`; the separate `IsDryRunPreview` flag **survives**; the
  other-areas chat's `LevelBoxesAreAuthoritative` is **present**. Both behaviours kept.
- `REGRESSION_LOG.md` and `FLEET_STATUS.md` conflicted only because all three chats prepend entries to a shared
  tail. **Both sides kept in full**, newest first. No entry from any chat was dropped.

**Build gap worth recording (issue #78):** a fresh worktree fails the net10 lane with `MSB3030` until
`Modules/Shared.Transform.Native2027/CE_TRANSFORM_TRIAL_2027.vcxproj` is built with
`/p:ProductionIntegration=true`. It must be run through **PowerShell** — Git Bash rewrites the `/t:` and `/p:`
switches into paths and MSBuild fails with `MSB1008`.

**What Tim must test if this is installed:** the **76-step Codex list** at
`archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-18.md` (Tim, 18 Sep: *"all 40 for codex so make sure it knows what to
do"*). Parts S (start-up) · N (CDWT, 11) · P (pit number, 7) · O (pipe text, levels, CDFIXTAGS, splits, 25) ·
T (CDTWL, detention, PSD, CDLPD, 21) · X (2024 lane) · Z (regression sweep).

⚠️ **The CDWT crash (W4) is NOT fixed** — the fixes chat states its cause is not established and no fix was
attempted. Step **N9** is a probe, and a crash there is expected, not a regression.

---

## TESTED 16 September 2026 — MOSTLY FAILED. Read `decisions/2026-09-16_TEST_DAY_RESULTS.md` FIRST

`c1af9781` is live and Tim has tested it. **The deploy worked; most of what it carried does not.** Do not use
the 77-step list as a to-do — use the failure register in
**`decisions/2026-09-16_TEST_DAY_RESULTS.md`**, which is the authoritative record of what he found.

**Tim's instruction, 16 Sep:** ONE AREA AT A TIME. Priorities **`CDWT`, `CD`, `PIT`**, then test sections
**H, I, J, K, L**, then **M**. He has withdrawn trust in large batches.

### Original deploy note (kept for the record)

**Live bundle is `c1af9781`.** Deployed after Tim said "AutoCAD is closed, deploy". All three lane SHA256s
matched the staged payload and the lineage check printed nothing. **Nothing below has been tested in AutoCAD
by anyone** — that is the whole point of the list.

Use `archive/chat-records-2026-09/DEPLOY_AND_TEST_2026-09-16.md` section 3: **77 steps, A to O**, covering the whole
69-commit payload. Restart AutoCAD first.

### BUILT 18 Sep — **P12 / P14 / BUG-151 pit label**, branch `claude/civil-fixes-2026-09-18` @ `29d0598d` — NOT installed, NOT tested

Fixes register **P12** and **P14**, and almost certainly the long-running **BUG-151 / P-08** *"the label
won't step out"*. Builds net48 / net8 / net10 **0 errors**; full net10 suite **9,929 run · 9,890 passed ·
22 failed · 17 skipped — the same 22 names as the recorded baseline, compared by name. No regressions.**
Full entry: plugin `REGRESSION_LOG.md` **P12 / P14 / BUG-151**.

**What it actually was:** the pit label is a block holding the **circle**, with the **number** stored as an
attribute that has its own position. CE moved the block and never moved the number. The label *did* step
out — the circle went, the number stayed.

| # | What | Steps | Lane |
|---|---|---|---|
| P12 | **Resize: number goes with the circle** | Open DWG-B. `CDEDIT` on **P10**, change **450 × 450 → 1200 × 1200**, Save. The circle **and** the number move together; the number stays centred in the circle. | 2027 **and 2024** |
| P14 | **Corner change: same, with no resize** | `CDEDIT` **P10**, change only the **label corner Top right → Bottom right**, Save. The number goes with the circle. | 2027 **and 2024** |
| P12b | **The other label block** | Same test on **P1** or **C1** (they use `PIT LABEL`, not `PIT LABEL 2`). | 2027 |
| P12c | **Two pits at once** | Resize two pits in one go. **Both** numbers travelled. | 2027 |
| P12d | **One change = one Undo** | After an accepted resize, one `U` puts it back. | 2027 |

**NEW, NOT FIXED — worth knowing:** a second probe on the same drawing found **240 of 387** other blocks
also carry their text as attributes — the **FALL / grade** label, the **LEVEL** texts, **DP** and **WT**
tags. Two pipe paths move those blocks the same way the pit label was moved. That is a **strong candidate**
for register items **O3 / O4 / O10 / O17** ("MOVE and grip break label alignment") — but it is a hypothesis,
nobody has reproduced those items against it, and it needs a full rotate-and-move rather than the simple
fix used here. **Not touched.**

### BUILT 18 Sep — **W-09 / W-10 CDWT tank plans**, branch `claude/civil-fixes-2026-09-18` @ `d95e7342` — NOT installed, NOT tested

Fixes register **W2** (blank tile pictures, short list) and the **no-ghost** half of **W4**. Cut from
`claude/civil-combined-2026-09-17` @ `c9dac1bc`. Builds net48 / net8 / net10 **0 errors**; 149 WaterTank
tests pass. Full entry: plugin `REGRESSION_LOG.md` **W-09 / W-10**.

Measured against Tim's own `CE Civil WATER TANKS PLAN.dxf`: **39 plans read · 29 offered before · 39 now ·
39 with a picture · 39 with a real size · 0 using the caption as a block name.**

| # | What | Steps | Lane |
|---|---|---|---|
| W-09a | **Every tile has a picture** | `CDWT`. No tile is blank. | 2027 |
| W-09b | **Nothing is missing from the list** | `CDWT`. Count the tiles: **39**, not 29. Look for **GRAF CARAT**, **AQUARIUS**, **WT1** and **PLAN VIEW** — all four were being dropped. | 2027 |
| W-10 | **Three PLAN VIEW tanks — Tim's eye needed** | Three tiles read "PLAN VIEW  (7560 x 4800 mm)", "… 2" and "… 3". They are three different plans in your master. **Say if you want them named properly** — that means moving titles in the master, not changing CE. | 2027 |
| W-09c | **The ghost comes back** | Pick **2510L UNDERDECK WATER TANK**, set a detention share, **Place tank**, pick an insertion point. **A ghost of the real tank follows the cursor.** That is the exact tile that failed on 16 Sep. | 2027 |
| W-09d | **The right block lands** | Finish the placement. The block on the drawing is the one in the picture. | 2027 |
| **W4-PROBE** | **The crash — NOT fixed, this is a 30-second probe** | Place a tank, and press **Enter** at the callout prompt instead of picking a point. **Does it still crash?** If it completes, the callout pick is the suspect; if it crashes anyway, it is elsewhere. Either answer tells me where to look. | 2027 |

**Not claimed fixed:** the `AutoCAD cannot continue` crash in W4. It is an unmanaged fault — CE's own error
handling cannot see it and there is no CE log line for it — so its cause is **not established** and no fix
has been attempted. The probe above is how we settle it.

### BUILT overnight 17 Sep - branch `claude/civil-combined-2026-09-17` @ `28464fbd` - NOT installed

Windows chat. Three CDWT faults found by opening the real master and the rendered window. Full detail in the
plugin `REGRESSION_LOG.md` (**W-06**, **W-07**, **W-08**) and
`archive/chat-records-2026-09/MORNING_PACK_WINDOWS_2026-09-18.md`. Builds 0 errors on all three lanes; full net10 suite
**9,918 run · 9,879 passed · 22 failed · 17 skipped** - the same 22 names as the baseline, compared by name.

| # | What | Steps | Lane |
|---|---|---|---|
| N1 | **Tank tile names are right (W-06)** | `CDWT`: no two tiles carry the same tank name at different sizes; exactly **one** "KINGSPAN 6000 L SLIMLINE METAL TANK"; no tile starts with a code like `xsm1;` | 2027 |
| N2 | **Untitled tiles are honest (W-06)** | Two tiles read **"Untitled tank plan"** with a size and a picture - those plans have no title in the master. **Tim: say if you want them named** | 2027 |
| N3 | **The MELRO pair - Tim's eye needed (W-06)** | 4500 and 5500 MELRO now attach to different blocks (4500 -> 5600x1760, 5500 -> 4622x1760). Check against the master; if wrong, the master's titles need moving, not CE | 2027 |
| N4 | **Empty Standard Details folder (W-08)** | Settings -> point the folder at an empty one -> `CDWT`: reads "No tank plans found", names the drawing, offers both ways out. **No empty black panel.** "Tag a block already in the drawing" still asks for the block. Put the folder back: tiles return | 2027 |
| N5 | **Nothing else about CDWT moved** | Place a tank normally: tank, detention share, plan, Place tank, insertion point, callout/riser/dropper, Base RL - as before | 2027 |
| N6 | **The tank detail warning (W-07)** | Nothing to do in normal use. If the master is ever resaved, `CDWT` prints *"The usual water tank detail was not in ... CE used the biggest tank detail it could find instead"* rather than quietly drafting a different detail | 2027 |

**Not fixed, contract written:** double-clicking a pipe **label** opens the OLD editor, not the one-page
window (needs 823 px against an 820 cap - three pixels). `CdDialog.xaml` is Codex's file under ruling B, so
the measurement and the contract are in the plugin at
`docs/workflows/CD_LABEL_TAB_FIT_CONTRACT_2026-09-17.md`. Building it clears **five** of the 22 red tests.

### SUPERSEDED 20 minutes later by `d0ffe1a2` — see below. `081c82b6` was live 22:31–22:57 only.

### LIVE since 16 Sep 22:57 — `d0ffe1a2` on `claude/civil-combined-2026-09-17`

`081c82b6` **did not contain two commits Tim had already been answered on.** The K/L branch had moved to
`26432227` after the tip that was handed over, carrying `L-01b/L-02b` (**both** Council Pit wordings offered,
note moved to `25TEXT`) and `L-02c`. Those are now in, plus **F1-06** (Tim, 17 Sep: the rainfall warning
appears *"once"*).

All three lanes read `3.0.0+d0ffe1a281808c1837375785351581610dcc9c51`. Manager's `CE_SHARED` re-synced.
Backup is still `CE_CVL_SUITE_PRE_6505fb5a_20260916_222407.backup`.

Builds: net48 / net8 / net10 **0 errors**. Full net10 suite: **9,904 run · 9,864 passed · 23 failed ·
17 skipped**. The 23rd is `MarkupFileImageLoaderTests.LoadAsync_ValidSinglePagePdf_RendersOnePageSuccessfully`
— *"The PDF renderer produced only blank page(s)"*. **It passes 15/15 when its fixture is run on its own**,
and this payload changes no PDF or markup code. Recorded as **flaky under full-suite load, not a regression**
— not as "pre-existing", because it did not fail in the 22:31 run of the same suite.

**Tim's four answers of 17 Sep:**

| | Tim | State |
|---|---|---|
| `COUNCIL PIT` vs `EXISTING COUNCIL PIT` | *"both are necessary"* (and *"both are options"*, 16 Sep) | **Both offered** — `CouncilPit` and `ExistingCouncilPit`, in `d0ffe1a2` |
| Sump tick wording | *"yes"* | Already built (PIT-TWEAKS-01) — no change |
| Two tanks on one system | *"i have confirmed two tanks on one detention system"* | Already built (item 66) — no change |
| Rainfall warning twice | *"once"* | **Built in `d0ffe1a2`** (F1-06) |

**Still open and NOT decided:** the note's wrap width — Tim asked to *"show me the different variations"*,
five widths were drawn for him on 17 Sep and **he has not picked one**.

**Installed, NOT tested.** The ONE list: `archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-17.md`; drawings named in
`C:\Users\TimothyBrand\CE_TEST_DRAWINGS_2026-09-17.md` (outside every repo, DATA-01).

### LIVE since 16 Sep 22:31 — `081c82b6` on `claude/civil-combined-2026-09-17` (ALL THREE overnight chats, one payload)

Tim: *"AUTOCAD IS CLOSED, DEPLOY"*. Merge of `claude/ce-civil-handoff-sept-16-5623ca` @ `17847985` (windows),
`claude/civil-other-areas-2026-09-16-1c1ae6` @ `e0cfe172` (C7 / labels) and `claude/civil-k-l-2026-09-16` @
`0ed39495` (K/L). All three lanes read `3.0.0+081c82b6315c43213f1a699c3d1421fd8c795790`.
Backup: `CE_CVL_SUITE_PRE_6505fb5a_20260916_222407.backup`. Manager's `CE_SHARED` brought into step
(backup `CE_SUITE_MANAGER_PRE_CESHARED_20260916_223259.backup`); **Structural is NOT redeployed**, so the
Structural half of PERF-003 is not live.

Builds: net48 / net8 / net10 **0 errors**. Full net10 suite: **9,899 run · 9,860 passed · 22 failed ·
17 skipped** — the 22 known names, all in test files this payload never touched (list below).

**Installed, NOT tested.** The ONE list for this build is
**`archive/chat-records-2026-09/CODEX_TEST_RUN_2026-09-17.md`** — 90 steps in parts S/W/C/P/O/K/L/F/R/M, being run by
Codex driving AutoCAD. It supersedes rows L8–L18, O1–O15 and K1–L11 below as the thing to work from;
those rows stay for the record.

<details><summary>The 22 known failures, by name (recorded 17 Sep — this baseline did not exist before)</summary>

AddSystemCommand_Execute_AddsAnotherSystem · AddSystemCommand_Execute_NameIsSystem2 ·
AddSystemCommand_Execute_SelectsNewSystem · BackTest_GlenEira24115_Computed_WithinTolerance ·
BoydsDetentionRequired_Changed_PropagatesBoydsSuggestedVolumeToAllSystems ·
CdEnterAfterTwoPickedPoints_FinishesTheRouteInsteadOfCancellingIt ·
CompiledDefaultSourceCallersNeverOptIntoPitPlanPlacement ·
Copy_GivesTheCloneItsOwnIdentityDuringReconciliation ·
EveryTabFitsOrUsesExplicitFallbackAtOfficeScaling (×3 cases) ·
ExistingEngineeringAndInteractionRulesRemainInTheProductionCommands ·
FinalLandingProducerCollapsesOnlyItsOwnFreeEndRunBeforeSplitPreflightAndFinalDecision ·
GetPanels_KeepsEveryVisibleCivilCommandReachable ·
IMP014_OnDocumentToBeDestroyed_GatesUnhookOnIsDatabaseAlive ·
InternalCivilCommands_RebuildOnlyAfterAnAcceptedPipeChange ·
NativeQueue_StoresIdentityContractAndRechecksItBeforePreviewAndWrite ·
PendingValuesKeepThePriorDisplayEnvelopeAndEveryComparisonFits ·
RefusedNativeCallbackInvalidatesTheManagedSessionBeforeReportingChannelFailure ·
Registration_ProjectsOnlyAfterCanonicalPipeAndOwnerRecordsAreWritten ·
SelectedLabelStillFitsThePrevious1080p125PercentEnvelope ·
SpineReader_WiresListedVisibleReciprocalMTextIntoTheBoundedResolver

</details>

### LIVE since 16 Sep 16:06 — `6505fb5a` on `claude/ce-civil-handoff-sept-16-5623ca` (LAYOUT-01 · PIT-PREVIEW-01/02 · CD-PREVIEW-01 · BUG-159 CDGRIPDIAG)

Tim: *"AUTOCAD IS CLOSED, DEPLOY"*. All three lanes read `3.0.0+6505fb5a`. Backup: `CE_CVL_SUITE_PRE_0737efa3_20260916_160353.backup`.
**Installed, NOT tested.** Rows L1–L7 below are the list, plus the BUG-159 rectangle test in the plugin repo `docs/workflows/BUG159_DEPLOY_HANDOVER.md`.

Full entries: plugin `REGRESSION_LOG.md` LAYOUT-01, PIT-PREVIEW-01, PIT-PREVIEW-02, CD-PREVIEW-01.

| # | What | Steps | Lane |
|---|---|---|---|
| L1 | **CD window uses the whole window** | Double-click a stormwater pipe. Engineering left, Drafting right, PLAN PREVIEW reaching from just under the fields to just above the buttons. No empty black band. All five buttons visible, no scrolling. | 2027 |
| L2 | **Nothing pushed off on the busy cases** | Same on a detention pipe with twin pipes on, and on a pipe with a linked IL label. Type a value → More… → Back: value still there. | 2027 |
| L3 | **PIT centre preview is the wide column** | Double-click a pit. Centre PLAN PREVIEW clearly wider than either side column. Both "Bottom right" position lists on the right fully readable, not cut off. | 2027 (and 150% scaling if you can) |
| L4 | **Fit guard** | If the command line prints "The tabbed editor does not fit this AutoCAD work area", report which window and your monitor/scaling. | 2027 |
| L5 | **PIT preview shows every connected pipe (PIT-PREVIEW-01, `d5f41362`+)** | Double-click a pit with 2+ pipes: each pipe is a grey stub on the wall it enters, square to the wall, with "size · Entering/Leaving · IL" at its end. Pick another pipe in the list: its stub goes gold. A pipe with no IL reads "IL Unknown". A pipe CE cannot place is listed top-left as "Not placed: … – reason" with no stub. Change the pit size: stubs stay on the walls. | 2027 only |
| L6 | **PIT preview is the real plan around the pit (PIT-PREVIEW-02)** | Double-click a pit on a real drawing: the centre picture is the actual plan, north up, pit centred, ~3 pit-widths across, sharp. Tags (no stub lines) at each placed pipe's wall point with "size · Entering/Leaving · IL"; picked pipe goes gold. Change pit size: redraws. Opening must not feel slower; say by how much if it does. Try a drawing with an xref underneath and report whether it shows. A NEW unplaced pit shows the block + stubs instead. | 2027 only |
| L7 | **CD preview is the real plan along the pipe (CD-PREVIEW-01)** | Double-click a pipe between two pits: the PLAN PREVIEW band is the actual plan along it, north up, both pits in view, sharp. Gold ring + caption "pit · IL" at each end; type a new invert and the caption changes at once. A pipe ending at an IO/DP/LPD shows the real symbol. A 3+ vertex pipe shows the whole run. A NEW pipe still shows the old schematic. Opening must not feel slower. NOT yet shown: where pipe text / invert text / arrow will land (next item). | 2027 only |
| L8 | **PIT-CONN-01 - pit lists its pipes again** (built, NOT installed) | Edit Pit P10 on the same drawing: Connected pipes shows the P10→P9 pipe with size and IL, and its tag sits on the picture at the wall. Edit Pit P9: same pipe, Entering. A pit with no pipes still says so. | 2027 |
| L9 | **CD-PREVIEW-01a - New Pipe shows the real plan** (built, NOT installed) | CD, pick the route: the window opens with the plan along the picked points and End 1 / End 2 captions. | 2027 |
| L10 | **POLISH-01 - CD/PIT windows tidied** (built, NOT installed) | Edit Pipe: level row on one line ("Set Upstream 19.45 m AHD"), header chip one line, plain wording under the levels. Edit Pit: label row + one status line under it, two readout lines under the picture, no duplicate "no pipes". Say what still looks wrong. | 2027 |
| L11 | **PIT-TYPE-01 - stormwater pipe no longer called CHARGED in the pit list** (built, NOT installed) | Edit Pit P10: list reads "P10 → P9 · Entering/Leaving · IL 19.450" and the pit IL suggestion strip appears. Save the pipe unchanged, reopen the pit: still not charged. A real Charged pipe still reads CHARGED. | 2027 |
| L12 | **CLICK-01 - click the picture to select** (built, NOT installed) | Edit Pit with 2+ pipes: click a pipe tag on the picture, the list changes and the tag goes gold. Edit Pipe: click the downstream ring, the cursor lands in the downstream level box with its value selected. | 2027 |
| L13 | **DRAG-01 - drag the corner badge** (built, NOT installed) | Edit Pit: drag the gold badge to the top-left of the picture and release: badge sits top-left, the Pit label corner list reads Top left, cover-text list unchanged. Pick "Cover text" in the footer list, drag to top-right: only the cover-text corner changes. Cancel: nothing moved on the drawing. | 2027 |
| L14 | **DRYRUN-01 - the picture shows what Save would do** (built, NOT installed) | Edit Pit: 450→1200, wait 1 s: bigger pit + stepped-out label in the picture; change label corner: label moves. **Cancel, then `U` once: only your previous real edit undoes - anything else, stop and report.** Edit Pipe: change diameter + text side, wait: text reads the new size on the new side, arrow where Save puts it; type a new IL: it changes. Type fast: no per-keystroke flicker. Blank the pit size: falls back to the plan as-is, no error. | 2027 |
| L15 | **PIT-TWEAKS-01 - tick, size drop-down, sump tick** (built, NOT installed) | Edit Pit: Plan size is a drop-down of your ladder (450/600/900/1200/1500); pick 900 → picture redraws; type 700 → accepted. Bottom row tick reads "Sump pit · own bottom IL": unticked = grey box; ticked = box opens. Save, reopen: kept. **Confirm "Sump pit" is what you meant.** | 2027 |
| L16 | **CDWT-W01 - tank window first, and it opens** (built, NOT installed) | `CDWT`: the window appears IMMEDIATELY (no "Adopt or Insert" at the command line first). Above ground ticked; list smallest first with dimensions; tick Underground → list changes. Pick tank, detention, plan → Place tank → insertion point with ghost → callout/riser/dropper → Base RL. "Tag a block already in the drawing" closes the window and asks for the block. Cancel: nothing placed. If the command line asks Adopt/Insert first, paste the [CE] line. | 2027 |
| L17 | **BUG-158 / F1 - the computations sheet is a CE sheet** (built, NOT installed) | `CDCALC` → Export PDF → print to PDF → **open the PDF**. Page 1 = CE letterhead sheet: logo top-left, CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS top-right, job strip, then BASIS OF DESIGN → ON SITE DETENTION → STORAGE PROVIDED → VOLUME tables → ORIFICE → WHERE THESE FIGURES CAME FROM. No "Note:", no blank cover, no repeated detention page. Export XLSX: "Computations" tab reads the same. | 2027 |
| L18 | **CD-TICKS-01 - level Set buttons are ticks** (built, NOT installed) | Edit Pipe: level row reads "☐ Upstream 19.45 m AHD"; untick → box greys; tick → opens. Save, reopen: as left. | 2027 |

### Branch `claude/ce-civil-handoff-75-percent-671a19` — IFD-01 · D2 · F1/F2 · BUG-156 (built overnight 15–16 Sep 2026)

Owner: the Civil behaviour chat. **Use `archive/chat-records-2026-09/DEPLOY_AND_TEST_2026-09-16.md` section 3 — it is the
ONE consolidated list for the whole 69-commit payload, including everything in the folded-in table above.
The rows below are a summary of this chat's own part only.**

| # | What | Steps | Lane |
|---|---|---|---|
| R1 | **`CDRAINFALL` — a job carries its own rainfall** | New command. Run it on a job with no curve: it must SAY it is using the office Melbourne curve and warn that it reads 7–9% high. Load `SAMPLE_2_lighter_place.txt`, answer No (nothing changes), then Yes. Reopen the drawing — the curve is still there. | Both |
| R2 | **A bad block is refused, nothing stored** | `SAMPLE_4_BROKEN_only_three_rows.txt` → "needs 7 rows… 3 rows found. Nothing has been stored." `SAMPLE_5_BROKEN_wrong_order.txt` → refused for being out of order. The previously stored curve must be untouched. | Both |
| R3 | **The rainfall actually changes the design** | `CDDESIGN` with no curve, note the storage required. Set the 18%-lighter curve, run again — **storage required must go DOWN**. Set the same-as-office curve — it must return to the original figure. | 2027 |
| R4 | **CDCALC produces the computations sheet** | `CDCALC` → Export PDF / XLSX. The export now LEADS with a CREATIVE ENGINEERING / DRAINAGE COMPUTATIONS sheet (XLSX tab "Computations"): header, basis of design naming the rainfall curve, PSD and storage required with the council in brackets, the storage split, VOLUME OF PIPE and VOLUME OF PIT tables, an ORIFICE block, and WHERE THESE FIGURES CAME FROM. | 2027 |
| R5 | **The sheet warns, never blocks** | Leave the council unset and export: the sheet still comes out, PSD reads **"not known"** and never `0`, and the last block names it as not established. Make the storage short on purpose — it must say **by how much**. | 2027 |
| R6 | **Plate height says "not known"** | On the ORIFICE block, plate height is deliberately "not known" — CDCALC holds the head, not the plate height, and CE will not work one backwards. Confirm the head, diameter, Co and flow are all present. | 2027 |
| R7 | **BUG-156 — a redesign stops forgetting** | Record a downpipe destination (`CDDEST`), answer the split question, set a rainfall curve. Run a network redesign and apply it. All three must survive. Before this fix all three were lost. | 2027 |
| R8 | **Nothing that already worked has moved** | A job you know well with NO rainfall curve set must produce **exactly the same** detention numbers as before. Any movement at all is a fault. | Both |
| R9 | **The 2024 lane** | R1 and R8 on AutoCAD 2024 — 2022–2024 users are in scope. | **2024** |


### FOLDED IN — `claude/c7-one-object` @ `9058a405` is inside the batch below

> **Do not test from this table.** Every row of it is now part of
> `archive/chat-records-2026-09/DEPLOY_AND_TEST_2026-09-16.md` section 3, which is ONE list covering the whole payload
> (Tim's ruling, 14 Sep). `9058a405` is an ancestor of `d6aa4dbf`, so deploying that batch installs all of
> this too. The rows are kept below only so nothing is lost; the steps in the deploy document are the
> current ones.
>
> **Row 14's hold is lifted.** `CDTWL` was held because it asserted a top water level instead of offering
> candidates. It now offers them (commit `a5dce440`), so it is testable — see section E of the deploy
> document.

#### Original rows, superseded by that document

Owner: the Civil behaviour chat. **Requires the API-v3 enabler to be rebuilt and shipped with it.**

| # | What | Steps | Lane |
|---|---|---|---|
| 1 | **BUG-154 — CDFW/CDSOURCE place again** | In the job that failed: `CDFW` at a free point, then on a pipe run, then on a free pipe end. Each must place. | Both |
| 2 | **The repeated-name offer** | After each placement the command line names the repeated source name, says **nothing was stopped by it**, and offers `CDFIXTAGS`. | Both |
| 3 | **`CDFIXTAGS`** | It lists the repeated names and their blocks, proposes renames, changes nothing on **No**. Run again, answer **Yes**, check the renamed blocks show their new labels. | Both |
| 4 | **Split on draw** | Three pits in a line; draw ONE pipe through all three. It asks once — answer Yes. You get four pipes, four schedule rows, and the middle pits have a pipe in and out. | Both |
| 5 | Split on draw — memory | Draw another across pits: **it must not ask again**. In a NEW drawing answer **No** first time; it stays one pipe and does not ask again. | Both |
| 6 | Split on draw — edge cases | A pipe that starts and ends on pits but crosses nothing: says nothing, splits nothing. **Escape** at the question: nothing split, pipe intact. | Both |
| 7 | **Converted pipe split (C7 3d)** | `CDC7UPGRADE` a pipe, then `CDFW` on it. Both halves must be CE pipe objects. **Move the top half aside and check there is no stray pipe underneath** — that is the whole point. | 2027 |
| 8 | Converted split — annotations | Labels and invert texts end on the correct halves; the new invert appears both sides of the floor waste. A **twin barrel** still draws as twins after the split. | 2027 |
| 9 | Ordinary pipe unchanged | Do the same on an unconverted pipe and confirm nothing about it changed. | Both |
| 10 | **Pit label on resize** | PITEDIT a 450 pit to 1200. The label circle steps out and **keeps its distance from the pit**, like the cover text. Check the CE log line `ShiftAnnotation [pit label]`. | Both |
| 11 | **`CDDESIGN`** | Asks only for what is missing; makes you confirm the legal point of discharge; refuses a roof area larger than the site **without shrinking your number**; finishes saying nothing was drawn. **Confirm the drawing is untouched.** | Both |
| 12 | **LPD note** | `CDLPD`, pick the street pipe end. The list now offers **CouncilStub, ExistingStub, Easement** as well as Kerb/CouncilPipe/SideEntry. Choose CouncilStub — the callout must read `CONNECT TO COUNCIL STUB AT APPROX IL<level>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM ALL LEVELS PRIOR TO THE COMMENCEMENT OF WORK.` with the level to **two decimals**. | Both |
| 13 | LPD — unknown level | Run it on a pipe end whose invert is **not set**. The note still appears and simply leaves the level clause out — no `IL m`, no zero. | Both |
| 14 | **`CDTWL`** | ⚠️ **Hold** — the TWL rule was reopened 15 Sep (a trench grate can sit above the highest pipe obvert). Do not test until the command offers the candidates rather than asserting one. | — |

### Codex window candidates — not installed

| # | What | Status |
|---|---|---|
| 15 | PIT input pages / no-scroll | **Measured failure open**: detention at 900 × 600 overflows by ~5.4 layout units. Not committed, not deployed. |
| 16 | UI connection recovery (`af0cd66a`) | 19 of 25 wanted corrections recovered. **Not a Structural replacement** — it deletes the installed SBEAM runners. |
| 17 | Structural preservation (`60c41228`) | Built and checked, **not installed**. Preserves SBEAM commands. |

---

## ALREADY LIVE AND STILL UNTESTED — `10ac480d`, installed 15 Sep 14:46

| # | What | Steps | Lane |
|---|---|---|---|
| 18 | PIT block preview, taller pane (`63bc7207`) | Open PIT. **Check nothing scrolls** and everything is visible on open. Tim has reported a scrollbar is present — Codex owns this. | 2027 |
| 19 | PIT preview in 2024 | Old schematic/text remains usable; no renderer error. | **2024 — never tested** |

---

## ACCEPTED — keep the record, do not re-test without a reason

| What | Build tested | Date |
|---|---|---|
| CDPARTS Save and Reset to Defaults (BUG-152/153) | `10ac480d` | 15 Sep 2026 — recorded on #78 |
| PIT block preview, original rendering — **7 of 8 checks** | `6a6d6bc7` | 15 Sep 2026 — #75. The 2024 check stays open |
| C0 managed Slide/Offset/Flip grips and twin/MLINE selection, bounded Test Day 2 | `9050f497` | recorded on #26 |

### BUILT 16→17 Sep overnight — branch `claude/civil-other-areas-2026-09-16-1c1ae6` @ `3bc94c78` (other Civil areas chat) — NOT installed, NOT tested

Steps written for a stranger are in the plugin `REGRESSION_LOG.md` entries **C7-POLY, IDENT-01, PLACE-01, C7-2024**. Summary rows:

| # | What | Test (2027 unless said) | Lane |
|---|---|---|---|
| O1 | Pipes become CE pipe objects on open | Open a COPY of a job: one line `[CE] N pipe(s) upgraded to CE pipe objects ... Backup: ...`; `_PRE_C7_` file beside it; reopen → no second line, no second backup | 2027 |
| O2 | The object is ONE polyline-like thing | Click a pipe: band + magenta walls, vertex grips only, LIST says `CE pipe P3: 3 points, 225 mm wide` | 2027 |
| O3 | Text follows the object | MOVE a pipe 2 m: pipe text, both IL texts, arrow move with it; grip an end: same at command end | 2027 |
| O4 | CDFW on a converted pipe | Split happens, two objects, no stray polyline under either half (move one half aside) | 2027 |
| O5 | CD draws the object | `CD` a pipe: one object at once; one U removes pipe + labels | 2027 |
| O6 | Twin | After open a twin is ONE object drawing two barrels; grip-move it; no stray barrels | 2027 |
| O7 | CDEDIT width | 100 → 150: walls widen, no MLINE appears | 2027 |
| O8 | Migration | The 16 Sep test copy (51 morning-objects): open → "migrated" in the line; pipes still work | 2027 |
| O9 | IDENT-01 | `CD` a pipe, grip-drag its end straight away: labels follow; no "identity" line in the log | 2027 |
| O10 | PLACE-01 draw | `CD` a pipe whose start lands 100 mm from a big pit's edge: the start IL text sits one step further in (log `route=draw ... in from the pipe end (1)`) | 2027 |
| O11 | PLACE-01 pit | `PITEDIT` 450 → 1200 on a pipe: IL text slides in; past 500 mm it flips (`route=pit-boundary`) | 2027 |
| O12 | PLACE-01 pipe | MOVE a pipe so its label crosses another pipe: label slides clear; report names `pipe P9` | 2027 |
| O13 | PLACE-01 callout | MOVE a pipe so its callout text lands on IL text: text moves, leader still starts on the pipe | 2027 |
| O14 | PLACE-01 settings | CDSETTINGS → LABEL PLACEMENT: 900 refused; 300 → IL text flips instead of a second slide | 2027 |
| O15 | 2024 enabler | Needs an AutoCAD 2024: ARXLOAD `CE_CVL_OBJECTS_2024.dbx`, open a 2027-saved drawing with pipe objects: pipes draw, one object, no proxy warning | 2024 |

### BUILT 16→17 Sep overnight — branch `claude/civil-k-l-2026-09-16` @ `0ed39495` (sections K and L chat) — NOT installed, NOT tested

Steps written for a stranger are in the plugin `REGRESSION_LOG.md` entries **L-01, L-02/L-03, P-08/item 64,
item 66, item 67, AUDIT-K-L**, and collected in `archive/chat-records-2026-09/MORNING_PACK_K_L_2026-09-17.md`. Summary rows:

| # | What | Test (2027 first; 2024 builds clean but is unrun) | Lane |
|---|---|---|---|
| K1 | `CDLPD` offers **Council Pit** | `CDLPD` on a street pipe end: `CouncilPit` is in the list; note reads `CONNECT TO COUNCIL PIT AT APPROX IL<lvl>m TO COUNCIL SATISFACTION. BUILDER TO CONFIRM…` | both |
| K2 | The old `Council` word still works | `CDLPD`, type `Council` → still gives COUNCIL PIPE | both |
| K3 | An unknown word writes nothing | `CDLPD`, type `Banana` → "not recognised", **nothing written**. Must NOT quietly write a kerb note | both |
| K4 | The note is an **MLeader**, wrapped | Note sits where you picked, **wrapped ~5 lines**, leader + arrow back to the **pipe end**, same look as a CD pipe callout. Not one long line; leader must not shoot to the drawing origin | both |
| K5 | **No invert set → no level clause** | `CDLPD` on an end with no invert: `CONNECT TO COUNCIL STUB TO COUNCIL SATISFACTION. BUILDER TO…` — no `IL`, no `0.00`, no gap | both |
| K6 | COUNCIL PIPE does not break mid-sentence | `CDLPD` → `CouncilPipe`: `CONNECT TO COUNCIL PIPE AT APPROX …` runs on. Must NOT break the line after PIPE | both |
| K7 | One note, not two | Run `CDLPD` twice on the same end → one note. `U` once removes note + leader | both |
| L1 | **Pit resize re-snaps the pipe ends** (was broken) | 450 pit with ≥2 pipes in → `PITEDIT` → 1200 × 1200 (**both** boxes) → every pipe stops at the **new** outline; none stranded inside, none poking through | both |
| L2 | Label and cover keep their distance | Same resize: label circle and cover text step out, same clear gap from the pit edge | both |
| L3 | Undo, and shrink | `U` once → size, label, cover, pipe ends all go back. Then 1200 → 450: label + cover come **in**, pipe ends come in with them | both |
| L4 | If L2 still looks wrong, the log now answers it | `%APPDATA%\CE_CVL_SUITE\logs\`: `PITEDIT Resize:` names size **from** and **to**; each `ShiftAnnotation` line prints `gapBefore=` / `gapAfter=`. Same numbers = the ruling held | both |
| L5 | **Every tank counted** | `CDTWL` on a job with 2+ tanks on one system: total goes **up**; report says *"This system has 2 tanks (WT1, WT2). All of them are counted in the storage."* Must NOT say *"Only WT1 is counted"* | both |
| L6 | A one-tank job is unchanged | `CDTWL` on a single-tank system: total the same as before | both |
| L7 | A tank on another branch is not counted | A re-use tank on a different system must not appear in this branch's total | both |
| L8 | **Propagation: drawing and record agree** | Type an invert by hand, save, `CDPROPAGATE` from the downstream pit: it says which levels you set by hand and asks; after Apply the drawing level and the schedule level are the **same number** (open 2–3 pipes) | both |
| L9 | One Undo takes the schedule with it | `U` once after L8 → pipes, pits **and** the schedule all go back. Reopen a pipe and check | both |
| L10 | **Nothing is skipped in silence** | On a `CDC7UPGRADE`d drawing, `CDPROPAGATE`: any pipe that could not be updated is **named** in a line at the top. Must not quietly report success. **Send Tim's line back** — evidence for the unfinished piece | 2027 |
| L11 | A refused cascade leaves the schedule alone | If a cascade is refused for any reason, the schedule still shows the **old** levels | both |

**Not finished, needs the other Civil chat:** writing a *converted* pipe's own stored record goes through
`LinkService.Persistence.cs` (their file) and, reading the code, does not reach the real object. Unproven in
AutoCAD, their file untouched. Written up in `FLEET_STATUS.md` on the K/L branch.

**Open for Tim (5):** the `COUNCIL PIT` vs `EXISTING COUNCIL PIT` wording · the note's layer (`25DIMS` vs
`25TEXT`) · the note's wrap width (18.7 text heights) · whether two tanks on one system should be added ·
whether the 16 Sep `PITEDIT` tests changed one size box or both.

---

### BUILT 17 Sep — branch `claude/civil-other-areas-handoff-d747af` @ `0b3f17bd` (other Civil areas chat) — NOT installed, NOT tested

> **Branch note for the window chat:** this branch **is** the old `claude/civil-other-areas-2026-09-16-1c1ae6`
> (same tip, `e0cfe172`) plus this one commit. The chat's worktree could not write to the old branch's copy, so it
> was continued under a new name cut from that branch's tip — **not from master**. Merge THIS one; the old branch
> is contained in it.

**IDENT-02 (P-07, second half)** — *"double-clicking the invert again will not let him edit it"*. Full steps and
the evidence are in the plugin `REGRESSION_LOG.md` entry **IDENT-02**. Summary rows:

| # | What | Test | Lane |
|---|---|---|---|
| O16 | **Double-click a pipe's IL text opens the Edit Pipe window** | Open a COPY of a job with pipes. **Edit nothing first** — that is the point. Double-click an `IL 19.40` text: the Edit Pipe window opens on that pipe with 19.40 in the level box. Before, you got AutoCAD's plain text editor. | 2027 **and 2024** |
| O17 | It works the **second** time too | Escape out, double-click the same IL text again: the window opens again, not a refusal | 2027 |
| O18 | Pipe text does the same | Double-click `225 DIA. UPVC PIPE AT 1 IN 100`: Edit Pipe window opens | 2027 |
| O19 | **Pits are unchanged** | Double-click a pit's `CL 19.65` cover text: the Edit Pit window opens exactly as before | 2027 **and 2024** |
| O20 | **Ordinary text is still AutoCAD's** | Double-click a note in the title block that CE did not draw: AutoCAD's own text editor opens. If the Edit Pipe window opens on it, **stop and report** | 2027 **and 2024** |
| O21 | The pipe itself is unchanged | Double-click the pipe: Edit Pipe window as before | 2027 |
| O22 | A drawing with no CE pipes | Double-click any text: AutoCAD's editor; opening the drawing must not feel slower | 2027 |
| O23 | **The evidence run for "changing an invert does nothing"** | Open a pipe, change a level, press OK. **Whatever happens, say what the command line said and send the log.** Two new lines now record Cancel/Escape and "OK but nothing changed", with both levels as held and as read in. This is how that half gets settled — it is **not** claimed fixed | 2027 |

**ANSWERED and BUILT — this is no longer open.** The question was: blanking a level in the Edit Pipe window did
**not** clear it from the pipe's stored record, so the schedule could keep showing a level you deleted.
**Tim, 17 September 2026: *"yes a blank box should clear it, go ahead"***. Built as **BLANK-01** (`d63a29f3`) —
it turned out the old level came back from **two** places, the pipe's own record **and** the schedule row, and
both were fixed as an opt-in so the other four level-writers are untouched. **Test rows O24–O29.**

### ADDED 17 Sep — CDTWL faults, same branch `claude/civil-k-l-2026-09-16` @ `b8d827b8` — NOT installed, NOT tested

Steps in the plugin `REGRESSION_LOG.md` entry **TWL-04 / TWL-06**. Summary rows:

| # | What | Test (2027 first, then 2024) | Lane |
|---|---|---|---|
| T1 | **CDTWL takes your own level** | `CDTWL` → outlet → volume → at *"Which level is the top water level?"* type **`18.54`**. Accepted. It must NOT say *"1 or 2 only"*. The report says *"your own level, not one CE measured off the drawing"* | both |
| T2 | Picking by number still works | Run again, type `1` — exactly as before | both |
| T3 | It warns without blocking | Type a level above the lowest lid → accepted, plus *"Careful: that is ABOVE the lowest lid in this system (…), so water would come up out of it."* | both |
| T4 | Nonsense is refused cleanly | Type `banana` → *"neither one of the numbers above nor a level. Nothing was worked out."* | both |
| T5 | **The storage total — the important one** | On the same real job as Test Day, run `CDTWL`. Far fewer pits left out; the ones taken say *"…so its floor was taken from the pipes that meet it (19.200)"*; storage total **higher** than the 17,948 L he saw. **Send back the new number and how many pits and pipes are still left out** | both |

**Not fixed, and said so:** the **18 dropped pipes** (`PipeData` records no length or geometry, so the pure
collector can only measure a pipe from its two pits' positions — fixing it changes the shape and was not
guessed at); **TWL-03** (CDCALC's own TWL box is already offered, so its record did not hold 18.54 and why
cannot be established without the drawing — T1 removes the harm); **TWL-05** (the `"0.0"` volume is written on
the CDCALC side, which is the unclaimed computations work); **TWL-07** (*"will this whole command be in a
window at some point?"* — still Tim's question).

### BUILT 17 Sep — **BLANK-01**, branch `claude/civil-other-areas-handoff-d747af` @ `d63a29f3` — NOT installed, NOT tested

**Tim, 17 Sep:** *"yes a blank box should clear it, go ahead"*. Emptying a level box now deletes the level. It was
coming back from **two** places — the pipe's own record **and** the schedule row — so both were fixed. Everything
else that writes levels is untouched (opt-in). Full entry: plugin `REGRESSION_LOG.md` **BLANK-01**.

| # | What | Test | Lane |
|---|---|---|---|
| O24 | **A deleted level stays deleted** | Pick a pipe with both levels; note them in `PITSCHEDULE`. Double-click it, **empty the downstream box**, OK. The IL text leaves the plan **and** `PITSCHEDULE` shows that level **blank** — not the old number. Re-open the pipe: the box is still **empty** | 2027 **and 2024** |
| O25 | One Undo brings it back | `U` once after O24: the level returns on the plan **and** in the schedule | 2027 |
| O26 | Both levels deleted | Empty **both** boxes, OK: both gone from plan and schedule; the pipe still runs between the same two pits and its pipe text still reads size and material | 2027 |
| O27 | **A typo must never delete anything** | Type `19.4O` (**letter O**) in a level box, OK. **Nothing is deleted** — the stored levels stay as they were. Say what the command line said | 2027 |
| O28 | **"Just draw the pipe" must never delete a level** | On a pipe with both levels, tick **simple pipe only**, OK. The texts come off the plan but `PITSCHEDULE` **still shows both levels**. Untick: still there | 2027 **and 2024** |
| O29 | Nothing else changed | Run `CDLPD`, a pit move, and `CDREPAIR` on a pipe that has only ONE level: the other level must **not** be wiped | 2027 |

### ADDED 17 Sep — TWL-05, branch `claude/civil-k-l-2026-09-16` @ `b8e234f9`

| # | What | Test | Lane |
|---|---|---|---|
| T6 | A fresh system has **no** volume | `CDCALC` → Detention → add a system. Volume required box is **empty**, not `0.0`; status reads *"Enter required volume to compare."* | both |
| T7 | A real volume is offered | Type `25.06`, save, run `CDTWL`. *"CDCALC records the volume required for this system as 25.06 m3. Press Enter to use it…"* — and **Enter accepts it** | both |
| T8 | An empty one is explained | `CDTWL` on a system with no volume: *"CDCALC has no volume recorded for this system yet…"*. Must NOT say *"not a plain number"* | both |
| T9 | No matching system says so | Pick an outlet no CDCALC system names: *"CDCALC has no detention system recorded against this outlet…"*. Must not go quiet | both |
| T10 | **The drawing block** | Insert ON SITE DETENTION CRITERIA for a system with no volume: `VOLUME REQUIRED   NOT SET`. Must NOT read `0.00 m3`. **Tim to say whether `NOT SET` is the right words** | both |
| T11 | An existing job is untouched | Open a job already filled in — its volume still reads what he typed | both |

**Question for Tim (new):** the same view model hard-codes `_psd = "5.24"` — a permitted site discharge, an
engineering value, in code. R-00 puts those on the Settings page. **Not changed**, because a different default
PSD changes designs. Should it be a Settings value, or start empty like the volume now does?

### BUILT 17 Sep — **T-01 `CDFIXTAGS`**, branch `claude/civil-other-areas-handoff-d747af` @ `acfb38f6` — NOT installed, NOT tested

It contradicted itself because the summary asked "describe the renames that worked" with an empty list, and that
helper answers *"Nothing to repair"*. It also **stopped at the first block it could not rename**, so the rest were
never tried, and the failure reason never reached the command line. Full entry: plugin `REGRESSION_LOG.md` **T-01**.

| # | What | Test | Lane |
|---|---|---|---|
| O30 | **The contradiction is gone** | Same drawing as 16 Sep. `CDFIXTAGS` → **Yes**. The words *"Nothing to repair"* must **not** appear anywhere after a Yes | 2027 **and 2024** |
| O31 | **It says what it did, once** | One summary: either *"N blocks were renamed: …"* or *"No block was renamed."*, then *"N was/were not renamed:"* and one line per block with the block number and a plain-English reason ending in what to do (`CDTAG` or `CDREPAIR`) | 2027 |
| O32 | **More should change than last time** | One awkward block used to stop the rest. **Count how many of the three get renamed now and tell me the number** | 2027 |
| O33 | Follow the reason, run it again | Do what the reason says (usually `CDTAG` the other block), run `CDFIXTAGS` again — it should rename the rest | 2027 |
| O34 | A tidy drawing is still called tidy | `CDFIXTAGS` on a drawing with no repeated names: *"Every source name in this drawing already names one block. Nothing to repair."* — that sentence is correct **there** and must stay | 2027 |
| O35 | Answering No | *"Nothing was renamed."* and nothing changes | 2027 |
| O36 | **Send the log** | A new `[SourceClaims] refused:` line names which piece of text is claimed twice and by which blocks. **That is what decides whether the refusal is right or whether it is the next bug** | 2027 |

**Not fixed, and said plainly:** the underlying refusal. Erasing a label that another source also claims would take
the wrong text off the drawing, so that guard was **not** bypassed. Whether the shared claim is real on this
drawing or the duplicate tag itself confuses the scan **is not established** — row O36's log line settles it.

### BUILT 17 Sep — **P-02 split levels**, branch `claude/civil-other-areas-handoff-d747af` @ `24d9230f` — NOT installed, NOT tested

The split level was correct but **one of the two copies was drawn at the far end of the pipe** instead of at the
pit it was split at. Proven from Tim's own 16 Sep coordinates. Full entry: plugin `REGRESSION_LOG.md` **P-02**.

| # | What | Test | Lane |
|---|---|---|---|
| O37 | **Split levels sit at the middle pit** | Three pits in a line, left to right. `CD` ONE pipe through all three (19.45 → 19.25). Answer **Yes** to the split. **Both `IL 19.35` texts must be beside the MIDDLE pit** — one just above the pipe, one just below — **not** one back at the first pit | 2027 **and 2024** |
| O38 | Drawn right-to-left | Same run drawn the other way, split it: levels still at the middle pit | 2027 |
| O39 | Drawn vertically | A north-south run through three pits, split it: levels at the middle pit | 2027 |
| O40 | They do not overlap | The two split levels are on opposite sides of the pipe | 2027 |

**DECIDED — P-01, Tim, 18 September 2026: *"ask inside the CD window as a tick"***

The command-line question is **moved, not retired**: the same choice, asked before the pipe is drawn instead of
at the command line after the window closes. The splitting itself still runs after the pipe exists, because the
halves cannot link to their pits until the pipe is in the drawing. Contract for Codex to build the tick from:
`04_REFERENCE/contracts/CONTRACT_SPLIT_ON_DRAW_TICK_2026-09-18.md`. Ruling recorded at `TEST_DAY_RESULTS_2026-09-16.md`
§6s. **Not built yet** — acceptance replaces steps 52–56 and is listed in §9 of the contract.

**Both follow-ups settled the same day.** Tim, 18 September 2026: ***"wording is fine, and yes retire the escape
step"***. The tick reads **`Split where it crosses pits`**. The old **Escape at the split question** route is
**RETIRED with his explicit approval**, and **acceptance step 56 of the 16 September list is retired with it** —
leaving the tick unticked is the same answer, and Cancel on the CD window still means no pipe at all.
**The contract is complete and waiting on nobody; Codex can build the tick.**

**One thing the behaviour side must prove before it ships:** that one `U` after a ticked draw removes the pipe,
its halves and their labels **together**. Not verified today, not claimed.

**Still open in this area:** P-04 (a pipe with more than one bend) and P-05 (each half needs its own pipe text)
— both in progress in the same chat.

### ADDED 17 Sep — PSD-01, branch `claude/civil-k-l-2026-09-16` @ `457bf032`

| # | What | Test | Lane |
|---|---|---|---|
| T12 | A new system has **no** PSD | `CDCALC` → Detention → add a system. PSD box **empty**. Must NOT say `5.24` | both |
| T13 | CE does not fill it in for you | Fill the Boyd's tab so it works out a PSD → the Detention PSD box is **still empty** (the one-click button is Codex's to add) | both |
| T14 | A typed PSD survives | Type your own PSD, then change the Boyd's figure → yours stays | both |
| T15 | It round-trips | Save, reopen: an empty PSD is still empty, a typed one still reads what you typed | both |

**Worth a look on old jobs:** every system created before today started at `5.24 l/s`. CE does not rewrite
saved records, so check any job you have not looked at since.

### ADDED 18 Sep — K4 Council keyword, branch `claude/civil-k-l-2026-09-16` @ `dc937001`

| # | What | Test | Lane |
|---|---|---|---|
| T16 | **`Council` gives COUNCIL PIPE** *(the bug)* | `CDLPD` → pipe end → label point → type **`Council`**. Note says **COUNCIL PIPE**. Must NOT say COUNCIL STUB | both |
| T17 | Each full word still works | `CouncilStub`, `CouncilPit`, `CouncilPipe` each give their own wording | both |
| T18 | An ambiguous shortening is refused, not guessed | Type **`CouncilP`** → *"CouncilP could mean CouncilPit or CouncilPipe. Nothing was written…"* and **nothing is placed** | both |
| T19 | Shortenings still work | Type **`K`** → KERB & CHANNEL | both |
| T20 | Enter still takes the default | Press Enter → KERB & CHANNEL | both |
| T21 | `Other` still takes your own words | Type `Other`, then your wording → it goes on the note | both |

**Changed for Tim, say if you mind:** this one question no longer offers AutoCAD's right-click keyword menu —
CE reads what you type and matches it itself, which is why it can now be proven. The choices are still printed
in the question and shortenings still work.

**Not fixed by this:** the note **wording** is still wrong on Tim's machine because his settings hold the old
short template. K4 fixes which connection **type** is chosen. Both are needed.

## BUILT overnight 20→21 Sep — `claude/lisp-tools-port`, merged to master 23 Sep (PR #83, `38f1d98a`) — NOT INSTALLED, NOT TESTED

Two commands ported from the retired root LISP file CLOSED MLINE.lsp (Tim, 20 Sep: "can those lisp files be updated and added to the plugin"). CML already ran natively. Built on net10, three source-guard tests pass. Nothing installed; needs a build into a bundle and a deploy on Tim's phrase before these rows can be ticked.

| ID | What Tim would see | Lane |
|---|---|---|
| **L1** | Type `SML`, then draw two points. **A plain STANDARD multiline appears** (no end caps). Type `CML`, draw again: **closed ends** as before. | both |
| **L2** | Type `CHECKML` after `SML`. The command line prints **three lines: MLINE style STANDARD, the scale number, the justification word** (Top / Zero (centre) / Bottom). After `CML` it says CLOSED-ENDS. | both |
| **L3** | In a fresh drawing with no STANDARD style renamed, `SML` never errors. If STANDARD was deleted from the drawing, `SML` says **"STANDARD MLINE style not found in this drawing"** and draws nothing. | 2027 |
