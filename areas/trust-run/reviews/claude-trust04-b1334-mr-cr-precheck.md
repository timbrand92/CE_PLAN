# Review: PR 2081 `claude/trust04-b1334-mr-cr-precheck` (BUG-1334, MR and CR on AutoCAD 2027 say in plain words what they cannot move)

**Reviewer:** lane trust-review (fourteenth run). **Written:** 2026-11-13 07:27 PC clock. **Head reviewed:** `c78016cf` (own commits `323f6ec5`, `c78016cf` on `cf059dcf`, the installed Civil 3.0.90, confirmed as ancestor). Read only: no build, no test run, no AutoCAD.

---

# FOR TIM

1. **On AutoCAD 2027, MR and CR now check what you picked before moving anything.** One CE pipe in the selection used to stop the whole move with "CE transform stopped (eNotApplicable)"; now one plain line names the pipe and its layer and says nothing was changed. Nothing is unlocked, no Xref is touched, and everything the move refused before is still refused.
2. **The pipe still cannot be moved with MR or CR on 2027;** that needs a change to the native part and is not in here. AutoCAD 2022 to 2026 are not touched.
3. **Two small things to put right before Codex looks:** after CR picks its objects by asking you, the ORIGINALS stay gripped afterwards (a Delete press would erase them); and the line's advice "leave the pipe out of the selection" can leave a pit moved away from its pipes.

**Verdict: GO** for the robot on copies in AutoCAD 2027, with the small items below before Codex's look.

---

# Findings (file and line at `c78016cf` unless stated)

1. **The check matches the native step, by reading.** Installed `Modules/Shared.Transform.Native2027/TransformCommands.cpp:157-177` (`validate`): locked layer, then current space, then the exact class list (eight kinds, `isA() ==`, so derived classes such as MINSERT and attribute definitions fail), then Xref, then each attribute's layer. `Rules/MoveRotateSelectionRule.cs:60-81` checks in the same order with the same eight AutoCAD class names; `Commands/CopyRotateCommands.cs:121-161` feeds it the object's own class name (`ObjectId.ObjectClass.Name`), its layer, owner against `CurrentSpaceId`, the Xref test on the block definition and each attribute's layer. CE's pipe class registers as `CeCvlPipeObject` (`Drainage.NativeObjects2027/CeCvlPipeObject.cpp:53`), the name the rule looks for. Nothing it accepts would be refused by the native step for these reasons; nothing it refuses would have been moved.
2. **Reads only.** `DescribeRefusal` uses an open-close transaction and opens everything for read; no Undo step, nothing unlocked. Esc or an empty pick at "Select objects" returns before anything (line 94-95). The move itself is still one native transaction (one U).
3. **Small: the new step sits outside the command's own error catch.** `Run` (line 45) calls `TryTakeCheckedSelection` before the `try` (line 47). Any exception in it (for example opening an erased attribute in `DescribeRefusal`, line 139, with `openErased` false) now reaches AutoCAD as an unhandled error instead of the plain "[CE Transform] The move or copy could not run" line. Move the call inside the `try`.
4. **Small: grips left on after the ask route.** When nothing was gripped, CE hands its checked set to the native step as the gripped set (line 108). The native step treats it as gripped and puts it back when it finishes, after a move, a copy, or Esc (`TransformCommands.cpp:105-110`, `implied` true). So after CR the original objects stay gripped; after Esc everything picked stays gripped. The PR says "may stay gripped" but does not treat it. Today's ask route leaves nothing gripped. Clear the gripped set after the native call when CE did the asking (the Redraw flag added at lines 29-35 allows it), or list it for Tim as a default.
5. **Small, for Codex and Tim: the pipe advice.** "Leave the pipe out of the selection, or move it with AutoCAD's MOVE and ROTATE" (`MoveRotateSelectionRule.cs:74`). Leaving the pipe out and moving its pit with MR moves the pit away from the pipe ends (on 2027 nothing re-joins them). The bug's own wording suggests CDEDIT or MOVE. Suggest: "Move the pit and its pipes together with AutoCAD's MOVE, then ROTATE." Tim's call on the words.
6. **REFEDIT order and the merge with 2062.** The native step refuses REFEDIT before asking for objects (`TransformCommands.cpp:260-264`); CE now asks for objects and checks them first, then the native step refuses. Never bypassed, but the drafter picks objects for nothing. PR 2062 puts its read-only and REFEDIT check at the same spot in `Run` (directly after `if (doc == null) return;`). When both land, 2062's check must come first. The PR's merge note says "small text conflict"; the order is the point.
7. **Plain words.** Every line names the command, the object in drafting words and its layer, and ends "Nothing was changed."; no code words (`KindWords` falls back to "an object MR and CR cannot move yet"). "Unlock it" is advice to the drafter, not something CE does. Fine.
8. **Tests.** `Trust04B1334MoveRotateTests`: the rule cases are real calls; "accepted kinds match the native source" reads the .cpp text (good pin against drift); "MR checks before the native call" is a text search. `DescribeRefusal` and the hand-over have no test (they need AutoCAD); the lane's broken twin (check bypassed) fails 1 of 16, the text search. Acceptable with robot cases.
9. **No PENDING_TESTS row** for 2081 yet. The robot needs: a 2027 pipe plus two lines (refused, nothing moves, line names the pipe's layer); the two lines alone with nothing gripped ("Select objects" asked once, they move, and whether they stay gripped afterwards); gripped first; CR the same and check what is gripped afterwards; Esc at the base point; one locked-layer line; one Xref; during REFEDIT.

# What I did not check

1. No build or test run; the lane's 116 of 116 and the broken twin not re-run.
2. Whether AutoCAD accepts the hand-over (`SetImpliedSelection` then the native `acedSSGet("_I")`) inside one command: robot case.
3. Whether `AttributeCollection` can yield an erased attribute in practice (finding 3 holds either way: any exception there is unhandled).
