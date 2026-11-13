# One drafter, one civil job: what CE should feel like

**DRAFT by the controller (CE_ACAD / trust plan / plan / 01), Sat 14 Nov 2026. Written at Tim's request: "you think about how one end user might use this plugin for civil design ans then think of most useful areas and how best to display, use, integrate, implement them". Nothing here is decided until Tim says so. Tool names are from the 47 core tool notes in `04_REFERENCE\core-tool-notes\`. Assumption to check with Tim: the usual job is a site stormwater drainage plan for council.**

## 1. The drafter's day, in the order the work happens

1. **Start the job.** New job drawing (CDNEWDWG), then the job's council, rainfall and design inputs (CDRULEBOOK, CDRAINFALL, CDDESIGN). Office numbers come from Civil Settings (CDS), set once.
2. **Mark where water comes from.** Downpipes (DP), overflows (OF, FO), floor wastes (CDFW), strip drains (CDSTRIP), trench grates (CDTG), other sources (CDSOURCE), tags (CDTAG). Tanks and raingardens (CDWT, CDRG).
3. **Lay the network.** Pits (PIT, PP), inspection openings (IO), pipes (CD), AGI drains (CDAGI), systems (CDSYSTEM), and the one outlet: the legal point of discharge (CDLPD).
4. **Set the levels.** Spot levels (CDSL), top water level (CDTWL), solve inverts down a run (CDRUNSOLVE), fix one pit or pipe (CDEDIT), reverse flow (CDREVERSEFLOW).
5. **Check it.** Calculations (CDCALC), council rules (CDRULES), where each downpipe ends up (CDDEST), check this drawing (CDCHECKCURRENT), Inspector (CDINSPECTOR).
6. **Put it on the sheet.** Renumber from the outlet up (CDRENUMBER), Pit Schedule (PITSCHEDULE), long section (CDPROFILE), tidy the labels (CDTIDYLABELS, CDANNOTATIONEDIT, CDMA, CDTEXTSEG, CDPITCOVERFLIP), layers (CDMANAGER).
7. **Markup comes back.** Move or copy things (MR, CR), edit, then levels, checks and schedule again.

Stage 7 is most of a real week. A plugin that is good at stages 1 to 6 once, and poor at doing them again after a change, saves little.

## 2. The five areas worth the most

Ranked by how often a drafter needs it, how much time it saves, and how badly a mistake hurts.

1. **"Is this drawing OK?" at a glance.** One line that is always in the same place: how many pits and pipes CE knows, how many Unknowns, how many rule warnings, whether the schedule on the sheet is out of date. Reads only, never changes anything.
2. **Levels that solve themselves and show their working.** Pick a run, see every invert, cover and fall in a preview before anything is written, with the leg it will follow shown on the plan.
3. **A schedule and long section that cannot disagree with the plan.** Both read the same record as the plan. When the plan changes they are marked "out of date" until refreshed.
4. **A council check that gives reasons.** Each warning names the pit or pipe, the rule, the number found and the number required, and zooms to it on a click.
5. **Change after markup that does not break the job.** Move, copy, edit and renumber keep pipes joined, levels sensible and labels attached, in one Undo.

Everything else (the many source types, label nudging, layer colours) supports these five.

## 3. How to show it

1. **Ribbon in job order, left to right:** Start, Sources, Network, Levels, Check, Sheet. Six panels that match section 1. A new drafter reads the ribbon as the method.
2. **One status line, same place every time** (area 1). Quiet when all is well; colour and bold only where a decision is needed.
3. **One Inspector.** Click any pit, pipe or source and see what CE knows about it. Known values plain, Unknown in colour, values CE worked out marked as worked out.
4. **Preview before every change.** What will change, how many objects, on the plan and in a short list. Cancel or Esc writes nothing.
5. **Results as a list you can click.** Every check, schedule row and warning zooms to its object.
6. **Plain words.** No software terms anywhere a drafter reads.

## 4. How the parts join up

1. **One CE record per drawing,** never shared between open drawings.
2. **Plan, schedule, long section, calculations and checks all read that one record.** No tool keeps its own copy.
3. **The outlet (LPD) is the one start point** for numbering, runs and calculations (Tim's answer B4 of 12 Nov).
4. **Every number comes from Settings** (office) or the job's rulebook (council). Nothing is fixed in the tool.
5. **Unknown stays Unknown.** CE never fills in a size, material or level it was not given.
6. **One door for every change:** right drawing, locked layers and xrefs respected, one Undo, nothing on Cancel, says what changed.

## 5. How to build it, in the order of the day

Proposed ten, replacing the controller's first draft order in `areas\trust-run\QUEUES.md`. Each one: known faults fixed on its existing drafts, moved onto the one door, seen in real AutoCAD on scratch copies, installed with Tim's word, accepted by Tim.

1. **Place a pit (PIT).**
2. **Draw a pipe (CD).**
3. **Legal point of discharge (CDLPD).** Fix drafted, reviewed GO.
4. **Edit a pit or pipe (CDEDIT).** Changes on Cancel and made-up values: seen in AutoCAD.
5. **Solve inverts down a run (CDRUNSOLVE).** Fix drafted, needs more work.
6. **Renumber (CDRENUMBER).** Crash fix seen working on the installed build.
7. **Pit Schedule (PITSCHEDULE).** Plastic pits left out; Export CSV fix reviewed GO.
8. **Check against the rulebook (CDRULES) with calculations (CDCALC).**
9. **Check this drawing (CDCHECKCURRENT)** as the status line of area 1.
10. **Move and rotate (MR).** First tool already on trial.

Safety fixes that sit outside the ten and go first because they can lose work: two jobs mixed up (installed on Tim's PC, robot-proven) and CLEAN / FASTSAVE saving over a template (fix reviewed GO).

After these ten, one drafter can take a simple job from blank drawing to council sheet and through one round of markup on tools that have each been seen working. That is the first thing worth handing to a colleague.

## 6. Open for Tim

1. **Is the usual job a site stormwater plan for council,** or should the walk-through follow a different kind of job?
2. **Is this the right ten?** ANSWERED Sat 14 Nov 2026 00:28: "Yes, use that ten (Recommended)". He can swap any later.
3. **Ribbon in job order:** agreed, or keep today's layout?
