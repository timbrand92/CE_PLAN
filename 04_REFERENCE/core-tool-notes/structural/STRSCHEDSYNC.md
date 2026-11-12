# TOOL NOTE: Push schedule edits back to the drawing (STRSCHEDSYNC)

**Core since:** not yet
**Build this note describes:** Structural 1.0.126 (installed code, commit 8de95c34)

---

## 1. What it does

1. **Takes what is typed in a CE schedule table and writes it into the blocks it came from.** You pick the table; CE goes down its rows.
2. **Bracing table:** the TYPE, LENGTH and ROTATION cells go into the brace block (its type text, its length setting and its rotation setting).
3. **Bored pier table:** the VISIBILITY cell goes into the older 450DIABPV2 pier block.
4. **Tie-down table:** nothing. The command accepts the table and does nothing.

## 2. What it changes in the drawing

1. **Brace blocks: every row is written, edited or not.** Type text, length and rotation are set from the cell text for every brace the table lists.
2. **Older bored pier blocks:** the visibility setting, from the VISIBILITY cell.
3. **The table itself is not changed,** and CE's own record of the table is not changed.
4. **It does not save the drawing.**

## 3. What it will not do

1. **Does not change a brace's layer** when you type a new TYPE. Typing B over A leaves the brace on the A layer (see section 7).
2. **Does not send typed MARK or DIA MM back** to either kind of pier. Only VISIBILITY goes, and only to the older pier block.
3. **Does not check the drawing is read-only,** unlike the other two schedule commands.
4. **Does not check for an erased brace or a locked layer** before writing (see section 7).
5. **A table CE did not make: nothing happens and nothing is printed.**
6. **Does not say what it changed or skipped.** A cell that is not a number is skipped quietly, and a block that refuses a value is skipped quietly.
7. **Does not work out which row is which from the row's contents for piers.** It trusts CE's saved row order as long as the row count has not changed (see BUG-1183).

## 4. What it asks you, and what Enter means

1. **"Select schedule table to sync: "** One pick. Anything that is not a table is refused with "Select a Table."
2. **Esc ends the command with nothing changed.** Anything other than a proper pick ends the command with nothing changed (`Services\ScheduleService.cs:358-359` (corrected 13 Nov after review `reviews\structural-tool-notes-sample.md`)).
3. **No other question and no line on success.**

## 5. When it says Unknown or "needs checking"

1. **Bored pier table, rows added or removed by hand:** it prints "The Bored Pier Schedule has had rows added or removed by hand, so CE used the HANDLE column to find each row's object. Run STRSCHEDREFRESH on it to tidy it up."
2. **The same, on a pier table printed without a HANDLE column:** "The Bored Pier Schedule has had rows added or removed by hand and has no HANDLE column, so CE could not tell which object some rows belong to and left them alone. Run STRSCHEDREFRESH on it first."
3. **That is the only check.** If rows were swapped with the same count, nothing is said (BUG-1183).

## 6. How to undo it

1. **U once should undo the sync.** All the writes sit in one change; not proven in AutoCAD.
2. **A failure part way drops the whole change** (nothing is half written) but the message is AutoCAD's own, not CE's. What it looks like is not seen.

## 7. Known faults

