# Check room queue (CE_ACAD / check / 01)

**What this page is.** Every branch or mock-up waiting for its independent check, being checked, or given a verdict, with clock times (Melbourne). The gate is decision D-346: MERGE or HOLD; a blocker is only a wrong figure that could reach a sheet, an edit that could damage or lose drawing content, a breach of a hard limit, or a ruling built the opposite way. Kept by the check room only. Verdicts are in `VERDICTS\<branch>.md`; non-blockers per part in `FOLLOW_UP\`.

**Words used here.** "Checked on the bench" only. Whether a thing works in AutoCAD is the AutoCAD test room's word, from pictures.

**Opened:** Fri 20 Nov 2026, 11:06 am. Main line of `C:\CE_CIVIL` at 11:10 am: 22993fa.

## 1. Being checked now

1. **team/pipe-default at 741f0f2** (Stage 1 item A5: a pipe opens at the size of what it joins, else 100 dia.; never "Not known"; D-263). Handed over by the build room at 11:07 am as a re-check after its own HOLD (`C:\CE_WORK\scratch\team\check_a5_REPORT_1.md`, one blocker) and fix round 1. The branch is 5 commits behind main, so the suite is also run on the merged result.
   - **Honest check:** Team helper (opus), worktree `C:\CE_WORK\check\pipe-default_honest`, started 11:10 am.
   - **Adversarial pass:** Codex gpt-6.2-astra (xhigh), worktree `C:\CE_WORK\check\pipe-default_adv`, started 11:10 am.
   - **Fix rounds used:** 1 of 2.

## 2. Waiting (not yet handed to the check room)

The build room's word at 11:07 am: each is mid-fix after its own check and comes over one line each when ready. None is started before that.

1. **team/acad-windows** at 7d3cb97 (Stage 1 items A1 to A3). Build room's own check: HOLD, 1 blocker; fix round running.
2. **team/acad-pictures** at 8e16800 (the picture tool for tonight). Build room's own check: HOLD, 5 blockers; fix round running.
3. **codex/doorway** at 725338f (tests only). Codex review: HOLD on the list; a tests-only fix running.
4. **codex/c11-tests** at 11c6041. The tests job is still running.
5. **Mock-up `zero\pictures\pipe_top_preview_mockup.html`.** Build room's own check: FAIL narrowly; fix 4 running. To be checked against all 31 screen rules and the approved style, from a picture the check room takes itself.
6. **codex/tests-a7** at 90bbea2 and **codex/tests-a6b** (not yet made; rewritten to D-354 to D-359): tests-only; each comes when its report lands. codex/tests-a6 used the old brief and is ignored.

## 3. Not for the check room (merged before it opened, on the build room's own check)

1. **team/night-safety2** (f24fc2d), merged 10:57 am. Build room's Team opus check said MERGE: `C:\CE_WORK\scratch\team\check_ns2_REPORT.md` (seen by the check room: the file exists and says MERGE, no blockers).
2. **team/office-blocks** (2487bcf), merged 11:07 am. Build room's Team opus check said MERGE: `C:\CE_WORK\scratch\team\check_a4_REPORT.md` (seen: exists, says MERGE; it names a missing blocks file as an install blocker).
3. **Noted for the control room:** each of these two had one independent check. Whether an adversarial pass was also run on them is not known to the check room; D-346 asks for both.

## 4. Verdicts given

None yet.

## 5. Look log (the check room's own look at the branches, every 20 minutes)

1. **11:05 am:** first look. Six candidates listed; one merge to main found (night-safety2).
2. **11:10 am:** build room answered. One hand-over (team/pipe-default); main moved to 22993fa (office-blocks merged).
