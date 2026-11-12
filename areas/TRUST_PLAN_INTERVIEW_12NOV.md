# Trust plan interview with Tim (started Thu 12 Nov 2026)

**What this is:** the running record of the interview that fills the gaps in the trust plan (`areas\V3_TRUST_PLAN_06NOV.md`). Chat: CE_ACAD / trust plan / plan / 01.

**Rules for this file:**
1. Tim's exact words go in quotes with the date. A reading of his words is marked INTERPRETATION.
2. A question with no answer stays OPEN. It is never turned into a decision.
3. Each answer also gets one line in `areas\release-v3-colleagues-DESK_LOG.md`.
4. Questions already answered in CE_PLAN are not asked again; the document checked is named.

Tim, 12 Nov 2026: "send questions in chat" and "interview me properly and create / modify the plan to make it watertight".

INTERPRETATION of "properly": ask the questions that decide whether the plan works first (the finish line, old drawings, who is affected), and the button-placement questions last. One question at a time, in the chat text.

---

## The interview map (biggest consequences first)

**A. The finish line (what "works" means)**
1. A1. When is the first colleague release ready? ANSWERED 12 Nov, see Answers.
2. A2. What kind of fault stops a release, and what kind waits? ANSWERED 12 Nov, see Answers.
3. A3. Which colleagues are first, and which AutoCAD year is each on? (2022 to 2024 gets no ribbon today.) ANSWERED 12 Nov: 2027. Which colleague is still OPEN.
4. A4. How much of Tim's own drafting time each step may use (about 3 working days on real jobs per step, or steps grouped). ANSWERED 12 Nov, see Answers.

**B. Old and revised drawings (the reader and the test set)**
1. B1. Which kinds of old drawing exist in the office (old LISP work, early plugin, current), and roughly how many of each come back as revisions. ANSWERED 12 Nov, see Answers.
2. B2. The 10 test jobs: which ones, and how messy the messiest should be. OPEN. (Tim picks at his PC; no client name or address goes in any file.)
3. B3. How many Unknowns on a job are acceptable before the reader has failed that job. OPEN.
4. B4. The start point: is the LPD the one stored start point, and what happens on a job with two. Voice talk 6 Nov agreed "CE proposes, Tim confirms once, stored in the drawing, more than one LPD handled"; ANSWERED 12 Nov: the LPD itself. Two-LPD jobs still OPEN.
5. B5. What CE may still change by itself when a drawing opens (pipes converted, pit symbols updated). Two earlier answers pull in different directions: 16 Sep "IT NEEDS TO BE IMPLEMENTED EVERYTIME YOU OPEN AN EXISTING JOB" and 4 Nov "ASK USER WHEN OPENS". ANSWERED 12 Nov: nothing changes on open; both superseded.

**C. Check this drawing**
1. C1. Do CDSYNC and CDREBUILD stay as direct typed commands once the one door exists (25 Sep ruling UX-REP-01)? OPEN.
2. C2. What happens when a drafter uses an ordinary tool on a drawing that still "needs checking". OPEN.
3. C3. What Apply may change in one go, and what always stays a separate careful command. OPEN.

**D. Same settings for everyone**
1. D1. Colleagues get Tim's exact setup: ANSWERED earlier (memory note colleagues-get-tims-exact-setup); not asked again. What is OPEN is whether an existing colleague's own settings are replaced at each release.
2. D2. Which finished-but-switched-off features come on in the core. OPEN.
3. D3. Remembered last-used values (pipe size, levels) carrying from one job to the next. OPEN.

**E. Releases to colleagues**
1. E1. Who looks after each release. OPEN.
2. E2. How a colleague reports a problem, and who reads it. OPEN.
3. E3. How a colleague goes back to the previous version. OPEN.
4. E4. How often, and what one release may contain. OPEN.

**F. The core ribbon (Civil sort questions 3 to 11)**
1. F3. New Job at the left end of CE Drainage. OPEN (asked 12 Nov, not answered).
2. F4 to F11. Spot levels, long section, downpipe destinations, CDRENUMBER and CDEDIT, Structural tab, preset pit sizes, CDCHECKDWG, PITDELETE and CDBREAK. OPEN.
3. F12. Which tools count as "CE tools useful in all drawings" (Tim, 7 Nov). OPEN.

**G. Structural and Manager**
1. G1. Structural marks on `areas\CORE_TICK_LIST_05NOV.md`. OPEN.
2. G2. Manager marks on the same list. OPEN.

**H. Standing rules this plan pauses or replaces**
1. H1. Rule 15 (AutoCAD never idle), the 17 Oct "switches ON once Codex passes" ruling, and percentages in every message: paused, replaced or kept. OPEN. They stay in force until Tim says.

---

**I. Decisions inside the draft cards (added 12 Nov, all OPEN)**
1. Each card in `04_REFERENCE\ux-plan\cards\TRUST-02` to `TRUST-08` ends with its own "Decisions for Tim". Where one repeats a question above, the letter is given on the card. The ones with no letter above:
   1. TRUST-04: one small safety build or several; is the Excel export fault a blocker for the first colleague release; reminder minutes.
   2. TRUST-05: should CDRECOVERINVERTS stop running the hidden update first.
   3. TRUST-06: each fill-in (size, material, lid, pit type, pit number, flow direction, pit invert from the lowest pipe); how Unknown looks on the plan; lines on a pipe layer with no CE data.
   4. TRUST-07: is the start point the LPD or the last pit before it; should the marker print.
   5. TRUST-08: warn and allow when the drawing has unsaved changes before Apply.
