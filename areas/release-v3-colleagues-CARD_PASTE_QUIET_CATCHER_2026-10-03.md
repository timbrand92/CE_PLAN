# Workflow card: the quiet paste catcher (BUG-342 part 1 / BUG-366)

**Status: approved by Tim 4 Oct 06:45 (INT-048, his words "PASTE - YEP"; desk reading: a paste of CE pits or pipes into a drawing with no drainage wakes Civil for that paste with one plain line, run CDREPAIR, only for CE pits and pipes). Opus review MED 1 + LOW 2 fixed on #567 head ff0da1bf; round 2 LOW 1 fixed and branch moved onto claude/rel-20261015f (C-15, Civil 3.0.29) at a854d867 (build/04, 4 Oct); Opus re-review needed. Earlier: DESIGN ACCEPTED BY THE DESK, 3 Oct 2026 (controller 06).** The code is on draft PR #567 (branch `claude/c11-quiet-paste-catcher`, base `claude/rel-20261015f`); INT-048 says it may ship once the Opus re-review says MERGE. Nothing here is Installed or Tim-accepted.

Authority: `PASTE_NO_DRAINAGE_READ_2026-10-03.md` (the source read and Option A), BUG-342 and BUG-366 in `BUG_CARPARK.md`, `DRIVER_RUN8_2026-10-03.md` (the real PASTECLIP that printed nothing), #393 (Civil stays quiet in Structural drawings), R-27 (warn, never block), the native protection rule (never unlock a layer).

## What works today, and what is wrong

1. **Paste into a drawing that already has drainage:** works. CE tracks the paste and prints one line at the end.
2. **Paste of CE pits and pipes into a drawing with NO drainage (a blank or Structural drawing):** CE says nothing. The pasted pits keep the other job's links, and nobody is told to run CDREPAIR. This is BUG-342 part 1, seen again live in driver run 8 (46 objects pasted, 143 to 189, no line, Civil never woke).
3. **Why:** a quiet drawing only wakes for a paste when one pasted object is a one-piece CE pipe object. Pits never wake it. Ordinary (older style) pipes never wake it. On a colleague's PC the pipe upgrade is held, so their pipes are always ordinary and this paste is silent every time.

## Tim's intended result

