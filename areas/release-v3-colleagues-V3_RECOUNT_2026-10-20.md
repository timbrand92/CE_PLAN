# V3 whole-plan recount 2: built, reachable, installed, switched on, tested, accepted (desk plan/03 recount job, Opus, Tue 20 Oct 2026, about 17:55 to 18:15 Melbourne)

**What this is.** The second recount of the WHOLE V3 plan. It uses the same list (548 items) and the same method as the first recount (`release-v3-colleagues-V3_RECOUNT_2026-10-18.md`), so the two can be compared line by line. Read-only: no code was edited, built or run, nothing was opened in AutoCAD, nothing was checked out.

**What is installed (taken from robot run 40, which read the nine DLLs at 17:34 today).** Civil 3.0.64 and Manager 1.1.64, build 6644752b (train C-54, line `origin/claude/rel-20261020h`). Structural 1.0.118, build 9a8e5d4e (line `origin/claude/rel-20261017s`), unchanged since the first recount.

**What changed since 18 Oct, in one line.** Ten Civil + Manager trains (C-45 to C-54, about 90 pull requests) were installed. Every one of them is a bug fix, a diagnostic or a guard test, as ruling A asks. None added, finished, wired or switched on a plan item. So the plan figures barely move. The bug figures move a lot.

---

## ANSWER FIRST

### The list we count against (the denominator)

