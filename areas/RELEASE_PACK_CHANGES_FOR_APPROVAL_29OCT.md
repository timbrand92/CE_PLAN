# Colleague pack: change list for approval (pages 01 to 06 against Civil 3.0.85 and Tim's 29 Oct rulings)

**Date:** Thu 29 Oct 2026 (Melbourne). **Written by:** a read-only drafting job. Nothing in the pack was edited. Nothing was published, copied or sent. No git, AutoCAD, build, robot or Codex was run.

---

# FOR TIM

1. **Answer:** pages 01 to 05 need 97 changes to be true for the build on your PC (Civil 3.0.85, Manager 1.1.85, commit 09126560) and your 29 Oct rulings. Page 01: 12. Page 02: 19. Page 03: 16. Page 04: 40 (15 changes to the 30 old items, 14 false statements in the 25 Oct draft, 11 new items). Page 05: 10. Page 06: 3 questions answered, 4 partly, 13 still open.
2. **Three things that would be wrong or unsafe if left as drafted:**
   1. **Page 02 says "Your drawings are safe either way" after a rollback.** Not true: an older CE deletes the newer parts of a drawing's record when it saves (BUG-1135).
   2. **Page 05 says the support zip drops drawing paths and "never sends itself anywhere".** The first part was never checked. The second is false if Max's Desktop is inside OneDrive (BUG-482).
   3. **Page 04 (both versions) says "no fix yet" or "next update" for about 15 problems that are already installed,** and says you have not decided things you decided on 20 and 29 Oct.
3. **Your 29 Oct rulings change page 04 in 8 places** (cover to the outside, pit drop warning, no-units note, HGL line on every sheet, green DP label, "Unknown" wording, comma figure, rainfall wording). Each is marked TRUE ONLY IF its build item (B-010 to B-016, where one exists) is in the frozen build. If it is not, the old wording stays.
4. **31 [CHECK] marks on pages 01 to 05:** 10 settled from the files, 5 partly, 16 still open. Open ones need you (6), Max (3), a spare-login rehearsal (3) or a Codex look (4). Section 8 lists them.
5. **Section 10, "APPROVE IN ONE PASS", has 12 yes/no decisions about pack wording.** None turns an open question into a decision. Answer them in one go.

---

# 0. HOW TO READ THIS FILE

