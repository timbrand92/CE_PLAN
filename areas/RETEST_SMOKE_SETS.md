# RETEST SMOKE SETS and the standing re-test rule (PERMANENT FILE, CE 02; created Fri 30 Oct 2026 00:10; keep current)

Companion of `RETEST_AREA_MAP_29OCT.md` (the areas) and `decisions\2026-10-29_TIM_RETEST_RULE.md`. Owner: CE 02. The C-77 working draft stays in `C77_AREA_SMOKE_SETS_DRAFT_29OCT.md`.

## The standing rule (Rule 14, areas\CE_SESSIONS_MAP_29OCT.md; Tim: "thats should be the plan throughout as a rule")

1. After ANY install, re-run the cases of every tool area the changed files touch, plus the smoke set (section below) of every shared group the changed files touch. Everything else keeps its earlier pass, labelled "carried from <build>".
2. ONE full re-test (all counted accepted cases, two separate starts each) before anything goes to Max (cut-off Fri 13 Nov) and every weekend, as planned.
3. A file the map does not know is PLACED in an area by CE 02 (record the placement here) and does not force FULL.
4. A fix whose only settings change is a brand-new switch with a new name counts as touching only its own tool.
5. EDITING or REMOVING an EXISTING setting still forces FULL. A saved-data migration (an old saved table or ladder moved once) counts as editing existing data. A changed DEFAULT of an existing key is a judgement call put to Tim (question raised 30 Oct via CE 00); until he answers, treat it as FULL.
6. Any FAIL, FLAKY or BLOCKED in the smaller set widens to FULL in the next free window.
7. The job text of every tester_run job says this (tester_run81 carries it now).

## How to refresh this file

1. After each train, read the finalizer's changed-file list, place any new file in an area (git grep its class name for callers; a core caller adds the core smoke set S3), and add the placement below.
2. Re-check smoke case names against `C:\ce-fx\retest\spec_full_weekend.txt` and the current accepted list.
### 2. Smoke sets, one per shared group (named cases from the weekend spec)

Case names are the accepted cases in `C:\ce-fx\retest\spec_full_weekend.txt`. Each set is five or six cases chosen so the group is exercised from at least two tools.

1. **S1 Settings** (`Models/*Settings*.cs`, settings services, Settings window): R07 (Settings Cancel throws a change away), R10 (Settings window state), R14h_pipekey_200 (CDTWL wording follows a setting key), N05 (a placed pit gets the default values), R02 (a new pipe joins the pit).
2. **S2 The pit and pipe record** (`ProjectData*`, spine, pipe record): N01 (CDREBUILD), N26 (sync), R04 (CE never saves; stored record unchanged on disk), R13, R15.
3. **S3 The linking engine core** (`LinkService.cs` and its core partials): R01 (PIT and CD keep placing, one U takes back), R02, N12 (COPY of a pit), R16 (move), N01, N24 (CDRENUMBER).
4. **S4 Undo and redo plumbing:** R01, N01 (one U echoes CDREBUILD), R15, R16, N12.
5. **S5 Command log and command-line words:** N01, N21 (CDFEEDBACK), N20 (callout snap prompt), R04, N24.
6. **S6 Labels and text formatters:** N05, N25 (label lands where clicked), N20, R03 (one IL text at each pipe end), N24, R16.
7. **S7 Layers, blocks, drawing access:** N05, N03 (DP), N12, N16, R02.
8. **S8 Overrules and CE's pipe object:** R02, R03, N20, R23 (Edit Pipe), R32, R11.
9. **S9 Load path, ribbon, bundle:** R05, R07, R08, R10, N21.
10. **S10 Shared window parts:** N21 (Feedback window), R07 (Settings), N07 (PIT window), N02 (Pit Schedule), R11.
11. **S11 Manager and other modules (CE_SHARED, Manager):** the launch group R05, R07, R08, R10, plus N21. Manager windows (About) need the Codex look A1.
12. **S12 Unknown file:** FULL.

**Union if every group is touched:** R01 R02 R03 R04 R05 R07 R08 R10 R11 R13 R15 R16 R23 R32 N01 N02 N03 N05 N07 N12 N16 N20 N21 N24 N25 N26 R14h_pipekey_200 = 27 cases, about 3 h 15 min for two starts each.

### 3. The two unmapped files

Checked with `git grep` on `origin/claude/rel-20261029a` (5888ee75, the 3.0.86 line).

1. **`Services/FallArrowDirectionReviewService.cs`.** Used only by `Commands/SpineCheckCommand.cs`, `Services/Checks/ChecksResult.cs` and `Services/Checks/ChecksResultReader.cs`, all in area 10 (Checks). **Placement: area 10, cases R05, R10, R19, R21.** It does not touch Edit Pipe.
2. **`Services/LinkService.SourceScanMemo.cs`.** It remembers what a first look at an object proved, for the downpipe and overflow landing. Used by `Rules/OwnerScanMemo.cs`, `Rules/SourceLandingSpeedRule.cs` and, importantly, by `Services/LinkService.Geometry.cs`, which is a core linking file (shared group 3). **Placement: area 8 (DP, OF and other sources: N03, N04, R36) plus area 7 (copy, move and rotate: the source landing is called from the copy code), plus S3 (core) because of the Geometry caller.** If a C-77 diff touches `LinkService.Geometry.cs` itself, S3 is mandatory; if it only touches the memo file or the rules, area 8 plus S3 is the set. This stops unknown forcing FULL.


### Placements recorded so far

1. `Services/FallArrowDirectionReviewService.cs`: Checks area 10 (R05 R10 R19 R21); only CDCHECK code uses it (30 Oct 2026).
2. `Services/LinkService.SourceScanMemo.cs`: sources area 8 (N03 N04 R36) plus copy and move area 7 plus core smoke S3, because the core file `LinkService.Geometry.cs` calls it (30 Oct 2026).