# Current rulings: Long section (levels along a run)

Current rulings as of 18 Nov 2026, 5:30 pm (Melbourne), from decisions D-001 to D-297. If this page and DECISIONS.md disagree, DECISIONS.md wins and this page is stale.

## What is decided now

### Name

1. **The tool is LONGSECTION, short name LG:** checked free in AutoCAD's short names and Tim's alias list (LS, PS and SEC were not) (D-196, which settled the rename asked for in D-162 and replaced LEVELS / LV of D-101).

### How levels are designed

2. **Levels work from either end:** the plug-in works whatever is not held, in whichever direction that needs (D-086).
3. **No single rule when a pit moves:** "IT DEPENDS ON THE DESIGN", inverts or grades may change upstream or down (D-016).
4. **The critical value governs the method:** a high discharge invert means checking there is enough depth to the back of the site; plenty of depth means working top down (D-017).
5. **Normally fixed on a tight site:** the council connection invert, cover levels, the top water level and the orifice; the tank outlet or charged inlet was not ticked as fixed (D-018).
6. **A house with no detention:** levels and cover only are worked out; pipe capacity is not checked (D-019).
7. **How Tim designs levels on a tight site:** "fix what is fixed, see where it fails" (D-129).
8. **When held values do not fit and a standard would have to give way:** "Nothing: tell me, I decide"; the plug-in never bends a standard itself, says how far out and shows what could be changed (D-124).
9. **Reporting a clash:** name the stretch and the amount, for example "Out by 0.06 between P4 and P1", with the held values on that stretch listed and no single pipe blamed (D-125).
10. **Today's practice:** long sections are drawn only when the council asks (D-030).

### The window

11. **The preview shows the long section AND the plan** (D-129).
12. **The long section is drawn taller, about 4 to 5 times, with a one-line plan strip:** "thats better" (D-131, D-132).
13. **The Levels window looks good** (D-162); its first test steps worked when the planning chat clicked them, and the missing feedback when a level is clicked to hold it was a fault being fixed (D-129).
14. **Brought next after the Pit and Pipe windows:** "The whole-run levels tool" (D-088).

### Added 18 Nov 2026, D-230 to D-297

