# TRUST-03: the same settings for everyone

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card and lifts the HOLD for it.
**Class:** Missing (new). Nothing is retired.
**Source:** Tim, 5 Nov: "when they use our plugin, it does random stuff for them and I can't explain why it does it". Trust rule 2: everyone runs the same thing. Earlier ruling: colleagues get Tim's exact setup. Step 3 of `areas\trust-plan.md`.

---

## FOR TIM

**Today two colleagues on the same build can get different results from the same clicks, and you have no way to see it. This card gives the office one setup that travels with each release.**

```before
A new login gets the colleague starting values, once.
Anyone who has ever saved Settings is frozen on that day's values.
Each person's last pipe size and levels are remembered and reused.
You cannot tell from your desk what a colleague is running.
```

```after
Each release carries the office setup.
On the first start after an update: "Office settings changed: 6 values. See them / Apply."
CE Health shows: "Office setup: yes" or "Office setup: no, 3 values differ".
Personal choices (theme, window positions, your folders) stay your own.
```

**Why it matters on a job:** a colleague's Pit Schedule orders pits P1, P10, P2 and yours orders P1, P2, P10. Same build, different switch. Today neither of you can see why.

**What this card does not do:**

1. **It does not decide the values.** It carries whatever you have set.
2. **It does not lock anything** (no hard blocks). A colleague can still change a value; CE Health then says they differ, and by how many.
3. **It does not change any drawing.**

## 1. What you'd see

1. **After an update, once:** a short window listing each office value that is about to change on this PC, old and new, in plain words. Two buttons: Apply and Not now.
2. **Not now** leaves the PC as it is. CE Health then reads "Office setup: no, 6 values differ".
3. **In CE Health and the version window:** one line, "Office setup: yes" or the count that differs, with a button to list them.
4. **In the support bundle a colleague sends:** the same list, so "why did it do that" starts with a fact.
5. **Nothing at all** when the office setup has not changed.

## 2. The full experience

1. **Trigger:** first start of AutoCAD after a release that carries a changed office setup. Never mid-command, never mid-session.
2. **Cancel and Escape:** same as Not now. Nothing changes.
3. **Undo:** the previous settings file is kept beside the new one, dated. One button, "Put my previous settings back", restores it exactly.
4. **Save and reopen:** no drawing is touched. Choices that are stored in a drawing (its rulebook, its paused features) stay with the drawing and are not part of the office setup.
5. **Locked layers, Xrefs:** not relevant.
6. **AutoCAD 2022 to 2024:** same window and same line. Values that only apply on 2027 are carried but have no effect there.
7. **Tim's own PC:** Tim is the source. His PC is never overwritten by the office setup; it is where the setup is made (decision 1).
8. **Remembered last-used values:** see decision 4. This is the part most likely to look random to a colleague.

## 3. Which values are "office" and which are "personal"

Proposed split, for Tim to change:

1. **Office (same for all):** every engineering and council value; every switch that changes what a tool does to a drawing; layer names; label styles; all reaches and tolerances.
2. **Personal (stays yours):** dark or light theme; window positions; your own folder paths (already kept out of the colleague file today); object snap choices; whether tips show.
3. **Per drawing (travels with the DWG):** unchanged.

## 4. Settings

1. **"Follow the office setup":** on by default. Off means this PC keeps its own values and CE Health says so.
2. **The office setup file** ships inside the release. It is made on Tim's PC by one action, "Make this the office setup", which shows the values that differ from the last one before it writes.

## 5. What it reuses

1. **The colleague starting file** that already applies office values to a brand-new login. This card extends the same idea to existing logins.
2. **The rule that keeps Tim's folder paths away from colleagues.**
3. **CE Health and the support bundle** as the places to show the result.

## 6. How it gets proven

**Robot, on test Windows logins, no real job needed:**

1. New login: after first start, every office value equals the office setup (compared value by value).
2. Login with an old saved settings file: the window lists exactly the values that differ; Apply makes them equal; personal values are unchanged; the old file is kept.
3. Not now: nothing changes; CE Health shows the right count.
4. "Put my previous settings back": the file is identical to the kept copy (file comparison).
5. Tim's login: the office setup never overwrites it.
6. A deliberately broken version that changes a personal value must fail check 2.

**Codex:** one look at the window and the CE Health line: plain words, one decision, fits without scrolling.

**Tim, about three working days:** make the office setup from your PC; confirm your own tools behave exactly as before; on a second login, open a job and confirm Edit Pit, New Pipe and the Pit Schedule behave as on yours.

## 7. Decisions for Tim

1. **Source of truth:** your PC's current values become the office setup. Recommended, and it matches your earlier ruling that colleagues get your exact setup. OPEN on the detail: do you want to review the list of about 570 values first, or only the ones that differ from what colleagues start with today?
2. **A colleague's own changes:** replaced at each release after they press Apply, with their old file kept. Recommended. OPEN (interview D1).
3. **Which finished-but-off features come on in the office setup** (interview D2): pipe ends joining within 75, labels you moved staying put, Pit Schedule in natural order, AutoCAD-style prompts with Undo, the one Checks list, Tidy's three extras, double-click to edit, label on Esc, the CE bell, pipe-size suggestions. Recommended: none come on in this step. Each joins as its own trial, one at a time, because each changes what a tool does. OPEN.
4. **Remembered last-used values:** recommended that a level is never carried from one drawing into another (the BUG-743 fault: Enter reused a cover level from a different job), and that sizes and materials may still be remembered. OPEN (interview D3).
5. **Manager's own switches** (roll back shown, update colleagues, and others): today they sit in a file on each PC that anyone can edit. Recommended: carried in the office setup too. OPEN.

## 8. Not known yet

1. What each colleague's settings file holds today. No colleague PC has been read.
2. How many of your own values differ from the colleague starting file. Your file was not read for this card.
3. Whether Structural's settings need the same treatment in this step or later. Its settings file is separate.
4. Whether any tool reads a value at start-up only, so that Apply needs a restart.

Written from reading Civil 3.0.90 and Manager 1.1.89 (commit cf059dcf). Nothing here was run in AutoCAD.
