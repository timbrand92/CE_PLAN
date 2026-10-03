# Controller review of STRUC-ROOF-DOWN-PRODUCTION_CARD (4 Oct 2026, controller 06)

Checked against the plugin code on `origin/claude/rel-20261015w` (installed Structural 1.0.99 line), read only, and the plan rules (R-00 Settings-first, R-27 no hard blocks, native locked-layer/Xref protection, one U per CE command, plain English, roof-down order, DATA-01).

## Verdict: sound; fix 6 points before it goes to Tim as a card

1. **WRONG (fix): "a per-plan level is missing / UX-LEVEL-01 not built" (card 2.1 item 3).** It IS built and installed: command **CSPLANLEVEL** (`PlanLevelCommands.cs`, "Records which level this plan is (Ground, First, Roof ...). Set once per plan"), `PlanLevelRecord`, the office level list in Settings (`SettingsService.Current.PlanLevel.LevelNames`), and UX-LEVEL-02 (copies, records CE cannot follow) is merged too. `LoadTraceEngine.LevelAbove(level, order)` already uses it, and the markers say "This plan's level was recorded as X" when the level is unconfirmed. So Q1 ("turn markers on") needs one extra sentence: **each plan's level must be set (CSPLANLEVEL) and confirmed first**, otherwise the markers name an unconfirmed level or say there is no level above.
2. **Command names: all accurate.** Spot-checked 26 names in the installed line (CSLOADPATH, FST, FSF, FPFC, PFC, FREGENALL, CSMARKSRENUMBER, CSFOOTINGLEGEND, CSINFILL, STRSCHEDREFRESH/SYNC, STRUCEXPORTPDF/CSV, CESHEETS, CEPROPS, CENOTES, CECHECKLIST, CEMARKUP, CEARCHREVIEW, FSTEXPORT, CSBRACINGREQUIRED, CSTIEDOWN, CSWINDCLASS, XCLMTXT, CE_MEMBERLABEL, CSSOILREPORT): all exist. **CSFDNPROPOSE does not exist**, as the card says (missing). Facts about UX-LOAD-01/02/03 and RoofPointLoadCarryDown match the code (switched off / engine only / unwired).
3. **CSMARKSRENUMBER is ALREADY a previewed, one-Undo "Renumber marks in order"** (UX-MARK-01, `CeTextCommands.cs`): the card's "as a proposal list" is right, but the assistant needs a NON-INTERACTIVE form (preview written to the report, apply only when the drafter accepts); today it is an interactive command, which is exactly what wedged the driver (a prompt left waiting). Add this to 3.3 as a prerequisite build item.
4. **"One Undo" does not apply to a headless run (3.1, section 5).** In the console there is no U after the drawing is saved. The real safety is: copies only, a report listing every change, the original untouched. Say "one U per step when run interactively; headless runs are protected by working on a copy". Do not promise Undo for a saved copy.
5. **FREGENALL rewrites footing graphics (3.1 item 4).** It is mechanical but it erases and redraws CE footing outlines; on a locked layer it must skip and say so (the S-14/S-16 finalizers confirmed nothing is unlocked). Keep it on the allow-list but mark it "writes graphics: copy only, locked layers reported". Same for STRSCHEDSYNC (writes the schedule table).
6. **Quiet hours (3.3 item 1):** AGENTS.md's 8:40-5:30 hours are Tim's drafting hours for LONG TEST RUNS, not a rule for the product; as a Settings value it is fine (default after 5:30 pm and before 8:40 am), but write "Tim's PC lag finding: a polling or computer-control client costs about 1 core of AutoCAD while it reads": the assistant must run outside drafting hours and must not poll a window.

## Rules check

1. R-00: every number/list is a Setting (allow-list, queue path, report folder, copy folder, quiet hours, max run time, learned placement values): OK. Add: the **Manning's n / Settings duplicate** lesson (a hard-coded second table beside Settings, found in C-15) is the failure to avoid for the learned values: one source of truth.
2. R-27: no hard blocks: the card only skips locked/foreign content and reports; the allow-list refusal of design steps is the one deliberate refusal and is Tim's own list: OK (state it as such).
3. Native protection: sections 3.1 item 4 and 5 item 4: OK.
4. Plain English: section 1 is plain; the questions are typed and short: OK. Roof-down order: sections 2 and 6.2 follow roof, upper floors, ground, footings last: OK.
5. DATA-01: OK (counts and positions only; names stay local).
6. No third-party code (INT-035): OK; the MCP wrapper stays "only if needed".
7. Boundary (Tim: "drives only that boring end, never design decisions"): the allow-list in 3.1 is correct. One addition: **"CSLOADPATH ... Check load path"** is a check (list), fine; **"Propose footings" (CSFDNPROPOSE) must stay a PROPOSAL the engineer accepts, sizes Unknown** (already stated).

## Questions for Tim (section 7): fine; changes

1. Q1 add: "each plan needs its level set once with CSPLANLEVEL".
2. Q3/Q4: fine. Q7: ask which title block is the DEFAULT for NEW jobs, not "standard now".
3. Add Q9 (small): **may the assistant refresh the schedules of a handed-over drawing, or copies only for the first month?** (the card says copies only today; make it explicit as a month-one setting).
