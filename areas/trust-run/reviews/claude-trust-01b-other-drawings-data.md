# Review: PR 2078 `claude/trust-01b-other-drawings-data` (BUG-1456 follow-up: a read-only line when a drawing opens that already holds another job's CE data)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 06:58 PC clock (written 06:42 to 06:58). **Head reviewed:** `5bde761b` (one commit on the opening line's head `31f426ab`, PR 2041; base of the PR is `claude/trust-01-open-line`, confirmed). **Against:** the brief's six tests, `EVIDENCE_CROSS_DRAWING.md` parts 1 and 2, and the PR's own claims. **Four states:** Built yes (lane: net48 and net10.0-windows, 0 errors). Tested unit only (lane: 22,275 ran, 0 failed; 74 opening-line and new tests). Installed no. Accepted no.

---

## FOR TIM

1. When a drawing that was mixed up by the Help or Settings fault (BUG-1456) is opened and left alone, CE will now say so in one line ("this drawing holds CE data that looks like it belongs to another drawing. Nothing has been changed.") and change nothing.
2. A revision made by Save As, a copied job folder, a renamed or moved file, or a drawing started from a template keeps the usual line, because its pits and pipes are all still there.
3. It cannot find a mixed-up drawing once any CE tool has been used in it and it has been saved: the clue it uses (the other drawing's name inside CE's data) is then overwritten.

**Verdict: GO** for the robot on copies. Two small fixes listed, neither stops the robot.

---

## The brief's tests, one by one

