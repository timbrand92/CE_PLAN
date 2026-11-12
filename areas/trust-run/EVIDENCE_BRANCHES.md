# Evidence for the builder branches (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, from 01:00. **Status: DRAFT evidence.** Nothing here is installed, merged or accepted. Every check is one of three words: **seen to pass**, **seen to fail**, **could not be run headless**.

**How it was run.** Each branch head is built in my own worktree (`-p:SkipDevBundle=true -nr:false --disable-build-servers`, under the build lock) and copied to a scratch folder. The copy is loaded only in AutoCAD 2027's core console (no ribbon, no windows, no idle events) by the repo's headless-proof harness, on a copy of a made-up-and-test drawing, never from the live bundle. CE's record is read from a DXF export of the drawing taken before and after each tool. The installed build (`cf059dcf`, Civil 3.0.90) is run through the same steps as the control: it is the "broken twin" for every check that is meant to fail today.

**The drawing:** a copy of the standard test drawing (11 pits, 49 pipes, millimetres) with one plain line added on the pipe layer, so CE's record is behind the drawing. Same file for every run.

---

# FOR TIM

1. **Step 5 (PR 2045), tools that only read: seen to pass for CDGRAPH and CDDIAG.** On the new build neither changes CE's record (49 pipes before, 49 after, byte for byte). On the installed build CDGRAPH quietly adds the stray line to the record (49 to 50) and gives it a CE identity. This is the check that Tim named.
2. **The new "needs checking" line works for the stray line.** The tool prints: `CE: needs checking. 22 pipes not linked, 1 line on a pipe layer not in the CE record. Type CDCHECKCURRENT to see them.` The "1" is right.
3. **Two things the cases ask for that the build does not do yet (for the builder):**
   1. CDGRAPH still counts the stray line as a pipe in its own network summary (50 pipes) while the record holds 49. The case says it should show the stored pits and pipes.
   2. CDDIAG prints only the "needs checking" line and none of its usual numbers in this state. The installed build prints "11 pits, 50 pipes recorded". A drafter loses the numbers.
4. **CDSYNC and CDREBUILD unchanged: CDSYNC seen to pass.** The record after CDSYNC is identical between the installed build and the new build (value for value).
5. **What I could not prove headless:** the opening line (PR 2041), Edit Pit's line, the dashboard, CE Health, the undo promise, and all the Structural branches (2044, 2046, 2047). The reasons are below. The opening line in particular needs real AutoCAD with the build loaded, and loading it means installing it, which this run may not do.
6. **Not seen at all yet:** the ribbon (2038), the reader (2040) and the Structural schedule rows. See the section for each.

---

# DETAIL

## A. PR 2045 step 5 (TRUST-05) at head `faa4d7d5`

**Builds compared:** installed `cf059dcf` (CE_CVL_SUITE 3.0.90) and `faa4d7d5` (TRUST-05 plus the review fix; built 01:13, 58 s, 0 errors). I also ran the first TRUST-05 commit `f23b9530` once; it behaved the same way for CDGRAPH.

**Checks from `cases\TRUST-05.md`:**

1. **Y1, each read-only tool leaves everything as it was.** CDGRAPH and CDDIAG: **seen to pass** on the new build (record identical after each: 49 pipes, same text with the run-folder path masked). **Seen to fail** on the installed build (CDGRAPH: record 49 to 50 pipes; the stray line also gained CE's identity in the drawing). CE Health (Manager's command) and the dashboard (a window): **could not be run headless**. Drawing side: on both builds 7 to 9 callout (multileader) objects differ between exports, the same kind on the new and installed build; the cause is not known (probably AutoCAD refreshing its picture of them when the file is written); the new build changes no pit, pipe or text. The installed build also changed the one stray line (it received an identity).
2. **Y2, the tool says so when the record is behind.** **Seen to pass** for the stray-line count (1 line on the pipe layer, equal to the drawing). **Seen to fail** on two sub-points of the case: CDGRAPH's network summary still counts 50 pipes (record has 49), and CDDIAG prints no counts at all.
3. **Y12, the undo promise.** **Could not be run headless.** In the core console, `U` after CDSYNC left the record changed on both builds, but in real AutoCAD one U restored the record exactly (my probe of the installed build, 12 Nov: `TRUST_PROBES_13NOV.md`). The two disagree, so the console's U is not evidence. Needs real AutoCAD with the new build loaded.
4. **Y14, CDSYNC does what it did.** **Seen to pass**: record after CDSYNC identical on the installed and new build (246,509 characters each, all values equal), on the same starting drawing. CDREBUILD: **not run**.
5. **Y7 to Y11, the "CE updated its record" line after Edit Pit, PIT, CD and others.** **Could not be run headless**: Edit Pit and the others open windows or wait at prompts. The line itself was therefore **not seen** in any run. (CDGRAPH prints the "needs checking" line instead, because it no longer updates.)
6. **Y13 (the two switches), Y15 to Y24.** **Not run.** The switches live in the live settings file (never touched); units, Xref, paper space and the rest need further drawings and, mostly, windows.

**Wording check (card Y2 wording against what was printed):** the card's example reads `CE: needs checking. 2 lines on the pipe layer are not in the record.` The build prints `... 1 line on a pipe layer not in the CE record.` plus `22 pipes not linked` (those 22 are the drawing's unlinked pipes, which were there already). The facts match; the words differ. The test-cases note says the card does not fix the words.

## B. PR 2041 opening line (UX-OPEN-01) at head `31f426ab`

All 34 cases: **could not be run headless.** The line is printed when AutoCAD goes idle after a drawing opens. The core console never goes idle, and the branch has no command or probe that runs the line on demand. The build's own counting (shared with CDCHECKCURRENT) is exercised indirectly by the "needs checking" line above, whose "1 line not in the record" and "22 pipes not linked" counts are plausible but are not the opening line itself. To see the opening line the build has to be loaded in real AutoCAD; I did not install and did not start a second profile.

## C. PRs 2044 and 2046 (Structural bracing schedule rows), 2047 (trusses out of wall totals)

**Could not be run headless.** The headless-proof harness loads the Civil build only. Structural has no such harness here, and its schedule commands create tables and read the drawing's notes, which need a Structural build loaded in a profile of its own. Not attempted tonight. Next step if wanted: a Structural probe in scratch (new code, not in any repository) loaded in the core console.

## D. PR 2038 core ribbon

**Could not be run headless.** A ribbon is not built in the core console. The branch's own unit tests pin today's layout; I did not run them.

## E. PR 2040 the reader

**Not run.** It has no caller yet ("nothing calls it yet"). The made-up drawings for it are in `C:\CE_WORK\testset` (`MADEUP_README.md` has the answer sheet). Running the reader over them needs its scorer built; ask the reader lane for the command.

## F. What this evidence can and cannot say

1. **Can say:** the new build really does stop CDGRAPH and CDDIAG from changing CE's record on a drawing where it is behind; CDSYNC is unchanged.
2. **Cannot say:** anything about what a drafter sees on screen, the undo promise, the "CE updated its record" line, or any window.
3. **Defaults taken for Tim to confirm:** the test drawing is the standard test copy plus one stray line (not the cases' MD-02); the builds are loaded by the repo's harness with the installed object enabler beside them.

Files: `C:\CE_WORK\scratch\trustprobe\ab\` (DXF exports, parsed records, console text). Scratch only.
