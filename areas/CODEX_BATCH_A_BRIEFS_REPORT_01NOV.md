# Codex batch A briefs: written, not run (CE 02, Sun 1 Nov 2026 04:31)

## ANSWER FIRST

1. **Files written (four, all new, nothing overwritten):** `C:\Lisp Files\_CODEX_RUNNER\verifyA78_c88.txt` + `verifyA78_c88_full.txt`, and `verifyS467_c88.txt` + `verifyS467_c88_full.txt`. K1 untouched.
2. **A78 proves what a drafter must SEE of three C-78 fixes:** the Grade mismatch box (words, three buttons, Cancel / Esc / X draw nothing), plain RG on raingardens, and the short-pipe label on its leader.
3. **S467 proves BUG-467 and BUG-472 by screen and mouse:** braces with CLICKED points in a turned UCS (the open question), FPFC and R1 in a turned UCS, BTX on sheet text, C1 inside a viewport, REFEDIT.
4. **Launch lines:** `verifyA78_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6` with `-ReportGlob "CODEX_VERIFY_A78_*"`; `verifyS467_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6` with `-ReportGlob "CODEX_VERIFY_S467_*"`.
5. **Nothing was run:** no AutoCAD, no build, no Codex. An acad.exe was running at 04:20 (Tim's or the robot's); I touched nothing.

---

## 1. Installed build (read from the bundle DLLs, 04:20 Sun 1 Nov)

1. **Civil:** 3.0.88+3fbb9da5.
2. **Manager:** 1.1.88+3fbb9da5.
3. **Structural:** 1.0.125+204dfad2.
4. **Both briefs** name the build as WHATEVER IS INSTALLED (rule N14). Codex reads it first and writes it down. A different version is information, never a stop.

## 2. What each look proves

### verifyA78_c88 (one session, fixture DRV1_B1, 20 to 25 minutes)

1. **A78-01 Grade mismatch box and its Cancel (BUG-857, N33 family):** a 20 m pipe at Set my own 1 in 100 with levels 18.000 / 17.900. The words are pinned from source at 3fbb9da5: "Grade mismatch detected", the body ending "Cancel (or Esc, or the X) places no pipe.", and the buttons "Use 1 IN 200", "Keep 1 IN 100", "Cancel". Cancel must print "[CE] Grade mismatch box cancelled - no pipe placed. ..." and the object count must not change.
2. **A78-02 plain RG (B-007b, N90 family):** two raingardens drawn with the robot's CDRG chain, each zoomed so the 250 mm text is readable. PASS means each one shows exactly "RG" in its middle, with no RG2 or RG3.
3. **A78-03 short-pipe leader (D11, N20v87):** a 2 m pipe at 1 in 100, Label layout Auto. The two leader points are typed by hand, with one click allowed as a fallback. PASS means the arrow tip touches the pipe, the words are clear of the pipe and both level texts, and no description runs along the pipe.
4. **A78-04 Esc and the X on the Grade mismatch box:** the robot cannot do either. Each must behave like Cancel, with nothing drawn.

### verifyS467_c88 (one session, fixture DRV2_S1, 20 to 25 minutes)

1. **S467-01 BT1, AB and BB with CLICKED points (UCS Z 30):** the pixel pairs are 2400 mm apart along the turned X axis, worked out from SCREENSIZE. Codex takes drag-preview pictures in three directions and copies the "Preview length / rotation" lines. Each answer is written CLICKED SECOND POINT ALSO WRONG, or RIGHT. A World BT1 is run as the control.
2. **S467-02 FPFC in the turned UCS:** the pad should be centred on the click with its sides at 30 degrees. Codex screenshots the command line first, so a chain that goes out of step is caught.
3. **S467-03 R1 Point in the turned UCS:** pictures of the rubber band, and the RT1 tag inside the bay.
4. **S467-04 BTX on the sheet:** a test text is placed on the sheet and pre-selected (the worst case). The layout line must show and the text must survive.
5. **S467-05 C1:** on the sheet it must give the layout line; inside a viewport (Codex double-clicks in) it must ask for its point.
6. **S467-06 REFEDIT:** this runs because robot case S472b was BLOCKED (aS6). Codex presses OK in the Reference Edit window by hand. Each of BT1, C1 and BTX must print one REFEDIT line. The block is then closed without keeping changes.

