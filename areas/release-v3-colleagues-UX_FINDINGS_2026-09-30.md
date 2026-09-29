# UX findings from Codex, 30 Sep 2026 (pass 18 and sweep C1 FINAL)

**What this is.** Codex's ranked UX findings from two runs on the INSTALLED build (Civil 3.0.15, Manager 1.1.15, Structural 1.0.86), copies only. Written by the triage step; the controller reads it. Nothing here is Tim-accepted; these are findings, not fixes. Where a finding is also a carpark bug, the bug ID is given (the bug is the record; this file is the reading list).

**Sources.**
1. **Pass 18:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_TEST_REPORT_PASS18_2026-09-28.md` (103 checks: PASS 47 / FAIL 18 / BLOCKED 21 / NOT TESTED 17). Screenshots in `C:\Lisp Files\_TEST_COPIES_20260923\P18_screenshots\` (names below are files in that folder).
2. **Sweep C1 (FINAL, updated 30 Sep after the report was completed ~08:10):** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_SWEEPC1_2026-09-30.md` (IN SCOPE 631, PASS 11 / FAIL 11 / BLOCKED 5 / NOT TESTED 604; 22 tested, 609 not tested; scope still incomplete, 631 is a discovered minimum). AutoCAD CRASHED at 07:55 (BUG-224); Codex stopped for recovery. Screenshots in `C:\Lisp Files\_TEST_COPIES_20260923\SWEEPC1\screens\` (207, all present). Sweep C2 (`CODEX_SWEEPC2_2026-09-30.md`): AutoCAD never opened, 0 of 43 known commands tested, no UX finding, no verdict.

**Codex's verdicts.** Pass 18: "Faster ordinary drafting and several good defaults, but recovery and agreement between the drawing and its records are not reliable enough yet." Sweep C1 (final): **"Not ready for a colleague: the save/close crash and unreliable recovery need resolving; this sweep remains incomplete."** (The earlier interim verdict, "Not ready for acceptance; startup and version messaging need attention...", is superseded by this.) Sweep C2: "No defensible usability verdict; the drawing workflow has not been tested."

---

## BLOCKER (sweep C1 final, ranked first)

0. **BLOCKER - AutoCAD crashed closing a saved copy.** Place: after CDDISCIPLINE changes and Save As, the drawing was closed through the COM `Document.Close(false)` call; the close stalled and AutoCAD exited (Autodesk Error Report). Once, not repeated; the saved copy reopened fine; CE involvement Unknown (dump `acad.exe.4120.dmp` not yet read). Screenshot: `autocad-error-report-after-copy-close.png` (in `SWEEPC1\screens\`). Codex suggestion: diagnose and fix this exact save/close sequence before release. Carpark: **BUG-224**.

## BLOCKER (Codex ranked these BLOCKER; all nine are pass 18)

1. **BLOCKER - U then REDO loses the redo (PIT, grip moves, CD).** Place: PIT / grip edit / CD, then U, then REDO says "Nothing to redo". Screenshot: `BUG192_PIT_REDO_FAIL.png`. Codex suggestion: keep the redo operation when CE refreshes after Undo. Carpark: **BUG-192** (reproduced five times).
2. **BLOCKER - CD "Use level direction" makes an uphill pipe.** Place: CD > Start Pipe direction question (both ends called "Open end"). Screenshot: `N384_direction_uphill_FAIL.png`. Suggestion: show the real levels and preview 18.00 to 17.80 before the drafter confirms. Carpark: **BUG-205**.
3. **BLOCKER - drawn Pit Schedule stays stale after a pit edit.** Place: Edit Pit > Save, then the drawn schedule (cover 20.10 on the plan, 20.00 on the sheet). Screenshot: `Q3_fresh_schedule_stale_FAIL.png`. Suggestion: update linked cells at once, or mark the placed schedule out of date when the pit edit is saved. Carpark: **BUG-207** (needs Tim: UX-LIVE-01 says "Straight after each edit").
4. **BLOCKER - ERASE then COPY a pit: three views disagree.** Place: Edit Pipe says P4 -> P3, Edit Pit says no connection, Pit Schedule blank. Screenshot: `Q2a_schedule_missing_links.png`. Suggestion: show the same confirmed endpoint link in all three. Carpark: **BUG-210**.
5. **BLOCKER - pipe end grip: geometry moves, CE records refused.** Place: grip/STRETCH on a fresh CD pipe end. Screenshot: `Q2b_fresh_pipe_guard.png`. Suggestion: keep geometry and records together, with one clearly named repair action if the edit cannot complete (the message says "admission evidence"). Carpark: **BUG-208**.
6. **BLOCKER - Edit Pipe diameter-only changes the grade.** Place: Edit Pipe > change 225 to 300 > Save (1 IN 100 becomes 1 IN 99). Screenshot: `N384_diameter_grade_FAIL.png`. Suggestion: keep the chosen grade on a diameter-only edit. Carpark: **BUG-198** (still failing on 3.0.15).
7. **BLOCKER - CDCATCHMENT says 28 million m2.** Place: CDCATCHMENT > New. Screenshot: `R5_catchment_area_FAIL.png`. Suggestion: convert drawing area to m2 before showing it and before the capacity check. Carpark: **BUG-209**.
8. **BLOCKER - erase a column: no question about its beam.** Place: Structural, select column C1 and Delete. Screenshot: `P12_support_erased_no_prompt.png`. Suggestion: ask what to do with each linked beam before the erase completes. Carpark: **BUG-211**.
9. **BLOCKER - older schedule: "re-place it" but only a disabled Update button.** Place: PITSCHEDULE > Placement on an older drawing. Screenshot: `Q3_disabled_update.png`. Suggestion: a "Replace older schedule..." action with a preview and one U. Carpark: **BUG-213**.

## ANNOYING (pass 18, in Codex's order, then extras from its journal)

10. **ANNOYING - Place schedule ends with "please try again".** Place: PITSCHEDULE > Place on a legacy pit. Screenshot: `Q3_new_schedule_FAIL.png`. Suggestion: name the affected pit before placing and offer the repair. Carpark: **BUG-212**.
11. **ANNOYING - RC then U: first U does nothing.** Place: Structural RC. Screenshot: `RC_immediate_U_FAIL.png`. Suggestion: one undo step for the cloud and its temporary layer/snap changes. Carpark: **BUG-215**.
12. **ANNOYING - CSBRACINGPANEL says shown, nothing visible.** Screenshot: `R8_bracing_not_visible.png`. Suggestion: bring the panel to the front. Carpark: **BUG-218**.
13. **ANNOYING - CDFALLSUGGEST: Enter is "Invalid point".** Screenshot: `R5_Enter_finish_FAIL.png`. Suggestion: make Enter finish as the prompt says and print placed/skipped. Carpark: **BUG-216**.
14. **ANNOYING - CDPERIMETER: command says PD1, plan says AG; prompts say "AGI".** Screenshot: `R6_PD1_placed.png`. Suggestion: say "perimeter drain" everywhere and draw a PD tag. Carpark: **BUG-217**.
15. **ANNOYING - Inspector calls a recorded legacy pit "not recorded / Unknown".** Place: CE Inspector on a selected legacy pit until Edit Pit is opened once. Screenshots: `T098_Inspector_unknown.png`, `T098_label_synced.png`. Suggestion: load the pit's record on selection, or say "Open Edit Pit to load this pit" instead of "not recorded". Related: **BUG-098**.
16. **ANNOYING - CD with two open ends: downstream stays "Unknown" before Start Pipe.** Screenshot: `N384_provenance_unknown.png`. Suggestion: calculate and label the downstream value once route and grade are known. Carpark: **BUG-199** (open-end case).
17. **ANNOYING - CDRG refusal says "Move the source and pick again".** Screenshot: `B3_GIO_data_guard.png`. Suggestion: name the drawing repair and give its exact command; the red cursor sentence runs off the right edge. Related: **BUG-176**.
18. **ANNOYING - PIT default cover text crosses the pit mark.** Place: PIT, accept Enter for cover position at DIMSCALE 20. Screenshot: `Q3_fresh_pit_placed.png`. Suggestion: default the cover text beyond the mark and show the real proposed text in the preview.
19. **ANNOYING - New Pit > More hides Surface and lid class.** Screenshot: `R7_Surface_more.png`. Suggestion: put Surface, its suggested lid class and a Use action on the main Engineering page. (Lid suggestion itself not proven: BLOCKED.)
20. **ANNOYING - CSTIEDOWN: type codes need another command to learn; label crowds the symbol.** Screenshot: `R8_TD1_placed.png`. Suggestion: show "TD1 - Strap tie-down" in the prompt and offset the label.
21. **ANNOYING - CEBLOCKS catalogue stays behind a docked tab.** Screenshot: `B1_catalogue.png`. Suggestion: bring the catalogue forward when the command runs. (Same pattern as CSBRACINGPANEL and CEASK.)
22. **ANNOYING - Structural ribbon Column button opens the RC column section window, not "place column".** Screenshot: `P12_Column_ribbon_section.png`. Suggestion: label it "RC column section" and add a separate "Place column".
23. **ANNOYING - linked pit grip and STRETCH pauses.** Network grip 644 ms, STRETCH 453 ms, later grip 258 ms, with 50-186 ms schedule work each time. Screenshot: `Q1_P3_moved.png`. Suggestion: less repeated linked-geometry and schedule work after one edit. Related: **BUG-189**.
24. **ANNOYING - PIT still prints internal jargon.** "Auto inline split skipped ... considered=50, geometryRejected=36 ..." then, at a pipe end, hundreds of digits. Screenshots: `BUG192_PIT_placed.png`, `Q3_P2_open_end_placed.png`. Suggestion: "Pit placed and linked to the pipe end"; counts to the log. Carpark: **BUG-201** (still present on 3.0.15).
25. **ANNOYING - selecting overlapping pit, pipe and label objects.** A centre pick opened Edit Pipe, a label pick opened the attribute editor, and typed PITEDIT rejected a non-pit object. Screenshot: `P2_PITEDIT_rejected.png`. Suggestion: offer the pit and the linked pipe by name when both are under the pick.
26. **ANNOYING - Edit Pit preview flickers "No preview for this pit" and labels an existing pit "Pit - not yet saved".** Screenshots: `P2_pit01_before.png`, `P2_pit01_1911.png`. Suggestion: keep the previous preview while updating; label the pit accurately.
27. **ANNOYING - CDCATCHMENT label is blue on blue fill.** Screenshot: `R5_catchment_area_FAIL.png`. Suggestion: high-contrast label with a mask.
28. **ANNOYING - CDPAVE shows no boundary preview while picking.** Screenshot: `R3_type_picker.png`. Suggestion: a temporary outline following the picked corners.
29. **ANNOYING - runtime health says "RESTART RECOMMENDED" with no reason (recent hotspots 0).** Place: after switching drawings (CEADMIN). Screenshot: `P10_A_retained.png`. Suggestion: state the measured problem, or say nothing when none is recorded.
30. **ANNOYING - detention CD ends with a sharp zoom that clips the new callout.** Screenshot: `N383_detention_placed.png`. Suggestion: keep the drafter's view or fit the pipe and callout together.
31. **ANNOYING - Structural beam/C1 command line is swamped by route and coordinate debug messages.** Screenshot: `P12_beam1.png`. Suggestion: keep them in the log; show only drafting prompts.
32. **ANNOYING - typed DDEDIT returns "Unknown command" with no pointer to TEXTEDIT.** Screenshot: `P8_DDEDIT_unknown.png`. Suggestion: point to the replacement command.
33. **ANNOYING - Inspector cannot explain a just-drawn spoon drain ("Not a CE object").** Screenshot: `R4_spoon_Inspector_unknown.png`. Suggestion: show SD1, length, fall and outlet P66 under Connections.
34. **ANNOYING - Pit Schedule Rows: picking a row shifts the table and zooms the drawing behind it.** Screenshot: `N384_size_typed.png`. Suggestion: keep the row position stable; refresh the group heading (still says 450 after a 1200 x 900 edit).
35. **ANNOYING - movement messages name a pipe by handle ("10B03B") and "the block Drawing Border".** Screenshot: `P7_STRETCH.png`. Suggestion: say "pipe P6 to P5" and describe the overlap once.
36. **ANNOYING - the end-of-pass OSMODE was 0.** Screenshot: `PROFILE_CHECK_END_OSMODE_FAIL.png`. Suggestion: every command that changes snaps restores the prior value on completion and Escape. Carpark: **BUG-206**.

## ANNOYING (sweep C1)

37. **ANNOYING - status bar says CE MANAGER v1.1.10, Manager is 1.1.15.** Screenshots: `cemanager-module.png`, `cddiag-heavy-output.png`. Suggestion: generate every version label from the running assembly. Carpark: **BUG-219**.
38. **ANNOYING - CEFIND then Esc marks a clean drawing changed; U does not clear it.** Screenshot: `cefind-cancel-undo-redo-dirty.png`. Suggestion: start Find without writing drawing data. Carpark: **BUG-214**.
39. **ANNOYING - an unsolicited Structural tools launcher opens at start (two of the starts).** Screenshot: `cold1-structural-launcher.png`. Suggestion: open it only on request. Carpark: **BUG-220**.
40. **ANNOYING - CEASK palette: "No classified drawing" and "AI disconnected - R0/W0" explain nothing; Send still looks available.** (No carpark bug: answers were BLOCKED because the AI is disconnected and the brief forbids Send.) Place: type CEASK (palette also stays auto-hidden until clicked). Screenshot: `ceask-empty-disconnected.png`. Suggestion: "Ask CE is unavailable for this drawing", with Help Centre next to the reason.
41. **ANNOYING - CDDIAG says "Full diagnostic dialog coming in v2.1 (PL-032)".** Screenshot: `cddiag-heavy-output.png`. Suggestion: remove the stale release promise and internal ID; offer a direct Audit action. Carpark: **BUG-228** (with the tooltip).
42. **ANNOYING - CEMANAGER Settings > Civil is one long scrolling form.** Screenshots: `cemanager-settings-civil.png`, `cemanager-settings-civil-bottom.png`. Suggestion: use the same task tabs CDS uses. Carpark: **BUG-222** (breaks the no-scrolling-layout rule).
43. **ANNOYING - CEMANAGER Status: running hash overlaps "Installed next start" in all three cards.** Screenshot: `cemanager-status-default.png`. Suggestion: short version prominent, full hash in a copyable detail line. Carpark: **BUG-221**.
44. **ANNOYING - CDMANAGER Draw Order list shows duplicate rows (20TEXT, 25DIMS, 25TEXT, AGI DRAIN and others); cause Unknown.** Screenshot: `cdmanager-layers-default.png`. Codex gave no suggestion; needs a look before anyone edits the list. Carpark: **BUG-229**.

45a. **ANNOYING - CDDISCIPLINE: Undo restores Unknown, but Redo says "Nothing to redo" (after one change and after five).** Screenshot: `cddiscipline-undo-redo-commandline.png`. Suggestion: preserve AutoCAD Redo after a discipline change. Carpark: **BUG-192** (now seen on an empty drawing, CE write-after-U named in the log).
45b. **ANNOYING - Pit contextual tab: the Close button runs CDCLOSETAB but the pit stays selected and the tab stays open (twice); the typed command works.** Screenshot: `context-pit-close-settled.png`. Suggestion: make Close clear the selection reliably from ribbon focus. Carpark: **BUG-225**.
45c. **ANNOYING - Civil ribbon tooltip says "This drawing is Civil" on an Unknown drawing and offers "Both", which the prompt does not have.** Screenshot: `ribbon-tooltip-civil.png`. Suggestion: build the tooltip from the actual drawing and prompt. Carpark: **BUG-226**.
45d. **ANNOYING - Settings tooltip promises Personal/Project/Firm pages and combined editors the installed CDS does not have (it has six tabs and separate windows).** Screenshot: `ribbon-tooltip-settings.png`. Suggestion: describe the installed six-tab window and the separate editors. Carpark: **BUG-227**.
45e. **ANNOYING - Data Diagnostics tooltip promises inspect and export, CDDIAG prints counts only.** Screenshot: `ribbon-tooltip-settings-4.png`. Suggestion: describe only the counts until the report window is installed. Carpark: **BUG-228**.

## POLISH

45. **POLISH - CDFEEDBACK: the "saves a file; email it to Tim" explanation sits apart from the Send report button.** Screenshot: `cdfeedback-included.png` (sweep). Suggestion: repeat it beside the button.
46. **POLISH - CD pipe-type header still says "Existing" after switching back to Stormwater.** Screenshot: `B2_return_stormwater.png`. Suggestion: refresh the title at once.
47. **POLISH - Edit Pipe shows the same material warning twice (header and banner).** Screenshot: `P7_outline_edge.png`. Suggestion: once, with both conflicting values and the action.
48. **POLISH - CDCALC preview wording repeats itself ("not known - not known").** Screenshot: `B4_no_council.png`. Suggestion: "Storage requirement not calculated. Open Detention and enter the required volume."
49. **POLISH - Inspector Checks and Findings are blank or a dash, so "no problems" and "not checked" look the same.** Screenshot: `T099_no_symbols.png`. Suggestion: "No problems found - checked at [time]" or "Not checked - Refresh drawing checks".
50. **POLISH - New Pipe Engineering captions clip "Staff ente...".** Screenshot: `N384_typed_staff_entered.png`. Suggestion: reserve the width.
51. **POLISH - Structural Home > Time header: "Unknown Job" overlaps the timer when docked narrow.** Screenshot: `P12_beam_moved.png`. Suggestion: separate lines.
52. **POLISH - CDPAVE after four corners: Enter gives "Point or option keyword required."** Screenshot: `R3_type_picker.png`. Suggestion: `<Close>` as the default after three points.
53. **POLISH - CSWINDCLASS shows fused keywords (Hilltop, Escarpmentorridge); CSSOILREPORT says "type the soil values as usual" without saying where.** Screenshots: `R10_topography.png`, `R10_no_soil_report.png`. Suggestion: readable names once with short aliases; name the exact manual-entry command.
54. **POLISH - Pit Schedule: the final Place button jumps from the footer to mid-page.** Screenshot: `Q3_new_schedule_FAIL.png`. Suggestion: keep the main action in the footer.
55. **POLISH - Pit Schedule SIZE edit: header still shows the old size.** Screenshot: `N384_size_typed.png`. Suggestion: refresh the summary when SIZE is committed.
56. **POLISH - Start Here reopens at 745 x 554 after maximise; the minimum size scrolls five sections; the one-page tour has no Back or Skip; Help guide pages show technical IDs and the word "qualified".** Screenshots: `start-here-default.png`, `start-here-minimum-reading.png`, `help-centre-home.png`. Codex gave no single suggestion; noted for the Help pass.

## Not bugs, but the desk should know

57. **Wind region table is empty in the installed Structural.** CSWINDCLASS said "A is not in CE's region table, so CE has no starting wind class to suggest." Screenshot: `R10_wind_no_suggestion.png`. Under the Settings-first rule this may be by design (no invented values); Tim to confirm whether the table should hold the AS/NZS 1170.2 regions.
58. **Two P13 backup checks are obsolete.** The installed Structural (commit 532f9550) removed timed idle saves (UX-STD-03), so "rolling backup" cannot be tested as written; the brief needs rewriting.
59. **DDEDIT.** The brief used DDEDIT; the installed AutoCAD returned "Unknown command". The brief should say TEXTEDIT (Codex used it; it worked).

---

## What works really well (Codex's words, tidied)

1. **Speed of ordinary drafting.** First spline 26.7 ms with zero pipe updates (was 3,249 ms). Original linked pits brought their pipes and labels with them.
2. **Stable choices.** A custom 1 in 100 survived pipe-type changes; CD remembered 225 UPVC Stormwater and ignored the later detention pipe.
3. **Safe cancellation.** CDPAVE, CDKERB, CDSPOONDRAIN Escape leave nothing and say so; CDRENUMBER default No keeps the numbering; CDCATCHMENT Hide, Show and Clear explain recovery plainly.
4. **Native behaviour holds.** Every part of a pipe opens Edit Pipe by double-click; copied, rotated and scaled columns take their beam ends and labels with them ("One U undoes both"); tie-down placement survived a rotated UCS; native EATTEDIT on a placed office block just works.
5. **RC cloud.** Repeats with Enter, arc sizes scale correctly (450 / 90 / 4.5), layer and snaps come back, Escape leaves nothing (the one-U problem is BUG-215).
6. **Guards that refuse to invent numbers.** CSLOADPATH names the missing footing plan; soil and wind commands refuse to guess.
7. **Sweep C1 (final, Codex's own list):** (a) **Settings cancellation** - staged Light theme and a negative cover were discarded; reopening restored Dark and 300 mm and the settings file hash stayed identical (screenshots `cds-cover-negative-unsaved.png`, `cds-cover-reverted.png`; Codex-accepted for that narrow check, the engineering values are not accepted). (b) **Alias protection** - empty, native-conflicting and overlong short names got validation, and Cancel kept the file identical (`aliases-native-clash.png`, `aliases-200-name-validation.png`). (c) **Help reading** - the Manager-hosted guide scrolls in a bounded area, and enlarging a picture then Escape returned to the same reading position (`help-task-enlarged-picture.png`); search for pit, levels, schedule, tank, print, label all return entries. (d) **Typed selection recovery** - a real CE pipe shows the Pipe tab, and Escape or typed CDCLOSETAB clears it with the object count unchanged (`context-pipe-selected.png`, `context-cdclosetab.png`). Also: CPROFILE and OSMODE matched Tim's baseline at the start; CDDISCIPLINE names where the discipline came from and offers a clickable Cancel that prints "No change"; no-drawing start, Explorer double-click open, File > Open and a blank-copy start all work; Start Here to Help Centre is two clicks; the CDFEEDBACK form reads well, warns plainly when text is truncated and Escape discards the draft.

## What was NOT tested

1. Sweep C1 final: IN SCOPE 631, tested 22, NOT TESTED 609 (5 of them BLOCKED, 604 NOT TESTED, reason TIME for nearly all); the rest (every ribbon drawing command, most Settings fields, most dialogs) are NOT TESTED, not passed. Scope is a discovered minimum, not the full total. Sweep C2 tested 0 of 43 known commands (AutoCAD never opened).
2. Engineering values shown in CDS, CDPARTS and CDRULEBOOK were read and recorded by Codex only; none is accepted (they need Tim's word).
3. Nothing here is Tim-accepted.
4. Not observed in sweep C1 (Codex notes): 150% display scaling, saved theme/profile/workspace changes, any Settings Save/Apply/OK, Send, install or publish, the protection cases (locked layer, XREF, REFEDIT, unsupported objects), the Plug-ins fallback (only Autodesk App Manager was in the tab, no CE button; not a fail), the CE right-click items on a selected pipe (only standard AutoCAD items were present; planned, not accepted from this build).
