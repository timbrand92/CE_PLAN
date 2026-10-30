# EV-04 library read: brief for a chat on Tim's PC (30 Oct 2026)

**Written by:** chat "CE_ACAD_Plugin - Evidence Model" (Claude, online). **Card:** `03_DRAWING_INTELLIGENCE\EV-04_LIVE_JOB_EVIDENCE_MODEL.md` (DRAFT). **Tim's words:** `decisions\2026-10-29_TIM_EV-04_LIVE_JOB_EVIDENCE.md` items 12 to 15.
**Why this runs on Tim's PC:** DATA-01. Client drawings, names and addresses never go to an online service. This chat reads locally and sends back **counts only**.

## 1. Goal

Build the counts for the EV-04 library. For each job, answer three questions:

1. **What kind of job:** one of the 13 job types Tim confirmed on 30 Oct (alterations and additions; single dwelling new; townhouses / multi-unit / dual occ; basement; civil stormwater drainage; civil roads / subdivision / services; commercial / community; industrial / steel frame; small elements; deck / small outbuilding; pool only; retaining wall only; other).
2. **Which disciplines:** Structural only, Civil only, or both (Tim, 30 Oct: "we have these job types for civil projects and structural projects, sometimes both for one project sometime only one type").
3. **Which sheets, and which construction methods:**
   1. **Structural sheet kinds**, from the sheet titles of the issued structural set (general notes, footing / slab plan, ground floor framing, first floor framing, roof framing, footing details, framing details, bracing, demolition / remedial, basement / retention, pool, schedules, sections, anything else found: list it, group it, count it).
   2. **Civil sheet kinds**, from the issued civil set (drainage plan, pit schedule, tank / OSD details, long sections, notes, anything else found).
   3. **Construction methods**, from the structural general notes, footing plan, schedules and details: footing system (for example waffle raft, stiffened raft, strip, pad, bored piers, screw piles, stumps), ground floor (slab on ground, suspended slab, timber or steel bearers and joists), walls (timber frame, steel frame, masonry, blockwork), roof (trusses, rafters, steel portal), retention. Keyword evidence with the sheet it came from; **Unknown when not found, never a guess**.

## 2. Two stages (Tim checks after stage A)

1. **Stage A: the 78 jobs from Evidence Job 2 only.** They are already copied and read in `C:\ce_evidence_local\job2\` (sheet titles, issued PDFs, classified job types). Reuse them; do not redo the copy. Report the counts, then stop.
2. **Stage B: only after Tim says go.** Every job with an issued PDF set (about 1,165, Evidence Job 2 section 1). Estimate the time first.

## 3. What comes back (the only output that may leave the PC)

1. **One counts file:** `C:\CE_PLAN\areas\EV-04_LIBRARY_COUNTS_STAGE_A.md`.
2. **Tables of counts only**, for example: "Structural, single dwelling new: footing plan 9 of 9 jobs; ground floor framing 3 of 9; …" and "Construction method, footing system, townhouses: waffle raft 5 of 9; stiffened raft 2 of 9; Unknown 2 of 9."
3. **Sheet titles that fit no group**, as generic wording (job numbers allowed; no client names or street addresses).
4. **What could not be read, and why.** Zero silent skips.

## 4. Rules

1. **Read only.** Work from copies. Never write to the Projects folder. Never open drawings in Tim's own AutoCAD session; the headless core-console method of Evidence Jobs 1 and 2 is fine.
2. **Job numbers are fine (Tim, 30 Oct 16:42: "just keep the job number"):** identify jobs by job number. Still keep client names, street addresses and architect names out of the counts file. Before writing, scan the file against `C:\CE_DrawingIntelligence\00_Control\leak-scan-terms.txt` and `private-job-paths.txt`. The plan's leak-scan hook must pass. If the leak check refuses the file because of job numbers, do not bypass it: keep the per-job rows in `C:\ce_evidence_local\ev04_library\`, put counts only in the plan file, and tell Tim.
3. **Per-job detail stays local:** `C:\ce_evidence_local\ev04_library\` only.
4. **Unknown stays Unknown.** Keyword-based types and methods are estimates; say so on the counts file.
5. **One reader process.** Watch disk space; stop and report if C: falls below 25 GB free.
6. **Plan history:** add only the counts file, by name (`git add areas\EV-04_LIBRARY_COUNTS_STAGE_A.md`), never everything. While there, also add these files left uncommitted by the online chat, by name: `03_DRAWING_INTELLIGENCE\EV-04_LIVE_JOB_EVIDENCE_MODEL.md`, `decisions\2026-10-29_TIM_EV-04_LIVE_JOB_EVIDENCE.md`, `areas\drawing-intelligence.md`, and this brief.
7. **Talk to Tim** in AutoCAD terms and simple English only. No software words.

## 5. Finding (30 Oct), settled by Tim

The online chat found street names and job numbers in `C:\CE_DrawingIntelligence\02_Anonymised_Evidence\`. Tim, 30 Oct 16:42: "donmt worry about street names and job numbers, just keep the job number this isnt a big deal". No action needed.
