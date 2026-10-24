# Runner hardening, cases R01 to R10 after the Opus review (Sun 25 Oct 2026)

Written Sun 25 Oct 2026 about 03:30 Melbourne (PC clock) by the Team Sonnet job "TEST RUNNER: HARDEN CASES R01-R10 AFTER THE OPUS REVIEW". Real AutoCAD 2027 on test copies only, one session at a time under the shared lock as `Claude-driverv3`, every session released. Build under test: **Civil 3.0.74 (a15b414c), Structural 1.0.123, Manager 1.1.74** (the build moved from 3.0.72 to 3.0.74 while the job was queued; everything below was re-run on 3.0.74). Nothing in `DESK_LOG.md` or `BUG_CARPARK.md` was edited. Nothing here is Tim-accepted, nothing is Codex-accepted, and **no case has an independent review of its new text yet**, so no case may be called Claude-accepted by this report.

## ANSWER FIRST

1. **R08 / BUG-861 verdict: the old R08 failure came from the test route, not from CE.** The old case read AutoCAD through COM (the view, the pit, the pick-first set) between U and REDO. Those reads lose REDO on their own:
   1. **(a) Real-mouse pick of the pit with NO read between U and REDO:** REDO kept **5 of 5** sessions on 3.0.74 (runs k1A1 to k1A5). The new R08 does five rounds per session and kept REDO in all five rounds in three sessions (k8R1, hdnA4, hdnB4b): 15 rounds, which with the 5 single-round sessions above make 20 pit-pick rounds, 20 times "Everything has been redone". On 3.0.72 the same design kept REDO 4 of 4 with the checked text (hA7 to hA10) and 3 of 3 with an earlier text (hA4c to hA6).
   2. **(b) The same reads and a hover over the pit, but NO pick:** REDO lost **5 of 5** (k1B1 to k1B5). A single `pick-read` alone loses it (2 of 2, k1F1 and k1F2). A view read plus a pit data read alone keeps it (2 of 2, k1G1 and k1G2). Waiting 12 seconds with nothing else keeps it (k1E1).
   3. **(c) The old route, a real-mouse click with the runner's proof reads:** REDO lost **5 of 5** (k1C1 to k1C5). The same route on a **plain AutoCAD line** (no pit, no CE object) also lost REDO **5 of 5** (k1D1b to k1D5).
   4. **What this shows about CE (BUG-861):** CE does not lose REDO after U plus a real pit pick in 20 rounds across 8 fresh AutoCAD sessions on 3.0.74, when the runner reads nothing in between. The 5-of-5 loss in the old R08 was caused by the driver's reads (it happens with no pick at all, and with a plain line).
   5. **What it does NOT show:** (i) It does not prove Codex's first-control-run loss in V4 and V6 (a freshly opened drawing, Inspector showing, hand picks) had the same cause; that stays unexplained. (ii) The right-click CE menu half of BUG-861 and BUG-416 is not covered. (iii) A pick in plain AutoCAD **with CE not loaded** was not run: CE loads from Tim's live `ApplicationPlugins` bundles, and the only way to start AutoCAD without it is to rename those live bundle folders, which this job is not authorised to do. Control D (plain line, CE loaded) is the nearest. (iv) Whether CE or AutoCAD makes AutoCAD refuse COM calls for over 60 seconds right after a pit pick in a reopened drawing is unexplained (see item 4.4 below).
   6. **BUG-861 stays open.** The desk may ask the Opus reviewer to re-review R08 for the "one drawing, real-mouse pick" half only.
