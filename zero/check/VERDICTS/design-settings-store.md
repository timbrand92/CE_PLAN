# Answer: design\SETTINGS_STORE.md at f0bf88e (one source for every setting; TOLERANCE.md folded in)

**Answer: FIX THE PAGE FIRST, on four short edits.** Both readers say fix first, and they found different faults. Written Sat 21 Nov 2026, about 4:24 am, by reading only.

**Who read it:**
- **Honest reader:** one Claude helper on Opus, started before D-440. Report: `C:\CE_WORK\check\reports\sspage_honest_REPORT.md`. It asks for one edit.
- **Adversarial reader:** Codex gpt-6.2-astra. Report: `C:\CE_WORK\check\reports\sspage_adv_REPORT.md`. It asks for three edits.

**What holds:**
- All eight failing routes are answered, and both readers quote the page for each: the literal 5, `cover_margin_mm`, the 5 mm method default, the four Job-edit uses, the 17 mm older pipe note, the mislabelled office row, the over-limit entry, and the "unused pipe 1" stop.
- The page names one holder, with a small fixed way for a tool to ask it.
- The source test works by meaning.
- The refusals hold: a missing or mislabelled row stops the tool, a record not ours is never written, units are refused, saving happens on OK inside one Undo, and WBLOCK is covered.
- Every acceptance figure is right when worked by hand.

## The edits

1. **The figure a window shows comes from the checker** (honest reader). In "Tolerance and the Levels window" item 2, add:
   - the checker returns, with every result (a verdict or "Cannot check yet"), the tolerance and the source it used;
   - Pipe and Levels print their grey line from that, and nothing else;
   - the editor's preview shows only the typed entry, never a verdict;
   - the checker takes no tolerance argument.

   Plant a fault: a window line taken from the editor's unsaved figure must fail the source test.
2. **The source test has a written allow-list** (adversarial reader; lines 65-66).
   - **What to add:** list each permitted origin and use with its reason, and reject any definition or read that does not match an entry.
   - **The planted fault to add:** a read of the right type but from the wrong drawing or the wrong setting must fail. A pipe 10 mm short must stay Wrong in a drawing set to 5 mm, even with another drawing set to 11 mm open.
3. **Missing figures use the rounding page's forms** (adversarial reader; line 37):
   - an unknown pipe grade is omitted;
   - an unset surface cover is omitted;
   - an unknown pit cover prints "CL TBC".

   This matches ROUNDING.md at 5a77b22 and D-413 item 3.
4. **The distance limit covers every distance setting** (adversarial reader; line 45). Apply D-425 to every distance setting in its declared unit, the pit drop included. Zero stays allowed for the tolerance (D-350).

## For Tim (designer's calls, to be marked DRAFT on the page)
1. **Units:** whole millimetres only.
2. **The cap:** the 10,000 mm upper limit on the tolerance.
3. **Resetting:** "Back to office values" keeps settings it does not recognise.

## Follow-ups (none holds the page)
1. **The list of settings:** the 16 named settings still need reconciling with every shipped definition. The two mask factors, the no-plot layer name and the draft sump row were found earlier.
2. **Edge values:** write the expected results for 0, 10,000 and 10,001.
3. **The AutoCAD proof list:** add a plain copy and paste between drawings.
4. **Office changes:** add a case where a drawing with no saved value follows an office change.

**Next:** the page's writer makes the four edits. The check room reads them back alone, because the page's own open list is short.

---

# Second answer: the page at 0ce96da (the four edits read back)

**Answer: BUILD FROM IT.** Written Sat 21 Nov 2026, about 4:47 am. The check room read it back alone, by reading only. The change from f0bf88e is one file, 34 lines in and 10 out, with a "Changed since f0bf88e" list at the top.

1. **The window figure:** the checker takes no tolerance argument. It reads the tolerance of the drawing that owns the part, and every result, "Cannot check yet" included, carries the figure and source it used. Pipe and Levels print only that. The editor's preview shows only the typed entry. Planted case 7, the unsaved 11 mm fed to the grey line, must fail.
2. **The allow-list:** nine permitted origins are written out, each with its use and reason. Any read that does not match on origin, owning drawing, setting, kind, unit, operation and destination fails. Planted cases 8 (the wrong drawing, 10 mm short, staying Wrong at 5 mm) and 9 (the invert gap fed to label placement, 83 mm restored) are added.
3. **Missing figures:** on the sheet, an unknown grade is omitted, an unset surface cover is omitted, and an unknown pit cover prints "CL TBC".
4. **The distance limit:** it applies to every distance setting in its declared unit. The pit drop allows 10 m and refuses 10.001 m. Zero stays allowed for the tolerance. A saved override that fails falls back to the office value with a warning.
5. **DRAFT marks for Tim:** whole millimetres only, the 10,000 mm cap, and "Back to office values" keeping unrecognised settings.

**One follow-up (it does not hold the page):** line 37 also says "other missing figures that the sheet calls for read 'TBC'". The rounding page (5a77b22, edit 6) says "TBC" appears only as "CL TBC". The build must follow ROUNDING, and the store's test list should name any other sheet figure that could be missing.

**What this means:** the settings store may be rebuilt from this page. team/settings-store-main's code is not carried as it stands.
