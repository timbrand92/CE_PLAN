# V3 whole-plan recount: built, reachable, installed, switched on, tested, accepted (desk plan/03 recount job, Opus, Sun 18 Oct 2026, about 18:24 to 18:45 Melbourne)

**What this is.** One recount of the WHOLE V3 plan against one agreed list, read-only. No code was edited, built or run. Nothing was opened in AutoCAD. It replaces the 17 Oct audit's figures (`release-v3-colleagues-PLAN_GAP_AUDIT_2026-10-17.md`), which covered only part of the plan.

**What is installed (read from the nine DLLs at 18:30 today).** Civil 3.0.55 and Manager 1.1.55, build 70a4e24f (train C-44, line `origin/claude/rel-20261018d`). Structural 1.0.118, build 9a8e5d4e (train S-38, line `origin/claude/rel-20261017s`). Legacy, Net8 and Modern copies all carry the same version text.

---

## ANSWER FIRST

### The list we count against (the denominator)

1. **548 plan items.** 526 are the UX IDs in Tim's plan, and 22 are build-queue items that are not UX IDs. Bugs are a separate list (762 entries) and are never mixed in.
2. **The 526 is Codex's own index, and it matches mine.** I expanded every UX ID range in `V3_UX_PLAN.md` and got 508. Codex's coverage index had the same 508 and then found 18 more IDs written only in the 25 Sep rulings file (UX-RIBBON-02, UX-RIBBON-04, UX-PIPE-06b and others).
3. **Split.** Civil 212, Manager 25, Shared (rules every command follows, ribbon, help, Ask CE) 153, Structural 158. **The 9 Nov release (Civil + Manager) is Civil + Manager + Shared = 390 items.** Structural's 158 are outside it.

### The whole plan (548 items)

