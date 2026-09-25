# DETENTION-PIT-ANNOTATE workflow card — give an existing pit a real detention record

**DRAFT · awaiting Tim's approval before any code starts.** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Pass 3, family 3:
water tanks (CDWT) — 25 Sep 2026, 14:35", **UX-TANK-03**. This is the card `areas/civil-G-water-tanks-cdwt.md`
§12.4 said was needed before UX-TANK-03 could be built, and the card `docs/workflows/CV-04_CDWT_WATER_TANKS_
ONLY_ATOMIC_2026-09-13.md` said this feature needed "its own card" when it was taken out of CDWT. Draft PR
[#241](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/241) found the gap and asked for this card instead of
guessing at a build. All "today" statements below are read directly from `origin/master` at `bf57f739`
(24 September 2026) in `C:\Lisp Files\CE_ACAD_PLUGIN`, never from AutoCAD. No client name or site address
appears anywhere in this document.

## 1. What existed before 13 September, and why it was removed

1. **What it actually did.** Before 13 Sep, `CDWT` opened by asking the drafter to pick a block. If the picked
   block was an ordinary pit (not a water-tank block), the command switched into a hidden second mode
   (`TryRunDetentionPitMode`, tagged "BUG-040 R4.10" in the code, dated 21 May 2026). It asked for a Total
   capacity and a Detention volume in litres, then drew a **plain MText note** above the pit —
   `"{TAG} — {total} lt WATER TANK"`, with a second line for detention litres and a third for reuse litres when
   they were greater than zero. **That is all it did.** Reading the retired code (`WaterTankCommand.cs` as it
   stood at commit `7831f74a1cc02fe9b1192c791c51a99b5b3fe127`'s parent) line by line: it never touched the
   pit's own record. It did not set `PitData.PitType`, did not set `PitData.DetentionLitres`, did not change the
   pit's drawn footprint, and read the pit only once, to find a tag for the note. So even before 13 Sep, this
   mode never gave CDCALC, the Pit Schedule or CDINSPECTOR anything to count — Tim's 25 Sep description ("today
   it only annotates") undersells it: it did not annotate the pit's own record at all, only the drawing beside
   it. **UX-TANK-03 is not "restore the old behaviour" — the old behaviour never produced a record CDCALC could
   read, and there is no live path that does today.**
2. **Why Tim removed it.** His own words, 13 September 2026 (late evening), quoted in the CV-04 card: *"This
   command is for water tanks only … update to be water tanks only and then get details and water tank plan
   blocks from civil details folder."* The CV-04 card records the consequence directly: *"the CV4-9 'annotate
   an existing detention pit' mode is NOT in CDWT (the BUG-040 branch is retired from this command; a
   detention-pit annotation tool needs its own card)."* Commit `7831f74a` deleted `TryRunDetentionPitMode`,
   `BuildPitDetentionCalloutText` and `ResolvePitTag` outright — confirmed by `git log -S` and by a plain
   search of `origin/master`, which finds none of the three names anywhere except a retired-behaviour guard
   test and the CV-04/PR #241 documentation.
3. **What this means for today's card.** Nothing needs to be un-retired. CDWT stays water-tanks-only, exactly
   as Tim ruled on 13 Sep. This card is for a **separate, new, small command** that picks up the real need the
   old cosmetic note was trying to paper over.

## 2. Tim's intended result now

Quoted from the 25 Sep ruling, Q34: *"Real record (Recommended)."* *"'Annotate existing detention pit' gives
the pit a real detention record, so CDCALC and the drawn-versus-issued storage check count it; the pit stays
a pit."* Three things follow directly from that sentence:

1. **A real record** — not a drawn note. The pit's own `PitData` must change, the same way any other pit edit
   changes it.
2. **CDCALC and the drawn-versus-issued storage check must count it** — using the data those two already read
   today, not a new parallel field only this command understands (§4 below).
3. **The pit stays a pit** — not a water tank, not a new compound block. No `WaterTankCommand` machinery, no
   `WT` tag, no riser/dropper. This is a `PitEdit`-shaped problem, not a `CDWT`-shaped one.

## 3. What works today — Keep / Modify / Rebuild / Missing

1. **A pit becoming "Detention" already has one working, tested mechanism — Keep, for the plumbing; Missing,
   for a route into it from an existing pit.** `Services/PitScheduleBuilder.cs:90-93` and
   `Services/DetentionTwlService.cs:108-114` both decide "is this pit detention" the same way:
   `pit.PitType` containing the word `"DETENTION"` (case-insensitive substring match). Both are read by
   real, live features today — the Pit Schedule (`ViewModels/PitScheduleViewModel.Data.cs`, three call sites)
   and the ON SITE DETENTION CRITERIA drawing block (`DetentionTwlService.FindDetentionPits`,
   `StorageBelow`). **Neither check cares how the pit got that `PitType` — a pit typed "DETENTION PIT" from
   scratch by `PitCommand.cs` and a pit that started life as a grated pit and was later changed both count
   identically.** That is the literal mechanism UX-TANK-03 needs, and it already exists and is already wired
   into both places Tim named.
2. **Changing an existing pit's type is already a general capability of `PitEdit` — Keep, unverified for this
   specific conversion.** Both pit-edit windows (`Dialogs/PitDialog.xaml:122` and
   `Dialogs/PitEditWorkshopDialog.xaml:50`) bind an editable `PitType` combo box straight to the pit's type —
   the same dialog class `PitCommand.cs` uses to create a brand-new pit. `PitEditCommand.cs` already branches
   on `vm.IsDetentionPit` in at least nine places (resize deltas, block-attribute writes, annotation follow,
   readiness checks) to keep a detention pit's drawn footprint, cover text and connected-pipe snap correct
   when its detention dimensions change. **What is not confirmed anywhere in the tests or the code comments is
   that this path has ever been exercised for the specific case UX-TANK-03 needs: an ordinary pit (grated,
   solid, SPS, trench grate) with no detention dimensions at all, converted to Detention for the first time.**
   `PitData.DetentionSolidWidth`, `DetentionGratedWidth` and `DetentionYWidth` all default to `0`
   (`Models/PitData.cs:24-31`) — a pit converted this way and saved without the drafter noticing would become
   a Detention pit with a **zero storage footprint**: correctly labelled, silently worthless to the storage
   calculation. Nothing today stops that. This is the one real, verified gap in the mechanism itself, separate
   from the entry-point gap in item 3.
3. **A dedicated, discoverable "annotate this pit for detention" entry point — Missing.** There is no command,
   button or PitEdit prompt anywhere on `origin/master` that frames this as one guided action. A drafter who
   wants to do what UX-TANK-03 describes has to already know that PitEdit's ordinary Pit Type drop-down can be
   changed to "DETENTION PIT" on any pit, and then also know to fill in three width fields that default to
   zero and are not flagged as required for that combination — none of which is written down anywhere a
   drafter would see it, and none of which was true of the old CDWT shortcut it replaces (which was at least
   one visible prompt, however useless its output). CV-04's own words — *"a detention-pit annotation tool
   needs its own card"* — describe exactly this: a purpose-built front door onto a mechanism that otherwise
   already works.
4. **Storage volume is computed from geometry, not typed in — confirms the brief's premise needs correcting.**
   `ViewModels/DetentionSystemViewModel.cs:811-825` (`GetDetentionStorageFootprint`) uses
   `DetentionGratedWidth` × `DetentionYWidth` as the pit's storage footprint, combined with the pit's existing
   `CoverLevel` and its outlet invert (already on every pit, `PitData.cs:46,81`) to integrate volume below the
   system's top water level. **`PitData.DetentionLitres` — the one field that looks like "type the storage
   volume in" — is never read by this path at all.** `git grep` confirms every read of `.DetentionLitres`
   is inside `WaterTankCommand`/`WaterTankFacts` (the WT tank record), none inside `DetentionSystemViewModel`,
   `PitScheduleBuilder` or `DetentionTwlService`. **A real detention pit's storage volume is provided
   entirely by its physical footprint and levels — there is no litres field to fill in for a pit at all.**
   This card's data-capture list in §5 reflects that; a design built around "type the storage volume" for a
   pit would silently do nothing, exactly the failure mode CDCALC's own workflow card (§6) exists to stop.
5. **Orifice — not this pit's data, deliberately not duplicated.** The orifice (`OrificePitId`,
   `BaffleWallHeightMm`, `OrificeDiameterMm`) is chosen once per detention *system* on CDCALC's own Detention
   tab (`DetentionSystemViewModel.cs`), not stored per pit. This card's job is to make the picked pit a valid,
   correctly-typed candidate for that existing choice — not to ask for an orifice size itself. Asking here
   would create a second place to type the same fact, against R-00.
