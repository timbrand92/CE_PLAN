# Robot case drafts, set 16: Detention, WSUD and council values (Mon 2 Nov 2026, read-only drafter, Sonnet)

## FOR TIM

1. **Result: 0 robot cases drafted, 0 twins.** All six fixes are BLOCKED-FOR-ROBOT. I did not write a case that would only come back BLOCKED or pass for the wrong reason.
2. **The brief was wrong on one point, and it matters.** It said all six were "already merged and installed". `gh pr view` shows #1810, #1811, #1801, #1806 and #1807 all still OPEN (not merged). Their switch names appear in no release branch I checked (`rel-20261102a` and `rel-20261026s` included). Only #1852 (BUG-1095) is merged, in `origin/claude/rel-20261102a` by "Merge PR #1852 (B-017 BUG-1095) at b531c85e". So five of the six are not in any build that can be installed yet.
3. **Why not even #1852.** Its result shows only in the CDCALC Boyd's tab, the CDDESIGN Results tab and the computations sheet notes. None of those prints to the command line or the CE log. The robot cannot type into those boxes.
4. **Codex-only (all six).** Numbered Codex looks are in section 4 below. Each one names the council, the numbers to type and what right looks like.
5. **Opus review before running:** none. No look touches Undo, REDO, a locked layer or an Xref.
6. **One safety note for the desk.** Looks 1 and 5 (CDWT) place a tank in the drawing. Run them on a copy only.
7. **Not verified:** the council set on the Example Job copy, the tank library contents, and the real window words. All come from the PR texts and the carpark, none from a run.
8. **Nothing for you to test or decide.**

---

## 1. What I read, built and tested

