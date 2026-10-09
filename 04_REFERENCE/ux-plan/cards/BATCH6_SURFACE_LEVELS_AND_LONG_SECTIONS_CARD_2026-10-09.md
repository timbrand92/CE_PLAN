**Code read on Civil rel-20261009l e636e17d** (Civil 3.0.43 / Manager 1.1.43, train C-30, 9 Oct 13:16; read with `git show` / `git grep`
on that commit, no checkout; never master). **Installed today:** Civil 3.0.41 (`660487d1`, read from the bundle DLL product version, Fri 9 Oct
about 16:08). Every file cited below is identical between 660487d1 and e636e17d except `Commands/PitCommand.cs` (+12 lines, not the survey part).

# Batch 6 card: surface levels and long sections (Civil), 9 Oct 2026

**Status: DRAFT. Not approved by Tim.** Under INT-073 (Tim, Fri 9 Oct about 05:50: "the builds should not be hung on me answering
questions"), extended by the desk at 08:05 to every batch card with recommended answers, builders MAY build this card on the
**Recommended** answers below, as DRAFT PRs, tests red first, every new behaviour behind a Settings value and OFF where it changes what a
drafter sees, nothing retired, no old command removed, locked layers / Xref / REFEDIT protection unchanged. Tim's answer by number in
`TIM_BATCH_QUESTIONS_8_9_2026-10-09.md` (questions 1 to 8) replaces a recommended default in a follow-up. **Engineering values are not
covered:** the minimum clearance to a crossing service is Tim's number (question 8); until he types it CE says "clearance not set, not
checked" and never invents one (R-00, RULES 12).
Written by design lane run 9 (headless, Opus), Fri 9 Oct 2026 about 16:20 Melbourne (PC clock). Read-only on plugin code. Code lines are
not proof of what installed Civil 3.0.41 does on screen.
**Numbering:** this is **Batch 6** in `REVIEW_BATCHES_2026-10-09.md`; the question file calls it "card 8".

**House rules from Tim's answers of 9 Oct (INT-074 to INT-078), apply to everything below:**
1. **No blue** in any window this card touches (gold, black, white / grey). A red mark on the DRAWING (card 6.8) is drawing output, not a
   window colour.
2. **Plain name and command name together during the transition**, e.g. ribbon "Long section (CDPROFILE)", behind the Settings switch
   "Show AutoCAD command names", default ON; the plain name stays the main name.
3. **Plain English:** no "TIN", "RL source", "modified z-score" or "entity" anywhere a drafter reads. "Survey surface", "survey spot
   level", "level", "from survey", "typed".
4. **Unknown stays Unknown;** no hard blocks except the two in R-27; new visible behaviour behind a Settings value, OFF.

**Items (8):** UX-RL-01, 02, 03, 04, 05, 06 (surface levels), UX-LSEC-01, 02 (long sections).
**Commands touched:** PIT / New Pit window, PITEDIT / Edit Pit window, CDSURVEY (and Manager's Survey Intake, CESURVEYREVIEW), CDSL (spot
level), CDSLAB, CDPROFILE (long section), the Checks palette (Batch 2), the CE panel health line; one new command for assumed levels.
**Why now:** every pit's cover level, every cover check and every long section rests on the surface level. Today the level can come from a
survey point 40 m away without saying so, one bad survey point stops the whole survey loading, and the long section reads the ground from a
second, hidden copy of the survey.

**Authority:** `decisions\2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` "Surface levels" 27 Sep 18:37-18:40 (UX-RL-01..06, lines 2227-2242),
"Long sections" 27 Sep 18:51 (UX-LSEC-01, 02, lines 2244-2250), UX-CPLAN-34 (outfall long section office layout, line 2223), UX-CPLAN-11
(existing services, line 1770), UX-SURV-01..04 (lines 887-895); `V3_UX_PLAN.md` lines 137-139; RULES R-00, R-27.
**Related (do not build twice):** UX-SURV-01 (fill the pit level from survey, marked "Survey") and UX-SURV-02 (compare a revised survey) are
in **Batch 12**: card 6.1 / 6.2 build the one level lookup and source tag both batches use, card 6.5 builds "fill in after a late survey",
Batch 12 adds the old-versus-new survey compare on top. UX-CPLAN-11 (services labelled on plan, clash check) is **Batch 7**: card 6.8 shares
its service-layer list. BUG-134 (one outlier used to block the survey; now kept as Unknown) is in the code. R00_CIVIL item 11 (the long
section works out pipe speed with its own roughness list) is filed in BUG_CARPARK and is NOT fixed here; card 6.7 only decides whether the
speed rows are on the section at all.
**New flag for the controller (not in the R-00 audit):** the long section's ground line uses its own hidden numbers: search rings 2.5 m,
5 m and 12 m and level windows 0.6 m, 0.9 m and 1.2 m around the DESIGN cover level (`ViewModels/LongitudinalSectionViewModel.cs:1568-1590`).
Not on Settings (R-00), and it filters the survey by the design levels it is meant to check.

**Who does what (INT-073: windows stay Codex's):**
1. **Claude (behaviour):** the one level lookup; the stored level source per pit; the assumed-levels command and its prompts; the
   late-survey fill engine and the re-check; suspect-point flagging and the intake change; the long section rows, title, scales and service
   marks (drawing output); every Settings value; tests.
2. **Codex (windows):** the source words beside the level in New Pit and Edit Pit; the "Levels from the new survey" list window; the
   Survey Intake window wording; the Checks palette rows for suspect points; the Settings page rows; every AutoCAD acceptance run.

---

## Card 6.1 — UX-RL-01: the surface level comes from the survey, interpolated; Unknown where the survey does not reach

1. **Tim ruled (27 Sep 18:37):** "Survey levels, interpolated". CE reads the survey spot levels (and contours if present) and interpolates
   at each pit or chainage; anywhere the survey does not cover shows Unknown, never a guess.
2. **Today:**
   - CDSURVEY reads the survey Xref (and, if the Xref is flat, the surveyor's raw 3D file) and stores the survey surface and spot levels
     in the drawing after an approval step (`Commands/CdSurveyCommand.cs:56-217`).
   - One lookup, `SurveyService.TryGetRlAtPoint` (`Services/SurveyService.cs:477-500`): inside the survey surface it interpolates exactly;
     **outside it takes the nearest spot level with no distance limit** ("No maximum radius - callers decide", lines 538-570). No caller
     sets a limit (PitCommand 127, PitEditCommand 1050, CdCommand.GradeSuggestion 422, SlabCommand 618, SpotLevelCommand 87,
     SmartifyPitTool 227). A pit 40 m from the last survey point is offered that point's level.
   - New Pit shows it only in Design mode (Settings Survey "workflowMode", `Models/UserSettings.cs:1472-1485`) as a grey line "Survey RL
     12.34 m AHD · TIN" or "· nearest spot (37.2 m)" with a **Use RL** button (`Dialogs/PitDialog.xaml:256-268`); the cover level is not
     filled until Use RL is clicked. Edit Pit shows the same line when the pit has no cover level.
   - CDSL shows "Existing level from the survey here: 12.345 m (TIN)" or "No survey level near this point." (`SpotLevelCommand.cs:80-93`,
     UX-SURV-03 already built).
   - Contours are not read.
   - **The long section reads the ground a second, separate way:** it scans every level-looking text inside any Xref
     (`LongitudinalSectionViewModel.cs:45, 1129-1153, 1230-1267`) and averages nearby ones with the hidden rings and level windows flagged
     above (`1517, 1568-1590`). It never uses the stored survey.
3. **What works:** the stored, approved survey; exact interpolation inside the surface; Unknown when there is no survey at all; CDSL's
   "existing, you type proposed".
4. **Wrong or missing:** no distance limit on the nearest spot level; "TIN" and "Survey RL" on screen; two code paths for one question
   (design rule 1); contours not read.
5. **Classification: MODIFY.**
6. **Proposed:**
   - **One lookup for everything** (pits, CDSL, CDSLAB, the grade suggestion, the long section ground line).
   - Inside the survey surface: interpolated, as today.
   - Outside it: interpolate between the survey spot levels that surround the point; if none surround it, use the nearest spot level
     **only within the Settings value "Use a survey spot level up to (m) away"** (question 1; recommended **3 m**); beyond that the level
     is **Unknown**, said plainly: "No survey level within 3 m of this point."
   - Contours: read later (not in this batch); say so in the card, not on screen.
   - The long section's ground line uses the same lookup behind the Settings switch "Long section ground from the stored survey" (default
     **OFF** = today's text scan). The old scan is not deleted until Tim passes the new one.
   - Words on screen: "Survey level 12.34 (from the survey surface)" / "(from a survey spot level 2.1 m away)". Button "Use this level".
7. **Prompts:** none new. **Esc / Undo:** looking up writes nothing.
8. **Example:** a pit 15 m beyond the last survey point: today the window offers that point's level; after, it says "No survey level within
   3 m of this point" and the cover level stays blank (Unknown).

## Card 6.2 — UX-RL-02: a small source tag in windows and on hover; the drawing looks the same

1. **Tim ruled (27 Sep 18:37):** "Yes, small source tag". Windows and hover say "from survey", "design" or "typed"; on the drawing they
   look the same.
2. **Today:** the source word exists only while New Pit or Edit Pit is open ("TIN" / "nearest spot (37.2 m)") and only for the suggestion.
   Once Use RL is clicked, or a level is typed, **nothing remembers where the level came from.** The Pit Schedule, the Inspector and
   CDINSPECTOR show the level with no source. `Services/PitSetupAdvisorService.cs:39-49` has "current" / "survey" words for its own
   advice only.
3. **Classification: MISSING** (the stored tag) / **MODIFY** (the wording of the suggestion line).
4. **Proposed:**
   - Each pit's surface (cover) level stores one source: **from survey**, **design**, **typed**, **assumed** (card 6.4), or **not
     recorded** (every pit drawn before this change; never guessed). Saved with the pit; travels with COPY and MIRROR like the level.
   - Use this level = "from survey" (with the date of the survey); typing over it = "typed"; a design level (card 6.3) = "design".
   - Shown: beside the level in New Pit and Edit Pit (small grey word), in the Pit Schedule window as a hover note on the level cell, in
     the Inspector / Civil Properties line, and on the hover tooltip over a pit. **Never on the plotted drawing, never in the plotted
     schedule** (Tim's ruling).
   - Behind the Settings switch "Show where each level came from" (default **OFF** until Codex passes the windows; the stored tag is
     written from day one so nothing is lost while it is off).
5. **Undo:** the tag changes with the level in the same U.
6. **Example:** P4 cover 12.34 "from survey (survey of 3 Oct)"; the drafter types 12.40: it now says "typed".

## Card 6.3 — UX-RL-03: design levels win where they are set

1. **Tim ruled (27 Sep 18:37):** "Design levels win where set". Pits in paved or finished areas use the design level (drafter or
   architect); elsewhere the survey level; the source tag says which.
2. **Today:** CE has two kinds of design level but the pit never reads them: CE slabs (CDSLAB, with finished levels and falls,
   `Services/SlabService.cs`) and proposed spot levels placed with CDSL (block "SPOT LEVEL", read only by the fall arrow and the slab
   tools: `FallSuggestCommand.cs:216`, `SlabCommand.cs:272`). New Pit offers only the survey level.
3. **Classification: MISSING.**
4. **Proposed (question 2):**
   - Where a pit sits inside a CE slab or paved area that has a design level, New Pit offers the **design level first**, tagged "design",
     with the survey level under it as "existing ground 12.21 (from survey)".
   - Elsewhere, a CE proposed spot level (CDSL) within the reach of card 6.1 counts as a design level.
   - Architect's levels are read only when the drafter points CE at them (later, Batch 19, other people's drawings); not in this batch.
   - Nothing changes a level already on a pit; this is the level OFFERED when a pit is placed or when Edit Pit has no level.
   - Behind the Settings switch "Offer design levels before survey levels" (default **OFF**).
5. **Undo:** offering writes nothing; Use this level is part of the pit's own U.
6. **Example:** a pit in a driveway slab with a finished level of 12.60 at that point and existing ground 12.21: New Pit offers 12.60
   "design" first.

## Card 6.4 — UX-RL-04: no survey yet, so CE asks for assumed levels and marks them Assumed

1. **Tim ruled (27 Sep 18:40):** "Ask for assumed levels". With no survey, CE asks for an assumed datum and fall; levels built from them are
   marked **Assumed** (never passed off as surveyed), shown with the "assumed" tag, and the health line says the job is on assumed levels.
2. **Today:** with no survey, New Pit shows no level line; the drafter types every level or leaves it Unknown. Nothing asks for an assumed
   level, nothing is marked assumed, the health line says nothing about it.
3. **Classification: MISSING.**
4. **Proposed:**
   - New command **CDASSUMEDLEVELS**, ribbon Survey > "Assumed levels (CDASSUMEDLEVELS)". Prompts:
     1. "Pick a point to give an assumed level:" (the drafter clicks, for example, the front boundary corner or the kerb).
     2. "Assumed level at this point, in m <100.00>:" (100.00 is the usual office assumed datum; the drafter types any value).
     3. "Fall across the site [Flat/Pick] <Flat>:"; Pick asks "Pick the high side:", "Pick the low side:", then "Fall from high to low,
        1 in <100>:" (the drafter's figure; CE suggests nothing beyond what is typed).
   - CE then offers levels from that plane exactly as it would from a survey, tagged **assumed**. The drawing stores the assumed datum,
     the point, the fall, who and when.
   - The CE panel health line reads "Levels: ASSUMED (no survey yet)" in the attention colour until a survey is approved (card 6.5).
   - **Offered, not forced:** the first time a pit is placed in a drawing with no survey and no assumed levels, one command-line line:
     "No survey yet. Type CDASSUMEDLEVELS to set assumed levels, or keep typing levels." Once per drawing, never a pop-up.
   - Plotted note (question 3): CE offers, unticked, the note "LEVELS ARE ASSUMED AND SUBJECT TO SURVEY" for the drawing notes.
   - Behind the Settings switch "Offer assumed levels when there is no survey" (default **OFF**; the command itself works when typed).
5. **Cancel / Esc / Undo:** Esc at any prompt: "Nothing was changed." Setting assumed levels is one U. Running it again replaces the plane
   and lists the pits whose assumed levels would change (they change only when the drafter accepts, as card 6.5).
6. **Example:** no survey on a new job; the drafter sets 100.00 at the front left corner, fall 1 in 80 to the back. P1 at the back is
   offered 99.71 "assumed"; the health line says the job is on assumed levels.

## Card 6.5 — UX-RL-05: the survey arrives later; CE fills in and shows what changed

1. **Tim ruled (27 Sep 18:40):** "Fill in and show changes". CE replaces the assumed / Unknown levels, reruns checks and lists anything
   that now fails, with fix suggestions.
2. **Today:** approving a survey stores it and says "When you place a pit (PIT command), the nearest ground RL will be suggested as the
   cover level." (`CdSurveyCommand.cs:217`). Pits already drawn keep their levels; nothing lists them; nothing re-checks.
3. **Classification: MISSING.**
4. **Proposed (question 4):**
   - Straight after a survey is approved (CDSURVEY or Manager's Survey Intake), CE opens one list, **"Levels from the new survey"**: one
     row per pit whose level would change: "P3 · assumed 99.71 → survey 99.88 (+0.17)".
   - **Ticked** by default: levels tagged assumed or not set (Unknown). **Unticked**: levels tagged typed or design (CE never overwrites
     a level a person typed without a tick). Not recorded (old pits): unticked, with the difference shown.
   - Apply = one U for all ticked rows. Cancel = nothing changed.
   - After Apply, CE re-checks those pits and their pipes (cover, grade, the council rules) and lists what now fails, each with its fix:
     "P3-P4: cover now 240 mm, under the 300 mm minimum. Edit pipe / Lower the invert / Ignore". These rows land in the Checks palette
     (Batch 2) under a "From the new survey" heading.
   - Assumed levels then switch off: the health line goes back to normal.
   - Batch 12 (UX-SURV-02) adds the old-survey-versus-new-survey compare on top of this same list.
5. **Esc / Undo:** closing the list = Cancel, nothing changed. One U undoes the whole Apply.
6. **Example:** the job above gets its survey on day 3: 9 pits listed, all ticked (assumed); after Apply, P3-P4 shows "cover now 240 mm".

## Card 6.6 — UX-RL-06: a suspect survey level is flagged and not used, not a reason to stop

1. **Tim ruled (27 Sep 18:40):** "Flag, don't use". A spot level far off its neighbours is flagged in checks and skipped for interpolation
   until the drafter confirms it.
2. **Today (two different behaviours):**
   - **Outliers across the whole site** (a statistical test against the site's middle level, `Services/SurveyIntakeSanityService.cs:54,
     238-270`) are stored, kept as Unknown and never used (BUG-134); they are listed in the intake review in words like "is a statistical
     outlier (median 12.410, modified z-score 4.1)". On a steep site a correct point at the top or bottom can be flagged; a wrong point in
     the middle of the range is not. There is no way to confirm one, and they are not in Checks.
   - **A spot level more than 100 mm off the survey surface, or two near-identical points that disagree by more than 10 mm, BLOCK THE WHOLE
     SURVEY:** "Intake blocked - suspect or conflicting evidence stays Unknown and cannot be activated. Nothing was stored; the previously
     stored survey is unchanged." (`CdSurveyCommand.cs:178-182`, `Services/SurveyIntakeApprovalPolicy.cs:17-20, 61`). One bad point stops
     the job's survey: a third hard block against R-27 and against "flag, don't use".
3. **What works:** suspect points are never used for a suggestion; the tolerances are already Settings values (CL6, 8 Oct:
   `spotVsSurfaceToleranceMm` 100, `duplicateDistanceMm` 50, `duplicateLevelToleranceMm` 10, `UserSettings.cs` survey section).
4. **Classification: MODIFY.**
5. **Proposed (questions 5 and 6):**
   - **"Far off its neighbours"** = a spot level that differs from the level its nearby survey points (and the survey surface) give at
     that spot by more than the Settings value "A survey spot level this far from its neighbours is suspect (mm)" (recommended start =
     today's 100 mm).
   - A suspect point is stored, flagged and **skipped**; the rest of the survey loads. The two conflict kinds above become suspect points,
     not a block.
   - Checks palette row: "Survey spot level 23.45 looks wrong: 0.62 m above its neighbours. Show where / Use it anyway / Keep skipping".
     Use it anyway is recorded with name and date (as an Ignore, Batch 2).
   - Intake review words: "3 survey spot levels look wrong and will not be used until you confirm them in Checks." No statistics words.
   - The whole-site outlier test stays as a second net, reworded.
   - Behind the Settings switch "Load the survey and skip suspect points" (default **OFF** = today's block; question 5 recommends Tim turns
     it ON as the default).
6. **Undo:** Use it anyway / Keep skipping are each one U.
7. **Example:** a survey with one spot typed 23.45 among neighbours at 22.80-22.85: today the whole survey is refused; after, it loads,
   that one point is skipped, and Checks lists it once.

## Card 6.7 — UX-LSEC-01: a long section on request, in the office layout

1. **Tim ruled (27 Sep 18:51):** "On request, same layout". Pick a run and CE draws its long section in the outfall section's office layout;
   not automatic for on-site runs. The office layout (UX-CPLAN-34, 27 Sep 18:28): H 1:100, V 1:50; rows DATUM LEVEL R.L., PIPE SIZE,
   PIPE GRADE, INVERT DEPTH, INVERT LEVEL, SURFACE LEVEL, CHAINAGE; pits as vertical-labelled bars; crossovers and services noted.
2. **Today:**
   - CDPROFILE (ribbon "Longitudinal Profile (CDPROFILE)") uses a selected pit or asks "Select starting CE pit for profile review:"
     (with live words under the cursor), then opens the profile review inside the Calculations window (`Commands/ProfileCommands.cs:39-66`).
     Codex (UI/UX review item 19) saw it open with Preview / Apply.
   - Insert draws a section block titled "LONGITUDINAL SECTION" (`Services/LongitudinalSectionService.cs:21`) with rows **PIPE SIZE, PIPE
     GRADE, Vf - PIPE VELOCITY FULL, Qf - PIPE FLOWING FULL, INVERT LEVEL, SURFACE LEVEL, CHAINAGE** (`1163-1172`) and a "DATUM RL" label
     (`1234`); scales start at 1:100 / 1:50 (window values, not Settings: R-00 audit item 65); pit bottoms drawn 0.30 m below the invert
     (`314`, audit item 64); branch junction marks (CD-BRANCH-01); boundary marks; the ground line (card 6.1). Re-running updates the same
     section (UX-PROFILE-05) and refuses when the target changed.
   - Never automatic on site runs (correct); auto-design only produces rows for the window (`AutoDesignOrchestrator.cs:216`).
3. **What works:** on request; picks a run from a pit; the update-in-place and its refusal; junction and boundary marks; H 1:100 / V 1:50.
4. **Wrong or missing against the office layout:** the two speed rows (Vf, Qf) are not office rows (and the speed uses its own roughness
   list, R00 item 11, filed); **INVERT DEPTH** row missing; "DATUM LEVEL R.L." is a label, not the first row; one generic title; scales and
   rows not on Settings.
5. **Classification: MODIFY.**
6. **Proposed (question 7):**
   - Ribbon "Long section (CDPROFILE)". Prompts unchanged; one added: after the start pit, "Pick the end pit, or Enter to run to the
     outfall:".
   - Settings list **"Long section rows"**, seeded with the office layout in order: DATUM LEVEL R.L., PIPE SIZE, PIPE GRADE, INVERT DEPTH,
     INVERT LEVEL, SURFACE LEVEL, CHAINAGE. The two speed rows stay available, unticked.
   - Title from the run: "LONGITUDINAL SECTION P1 - P6"; an off-property outfall run is titled "OUTFALL DRAIN LONGITUDINAL SECTION"
     (UX-CPLAN-34).
   - Scales (1:100 / 1:50) and the pit bottom depth move to Settings with today's numbers.
   - INVERT DEPTH = surface level minus invert level at each pit; Unknown if either is Unknown ("UNKNOWN" in the cell, never 0).
   - Behind the Settings switch "Long sections in the office layout" (default **OFF** = today's rows, byte for byte).
7. **Cancel / Esc / Undo:** Esc at either pick: "Nothing was drawn." Insert or update = one U. Locked layer: refused with the layer named.
8. **Example:** P1 to the outfall: the section shows the seven office rows, INVERT DEPTH 0.62 / 0.85 / 1.10, title "LONGITUDINAL SECTION
   P1 - P6", no speed rows.

## Card 6.8 — UX-LSEC-02: services crossing the run are marked on the section, with their clearance

1. **Tim ruled (27 Sep 18:51):** "Shown with clearance". Survey services crossing the run are marked on the section with their clearance,
   red if under the Settings minimum (with UX-CPLAN-11).
2. **Today:** **CE does not read survey services at all.** No sewer, water, gas, electricity or telecommunications line is recognised; the
   only service-like reading is an easement note's width (`Models/XrefSiteGeometryModels.cs:53`). No clearance value on Settings.
3. **Classification: MISSING** (needs the service-layer list that Batch 7's UX-CPLAN-11 also needs: build once).
4. **Proposed:**
   - Settings list **"Survey service layers"**: layer-name words and what they are, seeded with SEWER, WATER, GAS, ELEC, TELSTRA, NBN,
     COMMS, STORMWATER, with their office labels (EX. SEWER DRAIN, EX. WATER MAIN ...). The drafter adds the surveyor's own names.
   - When a long section is drawn, CE finds every service line on those layers that crosses the run on plan and marks it on the section at
     its chainage: a small circle at its level with "EX. SEWER IL 99.80" and "clearance 0.35 m".
   - The level comes only from the survey (an IL or depth note at or near the crossing). No level: "EX. WATER, level unknown, clearance not
     checked". Never a guessed depth.
   - **Clearance minimum = Tim's number** (question 8): Settings "Minimum clearance to a crossing service (mm)", blank. While blank: every
     mark says "clearance not set, not checked". Under the minimum: the mark and its words drawn red, and a Checks row "P3-P4 crosses the
     EX. SEWER at ch 12.4 with 0.12 m clearance, under the 150 mm minimum. Show where".
   - Behind the Settings switch "Show crossing services on long sections" (default **OFF**).
5. **Undo:** marks are part of the section's one U.
6. **Example:** a sewer with "IL 99.80" noted crosses P2-P3: the section shows it at ch 12.4 with "clearance 0.35 m"; with no minimum
   typed it adds "clearance not set, not checked".

---

## Recommended answers a builder may use now (INT-073)

1. Nearest survey spot level used only within **3 m**; beyond that the level is Unknown and says so.
2. Design levels = CE slabs and CE proposed spot levels (CDSL); architect's levels later.
3. Assumed levels: the plotted note is offered **unticked**.
4. Late survey: assumed and Unknown levels ticked; typed, design and not-recorded levels unticked; one U; re-check lands in Checks.
5. One bad survey point no longer stops the survey: load it, skip and flag that point (switch ON recommended as the default after Codex).
6. Suspect = more than **100 mm** from its neighbours (today's figure).
7. Long section rows = the office layout with INVERT DEPTH; speed rows available, unticked.
8. Crossing-service clearance: **no default; Tim's number**; "clearance not set, not checked" until typed.

## Tests (automated, before Codex)

1. Lookup: a point inside the survey surface gives the interpolated level; a point surrounded by spot levels interpolates; a point 2 m from
   the nearest spot uses it; a point 10 m away is Unknown with the plain line. Every caller (pit, CDSL, slab, grade suggestion) gets the
   same answer for the same point.
2. Long section ground: switch OFF gives today's samples byte for byte; switch ON gives samples from the stored survey only; no text scan
   runs.
3. Source tag: Use this level stores "from survey" with the survey date; typing over stores "typed"; COPY keeps it; U restores the old tag;
   an old pit reads "not recorded"; the plotted schedule text has no source words.
4. Design level: a pit inside a slab is offered the slab level first, tagged design; switch OFF = today.
5. CDASSUMEDLEVELS: Esc at each prompt changes nothing; datum 100.00 and 1 in 80 give the expected level at a test point; levels tagged
   assumed; health line says ASSUMED; one U removes it.
6. Late survey: 3 assumed, 1 typed, 1 Unknown pits: list has 5 rows, 4 ticked (not the typed one); Apply is one U; a cover failure appears
   in Checks under "From the new survey".
7. Suspect point: switch ON: survey with one point 0.62 m off loads, that point is skipped and listed; switch OFF: today's block message.
8. Long section office layout: rows in the Settings order, INVERT DEPTH = surface minus invert, UNKNOWN when either is unknown; switch OFF
   = today's block byte for byte; Esc at the end-pit prompt draws nothing.
9. Services: a sewer line on a "SEWER" layer crossing the run with "IL 99.80" is marked at the right chainage; with no minimum the words say
   "not checked"; with a 150 mm minimum and 120 mm clearance the mark is red and Checks lists it; a service with no level is never given one.
10. Wording guard: no "TIN", "RL", "z-score" or "entity" in any new prompt or window text.

## Example drawings

1. Synthetic only (no client job): a copy of `C:\Lisp Files\_TEST_COPIES_20260923\DWG-B.dwg` (Codex's usual Civil copy) with a test survey
   Xref made for this card: a 3D-face surface over the front half of the site, spot levels over the back half, one spot typed 0.62 m wrong,
   one sewer line on a layer named "SEWER" with an "IL 99.80" note, crossing the P2-P3 run.
2. A second copy with no survey at all (for card 6.4 and 6.5), then the test survey attached on "day 3".
3. For the long section only, the job W26-26 copy Codex already uses (job number only): P1 to its outfall.

## Tim's AutoCAD checklist (about 10 minutes, on a copy; Codex first)

1. **Far from the survey:** place a pit 15 m past the last survey point. **Should see:** "No survey level within 3 m of this point", cover
   level blank. Near a survey point: "Survey level 12.34 (from a survey spot level 2.1 m away)" and "Use this level".
2. **Source tag:** click Use this level, then hover the pit. **Should see:** "from survey". Type over it in Edit Pit: "typed". Plot preview
   of the schedule: no source words.
3. **Design level:** place a pit inside a driveway slab. **Should see:** the slab level offered first as "design", existing ground under it.
4. **No survey:** on the no-survey copy, Survey > Assumed levels: 100.00 at the front corner, fall 1 in 80. **Should see:** pits offered
   "assumed" levels; the CE panel says the job is on ASSUMED levels.
5. **Survey arrives:** attach the test survey with CDSURVEY and approve. **Should see:** "Levels from the new survey" with the assumed pits
   ticked; Apply; any pit now short of cover appears in Checks with a fix. U undoes the lot.
6. **Bad point:** CDSURVEY on the survey with the wrong spot (switch ON). **Should see:** the survey loads; Checks lists one suspect point
   with Show where / Use it anyway / Keep skipping.
7. **Long section:** Long section from P1, Enter to run to the outfall (switch ON). **Should see:** your office rows with INVERT DEPTH, no
   speed rows, title "LONGITUDINAL SECTION P1 - ..."; the sewer marked where it crosses, "clearance not set, not checked" until you type
   your minimum in Settings, then red if it is too close.

## Code references (Civil release commit e636e17d)

Under `Modules\Drainage\`: `Services/SurveyService.cs:20-26, 477-500, 503-536, 538-570`; `Commands/CdSurveyCommand.cs:56, 70-217`;
`Services/SurveyIntakeApprovalPolicy.cs:17-29, 61, 75-77`; `Services/SurveyIntakeSanityService.cs:19-23, 54, 108, 238-270`;
`Services/SurveyOutlierMarkingPolicy.cs:15-29`; `Commands/PitCommand.cs:118-133`; `Commands/PitEditCommand.cs:1044-1056`;
`Dialogs/PitDialog.xaml:256-268`; `Dialogs/PitEditWorkshopDialog.xaml:196-201`; `ViewModels/PitViewModel.cs:234, 512-529`;
`Models/UserSettings.cs:1472-1520` (workflow mode, CL6 survey tolerances); `Commands/SpotLevelCommand.cs:25, 58-93`;
`Services/PitSetupAdvisorService.cs:39-49, 185-208`; `Commands/FallSuggestCommand.cs:216`; `Commands/SlabCommand.cs:272, 618`;
`Commands/ProfileCommands.cs:39-66`; `Services/LongitudinalSectionService.cs:15-35, 288-314, 1155-1172, 1234, 1674, 2182-2189`;
`ViewModels/LongitudinalSectionViewModel.cs:45, 65-66, 1079-1153, 1230-1267, 1517, 1568-1590`; `Services/AutoDesignOrchestrator.cs:216`;
`Models/XrefSiteGeometryModels.cs:53`; `Assets/Config/command-registry.json:229-230`.
Not found on that commit: a distance limit on the nearest spot level, a stored level source on a pit, any assumed-level datum, any
survey-later fill or re-check, a per-point suspect check against neighbours, an INVERT DEPTH row, any recognition of survey services or a
service clearance value.
Codex: `CODEX_CIVIL_UIUX_REVIEW.md` item 19 (CDPROFILE opens the review); `CODEX_TEST_REPORT_PASS10_2026-09-24.md` N12 (CDPROFILE not
tested, BLOCKED); `CODEX_SWEEPC1_2026-09-30.md` items 45, 60 (CDPROFILE, CDSURVEY NOT TESTED); `CODEX_VERIFYW10_2026-10-05.md` W10-01
(Survey Intake opens). R-00 audit: `areas\release-v3-colleagues-R00_CIVIL_2026-10-09.md` items 11, 64-67.
