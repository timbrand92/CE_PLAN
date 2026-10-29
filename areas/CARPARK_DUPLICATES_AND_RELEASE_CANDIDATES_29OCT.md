# Carpark suspected duplicates and release-blocker candidates (tidy steps T-7 and T-8, 29 Oct 2026)

**Nothing was merged, closed or changed.** A script compared titles; a person (Tim or the desk) decides. A duplicate never closes an entry: the newer points at the older (carpark rule 8).

## 1. Suspected duplicates (same command, titles share most words): 19 pairs

1. BUG-970 and BUG-1021 (CDTWL, 100% alike): "CDTWL (no switch) (Civil engineering numbers), ledger F-160." / "CDTWL. No switch. (Civil engineering numbers), ledger F-226."
2. BUG-1001 and BUG-1002 (CDIMPORTXCIVIL, 100% alike): "CDIMPORTXCIVIL. No switch (Civil imports), ledger F-198." / "CDIMPORTXCIVIL. No switch (Civil imports), ledger F-199."
3. BUG-435 and BUG-442 (CD, 100% alike): "CODEX W24 on installed Civil 3.0.36 / Manager 1.1.36 / Structural 1.0.106 (8 Oct 07:28, CODEX_V" / "CODEX W32 on installed Civil 3.0.37 / Manager 1.1.37 / Structural 1.0.107 (8 Oct 11:16, CODEX_V"
4. BUG-968 and BUG-1005 (CDRENUMBER, 87% alike): "CDRENUMBER (PitRenumberCommand.cs:28, :69); no switch (Civil commands, Undo and Checks), ledger" / "CDRENUMBER. No switch (Civil commands, Undo and Checks), ledger F-202."
5. BUG-730 and BUG-738 (CDIMPORTXCIVIL, 75% alike): "CDIMPORTXCIVIL, pit schedule table in the DWG (HUNT Civil B finding D1, installed Civil 3.0.53)" / "CDIMPORTXCIVIL, text schedule row with no "CL" (HUNT Civil B finding D9, installed Civil 3.0.53"
6. BUG-981 and BUG-1008 (PITSCHEDULE, 70% alike): "PITSCHEDULE, Source = Drainage XREFs (no switch) (Civil records, schedules and sheets), ledger " / "PITSCHEDULE (no switch) (Civil records, schedules and sheets), ledger F-206."
7. BUG-717 and BUG-738 (CDIMPORTXCIVIL, 66% alike): "CDIMPORTXCIVIL spot-level text (HUNT Civil B finding B8, installed Civil 3.0.53)." / "CDIMPORTXCIVIL, text schedule row with no "CL" (HUNT Civil B finding D9, installed Civil 3.0.53"
8. BUG-735 and BUG-738 (CDIMPORTXCIVIL, 66% alike): "CDIMPORTXCIVIL, invert text at the wrong end (HUNT Civil B finding D6, installed Civil 3.0.53)." / "CDIMPORTXCIVIL, text schedule row with no "CL" (HUNT Civil B finding D9, installed Civil 3.0.53"
9. BUG-715 and BUG-716 (CDSLAB, 66% alike): "Pit design-level offer versus CDSLAB surface (HUNT Civil B finding B6, installed Civil 3.0.53)." / "Pit design-level offer after editing a CDSLAB spot (HUNT Civil B finding B7, installed Civil 3."
10. BUG-894 and BUG-895 (CDTIDYLABELS, 66% alike): "CDTIDYLABELS pit cover text, ledger F-035." / "CDTIDYLABELS on a layout sheet, cover text, ledger F-036."
11. BUG-641 and BUG-642 (CDCATCHMENT, 66% alike): "CDCATCHMENT New, Civil3.0.49, AutoCAD2027. MEDIUM." / "CDCATCHMENT overlay/labels, Civil3.0.49, AutoCAD2027. MEDIUM."
12. BUG-730 and BUG-736 (CDIMPORTXCIVIL, 62% alike): "CDIMPORTXCIVIL, pit schedule table in the DWG (HUNT Civil B finding D1, installed Civil 3.0.53)" / "CDIMPORTXCIVIL, IL and CL wordings (HUNT Civil B finding D7, installed Civil 3.0.53)."
13. BUG-736 and BUG-738 (CDIMPORTXCIVIL, 62% alike): "CDIMPORTXCIVIL, IL and CL wordings (HUNT Civil B finding D7, installed Civil 3.0.53)." / "CDIMPORTXCIVIL, text schedule row with no "CL" (HUNT Civil B finding D9, installed Civil 3.0.53"
14. BUG-736 and BUG-739 (CDIMPORTXCIVIL, 62% alike): "CDIMPORTXCIVIL, IL and CL wordings (HUNT Civil B finding D7, installed Civil 3.0.53)." / "CDIMPORTXCIVIL report and PDF reading (HUNT Civil B finding D10, installed Civil 3.0.53)."
15. BUG-741 and BUG-744 (CDFIXTAGS, 62% alike): "CDFIXTAGS duplicate repair (HUNT Civil B finding E2, installed Civil 3.0.53)." / "CDFIXTAGS labels (HUNT Civil B finding E5, installed Civil 3.0.53)."
16. BUG-439 and BUG-448 (C1, 62% alike): "S-24 Opus finalizer findings (8 Oct, TRAIN_S24_FINALIZER_REPORT.md; GO at 37a99f27; no HIGH). T" / "S-26 Opus finalizer findings (9 Oct, TRAIN_S26_FINALIZER_REPORT.md): the train as assembled (35"
17. BUG-448 and BUG-548 (C1, 62% alike): "S-26 Opus finalizer findings (9 Oct, TRAIN_S26_FINALIZER_REPORT.md): the train as assembled (35" / "S-29 Opus finalizer findings (9 Oct, TRAIN_S29_FINALIZER_REPORT.md; GO at 68ace978 = the head t"
18. BUG-717 and BUG-735 (CDIMPORTXCIVIL, 60% alike): "CDIMPORTXCIVIL spot-level text (HUNT Civil B finding B8, installed Civil 3.0.53)." / "CDIMPORTXCIVIL, invert text at the wrong end (HUNT Civil B finding D6, installed Civil 3.0.53)."
19. BUG-690 and BUG-693 (PIT, 60% alike): "PIT placed on an existing pipe (inline split route) (HUNT Civil E finding G1, installed Civil 3" / "PIT placed on a pipe that has an arc (HUNT Civil E finding G4, installed Civil 3.0.51)."

