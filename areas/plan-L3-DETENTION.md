# plan-L3-DETENTION — implementation plan for "CE proposes detention and tank layout" (Level 3 proposal 3)

**Written:** Sun 4 Oct 2026, 15:40 Melbourne, by team lane build/04 (headless run 14), because none existed (plan-L3-NETWORK
section 0 item 3 and section 7 item 1 asked for it). Slice 1 was built straight after (see section 2).
**Card (read completely first):** `04_REFERENCE/ux-plan/cards/L3-DETENTION_CARD_2026-09-26.md` (APPROVED as plan, 26 Sep).
**Rulings it rests on:** UX-L3-11..14, UX-L3-19..23, UX-L3-02 (build item 3, after levels and sources), UX-L3-17
("Always 2-3 side by side"), job mode UX-MODE-01..04, CR-A3 (orifice rounds down, never below the council minimum),
UX-CR-03 (1 m implied easement band), UX-CR-10 (OSD block always shows required and provided), UX-SITE-01 (TPZ / SRZ).
**Code read (read-only):** `origin/claude/rel-20261015h` (88bf32d8, installed Civil 3.0.31).

## 0. FOR THE CONTROLLER, in six lines

1. The hydraulics exist: `Services/AutoDesignService.cs` gives ONE first-pass design (flows, Boyd's storage, orifice, one
   detention pipe, connection pipe). Options must come from it, never from a second storage calculation (design rule 1).
2. Slice 1 (built, draft PR, OFF): from that one design, 2-3 storage options side by side, each with its storage, depth
   and council check (% underground, storage provided against required). No drawing, no window.
3. This plan owns the two shared pieces L3-NETWORK waits for: the combined clash check (slice 2) and the side-by-side
   chooser with ghosts (slice 3, Codex window, ruling B).
4. **Tim must rule** the footing / service clash distances and what counts as a footing or service (card OPEN 3) before
   slice 2's footing half; the easement and tree-zone halves can start without him.
5. Learning "best" (UX-L3-22) is last (slice 7); two of its three signals need features that do not exist (RFI reader,
   issue-to-issue comparison).
6. Nothing here can be tested in AutoCAD by a builder: Codex drives section 6 on copies.

## 1. What already exists (checked on 88bf32d8)

1. **Sizing:** `AutoDesignService.Design(AutoDesignInputs)` -> `DesignProposal` (archetypes `no-detention`,
   `osd-with-orifice`; `SsrM3`, `PsdLps`, `OrificeDiameterMm`, `DetentionPipeDiameterMm` / `LengthM`). The detention pipe is
   the smallest standard size (225-600) whose run is within 40 m; both lists are constants in that file today (an existing
   R-00 gap, not widened here).
2. **Council rules:** `CouncilProfile.MinUndergroundPct` (council-profiles.json: Boroondara, Banyule, Yarra Ranges 100;
   Monash 60; Glen Eira, Bayside, Frankston, Mornington, Darebin, Manningham 50; others 0), minimum orifice, PSD ARI.
3. **Tanks:** `Commands/WaterTankCommand.cs` (CDWT, Adopt or Insert from the master library, above ground / underground W-04),
   `Rules/TankLibrary.cs`.
4. **Pit storage:** `DETENTION-PIT-ANNOTATE_CARD_2026-09-25.md` (pit detention record; `PitScheduleBuilder`,
   `DetentionTwlService`).
5. **Clash pieces:** UX-CR-03 easement band warning; `Services/TreeSiteConstraintService.cs` + `Commands/TpzCommand.cs`;
   `Services/XrefSiteGeometryService.cs` (`TpzZones`, `Easements`). Footings / services: missing.
6. **Ghosts:** `Rules/EditGhostPlan.cs` + `Services/TransientDrawableSet.cs`. Chooser: only the approved sketch.
7. **Apply:** the D+F card's Apply-to-drawing preview (orifice pit, overflow, OSD block) and `ProposalApplyService.Apply`.

## 2. Build order (one draft PR per slice; failing test first; REGRESSION_LOG entry; switch OFF throughout)

### Slice 1 — 2-3 storage options from the one design (Claude; BUILT run 14, draft)

1. **New** `Services/Proposals/DetentionOptionsEngine.cs` + `DetentionOptionsModels.cs`, pure. Calls
   `AutoDesignService.Design` once; every option shares its storage required, PSD and orifice.
2. Seed list (card OPEN 2, recommended answer): A storage pipe (the design's own pipe), B a larger storage pipe (next standard
   size up, shorter run; not offered when the design already uses the largest), C a tank holding the whole storage
   (underground; footprint Unknown until a tank is picked from the library, never an invented depth).
3. Each option: storage provided (m3) against required, depth (pipe size; tank Unknown), % underground against the council
   minimum, a difference line, and its pieces listed (run, size, length, volume: UX-L3-23 shape). A check that fails is
   shown, never hidden (R-27 warn, never block). No detention needed = no options, one line.
4. **Settings:** `detentionProposal.enabled` (false), `detentionProposal.optionCount` (3; display, UX-L3-17).
5. **Tests first:** the options share one storage figure; pipe volume = pi/4 x D^2 x L meets the required storage; a 100%
   council passes all three underground; the larger pipe is shorter; largest size already used = 2 options and why;
   no-detention site = 0 options and the line.

### Slice 2 — combined clash check (Claude)

