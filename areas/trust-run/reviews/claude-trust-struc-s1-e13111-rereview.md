# Re-review: PR 2054 `claude/trust-struc-s1-e13111` (Structural step S1: the tab cut down to the core, roof down, switch OFF)

**Reviewer:** lane trust-review (ninth run), 13 Nov 2026 04:14 PC clock. **Head reviewed:** `10a50084` (commits `a4739ae9` and `10a50084` since `6abdc171`; base `8de95c34`). Against `reviews\claude-trust-struc-s1-e13111.md`. Read by a helper reader; the six "Known fault" lines re-read by me. **Four states:** Built yes (lane). Tested unit only (lane). Installed no. Accepted no.

---

## FOR TIM

1. The "Known fault" lines in the tooltips are now in drafting words, with no bug numbers or card names.
2. Every button keeps today's words except the four beam types, as the card asks.
3. With the switch OFF the Structural tab is exactly today's.

**Verdict: GO** for the robot's layout checks and Codex's look on copies. GO means fit for testing on copies, never merge or install.

---

## Earlier FIX FIRST items

1. **Bug numbers, "card S2/S3" and "installed code" in the fault lines: FIXED.** All six now read as drafting words (`Modules\Structural\Services\CeStrucCoreRibbonList.cs` 33, 51, 55, 62, 80, 83, read by me). The test now checks every fault line for "BUG-", "card", "S2/S3/S4", "code" and "installed" (`RibbonCommandHubServiceTests.CoreTab.cs` 152-184). The hidden buttons' planning notes still carry "card S4" and bug numbers, but only a test reads them.
2. **20 of 27 buttons getting new words: FIXED.** Shown buttons pass no label, so they keep today's words, which match their own tooltips; the exceptions are the four beam types (lines 40-44). The test compares the other 23 with the command list (`CoreTab.cs` 187-214).
3. **The failing compiled-proof tests: named in full; run on 8de95c34 by the lane.** The PR now names both test families and reports eight cases failing the same way on this branch and on `8de95c34`. The cases exist in source (`SbeamEditAutoCadEvidenceReaderCompiledExactProof.cs` 358-360, `...CompiledR11Proof.cs` 2337-2340). Not re-run by me.
4. **The pin and `includeExpert: true`: FIXED.** The fragment is now checked (`RibbonCommandHubServiceTests.TodaysTab.cs` 370) and is in the shipping builder (`RibbonCommandHubService.cs` 191). The pin still reads the test's own copy of today's builder, which the last review accepted.
5. **Switch OFF equals today's tab: unchanged.** Since `6abdc171` only the list file, two test files and the change log changed; the builder, the switch reader and the core-tab builder are untouched.

## Worth an engineer's glance

1. The double stud's fault line now says "when a member schedule is in the drawing the size it reads may be wrong" (line 51). That is sharper than the old line; it matches fault 3 in `STRUCTURAL_NEW_FAULTS_TO_FILE.md` (a schedule size the block cannot show is drawn as the default size), which the item-5 review of this run confirms in code.

## What I did not check

1. Built nothing, ran nothing; the S1 tests and the eight failing cases are the lane's.
2. Nothing in AutoCAD; the tab's look.
