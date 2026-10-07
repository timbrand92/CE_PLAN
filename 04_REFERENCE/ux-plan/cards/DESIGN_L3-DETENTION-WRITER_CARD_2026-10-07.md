# DESIGN CARD L3 detention: Accept draws the chosen storage system (DRAFT, 7 Oct 2026)

Status: **DRAFT, not approved.** This is the last step of "CE proposes detention and tank layout". These parts are built, switched off and not installed: the 2 or 3 storage options, the clash check (without footings), the side-by-side chooser layout, the "Draft: calculation not approved" marking and the list of what Accept would draw.

## What you would see in AutoCAD

1. CE shows 2 or 3 storage options side by side, each from the same calculation: A a storage pipe, B a larger and shorter pipe, C a tank. Each one shows m³ provided against m³ required.
2. You pick one and press Accept. CE draws the whole system in one go, through the same commands you use by hand: the storage pipe or tank, the orifice pit, the overflow and the on-site detention block.
3. One U removes the whole system. A short storage or a failed council check is shown as a warning and never stops you.

## Questions

1. **Where does the on-site detention block go?**
   - **Recommended:** beside the orifice pit, on the same layer as the existing on-site detention block, unticked in the preview until you tick it.
   - **Job:** the orifice pit sits at the end of a DN600 storage pipe. The block is shown 1 m east of it, and you tick it to place it. Until you answer, CE draws everything except the block and says "block not placed: where it goes is not decided".
2. **How close may a storage pipe or tank come to a footing or a service before CE calls it a clash?** (asked 4 Oct, numbers not typed yet)
   - **Recommended:** you type the two distances in metres. CE keeps them on the Settings page and recognises footings and services by layer or block names, confirmed on each job. There is no recommended number: it is your engineering call.
   - **Job:** with 0.5 m for footings, a storage pipe 0.4 m from footing F3 shows "Clash: footing F3, 0.4 m". Until you type them, CE says "footing and service clearance not set" and does not check them.
3. **When a council needs only part of the storage underground (for example Glen Eira at 50 %), which tank does CE propose?**
   - **Recommended:** a fully underground tank first, because it meets every council. A split above-and-below option comes later with the combined options.
   - **Job:** a Glen Eira lot needing 15 m³ gets option C as one 15 m³ underground tank, not 7.5 m³ above and 7.5 m³ below.

## What stays safe

1. Esc or Cancel draws nothing and leaves no dashed preview. One Accept is one Undo, covering the pipe or tank, the orifice pit, the overflow and the block together.
2. A locked layer, an Xref or a reference edit is never unlocked, detached or exploded. CE refuses that piece in plain words, and it never draws half a system without saying so.
3. Every distance, option count and on/off switch sits on the Settings page. A tank depth is never invented. It stays Unknown until a tank is picked from the library.
4. CE warns and carries on. A failed check is shown, never hidden, and never blocks Accept.

## Once you approve

1. **Builders:** first a senior design review of drawing the whole system as one Undo through the existing tank, pipe and pit commands. Then they build it and Codex tests it in AutoCAD on a copy.
2. **Test that proves it:** on a copy with a finished calculation, open the chooser and pick each option in turn. Only the dashed picture changes. Accept option A, then press U once: the pipe, orifice pit, overflow and block all go together. Lock the storage layer and Accept: CE names the layer and draws nothing. Esc leaves no dashed lines.

---
For builders (Tim need not read): plan `areas/plan-L3-DETENTION.md` slice 4 and section 8b item 2 (writer NOT built: CDWT plus the pipe-drawing path plus the D+F Apply preview in one `ChangePlan`; needs the controller's go, then an Opus design review, then a Codex AutoCAD run). Built: #694 (options), #699 (clash, no footing half), #708 (chooser contract and ghost), #752 (draft banner), #756 (accept planner; Opus run 107 MWF, NEW MEDIUM: the ghost draws the overflow when the orifice pit is not shown; fix round run 25). Question 1 = 8b item 3. Question 2 = L3_QUESTIONS Q8 / INT-059 item 24 (unanswered). Question 3 = plan section 5 item 2 (unanswered). Codex checks: plan section 6.
