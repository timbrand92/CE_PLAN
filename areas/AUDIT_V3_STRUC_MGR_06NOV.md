# V3 audit: Structural, Manager and Shared. What is built, off, engine-only, not built, or needs fixing

Written Fri 6 Nov 2026 (Melbourne) by Claude Sonnet 5.5. Read-only job: I built nothing, ran no tests, opened no AutoCAD, installed nothing. Only this file was written.

Code read: Structural 1.0.126 at `C:\CE_WORK\scratch\audit_struc` (commit 8de95c34); Manager 1.1.89 and Shared at `C:\CE_WORK\scratch\audit_civil` (commit cf059dcf); Structural candidate S-46 (f8a01fe4) by `git grep` only.

---

## FOR TIM

1. **Plain answer:** most of what you use daily (beams, bracing, DS/C1/TS1, R1/FJ1/P1, CLEAN) is in your install and reachable. About a quarter of the roof-down production tools are installed but OFF or typed-only. The big plan items (computations, detail library, whole-plan proposal, Move My Settings) are not built.
2. **Totals (see counts at the bottom, 110 lines):** WORKS-INSTALLED 38 of 110, NEEDS-FIXING 25 of 110, INSTALLED-BUT-OFF 18 of 110, ENGINE-ONLY 1 of 110, CANDIDATE-ONLY 1 of 110, NOT-BUILT 14 of 110, UNKNOWN 13 of 110.
3. **How sure:** I checked 71 of 110 lines myself in the code, 1 of 110 are carried from older documents only, 38 of 110 are both. "Installed" here means the code is there and reachable. It does not mean it works: nobody has driven the Structural items on 1.0.126 in AutoCAD.
4. **Ribbon:** 79 of the 377 Structural commands have no ribbon button of their own. 58 of those are explained (typed shortcuts, or a roof-down tool hidden by design). **21 have no button and no plan item.**
5. **The 10 most damaging gaps are listed straight below.** Items 6 to 8 here are the biggest surprises.
6. **Surprise 1:** the Structural ribbon is still the flat list of 298 buttons. Your ruling (about 40 tools in families) is built but switched OFF.
7. **Surprise 2:** the roof-down tools you approved on 25 Sep to 7 Oct (roof setout, floor span arrow, lintels, framing legend, member schedule, wall schedule, footing proposals) ship OFF and have no button. Typing the name tells you a switch is off.
8. **Surprise 3:** the Manager colleague "Roll back" is admin-only and hidden until a switch file says so. The fix for the stale schedule rows (BUG-497, 498) is only in the S-46 candidate.

### The 10 most damaging gaps (worst first)

1. **Support blocks DS, DS1, TS1, C1, C2 have a pile of open bugs** (BUG-1139, 434, 437, 438, 576, 501, 974). Several fixes are in your install (1.0.121) but nobody has proved them. C1/C2 can take the wrong size from the member schedule when the same mark is used on two floors (BUG-501).
2. **Bracing schedule tables are one row short or keep erased rows** (BUG-497, 498). Overstated bracing is the dangerous direction. Fixed only in the S-46 candidate, not installed.
3. **Bracing panel adds roof trusses (BT1) into the wall totals** (BUG-499). Wrong numbers on a sheet.
4. **SBEAM steel section list is wrong in places** (BUG-818, 819: UB/UC radii, PFC, angles, welded sections, hollow sections, Lysaght purlins). The Z purlin section outline crosses itself (BUG-858). Waiting on your ten-row check.
5. **CEMEMBER (the SBEAM replacement) has no window and no button.** Command line only, hidden. BUG-864, 880, 909 open.
6. **Computations (UX-SCALC-01..08) are engine-only.** No command, nothing a drafter can reach.
7. **Move My Settings (M-SET-01) is not on the installed line.** Drafts #424/#425 are 72 to 75 commits behind and unmerged.
8. **No detail library, no details sheets, no whole-plan proposal** (UX-DET, UX-SL3). Nothing in the code.
9. **Publish Issue (CESHEETS) has a HIGH open bug** (BUG-495, 1262), and its extras (job-wide PDF, DWG snapshot, preview) ship OFF.
10. **Manager end-to-end update has no recorded pass.** The two blockers found on 19 Oct (HUNT-MI-01, 02) are fixed in the code I read, but nobody has run a colleague install. The Admin Dashboard opens for ordinary users from "Updates & Rollback" (BUG-1247).

