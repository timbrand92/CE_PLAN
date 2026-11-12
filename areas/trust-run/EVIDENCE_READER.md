# Evidence for the reader (PR 2040 at 222a303e), in the core console (lane trust-acad-evidence)

**Written:** Fri 13 Nov 2026, 03:00. **Status: DRAFT evidence.** Built yes (head `222a303e`, Civil 3.0.90 build, 0 errors). Tested: six drawings read twice each, below. Installed no. Accepted no.

**How it was run.** The reader and its read-only copy-filler (`TrustSnapshotFiller.Fill`, then `TrustDrawingReader.Read`) have no command and no caller yet. To run them I wrote a small probe command, `CEPROOFREADER`, in my OWN worktree (never committed, never pushed, outside every pull request). It calls the two functions through reflection on the branch's own build, loaded in AutoCAD's core console from a scratch folder, never the live bundle. It fills the copy twice, reads it, and dumps both as text. Each drawing is a COPY made by the repo's harness; the originals are never opened. The branch's scorer was not run: my answer sheets are prose, not in its file format, so the comparison below is by eye against `C:\CE_WORK\testset\MADEUP_README.md`.

---

# FOR TIM

1. **Safe: seen to pass on all six drawings.** Reading changes nothing: the drawing's change counter was the same before and after each reading, the copy on disk is untouched, and the file the copy was made from is untouched. I did NOT compare CE's stored record text before and after, so that half of the check is not seen (the reviewer's call-graph test is what promises it).
2. **Repeatable: seen to pass.** Each drawing was read twice in the same session and in two separate runs: every reading came out word for word the same.
3. **Right on the two real test copies.** The standard test copy has 11 pits and 49 pipes in CE's record; the reader reports 11 pits and 49 pipes, all Sure, every pit with its number and every pipe with its size. On the second (larger) test copy it reports 10 pits and 46 pipes; only 1 of the 10 pits got a number (see below).
4. **Right on the made-up old drawings, mostly.** Seen to pass: the old "Stormwater Pit" is read as a Proposed pit; plain-text numbers P1 to P5 land on the right pits; a number text exactly between two pits (X1 in one drawing, P6 in another) is given to neither; the old DIA. PIPE blocks give 100, 150, 225 and 300; the downpipe and tank blocks are found; the "NEW LEVEL" existing-level note is NOT mistaken for a cover level; pipes with no text, or with two competing texts, stay Unknown; the old LISP pipe text gives size, material, grade, detention length and the charged-pipe destination.
5. **Three misses against my answer sheet (for the reader lane):**
   1. **Cover and invert levels next to an old pit are not read in the old-palette drawing.** The COVER LEVEL and INVERT blocks are recognised, but their numbers (12.30, 12.10, 11.95, 11.60; 11.20 and 11.05) are not given to any pit: every cover level and invert reads Unknown, with the note "no level text found yet". In the old-LISP-style drawing the same kind of text, written "CL 12.30", IS read.
   2. **Inverts in the old-LISP drawing are given to pits, and the pipe ends are mostly missed.** "IL 1.10" and "IL 0.88" land as pit inverts (P1, P2) and as the first pipe's start; the three other inverts are not read. They sit 2,200 mm from their pit, beyond the reader's 2,000 mm reach. I do not know where the real old tool put them, so my placement may be wrong, not the reader.
   3. **A loose exploded pipe with the text "150 DIA. PIPE" reads size Unknown.** My sheet expected 150. The text is not in the fixed old-LISP wording ("150 DIA. UPVC PIPE AT 1 IN 100 MIN."), so Unknown is defensible under the reader design; it is a decision for the reader lane and Tim.
6. **What I did not test:** the branch's scorer (my sheets are not in its format), any real job, any drawing with CE's record behind the drawing, AutoCAD 2022 to 2024.

---

# DETAIL

## 1. Safe and repeatable (the P3 steps)

1. **MADEUP_oldlisp_01 (37 objects):** change counter 0 before and 0 after; two fills identical; two reads identical; run 1 equals run 2 (reading and copy, ignoring the run name).
2. **MADEUP_handdrawn_01 (13 objects):** same: 0 and 0; identical; identical.
3. **MADEUP_oldpit_levels_01 (27 objects):** same.
4. **MADEUP_oldpipeblocks_01 (14 objects):** same.
5. **Standard test copy, 1,034 objects:** change counter 1 before and 1 after (opening a drawing marks it changed; the reading adds nothing); identical; identical.
6. **Second standard test copy, 1,285 objects:** same as 5.
7. **CE's record was found readable (not "unreadable") in all twelve runs.** The probe does not compare the record text itself; the filler's own call-graph test (a reviewer's job) is the guarantee that it never calls CE's record update.
8. **Not shown:** that no Undo step is added (the console does not show it); that CE's log is unchanged (the harness reports the live log was untouched).

## 2. Readings against the answer sheets

**MADEUP_oldpit_levels_01 (old "Stormwater Pit", plain-text numbers, old level blocks)**

1. **Pits (5):** all five Proposed ("old palette pit block 'Stormwater Pit'; it carries nothing of CE's"). Numbers P1, P2, P3, P4 right (each note names the text and the distance, for example 1,140 mm to the only pit in reach). Pit 5: number Unknown, as the sheet says.
2. **The ambiguous text "P6":** given to neither pit 2 nor pit 3. Right.
3. **Levels:** all Unknown (see FOR TIM 5.1). The six COVER LEVEL and INVERT blocks appear as "other CE symbol" rows without values.
4. **NEW LEVEL block (attribute 11.95):** read as an other CE symbol with Level 11.95; not used as a cover level. Right.
5. **Pipes (4):** Proposed rows, every value Unknown. Right.

**MADEUP_oldpipeblocks_01 (old "DIA. PIPE" blocks)**

1. **Pits (5):** Proposed, numbers Unknown. Right.
2. **100 DIA. PIPE:** diameter 100 (Proposed). **150 DIA. PIPE (scale 2):** 150. **225 DIA. PIPE (rotated 90 degrees, scale 1.5):** 225. **300 DIA. PIPE:** 300. All right.
3. **"100 PIPE" block:** diameter 100, reason "a pipe drawn as the old palette block '100 PIPE'; its size is read from its name". My sheet allowed this or Unknown with a stated reason: pass.
4. **The loose exploded pipe:** diameter Unknown, reason "on layer STORMWATER PIPE with no CE data". My sheet expected 150; see FOR TIM 5.3.
5. **DRAINAGE lines:** not counted as pipes. Right (11 rows: 5 pits, 6 pipes).

**MADEUP_oldlisp_01 (old LISP style)**

1. **Pits (6):** Proposed; numbers P1 to P5, pit F Unknown; "X1", exactly between pits C and D, given to neither. Right.
2. **Cover levels from "CL ..." text:** P1 12.30, P2 12.10, P3 11.95; D, E, F Unknown. Right.
3. **Pipes:** P-1 150 UPVC 1 IN 100 (start invert 1.10); P-2 225 UPVC 1 IN 150; P-3 225 UPVC 1 IN 200 with detention length 12.5 m; P-4 charged pipe 100 UPVC, destination WT; P-5 (no text) all Unknown; P-6 (two competing texts) all Unknown. Right for size, material and grade. Inverts: see FOR TIM 5.2.
4. **Downpipe block:** a Source row, Downpipe, Proposed (my sheet said Sure by name; the reader is more careful). **3000 LITRE TANK:** a Tank row, 3000 L, Proposed.
5. **The two flow arrows:** "other CE symbol", Sure. Plausible.

**MADEUP_handdrawn_01 (no CE tools)**

1. **No rows, no unrecognised blocks, note "the drawing has no CE record".** Right: nothing on a CE layer, nothing invented. My sheet also hoped for a list of the rectangles on layers the reader does not know; the reader only lists unrecognised BLOCKS, so that part is not delivered (small).

**Standard test copy (11 pits, 49 pipes in CE's record)**

1. 395 rows: pits 11 Sure and 11 pit labels Sure; pipes 49 Sure; 18 sources Sure and 32 Proposed; 12 tanks Sure; 247 other CE symbols Sure; 15 unknown blocks. Every pit has a number; every pipe has a diameter. Equals the record's 11 and 49.

**Second standard test copy (an older, larger job)**

1. 118 rows: 46 pipes Sure (CE's record held 27 CE pipe objects; the 46 includes plain pipe lines the reader recognised, not checked line by line), 10 pits (1 Sure, 9 Proposed), 11 pit labels (1 Sure), 42 sources Proposed, 5 tanks, 2 other CE symbols, 2 unknown blocks. Only 1 of the 10 pits has a number: the other nine have no matching label text or label block within reach, or are old symbols. I did not check why; it is the best candidate for a real old-job finding.

## 3. Not done

1. The branch's scorer (needs answer sheets in its JSON form with real handles).
2. A drawing where CE's record is behind the drawing, or damaged.
3. A read of the same drawing in real AutoCAD (the probe is core-console only).
4. Anything about speed on a large drawing: the larger copy read in about 25 s per run including start-up.

Probe source (local, never committed): `C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\trust-acad-evidence-d9369a\Modules\Drainage.HeadlessProof\ReaderProbe.cs`, copy in `C:\CE_WORK\scratch\trustprobe\reader_probe_copy.cs`. Readings: `C:\CE_WORK\scratch\trustprobe\reader\`.

