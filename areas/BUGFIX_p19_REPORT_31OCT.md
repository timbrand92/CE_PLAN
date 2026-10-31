# BUGFIX p19 report: BUG-467 root cause (step 1 of 2, read only)

Job p19, Sat 31 Oct 2026, about 14:05 to 14:40 Melbourne. Code read on origin/claude/rel-20261026s at 204dfad2 (installed Structural 1.0.125). No code change, no build, no test, no PR, no AutoCAD, no Codex.

## FOR TIM

1. **Answer:** the fault is real and it is one wrong line. When you give BT1, AB or BB its second point, AutoCAD already hands CE that point in World. CE then turns it by your UCS a second time. That is why a 2400 mm brace came out 10.6 m long at 112 degrees.
2. **Who caused it:** our own earlier fix (HUNT-S-02, commit 2a395832, about 9 Oct). Before that fix the second point was right; the fix added the extra turn. The unit test written with it checks that the wrong line is there, so it stayed green.
3. **Clicked points too:** yes, from the code a clicked second point is turned twice exactly like a typed one. Snaps too. The further the job is from the drawing's 0,0, the further off the brace lands. In World UCS nothing is wrong.
4. **The drag preview is wrong too:** the rubber line you see while dragging ends away from the cursor in a turned UCS. Same cause.
5. **Enter (2700 default) and Zero are already right:** they lay the brace along your UCS X and turn it once. They do not need changing.
6. **R1 Point is right** (the robot passed it): it asks for the point a different way, which gives a UCS point, so one turn is correct there.
7. **The fix:** remove the extra turn on the second point and in the preview line. Two lines in two files, no Settings switch (your decision 169). PR #1883 has the same mistake and would not fix it.
8. **What you would see after the fix:** UCS turned 30 degrees, BT1 on two points 2400 apart along your UCS X prints "Preview length: 2400 rotation: 30" and the brace sits between the two points you picked.
9. **Not proven:** nothing was run. Whether the drag line starts from the right place in a turned UCS still needs a Codex look (detail below, item 4 of the technical part).

Nothing for you to do now. Step 2 (the build job) can go ahead on this.

---

## Technical detail

### Mistakes of my own

None in this job. One process note: gh is not on the Bash PATH here; I used "C:\Program Files\GitHub CLI\gh.exe" to read PR #1883.

### Q1. Why the second point is turned twice (file, line, statement)

1. **The wrong statement:** `Modules/Structural/Commands/BracingCommands.cs:769`
   `secondPoint = jig.CurrentPoint.TransformBy(ucs);`
