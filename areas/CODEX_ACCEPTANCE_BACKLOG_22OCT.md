# Codex acceptance backlog, 22 Oct 2026 (desk plan/03 brief factory, Sonnet, about 21:20 to 23:00 Melbourne)

**What this is.** Every bug or plan item that is built and INSTALLED (Civil 3.0.70 / Manager 1.1.70, Structural 1.0.121), has a Claude robot PASS or is a window / picture the robot cannot judge, and has no Codex PASS yet. Each line says whether a typed route to the look is known, and which Codex brief (verifyW1_c60 to verifyW8_c60) carries it. Source: robot runs 35 to 47 (`CLAUDE_DRIVER_RUN*_V2_*.md`), the Codex reports V1 to V10, the train finalizer reports C-53 to C-60 and S-39 to S-41, and the REGRESSION_LOG entries of the 18 to 19 Oct fix batch. Four words kept apart: these items are built, mostly unit-tested, installed; none is Codex-accepted.

**Left out on purpose:** BUG-859 / 861 / 505 / 856 / 825 (already in V10 or V9b or accepted), BUG-141, 815, 820 totals, 854, 516 (already Codex-accepted), CDCHECKIGNORE and wrong-layer rows (V10), CEMEMBER hidden layer, LBUH / LBH, EBT (V9b), the CDS Advanced tab at 150 percent (needs a 1920 x 1080 screen; this PC is 5120 x 1440), and every Manager administrator item (parked by Tim). Note for the desk: the V10 run of 22 Oct 20:51 ended NOT TESTED on all five looks ("screen and mouse unavailable"), so a Codex run that cannot see the screen costs a brief; check the Codex screen tool before the conveyor feeds these.

## Ranked list (1 = release scope Civil + Manager first, then easiest proven route)

