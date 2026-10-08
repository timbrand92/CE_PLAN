# Bug hunt 2, Civil design tools (hunt2_civil run 2)

**Written Fri 9 Oct 2026, 09:21 to 09:45 Melbourne (PC clock). Read-only helper, MAX account, desk plan/03.**

**What was read.** The installed Civil code, Civil 3.0.41 at `660487d1` (the tip of `origin/claude/rel-20261009g`; one version-number commit on top of `319ba688`), read with `git archive` into a scratch folder. Nothing was checked out, built or run. No AutoCAD, no accoreconsole. **Every finding is from reading the code only. Nobody has seen any of these in AutoCAD.** Where a sentence is my judgement and not what the code shows, it starts "I think".

**Carpark checked.** `C:\CE_PLAN\BUG_CARPARK.md` (runs to BUG-494) was searched for each finding. Left out because they are already parked: the fixed Boyd's rainfall rows in CDCALC (BUG-249), the built-in velocity, cover, grade and 5 minute numbers, the Casey orifice formula and the pump sizer numbers (BUG-419), the long section 0.30 m sump (7 Oct source audit), the X-Civil unlocking of locked layers (BUG-417), the X-Civil family BUG-058 to BUG-069, metre-drawing faults (BUG-328 to BUG-338, BUG-393), the Swinburne councils sized with Boyd's (BUG-095 and the release area file, item 11), and everything in hunt run 1 (BUG-458 to BUG-465).

**Paths.** File paths are inside `Modules/Drainage/` at `660487d1` unless named otherwise.

**Not in the installed build.** The "place many downpipes" step (PlaceMany, card `DESIGN_L3-PLACEMANY_CARD_2026-10-07.md`) is not in `660487d1` (searched the whole commit), so it was not hunted.

---

## The 15 findings, most valuable first

### HUNT2-C-01 (HIGH): X-Civil import can put the whole job 1000 times too far out, from one short pipe line

1. **What the drafter sees.** `CDIMPORTXCIVIL` on a millimetre X-Civil drawing. The pits and pipes land 1000 times further from the origin than the X-Civil linework, and are 1000 times too big. No line on the command line says CE changed the scale. The same happens for every X-Civil or LandXML import into a drawing whose UNITS are Metres.
2. **Why (the code shows).** CE guesses whether the X-Civil drawing is in metres (`Services/XcivilEntityScanner.cs:427-486`). It does not read the X-Civil drawing's own UNITS. It takes the FIRST thing that looks metre-sized and stops: one pit block 0.05 to 3.0 wide (`:436-442`), or one polyline on a pipe layer 1 to 250 long (`:448-455`). The comment above says "if EVERY named pit" is metre-sized, but the code returns on the first one. Then every position, pit size and pipe diameter is multiplied by 1000 (`:499-518`, called at `Services/XcivilImportService.cs:323-325`). The scale is written only to the debug file (`:324`). Neither the X-Civil route nor the LandXML route (`Helpers/LandXmlParser.cs:170-173`) looks at the CURRENT drawing's UNITS at all: both always place in millimetres. Compare the downpipe symbol reader, which does use the drawing's own UNITS (`Services/BackgroundDownpipeSymbolReader.cs:73-77`).
3. **I think.** A 200 mm stub, a short leader or a short tail of pipe linework on a pipe layer is common in a millimetre drawing, so a real job can trip this.
4. **Steps in AutoCAD.** Take a COPY of a millimetre X-Civil drawing that imports correctly today. Add one 200 mm polyline on its pipe layer and save. `CDIMPORTXCIVIL` into a copy of a job drawing. `ZOOM` Extents. Then a second test: set `UNITS` to Metres in a copy of the target drawing and import again.
5. **Right result.** CE reads the X-Civil drawing's UNITS first and the target drawing's UNITS too, scales between them, and says so in one line: "X-Civil drawing is in metres; placed in this millimetre drawing at 1000 times." Where the units are not set, it asks once.
6. **Test today.** None for the scale guess (searched `Modules/Drainage.Tests` for `DetermineXcivilSourceToTargetScale` and for metre imports).
7. **Smallest fix.** Use the source drawing's `Insunits` and the target's `Insunits` (the same `DrawingAreaUnits.MillimetresPerUnit` the downpipe reader uses). Keep the guess only when UNITS are not set, require most pits to agree, and print the scale used.

### HUNT2-C-02 (MEDIUM): CDDESIGN's calculation summary shows the connection pipe grade as "1:0"

