# Re-review: PR 2070 `claude/trust-b1363-support-size-unknown` (BUG-1363, a schedule size the support block cannot show)

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:20 PC clock. Read only. **Head reviewed:** `db23f026` (commits `de217ba7` and `db23f026` since `93d4733f`, the head of the first review `reviews\claude-trust-b1363-support-size-unknown.md`; still on the installed Structural `8de95c34`). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The screen no longer names a size the support symbol does not show: before placing, the line says only what the schedule says; after placing, it says what the symbol actually shows, or that the symbol has no state for the schedule's size and was drawn at CE's own size.
2. No line tells the drafter to change or remove the member schedule row any more; each says "The schedule has not been changed."
3. The stop-and-place-nothing choice now has a tick box on the Structural Settings window (Supports), still off by default and still yours to decide.

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## Earlier items, one by one

1. **False "shown as" line: FIXED.** The line before placing is now "[CE] DS1: the schedule says '...'." (`Commands\SupportBlockCommands.cs` 255-256, `Services\SupportSizeWording.cs`). After the support is in, the line names the state the symbol took: the exact or nearest state (`SetDynamicVisibility` records it, 1501-1504) or CE's own size when the fallback was used (1520-1525). A near match such as a schedule "100 x 100 x 4 SHS" now reads "the support symbol shows '100 SHS'".
2. **Advice that edits the engineering: FIXED.** Both lines talk about the symbol and end "The schedule has not been changed."; no list of steel sizes; a test fails if any of six advice phrases comes back.
3. **Switch not on the Settings page: FIXED.** A tick box "Stop when the schedule gives a size the support symbol cannot show (off = draw CE's own size and say so)" on the Supports tab, loaded and saved with the setting (`UI\Dialogs\CeSettingsDialog.xaml` 338-340, `.xaml.cs` 137 and 358), and named in the settings recovery list.
4. **Small items: FIXED.** The line now prints only after the rotation step, so a cancelled rotation leaves no false line (384-386); the settings read has its null guard (328).

## New, small

1. **One quiet case left:** with the switch off, if neither the schedule's size nor CE's own size is a state the block offers (an old or altered block definition), the block is left at its own default state and only "the schedule says ..." is printed, with no line saying what it shows (1535-1540 set "not offered" but no notice is made for it with the switch off). Rare; worth one line.
2. Every schedule-driven placement now prints two lines (what the schedule says, what the symbol shows), the second without the "[CE]" mark the first has. For Codex's look.

## Tests

Wording, the setting and the tick box are tested directly; the order of steps in the command is a text search; `SetDynamicVisibility` never runs. As before.

## What I did not check

1. Built nothing and ran no test.
2. Nothing in AutoCAD; the tick box not seen.
3. The support's text label in the unshowable case, and SDS1 and STS1 (as in the first review).
4. No client name, street, suburb or job number in the diff (checked).
