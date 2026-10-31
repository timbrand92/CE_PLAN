# Codex brief: eleven window bugs as card batches (Tim decision 180)

Written by CE 05, Sat 31 Oct 2026. Tim's word (voice batch 6, decision 180, "yes"): the 11 window bugs go to Codex as card batches, Codex does them, Tim approves wording only. Windows stay Codex-owned.

## NAME THIS CHAT
CE_ACAD / civil-windows / build / 01

## How to work
1. Group the eleven into three or four card batches by window (below). One card per window, in drafter terms, before any code (the command review gate in the plugin repo's AGENTS.md).
2. Tim approves the wording only. Anything that changes a control or layout is shown to him as a picture.
3. Draft PRs only. Base `origin/claude/rel-20261102a` (Civil 3.0.88 / Manager 1.1.88). Ask CE 01 for a B number before each PR.
4. No hard blocks (R-27). Plain English on screen. Never put a code word in front of a drafter. Settings-owned values.
5. Nothing is built yet. Source: `C:\CE_PLAN\areas\NEXT_TRANCHE_31OCT.md`, section C3, and the carpark entries.

## The eleven
1. **Pit Schedule window:** BUG-213, Placement for an older schedule has no enabled Replace button (window change, plus Tim's wording).
2. **Manager Settings, Civil form:** BUG-222, the form scrolls, which breaks Tim's no-scroll rule (a regroup).
3. **Manager Help:** BUG-581, "Start tool" minimises without launching its prompts.
4. **Remember window position:** BUG-958, Edit Pipe, Edit Pit, New Pit and CDS ignore it. BUG-959, Civil Hub reopens on the primary screen, not the second monitor. BUG-1208, a second AutoCAD can erase the other one's saved position (window store, off by default). These three share the window-position code.
5. **CDCALC:** BUG-1033, the Pump System tab is read-only but shows no banner. BUG-1217, Calculations Help invites input to the read-only Pump System and WSUD tabs.
6. **AutoCAD 2022 to 2024 lane:** BUG-1210, Edit Pipe and Edit Pit lose the plan picture and click selection (window controls compiled out). Parked until after the pilot (decision 181) but stays open.
7. **Survey Intake review:** BUG-1248, written in survey-software words (XREF, sha256, TIN triangles); needs plain English.
8. **CDCHECKDWG:** BUG-1254, the results list cuts off its last row; CE 00's analysis says probably no fault, so look first.

## Proof Tim wants
A screenshot of each changed window and the exact click steps. The robot or Codex runs the steps on a copy of a test drawing (made-up data, no client drawings).

## Open
No cards written yet. Check each entry against the current build first; some may already be overtaken.

## Added 31 Oct 18:35 (from job n1, BUG-540 follow-up; CE 04 says this is not a Tim question)
9. **Step-iron depth box on the Settings page.** The step-iron depth is already read from one Settings value by the Pit Schedule remark, pit size advice, CDRULES and the refresh, but the Settings page has no box for it. Recommendation: put it beside the other pit depth figures on the pit and cover tab (the page is at its height limit, so this may belong on the new "Switches" tab; see CODEX_BRIEF_SWITCHES_TAB_31OCT.md). Tim sees one picture. Needs a B number from CE 01.
