# UX-OPEN-01: one line on opening that says what state a Civil drawing is in

**Status:** all three decisions answered by Tim (6 and 7 Nov). **Not built, not tested, not installed.** No code starts until Tim lifts the HOLD for it.
**Class:** Missing (new). Nothing is retired, renamed or hidden.
**Source:** Tim, 5 Nov: "it also doesn't really make it clear where the start point of the entire system is"; 4 Nov answer 15: "ONE ACTION - PROMPT ON OPENING OF DRAWING". Step 1 of `areas\V3_TRUST_PLAN_06NOV.md`.

---

## FOR TIM

**You open a Civil drawing, and one line on the command line tells you whether CE thinks it needs checking. That is all it does. It changes nothing in the drawing.**

```before
You open a job.
Nothing says what state it is in.
The hidden sync changes the record later, without a word.
```

```after
You open a job.
CE: 14 pits, 22 pipes, all linked.
or
CE: needs checking. 3 pipes not linked, 2 pits with no object. Type CDCHECKCURRENT to see them.
```

**What this card does not fix.** Be clear on this before you approve it:

1. **The hidden sync still runs** when you use a tool. That is step 5 of the plan.
2. **Pipe conversion and the pit block swap still run on opening.** So opening is not yet fully read-only. Only this line is.
3. **It does not repair anything.** It tells you the truth so that later steps can be designed from real numbers.

---

## 1. What you'd see

1. **Civil drawing, nothing to check:** `CE: 14 pits, 22 pipes, all linked.`
2. **Civil drawing, something to check:** `CE: needs checking. 3 pipes not linked, 2 pits with no object. Type CDCHECKCURRENT to see them.`
3. **Old drawing with pits but no CE record:** `CE: 14 pit blocks found, no CE record. Nothing has been changed by this check. Type CDCHECKCURRENT to see them.`
4. **CE changed something on opening:** a second line, for example `CE: pit symbols were updated when this drawing opened.` Today the pit swap says nothing. Pipe conversion already prints its own line.
5. **Very large drawing:** `CE: large drawing, not checked on opening. Type CDCHECKCURRENT to check it.`
6. **Not a Civil drawing (Structural, consultant, blank):** nothing at all, so CE stays quiet.
7. **The check itself fails:** nothing on screen except `CE: could not check this drawing.` The reason goes in the log. The drawing opens as normal.

## 2. Why not "Up to date"

The trust plan used the words "Up to date". **I recommend not using them in this first version**, because CE can't honestly know that yet:

1. No drawing stores what version made it.
2. No drawing stores a confirmed outlet, so "outlet set" would be false on every job.

"All linked" is what it can prove. "Up to date" comes back once steps 7 and 8 are in.

## 3. What gets counted

Only network facts, read from the drawing:

1. **Pipes** not linked to a drawing object, or with an end not linked to a pit.
2. **Pits** with a record but no object.
3. **Pit blocks and pipe-layer polylines** with no CE record.

**Left out on purpose:** the check's general notes, such as "No attached source drawings found". Those would make nearly every drawing say "needs checking", and you'd stop reading the line within a day.

The numbers must match what CDCHECKCURRENT shows, because it uses the same check (design rule 1).

## 4. The full experience

1. **Trigger:** the first quiet moment after a drawing opens, after CE's opening jobs finish, so the numbers describe the drawing you actually have. Once per drawing per session. Switching tabs does not repeat it.
2. **Ribbon, prompts, selection, preview:** none. It is one line, with no window.
3. **Cancel and Escape:** nothing to cancel. If a command is running, it waits.
4. **Undo:** adds no step and must not disturb Redo (BUG-256 guard).
5. **Save and reopen:** writes nothing. It must cause no "save changes?" question on close. Checked by comparing AutoCAD's changed-drawing counter before and after, which the check already does.
6. **Locked layers, Xrefs, REFEDIT:** read only, so nothing is touched. Counts cover this drawing, not attached Xrefs.
7. **Read-only files and templates:** the line still shows, as it writes nothing.
8. **Batch work and scripts:** skipped when AutoCAD has no one at the screen.
9. **AutoCAD 2022 to 2024:** same line. It needs no ribbon.
10. **Speed:** must not hold up opening. The size limit lives on Settings. **Its value is not set:** measure on real job copies first (section 7, step 1).
11. **Later:** when the CE bell is switched on, the line also goes there (UX-MSG-01).
12. **With C-80's opening question, if that lands:** the line waits for the answer. For a drawing marked Civil OFF, it stays quiet.

## 5. Settings

1. **"Say what state a drawing is in when it opens":** on or off. Default ON in the core build. **Undo: switch it off.** Nothing needs restoring, because nothing was written.
2. **"Don't check on opening above this many objects":** a number, set after measuring.

Both belong on the Settings page (R-00). Rows there are Codex's window work. Until then, they live in the settings file.

## 6. What it reuses

1. **The read-only check behind CDCHECKCURRENT.** It already avoids the sync and already confirms it changed nothing. New work is the small counting rule and the timing.
2. **The Civil or quiet decision** CE already makes on opening.

## 7. How it gets proven

**Before any code:**

1. Time the existing check on copies of real large jobs, to set the size limit. This needs AutoCAD and a free window.

**Robot, in real AutoCAD on copies:**

1. Current job copy, all linked: "all linked" line, and no change in the drawing.
2. Same job with one extra polyline on the pipe layer: "needs checking", and the count matches CDCHECKCURRENT.
3. LISP-era drawing with no record: "no CE record" line.
4. Structural drawing: no line.
5. Read-only file: line shows, nothing written.
6. Open and close with no edits: no save question from this line.
7. U then open another drawing: Redo still works.
8. A deliberately broken version that writes to the drawing must fail check 6.

**Codex:** one look, for one clean line with no software words, on a large drawing as well.

**Tim, on real jobs for about three working days:**

1. Open five real jobs you know. Right = the line matches what you know about each job.
2. Open a job you know is messy. Right = it says "needs checking" and CDCHECKCURRENT shows the same numbers.
3. Open a Structural drawing. Right = nothing appears.
4. Close a job without editing. Right = no save question from CE.

## 8. Decisions for Tim

1. **Wording:** "all linked", not "Up to date". **Agreed on the voice talk, 6 Nov.**
2. **Not a Civil drawing:** no line at all, rather than printing "Not a CE drawing". **Agreed by Tim, 7 Nov,** with this condition: "yes but some of the commands are useful in all drawings as ce tools". Read as: only the opening line stays silent. CE tools stay available on every drawing, and this card must not switch any off.
3. **Pit swap line:** also say when pit symbols were updated on opening. **Agreed by Tim, 7 Nov.**

## 9. Not known yet

1. How long the check takes on a large job.
2. Whether the opening jobs always finish before the line, on every path. A drawing just after a U delays them.
3. Whether the counts mislead on real old jobs. No real old drawing has been opened for this card.
4. Which exact items count as "not linked" on a job where pipes end at a connection point or an outlet. Those must not count as faults.

Written from reading Civil 3.0.90 (commit cf059dcf). Nothing here was run in AutoCAD.
