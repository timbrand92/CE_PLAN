# 17 Oct 2026 — Tim asks for a V3 alignment reset before the colleague release

**Chat:** `CE_ACAD / general / plan / 01`, Sat 17 Oct 2026, about 03:10 Melbourne.

## Tim's words (verbatim, voice-typed)

> "I wanted to plan out this version 3 before its release to my colleagues. I wanted to feel like a really finalized
> and polished plugin software for AutoCAD. Now, it needs to work around our existing workflow and improve it, make it
> faster, make it more reliable, and just make day-to-day things so much easier. Now, it feels like I've gone round
> circles. I've given you answers. I've told you what things look like. I've told you how things work. But it kind of
> feels like this plan doesn't feel aligned. Like, it feels like civil and structural are kind of different in how they
> work. There's so much about what we've done that doesn't feel like a polished product, if that makes sense. I feel
> like it's all jumbled together because obviously this project started, you know, 2 years ago. So it's kind of just
> been built upon and built upon and built upon and built upon. And it doesn't feel like at any point we've kind of
> aligned everything and made it work in the way that it should, or how, you know, a professional company would make
> it work. I just want to see if we can, you know, fix this, plan it, make sure that this version 3 is good, make sure
> that building in the future is easier, and, you know, plans between you and I are done correctly and updates are
> implemented properly, and just the whole workflow just seems confusing, muddled, and doesn't all work together. And
> there's just so many things in my head that just don't work how I think they should, and I want to plan these out."

## What this is (and is not)

1. **A goal, not yet a decision on scope or order.** Nothing is paused, cut or re-ordered by this record.
2. **Four outcomes Tim named:** (a) V3 feels finished and polished, built around CE's existing workflow, faster and more
   reliable; (b) Civil and Structural work the same way; (c) future building is easier; (d) the way plans and updates
   pass between Tim and the AI is clean and reliable.
3. **Same bar as before:** 25 Sep, *"i want users to feel like theyre using a polished product similar to something
   apple or autodesk would design"* (`2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`). This reset does not replace those
   rulings; it asks for them to be made to fit together.

## What the planning chat found when it looked (17 Oct, read from the drive)

