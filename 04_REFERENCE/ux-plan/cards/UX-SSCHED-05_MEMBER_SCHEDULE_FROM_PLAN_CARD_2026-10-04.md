# UX-SSCHED-05..08: per-plan MARK / SIZE member schedule from the drawn members, grouped the office way (card, 4 Oct 2026)

Status: **DRAFT, not approved.** No code. Written by Team build 02 (headless run 68): the job asked for this schedule and
no approved workflow card exists (review gate, AGENTS.md). Slice stopped here for Tim.
Class: **Missing** (a schedule built from what is drawn) plus **Keep** (XCLMTXT and the office MEMBER SCHEDULE block).

**Authority:** `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Framing member schedule and beam marks", 27 Sep
10:58-11:01: UX-SSCHED-05 **"Copy exactly"** (one schedule per floor, "FIRST FLOOR MEMBER SCHEDULE", MARK | SIZE blocks side
by side, group subheadings, size and description in one cell, e.g. "140 x 45 MGP10 TRIMMER BEAM"); UX-SCHED-04b
**"Side-by-side blocks first"**; UX-SSCHED-06 **keep the office MEMBER SCHEDULE block** (1/2/3 COLUMNS, about 31 rows a
column); UX-SSCHED-07 **"Second block beside it"**; UX-SSCHED-08 one column keeps the plain "MEMBER SCHEDULE" title;
UX-MARK-07 **"Own mark per beam"**. Evidence: `04_REFERENCE/structural/JOBS_PROCESS_STUDY_2026-10-04.md` section 2.2
item 6: groups "Structural Supports", "First Floor Members", "Common Members", seen on 4 of 6 jobs (B, C, D, F); roof
plans 2 of 6 ("ROOF MEMBER SCHEDULE").

## 0. What exists (read in code on `origin/claude/rel-20261015y`, 8e88af4e)

1. **XCLMTXT (Excel to Schedule):** fills the office MEMBER SCHEDULE block from an Excel sheet; already knows the group
   titles (`ExcelMTextService.KnownTitlePhrases`: COMMON MEMBERS, STRUCTURAL SUPPORTS, FLOOR BEAMS, LINTELS ...).
   **Keep.**
2. **STRSCHEDCREATE / REFRESH / SYNC:** bracing, bored pier and tie-down tables only. No member schedule from the plan.
3. **Marks on plan:** beam marks (FB, L, RB, RL ...) from the beam commands; columns and studs (C, DS, TS) from their
   markers. Each beam has its own mark (UX-MARK-07).
4. **Plan level:** CSPLANLEVEL records which floor this plan is (title "FIRST FLOOR MEMBER SCHEDULE" can come from it).

## 1. What the drafter would do (proposal)

1. Framing > Member schedule (typed CSMEMBERSCHED). Pick the insertion point once.
2. CE reads every marked member on this plan (beams, lintels, rafters, joists, columns, studs, posts), one row per mark,
   MARK | SIZE + description in one cell, and fills the office MEMBER SCHEDULE block, grouped under the office
   subheadings, side-by-side blocks, a second block beside it when more than 3 columns.
3. A member with no size: the row says "Unknown" (never guessed). Two members with one mark and different sizes: a
   quiet QA line, never a block.
4. Afterwards it updates itself when marks or sizes change (or STRSCHEDREFRESH), changed rows only.
5. **Switched OFF by default** (Settings `MemberSchedule.Enabled`), hidden until Codex passes it.

## 2. Cancel, Undo, protection

Escape at the point writes nothing; one placement = one U; a locked schedule layer: one plain line, nothing unlocked;
the office block is used as it is, never exploded.

## 3. Settings (R-00)

The group list and which member kinds go in each (below), the title pattern, rows per column (block's ~31): all
Settings values, each Needs Tim's acceptance.

## 4. Tests

Pure: grouping, ordering inside a group (by mark number), Unknown sizes, column split at the row limit, second block,
one-column plain title. Codex in AutoCAD: a synthetic first-floor plan with 15 beams, 6 lintels, 10 columns/studs.

## 5. QUESTIONS FOR TIM (short, typed)

1. **Which members go under "Structural Supports", "First Floor Members" and "Common Members"?** Rec: Supports =
   columns, posts, studs (C, PC, SC, DS, TS); First Floor Members = this floor's beams and lintels (FB, L, OR, PB ...);
   Common Members = joists, trimmers, plates and anything repeated across floors (FJ, trimmer, wall plates).
   Example: "C1 89 x 89 SHS" under Structural Supports.
2. **Order inside a group:** by mark number (FB1, FB2 ...) or by size? Rec: by mark number.
3. **Roof plan:** the same command, titled "ROOF MEMBER SCHEDULE"? Rec: yes, title from the plan level.
4. **Excel route (XCLMTXT) stays as well?** Rec: yes, both; the drawn-members schedule is for jobs with no Excel sheet.
