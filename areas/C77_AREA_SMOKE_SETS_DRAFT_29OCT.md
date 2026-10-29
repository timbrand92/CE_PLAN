# C-77 re-test: area plus smoke sets, the two unmapped files, and the revised Friday (DRAFT, Thu 29 Oct 2026 23:50)

Written by CE 02 Robot and Codex Testing after Tim's ruling "do your recommendation" (relayed by CE 00 at 23:45). This is a DRAFT from the area map (`RETEST_AREA_MAP_29OCT.md`) and CE 01's list of what C-77 changes. The final set for C-77 is cut at about 07:30 Fri from the real file list (`git diff --name-only 5888ee75..<C-77 head>`), and this file is then rewritten as the decision record.

## ANSWER FIRST

1. **C-77 is re-tested by AREA plus SMOKE, not FULL.** The robot re-runs the cases of every tool area the train touches, plus a small named smoke set for each shared file the train touches. Everything else is carried from 3.0.86.
2. **Cost, indicative (3.6 minutes per case measured tonight, two separate starts per case):** a worst case where every shared group is touched is a smoke union of 27 cases, about 3 h 15 min. Add the touched areas (6 to 30 cases each). Expect 3 to 5 hours against about 8 hours for FULL.
3. **The two unmapped files are placed:** `FallArrowDirectionReviewService` goes to the Checks area; `LinkService.SourceScanMemo` goes to the sources area plus copy and move, because its caller `LinkService.Geometry.cs` is core (details below).
4. **Friday moves earlier:** the 3.0.87 re-test starts about 12:15 and should end about 15:30 to 17:30, so the Codex looks on 3.0.87 (H1 to H8) can start that afternoon instead of overnight.
5. **Carried passes are labelled "carried from 3.0.86" in the ledger.** One FULL re-test runs before Max (plan Thu 12 or Fri 13 Nov) and the Saturday weekend full re-tests stay as already planned.

## FOR TIM

1. **What happens on a job night:** the robot no longer repeats every check after every install. It repeats the tools the fixes touched, and a few "does the basic stuff still work" checks for anything that every tool shares (settings, labels, undo, the pit and pipe record).
2. **What you need to do:** nothing.
3. **What it cannot catch:** a fix to one tool that breaks another through a link the map does not show. The Saturday full re-test and the one before Max are the safety net. Any red in the smaller set widens it to a full re-test straight away.

---

## Detail

### 1. The rule used (from the area map section 4, with Tim's ruling applied)

1. List the changed product files. Drop tests, docs and version-only lines.
2. A file in an area: that area's cases re-run. A file in a shared group: that group's smoke cases re-run (below). A file in no area and no group: FULL (stays the safe default).
3. Any FAIL, FLAKY or BLOCKED in the set widens to FULL in the next free window.
4. Each case runs in two separate AutoCAD starts on 3.0.87. No twins for a case whose file hash is unchanged.
5. The ledger labels every other accepted case "carried from 3.0.86 (two passes, ledger item for C-76)".
6. **Change from the map:** an edit to an EXISTING setting no longer forces FULL by itself (Tim's ruling). It forces the Settings smoke set plus the area of the tool that reads that setting.

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

### 4. What C-77 is expected to touch (CE 01, 23:25), mapped

Provisional; the final map is made from the real file list at about 07:30.

1. **B-008 Tidy labels default ON:** area 6 (Tidy and label placement: R16 N27 N05 N20 N25 R03) plus S1 (a default changed) and S6.
2. **B-046 pipe object Automatic reads On:** area 2 (New Pipe) plus S8 plus S1.
3. **#1841 minimum-fall ladder, #1843 lid table, #1854 council data, #1850 cover table by surface:** calculations and rules: area 13 (no accepted robot case) plus S1; Codex look H8 for the visible answer.
4. **B-035 new-profile defaults:** S1 and a fresh-profile check (new case needed; carried until written).
5. **B-009 grip copy default:** area 7. **BUG-1227 fix (B-049a):** area 7 plus S3; the failing case for it joins the next batch.
6. **Everything else adds a new switch beside unchanged settings:** the area of the tool plus S1 only if a settings file line is edited.

### 5. Revised Friday (to confirm once CE 01 gives the file list)

1. **Tonight to 05:00:** the 3.0.86 full pass finishes. **05:30:** report job ends, hold lifts.
2. **05:30 to 09:40:** Codex looks G3, G7, G4 on 3.0.86. **From 09:40:** nothing in AutoCAD.
3. **09:45 to 12:00:** CE 01 payload and install (about 11:00). CE 01 messages "installed, DLLs re-read".
4. **About 12:15 to 15:30 or 17:30:** the AREA plus SMOKE set on 3.0.87.
5. **Then:** Codex looks H1 to H8 on 3.0.87 (cap 30 until 17:53, then 44, then 58 on Sat), then A1, C1, C3, C6, G6, G5. Then run79 and run78 from `ROBOT_QUEUE_AFTER_C77.txt` when the robot has a free window.
6. **Saturday:** weekend full re-test. **Thu 12 or Fri 13 Nov:** the one full re-test before Max.

### 6. What I did NOT verify

1. The C-77 file list: it does not exist yet (assembler about 07:15). Every area and smoke mapping above for C-77 is provisional.
2. The smoke case choices were made from the case titles in the area map and spec, not by re-reading each case file against each shared file.
3. No case was run for this document; tonight's pass was not touched.