2. **Per case (both evidence sessions, the red variant, what changed, runtime).** "Pass A" and "pass B" are two separate AutoCAD sessions on 3.0.74, recorded in the ledger.
   1. **R01 PIT and CD keep placing:** PASS (A: hdnA1) and PASS (B: hdnB1). Red variant R01_BROKEN: **FAIL, yes** (hdnA2v, k4V1). Changed: now places a **second pit and a second pipe** in one PIT run and one CD run (new setup `SETUP-P8x2`, second pick by real mouse), asserts 2 pits, 2 pipe objects, 2 arrows, 4 IL texts, 6 texts, no window left open, "completed" outcome lines for PIT and CD, never "cancelled", and that ONE U takes back only the last pipe. Runtime about 13 to 15 minutes a session.
   2. **R02 pipe joins the pit:** PASS (hdnA2) and PASS (hdnB2). Red variant R02_BROKEN (CD starts 2 m off the pit): **FAIL, yes** (hdnA2v: it printed `Flow: Open end -> Open end`, the BUG-560 drift, and the pipe box sat at x 152000). Changed: exactly one pipe and one pit, the line must appear once, and the pipe's box corner must sit at x 150225 y -80112.5 (+-50 mm), where CE moves the pipe end to the pit wall. Runtime about 15 minutes for R02 to R04 together.
   3. **R03 one IL text each end:** PASS (hdnA2) and PASS (hdnB2). Red variant R03_BROKEN: **FAIL, yes** (hdnA2v, k6V2). Changed: the two distances are tightened to 800 mm (462.5 and 270.8 mm are read). **The review's red was wrong:** `options.createText false` does NOT remove the IL texts (it only switches the pipe label text; the variant PASSED in k6V1). The red now ticks both "Hide invert text" boxes in the New Pipe window; the pipe is still placed (that check passes) and the IL texts are 0.
   4. **R04 CE never saves:** PASS (hdnA2) and PASS (hdnB2). Red variant: **no red is possible inside a case** (a red needs something to save the drawing, which cases ban). The offline self-test (item 6.3 below) shows both checks go red on a changed copy and on a stray file. Changed: header only (PROVES_BUGS line, none). **Question for the desk and Tim: accept R04 with the offline red as a written exception?**
   5. **R05 outcome line:** PASS (hdnA3) and PASS (hdnB3). Red variant R05_BROKEN (`options.commandOutcomeLines false`): **FAIL, yes** (hdnA5, k7V1: all five log checks fail). Changed: the wrong sentence is corrected (CDCHECKCURRENT opens the What CE Found palette), the "<n> ms" format is checked, and a PIT stopped at its first prompt must log `Command outcome: PIT cancelled` once and never `completed`. Runtime about 3 minutes.
   6. **R06 About CE Suite:** not touched (needs a Codex look). See section 4.
   7. **R07 Settings opens, Cancel closes:** PASS (hdnA3) and PASS (hdnB3). Red variant R07_BROKEN: **FAIL, yes** (hdnA3, k5V1, k9L1). Changed: all eight tabs are checked, and spec C14 is now covered: one field (Drafting, Label slide step) is changed to 123 with the settings guard armed, the window shows it (the "No changes" line goes), Cancel closes it, and the four settings files are byte-for-byte unchanged. Runtime about 1 minute inside a 3-minute session.
   8. **R08 REDO after a pit pick:** PASS (A: hdnA4) and PASS (B: hdnB4b; hdnB4 was BLOCKED at calibration, see item 4.5). Red variant R08_BROKEN (a pick-first read between the click and REDO): **FAIL, yes** (hdnA4b, k5V1). It is a **true red**: REDO really is lost. Changed: rewritten with the blind click route, five rounds, a per-round check that the second LINE drew, and one proof that the blind click selects pit 109D56. Runtime about 10 minutes.
   9. **R09 DP1 double-click:** not touched. **Real fault, BUG-859 round 3 (#1676) is not installed.** See section 4.
   10. **R10 CDCHECKIGNORE switch off:** PASS (hdnA3) and PASS (hdnB3). Red variants: R10_BROKEN (`checks.allowIgnoreFinding true`): **FAIL, yes** (hdnA6, k7V2); R10_SAVE_BROKEN (a CDSYNC after the refusal): **FAIL, yes** (hdnA3, k5V1). Changed: asks nothing (`CMDACTIVE` = 0), logs `Command outcome: CDCHECKIGNORE refused`, and the Civil log must hold **no `Project data saved to DWG` line** (the BUG-863 symptom). DBMOD is also read but it stayed 1 before and after (already modified at open), so it adds little; the log line is the real check. Runtime about 1 minute inside a 3-minute session.
3. **Which cases the desk may now ask the Opus reviewer to re-review as CLAUDE-ACCEPTED-READY:** **R01, R02 (start-on-a-pit half only), R03 (counts and which end only; the leader and the label position are not covered), R05, R07, R08 (real-mouse pick half only) and R10 (switch-off half only).** R04 only if the desk and Tim accept the offline red. **Not R06 (needs a Codex look) and not R09 (real fault).** I did not fill any `reviewed_against` line and wrote no review file.
4. **Things that went wrong or need a person:**
   1. **R03's red needed a different switch** than the review named (above). The first red attempt PASSED and was kept as evidence (k6V1), not as a ledger entry.
   2. **R02 cannot check the pipe's first vertex.** `ent-read` of a pipe object returns only its handle, object and layer. The join is proved by CE's own command line plus the pipe box corner.
   3. **R01 needs real mouse clicks for the second pit and second pipe** (typed text is lost while CE waits at a prompt). It therefore runs only outside Tim's hours.
   4. **R08_BROKEN was BLOCKED "AutoCAD busy" twice** (hdnA3, hdnA4) when it ran as a later case in a session (after a reopened drawing): the `pick-read` right after the pit click got "call rejected" for 61 seconds. Run first in its own session it FAILS as intended (k5V1, hdnA4b). Unexplained. R08 itself ran first in its sessions every time.
   5. **hdnB4 (R08, pass B) was BLOCKED at calibration** and the runner then stopped with `Exception setting "CalibRetry": property cannot be found` (a defect in the runner's own retry path, not mine). A plain re-run (hdnB4b) passed.
5. **Unproven and left open:** R06 and R09 (section 4); the pipe's end-on-a-pit half of UX-PIPE-02; CDREBUILD and PITSCHEDULE under R04; the right-click half of BUG-861; Tim's question inside R03 (the IL leader); stored project data, the leader and label positions are not read by any case.
6. **Runtime.** 71 AutoCAD sessions in this part of the job (Sat 24 Oct 18:04 to Sun 25 Oct 03:19, about 9 hours; the control sessions k1 took about 6 minutes each, the setup probes k2 about 8 to 12), plus 21 control sessions on 3.0.72 done by an earlier part of this job (runs hA, hB, hE). Longest session about 16 minutes (R02 to R04). Every session ended clean: no acad.exe left, lock released, Tim's four settings files back by hash (checked at the end: CD ACD64E79A33B, CS 622A246F7D3B, settings.json EFE307C4FC74, Structural 2972CE70C514).

## 1. The R08 control design, in detail

**Why the question mattered.** The review said the 5-of-5 "Nothing to redo" after a pit pick could come from the runner's own reads between U and REDO. Old R08 did three things there that the no-pick control never did: it read the view, the pit and the pick-first set through COM, it brought AutoCAD to the front, and it clicked.

**The sequence under test** (every arm, one round per fresh AutoCAD session unless stated): zoom to pit P3, draw a LINE, U, a step, wait 12 seconds, REDO, read what the command line says. Each arm first runs a no-pick control round (LINE, U, REDO) that must say "Everything has been redone", and checks that U really took back the LINE (an earlier draft undid its own ZOOM instead).

1. **Arm A, blind real-mouse click, no read between U and REDO** (`cases\controls\R08c_A_blind`): kept REDO **5 of 5** on 3.0.74 (k1A1 to k1A5, Sat 18:06 to 19:59).
2. **Arm B, the same reads and a mouse hover, no click** (`R08c_B_reads`): lost REDO **5 of 5** (k1B1 to k1B5).
3. **Arm C, real-mouse click with the runner's usual proof reads** (`R08c_C_mouse`, the old R08 route): lost REDO **5 of 5** (k1C1 to k1C5).
4. **Arm D, the same route on a plain AutoCAD line** (`R08c_D_plainline`): lost REDO **5 of 5** (k1D1b to k1D5; k1D1 was BLOCKED "AutoCAD busy" at the first step and re-run).
5. **Narrowing arms:** E (12 second wait only) kept REDO (k1E1). F (one pick-first read only) lost it (k1F1, k1F2). G (view read plus pit data read only) kept it (k1G1, k1G2). So the read that loses REDO is the pick-first read.
6. **Does the blind click really pick the pit?** Arm J (blind click, then read the pick-first set, no REDO): the set held pit 109D56, 1 object, **2 of 2** (k1J1, k1J2). Arm H (pick-first read AFTER REDO) read 0 objects (k1H1, one run): the selection is gone by then, so the proof has to come from J, not from after REDO. Arm I (typing LIST after REDO) printed no listing (k1I2, inconclusive; k1I1 was refused for a missing -Force).
7. **3.0.72 history:** hA7 to hA10 (4 runs, checked text) kept REDO 4 of 4 and hA4c to hA6 (3 runs, earlier text without the LINE check) 3 of 3; hB1 to hB5 (5 runs, reads and hover) lost it 5 of 5; hA1 to hA3 lost it with an earlier text of arm A that did not check the second LINE, cause not recorded, not counted.
8. **CE not loaded:** not run. See item 1.5 (iii).

## 2. What changed in each case (files in `C:\Lisp Files\_ACAD_DRIVER\cases`)

The text before each change is saved in `cases\previous\<case>.v1_before_harden.case.txt` (the folder is not run by the runner). Hardened cases were edited in place; the case SHA-256 changed, so any earlier ledger record belongs to the old text. Final SHA-256 (first 12): R01 99BC70E23675, R02 F4F2019CD026, R03 4384D2D7B6B9, R04 EEFB27776F8A, R05 4E5A615417F8, R07 C35F05BD147A, R08 4A42C588E549, R10 BFE0DD9A76D8; variants R01_broken 8D6A64A5E2DD, R02_broken CF4B9FCEC37A, R03_broken 5306E08120E5, R05_broken ADF4E7646481, R07_broken 6D4A87C56915, R08_broken 9793E1E72734, R10_broken 8FCF5432C138, R10_save_broken 015862A667C3; setup SETUP-P8x2 81152F70E476. R06 (C783FF31387F) and R09 (E08D471171A9) are unchanged.

1. **PROVES_BUGS lines (the desk's addition, read from each case and card, not guessed):**
   1. **R01:** BUG-862, the "completed" half only (PIT and CD runs that placed objects and ended by Esc are logged completed).
   2. **R02:** none. BUG-560 is a click-based fault and this case types the pit centre, which BUG-560's own update says worked.
   3. **R03:** none (UX-CPLAN-26 has no bug entry).
   4. **R04:** none (UX-STD-03, no bug entry).
   5. **R05:** BUG-862, the "cancelled" half only.
   6. **R06:** none. Its PLAN_ITEM names BUG-852, which this case cannot test (BUG-852 is about a PC without Structural). Left as is, see section 4.
   7. **R07:** none.
   8. **R08:** BUG-861, the one-drawing real-mouse-pick half only.
   9. **R09:** BUG-859 when it passes. It FAILS today, so it proves nothing yet. Left as is.
   10. **R10:** BUG-863 (the off path saves no project record) and BUG-862 (the "refused" half only).
   BUG-862 is therefore covered across three cases: completed (R01), cancelled (R05), refused (R10). Each case names only its own part.
2. **R01 route facts (probes PRH1 to PRH10):** typed text is lost while CE waits at a prompt, so the second pit and second pipe use `v3 pt-click -Blind` and a right-click as Enter; after the New Pit window CE asks the label point (a click) and the cover text (one Esc); to end a run after a mouse click use `v3 esc-key`, because the v2 `esc-prompt` does nothing then. Each PIT or CD "instance" writes its own outcome line.
3. **The offline red for R04** (`C:\ce_rc_scratch\harden\r04_selftest.ps1`, scratch, not a build script; it copies a drawing to a scratch folder and never touches a drawing AutoCAD has open). Output, 25 Oct 2026:
   1. untouched copy: `copy-unchanged` Ok=True (SHA-256 34BBE37C2EA4 vs 34BBE37C2EA4, last written same); `folder-new-only` Ok=True (none).
   2. scratch copy changed by one byte: `copy-unchanged` **Ok=False** (SHA-256 3FCA641A012B vs 34BBE37C2EA4, last written DIFFERENT).
   3. a stray `.dwg` appears beside it: `folder-new-only` **Ok=False** (R04SELF_B1_SAVED.dwg not expected).
   4. RESULT: the two R04 checks pass on an untouched copy and FAIL when the copy changes or a file is added.

## 3. The four conditions, case by case (RULES.md acceptance amendment, 24 Oct)

"Nothing to see" means nothing the drafter must look at. "Two passes" means two separate sessions on one build, same case text. "Red" means a recorded FAIL on a broken variant of the same text. "Reviewed" means an independent reviewer has written it; **it is NOT MET for every case because I may not fill it.**

1. **R01:** nothing-to-see MET; two passes MET (hdnA1, hdnB1); red MET (R01_BROKEN); reviewed NOT MET. Covers: the keeps-placing loop for PIT and CD, what Esc keeps, what one U takes back, the completed word. Does not cover: sizes, label look, Undo of the first pit.
2. **R02:** nothing-to-see MET; two passes MET (hdnA2, hdnB2); red MET (R02_BROKEN); reviewed NOT MET. Part only: a pipe started on a pit joins it. Not covered: a pipe ending on a pit, the Pit Schedule row, the pipe's first vertex.
3. **R03:** nothing-to-see MET for the count and which end (the exact text position is a label position, a Codex look); two passes MET; red MET (R03_BROKEN, UI route); reviewed NOT MET. Tim's word is still needed on the IL leader (his 27 Sep ruling asks for "a short leader", not built).
4. **R04:** nothing-to-see MET; two passes MET; red **NOT MET in the runner**, met offline only (item 2.3); reviewed NOT MET. Covers PIT, CD, CDSYNC, CDRECOVERINVERTS; not CDREBUILD or PITSCHEDULE; a save at drawing close is not checked.
5. **R05:** nothing-to-see MET; two passes MET (hdnA3, hdnB3); red MET (R05_BROKEN); reviewed NOT MET. Covers two commands (CDCHECKCURRENT completed, PIT cancelled), not "every CE command" and not Structural or Manager lines.
6. **R06:** nothing-to-see NOT MET (a look case); two passes met earlier on 3.0.72 only (not re-run on 3.0.74); red NOT MET; reviewed NOT MET. **Needs a Codex look first.**
7. **R07:** nothing-to-see MET; two passes MET (hdnA3, hdnB3); red MET (R07_BROKEN); reviewed NOT MET. Covers open, eight tabs, a changed value thrown away by Cancel, files unchanged. The window's look is not judged.
8. **R08:** nothing-to-see MET; two passes MET (hdnA4, hdnB4b); red MET (R08_BROKEN, a true red); reviewed NOT MET. Covers the real-mouse pick half of BUG-861 only.
9. **R09:** **FAIL, real fault** (BUG-859). Not hardened. Conditions not applicable.
10. **R10:** nothing-to-see MET; two passes MET (hdnA3, hdnB3); red MET (R10_BROKEN and R10_SAVE_BROKEN); reviewed NOT MET. Covers the switch-off half of UX-DI-03 only.

## 4. R06 and R09, as asked

1. **R06 needs a Codex look.** It is a look case. Its picture `R06_about.png` (SHA-256 07A0C4C8D288) and look note still wait for a Codex verdict. Its PLAN_ITEM label is wrong (BUG-852; the right spec is C12), see the review item 6. It was not touched or re-run.
2. **R09 is a real fault, not a case problem.** BUG-859 round 3 (#1676, `dee2744f`) is not installed: the build under test is Civil 3.0.74 and the double-click on the DP1 downpipe still opened AutoCAD's own Enhanced Attribute Editor on 3.0.72 (R09 FAILED twice, same SHA E08D4711). R09 was not changed and not re-run on 3.0.74 in this job. The review's three fixes (Tag box name, a real Cancel press, the other parts of the symbol) are still to do, and must be done before the next Civil train goes in, so a later green on that train meets the red-before-green condition.

## 5. For the runner owner (not case faults, listed so they are not lost)

1. **`control-text ... absent` prints garbage evidence when it fails:** `window shows '[string]System.Management.Automation.OrderedHashtable[0].name'` (seen in R07_BROKEN). The verdict is right; the evidence text is not.
2. **`esc-prompt` (v2) does nothing after a mouse click** at a CE prompt (the log tail ends `Command:`); `v3 esc-key` works.
3. **`pt-hover` refuses a CE pipe object** (`do not know a point on a CeCvlPipeObject`); hover a block instead.
4. **`ent-read` of a CE pipe returns only handle, object, layer.** A verb that returns the pipe's first and last vertex would let R02 assert the join geometrically.
5. **The runner's calibration-retry path is broken:** `$pk.CalibRetry = ...` in `case_runner.ps1` line 200 sets a property the pack object does not have, so a calibration that needs a retry ends BLOCKED with `property 'CalibRetry' cannot be found` (run hdnB4). Calibration also failed twice at session start with "stored view 37 / 45 s old (limit 30)" (k2P5, k2P6 probes). Both are transient on a busy PC.
6. **A session only calibrates the pointer if the CASE (not its setup) has a `v3 pt-` step.** SETUP-P8x2 uses clicks, so R01 carries one hover step for that reason.
7. **Case order inside a session matters for R08_BROKEN** (item 4.4): run alone, it FAILS as intended.
8. **A case must never type a ZOOM before a U**: U undoes the zoom (R01's first draft read `U printed ZOOM`).

## 6. Files changed, listed loudly

1. **Driver v3, an additive switch, made earlier in this job (Sat 24 Oct 09:06):** `-Blind` on `pt-click`/`pt-hover`/`pt-rclick` (`acad_driver_v3.ps1`, `acad_driver_v3_session.ps1`, and the case-step parser in `case_runner_lib.ps1`). It needs the stored view (up to 180 seconds old), clicks a bare world point and reads nothing from AutoCAD before or after. Backups before the change: `C:\ce_rc_scratch\acad_driver_v3.ps1.bak_before_harden`, `...v3_session.ps1.bak_before_harden`, `case_runner_lib.ps1.bak_before_harden`. **v2 (`acad_driver_witness_v2.ps1` 120EE24D15B2) and both allow-lists untouched.** Hashes now: v3 7CADBF80D5AA, v3 session 9A7B8D210C7F, case_runner_lib 5AB2CBC1A5A0, case_runner 7E3BC77F93F4 (none changed during this part of the job).
2. **New in `cases`:** `_setups\SETUP-P8x2.setup.txt`; `controls\R08c_A` to `R08c_J` (ten control arms; the folder is not run by `run-pack`); `previous\` (the old texts); `variants\R01_broken`, `R02_broken`, `R03_broken`, `R05_broken`, `R07_broken`, `R10_save_broken` (new) and `R08_broken`, `R10_broken` (rewritten; the old flipped ones are in `previous\`).
3. **No review file was written and no `REVIEWED_AGAINST` line was filled.** The existing `<case>.review.txt` files belong to the old texts and no longer count.

## 7. What was not tested

1. Anything about Codex's hand-pick runs, the right-click CE menu, or a second open drawing (BUG-861).
2. A pit pick with CE not loaded.
3. R06 and R09 on 3.0.74.
4. Window looks (R03 label positions, R25-style windows, the Settings window's look).
5. The Pit Schedule, CDREBUILD, pipe-ends-on-pit, a metre drawing.
6. Evidence on any build other than Civil 3.0.74 (the controls on 3.0.72 are history).

## Summary

R08's old failure came from the runner's own AutoCAD reads, not CE: reads with no pick lost REDO 5 of 5, a pit pick with no reads kept it in 20 of 20 rounds. R01, R02, R03, R05, R07, R08 and R10 are hardened, each passes in two sessions on Civil 3.0.74 and has a variant that fails. R04 has only an offline red. R06 needs a Codex look; R09 is a real fault. None is independently reviewed yet.
