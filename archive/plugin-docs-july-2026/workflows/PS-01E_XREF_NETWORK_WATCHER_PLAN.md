# PS-01E — Passive XREF network watcher

**Status:** visual and implementation plan approved by Tim; 2026-07-24
**Depends on:** PS-01B XREF discovery, PS-01D2 passive status,
`ProjectDataFingerprintService`, Civil Hub  
**Implementation:** PS-01E1 pure coordinator and E2 read-only AutoCAD
lifecycle adapter implemented in source; E3–E4 not started
**Deployment:** not authorised  
**DATA-01:** remains blocked

## Practical result

```text
Drainage XREF is attached, unloaded, reloaded or resolved
                    ↓
CE waits until the AutoCAD command has finished and AutoCAD is safely Idle
                    ↓
One read-only XREF graph + CE data fingerprint check
                    ↓
Civil Hub quietly shows:
Current · Out of date · Missing · Unloaded · Conflict
                    ↓
Staff chooses Review schedule changes
```

![Current manual status compared with the passive XREF watcher](../image/PS-01/ps-01e-xref-network-watcher-mockup.png)

The right side is a conceptual status panel inside the already proposed Civil
Hub shell, not a new window or palette.

Nothing updates automatically. The placed schedule remains unchanged until the
existing reviewed `PITSCHEDULE` update path is explicitly applied.

## What changes — and what does not

| Today | PS-01E proposal |
|---|---|
| Status is checked when staff open/refresh schedule tools | Relevant XREF lifecycle changes request one safe status check |
| A changed source can be overlooked | Civil Hub keeps the current schedule status visible |
| Staff open PITSCHEDULE to discover the state | The existing PITSCHEDULE review opens only when staff chooses it |

PS-01E is not another schedule checker. It reuses:

- `PitScheduleXrefDiscoveryService` for one read-only XREF graph snapshot;
- `ProjectDataFingerprintService` for the one approved CE data fingerprint;
- `PitScheduleStatusService` for `Current`, `Out of date`, `Missing`,
  `Unloaded` and `Conflict`;
- the placed `PitScheduleHostInstanceRecord` as the comparison baseline.

It adds no command, palette, fingerprint format, schedule writer or XREF writer.

## Trigger and throttle contract

1. Relevant document/XREF lifecycle events only mark that document `dirty for
   status check`. Event handlers do not open database objects.
2. A completed/cancelled/failed XREF command, document activation, XREF graph
   resolution change or source-file notification may request a check.
3. The coordinator waits for the next safe AutoCAD Idle after one second of
   command quiet.
4. One document is checked at most once per five seconds. Repeated events
   coalesce into one check. An explicit user refresh may bypass the throttle.
5. There is no repeating scan when nothing changed.
6. No check runs while a command, grip edit, drag, modal dialog, plot/publish,
   save or document close is active.
7. Closing/switching documents cancels pending work and unregisters every
   document-specific event.

Command names are merely trigger hints. The checker always re-reads the actual
XREF graph and stored source identities; it never decides status from a command
name alone.

## External source-file change

A file notification is advisory only because a path and timestamp do not prove
engineering identity or content.

```text
Drainage.dwg changed on disk
        ↓
SOURCE CHANGED — reload XREF to verify
        ↓
AutoCAD reloads/resolves the XREF
        ↓
The normal CE fingerprint decides Current / Out of date / Conflict
```

Missed, duplicated or unavailable operating-system notifications must be
harmless. File path is display information only; permanent drawing identity
continues to qualify the source.

## Read-only and fail-closed rules

- read only the active host drawing and databases already exposed through its
  loaded XREF graph;
- never open, lock, save, reload or write an external DWG;
- never call relink, repair, update, placement or schedule cell writers;
- never start an AutoCAD transaction for write;
- never add an Undo record or mark either host/source drawing modified;
- unavailable, unreadable, empty or ambiguous evidence stays
  `Missing`, `Unloaded` or `Conflict`, never `Current`;
- preserve the last placed schedule graphics and last proven status if a scan
  fails unexpectedly, then show `Could not verify — review required`;
- one bad XREF cannot suppress named results for other sources.

## One quiet doorway

Civil Hub owns the visible summary. The existing Inspector and PITSCHEDULE
consume the same immutable result; they do not run parallel scans.

| State | Civil Hub treatment | Action |
|---|---|---|
| Current | Green, quiet | None |
| Out of date | Amber, exact source named | Review schedule changes |
| Source changed on disk | Amber, not yet verified | Reload XREF |
| Unloaded / Missing | Red, placed graphics preserved | Load/find source |
| Conflict / could not verify | Red, reason named | Review source |

