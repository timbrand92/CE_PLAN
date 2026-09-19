# CV-01G — Design-change impact preview

**Status:** G1/G2/G3 complete; independent PASS
**Depends on:** CV-01E connected identity/flow, NH-01B Civil Hub shell, the
existing immutable `ChangePlan`, PS-01D schedule identity  
**Implementation:** G1 pure engine, G2 page and G3 proposal hand-off complete
**Deployment:** not authorised  
**DATA-01:** remains blocked

## Practical result

```text
Existing CE proposal
        ↓
View design impact
        ↓
Direct change + proven downstream branches + labels/arrows/schedule + stop points
        ↓
Close / return to the existing Apply or Cancel decision
```

![Current proposal compared with the impact preview](../image/CV-01/cv-01g-design-impact-preview-mockup.png)

CV-01G is explanation only. It adds no writer and has no Apply button.

## Exact impact meaning

| Group | Included |
|---|---|
| Direct | The exact CE fields already present in the immutable proposal |
| Downstream | Proven gravity-flow paths starting at a directly changed endpoint |
| Branches | Every separately proven downstream branch; merges appear once but retain all path reasons |
| Presentation | CE-owned labels, arrows and schedule rows linked by stable identity |
| Fixed boundary | Existing/council/locked boundary shown as `Stops here`; never changed and traversal stops |
| Unknown | Missing, equal, contradictory or ambiguous direction/link shown by name; traversal stops rather than guessing |

Upstream objects are not included merely because they are geometrically close.
Rising mains use their stored design direction. XREF objects are read-only
sources/boundaries. Several fixed outlets are kept separate.

## One authority and entry points

- no new AutoCAD command;
- one `Design impact` page inside the approved Civil Hub;
- the existing Proposal Preview may open this page with `View design impact`;
- closing returns to the existing proposal, where its current Apply/Cancel
  rules remain authoritative;
- CDDASHBOARD and `CDRUNSOLVE` continue creating the existing `ChangePlan`;
  CV-01G consumes it and performs no engineering calculation.

## Pure read-only model

The proposed AutoCAD-free service receives:

1. the immutable `ChangePlan`;
2. a snapshot of CE pit/pipe stable identities, proven connections and flow;
3. Fixed/Designed/XREF ownership;
4. linked label/arrow and schedule identities;
5. the exact snapshot fingerprint.

It returns `Complete`, `Partial`, `Unknown` or `OutOfDate`, plus grouped impact
rows and plain-English reasons. It never receives an AutoCAD transaction or a
drawing-write callback.

## Stale-result protection

The fingerprint is SHA-256 over canonical, sorted records of:

- stable pit/pipe identity and relevant field values;
- proven connections/direction and Fixed/Designed ownership;
- CE-owned presentation links;
- source-DWG/XREF fingerprints;
- linked schedule authority and row identities.

Before `Show on plan` or returning to a write-capable proposal, CE recomputes
the fingerprint. A mismatch changes the page to `Out of date — Check again`.
An old result can never be used as evidence that the current proposal is safe.

## Performance boundary

- explicit user request or throttled Idle refresh only;
- never run a full traversal while dragging, selecting, zooming or inside
  `ObjectModified`;
- deterministic first-build maximum: **2,000 CE objects, 4,000 network links
  and 5,000 linked presentation/schedule records**;
- a result may be `Complete` at the exact maximum only when traversal has
  finished; before adding the first record that would exceed any maximum, CE
  stops, returns `Partial` and names that limit;
- rows are grouped and virtualised; the summary appears before large lists;
- cycles are detected by stable identity; the repeated edge stops, the overall
  result is always `Partial`, and the reason names both ends of the cycle.

The cap is a fail-closed safety limit, not an office network-size claim. PD-01
later records measured interactive timing before release promotion.

## Window, resize and high-DPI behaviour

- reuse the approved Civil Hub window: first-open working area `1216 × 698`;
- minimum usable content area `900 × 600`;
- at 1,100 px content width and above, network sketch and grouped list sit
  side-by-side;
- below 1,100 px, the grouped text list remains first and the sketch moves
  below a labelled `Network sketch` expander; no horizontal page scroll;
- finding rows virtualise and never shrink below 44 px;
- at 100%, 150% and 200% Windows display scaling, headings, state words,
  reasons and buttons remain visible without clipped values;
- resizing changes presentation only, never the result/fingerprint.

## Incremental build

### CV-01G1 — pure impact engine

- immutable input/output models;
- proven downstream, branch, merge, cycle and fixed-boundary traversal;
- presentation/schedule linkage by identity;
- canonical fingerprint and fail-closed caps;
- no WPF or Autodesk dependency.

