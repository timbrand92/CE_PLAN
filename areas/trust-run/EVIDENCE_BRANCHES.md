# Evidence for the builder branches (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, from 01:00. **Status: DRAFT evidence.** Nothing here is installed, merged or accepted. Every check is one of three words: **seen to pass**, **seen to fail**, **could not be run headless**.

**How it was run.** Each branch head is built in my own worktree (`-p:SkipDevBundle=true -nr:false --disable-build-servers`, under the build lock) and copied to a scratch folder. The copy is loaded only in AutoCAD 2027's core console (no ribbon, no windows, no idle events) by the repo's headless-proof harness, on a copy of a made-up-and-test drawing, never from the live bundle. CE's record is read from a DXF export of the drawing taken before and after each tool. The installed build (`cf059dcf`, Civil 3.0.90) is run through the same steps as the control: it is the "broken twin" for every check that is meant to fail today.

**The drawing:** a copy of the standard test drawing (11 pits, 49 pipes, millimetres) with one plain line added on the pipe layer, so CE's record is behind the drawing. Same file for every run.

---

# FOR TIM

1. **Step 5 (PR 2045), tools that only read: seen to pass for CDGRAPH and CDDIAG.** On the new build neither changes CE's record (49 pipes before, 49 after, byte for byte). On the installed build CDGRAPH quietly adds the stray line to the record (49 to 50) and gives it a CE identity. This is the check that Tim named.
2. **The new "needs checking" line works for the stray line.** The tool prints: `CE: needs checking. 22 pipes not linked, 1 line on a pipe layer not in the CE record. Type CDCHECKCURRENT to see them.` The "1" is right.
3. **One thing the cases ask for that the build does not do (for the builder), and one correction of mine:**
   1. CDGRAPH still counts the stray line as a pipe in its own network summary (50 pipes) while the record holds 49. The foundations lane has looked at this: CDGRAPH traces the drawn network, so its count is of drawn pipes, and the "needs checking" line above it is what says one is not in the record. It is listed for the controller as a decision.
   2. **Correction (my mistake, found 13 Nov 02:05):** this file first said CDDIAG printed none of its numbers on the new build. That was wrong. My output filter cut the transcript at 60 lines. CDDIAG printed, straight after the "needs checking" line: `[CE] CDDIAG - 11 pit(s), 49 pipe(s) recorded in this drawing.` and `[CE] For a full check of this drawing, type CDREPAIR and click Audit Drawing.` Those are the lines the code prints, and 49 is the stored count, as the case asks.
4. **CDSYNC and CDREBUILD unchanged: CDSYNC seen to pass.** The record after CDSYNC is identical between the installed build and the new build (value for value).
5. **What I could not prove headless:** the opening line (PR 2041), Edit Pit's line, the dashboard, CE Health, the undo promise, and all the Structural branches (2044, 2046, 2047). The reasons are below. The opening line in particular needs real AutoCAD with the build loaded, and loading it means installing it, which this run may not do.
6. **Not seen at all yet:** the ribbon (2038), the reader (2040) and the Structural schedule rows. See the section for each.

---

# DETAIL

## A. PR 2045 step 5 (TRUST-05) at head `faa4d7d5`

**Builds compared:** installed `cf059dcf` (CE_CVL_SUITE 3.0.90) and `faa4d7d5` (TRUST-05 plus the review fix; built 01:13, 58 s, 0 errors). I also ran the first TRUST-05 commit `f23b9530` once; it behaved the same way for CDGRAPH.

**Checks from `cases\TRUST-05.md`:**

