# CV-01F — Pit Level Assistant implementation plan

**Decision:** feature approved by Tim; implementation plan prepared 2026-07-23
**Implementation:** CV-01F1/F2/F3/F4 independently PASS; Order 4 complete
**AutoCAD verification:** not started
**Deployment:** not authorised
**DATA-01:** remains blocked

## Practical result

The assistant belongs inside the existing `PIT` / `CDEDIT` pit window. Staff
should not have to remember another command.

```text
Open or edit pit P4
        ↓
CE reads only the proven pipes connected to P4
        ↓
┌───────────────────────────────────────────────┐
│ CONNECTED LEVELS                              │
│ Arriving:  P3 → P4     IL 12.34              │
│ Leaving:   P4 → P5     IL 12.29              │
│                                               │
│ ✓ Levels fall through this pit               │
│ Suggested pit IL: 12.29  [Use this IL]        │
└───────────────────────────────────────────────┘
        ↓
Use fills the existing field; `Update Pit` / `Place Pit` remains the drawing action
```

If the topology or levels do not prove an answer, CE shows `Cannot determine`
and explains the missing/ambiguous item. It never guesses.

## Important audit finding

Much of the safe backbone already exists:

| Existing part | Reuse |
|---|---|
| `PitSetupAdvisorService` | Already reads the current pit and connected pipe levels without AutoCAD writes |
| `PitSuggestionViewModel` / shared suggestion strip | Already presents an advisory inside pit edit |
| `PitDropResolver` | Already applies the approved inlet-to-outlet pit-drop convention |
| `ConnectedPipeFlowResolver` | Already resolves direction only when connectivity/levels prove it |
| `CDRUNSOLVE` + `ProposalApplyService` | Already owns whole-run preview, explicit Apply and the existing update path |
| NH-01 health snapshot | Already reports missing levels, disconnected pipes and backfalls |

CV-01F is therefore an **upgrade to the existing inline advice**, not another
calculation engine, command or drawing writer.

## Level model

A junction pit can have several arriving and leaving pipes. One generic `IL`
field must not hide that reality.

| Display | Meaning |
|---|---|
| Arriving level(s) | Each confirmed incoming pipe invert at this pit |
| Leaving level(s) | Each confirmed outgoing pipe invert at this pit |
| Stored pit IL | The pit's existing reference/outlet invert used by current CE data and schedule behaviour |
| Suggested pit IL | Lowest confirmed connected gravity-pipe invert, clearly labelled as advice |
| Pit drop check | Each leaving gravity level must not rise above the proven incoming control level |

Different branch inverts remain listed separately. CE does not collapse them
into a fabricated single inlet level.

## Fail-closed rules

The assistant returns `Unknown` and disables `Use this IL` when:

- a connected pipe end is blank;
- duplicate pit numbers make ownership ambiguous;
- required end levels are missing or invalid;
- pipe direction cannot be proven;
- the object comes from a read-only XREF;
- different connected records contradict one another;
- the proposed value would raise a gravity outlet above its controlling inlet.

Charged/rising-main connections are labelled separately and are not judged by
the gravity fall rule. Existing/council assets remain reference-only.

## Incremental build

### CV-01F1 — pure connected-level analysis

- one AutoCAD-free input/result model — built;
- preserves every connected branch and its source pipe handle;
- returns `Valid`, `Warning`, `Error` or `Unknown` plus a plain-English reason;
- calculates no new hydraulics and writes nothing;
- consumes the existing `ConnectedPipeFlowResolver` result and uses
  `PitDropResolver`'s sane-drop rule;
- suggested pit IL is the lowest confirmed gravity-pipe invert;
- charged/rising-main pipes remain visible but are excluded from gravity fall;
- duplicate IDs, missing/ambiguous direction/levels, contradictory records and
  XREF read-only state disable use.

### CV-01F2 — existing pit window, read-only

- `Connected levels` section added to the existing
  [`UI-02` pit window](UI-02_CIVIL_PIT_VISUAL_REVIEW.md);
- shows arriving/leaving/charged pipe names and levels as separate rows;
- shows impossible, missing and ambiguous combinations inline;
- reads current pipe-truth snapshots through the existing flow resolver;
- suggested pit IL is explicitly labelled display-only;
- no new ribbon button, command or writer.

### CV-01F3 — explicit use

- `Use this IL` is enabled only for one unambiguous proposal;
- copies the proposal into the existing pit IL field at 3-decimal precision;
- keeps `Update Pit` / `Place Pit` as the only commit and `Cancel`/Escape as no
  change;
- XREF, Unknown and Error results cannot use the value;
- existing linked-data/label/schedule path remains the only save path.

### CV-01F4 — network hand-off

- where more than one pit needs regrading, offer `Preview whole run`;
- hand off to the existing `CDRUNSOLVE` plan → preview → Apply path;
- do not add a second run solver or write path.
- the hand-off closes Pit Edit without saving temporary Pit Edit fields;
- it is shown only for a local pit with a proven leaving gravity branch;
- a stale one-use pit selection falls back to the existing start-pit prompt.

## Required automated situations

| Situation | Expected |
|---|---|
| One inlet + one lower outlet | Valid suggestion |
| Equal inlet/outlet | Warning; no silent correction |
| Outlet above inlet | Error; Use disabled |
| Several inlets + one outlet | List every branch; derive only from proven levels |
| One inlet + several outlets | Keep every outlet visible; do not merge values |
| Missing end level | Unknown; name the missing pipe/end |
| Duplicate pit ID | Unknown; ownership ambiguous |
| Pipe reversed after redesign | Use CV-01E connected direction, not old draw order |
| Rising main/charged pipe | Label separately; exclude from gravity fall failure |
| XREF network | Read-only result; no Use |
| Cancel/Escape | No ProjectData, DWG, label or schedule change |
| Use then Update Pit | Existing linked labels, flow arrows and schedule remain consistent |
| Use then Undo | One user action reverses the committed change |

## Tim's later AutoCAD check

1. Open a disposable Civil drawing with one simple P3 → P4 → P5 run.
2. Run `CDEDIT` on P4 and confirm the two connected levels read correctly.
3. Reverse one level so the outlet rises; confirm CE explains the problem and
   disables `Use this IL`.
4. Add a second branch and confirm both levels stay visible.
5. Press `Use this IL`, then Cancel; confirm nothing changes.
6. Repeat, press `Update Pit`, and confirm pit text, pipe labels/arrows and schedule agree.
7. Run `U`, save/reopen and confirm the old values return and links remain intact.

## Gate

No implementation begins until the UI-02 pit-window visual is shown to and
approved by Tim. This plan does not change the current drawing or plugin.
