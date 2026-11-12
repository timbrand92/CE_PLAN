# TRUST-S0: one line on opening that says what state a Structural drawing is in

**Status: DRAFT, written Fri 13 Nov 2026, 03:41 PC clock, by lane trust-struc-mgr-plan.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card.
**Class:** Missing (new). Nothing is retired, renamed or hidden.
**Source:** the Civil opening line, card UX-OPEN-01 (Tim's answers of 6 and 7 Nov); Tim, 5 Nov: "it does random stuff for them and I can't explain why"; Tim, 12 Nov, B5: "Nothing changes on open" (for Civil). Step S0 of `areas\trust-plan-structural.md` (added by this card). Findings: `areas\trust-run\STRUCTURAL_NEW_FAULTS_TO_FILE.md` and the 32 Structural tool notes in `04_REFERENCE\core-tool-notes\structural\`.

---

## FOR TIM

**You open a Structural drawing, and one line tells you what CE sees in it: supports, beams with an unsupported end, braces with no type, and bracing schedules that no longer match the plan. It changes nothing in the drawing.**

```before
You open a Structural job.
Nothing says what state it is in.
If it is an older job, CE converts its beam links and writes a marker,
  so a drawing you only opened asks "save changes?" when you close it.
```

```after
You open a Structural job.
CE Structural: 38 supports, 26 beams, 14 braces, all checked.
or
CE Structural: needs checking. 2 beam ends with no support, 1 brace with no type,
  bracing schedule lists 13 braces, plan has 14.
```

**What this card does not fix.** Be clear before you approve it:

1. **The old beam link conversion still runs on opening** until you answer decision 4 (question Q70). This line only says when it happened.
2. **It does not repair anything,** and it adds no new command.
3. **It does not check footings, sheets or the roof-down tools** in this first version.

## Decisions for Tim (read these first)

1. **What the line counts.** Recommended: supports, beams with an unsupported end, braces with no type, and bracing or pier schedules whose row count differs from the plan. Example: a job where you erased a brace reads "bracing schedule lists 13 braces, plan has 14" (the schedule keeps erased braces today, BUG-498). OPEN.
2. **Wording.** Recommended: "all checked" when nothing is found, matching the Civil "all linked" idea of saying only what CE can prove. Not "up to date". OPEN.
3. **Not a Structural drawing:** recommended no line at all. A Civil drawing already gets Structural's own "resting" line today (`Services\DrawingDisciplineDb.cs:26-27, 123-124`). Example: you open a drainage job and see only the Civil line. OPEN.
4. **Old beam links converted on opening.** Recommended: move the conversion out of opening (question Q70), and until then say it in a second line: "CE Structural converted the old beam links in this drawing (12 beams)." Example: you open last year's job to print; you are told why CE will ask to save. OPEN.
5. **Bracing totals in the line?** Recommended: no, not until the bracing panel's faults are fixed (units, north-south by the drawing's own axis, trusses, blank type; step S4 and card TRUST-04). Example: a turned plan would otherwise show wrong totals on every open. OPEN.

## 1. What you'd see

1. **Structural drawing, nothing to check:** `CE Structural: 38 supports, 26 beams, 14 braces, all checked.`
2. **Something to check:** `CE Structural: needs checking. 2 beam ends with no support, 1 brace with no type, bracing schedule lists 13 braces, plan has 14.`
3. **Drawing not in millimetres:** a second line, `CE Structural: this drawing is in metres. The beam tools scale for it; the support blocks, bracing and rafter marks will stop until it is in millimetres.` (From the code: beam tools 1, 2 and 4 convert millimetres, metres and inches, `Services\ConnectedDesign\Host\BeamCommandAutoCadRenderPort.cs:65-75`; the others stop, for example `Commands\SupportBlockCommands.cs:216`.)
4. **Old beam links converted when it opened:** a second line, as decision 4.
5. **Very large drawing:** `CE Structural: large drawing, not checked on opening.`
6. **The check itself fails:** `CE Structural: could not check this drawing.` The reason goes in the log; the drawing opens as normal.
7. **Not a Structural drawing:** nothing (decision 3).

## 2. What a Structural drafter is exposed to today without being told

From the installed code (Structural 1.0.126) and the 104 new findings. "Verified" means this lane read the line itself.

**On opening a drawing**

1. **Old beam links converted, marker written, drawing marked changed, nothing said.** Verified: `Services\LinkMigrationService.cs:29-33` (every open drawing), `78-84` (when old links exist), line 20 (the marker); no command-line message in the file.
2. **The Civil pit symbol swap** runs on any drawing when the Civil plugin is loaded, and prints nothing. Seen in AutoCAD on a blank drawing (`areas\TRUST_PROBES_13NOV.md` section 5).
3. **A selection setting changed at AutoCAD start:** PICKSTYLE is turned on so CE's linked groups pick as one; logged only. Verified: `Services\GroupSelectionService.cs:32` (sets it) and `36` (the log line). This is an AutoCAD setting, not the drawing.
4. **The settings file is written when Structural first starts,** freezing each login on that build's defaults. Verified: `Services\SettingsService.cs:675-684`. Not the drawing.

**While working (not on opening, but the same kind of hidden change)**

