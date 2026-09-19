# Report fact-review concept — independent visual audit

FOR TIM

The core review and adoption controls work in the offline concept. Three details need correction before this visual is presented as reviewed: stale manual-pin wording, visible original evidence revision, and a result-status warning that disappears after later actions.

---

Actual file opened through file URL with an independent browser script. Initial SHA256: 0072919f947cc7397232ebff4197ad028a0a785f5c68acc1ce1cd0ae26bd6cd3. Receipt: REPORT_FACT_VISUAL_EVIDENCE.json; script: audit-report-facts.cjs. 26 independent Boolean checks passed; zero page errors. These passing checks do not erase the findings below.

## Verified interactions

No adoption on initial load, new revision or unload. Empty selection and unloaded report block confirmation. Unknown discharge has no adoption control. Review enables only selected choices; Cancel and focused Escape retain pending choices/basis while invalidating review. Revision changes actual page/candidate/citation and invalidates review. Confirmation changes selected area, preserves retained manual level, and later level replacement changes current basis/keep option to report. Later candidate revisions do not overwrite adopted values. Discharge remains unresolved/mixed.

## Findings

| ID | Reproduction and actual result | Required correction |
|---|---|---|
| RFV01 / low | Adopt report level, then click Reference level on the page. Excerpt still says to review before replacing the manual pin, although current basis is now report. | Condition the wording on actual governing basis, or use neutral current-basis wording. |
| RFV02 / medium | Adopt Rev C area/level, then find Rev D. Current numbers correctly retain C values, but no current-basis revision/source is displayed; the only visible citation belongs to D. | Record/display adopted source revision/page/identity separately beside governing facts, including retained manual provenance where applicable. Candidate inspection must not relabel old evidence. |
| RFV03 / medium | Adopt a changed value, then confirm Keep or find another revision/Cancel. The sole numerically-out-of-date message is overwritten despite no recalculation. | Retain affected-result state independently from operation messages; unchanged later actions must not conceal the outstanding dependent-result state. |

## Render evidence actually opened

report-facts-desktop.png (1280×720), report-facts-medium.png (1024×768), report-facts-narrow.png (360×800 full page). Text, selected page highlight, controls and values are legible; no observed overlap or horizontal overflow. Footer bottom702px fits desktop720. Narrow footer1419px requires main scrolling: readable responsive fallback, not native no-main-scroll parity. Existing full-page screenshots capture the state after adopted C and candidate D.

## Limits

Synthetic fixed-page/fact simulation; no real report extraction, document deletion, provider use, engineering validity, persistence, native CDDESIGN, multi-source conflict or partial-save execution. Linked treatment/reuse grouping is explicitly unresolved. Browser state alone is not design adoption or Tim acceptance. Findings remain open pending corrected exact-file rerun.

## RFV01–03 closure — 2026-09-17T01:32:05.3712784+10:00

Reran actual file with independent script: 32 Boolean checks passed, zero page errors. SHA256 AD693FB9E3C9A77DE1FFD2877B5CA0CB7AD3A9A89A9BF5028EB7C47E0D2C319F. RFV01 excerpt now follows current report basis; RFV02 governing area/level retain Rev C/page4/C-01 while candidate page is D, with old discharge A evidence separate; RFV03 affected-result state persists after unchanged Keep, new revision and Cancel. All three findings closed for this bounded concept.

Actually opened all three refreshed screenshots. Desktop/medium footer693px; narrow1434px with no horizontal overflow/observed overlap. Existing limits remain: synthetic offline state, no real extraction/persistence/native engineering validation, narrow scrolling is not no-main-scroll parity. Initial receipt preserved as REPORT_FACT_VISUAL_INITIAL_EVIDENCE.json; current receipt REPORT_FACT_VISUAL_EVIDENCE.json. Cleared for bounded concept review only, not whole-plugin completion.

