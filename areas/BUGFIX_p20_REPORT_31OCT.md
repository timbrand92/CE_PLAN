# BUGFIX p20 report: BUG-467 second point turned twice, the fix (step 2 of 2)

Job p20, Sat 31 Oct 2026, about 14:36 to 15:00 Melbourne. **ANSWER: draft PR #1921** (B-109), head claude/b109-bug467-second-point, base claude/rel-20261026s (Structural 1.0.125, 204dfad2). Built and unit-tested only; not AutoCAD-accepted; BUG-467 not marked fixed.

## FOR TIM

1. **Answer:** the fix is built as draft PR #1921. With a turned UCS, BT1, AB and BB now put the brace between the two points you pick.
2. **Example:** UCS Z 30, two points 2400 mm apart along the UCS X: the brace is 2400 mm long at 30 degrees. Before it was 10579.52 mm at 112.63 degrees.
3. **Unchanged:** World UCS, ENTER (2700), Zero and R1 Point behave as before.
4. **No Settings switch** (your decision 169): always on.
5. **My own mistakes:** none that reached the code. I wrote the first edit script for bash and had to rerun it in PowerShell, and the first net48 build failed only because "powershell" was not on my PATH (the compile itself had 0 errors; the rerun passed).
6. **Not proven:** nobody has opened it in AutoCAD. A CLICKED second point (including snaps) and the drag line need a Codex look. The rubber band's start point in a turned UCS is still unsettled (leave as is; look at it in the same Codex check).
7. **Nothing for you to do now.**

---

## Technical detail

### Fault re-checked on the start point
Confirmed on origin/claude/rel-20261026s: BracingCommands.cs line 769 `secondPoint = jig.CurrentPoint.TransformBy(ucs);` and BracingService.cs WorldDraw `end.TransformBy(_ucs)`. The jig answer from AcquirePoint (BracingService.cs Sampler) is stored unchanged, so it is World; p19's reading is right. Not already fixed.

### Change (one rule, design rule 1)
1. New pure rule `Modules/Structural.DesignCore/BracingSecondPoint.cs`: a jig answer is returned as given; only the ENTER / Zero default (built along UCS X) is turned once.
2. `BracingCommands.BracingEndWorld` wraps it with the real UCS matrix; `TryGetSecondPointWithPreview` uses it for both the answer and ENTER/Zero; `BracingPointJig.WorldDraw` uses the same call for the preview end.
3. The jig's start value is now the World first point, so no stray line draws before the first drag.
4. REGRESSION_LOG.md entry added. CE_SHARED not touched. No new write, command, regen, view or system variable; layers, Xrefs and REFEDIT untouched.

### Tests (all net10; each command named one .csproj and had a --filter)
1. DesignCore.Tests `FullyQualifiedName~BracingSecondPointTests`: 4 passed, 0 failed (UCS 30: length 2400, rotation 30; Enter 2700 at 30; World UCS unchanged; the old double turn documented as 10579.52 at 112.63).
2. Structural.Tests `HuntS02UcsTests|Bug433LowsTests`: 15 passed, 0 failed. The two wrong HuntS02 source pins now pin the corrected text (jig.CurrentPoint is not turned; preview end not turned again).
3. net48 compile (Release, refs from the recipe): Build succeeded, 0 errors.
4. Not run: full suite, Manager, Civil (by instruction). I did not run the new test against the start point to show the red case; the old arithmetic is pinned in a test instead (item 1 last test).
5. Test env: CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\p20\struc and CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\p20\logs, echoed before each run.

### Real-files compare (before and after, names, sizes, times only)
Listings taken with a script over TIM_CE_CADTOOLS (CE_Admin and logs), CE_STRUC_SUITE, CE_CVL_SUITE, CE_CADTOOLS (CE_Admin). Before 33,269 files; after 33,275. **No settings file changed** (CS_Settings.json in both folders, CD_Settings.json: same size and time; the Structural one is 35613 bytes, 30 Oct 19:54:14). What did change, all stamped 14:40 to 14:42 (my tests ran about 14:42 to 14:55): CE_Admin outbox machine heartbeats and session files for CE_CVL_SUITE, CE_STRUC_SUITE and CE_SUITE_MANAGER; CE_Admin usage json files (6 new); CE_CVL_SUITE\telemetry\outbox.jsonl (14:40:36); manager-menu-state.json and CE_SUITE_MANAGER_MENU.cuix (14:40:54); the ce_struc_structured_20261031.log growing. **Honest reading:** Structural unit tests cannot write the CVL telemetry, the Manager menu or Manager sessions, so these look like another AutoCAD session starting on this PC about 14:40 (acad was not running by the time I checked). I cannot prove that from here; flagging it as the instructions require.

### Shared files
Open drafts touching the same files: #889 (BracingCommands.cs, locked-layer skip, base rel-20261009f, older line), #863, #770, #808, #647 and #760 (older lines, their content already in 204dfad2 or on other bases). #1883 (Civil line, switch Bracing.PickedPointsFollowUcs) not used or copied. A merge conflict with #889 is possible later.

### Robot cases for CE 02
1. **aS1, aS2, aS3 and their broken twins** must pass on a candidate build with this PR (aS1 BT1 and aS2 AB/BB were the FAIL cases; aS3 R1 Point stays PASS).
2. **S467a and S467b** pass unchanged (BT1 `_.UCS _Z 30`, `17700,-3300`, `20100,-3300`, `1`, `No`: line "Preview length: 2400\s+rotation: 30(?![\d.])" and brace within 1 mm of World 16978.650,5992.116; AB/BB as aS2).
3. **New control S467e_bt1_ucs30_enter:** `_.UCS _Z 30`, BT1 `17700,-3300`, then Enter (Settings default 2700), `1`, `No`. Check "Preview length: 2700\s+rotation: 30(?![\d.])". It passes today and must still pass after (Enter path).
4. **Needs a Codex look (a robot cannot read a drag):** a CLICKED second point and an endpoint snap in UCS Z 30 (draw a 2400 line along the UCS X, BT1 snap its two ends: expect "Preview length: 2400 rotation: 30" and the brace on the line), and the drag rubber line ending under the cursor. Screenshot of the drag.

### Housekeeping
Worktree C:\CE_WORK\build\p20\w and scratch C:\CE_WORK\scratch\p20 removed at the end (see below). BUG_CARPARK.md and DESK_LOG.md not edited.