(regenerate to see all.)

## 2. Release-blocker candidates (open entries that say BLOCKER, COLLEAGUE RELEASE GATE, PILOT-BLOCKER or HIGH)

Counts: BLOCKER 1, GATE 4, HIGH 216. The pilot is Mon 16 Nov 2026 with the cut-off Fri 13 Nov (desk continuity record); the desk's own lists are `areas/PILOT_CRITICAL_TEST_LIST_29OCT.md` and `areas/COLLEAGUE_READINESS_29OCT.md`, and they decide, not this list. The first group is the strongest:

1. **BLOCKER** (1): BUG-224 AutoCAD itself closing a drawing right after "Save As", on the install
1. **GATE** (4): BUG-495 COLLEAGUE RELEASE GATE CANDIDATE. HUNT2-S-01 (HIGH): Publish Issue (CE; BUG-496 COLLEAGUE RELEASE GATE CANDIDATE. HUNT2-S-02 (HIGH for colleagues): th; BUG-505 COLLEAGUE RELEASE GATE CANDIDATE. HUNT2-C-01 (HIGH): the X-Civil and L; BUG-517 HUNT3 3.1, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8 (MEDIUM; the printed sheet goe
1. **HIGH** (216 entries, ids only): 287, 290, 328, 333, 334, 335, 338, 340, 341, 342, 343, 346, 349, 350, 352, 353, 358, 362, 363, 366, 369, 371, 385, 391, 425, 428, 432, 433, 439, 441, 443, 444, 447, 450, 452, 456, 458, 467, 478, 497, 498, 499, 529, 534, 538, 539, 540, 544, 545, 548, 549, 550, 551, 552, 558, 561, 593, 594, 595, 597, 598, 603, 605, 610, 625, 635, 636, 638, 643, 649, 650, 652, 653, 654, 655, 659, 666, 667, 668, 674, 675, 676, 680, 681, 682, 683, 690, 691, 699, 700, 701, 702, 710, 719, 720, 721, 722, 723, 724, 730, 731, 732, 733, 734, 740, 742, 743, 756, 757, 758, 759, 779, 780, 781, 782, 783, 784, 785, 786, 787, 789, 790, 791, 808, 813, 818, 823, 824, 825, 826, 827, 829, 830, 862, 866, 867, 868, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 913, 914, 915, 916, 955, 963, 964, 965, 966, 967, 968, 969, 970, 971, 972, 973, 974, 975, 976, 977, 978, 979, 980, 981, 982, 983, 984, 985, 986, 987, 988, 989, 990, 991, 1040, 1041, 1051, 1052, 1053, 1056, 1064, 1067, 1068, 1080, 1081, 1088, 1095, 1096, 1097, 1098, 1099, 1135, 1136, 1137, 1183, 1184, 1188, 1189, 1190, 1192, 1196, 1199, 1209

## Limits of this first pass

1. **The duplicates list is weak.** Only 19 pairs came out, and many are separate numbered findings with the same wording (for example two ledger findings for the same command). None is a confirmed duplicate. A real duplicate check needs a person or an Opus read of the symptom, not the title.
2. **"HIGH" counts every open entry that contains the word,** including ones that say it about something else, so it over-counts. Use the desk's pilot lists to decide what blocks 9 Nov.
