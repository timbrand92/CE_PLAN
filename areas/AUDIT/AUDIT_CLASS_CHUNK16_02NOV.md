# Carpark audit, chunk 16 of 21: BUG-951 to BUG-1010 (60 entries)

Written Mon 2 Nov 2026 (Melbourne), Sonnet, read-only. Checked against origin/claude/rel-20261102a (Civil/Manager) and origin/claude/rel-20261026s (Structural), after a git fetch.

## FOR TIM

1. **Counts:** 60 entries. 45 ALREADY-FIXED (fix is merged on a release line, but not proven in AutoCAD), 9 HAS-DRAFT (fix written on its own branch or PR, not on the release line), 4 NEEDS-TIM, 2 FIXABLE-NOW, 0 duplicates, 0 closed, 0 unclear.
2. **Biggest finding:** the carpark still says OPEN on all 60. Fifty-four of them already have a fix written, so the carpark is out of date, not the code.
3. **Class meaning:** ALREADY-FIXED here means the fix is merged into the release line. It does not mean installed, and it does not mean tested in AutoCAD.
4. **Pilot-critical FIXABLE-NOW:** none. The only two FIXABLE-NOW are BUG-958 (Remember window position does nothing on four windows) and BUG-959 (Civil Hub jumps back from the second monitor). Both are MEDIUM and neither is pilot-critical.
5. **NEEDS-TIM (4):** BUG-952 (confirm the member-size rule), BUG-954 (which scale rule for the library hatches), BUG-989 (spine rollback: keep identities or refuse), BUG-1006 (replacement wording for the speed advice).
6. **Pilot-critical, still not on a release line:** BUG-972 (Sheets preview saves the drawing) and BUG-976 (Notes file overwrite), both drafts.

## HOW I CLASSED

- **Read:** every entry in the carpark, from its Symptom to its last Status line and notes.
- **Checked:** git history on both release lines for each BUG number, whether each fix commit is an ancestor of the release line, and the list of remote branches and pr/NNN refs.
- **Pilot-critical yes** means HIGH severity, wrong engineering numbers, or lost or overwritten data.

## ENTRIES

