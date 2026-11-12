# V3 audit, CIVIL: what is built, not built, needs building, needs fixing (Fri 6 Nov 2026)

Read-only audit. Nothing built, run, installed or opened in AutoCAD. Code checked: commit cf059dcf (Civil 3.0.90), Modules/Drainage and Shared. I confirmed that is the installed DLL (product version 3.0.90+cf059dcf read from the bundle). Candidate: a6809594 (C-80, 3.0.93). Note: the 5 Nov CE_PLAN notes still say 3.0.89 is installed; the PC now shows 3.0.90, so they are one step stale.

## FOR TIM

1. **Answer:** of 111 Civil items, 47 work (installed, reachable, on), 8 are installed but off, 7 are engine-only, 4 are only in the next build, 19 are not built, 19 are reachable but have an open bug, and 7 I could not settle.
2. **Totals:** WORKS-INSTALLED 47 of 111. INSTALLED-BUT-OFF 8 of 111. ENGINE-ONLY 7 of 111. CANDIDATE-ONLY 4 of 111. NOT-BUILT 19 of 111. NEEDS-FIXING 19 of 111. UNKNOWN 7 of 111.
3. **How sure:** 59 of 111 checked by me in the code, 24 of 111 part checked and part carried from older documents, 28 of 111 carried only. 'Works' means installed and reachable, not proven in AutoCAD.
4. **Count:** the plan counts 212 Civil items. The full item list is not in one file, so I grouped them into 111 lines using the job-order plan and the daily-tool list. A line can stand for several plan items.
5. **Ten worst gaps for a drafter on a real job:** listed just below.
6. **Surprise:** the OSD criteria block is now wired to CDCALC, and the Checks palette and Tidy labels are installed. The 17 Oct audit said none were reachable.
7. **Biggest hidden risk:** many finished features are installed but switched off, so a colleague will never see them.
8. **Nothing here is Tim-accepted.** Hand checks of 29 Oct are noted where they exist.

### The 10 most damaging gaps

1. **Pit Schedule Excel export fails in AutoCAD 2027** (BUG-1255, marked PILOT-BLOCKER). No fix found in the code.
2. **Pit Schedule leaves plastic pits out with no message** (BUG-1274). The fix exists only in the next build, and about 16 other schedule bugs are open.
3. **No 'Set up C01 and C02'.** Legend, notes, LPD note, details and sheet set-up are still by hand. There is no New sheet command.
4. **No Civil issue.** No register, no check plot, no council pack, no revision clouds.
5. **Survey import is shaky.** LandXML levels come in blank with no preview (BUG-602 to 605); X-Civil has BUG-417 and the PDF fix is next-build only.
6. **Whole design jobs are missing:** detention pit command, outfall run and its schedule, pump station, buffer strip, overland flow. Existing and demolished layers (D25) are not built either.
7. **Data-loss bugs still open:** cancelling CDFW clears stored pit inverts (BUG-650, HIGH); the Civil unsaved-work reminder is next-build only.
8. **Daily-use faults:** no recent-level buttons on New Pipe (BUG-1226/1238), CDRENUMBER stops with no help when there is no outlet pipe (BUG-1237), FO symbol reads OF (BUG-1236), Inspector shows too-flat pipes amber (BUG-1094).
9. **Finished but switched off:** hand-placed labels stay, join pipe ends, double-click Edit, natural pit order, Esc label, [Undo] prompts, tidy options. A new user sees none of them.
10. **Level 3 is not usable:** levels proposal, soakage and the council RFI reader are engines with no way for a drafter to reach them.

## ITEM LIST

Status words: WORKS-INSTALLED, INSTALLED-BUT-OFF, ENGINE-ONLY, CANDIDATE-ONLY, NOT-BUILT, NEEDS-FIXING, UNKNOWN. The words in brackets say what I did.

### 1. SET UP THE JOB

