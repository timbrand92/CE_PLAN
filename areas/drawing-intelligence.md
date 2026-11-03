# Area DI — Drawing intelligence: connectivity, CDCHECK, learning from real drawings safely (DATA-01)

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Drawing intelligence: connectivity, CDCHECK, learning from real drawings safely (DATA-01). (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `03_DRAWING_INTELLIGENCE\` (EV-03 evidence model, project queue, synthetic safety plan, README)
2. `04_REFERENCE\CE_CIVIL_DRAWING_INTELLIGENCE_BRIEF.md`
3. `decisions\DECISIONS_LOG_DRAWING_INTELLIGENCE.md`
4. `C:\CE_DrawingIntelligence` (local only, never in a repo)

## 3. Items and status

1. **Standing rule R-LEARN (Tim, 19 Sep 2026): the evidence keeps growing.** See `ENGINEERING_RULEBOOK.md`. The CEMARKUP corpus is now at `C:\CE_DrawingIntelligence\10_Plugin_CEMARKUP_Corpus\` (out of the repo on 19 Sep, plugin PR #79) and every project worked on adds to it; anonymised lessons come back into this repository.
2. **EV-04 live job evidence model (29 Oct 2026): DRAFT card, plan only.** `03_DRAWING_INTELLIGENCE\EV-04_LIVE_JOB_EVIDENCE_MODEL.md`. Follows a structural job from inputs to issue and revisions: one record per job, the source of every value, proof of each check; covers the four Claude skills (footing schedule, member schedule, geotech note, numbered notes). Tim's words: `decisions\2026-10-29_TIM_EV-04_LIVE_JOB_EVIDENCE.md`. **Not approved, not built, not tested, not installed, not Tim-accepted.** Build waits until after the pilot (Tim, 29 Oct). Six open questions on the card, section 7 (question 1 answered 30 Oct: skill notes beside the drawing file in the Markups folder). Written from the cloud chat "CE_ACAD_Plugin - Evidence Model", which has no shell on this PC: these three files are **not committed**; the next CE_PLAN chat commits them by name.
3. **Finding (30 Oct 2026, online chat "CE_ACAD_Plugin - Evidence Model"): `C:\CE_DrawingIntelligence\02_Anonymised_Evidence\` is not anonymous.** Its folder names and summary files (for example the 300-job results, the seven-systems baseline) carry street names and job numbers. The online chat opened four of those files expecting them to be anonymous, then deleted its copies and stopped. ~~Treat the folder as private until someone cleans or renames it.~~ **Superseded 30 Oct 16:42, Tim: "donmt worry about street names and job numbers, just keep the job number this isnt a big deal".** No cleaning needed; see decisions item 16.
4. **EV-04 library read (30 Oct 2026):** brief `areas\EV-04_LIBRARY_READ_BRIEF_2026-10-30.md` for a chat on Tim's PC (counts only). **Stage A (78 jobs) done 30 Oct 2026, counts in `areas\EV-04_LIBRARY_COUNTS_STAGE_A.md`.** Second pass the same day (Tim: "Yes, re-read first"): the 78 jobs' issued PDFs re-read in full, read only, 26 seconds, 0 failures; real sheet titles on 727 of 889 sheets. Sheet kinds now counted from titles plus headings drawn inside sheets. Construction methods stay Unknown: footing plans name 3 to 4 systems each in their standard legends, so the words cannot say which was used; that needs the drawings, not the PDFs. **Stage B done 30 Oct 2026** (Tim: "Go, stage B", then "keep this running without me until completion, take your recommendation"): all 1,165 jobs, 1,122 with issued PDFs, 11,063 sheets read in 6 minutes, 0 failures, titles on 7,736 sheets (70%). Counts in `areas\EV-04_LIBRARY_COUNTS_STAGE_B.md`. Construction methods still Unknown; a second try from footing marks on the PDF plans failed (S1, P1, F1 clash with section, panel and fabric marks), so they need a drawing-based reader: brief `areas\EV-04_METHODS_READ_BRIEF_2026-10-30.md`, Tim: "Start it" (Fri 30 Oct, 17:06, AutoCAD open, so no AutoCAD run). **Methods pilot done** from Evidence Job 2's saved drawing scan (layer and block counts, no new AutoCAD run): footing systems for 70 of 78 jobs, `areas\EV-04_METHODS_PILOT_STAGE_A.md`. Mapping **confirmed by Tim** ("Mapping is right", decisions item 17; pad footing layer still unanswered, stays Unknown). **Methods stage B done Wed 4 Nov 2026, 03:29**: footing systems for 984 jobs, `areas\EV-04_METHODS_COUNTS_STAGE_B.md`; 126 jobs had no structural drawing at the top of the job folder, 4 had moved files, 5 drawings needed recovery, 0 timeouts. **EV-04 library read complete** for job types, disciplines, sheet kinds and footing systems; pad footings, ground floor, walls, roof and retention stay Unknown (no confirmed CE layer). Run history: started Fri 30 Oct 17:12: headless scan of the structural drawings of 1,044 more jobs (2,702 drawings, about 2.8 GB of copies one job at a time, about 8.6 hours at Evidence Job 2's 30 seconds a job), using Evidence Job 2's own reader. It only runs in free AutoCAD windows (stops 10 minutes before 8:30 am and 3 pm on weekdays), only while AutoCAD is closed and no Codex run is starting, and stops below 25 GB free. Resumable: re-running `C:\ce_evidence_local\ev04_library\methods_b_scan.py` skips jobs already done. Per-job detail local only in `C:\ce_evidence_local\ev04_library\`.

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "see the source documents". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_
