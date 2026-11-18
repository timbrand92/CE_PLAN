# OFFICETEXT / OT and the 25 / 18 text names: what they do, from Tim's answers

**Revision:** 1 (Wed 18 Nov 2026, late afternoon, Melbourne time). IDs: TX-01 onwards, never reused.
**Sources:**
1. **This tool:** TA-034, TA-111 to TA-119 in `interview_tools\ANSWERS.md`.
2. **Old code:** the old Structural text commands (`CeTextService`, read only).
3. **Old jobs:** 218 drawings from 21 old jobs in the local evidence store, read only; counts only, nothing private kept.

**Status:** planning only, in words. No window picture until the approved style arrives (D-286). In the first release (D-201).

## What today's text names do (old code)

1. **25T / 25B:** type text, pick a point, then pick a second point for the angle. The text sits on top of that line (25T) or is mirrored below it (25B).
2. **25L / 25R:** text at 45 degrees, left or right of the point.
3. **25C, 25LC, 25RC:** flat text, centred, left or right.
4. **18T, 18B, 18L, 18R:** the same at 1.8 mm.
5. **Layers and memory:** all go on 25TEXT or 18TEXT, in style STANDARD (Arial Narrow). Each remembers the last text typed.
6. **Size today:** 25 text already follows DIMSCALE (2.5 x DIMSCALE). 18 text is fixed at 180 and does not.

## What the old jobs show

1. **The office setting:** 145 of 218 drawings are at DIMSCALE 100.
2. **Sizes on the sheet, by text layer:**
   - **25TEXT:** mostly 2.5 mm, some 2.0. 22,622 texts, all 21 jobs.
   - **18TEXT:** 1.8 mm; 19 jobs.
   - **35TEXT:** mostly 3.0 mm, some 3.5; 19 jobs.
   - **50TEXT:** mostly 3.5 mm, some 5.0; 19 jobs.
   - **70TEXT:** mostly 2.5 mm, a few 7.0; 17 jobs.
3. **So the number in a text layer is the pen, not the size.** Tim confirmed this (TA-116).
4. **Capitals:** about 70% of 25TEXT is in capitals, and over 90% of the bigger text.
5. **Single-line or multiline:** both, about equally.
6. **Style:** STANDARD with Arial Narrow, the same as CLEAN sets.

## The new text tools

1. **TX-01 The quick names stay:** 25T, 25B, 25L, 25R, 25C, 25LC, 25RC, 18T, 18B, 18L, 18R, typed as today, single-line as today (TA-034, TA-115, TA-119).
2. **TX-02 OFFICETEXT / OT:** the text window (TA-111). In it:
   - **Size:** 1.8, 2.0, 2.5, 3.0, 3.5, 5.0 or 7.0 mm on the sheet (TA-117).
   - **Pen layer:** 18TEXT, 25TEXT, 35TEXT, 50TEXT or 70TEXT, chosen separately from the size (TA-116).
   - **Side and angle:** top, bottom, left, right or centre, and the angle.
   - **Last text:** remembered.
   - **Kind:** always multiline, so a second line is just Enter (TA-119).
3. **TX-03 Every size follows DIMSCALE:** sheet height x DIMSCALE, for all sizes including 1.8 (TA-112). This fixes today's 18 text, which is five times too big at 1:20.
4. **TX-04 Side of a line:** text goes on the side with less in the way. Typing 25T or 25B still forces a side (TA-114). The joint labels (CJ / SSC) use the same rule (TA-025).
5. **TX-05 Capitals:** as typed, never forced (TA-118).

## Still open

1. **Default pen for each size,** for example whether 2.5 mm text starts on 25TEXT. It has not been asked; the old jobs suggest 25TEXT for 2.5 and 18TEXT for 1.8.
2. **The window's look:** waits for the approved style (D-286).