15. **The preview is at the left, like every window (D-296):** "Left side, as shown (Recommended)", including Long section; its size and form are OPEN under D-297. Cover short on a run: the window says how short and lists the ways out, never a number (D-280, see LEVELS_AND_STANDARDS item 25).
16. **How a long section starts and what OK writes (D-271; planning chat's call from his rulings; his to overturn):** DQ-030 a long section is started by picking one pit or pipe of the run; DQ-031 at a fork it follows the main line and says so; DQ-033 OK writes back only held figures that changed; DQ-034 OVERTURNS the built answer: a cover level changed in the Long section window redoes that pit's cover text too (typed once, everything follows, D-171), using the Pit tool's own text rule; DQ-035 held figures reopen held and the window's own list of padlocks starts empty; DQ-036 a typed grade is never let go, and a level that disagrees shows "Out by" and changes nothing (D-124, D-125).
17. **Drawing it on the sheet (D-276; planning chat's call from his rulings; his to overturn):** DQ-037 the long section is drawn on the sheet from a "Draw on sheet" button in the LONGSECTION window, not a separate command (D-246, FP-006), built last inside that tool; DQ-038 the scale is asked each time with 1:100 across by 1:50 vertical offered first, and printed under the title; DQ-039 the single SCHED layer, as the three newest examples (to be checked against the office template when built); DQ-040 the rows of the issued council sheet are pipe size, pipe grade, design flow and velocity, invert depth, invert level, surface level and chainage, under a datum line; DQ-041 draft words are kept until the wording pass; DQ-048 with all three padlocks closed a different figure shows "Out by" and changes nothing (D-124, D-125).
18. **Working from the end the drafter types (D-277 DQ-052; planning chat's call from his rulings; his to overturn):** typing a figure at the end the run is not worked from turns the run to work from that figure; DQ-054 a crowded long section preview is drawn less tall, cards are only as tall as their lines, and nothing scrolls.

## Changed along the way

1. **LEVELS / LV (D-101, 16 Nov) was replaced by LONGSECTION / LG (D-196, 18 Nov),** after D-162 asked for "long section or something like that or pipe section".
2. **The preview as a long section only (16 Nov) became long section AND plan (D-129), then taller with a one-line plan (D-131, D-132, 16 Nov).**
3. **The planning chat told Tim "short by 0.01 at P3" (16 Nov); the worst figure was short by 0.05 at the connection (D-129).** Recorded so the wrong figure is not reused.
4. **The built answer "a cover level changed here does not redo the cover text" was overturned by D-271 DQ-034 (18 Nov; planning chat's call from his rulings; his to overturn):** typed once, everything follows (D-171).
5. **The long section drawn onto the sheet, "only partly covered", got a form by D-276 DQ-037 (18 Nov; planning chat's call from his rulings; his to overturn):** a button inside the LONGSECTION window, built last.

## Still open on this subject

1. **The long section drawn onto the sheet:** only partly covered; council asks for it sometimes (FUNCTION_MAP FM-021; SITUATIONS E9; DRAFTS_levels 16). Waits on: Tim. **Form taken by D-276 DQ-037 (planning chat's call from his rulings; his to overturn):** a "Draw on sheet" button, built last (item 17).
2. **Click a level in the long section to hold it gave no visible feedback** (fault found 16 Nov, D-129); fixed status not recorded in the decisions. Waits on: a test.
3. **CELEV2 failed in the midday run;** its check was changed to D-175 and has not been re-run (OBSTACLE_COURSE part E). Waits on: a test.
4. **When a clash stands the long section writes nothing, which loses typed work;** proposal that OK always saves (SITUATIONS F4, G6; stops a job). Waits on: Tim. **Taken in part by D-271 DQ-033 and DQ-048 (planning chat's call from his rulings; his to overturn):** OK writes back only held figures that changed, and a disagreeing figure shows "Out by" and changes nothing.
5. **Duplicate pit numbers make the long section open nothing;** proposal never to refuse (SITUATIONS D5). Waits on: the build chat.
6. **Half the levels known:** show the gaps on the long section (SITUATIONS F1). Waits on: the build chat.
7. **A long section of any length, and a made-up 40-pit job test** (SITUATIONS K1). Waits on: a test.
8. **Whether sums in any direction stay quick on a branched run with many held values:** trial 11 passed in pure code; not yet proven inside AutoCAD on a real job (THE_PLAN section 6 item 4; FOUNDATION honest limits). Waits on: a test.
9. **CONFLICT in documents, never blocks:** D-124 and D-140 say a check never blocks, while DRAFTS_levels items 11, 3 and 21 block (SITUATIONS document conflicts). Waits on: the build chat.
10. **The SCHED layer and the rows of the council sheet** are to be checked against the office template when the "Draw on sheet" button is built (D-276 DQ-039, DQ-040). Waits on: the build chat.
11. **The long section window has to show repeating rows, not four,** before first real use, since runs past four pits are normal (D-271 DQ-032). Waits on: the build chat.

**Closed (D-230 to D-297):** how a long section is started (D-271 DQ-030); the scale of a long section on the sheet (D-276 DQ-038); both taken as the planning chat's calls from his rulings; his to overturn.

## Where the detail lives

Added 18 Nov 2026: `DECISIONS.md` D-271, D-276, D-277, D-280, D-296, D-297.

1. `DECISIONS.md` D-016 to D-019, D-086, D-124, D-125, D-129, D-131, D-132, D-162, D-196.
2. `design\FOUNDATION.md`; `stage4\TRIAL_RESULTS.md` trial 11.
3. `design\SITUATIONS.md` sections E and F; `design\FUNCTION_MAP.md` FM-015, FM-019 to FM-022.
