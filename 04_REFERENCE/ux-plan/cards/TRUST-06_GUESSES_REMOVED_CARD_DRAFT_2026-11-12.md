# TRUST-06: guesses removed, Unknown shown as Unknown

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card and lifts the HOLD for it.
**Class:** Modify. Nothing is retired.
**Source:** Tim, 5 Nov: "It wildly guess what's what because of the old versions". Voice talk 6 Nov: "Unknowns are fine"; anything unrecognised shows as Unknown. Trust rule 3: guesses are never shown as facts. RULES 12.2: Unknown stays Unknown. Step 6 of `areas\trust-plan.md`.

**Engineering judgement:** every fill-in below is an engineering default. Robot and Codex can prove the behaviour; only Tim's word settles what each should be.

---

## FOR TIM

**When CE meets something it has no data for, it fills the gap and shows the result as if it were known. This card stops each fill-in and shows Unknown instead. It also stops CE reaching too far for labels.**

```before
A line on the pipe layer, no size, no label.
CE: 100 dia UPVC pipe, P3 to P4, in the Pit Schedule.
A pit with no label: becomes the next free number, lid Class C.
Metre drawing: CE looks 2 km for a pit's label.
```

```after
The same line: pipe, size Unknown, material Unknown. Schedule shows "?".
The pit with no label: number Unknown, lid Unknown, listed for you to fill.
Metre drawing: CE looks 2 m, the same real distance as in a millimetre drawing.
```

## 1. Each fill-in, what happens today, and what is proposed

1. **Pipe size "100".** Today: no recorded size and no drawn width means 100. Proposed: Unknown.
2. **Pipe size from drawn width.** Today: the width is read in drawing units, so a 0.225 wide line in a metre drawing reads as 0. Proposed: converted to millimetres first; a width that matches no pipe size in your list is Unknown, not rounded.
3. **Material "UPVC".** Today: filled by pipe type. Proposed: Unknown.
4. **Lid "Class C".** Today: taken from the Settings of whoever happens to open the drawing. Proposed: Unknown for a pit CE did not place.
5. **Pit type "grated pit", label corner, label switches.** Today: filled. Proposed: type Unknown; the label switches stay as display choices, not facts.
6. **Pit number.** Today: a pit with no label found gets the next free number. Proposed: number Unknown, shown as "?" on the check list, and never drawn on the plan until you give it one.
7. **Plastic pit rule.** Kept as you ruled (5 Sep): 350 x 350 and smaller is plastic and is not scheduled. It applies only when the size is really known.
8. **Flow direction.** Today: with no record, the order the line was drawn decides which end is upstream. Proposed: direction Unknown until inverts or a link prove it; the drawn order is offered as a proposal, with that reason.
9. **Pit invert filled from the lowest pipe.** Today: a blank pit invert takes the lowest connected pipe invert, silently. Proposed: kept, but marked as worked out from the pipes, and reported in step 5's line. (Your call, decision 3.)

## 2. Each reach, and what is proposed

1. **Pit to its label: pit width plus 2000.** Hard-coded, not adjusted for drawing units. Proposed: a Settings value in millimetres, adjusted for units.
2. **Pit to its CL and IL text: pit width plus 2500** (CDUPGRADE). Same fault, same cure.
3. **Restoring typed values by position: 200.** Not adjusted for units. Same cure.
4. **Re-attaching a pit record to a pit block: 50.** Already unit-safe, not on Settings. Moves to Settings.
5. **Label to pit: 5,000.** Already a Setting and already unit-safe. No change. When two pits are both in reach it takes the nearer and writes only to the log. Proposed: two candidates means Unknown, listed for you (decision 4).

## 3. The full experience

1. **Trigger:** wherever CE reads a drawing object it has no data for: the update inside tools, CDSYNC, CDUPGRADE, CDLINKDANGLINGPIPES.
2. **Cancel and Escape:** unchanged.
3. **Undo:** unchanged from today; this card changes what is written, not when.
4. **Save and reopen:** Unknown is stored as blank, which the record already allows. A drawing saved with Unknowns reopens with the same Unknowns.
5. **Locked layers and Xrefs:** unchanged; nothing protected is touched.
6. **AutoCAD 2022 to 2024:** same behaviour.
7. **Values already in old drawings:** a "100" written last month cannot be told apart from a real 100 dia pipe, because the record does not say where a value came from. This card cannot clean those up. From this step on, each value records its source (typed, read from a label, worked out, proposed), as cover levels already do.
8. **Downstream tools:** the Pit Schedule already shows "?" for a blank size. Others need checking before this is switched on (section 7).

## 4. Settings

1. **"Show Unknown where the drawing gives no value":** on or off. Default on. Off returns today's fill-ins for new readings. Values already written are not changed back by the switch.
2. **Four reach values in millimetres** join the existing reach section on Settings.

## 5. What it reuses

1. **The unit conversion already used for the 5,000 reach.**
2. **The reach section already on Settings.**
3. **The schedule's "?" for a blank size,** and the "unknown size stays unknown" rule already in CDRECOVERINVERTS.
4. **The source-and-date note already stored with cover levels,** as the pattern for every value.

## 6. How it gets proven

**Robot, in real AutoCAD on copies:**

1. A line on the pipe layer with no size: size and material Unknown; the schedule shows "?"; nothing reads 100 or UPVC.
2. The same job in a millimetre copy and a metre copy: identical readings, item for item.
3. A pit with a label 1.5 m away and another 30 m away, metre drawing: only the first is matched.
4. Two pits both within reach of one label: Unknown, listed, not attached.
5. A pit with no label: number Unknown; no number is drawn.
6. Save, close, reopen: the same Unknowns.
7. A deliberately broken version that fills "100" must fail check 1.
8. All test-set jobs: zero invented values against the written answers.

**Codex:** looks at how Unknown shows in the schedule window, Edit Pipe, Edit Pit and on the plan.

**Tim (engineering judgement), about three working days:** on jobs you know, the Unknowns are the ones you would expect, and nothing you know is shown as Unknown.

## 7. Decisions for Tim

1. **Each fill-in in section 1:** Unknown as proposed, or keep a default? OPEN, one answer each.
2. **How Unknown looks on the plan:** nothing drawn until known, or a visible "?" label. Recommended: nothing drawn on the plan, "?" in the schedule window and the check list, so a "?" can never reach a council print by accident. OPEN.
3. **Pit invert from the lowest pipe:** keep as a worked-out value, or Unknown until you confirm. OPEN.
4. **Two candidates:** Unknown rather than nearest. Recommended; it is also the earlier ruling CV8-7. OPEN.
5. **Lines on a pipe layer with no CE data:** a pipe with Unknown size, or not a pipe at all until you say so? An earlier ruling (CV8-10) says layer alone is not proof. Recommended: listed as "possible pipe" in the check, not added to the record. OPEN.

## 8. Not known yet

1. **How calculations, the rule checks and the long section behave with a blank size or material.** Not traced. This must be read before the switch defaults on.
2. **How many "?" will appear on real jobs.** Step 1's numbers and the test set will show it.
3. **How many existing drawings already hold invented values.**
4. **Whether a blank lid class upsets the schedule's lid column.**

Written from reading Civil 3.0.90 (commit cf059dcf). Nothing here was run in AutoCAD.
