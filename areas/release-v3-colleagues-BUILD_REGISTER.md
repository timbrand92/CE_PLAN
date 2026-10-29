# Build register: one number per build item (B-001 and up)

Started Thu 29 Oct 2026 by CE 01 Build. Tim: "yes, build numbers" (29 Oct 2026, answering whether every build item should have its own number). Owner: CE 01 Build only; other sessions read it, they do not edit it.

**What a build item is:** one piece of work that ends in one draft PR (a bug fix, a plan card, a default change). The B number never changes. It sits beside the other labels and replaces none of them: the BUG number (if it came from the bug file), the card or ruling (D05, UX-SRC-03), the PR number (#1834) and the train (C-76).

**The four words** (RULES section 4, never merged into a percentage): Built, Tested (unit tests or the robot), Installed, Tim-accepted. A line says which are true today. "Claude-accepted" and "Codex-accepted" are written out in full where they apply; they are not Tim-accepted.

**Before 29 Oct:** earlier trains are not renumbered. C-75 (installed 29 Oct 00:21) was PR #1831 (BUG-665 and BUG-672), #1832 (BUG-1222) and #1833 (BUG-1223); see TRAIN_C75_PR_LIST_2026-10-28.md.

## Train C-76 (Civil 3.0.86 / Manager 1.1.86), assembling from 10:27

1. **B-001 BUG-859, double-click on a downpipe opens CE's Edit source window first.** PR #1834. Switch doubleClick.sourceStopsAttributeEditorFirst, ON. Built yes; tested unit only; installed no; Tim-accepted no. Robot proof R09 (twin R09_OFF_BROKEN).
2. **B-002 BUG-372, CDCHECK prints "an unnamed pipe", no raw handles.** PR #1835. Built yes; tested unit only; installed no; Tim-accepted no. Robot proof R22.
3. **B-003 BUG-090, the Manager About window grows to fit its rows.** PR #1836. Changes Manager code. Built yes; tested unit only; installed no; Tim-accepted no. Needs a Codex look.
4. **B-004 BUG-1228, DP takes about 30 s: each object is read once per landing read.** PR #1837. Switch linking.sourceLandingReadsEachObjectOnce ON (log-only linking.sourceLandingTimingLog OFF). Built yes; tested unit only (new time not measured); installed no; Tim-accepted no. Robot proof N31_dp_time with control C31.

## Next (fix agents and Team jobs running, one dotnet at a time)

5. **B-005 BUG-1229, grade shown flatter than the grade chosen (1 in 102 for 1 in 100).** PR #1838 (29 Oct 10:35). Switch pipe.suggestedLevelNeverFlatterThanGrade ON. Built yes; tested unit only (net10 20,853 passed, 0 real failures); installed no; Tim-accepted no. NOT in C-76 (the assembler read the list at 10:27 and skipped it; assembly report 11:36). Goes into C-77. Robot proof N32_cd_grade_never_flatter, control N32_off.
6. **B-006 BUG-1226, "Recent:" invert buttons back on the New Pipe window.** Team job team_fix_c77a. Tim: "yep bring back". Robot guard N30. Running.
7. **B-007 Raingarden RG1, RG2 label from CDRG.** Team job team_fix_c77b. Tim: "as recommended" (ruling UX-SRC-03, card D07). Queued.
8. **B-008 Tidy labels switch ON by default.** team_fix_c77c. Tim: "yes". Queued.
9. **B-009 Grip, ROTATE and SCALE copy clean-up ON by default.** team_fix_c77d. Tim: "yes", after a robot pass with it ON (CE 02 runs that pass); not for a train before then. Queued.
10. **B-010 BUG-505, no-units import keeps millimetres with one soft note.** team_fix_c77e. Tim: "yes". Queued.
11. **B-011 The two small extras of #1788 (comma figure refused, unset material speed falls back).** team_fix_c77f. Tim: "agreed to two small extras". The outbox switch stays OFF and is not part of this. Queued.
12. **B-012 Cover measured to the outside top of the pipe.** team_fix_c77g (Opus). Tim: "yes, add the pipe wall". Wall thickness from Settings or pipe data. Queued.
13. **B-013 Pit drop warning where the outlet pipe top sits above the inlet pipe top.** team_fix_c77h. Tim: "yes". Warn, never block. Queued.
14. **B-014 BUG-860, double-click on the green DP label opens Edit source.** team_fix_c77i, stacked on #1834. Tim: "yes". Queued.
15. **B-015 PR #1771, computations-sheet line (hydraulic grade line not calculated) on every council sheet.** Existing PR on an old base (rel-20261025o). Tim: "do as you recommend". Needs the usual review and a rebase onto the newest line before a train. Not started.

## After C-76 and the nine backlog jobs: pilot-critical bugs with no fix (Control Room ruling 29 Oct; from areas\release-v3-colleagues-PILOT_NOFIX_TRIAGE_29OCT.md)

BUG-901 is B-012 and BUG-907 is B-013 above. Each item below is a draft behind a Settings switch ON, built on the recommended answer where the triage says so; Tim's word replaces the default (questions in QUESTIONS_FOR_MONDAY.md item 21). Sizes are the triage's guesses. Nothing started.

16. **B-016 BUG-866, rainfall note wording on the detention sheet (no curve value changes, Tim: "leave them until you've checked the curve").** S. Build on recommended.
17. **B-017 BUG-1095, the council minimum runoff figure is never applied (Darebin 0.80, CDDESIGN uses 0.70).** M. Build now (council documents and the 4 Sep ruling answer it).
18. **B-018 BUG-1099, council time of concentration for detention (Boroondara, Maribyrnong, Maroondah).** M. Build on recommended (question 21b).
19. **B-019 BUG-1091, pipes DN450 and larger lose their minimum grade in redesign.** S. Build now. Base for B-020 and B-022.
20. **B-020 BUG-1088, pipe sizer picks the smallest pipe at any grade.** M. Build on recommended (question 21a). After B-019.
21. **B-021 BUG-1192, long section hides a ground depression (step one: a plain warning line).** M. Build now; dashed stretch waits for question 21d.
22. **B-022 BUG-903, screens that disagree on minimum cover.** M. Build now, after B-019.
23. **B-023 BUG-857, New Pipe window Grade mismatch box.** S. Build now; needs a Codex look.
24. **B-024 BUG-1031, Pit Schedule delete-cell button.** S. Build now; needs a Codex look.
25. **B-025 BUG-816, label tidy-up setting row.** S to M. Build now.
26. **B-026 BUG-902, one Unknown note on the CDRULES cover row.** S. Build now.
27. **B-027 BUG-525, no blue in Civil windows and icons (water line and snap glow wait for questions 21j and 21k).** M. Build now (Civil only).
28. **B-028 BUG-587, Pit Schedule row grows for a long remark.** M to L. Build on recommended (question 21e); needs a Codex look.
29. **B-029 BUG-1096 with BUG-1098, rainwater reuse boxes in CDDESIGN and the Kingston credit.** L. Build on recommended (question 21c); needs a Codex look.
30. **B-030 BUG-648, AG drain copy gets its own grade label.** L. Build on recommended (questions 21f and 21g); needs an Opus review and a Codex look.
31. **B-031 BUG-1228 follow-up, PIT is also slow (readiness report); B-004 only covers the source-placing reads (DP, OF, floor waste).** Not started; the robot timing from B-004 comes first.
32. **B-032 BUG-1232, label tidy after MOVE treats the Drawing Border block as a clash (suspected).** Not started; confirm by hand or robot first.

33. **B-033 BUG-905, hard-ground runoff 0.9 in CDCALC Boyd's: turn the fix's default ON.** Tim (29 Oct, item 30): "Recommended: yes, 0.9". Team job team_fix_c78f. Needs a robot proof by CE 02 (CDCALC Boyd's example with a known hard area, switch-off control). The guidebook figure is not yet confirmed (guidebook audit session).
34. **B-034 BUG-1097, the 300 mm minimum head check uses the head left after pipe losses (PR #1772 was installed with the typed head).** Tim (item 31). A warning only. Team job team_fix_c78g. Robot proof: a charged-system example where typed head is above 300 mm and head after losses is below it (warning appears; switch-off control keeps the old answer).

35. **B-035 F-023, the colleague-defaults export: Max's starting settings equal Tim's (including options.pipeObjectUpgrade On so Max gets the one-piece pipe object).** Control Room ask 29 Oct 12:20; Tim's standing rule 24 Sep ("colleagues get your exact install AND your switches"); Tim's ruling is QUESTIONS item 40 (CE 04). Built as a DRAFT on the recommended answer (pipe object ON for Max, plus one full test pass on Automatic). Two Team jobs: team_fix_c78k (Opus, read-only comparison of Tim's switches with the built-in defaults, report F023_COMPARISON_REPORT.md; started 12:32) then team_fix_c78l (Sonnet, build: shipped defaults file read only when a profile has no settings file, never overwriting an existing profile, no folder paths per BUG-1167, switch settings.firstStartUsesColleagueDefaults ON). Must be in the frozen candidate by Fri 6 Nov: planned for C-78. Proof for CE 02: a clean install on an ordinary (non-Tim) Windows login reads Tim's values on the Settings page for every exported key, the pipe object upgrade reads On and pipes are the one-piece object, no folder path from Tim's PC appears; control with the switch OFF reads the built-in defaults. The proof needs the spare ordinary login or the 2027 test PC (Tim organising); a headless unit proof exists meanwhile.
**Freeze fixes Tim named (item 32, "build all three before 6 Nov"):** BUG-1095 = B-017, BUG-1091 = B-019, BUG-1088 = B-020. They are in the C-78 job lanes below and in the frozen build. Robot proofs: B-017 a CDDESIGN Darebin example (council minimum C 0.80 applied; control switch off gives 0.70); B-019 a redesign of a DN450 pipe (grade not flatter than the Settings minimum; control gives the old flat grade); B-020 a 40 L/s connection (DN225 near 1 in 200, not DN100 at 1 in 3; control gives the old pick).
Not buildable (no B number): BUG-685 and BUG-1148 wait for Tim's rulings (21h, 21i); BUG-1166, 1169, 1170, 1209, 1210, 855, 865 are facts to gather; BUG-1171 needs a Shared train.
## Train calendar to the Fri 6 Nov freeze (PLANNED, estimates, not promises; written Thu 29 Oct 11:35 after Tim's "option b")

Tim's ruling (decisions\2026-10-29_TIM_RELEASE_FREEZE.md): release candidate frozen Fri 6 Nov, pilot Mon 16 Nov, last install by Fri 6 Nov before the pre-pilot re-test. Re-test rule (decisions\2026-10-29_TIM_RETEST_RULE.md): an install re-tests only the areas it touches, so each train lists its areas. Full re-tests: Sat 31 Oct, Sat 7 Nov, and before Max. How long a train takes (C-75 as the measure): assembler about 1 hour, Opus finalizer about 2 hours, payload about 40 minutes, so about 4 hours from start to a ready payload; the install then waits for AutoCAD to be closed and the robot lock. Builds run one at a time, so the nine backlog jobs and the trains queue behind each other.

1. **C-76 (Civil 3.0.86 / Manager 1.1.86): B-001, B-002, B-003, B-004 (+ B-005 only if the assembly report took #1838).**
   1. **Areas touched:** double-click on a downpipe (editing), CDCHECK wording, the Manager About window, the placing of DP, OF and floor waste (how fast the drawing is read), and (if B-005 is in) the New Pipe level suggestion.
   2. **Build:** assembler started Thu 29 Oct 10:27; payload ready about Thu 15:00 to 16:30. **Install:** Thu 29 Oct evening after 17:30 when AutoCAD is closed (install chain, undo stated at install). **Robot proof:** R09, R22, N31_dp_time (+ control C31), a Codex look at the About window.
2. **C-77 (Civil 3.0.87 / Manager 1.1.87, Manager only if the work touches it): B-005 (if not in C-76), B-006 to B-011, B-013, B-014, B-015.** B-009 (grip copy default) joins only after CE 02's robot pass with the switch ON; B-012 (cover to the outside of the pipe) joins if its Opus job is done by the assembly start, otherwise it goes to C-78.
   1. **Areas touched:** the New Pipe and Edit Pipe windows (Recent buttons), raingarden CDRG labels, Tidy labels and copy clean-up defaults, drawing import (units note), typed-figure parsing and pipe-speed check, pit drop warning, double-click on the green DP label, the computations sheet line.
   2. **Two build lanes from Thu 29 Oct 12:03 (Control Room ruling; each job in its own private worktree under C:\ce-fx):** lane 1 = B-006 (running since 10:20), then B-007, B-008, B-010, B-009; lane 2 = B-012 (Opus), then B-013, B-011, B-014. The lanes overlap in reading, thinking and editing; dotnet builds still run one at a time (the job texts wait while another build runs), which keeps Tim's PC responsive and keeps the C-76 finalizer from being starved. Estimate: both lanes done Thu about 17:00 to 20:00 if nothing stalls (about 70 percent that all nine make C-77); anything not PR-ready by Fri 06:00 moves to C-78.
   3. **Build:** assemble Fri 30 Oct early morning. **Install:** Fri 30 Oct evening after 17:30 (or Sat 31 Oct morning), so the full re-test on Sat 31 Oct runs on it.
3. **C-78 (engineering numbers): B-012 (if moved), B-016 to B-022, B-026.** Council minimum runoff, council time of concentration, minimum grade for DN450 and up, the pipe sizer, cover screens agreeing, the long section ground warning, the CDRULES cover note, the rainfall note wording.
   1. **Areas touched:** CDDESIGN and the sizing and detention figures, CDRULES, CDCHECK cover, the long section. This is the train that changes answers, so its robot proof is by worked examples (9.2 m style hand-checks, the Darebin C figure, the Maroondah Tc).
   2. **Also in C-78:** B-033 (BUG-905 ON) and B-034 (BUG-1097 head after losses). **Build:** two more lanes (chain_fix_c78_a with B-017, B-019, B-020, B-022, B-021; chain_fix_c78_b with B-033, B-034, B-018, B-016, B-026) start automatically when the C-77 lanes finish (Thu evening), so the fix jobs may be done by Fri; assemble when the C-77 train is through its finalizer. **Install:** Tue 3 Nov (Cup Day, a free day for the robot), earlier if C-77 is clear.
4. **C-79 (windows and looks): B-023, B-024, B-025, B-027, B-028; B-029 and B-030 only if finished by Mon 2 Nov.**
   1. **Areas touched:** the New Pipe Grade mismatch box, the Pit Schedule (delete cell, row height), the label tidy-up setting, colours in Civil windows and icons, and (if in) the CDDESIGN rainwater reuse boxes and AG drain copy labels.
   2. **Build:** Mon 2 to Tue 3 Nov, assemble Tue 3 Nov. **Install:** Wed 4 Nov evening, so the Codex looks (windows and pictures need a Codex look) run Thu 5 and Fri 6 Nov.
5. **C-80 (hotfix only, if needed): fixes for faults found by the Sat 31 Oct re-test and the Codex looks.** **Install:** no later than Fri 6 Nov morning. Nothing new goes in after this.
6. **Not in any train before the freeze:** B-031 (PIT slow), B-032 (BUG-1232 Drawing Border clash) until they are confirmed; BUG-685 and BUG-1148 (wait for Tim's rulings, QUESTIONS item 21); the facts bugs; BUG-1171 (needs a Shared train); the unbuilt 9 Nov-scope plan items (stay behind the pilot-critical work).
7. **Risks I can see now:** the finalizer is the slow step (about 2 hours each) and there are five trains in eight days; each install resets the two-pass clock for the areas it touches, so C-78 and C-79 are the ones that cost the most re-testing; B-029 and B-030 are large and may not make the freeze; Tim's PC has to be free of AutoCAD for each install.
## Rules for this register

1. **New number = next free B number**, written the same moment the work is queued; never reused, never deleted (D6).
2. **A bug fix keeps its BUG number beside the B number.** Building never creates a BUG number; only a fault found by a test or by Tim does (bug file, next free number).
3. **Updated at every 20-minute check** by CE 01. If it disagrees with a PR, the PR is right: fix the register and say so in DESK_LOG.