1. BUG-951 | HAS-DRAFT | pilot-critical no | Fix be6e198f is on branch claude/tl2-r501-bug951-tag-heights only, not on the Structural line.
2. BUG-952 | NEEDS-TIM | pilot-critical no | Tim's 29 Oct ruling is open to two readings (is "dimscale = 120" really 20; CEMEMBER to follow the old SBEAM rule), and the entry says to show him a picture first; no build found.
3. BUG-953 | HAS-DRAFT | pilot-critical no | Fix 602bc901 is on pr/1592, not on the Structural line.
4. BUG-954 | NEEDS-TIM | pilot-critical no | Which scale rule each fixed hatch pair follows is Tim's choice; only a coverage note was found.
5. BUG-955 | ALREADY-FIXED | pilot-critical no | Commit 22d1f3ed is on the Structural line (rel-20261026s).
6. BUG-956 | ALREADY-FIXED | pilot-critical no | Commits 69fc3269 and d1779258 are on the Structural line.
7. BUG-957 | ALREADY-FIXED | pilot-critical no | Commit 78a2303f is on rel-20261102a.
8. BUG-958 | FIXABLE-NOW | pilot-critical no | Expected behaviour is plain, the file and line are named, and no commit or branch for it exists.
9. BUG-959 | FIXABLE-NOW | pilot-critical no | Expected behaviour is plain, the files are named, and no commit or branch for it exists.
10. BUG-960 | ALREADY-FIXED | pilot-critical no | PR #1690 is merged (a39b638b) on rel-20261102a, with palette pictures recorded.
11. BUG-961 | HAS-DRAFT | pilot-critical no | Commit 13b95ef8 is on pr/1691 (cx2/bug-961-manager-fields); the carpark names #1527, which is out of date.
12. BUG-962 | ALREADY-FIXED | pilot-critical no | PR #1980 (4b03038b) is merged on rel-20261112a, but it is not on rel-20261102a.
13. BUG-963 | ALREADY-FIXED | pilot-critical yes | Merged on rel-20261102a (ea752acf, 111b8e0a), with a new switch default ON.
14. BUG-964 | ALREADY-FIXED | pilot-critical yes | PR #1669 merged (d361f797) on rel-20261102a.
15. BUG-965 | ALREADY-FIXED | pilot-critical yes | Merged on rel-20261102a (c73df761, 92e83fa5, ea752acf).
16. BUG-966 | ALREADY-FIXED | pilot-critical yes | Commit 04fae248 is on rel-20261102a.
17. BUG-967 | ALREADY-FIXED | pilot-critical yes | Test and proof commits (c6f550c6, 6a4790f9) are on rel-20261102a; I did not find the fix commit itself by number, so check it before trusting this.
18. BUG-968 | ALREADY-FIXED | pilot-critical yes | Commit ffd8e500 is on rel-20261102a.
19. BUG-969 | ALREADY-FIXED | pilot-critical yes | PR #1692 merged (c0706e5e) on rel-20261102a.
20. BUG-970 | ALREADY-FIXED | pilot-critical yes | Commits 2fb1ff7c and 2bd5c2be are on rel-20261102a.
21. BUG-971 | ALREADY-FIXED | pilot-critical yes | PR #1658 merged (f007893b) on rel-20261102a.
22. BUG-972 | HAS-DRAFT | pilot-critical yes | Commit 2829c47a is on pr/1572, not on the Structural line.
23. BUG-973 | ALREADY-FIXED | pilot-critical yes | PR #1568 merged (8fc66fec) on the Structural line.
24. BUG-974 | ALREADY-FIXED | pilot-critical yes | Commit cecf3506 is on the Structural line.
25. BUG-975 | ALREADY-FIXED | pilot-critical yes | PR #1564 merged (c4768031) on the Structural line.
26. BUG-976 | HAS-DRAFT | pilot-critical yes | Commit 2fbfef93 is on pr/1560 (tl2-r501-bug976-notes-overwrite), not on the Structural line.
27. BUG-977 | ALREADY-FIXED | pilot-critical yes | PR #1563 merged (3e23cd99) on the Structural line.
28. BUG-978 | ALREADY-FIXED | pilot-critical yes | PR #1566 merged (a9d64a24) on the Structural line.
29. BUG-979 | ALREADY-FIXED | pilot-critical no | PR #1559 merged (b04f72dc) on rel-20261102a.
30. BUG-980 | ALREADY-FIXED | pilot-critical no | PR #1561 merged (7a62f39e) on rel-20261102a.
31. BUG-981 | ALREADY-FIXED | pilot-critical no | PR #1631 merged (fb15c3f3) on rel-20261102a.
32. BUG-982 | HAS-DRAFT | pilot-critical no | Commit 18c6393e is on pr/1643, not on rel-20261102a.
33. BUG-983 | ALREADY-FIXED | pilot-critical no | PR #1574 merged (a25bd244) on the Structural line.
34. BUG-984 | HAS-DRAFT | pilot-critical no | Commit d7299d1e is on pr/1579, not on the Structural line.
35. BUG-985 | ALREADY-FIXED | pilot-critical no | PR #1575 merged (be1a5e98) on the Structural line.
36. BUG-986 | ALREADY-FIXED | pilot-critical no | PR #1581 merged (e490038a) on the Structural line.
37. BUG-987 | ALREADY-FIXED | pilot-critical no | Commit 5ca3f08f is on rel-20261102a.
38. BUG-988 | ALREADY-FIXED | pilot-critical no | PR #1642 merged (746a55e4) on rel-20261102a.
39. BUG-989 | NEEDS-TIM | pilot-critical no | Does Rollback keep the permanent identities and undo the rest, or refuse with a plain line? The entry says it needs Tim's word; only a coverage note exists.
40. BUG-990 | HAS-DRAFT | pilot-critical no | Commit 9c7953ce is on pr/1620, not on rel-20261102a.
41. BUG-991 | ALREADY-FIXED | pilot-critical no | PR #1618 merged (9476b85e) on rel-20261102a.
42. BUG-992 | ALREADY-FIXED | pilot-critical no | PR #1640 merged (3b14fc3a) on rel-20261102a.
43. BUG-993 | ALREADY-FIXED | pilot-critical no | PR #1583 merged (7114f63a) on rel-20261102a.
44. BUG-994 | HAS-DRAFT | pilot-critical no | Commit 8ae9c2f3 is on pr/1588, not on rel-20261102a.
45. BUG-995 | ALREADY-FIXED | pilot-critical no | PR #1599 merged (5cf293b6) on rel-20261102a.
46. BUG-996 | ALREADY-FIXED | pilot-critical no | PR #1641 merged (eb906d15) on rel-20261102a.
47. BUG-997 | ALREADY-FIXED | pilot-critical no | PR #1627 merged (b0c6a305) on rel-20261102a.
48. BUG-998 | ALREADY-FIXED | pilot-critical no | PR #1626 merged (6731077a) on rel-20261102a.
49. BUG-999 | ALREADY-FIXED | pilot-critical no | Commit 330ee22f is on rel-20261102a; it says "could not solve" in plain words.
50. BUG-1000 | ALREADY-FIXED | pilot-critical no | PR #1607 merged (208029d0) on rel-20261102a.
51. BUG-1001 | ALREADY-FIXED | pilot-critical no | PR #1601 merged (e7c42c99) on rel-20261102a.
52. BUG-1002 | ALREADY-FIXED | pilot-critical no | PR #1616 merged (47284178) on rel-20261102a.
53. BUG-1003 | ALREADY-FIXED | pilot-critical no | PR #1565 merged (be16a462) on rel-20261102a.
54. BUG-1004 | ALREADY-FIXED | pilot-critical no | Commit e0397253 is on rel-20261102a.
55. BUG-1005 | ALREADY-FIXED | pilot-critical no | PR #1628 merged (db942f59) on rel-20261102a.
56. BUG-1006 | NEEDS-TIM | pilot-critical no | What replacement advice should the too-slow and too-fast pipe warnings give? The entry says it is Tim's engineering call; only a "held" note exists.
57. BUG-1007 | ALREADY-FIXED | pilot-critical no | PR #1573 merged (261e4f96) on rel-20261102a.
58. BUG-1008 | ALREADY-FIXED | pilot-critical no | PR #1569 merged (ba6cd492) on rel-20261102a.
59. BUG-1009 | ALREADY-FIXED | pilot-critical no | PR #1614 merged (ed399bfc) on rel-20261102a.
60. BUG-1010 | ALREADY-FIXED | pilot-critical no | PR #1580 merged (fc978c23) on rel-20261102a; the "does the first idle 5 minutes count" billing question is a separate Tim ruling that the fix leaves alone.

## WHAT I COULD NOT VERIFY

1. **Installed or proven:** none of these was tested in AutoCAD by me. I did not check which build is installed. The ledger (runner-reports\ledger.json) holds no BUG numbers in this range, so no ledger PASS could be matched. Nothing here is INSTALLED-WAITING-PROOF for that reason: I could not tell.
2. **gh was not on the PATH.** I used git branches and pr/NNN refs instead. The PR numbers above come from commit text and branch names; I did not confirm PR state (open, merged, closed).
3. **BUG-967:** only the test and proof commits turned up by number. I did not read the fix itself.
4. **BUG-951:** the branch exists, but I found no PR number.
5. **BUG-958 and BUG-959:** a keyword search of the line found no fix. A fix could exist under another wording.
6. **BUG-962:** the fix is on rel-20261112a, a branch name later than the one named in the brief. It is not on rel-20261102a.
7. **Numbering:** the brief counts headings 901 to 960 from the top, but the 901st heading in the file is BUG-950. I went by the ids BUG-951 to BUG-1010, as the brief says.
8. **Merged is not proven:** several fixes (for example BUG-957, 987, 999, 1004) were found only as commits, with no PR number seen.
