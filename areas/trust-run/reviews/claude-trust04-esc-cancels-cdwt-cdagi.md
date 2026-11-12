# Review: PR 2057 `claude/trust04-esc-cancels-cdwt-cdagi` (TRUST-04 queue item 8, BUG-1289: Esc cancels, not skips, in CDWT and at CDAGI's level questions)

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:12 PC clock. **Head reviewed:** `311147d8` (own commits `6ff93be3`, `eacca8ad`, `311147d8`; base `cf059dcf` confirmed). Against the BUG-1289 entry in `BUG_CARPARK.md`. Read by a helper reader; the CDWT Esc lines and the detention questions re-read by me. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. In CDWT, Esc at the callout, riser, dropper and detention questions now cancels the tank ("CDWT cancelled - nothing was placed."); in CDAGI, Esc at the start and end level questions cancels the drain. Enter still skips or takes the default, as before.
2. One thing left from before: CDWT has already added the tank, riser and dropper block definitions to the drawing when those questions are asked, so after Esc the drawing still shows as changed (nothing is drawn).
3. The tests read the source text; only the robot can press Esc for real.

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never merge or install.

---

## Findings

1. **It fixes what BUG-1289 says.**
   1. CDWT callout, riser and dropper points: Esc returns with "CDWT cancelled - nothing was placed." (`Commands\WaterTankCommand.cs` 225-229, 239-243, 245-249, read by me).
   2. The detention question, both forms: Esc cancels at the library-tank question (`WaterTankCommand.cs` 515-521) and at the typed-litres question (537-542); Enter still means the library figure or 0. The drafter sees "CDWT cancelled at the litres prompt - nothing was placed." (130-133).
   3. CDAGI start and end levels: "CDAGI cancelled - nothing was drawn." (`Commands\AgiCommand.cs` 141-147, 279-282, 318). CDPERIMETER shares this code and gets the same change.
2. **Already written before the Esc (true before this PR too).** The tank's block definition is added while its preview follows the cursor, before the callout question (`WaterTankCommand.cs` 192-197, read by me); the RISER and DROPPER definitions just before their questions (700-704). They stay after Esc: unused, purgeable, the drawing marked changed and an Undo step. "Nothing was placed" is true on screen. The "Civil active" mark waits until the tank is placed in both commands (`WaterTankCommand.cs` 51-52, `AgiCommand.cs` 76-77). CDAGI writes nothing before its final question. The robot should note whether the drawing shows as changed after Esc at the riser or dropper.
3. **The detention question is on the command-line route only,** used when the window cannot open; the normal route takes detention from the window.
4. **Extra, harmless:** the changes in `WaterTankCommand.Window.cs` 151-173 are in a function nothing calls; the robot cannot exercise them.
5. **Words:** plain.

## Does the test fail without the change, through the real code path?

It fails on `cf059dcf`, but by reading source text (`Trust04EscCancelsTests.cs`); no test presses Esc through real code (that needs AutoCAD). The edit to the existing `Bug649AgiRisingGradeTests.cs` 124 only loosens a text search; it does not weaken what that test guards.

## Does it do only what the bug needs?

Yes, plus the uncalled window-route edits (item 4).

## What I did not check

1. Built nothing, ran nothing.
2. Nothing in AutoCAD; whether AutoCAD shows the drawing as changed after Esc.
