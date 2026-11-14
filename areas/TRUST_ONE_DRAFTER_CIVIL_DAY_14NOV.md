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
   - **CONFIRMED by Tim, Sun 15 Nov 2026 02:02 and 03:25 (ask chat; interview 5.3 and 11a).** First asked at 01:59 he typed "think about this more"; shown a picture he clicked "Yes, as pictured (Recommended)", and from a mock-up file chose its place: "B: top left of the drawing". Since the schedule now updates itself (item 3), the line would say "Schedule updated 10:42", not "out of date". A picture approval, not a build.
   - **Related, and different from this draft:** WHEN the council check runs. Tim, 01:55 (interview 5.1), clicked "Before schedule or plot" (choice text: "you draft undisturbed; when you place the Pit Schedule or plot, CE runs the check first and lists anything open"), passing over "When I ask, plus a quiet line (Recommended)". At plot time with open warnings he clicked "Show them, I choose" (5.2).
2. **Levels that solve themselves and show their working.** Pick a run, see every invert, cover and fall in a preview before anything is written, with the leg it will follow shown on the plan.
3. **A schedule and long section that cannot disagree with the plan.** Both read the same record as the plan. When the plan changes they are marked "out of date" until refreshed.
   - **SUPERSEDED by Tim's answer, Sun 15 Nov 2026 01:55 and 01:59 (ask chat; `trust-run\TIM_INTERVIEW_15NOV.md` 6.1 and 6.2), the "out of date until refreshed" part only.** Asked what the Pit Schedule should do when a pipe changes on the plan, he clicked "Update itself" (choice text: "you change P4 to P5 from 150 to 225 and the schedule row changes by itself, with one line saying it did"), passing over "Mark it out of date (Recommended)". Asked whether the long section and calculations do the same, he clicked "Yes, all follow the plan (Recommended)". A later idea, not a build.
4. **A council check that gives reasons.** Each warning names the pit or pipe, the rule, the number found and the number required, and zooms to it on a click.
5. **Change after markup that does not break the job.** Move, copy, edit and renumber keep pipes joined, levels sensible and labels attached, in one Undo.
   - **Made specific by Tim, Sun 15 Nov 2026 01:55 (ask chat; interview 7.1).** Asked what happens to pipes and levels when pit P4 is moved 2 m with MR, he clicked "Pipes follow, ask about levels" (choice text: "the pipes stretch, then CE offers the solve preview for that run: Apply to update the levels or Esc to keep them"), passing over "Pipes follow, levels kept, flagged (Recommended)". A later idea, not a build; MR's proof in the ten is unchanged.

Everything else (the many source types, label nudging, layer colours) supports these five.

## 3. How to show it

1. **Ribbon in job order, left to right:** Start, Sources, Network, Levels, Check, Sheet. Six panels that match section 1. A new drafter reads the ribbon as the method.
   - **A mock-up of this was OK'd by Tim, Sun 15 Nov 2026 03:20 (ask chat; `trust-run\FOR_TIM_QUEUE.md` item 8 under "Answered").** File: `04_REFERENCE\mockups\RIBBON_JOB_ORDER_15NOV.html`. He clicked "Yes, OK as shown (Recommended)" (choice text: "this becomes the layout the Civil ribbon is built to, once the tools on it are proven"). Two of his own choices in it: "One tab, as pictured" (CE Design folded into CE Drainage) and Edit pit or pipe in "Network, beside Pit and Pipe". A picture approval, not a go-ahead to build.
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

1. **Is the usual job a site stormwater plan for council,** or should the walk-through follow a different kind of job? ANSWERED Sun 15 Nov 2026 01:51 (ask chat; queue item 7): "Site stormwater for council (Recommended)".
2. **Is this the right ten?** ANSWERED Sat 14 Nov 2026 00:28: "Yes, use that ten (Recommended)". He can swap any later.
3. **Ribbon in job order:** agreed, or keep today's layout? ANSWERED Sun 15 Nov 2026 03:20 (ask chat; queue item 8): mock-up OK'd, "Yes, OK as shown (Recommended)"; see the note under section 3 item 1.

## 7. Later answers from Tim that sit beside this draft (added Sun 15 Nov 2026 by the ask chat at the controller's request; the draft above is not rewritten)

1. **A new job begins with New Job, one window** (01:51; interview 1.1), and the architect's plan sits "As an xref, CE never touches it" (01:53; 1.2). Section 1 stage 1 lists the same tools; his answer fixes the order.
2. **Downpipes:** "Both: propose where it can" (01:53; 2.1) and "Nothing placed until I tick" (01:55; 2.2). Not in this draft.
3. **Laying the network:** "Pits first, then pipes" (01:53; 3.1), as section 1 stage 3 has it.
4. **Solving levels:** "Preview first, then Apply" (01:53; 4.1), as section 2 item 2 and section 3 item 4 have it.
5. **Unknown:** "Unknown everywhere" for a pipe with no size or material, and his own idea to read missing values from the Pit Schedule as Proposed (02:02 to 02:04; interview section 11, Q9 to Q12). Section 4 item 5 agrees; the schedule idea is new.
6. **His whole-product direction of 03:27** ("it feels complex and feels like it was built by ai with no considerarion for how its used by humans") and the seven rules he made "the plan's focus" at 03:30 are in interview sections 12.3 and 13 and in `trust-run\FINAL_PRODUCT_DRAFT_15NOV.md`. They are wider than this draft, which covers one drafter and Civil only.
7. **Held by the controller until he confirms them himself** (queue items 12, 13, 14): building the simpler layout now; CE acting by itself on levels, sizes, numbers, labels and layers; copying finished jobs from the office Projects folder. Until then section 4 item 6 ("One door for every change") and section 3 item 4 ("Preview before every change") stand as written.
