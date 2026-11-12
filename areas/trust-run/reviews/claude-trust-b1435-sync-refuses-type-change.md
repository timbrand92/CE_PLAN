# Review: PR 2072 `claude/trust-b1435-sync-refuses-type-change` (BUG-1435: typing B over A in the bracing table changes the type text only)

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:19 PC clock. Read only. **Head reviewed:** `b3986ade`, one own commit stacked on PR 2071's head `a8ef1ec9` (which is cut from the installed Structural `8de95c34`; checked). **Read against:** the BUG-1435 carpark entry and the installed code at `C:\CE_WORK\scratch\audit_struc`. **Four states:** Built yes (lane). Tested unit only (lane, 543 schedule and bracing tests). Installed no. Accepted no.

---

## FOR TIM

1. Typing B over an A row in the bracing table and running STRSCHEDSYNC no longer leaves the table saying B while the brace plots as A: the type change is refused, the brace is left exactly as it is, and one line says to use ABS and then refresh the table.
2. Refusing (rather than switching the brace from the table) is marked as a DRAFT default for you; it is the safe choice and copies nothing of ABS into a second place.
3. This PR sits on top of PR 2071, so testing it tests 2071 too; 2071's two FIX FIRST items carry over.

**Verdict: GO** for its own change (the robot on copies, together with 2071 once 2071's items are fixed). GO means fit for testing on copies, never to merge or install.

---

## Sound (by reading)

1. **Nothing is written for a type edit:** the sync no longer calls the type writer at all (`Services\ScheduleService.cs` 750-752 print the line only); length and angle edits on the same row are still written through 2071's plan. No layer, colour or block is touched, so table and brace cannot disagree because of the sync.
2. **The words are plain:** "Bracing table row N: the type was changed from A to B in the table, but a brace's type cannot be changed from the table (the brace would stay on the A layer and plot as A). The brace was not changed. Use ABS to switch it, then refresh the table." (`Services\BracingTableSyncPlan.cs` 24-27). ABS is a real typed command on the installed build (`Commands\BracingCommands.cs` 369).
3. **Tim's choice listed, not built in as fact:** the PR, the change log and the carpark note say DRAFT default, engineering judgement for Tim.
4. **No total, length or angle changed;** nothing unlocked; one transaction, one U, as before.

## Small (before Codex reads the line)

1. **Which row is "row N"?** The line uses the table's row index minus one (`ScheduleService.cs` 752), so the first brace is "row 1". AutoCAD's own table editing counts the title and the heading too, so a drafter clicking that brace sees it as row 3. Name the brace another way (for example "the 3rd brace listed in the bracing table") or use AutoCAD's numbering.
2. **"would stay on the A layer" is assumed from the type text,** not read from the brace. A brace sitting on some other layer would be described wrongly; the reader already has the brace's real layer (`ProjectDataService.ReadBracing` returns `Layer`).
3. The line repeats on every later sync until the table is refreshed (the typed B stays in the cell). Harmless, and the line says to refresh.

## Tests

Do they fail without the change through the real code path? Partly, as for 2071: the decision and the line are real functions; that the sync no longer writes the type and the refusal branch writes nothing are text searches of `ScheduleService.cs` (`Bug1435BracingTypeEditTests.cs` 37-52). `SyncBracingTable` never runs.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
3. Lower-case type text ("a" over "A" is refused as a change; harmless).
4. No client name, street, suburb or job number in the diff (checked).
