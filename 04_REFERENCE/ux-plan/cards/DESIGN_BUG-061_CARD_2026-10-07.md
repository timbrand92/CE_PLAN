# DESIGN CARD BUG-061: imported consultant pipes split into pieces (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved. Needs a drawing from you.** Nothing can be built or proven without one.

## What you would see in AutoCAD

1. On 3 Jul you saw consultant pipes come in through the Civil 3D import (CDIMPORTXCIVIL) as several short pipes, each with its own IL text.
2. Most of that was the doubled and tripled pipes, which the July import fix dealt with. That fix is still waiting for your re-import test. What may be left is a real run between two pits drawn as several pieces in the consultant's file.
3. With the fix, pieces that meet end to end with no pit between them come in as ONE CE pipe with one pair of ILs.

## What you must supply

1. **One consultant drawing where this still happens.** Use the drawing you import with CDIMPORTXCIVIL, plus the two pit numbers either side of one split run. A copy is enough, and it stays on your PC.
   - **Job:** "Smith St job, run between consultant pits 3 and 4 comes in as 3 pipes."
   - If it no longer happens since the July fix, reply "061 gone" and it is closed once you have tried one import.

## Questions

1. **Which pieces should CE join into one pipe?**
   - **Recommended:** only pieces of the same size that meet end to end in a straight line, with no pit between. At a bend with no pit, CE keeps them separate and lists the spot.
   - **Job:** a DN225 run drawn as 3 straight pieces between pits 3 and 4 becomes one 42 m pipe. A DN225 that turns 30 degrees with no pit stays as 2 pipes, with the note "bend with no pit between pits 5 and 6".

## What stays safe

1. Esc during the import brings nothing in. One import is one Undo.
2. The consultant's drawing and any Xref are only read, never changed. Locked layers in your drawing are refused in plain words.
3. The "meet end to end" distance and the straightness angle sit on the Settings page.
4. CE warns and carries on. Every join and every bend left alone is listed after the import, so you can check it against the consultant's long section.

## Once you approve

1. **Builders:** import your drawing on a copy, confirm the split run, then join the pieces at import time and add a test made from that run.
2. **Test that proves it:** import your drawing on a copy. The run between pits 3 and 4 is one pipe with one IL at each end. The bend case is listed. Import again with Replace: still one pipe, not two.

---
For builders (Tim need not read): BUG_CARPARK BUG-061 (residual chain-merge after BUG-059) and BUG-059 (round-4 fix d48f8d5, status IN PROGRESS, awaiting Tim's double-import retest). Both tolerances are new Settings values, not yet named. Do not start until the drawing arrives (build/03 run 38, build/04 run 24: "needs a test drawing from Tim").