1. **New** `Services/Proposals/SiteClashCheck.cs`, pure: one pass for a candidate footprint (pipe run or tank outline)
   against the implied 1 m council-drain band (UX-CR-03), easements, TPZ / SRZ (UX-SITE-01), and footings / services
   (Settings-held layer / block patterns, card OPEN 3; distances are Tim's). Each clash named ("Clash: tree zone T2").
2. L3-NETWORK slice 3 calls the same check; no second clash engine (design rule 1).

### Slice 3 — chooser and ghosts (Codex window, Claude ghosts)

1. Claude writes `docs/workflows/L3-DETENTION_WINDOW_CONTRACT.md` first (three panels, plan picture, figures, difference
   line, clash line, Cancel / Accept [letter], to the approved sketch).
2. Claude adds `EditGhostPlan.ForDetentionOption` and the transient draw / swap / clear; Codex builds the window. One chooser
   class, reused by L3-NETWORK.

### Slice 4 — complete system Accept, one Undo (Claude)

1. Accept writes the chosen option's pieces through the existing paths (CDWT for a tank, the pipe-drawing path per run, the
   pit-detention path per pit) and feeds the D+F card's Apply preview for orifice pit, overflow and OSD block; one
   `ChangePlan`, one Undo. Native protection: never unlock, detach or explode.

### Slice 5 — Draft banner (UX-L3-14), reusing "DRAFT - NOT FOR CONSTRUCTION" and saying which state is missing.

### Slice 6 — combination options (UX-L3-23): several pit-to-pit storage runs, detention pits and tanks totalled.

### Slice 7 — learned "best" (UX-L3-22): least pipe / depth / pits first, then issued-without-redraws, RFI last.

## 3. Settings keys (Civil user settings, `detentionProposal.*`)

1. `enabled` — bool, false. 2. `optionCount` — 3 (display). No engineering value is added by slices 1-2 except the
footing / service distances and patterns (slice 2), which wait for Tim.

## 4. Risks

1. **A second storage calculation** creeping in beside `AutoDesignService` (design rule 1). Slice 1 tests that every
   option's required storage is the design's own figure.
2. **An invented tank depth** to give a footprint: never; the tank's footprint comes from the library tank picked.
3. **Two choosers / two clash engines** (with L3-NETWORK): review checks one of each.
4. **Hard-coded pipe sizes and 40 m run** in `AutoDesignService` (existing R-00 gap): flag to the controller, not widened.

## 5. What Tim must rule (through the desk, one batch)

1. **Footing and service clash distances, and what counts as a footing or a service.** *Recommended:* a Settings list of
   layer / block-name patterns, confirmed per job, with distances he gives (example: a storage pipe 400 mm from a footing
   is flagged "Clash: footing F3, 0.4 m" if his distance is 0.5 m).
2. **Which tank position to propose when the council needs only part underground** (e.g. Glen Eira 50%). *Recommended:*
   underground tank first (meets every council); a split above/below tank only as a later combination option (slice 6).

## 6. What Codex must check in AutoCAD (copies only, when slices 3-4 exist)

1. Switch OFF: nothing new anywhere. 2. DWG-A with a calculation: three panels to the approved sketch, figures match the
calculation sheet's required storage. 3. Selecting each option swaps the ghost; nothing drawn. 4. Clash variant shows the
named clash. 5. Draft calculation shows the banner. 6. Accept one, U once: tank / pipes, orifice pit, overflow and OSD
block all revert together. 7. Cancel and Escape: "Cancelled - drawing unchanged.", no ghost left.

## 7. Not in this plan

1. Levels, sources, network (`plan-L3-LEVELS.md`, `plan-L3-SOURCES.md`, `plan-L3-NETWORK.md`).
2. The council RFI reader (UX-RFI-01..03) and the issue-to-issue comparison: their own cards.

## 8. Build/04 run 20 notes (Wed 7 Oct 2026)

1. **Slice 5 built (draft PR #752):** the "Draft: calculation not approved" marking (`DetentionDraftBannerRule`). Pure; the caller passes what the CDCALC approval check already says, so staleness is never worked out twice.
2. Built so far: slice 1 (#694), slice 2 without the footing half (#699), slice 3 ghost and chooser contract (#708), slice 5 (#752). Not built: slice 4 (complete Accept, one Undo: writes through CDWT, the pipe path and the pit-detention path, needs its own Opus review), 6, 7. The footing and service distances still wait for Tim (section 5 item 1).

## 8b. Build/04 run 21 notes (Wed 7 Oct 2026)

1. **Slice 4, plan half, built (draft PR #756, stacked on #708):** `DetentionAcceptPlanner` lists what Accept would write for the chosen option (storage pipe or tank through CDWT, orifice pit, overflow, on-site detention block) and what it leaves out and why. The storage is written exactly when the dashed picture shows it; no half system; a failing council check or short storage is a warning, never a block.
2. **NOT built: the writer.** CDWT, the pipe-drawing path and the D+F Apply preview in one transaction (one Undo, never unlocking or exploding) can only be proven in AutoCAD. *Recommended:* Opus design review of the planned shape, then a Codex run on a copy. Needs the controller's go.
3. **Question for Tim (small), with a recommendation:** where does the on-site detention block go? The plan only says the D+F card's Apply preview decides. *Recommended:* beside the orifice pit, on the same layer as the existing OSD block, unticked in the preview. Example: orifice pit at the end of the storage pipe, block placed 1 m east of it. Until answered the plan lists the block as "not written: where it goes is not decided".
