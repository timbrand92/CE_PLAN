# CV-07 — Survey and consultant import

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-52`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

## CV-07 — Survey, consultant and civil import

### Current AutoCAD state

| Command/tool | What works now | Required direction |
|---|---|---|
| `CDSURVEY` | Imports survey XREF/raw 3D data; project storage now survives reopening | Modify — make transform and suspect-point checks approval gates |
| `CDCHECKDWG` | Examines a consultant DWG without opening it | Modify — stop writing reports beside the consultant file; show unsaved-current-DWG limitation |
| `CDIMPORTXCIVIL` | Hidden; parsing and repeat-import fixes exist | Rebuild — result remains too rough for production drafting |
| `CDIMPORTLANDXML` | Hidden; protected XML parsing and network extraction exist | Rebuild — preserve levels and add proper preview |
| `CDIMPORTCOMPARE` | Produces comparison information | Rebuild — it currently reconciles/moves drawing data before “comparison” |
| `CDEXPORTCORPUS` | Produces test data | Keep disabled — currently exposes paths, geometry and real coordinates |

### Recommended data flow

```text
Survey / LandXML / consultant DWG / schedule
                     ↓
          Frozen intake snapshot
                     ↓
      Mapping + conflicts + Unknowns
                     ↓
       Native CE drawing preview
                     ↓
       Timothy approves → Apply → Undo
