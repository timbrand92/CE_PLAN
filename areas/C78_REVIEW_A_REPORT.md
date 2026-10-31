# C-78 batch case review A (Opus-Team-C78rev-A, Sun 1 Nov 2026)

1. **Answer:** 14 cases reviewed: 1 ACCEPT FULL (N23v87), 13 ACCEPT PART, 0 NOT YET, 0 ALREADY. 14 slips written.
2. **Hashes:** all 14 case files match the sha256 in c78rev_list_1.txt. N24's old slip (sha 323E733A..., 3.0.85) was copied to N24_...review.txt.old, then replaced.
3. **Weakest three:** (a) N33_grade_mismatch_x_off: a control that passes on 3.0.87 too; it proves the switch, not the fix. (b) N33c: also a control (passes before and after the fix); its twin only claims the opposite. (c) N06v87: IL text, label and pipe layers are only recorded, and its red is the case changing CLAYER itself.
4. **UNSOURCED items:** none. Every asserted word traces to source at 3fbb9da5 or was seen on a run (listed per case).
5. **Too weak to fail:** N17 'history absent Undid:' (only CD's [Undo] prints it; this case never uses it).
6. **Mirror twins, not broken inputs:** N33a, N33b and N33c twins only claim the opposite; N06 and N28 twins change CLAYER themselves. All five fail on a CHECK, not a stall. The true switch-off red for N33a/b is N33s (not in this list).
7. **No twin on this build:** N24 (last red N24_BROKEN on 3.0.85, n3c4); N33_x (red partner is N33_x_off); N33_x_off (control).
8. **Codex must SEE:** N20 leader arrow on the pipe and its clearance; N33_x box look at 100/125/150 per cent; N33_x_off Esc/X placing the pipe; N33c window look.
9. **Time:** 08:10:30 to 08:15:08 Melbourne by the date command (about 5 minutes on the clock).
10. **Wrote:** 14 .review.txt slips and this report; nothing else changed.
11. **Not done:** no AutoCAD, no driver, no build, no case edits, no commits.
12. **Detail below**, one entry per case.

## Cases

1. **N06v87, ACCEPT PART.** Proves: CLAYER stays BLOCKS after PIT and CD, nothing new on 0 or BLOCKS, pit on STORMWATER PIT (LayerService.cs 142), arrow on ARROW (138, TIM_CVL_ARROW ArrowService.cs 41). Not: IL text, label and pipe layers (recorded only, card D24 assertion 2), pit label layer (N05), Esc paths (N28), never-recolour (not built). Twin tW1 fails on the check ('0'), self-made.
2. **N17v87, ACCEPT PART.** Proves D19 profile A: U echoes CD (pipe gone, pit stays), U echoes PIT (nothing left), U after MOVE of P3 echoes MOVE and restores Y -25569.8 (seen N07/R12). Not: profile B, REDO. Weak: 'absent Undid:'. Twin fails on the MOVE echo check ('U | COPY').
3. **N18v87, ACCEPT PART.** Proves D19 profile B for a placed pipe: 'Undid: point 3 of the pipe route.' (CdCommandLineSpecRules.cs 175/180), two-point pipe, U echoes CD and leaves nothing. Not: the Esc ending (N07), REDO. Twin (no U) fails on count 5.
4. **N19v87, ACCEPT PART.** Proves 50 mm out caught (PipeEndWallSnap.cs 79), 150 mm out free (PipeEndClassification.cs 250). Not: the 90/110 boundary (N23). Opening 450 mm from remembered size (seen R02). Twin fails on the Flow check with CD completed.
5. **N20v87, ACCEPT PART.** Proves a 2 m pipe asks 'Snap callout arrow to pipe:' (TextService.cs 401), one multileader, no plain label, no cancel. Not: arrow point on the pipe, leader wording (Codex). EXPECTED says clicks at 151000, steps click at 150300 (wording only). Twin (20 m) fails on leader count 0.
6. **N23v87, ACCEPT FULL.** Proves card D02's three assertions at the 90/110 mm edge, 1 mm tolerances, two Flow lines, three free ends. Limits: snaps off on purpose; pit 450 not Tim's 600 x 900 (fails, never passes, if different). Twin changes only 90 to 110 and fails on the Flow check.
7. **N24, ACCEPT PART.** New text now covers whole-map equality after No and after U, and X1 after Yes (the old slip's gaps). The 'hits' back-reference captures the whole list (JSON read in aF2). Not: DBMOD (recorded), TG, Pit Schedule half (N15), the numbering rule (Tim). No twin re-run on 3.0.88.
8. **N27v87, ACCEPT PART.** Proves the hand-moved invert text is counted 'Placed by hand (left alone) 1' (TidyLabelsSummaryRule.cs 66) and moves 0 mm after Yes. Not: pit-move step 3, profile A, the pipe label itself. Twin (switch off) fails both checks, text moved 275 mm: a true red.
9. **N28v87, ACCEPT PART.** Proves CLAYER stays BLOCKS after five PIT/CD endings ('[CE] CD command cancelled.' CdCommand.cs 99/188; 'Cancel without saving' WorkshopEditorFocus.cs 286). Not: never-recolour, label layers. Twin self-made.
10. **N33_grade_mismatch_x, ACCEPT PART.** Proves BUG-857 Cancel: button, 'places no pipe' line, cancelled line (GradeMismatchChoiceRule.cs 33), log line (CdCommand.cs 597), nothing drawn, file unchanged. Tim's ruling 'Esc = Cancel' (25 Sep rulings line 1833). Not: Esc and the X, the look.
11. **N33_grade_mismatch_x_off, ACCEPT PART.** Proves switch off gives the two-button box. A control. Not: Esc/X places the pipe (Codex).
12. **N33a, ACCEPT PART.** Proves 'I know one end' ON at 19.45 skips the window, IL 19.45 / 19.40. Not: label 1 IN 100, N33s. 3.0.87 window from pre-review, not a recorded run.
13. **N33b, ACCEPT PART.** Proves CE's own 19.40 skips the window after the upstream box is cleared. Not: the plain route without clearing, label grade, N33s.
14. **N33c, ACCEPT PART.** Proves a typed 19.37 still asks ('Use 1 IN 51', 'Keep 1 IN 100', xaml.cs 25/26). A control. Not: N33d to N33f, the answers, the look.