**Built 2026-07-24:** the AutoCAD-free engine returns grouped `Direct`,
`Downstream`, `Presentation`, `Stops here` and `Unknown` rows. It removes
duplicate/ambiguous identities and malformed connections from traversal
instead of selecting one. Host, XREF and schedule sources must match their
fingerprinted authority; same-labelled branches remain distinct by stable CE
identity; all collections are copy-on-create. Focused automated evidence is
32/32 in both net48 and net10; all three Civil Release lanes compile with zero
errors using `-p:SkipDevBundle=true`. Independent audit passed with no
findings at exact clean commit `5ba57ab31a715acee181cf6e72f227f79136adbe`.

### CV-01G2 — Civil Hub read-only page

- implement the approved visual and grouped text alternative to the network
  sketch;
- Complete / Partial / Unknown / Out of date states;
- `Show on plan`, `Check again`, `Close`;
- no Apply, writer or new command.

**Built 2026-07-24:** the existing disabled Civil Hub navigation item now opens
one read-only Design impact page. It presents the approved states and groups,
virtualises 44 px rows, moves the sketch below the text list under 1,100 px
and has no Apply path. `Show on plan` is fail-closed unless the result
fingerprint matches the supplied current snapshot, row/asset ownership agrees
and the authoritative asset is local. XREF handles are never selected.
Missing, null and throwing refresh providers replace the old result with a
plain Unknown page; `Check again` is disabled when no provider exists.
Focused G2 evidence is 12/12 in net48 and net10; combined G1/G2/Hub evidence
is 53/53 in both lanes; all three Release lanes compile with zero errors using
`-p:SkipDevBundle=true`. The first audit's two bounded fail-closed findings
were corrected. Independent re-audit passed with no findings at exact clean
commit `387060bc2fe0f7f37040894dd5b681157c730711`.

### CV-01G3 — existing-proposal hand-off

- Proposal Preview may open the Hub page with its existing immutable plan;
- returning never bypasses the existing Apply/Cancel decision;
- changed fingerprint forces a rebuilt proposal and a new impact preview.

**Built 2026-07-24; independent audit pending:** the existing Proposal Preview
now offers `View design impact` and passes its existing immutable plan to the
existing Civil Hub page. One read-only adapter projects the already-loaded
ProjectData, existing pipe-truth result, CE annotation links, fixed LPD owner
and placed-schedule authority into the G1 snapshot. It never initialises or
writes ProjectData. Missing links, ambiguous direction, duplicate/unreadable
schedule authority and unresolved schedule rows are named Unknown rather
than omitted. `Show on plan` refreshes before exposing local handles. Closing
the Hub recomputes the fingerprint; if the same complete snapshot cannot be
proved, the old proposal's Apply button is disabled and staff must close and
rebuild it. Cancel remains available and no new writer, command or ribbon
route exists. Focused combined G1/G2/G3 evidence is 70/70 in net48 and net10;
all three Release lanes compile with zero errors using
`-p:SkipDevBundle=true`. The first independent audit found an incomplete
initial fingerprint could return to an enabled old Apply. The bounded
correction now treats that hand-off as unproven, disables Apply and preserves
Cancel. Independent re-audit passed with no findings at exact clean correction
commit `da8fad2b0de438b40bec7324a7c23c76f84549c3`.

## Required automated situations

| Situation | Expected |
|---|---|
| One direct pit change | Exact direct field plus only proven downstream links |
| Two downstream branches | Both paths listed separately |
| Branches merge | Shared object once, both reasons retained |
| Multiple fixed outlets | Each stop shown; no traversal beyond it |
| Missing/equal direction | Unknown at that edge; no guessed downstream set |
| Rising main | Stored design direction used |
| XREF source/boundary | Read-only, named source, no write |
| Cycle | `Partial`; repeated edge names both ends, stops once, no loop |
| Unlinked label/schedule | Named Unknown; not silently omitted |
| Fingerprint changes | Out of date; Check again required |
| Exact maximum reached and traversal finished | `Complete` |
| Next record would exceed a maximum | `Partial` with named limit; extra record is not added |
| Close/Escape | No ProjectData, DWG, annotation or schedule change |
| AutoCAD 2022/2025/2027 tiers | Same information, order, keyboard and safety |

## Approval boundary

Approval authorises the three read-only increments above. It does not approve
automatic redesign, relocated-LPD calculations, pipe sizing, drawing changes,
new engineering rules, XREF write-back, deployment or DATA-01 access.

Tim approved the reviewed smart-Civil visual pack and instructed Codex to
proceed on 2026-07-24. Each implementation increment still requires its own
clean commit and independent audit before the next increment starts.
