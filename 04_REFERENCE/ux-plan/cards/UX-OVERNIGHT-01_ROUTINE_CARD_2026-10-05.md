# UX-OVERNIGHT-01 — overnight routine on handed-over copies (DRAFT card, 5 Oct 2026)

**Status: DRAFT, not approved.** Written by build/02 run 75 from Tim's rulings. Only slice 1 (a read-only report,
switched OFF) is built from it, as a draft PR.

**Authority:** Tim, 5 Oct 2026 (INT-059, `decisions\2026-09-28_HOLIDAY_AUTONOMOUS_RUN.md`): item 1 "All three
(Recommended)": schedule refresh + checks + PDF set, on copies only, one morning report; item 13 "Drafter button, copies
first (Recommended)": copies only for the first month, then a separate decision before originals. Boundary INT-054: the
assistant drives only the boring end and NEVER makes design decisions (sizes, spans, load assumptions, footing sizes,
bracing counts).

## 1. The routine, in AutoCAD terms

1. **Hand-over (drafter):** at the end of the day the drafter presses a CE button on each drawing they want worked on
   overnight. Nothing is handed over by default. A drawing not handed over is never opened, copied or read.
2. **Copies only (first month):** overnight, CE copies each handed-over drawing (and the job file) into a dated overnight
   folder inside the job and works only on the copies. The originals are never opened for writing.
3. **The three jobs, on the copies:** (a) refresh the member and footing schedules from the plan tags; (b) run the
   existing checks (title block fields, revision and date, register, schedule vs tags); (c) plot the PDF set into the
   overnight folder (not the issue folder; it is not an issue).
4. **One morning report:** one plain page per job: what was done, what was skipped and why, every warning. Nothing is
   blocked; nothing is decided for the engineer.
5. **Native protection:** a drawing open in AutoCAD (a `.dwl` lock beside it), read-only, inside a REFEDIT session, or an
   Xref of another drawing is skipped and reported, never unlocked, detached, bound or exploded. Locked layers stay locked.
6. **Never a design decision:** the routine never changes a size, span, load, footing or bracing value. Where a schedule
   and a tag disagree it reports the disagreement; it does not choose.
7. **Undo:** the originals are untouched, so there is nothing to undo; delete the overnight folder to discard a night.

## 2. Slices (engine first, each OFF by default)

1. **Slice 1 (built, draft PR #725): the read-only morning report preview.** Given the job and the handed-over drawings, CE
   says, per drawing, what a night would do: not found / open in AutoCAD (skipped) / read-only (skipped) / not a sheet of
   this job (skipped) / saved since the last issue (PDFs would be refreshed on a copy) / no change. File facts only: it
   never opens a drawing. Settings switch `CeSheets.OvernightReportEnabled` OFF.
2. Slice 2: the hand-over button and the hand-over list in the job file (window = Codex).
3. Slice 3: copy to the dated overnight folder; slice 4: PDF set on the copies (accoreconsole); slice 5: checks; slice 6:
   schedule refresh on the copies; slice 7: the scheduled start (Windows Task Scheduler, Tim's PC only).

## 3. Settings (R-00)

1. `CeSheets.OvernightReportEnabled` (OFF). 2. Later: overnight folder name, start time, which of the three jobs run.
   No engineering number lives here.

## 4. Questions for Tim (via the desk, not decided here)

1. Start time for the night run (suggest 10 pm, after the 5:30 pm finish and any long test suites)?
2. Where the morning report shows: a file in the job folder, the CE panel at AutoCAD start, or both?

## 5. AutoCAD checks (slice 1, after a reviewed install, copies only)

1. Switch on; hand over three drawings of a copied job, one of them open in AutoCAD: the report says the open one is
   skipped, the others "saved since the last issue" or "no change".
2. File dates of every drawing are unchanged after the report.
