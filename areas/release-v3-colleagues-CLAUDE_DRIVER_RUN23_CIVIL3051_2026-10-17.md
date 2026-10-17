# Claude driver run 23: Civil 3.0.51 / Manager 1.1.51 / Structural 1.0.118 (Sat 17 Oct 2026, 16:56 to 17:08 Melbourne, PC clock)

**Answer first.** Of the 139 Codex FAILs, only a handful can be reached by typing complete commands (the rest need a mouse pick, a window button the driver will not press, or Save). I retested the ones that can. **Five look cured, two still fail, BUG-650 could not be built by typing.** AutoCAD is closed.

Counts: PASS 8, STILL FAILS 2, BLOCKED 4, UNPROVEN 3 (source reading only), plus 1 PASS carried from run 22 (BUG-606). Driver calls: session 1 used 58 of 70 (including one forced kill), session 2 used 9 of 70. Nothing was saved. Both copies still equal their source hashes.

## A. Setup

1. **Installed builds (nine DLLs read first, readdll.ps1).** Civil 3.0.51+4e2bdfeb, Manager 1.1.51+4e2bdfeb, Structural 1.0.118+9a8e5d4e (Legacy, Net8 and Modern of each). Same as run 22, so I did not repeat CEHEALTH.
2. **Before launch.** `Get-Process acad` showed nothing, no lock file, and the Codex queue.log had no START line in the last 3 minutes (last line was an END of verifyW65 at 08:38).
3. **Fresh copies.** CLD51_B1 from DRV1_B1 (34BBE37C2EA4), CLD51_S1 and CLD52_S1 from DRV2_S1 (950AFDF6E523). All three equal their source after the run.
4. **Witness recorder** loaded in both sessions (sha 49E79D6D...). The Civil drawing was the launch drawing, so it was open before the recorder loaded and has no witness log; I did not read witness logs this run.
5. **Staging by LISP (please rule on this).** To stage two test conditions I set CELWEIGHT to -3 and DIMSCALE to 100 then 50 with `(setvar ...)` inside `-AllowLisp` lines on the unsaved test copy. The driver's own `setvar` command refuses those names, so this used the driver's LISP route, not a bypass, but the desk may prefer a rule on it. None of it was saved.

## B. The checks (highest severity first)