6. **Settings-first defaults already exist and are unused by any "convert existing pit" path — Keep, needs
   wiring in.** `Models/UserSettings.cs:587-599` already carries office defaults for exactly these fields —
   `DetentionSolidWidth "450"`, `DetentionGratedWidth "450"`, `DetentionYWidth "450"`,
   `DetentionOrientation "Solid Left / Grated Right"`, `DetentionRotation "0 deg"` — the same defaults
   `PitCommand.cs`'s brand-new "DETENTION PIT" already pre-fills from. Nothing stops this card's command from
   reading the same Settings values instead of leaving the fields at the model's raw `0` default (item 2).

## 4. The full experience

1. **Trigger — Missing, new.** Recommend a new command, not a CDWT mode (Tim: "the pit stays a pit"; CDWT is
   water-tanks-only per 13 Sep). Working name `CDPITDETENTION`, grouped on the ribbon beside `PIT`/`PITEDIT`
   (production commands, not alphabetically) so a drafter looking for "make this pit a detention pit" finds it
   next to the pit tools, not the tank tools. Naming and ribbon placement are open — §7, OPEN 1.
2. **Picking the pit — Missing, but a working precedent exists.** The retired `TryRunDetentionPitMode` used
   `PromptEntityOptions` with `AddAllowedClass(typeof(BlockReference))` and a reject message for anything that
   was not a pit block — a sound, simple pattern worth reusing for the pick prompt itself, even though its
   handler is gone. Reject anything that is not a recognised CE pit (reuse the same `BlockService.IsPitBlock`
   check the old code used). A pit that is already Detention should say so and offer to open the normal
   PitEdit dimensions instead of re-running the conversion.
