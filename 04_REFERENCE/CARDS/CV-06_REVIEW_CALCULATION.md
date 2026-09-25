# CV-06 — Review and calculation workspace

**Planning:** approved
**Record:** complete — exact planning-task source recovered 2026-07-22
**Implementation:** in progress — CV6-14 selected-section preview, PDF and XLSX export implemented 2026-09-10; remaining CV-06 scope is not claimed
**AutoCAD verification:** not started
**Design rules enforced:** recorded in the approved decisions and Timothy's review below
**Source task:** `019f822e-367c-78a0-b780-25df7c1381bd`
**Source assistant item:** `item-48`

> The source card and approval text below are preserved verbatim. Approval is a planning decision only; it does not claim implementation or AutoCAD verification.

## Implementation record — CV6-14 selected-section export (2026-09-10)

- The Print tab now prepares one detached package from the exact checked sections: detention, pipe flow, catchments and/or WSUD. The on-screen preview and PDF both read that package. Changing a selected section, calculation value, nested row/measure or cover field invalidates it and disables export until Preview is run again. PDF and XLSX recheck the reviewed package after their modal Print/Save window returns.
- XLSX reads the same prepared package and creates one worksheet per selected section. It retains the displayed labels, units, results, source/status text and project cover fields. The writer is ClosedXML 0.102.3, matching the existing Structural module and its netstandard2.0/net48 compatibility.
- No calculation formula was copied into the export owner. WSUD output is labelled Advisory and states that project authority is unverified. The package does not fabricate a standards citation or document locator.
- Focused production tests pass 7/7 on each of net48, net8 and net10. The added correction guard renames a catchment while flow/status stay identical and proves both exports disable; collection Reset also removes old child observation and registers replacement rows. AutoCAD visual review of the Print tab, one PDF and one XLSX remains pending. Existing `System.IO.Packaging` 6.0.0 NU1903 vulnerability warnings are inherited through the approved ClosedXML version and remain visible for dependency remediation.
- New source-trace requirement: CDCALC currently has no planning/council document-import locator in this export path. Existing pipe prefill source text and catchment intensity authority text are retained; exact Show Source support must come from a separately approved upstream evidence owner before imported document values can claim that capability.

## Approved source card — verbatim

# CV-06 — Profiles, dashboard and calculations

### Current AutoCAD state

| Tool | What works | Required treatment |
|---|---|---|
| `PITSCHEDULE` | Strong core; PS-01 locked | Follow PS-01; remove opening lag/writes |
| `CDPROFILE` | Strong longitudinal-section engine and preview | Fix route selection and stored ownership |
| `CDDASHBOARD` | Good checks, navigation and fix proposals | Make review snapshot genuinely read-only |
| `CDCALC` | Many tested calculation panels | Consolidate rules, persistence and honest export |

Critical findings:

- `CDPROFILE` can select any pit containing “LPD”, even from an unrelated network.
- At a branching pit it follows the first downstream pipe rather than asking which run.
- Dashboard opening can reconcile/write drawing data and run a full scan before displaying.
- Dashboard documentation says read-only, but it now contains Apply and Fix All.
- CDCALC catchments and systems are largely session-only.
- Print options advertise Pipe Flow, Catchments and WSUD sections, but the current export builds only detention pages.
- Labels such as NCC, ARR/BOM, MUSIC-equivalent and Melbourne Water require verified authority before compliance claims.

## CV6-1–CV6-15 recommendations

