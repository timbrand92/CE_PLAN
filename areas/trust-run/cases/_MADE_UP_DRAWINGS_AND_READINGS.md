# Shared by every case file: the made-up drawings and the standard readings

**Status: DRAFT (12 Nov 2026), written by lane trust-test-cases.** Documents only. Nothing here was run. Part of area TRUST.
**Used by:** `areas\trust-run\cases\UX-OPEN-01.md` and `TRUST-02.md` to `TRUST-08.md`.
**Privacy:** every drawing here is invented. No client name, street or job address anywhere. Screenshot and log names use the drawing codes (MD-01 and so on), never a job name.

---

# FOR TIM

**This page says what the robot reads from a drawing, and which made-up drawings it practises on. You do not need to read it. The case files point here so the same words mean the same thing every time.**

---

## 1. The made-up drawings (code MD-nn)

These are described by what is in them. Lane trust-acad-evidence builds the real files under `C:\CE_WORK\testset\MADEUP_*`. If its files differ from this list, the case file is read against this description, and the difference is written in the case result.

**Every drawing is made on a fresh copy.** The robot never opens the first file twice. Each run starts from a new copy of the copy.

**The answer sheet is written when the drawing is made, before CE reads it.** It comes from how the drawing was built, never from CE's own record or schedule.

1. **MD-01, clean current job.** Millimetres. Pit blocks P1 to P6, placed with the current tools, all with CE's record.
   1. Cover levels from the outlet end up: P1 10.50, P2 10.80, P3 11.10, P4 11.50, P5 11.90, P6 12.30.
   2. Lowest pipe invert at each pit: P1 9.10, P2 9.45, P3 9.80, P4 10.20, P5 10.60, P6 11.00.
   3. Six pipes: P6 to P5 and P5 to P4 are 150 dia; P4 to P3, P3 to P2 and P2 to P1 are 225 dia, each 35 m long and 1.0% fall; the outlet pipe P1 to the LPD is 225 dia, 10 m, falling from 9.10 to 9.00.
   4. One LPD drawn at the end of the outlet pipe. No downpipes, no tank.
   5. Answer sheet: 6 pits, 6 pipes, every pipe joined at both ends except the outlet pipe, which ends at the LPD.
2. **MD-01-DP, MD-01 plus two downpipes** (DP1 into P4, DP2 into P5) **and one water tank** feeding P6 with its overflow to P5.
3. **MD-02, MD-01 plus one stray line:** a plain 3 m polyline on the stormwater pipe layer, no CE data, no label, not touching a pit.
4. **MD-03, old LISP-style job.** Four pit blocks named PIT BLOCK 2 with no CE record. Three plain polylines on the stormwater pipe layer, each with one pipe text in the old fixed pattern ("150 DIA. UPVC PIPE AT 1 IN 100 MIN.") and "IL" invert text at each end. Nothing in the drawing records a CE version.
5. **MD-04, hand-drawn job, no CE tools.** Five plain blocks named PIT (not a CE name), lines on a layer named DRAIN-LINES, no text. Right = CE claims nothing as Sure and invents nothing.
6. **MD-05-MM and MD-05-M, MD-01 in two unit settings.** Same job, one in millimetres and one in metres (all coordinates and sizes divided by 1000). **MD-05-U:** the same job with drawing units not set.
7. **MD-06, one label, two pits.** MD-01 with pit label P3 moved so it sits 600 mm from P3 and 900 mm from P4 (both inside the label reach).
8. **MD-07, plastic pits.** MD-01 with P3, P4 and P5 changed to 350 x 350 plastic grated pits.
9. **MD-08, two outlets.** Two separate networks of three pits each, each with its own LPD.
10. **MD-09, Save As copy.** MD-01 saved under a new name. Plus **MD-09-X:** two pits copied from MD-01 into MD-08 through WBLOCK, so they carry another job's CE identity.
11. **MD-10, Xref host.** A blank drawing with MD-01 attached as an Xref.
12. **MD-11, paper space.** MD-01 with a Pit Schedule placed on a layout, and one PIT BLOCK 3 sample drawn on that layout as a legend.
13. **MD-12, spoiled blocks.** MD-01 with P4 exploded, P5 mirrored, P6 rotated 30 degrees, one extra pit scaled 2 times, and one block named PIT_SUMP_OTHER that is not CE's.
14. **MD-13, large job.** 400 pits and 450 pipes made by script, with the same rules as MD-01. Used for time and size limits.
15. **MD-14, read-only.** MD-01 with the Windows read-only attribute set. **MD-14-L:** MD-01 open in a second AutoCAD session so a lock file exists.
16. **MD-15, Structural drawing.** A made-up Structural drawing with four beams and a footing. **MD-15-B:** a blank drawing.
17. **MD-16, one job over two drawings.** P1 to P3 in one file, P4 to P6 in the other, with the P3 to P4 pipe drawn in the first.
18. **MD-17, touched by another version.** MD-01 with its stored format number edited by script on a copy: **MD-17-OLD** one step lower, **MD-17-NEW** far higher (9.0).
19. **MD-18, locked layer.** MD-01 with the pipe layer locked. **MD-18-V:** the pit layer frozen.
20. **MD-19, no outlet.** MD-01 with the LPD and the outlet pipe removed. **MD-20, no inverts:** MD-01 with every invert blank and no LPD.
21. **MD-21, ten pits.** Pits P1, P2 and P10 to P17, to show whether the Pit Schedule orders P1, P2, P10 or P1, P10, P2.
22. **MD-22, damaged record.** MD-01 whose stored CE record is cut off half way by script.
23. **MD-23, 100 and UPVC trap.** MD-01 where one pipe line has no CE size, no CE material and no drawn width, and one pit has no label.

