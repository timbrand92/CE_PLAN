# CV-08 — Repair and migration

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-59`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Approved source card — verbatim

# CV-08 — Repair and migration

## Current AutoCAD state

| Tool | Current behaviour | Direction |
|---|---|---|
| `CDREPAIR` | Working window containing many repair buttons | Consolidate into guided diagnosis and preview |
| `CDSYNC` | Directly re-registers and relinks pits/pipes | Modify — no blind proximity decisions |
| `CDREBUILD` | Recovers considerable data and preserves many user edits | Modify — currently writes immediately and derives some values |
| `CDREBUILDLINKS` | Rebuilds compound links and reports skipped objects | Keep engine; add preview and atomic Apply |
| `CDLINKDANGLINGPIPES` | Registers polylines found on CE pipe layers | Modify — layer alone is insufficient proof |
| `CDUPGRADE` | Merge/Replace migration for older drawings | Rebuild — Replace is too destructive without preview |
| `CDRECOVERINVERTS` | Recreates stored invert data and missing text | Modify — remove guessed endpoint mapping and 150 mm fallback |
| `CDAUDIT` | Reports link/data issues | Serious gap: it calls drawing sync and may write during an “audit” |

## CV8-1–CV8-15 for approval

| ID | Recommended decision | AutoCAD example |
|---|---|---|
| **CV8-1** | Keep `CDREPAIR` as the civil recovery entry. Expert commands remain hidden aliases to one repair engine. | Staff use one Repair button, not eight commands. |
| **CV8-2** | `CDREPAIR` opens **Manager → Drawing Repair**, not another standalone dashboard. | One CE home surface remains authoritative. |
| **CV8-3** | Every repair begins with a genuinely non-writing frozen audit. `CDAUDIT` must never call Sync or alter links. | Running Audit cannot move a pipe endpoint. |
| **CV8-4** | Show findings as **Healthy / Warning / Blocked / Unknown**, with Zoom, cause and suggested repair. | “P4 label ownership ambiguous—zoom to objects.” |
| **CV8-5** | All writes follow **Plan → Preview → approval → Apply → one Undo**. Heavy repair requires a saved disposable copy. | One `UNDO` restores the complete pre-repair drawing. |
| **CV8-6** | Sync validates stored identities first. It must not discard and recreate healthy records merely because geometry moved. | Moving P3 preserves its lid, remarks, overrides and schedule position. |
| **CV8-7** | Permanent identity outranks proximity. A proximity match is allowed only when unique and clearly within tolerance; ambiguity is blocked. | Labels 1.8 m and 2.1 m from two pits remain unresolved—not guessed. |
| **CV8-8** | Rebuild preserves authored values and provenance. Missing ILs may be proposed from connected pipes, but never silently established. | “Candidate IL 42.140 from Pipe 7” requires approval. |
| **CV8-9** | Compound rebuilding repairs the complete pit/pipe plus its labels, IL text, callouts and stored relationships atomically. | No repaired pit with a stranded old label. |
| **CV8-10** | A polyline on a CE layer is only a **candidate pipe**. Preview type, diameter and endpoints before registration. | A construction line on `CE-SW` cannot silently enter the schedule. |
| **CV8-11** | Drawing upgrades use explicit version steps. A drawing created by a newer CE version enters CE compatibility read-only and is never downgraded. | Normal AutoCAD drafting remains available, but older CE cannot overwrite newer project data. |
| **CV8-12** | Recovery authority: embedded CE identity/data → owned annotations → verified text → geometry. Conflicts produce Unknown. | Stored IL 42.100 versus text IL 42.150 is shown as a conflict. |
| **CV8-13** | `CDRECOVERINVERTS` recreates text only when the value and endpoint are certain. Remove the guessed endpoint order and default 150 mm diameter. | Unknown pipe size remains Unknown, not DN150. |
| **CV8-14** | Unresolved records are quarantined for review, never silently deleted. Produce a local before/after repair receipt without client-sensitive log content. | “2 orphan records retained for review.” |
| **CV8-15** | Heavy scans use cached snapshots and never run continually while drafting. Automated damaged-drawing fixtures carry most testing; Timothy performs one Apply/Undo test on one disposable drawing, targeted at **10 minutes maximum**. | No background repair scan causing cursor or grip lag. |

## Exact stored-link repair engine boundary (2026-09-09)

The first Apply-capable repair engine is held behind the future shared Manager
**Drawing Repair** surface. It does not change the public `CDREPAIR` route yet.
Its bounded automatic batch may only:

- inspect a `PIT_LINK` or `PIPE_LINK` record as repair authority when its embedded
  owner handle is a valid AutoCAD handle equal to the entity carrying that record;
  a copied/cross-owner, missing or malformed embedded owner stays Unknown/Conflict
  and supplies neither removable rows nor self-pipe direction evidence;
- remove a pit-to-pipe, pit-attachment or pipe-attachment row when the referenced
  handle parses as a valid AutoCAD handle and is proven missing or erased in the
  current host drawing; malformed handles and lookup/read failures remain retained; and
- correct one stored self-pipe end when both current endpoint owner handles,
  permanent pit identities, unique ProjectData rows and the existing current
  physical-first/last-to-logical-From/To resolver prove the single alternate pit.
  A reversed pipe is mapped through that direction evidence; an unknown direction
  remains retained. Proximity and display-name-only matching are forbidden.

Every removed row is copied, with its complete original owner record, into the
same drawing's repair quarantine in the same AutoCAD transaction. Unreadable,
present-but-unsupported, ambiguous, protected, Xref/REFEDIT, Source-owned and
conflicting evidence remains untouched and is listed as retained. Stale
self-handles, missing ProjectData creation, cross-link rebuilding, registration,
levels, geometry and upgrades remain outside this batch.

Preview freezes the exact Document/Database, DWG `FingerprintGuid`, full stored
ProjectData, all inspected link Xrecords, referenced-target states and protection
states. Apply recaptures that evidence inside its only write transaction and
refuses the whole batch if anything differs or any planned owner is no longer
writable. Link rows, quarantine and any proven ProjectData end correction commit
together; the live cache is adopted only after commit. Cancel/close has no write
path. A successful commit emits a separate sanitised local receipt containing
only hashes, action codes and counts; no drawing path, project text, level or raw
record content leaves the DWG.

### Held Civil shared-page adapter

Civil registers one nonvisual **Civil exact stored links** contributor without
opening or scanning a drawing. A shared opaque session ID privately owns the exact
sealed preview plan and its original AutoCAD document inside Civil. Apply consumes
that one stored plan, first refuses a different active document, and then delegates
to the same engine recapture/protection/one-transaction path above. Cancel, drawing
activation, drawing close and module unload invalidate the private plan.

Shared display data is deliberately count/category only. Entity handles, drawing
paths, raw record JSON, engine summaries, AutoCAD objects and the repair plan do not
cross the CE_SHARED boundary. Incomplete or retained-unproved evidence stays
Unknown; an Apply result stays Warning until native drawing checks confirm it. A
Healthy result is limited to the explicitly named exact stored-link inspection
scope. The Manager page is available through `CEMANAGER` for native acceptance;
public `CDREPAIR` routing remains held and continues to open the legacy repair window.

Focused managed checks cover carrying-entity versus embedded-owner identity for
pit and pipe records, the exact row match, healthy-row order, full
self-pipe field preservation, reversed and unproved direction handling,
protected/Source retention, truthful Missing/Erased versus malformed/unreadable/
unsupported audit states, hashes/counts-only receipt and the one-transaction
Apply ordering. They pass **44/44** on each of `net48`, `net8.0-windows` and
`net10.0-windows`. Native Preview/Cancel/Apply/Undo/quarantine-save-reopen and the
shared Manager page remain required before this held engine may be exposed.

The Civil adapter checks separately cover private exact-plan identity, one-use
Apply, active-document refusal, cancel/document-change invalidation, Unknown
preservation, sanitized display output and registration/availability without Preview
scanning; they pass **7/7** on each supported target.

**Recommendation: approve CV-08 all.** The most critical correction is CV8-3: an audit must be physically incapable of repairing the drawing.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-60

The matched consultant-input → your-final-drawing corpus is a strong call — it's the HD4 "compare against approved jobs" mechanism aimed straight at import, and the four-way difference classification (import failure / intentional CE change / drafting improvement / Unknown) is what stops it crying wolf: not every difference is a bug. It's the objective gate CV7-6 needs to be measured against, and it's correctly DATA-01-gated. Good.

✅ Approve CV-08 all
Repair is the riskiest area in the plugin — these tools write to fix things, so it's exactly where silent-mutation and data-loss concentrate. This card correctly pulls every safety principle into one place. Four stand out.

🚨 CV8-3 — you're right, it's the most critical
An audit that writes is the worst possible bug: it means you can never trust an inspection, because the act of checking might have changed the thing you checked. "CDAUDIT calls Sync and may write during an audit" has to die. Making the audit physically incapable of repairing (frozen snapshot, no write path even available — RS1's "physically incapable," applied to diagnosis) is the fix. Without it, "I audited and it's clean" is meaningless. Affirm as strongly as you framed it.

🔄 CV8-11 — the forward-compat mirror, and it's the one people forget
CV-01 protected the backward direction (old drawing in new CE → safe upgrade preview). CV8-11 protects the forward direction: a drawing made in newer CE, opened in older CE, goes compatibility read-only and is never downgraded. That's the real data-loss risk across a mixed-version office — an old version that "helpfully" rewrites data it doesn't understand silently strips the new fields. With both directions handled, version skew can no longer eat project data. Important, and easy to miss.

🗄️ CV8-14 — the data-loss keystone for repair
"Unresolved records quarantined for review, never silently deleted" is the single most important safety rule for a repair tool. A repair that deletes what it can't resolve loses data during the act of fixing — and you never find out what went. Quarantine + a sanitised before/after receipt (audit trail without client content, per DATA14) is the safe alternative. This is CV19's deletion-safety, applied where it matters most.

🎯 CV8-13 + CV8-7 — the two silent-guess killers
CV8-13 removes the default DN150 and the guessed endpoint order — two classic fail-open guesses (the DN150 fallback is the cousin of the "failed-parse pipe silently treated as 225 mm" bug). Unknown stays Unknown; a recovered value is certain or absent, never plausible-looking.
CV8-7 is now the definitive statement of the theme running through the whole section: permanent identity outranks proximity; a proximity match is allowed only when unique and clearly within tolerance; ambiguity is blocked, never guessed. In repair — where guessing does the most damage — that's exactly the right law. (CV8-6 and CV8-12 apply it: Sync keeps authored data through a geometry move; recovery shows stored-vs-text conflicts as Unknown, not a silent pick.)
🔒 Locked, nothing starts
Read-only audit, identity-over-proximity, preview→apply→one-Undo, Unknown-not-guess, quarantine-not-delete, version-skew-safe. The repair area — historically the scariest — is now the most disciplined.

📋 On the progress board — a nudge, not a push: you're at 19 sections locked and they're mostly still only in this conversation, not the committed docs (visible commits stop at TF). That's a lot of hard-won decisions riding on one chat. Whenever you're ready, say the word + a destination and I'll write all 19 sections + the foundations into the record in one consolidated pass so the git history matches where you actually are. No rush tonight, but I didn't want 19 sections sitting unbanked without flagging it.