2. Reader design: where old block files or LISP tools are kept, if anywhere.

**J. Questions raised by the independent review (12 Nov, all OPEN; recommendation first)**
1. J1. On an old job, can proposed pipe sizes be ticked all at once? Recommended: tick-all for links only; sizes, levels and numbers one by one.
2. J2. Do the right answers for test jobs come from the plan labels or a marked-up print, not the old Pit Schedule? Recommended yes.
3. J3. When the core reaches colleagues, does the whole office move on the same day? Recommended yes, because an older version re-guesses drawings the core has touched.
4. J4. The steps add up to about ten three-day trials. Keep Tim's own trials for steps 4, 6 and 8 only, with the robot and Codex accepting the rest? Recommended yes.
5. J5. If a colleague types CDSYNC or CDREBUILD, does CE print one line pointing to Check this drawing and then carry on? Recommended yes.
6. J6. When a drawing has no units set, does CE ask once whether it is millimetres or metres and remember it in the drawing? Recommended yes.
7. J7. Are Tim's switched-on trial features left out of the office setup? Recommended yes.
8. J8. With no LPD drawn, does CE ask for the LPD point to be picked, rather than offer the lowest pit? Recommended yes.
9. J9. If Esc is pressed at the LPD question, is the Pit Schedule still made in today's order with a warning line? Recommended yes.
10. J10. Do colleagues keep their current Structural version in the first release? Recommended yes.
11. J11. Does Tim approve the five trust rules as the gate, with any exception named and signed by him? Recommended yes.

---

## Answers

Tim, 12 Nov 2026: "send questions using claude question interface". From here the questions are asked through the tick-box question interface. What is recorded below is the option Tim chose, word for word as it was shown to him; these are his selections, not sentences he typed.

### A1 to A4, answered Thu 12 Nov 2026 (late evening, PC clock)

1. **A1, when is the first colleague release ready?** Tim chose: "Zero wrong, all 10 (Recommended)". The option read: "Every one of the 10 test jobs has no wrong value shown as fact. Unknowns are allowed where the drawing lacks the information. Plus your three clean working days on real jobs."
2. **A2, which faults take a step or a release back off the same day?** Tim chose all four: "Lost work", "AutoCAD crash", "Wrong value shown as fact", "Changed without telling". The fourth read: "CE altered the drawing or its record and printed nothing, even if the result was correct."
   - INTERPRETATION: the fourth applies from the point a step has promised it. Until step 5 is in, everyday tools still update the record quietly by design, so that alone does not take step 1 to 4 off. For Tim to correct.
3. **A3, which AutoCAD year is the first colleague on?** Tim chose: "2027".
   - INTERPRETATION: the first colleague release is proven on 2027. The 2022 to 2024 pull-down menu work in card TRUST-02 is not needed for the first release, but those users stay in scope later (15 Sep ruling), so each step still records what it does on those years. Which colleague, and that their PC really is 2027, has not been read from the PC.
### B1, B4, B5 and the old tools, answered Thu 12 Nov 2026 (late evening, PC clock)

1. **B1, which kinds of old drawing come back as revisions?** Tim chose three of four: "Old LISP-era jobs", "Early plugin jobs", "Hand-drawn, no CE tools". He did not choose "Mixed AutoCAD years".
   - INTERPRETATION: the reader and the test set must cover those three kinds. Mixed-year jobs are not something he sees as revisions, so they are not a required test job; one real job on 4 Nov did show a mix (46 pipes, 6 converted), so the reader still has to read both pipe forms.
2. **B4, what is the start point of a network?** Tim chose: "The LPD itself (Recommended)". The option read: "The start point is the legal point of discharge. Pit numbers count up from the first pit upstream of it. One stored thing, matching what council calls the outlet."
3. **B5, what happens when a drawing opens?** Tim chose: "Nothing changes on open (Recommended)". The option read: "Opening only reads. The pipe conversion and symbol update become rows in Check this drawing, which you tick and apply. One U undoes it."
   - This SUPERSEDES, for the core, his 16 Sep answer ("IT NEEDS TO BE IMPLEMENTED EVERYTIME YOU OPEN AN EXISTING JOB"; 29 Oct "defualt on for everyone") and his 4 Nov answer ("ASK USER WHEN OPENS"). Both stay on record, marked superseded 12 Nov 2026.
   - INTERPRETATION: until Check this drawing can do the conversion (step 8, slice D), today's behaviour on opening is unchanged; nothing is switched off by this answer alone. For Tim to correct.
4. **Old LISP tools and old block files, where are they?** Tim typed: "on my work pc".
   - INTERPRETATION: this PC. The first search looked in only two places; a wider read-only search of this PC is the next job. Which folder is still not known.

### Tim's instruction, same evening

"can you work autonomously until tomorrow midday on anything you think is worthwhile"

INTERPRETATION: carry on with reading and planning work without waiting for answers. It does not lift the HOLD: no builds, tests, installs, AutoCAD or colleague releases, and no code changes. Questions are queued for him rather than asked while he is away.

4. **A4, how is Tim's trial time used?** Tim chose: "Group the safe ones (Recommended)". The option read: "Steps 1, 2 and 3 change nothing in a drawing, so they share one 3-day trial. Steps 4 to 8 each get their own. About 6 trials instead of 8."
