# CV-01E4 — CD draw-first AutoCalc and connected-end preview

**Decision:** approved by Tim, 2026-07-24
**Implementation:** source complete and independently passed at `130c00f`;
integrated at `896510c` and joined source re-audit passed at `34d5e3c` — live
AutoCAD acceptance remains mandatory before the CD window rebuild
**Depends on:** CV-01E connected identity/flow, UI-02 Civil visual language,
PS-01 schedule authority
**Deployment:** not authorised
**DATA-01:** remains blocked

## Practical result

```text
Draw the pipe
      ↓
CE identifies both connected ends
      ↓
PP ─────────→ P3
From IL       To IL
      ↓
AutoCalc opens with the proven values already filled
      ↓
Preview confirms direction, arrow, text and schedule impact
```

The current settings-first doorway remains available until the draw-first
workflow passes one representative AutoCAD test and produces the same result.

## Required CD behaviour

1. Drawing the route before the CD window opens must not break AutoCalc.
2. The preview and **Flow / Inverts** page show both proven endpoint names,
   for example `PP → P3`, beside their physical invert values.
3. Polyline drawing direction and hydraulic flow direction remain separate.
4. If the levels indicate the opposite direction, CE asks:

   > Pipe was drawn P3 → PP, but the entered levels indicate PP → P3.
   > Is this correct?

   Choices are **Use level direction**, **Keep nominated direction** and
   **Review**. CE never silently reverses the pipe.
5. Each invert remains attached to its physical endpoint. Reversing hydraulic
   meaning must not swap the entered numbers between pits.
6. Missing, equal, duplicated or ambiguous endpoint evidence remains
   **Unknown**. CE does not guess from nearby geometry.
7. CE recognises proven pit, LPD, IO, DP, OF, Fixed boundary and XREF
   endpoints. XREF content remains read-only.
8. A confirmed direction updates the flow arrow, pipe text, endpoint roles
   and linked schedule through the one existing authority.

## AutoCalc and window rules

- AutoCalc begins only after the two endpoints have been identified.
- Size, grade, fall, cover, velocity and invert advice refresh when a relevant
  value changes, without overwriting a staff-entered or locked value.
- The window clearly distinguishes **Detected**, **Staff entered**, **Fixed**
  and **Unknown** values.
- Cover, backfall, rising-pipe and missing-connection warnings appear before
  acceptance.
- The same endpoint labels and direction are used in the initial preview,
  Flow / Inverts page, final preview, plan annotation and schedule.
- Cancel/Escape removes or abandons the unfinished pipe without leaving
  partial data, labels or arrows.
- One accepted pipe is one AutoCAD Undo action.
- The workflow preserves OSNAP, UCS and the drafter's existing drawing
  settings.

## Situations that must be proven

| Situation | Expected result |
|---|---|
| Pipe drawn PP to P3 with matching fall | `PP → P3` shown throughout |
| Pipe polyline drawn backwards | Prompt before changing hydraulic direction |
| Inverts later reverse | Preview the old and proposed direction |
| Equal or missing inverts | `Unknown`; retain existing direction |
| One or both ends unconnected | Name the proven end; do not guess the other |
| LPD / IO / DP / OF endpoint | Display the real endpoint role |
| Rising main | Preserve nominated pump/design direction |
| Fixed/council boundary | Preserve the Fixed direction and datum |
| XREF endpoint | Read-only status; no host-drawing write-through |
| Branch or multi-segment pipe | Show the exact connected identities |
| Cancel / Escape | No partial pipe, data, label or schedule row |
| Apply then Undo | Complete pipe creation reverses in one Undo |
| Save/reopen | Same endpoints, inverts, direction, labels and schedule |
| Rotated UCS / normal World UCS | Same engineering result |

## Build boundary

CV-01E4 improves the existing `CD` workflow and shared connected-flow
authority. It does not introduce another command, pipe solver, schedule
owner, direction engine or CD window. The later CD WPF rebuild may change the
layout only after this behaviour and its tests exist.

Implementation must include automated guards for endpoint identity,
draw-direction versus hydraulic-direction separation, reversal confirmation,
Unknown handling, Cancel/Undo and cross-surface consistency. Tim's final
AutoCAD acceptance should cover one normal pipe, one backwards-drawn pipe and
one ambiguous pipe.