Not yet recorded in his own words for this card. The standing rulings that apply: Civil stays quiet in a Structural drawing (#393); no hard blocks, warn and carry on (R-27); one U undoes one command. The desk accepted the design below on 3 Oct 2026.

## Classification

1. **Paste/insert tracking in a quiet drawing:** Modify (add a watcher at the end of the command).
2. **The "run CDREPAIR" line and its wording:** Keep, unchanged.
3. **Quiet Structural drawings for everything that is not a real CE paste:** Keep.
4. **CDREPAIR:** Keep (it is what the line points to).

## The full experience

1. **Trigger:** Ctrl+V (PASTECLIP), PASTEORIG, PASTEBLOCK, INSERT or -INSERT into a drawing CE has decided has no Civil content. Nothing new to learn.
2. **During the paste:** nothing visible. CE quietly remembers which block references and polylines the command added (memory only, no drawing access, capped at 3,000 of each).
3. **At the end of that paste, CE asks the existing "is this a real CE pit or pipe" check.** It counts a block as a pit only when it carries CE pit notes, a CE identity key, or a pasted pipe ends inside it. It counts a polyline as a pipe when it is a CE pipe object, carries a CE pipe record, or is on a configured pipe layer.
4. **If it finds real CE pits or pipes:** Civil wakes for that drawing and prints ONE line, the same wording as today, for example: `[CE] 2 pits and 1 pipe pasted from another drawing are not in the schedule yet: run CDREPAIR.` (When CE cannot prove the other drawing, the middle words are `just pasted`: `[CE] 2 pits and 1 pipe just pasted are not in the schedule yet: run CDREPAIR.`) The line is printed once, by the same clean-up a woken paste already gets, so the pasted pits also get their own identity as far as AutoCAD's copy map allows.
5. **If it finds none:** nothing is printed and Civil stays quiet.
6. **Diagnostic:** one line in the CE log (not on the command line) each time a quiet drawing is pasted into, saying whether AutoCAD's clone event fired and what it carried. It settles in one real paste whether that event fires in a real PASTECLIP.
7. **CDREPAIR afterwards:** unchanged. It registers the pasted pits and pipes.

## What stays silent (by design)

1. **A Structural drawing pasted with plain geometry, text, hatches, dimensions.** No line, Civil stays quiet.
2. **A lone legend or detail block with a pit-like name and no CE notes, no identity key and no pipe ending in it.** No line, Civil stays quiet (finding 10 stays).
3. **A paste that adds nothing the check recognises.** No line.
4. **A pit pasted on its own whose CE notes did not travel in the clipboard.** Silent under every option, because a pit-named block with no CE evidence is not counted. Whether the notes travel in a real PASTECLIP is an open Codex step; if they do not, the pits come with their pipes in the usual job paste, which is counted.

## Cancel, Escape, Undo, Redo, Save, reopen

1. **Cancel or Escape of PASTECLIP (before or after the insertion point):** nothing is written, nothing is printed, nothing is remembered. The memory is dropped when the command is cancelled or fails.
2. **Undo:** no new Undo step. The wake is a memory flag; the check is a read; the clean-up runs inside the paste command's own end, exactly as it does for a paste that already wakes Civil. ONE U removes the paste and its clean-up together.
3. **Redo:** U then REDO then U works as before. Nothing is written at the end of U, UNDO or REDO (the existing redo guards still apply).
4. **Save and reopen:** nothing is saved by this change. If the pasted pits are registered with CDREPAIR the record is saved as for any Civil drawing. If they are not registered, the drawing is quiet again at the next open (CE reads the stored record only at open, by design).

## A Structural drawing that receives real CE pits or pipes

1. **It is told once**, and Civil stays awake in that drawing for the rest of the session. That is the existing rule "content wins over a Structural name" (the same as a one-piece pipe object does today).
2. **The cost:** while awake, CE handles that drawing's edits again (the work the quiet mode saved). A drawing that only ever gets plain Structural geometry never pays this.
3. **Not changed:** Structural's own commands and ribbon; #393 for everything except a genuine CE civil paste.

## Colleagues' PCs

1. The one-piece pipe upgrade is held on every PC except Tim's sign-in, so colleagues' pipes are ordinary polylines. After this change an ordinary polyline on a configured pipe layer counts, so their paste is no longer silent.
2. They see the same single line. Nothing to switch on.

## Edge cases

1. **A paste of more than 3,000 block references or 3,000 polylines:** only the first 3,000 of each kind are checked; CE logs that the memory was full. Plain Structural pastes cost almost nothing (a type check per added item).
2. **A locked layer:** never unlocked. A pasted pit or pipe on a locked layer is counted in its own sentence, as today.
3. **A layout (paper space) paste:** the check counts items drawn in model space or a layout, never inside a block definition.
4. **A paste woken by the old path (a one-piece pipe object in the clipboard):** unchanged. The catcher does nothing extra there, so the line is not printed twice.
5. **PASTECLIP run inside an office LISP routine:** the paste's own end is what counts; a nested command ending inside it does not end the watch early.

## Example drawings

1. **A:** Run 8's case. Source `C:\ce_rc_drv\DRV1_B1.dwg` (2 pits and pipe 109E23, ordinary pipe likely), target a WRITABLE copy of `C:\ce_rc_vc7\NEWTGT_VC7.dwg`. Expect the line.
2. **B:** The one-piece pipe case. `C:\ce_rc_fix\FIX_MODERN_PIPE.dwg`, pipes 11C807 and 11C83E (CE pipe objects) into a blank copy. Expect the line ONCE.
3. **C:** Plain geometry and a lone pit-named block with no CE notes into a quiet copy. Expect no line and Civil still quiet.
4. **D:** A Structural drawing (writable copy) receiving case A's objects. Expect the line once.

## Checks

1. **Automated (builder):** a pure wake rule (command name, candidate facts) that wakes only when the existing line is non-null; a legend block, plain items, a lone pit-named block, a Cancel and a non-paste command never wake; source-text guards that the quiet branches call the catcher before their early return, that the catcher writes nothing and opens no transaction inside the reactor, that Cancel/failure drops the memory, and that the wake runs only for a paste/insert command.
2. **Driver or Codex (typed, writable copies only, never Tim's files):** the chain below. Evidence and screenshots; only Tim accepts engineering behaviour.

## The typed check chain for the driver

Use the PASTE section of `C:\Lisp Files\_ACAD_DRIVER\TYPED_FORMS_S8_C9.md` (section 3) for the helpers (`$H`, `$H2`, `J`, `T`, `z:n`). Only WRITABLE copies are opened for a target; the source may be read-only. Nothing is saved. Nothing else is copied while the test runs (the clipboard is Tim's Windows session).

1. **Pre-check in the source, before COPYCLIP:** `T '(cdr (assoc 0 (entget (handent "109E23"))))'`. Record `LWPOLYLINE` (ordinary pipe) or `CE_CVL_PIPE_OBJECT`. Expect the CE line either way after this change.
2. **Case A (the run 8 case):** copy `C:\ce_rc_vc7\NEWTGT_VC7.dwg` to `C:\ce_rc_drv\DRV3_NEWTGT.dwg`; open the source `DRV1_B1.dwg`; select the 46-object window and check the five handles as in section 3; COPYCLIP; open the target; run the helpers; `$n0 = J '(z:n)'`; `T '(progn (command "_.PASTECLIP" (list 0 0 0)) (princ))'`; wait 12 s; `T '(z:n)'`.
   1. **Expect:** `ENTS` is `$n0` plus about 46; ONE line `[CE] 2 pits and 1 pipe pasted from another drawing are not in the schedule yet: run CDREPAIR.` (or the `just pasted` variant); not printed twice.
   2. **CE log (read only):** `Get-ChildItem "$env:APPDATA\CE_CVL_SUITE\logs\ce_cvl_structured_*.log" | sort LastWriteTime | select -Last 1 | Select-String 'PasteCheck|CivilQuiet' | select -Last 12`. Expect the new diagnostic `[PasteCheck]` line for the quiet paste, then `[PERF] CivilQuiet: Civil switched on for this drawing (...)`, then the `summary:` line. No `eNotInBlock`.
3. **Case A, U and REDO:** reopen the target fresh (source stays open, do not copy again), paste, wait 12 s, then `T 'U'`, wait 12 s, `T '(z:n)'` (expect `$n0`; record the word the U echo names). Third run: paste, 12 s, `U`, 12 s, `REDO` (expect `Everything has been redone`), 12 s, `(z:n)` (the pasted figure), `U`, `(z:n)` (back to `$n0`). **Failure:** a second U needed; `Nothing to redo`; the line printed twice; pits left after U.
4. **Case B (wakes by one-piece pipe objects):** open a WRITABLE copy of `C:\ce_rc_fix\FIX_MODERN_PIPE.dwg` as the source; confirm `(cdr (assoc 0 (entget (handent "11C807"))))` reads `CE_CVL_PIPE_OBJECT`; copy a window holding pipes 11C807 and 11C83E (and any pit at their ends); paste into a fresh writable blank copy. Expect the line ONCE (the old wake path), and in the CE log `Civil switched on by this PASTECLIP` (the old line), not twice.
5. **Case C (stays quiet):** in a fresh writable blank copy draw nothing; in the source (any writable copy) COPYCLIP a plain LINE and a plain polyline on layer 0 plus one inserted block named like a pit but with no CE notes (a legend symbol); paste. Expect NO `[CE]` line; the CE log has the diagnostic line, no `Civil switched on`.
6. **Case D (a Structural target):** repeat Case A with a writable copy of a Structural fixture drawing as the target (the controller names it). Expect the line once; the Structural palette and commands still work afterwards (open the Structural palette by its typed command).
7. **Cancel (by hand, Tim or Codex with a person; the driver cannot send Esc):** COPYCLIP in the source, in the quiet target run PASTECLIP, press Esc at the insertion prompt. Expect no line, no change in object count, no Civil switch in the log, no Undo step added (a following U must not undo the paste that never happened).
8. **Before and after every run:** hash `%APPDATA%\CE_CVL_SUITE` and `%APPDATA%\TIM_CE_CADTOOLS` settings and copy the logs aside; compare afterwards. Close each drawing without saving.

## Tim's 5-step AutoCAD check

1. In a drawing with drainage, copy two pits and a pipe (Ctrl+C).
2. Open a NEW blank drawing and paste (Ctrl+V). Confirm one line says the pits and pipe are not in the schedule yet and to run CDREPAIR.
3. Press U once. Confirm the paste is gone completely. Press REDO, then U again.
4. Paste again, run CDREPAIR, and confirm the pits and pipe now appear in the Pit Schedule.
5. In a Structural drawing, paste only plain lines and text, and confirm CE says nothing.

## Risks

1. **Reactor path on every paste and insert in every quiet drawing.** The extra work while watching is a type check and a set insert per added object; at the command end it is one read pass over at most 3,000 blocks and 3,000 polylines. A Structural paste of thousands of ordinary polylines pays that read pass once (an estimate: up to a few hundred milliseconds; the first AutoCAD run will measure it).
2. **Real PASTECLIP behaviour is not yet observed.** Whether AutoCAD's clone event fires in a real PASTECLIP, and whether CE pit notes travel in the clipboard, are unproven. The catcher does not depend on the clone event (it uses the objects added), but the pasted pit's own identity clean-up for labels is better when the event fires. If the event does not fire, the paste is still told to run CDREPAIR and CDREPAIR does the clean-up (proven PASS in the headless probe).
3. **A Structural drawing stays awake after a CE paste for the session.** Deliberate; same as the existing one-piece pipe rule.
4. **Pit-only paste with no CE notes and no pipe ending in it stays silent.** By design (a legend block is indistinguishable).
5. **No Undo step added, nothing unlocked, nothing blocked.** The wake is a memory flag; every write is the existing clean-up inside the paste command's own end.

## Open questions

None for Tim. The plan already answers: quiet Structural (#393), no hard blocks (R-27), settings own values (R-00, nothing hard-coded here; the 3,000 cap is a memory guard, not an engineering value).
