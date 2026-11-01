# Carpark audit, chunk 21 of 21: BUG-1252 to BUG-1268 (Mon 2 Nov 2026, Melbourne time)

Read only. Nothing built, tested, run or changed except this file.

## FOR TIM

1. **WARNING FIRST: the live carpark file has been wiped.** C:\CE_PLAN\BUG_CARPARK.md is now 5 lines (one note repeated). Commits 20e999d3 and 5cd059e9 ("BUG-791 note") replaced the whole file. The last good copy is commit b498a968 (17,974 lines). I did not repair it (read only). Someone should restore it from b498a968 and re-add the BUG-791 note before anything else writes to it.
2. **Counts (17 entries):** FIXABLE-NOW 4, NEEDS-TIM 1, HAS-DRAFT 4, INSTALLED-WAITING-PROOF 1, UNCLEAR 7, DUPLICATE 0, ALREADY-FIXED 0, CLOSED 0.
3. **Fixable now, most pilot-critical first (only four exist, none is pilot-critical):** BUG-1253 (invert text lands on the pipe strip after a pit move, fix together with BUG-1034), BUG-1260 (Structural support zip leaks login and PC name), BUG-1256 (cancel line says "pre-flight gate"), BUG-1261 (Manager support upload skips key files only by folder name).
4. **Pilot-critical items are already moving:** BUG-1255 (Excel export on AutoCAD 2027) is installed in 3.0.88 and waits for proof; BUG-1257 (tests rewrote your real Structural settings) has draft #1922; BUG-1268 (CDCALC Excel writes no file) has draft #1983 that makes the failure visible but does not find why Windows said "not saved".
5. **One question for you:** BUG-1252, your Monday question 19. Should a pipe label travel with its pipe end when a pit moves (recommended), or should a hand-moved label stay where you put it?
6. **Not verified:** see the end of the file.

---

## Classification (one line per entry)

1. BUG-1252 | NEEDS-TIM | pilot-critical no | Open question 19: label travels with the pipe end (current, recommended) or hand-placed label stays put; no answer found in the entry.
2. BUG-1253 | FIXABLE-NOW | pilot-critical no | Cause note names the code (a text's own pipe strip is never treated as keep-clear in LinkService.TextClashTidyUp.cs); expected result is clear; do together with BUG-1034.
3. BUG-1254 | UNCLEAR | pilot-critical no | The CE 00 note says probably no fault (a scrolling list normally shows a part row; the same window passed at 08:57); needs a clean re-look or Tim's word to close, or a decision to fit the list to whole rows.
4. BUG-1255 | INSTALLED-WAITING-PROOF | pilot-critical yes | Fix #1871 (B-056, commits 0b8698eb, c137e78a, 9a1f4e64) merged into C-78 (Civil 3.0.88); the BUG-1268 entry says Pit Schedule Export Excel worked in Codex K1-01 and K1-03, but no ledger acceptance by name and Structural Excel not seen.
5. BUG-1256 | FIXABLE-NOW | pilot-critical no | Replace "Import aborted at pre-flight gate" with a plain cancelled sentence saying nothing was inserted; the entry states the wanted wording rule.
6. BUG-1257 | HAS-DRAFT | pilot-critical yes | Draft PR #1922 (B-099, rel-20261102a) adds redirects plus a guard test; a local branch pr/1922 exists; built and unit-tested only, and Tim's two Rebar flags question is still open.
7. BUG-1258 | UNCLEAR | pilot-critical no | The CDRULES side only exists in draft #1857 (B-011), which is not on rel-20261102a; the follow-up cannot be built until #1857 is in a train.
8. BUG-1259 | UNCLEAR | pilot-critical no | The fix belongs to the EV-04 scan owner (areas\EV04_ISOLATION_REQUEST_30OCT.md) and the scan scripts sit outside this repo, so I cannot say a builder could do it from the entry alone.
9. BUG-1260 | FIXABLE-NOW | pilot-critical no | Either remove the unused Structural support zip or skip key and settings files by name and scrub login, PC name and drawing path; the expected result is stated, and a test method is given.
10. BUG-1261 | FIXABLE-NOW | pilot-critical no | Apply the same by-name skip to the Manager upload that B-063 (#1878) applies to the zip; wording is exact in the entry (depends on the #1878 helper, which was not confirmed merged).
11. BUG-1262 | HAS-DRAFT | pilot-critical no | Tim answered "3yes" (decision 150); draft PR #1929 (B-101, Structural line) warns, plots nothing, keeps revisions, records "no sheets"; it fixes the older window and overlaps drafts #721 and #1248.
12. BUG-1263 | UNCLEAR | pilot-critical no | Follow-up to draft #1880, whose code (InspectorProjectSourceRule) is not on rel-20261102a; also the expected result allows two answers (current values or an "older than the drawing" line).
13. BUG-1264 | UNCLEAR | pilot-critical no | Same as BUG-1263: depends on draft #1880 which is not on the line.
14. BUG-1265 | UNCLEAR | pilot-critical no | Merge of two near-identical rules (#1866 and #1880); #1866 is merged (cf71af0d) but #1880 is not on the line, and the entry itself says do it after both are in a train.
15. BUG-1266 | UNCLEAR | pilot-critical no | Log noise from #1880 code, which is not on the line yet.
16. BUG-1267 | HAS-DRAFT | pilot-critical no | Tim answered "5as recommened" (decision 122): after Recall Last, a new upstream level works from the standard grade (19.40); draft PR #1927 (B-095) holds it behind a switch; built and unit-tested only.
17. BUG-1268 | HAS-DRAFT | pilot-critical yes | Draft PR #1983 (q11 / B-157, commit 4fcf82b4) makes CDCALC say "saved" or "not created", but q11's own report says why Windows returned "not saved" is NOT proven and the bug stays open.

---

## What I could not verify

1. **The live carpark file is damaged.** I read the entries from commit b498a968 (the last intact copy), not from the working file. Entries after that commit (if any) are not covered.
2. **Entry numbering.** The task says headings 1201 to 1217, but counting headings in the intact copy gives BUG-1252 as number 1202 and BUG-1268 as number 1218 (1,218 headings in all). I went by the ids you named, BUG-1252 to BUG-1268, all 17.
3. **Pull requests.** The `gh` tool is not installed in this session's shell, so I could not list or open pull requests. Draft status (#1922, #1927, #1929, #1983) comes from the carpark notes and the q11 report, plus local branch names for #1922 and #1929. I did not confirm whether any of them is open, merged or closed, or whether #1857 and #1880 are still open.
4. **The acceptance ledger.** I searched ledger.json for each BUG id and found no mention of any of the 17 (the file may key by case, not bug), so none shows an accepted pass by name.
5. **Cut-off text.** A few long Status and Note lines were shortened when I read them; I read the heads, the Status lines and the latest notes.
6. **Not run:** no code, no test, no AutoCAD, no robot. All evidence is read from the carpark, reports and git history.
7. **Structural line.** I did not check origin/claude/rel-20261026s for any of these.
