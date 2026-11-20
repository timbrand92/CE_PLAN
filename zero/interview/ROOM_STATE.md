# Tim's room: state to pick up cold

**Room:** "CE_ACAD / Tim / interview and ideas" (D-353, `ROOMS.md`). **Written:** Fri 20 Nov 2026, about 2:45 pm (PC clock), because the chat is long. Whoever carries this room on, in this chat after a compact or in a new one, starts here.

## 1. What this room does and never does

1. **Does:** interviews Tim down the list of unknowns; is his general chat; research and fresh thinking. Writes only under `C:\CE_PLAN\zero\`: `UNKNOWNS.md`, `interview\`, `pictures\`, `reference\research\`, one line per idea in `IDEAS.md`.
2. **Never:** code, `C:\CE_CIVIL` (read only), AutoCAD or anything that starts it, installs, branches, `DECISIONS.md`, `BOARD.md`, `BOARD.json`, `STATE.md`, the scope pages, the rulings pages. No client names, job addresses or job numbers anywhere. Rule 1.9 in full.
3. **Every reply to Tim** starts with the two R-72 lines (counts read from `C:\CE_PLAN\BOARD.json`: Built 2, Checked 0, Installed 0, Accepted 0 of 9 when last read), FOR TIM above a line, numbered lists with bold labels, no tables, ends Completed / Not completed / Next.

## 2. How Tim wants to be asked (his words and corrections today)

1. **Question window, four questions at a time, each with its own context and a real example inside it** (he cannot see chat text behind the window), one option "(Recommended)".
2. **ONE BY ONE (TR-086).** Never "confirm these ten". Each specific is its own question. Saved to memory as `tim-wants-questions-one-by-one`.
3. **A picture first where a screen or a position on the plan is involved.** Drawn by a helper to a tight brief, checked by a SEPARATE helper against the 31 screen rules, faults fixed, then sent with SendUserFile, then asked.
4. **Never open the question window if he has not spoken in the last half hour.**
5. **He often answers in his own words, not an option.** Record the words exactly, mark the room's reading as the room's, and put the reading back to him when it matters. Twice today the room misread him: "live" means in the window's OWN preview panel (TR-068), not on the drawing behind; and "less text" was already answered (TR-021).

## 3. Where everything is

1. **His answers, in his words:** `interview\ANSWERS_TIM.md`, TR-001 to TR-107. Next number TR-108.
2. **The list:** `UNKNOWNS.md`. PART A is U-001 to U-128 in that file. PART B is N-001 to N-119, held in `interview\FOLD_DRAFT.md` Part 1 (the control room's two line-by-line pages, `stage6\SPEC_PIT.md` section 10 and `stage6\SPEC_PIPE.md` section 12, sorted against his answers). The line "PART B CLOSED:" in `UNKNOWNS.md` lists which N-numbers are closed. Count at the top of the file.
3. **The recorder:** `C:\CE_WORK\scratch\tim_room\rec.py batch.json` appends a batch to the answers, closes U and N lines, rewrites the count, commits the two files by name, pulls and pushes. Examples: `b22.json` to `b26.json` beside it. Pass the open-blocker figures by hand.
4. **Pictures shown to him and answered:** `pictures\label_positions*`, `clash_order*`, `flow_arrow*` (superseded on the arrow's first spot by TR-019), `pit_window_live_*` (approved, TR-078 to TR-081).
5. **Research:** `reference\research\R-016_SLEEVED_PIPE.md` done; queue in `reference\research\THINKING_QUEUE.md` (1 of 7 done).
6. **Helpers run on the Team account** (usage order): `CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team`, `C:\Users\TimothyBrand\.local\bin\claude.exe -p --model sonnet` (opus for a check), brief in a text file under `C:\CE_WORK\scratch\tim_room\` written with the Write tool (a long shell heredoc failed once), run in the background. Every brief repeats the hard limits.
7. **Telling the control room:** SendMessage to `local_1ce7be26-8d42-4f4d-b792-c55c7af074a7`. Answers that change work in hand at once; the rest every 15 to 20 minutes (D-391). No notes that only acknowledge.

## 4. In flight when this was written (check each before telling Tim it is done)

1. **Tim is at lunch** (TR-107, about 2:30 pm). No question window until he speaks.
2. **Pipe window mock-up** `pictures\pipe_window_live_preview.html` with `pipe_window_live_laptop.png` and `_desktop.png`: drawn, checked once (report `C:\CE_WORK\scratch\tim_room\check_pipe_window.md`), fixed (falls worked from exact figures), saved. A Team helper is now adding a grey-band "not known" state (`?s=notknown`, report `grey_band_report.md`) and re-checking the page. NOT yet shown to Tim. To ask with it: is the plan across the top right (D-313) now the Pit window has it at the left; contents of the window line by line (U-037); the grey band for "Cannot check yet" and "Not known" (D-389); that the two set sizes apply to the Pipe window too.
3. **Two Team helpers drawing option sheets:** `pictures\bends_and_sleeve.html` (label on a pipe with bends, a bend close to a pit, the sleeved length; U-107, U-112) and `pictures\grips_and_levels_window.html` (grips on a pipe, grips on a pit, the levels-or-grade window; U-057, U-113, TR-036, TR-101). Outputs `draw_bends_out.txt`, `draw_grips_out.txt` in the scratch folder. Each still needs a separate check, then Tim.
4. **Owed and not started:** the arrow redrawn his way (TR-019: first spot opposite the label, centred); "also on the drawing behind the window" as two pictures (U-100, TR-070); an inspector panel against Properties (his question in TR-066, U-052); the nine clashes at the foot of `rulings\INDEX.md` sorted against the TR numbers (U-127).

## 5. Next questions for Tim, in order (one by one, four to a window)

1. The Pipe window pictures (above).
2. Bends, then grips, then the sleeved length, then the levels-or-grade window.
3. Then on down `interview\FOLD_DRAFT.md` Part 1 in the order a drafter meets things. Pit items not yet asked include: N-010 (cursor key), N-017 (kind looks), N-018 (prompt words), N-025 (cover level on a turned pit: the D-267 clash), N-026 (lid words, research first), N-027 (schedule and detention ticks), N-029 to N-031, and the "how a pit is drawn" and "editing a pit" lines that were in the refused batches of ten (circle tag, "CL" wording, plastic "PP over CL", ByLayer, height 0 and scale 1, beside order, where the 900 and 400 are measured to, masks, what counts as in the way, hand-typed cover text, plastic stretched, insertion grip, MIRROR erase source, SCALE, xref, MATCHPROP, paste, erase mid-run).
4. From the control room, not yet asked: U-126 (which circled tag, and from where), U-128 (two pipes between the same two pits), a fork or loop below the resize offer, the typed name for Renumber, whether CDEDIT clashes with an old name.
5. Readings to confirm in one line each: TR-030 (ordinary pipe ONLY in Stage 1, charged waits), TR-020 (a flow he reversed by hand stays put).

## 6. Things easy to get wrong

1. **The PC clock is the clock.** The control room's notes have run up to 40 minutes ahead of it.
2. **`C:\CE_PLAN` is a shared working copy.** Commit by file name only, `git pull --no-rebase` then push, never `add -A`, never force. Other sessions leave their own uncommitted files there; leave them.
3. **A helper's findings are not checked until this room has read a source itself.** Say which were and were not.
4. **The mock-ups are pictures.** Nothing in them has been seen working in AutoCAD; say so each time.

## 7. Update, Fri 20 Nov 2026, about 3:40 pm

1. **Answers now run to TR-142.** Next number TR-143. The recorder's last batch file is `b34.json`; pass `"a_total": 152` from now on.
2. **Settled from pictures since section 4 was written:** the Pipe window (TR-108 to TR-111, TR-120), one length in a run (TR-114), the single-pipe window in words (TR-115, picture still owed), pipe numbers (TR-119), bends (TR-130, TR-131), grips (TR-139, TR-140), the levels-or-grade window (TR-141), the sleeved length (TR-142).
3. **Control room's questions owed to Tim** are in `interview\FROM_CONTROL_ROOM.md` and on the list as U-133 to U-152 (nine label questions, eleven draft calls). One by one, pictures first where a place on the plan is involved.
4. **Asked and not yet answered:** which layer the green impervious-area line is on (TR-134, U-132). The old-jobs search found nothing in the folders this room may read (`C:\CE_WORK\scratch	im_room\impervious_findings.md`, a helper's search, not re-read by the room).
5. **Pictures owed:** the single-pipe window; the cover level "from the pit outwards" on the two left corners (TR-140); "also on the drawing behind the window" both ways (U-100); an inspector panel against Properties (U-052); which side is "above" on a pipe drawn right to left and on an upright pipe (U-133).
6. **Team sign-in ends between 24 and 27 Nov;** Tim must sign in again before then or the helpers stop.

## 8. Update, Fri 20 Nov 2026, about 5:10 pm: Tim has gone home (TR-211, "IM GOING HOME CAN YOU KEEP THINGS MOVING")

1. **Answers run to TR-211.** Next number TR-212. Recorder batch files `b35.json` to `b52.json` are written with the Write tool (a path with backslashes broke one written in the shell); keep `"a_total": 152`.
2. **Count: 195 of 271 closed.** EVERY PLAIN STAGE 1 QUESTION HAS BEEN ASKED. What is left is not plain questions; the full list is in the note sent to the control room at about 5:06 pm and in `UNKNOWNS.md`: about ten tests in AutoCAD (not his), eight pictures and three research pages owed by this room, and the nine clashes at the foot of `rulings/INDEX.md` to sort against the TR numbers (U-127).
3. **Running tonight** (`C:\CE_WORK\scratch	im_room
un_night.sh`, Team account): one helper drawing `pictures/single_pipe_window.html` and `pictures/ce_settings_window.html`; one drawing `pictures/night_sheets.html` (five sheets: cover level from the pit outwards; the flow arrow's look; how "assumed" shows; the part behind the window; hover); then a separate checker writing `C:\CE_WORK\scratch	im_room
ight_check.md`. When they finish: read the check, send the failed ones back for fixes (brief like `brief_fix_sheets.txt`), look at each PNG, commit the files by name. Do NOT send pictures or open the question window until he speaks.
4. **Questions ready for him tomorrow, one by one, each with its picture:** the single-pipe window (step 1 with a level box at each end, the typed length); the CE Settings window (its rows; its typed name); cover level from the pit outwards (TR-140); the arrow's look (N-076); assumed levels on a copied system (U-063); the part behind the window (U-100, TR-070); hover (U-103); dragging and resizing the window (U-105, no picture yet); two readings to confirm (TR-030 ordinary pipe ONLY in Stage 1; the text style by name, TR-187).
5. **Research still owed (0 of 3 started):** the material that follows sizes above 150 (N-054); the pipe's outside size for the cover check (U-086); what bends the standards allow (U-098). Helpers on the Team account, briefs like `brief_impervious.txt`; check a source yourself before it reaches him.
6. **Today's overturned drafts, all sent to the control room:** shaped grips are part of Stage 1 (TR-166); a mask tick per text (TR-156); the tool puts its own no-plot layer back (TR-163); a pipe's length may be typed (TR-175); cover is checked at the two ends only (TR-198) and says nothing when "what is over it" is not set (TR-197); a missing grade is left off the label (TR-185); one length in a run can be changed in the run window (TR-114); pipes have their own numbers (TR-119).

## 9. Update, Fri 20 Nov 2026, evening: tonight's set is ready for the morning

1. **Pictures drawn, checked once by a separate Team helper (5 passed, 4 failed), fixed, looked at by the room, saved; NOT shown to Tim:** `pictures/single_pipe_window_desktop.png` and `_laptop.png`; `pictures/ce_settings_window.png`; `pictures/night_sheets_1.png` (cover level from the pit outwards, two options), `_2.png` (the flow arrow's look, three options), `_3.png` (assumed levels on a copied unit: APPROX. or markers), `_4.png` (the new pit also on the drawing behind the window, or not), `_5.png` (hover). The fixes have NOT had a second independent check; the control room has been asked to have the check room look before he sees them. Reports: `C:/CE_WORK/scratch/tim_room/night_check.md`, `night_fix_report.md`.
2. **Research pages filed:** R-017 (material by size), R-018 (outside size), R-019 (bends and inspection openings). Each says at its top what the room checked itself and what only the helper read. To put to him: the six-row material list and a 90 dia. question (N-054); the outside-size list (U-086); the inspection-opening prompts and whether 30 m applies to single dwellings (U-098).
3. **Morning order, one by one, four to a window, picture first:** the single-pipe window; the CE Settings window and its typed name (U-158); cover level outwards; arrow look; assumed; behind the window; hover; then the control room's H1 and I1 to I4 (U-153 to U-157); then the research confirmations; then readings to confirm (TR-030 ordinary pipe only; text style by name).
4. **Not started:** a picture for dragging and resizing the window (U-105); sorting the nine clashes at the foot of `rulings/INDEX.md` (U-127).

## 10. Update, Fri 20 Nov 2026, about 9 pm: STOPPED until Tim speaks (control room, D-434)

1. **Usage order:** the Team account is spent until 1 December: send it NOTHING. This room now runs on Opus 5.5. No further helpers and no periodic looks until Tim speaks. Codex only, if anything.
2. **Single-pipe window and Settings window:** four fix passes done (two from the check room's looks, D-419, D-426); saved (commit a2d397ff); sent to the check room for its third look, answer not yet received. If the check room still fails something, ONE fix by Codex or one Sonnet helper at most, then stop.
3. **Research pages R-017 to R-019 are DONE** (filed before this order). The nine clashes (U-127) wait for Monday.
4. **New for Tim on Monday:** U-159 (his login name in the block drawings), U-160 (web addresses in their class records), plus everything in section 9 point 3 and U-153 to U-158.
5. **Count:** 195 of 279 closed.

## 11. Update, Fri 20 Nov 2026, about 10:35 pm: pictures passed

1. **The check room's third look PASSES** the single-pipe window (seven states), the CE Settings window and sheets 1, 4 and 5, after one fit edit, which the room made itself (no helper). They may go to Tim on Monday. Verdict: `check/VERDICTS/timroom-night-pictures.md`, "Third look".
2. **Finish items left as the check room's "your call"**: a column heading 2 px over in the no-level state; sheet 1's last line not a full sentence; the Settings "office value" heading 4 px over its box.
3. **New for Monday:** U-161, which green and amber the windows use.
4. **This room is stopped** until Tim speaks (D-434). Count: 195 of 280 closed.
