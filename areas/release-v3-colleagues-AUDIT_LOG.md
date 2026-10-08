# Release v3 colleagues — AUDIT helper log

Helper: CE_ACAD / release-v3-colleagues / audit / 01 (read-only; started by desk plan/03).

1. **Fri 9 Oct 2026 08:40 (PC clock)** — audit run 1 started. Scope: A privacy routes, B Structural Undo/Redo, C settings writes. Release commits: Civil/Manager rel-20261009e 1200744d, Structural rel-20261009f 9babe787.
2. **Fri 9 Oct 2026 08:40 (PC clock)** — hunt_mgr run 1 started (bug hunt, Manager and installer, read-only). Release commits: Civil/Manager installed rel-20261009e 1200744d, next rel-20261009g 319ba688; Structural rel-20261009f 9babe787. Output: areas/release-v3-colleagues-HUNT_MANAGER_2026-10-09.md.
2. **Fri 9 Oct 2026 08:41 (PC clock)** — hunt_civil run 1 started (read-only bug hunt, Civil Day 1 steps 1 to 13, installed Civil rel-20261009e 1200744d).

2. **Fri 9 Oct 2026 08:41 (PC clock)** — hunt_struc run 1 started (Structural bug hunt, Day 1 steps 14 to 24, installed Structural rel-20261009f 9babe787; read-only).
3. **Fri 9 Oct 2026 08:54 (PC clock)** — hunt_civil run 1 ended. 15 draft findings HUNT-C-01..15 (1 HIGH, 6 MEDIUM, 8 LOW), code reading only, none seen in AutoCAD. Report: areas/release-v3-colleagues-HUNT_CIVIL_2026-10-09.md.

2. **Fri 9 Oct 2026 08:55 (PC clock)** — hunt_struc run 1 ended. 15 findings HUNT-S-01..15 in areas/release-v3-colleagues-HUNT_STRUC_2026-10-09.md (code reading only, nothing run).
7. **Fri 9 Oct 2026 08:56 (PC clock)** — hunt_mgr run 1 ended. Report: areas/release-v3-colleagues-HUNT_MANAGER_2026-10-09.md (15 findings, 2 HIGH). Installed was already Civil 3.0.41 / Manager 1.1.41 (660487d1), Manager code identical to 1200744d apart from version stamps.
8. **Fri 9 Oct 2026 08:59 (PC clock)** — audit run 1 ended. Report: areas/release-v3-colleagues-AUDIT_01_REPORT_2026-10-09.md. A: 11 privacy routes ranked (blocker: "Send a fault report" / CEMANAGERDIAG writes real login, PC name and user folder to the office IT folder; zip still carries drawing names logged without ".dwg" and folder/PDF paths; login written into drawings by connection decisions). B: nothing found writing between U and REDO in Structural 1.0.110 (code reading); TS1, R1, FSF, FPFC, grips, Sheets update, autosave-on not walked by Codex; scan blind to async and late-bound COM calls. C: Structural rewrites CS_Settings.json at start-up when it gains default rows (seen W43-04); Civil and Structural save settings at start-up after each new version. Code reading only, nothing run.

9. **Fri 9 Oct 2026 09:21 (PC clock)** — hunt3_cross (run 2) started. Read-only: jargon, window words, blue, Settings labels, double-read Settings, CE_SHARED drift.

9. **Fri 9 Oct 2026 09:21 (PC clock)** — hunt2_civil run 2 started (Civil design tools beyond Day 1, code reading only).

10. **Fri 9 Oct 2026 09:21 (PC clock)** — hunt2_struc run 2 started (Structural beyond Day 1 at rel-20261009f 9babe787, code reading only).
