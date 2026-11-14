# Old drawings study: plan (reading only)

**Status: PLAN. Written Sun 15 Nov 2026 (Melbourne). Nothing built, nothing installed, no tool changed. No drawing opened yet. Built n/a. Tested n/a. Installed n/a. Accepted no.**

**Authority:** Tim, 15 Nov 2026 02:13 (`TIM_INTERVIEW_15NOV.md` 12.2): study "now, reading only, beside the ten"; patterns "shown to me in batches, I tick"; no tool changes until the ten are done and he has ticked the pattern. Copies of finished jobs: his "yes" to the controller (`QUEUES.md`, last section). The evidence model's own line applies: frequency alone never makes an engineering rule.

---

# FOR TIM

1. **What the study will tell you:** how your office actually draws a stormwater job and a Structural job, read from your own finished drawings: which layers hold pits, pipes, labels and levels; how pit numbers and levels are written and how far from the pit; how schedules are laid out; what an old drawing has that CE can read, and what it does not have.
2. **What you will get:** up to 8 patterns at a time, each one sentence, with "4 of 5 jobs" beside it and what CE would do if you tick it. Nothing is used until you tick it.
3. **What it is waiting on:** the copies of five finished jobs (another chat is making them now) and a time slot for AutoCAD's background tool from the chat that gives out the slots. Nothing opens until then.
4. **What it does not touch:** the Projects folder, `C:\CE_DrawingIntelligence`, live jobs, any CE tool. No client name, address or job number appears in anything written.

---

# DETAIL

## 1. What the study must answer for CE (Civil)