1. **Built (code exists, installed or on an open PR): 412 of 548, 75 percent.** ESTIMATED (Civil, Manager and Shared are counted; Structural is estimated).
2. **Reachable (a command, button or window gets to it, any switch state): 262 of 548, 48 percent.** ESTIMATED.
3. **Installed (on the builds on Tim's PC today): 300 of 548, 55 percent.** COUNTED.
4. **Switched ON for a drafter with default settings: 179 of 548, 33 percent.** ESTIMATED (switch defaults were sampled, not read for every item).
5. **Tested on the installed build (robot or Codex, per item): 9 of 548, 2 percent.** COUNTED. Another 52 (9 percent) have test evidence only on an older build.
6. **Accepted (Tim or Codex-accepted, whole item): 0 of 548, 0 percent.** COUNTED.

### The 9 Nov release scope (Civil + Manager + Shared, 390 items)

1. **Built: 290 of 390, 74 percent.** COUNTED (the Level 3 sub-items on PRs are estimated from PR titles).
2. **Reachable: 161 of 390, 41 percent.** ESTIMATED.
3. **Installed on Civil 3.0.55 / Manager 1.1.55: 184 of 390, 47 percent.** COUNTED.
4. **Switched ON by default: 123 of 390, 32 percent.** ESTIMATED.
5. **Tested on the installed build: 9 of 390, 2 percent.** COUNTED. Another 45 (12 percent) were tested only on an older build.
6. **Accepted: 0 of 390, 0 percent.** COUNTED.

### The bug list (separate, 762 entries)

1. **Total: 762 entries,** BUG-001 to BUG-812. COUNTED. About 50 numbers in that range have no entry of their own (merged or never used).
2. **Closed: 34 of 762, 4 percent.** COUNTED from each entry's status line. These are FIXED with a date, WONT FIX, retired, or not reproduced; 7 of them are Codex-accepted.
3. **Fixed or part fixed, awaiting Tim's AutoCAD check: 383 of 762, 50 percent.** ESTIMATED as an upper limit. The bug number is named in a change on the installed builds, and the entry is not closed. Some of those changes are tests or part fixes.
4. **Fix built but not installed: 74 of 762, 10 percent.** ESTIMATED (named only on an uninstalled branch).
5. **Open with no fix named anywhere: 271 of 762, 36 percent.** ESTIMATED.
6. **Open in Tim's sense (not closed): 728 of 762, 96 percent.** COUNTED. RULES 13.3 says a bug is only fixed when Tim (or a Codex pass) confirms it.

---

## 1. How the list was built, and where the old 284 and 492 fit

1. **284 (17 Oct audit, section 1b)** was every line of the two 10 Oct build queues plus the 53 UX cards. It mixed in bug fixes and counted some card lines twice. It is a subset, not the plan.
2. **492 (17 Oct audit, section 1c)** was that auditor's own expansion of `V3_UX_PLAN.md`, matched by name in change messages. My expansion of the same file gives 508, and Codex's index gives 508 plus 18 = 526. The 16-ID difference is ranges like "UX-WORD-01..03b" and "UX-TANK-01..04b", where the lettered items (03b, 04b) were dropped.
3. **The 22 extra items** are build-queue items that are not UX IDs and not bugs. Structural (9): beam linking ON by default (INT-078), the R-00 Structural settings leftovers, Structural speed, the Sheets "Update drawings" command, the CSMARKSRENUMBER report, the locked-rule guard tests, the FEDIT outline pick, the footing outlines reader and the new-job title block. Civil (11): Civil speed, Set C items 1 to 7, Set C item 8 (LandXML circular pits), K-REQ-01 slices 2 and 3, the computations-sheet F1/F2 tables, the B11 orifice-head reader, the council rulings that need sourced values, rulebook B9 and B5, E-HOLD-01, CD-BRANCH-01, and drawing-production step 5. Manager (2): Move My Settings (M-SET-01) and the overnight routine (UX-OVERNIGHT-01).
4. **Left out on purpose, to avoid counting things twice.** The build queue says the drawing-production packages DP-0 to DP-7 fold into UX Batches 7 to 9 and 16 to 17, and the Manager plan M01 to M07 folds into Batch 22, so their UX IDs already count them. The 39 workflow cards in `04_REFERENCE\CARDS` are the questionnaires the UX IDs came from. Release-gate items (installer, update channel, privacy) are tracked in the REL area file, not here.
5. **Ruling A items stay in the list and are marked paused.** Ruling A (17 Oct) is Tim's "pause building of new items, but let's continue the fixing of existing items". 127 of the 136 unbuilt items are paused by it. The other 9 are superseded, a ruling with nothing to build, or waiting on Tim (for example UX-STRUC-10, retiring CESTRUC).
6. **Compared with earlier figures.** The 10 and 12 Oct "built about 60 percent, installed about 53 percent" mixed bugs with plan items. The 17 Oct "installed by name 231 of 492" was a name match only. Today's 300 of 548 installed is checked against the installed code.

---

## 2. Area by area

### 2a. Civil (212 items)

1. **Figures.** Built 185, COUNTED. Reachable about 90. Installed 110, COUNTED. ON 73, COUNTED. Tested on 3.0.55: 8, COUNTED. Tested on an older build only: about 37. Paused: 24.
2. **C01 and C02 sheet set-up is the biggest hole.** 17 IDs (legend, note blocks, LPD note, sheet rule, details packing, charged pipes, details a plan needs) exist as engines on open PRs. Nothing places them on a sheet.
3. **Council rules.** UX-CR-01 to 17: 16 engines on open PRs, none installed, and CDCHECK uses none of them. On a job, CDCHECK cannot yet say "this council refuses that storage item".
4. **16 installed features are switched OFF.** Examples: Tidy labels (UX-LBL-01 to 03), the Checks extras (UX-DI-01, 03, 04), sizing (UX-SIZE-01, 03), the pipe edits (UX-PIPE-02, 08), late survey (UX-RL-03, 06). A drafter never sees them.
5. **21 installed engines have nothing calling them.** Examples: the orifice and tank details (UX-CPLAN-28 to 30), architect downpipe detection (UX-DP-01), "not in markup" (UX-MODE-02), crossing services on the long section (UX-LSEC-02), wrong-layer finding (UX-LYR-02) and K-REQ-01.
6. **Level 3 proposals.** The levels engine is installed with no caller. There is no Proposals page. Sources, detention and network are on PRs. UX-L3-02, 19 and 20 are unbuilt.
7. **The detention chain is not installed.** CDPITDETENTION (PR #1031), detention "Apply to drawing" (PR #1123), the Level 3 detention writer and the live OSD criteria block are all missing from 3.0.55.
8. **What was tested on 3.0.55.** The Edit Pipe cascade, CDSL on a locked layer, typed MOVE/STRETCH quick edits, and CDSYNC. Tidy labels ran with its switch ON and gave a finding, not a pass: the start invert text stays on the pit. No switched-OFF Civil feature has passed with its switch ON on this build.

### 2b. Manager (25 items)

1. **Figures.** Built 22, COUNTED. Reachable 7 (6 installed, 1 on a PR). Installed 9, COUNTED. ON about 6. Tested on 1.1.55: 0, COUNTED. Paused: 3 (UX-MGR-04, UX-SET-01, UX-SET-08).
2. **The colleague update path is not built.** UX-MGR-04 (quiet update at next start) and BUG-478 (the real update route) are missing. A colleague cannot yet update without an installer run, and the 9 Nov release depends on this.
3. **One-glance status (UX-MGR-01 to 03) is installed, but no window shows it.**
4. **Reporting, approval, colleague view and roll-back pages (UX-MGR-05 to 13)** are engines on open PRs (#1072, #1075, #1076, #1077, #1080, #1111, #1113, #1119). None is installed, and Codex still owes the pages.
5. **Nothing in Manager has been tested on 1.1.55.** Codex look L3 on 1.1.54 found the status-card version text running together and no theme preview pictures. UX-MGR-02 ("drop Open Hub") is ruled, but its hide switch defaults OFF, so Open Hub still shows.

### 2c. Shared rules, ribbon, help and Ask CE (153 items)

1. **Figures.** Built 83 COUNTED, up to about 90 counting parts built under other names. Reachable about 72. Installed 73, COUNTED, of which 65 are on the Civil/Manager build. ON about 47, about 44 of them on the Civil build. Tested on the installed build: 1 (UX-UNDO-01, in part). Older build only: about 8. Paused: 68.
2. **The one-tab ribbon and CE panel are not built** (UX-RIBBON-02 to 07, UX-PANEL-01/02, UX-RECENT-01). Ruling F2 holds the ribbon change until Tim checks the plan.
3. **The first day is not built:** splash, Start here tour, first-run help (UX-START-01, UX-FIRST-01 to 03, UX-HELP-01, 06).
4. **The CE bell (UX-MSG-01 to 03) is installed but hidden and OFF.** "Send to admin" (UX-FAIL-01/02) is not built.
5. **The issue register is Structural-only and OFF.** UX-REG has no Civil half, and 10 of its 15 IDs are unbuilt.
6. **Ask CE (UX-AI-01 to 07) and keyboard access (UX-ACC-01 to 03) are unbuilt.** The shared window look (UX-LOOK-01) is in 4 Civil windows only; Structural windows are still blue.

### 2d. Structural (158 items, outside the 9 Nov release)

1. **Figures.** Built about 122. Reachable about 93, of which 22 work only by typing a hidden command. Installed 108, COUNTED. ON about 53. Tested on 1.0.118: 0 passes, COUNTED (one attempt, the section mark, was BLOCKED). Older build only: 7. Paused: about 32.
2. **55 installed items never reach a drafter.** They are OFF, or nothing calls them. The Structural Settings page rows that would switch them on (PRs #1063, #1248, #1250) are not installed.
3. **Retaining walls (UX-RW-01 to 11):** 8 of 11 are unbuilt. Two engines are on PRs with no command.
4. **Markup QA (UX-QA-01 to 08):** nothing reaches a drafter with default settings. The compare and clarification engines are installed with no caller. The faded markup underlay is unbuilt.
5. **Member schedule:** CSMEMBERSCHED only lists to the command line. Filling the office MEMBER SCHEDULE block is unbuilt.
6. **Details and sections (UX-DET-01 to 06, UX-SEC-02/03):** nothing installed.
7. **Beam linking (X-S01)** defaults ON in the code, but Tim's own settings file has it OFF, so on his PC it behaves OFF.

---

## 3. Unbuilt and uncarded items, grouped (136; 127 paused by ruling A)

1. **Civil (27; 24 paused).** UX-CPLAN-04; UX-CR-10; UX-DET-08; UX-L3-02, 19, 20; UX-LYR-03; UX-RL-04, 05; UX-SCHED-01b, 04b; UX-SITE-01; UX-SLAB-01, 02; UX-SPS-02 to 04; UX-TANK-01; UX-WSUD-02 to 04; X-C07 (council rulings with sourced values), X-C09 (E-HOLD-01, only the probe exists), X-C11 (drawing-production step 5). Not paused (superseded or nothing to build): UX-PIT-01, UX-SRC-04, UX-PLAN-01 and similar records.
2. **Manager (3, all paused).** UX-MGR-04, UX-SET-01, UX-SET-08.
3. **Shared (70; 68 paused).** UX-ACC-01 to 03; UX-AI-01 to 07; UX-ARCH-01/02; UX-ASK-01; UX-DWG-01 to 03; UX-FAIL-01/02; UX-FIRST-01 to 03; UX-HELP-01, 06; UX-JOB-02, 05; UX-LAY-03/04; UX-LEARN-02 to 04; UX-LOOK-01 (as a whole item); UX-MIX-02; UX-NAMES-03, 05; UX-PANEL-01/02; UX-PERF-01; UX-PROP-01; UX-RCLICK-01; UX-RECENT-01; UX-REG-01 to 03, 06, 08, 10, 11, 13 to 15; UX-RIBBON-02 to 07; UX-RULES-01; UX-SEL-01; UX-SHARE-01; UX-START-01; UX-STDS-03; UX-VOICE-01; UX-WIN-01, 04; UX-XDISC-01 to 04; UX-XREF-02. Not paused: UX-HELP-07 (superseded by UX-FIRST-03) and UX-AI-04 ("later, not V3").
4. **Structural (36; about 32 paused).** UX-D2-05b; UX-DET-01 to 03, 06; UX-MARK-08; UX-QA-02; UX-RW-03 to 09, 11; UX-SEC-02, 03; UX-SL3-01; UX-SSCHED-04, 06, 12, 13; UX-STEEL-01; UX-STRUC-05, 07, 08, 09, 09b, 11; X-S04, X-S05, X-S09. Not counted as paused: UX-CDTAG-01 (really a Civil item), UX-MARK-02 (superseded by UX-MARK-07), UX-STRUC-06 (a priority ruling), UX-STRUC-10 (retiring CESTRUC waits for Tim).
5. **Mostly uncarded.** Ask CE, the first day, keyboard access, the one-tab ribbon, retaining walls, details and sections, and Level 3 slices 19/20 have no approved card. Under ruling A and F2 they wait for Tim's check of the one plan.

---

## 4. What to do next to move the 9 Nov scope fastest

1. **Install the Civil Settings page PRs (#1208, #1246, #1251, #1252) on the next Civil train.** Then the 16 OFF Civil features and the bell can be switched on from Settings instead of by editing a file. This is not new building.
2. **Robot-test the OFF Civil features with their switches ON, through the driver v2 settings guard, on 3.0.55.** That is the fastest way past 9 of 390 tested. Start with Tidy labels (fix the start-invert finding first), Checks, sizing and late survey.
3. **Get Tim's answer to ruling A open question 2 ("does wiring an already-built engine count as new?").** It decides whether the 21 installed Civil engines with no caller, the 17 sheet set-up engines and CDPITDETENTION can be wired before 9 Nov.
4. **Build and install the Manager update route (BUG-478 and UX-MGR-04) and test Manager on 1.1.55 at all.** It is a bug fix, so ruling A allows it, and a colleague release without it cannot update.
5. **Train the 74 bug fixes that are built but not installed, then hand Tim one batched AutoCAD check of the 383 fixes on his build.** That moves bugs from "awaiting" to closed, which is where the release gate is judged.

---

## 5. What I did not check

1. Nothing was run in AutoCAD and no window was looked at. "Reachable" means the code path exists, not that it works.
2. Switch defaults were read for true/false settings and sampled elsewhere, so every ON figure is an estimate. Ribbon buttons were not checked one by one.
3. PR bodies were not read. The evidence is PR titles, change messages and the installed code.
4. Structural built, reachable and ON figures are estimates. Some rest on change titles, not a code read.
5. The bug split is a status-line and name match. "Awaiting Tim" (383) is an upper limit, and some of those changes are only tests or part fixes.
6. The Codex VERIFYW ledgers were read through the coverage index, not case by case.
7. No private worktree was made; every read was by git on the two installed builds.

---

## EXEC PARAGRAPH

V3 has 548 plan items: 526 from Tim's UX plan (the same list Codex keeps) and 22 extra build-queue items.
Bugs are counted separately: 762 entries.
About three quarters of the plan has code written (412 of 548, 75 percent).
Just over half is installed on Tim's PC (300 of 548, 55 percent).
Only a third reaches a drafter with default settings (179 of 548, 33 percent); most new work is switched off.
Nine items have been tested on the installed build (2 percent). None is accepted by Tim or Codex (0 percent).
For the 9 Nov release (Civil and Manager, 390 items): 290 built (74 percent), 184 installed (47 percent).
Of those 390, 123 are switched on (32 percent), 9 are tested on the installed build (2 percent) and 0 are accepted.
Of the 136 unbuilt items, 127 are paused by Tim's 17 Oct ruling to fix before building more.
The biggest release gaps are the C01/C02 sheet set-up, the council rules in Checks, and the colleague update route.
Of the bugs, 34 are closed; up to 383 have a fix on Tim's PC awaiting his check, 74 have a fix not yet installed, and 271 have no fix yet.
The fastest gains are switching on and testing what is already installed, and installing the colleague update route.
