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

## Pass 3, family 7: import and repair — 25 Sep 2026, answered by 15:48

1. **UX-IMP-02 (Q60):** Tim: "Summary + open the list (Recommended)". CDCHECKDWG ends with one summary line and
   opens the full list in the results window.
2. **UX-IMP-03 (Q63):** Tim: "Choose files in the window (Recommended)". Survey files are chosen inside the Import
   window; CE shows what it found before anything goes into the drawing.
3. **UX-IMP-04 (Q64):** Tim: "Record + a file (Recommended)". The import report is kept in the drawing's record and
   saved as a PDF in the job folder.
4. **UX-REP-01 (Q70):** Tim: "Yes, with a warning (Recommended)". CDSYNC, CDREBUILD and similar stay typed-only with
   direct writes, starting with one line saying what they will change and that one U undoes it. No button.

## Pass 3, batch: Darebin note, repair holding list, administrator — 25 Sep 2026, 15:49

1. **CR-A2b (release chat's follow-up from the PR #228 review):** Tim: "Everywhere the orifice shows (Recommended)".
   The Darebin note (Darebin's published 1.0 and the smaller hole it gives; CE draws the 0.6 hole) appears in
   CDDESIGN's working, in CDCALC's Detention page and as a note under the drawn OSD table.
2. **UX-REP-02 (Q72):** Tim: "A tab in Drawing Repair (Recommended)". The "Decide later" holding list is a tab in
   Drawing Repair, with the count in its title.
3. **UX-REP-03 (Q73):** Tim: "Administrator only (Recommended)". Anyone can resolve a parked item; only an
   administrator can delete one outright, and CE records who and why.
4. **UX-ADMIN-01 (Q68):** Tim: "Tim only (Recommended)". Tim is the only CE administrator on day one; adding someone
   is done in Manager.

## Pass 3, family 8: Manager, Help and rule updates — 25 Sep 2026, 15:51

1. **UX-MGR-01 (Q77):** Tim: "Pick who, then everyone (Recommended)". Update colleagues: tick who gets a version
   first, then Everyone once proven; one click to roll back.
2. **UX-RULES-01 (Q69):** Tim: "Any time, you choose (Recommended)". A job may adopt a newer council rulebook at any
   time, only when the user clicks; CE shows what changed; issued jobs keep their issued edition.
3. **UX-MGR-02 (Q75):** Tim: "Drop it (Recommended)". Manager's "Open Hub" button is retired (explicit Tim yes); job
   review lives in the one Project Review on the CE tab.
4. **UX-HELP-01 (Q76):** Tim: "Yes (Recommended)". Help guides get an "Open in browser" button.

## Council RFI reader — Tim, 25 Sep 2026, 15:52

**Tim, verbatim: "we also need a council rfi ingest and reader".** Related existing record: the RFI checklists per
council in the CE guidebook v1.3 (`02_COUNCIL_RULES\CE_GUIDEBOOK_V1_3_SUPERSEDES.md` §2). This is new: reading the
actual RFI letter a council sends on a job.

1. **UX-RFI-01, what CE does** (multi-choice): Tim ticked "List every item as a to-do", "Check what it can itself",
   "Learn from it". Not ticked: "Draft the response".
   - Each council request becomes a line: what was asked, which drawing or calculation it concerns, done / not done.
   - CE checks the items it can against the drawing: Met / Not met / Can't tell, with Show where.
   - What councils keep asking for feeds the council rules and RFI checklists (UX-LEARN-01; client data stays local).
2. **UX-RFI-02, how it arrives:** Tim: "CE finds it in the job folder (Recommended)". CE spots a new council PDF in
   the job folder and asks "Read this RFI?"; dragging one in also works.
3. **UX-RFI-03, where it lives:** Tim: "A tab in Project Review (Recommended)". "Council RFI (n open)", with Show
   where and Fix working as for any check.
4. Build request logged in `IDEAS_INBOX.md`; needs a workflow card (release chat).

## Pass 3, last-but-one batch — 25 Sep 2026, 15:53

1. **UX-PIPE-07 (Q16):** Tim: "Whole job (Recommended)". "Keep as a free end" is remembered for the whole job.
2. **UX-SET-01 (Q65):** Tim: "Retire it (Recommended)". Settings' "Mirror Text Default" is retired (explicit Tim
   yes); the Pipe window's own mirror control, which remembers the last choice, is the one place.
3. **UX-ASK-01 (Q78):** Tim: "Both (Recommended)". Ask CE keeps "Review changes", and the same changes are listed
   under Project Review > Proposals.
4. **UX-DES-01 (Q83):** Tim: "Back to drafting (Recommended)". A draftsperson's "Confirm setup" closes Design and
   returns to drafting.

## Design window, last two — 25 Sep 2026, 19:56

1. **UX-DES-02 (Q82):** Tim: "Fixed CE colours (Recommended)". Area overlay in Design: roof blue, driveway orange,
   paving purple, garden grey, unknown amber, on every job; preview only.
2. **UX-DES-03 (CDSETUP card Q5):** Tim: "During (Recommended)". A part-drawn, unchanged job opens Design on During.
3. Q84 (outlet invert source words) was answered 5 Sep. Q56 (Pit Schedule "DET X (Grated)" display column) is
   parked: the question could not be worded clearly; not decided.

## Release-chat follow-ups — 25 Sep 2026, 20:04

1. **UX-PIPE-02b (auto-join behaviour; nothing built yet):** Tim: "Pits or pipe ends". A new pipe's end placed within
   the Settings distance (75 mm default) of a pit or another pipe end is snapped on and linked, shown in the
   preview. (Recommended "pits only" not taken.) Carried standing rules: never guess between two candidates (ask);
   one U or Disconnect undoes; off switch in Settings.
2. **UX-PIPE-06b (downstream when setting one grade on several pipes):** Tim, his own words: "both options".
   **Interpretation (this chat's, not a ruling):** the preview offers both, and the drafter chooses each time:
   "Only the selected pipes" (downstream clashes listed as warnings) or "Carry downstream" (downstream pipes
   re-graded, all shown first). Which one is pre-selected is not decided.
3. **UX-STRUC-01 (Structural PR #236, closed-sheet writes):** Tim: "Keep, with a notice (Recommended)". CE Sheets
   sync and project setup keep updating closed sheet drawings and say plainly which ones they changed; open
   drawings are never saved for the user; Issue/Publish warns if an open sheet has unsaved changes.
4. **UX-TANK-04b:** Tim: "Retire (Recommended)". The LidType "Standard" field is also retired on AGI drain and
   trench grate records.

## Release-chat cards approved — 25 Sep 2026, 21:20

Cards in `04_REFERENCE\ux-plan\cards\` (release chat, 25 Sep). Tim was asked to approve each with its recommended
answers.

1. **Approved with recommended answers** (Tim ticked all four): UX-RIBBON-01 ("Pipe tab jump"), K-REQ-01 ("Section
   + schedule together"), REPAIR-DECIDE-LATER ("Decide later tab"), UX-LEARN-01 ("Learning, slice 1").
2. **DETENTION-PIT-ANNOTATE approved:** Tim: "Approve (Recommended)". CDPITDETENTION beside PIT; "DETENTION PIT"
   only; widths pre-filled from Settings (never a zero-volume pit); indicative volume shown before Accept; warns if
   connected pipes are not Detention; additive with a tank's detention; preview, one U.
3. **UX-RIBBON-04 corrected and approved:** Tim: "Yes, as the card says (Recommended)". CETOOLS stays on the
   Structural ribbon; CECHECKLIST and CETOOLSTOGGLE merge into it (typed redirects kept); only CENOTES moves into
   Manager; STRIPLAYERSMERGE and STRUCLINKTEXT stay typed in Structural. Refines UX-RIBBON-04's earlier wording.
4. **CESTRUC / StrucSuiteWindow (UX-RIBBON-04 OPEN 2):** Tim, his own words: "needs to be revisited in detail before
   deciding". Not decided; kept as is until a detailed review.

## Two checks on today's answers — 25 Sep 2026, 21:46

1. **UX-PIPE-06c:** Tim: "Only these pipes (Recommended)". The several-pipes grade preview opens with "Only these
   pipes" ticked; "Carry downstream" is the other choice. Confirms this chat's interpretation of "both options".
2. **UX-STD-01b:** Tim: "Carry on by default (Recommended)". CD and PIT carry on until Enter or Escape by default,
   like the source commands; no Batch tick needed. Corrects the build that made them carry on only with a Batch
   tick switched on (off by default).

---

## Structural front door — 25 Sep 2026, 22:56

Inventory read from the installed Structural's registry (commit 8c077569, `Modules/Structural/Assets/Config/
command-registry.json`): 307 commands, 298 visible; largest groups Text Tags 56, Hatching 38 (patterns 20, presets
18), Utilities/Legacy 29, Beam 16; many duplicates.

1. **UX-STRUC-02 — families on the ribbon:** Tim: "Families (Recommended)". The Structural ribbon shows families
   with drop-downs (Beam ▾ Regular/Lower/Special/Offset, Text ▾, Tag ▾, a Hatch gallery with pictures); each
   remembers the last pick; about 40 tools shown; every typed code unchanged.
2. **UX-STRUC-03 — duplicates:** Tim: "One each + shortcuts (Recommended)". One real command per tool
   (e.g. CENTERLINE/CENTRELINE/CL/CLINE; FFL/FFLMARKER/FLMK; RB/REBAR; SCAB/SCABBLE; COPYM/CEMCOPY; BEXT/BEXTEND);
   the other names stay as silent typed shortcuts; Help and the ribbon show one name.
3. **UX-STRUC-04 — tags:** Tim: "Codes + one Tag tool (Recommended)". The 56 text/tag codes stay typed; one Tag tool
   on the ribbon: pick the object and side once, and it remembers.
4. **UX-STRUC-05 — "Legacy" utilities:** Tim: "Sort into proper families (Recommended)". Piers to Foundations, rebar
   to Rebar, floor level and centreline to Annotate, and so on; the word "Legacy" disappears.
5. Diagnostic/test commands hidden from drafters (e.g. CEDEBUG, JOBTIMERDEBUG): presented as part of the polished
   version; not separately asked.

---

## Structural D1 card — Tim's 12 choices, 25 Sep 2026, answered by 23:13

Card: `04_REFERENCE\structural\STRUCTURAL_D1_CARD_DRAFT_2026-09-24.md` §3 (planned for Tuesday; Tim chose to do it
today). Numbers follow the card.

1. **Permanent name:** Tim: "One system with Civil (Recommended)". The spine name Civil pits and pipes use; each
   beam and column named when drawn, inside the same U.
2. **Column grip:** Tim: "Edit together (Recommended)".
3. **Beam end grip:** Tim: "Edit together (Recommended)". The label slides to stay centred.
4. **Beam middle grip / MOVE on the beam alone:** Tim: "Edit together (Recommended)".
5. **Typing over a label:** Tim: "Text changes; QA notes it (Recommended)". QA lists "Label says B3, beam is B1" with
   "Make the beam B3"; no pop-up.
6. **Shared mark, Enter:** Tim: "All B1s (Recommended)", with the count shown.
7. **AutoCAD MOVE on a column without its beams:** Tim: **"Beams follow"** (recommended "what you select moves" not
   taken). Beam ends follow the column even with plain MOVE, which cannot show CE's preview; this chat noted to Tim
   that one U must take back the column and beam ends together. Resolves the card's conflict between the July rule
   (moving a support updates its beam ends) and the September no-silent-change rule in favour of the July rule for
   MOVE.
8. **Schedule mismatch display:** Tim: "QA list + non-printing highlight (Recommended)".
9. **Mark with no schedule row:** Tim: "Offer to add a row (Recommended)". Size stays Unknown until typed.
10. **Last B4 erased:** Tim: "Row stays, QA notes it (Recommended)".
11. **Where the schedule values live:** Tim, his own words: **"ideally xclmtxt and then it gets phased out as the
    comps are done easier and better within autocad as the plugin"**. For D2 the engineer's Excel schedule brought in
    by XCLMTXT stays the one member schedule (linked by mark). Longer term, XCLMTXT is phased out as the computations
    move into the plugin inside AutoCAD (links to the 20 Sep idea: CE_COMPSHEET into the Structural module).
12. **Grip versions:** Tim: "2027 first (Recommended)". 2022-2026 keep plain grips plus right-click and beam-panel
    actions until a later step.

**Card status:** all 12 choices answered; section 5's test drawing and checklist not yet reviewed with Tim.

**D1 card APPROVED — Tim, 25 Sep 2026, 23:14: "Approve (Recommended)".** The question read: *Approve the D1 card, with its
test drawing and 12 steps plus step 13 (MOVE C1 alone: beams follow, one U restores all three)?* Added test step
13: MOVE C1 alone 300 mm; both beam ends follow and labels re-centre; one U puts all three back.

---

## Structural drawing journey — priority after D1, 25 Sep 2026, 23:19

Walked through Tim's 14 Sep journey rulings (`04_REFERENCE\structural\STRUCTURAL_JOURNEY_RULINGS_2026-09-14.md`)
stage by stage, with today's state (read from the installed registry, not AutoCAD-tested).

**UX-STRUC-06:** asked which stages Structural V3 tackles first after beams (D1), up to three, most important first.
Tim ticked, in this order: **"QA against the markup"**, **"Register, revisions, issue"**, **"Background preparation"**.
Not ticked: "Detail browser".

1. Order after D1: (1) QA against the engineer's markup (stage 6); (2) drawing register, per-sheet revisions and
   issue (stage 7); (3) architectural background preparation (stage 2). The detail browser (stage 5) follows later.
2. Each needs its workflow card before any build (release chat), reusing the 14 Sep rulings; stage 2 first needs
   real prepared Xrefs studied (the 14 Sep record says the cleanup rules must be learned from actual jobs).

## Structural QA against the markup, batch 1 — 25 Sep 2026, 23:23

Builds on the 14 Sep rulings (Missing / Different from markup / Unable to verify; highlight with markup beside;
agreed departures remembered; issue-time decision; review highlights never print).

1. **UX-QA-01, reading the markup:** Tim: "CE proposes, you correct (Recommended)". CE reads the handwriting (AI
   vision) and proposes each item with the markup snippet beside it; the user fixes or deletes wrong items and clicks
   any missed mark to add it; CE learns from the corrections (UX-LEARN-01).
2. **UX-QA-02, where the markup shows:** Tim: "Faded over the plan + side list (Recommended)". The marked-up page
   sits lined-up and faded under the drawing (toggle on/off), with the item list docked beside; clicking an item
   zooms there.
3. **UX-QA-03, when it runs:** Tim: "On demand + at issue (Recommended)". A "Check against markup" button, always
   before issue, and a quiet open-item count in the QA panel; never pop-ups.
4. **UX-QA-04, item states:** Tim: "Yes, those four (Recommended)". To do, Drafted, Needs clarification, Checked. CE
   may set Drafted when it sees the item drawn; only a person marks Checked.

## Structural QA against the markup, batch 2 — 25 Sep 2026, 23:28

1. **UX-QA-05, AI provider permission for markup reading (DATA-01 / Gate 0 provider permission):** Tim: "Yes, Claude
   only, page only (Recommended)". The choice read: *Only the markup page goes, only to Claude through CE's
   connection, never kept for training; the title-block area is blanked first where possible. Recorded as your
   provider permission.* Scope: engineer markup page images for QA reading only. Not a permission for any other
   provider or any other job data.
2. **UX-QA-06, markup rounds:** Tim: "One list, grouped by round (Recommended)". A new round's items join the list
   tagged by round; earlier open items stay open; items a new round changes are marked "superseded by P3".
3. **UX-QA-07, clarification list:** Tim: "Yes, a PDF list with snippets (Recommended)". "Needs clarification" items
   become a one-page PDF with markup and plan snippets; the user sends it; CE never emails.
4. **UX-QA-08, engineer-drafted changes:** Tim: "Yes, compare drawing versions (Recommended)". CE compares the
   engineer's drawing with the last version and lists the changes as items, with the same states and highlights.

**QA against the markup: all workflow choices answered.** Needs a workflow card from these plus the 14 Sep rulings
(release chat).

## Structural register, revisions and issue — 25 Sep 2026, 23:33

Builds on the 14 Sep rulings (one sheet list; suggest-then-confirm affected sheets; unchanged sheets keep revision
and date; P/T/A not hard-coded; issue preview; one combined PDF; clouds after A, current changes only; failed plot
finalises nothing).

1. **UX-REG-01, what changed:** Tim: "Compare with last issue (Recommended)". CE compares each sheet with its last
   issued version and lists changed sheets with a reason; the user ticks which get a new revision.
2. **UX-REG-02, next revision:** Tim: "Suggest, you pick stage (Recommended)". After P3 CE offers P4 / T1 / A with the
   likely one pre-picked from the job's pattern; remembered per job.
3. **UX-REG-03, revision clouds (after A):** Tim: "CE proposes, you adjust (Recommended)". CE draws proposed clouds
   and triangles around each change in the preview; the user accepts, moves, reshapes or deletes each before issue.
4. **UX-REG-04, register location:** Tim: "On the cover sheet, auto (Recommended)". The drawing list table on the
   cover/notes sheet updates from the one sheet list, plus an Excel copy in the issue folder.

## Structural register and issue, batch 2 — 25 Sep 2026, 23:37

1. **UX-REG-05, status words:** Tim: "Yes, from the revision (Recommended)". P revisions read PRELIMINARY, T FOR
   TENDER, A onwards FOR CONSTRUCTION; shown in the issue preview; wording is a Settings value and can be changed.
2. **UX-REG-06, who issues:** Tim: "Anyone, names the engineer (Recommended)". Any CE user issues, picks the approving
   engineer (printed in the title block); who pressed Issue is recorded (same as UX-CALC-03).
3. **UX-REG-07, new sheet number:** Tim: "Next in its group (Recommended)". Gaps are never filled or renumbered
   without asking.
4. **UX-REG-08, where issue starts:** Tim: "Sheets window + Project Review (Recommended)". Both open the one issue
   preview.

## Structural cards (release chat, commit d65586a7) — 25 Sep 2026, 23:39

Cards in `04_REFERENCE\structural\cards\`.

1. **STRUC-RIBBON, which name wins in each duplicate group:** Tim: "Shortest code (Recommended)". AutoCAD style (CL
   over CENTRELINE, RB over REBAR, FFL over FFLMARKER); all other names keep working typed. The card's other two
   recommendations (footing/slab "over" and left/right groups stay separate until a detailer confirms; hide
   CEMARKUPBENCH) were not put to Tim separately.
2. **STRUC-MARKUP-QA, title block cannot be blanked:** Tim: "Don't send; say so (Recommended)". CE does not send that
   page to Claude and tells the user to tag that page's marks by hand.
3. **STRUC-REGISTER-ISSUE, multi-DWG job:** Tim: "One PDF, register order (Recommended)".
4. **STRUC-ARCH-BACKGROUND, example jobs:** Tim: "Pick recent completed jobs". The release chat may pick 2-3 recently
   completed Structural jobs from the office Projects folder to study read-only; nothing copied into any repository;
   client names and addresses stay on Tim's PC (DATA-01). This is Tim's permission for that bounded read.

## Structural hatch and text families — 25 Sep 2026, 23:45

1. **UX-STRUC-07, hatch gallery:** Tim: "Yes, that layout (Recommended)". Most-used presets at the top (learned),
   then material picture tiles, colour swatches, and the hatch tools (Library, Change Preset, Batch, Gap
   Assistance, Audit, Make Annotative) along the bottom; typed codes unchanged.
2. **Hatch code convention (office knowledge, recorded per R-LEARN):** asked whether the solid-colour hatches have
   fixed meanings, Tim explained the naming instead, verbatim: **"its colour then type then h to denote its a
   hatch"**. So a hatch code is AutoCAD colour number + pattern-type letter(s) + H: e.g. 21H colour 21 solid,
   21DH colour 21 dot, 21LH colour 21 diagonal/line, 11CH colour 11 concrete, 6DH colour 6 dot. Consequence for the
   gallery (this chat's proposal, not a ruling): group the colour hatches by pattern type with colour swatches, and
   show each tile's code so users learn the pattern; any new preset follows the same convention.
3. **UX-STRUC-08, text:** Tim: "Yes, size + compass (Recommended)". One Text button: pick 1.8 or 2.5 mm and a
   position on a compass pad; remembers the last pick; the 11 codes stay typed.
4. **UX-STRUC-09, tags:** Tim: "Smart tag, picker as backup (Recommended)". Click a CE beam, column or footing: CE
   places the right tag on the side clicked; a small picker (object, over/under, side) for anything not recognised.

### UX-STRUC-09b — Smart tagger learns placement from history (Tim, 25 Sep 2026, 23:46)

**Tim, verbatim: "a smart text tagger which you select object and it automatically places tag correctly based off
historical data would be great".** Extends UX-STRUC-09: select the object and CE places the tag (type, side, offset,
rotation) the way CE's past drawings did it, learned from history (UX-LEARN-01 "past CE projects" and "your
corrections"; client data stays local, only anonymised lessons shared). Every placement is previewed and one U; a
moved tag is remembered as a correction.

### UX-STRUC-10 — CESTRUC "CE Structural Suite" window (Tim, 25 Sep 2026, 23:54)

Read at 8c077569: a modeless window of 109 command buttons in 7 tabs (Beams, Text + Supports, Bracing, Bored Piers,
Imports, Schedules + Export, Utilities) plus Reload LISP and Deploy Assets. Offered: replace with a "Find a tool"
search window / retire / keep.

**Tim, verbatim: "cestruc does a lot more than search commands, retire the search as ribbon will cover it".**

1. The command-launcher role of CESTRUC is retired; the family ribbon covers it.
2. **Interpretation (this chat's, per the full-function-preservation rule):** nothing CESTRUC does is lost. Every
   function reachable today only through CESTRUC (e.g. Create / Refresh / Sync Schedule, Export CSV / PDF / Blocks,
   FADOPT, FREGEN, FREGENALL, Link Text to Entity, Reload LISP, Deploy Assets, the CEADMIN lists, the XRL tools) gets
   a ribbon or Manager home, listed Kept/Moved in a card, before the window is retired. The "Find a tool" search
   window is not adopted. Supersedes the "revisit in detail" hold recorded earlier today.

## Structural detail browser — 25 Sep 2026, 23:55

Builds on the 14 Sep eight approved detail-browser behaviours and statuses.

1. **UX-DET-01, one library:** Tim: "One palette: Blocks | Details (Recommended)". CE Blocks (approved 24 Sep) and the
   detail browser become one "CE Library" palette with Blocks and Details tabs and one search box.
2. **UX-DET-02, who approves office standards:** Tim: **"Any engineer"** (recommended "Administrator" not taken). Any
   engineer may mark a detail Approved office standard; batch approval of trusted groups allowed; the approver and
   time are recorded (consistent with UX-CALC-APPROVE-01).
3. **UX-DET-03, PDF-only details:** Tim: "Reference picture, marked (Recommended)". Placed as a linked PDF underlay
   with a small "REFERENCE ONLY - not editable" tag until redrawn as a DWG detail.
4. **UX-DET-04, numbering:** Tim: "Yes, number and track (Recommended)". CE gives the next detail number on the sheet
   and title; if a detail or sheet moves, every callout (e.g. "5/S20") updates, with a preview.

---

## Help and first run — 25 Sep 2026, 23:57

1. **UX-HELP-02, first run:** Tim: ""Start here" button, lit once (Recommended)". A highlighted "Start here" on the CE
   tab until clicked: a 2-minute picture tour of the ribbon and the five things to know (Pipe, Pit, Edit, Checks,
   Help); never shown again once opened. No pop-up (SH2 stands).
2. **UX-HELP-03, What's New:** Tim: **"Opens once after update"** (recommended "dot on Help" not taken). What's New
   opens by itself the first time AutoCAD starts after an update, once. **Note:** this is a deliberate exception by
   Tim to the July "no startup pop-up" ruling (SH2), limited to the first start after an update.
3. **UX-HELP-04, F1:** Tim: "Yes, context help (Recommended)". F1 or a small ? in any CE window or command opens that
   command's guide at the part in use.
4. **UX-HELP-05, role:** Tim: "Ask once, first run (Recommended)". The Start-here tour asks "Engineer or
   Draftsperson?" once; changeable any time on the CE panel. (Colleagues otherwise get Tim's set-up and switches.)

## Manager — 25 Sep 2026, 23:59

1. **UX-MGR-03, home page:** Tim: "One-glance status page (Recommended)". Civil / Structural / Manager versions with
   green-amber-red, up to date or update ready, and any problem in plain words with its fix button.
2. **UX-MGR-04, update arrival:** Tim: "Quietly at next start (Recommended)". Downloaded in the background, switched
   on at the next AutoCAD start (never mid-drawing), then What's New opens once (UX-HELP-03).
3. **UX-MGR-05, rollback:** Tim: "Yes, one click, you're told (Recommended)". Any user can go back to the previous
   version in Manager (applied at next start); a note goes to the office feedback folder saying who and why.
4. **UX-MGR-06, one report:** Tim: "Merge (Recommended)". Feedback "Send report" and the Support bundle become one
   "Report a problem" everywhere (ribbon, Help, error messages); versions and recent log added automatically; the
   drawing only if ticked. UX-WORD-03's honest result line applies.

## Civil labels and annotations — 26 Sep 00:00 2026

1. **UX-LBL-01, hand-placed labels:** Tim: "Stays where you put it (Recommended)". Hand-placed labels are remembered
   and never re-tidied; a new clash is listed quietly in Checks.
2. **UX-LBL-02, re-tidy after edits:** Tim: "Straight away, in the same U (Recommended)". CE-placed labels that now
   clash are re-placed in the edit's own preview; one U undoes edit and tidy together.
3. **UX-LBL-03, Tidy labels command:** Tim: "Yes (Recommended)". Tidies every CE label on a sheet or selection by
   slide-then-flip, skipping hand-placed ones; preview first; one U. (Relates to the CV-01I annotation tidy-up plan.)
4. **UX-LBL-04, what tidying avoids:** Tim: "Avoid everything, move only CE (Recommended)". CE labels avoid Xref
   content, other disciplines' text and hatches; only CE labels ever move.

## Civil site and slab tools — 26 Sep 00:04 2026

Builds on the 5 Sep Slab System review (one Slab window; outlets; Show flow; joints advisory until a signed rule;
tree-zone radius from the report only).

1. **UX-SITE-01, arborist report:** Tim: "CE reads it, you confirm (Recommended)". CE finds the arborist PDF in the job
   folder, lists each tree with TPZ/SRZ radius and page; the user confirms before anything is drawn.
2. **UX-SITE-02, joint proposals:** Tim: "Propose, marked advisory (Recommended)". CE proposes construction joints and
   saw cuts learned from past slabs (re-entrant corners, pit clearances, panel shapes), previewed and labelled
   "Advisory - from past jobs"; each accepted, moved or deleted by the user. Stays advisory under the 5 Sep ruling.
3. **UX-SITE-03, spoon drains:** Tim: "Drag with live fall (Recommended)". Pick points with length and fall shown live;
   linked to its slab and outlet.
4. **UX-SITE-04, slab boundaries from the background:** Tim: "Offer, you confirm (Recommended)". CE highlights closed
   outlines found in the architect's background as possible slabs; click to use; own pick or drawing still allowed.

## Civil survey — 26 Sep 00:06 2026

1. **UX-SURV-01, surface level from the survey:** Tim: "Fill it, marked "Survey" (Recommended)". Placing a pit fills
   the existing surface level from the linked survey with the source word "Survey"; typing over it makes it
   "manual"; no nearby survey level means Unknown, never a guess.
2. **UX-SURV-02, revised survey:** Tim: "Compare and list effects (Recommended)". CE compares old and new surveys and
   lists changes that affect the design, with Show where; the user chooses which to update, one U.
3. **UX-SURV-03, spot levels:** Tim: "Shows existing, you type proposed (Recommended)". CDSL shows the survey level at
   the clicked point and the user types the proposed level.
4. **UX-SURV-04, survey approval:** Tim: "Any user, recorded (Recommended)". Whoever links the survey confirms the
   survey and AHD datum; name and time recorded, shown in Project Review.

**Civil families: all covered in the V3 plan discussion.**

## Pipe-size suggestions (CV-02A) and Structural timing — 26 Sep 00:08 2026

Plan read: `archive\plugin-docs-july-2026\workflows\CV-02A_ASSISTED_PIPE_SIZING_PLAN.md` (July; not approved then).

1. **Structural timing — CORRECTED 26 Sep by Tim:** *"Structural once Civil passes are done, i meant our plan discussions"*. His first words referred to the ORDER OF THIS CHAT'S DISCUSSION (Structural UX after the Civil passes), not to builds. Original record kept below. Tim wrote "we needs to work on structural once civil passes are done", then, asked what
   to do with the D2 beam build already started, chose **"Keep both going"**. Structural continues alongside Civil;
   the release chat keeps its own pacing (usage, one AutoCAD test at a time).
2. **UX-SIZE-01, where suggestions appear:** Tim: "Pipe window + Proposals (Recommended)". One advisory line in the
   Pipe window while drawing or editing (never changes the pipe), and the whole-network review in Project Review >
   Proposals.
3. **UX-SIZE-02, modes:** Tim: "Yes, tie them (Recommended)". Draftsperson mode checks against the supplied design
   (Matches / Different / Can't verify); Engineer mode suggests sizes (Keep / Upsize / Unknown / No size works).
4. **UX-SIZE-03, accept all:** Tim: "Accept all allowed (Recommended)". After the preview, Accept all applies the clear
   suggestions in one U; Unknown and no-feasible-size pipes are never included and stay listed. Supersedes the July
   plan's "visit every pipe first" gate.
5. Unchanged from the July plan and not re-asked: no automatic downsizing (information note only); the numeric sizing
   rules need engineer sign-off before production suggestions (CV-02A4 gate).

## Pit Schedule DET X column (design-pack Q56) — 26 Sep 00:10 2026

**UX-SCHED-03:** Tim: "Inside, as printed (Recommended)". The Pit Schedule window shows a detention pit's grated size
inside PIT SIZE and LID TYPE + REMARKS exactly as the printed schedule does (no eleventh on-screen column);
double-clicking the row edits it. Closes the parked Q56. **All 86 design-pack questions are now answered, overtaken
or covered by standing rules.**

## Structural D2 slice 1 questions (release chat, PR #250) — 26 Sep 00:18 2026

1. **UX-D2-01, ordinary column grip before CE grips:** Tim: "Keep (Recommended)". Dragging a column's ordinary
   AutoCAD grip moves its beams (no preview, like MOVE), one U, until CE's own grips arrive.
2. **UX-D2-02, column label:** Tim: "Yes, next slice (Recommended)". A column's own label (e.g. "C1") moves with the
   column; a hand-placed label keeps its offset. Card item for D2 slice 2.
3. **UX-D2-03, test tool:** Tim: "Yes, keep it (Recommended)". The builder's headless beam-check tool is kept in the
   plugin repo next to Civil's headless proof, never shipped to colleagues (Tim's approval for new test tooling).
4. **Permanent names on the Structural line (not asked):** bringing the shared spine-name component onto the
   Structural shipping line is technical and follows Tim's D1 choice 1 ("One system with Civil"); decided by this
   chat as implementation, under the one-version rule.

## Clash check: July cards vs 25-26 Sep rulings — 26 Sep 00:21 2026

Read-only check of 24 July card files (`04_REFERENCE\CARDS\`) against this file; three conflicts found.

1. **ST-09 ST9-1/ST9-2 vs UX-RIBBON-04 (corrected):** July had CETOOLS/CECHECKLIST opening Manager "Coordination"
   sections; 25 Sep keeps CETOOLS on the Structural ribbon (CECHECKLIST merged into it), only CENOTES into Manager.
   The later, explicit 25 Sep ruling governs; not re-asked. ST-09 is superseded on that point.
2. **UX-SCHED-01b (PS-01 PS11 superseded):** Tim: "Update the pit, all values (Recommended)". Any engineering value
   typed in the Pit Schedule (depth, invert, cover level, lid class...) updates the pit or pipe, with preview and one
   U; the schedule never disagrees with the drawing. A separate right-click "display only" remains for the rare case
   of matching an issued council schedule. Supersedes PS11's "offer two explicit paths" for typed engineering values.
3. **UX-STRUC-11 (ST-07 controlled schedule edit superseded):** Tim: "Any CE user, recorded (Recommended)". A beam
   size change driven by the engineer's Excel schedule can be applied by any CE user after the preview; name, time
   and Excel revision recorded; QA shows it until checked. Supersedes ST-07's "Timothy or the responsible engineer
   must approve the update".

## CDRG and DP placement — 26 Sep 00:24 2026

Release chat's question (test N4): CDRG places nothing on ordinary pipes because they do not record their end pits.

**UX-SRC-05 — Tim, verbatim: "cdrg and dp are not pipe dependent if anything they are similar to pits which in most
cases get placed prior to pipes connecting them".**

1. CDRG (raingarden + grated inlet) and DP (downpipe) are placed like pits: anywhere, **before** pipes exist; they
   do not need a pipe to land on.
2. Pipes drawn later connect **to** them, the same way pipes connect to pits (auto-join UX-PIPE-02b applies).
3. None of the three offered options was chosen; the premise (place onto an existing pipe) was wrong. Consistent
   with the 15 Sep idea that sources place anywhere with CD's live feedback.

## Items queued for Tuesday, settled early — 26 Sep 00:30 2026

From `areas\release-v3-colleagues.md` "Queued for Tim, Tuesday 29 Sep".

1. **Item 14, UX-SET-02:** Tim: "Add to Settings > Design (Recommended)". The standard LPD note wording gets an
   editable text box on the Settings Design page; CDLPD writes whatever is there.
2. **Item 17, UX-PIT-02:** Tim: "Outline + 100 mm (Recommended)". A pit catches a pipe end only within its own outline
   plus 100 mm (not the ~1 m hidden 950 mm circle), proved on a real job copy first. Supersedes the R6.10 "never
   shrink it" note for this reach.
3. **Item 10, UX-TPL-01:** Tim: "Skip templates + delete stray (Recommended)". The open-time pipe upgrade skips the
   office Templates folder (no upgrade, no in-place backup); the one stray backup
   `Drawings Templates\A1 Templates\CE_A1_C01 - VERTICAL_PRE_C7_20260923_084850.dwg` is to be deleted (Tim's explicit
   yes; the template itself is unchanged). Deletion is done by the release chat, after re-checking the template.
4. **Item 8, CDPIPEOBJ:** Tim asked, verbatim: "is this not a temporary command to test the object prior to making it
   part of the cd/pipe command and all pipes are upgraded to this when opening old drawings". Read from master:
   CDPIPEOBJ draws a pipe directly as the one CE object (2027 only); CDC7UPGRADE converts existing pipes; pipes are
   also upgraded on open. Follow-up question put to Tim below.

**UX-PIPE-08 (item 8):** Tim: "Hide now, retire later (Recommended)". CDPIPEOBJ is hidden from the ribbon and Help now
(still works typed for testing), and retired once CD itself draws the one-piece pipe and Tim has accepted it in
AutoCAD (retirement approved in advance on that condition).

## Council tools and Structural 2022 — 26 Sep 00:38 2026

1. **UX-CR-01 (council OPEN_QUESTIONS C13 and the CR spec "produce the enquiry"):** Tim: "Yes, one-page enquiry
   (Recommended)". For councils that issue the allowed discharge on request (Boroondara, Bayside, Monash, Manningham),
   Design offers "prepare enquiry"; CE measures the figures off the plan and fills that council's form or letter;
   the user checks and sends; council's reply figures are entered against the job with the letter as source.
2. **UX-CR-02 (B3):** Tim: "Suggest from the surface (Recommended)". CE pre-fills the lid class from where the pit sits
   (driveway/hardstand etc.) with the reason shown; editable; class per location is a Settings/council value.
3. **UX-CR-03 (B10e):** Tim: "Show and warn (Recommended)". A traced council drain gets a non-printing 1 m each-side
   "implied easement" band; CE warns if a footing, tank or pit sits inside it.
4. **UX-STRUC-12 (release-v3 queued item 7):** Tim: "Same Structural, that one tool greyed (Recommended)". AutoCAD 2022
   colleagues get the full Structural build; CEARCHREVIEW shows greyed with "needs AutoCAD 2027".

## Council tools, batch 2 — 26 Sep 00:41 2026

1. **UX-CR-04 (B4):** Tim: "Own system, rule per council (Recommended)". AGI runs are their own network; where a
   council requires AGI to bypass detention, CE warns if an AGI connects into storage (or below the council's height
   above the baffle, e.g. Manningham 150 mm).
2. **UX-CR-05 (B10a):** Tim: "Warn on short offcuts (Recommended)". A pipe split leaving a piece shorter than a Settings
   minimum (per council where published) shows "short offcut next to P4" in the preview with a suggestion to nudge
   the pit.
3. **UX-CR-06 (B10b):** Tim: "Shared base + overrides (Recommended)". Council settings hold one shared base that each
   council inherits; each council page highlights only what differs; the rest reads "from base".
4. **UX-CR-07 (B10d):** Tim: "Yes, in Design's start (Recommended)". On a Boroondara job, Design measures the distance to
   kerb/easement at the start and says which outfall requirement applies, citing the council table.

## Council tools, batch 3 — 26 Sep 00:43 2026

1. **UX-CR-08 (B6):** Tim: "Default from council + warn (Recommended)". New pipes default to the council's minimum class;
   a material the council refuses warns with the source; editable.
2. **UX-CR-09 (B7):** Tim: "Warn, with source (Recommended)". Items a council refuses (e.g. Maroondah multi-cell units,
   driveway above-ground storage) warn with the document reference; never block.
3. **UX-CR-10 (B8):** Tim: "Always show it (Recommended)". The OSD criteria block always shows required and provided
   detention volume, from the same record as the computations sheet.
4. **UX-CR-11 (B9):** Tim: "Check and tell (Recommended)". On linking a survey, CE compares its contour interval (and
   extent) with the council's rule and warns early (e.g. Whitehorse 0.1/0.2 m, 10 m beyond the boundary).

## Council tools, batch 4 — 26 Sep 00:46 2026

1. **UX-CR-12 (B5):** Tim: "Check, council value wins (Recommended)". Every pipe's velocity is checked against the
   minimum; the council's published figure applies where it exists, otherwise R-02 (0.6 m/s); a slow pipe shows a
   quiet warning in Checks and the Pipe window.
2. **UX-CR-13 (B10c/B10f):** Tim: "Yes, at Design start (Recommended)". Design states at the start whether detention
   is needed under the council's hard-surface threshold, with the source; the engineer can override.
3. **UX-CR-14 (A4):** Tim: "Show it, quietly (Recommended)". Design shows the council's named AS/NZS 3500.3 edition
   beside the office edition (R-24) as information only.
4. **CR-D1 (sweep):** Tim: "Yes, sweep all (Recommended)". Sweep all 22 council profiles for the known error patterns
   (copied values, wrong field, wrong row), each change listed with its source for Tim to glance at; unsure values
   become Unknown.

## Council tools, batch 5 — 26 Sep 00:47 2026

Covered without asking: B2 (pipe too big for pit) by Tim's 15 Sep ruling "ASK to upsize" (IDEAS_INBOX 15 Sep); B10
(critical duration stated) by the approved D+F card.

1. **UX-CR-15 (C1):** Tim: "Warn per council (Recommended)". Drawing a basement pump station shows that council's
   basement rule beside the office rule R-23 and warns where they differ.
2. **UX-CR-16 (C11):** Tim: "Ask once on Banyule jobs (Recommended)". Design asks whether the site falls to the rear
   (or reads it from survey levels) and applies Banyule's 1-in-20 storm if so, with the source.
3. **UX-CR-17 (C12):** Tim: "Check against floors (Recommended)". With floor levels known, CE checks the top water
   level against each council's floor freeboard and warns on failure; the 150 mm water-to-lid rule stays alongside.
   Floor level still never sets the water level.
4. **CR-C2:** Tim: "Not sure, mark Assumed (Recommended)". Whitehorse's 90 mm minimum orifice stays but is marked
   "Assumed - source not found" until a Whitehorse document confirms it.

## Drawing intelligence: keeping the network right — 26 Sep 00:49 2026

Master plan Stage 3 (bounded local reassessment; Connect/Disconnect/Ignore/Resolve; CDCHECK and Show where;
CDTRIM/CDEXTEND/CDBREAK/CDJOIN).

1. **UX-DI-01:** Tim: "Straight after, quietly (Recommended)". After an ordinary AutoCAD edit, CE re-checks only the
   edited items and their neighbours; ends that no longer touch turn amber "Not connected yet"; no pop-up; shown in
   Checks; never reconnects on its own.
2. **UX-DI-02:** Tim: "AutoCAD's own commands (Recommended)". Once the one-piece pipe is accepted, AutoCAD's TRIM,
   EXTEND, BREAK and JOIN work on CE pipes and CE keeps lengths, grades and labels right, one U; CDTRIM, CDEXTEND,
   CDBREAK and CDJOIN become hidden typed shortcuts.
3. **UX-DI-03:** Tim: "Until something changes (Recommended)". An ignored finding is ignored for the job with its
   reason and asked again only if the item or its rule changes; an "Ignored" list shows them all.
4. **UX-DI-04:** Tim: "Zoom + glow, window stays (Recommended)". Show where zooms and highlights in the attention
   colour; the list stays open; Escape clears the highlight.

## Level 3: Civil design proposals — 26 Sep 00:52 2026

Asked to tick up to three Civil proposal types for CE to learn first; Tim ticked **all four**: "Network layout",
"Levels for a drawn network", "Detention and tank layout", "Downpipe and source placement". (Ask CE: covered by the
approved July card AI-01, not re-asked.)

1. **UX-L3-01:** all four are wanted as V3 Level 3 proposals. Each: preview first, accept or adjust per item, one U;
   learned from past jobs and corrections (UX-LEARN-01); never silently changes an engineering rule; Unknown never
   guessed.
2. The build order is asked separately below.

**UX-L3-02, build order:** Tim: "Levels, sources, detention, layout (Recommended)". (1) Levels and grades for a drawn
network (building on Solve Run); (2) downpipe and source placement from the rating report and roof plan;
(3) detention and tank layout (after the approved calculations card); (4) full network layout last.

## Level 3 proposal 1: levels for a drawn network — 26 Sep 00:55 2026

Builds on Hold grade / hold levels (23 Sep) and Solve Run.

1. **UX-L3-03, start:** Tim: "Fit between both ends (Recommended)". Hold the outlet/LPD invert and minimum cover at the
   top pits; fit grades between; if impossible, say where and by how much.
2. **UX-L3-04, hand-typed levels:** Tim: "Keep them fixed (Recommended)". Treated as fixed controls; flagged if they
   make the network impossible.
3. **UX-L3-05, preview:** Tim: "Ghost labels + was/now list (Recommended)". Ghost invert labels on the plan plus a
   pit/was/now/why list; accept all or per pit; one U.
4. **UX-L3-06, no solution:** Tim: "Show shortfall + options (Recommended)". CE states the shortfall at the worst pit
   and offers flatter grades (if allowed), a charged system, a pump, or reduced cover with a reason; the user
   chooses; CE never forces one.

## Level 3 proposal 2: downpipes and sources — 26 Sep 00:58 2026

1. **UX-L3-07, positions:** Tim: "Architect's DPs, else roof (Recommended)". Use the architect's downpipe symbols
   where present; otherwise propose from roof edges and gutters, learned from past jobs; each confirmed.
2. **UX-L3-08, destination:** Tim: "Rating report, then nearest option shown (Recommended)". From the rating report's
   catchment names; where a name does not say, the destination is Unknown with the likely tank/pit suggested from
   past jobs for the user to pick; never guessed silently.
3. **UX-L3-09, numbering:** Tim, his own words: "all option available". All three orders are offered as a choice in
   the preview: the learned office pattern, clockwise from the front left, and the order placed; renumber with one
   click. Default pre-selection not ruled (this chat suggests the learned pattern).
4. **UX-L3-10, preview:** Tim: "Ghost DPs + lines to destination (Recommended)". Ghost DP symbols with a thin line to
   the tank/pit and the catchment area; accept all or per DP; one U.

## Level 3 proposal 3: detention and tank layout — 26 Sep 00:59 2026

1. **UX-L3-11, options:** Tim: "2-3 options side by side (Recommended)". Each option with storage, depth and council
   rules checked (e.g. % underground); the user picks one, then adjusts.
2. **UX-L3-12, location:** Tim: "Learned + clash-checked (Recommended)". Placed where past jobs usually put storage,
   clear of easements (including implied), tree zones, footings and services; each clash shown.
3. **UX-L3-13, complete system:** Tim: "Yes, complete system (Recommended)". The proposal includes the orifice pit with
   its sized plate (from the calculation), the overflow route and the OSD criteria block; one preview, one U.
4. **UX-L3-14, unapproved calculation:** Tim: "Yes, marked draft (Recommended)". Proposes from current figures with a
   "Draft: calculation not approved" banner in the preview and on the OSD block until approved.

## Level 3 proposal 4: full network layout — 26 Sep 01:01 2026

1. **UX-L3-15, missing inputs:** Tim: "Propose, show gaps (Recommended)". Proposes with what exists; missing inputs
   listed; those parts stay Unknown until supplied.
2. **UX-L3-16, routes:** Tim, his own words: **"learn from previous drawings"**. Pipe routes, pit positions and
   set-offs follow the patterns learned from CE's previous drawings (UX-LEARN-01), not a fixed "building lines" or
   "shortest path" rule; footings, tree zones and easements still avoided.
3. **UX-L3-17, alternatives:** Tim: **"Always 2-3 side by side"** (recommended "one + try another" not taken). Like
   the detention options.
4. **UX-L3-18, existing work:** Tim: "Build around it (Recommended)". Drawn pipes and pits are kept; only what is
   missing is proposed; any change to existing work is shown separately and applied only if ticked.

### UX-L3-19 — Visual proposals

**Tim, verbatim: "can ce plugin show visual proposals for detention and storage as well as the full design".**
Recorded as a requirement for every Level 3 proposal (detention/storage options and full network layout):
1. The chooser shows each option as a **picture of the plan** (a small drawing of that option on the real site,
   with its key figures), side by side.
2. Selecting an option shows it as a **full-size ghost in the real drawing** (pipes, pits, tank or storage, orifice
   pit, overflow, labels); switching options swaps the ghost; nothing is drawn until Accept; one U.
3. Differences between options are highlighted (e.g. "B uses 7 m less pipe, 0.3 m shallower").

**UX-L3-20, chooser sketch approved:** shown a sketch of the proposal chooser (three options side by side with plan
pictures and figures, the selected option as a full-size ghost in the drawing, Cancel / Accept), Tim: "Yes, that's it
(Recommended)". Reference sketch: `04_REFERENCE\ux-plan\PROPOSAL_CHOOSER_SKETCH_2026-09-26.svg` (synthetic figures).

### UX-L3-21 — Detention proposals learned from previous jobs (26 Sep 01:04)

**Tim, verbatim: "you need to learn proposals of detention from previous jobs and the best layouts".** Detention and
storage proposals are learned from CE's previous jobs (the drawing-intelligence evidence, local only), weighted
toward the best layouts. How "best" is judged is asked next.

**UX-L3-22, what makes a layout "best":** Tim ticked **"Council approved first time"**, **"Least pipe and depth"** and
**"Issued without later changes"**. Not ticked: "You or an engineer marks it". So "best" past detention layouts are
scored by: no council RFI on the drainage (council RFI reader, UX-RFI-01..03); meeting storage with the least pipe
length, excavation depth and number of pits; and not redrawn in later revisions (compared across issues). No manual
"good example" marking is required.

**UX-L3-23, detention options are combinations (Tim, verbatim): "might be one detention pipe between p1 and p2 and
then another between p2 and p3 or something like that and including pit detention".** A proposed detention option can
combine storage pipes on several pit-to-pit runs (e.g. P1-P2 and P2-P3, sizes may differ) with detention pit storage
(and tanks), totalled against the required storage; each option card lists every piece (run, size, length, volume)
and the pits counted as storage.

## Issue and submission, Civil and whole plugin — 26 Sep 01:07 2026

1. **UX-REG-09:** Tim: "Same workflow (Recommended)". Civil drawings use the Structural register, revision and issue
   workflow (UX-REG-01..08); a job with both disciplines shares one register.
2. **UX-REG-10:** Tim: "Yes, one pack (Recommended)". One click builds a dated council submission folder (drawing set
   PDF, computations sheet, rating report, LPD letter) named the way that council asks; reviewed before it is made;
   CE never sends it.
3. **UX-REG-11:** Tim: "Yes, from Settings (Recommended)". Issue applies the office plot style, page setup and pen
   settings (Settings values); a differently set-up sheet is flagged in the issue preview.
4. **UX-REG-12:** Tim: "Yes, in the issue folder (Recommended)". A locked read-only DWG snapshot goes into the dated
   issue folder beside the PDF; the "what changed since last issue" comparison uses it.
