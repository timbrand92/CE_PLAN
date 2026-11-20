# Answer: the text grips test list, codex/tests-grips at d552bae (from design\SHAPED_GRIPS.md 04b4034)

**Answer: HOLD THE LIST. Both halves hold it. First answer on this list: fix round one of two follows.** Written Sat 21 Nov 2026, about 12:05 am. Checked on the bench only.

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