1. **W1-01 Edit Pipe cascade with U and REDO, changed pipes in view.** Plan items UX-LBL-02 and the cascade (BUG-782 / 797 are open and separate). Robot PASS every run 35 to 47; Codex V2-05 NOT TESTED. Route known: yes (robot run 47 plus V3-05 double-click). Group W1.
2. **W1-02 Quick MOVE of pit P3 opens no CE window, labels move with it, one U.** Robot PASS every run. Route known: yes (typed handle, proven by V3-01). Group W1.
3. **W1-03 CDSYNC leaves the Pit Schedule rows alone (BUG-855 header count REPORTED).** Robot PASS runs 31 to 46. Route known: yes (PITSCHEDULE window, Codex W14-02). Group W1.
4. **W1-04 CDTWL pick list names the highest obvert (BUG-777, #1411).** Built, switch ON by default, robot only saw the freeboard line. Route known: partly (prompts from V2b; the wording of the usual-rule line is not recorded; written as SEEN). Group W1.
5. **W1-05 Tag refusal words (BUG-814, #1429).** Robot PASS runs 34 and 35. Route known: yes (DP3 pair coordinates from the robot). Group W1.
6. **W2-01 Pit Schedule FROM column keeps the number of pit C1 (BUG-784, #1413).** Built, switch ON, never seen. Route known: yes (window read). Group W2.
7. **W2-02 Pit Schedule window marks only changed cells and never the pit size (BUG-791, #1425).** Window code; robot cannot judge. Route known: partly (cell colour read). Group W2.
8. **W2-03 Delete cell stays blank, never the word DELETE (BUG-783, #1412).** Window code. Route known: yes (right-click menu named in the entry). Group W2.
9. **W2-04 Opening and closing the Pit Schedule leaves no change and an undo step (BUG-817 REPORTED, open).** Route known: yes. Group W2.
10. **W3-01 to W3-05 CDCHECKS palette window: counts match, "unnamed pipe" names (BUG-753, #1387), Show where, CDCHECKCURRENT folds into Checks, Close.** Robot saw the typed list only; the palette rows are unreadable to the robot. Needs checks.checksCommandEnabled (one guard pass). Route known: yes (V4 / V8 / V10 pattern). Group W3.
11. **W4-01 to W4-05 Tidy labels with its switch ON: counts, Apply with Yes, one U puts every label back, REDO, the hand-placed label on a pit stays (UX-LBL-03, BUG-141 pit part).** Robot PASS 3.0.59 to 3.0.66; Codex accepted only the preview (V3-01). Needs linking.tidyLabelsEnabled (one guard pass). Route known: yes (V3-01 placement steps). Group W4.
12. **W5-05 CDCHECKCURRENT stays quiet with its defaults (#1514 quiet) and W5-06 the What CE Found panel closes without wiping your own selection (BUG-809 item 4, #1430).** Robot PASS for the quiet line; the panel selection was never seen. Route known: yes (typed handles, UsePickSet read from the code). Group W5.
13. **W5-01 and W5-02 CDCALC opens with the Older longitudinal tab still present, and the Profiles and Older longitudinal tabs open without drawing anything (BUG-758 window half, #1408).** Window look. Route known: yes (tab names read from CalculationsV2Dialog.xaml). Group W5.
14. **W5-03 and W5-04 the Older calculators tabs are read-only, and CDCALC closes with nothing changed.** BUG-772 (WSUD areas held to the site, #1428) itself is BLOCKED-by-design: the WSUD tab is read-only in this build, so no area can be typed. Group W5.
15. **(merged into 13 and 14).**
16. **W6-01 Manager window tabs readable (BUG-754, #1388), W6-02 About CE Suite window (CE_VERSION, BUG-852; V5-02 saw it clipped), W6-03 the Help and Module tabs fit, W6-04 theme as it stands.** Window looks only; no button that changes anything is pressed; no administrator item. Route known: yes (CEMANAGER typed, CE_VERSION typed). Group W6.
17. **W7-01 to W7-06 CEMEMBER: SI side elevation of a 310UB32, S alone refused, SE section front and beyond with a base point, Enter repeats with the last choices and Reset clears, one U after three members, Esc at each question (S-40, #1504 / 1505 / 1506).** Robot did the first question only. Route known: yes (read from CeMemberCommands.cs, installed 1.0.121). Group W7.
18. **W8-01 to W8-04 AD, LD and Q at DIMSCALE 50 (and 20, 100): text and arrows the same size on paper; QD dot (#1497, FollowAnyDrawingScale).** Robot did not run them. Route known: yes (typed points; the native DIMALIGNED / DIMLINEAR / QLEADER prompts). Group W8.

**Not briefed, with the reason (every one is BLOCKED-by-design until a route is proven):**

19. **BUG-416 right-click "CE: Select this run" with U and REDO.** Overlaps V10-05 (BUG-861); a pick and a right-click, the robot cannot. Left to V10-05.
20. **Pits marked To be removed (checks.leaveOutRemovedPits) and the callout that goes out with its leader (TidyLeaderOut), both OFF.** Both ship OFF, no typed way to mark a pit To be removed is recorded, and the key path for the guard is not recorded. Needs the desk to read the code first.
21. **BUG-786 / 787 / 798 / 792 drawn Pit Schedule table items.** Need the drawn table placed (no typed route recorded for placing it). Needs a route first.
22. **BUG-709 CDSURVEY multi-line levels (ships OFF), BUG-683 same-plan break "More..." button.** Need a survey source drawing / a New Pipe button the robot could not press. Fixtures wanted.
23. **BUG-767 / 756 / 757 / 761 / 768 to 770 CDPROFILE long section pictures.** Need a route through the CDPROFILE review window; none recorded.
24. **BUG-522 start-up copies check with mismatched copies.** Needs a deliberately broken install; never on Tim's PC.
25. **BUG-837 / 838 / 834 / 832 installer and update items.** Administrator and update path: parked by Tim.
