# Surface coverage, Notes/Time and criteria audit

FOR TIM

All 47 named Structural XAML surfaces and 40 code-created groups appear in the new map. That proves they have a destination, not that every action is fully specified. The source also exposes a time-edit edge case: deleting every row from one file can leave that file untouched.

---

Clock: 2026-09-16 13:31:51 UTC / 23:31:51 Sydney. Read-only planning audit; no runtime, build, git, client scan or AutoCAD action.

## Findings sent to root

| ID / severity | Evidence | Required correction |
|---|---|---|
| SURF-01 / medium | TimeEntryFileService.cs:159–205 groups surviving entries only. Browser removes row from _allEntries:163–191 and calls SaveAll(_allEntries):197–225. | Qualify deletion claim: a source CSV with no surviving rows has no group, so this route does not rewrite it. Add last-row/all-rows-in-one-file future scenario. Do not claim observed runtime failure. |
| SURF-02 / low | Coverage map §B discovery says remaining gap is native reachability only, whereas §A retains source-answerable Help/run/pin side effects. | Make §B agree: source semantics remain open where not traced. No full action-coverage claim from matching names. |
| SURF-03 / low | JobTimeTracker.cs:406–434 increments save count before IsTrackable and >=60-second gate, which guards drawing-storage write. | Separate save-count increment from storage threshold in Time table. |

## Verified scope and authority

- Parsed actual retained-control ledger: 52 XAML table occurrences, **47 unique paths**, plus **40 code-created group rows**. Every basename/group appears in map. Additional five XAML occurrences are repeated control addendum entries, not extra surfaces. This is bounded name reconciliation, not all-field semantics or native discovery proof.
- NotesBrowserDialog.xaml.cs:920–955 updates record, then removes/adds images separately. SharedNotesManager.cs:381–419 force-reloads and replaces matching current-user record, routes cross-user elsewhere. New supplement correctly refuses to treat that as merge/conflict proof. Cross-user implementation was not audited in this delta.
- TimeEntryBrowserWindow.xaml.cs:85–276 and TimeEntryFileService.cs:155–205 support dirty local edits, confirmed unsaved delete, validation, whole-file grouped rewrite and separate file effects. Multi-file save can complete some files before a later error; overall exception is not global rollback. This should remain explicit in any future recovery implementation.
- JobTimeTracker.cs:406–465 and568–590 support save event and legacy idle-dialog qualification. Canonical ST-09 lines264,296–319 substantiate Keep mine/Keep shared/Merge/Cancel, five-minute idle exclusion/restoration, Unassigned/not billable and append-only corrections. This pass did not execute idle behaviour or prove concurrent durability.
- Root15 criteria claims verified directly against complete OnSiteDetentionCriteriaService.cs:16–216: definition load precedes placement; returned reference is exploded/erased; non-title text is erased before extents check; caller then commits. BuildSummary:556–595 and Parse:716–723 confirm invalid strings become zero in this bounded handoff. Snapshot/currentness and asset-explosion qualification are appropriately limited. No native incomplete-output event was claimed or observed.

## Remaining planning coverage

The new map candidly leaves source-answerable column visibility, exact settings scopes, discovery actions and remaining report/export writers. Assigning them to a group or root owner does not alone satisfy root17's per-workflow semantics criterion. Root-owned markup/checklist/issue routes must be checked against their actual companion contracts, not presumed complete from the word Root. Native focus/Undo/save-reopen stays future qualification; unresolved engineering/product intent stays a reviewed question rather than a source guess.

Criteria output has a useful explicit contract and future failure cases; no additional material correction found there. Pending source-wording findings above need read-back. Whole-plugin audit remains active.