1. **Y1, each read-only tool leaves everything as it was.** CDGRAPH and CDDIAG: **seen to pass** on the new build (record identical after each: 49 pipes, same text with the run-folder path masked). **Seen to fail** on the installed build (CDGRAPH: record 49 to 50 pipes; the stray line also gained CE's identity in the drawing). CE Health (Manager's command) and the dashboard (a window): **could not be run headless**. Drawing side: on both builds 7 to 9 callout (multileader) objects differ between exports, the same kind on the new and installed build; the cause is not known (probably AutoCAD refreshing its picture of them when the file is written); the new build changes no pit, pipe or text. The installed build also changed the one stray line (it received an identity).
2. **Y2, the tool says so when the record is behind.** **Seen to pass** for the stray-line count (1 line on the pipe layer, equal to the drawing) and for CDDIAG showing the stored count (`11 pit(s), 49 pipe(s) recorded`, after the needs-checking line). **Seen to fail** on one sub-point of the case: CDGRAPH's network summary still counts 50 drawn pipes while the record has 49 (the foundations lane says this is by design: CDGRAPH traces the drawn network). **Correction 13 Nov 02:05:** an earlier version of this line said CDDIAG printed no counts; that was my filter cutting the transcript, the lines are there.
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

---

# G. Rerun at the fixed heads (13 Nov 03:00): PR 2050's checks and step 5's CDGRAPH fix

**Build:** `claude/trust-proof-checks` at `03af5393` (the fix `08781653`, step 6's head merged in, carrying step 5's CDGRAPH fix `d0cf644c`), Civil 3.0.90 build, 0 errors, 51 s, loaded in the core console from a scratch folder. Nothing installed.

**FOR TIM**

1. **The four proof checks all PASS now.** Opening line (TRUST-OPEN-01), read-only door (TRUST-READONLY-01), update count (TRUST-UPDATE-01) and Unknown instead of 100 UPVC (TRUST-UNKNOWN-01). The pit-label check from the older harness (MODELSPACE-CASE-01) also PASSES, so it was unblocked by the same fix. Seen to pass.
2. **Each check also proves it can fail.** The two that run a deliberately faulty version noticed it all three ways: the drawing's own object events, CE's stored record text, and CE's record in memory (20 changed and 4 added objects for the opening check's faulty version; 23 changed and 5 added for the read-only one).
3. **Step 5's CDGRAPH fix works in a real run.** On the stray-line copy, CDGRAPH now says 49 pipes (it said 50), prints "CE's record holds 11 pits and 49 pipes. 1 line on a pipe layer is not in the record, so it is left out of this trace. Type CDCHECKCURRENT to see it.", and CDGRAPH and CDDIAG leave CE's record identical (49 pipes, same text before and after each). CDDIAG still prints its own numbers (11 pits, 49 pipes recorded). Seen to pass.

**Detail, answering the foundations lane's two questions**