1. **What the reviewer sees.** In the CDDESIGN calculation summary, under CONNECTION PIPE: "Diameter 100 mm" and "Grade 1:0" (any size; the grade always reads 1:0 for anything flatter than 1 in 2).
2. **Why (the code shows).** The pipe sizer hands back the grade as N in "1 in N", for example 100 (`Services/PipeSizingSolver.cs:235`; CDDESIGN keeps it as `connectionGradeN`, `Services/AutoDesignService.cs:113-114, 648-651`). The summary treats it as a slope and divides 1 by it: 1 / 100 = 0.01, rounded to 0, printed "1:0" (`Services/DesignProposalReport.cs:280-284`).
3. **Steps in AutoCAD.** Copy of a job with a council and areas set. `CDDESIGN`, work the design out, read CONNECTION PIPE in the summary.
4. **Right result.** "Grade 1:100" (the N the sizer gave).
5. **Test today.** `Modules/Drainage.Tests/Services/DesignProposalReportTests.cs:55` feeds the summary 0.01 ("1:100"), which the real design never produces, so the test passes and the screen is wrong. `DetailSelectorTests.cs:718` feeds 100.0, the real form.
6. **Smallest fix.** Print `"1:" + N` without dividing, and change the report test to feed 100.

### HUNT2-C-03 (MEDIUM, R-12): CDCALC's Boyd's tab opens with another job's figures, and they flow on

1. **What the drafter sees.** A new job with no saved calculation. `CDCALC`, Boyd's tab: site area 746 m², roof and paved 414 m², pervious 332 m², permitted discharge 7.9 L/s and a storage already worked out. On the Detention tab each system is offered that storage and 7.9 L/s. If the drafter saves without overtyping, `CDDESIGN` later reads 746 m² and 414 m² as this job's areas.
2. **Why (the code shows).** The Boyd's tab starts with fixed figures (`ViewModels/BoydsCalcViewModel.cs:12-17`) and works a storage out at once (`:95`). With no saved Boyd's draft the figures stay ("an absent panel keeps its current defaults", `ViewModels/CalculationsV2ViewModel.cs:571-573, 618-619`). The storage is pushed to every detention system (`:446-451`) and the 7.9 is offered as the PSD (`:457-470`). CDDESIGN reads the Boyd's areas as known site facts (`Services/CivilDesignService.cs:53-58`).
3. **Steps in AutoCAD.** Copy of a job that has never had CDCALC saved. `CDCALC`, open Boyd's, read the boxes. Open the Detention tab and read the suggested volume. Save, close, `CDDESIGN` and read the site area.
4. **Right result.** Empty boxes that say "Unknown, not entered", no storage worked out and nothing offered to the Detention tab until real figures are typed.
5. **Test today.** None that checks a new job starts empty. (BUG-249 covers only the intensity rows, not these area and discharge figures.)
6. **Smallest fix.** Start the Boyd's boxes blank; work out nothing and push nothing while any box is blank.

### HUNT2-C-04 (MEDIUM): CDDESIGN works the flows and the connection pipe off the office rainfall curve, even when the job has its own

1. **What the reviewer sees.** A job with its own rainfall coefficients (CDRAINFALL). The storage and the permitted discharge use the job's curve, but "Q minor" and "Q major" in the summary, and the connection pipe size, come from the office Melbourne curve. Nothing says the two halves used different rainfall. (DAY1 notes the office curve reads 6.5 to 8.6 per cent high against a real issued sheet.)
2. **Why (the code shows).** The flows come from `RationalFlowService.ComputeMinorMajorWithNotes` (`Services/AutoDesignService.cs:101-114`), which calls `ComputeFlow` and `GetIntensity`, and `GetIntensity` always uses the office curve (`Services/RationalFlowService.cs:199-200, 264-288, 330-353`). The job's curve is never passed in. The storage and the permitted discharge do use it (`Services/DetentionSizingService.cs:129-133, 270-273`; `Services/AutoDesignService.cs:389-392`, whose comment says both halves must be on the same rainfall).
3. **Steps in AutoCAD.** Copy of a job. `CDRAINFALL`, set the job's own coefficients. `CDDESIGN`, read Q minor and Q major. Compare with the same figures worked by hand from the job's curve.
4. **Right result.** All flows on the job's curve, or a line saying which curve each figure used.
5. **Test today.** None: no test gives the flows a job curve (searched the tests that read `QMinorLps`/`QMajorLps`).
6. **Smallest fix.** Pass the job's curve into `ComputeMinorMajorWithNotes` and `ComputeFlow`, and use `RainfallCurves.CurveInUse(curve)` there like the storage does.