Only a transition away from `Current` may show one non-modal notification.
Repeated Idle checks do not repeat it. There is no modal popup and no update
button in the notification.

## Incremental build

### PS-01E1 — pure coordinator

- AutoCAD-free per-document dirty/coalesce/throttle state machine;
- immutable check request/result;
- exact one-second quiet and five-second minimum interval rules;
- deterministic time and event-sequence tests.

### PS-01E2 — read-only AutoCAD adapter

- document/XREF command-end and safe-Idle lifecycle;
- complete subscribe/unsubscribe across open, activate, close and plugin unload;
- one adapter invocation of the existing discovery/status authorities;
- no database work inside native document or command callbacks; the approved
  read-only snapshot runs only from a safely gated Idle.

**Implemented source checkpoint — 2026-07-24:** the adapter assigns transient
per-session document identities, attaches command-end events only to the active
document, discards pending work on switch/close, and checks `CommandInProgress`
plus `CMDACTIVE == 0`, editor quiescence, foreground/background plot state,
save state, close/destroy state and normal-project-drawing safety before one
read-only Idle evaluation. Completed, cancelled and failed XREF command hints
all mark the active document dirty. Native detach steps are fail-independent,
so one AutoCAD teardown exception cannot skip later cleanup or close
cancellation. Explicit refresh uses the same route and bypasses only the
five-second throttle. The adapter invokes `PitScheduleHostInstanceService.ReadAll`,
`PitScheduleXrefDiscoveryService.TryDiscover` and
`PitScheduleStatusService.Evaluate`; it creates no alternate checker or
fingerprint. Plugin unload and headless-host exclusion are wired. AutoCAD
runtime evidence remains E4. Independent source audit passed after the bounded
safe-Idle and fail-independent teardown corrections; watcher plus existing
PS-01D2 status/discovery tests pass 78/78 on net48 and 78/78 on net10, and all
three runtime lanes build with zero errors.

### PS-01E3 — Civil Hub status contribution

- one status card in the approved Civil Hub;
- existing Inspector/PITSCHEDULE receive the same result;
- existing PITSCHEDULE route opens `Review schedule changes`;
- transition notification is non-modal, deduplicated and optional.

### PS-01E4 — runtime evidence

- active, inactive, closing and several-open-document cases;
- attach/load/unload/reload/rename/missing/nested/duplicate source cases;
- command cancel/fail, rapid repeated events and plugin unload;
- host/source `DBMOD` unchanged after every passive check;
- no Undo record, no schedule cell/block change and no XREF write;
- save/reopen retains only the approved authority baseline, not transient
  watcher state.

## Required situations

| Situation | Expected |
|---|---|
| No linked schedule | Existing `Missing` result; no false XREF warning |
| Same loaded source/fingerprint | Current |
| Source fingerprint changed after reload | Out of date; source named |
| File changed but XREF not reloaded | Advisory reload-required state only |
| XREF unloaded | Unloaded; placed graphics preserved |
| Source missing/renamed | Missing; placed graphics preserved |
| Same source attached twice | One durable source result by default |
| Duplicate/ambiguous identity | Conflict; never choose by path |
| Nested XREF changes | Qualified chain/source named |
| Rapid reload commands | One coalesced check |
| Command cancelled/failed | Recheck actual graph; no assumed outcome |
| Modal dialog or grip edit active | Wait |
| Document closes before Idle | Pending work discarded safely |
| Scan throws | Last graphics preserved; could-not-verify shown |
| Repeated unchanged Idle | No scan and no repeated notification |

## Performance and accessibility

- a check uses one XREF graph pass and one cached project-record read per
  durable source;
- no per-entity drawing scan and no full schedule rebuild;
- target: 100 ms p95 for 10 sources and 300 ms p95 for 50 sources using
  synthetic records; over-budget results remain truthful and diagnostic;
- the status uses text plus colour and remains readable at 100/150/200% DPI;
- reuse the Civil Hub 1216×698 first-open size, 900×600 minimum and
  under-1100-pixel single-column reflow; status cards become a vertical list
  with no horizontal scrolling;
- actions retain a minimum 44-pixel target, visible keyboard focus and the same
  tab order in Legacy/Modern/Fluent presentation tiers;
- keyboard focus reaches the existing review action; Escape closes only the
  opened review surface and never changes the drawing.

## AutoCAD and release boundary

The same state names, ordering and no-write rules apply in AutoCAD 2022–2024,
2025–2026 and 2027. Legacy/Modern/Fluent presentation may differ visually but
not behaviourally.

Approval authorises planning-to-code for E1–E4 only. It does not authorise a
new command, automatic XREF reload, schedule update, XREF write, deployment or
DATA-01 access.

Tim approved this plan and visual before PS-01E1 implementation began.