3. **What data is captured — Modify (reuses existing PitData fields, does not invent new ones).**
   - The pit's `PitType` changes to include "DETENTION" (recommend the existing catalogue value
     `"DETENTION PIT"` — §7, OPEN 2, if a solid-only or grated-only site pit needs a different label).
   - `DetentionSolidWidth`, `DetentionGratedWidth`, `DetentionYWidth`, `DetentionOrientation`,
     `DetentionRotation` — pre-filled from Settings (item 3.6), shown for the drafter to confirm or correct
     against the pit actually built on site, never silently accepted at the default.
   - `CoverLevel` and the outlet invert are **not re-asked** — they already exist on the pit and already feed
     the storage-below-TWL calculation (item 3.4); this command must not offer a second place to edit them.
   - **No litres field.** Per item 3.4, typing a volume would be inert. If Tim wants a sanity figure shown
     back to the drafter ("this footprint gives roughly X m³ below a Y m TWL"), that is a *display*, computed
     the same way CDCALC computes it, never a value the drafter types and CE stores — §7, OPEN 3.
4. **Where values come from — Settings-first, confirmed against item 3.6.** Office defaults from
   `UserSettings.Options`, exactly as a new Detention pit already gets them; a council profile value only
   enters if the council rulebook workstream (separate, ongoing) ever defines a detention-pit minimum — not
   assumed here.
