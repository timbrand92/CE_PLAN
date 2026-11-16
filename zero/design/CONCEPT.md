# The new plugin: concept (draft 1)

**Made:** Mon 16 Nov 2026 by the planning chat, at Tim's request ("i want to see what your interpretation of the new plugin would be like if you were to design it from scratch based on what you learnt"). **Status:** my interpretation, for Tim to react to. NOT approved. No dates. Nothing here says how it is built inside; that is Stage 4 research, and each "must" below becomes a test there.
**Picture version for Tim:** `..\pictures\new_plugin_concept.html`.
**Built on:** decisions D-001 to D-030, the civil study in `..\evidence\`, and the reference library.

## 1. The idea in one paragraph

The drawing holds ONE drainage network for the job: pits, pipes, tanks, inlets and the discharge point, each knowing what it connects to and holding its own facts once. Everything on the sheet (pipe labels, level text, pit tags, the pit schedule, the detention criteria box, the numbers inside the orifice pit and tank details, the computations sheet) is a view of that network and re-reads itself when a fact changes. Each visible part can still be dragged on its own. Standards (layers, text sizes, distances, wording, symbols, pit and pipe sizes, council rules) live in one office standards file. What prints is made only of ordinary AutoCAD objects, so a PC with no plugin sees and plots the same sheet.

## 2. Principles (each traces to a decision)

1. **CP-01 One network, parts still editable** (D-011). Select any part and the whole element knows; drag one part and only that part moves.
2. **CP-02 Type once** (D-002). A fact has one home. Every other showing of it is read from there.
3. **CP-03 One place for standards** (D-012, D-013). Distances, sizes, wording and symbols come from the office standards file. A hand move is remembered as an exception and can be reset (D-014).
4. **CP-04 Looks and plots identical with no plugin, proven every release** (D-015). The test is run on a PC with nothing installed, comparing the plot.
5. **CP-05 The engineer decides levels; the plugin shows the room** (D-016, D-017, D-018). It never re-levels by itself. It shows fall available against fall needed, which end is critical, and what each choice would change, before anything changes.
6. **CP-06 Sums inside, shown as sums** (D-021). Every worked-out number can be opened to see its sum and where each input came from.
7. **CP-07 Nothing disagrees silently** (D-003). Where two sources differ the user picks one or writes a short reason; the choice is kept.
8. **CP-08 Assumed is visible until confirmed** (D-030). An assumed value shows amber in the panel and carries its "to be confirmed" wording onto the sheet by itself.
9. **CP-09 Council, then AS 3500.3, then office** (D-022). Each limit shows which of the three it came from.
10. **CP-10 Small on the surface** (D-001, D-004). One ribbon tab, about 20 buttons, one side panel. No hidden commands needed for normal work. Repair tools are not part of normal work.
11. **CP-11 Built to be added to** (D-009). A new kind of thing (a pump station, a soakage pit, a new council) is added as data and one new element kind, not by reworking what exists.
12. **CP-12 One undo, no "are you sure"** (R-41). Anything that changes engineering values shows a preview and needs a click (R-55).

## 3. What a job looks like, start to issue

1. **Start the job.** Pick the job folder and sheet size. The template opens with the title block filled from the job facts. No parked kit of samples beside the sheet: the buttons replace copy-and-fill.
2. **Job facts (typed once).** Council (picked from a list, which brings its rules), discharge point and its invert (given or assumed), permitted discharge and storage if given, method (given figures, Boyd's, OSD4W result typed in), storms, STORM tank figures. Each fact carries a status: given, measured, chosen, worked out, or assumed.
3. **Areas.** Pick roof and paving outlines on the background; each area is named and counted once (site, impervious, pervious, roof to each tank).
4. **Place the network.** Pit (click; size and type from the standards; cover level picked from a survey level or typed). Pipe (pick from, pick to; size and class default from the standards; label, walls, flow arrow and both invert texts appear at standard distances). Downpipes, inspection openings, floor wastes, overflows, tanks, trench grates the same way: one click each, tagged and counted.
5. **Set levels.** The levels view shows each run from its top to the discharge point: fall available, fall needed, the slack, and which end is critical. The engineer locks what is fixed (connection invert, cover levels, top water level and orifice are locked by default, per D-018) and chooses per run: work up from the outlet, or down from the top, at a chosen grade. A preview shows every invert that would change; one click applies; one undo reverses.
6. **Detention (when the job has it).** The storage list builds itself from the pipes, pits and tanks marked as detention. Volume required comes from the council's figure, Boyd's inside the plugin, or a typed OSD4W result. Orifice size is tried against the permitted discharge with the sum shown. The share underground is shown against the council's minimum.
7. **Checks, always on, one list.** Plain words, green / amber / red with a word: storage against required, orifice flow against permitted, each pipe's grade and cover against the governing limit, pit depth against pit size, top water level below every cover, clearances, every assumption still open.
8. **The sheet.** Pit schedule, criteria box, roof-to-tank box, the job's orifice pit and tank details, council notes for that council, legend, title block, revision rows and issue stamp are placed from buttons and stay tied to the network. Standard details come from the office library by name.
9. **Issue.** One step: check list must have no red, pick the stage (preliminary, for council approval, construction), add the revision row, plot the PDF set, and save the computations PDF beside it. The no-plugin copy is the same file.
10. **A change arrives** (council moves the discharge invert 50 mm; architect moves a wall). Change the one fact or drag the one pit. Everything that reads from it updates; anything that now fails goes amber or red; nothing engineering changes without a click.

## 4. How one element is put together (the model, built to be added to)

Every kind of thing in the network is described the same way, so new kinds can be added without touching the old ones.

1. **Facts it holds** (each with a status and a source): e.g. a pit holds number, type, size, cover level, lid class, each connection's invert.
2. **Parts it shows on the plan** (each an ordinary AutoCAD object with a standard position from the standards file, and an optional hand-moved position): e.g. a pipe shows the band, the walls, the label, the flow arrow, an invert text at each end.
3. **What it connects to:** a pipe has a from and a to; a downpipe feeds a pipe or a tank; a tank has an inlet, an outlet and an overflow.
4. **The sums it feeds:** a detention pipe feeds the storage list; a pit feeds the schedule and, if it holds water, the storage list.
5. **Where else it appears:** schedule row, criteria box line, detail values, computations sheet.
6. **Its checks.**

Element kinds for the first release: pit (junction, grated, plastic, orifice / control), pipe (gravity, charged, detention, existing), inlet symbol (downpipe, inspection opening, grated inspection opening, floor waste, overflow, surcharge), water tank, line drain (trench grate, spoon drain, agricultural drain), discharge point, level tag (floor, finished ground, pavement), area (roof, paving, pervious). Later kinds, each added the same way: pump station and rising main, soakage pit, raingarden, modular tank, outfall with long section, basement drainage.

Fact statuses (five, deliberately few): **given** (council, survey, report), **measured** (off the drawing), **chosen** (by the engineer), **worked out** (by a sum), **assumed** (until someone confirms it). The old model's layers of certainty and approval are not carried over (D-004); this is a Stage 3 item for Tim to confirm.

## 5. The standards file (one place)

1. **Drafting standards:** layer for every part, colour and linetype; the one text style; text height for each purpose (invert 1.8, cover 2.0, labels 2.5, tags 3.5, titles 5 and 7); standard distance of each label from its object; wording patterns ("{dia} DIA. {material} {class} PIPE AT 1 IN {grade}"); symbol for each inlet; pit symbols by size and type; schedule and criteria box layouts; title block and stamp wording.
2. **Engineering standards:** pipe sizes, materials and classes with real diameters; pit sizes with maximum depths; minimum grades; cover by situation; orifice coefficient; tank orifice 30 (D-024); runoff coefficients; lid classes.
3. **Council rules, one dated row set per council:** method, storms, coefficients, minimum orifice, share underground, tank credit rule, required notes and details, how to submit, what they commonly send back.
4. **Order of authority** (D-022): council, then AS 3500.3, then office. Each conflict found in the study is listed once for Tim to settle.
5. **Who can change it:** the office standards are shared by everyone and changed in one place by Tim (or whoever he names); a job can carry a marked exception. Personal preferences are few (window position, last-used values).

## 6. CE tools and the Manager

1. **CE tools:** one small set of everyday helpers that exists once and works on any PC with the plugin: move + rotate, copy + rotate, leader, dimensions, hatches by pen, layer-by-pen quick set, revision cloud, clean and purge, background (Xref) tidy, copy as block. Chosen from what is actually used (usage records and Tim), not from the 486 old names. Old typed names kept where they are habit (MR, CR, Q, LD).
2. **Manager:** three things only. What is installed (one version for everything). A new version offered when AutoCAD starts, one click, no administrator rights, with one-click go back (D-028). Send a fault report. Tim's side: publish a version to named people first, then everyone.

## 7. Packaging, from the core (D-007), as requirements for Stage 4

1. One package, one version number, AutoCAD 2027 only (D-008). Civil, CE tools and Manager are parts of one thing, not three things that must match.
2. Installs per user with no administrator rights. Updating never needs AutoCAD closed by hand at an awkward moment: it applies at the next start.
3. One settings folder per user; the office standards in one shared place.
4. No leftovers: no backups piling up in AutoCAD's folders, no second copies of helpers.
5. A drawing made with it opens, looks, plots and can be edited as ordinary AutoCAD on a PC with nothing installed (CP-04). Whether the hidden tie between parts survives an outsider's edit is a Stage 4 question; if it cannot, the plugin must notice on the next open and say what changed.

## 8. Releases, smallest first (order, no dates)

1. **Release 1: carry one real house or units job from start to issue.** Job facts, areas, pits, pipes, inlet symbols, tanks, levels view, checks, pit schedule, title block and issue, the no-plugin proof, the update path, the CE tools set. Job kinds covered: plain house, and any job whose detention figures are given.
2. **Release 2: detention complete.** Boyd's inside, storage list, orifice sum, criteria box, the job's orifice pit and tank details, computations sheet. Covers houses and units with detention, OSD4W jobs (result typed in), council-supplied jobs.
3. **Release 3 onwards, one kind at a time, in the order Tim ranks them:** pumped, soakage, raingarden, outfall with long section, industrial, basement, civil site drawings, adopt an old drawing.
4. **Then structural** (D-006).

Each tool in a release gets its own interview, design record and mock-up before any building (R-14, R-15).

## 9. What this concept deliberately leaves out

1. No automatic design (no auto-routing, no auto-sizing). It shows, checks and carries; the engineer designs.
2. No import of other firms' drawings in the first releases.
3. No AI features in the first releases; where they come later they read documents into drafts a person places (R-54).
4. No approval-state tracking beyond the issue stamp and revision row.

## 10. What must be proven before this can be promised (Stage 4)

1. The best way in AutoCAD 2027 to make ordinary objects behave as one element with separately movable parts, and what survives copy, mirror, stretch, undo, save and reopen, and an outsider's edit.
2. The no-plugin proof (CP-04), including what went wrong in the live case (P-04).
3. Install and update with no administrator rights.
4. How the network and standards are stored so that later tools read one place.
5. How it is tested without a person (R-19).
