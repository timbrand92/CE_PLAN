# Review: PR 2096 `claude/trust-support-link-says-saved` (BUG-1414: a support says "linked to nearby beam" when the link was not saved), head `e4369378`

**Reviewer:** trust-review helper. **Written:** Fri 13 Nov 2026, 23:48 PC clock. **Base:** `claude/trust04-base-struc-1.0.126` = `8de95c34` (installed Structural 1.0.126); one commit on top. `SupportBlockCommands.cs`, `BeamLinkService.cs` and `BeamLinkService.Persistence.cs` at the PR's parent are byte-identical to `8de95c34`. Draft, auto-merge off. Read only: no build, no test run, no AutoCAD. **Lane that owns the branch:** trust-core-ribbon (its Structural standing refill, 12:04 line: built, 309 tests). Note: the commit message itself still says "NOT BUILT YET, local".

**Chosen because:** a wrong fact shown to the drafter. "Linked" when it is not means a later beam move leaves the support behind, silently.

**Verdict: FIX FIRST.** The fault is real and the change stops the support line saying "linked" when the save fails. But (1) the AutoCAD check written for it will not make the save fail on a beam CE drew, so the robot would report a false result; (2) the new line sends the drafter to BEAMLINKMIGRATE, which still reports links it did not save, the same fault; (3) "try again" is not true while the beam's layer stays locked.

---

# FOR TIM

