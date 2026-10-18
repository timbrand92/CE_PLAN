# HUNT — Civil schedules, details, notes, QA and repair (areas L and M)

**Job:** headless hunt, desk plan/03, read-only code audit. **Written:** Sun 18 Oct 2026 (Melbourne). The file name keeps the date the job was given (12 Oct).
**Code audited:** the installed lineage, `origin/claude/rel-20261018d` @ `70a4e24f` "Version: Civil 3.0.55 / Manager 1.1.55 (C-44)". It was read in a private worktree at `C:\ce-hunt\civil-lm`, removed at the end. I did not read master.
**Method:** five parallel readers, one each for: Pit Schedule build and text; Pit Schedule update and Xref; Checks and QA; CDREPAIR and the repair commands; legacy migration with details, notes and X-Civil schedule import. Each reader was told to skip anything already in `BUG_CARPARK.md` (up to BUG-755) or in the `areas\*HUNT*`, `*AUDIT*` and `*R00*` files. The controller (I) re-read the code for the top findings myself. Two were corrected as a result, marked "controller check" below.
**Not done:** nothing was built or run, nothing was opened in AutoCAD, and no BUG numbers were filed (the controller files them). Every finding below is **found by reading only**. None is built, tested, installed or Tim-accepted.
**Paths** are relative to `Modules\Drainage\` unless they say otherwise.

---

## The 10 worst, in plain English

1. **Moving the drawn Pit Schedule changes the pits and pipes underneath (HUNT-LM-43).** If a cell shows a value typed in the Pit Schedule window (say cover 21.50 where the real cover is 21.00), a MOVE or STRETCH of the table writes 21.50 into P3's real cover and rewrites the plan label, with no message. It does the same for diameters and inverts.
2. **Pit Schedule puts the wrong pipe on an inlet row (HUNT-LM-01).** When two downpipes come into a pit at the same level, CE merges them into one "DPs" row. Every inlet row after that then picks up the pipe that belonged to the row above. Example: P4's 375 pipe vanishes from the table, its row shows DP2's 100 dia and level, and typing on that row edits DP2. Two readers found this independently.
3. **Importing a consultant's PDF schedule can give pits their neighbour's cover level and size (HUNT-LM-02).** When the pit-number column reads blank, CE pairs rows with pits in number order. If one row is thrown out, or the consultant used a different order, every later pit gets the next pit's values.
4. **Recalculating levels overwrites a level the drafter typed by hand (HUNT-LM-03).** This happens on any pipe drawn from its low end. CE protects the wrong end, so the typed level is replaced and the protected end leaves a step. The summary still says the hand level was kept.
5. **A cell blanked with "Delete cell" comes back as the word "DELETE" on the drawing (HUNT-LM-44).** It is blank when first placed, but after the next PITEDIT, or anything that refreshes the table, the cover cell reads "DELETE". CDDESIGN's redesign Apply then refuses with "edited directly or out of date".
6. **The FROM column on the Pit Schedule cuts the number off pits not named P-number (HUNT-LM-04).** An upstream pit C1, CP3 or SPS1 prints as "C", "CP" or "SPS". Two of them at the same level merge into "Cs", and one disappears.
7. **The depth on the drawn schedule changes after the next edit (HUNT-LM-17).** The refresh after each command works depth out differently from the window that drew it. Example: a pump station placed at 3.20 deep flips to 0.70. A pit whose outlet has no level yet loses its depth, an end pit's depth never updates, and step irons use a fixed 0.90 m, not the Settings value.
8. **The saved row order breaks a pit's rows apart once a pipe is added (HUNT-LM-05).** Add a new inlet to P5 on a placed schedule and reopen PITSCHEDULE. The new row drops to the very bottom with no pit number, so on the drawing it reads as an inlet of the last pit.
9. **Two Xref drawings made by SAVEAS from each other become one schedule source (HUNT-LM-45).** Example: Xref Stage 1 and Stage 2 into a sheet and run PITSCHEDULE. Stage 2's pits silently drop out, because both drawings carry the same internal fingerprint. (PLAUSIBLE: it depends on AutoCAD keeping the fingerprint on SAVEAS, which the team's own notes say it does.)
10. **The Recover Inverts button never redraws missing level text (HUNT-LM-06).** It saves the levels first, then asks "is there level text already?". The answer counts the levels it just saved, so it replies "already had invert text, 0 written" and nothing appears.

Next tier, all MEDIUM to MEDIUM-HIGH:
1. **A typed cover level moves to another row** when a lower inlet is added (LM-07).
2. **Level recalculation ignores a locked pipe layer** (LM-08).
3. **Every drawing opened is checked for blocks named "PIT BLOCK" or "PIT BLOCK 2"**, even a consultant's, and PIT BLOCK 3 is redefined on every open, which probably marks untouched drawings as changed (LM-09).
4. **The Design Review ignores office Settings** (LM-10).
5. **The Pit Schedule window marks Pit Size as overridden on every edit**, so a later PITEDIT resize never shows (LM-46).
6. **Typed cells take the first number they find**: "21,15" becomes 21.00 (LM-47).
7. **"Delete cell" on Remarks prints "DELETE With Step Irons"** (LM-12).
8. **The PDF schedule check says "no issues found" when no PDF was read** (LM-13).
9. **CDXREFREPAIR can point an Xref at the host drawing**, or at a stale copy (LM-14, LM-15).
10. **Four Repair Center buttons change the drawing with no preview** (LM-16).

---

## A. Pit Schedule: building and printing the table

### HUNT-LM-01 — merged inlet rows shift every later inlet onto the wrong pipe
- **Where:** `ViewModels\PitScheduleViewModel.Data.cs:309-326` (current drawing). The same pattern is at `:724-734` (Xref rows) and `Services\NetworkRedesignScheduleReviewService.cs:133-151`. `PitScheduleBuilder.ConsolidateInletsByLabelAndInvert` drops the duplicates, then the shorter label list is paired with `inletPipes` by position (`consolidatedInlets.Add((inletPipes[inletIdx2], consolidatedLabel)); inletIdx2++;`).
- **Trigger:** PITSCHEDULE on pit P5 with inlets sorted by invert: P3 19.40, DP1 19.60, DP2 19.60, AG1 19.90.
- **Wrong:** the rows read P3, "DPs" (DP1's pipe), then "AG" with DP2's diameter and IL 19.60. The real AG pipe is missing, and the AG row's link handle points at DP2, so an edit on that row writes to DP2.
- **Right:** P3, DPs, then AG with its own diameter and IL 19.90.
- **Severity:** HIGH (wrong figures on the drawing, plus edits written to the wrong pipe). **Confidence:** CONFIRMED (controller re-read it).
- **Fix idea:** have the merge return the source-pipe index for each kept entry, and map by that index.
- **RED test:** yes, after pulling the inline mapping into one pure helper (for example `PitScheduleBuilder.ConsolidateInlets(pipes, …)`), which also gives the three copies a single code path (design rule #1).

### HUNT-LM-04 — FROM column strips the number off pits not named P-digits
- **Where:** `Services\PitScheduleBuilder.cs:209-217` (`StripSourceTagNumber`): `if (Regex.IsMatch(cleaned, @"^P\d+$")) return cleaned; … Regex.Replace(cleaned, @"\d+$", "")`. It is reached from `BuildInletFromDisplay` (`:151`) even when the other end is a real registered pit; the comment says so on purpose ("even if the ID happens to match a registered pit"). The merge exemption at `:248-249` also only spares `^P\d+$`. The drawn-cell refresh uses the same path (`Services\ScheduleLinkService.cs:2548`).
- **Trigger:** an upstream pit numbered C1, CP3 or SPS1, or an X-Civil ID such as GP4.
- **Wrong:** FROM reads "C", "CP" or "GP". Two such inlets at the same IL merge into "Cs" and one row is dropped, which LM-01 then makes worse.
- **Right:** "C1".
- **Severity:** HIGH (wrong text on the drawing). **Confidence:** CONFIRMED (controller re-read it).
- **Fix idea:** strip only when the ID is a source-block tag (DP, OF, FO, IO, AGI and so on, decided by the pit's type), never because of the prefix.
- **RED test:** yes: `BuildInletFromDisplay` with a pit C1 of type "Standard" should return "C1".

### HUNT-LM-05 — saved row order splits a pit's rows once a pipe is added
- **Where:** `ViewModels\PitScheduleViewModel.Data.cs:859-930` (`ApplyPersistedSortOrder`), keyed by `BuildLinkedOverrideKey` (`ViewModels\PitScheduleViewModel.Schedule.cs:651-661`), which is pit + inlet pipe + outlet pipe + set. A row with no saved key gets `int.MaxValue`, and the map only counts as stale below 90 % coverage. `PersistManualRows` saves the map on Place, Export CSV/Excel and every edit.
- **Trigger:** place a schedule of 10 or more rows, add a second inlet pipe to P5, and reopen PITSCHEDULE (coverage is now about 95 %).
- **Wrong:** P5's new row goes to the very end with a blank pit number, so the drawn table shows it as an inlet of the last pit. If the new inlet is the lowest, P5's primary row moves to the bottom instead. A renamed pit also keeps its old position, which breaks the "rows auto-sort on open" rule (BUG-008).
- **Right:** a pit's rows stay together, in invert order.
- **Severity:** HIGH (misattributed row on the drawn table). **Confidence:** CONFIRMED.
- **Fix idea:** apply saved order at pit-group level (pit handle + set), not per row.
- **RED test:** yes, once the ordering step is a pure function of (rows, map).

### HUNT-LM-07 — overrides on pit-level cells are saved per row and slide to another row
- **Where:** `ViewModels\PitScheduleViewModel.Schedule.cs:450-586` (`BuildLinkedOverrideMap` / `ApplyLinkedOverride`, same pit + inlet + outlet key). `TrackOverriddenField` is at `ViewModels\PitScheduleViewModel.Data.cs:1112-1158`.
- **Trigger:** type cover 20.95 on P5's row, then add an inlet with a lower invert.
- **Wrong:** the override lands on the second row. Cover is drawn only on the first row of a group, so 20.95 disappears from the table and the Review. `UpdateDepth` then prints a depth (20.95 minus the inlet IL) on the inlet row, because depth is drawn on every row (`Schedule.cs:1739-1741`). Changing the outlet pipe orphans every override on that pit.
- **Severity:** MEDIUM-HIGH (a typed value lost from the drawing, plus a stray figure). **Confidence:** CONFIRMED.
- **Fix idea:** key pit-level fields (pit number, size, cover, lid, remarks, depth, outlet) by pit + set, and inlet fields by pit + inlet pipe.
- **RED test:** yes, `ApplyLinkedOverride` with a map keyed to the old inlet, after extracting it.

### HUNT-LM-11 — a pit running over a sheet break starts the next sheet with no pit number
- **Where:** `Services\PitScheduleContinuationLayout.cs:116` forces "first in group" when `rowInSet == 0`. But rows are built with `PitNo = isPrimaryRow ? pit.Id : string.Empty`, and the same for cover, size, outlet diameter and outlet IL (`ViewModels\PitScheduleViewModel.Data.cs:362, 374`). That contradicts the comment at `Schedule.cs:1689` ("blanked at render time, not stored").
- **Trigger:** 20 rows per sheet, with P12's two rows falling at rows 20 and 21.
- **Wrong:** sheet 2 starts with FROM, diameter, IL and remarks, but blank pit number, size, outlet and cover. **Right:** "P12" and its pit columns repeated.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Fix idea:** store pit fields on every row and blank them only in `FormatColumnText`.
- **RED test:** yes, through the placement helper (two rows, rows-per-sheet 1, second sheet's first cell should be "P12").

### HUNT-LM-12 — "Delete cell" on a deep pit's Remarks prints "DELETE With Step Irons"
- **Where:** `ViewModels\PitScheduleViewModel.Filters.cs:29-58`: `ApplyDepthRemark` appends the step-iron wording to `BaseRemarks`, which holds the token "DELETE". `NormalizeCellForExport` (`Data.cs:1522-1528`) only blanks an exact "DELETE".
- **Trigger:** a pit 1.2 m deep. Right-click its Remarks and choose Delete cell, then place or update.
- **Wrong:** the drawn cell reads "… DELETE With Step Irons", and it reloads that way. **Right:** "With Step Irons" only, or blank, as Tim intends.
- **Severity:** MEDIUM (wrong text on the drawing). **Confidence:** CONFIRMED.
- **Fix idea:** treat a "DELETE" base as empty in `ApplyDepthRemark` and `CompactRemarksLine`.
- **RED test:** yes.

### HUNT-LM-17 — the refresh after each command works depth out differently from the window that drew it
- **Where:** `Services\ScheduleLinkService.cs:2598-2610` (`BuildDepthText` = cover − outlet) and `:2786` (`(cover - lowestInvert) > 0.90 + 1e-6`). The window and placement use the larger of cover − inlet and cover − outlet for SPS rows (`ViewModels\PitScheduleViewModel.Data.cs:2107-2117`), and the step-iron depth from Settings.
- **Trigger:** SPS cover 10.50, gravity inlet 9.00, rising main outlet 10.00. The placed depth is 1.50; after any command that touches the pit, the drawn cell becomes 0.50. Or set the step-iron depth in Settings to 1200 mm: a 1.00 m pit gets "With Step Irons" added on refresh.
- **Also, from the update reader:**
  1. **No outlet level yet:** `BuildDepthText` returns "" rather than null, so the depth worked out from the inlet is blanked.
  2. **End pit with no outlet:** the depth cell is registered with no link (`Schedule.cs:1638-1640`), so after a PITEDIT cover change the cover cell updates and the depth stays stale, with no message.
  3. **Pump stations:** CDDESIGN redesign Apply's preflight refuses on these rows.
- **Severity:** HIGH (a drawn figure changes to a wrong value after an unrelated edit). **Confidence:** CONFIRMED by two readers working separately.
- **Status:** this is the part of the R00 step-iron fix (items 7/8) that never reached the after-command refresh path. File it as a re-open or child of that bug, not as a new family.
- **Fix idea:** one depth function, using `PitScheduleDepthRule.StepIronDepthMetres`, shared by both paths.
- **RED test:** yes, `BuildDepthText` against the window rule for an SPS pit.

### HUNT-LM-18 — depth or level can print "-0.00" on AutoCAD 2025 and later
- **Where:** `ViewModels\PitScheduleViewModel.Data.cs:2122/2126`, `Schedule.cs:1765`, `Services\PitScheduleLevelText.cs:27`.
- **Trigger:** cover 18.50 with outlet 18.504. Newer .NET (the 2025+ runtime) prints "-0.00"; the 2024 runtime prints "0.00". The reader checked both runtimes in pwsh.
- **Severity:** LOW. **Confidence:** CONFIRMED.
- **Fix idea:** turn −0 into 0 after rounding.
- **RED test:** yes, `PitScheduleLevelText.Format(-0.004, 2)` should be "0.00" (RED on net10).
- **Related, outside this slice:** "F2" formatting on net10 rounds half to even (1.125 → "1.12"), unlike the locked "0.00" away-from-zero rule. `Rules\PipeEndClassification.cs:231` (`FormatInvert`) uses it; worth a separate look.

### HUNT-LM-19 — "outlet smaller than inlet" warning only checks the lowest inlet
- **Where:** `ViewModels\PitScheduleViewModel.Data.cs:2189-2212`.
- **Trigger:** inlets 300 (lowest) and 375 (higher), outlet 300. **Wrong:** no warning.
- **Severity:** LOW. **Confidence:** CONFIRMED.
- **Fix idea:** compare the outlet against the largest inlet in the pit's group.
- **RED test:** yes, after extracting the check.

**Checked and sound (schedule build):** the continuation-layout arithmetic; natural sort for P and CP (P2 before P10, P1A after P1); invariant-culture invert parsing; "0.00" formatting; row-identity uniqueness; set and system output scope; the grade note (integer denominator, no MIN./MAX.). With natural order off (the default), non-P/CP pits sort as plain text (C10 before C2); that is a setting, not filed.

---

## B. Pit Schedule: updating, editing and Xref

**Sound:** the Xref watcher (it unsubscribes on document close and on drawing switch, and each check is tied to its request), the scoped refresh index, the update guard, the difference service, and the size and depth edit planners. This reader also found the inlet-merge fault (LM-01, `NetworkRedesignScheduleReviewService.cs:146-151`); it is not filed twice. Its depth-refresh finding is merged into LM-17.

### HUNT-LM-43 — moving the drawn schedule writes its cell text back into the pit and pipe records
- **Where:** `Services\ScheduleLinkService.cs:226-332` (`TryHandleEditedCell`). MOVE, STRETCH or a grip edit queues every changed CE MText (`LinkService.Reactors.cs`), so each moved cell passes through here. Only the pit-number case checks whether the cell still shows CE's own text (`TypedPitIdFromCell(text, BuildCellText(...))`). The cover case (`if (TryParseLevelNumber(text, out double cover)) … if (!string.Equals(pit.CoverLevel, coverText)) UpdatePitCoverByHandle(...)`), the diameter case and the invert case write whenever the cell differs from the record.
- **Trigger:** in PITSCHEDULE, override P3's cover to 21.50 (real 21.00), or an inlet diameter to 375 (real 300). Close the window and MOVE the whole table.
- **Wrong:** P3's real cover becomes 21.50 and its plan label is rewritten, or the pipe becomes 375 mm, with no message. A cover stored as 21.125 is quietly rounded to 21.13. A row left as drawn after a pipe changed direction pushes its old level into the pipe. Typing into an overridden cell changes the record while the refresh puts the override text back, so the drafter sees nothing change but the plan has changed.
- **Right:** a move changes no record. Typing into an overridden cell either clears the override or is refused with a message.
- **Severity:** HIGH (silent change to design levels and sizes). **Confidence:** CONFIRMED. The controller re-read the handler; the reader traced the reactor queueing.
- **Fix idea:** do nothing when the cell text equals `BuildCellText(linkData, Current)` or the field is overridden, which is the rule the pit-number case already follows.
- **RED test:** after extracting a pure "should this cell change the record?" decision.

### HUNT-LM-44 — an intentional blank (DELETE) shows as the word "DELETE" after the linked refresh
- **Where:** `Services\ScheduleLinkService.cs:1887-1932` (for example `if (IsOverridden(ovr, nameof(PitScheduleRow.Cover))) return ovr.Cover ?? string.Empty;`); lid text at `:2496`. The window keeps the literal "DELETE" token on purpose (`PitScheduleViewModel.Schedule.cs:644`). Placement blanks it through `NormalizeCellForExport`; the refresh path does not.
- **Trigger:** PITSCHEDULE, right-click P3 Cover, Delete cell, then place. Next, PITEDIT P3 or run any command that refreshes the schedule.
- **Wrong:** the cover cell reads "DELETE" (the lid cell would read "Delete"). CDDESIGN redesign Apply's preflight (`TryValidateScheduleCellText`, `""` vs `"DELETE"`) then refuses with "edited directly or out of date". **Right:** blank.
- **Severity:** HIGH (wrong text on the drawing, and it blocks real work). **Confidence:** CONFIRMED.
- **Fix idea:** map the DELETE token to blank inside `BuildCellText`.
- **RED test:** yes: `RefreshLinkedCellFromRecord` with a `ManualScheduleRows` override Cover="DELETE".

### HUNT-LM-45 — two Xrefs that are SAVEAS copies of each other merge into one source
- **Where:** `Services\PitScheduleXrefDiscoveryCore.cs:56` groups sources by `DrawingIdentity` (the drawing fingerprint). `Services\PitScheduleXrefDiscoveryService.cs:394-398` caches each project record by that fingerprint, so the second record is never read. Source selection and the duplicate-pit check also key on it. The team's own note in `NewSkipReport`, and the #430 review, say a SAVEAS copy keeps its fingerprint.
- **Trigger:** Xref DRAIN_STAGE1.dwg and DRAIN_STAGE2.dwg (Stage 2 made by SAVEAS from Stage 1) into a sheet, then run PITSCHEDULE.
- **Wrong:** one source is listed, carrying Stage 1's data. Stage 2's pits are missing, and pit numbers duplicated across the two are not flagged. **Right:** two sources, or a refusal that names the clash.
- **Severity:** HIGH (pits silently missing from the schedule). **Confidence:** PLAUSIBLE (it depends on the fingerprint surviving SAVEAS).
- **Fix idea:** identity = fingerprint + resolved file path, or refuse when two loaded Xrefs share a fingerprint.
- **RED test:** yes: `PitScheduleXrefDiscoveryCore.Discover` with two probes sharing a fingerprint but carrying different JSON.

### HUNT-LM-46 — the Pit Schedule window marks Pit Size, and untouched cells, as overridden on every commit
- **Where:** `Dialogs\PitScheduleDialog.xaml.cs:218` `row.OverriddenFields.Add(propertyName);` runs on every committed edit. That includes pit size (BUG-193 says size must never be an override) and F2-then-Enter with no change.
- **Trigger:** on a row already overriding cover, type size 900 x 900 (the pit resizes). Later, PITEDIT P3 to 1200 x 1200.
- **Wrong:** the window and the drawn table keep showing 900 x 900 (`Schedule.cs:555`, `ScheduleLinkService.cs:1891`). Review and Update is then blocked with "display override has no accepted linked-value evidence" (`PitScheduleDifferenceService.cs:471-488`). **Right:** 1200 x 1200.
- **Severity:** MEDIUM-HIGH. **Confidence:** CONFIRMED.
- **Fix idea:** skip PitSize, add a field only when its value actually changed, and leave tracking to `TrackOverriddenField`.
- **RED test:** no (window code-behind).

### HUNT-LM-47 — typed level and diameter cells take the first number found
- **Where:** `Services\ScheduleLinkService.cs:3290`, a regex that takes the first number anywhere in the cell.
- **Wrong:** "21,15" (a comma typo) becomes cover 21.00. Formatted MText with a height code, "{\H0.7x;21.15}", becomes 0.70. "2/375" in a diameter cell becomes a 2 mm pipe. **Right:** refuse anything that is not one clean number, with a message (as `TypedPitIdFromCell` already does).
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **RED test:** yes, once `TryParseLevelNumber` is made internal.

### HUNT-LM-48 — CDDESIGN redesign Apply writes depth on a different basis
- **Where:** `Services\NetworkRedesignScheduleReviewService.cs:155-157, 1012-1031`: depth = cover − `pit.InvertLevel`, at 3 decimals. The schedule's rule is cover − outlet invert (else inlet).
- **Wrong:** a pit with a sump shows a deeper depth, and a pit with no stored bottom level shows a blank depth. The next refresh flips the cell to the other rule, so the stored baseline disagrees and gives false OUT OF DATE results.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **Fix idea:** the same shared depth rule as LM-17.

### HUNT-LM-49 — an unloaded source Xref is reported as missing
- **Where:** discovery stores the loaded drawing's full path (`PitScheduleXrefDiscoveryService.cs:273`), but when unloaded it uses the saved path (`:291`), often relative. `PitScheduleStatusService.cs:104, 301-305` resolves that against AutoCAD's current folder, not the host drawing's folder. The same relative-path problem can group two different unloaded nested Xrefs into one row (`DiscoveryCore.cs:172`).
- **Trigger:** a relative-path Civil Xref. Place a linked schedule, XUNLOAD it, then reopen PITSCHEDULE.
- **Wrong:** "SOURCE MISSING: the linked source could not be found". **Right:** "SOURCE UNLOADED: load X".
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.
- **RED test:** yes: `PitScheduleStatusService.Evaluate`.

### Smaller update and Xref findings
1. **HUNT-LM-50, LOW-MEDIUM:** text typed into a Depth, Pit Size, FROM or Lid/Remarks cell of the drawn table is silently ignored, because `TryHandleEditedCell`'s switch has no default case (`ScheduleLinkService.cs:226-337`). The next refresh then silently overwrites it. Fix: put the cell back and say "edit this in PITSCHEDULE or PITEDIT". CONFIRMED.
2. **HUNT-LM-51, LOW:** new pits from redesign Apply sort to the bottom (`int.MaxValue`, `NetworkRedesignScheduleReviewService.cs:886-905`), so P2A comes after P10. PLAUSIBLE.
3. **HUNT-LM-52, LOW:** a copied CE_PUMP_PIT block with the same LABEL is skipped, and any exception returns a partial pump-pit list with only a log line (`Services\PumpPitScheduleReader.cs:212-213`). CONFIRMED.

---

## C. Checks and QA

### HUNT-LM-10 — Design Review ignores office Settings except pipe roughness
- **Where:** `Services\DesignReviewService.cs:33` uses `standards ?? DesignValidationService.WithLiveRoughness(new DesignStandards())`. `WithLiveRoughness` (`DesignValidationService.cs:195-204`) copies only Manning's n. The callers that pass no standards are `Commands\DashboardCommands.cs:73`, `ViewModels\DesignCheckDashboardViewModel.cs:220`, `Services\ConsultantDwgCheckService.cs:152`, `Services\XcivilImportService.cs:1499` and `AI\ReviewDesignTool.cs:51`. The pit-fit section of the same dashboard does read `SettingsService.Current.DesignStandards` (`:223-224`).
- **Trigger:** change the maximum velocity or minimum grade in Settings, then run CDDASHBOARD or CDCHECKDWG.
- **Wrong:** the verdicts use code defaults for minimum grade, minimum and maximum velocity, maximum run length and reverse-fall tolerance. **Right:** the office's values, as Edit Pipe and CDCALC use.
- **Severity:** MEDIUM-HIGH (wrong engineering verdict). **Confidence:** CONFIRMED.
- **Fix idea:** default to `SettingsService.Current.DesignStandards` (or the rulebook values).
- **RED test:** yes, with a Settings stub.

### HUNT-LM-13 — PDF schedule check says "no issues found" when no PDF was read
- **Where:** `Services\PdfScheduleSanityService.cs:103-106` (a null document gives an empty result), `:425-428` and `:448-452`. `XcivilScheduleService.cs:163-164` clears the document on each import and only sets it once the extractor's JSON exists (`:287-294`). `XcivilImportService.cs:831-833` and `:1428-1430` run the check regardless.
- **Trigger:** CDIMPORTXCIVIL where the PDF extractor fails ("JSON output was not created"), or where no PDF is given.
- **Wrong:** "PDF schedule sanity: no issues found." **Right:** "PDF schedule not read: (reason). Not checked."
- **Severity:** MEDIUM (a false pass). **Confidence:** CONFIRMED.
- **RED test:** yes: `BuildPreflightLines(CheckSchedule(null))`.

### HUNT-LM-20 — CDCHECKDWG says "checked 12" for pipes whose grade and velocity were never checked
- **Where:** `Services\DesignReviewService.cs:64` counts a pipe as checked once it has a diameter. `DesignValidationService.ValidatePipe` (`:56-66`) skips the reverse-fall, grade, velocity and outlet-speed checks without both inverts (velocity also needs length > 0). The summary line is at `Services\ConsultantDwgCheckService.cs:200-201`.
- **Controller check:** the reader called this HIGH ("No project data QA issues found" printed). That is **not right for blank inverts**: `ProjectDataSanityService.CheckPipeInverts` (`:182-210`) raises MISSING_PIPE_INVERT, which stops the "no issues" line. What remains true: the "checked N" count includes pipes that got no hydraulic check, and a pipe with inverts but zero length gets no velocity check with no mention. There is also no cover check in this review, and nothing says so.
- **Severity:** LOW-MEDIUM. **Confidence:** CONFIRMED (corrected).
- **Fix idea:** count a pipe as checked only when grade and velocity actually ran; list the others as skipped with the reason; state that cover is not part of this check.

### HUNT-LM-21 — Checks palette shows "Network OK" when a source failed to read
- **Where:** `Services\Checks\ChecksResultReader.cs:156-160`. If rule findings throw, findings become empty and the failure only goes to the CE log; the same happens at `:93-96` (open ends) and `:131-134` (FALL arrows). `PitRecordUnreadable` never becomes a row, and `NetworkOkLine` (`ChecksResult.cs:151-156`) looks only at rows.
- **Wrong:** "0 to look at · 185 OK" plus green "Network OK". **Right:** one "CE could not check" row per source that failed.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE (it needs a read failure to trigger).
- **RED test:** yes: `ChecksResult.Build` with empty findings and a failure flag.

### HUNT-LM-22 — automatic Project QA is not marked stale by CE's own edits
- **Where:** `Services\CivilProjectQaAutomaticService.cs:677-690`. The "affects output" command list is native AutoCAD commands only; PIT, CD, PITEDIT, CDEDIT, schedule writes and CDRULES fixes are missing. `OnCommandWillStart` (`:261-269`) resets only a capture that is still in progress.
- **Trigger:** open a final drawing and wait about 3 s for QA7. PITEDIT a cover level, don't save, then issue sheets. `Modules\Structural\Services\CeSheetsIssueCoordinator.cs:971-988` records QA7 as "Current" from the old capture.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.
- **Fix idea:** call `MarkAffected` wherever the project record is written.
- **RED test:** yes: `AffectsRecordedOutput("PITEDIT")` returns false.

### HUNT-LM-23 — an ignored cover finding stays hidden when the cover gets worse (latent)
- **Where:** `Services\Checks\IgnoredChecks.cs:204-221, 249-260`. The fingerprint takes only the pipe's facts and the rule value, not the end pits' cover levels. The fallback compares `row.Subject` ("P3→P4 upstream") with the internal `pipe.Id`, which never matches.
- **Trigger, once Ignore is wired:** ignore "R-04 P3→P4 cover 250 mm", then lower P4's cover level 0.2 m. The finding stays hidden at 50 mm.
- **Status:** nothing writes the ignore list yet (`ProjectDataService.IgnoredChecks.cs:13-15`). Fix before the Ignore button ships.
- **Severity:** MEDIUM (latent). **Confidence:** CONFIRMED by reading.
- **RED test:** yes: `IgnoreFingerprint.ForRow` gives the same hash after the cover level changes.

### Smaller QA findings
1. **HUNT-LM-24, LOW:** CDCHECK "Problems only" counts Possible links differently from the Checks palette (`Commands\SpineCheckCommand.cs:33-38` vs `Services\Checks\ChecksResult.cs:299-309`, whose comment wrongly says they match). Two Possible links show "0 problems" against "2 to look at". CONFIRMED.
2. **HUNT-LM-25, LOW-MEDIUM:** CDCHECKDWG reports CE data it cannot read (corrupt JSON) as "No CE project data found, expected for a raw consultant drawing" (`Commands\CheckDwgCommand.cs:80-91`; `ConsultantDwgCheckService.cs:186-189, 313-316`). CONFIRMED.
3. **HUNT-LM-26, LOW-MEDIUM:** CDIMPORTAUDIT calls `ProjectDataService.SetDrawingPath` (`Commands\LinkCommands.cs:722`), which can save the project record into the drawing (DBMOD, undo entry) when run first in a drawing. CDAUDIT's detached reader avoids this. PLAUSIBLE.
4. **HUNT-LM-27, LOW:** an office minimum cover of 0, blank or negative passes every pipe: `Services\MinimumCoverForChecks.cs:25` `return officeMm ?? AssumedMm;`. CONFIRMED. RED test: `Choose(false, null, 0.0)` returns 0.
5. **HUNT-LM-28, LOW:** closing the What CE Found palette puts back the selection from when it opened, wiping what the drafter has selected since (`Services\DrawingCheckPaletteService.cs:266-275, 296-319`). CONFIRMED.
6. **HUNT-LM-29, LOW:** the "Record pipe ends off pit" setting does nothing: no `PipeEndOffPitLedger` is ever built (`ChecksResultReader.cs:170`). Switching it on shows no rows, which reads as "none". CONFIRMED.

**Checked and sound (QA):** `PitOutletSpeedCheck` thresholds and NaN handling; more than one schedule correctly comes back as a Conflict in `PitScheduleQaService`; `CurrentDrawingCheckService` stays read-only and watches DBMOD; Show where zooms without changing the selection; CDCHECK's numbering matches Show where; `RulebookLevelsCheck` treats unknown levels as Unknown (no caller yet). `HealthCheckCommand` has no registered command (dead code).

---

## D. CDREPAIR and the repair commands

**Sound:** the CDREPAIR window itself (buttons only; Close changes nothing; every button names a real command). CDFIXFLATPIPES is careful: it previews, defaults to No, re-checks the record before writing, refuses locked and Xref pipes, and is one Undo. No new defects were found in CDFIXPIPEENDS, CDFIXTAGS or the stored-link Apply.

### HUNT-LM-03 — a level typed by hand is protected at the wrong end in the level cascade
- **Where:** `Services\LinkService.RepairAudit.InvertPropagation.cs:425-426`: `UpstreamManuallySet = edge.StartIsUpstream ? fromPinned : toPinned`. The pins come from `ReadPinnedPipeEnds` (`:54-66`) as the record's `FromInvertOverrideActive` and `ToInvertOverrideActive`. The record's From is the upstream end (CD writes it that way: `Commands\CdCommand.Schedule.cs:51-72`; `ProposalApplyService.cs:795` says "FromInvert is always the UPSTREAM end"). So mapping through the drawn direction swaps the ends whenever the pipe was drawn from its low end.
- **Trigger:** P1 upstream, P2 downstream, pipe drawn from P2 to P1, 20 m at 1 in 100, P1 end typed by hand as 10.20. Run CDPROPAGATE (or Edit Pipe "Recalculate downstream") with P2 changed from 10.00 to 9.90 and choose Keep.
- **Wrong:** the typed 10.20 is overwritten with 10.10. P2's end is held at the old 10.00, a step against the new 9.90. The summary says the hand level was kept. `RowsFlatWhenWritten` checks the wrong end too, so a pipe that will run backwards can pass the block.
- **Right:** P1 stays at 10.20 and P2's end goes to 9.90.
- **Severity:** HIGH (it overwrites a deliberate level). **Confidence:** CONFIRMED by reading. The controller re-read the mapping and the pin source. It holds as long as record From is always upstream, which is the documented CD rule.
- **Fix idea:** `UpstreamManuallySet = fromPinned; DownstreamManuallySet = toPinned`.
- **RED test:** after pulling out a pure `MapPinnedEnds(edge, pins)`.

### HUNT-LM-06 — CDRECOVERINVERTS never redraws missing invert text
- **Where:** `Commands\LinkCommands.cs:2257-2261` stores the levels on the pipe (`LinkService.StorePipeInverts`). Line 2267 then calls the public `TryGetPipeEndpointInverts`, which runs `ReadPipeEndpointInverts` with `includeStoredFallback = true` (`Services\LinkService.Persistence.cs:25-48, 113-114, 190-200`), so it reads back the values just stored.
- **Trigger:** delete a pipe's IL texts, then press Recover Inverts in the Repair Center.
- **Wrong:** "N already had invert text, 0 invert texts written", and no text appears. **Right:** the IL text is redrawn.
- **Also:** `recoveredCount++` counts pipes on locked layers whose write was quietly skipped.
- **Severity:** MEDIUM-HIGH (the button does nothing visible). **Confidence:** CONFIRMED (controller re-read it).
- **Fix idea:** check for text before storing, or pass `includeStoredFallback: false`.
- **RED test:** not pure; an accoreconsole check would show it.

### HUNT-LM-08 — the level cascade does not respect a locked pipe layer
- **Where:** `InvertPropagation.cs:733` opens the pipe for write and, on a locked layer, quietly opens it read-only. At `:790` the stored-level write is skipped, but the IL labels on an unlocked text layer are rewritten, and the record is updated and counted (`:810`).
- **Trigger:** lock only the pipe layer, then run CDPROPAGATE across that pipe.
- **Wrong:** the labels show the new level while the pipe keeps the old one. The relink in the same transaction then puts the schedule levels back, and the report says "updated". **Right:** refuse that pipe and name it, as CDFIXFLATPIPES does (native protection rule).
- **Severity:** MEDIUM (the drawing disagrees with itself). **Confidence:** CONFIRMED.
- **Fix idea:** check the pipe layer's lock next to `CanWriteIlAttachment` and skip the row.

### HUNT-LM-16 — four Repair Center buttons change the drawing with no preview or Yes/No
- **Where:** CDREBUILD (`Commands\LinkCommands.cs:201-300`, which also runs `RepairStaleClones`), CDREBUILDLINKS (`Commands\HubCommands.cs:636`, rebuilds every pit's pipe list by proximity), CDLINKDANGLINGPIPES (`HubCommands.cs:665`, registers every polyline on a CE pipe layer) and CDRECOVERINVERTS (`LinkCommands.cs:2187`).
- **Wrong:** they write as soon as the button is pressed, breaking the "repair previews and asks first" rule. **Right:** a list plus a Yes/No prompt defaulting to No, like CDFIXFLATPIPES.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.

### HUNT-LM-30 — CDREBUILD treats an original pit as a copy when its stored self-handle is out of date
- **Where:** `Services\LinkService.CloneRepair.cs:93, 113` flags any object whose stored handle differs from its own. `:39-46` then gives the pit a new ID and clears its pipe list, and `:160` clears the pipe's links. It never checks whether this object is the only one carrying that ID. `ExactStoredLinkRepairPlanningService` does check (`DrawingSpineCarrierCount == 1`).
- **Trigger:** a network brought in by WBLOCK, or by INSERT plus EXPLODE, then CDREBUILD.
- **Wrong:** every pit gets a new ID, and the pipe records point at nothing. **Right:** the only carrier keeps its ID and its stored handle is corrected.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.

### HUNT-LM-31 — the cascade writes record From and To by drawn order
- **Where:** `InvertPropagation.cs:793-794` (`string fromStr = row.StartIsUpstream ? newUpStr : newDownStr;`). This is the same root cause as LM-03. The relink usually rewrites the record afterwards, so the error survives only where the direction cannot be proven (an open end, or a typed pit with no block). The mirror image is `ProposalApplyService.cs:807`, which always passes `StartIsUpstream = true`.
- **Severity:** MEDIUM. **Confidence:** PLAUSIBLE.
- **Fix idea:** write the record by flow (From = upstream), and labels and stored levels by drawn order.

### Smaller repair findings
1. **HUNT-LM-32, LOW-MEDIUM:** repair reports count candidates, not successes. CDLINKDANGLINGPIPES returns `toRegister.Count` even when a registration threw (`Relink.cs:278`). CDREBUILDLINKS prints pits + sources + pipes as "registered" (`Relink.cs:225`), and pipes are never registered by that step. CDPROPAGATE's "Min grade" line uses planned levels, not the levels kept (`InvertPropagation.cs:803`). CONFIRMED.
2. **HUNT-LM-33, LOW:** a split-and-rejoin network can leave a step at the rejoining pit. Its outlet can be worked out before its second incoming pipe is recalculated (`InvertPropagation.cs:302-353`), and `HasBlockingFlatGrade` does not catch it. PLAUSIBLE. RED-testable through the pure graph overload of `BuildPropagationPlan`.
3. **HUNT-LM-34, LOW (report only):** CDAUDIT pass C compares `mline.Scale` (drawing units) with the diameter in mm, so every pipe is flagged in a metre drawing (`AuditPasses.cs:163`). Pass B measures pipe end to the pit insertion point against 500 mm, though CE trims pipes to the pit wall, so most pipes at a 1200 pit are flagged (`:102-123`). CONFIRMED.

---

## E. Legacy migration, details, notes and X-Civil schedule import

**Reach check:** these have **no live caller** today: `LegacySplitMigrationService`, `SpsDetailGenerator`, `MasterDetailCaptureService`, `ProfileScheduleRowPreview`, `OrificePitDetailDwgWriter`, `WaterTankDetailGrouping`, and the orifice detail mappers (as DFGH already noted). `DetailSelector` runs inside CDDESIGN, but its list is never shown. **Sound:** `LpdNotePlacement`, `PitDetailsReview`, `LinkService.LegacyCopyLabels`, `MultiLpdAuthorityService.Legacy`, `LegacyDownpipeEvidence`, and `OrificeMinimumNote` (council minimums match the rulebook). The BUG-027 MIN./MAX. suffix is not resurrected anywhere in this slice.

### HUNT-LM-02 — CDIMPORTXCIVIL assigns pit numbers to schedule rows by position
- **Where:** `Services\XcivilScheduleService.cs:308-329` filters out unreadable rows, then `AssignImportedSchedulePitIdsByOrder` (`:395-430`) sorts the drawing's unassigned pit IDs and does `unassignedEntries[index].PitId = orderedPitIds[index]`. The vision path does the same at `Services\XcivilImportService.cs:773`. The only trace is a debug-log line.
- **Trigger:** a PDF schedule whose pit-number column reads blank (the 26612 case), with any row dropped by the size or level check. Or the consultant lists pits in network order (P1, P4, P2 …), or a drawn pit is missing from the schedule.
- **Wrong:** every row after the gap shifts one pit, so P5 gets P6's cover level, size and type. **Right:** leave unnumbered rows unassigned (Unknown, as R-27 says), or allow order pairing only when row count equals pit count and nothing was dropped, with a visible warning.
- **Severity:** HIGH (wrong cover levels and sizes go into the job). **Confidence:** CONFIRMED (controller re-read it).
- **RED test:** yes: `AssignImportedSchedulePitIdsByOrder` with one row filtered out, pits P1–P3, shows the third row mapped to P2.

### HUNT-LM-09 — pit-block migration on open trusts the block name only, and redefines PIT BLOCK 3 every open
- **Where:** `Services\PitBlockMigrationService.cs:205-237` (`Plan` decides by name: `LegacyNames.Where(present.Contains)`), run on Idle after every DocumentActivated (`:150-175`). The only filter is `TryGetNormalProjectDrawing`. `:222` `if (hasTarget) redefine.Add(Target);` re-reads PIT BLOCK 3 geometry from file on every first activation.
- **Controller check:** the reader rated the silent migration HIGH as a broken preview rule. **Automatic migration on open is what Tim asked for** (BUG_CARPARK "PIT BLOCK 3 — force-adoption + elimination of PIT BLOCK 2", 12 Jun 2026), so that part is by design. What remains: (a) a consultant's or architect's own block named "PIT BLOCK" or "PIT BLOCK 2" is replaced with CE geometry and renamed, with no check that it is a CE pit; (b) the redefine on every open probably sets DBMOD, giving "Save changes?" on untouched drawings. That would be a Civil cause in the BUG-383 family; TEAMLANE2 already listed this service as "not read in full".
- **Trigger:** (a) open a non-CE DWG containing a block called "PIT BLOCK". (b) open any CE drawing with pits, change nothing, close, and see whether AutoCAD asks to save.
- **Severity:** MEDIUM. **Confidence:** (a) CONFIRMED by reading, (b) PLAUSIBLE until DBMOD is watched.
- **Fix idea:** migrate only when references carry CE pit link data, and skip the redefine when a stored version stamp matches.

### HUNT-LM-14 — CDXREFREPAIR can point an Xref at the host drawing
- **Where:** `Services\BrokenXrefPathRepairService.cs:52-60` takes the first folder holding the same file name, and the host folder is searched first (`Commands\BrokenXrefRepairCommand.cs:248`). There is no check that the candidate is the host itself.
- **Trigger:** host `C:\Job\SITE.dwg` with a broken Xref `..\Arch\SITE.dwg`. **Wrong:** it is re-pointed at the host, a circular reference. **Right:** exclude the host path.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED. **RED test:** yes, `SuggestRepairs`.

### HUNT-LM-15 — CDXREFREPAIR picks a stale copy when the same name is in several folders
- **Where:** the same loop. The search order is host, Xref, Survey, Background, then the parent folder; the stored path's own subfolder is ignored, and the preview shows only a relative path.
- **Trigger:** stored `C:\OldJob\Xref\BASE.dwg`; the new job has an old `BASE.dwg` beside the drawing and the current one in `Xref\`. **Wrong:** it re-points to the old copy. **Right:** prefer the candidate whose trailing folders match, and flag ambiguity instead of choosing.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED. **RED test:** yes.

### HUNT-LM-35 — the AI vision fallback never sends a schedule beyond page 6
- **Where:** `Services\XcivilVisionScheduleExtractionService.cs:274-277`: `maxPages = hint + 2`, capped at 6, and the renderer always renders pages 1 to maxPages (`MarkupPdfImageRenderer.cs:161`).
- **Trigger:** the schedule is on sheet 8. **Wrong:** pages 1–6 are sent (and paid for) and the schedule is not, so the result is 0 or wrong rows. **Right:** render the hinted page and its neighbours.
- **Severity:** MEDIUM. **Confidence:** CONFIRMED.

### Smaller legacy and import findings
1. **HUNT-LM-36, LOW-MEDIUM:** the vision parser reads "1.2 m" as 1.2 mm (`Services\XcivilVisionScheduleParser.cs:161`, `TrimEnd('m','M')`). Sizes in metres (0.9 m) then fail the 300–5000 check and the rows are dropped. CONFIRMED. RED test: `Parse` with `"pitDepthMm":"1.2m"`.
2. **HUNT-LM-37, LOW-MEDIUM:** the GN-ANNO-TABL reader takes the first "number m" in a row as depth (`XcivilScheduleService.cs:523-526`). On low bayside sites, "CL 8.45m 1.20m" gives depth 8450 mm. PLAUSIBLE. RED test available.
3. **HUNT-LM-38, LOW-MEDIUM:** a pipe-schedule row with one end blank gives its diameter to whichever pipe has an unresolved From pit (`XcivilScheduleService.cs:1165-1182`). CONFIRMED. RED test: `ApplyPipeScheduleToImportedPipes`.
4. **HUNT-LM-39, LOW-MEDIUM:** after the 60 s vision timeout, the background task keeps appending to the import log list while the command thread writes the report (`Services\XcivilVisionFallbackOrchestrator.cs:208-231`). Possible "Collection was modified" error or a garbled report. PLAUSIBLE.
5. **HUNT-LM-40, LOW:** CDXREFREPAIR on an unsaved drawing probes the working folder, and can throw from `new Uri("\\")` (`BrokenXrefRepairCommand.cs:168-169`). PLAUSIBLE. Fix: "Save the drawing first".
6. **HUNT-LM-41, LOW:** CDLEGACYAUDIT has no try/catch around a lazy folder scan (`Commands\LinkCommands.cs:323`; shared `CeLegacyEnvironmentAudit.cs:232-233, 358-380`), so an access-denied folder crashes the command. It also flags APPLOAD history entries as "legacy startup conflict" (`:305-306`). PLAUSIBLE.
7. **HUNT-LM-42, LOW (no live caller):** `Services\OrificeDetailFieldMap.cs:98-100` sets baffle = TWL − **outlet** IL, but the rulebook says head is measured from the **orifice** IL. `:113` rounds the orifice to nearest (55.6 → 56, which can exceed the PSD), and `PIT_IL_CENTRE` is filled with the orifice IL (`:110`). Fix before this mapper is wired up. CONFIRMED. RED test: `OrificeDetailFieldMap.Build`.
8. **Noted, not counted:** `DetailSelector.cs:638-650` always adds "Verify with Tim before issuing" to the council generic default. `CivilDesignService.cs:213-214` says the needed standard details "are listed in the package", but nothing lists them.

---

## RED-first candidates (pure unit tests, no AutoCAD)

1. LM-01 merged-inlet mapping (after extraction)
2. LM-02 `AssignImportedSchedulePitIdsByOrder`
3. LM-04 `PitScheduleBuilder.BuildInletFromDisplay`
4. LM-05 and LM-07 ordering and override maps (after extraction)
5. LM-03 `MapPinnedEnds` (after extraction)
6. LM-10 `DesignReviewService.ReviewNetwork` with a Settings stub
7. LM-13 `PdfScheduleSanityService.BuildPreflightLines(CheckSchedule(null))`
8. LM-14 and LM-15 `BrokenXrefPathRepairService.SuggestRepairs`
9. LM-17 `ScheduleLinkService.BuildDepthText`, and LM-44 `RefreshLinkedCellFromRecord` with a DELETE override
10. LM-18 `PitScheduleLevelText.Format`
11. LM-27 `MinimumCoverForChecks.Choose`
12. LM-36 `XcivilVisionScheduleParser.Parse`
13. LM-38 `ApplyPipeScheduleToImportedPipes`
14. LM-42 `OrificeDetailFieldMap.Build`
15. LM-45 `PitScheduleXrefDiscoveryCore.Discover`
16. LM-49 `PitScheduleStatusService.Evaluate`

---

## Summary

Read-only hunt of the installed Civil 3.0.55 lineage (`claude/rel-20261018d` @ `70a4e24f`) over Pit Schedule (build, text, update, edit, Xref), Checks and QA, CDREPAIR, legacy migration, details, notes and the X-Civil schedule import. It found 52 numbered defects that are not in the carpark or earlier hunt files, about ten of them HIGH. All were found by reading only, and the controller re-read the code for the worst before ranking them. The Pit Schedule is the biggest risk, because it can change or misprint real design data. Moving the table writes override text back into pit covers, diameters and inverts (LM-43). Merged "DPs" rows put the wrong pipe on later inlet rows (LM-01). "DELETE" blanks come back as the word DELETE (LM-44). The FROM column turns C1 into "C" (LM-04). Depth changes on refresh (LM-17). Saved row order splits a pit's rows (LM-05). SAVEAS-copied Xrefs merge into one source (LM-45). Outside the schedule, the X-Civil import pairs unnumbered schedule rows with pits by position (LM-02), the level cascade overwrites a typed level on pipes drawn from their low end (LM-03), and Recover Inverts reports success but draws nothing (LM-06). The controller corrected two reader claims. CDCHECKDWG does not print "no issues" for blank inverts. Migrating the pit block automatically on open was Tim's own June ruling, so only blocks from other offices that share the name, and the redefine on every open, remain. Nothing was built, run or opened in AutoCAD, and no BUG numbers were filed. Sixteen findings can be shown RED with pure unit tests before any fix.