5. **Preview — Missing, new; matches the pattern every other CE compound-write command already uses.**
   Before/after: the pit's outline changes from its current footprint to the new detention footprint on
   screen (the same transient-preview mechanism `WaterTankCommand.Preview.cs` and `PitEditCommand`'s dry-run
   already use), its cover-text and any connected-pipe snap shown moving if the footprint changes size, and a
   one-line summary of what is about to be written ("PIT2 becomes a Detention pit: grated 450 × 450, Class C
   lids").
6. **Drawing output — Keep, reuses PitEdit's existing annotation-follow behaviour, no new drawn object type.**
   Changing a pit's type and dimensions already re-snaps its cover text and connected pipe ends
   (`PitEditCommand.cs`'s `annotDeltaX/Y` and `ReSnapLinkedPipesToPitBoundary`, confirmed already branching on
   `IsDetentionPit`). No new callout or label is drawn by this command — the existing ON SITE DETENTION
   CRITERIA block (built separately, by CDCALC — §6) is what prints the pit's contribution on the sheet, once
   the record is real. This command's only drawn change is the pit itself looking correct.
7. **Cancel / Escape — Missing, needs building, same rule as everywhere else.** Leaves the pit exactly as it
   was — no partial type change, no half-written dimensions. Matches the standing native-protection rule
   (AGENTS.md): never leaves an object in an inconsistent state.
8. **One Undo — Missing, needs building, same rule as everywhere else (CV4-15 pattern).** One accepted
   conversion is one AutoCAD Undo, covering the type change, the dimension fields and any re-snapped
   annotation together, exactly as `WaterTankCommand.Apply.cs`'s `AtomicDrawingChangeRunner` already does for
   CDWT's own atomic write.
9. **Save / reopen — Keep, already proven for every other pit field.** `PitData` already round-trips through
   save/reopen for every other pit type and field; nothing new needs proving here beyond confirming these
   five fields survive the same way (they already do for a pit created as Detention from scratch).

## 5. How CDCALC's Detention page shows it — same data model, not a new one

1. **Pit Schedule and the ON SITE DETENTION CRITERIA block will already show it correctly**, the moment this
   command writes a real `PitType` containing "DETENTION" plus non-zero footprint dimensions — both read
   `PitScheduleBuilder.IsDetentionPit`/`DetentionTwlService.FindDetentionPits`, which check `PitType` alone, no
   pipe topology, no separate flag. This is Keep-and-already-wired, not something this card's command needs
   to push data into separately.
2. **CDCALC's own Detention tab (the interactive Boyd's/storage grid) is a narrower gate — flagged, not solved
   here.** `DetentionSystemViewModel.cs:560-589` only lists a pit in that tab's working grid if it is
   **connected to a pipe already typed `PipeType.DetentionPipe`** (`connectedPitIds`, built from the system's
   detention pipe seeds) — a second, separate condition from the pit's own `PitType`. An existing on-site
   detention pit annotated by this command will show correctly in the Pit Schedule and contribute to the
   printed ON SITE DETENTION CRITERIA total immediately, **but will not appear in CDCALC's interactive
   Detention tab grid for its system unless its connected pipes are also typed Detention** — a separate,
   already-existing pipe-edit control (`PipeEdit`'s own `IsDetentionPipe`), not something this card invents.
   §7, OPEN 4, asks Tim whether this command should warn about that when it applies, or leave it entirely to
   the drafter's existing pipe-typing habit.
3. **The drawn-versus-issued storage check Tim named is a separate, already-approved workstream — this card
   feeds it, does not build it.** `04_REFERENCE/civil-D-F/DF_CALC_PROVENANCE_WORKFLOW_CARD_2026-09-25.md`
   §2 item 8 ("Warn on sheet-versus-drawing disagreement") is **Missing** on its own account, approved
   25 Sep 2026 as item 39.7, with its own build slices. Once that workstream is built, it will compare storage
   measured from the drawing (which reads exactly the same `PitType`/footprint data this card writes) against
   the last issued figure. This card does not duplicate or race that build — it only makes sure a pit
   annotated by `CDPITDETENTION` is real, measurable data by the time that check exists to read it.

## 6. Example drawings

1. **DWG-A or DWG-B (Civil):** a job with at least one existing pit (grated or solid) that is not currently
   typed Detention, sitting on a network of ordinary stormwater pipes — proves the "pick an ordinary pit, make
   it Detention" path and lets Tim see the Pit Schedule and criteria block pick it up.
2. **DWG-B:** if it already has a genuine `DETENTION PIT` created from scratch (via `PitCommand`), use it to
   confirm the annotate command correctly declines/redirects on a pit that is already Detention (item 4.2).

## 7. Automated guards vs Tim's AutoCAD checklist

1. **Automated:** a unit test proving a pit converted by this command is recognised by
   `PitScheduleBuilder.IsDetentionPit` and `DetentionTwlService.FindDetentionPits` immediately afterwards; a
   test proving the Settings defaults (not zero) are what gets written when the drafter accepts without
   editing; a test proving Cancel/Escape leaves `PitType` and every detention field exactly as read; a test
   proving one Undo removes the type change, the dimension fields and any re-snapped annotation together; a
   test proving a pit already typed Detention is refused/redirected rather than silently re-converted.
2. **Tim's AutoCAD checklist (DWG-A or DWG-B):** run `CDPITDETENTION`, pick an ordinary existing pit. **Right
   result:** the preview shows the pit's new footprint and a one-line summary before anything is written;
   Accept writes it in one step; CDINSPECTOR now shows the pit as Detention with its solid/grated/Y widths;
   the Pit Schedule lists it under Detention; open CDCALC, insert or refresh the ON SITE DETENTION CRITERIA
   block for that system and confirm the pit's footprint volume is included in the printed total. Escape
   partway through the prompts — **right result:** the pit is completely unchanged. One `U` after Accept —
   **right result:** the pit, its cover text and any re-snapped pipe ends are all back exactly as they were.

## 8. Slices — smallest first

1. **Slice 1 — the conversion itself, no new command yet.** Prove, as a headless/unit-level guard only, that
   an ordinary `PitData` with Settings-default detention dimensions is recognised everywhere `IsDetentionPit`
   is checked, and that `PitEdit`'s existing type-change path does not corrupt an ordinary pit's other fields
   when converting it. Closes the one real gap in item 3.2 before any new UI exists.
2. **Slice 2 — the guided pick-and-confirm command, one atomic write, one Undo.** `CDPITDETENTION` end to end:
   pick, preview, Accept/Cancel/Escape, as described in §4. No pipe-connectivity warning yet.
3. **Slice 3 — the pipe-connectivity warning (OPEN 4).** Once Tim answers OPEN 4, add whatever warning or
   guidance the annotated pit needs when its connected pipes are not yet typed Detention.

## 9. OPEN questions, each with a recommended answer

1. **OPEN 1 — command name and ribbon placement.** *Recommended: `CDPITDETENTION`, on the Civil ribbon next
   to `PIT`/`PITEDIT` in the same production group, not alphabetically and not under CDWT/Tanks — it is a pit
   command, and grouping it with the tank tools would recreate the exact confusion 13 Sep's ruling removed.*
2. **OPEN 2 — is `"DETENTION PIT"` the only type this command should offer, or does an existing solid-only /
   grated-only site pit need its own label?** *Recommended: offer only the existing `"DETENTION PIT"` type to
   start (Slice 2) — it is the one value every reader (`PitScheduleBuilder`, `DetentionTwlService`,
   `PitOnePageLayout`) already understands; a narrower type is a follow-up only if Tim finds a real job where
   "DETENTION PIT" alone reads wrong on the schedule.*
3. **OPEN 3 — should the command show an indicative storage volume back to the drafter before Accept, computed
   the same way CDCALC computes it?** *Recommended: yes, as a read-only preview line only ("≈ X m³ below a
   council 1.0 m TWL, once a top water level is set in CDCALC") — never a value CE stores, since the real
   figure depends on the system's TWL, which is decided in CDCALC, not here. Showing nothing risks the drafter
   thinking the conversion did not "do" anything.*
4. **OPEN 4 — when the picked pit's connected pipes are not typed Detention, does this command warn, offer to
   fix it, or say nothing?** *Recommended: warn only, name the pipes, and point at the existing `PipeEdit`
   type control — never silently retype a pipe the drafter did not ask about (native-protection rule: no
   silent reclassification of what is already on the drawing). Build as Slice 3, after Tim confirms the
   wording he wants.*
5. **OPEN 5 — does converting a pit that is already connected to a *tank's* detention litres (the WT record,
   §1 item 4) need any reconciliation, or are the two simply independent and additive, as
   `DetentionTwlService.StorageBelow`'s existing `pits + pipes + tank` sum already assumes?** *Recommended:
   independent and additive, exactly as the existing sum already treats them — no new interaction to build; a
   job may legitimately have both a WT tank and a separately-annotated detention pit in the same system.*
