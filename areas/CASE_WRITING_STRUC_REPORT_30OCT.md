# Case writing report, Structural: BUG-467 and BUG-472 (CE 02 case writer, Opus, Fri 30 Oct 2026)

## ANSWER FIRST

**Twelve robot cases are written and all twelve pass the offline check (12 files checked, 0 invalid). None has been run in AutoCAD.**

1. **What they prove:** two fixes that are ALREADY INSTALLED in Structural 1.0.125. BUG-467 (rotated UCS) came in with HUNT-S-02 (PR #879) and BUG-472 (layout tab and REFEDIT) with HUNT-S-07 (PR #887). A passing case proves the installed fix works in AutoCAD; a failing case means it does not.
2. **The brief was wrong about the drawing.** It said the robot has no Structural copy. It has one: `C:\ce_rc_drv\DRV2_S1.dwg` (SHA-256 starts 950AFDF6E523, four pads PF1 to PF4, a footing schedule). Robot run 2 already ran BT1 on it on 9 Oct. Every case uses it, so no new drawing is needed.
3. **Six cases are proofs and six are "broken twins"** that claim the old fault and must FAIL on 1.0.125. The twin failing is the proof that the case can tell good from bad.
4. **One Codex look brief is written** for what must be seen with the mouse (the drag preview, the R1 rubber band, BTX on a sheet text).

---

## FOR TIM

1. **Nothing for you to do now.** These are robot cases for the free AutoCAD windows (after 5:30 pm). Nothing was built, installed or run.
2. **What the robot will check, in drawing terms:**
   - Turn the UCS 30 degrees. Type BT1, AB, BB, R1 (Point picks) and FPFC with typed points. Each brace, tag and pad must land where the typed points really are, not at the raw numbers 9 to 10 m away.
   - Back in World UCS, BT1 gives the same 2400 mm brace at 30 degrees.
   - On a layout tab (paper space), BT1, C1 and BTX each print one plain line ("You are on a layout tab (paper space), so CE drew no bracing truss. Go to the Model tab, or double-click into a viewport, and try again.") and draw nothing.
   - The same three commands inside REFEDIT print "A block or Xref is open for in-place editing (REFEDIT), so CE ... Close it (REFCLOSE) and try again."
3. **What a Codex look must see** (the robot cannot): the drag line follows the cursor in the rotated UCS; the R1 rubber band starts at the first click; the FPFC pad sits square to the rotated UCS; BTX on a text sitting on the sheet leaves that text on the sheet.
4. **The bug entries stay OPEN.** Nothing is FIXED until the cases pass (twice) and are reviewed, or until Codex or you see it.

---

## Files written

1. `C:\Lisp Files\_ACAD_DRIVER\cases\drafts_struc_30oct\S467a_bt1_rotated_ucs_proof.case.txt` (CASE S467a_bt1_ucs30_proof)
2. `...\drafts_struc_30oct\S467a_bt1_rotated_ucs_BROKEN.case.txt` (S467a_BROKEN)
3. `...\drafts_struc_30oct\S467b_ab_bb_rotated_ucs_proof.case.txt` (S467b_ab_bb_ucs30_proof)
4. `...\drafts_struc_30oct\S467b_ab_bb_rotated_ucs_BROKEN.case.txt` (S467b_BROKEN)
5. `...\drafts_struc_30oct\S467c_r1_point_rotated_ucs_proof.case.txt` (S467c_r1_point_ucs30_proof)
6. `...\drafts_struc_30oct\S467c_r1_point_rotated_ucs_BROKEN.case.txt` (S467c_BROKEN)
7. `...\drafts_struc_30oct\S467d_fpfc_rotated_ucs_proof.case.txt` (S467d_fpfc_ucs30_proof)
8. `...\drafts_struc_30oct\S467d_fpfc_rotated_ucs_BROKEN.case.txt` (S467d_BROKEN)
9. `...\drafts_struc_30oct\S472a_layout_tab_stops_proof.case.txt` (S472a_layout_tab_stops_proof)
10. `...\drafts_struc_30oct\S472a_layout_tab_stops_BROKEN.case.txt` (S472a_BROKEN)
11. `...\drafts_struc_30oct\S472b_refedit_stops_proof.case.txt` (S472b_refedit_stops_proof)
12. `...\drafts_struc_30oct\S472b_refedit_stops_BROKEN.case.txt` (S472b_BROKEN)
13. `C:\CE_PLAN\desk_jobs\CODEX_LOOK_STRUC_467_472_30OCT.txt` (the one Codex look brief, not sent)
14. This report.

**Validate result:** `pwsh -NoProfile -File "C:\Lisp Files\_ACAD_DRIVER\case_runner.ps1" validate "C:\Lisp Files\_ACAD_DRIVER\cases\drafts_struc_30oct"` printed `12 file(s) checked, 0 invalid`.

Every case has REVIEWED_AGAINST "builder-filled: Opus review still needed", BUG, PROVES_BUGS (proof cases name exactly the part they cover; twins leave it empty), KIND deterministic, FIXTURE DRV2_S1, SLOT fresh. No SETTING line (see "Could not write" item 2).

---

## Per case: steps, what is derived from the code, what is guessed

All code was read at the installed Structural commit 204dfad2 (`git show 204dfad2:...`). The UCS numbers are worked out once: `_.UCS _Z 30` turns the UCS 30 degrees about the World origin, and a typed point without a star is read in the current UCS, so UCS (x, y) is World (x cos 30 - y sin 30, x sin 30 + y cos 30). Every World point in the cases was computed by a script, not by hand.

### 1. S467a_bt1_ucs30_proof (BT1, and the World repeat)

1. **Steps:** settings-arm; OSMODE 0; zoom; UCS Z 30; BT1, typed 17700,-3300 and 20100,-3300, truss 1, flip No; read the new BRACING block; UCS W; BT1 typed at the World points shifted 3000 up (16978.650,8992.116 to 19057.111,10192.116); read the second block.
2. **Asserts:** "Preview length: 2400  rotation: 30" both times; one new BRACING block on WALL BRACING TYPE BT1 each time; first block within 1 mm of World 16978.650,5992.116, second within 1 mm of 16978.650,8992.116; INSUNITS 0 or 4; UCSXDIR about 0.866; drawing file unchanged.
3. **Derived from the code:** the block goes in AT the World first point with block rotation 0 (BracingService.InsertBracingBlock 1645-1702); the angle lives in a dynamic grip that ent-read cannot read, so the angle is taken from BT1's own line "Preview length: L  rotation: deg" (BracingCommands.cs 295), which is worked out from the two World points. Prompt order from BracingCommands.cs 244-368 and robot run 2's transcript on this drawing (flip question shown, answered No).
4. **Guessed / unconfirmed:** that the flip question still appears at these points on 1.0.125 (no Xref walls in DRV2_S1, as in run 2). If it is skipped, "No" lands at Command: as an unknown word (harmless; recorded).
5. **Twin S467a_BROKEN:** claims "rotation: 0" and the block within 1 mm of 17700,-3300 (the old fault, 9.3 m away). Must FAIL on 1.0.125.
6. **Worth knowing:** the second point goes through BT1's drag preview. The HUNT-S-02 log entry flagged an untested assumption about what AutoCAD hands that preview. If the assumption is wrong, the Preview line will NOT say 30 and the case fails: that would be a real finding, not a case fault.

### 2. S467b_ab_bb_ucs30_proof (AB and BB)

1. **Steps:** as S467a; AB typed 17700,-300 to 20100,-300, flip No; BB typed 17700,2700 to 20100,2700, flip No.
2. **Asserts:** both Preview lines read 2400 at 30; one new BRACING block on WALL BRACING TYPE A within 1 mm of World 15478.650,8590.192; one on WALL BRACING TYPE B within 1 mm of World 13978.650,11188.269; drawing unchanged.
3. **Derived:** TryGetBracingEndpoints 576-600 (Tim's Bracing Wall option is OFF, so the first question is "Specify first point of bracing: "); Tim's longest brace is 2700, so 2400 gets no length warning.
4. **Not covered:** the Wall option route (pick a wall line, the S-32 finalizer change f79e17e6). It is OFF in Tim's settings and the runner cannot switch a Structural setting (see below).
5. **Twin S467b_BROKEN:** claims rotation 0 and the braces at the raw numbers.

### 3. S467c_r1_point_ucs30_proof (R1, Point option)

1. **Steps:** settings-arm first (R1 saves the Structural settings file at the end, RafterJoistCommands.cs 258); UCS Z 30; R1, then P and a typed point four times (LEFT 17700,-3300, RIGHT 21700,-3300, TOP 19700,-1800, BOTTOM 19700,-4800); tag RT1 (Tim's own last tag, so the saved value does not change).
2. **Asserts:** "Placed RT1 on layer RAFTERS"; one new RAFTER-JOISTV2 block on RAFTERS within 2600 mm of World 18710.700,6992.116 (the bay centre; anywhere inside the 4000 x 3000 bay is within 2500 mm). The old fault puts it 10.3 m away.
3. **Derived:** prompts from TryGetPick 1333-1375 and TryPromptTagText 566-596; HUNT-S-02 at 1367 and 1377.
4. **Guessed:** exactly where auto-placement slides the tag (so the tolerance is the bay, not a point). R1 turns on Nearest and Perpendicular object snap itself during the picks; the typed points are in an empty area so no snap is expected (recorded).
5. **Twin S467c_BROKEN:** claims the tag within 2600 mm of the raw 19700,-3300.

### 4. S467d_fpfc_ucs30_proof (FPFC)

1. **Steps:** UCS Z 30; FPFC, PF7, 600, 600, 0, centre 19700,-3300, Enter at the rotation.
2. **Asserts:** one new closed polyline on STRIP FOOTINGS with its first corner within 5 mm of World 18600.893,6582.309 (centre World 18710.700,6992.116, turned 30 degrees); none at the old place 19400,-3600.
3. **Derived:** ExecuteCreateRectElement 1199-1305 (centre through UcsPointToWorld, the UCS angle added to the typed rotation), BuildRectanglePolyline (first corner = centre + (-300,-300) turned).
4. **Guessed / unconfirmed:** that DRV2_S1 remembers no size for PF7 (it holds PF1 to PF4). If it does, the size questions are skipped and the chain goes out of step: the case FAILS or is BLOCKED and the type reply shows why.
5. **Twin S467d_BROKEN:** claims the first corner at 19400,-3600.

### 5. S472a_layout_tab_stops_proof (layout tab)

1. **Steps:** TILEMODE 0 (to the layout tab), _.PSPACE (no viewport active), read CTAB and CVPORT; BT1, C1, BTX each typed bare with an Esc after; TILEMODE 1.
2. **Asserts:** CTAB is not Model, CVPORT 1; the three exact lines (wording copied from ModelSpaceWriteGuard.StopLine: "You are on a layout tab (paper space), so CE drew no bracing truss / placed no support / changed no text. Go to the Model tab, or double-click into a viewport, and try again."); exactly three such lines in the history; Model space count unchanged; drawing unchanged.
3. **Derived:** the guard is the first thing each command does (BracingCommands.cs 248, SupportBlockCommands.cs 215, BeamTextConvertCommands.cs 22). Inside a viewport the commands are allowed on purpose, hence PSPACE.
4. **Why bare commands:** the driver refuses a typed answer chain behind BT1 or C1 on a layout tab (it knows they stop there), so each is typed alone.
5. **Guessed:** that the first visit to the layout opens no page-setup window (if it does, BLOCKED).
6. **Twin S472a_BROKEN:** claims no layout line from any of the three. The brief asked for "the command asserted to draw something"; on the old build the commands only asked their first question on a layout tab (the drawing into Model space needs typed answers, which the driver refuses there), so the twin claims the missing line instead.

### 6. S472b_refedit_stops_proof (REFEDIT)

1. **Steps (typed set-up only, no mouse):** draw a 2 m line, make it block S472BLK with the command-line -BLOCK, insert it with -INSERT, zoom so it is in view, open it with -REFEDIT (pick 19000,5000, OK, All); read REFEDITNAME; BT1, C1, BTX bare; REFCLOSE Discard.
2. **Asserts:** REFEDITNAME = S472BLK (the set-up check); the three REFEDIT lines; three in the history; Model space count unchanged during the edit; drawing unchanged.
3. **Derived:** the REFEDIT wording from ModelSpaceWriteGuard.StopLine.
4. **Guessed and untried:** the -BLOCK, -INSERT and -REFEDIT question order on AutoCAD 2027. If the set-up is wrong the REFEDITNAME check fails first: read that as a set-up problem, not a CE fault. If it cannot be made to work, Codex look item 4 covers it.
5. **Twin S472b_BROKEN:** keeps the set-up check, claims no REFEDIT line.

---

## What I could not write, and why

1. **No case for the drag preview, the R1 rubber band or how the pad looks.** They need the mouse and eyes: Codex look items 1 to 3.
2. **No SETTING line for Structural settings.** The runner turns a bare `CS_Settings.json` into `%APPDATA%\TIM_CE_CADTOOLS\CS_Settings.json`, but Structural 1.0.125 reads `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json`. A line `STRUC\CS_Settings.json` passes the offline check, but the driver would read it as a relative path and refuse it. So the Wall option route of AB/BB and a forced flip question could not be set. Instead, every case starts with `settings-arm`, which backs up every settings file and puts the exact bytes back at the end. Fixing this needs a runner change (not mine to make).
3. **The brace angle cannot be read from the block.** ent-read returns the block's own rotation (always 0 for BRACING) but not its dynamic grip values, so the angle comes from the command line. A driver reading of dynamic properties would make it stronger.
4. **No case for BTX on a text that sits on the sheet** (the worst case in the carpark entry). The robot cannot pick on a layout: Codex look item 5.
5. **R1, AB, BB, TS1, FSF and FPFC on a layout tab or in REFEDIT** are not typed. They share the same guard; adding them is three lines each if CE 00 wants them.
6. **Xref in-place editing** (the other half of the REFEDIT rule) is not set up: there is no Xref the robot can rely on.
7. **The FSF two-point route** (also fixed by HUNT-S-02) is not covered.

---

## Minimum Structural fixture (what BT1, AB, BB, R1, FPFC, C1 and BTX need)

1. **The answer:** DRV2_S1 is already enough for every case here. A Civil copy (DRV1_B1) with no walls at all would also work for every command in this report, as long as the drawing is in millimetres, because the typed-point routes need no lines. I used DRV2_S1 because it is a Structural copy, it is small (85,871 bytes, about 22 objects) and BT1 has already run on it.
2. **Units:** millimetres (INSUNITS 4) or unset (0). In metre, centimetre or inch drawings BT1, AB, BB, R1 and C1 stop with the Day 1 units line (Tim's setting "Day 1 units: hold in non-millimetre drawings" is ON), and FPFC converts or holds (FoundationService.Identity.cs 119).
3. **Blocks:** none need to be in the drawing. BRACING (BT1, AB, BB) and RAFTER-JOISTV2 (R1) are loaded by CE from the installed bundle (`CE_STRUC_SUITE.bundle\Contents\Win64\...\Assets\Blocks\`, checked on disk). If BRACING were missing everywhere CE would open a file picker. C1's SUPPORT BLOCK NEW is in the same folder; I think C1 loads it the same way (not read in full).
4. **Layers:** none need to exist; CE creates WALL BRACING TYPE BT1 / A / B, RAFTERS, STRIP FOOTINGS and 25TEXT. If one exists it must NOT be locked (locked layers stop the command, HUNT-S-08).
5. **Walls:** not needed for the Point routes. Xref walls only change the brace's auto flip; without them CE asks "Toggle flip? [Yes/No]". R1's Object option needs real beam or wall lines; its Point option does not. The AB/BB Wall option needs a line or polyline.
6. **Footings (FPFC):** no raft is needed for a pad. The footing record and remembered sizes live in the drawing; a mark new to the drawing asks for X size, Y size and depth.
7. **BTX:** needs a TEXT or MTEXT to pick in Model space (not needed for the layout and REFEDIT cases, where it stops first).
8. **Layout tab:** every drawing has one. **REFEDIT:** needs a block reference; S472b makes one with typed commands.
9. **Profile and data folder:** no special AutoCAD profile. The Structural plug-in must be installed and loaded (1.0.125). Settings come from `%APPDATA%\CE_STRUC_SUITE\CS_Settings.json`, where R1 saves its last tag at the end of every run (hence settings-arm). No job data folder is needed for these seven commands, as far as the code shows.

---

## Sources checked

1. `C:\TimOS\RULES.md`; the brief `C:\CE_PLAN\desk_jobs\CASE_BRIEF_STRUC_467_472.txt`.
2. `C:\CE_PLAN\areas\BUGFIX_p15_REPORT_30OCT.md` and `BUGFIX_p17_REPORT_30OCT.md`; BUG_CARPARK.md entries BUG-467 and BUG-472.
3. Structural code at 204dfad2: BracingCommands.cs, BracingService.cs, RafterJoistCommands.cs, FoundationService.cs and FoundationService.Identity.cs, SupportBlockCommands.cs, BeamTextConvertCommands.cs, DrawingSafetyService.cs, Core/Symbols/ModelSpaceWriteGuard.cs, CeInstallPaths.cs, SettingsService.cs.
4. Driver and runner (read only): cases\README_CASES.md, case_runner_lib.ps1 (validation, ms-new, select, dist, type), acad_driver_v3.ps1 (ent-read), acad_driver_witness_v2.ps1 (layout-tab chain guard, settings file rules), TESTPLAN_C8_S7.md and DRIVER_TESTER_GUIDE.md (DRV2_S1 contents and hash), robot run 2 report (BT1 on DRV2_S1).
5. Tim's Structural settings file, read only: Bracing.WallOption false, SkipFlipPromptWhenAutoDetermined true, BraceLength.MaxLengthMm 2700, RafterJoist.AutoPlacementEnabled true, LastR1Tag RT1, Day1Units.HoldInNonMillimetreDrawings true.

## What I did NOT do

1. No AutoCAD, driver, runner run (other than the offline validate), build or test.
2. No existing case, setup, driver, runner or settings file was edited. Nothing committed, pushed or deleted.
3. BUG_CARPARK.md was not edited (outside this job's limits). CE 05 may want to add one line under BUG-467 and BUG-472: "robot cases S467a-d and S472a-b written 30 Oct, not run".