1. **PASS. BUG-646 (Codex TS-02): 25C no longer changes the lineweight.** Staged CELWEIGHT -3 (Default). Typed `25C`, `5`, `0,4000`. AutoCAD printed "Enter a number to append to '25' (or press Enter to exit): 5" and "Specify insertion point: 0,4000". After it: CELWEIGHT still -3, CECOLOR BYLAYER, CELTYPE ByLayer, CLAYER 0 (all unchanged), one object added (15 to 16). Codex saw -3 become -1. Structural 1.0.118.
2. **PASS (completed route). BUG-621 (Codex DM-09 and the family): LD leaves the drafter's dimension style alone.** Staged DIMSCALE 100 (the command needs 20 or 100). Before: DIMSTYLE ISO-25. Typed `LD`, `1000,4000`, `3000,4000`, `2000,4500`. AutoCAD showed "Current dimension style: TIM LEADER" during the command and "Dimension text = 2000". After: DIMSTYLE ISO-25, CLAYER 0, CELWEIGHT -3, one object added. Codex's failing case was the Escape path; I could only reach the completed path.
3. **PASS (completed route). BUG-621: AD likewise.** `AD`, `1000,6000`, `3000,6000`, `2000,6500`. After: DIMSTYLE ISO-25, CLAYER 0, one object added.
4. **PASS. BUG-256: U then 12 s then REDO after CDFW on the Civil copy.** `CDFW` and `5000,6000` placed "Floor waste placed. Tag: FW1." Then `U` (echo "CDFW"), 12 s, `REDO`: "Everything has been redone".
5. **PASS. BUG-256: the same after CDAGI.** Typed `CDAGI`, `None`, `0,3000`, `10000,3000`, two Enters (finish, skip the outlet), `20.000`, `19.900`, `Accept`. AutoCAD printed "[CE] AG drain AGI1 placed. ... Grade: 1:100 meets the office minimum 1:100. One Undo removes it and its record." Then `U` (echo "CDAGI"), 12 s, `REDO`: "Everything has been redone". The first attempt at this walk was **spoiled by an autosave** (the 5 minute mark fell in the 12 s wait: "REDO must immediately follow the U or UNDO command"). I placed the drain again and repeated the walk; that one passed. Not a finding.
6. **PASS. BUG-256 on Structural 25C.** After check 1: `U` (echo "25C"), 12 s, `REDO`: "Everything has been redone".
7. **PASS. BUG-256 on Structural AD.** After check 3: `U` (echo "AD"), 12 s, `REDO`: "Everything has been redone".
8. **PASS, with a caveat. BUG-647 (Codex FW-04): CDFW is no longer refused when an AG drain exists.** After the AGI1 drain was placed, `CDFW` and `5000,6000` placed FW1 with no "pit without CE identity" refusal. Caveat: Codex's drawing had a strip drain SD1 as well, and this drawing already had four blocks named AGI (CE printed "The source name 'AGI' is on 4 blocks ... Run CDFIXTAGS"). I did not build a strip drain. So the AGI part looks cured; the strip drain part is unproven.
9. **STILL FAILS. BUG-648 (Codex AG-07): the AG drain still draws no grade label.** After the CDAGI chain in check 5, I listed everything added after the previous last object: exactly one object, an LWPOLYLINE on layer "AGI DRAIN", no TEXT or MTEXT. The grade only appears in the command line ("1:100 meets the office minimum 1:100"). Handle of the polyline: 11C558.
10. **STILL FAILS. BUG-531 (Codex TS-04): 25C and EBT text heights still differ at DIMSCALE 50.** Same drawing, DIMSCALE 50: `25C`, `6`, `0,5000` gave a TEXT of height **125** on 25TEXT; `EBT`, `2`, `650,5900`, `1650,5900` gave a TEXT of height **250**. Exactly the 125 versus 250 Codex saw.
11. **PASS (carried from run 22, not repeated). BUG-606 (Codex DC-03): CDCHECKDWG writes its report to the CE logs folder, not beside the drawing.**

## C. Blocked, unproven and my own mistake

1. **BLOCKED. BUG-650 (Codex FW-03, FC-03, GS-02): the fixture cannot be built by typing, and this drawing cannot show it.** What I found: on this drawing every pit's cover label is a separate "CL 18.88" style text with no IL line (nine pit cover labels listed, all CL only), and the IL numbers live in separate pipe-end texts. So the "cover label with a CL line and no IL line" shape is already there, and the pits' own stored bottom level is not shown anywhere I can read: in Edit Pit for P3 the box "Pit bottom level (m AHD)" is greyed out and blank (it only opens when "Sump pit · own bottom IL" is ticked). To **store** an invert on a pit I would have to press "Save pit and close" in Edit Pit or "Continue placement" in New Pit. The driver refuses both (the words Save and Continue placement are on its never-press list). I also did not run CDFW again: run 22 already showed CDFW start and accept left every Pit Schedule row unchanged on a drawing of this same kind. **What Codex needs to do:** build the fixture itself (a pit with a stored invert such as P1 20.000 and a label "CL 21.10" with no IL line) and run CDFW Esc and CDSOURCE Esc, then read the saved project. Codex's own working copies in `V3UX_20261014\linked-fall` (CODEX_FW_CONTROL and CODEX_FLOOR_WASTE, 16 Oct) were already changed by its tests, so they are not clean fixtures.
2. **BLOCKED. BUG-649 (Codex AG-11): a drain that rises towards its outlet.** CDAGI asks "Select outlet pit or pipe (Enter to skip)" with an object pick. A typed answer cannot pick an object, and with the outlet skipped CE cannot know which end is the outlet, so the test would prove nothing. Needs a mouse pick.
3. **BLOCKED. BUG-643 (Codex CV-03): catchment area with a curved edge.** CDCATCHMENT asks for the closed outline and then the pits by object pick. Needs a mouse pick.
4. **BLOCKED. The Escape cases of BUG-621 (DM-02, DM-09, QL-02, QL-04, AM-03, AE-02).** A typed chain cannot press Esc, and the driver's `esc` is only for CE prompts (its own list says LD stays refused). I will not leave AD, LD or Q waiting at a prompt.
5. **UNPROVEN (source reading only, not run). BUG-622 (ML-02, ML-05) and BUG-640 (AM-09).** At commit 9a8e5d4e, MLL's first prompt is "Leader arrow point or [?]" with no Flip keyword, so typing F still cannot work; RD still asks Length/Radius/Diameter before any geometry. Typing F would leave a prompt open, so I did not run it. **BUG-576 (ES-13, column selector caption)**: I could not find the caption text in the source and did not run C1.
6. **MY MISTAKE (cost: one forced kill and about 10 minutes).** I typed `EBT`, `2`, `650,5900` with only three answers. EBT has a fourth question ("Pick second point to define rotation angle or press Enter for 0"), so AutoCAD was left waiting. The driver's `esc` refused (EBT is not on its CE list: "no CE command at a prompt"), `cancel` refused (alarm set), so I used `quit -Kill` as the guide allows, on the AutoCAD this driver launched. Both drawing copies were unchanged afterwards. In the second session I gave EBT its fourth answer (`1650,5900`) and it completed.
7. **SKIPPED. The other roughly 130 FAILs.** They need a mouse pick (DSET, DUP selection, hatch, XRL, CXREF, MOVE of a compound), a window button the driver will not press (Edit Pit Save, New Pit Continue placement, Pit Schedule Apply or Place), a layout tab (BL, paper-space text: the driver refuses answer chains on a layout), Settings, or the Excel and PDF exports. I did not try to get round any of them.