5. **Moved single-line text has its anchor re-set when AutoCAD goes idle,** with nothing said. Verified: `Services\DrawingAutoSaveService.cs:1098-1105`, changes at `959` and `966`.
6. **Footing outlines are redrawn and the footing schedule marked out of date,** silently when it works. Verified: `Services\FoundationService.cs:785, 796-798`.
7. **Schedule sync with no edits turns a brace again** (only one drawn flat and later ROTATEd, on the first sync; narrowed after review), and rewrites every brace's length and angle at two-decimal rounding. Verified: `Services\ScheduleService.cs:725-756` with `Services\ProjectDataService.cs:322-326`.
8. **The A/B switch erases an older brace before drawing the new one,** and if the BRACING block cannot be loaded it still says "It was left as it was." (narrowed after review; one U brings it back). Verified: `Services\BracingService.cs:2151-2206`, message at `Commands\BracingCommands.cs:498`.
9. **A schedule size the block cannot show is drawn as the default size** while the line names the schedule size. Verified: `Commands\SupportBlockCommands.cs:1470-1480`.

Items 1 to 4 are what this card would make visible at opening (1 and 2 in a line; 3 and 4 belong to CE Health and card TRUST-03). Items 5 to 9 belong to steps S2 to S5.

## 3. What gets counted

Only plan facts, read from the drawing:

1. **Supports:** the support blocks DS, DS1, TS1, C1 and C2 by block name.
2. **Beams with an end that has no support recorded.** CE's beam record marks a reference as Unresolved, Missing or Conflict (`Models\ConnectedDesign\ConnectedStructuralRecord.cs:55-61`); whether every beam end carries that mark, so it can be counted, is not known yet.
3. **Braces with no type:** BRACING blocks whose type is blank (today read as type A, `Services\ProjectDataService.cs:316-320`). BT1 trusses counted on their own, never as wall braces, in the line.
4. **Bracing and pier schedules** whose number of rows differs from the braces or piers on the plan. Care: every bracing schedule made today is one row short (BUG-497), so until card TRUST-04's fix is in, the line must compare against the real row count, not the table size.

**Left out on purpose:** footings, roof-down tools, sheets, hatches, text. They would make nearly every drawing say "needs checking".

## 4. The full experience

1. **Trigger:** the first quiet moment after a Structural drawing opens, after CE's opening jobs, once per drawing per session.
2. **Ribbon, prompts, preview:** none. One line, no window.
3. **Cancel, Escape, Undo:** nothing to cancel; adds no Undo step and must not disturb Redo.
4. **Save and reopen:** writes nothing; must cause no "save changes?" of its own. Proven by comparing AutoCAD's changed-drawing counter before and after.
5. **Locked layers, Xrefs, REFEDIT:** read only. Counts cover this drawing, not attached Xrefs.
6. **Read-only files and templates:** the line still shows.
7. **Scripts and the core console:** skipped (Structural already skips its resting line there, `Services\DrawingDisciplineDb.cs:29, 114`).
8. **AutoCAD 2022 to 2024:** same line; it needs no ribbon.
9. **Speed:** must not hold up opening; a size limit on Settings, set after timing on copies.

## 5. Settings

1. **"Say what state a Structural drawing is in when it opens":** on or off. Default on in the core build. Undo: switch it off; nothing to restore.
2. **"Don't check on opening above this many objects":** a number, set after measuring.

## 6. What it reuses

1. **The Structural-or-not decision** CE already makes on opening (`Services\DrawingDisciplineDb.cs:117-124`, `HasStructuralContent` at line 177).
2. **The bracing reading rules** of the bracing panel scan (`Services\ProjectDataService.cs:230` onward), without any save step. Whether that scan writes anything by itself is not known yet (section 8).
3. **The Civil opening line's design** (card UX-OPEN-01): same trigger, same quiet rules, same proof.

## 7. How it gets proven

**Before any code:** time the count on copies of large Structural jobs; check that the bracing scan writes nothing (changed-drawing counter and file comparison on a copy).

**Robot, on copies (Structural 1.0.126 plus the trial build, never on a live job):**

1. A made-up job, everything supported: "all checked", nothing changed.
2. The same job with one column erased under a beam: "1 beam end with no support".
3. A brace with its type cleared: "1 brace with no type".
4. A brace erased after the schedule was made: the schedule mismatch is named.
5. A metre copy: the units line.
6. An old job with old beam links: the conversion line (until decision 4 moves it).
7. A Civil drawing: no Structural line.
8. Open and close with no edits: no save question from this line.
9. A deliberately broken version that writes to the drawing must fail check 8.

**Codex:** one look for a clean line with no software words.

**Tim:** open five Structural jobs you know. Right = the line matches what you know about each.

## 8. Not known yet

1. **Whether the bracing panel scan writes anything** when it reads (it commits its reading transaction at `Services\ProjectDataService.cs:310`; a separate save writes a project file to disk, lines 155 to 182; whether the scan calls it was not traced).
2. **Whether the Structural-or-not decision stores anything in the drawing** (`DrawingDisciplineGate.SetStructuralContent`, called at `Services\DrawingDisciplineDb.cs:121`, not traced).
3. **How long the count takes** on a large job.
4. **How a drawing that is both Civil and Structural** should show both lines.

Written from reading Structural 1.0.126 (commit 8de95c34). Nothing here was run in AutoCAD.
