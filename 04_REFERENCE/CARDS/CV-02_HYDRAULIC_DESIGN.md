# CV-02 — Gravity pipe hydraulic design engine and rule values

**Planning:** approved
**Record:** complete — exact source recovered from the planning review chat, 2026-07-22
**Implementation:** not started
**AutoCAD verification:** not started
**Design rules enforced:** one hydraulic engine (identical results from identical inputs); sourced/versioned rules; Fixed levels win → "No feasible solution", never move survey; Unknown/Advisory never a false Pass; one rounding policy (no drift); engineering firewall (frequency never sets a value)
**Source:** planning review chat (this session) — Tim's posted CV-02 behaviour card (HD1–HD15) + values card (HV1–HV15) + assistant approvals

**CV-02A planning gate, updated 2026-07-24:** the dedicated
[Assisted pipe sizing plan](../workflows/CV-02A_ASSISTED_PIPE_SIZING_PLAN.md)
and two-visual review package are ready for Tim. They separate
designed-plan checking from advisory scratch design; show full-network,
multi-LPD, full-schedule, item decision, disabled-action, runtime-tier and
keyboard/DPI states; and keep the safe advisory foundation separate from
production Pass/Fail and Apply. All illustrated values are synthetic and marked
not verified. Production remains blocked by unverified rule authority and
DATA-01 approved-job validation.

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification. CV-02 owns hydraulic behaviour across CD · CDEDIT · CDINSPECTOR · CDRUNSOLVE · CDCALC Pipe Flow.

## Approved source card A — verbatim (behaviour: HD1–HD15)

# CV-02 — Gravity Pipe Hydraulic Design

*This first batch decides how calculations behave; the values batch (below) covers the numeric rulebook.*

### Current AutoCAD state

| Area | Current condition |
|---|---|
| Grade advice | Built into CD and CDEDIT, but relies on partly unverified rules |
| Flow sizing | Optional Q value can check/upsize pipes |
| Network solving | Preview/apply exists but depends on the same conflicting rules |
| CDCALC | Separate calculator can disagree with drawing commands |
| Velocity | UPVC currently has conflicting 3.0 and 6.0 m/s limits |
| Cover | Some paths use a global 600 mm instead of council requirements |
| Self-cleansing | Current engine checks full-pipe velocity, not necessarily velocity at the actual flow |
| Auto-design | Strong offline engine exists but is not yet connected to AutoCAD |

### HD1–HD15 proposed decisions

| ID | Recommendation |
|---|---|
| HD1 | CV-02 covers gravity pipes. Charged pipes, pumps and detention use the same rulebook but receive dedicated workflow reviews because their calculations differ. |
| HD2 | One hydraulic engine supplies every command. CDCALC, CDEDIT, Inspector and CDRUNSOLVE must return identical results from identical inputs. |
| HD3 | Rule priority is: project requirement → council profile → CE office rule → verified standard → advisory placeholder. The winning source is always displayed. |
| HD4 | Every rule carries its source, approval status and version date. Changing a rule triggers automated comparison against approved example jobs. |
| HD5 | Every design flow records its source: catchment calculation, council information, import, manual entry or upstream total. Hand-entered flow is Designed by default and can be locked. |
| HD6 | CE may total flows through a connected network only when upstream sources are known. A manually locked downstream flow overrides aggregation, with any mismatch clearly reported. |
| HD7 | Show full-pipe capacity separately from performance at design flow. Until partial-flow calculations are verified, CE must not claim that a pipe passes self-cleansing requirements from full-pipe velocity alone. |
| HD8 | CE never downsizes an existing pipe automatically. It may recommend keeping or upsizing it; downsizing requires an explicit separate approval. |
| HD9 | Fixed levels always win. If fixed inverts, cover and minimum grade cannot all be satisfied, return No feasible solution—never move surveyed information. |
| HD10 | Grade labels show the achieved grade from the final inverts, as 1:N, with no MIN/MAX suffix. The proposed grade remains visible in the calculation record. |
| HD11 | Cover means vertical distance from the governing surface/design level to the pipe obvert. Check both ends and the worst point along the pipe where reliable surface information exists. |
| HD12 | If no reliable surface exists, cover status is Unknown, not Pass. CE identifies exactly what information is missing. |
| HD13 | Pipe materials, standard diameters, Manning roughness and velocity rules come from one controlled catalogue. Unknown materials cannot inherit a generous default silently. |
| HD14 | Calculate internally at full precision, then use the approved common rounding method for stored and displayed values. Repeating the calculation must produce no drift. |
| HD15 | Every result is one of: Pass, Advisory, Fail, Unknown, or No feasible solution. Show the controlling reason and safe options; automate comparison tests before Tim's one ≤10-minute AutoCAD check. |

