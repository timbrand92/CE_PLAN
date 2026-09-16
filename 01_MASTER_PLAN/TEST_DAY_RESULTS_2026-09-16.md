# Test Day, 16 September 2026 — Tim's results on `c1af9781`

**This is the authoritative record of what Tim found. Read it before touching Civil code.** It replaces any
optimistic claim in `DEPLOY_AND_TEST_2026-09-16.md`. The deploy worked; **most of what it carried does not.**

Tim, at the end of the session:

> *"IM NOT TESTING THE REST YOU HAVE MADE FAR TOO MANY MISTAKES, I NEED TO GO ONE AREA AT A TIME YOU CANT BE
> TRUSTED TO BUILD MORE THAN THAT, FOCUS ON THE AUTOCAD SIDE FOR NOW WITH CDWT, CD, PIT COMMANDS AS HIGHEST
> PRIOROTIES, SECTIONS H,I,J,K,L ARE MOST IMPORTANT THEN M, SO MAKE SURE THE PLAN KNOWS EXACTLY WHAT HAS
> HAPPENED AND DOESNT FORGET IF I MOVE CHAT"*

---

## 0. The new way of working — binding from now on

1. **ONE AREA AT A TIME.** No more multi-item batches. Tim has withdrawn trust in large payloads and he is
   right to.
2. **Order of priority: `CDWT`, `CD`, `PIT`** — the AutoCAD side. Then test sections **H, I, J, K, L**, then
   **M**.
3. **Nothing is "done" until Tim has seen it in AutoCAD.** A passing unit test is not evidence about a
   drawing, a window or a PDF.
4. **Look at the actual artefact.** See §4 — a whole document was built, unit-tested green, and shipped
   unreadable because nobody opened the PDF.

---

## 1. What actually passed

| Step | Result |
|---|---|
| 1 | Version check — About CE Suite shows Civil `v3.0.0`, commit `c1af9781`. Deploy verified. |
| 2 | Plugin loads, CE ribbon appears — **but see R-01, icons are misplaced.** |
| 3 | `CDRAINFALL` exists and its opening message reads correctly, with the right intensities (5 min 105 mm/hr). |
| 57 | `CDC7UPGRADE` converted 51 pipes in place, 0 refused, backup taken. **The conversion itself worked.** |
| 58 (part) | Converted pipes "look and work right" — but see C7-01. |

**Everything else either failed, could not be reached, or Tim declined to test.**

---

## 2. Blocking faults, by area

### R — Ribbon

- **R-01. Ribbon icons render in the wrong place.** Tim: *"RIBBBON IMAGES/ICONS ARENT RENDERING IN THE CORRECT
  PLACE"*. See his image 2.
- **R-02. Toolbar icons must be updated to match**, so a user who prefers the toolbar gets the same icons.

### W — `CDWT` (water tank) — **TIM'S TOP PRIORITY, and a repeated ask he says has been ignored**

- **W-01.** The tank window with the visuals **no longer appears until after he has already chosen through the
  command line.** Tim: *"CDWT NO LONGER HAS MY WINDOW WITH ALL THE VISUALS ON IT ANYMORE UNTIL AFTER IVE
  ALREADY SELECTED THROUGH COMMAND LINE"*.
- **W-02.** No list of tanks **in order of size**.
- **W-03.** **Dimensions are not shown.**
- **W-04.** **It never asks what type of tank.**
- **W-05.** Tim: *"I ASKED FOR THIS NUMOUROUS TIMES AND YOU JUST BREEZE PAST IT"* — the order of asking makes
  no sense. The command works *after* everything, but the way data is gathered and the tank chosen
  *"DOESNT FOLLOW ANY LOGIC"*.

### P — `CD` (pipe), pits, levels

- **P-01. Split-on-draw asks at the wrong time** — only after the CD window, and *"the question and answer are
  messed up"*.
