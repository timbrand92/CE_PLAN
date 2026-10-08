# Structural bug hunt 2, beyond Day 1 (9 Oct 2026)

Helper: hunt2_struc, run 2 (read-only, MAX account, desk plan/03). Written Fri 9 Oct 2026, about 09:35 Melbourne time.

**What was read:** the code of the INSTALLED Structural, release commit `origin/claude/rel-20261009f` (9babe787, Structural 1.0.110), plus its shared calculation library (`Modules/Structural.DesignCore`). Read with `git archive` into a scratch folder. Nothing was checked out, built or run. No AutoCAD, no accoreconsole.

**What was walked:** wall bracing (AB, BB, BT1, the bracing panel CSBRACINGPANEL and CSBRACINGREQUIRED), wind class (CSWINDCLASS) and the soil report (CSSOILREPORT), the timber subfloor grid (CSSUBFLOORGRID), roof and floor setout (planners only; both commands are OFF), lintel and support proposals (CSLINTELPROPOSE, CEAUTOSUPPORT), the footing proposal (CSFDNPROPOSE), FADOPT, the schedule tools (STRSCHEDCREATE, STRSCHEDREFRESH, STRSCHEDSYNC, the member schedule C1 reads), and Sheets issue and revision (CESHEETS, the Publish Issue window, the issue preview).

**Calculation sheet (CDCALC family):** not shared. Structural has no calculation sheet command at 9babe787; CDCALC is Civil only. Nothing to report here.

**Already in the carpark or in hunt run 1, so NOT reported again:** BUG-398 (issue preview engine disagreeing for unticked sheets; HUNT2-S-01 below is a different fault in the windows people actually use), BUG-453 (the "Settings page for it is still to be built" sentence on OFF commands), BUG-196 (schedule text size), BUG-273 (job file save failure wording; but see HUNT2-S-02, its premise is wrong), HUNT-S-02 (rotated UCS), HUNT-S-06 (units in R1, BT1, C1, TS1), HUNT-S-07 (layout tab and REFEDIT for the Day 1 commands), HUNT-S-13 (BT1 and the longest-brace limit), HUNT-S-14 (Day 1 code words).

**How to read each item:** "The code shows" is what I read in the file. "I think" is my judgement and has NOT been seen in AutoCAD. Nothing here is accepted. Every item needs a Codex or Tim check on a copy.

---

## The 15 findings, most valuable first

### HUNT2-S-01. Publish Issue gives the new revision to EVERY sheet of the discipline and re-dates every sheet in the set (HIGH)

1. **What the drafter does:** types `CESHEETS`, presses Publish Issue, ticks Structural, types revision C, publishes a 10-sheet set where only S03 and S05 changed.
2. **The code shows:** the window writes the typed revision onto every Structural sheet in the job's sheet list, including sheets left out of this issue (`UI/Dialogs/CeSheetsWindow.xaml.cs` 263 to 273, called at 492; `SheetsOfDiscipline` 206 to 212 does not look at "include in issue"). It then calls the old issue path, which dates every sheet in the issue with the issue date (`Services/CeSheetsIssueService.cs` 24 to 32 and 86 to 109: with no ticked list, every sheet "gets" the new revision and date). The Sheets Manager window does the same (`CeSheetsManagerWindow.xaml.cs` 1191 to 1196).
3. **The ticked-sheet path is built but nothing uses it:** the overload that gives the revision only to ticked sheets (`CeSheetsIssueService.cs` 39 to 47) and the issue preview (`Services/CeIssuePreviewBuilder.cs`) are called by no window. The Settings switch "IssuePreviewEnabled" (`Models/UserSettings.cs` 268 to 271) is read by nothing, so turning it on changes nothing.
4. **Tim's rulings it breaks:** 14 Sep, as quoted in `04_REFERENCE/structural/cards/STRUC-REGISTER-ISSUE_CARD_2026-09-26.md` section 4: "Unchanged sheets keep their existing revision and date — a set-wide issue date must never overwrite them" (item 3) and "Before plotting, show an issue preview" (item 6). Also INT-059 item 22 (blank revision allowed when nothing changes): the Publish Issue window refuses a blank revision ("Enter a revision for each ticked discipline.", `CeIssuePublishDialog.xaml.cs` 198 to 200).
5. **Real-world effect:** all ten sheets come out at revision C dated today. Eight sheets that did not change now claim a change. A builder holding revision B of S07 is told it is superseded when it is not. Sheets left out of the issue also jump to C in the sheet list without ever being issued.
6. **Should do (I think):** the windows use the ticked path and show the preview before plotting, as the card says. Only ticked sheets get the new revision and date.
7. **Test on a copy:** a job copy with three Structural sheets at revision B. `CESHEETS`, untick "include" on sheet 3, Publish Issue, Structural, revision C. Right now (from code): sheets 1 and 2 at C dated today, and sheet 3 also shows C in the list. Right: only the sheets chosen to change get C; sheet 3 stays B.

