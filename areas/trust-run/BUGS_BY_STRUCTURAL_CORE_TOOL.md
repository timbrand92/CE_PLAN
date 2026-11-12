# Open bugs by Structural KEEP tool

Lane: trust-records. Date: Thu 12 Nov 2026. A derived copy, not a status. The 32 KEEP buttons come from `C:\CE_PLANreas\STRUCTURAL_COMMAND_SORT_12NOV.md` (Roof 3, Floors 19, Bracing 7, Tools 3). For each command: the open or in progress entries in `BUG_CARPARK.md` whose Command / Area line names that command as a whole word in upper case. Each title is copied from that Command / Area line, cut at 220 characters with "..." where longer. The "## BUG-<number>" heading above each hit gives the number. OPEN, IN PROGRESS and ON HOLD count as open. Copy only, nothing judged.

Not searched: the four tools named only by a digit (1, 2, 4, 5). A digit is not a usable search word, so they show no bugs here. Their bugs may be filed under other names (the log calls the beam tools BEAM); that is not checked. Duplicate names of a kept tool (for example ABSWITCH, STRUCABS) are not searched separately.

A bug that names two commands appears under both.

1. **R1** (Roof): 7 open or in progress in the carpark
    1. BUG-451: Codex W41 on the installed Structural 1.0.109 (9 Oct 05:20 to 05:45, usage 57% to 59%, DWG-S1_VC7_b.dwg copy, report CODEX_VERIFYW41_2026-10-09.md): the DAY1 "not seen" steps 14, 18, 19, 20. PASS 0, BLOCKED 5, FAIL 0,...
    2. BUG-467: HUNT-S-02 (HIGH where a rotated UCS is used): BT1, R1 (Point option) and FPFC put things in the wrong place in a rotated UCS: they write the clicked point into the drawing without turning it from the UCS to World. BT1...
    3. BUG-471: HUNT-S-06 (MEDIUM): R1, BT1, C1 and TS1 ignore metre, centimetre and inch drawings. R1 uses fixed millimetres (25 "too short", 300 depth, +200 width: Commands/RafterJoistCommands.cs 27-28, 315-319, 597): in a metre dr...
    4. BUG-472: HUNT-S-07 (MEDIUM): on a layout tab or during REFEDIT, R1, BT1, C1, TS1, BTX, FSF and FPFC still write into Model space and never check REFEDIT or the space (R1 RafterJoistCommands.cs 202; BT1 BracingService.cs 1672;...
    5. BUG-475: HUNT-S-09, 10, 12, 13, 14, 15 (LOW / docs) and causes for older bugs: (S-09) the DAY1 page was wrong about R1: it asks "Pick LEFT beam or wall", "Pick RIGHT beam or wall", "Pick TOP/near side", "Pick BOTTOM/far side"...
    6. BUG-494: AUDIT 01 section B (Structural Undo/Redo, Stage 1): in the audit's reading nothing in Structural 1.0.110 writes to the drawing between U and REDO (Idle work waits, command-end work skips U/UNDO/REDO/MREDO), but this i...
    7. BUG-584: R1 rafter-span drawing size, installedStructural1.0.116+f180b349. MEDIUM: accepted bay dimensions do not reach the placed dynamicblock, with no visible refusal or warning. FJ1 and normalP1 now reproduced; see the date...
2. **P1** (Roof): 6 open or in progress in the carpark
    1. BUG-60: `CDIMPORTXCIVIL` / `LinkService.RelinkAllPipesToPits` — self-pipe P1→P1
    2. BUG-426: C-21 Opus finalizer findings (8 Oct, TRAIN_C21_FINALIZER_REPORT.md; GO at 49034734, none blocks the install). **MEDIUM (#766):** in the Pit Schedule window type 9 in P1's pit-number cell, then type p1 (lower case of t...
    3. BUG-430: CODEX W20 on installed Civil 3.0.35 / Manager 1.1.35 (8 Oct 05:20, CODEX_VERIFYW20_2026-10-08.md; usage 27 -> 28%). **(1) Double-click on a CE pit label opens AutoCAD's own 'Enhanced Attribute Editor' (block PIT LABEL...
    4. BUG-445: CODEX W35 on installed Civil 3.0.38 / Manager 1.1.38 (8 Oct 13:37, CODEX_VERIFYW35_2026-10-08.md; usage 45 -> 47%): **the rebuilt #805 marker WORKS and its single U/12 s/REDO PASSES.** Route (from build/04's W35_ROUTE...
    5. BUG-503: LOW findings from the second Structural bug hunt, grouped (HUNT2-S-09 to HUNT2-S-15; each is small, none seen in AutoCAD). (1) HUNT2-S-09 MEDIUM-LOW, Services/ScheduleService.cs 350-364 and 396-409: the STRSCHEDCREATE...
    6. BUG-585: P1 purlin lateEscape, installedStructural1.0.116+f180b349. MEDIUM: cancelling the lapquestion stillcommits a new purlin.
3. **BT1** (Roof): 10 open or in progress in the carpark
    1. BUG-434: CODEX W21 on installed Structural 1.0.105 (8 Oct 07:01, CODEX_VERIFYW21_2026-10-08.md; usage 29 -> 30%; PASS 1 / BLOCKED 2 by a brief fault, no product failure). **(1) MEDIUM to confirm (C1 / TS1 leave the current lay...
    2. BUG-451: Codex W41 on the installed Structural 1.0.109 (9 Oct 05:20 to 05:45, usage 57% to 59%, DWG-S1_VC7_b.dwg copy, report CODEX_VERIFYW41_2026-10-09.md): the DAY1 "not seen" steps 14, 18, 19, 20. PASS 0, BLOCKED 5, FAIL 0,...
    3. BUG-467: HUNT-S-02 (HIGH where a rotated UCS is used): BT1, R1 (Point option) and FPFC put things in the wrong place in a rotated UCS: they write the clicked point into the drawing without turning it from the UCS to World. BT1...
    4. BUG-471: HUNT-S-06 (MEDIUM): R1, BT1, C1 and TS1 ignore metre, centimetre and inch drawings. R1 uses fixed millimetres (25 "too short", 300 depth, +200 width: Commands/RafterJoistCommands.cs 27-28, 315-319, 597): in a metre dr...
    5. BUG-472: HUNT-S-07 (MEDIUM): on a layout tab or during REFEDIT, R1, BT1, C1, TS1, BTX, FSF and FPFC still write into Model space and never check REFEDIT or the space (R1 RafterJoistCommands.cs 202; BT1 BracingService.cs 1672;...
    6. BUG-473: HUNT-S-08 (MEDIUM, symptom "I think"): locked layers: BT1, C1, TS1 and BTX have no locked-layer check. CSREOBAR uses CE's shared check and plain line (LayerService.cs 219-236; ReoBarService.cs 150-155); BT1, C1, TS1 a...
    7. BUG-475: HUNT-S-09, 10, 12, 13, 14, 15 (LOW / docs) and causes for older bugs: (S-09) the DAY1 page was wrong about R1: it asks "Pick LEFT beam or wall", "Pick RIGHT beam or wall", "Pick TOP/near side", "Pick BOTTOM/far side"...
    8. BUG-494: AUDIT 01 section B (Structural Undo/Redo, Stage 1): in the audit's reading nothing in Structural 1.0.110 writes to the drawing between U and REDO (Idle work waits, command-end work skips U/UNDO/REDO/MREDO), but this i...
    9. BUG-499: HUNT2-S-05 (MEDIUM-HIGH): the bracing panel (CSBRACINGPANEL) adds roof bracing trusses placed with BT1 to the WALL bracing totals. What the drafter sees: two 4 m roof trusses add 8 m to the wall bracing 'provided'; a...
    10. BUG-535: WINDOW ROWS FOR CODEX: R00_STRUC items 4, 30, 31, 32, 33 and 38 (MEDIUM; six values already named in CS_Settings.json that have NO box on the CESETTINGS window, so a drafter can only change them by editing the file)....
4. **1** (Floors): not searched, a digit name (see the note above)
5. **2** (Floors): not searched, a digit name (see the note above)
6. **4** (Floors): not searched, a digit name (see the note above)
7. **5** (Floors): not searched, a digit name (see the note above)
8. **BDL** (Floors): 0 open or in progress in the carpark
    No open entry names this command.
9. **BSET** (Floors): 1 open or in progress in the carpark
    1. BUG-1077: BSET ribbon tooltip and CEHELP entry, Structural 1.0.122 (Codex audit RD11-06, 23 Oct 2026). MEDIUM, SURE (verified by reading).
10. **BSETLIST** (Floors): 0 open or in progress in the carpark
    No open entry names this command.
11. **BSETRESET** (Floors): 0 open or in progress in the carpark
    No open entry names this command.
12. **DS** (Floors): 5 open or in progress in the carpark
    1. BUG-439: S-24 Opus finalizer findings (8 Oct, TRAIN_S24_FINALIZER_REPORT.md; GO at 37a99f27; no HIGH). **Two MEDIUMs, both FIXED in the finalizer's one commit 37a99f27:** (1) #793 FADOPT 'Width in mm <300>:' showed '<300>' twi...
    2. BUG-440: CODEX W29 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.107 (8 Oct 10:10, CODEX_VERIFYW29_2026-10-08.md; usage 38 -> 39%; PASS 3 / FAIL 1 by the brief's settings rule). **BUG-061 (W26-26 copy) RESULT: (1...
    3. BUG-532: R00_STRUC items 28 and 29 (MEDIUM; layer names written into the code, and four objects drawn on two different layer names). What the drafter sees: the same kind of object lands on a different layer depending on which...
    4. BUG-537: R00_STRUC items 6, 8, 9, 10, 11, 12, 13, 17, 22, 35, 36, 37 and 41 to 65 (LOW-MEDIUM; the remaining ranked values, grouped; each named with file:line, all under Modules/Structural; none seen in AutoCAD; items already...
    5. BUG-1139: C1 / C2 / DS support placement, Structural 1.0.122 (T4-05). MEDIUM, SURE (label movement UNSURE).
13. **DS1** (Floors): 2 open or in progress in the carpark
    1. BUG-468: HUNT-S-03 (MEDIUM, roof-down order UX-STRUC-13): columns placed with beam linking OFF are invisible to the level-below tools. The only place CE looks for posts coming down is the beam-to-support links (Services/Founda...
    2. BUG-537: R00_STRUC items 6, 8, 9, 10, 11, 12, 13, 17, 22, 35, 36, 37 and 41 to 65 (LOW-MEDIUM; the remaining ranked values, grouped; each named with file:line, all under Modules/Structural; none seen in AutoCAD; items already...
14. **TS1** (Floors): 11 open or in progress in the carpark
    1. BUG-434: CODEX W21 on installed Structural 1.0.105 (8 Oct 07:01, CODEX_VERIFYW21_2026-10-08.md; usage 29 -> 30%; PASS 1 / BLOCKED 2 by a brief fault, no product failure). **(1) MEDIUM to confirm (C1 / TS1 leave the current lay...
    2. BUG-435: CODEX W24 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 07:28, CODEX_VERIFYW24_2026-10-08.md; usage 31 -> 32%; PASS 1 / BLOCKED 2 by a brief fault). **(1) MEDIUM to confirm (start-up messages...
    3. BUG-437: CODEX W26 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 08:08, CODEX_VERIFYW26_2026-10-08.md; usage 33 -> 34%; PASS 1 / FAIL 1 / BLOCKED 2). **(1) MEDIUM (C1 and TS1, Structural support placem...
    4. BUG-439: S-24 Opus finalizer findings (8 Oct, TRAIN_S24_FINALIZER_REPORT.md; GO at 37a99f27; no HIGH). **Two MEDIUMs, both FIXED in the finalizer's one commit 37a99f27:** (1) #793 FADOPT 'Width in mm <300>:' showed '<300>' twi...
    5. BUG-468: HUNT-S-03 (MEDIUM, roof-down order UX-STRUC-13): columns placed with beam linking OFF are invisible to the level-below tools. The only place CE looks for posts coming down is the beam-to-support links (Services/Founda...
    6. BUG-471: HUNT-S-06 (MEDIUM): R1, BT1, C1 and TS1 ignore metre, centimetre and inch drawings. R1 uses fixed millimetres (25 "too short", 300 depth, +200 width: Commands/RafterJoistCommands.cs 27-28, 315-319, 597): in a metre dr...
    7. BUG-472: HUNT-S-07 (MEDIUM): on a layout tab or during REFEDIT, R1, BT1, C1, TS1, BTX, FSF and FPFC still write into Model space and never check REFEDIT or the space (R1 RafterJoistCommands.cs 202; BT1 BracingService.cs 1672;...
    8. BUG-473: HUNT-S-08 (MEDIUM, symptom "I think"): locked layers: BT1, C1, TS1 and BTX have no locked-layer check. CSREOBAR uses CE's shared check and plain line (LayerService.cs 219-236; ReoBarService.cs 150-155); BT1, C1, TS1 a...
    9. BUG-494: AUDIT 01 section B (Structural Undo/Redo, Stage 1): in the audit's reading nothing in Structural 1.0.110 writes to the drawing between U and REDO (Idle work waits, command-end work skips U/UNDO/REDO/MREDO), but this i...
    10. BUG-537: R00_STRUC items 6, 8, 9, 10, 11, 12, 13, 17, 22, 35, 36, 37 and 41 to 65 (LOW-MEDIUM; the remaining ranked values, grouped; each named with file:line, all under Modules/Structural; none seen in AutoCAD; items already...
    11. BUG-548: S-29 Opus finalizer findings (9 Oct, TRAIN_S29_FINALIZER_REPORT.md; GO at 68ace978 = the head the assembler pushed; the finalizer made NO commit; nothing HIGH, one MEDIUM, seven LOWs). The train carries #848 #854 #846...
15. **C1** (Floors): 27 open or in progress in the carpark
    1. BUG-211: ERASE a Structural column that has a beam attached (Structural 1.0.86, C1 toolbar column + Beam ribbon command `1`).
    2. BUG-214: CEFIND (Civil), and a drawing marked "changed" with no edit (Civil 3.0.15 / Manager 1.1.15, sweep C1).
    3. BUG-224: AutoCAD itself closing a drawing right after "Save As", on the installed build (Civil 3.0.15+a6e0cc87, Manager 1.1.15+a6e0cc87, Structural 1.0.86+532f9550 all loaded). Found by Codex sweep C1, 30 Sep 2026 07:53-07:55...
    4. BUG-434: CODEX W21 on installed Structural 1.0.105 (8 Oct 07:01, CODEX_VERIFYW21_2026-10-08.md; usage 29 -> 30%; PASS 1 / BLOCKED 2 by a brief fault, no product failure). **(1) MEDIUM to confirm (C1 / TS1 leave the current lay...
    5. BUG-435: CODEX W24 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 07:28, CODEX_VERIFYW24_2026-10-08.md; usage 31 -> 32%; PASS 1 / BLOCKED 2 by a brief fault). **(1) MEDIUM to confirm (start-up messages...
    6. BUG-437: CODEX W26 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 08:08, CODEX_VERIFYW26_2026-10-08.md; usage 33 -> 34%; PASS 1 / FAIL 1 / BLOCKED 2). **(1) MEDIUM (C1 and TS1, Structural support placem...
    7. BUG-438: CODEX W28 on installed Structural 1.0.106 (8 Oct 08:57, CODEX_VERIFYW28_2026-10-08_0837.md; usage 36 -> 37%; PASS 1 / FAIL 1 / BLOCKED 1). **(1) MEDIUM (C1, Structural column + support text):** with the support-text p...
    8. BUG-439: S-24 Opus finalizer findings (8 Oct, TRAIN_S24_FINALIZER_REPORT.md; GO at 37a99f27; no HIGH). **Two MEDIUMs, both FIXED in the finalizer's one commit 37a99f27:** (1) #793 FADOPT 'Width in mm <300>:' showed '<300>' twi...
    9. BUG-448: S-26 Opus finalizer findings (9 Oct, TRAIN_S26_FINALIZER_REPORT.md): **the train as assembled (35f4e152) was NO-GO: PR #815 misread the cause of BUG-438 and would NOT have fixed the column label; the finalizer's commi...
    10. BUG-453: Codex W43 on the installed Structural 1.0.110+9babe787 (9 Oct 05:57 to 06:15, usage 59% to 60%, report CODEX_VERIFYW43_2026-10-09.md): PASS 4, FAIL 1. **(1) PASS, the new wording:** C1, bare Enter at the text question...
    11. BUG-467: HUNT-S-02 (HIGH where a rotated UCS is used): BT1, R1 (Point option) and FPFC put things in the wrong place in a rotated UCS: they write the clicked point into the drawing without turning it from the UCS to World. BT1...
    12. BUG-468: HUNT-S-03 (MEDIUM, roof-down order UX-STRUC-13): columns placed with beam linking OFF are invisible to the level-below tools. The only place CE looks for posts coming down is the beam-to-support links (Services/Founda...
    13. BUG-471: HUNT-S-06 (MEDIUM): R1, BT1, C1 and TS1 ignore metre, centimetre and inch drawings. R1 uses fixed millimetres (25 "too short", 300 depth, +200 width: Commands/RafterJoistCommands.cs 27-28, 315-319, 597): in a metre dr...
    14. BUG-472: HUNT-S-07 (MEDIUM): on a layout tab or during REFEDIT, R1, BT1, C1, TS1, BTX, FSF and FPFC still write into Model space and never check REFEDIT or the space (R1 RafterJoistCommands.cs 202; BT1 BracingService.cs 1672;...
    15. BUG-473: HUNT-S-08 (MEDIUM, symptom "I think"): locked layers: BT1, C1, TS1 and BTX have no locked-layer check. CSREOBAR uses CE's shared check and plain line (LayerService.cs 219-236; ReoBarService.cs 150-155); BT1, C1, TS1 a...
    16. BUG-475: HUNT-S-09, 10, 12, 13, 14, 15 (LOW / docs) and causes for older bugs: (S-09) the DAY1 page was wrong about R1: it asks "Pick LEFT beam or wall", "Pick RIGHT beam or wall", "Pick TOP/near side", "Pick BOTTOM/far side"...
    17. BUG-493: AUDIT 01 section C (settings and profile writes; no value a person set is changed by any of them; "start-up write" = written without the user asking): (C1) Structural rewrites CS_Settings.json at every AutoCAD start w...
    18. BUG-494: AUDIT 01 section B (Structural Undo/Redo, Stage 1): in the audit's reading nothing in Structural 1.0.110 writes to the drawing between U and REDO (Idle work waits, command-end work skips U/UNDO/REDO/MREDO), but this i...
    19. BUG-501: HUNT2-S-07 (MEDIUM): the column commands C1 and C2 take their size from the imported member schedule by mark only, ignoring the floor. What the drafter sees: the member schedule imported with XCLMTXT has C1 = 89 SHS o...
    20. BUG-503: LOW findings from the second Structural bug hunt, grouped (HUNT2-S-09 to HUNT2-S-15; each is small, none seen in AutoCAD). (1) HUNT2-S-09 MEDIUM-LOW, Services/ScheduleService.cs 350-364 and 396-409: the STRSCHEDCREATE...
    21. BUG-504: HUNT2-S-11 (own entry from the desk, 9 Oct: it breaks the rule that Unknown stays Unknown): CSWINDCLASS saves a blank or any typed text as the job's wind class and says it is set. Evidence (code reading only, installe...
    22. BUG-534: R00_STRUC items 14, 15, 19, 32, 33, 40 (MEDIUM-HIGH; five standards tables that must be cited with their editions, in the tables and in the output; plus items 11, 39, 49 and 50 that lean on a standard without citing i...
    23. BUG-537: R00_STRUC items 6, 8, 9, 10, 11, 12, 13, 17, 22, 35, 36, 37 and 41 to 65 (LOW-MEDIUM; the remaining ranked values, grouped; each named with file:line, all under Modules/Structural; none seen in AutoCAD; items already...
    24. BUG-548: S-29 Opus finalizer findings (9 Oct, TRAIN_S29_FINALIZER_REPORT.md; GO at 68ace978 = the head the assembler pushed; the finalizer made NO commit; nothing HIGH, one MEDIUM, seven LOWs). The train carries #848 #854 #846...
    25. BUG-561: PITEDIT (Edit Pit), a detention pit whose label is changed from C1 to C99 (number only), then Save. Civil 3.0.41, Codex W49-04ii, 10 Oct 01:40, report CODEX_VERIFYW49_2026-10-10.md item 19 and 34. HIGH (desk 10 Oct 02...
    26. BUG-719: CDIMPORTLANDXML, pipes in a standard LandXML file (HUNT Civil B finding C1, installed Civil 3.0.53).
    27. BUG-1139: C1 / C2 / DS support placement, Structural 1.0.122 (T4-05). MEDIUM, SURE (label movement UNSURE).
16. **C2** (Floors): 11 open or in progress in the carpark
    1. BUG-86: Structural command `C2` — support block insertion and dynamic Visibility property.
    2. BUG-426: C-21 Opus finalizer findings (8 Oct, TRAIN_C21_FINALIZER_REPORT.md; GO at 49034734, none blocks the install). **MEDIUM (#766):** in the Pit Schedule window type 9 in P1's pit-number cell, then type p1 (lower case of t...
    3. BUG-468: HUNT-S-03 (MEDIUM, roof-down order UX-STRUC-13): columns placed with beam linking OFF are invisible to the level-below tools. The only place CE looks for posts coming down is the beam-to-support links (Services/Founda...
    4. BUG-493: AUDIT 01 section C (settings and profile writes; no value a person set is changed by any of them; "start-up write" = written without the user asking): (C1) Structural rewrites CS_Settings.json at every AutoCAD start w...
    5. BUG-501: HUNT2-S-07 (MEDIUM): the column commands C1 and C2 take their size from the imported member schedule by mark only, ignoring the floor. What the drafter sees: the member schedule imported with XCLMTXT has C1 = 89 SHS o...
    6. BUG-537: R00_STRUC items 6, 8, 9, 10, 11, 12, 13, 17, 22, 35, 36, 37 and 41 to 65 (LOW-MEDIUM; the remaining ranked values, grouped; each named with file:line, all under Modules/Structural; none seen in AutoCAD; items already...
    7. BUG-576: Structural C2/SC2 Select Column Type window, installed1.0.116, real AutoCAD14Oct2026.
    8. BUG-666: ERASE of a copied pipe (rising main, same-plan break, or a grip-copied pipe after U or reopen) (HUNT Civil E finding C2, installed Civil 3.0.51).
    9. BUG-720: CDIMPORTLANDXML, detention (control) pits (HUNT Civil B finding C2, installed Civil 3.0.53).
    10. BUG-974: XCLMTXT (Insert Selected) then C2 (also any support command whose name matches a schedule mark); no switch (Structural), ledger F-164.
    11. BUG-1139: C1 / C2 / DS support placement, Structural 1.0.122 (T4-05). MEDIUM, SURE (label movement UNSURE).
17. **SDS** (Floors): 1 open or in progress in the carpark
    1. BUG-975: SDS, SDS1, SC2 and every other S* support switch (and TDS); no switch (Structural), ledger F-165.
18. **SDS1** (Floors): 2 open or in progress in the carpark
    1. BUG-548: S-29 Opus finalizer findings (9 Oct, TRAIN_S29_FINALIZER_REPORT.md; GO at 68ace978 = the head the assembler pushed; the finalizer made NO commit; nothing HIGH, one MEDIUM, seven LOWs). The train carries #848 #854 #846...
    2. BUG-975: SDS, SDS1, SC2 and every other S* support switch (and TDS); no switch (Structural), ledger F-165.
19. **STS1** (Floors): 1 open or in progress in the carpark
    1. BUG-548: S-29 Opus finalizer findings (9 Oct, TRAIN_S29_FINALIZER_REPORT.md; GO at 68ace978 = the head the assembler pushed; the finalizer made NO commit; nothing HIGH, one MEDIUM, seven LOWs). The train carries #848 #854 #846...
20. **SC1** (Floors): 1 open or in progress in the carpark
    1. BUG-548: S-29 Opus finalizer findings (9 Oct, TRAIN_S29_FINALIZER_REPORT.md; GO at 68ace978 = the head the assembler pushed; the finalizer made NO commit; nothing HIGH, one MEDIUM, seven LOWs). The train carries #848 #854 #846...
21. **SC2** (Floors): 3 open or in progress in the carpark
    1. BUG-548: S-29 Opus finalizer findings (9 Oct, TRAIN_S29_FINALIZER_REPORT.md; GO at 68ace978 = the head the assembler pushed; the finalizer made NO commit; nothing HIGH, one MEDIUM, seven LOWs). The train carries #848 #854 #846...
    2. BUG-576: Structural C2/SC2 Select Column Type window, installed1.0.116, real AutoCAD14Oct2026.
    3. BUG-975: SDS, SDS1, SC2 and every other S* support switch (and TDS); no switch (Structural), ledger F-165.
22. **FJ1** (Floors): 1 open or in progress in the carpark
    1. BUG-584: R1 rafter-span drawing size, installedStructural1.0.116+f180b349. MEDIUM: accepted bay dimensions do not reach the placed dynamicblock, with no visible refusal or warning. FJ1 and normalP1 now reproduced; see the date...
23. **AB** (Bracing): 7 open or in progress in the carpark
    1. BUG-428: S-22 Opus finalizer findings (8 Oct, TRAIN_S22_FINALIZER_REPORT.md; GO at c2df7548; no HIGH, no MEDIUM; seven LOW/NIT/NOTE items, none blocking; read the report for all seven): the BB brace command still draws a long...
    2. BUG-475: HUNT-S-09, 10, 12, 13, 14, 15 (LOW / docs) and causes for older bugs: (S-09) the DAY1 page was wrong about R1: it asks "Pick LEFT beam or wall", "Pick RIGHT beam or wall", "Pick TOP/near side", "Pick BOTTOM/far side"...
    3. BUG-497: HUNT2-S-03 (HIGH, the exact symptom is my reading of AutoCAD's table rules, not seen): STRSCHEDCREATE (Schedules > Create Schedule) makes every table one row too short. What the drafter sees (I think): after placing a...
    4. BUG-498: HUNT2-S-04 (MEDIUM-HIGH): STRSCHEDREFRESH never removes rows, so a brace or pier that was erased stays on the schedule. What the drafter sees: four braces drawn, one erased, STRSCHEDREFRESH and pick the bracing schedu...
    5. BUG-499: HUNT2-S-05 (MEDIUM-HIGH): the bracing panel (CSBRACINGPANEL) adds roof bracing trusses placed with BT1 to the WALL bracing totals. What the drafter sees: two 4 m roof trusses add 8 m to the wall bracing 'provided'; a...
    6. BUG-503: LOW findings from the second Structural bug hunt, grouped (HUNT2-S-09 to HUNT2-S-15; each is small, none seen in AutoCAD). (1) HUNT2-S-09 MEDIUM-LOW, Services/ScheduleService.cs 350-364 and 396-409: the STRSCHEDCREATE...
    7. BUG-535: WINDOW ROWS FOR CODEX: R00_STRUC items 4, 30, 31, 32, 33 and 38 (MEDIUM; six values already named in CS_Settings.json that have NO box on the CESETTINGS window, so a drafter can only change them by editing the file)....
24. **BB** (Bracing): 5 open or in progress in the carpark
    1. BUG-428: S-22 Opus finalizer findings (8 Oct, TRAIN_S22_FINALIZER_REPORT.md; GO at c2df7548; no HIGH, no MEDIUM; seven LOW/NIT/NOTE items, none blocking; read the report for all seven): the BB brace command still draws a long...
    2. BUG-475: HUNT-S-09, 10, 12, 13, 14, 15 (LOW / docs) and causes for older bugs: (S-09) the DAY1 page was wrong about R1: it asks "Pick LEFT beam or wall", "Pick RIGHT beam or wall", "Pick TOP/near side", "Pick BOTTOM/far side"...
    3. BUG-503: LOW findings from the second Structural bug hunt, grouped (HUNT2-S-09 to HUNT2-S-15; each is small, none seen in AutoCAD). (1) HUNT2-S-09 MEDIUM-LOW, Services/ScheduleService.cs 350-364 and 396-409: the STRSCHEDCREATE...
    4. BUG-525: HUNT3 heading 3, findings 3.2 and 3.9 to 3.14 (the other blues; grouped; severity kept per item; the main blue is BUG-517; Tim, INT-075 Batch 3 item 8: 'ideally no blue please our colours are gold, black and white /gr...
    5. BUG-535: WINDOW ROWS FOR CODEX: R00_STRUC items 4, 30, 31, 32, 33 and 38 (MEDIUM; six values already named in CS_Settings.json that have NO box on the CESETTINGS window, so a drafter can only change them by editing the file)....
25. **ABS** (Bracing): 1 open or in progress in the carpark
    1. BUG-583: Structural Switch A/B (ABS), locked selected brace. MEDIUM: command opens an unhandled-error window; protection remains intact in the single-object case.
26. **CSBRACINGPANEL** (Bracing): 3 open or in progress in the carpark
    1. BUG-499: HUNT2-S-05 (MEDIUM-HIGH): the bracing panel (CSBRACINGPANEL) adds roof bracing trusses placed with BT1 to the WALL bracing totals. What the drafter sees: two 4 m roof trusses add 8 m to the wall bracing 'provided'; a...
    2. BUG-500: HUNT2-S-06 (MEDIUM): the required bracing figures (CSBRACINGREQUIRED) are one value for the whole PC, so the last job's figure sits on the next job. What the drafter sees: sets 12000 / 9000 on job A, opens an unrelate...
    3. BUG-503: LOW findings from the second Structural bug hunt, grouped (HUNT2-S-09 to HUNT2-S-15; each is small, none seen in AutoCAD). (1) HUNT2-S-09 MEDIUM-LOW, Services/ScheduleService.cs 350-364 and 396-409: the STRSCHEDCREATE...
27. **STRSCHEDCREATE** (Bracing): 3 open or in progress in the carpark
    1. BUG-497: HUNT2-S-03 (HIGH, the exact symptom is my reading of AutoCAD's table rules, not seen): STRSCHEDCREATE (Schedules > Create Schedule) makes every table one row too short. What the drafter sees (I think): after placing a...
    2. BUG-498: HUNT2-S-04 (MEDIUM-HIGH): STRSCHEDREFRESH never removes rows, so a brace or pier that was erased stays on the schedule. What the drafter sees: four braces drawn, one erased, STRSCHEDREFRESH and pick the bracing schedu...
    3. BUG-503: LOW findings from the second Structural bug hunt, grouped (HUNT2-S-09 to HUNT2-S-15; each is small, none seen in AutoCAD). (1) HUNT2-S-09 MEDIUM-LOW, Services/ScheduleService.cs 350-364 and 396-409: the STRSCHEDCREATE...
28. **STRSCHEDREFRESH** (Bracing): 2 open or in progress in the carpark
    1. BUG-498: HUNT2-S-04 (MEDIUM-HIGH): STRSCHEDREFRESH never removes rows, so a brace or pier that was erased stays on the schedule. What the drafter sees: four braces drawn, one erased, STRSCHEDREFRESH and pick the bracing schedu...
    2. BUG-503: LOW findings from the second Structural bug hunt, grouped (HUNT2-S-09 to HUNT2-S-15; each is small, none seen in AutoCAD). (1) HUNT2-S-09 MEDIUM-LOW, Services/ScheduleService.cs 350-364 and 396-409: the STRSCHEDCREATE...
29. **STRSCHEDSYNC** (Bracing): 1 open or in progress in the carpark
    1. BUG-1183: STRSCHEDSYNC, Bored Pier Schedule, Structural 1.0.122 (Codex audit RD14-01). HIGH, SURE (verified by reading; not run in AutoCAD).
30. **CLEAN** (Tools): 1 open or in progress in the carpark
    1. BUG-425: SECOND SOURCE AUDIT of Structural + Manager (8 Oct, `04_REFERENCE/release/SOURCE_AUDIT_2_2026-10-08.md`, Opus, read-only, code at Structural 1.0.104 and Manager 1.1.34): 25 findings, 2 HIGH, 12 MEDIUM, 11 LOW, none a...
31. **CEHELP** (Tools): 4 open or in progress in the carpark
    1. BUG-1077: BSET ribbon tooltip and CEHELP entry, Structural 1.0.122 (Codex audit RD11-06, 23 Oct 2026). MEDIUM, SURE (verified by reading).
    2. BUG-1078: CEHELP for CEMARKUPLOAD (Open Saved Markup Review), CEMARKUPREGISTER (Set Drawing for Markup), CEMARKUPRUN (Apply Next Markup Group), Structural 1.0.122 (Codex audit RD11-07, 23 Oct 2026). MEDIUM, SURE (verified by re...
    3. BUG-1079: CEHELP for STRUCEXPORTPDF (Export Layout to PDF), Structural 1.0.122 (Codex audit RD11-08, 23 Oct 2026). LOW, SURE (verified by reading).
    4. BUG-1219: CEHELP (Show advanced commands), "Beam Settings (8)" and RJSET, Structural 1.0.122 (RD22-05). LOW, SURE.
32. **CESETTINGS** (Tools): 16 open or in progress in the carpark
    1. BUG-520: HUNT3 4.1, 4.2, 4.3, 4.4 (4.3 MEDIUM because the command is live; the rest LOW-MEDIUM; breaks the Settings-first rule R-00): new engineering values have no row on the Settings window, so a drafter cannot see or change...
    2. BUG-526: HUNT3 heading 4, finding 4.5 (LOW, a record; the other Settings findings are BUG-520): 29 Structural Settings groups are never read by the CESETTINGS window. What the drafter sees: nothing wrong today; the risk is tha...
    3. BUG-530: R00_STRUC item 1 (MEDIUM; the pad footing size 600 has no Settings name and is also drawn for old pads that have no recorded size). What the drafter sees: FPFC offers 600 as the first answer for every new pad mark, an...
    4. BUG-534: R00_STRUC items 14, 15, 19, 32, 33, 40 (MEDIUM-HIGH; five standards tables that must be cited with their editions, in the tables and in the output; plus items 11, 39, 49 and 50 that lean on a standard without citing i...
    5. BUG-535: WINDOW ROWS FOR CODEX: R00_STRUC items 4, 30, 31, 32, 33 and 38 (MEDIUM; six values already named in CS_Settings.json that have NO box on the CESETTINGS window, so a drafter can only change them by editing the file)....
    6. BUG-536: R00_STRUC items 5, 7, 20, 23, 24, 26, 27 and 34 (MEDIUM; EIGHT commands that ignore a Settings name that already exists, or read it for only part of the job). What the drafter sees: they change a value on the Settings...
    7. BUG-537: R00_STRUC items 6, 8, 9, 10, 11, 12, 13, 17, 22, 35, 36, 37 and 41 to 65 (LOW-MEDIUM; the remaining ranked values, grouped; each named with file:line, all under Modules/Structural; none seen in AutoCAD; items already...
    8. BUG-549: URGENT PRIVACY FINDING (desk design run 9, card BATCH15_STRUC_MARKUP_QA_ROOF_DOWN_CARD_2026-10-09.md; HIGH). **BLOCKS COLLEAGUE INSTALL (gate item 10).** The Structural 'Read Markup PDF' command (CEMARKUP) in its DEFA...
    9. BUG-575: Structural Settings (CESETTINGS), System -> Installation; installed Structural 1.0.116, real AutoCAD, 14 Oct 2026 06:16 Melbourne.
    10. BUG-752: Structural Settings (CESETTINGS), installed Structural 1.0.118, real AutoCAD 2027, 18 Oct 2026. LOW.
    11. BUG-826: Structural Settings (CESETTINGS) > Reset Defaults, Structural 1.0.118 (HUNT-MI-04). HIGH.
    12. BUG-841: Structural Settings (CESETTINGS), beam offset and other number boxes, Structural 1.0.118 (HUNT-MI-19). LOW-MEDIUM.
    13. BUG-955: Structural windows (CESHEETS, CESETTINGS and others sharing the host), ledger F-139.
    14. BUG-1072: CESETTINGS > System > Saving and diagnostics, Structural 1.0.122 (Codex audit RD11-01, 23 Oct 2026). MEDIUM, SURE (verified by reading).
    15. BUG-1076: CESETTINGS > System > Saving and diagnostics, Structural 1.0.122 (Codex audit RD11-05, 23 Oct 2026). MEDIUM, SURE (verified by reading).
    16. BUG-1203: Structural start-up, CESETTINGS, Schedules / Markup, Structural 1.0.122 (RD19-02). MEDIUM, SURE.

## Added 13 Nov from the code read

Fri 13 Nov 2026. 95 new entries, BUG-1361 to BUG-1455, all OPEN, all found by reading the installed Structural 1.0.126 code (commit 8de95c34) and not yet seen in AutoCAD. A bug that names several tools appears under each. FASTSAVE is not one of the 32 KEEP tools; it is listed last because several entries name it.

1. **R1**: 8 new
    - BUG-1372: R1, P1 and FJ1 draw a guessed arrow depth when the top and bottom picks are under 25 units apart, with no line
    - BUG-1373: R1, P1 and FJ1 straighten a bay within 12 degrees of horizontal or vertical and measure the width along that axis, with no line
    - BUG-1374: R1, P1 and FJ1 slide the marker inside the bay to miss text and walls with no line
    - BUG-1375: R1, P1 and FJ1 draw on a locked RAFTERS, PURLINS or JOISTS layer where AB, BB and BT1 refuse
    - BUG-1376: R1, P1 and FJ1 do not report a size the block did not take when the value cannot be read back
    - BUG-1377: R1, P1 and FJ1 use fixed numbers (25, 300, plus 200) that have no Settings name
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
2. **P1**: 8 new
    - BUG-1371: P1 purlin lap is fixed at 1200 mm and the question "Apply purlin lap?" does not show the number
    - BUG-1372: R1, P1 and FJ1 draw a guessed arrow depth when the top and bottom picks are under 25 units apart, with no line
    - BUG-1373: R1, P1 and FJ1 straighten a bay within 12 degrees of horizontal or vertical and measure the width along that axis, with no line
    - BUG-1374: R1, P1 and FJ1 slide the marker inside the bay to miss text and walls with no line
    - BUG-1375: R1, P1 and FJ1 draw on a locked RAFTERS, PURLINS or JOISTS layer where AB, BB and BT1 refuse
    - BUG-1376: R1, P1 and FJ1 do not report a size the block did not take when the value cannot be read back
    - BUG-1377: R1, P1 and FJ1 use fixed numbers (25, 300, plus 200) that have no Settings name
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
3. **BT1**: 6 new
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1379: AB, BB and BT1 say the brace was set "from the Xref walls: the side with fewer wall lines" whatever the real reason
    - BUG-1380: AB, BB and BT1 move the brace end by up to 1 degree to a square angle with no line
    - BUG-1381: AB, BB and BT1 add layer 25CONT to the drawing if it is missing, with no line
    - BUG-1382: BT1 help lists "BT number 1-9" before "Insert point" but the tool asks the points first
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
4. **1**: 9 new
    - BUG-1365: Beam tools 1, 2, 4 and 5 refuse every beam with "CE hit an internal problem" when the beam or text layer is locked, off, frozen or set differently
    - BUG-1384: On a layout tab or in REFEDIT the beam tools show an "internal problem" or "safety checks" line instead of "go to model space"
    - BUG-1385: Beam tools 1, 2, 4 and 5 ignore the beam and text layer names set on the Settings window
    - BUG-1390: Enter at "Enter text" with no text shown prints "one of the command-line prompts did not complete properly"
    - BUG-1391: "Remember last choices" does not remember the mark, beam type, suffix or shortening in the new beam route
    - BUG-1392: Any beam mark starting with L (such as LVL1) is treated as a lintel
    - BUG-1393: Beam tools 1, 2, 4 and 5 shorten a beam end by the auto-trim with no line saying so
    - BUG-1394: Walls and openings steer the beam mark only when the layer name contains WALL, WINDOW or DOOR
    - BUG-1404: After 128 saved inside points the beam tools stop with "the saved inside-of-building point looks wrong" and BSET does not warn
5. **2**: 10 new
    - BUG-1365: Beam tools 1, 2, 4 and 5 refuse every beam with "CE hit an internal problem" when the beam or text layer is locked, off, frozen or set differently
    - BUG-1384: On a layout tab or in REFEDIT the beam tools show an "internal problem" or "safety checks" line instead of "go to model space"
    - BUG-1385: Beam tools 1, 2, 4 and 5 ignore the beam and text layer names set on the Settings window
    - BUG-1386: Beam tools 2, 4 and 5 give no "best available" choice when neither side of the beam has room for the mark
    - BUG-1390: Enter at "Enter text" with no text shown prints "one of the command-line prompts did not complete properly"
    - BUG-1391: "Remember last choices" does not remember the mark, beam type, suffix or shortening in the new beam route
    - BUG-1392: Any beam mark starting with L (such as LVL1) is treated as a lintel
    - BUG-1393: Beam tools 1, 2, 4 and 5 shorten a beam end by the auto-trim with no line saying so
    - BUG-1394: Walls and openings steer the beam mark only when the layer name contains WALL, WINDOW or DOOR
    - BUG-1404: After 128 saved inside points the beam tools stop with "the saved inside-of-building point looks wrong" and BSET does not warn
6. **4**: 13 new
    - BUG-1365: Beam tools 1, 2, 4 and 5 refuse every beam with "CE hit an internal problem" when the beam or text layer is locked, off, frozen or set differently
    - BUG-1384: On a layout tab or in REFEDIT the beam tools show an "internal problem" or "safety checks" line instead of "go to model space"
    - BUG-1385: Beam tools 1, 2, 4 and 5 ignore the beam and text layer names set on the Settings window
    - BUG-1386: Beam tools 2, 4 and 5 give no "best available" choice when neither side of the beam has room for the mark
    - BUG-1387: Beam tools 4 and 5 place a lintel mark as an ordinary mark when no inside point is known, with no line
    - BUG-1388: Beam tools 4 and 5 ask the inside-point question for every mark when none is saved, not only for lintels
    - BUG-1389: Beam tools 4 and 5 can only shorten or offset by 45 or 100, with no Settings list
    - BUG-1390: Enter at "Enter text" with no text shown prints "one of the command-line prompts did not complete properly"
    - BUG-1391: "Remember last choices" does not remember the mark, beam type, suffix or shortening in the new beam route
    - BUG-1392: Any beam mark starting with L (such as LVL1) is treated as a lintel
    - BUG-1393: Beam tools 1, 2, 4 and 5 shorten a beam end by the auto-trim with no line saying so
    - BUG-1394: Walls and openings steer the beam mark only when the layer name contains WALL, WINDOW or DOOR
    - BUG-1404: After 128 saved inside points the beam tools stop with "the saved inside-of-building point looks wrong" and BSET does not warn
7. **5**: 14 new
    - BUG-1365: Beam tools 1, 2, 4 and 5 refuse every beam with "CE hit an internal problem" when the beam or text layer is locked, off, frozen or set differently
    - BUG-1384: On a layout tab or in REFEDIT the beam tools show an "internal problem" or "safety checks" line instead of "go to model space"
    - BUG-1385: Beam tools 1, 2, 4 and 5 ignore the beam and text layer names set on the Settings window
    - BUG-1386: Beam tools 2, 4 and 5 give no "best available" choice when neither side of the beam has room for the mark
    - BUG-1387: Beam tools 4 and 5 place a lintel mark as an ordinary mark when no inside point is known, with no line
    - BUG-1388: Beam tools 4 and 5 ask the inside-point question for every mark when none is saved, not only for lintels
    - BUG-1389: Beam tools 4 and 5 can only shorten or offset by 45 or 100, with no Settings list
    - BUG-1390: Enter at "Enter text" with no text shown prints "one of the command-line prompts did not complete properly"
    - BUG-1391: "Remember last choices" does not remember the mark, beam type, suffix or shortening in the new beam route
    - BUG-1392: Any beam mark starting with L (such as LVL1) is treated as a lintel
    - BUG-1393: Beam tools 1, 2, 4 and 5 shorten a beam end by the auto-trim with no line saying so
    - BUG-1394: Walls and openings steer the beam mark only when the layer name contains WALL, WINDOW or DOOR
    - BUG-1395: Help for beam tool 5 says "Beam offset helper command" and does not say the beam moves 45 or 100 mm
    - BUG-1404: After 128 saved inside points the beam tools stop with "the saved inside-of-building point looks wrong" and BSET does not warn
8. **BDL**: 6 new
    - BUG-1364: BDL has no units handling: in a metre drawing its 50 minimum, 100 offset and 250 search are metres
    - BUG-1391: "Remember last choices" does not remember the mark, beam type, suffix or shortening in the new beam route
    - BUG-1396: BDL ends silently with both beam lines already drawn if Esc or Enter is pressed at the text questions
    - BUG-1397: BDL has no Model space or REFEDIT check: on a layout tab its lines go into Model space at the picked coordinates
    - BUG-1398: BDL draws on a locked BEAM, BEAM LOWER or 25TEXT layer where tools 1, 2, 4 and 5 refuse
    - BUG-1399: BDL zooms the view with no line, and the zoom is not part of Undo
9. **BSET**: 4 new
    - BUG-1400: BSET, BSETRESET and BSETLIST report success or "none stored" when the store could not be written or read
    - BUG-1402: BSET saves the clicked point as given, so a turned UCS can save the wrong place
    - BUG-1403: BSET and BSETRESET have no read-only, Model space or REFEDIT check
    - BUG-1404: After 128 saved inside points the beam tools stop with "the saved inside-of-building point looks wrong" and BSET does not warn
10. **BSETLIST**: 2 new
    - BUG-1400: BSET, BSETRESET and BSETLIST report success or "none stored" when the store could not be written or read
    - BUG-1405: Help for BSETLIST and BSETRESET still says the points are stored in the drawing's XRecord
11. **BSETRESET**: 4 new
    - BUG-1400: BSET, BSETRESET and BSETLIST report success or "none stored" when the store could not be written or read
    - BUG-1401: BSETRESET clears every saved inside point with no question
    - BUG-1403: BSET and BSETRESET have no read-only, Model space or REFEDIT check
    - BUG-1405: Help for BSETLIST and BSETRESET still says the points are stored in the drawing's XRecord
12. **DS**: 11 new
    - BUG-1363: A schedule size the support block cannot show is drawn as the default size while the screen line names the schedule size
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1406: With no schedule row the support is drawn at the default size and nothing says where the size came from
    - BUG-1407: A Settings size the support block does not offer leaves the block in whatever state it had, with no line
    - BUG-1414: "Support linked to nearby beam" can print when the link was not saved
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1417: A member schedule saved with every row left out does not replace the old schedule, so the old sizes keep being used
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1421: With the rotation preview switched off the line says "CE could not turn the support to the wall direction by itself"
    - BUG-1422: Help for DS and the five support switches lists prompts these commands do not ask
    - BUG-1423: Support tools say nothing about a frozen or switched-off support layer
13. **DS1**: 11 new
    - BUG-1363: A schedule size the support block cannot show is drawn as the default size while the screen line names the schedule size
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1406: With no schedule row the support is drawn at the default size and nothing says where the size came from
    - BUG-1407: A Settings size the support block does not offer leaves the block in whatever state it had, with no line
    - BUG-1414: "Support linked to nearby beam" can print when the link was not saved
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1417: A member schedule saved with every row left out does not replace the old schedule, so the old sizes keep being used
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1421: With the rotation preview switched off the line says "CE could not turn the support to the wall direction by itself"
    - BUG-1423: Support tools say nothing about a frozen or switched-off support layer
14. **TS1**: 12 new
    - BUG-1363: A schedule size the support block cannot show is drawn as the default size while the screen line names the schedule size
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
    - BUG-1406: With no schedule row the support is drawn at the default size and nothing says where the size came from
    - BUG-1407: A Settings size the support block does not offer leaves the block in whatever state it had, with no line
    - BUG-1414: "Support linked to nearby beam" can print when the link was not saved
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1417: A member schedule saved with every row left out does not replace the old schedule, so the old sizes keep being used
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1421: With the rotation preview switched off the line says "CE could not turn the support to the wall direction by itself"
    - BUG-1423: Support tools say nothing about a frozen or switched-off support layer
15. **C1**: 12 new
    - BUG-1363: A schedule size the support block cannot show is drawn as the default size while the screen line names the schedule size
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
    - BUG-1406: With no schedule row the support is drawn at the default size and nothing says where the size came from
    - BUG-1407: A Settings size the support block does not offer leaves the block in whatever state it had, with no line
    - BUG-1414: "Support linked to nearby beam" can print when the link was not saved
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1417: A member schedule saved with every row left out does not replace the old schedule, so the old sizes keep being used
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1421: With the rotation preview switched off the line says "CE could not turn the support to the wall direction by itself"
    - BUG-1423: Support tools say nothing about a frozen or switched-off support layer
16. **C2**: 10 new
    - BUG-1363: A schedule size the support block cannot show is drawn as the default size while the screen line names the schedule size
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1414: "Support linked to nearby beam" can print when the link was not saved
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1417: A member schedule saved with every row left out does not replace the old schedule, so the old sizes keep being used
    - BUG-1419: The first C2 placement can print AutoCAD's "Duplicate definition of block _Dot ignored"
    - BUG-1420: If the C2 support block cannot be loaded the screen shows the raw error text
    - BUG-1421: With the rotation preview switched off the line says "CE could not turn the support to the wall direction by itself"
    - BUG-1423: Support tools say nothing about a frozen or switched-off support layer
17. **SDS**: 9 new
    - BUG-1408: Support switch commands do not check that the size change took, so the layer and position change even if the block keeps its old size
    - BUG-1409: Support switch commands have no layout tab, REFEDIT or non-millimetre check
    - BUG-1410: Switching a support with a label on a locked text layer draws the label again on top of the old one
    - BUG-1411: After a support switch the redrawn labels are not recorded as the support's own, so they stop following it when it moves
    - BUG-1412: In a support switch the block turns about its insertion corner while its labels turn about its centre
    - BUG-1413: A label carried across a support switch keeps its old wording and layer, so a column can read "DS3"
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1422: Help for DS and the five support switches lists prompts these commands do not ask
18. **SDS1**: 10 new
    - BUG-1408: Support switch commands do not check that the size change took, so the layer and position change even if the block keeps its old size
    - BUG-1409: Support switch commands have no layout tab, REFEDIT or non-millimetre check
    - BUG-1410: Switching a support with a label on a locked text layer draws the label again on top of the old one
    - BUG-1411: After a support switch the redrawn labels are not recorded as the support's own, so they stop following it when it moves
    - BUG-1412: In a support switch the block turns about its insertion corner while its labels turn about its centre
    - BUG-1413: A label carried across a support switch keeps its old wording and layer, so a column can read "DS3"
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1422: Help for DS and the five support switches lists prompts these commands do not ask
19. **STS1**: 10 new
    - BUG-1408: Support switch commands do not check that the size change took, so the layer and position change even if the block keeps its old size
    - BUG-1409: Support switch commands have no layout tab, REFEDIT or non-millimetre check
    - BUG-1410: Switching a support with a label on a locked text layer draws the label again on top of the old one
    - BUG-1411: After a support switch the redrawn labels are not recorded as the support's own, so they stop following it when it moves
    - BUG-1412: In a support switch the block turns about its insertion corner while its labels turn about its centre
    - BUG-1413: A label carried across a support switch keeps its old wording and layer, so a column can read "DS3"
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1422: Help for DS and the five support switches lists prompts these commands do not ask
20. **SC1**: 10 new
    - BUG-1408: Support switch commands do not check that the size change took, so the layer and position change even if the block keeps its old size
    - BUG-1409: Support switch commands have no layout tab, REFEDIT or non-millimetre check
    - BUG-1410: Switching a support with a label on a locked text layer draws the label again on top of the old one
    - BUG-1411: After a support switch the redrawn labels are not recorded as the support's own, so they stop following it when it moves
    - BUG-1412: In a support switch the block turns about its insertion corner while its labels turn about its centre
    - BUG-1413: A label carried across a support switch keeps its old wording and layer, so a column can read "DS3"
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1422: Help for DS and the five support switches lists prompts these commands do not ask
21. **SC2**: 10 new
    - BUG-1408: Support switch commands do not check that the size change took, so the layer and position change even if the block keeps its old size
    - BUG-1409: Support switch commands have no layout tab, REFEDIT or non-millimetre check
    - BUG-1410: Switching a support with a label on a locked text layer draws the label again on top of the old one
    - BUG-1411: After a support switch the redrawn labels are not recorded as the support's own, so they stop following it when it moves
    - BUG-1412: In a support switch the block turns about its insertion corner while its labels turn about its centre
    - BUG-1413: A label carried across a support switch keeps its old wording and layer, so a column can read "DS3"
    - BUG-1415: The remembered label text for support tools carries from one drawing to the next in the same AutoCAD session
    - BUG-1416: Support label height 200, the 45 degree label turn, the 260 label search radius and the support colours are fixed in the code
    - BUG-1418: Only C2 checks that the support block in the drawing is the current one
    - BUG-1422: Help for DS and the five support switches lists prompts these commands do not ask
22. **FJ1**: 7 new
    - BUG-1372: R1, P1 and FJ1 draw a guessed arrow depth when the top and bottom picks are under 25 units apart, with no line
    - BUG-1373: R1, P1 and FJ1 straighten a bay within 12 degrees of horizontal or vertical and measure the width along that axis, with no line
    - BUG-1374: R1, P1 and FJ1 slide the marker inside the bay to miss text and walls with no line
    - BUG-1375: R1, P1 and FJ1 draw on a locked RAFTERS, PURLINS or JOISTS layer where AB, BB and BT1 refuse
    - BUG-1376: R1, P1 and FJ1 do not report a size the block did not take when the value cannot be read back
    - BUG-1377: R1, P1 and FJ1 use fixed numbers (25, 300, plus 200) that have no Settings name
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
23. **AB**: 5 new
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1379: AB, BB and BT1 say the brace was set "from the Xref walls: the side with fewer wall lines" whatever the real reason
    - BUG-1380: AB, BB and BT1 move the brace end by up to 1 degree to a square angle with no line
    - BUG-1381: AB, BB and BT1 add layer 25CONT to the drawing if it is missing, with no line
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
24. **BB**: 5 new
    - BUG-1378: In a metre, centimetre or inch drawing the "held" line talks about footings and tells the drafter to LIST one footing
    - BUG-1379: AB, BB and BT1 say the brace was set "from the Xref walls: the side with fewer wall lines" whatever the real reason
    - BUG-1380: AB, BB and BT1 move the brace end by up to 1 degree to a square angle with no line
    - BUG-1381: AB, BB and BT1 add layer 25CONT to the drawing if it is missing, with no line
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
25. **ABS**: 4 new
    - BUG-1362: ABS (A-B switch) erases an older brace first, and if the new one cannot be drawn says "It was left as it was"
    - BUG-1366: ABS on a layout tab or inside REFEDIT erases the older brace there and redraws it in Model space with no stop line
    - BUG-1367: ABS reads the type of an untagged brace block from its layer name
    - BUG-1380: AB, BB and BT1 move the brace end by up to 1 degree to a square angle with no line
26. **CSBRACINGPANEL**: 4 new
    - BUG-1368: The bracing panel keeps the last totals on screen with no sign when a read fails
    - BUG-1369: Older-named brace blocks count as zero in the bracing panel and are left out of the bracing schedule
    - BUG-1370: Braces on a frozen or switched-off layer are counted in the bracing panel and the bracing schedule
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
27. **STRSCHEDCREATE**: 10 new
    - BUG-1361: STRSCHEDSYNC with no edits turns every rotated brace again and rewrites every brace's length and angle
    - BUG-1369: Older-named brace blocks count as zero in the bracing panel and are left out of the bracing schedule
    - BUG-1370: Braces on a frozen or switched-off layer are counted in the bracing panel and the bracing schedule
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
    - BUG-1424: STRSCHEDCREATE on a layout tab or in REFEDIT still puts the tables in Model space at the point clicked on the sheet
    - BUG-1425: In a rotated UCS the schedule tables land away from the point clicked
    - BUG-1426: A second STRSCHEDCREATE adds three more tables and leaves the first three out of date
    - BUG-1427: The schedule tables sit on whatever layer is current, because CE sets none
    - BUG-1428: The bracing table's ROTATION column ignores AutoCAD ROTATE on a brace and shows the block's own setting
    - BUG-1429: Help for the three schedule commands lists "Command-specific utility prompts" and describes them as "Create Schedule."
28. **STRSCHEDREFRESH**: 8 new
    - BUG-1369: Older-named brace blocks count as zero in the bracing panel and are left out of the bracing schedule
    - BUG-1370: Braces on a frozen or switched-off layer are counted in the bracing panel and the bracing schedule
    - BUG-1428: The bracing table's ROTATION column ignores AutoCAD ROTATE on a brace and shows the block's own setting
    - BUG-1429: Help for the three schedule commands lists "Command-specific utility prompts" and describes them as "Create Schedule."
    - BUG-1430: STRSCHEDREFRESH on a table CE did not make does nothing and prints nothing
    - BUG-1431: STRSCHEDREFRESH re-sorts a schedule the drafter sorted by hand
    - BUG-1432: STRSCHEDREFRESH is marked expert, so CEHELP hides it until "Show advanced commands" is ticked
    - BUG-1433: An old three-column pier table gets no MARK or DIA MM column on refresh and nothing says so
29. **STRSCHEDSYNC**: 7 new
    - BUG-1361: STRSCHEDSYNC with no edits turns every rotated brace again and rewrites every brace's length and angle
    - BUG-1429: Help for the three schedule commands lists "Command-specific utility prompts" and describes them as "Create Schedule."
    - BUG-1434: STRSCHEDSYNC on an erased brace or a locked brace layer gives AutoCAD's own error and nothing is synced
    - BUG-1435: Typing B over A in the bracing table changes the type text only; the brace stays on the A layer and plots as A
    - BUG-1436: STRSCHEDSYNC says nothing about values it skipped
    - BUG-1437: Edits to the tie-down table and typed pier MARK or DIA MM go nowhere with STRSCHEDSYNC and nothing says so
    - BUG-1438: STRSCHEDSYNC has no read-only drawing check, unlike the other two schedule commands
30. **CLEAN**: 11 new
    - BUG-1439: CLEAN: one object on a locked layer drops the whole text step and the whole ByLayer step, and the drawing is still saved after a half clean-up
    - BUG-1440: The CLEAN tooltip says "Does not save: save the drawing yourself" and Settings says "CE never saves" while CLEAN saves
    - BUG-1441: CLEAN prints "saved" when it only sent QSAVE and never checked the save
    - BUG-1442: CLEAN has no read-only, layout tab or REFEDIT check at the start
    - BUG-1443: CLEAN ignores the Xref layer settings on the Settings window and always uses layer XREF, colour 7, hatch 21 and Arial Narrow
    - BUG-1444: After CLEAN the next hatch is SOLID on layer HATCH 21 for the rest of the session
    - BUG-1445: CLEAN sets attribute definitions inside blocks to STANDARD while the summary says "attributes=preserved"
    - BUG-1446: CLEAN saves in the running AutoCAD's own file version, not the Save As format setting
    - BUG-1447: CLEAN keeps no copy from before the clean-up, because CE's backup copy is taken after the save
    - BUG-1448: FASTSAVE Help still says "lighter cleanup sequence" and lists FASTSAVE as another name for CLEAN
    - BUG-1452: CEHELP "Run command" starts the selected command with no confirmation, including CLEAN, which saves
31. **CEHELP**: 4 new
    - BUG-1449: CEHELP opens already filtered by the last thing searched, so the list can be empty with "No matching command"
    - BUG-1450: The 19 visible Foundations commands (FPFC, FSF, FST, BP and others) never appear in the CEHELP list
    - BUG-1451: CEHELP rewrites the settings file on every key typed in the search box, every tick and every Run
    - BUG-1452: CEHELP "Run command" starts the selected command with no confirmation, including CLEAN, which saves
32. **CESETTINGS**: 3 new
    - BUG-1453: Blanking a note or list box on CESETTINGS is ignored on Save and the old text stays
    - BUG-1454: "Share learning data" is ticked by default, nothing in the code reads it, and the page does not say where anything goes
    - BUG-1455: The Markup service page still offers an API key name, a service URL and an AI model that do nothing while page-send is blocked
33. **FASTSAVE**: 6 new
    - BUG-1383: Switches that change what AB, BB, the bracing panel, STRSCHEDCREATE and FASTSAVE do have no box on the Settings window
    - BUG-1441: CLEAN prints "saved" when it only sent QSAVE and never checked the save
    - BUG-1442: CLEAN has no read-only, layout tab or REFEDIT check at the start
    - BUG-1446: CLEAN saves in the running AutoCAD's own file version, not the Save As format setting
    - BUG-1447: CLEAN keeps no copy from before the clean-up, because CE's backup copy is taken after the save
    - BUG-1448: FASTSAVE Help still says "lighter cleanup sequence" and lists FASTSAVE as another name for CLEAN

