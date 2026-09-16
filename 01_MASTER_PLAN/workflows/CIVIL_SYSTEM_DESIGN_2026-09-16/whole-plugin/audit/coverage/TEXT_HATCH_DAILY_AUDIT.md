# Text/tag and breakline/hatch daily audit

FOR TIM

The arc-sequence correction is verified. The new hatch card still omits approved daily controls and preservation details. The text card needs an explicit distinction between an owned tag and an independent note when no parent is selected.

---

Checkpoint: 2026-09-17T02:08:09+10:00. Planning/source reads only.

| Finding | Severity / file | Exact evidence and required change |
|---|---|---|
| HATCHDAILY01 | Medium; planner/structural_breakline_hatch_daily_card.md, Ordinary hatch | ST5-3/4/7 explicitly retain Approved defaults versus Candidate Preview-only, Scale/Angle/Origin adjustment, R rotate, O origin and WH visible origin. The card only says inspect properties. Add actual gestures and explicitly retained frequent LBH/LBUH/BLH. |
| HATCHDAILY02 | Medium; same, ordinary preview and H2A property list | ST5-8/10 retain islands/openings, background, transparency and draw order. The list labelled full properties omits these. State them, independent multi-region editing and ST5-9 explicit CE owner versus general independent hatch. No new values or defaults required. |
| TEXTDAILY01 | Low clarification; planner/structural_text_tag_daily_card.md entry/Apply | ST4-9 requires explicit parent relationship for beam/support/foundation labels; card offers no-parent independent draft then Apply without a clear transition. Require explicit parent for owned label or deliberate independent-note choice; do not treat the alias as proof of an owned tag. Retain named SFT/SFB/BSFT/BSFB transition aliases in ST04 text versus ST06 geometry boundary. |

Actual evidence read: full text and hatch cards; full ST04 including approval; ST05 decisions/examples/refinements; CeTextCommands.cs1–94; BreaklineCommands.cs26–55; HatchCommands.cs179–234 and466–530. Source H2A changes discovered boundary layer/colour and erases original before invoking replacement and enumerating new hatches. The planning card correctly rejects this as target behavior. Actual native rendering/cleanup/rollback was not run. BL two-point current source and target plotted-space/UCS/normal edits are consistent at this bounded level.

DIMDAILY01 closure recorded separately after actual corrected rows, steps and example readback. Findings sent to planner; await actual corrections before closing.

Next concrete candidate: CXREF/PXREF and XRL ordinary production gestures, preserving settled ST5-11/12. Sampled workflow cards only name Xref retention/inspection; planner asked to check existing supplements first. This is not whole-plugin completeness evidence.

## Closure readback — 2026-09-17T02:10:26+10:00
HATCHDAILY01/02 closed after actual ordinary-hatch and H2A rows were read: Scale/Angle/Origin, R/O/WH, Approved/Candidate, LBH/LBUH/BLH, islands/openings/background/transparency/draw order and multi-region/owner boundaries are now explicit. TEXTDAILY01 closed: parent selection or deliberate independent-note choice is explicit and SFT/SFB/BSFT/BSFB transition retained. Native limits unchanged.

