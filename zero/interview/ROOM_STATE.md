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
