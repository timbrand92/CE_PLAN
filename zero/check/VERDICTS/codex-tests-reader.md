# Answer: the single drawing reader test list (C9), codex/tests-reader at d51a990

**Answer: HOLD THE LIST. Both halves hold it. First answer on this list: fix round one of two follows.** Written Sat 21 Nov 2026, about 12:54 am. Checked on the bench only.

**Who checked.** Honest: one Claude helper on Sonnet: `C:\CE_WORK\check\reports\reader_honest_REPORT.md` (every expected figure hand-worked and right; no contradiction of the accepted C11 list or the held rounding branch). Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\reader_adv_REPORT.md`, proofs in `reader_adv_proofs\` (a build that widens an unchanged pipe and strips a bend from a neighbour passed three targets). Counts true: 16 cases, 15 targets fail, the control passes; the whole solution builds; 674 older pretend-drawing tests pass; no report or run file.

## 1. Reasons to hold

1. **An unchanged 150 mm pipe can become 225 mm on the sheet** (both halves): the width target (`SinglePipeReaderTests.cs:29-43`) changes one pipe and reads only the start of the proposed label; a build forcing 225 on every reopened pipe passes. Add an unchanged pipe and a narrower one, and read each whole label after OK and reopen (D-349, D-380).
2. **A barrel edit can destroy a different pipe and pass** (both halves): the twin targets (`:145-167`, `:348-365`) have one pair and nothing else on the layer; a build that rewrites every polyline on that layer passed, while a separate 375 mm pipe lost its middle vertex. Add a second pair and an unrelated bent pipe, compared after the edit (D-349).
3. **"MIN." accepted where both inverts are typed** (both halves): the TRIM and EXTEND label check (`:221-230`) allows either ending; D-383 item 9 and D-413 item 9, and the accepted C11 list, require no "MIN." when both ends are typed: the whole label, exactly.
4. **Stage 2 targets counted as Stage 1** (both halves): the detention twins and the Detention window (`:145, 159, 169-185`) fail only because a window method looked up by name does not exist; mark them WAITING (D-347, D-377 item 1).
5. **The one-reader scan can reject a right reader and pass two** (adversarial): it requires one of three file names and particular spellings (`PipeReaderSourceTests.cs:58-139`); renaming a correct reader fails it, and a second reader written another way passes. Test behaviour: two routes, one answer.
6. **Correct behaviour can fail on a private name** (adversarial): `:204-207` demand a writable property called CoverStations and inject into an opened context; `:339-357` invent drawing records in the helper. Drive the window and the drawing as a drafter would.

## 2. To fix in the same round

The cover targets (`:109-212`) take the top of pipe as the nominal size alone: mark them DRAFT D-426 (one wall) and restate when U-086 closes.

## 3. Binding probes for the build (D-431)

Keep the adversarial wrong-build cases (`reader_adv_proofs\`) for the build check: every reopened pipe keeps its own width; no neighbour on the same layer changes in any edit.
