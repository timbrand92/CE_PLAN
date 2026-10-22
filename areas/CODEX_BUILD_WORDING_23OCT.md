# CODEX wording build — 23 October 2026

1. **Answer first:** branch `cx/wording-c60`, base `origin/claude/rel-20261022m` at `40ee0a36`. Draft PR **#1534**: https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/1534. Current pushed head `a93b1b1ee2b8a76b57dc039d203399f5b7a78dfb`; verified test totals will be recorded after the build gate. Worktree `C:\cw60`. No deployment authorised or attempted.
2. **Current work:** correct all five HIGH findings, the Fixes tooltips, Checks wording, Settings naming in open files, the eight-tab Help list and certain polish. Tests are waiting for another job's shared build lock. No test pass is claimed yet.
3. **Scope:** wording only. No window layout, default, colour, drawing operation, source-edit window or double-click code changed. Protected editing windows retain their old Settings button label and need their owner's follow-up.
4. **Evidence folder:** `C:\cw60-evidence`. Build/test commands use `-p:SkipDevBundle=true -nr:false --disable-build-servers`, explicit C-57 reference paths, a temporary folder and `CE_LOG_DIR_OVERRIDE`. The existing Settings isolation fixture remains in force. The initial settings fingerprints were read only.
5. **Audit corrections:** missing CE project information does not prove there are no pits or pipes, so the Ignore message describes the unread information. Missing/assumed roughness does not prove the material is missing, so the messages ask to check roughness. Checks' not-known count also includes failed reads, so its heading says “not enough information”, rather than claiming every value is missing. The pure finish-update planner saves no details, so its folder message must not promise that it does. The visible “Pipes & Pits” heading is changed to “Pipes and Pits”, matching the existing accessible name.
6. **Behaviour preserved:** suggested fixes recognise old saved wording and the new Settings wording. A narrow test checks the same Settings action remains offered. Installer instructions reuse the existing administrator/colleague phrase; nothing starts an installer. AutoCAD years map only known releases, with “not read” for any other release or a failed read. Autodesk reference: https://www.autodesk.com/support/technical/article/Release-numbers-differ-from-version-year-numbers-in-AutoCAD-products.
7. **Still untested:** compilation, full suites, 150% Settings fit and screenshots are pending. AutoCAD will not be started. This is not installed or AutoCAD-accepted.

8. **Coverage inventory (awaiting tests):** 48 findings have wording corrections: 1, 3, 4, 5, 7–17, 19–25, 28, 29, 35–46, 49–51, 53, 56–63. This includes all five HIGH findings: 1, 7, 8, 13 and 14. Four findings are partly addressed: 27, 48, 55 and 68. Sixteen are left unchanged: 2, 6, 18, 26, 30–34, 47, 52, 54, 64–67. These are code coverage counts, not accepted fixes; verified test totals and visual checks are pending.
9. **Partly addressed, and why:**
   1. **27 — not-known wording:** corrected the touched Settings hints. Other council/link-command text belongs to the older-string follow-up.
   2. **48 — Older longitudinal:** corrected the name in the Settings tooltips. Moving the tick under a separate CDCALC heading changes layout and is excluded.
   3. **55 — Settings:** corrected the open ribbon, Help and message sources. The protected Edit Pipe window retains “Preferences”; route that one-word change to its owner. No aliases were removed.
   4. **68 — message opening:** the touched progress line now begins `[CE]`. Older command prefixes remain outside this focused pass.
10. **Unchanged, and why:**
    1. **2 — update-stage names:** the audit groups several different states together; a wider status-wording pass needs each displayed state checked against what has actually been copied or installed.
    2. **6 — future update promise:** guarding an unconnected future installer rule changes behaviour; no installer is started by this PR.
    3. **18 — retry a mistyped Ignore reason:** requires a command-flow change. The cancellation wording remains true.
    4. **26 — show saved pipe inputs as words:** replaces raw-data formatting and needs a separate behaviour change.
    5. **30–34 — source tagging/editing:** reserved for the other source-edit PRs, including the new validation line. Source-edit and double-click code are untouched.
    6. **47 — repeated Fixes hints:** the proposed single heading requires a new layout element. Existing tooltip hints are retained.
    7. **52 — expose hidden switches:** adds Settings controls and changes reachability; excluded from wording-only work.
    8. **54 — regroup Survey boxes:** layout change, excluded.
    9. **64 — Inspector/Edit Pit:** hiding rows changes layout; Edit Pit is expressly protected.
    10. **65–67 — older repair/help and command messages:** outside the requested Fixes/Checks/Settings-name pass. Their drawing/read/repair claims need a separate checked wording pass; no protected link or save code was edited.