1. **The fault is real.** Place C1, C2, DS, DS1 or TS1 at a beam end. If CE cannot save the link, today it still prints "Support linked to nearby beam.", and the support will not follow when the beam is moved.
2. **What this change does:** in that case the line now says the link could not be saved, the support is not linked, and to run BEAMLINKMIGRATE. A normal beam: the same line as today. Nothing placed changes.
3. **Why it is not ready:** the planned test (lock the beam's layer, place C1) will most likely still say "linked" on any beam CE drew, and that "linked" would be true. CE writes the link store into each beam when it is drawn, and locking a layer does not stop CE adding to that store. The test needs a beam CE has never linked, for example a plain line drawn on layer BEAM.
4. **The advice leads into the same fault:** BEAMLINKMIGRATE counts "supports attached" without checking the save worked. On the same locked beam it would claim success.
5. **The most likely real cause is a locked beam layer,** so the line should name the layer and say to unlock it first.

---

# Findings (file and line at `e4369378` unless marked `8de95c34`)

## 1. Is the fault real in the installed code, and by which path

1. **Confirmed by reading, three levels deep.** `SupportBlockCommands.InsertSupportBlock` (`8de95c34` 410 to 411) prints `SupportLinkResultLine(linked, ...)`, where `linked` is `TryLinkSupportToNearbyBeam`'s answer. That routine returns true as soon as a beam end is within reach and it has called `RegisterBeam` and `RegisterAttachment` (`8de95c34` `BeamLinkService.cs` 416 to 420). Both are `void`, and their write, `WriteBeamLinkData` (`8de95c34` `BeamLinkService.Persistence.cs` 52 to 65), catches any failure and only logs it. So a failed save still prints "Support linked to nearby beam."
2. **When the save really fails.** The write opens the beam itself for change only when the beam has no extension dictionary yet (`BeamLinkService.Persistence.cs` 184 to 189, `ent.UpgradeOpen()`). On a locked layer that open is refused (the ObjectARX guide: "Entities on a locked layer cannot be ... opened for the write() function"). Once the beam has its store, the write opens only the store's dictionary and record (200 to 205, 312 to 320), not the beam. The guide's refusal covers entities, so a locked layer most likely does not stop it (not proven in AutoCAD).
3. **Every beam CE draws already has its store.** The BEAM tools call `RegisterBeam` when the beam is placed (`Commands/BeamPlacementCommands.cs` 695), and linking is ON by default (`Models/UserSettings.cs` 523, Tim's INT-078). So the save fails, in practice, on beams CE never linked: a line drawn by hand on layer BEAM or BEAM LOWER (both accepted as beams, `BeamLinkService.cs` 406 to 411), a beam from an older drawing, or one drawn with linking switched off. Their layer must be locked. A full link record (the codec's size limit) is the other way, and is rare.

## 2. Does the fix close it on every path

1. **The support line: closed.** The write now reports its result (`TryWriteBeamLinkData`, `Persistence.cs` 55 to 70). `RegisterBeamCore` and `RegisterAttachmentCore` pass it on (`BeamLinkService.cs` 59 to 103, 119 to 167). `TryLinkSupportToNearbyBeam` sets `linkNotSaved` when the attachment was not written (441 to 443), and the command picks the new line (`SupportBlockCommands.cs` 410 to 411, 423 to 433).
2. **Skipping the attachment when the beam step failed** (`beamSaved && ...`, 442) is safe by reading. Every way the beam step fails (no beam, or the same beam's store cannot be written) would make the attachment step fail too.
3. **Not closed: BEAMLINKMIGRATE,** the tool the new line sends the drafter to. It calls the old `void` `RegisterBeam` and `RegisterAttachment` and counts each call as done (`Commands/BeamLinkMigrateCommand.cs` 164 to 180). It then prints "N beams registered ... N supports + N labels attached" (191). On the same locked, never-linked beam it would report one beam registered and the support attached, with nothing saved. It also treats any beam that already holds one attachment as "already linked" and skips it (119 to 128), so a beam whose second support failed is never retried. See fix item 2.

## 3. Nothing written on Cancel/Escape; locked layers and Xrefs

1. **Cancel and Esc unchanged.** Linking runs only after the support is placed and its rotation and label are accepted. Esc earlier takes the support back out and ends the command before the link step (`SupportBlockCommands.cs` 344 to 403).
2. **Locked layers respected.** The support and its label layer are checked before anything is placed (222 to 231); CE never unlocks anything. A beam on a locked layer is never opened for change (the open is refused, and the refusal is now reported). Writing into the store of a locked beam that already has one is AutoCAD-permitted, not a workaround.
3. **Xrefs:** the beam search walks only the drawing's own Model space (`BeamLinkService.cs` 374 to 434); a beam inside an Xref is not a candidate.

## 4. One code path per behaviour

1. **Good inside the service:** the work lives once in the new `...Core` methods; the old public `RegisterBeam` and `RegisterAttachment` keep their linking-switch check and call them (50 to 55, 111 to 116).
2. **A second "linked" report remains:** BEAMLINKMIGRATE's own counting (section 2 item 3).

## 5. Settings and hard-coded values

1. **No new setting.** The reach comes from the existing `Beams.MigrateSupportEndpointTolerance` (default 250, unchanged); linking from the existing `LinkingEnabled` (default ON). No engineering value changed.

## 6. Wording the drafter sees

1. **Plain and true about what happened:** "A beam was found nearby, but CE could not save the link, so the support is not linked and will not follow the beam if it moves."
2. **Not true about what to do next.** "Run BEAMLINKMIGRATE to try again" (`SupportBlockCommands.cs` 429) fails again while the beam's layer is locked, and today BEAMLINKMIGRATE would then claim it worked. See fix items 2 and 3.
3. **The other three lines are unchanged,** checked against `8de95c34`.

## 7. Tests

1. **Real in part.** The line tests call the shipped `SupportLinkResultLine`. The other two tests are text searches of the code (`Bug1414SupportLinkSavedTests.cs` 38 to 72). All four fail on the base (the method and the strings do not exist), but none runs a failed save.
2. **The AutoCAD check as written gives a false result** (section 1 items 2 and 3). See fix item 1.
3. **Only AutoCAD can prove (robot, copies only):** (a) draw a plain LINE on layer BEAM, lock BEAM, place C1 at one end: the "could not save the link" line, and BEAMLINKDEBUG on the line says it has no link data; (b) broken twin: (a) on Structural 1.0.126 prints "Support linked to nearby beam."; (c) control: a beam drawn with CE's BEAM tool, BEAM locked, C1 at its end: "Support linked", and BEAMLINKDEBUG on that beam lists the C1 attachment, so "linked" is true; (d) an ordinary unlocked beam: "Support linked", and moving the beam carries C1.

## 8. Risk to normal use

1. **Low.** The routine's true/false answer means the same as before. An ordinary beam gets the same line and the same saved link. Only the failed-save case prints differently.

---

# FIX FIRST

1. **Correct the AutoCAD check, everywhere it is written.** It must use a beam CE has never linked (a plain LINE on layer BEAM, or a beam drawn with beam linking switched off), not a beam CE drew. Add the 1.0.126 broken twin and the CE-beam control (section 7 item 3). Places: the PR body "Check in AutoCAD"; `REGRESSION_LOG.md` items 5 and 6; the summary comment in `Bug1414SupportLinkSavedTests.cs` 9 to 12; in CE_PLAN, `PENDING_TESTS.md` 13 Nov Structural section item 3 and the BUG-1414 "Steps to confirm".
2. **`Commands/BeamLinkMigrateCommand.cs` 161 to 191: count only what was saved,** or stop pointing the drafter at it. Count from `RegisterBeamCore` and `RegisterAttachmentCore` (now available) and add a "not saved" count to the summary line. Either let a beam with a missing support be retried (119 to 128), or have the support line say BEAMLINKMIGRATE will not fix that case. Simplest alternative: take "Run BEAMLINKMIGRATE to try again" out of the new line.
3. **`BeamLinkService.cs` 441 to 443 and `SupportBlockCommands.cs` 423 to 433: name a locked beam layer.** When the attachment was not saved, read whether the beam's layer is locked, with the existing `LayerService.FirstLockedLayer` (read only). If it is, say for example: "[CE] A beam was found nearby, but its layer BEAM is locked, so CE could not save the link. The support is not linked and will not follow the beam. Unlock BEAM, then run BEAMLINKMIGRATE." Keep the general line for any other cause.

# Small, before Codex or merge

1. **`BeamLinkService.cs` 339 to 348:** two summary blocks are stacked; the first still says "Returns true if linked", now untrue (it means "a beam was found"). Merge them into one.
2. **Commit `e4369378` message** says "NOT BUILT YET, local" while the PR body says built with 309 tests; say which is current.
3. **After a failed save the transaction is still committed** (`RegisterBeamCore` 93 to 95, `RegisterAttachmentCore` 156 to 158), so a half-made empty store can be kept. Same as today; harmless by reading.
4. **A failure in the search itself** (outer catch, 446 to 451) still prints "No beam found nearby" even if a beam was there. Not "linked", so outside this bug.

# Could not verify

1. The build and the 309 tests (no build or test run, by rule).
2. That AutoCAD 2027 lets CE add to the store of a beam on a locked layer. By the ObjectARX guide's entity rule, likely yes; the control case (c) settles it.
3. Whether the beam-move follower needs anything besides the beam's stored record to carry the support (not traced; the robot's case (d) covers it).
