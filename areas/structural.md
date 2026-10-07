# Area S — Structural (S1 to S3 and Level 3): project understanding, connected framing, details library, drawing journey

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Structural (S1 to S3 and Level 3): project understanding, connected framing, details library, drawing journey. (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `04_REFERENCE\structural\STRUCTURAL_LEVEL3_PLAN.md`
2. `04_REFERENCE\structural\STRUCTURAL_DELIVERY_PLAN_2026-09-14.md`
3. `04_REFERENCE\structural\STRUCTURAL_BUILD_AREAS.md`
4. `04_REFERENCE\structural\STRUCTURAL_PROGRESS_2026-09-13.md`
5. `04_REFERENCE\structural\STRUCTURAL_READINESS_2026-09-12.md`
6. `archive\chat-records-2026-09\STRUCTURAL_PACKAGING_DIAGNOSIS_2026-09-15.md`

## 3. Items and status

1. **DATA-01 corpus move (19 Sep 2026).** The CEMARKUP corpus data is out of the repo (plugin draft PR `claude/private-data-step4`) and lives at `C:\CE_DrawingIntelligence\10_Plugin_CEMARKUP_Corpus\`. The code reads only the manifest, which stayed. **Built (docs and data only), not tested, not installed.** Still to do in a plugin chat with a build: swap the real addresses in eleven drainage test/source string literals for fictional same-shape addresses, run Drainage.Tests and Structural.Tests, then a settings-page path for the corpus root if the validation service ever needs the snapshots.
   **20 Sep 2026 update:** the address swap landed on PR #80 (merged, 22 files; probes read office folder names from a local-only map), the drainage import corpus left the repo on PR #81 (merged), and the rotated Azure URLs became placeholders on PR #82 (merged 23 Sep 2026). Built and unit-tested on net10 (116 + 8 fixtures), not installed, not Tim-accepted; nothing here changes AutoCAD behaviour.
2. **Retired root LISP tools into the plugin (Tim, 20 Sep 2026: "can those lisp files be updated and added to the plugin at some point add to the plan to do so").** Gap review done 20 Sep against the Structural audit list (`Modules\Structural\Docs\Audit.md`): of the 34 commands the old root LISP files provided (XRL, XRLFAST, XRLCONFIG, XRLINFO, CXREF, PXREF, CPB, SPW, SPW3, SPW6, SPWC, TDS, TDS1, TTS1, TC1, Q, QD, LD, AD, CLEAN, FASTSAVE, the CE text and support-block set, the schedule importers), all run natively already. The two with no native command, `SML` and `CHECKML` from CLOSED MLINE.lsp, were ported on PR #83, merged to master 23 Sep 2026 (SML selects the STANDARD multiline style then runs MLINE; CHECKML prints the current multiline style, scale and justification). **Built on net10 and guarded by three source tests; not installed, not Tim-accepted.** Test steps in `PENDING_TESTS.md`. Unknown, not zero: `TIM_TOOLS_COMBINED.lsp` was lost on 20 Sep (see the idea file); the audit names its utilities only by function (copy/rotate, breakline, centreline, rebar, scabble), so a file-by-file check is not possible; `slopetick.vlx` is lost and its purpose unknown.
3. **D2 connected framing, slice 1: beams follow their support (26 Sep 2026, 00:25).** From the D1 card Tim approved 25 Sep (choice 7 "Beams follow" + the label half of choices 3 and 4). Plugin draft [PR #250](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/250), branch `claude/d2-slice1` (tip `cce3b237`) against the shipping line `claude/struc-d1-prep`. In AutoCAD: MOVE, ROTATE, STRETCH, SCALE, ALIGN or an ordinary grip on a CE support makes every beam end recorded on it follow, and each beam's own label keeps its place on the beam; a beam moved alone brings its label; one U undoes both; locked layers and REFEDIT never bypassed. **Built (shipped Standalone lanes net48/net8/net10: 0 warnings, 0 errors) and tested by machine (planner 41/41 on three lanes; 68 focused Structural guards 0 failed; DesignCore 1,343 run / 6 = the known baseline); proven headless in AutoCAD 2027's core console, 13/13 plus save/reopen, one U restoring all each time. Not installed, not opened in full AutoCAD, not Tim-accepted.** Test steps: `PENDING_TESTS.md` (STRUC-D2-SLICE1) and the plugin REGRESSION_LOG. **Left:** slice 2 = CE grips on 2027 with preview and the Edit together / Edit this only / Disconnect choice; then the QA list's quiet flags, spine names (needs `Shared/CE.Spine` on the Structural line; the card's convergence plan `STRUCTURAL_TRUNK_CONVERGENCE_2026-09-24.md` was never written), COPY and ERASE rules, the XCLMTXT schedule link.

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "see the source documents". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

1. **Fold CE_COMPSHEET computations into this module** (Tim, 20 Sep 2026, on the idea file). Source retired at `C:\TimOS\retired\CE_COMPSHEET`.
2. **TIM_TOOLS_COMBINED utilities**: confirm each (breakline, centreline, rebar, scabble) has a native equivalent once Tim names the commands he used.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_

## UX plan — Structural front door, 25 Sep 2026 (chat CE_ACAD / V3 PLAN / DISCUSSION / 01)

1. **Ruled by Tim (UX-STRUC-02 to 05):** ribbon families with drop-downs (about 40 tools shown instead of 298); duplicate commands merged, other names kept as typed shortcuts; the 56 text/tag codes stay typed, plus one Tag tool; the "Legacy" utilities sorted into proper families. Every typed code keeps working. Record: decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.
2. **Also today:** beam fixes UX-BEAM-01 to 03 (plain reasons, STRUCDEBUG, one engine); closed-sheet writes kept with a notice (UX-STRUC-01); CETOOLS stays on the ribbon, CENOTES into Manager (UX-RIBBON-04); CESTRUC to be reviewed in detail.
3. **Not built, not tested, not installed, not Tim-accepted.** Needs a Structural ribbon card (release chat).
4. **Priority after D1 (Tim, 25 Sep, UX-STRUC-06):** QA against the engineer's markup, then register/revisions/issue, then architectural background preparation; detail browser later. Each needs a workflow card first.
5. **Office convention learnt 25 Sep (Tim):** hatch codes are colour number + pattern-type letter(s) + H (e.g. 21H solid colour 21, 21DH dot, 11CH concrete colour 11). Any new hatch preset follows it. Hatch, Text and Tag family rulings: UX-STRUC-07 to 09.
6. **Later stage, planned (Tim, 26 Sep, UX-D2-05b):** Structural beams and columns become CE's own kind of object (like Civil's one-piece pipe, C7), which allows a safe hover menu. Separate stage, own card, 2027 first; after D2. The hover-menu attempt on ordinary objects was stopped (it broke AutoCAD's own menus, BUG-159 class).
7. **Plan cards updated 26 Sep 2026:** `04_REFERENCE/structural/cards/STRUC-REGISTER-ISSUE_CARD_2026-09-26.md` is APPROVED as a plan: Civil has no register or notes page; the Structural register lists Civil sheets on combined jobs, with separate revision sequences, and Check plot/engineer mark-up are included. `STRUC-ARCH-BACKGROUND_CARD_2026-09-26.md` now covers Civil and Structural Xrefs, including Civil preset evidence, changed-background comparison and relative-path repair; planning only. New `STRUC-COMPS_CARD_2026-09-26.md` is a DRAFT PLAN for drawing-led computations, timber first; numerical methods and clauses remain OPEN for engineer sign-off. **No plugin work built or tested by this documentation update; no new PENDING_TESTS or BUG_CARPARK row.**

## Draft cards awaiting Tim, 7 Oct

1. **UX-FRM-05 (roof area setout, rafter or truss arrow, GT marks):**  4_REFERENCE\ux-plan\cards\CARD_UX-FRM-05_ROOF-AREA-SETOUT_2026-10-07.md. Status DRAFT, not approved. Logic built, no command. 3 questions.
2. **UX-FRM-11 (floor joist and bearer span arrow):**  4_REFERENCE\ux-plan\cards\CARD_UX-FRM-11_FLOOR-SPAN-ARROW_2026-10-07.md. Status DRAFT, not approved. 3 questions.
3. **UX-FRM-01 (framing plan legend built from what is drawn):**  4_REFERENCE\ux-plan\cards\CARD_UX-FRM-01_FRAMING-LEGEND_2026-10-07.md. Status DRAFT, not approved. 3 questions.
4. **UX-FRM-04 and 06 (propose lintels over openings and supports under beam ends):**  4_REFERENCE\ux-plan\cards\CARD_UX-FRM-04-06_LINTEL-SUPPORT-PROPOSALS_2026-10-07.md. Status DRAFT, not approved. 3 questions.
5. **UX-LEVEL-02 (draw the level above and below as (O) and (U)):**  4_REFERENCE\ux-plan\cards\CARD_UX-LEVEL-02_OVER-UNDER-ITEMS_2026-10-07.md. Status DRAFT, not approved. Engine built and off, no command. 3 questions.