1. **WORKS-INSTALLED** New job drawing (CDNEWDWG): command and A1/A3 dialog files exist; no ribbon button found, typed only (CHECKED IN CODE)
2. **WORKS-INSTALLED** Job set-up (CDDESIGN, CDSETUP) with job mode per discipline: ribbon button 'Design setup'; job-mode code in the window (UX-DES-01, UX-MODE-01..04, merged since 17 Oct) (CHECKED IN CODE)
3. **WORKS-INSTALLED** Council profiles, 22 of them, chosen at set-up: 22 profiles in council-profiles.json, incl. a Generic Default (CHECKED IN CODE)
4. **WORKS-INSTALLED** Council rulebook values on the Settings page (R-00): Settings window and council data installed; 284 values are marked Assumed (no council source) (PART CHECKED, PART CARRIED)
5. **WORKS-INSTALLED** Land-use field (30 Sep ruling): field exists in the job record; that CDCALC reads it was not checked (PART CHECKED, PART CARRIED)
6. **WORKS-INSTALLED** Colleague starting settings (F-023): file installed; applies only on a PC with no settings file yet; draft awaiting Tim's answer (CHECKED IN CODE)
7. **WORKS-INSTALLED** Job timer (UX-TIME): JobTime code installed; whether it reaches the Project Manager not checked (PART CHECKED, PART CARRIED)
8. **WORKS-INSTALLED** Help, Start Here tour, Ask CE (CDHELP, CESTARTHERE, CEASK): commands and ribbon buttons exist (CHECKED IN CODE)
9. **NEEDS-FIXING** Help wording points at Tim's own folders (BUG-1175): OPEN in carpark; fix is in the next builds (b2, C-79c) per the 5 Nov count, not in the installed one (CARRIED)
10. **ENGINE-ONLY** 'Not in the engineer's markup' check (UX-DES-01): NotInMarkupChecker is only called by tests (CHECKED IN CODE)
11. **NOT-BUILT** Council discharge-enquiry writer (UX-CR-01): no command found in the command list (CHECKED IN CODE)
12. **NOT-BUILT** New job title-block fill from the job record (UX-TITLEBLOCK-NEWJOB, UX-JOB-02): card questions waiting on Tim (CARRIED)
13. **UNKNOWN** Known drawing opens straight on its job (UX-STD-07): not checked (CARRIED)
14. **CANDIDATE-ONLY** Civil OFF per drawing, older-project question and one Upgrade button: only in a6809594; CDUPGRADEDRAWING is the new command (CHECKED IN CODE)

### 2. BACKGROUNDS AND SURVEY

