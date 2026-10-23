# Open PR pile triage, Sat 24 Oct 2026

Headless job from desk plan/03, Team (Sonnet). Read-only: nothing was closed, labelled, merged, built, deployed or pushed to a PR branch. Snapshot of the open PRs taken at about 03:17 Melbourne time on Saturday 24 Oct.

## ANSWER FIRST

1. **The pile is 1310 open PRs, not about 1,300.** About three in five (787) are already inside the installed code, so only about 298 have never been looked at and are not a duplicate, old or already installed.

2. **Count per class:**
   1. **Class A** (already inside installed code (Civil 3.0.72 / Manager 1.1.72 / Structural 1.0.122)): **787**
   2. **Class B** (in the planned C-63 or S-43 train): **34**
   3. **Class C** (independently reviewed MERGE or MERGE-WITH-FIXES, not in a train): **9**
   4. **Class D** (independently reviewed HOLD or REJECT): **14**
   5. **Class E** (NOT reviewed, fixes a bug still open, matters for the 9 Nov pilot): **134**
   6. **Class F** (NOT reviewed, plan work): **164**
   7. **Class G** (duplicate or superseded by another PR): **21**
   8. **Class H** (old or stale, or fixes a bug the carpark already shows FIXED): **147**

3. **Count per branch prefix** (A, B, C, D, E, F, G, H):
   1. **b03/** 163 PRs: A=105, B=0, C=0, D=0, E=34, F=1, G=7, H=16
   2. **claude/** 957 PRs: A=617, B=0, C=1, D=1, E=87, F=156, G=5, H=90
   3. **cx/** 26 PRs: A=15, B=0, C=1, D=3, E=1, F=0, G=6, H=0
   4. **cx2/** 33 PRs: A=0, B=5, C=0, D=4, E=8, F=0, G=0, H=16
   5. **cx3/** 4 PRs: A=0, B=0, C=0, D=0, E=1, F=2, G=0, H=1
   6. **cx4/** 7 PRs: A=0, B=0, C=2, D=5, E=0, F=0, G=0, H=0
   7. **fw2/** 25 PRs: A=22, B=0, C=0, D=1, E=0, F=0, G=2, H=0
   8. **fb/** 32 PRs: A=0, B=28, C=4, D=0, E=0, F=0, G=0, H=0
   9. **others/** 63 PRs (b04/ 6, codex/ 57): A=28, B=1, C=1, D=0, E=3, F=5, G=1, H=24

4. **Three things Tim should know first:**
   1. **The C-63 train branch already exists.** `claude/rel-20261024m` (tip 28987b73, 24 Oct) holds 28 of the 29 PRs in the C-63 list. Only #1706 (FB-12, left out on purpose) is not in it. It is built from the installed 3.0.72 line but is not installed.
   2. **Most of the pile is shipped history.** 785 heads are ancestors of the installed Civil/Manager or Structural branch, so closing them (Tim's call, not mine) loses nothing. Another 147 are old or already shown FIXED in the carpark.
   3. **Over half of class E is one batch.** 70 of the 134 were opened on 22 and 23 Oct, the Fix-wave PRs from #1561 up (about 40 of the 56 in #1561 to #1644 are Civil, the rest Structural). None has an independent review and none is in C-63. Review these first.

5. **The 30 best class E PRs, ranked for review** (Civil and Manager daily tools first, then small, recent, one open bug each). Each has its own "BUG" in the carpark with no FIXED mark.

   1. **#1642** (BUG-988, Civil, 98 lines): When a drawing has its own CE record that is empty, CE no longer falls back to an old file on the PC (touches a protected file).
   2. **#1672** (BUG-918, Manager, 30 lines): Manager stops promising an update will finish by itself when no installer is connected.
   3. **#1569** (BUG-1008, Civil, 67 lines): Double-click a Remarks cell in the Pit Schedule and it opens for typing.
   4. **#1565** (BUG-1003, Civil, 135 lines): CEFIND finds pits such as P1A and C2, and the pipes between them.
   5. **#1643** (BUG-982, Civil, 137 lines): CDPROPAGATE judges levels as written to two decimals, so it stops flagging a level that already matches (protected file).
   6. **#1597** (BUG-1024, Civil, 102 lines): CDSPINEUPGRADE Apply brings a rebuilt CE record back in step with the drawing.
   7. **#1593** (BUG-1021, Civil, 141 lines): CDTWL checks the lid level of a pit whose floor level is unknown.
   8. **#1578** (BUG-1012, Civil, 85 lines): Long section now reads the closing side of a closed boundary line.
   9. **#1626** (BUG-998, Civil, 113 lines): Network redesign: before levels are set, each pipe keeps its own levels.
   10. **#1627** (BUG-997, Civil, 130 lines): Update Existing changes only the older long section you picked.
   11. **#1628** (BUG-1005, Civil, 104 lines): CDRENUMBER counts the joining pipe when it numbers the main line.
   12. **#1629** (BUG-1022, Civil, 184 lines): A pit CE finds again keeps its schedule override and its row position.
   13. **#1631** (BUG-981, Civil, 105 lines): A Pit Schedule built from two Xrefs keeps each drawing's pits as separate groups.
   14. **#1573** (BUG-1007, Civil, 62 lines): CDFALL arrow points the way you picked in a metre drawing.
   15. **#1588** (BUG-994, Civil, 59 lines): Inspector shows a pipe's drawn length correctly through the drawing's units.
   16. **#1599** (BUG-995, Civil, 52 lines): Inspector health buttons zoom to the right pits when the UCS has been moved.
   17. **#1614** (BUG-1009, Civil, 61 lines): Clicking an Xref row in the Pit Schedule no longer looks in the current drawing.
   18. **#1561** (BUG-980, Civil, 87 lines): CDCALC Pipe Flows refills the grade when a second pipe is picked.
   19. **#1641** (BUG-996, Civil, 101 lines): Mirrored CD text keeps its link to the pipe.
   20. **#1644** (BUG-999, Civil, 127 lines): CDRUNSOLVE stops saying every invert matches when it solved nothing (wording half; compare with installed #1617).
   21. **#1657** (BUG-917, Manager, 233 lines): Manager shows Approved, Copied and Installed as separate update stages.
   22. **#1691** (BUG-961, Manager, 139 lines): Manager shows the running build and the installed build as separate fields.
   23. **#1554** (BUG-799, Civil, 324 lines): An unloaded Xref shows its true status in the Pit Schedule instead of SOURCE MISSING.
   24. **#1656** (BUG-904, Civil, 82 lines): CDDESIGN warns when the shortest storm tried is the one that governs storage.
   25. **#1655** (BUG-906, Civil, 95 lines): Council storage grade is left unknown when the detention length is missing.
   26. **#1640** (BUG-992, Civil, 169 lines): CDXREFCOMPARE also checks where a moved shape used to be.
   27. **#1601** (BUG-1001, Civil, 70 lines): X-Civil import: two close pits each keep their own label.
   28. **#1607** (BUG-1000, Civil, 71 lines): X-Civil import moves spot levels and FALL arrows with their pits and pipes.
   29. **#1616** (BUG-1002, Civil, 73 lines): X-Civil import: a rotated FALL arrow block keeps its direction.
   30. **#1423** (BUG-787, Civil, 376 lines): Typed Pit Schedule figures follow their pit or inlet pipe (Settings switch, ON).

6. **The 20 best class F plan-work PRs** (Manager update rules first, then Civil daily-tool plan items). Most are "engine only, no caller", so they cannot be driven in AutoCAD yet; they need a command card before review.

   1. **#1314** (Civil, 30 lines): CDTIDYLABELS whole stack with a ribbon button; Settings switch OFF.
   2. **#1198** (Manager, 265 lines): Manager M05: each update attempt on each PC gets a plain-words result, never "unknown".
   3. **#1200** (Manager, 207 lines): Manager M07: a support bundle is never called complete with a part missing.
   4. **#1195** (Manager, 208 lines): Manager M03: names the exact missing standard files with one repair line.
   5. **#1190** (Civil, 215 lines): Checks Explain: one plain explanation per finding, citing the rule and source.
   6. **#1086** (Civil, 279 lines): New Pit opens on the pit type and size last placed in this job (Settings, OFF).
   7. **#1084** (Civil, 150 lines): UX-CR-05: short offcut rule for pipe splits (engine only).
   8. **#1070** (Civil, 207 lines): Batch 6 card 6.7: long section office layout rules (engine only).
   9. **#1048** (Civil, 158 lines): UX-CR-08: council minimum concrete pipe class, with a default and a warning.
   10. **#1039** (Civil, 225 lines): C4 B5: pipe size check worded Matches / Different / Can't verify by job mode.
   11. **#1037** (Civil, 260 lines): K-REQ-01: plan of which Pit Schedule cells CDPROFILE Apply would write.
   12. **#1192** (Civil, 150 lines): R-00 Civil 7/8: step-iron depth read from Settings in the Pit Schedule and pit advice.
   13. **#1199** (Civil, 128 lines): R-00 Civil 33: pit cover text offset is one Settings value used by PIT and Edit Pit.
   14. **#1196** (Civil, 97 lines): R-00 Civil 17: note when the longest storm tried governs storage (Settings, OFF).
   15. **#1191** (Civil, 188 lines): UX-SET-03/06: Settings history keeps a reason; sources named Office, Job, Council.
   16. **#1033** (Civil, 101 lines): Set C item 5: sizing standards can read the Settings minimum cover (switch OFF).
   17. **#1021** (Civil, 103 lines): Set C item 2: long section can read the Settings roughness table (switch OFF).
   18. **#1040** (Civil, 166 lines): INT-075: Civil ribbon labels as Name (COMMAND) behind a Settings switch (OFF).
   19. **#1047** (Civil, 68 lines): Batch 1 Q3: plastic pit PP cover-text line is CE's wording, not saved as text above.
   20. **#1302** (Civil, 21 lines): UX-RFI-01/02/03: a council RFI letter becomes a to-do list (engine only, Settings OFF).

7. **What I did NOT do, so nothing here is overstated:**
   1. **No build, no test run, no merge dry run.** Whether an E or F PR still merges cleanly onto the installed line is unknown. Class H "stale" is judged by branch age and last change, not by a conflict check.
   2. **Class A "contained" means git ancestry only** (plus a same-patch check on small recent branches, which found none). A fix that was re-typed by hand into the train would show as E, not A.
   3. **Class G is a guess from two signals:** the same BUG number and similar wording. Ten supersessions are named in the reviews or PR text. The rest need a quick look before anyone closes them.
   4. **Bug status uses the first "Status" line of each carpark entry.** "OPEN" there can still mean "fix installed, awaiting Codex test". I did not edit the carpark.
   5. **GitHub's own list command failed** (HTTP 502 on its GraphQL route), so I used the REST list and measured PR size with git in my own copy (`C:\ce-tr`). Any PR opened after about 03:17 (for example #1722 and up) is not in these counts.
   6. **Reviews:** I counted only independent reviews (Opus REVIEW_ files, Codex group reviews, the older review-lane log). Builder reports (FB_TEAM_BATCH, MAX_BUILD) are not reviews.

## Method, in short

1. **List:** all open PRs by the GitHub REST list, each head fetched into a bare copy at `C:\ce-tr\repo.git` (its own folder; the real clone was only read).
2. **Installed code:** `claude/rel-20261023m` (f7f7d551, Civil 3.0.72 / Manager 1.1.72) and `claude/rel-20261023s` (e6d597c0, Structural 1.0.122), both confirmed on GitHub before starting.
3. **Order of classes:** A first, then B, then C or D by review, then G, then H, then E or F. A PR lands in the first class that fits.
4. **Reviews read:** every REVIEW_*.md, CODEX_PR_REVIEW_GROUP*.md, FB_TEAM_BATCH*_REPORT.md and MAX_BUILD_*_REPORT.md in `C:\CE_PLAN\areas`, plus `release-v3-colleagues-REVIEWLANE_LOG.md`. A PR reviewed more than once takes the newest verdict.
5. **Train lists:** PR numbers from `desk_jobs\make_c63_files_job.txt` and `make_s43_files_job.txt` (no TRAIN_C63 area file exists yet).

## Full list, grouped by class

### Class A - already inside installed code (Civil 3.0.72 / Manager 1.1.72 / Structural 1.0.122) (787)

1. **#12** `claude/mlines-glitch-investigation-0q3jgp` class A: head is an ancestor of installed Structural 1.0.122 branch
2. **#22** `claude/ce-civil-batch-editor-tokens-24b640` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
3. **#56** `codex/level2-readonly-evidence` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
4. **#349** `claude/bug-189-perf-timing` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
5. **#350** `claude/bug-189-speed-fix` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
6. **#351** `claude/bug-189-struc-speed` class A: head is an ancestor of installed Structural 1.0.122 branch
7. **#354** `claude/bug-160-typed-flag` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
8. **#355** `claude/cdrenumber-ask-outlet` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
9. **#356** `claude/bug-189-speed-round2` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
10. **#357** `claude/bug-190-save-flush` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
11. **#358** `claude/bug-189-speed-round3` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
12. **#359** `claude/bug-191-use-plan-label-command` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
13. **#360** `claude/bug-189-speed-round4` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
14. **#361** `claude/bug-186-grade-survives-existing` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
15. **#362** `claude/bug-193-schedule-size` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
16. **#363** `claude/bug-067-schedule-from` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
17. **#364** `claude/bug-167-zip-hang` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
18. **#365** `claude/bug-062-import-pit-rotation` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
19. **#366** `claude/bug-064-dashboard-summary` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
20. **#367** `claude/bug-011-012-text-justify` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
21. **#368** `claude/bug-065-trim-imported-pipes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
22. **#370** `claude/bug-079-fall-symbol-land` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
23. **#371** `claude/cdslab-falls-follow-cdfall` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
24. **#372** `claude/cd-branch-01-part1` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
25. **#373** `claude/cd-branch-01-part2` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
26. **#374** `claude/v3ux-edit-01` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
27. **#375** `claude/v3ux-edit-04` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
28. **#376** `claude/v3ux-ux-surv-03` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
29. **#377** `claude/v3ux-ux-cmd-02` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
30. **#379** `claude/v3ux-ux-edit-02` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
31. **#380** `claude/bug-194-pipe-tab-plain-polyline` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
32. **#381** `claude/civil-quiet-in-non-civil-drawings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
33. **#383** `claude/v3ux-ux-resume-01` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
34. **#384** `claude/x1-cd-levels-fixes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
35. **#387** `claude/bug200-201` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
36. **#388** `claude/bug197` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
37. **#389** `claude/a6-implvl` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
38. **#390** `claude/ux-msg` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
39. **#391** `claude/a5-pick` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
40. **#393** `claude/bug203-quiet` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
41. **#394** `claude/ux-mgr` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
42. **#395** `claude/ux-pipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
43. **#396** `claude/l1-learn` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
44. **#398** `claude/c1-undo` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
45. **#400** `claude/c2-src` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
46. **#401** `claude/pipe-autojoin` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
47. **#402** `claude/s2-unit-copy` class A: head is an ancestor of installed Structural 1.0.122 branch
48. **#403** `claude/c4-calc` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
49. **#404** `claude/bug205-uphill` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
50. **#405** `claude/s3-notes` class A: head is an ancestor of installed Structural 1.0.122 branch
51. **#406** `claude/l3-levels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
52. **#407** `claude/bug198-again` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
53. **#409** `claude/bug207-sched` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
54. **#410** `claude/bug208-grip` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
55. **#411** `claude/bug209-area` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
56. **#412** `claude/bug224-close` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
57. **#413** `claude/c4-calc2` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
58. **#414** `claude/bug192-light` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
59. **#416** `claude/bug214-216` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
60. **#417** `claude/bug210-217` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
61. **#419** `claude/bug212-legacy-id` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
62. **#420** `claude/bug233-sources` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
63. **#421** `claude/bug230-units` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
64. **#422** `claude/bug223-editflow` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
65. **#423** `claude/bug232-scoped-locks` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
66. **#426** `claude/bug236-pd1-text` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
67. **#427** `claude/king5-storm` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
68. **#429** `claude/c4-des02-colours` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
69. **#432** `claude/c4-des03-agreed` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
70. **#433** `claude/landuse-field` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
71. **#434** `claude/c4-size02-unknown` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
72. **#435** `claude/c4-size13-network` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
73. **#437** `claude/c4-size-writer` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
74. **#438** `codex/w-during` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
75. **#439** `codex/w-landuse` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
76. **#440** `claude/s4-reobars` class A: head is an ancestor of installed Structural 1.0.122 branch
77. **#441** `codex/w-pipesizes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
78. **#442** `claude/bug257-close-cancel` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
79. **#443** `claude/bug258-pd-oops` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
80. **#444** `claude/bug261-direction` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
81. **#448** `claude/bug259-confirm-outlet` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
82. **#450** `claude/bug266-far-copy` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
83. **#452** `claude/bug256-redo-gate` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
84. **#453** `claude/bug270-reach-units` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
85. **#454** `claude/bug260-262` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
86. **#458** `claude/bug269-array-cleanup` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
87. **#460** `claude/bug267-268` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
88. **#464** `claude/bug275-palette-db` class A: head is an ancestor of installed Structural 1.0.122 branch
89. **#469** `claude/bug254-278` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
90. **#470** `claude/bug255-271` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
91. **#473** `claude/c4-fix-direction` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
92. **#474** `claude/c4-fix-copy` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
93. **#475** `claude/c4-fix-sizing` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
94. **#477** `claude/c4-fix-design` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
95. **#478** `claude/c4-fix-units` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
96. **#479** `claude/c4-fix-redo` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
97. **#486** `claude/s4-reobars-adv2-size` class A: head is an ancestor of installed Structural 1.0.122 branch
98. **#487** `claude/c4-fix-redo2` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
99. **#489** `claude/c5-locked-audit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
100. **#490** `claude/c5-oops-copy` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
101. **#491** `claude/c5-units-mixed` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
102. **#492** `claude/c5-refresh-direction` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
103. **#497** `claude/c5-bug308` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
104. **#501** `claude/c6-paste-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
105. **#502** `claude/c6-scaled-pit-record` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
106. **#503** `claude/c6-metre-locked` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
107. **#507** `claude/c6-c5-findings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
108. **#508** `claude/c6-metre-grade` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
109. **#513** `claude/c7-flat-pipes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
110. **#516** `claude/c7-metre-lengths` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
111. **#537** `claude/c7-paste-ownership` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
112. **#538** `claude/c7-batch-apply-cell` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
113. **#540** `claude/c7-pit-schedule-mixed` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
114. **#543** `claude/c7-design-buttons-all-tabs` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
115. **#545** `claude/test-log-redirect` class A: head is an ancestor of installed Structural 1.0.122 branch
116. **#547** `claude/s7-footing-draw-convert` class A: head is an ancestor of installed Structural 1.0.122 branch
117. **#548** `claude/c8-probe-fixes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
118. **#549** `claude/bug-346-copy-pit-labels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
119. **#550** `claude/bug-350-paste-line-pits` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
120. **#551** `claude/bug-350-batch-stale-cells` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
121. **#552** `claude/c9-unconnected-end-record` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
122. **#553** `claude/bug-352-raft-beam-mm-evidence` class A: head is an ancestor of installed Structural 1.0.122 branch
123. **#554** `claude/bug-352-schedule-width-by-mark` class A: head is an ancestor of installed Structural 1.0.122 branch
124. **#555** `claude/bug-355-fedit-outline-pick` class A: head is an ancestor of installed Structural 1.0.122 branch
125. **#556** `claude/bug-356-whats-new-modeless` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
126. **#557** `claude/c9-pit-move-locked-pipes-line` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
127. **#558** `claude/bug-358-fregenall-undo` class A: head is an ancestor of installed Structural 1.0.122 branch
128. **#559** `claude/c9-redirect-remaining-writers` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
129. **#560** `claude/c10-ui-accessible-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
130. **#561** `claude/c11-moved-pipes-keep-labels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
131. **#562** `claude/bug-362-fedit-strip-pick` class A: head is an ancestor of installed Structural 1.0.122 branch
132. **#563** `claude/bug-362-reo-bar-units` class A: head is an ancestor of installed Structural 1.0.122 branch
133. **#564** `claude/bug-365-struc-accessible-names` class A: head is an ancestor of installed Structural 1.0.122 branch
134. **#565** `claude/bug-365-civil-accessible-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
135. **#566** `claude/bug-366-reobar-layer-order` class A: head is an ancestor of installed Structural 1.0.122 branch
136. **#567** `claude/c11-quiet-paste-catcher` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
137. **#568** `claude/bug-367-struc-layer-keep` class A: head is an ancestor of installed Structural 1.0.122 branch
138. **#569** `claude/bug-368-struc-one-undo-step` class A: head is an ancestor of installed Structural 1.0.122 branch
139. **#570** `claude/bug-370-fm-kind-plain` class A: head is an ancestor of installed Structural 1.0.122 branch
140. **#571** `claude/bug-369-frozen-layer-line` class A: head is an ancestor of installed Structural 1.0.122 branch
141. **#572** `claude/bug-372-invert-text-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
142. **#573** `claude/b03-test-hygiene-civil-manager` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
143. **#574** `claude/b03-test-hygiene-structural` class A: head is an ancestor of installed Structural 1.0.122 branch
144. **#575** `claude/b03-quiet-start-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
145. **#576** `claude/b03-manager-plain-english` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
146. **#577** `codex/bj1-grade` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
147. **#578** `claude/bug-365-design-dropdown-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
148. **#579** `claude/bug-365-batch-editor-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
149. **#580** `claude/bug-365-pit-schedule-il-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
150. **#581** `claude/edit-pipe-cancel-dbmod` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
151. **#582** `claude/b03-array-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
152. **#583** `claude/bug-377-clash-warning-arrow` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
153. **#584** `claude/bug-376-sched-il-plan-fallback` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
154. **#585** `claude/bug-380-osmode-batch-leak` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
155. **#586** `claude/bug-381-fst-dbmod` class A: head is an ancestor of installed Structural 1.0.122 branch
156. **#587** `claude/b03-civil-wording-sweep` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
157. **#588** `claude/b03-fst-status-plain` class A: head is an ancestor of installed Structural 1.0.122 branch
158. **#589** `codex/bj1-revert` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
159. **#591** `codex/bj1-cell` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
160. **#592** `codex/bj1-level` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
161. **#593** `claude/tl2-fdn-outlines` class A: head is an ancestor of installed Structural 1.0.122 branch
162. **#594** `claude/b03-cdcheck-log-override` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
163. **#595** `claude/tl2-fdn-routes` class A: head is an ancestor of installed Structural 1.0.122 branch
164. **#596** `claude/b03-no-override-acad-guard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
165. **#597** `claude/tl2-struc-words` class A: head is an ancestor of installed Structural 1.0.122 branch
166. **#598** `claude/tl2-stale-pins` class A: head is an ancestor of installed Structural 1.0.122 branch
167. **#599** `claude/b03-arrow-emdash-sweep` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
168. **#601** `claude/b03-commandtruth-register` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
169. **#602** `claude/b03-bug378-upgrade-reads-own-record` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
170. **#603** `claude/tl2-bug384-locked-pipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
171. **#604** `claude/bug-385-revert-row-drop` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
172. **#605** `claude/tl2-fdn-prompts` class A: head is an ancestor of installed Structural 1.0.122 branch
173. **#606** `claude/tl2-fst-locked-line` class A: head is an ancestor of installed Structural 1.0.122 branch
174. **#607** `claude/tl2-fdn-cmd-prompts` class A: head is an ancestor of installed Structural 1.0.122 branch
175. **#609** `claude/b03-arrow-result-routes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
176. **#610** `claude/bug-385-sync-binds-record` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
177. **#611** `claude/b03-bug384-label-layer-explain` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
178. **#612** `claude/bug-385-cdsystem-binds-record` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
179. **#613** `claude/tl2-fdn-help-words` class A: head is an ancestor of installed Structural 1.0.122 branch
180. **#614** `claude/b03-manager-civil-window-words` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
181. **#615** `claude/b03-manager-audit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
182. **#616** `claude/b03-manager-greyed-reasons` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
183. **#618** `claude/pit-schedule-search-clears-on-open` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
184. **#619** `claude/tl2-bug388-fdelete-yesno` class A: head is an ancestor of installed Structural 1.0.122 branch
185. **#620** `claude/tl2-fst-failure-words` class A: head is an ancestor of installed Structural 1.0.122 branch
186. **#621** `claude/bug-385-keep-unsaved-record-on-switch` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
187. **#622** `claude/b03-bug228-cddiag-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
188. **#623** `claude/tl2-bextend-end-words` class A: head is an ancestor of installed Structural 1.0.122 branch
189. **#624** `claude/b03-bug226-discipline-hover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
190. **#625** `claude/b03-bug227-settings-hover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
191. **#626** `claude/bug-322-freeze-copy-keeps-all` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
192. **#627** `claude/bug-330-length-units` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
193. **#628** `claude/tl2-kw-once-structural` class A: head is an ancestor of installed Structural 1.0.122 branch
194. **#629** `claude/b03-bug239-council-source-words` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
195. **#630** `claude/tl2-struc-cmdline-words` class A: head is an ancestor of installed Structural 1.0.122 branch
196. **#631** `claude/b03-bug176-refusal-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
197. **#632** `claude/b03-bug252-material-words` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
198. **#633** `claude/b03-bug243-overlay-label-size` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
199. **#634** `claude/b03-bug389-cdcheck-arrow` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
200. **#635** `claude/b03-bug242-raingarden-area-note` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
201. **#636** `claude/b03-bug231-no-shutdown-write` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
202. **#637** `claude/bug-351a-pit-number-as-typed` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
203. **#638** `claude/b03-bug306-recent-values-file` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
204. **#639** `claude/tl2-fedit-outline-pick` class A: head is an ancestor of installed Structural 1.0.122 branch
205. **#640** `claude/b03-webview2-test-folders` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
206. **#641** `claude/int043-stop-overriding` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
207. **#642** `claude/r00-mannings-n-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
208. **#643** `claude/bug351b-achieved-grade-note` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
209. **#644** `claude/bug318-2-screenshots-temp` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
210. **#645** `claude/bug234-flat-pipe-moved-ends` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
211. **#646** `claude/bug331-4-longsection-grade-rule` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
212. **#647** `claude/tl2-bug388-rest` class A: head is an ancestor of installed Structural 1.0.122 branch
213. **#648** `claude/bug253-one-batch-preflight` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
214. **#649** `claude/bug318-1-calc-tests-order` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
215. **#650** `claude/cemanager-restore-minimised` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
216. **#651** `claude/tl2-units-plain-words` class A: head is an ancestor of installed Structural 1.0.122 branch
217. **#652** `claude/tl2-fst-no-undo-step` class A: head is an ancestor of installed Structural 1.0.122 branch
218. **#653** `claude/tl2-fst-footer-true-words` class A: head is an ancestor of installed Structural 1.0.122 branch
219. **#654** `claude/bug244-relink-resolve-with-levels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
220. **#655** `claude/bug-093-remove-dead-flip-grip` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
221. **#656** `claude/b03-bug176-pick-again-once` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
222. **#658** `claude/b03-bug246-skipped-cells-stale` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
223. **#659** `claude/bug-393-metre-record-lengths` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
224. **#660** `claude/bug-351a-label-cell-typed-number` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
225. **#661** `claude/bug-093-unused-grip-helpers` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
226. **#662** `claude/tl2-struc-report-pii` class A: head is an ancestor of installed Structural 1.0.122 branch
227. **#663** `claude/b03-manager-next-step-words` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
228. **#664** `claude/tl2-struc-plain-words` class A: head is an ancestor of installed Structural 1.0.122 branch
229. **#665** `claude/tl2-s17-lows` class A: head is an ancestor of installed Structural 1.0.122 branch
230. **#666** `claude/bug-393b-six-metre-readers` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
231. **#667** `claude/bug-385-more-binds-g` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
232. **#669** `claude/b03-manager-words-2` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
233. **#670** `claude/bug-351a-c2-followups` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
234. **#671** `claude/pit-place-dot-noise` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
235. **#672** `claude/tl2-decimetre-hold-card` class A: head is an ancestor of installed Structural 1.0.122 branch
236. **#673** `claude/tl2-relink-protect` class A: head is an ancestor of installed Structural 1.0.122 branch
237. **#674** `claude/tl2-undo-mark-log` class A: head is an ancestor of installed Structural 1.0.122 branch
238. **#675** `claude/tl2-roofdown-words` class A: head is an ancestor of installed Structural 1.0.122 branch
239. **#677** `claude/b03-bug318-3-manager-payload-tests` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
240. **#678** `claude/tl2-fdn-propose` class A: head is an ancestor of installed Structural 1.0.122 branch
241. **#681** `codex/k1-diag-words` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
242. **#683** `claude/b03-bug387-clayer-restore` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
243. **#684** `claude/b03-manifest-commands` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
244. **#685** `codex/k3-typed-mark` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
245. **#686** `claude/tl2-bug394-prompt-defaults` class A: head is an ancestor of installed Structural 1.0.122 branch
246. **#687** `claude/b03-plan-label-typed-number` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
247. **#688** `claude/tl2-wind-help-words` class A: head is an ancestor of installed Structural 1.0.122 branch
248. **#692** `claude/tl2-issue-preview-engine` class A: head is an ancestor of installed Structural 1.0.122 branch
249. **#695** `claude/b03-c5-repair-next` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
250. **#697** `claude/l3-levels-check-these-levels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
251. **#700** `claude/tl2-issue-dwg-snapshot` class A: head is an ancestor of installed Structural 1.0.122 branch
252. **#702** `claude/tl2-issue-jobwide-pdf` class A: head is an ancestor of installed Structural 1.0.122 branch
253. **#703** `claude/l3-sources-architect-dp` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
254. **#704** `codex/w1b-issue-preview-fix` class A: head is an ancestor of installed Structural 1.0.122 branch
255. **#705** `claude/b03-bug401-pit-cover-switch` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
256. **#711** `codex/s1-downpipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
257. **#715** `codex/s3-cover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
258. **#719** `codex/s3-issue` class A: head is an ancestor of installed Structural 1.0.122 branch
259. **#721** `claude/tl2-blank-rev-no-ticks` class A: head is an ancestor of installed Structural 1.0.122 branch
260. **#722** `claude/l3-levels-steep-warn` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
261. **#723** `claude/b03-bare-number-beside-p-refused` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
262. **#731** `claude/b03-new-pit-cover-blank-default` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
263. **#733** `claude/k-req-01-schedule-preview` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
264. **#734** `codex/n3-newpit-number` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
265. **#735** `claude/tl2-pointload-carrydown` class A: head is an ancestor of installed Structural 1.0.122 branch
266. **#736** `claude/tl2-member-schedule-plan` class A: head is an ancestor of installed Structural 1.0.122 branch
267. **#737** `claude/tl2-pointload-command` class A: head is an ancestor of installed Structural 1.0.122 branch
268. **#738** `claude/tl2-fdn-propose-s19` class A: head is an ancestor of installed Structural 1.0.122 branch
269. **#739** `claude/tl2-membersched-command` class A: head is an ancestor of installed Structural 1.0.122 branch
270. **#740** `b03/w10-stop-override-sentence` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
271. **#743** `claude/tl2-preview-prereqs` class A: head is an ancestor of installed Structural 1.0.122 branch
272. **#744** `claude/tl2-bt1-dot-bt1x` class A: head is an ancestor of installed Structural 1.0.122 branch
273. **#745** `b03/bug413-hashed-machine-file` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
274. **#746** `claude/tl2-btx-empty-window` class A: head is an ancestor of installed Structural 1.0.122 branch
275. **#747** `b03/bug396-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
276. **#748** `claude/tl2-bug405-report-fields` class A: head is an ancestor of installed Structural 1.0.122 branch
277. **#749** `claude/tl2-s19-lows` class A: head is an ancestor of installed Structural 1.0.122 branch
278. **#750** `claude/l3-levels-ghosts` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
279. **#752** `claude/l3-detention-draft-banner` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
280. **#753** `b03/bug224-close-handler-scan` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
281. **#757** `claude/tl2-usage-drawingname` class A: head is an ancestor of installed Structural 1.0.122 branch
282. **#758** `claude/b03-edit-pit-rename-clash` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
283. **#759** `claude/tl2-s20-low3-resize-mm` class A: head is an ancestor of installed Structural 1.0.122 branch
284. **#760** `claude/tl2-s20-low2-bt1-words` class A: head is an ancestor of installed Structural 1.0.122 branch
285. **#761** `claude/tl2-s20-low1-fdnpropose-help` class A: head is an ancestor of installed Structural 1.0.122 branch
286. **#762** `claude/b03-label-bare-number-sentence` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
287. **#763** `claude/b03-schedule-window-lookalike-warning` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
288. **#764** `claude/tl2-bug418-layer-merge` class A: head is an ancestor of installed Structural 1.0.122 branch
289. **#765** `claude/bug-417-ximport-never-unlock` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
290. **#766** `claude/bug-420-schedule-window-pit-number-commit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
291. **#769** `claude/bug-422-cover-unknown` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
292. **#770** `claude/tl2-cl4-brace-section` class A: head is an ancestor of installed Structural 1.0.122 branch
293. **#771** `claude/cl1-missing-not-zero` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
294. **#772** `claude/cl5-one-sizing-standards` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
295. **#773** `claude/cl3-detention-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
296. **#774** `claude/bug-423-civil-lows` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
297. **#775** `claude/tl2-sbeam-missing-size-named` class A: head is an ancestor of installed Structural 1.0.122 branch
298. **#776** `claude/tl2-s21-lows` class A: head is an ancestor of installed Structural 1.0.122 branch
299. **#777** `claude/flake-recent-values-retry` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
300. **#778** `claude/tl2-btx-no-undo` class A: head is an ancestor of installed Structural 1.0.122 branch
301. **#779** `claude/tl2-bt1-load-log` class A: head is an ancestor of installed Structural 1.0.122 branch
302. **#780** `claude/tl2-glued-login` class A: head is an ancestor of installed Structural 1.0.122 branch
303. **#782** `claude/manager-perf-fingerprint` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
304. **#783** `claude/manager-atomic-json` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
305. **#784** `claude/manager-ribbon-marshal` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
306. **#785** `claude/cl6-survey-markup-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
307. **#786** `claude/bug-426-c22-fixes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
308. **#787** `claude/tl2-bug428-bb-warn` class A: head is an ancestor of installed Structural 1.0.122 branch
309. **#788** `claude/priv7-civil-old-report` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
310. **#789** `claude/bug-427-flat-label` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
311. **#790** `claude/int068-pit-outlet-speed` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
312. **#791** `claude/int068-detention-warnings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
313. **#792** `claude/tl2-roof-area-setout` class A: head is an ancestor of installed Structural 1.0.122 branch
314. **#793** `claude/tl2-footing-width-asks` class A: head is an ancestor of installed Structural 1.0.122 branch
315. **#794** `claude/mgr-rollback-int069` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
316. **#795** `claude/mgr-pair-approve-int069` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
317. **#796** `claude/mgr-cesupport-no-upload-int069` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
318. **#797** `claude/mgr-report-coded-names-int069` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
319. **#798** `claude/tl2-sheet-sync-skip-open` class A: head is an ancestor of installed Structural 1.0.122 branch
320. **#799** `claude/tl2-settings-updated-trace` class A: head is an ancestor of installed Structural 1.0.122 branch
321. **#800** `claude/int070-speed-limit-labels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
322. **#801** `claude/mgr-who-is-this-int071` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
323. **#802** `claude/tl2-floor-span-arrow` class A: head is an ancestor of installed Structural 1.0.122 branch
324. **#803** `claude/bug-251-kingston-commercial` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
325. **#804** `claude/tl2-framing-legend` class A: head is an ancestor of installed Structural 1.0.122 branch
326. **#805** `claude/bug-351b-plan-marker` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
327. **#806** `claude/tl2-lintel-propose` class A: head is an ancestor of installed Structural 1.0.122 branch
328. **#807** `claude/bug-246-xref-badge` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
329. **#808** `claude/tl2-bug433-lows` class A: head is an ancestor of installed Structural 1.0.122 branch
330. **#809** `claude/bug-432-cdtg-blank-cover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
331. **#810** `claude/tl2-bug434-support-layer` class A: head is an ancestor of installed Structural 1.0.122 branch
332. **#811** `claude/mgr-damaged-file-read` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
333. **#812** `claude/tl2-bug437-enter-auto` class A: head is an ancestor of installed Structural 1.0.122 branch
334. **#814** `claude/bug-440-zero-length-pipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
335. **#815** `claude/tl2-bug438-cr1-number` class A: head is an ancestor of installed Structural 1.0.122 branch
336. **#816** `claude/mgr-cesupport-real-logs-bug442` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
337. **#818** `claude/tl2-r112-legend-fixes` class A: head is an ancestor of installed Structural 1.0.122 branch
338. **#819** `claude/bug-442-editpipe-flat` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
339. **#820** `claude/bug-432-remaining-screens` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
340. **#822** `claude/mgr-test-hygiene-no-real-files` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
341. **#823** `claude/bug-446-stale-marker-editpipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
342. **#825** `claude/tl2-level-carry` class A: head is an ancestor of installed Structural 1.0.122 branch
343. **#826** `claude/bug-435-civil-no-main-cuix-g` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
344. **#827** `claude/xcivil-endmatch-bug447` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
345. **#828** `claude/xcivil-snap-tolerances-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
346. **#829** `claude/bug-805-typed-level-wording-c` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
347. **#830** `claude/whatsnew-heading-installed-version` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
348. **#833** `claude/b1-pit-natural-sort` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
349. **#834** `claude/checks-offpit-record` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
350. **#835** `claude/b1-hand-placed-mark` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
351. **#836** `claude/checks-result-model` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
352. **#837** `claude/b1-cdtidylabels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
353. **#838** `claude/checks-ignore-store` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
354. **#839** `claude/b1-editpipe-retidy` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
355. **#840** `claude/checks-show-where` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
356. **#841** `claude/checks-slowdown-pause` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
357. **#845** `claude/b1-no-typ-label` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
358. **#846** `claude/tl2-r117-fsf-enter` class A: head is an ancestor of installed Structural 1.0.122 branch
359. **#847** `claude/b1-tidy-rearrange` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
360. **#848** `claude/tl2-r117-bug450-lows` class A: head is an ancestor of installed Structural 1.0.122 branch
361. **#849** `claude/b1-pp-cover-esc` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
362. **#850** `claude/b1-readable-text` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
363. **#854** `claude/tl2-r118-tiedown-names` class A: head is an ancestor of installed Structural 1.0.122 branch
364. **#857** `claude/tl2-r119-c1-esc-removes` class A: head is an ancestor of installed Structural 1.0.122 branch
365. **#858** `claude/pause-report-to-admin` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
366. **#859** `claude/tl2-r119-member-schedule` class A: head is an ancestor of installed Structural 1.0.122 branch
367. **#860** `claude/tl2-r119-schedule-place` class A: head is an ancestor of installed Structural 1.0.122 branch
368. **#861** `claude/tl2-r119-lintel-job` class A: head is an ancestor of installed Structural 1.0.122 branch
369. **#862** `claude/tl2-r119-beam-hover` class A: head is an ancestor of installed Structural 1.0.122 branch
370. **#863** `claude/tl2-r119-ab-wall` class A: head is an ancestor of installed Structural 1.0.122 branch
371. **#864** `b03/hunt-m01-fault-report-scrub` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
372. **#865** `claude/tl2-r120-s01` class A: head is an ancestor of installed Structural 1.0.122 branch
373. **#866** `b03/hunt-m-zip-cleaner-gaps` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
374. **#867** `claude/tl2-r120-s04` class A: head is an ancestor of installed Structural 1.0.122 branch
375. **#868** `b03/hunt-m02-rollback-hidden` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
376. **#869** `b03/hunt-m04-m05-status-truth` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
377. **#870** `claude/bug-457-redo-guard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
378. **#871** `b03/hunt-m06-menubar-switch` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
379. **#872** `b03/hunt-m07-support-zip-onedrive` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
380. **#873** `b03/hunt-m10-office-copy-guard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
381. **#874** `b03/hunt-m14-first-install-peruser` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
382. **#875** `b03/hunt-m12-m13-feedback-hover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
383. **#876** `b03/hunt-m15-startup-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
384. **#877** `b03/hunt-m09-cehealth-gaps` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
385. **#878** `b03/hunt-m11-short-staging-folders` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
386. **#879** `claude/tl2-r120-s02` class A: head is an ancestor of installed Structural 1.0.122 branch
387. **#880** `claude/hunt-c-01-refedit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
388. **#881** `claude/hunt-c-07-schedule-readonly` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
389. **#882** `claude/hunt-c-02-03-locked-annotation-layers` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
390. **#883** `claude/hunt-c-04-truthful-end-sentences` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
391. **#884** `claude/hunt-c-05-grade-mismatch-setting` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
392. **#885** `claude/hunt-c-06-schedule-level-decimals` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
393. **#886** `claude/tl2-r120-s10` class A: head is an ancestor of installed Structural 1.0.122 branch
394. **#887** `claude/tl2-r120-s07` class A: head is an ancestor of installed Structural 1.0.122 branch
395. **#888** `claude/audit-login-in-dwg` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
396. **#889** `claude/tl2-r120-s08` class A: head is an ancestor of installed Structural 1.0.122 branch
397. **#890** `claude/tl2-r120-s11` class A: head is an ancestor of installed Structural 1.0.122 branch
398. **#891** `claude/b1-pit-label-esc` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
399. **#893** `claude/tl2-r120-s12` class A: head is an ancestor of installed Structural 1.0.122 branch
400. **#894** `b03/hunt2-c02-connection-grade` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
401. **#895** `claude/tl2-r120-s14` class A: head is an ancestor of installed Structural 1.0.122 branch
402. **#896** `claude/b5-block-layer-office-colour` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
403. **#897** `claude/b5-bylayer-spoon-raingarden` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
404. **#898** `claude/tl2-r120-s15` class A: head is an ancestor of installed Structural 1.0.122 branch
405. **#899** `claude/tl2-r120-s05` class A: head is an ancestor of installed Structural 1.0.122 branch
406. **#900** `b03/hunt2-c03-boyds-blank` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
407. **#901** `claude/b5-rightclick-items` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
408. **#902** `claude/tl2-r120-s06` class A: head is an ancestor of installed Structural 1.0.122 branch
409. **#903** `b03/hunt2-c04-flows-job-curve` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
410. **#904** `claude/tl2-r120-b14-sched` class A: head is an ancestor of installed Structural 1.0.122 branch
411. **#905** `b03/hunt2-c06-hard-ground-c` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
412. **#906** `claude/tl2-r120-b14-prefix` class A: head is an ancestor of installed Structural 1.0.122 branch
413. **#908** `b03/hunt2-c10-assumed-roughness` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
414. **#909** `b03/hunt2-c05-predev-c-printed` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
415. **#910** `claude/b5-layer-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
416. **#911** `b03/hunt2-c08-09-landxml-unknowns` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
417. **#912** `claude/b5-existing-pits` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
418. **#913** `b03/hunt2-c14-no-detention-sentence` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
419. **#914** `claude/r00-step-irons` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
420. **#915** `b03/hunt2-c11-storm-still-rising` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
421. **#916** `claude/r00-text-heights` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
422. **#917** `claude/r00-cover-text-gap` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
423. **#918** `claude/r00-pervious-c` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
424. **#919** `claude/tl2-r121-reo-warns` class A: head is an ancestor of installed Structural 1.0.122 branch
425. **#920** `claude/r00-cddesign-detention-limits` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
426. **#921** `claude/tl2-r121-label-height` class A: head is an ancestor of installed Structural 1.0.122 branch
427. **#922** `claude/r00-suggested-level-decimals` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
428. **#923** `claude/tl2-r121-rebar-start` class A: head is an ancestor of installed Structural 1.0.122 branch
429. **#924** `claude/tl2-r121-pier-dia` class A: head is an ancestor of installed Structural 1.0.122 branch
430. **#926** `claude/b5-wrong-layer-rows` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
431. **#927** `claude/tl2-r122-link-admission` class A: head is an ancestor of installed Structural 1.0.122 branch
432. **#928** `b03/hunt2-c12-twl-pipe-storage` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
433. **#929** `claude/tl2-r122-wall-engine` class A: head is an ancestor of installed Structural 1.0.122 branch
434. **#930** `claude/tl2-r122-wall-commands` class A: head is an ancestor of installed Structural 1.0.122 branch
435. **#933** `claude/tl2-r122-lintel-table` class A: head is an ancestor of installed Structural 1.0.122 branch
436. **#935** `claude/tl2-r122-pier-link` class A: head is an ancestor of installed Structural 1.0.122 branch
437. **#936** `b03/hunt-m03-honest-installer-words` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
438. **#937** `claude/tl2-r122-pier-nocols` class A: head is an ancestor of installed Structural 1.0.122 branch
439. **#940** `claude/tl2-r122-screwpile-offer` class A: head is an ancestor of installed Structural 1.0.122 branch
440. **#942** `claude/tl2-r123-stud-wording` class A: head is an ancestor of installed Structural 1.0.122 branch
441. **#943** `claude/tl2-r123-bp-layer` class A: head is an ancestor of installed Structural 1.0.122 branch
442. **#946** `claude/tl2-r124-a10-dormant-bundle` class A: head is an ancestor of installed Structural 1.0.122 branch
443. **#947** `b03/hunt-m10-m14-low-fixes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
444. **#949** `claude/tl2-r125-markup-privacy` class A: head is an ancestor of installed Structural 1.0.122 branch
445. **#950** `b03/priv-xcivil-ai-default-no` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
446. **#951** `b03/priv-cdask-one-page-blanked` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
447. **#952** `b03/priv-civil-cloud-route-only` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
448. **#953** `b03/priv-ai-master-switch` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
449. **#955** `claude/tl2-r126-drawing-name-code` class A: head is an ancestor of installed Structural 1.0.122 branch
450. **#956** `claude/tl2-r126-ab-bb-units-layout-first` class A: head is an ancestor of installed Structural 1.0.122 branch
451. **#957** `claude/tl2-r126-markup-qa-caller` class A: head is an ancestor of installed Structural 1.0.122 branch
452. **#958** `b03/b6-suspect-point-warns` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
453. **#959** `b03/b6-survey-reach-limit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
454. **#961** `claude/hunt-c-13-flat-not-uphill` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
455. **#962** `claude/hunt-c-14-esc-reopen-prompt` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
456. **#963** `b03/b6-level-source` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
457. **#964** `claude/tl2-r126-r00-column-sizes` class A: head is an ancestor of installed Structural 1.0.122 branch
458. **#965** `claude/hunt-c-15-cdcheck-clear-selection` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
459. **#966** `claude/tl2-r126-issue-only-ticked` class A: head is an ancestor of installed Structural 1.0.122 branch
460. **#967** `claude/hunt-c-11-sps-next-free-number` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
461. **#968** `claude/hunt-c-10-sps-edit-footprint` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
462. **#969** `b03/b6-design-levels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
463. **#970** `claude/hunt-c-08-09-pit-text-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
464. **#971** `claude/plain-pit-pick-and-cdcheck-words` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
465. **#973** `claude/tl2-r127-undo-guard` class A: head is an ancestor of installed Structural 1.0.122 branch
466. **#974** `b03/b6-longsection-rows` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
467. **#975** `b03/r00-reuse-credit-profile` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
468. **#976** `b03/r00-pump-council-values` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
469. **#981** `claude/tl2-r128-reo-warn-defaults` class A: head is an ancestor of installed Structural 1.0.122 branch
470. **#982** `claude/bug558-idle-no-command` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
471. **#990** `claude/tl2-r129-redo-sweep` class A: head is an ancestor of installed Structural 1.0.122 branch
472. **#993** `claude/tl2-r130-markup-drawn-reader` class A: head is an ancestor of installed Structural 1.0.122 branch
473. **#994** `b03/redo-sweep-reverify` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
474. **#995** `claude/tl2-r130-markup-compare-engine` class A: head is an ancestor of installed Structural 1.0.122 branch
475. **#997** `claude/b6-crossing-services-rule` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
476. **#999** `claude/tl2-r131-wall-line-totals` class A: head is an ancestor of installed Structural 1.0.122 branch
477. **#1001** `claude/tl2-r131-beam-layer-settings` class A: head is an ancestor of installed Structural 1.0.122 branch
478. **#1002** `claude/bug558-global-redo-guard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
479. **#1003** `claude/b2-slow-work-progress` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
480. **#1006** `claude/tl2-r131-clarify-plan` class A: head is an ancestor of installed Structural 1.0.122 branch
481. **#1007** `claude/bug558-manager-menu-once` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
482. **#1009** `claude/b1-tidy-pit-labels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
483. **#1017** `claude/b1-tidy-leader-out` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
484. **#1090** `claude/bug-565-pit-number-attribute-lock` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
485. **#1145** `claude/b4-cplan09-tank-callout` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
486. **#1165** `claude/bug-522-shared-copies-differ` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
487. **#1166** `claude/b4-names-guard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
488. **#1169** `claude/bug-556-delete-dead-azure-publish` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
489. **#1170** `claude/b4-bug416-select-run-redo` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
490. **#1171** `claude/bug-557-fleet-heartbeat-switch` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
491. **#1176** `claude/b4-bug430-dblclick-pit-label` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
492. **#1203** `claude/tl2-r151-unlinked-posts` class A: head is an ancestor of installed Structural 1.0.122 branch
493. **#1206** `claude/tl2-r151-tiedown-sched` class A: head is an ancestor of installed Structural 1.0.122 branch
494. **#1209** `claude/tl2-r151-shorten-choices` class A: head is an ancestor of installed Structural 1.0.122 branch
495. **#1218** `claude/b4-bug542-longsection-roughness` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
496. **#1222** `claude/b4-bug521-inspector-cover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
497. **#1223** `claude/b4-bug544-xcivil-levels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
498. **#1224** `claude/b4-bug544-detention-tab-predev-c` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
499. **#1226** `claude/b3-bug476-first-admin-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
500. **#1227** `claude/tl2-r160-fj1-joist-layer` class A: head is an ancestor of installed Structural 1.0.122 branch
501. **#1228** `claude/b3-bug505-xcivil-units` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
502. **#1237** `claude/b3-bug452-trace-scrub` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
503. **#1239** `claude/b3-bug516b-one-freeboard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
504. **#1244** `claude/bug-pits-nonfirst-drawing` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
505. **#1253** `codex/v3-ux-test-20261013` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
506. **#1254** `codex/v3-ux-struc-test-20261013` class A: head is an ancestor of installed Structural 1.0.122 branch
507. **#1255** `codex/manager-header-contrast-20261014` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
508. **#1257** `codex/calc-warning-display-20261014` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
509. **#1259** `codex/catchment-result-state-20261015` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
510. **#1261** `codex/column-picker-instruction-20261015` class A: head is an ancestor of installed Structural 1.0.122 branch
511. **#1262** `codex/timber-picker-status-20261015` class A: head is an ancestor of installed Structural 1.0.122 branch
512. **#1263** `claude/mx03b-shared-pit-invert` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
513. **#1264** `claude/mx02-struc-locked-layers-583` class A: head is an ancestor of installed Structural 1.0.122 branch
514. **#1265** `claude/mx02-struc-hatch-619` class A: head is an ancestor of installed Structural 1.0.122 branch
515. **#1266** `claude/mx03b-shared-readonly-loader` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
516. **#1267** `claude/mx02-struc-dset-633` class A: head is an ancestor of installed Structural 1.0.122 branch
517. **#1268** `claude/mx03b-agi-direction` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
518. **#1269** `claude/mx03b-arc-area` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
519. **#1270** `claude/mx02-struc-purlin-esc-585` class A: head is an ancestor of installed Structural 1.0.122 branch
520. **#1271** `claude/mx03b-bug588-savedlist` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
521. **#1272** `claude/mx02-struc-windclass-504` class A: head is an ancestor of installed Structural 1.0.122 branch
522. **#1273** `claude/mx02-struc-version-575` class A: head is an ancestor of installed Structural 1.0.122 branch
523. **#1274** `claude/mx04-pipeflows` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
524. **#1275** `claude/mx04-charged` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
525. **#1276** `claude/mx03-r2-landxml-inverts` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
526. **#1277** `claude/mx03-r2-rating-reader` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
527. **#1278** `claude/mx02-r2-a439-scale` class A: head is an ancestor of installed Structural 1.0.122 branch
528. **#1279** `claude/mx03-r2-compare-score` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
529. **#1280** `claude/mx03-r2-checkdwg-report` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
530. **#1281** `claude/mx04-exportwriter` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
531. **#1282** `claude/mx02-r2-a439-sysvars` class A: head is an ancestor of installed Structural 1.0.122 branch
532. **#1283** `claude/mx03-r2-sched-precision` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
533. **#1284** `claude/mx03-r2-profile-linetype` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
534. **#1285** `claude/mx02-r2-a439-space` class A: head is an ancestor of installed Structural 1.0.122 branch
535. **#1286** `claude/mx04-remarks` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
536. **#1287** `claude/mx02-r2-a439-fastsave` class A: head is an ancestor of installed Structural 1.0.122 branch
537. **#1288** `claude/mx03-r3-surface-drain-identity` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
538. **#1289** `claude/mx04-pitxlsx` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
539. **#1290** `claude/mx03-r3-profile-regen` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
540. **#1291** `claude/mx03-r3-profile-title` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
541. **#1292** `claude/mx03-r3-calc-level-direction` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
542. **#1293** `claude/mx03-r3-catchment-style` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
543. **#1294** `claude/mx02-r2-a439-causes` class A: head is an ancestor of installed Structural 1.0.122 branch
544. **#1295** `claude/mx02-r2-a439-dynprop` class A: head is an ancestor of installed Structural 1.0.122 branch
545. **#1296** `claude/mx04-handles` class A: carpark BUG-360 says fix installed via this PR number
546. **#1297** `claude/mx03-r4-bug518-ribbon-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
547. **#1298** `claude/mx02-r3-ad01-sectionmark-632` class A: head is an ancestor of installed Structural 1.0.122 branch
548. **#1299** `claude/mx03-r4-win02-placement` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
549. **#1300** `claude/mx02-r3-ad01-dset1-635` class A: head is an ancestor of installed Structural 1.0.122 branch
550. **#1301** `claude/mx03-r4-win03-preview-quiet` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
551. **#1303** `claude/mx04-r2-names-guard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
552. **#1304** `claude/mx02-r3-ad01-mleader-622` class A: head is an ancestor of installed Structural 1.0.122 branch
553. **#1306** `claude/mx02-r3-ad01-secnum-13` class A: head is an ancestor of installed Structural 1.0.122 branch
554. **#1307** `claude/mx04-r2-plain-errors` class A: carpark BUG-523 says fix installed via this PR number
555. **#1308** `claude/mx03-r4-bug603-read-then-apply` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
556. **#1309** `claude/mx03-r4-chk02-drafter` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
557. **#1310** `claude/mx03-r4-bug524-window-titles` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
558. **#1311** `claude/mx03-fix-xcivil-preflight-esc` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
559. **#1312** `claude/tl2-r429-issue-unticked` class A: head is an ancestor of installed Structural 1.0.122 branch
560. **#1313** `claude/mx-edit-windows-a684ae` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
561. **#1315** `claude/mx-checks-list-a9197708` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
562. **#1316** `claude/mx-dblclick-all-af46b1` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
563. **#1317** `claude/b3-cascade-652-655` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
564. **#1318** `claude/b4-pit-resnap-flow-q` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
565. **#1319** `claude/b4-edit-pipe-flow-only` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
566. **#1320** `claude/b4-flow-arrow-zero-level` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
567. **#1321** `claude/b4-cd-existing-line-arcs` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
568. **#1322** `claude/b3-relink-recorded-659` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
569. **#1323** `claude/b4-pit-number-source` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
570. **#1324** `claude/b4-pit-lid-wording` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
571. **#1325** `claude/b4-schedule-level-breakline` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
572. **#1326** `claude/b4-pit-resnap-batch-turn` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
573. **#1327** `claude/b4-batch-grade-688-689` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
574. **#1328** `claude/b3-clone-policy-665` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
575. **#1329** `claude/b3-pickend-ucs-661` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
576. **#1330** `claude/b3-upgrade-merge-662` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
577. **#1331** `claude/b3-units-663-695-696` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
578. **#1332** `claude/b3-dispcache-673` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
579. **#1333** `claude/b3-relink-keep-list-660` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
580. **#1334** `claude/b3-followed-set-669` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
581. **#1335** `claude/b3-split-paired-691` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
582. **#1336** `claude/b3-erased-label-667` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
583. **#1337** `claude/b3-clone-rest-670` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
584. **#1338** `claude/b4-bug697-existing-line` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
585. **#1339** `claude/b4-bug698-cdsync-sizes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
586. **#1340** `claude/bug-698-recovery-scan-recorded-size` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
587. **#1342** `claude/b4-bug711-spot-level-reader` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
588. **#1343** `claude/b4-bug744-fixtags-no-new-label` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
589. **#1344** `claude/b4-bug712-cdsl-locked-layer` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
590. **#1345** `claude/b4-bug743-745-trench-grate` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
591. **#1346** `claude/b4-bug715-design-offer-constrained` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
592. **#1347** `claude/b4-bug718-level-text-culture` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
593. **#1348** `claude/b4-bug717-xcivil-prefix` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
594. **#1349** `claude/b4-bug716-offer-spot-text` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
595. **#1350** `claude/b4-bug745-trench-block-metres` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
596. **#1351** `claude/b4-bug718-review-units` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
597. **#1352** `claude/b3-survey-rl-range-699` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
598. **#1353** `claude/b3-xcivil-pits-733` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
599. **#1354** `claude/b3-xcivil-schedule-730` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
600. **#1355** `claude/b3-source-names-740` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
601. **#1356** `claude/b3-xcivil-replace-731` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
602. **#1357** `claude/b3-importcompare-726` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
603. **#1358** `claude/b3-cdtag-free-742` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
604. **#1359** `claude/b3-xcivil-il-wording-736` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
605. **#1360** `claude/b3-survey-suspect-708` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
606. **#1361** `claude/b3-survey-faces-704` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
607. **#1362** `claude/b3-survey-attdef-702` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
608. **#1363** `claude/b3-landxml-clash-722` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
609. **#1364** `claude/b3-xcivil-agi-747` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
610. **#1365** `claude/b3-xcivil-cover-738` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
611. **#1366** `claude/b3-xcivil-floor-737` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
612. **#1367** `claude/b3-xcivil-iltext-735` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
613. **#1368** `claude/b3-xcivil-grade-734` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
614. **#1369** `claude/b3-survey-units-701` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
615. **#1370** `codex/cesettings-tools-civil` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
616. **#1371** `claude/b3-survey-pairs-703` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
617. **#1372** `claude/b3-tag-orphan-746` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
618. **#1373** `claude/b3-report-more-739` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
619. **#1374** `claude/b3-survey-reach-705` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
620. **#1375** `claude/b3-survey-z-700` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
621. **#1376** `claude/b3-survey-skip-706` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
622. **#1377** `claude/b3-importcompare-open-727` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
623. **#1378** `claude/b3-cascade-locked-text-657` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
624. **#1379** `claude/b3-cascade-relink-scope-656` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
625. **#1380** `claude/b3-landxml-keep-or-replace-721` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
626. **#1387** `claude/b4-bug753-checks-pipe-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
627. **#1388** `claude/b4-bug754-manager-dark-tabs` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
628. **#1389** `claude/b4-bug221-manager-status-cards` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
629. **#1390** `claude/b4-bug430-eattedit-log` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
630. **#1391** `b03/ijk-02-tg-zero-cover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
631. **#1392** `b03/ijk-01-crown-own-size` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
632. **#1393** `b03/ijk-07-invert-above-cover` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
633. **#1394** `b03/ijk-04-datum-below-invert` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
634. **#1395** `b03/ijk-06-uphill-pipe-grade` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
635. **#1396** `b03/ijk-08-review-grid-one-pipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
636. **#1397** `b03/ijk-23-spoon-repeated-pick` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
637. **#1398** `b03/ijk-x2-pump-note-percent` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
638. **#1399** `b03/ijk-26-split-message-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
639. **#1400** `b03/bug-782-mappinnedends` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
640. **#1401** `b03/bug-781-xcivil-rows-by-order` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
641. **#1402** `b03/bug-785-depth-one-rule` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
642. **#1403** `b03/bug-790-design-review-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
643. **#1404** `b03/bug-788-saveas-xrefs` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
644. **#1405** `b03/bug-794-pdf-not-read` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
645. **#1406** `b03/bug-789-recover-inverts` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
646. **#1407** `b03/bug-758-section-write-admit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
647. **#1408** `claude/b4-bug758-hide-older-section-tab` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
648. **#1409** `b03/bug-807-809-small-checks` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
649. **#1410** `claude/b4-bug779-move-keeps-records` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
650. **#1411** `b03/bug-777-twl-default` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
651. **#1412** `claude/b4-bug783-delete-cell-blank` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
652. **#1413** `claude/b4-bug784-from-keeps-c1` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
653. **#1414** `b03/bug-800-checks-read-failure` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
654. **#1415** `claude/b4-bug780-merged-inlet-pipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
655. **#1416** `b03/bug-801-qa-stale-ce-writes` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
656. **#1417** `b03/bug-795-xref-repair-host` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
657. **#1418** `b03/bug-809-cdcheckdwg-corrupt` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
658. **#1420** `claude/b4-bug798-continuation-pit-columns` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
659. **#1421** `b03/bug-768-pit-width-sps-only` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
660. **#1422** `claude/b4-bug786-row-order-by-pit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
661. **#1424** `b03/bug-770-longsection-bridge-fullflow` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
662. **#1425** `claude/b4-bug791-window-marks-changed-only` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
663. **#1426** `claude/b4-bug792-clean-typed-numbers` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
664. **#1427** `b03/bug-769-profile-route-set` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
665. **#1428** `claude/b4-bug772-wsud-inputs` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
666. **#1429** `claude/b4-bug814-plain-refusals` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
667. **#1430** `claude/b4-bug809-palette-close-selection` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
668. **#1431** `claude/b4-bug808-outlet-vs-largest-inlet` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
669. **#1432** `claude/b4-bug773-raingarden-centre` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
670. **#1433** `claude/b4-bug767-section-frame-stub` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
671. **#1434** `claude/b4-bug681-flip-schedule` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
672. **#1435** `claude/b4-bug682-uphill-cancel` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
673. **#1436** `b03/bug-815-r06-detention-only` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
674. **#1437** `claude/b4-bug683-same-plan-real-length` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
675. **#1438** `claude/b4-bug709-survey-levels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
676. **#1439** `claude/b4-bug814-checks-unnamed-pipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
677. **#1440** `b03/bug-141-tidy-pit-clear` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
678. **#1441** `b03/bug-820-recover-one-text` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
679. **#1442** `b03/bug-823-staged-receipt` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
680. **#1443** `b03/bug-824-installer-dbx` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
681. **#1444** `b03/bug-834-old-stage` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
682. **#1446** `b03/bug-838-readonly-stage` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
683. **#1447** `b03/bug-825-settings-safe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
684. **#1448** `b03/bug-850-one-ribbon-owner` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
685. **#1449** `b03/bug-846-pii-salt-fallback` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
686. **#1450** `b03/bug-843-admin-names` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
687. **#1452** `b03/bug-844-dashboard-one-bad-file` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
688. **#1453** `b03/bug-827-settings-unopened` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
689. **#1454** `b03/bug-849-admin-list-not-downloaded` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
690. **#1455** `b03/bug-845-dashboard-buttons-catch` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
691. **#1456** `b03/bug-829-admin-seed` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
692. **#1458** `b03/bug-828-ribbon-cancel` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
693. **#1459** `b03/bug-842-ce-blocks-settings` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
694. **#1461** `b03/bug-832-833-stage-order` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
695. **#1462** `b03/bug-853-ribbon-click-log` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
696. **#1463** `b03/bug-850-one-tab-owner` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
697. **#1469** `b03/bug-842-848-files-half-written` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
698. **#1470** `b03/bug-835-851-836-837` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
699. **#1473** `b03/bug-851-disable-main-only` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
700. **#1474** `b03/bug-838-846-847` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
701. **#1475** `b03/bug-838-readonly-staged` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
702. **#1476** `claude/b4-bug830-839-reset-apply` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
703. **#1477** `b03/bug-430-pit-label-double-click` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
704. **#1478** `claude/b4-bug813-identity-reason` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
705. **#1479** `b03/bug-815-no-length-detention` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
706. **#1480** `b03/bug-141-sheet-frame` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
707. **#1481** `b03/bug-854-r06-fix-line` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
708. **#1482** `b03/bug-141-pit-body-only` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
709. **#1483** `claude/b4-bug141-border-extents` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
710. **#1484** `b03/bug-141-frame-contains-start` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
711. **#1485** `claude/b4-bug141-text-obstacle` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
712. **#1486** `b03/bug-856-tidy-move-line-names-pipe` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
713. **#1487** `claude/tl2-cemember-a-ub-engine` class A: head is an ancestor of installed Structural 1.0.122 branch
714. **#1488** `claude/tl2-cemember-b-shapes` class A: head is an ancestor of installed Structural 1.0.122 branch
715. **#1489** `claude/tl2-cemember-b2-cee` class A: head is an ancestor of installed Structural 1.0.122 branch
716. **#1490** `claude/tl2-cemember-c1-placement` class A: head is an ancestor of installed Structural 1.0.122 branch
717. **#1491** `claude/b4-bug825-stepiron-once` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
718. **#1492** `claude/b4-bug834-approved-version` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
719. **#1493** `claude/b4-bug852-version-in-manager` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
720. **#1494** `codex/cesettings-fixes-sched-civil` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
721. **#1495** `codex/cesettings-fixes-draft-civil` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
722. **#1496** `b03/bug-531-25c-ebt-text-height` class A: head is an ancestor of installed Structural 1.0.122 branch
723. **#1497** `b03/ad-any-dimscale` class A: head is an ancestor of installed Structural 1.0.122 branch
724. **#1498** `b03/bug-748-hatch-paper-density` class A: head is an ancestor of installed Structural 1.0.122 branch
725. **#1499** `b03/dp1-double-click-edit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
726. **#1500** `claude/tl2-cemember-d-zpurlin` class A: head is an ancestor of installed Structural 1.0.122 branch
727. **#1501** `claude/tl2-cemember-e1-catalogue` class A: head is an ancestor of installed Structural 1.0.122 branch
728. **#1502** `b04/bug-416-select-run-readonly` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
729. **#1503** `claude/b4-bug852-structural-half` class A: head is an ancestor of installed Structural 1.0.122 branch
730. **#1504** `claude/tl2-cemember-e2-command` class A: head is an ancestor of installed Structural 1.0.122 branch
731. **#1505** `claude/tl2-cemember-f-section` class A: head is an ancestor of installed Structural 1.0.122 branch
732. **#1506** `claude/tl2-cemember-g-repeat` class A: head is an ancestor of installed Structural 1.0.122 branch
733. **#1507** `b03/cmd-outcome-info-lines` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
734. **#1508** `claude/b4-mgr-finish-update` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
735. **#1509** `claude/tl2-cemember-h-record` class A: head is an ancestor of installed Structural 1.0.122 branch
736. **#1510** `claude/tl2-bug858-zpurlin` class A: head is an ancestor of installed Structural 1.0.122 branch
737. **#1511** `claude/b4-wire-wronglayer` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
738. **#1512** `claude/b4-wire-wronglayer-reader` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
739. **#1513** `claude/b4-tidy-leader-out` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
740. **#1514** `claude/b4-check-progress-line` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
741. **#1515** `claude/b4-bug478-start-rule` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
742. **#1516** `claude/b4-removed-pits-leave-checks` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
743. **#1517** `claude/b4-wire-ignored-checks` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
744. **#1518** `claude/cemember-renamed-layer-linetype` class A: head is an ancestor of installed Structural 1.0.122 branch
745. **#1520** `b04/bug-859-dp1-doubleclick` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
746. **#1522** `b04/bug-859-r2-pick-at-doubleclick` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
747. **#1523** `claude/fix-audit-1-outcome-line` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
748. **#1524** `cx/ignore-undo-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
749. **#1525** `claude/fix-audit-2-checkignore-switch-first` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
750. **#1526** `cx/settings-rows-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
751. **#1527** `cx/automation-ids-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
752. **#1530** `cx/eng-real-length-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
753. **#1531** `cx/eng-pit-floor-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
754. **#1532** `claude/fix-audit-4-bug861-instrumentation` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
755. **#1533** `cx/xclmtxt-s41` class A: head is an ancestor of installed Structural 1.0.122 branch
756. **#1535** `cx/manager-support-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
757. **#1536** `cx/guard-tests-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
758. **#1538** `cx/eng-twl-units-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
759. **#1540** `cx/fb03-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
760. **#1545** `cx/fb10-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
761. **#1546** `cx/fb08-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
762. **#1547** `cx/outcome-struct` class A: head is an ancestor of installed Structural 1.0.122 branch
763. **#1548** `cx/outcome-mgr` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
764. **#1549** `cx/eng-small-c60` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
765. **#1552** `fw2/bug-966-cdspoon-bylayer-readback` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
766. **#1553** `fw2/bug-967-bluefactor-garden-lawn` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
767. **#1556** `fw2/bug-970-cdtwl-same-pit-numbers` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
768. **#1557** `fw2/bug-876-replace-keeps-old-pit` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
769. **#1558** `fw2/bug-877-import-choose-file` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
770. **#1562** `fw2/bug-874-cd-esc-callout-link` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
771. **#1567** `fw2/bug-963-propagate-single-il` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
772. **#1570** `fw2/bug-965-refresh-twin-trench` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
773. **#1586** `fw2/bug-878-named-level-outranks-shortcut` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
774. **#1591** `fw2/bug-968-renumber-loop-guard` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
775. **#1594** `fw2/bug-946-cehealth-not-loaded` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
776. **#1595** `fw2/bug-948-updates-button-colleague` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
777. **#1609** `fw2/bug-892-inspector-empty-count` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
778. **#1610** `fw2/bug-957-settings-search-enter` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
779. **#1611** `fw2/bug-987-cdsync-identity-first` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
780. **#1612** `fw2/bug-1011-typed-depth` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
781. **#1613** `fw2/bug-1017-manager-buttons-busy-command` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
782. **#1617** `fw2/bug-999-runsolve-no-flow` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
783. **#1619** `fw2/bug-969-newdwg-job-folder` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
784. **#1623** `fw2/bug-1004-agreed-design-head` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
785. **#1625** `fw2/bug-1019-cdcalc-negative-levels` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
786. **#1632** `b03/bug-947-staging-damaged-copy` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch
787. **#1645** `fw2/cdrg-rollback` class A: head is an ancestor of installed Civil/Manager 3.0.72 branch

### Class B - in the planned C-63 or S-43 train (34)

1. **#1636** `b04/bug-1030-cdcalc-no-undo-step` class B: planned train C-63 group 3, Codex PR passed by Opus
2. **#1647** `cx2/bug-884-portable-approval` class B: planned train C-63 group 3, Codex PR passed by Opus
3. **#1648** `cx2/bug-886-office-approval` class B: planned train C-63 group 3, Codex PR passed by Opus
4. **#1650** `cx2/bug-875-ignore-inputs` class B: planned train C-63 group 3, Codex PR passed by Opus
5. **#1653** `cx2/bug-889-asked-again` class B: planned train C-63 group 3, Codex PR passed by Opus
6. **#1654** `cx2/bug-899-landxml-position` class B: planned train C-63 group 3, Codex PR passed by Opus
7. **#1658** `fb/max-971` class B: planned train C-63 group 1, Opus-reviewed
8. **#1659** `fb/fb02-inline-split-decisions` class B: planned train C-63 group 1, Opus-reviewed
9. **#1660** `fb/max-c-pit-depth` class B: planned train C-63 group 1, Opus-reviewed
10. **#1663** `fb/fb04-edit-pipe-cancel` class B: planned train C-63 group 1, Opus-reviewed
11. **#1664** `fb/max-868` class B: planned train C-63 group 1, Opus-reviewed
12. **#1665** `fb/max-wording-1` class B: planned train C-63 group 1, Opus-reviewed
13. **#1669** `fb/max-964` class B: planned train C-63 group 1, Opus-reviewed
14. **#1671** `fb/fb05-pit-schedule-open-no-write` class B: planned train C-63 group 1, Opus-reviewed
15. **#1676** `fb/max-c-dp-dblclick` class B: planned train C-63 group 2, Opus-reviewed
16. **#1682** `fb/fb06-pit-rename-pipe-notes` class B: planned train C-63 group 2, Opus-reviewed
17. **#1687** `fb/max-c-bluefactor` class B: planned train C-63 group 2, Opus-reviewed
18. **#1688** `fb/fb07-inline-split-callout-curve` class B: planned train C-63 group 2, Opus-reviewed
19. **#1689** `fb/max-c-cdcalc-cover` class B: planned train C-63 group 2, Opus-reviewed
20. **#1692** `fb/max-c-newdwg` class B: planned train C-63 group 2, Opus-reviewed
21. **#1693** `fb/fb11-pit-preview-live` class B: planned train C-63 group 4, not independently reviewed
22. **#1694** `fb/max-c-mgrlogs` class B: planned train C-63 group 2, Opus-reviewed
23. **#1695** `fb/max-s43-ucs-frame` class B: planned train S-43 (Structural) list
24. **#1696** `fb/max-s43-win-dpi` class B: planned train S-43 (Structural) list
25. **#1697** `fb/max-s43-cem-names` class B: planned train S-43 (Structural) list
26. **#1698** `fb/max-s43-cem-layers` class B: planned train S-43 (Structural) list
27. **#1699** `fb/max-s43-table-guard` class B: planned train S-43 (Structural) list
28. **#1700** `fb/fb13-cdrg-enter-finishes` class B: planned train C-63 group 4, not independently reviewed
29. **#1701** `fb/fb14-repair-report-counts` class B: planned train C-63 group 4, not independently reviewed
30. **#1706** `fb/fb12-pit-tab-close` class B: planned train C-63 group 4, not independently reviewed
31. **#1707** `fb/fb16-landxml-import` class B: planned train C-63 group 4, not independently reviewed
32. **#1708** `fb/fb17-landxml-scale-grade-rim` class B: planned train C-63 group 4, not independently reviewed
33. **#1709** `fb/fb20-boundary-along-pipe` class B: planned train C-63 group 4, not independently reviewed
34. **#1710** `fb/fb19-level-pipe-grade` class B: planned train C-63 group 4, not independently reviewed

### Class C - independently reviewed MERGE or MERGE-WITH-FIXES, not in a train (9)

1. **#397** `claude/s2-unit` class C: Opus lane review MERGE at this head, not in a train
2. **#1534** `cx/wording-c60` class C: reviewed MERGE-WITH-FIXES (REVIEW CODEX LF B), not in a train
3. **#1635** `b04/bug-1032-cdtwl-wording` class C: reviewed MERGE (CODEX PR REVIEW GROUP06 (Codex only)), not in a train
4. **#1711** `fb/fb22-cdprofile-junction-marks` class C: reviewed MERGE (REVIEW CX4 AND BATCH4), not in a train
5. **#1712** `fb/fb23-cascade-rejoin-order` class C: reviewed MERGE (REVIEW CX4 AND BATCH4), not in a train
6. **#1713** `fb/fb24-audit-read-only` class C: reviewed MERGE (REVIEW CX4 AND BATCH4), not in a train
7. **#1717** `fb/fb25-schedule-order-pump` class C: reviewed MERGE-WITH-FIXES (REVIEW CX4 AND BATCH4), not in a train
8. **#1719** `cx4/fa05-rd09-tests` class C: reviewed MERGE (REVIEW CX4 AND BATCH4), not in a train
9. **#1720** `cx4/fa01-inspection` class C: reviewed MERGE-WITH-FIXES (REVIEW CX4 AND BATCH4), not in a train

### Class D - independently reviewed HOLD or REJECT (14)

1. **#425** `claude/manager-settings-move-de` class D: Opus lane review DO-NOT-MERGE at this head
2. **#1528** `cx/test-state-c60` class D: reviewed HOLD (REVIEW CODEX PRS A)
3. **#1539** `cx/fb01-c60` class D: reviewed HOLD (REVIEW CODEX PRS B)
4. **#1551** `cx/eng-move-pit-grade-c60` class D: reviewed HOLD (REVIEW CODEX PRS B)
5. **#1621** `fw2/bug-947-damaged-stage-repair` class D: reviewed REJECT (REVIEW FIXWAVE2 B)
6. **#1646** `cx2/bug-878-ledger-batch02` class D: reviewed REJECT (REVIEW CODEX LF A); head differs from the review
7. **#1649** `cx2/bug-885-frozen-packaging` class D: reviewed HOLD (REVIEW CODEX LF B); head differs from the review
8. **#1651** `cx2/bug-893-ledger-batch05` class D: reviewed HOLD (REVIEW CODEX LF B); head differs from the review
9. **#1652** `cx2/bug-887-shared-pair` class D: reviewed HOLD (REVIEW CODEX LF B); head differs from the review
10. **#1714** `cx4/fa04-rd08-desk` class D: reviewed REJECT (REVIEW CX4 AND BATCH4)
11. **#1715** `cx4/fa03-drainage` class D: reviewed REJECT (REVIEW CX4 AND BATCH4)
12. **#1716** `cx4/fa02-units` class D: reviewed HOLD (REVIEW CX4 AND BATCH4)
13. **#1718** `cx4/fa06-plain-words` class D: reviewed HOLD (REVIEW CX4 AND BATCH4)
14. **#1721** `cx4/fa07-native-protection` class D: reviewed HOLD (REVIEW CX4 AND BATCH4)

### Class E - NOT reviewed, fixes a bug still open, matters for the 9 Nov pilot (134)

1. **#987** `claude/bug561-detention-sides` class E: not reviewed; fixes BUG-561, still open in carpark
2. **#988** `claude/bug559-results-short-pipe` class E: not reviewed; fixes BUG-559, still open in carpark
3. **#989** `claude/bug-560-click-end-unknown` class E: not reviewed; fixes BUG-560, BUG-563, still open in carpark
4. **#998** `b03/bug558-hold-other-drawings` class E: not reviewed; fixes BUG-558, still open in carpark
5. **#1004** `claude/bug558-qa-xref-open-close` class E: not reviewed; fixes BUG-558, still open in carpark
6. **#1005** `claude/bug558-block-name-open-close` class E: not reviewed; fixes BUG-558, still open in carpark
7. **#1008** `claude/tl2-r132-bug497-sched-rows` class E: not reviewed; fixes BUG-497, still open in carpark
8. **#1011** `claude/tl2-r132-bug498-refresh-rows` class E: not reviewed; fixes BUG-498, still open in carpark
9. **#1012** `claude/tl2-r132-bug499-bt1-out` class E: not reviewed; fixes BUG-499, still open in carpark
10. **#1013** `claude/tl2-r132-bug501-mark-two-sizes` class E: not reviewed; fixes BUG-501, still open in carpark
11. **#1014** `claude/tl2-r132-bug502-subfloor-assumed` class E: not reviewed; fixes BUG-502, still open in carpark
12. **#1016** `claude/tl2-r132-bug503-lintel-preview` class E: not reviewed; fixes BUG-503, still open in carpark
13. **#1018** `claude/tl2-r132-bug503-issue-date` class E: not reviewed; fixes BUG-503, still open in carpark
14. **#1024** `claude/tl2-r133-job-record` class E: not reviewed; fixes BUG-500, BUG-496, still open in carpark
15. **#1026** `claude/tl2-r133-bracing-units` class E: not reviewed; fixes BUG-503, still open in carpark
16. **#1029** `claude/b25-no-blue-sheet` class E: not reviewed; fixes BUG-517, still open in carpark
17. **#1120** `claude/tl2-r144-pad-label-height` class E: not reviewed; fixes BUG-454, still open in carpark
18. **#1135** `claude/bug-519-startup-banner` class E: not reviewed; fixes BUG-519, still open in carpark
19. **#1139** `claude/tl2-r150-privacy-leftovers` class E: not reviewed; fixes BUG-550, still open in carpark
20. **#1142** `claude/tl2-r150-standard-editions` class E: not reviewed; fixes BUG-534, still open in carpark
21. **#1144** `claude/bug-543-one-orifice-basis` class E: not reviewed; fixes BUG-543, still open in carpark
22. **#1146** `claude/tl2-r150-plain-words-a` class E: not reviewed; fixes BUG-503, still open in carpark
23. **#1147** `claude/bug-527-one-pipe-speed-limit` class E: not reviewed; fixes BUG-527, still open in carpark
24. **#1150** `claude/bug-541-slab-min-falls-settings` class E: not reviewed; fixes BUG-541, still open in carpark
25. **#1152** `claude/bug-545-pit-drop-one-box` class E: not reviewed; fixes BUG-545, still open in carpark
26. **#1154** `claude/tl2-r150-unknown-pad` class E: not reviewed; fixes BUG-530, still open in carpark
27. **#1156** `claude/bug-547-1-xcivil-level-range` class E: not reviewed; fixes BUG-547, still open in carpark
28. **#1157** `claude/tl2-r150-fadopt-beam-kind` class E: not reviewed; fixes BUG-503, still open in carpark
29. **#1159** `claude/bug-547-2-wsud-charged-settings` class E: not reviewed; fixes BUG-547, still open in carpark
30. **#1161** `claude/bug-547-3-strip-lpd-join-sps-settings` class E: not reviewed; fixes BUG-547, still open in carpark
31. **#1167** `claude/bug-555-491-help-web-attribute-log` class E: not reviewed; fixes BUG-555, BUG-491, still open in carpark
32. **#1207** `claude/tl2-r151-job-record-lintel` class E: not reviewed; fixes BUG-548, still open in carpark
33. **#1212** `claude/tl2-r155-standard-editions-2` class E: not reviewed; fixes BUG-534, still open in carpark
34. **#1215** `claude/b4-bug506-grade-text` class E: not reviewed; fixes BUG-509, BUG-506, still open in carpark
35. **#1216** `claude/b4-bug515-boyds-last-row` class E: not reviewed; fixes BUG-515, still open in carpark
36. **#1217** `claude/b4-bug511-detpipe-settings` class E: not reviewed; fixes BUG-511, still open in carpark
37. **#1219** `claude/b4-bug464-schedule-readonly` class E: not reviewed; fixes BUG-465, BUG-464, still open in carpark
38. **#1221** `claude/b4-bug465-sps-heights` class E: not reviewed; fixes BUG-465, still open in carpark
39. **#1225** `claude/b3-bug552-fault-report-scrub` class E: not reviewed; fixes BUG-552, still open in carpark
40. **#1229** `claude/b3-bug513-bug512-landxml-honesty` class E: not reviewed; fixes BUG-513, BUG-512, still open in carpark
41. **#1230** `claude/b3-bug514-roughness-warning` class E: not reviewed; fixes BUG-514, still open in carpark
42. **#1231** `claude/b3-bug481-leave-menubar-alone` class E: not reviewed; fixes BUG-481, still open in carpark
43. **#1232** `claude/b3-bug485-upload-outbox-errors` class E: not reviewed; fixes BUG-485, still open in carpark
44. **#1233** `claude/b3-bug484-cehealth-manager-and-copies` class E: not reviewed; fixes BUG-484, still open in carpark
45. **#1234** `claude/b3-bug486-short-staging-folder` class E: not reviewed; fixes BUG-486, still open in carpark
46. **#1235** `claude/b3-bug487-first-install-per-user` class E: not reviewed; fixes BUG-487, still open in carpark
47. **#1236** `claude/b3-bug487-feedback-count-admin-only` class E: not reviewed; fixes BUG-487, still open in carpark
48. **#1238** `claude/b3-bug487-startup-words` class E: not reviewed; fixes BUG-487, still open in carpark
49. **#1242** `claude/b3-bug465-11-sps-number` class E: not reviewed; fixes BUG-465, still open in carpark
50. **#1243** `claude/b04-help-undo-redo-note` class E: not reviewed; fixes BUG-558, still open in carpark
51. **#1245** `claude/tl2-r205-bug566-menubar` class E: not reviewed; fixes BUG-566, still open in carpark
52. **#1246** `codex/cesettings-switches-civil` class E: not reviewed; fixes BUG-546, still open in carpark
53. **#1256** `codex/pit-remark-regression-20261014` class E: not reviewed; fixes BUG-586, still open in carpark
54. **#1260** `codex/checklist-lifecycle-regression-20261015` class E: not reviewed; fixes BUG-609, still open in carpark
55. **#1341** `claude/b4-bug710-fall-suggest-units` class E: not reviewed; fixes BUG-710, still open in carpark
56. **#1383** `claude/tl2-r440-bug751-hatch-card-pictures` class E: not reviewed; fixes BUG-751, still open in carpark
57. **#1384** `claude/tl2-r440-bug750-side-elev-flange-lines` class E: not reviewed; fixes BUG-750, still open in carpark
58. **#1385** `claude/tl2-r440-bug755-rc-beam-pictures` class E: not reviewed; fixes BUG-755, still open in carpark
59. **#1386** `claude/tl2-r440-bug752-settings-paths` class E: not reviewed; fixes BUG-752, still open in carpark
60. **#1419** `b03/bug-803-rebuild-original-pit` class E: not reviewed; fixes BUG-803, still open in carpark
61. **#1423** `claude/b4-bug787-overrides-by-pit` class E: not reviewed; fixes BUG-787, still open in carpark
62. **#1457** `claude/tl2-r455-bug826-reset` class E: not reviewed; fixes BUG-826, still open in carpark
63. **#1460** `claude/tl2-r455-bug840-routine-save` class E: not reviewed; fixes BUG-840, still open in carpark
64. **#1464** `claude/tl2-r455-bug841-typed-numbers` class E: not reviewed; fixes BUG-841, still open in carpark
65. **#1521** `claude/b4-bug-860` class E: not reviewed; fixes BUG-860, still open in carpark
66. **#1529** `claude/fix-audit-3-hidden-layer-keep` class E: not reviewed; a fix with no bug number
67. **#1554** `cx/fb09-c60` class E: not reviewed; fixes BUG-799, still open in carpark
68. **#1559** `b03/bug-979-cdjoint-erase-late` class E: not reviewed; fixes BUG-979, still open in carpark
69. **#1560** `claude/tl2-r501-bug976-notes-overwrite` class E: not reviewed; fixes BUG-976, still open in carpark
70. **#1561** `b03/bug-980-pipeflows-second-pick` class E: not reviewed; fixes BUG-980, still open in carpark
71. **#1563** `claude/tl2-r501-bug977-sbeam-ucs` class E: not reviewed; fixes BUG-977, still open in carpark
72. **#1564** `claude/tl2-r501-bug975-neighbour-text` class E: not reviewed; fixes BUG-975, still open in carpark
73. **#1565** `b03/bug-1003-cefind-pit-ids` class E: not reviewed; fixes BUG-1003, still open in carpark
74. **#1566** `claude/tl2-r501-bug978-second-acad` class E: not reviewed; fixes BUG-978, still open in carpark
75. **#1568** `claude/tl2-r501-bug973-swap-sheets` class E: not reviewed; fixes BUG-973, still open in carpark
76. **#1569** `b03/bug-1008-remarks-cell-edit` class E: not reviewed; fixes BUG-1008, still open in carpark
77. **#1572** `claude/tl2-r501-bug972-preview-readonly` class E: not reviewed; fixes BUG-972, still open in carpark
78. **#1573** `b03/bug-1007-cdfall-metre-direction` class E: not reviewed; fixes BUG-1007, still open in carpark
79. **#1574** `claude/tl2-r501-bug983-title-xref-match` class E: not reviewed; fixes BUG-983, still open in carpark
80. **#1575** `claude/tl2-r501-bug985-bextend-arc` class E: not reviewed; fixes BUG-985, still open in carpark
81. **#1577** `claude/tl2-r501-bug881-hatch-repair-scale` class E: not reviewed; fixes BUG-881, still open in carpark
82. **#1578** `b03/bug-1012-closed-boundary-last-side` class E: not reviewed; fixes BUG-1012, still open in carpark
83. **#1579** `claude/tl2-r501-bug984-markup-undo-doc` class E: not reviewed; fixes BUG-984, still open in carpark
84. **#1580** `b03/bug-1010-idle-time-double-count` class E: not reviewed; fixes BUG-1010, still open in carpark
85. **#1581** `claude/tl2-r501-bug986-reobar-slope` class E: not reviewed; fixes BUG-986, still open in carpark
86. **#1582** `claude/tl2-r501-bug1016-checklist-pending` class E: not reviewed; fixes BUG-1016, still open in carpark
87. **#1583** `b03/bug-993-fall-arrow-block-rotation` class E: not reviewed; fixes BUG-993, still open in carpark
88. **#1584** `claude/tl2-r501-bug1013-manifest-stale` class E: not reviewed; fixes BUG-1013, still open in carpark
89. **#1585** `claude/tl2-r501-bug1015-rib-refusal` class E: not reviewed; fixes BUG-1015, still open in carpark
90. **#1587** `claude/tl2-r501-bug1025-reobar-layout-units` class E: not reviewed; fixes BUG-1025, still open in carpark
91. **#1588** `b03/bug-994-compact-inspector-length-units` class E: not reviewed; fixes BUG-994, still open in carpark
92. **#1589** `claude/tl2-r501-bug974-xclmtxt-excluded` class E: not reviewed; fixes BUG-974, still open in carpark
93. **#1590** `claude/tl2-r501-bug912-cemember-default-scale` class E: not reviewed; fixes BUG-912, still open in carpark
94. **#1592** `claude/tl2-r501-bug953-hatch-no-refusal` class E: not reviewed; fixes BUG-953, still open in carpark
95. **#1593** `b03/bug-1021-twl-lid-no-floor` class E: not reviewed; fixes BUG-1021, still open in carpark
96. **#1596** `claude/tl2-r501-bug951-tag-heights` class E: not reviewed; fixes BUG-951, still open in carpark
97. **#1597** `b03/bug-1024-spine-upgrade-project-behind` class E: not reviewed; fixes BUG-1024, still open in carpark
98. **#1598** `claude/tl2-r501-bug911-label-units` class E: not reviewed; fixes BUG-911, still open in carpark
99. **#1599** `b03/bug-995-inspector-zoom-ucs` class E: not reviewed; fixes BUG-995, still open in carpark
100. **#1601** `b03/bug-1001-xcivil-pit-id-neighbour` class E: not reviewed; fixes BUG-1001, still open in carpark
101. **#1603** `claude/tl2-bug950-bracing-types` class E: not reviewed; fixes BUG-950, still open in carpark
102. **#1604** `claude/tl2-bug880-cemember-units` class E: not reviewed; fixes BUG-880, still open in carpark
103. **#1605** `claude/bug-610-checklist-undo` class E: not reviewed; fixes BUG-610, still open in carpark
104. **#1606** `claude/bug-608-na-reason` class E: not reviewed; fixes BUG-608, still open in carpark
105. **#1607** `b03/bug-1000-xcivil-spot-fall-translate` class E: not reviewed; fixes BUG-1000, still open in carpark
106. **#1608** `claude/bug-645-r2ltxt-ask-first` class E: not reviewed; fixes BUG-645, still open in carpark
107. **#1614** `b03/bug-1009-xref-row-no-host-zoom` class E: not reviewed; fixes BUG-1009, still open in carpark
108. **#1615** `claude/bug-644-text-side-at-insertion` class E: not reviewed; fixes BUG-644, still open in carpark
109. **#1616** `b03/bug-1002-xcivil-fall-block-rotation` class E: not reviewed; fixes BUG-1002, still open in carpark
110. **#1618** `b03/bug-991-ai-sender-no-redirect` class E: not reviewed; fixes BUG-991, still open in carpark
111. **#1620** `b03/bug-990-heartbeat-https-only` class E: not reviewed; fixes BUG-990, still open in carpark
112. **#1626** `b03/bug-998-redesign-before-levels` class E: not reviewed; fixes BUG-998, still open in carpark
113. **#1627** `b03/bug-997-update-section-own-block` class E: not reviewed; fixes BUG-997, still open in carpark
114. **#1628** `b03/bug-1005-renumber-main-line` class E: not reviewed; fixes BUG-1005, still open in carpark
115. **#1629** `b03/bug-1022-refound-pit-keeps-override` class E: not reviewed; fixes BUG-1022, still open in carpark
116. **#1631** `b03/bug-981-xref-groups-keep-drawing` class E: not reviewed; fixes BUG-981, still open in carpark
117. **#1633** `b03/bug-927-cdtag-messages` class E: not reviewed; fixes BUG-927, still open in carpark
118. **#1634** `b03/bug-944-plain-command-messages` class E: not reviewed; fixes BUG-944, still open in carpark
119. **#1637** `b03/bug-945-plain-audit-messages` class E: not reviewed; fixes BUG-945, still open in carpark
120. **#1638** `b03/checkignore-stores-coded-name` class E: not reviewed; a fix with no bug number
121. **#1640** `b03/bug-992-xrefcompare-old-and-new` class E: not reviewed; fixes BUG-992, still open in carpark
122. **#1641** `b03/bug-996-cd-mirror-keeps-link` class E: not reviewed; fixes BUG-996, still open in carpark
123. **#1642** `b03/bug-988-drawing-record-wins` class E: not reviewed; fixes BUG-988, still open in carpark
124. **#1643** `b03/bug-982-propagate-judges-written-levels` class E: not reviewed; fixes BUG-982, still open in carpark
125. **#1644** `b03/bug-999-runsolve-honest-nothing-to-apply` class E: not reviewed; fixes BUG-999, still open in carpark
126. **#1655** `cx2/bug-906-detention-grade` class E: not reviewed; fixes BUG-906, still open in carpark
127. **#1656** `cx2/bug-904-storm-peak` class E: not reviewed; fixes BUG-904, still open in carpark
128. **#1657** `cx2/bug-917-update-stages` class E: not reviewed; fixes BUG-917, still open in carpark
129. **#1661** `cx2/bug-925-source-values` class E: not reviewed; fixes BUG-925, still open in carpark
130. **#1670** `cx2/bug-948-batch16-audit` class E: not reviewed; fixes BUG-948, BUG-949, BUG-950, BUG-951, BUG-952, still open in carpark
131. **#1672** `cx2/bug-918-update-promise` class E: not reviewed; fixes BUG-918, still open in carpark
132. **#1690** `cx2/bug-960-palette-theme` class E: not reviewed; fixes BUG-960, still open in carpark
133. **#1691** `cx2/bug-961-manager-fields` class E: not reviewed; fixes BUG-961, still open in carpark
134. **#1703** `cx3/tests-bd03` class E: not reviewed; fixes BUG-425, BUG-832, BUG-835, BUG-842, BUG-848, BUG-1028, still open in carpark

### Class F - NOT reviewed, plan work (164)

1. **#972** `b03/b6-assumed-levels` class F: not reviewed; plan, engine or feature work
2. **#983** `claude/c35-ai-settings-section` class F: not reviewed; plan, engine or feature work
3. **#984** `claude/tl2-r128-redo-guard-commands` class F: not reviewed; plan, engine or feature work
4. **#985** `claude/c35-ask-model-tab-from-file-only` class F: not reviewed; plan, engine or feature work
5. **#986** `claude/tl2-r128-speed` class F: not reviewed; plan, engine or feature work
6. **#991** `claude/civil-speed-block-name-cache` class F: not reviewed; plan, engine or feature work
7. **#992** `claude/ribbon-contextual-tab-hide-guard` class F: not reviewed; plan, engine or feature work
8. **#996** `claude/b6-late-survey-planner` class F: not reviewed; plan, engine or feature work
9. **#1000** `claude/b2-pick-prompts` class F: not reviewed; plan, engine or feature work
10. **#1010** `claude/setc-landxml-circular-diameter` class F: not reviewed; plan, engine or feature work
11. **#1019** `claude/setc-flat-label-tolerance` class F: not reviewed; plan, engine or feature work
12. **#1020** `claude/b2-slow-work-wired` class F: not reviewed; plan, engine or feature work
13. **#1021** `claude/setc-longsection-roughness` class F: not reviewed; plan, engine or feature work
14. **#1023** `claude/setc-detention-start-c` class F: not reviewed; plan, engine or feature work
15. **#1025** `claude/setc-pipeflow-start-roughness` class F: not reviewed; plan, engine or feature work
16. **#1028** `claude/setc-xcivil-size-list` class F: not reviewed; plan, engine or feature work
17. **#1030** `claude/setc-old-sps-radius` class F: not reviewed; plan, engine or feature work
18. **#1031** `claude/pit-detention-annotate` class F: not reviewed; plan, engine or feature work
19. **#1033** `claude/setc-min-cover-settings` class F: not reviewed; plan, engine or feature work
20. **#1035** `claude/repair-decide-later` class F: not reviewed; plan, engine or feature work
21. **#1036** `claude/pit-detention-engine` class F: not reviewed; plan, engine or feature work
22. **#1037** `claude/k-req-01-combined-write` class F: not reviewed; plan, engine or feature work
23. **#1039** `claude/c4-b5-sizing-mode-words` class F: not reviewed; plan, engine or feature work
24. **#1040** `claude/b4-transition-names` class F: not reviewed; plan, engine or feature work
25. **#1042** `claude/c4-b7-issue-record` class F: not reviewed; plan, engine or feature work
26. **#1045** `claude/tl2-r133-roofdown-help` class F: not reviewed; plan, engine or feature work
27. **#1046** `claude/cr09-refused-storage` class F: not reviewed; plan, engine or feature work
28. **#1047** `claude/b1-pp-cover-text` class F: not reviewed; plan, engine or feature work
29. **#1048** `claude/cr08-pipe-class` class F: not reviewed; plan, engine or feature work
30. **#1049** `claude/tl2-r134-loadpath-line` class F: not reviewed; plan, engine or feature work
31. **#1052** `claude/tl2-r134-sill-trimmer-table` class F: not reviewed; plan, engine or feature work
32. **#1053** `claude/msg-failure-producer` class F: not reviewed; plan, engine or feature work
33. **#1054** `claude/wsud02-rating-check` class F: not reviewed; plan, engine or feature work
34. **#1055** `claude/tl2-r134-strength-band` class F: not reviewed; plan, engine or feature work
35. **#1056** `claude/l3-levels-one-rulebook` class F: not reviewed; plan, engine or feature work
36. **#1057** `claude/tl2-r134-clarify-pdf` class F: not reviewed; plan, engine or feature work
37. **#1058** `claude/sps01-duty-point` class F: not reviewed; plan, engine or feature work
38. **#1059** `claude/l3-proposals-feed` class F: not reviewed; plan, engine or feature work
39. **#1060** `claude/tl2-r134-issue-open-markup` class F: not reviewed; plan, engine or feature work
40. **#1061** `claude/int077-footing-plan-reader` class F: not reviewed; plan, engine or feature work
41. **#1062** `claude/surv02-04-revised-survey` class F: not reviewed; plan, engine or feature work
42. **#1064** `claude/b2-pause-slow-feature` class F: not reviewed; plan, engine or feature work
43. **#1066** `claude/tl2-r139-markup-tag-read` class F: not reviewed; plan, engine or feature work
44. **#1068** `claude/tl2-r139-markup-per-drawing` class F: not reviewed; plan, engine or feature work
45. **#1069** `claude/b6-free-end-record` class F: not reviewed; plan, engine or feature work
46. **#1070** `claude/b6-long-section-layout-engine` class F: not reviewed; plan, engine or feature work
47. **#1071** `claude/tl2-r139-markup-compare-command` class F: not reviewed; plan, engine or feature work
48. **#1072** `claude/mgr08-approval-page-engine` class F: not reviewed; plan, engine or feature work
49. **#1074** `claude/tl2-r139-issue-suggest` class F: not reviewed; plan, engine or feature work
50. **#1075** `claude/mgr06-report-a-problem-plan` class F: not reviewed; plan, engine or feature work
51. **#1076** `claude/mgr10-whats-new-draft` class F: not reviewed; plan, engine or feature work
52. **#1077** `claude/mgr05-go-back-plan` class F: not reviewed; plan, engine or feature work
53. **#1078** `claude/tl2-r139-wall-line-report` class F: not reviewed; plan, engine or feature work
54. **#1080** `claude/mgr13-report-view-handoff` class F: not reviewed; plan, engine or feature work
55. **#1081** `claude/tl2-r139-sheets-ribbon` class F: not reviewed; plan, engine or feature work
56. **#1082** `claude/cr17-floor-freeboard-rule` class F: not reviewed; plan, engine or feature work
57. **#1083** `claude/tl2-r139-revision-clouds` class F: not reviewed; plan, engine or feature work
58. **#1084** `claude/cr05-short-offcut-rule` class F: not reviewed; plan, engine or feature work
59. **#1085** `claude/tl2-r139-check-plot` class F: not reviewed; plan, engine or feature work
60. **#1086** `claude/b4-pit-last-size` class F: not reviewed; plan, engine or feature work
61. **#1087** `claude/cr04-agi-bypass-rule` class F: not reviewed; plan, engine or feature work
62. **#1088** `claude/tl2-r139-next-revision` class F: not reviewed; plan, engine or feature work
63. **#1091** `claude/tl2-r140-stump-sizes` class F: not reviewed; plan, engine or feature work
64. **#1092** `claude/cr16-rear-fall-storm-rule` class F: not reviewed; plan, engine or feature work
65. **#1093** `claude/tl2-r140-beam-pullback` class F: not reviewed; plan, engine or feature work
66. **#1094** `claude/cr02-lid-class-from-surface` class F: not reviewed; plan, engine or feature work
67. **#1095** `claude/cr03-implied-easement-band` class F: not reviewed; plan, engine or feature work
68. **#1096** `claude/tl2-r141-roofdown-level` class F: not reviewed; plan, engine or feature work
69. **#1097** `claude/cr07-boroondara-outfall-length` class F: not reviewed; plan, engine or feature work
70. **#1098** `claude/tl2-r141-beam-label-heights` class F: not reviewed; plan, engine or feature work
71. **#1099** `claude/cr06-council-base-overlay` class F: not reviewed; plan, engine or feature work
72. **#1100** `claude/tl2-r141-fixed-label-height` class F: not reviewed; plan, engine or feature work
73. **#1101** `claude/b4-transition-names-2` class F: not reviewed; plan, engine or feature work
74. **#1102** `claude/tl2-r141-retaining-wall-layout` class F: not reviewed; plan, engine or feature work
75. **#1103** `claude/tl2-r141-screwpile-schedule` class F: not reviewed; plan, engine or feature work
76. **#1104** `claude/learn01-slice3-office-usual` class F: not reviewed; plan, engine or feature work
77. **#1105** `claude/tl2-r142-waffle-pod-notes` class F: not reviewed; plan, engine or feature work
78. **#1106** `claude/tl2-r142-fence-footings` class F: not reviewed; plan, engine or feature work
79. **#1107** `claude/learn01-slice4-promote-default` class F: not reviewed; plan, engine or feature work
80. **#1108** `claude/cr01-discharge-enquiry-figures` class F: not reviewed; plan, engine or feature work
81. **#1109** `claude/r00-loadpath-roundup` class F: not reviewed; plan, engine or feature work
82. **#1110** `claude/r00-footing-schedule-widths` class F: not reviewed; plan, engine or feature work
83. **#1111** `claude/ux-mgr-07-11-12-office-health` class F: not reviewed; plan, engine or feature work
84. **#1112** `claude/r00-stirrup-sizes` class F: not reviewed; plan, engine or feature work
85. **#1113** `claude/ux-mgr-09-admin-rollback-plan` class F: not reviewed; plan, engine or feature work
86. **#1114** `claude/r00-remove-unused-cover` class F: not reviewed; plan, engine or feature work
87. **#1115** `claude/r00-support-placement-tuning` class F: not reviewed; plan, engine or feature work
88. **#1116** `claude/ux-surv-01-level-source` class F: not reviewed; plan, engine or feature work
89. **#1117** `claude/r00-wall-pairing-tuning` class F: not reviewed; plan, engine or feature work
90. **#1118** `claude/des01-differs-from-supplied` class F: not reviewed; plan, engine or feature work
91. **#1119** `claude/ux-mgr-07-pc-report-file` class F: not reviewed; plan, engine or feature work
92. **#1121** `claude/c4-b8-whole-set-catchment-review` class F: not reviewed; plan, engine or feature work
93. **#1122** `claude/privacy-pyautocad-bootstrap-off` class F: not reviewed; plan, engine or feature work
94. **#1123** `claude/c4-b6-apply-preview-plan` class F: not reviewed; plan, engine or feature work
95. **#1124** `claude/mode03-late-markup-qa-list` class F: not reviewed; plan, engine or feature work
96. **#1125** `claude/b6-crossing-service-planner` class F: not reviewed; plan, engine or feature work
97. **#1126** `claude/des01-panel-mode-line` class F: not reviewed; plan, engine or feature work
98. **#1127** `claude/olf-02-03-overflow-checks` class F: not reviewed; plan, engine or feature work
99. **#1128** `claude/chk-01-03-job-checklist` class F: not reviewed; plan, engine or feature work
100. **#1129** `claude/notes-01-job-notes-once` class F: not reviewed; plan, engine or feature work
101. **#1133** `claude/pool02-backwash-note-catchment` class F: not reviewed; plan, engine or feature work
102. **#1134** `claude/site03-spoon-drain-live-fall` class F: not reviewed; plan, engine or feature work
103. **#1136** `claude/site04-slab-outline-offer` class F: not reviewed; plan, engine or feature work
104. **#1137** `claude/olf01-overland-route-trace` class F: not reviewed; plan, engine or feature work
105. **#1140** `claude/olf04-floor-freeboard` class F: not reviewed; plan, engine or feature work
106. **#1141** `claude/b4-cplan01-legend` class F: not reviewed; plan, engine or feature work
107. **#1143** `claude/b4-cplan08-notes` class F: not reviewed; plan, engine or feature work
108. **#1148** `claude/b4-cplan11-service-labels` class F: not reviewed; plan, engine or feature work
109. **#1151** `claude/b4-cplan03-existing-grey` class F: not reviewed; plan, engine or feature work
110. **#1153** `claude/b4-cplan02-sheet-rule` class F: not reviewed; plan, engine or feature work
111. **#1155** `claude/b4-cplan15-c02-title` class F: not reviewed; plan, engine or feature work
112. **#1158** `claude/b4-cplan16-detail-pack` class F: not reviewed; plan, engine or feature work
113. **#1160** `claude/b4-cplan17-charged` class F: not reviewed; plan, engine or feature work
114. **#1162** `claude/tl2-r150-footing-sched-sizes` class F: not reviewed; plan, engine or feature work
115. **#1163** `claude/b4-det07-details-needed` class F: not reviewed; plan, engine or feature work
116. **#1164** `claude/tl2-r150-fedit-strength` class F: not reviewed; plan, engine or feature work
117. **#1168** `claude/tl2-r150-sheet-order` class F: not reviewed; plan, engine or feature work
118. **#1172** `claude/tl2-r150-clarify-command` class F: not reviewed; plan, engine or feature work
119. **#1173** `claude/b4-l3-25-26-keep-mix` class F: not reviewed; plan, engine or feature work
120. **#1174** `claude/b11-one-orifice-head-reader` class F: not reviewed; plan, engine or feature work
121. **#1175** `claude/tl2-r150-markup-count` class F: not reviewed; plan, engine or feature work
122. **#1177** `claude/ux-cplan-33-outfall-run-numbering` class F: not reviewed; plan, engine or feature work
123. **#1178** `claude/tl2-r150-markup-corrections` class F: not reviewed; plan, engine or feature work
124. **#1179** `claude/b4-free-end-job-record` class F: not reviewed; plan, engine or feature work
125. **#1180** `claude/ux-cplan-11-plan-service-clash` class F: not reviewed; plan, engine or feature work
126. **#1181** `claude/b4-l3-network-rows` class F: not reviewed; plan, engine or feature work
127. **#1182** `claude/tl2-r150-issue-hardening` class F: not reviewed; plan, engine or feature work
128. **#1183** `claude/ux-pool-01-zone-of-influence` class F: not reviewed; plan, engine or feature work
129. **#1184** `claude/tl2-r150-locked-rule-guards` class F: not reviewed; plan, engine or feature work
130. **#1185** `claude/ux-site-02-joint-proposal` class F: not reviewed; plan, engine or feature work
131. **#1186** `claude/ux-stds-01-issue-standards-check` class F: not reviewed; plan, engine or feature work
132. **#1187** `claude/b4-branch-profile` class F: not reviewed; plan, engine or feature work
133. **#1188** `claude/ux-arch-03-background-preset` class F: not reviewed; plan, engine or feature work
134. **#1189** `claude/tl2-r150-member-sched-sizes` class F: not reviewed; plan, engine or feature work
135. **#1190** `claude/checks-explain-finding-explanation` class F: not reviewed; plan, engine or feature work
136. **#1191** `claude/ux-set-03-06-setting-provenance` class F: not reviewed; plan, engine or feature work
137. **#1192** `claude/b4-r00-step-iron-depth` class F: not reviewed; plan, engine or feature work
138. **#1193** `claude/tl2-r150-beam-layer-readers` class F: not reviewed; plan, engine or feature work
139. **#1194** `claude/m06-report-lifecycle` class F: not reviewed; plan, engine or feature work
140. **#1195** `claude/m03-standard-files-repair` class F: not reviewed; plan, engine or feature work
141. **#1196** `claude/b4-r00-detention-gaps` class F: not reviewed; plan, engine or feature work
142. **#1197** `claude/m04-offline-report-queue` class F: not reviewed; plan, engine or feature work
143. **#1198** `claude/m05-update-outcome` class F: not reviewed; plan, engine or feature work
144. **#1199** `claude/b4-r00-cover-text-offset` class F: not reviewed; plan, engine or feature work
145. **#1200** `claude/m07-support-completeness` class F: not reviewed; plan, engine or feature work
146. **#1201** `claude/tl2-r151-roofdown-one-switch` class F: not reviewed; plan, engine or feature work
147. **#1202** `claude/tl2-r151-job-folder-levels` class F: not reviewed; plan, engine or feature work
148. **#1205** `claude/tl2-r151-bracing-words` class F: not reviewed; plan, engine or feature work
149. **#1210** `claude/tl2-r154-autosupport-bands` class F: not reviewed; plan, engine or feature work
150. **#1211** `claude/tl2-r154-wrong-units-tuning` class F: not reviewed; plan, engine or feature work
151. **#1213** `claude/tl2-detail-numbering` class F: not reviewed; plan, engine or feature work
152. **#1214** `claude/tl2-details-needed` class F: not reviewed; plan, engine or feature work
153. **#1248** `codex/cesettings-issue-struc` class F: not reviewed; plan, engine or feature work
154. **#1250** `codex/cesettings-roof-struc` class F: not reviewed; plan, engine or feature work
155. **#1251** `codex/cesettings-privacy-civil` class F: not reviewed; plan, engine or feature work
156. **#1252** `codex/cesettings-limits-civil` class F: not reviewed; plan, engine or feature work
157. **#1258** `codex/calc-export-regression-20261014` class F: not reviewed; plan, engine or feature work
158. **#1302** `claude/mx04-r2-rfi` class F: not reviewed; plan, engine or feature work
159. **#1305** `claude/mx04-r2-tank-callout-wire` class F: not reviewed; plan, engine or feature work
160. **#1314** `claude/mx-tidy-labels-q1` class F: not reviewed; plan, engine or feature work
161. **#1600** `claude/tl2-cemember-i-save-record` class F: not reviewed; plan, engine or feature work
162. **#1602** `claude/tl2-cemember-j-sbeamedit` class F: not reviewed; plan, engine or feature work
163. **#1702** `cx3/tests-bd02` class F: not reviewed; plan, engine or feature work
164. **#1704** `cx3/tests-bd01` class F: not reviewed; plan, engine or feature work

### Class G - duplicate or superseded by another PR (21)

1. **#851** `claude/tl2-r118-roofdown-help` class G: same Roof-down switch as newer #1045
2. **#1032** `claude/b23-pit-last-values` class G: same New Pit last-size change as newer #1086
3. **#1381** `claude/b3-xcivil-pit-merge-733` class G: same bug and wording as #1353, which is already installed
4. **#1382** `claude/tl2-r440-bug748-dots-scale` class G: same bug and wording as #1498, which is already installed
5. **#1468** `b03/bug-845-admin-buttons-catch` class G: same bug and wording as #1455, which is already installed
6. **#1471** `b03/bug-849-offline-list` class G: same bug and wording as #1454, which is already installed
7. **#1472** `b03/bug-853-click-log` class G: same bug and wording as #1462, which is already installed
8. **#1519** `claude/b4-bug-859` class G: same bug and wording as #1520, which is already installed
9. **#1537** `cx/eng-pipe-material-c60` class G: BUG-868 finished in #1664 (also reviewed)
10. **#1541** `cx/fb02-c60` class G: FB-02 note-only draft; real fix is #1659 (also reviewed)
11. **#1542** `cx/fb04-c60` class G: FB-04 note-only draft; real fix is #1663 (also reviewed)
12. **#1543** `cx/fb07-c60` class G: FB-07 note-only draft; real fix is #1688 (also reviewed)
13. **#1544** `cx/fb05-c60` class G: FB-05 note-only draft; real fix is #1671 (also reviewed)
14. **#1550** `cx/fb06-c60` class G: FB-06 note-only draft; real fix is #1682 (also reviewed)
15. **#1555** `fw2/bug-964-redesign-pit-level` class G: BUG-964 replaced by #1669 (also reviewed)
16. **#1571** `b04/bug-963-propagate-hidden-il` class G: same bug and wording as #1567, which is already installed
17. **#1576** `fw2/bug-971-unreadable-record-kept` class G: BUG-971 replaced by #1658 (also reviewed)
18. **#1622** `b03/bug-1019-detention-negative-levels` class G: same bug and wording as #1625, which is already installed
19. **#1624** `b03/bug-1004-agreed-design-head` class G: same bug and wording as #1623, which is already installed
20. **#1630** `b03/bug-969-newdwg-job-from-new-folder` class G: same bug and wording as #1692, which is planned for a train
21. **#1639** `b03/bug-1032-twl-pick-list-wording` class G: same bug and wording as #1635, which is reviewed MERGE

### Class H - old or stale, or fixes a bug the carpark already shows FIXED (147)

1. **#1** `claude/cool-cannon-fe1ebd` class H: branched 2026-07-03, far behind installed code; last change 2026-09-03
2. **#2** `claude/xcivil-import-strategy-6nvd11` class H: branched 2026-07-03, far behind installed code; last change 2026-09-03
3. **#3** `claude/serene-allen-6d58d3` class H: branched 2026-07-03, far behind installed code; last change 2026-09-03
4. **#13** `claude/drainage-stageb-consumer-inventory-hb4oms` class H: branched 2026-07-26, far behind installed code; last change 2026-07-28
5. **#19** `claude/project-control-ribbon-status-map` class H: branched 2026-08-04, far behind installed code; last change 2026-08-18
6. **#23** `codex/civil-editor-undo-bracket` class H: branched 2026-08-31, far behind installed code; last change 2026-08-31
7. **#43** `claude/41-github-actions` class H: branched 2026-08-31, far behind installed code; last change 2026-09-04
8. **#47** `codex/worktree-recovery-audit-20260904` class H: branched 2026-09-04, far behind installed code; last change 2026-09-04
9. **#55** `claude/rulebook-structural-r30-r31` class H: branched 2026-09-04, far behind installed code; last change 2026-09-04
10. **#57** `codex/rulebook-column-pad` class H: branched 2026-09-04, far behind installed code; last change 2026-09-05
11. **#67** `claude/windows-builder-chat-prompt-2a1a8c` class H: branched 2026-09-05, far behind installed code; last change 2026-09-05
12. **#68** `claude/structural-module-ui-ux-241f85` class H: branched 2026-09-05, far behind installed code; last change 2026-09-05
13. **#69** `codex/level3-all-modules-plan-20260906` class H: branched 2026-09-05, far behind installed code; last change 2026-09-05
14. **#71** `codex/v3-structural-manager-design-pack` class H: branched 2026-09-06, far behind installed code; last change 2026-09-10
15. **#72** `codex/structural-full-plan-20260914` class H: branched 2026-09-06, far behind installed code; last change 2026-09-14
16. **#73** `codex/structural-beam-feedback-12345` class H: branched 2026-09-06, far behind installed code; last change 2026-09-14
17. **#88** `claude/e-hold-01-move-test` class H: branched 2026-09-23, far behind installed code; last change 2026-09-23
18. **#208** `codex/v3-noscroll-1` class H: branched 2026-09-24, far behind installed code; last change 2026-09-25
19. **#230** `codex/ux-std-03-no-save` class H: branched 2026-09-24, far behind installed code; last change 2026-09-25
20. **#352** `claude/bug-160-grade-held-typed-invert` class H: carpark already shows BUG-160 FIXED or installed
21. **#369** `claude/bug-069-mirrored-text` class H: branched 2026-09-29, far behind installed code; last change 2026-09-28
22. **#424** `claude/manager-settings-move` class H: branched 2026-09-29, far behind installed code; last change 2026-10-03
23. **#463** `claude/bug268-copied-check` class H: carpark already shows BUG-268 FIXED or installed
24. **#514** `claude/bug334-schedule-stale-native` class H: carpark already shows BUG-334 FIXED or installed
25. **#517** `claude/bug334-link-marker` class H: carpark already shows BUG-334 FIXED or installed
26. **#518** `claude/bug333-legacy-busy-save` class H: carpark already shows BUG-333 FIXED or installed
27. **#520** `claude/bug333-units-ask-once` class H: carpark already shows BUG-333 FIXED or installed
28. **#590** `codex/bj1-array` class H: carpark already shows BUG-353 FIXED or installed
29. **#668** `claude/bug-393c-markup-metre-readers` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
30. **#676** `claude/b03-bug331-4-longsection-length` class H: carpark already shows BUG-331 FIXED or installed
31. **#679** `claude/l3-levels-drawing-reader` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
32. **#680** `claude/l3-sources-destinations` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
33. **#682** `claude/l3-network-gap-list` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
34. **#689** `codex/k4-stale-cell` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
35. **#690** `claude/tl2-fst-leftover-undo` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
36. **#691** `claude/l3-levels-proposal-write` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
37. **#693** `claude/l3-network-not-enough-learned` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
38. **#694** `claude/l3-detention-options` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
39. **#696** `claude/b03-c3-council-next` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
40. **#698** `codex/w2-layout-gaps-window` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
41. **#699** `claude/l3-detention-clash-check` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
42. **#701** `claude/b03-uxcr11-survey-contour-check` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
43. **#706** `claude/l3-sources-roof-edge` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
44. **#707** `claude/b03-uxcr05-short-offcut` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
45. **#708** `claude/l3-detention-ghosts` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
46. **#709** `claude/tl2-struc-screens-temp` class H: carpark already shows BUG-318 FIXED or installed
47. **#710** `claude/b03-bug403-paste-no-record` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
48. **#712** `claude/b03-uxcr14-council-3500-edition` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
49. **#713** `codex/s1-sources` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
50. **#714** `claude/b03-uxcr13-detention-needed` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
51. **#716** `claude/b03-uxcr17-floor-freeboard` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
52. **#717** `codex/s3-offcut` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
53. **#718** `claude/b03-uxcr08-refused-pipe-material` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
54. **#720** `claude/b03-council-info-only-list` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
55. **#724** `claude/l3-levels-pit-typed` class H: branched 2026-10-04, far behind installed code; last change 2026-10-07
56. **#725** `claude/tl2-overnight-report` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
57. **#726** `claude/tl2-office-plot-check` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
58. **#727** `claude/b03-charged-pipe-flip-line` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
59. **#728** `claude/tl2-markup-qa-items` class H: branched 2026-10-04, far behind installed code; last change 2026-10-07
60. **#729** `claude/b03-uxcr15-council-basement-rule` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
61. **#730** `codex/settings-enter-s` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
62. **#732** `codex/settings-enter-c` class H: branched 2026-10-04, far behind installed code; last change 2026-10-04
63. **#742** `b03/bug406-metre-readers` class H: branched 2026-10-04, far behind installed code; last change 2026-10-05
64. **#751** `claude/l3-sources-ghosts` class H: branched 2026-10-04, far behind installed code; last change 2026-10-07
65. **#754** `claude/l3-network-layout-habits` class H: branched 2026-10-04, far behind installed code; last change 2026-10-07
66. **#755** `claude/l3-sources-numbering` class H: branched 2026-10-04, far behind installed code; last change 2026-10-08
67. **#756** `claude/l3-detention-accept` class H: branched 2026-10-04, far behind installed code; last change 2026-10-07
68. **#767** `codex/verify-w15-20261007` class H: branched 2026-09-28, far behind installed code; last change 2026-10-07
69. **#768** `codex/w1d-issue-preview-window` class H: branched 2026-10-07, far behind installed code; last change 2026-10-07
70. **#781** `claude/tl2-issue-preview-wiring` class H: branched 2026-10-07, far behind installed code; last change 2026-10-07
71. **#813** `claude/tl2-fadopt-default` class H: branched 2026-10-08, far behind installed code; last change 2026-10-07
72. **#817** `claude/bug-805-typed-level-wording` class H: branched 2026-10-08, far behind installed code; last change 2026-10-08
73. **#821** `claude/l3-sources-placemany` class H: branched 2026-10-04, far behind installed code; last change 2026-10-08
74. **#824** `claude/bug-435-civil-no-main-cuix` class H: carpark already shows BUG-435 FIXED or installed
75. **#831** `claude/tl2-r115-struc-tooltips` class H: branched 2026-10-09, far behind installed code; last change 2026-10-08
76. **#842** `claude/b1-tidy-avoid-xref-hatch` class H: branched 2026-10-09, far behind installed code; last change 2026-10-08
77. **#843** `claude/tl2-r116-off-wording` class H: branched 2026-10-09, far behind installed code; last change 2026-10-08
78. **#844** `claude/b1-auto-callout` class H: branched 2026-10-09, far behind installed code; last change 2026-10-08
79. **#852** `claude/tl2-r118-layout-ranking` class H: branched 2026-10-09, far behind installed code; last change 2026-10-08
80. **#853** `claude/b4-first-start` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
81. **#855** `claude/b4-recent-jobs` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
82. **#856** `claude/b4-admin-practice` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
83. **#892** `b03/hunt2-c01-import-units` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
84. **#907** `b03/hunt2-c07-detention-pipe-settings` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
85. **#925** `b03/hunt2-c13-one-freeboard` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
86. **#931** `b03/hunt2-c15-landxml-size-units` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
87. **#932** `b03/hunt2-c11b-shared-storm-list` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
88. **#934** `b03/hunt2-c14b-no-profiles-words` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
89. **#938** `b03/hunt-m09b-health-paths-no-login` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
90. **#939** `claude/tl2-r122-pad-size` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
91. **#941** `b03/audit-a6-failure-report-scrub` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
92. **#944** `b03/audit-a7-civil-report-scrub` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
93. **#945** `b03/audit-a8-attribute-log` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
94. **#948** `claude/b5-status-layers` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
95. **#954** `b03/priv-office-folder-coded` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
96. **#960** `claude/b5-wrong-layer-reader` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
97. **#977** `claude/tooling01-witness-recorder` class H: branched 2026-09-28, far behind installed code; last change 2026-10-09
98. **#978** `claude/tooling01-what-got-drawn` class H: branched 2026-09-28, far behind installed code; last change 2026-10-09
99. **#979** `claude/tooling01-window-pictures` class H: branched 2026-09-28, far behind installed code; last change 2026-10-09
100. **#980** `claude/tooling01-fall-and-pit-label-checks` class H: branched 2026-09-28, far behind installed code; last change 2026-10-09
101. **#1015** `claude/tl2-r132-bug504-windclass-blank` class H: carpark already shows BUG-504 FIXED or installed
102. **#1022** `claude/b5-wrong-layer-pipes` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
103. **#1027** `claude/b5-removed-leaves-checks` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
104. **#1034** `claude/b2-checks-palette-command` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
105. **#1038** `claude/b5-footing-zone-engine` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
106. **#1041** `codex/noblue-manager` class H: branched 2026-10-09, far behind installed code; last change 2026-10-10
107. **#1043** `codex/noblue-civil` class H: branched 2026-10-09, far behind installed code; last change 2026-10-10
108. **#1044** `codex/noblue-struc` class H: branched 2026-10-09, far behind installed code; last change 2026-10-10
109. **#1050** `claude/l3-detention-combos` class H: branched 2026-10-04, far behind installed code; last change 2026-10-09
110. **#1051** `claude/b4-command-tips` class H: branched 2026-10-09, far behind installed code; last change 2026-10-09
111. **#1063** `codex/cesettings-rows` class H: branched 2026-10-09, far behind installed code; last change 2026-10-10
112. **#1065** `claude/l3-sources-propose-command` class H: branched 2026-10-04, far behind installed code; last change 2026-10-10
113. **#1067** `claude/l3-network-habit-store` class H: branched 2026-10-04, far behind installed code; last change 2026-10-10
114. **#1073** `claude/b4-panel-health-line` class H: branched 2026-10-09, far behind installed code; last change 2026-10-10
115. **#1079** `claude/bug-446-batch-marker` class H: carpark already shows BUG-446 FIXED or installed
116. **#1089** `claude/b4-panel-strip` class H: branched 2026-10-09, far behind installed code; last change 2026-10-10
117. **#1138** `claude/b4-drafting-words` class H: carpark already shows BUG-523, BUG-524 FIXED or installed
118. **#1149** `claude/tl2-r150-plain-words-b` class H: carpark already shows BUG-523 FIXED or installed
119. **#1204** `claude/tl2-r151-units-convert` class H: branched 2026-10-09, far behind installed code; last change 2026-10-11
120. **#1208** `codex/cesettings-rows-civil` class H: branched 2026-10-09, far behind installed code; last change 2026-10-11
121. **#1220** `claude/b4-r00-pump-pervious-c` class H: carpark already shows BUG-544 FIXED or installed
122. **#1240** `claude/b3-bug516c-no-detention-sentence` class H: carpark already shows BUG-516 FIXED or installed
123. **#1241** `claude/b3-bug516d-landxml-size-units` class H: carpark already shows BUG-516 FIXED or installed
124. **#1247** `claude/tl2-r205-bug439-plain-width-wording` class H: carpark already shows BUG-439 FIXED or installed
125. **#1249** `codex/w-gradekeep` class H: carpark already shows BUG-160 FIXED or installed
126. **#1445** `b03/bug-836-devices-behind` class H: carpark already shows BUG-836, BUG-837 FIXED or installed
127. **#1451** `b03/bug-847-support-zip-temp-names` class H: carpark already shows BUG-847 FIXED or installed
128. **#1465** `b03/bug-843-admin-name-match` class H: carpark already shows BUG-843 FIXED or installed
129. **#1466** `claude/tl2-r455-bug846-salt` class H: carpark already shows BUG-846 FIXED or installed
130. **#1467** `b03/bug-844-dashboard-half-file` class H: carpark already shows BUG-844 FIXED or installed
131. **#1662** `cx2/bug-928-batch12-triage` class H: notes or records only, no working fix (same record sits in CE_PLAN)
132. **#1666** `cx2/bug-933-batch13-triage` class H: notes or records only, no working fix (same record sits in CE_PLAN)
133. **#1667** `cx2/bug-938-942-coverage` class H: notes or records only, no working fix (same record sits in CE_PLAN)
134. **#1668** `cx2/bug-943-batch15-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
135. **#1673** `cx2/bug-953-batch17-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
136. **#1674** `cx2/bug-968-batch20-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
137. **#1675** `cx2/bug-973-batch21-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
138. **#1677** `cx2/bug-983-batch23-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
139. **#1678** `cx2/bug-988-batch24-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
140. **#1679** `cx2/bug-993-batch25-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
141. **#1680** `cx2/bug-998-batch26-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
142. **#1681** `cx2/bug-1003-batch27-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
143. **#1683** `cx2/bug-1013-batch29-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
144. **#1684** `cx2/bug-1018-batch30-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
145. **#1685** `cx2/bug-1023-batch31-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
146. **#1686** `cx2/bug-1028-batch32-audit` class H: notes or records only, no working fix (same record sits in CE_PLAN)
147. **#1705** `cx3/tests-bd04` class H: carpark already shows BUG-303, BUG-315, BUG-858 FIXED or installed

