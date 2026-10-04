# UX-CR-08 class half: new pipes take the council's minimum class - DRAFT card (5 Oct 2026)

Class: **Missing** (CE has no pipe class today). Status: **DRAFT for Tim; no code; needs his answers to OPEN 1-3 before a build.**
Tim, 26 Sep 2026 (B6, decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md): "Default from council + warn (Recommended)".
"New pipes default to the council's minimum class; a material the council refuses warns with the source; editable."
The material half is built (draft #718, folded into #720). This card is the class half only. Written by team build/03 run 26.

## Today (installed Civil 3.0.31)

1. A CE pipe records its diameter and its material (e.g. "RCP", "uPVC") only. There is no pipe class anywhere:
   not on the pipe, not in the parts catalogue, not in the Pipe Schedule, not on the council profile.
2. So "Mornington Peninsula wants Class 3 concrete, Darebin accepts Class 2" cannot be checked or defaulted.

## Wanted (Tim's ruling, made concrete)

1. A council can record its minimum concrete pipe class (e.g. Mornington Peninsula 3, Darebin 2), with its source. Empty = not recorded, never guessed.
2. A new concrete pipe on that job starts at that class. The engineer can change it.
3. A concrete pipe below the council minimum warns in CDCHECK with the source; never blocks, never changes the pipe.
4. A non-concrete pipe (uPVC, PE) is not given a concrete class.

## OPEN (Tim's call; recommendation in brackets)

1. **Where does the class live on a pipe?** (Recommended: a new "Class" value on the pipe, shown in the Pipe Schedule only when a job uses it, so jobs without classes look unchanged.)
2. **Existing pipes on old drawings** have no class. (Recommended: show "not recorded", never assume Class 2; CDCHECK says "class not recorded" only on councils that set a minimum.)
3. **Does the class print on the drawing label?** (Recommended: not by default; a Settings tick to add it.)

## Tests (before code)

1. Unit: a council minimum class plus a new concrete pipe gives that class; a uPVC pipe gets none.
2. Unit: a Class 2 concrete pipe on a Class 3 council gives one CDCHECK warning with the source; Class 3 gives none; unrecorded class gives "not recorded".
3. Information-only list (#720): decide on purpose whether the council minimum class joins it (it changes no flow figure; recommended yes).
4. An old drawing with no classes opens, schedules and checks exactly as before.

## What to check in AutoCAD (after install)

1. Job set to a council with a minimum class; draw a new RCP pipe: Properties / Pipe Schedule show that class.
2. Change it lower: CDCHECK shows one warning naming the council document; nothing is blocked; one U undoes the change.
3. An old drawing: nothing changes on screen.

## Not changing

Pipe sizing, hydraulics, the material warning (#718), pit lid classes (a separate, existing feature).
