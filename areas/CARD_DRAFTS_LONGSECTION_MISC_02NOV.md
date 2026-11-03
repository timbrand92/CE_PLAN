# Card drafts 10 of 15: long section, Xref source, twin detention pipe, spot level wording

Written Mon 2 Nov 2026 (Melbourne) by Sonnet (Team), read-only, for CE 05 at CE 00's request. Nothing in this file is approved. No code was changed, built or run. No AutoCAD was opened.

## FOR TIM

1. **Five cards below, one per command.** Long section curved boundary (#1938), long section survey-layer levels (#1939), Pit Schedule "SOURCE RECREATED" (#1937), twin detention pipe refused upgrade (#1950), Spot Level and Trench Grate Audit wording (#1974). Each is headed "DRAFT FOR TIM: nothing is approved".
2. **Where the work sits.** Not one of the five is on `claude/rel-20261102a` (the line was checked: none of the five switch names or the new wording file is there). #1950 is on the C-79b1 branch `claude/rel-20261108a` and later. #1937, #1938, #1939 and #1974 are on the C-79b2 branch `claude/rel-20261110a` (final head d4ce878e) and on the later `claude/rel-20261112a` (C-79c). They are not on `claude/rel-20261106a` (C-79a).
3. **Nothing could not be pinned down**, with two small gaps. I could not read what the Pit Schedule badge looks like on screen (only its words). And "when the twin upgrade runs" is a guess in places (card 4, field 2).
4. **Xref, locked layer and REFEDIT, plainly.** No path in #1937, #1938 or #1939 writes to an Xref, a locked layer or a REFEDIT object: they read only. #1950 writes to the twin pipe's own main line (a CE pipe, not an Xref), and the upgrade refuses a pipe on a locked layer before it changes anything. #1974's CDSL writes only the spot level block on its usual layer and stops if that layer is locked; CDTRENCHGRATEAUDIT reads one drawing from the bundle and writes only a text report in the Windows temp folder.
5. **Questions that need you (three).** Which words count as survey layers for the long section (card 2: add KERB, INV, FFL, FSL to the "not survey" list?). Whether a curve CE cannot follow (old-style 2D polyline with arcs, spline, ellipse) should print a warning (card 1). Whether CDHELP's leftover "C:\Lisp Files\SUPERSEDED" line and the saved-computations default folder "C:\Lisp Files\Computations" should be filed as their own bugs (card 5).
6. **What was read:** the build register, the C-79b PR lists, the C-79b2 assembly and finalizer reports, the Opus pre-reviews (W, AD, RECHECK), the carpark entries for BUG-1193, 765, 1155, 1152 and 1175, the older family cards, and the code on `claude/rel-20261112a` (which contains all five PRs). I did not read the PR text on GitHub (no `gh` on this tool's path); PR facts come from the register and reports.
7. **Built, Tested, Installed, Tim-accepted, for all five:** built yes (authors, assemblers, finalizer: net10 and net48 compile). Unit-tested yes (the finalizer's focused run: 2,909 tests, 0 failed, across the whole b2 train). Installed: no for #1937 to #1939 and #1974 (C-79b2 is not installed); #1950 is in C-79b1 (Civil 3.0.90), which another card says is built but not installed. I did not read the installed DLL. Tim-accepted: no. Opened in AutoCAD by anyone: no.
8. **All five bugs stay OPEN** in the carpark. A green build or an install does not fix them.

---

## CARD 1 of 5: long section follows a curved property boundary (#1938)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Long section (CDPROFILE) boundary mark: when the property boundary in the survey Xref is curved, the mark on the section sits where the curve really crosses the pipe, not where a straight chord would.
2. **Ribbon or trigger.** Typed command `CDPROFILE`. Ribbon: tab "CE", panel "Review", button "Profile" ("Draw a longitudinal section.") on the default layout; on the classic layout the tab is "CE Civil", panel "Output", flyout "Design Review", button "Longitudinal Profile". Also reachable from the CDCALC Calculations window (Longitudinal page) and from the Civil Hub. (Read from `CeCvlRibbonContributor.cs` and `CeCvlClassicRibbonLayout.cs` on rel-20261112a.)
3. **Works today** (Keep would protect). Pick a starting pit; CE lists the reachable routes; you choose the route, scales and insertion point; Preview, then Apply writes one linked profile block. A straight boundary polyline in the survey Xref (layer "BOUNDARY" or "A-TITLE BOUNDARY", with or without an Xref prefix) already gives a boundary mark at the right chainage. With the bulge set to 0 the answer is unchanged (5.00 m in the carpark example).
4. **What the train or PR changes.** PR #1938 (B-122, BUG-1193, head 87104a99), in C-79b2. Polyline sides with a bulge, and ARC entities on the boundary layer, are followed in straight pieces of 5 degrees or less. Switch `survey.longSectionBoundaryFollowsCurves`, ships ON; OFF reads every bulge as 0 and skips ARCs, which is the old reading exactly. The switch is read at each CDPROFILE.
5. **Suggested class: Modify.** The workflow is kept; one input (curved boundaries) is corrected. Suggestion only.
6. **Prompts and windows.** `Select starting CE pit for profile review: ` (reject message "Select a CE pit block."), then the existing Calculations window on the Longitudinal Review page. No new prompt or window. The change adds no warning line for curves CE cannot follow (see field 18).
7. **Selection.** One CE pit block, or one pit already selected before typing the command. The boundary is read from the survey Xref, not selected.
8. **Preview.** The existing Preview New / Preview Update in the window. The boundary mark shows on the section preview. Nothing new was built for the curve.
9. **Drawing output.** The profile block on the section, with the boundary mark at the crossing. Read-only on the survey: the finalizer pinned the two new members as read-only and the pre-review found no write, regen, view or system variable change. **Xref, locked layer, REFEDIT: no path writes to any of them.** The profile write itself is the existing atomic writer, which per the older card CV-06 refuses a locked layer, Xref or REFEDIT target before its first write (that wording is from the older card; I did not re-read the writer on this line).
10. **Cancel, Escape, Undo and Redo.** Escape at the pit prompt returns with nothing changed (code reads: `if (selection.Status != PromptStatus.OK) return;`). Apply is the existing one-Undo write. The change adds no event hook, transaction or command string (finalizer REDO scan: only an arithmetic `sweep += 2.0 * Math.PI`). Not tested in AutoCAD.
11. **Save and reopen.** No new saved data. The setting is in the Settings file.
12. **Assets, data and Settings.** Reads the survey Xref's boundary polyline or arc. Setting: `survey.longSectionBoundaryFollowsCurves` (ON). Maths in `Helpers/LongSectionBoundaryProjector.cs`; reader in `ViewModels/LongitudinalSectionViewModel.cs`. The 5-degree step is a drawing tolerance, copied from how pipe arcs are already stepped, not an engineering value.
13. **Performance.** Not measured. A long arc becomes about 36 pieces per half-turn at most (GUESS from 180 / 5); the crossing code is the existing one.
14. **Discovery.** Ribbon button above; command line `CDPROFILE`; help link `https://help.creativeeng.com.au/ce-cvl-suite/commands/cdprofile` (from the registry). No help text mentions curved boundaries (not checked in the page itself).
15. **Example drawing and expected result.** From BUG-1193: a survey Xref with an open BOUNDARY polyline from (5000,-5000) to (5000,5000), first bulge +1 (a half-circle), and a pipe along y = 0 starting at P1 (0,0), horizontal scale 1:100. Expected: the boundary mark sits 10.00 m from P1. With bulge 0 (or the switch OFF) it sits at 5.00 m. On a job: a curved lot frontage shows its mark in the right place.
16. **Older family card.** `docs/CARDS/CV-06_PROFILE_REVIEW_UI.md`, `CV-06_PROFILE_ATOMIC_WRITER.md`, `docs/workflows/C4_CDPROFILE_CAPTURE_ADAPTER_2026-09-10.md` and `C4_CDPROFILE_EXACT_ROUTE_REVIEW_2026-09-10.md`. They describe the pit pick, route choice, Preview and the atomic writer, and say boundary display is captured, but they say nothing about arcs or bulges; the capture adapter card says a chord is never used for pipe lengths, yet the boundary was read as a chord. They also say native AutoCAD acceptance is pending, which is still true.
17. **Tim's AutoCAD checklist.** (On a copy of a drawing; AutoCAD 2027 with the C-79b2 build installed, which has not happened.)
    1. Make a survey Xref drawing with a polyline on layer BOUNDARY from (5000,-5000) to (5000,5000) and set its first bulge to 1. Attach it to a drawing with a CE pit at 0,0 and one CE pipe along the X axis.
    2. Type `CDPROFILE`, pick the pit, choose the route, set 1:100 horizontal, pick an insertion point, Preview New.
    3. Look at the boundary mark: it should read 10.00 m from the first pit.
    4. Redraw the same boundary as an ARC and repeat: same 10.00 m.
    5. Set `survey.longSectionBoundaryFollowsCurves` to false in the Settings file before AutoCAD starts and repeat: it should read 5.00 m (the old answer).
    6. Mirror the Xref (the pre-review flagged a mirrored boundary as untested) and check the mark is still on the pipe's side of the curve.
    7. Press Escape at the pit prompt: nothing is added.
18. **Questions only Tim can answer.**
    1. **Curves CE cannot follow.** Context: the carpark said "if a curve cannot be resolved, warn and leave that mark unresolved". I understand an old-style 2D polyline with arcs, a spline or an ellipse is still read straight (2D polyline) or skipped (spline, ellipse), with no warning. Recommendation: add one warning line, because a quiet straight mark from a curve is the exact fault BUG-1193 describes. On a job: without the line, a spline lot boundary shows no mark and nobody knows why. Your answer decides whether this is added to #1938 or filed as its own bug. I have not decided it.
19. **NOT proven.** Built: yes. Tested: yes (pure maths tests and a source-text guard; nothing ran the AutoCAD reader). Installed: no. Tim-accepted: no. Nobody has done the installed, AutoCAD or accepted steps; the mirrored-boundary case has no test at all.

---

## CARD 2 of 5: long section ground line reads only level texts on a survey layer (#1939)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Long section (CDPROFILE) existing ground line: only level texts on a layer that looks like a survey layer count as ground levels, so a bare "18.60" (a pit invert) written beside the run no longer dips the ground line.
2. **Ribbon or trigger.** Same as card 1: `CDPROFILE`; tab "CE", panel "Review", button "Profile". The shared code is `LongitudinalSectionViewModel.cs` (cross-refer card 1: #1938 and #1939 ride together).
3. **Works today.** Before this change every plain number written as text anywhere in the survey Xref is taken as a ground level (text with letters is skipped; a leading RL, AHD or LEVEL is allowed). Survey spot levels on ordinary survey layers already produce the ground line.
4. **What the train or PR changes.** PR #1939 (B-122, BUG-765, head 209cc31d), in C-79b2. Each level text carries its layer (a text on layer 0 takes its block's layer). A layer counts as survey when, after any Xref prefix, one of its words STARTS with SURVEY, SURV, SPOT, LEVEL, LVL, RL, HEIGHT, ELEV, TOPO, GROUND, NSL, ESL, TIN, DTM or CONTOUR. A whole word PIT, PIPE, DRAIN(S/AGE), INVERT(S), IL, STORM(WATER), SEWER(AGE) or SW overrides that. If NO text sits on a recognised layer, all are used as before and one line says so. Switch `survey.longSectionSurveyLevelsOnSurveyLayersOnly`, ON; two word lists `survey.longSectionSurveyLevelLayerWords` and `survey.longSectionNotSurveyLayerWords` ship empty and mean "use the shipped words". OFF returns every level as today.
5. **Suggested class: Modify.** Same workflow, stricter input. Suggestion only.
6. **Prompts and windows.** No new prompt. Two command-line lines can appear. If some are left out: `[CE] N plain number(s) in the survey XREF (on layer "X" ...) was/were not used as ground levels, because that layer is not a survey layer.` If none are recognised: `[CE] The survey XREF's level texts are not on a layer CE recognises as a survey layer, so all N were used as before. Add your survey layer's name to the survey layer words in Settings if the surface line looks wrong.` There is no Settings box for the word lists (file only; not confirmed on the Settings page).
7. **Selection.** None for this change (the survey Xref is read as a whole).
8. **Preview.** The ground line in the existing Preview. The pre-review notes the same warning can print twice from one CDPROFILE (a cosmetic issue; the 30-second repeat guard remembers only the last text).
9. **Drawing output.** The ground (existing surface) line on the profile. **Xref, locked layer, REFEDIT: nothing is written.** The change filters a list in memory and prints a line. The finalizer pinned the new members read-only.
10. **Cancel, Escape, Undo and Redo.** As card 1 (same command, no new hook). The only added output is `ed.WriteMessage` lines inside the command, judged REDO-safe by the finalizer.
11. **Save and reopen.** No saved data added.
12. **Assets, data and Settings.** Reads the survey Xref's DBText and MText. Settings above. Rule file `Rules/LongSectionSurveyLayerRule.cs`. Per rule R-00 the words are Settings values, not hard-coded in the reader.
13. **Performance.** Not measured. One extra pass over the level texts (GUESS: negligible).
14. **Discovery.** As card 1. The command-line line names the Settings words. No help page entry was read.
15. **Example drawing and expected result.** A survey Xref with covers 19.20 on layer "SURVEY-LEVELS" and a pit invert "18.60" on "PIT INVERTS" beside the run. Expected: the ground line stays near 19.20 and the command line says 1 plain number on "PIT INVERTS" was not used. Second case: every level on layer "TEXT": all used, plus the "not on a layer CE recognises" line. Known gap from the pre-review: an invert "18.60" on a layer called "KERB LEVELS" still counts as survey (LEVELS starts with LEVEL; KERB is not on the exclude list), so it still dips the line.
16. **Older family card.** Same as card 1 (CV-06 and the C4 CDPROFILE cards). They mention surface and boundary display evidence but nothing about which survey layers count, and the capture adapter card says missing or doubtful evidence must show as Unknown, not be guessed. This change is a guess-by-layer-name filter, which those cards do not cover.
17. **Tim's AutoCAD checklist.** (Not run by anyone.)
    1. On a copy, make a survey Xref with a text "19.20" on layer SURVEY-LEVELS and a text "18.60" on layer PIT INVERTS beside the run. Attach it to a drawing with a CE pit and pipe.
    2. Type `CDPROFILE`, pick the pit, Preview. The ground line should stay near 19.20; the command line should name one number left out and the layer "PIT INVERTS".
    3. Move the 18.60 onto layer "TEXT" and put the 19.20 on "TEXT" too: expect all used, with the "not on a layer CE recognises" line.
    4. Put the 18.60 on layer "KERB LEVELS": it will still dip the line today (the known gap).
    5. Set `survey.longSectionSurveyLevelsOnSurveyLayersOnly` to false before AutoCAD starts: expect the old dip to 18.60.
18. **Questions only Tim can answer.**
    1. **Survey layer words.** Context: the shipped word lists are CE's guess, not your ruling. What I understand: the lists work for names like SURVEY-LEVELS but let "KERB LEVELS", "INV LEVELS", "FFL" and "FSL LEVELS" through. Recommendation (the Opus re-check's): add KERB, INV, FFL and FSL to the "not survey" words, because the bug's own example is a kerb invert. On a job: with KERB in the list, a consultant's kerb-invert texts stop pulling the ground line down; without it they still do. If your offices' consultants name layers differently, say which names (for example "SPOTS" or "NSL_LEVELS"). Not decided.
    2. **Engineering-result risk.** Context: this changes what the ground line shows on a drawing that goes to council. If a survey has only one stray text on a recognised layer (a datum note on layer "RL"), every other level is dropped and the line rests on the pit covers alone; the command line says how many were left out. Is a warning line enough, or should CE refuse to use only one recognised text? I have no recommendation beyond leaving the warning; this is your call.
19. **NOT proven.** Built: yes. Tested: yes (the rule is tested with the report's numbers; the reader is covered only by a source-text order guard). Installed: no. Tim-accepted: no. Nobody has done the installed, AutoCAD or accepted steps. Whether the shipped words match real consultant survey layers is not proven by anyone.

---

## CARD 3 of 5: recreated Xref source reads SOURCE RECREATED, not SOURCE MISSING (#1937)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Pit Schedule status and Project QA: when the drawing a schedule was placed from has been rebuilt (for example by WBLOCK * over the same file) and its Xref is still loaded at the same path, the badge says SOURCE RECREATED and tells you to re-place the schedule, instead of SOURCE MISSING.
2. **Ribbon or trigger.** Typed `PITSCHEDULE`. Ribbon: tab "CE", panel "Review", button "Pit Schedule" ("Review and place the pit schedule."); classic layout: tab "CE Civil", panel "Output", large button "Pit Schedule". The same words appear in Check Drawing / Project QA (the QA service consumes the same status).
3. **Works today.** The schedule keeps a record of each source Xref. A source that matches an Xref by the drawing's internal identity reads as current; an unloaded Xref falls back to its path; a truly missing source reads SOURCE MISSING; two matches read as a conflict. Update is stopped for a missing source and QA fails.
4. **What the train or PR changes.** PR #1937 (B-115, BUG-1155, head 99f4b09e), in C-79b2 as a net diff (the branch history carries the parked BUG-1149 commits; assembled by net diff on purpose). A stored source with no identity match is checked again: if a LOADED Xref sits at the same full path, the result reads SOURCE RECREATED. Switch `linking.pitScheduleRecreatedSourceWording`, ON, read at each status call; OFF sends it down the old SOURCE MISSING branch with today's wording exactly. Only the words change: the kind stays "Missing", so Update still stops and QA still fails.
5. **Suggested class: Modify.** Wording of one branch; the stop is kept on purpose. Suggestion only.
6. **Prompts and windows.** Pit Schedule window badge: `SOURCE RECREATED`. Detail text: "The source drawing was recreated: <source name>. It is loaded, but it is no longer the drawing this schedule was placed from. Re-place the schedule. The placed schedule is preserved." (`PitScheduleStatusService.cs`.) Priority order: a truly missing source still shows SOURCE MISSING first; a conflict outranks both. Whether the longer badge fits the window is not looked at.
7. **Selection.** None (status is passive).
8. **Preview.** No change to the Pit Schedule compare/preview.
9. **Drawing output.** None. **Xref, locked layer, REFEDIT: no code path writes to any of them.** The finalizer's own words: "every added line reads the Xref's load state and path and chooses words; no added line opens anything for write, starts a transaction, takes a lock, erases or commits", and two status files are pinned read-only in its test class. The placed schedule is not touched.
10. **Cancel, Escape, Undo and Redo.** Nothing to cancel or undo (display only). No new hook.
11. **Save and reopen.** Nothing new saved. The comparison uses the schedule record already in the drawing; reopening re-evaluates it.
12. **Assets, data and Settings.** Reads the placed schedule record and a fresh snapshot of the drawing's Xrefs (load state and full path). Setting `linking.pitScheduleRecreatedSourceWording` (ON). Files: `Services/PitScheduleStatusService.cs`, `Services/PitScheduleQaService.cs`, `Models/UserSettings.cs`.
13. **Performance.** No new reads; one extra path comparison per unmatched source (GUESS: negligible).
14. **Discovery.** In the Pit Schedule window badge and in Check Drawing / Project QA. No Help page was checked for the new word.
15. **Example drawing and expected result.** Stage drawing "East drainage" is Xref'd and a schedule placed from it. WBLOCK * the stage drawing over its own path and reload the sheet. Expected: badge SOURCE RECREATED, detail says "Re-place the schedule". With the switch OFF: SOURCE MISSING, as before. The carpark marks this UNSURE: whether WBLOCK * really gives a new identity while the Xref stays loaded is unproven.
16. **Older family card.** `docs/CARDS/PS-01_PIT_SCHEDULES.md` (and the system-scoped and exact-update workflow cards under `docs/workflows`). They describe the status, review and final-drawing QA but not a "recreated source" state. They say AutoCAD verification has not started, which is still true.
17. **Tim's AutoCAD checklist.** (Not run by anyone.)
    1. On a copy, Xref a stage drawing and place a Pit Schedule from it.
    2. In the stage drawing type `WBLOCK`, choose `*` and save over the same file path. Reload the Xref in the sheet.
    3. Type `PITSCHEDULE`. Look at the badge: it should read SOURCE RECREATED, not SOURCE MISSING, and the detail should end "Re-place the schedule. The placed schedule is preserved."
    4. Run Check Drawing / Project QA: the same words should appear, and QA should still fail.
    5. Confirm Update is still stopped (it should be).
    6. Set `linking.pitScheduleRecreatedSourceWording` to false before AutoCAD starts and repeat: expect SOURCE MISSING.
    7. Look at the window: does the longer badge text fit?
18. **Questions only Tim can answer.**
    1. **Stop or rebind.** Context: when a source is recreated CE still stops Update, as it always did. What I understand: the Opus review notes this stop is old behaviour kept on purpose, and that "rebind to the recreated source and update" would be a separate reviewed workflow. Recommendation: leave the stop; a recreated drawing may hold different pits and an auto-rebind could place a wrong schedule. On a job: today you re-place the schedule yourself; a rebind workflow would save that step but needs its own card. Not decided.
19. **NOT proven.** Built: yes. Tested: yes (7 tests in `Bug1155RecreatedSourceTests` call the real Evaluate with the real words, and check that gone, unloaded and identity-matched sources are not called recreated). Installed: no. Tim-accepted: no. Nobody has done the installed, AutoCAD or accepted steps. Whether a real WBLOCK * gives a new identity with the Xref still loaded has not been shown by anyone.

---

## CARD 4 of 5: a refused twin detention pipe upgrade puts the main line back (#1950)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** Opening a drawing with an older twin detention pipe: if CE cannot turn it into a pipe object, the pipe's main line goes back to the barrel route it had, instead of staying on the centreline while the record still calls it a barrel.
2. **Ribbon or trigger.** No button or typed command of its own. It runs inside the open-time pipe-object upgrade (`UpgradePipesToObjects` called from `PipeObjectUpgradeService.UpgradeDrawing`). When exactly that upgrade starts (on open, on a CE command) I did not trace: GUESS "on open" from the register's wording. It needs the CE pipe object enabler (AutoCAD 2027 only, per the code) and is held on colleagues' PCs by the existing hold gate (UX-MIX-03).
3. **Works today.** Pipes without a refusal upgrade as before. A pipe on a locked layer is refused before anything changes (BUG-313): never unlocked or force-opened. A legacy pipe object migrates in place.
4. **What the train or PR changes.** PR #1950 (B-120, BUG-1152, head 649df208), in C-79b1 (on `claude/rel-20261108a`; carried in b2 and c). Before the main-line rewrite the code now saves every vertex (position, bulge, widths). If the upgrade is refused, or throws, a new transaction puts them back and removes the pipe from the "route changed" list. Switch `linking.twinUpgradeRestoresRouteOnRefusal`, ON; OFF is the old behaviour (never restored). A failed put-back is logged only, never thrown, never blocks.
5. **Suggested class: Modify.** Suggestion only.
6. **Prompts and windows.** None new. The refusal is listed in the existing upgrade summary (name and reason). A log line reads "twin pipe <name> (<handle>) left as drawn: the upgrade was refused, so its main line was put back to the barrel route". No colour or window text was read.
7. **Selection.** None.
8. **Preview.** None.
9. **Drawing output.** Writes the twin pipe's own main polyline (CE's pipe on its own layer): the rewrite to the centreline, then (on refusal) the put-back to the original vertices, set open. **Xref: not involved** (it opens pipes in this drawing's own record). **Locked layer: the check runs first and refuses the whole pipe, including the twin root rewrite, before anything changes.** The restore uses the same `SafeOpenForWrite` as the rewrite, and if the root cannot be opened or is already a pipe object it does not restore and logs it. **REFEDIT: I found no REFEDIT-specific handling in this path;** the code relies on the safe-open helper (I did not read that helper). The finalizer reviewed the b1 write paths; read that report before relying on this line.
10. **Cancel, Escape, Undo and Redo.** No prompt, so no Escape. It runs under the existing upgrade suppression (the pipe-link queue is held off during the upgrade, BUG-189). Whether one Undo reverses the rewrite plus put-back as a unit is not shown. The change keeps the "route changed" list in step with the put-back.
11. **Save and reopen.** The restored vertices are saved with the drawing as normal. After a refusal the next open tries the upgrade again (GUESS; not read).
12. **Assets, data and Settings.** Reads and writes the twin pipe polyline and the pipe's link record. Setting `linking.twinUpgradeRestoresRouteOnRefusal` (ON). Files: `Services/LinkService.PipeObjectUpgrade.cs`, `Rules/TwinUpgradeRestoreRule.cs`. A dated backup of the drawing is taken first (existing behaviour) only when the drawing is saved and no `_PRE_C7_` backup exists beside it.
13. **Performance.** One vertex snapshot per twin pipe being upgraded (GUESS: negligible).
14. **Discovery.** None; invisible except in the log and the upgrade summary. The raingarden outlet words PR #1815 (BUG-1107) are on the Inspector card (`CARD_DRAFTS_INSPECTOR_CHECKS_02NOV.md`), which says #1815 is on no C-79 branch; cross-reference only here.
15. **Example drawing and expected result.** BUG-1152's own case: a twin detention pipe drawing opened on a PC where the object upgrade is refused. Expected: the main line has the same vertices as before the open (a 9-vertex barrel-route main line before still has those 9 after), and the record and the geometry agree. Before the change: the main line had been rewritten to the centreline but the record still called it a barrel, so the next redraw could place the barrels wrongly.
16. **Older family card.** `docs/workflows/C5_DRAWING_REPAIR_SHARED_BRIDGE_2026-09-09.md` is the nearest repair card; I did not find a card for the open-time pipe-object upgrade (so that gap is itself a finding). It cannot say anything about this PR.
17. **Tim's AutoCAD checklist.** (Not run by anyone; needs a refusal that real drawings may not produce.)
    1. This needs a copy of a drawing with an older twin detention pipe, opened on a PC where the pipe object upgrade is refused (the carpark does not say how to force a refusal; ask Codex for a robot case).
    2. Note the main line's grips before opening (count and position).
    3. Open the copy. Check the upgrade summary lists the pipe as refused.
    4. Select the pipe: the main line should have the same grips as in step 2.
    5. Redraw (`REGEN`): the barrels should sit where they did before.
    6. Set `linking.twinUpgradeRestoresRouteOnRefusal` to false before AutoCAD starts and repeat: the main line should now be on the centreline (the old fault).
18. **Questions only Tim can answer.**
    1. **How to force a refusal.** Context: nobody has shown a refusal in AutoCAD. What I understand: the carpark marks the aftermath UNSURE. Recommendation: have Codex build a robot case that forces a refusal (for example a copy with a locked layer, which per the code refuses before any rewrite and so would not exercise the put-back) or accept unit-test proof only. On a job: unit tests prove the vertices go back; only an AutoCAD run shows the barrels redraw correctly. Your call on whether unit-test proof is enough for this rare path.
19. **NOT proven.** Built: yes. Tested: yes (the authors' focused tests and the finalizer's runs; the real put-back needs a refused upgrade in AutoCAD). Installed: not by me; C-79b1 (Civil 3.0.90) is built but another card says not installed (I did not read the installed DLL). Tim-accepted: no. Nobody has done the AutoCAD or accepted steps.

---

## CARD 5 of 5: CDSL and CDTRENCHGRATEAUDIT wording no longer names C:\Lisp Files (#1974)

**DRAFT FOR TIM: nothing is approved**

1. **Name, and what it does for a drafter.** CDSL (Civil Spot Level) and CDTRENCHGRATEAUDIT (a hidden diagnostic): messages and the audit's file lookup point at the CE Civil bundle's Blocks folder, not at your own folder `C:\Lisp Files`.
2. **Ribbon or trigger.** `CDSL`: tab "CE", panel "Draw", button "Spot Level" ("Place or edit a civil spot level."); classic layout tab "CE Civil", panel "Levels & Falls", large button "Spot Level"; registry label "Civil Spot Level (CDSL)". `CDTRENCHGRATEAUDIT`: typed only; hidden and expert in the registry ("Working off-register trench grate audit retained during CT-01 migration"), no ribbon button.
3. **Works today.** CDSL: checks the dimension-text layer is unlocked (stops with "Nothing was changed" if locked), loads the SPOT LEVEL block, shows any survey level as information only, asks for the point then the proposed level, accepts "P18.6", "18,6", "18.6m" or "PRL 18.600" as 18.600, and places the block. Enter alone places a blank level. CDTRENCHGRATEAUDIT: audits a block drawing and writes a report.
4. **What the train or PR changes.** PR #1974 (B-123, BUG-1175, head 3993061a), in C-79b2, no Settings switch (wording and a read-only lookup). New `Rules/BundleFolderWording.cs`. CDSL missing-block message now reads: "[CE] SPOT LEVEL block not found. Place SPOT LEVEL.dwg in the CE Civil bundle's Blocks folder: CE_CVL_SUITE.bundle\Contents\Blocks\ or reinstall CE Civil." CDTRENCHGRATEAUDIT used the fixed `C:\Lisp Files\TRENCH GRATE.dwg`; it now uses the normal block search with the bundle Blocks folder first. If it finds nothing: "[CE] CDTRENCHGRATEAUDIT: TRENCH GRATE.dwg was not found in the CE Civil bundle's Blocks folder (CE_CVL_SUITE.bundle\Contents\Blocks\). Nothing was audited."
5. **Suggested class: Keep for CDSL's drafting behaviour (only its error text changes); Modify for CDTRENCHGRATEAUDIT (behaviour changes, not only words).** Suggestion only.
6. **Prompts and windows.** CDSL prompts are unchanged: `Specify spot level insertion point: ` then `Enter proposed spot level (m): `; a bad level prints `"<typed>" is not a level in metres (for example 18.600). Type it again, or press Enter for a blank level.` Cancel prints `CDSL command cancelled.` or `CDSL command cancelled. Nothing was placed.` Locked layer message: `[CE] The <layer> layer is locked, so a spot level cannot be placed. Unlock it and run CDSL again. Nothing was changed.` The only change is the missing-block text above.
7. **Selection.** CDSL: one pick point. The audit: none.
8. **Preview.** CDSL: the usual drag preview of the block at the pick point; the block is not added until the level is answered (UC-FALL-ESC-01).
9. **Drawing output.** CDSL: one SPOT LEVEL block with its LEVEL attribute, on the dimension-text layer. **Locked layer: CDSL stops and never unlocks.** Xref and REFEDIT: this change touches neither (no new writes at all). CDTRENCHGRATEAUDIT: **does not touch the drawing**: it opens the bundle's TRENCH GRATE.dwg in a side database for read and writes a text report `TRENCH_GRATE_AUDIT_<date_time>.txt` in the Windows temp folder, echoing the first 80 lines to the command line.
10. **Cancel, Escape, Undo and Redo.** CDSL: Escape at the point or level prompt places nothing (existing). Placement is its own transaction (existing). This PR adds no hook; the finalizer judged the added `WriteMessage` lines REDO-safe. The audit has nothing to undo.
11. **Save and reopen.** Nothing new saved.
12. **Assets, data and Settings.** CDSL reads `SPOT LEVEL.dwg`; the audit reads `TRENCH GRATE.dwg`, which is in `Installer/source_blocks` and is copied into the bundle's Blocks folder (the finalizer read the installed Blocks folder and says it is there). No Settings switch.
13. **Performance.** Unchanged.
14. **Discovery.** CDSL: the ribbon button above; help link `https://help.creativeeng.com.au/ce-cvl-suite/commands/sl`. The audit: typed only. Two other leftovers are still there: CDHELP's window line `Dialogs/CdHelpDialog.xaml.cs` line 41 still shows `C:\Lisp Files\SUPERSEDED\CE_CVL_SUITE` (a Codex window brief exists), and the default folder for saved computations in `UserSettings.cs` is still `C:\Lisp Files\Computations` (new fault found by the AD review; needs its own bug entry). The carpark's guard test (no shipped string contains "C:\Lisp Files") is not built; it would fail today on those leftovers.
15. **Example drawing and expected result.** On a PC where the SPOT LEVEL block file is missing from the bundle: CDSL prints the new bundle-folder text and stops. On an ordinary PC: CDSL places a spot level with level 18.600 as before. CDTRENCHGRATEAUDIT on the installed bundle: prints a report from the bundle's TRENCH GRATE.dwg and the temp-file path.
16. **Older family card.** `docs/CARDS/CV-05_SLAB_SITE_LAYOUT.md` and `docs/workflows/C5_B1_CONSTRAINED_SLAB_SURFACE_2026-09-10.md` (slab and site levels; I did not find a card for CDSL or the trench grate audit on their own, so say so). They say nothing about the block-missing message or where the audit's drawing comes from.
17. **Tim's AutoCAD checklist.** (Not run by anyone.)
    1. Type `CDSL`, pick a point, type `18.6`: the block places with level 18.600.
    2. Press Escape at the level prompt: nothing is added.
    3. Rename `SPOT LEVEL.dwg` in a test copy of the bundle's Blocks folder (a colleague-type profile is best; do this only on a spare install) and run `CDSL`: the new bundle-folder text appears, with no `C:\Lisp Files`.
    4. Type `CDTRENCHGRATEAUDIT`: a report prints and the last line names a TRENCH_GRATE_AUDIT file in the temp folder. Open that file.
    5. Rename the bundle's `TRENCH GRATE.dwg` on the same spare install and run it again: the "was not found" line appears and nothing is audited.
18. **Questions only Tim can answer.**
    1. **File the leftovers.** Context: BUG-1175 cannot close while CDHELP still shows `C:\Lisp Files\SUPERSEDED` and the saved-computations folder default is `C:\Lisp Files\Computations`. What I understand: CDHELP is a window (Codex's job); the computations folder is your own folder, and on a colleague's PC a missing folder could matter (not checked). Recommendation: file the computations default as its own bug, and leave BUG-1175 open until CDHELP is fixed. On a job: a colleague saving a computation could be sent to a folder that does not exist. Not decided.
    2. **Audit scope.** Context: CDTRENCHGRATEAUDIT now audits the bundle's copy, not yours. What I understand: that is the point; the two files may differ. Recommendation: accept. If you keep an edited TRENCH GRATE.dwg in `C:\Lisp Files`, this command no longer reads it.
19. **NOT proven.** Built: yes. Tested: yes (4 new tests that read source files; the finalizer's focused run). Installed: no. Tim-accepted: no. Nobody has done the installed, AutoCAD or accepted steps. The real lookup of the bundle copy of TRENCH GRATE.dwg has not been run in AutoCAD.