15. **NEEDS-FIXING** Import survey (CDSURVEY) and LandXML (CDIMPORTLANDXML): reachable from the ribbon; BUG-602, 603, 604, 605 open (levels blank, no preview); BUG-605 fix installed but unproven (PART CHECKED, PART CARRIED)
16. **NEEDS-FIXING** Import X-Civil (CDIMPORTXCIVIL): reachable; BUG-417 open (locked layer, needs Tim's ruling); the all-pages PDF fix (BUG-900) is candidate-only (PART CHECKED, PART CARRIED)
17. **WORKS-INSTALLED** Compare import (CDIMPORTCOMPARE), compare only: ribbon button; compare-only is by design (CHECKED IN CODE)
18. **NEEDS-FIXING** Check consultant DWG (CDCHECKDWG): reachable; BUG-606 open (report written beside the source drawing); D28 needs a Codex look (PART CHECKED, PART CARRIED)
19. **WORKS-INSTALLED** Spot level (CDSL) shows survey level, you type proposed: ribbon; typed-level half passed by robot, stored-survey half never tested (PART CHECKED, PART CARRIED)
20. **WORKS-INSTALLED** Background compare and repair (CDXREFCOMPARE, CDXREFREPAIR): commands exist; no ribbon button found, typed only (CHECKED IN CODE)
21. **WORKS-INSTALLED** Tree zones (CDTPZ) and root zones (CDSRZ): ribbon flyout (CHECKED IN CODE)
22. **WORKS-INSTALLED** Import existing slab (CDSLABIMPORT): ribbon flyout (CHECKED IN CODE)
23. **NOT-BUILT** Existing greyed and demolished dashed on separate layers (D25, UX-LYR-04): pit record has a status field but nothing sets it; no demolish layer or TO BE REMOVED text found (CHECKED IN CODE)
24. **NOT-BUILT** Existing services labelled 'Ex. SEWER DRAIN' (ExistingItemStyleRule): class does not exist in the installed code or the candidate (CHECKED IN CODE)
25. **NOT-BUILT** Footing plan reader and footing zone-of-influence check: neither class exists in the code (CHECKED IN CODE)
26. **NOT-BUILT** Arborist report reader (UX-SITE-01): nothing found (CHECKED IN CODE)
27. **NOT-BUILT** Assumed datum and fall when there is no survey (UX-RL-04): no code found by name (CHECKED IN CODE)
28. **NOT-BUILT** Background 'what moved' review and Replace background (UX-ARCH-01..03): named NOT BUILT in the 17 Oct gap audit (CARRIED)
29. **UNKNOWN** Pit levels filled from survey with a 'Survey' tag (UX-SURV-01, UX-RL-01..03): not checked (CARRIED)

### 3. DRAW

30. **WORKS-INSTALLED** Place a pit (PIT) and keep placing until Esc: Tim passed this by hand 29 Oct; robot passed (PART CHECKED, PART CARRIED)
31. **WORKS-INSTALLED** Preset pit sizes (CDPIT350 to CDPIT1200) and Quick Plastic Pit (PP): commands and ribbon entries exist (CHECKED IN CODE)
32. **NEEDS-FIXING** Draw a pipe (CD) and keep placing until Esc: Tim passed by hand 29 Oct; BUG-1226/1238 open: no recent-level buttons on the one-page New Pipe window; BUG-1228 DP/CD slow (PART CHECKED, PART CARRIED)
33. **WORKS-INSTALLED** Pipe joins a pit; pit catches a pipe end within reach (UX-PIT-02): robot passed twice, Tim passed 90 mm caught and 110 mm free (CARRIED)
34. **INSTALLED-BUT-OFF** Join a new pipe end to another pipe end (UX-PIPE-02b): autoJoinPipeEnds is false in code (CHECKED IN CODE)
35. **WORKS-INSTALLED** Esc at the third point draws nothing (UX-PIPE-03): robot passed; the Enter half was not accepted (CARRIED)
36. **WORKS-INSTALLED** One-piece pipe object (CDPIPEOBJ, CDC7UPGRADE, pipeObjectUpgrade On): colleague default is On (CHECKED IN CODE)
37. **WORKS-INSTALLED** Branch junction (CDBREAK, CD-BRANCH-01): ribbon layout lists it (CHECKED IN CODE)
38. **WORKS-INSTALLED** Downpipe, inspection opening, overflow (DP, IO, OF): ribbon; Tim accepted D08 (OF and FO share one symbol) (PART CHECKED, PART CARRIED)
39. **NEEDS-FIXING** Front overflow (FO): reachable; BUG-1236: symbol text reads OF, not FO (CARRIED)
40. **NEEDS-FIXING** Floor waste (CDFW): reachable; BUG-650 HIGH: cancelling clears stored pit inverts; BUG-647 refusal wording (CARRIED)
41. **NEEDS-FIXING** Strip drain (CDSTRIP): reachable; BUG-647 stays loose geometry, MOVE strands children (CARRIED)
42. **NEEDS-FIXING** AGI drain (CDAGI): reachable; BUG-649 rising AGI passes the grade check; BUG-648 grade never labelled (CARRIED)
43. **WORKS-INSTALLED** Trench grate (CDTG), GIO block, generic source (CDSOURCE), source tag (CDTAG): ribbon (CHECKED IN CODE)
44. **WORKS-INSTALLED** Raingarden (CDRG) placed before pipes: ribbon; RG1 name label is a setting (UX-SRC-03); whether it is on by default not read (PART CHECKED, PART CARRIED)
45. **WORKS-INSTALLED** Water tank (CDWT): ribbon; tank library installed; the tank dialog is the Codex-built window (CHECKED IN CODE)
46. **WORKS-INSTALLED** Slab and fall tools (CDSLAB, CDFALL, CDFALLSUGGEST, CDSPOON, CDSPOONDRAIN, CDPAVE, CDKERB, CDJOINT, CDCJ, CDSC): ribbon flyouts (CHECKED IN CODE)
47. **NEEDS-FIXING** Catchment overlay (CDCATCHMENT): ribbon; BUG-643 (arcs ignored) fix installed, unproven (PART CHECKED, PART CARRIED)
48. **WORKS-INSTALLED** Legal point of discharge (CDLPD): ribbon; CDLPDRESET typed (CHECKED IN CODE)
49. **WORKS-INSTALLED** Label every pit with number and CL (D09): robot and Codex accepted (CARRIED)
50. **WORKS-INSTALLED** One IL text at each pipe end (D12): robot accepted (CARRIED)
51. **NEEDS-FIXING** Mid-pipe label wording and direction (D10): reachable; text angle never judged by Codex (CARRIED)
52. **WORKS-INSTALLED** Short-pipe label on a leader (D11): robot plus Codex passed (CARRIED)
53. **NOT-BUILT** Detention pit command (CDPITDETENTION): absent from installed and candidate (CHECKED IN CODE)
54. **NOT-BUILT** Outfall drain run and its own schedule (UX-CPLAN-33/34): OutfallRunPlanner does not exist in the code (CHECKED IN CODE)
55. **NOT-BUILT** Buffer strip tool (UX-WSUD-03): no command (CHECKED IN CODE)
56. **NOT-BUILT** Pump Station tool (UX-SPS-01..04): no CDPUMP command; only older pump calculators exist (CHECKED IN CODE)
57. **NOT-BUILT** Overland flow route (UX-OLF-01..04): no code beyond mentions in design helpers (CHECKED IN CODE)
58. **UNKNOWN** Detect architect's downpipes (UX-DP-01) and roof split (UX-DP-03): not checked (CARRIED)
59. **UNKNOWN** Level text (RL, FFL, CL, TWL) that follows its object: not checked (CARRIED)

### 4. EDIT

60. **WORKS-INSTALLED** Edit pipe or pit (CDEDIT, PIPEEDIT, PITEDIT) one-page windows: one-page layouts installed; BUG-173 still in progress; BUG-574/290 fixes installed, unproven (PART CHECKED, PART CARRIED)
61. **NEEDS-FIXING** Renumber pits from the outlet up (CDRENUMBER): reachable by typing only; BUG-1237: stops with no help on a network with no outlet pipe; Tim not shown the real run (PART CHECKED, PART CARRIED)
62. **WORKS-INSTALLED** ERASE, COPY, EXPLODE, MOVE, ROTATE copy of CE objects (UX-EDIT-01..04): COPYMULTI, COPYROT, MOVEROT, MR exist; Tim passed ERASE, COPY, EXPLODE by hand (PART CHECKED, PART CARRIED)
63. **NEEDS-FIXING** Tidy labels (CDTIDYLABELS): ribbon; switched ON by default; BUG-816, 896 open; sub-switches below are OFF (CHECKED IN CODE)
64. **INSTALLED-BUT-OFF** Tidy: move pit cover text, leader out, rearrange neighbours: tidyMovesPitText, tidyLeaderOut, tidyRearrangeNeighbours all false (CHECKED IN CODE)
65. **INSTALLED-BUT-OFF** Label you moved by hand stays put (UX-LBL-01): handPlacedLabelsStay false; BUG-879 also open (CE's own moves not marked) (CHECKED IN CODE)
66. **INSTALLED-BUT-OFF** Esc at a pit or plastic-pit label still places the label: pitLabelOnEsc and plasticCoverTextOnEsc false (CHECKED IN CODE)
67. **ENGINE-ONLY** ROTATE/MIRROR keeps text readable (UX-EDIT-03): rule built, the hook is not; switch false (CHECKED IN CODE)
68. **INSTALLED-BUT-OFF** Edit Pipe re-tidies labels: editPipeRetidyLabels false (CHECKED IN CODE)
69. **INSTALLED-BUT-OFF** Double-click opens Edit for the newer kinds of object: opensEditWindow false until Codex passes it; BUG-396 and BUG-859 open (CHECKED IN CODE)
70. **INSTALLED-BUT-OFF** AutoCAD-style CD prompts with [Undo]: autoCadStyleCdPrompts false (CHECKED IN CODE)
71. **WORKS-INSTALLED** Annotation edits (CDANNOTATIONEDIT, CDTEXTSEG, CDLABELSTYLE, CDUSEPLANLABEL, CDFIXTAGS, CDPITCOVERFLIP): commands exist (CHECKED IN CODE)
72. **WORKS-INSTALLED** Solve run inverts (CDRUNSOLVE), propagate (CDPROPAGATE), reverse flow (CDREVERSEFLOW): ribbon and preview dialog installed (CHECKED IN CODE)
73. **NEEDS-FIXING** Hold grade / grade-held drag: grade-held drag BUG-160 and FLAT label BUG-427 open, fixes installed but unproven; the chosen-grade memory draft was closed 4 Nov (decision 214) (CARRIED)
74. **WORKS-INSTALLED** Every CE Undo step has a plain name (UX-UNDO-01): Tim passed the PIT half, MOVE half not hand-tested (CARRIED)
75. **WORKS-INSTALLED** Contextual ribbon tabs for pipe, pit, source: three context tabs built; D30 (tab jumps forward on pick) needs a Codex look (PART CHECKED, PART CARRIED)

### 5. CHECK

76. **WORKS-INSTALLED** Project Review, Checks, Rules (CDDASHBOARD, CDCHECK, CDCHECKCURRENT, CDHUB, CDRULES, CDRULEBOOK): ribbon (CHECKED IN CODE)
77. **WORKS-INSTALLED** Checks palette (CDCHECKS) with progress line: now installed (it was not on 3.0.50) (CHECKED IN CODE)
78. **WORKS-INSTALLED** Wrong-layer finding: called from the checks result code (CHECKED IN CODE)
79. **WORKS-INSTALLED** Ignore a finding (CDCHECKIGNORE, CDCHECKIGNOREAPPLY): commands exist (CHECKED IN CODE)
80. **ENGINE-ONLY** Offer to pause a slow feature (SlowdownMonitor): class referenced only by tests (CHECKED IN CODE)
81. **ENGINE-ONLY** Council RFI reader (UX-RFI-01..03): rule and settings only, no command (CHECKED IN CODE)
82. **NOT-BUILT** Decide-later list in Repair (UX-REP-02) and footing influence check: classes do not exist (CHECKED IN CODE)
83. **NEEDS-FIXING** Inspector (CDINSPECTOR): ribbon; BUG-1094: pipe 20 percent too flat shows amber, not red (CARRIED)
84. **WORKS-INSTALLED** Repair Centre and repair commands (CDREPAIR, CDSYNC, CDREBUILD, CDREFRESHLINKS, CDRECOVERINVERTS, CDFIXPIPEENDS and the rest): commands exist; warn-first accepted for CDSYNC/CDREBUILD (D27) (PART CHECKED, PART CARRIED)
85. **WORKS-INSTALLED** Audit commands (CDAUDIT, CDTRIAGE, CDLEGACYAUDIT, CDSTARTUPAUDIT): typed commands exist (CHECKED IN CODE)
86. **WORKS-INSTALLED** Guidebook rules in CDRULES (flattest fall 1 in 100, pit size by depth, lid class, cover table, garages): settings keys and engines in the installed code; garage drawing read never run in AutoCAD; none Tim-accepted (PART CHECKED, PART CARRIED)
87. **UNKNOWN** Message bell: host exists, producer not checked (CARRIED)

### 6. SCHEDULE

88. **NEEDS-FIXING** Pit Schedule (PITSCHEDULE): ribbon; BUG-1274 leaves plastic pits out silently (fix is candidate-only); BUG-637, 586, 855, 213 open; about 16 schedule bugs open (PART CHECKED, PART CARRIED)
89. **NEEDS-FIXING** Export the Pit Schedule to Excel: BUG-1255 PILOT-BLOCKER: fails in AutoCAD 2027; no fix found in code (CARRIED)
90. **INSTALLED-BUT-OFF** Pit Schedule in natural order: pitScheduleNaturalOrder false (CHECKED IN CODE)
91. **UNKNOWN** Long schedule continues on the next sheet with headers (D22): Codex was blocked; unknown (CARRIED)
92. **NOT-BUILT** One command 'Set up C01 and C02' (legend, notes, LPD note, OSD block, details): no command; legend engine not found by name (CHECKED IN CODE)
93. **NOT-BUILT** New sheet at office scale (UX-LAY-01): no command (CHECKED IN CODE)
94. **WORKS-INSTALLED** OSD criteria block from the Detention tab (UX-CALC-02): CDCALC calls InsertCriteriaBlock (17 Oct audit said not wired; now is) (CHECKED IN CODE)
95. **ENGINE-ONLY** Long section schedule rows and crossing services (ProfileScheduleRowPreview, CrossingServiceRule): only tests call them (CHECKED IN CODE)
96. **WORKS-INSTALLED** Long section (CDPROFILE): ribbon; never Tim-accepted (PART CHECKED, PART CARRIED)
97. **UNKNOWN** Construction details and notes on C02, details library: CEBLOCKS button exists; Civil detail set not checked (CARRIED)

### 7. DESIGN

98. **NEEDS-FIXING** Calculations (CDCALC): catchments, detention, pipe flow, print: ribbon; BUG-590/591 export drops DRAFT and saves numbers as text; BUG-249 rainfall curve missing on the sheet (CARRIED)
99. **WORKS-INSTALLED** Rainfall (CDRAINFALL) and top water level (CDTWL): ribbon; BUG-777 default top-water rule switch OFF pending Tim (PART CHECKED, PART CARRIED)
100. **WORKS-INSTALLED** Pipe size proposals and writing sizes (Project Review, Proposals): proposals dialog and size-write service installed; Accept all switch not read (PART CHECKED, PART CARRIED)
101. **ENGINE-ONLY** Levels proposal (L3-LEVELS): engine has no caller; switch false (CHECKED IN CODE)
102. **WORKS-INSTALLED** Design proposals via CDDESIGN (auto-design orchestrator, detention options): chain from CDDESIGN to the orchestrator exists; results never Tim-accepted (PART CHECKED, PART CARRIED)
103. **ENGINE-ONLY** Soakage sizing: used only inside the auto-design helpers, no window (CHECKED IN CODE)
104. **NEEDS-FIXING** Storm report / Blue Factor carried with its source (BUG-1105): OPEN, nothing compares report tank with drawn reuse (CARRIED)

### 8. ISSUE

105. **NOT-BUILT** Civil issue, register, check plot, council pack (UX-REG): no Civil issue command found (CHECKED IN CODE)
106. **NOT-BUILT** Standards at issue and checklist at issue (UX-STDS-03): named NOT BUILT in the gap audit (CARRIED)
107. **NOT-BUILT** Revision clouds for Civil: not built per gap audit (CARRIED)
108. **WORKS-INSTALLED** Send feedback (CDFEEDBACK): ribbon; Send never pressed, needs Tim's yes (D29) (PART CHECKED, PART CARRIED)

### 9. PROTECTING THE DRAFTER

109. **CANDIDATE-ONLY** Not-saved reminder and timed copies of unsaved work (Civil half of BUG-1276): UnsavedWorkPlanner only in a6809594 (CHECKED IN CODE)
110. **CANDIDATE-ONLY** Pit Schedule says which pits it leaves out (BUG-1274), CDWT refuses locked layer and Xref adopt, X-Civil PDF all pages: only in a6809594 (C-80, 3.0.93) (CHECKED IN CODE)
111. **CANDIDATE-ONLY** Window positions saved safely (BUG-1208), CDREFRESHBLOCKS respects locked layers (BUG-1080): only in a6809594 (CHECKED IN CODE)

## WHAT I DID NOT CHECK

1. **Nothing was run.** No AutoCAD, no robot, no build. WORKS-INSTALLED means the code is there and reachable, not that it behaves.
2. **Switch defaults** were read only for the settings named in the list. Other switches may be on or off.
3. **Button wiring:** I confirmed commands exist and ribbon buttons are declared. I did not trace every button to its handler.
4. **Bug status** comes from the carpark text. I did not read each bug fully, and did not split the 1,057 open bugs by Civil or Structural.
5. **The 212-item plan list** was not found as one file. Items in the cards that are not in the job-order plan may be missing from my list.
6. **Look-alike names:** a class I call missing may exist under another name (legend, notes and assumed-datum engines especially).
7. **Not covered:** UX cards, Structural, Manager (other agents). Candidate 3.0.93 was compared by command list and file diff only.
