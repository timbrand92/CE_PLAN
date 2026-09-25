# Structural beam commands: fix card (DRAFT for Tim, 25 Sep 2026)

Made by the release chat after Tim's message of 25 Sep about 13:20: *"with structural module can you looking into the beam commands, it always fails and always works terribly in multiple ways"*.

This card is based on a read-only investigation of the installed code (Structural `1.0.74+8c077569`), every Codex test report and the bug carpark. Nothing here is built, installed or Tim-accepted. The connected-framing card (`STRUCTURAL_D1_CARD_DRAFT_2026-09-24.md`) stays separate and is still due for Tuesday.

## 1. What goes wrong today, and why

1. **Every beam failure says the same thing.**
   - When commands `1`, `2`, `4`, `5` or `BDL` cannot place a beam, the screen always says *"Beam not placed. Nothing was drawn. Try the command again."*, whatever the reason. That wording was introduced 23 Sep (STRUC-BEAM-WORDS-01) to hide a cryptic code, but it hides the reason too.
   - The real reason goes only to a hidden log file (`%APPDATA%\TIM_CE_CADTOOLS\logs\ce_struc_structured_<date>.log`).
   - This is why it feels like "it fails in multiple ways": several different problems all look identical on screen. **Proven** (code and log).
2. **The same-looking beam commands run on two different engines.**
   - `1`, `2` and `4` use the newer, careful placement: they look at nearby walls and Xrefs and remember which supports the beam sits on.
   - `5` and `BDL` use the older, simpler logic. They do not remember supports; that linking has been switched off since 3 June.
   - So beams behave differently depending on which button you pick. **Proven** (code).
3. **Edit Steel/Timber Section (`SBEAMEDIT`) says "Unknown command".** **Proven** (Codex pass 7). Fixed in Structural 1.0.75, which is due on your PC tonight.
4. **Very large or Xref-heavy drawings can still refuse.** The newer engine stops looking after a set number of nearby objects. The limit was raised 16 times over after a field failure, but it is still a hard stop, and it then shows the same generic message. **Suspected**: the test drawings are too small to reach the limit.
5. **Beams do not behave as connected framing yet.** There are no proper beam grips. Moving a column does not drag the beam ends. COPY drops the label and supports. The beam schedule does not know which row belongs to which beam. This is planned work, not a bug: the D1 card, due Tuesday.
6. **There is no switch to see what a beam command is doing.** Structural has a hidden diagnostic setting, but no button or command turns it on. Civil has `CDDEBUG`; Structural has no equivalent.
7. **Already fixed and installed:**
   - Ribbon buttons that did nothing (pass 6, fixed 24 Sep).
   - Labels on the wrong side for right-to-left beams.
   - Misleading "Xref limit" refusals on ordinary drawings.
   - Lintel beams stopping before Preview.
   - A lintel refusing when no inside-of-building point was set: CE now asks for the point once.

## 2. Proposed fixes, for Tim to choose

1. **Say why, in plain words** *(recommended)*. Every refusal gets one plain line saying what CE found and what to do next, for example:
   - *"Beam not placed: no inside-of-building point in this drawing. Pick one now, or run BSET."*
   - *"Beam not placed: this drawing has too many nearby objects for CE to check (limit 65,536). Try a smaller window, or turn off unneeded Xrefs."*

   The internal code stays in the log only, never on screen.
2. **A Structural debug switch.** Add `STRUCDEBUG` (On/Off, like `CDDEBUG`). While it is on, every beam step writes a readable trace to the command line and the log, so Codex's AutoCAD test runs can prove each cause.
3. **One engine for every beam command.** Move `5` and `BDL` onto the same placement as `1`, `2` and `4`, so every beam command checks walls and Xrefs, remembers supports and undoes in one U. This is a bigger change: do it after 1 and 2, with Codex testing each command.
4. **The object limit as a setting.** Put the nearby-object limit on the Settings page (R-00, settings-first), with today's 65,536 as the default, and state it in the message from fix 1.
5. **Connected framing:** as the D1 card, Tuesday. It is not part of this card.

## 3. How it will be proven

1. **Tonight:** Codex's AutoCAD test run on Tim's PC (on Structural 1.0.75) runs every beam command through to a placed beam, not just the first prompt:
   - `1`, `2` (ordinary and lintel), `4`, `5`, `BDL`, `8`, `BSET`/`BSETRESET`/`BSETLIST`, `BEXTEND`, `BTX`, `SBEAM`, `SBEAMEDIT`, `RCBEAM`;
   - a right-to-left beam;
   - a lintel with no `BSET` point;
   - COPY of a placed beam;
   - one U after each command.

   For every failure it captures the command line and the Structural log line.
2. **After Tim's yes to fixes 1 and 2:**
   - Build them.
   - Next Codex run: every failure must now name its reason on screen.
3. **Then fix 3:** one command at a time, each re-tested by Codex before the next.

## 4. Questions for Tim (recommended answer first)

1. **Plain reasons on screen (fix 1):**
   - (a) Yes, one plain line per reason plus what to do. *(recommended)*
   - (b) Keep the single generic message.
2. **Structural debug switch (fix 2):**
   - (a) Yes, `STRUCDEBUG` like `CDDEBUG`. *(recommended)*
   - (b) No.
3. **One engine for all beam commands (fix 3):**
   - (a) Yes, after fixes 1 and 2, one command at a time. *(recommended)*
   - (b) Only after the Tuesday D1 review.
   - (c) No, keep `5` and `BDL` as they are.
4. **Object limit (fix 4):**
   - (a) A Settings value, default 65,536, named in the message. *(recommended)*
   - (b) Leave it fixed in code.
