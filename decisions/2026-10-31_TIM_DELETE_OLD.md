# Tim's ruling: "delete old", 31 Oct 2026 (about 23:32 Melbourne)

Recorded by CE 00 (desk chat).

> "delete old"

Tim answered a push notification and the question "which of these may I delete?" with that two-word reply. CE 00 read it as the three items it had offered, nothing more.

## What was deleted (log: C:\CE_WORK\scratch\cleanup\delete_old.log)

1. All 196 folders in `C:\CE_WORK\old_clutter_31oct` (moved there from the root of C: earlier that day; manifest saved at `C:\CE_WORK\scratch\cleanup\MANIFEST_moved_from_C_root.txt`).
2. 27,017 Windows Temp files older than 3 days from CE 01's manifest (361 kept: in use or newer).
3. `C:\ce_rc_scratch\c1069` to `c1073` (old payload candidates; c1074, the installed one, kept).

Result: C: free went from 24.5 GB to 46.9 GB. `git worktree prune` removed 165 dead entries in the plugin repo and 3 in CE_PLAN; live worktrees checked afterwards.

## NOT covered by this ruling (still Tim's question)

- `C:\Lisp Files\_TEST_COPIES_20260923` (33.8 GB; 29.4 GB is the Codex looks folder): may old look pictures be archived once results are in the ledger?
- The Codex app data in `C:\Users\TimothyBrand\.codex` (about 47 GB): Tim's own data.
- `C:\ce-fx` (12.5 GB, 370 folders) and `C:\ce_rc_scratch` (6.6 GB).
- Hibernation file and page file (system settings).

The cause of the 4 GB an hour fall on the evening of 31 Oct was not found.
