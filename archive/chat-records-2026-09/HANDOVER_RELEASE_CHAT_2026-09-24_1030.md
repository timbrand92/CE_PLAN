# Release chat handover — 24 Sep 2026, 10:30 (Melbourne)

Written by the release chat (`CE_ACAD / release-v3-colleagues`, session d4076b2c) because its context was nearly full.
The next release chat starts here, then reads `areas/release-v3-colleagues.md` items 38-43 and
`decisions/2026-09-23_V3_COLLEAGUE_RELEASE.md` (the newest entries at the bottom).

## 1. Live now

1. **Installed on Tim's PC (07:39):** Civil `3.0.0+c78a350d`, Manager `1.1.0+c78a350d`, Structural `1.0.74+8c077569`
   (from `claude/struc-d1-prep`). Tim is drafting in AutoCAD until about 17:30. **Nothing touches AutoCAD before then**:
   no install, no Codex AutoCAD run, no accoreconsole/headless.
2. **Merged to master since that install, NOT installed:**
   - #143 C7 regressions (split, grip, double-click, tidy-up, CDRG).
   - #146 and #149 CDDESIGN / CDRAINFALL / CDLPD windows, connected per Tim's "yes to windows".
   - #150 SEC-001 port (Manager: no AdminSasUrl in the shipped file).
   - #152 BUG-163 record.
   - #154 BUG-159 grip filter.
   Structural on `claude/struc-d1-prep`: #148 stubs hidden and SBEAMEDIT.
3. **Workaround Tim is using today:** CDGRIPDIAG then Off gives normal rectangle grips, confirming BUG-159's cause.

## 2. Open PRs for tonight's merge, in this order

1. **#151** `claude/undo-and-pit-window-01` (Opus):
   - One U = one edit. The cause was CE's out-of-command document locks, each recorded as an empty Undo step.
   - PIT and Edit Pit open the tabbed windows.
   - Edit Pipe clipping fixed.
   - Only filtered tests have run; the full suite is held for after 17:30.
2. **#157** `claude/window-words-01` (Sonnet): the wording and layout sweep on 7 windows. Full suite clean (11 known).
3. **#155** `codex/keyword-shortcuts`: F12 keyword shortcut clashes (Off/On). Filtered tests only.
4. **#156** `codex/perf-audit`: the audit report `docs/perf/PERF_AUDIT_2026-09-24.md`. The **perffix** Codex job (queued)
   adds the four speed fixes to the same branch: tidy-up scan limited to the moved pipe, QA idle debounce, telemetry off
   the command thread, cheap grip IsApplicable.
5. **#153** `codex/ui-import`: import windows built but NOT connected. Connecting them changes how import works, so ask
   Tim first, as with the design windows.
6. **Codex `codex/pit-fit-warning`** (running at 10:19): the approved 2 Sep pipe-to-pit fit warning (warning only; clearances
   on the Settings page; CDCHECK and Project Review).
7. **Structural (base `claude/struc-d1-prep`):**
   - #158 keyword shortcuts.
   - Codex `codex/struc-windows-2` (the rest of the Structural windows; started 09:39, check `out/strucwin2.last.txt`).

## 3. Tonight, after Tim closes AutoCAD (confirm acad.exe is gone, twice, 10 s apart)

1. **Merge and test:** merge the PRs above. Resolve REGRESSION_LOG.md conflicts by keeping both sides (`resolve_log.py`).
   Then run ONE full Civil suite on the final master (`tcivil.ps1`; AutoCAD 2027 on PATH). Known failures: 11.
