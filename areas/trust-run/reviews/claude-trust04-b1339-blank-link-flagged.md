# Review: PR 2066 `claude/trust04-b1339-blank-link-flagged` (BUG-1339: CDCHECKCURRENT flags a pit or pipe with a blank link)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:08 PC clock (written 05:05 to 05:08). **Head reviewed:** `1ff10de2`, one own commit on `claude/rel-20261108a` = installed Civil `cf059dcf` (checked). **Against:** `BUG_CARPARK.md` BUG-1339. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. "Check current drawing" now also lists a pit or pipe that CE holds with no drawing object recorded at all; before, only a link to an object that had gone was listed.
2. It still only reads; nothing is repaired.
3. One small fix before Codex looks at the list: two such records with no number would share one entry name, so hiding one with Ignore would hide the other.

**Verdict: GO** for the robot on copies, with one small fix before Codex's look (never to merge or install).

---

## Checked against BUG-1339 (by reading the code at `1ff10de2`)

1. **Both lists use the new rule:** pipes (`Services\CurrentDrawingCheckService.cs` 439-454) and pits and tanks (461-477) call `ReadLinkProblem` (481-493): blank is a problem, a link to an object that cannot be found is a problem, a link that resolves is fine. Same heading as before; the blank case has its own sentence ("The saved pipe list has no drawing object recorded for this pipe." / "... for this item.").
2. **Read only:** the change adds list entries only; no write, no repair (unchanged "Nothing has been repaired automatically").
3. **Records that may legitimately have no drawing object:** I looked for any place CE stores a pit or pipe with a blank link on purpose and found none (the only blank-link pit CE makes is a temporary one inside CDRUNSOLVE that is never stored, `Commands\RunSolveCommand.cs` 337-342). Duplicate rows of one pipe (CE keeps the most complete, `ProjectDataService.Queries.cs` 40-60) will now show their blank twin, which is what the check is for.
4. **Tests:** the rule for blank, missing and good links, and a source guard that both lists use it and the old skip is gone.

## Small fix before Codex's look

1. **Entry names collide for blank links.** The entry name is built from the kind, the number and the drawing link (`BuildFindingId("PIT-OBJECT", pitName, pit.EntityHandle)`, 465; pipes 444; builder 739-755, blank parts left out). With the link blank, two pits with no number both become "...PIT-OBJECT-PIT", and two copies of P3 both "...PIT-OBJECT-P3". The checks list keys its Ignore on that name (`Services\Checks\IgnoredChecks.cs` 92-112, `IgnoreFindingPicker.cs` 40 drops a second row with the same key), so ignoring one hides the other. Before this change a listed item always had its link in the name. Fix: use the record's own identity (its spine key) in the name when the link is blank.

## Worth knowing

1. **Merge order:** steps 1, 5, 6 and 7 rewrite large parts of this same file (about 260 to 310 changed lines on their branches); expect a conflict, not a behaviour clash. Whether step 1's opening-line count reads these entries was not checked.
2. "item" for a pit or tank is the existing wording ("the saved item list"); for Codex.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
3. Whether the opening line or step 8's list count these entries.
