# Independent Structural audit — 22 October 2026, Melbourne

1. **ANSWER FIRST — eight findings: three HIGH, four MEDIUM, one LOW.** The biggest risks are changing existing dashed lines elsewhere in a drawing, drawing a member 1,000 times too large in a metre drawing, and changing correct hatch spacing when the drawing scale settings disagree. These need attention before relying on the affected cases for issued drawings.

2. **What is sound on this read.** The corrected Z outline and its window picture share the same corners. At ordinary millimetre model-space scales, the new hatch and EBT height calculations agree with their stated rules. Cancelling CEMEMBER before placement reaches no member-writing code.

3. **What this proves.** Findings below are verified by reading the specified source, not by watching AutoCAD. Native prompt behaviour, complete Undo/Redo and appearance remain unproven. No build, test, AutoCAD session, installation, source edit or sub-agent was used. The reproduction steps are for a later AI tester on synthetic copies; Tim is not being asked to test.

---

1. **Audit boundary and evidence.** Read RULES.md, ROUTER.md, CE_PLAN's start/map/Structural area, REVIEWLANE_LOG entries 1550–1557 and 1565–1593, and both S-40/S-41 finalizer reports before tracing source. Earlier findings are not counted again. The specific brief overrides its appended worktree/build/PR instructions. Only this report is authored; CE_PLAN fetch/merge/commit/push is the expressly authorised exception.

2. **Pinned comparison.** After `git fetch origin` in `C:\Lisp Files\CE_ACAD_PLUGIN`, compared `origin/claude/rel-20261017s` (`9a8e5d4e33cf565e5aa2f73e8addfa554cc560e5`, S-38) with `origin/claude/rel-20261022s2` (`2c9a96942a024888a5ab520600f2d5025de83036`, S-41, 1.0.121). Ran the requested Structural diff and first-parent log. The scoped diff is 25 files, 962 additions, 131 removals. Read referenced DesignCore routines at the same commit to trace the new command and record engine; no checkout was made. All file:line references below belong to the S-41 commit, not the main checkout.

3. **Reading the findings.** HIGH means another drawing item can change or geometry is materially wrong; MEDIUM means a supported drafting context gives a wrong result or ignores a setting; LOW means misleading recovery guidance. “Verified-by-reading” establishes the code path and arithmetic only. “Suspected” explicitly marks a native behaviour or drafting expectation that needs the stated probe.

## Numbered findings

1. **F1 — HIGH — standard-name hidden layers still lose the office's linetype. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/CeMemberLineWriter.cs:86`, `:92`; `Modules/Structural/Services/StructuralDetailService.cs:1903`, `:1917`, `:2017`.

   **Plain words and failure scenario:** The S-41 fix protects an existing renamed layer such as S-HID, but not an existing layer named 18HIDDEN or 9HIDDEN2. CEMEMBER routes those names straight to the shared helper, which overwrites their linetype. A previously issued detail using an office DASHED definition can change when an unrelated new member is placed. The layer's colour and lineweight are not overwritten on this path. This is the remaining standard-name case, not a repeat of the renamed-layer defect fixed in 871ad971.

   **DETERMINISTIC TEST — fixture:** Synthetic millimetre drawing, World UCS, DIMSCALE 50, LTSCALE 500; unlocked 18HIDDEN with colour 3, DASHED linetype, 0.35 mm lineweight, and an existing ByLayer line on it. Preload HIDDEN too, to remove file-loading uncertainty.

   **Typed steps:** `CEMEMBER`, `SI`, `380PFC`, `Right`, `Centreline`, `None`, `0,0`, `3000,0`, Esc. Read 18HIDDEN in Layer Properties and the old line. Repeat independently with 9HIDDEN2 set to DASHED and `CEMEMBER`, `SE`, `310UB32`, `Beyond`, `Centre`, `0,0`, Esc.

   **Assertion:** Both existing layer definitions must remain byte-for-byte equivalent in their relevant properties, and old lines must retain their appearance. Source predicts HIDDEN/HIDDEN2 replaces DASHED. Repeat with the layer locked: no new member, no layer change. Fix direction: check existence before either the standard-name or office-name creation branch.