1. **Read:** `C:\TimOS\RULES.md`; `README_CASES.md`; the case R27 and the twin `variants\R09s_new_switch_off_broken.case.txt`; `gh pr view` and `gh pr diff` for all six PRs; the carpark entries for BUG-1102, 1110, 1111, 1103, 1115 and 1095; `CODEX_BUILD_BD23_26OCT.md` (the #1810 report); the CDWT source on `origin/claude/rel-20261102a`.
2. **Not read in full:** `ROBOT_CASE_DRAFTS_TOP12_30OCT.md` (first 200 lines only), `ROBOT_CASE_DRAFTS_WAVE1_02NOV.md` (not opened), `acad_driver_v3.allowlist.json` (not opened; I relied on the refused-button list in README_CASES.md), the BUGFIX reports other than BD23 and the BUG-1095 fix report (not opened), and the REGRESSION_LOG entries (only the part that arrived in the PR diffs).
3. **Searched:** the cases folder (including the `drafts_*` folders), `ledger.json` and the `ROBOT_CASE_DRAFTS_*.md` files. No case or draft names any of the six. The earlier search was right. `ledger.json` has no row for any of the six bug numbers. The only name hits in the cases folder were unrelated cases.
4. **Built:** nothing. **Tested:** nothing. **AutoCAD opened:** no. **Robot run:** no. **Files written:** this one.
5. **NOT proven:** every sentence in this file about what a window or command line prints comes from the PR text or the source diff. Nothing was seen on a run.

---

## 2. How the drafts were written

1. No case texts. The brief asks for a case only where a command line, a saved file or the CE log shows the result. For these six the result is in a window, on a drawing placement, or in a file the robot may not open.
2. The decision for each fix is in section 3, with the one-line reason.
3. I did not use the CDWT command-line route as a robot path. The source (`WaterTankCommand.cs` lines 85 to 135) shows the command line is only a fallback when the Civil Standard Details folder is not found or the tank window cannot open. The normal route opens the tank window first, and the window's choice buttons are not on the robot's press list. Forcing the fallback would mean changing the Standard Details folder setting, which is Tim's real settings. I did not go there.

---

## 3. Fix by fix

1. **#1810 (BUG-1102), underground detention warning: BLOCKED-FOR-ROBOT, and not yet in any build.** The warning prints after the CDWT choice. It needs Banyule set as the job council, a tank pick in the window, and it places a tank. Switch: `detention.detentionUndergroundShareWarning`, ships ON. A switch-off twin would be possible once installed, but without a first case there is nothing for it to twin.
2. **#1811 (BUG-1110), soft ground C and notes follow values used: BLOCKED-FOR-ROBOT, not yet in any build.** The change is in the CDDESIGN summary text, which sits in the Results tab. Switch: `detention.councilWarningsOnlyForUsedValues`, ON.
3. **#1801 (BUG-1111), before-development working shows the coefficients: BLOCKED-FOR-ROBOT, not yet in any build.** The text is in the CDRULEBOOK source viewer window. Switch: `detention.councilWorkingTextUsesNumbersInUse`, ON.
4. **#1806 (BUG-1103), Charged System millimetre warning: BLOCKED-FOR-ROBOT, not yet in any build.** Needs typing 150 into the Pipe diameter box of CDCALC and pressing Tab. The robot cannot type into that box. Switch: `detention.chargedDiameterSenseWarning`, ON.
5. **#1807 (BUG-1115), typed zero for CDWT detention: BLOCKED-FOR-ROBOT, not yet in any build.** The `Detention volume (litres) <1000>:` prompt is only on the fallback route (see section 2, item 3). Switch: `linking.cdwtTypedZeroDetentionIsKept`, ON. The PR itself says the full test suite comparison was blocked and it remains a draft.
6. **#1852 (B-017, BUG-1095), council minimum runoff C: BLOCKED-FOR-ROBOT, merged in `rel-20261102a`.** The new lines `[CE] council minimum C governs` and `[CE] Runoff C = 0.80 (calculated 0.70).` appear only in the Boyd's tab warning, the CDDESIGN results and the computations sheet. Switch: `detention.councilMinimumRunoffCApplied`, ON, read at start-up. This is the only fix where a twin could be written once a case exists: set `SETTING CD_Settings.json detention.councilMinimumRunoffCApplied false` before launch and expect C 0.70, not 0.80.

---

## 4. Codex looks

Evidence folder for every look: `C:\CE_WORK\codex\set16_<look number>\`. Use a copy of an Example Job drawing, never Tim's live drawing. Never accept or capture a folder that a file box opened in.

1. **Look 1 (#1810): Banyule, tank above ground.**
   1. Open a copy of an Example Job drawing. Set the job council to Banyule in the CDRULEBOOK or project setup.
   2. Type CDWT. In the tank window choose position AboveGround, pick a library tank that carries detention above 0 L, and press OK.
   3. **Right looks like:** the command line prints `[CE] Banyule requires 100 per cent of detention underground; the share above ground is 100 per cent.` and the placement continues.
   4. Repeat choosing Underground. **Right looks like:** no such line.
   5. Photograph the command line both times.
2. **Look 2 (#1810, CDDESIGN half).** On the same Banyule copy open CDDESIGN, fill the minimum to reach Results, and read the lines. **Right looks like:** `Banyule requires 100 per cent of detention underground; the share above ground is not recorded. Check the detention location.`
3. **Look 3 (#1811): Whitehorse soft ground C.**
   1. Set the council to Whitehorse and Settings soft ground C to 0.30.
   2. Open CDDESIGN to Results. **Right looks like:** no warning about the council's unused 0.35, and the summary names the 0.30 actually used from Settings.
4. **Look 4 (#1801): before-development working.** On a Whitehorse copy, run CDRULEBOOK and open the before-development C source. **Right looks like:** the working reads `(0.35 x pervious + 0.9 x impervious) / site`, not `0.3`.
5. **Look 5 (#1806): millimetre warning.**
   1. Type CDCALC and open the Charged System tab.
   2. Type 150 in Pipe diameter and press Tab. **Right looks like:** the results still show, with the warning `Pipe diameter 150 m is over 2 m. This box takes metres: type 0.15 for a 150 mm pipe.`
   3. Type 0.15. **Right looks like:** the warning is gone. Repeat with Downpipe dia 100 (warns) and 0.1 (quiet).
6. **Look 6 (#1807): typed zero.** Only possible on the command-line route. On a copy, run CDWT with the Civil Standard Details folder not found (the window cannot open). Choose a library tank carrying 1,000 L detention. At `Detention volume (litres) <1000>:` type 0. **Right looks like:** the tank is recorded as all reuse, 0 L detention. Then press Enter alone (keeps 1,000 L) and type 400 (stays 400).
7. **Look 7 (#1852): Darebin minimum C.**
   1. Set the council to Darebin. Type CDCALC and open the Boyd's tab. Enter catchment 600, impervious 400, pervious 200, permitted discharge 2.
   2. **Right looks like:** runoff C 0.80, with the warning `[CE] council minimum C governs` and `[CE] Runoff C = 0.80 (calculated 0.70).` shown, not cut off.
   3. Set `detention.councilMinimumRunoffCApplied` to false before AutoCAD starts and repeat. **Right looks like:** C 0.70, no council line.

---

## 5. Fixes skipped, and why

1. **All six.** None has a result the robot can read from the command line, the CE log or a saved file (section 3).
2. **Next step for the desk.** Draft robot cases for #1810, #1811, #1801, #1806 and #1807 only after each is merged into a train and installed. The brief's description ("already merged") should be corrected on the queue.