- **P-02. Invert levels land in the wrong place** after a split. See his image.
- **P-03. `CDPIPEOBJ`-style pipe is lost** — a split pipe does not come back as the new pipe object.
- **P-04. The command cannot handle a pipe with more than one vertex.**
- **P-05. Each pipe segment between pits needs its own pipe text.** Currently it does not get one.
- **P-06.** Tim: *"NEED TO BETTER UNDERSTAND HOW THE PLUGIN FINDS PITS AND THE OUTLINE AND HOW INVERT TEXT
  SHOULD BE PLACED IN RELATION TO THAT"* — this is a request for the underlying model to be understood and
  written down before more code is written.
- **P-07. Changing an invert does nothing**, and double-clicking the invert again **will not let him edit it**.
  Tim: *"what a joke"*.
- **P-08. Pit label on resize is still wrong**, and **it does not move the connections of existing pipes**.

### C7 — the one-object pipe

- **C7-01. Converted pipes are no longer connected/compounding** with pipe text, invert text or arrows.
- **C7-02. Newly drawn pipes do not use the new pipe style.**
- **C7-03. `CDFW` does not work on a converted pipe.** (Test step 60.)

### L — `CDLPD`

- **L-01.** The connection list **has no "Council Pit"** option.
- **L-02.** The note **is not the one CE actually uses**, and it **should be placed with an MLeader like the
  pipe command's callout**, not as it is now.
- **L-03.** It **still shows the invert level** when the invert is not set — the opposite of what was claimed.
  Check the logs.

### T — `CDFIXTAGS`

- **T-01. It contradicts itself.** It lists 3 repeated `AGI` tags, proposes 3 renames, is answered **Yes**, and
  then prints *both* "Every source name in this drawing already names one block. Nothing to repair." **and**
  "3 rename(s) were not made". Only **one** tag actually changed.

### D — `CDDEST`

- **D-01. "No downpipes were found in this drawing"** on a drawing that plainly has downpipes (his image 7
  shows `DP` labels throughout). Tim: *"I KNOW ITS AN OLD DRAWING BUT IT SHOULD UNDERSTAND CONTEXT BY NOW"*.

### G — `CDDESIGN` and the rating report

- **G-01. The question is malformed** — see his image 4.
- **G-02. It only looks in one folder.** Tim: *"THE CORRECT FILES ARENT ALWAYS IN THE SAME FOLDER, THEY SHOULD
  BE BUT ARENT. I NEED YOU TO LOOK THROUGH EVERY FOLDER IN THE JOB."*
- **G-03. It must be a WPF window, not the command line.** Tim: *"THIS SHOULD ALL BE DONE IN A WPF WINDOW NOT
  IN COMMAND LINE AND IT NEEDS TO BE DONE FAR BETTER WOW. NOT CLEAN AT ALL"*. **Codex is building that
  window** — the behaviour side must publish a contract, not build it.
- **G-04. It stumbles on the council and then stops being useful.** Tim: *"I WILL ONLY TEST WHEN YOUR PROGRAM
  CAN FIND AND INPUT DATA WITHOUT ME, CURRENTLY IT STUMBLES ON COUNCIL, IF IT DOESNT KNOW HOW HARD IS IT FOR
  IT TO SEARCH ADDRESS FROM FOLDER OR FIND A DOCUMENT IN THE FOLDER"*. **He will not test steps 42–47 until
  this is fixed.**

### TWL — `CDTWL`

- **TWL-03. The offered levels do not include the designed one.** The drawing's ON SITE DETENTION CRITERIA
  block says **TWL 18.54 m**; CDTWL offered only **18.75** and **18.05**. Tim: *"HOW CAN IT BE?"* — a fair
  question with no answer yet.
- **TWL-04.** It refuses a typed level (`18.54`) and demands "1 or 2 only", so the engineer **cannot enter the
  level the job was actually designed to**.
- **TWL-05. CDCALC stores the required volume as the string `"0.0"`**, so CDTWL cannot offer it and makes him
  retype 25.06 by hand.
- **TWL-06. Almost the whole system is dropped from the calculation** — 8 pits and 18 pipes excluded for
  "invert level is not set" or "its length cannot be worked out from where its pits sit", on a real drawing
  that clearly has levels. The storage total is therefore wrong (17,948 L against a required 25,060 L).
