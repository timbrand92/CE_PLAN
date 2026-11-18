# Function plan tick sheet (revision 1)

**For:** `design\FUNCTION_PLAN.md` revision 1, Wed 18 Nov 2026. DRAFT.
**Everything is taken as agreed unless you write its number and what to change.**
Example: "FP-032 spoon drain in first release" or "ASK-1: use our council note wording instead".

## Answer these five first (my recommendation in brackets)

1. **ASK-1 (FP-015)** APPROX. note wording (LEVELS MARKED APPROX. ARE ASSUMED AND ARE TO BE CONFIRMED ON SITE BY THE BUILDER PRIOR TO THE COMMENCEMENT OF WORK. NOTIFY THE ENGINEER OF ANY DIFFERENCE.)
2. **ASK-2 (FP-007)** How the site's rainfall reaches you (copy the Bureau's table, paste into the Job window)
3. **ASK-3 (FP-013)** Pump well level rules (as CIV-12: static rise from inlet, bottom 400 below pumps stop, never under 3 m3 unless typed over)
4. **ASK-4 (FP-010)** Orifice pit detail per council (one office detail filled in; own detail only where the pit shape differs)
5. **ASK-5 (FP-053, FP-054)** Your WL/WT/Gr/ET... aliases and the TB2024 menu (leave untouched outside CE)

## Needed to finish a job

1. FP-001  CDCALC: computations PDF from Detention
2. FP-002  CDLPD: own tool LEGALPOINT / LPD
3. FP-003  CDTG, TG: own tool TRENCHGRATE / TG
4. FP-004  CDAGI, CDPERIMETER: own tool AGDRAIN / AG
5. FP-005  PITDELETE: plain ERASE, pipes stay loose
6. FP-006  CDPROFILE: LONGSECTION draws it on sheet
7. FP-007  CDRAINFALL: Job window, pasted or typed (ASK-2)
8. FP-008  CDTWL: TWL limits shown in Detention
9. FP-009  CDWT riser/dropper: part of TANK
10. FP-010  Orifice pit detail: filled by Detention (ASK-4)
11. FP-011  Tank detail: filled by TANK
12. FP-012  Roof area to tank box: TANK
13. FP-013  Pump well sums and box: PIT pump kind (ASK-3)
14. FP-014  Rising main: one more PIPE kind
15. FP-015  Legend, notes, details, APPROX. note: palette (ASK-1)
16. FP-016  Title block and issue: later; by hand
17. FP-017  Cleaned background: Put on office layer

## Civil drainage extras

18. FP-018  CDREVERSEFLOW, CDPIPEDIRECTION: direction from outlet; "Turn round"
19. FP-019  CDSYSTEM: system found from each outlet
20. FP-020  CDDEST: shown in the system strip
21. FP-021  CDSOURCE: "other inlet" kind
22. FP-022  CDRG: OFFICEHATCH raingarden plus area label
23. FP-023  CDCHECKIGNORE: accept finding with a note
24. FP-024  CDTAG foreign blocks: later, take-up group
25. FP-025  CEFIND: later; Unfinished list meanwhile
26. FP-026  Silt and soakage pits: later; by hand
27. FP-027  CDSTRIP: later; polyline plus FW meanwhile

## Pavement and site

28. FP-028  CDFALL, CDFALLSUGGEST: palette block; suggest later
29. FP-029  CDSL: palette block
30. FP-030  CDSLAB group: later, site group
31. FP-031  CDJOINT: later, SAWCUT fill option
32. FP-032  CDSPOON, CDSPOONDRAIN: later; MLINE meanwhile
33. FP-033  CDKERB: Put on office layer
34. FP-034  CDPAVE, CDCATCHMENT: OFFICEHATCH; overlay later
35. FP-035  CDTPZ, CDSRZ: Put on office layer plus hatch
36. FP-036  CDXREFCOMPARE, CDXREFREPAIR: later; AutoCAD repairs paths
37. FP-037  CDNEWDWG: later; copy template by hand
38. FP-038  CDDISCIPLINE: retire

## Shared tools and hatches

39. FP-039  DSET, DSET1: Dimensions "detail five times size"
40. FP-040  MD: Divide "copy at most X apart"
41. FP-041  CEHATCHCHANGE, BATCH, GAP, AUDIT: OFFICEHATCH buttons
42. FP-042  CJSS: change joint kind in Properties
43. FP-043  XRL variants: ticks in CLEAN
44. FP-044  Joint label placing: like 25T / 25B
45. FP-045  The 40 hatch names: your tick list
46. FP-046  CDS personal defaults: last used per PC

## Manager, help and records

47. FP-047  CEMANAGERLOGS: Open logs button, fault report
48. FP-048  Usage and failure records: kept, no job names
49. FP-049  CDHELP, CESTARTHERE: ribbon tips; tour later
50. FP-050  Admin dashboard tabs: retire, one admin page
51. FP-051  Old Manager pages: retire, jobs moved elsewhere

## Aliases and loose LISP

52. FP-052  CE short names: inside the plug-in
53. FP-053  Your WL, WT, Gr... aliases: untouched (ASK-5)
54. FP-054  TB2024 menu and toolkit: untouched outside CE
55. FP-055  3DF2L: kept as loose LISP
56. FP-056  CIVILEXCELMTEXT: retire, SCHEDULE replaces
57. FP-057  TP: retire once Blocks palette accepted
58. FP-058  CDJ, owner's NEW.lsp, TEXTON...: retire
59. FP-059  CDD and helpers: retire, PIPE replaces
60. FP-060  Old LISP CD: retire before new CD
61. FP-061  TBDRAIN-INPUT: retire
62. FP-062  Excel importer build steps: retire
63. FP-063  Excel importer tests: retire
64. FP-064  Check and debug routines: retire
65. FP-065  Old tool palettes: archive, not delete

## Retire

66. FP-066  CDPIPEOBJ: retire (your D-094)
67. FP-067  CDC7UPGRADE: retire (your D-119)
68. FP-068  C: retire, use Copy (your D-203)
69. FP-069  COPYMULTI, COPYM, CEMCOPY: retire, use Copy
70. FP-070  CDSOURCECHANGETYPE: retire, Properties
71. FP-071  CDFOCUS: retire, Inspect button
72. FP-072  CDSETUP: retire, Job window
73. FP-073  CEPALETTE, CETOOLS: retire, ribbon tips
74. FP-074  CEASK, CDASK: retire
75. FP-075  Civil debug commands: retire
76. FP-076  Leftover test bundles: retire
77. FP-077  Structural debug commands: retire

**Counts:** 77 lines. 33 into a first-release tool; 3 own small tools; 3 palette blocks; 10 later with a named way meanwhile; 3 kept outside CE; 25 retire. 5 ASK.
