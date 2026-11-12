# Review: card TRUST-06, guesses removed, Unknown shown as Unknown (DRAFT, 12 Nov)

**Reviewer:** lane trust-review, Thu 12 Nov 2026, about 23:45. Read only. Card at `04_REFERENCE\ux-plan\cards\TRUST-06_GUESSES_REMOVED_CARD_DRAFT_2026-11-12.md`. Checked against `areas\trust-run\CODE_FACTS_13NOV.md` and the installed code (`cf059dcf`) where marked "checked".

---

# FOR TIM

1. **What the card would do:** where the drawing gives no size, material, lid or pit number, CE shows Unknown ("?") instead of making one up, and stops looking kilometres away for labels in metre drawings.
2. **It misses about half the places that fill in values,** including one that changes invert levels (CDPROPAGATE assumes a 225 pipe), and its metre fix does not work on old drawings whose units were never set.
3. **Verdict: FIX FIRST** (the card needs the full list and three rule changes before you are asked for your engineering word on each fill-in).

---

## Findings

1. **FIX FIRST: section 1 misses fill-ins already found in the code** (`CODE_FACTS_13NOV.md` section A, written the day after the card):
   1. **CDPROPAGATE assumes 225** when a pipe has no size. That feeds invert levels, so a wrong level can be shown as fact.
   2. **Edit Pipe** fills "100" and "UPVC" in its window; pressing OK saves them. **Edit Pit** fills lid "Class C"; OK writes it.
   3. **Pipe flow calculator** keeps the last pipe's size, or 300.
   4. **Detention calculation** silently leaves a pipe with no size out of the pipe storage volume.
   5. **Copies, a pipe split and CDUPGRADE** fill 100; CDUPGRADE also fills a blank material on an existing pipe.
   6. **Plan labels** would print " DIA. UPVC PIPE" with a blank size; charged pipes and rising mains always print UPVC.
   7. **Pit Schedule** prints "0 x 0" for zero pit widths and writes the drawn pipe size back on opening.
   Section 8 item 1 ("not traced") is now partly answered by that file; update it.
2. **FIX FIRST: "Unknown is stored as blank" does not hold for pit numbers.** Section 3 item 4. Checked: every record update replaces a blank pit number with the drawing's internal handle (`ProjectDataService.Mutations.cs` 2006), and the number is also the key that identifies the pit in the record. So a pit with no number reads back as a code like "2A3F", not blank. The card needs either a separate place for the number, or a rule that the handle stand-in shows as Unknown everywhere. (The BUG-1274 branch already trips on this; see `reviews\claude-b-1274-rebuilt-on-rel-20261112a.md` finding 1.)
3. **FIX FIRST: drawings with units not set.** Checked: the existing unit-safe conversion treats a drawing with units not set as millimetres (`Services/DrawingAreaUnits.cs` 87-103, "Unitless ... assumed millimetres"). An old metre drawing with units never set, likely on LISP-era jobs, still reaches about 2 km after this card. Plan case 3 asks every card to answer this. Add a rule (say "units not set, distances assumed millimetres" in the check, or detect metre scale) and a robot case on such a copy.
4. **The pit width must be converted too.** Section 2 item 1 says the 2000 becomes a Settings value in millimetres. The pit width (stored in millimetres) is added to it, and must be converted to drawing units as well, or in a metre drawing a 600 pit still adds 600 metres to the reach.
5. **The placed Pit Schedule table.** Decision 2 aims to keep "?" off council prints, but the schedule placed in the drawing is on the print. Section 3 item 8 says the schedule shows "?" for a blank size. Say what the placed table prints, and warn before placing ("3 pipes have no size; the schedule will show ?"), never blocking.
6. **Value-source notes and older versions.** Checked: the stored record keeps fields an older CE does not know (`[JsonExtensionData]` on ProjectData, PitData and PipeData), so the new source notes survive a colleague's older build. But that older build can still fill "100" into a value this step marked Unknown, leaving the note behind, so value and note disagree. The reader must treat a disagreeing value as Proposed (source unknown); add the previous-version test.
7. **Engineering judgement is correctly flagged** (each fill-in is Tim's call). With item 1, the list Tim is asked about grows from 9 to about 16; batch it as one question set.

## What I did not check

1. How each calculation behaves with a blank size beyond what `CODE_FACTS_13NOV.md` lists.
2. How many existing drawings already hold invented values.
3. Nothing was run; the 2 km reach in a metre drawing is from the code and the 12 Nov findings, not seen.
