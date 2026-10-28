# Tim's planning changes, 29 Oct 2026 (carpark and planning intake chat)

Words in quotes are Tim's. "Interpretation" lines are the intake chat's guess and are not decisions.

## PC-01 — Settings for the automatic grade and level working

Tim: "in the cd window or cdedit window it automatically gives you a grade say i put 19.45 in for one invert it automatically gives me the closest to 1 in 100 downstream. the issue i have is there needs to be settings for this, like what is the automatic number do you set it on your own does it update the engineering invert level or is it just for the presentation?"

Facts read from the code (commit 09126560, Civil 3.0.85, not seen in AutoCAD): the worked-out end is a real level written to the pipe record, not presentation only; the fall is length / grade rounded UP to the next 10 mm (ignores the "calculated decimals" setting); minimum drop 20 mm is in Settings; no box controls the round-up. Related: AUDIT_ENGINEERING_CIVIL_2026-10-22.md, R00_CIVIL item 14.
Interpretation (guess): Tim wants every number in this working on the Settings page (R-00), and the window to say plainly whether a level is real or display only. Not yet agreed with Tim what the Settings should be.

## PC-02 — "I know one end - work the other out from the grade" to be built into the whole system

Tim: "the i know one end - work out from the other grade could be implemented far better into the whole system do you get what i mean?"

Interpretation (guess, NOT confirmed): today the option is a tick in the CD and CDEDIT windows only; Tim may want the same working wherever a level is set or a pit or pipe moves (pit move, Pit Schedule, CDPROPAGATE, long section). Question open with Tim: where does he want it to work that it does not now.

## PC-02 update (Tim, 29 Oct, later) — replaces the interpretation above

Tim: "what i meant was theres that button but then theres also the pipe grade above so it feels likes theres two points of contact and as an end suer what do you use if youve never used the program before, surely thsi can eb designed for better end user experience"

Meaning (Tim's own words, little to interpret): in the CD and CDEDIT windows the "I know one end - work the other out from the grade" button and the "Pipe grade" row both control how the levels and grade are worked out, so a new user does not know which one to use. Wants it designed better for a first-time user. The earlier guess (wire it into pit move, Pit Schedule and so on) is NOT what he meant; it is withdrawn.
Process: this is a user-facing workflow change, so it goes through the command and workflow review gate (AGENTS.md): a review with Tim, a card, his approval, before any code.

## PC-03 — Review the whole CD / CDEDIT preview and grade-and-level working before it is formally a bug

Tim: "with bug 1230 - we need to look into this entire fucntionality more overall before formally putting it in, how does it work in all situations and how it looks and feels for end user"

Meaning: BUG-1230 is held (kept as evidence, not fixed on its own). Wanted: one review of how the plan preview, the grade box, the "I know one end" choice and the worked-out levels behave in every situation (new pipe, edit pipe, upstream or downstream known, custom grade, standard grade, flat, existing levels) and how it looks and feels, together with PC-02. Not a fix yet. Interpretation (guess): this becomes one workflow card for the review gate, with BUG-1229 and BUG-1230 attached.