1. **Layers.** Which layer names hold pits, pipes, pit labels, levels (cover and invert), downpipes, tanks, the long-section and the schedule. Do they match the old legend layers (DRAINAGE, STORMWATER PIPE, PITS HIDDEN, GRATED TRENCH and so on) or CE's own?
2. **Pit symbols.** Is a pit the old "Stormwater Pit" block, a CE pit block, or loose lines? Do any carry attributes?
3. **Pit numbers.** Written as text or as an attribute? Pattern (P3, PIT 3, SWP3, other)? How far from the pit, and on which side?
4. **Levels.** How cover level and invert level are written (CL, IL, RL, a bare number, a level block). How far from the pit or the pipe end, along and beside the pipe. When two pits are in reach of one label, which does the label belong to?
5. **Pipes.** Line plus text, a DIA. PIPE block, or something else? Where size, material and grade are written. How often is size missing altogether (this is how often CE will say "Unknown")?
6. **Flow direction and the LPD.** Is the discharge point marked, and how? Is flow direction drawn (arrow), implied by levels, or not shown?
7. **Schedules.** How the Pit Schedule and pipe schedule are drawn: a real table object, lines and text, or a block with attributes. Column order and headings. Are lid class, pit type and inverts in it (Tim's "read from the schedule" idea, interview section 11)? Is it always laid out the same way?
8. **What an old drawing has instead of CE's record.** Does it carry any CE record at all (CE-named stored data), or only drawn objects? What share of pits, pipes and labels could CE only offer as Proposed?
9. **Units and scale.** Drawing units setting, whether metres or millimetres, dimension scale, units on the sheets (his Q15).
10. **Sheets.** Layouts, viewports and scales, xrefs used (survey, architect), title-block fields.

## 2. What it must answer for CE (Structural)

1. **Members.** Beams, columns, bracing, footings: block, polyline or text? Which layers? Is there a member-mark layer?
2. **Marks.** How marks are written (pattern, example shape only), where they sit against the member, whether the mark is an attribute or loose text.
3. **Schedules.** Beam, column, footing and bracing schedules: table object, text grid or block attributes; headings and order; do marks in the schedule match marks on the plan.
4. **Floor by floor.** Roof, upper floors, ground, footings: separate drawings, separate layouts or separate layers? (Tim's roof-down order.)
5. **Levels, sections and details.** How levels and section/detail marks are written.
6. **What an old Structural drawing carries instead of a CE member record.** Same test as Civil item 8.
7. **Limit:** running Structural tools on the copies was not asked. This study only reads.

## 3. What can be answered from the files alone, and what needs a drawing opened

**From the files alone (no AutoCAD; file system only; no drawing contents):**

1. Which file types each coded job holds (drawings, PDFs, spreadsheets, calcs, markups) and how many.
2. Whether a job is a complete package (EV3-1): drawings, xrefs, schedules, calcs, issued PDFs.
3. How the files for revisions are named (pattern only; client words never copied).
4. Whether PDFs and spreadsheets for schedules and calcs exist, so a drawn schedule can later be compared with its source.
5. Nothing about layers, text or geometry: a DWG is not readable as plain text and I will not guess.

**Needs a drawing opened (read only):** everything in sections 1 and 2 except the five lines above.

## 4. The exact read-only step

**Method (already proven, `OLD_BLOCKS_FOUND.md` section 1):** AutoCAD's background tool (the core console) with no CE plugin loaded. It opens a copy from `C:\CE_WORK\realjobs\`, and the copy is exported as a DXF (a plain-text version) into `C:\CE_WORK\scratch\` on Tim's PC. The drawing copy itself is never saved. Reading the DXF text is then plain file reading.

1. **Before and after check:** the SHA256 of every copy before the run and after it; any difference stops the study and is reported.
2. **Read-only commands only:** open, DXFOUT to scratch, close without saving. No SAVE, no QSAVE, no AUDIT, no RECOVER, no purge, no xref path change, no CE command, no object upgrade.
3. **What is read from the DXF (by a small read-only reading script, kept in scratch, not committed):** layer list with counts of each kind of object; block names with insert counts and attribute names; text strings by layer, matched to patterns (pit number, CL/IL level, pipe note, mark); for each matched text, the distance and side to the nearest pit or pipe end, computed from geometry; table objects and their grid; drawing units and dimension scale; layouts and viewports; xref names (kept coded); whether any CE-named stored data exists.
4. **Optional, only if the slot allows:** the ordinary AutoCAD window on the copies to look at three real cases per pattern, for the pictures Tim's batch should carry. Screenshots stay on his PC; only a crop clear of the title block could ever go to CE_PLAN (controller's care rule, `QUEUES.md`).
5. **Not used:** `CETRUSTREAD` (the CE read-only command is a draft on a branch, never installed); installing anything; starting the full AutoCAD window without a slot.

**Slot asked of the controller:** one slot of about 60 minutes of the background tool for the five copies (three Civil, two Structural), in a free window (after 5:30 pm, before 8:30 am or weekend). An ordinary AutoCAD window is only asked for later, for pictures, as a second short slot.

## 5. What is written, and where

1. **Here:** this plan. Then `OLD_DRAWINGS_PATTERNS_BATCH_01.md` (at most 8 patterns), then later batches.
2. **Local only (never a repo):** the DXF files, the per-job readings with real text, any screenshot with a title block, the code-to-job key (already the helper's local file).
3. **Patterns in CE_PLAN:** one plain sentence each, counted "N of M jobs", one neutral example, what CE would do if ticked. Job codes JOB_A, JOB_B ... only.
4. **Per rule 9.9:** each batch also gets a line in this folder's record of what was learnt, with Tim's tick or reject beside it once he answers.

## 6. Order of work

1. Plan pushed (this sitting).
2. Check again for the helper's report `REAL_JOBS_STUDY_15NOV.md` and the copies.
3. Slot arrives: file-only inventory first (section 3), then the read-only run (section 4).
4. Read the extracts, count patterns across the jobs, write batch 01.
5. Ask chat puts batch 01 to Tim.

## 7. Limits to say plainly

1. **Five jobs is a small sample.** "4 of 5" is a first look, never a rule. Frequency alone never makes a standard.
2. **A pattern in jobs drawn by CE tools may be CE's own habit**, not the office's old hand drawing. Each job is marked old-hand, old-LISP or CE-tool-made, and counted separately where it matters.
3. **Anything that cannot be read stays Unknown**, never a zero.
