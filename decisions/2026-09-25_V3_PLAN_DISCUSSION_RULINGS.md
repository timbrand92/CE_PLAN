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