- **TWL-07.** Tim asks: *"WILL THIS WHOLE COMMAND BE IN A WINDOW AT SOME POINT?"* — **needs an answer.**

### F1 — the computations sheet

- **F1-01. The whole sheet renders as a list of lines prefixed `Note:`.** The V3 sheet's text was put into the
  export section's *Notes* collection, and the PDF writer renders every note as `Note: <text>`. So the
  CREATIVE ENGINEERING header, the basis of design, every figure — all of it reads as notes.
- **F1-02. Page 1 is still the old "CALCULATIONS PACKAGE" cover**, with every field blank. That is the first
  page a council sees.
- **F1-03. No CE branding.** "CREATIVE ENGINEERING" is just another `Note:` line, not a letterhead.
- **F1-04. The layout is out of order** — the narrative is page 2, the volume tables are page 3, and the old
  detention section repeats the same figures again on page 4.
- **F1-05.** Tim: *"THE REPORT IS MESSY, NOT FORMATTED IN ORDER, DOESNT HAVE CE BRANDING AND HONESTLY A MASSIVE
  DISAPPOINTMENT, NOT ACCEPTABLE"*.

---

## 3. What could not be tested, and why

- **Steps 5–20 (`CDRAINFALL` beyond the opening message) — blocked entirely by my mistake.** The five sample
  coefficient files were sent as chat attachments and **never written to a findable folder**, so when the file
  dialog opened Tim had nothing to point it at. Tim: *"IDK WHERE THAT FILE IS YOURE TALKING ABOUT"*.
  **Fix: put them on disk and give him the path.**
- **Steps 39–41, 42–47** — declined pending G-04.
- **Steps 53–56** — declined pending P-01..P-06.
- **Steps 66, 67** — Tim: *"IDK HOW TO CHECK, SEE WHAT I MEAN ABOUT ZERO LOGIC, UNLESS YOU DESIGNED THE THING
  YOUD HAVE NO CLUE WHERE TO GO OR WHAT TO DO"*. **The steps were written by someone who already knew the
  answer. That is a fault in the test list, not in Tim.**
- **Steps 68–71 (AutoCAD 2024)** — declined: *"NOT TESTING 2024 AT THIS TIME, FAR TOO MANY ISSUES"*.

---

## 4. What I got wrong, as process — so it is not repeated

1. **I tested the model and never the deliverable.** `ComputationsSheetV3Tests` (27 green) asserts on
   `ToPlainText`. The PDF was never opened. The tests passed while the real output was unusable. **A test that
   cannot fail the way the user experiences the thing is not coverage.**
2. **I shipped a batch far bigger than could be trusted**, against Tim's repeatedly stated preference, and
   then wrote a 77-step list that assumed it all worked.
3. **I wrote test steps that only make sense to the author.** Several steps had no way for Tim to know what
   "right" looked like.
4. **I delivered files through chat only**, with no path on disk, and blocked 16 test steps doing it.
5. **W-01..W-05 are repeats.** Tim says he has asked for the tank window behaviour *numerous* times. Whatever
   the history, the record now says it plainly so it cannot be missed again.

---

## 4a. OVERRIDE — Tim, 16 September 2026: Claude builds the CDWT window

> **Tim: *"build the CDWT window yourself, ignore ruling B for now"***

**This suspends Ruling B for the CDWT window only.** It does not change ownership of any other window, and it
is explicitly *"for now"* — it is not a general reversal of the 15 September ruling.

**Collision risk, stated so it is not discovered the hard way:** Codex may already be working on Civil
windows. The CDWT window is now Claude's. If Codex has work in flight on `WaterTankPlanBlockPickerDialog` or a
tank window, **Tim must be told before either side merges**, because two hands on one window is exactly how
work gets lost.

## 5. Ownership — otherwise unchanged, and it matters here