2. **F2 — HIGH — CEMEMBER does not convert catalogue millimetres in a metre drawing. Verified-by-reading.**

   **File:line:** `Modules/Structural/Commands/CeMemberCommands.cs:79`, `:128`, `:191`; `Modules/Structural/Services/CeMemberSectionWriter.cs:102`, `:116`; `Modules/Structural/Services/CeMemberLineWriter.cs:123`; `Modules/Structural.DesignCore/SteelSections/CeMemberCatalogue.cs:61`.

   **Plain words and failure scenario:** The new command uses millimetre section dimensions as drawing units in both elevations and sections. It never reads drawing units or applies a conversion. The packaged 310UB32 is 298 mm deep and 149 mm wide; in a metre drawing its section becomes 298 m by 149 m. Picked member length is already in drawing units, so length and section size disagree. Break overshoot/kink have the same missing conversion.

   **DETERMINISTIC TEST — fixture:** Two synthetic drawings, INSUNITS 4 and 6 respectively, DIMSCALE 50/LTSCALE 500, World UCS, default CeMember values. The catalogue row is `Modules/Structural/Assets/Config/section-catalogue.json:205`.

   **Typed steps:** In each, `CEMEMBER`, `SE`, `310UB32`, `Beyond`, `BottomLeft`, `0,0`, Esc; measure extents. Then `CEMEMBER`, `SI`, `310UB32`, `Centreline`, `Both`; pick `0,1000` and `3000,1000` in the mm copy, `0,1` and `3,1` in the m copy; Esc.

   **Assertion:** Section width/depth must be 149/298 mm or 0.149/0.298 m; the side member must be 3 m long and 0.298 m deep in both. Break overshoot/kink must be 75/100 mm or 0.075/0.100 m. Source predicts 149/298 and 75/100 drawing units in both. Converting only the picked points would not fix this: section dimensions, offsets, radii and break sizes all need consistent units.

3. **F3 — MEDIUM — CEMEMBER discards the picked plane; section orientation is fixed to World axes. Verified-by-reading; intended orientation in a rotated plan remains suspected.**

   **File:line:** `Modules/Structural/Commands/CeMemberCommands.cs:125`, `:131`, `:190`; `Modules/Structural/Services/CeMemberLineWriter.cs:124`; `Modules/Structural/Services/CeMemberSectionWriter.cs:39`, `:43`.

   **Plain words and failure scenario:** The command converts picks to World coordinates, then keeps only X and Y and writes Z = 0. A member picked on an elevated or tilted UCS can land on the wrong plane, shorten in projection, or be refused as two coincident points. For a section it also discards the UCS axes: only the insertion location is converted. The earlier review's “rotated UCS” assurance therefore covers at most planar positioning, not arbitrary UCS placement.

   **DETERMINISTIC TEST — fixture:** Synthetic mm drawing, DIMSCALE 50/LTSCALE 500, OSNAP off, dynamic input off. Set `UCS`, `World`, then `UCS`, `Origin`, `0,0,1000`.

   **Typed steps:** `CEMEMBER`, `SI`, `310UB32`, `Centreline`, `None`, `0,0,0`, `3000,0,0`, Esc. `UCS`, `World`; use LIST on the new lines. Repeat a section at local `0,0,0`. For a rotated planar check, `UCS`, `World`, `UCS`, `Z`, `90`, `PLAN`, `Current`; place `SE`, `380PFC`, `Right`, `Beyond`, `BottomLeft`, `0,0`.

   **Assertion:** Elevated geometry must stay at World Z = 1000 or be explicitly refused before writing; source predicts Z = 0. On the rotated check, record whether “Right” is expected relative to the current UCS/view: source draws World-right, which appears rotated on screen. Do not call the latter an accepted design decision without a recorded ruling. Repeat with a tilted UCS to expose projection loss.

