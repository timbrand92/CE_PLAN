# Carpark audit, chunk 21 of 21: BUG-1252 to BUG-1268 (Mon 2 Nov 2026, Melbourne time)

Read only. Nothing built, tested, run or changed except this file. This file replaces an earlier, garbled copy of itself (an earlier run had also reported the carpark as wiped; it was restored in commit f9d3d4fc, and I read it whole at 17,989 lines).

## FOR TIM

1. **Counts (17 entries):** FIXABLE-NOW 9, NEEDS-TIM 1, HAS-DRAFT 4, INSTALLED-WAITING-PROOF 1, UNCLEAR 2, DUPLICATE 0, ALREADY-FIXED 0, CLOSED 0.
2. **Pilot-critical items are already moving:** BUG-1255 (Excel export on AutoCAD 2027) is in the installed 3.0.88 and waits for proof; BUG-1257 (a test run rewrote your real Structural settings) has draft #1922; BUG-1268 (CDCALC Excel writes no file) has draft #1983, which makes the failure visible but does not find why Windows said "not saved".
3. **Fixable now, five most important (none is pilot-critical):** BUG-1253 (invert text lands on the pipe strip after a pit move), BUG-1258 (CDRULES and Project Review disagree on a pipe's speed limit), BUG-1260 (Structural support zip includes the login and PC name), BUG-1256 (cancel line says "pre-flight gate"), BUG-1261 (Manager support upload skips key files only by folder name).
4. **One question is yours:** BUG-1252, Monday question 19. Should a pipe label travel with its pipe when the pit moves (recommended), or stay where you put it?
5. **Drafts waiting for your AutoCAD check:** BUG-1262 (#1929, nothing ticked warns and plots nothing) and BUG-1267 (#1927, Recall Last then a new upstream level gives 19.40). Both are built and unit-tested only.

---

## The list

1. BUG-1252 | NEEDS-TIM | pilot-critical no | On hold for Tim's Monday question 19: keep the label travelling with its pipe end (recommended) or build it so a hand-placed label stays put; the carpark entry says nothing was built.
2. BUG-1253 | FIXABLE-NOW | pilot-critical no | Cause is named (a text's own pipe strip is never treated as keep-clear in LinkService.TextClashTidyUp.cs) and the expected result is stated; fix together with BUG-1034; no commit or PR found.
3. BUG-1254 | UNCLEAR | pilot-critical no | The carpark note says probably no fault (the same window passed at 08:57) and only Tim or a clean re-look closes it; a re-look in AutoCAD is missing.
4. BUG-1255 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix commits 96b87f73, 9a1f4e64, c137e78a and 0b8698eb (PR #1871, B-056) are in Civil/Manager 3.0.88 (C-78); I found no named acceptance in the ledger.
5. BUG-1256 | FIXABLE-NOW | pilot-critical no | Plain wording change to one closing line (drop "pre-flight gate"); no commit or PR found; the "or change the card" alternative is a wording call a builder can settle with the plain sentence.
6. BUG-1257 | HAS-DRAFT | pilot-critical yes | Draft PR #1922 (B-099, rel-20261102a) adds the missing redirects plus a guard test, per the carpark note; not merged and not opened in AutoCAD.
7. BUG-1258 | FIXABLE-NOW | pilot-critical no | Expected result is one shared speed-limit rule from the Settings value (6.0 m/s as shipped); it follows draft #1857 (B-011), so check #1857 is in the train first; no commit found.
8. BUG-1259 | UNCLEAR | pilot-critical no | The fix sits with the evidence-scan owner (areas\EV04_ISOLATION_REQUEST_30OCT.md), outside this repo, and I could not see whether the scans have been changed.
9. BUG-1260 | FIXABLE-NOW | pilot-critical no | Either remove the unreachable Structural zip or skip key and settings files by name and scrub login, PC name and drawing path; both options are spelled out; no commit found.
10. BUG-1261 | FIXABLE-NOW | pilot-critical no | Apply the same by-name skip as the zip (blob-config*, *.local.json, CE_SUITE folders) to the Manager upload; it follows B-063 (#1878), so check #1878 is in first; no commit found.
11. BUG-1262 | HAS-DRAFT | pilot-critical no | Draft PR #1929 (B-101, Structural line) implements Tim's decision 150 (warn, plot nothing, keep revisions, record "no sheets"); it fixes the OLDER window and overlaps drafts #721 and #1248.
12. BUG-1263 | FIXABLE-NOW | pilot-critical no | Expected result stated (show current values or say they are older than the drawing); LOW and rare; depends on draft #1880 (B-059) being in a train; no commit found.
13. BUG-1264 | FIXABLE-NOW | pilot-critical no | Expected result stated (clear or reload the pit list after such an Undo); LOW and rare; depends on #1880; no commit found.
14. BUG-1265 | FIXABLE-NOW | pilot-critical no | Merge the two near-identical rules into one and fix the comment at line 20; do it after #1866 and #1880 are both in a train; no commit found.
15. BUG-1266 | FIXABLE-NOW | pilot-critical no | Log one line per unreadable record per drawing and remember the read per drawing; LOW log noise; depends on #1880; no commit found.
16. BUG-1267 | HAS-DRAFT | pilot-critical no | Tim answered "5as recommened" (decision 122); draft PR #1927 (B-095, on the #1919 branch) works from the standard grade behind switch pipe.recallLastNewUpstreamUsesStandardGrade; built and unit-tested only.
17. BUG-1268 | HAS-DRAFT | pilot-critical yes | Draft PR #1983 (q11, B-157, switch excel.confirmCalcXlsxSaved) adds a "saved" message, a file check and a start folder; 18 of 18 new tests and 116 of 116 in the focused set on both lanes per areas\BUGFIX_q11_REPORT_01NOV.md; it does not find why Windows said "not saved".

---

## What I could not verify

1. **Draft PR status:** the `gh` command is not available in this shell, so I could not list or open #1857, #1871, #1878, #1880, #1922, #1927, #1929 or #1983. The PR numbers above come from the carpark notes and the q11 report, not from GitHub. Whether any has merged since is unknown.
2. **Release line:** `git fetch` ran, and origin/claude/rel-20261102a (3fbb9da5, the 3.0.88 C-78 commit) shows no commit mentioning BUG-1252, 1253, 1254, 1256 to 1268 by name. The drafts are therefore not on that line yet. The commits that matched "1252" to "1268" were unrelated merges (PR numbers) and were ignored.
3. **BUG-1255 proof:** I searched the ledger (areas\runner-reports\ledger.json) and found no entry naming BUG-1255; the only hits were run ids that happen to contain 1255. Whether the installed 3.0.88 has passed a Codex look is not proven.
4. **Nothing was seen in AutoCAD by me.** Every class is from reading the entries, notes, commits and reports.
