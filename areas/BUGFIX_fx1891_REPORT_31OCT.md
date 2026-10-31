# BUGFIX report: PR #1891 (BUG-1246) locked label layer, 31 Oct 2026

## FOR TIM

1. **What happens now when the label's layer is locked.** You copy downpipe DP2 (CR, COPY and so on). If the layer the DP2 label sits on (normally GUIDELINES) is locked, the copy still becomes DP3, but CE draws no label for it and prints one line: "[CE] The label for DP3 was not drawn because layer GUIDELINES is locked. CE has not changed the layer; unlock it and the label can be added." CE never unlocks the layer and never puts text on it.
2. **The tag on a locked layer.** The tag value DP3 is still given (it is stored on the downpipe itself, not on the label). Only the label text is skipped. If two copies are made together, it is still one line, naming the layer once.
3. **Switch OFF.** `linking.copiedDownpipeGetsOwnTag` OFF runs none of this: the copy stays as AutoCAD copied it, exactly the old behaviour. The lock check lives only inside the switch-ON route.
4. **What I tested.** Built and unit-tested only: 10 of 10 tests in `Bug1246CopiedDownpipeOwnTagTests` pass (net10.0-windows). Three are new: the locked-layer line (names the layer, one line, tag still given), no line when the label was drawn, and a guard that the layer lock is read before the label is drawn and nothing is unlocked. On the old PR head these cannot pass (the new line and check did not exist).
5. **What I did NOT test.** Nothing in real AutoCAD. The robot needs a locked-GUIDELINES case (downpipe layer open, label layer locked): expect DP3, no new label, the one line, layer still locked. The net48 and net8 test runs were not done; the other two review items (copied label selected too, U then U again) are untouched.

---
Technical: new head 4f21fc9d on `fb/bug1246-copied-downpipe-new-tag`, normal commit, no force-push. Files: `LinkService.CopiedSourceOwnTag.cs` (reads `LayerTableRecord.IsLocked` of the label layer before `EnsureTagLabel`), `CopiedSourceOwnTagRule.cs` (`LockedLabelLayerLine`), `LinkService.Utilities.cs` (adds the line), tests, `REGRESSION_LOG.md` (new entry at the top). C: was 29.4 GB (under 30) after my own build; I used the finished build and ran the tests with no further build.
