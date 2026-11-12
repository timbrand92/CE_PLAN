# Review: PR 2079 `claude/trust-bset-honest` (BUG-1400, BUG-1401, BUG-1403: BSET, BSETLIST and BSETRESET)

**Reviewer:** lane trust-review (thirteenth run), Fri 13 Nov 2026, 07:00 PC clock. **Head reviewed:** `c7b5902f` (one commit on `8de95c34`, installed Structural 1.0.126, confirmed). **Against:** BUG-1400, BUG-1401 and BUG-1403 and the brief (BSETRESET asks before clearing; nothing reports success when it failed). **Note on the numbers:** this run's brief called the PR "BUG-1389 to 1391". That is wrong: in the carpark 1389 to 1391 are beam tool 4/5, Enter-at-text and "remember last choices" faults. The PR's own numbers (1400, 1401, 1403) match its change and its description; reviewed against those. **Four states:** Built yes (lane: net8 and net48 clean). Tested unit only (lane: 776 beam tests on net10). Installed no. Accepted no.

---

## FOR TIM

1. BSETRESET now asks before it clears your saved inside points, names how many ("will clear 3 ... Clear them? [Yes/No] <No>"), and Enter or Esc clears nothing. On a drawing with none it says so and adds nothing.
2. BSET, BSETLIST and BSETRESET no longer say "added", "cleared" or "none stored" when CE could not save or read the points; they say it plainly.
3. BSET and BSETRESET now stop with one line on a layout tab, in REFEDIT or on a read-only drawing, like the other beam commands.

**Verdict: GO** for the robot on copies. Two small items.

---

## Findings

1. **BSETRESET asks before clearing: yes.** It reads first; if the points cannot be read it says so and clears nothing; if there are none it says "nothing to clear" and writes nothing; otherwise it asks with the count, default No, and only Yes clears (`Modules\Structural\Commands\BeamInsidePointCommands.cs` 76-112). The question goes through the beam tools' own keyword prompt, which adds no second list (`Services\BeamService.cs` 1108-1133). The clear never creates an empty record on a drawing with none (`Services\BeamInsidePointStore.cs`, `TryClear`). One transaction each: one U undoes a clear or an add.
2. **Nothing reports success when it failed: yes, for the three commands.** A failed save says "could not save ... nothing was changed" (the save's transaction is not committed); a save that worked but cannot be counted says so and points to BSETLIST; an unreadable list is never "none stored" (BSETLIST and BSETRESET); a failed clear says so (`BeamInsidePointCommands.cs` 40-55, 81-112, 133-145; `BeamInsidePointStore.cs` `TryGetAll`, `TryAdd`, `TryClear`).
3. **The stop: yes.** Both call the model-space pre-flight first (`BeamInsidePointCommands.cs` 25, 77): the read-only check, then a layout tab outside a viewport or REFEDIT (`Services\DrawingSafetyService.cs` 62-67). It reads system variables only.
4. **Words** are plain and say "Nothing was changed" where true.

## Small items

1. **The opposite mistake is still possible.** If anything after a successful save throws (the debug line, the command record), BSET's outer catch prints "CE could not store that inside-point. Nothing changed." though the point was stored (`BeamInsidePointCommands.cs` 60-62, the installed line). Not a false success; say "the reason is in the CE log; run BSETLIST to check" instead of "Nothing changed".
2. **The failure lines are hard to reach on a copy.** The bug's own step (make the drawing read-only) now hits the new stop first, so BUG-1400's lines are proven by reading only. Robot row 2 (`PENDING_TESTS.md`, Structural section) has no failure case; add one if a damaged inside-point record can be made, otherwise record "not reachable on a copy".

## Worth knowing

1. **The beam tools still read the points the old way** (`GetAll`, which returns an empty list when it cannot read). So if the points cannot be read, the lintel-mark tools still act as if none were saved, silently. That is the symptom's "marks land on the wrong side"; it is outside these three bugs. For the controller.
2. BUG-1402 (a turned UCS saves the wrong place) is untouched; the old comment "pr.Value is already WCS" is still there. The PR says so.
3. Older wording ("inside-point(s) stored", the outer catch lines) keeps the hyphen; cosmetic.

## What I did not check

1. Nothing run.
2. The point reader's behaviour on a damaged record (whether it throws or skips), which decides whether small item 2 is reachable.
