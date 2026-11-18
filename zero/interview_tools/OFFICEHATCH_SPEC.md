# OFFICEHATCH / OH: what it does, from Tim's answers

**Revision:** 1 (Wed 18 Nov 2026, late afternoon, Melbourne time). IDs: OH-01 onwards, never reused.
**Sources:**
1. **This tool:** TA-102 to TA-110 in `interview_tools\ANSWERS.md`.
2. **Earlier rulings:** TA-003, TA-044 to TA-063 (D-214, D-227); the hatch list in `interview_tools\HATCHES_BY_FUNCTION.md`.
3. **Picture:** the window he approved is option B on `pictures\pick_an_oh_window.html` (revision 2).

**Status:** planning only. In the first release (D-201). Hatch grips and "recreate boundary" research: R-006 and D-199.

## The window (OH-01 to OH-04)

1. **OH-01 Typed OH or OFFICEHATCH;** the full CE window opens on the last pick (TA-107, TA-044).
2. **OH-02 Left side:** the drawing around the area as AutoCAD shows it, with the area being hatched lit in rose. Below it, "where on the plan", whether this hatch is in the sheet's legend yet, and the picked hatch's layer, pattern, pen and scale.
3. **OH-03 Right side:** every hatch in the office list shown at once as a real sample, 8 across, grouped (Slabs, Walls, Existing, Sections, Civil), with a search box. No scrolling at 1920 x 1080 (TA-103, TA-106). The pick is outlined in rose.
4. **OH-04 Bottom:** the "What else changes" strip, then Inspect and Match on the left, Cancel and OK on the right, as in every CE window.

## Using it (OH-05 to OH-10)

1. **OH-05 Picking areas:** click inside each area like HATCH, as many as needed, Enter to finish; "select outline" is also offered (TA-104).
2. **OH-06 What it draws:** the hatch for the picked function, on its layer, with its pattern.
   - **Scale:** base scale x DIMSCALE / 100; DIMSCALE leads (TA-058, TA-062).
   - **Linked:** always to its outline (TA-046).
3. **OH-07 Draw order:** always behind the linework and text (TA-109).
4. **OH-08 Legend:** the first time a hatch is used on a sheet, "What else changes" offers to add its legend line, for example "DENOTES LOCATION AND EXTENT OF BAND BEAMS" with a sample. One tick, never forced (TA-108).
5. **OH-09 Editing a hatch already drawn:** double-click opens AutoCAD's own Hatch Edit, not the OH window (TA-105). This is an exception to D-061 for hatches.
6. **OH-10 When DIMSCALE changes:** hatches already drawn keep their scale; only new ones follow (TA-110). This differs from dimensions, which update (D-210).

## The list behind it

1. **OH-11 The office hatch list:** sorted by what each hatch does, with layer, pattern and base scale. It is held in one office list, so a new hatch is one line (HATCHES_BY_FUNCTION.md, D-227).
   - **Shared layers:** several functions may share one layer, as HATCH 74 does for band beam, first floor over and rain garden.
   - **Mock-up only:** the 24 functions drawn on the mock-up are the main ones. The full list includes every kept layer, including the four of unknown meaning (TA-063).

## Still open

1. **Legend wording:** the exact wording of each function's legend line is taken from the old-job legends where found. Where none was found, the wording is not known.
