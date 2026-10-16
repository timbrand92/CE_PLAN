# V3 alignment findings — 17 Oct 2026 (planning chat `CE_ACAD / general / plan / 01`)

**Why:** Tim's reset request and rulings, `decisions\2026-10-17_V3_ALIGNMENT_RESET.md`. Four read-only reviewers read
the plans (whole-plugin, Civil, Structural, how CE works + what is installed + process). Nothing here is a ruling.
"Read" = found in a file or measured; "I think" = reviewer's view. Nothing here was checked in AutoCAD.

## 1. Headline findings

1. **Two products, not one (measured).** Civil and Structural ship from two code lines that last met on 26 Jul 2026
   (3,319 Civil-only and 1,574 Structural-only commits since). Installed: Civil 3.0.50 / Manager 1.1.50 from d36f9545,
   Structural 1.0.117 from 0dfbd1d6. Master (650c0c19) is ~1,420 commits behind the shipped Civil line.
2. **Ribbons differ (measured from code, not seen rendered).** Civil: one "CE" tab, 9 panels roughly in job order,
   ~59 commands on ~90 buttons, contextual panels. Structural: separate "CE Structural" tab, built automatically from
   the command list, up to 313 visible commands poured into 7 panels by object type, older ribbon interface.
   Commands: Civil 140, Manager 12, Structural 377 (incl. aliases). Tim ruled one CE tab, ~40 tools in families
   (UX-RIBBON-01, UX-STRUC-02..10): not built.
3. **Built work piles up unshipped (measured).** 900 open PRs (889 drafts), 792 opened in October, 1 merged to master in
   October. Gap audit: 284 plan lines, 238 engines, ~107 reachable, 77 installed, ~10 Codex-checked, 0 Tim-accepted;
   131 engine-only; ~182 never reviewed.
4. **Installed features are mostly OFF.** "Default OFF" was the desk's addition (TIM_DESK item 204), not Tim's words;
   the Settings rows to switch them on are uninstalled PRs. Reachable with defaults: "well under 10 percent".
5. **No plan follows the CE job.** V3_UX_PLAN files rulings by the order they were asked. Civil has 13 stage areas
   (A..M); Structural has one file with 3 items and empty bug/regression sections, despite ~133 Structural ruling IDs
   (vs ~176 Civil). The answers exist; they were never assembled along the job.
6. **Evidence model not used.** EV-03 header: "Implementation: not started". `areas\drawing-intelligence.md` and
   `drawing-production.md` have zero items since 19 Sep. DP-0 "measurement not run". The Structural "P1" read of copied
   jobs never ran. `DRAFTING_DELIVERY_REGISTER.md` is linked but missing.
7. **Too much paper (measured).** 573 .md files outside archive; at least five "whole V3" plans (MASTER_PLAN,
   V3_OVERALL_PLAN 4 Sep, STRUCTURAL_LEVEL3_PLAN 5 Sep, DRAWING_PRODUCTION_PLAN 6 Sep, V3_UX_PLAN 25-26 Sep).
   QUEUE.md 724 KB, REVIEWLANE_LOG 807 KB, BUG_CARPARK 1.34 MB. Broken links to files not in CE_PLAN. Six numbering
   schemes (Stage, C, P, DP, SL3, Batch).
8. **Testing thin and on the wrong build.** Codex's 762 checks ran on 3.0.49 / 1.0.116; cover 17 of 492 UX IDs; many
   saw features OFF. One AutoCAD, one PC; a full Codex pass ~7% of the Codex week.
9. **Branch and copy sprawl (measured).** 113 rel- branches, 3,373 remote and 2,507 local branches, 308 registered
   worktrees. New chats look at master first and reach wrong conclusions.

## 2. Civil job as recorded, with gaps

