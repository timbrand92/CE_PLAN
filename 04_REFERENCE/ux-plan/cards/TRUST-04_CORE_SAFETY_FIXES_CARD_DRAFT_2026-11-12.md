# TRUST-04: core safety fixes

**Status: DRAFT.** Not approved, not built as a core build, not tested, not installed. No code starts until Tim approves this card and lifts the HOLD for it.
**Class:** Modify (fixes to existing tools). Nothing is retired.
**Source:** Tim, 5 Nov: "EVERYTIME I GIVE SOMEONE A RELEASE IT MAKES THEIR EXPERIENCE WORSE". The 5 Nov loss of about 3 hours of drawing work. Step 4 of `areas\trust-plan.md`. Bugs: `BUG_CARPARK.md`.

---

## FOR TIM

**These are the faults that lose work or leave something off a drawing without telling you. They are fixed before anything else is asked of colleagues, one small piece at a time, lifted out of the held builds rather than installing those builds whole.**

**Civil, in this order:**

1. **Unsaved-work reminder (BUG-1276, Civil half).** Right = after a set time of editing without a save, CE reminds you once, in one line. CE still never saves for you.
2. **Cancelling CDFW clears stored pit inverts (BUG-650).** Right = start CDFW, press Esc before picking: every pit invert is exactly as it was.
3. **Pit Schedule leaves out plastic pits without saying (BUG-1274).** Right = the window says "6 plastic pits are not scheduled: P3 to P8", and how to include one. The plastic pit rule itself is unchanged.
4. **Pit Schedule Excel export fails in AutoCAD 2027 (BUG-1255).** Right = Export Excel opens the Windows save box and the file opens in Excel with the same rows as the window.

**Structural, after Civil:**

1. **CLEAN saves again.** Already on your PC in 1.0.126. Still owed: one run on a copy to see it save.
2. **Unsaved-work reminder (BUG-1276, Structural half).**
3. **Bracing schedule one row short, and erased braces staying in (BUG-497, BUG-498).** Overstated bracing is the dangerous direction.
4. **Roof trusses added into wall bracing totals (BUG-499).**
5. **AutoCAD crash in SBEAM (BUG-1275).**

**What this card does not do:**

1. **It does not install C-79c, C-80 or S-46.** Only the pieces above are lifted out.
2. **It does not fix every fault on a core tool.** Others go on that tool's note until their turn.

## 1. The full experience, for each fix

1. **Trigger:** unchanged. Each fix sits inside a tool you already use.
2. **Cancel and Escape:** for BUG-650 this is the fix itself. For the others, cancel must leave the drawing and the record exactly as they were.
3. **Undo:** no fix adds an Undo step of its own. The reminder never touches the drawing.
4. **Save and reopen:** the reminder never saves. The schedule note is not stored in the drawing.
5. **Locked layers and Xrefs:** unchanged.
6. **AutoCAD 2022 to 2024:** each fix is checked there too. BUG-1255 is a 2027 fault; the check on 2024 is that export still works as it did.

## 2. Settings

1. **Reminder:** on or off, and the number of minutes. Default on. The minutes value is yours to set (decision 3).
2. **No new switches for the other fixes.** A fix to a wrong result does not get an off switch.

## 3. What it reuses

1. **The fixes already written** on the held branches for BUG-1276, BUG-1274, BUG-497, BUG-498 and BUG-1275. Each is re-read and re-reviewed before it is lifted; being written is not being proven.
2. **CSV export,** which works, as the comparison for the Excel export.

## 4. How it gets proven

**Robot, one case per fix, each with a broken twin that must fail:**

1. BUG-650: read every pit invert, run CDFW, Esc, read again. Identical. Then place a floor waste and confirm inverts are still identical.
2. BUG-1274: a copy with plastic and concrete pits. The note names exactly the pits left out.
3. BUG-1255: export, then open the file and compare every row with the window.
4. BUG-1276: edit without saving past the set time. One reminder, the drawing's changed-flag untouched by CE, no file written.
5. CLEAN: run on a copy, then read the file's saved time.
6. BUG-497 and 498: add and erase braces, refresh, count rows against braces.
7. BUG-499: a plan with roof trusses and wall braces; wall totals exclude the trusses.

**Codex:** looks at the reminder, the schedule note and the opened Excel file.

**Tim, about three working days:** normal jobs. Right = no lost work, and the schedule note matches what you know of the job.

## 5. Decisions for Tim

1. **One small build or several:** recommended, the four Civil fixes go on your PC as one small safety build, after each has passed alone, and the Structural five as a second build later. Reason: installing two things one after the other means the second can wipe the first (RULES 8.5). OPEN.
2. **Is BUG-1255 a blocker for the first colleague release,** or can the core ship with CSV only and the Excel fault on the tool note? Recommended: blocker, because the schedule is the thing colleagues send to council. OPEN.
3. **Reminder time:** ALREADY DECIDED, corrected 12 Nov. Tim's decision 223 (5 Nov, `decisions\2026-10-29_TIM_ANSWERS.md`): both a "Not saved for 25 minutes" reminder AND timed backup copies of unsaved work, the copies going to the CE backup folder only, never over the drawing. This card's earlier lines ("reminder only", "recommended 15", "no file written") were wrong; the checks for this fix must expect the backup copy in the backup folder and nothing written to the drawing.
4. **Anything missing from this list** that has cost you or a colleague work. OPEN.

## 6. Not known yet

1. **BUG-1255: CORRECTED 13 Nov.** A fix is already in the build on Tim's PC (3.0.90): when AutoCAD has loaded its own copy of the Excel part, CE uses that copy. Nobody has seen it work in AutoCAD. So the job is to prove it, not write it. See `areas\trust-run\CODE_FACTS_13NOV.md` section F. The earlier line here, "No fix exists", was wrong.
2. **BUG-1276's cause is not known** for the Structural autosave that made no backup. The reminder is a guard, not the cure.
3. **BUG-1275:** whether the fix on the held branch covers the crash you hit on 5 Nov.
4. **Whether each held fix still applies cleanly** on top of what is installed. The held builds were not re-read for this card.

Written from the bug records and the 6 Nov audits. Nothing here was run in AutoCAD.
