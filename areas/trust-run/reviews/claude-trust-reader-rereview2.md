# Re-review 2: PR 2040 `claude/trust-reader` (trust plan step 0, the reader)

**Reviewer:** lane trust-review (tenth run), Fri 13 Nov 2026, 05:08 PC clock (written 05:05 to 05:08). **Head reviewed:** `d93ebdc0` (two commits since the last review at `222a303e`: `92d875c9`, the three misses the core-console evidence found; `d93ebdc0`, the copy carries CE's stored LPDs). **Against:** `reviews\claude-trust-reader-rereview.md` (its two "worth knowing" items) and `EVIDENCE_READER.md` FOR TIM item 5. **Four states:** Built yes (lane). Tested unit only (lane: 200 of 200 reader tests on net10 and net48; 399 with the call-graph, Redo window and LPD suites). Installed no. Accepted no.

---

## FOR TIM

1. The reader now reads the old cover and invert blocks' numbers, old "IL" text beside a pipe end, and CE's stored LPDs in both forms; a loose pipe note in other words stays Unknown and says why.
2. It still cannot write anything, and still never picks the nearer of two.
3. One caution: the new "IL beside a pipe end" reach (2.5 m along) was set to fit a made-up drawing whose layout was itself a guess, so passing it proves little until real old jobs are read.

**Verdict: GO** for the robot to keep running the reader on copies (probe P3). One small fix listed.

---

## Earlier items

1. **Stored LPDs not copied (was "worth knowing" 1): fixed.** The filler asks CE's one existing LPD reader inside its open-close read (`Services\TrustReaderFill\TrustSnapshotFiller.cs` 74, 109-123; `TrustLpdCopy.cs`). Both forms are read; both stored, damaged, a newer version or another drawing's set gives one Unknown LPD with CE's reason, never "no LPD" (`TrustLpdCopy.cs` 27-59). The compiled-filler test now walks into the LPD reader and a twin that calls the LPD writer is caught (`Drainage.Tests\Services\TrustReader\TrustLpdCopyTests.cs` 191-217); twins that drop the older form or read a conflict as "none" are caught (158-170).
2. **Model space only (was "worth knowing" 2): unchanged,** still said plainly in the filler's own note.

## The three evidence misses (`92d875c9`)

1. **Old COVER LEVEL and INVERT blocks:** a level block with exactly one plain number within 1000 mm gives it to the one pit within 2000 mm, as Proposed with the reason; two numbers, two blocks or two pits give Unknown. Never the nearer of two: confirmed by reading the rule and its "two candidates" twin.
2. **Old LISP "IL" text at a pipe end:** a new rule takes text lying beside a pipe's first or last stretch, up to 2500 mm along and 1000 mm to the side; a text a pipe end took is no longer also a pit's invert; beside two ends, Unknown. The old 1500 mm circle is unchanged for everything else.
3. **A loose "150 DIA. PIPE":** size stays Unknown and now says "text found, wording not recognised".

## Small fix (before the scorer reads damaged drawings)

1. **An LPD-only copy hides "no record" or "record unreadable".** When CE's record is missing or cannot be read but an LPD is stored, the filler now creates a record holding only the LPDs (`TrustSnapshotFiller.cs` 118-121). The reader then says "CE record format not stated" instead of "the drawing has no CE record" (`Services\TrustReader\TrustDrawingReader.cs` 154-158), and every pit is read against an empty record, so its reason can say it is not in CE's record when the truth is that the record could not be read. Fix: keep "no record / unreadable" as it was and carry the LPDs beside it, or add a plain note when the record is LPD-only.

## Caution for the controller (not a fault in the code)

1. **The 2500 mm pipe-end reach is fitted to a guess.** The evidence lane wrote the made-up old-LISP drawing with its IL texts 2200 mm from the pits and said itself "I do not know where the real old tool put them" (`EVIDENCE_READER.md` FOR TIM 5.2); the builder set 2500 mm "only to take the made-up drawing's 2200 mm with a margin" and lists it as a question for Tim. So MADEUP_OLDLISPENDS passing shows the reader agrees with the guess, nothing more. Keep it DRAFT; the measure that counts is real old jobs (the second standard test copy, 1 of 10 pits numbered, is the nearest candidate). The old LISP source is not in the repository (searched for .lsp files), so the real offset cannot be read from code here.

## What I did not check

1. Built nothing and ran no test; counts are the lane's.
2. Nothing in AutoCAD; the core-console evidence predates both commits.
3. Every line of the 1,071 changed lines: I read the product code (filler, LPD copy, the three rules' entry points) and the twins' names, not every test fixture.
