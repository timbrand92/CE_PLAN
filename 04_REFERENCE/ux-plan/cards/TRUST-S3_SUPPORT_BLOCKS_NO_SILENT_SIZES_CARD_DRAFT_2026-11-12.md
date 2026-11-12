# TRUST-S3: support blocks with no silent sizes

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card.
**Class:** Modify (DS, DS1, TS1, C1, C2 and their switch versions). Nothing is retired.
**Source:** the five most used Structural tools (DS 211, DS1 93, C1 60 uses in Tim's log). BUG-501, BUG-1139, BUG-437, BUG-438. Trust rule 3: guesses are never shown as facts. Step S3 of `areas\trust-plan-structural.md`.

---

## FOR TIM

**When the drawing has a member schedule, C1, C2, DS, DS1 and TS1 take their size from it without asking. Two things go wrong: the schedule has no floor, so a mark used on two floors gets the first row's size; and a size the block cannot show (a timber stud pack) is quietly drawn as the default 90 x 90 while the line on screen still names the schedule size.**

```before
First floor plan, schedule has C1 = 89 SHS (GROUND) and C1 = 75 SHS (FIRST).
Type C1: "[CE] C1: size '89 SHS' from the schedule"  -> draws 89 SHS.
Schedule has DS1 = "2 No 90 x 45 F17 KDHW".
Type DS1: "size '2 No 90 x 45 F17 KDHW' from the schedule" -> draws 90 x 90.
```

```after
Type C1: "C1 is 89 SHS on GROUND and 75 SHS on FIRST. Which? [Ground/First/Type a size]"
Type DS1: "The schedule says DS1 is '2 No 90 x 45 F17 KDHW'. The block cannot
show that size. Size? [90 x 90/...]"
One row only, and a size the block can show: no question, as today.
```

## Decisions for Tim (read these first)

1. **Same mark on two floors.** Recommended: ask, showing both sizes. Example: "C1 is 89 SHS on GROUND and 75 SHS on FIRST. Which?" OPEN.
2. **If the schedule sheet carries no floor names** (only marks and sizes). Recommended: ask whenever a mark appears twice, showing both sizes with their row numbers. Example: "C1 appears twice: row 4 = 89 SHS, row 11 = 75 SHS. Which?" OPEN.
3. **Timber stud packs on DS1 and TS1.** Recommended: ask for the block size and put the schedule's wording in the support text. Example: the block shows 90 x 90 and the label reads "2 No 90 x 45 F17 KDHW". Engineering and drafting convention: needs your word. OPEN.

## 1. What you'd see

1. **One clear row:** exactly as today. The command line names the size and where it came from.
2. **The same mark on two or more floors:** the question above, with each floor's size (decision 1).
3. **A schedule size the block cannot show:** the question above. Never a quiet default.
4. **A copied beam with a column placed on it** keeps its own links; the original beam keeps its label and its other column (BUG-1139).
5. **Support text Enter and the number question** behave as the installed fixes for BUG-437 and BUG-438 intend; this card proves them, it does not rewrite them.

## 2. The full experience

1. **Trigger:** unchanged (ribbon button or typed command).
2. **Prompts:** at most one new question, and only when the schedule cannot give one honest answer.
3. **Esc at the new question:** nothing placed, nothing written, the drawing and the schedule record exactly as they were.
4. **Undo:** one U removes one support and its text, as today (to be proven).
5. **Save and reopen:** the schedule record is unchanged by placing a support.
6. **Locked layers:** already refused with a plain line before anything is drawn (Verified, `Commands\SupportBlockCommands.cs:225-231`). Unchanged.
7. **Millimetre check:** already in place for these commands (Verified, `SupportBlockCommands.cs:216`). Unchanged.
8. **AutoCAD 2022 to 2024:** checked there too.

## 3. Settings

1. **No new switch for the questions.** Asking instead of guessing fixes a wrong result.
2. **One switch for the trial:** "Support blocks: old schedule behaviour" (off). Turns back today's first-row lookup if the questions get in the way during the trial. Removed once accepted.

## 4. What it reuses

1. **The schedule record** XCLMTXT already saves in the drawing (it keeps only included rows since the BUG-974 fix, Verified, `Services\XclmTxtService.cs:303-319`).
2. **The floor XCLMTXT already works out for each row.** Corrected 13 Nov after review: the import sets a floor on each row from the group titles (`Models\ExcelWorkbenchModels.cs:32`, `Services\ExcelMTextSourcePreviewLoader.cs:430-456`) and then drops it when the schedule is saved (`Services\XclmTxtService.cs:308-319`, `Services\MemberScheduleService.cs:16-22`). **This card keeps the floor when the schedule is saved,** so the question names the floor in most cases.
3. **The existing size question** C2 already asks when no schedule row exists.

## 5. How it gets proven

**Robot, AutoCAD 2027, on a made-up job, each with a broken twin that must fail:**

1. Schedule with C1 on two floors: C1 asks; answering First draws 75 SHS. Twin: a build that takes the first row must fail.
2. Schedule with a timber DS1 row: DS1 asks; never draws 90 x 90 unasked.
3. Schedule with one clear C2 row: no question, the right size drawn.
4. Esc at each new question: the drawing and the schedule record read back identical.
5. COPY beam B3, place C1 under the copy: B3 keeps its label and its other column.
6. BUG-437 and 438: Enter at the text question and a number at the append question both finish cleanly.

**Codex:** looks at the questions on the command line for plain words.

**Tim, about three working days:** real jobs with a member schedule. Right = every support size on the plan is one you saw or chose.

## 6. Not known yet

1. **How often XCLMTXT fails to find a floor** for a row (rows left at Unknown floor). Needs a few real schedules (Structural test set). Drawings that already hold a saved schedule have no floor stored, so they need a re-import or the row-number question (decision 2).
2. **How often a mark is reused across floors** on real jobs.
3. **Whether the installed BUG-437 and BUG-438 fixes work.** Fix installed in 1.0.121, never tested.

Written from reading Structural 1.0.126 (commit 8de95c34). Nothing here was run in AutoCAD.
