# BUGFIX ff2017b report, 4 Nov 2026 (CIVIL-OFF-3, PR 2017 wording fix)

## FOR TIM
1. **What you will see differently:** an older project left as it is now says "Older project, UPGRADE NEEDED. Nothing in this drawing has been changed. Civil is OFF in this drawing. Upgrade it or turn Civil ON." The line after "Leave it as it is" ends with the same sentence. Neither line mentions CDDISCIPLINE any more.
2. **Nothing else changed:** same banner switch (`options.olderProjectBanner`, Default: on), same rules, no new writes, so REDO cost is unchanged.
3. **Mistakes of my own:** my first test run used a hidden window and showed no output, and an early retry hit a locked file. Both were my run set-up, not the code; the third run was clean.
4. **NOT proven:** nobody has opened this in AutoCAD. No bug is marked fixed. The ribbon button is not part of this PR.
5. **Robot case that would prove it (not written or run):** open an older project marked Civil OFF, type nothing, read the command line. It must contain "Civil is OFF in this drawing. Upgrade it or turn Civil ON." and must not contain "CDDISCIPLINE". Control: set `options.olderProjectBanner` false, reopen: no banner line.
6. **A real file changed during the run:** `%APPDATA%\CE_CADTOOLS\CE_Admin\sessions\CE_SUITE_MANAGER.json` (228 bytes, last-write moved 23:28 to 23:50). I ran no Manager code and my tests ran with the log, TEMP and TMP overrides, so I believe Tim's or another session's Manager wrote it. Flagging per the isolation rule.

## Technical
1. **PR:** 2017 (draft, base claude/civil-off-2). One extra normal commit eb920bbe pushed to claude/civil-off-3 (3c76b8ac then eb920bbe). No force-push, no retarget, no new PR.
2. **Files:** `Modules/Drainage/Services/OldProjectPolicy.cs` (BannerLine, LeftAsItIsLine), `Modules/Drainage.Tests/Services/CivilOff3Tests.cs` (wording test now pins the card sentence and asserts CDDISCIPLINE absent from both lines; the AutoCAD 2027 assertion removed), `REGRESSION_LOG.md` (item 1 text updated, item 7 added). CE_SHARED untouched.
3. **Tests:** net10 Drainage.Tests, filter CivilOff1/2/3Tests: 82 total, 82 passed, 0 failed. Settings default pins untouched (switch unchanged). net48 compile of Modules/Drainage: 0 errors.
4. **Isolation listings:** before 36,996 files, after: one difference, the Manager session file above. No TIM_CE_CADTOOLS, CE_STRUC_SUITE or CE_CVL_SUITE file changed. Listings in C:\CE_WORK\scratch\ff2017b\before.txt and after.txt (removed with the scratch folder; the numbers are above).
5. **Base note:** reviewed on the PR's own branch, not master (master 650c0c19 has no Civil quiet-mode code).
