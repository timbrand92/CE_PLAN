# One V3 plan — House rules (every CE command: Civil, Structural, Manager)

**Draft for the one plan, planning chat, Sat 17 Oct 2026. Not a ruling.** Every line cites the ruling it comes from.
Tim's words are in the decisions files named at the end; nothing here adds a decision. Anything that is the planner's
own joining-up is marked "(planner's reading)".

**The bar (Tim, 25 Sep, restated 17 Oct):** *"i want users to feel like theyre using a polished product similar to
something apple or autodesk would design"*. On 17 Oct Tim added: Civil and Structural must work the same way (reset
outcome b); everything CE draws must look like CE's existing drawings, element by element (C3, D1); speed,
reliability and robustness are first-class (C4); all features ship, tidied before release where possible (B2).

**How to read each rule:** one plain line; what a Civil drafter sees; what a Structural drafter sees; the rulings
behind it; status today (Built / Codex-checked / Installed are separate facts, never a percentage); how the robot
checks it.

**Status sources:** the 17 Oct findings, the Batch 2/3/4 cards (code read on Civil release 446162c2, 9 Oct) and the
area file. None of it was seen in AutoCAD by this planner. Installed today: Civil 3.0.51 / Manager 1.1.51,
Structural 1.0.118 (START_HERE, 17 Oct 05:19), not driven in AutoCAD.

**Hold:** under ruling A (pause new items) and ruling F (Tim checks the one plan first), most "not built" items
below wait. Bug fixes continue.

---

## 1. Look: one CE window, every time

1. **The rule:** every CE window has the New Pipe header (CE logo, window name, one line saying what you are working
   on, status top right) and footer (tools bottom left, Cancel and the one gold main button bottom right), in CE's
   colours gold, black and white/grey, never blue.
2. **Civil sees:** Edit Pit, Pit Schedule, Settings and Project Review all open with the same logo, summary line
   ("Pit P4 · Grated pit 600 × 600") and the gold Save bottom right.
3. **Structural sees:** the XCLM text window, the beam and footing windows and CESHEETS open with the same header and
   footer as Edit Pit; today they have none of it.
4. **Fit and scrolling:** every window fits a 1920 × 1080 laptop at 150% with nothing cut off; tabs only for truly
   separate topics (Settings, CDCALC); no collapsed sections; high-use windows never scroll their layout; long lists,
   schedule rows and help pages may scroll inside their own panel.
5. **Keys and comfort:** Enter = main button, Esc = Cancel; Tab runs top to bottom, left to right; Alt shortcuts on
   main buttons (Alt+S Save); each window reopens where you last left it; preview follows typing after about 0.3 s;
   editors hold AutoCAD until Apply/Cancel, palettes (Properties, Checks, Proposals) stay open; every status has a
   symbol as well as a colour; windows follow Windows scaling; type, buttons and shared colours as reviewed 5 Sep.
6. **Rulings:** UX-LOOK-01 (25 Sep), INT-075 Q8 "no blue" (9 Oct), Batch 3 Q9-13 as recommended (INT-075), HELP-SCROLL
   ruling (24 Sep, Tim: happy to scroll "when you would have to implement a next page button"), UX-WIN-01..04,
   UX-ACC-01..03, UX-STD-08 (one green line when OK).
7. **Superseded:** 4 Sep "CE deep blue #1E5AA8 on light" (superseded 9 Oct by INT-075 Q8); 5 Sep "Settings window is
   the reference look" (superseded in part 25 Sep by UX-LOOK-01: header/footer follow New Pipe, colours/type stand);
   "graphite" accent (findings §4.1).
8. **Status:** Civil: 4 of about 12 main windows have the look (New/Edit Pipe, New/Edit Pit); the shared frame exists
   in code but no window uses it; light theme still blue. Structural: 0 windows. Manager: 0 windows. Alt shortcuts: 1
   Structural window only. Position memory: Civil Hub only. Preview 0.5 s, not 0.3 s.
9. **Robot check:** a test lists every CE window and fails one without the shared frame, a blue colour value, a
   clipped control at 100/125/150/200%, a broken Tab order or two buttons sharing an Alt letter; Codex screenshots
   light and dark.

## 2. One CE ribbon tab, in job-stage order, from one list

1. **The rule:** one "CE" tab for everything; the middle panels follow the drawing's discipline; panels run in the
   order a CE job runs; about 40 tools shown as families; one hand-kept list of commands drives the ribbon, tooltips,
   Help and the typed names.
