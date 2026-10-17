# Q4 flip list: which Settings switches Codex has proven, 18 Oct 2026

**Job:** ruling B1 Q4 (Tim, 17 Oct 2026, `decisions/2026-10-17_V3_ALIGNMENT_RESET.md`): a tool switches ON by default once Codex has passed it in real AutoCAD. This file lists what can be flipped in the next fix train.
**Written by:** read-only analyst (Max account). Nothing was built, run, installed or edited, and no AutoCAD was opened. This is a read of reports and of the code on git.
**Sources read:** the Codex coverage index (762 cases, 70 ledgers, 592 PASS, captured 16 Oct), the 13 Oct verification report, the 14 Oct UI functional report, and the code on `origin/claude/rel-20261018b` (Civil 3.0.53 / Manager 1.1.53, head b06126db) and `origin/claude/rel-20261017s` (Structural 1.0.118, head 9a8e5d4e).

## Answer first

1. **STRONG (flip ON now): 0.** No switch that ships OFF has a Codex PASS with the switch turned ON. Codex has only ever driven the tools that are ON by default, or the OFF sentence of a tool that is OFF.
2. **WEAK: 4.** Four Structural tools (Roof setout, Floor setout, Framing legend, Level carry) have a Codex PASS, but only for the sentence that says "switched off, nothing drawn". That is not a pass of the tool. Do not flip them. Their command files have not changed since the Codex build, so the first real test is still to come.
3. **PASS but no OFF switch found (or already ON): 588 of the 592 PASS cases, grouped into 26 feature families in section 4** (the other 4 are the weak ones above). Nothing to flip there.
4. **OFF switches Codex failed or never tested: 85.** The code has about 95 feature switches that default OFF (Civil 46, Structural 42, Manager 7). Of those, 4 are the weak ones, 6 must stay OFF by ruling, 2 are fixes Codex failed the old behaviour for, and 83 were never driven ON.
5. **The real blocker is not the list, it is the test set-up.** Codex is not allowed to edit Tim's real settings file, and no separate AutoCAD settings profile has been launched yet. Until that exists, Q4 cannot produce a single STRONG row. Section 5 gives the way through.

## 1. Why the STRONG list is empty (what I checked)

1. **Every Codex run kept Tim's three settings files byte-for-byte unchanged.** Ledger after ledger ends with "preferences unchanged" and a hash match. So no switch was ever turned on during a Codex test.
2. **The reports say it outright.** 13 Oct report, item 181: Codex read the settings file, saw the Framing legend and Level carry flags both false, and recorded "no global setting toggle". Item 152: "no verified separate AutoCAD profile launched".
3. **The Claude driver runs say the same.** Run 22 (17 Oct): proving a switch's new behaviour "means turning a switch ON in Tim's real Settings file, which the rules forbid". Run 24 (17 Oct, Civil 3.0.52): Tim's three settings files hold no Tidy or Checks key, so every new tool ran on its OFF default.
4. **The Codex build was Civil 3.0.49+48662ddd, Manager 1.1.49, Structural 1.0.116+f180b349 (12 Oct).** Since then Civil has 200 more commits (to 3.0.53) and Structural 77 more (to 1.0.118). Any pass would be on that older code.

## 2. (a) STRONG: Codex PASS, switch OFF, code unchanged since

1. **None.** See section 1. When an isolated test profile exists (section 5) the first candidates to drive ON are listed in section 6.

## 3. (b) WEAK: passed on older code that has changed since, or only the OFF sentence passed

All four passed on Structural 1.0.116+f180b349. The command files of all four are byte-unchanged on the 1.0.118 line (git log of the four command files since f180b349 is empty), so nothing about them has been tested ON at all.