4. **F4 — HIGH — hatch repair can replace correct new spacing with the old fallback when scale settings disagree. Verified-by-reading.**

   **File:line:** `Modules/Structural/Commands/HatchUpgradeCommands.cs:343`, `:380`, `:413`, `:576`; `Modules/Structural/Core/Units/DrawingScaleRule.cs:74`.

   **Plain words and failure scenario:** Placement refuses an invalid DIMSCALE/LTSCALE pair. Audit instead substitutes the old 1:20 value and treats it as a repair target. A correct new LBUH hatch at 1:50 can therefore be changed from 50 back to 20 merely because LTSCALE was changed to 1. This fallback predates S-41, but the new proportional LBUH/LBH values make it a newly exposed regression for those presets.

   **DETERMINISTIC TEST — fixture:** Synthetic mm model-space drawing, default switches ON, DIMSCALE 50, LTSCALE 500, HPANNOTATIVE 0, HPASSOC 1. Closed rectangle from `0,0` to `5000,3000`, ordinary unlocked hatch and boundary layers.

   **Typed steps:** `LBUH`, `Objects`, select rectangle, Enter; verify Pattern scale 50 and valid associative boundary. Set `LTSCALE` to `1` without changing the viewport or intended 1:50 plot. Run `CEHATCHAUDIT`, `Report`; then `CEHATCHAUDIT`, `Repair`. Inspect Pattern scale; repeat with LBH initially at 125.

   **Assertion:** An unusable scale pair must be reported as unknown and must not authorise a scale repair. Source predicts LBUH 50 becomes 20 and LBH 125 becomes 50. Restore LTSCALE 500: the audit would now want the new values again. Verify one U reverses repair separately in AutoCAD; that reversal was not exercised here.

5. **F5 — MEDIUM — “follows paper” still uses model drawing scale directly on the layout sheet. Verified-by-reading.**

   **File:line:** `Modules/Structural/Commands/HatchCommands.cs:1655`; `Modules/Structural/Core/Units/DrawingScaleRule.cs:56`; `Modules/Structural/Commands/CeMemberCommands.cs:99`; `Modules/Structural.DesignCore/SteelSections/CeMemberEngine.cs:219`.

   **Plain words and failure scenario:** LBUH/LBH and CEMEMBER break lines have no paper-space correction. With DIMSCALE 50 they use model-sized spacing even when drawing directly on a millimetre sheet. A CEMEMBER break kink becomes 100 mm on paper rather than 2 mm. The actual member section can legitimately be a full-size detail; the break symbol still must be paper-sized.

   **DETERMINISTIC TEST — fixture:** Synthetic mm layout, `PSPACE` (CVPORT 1), DIMSCALE 50, LTSCALE 500, HPANNOTATIVE 0. Closed 100 by 50 mm rectangle. Default settings.

   **Typed steps:** Place LBUH and LBH in separate rectangles using `Objects`. On the sheet run `CEMEMBER`, `SI`, `310UB32`, `Centreline`, `Both`, `0,200`, `500,200`, Esc. Measure hatch scales and break polyline geometry. Repeat on a model-space fixture plotted at 1:50, using matching pattern definitions.

   **Assertion:** To match the model-space paper density, direct-paper LBUH/LBH scale factors must be 1/2.5 respectively; break overshoot/kink 1.5/2 mm. Source predicts 50/125 and 75/100 mm. In an active model viewport, the code also reads no viewport CustomScale: correct paper size is conditional on DIMSCALE agreeing with that viewport. Changing CANNOSCALE alone does not change these calculations.

