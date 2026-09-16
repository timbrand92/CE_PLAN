# Pit-schedule CSV ordinary workflow audit

FOR TIM

The CSV plan preserves current work while reviewing imported identity, units, grouping and differences. It correctly separates import confirmation from changing a placed schedule or source drawing.

---

Read root43 in full and actual PitScheduleViewModel.Schedule.cs1–165. Confirmed ExportCsv calls PersistManualRows/FlushPendingSave before save chooser; gets placement rows and blanks selected repeated cells for continuation groups. ImportCsv reads candidate records, captures snapshot, clears Rows, recognises/maps headers, creates fresh manual IDs with empty physical source handles, updates depth and persists. No difference-confirmation step appears in inspected method. Parser/downstream/native effects remain unclaimed.

Proposal review covers raw headers/cells, Unknown units/datum, blank-group interpretation, stable identity versus display number, duplicate/unmatched groups, current/override/pending/imported values, named-set manual rows, source-owner versus schedule-only intent, explicit subset, stale comparison, repeated import and no implicit deletion. Export file-chooser Cancel is correctly not proof of no prior persistence. No material correction found.

Next concrete normal path: CDRG boundary create/close/Undo and optional GIO stage, then footprint/source requirement review and later selected boundary/GIO change. Current C5 source summary and root35 assessment comparison do not fully describe first creation or the commit/Cancel boundary between boundary and optional item. Must preserve Drainage Items/active owner and unresolved treatment grouping; no invented engineering default or link.

No CSV/product operation, native test, implementation or whole-run completion.