**Still open**
1. **BUG-1183 (HIGH, hides a wrong result):** rearrange the pier schedule rows (keeping each row's text together), sync, and two piers swap their drawn sizes with no warning. CE trusts its saved row order when the row count matches and ignores the HANDLE cell. Not seen in AutoCAD.

**New in code, no bug covers it**
1. **A sync with no edits can turn a brace again (hunt BRACE-01, 19 Oct; HIGH), narrowed 13 Nov after review:** only a brace drawn flat (within 1 degree, or the Enter default) and later turned with AutoCAD ROTATE, and only on the first sync. Braces drawn at an angle and then turned show the wrong angle in the table, but sync writes the same value back and nothing moves (`Services\BracingService.cs:1677-1681, 1706-1708`; `Services\ProjectDataService.cs:322-326`; `Services\ScheduleService.cs:750-753`). The original wording follows: A brace turned with AutoCAD ROTATE shows its block rotation in the table; sync writes that value into the rotation setting as well, so the brace turns a second time. All braces also get their length and rotation rewritten at the table's two-decimal rounding.
2. **Erased brace or locked brace layer: AutoCAD's error, nothing synced (hunt BRACE-03; MEDIUM-HIGH).** Narrowed 13 Nov after review: the error after an erased brace happens only in the same session; after save and reopen that row is skipped without a word (`Services\ScheduleService.cs:838-853`). The write has no check for either and no catch. Four braces, create, erase one, sync is enough. The same plain-line fix BUG-503 gave the refresh was not given here.
3. **Typing a new TYPE changes the text only (hunt SCHED-09; MEDIUM-LOW).** The brace stays on its old layer and plots as the old type while the schedule says the new one. A blank type is written back as A.
4. **A value the block refuses is skipped in silence.** The refusal goes only to a debug trace.
5. **Tie-down edits and typed pier marks go nowhere, with no word.**
6. **No read-only check.** The other two schedule commands refuse a read-only drawing; this one does not.
7. **Older brace blocks are not in the table,** so they cannot be synced, with no message (hunt BRACE-05).
8. **Help says nothing useful.** Its "In AutoCAD" steps read "Command-specific utility prompts" and its description is "Synchronise Schedule."

## 8. On AutoCAD 2022 to 2024

1. **Same code.** No version-specific lines were found in the schedule files. Whether dynamic block settings behave the same there is not known.

## 9. Proven by

1. **Not counted in this note.** Nothing was run in AutoCAD for it.

---

## Where this comes from

Paths are under `C:\CE_WORK\scratch\audit_struc\Modules\Structural\`.

1. **1.1, 1.2:** `Commands\UtilityCommands.cs:92-96`; `Services\ScheduleService.cs:349-380`, `725-756`.
2. **1.3:** `ScheduleService.cs:758-790` (line 788 sets `Visibility1`); `Services\BlockReferenceHelpers.cs:64-97`.
3. **1.4:** `ScheduleService.cs:369-376` (only bracing and bored pier branches).
4. **2.1:** `ScheduleService.cs:727-755` (no test that a cell was edited); `Services\ProjectDataService.cs:316-338`.
5. **2.2:** `ScheduleService.cs:786-788`.
6. **2.3:** `ScheduleService.cs:361-363` (table opened for read; no record write).
7. **3.1, 7 new 3:** `ScheduleService.cs:742-743`; `ProjectDataService.cs:318-320`.
8. **3.2, 7 new 5:** `ScheduleService.cs:762-766`; `BlockReferenceHelpers.cs:66` (a block that is not a dynamic block is skipped).
9. **3.3, 7 new 6:** `UtilityCommands.cs:92-96` has no pre-flight; compare `UtilityCommands.cs:72` and `ScheduleService.cs:193`.
10. **3.4, 7 new 2:** `ScheduleService.cs:732-735` (erased id accepted, opened for write, no catch), `780-783`, `838-853`.
11. **3.5:** `ScheduleService.cs:366-367`.
12. **3.6, 7 new 4:** `ScheduleService.cs:745-754`; `BlockReferenceHelpers.cs:79-84`.
13. **3.7, 7 BUG-1183:** `Core\Schedules\ScheduleRowLink.cs:14-36, 56-57`; `ScheduleService.cs:375, 771-789`, `661-667`.
14. **4.1, 4.2:** `ScheduleService.cs:355-359`.
15. **5.1, 5.2:** `Core\Schedules\ScheduleRowLink.cs:63-66`; printed at `ScheduleService.cs:772-773`.
16. **5.3:** `ScheduleRowLink.cs:56-57` (stale only when the counts differ).
17. **6.1, 6.2:** `ScheduleService.cs:361-379` (one transaction; dropped on an exception; no catch).
18. **7 new 1:** `ScheduleService.cs:409-410, 750-753`; `ProjectDataService.cs:322-326, 333`.
19. **7 new 7:** `ProjectDataService.cs:282-283`.
20. **7 new 8:** `Assets\Config\command-registry.json:1969-1985`.
21. **8.1:** no `#if` in `ScheduleService.cs`, `UtilityCommands.cs`, `BlockReferenceHelpers.cs`.

Checked against the installed code (Structural 1.0.126), Fri 13 Nov 2026, 03:01. Nothing was run in AutoCAD.