```text
Example result — Pipe P3 → P4
Design flow:      32 L/s — Catchment calculation 🔒
Diameter:         DN225 UPVC
Capacity:         PASS
Design-flow test: ADVISORY — partial-flow rule not verified
Cover:            FAIL at downstream end
Grade:            1:186 achieved
Rule source:      Council profile, version 2026-07
Result:           NO FEASIBLE SOLUTION with current Fixed levels
Options:          Review alignment / cover / diameter
```

## Approved source card B — verbatim (values: HV1–HV15)

# CV-02 — Hydraulic Values Batch

Official basis: Victoria requires AS/NZS 3500.3:2025 for plumbing work commenced from 20 October 2025 (older projects may retain an earlier applicable edition). Council values genuinely differ (e.g. Casey, Yarra, Maroondah publish different grades, velocities and cover requirements) — hence council overrides.

| ID | Recommendation |
|---|---|
| HV1 | New Victorian jobs use AS/NZS 3500.3:2025. Store the applicable edition with the project; never silently update an existing job's rule version. |
| HV2 | Office baseline minimum grades: DN90–150 = 1:100; DN225 = 1:200; DN300 = 1:250; DN375 and larger = 1:300. Council/project rules override this table. |
| HV3 | Retire the conflicting global 1:200 "too-flat" rule. Every grade check uses the diameter/council table. |
| HV4 | Proposed office self-cleansing baseline at actual design flow: 0.75 m/s when half-full or greater; 1.00 m/s below half-full. A council-specific value overrides it. This replaces the unverified global 0.6 m/s Pass. |
| HV5 | Remove the automatic 6.0 m/s unknown/default cap. Show an early advisory above 3.0 m/s, but authoritative maximum velocity comes from the council, project or verified material source. If none exists, maximum-velocity compliance is Unknown. |
| HV6 | Proposed Manning roughness: plastic 0.010, concrete/RCP 0.013, metal 0.012, GRP 0.011. Store the source; unknown material produces Unknown, not concrete's 0.013 automatically. |
| HV7 | Base diameter catalogue: 100, 150, 225, 300, 375, 450, 525, 600, 675, 750 mm. Only offer sizes available for the selected material and pipe class. |
| HV8 | The current 600 mm cover becomes an office design target—not a universal compliance minimum. Pass/Fail comes from the project/council/location rule. Missing location or rule produces Unknown. |
| HV9 | Cover is measured to the pipe obvert (top). New pipes use proposed finished surface; existing pipes use verified existing surface. Check the lowest cover along the complete alignment. |
| HV10 | Maximum cover has no universal value. Pipe class, bedding, traffic loading and manufacturer/council limits determine it. Missing class/loading information gives Unknown structural suitability. |
| HV11 | Pit drop: retain 5 mm as the editable office design default. A council minimum—such as 20 mm where required—overrides it. Never call 5 mm compliant without a source. |
| HV12 | Capacity Pass requires design flow ≤ calculated capacity. Add an office warning at 90% capacity so designers see pipes with little remaining allowance. |
| HV13 | No default design flow. Every Q records L/s, AEP/storm event, calculation method, catchment and source. Missing flow propagates an Unknown hydraulic result. |
| HV14 | Display precision: levels 0.01 m, grade integer 1:N, flow/capacity 0.1 L/s, velocity 0.01 m/s, cover nearest millimetre. Calculations retain full precision until the approved final rounding step. |
| HV15 | Use 9.81 m/s² everywhere a gravity constant is required. Rulebook version, council profile and every governing value are included in the calculation record and automated comparison tests. |

```text
Three high-impact changes
0.6 m/s full-pipe Pass  →  0.75/1.00 at actual flow
Unknown material = 6.0  →  Unknown compliance
Cover = 600 everywhere  →  Council/location rule
```

## Timothy's approval and refinements — verbatim

### Approval 1 — HD1–HD15 (behaviour)

