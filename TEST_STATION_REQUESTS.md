# Test Station requests — written ONLY by the release chat on Tim's PC

The Test Station (Tim's VM) reads this; it writes its answers in `TEST_STATION_RESULTS.md`. Set-up and rules:
`04_REFERENCE/TEST_STATION_SETUP.md`. Newest request first.

## R-004 — make the VM's AutoCAD match Tim's: his AutoCAD 2027 setup and his CE settings (24 Sep 2026, 17:10)

**Why:** Tim (24 Sep, verbatim): *"NEED TO TELL THE OTHER VM CHAT THAT ITS GOT THE OLD VERSION OF CD AND THAT IT NEEDS TO INSTALL MY SETUP OF AUTOCAD 2027."* The VM shows the older CD window because a fresh CE install has the one-page window switched off (`editors.workshopLayout`); Tim's PC has it on. Tim's standing rule: colleagues, and so the Test Station, get exactly his setup.

**Inputs** (in `CE_TEST_STATION\inputs\`):
1. `AutoCAD 2027 - English_cust_settings.zip` (6.7 MB): Tim's AutoCAD settings export (profile, support folder, fonts; 3,098 files). It contains **no CE plugins**, so it cannot overwrite the CE version installed on the VM.
2. `TIM_CE_SETTINGS_2026-09-24\TIM_CE_CADTOOLS\`: Tim's five CE settings files: `CD_Settings.json` (holds the one-page CD switch and his CE options), `CS_Settings.json`, `label_styles.json`, `parts_catalogue.json`, `theme.json`. Deliberately NOT copied: project records, autosave backups, logs, `install_salt.bin` (per-install identity), `last_version.txt`.

**Steps:**
1. Close AutoCAD on the VM (check `acad.exe` is gone twice, 10 s apart).
2. **Back up first:** copy `%APPDATA%\Autodesk\AutoCAD 2027` and `%APPDATA%\TIM_CE_CADTOOLS` (if present) to `C:\CE_TEST_STATION\backup-before-R004\`.
3. **Import Tim's AutoCAD settings** with Autodesk's own tool: Start menu > AutoCAD 2027 - English > **Import AutoCAD 2027 - English Settings**; choose the zip; import everything it offers. If the tool asks to overwrite, yes (the backup is in step 2).
4. **CE settings:** copy the five files into `%APPDATA%\TIM_CE_CADTOOLS\` (create it if missing).
5. **Check the CE plugins were not touched:** re-hash the three CE bundles against `SHA256SUMS.txt` of the installed payload (R-002). Any difference: stop and report.
6. Start AutoCAD. Check: the CE, CE STRUC and CE Tools tabs load; `CD` then Enter shows the **one-page** window (Engineering and Drafting across the top, a big plan preview below: Tim's reference picture `inputs\CD_NEWPIPE_THE_REFERENCE_tim_2026-09-24.webp`); the status bar shows 3.0.1; answer No to every save.
7. Report in `TEST_STATION_RESULTS.md` (what was imported, anything the import tool refused, the hash check, a screenshot path of the one-page CD window on the VM). Then carry on with R-002 (pass 9) on this setup; any pass 9 results taken before R-004 on window layout are INVALID and must be re-run.
8. **Undo:** close AutoCAD, restore the two folders from `C:\CE_TEST_STATION\backup-before-R004\`.

## R-003 — measure three office drawings, headless and read-only (24 Sep 2026, 13:35)

**Why:** the weld mark (Tim: CE's own tick-run mark, "A"), the base plate family and the CE Blocks palette must copy CE's own drawings, not guesses. Cards: `04_REFERENCE/structural/STRUCTURAL_WELD_MARK_CARD_2026-09-24.md`, `04_REFERENCE/structural/STRUCTURAL_STEEL_CONNECTIONS_WELDS_CARD_DRAFT_2026-09-24.md`, `04_REFERENCE/TOOL_PALETTES_PROPOSAL_2026-09-24.md`.
**Inputs** (copies of office standards, no client data): `CE_TEST_STATION\inputs\` `WELD_SOURCE_steel_details.dwg`, `CE_Base_Plate_Details.dwg`, `CE_TYPICAL_BLOCKS.dwg`.
**How:** AutoCAD 2027 `accoreconsole.exe` on the VM with a script and LISP you write; open each drawing read-only; **never save**; no CE plugin needed. Can run while Codex is between steps (it is a separate, headless process).
1. **WELD VERT and WELD HORIZ** block definitions: every entity (type, layer, colour, linetype, lineweight, start/end points), the base point, overall length and height, tick length, tick spacing and tick angle to the run line, and whether the ticks sit on one side of the line or across it. Whether the blocks are annotative or scaled.
2. **CE_Base_Plate_Details.dwg:** layers (name, colour, linetype, lineweight); text styles (name, font, height, width factor); dimension styles in use; block names used (with counts); every MText/Text content as plain text grouped by detail title (e.g. "VIEW A-A SCALE 1:10"), with its layer and height; hatch patterns and scales; the extents of each detail.
3. **CE_TYPICAL_BLOCKS.dwg:** every block definition name with its extents, the layers its contents use, whether it is annotative, and its attribute tags. Also the drawing's layers (name, colour, linetype, lineweight).
4. Write the results to `C:\CE_TEST_STATION\evidence\R-003\` and a **short summary** (the weld numbers in full; counts and names for the rest) in `TEST_STATION_RESULTS.md`. These are office standards, not client drawings, but still no screenshots in CE_PLAN.

## R-002 — install tonight's candidate and run pass 9 (24 Sep 2026, 13:10)

**Payload:** `CE_TEST_STATION\payloads\0924-civil-7d85c40f-struc-488f6250\` (three bundles + `SHA256SUMS.txt`, 1,542 files; the release chat re-hashed the OneDrive copy at 13:08: 0 mismatches). It is a **candidate** built from the release trains, not yet on master. If it holds, Tim's PC gets the same bytes tonight.
**S1 gate — expected, exactly:**
1. Civil, all three lanes (Legacy, Net8, Modern): `3.0.1+7d85c40f7908b45f6d07343f6520477529628d14`
2. Manager: `1.1.1+7d85c40f7908b45f6d07343f6520477529628d14` (its CE_SHARED.dll identical to Civil's in every lane)
3. Structural: `1.0.75+488f6250445206c754d51e71d1f8cdcc00b65d44` (Modern has `CE_STRUC_NATIVE_2027.arx`; no CE_SHARED.dll)

**Steps:**
1. Copy `CE_TEST_STATION\test-copies\` to `C:\CE_TEST_STATION\test-copies\` (local, so AutoCAD's lock files never sync). Work on fresh copies of the base drawings `DWG-A.dwg`, `DWG-B.dwg`, `DWG-S.dwg` named `*_P9.dwg`. Drawings by label only.
2. Install by REL-09 (first install on the VM: nothing to rename). Check every hash against `SHA256SUMS.txt`, read the versions back, compare with the S1 gate. Any difference: stop and report.
3. **Codex pass 9** (`gpt-6-astra`, effort low; one run at a time). Rules: `C:\CE_PLAN\archive\chat-records-2026-09\CODEX_TEST_RUN_2026-09-23_RELEASE.md` section 1, **with these VM changes:** rule 1 path = `C:\CE_TEST_STATION\test-copies`; rule 2 = labels only (the drawing list stays on Tim's PC); rule 10 = the VM runs at any hour; rules 13 (never F2) and 14 (never save a template, profile or setting; No to every save) still apply. Part S with the S1 gate above. Then:
   - **Re-tests from pass 8 and earlier:** C7 fixes (split, grip, double-click, tidy-up, CDRG); Undo R-A-4 then R-A-5, Z4 (Edit Pipe) and X3 (Edit Pit); BUG-159 (a plain rectangle keeps AutoCAD's own grips and hover menu; CE pipes keep CE grips); BUG-168 (CDGRIPDIAG F12 list: clicking Off turns it off); every pass 8 window FAIL (Z2 to Z11).
   - **Each PR's "Tim's AutoCAD checklist" in `REGRESSION_LOG.md`** (read it from `origin/release/civil-train-0924` and `origin/release/struc-train-0924`): Civil #151 (U1 one U, U2 tabbed PIT / Edit Pit, U3 Edit Pipe), #157 (window wording), #155 (keyword shortcuts), #156 (speed fixes), #162 (import windows: X-Civil, LandXML, survey), #160 (fit check: older drawings show one quiet line), #164 (versions), plus CDDESIGN / CDRAINFALL / CDLPD windows (#146, #149; never installed anywhere yet). Structural #158 (keyword shortcuts), #159 (windows), #161 (Line styles panel, 21 buttons, layers 25CONT to 70PHANTOM), #163 (RC, strip footings and CML return to your layer and repeat with Enter), #165 (version).
4. **Performance Parts 2 and 3** exactly as `docs/perf/PERF_AUDIT_2026-09-24.md` specifies (on `origin/release/civil-train-0924`): the timed pass on the largest drawing copy, then the one-hour soak.
5. **Usage:** Codex weekly must stay under **14% today** (Thursday line 15%; 5% at 13:00). If it reaches 14%, stop, save the partial report, and carry on tomorrow (Friday line 28%). Record usage before and after each run.
6. Results in `TEST_STATION_RESULTS.md`, four words per step and four counts per part, evidence on the VM. Say what was not tested.

## R-001 — set up and prove the station (24 Sep 2026)

1. Do the one-time set-up check (setup file section 3). Change nothing; report present / missing to Tim.
2. Ask Tim the authority question (section 4) and record his answer.
3. **Wait for R-002.** It will name tonight's payload (Civil 3.0.1, Manager 1.1.1, Structural 1.0.75 with its
   commit), placed in `CE_TEST_STATION\payloads\` by the release chat after Tim closes AutoCAD on his PC.
