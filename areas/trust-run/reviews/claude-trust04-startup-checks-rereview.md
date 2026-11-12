# Re-review: PR 2062 `claude/trust04-startup-checks` (BUG-1286, the shared start-up check on eight tools)

**Reviewer:** lane trust-review (twelfth run), Fri 13 Nov 2026, 06:20 PC clock. Read only. **Head reviewed:** `620fe976` (one new commit since `da1a6e49`, the head of the first review `reviews\claude-trust04-startup-checks.md`; still on the installed Civil `cf059dcf`). **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. Move and Rotate (MR) and Copy and Rotate (CR) now get only the two protections every CE tool must respect: a read-only drawing and an open reference edit (REFEDIT).
2. They no longer ask "Is this a Civil drainage drawing?", no longer refuse a Structural drawing, no longer refuse a layout tab, and never tag a drawing. That matches your 7 Nov decision that some CE tools stay useful on every drawing.
3. The six Civil tools keep the full Civil start-up check, unchanged.

**Verdict: GO** for the robot on copies. GO means fit for testing on copies, never to merge or install.

---

## Earlier item, one by one

1. **MR and CR must stay usable on every drawing: FIXED.** The shared check is split into two parts from one place (design rule 1): `ProtectionChecks` (read-only, then REFEDIT) and `ModelSpaceAndDisciplineChecks` (UCS note, Paper Space, Civil's drawing-type gate) (`Services\DrawingSafetyService.cs`). The Civil check runs both in the same order as before; the new `ProtectionPreFlight` runs only the first. MR and CR call `ProtectionPreFlight` on AutoCAD 2027 (`Commands\CopyRotateCommands.cs` 40) and 2022 to 2026 (125, 141). Nothing else in MR or CR calls the drawing-type gate, a tag or the Civil editing watch (checked by search of the file). The older version's own REFEDIT refusal (161, 210) stays.

## New problems

None found.

## Tests

The new cases check by reading the code that MR and CR call the protections with their own name before their first work and never the Civil check, and that the protections contain only the read-only and REFEDIT checks with no drawing-type gate and no Paper Space test (`Trust04StartUpChecksTests.cs`). They fail on `da1a6e49` (MR and CR called the Civil check there). Still no case that runs MR on a made-up Structural or untagged drawing (needs AutoCAD).

## What I did not check

1. Built nothing and ran no test.
2. Nothing in AutoCAD; the Structural suite's own MR and CR (if both suites are loaded) as in the first review.
3. No client name, street, suburb or job number in the diff (checked).