1. **The build everything is checked against:** Civil 3.0.85 and Manager 1.1.85, commit 09126560, installed 29 Oct 00:21 (train C-75). I took this from your brief, `PROGRESS.json` and the install queue. **I did not read the DLL version strings.** The desk must do that at the freeze (Mon 2 Nov).
2. **TRUE ONLY IF.** Where a change depends on a build item that is not installed, I write "TRUE ONLY IF B-0xx is in the frozen build; otherwise keep the old wording". The build items are in `areas\release-v3-colleagues-BUILD_REGISTER.md`. The ones used here:
   1. **B-001** double-click on a downpipe opens CE's Edit source window first (BUG-859, PR #1834, train C-76).
   2. **B-002** CDCHECK says "an unnamed pipe" (BUG-372, PR #1835, C-76).
   3. **B-003** Manager About window grows to fit (BUG-090, PR #1836, C-76).
   4. **B-004** DP takes about 30 seconds, fix reads each object once (BUG-1228, PR #1837, C-76).
   5. **B-005** grade shown flatter than chosen, 1 in 102 for 1 in 100 (BUG-1229, PR #1838, C-76 only if the assembly report says so).
   6. **B-006** "Recent:" level buttons back on New Pipe (BUG-1226, running).
   7. **B-007** raingarden RG1 label. **B-008** Tidy labels switch ON by default. **B-009** grip, ROTATE and SCALE copy clean-up ON by default (not before a robot pass with it ON).
   8. **B-010** no-units drawing: one soft line (BUG-505). **B-011** comma figure refused, unset material speed falls back (#1788 extras).
   9. **B-012** cover measured to the outside top of the pipe (BUG-901). **B-013** pit drop warning where the pipe gets bigger (BUG-907). **B-014** green DP label double-click (BUG-860).
   10. **B-015** the "hydraulic grade line not calculated" line on every council sheet (PR #1771, needs rebase and review first). **B-016** rainfall note wording (BUG-866, not started).
3. **Four words, never merged:** Built, Tested, Installed, Tim-accepted (RULES section 4). "Claude-accepted" and "Codex-accepted" are written out; they are not Tim-accepted. Of everything below, Tim confirmed by hand on 3.0.85 only what section 2 item 3 of `areas\COLLEAGUE_READINESS_29OCT.md` and hand checks H1 to H7 in `areas\ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` say.
4. **"Not recorded"** means I looked in the files named and found nothing. It does not mean it is false.
5. **Short names for evidence files** are under `C:\CE_PLAN\`. For example `areas\TEAM_AUDIT_T5_24OCT.md` is written `TEAM_AUDIT_T5`.

---

# 1. PAGE 01: START HERE FOR MAX (12 changes)

Checked, no change needed: section 1 items 1, 2 and 4; section 3 items 1, 2, 4, 5, 7, 8, 9, 10; first-10-minutes steps 3, 4, 5, 6 and 8.

1. **01-1 Header and version line.**
   1. **Now:** "**CE Civil 3.0.70 and CE Manager 1.1.70** (the versions on Tim's PC on 22 Oct). The exact numbers you receive are set when the release is frozen, about Mon 2 Nov. [CHECK]"
   2. **Proposed:** "**CE Civil 3.0.85 and CE Manager 1.1.85** (the versions on Tim's PC on 29 Oct). The final numbers are set when the release is frozen on Mon 2 Nov. Type `CE_VERSION` and use the numbers it shows." Header date: "DRAFT, updated Thu 29 Oct 2026".
   3. **Evidence:** `PROGRESS.json` (installed line); `release-v3-colleagues-QUEUE.md` install 309 and the C-75 entry.
   4. **Depends on:** the freeze build. If C-76 installs before the freeze the numbers become 3.0.86 and 1.1.86. Settles mark 01a.

2. **01-2 Section 1 item 3, "It warns, it never stops you."**
   1. **Now:** "It warns, it never stops you. ... Only two things are ever blocked, and neither is something you will meet day to day."
   2. **Proposed:** "**It warns before it stops you. CE refuses only a few things, so a drawing cannot be damaged:** a locked layer (CE names the layer and changes nothing), a pit number that clashes with one already used (a bare 8 next to P8), and a floor waste placed on top of an inspection opening. Everything else is a warning and you decide."
   3. **Evidence:** page 03 section 1 items 5 and 13; `decisions\2026-10-29_TIM_ANSWERS.md` item 4 (floor waste on an inspection opening: refusal stays); `TRAIN_C75_PR_LIST_2026-10-28.md` (#1833). The "two hard blocks" are a developer rule (R-27), not something Max sees.
   4. **Depends on:** nothing. Needs Tim's wording nod (Approve item 6).

3. **01-3 Section 2 item 2, "The same set-up Tim uses".**
   1. **Now:** "**The same set-up Tim uses**: his version and his working switches, not a separate build."
   2. **Proposed (if the colleague settings file is made):** "The same version and the same starting switches as Tim's PC on the freeze day. Tim's folder paths are not copied; CE works out yours." **Proposed (if it is not):** "The same version as Tim. Your starting settings are CE's built-in standard values. Tim will tell you if any of his switches differ."
   3. **Evidence:** `TEAM_AUDIT_T5` checklist item 14 (NOT MET, F-023: no approved colleague-defaults export exists) and finding 3; `PILOT_CRITICAL_TEST_LIST_29OCT.md` (your `CD_Settings.json` holds no value for the 26 switches checked, so the built-in defaults apply on your PC too); `COLLEAGUE_READINESS_29OCT.md` section 4 item 4.
   4. **Depends on:** the colleague-defaults export (F-023) being made and rehearsed. TRUE ONLY IF it exists by Fri 6 Nov; otherwise use the second wording. See Approve item 5.

4. **01-4 Section 2 item 3, "For AutoCAD 2027. [CHECK]".**
   1. **Now:** "**For AutoCAD 2027.** [CHECK: confirm Max's PC runs 2027]"
   2. **Proposed (once Max replies):** "For AutoCAD 2027. Type `ABOUT` in AutoCAD and read the year." If Max is not on 2027, this page and page 02 need a rewrite (nothing on this build has been driven in AutoCAD 2022 to 2026).
   3. **Evidence:** `TEAM_AUDIT_T5` checklist items 8 and 9, risk 3; `COLLEAGUE_READINESS_29OCT.md` section 4 item 5; page 06 question 2.
   4. **Depends on:** Max's answer. **Unresolved. Who: Max.**

5. **01-5 Section 3 item 3, DP prompts.**
   1. **Now:** "**`DP`: place a downpipe** (a DP1 source block). [CHECK: exact prompts]"
   2. **Proposed:** "**`DP`: place a downpipe.** CE asks 'Specify downpipe insertion point:'. Click the spot. CE says 'Downpipe placed. Tag: DP1.' and 'Pick the next DP, or press Esc to stop.' Esc to stop. A DP can take several seconds to half a minute; wait, do not click again."
   3. **Evidence:** the robot case header in `C:\Lisp Files\_ACAD_DRIVER\cases\N04_dp_and_raingarden_without_pipe.case.txt`, quoting Codex look D7-01 (`CODEX_VERIFY_D7_20261026_0553.md`, Civil 3.0.78, blank drawing). Slow DP: BUG-1228 (robot measured 29 to 32 seconds on 3.0.84; Tim 29 Oct).
   4. **Depends on:** prompts seen on 3.0.78, not re-seen on 3.0.85. The slow-DP sentence: TRUE ONLY IF B-004 is NOT in the frozen build; if B-004 is in, write "about a second or two" only after it is timed. Settles mark 01c.

6. **01-6 Section 3 item 6, CDCHECKS.**
   1. **Now:** "**`CDCHECKS`: the Checks list.** A palette listing what CE thinks is wrong on the drawing. [CHECK: confirm it is switched on in the shipped set-up]"
   2. **Proposed:** remove CDCHECKS from the 10 commands and say so on page 03: "The Checks list is switched off in your version. Use `CDRULES`." Replace the slot with `PITEDIT` or `CDFEEDBACK`.
   3. **Evidence:** `release-v3-colleagues-DESK_LOG.md` (robot pass 24: "CDCHECKS list is OFF by default", switch `checks.checksCommandEnabled`); gap plan section ANSWER item 3 (keep the Checks palette off); `CODEX_HUNT_WINDOWS_22OCT.md` (with the switch OFF, CDHUB opens the Civil Hub). No record that it was switched on since.
   4. **Depends on:** Tim's Q4 rule (switch ON after a Codex pass) and no Codex look of the Checks rows is recorded. TRUE ONLY IF the switch stays OFF. What the command does when typed while OFF: not recorded. Settles mark 01d. See Approve item 10.

7. **01-7 "Two habits", habit 2 (REDO).**
   1. **Now:** "For REDO, type nothing and pick nothing after `U`. Then type `REDO`."
   2. **Proposed:** add: "If REDO says 'Nothing to redo' after you picked a pit, that is a known fault. Closing the CE Inspector panel (type `CDINSPECTOR`) before you start may avoid it."
   3. **Evidence:** BUG-861 entry in `BUG_CARPARK.md` (25 and 26 Oct: robot-only, no person has tried the workaround; the 3.0.78 fix did not cure it); `COLLEAGUE_READINESS_29OCT.md` section 2 item 5.
   4. **Depends on:** nothing. Wording "may avoid" is deliberate; it is a robot finding. A BUG-861 control run was approved by Tim on 29 Oct (item 5) and may sharpen this.

8. **01-8 Section 4 "Before you start" and the practice drawing.**
   1. **Now:** "open the practice drawing Tim gives you ... [CHECK: Tim to name the practice drawing; no sample drawing ships with CE]"
   2. **Proposed:** "Open the practice drawing Tim gives you (a blank office template, so there is no client data). **Type `UNITS` first and check the drawing units are Millimetres.**"
   3. **Evidence:** page 06 question 13 (recommends a blank office template); `decisions\2026-10-29_TIM_ANSWERS.md` item 10 (no units set: read as millimetres, one soft line, B-010); page 04 item 18. Robot test drawings exist under `C:\ce_rc_drv` (for example DRV1_B1, millimetre units); whether any is free of client data is not recorded.
   4. **Depends on:** Tim naming the drawing. **Unresolved (mark 01e). Who: Tim.** The UNITS step is TRUE regardless.

9. **01-9 First 10 minutes, step 1 (PIT).**
   1. **Now:** "Type `PIT`. Click a spot. Type cover level `19.000`. Press Continue placement. Place the label. ... Press Esc."
   2. **Proposed:** add after the click: "The New Pit window can take a few seconds to appear. Wait; do not click again." Add to "Right looks like": "PIT keeps offering the next pit until you press Esc; the pits already placed stay."
   3. **Evidence:** hand check H1 in `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` (Tim 29 Oct: "pit command takes a while ... esc cancels the command and first pit remains"); BUG-1228 follow-on (PIT slow, build item B-031, not started).
   4. **Depends on:** nothing for the wait line; it is what Tim saw on 3.0.85.

10. **01-10 First 10 minutes, step 2 (CD) and the levels.**
    1. **Now:** "Type `18.000` and `17.900`. Press Start Pipe." (pits 20 m apart, covers 19.000 and 18.900)
    2. **Proposed:** "Type **both** levels yourself. After you type the first level, CE may fill in the second one and change Pipe grade to 'Set my own'. Type your second level over it. Use `18.000` and `17.880` (about 1 in 167)." Add under "Right looks like": "If you see 'Grade 1:200 is shallower than minimum 1:200', that is a wording fault at exactly the minimum; tell Tim."
    3. **Evidence:** BUG-1229 and BUG-1233 (Tim 29 Oct: the window guessed the downstream level, then switched Pipe grade to Set my own, 1 in 102); BUG-1235 (that sentence at exactly 1 in 200). The current script gives exactly 1 in 200 if the pipe is 20 m long (100 mm over 20 m), which sits on the boundary.
    4. **Depends on:** the changed levels have not been rehearsed. TRUE ONLY IF a test copy run of the 10-minute script on the frozen build gives the sentences on the page. If B-005 is in the frozen build, the 1 in 102 part may change. See Approve item 9.

11. **01-11 First 10 minutes, step 7 (help).**
    1. **Now:** "Type `CDHELP` and find 'Getting started'. [CHECK: section name]"
    2. **Proposed:** "Type `CDHELP` and read the first page." Name the section only after a Codex look at CDHELP on a fresh profile.
    3. **Evidence:** not recorded in any file read. The gap plan (section 1b item 3) says the first-day welcome, first-use tips and practice job (UX-FIRST-01 to 03, UX-START-01, UX-HELP-01 and 06) are cut and unbuilt. Page 03 section 9 item 1 says a first-run "Start Here" tour is built. **The two disagree.**
    4. **Depends on:** a Codex look. **Unresolved (mark 01f). Who: Codex.**

12. **01-12 Add a "day one" block and a "who to ask" line.**
    1. **Now:** not on the page.
    2. **Proposed:** "On Mon 9 Nov Tim sits with you for about 30 minutes: install check, then PIT, CD, Edit Pipe, Pit Schedule, CDFEEDBACK together. Tim checks in with you each day in the first week. Questions: <contact>, answered <reply time>." (Contact and reply time left blank for Tim.)
    3. **Evidence:** gap plan section 4 item 17 and section 1b item 3 (the 30-minute sit-down replaces the welcome tour); page 06 question 12 (reply time, open).
    4. **Depends on:** Tim's yes to the sit-down and the reply time. **Reply time unresolved. Who: Tim.**

---

# 2. PAGE 02: INSTALL AND UPDATE (19 changes)

Checked, no change needed: answer-first items 2 and 3; section 1 steps 1 and 2; section 2 steps 1, 2, 4 and 7; section 4 items 1, 2, 4 and 5; section 7 steps 1, 2, 4 and 6.

1. **02-1 Header.**
   1. **Now:** "DRAFT, Thu 22 Oct 2026, for Mon 9 Nov 2026."
   2. **Proposed:** "DRAFT, updated Thu 29 Oct 2026." The 10 [SCREENSHOT] placeholders stay until Codex takes them on a test copy after the freeze (page 06 question 20 recommends this; open).
   3. **Evidence:** page 06 question 20.
   4. **Depends on:** the freeze and a free AutoCAD window.

2. **02-2 Answer first item 1, the time.**
   1. **Now:** "It takes about 5 minutes."
   2. **Proposed:** "It takes about 20 minutes with the checks in section 3." Page 06 says "about 10 minutes of Max's morning". Three different figures are written: 5 (page 02), 10 (page 06), 20 (gap plan).
   3. **Evidence:** gap plan section 4 item 17 ("hand install (about 20 minutes)"). **No install has been timed:** the hand install has not been rehearsed (`TEAM_AUDIT_T5` checklist item 7: NOT MET).
   4. **Depends on:** the rehearsal on a spare login. TRUE ONLY IF the rehearsal measures about 20 minutes; otherwise use the measured figure. See Approve item 7.

3. **02-3 Section 1 step 3, AutoCAD year.**
   1. **Now:** "**Tell Tim which AutoCAD year you use.** This release is for AutoCAD 2027. [CHECK: Max's PC is 2027]"
   2. **Proposed:** "Open AutoCAD, type `ABOUT`, and tell Tim the year. Do not rely on the status bar: it says '[Modern]' on both AutoCAD 2025 and 2026."
   3. **Evidence:** page 06 question 2 (`ABOUT`); `TEAM_AUDIT_T5` finding 8; 25 Oct draft section E item 9.
   4. **Depends on:** Max's answer (mark 02a, same fact as 01b). **Unresolved. Who: Max.**

4. **02-4 Section 2 step 3, old July Structural.**
   1. **Now:** "**Leave the Structural folder alone** unless Tim says otherwise. [CHECK: Tim to decide, see 06]"
   2. **Proposed (page 06 recommendation):** "Before install day Tim reads the version and date of any Structural folder on Max's PC. If it holds a `CE_SHARED.dll`, rename the folder by adding `.backup`, as in step 2. Structural is not part of this release."
   3. **Evidence:** `TEAM_AUDIT_T5` finding 5 (old Structural's shared file may load first and break Civil's help and linetype lookups; load order UNVERIFIED); BUG-1169 (no fix, "a release check, not code"); page 06 question 3 (recommends leaving it installed but switched off in CEMANAGER). The two recommendations differ.
   4. **Depends on:** Tim's answer to page 06 question 3 (open). **Unresolved (mark 02b). Who: Tim.** Max's Structural version: not recorded.

5. **02-5 Section 2 step 5, old all-users copy.**
   1. **Now:** "Open `C:\ProgramData\Autodesk\ApplicationPlugins`. If a CE `.bundle` folder there still has a file named exactly `PackageContents.xml`, **stop and tell Tim.**"
   2. **Proposed:** check **both** `C:\ProgramData\Autodesk\ApplicationPlugins` and `C:\Program Files\Autodesk\ApplicationPlugins`. Add: "New Civil prefers its own pit blocks over an old copy, but that fix has not been seen; an old Manager there can still hide the ribbon."
   3. **Evidence:** `TEAM_AUDIT_T5` finding 1 (block search order is ProgramData, then Program Files, then your own copy); BUG-1165 fix PR #1751 installed in 3.0.74, switch `pits.blocksFromRunningBundleFirst` ON (`PILOT_CRITICAL_TEST_LIST_29OCT.md` entry 20, needs a spare PC with administrator rights to prove).
   4. **Depends on:** nothing for the added folder. The "fix not seen" sentence is TRUE until a rehearsal proves BUG-1165.

6. **02-6 Section 2 step 6, where the copy comes from.**
   1. **Now:** "Copy in the two new folders ... from the release folder Tim gives you. [CHECK: where the frozen release copy will sit; ...]"
   2. **Proposed:** "Copy the two folders from the frozen release folder Tim gives you (a USB stick or the pilot folder, **never an emailed or Teams zip**). The desk then reads back the SHA-256 of every file against the frozen list. Any mismatch: stop."
   3. **Evidence:** `TEAM_AUDIT_T5` finding 12 (a downloaded zip can block a helper), checklist item 6 and risk 4 (the package is not sealed to the tested files, BUG-885); gap plan section 1a items 1 and 2; AGENTS.md (verify SHA-256 after any deploy).
   4. **Depends on:** where the copy sits is Tim's call (page 06 question 5, open; recommended `CE V3 PILOT` folder, publishing needs his yes). **Unresolved (mark 02c). Who: Tim.** The hash list must exist by the packaging step (gap plan: Wed 4 Nov). See Approve item 12.

7. **02-7 New step in section 2: starting settings.**
   1. **Now:** not on the page.
   2. **Proposed:** "Copy the colleague settings file Tim gives you into `%APPDATA%\TIM_CE_CADTOOLS` as `CD_Settings.json`. Do **not** copy Tim's own file."
   3. **Evidence:** `TEAM_AUDIT_T5` finding 3 (Tim's file carries his folder paths) and checklist item 14; BUG-1167 (fix PR #1754 installed in 3.0.74: another person's folder paths follow this PC; not proved on a second login). This also moves the 25 Oct draft's section E item 5 ("Do not copy Tim's settings file") off Max's page 04 and onto the installer's page.
   4. **Depends on:** the colleague-defaults export (F-023) existing. TRUE ONLY IF it does; otherwise omit the step and use the 01-3 second wording.

8. **02-8 Section 3 steps 2 and 3, first start (two marks left open).**
   1. **Now:** "AutoCAD may ask whether to load the CE files. Choose 'Always Load'. [CHECK ...]" and "Its Civil panels are Draw, Sources, Edit, Design, Review, Site, Import and Settings. [CHECK: tab name as seen on screen]"
   2. **Proposed:** keep both sentences with their marks. Fill them in at the first rehearsal (security prompt) and from a Codex look at the ribbon on 3.0.85 (tab name, panel names).
   3. **Evidence:** `TEAM_AUDIT_T5` checklist item 12 (the installer sets SECURELOAD, a hand copy does not; AutoCAD's behaviour UNVERIFIED). Ribbon panel names: not recorded for 3.0.85.
   4. **Depends on:** a spare standard login and a Codex look. **Unresolved (marks 02d, 02e). Who: rehearsal, Codex.**

9. **02-9 Section 3 step 4, CEHEALTH.**
   1. **Now:** "Type `CEHEALTH`. Every line should start `[OK]`."
   2. **Proposed:** add: "Then look at the ribbon. CEHEALTH can say OK when Civil did not load. If the CE tabs are missing, go to section 6."
   3. **Evidence:** `TEAM_AUDIT_T5` checklist item 23 (MGR-01); 25 Oct draft section E item 10.
   4. **Depends on:** nothing.

10. **02-10 Section 3 step 5, version numbers.**
    1. **Now:** "Check the numbers match the ones Tim gave you."
    2. **Proposed:** "Civil 3.0.85 and Manager 1.1.85 (or the frozen numbers)." If B-003 is in, add "The About window shows every row."
    3. **Evidence:** B-003 (BUG-090, About window grows to fit its rows).
    4. **Depends on:** the freeze build. The About line: TRUE ONLY IF B-003 is in.

11. **02-11 Section 4 item 3, CESUPPORT.**
    1. **Now:** "`CESUPPORT`: makes a support zip of your CE logs for Tim. It never sends anything by itself."
    2. **Proposed:** "It never sends anything itself. The zip is saved in a 'CE Support' folder on your Desktop. **If your Desktop is inside OneDrive, OneDrive copies the zip to the company account straight away.** Tell Tim if it is."
    3. **Evidence:** `04_REFERENCE\release\DAY1_FOR_TIM_2026-10-09.md` (W45: "It has not been sent anywhere" is not quite true where the Desktop is in OneDrive, BUG-482); `STAFF_HELP_2026-10-08.md`.
    4. **Depends on:** whether Max's Desktop is in OneDrive (not recorded). The sentence is TRUE either way as a warning.

12. **02-12 Section 4 item 6, buttons not to press.**
    1. **Now:** "Roll Back Release, Get update ready (or any 'update' button), Set up CE administrator, and the Admin Dashboard."
    2. **Proposed:** add "the Manager fault report and `CEMANAGERDIAG`".
    3. **Evidence:** gap plan section 5 item 4.8 ("Do not use Manager's 'Get update ready', the support bundle or CEMANAGERDIAG yet"); `COLLEAGUE_READINESS_29OCT.md` section 1 gate item 5 (the pack names neither). Page 04 section E item 28 already says to use CESUPPORT instead.
    4. **Depends on:** nothing. Note the gap plan's short page also says not to use "the support bundle"; page 05 says to use CESUPPORT. See Approve item 3.

13. **02-13 Section 5 item 5, the citation.**
    1. **Now:** "switched off until Tim approves it (BUG-478, ruling F2, 17 Oct). [CHECK: whether this changes before 9 Nov]"
    2. **Proposed:** "Updates by hand are Tim's 20 Oct ruling (item 5, 'yes'). The quiet update at next start (UX-MGR-04) moves to after 9 Nov." Drop the "ruling F2" citation.
    3. **Evidence:** `decisions\2026-10-20_TIM_ANSWERS.md` item 5; gap plan section 1b item 1. F2 of 17 Oct in `decisions\2026-10-17_V3_ALIGNMENT_RESET.md` is "Tim checks the one plan before it is executed", not the update route. I found no F2 ruling on updates.
    4. **Depends on:** nothing. Settles mark 02f (answer: no, it does not change before 9 Nov).

14. **02-14 Section 6 item 2, shared-file message.**
    1. **Now:** "A line saying the shared CE file is not its own ... Ask Tim to copy both again together."
    2. **Proposed:** add: "The message may tell you to 'run the CE installer again'. You do not have the installer. Ask Tim."
    3. **Evidence:** `TEAM_AUDIT_T5` finding 14 (UNSURE).
    4. **Depends on:** nothing.

15. **02-15 Section 6 item 3, "Menu item failed to load".**
    1. **Now:** "This is harmless and the CE tabs still work. [CHECK: whether this line still appears on 3.0.70 on a clean PC]"
    2. **Proposed:** "You may not see this at all. It comes from old CE menu entries in Tim's own AutoCAD menu file. If you see it, the CE tabs still work; tell Tim."
    3. **Evidence:** `areas\release-v3-colleagues-BUG562_STARTUP_SYNTAX_ERROR_2026-10-10.md` (no CE file prints it; the lines match stale menu groups in Tim's `acad.CUIX`; the cause is read, not proven).
    4. **Depends on:** a clean-profile look. **Partly resolved (mark 02g, same as 04c).** Remaining check: spare login.

16. **02-16 Section 7 step 3, rename or delete.**
    1. **Now:** "Rename the new folders by adding `.REMOVED.backup` ... [CHECK: the desk prefers rename over delete; Tim to confirm]"
    2. **Proposed:** keep as written; drop the [CHECK].
    3. **Evidence:** `04_REFERENCE\release\ROLLBACK_GUIDE_2026-10-07.md` section 7 item 4 ("Do not delete the new bundle. Rename it.").
    4. **Depends on:** nothing. **Resolved from the file (mark 02i).** Tim's own nod is not recorded.

17. **02-17 Section 7 step 5, the menu name.**
    1. **Now:** "type `MENULOAD`, find `CE_SUITE_MANAGER_MENU` ... [CHECK: ... unloading it removes the menu has not been rehearsed]"
    2. **Proposed:** keep the wording. The name is right; unloading is still unrehearsed.
    3. **Evidence:** BUG-562 report (menu group `CE_SUITE_MANAGER_MENU` exists in Tim's menu file); `TEAM_AUDIT_T5` finding 9 (same name; "whether AutoCAD remembers it is UNVERIFIED"); BUG-1173.
    4. **Depends on:** the rollback rehearsal. **Partly resolved (mark 02j).**

18. **02-18 Section 7, the Roll Back button note.**
    1. **Now:** "**Never use Manager's Roll Back Release button.** ... [CHECK: whether it is hidden in 1.1.70]"
    2. **Proposed:** keep "never use". Replace the [CHECK] with "It is still visible; do not press it."
    3. **Evidence:** the records disagree. `TEAM_AUDIT_T5` checklist item 17 says NOT MET (BUG-477 live, no switch). `BUG_REGISTER_TRIAGE_2026-10-24.md` lists BUG-477 under hunt labels "installed", untested. `BUG_CARPARK.md` BUG-477 status: OPEN.
    4. **Depends on:** a Codex look at the Manager Updates tab on 1.1.85. **Unresolved (mark 02k). Who: Codex.** The "never use" wording is safe whichever is true.

19. **02-19 Section 7, "Your drawings are safe either way." (SAFETY)**
    1. **Now:** "**Your drawings are safe either way.** CE keeps its records inside each drawing. An older CE may not show the newest features in a drawing you worked on in 3.0. [CHECK: mixed-version behaviour has not been tested]"
    2. **Proposed:** "**A drawing you worked on in 3.0 is not safe to save with the old version.** The old version can delete the newer parts of CE's record in that drawing (for example a check you chose to ignore comes back). After going back, open 3.0 drawings only to look, do not save them, and tell Tim. Builds from 3.0.74 on keep the newer parts."
    3. **Evidence:** BUG-1135 in `BUG_CARPARK.md`; `PILOT_CRITICAL_TEST_LIST_29OCT.md` entry 1 (fix installed in 3.0.74; the full check needs two builds and a save, not possible on Tim's PC today); 25 Oct draft section B item 11. Max's old version is probably 2.1.14 (page 03 mark 03a), which is older than 3.0.74.
    4. **Depends on:** nothing. This is true now. **Settles mark 02l in the negative.** See Approve item 8.

---

# 3. PAGE 03: WHAT'S IN THIS RELEASE (16 changes)

Checked, no change needed: section 1 items 1, 4, 5, 7 to 11, 13; section 2 items 1, 3 to 6; section 4; section 5 items 1, 2, 4 to 7; section 6 items 2, 4, 5; section 7 items 1 to 4; section 8 items 1, 4; section 9 items 3 and 4.

1. **03-1 Header and base version.**
   1. **Now:** "based on the change log at the head of the installed line (Civil 3.0.70 / Manager 1.1.70, 22 Oct)."
   2. **Proposed:** "based on Civil 3.0.85 / Manager 1.1.85 (29 Oct)." Add a fourth label: "**Seen by Tim** means Tim did it in his own AutoCAD."
   3. **Evidence:** `release-v3-colleagues-QUEUE.md` installs 292 to 309; `ACCEPTANCE_LEDGER_CLAUDE_2026-10-24.md` H1 to H7.
   4. **Depends on:** the freeze build.

2. **03-2 Section 1 items 2 and 3 (PIT, CD, U).**
   1. **Now:** "PIT and CD keep placing until you press Esc ... Built, seen." and "One `U` takes back one whole CE action ... Built, seen."
   2. **Proposed:** "Built, **seen by Tim on 3.0.85 (29 Oct)**" for PIT and CD keep placing (H1, H2). For `U`: "U names what it undid; seen by Tim for PIT (H7). The MOVE case was not tried as written."
   3. **Evidence:** ledger H1, H2, H7.
   4. **Depends on:** nothing.

3. **03-3 Section 1 item 6, CDEDIT on a downpipe.**
   1. **Now:** "CDEDIT edits a downpipe (DP1) in a small 'Edit source' window ... Built 20 to 21 Oct, not seen. The double-click route does not work yet (page 04)."
   2. **Proposed:** keep. If B-001 is in: "Double-click on the downpipe symbol opens the Edit source window first." If B-014 is in: "Double-click on the green DP label does too, when the label belongs to that downpipe."
   3. **Evidence:** BUG-859 (still failed on 25 Oct: AutoCAD's editor opens, CE's window 21 to 37 seconds later); `decisions\2026-10-29_TIM_ANSWERS.md` item 22 (Tim: "yes" for the green label); BUILD_REGISTER B-001, B-014.
   4. **Depends on:** TRUE ONLY IF B-001 (and B-014) are in the frozen build; otherwise keep the old wording.

4. **03-4 Section 2 item 2, CDCHECKS.**
   1. **Now:** "CDCHECKS, the Checks list palette ... Built. [CHECK: whether it is ON in the shipped set-up]"
   2. **Proposed:** "Built. **OFF in your version.** Leave it off. Use `CDRULES`." Add "the Checks list" to the OFF list in item 7.
   3. **Evidence:** as 01-6.
   4. **Depends on:** TRUE ONLY IF the switch stays OFF. Settles mark 03b.

5. **03-5 Section 2 item 7, the OFF list.**
   1. **Now:** "OFF for now: CDCHECKIGNORE (ignore one finding). ..."
   2. **Proposed:** keep CDCHECKIGNORE OFF. Add one line: "With the switch off it now changes nothing in the drawing."
   3. **Evidence:** BUG-863 in `BUG_CARPARK.md`: FIXED (Claude-accepted, Civil 3.0.75, robot case R10 in two sessions; not Tim-confirmed).
   4. **Depends on:** nothing.

6. **03-6 Section 3 item 1, Tidy labels.**
   1. **Now:** "Tidy labels (CDTIDYLABELS) counts first ... [CHECK: whether it is ON]"
   2. **Proposed:** "Built. **OFF in your version.** Leave it off." If Tim switches it on for colleagues: "ON. It counts first, moves only after you type Yes, and one Undo takes it all back."
   3. **Evidence:** `release-v3-colleagues-CLAUDE_DRIVER_RUN26_Q4PROFILE_2026-10-18.md` (the robot had to add `linking.tidyLabelsEnabled` true to its copy; Tim's file held none, so the default is OFF, my inference); gap plan (switched-off features stay off). **Note the 29 Oct ruling is narrower than the register says.** Item 8 in `decisions\2026-10-29_TIM_ANSWERS.md` is the "Tidy labels **names the pipe**" switch, not Tidy labels itself. BUILD_REGISTER B-008 says "Tidy labels switch ON by default". No ruling to switch Tidy labels itself on for Max is recorded.
   4. **Depends on:** TRUE ONLY IF the feature stays OFF. **Settles mark 03c (OFF).** See Approve item 10.

7. **03-7 Section 3 item 5, Recover Inverts.**
   1. **Now:** "Recover Inverts (in Repair) redraws missing level text and says how many texts it drew. Built."
   2. **Proposed:** "Recover Inverts keeps the levels on the pipes and reports how many pipes it recovered and how many it skipped. It does not redraw missing level text." (Tim's 29 Oct run: 22 recovered, 0 invert texts written, 29 skipped.)
   3. **Evidence:** ledger H3 (Tim: "pass" for the summary); 25 Oct draft "What has been fixed" item 6 ("totals half only; it still does not redraw a single missing invert text").
   4. **Depends on:** nothing. The old claim is contradicted by Tim's own run.

8. **03-8 Section 7 item 5, "A fresh install behaves like Tim's PC".**
   1. **Now:** "A fresh install behaves like Tim's PC (same starting switches). Built 24 Sep. [CHECK: re-confirm against Tim's settings at the freeze]"
   2. **Proposed:** "A fresh install starts on CE's built-in standard values. Tim's PC runs the same values for the switches checked for this pack. The colleague settings file (Tim's switches without his folder paths) is [made / not made yet]."
   3. **Evidence:** `TEAM_AUDIT_T5` checklist item 14 (NOT MET) and finding 3; `PILOT_CRITICAL_TEST_LIST_29OCT.md` (defaults apply for the 26 keys).
   4. **Depends on:** F-023. **Settles mark 03d in the negative.**

9. **03-9 Section 8 item 2, CESUPPORT.**
   1. **Now:** "CESUPPORT makes a support zip with coded names that never uploads by itself. Built, seen."
   2. **Proposed:** add "If your Desktop is in OneDrive, OneDrive uploads the zip." (Same as 02-11.) Replace "coded names" with "no login or PC name in the file names or the index".
   3. **Evidence:** DAY1_FOR_TIM_2026-10-09 line 127 ("what is written inside the logs is NOT checked").
   4. **Depends on:** nothing.

10. **03-10 Section 8 item 5, Privacy: add job-time logging.**
    1. **Now:** the list says logins and PC names are coded, AI is OFF, Azure code removed, click log has no drawing names.
    2. **Proposed:** add: "**Job time:** from your first start, CE writes your Windows login name and job numbers to the shared Drafting folder, and a weekly export includes job addresses. You cannot turn this off yet. Tim decides whether that changes."
    3. **Evidence:** `TEAM_AUDIT_T5` checklist item 15 (NOT MET), finding 13 and risk 8; BUG-492 (Tim's call). The slow start-up part was fixed (BUG-1202, installed 3.0.76); the export stays.
    4. **Depends on:** Tim's wording nod only. The policy question (BUG-492) stays open. See Approve item 4.

11. **03-11 Section 9 item 1, the first-run tour.**
    1. **Now:** "Help Centre (CDHELP) describes Version 3, with a first-run Start Here tour and F1 help in CE windows. Built."
    2. **Proposed:** "Help Centre (CDHELP) describes Version 3, with F1 help in CE windows." Add the tour only if a Codex look sees it.
    3. **Evidence:** gap plan section 1b item 3 and `COLLEAGUE_READINESS_29OCT.md` section 6c item 2 say the welcome card, first-use tips and practice job are unbuilt and replaced by the one-page guide.
    4. **Depends on:** a Codex look at CDHELP. **Unresolved (same as mark 01f). Who: Codex.**

12. **03-12 Section 9 item 2, ribbon tab on selection.**
    1. **Now:** "Selecting a pipe, pit or source opens its own ribbon tab. Built."
    2. **Proposed:** "Built. A Codex look found a fault in the tab jump; details not recorded in the files read."
    3. **Evidence:** `COLLEAGUE_READINESS_29OCT.md` section 7 item 1 ("CDCHECKDWG's summary and the ribbon tab jump ... real faults Codex saw").
    4. **Depends on:** a Codex look report naming the fault. **Who: Codex.**

13. **03-13 Section 9 item 5, the command outcome log line.**
    1. **Now:** "CE writes one log line for each command that ends ... The line can wrongly say 'cancelled' ... (page 04)."
    2. **Proposed:** remove from Max's page. No action for Max.
    3. **Evidence:** the 25 Oct draft already moves it to the desk-only list; BUG-862 is "fix drafted" in the carpark with no later status.
    4. **Depends on:** nothing.

14. **03-14 The [CHECK] about Max's old version.**
    1. **Now:** "[CHECK] Your old version was probably Civil 2.1.14 from July 2026 ..."
    2. **Proposed:** keep until Max's current Civil and Manager versions are read.
    3. **Evidence:** BUG-1170 (waiting for Max's current Manager version); `TEAM_AUDIT_T5` finding 6.
    4. **Depends on:** reading Max's PC. **Unresolved (mark 03a). Who: Max / Tim.**

15. **03-15 New section 10, "Added since 3.0.70 (installed 3.0.71 to 3.0.85)".** Built and installed on Tim's PC; nothing here is Tim-accepted unless stated.
    1. **Now:** not on the page. The page misses about 40 fixes.
    2. **Proposed text (drafter's words):**
       1. **Copy and paste:** a pasted downpipe no longer takes the original's label (BUG-1140); a pasted network keeps its pipes with its pits after save and reopen (BUG-1150); one damaged pit record no longer stops new pipes linking (BUG-1142); ROTATE Copy and SCALE Copy of a pit get their number label and cover text (seen by Tim for ROTATE, 29 Oct; SCALE not tried); EXPLODE, ERASE and COPY of a pit seen by Tim 29 Oct (H4 to H6).
       2. **Editing:** Edit Pipe keeps a reversed arrow on a second Save (BUG-1222, seen by Tim); a downpipe or OF placed after closing without saving and reopening works (BUG-1225, seen by Tim); a blank ticked field in the batch window is left out and Apply still works (BUG-1049); CDTEXTSEG puts the label on the leg you clicked (BUG-1194); a floor waste or downpipe at a pipe end gets no false "record changed" refusal.
       3. **Pipes:** a hand-typed flat or back-falling level is kept with a warning (BUG-1040); a blank end level is written as Unknown, never 0.00 (BUG-1043); a pipe drawn along a curved polyline follows the true line (BUG-684, half).
       4. **Pit Schedule:** depth measured to the pit floor (BUG-869); a lower second outgoing pipe counts (BUG-1196); an Xref schedule says OUT OF DATE only when something changed (BUG-1145); Cancel on an export writes nothing (BUG-1198).
       5. **Calculations:** CDCALC Catchments opens empty (BUG-1101); the Charged System tab warns under a 300 mm head, on the head you type (BUG-1097); a STORM report naming Glen Eira or Yarra Ranges is read (BUG-1106); pipe material reaches the design, and an unknown material uses the Settings roughness 0.013 (BUG-868, Tim "yes" 29 Oct); starting figures for WSUD, Charged System, connection pipe, reach distances and slab minimum falls are on Settings.
       6. **Import:** a LandXML pipe with no grade is no longer labelled "AT 1 IN 100" (BUG-1188); levels inside a nested block in a turned survey Xref land in the right place (BUG-1190); markup on a metre drawing reads real pipe lengths (BUG-406).
       7. **Install and Manager:** the CE Tools tab appears when Manager loads before Civil (BUG-1206); CE prefers its own pit blocks over an old all-users copy (BUG-1165); folder paths from another person's settings follow this PC (BUG-1167); the job-time folder is looked for at every start and the weekly export runs in the background (BUG-1168, BUG-1202); a damaged approval file no longer shows "CE is current" (BUG-1179); Drawing Repair and Feedback Help wording (BUG-1180, BUG-1215); on AutoCAD 2022 to 2024 a pit move prints the pipes that did not follow (BUG-1151).
       8. **Printing:** the computations sheet prints in black by default, not blue (BUG-517 part g). Other blues in windows and icons remain (BUG-525).
       9. **Diagnostics, OFF:** the REDO diagnostic switches (`diag.redo.*`). Nothing to see.
    3. **Evidence:** `PILOT_CRITICAL_TEST_LIST_29OCT.md` section A; `TRAIN_C66` to `TRAIN_C75` PR lists; install queue entries 293 to 309; `COLLEAGUE_READINESS_29OCT.md` section 2.
    4. **Depends on:** "installed" is from git ancestry and train reports, not from the DLLs. Mark each line "Built, installed, not seen" except where a hand check or a Claude-accepted line is named.

16. **03-16 New section 11, "Agreed with Tim on 29 Oct, shown only if installed".** One line each, "TRUE ONLY IF" the item is in the frozen build:
    1. **B-010** a drawing with no units set prints "This drawing has no units set; CE read it as millimetres."
    2. **B-012** cover is measured to the outside top of the pipe, so a pipe that sat at minimum cover may newly warn.
    3. **B-013** a warning where the outlet pipe's top sits above the inlet pipe's top at a pit.
    4. **B-015** the computations sheet says the hydraulic grade line and pit losses were not checked.
    5. **B-011** a figure typed with a comma (630,5) is refused instead of being read ten times too big.
    6. **B-007** CDRG draws an RG1, RG2 label. **B-006** the New Pipe window shows "Recent:" level buttons.
    7. **Evidence:** `decisions\2026-10-29_TIM_ANSWERS.md` items 2, 3, 10, 15, 17, 18; BUILD_REGISTER. **Depends on:** each item separately; if not installed at the freeze, leave it out and keep the old page 04 wording.

---

# 4. PAGE 04: KNOWN PROBLEMS (reconcile three versions)

**Recommendation on structure:** use the 25 Oct draft as the base. It is grouped by the drafter's job and has no bug numbers in the body. Apply the corrections below. Drop its section F (Structural) and its desk-only appendix before publishing.

## 4A. The 30 items of the 22 Oct page, against the frozen build

Key: KEEP = still true, no change. CHANGE = wording must change now. COND = changes only if the named build item is in the frozen build (otherwise keep the old wording). REMOVE = take off Max's page. Totals: KEEP 15, CHANGE 6, COND 7, REMOVE 2.

1. **Item 1 (DP double-click, BUG-859): COND.** TRUE ONLY IF B-001 is in: "Double-clicking the downpipe symbol opens the Edit source window." Otherwise keep. Evidence: BUG-859 (25 Oct: editor opens first, CE window 21 to 37 seconds later).
2. **Item 2 (pit label double-click, BUG-430): KEEP.** Still fails (Codex look L4-01a, 19 Oct). No newer look recorded.
3. **Item 3 (green DP label, BUG-860): COND.** Tim said yes on 29 Oct (item 22). TRUE ONLY IF B-014 is in. Until then: "Tim has approved the fix; it is not in your version."
4. **Item 4 (REDO lost, BUG-861): CHANGE.** Add the workaround: close the CE Inspector panel (`CDINSPECTOR`), or click a pit once before the first `U`. Robot-found; see 01-7.
5. **Item 5 (renumber pits only in Edit Pit): KEEP, flag.** Tim's 8 Oct ground rule says "until the window fix is installed (it is, in 3.0.35)" (`decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` line 530). The rule may be lifted. **Who: Tim.** Keeping it is harmless.
6. **Item 6 (grade pit centre to pit centre, BUG-867): CHANGE.** Fix using the real pipe length is installed (HIGH 1, #1530); not confirmed in AutoCAD. Use the 25 Oct wording.
7. **Item 7 (all pipes sized as UPVC, BUG-868): CHANGE.** Material now reaches the design (#1664, #1669, installed in C-63, 3.0.73); not accepted. An unknown material uses roughness 0.013 (Tim "yes" 29 Oct item 20). Keep "hand check concrete sizes until confirmed".
8. **Item 8 (rainfall curve note, BUG-866): COND.** Tim 29 Oct item 16: curve numbers not changed ("leave them until you've checked the curve"). The note still says "7 to 9 per cent high" until B-016 is built. TRUE ONLY IF B-016 is in: "The note now says the curve may be high or low by up to about 8 per cent."
9. **Item 9 (cover to the inside top, BUG-901 and BUG-902): COND.** Tim 29 Oct item 17: yes, measure to the outside. TRUE ONLY IF B-012 is in. The "low spot between pits" part (BUG-902) stays.
10. **Item 10 (Pit Schedule depth to the outlet, BUG-869): CHANGE.** The pit-floor fix is installed (C-63); not confirmed. Step irons are still read from two places (BUG-540).
11. **Item 11 (moving a pit flattens a held grade): KEEP.** Add: the same symptom is now seen in New Pipe (BUG-1229, 1 in 100 shown as 1 in 102). Whether B-005 also covers the pit-move path (BUG-870): not recorded.
12. **Item 12 (pit drop compares inverts only, BUG-907): COND.** Tim 29 Oct item 18: yes, warn. TRUE ONLY IF B-013 is in.
13. **Item 13 (Inspector and CDRULES disagree, BUG-903): KEEP.** Which one is right is still open (page 06 question 18). **Who: Tim.** Build item B-022 is queued.
14. **Item 14 (CDTWL on metre drawings): KEEP, soften.** Use the 25 Oct wording: some number fixes are in, not confirmed. Not re-checked.
15. **Item 15 (Boyd's and CDDESIGN hard-ground C, BUG-905): KEEP.** The fix is built and switched OFF for Tim's figure (`detention.boydsUsesHardGroundC`). **Who: Tim** (is 0.9 right?).
16. **Item 16 (storm list jumps 5 to 10 minutes): KEEP.** Not re-checked.
17. **Item 17 (grade label ignores uphill): KEEP.** Not re-checked.
18. **Item 18 (unitless drawing read as millimetres, BUG-505): COND.** Tim 29 Oct item 10: yes, one soft line. TRUE ONLY IF B-010 is in: "CE prints 'This drawing has no units set; CE read it as millimetres.'" Keep the `UNITS` advice either way.
19. **Item 19 (X-Civil drops levels above RL 250 m): KEEP.** Not re-checked.
20. **Item 20 (CDCALC "0,35" read as 35): COND.** TRUE ONLY IF B-011 is in: "A figure with a comma is refused."
21. **Item 21 ("No clear spot" labels left): KEEP.** Tim 20 Oct item 4.
22. **Item 22 (start-up lines look like errors): CHANGE.** "You may not see these. They come from old menu entries in Tim's AutoCAD." See 02-15.
23. **Item 23 (F2 runs CLEAN): CHANGE, flag.** Tim 8 Oct: "leave as is for now, commonly used by me to save". But Codex wrote on 13 Oct that F2 invoked "Tim custom CLEAN macro" (`areas\release-v3-colleagues-CODEX_V3UX_VERIFICATION_2026-10-13.md`). It may be a key in Tim's own AutoCAD menu file and not exist on Max's PC. Proposed: "On Tim's PC F2 runs a CLEAN command, not the text window. If yours does too, save with Ctrl+S." **Who: Tim, or a look at a spare login** (mark 04d).
24. **Item 24 (typing between U and REDO ends REDO): KEEP.**
25. **Item 25 (Roll Back Release): KEEP.** 26. **Item 26 (Get update ready): KEEP.** 27. **Item 27 (Set up CE administrator): KEEP.** 28. **Item 28 (fault report buttons): KEEP.** Mark 04e is open (is BUG-488 coding complete in 1.1.85?). Records disagree (gap plan: no fix; triage: installed). **Who: Codex.**
29. **Item 29 (command outcome says "cancelled"): REMOVE.** Only affects Tim's log reading.
30. **Item 30 (CDCHECKIGNORE re-saves the record): REMOVE. FALSE for the frozen build.** BUG-863 is FIXED (Claude-accepted, 3.0.75): with the switch OFF it writes nothing.

## 4B. Statements in the 25 Oct draft that are false or out of date for the frozen build (14)

1. **FS1 Version line.** "Civil 3.0.75, Manager 1.1.75, Structural 1.0.123" becomes 3.0.85 and 1.1.85. Structural does not ship to Max (Tim ruling B3 of 17 Oct; gap plan section ANSWER 4).
2. **FS2 "The next update (Civil 3.0.76, Manager 1.1.76) is being built", and ten "fix built for the next update" lines.** 3.0.76 to 3.0.85 are installed. Change these to "fixed in the build, not yet confirmed (3.0.76)": CDCALC Catchments opens empty (BUG-1101), the 300 mm head warning (BUG-1097), the LandXML invented grade (BUG-1188), the job-time folder (BUG-1168), the slow start-up export (BUG-1202), the approval file status (BUG-1179), Feedback Help (BUG-1215), Drawing Repair wording (BUG-1180), and on AutoCAD 2022 to 2024 the copy clean-up (BUG-1137) and the move-pit line (BUG-1151). Evidence: `PILOT_CRITICAL_TEST_LIST_29OCT.md` section A.
3. **FS3 Section A item 1, old all-users copy "no fix yet".** BUG-1165 fix is installed (3.0.74), unproven.
4. **FS4 Section B item 3, green DP label "no fix yet, waiting for a decision".** Tim said yes (29 Oct item 22); fix queued as B-014.
5. **FS5 Section B item 6, batch edit blank field "no fix yet".** BUG-1049 is installed (3.0.77).
6. **FS6 Section C item 19, "the sentence is built but held until Tim says yes".** Tim said yes on 29 Oct (item 15, "do as you recommend"). It needs a rebase and review (B-015) before a train.
7. **FS7 Section C item 25, Detention with no length: "Tim has not decided".** Tim ruled "yes" on 20 Oct (item 3).
8. **FS8 Section C item 26, "Unknown" versus "not known": "Tim is deciding".** Tim ruled "Unknown everywhere" (29 Oct item 21). Whether the wording is built: not recorded. Remove the item or say "being changed".
9. **FS9 Section C item 14 (cover), section A item 8 (pit drop), section A item 4 (no units): each says "Tim is deciding".** All three are decided yes (29 Oct items 17, 18, 10). Wording per 4A items 9, 12, 18.
10. **FS10 Section C item 13 (rainfall): "Tim is deciding the wording and the curve values".** Curve values: left alone. Wording: drafted, not started (B-016).
11. **FS11 "Decisions Tim has not made yet", items 1 to 7.** Items 2, 3, 4 and 5 are now decided yes. Item 1: curve unchanged, wording pending. Item 6 (Tidy labels names the pipe): decided ON. Item 7 (grip, ROTATE and SCALE copy): decided ON after a robot pass with it ON (B-009). Rewrite the list to the three that are still open: survey Xref detach (BUG-1189), stage drawing BIND (BUG-1149), how a colleague finishes an update.
12. **FS12 Section C item 2 (remarks cross the row lines): "[CHECK: a fix is in the Structural build]".** For Civil: no fix. Tim's "row grows for a third line" idea is queued as B-028 (needs a Codex look).
13. **FS13 Section E item 5, "Do not copy Tim's settings file".** This is an installer instruction, not for Max. Move to page 02 (02-7).
14. **FS14 Section F, whole section (Structural).** Remove from Max's page.

## 4C. New items to add (found after 25 Oct) (11)

1. **N1 DP and PIT are slow.** "A downpipe can take about 30 seconds to place; PIT takes a few seconds to open its window. Wait, do not click again." Fix: B-004 (DP), B-031 (PIT, not started). BUG-1228.
2. **N2 The second level CE fills in is rounded, so the grade can read flatter than you chose (1 in 102 for 1 in 100).** "Type both levels yourself." Fix: B-005. BUG-1229.
3. **N3 CE can switch Pipe grade from Standard to 'Set my own' without telling you** after it guesses the second level. "Look at Pipe grade after you type the first level." BUG-1233. Whether B-005 covers it: not known. Tim wants the whole CD and Edit Pipe grade-and-level working redesigned (PC-02, PC-03 in `decisions\2026-10-29_TIM_PLANNING_CHANGES.md`).
4. **N4 The plan preview in New Pipe and Edit Pipe can show the old label and old levels after you change something.** On hold for the redesign. BUG-1230.
5. **N5 "Grade 1:200 is shallower than minimum 1:200".** A pipe at exactly the minimum can print this warning. BUG-1235.
6. **N6 Two pipes ending at one pit can leave the level text over the pit symbol and the arrow through the label.** Cause suspected: Tidy labels' after-move clash tidy-up. BUG-1234, unproven.
7. **N7 After EXPLODE, ERASE or COPY of a pit, many lines "Pit schedule cell for C1 ... not updated" may print.** Seen on Tim's test drawing; the pit change itself worked. "Run Update existing schedule in PITSCHEDULE." BUG-1231.
8. **N8 A label near the sheet border may report "no clear spot" naming the Drawing Border.** Suspected, not seen by hand. BUG-1232.
9. **N9 ROTATE or SCALE Copy landing exactly on the original may print many lines.** Unproven; SCALE Copy not tried by Tim. BUG-1227.
10. **N10 A floor waste cannot be placed on an inspection opening.** "CE refuses with a plain sentence ('IO2 is already at this point ...'). That is intended." Tim 29 Oct item 4; BUG-1223.
11. **N11 The New Pipe window has no 'Recent:' level buttons yet.** Tim said bring them back (29 Oct item 2). B-006. Optional line; Max will not miss what he never had.

---

# 5. PAGE 05: HOW TO REPORT A PROBLEM (10 changes)

Checked, no change needed: answer-first items 1, 2, 3, 5; section 3; section 6 item 1; form items 1 to 13.

1. **05-1 Header.** "DRAFT, Thu 22 Oct 2026." becomes "DRAFT, updated Thu 29 Oct 2026."

2. **05-2 Which route: CESUPPORT zip or CDFEEDBACK.**
   1. **Now:** answer first item 4: "The CE support zip: type `CESUPPORT`".
   2. **Proposed:** keep the zip as the main route, with the wording fixes in 05-4 and 05-5. Add CDFEEDBACK for a short note.
   3. **Evidence:** the gap plan's short page (section 5 items 4.8 and 5) tells Max to use CDFEEDBACK plus a Teams screenshot and **not** to use "the support bundle". Pack page 05 says use CESUPPORT. The two documents disagree.
   4. **Depends on:** Tim. See Approve item 3.

3. **05-3 Section 1 item 3, the Desktop folder name.**
   1. **Now:** "The zip is in a 'CE Support' folder on your Desktop. ... [CHECK: Desktop folder name on 3.0.70]"
   2. **Proposed:** keep; drop the [CHECK].
   3. **Evidence:** DAY1_FOR_TIM_2026-10-09 (seen on 3.0.40, W45); STAFF_HELP_2026-10-08 (seen on 3.0.37, W32); PILOT_CHECKLIST_2026-10-07. Not re-seen on 3.0.85.
   4. **Depends on:** nothing. **Resolved (mark 05a).**

4. **05-4 Section 1 item 4, the "drawing paths" claim. (UNCHECKED CLAIM)**
   1. **Now:** "Your login and PC name are coded inside. Drawing paths are cut back to job numbers."
   2. **Proposed:** "No login or PC name appears in the zip's file names or its index. What is written inside the log files has not been checked, so a log line can still hold a drawing name or path."
   3. **Evidence:** DAY1_FOR_TIM_2026-10-09 ("Codex did not open the log files themselves, so what is written inside the logs is NOT checked"). I found no file that checks the "job numbers" claim.
   4. **Depends on:** nothing. True now.

5. **05-5 Section 1 item 4, "never sends itself anywhere".**
   1. **Now:** "It never sends itself anywhere."
   2. **Proposed:** add the OneDrive sentence from 02-11.
   3. **Evidence:** BUG-482; DAY1_FOR_TIM_2026-10-09.
   4. **Depends on:** whether Max's Desktop is in OneDrive (not recorded).

6. **05-6 Section 2, finding the logs.**
   1. **Now:** "paste `%APPDATA%\CE_CVL_SUITE\logs` ... The Civil log is `CE_CVL_SUITE.log`. ... [CHECK: how the file rolls over each day]"
   2. **Proposed:** list **both** folders: `%APPDATA%\CE_CVL_SUITE\logs` and `%APPDATA%\TIM_CE_CADTOOLS\logs`; both hold a `CE_CVL_SUITE.log`. Add: "Send today's file and yesterday's."
   3. **Evidence:** ROLLBACK_GUIDE_2026-10-07 section 6 item 4 ("log locations ... not checked on 9 Oct"). The BUG-562 report names a dated file, `ce_cvl_structured_20261010.log`, so a per-day file exists; its folder is not recorded.
   4. **Depends on:** a look at the folders on 3.0.85. **Partly resolved (mark 05b).**

7. **05-7 Section 5 item 1, the pilot results folder.**
   1. **Now:** "[CHECK: Tim to confirm Max has write access; the desk cannot set this]"
   2. **Proposed:** keep until Tim shares the folder with Max ("can edit") and Max saves a test file in it.
   3. **Evidence:** page 06 question 11; `COLLEAGUE_READINESS_29OCT.md` section 4 item 5.
   4. **Depends on:** Tim sharing, Max confirming. **Unresolved (mark 05c).**

8. **05-8 Section 6 item 2, reply time.**
   1. **Now:** "[CHECK: Tim to set the expected reply time]"
   2. **Proposed:** "Same working day for anything that stops you; the weekly Monday session for the rest" (page 06 question 12 recommendation) once Tim says yes.
   3. **Evidence:** page 06 question 12 (open).
   4. **Depends on:** Tim. **Unresolved (mark 05d).**

9. **05-9 Add: when CDFEEDBACK says "saved on this PC".**
   1. **Now:** not on the page.
   2. **Proposed:** "If CDFEEDBACK says the report was 'saved on this PC', it did not reach the office. Put it in the pilot folder as in section 5."
   3. **Evidence:** `TEAM_AUDIT_T5` finding 2 and risk 5; BUG-1166 and BUG-1171 (no fix; depends on where Max's OneDrive puts "Creative Engineering - Drafting"); BUG-1215 (Help wording installed 3.0.76).
   4. **Depends on:** nothing.

10. **05-10 Add: a drawing that looks wrong.**
    1. **Now:** not on the page (page 01 says "Do not fix it by hand").
    2. **Proposed:** "If a drawing looks wrong, do not save over it. Close without saving and tell Tim the file name."
    3. **Evidence:** gap plan section 5 item 5.
    4. **Depends on:** nothing.

---

# 6. PAGE 06: THE 20 QUESTIONS (3 answered, 4 partly, 13 open)

1. **Q1 Who installs on 9 Nov, and when: OPEN.** Gap plan section 4 item 17 describes the day; Tim has not answered. (`COLLEAGUE_READINESS_29OCT.md` section 4 item 5.)
2. **Q2 Is Max on AutoCAD 2027: OPEN.** Nobody has looked.
3. **Q3 Max's old July Structural: OPEN.**
4. **Q4 Old Manager in Max's all-users folder: OPEN for Max's PC.** On Tim's PC he said "yes" to removing the stale Manager 1.0.0 (20 Oct item 14) and then parked it (item 16: "save the manager admin stuff for later"; not done, needs administrator rights).
5. **Q5 Where the frozen copy sits: OPEN.** Publishing; recommended `CE V3 PILOT` folder.
6. **Q6 Old install scripts in the IT Admin folder: OPEN.** Supporting fact: those scripts delete the old plugin folder with no backup (ROLLBACK_GUIDE_2026-10-07 section 7 item 1).
7. **Q7 Real jobs or copies only, and for how long: OPEN.**
8. **Q8 CDDESIGN, CDRUNSOLVE, CDTWL for drafting only: PARTLY.** The policy is unanswered. The reasons moved: pipe material now reaches the design (installed, not confirmed); the rainfall curve was left unchanged on 29 Oct ("leave them until you've checked the curve"), so the storage risk stands. File: `decisions\2026-10-29_TIM_ANSWERS.md` items 16 and 20.
9. **Q9 Tools switched OFF in the shipped set-up: PARTLY.** Tim's standing rule (17 Oct): a tool switches ON once Codex passes it. On 29 Oct: "names the pipe" switch ON (item 8, "yes"); grip, ROTATE and SCALE copy ON after a robot pass with it ON (item 9, "yes"). The Checks list, CDCHECKIGNORE, wrong-layer rows, Tidy labels itself and the double-click edit windows have no ruling for Max.
10. **Q10 F2 runs CLEAN: ANSWERED, with a new doubt.** Tim, 8 Oct (INT-069): "leave as is for now, commonly used by me to save" (`decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md` line 530). Doubt: it may be Tim's own key, not present on Max's PC (4A item 23).
11. **Q11 Can Max write to the pilot results folder: OPEN.**
12. **Q12 Reply time: OPEN.**
13. **Q13 Practice drawing: OPEN.**
14. **Q14 Rainfall note: PARTLY.** Tim, 29 Oct: "leave them until you've checked the curve." Curve not changed. No separate yes or no to the new wording; the desk builds it as a draft (B-016) and says so, so Tim can object (item 16).
15. **Q15 Cover: ANSWERED.** Tim, 29 Oct: "yes, add the pipe wall: about 20 mm for UPVC 225 and about 45 mm for concrete 375" (item 17). Wall thickness comes from Settings or pipe data, not hard-coded. B-012.
16. **Q16 Pit drop where the pipe gets bigger: ANSWERED.** Tim, 29 Oct: "yes" (item 18). Warn, never block. B-013.
17. **Q17 Minimum grade table: PARTLY.** Tim, 29 Oct: "review guidebook and save this guidebook in the memory of this plugin" (item 19). The Guidebook v1.3 decides; no number given; the review has not reported.
18. **Q18 Inspector versus CDRULES: OPEN.** (`COLLEAGUE_READINESS_29OCT.md` section 4 item 3: "not answered".)
19. **Q19 Format (printed 01 and 05): OPEN.**
20. **Q20 Screenshots: OPEN.** Recommended: Codex after the freeze.

Page 06 itself also needs updating: "Desk, Thu 22 Oct" header, the dates, and the "Desk readings recorded". Reading 1 follows Tim's 24 Sep rule (colleagues get his exact version and switches); that is why 01-3 and Approve item 5 matter.

---

# 7. MISSING ITEMS A FIRST-TIME COLLEAGUE NEEDS (no page covers them)

1. **How to tell the AutoCAD year.** Type `ABOUT`. Not the status bar. (02-3.)
2. **Check OneDrive is fully synced before the first start.** "Creative Engineering - Drafting", Standard Details and Drawing Templates must show as synced folders, not shortcuts. Otherwise CDFEEDBACK says "saved on this PC", CE Blocks and CDNEWDWG fail and job time goes to Max's own PC (BUG-1166, BUG-1168). Evidence: `TEAM_AUDIT_T5` findings 2 and 4. Put it on Tim's pre-install checklist.
3. **What to expect on first start.** The CE tab appears; a security prompt may appear; CE writes its settings files; `CEHEALTH` and `CE_VERSION` are the two checks. First-run tour: unproven (03-11).
4. **Drawing units.** Type `UNITS` and check Millimetres before using CE. A metre drawing needs hand checks (page 04).
5. **Do not hand pilot drawings to a colleague on an older CE.** Builds before 3.0.74 delete newer parts of CE's record when they save (BUG-1135).
6. **A copy of the old setup exists.** Max's old CE folders are renamed `_PRE_V3.backup`; do not delete them for the whole pilot.
7. **Job-time logging is on and cannot be switched off yet** (03-10).
8. **The support zip may upload itself if the Desktop is in OneDrive** (02-11).
9. **A day-one sit-down and daily check-in for the first week** (01-12). Source: gap plan section 4 item 17.
10. **No uninstall button.** The only route is renaming the CE folders (page 02 section 7). Source: BUG-888.
11. **Company Windows protection is unknown.** It could block an unsigned helper or the hand copy. Source: gap plan section 6 item 4. Add to the pre-install checklist.

---

# 8. THE 31 [CHECK] MARKS ON PAGES 01 TO 05

**Resolved from the files (10):**
1. **01a** versions: 3.0.85 / 1.1.85 today; final at the freeze.
2. **01c** DP prompts: from Codex look D7-01 on 3.0.78.
3. **01d** CDCHECKS: OFF by default.
4. **02f** update route changes before 9 Nov: no.
5. **02i** rename not delete: ROLLBACK_GUIDE section 7 item 4. Tim's nod not recorded.
6. **02l** mixed-version behaviour: an older CE is not safe to save a 3.0 drawing (BUG-1135).
7. **03b** CDCHECKS on in the shipped set-up: OFF.
8. **03c** Tidy labels on: OFF (inferred; see 03-6).
9. **03d** fresh install equals Tim's PC: not guaranteed (F-023).
10. **05a** Desktop folder name: "CE Support".

**Partly resolved (5):** **02g / 04c** start-up menu lines (cause read, clean PC not seen); **02j** MENULOAD name; **05b** log folders known, daily roll-over not recorded; **04a** "re-check every item against the frozen build": done on paper in section 4, but items marked "not re-checked" need AutoCAD.

**Unresolved (16), with who can answer:**
1. **Tim (6):** 01e practice drawing; 02b Structural folder; 02c where the frozen copy sits; 04b Inspector versus CDRULES; 05c share the pilot folder with Max; 05d reply time.
2. **Max (3):** 01b and 02a AutoCAD year; 03a his current Civil and Manager versions.
3. **Spare-login rehearsal (3):** 02d "Always Load" prompt; 02h a prompt on every start; 04d whether F2 does anything on a clean profile.
4. **Codex look (4):** 01f CDHELP section name (and the tour); 02e ribbon tab and panel names on 3.0.85; 02k whether Roll Back is hidden; 04e whether the Manager fault report codes names in 1.1.85.

The 25 Oct draft carries 45 [CHECK] marks of its own. Section 4 settles those the files answer. The rest are "still true on 3.0.85?" checks that need AutoCAD or a Codex look.

---

# 9. WHAT I DID NOT VERIFY

1. **No DLL version string was read.** "Installed" for each fix comes from `PILOT_CRITICAL_TEST_LIST_29OCT.md` (git ancestry on 09126560), the install queue and the train reports.
2. **Nothing was run.** No AutoCAD, no robot, no Codex, no build, no git.
3. **Whether each B-number is in the frozen build is unknown.** C-76 is assembling; C-77 holds nine jobs; B-009 waits for a robot pass; B-015 needs a rebase.
4. **The "still true" items** on page 04 (storm list, uphill label, RL 250, CDTWL, WSUD "indicative", suspect survey points, locked-layer Edit Pipe) were not re-checked. No file settles them.
5. **I did not read the 53-page guidebook, the BUG-488 code, the Manager window, or Max's PC.**
6. **Counts of changes** are mine: each numbered entry in sections 1, 2, 3 and 5 is one change; page 04 counts the 30 old items by verdict, 14 false statements and 11 new items.

---

# 10. APPROVE IN ONE PASS

Twelve yes/no decisions about **pack wording and handling**. Each carries a recommendation. None answers an open engineering question for you. Where one touches an open question, I say which stays open.

1. **Base page 04 on the 25 Oct draft, apply section 4, and delete its Structural section and desk-only appendix?**
   1. **Context:** the 25 Oct draft is newer and written in drafter's words; 14 of its statements are now false.
   2. **Recommend: yes.** One document to correct, not two. Structural does not ship (your 17 Oct ruling B3).
   3. **On a job:** Max reads one honest list in the order he works, not bug numbers.

2. **Adopt the "TRUE ONLY IF" rule?** Wording for each unbuilt item (B-001 to B-016) stays old unless the item is in the frozen build; at the freeze the desk reads the installed DLL commit and flips the wording item by item.
   1. **Context:** nine of your 29 Oct rulings are queued, not installed.
   2. **Recommend: yes.** A page that promises a fix Max does not have is worse than no promise.
   3. **On a job:** if the pit drop warning is not installed, Max is told to match pipe tops himself; if it is, he is told the warning exists.

3. **Keep CESUPPORT as Max's main report route, with the wording fixes (no "drawing paths" claim, add the OneDrive warning)?**
   1. **Context:** the gap plan's short page says "use CDFEEDBACK, not the support bundle"; pack page 05 says CESUPPORT. The zip was seen with clean file names on 3.0.40; log contents were never checked.
   2. **Recommend: yes.** It gives you the log; a screenshot alone often cannot show the cause.
   3. **On a job:** Max saves the zip in the pilot folder himself; he knows it may sync from his Desktop first.

4. **Tell Max in the pack that job-time logging writes his login, job numbers and (weekly) job addresses to the shared Drafting folder?**
   1. **Context:** he cannot switch it off yet (BUG-492); the policy question stays with you.
   2. **Recommend: yes.** He should hear it from the pack, not find it.
   3. **On a job:** no change to his work; he knows what is recorded.

5. **Give Max your switch values by a colleague settings file (your folder paths blanked), made at the freeze, as your 24 Sep rule says; and if it is not ready by Fri 6 Nov, start him on CE's built-in values and say so on page 01?**
   1. **Context:** no approved export exists (F-023). The first-start behaviour of a copied file is not proved (BUG-1167).
   2. **Recommend: yes.** It follows your rule and has a safe fallback. Copying your own file as it stands is not offered.
   3. **On a job:** Max's tools behave as yours do; or he knows a few may differ.

6. **Rewrite page 01 "it never stops you" to list the three things CE refuses (locked layer, clashing pit number, floor waste on an inspection opening)?**
   1. **Context:** the current line says only two things are blocked and he will not meet them.
   2. **Recommend: yes.** He will meet all three in week one.
   3. **On a job:** a refusal does not look like a fault.

7. **Change the install time from "about 5 minutes" to "about 20 minutes", until the rehearsal measures it?**
   1. **Context:** 5, 10 and 20 minutes are all written; none was measured.
   2. **Recommend: yes.** Over-promising on day one costs Max's morning.
   3. **On a job:** Max books the time; the install does not feel rushed.

8. **Replace "Your drawings are safe either way" with the rollback warning (do not save a 3.0 drawing with the old version)?**
   1. **Context:** BUG-1135: an older CE deletes the newer parts of a drawing's record on save.
   2. **Recommend: yes.** This is the one statement that could lose work.
   3. **On a job:** if Max rolls back, he opens his 3.0 drawings to look, does not save them, and calls you.

9. **Change the first-10-minutes pipe levels to 18.000 and 17.880, add "type both levels yourself", and run that script once on a test copy of the frozen build before the pack goes out?**
   1. **Context:** the current levels give exactly 1 in 200, where a wrong-wording warning appears (BUG-1235); the window can also switch Pipe grade on its own (BUG-1233).
   2. **Recommend: yes.** His first pipe should not show a warning that contradicts itself.
   3. **On a job:** the practice run looks right on the page and on the screen.

10. **Keep the Checks list (CDCHECKS) and Tidy labels OFF for Max until a Codex look passes each, per your standing rule (switch ON after a Codex pass), and take CDCHECKS out of the 10 commands?**
   1. **Context:** both are OFF now; no Codex look of the Checks rows is recorded. Your 29 Oct "yes" was for the "names the pipe" switch, not Tidy labels itself. Q9 on page 06 stays partly open.
   2. **Recommend: yes.** Confirms your existing rule; nothing new is switched off.
   3. **On a job:** Max uses `CDRULES` for checks and moves labels by hand.

11. **Reword the F2 line as "On Tim's PC F2 runs a CLEAN command; if yours does too, save with Ctrl+S", until a look at a clean login shows what F2 does there?**
   1. **Context:** you chose to keep F2 on 8 Oct; Codex described it as your own macro on 13 Oct, so it may not exist on Max's PC.
   2. **Recommend: yes.** It is true on both PCs.
   3. **On a job:** Max is not told a key does something it may not do.

12. **Add to page 02: copy only from the frozen folder on a USB stick or the pilot folder (never an emailed or Teams zip), the desk reads back every SHA-256 against the frozen list, and the old-copy check covers Program Files as well as ProgramData?**
   1. **Context:** a downloaded zip can block a helper (T5 finding 12); the package is not sealed to the tested files (BUG-885); Civil searches both folders for pit blocks.
   2. **Recommend: yes.** It matches the verify-after-deploy rule in AGENTS.md.
   3. **On a job:** what Max runs is exactly what was tested.