```

## AI1–AI15 equivalent: CV7-1–CV7-15 for approval

| ID | Recommended decision | Practical AutoCAD result |
|---|---|---|
| **CV7-1** | Keep one consultant-intake workflow. X-Civil and LandXML remain hidden until their drafting-quality gate passes. | Staff cannot run a known rough importer. |
| **CV7-2** | Commands open sections inside the existing Manager-owned Review workspace—no additional dashboard. | Survey, import preview and QA live in one place. |
| **CV7-3** | Lock the authority order: survey = ground levels; LandXML = structured network; DWG = plan evidence; schedules = corroboration; CE rules = engineering checks. | Conflicting sources are displayed, never silently blended. |
| **CV7-4** | `CDSURVEY` stores source revision, file fingerprint, transform, units and provenance with the project. | “Survey Rev C, transformed and approved” remains traceable. |
| **CV7-5** | Survey sanity checks become an approval gate. Suspect points are excluded or marked **Unknown**, not activated automatically. | An isolated RL 0.000 cannot distort the site surface. |
| **CV7-6** | Rebuild X-Civil as **extract the consultant design, then redraw using native CE pits, pipes and labels**. Do not copy their graphical clutter. | The result looks like Timothy’s drafting, not a cleaned-up consultant export. |
| **CV7-7** | Align imports to the architectural XREF using a preview overlay—no manual pick-point placement. Ambiguous alignment blocks Apply. | Pit centres and building geometry visibly coincide before insertion. |
| **CV7-8** | Preview shows recognised assets, skipped items, missing levels, conflicts, transform and proposed output before any drawing change. | Example: “23 pits recognised, 2 unknown, 1 conflicting outlet.” |
| **CV7-9** | Create typed native CE assets. Existing council infrastructure is **Existing/Fixed**. Parallel pipes under 1 m are detention twins only. | Existing infrastructure is shown but never redesigned silently. |
| **CV7-10** | LandXML retains its Z values and RLs. Plan transformation must never flatten meaningful levels to zero. | IL 44.320 remains design data while the plan position is aligned. |
| **CV7-11** | Re-import by stable source identity and revision. Preserve approved CE overrides; clearly show added, changed and removed items. | Rev D updates three pits without destroying Timothy’s corrected labels. |
| **CV7-12** | `CDCHECKDWG` and `CDIMPORTCOMPARE` use genuinely non-writing snapshots. No sync, relink or endpoint movement; reports go only to an approved CE/project report location. | Comparing a consultant file cannot alter either drawing or its folder. |
| **CV7-13** | PDF/AI vision fallback requires explicit project and provider permission. It is advisory and must pass the same deterministic checks. | A schedule image can suggest an IL, but cannot silently establish it. |
| **CV7-14** | Keep raw corpus export disabled until DATA-01 controls exist: de-identification, coordinate translation, metadata stripping and history clearance. | No real site location or client path enters test fixtures. |
| **CV7-15** | Heavy intake runs from snapshots without drafting lag. Automated evidence covers most testing; Timothy tests one representative package with Preview → Apply → Undo, targeted at **10 minutes maximum**. | One overlay and one Undo replace repeated package-by-package testing. |

### Recommendation

**Approve CV-07 all.** The major architectural choice is CV7-6: retain the useful extraction work, but abandon copying consultant drafting and produce clean native CE objects instead.

No files, code, builds or deployments were changed.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-53

✅ Approve CV-07 all
This rebuilds the worst-behaving area in the whole plugin (import had ~19 bug IDs and was hidden because you didn't trust it), and the strategy is right — because it stops fighting the symptoms and changes the approach.

🏆 CV7-6 is the keystone — and it retires an entire bug class at once
"Extract the design, then redraw native — don't copy their clutter" is the single most important decision on this card. Look at what the old import bugs actually were: rotated X01 blocks, mirrored text, pipes overrunning pit outlines, labels strewn everywhere, junk schedule rows. Almost all of them came from inheriting the consultant's graphics and trying to clean them up. Extract-and-redraw sidesteps every one — you read their design intent (pits here, at these ILs, connected thus) and draw clean CE objects that (crucially) inherit all of CV-01's identity, atomicity and safety. The result behaves like a real CE network because it is one, not a foreign drawing wearing CE data. This is the decision that makes import trustworthy.

🔁 CV7-11 is the second keystone — the re-import accumulation cure
Re-importing by stable source identity + revision, preserving your overrides, and showing added/changed/removed is the exact fix for the disaster where re-imports accumulated pipes (93 records for ~35 real pipes, BUG-058/059). Rev D updates three pits instead of duplicating the network — and your corrected labels survive.

One nuance: when Rev D changes a value you'd overridden (you set P3 to 42.140; Rev D now says 42.130), "preserve overrides" must surface the conflict — "P3: your override 42.140 vs Rev D 42.130 — review" — not silently keep the stale override. It's the PS11 override-staleness rule applied to re-import. Preserve, but flag when the ground moved under it.

🧭 CV7-3 is sophisticated and correct
Locking a source-authority precedence (survey owns levels, LandXML owns the network, DWG is plan evidence, schedules corroborate, CE rules check) — and displaying conflicts rather than silently blending — is real multi-source reconciliation. Blending a DWG IL, a schedule IL and a LandXML IL into an average gives you a number that matches none of them. Precedence + visible conflict is the honest way. Well judged.

🔒 CV7-14 closes the loop I flagged in DATA-01
"Keep raw corpus export disabled until DATA-01 controls exist — de-identification, coordinate translation, metadata stripping, history clearance" bakes in exactly the two catches from that review: coordinates are geolocatable (translate to a local origin), and deletion ≠ history-clean (SEC-001). Good — my flag became an enforced gate.

✅ Three quick affirms
CV7-5 — survey sanity as a gate: one isolated RL 0.000 can pull an entire TIN off; excluding/Unknown-marking suspect points before they activate is garbage-in prevention at the door.
CV7-10 — LandXML Z survives the plan transform. Aligning X/Y must never flatten IL 44.320 to zero — the false-zero-level bug in 3D form.
CV7-13 — AI vision is advisory and must pass the same deterministic checks; a schedule image suggests an IL, never establishes one silently (the "applied an empty schedule" bug, contained).
🔒 Locked, nothing starts
The importer stays hidden until its quality gate passes; extraction work is kept, consultant clutter is abandoned, re-imports are safe, and existing council infrastructure is Fixed and never silently redesigned. This is the right rebuild of the hardest area. Ready for the next.
