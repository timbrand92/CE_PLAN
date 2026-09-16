# Markup freshness and time-report export audit

FOR TIM

Markup review and execution have correctly documented freshness gaps. One additional report risk needs naming: changing the date fields does not clear the already generated report, so Export can still use the old date range.

---

Clock captured 2026-09-16 13:35:34 UTC / 23:35:34 Sydney. Read-only source audit, no markup worker, viewer, client file, report or AutoCAD command executed.

## Findings

| ID / severity | Actual evidence | Required change |
|---|---|---|
| MR-01 / medium | ReportsDialog.xaml date pickers82/85 lack change handlers; code references to those controls initialise/read/set them but do not invalidate _currentReport. Type/user handlers separately clear it. Export uses retained object. | Add explicit generate → change dates → export freshness scenario and current-source limitation. Target must either label the retained generated scope unmistakably or require regeneration before exporting a different requested scope. No silent new date attribution. |
| MR-02 / low | MarkupAIExecutionService.cs:13 initialises empty DirectCommandWhitelist; predicate260–266 only tests membership and no additions appear in file. | Qualify root04 conditional direct fallback: none is enabled in inspected list. A source string saying approved is not a Tim-approval receipt. |

## Independent verification

- PreviewWindow28–59 obtains runtime package/snapshot and rebuilds only when snapshot null. Workflow169–183 passes stored snapshot;470–505 separate rebuild updates or clears snapshot. Root04 appropriately avoids declaring all refresh absent or a proven wrong-drawing bug.
- Commands217–242 preflight, next-batch preview and Yes/No gate directly read. NativeExecution33–103 validates basic inputs, locks document, prepares standards, executes per action/catches failure; no target-path/content comparison in that boundary. PythonWorker125–165 assigns active document path while building actions from supplied snapshot. Downstream guards not exhaustively traced; root04 says so.
- ExecutionService53–200 skips missing Python results and derives success from positive executed/no failed plus worker ok; requested identity completeness is not established. Native missing result falls through to failure with the empty whitelist. Planned complete/failed/pending/unknown receipt remains appropriate.
- ReportsDialog126–190,367–443 and ReportManager628–646 confirm retained report export, second-resolution path naming, CloudFileHelper write and viewer launch within one try/catch. Saved message actually precedes launch; a later export error can therefore coexist with an existing file. No actual output or current client data was opened.
- Targets preserve package/action/drawing review scope and separately qualified native Undo. Report export remains separate from time adjustment, drawing save and issue history. No new engineering or provider approval inferred.

## Remaining scope

MR-01 needs read-back. MR-02 is source precision, not evidence of a reachable unsafe fallback. Full downstream markup action/worker guards and native execution remain qualification, not performed proof. CEPROPS new delta received and queued separately; not silently certified here. Whole-plugin semantic coverage and final morning pack remain pending.
