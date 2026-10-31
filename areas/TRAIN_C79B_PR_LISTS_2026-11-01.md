# Trains C-79b1 and C-79b2 (Civil + Manager): the PR lists, Sun 1 Nov 2026 (CE 01)

**What this is.** The second and third of the three follow-on assemblies after C-78 (CE 00's GO of Sat 31 Oct 22:15). C-79a is assembled (branch `claude/rel-20261106a`, head b8089300). **Each of these two sits on top of the one before it:** C-79b1 on `claude/rel-20261106a`, C-79b2 on C-79b1's branch (the assembler names it: next free branch letter). One assembly at a time. Heads below were read with `gh` at 00:30 on 1 Nov: the assembler reads them AGAIN at merge time and stops and reports if one moved. Source of the verdicts: the Opus pre-reviews in `areas\OPUS_PREREVIEW_*` (R, S, T, X, Y, Z, AB and the re-check where a PR is named in them). **#1969, #1970, #1972, #1965, #1967 and #1974 have NO Opus pre-review yet: CE 05 is running them on Team (CE 00, 00:20 Sun): the three b1 ones (#1969, #1970, #1972) must be in before b1 assembly starts; the b2 ones before b2.** No install, no version commit (the payload makes that). Rules as for C-79a: warn not block (R-27); Settings-first (R-00); nothing bypasses locked layers, Xrefs or REFEDIT; every new switch ships as the PR says; never close, retarget or delete a PR or branch; never mark a bug FIXED.

## C-79b1: the saved record, Undo, the Inspector and Edit Pipe (18 PRs, merge order; CE 00 allowed 18 at 00:20 Sun for the two small ones, #1922 and #1923)

Re-test class: area plus N91 (UserSettings.cs additive) and the record/Undo smoke cases; protected-file code is in this train (LinkService.Persistence.cs, ProjectDataService.Persistence.cs): the finalizer reads every write path.

0. **#1922 B-099 BUG-1257** (CE 00, 00:10 Sun: goes FIRST in b1, not in C-79a) Structural test runs on the Civil line write nothing into Tim's real CE folders; 16 files, mostly test projects (Modules/TestSupport and three test project files), head 7a3238a7, base claude/rel-20261102a. It protects Tim's real settings and logs. **The finalizer of this train confirms it changes no shipped DLL behaviour**; if it touches shipped behaviour beyond the old Structural copy's test redirect, it moves out of the train.
1. **#1868 B-019 BUG-1091** large-pipe minimum fall, head 38c3f825, base `claude/gb01-slice1-falls` (stacked on #1841, which is ALREADY IN the line: never merge #1841). Four files; keep both sides of the Settings file and the change log. Does nothing until Tim types the 1-in-N figure for 450 mm and larger gravity pipes. FIRST.
2. **#1891 B-071 BUG-1246** a copied downpipe gets its own next tag, head 4f21fc9d (stacks on #1867, which is in C-78). Touches the REDO-safe baseline file.
3. **#1892 B-070 BUG-1141** one unreadable pit or pipe record no longer stops CE remembering every pit's links, head 9545489c. Protected file LinkService.Persistence.cs; shares it with #1970 (merge #1892 first).
4. **#1940 B-121 BUG-1144** damaged saved outlet roles: one warning, a kept copy, Apply carries on, head c55494e0.
5. **#1943 B-121 BUG-1153** an unreadable LPD record gives one warning, head 62c8f363 (stacked on #1940; same files NetworkRedesign*).
6. **#1945 B-121 BUG-1158** CDDESIGN warns once when approved outlets were approved under another file path, head 7c31c33c (CivilDesignCommand.cs, also touched by #1874 in C-79b2). Tim's wording question on the folder-path comparison is still open (QUESTIONS): ships as the PR says.
7. **#1950 B-120 BUG-1152** a refused twin detention pipe upgrade puts the main line back, head 649df208.
8. **#1952 B-118 BUG-1070** Undo lifts the "cannot save over an unreadable record" hold, head 6845a095. Protected file ProjectDataService.Persistence.cs; Opus asked to read it again.
9. **#1880 B-059 BUG-1240** Inspector reads the saved drawing record when none is loaded, head 3f7ed338.
10. **#1951 B-127 BUG-1265** CDCHECK and the Inspector ask one shared rule for live-or-saved record, head d34c51b8 (stacked on #1880).
11. **#1953 B-127 BUG-1263** Inspector shows the newer list CE keeps for a drawing it could not save, head c6a04c9a (stacked on #1951, #1880).
12. **#1955 B-127 BUG-1264** Undo in drawing A clears CE's pit list after a pick in drawing B, head f5d89113 (stacked on #1953, #1951, #1880; touches LinkService.cs, ProjectDataService.cs and its Persistence file, shared with #1952 and #1944).
13. **#1958 B-127 BUG-1266** Inspector logs an unreadable saved list once per drawing, head 9d25604c (stacked on #1955 and the three before; LinkService.cs shared with #1955).
14. **#1969 B-119 BUG-1164** (review AC: KEEP-WITH-NOTE) Edit Pipe stores a typed level with a full stop on a comma-decimal PC, head 1d411b28 (switch ON).
15. **#1970 B-119 BUG-1157** (review AC: KEEP-WITH-NOTE, protected file, CE 05 says FULL: the finalizer sets the class) Edit Pipe says so when it could not write the level onto the pipe itself, head b3e76c82 (PipeEditCommand.Update.cs shared with #1969 and #1972; LinkService.Persistence.cs shared with #1892).
16. **#1972 B-119 BUG-658** Edit Pipe's downstream-recalculation question and cascade come after the change is accepted, head 556b3848. **Opus review AC (00:20 Sun): CHANGE-NEEDED, small; CE 05's job fx72 adds one fix commit to the PR branch. Merge it only after its head has moved from 556b3848.**
17. **#1923 B-110 BUG-430** double-click on a pit label stops AutoCAD's attribute editor first, switch `doubleClick.pitLabelStopsAttributeEditorFirst`. **LAST, and only if its shipped default is OFF** (Tim 22 Oct: until a Codex look). CE 05 owes a fix commit on the PR branch (job fx23, due soon); CE 05's fx23 fix is in: **new head 454e3eab, default OFF** (verified by CE 01 in the PR diff at 01:30: `PitLabelStopsAttributeEditorFirstDefault = false`; 6 files, 2 commits; it touches DoubleClickSettings.cs). Read the live head and the default in the diff at merge time anyway; if the head is not 454e3eab, or the default reads ON, do NOT merge it, say so in the report and carry on.

Stacked children are merged as their branch (the branch's base is its parent PR's branch, whose commits are already in the line by then). If a child's own diff would carry commits that are not its own, the assembler uses the net diff (cherry-pick of its own commits), never a merge of a branch whose history holds a dropped PR's commits.

## C-79b2: sizing, units, labels, windows and the long section (16 PRs, merge order; sits on C-79b1)

Re-test class: area plus N91; S1 for any changed shipped figure (#1960, #1965); the cover screens (#1897, #1920) and the Grade mismatch window (#1919, #1927) each need their own tool case.

1. **#1946 B-126 BUG-321** label text heights, offsets, arrow offset and pit hover radius read the drawing's units (metre drawings), head 8ef5e68e.
2. **#1944 B-126 BUG-296** rebuilt pit record matches saved pit data within 200 mm in the drawing's own units, head e5bccf42 (ProjectDataService.cs shared with #1955 in b1).
3. **#1960 B-120 BUG-80** one house-rule maximum-speed table for the connection pipe and the Edit Pipe grade strip, head 02d582e3 (CdCommand.GradeSuggestion.cs shared with #1897; SettingsSizingStandards.cs shared with #1868). CPAA 8 m/s against the house 6.0 is still Tim's question: ships as the PR says.
4. **#1965 B-133 BUG-539** Pump system and Rational tabs read the one roof-and-paved C in Settings, head 2f7549e6 (the live value is 0.9, told to CE 00).
5. **#1967 B-119 BUG-1235** the minimum-grade warning never prints the same figure twice, head ade56d0d.
6. **#1874 B-029 BUG-1096 with BUG-1098** CDDESIGN Rainwater reuse boxes and the Kingston credit, head 1b8b4af1, base is the OLDER `claude/rel-20261026z` (about 110 commits old): the assembler checks `git diff --stat` from the merge-base; if it carries more than its own 14 files, it takes its own commits only.
7. **#1954 B-120 BUG-1108** Manningham 2,000 L minimum tested against the reuse share, head da8e8f68 (stacked on #1874).
8. **#1956 B-120 BUG-1156** Save Draft keeps Design draft fields a newer build wrote, head 8b7ade95 (stacked on #1874).
9. **#1897 B-022 BUG-903** every cover screen reads the one minimum cover CDRULES uses, head b73618c3 (15 files).
10. **#1920 B-096 BUG-903** cover measured to the outside top of the pipe on Inspector, Civil Hub and repair check, head aba41924 (stacked on #1897; shares six files; InspectorPaletteService.cs also touched by the b1 Inspector stack).
11. **#1919 B-093** Grade mismatch window becomes one plain warning line, head d12f06d7 (CdCommand.cs and CdCommand.Grade.cs also touched by #1881, not here).
12. **#1927 B-095 BUG-1267** Recall Last, then a new upstream level, works from the standard grade, head 1732eb32 (stacked on #1919).
13. **#1937 B-115 BUG-1155** recreated Xref source reads SOURCE RECREATED, not SOURCE MISSING, head 99f4b09e. Read-only? The finalizer says plainly whether any path writes to an Xref. Assemble as net diff only (history trap).
14. **#1938 B-122 BUG-1193** a curved property boundary is followed along its curve in the long section, head 87104a99.
15. **#1939 B-122 BUG-765** the long section's ground line reads only level texts on a survey layer, head 209cc31d (LongitudinalSectionViewModel.cs shared with #1938).
16. **#1974 B-123 BUG-1175** CDSL and CDTRENCHGRATEAUDIT wording no longer names C:\Lisp Files, head 3993061a.

## Left for a third small assembly (C-79c) (CE 00, 00:20 Sun: b2 stays at 16)

1. **#1941 B-122 BUG-898** the import results page lists what was really drawn, head 9ec6f131, and **#1942 B-122 BUG-1256** closing the consultant import's schedule page prints a plain cancelled sentence, head 6733f165 (stacked on #1941; both in LinkCommands.ImportXcivil.cs and XcivilImportService.cs). #1926 (B-112, in C-79a) must be in the line first: it is.
2. **#1881 B-028 BUG-587** Pit Schedule row grows for a long lid and remarks note, head 72b032fa, base the OLDER line `claude/rel-20261026z`: GitHub counts 189 files only because the base is old; **CE 05's Opus net-diff review AE (areas/OPUS_PREREVIEW_AE_1881_NETDIFF_01NOV.md, 01:20 Sun): KEEP-WITH-NOTE, the real change is 10 files and 3 commits, the only clash is the top of the change log (keep both); rides C-79c, area plus smoke (Pit Schedule robot case N35_sched_row2 and its switch-off twin).** The assembler still checks the diff stat from the merge-base and falls back to its own 3 commits if it carries more.
3. **#1975 B-124 BUG-1253 + BUG-1034** (label's own pipe strip keep-clear) and **#1976 BUG-1161** (stacked on #1975; moved or flipped labels keep APPROX.): draft PRs from CE 05's batch 10, heads to be read at assembly; need an Opus pre-review first.

## Held for Tim or a document check (not in any of these trains)

#1948, #1961, #1963, #1964, #1966 (and #1968, #1971, #1973: council numbers need a document check), #1872 (B-018c follow-up owed), #1924 (Codex label look).

## Never

#1841 (already in the line since C-77), #1879 (stays open, unmerged), #1883 and #1817 (closed, branches kept).
