# UX-SPS-01..04 workflow card: one Pump Station tool (area H)

**DRAFT, awaiting Tim's approval before any code starts.** Written by build/04 (Team lane), Wed 7 Oct 2026. Not built, not tested in AutoCAD, not installed, not Tim-accepted. Area: `areas/civil-H-pump-stations.md` item 1.
Rulings (Tim, 26 Sep 2026, `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md` "Civil area H"): UX-SPS-01 "One Pump Station tool (Recommended)"; UX-SPS-02 "As a pipe to a discharge pit (Recommended)"; UX-SPS-03 "Fill from the job (Recommended)"; UX-SPS-04 "Duty point only, pump by engineer (Recommended)".

## 1. What exists today (checked, not assumed)

1. **Keep:** the normal pipe tool and pipe types, the pit tool, the Water Tank window (CDWT) as the model for "one window, pick the spot", and the CE Library insert for office details.
2. **Missing:** no pump station object, no wet well, no duty-point calculation, no Rising Main pipe type that I have checked. I have not searched the drawing blocks for an office SPS master detail: the card needs Tim to say where it lives (question 1).

## 2. What the drafter does (one sitting)

1. Types the command (name for Tim to choose, question 5) or clicks **Pump Station** on the ribbon.
2. A window opens, like the Water Tank window: inlet pipe (picked), wet well size, storage from the catchment (CE's figure, editable), discharge pit (picked), rising main size.
3. Picks the spot. CE shows a dashed picture of the wet well, duty and standby pumps, inlet, and the start of the rising main with its label.
4. **Accept** draws it all as ONE Undo. **Cancel** or Esc draws nothing.
5. The rising main is a normal pipe of type **Rising Main** running to the discharge pit, labelled "pumped"; it joins and updates like any pipe (UX-SPS-02).
6. The office SPS master detail is inserted with the job's levels, storage, pump duty and rising main size filled and linked; anything Unknown stays visible as "Unknown", never 0 (UX-SPS-03, RULES 12.2).

## 3. What CE works out (UX-SPS-04)

1. **Duty point only:** flow (L/s), static head (m), rising main friction losses (m), total head (m). Shown with the source of each number.
2. **The engineer names the pump.** CE never picks a make or model, and never says a pump "will do".
3. **Unknown stays Unknown:** no discharge level or no rising main length = "Not worked out", warn, never block (R-27).
4. Every number (friction method and roughness, minimum velocity, maximum velocity, storage hours, emergency storage allowance) sits on the Settings page with its source (R-00). None is invented here: the starting values come from Tim or the council (questions 2 and 3).

## 4. Native protection, Undo, save

1. A locked layer, an Xref or a protected object is left alone and said, never unlocked, detached or exploded.
2. One transaction, one Undo. Nothing is written until Accept. Save and reopen: the station is ordinary CE objects plus its record, no hidden state.

## 5. Questions for Tim (short, each with my recommendation)

1. **Where is the office SPS master detail (a drawing or block), and does it already carry fields for levels, storage, duty and main size?** *Recommended:* point me at the file; I fill its fields and add none.
2. **Friction loss method for the rising main:** *Recommended:* Hazen-Williams with a roughness value on the Settings page, starting value Tim gives (I will not guess one). Example: 100 m of DN100 PE main at 5 L/s.
3. **Storage rule:** what do you size the wet well storage on (hours of average dry-weather flow, a minimum emergency volume, or the catchment figure the card already means)? *Recommended:* you give the rule; CE shows the working beside the result.
4. **Pump stations on a stormwater job:** is the duty flow the PSD, a pumped detention outflow, or typed by the engineer? *Recommended:* typed by the engineer, with CE showing what the catchment suggests.
5. **Command name and ribbon home.** *Recommended:* `CDPUMP`, beside CDWT on the Civil ribbon, hidden until the first slice passes in AutoCAD.

## 6. Build order (each slice a draft PR, OFF by default, failing test first)

1. **Slice 1, pure engine:** duty point from flow, static head, main length, size and roughness; Unknown handling; Settings values with source. No drawing.
2. **Slice 2, Rising Main pipe type** through the normal pipe path (needs question 4 answered).
3. **Slice 3, plan picture and window contract** (Codex builds the window).
4. **Slice 4, Accept as one Undo,** then the master detail fill (needs question 1).

## 7. What Codex must check in AutoCAD (copies only)

Place a station on a copy of a drainage job; check the picture matches what Accept draws; Undo removes it all in one step; a locked layer is left alone with a message; the rising main joins a discharge pit like any pipe; the detail shows "Unknown" where a figure is missing.