**Ruling B: Codex builds windows. Claude owns behaviour, the spine and deploys.** Several items above are
window work (G-03 the CDDESIGN window, W-01 the tank window's appearance, TWL-07 if CDTWL becomes a window).
The behaviour side's job for those is to **publish a written contract** and build the logic behind it — not to
build the window.

Items that are squarely behaviour and therefore mine: P-02..P-08, C7-01..03, L-01..03, T-01, D-01, G-02, G-04,
TWL-03..06, F1-01..04, and the `CDRAINFALL` sample files.

---

## 6. Ruling — 16 September 2026 (afternoon): CD / PIT window layout

Asked: one-page Engineering/Drafting layout as shipped (proportioned properly), or the three slim tabs approved
on 2 September?

> **Tim: *"one page layout proportioned properly, no tabs"***

Interpretation (mine, not his words): the 2 September three-tab approval for the Pipe and Pit editors is
**superseded** for these two windows. The work is to make the shipped one-page layout fill the ~90% window —
CD: Engineering left, Drafting right, wide plan preview underneath; PIT: Engineering left, large centre
preview, Drafting right — with no scrolling and the main actions always visible. `PipeEditWorkshopDialog.xaml`'s
five tabs stay as the hidden source the one-page layout re-homes controls from; they are not shown.

### 6a. Tim on the LAYOUT-01 renders (16 Sep, afternoon; seen as test PNGs, not yet in AutoCAD)

> **Tim: *"PIT LOOKS GREAT THE CD WINDOW NOT SO"***

Asked whether the CD window could be redesigned to earn its 90% size. Three options were put to him:
(1) draw the real plan in the CD preview — the two pits, the pipe, pipe text, invert text and arrow where they
will land, live as he types (behaviour work, largest, also serves P-05/P-06); (2) size CD to its content instead
of 90%; (3) bring the More… groups onto the page as a third column. **No option chosen yet — open.**
PIT layout (2*/3*/2*, wide centre block preview) stands as built on `claude/ce-civil-handoff-sept-16-5623ca`.

### 6b. Ruling — CD and PIT previews show the real thing (Tim, 16 Sep afternoon)

> **Tim: *"ON SECOND THOUGHTS I AMA HAPPY WITH BOTH AS LONG AS IT CAN SHOW REAL WORLD PREVIEWS OF BOTH THE PIT
> AND INCOMING PIPES AND THEIR DETAILS FOR THE PIT WINDOW AND THEN FOR PIPE IT SHOULD SHOW ALL PREVIEWS OF EACH
> END SAY PIT OR IO OR WHATEVER"***

Interpretation (mine): option 1 for both windows. The LAYOUT-01 proportions stand. Next step is a written preview
contract (what is drawn, from which drawing data, what shows when an end is Unknown), then one build per window.

Contract written (nothing built): plugin repo `docs/workflows/PREVIEW_CONTRACT_CD_PIT_2026-09-16.md` on `claude/ce-civil-handoff-sept-16-5623ca`. Four open questions in it for Tim: detail placement on the PIT picture, CD end context, 2022-2024 lane, missing end types.

> **Tim, 16 Sep (confirming): *"1 – real plan drawing in the preview (pits, pipe, text, arrow, live)"*** — option 1 confirmed for CD. The four contract questions are still open.

### 6c. Tim's answers to the four preview-contract questions (16 Sep)

> 1. *"AT THE STUB ON THE WALL"*  2. *"only this pipe."*  3. *"The block picture is 2027-only."*  4. *"no additionS"*

PIT build starts on `claude/ce-civil-handoff-sept-16-5623ca`.

> **Tim, 16 Sep (on the PIT stub preview): *"CAN IT HAVE THE SCREENSHOT OF THAT AREA ON THE PLAN ? WITH HIGH FIDELITY?"*** — asked, not yet answered. Options put to him: render the real drawing around the pit off-screen (same PROBE-75 route, entities from the live drawing instead of a scratch block) — needs a probe first; nothing built.

> **Tim, 16 Sep: *"PROBE"*** — approved a probe for rendering the real drawing area around a pit off-screen (PROBE-75 route) before any build.

### 6d. PROBE-PLAN result (16 Sep, run by Tim on a real drawing)

Route A (off-screen re-render of the live entities around the pit) **works**: crisp 1200x1200, 3 entities, 224 ms.
Route B (screen capture) is screen-resolution, viewport-shaped, and the zoomed capture landed on the wrong area.
**Verdict: build the real-plan preview on Route A.** Findings: `C:\Autodesk\CERef\PROBE-PLAN-AreaPreview-20260916\FINDINGS.md`.

> **Tim: *"THIS WONT ADD EXTRA LAG WILL IT? IF SO HOW DO WE RESOLVE"*** — answer: one-off ~0.2 s per render, not
> continuous; render on open and on committed size/type change only, never per keystroke; extents pre-filter.

> **Tim, 16 Sep: *"CARRY ON, BUILD THE REAL PLAN PREVIEW FIRST"*** — no deploy yet; PIT real-plan preview (Route A) is being built on `claude/ce-civil-handoff-sept-16-5623ca`, which now also carries the BUG-159 CDGRIPDIAG merge.

> **Tim, 16 Sep: *"CARRY ON"*** — CD real-plan preview next, same Route A; still no deploy.

### 6e. DEPLOYED 16 Sep 16:06 — `6505fb5a`

> **Tim: *"AUTOCAD IS CLOSED, DEPLOY"***

Live is now `6505fb5a` in all three lanes (read back from the DLLs). Backup `CE_CVL_SUITE_PRE_0737efa3_20260916_160353.backup`. Register: issue #78. Installed, not tested: PENDING_TESTS L1–L7 + BUG-159 rectangle test.

### 6f. Tim's AutoCAD results on `6505fb5a` (16 Sep, ~16:30) — first sight of the new windows

1. About CE Suite: Civil `6505fb5a` — **deploy verified.**
2. Edit Pit P10: real-plan picture **appears** (P10 label, CL 19.45, pit block, sharp). Tim: *"HOW DO WE GET IT TO
   CHANGE BASED OF THE CHANGES WE MAKE IN THE WINDOW?"* Also seen in his image: **"No connected pipes were found
   for pit P10"** although the P10→P9 pipe exists (image 3) — a lookup defect, new, logged as PIT-CONN-01.
3. Edit Pipe P10→P9: real-plan picture **appears** with both end captions. Same question as 2.
4. New Pit: block picture at typed size — works. New Pipe: old schematic in a huge empty band — Tim: *"REVIEW"*.
5. Buttons visible, typed value survives More… → Back: *"WORKS"*.
6. Fit-guard message: *"DIDNT"* (did not appear) — good.
7. BUG-159: *"STILL NOT WORKING LOOK AT IMAGE 6"* — rectangle mid-side grips still square. His paste shows only
   the REC command; whether `CDGRIPDIAG → Off` was run first is NOT confirmed. Owner: the BUG-159 chat.
8. Tim: *"IS IT JUST ME OR ARE SOME OF THE TEXT BOXES AND SPACING AND LOOK OF THINGS A BIT UNPOLISHED AND UGLY"*
   — yes; window polish is Codex's lane under ruling B (list to be written).

### 6g. Tim, 16 Sep (after 6f)

> *"YES I RAN CDGRIPDIAG OFF FIRST AND NOW ITS BACK TO NROMAL, WILL THAT REGRESS THE PLUGIN?"* — **BUG-159 answer
> for the BUG-159 chat: YES, the CE pipe grip guard (`PipePlanGripOverrule`) is the cause.** Rectangle grips are
> normal with it Off. Fix belongs to the BUG-159 chat (XData filter, keep pipe protection).

> *"YOU DO THE POLISH YOURSELF MAKE IT FAR FAR BETTER PLEASE"* — **ruling B suspended for the CD and PIT windows'
> polish** (as already for CDWT on 16 Sep). Claude does it.

> *"FIX 4"* (New Pipe gets the real plan) and *"FIX THIS PLEASE"* (PIT-CONN-01 connected-pipe lookup) — ordered.
> Asked whether the dry-run preview (2 & 3) adds lag — answered in chat; recorded below when built.

Order: PIT-CONN-01 → New Pipe plan → polish → dry-run preview.

### 6h. Tim, 16 Sep (evening): all three CD/PIT window upgrades go ahead

> *"IVE GOT SOME OTHER FIXES ALONG SIDE THAT SO WHILST THAT HAPPENS CAN WE DO THIS STUFF:"* — (1) preview shows
> what is about to be saved (dry-run), (2) click a pipe tag in the PIT picture selects it in the list / click an
> end in the CD picture jumps to that level box, (3) drag the pit label / cover text tag on the picture to choose
> its corner.

Order: 2 (small) → 3 (medium) → 1 (biggest, contract first). Owner of the CD/PIT window files and preview
controls is this chat (`claude/ce-civil-handoff-sept-16-5623ca`). **Other chats fixing alongside must not touch
`PipeOnePageLayout`, `PitOnePageLayout`, `PitBlockPreviewControl`, `CdPlanPreviewControl`, `PlanAreaRenderer`,
or the preview parts of `PitEditCommand` / `PipeEditCommand`.**

### 6i. Tim, 16 Sep: *"INSPECTOR SHOWS CORRECTLY PIT WINDOW SHOWS THIS PIPE AS CHARGED?"*

Root cause found and fixed as PIT-TYPE-01 (plugin REGRESSION_LOG): the pipe window stored a charged-destination name on every pipe and the pit reader let that name outrank the drawing's own type. Built, not installed.

> **Tim, 16 Sep: *"CARRY ON WITH THE DRY-RUN PREVIEW"*** — contract first, then build.

DRYRUN-01 built (not installed) on `claude/ce-civil-handoff-sept-16-5623ca`; contract at plugin `docs/workflows/DRY_RUN_PREVIEW_CONTRACT_2026-09-16.md`. Open question for Tim's test: does an aborted outer transaction leave an Undo step (L14).

### 6j. Tim, 16 Sep (evening) — the CE pipe object (C7), text placement rules, and upgrade-everywhere (recorded by the "other Civil areas" chat)

Context: this chat found the causes of C7-01/02/03 in the log (CDFW refused on a converted pipe by the source
pre-scan; the pipe watcher only recognises polylines so a moved converted pipe is filed as a stray label; CD still
draws the old polyline). Tim's reply, in his words:

> *"THAT ALL SEEMS GREAT BUT THERE NEEDS TO BE SOME RULES AROUND PLACEMENT AND LOCATIONS FOR EXAMPLE IF A PIPE OR A
> PIT IS LOCATED IN/ON A PIPE TEXT OR INVERT TEXT THEN THAT TEXT EITHER MOVES AWAY FROM THE PIT TO NOT OBSTRUCT
> ALONG THE ANGLE OF THE PIPE OR IT FLIPS TO THE OTHER SIDE OF THE PIPE, DOES THAT MAKES SENSE?"*

> *"IF WE UPGRADE TO THIS NEW ENTITIY THAT STILL WORKS WITHOUT THE PLUGIN THEN IT NEEDS TO BE IMPLEMENTED EVERYTIME
> YOU OPEN AN EXISTING JOB, EVERYTIME YOU OPEN OR EDIT A PIPE EVERYWHERE IT NEEDS TO BE IMPLEMENTED."*

> *"THE CONVERTED PIPE MOVED OR SHIFTED AND IT FELL APART AND THE TEXT DIDNT MOVE WITH IT."* (C7-01 clarified: a
> MOVE / shift, not only a grip.)

Interpretation (Claude, not Tim's words):
- **PLACE-01 (rule):** when a pit or a pipe sits on a pipe text or an invert text, that text is moved clear —
  first along the pipe's own angle, away from the pit; otherwise flipped to the other side of the pipe. The
  order (slide first, flip second) and the clearance distance are put to Tim as questions below, not decided.
- **C7-UPGRADE-01:** automatic upgrade to the CE pipe object on open of an existing job and on every pipe
  open/edit — Tim's 14 Sep ruling (a) is now confirmed and widened to "everywhere". `CD` draws the new object
  directly (C7-02 becomes a build item, not a question). Pre-condition Claude states: the remaining polyline-only
  readers (252 sites on 16 Sep) must go through the one seam first, or an auto-upgraded job opens with tools that
  cannot read its pipes.
- **Open questions put to Tim (16 Sep evening):** Q1 slide-then-flip order; Q2 clearance value (Settings page);
  Q3 2022–2024 colleagues on an auto-upgraded drawing (no 2024 enabler exists today); Q4 one dated backup per
  drawing at first upgrade only, or every time. Unanswered until Tim answers.

### 6k. Tim's answers to the four C7 questions (16 Sep, evening)

> Q1 slide/flip: *"SLIDE FOR A CERTAIN DISTANCE THEN FLIP, DISTANCE SHOULD BE A TOGGLE BUT NO MORE THAN 500 FROM END
> OF PIPE. ALSO THIS NEEDS TO BE THE SAME FOR ANY OF THIS STUFF IF IT CLASHES WITH ANY OTHER CE OBJECT IN THE
> DRAWING LOGICALLY OFCOURSE. THIS SHOULD BE PLUGIN WIDE"*
> Q2 2022-2024: *"Build the 2024 enabler first"* (chose the recommended option).
> Q3 build order: *"Tools read the object first, then upgrade on open"* (recommended option).
> Q4 backups: *"One, the first time only"* (recommended option).

Interpretation (Claude): **PLACE-01 is now:** an obstructed CE label slides along its pipe away from the obstruction
up to a Settings-page distance (default to be set, hard ceiling 500 mm measured from the pipe end), then flips to the
other side of the pipe. It applies to every CE label (pipe text, invert texts, flow arrow; callouts left as placed)
clashing with **any** CE object (pits, pipes, sources, tanks, other CE text), plugin-wide, through one rule.
**Build order fixed:** (1) every CE tool reads the pipe object through the seam; (2) the fresh-pipe identity refusal;
(3) PLACE-01 as one rule in all five placement moments; (4) 2022–2024 enabler; (5) auto-upgrade on open with one
dated backup per drawing on first upgrade; (6) CD draws the object. "Logically of course" is read as: the rule never
moves a label onto another obstruction and never moves a hand-placed label — the existing CV-01I guarantees stand.

### 6l. Tim, 16 Sep (evening): the six "what you are missing" items — all confirmed

Claude listed eight things; Tim replied on six, in his words:

> *"1. The rule must be ONE rule used in five places  2. Ordinary pipes are refusing too  3. Arrows and callouts - YES
> BUT THE CALLOUT HAS TO BE CONNECTED TO THE PIPE AND THE TEXT NEEDS TO NOT OBSTRUCT ANY OTHER CE OBJECT  4. Twin
> pipes UPGRADE ALSO  5. One Undo  6. One line on open  — IMPLEMENT ALL OF THIS AS WELL"*

Interpretation (Claude): **PLACE-01 covers callouts too** — the leader stays anchored to the pipe (never detached),
and the callout TEXT is moved clear of any CE object like the other labels. Twin pipes go through the auto-upgrade.
One U reverses a move and every label that followed it. Every open that upgrades pipes prints one line naming the
count and the backup file. The fresh-pipe identity refusal (NativeEdits) is in scope of this batch.

### 6m. Tim, 16 Sep (evening): C7 fork — probe first

Claude found that the pipe object's stand-in polyline has no handle and no drawing behind it, so CE code that writes a
record against a stand-in writes nothing (hypothesis from code reading, not yet proven in AutoCAD), and that ~250
read sites + ~100 write lines would need changing. Alternative put to Tim: rebuild the object on AutoCAD's polyline
class so every tool sees a real polyline. Tim chose: **"Probe first, then rebuild if it works"** (the recommended
option). PROBE-C7-POLY: a throwaway DBX with a class derived from AcDbPolyline, proven headless in accoreconsole 2027
(reads as a real Polyline with its real handle, keeps its extension dictionary through handOverTo, draws its own
walls, survives save/reopen). No change to the live enabler until the probe result is recorded here.