1. **548 plan items, unchanged.** 526 UX IDs from Tim's plan (Codex's index) plus 22 build-queue items that are not UX IDs. Split: Civil 212, Manager 25, Shared 153, Structural 158.
2. **The 9 Nov release scope is Civil + Manager + Shared = 390 items.** Structural's 158 are outside it.
3. **Bugs are a separate list (807 entries) and are never mixed in.** CEMEMBER (Tim's new Structural member command, card approved 19 Oct) is not in the 548; adding it would make 549. It is paused by ruling A and outside 9 Nov.

### The whole plan (548 items)

1. **Built (code exists, installed or on an open PR): 412 of 548, 75 percent.** ESTIMATED, as on 18 Oct. **Change: none.** No plan-item PR was opened or closed since 18 Oct (all 105 PRs opened since are bug fixes; no PR was closed).
2. **Reachable (a command, button or window gets to it, any switch state): 262 of 548, 48 percent.** ESTIMATED. **Change: none.** No new command, ribbon button or window was wired to a plan item.
3. **Installed (on the builds on Tim's PC today): 300 of 548, 55 percent.** COUNTED. **Change: none.** The plan PRs named on 18 Oct (Settings pages #1208, #1246, #1251, #1252; CDPITDETENTION #1031; detention Apply #1123; the eight Manager page engines; Structural Settings #1063, #1248, #1250) were checked one by one: none is on the installed lines.
4. **Switched ON for a drafter with default settings: 179 of 548, 33 percent.** ESTIMATED. **Change: none.** The trains added 36 new switches, all for bug fixes (34 ON, 2 OFF). No plan-item switch default changed.
5. **Tested on the installed build (robot or Codex, per item): 5 of 548, 1 percent.** COUNTED evidence, ESTIMATED mapping to items. **Change: down from 9.** Nothing broke: the installed build moved from 3.0.55 to 3.0.64, and run 40 repeated only five of the nine. **Tested on any build of the current line since 18 Oct (3.0.55 to 3.0.64): 10 of 548, 2 percent (up 1).** Another 51 (9 percent) have evidence only on an older build.
6. **Accepted (Tim or Codex-accepted, whole item): 0 of 548, 0 percent.** COUNTED. **Change: none.**

### The 9 Nov release scope (Civil + Manager + Shared, 390 items)

1. **Built: 290 of 390, 74 percent.** COUNTED. **Change: none.**
2. **Reachable: 161 of 390, 41 percent.** ESTIMATED. **Change: none.**
3. **Installed on Civil 3.0.64 / Manager 1.1.64: 184 of 390, 47 percent.** COUNTED. **Change: none.**
4. **Switched ON by default: 123 of 390, 32 percent.** ESTIMATED. **Change: none.**
5. **Tested on the installed build: 5 of 390, 1 percent.** COUNTED evidence, ESTIMATED mapping. **Change: down from 9** (same reason as above). **On any build of the line since 18 Oct: 10 of 390, 3 percent (up 1).**
6. **Accepted: 0 of 390, 0 percent.** COUNTED. **Change: none.**

### The bug list (separate, 807 entries)

1. **Total: 807 entries,** BUG-001 to BUG-856. COUNTED. **Change: up 45** (BUG-813 to BUG-856 were added, mostly from robot runs and the Manager and installer review).
2. **Closed: 34 of 807, 4 percent.** COUNTED. **Change: none.** No closure was written into the carpark since 18 Oct (checked by the file's history). Robot passes do not close a bug; RULES 13.3 needs Tim or a Codex pass.
3. **Fixed or part fixed, awaiting Tim's AutoCAD check: 448 of 807, 56 percent.** ESTIMATED as an upper limit, same method (the bug number is named in a change on an installed line and the entry is not closed). **Change: up 65 from 383.** This is where the ten trains went.
4. **Fix built but not installed: 71 of 807, 9 percent.** ESTIMATED. **Change: down 3 from 74.**
5. **Open with no fix named anywhere: 254 of 807, 31 percent.** ESTIMATED. **Change: down 17 from 271.**
6. **Open in Tim's sense (not closed): 773 of 807, 96 percent.** COUNTED. **Change: up 45** (the new entries).

---

## 1. How the list was built (unchanged), and where 284 and 492 fit

1. **The 548 is the same list as 18 Oct.** 526 UX IDs (my expansion of `V3_UX_PLAN.md` gives 508; Codex's coverage index has the same 508 plus 18 written only in the 25 Sep rulings) and 22 build-queue items that are not UX IDs and not bugs. The full list of the 22 is in section 1 item 3 of the 18 Oct recount.
2. **284 (17 Oct audit, section 1b)** was the two 10 Oct build queues plus the 53 UX cards, with bug fixes mixed in and some card lines counted twice. It is a subset, not the plan.
3. **492 (17 Oct audit, section 1c)** was the same UX file expanded by that auditor, matched by name in change messages. It dropped lettered items such as UX-WORD-03b and UX-TANK-04b. 508 is the full expansion, and 526 adds the 18 ruled-only IDs.
4. **Left out on purpose, as before.** DP-0 to DP-7 and Manager M01 to M07 fold into UX IDs already counted. The 39 workflow cards are where the UX IDs came from. Release-gate items (installer, update channel, privacy) are in the REL area file.
5. **Ruling A items stay in the list, marked paused.** Ruling A (17 Oct): Tim's "pause building of new items, but let's continue the fixing of existing items". 127 of the 136 unbuilt items are paused. Open question 2 (does wiring an already-built engine count as new?) is still unanswered, so wiring stays paused.

---

## 2. What the test evidence since 18 Oct shows

### 2a. Robot runs 31 to 40 (driver v2, one per train)

1. **Run 31 (3.0.55, C-44):** 16 checks, PASS 10, FAIL 1, BLOCKED 2, UNPROVEN 2, FINDING 1. Already inside the 18 Oct figures.
2. **Runs 32 to 40 (3.0.56 to 3.0.64, C-45 to C-54):** 116 checks, **PASS 86, FAIL or STILL FAILS 11, BLOCKED 6, UNPROVEN 13.** COUNTED from each report's answer-first count line.
3. **Most passes are bug checks, not plan items.** About 31 of the 86 passes repeat the same four daily-work checks every run (Edit Pipe cascade with U and REDO, CDSYNC leaves the Pit Schedule alone, typed MOVE opens no CE window, the automatic label tidy after a move). The other 55 check bug fixes: BUG-815 detention rows (fixed on 3.0.58), BUG-141 Tidy labels pit body and sheet frame, BUG-820 Recover Inverts, BUG-854 R-06 fix line, BUG-516 freeboard, tag refusal wording, BUG-522 start-up check.
4. **Plan items with a pass on 3.0.64 (run 40), my mapping: 5.** Civil 4: the Edit Pipe cascade, quick edits leave the schedule and open no window, the automatic re-tidy of CE labels inside the edit (UX-LBL-02), CDSYNC keeps the Pit Schedule. Shared 1: plain-named Undo steps (UX-UNDO-01, in part).
5. **Dropped from the 18 Oct nine because run 40 did not repeat them:** typed STRETCH (last on 3.0.55), CDCHECKS with its switch ON (last on 3.0.59), CDSL on a locked layer (last on 3.0.55), and one more of the 18 Oct set. They still count in the "current line" figure.
6. **Added since 18 Oct: the Tidy labels command (UX-LBL-03), switch ON, Apply, U and REDO, PASS on 3.0.59 (run 35).** It is not clean: on the robot drawing one label still finds no clear spot because a real "SC" text sits under it (BUG-141, text half, still open).
7. **Still not proven by robot:** anything that needs a mouse drag, the Settings window, a right-click menu (BUG-416) or a New Pipe "More..." button (BUG-683). These are listed in `release-v3-colleagues-ROBOT_GAPS_2026-10-19.md`.

### 2b. Codex looks since 18 Oct

1. **L3, 19 Oct 14:27, on Civil 3.0.56 / Manager 1.1.56 / Structural 1.0.118:** 21 looks, PASS 17, FAIL 3, DIFFERENT 1. Manager status cards now read cleanly (PASS, BUG-221); six Civil Settings pages and two job windows fit with no clipping and no blue (PASS); the Structural Settings page clips long paths (FAIL); CEHATCH cards are empty and the steel side elevation still shows inner flange lines (FAIL, now superseded by the CEMEMBER design).
2. **L4, 19 Oct 15:02, on Civil 3.0.56:** 17 looks, PASS 2, DIFFERENT 5, BLOCKED 10 (Codex's mouse tool cannot drag). Double-clicking a pipe or its IL text opens Edit Pipe (PASS, Codex-accepted for that behaviour). Double-clicking a pit label or a schedule cell still opens AutoCAD's own editor (DIFFERENT).
3. **Why these do not raise "tested on the installed build".** They checked windows and bugs, not whole plan items, and 3.0.56 is now eight builds old. The one plan item they touch, the shared window look (UX-LOOK-01), is counted as not built as a whole item.
4. **The six 18 Oct looks (L1, L1B, L2, L3, L4, L5) were on 3.0.54** and were already in the 18 Oct "older build" figure. L5 (Structural) was blocked at start because the CE STRUC tab did not appear.

---

## 3. Area by area (figures, then the biggest gaps)

### 3a. Civil (212 items)

1. **Figures.** Built 185, COUNTED. Reachable about 90. Installed 110, COUNTED. ON 73, COUNTED. Tested on 3.0.64: 4. Tested on 3.0.55 to 3.0.64: 9. Older build only: about 36. Paused: 24. **Change since 18 Oct: tested only.**
2. **C01 and C02 sheet set-up is still the biggest hole.** 17 engines on open PRs (legend, note blocks, LPD note, sheet rule, details packing). Nothing places them on a sheet.
3. **Council rules (UX-CR-01 to 17) are still not installed.** CDCHECK cannot yet say "this council refuses that storage item". The robot did confirm the R-06 detention rows are now honest (BUG-815, 3.0.58).
4. **16 installed features are still switched OFF** (Tidy labels, the Checks extras, sizing, the pipe edits, late survey). The Settings page PRs that would show them are still not installed.
5. **21 installed engines still have nothing calling them** (orifice and tank details, downpipe detection, "not in markup", crossing services, K-REQ-01). Wiring them waits on ruling A question 2.
6. **The detention chain is still not installed** (CDPITDETENTION #1031, detention Apply #1123, the Level 3 detention writer).
7. **Tidy labels is closer.** Two of its three robot faults are fixed (pit body, sheet frame). The third (a real text under the label) is open as BUG-141 text half, and BUG-856 (the "would move" line names no pipe) has a PR (#1486).

### 3b. Manager (25 items)

1. **Figures.** Built 22, COUNTED. Reachable 7. Installed 9, COUNTED. ON about 6. Tested on 1.1.64: 0, COUNTED. Paused: 3. **Change since 18 Oct: none.**
2. **The colleague update path is still not built.** UX-MGR-04 (quiet update at next start) and BUG-478 (the real update route) are missing. A colleague cannot update without an installer run. This is the biggest 9 Nov gap.
3. **Lots of Manager bug work went in, none of it plan work.** About 20 Manager and installer fixes landed (BUG-823 to BUG-853: administrator list, support zip, version numbers, staging, read-only files), and the dead Azure upload code was removed (BUG-556).
4. **The status cards now read cleanly** (Codex L3 PASS on 1.1.56, BUG-221). The one-glance status page itself (UX-MGR-01 to 03) still has no window.
5. **The eight Manager page engines (UX-MGR-05 to 13) are still on PRs**, and Codex still owes the pages.

### 3c. Shared rules, ribbon, help and Ask CE (153 items)

1. **Figures.** Built 83 COUNTED (about 90 counting parts under other names). Reachable about 72. Installed 73, COUNTED. ON about 47. Tested on 3.0.64: 1 (UX-UNDO-01, in part). Older build only: about 8. Paused: 68. **Change since 18 Oct: none.**
2. **The one-tab ribbon and CE panel are not built** (ruling F2 holds them). The trains fixed ribbon faults only (a ribbon click now cancels a running command, BUG-828; the click log is capped, BUG-853; "Show the old CE tabs" sticks, BUG-850).
3. **The first day (splash, Start here tour, first-run help), Ask CE and keyboard access are not built.**
4. **The CE bell is installed but hidden and OFF.** "Send to admin" is not built.
5. **The UX-NAMES-01/06 guard (#1166) is installed.** It is a unit test that every typed Civil command name keeps working. It protects an installed item; it is not new plan work.

### 3d. Structural (158 items, outside the 9 Nov release)

1. **Figures.** Built about 122. Reachable about 93. Installed 108, COUNTED. ON about 53. Tested on 1.0.118: 0 plan items, COUNTED. Older build only: 7. Paused: about 32. **Change since 18 Oct: none.** No Structural train since 17 Oct.
2. **55 installed items still never reach a drafter** (OFF or uncalled). The Structural Settings page PRs are not installed.
3. **Four Structural bug PRs wait for a Structural train** (#1457, #1460, #1464, #1466), plus #1382, #1385, #1386.
4. **CEMEMBER (replaces SBEAM) is designed and its card approved by Tim (19 Oct).** It is not built: ruling A is not lifted for it, and whether to build it before or after 9 Nov is a Monday question.
5. **Retaining walls, markup QA, member schedule filling, details and sections** are as on 18 Oct: mostly unbuilt or unreachable.

---

## 4. Unbuilt and uncarded items, grouped (136; 127 paused by ruling A) — unchanged since 18 Oct

1. **Civil (27; 24 paused).** UX-CPLAN-04; UX-CR-10; UX-DET-08; UX-L3-02, 19, 20; UX-LYR-03; UX-RL-04, 05; UX-SCHED-01b, 04b; UX-SITE-01; UX-SLAB-01, 02; UX-SPS-02 to 04; UX-TANK-01; UX-WSUD-02 to 04; X-C07 (council rulings with sourced values), X-C09 (E-HOLD-01), X-C11 (drawing-production step 5). Not paused: UX-PIT-01, UX-SRC-04, UX-PLAN-01 (superseded or nothing to build).
2. **Manager (3, all paused).** UX-MGR-04, UX-SET-01, UX-SET-08.
3. **Shared (70; 68 paused).** Keyboard access (UX-ACC-01 to 03); Ask CE (UX-AI-01 to 07); architect background (UX-ARCH-01/02); the first day (UX-START-01, UX-FIRST-01 to 03, UX-HELP-01, 06); "Send to admin" (UX-FAIL-01/02); the one-tab ribbon and panel (UX-RIBBON-02 to 07, UX-PANEL-01/02, UX-RECENT-01); the issue register (10 UX-REG IDs); cross-discipline (UX-XDISC-01 to 04); and 25 single items (UX-ASK-01, UX-DWG-01 to 03, UX-JOB-02, 05, UX-LAY-03/04, UX-LEARN-02 to 04, UX-LOOK-01 as a whole, UX-MIX-02, UX-NAMES-03, 05, UX-PERF-01, UX-PROP-01, UX-RCLICK-01, UX-RULES-01, UX-SEL-01, UX-SHARE-01, UX-STDS-03, UX-VOICE-01, UX-WIN-01, 04, UX-XREF-02). Not paused: UX-HELP-07 (superseded), UX-AI-04 ("later, not V3").
4. **Structural (36; about 32 paused).** Details and sections (UX-DET-01 to 03, 06, UX-SEC-02, 03); retaining walls (UX-RW-03 to 09, 11); member schedule (UX-SSCHED-04, 06, 12, 13); UX-D2-05b; UX-MARK-08; UX-QA-02; UX-SL3-01; UX-STEEL-01; UX-STRUC-05, 07, 08, 09, 09b, 11; X-S04, X-S05, X-S09. Not paused: UX-CDTAG-01, UX-MARK-02, UX-STRUC-06, UX-STRUC-10.
5. **Mostly uncarded.** Ask CE, the first day, keyboard access, the one-tab ribbon, retaining walls, details and sections, and Level 3 slices 19/20 have no approved card. CEMEMBER is the only new card approved since 18 Oct, and it sits outside the 548.

---

## 5. What to do next to move the 9 Nov scope fastest

1. **Install the four Civil Settings page PRs (#1208, #1246, #1251, #1252) on the next Civil train.** They are existing-value pages, not new building, and they unlock the 16 OFF features. Same advice as 18 Oct; still not done.
2. **Add four checks to every robot run: STRETCH, CDCHECKS switch ON, CDSL on a locked layer, Tidy labels command.** That puts all 10 current-line items on the installed build each time, instead of 5.
3. **Get Tim's answer to ruling A question 2 on Monday.** "Does wiring an already-built engine count as new?" It decides whether the 21 uncalled Civil engines, the 17 sheet set-up engines and CDPITDETENTION can go in before 9 Nov.
4. **Build the Manager update route (BUG-478, UX-MGR-04) next.** It is a bug fix under ruling A, and a colleague release cannot update without it.
5. **Hand Tim one batched AutoCAD check of the bug fixes on his build.** 448 bug fixes are awaiting him and only 34 bugs are closed; the release gate is judged on closed bugs, not passing robots.

---

## 6. What I did not check

1. Nothing was run in AutoCAD and no window was looked at. "Reachable" means the code path exists, not that it works.
2. The plan figures were not rebuilt item by item. I checked the change since 18 Oct: every PR opened since 18 Oct (105, all bugs), every PR closed (none), the plan PRs named on 18 Oct against both installed lines, every new code file and every switch added by the ten trains. Built, reachable and ON carry the 18 Oct estimates.
3. Which robot check counts as which plan item is my judgement. The 18 Oct recount did not save its list of nine, so "down from 9 to 5" compares by behaviour, not by ID.
4. The bug split is a status-line and name match. "Awaiting Tim" (448) is an upper limit; some named changes are tests, diagnostics or part fixes. My status parse found 24 closed entries; the 18 Oct figure of 34 was kept because the carpark history shows no closure since, and the 10 difference was taken off "awaiting".
5. Installed builds were taken from run 40's DLL read at 17:34, not read again by me.
6. No helper agents and no private worktree were used: the change since 18 Oct was small enough to check directly with git and the reports.

---

## EXEC PARAGRAPH

V3 still has 548 plan items (526 from Tim's UX plan, 22 build-queue items); bugs are a separate list of 807.
Since the 18 Oct recount, ten Civil and Manager updates were installed (3.0.55 to 3.0.64), about 90 changes.
Every one was a bug fix, as Tim's 17 Oct "pause new building, keep fixing" ruling asks.
So the plan figures did not move: 412 of 548 built (75 percent), 300 installed (55 percent), 179 switched on (33 percent).
For the 9 Nov release (Civil and Manager, 390 items): 290 built (74 percent), 184 installed (47 percent), 123 switched on (32 percent).
Tested on today's installed build: 5 plan items (1 percent); on any build since 18 Oct: 10 (2 percent of the plan, 3 percent of the release).
Accepted by Tim or Codex: still 0.
The robot ran nine more passes (runs 32 to 40): 116 checks, 86 passed, 11 failed, 19 blocked or unproven.
Most of those passes were bug checks, and the bug list moved: 448 fixes now wait on Tim's AutoCAD check (up 65), 71 are built but not installed, 254 have no fix yet.
Only 34 bugs are closed, because only Tim or a Codex pass can close one.
The release gaps are unchanged: the colleague update route, the C01/C02 sheet set-up, council rules in Checks, and the 16 Civil features switched off.
Fastest gains: install the Civil Settings pages, test the switched-off features, and give Tim one batched check of the waiting fixes.