6. **F6 — MEDIUM — EBT inherits 25C's missing metre and annotative-scale handling. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/CeTextService.cs:27`, `:610`, `:625`, `:4655`, `:5482`, `:5492`, `:5520`.

   **Plain words and failure scenario:** Matching EBT to 25C is correct at positive DIMSCALE in mm drawings. It does not establish correct physical text size in other units. The metre conversion branch depends on a factor initialised only for the listed footing commands; neither EBT nor 25C belongs to that list. With DIMSCALE 50 both create height 125 drawing units even in metres. With DIMSCALE 0 both fall back to 250 and ignore CANNOSCALE, so at 1:50 they plot 5 mm high rather than 2.5 mm. The 25C limitation is older; S-41 newly routes EBT through it. This goes beyond the earlier review's acknowledgement that metre drawings change.

   **DETERMINISTIC TEST — fixture:** Synthetic metre model-space drawing, INSUNITS 6, DIMSCALE 50, intended plot 1:50, label height 2.5, TagTextFollowsLabelHeight ON. Use an ordinary non-annotative Standard text style.

   **Typed steps:** `EBT`, `1`, `0,0`, Enter at rotation; `25C`, `CHECK`, `1,0`. Read each text's Height in Properties. Repeat in a mm drawing with an annotative dimension style that yields DIMSCALE 0 and CANNOSCALE `1:50`; place the same two texts. Also compare a positive DIMSCALE 100 inside a viewport actually plotted 1:50.

   **Assertion:** Metre heights should be 0.125 m; source gives 125 m. The DIMSCALE 0/CANNOSCALE 1:50 mm case should resolve 125 mm or clearly report that its scale is unavailable; source gives 250 mm. A viewport mismatch also gives 250 mm, hence 5 mm on paper. EBT and 25C agreeing with each other is insufficient evidence of correct paper height.

7. **F7 — MEDIUM — the configured CEMEMBER fallback scale is ignored for DIMSCALE 0. Verified-by-reading.**

   **File:line:** `Modules/Structural/Models/UserSettings.cs:895`; `Modules/Structural/Commands/CeMemberCommands.cs:98`; `Modules/Structural/Services/LegacyToolCommon.cs:147`; `Modules/Structural.DesignCore/SteelSections/CeMemberEngine.cs:188`.

   **Plain words and failure scenario:** DefaultScale is described as applying when DIMSCALE is unusable. The command passes it only as the system-variable read-error fallback. A successful read of 0 passes straight through; the engine then substitutes its hard-coded 100. An office setting of 50 therefore still produces 150/200 mm breaks instead of 75/100 mm.

   **DETERMINISTIC TEST — fixture:** Later tester uses isolated settings, not Tim's live file: `CeMember.DefaultScale = 50`; a mm drawing with DIMSCALE 0, LTSCALE 500. Start the tested plugin against that fixture.

   **Typed steps:** `CEMEMBER`, `SI`, `310UB32`, `Centreline`, `Both`, `0,0`, `3000,0`, Esc. Record the warning and measure the breaks.

   **Assertion:** Configured fallback 50 must be used and named in the warning; source instead names 100 and draws 150/200. The normal positive-DIMSCALE path is unaffected. This is distinct from choosing whether annotation scale should be preferred.

8. **F8 — LOW — recovery directs the drafter to switches that are absent from Settings. Verified-by-reading.**

   **File:line:** `Modules/Structural/Services/SettingsService.LoadRecovery.cs:282`, `:828`, `:1321`; UI search at the pinned head finds no settings controls for these three keys.

   **Plain words and failure scenario:** FollowAnyDrawingScale, HatchDensityFollowsPaper and TagTextFollowsLabelHeight are entered in SettingsPageLabels. That dictionary makes recovery say they are on a Settings page, although the finalizers explicitly record no rows. A damaged OFF value can recover to ON, change subsequent drawing output, and tell the drafter to check a switch they cannot find. Missing rows themselves were already known; the false recovery destination is the additional finding.

   **DETERMINISTIC TEST — fixture:** Isolated CS_Settings.json with otherwise healthy values and `Layouts.HatchDensityFollowsPaper = "bad-value"`; repeat independently for the other two keys. Keep original bytes for comparison.

   **Typed steps:** Start the plugin on that isolated profile, trigger `CESETTINGS`, capture the recovery notice and inspect every page for the named switch. Do not alter Tim's settings to run this probe.

   **Assertion:** Recovery must name the key in plain words and say it has no Settings page, with the original protected. It must not direct the user to a nonexistent control. The shared `PlainLabelsWithoutPage` mechanism already exists at line 803 and is the appropriate classification until rows exist.

## Expected hatch scales and text heights — calculated, not executed