✅ HD1–HD15 approved. The best-designed card yet — a hydraulic engine whose defining trait is that **it refuses to make a claim it can't stand behind.** Advisory instead of false-Pass, Unknown instead of assumed-Pass, "No feasible solution" instead of silently moving survey data. That posture *is* the cure for "confidently wrong at scale."

🔑 **HD2 is the keystone.** "One engine, identical results from identical inputs" permanently ends the audit's #1 root cause — the same rule living in 3–4 code paths (`PipeEditCommand.BuildGradeValue` drifted from `CdCommand.BuildGradeValue`; CDCALC disagreeing with the drawing; g=9.8 vs 9.81; Co 0.6 vs 0.61). After HD2, the calculator and the drawing **cannot** disagree, because there's only one of them.

💧 **HD7 is the sharpest engineering catch — and you're right.** A pipe flowing 20% full moves water much slower than the same pipe full. Self-cleansing has to be met at the actual design flow, so checking full-pipe velocity and stamping "passes self-cleansing" is genuinely wrong — that pipe could silt up at low flows. HD7 correctly separates capacity from design-flow performance and refuses the pass until partial-flow is verified. Build note: partial-flow is standard part-full Manning (depth/diameter → area + hydraulic radius → velocity, solving for normal depth) — so "not verified" means "not yet implemented + validated against known values," not "hard."

🛡️ **The honesty trio — HD9 · HD12 · HD15.** HD9 (Fixed levels win → "No feasible solution", never move survey) is the single most important safety rule. HD12 (no surface → Unknown, not Pass) kills the fail-open default. HD15's five states make the whole thing honest. **One principle to state explicitly: Unknown must propagate** — an Unknown input yields an Unknown result, never a guessed Pass/Fail downstream (chains HD6 → HD9 → HD15).

🔄 **HD4 is how the rulebook stays safe as it grows.** "Change a rule → auto-compare against approved example jobs" means you can't quietly alter a value and break three known-good designs — the corpus becomes your engineering regression baseline.

📝 **One precision note on HD2.** Make the rule version part of "inputs." Two commands match only when they use the same geometry, flows and the same version-stamped rule set (HD3/HD4).

### Approval 2 — HV1–HV15 (values)

✅ HV1–HV15 approved — with the right caveat: I can check these for internal consistency, sanity against standard practice, and the things that need verifying — but the **authority is AS/NZS 3500.3:2025 + the council documents + you** (the licensed engineer), not me. The proof that these are *right* is **HD4 running them against your approved corpus jobs** before they drive a single live Pass/Fail.

The three high-impact changes are all the same good move — from a false "Pass" to an honest answer: `0.6 full-pipe → actual-flow` · `unknown = 6.0 → Unknown` · `600 everywhere → council rule`.

💧 **HV4 — your strongest rec, and the one I'd handle most carefully.** The engineering is sound (at low flow depth, particles are harder to move, so a higher required velocity below half-full is defensible). But: **(1) source it as a CE office rule, not AS/NZS** — I don't believe 0.75/1.00-at-half-full is code-specified; confirm no council mandates a specific value that outranks it. **(2) Run it against the approved corpus before it goes live (HD4)** — keep HV4 Advisory-only until you've seen the flag rate and it's catching marginal pipes, not crying wolf on sound ones. **(3) The half-full threshold is a cliff** (49% needs 1.00, 51% needs 0.75) — fine as a simplification; watch for flip-flopping near d/D≈0.5.

🔎 **Three things to verify (not change).** HV2 grade table vs the 2025 edition (the encoded values are likely from an older edition). HV2 mentions DN90, HV7's ladder starts at DN100 — reconcile. HV12's 90% capacity warning — many designers target ≤80% for gravity pipes; your call, it's a warning not a fail.

✅ **The rest are standard and correct.** HV5 resolves BUG-080 the right way — it stops pretending an unsourced placeholder is authoritative (advisory >3.0, Unknown without a real source). HV6 Manning values are textbook-standard. HV8 + HV10 correctly make cover location/loading-dependent. HV13 "no default design flow, missing → Unknown" is critical. HV14/HV15 (precision + one gravity constant 9.81) make HD14's "no drift on repeat" actually true.

🔒 Behaviour + values now defined — the corpus is the gate. The numbers look right and consistent, but "look right to me" isn't the bar: verified by you against the 2025 standard + council docs, stored sourced-and-versioned (HD4), and validated against your approved jobs without breaking them — that last step is non-negotiable before any of these drive a live Pass/Fail.
