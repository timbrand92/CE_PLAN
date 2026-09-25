# V3 plan discussion — Tim's rulings, 25 September 2026

Recorded by the chat `CE_ACAD / V3 PLAN / DISCUSSION / 01`. Tim answered by clicking one of the offered choices;
the choice he clicked is quoted exactly, with the wording of that choice as he saw it. Times are Melbourne.

---

## Council numbers — 25 Sep 2026, 13:10

From `02_COUNCIL_RULES\OPEN_QUESTIONS.md` A1, A2, A3 and A5. Each was checked first against Tim's earlier rulings
(`ENGINEERING_RULEBOOK.md` R-05, R-20, R-29 of 4 Sep; the 0.35 standing hold; STEP-02 of 15 Sep).

### CR-A1 — Runoff coefficient for soft ground

**Tim: "Two numbers (Recommended)".** The choice read: *0.35 stays for the whole site before development (your
hold). 0.30 for soft ground after development, as Banyule, Darebin and Maroondah write it. The printed working
always shows the number used. Example: 600 m² lot, 400 hard, 200 garden gives C 0.70 not 0.72, about 2% less flow.*

1. **Before development, whole site:** 0.35. The standing hold is **unchanged** (Kingston 0.4 unchanged).
2. **After development, soft ground inside the weighted sum:** 0.30.
3. **The printed working** must show the number actually used in the sum.
4. Both are Settings values (R-00); a council profile that publishes its own figure still wins for that council.

### CR-A2 — Orifice discharge coefficient

**Tim: "0.6, flag Darebin (Recommended)".** The choice read: *CE draws the 0.6 hole everywhere. On a Darebin job it
adds a note giving Darebin's figure and the smaller hole it would give, so the engineer can choose. Example: 60 mm
drawn, note says Darebin's formula gives 46 mm.*

1. Co = 0.6 on every job, as R-05 (4 Sep) already said. **Confirmed, not changed.**
2. Darebin's published 1.0 for a round orifice is recorded with its source and shown on Darebin jobs as a note,
   with the hole size it would give. It is a warning that records, not a block (R-27).

### CR-A3 — Rounding the orifice

**Tim: "Down to whole mm (Recommended)".** The choice read: *Round down to the whole millimetre, never below the
council minimum. Discharge stays at or under what council permits. Office sheets already use sizes like 63 and
71 mm. Example: 42.7 becomes 42 mm, about 3% less flow.*

1. The calculated orifice diameter is rounded **down** to the whole millimetre.
2. Never below the council's minimum orifice. If rounding down would go below it, the council minimum is used
   (and the drawing states that the minimum governs).
3. The exact calculated size stays visible beside the adopted size (carried from R-05).
4. **Supersedes** the rounding part of R-05 (4 Sep: *"Snap up to the next standard plate"*) and of R-20 (4 Sep:
   *"orifice rounds up to next whole mm"*). R-05's Co = 0.6 and "never below the council minimum" stand.