| ID | Recommended decision | AutoCAD example |
|---|---|---|
| CV6-1 | PS-01 remains schedule authority, CV-02 remains hydraulic authority and QA-01 remains issue authority. CV-06 integrates them without duplicating rules. | One result everywhere. |
| CV6-2 | Keep `PITSCHEDULE`, `CDPROFILE`, `CDDASHBOARD` and `CDCALC`; also expose them through one Review workspace. | Commands remain familiar while review becomes coordinated. |
| CV6-3 | All review tools start from a frozen, non-writing drawing snapshot. Reconciliation is a separate visible action. | Opening Dashboard cannot alter pipe links. |
| CV6-4 | Every finding shows category, severity, rule source and status: Pass, Fail, Unknown or Advisory. | Missing council authority displays Advisory—not Pass. |
| CV6-5 | Dashboard opens immediately with cached results, then refreshes safely without blocking pan, zoom or selection. | Large drainage plans remain smooth. |
| CV6-6 | Dashboard navigation uses permanent entity identity. Double-click may zoom/select but never repair automatically. | “Pipe P4–P5” always navigates to the correct pipe. |
| CV6-7 | Fix and Fix All require Plan → complete Preview → approval → Apply → one Undo. Filter scope and skipped items are shown; stale plans are refused. | “Fix visible 4 of 17 issues” is explicit. |
| CV6-8 | `CDPROFILE` starts from a selected pit, displays every reachable route and asks at branches. An LPD is valid only when reachable along the selected network. | P3 with two outlets cannot choose the first pipe silently. |
| CV6-9 | Missing cover/invert/surface levels remain Unknown. A profile cannot use a false zero datum or fabricate missing rows. | Missing P6 IL is named before export. |
| CV6-10 | A placed profile becomes a linked compound storing route, datum, scales, vertical exaggeration and network revision. Update uses Preview and one Undo. | Design changes can update the existing profile safely. |
| CV6-11 | Every CDCALC panel uses the same CV-02 engine and Rulebook—no duplicate Manning, rational, or detention formulas. | CDEDIT and CDCALC cannot calculate different results. |
| CV6-12 | Calculation panels display **Approved**, **Advisory** or **Blocked**. Unsupported methods remain visible only as clearly labelled advisory tools. | Pump or WSUD output cannot masquerade as approved design. |
| CV6-13 | Inputs, results, overrides, council profile and calculation revision persist with the project. Job/address suggestions require confirmation. | Closing CDCALC does not erase catchments. |
| CV6-14 | Standards names appear only with a verified citation and applicable scope. Export includes exactly the selected sections and previews the actual package contents. | No checked “Catchments” box producing a detention-only PDF. |
| CV6-15 | Automated evidence covers branched profiles, Unknown levels, read-only dashboard opening, stale fixes, save/reopen and complete export. Timothy reviews one profile, one dashboard preview and one PDF—about five minutes. | No repeated calculation checking. |

**Recommendation:** approve CV-06 as presented. It keeps the strong calculation/profile engines while removing false authority, hidden drawing writes, lost calculation data and ambiguous routes.

No files changed, builds run or deployment performed.

## Timothy's approval and refinements — verbatim

### Approval source 1 — item-49

✅ Approve CV-06 as presented
Its defining virtue is what it doesn't do: it's composition, not a fourth authority. That's exactly right, and it's the direct cure for one of the audit's real findings.

🔗 CV6-1 + CV6-11 — the review layer that can't lie
The audit found Dashboard, CDCALC and Ask CE each re-running their own network/hydraulic checks — three calculators, three chances to disagree. CV-06 defines the Review workspace as a view that composes PS-01 (schedule), CV-02 (hydraulics) and QA-01 (issue) — never a new engine. "CDEDIT and CDCALC cannot calculate different results" is HD2 enforced on the one tool most notorious for disagreeing with the drawing. One result everywhere is the whole point, and it's what makes a review surface trustworthy — if it re-derived anything, you couldn't trust it over the drawing.

🎯 The one thing to confirm — don't grow a third dashboard
CV6-2's "one Review workspace" must be the same Manager-owned surface as QA-01's Project QA view — remember CDDASHBOARD was assigned to open that QA view (QA1). If "Review workspace" and "Project QA view" end up as two separate dashboards, you've recreated exactly the competing-home-screens problem SH9 set out to kill. Confirm they're one surface (or one with clear sections), not two.

🔧 Two sharp catches worth flagging
CV6-7 — filtered Fix All is a footgun, and "Fix visible 4 of 17 issues" defuses it. Without explicit scope, you click Fix All under an active filter and either miss 13 issues you thought you fixed, or change more than you saw. Making the scope explicit (and refusing stale plans) is the right guard.
CV6-13 fixes a real data-loss bug. "Catchments session-only" was a logged CDCALC caveat — close the dialog, lose your catchment setup, redo the whole calc. Persisting inputs/results/overrides with the project (SH-04 #4) ends that, and stores the calc revision so staleness is visible.
✅ Two quick affirms
CV6-9 — a profile that uses a false zero datum or fabricates missing rows is a long-section that looks real and isn't (a ~45 m datum error drawn as a clean line). Unknown-named-before-export is the correct honesty.
CV6-14 — "export exactly the selected sections, preview the actual package" kills the "checked Catchments, got a detention-only PDF" mismatch, and "standards names only with a verified citation" stops CDCALC printing AS-compliant on an unverified rule.
🔒 Locked, nothing starts
Strong engines kept, no duplicated formulas, no hidden writes on open, no lost catchments, no silent branch choice. Ready for the next card — and whenever you want, I'll fold this whole civil run (CV-01→CV-06) plus the foundations into the committed record in one pass.