1. **Does merely reading fire an object event in the core console?** Not in these runs: both "real" halves report no changed, added or erased object. The faulty halves did fire them, as intended.
2. **What the faulty-version lines say:** "drawing objects: N changed, M added, 0 erased (changed DBDictionary, changed Xrecord, added DBDictionary, ...); CE's stored record; CE's record in memory". All three detectors fired for both faulty versions.
3. **Not shown:** the real "CE updated its record" line after Edit Pit and PIT (windows and prompts: not headless); Undo on the new build; the opening line itself on a real drawing opening (the check proves the counting and the no-write rule through CE's own code, not the idle event).
4. **A mistake I made twice tonight, so you can trust the corrected file:** my transcript summary stops at 60 lines, and CDGRAPH prints more than that, so lines after it can be cut. The CDDIAG lines are present at both heads (read from the full console file).

---

# H. Core-console matrix, 13 Nov 07:41 to 08:03 (every head built fresh under the build lock; nothing installed)

Each line: seen to pass, seen to fail, or could not be run (BLOCKED means this build does not have the thing the check drives, which is expected for an older branch, not a fault).

**FOR TIM**

1. **PR 2064 (cancel writes nothing), head `dde7825e`: all seven checks PASS.** Cancelled-command check (TRUST-CANCEL-01), the Esc check in a drawing with no Civil mark (TRUST-CANCEL-02), the opening line, the read-only door, the update count, Unknown instead of a guess, and the pit label. Each faulty version was noticed. Core console only: the real-AutoCAD rows are still open.
2. **PR 2073 (the BUG-1456 cure), head `1a28c3b3`: its check PASSES.** While CE held another drawing's record, the end of PIT, CDHELP and CDS, the flush and a save aimed at this drawing all wrote nothing into this drawing; the installed writer with no check did write it and was noticed.
3. **PR 2083 (the change door), head `522e5502`: its first check PASSES, its second FAILS, and the failure is the check's own fault.** The refusal worked (the three refused changes left the record at 2 pits). The check's own tidy-up read a stale list afterwards. The foundations lane has the fix (not yet pushed) and says to rerun it in the 2:00pm window.
4. **PR 2045 and 2049 (steps 5 and 6): all four proof checks PASS on 2049; on 2045 three pass and one is BLOCKED** because Unknown-instead-of-100 is step 6's work, not in step 5's branch.
5. **PR 2041 (the opening line) alone: the opening check PASSES; the other three are BLOCKED** because step 5 and step 6 are not in that branch.
6. **Not covered tonight:** PR 2078 (no headless check exists; it needs the build loaded in real AutoCAD), the Structural pull requests (2044, 2046, 2047), the ribbon (2038), and PR 2083's second check after its fix.

**DETAIL (the lines the harness printed)**

1. 2073 `CEPROOFCROSSDRAWING`: PASS BUG-1456-CROSS-01.
2. 2083 `CEPROOFCROSSDRAWING`: PASS. `CEPROOFCROSSCHANGE`: FAIL BUG-1456-CROSS-02: "the check did not leave CE's record as it found it (3 pit(s), 1 pipe(s) ... was 2 pit(s), 1 pipe(s) ...)". Detail: 2 pits at the start; 2 after three refused changes; 3 with a pit put straight in (the faulty version, noticed); 3 with the record the drawing's own and a pit added; 3 at the end. The foundations lane's reading: the check kept counting a list CE replaces on every save.
3. 2064 `CEPROOFTRUSTCANCEL`, `CEPROOFTRUSTESC`, `CEPROOFTRUSTOPEN`, `CEPROOFTRUSTREADONLY`, `CEPROOFTRUSTUPDATE`, `CEPROOFTRUSTUNKNOWN`, `CEPROOFPITLABEL`: PASS each. CANCEL faulty half: "drawing objects: 7 changed, 1 added, 0 erased"; READONLY faulty half: "23 changed, 5 added".
4. 2045 (`d0cf644c`): OPEN, READONLY, UPDATE PASS; UNKNOWN BLOCKED ("CE's TrustSettings has no ShowUnknownInsteadOfGuess"). 2049 (`98d81717`): OPEN, READONLY, UPDATE, UNKNOWN all PASS. 2041 (`31f426ab`): OPEN PASS; READONLY BLOCKED (no ReadOnlyToolLegacyUpdate); UPDATE BLOCKED (no ProjectDataService.LastRecordUpdate); UNKNOWN BLOCKED (no ShowUnknownInsteadOfGuess).
5. The older-head runs use the harness from PR 2050's head (`03af5393`, the probe) with each head's own Civil build, as the foundations lane planned.

---

# I. PR 2083 rerun at the fixed check, head `8a6decef` (13 Nov 09:06, PC clock; core console, nothing installed)

**FOR TIM**

1. **PR 2083's change-door check now PASSES.** While CE held another drawing's record, adding a pit, changing a pipe's ends and clearing everything all left the record alone. A change made with no check was noticed. And with the record the drawing's own, the pit was added. Seen to pass.
2. **Its cross-drawing check also passes again** (CEPROOFCROSSDRAWING).
3. **The earlier FAIL was the check's own fault** (a stale list); the fix is one test-tooling file, no plugin code.

**DETAIL**

1. Build: `claude/bug-1456b-record-change-door` at `8a6decef`, 0 errors. First rebuild attempt failed on an empty placeholder file my own tidy-up had removed (`CE_TRANSFORM_2027.arx`, a build copy step), not on the change; recreated and rebuilt.
2. Result lines: `PASS BUG-1456-CROSS-02` and `PASS BUG-1456-CROSS-01`. I did not keep the per-step pit counts (the evidence folder was cleared with my temp runs); the PASS line is the check's own verdict.
