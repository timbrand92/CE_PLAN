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


---

# Second answer: codex/tests-reader at 675b81e (its last round)

**Answer: HOLD THE LIST, with a one-page open list of ONE item; under the standing rule (STATE item 49) one bounded edit, read back by the check room alone, then ACCEPT THE LIST.** Written Sat 21 Nov 2026, about 1:54 am. Checked on the bench only.

**Who checked, and how they split.** Honest: one Claude helper on Sonnet: `C:\CE_WORK\check\reports\reader2_honest_REPORT.md`: ACCEPT, with three binding probes. Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\reader2_adv_REPORT.md`, proofs in `reader2_adv_proofs\`: HOLD on one. Five of the six reasons CLOSED (each pipe keeps its own width, read whole after reopen; neighbours protected, in the WAITING detention list; no "MIN." with both inverts typed; detention WAITING; the one-reader test through two routes); the sixth PARTLY; the D-426 cover rows marked DRAFT. Both earlier wrong builds now fail.

## 4. The open list (the bounded edit: this item only)

1. **The bent-pipe cover test demands an input the window does not have:** `SinglePipeReaderTests.cs:308-315` requires a visible, enabled garden picker in the Pipe window before it checks either end; D-409 item 1 made "what is over it" a read-off in step 2, taken from the drawing. A correctly read garden surface was rejected. Supply the surface as a drawing read-off, reopen the bent pipe, and check both ends (proof: `reader2_adv_proofs\read-off-comparison.txt`).

## 5. Binding probes for the reader BUILD (D-431)

Every reopened pipe keeps its own width; no neighbour on the same layer changes in TRIM, EXTEND, BREAK or a twin edit (a Stage 1 case, not only the WAITING detention one); a typed grade such as 200.0049996 is printed as typed (D-154, D-413 item 3; D-432 item 1 could be read the other way: a question for Tim, not for the build to settle by guessing).

---

# Read-back of the bounded edit: codex/tests-reader at 536cb01

**Answer: ACCEPT THE LIST.** Written Sat 21 Nov 2026, about 2:25 am, by the check room alone (the standing rule). The edit: one file (`SinglePipeReaderTests.cs`), 12 lines in, 13 out; nothing else changed.

1. **Read:** the garden picker demanded of the Pipe window is gone; "what is over it" is written into the pipe's own record as a drawing read-off (source "measured", D-409 item 1), the window shows it with its source and needs 300 mm, and the bent pipe's cover is checked at both ends.
2. **One run by the check room** (own worktree, whole solution built, 0 errors, the plug-in included): 16 cases: the control passes, 12 targets fail on what the product does, 3 skipped with their reasons (detention, Stage 2).
3. **What this means:** the list may go to the main line as one squashed commit. The reader BUILD owes section 5's binding probes (each reopened pipe keeps its own width; no neighbour changes in a Stage 1 edit; a typed grade printed as typed, a question for Tim). Nothing about the product is accepted.