## 3. How the briefs are built

1. **Copied word for word from verifyC1b_c86_full.txt:** the rules N1 to N17 and D1 to D12, with only "C1b" changed to the new look id. I checked this with a byte-for-byte compare (`cmp`) in both new files.
2. **Changes (a) to (i):** also copied. The one edit is in (i): the session is 20 to 25 minutes, and no new look starts after 30 minutes (C1b said 15 to 20 and 25).
3. **New lines added after (i):**
   1. **(j)** the current build numbers.
   2. **(k)** A78: typing in a CE window box. S467: clicked points are the test itself.
   3. **(l)** a driver cap of 70 calls instead of 40, because the START and END readings alone take about 25.
   4. **(m)** A78: the Grade mismatch box's standing Keep answer is replaced, and Enter is never pressed while the box shows (Keep is its default button). S467: the turned-UCS view rules.
4. **The word "follow":** it appears nowhere in the four files (checked with grep; BUG-421).
5. **Settings:** none are changed. The settings watch runs at start and end in both briefs.

## 4. What I could not confirm from paper

1. **Grade mismatch box:** that a 20 m pipe with no pits gives exactly 1 in 200 on screen. The robot's aC781r passed with this route, but nobody has seen it yet. The real words win (rule N7).
2. **Leader points:** that CE's leader prompts take typed points. The robot used clicks, and the Codex look G1 on 3.0.84 used an unknown route. One click is the written fallback.
3. **Remembered values:** that New Pipe keeps "Set my own" between runs. A78 sets every box itself each time.
4. **CD_RecentValues.json:** A78-03 places a pipe, which rewrites this file. It is not in the settings watch. The brief has Codex record its hash at start and end; **the desk must restore it after the run.**
5. **FPFC and PF7:** that the drawing remembers no size for mark PF7. If it does, the chain goes out of step and S467-02 is BLOCKED. The brief catches this on a screenshot.
6. **R1 settings save:** R1 rewrites the Structural CS_Settings.json (its last tag). Codex copies both CS_Settings.json files aside before the run and reports a hash change as a NOTE; **the desk restores from that copy.**
7. **Text on the sheet:** that a typed TEXT chain closes cleanly on the layout tab, and that the fixture's layout has a viewport. S467-05b becomes NOT TESTED if it has none.
8. **REFEDIT set-up:** the -BLOCK and -INSERT question order on AutoCAD 2027 is guessed, as in S472b. If the set-up fails, the brief marks it BLOCKED (set-up), not a CE fault.
9. **Pixel geometry:** that the drawing area height equals the second SCREENSIZE number. Codex measures it and writes both figures.
10. **Report name:** the job file asks for `C:\CE_PLAN\areas\CODEX_LOOK_STRUC_467_472_<date>.md`. Codex writes only `CODEX_VERIFY_S467_<stamp>.md`; the desk copies the results across.

## 5. How to launch (CE 00 / CE 02 desk, only inside the batch A window with STOP_CODEX lifted)

1. **A78:** `pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\launch_codex_retry.ps1 -Line "verifyA78_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6" -ReportGlob "CODEX_VERIFY_A78_*"`. The lock name comes out as Codex-A78.
2. **S467:** `pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\launch_codex_retry.ps1 -Line "verifyS467_c88|C:/Lisp Files/_TEST_COPIES_20260923|gpt-6.1-sol|low|90|6" -ReportGlob "CODEX_VERIFY_S467_*"`. The lock name comes out as Codex-S467.
3. **Order:** one at a time (one AutoCAD). The plan is K1, then A78, then S467. Each needs about 20 to 25 minutes of AutoCAD plus setup.
4. **Reports land in:** `C:\Lisp Files\_TEST_COPIES_20260923\CODEX_VERIFY_<id>_<yyyyMMdd_HHmm>.md`, with evidence in `...\LOOKS\<id>_<stamp>\`.

## 6. Not done here

1. No ledger, DESK_LOG, case, runner file or existing brief was edited.
2. No Codex run was started. Nothing was tested and nothing is accepted.
3. Scratch copies of the brief parts are in `C:\ce-fx\batchA_briefs_01nov\` (safe to leave).
