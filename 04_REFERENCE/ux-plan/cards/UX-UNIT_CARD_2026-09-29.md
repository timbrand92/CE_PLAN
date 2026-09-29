# UX-UNIT-01..04 - Multi-unit jobs (Structural) - workflow card

Status: card written 29 Sep 2026 by the S2 builder. Built and unit-tested: the tag setting, the tag renumbering
logic, the schedule grouping logic, the units-in-messages helper. NOT built: the copy-to-other-units command and
the grouped schedule on the drawing (they need Tim's answers below). Nobody has run any of it in AutoCAD.

Authority (Tim's rulings, `C:\CE_PLAN\decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`):

1. **UX-UNIT-01 (26 Sep 11:14):** "CE copies to the others, linked (Recommended)". Draft one unit; CE copies the framing to the picked identical or mirrored units, tags renumbered by unit (1FB1 to 2FB1), linked so a change offers to carry to all (Edit together / Edit this only).
2. **UX-UNIT-02:** "Asked once in the job record (Recommended)". "Tag prefix by: level / unit / none" is set once in the job record and applied everywhere (UX-FRM-10).
3. **UX-UNIT-03:** "One schedule, grouped by unit". One MEMBER SCHEDULE with a heading per unit, "Typical all units" where identical.
4. **UX-UNIT-04 (27 Sep 01:47):** "Always with units". Values in messages and windows always carry units (0.28 m, 225 mm, 1 in 100, 12.4 m3), never a bare number.

Plan label and ruling agree for all four. Not decided here (Tim's open item 5, area file "For Tim"): whether a leading number like 3FB1 is a floor or a unit. The job's "Tag prefix by" setting decides it, so this card only builds the setting and obeys it.

## What is built (this branch)

### UX-UNIT-02 - the setting (command CSUNITTAGS, hidden)

1. **What the drafter does:** types `CSUNITTAGS`. The command line says what the job currently means by a leading number, then asks `A leading number on a tag means [Level/Unit/None]:`.
2. **What the drafter sees:** "Tag numbering for this job is now: the unit number (2FB1 is first-floor beam 1 of unit 2)." If it was already set to something else, it adds "Tags already on the drawing were not renamed."
3. **Enter** keeps the current choice (or leaves it not chosen). **Escape** cancels and changes nothing.
4. **Undo:** nothing to undo. It writes only the job record file next to the drawing, never a drawing object.
5. **Save / reopen:** stored on the job record (`ProjectData`, the same place as CSWINDCLASS), so it comes back when the drawing is reopened. Assumed, Tim to confirm: per drawing, because no job-wide store exists yet (UX-JOB-01..05).
6. **Default OFF:** not chosen = nothing anywhere changes. The command is hidden from the ribbon and the command hub until Codex accepts it (it still works when typed).
7. **2022-2024 vs 2027:** no difference; plain command-line prompts, no window, no 2027-only call.

### What the setting changes today: XCLMTXT floor reading

1. When the job says **Unit**, XCLMTXT no longer reads a leading number as a floor: 3FB1 is read from its letters (FB, a first-floor beam) instead of as a third-floor beam. Level, None and not chosen read exactly as before.
2. Marks read for the office corpus (learning from other jobs) always use "not chosen", never this drawing's setting.

### UX-UNIT-01 - the tag rule only (logic, not yet on the drawing)

`UnitTagPrefix.ForUnit(tag, mode, unit)`: Unit job: 1FB1 becomes 2FB1 in unit 2; FB1 (no number) becomes 2FB1; a "(E)" marker stays in front. Level or None job: the tag stays as it is (with a plain reason). Not chosen: the tag stays and the caller must ask once. A non-tag ("12") is left alone.

### UX-UNIT-03 - the grouping rule only (logic, not yet on the drawing)

`UnitScheduleGrouper.Group`: a Unit job with two or more units gives TYPICAL ALL UNITS (a tag with the same size in every unit, shown once without the unit number), then UNIT 1, UNIT 2 ... for the rest, then UNIT NOT GIVEN for a tag with no unit number (never quietly filed under a unit). Any other job, or a single unit, comes back as one block in the order given, exactly as today. ASSUMED (Needs Tim's engineering acceptance): "identical" = same tag letters and number and same size in every unit; typical lines carry no unit number.

### UX-UNIT-04 - always with units (helper, not yet swept through old messages)

`UnitText` formats every value with its unit (225 mm, 0.28 m, 1 in 100, 12.4 m3, kN, kPa, L). An unmeasurable value reads "unknown", never a bare or zero number. Used by the new code; the sweep of older Structural messages is the C1 message sweep (UX-VOICE-01), not this lane.

## What is NOT built, and why (needs Tim)

See the questions at the end of the PR. Summary:

1. **UX-UNIT-01 copy command:** how a unit is picked (window around its framing? which layers/objects count as framing?), where the copies go (pick one base point per target unit, or type a spacing?), how "mirrored" is chosen (pick a mirror line), and whether Edit together / Edit this only reuses the existing beam link machinery (BeamLinkService: Opus-review area) or is a new link group. Recommendation in the questions.
2. **UX-UNIT-03 on the drawing:** whether the unit headings replace the per-floor MEMBER SCHEDULE blocks XCLMTXT builds today, or sit inside each floor block; and the type sub-headings (UX-FRM-09) which are not built yet.

## Tests and guards

Automated (48 new tests, `Modules/Structural.Tests/Core/Units/UnitTagTests.cs`): setting read/write and older job records; renumbering for level/unit/none/not chosen, markers, two-digit units, non-tags; grouping (identical, differing, partial, missing unit, ungrouped modes, nothing lost); XCLMTXT floor reading per setting and through the job record; unit formatting and culture.

## Codex steps in AutoCAD (copies only)

1. Type `CSUNITTAGS`. Right: the line says "not chosen yet for this job". Press Enter. Right: "Left as it was."
2. Type `CSUNITTAGS`, answer `Unit`. Right: confirmation names the unit number. Save, close, reopen the drawing, type `CSUNITTAGS`. Right: it says the job already uses the unit number.
3. Run `XCLMTXT` on a schedule containing 3FB1 with the job on Unit. Right: 3FB1 is on the First Floor group, not Third. Set the job to Level and repeat. Right: 3FB1 is on the Third Floor group.
4. Press Escape at the question. Right: nothing changes, no error. Press `U` afterwards. Right: it undoes your previous drawing action, not this command (this command drew nothing).