1. **Conditions and formula.** These are entity PatternScale factors, not measured dot diameters or an Australian Standard's minimum text heights. Fixture: mm model space, matching pattern definitions, HPANNOTATIVE 0, DIMSCALE = denominator, LTSCALE = 10 times DIMSCALE, both new switches and FollowAnyDrawingScale ON, LabelPlotHeightMm = 2.5. Hatch = its 1:20 value times DIMSCALE / 20, except fixed presets. Text = 2.5 times DIMSCALE for EBT/25C. Sources: `HatchCommands.cs:73`, `:120`, `:143`, `:1636`; `DrawingScaleRule.cs:56`; `CeTextService.cs:625`, `:663`, `:731`, `:5511`.

2. **At 1:20 (20/200).** LBUH DOTS 20; LBH ANSI31 50; EH EARTH 8; CH AR-CONC 1; WH waffle 1; BLH 50. EBT and 25C height 50 mm, plotting 2.5 mm. THL/THR, PFL/PFR and BPL/BPR height 250 mm, plotting 12.5 mm. CEMEMBER breaks: overshoot 30 mm, kink 40 mm.

3. **At 1:50 (50/500).** LBUH 50; LBH 125; EH 20; CH 2.5; WH 1; BLH 50. EBT and 25C height 125 mm, plotting 2.5 mm. TH/PF/BP text-only variants above stay 250 mm, plotting 5 mm. CEMEMBER breaks: overshoot 75 mm, kink 100 mm.

4. **At 1:100 (100/1000).** LBUH 100; LBH 250; EH 40; CH 5; WH 1; BLH 50. EBT, 25C and the TH/PF/BP text-only variants all height 250 mm, plotting 2.5 mm. CEMEMBER breaks: overshoot 150 mm, kink 200 mm. These unchanged TH/PF/BP constants are a known limitation from entry 1550, not a new finding here.

5. **A different label setting.** LabelPlotHeightMm 3.5 gives EBT/25C heights 70, 175 and 350 mm at 1:20, 1:50 and 1:100; 3.5 mm in paper space. TH/PF/BP text-only variants remain 250. Turning TagTextFollowsLabelHeight OFF restores EBT 250 everywhere, including paper space; 25C still uses the label setting.

6. **Paper space.** EBT/25C directly on a millimetre layout sheet are 2.5 mm at all three positive DIMSCALE values; TH/PF/BP text-only variants remain 250 mm. LBUH/LBH still return the model-scale numbers in items 2–4, the F5 defect. Equal-density direct-paper factors would be LBUH 1, LBH 2.5, EH 0.4, CH 0.05. Waffle is physical geometry, not a paper-density pattern: its real-size rule must be considered separately.

7. **Metre drawing expectations versus code.** For logical DIMSCALE 20/50/100, correct EBT/25C physical heights would be 0.050/0.125/0.250 m; these commands return 50/125/250 drawing units (metres), F6. CEMEMBER section dimensions likewise need division by 1,000, F2. Hatch rules have no INSUNITS input: they still return LBUH 20/50/100 and LBH 50/125/250. To reproduce the same physical spacing with the same pattern data in metre coordinates requires factors 0.020/0.050/0.100 and 0.050/0.125/0.250. Do not silently compare drawings using different imperial/metric pattern definitions.

8. **Switches and invalid pairs.** With HatchDensityFollowsPaper OFF, LBUH stays 20 and LBH 50 at all three valid office pairs; EH/CH remain proportional and fixed presets remain fixed. With FollowAnyDrawingScale OFF, 1:50 placement is refused even if paper density is ON; 1:20 and 1:100 remain accepted. A mismatched pair is refused by placement but uses 1:20 fallback values in audit, F4. DIMSCALE 0 yields EBT/25C 250, rejects LBUH/LBH placement and uses CEMEMBER scale 100. CANNOSCALE is not consulted by these active paths.

9. **Deterministic numeric check for the later tester.** For each pair above, create a separate synthetic model-space fixture with 5000 by 3000 mm closed rectangles; run LBUH/LBH/EH/CH/WH, choose Objects and select the appropriate rectangle (WH also needs origin `0,0`). Read PatternScale. Place EBT `1` with insertion `0,0` and Enter for rotation, and 25C `CHECK` at `1000,0`; inspect Height. For THL/PFL/BPL type `1`, leave the optional second text empty and place at separate points. Assert the exact numeric values above, then inspect equal-scale plot previews; entity values alone do not prove the patterns look right.

