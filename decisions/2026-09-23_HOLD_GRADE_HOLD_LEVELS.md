# Hold grade / hold levels when a pipe end moves — Tim, 23 September 2026

**Area:** E (pits, pipes, grades). **Chat:** `pipe-points-locking-grade-invert`. **Idea:** `IDEAS_INBOX.md`, 23 Sep 2026.

## The idea, Tim's words

*"when we insert pipes if their points are moved, they should be locked to a grade or locked to an invert so that the cdpropagate and or the grade is updated automatically based on which element is locked"*

## Questions put, and Tim's answers (23 Sep 2026, morning)

1. **When a grade-held pipe's bottom level drops, what happens to the pipes downstream?**
   Offered: A ask straight away, one Undo; B carry down automatically; C leave it (today).
   **Tim:** *"1a - but its not command line it should show a preview window"*
   **Meaning:** after the move, a preview window lists every pipe the move changes, old level to new level, before anything is written. Apply writes it all as one Undo. Not a command-line prompt.

2. **When a grade-held pipe gets longer, which end stays put?**
   Offered: A top stays, bottom drops (today's behaviour); B bottom stays, top rises.
   **Tim:** *"2a"*

3. **A level typed by hand vs an automatic re-work.** Claude proposed "a level you typed by hand always wins; the grade gives way and the command line says so".
   **Tim:** *"in regards to the level i typed always wins, it needs to make sense, if i changed something i always need to confirm if the automatic number is correct or not does that make sense?"*
   **Claude's proposal is SUPERSEDED (23 Sep 2026)** by Tim's rule: nothing typed by hand is silently kept or silently overwritten. Whenever a change produces an automatic number, Tim confirms it in the preview window. Where it clashes with a number he typed, the window shows both and he picks.

## Claude's reading of the rulings (interpretation, not Tim's words — Tim to correct)

1. The preview window shows **every time** a move changes a level or a grade, including a levels-held pipe where only the grade label changes. One window per move, however many pipes it touches.
2. A move that changes no number (the whole network moved together) shows no window.
3. The existing CDPROPAGATE / Pipe Edit "Cascade Preview" window is reused rather than a new window built. Its wording and any new column (the "you typed" choice) are Codex's work under ruling B; Claude writes the contract.

## 4. What Cancel does in the preview window

Offered: A undo the move, the pit or pipe goes back (recommended); B keep the move, leave the old numbers for CDCHECK.
**Tim (23 Sep 2026):** *"answer for question is a"* — **Cancel undoes the move.** The drawing never shows a pipe whose levels do not match its length.

## Still open

1. **Building waits for the trunk to be fixed** (BUG-161): the trunk lacks the 15 Sep fix this work builds on.