## 2. The standard readings (named once, used everywhere)

1. **Record reading.** The robot reads the stored CE record out of the drawing (named dictionary CE_CVL_SUITE_PROJECT, entry PROJECT_DATA) and writes it to a file, sorted the same way every time. Two record readings are equal only if every value is equal.
2. **Drawing reading.** For every object: its handle, type, layer, position and size, block name, and every attribute value; plus layer states (locked, frozen, on) and the block definitions. Written to a file, sorted. Two drawing readings are equal only if all of it is equal.
3. **Changed counter.** AutoCAD's DBMOD, read straight before and straight after. If it moves, something in the drawing changed.
4. **Command-line reading.** Everything CE printed to the command line, in order, with the exact words.
5. **File reading.** The drawing file's size, saved time and SHA256 before and after, and a listing of its folder (to catch a new backup or lock file).
6. **Log reading.** The CE log lines written during the case. Used only to see why something happened, never as proof it worked.
7. **Settings reading.** The settings file (CD_Settings.json) read value by value, and its SHA256.

## 3. The words every case uses

1. **Faulty partner.** For each check, a version of the change made on purpose with one named fault. It is made on a scratch copy of the code, never installed, never merged. The same check run on it **must fail.** If the check passes the faulty partner, the check proves nothing and is rewritten before it is trusted.
2. **Right.** What the robot must read back for the case to pass.
3. **RECORD.** A case where the plan does not yet say what right is. The robot records what it sees and the controller puts it to Tim. It never counts as a pass or a fail. Where a case says RECORD the reason is given.
4. **Not known.** Said plainly wherever the card or the code does not say.
5. **Two builds.** Where a case says "on 2027 and 2024", the same steps run on AutoCAD 2027 and AutoCAD 2024. A step that cannot run on 2024 says so and is not skipped silently.

## 4. The gaps the review found, closed in every file

The review (`areas\TRUST_PLAN_REVIEW_12NOV.md`, "Proof that could pass while broken") named four ways a test could pass while the tool was still wrong. Items 1 to 4 below are those four. Item 5 is the standing rule that readings must repeat. Each case file answers them in its section 3.

1. **Reading is not enough.** A reading taken once says nothing about the drawing after an edit. Every case file includes cases that make one ordinary edit on a copy, then read again. Anything that changed and was not the edit is a fault.
2. **The same jobs taught and tested.** The jobs used to teach the reader its list of old block versions must not be the jobs that test it. Two made-up drawings of each old kind are kept back and never used to build rules.
3. **"The button sent its command" is not "the command worked".** Every case that fires a command also reads what the command did and checks it against the answer sheet.
4. **"Apply, then U" never compared the linework.** Every Undo case compares the full drawing reading, not just CE's record.
5. **Twice, identical.** Any reading run twice on fresh copies must give identical text, and again on a second Windows login with different personal settings.