1. **Roof setout (CSROOFSETOUT).** Typing it says "off, nothing drawn, Settings page still to be built". Switch: `RoofSetoutSettings.Enabled`, default false, `Modules/Structural/Models/UserSettings.cs`. Evidence: floor-roof ledger ROOF-OFF-DISCLOSURE PASS (UX-FRM-05); ROOF-ACCEPTED-OUTPUT BLOCKED, "needs isolated enablement/settings profile". Do NOT flip: the drawn output was never seen.
2. **Floor setout (CSFLOORSETOUT).** Same. Switch: `FloorSetoutSettings.Enabled`, default false. Evidence: FLOOR-OFF-DISCLOSURE PASS (UX-FRM-11); FLOOR-ACCEPTED-OUTPUT BLOCKED. Do NOT flip.
3. **Framing legend (CSFRAMINGLEGEND).** Says "not switched on, nothing drawn, still being tested". Switch: `FramingLegendSettings.Enabled`, default false. Evidence: plan-level ledger FRAMING-LEGEND-OFF-DISCLOSURE PASS; FRAMING-LEGEND-ACTUAL-OUTPUT BLOCKED (UX-FRM-01). Do NOT flip.
4. **Level carry (CSLEVELCARRY).** Says "off in Settings, nothing drawn". Switch: `LevelCarrySettings.Enabled` (and `FromBelow`), default false. Evidence: LEVEL-CARRY-OFF-DISCLOSURE PASS; LEVEL-CARRY-ACTUAL-OUTPUT BLOCKED (UX-LEVEL-02). Do NOT flip.

## 4. (c) PASS, but the feature has no OFF switch (or the switch is already ON)

Search method: every `bool` property that defaults false in the Civil and Structural settings models, plus Manager's switch file keys. A non-bool or hidden switch could still exist; I did not find one. PASS numbers are cases in the index. Every family below was tested on the default settings, so these pass as they ship.

**Civil (273 PASS)** (items 1 to 10)

1. **Pit and pipe drawing, Edit Pipe, live schedule update (28).** Early Civil ledger, BUG-207, UX-LIVE-01. No OFF switch gates them. Linking is ON by default.
2. **Pit Schedule write and placement (11).** Schedule-write 5, schedule-placement 6. No OFF switch gates writing. Note: `PitScheduleNaturalOrder` (OFF) changes the order, untested.
3. **Flat pipe label and levels (5).** BUG-427. No switch.
4. **Spot level, Suggest fall, linked fall (47).** Spot-fall 17, suggested-fall 14, linked-fall 16. No OFF switch found.
5. **Rainfall curve window (15).** No switch. Note: `FlowsUseJobRainfallCurve` (OFF) is the separate setting that makes CDDESIGN use the job curve; not tested.
6. **Calculations: CDCALC, export, report intake, catchment rows (61).** UX-CALC-04. No on/off switch; the failures here are bugs, not switches.
7. **Long section CDPROFILE (18).** UX-LSEC-01, UX-LSEC-02. Tested with the default seven rows. `OfficeLayout` (OFF) is the office-layout version; untested.
8. **LandXML import, drawing check, comparison (17).** LandXML 8, CDCHECKDWG 5 (UX-IMP-02), comparison 4. No switch on the tested path.
9. **Catchment overlay, curves, overload warning (16).** UX-SURF-03. No switch.
10. **Source blocks, connection, connected move, floor waste, strip drain, AGI, generic source (55).** UX-SRC-05, UX-SURF-04. No switch.

**Structural (301 PASS; the other 4 are in section 3)** (items 11 to 24)

