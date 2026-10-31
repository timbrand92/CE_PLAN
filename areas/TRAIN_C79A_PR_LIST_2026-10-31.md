# Train C-79a (Civil + Manager): the PR list, Sat 31 Oct 2026 (CE 01)

**What this is.** The first of three follow-on assemblies after C-78 (CE 00's GO of Sat 31 Oct 22:15: C-79a, then C-79b1, then C-79b2). Small PRs: area test plus the start-up smoke (N91). Base `origin/claude/rel-20261102a` at `3fbb9da5` (C-78, Civil 3.0.88 / Manager 1.1.88, INSTALLED). Branch to create: `claude/rel-20261106a`. **No install, no version commit (the payload makes that).**

**Source of the verdicts:** Opus pre-reviews R, S, T, X, Y, Z and the final re-check (`areas\OPUS_PREREVIEW_*_31OCT.md`), all KEEP or KEEP-WITH-NOTE with the fixes pushed. Heads below were read with `gh` at 22:30 on 31 Oct: read them AGAIN at merge time and stop and report if one moved unexpectedly.

## Members, in merge order (24 PRs)

1. **#1884 B-062** test isolation, head f9fa356c. Expect its new Civil settings-file guard to go RED on the first full run (a real lead, not a faulty test; the real Civil settings file changed twice during test runs on 30 Oct).
2. **#1922 B-099** (partner of #1884), head 7a3238a7. Changes the OLD Structural copy that sits on this line, so tests run from a Civil-line worktree cannot touch Tim's real log or outbox.
3. **#1882 B-069 BUG-1093** lid at RL 0.000 / comma lid, head 84d5a659 (clashes: REGRESSION_LOG.md).
4. **#1887 B-069 BUG-1092** 1 mm uphill (markup route keeps its 1 mm limit), head 0d5e3d98 (REGRESSION_LOG.md).
5. **#1888 B-072 BUG-1195** pipe label angle in a turned UCS, head 0b40e4af.
6. **#1889 B-067 BUG-1237** CDRENUMBER wording, head ff36dbeb.
7. **#1890 B-067 BUG-1071** "Not saved" wording, head 5e8e208f.
8. **#1896 B-074 BUG-1218/1220** Help pages, head 6c6f0db1.
9. **#1857 B-011** #1788 extras (comma figure refused, unset material speed), head 718ec21c, base is the OLDER claude/rel-20261026z: it adds 3 commits and 17 files over the C-78 line (checked).
10. **#1875 B-025 BUG-816** After-MOVE label tidy own Settings row, head 107a6a74, same older base: 3 commits, 13 files (checked).
11. **#1876 B-058 BUG-1247** Updates & Rollback opens the drafter's own Updates screen, head d30041c4 (Manager; PluginManagerCommands.cs).
12. **#1936 B-116 BUG-1244** CE Tools Refresh result line, head 4ebf367a: SAME FILE as #1876 (PluginManagerCommands.cs), keep both sides.
13. **#1935 B-116 BUG-1172** Manager start-up line says Net8 on 2025/2026, head d49842fe.
14. **#1877 B-061 BUG-1112** WSUD export prints "not entered", head b9842f28 (clashes with the #1892 switch block later; #1892 is not in this train).
15. **#1878 B-063** CESUPPORT zip never takes a key or local settings file by name, head a9a0a4f5.
16. **#1923 B-110 BUG-430** double-click on a pit label stops AutoCAD's attribute editor first (switch `doubleClick.pitLabelStopsAttributeEditorFirst`): **its shipped default MUST be OFF** until a Codex look (Tim, 22 Oct). Read the default in the PR diff; if it is ON, STOP and report. Head e3dfb957.
17. **#1925 B-113 BUG-788** two Save As Xrefs read separately (existing switch), head 8b7ee79b.
18. **#1926 B-112 BUG-505** CHECK THE SCALE warning on the X-Civil import window, head f0b98291. (#1941 and #1942, later trains, contain this PR's head: it must be in the line first.)
19. **#1947 B-130 BUG-685** note when a typed level is held to the nearest 10 mm, head b2ecdfb3.
20. **#1949 B-130 BUG-907** outlet pipe top above inlet pipe top at a pit, head 8a16a42e.
21. **#1962 B-131 BUG-1094** Inspector shows a flatter-than-minimum pipe in red, head 7f7bc477.
22. **#1959 B-129 BUG-1214** CDASK From file picker on AutoCAD 2022 to 2024, head d7c1e154 (a first test run showed 1 failed of 47, name hidden, did not recur: run that test class several times and capture the failing name).
23. **#1957 B-129 BUG-1211** CDMENU and Repair check the Civil menu is really loaded (2022 to 2024), head 4e1574d6 (clashes in intent with open draft #599, which is NOT in this train).
24. **#1928 B-094** colleagues' fresh logins start New Pipe in Custom 1 in 100 (shipped starting settings), head 22766c90. LAST: it changes shipped defaults. Re-test class: its own tool plus Settings smoke S1.

## NOT in C-79a (do not merge)

- **CORRECTED 31 Oct 22:50 (CE 01, after Opus review AB):** my first note said #1868 (B-019) was held because #1841 (B-042) was unreviewed. WRONG: #1841 is ALREADY IN the line (an ancestor of 3fbb9da5; it shipped in C-77) and had Opus review B on 29 Oct; its GitHub page is open only because trains merge without closing pages. **#1841 must NEVER be merged again in any train.** **#1868 (B-019, head 38c3f825, KEEP-WITH-NOTE, area plus smoke) can ride a C-79 assembly; the C-79a assembler had already passed its merge step when this was found, so #1868 goes FIRST in C-79b1** (two keep-both clashes: the Settings file and the change log; it does nothing until Tim types the 1-in-N figure for 450 mm and larger gravity pipes).
- **C-79b1 / C-79b2 (later):** #1891, #1892, #1940+#1943, #1945, #1946, #1950, #1952, #1955, #1960, #1881; #1874 (+#1954, #1956), #1880+#1951+#1953+#1958, #1897+#1920, #1919+#1927, #1937, #1938, #1939, #1941+#1942, #1944, #1965, #1967.
- **Held for Tim or a document check:** #1948, #1961, #1963, #1964, #1966, #1872, #1924.
- **Structural** PRs (#1885, #1895, #1898 to #1916, #1918, #1921, #1929 to #1934 and so on): a separate S-train from `claude/rel-20261026s`, NOT here.
- **Closed or reference only:** #1879, #1817, #1883. #1717, #1767, #599, #721, #1248: older-line drafts, not here.

## Rules for this assembly

Warn, not block (R-27); Settings-first (R-00); nothing bypasses locked layers, Xrefs or REFEDIT; every new switch ships as the PR says (ON for a fix, OFF for a diagnostic, #1923 OFF); never close, retarget or delete a PR or branch; never mark a bug FIXED; new work folders under `C:\CE_WORK\build` (Tim, 31 Oct).
