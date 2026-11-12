# Re-review: PR 2072 `claude/trust-b1435-sync-refuses-type-change` (BUG-1435, a type typed over in the bracing table is refused)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:35 PC clock. **Head reviewed:** `0f7ca816`, since `b3986ade` (reviewed GO at 06:19, `reviews\claude-trust-b1435-sync-refuses-type-change.md`). New since then: `514f8334` (2071's review fix, re-reviewed GO at 07:03) and the merge `0f7ca816`, which brings it in and carries this PR's two small items. Own change read as the difference from 2071's head `514f8334`. Base `8de95c34`. Read only.

---

# FOR TIM

1. **Both small things from the last review are fixed:** the refusal line now gives the row number the way AutoCAD's own table counts it (the first brace is row 3), and it names the layer the brace is really on, read from the brace, not worked out from the letter.
2. **One new small thing:** if on the same row you typed a new type AND a new length, the length is still written (as it should be), but the line says "The brace was not changed." It should say the type was not changed.
3. **Nothing else moved:** the type is still never written from the table; length and angle follow 2071's rule (only cells you edited).

**Verdict: GO** for the robot on copies together with 2071, one small wording item before Codex reads the line.

---

# Findings (file and line at `0f7ca816` unless stated)

1. **Row number: FIXED.** `Services/ScheduleService.cs:809` passes `row + 1`; the loop starts at index 2 (line 773), the first brace row, which AutoCAD's table editing calls row 3. `BracingTableSyncPlan.TypeChangeRefusedLine` describes the numbering (`BracingTableSyncPlan.cs:21-37`). Test `TheRowInTheLine_IsNumberedTheWayAutoCadsTableNumbersIt_...` pins the call text.
2. **Real layer: FIXED.** Line 809 passes `br.Layer`, the brace's own layer; with no layer the line says "the brace would stay as A" and names no layer. Test `TheRefusalLine_NamesTheBracesRealLayer_...` is a real call with a moved-brace layer and a blank one.
3. **Still never writes the type.** The `if (plan.TypeEdited)` branch (line 808-809) only prints; no `SetAttributeValue` anywhere in `SyncBracingTable` (pinned by `TheSync_NoLongerWritesTheTypeText_...`). The table's record keeps the old type (`was.BuiltType` untouched), so every later sync repeats the line until the table is refreshed, which the line asks for. Right.
4. **New, small: "The brace was not changed." can be untrue.** A row with both the type and the length (or angle) edited prints the refusal (line 809) and then writes the length (line 811-816) or angle (818-824). Say "Its type was not changed" or print the line after the writes with what was and was not changed.
5. **2071's two small items (from its 07:03 re-review) are still open on `514f8334`** and so here too: the "left as drawn" count includes a brace whose cell was also edited; after a write the table record update has no fallback.

# What I did not check

1. No build or test run.
2. The table in AutoCAD (row numbering seen only through the code and the table's own index).