5. **Also settles CDPROFILE open decision 3** (PR #187, "Standard-detail orifice plate increments"): no plate
   increments; whole millimetres, rounded down.

### CR-A5 — Step irons

**Tim: "900 everywhere (Recommended)".** The choice read: *One office rule that meets or beats every council.
Example: a 950 deep pit in Banyule gets step irons, although Banyule only asks for them from 1 m.*

1. Step irons in pits **deeper than 900 mm**, on every job, as one office rule (a Settings value, R-00).
2. Councils publishing 1 m (Banyule, Manningham, Kingston) are met by the stricter office rule; no per-council
   depth is applied.
3. Confirms STEP-02 (15 Sep, Tim: *"LET'S DO OVER 900 DEEP"*). **Supersedes** R-29's depth (4 Sep: *"pits deeper
   than 1000 mm"*). R-29's note wording (24 mm galvanised MS step irons) is unchanged.

### Tim's comment on this batch — 25 Sep 2026, about 13:12

**Tim, verbatim: "this planning is for how the ux is not necessarily the number that ive answered numourous times
about".**

1. **Meaning for every plan chat:** the V3 plan discussion is about how the plugin works for the drafter (what is
   clicked, what appears, the order of steps), not engineering numbers. Numbers live on the Settings page (R-00),
   where engineers change them; most were already ruled.
2. **Before any question about a value:** check `ENGINEERING_RULEBOOK.md`, `decisions\` and the council files, and
   do not ask it again. Only an engineering choice that changes how a workflow behaves is asked, and only once.
3. The four answers above stand as Tim gave them. Three confirm earlier rulings; CR-A3 changes R-05/R-20's
   rounding direction.

---

## How commands behave — 25 Sep 2026, 13:18

The CDTAG question came from the release chat (release-v3 item 116, PR #209 held). The other three are CDPROFILE
PR #187's open decisions 5, 4 and 2. Decision 1 (keep the old long-section instruction line) is covered by the
standing rule that nothing is retired without Tim's yes; decision 3 was settled by CR-A3; decision 6 (one Review
home) is still open.

### UX-CDTAG-01 — CDTAG typed with nothing selected

**Tim: "Ask me to pick (Recommended)".** The choice read: *Command line asks "Pick the downpipe or source to tag:",
the way MOVE asks "Select objects". This was CE's rule until Codex's PR #209 changed it.*

1. The old rule UC-CDTAG-PICK-01 **stands**: with nothing selected, CDTAG asks the drafter to pick the downpipe or
   source.
2. PR #209 (one message, then stop) is **not** what Tim wants for this case and should not be merged as built.

### UX-PROFILE-05 — Long section update and the Pit Schedule

**Tim: "Both together now".** The choice read: *The long section and the matching schedule rows update in one step.
This needs a combined preview and one-Undo build first, so it arrives later either way.*

1. When a long section is updated (CDPROFILE Apply), the Pit Schedule rows it touches update **in the same step**:
   one preview showing both changes, one Undo for both.
2. Tim chose this over "leave the schedule alone for now". It is a build request for the release chat, recorded in
   `areas\civil-K-profiles-long-sections.md`. Until it is built, the schedule is not refreshed by CDPROFILE
   (nothing silent is added in the meantime).

### UX-CALC-APPROVE-01 — Who can approve a calculation

**Tim: "Any CE user, recorded (Recommended)".** The choice read: *Anyone can approve. CE records their name, the
time and the source they checked, and shows it on the sheet, e.g. "Approved by JS 25/09 14:05, source: rating
report". Nothing is locked.*

1. Any CE user may press Approve. No Engineer-mode lock (consistent with R-27).
2. The approver's name, the time and the source reviewed are recorded and shown on the calculation output.

### UX-CALC-OLDER-01 — Pump and WSUD calculators in CDCALC

**Tim: "Under 'Older calculators' (Recommended)".** The choice read: *They move to an 'Older calculators' heading,
read-only, until their rules are signed. The commands you use today to open them still work.*

1. In CDCALC, the pump and WSUD calculators sit under an **Older calculators** heading, read-only, until their
   rules are signed.
2. Their existing opening routes keep working. Nothing is retired.

---

## What this chat is for — Tim, 25 Sep 2026, about 13:22

**Tim, verbatim: "this ux planning should be for the commands, command names, how an end user interacts with the
plugin and how it can best be designed to help the end user, i want users to feel like theyre using a polished
product similar to something apple or autodesk would design".**

1. **Scope of `CE_ACAD / V3 PLAN / DISCUSSION`:** the end-user experience of the whole plugin: the command set,
   command names, how a user finds a command (ribbon, typing, help), how each command talks to the user (prompts,
   selection, windows, preview, grips, messages, Cancel, Escape, Undo), and consistency across Civil, Structural
   and Manager.
2. **The bar:** a polished product, like something Apple or Autodesk would design.
3. **Not this chat's job:** engineering numbers (Settings page, R-00) and release status (the release chat).
4. Structural D1 (12 choices on beam grips and the member schedule) stays on its own card for Tuesday, as that
   card planned; it is taken up here only as part of the Structural command family.

### UX-PLAN-01 — How the UX plan runs (Tim, 25 Sep 2026, 13:23)

**Tim: "Yes, front door first (Recommended)".** The choice read: *Names and ribbon first, because they are what a
colleague meets first and they shape everything after. Then the one standard, then family by family.*

1. **Pass 1, the front door:** every command name, ribbon tabs and panels, icons, tooltips and what is typed.
2. **Pass 2, one way of working:** one interaction standard every command follows (start, ask, preview, finish,
   change later), written from existing rulings plus the gaps.
3. **Pass 3, family by family:** 5 to 10 related commands at a time in job order (Civil, then Structural, then
   Manager), each showing today, the polished version and only Tim's genuine choices.

---

## Structural beam commands — 25 Sep 2026, 13:32

From the release chat's card `04_REFERENCE\structural\STRUCTURAL_BEAM_FIX_CARD_2026-09-25.md` section 4, raised after
Tim's own message to the release chat at about 13:20 (*"with structural module can you looking into the beam
commands, it always fails and always works terribly in multiple ways"*).

### UX-BEAM-01 — Say why a beam was not placed (card fix 1)

**Tim: "Plain reason + next step (Recommended)".** The choice read: *One line naming the cause and what to do, e.g.
"Beam not placed: no inside-of-building point in this drawing. Pick one now, or run BSET." Internal codes stay in
the log, never on screen.*

1. Every beam refusal (commands 1, 2, 4, 5, BDL) shows one plain line: what CE found and what to do next.
2. Internal codes stay in the log only. This supersedes the single generic line introduced 23 Sep
   (STRUC-BEAM-WORDS-01) for the refusal case.

### UX-BEAM-02 — STRUCDEBUG switch (card fix 2)

**Tim: "Yes, like CDDEBUG (Recommended)".** The choice read: *Off by default, so colleagues never see it. When on,
each beam step writes a readable line to the command line, so Codex's test runs can prove each cause.*

### UX-BEAM-03 — One engine for every beam command (card fix 3)

**Tim: "After the message fixes (Recommended)".** The choice read: *Once the plain reasons and the switch are in,
move 5 then BDL across one at a time, each tested by Codex before the next.*

### Card question 4 (object limit) — not asked, already answered

Covered by R-00 (Tim, 4 Sep 2026: *"all of the engineering values and decisions must be part of the settings page
so engineers can update system wide, same for council values, nothing should be hardcoded"*): the nearby-object
limit becomes a Settings value with today's default. **UX note from this chat (a recommendation, not a Tim
ruling):** the on-screen message should not show the raw number ("limit 65,536"); say it in drafting words, e.g.
*"Beam not placed: too much drawing near this beam for CE to check. Zoom closer or turn off Xrefs you do not need."*

---

## Calculations workflow card (CDCALC, D+F) — 25 Sep 2026, 13:40

Card: `04_REFERENCE\civil-D-F\DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md` (release chat's draft from Tim's 15 Sep
rulings, commit e0e224da). Questions cover its OPEN 1, 2 and 5; the fourth approved the card with OPEN 3 and 4 as
recommended.

### UX-CALC-01 — Fixing a catchment inside the one confirmation (OPEN 1)

**Tim: "Yes, fix it there (Recommended)".** The choice read: *Report value and your value side by side, yours marked
"manual". A downpipe CE can't prove stays Unknown. Then confirm the whole set once.*

### UX-CALC-02 — What Apply to drawing replaces (OPEN 2)

**Tim: "You pick, one U (Recommended)".** The choice read: *Click the existing block or detail, or pick a spot for a
new one. A preview shows every change first. One U takes it all back. CE never overwrites a detail you didn't pick.*

1. The one Undo includes the reviewed calculation record saved with the Apply (the card's recommendation).

### UX-CALC-03 — Who issues the computations sheet (OPEN 5)

**Tim: "Anyone, names the engineer (Recommended)".** The choice read: *Any CE user can issue, but must pick the
engineer responsible. That engineer prints on the sheet; who pressed Issue, and when, is recorded. No locks, and
council always sees an engineer's name.*

1. Differs from the card's recommendation (named engineer only). Tim's answer governs; consistent with
   UX-CALC-APPROVE-01 and R-27.
2. Until issued, the sheet keeps DRAFT - NOT FOR CONSTRUCTION. Issue records the revision, date, who pressed Issue,
   the responsible engineer and the reviewed sources.

### UX-CALC-04 — Card approved

**Tim: "Approve (Recommended)".** The question read: *Approve the calculations card, with its suggestions for the
last two points: compare drawn storage with the last issued sheet (and warn), and keep today's way of pasting
rainfall numbers (no automatic fetching yet)?* The choice read: *The release chat builds slice 1 this weekend: one
catchment from the rating report, one confirmation, sources shown. You check it in AutoCAD afterwards.*

1. OPEN 3: compare unrounded drawn storage with the last explicitly issued revision for that system; warn; show
   both values and the difference; no invented percentage allowance.
2. OPEN 4: keep CDRAINFALL's reviewed paste/file route; no automatic fitting of rainfall coefficients until a
   method is evidenced and approved.
3. The card is approved **with UX-CALC-03 replacing its OPEN 5 recommendation**.

---

## Front door, batch 1 — 25 Sep 2026, 13:50

From the sorted design-pack list (`04_REFERENCE\ux-plan\DESIGN_PACK_QUESTIONS_SORTED_2026-09-25.md`) and
`windows\01_RIBBON.md` §9 (plugin repo design pack).

### UX-RIBBON-01 — Selecting a pipe (design-pack Q5)

**Tim: "Jump to it (Recommended)".** The choice read: *Same as AutoCAD's Hatch and Text editors: select a pipe and its
tools are in front of you. Escape or Close returns to the CE tab.* Applies to the contextual Pipe, Pit and Source
tabs alike.

### UX-RIBBON-02 — Three ribbon details as built (Q1, Q2, Q4)

**Tim: "Keep all three (Recommended)".** Kept: the Pit button face opens the full Pit window and its arrow gives the
preset sizes; Solve Run Inverts sits on the Review panel; the Civil/Structural switch is always visible on the CE
panel.

### UX-RIBBON-03 — CE CVL pull-down menu and its seven toolbars (01_RIBBON §9, "Retired — needs Tim")

**Tim: "Keep toolbars, drop menu (Recommended)".** The choice read: *Toolbars stay for people who like them, with
icons matching the ribbon (your 16 Sep ask). The pull-down menu goes, and so does the start-up warning it causes on
AutoCAD 2022.*

1. The seven CE toolbars stay as a second way in; their icons match the ribbon.
2. The CE CVL pull-down menu is retired **once the one CE tab works on every AutoCAD version, 2022 included**
   (the 2022-2024 CUIX still carries the ribbon there today). Answers release-v3 queued item 9 in the same
   direction: stop writing the menu entry that causes *"Menu item failed to load"*.

### UX-RIBBON-04 — Workspace and System repair commands (01_RIBBON §9, "Retired — needs Tim")

**Tim, his own words (not one of the offered choices): "merge and automte them as much as possible then add
tomanager".**

1. The seven commands that install and repair the CE workspace, menu and toolbars are **merged** into as few as
   possible and **automated** as far as possible (repair happens without the user having to run them).
2. What remains goes **into Manager**. Nothing on the CE ribbon.

---

## Pass 2, one way of working, batch 1 — 25 Sep 2026, 13:54

Standards every CE command follows (design-pack Q9, Q39, Q74, Q53 as general rules).

### UX-STD-01 — Placing commands repeat (Q9)

**Tim, his own words: "carry on but will it open window each time?"**

1. Placing commands (pipe, pit, source) **carry on** for the next item until Enter or Escape.
2. **Open:** whether the window opens for every item. Tim asked; the follow-up question is recorded below when he
   answers. Not decided.

### UX-STD-02 — No "Are you sure?" after a preview (Q39)

**Tim: "No, the preview is enough (Recommended)".** The choice read: *Preview, one click, done; one U takes it back.
How Autodesk tools work. Only deleting CE's link records still asks.*

### UX-STD-03 — CE never saves the drawing (Q74)

**Tim: "Never, you save (Recommended)".** The choice read: *Like every AutoCAD command: CE changes the drawing and
you decide when to save. Undo stays available.*

### UX-STD-04 — Override reasons (Q53)

**Tim: "Quick picks + note (Recommended)".** The choice read: *One click on "Survey", "Council requirement",
"Engineer's judgement" or "Other", with a note box if wanted. Still optional.* (Optional per the 5 Sep review.)

---

## Pass 2, batch 2, and the learning principle — 25 Sep 2026, 13:57

### UX-STD-01 (completed) — The window during a run (Q9 follow-up)

**Tim: "Every time".** The choice read: *Each pipe opens the window so you can check it before it's placed.*

1. Placing commands carry on until Enter or Escape (UX-STD-01), and **the window opens for every item** in the run.
2. Chosen over "first one, then keep clicking" (recommended) and "review at the end".

### UX-LEARN-01 — Decisions in the plugin learn (machine learning)

**Tim, verbatim (about 13:55): "decision within the plugin should have a machine learning element".**

Then, asked where CE should learn from, Tim ticked **all four**: "Your own habits (Recommended)", "The whole office
(Recommended)", "Past CE projects", "Your corrections". The question read: *Machine learning: where should CE learn
from decisions? It always shows why it suggests something ("You usually pick 450 here") and never silently changes
an engineering rule.*

1. **Your own habits:** pre-fill what this user usually chooses in that situation (pit size, lid class, label side,
   which window tab).
2. **The whole office:** everyone's choices shape suggestions, shared through Manager (a new colleague gets the
   office's usual choice first).
3. **Past CE projects:** learn from drawings CE has issued (the drawing-intelligence evidence). Client data stays on
   Tim's PC; only anonymised lessons are shared (DATA-01, R-LEARN).
4. **Your corrections:** when a user changes a suggestion, CE remembers and suggests their version next time, and
   shows how often it has been corrected.
5. **Limits carried from standing rules:** every suggestion shows its reason; learning proposes and never silently
   changes an engineering rule (master plan Part C §5); a learned default becomes a company default only when an
   engineer promotes it (R-10 pattern); Unknown is never filled by a guess.
6. Build request: `IDEAS_INBOX.md`, 25 Sep 13:57 (for the release chat to card and schedule).

### UX-STD-05 — What comes pre-ticked in a list of fixes (Q71)

**Tim: "Safe drafting fixes ticked (Recommended)".** The choice read: *Label overlaps, layer names and missing tags
come ticked. Anything touching levels, sizes or links is never pre-ticked. One U undoes the lot.*

### UX-STD-06 — Selection after editing part of it (Q17)

**Tim: "Your original selection (Recommended)".** The choice read: *Like AutoCAD's Properties palette: editing never
changes what you'd selected.*

---

## Pass 2, batch 3 — what the drafter sees and reads — 25 Sep 2026, 14:00

### UX-STD-07 — Design on a drawing CE already knows (Q81)

**Tim: "Straight to the job (Recommended)".** The choice read: *Opens on the job with its saved answers. A small
"Different job?" link is there if needed.*

### UX-STD-08 — When checks find nothing wrong (Q22, Q41)

**Tim: "One green line (Recommended)".** The choice read: *e.g. "Network OK: 24 pipes, 11 pits checked". The passed
checks are folded away and one click opens them. One glance tells you you're fine (your cockpit rule).*

### UX-WORD-01 — Pipe-end chips (X1)

**Tim: ""Free end" / "Not connected yet" (Recommended)".** The choice read: *Your deliberate choice reads "Free end";
the undecided one reads "Not connected yet" in amber. No two labels look alike.*

1. Replaces the chip "Not connected" (used for "Keep as a free end") with **"Free end"** everywhere it appears
   (Pit window, Civil Properties, Inspector, checks).

### UX-WORD-02 — Proposal based on an unsigned office rule (Q52)

**Tim: "Suggestion only (Recommended)".** The choice read: *"Suggestion only: not an office rule yet". Plain, and it
says why you should check it.*

---

## Pass 2, batch 4 — 25 Sep 2026, 14:05

### UX-LOOK-01 — Master look for every CE window — ANSWERED 14:08, see below

**Tim, his own words: "can you show me both im leaning to pipe window".** Not decided. He is leaning to the one-page
New Pipe window over the Settings window; pictures of both are being shown to him first.

### UX-STD-09 — Hidden Inspector stays hidden (Q21)

**Tim: "Stay hidden (Recommended)".** The choice read: *Like AutoCAD's Properties palette: if you closed it, it stays
closed. Double-click still opens the pipe's window.*

### UX-STD-10 — Inspector on a non-CE object (Q25)

**Tim: "What it is + a hint (Recommended)".** The choice read: *e.g. "Not a CE object: Polyline on layer DRAINAGE. To
make it a pipe, use Convert to Pipe."*

### UX-STD-11 — "Highlight warnings" switch retired (Q55)

**Tim: "Retire it (Recommended)".** The choice read: *The colours are how CE tells you something needs attention
(your 4 Sep emphasis rule), and every coloured chip also has words, so nothing depends on colour alone.* Retirement
approved by Tim here (explicit, per the no-retirement-without-Tim rule).

### UX-LOOK-01 (answered) — Master header and footer for every CE window

Tim was shown both real window pictures (New Pipe one-page reference and Settings, dark theme, from the plugin's
docs/image/V3_WINDOWS on master), then answered **"New Pipe's (Recommended)"**. The choice read: *CE logo, one-line
summary of what you're working on, status top right; tools bottom left, Cancel and the gold button bottom right. Tabs
only where a window has separate topics (like Settings).*

1. Every CE window uses the one-page New Pipe window's header and footer.
2. Tabs are used only where a window has genuinely separate topics (Settings keeps its tabs).
3. **Supersedes in part** the 5 Sep review line that froze the Settings design as the reference for every window's
   look (plugin repo docs/design/V3_UI/00C_TIM_REVIEW_2026-09-05.md): the shared colours, type and buttons stand (the
   two windows already match there); the header and footer now follow New Pipe.

### UX-WORD-03 — Feedback button (Q79)

**Tim: "Send report (Recommended)".** The choice read: *Then one honest line: "Sent to the office feedback folder", or
"Saved on this PC only: the office folder wasn't reachable".* (Today the report is saved locally and copied
best-effort to the IT Admin folder, read from FeedbackService on master, 25 Sep.)

### UX-WORD-03b — Parking a Drawing Repair item (R3)

**Tim: "Decide later (Recommended)".** The choice read: *Plain and says what happens; the item waits in the holding
list with your reason.* Replaces the design pack's "Leave undecided".

**Pass 2 status:** every Pass 2 question on the sorted list is now answered (14:10).

---

## Chat model — Tim, 25 Sep 2026, about 14:24

**Tim: "go but keep opus 5.5 medium".** This chat stays on Opus 5.5 at medium effort (Tim's override of the
prompt's Sonnet default, scope: this chat).

## Pass 3, family 1: pipes and pits, batch 1 — 25 Sep 2026, 14:26

### UX-PIPE-01 — "Keep separate" and "Keep as a free end" (design-pack Q6)

**Tim: "Keep both (Recommended)".** Both stay: touching a pit but not joined, versus joined to nothing.

### UX-PIPE-02 — Auto-join to the only matching pit within 75 mm (Q15)

**Tim: "On (Recommended)".** On by default in a new drawing; never guesses between two pits; one U or Disconnect
undoes it.

### UX-PIPE-03 — Escape at the third point of CD (release-v3 queued item 12)

**Tim: "Keep CE's rule (Recommended)".** Escape cancels the whole pipe; Enter gives the straight pipe (10 Sep rule
confirmed).

### UX-PIPE-04 — Recent values in the New Pipe window (release-v3 queued item 13)

**Tim: "Yes, all three (Recommended)".** One-click recent diameter, material and invert buttons in the one-page
New/Edit Pipe window, read from CE's existing saved recent lists. Build request (window build).

## Pass 3, family 1: pipes and pits, batch 2 — 25 Sep 2026, 14:30

### Design-pack Q7 (broken-pipe total length) — not decided, question withdrawn

**Tim: "this doesnt make sense to me".** The question was badly worded by this chat. Plain meaning: one real pipe
drawn as two pieces on the same sheet with a break (the "Broken on this plan" choice); CE measures the real total
length itself. Already covered by Tim's 2 Sep ruling (the real total is measured automatically, with an explicit
typed/pinned correction; plugin repo `docs/design/V3_UI/windows/02_PIPE.md`) and his 5 Sep rule that every value is
editable and marked manual. Nothing further asked.

### UX-PIPE-05 — "Hide" grade on every pipe type (Q8)

**Tim: "Every type (Recommended)".** The grade stays in the pipe's data and schedule either way.

### UX-PIT-01 — Plastic pit off the schedule still gets its plan label (Q14)

**Tim: "Yes, label it (Recommended)".**

### UX-PIPE-06 — One design grade for several selected pipes (Q18)

**Tim: "Allow, with preview (Recommended)".** The preview lists each pipe's new levels and anything downstream
before Apply; one U undoes it.

## Pass 3, family 2: downpipes and sources — 25 Sep 2026, 14:31

1. **UX-SRC-01 (Q26):** Tim: "Same symbol, different tag". OF and FO share one plan symbol; the tag (OF1 / FO1)
   tells them apart.
2. **UX-SRC-02 (Q27):** Tim: "Its own type (Recommended)". Strip drain is its own type in the Source window and
   asks for the run.
3. **UX-SRC-03 (Q28):** Tim: "RG1, RG2 (Recommended)". Raingardens are tagged RG.
4. **UX-SRC-04 (Q29):** Tim: "Drag, or type (Recommended)". Trench grate length: drag with the length shown live, or
   type it at any time, like LINE.

## Pass 3, family 3: water tanks (CDWT) — 25 Sep 2026, 14:35

1. **Design-pack Q30 (typed reuse), not asked:** covered by Tim's 5 Sep rule that every value can be overridden,
   marked manual.
2. **UX-TANK-01 (Q31):** Tim: "Keep it (Recommended)". No-detention tanks keep the one-line callout
   ("WT1 — 5000 lt TO BE USED FOR TOILET FLUSHING AND WATER REUSE"); three lines only when there is detention.
3. **UX-TANK-02 (Q33):** Tim: "Keep R1 / D1". Risers and droppers keep R1 / D1 numbering (recommended WT1-R/WT1-D
   not taken).
4. **UX-TANK-03 (Q34):** Tim: "Real record (Recommended)". "Annotate existing detention pit" gives the pit a real
   detention record, so CDCALC and the drawn-versus-issued storage check count it; the pit stays a pit.
5. **UX-TANK-04 (Q32):** Tim: "Retire it (Recommended)". The tank record's LidType "Standard" field is retired
   (explicit Tim yes); underground tanks carry their real lid and surface level.

## Pass 3, family 4: slab (CDSLAB) — 25 Sep 2026, 14:38

1. **Design-pack Q39 (Make fixed control: confirm first?), not asked:** answered by UX-STD-02 (no "Are you sure?"
   after a preview).
2. **UX-SLAB-01 (Q36):** Tim: "Keep "Meets 1 in 100" (Recommended)". Fall checks keep naming the rule ("Meets 1 in
   100" / "Below 1 in 100") before and after the rulebook is signed.
3. **UX-SLAB-02 (Q37):** Tim: "Right as it is". The nine-item Purpose list stays.
4. Q35 (demo-job outlet naming) is a test-fixture detail, not asked. Q38 (decimals) is a Settings default.

## Pass 3, family 5: review and checks — 25 Sep 2026, 14:40

1. **UX-REV-01 (CDPROFILE PR #187 decision 6):** Tim: "One Project Review (Recommended)". One Project Review window
   from the CE tab covering Civil and Structural (checks, calculations, profiles, proposals). CDPROFILE decision 6
   is closed.
2. **UX-REV-02 (Q50):** Tim: "Proposals tab (Recommended)". The Proposals button opens Project Review on
   Proposals; the Project Review button opens on Checks.
3. **UX-REV-03 (Q51):** Tim: "Confidence first, then size (Recommended)".
4. **UX-REV-04 (Q44):** Tim: "PDF (Recommended)". Export report defaults to PDF; CSV one tick away.
5. Q41 (passes folded) was answered by UX-STD-08.

## Pass 3, family 6: Pit Schedule and leftovers — 25 Sep 2026, 14:42

1. **UX-SCHED-01 (Q58):** Tim: "Updates the pit, with preview (Recommended)". A DEPTH typed in the Pit Schedule
   changes the pit's bottom level; the preview shows what else moves; one U undoes. The schedule never disagrees
   with the drawing.
2. **UX-SCHED-02 (Q59):** Tim: "Plus a checking sheet (Recommended)". Excel export: sheet 1 the schedule as drawn,
   sheet 2 each value with its source.
3. **UX-REV-05 (Q54):** Tim: "Yes (Recommended)". Applying a CE proposal records who approved it, the time and what
   changed, inside the drawing.
4. **UX-IMP-01 (Q61):** Tim: "Compare only (Recommended)". Import > Compare changes nothing; any update is a separate
   Apply with preview and one U. Today's write-before-compare behaviour goes.
5. Q56 (DET X (Grated) column) not asked yet: needs clearer context first.

## Pass 3, family 7: import and repair — 25 Sep 2026, 14:45

1. **UX-IMP-02 (Q60):** Tim: "Summary + open the list (Recommended)". CDCHECKDWG ends with one summary line and
   opens the full list in the results window.
2. **UX-IMP-03 (Q63):** Tim: "Choose files in the window (Recommended)". Survey files are chosen inside the Import
   window; CE shows what it found before anything goes into the drawing.
3. **UX-IMP-04 (Q64):** Tim: "Record + a file (Recommended)". The import report is kept in the drawing's record and
   saved as a PDF in the job folder.
4. **UX-REP-01 (Q70):** Tim: "Yes, with a warning (Recommended)". CDSYNC, CDREBUILD and similar stay typed-only with
   direct writes, starting with one line saying what they will change and that one U undoes it. No button.
