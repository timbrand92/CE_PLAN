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

5. **B-005 BUG-1229, grade shown flatter than the grade chosen (1 in 102 for 1 in 100).** PR #1838 (29 Oct 10:35). Switch pipe.suggestedLevelNeverFlatterThanGrade ON. Built yes; tested unit only (net10 20,853 passed, 0 real failures); installed no; Tim-accepted no. Promoted in the C-76 list at 10:35 after the assembler had started: in C-76 only if the assembly report says so, otherwise the next train. Robot proof N32_cd_grade_never_flatter, control N32_off.
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

Not buildable (no B number): BUG-685 and BUG-1148 wait for Tim's rulings (21h, 21i); BUG-1166, 1169, 1170, 1209, 1210, 855, 865 are facts to gather; BUG-1171 needs a Shared train.
## Rules for this register

1. **New number = next free B number**, written the same moment the work is queued; never reused, never deleted (D6).
2. **A bug fix keeps its BUG number beside the B number.** Building never creates a BUG number; only a fault found by a test or by Tim does (bug file, next free number).
3. **Updated at every 20-minute check** by CE 01. If it disagrees with a PR, the PR is right: fix the register and say so in DESK_LOG.