2. **Civil sees:** one CE tab; select a pipe and the green Pipe tab jumps to the front (like AutoCAD's Hatch editor),
   Escape returns to CE; about five big buttons per panel for daily tools.
3. **Structural sees:** the same CE tab (no separate "CE Structural" tab); Beam ▾ (Regular/Lower/Special/Offset),
   Text ▾, one Tag tool, a Hatch gallery with pictures; about 40 tools instead of 298; "Legacy" disappears; debug
   commands hidden.
4. **Names on the buttons:** plain words first with the command beside it during the transition, e.g. "Pit Schedule
   (PITSCHEDULE)", behind the Settings switch "Show AutoCAD command names", default ON.
5. **Tooltips:** Autodesk style: short line, then on a longer hover a small final picture of the drawn result and
   "Type: PIT"; tooltip words may only name things that exist (BUG-226..228 family).
6. **Look and stability:** flat AutoCAD-style line icons with one CE accent; fixed layout, changed only between
   releases from office use counts; toolbars kept with matching icons; the CE CVL pull-down menu retired once the one
   tab works on 2022.
7. **CE panel (left of the tab):** job button "25-123 · From markup" with the last 10 jobs; job stages with a tick and
   one button (a guide, never compulsory); health line into Checks; bell count; find box; Start Here, Help, Ask CE.
8. **Rulings:** 4 Sep single tab; UX-RIBBON-01 (contextual jump), -02, -03, -05..07; UX-STRUC-02..05, 07, 08, 10;
   UX-NAMES-03 with INT-075 transition names; UX-TIP-01 with INT-075 Q14 (final pictures before colleague release);
   UX-PANEL-01, 02; UX-RECENT-01; B1 Q5 (job-stage guide panel, 17 Oct); B2 (tidy-up includes one tab and job-stage
   order). "From one list": Batch 3 card 3.8 plus the Open CAD Studio lesson (findings §6c) (planner's reading: this
   is how, not a separate ruling).
9. **Superseded:** MASTER_PLAN §3 "its own CE Civil ribbon" and the July three tabs (by 4 Sep and UX-RIBBON-01);
   UX-NAMES-03 "code in tooltip only" (refined 9 Oct by INT-075: plain name and command together for the transition).
10. **Status:** Civil: one CE tab, 9 panels roughly in job order, about 59 commands on about 90 buttons, contextual
    Pipe/Pit/Source tabs built (jump-on-select in a draft PR); tooltips "Pipe (CD)" + "Type: CD", no pictures; middle
    panels do not switch. Structural: separate tab, up to 313 commands poured into 7 panels by object type, older
    ribbon interface, tooltips show bare codes. Manager: buttons through Civil's shared ribbon builder. Job-stage panel,
    health line, find box, job button: not built. Held by ruling F (ribbon reorganisation).
11. **Robot check:** a test reads the one command list and the built ribbon and fails on a button not in the list, a
    tooltip naming a missing command or option, a missing "Type:" line, or more than the agreed count per panel;
    Codex reads the rendered ribbon on 2027 and 2024.

## 3. Command names, and old names still typed

1. **The rule:** new commands start CD (Civil), CS (Structural) or CE (shared); every old or merged name keeps working
   when typed, forever, silently; old names never appear on the ribbon, Help or tooltips.
2. **Civil sees:** CDWT and CDLPD stay as they are (short codes kept); a renamed command still runs from the old name.
3. **Structural sees:** CENTERLINE, CENTRELINE, CL and CLINE all run one Centreline tool; Help shows one name. In the
   Structural stage, buttons and Help move to CS names (e.g. CSBEAM); BT1, 1, R1 still work when typed.
4. **Office aliases:** about ten short aliases for daily tools (e.g. PP pipe, PT pit), set in Settings, checked against
   AutoCAD's own aliases.
5. **Rulings:** UX-NAMES-01 (26 Sep, supersedes 5 Sep "for one release"), UX-NAMES-02, 04, 05, 06; UX-STRUC-03.
6. **Note:** the transition display "Tidy labels (CDTIDYLABELS)" (INT-075) shows the CURRENT command name, not an old
   one, so it does not break UX-NAMES-01 (planner's reading).
7. **Status:** Civil 140 commands, Manager 12, Structural 377 including aliases (findings). Structural duplicates not
   yet merged; office alias list not built; CS renames not started.
8. **Robot check:** every name in the one list, old and new, is typed in the core console on a test copy and must
   start its command; a guard fails if an old name appears in ribbon, Help or tooltip text.

## 4. Placing and editing

1. **The rule:** placing commands carry on until Enter or Escape; the window opens for every item; the preview is
   the confirmation (no "Are you sure?"); editing part of a selection never changes what you selected; nothing selected
   means the command asks for the right object, filtered.
2. **Civil sees:** CD places pipe after pipe, the window opening each time; "Pick next point or [Size/Grade/Undo]
   <225 at 1 in 100>:"; "225 · 1 in 100 · 12.4 m" beside the cursor, warning colour on a fail; Enter or Space repeats
   with the last size; the only question that still asks is deleting a CE link record.
3. **Structural sees:** footing proposals shown as a preview with marks, Accept, done (UX-FDN-01); column and beam
   grips "Edit together"; MOVE a column and its beams follow (D1 choice 7); typing over a beam label changes the text
   and QA notes "Label says B3, beam is B1" with no pop-up.
4. **Everyday AutoCAD edits:** ERASE a pit leaves free ends and says how many; COPY makes real CE copies, renumbered,
   levels flagged "Check levels"; MIRROR/ROTATE keep CE text readable; EXPLODE works with a status-bar note of what
   left the schedule.
5. **Around the object:** right-click shows a short CE group on top of AutoCAD's menu; Ctrl+1 shows editable CE
   values under the same rules; double-click opens the object's window.
6. **Override reasons and fix lists:** quick picks (Survey, Council requirement, Engineer's judgement, Other) plus an
   optional note; safe drafting fixes pre-ticked, levels/sizes/links never pre-ticked.
7. **Rulings:** UX-STD-01, 01b, 02, 04, 05, 06; UX-SEL-01; UX-CMD-01..04; UX-EDIT-01..04; UX-RCLICK-01; UX-PROP-01;
   UX-NAV-04; D1 choices 2-7; UX-FDN-01, 02.
8. **Status:** Civil: CD/PIT carry-on default corrected in a build (UX-STD-01b); pick prompts mostly right, wording
   uneven ("pit block", "entity"); tip/cursor/Ctrl+1 status not confirmed by this planner. Structural: D1 grips
   approved, 2027 first; hover menu stopped (BUG-159 class); placing carry-on not recorded for Structural commands
   (planner's reading: the rule applies, status unknown). Manager: not applicable.
9. **Robot check:** a guard lists every pick prompt and fails on "entity", "block reference" or "pit block"; a
   scripted run places three items and checks the command is still running until Enter.

## 5. Escape, Cancel and Undo

1. **The rule:** one accepted operation = one AutoCAD Undo, named in plain words; Escape or Cancel at any point leaves
   nothing behind (no half-drawn object, no stray layer, no record change); a cancelled long job is undone whole.
2. **Civil sees:** the Undo list reads "CE: Move P3 (4 pipes relevelled)" and "CE: New pipe P2-P3"; Esc at a pick
   prints "[CE] Nothing was changed." once; Cancel in Pit Schedule writes nothing; one U takes back a whole Pit
   Schedule visit.
3. **Structural sees:** MOVE C1 300 mm, both beam ends follow and labels re-centre, one U puts all three back (D1
   test step 13); Esc at "Enter a number to append" on C1 removes the column (INT-075 Set A 6).
4. **Rulings:** START_HERE §3 engineering rule 6; UX-UNDO-01; UX-SEL-01; Batch 2 card 2.5 and 2.6 (Cancel = nothing
   written or whole command undone); D1 step 13; INT-075 Set A 6; C4 (Escape and Undo part of "done").
5. **Status:** Civil: about 13 open undo bugs (findings §2); plain Undo names not confirmed built. Structural: about 10
   open undo bugs and its own undo guard (findings §3); Esc/prompt bugs 5. Manager: not applicable.
6. **Robot check:** for every command, a scripted run cancels at each prompt and compares a drawing fingerprint
   (layers, blocks, object counts, extents) before and after: must be identical; a full-AutoCAD driver run checks one
   U restores the before-state (Undo needs full AutoCAD, findings §6.6).

## 6. Saving

1. **The rule:** CE never saves your drawing; AutoCAD's own automatic save makes the recovery copy; CE only adds a
   quiet "Not saved for 25 min" note in the bell, minutes on Settings.
2. **Civil sees:** after an hour of pipes, a quiet bell line "Not saved for 25 min"; nothing saves by itself; Undo
   is still there.
3. **Structural sees:** the same; one exception: CE Sheets sync updates CLOSED sheet drawings and says which ones it
   changed; open drawings are never saved; Issue warns if an open sheet has unsaved changes; sheets a colleague has
   open are skipped and named.
4. **Rulings:** UX-STD-03; Autosave ruling 25 Sep 21:22 ("AutoCAD's own + reminder"); UX-MSG-01, 03 (reminder is
   personal); UX-STRUC-01; INT-069 (13).
5. **Note:** INT-069 (9) Tim uses F2 to save; BUG-411 stays open, nothing changes there.
6. **Status:** Civil: never saves (long-standing). Reminder: not built (bell built, hidden, default OFF). Structural:
   closed-sheet writes with notice approved (PR #236). Manager: not applicable.
7. **Robot check:** a guard fails any CE code path that calls a save on the open drawing outside the Sheets-sync
   exception; a driver run checks the drawing's "changed" flag stays set after each command.

## 7. Settings: every engineering value, its source, no hard blocks

1. **The rule:** every engineering and council value lives on the one Settings page, never in code; each value shows
   where it came from (Council: name / Job override / Office) and the standard and edition it follows; a check that
   fails warns and records, it never stops the drafter.
2. **Civil sees:** Settings search "cover" lists every cover value; a job value has a gold "This job" tag with the
   office value beside it and Reset; a clock opens its history; "uPVC 3 m/s, unconfirmed, no standard found" shown as
   a warning, never a block; a new council rulebook is adopted only when the user clicks.
3. **Structural sees:** lintel tolerances (150/350/300 mm, 2°) as office defaults with a job override; BT1 accepts any
   width; the mark prefix list (PF, SF, GEB...) is a Settings list; an unset zone-of-influence angle says "angle not
   set, pipes near footings were not checked"; AS 3600 shows its edition by name.
4. **Who changes it:** any engineer, with a reason; who, when and the old value kept; everyone gets it at next start;
   an office change hits new work only, with a bell offer per job ("Office wording changed: update this job?").
5. **Hard blocks:** only two exist: deleting spine identities, and pushing an update to colleagues on a failed build.
6. **Unknown stays Unknown:** a missing value shows Unknown, never a quiet default or zero.
7. **Rulings:** R-00 (4 Sep); R-27 and its list; R-24 (edition as one value, old jobs keep theirs); UX-SET-03..09;
   UX-RULES-01; UX-STDS-03 (Drawing Standards is the Settings home for office standards); INT-066..070 (sources
   labelled); INT-075 Set A 8; INT-076 (3); INT-077 (8); UX-SSCHED-02; RULES 12.2.
8. **Status:** Civil: Settings page (CDS) exists; search, history clock, source tags status not confirmed by this
   planner; many rows are uninstalled PRs (findings §1.4). Structural: own settings file, 65 hard-coded values, three
   hard blocks (BUG-529..537), unnamed AS 3600 editions (BUG-534), no standards home on Settings. Manager: settings for
   the office admin name not built.
9. **Robot check:** a scan of the code fails on any engineering number not read from Settings (allow-list for units
   and geometry tolerances); a test fails on any check that stops a command outside the two listed hard blocks.

## 8. Messages and errors

1. **The rule:** quiet messages collect in one CE bell on the status bar, one action each; only a failure, a colleague
   holding the drawing and "update ready" may show a self-fading balloon; every message is calm, plain, with units, and
   says what to do; an unexpected failure opens one window with a plain first line, the log, "Send to admin" and a Fix
   button where CE knows the fix, with the drawing left as it was.
2. **Civil sees:** "P3 cover is 0.28 m. Office minimum is 0.45 m. Lower the pipe or raise the pit."; a failure window
   with "Send to admin (Tim)" and the honest result "Saved for Tim in the office feedback folder."
3. **Structural sees:** a known refusal is one plain line with the next step ("No inside point found. Pick inside the
   room.") (UX-BEAM-01); only bugs open the failure window; the same bell and button.
4. **Rulings:** UX-MSG-01..03; UX-VOICE-01; UX-UNIT-04; UX-FAIL-01, 02; UX-BEAM-01; UX-MGR-06 (one "Report a problem");
   UX-WORD-03; UX-SHARE-01 ("Name them + read-only", "Notify me when free"); plain-English UI rule.
5. **Status:** Civil: bell built and hidden, default OFF; failure route exists in code (CeMessages.Failure); Feedback
   window saves locally plus office copy; no "Send to admin" button anywhere. Structural: own messages, no bell; 3
   privacy bugs. Manager: CESUPPORT zip and feedback count on any PC that can read the folder, not only the admin's.
6. **Robot check:** a word list guard fails on "Oops", "!", "entity", "exception", bare numbers without units in any
   message text; a forced failure in a test copy must open the window and leave the drawing fingerprint unchanged.

## 9. Checks: one door

1. **The rule:** one Checks door from the ribbon: a palette that stays open while you draft, the same numbers
   everywhere; Project Review is the full pre-issue view of the same findings; CDHUB and CDCHECKCURRENT fold in;
   CDCHECK and CDRULES stay typed-only with their command-line answers.
2. **Civil sees:** ribbon "Checks" opens one palette with Connections, Rules and Ignored tabs; header "Checks: 4 to look
   at · 185 connected · 312 not known"; or one green line "Network OK: 24 pipes, 11 pits checked"; each row has Show
   where (zoom and glow, Esc clears), the known fix and Ignore with a reason.
3. **Structural sees:** the same door; the markup QA items ("Label says B3, beam is B1", Missing / Different from
   markup / Needs clarification) and "Renumber marks in order" before issue appear in it (planner's reading: B1 Q6 and
   UX-REV-01 make it one door for both disciplines; see open item 3).
4. **Rulings:** B1 Q6 (17 Oct); UX-REV-01..05; UX-STD-08; UX-WIN-04; Batch 2 cards 2.2-2.4 (INT-075, approved as
   recommended); UX-DI-03, 04; UX-MARK-01; UX-CPLAN-20.
5. **Superseded:** the seven Civil doors (CDCHECK, CDRULES, CDCHECKCURRENT, CDDASHBOARD, CDHUB, CDINSPECTOR,
   CDCHECKDWG, findings §2) as separate entry points; Manager's "Open Hub" (UX-MGR-02).
6. **Status:** Civil: seven doors with different counts; Checks palette not built ("What CE Found" is the nearest).
   Structural: CEMARKUP, CECHECKLIST (CECHECKLIST merges into CETOOLS, UX-RIBBON-04). Manager: none.
7. **Robot check:** on the test drawing the palette, Project Review, the CE panel health line and CDCHECK's summary
   must report the same counts; the ribbon must carry exactly one Checks button.

## 10. Help, first day, What's New, tips

1. **The rule:** first day = a short CE splash while CE loads, one welcome card whose "Show me" opens Start Here, a
   one-line tip the first time each command is used, a made-up practice job in Help; What's New opens once after an
   update; F1 opens help for what you are doing.
2. **Civil sees:** splash 1-3 s, no click; command line "CE ready. New? Click Start Here on the CE tab."; one card with
   three pictures (draw a pipe, place a pit, run checks); first PITSCHEDULE: "Tip: click a row to zoom to that pit."
   once; Help > Open practice job gives a fresh copy each time, never counted in job time.
3. **Structural sees:** the same splash and Help; tips and short clips for Beam, Column and Footing; practice job for
   Structural not yet planned (planner's reading: Structural is Tim's PC only until ready, B3).
4. **Also:** short silent clips for main tasks, made from the real windows; "suggest the faster way once"; Help pages
   with "Open in browser"; What's New drafted by CE, approved by Tim.
5. **Rulings:** B1 Q9 (17 Oct: splash, one welcome card, Show me opens Start Here, tip once, made-up practice job in
   Help); UX-START-01; UX-FIRST-01..03; UX-HELP-01..04, 06, 09; UX-MGR-10; Batch 4 recommended answers (INT-073 build
   permission).
6. **Superseded:** UX-HELP-07 "No practice drawing" (26 Sep) and UX-HELP-08 "first 3 uses" (26 Sep), both by
   UX-FIRST-03/02 (27 Sep) and confirmed by B1 Q9 (17 Oct); UX-HELP-05 role question (by UX-MODE-01); V3_UX_PLAN §2
   item 7 wording.
7. **Status:** Civil: Start Here built (Codex PASS 26 Sep); What's New once and modeless built; tips built for 2
   windows at 3 uses; F1 help built; splash, welcome card, practice job, clips: not built. Structural: prints its own
   start-up lines; no tips. Manager: prints its own lines.
8. **Robot check:** with an empty settings file the welcome card record is written and What's New does not open;
   splash never appears in the core console; tip count from Settings honoured; every Help page's command names exist
   in the one list.

## 11. Job set-up and job mode

1. **The rule:** one job record for both disciplines (number, address, client, people, council, rating report); title
   blocks fill from it and stay in step; each job, per discipline, is "From markup / supplied design" or "Design from
   scratch", suggested by CE, shown on the CE panel, switchable, never locked to a person.
2. **Civil sees:** CDDESIGN opens straight on the job with its saved answers; "25-123 · From markup" on the panel; in a
   From-markup job CE still shows every proposal, marked "differs from supplied design", and changes nothing until
   accepted; extras listed quietly as "Not in markup".
3. **Structural sees:** the same job record (CEPROPS today); a markup PDF in the job folder makes it "From markup" and
   QA against the markup leads; a late markup offers a switch, keeps everything drawn and adds the QA list.
4. **New job drawing:** pick discipline and sheet size; CE copies the office template into the job folder with the
   learned file name, fills the title block, opens it; templates never modified; another person's change to the job
   record is shown and chosen, never overwritten.
5. **Rulings:** UX-JOB-01..05; UX-MODE-01..04; UX-STD-07; UX-RECENT-01; UX-PANEL-01; B1 Q5; UX-TPL-01.
6. **Superseded:** UI-03 Drafter/Engineer modes (4 Sep) and the 5 Sep "who am I" role, by UX-MODE-01 (26 Sep).
7. **Status:** Civil: job mode per job and discipline built (CDSETUP, merged #348); no single new-job command.
   Structural: CEPROPS; no new-job drawing or title block command. Shared job record across disciplines: not built
   (planner's reading from findings §2-3).
8. **Robot check:** a test sets the job record once and reads it back from a Civil and a Structural title block on
   two test copies; mode suggestion is a pure policy test on folders with and without a markup PDF.

## 12. Protection: locked layers, Xrefs, REFEDIT

1. **The rule:** CE respects AutoCAD's own protections: it never silently unlocks a layer, edits Xref content, works
   around REFEDIT, explodes, detaches or clones around protected content; when it skips something it says so in one
   plain line per skip.
2. **Civil sees:** CDIMPORTXCIVIL onto a locked layer skips and says so (INT-069 8); the issue tidy-up lists
   off-standard layers but never touches Xref content; a revised architect's Xref raises "what moved", nothing moves.
3. **Structural sees:** the SF/BSF layer tidy runs quietly but never touches a locked layer, Xref content or anything
   while REFEDIT is open, erases an old layer only when empty and unused, and names each skip (INT-065).
4. **Rulings:** AGENTS.md native protection rule; INT-065; INT-069 (8); UX-STDS-01, 02; UX-ARCH-01..03; UX-XREF-01..03;
   C4 (locked layers in every robustness check). Any exception needs its own reviewed workflow and Tim's approval.
5. **Status:** Civil: about 14 open locked-layer bugs (findings §2); BUG-417 fix in PR #765. Structural: 4 open
   protection bugs; draft #764 implements the INT-065 behaviour. Manager: not applicable.
6. **Robot check:** the robustness drawing set (locked layers, missing and mirrored Xrefs, REFEDIT open) runs every
   command; the fingerprint of locked and Xref content must be byte-identical afterwards, with one skip line each.

## 13. Speed and robustness

1. **The rule:** drafting never waits on CE; any CE handler under 10 ms typical, never over 50 ms; anything over about
   a second shows status-bar progress with Cancel; big drawings, bad input, Escape, Undo and locked layers are part of
   "done" for every item, tested automatically and measured, not felt.
2. **Civil sees:** LINE, pan and zoom feel the same with CE loaded; "CE: checking connections 140 of 217..." with Esc
   to cancel; if the label tidy slows a drawing, one line offers "Pause it for this drawing?" and a report goes to the
   admin.
3. **Structural sees:** a schedule build or sheet sync on a large job shows the same progress and Cancel (planner's
   reading); Civil watchers sleep in a Structural drawing while every command still works everywhere.
4. **Never re-read the whole drawing for one change;** idle work in slices of 20 ms or less; every queue capped; no
   background thread touches the drawing or ribbon; a CE failure never stops AutoCAD's own command.
5. **Rulings:** C4 (17 Oct); Speed and reliability framework (Tim 28 Sep, ENGINEERING_RULEBOOK); API guardrails 4, 5;
   UX-PERF-01, 02 with INT-075 Q6 (pause sends a report); UX-LIVE-01 (big jobs batch with Cancel); 25 Sep discipline
   switch-off principle; R-27 (bad input warns).
6. **Status:** Civil: [PERF] logging and timings in the log; no AutoCAD progress line anywhere; pause switches exist
   for the session only (CEPERFDIAG). Structural: memory note 29 Sep that Civil wakes in Structural drawings on an
   empty record. Manager: status page does not show paused features. No speed baseline yet (planning list item 14).
7. **Robot check:** the speed gate times every headless step, median of 5, fails at about 20% slower than the last
   accepted build or any handler over 50 ms; the robustness suite (50,000 objects, rotated UCS, mm vs m, damaged file,
   bad input, cancelled prompts) must finish with no crash and an unchanged fingerprint on Cancel.

## 14. Looks like ours

1. **The rule:** every element CE draws (schedule blocks, labels, symbols, text, layers, linetypes, details, exported
   output) matches CE's existing drawings; how each sheet is laid out is the job's and is not compared; all heights,
   layers and wording come from Settings and the office typical files.
2. **Civil sees:** "100 DIA. UPVC PIPE AT 1 IN 100" (never MIN., never 1:100); pit label "P1" with "CL 43.60"; plastic
   pits only "PP" in the cover text; Pit Schedule columns copied exactly from the last issued C01; CE objects on office
   layers, colour ByLayer, CD resets the office colour every time; labels plot at office height at every scale.
3. **Structural sees:** footing and pier schedules sideways, one column per mark, f'c band (copied exactly); member
   schedule on the office MEMBER SCHEDULE block, MARK | SIZE side by side; own mark per beam, columns and footings by
   size, most common = 1; masonry lintel table from S01.
4. **Built-in AutoCAD tools** may be used only where their output can be made to match exactly.
5. **Rulings:** C3, D1 (17 Oct); UX-CPLAN-05, 06, 21..27; INT-074 (1); INT-077 (1, 3, 10, 11, 12); UX-LYR-01..04;
   UX-LAY-04; R-28 (annotation offsets at DIMSCALE); UX-SSCHED-01..06; UX-MARK-04..07; UX-DET-09 (Civil details by
   title, no numbers) vs UX-DET-04 (Structural numbered).
6. **Superseded:** UX-PIT-01 plan label for plastic pits (by INT-074 1); UX-MARK-02 and the beam part of UX-MARK-06 (by
   UX-MARK-07); V3_UX_PLAN §1 item 27 "identical beams share a tag" (findings §4.7).
7. **Status:** Civil: labels, Pit Schedule and layers built in parts; about 19 label bugs, 16 Pit Schedule bugs.
   Structural: XCLMTXT inserts the office member schedule block (keeps it); schedules copy-exactly rulings largely
   unbuilt. Element catalogue and gold benchmark EV-06: approved, never started.
8. **Robot check:** EV-06 gold compare: output DWG read by ACadSharp and compared element by element (layer, block,
   text, position within tolerance) against 3 real jobs per discipline, plus both plotted to PDF and compared by
   picture; at most 30 exception cards for the Monday session.

## 15. Old drawings and mixed versions

1. **The rule:** an older CE drawing upgrades quietly on open with one status-bar line and one Undo; a drawing from
   another consultant gets a quiet offer in the bell, nothing converts until ticked; anyone without CE sees clean
   ordinary linework, no proxy box; V3 drawings stay visible to colleagues on older versions; 2027-only tools show
   greyed "needs AutoCAD 2027" elsewhere.
2. **Civil sees:** an old drawing's pipes become the one-piece CE pipe on open on Tim's PC with one line; on a
   colleague's PC that pipe upgrade is held until the 2022-2024 enabler is proven; a consultant's drawing shows "12
   things look like pits and pipes. Review".
3. **Structural sees:** older schedule blocks are kept, with an offer to update to the current office block; on
   2022-2026 Structural works fully with 2027-only tools greyed.
4. **Rulings:** UX-DWG-01..03 (27 Sep); UX-MIX-01..03; UX-STRUC-12; UX-SET-09; UX-SSCHED (old drawings get an offer).
5. **Superseded:** D2 (4 Sep: "explicit per-object upgrade; never automatic-on-open") by UX-DWG-02 (27 Sep), with the
   UX-MIX-03 hold kept.
6. **Status:** Civil: one-piece pipe built on a Polyline, upgrades on open/draw/demand; PROXYGRAPHICS safeguard noted
   26 Sep; 2022-2024 enabler never loaded on real 2022-2024. Structural: not recorded. Manager: version reporting per
   PC (UX-MGR-07) not confirmed.
7. **Robot check:** an old-drawing set (one per past CE version) opens in the core console: upgrade makes one undo
   step and one line; the saved copy opened with CE unloaded must show the pipes; nightly net48 load check.

## 16. Manager's job

1. **The rule:** Manager does four things only: shows versions, brings updates, rolls back, and takes "Report a
   problem"; drafting tools live on the CE ribbon, not in Manager.
2. **Two update lanes:** Tim's PC always gets the newest build that has passed (Civil, Manager, Structural);
   colleagues get only versions Tim marks as a release (Civil + Manager until Structural is ready); updates download
   quietly and switch on at the next AutoCAD start, never mid-drawing; What's New then opens once.
3. **Colleague sees:** their version, "Report a problem" and "Go back to previous version" (applied at next start, with
   an "are you sure", a note saying who and why); no admin controls.
4. **Tim (admin) sees:** office health at a glance (who is on which version, reports waiting, update ready); a one-page
   approval (changes in plain words, test results, what is not yet accepted, rollback location); approving Civil also
   approves the matching Manager; a report opens as a plain summary with "Send to Claude chat" and one-click rollback of
   that colleague.
5. **Rulings:** B1 Q8 (17 Oct); B3, B4 (17 Oct); F1 (Max, Mon 9 Nov); UX-MGR-01..13; UX-ADMIN-01; INT-069 (10, 11,
   12); INT-071 (7); INT-076 (1); R-27 list (no push on a failed build); UX-RIBBON-04 (install/repair commands merged,
   automated, into Manager).
6. **Superseded:** UX-RIBBON-04 (corrected 25 Sep) "only CENOTES moves into Manager" (planner's reading: CENOTES is a
   drafting tool, so B1 Q8 puts it on the ribbon); Manager "Open Hub" (UX-MGR-02); "Default OFF" for installed features
   (desk's addition, not Tim's words) by B1 Q4 (a tool switches ON once Codex passes it).
7. **Status:** Manager 1.1.51 installed; CESUPPORT, feedback inbox count, admin seed and "Roll Back Release" exist;
   two lanes, staged swap, one-page approval and colleague view: not built, paused by ruling A and held by ruling F;
   stale Manager 1.0.0 in ProgramData to remove (findings §7.10).
8. **Robot check:** a staged test install swaps at next start and rolls back to a byte-identical previous folder; a
   failed build can never be marked for the colleague lane (the one Manager hard block).

---

## Contradictions already settled: fix the old files

1. **Light theme blue:** `C:\CE_PLAN\areas\windows-and-ribbon.md` lines about "Dark gold / light CE blue" (CIVIL-HUB-UI
   item 3, DESIGN-WINDOWS item 4) and memory note `plain-english-ui-rule.md` ("CE deep blue #1E5AA8 on light"): mark
   superseded 9 Oct by INT-075 Q8 "no blue".
2. **Button names:** `V3_UX_PLAN.md` §2 item 2 and §1 item 36 ("code only in the tooltip"): add INT-075 transition
   names with the "Show AutoCAD command names" switch, default ON.
3. **First day:** `V3_UX_PLAN.md` §2 item 7 still says "tips on the first three uses; no practice drawing": replace with
   B1 Q9 (tip once, made-up practice job in Help). Batch 4 card questions 3 and 4: mark answered 17 Oct.
4. **Role question:** `V3_UX_PLAN.md` §2 item 6 is right; UX-HELP-05 in the rulings file needs its "superseded by
   UX-MODE-01" note beside it.
5. **One CE tab:** MASTER_PLAN §3 "its own CE Civil ribbon": superseded by 4 Sep and UX-RIBBON-01.
6. **Old drawings:** `V3_OVERALL_PLAN.md` decision table D2 and `2026-09-04_PLAN_RECONCILIATION.md` D2: mark superseded
   27 Sep by UX-DWG-02 (UX-MIX-03 hold kept).
7. **Beam marks:** `V3_UX_PLAN.md` §1 item 27 "identical beams share a tag": replace with UX-MARK-07.
8. **Plastic pit label:** UX-PIT-01 plan label: superseded 9 Oct by INT-074 (1).
9. **Default OFF:** any card or brief saying new features install OFF until Tim says so (INT-073, TIM_DESK item 204):
   now ON once Codex passes it in AutoCAD (B1 Q4), and acceptance is robot-accepted (D7).
10. **Ownership:** START_HERE §3 still states ruling B (Codex builds windows); superseded 23 Sep (Claude primary builder
    of windows, `2026-09-23_V3_COLLEAGUE_RELEASE.md`). Note: INT-073 (9 Oct) says "Windows stay Codex's"; this is a
    process line, not a house rule, and belongs to the operating-rhythm section of the one plan (planner's reading).
11. **Release scope:** any plan saying "release ~10 tools per discipline, hide the rest": superseded by B2 (all
    features ship, tidy first where possible).
12. **Pilot date:** `2026-09-23_V3_COLLEAGUE_RELEASE.md` 29 Sep target: superseded by F1 (Mon 9 Nov 2026).
13. **CENOTES into Manager** (UX-RIBBON-04 corrected): conflicts with B1 Q8 (Manager = versions, updates, rollback,
    report only) (planner's reading: B1 Q8 is newer and wins).
14. **Minimum cover:** R-04 table says 450 mm; Tim set 300 mm as the colleague default 24 Sep (findings §4.6). Fix the
    rulebook seed; the 300 vs 600 question (Set C Q5) stays with the Monday session (engineering, not a house rule).
15. **Test hours:** RULES 1.8 AutoCAD windows overridden for CE until Thu 29 Oct by E1; AGENTS.md "8:40-5:30
    Australia/Sydney" should say Melbourne and point to E1 for this period.

## Genuinely open (grepped `C:\CE_PLAN\decisions\` first; recommendation given, never filled in)

1. **When the one CE tab happens.** Ruled 4 Sep and UX-RIBBON-01; timing never ruled (findings §4.2); ruling F holds
   ribbon reorganisation. **Recommended:** Civil + Manager panels reorganised into job-stage order before 9 Nov;
   Structural joins the tab in its own stage, after the colleague release. Example: Max sees one tidy CE tab on 9 Nov;
   Tim still has CE Structural as a second tab until Structural is ready.
2. **Which gold, black and grey on a white window.** INT-075 says Codex shows Tim a light and dark picture; not shown
   yet. **Recommended:** one gold for the main button in both themes, black text on light, show both pictures at the
   Monday session.
3. **Structural markup QA inside the one Checks door?** B1 Q6 named only Civil commands. **Recommended:** yes, a
   "Markup" tab in the same palette, so one door serves both disciplines (reset outcome b).
4. **Switch ON when, for which lane?** B1 Q4 (ON once Codex passes) and D7 (robot-accepted = gates + Codex check + 5
   working days) differ. **Recommended:** ON for Tim's lane at the Codex pass; ON for colleagues only once
   robot-accepted.
5. **Structural first day.** Welcome card and practice job are Civil pictures. **Recommended:** add one Structural
   picture (draw a beam) and a Structural practice sheet when Structural is released (B3); nothing before.
6. **Settings home for Structural standards and editions** (AS 3600, AS 1170, AS 1684). Not ruled. **Recommended:** a
   Standards group on the one Settings page, edition named per value, job keeps its issued edition (R-24 pattern).
   Engineering values themselves go to the Monday session, not here.
7. **CESTRUC button launcher.** UX-RIBBON-04 OPEN 2: "needs to be revisited in detail before deciding"; UX-STRUC-10
   says it retires once its unique functions have homes. **Recommended:** retire after the ribbon families exist, with
   a Kept/Moved list for Tim.
8. **Workspace repair commands into Manager** (UX-RIBBON-04 "merge and automate then add to manager") vs B1 Q8's four
   jobs. **Recommended:** treat automatic repair as part of "updates", no extra Manager screen.

## What this planner did not read

1. `C:\CE_PLAN\MASTER_PLAN.md`, `V3_OVERALL_PLAN.md`, `DRAWING_PRODUCTION_PLAN.md`, `STRUCTURAL_LEVEL3_PLAN.md` (only
   what the findings quote).
2. The 4 Sep to 10 Sep design pack (`2026-09-04_to_09-10_RECONCILED_DELIVERY_PLAN_AND_DESIGN_PACK_D1-D10.md`) beyond
   the D2 line, and the 5 Sep Tim review in the plugin repo (fonts are cited, not named).
3. Rulings file lines 1-225, 425-495, 715-830, 860-1175, 1216-1375, 1536-1724, 2125-2412; holiday file lines 1-494.
4. `BUG_CARPARK.md`, `PENDING_TESTS.md`, `IDEAS_INBOX.md`, Batch 1, 5, 6, 13-15 cards, the UX-MSG and UX-RIBBON-01 cards,
   EV-06 and EV-03.
5. Any plugin code, the installed DLLs, or AutoCAD. Every "Status" line comes from plan files, not from looking.