## Settings migration and recovery trace

1. **Missing is not OFF. Verified-by-reading.** `UserSettings.cs:28` initialises CeMember; its nine values default to overshoot 1.5, kink 2, fallback scale 100, and layers 25CONT / 18CONT / 18HIDDEN / 9HIDDEN2 / HATCH 10 / 18CONT. Missing individual keys retain those initialisers. Missing Layouts keys leave FollowAnyDrawingScale, HatchDensityFollowsPaper and TagTextFollowsLabelHeight ON. Explicit valid false survives. A blank/null layer name is resolved to the built-in name by `CeMemberLayerNames` (`CeMemberEngine.cs:65`); an invalid nonblank symbol is rejected before writing.

2. **First start can legitimately rewrite the file. Verified-by-reading.** `SettingsService.cs:611` resolves the current CE_STRUC_SUITE folder and CS_Settings.json; line 667 loads/defaults it, line 681 persists with skip-if-unchanged. Adding CeMember/new Layouts keys changes serialised content, so it can write and log added settings without the user pressing Save. There is no special CeMember migration flag. `SettingsService.cs:919` and the protected writer preserve unknown members and skip unchanged content. The timestamp/size change reported in entry 1581 is consistent with this mechanism, but this git-only audit did not read or compare Tim's actual before/after JSON and does not prove what changed there.

3. **Null and damaged values differ from absent keys. Verified-by-reading.** `LoadRecovery.cs:573` deserialises, then `RestoreMissingBlocks` at 754 restores an explicitly null object group and records recovery. A mistyped scalar is removed individually during the bounded retry at 589; defaults fill it while other readable values survive. Recovery copies the original before repair and holds routine writes when protection fails (`:264`). CeMember's absence from `EnsureDefaultsAndMigrate` is not by itself a missing-group defect because this reader restores it. Zero/negative numeric CeMember values are nevertheless syntactically valid and are not range-checked by that reader; break geometry has no separate positivity check. This is an additional robustness concern, not counted without an agreed permitted range.

4. **Exceptions and performance.** CEMEMBER's ordinary draw failures are logged and abort the current member transaction (`CeMemberCommands.cs:219`, `:288`); earlier completed members remain. REFEDIT-state read failure refuses placement. Hatch/tag setting readers catch exceptions and choose ON; this fallback must not be mistaken for the user's explicit preference. Catalogue JSON is cached, then projected once per command (`SectionDatabaseService.cs:25`, `:64`); name search is linear in catalogue size, and drawing writes scale with the small set of member lines, not all objects in the DWG. No runtime timing was measured. Recovery's repeated whole-file deserialisation is bounded at 500 attempts and is older code, not a demonstrated new slowdown.

5. **Deterministic migration fixture for later execution.** Start with isolated S-38-shaped JSON containing an unrelated nondefault value, an unknown future key and no CeMember/new Layouts keys. Launch once on the target build, inspect the resulting JSON and settings log, then launch again. Assert all nine defaults and both new ON values appear, unrelated and unknown values survive, and the second unchanged start does not rewrite the bytes. Repeat with explicit false, null CeMember and one bad numeric string. Assert false survives, recovery names only the damaged/null member, and any protected original is retained. None of these launches or writes was performed in this audit.

## Native checks still owed — not additional verified defects

1. **First questions and keyboard routes — suspected host-dependent risk, no remaining clash proved.** The live View prompt at `CeMemberCommands.cs:317` now has SIde/Top/SEction/Reset; global result names remain Side/Top/Section. Default starts Side. Reset clears session memory and proceeds to the section-name question in Side mode, rather than re-asking View. Anchor/orientation keywords are multiword names such as TopLeft and LeftBottom; they must be exercised in AutoCAD, not certified by the text guard alone. Fixture: fresh synthetic drawing/session. Type CEMEMBER and try SI, SE, T, R, full names and S alone on independent runs; assert SI and SE enter different routes, ambiguous S does not silently choose, Enter with no remembered section asks again, and every displayed anchor/orientation accepts its displayed full word.

