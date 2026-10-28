# Tim's planning changes, 29 Oct 2026 (carpark and planning intake chat)

Words in quotes are Tim's. "Interpretation" lines are the intake chat's guess and are not decisions.

## PC-01 — Settings for the automatic grade and level working

Tim: "in the cd window or cdedit window it automatically gives you a grade say i put 19.45 in for one invert it automatically gives me the closest to 1 in 100 downstream. the issue i have is there needs to be settings for this, like what is the automatic number do you set it on your own does it update the engineering invert level or is it just for the presentation?"

Facts read from the code (commit 09126560, Civil 3.0.85, not seen in AutoCAD): the worked-out end is a real level written to the pipe record, not presentation only; the fall is length / grade rounded UP to the next 10 mm (ignores the "calculated decimals" setting); minimum drop 20 mm is in Settings; no box controls the round-up. Related: AUDIT_ENGINEERING_CIVIL_2026-10-22.md, R00_CIVIL item 14.
Interpretation (guess): Tim wants every number in this working on the Settings page (R-00), and the window to say plainly whether a level is real or display only. Not yet agreed with Tim what the Settings should be.

## PC-02 — "I know one end - work the other out from the grade" to be built into the whole system

Tim: "the i know one end - work out from the other grade could be implemented far better into the whole system do you get what i mean?"

Interpretation (guess, NOT confirmed): today the option is a tick in the CD and CDEDIT windows only; Tim may want the same working wherever a level is set or a pit or pipe moves (pit move, Pit Schedule, CDPROPAGATE, long section). Question open with Tim: where does he want it to work that it does not now.