---

## How to read this

1. **Status words:** WORKS-INSTALLED = code is in the installed commit, reachable by a command or button, on by default. INSTALLED-BUT-OFF = installed, off by default or behind a setting. ENGINE-ONLY = code exists, nothing reachable calls it. CANDIDATE-ONLY = only in S-46. NOT-BUILT = I found no code. NEEDS-FIXING = reachable but has an open bug (number given). UNKNOWN = I could not tell.
2. **Source word at the end of each line:** Checked = I read the code or registry myself. Carried = taken from an older document and not re-checked. Checked + carried = both.
3. **Typed-only** means the command exists and works by typing, but the registry hides it from the ribbon.
4. **Open bug text can be stale.** Several carpark entries still read OPEN although the code now has the fix (for example BUG-471, 472, 473: the units, layout and locked-layer guards are in the code for R1, BT1, C1, TS1, AB, BB). I name a bug only when I could not see it fixed.
5. **The plan list.** The full 548-item list is not held as one file. I used the Structural, Manager and Shared sections of `V3_UX_PLAN.md`, `areas\structural.md`, `areas\manager.md`, the 29 Oct recount and the card drafts. Where the plan gives a range (for example UX-SSCHED-01..13) I report the range as one line and say which numbers I found in code.
6. **Version note.** `audit_civil` is at cf059dcf (Civil 3.0.90). The carpark audit says Civil 3.0.89 (61fd6fbc) is the installed build and cf059dcf is candidate b1. I diffed 61fd6fbc against cf059dcf for `Modules/Manager` and `Shared`: no differences, so Manager and Shared results hold for either.

---

## A. ROOF (draft first)