Set-up (no single Civil new-job command) → mode + council (CDDESIGN/CDS; council enquiry no command) → survey
(CDSURVEY, CDIMPORTLANDXML, CDIMPORTXCIVIL, CDSL) → LPD (CDLPD) → catchments (three places: CDCALC tab, CDCATCHMENT,
CDDESIGN) → downpipes/pits (DP/CDSOURCE, PIT, CDRG; architect downpipe pick-up no command) → pipes (CD, CDEDIT,
PIPEEDIT, PITEDIT, CDRUNSOLVE) → tanks/OSD (CDWT, CDPITDETENTION, CDTWL, CDCALC, CDRAINFALL; Apply to drawing not
wired) → long sections (CDPROFILE) → schedule/notes/legend/C02 (PITSCHEDULE; C01/C02 sheet set-up no command;
CDTIDYLABELS not installed) → check (seven doors: CDCHECK, CDRULES, CDCHECKCURRENT, CDDASHBOARD, CDHUB, CDINSPECTOR,
CDCHECKDWG, different counts) → comps sheet (CDCALC Export; Issue not wired) → issue (no Civil issue command).

Civil build-vs-ruling mismatches: Pit Schedule typed value only "waits" vs UX-SCHED-01b "updates the pit, all values";
OSD criteria block three rulings (UX-CALC-02, UX-DET-08, UX-CPLAN-07); issue route F-Q2 vs UX-REG-09/10.
~200 open Civil bugs: record/drawing disagree after edits ~20, labels ~19, Pit Schedule ~16, locked layers ~14,
ribbon/start-up ~14, undo ~13, levels/grades ~13, calcs ~13, import ~11, m vs mm ~10, windows ~10.

## 3. Structural job as recorded (roof-down, UX-STRUC-13), with gaps

Set-up (CEPROPS; new job drawing and title block no command) → backgrounds (XRL/CXREF/PXREF, CEARCHREVIEW; clean-up
no command) → sheets/levels (CESHEETS, CSPLANLEVEL) → roof (1/2, R1, RJSET, C1, DS1, TS1, CSTIEDOWN, CSWINDCLASS;
point loads down no command) → upper floors (LBW, CE_MEMBERLABEL, AB/BB/BT1, CSBRACINGPANEL; markers OFF) → slab
(REB, RIB, FTHC, CSINFILL, RCBEAM, CE_SSL, CSSOILREPORT) → footings (FPFC, PFC, FSF, BP, CSPIER, SCREWPILE, FST,
CSLOADPATH; CSFDNPROPOSE hidden) → reo (CSREOBAR) → schedules (XCLMTXT, STRSCHED*, FSTEXPORT, CSMARKSRENUMBER) →
sections (SBEAM; detail library no command) → notes/comps (CENOTES; sizes still from Excel) → markup check
(CEMARKUP, CECHECKLIST) → issue (CESHEETS publish, STRUCEXPORTPDF; no single issue step).

Why below Civil: MASTER_PLAN §C.3 defines V3 complete as Civil only; no stage areas; 65 hard-coded values incl. three
hard blocks (BUG-529..537) and unnamed AS 3600 editions (BUG-534); no standards Settings home; roof-down card
questions waiting 13 days; competing priority orders (UX-STRUC-06, roof-down card, lane queue, 14 Sep plan); no
New Pipe look on any Structural window; own settings file, own link store, own undo guard. ~95-100 open Structural
bugs: Codex round-ups 17, settings/hard-coded 14, footings 13, undo 10, beams/columns 8, start-up/ribbon 8,
schedules 7, text 5, Esc/prompts 5, protection 4, privacy 3.

## 4. Contradictions already settled by Tim (fix the files, do not re-ask)

1. Look: UX-LOOK-01 + INT-075 (gold, black, white/grey; plain name with command) beat "CE deep blue" and "graphite".
2. One CE tab: UX-RIBBON-01 beats MASTER_PLAN §3 "its own CE Civil ribbon" and the July three tabs. Open: when.
3. Old drawings: UX-DWG-02 (upgrade quietly) supersedes D2, with the UX-MIX-03 hold.
4. Trench grate: UX-SURF-01 beats UX-SRC-04. Edit Pipe: one page (#180) beats three tabs (#144).
5. Ownership: START_HERE §3 still states ruling B; superseded 23 Sep.
6. Minimum cover: R-04 says 450; Tim set 300 as colleague default (24 Sep); 300 vs 600 still listed open (Set C Q5).
7. V3_UX_PLAN line 85 "identical beams share a tag" replaced by UX-MARK-07.

## 5. Open questions put to Tim on 17 Oct (answers go to the decisions file)

See the chat reply of 17 Oct; recorded there as "batch 1" once answered.