11. **Wind and bracing: AB, BB, panel, wind region (20).** UX-FRM-14, UX-SOIL-03, BUG-496, BUG-218. No switch. `WallOption` (OFF) adds the wall pick; untested.
12. **Tie-down BT9 and floor-roof entry (7 of the 9 in that ledger).** UX-FRM-14, R1, RJSET. The other 2 are the OFF sentences in section 3. `ShowTypeNamesInPrompt` and `ScheduleShowsDescription` (OFF) untested.
13. **Rafter R1, joist FJ1, purlin P1 (15).** No switch.
14. **Plan level carry-down prompt (11 of the 13 in that ledger).** The other 2 are OFF sentences, section 3.
15. **Supports C1, DS, TS1, SC2; beams B1; footings FPFC, FEDIT, FSF, FDELETE, FST (32).** Early Structural ledger. `LinkingEnabled` defaults ON in code; Tim's own file has it OFF, so Codex saw "linking off". Linking itself is untested. `FoundationGripSettings.Enabled` and `FoundationProposalSettings.Enabled` (OFF) cover grips and proposals, not the typed footing commands tested.
16. **Checklist CECHECKLIST (12).** No switch.
17. **Steel section picker SBEAM (13).** No switch.
18. **Reinforced concrete beam and column RCBEAM, RCRECTCOL, RCCIRCCOL (24).** No switch.
19. **Hatch library and CH, EH, WH, LBH, LBUH, BLH, gap, batch (45).** No switch.
20. **Xref layer move XRL, XRLCONFIG, CXREF, PXREF (12).** No switch.
21. **Dimensions AD, LD, RD, arc dimension, dimension repair DSET, DUP (42).** Dimension style Escape fault (BUG-621) is a bug, not a switch.
22. **Leaders: Q, QD, MLL, MLR (24).** No switch.
23. **Levels FFL and LMU, break line BL, section mark SM, revision cloud (24).** `SectionMarkIdentifierInClearHalf` and `SectionMarkOfferNextIdentifier` (OFF) are fixes for failed SM cases; see section 7.
24. **Text 25L, 25R, 25C, EBT, R2LTXT (20).** No switch.

**Manager (14 PASS)** (items 25 and 26)

25. **Manager window: Module pages, View commands, Settings Light and Dark, Help guides (9).** EM-02, 03, 04, 06, 08, 09, 10, 11, 13. No switch on the tested path. The Manager switch file (`manager-switches.json`) holds 7 keys, all OFF; Codex tested the default look. `showRollBack` hidden is the intended default and Codex W56 (10 Oct) passed that.
26. **Move and rotate MR (5).** EM-15..EM-19, PASS narrowly (Undo, Redo, locked-layer refusal). The echo "Move Rotate complete" is the native ObjectARX transform in `Shared.Transform.Native2027`, which has no Settings switch. `OptionSettings.UseNativeCopyRotate` (OFF) is a different C# path and was not what ran. The tool register still labels MR "Preview" (`Assets/Config/ce-tool-register.json`): that is a label used by Help, not an on/off switch. Suggest: set it to Active in the register if Tim agrees.

**Shared across Civil, Structural and Manager**

27. **Cross-cutting, not counted again: Settings window pages (CDS, CESETTINGS).** EC-01..EC-03, ES-01..ES-02, EM-05..EM-10: window fit and Cancel. No switch.
28. **Cross-cutting: Undo and Redo behaviour, save and reopen persistence.** Covered inside every ledger above. No switch.
29. **Cross-cutting: protection of locked layers and Xrefs.** Covered inside the transform, bracing and dimension ledgers. No switch (and the ruling is that there must never be one).

## 5. What it takes to make Q4 work (recommendation)

1. **Build a test settings profile Codex may switch freely.** Structural already honours `CE_STRUC_SUITE_APPDATA_ROOT`; Civil honours `CE_LOG_DIR_OVERRIDE` (it moves the Civil settings folder to a "settings" folder inside it; the test project reported a guard that wants the folder inside Windows Temp). Neither has been launched in a separate AutoCAD session to prove it. Recommendation: one Codex job proves this on a throw-away folder first.
2. **Then Codex runs each OFF tool with its switch ON, on a test copy, and records PASS or FAIL.** Only that gives the STRONG row Q4 asks for.
3. **Flip the default in code in the same fix train as the pass.** A Civil default flip reaches Tim's PC too, because Tim's file holds no key for these tools (Run 24). Structural defaults only reach PCs with no stored value; a stored value is never rewritten.
4. **Do not flip the 6 in section 7.3.**

## 6. First tools to drive ON when the profile exists (my order, for the desk to accept or change)

