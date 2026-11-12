# Review: PR 2070 `claude/trust-b1363-support-size-unknown` (BUG-1363: a schedule size the support block cannot show is drawn as another size)

**Reviewer:** lane trust-review (eleventh run), Fri 13 Nov 2026, 05:40 PC clock. Read only. **Head reviewed:** `93d4733f`, one own commit on the installed Structural `8de95c34` (ancestor, checked). **Read against:** the BUG-1363 carpark entry (card TRUST-S3); the installed support commands at `C:\CE_WORK\scratch\audit_struc` (`Commands\SupportBlockCommands.cs`, the Structural Settings window). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. With the new switch off (the default), DS1, TS1, C1, C2 and DS still draw their own size when the schedule names one the block cannot show, but now add a line saying so. The old line that names the schedule size as "shown as" is still printed first, so the screen still names a size the block does not show.
2. Both new lines tell the drafter to change the member schedule's size "to a size the block has" (listing steel sizes such as 89 SHS even for a timber stud pack) or to remove the row. That changes the engineering to suit a drawing symbol; it must not be the advice.
3. The stop-and-place-nothing choice is behind a switch that is clearly marked yours to decide, but the change log says it is on the Settings page and it is not; you could only try it by editing a settings file.

**Verdict: FIX FIRST** (three items). GO would mean fit for testing on copies, never to merge or install.

---

## FIX FIRST

1. **The false "shown as" line is still there** (`Commands\SupportBlockCommands.cs` 252-257, unchanged by this PR, the very line the bug names). Before the point is picked it prints "[CE] DS1: size '2 No 90 x 45 F17 KDHW' from the schedule, shown as '<the schedule size, tidied>'". Then:
   1. switch OFF: after placing, the new line says the block "was drawn at '90 x 90' instead". Two lines that disagree, the first naming a size the block does not show.
   2. switch ON: the screen says "shown as ...", then "nothing was placed".
   3. a near match (for example a schedule "100 x 100 x 4 SHS" placed as the block's "100 SHS") also names the schedule string, not the state the block took.
   The change log says this on purpose ("The old ... line is left as it was"). Fix: before placing say only what the schedule says; after placing, name the state the block actually shows (the resolved value is already known inside `SetDynamicVisibility`, branch 1467-1531).
2. **The advice changes the engineering, not the drawing.** `Services\SupportSizeWording.cs` (new): the stop line says "change that row in the schedule to a size the block has ('89 SHS', '100 SHS', ...) ... or remove the row so CE uses its own size"; the default line, shown by default for every unshowable size, says "change that row in the schedule to one the block has". The member schedule is the engineer's statement of the member; a drafter following this could turn a timber stud pack into an SHS or delete the row. The words must leave the schedule alone and talk about the symbol, for example "The support symbol has no state for '2 No 90 x 45 F17 KDHW'; it was drawn at '90 x 90'. The schedule is unchanged." What the drafter should do next is Tim's to decide (see "For Tim"); until then say nothing that edits the schedule.
3. **The switch is not on the Settings page.** The change log says "Settings, Supports, 'stop when the schedule size cannot be shown'", but no row was added: the Structural Settings window wires its Supports rows by hand and has only the text-side tick (`UI\Dialogs\CeSettingsDialog.xaml.cs` 136, 356); the new value appears only in `Models\UserSettings.cs` 1008-1016 and the command. The robot steps edit the JSON file instead. Either add the row (R-00, Settings-first) or correct the words so nobody looks for it.

## Sound

1. **Switch ON places nothing:** no fallback is passed (branch 332), the transaction is aborted before commit and the line written (334-339); the undo group still ends in the existing `finally` (installed 413-418). A block definition imported for an empty drawing's C2 is outside that transaction (`SupportBlockDefinitionUpgradeService.ImportApprovedDefinitionForEmptyDrawing`, installed 1341-1344) and stays; nothing visible, drawing marked changed. Small.
2. **Switch OFF draws exactly as today** (same fallback, same commit) plus one line.
3. **The block is still only ever set to a state it offers** (`ResolveAllowedVisibility`, installed 1503-1555); the report object only records what happened.
4. **Clearly Tim's choice:** the PR title, the change log ("Engineering judgement for Tim"), the setting's own note and the PR say so; OFF is the default and is not written to the settings file while off.
5. Nothing unlocked, thawed or bypassed; the locked support layer check is unchanged (installed 223-232). One U: unchanged.

## Tests

Do they fail without the change through the real code path? Partly. The two wording functions and the setting are tested directly (they do not exist on the installed build). Everything about the command (no fallback with the switch on, abort before commit, the notice) is a text search of `SupportBlockCommands.cs` (`Structural.Tests\Commands\Bug1363SupportSizeTests.cs` 70-115); `SetDynamicVisibility` never runs. The tests also pin the advice that FIX FIRST 2 asks to remove.

## Small

1. With the switch off and the rotation then cancelled, "the block was drawn at '90 x 90' instead" has already printed before the support is rolled back.
2. `SettingsService.Current.Supports` is read without the null guard the rest of the file uses (`TryGetConfig`, installed 110); an empty settings object would end in "CE could not place the support". Unlikely.

## For Tim (DRAFT, engineering judgement)

1. DS1's own size, 90 x 90, is the outline of a "2 No 90 x 45" stud pack and TS1's 135 x 90 that of a "3 No 45 x 90" pack (installed 67-68), so for the commonest timber rows today's fallback draws the right outline; with the switch on those would all stop. A thinner pack (for example 2 No 90 x 35) would still be drawn 90 x 90.
2. The bug's own suggestion, leave the size Unknown and let the drafter pick from the block's sizes (as C2 already asks, `TryPromptC2Visibility`), is not offered. The question for Tim has three answers, not two: draw CE's own size and say so; stop; or ask the drafter to pick.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD.
3. What the support's text label (DS1, TS1, C1, C2) prints in the unshowable case (`HandleSupportTextPlacement`), and the switch commands (SDS1, STS1), which do not read the schedule.
4. No client name, street, suburb or job number in the diff (checked).
