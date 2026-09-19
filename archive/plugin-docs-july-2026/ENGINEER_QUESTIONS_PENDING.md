# Engineer questions — ALL ANSWERED (2026-06-11) ✅

## Q23 — pre-dev C: RESOLVED (Tim, 2026-06-11)

**Ruling: "We use 0.35 for all jobs — 0.35 unless a specific council has other rules."**

That is exactly the engine's existing configuration (default PreDevC = 0.35 + per-council
`preDevCFixed` overrides, currently Kingston = 0.4). **No engine change.**

⚠ Office templates FIXED 2026-06-11 (Tim authorized): both generic `CALCULATIONS - BOYDS
METHOD.xls` masters corrected 0.4 → 0.35 (pre-fix backups alongside); KINGSTON variants
untouched at 0.4.

**STANDING HOLD (Tim, 2026-06-11): 0.35 all projects / Kingston 0.4 is LOCKED — no change
to pre-dev C in the engine OR the templates without Tim's explicit confirmation.**

---

# Previously pending — ALL ANSWERED (2026-06-11) ✅

Tim answered all five on 2026-06-11 (commit applying them: see REGRESSION_LOG). Record:

1. **Kingston** — requirement text supplied: PSD basis 20% AEP (1-in-5), pre-dev C = 0.4
   regardless of existing imperviousness, 5-min Tc < 1000 m², designer-determined critical
   duration above. "USE 1 IN 5." Kingston UNFROZEN; the 1-in-2 office sheet was not authoritative.
2. **Glen Eira** — AT LEAST half underground (minUndergroundPct = 50, soft rule).
3. **Manningham** — from the OSD Guidelines v001.6 PDF: **min orifice 40 mm** (RWT detention
   orifice 25 mm); head = top of baffle to centre of orifice; in-situ baffle, no plates;
   nearest standard diameter ±2 mm; chamber/baffle/outlet rules captured in the profile.
4. **24-100** — the Boyd's KINGSTON xls (686.4 / 386.12) is the approved set ("USE KINGSTON
   BOYDS") — matches the replication-harness ground truth.
5. **Closed-polygon drafting convention** — YES, but only on jobs where the roof is used
   for the design.

— Original questions kept below for the record —

---

## 1. Kingston requirement text  ⚠ biggest accuracy item
Your screenshot of the Kingston OSD requirement never came through. It decides:
- PSD ARI: **1-in-2 or 1-in-5?** (your office Boyd's sheet used 1-in-2 = 5.24 L/s; council letter said 6.20)
- Which Boyd's sheet is authoritative when two disagree
- Whether Kingston mandates a specific storm duration

**Until then Kingston stays frozen at its current settings.**
→ *Paste the requirement text or re-send the screenshot.*

## 2. Glen Eira ~50% underground — minimum or maximum?
You wrote "50% MAX UNDERGROUND SOFT RULE" — ambiguous. Is it *at least* half underground,
or *no more than* half? Currently treated as an advisory note, not enforced.
→ *One word: min or max (or "leave advisory").*

## 3. Manningham minimum orifice diameter
A minimum applies but the value was never given (Monash 65, Whitehorse 90, Mornington 65,
Casey 50 are all in). Manningham currently has NO minimum enforced.
→ *The number in mm (or "none").*

## 4. Job 24-100 ([job 24-100], Chelsea) — which sheet is approved?
Two conflicting sets exist in the job folder:
- Boyd's KINGSTON xls: site **686.4** m² / impervious **386.12** m²
- Other session record: site **657** / impervious **345**
The xref title boundary reads exactly 686.4, matching the first.
→ *Which pair is the approved design?*

## 5. The office drafting convention proposal (no answer needed — a decision when ready)
Adopting a closed-polygon rule for roof/driveway outlines on future jobs would make every
new job machine-readable (today only ~45% of architects draw closed roofs). Costs the
drafter ~2 minutes per job; unlocks impervious auto-read and large-scale self-checking.
→ *Yes / no / later.*
