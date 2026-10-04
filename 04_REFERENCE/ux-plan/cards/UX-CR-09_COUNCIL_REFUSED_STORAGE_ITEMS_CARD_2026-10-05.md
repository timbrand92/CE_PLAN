# UX-CR-09: warn when a job uses a storage item the council refuses - DRAFT card (5 Oct 2026)

Class: **Missing**. Status: **DRAFT for Tim; no code; needs his answers to OPEN 1-2 before a build.**
Tim, 26 Sep 2026 (B7, decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md): "Warn, with source (Recommended)".
"Items a council refuses (e.g. Maroondah multi-cell units, driveway above-ground storage) warn with the document reference; never block."
Written by team build/03 run 26.

## Today (installed Civil 3.0.31)

1. CE records detention as storage pipes, detention pits and water tanks (CDWT). It does not record that a storage is a
   **multi-cell unit**, nor that above-ground storage sits **on a driveway**.
2. So there is nothing on a job for the warning to look at. The council side is easy (a list of refused items with source);
   the job side is the missing piece.

## Wanted (Tim's ruling, made concrete)

1. A council can record the storage items it refuses (e.g. Maroondah: multi-cell units; above-ground storage on a driveway), with its source. Empty = not recorded.
2. When the job uses one, CDCHECK shows one warning naming the item and the council document. Never blocks; nothing on the drawing changes.
3. Nothing is guessed: a storage CE cannot classify is never reported as refused.

## OPEN (Tim's call; recommendation in brackets)

1. **How does CE know a storage is a multi-cell unit?** (Recommended: a "Storage type" choice on the detention record: Pipe / Pit / Tank / Multi-cell unit / Above-ground; blank = not recorded. The engineer picks it; CE never infers it from geometry.)
2. **How does CE know above-ground storage is on a driveway?** (Recommended: the same record gets "Location: driveway / landscape / other", picked by the engineer; CE does not read hatch or surface areas for this.)

## Tests (before code)

1. Unit: a Maroondah job with a storage typed "Multi-cell unit" gives one CDCHECK warning with the source; Banyule gives none.
2. Unit: a storage with no type recorded gives no warning (never guessed).
3. Information-only list (#720): the refused-items list joins it on purpose (it changes no calculated figure).
4. Old jobs open and check exactly as before.

## What to check in AutoCAD (after install)

1. Maroondah job: set a storage's type to Multi-cell unit, run CDCHECK: one warning, council document named; drawing unchanged (DBMOD same).
2. Change the council to Banyule: the warning goes.

## Not changing

Detention volume sizing, CDCALC, the OSD criteria block.