2. **Esc at every prompt — verified write ordering, native outcome unproven.** On independent copies cancel at View, name, orientation, Points sit on, Break lines, first point, second point, Section Front/Beyond, base-point choice and insertion. No member/layer write is reached before all required picks (`CeMemberCommands.cs:144`, `:192`). Assert zero new member entities and zero layer-definition changes on all pre-placement exits. Place one complete member, begin a second and Esc at its second point: exactly the first member remains, no fragment of the second. Memory is updated only after successful placement; Reset intentionally changes session memory even if a later prompt is cancelled.

3. **One U / REDO — suspected until driven.** CEMEMBER is Modal without NoUndoMarker, has no native command dispatch and writes each complete member in a short transaction. This supports, but does not prove, its “one U removes the whole run” message. Fixture: clean mm drawing with a baseline line and all output layers/linetypes preloaded. In one CEMEMBER run place three members, Esc, type `U`, then `REDO`. Assert all three disappear together, baseline survives, then all three return with identical extents, layers and hatch loops. Repeat with missing layers and with an in-front hollow section. Also U, start CEMEMBER and Esc before placement, then REDO: record whether native cancellation preserves redo. Do not infer that outcome from transaction boundaries alone.

4. **Locked layers and Xrefs — verified refusal paths, native checks owed.** `CeMemberLineWriter.cs:50` refuses active or unreadable REFEDIT state; `:58` rejects an Xref/overlay space; `:76` uses the protection contract, which rejects required locked/dependent/unavailable layers. It does not traverse or modify Xref contents. Fixture: a synthetic host with one attached synthetic Xref, one locked required output layer, and another unrelated locked layer. Run a placement needing the locked output layer: assert zero additions, no unlock. Repeat during REFEDIT: assert refusal and unchanged Xref. With only the unrelated layer locked, placement should proceed. Picking snap points on an Xref from the host should draw only in the host. Ordinary renamed unlocked layers are preserved by the S-41 fix; F1 covers the remaining standard-name exception.

5. **Z outline and base point — verified arithmetic, picture unviewed.** `StructuralDetailService.cs:291` and `SteelSectionPickerDialog.Preview.cs:349` share the corrected 12 corners. With synthetic depth 250, flange width 125, lip 20, thickness 5, extents are X -120 to 125 and Y -250 to 0: width 245. Thus 100 mm flanges and 3 mm thickness give 197 mm overall, not the 194 quoted in entry 1557. CEMEMBER's equal-width catalogue case yields the same width; its section planner moves/mirrors/turns the outline and then hatches. Fixture: select a packaged ZC in SBEAM; compare preview and placed outline, use all nine anchors, measure width `2W - t`, check no crossing and intact hatch. Repeat CEMEMBER Front/Beyond. The known SBEAM top-elevation width issue, stale CEMEMBER help and duplicate layer-look definitions remain with the earlier reviews and are not recounted here.

6. **Saved-member engine — deliberately not connected.** Searches at the pinned head find no CeMemberRecord/CeMemberReplanner caller under Modules/Structural. Schema 1 checks required names/enums and finite coordinates/positive scale; the undefined-anchor constructor repair is present. The command writes ordinary lines/polylines/hatches without a CEMEMBER edit record. This confirms the earlier review's limitation rather than a new failure. A later storage/edit integration must prove owner identity, cancellation, Undo/Redo, office-layer mapping, units and coordinate-plane preservation; current engine tests cannot establish those host behaviours.

## Summary

1. **Summary.** Eight findings: three HIGH, four MEDIUM, one LOW. Prioritise existing hidden-layer preservation, metre-safe member dimensions and hatch repair when scale is unknown. Complete paper/UCS/text-scale handling and correct fallback/recovery guidance. Ordinary mm-model calculations and the shared Z outline check out by reading. Native prompts, appearance, cancellation and Undo/Redo remain untested. Only this report was authored; no plugin code, settings or drawing was changed, and no bug was marked fixed.