### HUNT2-C-05 (MEDIUM): the CDDESIGN summary prints the office pre-development C, not the council's C that was used

1. **What the reviewer sees.** A Darebin or Maribyrnong job. The summary says "Before-development C (whole site) 0.35" and "Source: computed (pre-dev rational method, C = 0.35)". The permitted discharge was actually worked out with the council's 0.4.
2. **Why (the code shows).** The calculation picks the council's fixed C first (`Services/DetentionSizingService.cs:254-258`; `Services/AutoDesignService.cs:379-383`). Darebin and Maribyrnong carry 0.4 in `Assets/Config/council-profiles.json`. The summary prints the office Settings figure the window passed in (`Services/DesignProposalReport.cs:114-115, 178-181`; the figure comes from `Services/CivilDesignService.cs:155`). The same happens for a site-case C (Kingston commercial).
3. **Steps in AutoCAD.** Copy of a job. `CDRULEBOOK`, set the council to Darebin. `CDDESIGN` with detention on, read the two C lines and the PSD. Work the PSD by hand with 0.35 and with 0.4.
4. **Right result.** The summary prints the C actually used, and where it came from ("0.40, Darebin's own figure").
5. **Test today.** None for a council with its own fixed C in the summary.
6. **Smallest fix.** Have the design hand back the C it used (one field on the proposal) and print that.

### HUNT2-C-06 (MEDIUM, R-00): roof and paved areas count as C 0.9 in CDDESIGN but 1.0 in CDCALC

