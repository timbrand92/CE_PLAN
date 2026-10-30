# B-007b: raingarden plan label is plain RG (report, 30 Oct 2026)

## FOR TIM

1. **PR:** #1870 (DRAFT), branch fb/raingarden-label-plain-rg, against claude/rel-20261030a. Built and unit-tested only. Nobody has opened it in AutoCAD.
2. **What you will see:** CDRG draws the plan label as plain RG, with no number, like OF and DP. The tag and the record still read RG1, RG2 (numbered per drawing). Before this, #1845 drew RG1 on the plan, which broke your item 77.
3. **Switch:** linking.raingardenLabelWithoutNumber, ships ON. Set to false and the plan label reads RG1 again.
4. **My mistakes:** none new. An earlier stopped attempt had already made the edits in the worktree; I reused them, committed them and merged the newer train. I first added the switch to the C-77 finalizer's switch list, which broke its "17 switches" count test, so I removed that line again; my own tests pin the default instead.
5. **Not proven:** nothing was drawn in AutoCAD. The locked-layer line is pinned by a source-text test, not by a locked layer in a drawing.
6. **Robot proof for CE 02 (case C31, extended):** fresh drawing, type CDRG and place a raingarden; check the text on layer GUIDELINES at the outline centre reads RG, and the recorded name/tag reads RG1. A second raingarden: label RG, tag RG2. Switch-off control C31_off: type the setting linking.raingardenLabelWithoutNumber = false before launch, repeat; the plan text must read RG1.

---

## Technical detail

1. **Entry point:** Modules/Drainage/Rules/RaingardenLabelRule.cs `LabelText(switchOn, name, withoutNumber)` strips trailing digits (RG1, RG12 give RG; digits-only gives RG). New `WithoutNumberIsOn`. Caller: Services/SourcePlacementService.cs `AppendRaingardenLabel`. Warnings and the locked-layer/failed lines still use the recorded name.
2. **DP/OF:** SourceTagService does not reference the rule (asserted by a test); unchanged.
3. **Setting:** Models/UserSettings.cs `LinkingSettings.RaingardenLabelWithoutNumber`, "Default: on."
4. **Tests:** RaingardenLabelTests updated and extended (RG1/RG12/RG/digits-only, record stays RG1, switch OFF gives RG1, default ON through DeserializeSettings and DeserializeSettingsTolerant, typed false only turns it off). Focused net10: 220 passed. Full Civil net10 Release: 21,516 total, 21,484 passed, 32 skipped, 0 failed. net48 compile: 0 errors.
5. **Not done:** no Settings-page row (raingardenTagLabel has none either). CE_SHARED unchanged. REGRESSION_LOG.md entry added.
