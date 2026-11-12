# Review: card TRUST-05, the hidden sync made visible (DRAFT, 12 Nov)

**Reviewer:** lane trust-review, Thu 12 Nov 2026, about 23:40. Read only. Card at `04_REFERENCE\ux-plan\cards\TRUST-05_SYNC_MADE_VISIBLE_CARD_DRAFT_2026-11-12.md`. Checked against `areas\trust-run\CODE_FACTS_13NOV.md`, the "cases every card must answer" list in `areas\trust-plan.md`, and the code where marked "checked".

---

# FOR TIM

1. **What the card would do:** CE Health, CDGRAPH, CDDIAG and the dashboard stop changing CE's record, and every other tool prints one line when it changes the record.
2. **The idea is sound, but the line as written would not show the guesses.** It counts pits and pipes added and removed, not sizes filled in as "100" or pits given a stand-in number, which is the thing you most need to see.
3. **Verdict: FIX FIRST** (five corrections to the card before you are asked to approve it).

---

## Findings

1. **FIX FIRST: the line would not show the guesses happening.** The card says (section "does not do", item 2) "The line will show them happening", but the counts it lists (section 1 item 2, section 4) are added, removed, re-attached and re-read. Nothing counts "pipe size filled in", "material filled in", "lid filled in" or "pit given a stand-in number". Checked: a blank pit number is replaced by the drawing's internal handle during the update (`ProjectDataService.Mutations.cs` 2006 at `cf059dcf`). Add those counts, worded as guesses, for example "2 pipe sizes filled as 100 (a guess)".
2. **FIX FIRST: opening the Pit Schedule writes to the record.** `CODE_FACTS_13NOV.md` A8: a blank pipe size is replaced by the drawn size and opening the schedule writes it back. A drafter thinks opening a schedule only reads. The card lists only "Pit Schedule relink". Put opening the schedule on the read-only list, or at least under the line.
3. **FIX FIRST: changes to the drawing on opening are not covered by any step before 8.** The pit symbol swap on opening replaces a block definition with no setting and no line, even when no pit is placed (`CODE_FACTS_13NOV.md` I.2). Step 5 promises "nothing changes behind your back", and the stop rule's fourth fault applies from the step that promises it. Either print one line for the open-time changes in this step, or say plainly in the card that opening still changes the drawing silently until step 8 slice D.
4. **FIX FIRST: the robot's own reading must not trigger an update.** Robot case 1 reads the stored record before and after each tool. If that read goes through any of the roughly 60 update points, the test can never fail. Name the read path (the step 0 reader, or a direct read of the stored data on a copy).
5. **FIX FIRST: when a line prints.** Some updates do not come from a tool the drafter just ran: the Inspector updates on selection, and updates are held back while a Redo is open and run later. A line printed then lands between another command's prompts, or straight after U, describing something the drafter did not just do. Rule needed: print at the next quiet moment, one combined line per burst, and say which tool caused it.
6. **Older versions keep updating silently.** A colleague still on an earlier build opens a step-5 drawing and the old hidden update runs with no line (the review's hole 5). The card should say the promise holds only where step 5 is installed, and carry the test "a step-5 drawing opened on the previous version".
7. **The "changed" baseline.** Robot case 1 and section 2.4 use AutoCAD's changed-drawing counter. CE's own open-time changes already set it, so the baseline must be taken after opening settles, or the check fails for reasons outside the tool. Note also: the BUG-1276 reminder ("Not saved for N min") will appear on drawings changed only by CE on opening.
8. **The nine real-job cases are not walked.** In particular: a read-only drawing (a tool that updates the record there cannot save it; the line should say so), and drainage inside an Xref (does any update point write to an Xref's record?). Add a short section answering the nine.

## What I did not check

1. The count of about 60 update points (one reader's count; not recounted).
2. Whether CE Health, CDGRAPH, CDDIAG and the dashboard show wrong information once they stop updating first.
3. How U treats any update (probe P2, AutoCAD only).
