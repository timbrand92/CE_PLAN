# How a release reaches colleagues (draft from evidence)

**Status: DRAFT. NOT DECIDED.** Written 12 Nov 2026 from the records. Who looks after a release and how problems are reported are Tim's to decide (interview E1 to E4, all OPEN). Part of area TRUST (`areas\trust-plan.md`).

---

# FOR TIM

**Proposal in one line: a colleague release is one small change, sent by one named person, with a "what changed" line colleagues can read, and a way back that has been rehearsed.**

## 1. What the records say about releases so far

1. **Your words, 5 Nov:** "EVERYTIME I GIVE SOMEONE A RELEASE IT MAKES THEIR EXPERIENCE WORSE".
2. **Releases have been large.** The three held builds carry nine, five and several changes each.
3. **Going back a version is by hand.** The colleague pack says never to use Manager's Roll Back button, because it is not proven on a colleague's PC (BUG-441, BUG-477). It is also hidden from colleagues today.
4. **There is no working way to report a problem from inside CE.** The feedback tool saves a file; Help promises a send step that does not exist (BUG-1215).
5. **You cannot see what a colleague is running.** No colleague PC's build, AutoCAD year or settings has ever been read.
6. **The pilot colleague's folder was made on 4 Nov** one Structural version behind your PC. Per your 6 Nov answer, nothing separate is being sent.
7. **No record of colleague usage exists.** The click log is your PC only.

## 2. Proposed: what one release contains

1. **One change a colleague will notice,** or one group of fixes to a single tool. Never two tools changing at once.
2. **The office setup** as of that day (card TRUST-03), so everyone is on the same values.
3. **A "what changed" note of three lines at most,** in drafting words: what is different, what to do differently, what to report.
4. **The one-page tool note** for any tool that changed (`areas\TRUST_RULES_CHECKLIST_12NOV.md`).
5. **Nothing else.** Work that is finished but not yet through its own trial stays out.

## 3. Proposed: what must be true before it goes

1. **It has been on your PC for about three working days** on real jobs, with no lost work, no crash and nothing unexplained.
2. **The test set passed** before and after the change.
3. **The previous release is kept,** and its location is written in the release note.
4. **Going back has been rehearsed** for this kind of change, on a PC set up like a colleague's.
5. **You say "send it".** No release goes on a robot or Codex result alone.

## 4. Proposed: who does what (E1, OPEN)

1. **The keeper:** one named person per release who sends it, watches for the first two working days, and can take it back. **Recommended: you, for the first three releases,** with the release chat doing the packaging and the checks. Reason: you are the only person who knows whether what a colleague describes is a fault or the intended behaviour. After three clean releases, decide whether someone else takes it on.
2. **The release chat (Claude):** builds the package, runs the test set, writes the "what changed" note for your approval, keeps the three numbers below.
3. **Codex:** looks at what must be seen on the release build before it goes.
4. **Colleagues:** install, and report.

## 5. Proposed: how a problem comes back (E2, OPEN)

1. **One route, the one colleagues already use to talk to you.** Recommended: a message to you (Teams or in person), with the drawing name and what they did. CE's own feedback tool joins once it genuinely sends (it does not today).
2. **What a report needs, and no more:** which drawing, which tool, what they expected, what happened. A screenshot if it is something seen.
3. **What happens next, the same day:**
   1. it goes into the one bug file with the release number;
   2. you say whether it is lost work, a crash or a wrong value (stop and take the release back), or something that can wait;
   3. the colleague is told which.
4. **The drawing they hit it on** is offered to you as a new test-set job.

## 6. Proposed: going back a version (E3, OPEN)

1. **By hand, with written steps, until Manager's button has been proven on a colleague-style PC.** The steps are rehearsed once before the first release and kept with the release.
2. **Going back never touches drawings.** A drawing saved under the newer version must still open under the older one; where it would not, the release note says so before anyone installs.
3. **Who decides to go back:** the keeper, the same day, on any of the three stop faults.

## 7. Proposed: how often (E4, OPEN)

1. **No calendar.** A release goes when section 3 is true, not on a date. This matches "let's take the time".
2. **Not more than one a week,** so a colleague is never learning two changes at once and a problem can be tied to one release.

## 8. The three numbers (from the 5 Nov plan)

These replace percentages in what you are told about the core:

1. **Tools in the core.**
2. **Working days since lost work or a crash,** yours and colleagues'.
3. **Colleague problems since the last release.**

The percentages rule stays in force until you say otherwise (interview H1).

## 9. The first colleague release, specifically

1. **Contents:** the whole core at once: steps 1 to 8. This is the one release that cannot be "one small change", because the core is the product.
2. **To whom first:** one colleague, on AutoCAD 2027 (Tim's answer A3, 12 Nov). Which colleague is still OPEN, and their PC has not been read.
3. **Then:** the next colleague after two clean working days, and so on.

## 10. Not known yet

1. Which AutoCAD year each colleague uses, and what each has installed today.
2. Whether a drawing saved on the core opens cleanly on what colleagues have now.
3. Whether Manager's update route works end to end on a colleague's PC. No pass is recorded.
4. How colleagues prefer to report. Nobody has asked them.
5. Two procedure notes for publishing to the pilot and for sorting colleague support exist among the TimOS skills. They were not opened for this draft; whoever runs the first release reads them then.