1. **572 plan files outside `archive\`**, 118 of them in `areas\` (most are run logs and audit reports, not areas).
2. **At least five overlapping "whole V3" plans:** `MASTER_PLAN.md`, `04_REFERENCE\V3_OVERALL_PLAN.md` (4 Sep),
   `04_REFERENCE\DRAWING_PRODUCTION_PLAN.md` (6 Sep), `04_REFERENCE\STRUCTURAL_LEVEL3_PLAN.md` (5 Sep),
   `04_REFERENCE\ux-plan\V3_UX_PLAN.md` (25-26 Sep), plus 73 UX cards and the 17 Oct gap audit.
3. **Gap audit 17 Oct:** 284 plan lines, 238 built as an engine, about 107 wired to a command, 77 installed, 0 accepted
   by Tim; 131 built but not reachable from AutoCAD.

## RULING A — pause new items, keep fixing (Sat 17 Oct 2026, about 03:20 Melbourne)

> "Okay, for now let's pause building of new items, but let's continue the fixing of existing items. The bug fixes
> are really important."

**Interpretation (planning chat):** no builder starts a new plan item or new engine until the one aligned plan replaces
the five. Bug fixes from `BUG_CARPARK.md`, review fixes on existing PRs and Codex testing carry on. Wiring an
already-built item to a command counts as a NEW item until Tim says otherwise. Passed to the desk (acting
controller) the same night.

## Tim's brain dump, part 1 (17 Oct, about 03:20), verbatim

> "What I feel at the moment is that every time I get grand ideas in my head and I want to implement them, and then,
> you know, things like the Apple and Autodesk feel, you know, it kind of feels like whenever I open a chat or a new
> one, it doesn't quite fully understand what I think version 3 plan is, and then, you know, when I audit, it just
> builds a whole new thing, and then there's on different workspaces and all sorts. It's just all so confusing, and
> it's not really managing me, whereas I just want to give it a plan, let it build, and then when I have a new idea,
> it implements it, and then the versioning control works. Testing is all done by Codex. It feels like the civil is
> really good and kind of working how I want it, or at least, you know, the plan, the final plan is something that is
> something I would, you know, feel accomplished having. It feels like the structural isn't up to that same level. It
> feels like there's no data and evidence model that you're following, even though we've got one. It doesn't feel like
> the program, it feels like the program is built, because I built it this way, from the function up as opposed to,
> you know, our workflow down. And it doesn't understand the context of what our workflow is and how it can improve
> it and how it can make it easy for the end user to use the program to make their life easier, if that makes sense.
> Often I get told that it's too hard to use, or nobody knows all the commands, or, you know, it doesn't really match
> how people work. And there's also like too many bugs and issues and problems. So all of that is really quite
> annoying. And also it just feels like every time I want to make an update, there's no real way of handling that
> nicely. And the testing process is bad, and it's long, and all of this building takes ages. Like, we've been working
> on this for 4 weeks. It's just taking way longer than I was expecting, and it's hardly tested at all, and I don't
> want to be the one testing it. I don't have the time for that. And then also how we can manage building and working
> at the same time, and yeah, it's just a muddled, jumbled thing, and I just want it to be so much easier for me when I
> go in there and always have something constantly building at the same time. And testing."

### Sorted into themes (planning chat's sorting, for Tim to correct)

1. **T1 Continuity:** a new chat does not know Tim's V3; an audit spawns a new plan or a new working copy.
2. **T2 Managing Tim:** Tim gives a plan and ideas; the system slots each idea in, builds it, versions it. Tim does
   not manage the AI.
3. **T3 Workflow down, not function up:** the plugin is organised by tool, not by how a CE job runs; the evidence
   model exists but is not followed.
4. **T4 Easy to use:** colleagues say it is too hard, nobody knows all the commands, it does not match how they work.
5. **T5 Structural below Civil:** Civil's final plan is one Tim would be proud of; Structural's is not at that level.
6. **T6 Reliability:** too many bugs.
7. **T7 Updates:** no clean way to take a change from idea to installed version.
8. **T8 Testing:** Codex tests, not Tim; today it is slow, long and covers little.
9. **T9 Speed and always-on:** 4 weeks in, slower than expected; building and testing should run constantly in the
   background while Tim works.

## Tim's brain dump, part 2 (17 Oct, about 03:35), verbatim

> "It would be great if we could decompile or use resources already on the internet to help us to build programs or
> elements of what we're building in this plugin that are already reliable, that are already working, that are already
> built, so that it can speed up the whole process. Obviously, I understand that building our own stuff is going to
> take a little longer, but it feels night and day length difference. And if we can sort of make the process a lot
> easier and faster, that would be great somehow. And obviously, some of the stuff that we're building doesn't relate
> to what other people are using or doing, but surely it can't be too difficult to do."

**Theme T10 Reuse before build** (planning chat's proposal, not yet a ruling): for every plan item, check in this
order and record which was used: (1) something AutoCAD already does (tables, fields, sheet sets, dynamic blocks,
data extraction, layer states); (2) Autodesk's own documented API and samples (incl. the Civil 3D API, already looked
at 10 Oct, `04_REFERENCE\CIVIL3D_API_FIRST_LOOK_2026-10-10.md`); (3) a free library whose licence allows company use
(MIT, Apache, BSD); (4) only then build CE's own. Decompiled Autodesk code (`C:\Tools\AcadDecomp`) is for
understanding how AutoCAD behaves, never for copying code into the plugin (licence). Same for other vendors' products
(12d, DRAINS, Civil 3D itself).

## RULINGS B — batch 1 answers (Sat 17 Oct 2026, about 04:20 Melbourne)

Questions as put (chat reply, 17 Oct): 1 one plan in job order; 2 Structural in the colleague release; 3 release ~10
finished tools per discipline, hide the rest; 4 a tool switches ON once Codex passes it in AutoCAD; 5 CE panel shows
job stages with a tick and one button (guide, not compulsory); 6 one Checks door (CDHUB, CDCHECKCURRENT fold in;
CDCHECK/CDRULES typed only); 7 headless read of 6-10 copied Structural jobs, results local only; 8 Manager = versions,
updates, rollback, Report a problem only; drafting tools on the ribbon; 9 first day = splash, one welcome card whose
Show me opens Start Here, tip once, made-up practice job in Help; 10 weekly 20-minute question session.

Tim's words:
> "yes to everything but
> -point 3, lets release with all features and then clean it up as we go along. id prefer to clean it up before
> issuing ideally
> -point 2, given structural is far away from ehere i want it, initially i wanted to release just civil and manager
> and then release structural when ready thoughts? also i always want the bleeding edge of whats built on my machine.
> ideally manager can handle all of this
>
> talk to me on a monday morning each week
>
> colleagues all use autocad only"

1. **B1 (Q1, 4, 5, 6, 7, 8, 9): YES** as put.
2. **B2 (Q3) — all features ship, tidy first where possible.** Interpretation: the colleague release is NOT trimmed to
   10 tools; every working feature ships. The tidy-up (one tab, job-stage order, names, switches ON after a Codex
   pass) is done before the colleague release where it can be, and continues after. Supersedes the planning chat's
   Q3 proposal.
3. **B3 (Q2) — Civil + Manager go to colleagues first; Structural follows "when ready".** Planning chat agreed in chat
   (17 Oct): Structural is the furthest from the bar, and this matches MASTER_PLAN §C.3. Structural keeps being
   built and planned (its job-order plan is part of the one plan) and installs on Tim's PC only.
4. **B4 — two install lanes, run by Manager.** Tim's PC always gets the newest build that has passed ("bleeding
   edge"), Civil + Manager + Structural. Colleagues get only versions marked as a release, Civil + Manager. Manager
   is to handle both. (Planned, not built; ruling A pause applies to building it.)
5. **B5 (Q10) — weekly question session: Monday morning.** A scheduled task `ce-monday-questions` starts a chat
   every Monday 08:40 Melbourne with the week's batch (set up 17 Oct).
6. **B6 — colleagues run plain AutoCAD only** (confirms 1a below).

## RULINGS C (Sat 17 Oct 2026, about 04:35 Melbourne)

> "lets learn from open cad studio, i dont plan on selling this program anytime soon so no need to worry about that.
> yes the slow part is as you said how can we make this more efficient and not as costly do research find solutions.
> the issues i have with using built in tools is everything we draw must look exactly like it currently does in our
> existing drawings both gor civil and structural. do you need more evidence for this on both sides?"

1. **C1 — Open CAD Studio (GPL-3.0) may be studied and reused.** Tim: the plugin is not for sale "anytime soon",
   so the GPL concern is waived for internal CE use. Planning chat note: if CE ever sells or gives the plugin outside
   the company, GPL-derived parts must be reviewed first.
2. **C2 — research the slow, costly part** (review, merge, install, testing) and bring solutions. Under way 17 Oct.
3. **C3 — HARD output rule: everything CE draws must look exactly like CE's existing drawings, Civil and
   Structural.** Built-in AutoCAD tools (T10) may only be used where their output can be made to match exactly.
   Same direction as "Copy exactly" (UX-CPLAN-06, UX-SSCHED-01, UX-SSCHED-05). The approved but never-started EV-06
   Gold Drawing Benchmark (`04_REFERENCE\CARDS\EV-06_GOLD_BENCHMARK.md`) is the planned way to prove it.

4. **C4 — performance, speed, reliability and robustness are first-class** (17 Oct, about 04:40):
   > "Performance and speed and reliability and robustness are all really important when it comes to this program as
   > well. So when we are building, testing and implementing, we need to make sure that this is also focused on."
   Planning chat's reading: every plan item carries a speed budget and a robustness check (bad input, Escape, Undo,
   big drawings, locked layers) as part of "done", tested automatically, and AutoCAD slowness is measured, not felt.
   Earlier evidence: memory/plan note 29 Sep (AutoCAD main thread busy, PC starved by builds and tests).

## RULINGS D (Sat 17 Oct 2026, about 05:00 Melbourne)

> "what I mean by looks exactly like ours is, you know, the schedule blocks need to look like ours. Basically, the
> drawing need to export similar to how ours is. Obviously, each job has a different way that it's laid out and drawn,
> but in terms of the elements on the drawing, we need to manage all of that. Also, we need to manage weekly usage
> limits, and I want you to work autonomously between you and Codex. And let's think about any other subscription
> that we need to get to build this slash test it faster or better. And then obviously what model and thinking is
> required for this stuff, and just making sure that this is all checked and working and built and everything is done
> efficiently, effectively, and under good time schedule within usage limits each week and working throughout the day
> so we don't lose time. Obviously, time is of the essence, and it's one of the most important factors in this whole
> thing. In terms of questions that you've asked me, let's think about doing the tests and the AutoCAD on a separate
> PC. I can definitely sort that out without having to sort of pay for anything and sort it out. We've got plenty at
> work that we can work from. So if that's something that needs to be set up, how do I manage it between you building
> and maybe you build on that computer as well, and how I continue working on my own computer? Let's think about
> that. In terms of clearing out the old unfinished pile, I don't know what you mean by this, but maybe be a bit more
> clear with what that means. And yeah, I don't really want to delete anything. I just want to compile everything,
> make sure we haven't missed anything, make sure that it all becomes part of our plan. Obviously, the most important
> thing is time, efficiency, and working towards helping creative engineering with drafting and engineering and
> making it look and feel the same as our current drawings are now. What should accept mean? Yeah, look, I don't want
> to be massively testing things ages. I'm not one to test. I think that needs to be done by a computer or by AI by
> itself without me engaging with it. Then obviously, you know, I don't need to be involved in that process. You come
> up with whatever the best way about it going is."

1. **D1 — "looks like ours" means the ELEMENTS, not the sheet layout.** Schedule blocks, labels, symbols, text,
   layers, linetypes and exported output must match CE's existing drawings; how each job is laid out varies and is
   not compared. Refines C3. The gold check (EV-06) compares element by element.
2. **D2 — autonomous Claude + Codex, managed inside weekly usage limits, working through the day.** Time is "one of
   the most important factors".
3. **D3 — look at other subscriptions** that would build or test faster or better (planning chat to recommend with
   figures).
4. **D4 — the AI picks model and thinking level per job**, aiming at efficiency inside the limits.
5. **D5 — a separate work PC (no purchase) for AutoCAD testing, and possibly building.** Supersedes the 24 Sep VM
   plan in `04_REFERENCE\TEST_STATION_SETUP.md` (never got past set-up: nothing installed, no run). Open condition:
   that PC's AutoCAD needs a licence not in use on another PC at the same time. 17 Oct ~05:15 Tim: *"i have a spare
   pc with autocad on it already , happy with the rest"*; the signed-in account is checked during set-up
   (`04_REFERENCE\TEST_PC_START_PROMPT.md` step 3).
6. **D6 — nothing deleted. Every unfinished piece of work (the ~900 open PRs) is compiled, checked against the plan,
   and either becomes part of the one plan or is recorded as covered elsewhere.** Supersedes the planning chat's
   "keep ~30, close the rest" proposal.
7. **D7 — acceptance is done by computer/AI, not Tim.** Tim: "I don't need to be involved in that process. You come up
   with whatever the best way about it going is." This overrides RULES 4.5 for testing (RULES 14.6 override; scope:
   CE_ACAD, from 17 Oct 2026). Planning chat's design, to be written into the one plan: "Robot-accepted" = every
   automatic gate green + Codex/driver check in real AutoCAD on the test PC with screenshots + 5 working days on Tim's
   PC with no new bug against it. Tim can still reject anything. Engineering judgement (council values, design rules,
   sizing) still goes to the Monday session as questions, not tests.

## RULING E (Sat 17 Oct 2026, about 05:25 Melbourne)

> "im away from work until 29th so we can test and build as we need until that day"

1. **E1 — until Thu 29 Oct 2026, building and AutoCAD testing may run at any hour on Tim's PC**, for all CE work
   (not only the Codex verification goal of the 14 Oct override, `2026-10-14_HOLIDAY_TESTING_HOURS_UNTIL_29_OCTOBER.md`,
   which this widens). RULES 1.8 / ROUTER AutoCAD windows are overridden for this period (RULES 14.6). Return hour on
   29 Oct not given; do not invent one. Installs on Tim's PC continue under the release charter.
2. **Consequence (planning chat):** the spare test PC is at work, so its set-up waits until Tim is back; Tim's own PC is
   the test machine until then. Robot gates, the pile compile and the one plan are process work, not new plugin items,
   so ruling A does not pause them.

## RULING F (Sat 17 Oct 2026, about 05:50 Melbourne)

> "lets issue to max on monday 9th novermber. i also would like to check your plan before we execute, so you go on
> with that and then show me visually so i can cehck or show me without software jargon"

1. **F1 — colleague release (Civil + Manager) to Max on Monday 9 November 2026.** Supersedes the 29 Sep target
   (`2026-09-23_V3_COLLEAGUE_RELEASE.md`). Pilot colleague "Max" from 8 Oct (INT-071).
2. **F2 — Tim checks the one plan before it is executed**, shown visually, no software jargon.
   Planning chat's reading: until Tim has checked it, only these continue: bug fixes (ruling A), testing, reading and
   measuring that feeds the plan (element catalogue, pile compile, speed baseline). Structural changes (one code line,
   ribbon reorganisation, robot gate as a hard block, Manager channels) wait for his check.

## RULINGS G — plan page draft 2 questions (Sat 17 Oct 2026, about 07:00 Melbourne)

Page: https://claude.ai/artifact/MARLzjbaDrfS6zg3WkRDWi (version 2), copy in
`04_REFERENCE\one-plan-draft-2026-10-17\ce-v3-one-plan.html`. Tim:

> "all yes, what about setup of architerctural backgrounds, what about difference ebtween an engineer working and a
> draftsperson or a person design and drafting simulataneously and one is drafting from a plan. also how does it
> handle details, custom sections and jobs with basements or commercial or industrial projects. i am still not
> convinced the full data/evidence model understands all of our job types, details and how we draft"

1. **G1 ribbon** as drawn on the page: one CE tab, panels left to right in job order (Job, Background, Design,
   Draw and label, Check, Sheets, Calcs, Issue for Civil; Job, Background, Framing roof down, Footings, Annotate,
   Check, Sheets, Issue for Structural), shared Job/Check/Sheets/Issue panels. YES.
2. **G2** double-click any CE object opens its Edit window, the same window as when placed. YES.
3. **G3** Structural windows match Civil (New Beam / Edit Beam look like New Pipe). YES.
4. **G4** one CE Properties palette for all CE objects, Civil and Structural. YES.
5. **G5** Pit Schedule typed value: row turns amber, one click Update changes pit + plan text + schedule, one Undo.
   YES. Settles UX-SCHED-01b vs INT-075 Set A 4.
6. **G6** OSD criteria block: placed once, then fills itself live from the design; hand-typed values kept and flagged.
   YES. Settles UX-CALC-02 / UX-DET-08 / UX-CPLAN-07.
7. **G7** minimum pipe cover default 300 mm. YES (Settings value; Set C Q5 closed).
8. **G8 — Tim is NOT convinced the evidence model covers CE's job types, details and drafting.** Raised: architectural
   background set-up; engineer vs draftsperson vs one person designing and drafting at once vs drafting from a
   plan; details and custom sections; basements, commercial and industrial jobs. Planning chat checked 17 Oct:
   no job-type catalogue exists in CE_PLAN; the background set-up card (`STRUC-ARCH-BACKGROUND_CARD_2026-09-26`) is
   blocked because only one prepared Xref was ever read; basements are ruled (UX-BSMT-01..06), commercial and
   industrial appear only as Civil council values. Tim's concern is upheld. The plan is NOT yet approved (F2 open).

## RULINGS H (Sat 17 Oct 2026, about 07:15 Melbourne)

> "what about situations when a job is drafted and we need to make quick changes without being interrupted.
> 1. yes
> 2. yes
> 3. yes i want to start building the library if we can, you should know where everything is lcoated
> 4. yes"

1. **H1 — the robot may read about 60 real issued jobs from the office Projects folder,** read-only, from copies,
   identifying material kept local only, to build the CE drawing atlas across job types (DATA-01 authorisation,
   scope: this atlas). Brief: `04_REFERENCE\one-plan-draft-2026-10-17\EVIDENCE_JOB_BRIEFS.md` job 2.
2. **H2 — the four working situations match how the office works** (from markup; designing and drafting at once;
   engineer designing only; two people at once). Planning chat's reading of "yes" to the example: an
   engineer-checks-the-drafter step exists and gets its own flow in the plan (check plot "For engineer",
   UX-REG-13..15, plus the markup check list). Confirm at the next Monday session.
3. **H3 — custom detail "Save to library", this job only by default; an engineer promotes it to the office
   library.** Tim also: "i want to start building the library if we can". Library catalogue starts now from
   `...\Creative Engineering - Drafting\Standard Details` (184 DWG on 17 Oct). Brief job 1.
4. **H4 — Civil items not dependent on the atlas start building now:** Checks list, Tidy labels, Edit windows
   (one-page, G2/G3). Planning chat's reading: this is Tim's approval for those three under F2; everything else
   in the plan stays unapproved until the atlas is in.
5. **H5 — new concern: quick changes on a drafted job "without being interrupted".** Proposal put to Tim in chat
   (17 Oct): once a drawing has been issued, CE goes quiet by itself (see chat). Open until answered.

## Open (Tim to answer; never fill these in)

1. Tim's brain dump continues — part 3 onward to be added here.
1a. ANSWERED 17 Oct about 04:05: *"colleagues use regular autocad but we could inclrporate civil 3d stuff if it
    helps"*. Planning chat's reading: the plugin must run on plain AutoCAD; Civil 3D can be used for importing
    consultants' Civil 3D work and as a source of ideas, never as something colleagues must have. Tim also asked
    how browser CAD projects (Open CAD Studio, GPL-3.0, opencadstudio.com) exist without copying decompiled code;
    answered in chat (own code reading the DWG file format; copyright covers code, not formats or ideas).
    Original question: Do colleagues run plain AutoCAD, or Civil 3D? (decides whether Civil 3D's own pipe networks and surfaces can be
    reused). Not found in the plan on 17 Oct; the 10 Oct "Civil 3D yes" covers research only.
2. Whether wiring already-built items counts as "new" under ruling A (planning chat's reading: yes, paused).