### HUNT2-S-02. The "job record" (wind class, soil values) is kept on this PC, filed under the drawing's path, not with the job (HIGH for colleagues)

1. **What the drafter does:** runs `CSSOILREPORT` and answers Yes at "Save these values to the job record?", or sets the wind class with `CSWINDCLASS` ("Wind class set to N2 for this job").
2. **The code shows:** the record is written to the user's own AppData folder, `CE_STRUC_SUITE\projects\CS_ProjectData_<drawing name>_<code made from the drawing's full path>.json` (`Services/ProjectDataService.cs` 33 to 37 and 402 to 418; folder from `SettingsService.cs` 607). It is not beside the drawing and not in the job folder.
3. **Real-world effect:** (a) a colleague opening the same drawing sees no wind class and no soil values; general notes would say Unknown. (b) Copying the job folder (DAY1 step 1 does exactly this), Save As to a new name, or moving the job to the archive loses the record. (c) A second drawing in the same job has its own empty record. The command words "for this job" and "job record" are untrue.
4. **Also:** BUG-273 is written as if the file sits "beside the drawing", and its test step ("make the job file beside the drawing read-only") would test a file that does not exist. That carpark entry needs correcting.
5. **Should do (I think):** keep the job record with the job (in the drawing or the job folder), or say plainly "saved on this PC for this drawing only". Tim's call which.
6. **Test on a copy:** `CSWINDCLASS`, type a region, accept or type N2. Copy the drawing to another folder, open the copy, `CSWINDCLASS` again. Right now (from code): it asks from scratch, no "already set to N2". Right: the copy knows N2.

### HUNT2-S-03. STRSCHEDCREATE makes every table one row too short (HIGH, "I think" on the exact symptom)

1. **What the drafter does:** places at least one A or B brace (or a bored pier, or a tie-down), then Schedules > Create Schedule (`STRSCHEDCREATE`) and picks a point.
2. **The code shows:** each table is sized "count + 1" rows (`Services/ScheduleService.cs` 335, 373, 481) but holds a title row, a heading row and then one row per item starting at row 2 (342 to 365, 388 to 411, 489 to 506). With one brace the table has rows 0 and 1 only, and the brace is written to row 2.
3. **I think:** AutoCAD refuses the write to a row that does not exist, the whole command stops with an AutoCAD error, and no table is drawn (there is no error catch in `CreateSchedules`, 193 to 236). At best the last brace, pier or tie-down is missing from its schedule. Codex X1 (29 Sep) ran STRSCHEDCREATE on a drawing with no braces, piers or tie-downs, which is the one case that works.
4. **Should do:** size each table "count + 2".
5. **Test on a copy:** draw one `AB` brace, then `STRSCHEDCREATE`. Right now (from code): an error and no tables, or a bracing schedule with no brace row. Right: three tables, the brace listed.

### HUNT2-S-04. Schedule refresh never removes rows: a deleted brace or pier stays on the schedule (MEDIUM-HIGH)

1. **What the drafter does:** erases one of four braces, then `STRSCHEDREFRESH` and picks the bracing schedule.
2. **The code shows:** the bracing and bored pier refresh rewrite rows from the top and add rows when needed, but never clear the rows left over (`Services/ScheduleService.cs` 551 to 569 and 571 to 593). The tie-down refresh does clear them (529 to 534), so the two behave differently.
3. **Real-world effect:** the schedule still lists four braces, the last row being the old fourth one. A schedule that overstates bracing is the dangerous direction.
4. **Should do:** clear (or delete) the left-over rows, as the tie-down schedule already does.
5. **Test on a copy:** four `AB` braces, `STRSCHEDCREATE` (after HUNT2-S-03 is fixed), erase one brace, `STRSCHEDREFRESH`. Right now (from code): four rows. Right: three.

### HUNT2-S-05. The bracing panel adds roof bracing trusses (BT1) to the wall bracing totals (MEDIUM-HIGH)

1. **What the drafter does:** places wall braces with `AB` and `BB`, roof bracing trusses with `BT1`, and watches `CSBRACINGPANEL`.
2. **The code shows:** BT1 inserts the same BRACING block, tagged "BT1" (`Commands/BracingCommands.cs` 313 to 327). The scan collects every BRACING block whatever its tag (`Services/ProjectDataService.cs` 245 to 248), and the panel adds up all their lengths (`Modules/Structural.DesignCore/BracingPanelCalculator.cs` 62 to 93). Type A and type B lengths are also added together as if equal. A brace with no type tag is read as type A (`ProjectDataService.cs` 281 to 283): an Unknown turned into a value.
3. **Real-world effect:** two 4 m roof trusses add 8 m to the wall bracing "provided". A wall direction that is short shows a green tick.
4. **Should do (I think):** count only wall bracing (A and B) and show them separately; leave BT1 out; a brace with no type counts as Unknown, not A. How A and B combine against "required" is Tim's engineering call.
5. **Test on a copy:** `CSBRACINGREQUIRED`, North-South 5000. One 2700 `AB` brace running north-south, then one 4000 `BT1` running north-south. Right now (from code): "6700 mm provided / 5000 mm required" with a tick. Right: 2700 provided, a cross.

### HUNT2-S-06. Required bracing is one value for the whole PC, so the last job's figure sits on the next job (MEDIUM)

1. **What the drafter does:** sets 12000 / 9000 with `CSBRACINGREQUIRED` on job A, then opens job B.
2. **The code shows:** the two values live in the PC-wide Settings file (`Models/UserSettings.cs` 695 to 707, saved by `SettingsService.SaveSettings` in `Commands/BracingPanelCommands.cs` 123). The comment in the code says "entered once per job", but nothing ties it to a job.
3. **Also in CSBRACINGREQUIRED (89 to 127):** a mistyped value ("12,000" or "12m") is silently ignored and the line still says "Required bracing set"; there is no way back to "not set" (blank keeps the old figure); 0 and negative figures are accepted, and 0 shows a green tick for any job.
4. **Real-world effect:** job B's panel shows job A's requirement with a tick or a cross, as if it were job B's.
5. **Should do (I think):** keep the required figures with the job; refuse or question a value it cannot read; let blank or a word clear it back to "not set".
6. **Test on a copy:** `CSBRACINGREQUIRED` 12000 / 9000 in drawing 1. Open an unrelated drawing 2, `CSBRACINGPANEL`. Right now (from code): "/ 12000 mm required". Right: "required not set".

### HUNT2-S-07. C1 and C2 take their size from the imported member schedule by mark only, ignoring the floor (MEDIUM)

1. **What the drafter does:** imports the member schedule with `XCLMTXT` (C1 = 89 SHS on the ground floor, C1 = 75 SHS on the first floor), then places `C1` on the first floor plan.
2. **The code shows:** the saved schedule copy keeps mark, size and group only, no floor (`Services/XclmTxtService.cs` 308 to 325). C1 looks up the FIRST row with that mark and, when found, skips the size question altogether (`Commands/SupportBlockCommands.cs` 218 to 233; `Services/MemberScheduleService.cs` 31 to 45).
3. **Also:** the copy is taken once at import. Editing the schedule text by hand, or erasing it, does not change what C1 uses.
4. **Real-world effect:** the first-floor post is drawn as 89 SHS with one line "size '89 SHS' from the schedule", and no question that would have caught it.
5. **Should do (I think):** when the same mark has more than one size, ask (offering the sizes found); say which floor the size came from.
6. **Test on a copy:** an `XCLMTXT` import whose CSV has C1 twice with two sizes on two floors. Type `C1`. Right now (from code): the first size, no question. Right: CE asks which.

### HUNT2-S-08. CSSUBFLOORGRID offers made-up bearer and stump sizes and spacings and writes them on the plan (MEDIUM, R-00)

1. **What the drafter does:** types `CSSUBFLOORGRID` (typed only, not on the ribbon), picks the floor outline and joist direction, and presses Enter at each question.
2. **The code shows:** the Enter defaults are 3000 mm bearer spacing, 1800 mm stump spacing, "150x50 F17" bearers and "90x90 F17" stumps (`Models/UserSettings.cs` 1436 to 1471). The code's own comment says these are "ASSUMED ... NOT checked against AS 1684.2". The questions do not say so (`Services/TimberSubfloorService.cs` 79 to 82), and the bearers are labelled "BR1 150x50 F17" on the plan (101 to 118). The "bearer span table" it ships is read by nothing (only a load fix-up in `SettingsService.cs` 526 to 534), so no size is ever checked against a span. Spacings are not converted for metre drawings.
3. **Real-world effect:** four Enters put engineering sizes nobody chose on the drawing. Footings and lintels already follow the rule "sizes are never invented" (Unknown until the engineer gives one); this tool does not.
4. **Should do (I think):** no size default unless Tim has set one; sizes left blank show as Unknown; say "assumed" wherever a starter figure is offered.
5. **Test on a copy:** `CSSUBFLOORGRID` on a 10 x 8 m closed polyline, Enter at every question, Yes. Right now (from code): bearers tagged "150x50 F17". Right: CE asks for the size with no made-up default.

### HUNT2-S-09. The bracing schedule prints computer IDs, layer names and raw angles on the sheet (MEDIUM-LOW)

1. **The code shows:** STRSCHEDCREATE's BRACING SCHEDULE columns are TYPE, LENGTH, ROTATION, LAYER and HANDLE (`Services/ScheduleService.cs` 350 to 364). HANDLE is AutoCAD's internal object number (for example 2F4A). LENGTH is in drawing units with no unit and up to two decimals; ROTATION is degrees to two decimals. The bored pier schedule likewise prints VISIBILITY, LAYER and HANDLE (396 to 409). A bored pier schedule is also a separate table, where Tim ruled today that bored piers stay part of the footing schedule (INT-077 item 12; the ruling post-dates this build).
2. **Real-world effect:** a sheet issued with "HANDLE 2F4A" and "ROTATION 89.97" columns. None of it means anything to a builder or certifier.
3. **Should do (I think):** the schedule lists what an engineer would: mark, type, length in mm (rounded), wall or location. The IDs stay hidden in the table's own data.
4. **Test on a copy:** after HUNT2-S-03, `STRSCHEDCREATE` with two braces and look at the columns.

### HUNT2-S-10. The bracing panel ignores drawing units and splits North-South / East-West by the drawing's sideways axis (MEDIUM-LOW)

1. **The code shows:** the panel prints the summed block lengths as "mm provided" (`UI/Dialogs/BracingPanelWindow.xaml.cs` 129 to 132) without converting drawing units. A 2.7 m brace in a metre drawing reads "3 mm provided". The direction split is by the drawing's own X axis, with a brace at exactly 45 degrees counted East-West (`BracingPanelCalculator.cs` 53 to 60).
2. **Real-world effect:** on a plan drawn turned to fit the sheet (or a building at 45 degrees on its lot) the two totals are not the building's two directions. On a metre drawing every total is 1000 times too small, so every direction shows a cross.
3. **Should do (I think):** convert to mm as AB and BB already do (BUG-433), and let the drafter say which way is "across" the building (or use the walls' own directions).
4. **Test on a copy:** a metre drawing (`UNITS` Metres), one `AB` brace 2.7 long, `CSBRACINGPANEL`. Right now (from code): about "3 mm provided". Right: 2700 mm.

### HUNT2-S-11. CSWINDCLASS saves a blank or any typed text as the job's wind class and says "set" (MEDIUM-LOW)

1. **What the drafter does:** `CSWINDCLASS`, types a region, picks terrain and topography, then presses Enter at "Wind class:".
2. **The code shows:** the region table ships EMPTY (`Models/UserSettings.cs` 104 to 105), so CE never suggests a class and always asks. Enter at "Wind class:" with nothing stored gives a blank (`Commands/SoilAndWindCommands.cs` 216 and 357 to 366), and the command still saves and prints "Wind class set to  for this job" (241). Any text is accepted (N7, 50, "dunno"), upper-cased and recorded as confirmed (223 to 231). Esc at a Yes/No question is treated as No, not as stop (329 to 340; the comment there says Esc takes the default, which is wrong).
3. **Real-world effect:** a record that says "confirmed" holding nothing, or a class that does not exist, which general notes would then print.
4. **Should do (I think):** blank keeps "not set" and says so; a class outside N1 to N6 and C1 to C4 gets a warning (R-27, not a block); the region table either ships with Tim's regions or the command says once that it cannot suggest.
5. **Test on a copy:** `CSWINDCLASS`, region "Melbourne", Enter, Enter, Enter at "Wind class:". Right now (from code): "Wind class set to  for this job". Right: "No wind class was given; nothing was saved."

### HUNT2-S-12. The Publish Issue window's folder line is not the folder CE makes, and a mistyped date silently becomes today (LOW-MEDIUM)

1. **The code shows:** the window builds its own folder line (`UI/Dialogs/CeIssuePublishDialog.xaml.cs` 211 to 229) by a different rule from the real folder (`Services/CeSheetsIssueService.cs` 158 to 170): it adds the status word, e.g. "  (PRELIMINARY)", which the real folder does not; it calls an Architectural set "ARCH" where the real folder says "ARCHITECTURAL" (dialog 265 to 272, service 539 to 554); in a combined issue it lists disciplines in the order the window shows them, where the real folder always puts STR first (service 175 to 181).
2. **Dates:** a date CE cannot read (for example 31/09/2026) becomes today's date with no warning, in the window line and in the real issue (`CeSheetsIssueService.cs` 126 to 132, 158 to 160). Only the unused preview (HUNT2-S-01) would have warned.
3. **Real-world effect:** the folder name the drafter approved is not the one on the server, and an issue meant for a set date goes out dated today.
4. **Should do:** one rule for both (design rule 1), and a plain warning when the date cannot be read.
5. **Test on a copy:** Publish Issue, date "31/09/2026", revision P1. Right now (from code): the folder and title blocks carry today's date, no warning. Right: a warning before anything plots.

### HUNT2-S-13. FADOPT Raft: an unlabelled beam line becomes an INTERNAL beam (LOW-MEDIUM)

1. **What the drafter does:** `FADOPT`, Raft, picks the slab perimeter, on a drawing whose edge beam lines have no label (or a label CE does not know).
2. **The code shows:** a line with no recognised label is adopted as an internal beam "IB" (`Services/FoundationService.cs` 1448 to 1468; `InferBeamKindFromLabel` 4400 to 4408). The known label starts are BEB, BIB, BTH, BPF, BSF, EB, IB, TH, PF, SF, BP, SP and ST only (41 to 43).
3. **I think:** an edge beam on the slab perimeter, unlabelled or labelled GEB (Tim today: G = ground, INT-077 item 15), lands in the schedule as an internal beam with the internal beam's width.
4. **Should do (I think):** an unlabelled beam's kind is Unknown and asked once (or taken from whether it sits on the perimeter, said aloud); add GEB, GIB and GPF to the known labels.
5. **Test on a copy:** a closed polyline on SLAB PERIMETER with one line along its edge on the raft layer, no label. `FADOPT`, Raft. Look at the schedule row. Right now (from code): IB.

### HUNT2-S-14. CSLINTELPROPOSE: the grey preview is not what is drawn (LOW)

1. **The code shows:** the preview for a stud support is a CIRCLE with a radius equal to the full built-in support size (`Services/LintelProposalService.cs` 112 and 313). What is drawn is a SQUARE of the Settings support size, half that each side of the point (337 to 338, 366 to 377). Preview and drawing use different sizes when Settings differ from the built-in value, and the preview is about twice the size of what is drawn even when they do not.
2. **Real-world effect:** small, but it is a preview that does not show the result (the rule this hunt was asked to check). OFF by default.
3. **Should do:** the preview draws the same square, from the same Settings value.
4. **Test on a copy:** switch the proposals on, set the support size to 200, `CSLINTELPROPOSE` on a beam end over a wall. Compare the grey circle with the square after Accept.

### HUNT2-S-15. Command-line sentences with plan codes or untrue words (LOW)

1. **CSWINDCLASS:** "no automatic wind-bracing-requirement calculation exists in this codebase yet" and "(UX-NOTES-10/11 is planning-only)" (`Commands/SoilAndWindCommands.cs` 242 to 248). "Codebase" and plan codes mean nothing to a drafter.
2. **CSSOILREPORT:** "no general-notes mechanism exists yet, UX-NOTES-10/11 is planning-only" (134 to 136). A general notes command (CSGENNOTES) does exist, hidden and off, and does read these values.
3. **CSFDNPROPOSE:** every row ends "size Unknown until the S5 footing calculation; pick it from the size library (Manual)" (`Modules/Structural.DesignCore/FootingProposalEngine.cs` 112, and 198 for piers). "S5" is a plan code. The OFF line says "Propose footings is not switched on in this version" (`Services/FoundationService.Proposal.cs` 34 to 35); it is a Settings switch, not a version.
4. **STRSCHEDREFRESH:** a table on a locked layer prints "[STRSCHEDREFRESH] Error: " plus AutoCAD's raw error word (`Commands/UtilityCommands.cs` 87), not "Layer X is locked, so the schedule was not updated".
5. **Should say, for example:** "CE does not work out the bracing needed yet. Type it with CSBRACINGREQUIRED." and "Size not known yet. Pick it when you draw the footing."

---

## What I did NOT check

1. **Nothing was run.** No AutoCAD, no tests, no build. Every symptom is read from code; HUNT2-S-03's exact symptom (error or missing row) is my reading of AutoCAD's table rules, not seen.
2. **Roof and floor setout:** only the planners were read (they looked sound); the commands are OFF (BUG-453) and were not traced.
3. **CEAUTOSUPPORT:** hidden and experimental. I saw fixed numbers in its engine (a beam over 4000 mm gets a column, 600 mm merge distance and others, `Structural.DesignCore/SupportPlacementEngine.cs` 42 to 107) and no drawing-units conversion, but did not rank it as it is not offered to anyone.
4. **CSFDNPROPOSE** (hidden, OFF): the engine looked careful about Unknown sizes and loads. Not ranked: a wall only partly on a footing is proposed a full-length strip, and a wall partly on the slab gets a strip, not a thickening (`FootingProposalList.cs` 122 to 129). Engineering judgement, Tim's call.
5. **STRSCHEDSYNC** writes the table's typed values back into the brace blocks with no locked-layer check. Not traced further.
6. **Lintel proposal values** are PC-wide Settings; Tim ruled today (INT-075 item 8) they are per-job values with an office default. The installed build predates that ruling, so it is not counted as a fault.
7. **Title blocks:** I did not trace whether the sheet-list revision changes in HUNT2-S-01 reach the title blocks at once or at the next Sheets update.
8. **Next version:** the job names no Structural "next"; the Civil/Manager commits were not read.