## D. System variables and tidy-up

1. **Read before:** OSMODE 5375, SAVETIME 5, CLAYER BLOCKS (Civil copy); OSMODE 5375, SAVETIME 5, CLAYER 0, DIMSTYLE ISO-25, DIMSCALE 1, CELWEIGHT -1 (Structural copy).
2. **Read after:** I changed none of OSMODE, SAVETIME or CLAYER and did not re-read them. The staged CELWEIGHT -3 and DIMSCALE 100 and 50 existed only in unsaved test copies that were closed without saving (one by the kill). The three copies equal their source hashes, so nothing persisted.
3. **Closing.** Session 1: forced kill (see C6), lock released, `Get-Process acad` empty. Session 2: `quit` (ended by CloseMainWindow, not killed), lock released, `Get-Process acad` shows 0 AutoCAD processes.

## E. Driver notes for the tooling worker

1. **`esc` cannot end EBT.** Suggest adding EBT and the other Structural text commands (25C, 25L and so on) to the CE list, or allowing `esc` when the newest echo is a Structural command name with no later `Command:` line.
2. **False alarm after CDFW again.** The CDFW call took 28 s, the driver raised the prompt alarm, but CMDACTIVE was 0 and the FW1 sentence had printed. One `wait` cleared it. Same as run 22.
3. **LD and AD print the same first prompt two or three times** in the log. Harmless.

## F. What Tim needs to do

Nothing in AutoCAD for these items. For Codex: build the BUG-650 fixture itself and test CDFW Esc and CDSOURCE Esc (item C1); do the object-pick cases (BUG-649, BUG-643) and the Esc cases of BUG-621. For the build lanes: BUG-648 (grade label) and BUG-531 (EBT height at DIMSCALE 50) are still failing on the installed builds.

**Built, tested, installed, accepted:** these are installed builds driven in real AutoCAD on copies by a robot, not Tim-accepted. The five PASS items (646, 621 completed path, 256 on CE and Structural commands, 647 AGI part) are Codex-style robot passes of a bounded check, not whole-workflow acceptance.

**What I did NOT test:** the Escape paths of 621, anything on a layout tab, BUG-650 itself, the strip-drain half of 647, the exact CDEDIT and Pit Schedule routes for BUG-256 (they need Save or Place), and the witness logs for any walk.