1. **What the reviewer sees.** The same site worked in CDCALC (Boyd's tab) and in CDDESIGN gives different storage. With the Boyd's tab's own figures (746 m² site, 414 m² roof and paved, soft ground 0.3) CDCALC uses an overall C of 0.69 and CDDESIGN 0.63, so the inflow differs by about 8 per cent before anything else.
2. **Why (the code shows).** CDDESIGN's hard-ground C is fixed in code at 0.9, and the code comment says it is "Not council- or Settings-driven" (`Services/AutoDesignService.cs:48-55, 296`). CDCALC's Boyd's tab counts roof and paved area at 1.0 (`ViewModels/BoydsCalcViewModel.cs:182`). Two code paths for one engineering figure (design rule #1), and neither is on the Settings page.
3. **Steps in AutoCAD.** Copy of a job. `CDCALC` Boyd's: type site, roof and paved area and PSD, note the storage. `CDDESIGN` on the same areas and PSD, note the storage.
4. **Right result.** One hard-ground C, on the Settings page beside the soft-ground and before-development C, used by both.
5. **Test today.** `DesignProposalReportTests.cs` prints the 0.9 but nothing compares the two tabs.
6. **Smallest fix.** Add a hard-ground C row to Settings (shipped value for Tim to confirm) and read it in both places.

### HUNT2-C-07 (MEDIUM, R-00): CDDESIGN sizes the detention pipe with its own 40 m and 225 to 600 mm, not the Settings values CDRULES checks

1. **What the reviewer sees.** Change the detention pipe house rules in the settings file (longest run 30 m, sizes 300 to 450 mm). CDDESIGN still proposes a 225 mm pipe up to 40 m long, and CDRULES then warns about the run CDDESIGN just proposed.
2. **Why (the code shows).** CDDESIGN uses a fixed size list and a fixed 40 m (`Services/AutoDesignService.cs:57-68, 569-605`). The Settings file already holds `detentionMaxRunM`, `detentionMinDiameterMm` and `detentionMaxDiameterMm` (`Models/UserSettings.cs:1367-1373`), and CDRULES R-06 checks the drawing against them (`Rules/RulebookValues.cs:234-236`, `Rules/RulebookEngine.cs:473-497`). These three are not on the Settings window either (the window saves none of them: `ViewModels/AdvancedSettingsViewModel.cs:1400-1420`).
3. **Steps in AutoCAD.** On a copy of the settings file, set the longest detention run to 30. `CDDESIGN` on a job with about 3 m³ of storage, read the detention pipe. `CDRULES`, read R-06.
4. **Right result.** CDDESIGN picks only sizes inside the Settings range and keeps runs within the Settings length, so CDRULES agrees with it.
5. **Test today.** None that ties the two together.
6. **Smallest fix.** Read the three rulebook values (council, then project, then office) in `SizeDetentionPipe`, and add the three rows to the Settings window.

### HUNT2-C-08 (MEDIUM, R-12): LandXML import fills in a 375 mm pipe, a 600 x 600 pit and STORMPRO SN12 when the file says nothing

1. **What the drafter sees.** `CDIMPORTLANDXML` on a file where a pipe has no size, a structure has no size, or a pipe has no material. The pipe is drawn and labelled 375 DIA, the pit 600 x 600, the material STORMPRO SN12, with no line saying these were not in the file.
2. **Why (the code shows).** `Helpers/LandXmlParser.cs:313` ("reasonable default" 375), `:195-196` (600 x 600), `:416-417` (STORMPRO SN12). The pipe is then marked as having a real size from the file (`HasExplicitDiameter = true`, `DiameterSource = "LandXML"`, `:329-331`), so later steps cannot tell it was invented. The X-Civil route marks the same case "default" and "uncertain" (`Services/XcivilEntityScanner.Pipes.cs:1132-1136`).
3. **Steps in AutoCAD.** Copy a LandXML file and delete one pipe's `CircPipe` element and one structure's `RectStruct`. `CDIMPORTLANDXML` into a copy of a drawing. Read the pipe label, the pit size and the command line.
4. **Right result.** Size and material stay Unknown, shown as "SIZE NOT IN FILE", and one line lists each one.
5. **Test today.** `Modules/Drainage.Tests/Helpers/LandXmlParserTests.cs` covers missing positions (CL1), not missing sizes or material.
6. **Smallest fix.** Leave the size at 0 with `HasExplicitDiameter = false` and `DiameterSource = "default"` like X-Civil, and list the gaps in the import report.

### HUNT2-C-09 (MEDIUM): LandXML import writes the pit floor (sump) level as the pit's invert level

1. **What the drafter sees.** A LandXML structure with no `Invert` rows but a sump level. CE labels the pit "IL" at the sump level, for example IL 19.70 where the outlet is at 19.85. The pipes connected to it then take a level 150 mm too low.
2. **Why (the code shows).** With no `Invert` children, CE writes `elevSump` as "IL", rounded to two decimals (`Helpers/LandXmlParser.cs:250-262`). The comment says "derive IL = elevRim - depth", but the code just copies the sump level. In LandXML the sump is the floor of the structure, not the pipe invert.
3. **Steps in AutoCAD.** Copy a LandXML file and remove the `Invert` rows from one structure that has a sump level below its outlet. Import and read the pit's IL.
4. **Right result.** IL stays Unknown with a line "no invert in the file for P3; its floor is 19.70", never the floor as the invert.
5. **Test today.** None (searched the tests for `elevSump`).
6. **Smallest fix.** Delete the sump fallback; report the sump only as a note.

### HUNT2-C-10 (MEDIUM): CDRULES adds a "Velocity uses Assumed roughness" warning for every pipe, even after Tim confirms the roughness

1. **What the drafter sees.** `CDRULES`: one warning per pipe that says "Velocity uses Assumed roughness", also after the Manning n values are confirmed in Settings. On a 30-pipe drawing that is 30 warnings, so the warning count in the summary line (DAY1 step 13 saw 29) is mostly this one line.
2. **Why (the code shows).** The warning is written for every pipe whose roughness is known, with no check (`Rules/RulebookEngine.cs:416`). The roughness reader does know when it is confirmed and says "Manning n; confirmed in Settings", and only marks the unconfirmed ones as assumed (`Rules/RulebookValues.cs:354-373`).
3. **Steps in AutoCAD.** On a copy, confirm the uPVC roughness in Settings. `CDRULES`, `P`, count the "Assumed roughness" lines.
4. **Right result.** The line appears only for a pipe whose roughness is still the unconfirmed seed value.
5. **Test today.** None mentions this line (searched the tests).
6. **Smallest fix.** Write the warning only when `roughness.IsAssumed` is true.

### HUNT2-C-11 (MEDIUM): the Boyd's storage can be too small when the worst storm is longer than the last row, and nothing says so

1. **What the reviewer sees.** CDCALC's Boyd's tab works only 5 to 30 minute storms. CDDESIGN works 5 to 180 minutes. When the storage is still growing at the last row (a tight permitted discharge), the answer is the last row's figure, the "critical duration" reads 30 min (CDCALC) or 180 min (CDDESIGN), and no warning is given.
2. **Why (the code shows).** `ViewModels/BoydsCalcViewModel.cs:87-92` (six rows, 5 to 30 min) and `:189-211` (largest row wins). `Services/DetentionSizingService.cs:66-67` (fixed list ending 180) and `:131-158` (largest row wins). Neither checks whether the largest is the last row.
3. **I think.** On a normal house lot the worst storm is 30 to 120 minutes, so CDCALC's 30-minute limit is the one most likely to bite, and two tools giving two storages for one site is design rule #1 again.
4. **Steps in AutoCAD.** Copy of a job. `CDCALC` Boyd's with a small permitted discharge (for example 2 L/s on 700 m²). Read the critical duration. `CDDESIGN` on the same figures and compare the storage.
5. **Right result.** Both use the same storm list, and when the worst storm is the last one CE says "storage still rising at 180 minutes: add longer storms before issuing".
6. **Test today.** None for the last-row case.
7. **Smallest fix.** A one-line check after each sweep, and one shared storm list (Settings value).

### HUNT2-C-12 (LOW): CDTWL measures detention pipe storage from pit centre to pit centre

1. **What the reviewer sees.** CDTWL's storage for a pipe run is a straight line between the two pit centres. A bent run is under-counted. The part of the pipe inside each pit is counted twice, because the pit's own volume is counted as well. Then the design-versus-drawing check can say "The drawing holds more than the sheet says" over a difference this method made.
2. **Why (the code shows).** `Rules/DetentionBranchCollector.cs:237` and `:309-322` (straight distance between pit positions). Pits are counted full plan size from their invert (`Rules/DetentionStorageMath.cs:106-125`). The "matches" tolerance is fixed in code at 0.5 per cent or 1 litre (`Rules/StorageDesignedVsDrawn.cs:10-12, 30-31`).
3. **I think.** For a 15 m twin 375 run between two 600 pits the double count is about 0.13 m³ of about 3.3 m³, roughly 4 per cent, which is well over the 0.5 per cent tolerance.
4. **Steps in AutoCAD.** Copy of a job with a detention run. `CDTWL`, read the pipe storage. Measure the drawn pipe from pit wall to pit wall with `LIST` and work the storage by hand.
5. **Right result.** Pipe storage from the drawn pipe length between the inside pit walls; the tolerance on the Settings page.
6. **Test today.** `Modules/Drainage.Tests/Rules/DetentionBranchCollectorTests.cs` exists; I did not find a bent-pipe or pit-overlap case.
7. **Smallest fix.** Use the pipe's own drawn length (already on the pipe record) less half of each pit's width along the pipe.

### HUNT2-C-13 (LOW, R-00): two different freeboard settings, and CDRULES prints one it never checks

1. **What the reviewer sees.** CDRULES lists "R-06 detention: ... freeboard 150 mm", but no CDRULES rule checks freeboard. CDTWL checks freeboard against a DIFFERENT setting. Change one and the two disagree. Neither is on the Settings window.
2. **Why (the code shows).** Two settings both named `detentionFreeboardMm`: one under Pipe (`Models/UserSettings.cs:505-506`), read by CDTWL (`Services/DetentionTwlService.cs:361-364`); one under Design Standards (`Models/UserSettings.cs:1374-1375`), read into the rulebook (`Rules/RulebookValues.cs:237`) and only printed (`Commands/RulesCommand.cs:240`). Nothing in `Rules/RulebookEngine.cs` uses it.
3. **Steps in AutoCAD.** On a copy of the settings file set the Design Standards freeboard to 300. `CDRULES` reads 300. `CDTWL` still warns against 150.
4. **Right result.** One freeboard, on the Settings window, used by CDTWL and shown by CDRULES.
5. **Test today.** None ties the two.
6. **Smallest fix.** Read the rulebook freeboard in `DetentionTwlService.FreeboardMm()` and retire the Pipe copy (keep reading it once for old files).

### HUNT2-C-14 (LOW): every no-detention design says "Inner-metro site — no OSD required", whatever the council

1. **What the reviewer sees.** Untick detention in CDDESIGN on, for example, a Casey job. The notes say "Inner-metro site — no OSD required; recommend WSUD water-sensitive landscaping tank (size separately)." Casey is not inner-metro and the drafter, not the council, decided there was no detention.
2. **Why (the code shows).** The sentence is added to every no-detention design (`Services/AutoDesignService.cs:131-133`). Also the "no council profiles" note fixes "storage 1-in-10" and "Co 0.6" in the words (`:270-273`) while the Tc and storm beside them come from Settings.
3. **Steps in AutoCAD.** Copy of a job set to Casey. `CDDESIGN`, untick detention, work it out, read the notes.
4. **Right result.** "Detention switched off for this design. Confirm the council does not need on-site detention before issue."
5. **Test today.** None (searched the tests for "Inner-metro").
6. **Smallest fix.** Say it only for the inner-metro profile; use the plain sentence above for the rest.

### HUNT2-C-15 (LOW): LandXML sizes ignore the file's own size units

1. **What the drafter sees.** A LandXML file that states its pipe sizes in inches (or feet) imports a 12 inch pipe as 12 mm. A metric file is read by a rule of thumb, not by what it says.
2. **Why (the code shows).** The parser reads only `linearUnit` and only to decide metres for positions (`Helpers/LandXmlParser.cs:400-408`). Pipe and pit sizes use "under 10 means metres, otherwise millimetres" (`:374-388`). The file's `diameterUnit` and `widthUnit` are never read.
3. **I think.** Rare on Victorian jobs, but a consultant file from a US-set-up Civil 3D template would do it.
4. **Steps in AutoCAD.** Copy a LandXML file, set `diameterUnit="inch"` and a 12 diameter. Import and read the label.
5. **Right result.** Sizes converted from the stated unit; where none is stated, the current rule plus a line saying so.
6. **Test today.** None for size units.
7. **Smallest fix.** Read `diameterUnit` and `widthUnit` from the `Metric` (or `Imperial`) element and convert.

---

## What was NOT checked

1. **Nothing was run.** No build, no test run, no AutoCAD. Every line above is from reading code.
2. **The long section (CDPROFILE, 3,171 lines)** was only scanned for fixed numbers; its levels, chainages and table text were not traced.
3. **X-Civil pit and pipe matching in depth** (the BUG-061 family and the note-to-pipe matching order against the scale step) was not traced beyond the scale finding.
4. **CDRG (raingarden)** was read; nothing new beyond the parked metre-drawing faults (its 1-unit closing distance is 1 m in a metre drawing).
5. **Council profile values themselves** were not checked against the council documents; only how the code reads them.
6. **PlaceMany** is not in the installed build.

## For the desk: draft IDs to carpark

1. **HUNT2-C-01** HIGH: X-Civil guesses metres from the first short pipe or small pit and multiplies the whole import by 1000; target drawing UNITS ignored by X-Civil and LandXML.
2. **HUNT2-C-02** MEDIUM: CDDESIGN summary connection pipe grade "1:0" (report divides N).
3. **HUNT2-C-03** MEDIUM: CDCALC Boyd's opens with example figures (746 / 414 / 7.9 L/s) that are offered to the Detention tab and read by CDDESIGN.
4. **HUNT2-C-04** MEDIUM: CDDESIGN flows and connection pipe on the office rainfall curve when the job has its own.
5. **HUNT2-C-05** MEDIUM: CDDESIGN summary prints the office pre-development C, not the council's C used.
6. **HUNT2-C-06** MEDIUM: hard-ground C 0.9 in CDDESIGN, 1.0 in CDCALC, neither in Settings.
7. **HUNT2-C-07** MEDIUM: CDDESIGN detention pipe ignores the Settings run and size range CDRULES checks.
8. **HUNT2-C-08** MEDIUM: LandXML fills in 375 mm, 600 x 600 and STORMPRO SN12 and marks the size as from the file.
9. **HUNT2-C-09** MEDIUM: LandXML writes the sump level as IL.
10. **HUNT2-C-10** MEDIUM: CDRULES "Assumed roughness" warning on every pipe even when confirmed.
11. **HUNT2-C-11** MEDIUM: Boyd's storage silently capped at the last storm row (30 min CDCALC, 180 min CDDESIGN).
12. **HUNT2-C-12** LOW: CDTWL pipe storage pit centre to pit centre; 0.5 per cent tolerance in code.
13. **HUNT2-C-13** LOW: two freeboard settings; CDRULES prints one it never checks.
14. **HUNT2-C-14** LOW: "Inner-metro site" sentence on every no-detention design.
15. **HUNT2-C-15** LOW: LandXML size units not read.

Count: 1 HIGH, 10 MEDIUM, 4 LOW. Code reading only; none seen in AutoCAD; none Codex-tested; none Tim-accepted.