2. **Build Structural:** `rel_struc_build.ps1 -ExpectedHead <struc-d1-prep tip>` (checkout detached first).
3. **Install:** `rel_install_v2.ps1` (stops BUG-167's zip hang after 180 s and installs from `payload_build`), then
   `rel_struc_swap.ps1`.
4. **Read back:** every lane's version; CE_SHARED identical in Civil and Manager; no AdminSasUrl in any Manager
   `blob-config.json`.
5. **Headless Undo check** from #151's REGRESSION_LOG entry (`tools\headless-proof`).
6. **Codex pass 9** (gpt-6-astra, low, about a 2-hour cap), re-testing:
   - C7 fixes: split, grip, double-click, tidy-up, CDRG.
   - Undo: R-A-4 then R-A-5, Z4 Edit Pipe, X3 Edit Pit.
   - The tabbed PIT / Edit Pit windows.
   - The three design windows.
   - BUG-159 grips.
   - F12 Off/On (CDGRIPDIAG).
   - The pass 8 window fails.
7. **Performance Part 2 and Part 3:** the timed pass on a large drawing copy, then a one-hour soak, exactly as the perf report specifies.
8. **Record everything:** in PENDING_TESTS (the LIVE block, with INVALIDATES).

## 4. Tools (session scratchpad, still on disk)

`C:\Users\TIMOTH~1\AppData\Local\Temp\claude\C--Lisp-Files-CE-ACAD-PLUGIN--claude-worktrees-ce-civil-merge-gate-8a60ae\d4076b2c-9fff-4c1c-883a-ff18db9ab0a8\scratchpad\`

1. **Install and build:** `rel_install_v2.ps1`, `rel_struc_build.ps1`, `rel_struc_swap.ps1`, `rel_struc_rollback.ps1`.
2. **Tests and merges:** `tcivil.ps1 [-Filter]`, `tstruc2.ps1`, `resolve_log.py`.
3. **Codex runner and usage** (in `codex\`):
   - `queue3.sh "name|worktree|model|effort|maxpct"` waits for fewer than `MAXC` live Codex runs (use `MAXC=2` while Tim drafts).
   - `codex_usage.sh [fresh-pct]` refreshes the weekly figure with a tiny luna probe when stale.
   - `common.txt` holds the shared rules appended to every brief; its file list must be kept current.
   - `queue.log` logs start/end and usage before and after each job.
   - `out\<job>.last.txt` holds each job's last message.
   - Launch `queue3.sh` with `run_in_background` or `&` plus `disown`.

## 5. Usage (full rules: `BUILD_TEST_LOOP.md`, "Usage budget")

1. **Codex:** 2% of the week at 10:19. Tim reset it at about 09:20; it must last to Thu 1 Oct 08:57. Daily cumulative
   ceilings: Thu 15, Fri 28, Sat 40, Sun 52, Mon 65, Tue 80, Wed 90, Thu 97. Model matrix: astra low for AutoCAD tests; sol
   high for windows; sol medium for fixes; luna for chores and notes; never the older models. Measured: a sol/high window
   build costs about 1% of the week.
2. **Claude:** 78% at 09:42; resets Fri 12:00. Build with Sonnet, audit with Opus, Opus builds only core work. The old chat's
   own turns were the biggest cost (context over 700k).

## 6. Waiting on Tim

1. **The StrucPlus coloured line toolbar** (his screenshot, 24 Sep about 10:25; about 32 buttons of solid and dashed lines in
   cyan, yellow, black, magenta, white, red):
   - The StrucPlus source, CUIX and LISP are gone from the PC. The Structural module ports 29 of its commands (CJ, SSC,
     CL, REBAR, SCAB, SPW and more) under Utilities → Legacy, but no coloured-line panel exists, and RBL and FFL are stubs.
   - What each colour and pattern meant (layer, linetype, lineweight; draw new or change selected) is not recorded
     anywhere found.
   - **Ask Tim for the mapping, or a drawing or template carrying those layers.** Then write the command card (review
     gate) and build a "Line styles" panel on the Structural ribbon.
2. **Import windows (#153):** connect them? The same question as the design windows.

## 7. Queued builds (after tonight's merges)

1. The Help guide brought up to v3 content (after #157).
2. The tabbed Pit window's "Review changes" list (after #151).
3. Undo leftovers: one U lost after a manual save (draw order re-applied) and after a native COPY of a callout.
4. Structural keyword and window follow-ups.
5. **Needs a card or approval first:** CDSETUP (no approved behaviour card), council rulebook integration, and
   Structural D2 (needs Tim's approval of the D1 card).

## 8. Coordination

The deploy chat (`CE_ACAD / release-v3-colleagues / deploy / 01`) closed Tim's four items:
1. **Signing key:** fine.
2. **Azure key:** made and kept in the drawer only; not needed for V3.
3. **Undo:** Tim ruled "Undo clears it".
4. **BUG-163:** not reproduced.

It holds AutoCAD for Tim's own tests and has stood down from Codex. Message it before any AutoCAD run.