1. **Writes nothing: confirmed by reading.** The new routine `AddOtherDrawingsDataObservation` (`Modules\Drainage\Services\CurrentDrawingCheckService.cs` 674-729) only counts lists and adds one item to the in-memory check list. The handles it counts are gathered in the opening check's existing walk, which opens everything for read inside an open-close transaction (255-261, 300-301), so no Undo step, no lock, no drawing write. CE's stored record is read as text through `TryReadProjectData` (852-896), never through CE's record in memory, so nothing attaches or rewrites it. The changed counter is read before and after by the opening line as before. The compiled-plugin guard now walks into the new routine and a broken twin that writes there is caught (`Drainage.Tests\Services\DrawingStateLineOpenTests.cs`, both changed lines). The two new Settings keys are read only.
2. **Fires on the drawing the evidence describes: yes, by reading plus a check on the robot's own dumps.** Both conditions: the stored path is compared with the open drawing's name (`Rules\OtherDrawingsDataRule.cs` 28-35), and more than 50 percent of recorded pits and pipes must have no object of that kind here (41-47, 50-51). I compared the evidence lane's record and drawing dumps (`C:\CE_WORK\scratch\trustprobe\reads\X2_*`) with the same rule (a pit is here when its number is a block in model space; a pipe when its number is a polyline or CE pipe object):
   1. Standard drawing's record inside the older job's drawing (the seen mix-up): 0 of 51 recorded items drawn there, **100 percent missing: fires.**
   2. The other order (C3): 0 of 45 drawn, **100 percent: fires.**
   3. Each drawing's own record (the control): every recorded pit and pipe found (9 pits and 42 pipes; 2 pits and 43 pipes): **0 percent: quiet.**
   So the two cases are 100 against 0, far from the 50 percent figure. (Counts are the items carrying an object number, as my own reading of the dump files found them; the evidence file's 11 pits and 49 pipes include items without one, which the rule leaves out.) The stored path in the saved mixed-up copy names the other drawing (evidence part 2, item 6). The opening line runs after CE's two opening jobs (`DrawingStateLineOnOpenService.cs` 15, 110, 137), and the pipe conversion on open reads the record without changing it (`NativeObjects\PipeObjectUpgradeService.cs` 158), which matches the evidence: the reopened mixed-up copy still named the other drawing after opening. Not run in AutoCAD.
3. **Does not fire on a Save As revision, a copied job folder, a renamed file, a moved folder, another drive letter or network path, or a drawing started from a template: yes, by reading.** In all of these AutoCAD keeps every object's number, so the recorded pits and pipes are found and condition 2 fails; the stored name alone never fires (unit test `ARevisionMadeBySaveAs_...`, and the faulty "name alone" version is caught). A new drawing from a template is named "Drawing1.dwg" (condition 1 true), but the template's objects keep their numbers too. One thing worth knowing: on a colleague's PC the job folder sits under their own user folder, so condition 1 is true on almost every drawing they open until a CE tool rewrites the name. The line then rests on condition 2 alone, which the dumps above separate at 0 against 100 percent. On a colleague's PC the pipe conversion is held, so older pipes stay plain polylines and count only when on a pipe layer; the older job above has 5 of its 45 recorded pipes on a drainage hatch layer, which would count as missing there: 11 percent, still quiet.
4. **Wording: plain, says nothing has been changed, does not tell the drafter to run a repair command.** It tells them NOT to run CDSYNC. Small suggestion for Codex's look below.
5. **One walk with the opening line: yes.** The handles come from the same loop and the result sits in the same observation that the opening line's counts come from (`CurrentDrawingCheckService.cs` 300-309, 381-388, 543-559), and the new line replaces the count line when it applies (`Rules\DrawingStateLineRule.cs` 69), so the command line can never show both. But see small fix 1: inside Check Current Drawing the two use different tests of "is this pit here".

## Small fixes

1. **Two different counts in one Check Current Drawing list.** The new item says "N of its M recorded pits and pipes are not drawn here", where "here" means a block or pipe line of that number (674-729). The older items just beneath it, "Pit X is not linked to a visible drawing object", count a pit as linked when its number belongs to ANY live object in the drawing, of any kind (`CanResolveHandle`, 961-970, used at 452 and 490). In a mixed-up drawing the other job's numbers often belong to unrelated objects here, so the list can say "51 of 51 not drawn here" above only a few "not linked" items. Fix: say what "drawn here" means in the item ("not drawn here as a pit block or pipe line"), or count the older items the same way when this item is shown.
2. **Robot cases (`PENDING_TESTS.md`, BUG-1456 follow-up):** the robot already has two real mixed-up drawings saved by the evidence lane (`CLDTP_SAVED_CONTAM.dwg`, `CLDTP_SAVED_CONTAM2.dwg` in the TRUST_VERIFY folder) and their untouched twin; use them first instead of making new ones. Add: the same file opened from a different folder path (copy the folder elsewhere and open it there), a file renamed in Explorer, and a new drawing started from each office template (all quiet).

## Worth knowing

1. **The known blind spot is real and permanent** (the PR says so): the first CE tool that attaches the record and saves rewrites the stored name to this drawing, and the line goes quiet for good while the data is still the other job's. With the cure (PR 2073) Help and Settings no longer write, but every other CE tool still refreshes the name when it saves. Condition 2 alone would still see it (100 percent missing), at the cost of firing on an ordinary drawing whose network was erased without CE; that trade is for the controller.
2. **Wording, for Codex's look:** "ask before fixing" does not say whom to ask, and the line does not say why it matters. The Check Current Drawing item does ("schedules and calculations in this drawing would read the other job's pits and pipes"). The worst seen effect is a Pit Schedule for council listing the other job's pits (evidence part 2, item 3). DRAFT wording, Tim's to confirm.
3. **On the installed build the pipe conversion on open acts on the wrong job's list** in a mixed-up drawing (it tries the other job's pipe numbers in this drawing; the evidence saw "1 left as drawn"). Not this PR's doing; it reads only.

## What I did not check

1. Nothing run: no build, no tests, no AutoCAD, no core console.
2. That AutoCAD keeps object numbers through every route named (Save As, copy, template, a different network path): taken as known AutoCAD behaviour, not proven here.
3. The dump check used my own reading of the dump files, not the plugin's code; pipe layers were not checked against the Settings list for the polylines (all recorded pipes in both dumps were CE pipe objects or polylines on stormwater pipe layers).
4. Drawings above the opening check's size limit (not walked, silent; as in step 1).
5. The test file beyond the cases quoted (read names and the cases that matter).