1. **Tidy labels (CDTIDYLABELS), `LinkingSettings.TidyLabelsEnabled`.** Tim approved building it on 17 Oct (ruling H4). Run 24 saw it print "switched off" and ask "Switch Tidy labels on for this computer now?" (answered No).
2. **New Checks list (CDCHECKS), `UseSharedResult` and the Checks switches (`AllowIgnoreFinding`, `ShowWhereGlow`, `RecordPipeEndsOffPit`, `WrongLayerRows`, `LayerDiffersRows`).** Run 24 saw "The new Checks list is switched off".
3. **Edit Pipe re-tidy and label rules (`EditPipeRetidyLabels`, `HandPlacedLabelsStay`, `PitLabelOnEsc`, `KeepTextReadableAfterRotateMirror`).** These sit on tools Codex already passed with the old behaviour, so a retest is cheap.
4. **Pipe ends join (`AutoJoinPipeEnds`) and AutoCAD-style CD prompts (`AutoCadStyleCdPrompts`, `ShowJoinTargetGlow`).** Both say in the code "OFF until Codex has accepted it".
5. **The four Structural setout and legend tools in section 3, then Member schedule (`MemberScheduleSettings.Enabled`), Beam hover (`BeamHoverSettings.Enabled`), Issue register (`IssuePreviewEnabled`, `IssueJobWidePdfEnabled`, `IssueDwgSnapshotEnabled`).** All say in the code "off until Codex passes it".

## 7. (d) OFF switches Codex failed or never tested: counts

1. **Total feature switches defaulting OFF in the code lines read: about 95** (this section's own count: 2 + 83 = 85 failed or never tested, plus 4 weak, plus 6 by ruling). Civil 46, Structural 42, Manager 7. Counted from `bool` properties in `UserSettings.cs` and the other models, and Manager's switch file; give or take a few if a switch is written another way.
2. **Codex FAILED the old behaviour the switch fixes: 2.** Both Structural section mark: `SectionMarkIdentifierInClearHalf` (SM-04 FAIL, BUG-632) and `SectionMarkOfferNextIdentifier` (SM-02 FAIL, BUG-630 and UX-SEC-01). These need a Codex retest with the switch ON before they flip.
3. **OFF by ruling or as a safety, must NOT be flipped: 6.** Civil AI master switch `AiSettings.FeaturesEnabled`; Civil `ConsultantCheckReportBesideDwg` (OFF is the protection, BUG-606); Civil `LandXmlSumpLevelAsInvert` (OFF is the fix for a made-up invert, BUG-605); Structural `FastSaveAlsoCleans` (Tim's ST5-14 ruling); Structural `AutosaveCivilOnlyDrawings` (OFF by design, BUG-189); Manager `showRollBack` (hidden by R-27).
4. **Weak: 4** (section 3).
5. **Never driven ON by Codex: 83.** This includes every `linking.*` fix switch, the Tidy and Checks families, the Issue register, Member schedule, Beam hover, Roof point load, Load path, Computations, Lintel and Wall schedule, Foundation grips and proposals, Council RFI, Crossing services, Tank callout, Levels proposal, and the other 6 Manager keys.
6. **Not in these counts:** Debug, diagnostic, migration and onboarding flags; the Markup AI switches (4 Structural); `ShowClassicCeTabs`; `UseNativeCopyRotate`; `LegacyReactorEngineEnabled`. Those stay as they are.
7. **Hidden-from-ribbon is a different thing.** The command registries mark 74 Civil and 62 Structural commands `hidden`. That is not a Settings switch and is not covered by Q4 here; say if Tim wants those reviewed as well.

## 8. What I did NOT check

1. **Tim's own settings files.** Not opened, by instruction. Whether a switch is ON in his real file is known only from what Codex and the driver runs quoted.
2. **Older Codex runs (W-series, 1 to 10 Oct) and any Codex run after 16 Oct.** Not in the coverage index I was given.
3. **Non-bool switches and switches held in other files.** Not found; not excluded.
4. **Whether any test copy of a setting could be changed safely in AutoCAD.** Not run. Section 5 is a recommendation only.
