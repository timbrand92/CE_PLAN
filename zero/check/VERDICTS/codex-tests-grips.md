# Answer: the text grips test list, codex/tests-grips at d552bae (from design\SHAPED_GRIPS.md 04b4034)

**Answer: HOLD THE LIST. Both halves hold it. First answer on this list: fix round one of two follows.** Written Fri 20 Nov 2026, about 11:05 pm. Checked on the bench only.

**Who checked.** Honest check: one Claude helper on Sonnet (D-434): `C:\CE_WORK\check\reports\grips_honest_report.md`. Adversarial pass: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\grips_adv_REPORT.md`, proofs in `grips_adv_proofs\`: a deliberately wrong build turned ALL 25 targets green, including one that drew the flow arrow pointing UPSTREAM. Counts true: 26 tests, 25 targets fail, 1 control passes; the whole solution builds; only two test files added; nothing older touched.

## 1. Reasons to hold

1. **The cover level is placed 100 mm short in each direction** (both halves): the targets take the pit WALL (300 mm from centre) as the dashed corner; the outer dashed line is 100 mm outside the wall (D-402 item 1; the block file, D-427). 300 + 400/√2 = 582.84 must be 400 + 400/√2 = 682.84. Cover-corner cycle and free-drag targets.
2. **A right marker fails, a wrong one passes** (both halves): the targets want the CE NO PLOT LAYER coloured 40; D-412 keeps it grey and puts the amber on the marker; and any three distinct points on that layer, even in a line at the origin, count as the marker. Read the moved part's own triangle, its colour, size one text height, one text height past the end.
3. **The flow arrow can be drawn backwards and pass** (adversarial): the flip target compares rotation, scale and anchor only; a west-pointing shaft replacing the eastbound office block passed. D-418 item 1: the flip puts the arrow on the other side, still pointing downstream.
4. **A slide off an oblique pipe passes:** every slide is tried on one horizontal pipe; on a straight at (0.8, 0.6) a shift of (100, 100) from (605, 860) must give (717, 944); the wrong build gave (705, 860).
5. **The connector can supply its own answers:** the adapter targets let the test connector provide the edits, the call count, the "moved by hand" answer and Undo, so a build with no real grip code passes. Drive the real grip action and read the drawing.
6. **The invert's 200 mm is measured from the wrong line** (from the wall, not the outer dashed line, D-405 item 4) and the pit circle's clearance is not checked (only its centre at 900 mm; D-400, D-406 item 5: 150 mm clear of the pit edge).
7. **Eighteen of the 25 targets need the edit doorway, the label build or the marker build** and are counted as targets, not WAITING (both halves; the D-399 precedent).
8. **Protection is tried on one cover only:** a handler that protects the cover but edits a locked or xref pipe label passes. Each protected kind on each grip (D-348).

## 2. To fix in the same round

The cover cycle asserts the two LEFT corners, which wait on Tim's picture (D-402 item 6, D-419 item 9): park those two; the bend-drop point has no sideways offset where every other slide keeps one: say which the page means ("projected onto it"); the "route unreachable" test is a scan of source text, not of the built plug-in, its commands or its ribbon: prove it on the deliverable (D-364 item 6); a correct refusal sentence fails because the word "refused" and one exact line are demanded (the page marks those words DRAFT).

## 3. Hand-worked and right

Label slide (3300, 325); label across (200 and 775); inverts (1150, 7650, 750, 7250; flips to +200); arrow slide (3150, −325) and flip spot (2500, 325); the pit number at 900 mm above, below, right, left; one Undo per drag; the refusals' wiring.

## 4. For the control room

1. **The bend drop:** does a label dragged past a bend land ON the next straight's line (offset 0), or keep its sideways offset from the pipe? The page says "projected onto it"; recommended: keep the same offset as on the straight it left.


---

# Second answer: codex/tests-grips at 73b56b8 (its last round)

**Answer: HOLD THE LIST, with a one-page open list of three items; under the control room's standing rule (STATE item 49) the list gets ONE bounded edit, read back by the check room alone, then ACCEPT THE LIST.** Written Sat 21 Nov 2026, about 1:12 am. Checked on the bench only.

**Who checked, and how they split.** Honest: one Claude helper on Sonnet: `C:\CE_WORK\check\reports\grips2_honest_REPORT.md`: ACCEPT, with eleven binding probes. Adversarial: Codex gpt-6.2-astra: `C:\CE_WORK\check\reports\grips2_adv_REPORT.md`, proofs in `grips2_adv_proofs\`: HOLD on three. The earlier backwards-arrow build now fails all 16 replay checks. Of the eight reasons of the first answer: cover corners (682.84), marker identity and colour, the downstream arrow, the oblique slide, and the counts CLOSED; the connector, the invert and circle clearance, and protection PARTLY.

## 5. The open list (the bounded edit: these three and nothing else)

1. **76 checks can never be reached by any grip build.** The 75 protection cases and the missing-handle case all call `Open`, which always throws; the fixture is private with no loading or registration path, so a correct external build cannot change the result (a separately built plug-in with the registered test command still failed all 76 at the same line). Give the list one public, documented way to connect the real built grip code (the honest half's probe 1: wiring only, and the counters must rise inside the built code, not in the host).
2. **The invert's 200 mm is measured to the wrong end:** with the downstream dashed line at x = 7600, text running from 7000 to 7400 is exactly 200 mm clear, but the check rejects it because it reads the left baseline and demands right alignment. Measure the gap to the end of the text nearest the pit, whatever its alignment (D-405 item 4).
3. **A clear refusal in the drafter's words fails:** "Handle FFFF is absent from this drawing. Nothing changed." is rejected by the missing-handle check. Test the meaning (the part named, refused, nothing changed), not one sentence.

## 6. Binding probes for the grips BUILD (D-431; from the honest half, kept on its report)

The host wiring is wiring only; a turned and an upright marker on sloping text; inverts and the arrow on a sloping pipe; a bend drop nearer the first straight and one onto a third straight; "moved by hand" in the saved record after reopen for slide, across and flip; the full clockwise cover cycle and its wrap; xref and reference-edit refusals told apart by their reason, not shared words; "unreachable" proven against LispFunction, any .lsp and the commands AutoCAD lists; another pit size with the circle radius read from PIT LABEL 2; sheets defined with figures the builder has not seen; "reads its settings from the store".


---

# Read-back of the bounded edit: codex/tests-grips at 6036bbf

**Answer: ACCEPT THE LIST.** Written Sat 21 Nov 2026, about 1:36 am, by the check room alone (the control room's standing rule, STATE item 49). The edit: one file (`TextGripAcceptanceTests.cs`), 133 lines in, 27 out; nothing else changed.

1. **Read:** the private `Open` that always threw is gone; the list now loads the grip route once from a documented public entry point the BUILT plug-in must expose (`CeCivil.GripTest.BenchConnection`, its methods listed in the file's own notes), so a correct build can reach all 76 cases by wiring alone; the invert's 200 mm is measured to the visible end of the text nearest the pit, whatever its alignment (a new control row with left, right and centred text); the missing-handle refusal is judged by meaning (the part named, why it cannot move, nothing changed), with "Handle FFFF is absent from this drawing. Nothing changed." accepted and a refusal that says nothing of why rejected.
2. **One run by the check room** (own worktree, whole solution built, 0 errors, the plug-in included): 106 cases: the 10 controls pass; 76 targets fail because today's product exposes no grip connection, which a grip build supplies; 20 skipped with their reasons (the 18 WAITING rows and the two parked left corners).
3. **What this means:** the list may go to the main line as one squashed commit. The grips BUILD owes section 6's binding probes; above all, the connection is wiring only and every counter rises inside the built grip code. Nothing about the product is accepted.
