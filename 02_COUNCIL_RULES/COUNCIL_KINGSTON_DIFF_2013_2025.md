# Kingston Part A — Issue 3 (2013) vs Issue 5 (2025)

**15 September 2026.** Twelve years apart. Both read in full and compared line by line, normalised so that
reformatting does not masquerade as a rule change.

**Headline: far less changed than the raw diff suggests, and the biggest difference is a change of notation, not
of engineering.** That itself is the finding worth carrying forward.

---

## 1. The trap — ARI became AEP

Kingston rewrote every storm frequency from **ARI** ("1 in 5 year") to **AEP** ("20%"). A naive comparison reads
that as dozens of changed requirements. It is not.

| 2013 | 2025 | Actually |
|---|---|---|
| 1 in 5 year ARI | 20% AEP | **same** |
| 1 in 10 year ARI | 10% AEP | **same** |
| 1 in 20 year | 5% AEP | **same** |
| 1 in 100 year ARI | 1% AEP | **same** |

**I nearly reported the Council-asset coefficient table as changed.** It is not:

| Land use | 2013 | 2025 | |
|---|---|---|---|
| Residential | 1 in 5 year, C = 0.6 | 20% AEP, C = 0.6 | same |
| Commercial | 1 in 20 year, C = 0.9 | **5% AEP**, C = 0.9 | same |
| Industrial | 1 in 10 year, C = 0.9 | 10% AEP, C = 0.9 | same |

**Why this matters beyond Kingston:** every council is making this conversion at its own pace. Some documents
will say ARI, some AEP, and CE's own guidebook still uses ARI throughout. **The plugin should hold one of them
internally and display whichever the council uses**, or the same requirement will look like two different rules.

## 2. Rules that did NOT change

- **Step irons where a pit is deeper than 1.0 metre** — word for word in both.
- Permissible site discharge: residential **C = 0.4 regardless of existing imperviousness**, Tc **5 min** under
  1000 m²; industrial/commercial the **lower of existing or C = 0.7**, Tc **7 min**.
- Rainwater tanks: **2,000 L minimum per dwelling**, **50 m² minimum roof area**, contributing **500 L per
  2,000 L tank** or **1,000 L for tanks ≥ 2,500 L**.
- Connection to Council pipes: Council pipe must be **225 mm or larger**.
- Detention criteria: 20% AEP with piped overflow, or 10% AEP without but with an overland flow path, plus
  **1% AEP at trapped low points**.
- Flood safety limits: depth **0.35 m**, velocity **1.5 m/s**, depth × velocity **0.35 m²/s**.
- Special Building Overlay freeboards.

**So the numbers CE relies on are twelve years stable.** That is genuinely reassuring and worth knowing.

## 3. What is genuinely NEW in 2025

| New | Why it matters |
|---|---|
| **AS/NZS 3500.3:2021 named by year** (appears twice; the 2013 issue names no year) | This is the citation that makes CE's 2018 copy a visible discrepancy |
| **Grey surfaces and porous paving counted × 0.5** — "Lilydale toppings" and "porous paving" appear **nowhere** in 2013 | A new rule, and the one that differs from CE's practice of counting porous paving as fully pervious |
| Development category wording tightened — 2013 *"Land development between 1,000 m² and 4,999 m²"*, 2025 *"**Subdivision of vacant land** between 1,000 m² and 4,999 m²"* | Narrows which jobs fall in the band; worth checking it does not move a job type into or out of scope |
| Non-residential band boundary 999 m² → **1,000 m²** | Tidy-up, but removes a 1 m² gap that existed in 2013 |

## 4. What this means for the earlier rulings

**STEP-02 (Tim: step irons over 900 deep) stands, and is stricter than Kingston.** Kingston says 1.0 m, in both
issues. Tim's 900 is more conservative, and it lines up with the 600 × 600 pit depth limit, so it will never
produce a pit that Kingston would reject. Worth recording that it is deliberately tighter rather than a
misreading.

**AREA-01 (porous paving counted as pervious) is the only place CE and Kingston genuinely diverge**, and this
diff confirms the Kingston rule is *new in 2025* — so it is not a long-standing requirement CE has been missing.
It appeared in the last issue.

**STD-03 (work to the edition CE holds) — the 2021 citation is also new in 2025.** The 2013 issue cited
AS/NZS 3500.3 with no year at all, which is why this has not come up before.

## 5. Questions

1. **Did CE know about the × 0.5 rule for grey surfaces and porous paving?** It is new in the 2025 issue, so if
   Kingston jobs have been done since then counting porous paving as fully pervious, the detention volume would
   be smaller than Kingston's method gives.
2. **"Subdivision of vacant land" vs "land development"** — does that reword move any job type CE does into or
   out of the 1,000–4,999 m² category?
3. Should the plugin **hold storm frequencies in AEP and display ARI where a council still uses it**, given the
   conversion is now half-done across councils?
