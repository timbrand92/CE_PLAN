# Re-review 2: PR 2078 `claude/trust-01b-other-drawings-data` (BUG-1456 follow-up, the opening line says when a drawing holds another drawing's CE data)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:36 PC clock. **Head reviewed:** `e1bdc16e` (pushed 07:31, during this run), since `26f110fa` (re-reviewed at 07:35, `reviews\claude-trust-01b-other-drawings-data-rereview.md`). One commit: the one-count change for Check Current Drawing, my small item from the first review. Read only.

---

# FOR TIM

1. **Fixed:** when Check Current Drawing finds another job's CE data in a drawing, it now shows one count of the other job's pits and pipes that are not drawn here, and no longer lists some of them again one by one under a different rule.
2. **Everything else is as before,** and a drawing that does not trip the warning lists exactly what it listed before.
3. **The robot can now run every case on its test list for this one,** row 13 included.

**Verdict: GO** for the robot on copies.

---

# Findings (file and line at `e1bdc16e`)

1. **One count: FIXED.** `Services/CurrentDrawingCheckService.cs:724-726`: only when the warning item is added, the one-by-one "X is not linked to a visible drawing object" items for pits and pipes are removed; every other kind of item stays (a pipe connection item is kept, pinned by the test). The first item's words now say how it counted ("no block, or no pipe line, with that object number") and that those pits and pipes are counted once and not listed again.
2. **The total stays true.** The "N items need checking" line is worked out from the list after this step (`CheckCurrentDrawingCommand.cs:36`, `DrawingCheckPaletteService.cs:127`, `DrawingCheckViewModel.cs:222-235`), so it matches what is shown.
3. **The names cannot drift apart.** The two prefixes are made by the same `BuildFindingId` the one-by-one items use (line 675-676 against line 1003); the test checks that real item names start with them, that a connection item does not, and that the check still builds the items with those names.
4. **Reads only, as before.** The step edits the in-memory list of findings, nothing in the drawing.
5. **Test.** `WhenTheItemIsShown_TheOneByOneNotLinkedItemsAreLeftOut_SoTheListShowsOneCount`: real calls; a Save As revision (the quiet case) keeps all three items.

# What I did not check

1. No build or test run.
2. The palette's look with the new longer words (Codex).