1. **R1 rafter marker:** [NEEDS-FIXING] On the ribbon. Units, layout and locked-layer guards are in the code. Open: BUG-584 (bay sizes do not reach the block; fix installed in 1.0.121, never tested), BUG-467 (wrong place in a rotated UCS, not seen fixed). Source: Checked + carried.
2. **FJ1 floor joist marker:** [NEEDS-FIXING] BUG-584 (FJ1 part; fix installed, untested). Layer name comes from Settings. Source: Checked + carried.
3. **P1 purlin marker:** [NEEDS-FIXING] BUG-584 says plain P1 reproduced the dimension fault; BUG-467 for the rotated UCS. Source: Checked + carried.
4. **UX-FRM-05 roof area setout (CSROOFSETOUT, rafter or truss arrow, GT marks):** [INSTALLED-BUT-OFF] Settings RoofSetout.Enabled is false, no ribbon button. Card is DRAFT, not approved. Source: Checked.
5. **UX-FRM-11 floor joist and bearer span arrow (CSFLOORSETOUT):** [INSTALLED-BUT-OFF] FloorSetout.Enabled false, hidden. Card DRAFT. Source: Checked.
6. **UX-FRM-04 lintel proposals over openings (CSLINTELPROPOSE):** [INSTALLED-BUT-OFF] LintelProposal.Enabled false, hidden. Source: Checked.
7. **UX-FRM-06 supports proposed under beam ends:** [NOT-BUILT] No code carries that number. Source: Checked.
8. **UX-FRM-01 framing plan legend (CSFRAMINGLEGEND):** [INSTALLED-BUT-OFF] FramingLegend.Enabled false, hidden. Source: Checked.
9. **UX-SSCHED-05 member schedule from the plan (CSMEMBERSCHED, MARK | SIZE blocks):** [INSTALLED-BUT-OFF] MemberSchedule.Enabled false, hidden. Source: Checked.
10. **UX-FRM-12 beam hover (mark, size, span, calc status):** [INSTALLED-BUT-OFF] BeamHover.Enabled false. The hover-menu approach on ordinary objects was stopped (BUG-159 class). Source: Checked + carried.
11. **UX-FRM-13 beams at level on BEAMS, lower beams on BEAMS LOWER:** [WORKS-INSTALLED] Beam commands 1 and 2 carry it. Not re-proved on 1.0.126. Source: Checked.
12. **UX-SUB-03 trusses by others as direction and tag, rafters as span arrows:** [INSTALLED-BUT-OFF] Rides on the roof setout switch (line 4). Source: Checked.
13. **UX-SUB-04 roof point loads carried down (CSPOINTLOAD):** [INSTALLED-BUT-OFF] RoofPointLoad.MarkerEnabled and CarryDown both false. Source: Checked.
14. **BT1 bracing truss:** [NEEDS-FIXING] BUG-499 (its trusses are added to the WALL bracing totals), BUG-467. Guards for units, layout and locked layer are in the code. Source: Checked + carried.
15. **AB, BB, ABSWITCH (wall bracing A/B and the switch):** [WORKS-INSTALLED] On the ribbon, guarded for units, layout, locked layers. Last Codex pass was on the bracing panel only (BUG-218, 1.0.116). Source: Checked + carried.
16. **Bracing schedule tables (STRSCHEDCREATE, STRSCHEDREFRESH, STRSCHEDSYNC):** [NEEDS-FIXING] BUG-497 (tables one row short) and BUG-498 (erased braces stay). Fixes are in the S-46 candidate only (f2841ae4, 9341c350). Source: Checked.
17. **UX-FRM-14 bracing required vs provided per direction (CSBRACINGPANEL, CSBRACINGREQUIRED):** [NEEDS-FIXING] BUG-499 and BUG-950 (panel colour when brace types differ; draft #1603). Codex narrow pass on 1.0.116. Source: Checked + carried.
18. **UX-FRM-15 tie-down symbols feeding a schedule (CSTIEDOWN, CSTIEDOWNTYPES):** [WORKS-INSTALLED] Visible commands. Not proved on 1.0.126. Source: Checked.

## B. BEAMS AND STEEL (all floors)

19. **Beam commands 1, 2, 4, 5 and BDL:** [WORKS-INSTALLED] On the ribbon. Codex-accepted on 1.0.77 for 1, 2 and 4 (BUG-182 to 184). Not re-run on 1.0.126. Source: Checked + carried.
20. **UX-BEAM-01..03 plain failure reasons and STRUCDEBUG:** [WORKS-INSTALLED] Referenced in code; STRUCDEBUG is typed-only and Codex-accepted (BUG-181). Source: Checked + carried.
21. **BSET, BSETRESET, BSETLIST (beam inside point):** [NEEDS-FIXING] BUG-1077 (tooltip and CEHELP wording wrong). Commands work by code. Source: Checked + carried.
22. **UX-D2-01..04 beams follow their support, labels follow, one Undo:** [WORKS-INSTALLED] Linking switch defaults ON. Codex-accepted on 1.0.77 (BUG-183). Source: Checked + carried.
23. **UX-D2-05b beams and columns as CE's own object, hover menu:** [NOT-BUILT] Mentioned in a comment only. Source: Checked.
24. **SBEAM (steel and timber section):** [NEEDS-FIXING] BUG-818 and 819 (section list differs from supplier data), BUG-858 (Z outline crosses itself), BUG-864, BUG-952. Stale-id crash fix (BUG-1275) is in S-46 only. Source: Checked + carried.
25. **SBEAMEDIT:** [NEEDS-FIXING] BUG-1132 (latent). BUG-1275 fix in S-46 only. Source: Checked + carried.
26. **CEMEMBER (replaces SBEAM):** [NEEDS-FIXING] Typed-only command with side and top elevation and a section view, command-line questions. The one window with live preview is not built. Open: BUG-864, 880 (metre drawing), 909 (UCS). Source: Checked + carried.
27. **RCBEAM and RC beam schedule (CSRCBEAMSCHEDULE):** [WORKS-INSTALLED] RCBEAM on the ribbon; schedule typed-only. Not proved on 1.0.126. Source: Checked.
28. **UX-STEEL-02 and 04 (galvanising note from exposure, substitution as standard note):** [WORKS-INSTALLED] Rules coded in the SBEAM note selector. Source: Checked.
29. **UX-STEEL-01 searchable catalogue picker with calc-passing sizes highlighted:** [UNKNOWN] The SBEAM picker exists; I did not find the calc-passing highlight. Source: Checked.
30. **UX-MARK-01..07 marks (gaps stay, identical beams share a mark, columns share by size):** [UNKNOWN] The mark engine and CSMARKSRENUMBER exist; numbers 01, 02, 06, 07 are referenced in code, 03 to 05 are not. Source: Checked.

## C. UPPER FLOORS

31. **DS and DS1 (support blocks):** [NEEDS-FIXING] BUG-1139 (placement and label movement, open on 1.0.122), BUG-974 (name clash with schedule marks). Source: Checked + carried.
32. **TS1:** [NEEDS-FIXING] BUG-434, 437 (fixes installed in 1.0.121, never tested), BUG-1139 style placement issue. Source: Checked + carried.
33. **C1 and C2:** [NEEDS-FIXING] BUG-438, 437, 576 (Select Column Type window), BUG-501 (size by mark ignores the floor), BUG-974. Source: Checked + carried.
34. **SDS, SDS1, STS1, SC1, SC2 (switch a support):** [NEEDS-FIXING] BUG-975 (a switch can disturb a neighbour's label; draft #1564, not on any line). Source: Checked + carried.
35. **UX-LEVEL-01 plan level (CSPLANLEVEL):** [WORKS-INSTALLED] Typed-only. Source: Checked.
36. **UX-LEVEL-02 the level above and below as (O) and (U) (CSLEVELCARRY):** [INSTALLED-BUT-OFF] LevelCarry.Enabled false, hidden. Card DRAFT. Source: Checked.
37. **UX-UNIT-01..03 multi-unit jobs (CSUNITCOPY, CSUNITTOOLS, CSUNITTAGS):** [WORKS-INSTALLED] Typed-only. UX-UNIT-04 (every value with its unit) not checked. Source: Checked.
38. **UX-LOAD path and load-bearing walls (CSLOADPATH, LBW):** [WORKS-INSTALLED] Visible commands. Source: Checked.
39. **UX-LOAD-02/03 carry loads down from the level above:** [INSTALLED-BUT-OFF] TraceFromLevelAbove and PostsFromSupportBlocks default false. Source: Checked.
40. **UX-SYM-02 step symbol and SLAB STEP line (CSSLABSTEP), UX-SYM-03 section mark offers its detail:** [UNKNOWN] CSSLABSTEP typed-only and present; SYM-03 referenced but I did not trace it. Source: Checked.
41. **UX-SUB-01/02 timber subfloor bearers and stumps (CSSUBFLOORGRID, CSSUBFLOORSET, CSTAGBEARERS):** [WORKS-INSTALLED] Typed-only. Source: Checked.
42. **UX-NOTES-02..04 general notes page (CSGENNOTES):** [WORKS-INSTALLED] Typed-only. Source: Checked.
43. **UX-NOTES-07..09 boxed notes and leader notes (CSBOXNOTES, CSLEADERNOTE):** [WORKS-INSTALLED] Typed-only. Source: Checked.
44. **Level marks (FFL, FFLMARKER, CE_RL, CE_NGL, CE_SSL and short forms):** [WORKS-INSTALLED] Legacy, on the ribbon. Source: Checked.

## D. GROUND FLOOR

45. **UX-RAFT-01/04 footing schedule and RC beam schedule in office columns (CSFOOTINGSCHEDULE, CSRCBEAMSCHEDULE):** [WORKS-INSTALLED] Typed-only. Source: Checked.
46. **UX-RAFT-02/03 footing-plan legend and infill slab tracked area (CSFOOTINGLEGEND, CSINFILL):** [WORKS-INSTALLED] Typed-only. Source: Checked.
47. **UX-BSMT-01, 02, 04, 05, 06 basements (CSBSMTWALL, CSPUMPPIT, CSPUMPPITSCHEDULE, CSREOBAR):** [WORKS-INSTALLED] Walls and pump pit visible; reo bar typed-only. Source: Checked.
48. **UX-BSMT-03 suspended slab area and band beams:** [NOT-BUILT] No code carries that number. Source: Checked.
49. **UX-SOIL-01..04 geotech report, wind class (CSSOILREPORT, CSWINDCLASS):** [WORKS-INSTALLED] Visible commands and a report reader. Not proved. Source: Checked.
50. **UX-FDN-05 waffle pod slabs:** [NOT-BUILT] Only the word appears, in hatch patterns. Source: Checked.
51. **UX-FDN-05 screw piles (SCREWPILE):** [WORKS-INSTALLED] Visible. Source: Checked.
52. **Live wall schedule (CSWALLSCHEDULE) and wall marks (CSWALLMARK):** [INSTALLED-BUT-OFF] WallSchedule.Enabled false. Source: Checked.
53. **Standard lintel table (CSLINTELTABLE):** [INSTALLED-BUT-OFF] LintelTable.Enabled false. Source: Checked.
54. **Slab, wall and column detail commands (BSSLAB, WALLREO, WALLSTRS, COLTIES, LIGS and more):** [WORKS-INSTALLED] Typed-only, no plan item of their own. Source: Checked.

## E. FOOTINGS (last)

55. **UX-FDN-01 footing proposals from what sits above (CSFDNPROPOSE):** [INSTALLED-BUT-OFF] FoundationProposal.Enabled false, hidden. Source: Checked.
56. **UX-FDN-02/03 footing grips like beams:** [INSTALLED-BUT-OFF] FoundationGrip.Enabled false. Source: Checked.
57. **UX-FDN-04 bar marks and bar schedule (CSREOBAR, CSBARSCHEDULE):** [WORKS-INSTALLED] Typed-only. Source: Checked.
58. **Footing edit commands (FST, FSF, FPFC, FEDIT, FDELETE, FREGEN):** [NEEDS-FIXING] On the ribbon. BUG-300 (OOPS after erasing a footing line, draft #1988, not on a line). Source: Checked + carried.
59. **Piers and BP family (CSPIER, BP, BPC and variants):** [NEEDS-FIXING] BUG-536 (BP says nothing when the Settings pier size is not on the block; draft #1986). Source: Checked + carried.
60. **UX-SYM-01 CE pier object with automatic tags:** [WORKS-INSTALLED] CSPIER is visible and referenced widely in code. Not proved. Source: Checked.
61. **Stump footings and legacy footing shapes (STUMPFOOTING, SF, SFC and others):** [WORKS-INSTALLED] On the ribbon. Source: Checked.

## F. ACROSS ALL FLOORS (Structural)

62. **CLEAN:** [WORKS-INSTALLED] Saves at the end again (B-178, Tim 5 Nov), in 1.0.126. Robot and Codex have not run it on this build. Source: Checked.
63. **FASTSAVE:** [WORKS-INSTALLED] Also saves (B-178). Source: Checked.
64. **UX-STRUC-02..05, 07, 08 ribbon families (about 40 tools, not 298):** [INSTALLED-BUT-OFF] BeamFamilyDropDown, TagFamilyDropDown, OneNamePerTool all default false. The ribbon is the flat 298. Source: Checked.
65. **UX-STRUC-09 smart tag learned from past drawings:** [NOT-BUILT] No code carries it. Source: Checked.
66. **UX-STRUC-12 2022 colleagues get Structural with 2027-only tools greyed:** [WORKS-INSTALLED] Code present with plain reason in the tooltip. Source: Checked.
67. **UX-STRUC-01 closed-sheet writes kept with a notice:** [UNKNOWN] Sheet guards exist; I did not trace the notice. Source: Checked.
68. **UX-QA-01..08 QA against the engineer's markup (CEMARKUP* commands, CEMARKUPCHECK):** [INSTALLED-BUT-OFF] Eleven CEMARKUP commands visible, but QaEnabled and SendPagesToAiEnabled default false. Source: Checked.
69. **UX-REG-01..15 register and issue (CESHEETS):** [NEEDS-FIXING] BUG-495 (HIGH, Publish Issue), BUG-1262. Job-wide PDF, DWG snapshot and issue preview all default OFF. Source: Checked + carried.
70. **UX-LAY-01..04 New sheet with layout, viewport, locked scale:** [UNKNOWN] Code exists in the sheets service; I did not find which button calls it. Source: Checked.
71. **UX-DET-01..06 detail library, details sheets:** [NOT-BUILT] Nothing in code. CE Blocks (Manager) is a block palette only. Source: Checked.
72. **UX-SEC-01 section marks (SM, SECTION):** [NEEDS-FIXING] BUG-630 (draft #1981: side pick gives the wrong bubble; not on a line). Source: Checked + carried.
73. **UX-SEC-02/03 member sections from member data, steel connections from a library:** [NOT-BUILT] Only the legacy typed STLCONN, PORTAL, KNEE and similar drawing commands exist. Source: Checked.
74. **UX-SCALC-01..08 computations in CE:** [ENGINE-ONLY] Settings say it outright: no command, no button, off. Source: Checked.
75. **UX-SL3-01/02 whole-plan proposal learned from past framing:** [NOT-BUILT] Nothing in code. Source: Checked.
76. **UX-ARCH and CEARCHREVIEW (architect's drawing changed):** [UNKNOWN] A visible command with a first slice exists; "Replace background" and the layer preset not found. Source: Checked.
77. **UX-TIME-01..04 job timer:** [UNKNOWN] Timer service and edit command exist; the floating timer defaults off; admin summary not traced. Source: Checked.
78. **UX-CHK-01..03 checklist (CECHECKLIST):** [WORKS-INSTALLED] Visible. Auto-ticking from proof not traced. Drafts #1605, 1606 not on a line. Source: Checked.
79. **XCLMTXT and Excel schedule import:** [NEEDS-FIXING] BUG-974 (XCLMTXT then C2). The command is on the ribbon. Source: Checked + carried.
80. **Hatches, text, line styles and the legacy utilities (about 170 buttons):** [WORKS-INSTALLED] Reachable. Hatch passed in 1.0.72 (BUG-087). Source: Checked + carried.
81. **Structural Settings page (CESETTINGS):** [UNKNOWN] Present; HUNT-MI-04 (Reset Defaults wipes all Structural settings) I could not confirm fixed. Source: Checked + carried.
82. **Structural rests in a Civil drawing (CSWAKE, discipline gate):** [WORKS-INSTALLED] Code present. Source: Checked.
83. **S-46 candidate contents:** [CANDIDATE-ONLY] BUG-497 and 498 (schedule rows), BUG-1275 (SBEAM stale id no longer crashes), BUG-1276 (unsaved-work reminder), B-219 SBEAM log lines. Built, not installed. Source: Checked.
84. **Structural drafts not in S-46:** [NOT-BUILT] About 32 open draft PRs sit on top of 1.0.125 (the nearest: #1981, #1986, #1988). None is in any build. Source: Carried.

## G. MANAGER (install, update, settings transfer, admin)

85. **CEMANAGER window and one-glance status (UX-MGR-01..04):** [WORKS-INSTALLED] Window, status service and menus are in the code. 20 of 21 CEMANAGER bugs still read OPEN (BUG-839, 843 to 849, 851 and others); I did not re-check each. Source: Checked + carried.
86. **Install route (installer, signed release gate):** [UNKNOWN] The two 19 Oct blockers (the extra receipt file, the .dbx file type) are fixed in the code I read. No end-to-end colleague install is recorded. Source: Checked + carried.
87. **Update route (stage, finish at next start, picked people first):** [UNKNOWN] Code for all three is present (staging, finish-update planner, staged rollout). HUNT-MI-07 to 10 (admin takeover, pair split) status not re-checked. Source: Checked + carried.
88. **Roll back (UX-MGR, colleague rollback with notice):** [INSTALLED-BUT-OFF] The button is admin-only and hidden until the switch file says showRollBack. The plan wants colleagues to have it. Source: Checked.
89. **Admin dashboard and Updates & Rollback (CEMANAGERADMIN, CEMANAGERUPDATES):** [NEEDS-FIXING] BUG-1247 (Tim, 29 Oct: an ordinary user lands on the admin dashboard with blank numbers), BUG-843 to 845. Source: Checked + carried.
90. **Report a problem and support zip (CESUPPORT, feedback dialog, UX-MGR-11..13):** [NEEDS-FIXING] BUG-482, 489 (privacy cleaner), 847, 1261. "Send to Claude chat" is not in the code. Source: Checked + carried.
91. **Move My Settings (M-SET-01):** [NOT-BUILT] No settings import or export in the installed line. Drafts #424/#425 are unmerged. Source: Checked + carried.
92. **CE Blocks palette (CEBLOCKS, CEBLOCKINSERT):** [NEEDS-FIXING] BUG-1243 (Tim, 29 Oct: "still doesnt work how i wanted it to"), BUG-1047, BUG-188. Source: Checked + carried.
93. **About CE Suite (CE_VERSION):** [NEEDS-FIXING] BUG-090, 913, 919, 1086, 1087. Source: Checked + carried.
94. **Health check (CEHEALTH):** [NEEDS-FIXING] BUG-484 (says all passed without checking the pair), BUG-946. Source: Checked + carried.
95. **Settings pages inside Manager (Civil settings, Reset Civil):** [NEEDS-FIXING] BUG-839; HUNT-MI-08 (Reset Civil resets hidden values) not re-checked. Source: Checked + carried.
96. **Admin policy and analytics (who is on what, Tim the only administrator):** [WORKS-INSTALLED] Services present. BUG-849, 843 open. Source: Checked.
97. **CE_SHARED identical copy check (Civil and Manager must ship the same):** [WORKS-INSTALLED] A copy-check service is in Manager. Source: Checked.
98. **Hours to CE Project Manager, own time plus admin summary (UX-TIME-02):** [UNKNOWN] Not traced. Source: Checked.

## H. SHARED (ribbon, Settings, AI, messages)

99. **One CE tab, Pipe/Pit contextual tab (UX-RIBBON-01):** [WORKS-INSTALLED] Code present. Tim passed it by hand (29 Oct, H18). Structural still adds its flat list. Source: Checked + carried.
100. **UX-RIBBON-05..07 look, large buttons, button-use counts:** [UNKNOWN] Not traced. Use counts are listed as later work. Source: Checked + carried.
101. **Settings search box (UX-SET):** [WORKS-INSTALLED] Search is in the Advanced Settings dialog code. Source: Checked.
102. **UX-SET per-value history, gold "This job" tag:** [NOT-BUILT] Nothing found. Source: Checked.
103. **Ask CE (CEASK palette, shared AI client, cloud worker):** [WORKS-INSTALLED] The palette, ribbon button and Anthropic client are in the code. Whether it answers depends on a key and proxy I did not check. Selection chips and "Draw these" are not found. Source: Checked.
104. **Markup AI in Structural:** [INSTALLED-BUT-OFF] Chat, QA and sending pages all default false. Source: Checked.
105. **CE bell on the status bar (messages):** [WORKS-INSTALLED] Service present. Source: Checked.
106. **Start Here tour, What's New, F1 help (UX-HELP-02..05):** [WORKS-INSTALLED] Present in code. Help clips (06 to 09) not found. Source: Checked.
107. **Failure window and Send to admin (UX-FAIL-01):** [NOT-BUILT] Nothing found; the feedback dialog exists. Source: Checked.
108. **Splash while AutoCAD loads (UX-START-01):** [NOT-BUILT] Nothing found. Source: Checked.
109. **Plain Undo names (UX-UNDO-01):** [UNKNOWN] Tim passed the pit half by hand; I found no code by my search patterns. Source: Checked + carried.
110. **One host, one bundle (CE.Host):** [NOT-BUILT] The project exists but the three suites still load separately by design (hard rule: no big-bang merge). Source: Checked.

---

## Counts

1. **WORKS-INSTALLED:** 38 of 110.
2. **NEEDS-FIXING:** 25 of 110.
3. **INSTALLED-BUT-OFF:** 18 of 110.
4. **ENGINE-ONLY:** 1 of 110.
5. **CANDIDATE-ONLY:** 1 of 110.
6. **NOT-BUILT:** 14 of 110.
7. **UNKNOWN:** 13 of 110.
8. **Checked by me in code:** 71 of 110. **Carried only:** 1 of 110. **Both:** 38 of 110.
9. **Not counted in these lines:** the Civil items, and the plan numbers listed in the last section.

## Commands with no ribbon button (Structural)

1. **Total commands:** 377 per the brief. My literal count of names in the code is 378 (some are declared through constants, so my count is approximate). Registry file: 375 rows, 312 visible and 63 hidden.
2. **On the ribbon through the registry:** 298 of the commands I found.
3. **No ribbon button of their own: 79.** 51 are hidden in the registry and 28 are not in it at all.
4. **Explained by design (58):** 29 CS* roof-down commands and 5 more tied to plan items (CEMEMBER, CEMARKUPCHECK, BEAMLINKDEBUG, BEAMLINKMIGRATE, STRUCDEBUG); 20 typed short names of ribbon commands (LM, LMU, SM, SECTION, MLL, MLR, RBL, RBC, RD, STR and others); 4 short forms (NGL, RL, SSL, CE_FFL).
5. **No button and no plan item of their own: 21.** 17 hidden legacy detail commands (ANGLES, BASEDET, BOLTS, BRACE, GUSSETS, KNEE, PORTAL, PURLINS, RIDGE, STLCONN, TRUSS, COLTIES, LIGS, WALLREO, WALLSTRS, BSSLAB, EXCELMTEXTNEW) and 4 variants (?CE, CEBLOCKS, CEPROJECTPROPS, CESHEETSMANAGER).
6. **Caveat:** this is from the registry file, not from the running ribbon.

## What I did not check

1. **Nothing was run.** No AutoCAD, no robot, no Codex, no build, no test. "Works" is never claimed from this audit.
2. **Tim's live settings file.** The OFF items are OFF by code default. His own settings may switch some on. Not read.
3. **Open bug text.** I did not read every carpark entry. Entries that read OPEN may already be fixed in code, and some marked fixed may not be. I named bugs only where I could see the symptom is still plausible.
4. **The 32 Structural drafts.** Their status is carried from `STRUCTURAL_DRAFTS_STATUS_05NOV.md`.
5. **Ribbon button creation.** I read the registry and the ribbon builder logic, not the drawn ribbon.
6. **Items 29, 30, 40, 67, 70, 76, 77, 81, 86, 87, 98, 100, 109** are UNKNOWN because I ran out of budget or the code path was not clear.
7. **The Civil items** (CDDESIGN, pipes, pits, Civil settings values) are covered by another audit.
8. **Which build is on your PC.** BUG-1274 says Civil 3.0.90; the authority says 3.0.89. I read no installed DLL.
9. **UX-FRM-02, 03, 07, 09, 10, UX-SSCHED-01, 04, 06 to 13, UX-REV, UX-STDS, UX-JOB-01..06 sharing between Civil and Structural, UX-XREF, UX-XDISC, UX-DWG, UX-ACC, UX-VOICE, UX-LIVE** were not given their own lines.