2. **Why it is wrong:** the jig answer comes from `JigPrompts.AcquirePoint` (`Modules/Structural/Services/BracingService.cs:1447`), and `BracingPointJig.Sampler` stores `res.Value` unchanged in `_currentPoint` (`BracingService.cs:1470`). A jig point from AcquirePoint is in World (WCS), unlike `Editor.GetPoint`, which answers in the current UCS. The comment at `BracingCommands.cs:746` ("the question and the preview work in the current UCS") assumes the GetPoint behaviour for the jig too. That assumption is the root cause.
3. **The arithmetic proves it** against CE 02's run aS1 exactly. UCS Z 30. First point typed 17700,-3300 gives World 16978.650,5992.116 (correct, line 279). Second point typed 20100,-3300: AcquirePoint returns World 19057.111,7192.116. Line 769 rotates that by 30 degrees again: 12907.8,15757.1. Distance from the first point = 10579.5, angle = 112.63 degrees. The command printed "Preview length: 10579.52 rotation: 112.63". CE 02's own note (rotating the correct World point by 30 degrees again gives the point used) is the same finding.
4. **When it came in:** `git log -S` shows commit 2a395832 ("HUNT-S-02: Structural commands convert clicked points from the UCS to World", PR #879) added `.TransformBy(ucs)` to that line. Before it, `secondPoint = jig.CurrentPoint;` was correct for the answer.
5. **Why the tests did not catch it:** `Modules/Structural.Tests/Services/HuntS02UcsTests.cs:54` pins the wrong text (`Does.Contain("secondPoint = jig.CurrentPoint.TransformBy(ucs);")`) and line 57 pins the wrong preview text. They are source pins, not behaviour tests.
6. **The working sibling:** the beam jig (`BeamService.cs:49-62` and `BeamPointJig`, about 1150-1210) passes the World first point and keeps `jig.CurrentPoint` as is, with no turn. That is the correct pattern.
7. **Callers affected (all three go through the one method):** BT1 `BracingCommands.cs:279-280`; AB and BB through `TryGetBracingEndpoints` at 587-588 (Wall option OFF, the default) and 600-601 (Wall option ON, first point clicked). The Wall route itself (`TryGetWallBracing`, 604-668) does not use the jig and is not affected.
8. **R1 Point is not affected:** `RafterJoistCommands.cs:1360-1374` uses `ed.GetPoint`, which answers in the UCS, then `ToWcs` once. One turn is right there; that matches aS3 PASS.

### Q2. A clicked second point

1. **From the code: yes, turned twice the same way.** AcquirePoint returns World for every kind of input (click, object snap, typed absolute, typed relative, polar tracking); the code at line 769 does not know which kind it was. The robot's typed-points result therefore stands for clicks too.
2. **The size of the error depends on where the job is:** the extra turn is about the World origin, so a brace 20 m from 0,0 lands roughly 2 x 20 m x sin(15 degrees), about 10 m, away; a job on survey coordinates hundreds of metres out would land hundreds of metres away.
3. **What would prove it (Codex look, AutoCAD, copy of a drawing):** draw a LINE from 17700,-3300 to 20100,-3300 in World. Then `UCS` `Z` `30`. Run BT1, endpoint-snap the two ends of a line drawn 2400 long along the new UCS X (or type them). Today expect "Preview length" about 10580 and the brace far away; after the fix expect "Preview length: 2400 rotation: 30" and the brace on the line. Also watch the drag: today the rubber line end does not sit under the cursor in the turned UCS; after the fix it should. Screenshot of the drag needed (the robot cannot read a drag).

### Q3. Is changing only the final transform enough? Each path

1. **Typed or clicked second point (line 769):** wrong now (turned twice). Must change: use `jig.CurrentPoint` as is.
2. **Enter default (line 762)** `new Point3d(baseUcs.X + enterLength, baseUcs.Y, baseUcs.Z).TransformBy(ucs)`: right now. `baseUcs` is the UCS form of the World first point (line 748), so the 2700 runs along UCS X and is turned once. No change.
3. **Zero keyword:** sets the same `_useDefault` flag in the jig (`BracingService.cs:1457-1462`) and goes through line 762. Right now. No change.
4. **Enter with no Settings length (line 756-760):** asks again with the World `basePoint`. Right now. No change.
5. **Preview line (`BracingService.cs:1478-1488`, `WorldDraw`):** wrong for a dragged point. It draws `end.TransformBy(_ucs)` where `end = _currentPoint` is already World, so the drag line's far end is turned twice (only shows in a turned UCS). For the Enter/Zero branch, `end = _basePoint + length` is UCS, so turning it is right. Must change: turn `end` only in the Enter/Zero branch.
6. **Rubber band base point (`BracingService.cs:1438`, `BasePoint = _basePoint`, the UCS form):** NOT proven either way from code. The beam jig passes a World base point; the bracing jig passes a UCS one. I could not confirm from the code which frame `JigPromptPointOptions.BasePoint` expects. It only affects the drawn rubber band and where Ortho locks from, not the answer for an absolute typed or clicked point. Recommendation: leave it as it is in the smallest fix and make it a named item of the Codex look (Q2 item 3); if the rubber band starts away from the first point in a turned UCS, change it to the World `basePoint` like the beam jig in a follow-up.
7. **The "Preview length / rotation" message (`BracingCommands.cs:307` and the AB/BB twins at 60 and 176):** computed from the World pt1/pt2 after the jig, so it comes right by itself once line 769 is right. No change.

So: the final transform alone is NOT quite enough; the preview line's dragged end needs the same correction. Enter, Zero and the message do not change.

### Q4. Smallest safe fix (no Settings switch, Tim decision 169)

1. **`Modules/Structural/Commands/BracingCommands.cs:769`:** `secondPoint = jig.CurrentPoint;` with a one-line comment: the jig answers in World (AcquirePoint), only the Enter/Zero point is built in the UCS (BUG-467). Correct the comment at 746 to say the same.
2. **`Modules/Structural/Services/BracingService.cs` `WorldDraw` (about 1478-1488):** draw `WorldLine(_basePoint.TransformBy(_ucs), _useDefault ? endUcs.TransformBy(_ucs) : _currentPoint)`. Correct the field comment at 1419.
3. **Better (still small, and it makes it testable without AutoCAD):** put the frame choice in one pure helper both places call, e.g. `internal static (double X, double Y) BracingSecondPointWorld(...)` in DesignCore or Core taking the World first point, the UCS angle and origin, the jig's World answer, the use-default flag and the Enter length as plain numbers. Rule #1 (one code path): the command answer and the preview end both come from it.
4. **No new write, command, regen, view or system variable change.** Nothing about layers, Xrefs or REFEDIT changes. CE_SHARED is not touched. No Settings key is added (do not add Bracing.PickedPointsFollowUcs; PR #1883 is not used).
5. **PR #1883 (read with gh pr diff, 31 Oct):** its line 185 is `secondPoint = jig.CurrentPoint.TransformBy(toWorld);` and its WorldDraw turns `end` too. It makes the same wrong assumption, so it would not fix the second point. Agrees with CE 05's note.

**Unit tests that fail before and pass after:**

1. New behaviour test (through the helper in item 3): UCS 30 degrees about 0,0; first point World 16978.650,5992.116; jig answer World 19057.111,7192.116; expect the second point back unchanged, length 2400 +/- 0.01, World angle 30 +/- 0.01. Before (helper copying today's rule, answer turned by the UCS) it gives 10579.52 at 112.63: fails.
2. Enter default under UCS 30: first point as above, use-default, length 2400: expect World 19057.111,7192.116 (2400 at 30). Passes before and after (guards that the fix does not break Enter/Zero).
3. World UCS (angle 0): any answer comes back unchanged and Enter gives +2400 in X. Passes before and after (the World case drafters use most).
4. Preview end equals the command answer, both for a dragged point and for Enter, under UCS 30. Fails before for the dragged point.
5. Source pins to change in `HuntS02UcsTests.cs` (lines 50-58): replace `Does.Contain("secondPoint = jig.CurrentPoint.TransformBy(ucs);")` with `Does.Not.Contain("jig.CurrentPoint.TransformBy(")` (fails before, passes after), and the line 57 preview pin with one that forbids turning the dragged end. `Bug433LowsTests.cs:124` (pins `BracingPointJig(baseUcs, prompt, ...)`) stays green with the smallest fix.

**Files the fix touches:** `Modules/Structural/Commands/BracingCommands.cs`, `Modules/Structural/Services/BracingService.cs`, `Modules/Structural.Tests/Services/HuntS02UcsTests.cs`, one new test file (or the helper's home in DesignCore plus its test), `REGRESSION_LOG.md`.

### Robot case that proves it (with a control)

1. **S467a_bt1_ucs30_proof and S467b_ab_bb_ucs30_proof, unchanged:** they already type the right things and check the right lines. After the fix both should PASS: BT1 `_.UCS _Z 30`, BT1 `17700,-3300` then `20100,-3300`, `1`, `No`; check "Preview length: 2400\s+rotation: 30(?![\d.])" and the brace within 1 mm of World 16978.650,5992.116. AB/BB as in aS2.
2. **Control (no switch exists, by Tim's decision):** the control is the World-UCS half of S467a (already in the case, passing today: "Preview length: 2400 rotation: 30" at 16978.650,8992.116) plus a new **S467e_bt1_ucs30_enter**: `_.UCS _Z 30`, BT1 `17700,-3300` then Enter, `1`, `No`; check "Preview length: 2700\s+rotation: 30(?![\d.])" (Settings default 2700). It passes today and must still pass after the fix (Enter path untouched).

### What is NOT proven

1. Nothing was run. The answer comes from code plus the exact arithmetic match with aS1.
2. The clicked second point and the drag preview: code only; needs the Codex look in Q2 item 3.
3. The frame of the rubber band base point (Q3 item 6): not settled.
4. FPFC (aS4) was not looked at in this job (out of the asked scope).

### Housekeeping

1. No worktree was made (read only; the source was read with git show into C:\CE_WORK\scratch\p19, which is removed at the end).
2. No dotnet build or test ran, so the before/after settings listings under %APPDATA% are not needed: this job ran no test code.
3. BUG_CARPARK.md and DESK_LOG.md not edited.
