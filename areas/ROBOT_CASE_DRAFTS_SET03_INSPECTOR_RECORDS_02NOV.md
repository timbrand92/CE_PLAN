# Robot case drafts, SET 03: Inspector and saved drawing record (Mon 2 Nov 2026, Melbourne, read-only drafter, Sonnet)

Fixes covered: #1880 (BUG-1240), #1951 (BUG-1265), #1953 (BUG-1263), #1955 (BUG-1264), #1958 (BUG-1266). Latest Civil/Manager line read: `origin/claude/rel-20261102a` (3fbb9da5). The five PR branches are `origin/fb/bug1240-...`, `bug1265-...`, `bug1263-...`, `bug1264-...`, `bug1266-...`.

---

## FOR TIM

1. **Drafted: 2 robot cases, each with a deliberately wrong twin (4 case texts).** W1880 (the Inspector goes to the list saved in the drawing) and W1958 (an unreadable saved list is logged once, not on every pick). Both are PART claims.
2. **How they prove it.** The robot cannot read the Inspector window (it is not on the driver's read list), so it reads CE's log instead. It damages the saved list in the open copy (the same damage SETUP-DMG-PITLIST makes for #1952), picks pits, and counts the line "The pit and pipe list saved in this drawing could not be read". Each twin turns the PR's own switch OFF before AutoCAD starts.
3. **Codex-only (2 fixes):** #1953 (needs two drawings and a save CE could not make) and #1955 (needs two drawings and an Undo). Exact Codex steps are below.
4. **No case for #1951.** It is a code tidy with no new switch and no change on the drawing, so there is nothing to turn off and no red twin is possible. W1880 exercises the Inspector side of it. The CDCHECK side was not drafted.
5. **Opus review before running:** the Codex look for #1955 (Undo). Neither robot case uses Undo, REDO, a locked layer or an Xref. Both do one write inside the open copy to damage the saved list, which is the same step the already-drafted #1952 and #1892 cases use.
6. **Not proven:** nothing was run, built or opened. The window lines and every log word below come from the PR text and source, not from a run. Whether picking by the robot's `pick-first` makes the Inspector refresh is not known: if the first run shows no line at all, the fallback is a real-mouse pick.
7. **Nothing for you to decide or test.** These go to CE 05 for validation, then the robot after the next install, then an Opus review.

---

## What I read, built and tested

1. **Read:** `C:\TimOS\RULES.md`; `README_CASES.md` and the v3 allow-list; the finished examples `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (header and twin style); `R09s_new_switch_off_broken` and `R08` (switch-off twin and pick style); `SETUP-DMG-PITLIST` and `SETUP-DMG-LINKS`, plus the drafts `W1952` (the model for a damaged record); the five PR descriptions and diffs (#1880 in full; the others through `gh pr view`); the `REGRESSION_LOG.md` entries on the PR branches; `Services/InspectorPaletteService.cs` and `ProjectDataService.KeptRecords.cs` on the branches.
2. **Checked again on the second pass (Mon 2 Nov, afternoon):** the carpark entries for BUG-1240 and BUG-1263 to BUG-1266 DO exist in `C:\CE_PLAN\BUG_CARPARK.md` (the first pass said they did not; that was wrong). They agree with the PRs. The carpark note for BUG-1240 says the robot case the desk expects is "N39_inspector_reopen with control C39 (switch false)"; no such case exists, so W1880 is it. No `BUGFIX_*` file names these bugs. `ledger.json` was searched as text only. **Fixed on this pass:** the first draft used a step `v3 ui-windows`, which is not on the driver's verb list (it is not in the allow-list file or README_CASES.md); it is now `windows-snapshot`, which is. Checked the CE log line text on both the #1880 and #1958 branches (it is the same wording, in `InspectorPaletteService.cs`). The CE Inspector is not in the allow-list's window list (confirmed), so it cannot be read.
3. **Existing case check, redone:** a text search of the cases folder (including every `drafts_*` folder and `_setups`), the four earlier ROBOT_CASE_DRAFTS files and `ledger.json` for these PR numbers and bug numbers found nothing relevant (only chance matches such as 0.1955). The names the PRs propose (N39_inspector_reopen, N13c, N13a) do not exist. So no fix here is skipped for already having a case.
4. **Built:** nothing. **Tested:** nothing. Nothing was run in AutoCAD and no case was validated. **No git write**, no push, no setting file touched.

---

## How the drafts were written

1. **Format:** the README format. Every `type` chain is a complete command, no `(`, no SAVE-type word. These two cases need no `type` at all. Twins carry `VARIANT_OF` and `EXPECT-FAIL BROKEN-VARIANT`. `REVIEWED_AGAINST` is empty.
2. **Fixture and setup:** `DRV1_B1`, `SLOT fresh`, `SETUP SETUP-DMG-PITLIST` (already in the `_setups` folder). Orders 720 to 723.
3. **Settings:** set only through `SETTING CD_Settings.json <key> <value>`, so the guard sets them before AutoCAD starts and puts them back by hash. Do not use `hashes-unchanged`. Never read or write Tim's real settings by hand.
4. **Handles used:** pit P3 is `109D56` and pipe P3 is `10A98D` (both from existing accepted cases on DRV1_B1).
5. **DERIVED marks:** any printed line or window word taken from the PR text or source and not seen on a run is marked DERIVED in the case.
6. **Important order rule:** no CE command may run between the damage setup and the picks. A CE command puts a pit list in memory and the Inspector would then use that list and never read the saved one.
7. **Safe by design:** no U or REDO, no locked layer, no Xref, no protection bypassed. The only write is the one damage step inside the open copy; the copy on disk stays the master (CE never saves).

---

## The cases

### Case 1: W1880, the Inspector goes to the saved list when CE holds none (PART of #1880)

**Intended file:** `W1880_inspector_reads_saved_list_log.case.txt`

```
# W1880 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1880 (B-059, BUG-1240), branch fb/bug1240-inspector-reads-saved-record.
# What the fix does: when CE holds no pit and pipe list for the open drawing, the Inspector reads the list saved in the drawing (read only). If that read fails it writes ONE line '[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown.' (Services/InspectorPaletteService.cs, LoggingService.Warning; DERIVED from the PR diff, not seen on a run).
# How this case proves the route without reading the Inspector window (it is not on the driver's read list): SETUP-DMG-PITLIST damages the saved list, then pit P3 is picked. With the switch ON the Inspector tries the saved list, fails, and writes the line. With the switch OFF it never tries the saved list, so the line is absent (twin).
# NOTHING CE runs between the setup and the pick: a CE command would put a list in memory and the Inspector would use that list instead. The picks use v2 pick-first; whether that makes the Inspector refresh is DERIVED from UI_MAP_2026-10-03 item 64 ('selecting with the pickfirst helper is enough'), not seen on a run.
CASE W1880
TITLE With no pit list in memory the Inspector reads the list saved in the drawing: a damaged saved list gives its one 'could not be read' log line on a pit pick
PLAN_ITEM PR #1880 BUG-1240 PART: the Inspector goes to the saved list when none is in memory (proved through the log line on a damaged list). NOT whole: that a healthy saved list then shows the real number and levels instead of Unknown is a window reading the robot cannot do (see NOT_AUTOMATED)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-DMG-PITLIST
ORDER 720
TIMEOUT 900
BUG
PROVES_BUGS
SETTING CD_Settings.json linking.inspectorReadsSavedRecordWhenNotLoaded true
REVIEWED_AGAINST
EXPECTED After the saved list is damaged and pit P3 is picked, CE's log holds the line '[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown.' at least once. The setup readback shows the damage word DMGBROKEN2A4.
WHY_NOT_UNIT_TEST The unit tests pin the choice (live, saved, none) and the source; only a real reopened drawing shows the Inspector actually reaches for the saved list when a pick happens.
NOT_AUTOMATED The healthy case, which is the point of the fix for a drafter: after Save As or reopen, pick pit P3 and the Inspector shows Number P3 and a Cover level instead of 'This pit is not in CE's recorded project data yet. Values below are Unknown'. The Inspector window is not on the v3 read list, so this is a Codex look (look A below).
NOT_AUTOMATED The 'Open existing' button, which still needs the list in memory.
STEPS
  windows-snapshot -> $win0
  pick-first "109D56"
  sleep 6
  v3 deselect
  sleep 4
  log-read civil -> $civlog
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil has "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown."
  record $win0 "windows listed at the start (is the CE Inspector palette among them?)"
  record $civlog "FULL civil log lines since the case began"
```

**Twin:** `W1880_BROKEN.case.txt` (place in the variants folder)

```
# W1880_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Switch-off twin of W1880: linking.inspectorReadsSavedRecordWhenNotLoaded false before AutoCAD starts, so the Inspector reads only CE's own list and never goes to the saved one. Same route and checks as W1880. It must FAIL on the 'could not be read' line (absent, because the saved list is never read). The damage readback check still PASSES, which proves the setup ran.
CASE W1880_BROKEN
TITLE BROKEN VARIANT of W1880: switch inspectorReadsSavedRecordWhenNotLoaded OFF, so the Inspector never reads the saved list (must FAIL)
PLAN_ITEM red-before-green proof for W1880 (BUG-1240)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-DMG-PITLIST
ORDER 721
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1880
SETTING CD_Settings.json linking.inspectorReadsSavedRecordWhenNotLoaded false
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the switch OFF the line '[Inspector] The pit and pipe list saved in this drawing could not be read ...' never appears, so the check on it fails.
WHY_NOT_UNIT_TEST It exists only to prove W1880's main check can go red.
STEPS
  windows-snapshot -> $win0
  pick-first "109D56"
  sleep 6
  v3 deselect
  sleep 4
  log-read civil -> $civlog
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil has "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown."
  record $civlog "FULL civil log lines since the case began"
```

---

### Case 2: W1958, an unreadable saved list is logged once per drawing (PART of #1958)

**Intended file:** `W1958_inspector_unreadable_logged_once.case.txt`

```
# W1958 DRAFT (read-only drafter, Sonnet, Mon 2 Nov 2026; NOT RUN, NOT REVIEWED). PR #1958 (B-127, BUG-1266), branch fb/bug1266-inspector-unreadable-record-once, stacked on #1955, #1953, #1951, #1880.
# The fix: with linking.inspectorUnreadableRecordLoggedOnce ON (default), a saved list that failed to read is noted for that drawing; the next picks and refreshes skip the read and write nothing. OFF: the read is tried and the line written on every pick (PR text; DERIVED).
# This case damages the saved list (SETUP-DMG-PITLIST), then picks pit, pipe, pit again with a deselect between each, so there are at least three refreshes. Right: the Inspector line appears exactly once. The twin turns the once-switch OFF: the line must appear more than once, so 'count = 1' fails.
# The warning text is from InspectorPaletteService.cs on the #1958 branch line 978 (DERIVED, not seen on a run). The failed read's own error line is NOT asserted: its exact wording was not read.
# The reads switch (#1880) stays ON, because the once-note only matters when the saved list is read.
CASE W1958
TITLE An unreadable saved pit and pipe list gives ONE 'could not be read' Inspector line over three picks, not one per pick
PLAN_ITEM PR #1958 BUG-1266 PART: the log noise half (one line per drawing). NOT whole: that the Inspector stops re-reading the list on every pick (a speed result) and that a Save As reads once more (a path change) are not read; neither is visible on the drawing
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-DMG-PITLIST
ORDER 722
TIMEOUT 900
BUG
PROVES_BUGS
SETTING CD_Settings.json linking.inspectorReadsSavedRecordWhenNotLoaded true
SETTING CD_Settings.json linking.inspectorUnreadableRecordLoggedOnce true
REVIEWED_AGAINST
EXPECTED After the saved list is damaged and three picks (pit 109D56, pipe 10A98D, pit 109D56, each followed by a deselect), CE's log holds the line '[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown.' exactly once.
WHY_NOT_UNIT_TEST The unit test counts reads through a fake; only AutoCAD shows how many times a real pick and deselect cause a refresh and a log line.
NOT_AUTOMATED That values still show Unknown on the drawing: the Inspector window is not on the v3 read list.
NOT_AUTOMATED A drawing whose list is a NEWER CE's genuine record, and Save As reading once more: not driven.
NOT_AUTOMATED If the first run shows ZERO lines, the robot's pick did not make the Inspector refresh: change the picks to a real-mouse click (v3 pt-click) and record that in the report. Do not loosen the count check.
STEPS
  windows-snapshot -> $win0
  pick-first "109D56"
  sleep 6
  v3 deselect
  sleep 6
  pick-first "10A98D"
  sleep 6
  v3 deselect
  sleep 6
  pick-first "109D56"
  sleep 6
  v3 deselect
  sleep 4
  log-read civil -> $civlog
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil has "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown."
  log civil count "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown." = 1
  record $win0 "windows listed at the start (is the CE Inspector palette among them?)"
  record $civlog "FULL civil log lines since the case began"
```

**Twin:** `W1958_BROKEN.case.txt` (place in the variants folder)

```
# W1958_BROKEN DRAFT (Mon 2 Nov 2026; NOT RUN). Switch-off twin of W1958: linking.inspectorUnreadableRecordLoggedOnce false before AutoCAD starts, so every pick and deselect tries the read again and writes the line. Same route and checks. It must FAIL on 'count = 1' (the line appears more than once, DERIVED from the PR: 'two lines on every pick'). The 'has' check still PASSES, which proves the picks reached the Inspector.
CASE W1958_BROKEN
TITLE BROKEN VARIANT of W1958: switch inspectorUnreadableRecordLoggedOnce OFF, so the line is written on every pick (must FAIL)
PLAN_ITEM red-before-green proof for W1958 (BUG-1266)
KIND deterministic
FIXTURE DRV1_B1
SLOT fresh
SETUP SETUP-DMG-PITLIST
ORDER 723
TIMEOUT 900
BUG
EXPECT-FAIL BROKEN-VARIANT
VARIANT_OF W1958
SETTING CD_Settings.json linking.inspectorReadsSavedRecordWhenNotLoaded true
SETTING CD_Settings.json linking.inspectorUnreadableRecordLoggedOnce false
REVIEWED_AGAINST
EXPECTED Wrong on purpose: with the once-switch OFF the Inspector line appears on every pick, so 'exactly once' fails.
WHY_NOT_UNIT_TEST It exists only to prove W1958's count check can go red.
STEPS
  windows-snapshot -> $win0
  pick-first "109D56"
  sleep 6
  v3 deselect
  sleep 6
  pick-first "10A98D"
  sleep 6
  v3 deselect
  sleep 6
  pick-first "109D56"
  sleep 6
  v3 deselect
  sleep 4
  log-read civil -> $civlog
ASSERT
  contains $dmg_pitlist_after "DMGBROKEN2A4"
  log civil has "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown."
  log civil count "[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown." = 1
  record $civlog "FULL civil log lines since the case began"
```

---

## Codex looks

### Look A: #1880 (and #1951), healthy list after reopen (what a drafter sees)

BLOCKED-FOR-ROBOT: the Inspector window is not on the driver's read list, so the real Inspector values cannot be read. W1880 covers only the route.

1. **Setup:** copy DRV1_B1 to `C:\CE_WORK\codex\w1880_look_02nov\` and work on the copy only. Set `linking.inspectorReadsSavedRecordWhenNotLoaded` through the settings guard before launching (the desk does this; do not hand-edit Tim's settings file). Default is ON.
2. **Steps:** open the copy, run no CE command at all, click pit P3 on the plan, look at the CE Inspector (it follows within about 4 s). Close without saving, reopen, pick P3 again as the first thing.
3. **Right looks like:** Number P3 and a Cover level and Invert level, not "This pit is not in CE's recorded project data yet. Values below are Unknown". CE never saves here, so the copy on disk is unchanged.
4. **Control:** with the switch false (set by the desk through the guard before AutoCAD starts) the same steps must show the Unknown text. That is the red.
5. **Evidence:** screenshot of the Inspector after each pick, saved in the folder above; never accept or capture a folder the box opened in.
6. **Also check (for #1951):** with a healthy list and no CE command run, type CDCHECK on the reopened copy and confirm it reads the saved list the same way (it reports pit and pipe results, not an empty drawing). Same evidence folder.

### Look B: #1953 (BUG-1263), BLOCKED-FOR-ROBOT

Why: needs two open drawings and a CE save that could not reach its drawing (kept for later). A case cannot open a second drawing, and the PR names no trigger the robot can make ("a read-only file, a busy drawing" is from the PR text; how to make CE keep a save was not verified).

1. **Before Codex starts:** CE 04 (via CE 05) must give the exact way to make CE keep a save for drawing A. If nobody can, Codex reports BLOCKED, not PASS, after 10 minutes of trying.
2. **Setup:** copies of two job drawings A and B in `C:\CE_WORK\codex\w1953_look_02nov\`. Both open. Switch `linking.inspectorShowsRecordWaitingToSave` ON (default).
3. **Steps:** in A, change one pit value with a CE command, with A's save made to fail as agreed in step 1. Switch to B and run any CE command there. Switch back to A and pick the changed pit without running a CE command.
4. **Right looks like:** the Inspector shows the NEW value CE is holding, not A's older saved value.
5. **Control:** switch false (set before AutoCAD starts, through the guard) must show the older saved value.
6. **Evidence:** screenshot of the Inspector in A before and after, plus the CE log, in the folder above.

### Look C: #1955 (BUG-1264), BLOCKED-FOR-ROBOT, OPUS REVIEW BEFORE IT IS RUN (it uses Undo)

Why: needs two open drawings and an Undo in the first one.

1. **Setup:** two copies in `C:\CE_WORK\codex\w1955_look_02nov\`: drawing A with NO CE record yet (a drawing that has never had a CE command; no such fixture is named in the repo, so the desk must name one) and drawing B with a CE record. Both open. Switch `linking.undoRemembersEachDrawingsRecord` ON (default).
2. **Steps:** in A, run one CE command that saves its first pit list into A (for example place one new pit). Switch to B and pick a pit there (the Inspector reads B's saved list). Switch back to A and press Undo until the new pit is gone (the CE command line says what U undid; take no other action between U presses). Pick in A, or run CDCHECK there.
3. **Right looks like:** the Inspector for A no longer lists the pit that Undo removed (CE's pit list for A was cleared to match the drawing). Then press REDO once: the pit comes back and REDO works (it must not say "Nothing to redo").
4. **Control:** with the switch false before AutoCAD starts, the Inspector can still list the removed pit. That is the red.
5. **Evidence:** screenshots after the pick in B, after the Undo in A, and after the REDO, plus the command-line text, saved in the folder above. Never accept or capture a folder the box opened in.

---

## Fixes skipped, and why

1. **#1951 (BUG-1265):** a tidy of existing code: one shared rule, no new switch, no change on the drawing ("What a drafter sees: nothing different"). With nothing to turn off there is no red twin. The Inspector side is exercised by W1880 and Look A; the CDCHECK side by an existing CDCHECK-after-reopen case, if the desk has one (not checked here).
2. **#1953 and #1955:** Codex-only, as above. Neither can be a robot case today (second drawing needed).

## What is NOT proven

1. Nothing was run. The log line, its exact wording, the Civil log being the file that holds it, and the Inspector refreshing on a `pick-first` are all taken from the PR text and source (DERIVED). Expect one or two fix-ups on the first run.
2. W1880 and W1958 prove the route and the log noise only. Whether a healthy list shows the right numbers in the Inspector window is not proven by any robot case; Look A is the only check of that.
3. That the damaged-list setup makes the Inspector's read fail (rather than a different path) is taken from the #1952 and #1892 drafts' own claim; their first runs have not happened either.
