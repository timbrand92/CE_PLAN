# Time report — scope, adjustments and export

FOR TIM

Choose the period and people, inspect the included sessions and time components, then export that exact reviewed report. Changing the dates does not relabel an older generated result.

## Authority and source evidence

ST9-13/14 require stable job identity, Unassigned/not billable, genuine active time, excluded idle, traceable manual adjustments and their reasons/user/project/drawing/session. W0-B already defines tracking, idle return and append-only corrections. This card adds report production only; no rates, charging rules, rounding policy, payroll or invoice function is introduced. The unfinished checklist report remains hidden until real.

Actually read canonical ST9-13/14 and root `Modules/Structural/UI/Dialogs/ReportsDialog.xaml.cs:126–202,367–448`, relevant XAML report/date/user controls, and the earlier independent MARKUP_AND_TIME_REPORT_AUDIT. Current dialog generates By Job, By Date or Detailed Sessions into a retained report object. User-filter handler clears that object; date pickers in inspected XAML have no change handlers. Export uses retained report data, not the new visible date fields. The earlier audit's generated-scope freshness finding remains a real source qualification; no native report was executed.

Export handlers call SaveReport, display saved path, then launch Explorer/browser in the same try/catch. A later viewer failure can therefore coexist with an existing file; generic export error is not proof no file exists. Earlier audited writer naming/destination/collision details remain inherited, not newly runtime-tested. Proposed destination/collision review below is not claimed as current dialog capability.

## Proposed ordinary sequence

| Step | What the user sees and does | Scope boundary |
|---|---|---|
| Open Time reports | Use the existing Coordination/Time report route; retain By Job, By Date and Detailed Sessions | Report browsing does not stop or reassign the live timer, correct ledger entries or publish an issue. |
| Choose period/context | Set dates and user scope, inspect stable job/drawing/session membership and the actual time-zone/day-boundary basis | Do not infer another job from a reused folder name. A missing zone/boundary basis stays Unknown; no new zone conversion or midnight-splitting policy approved here. |
| Generate | Build a named report snapshot with exact requested period, included identities, generated time and ledger revision where supported | Pending filters remain separate until generation succeeds. No hidden fallback date span presented as the user's selected period. |
| Inspect components | Show active time, excluded idle, manual adjustments/reasons and unassigned time distinctly; inspect detailed sessions behind a summary | Summary and detail must represent the same reviewed scope. Unassigned remains not billable; report visibility does not reassign it. No implicit double-counting of original and adjusted records. |
| Resolve a correction | Open the existing append-only correction route for that exact session if needed; return to regenerated report | Export is not an editor that overwrites old ledger rows. An unaccepted correction is not counted as committed time. |
| Review file output | Choose supported CSV/HTML output, inspect actual destination, report identity and existing-file collision state | No silent replacement of a prior valid report. Format choice does not change which sessions or adjustment chain are included. |
| Export | Write the exact reviewed snapshot and report actual file/readability state | Exported file, viewer opened and ledger saved are separate facts. A readable CSV/HTML report is not an invoice or drawing-issue record. |

Keep common report controls visible and the generated scope beside the preview. No extra wizard is needed; detailed sessions, adjustment reasons and omissions can be inspected from the same report review.

## Changes while reviewing

### Two drawings, one reviewed report

Fictional integration case with [project context21](21_AUTOMATIC_PROJECT_CONTEXT_BOUNDARIES.md): generate a Job North report, then activate a Job South drawing while the report remains open. The snapshot retains its original job/session membership, dates, users and cutoff. The active drawing must not silently change the report heading, export destination, pending correction's session, or ownership of Unassigned time. A multi-job report likewise retains its explicitly reviewed membership; the drawing switch does not filter it to the active job.

Before export show the exact retained snapshot and destination. Deliberately requesting South's report requires its own regenerated scope; it does not rewrite North's snapshot. If the original job/destination is unavailable, show that limitation and retain the review; no guessed destination in the newly active job. Cancel the export leaves the snapshot intact and makes no timer reassignment or correction. Normal tracking of the newly active drawing follows its existing time owner independently; this report action does not promise to freeze or stop it. No new billing policy is introduced.

This cross-window sequence is a proposed acceptance case, not a native test or proof current exports enforce the boundary. Its implementation needs action-time target checking by the existing report owner, not a second project resolver.

- **Dates/user/job/type changed:** identify the old generated scope and pending requested scope. Require regeneration before exporting the new scope; never make an old report look newly generated by changing its header alone. If deliberate export of the old snapshot is supported, name that scope explicitly.
- **New live time or another adjustment arrives:** preserve the snapshot with its cutoff and show changed ledger evidence. Refresh builds a new candidate snapshot; it does not silently alter a previously exported file.
- **Midnight or overlapping sessions:** show original session identities and the adopted period basis. Do not count a split twice, merge two staff merely by timestamp or fabricate absent idle information.
- **Unreadable record:** show omitted/unreadable evidence with reason and partial-report status, rather than deleting it during repair or presenting a complete total.
- **Filtering:** distinguish display-only filters from exported membership; final output summary always names the actual included scope. No selected grid row secretly changes a whole-report export.
- **Cancel or write failure:** pending export cancellation leaves ledger and prior files unchanged under the proposed owner contract. Inspect an uncertain file before retry; viewer-launch failure only retries opening the existing verified file.

## Fictional example

Generate a Monday–Friday report for one named job with two users, excluded idle, a traceable correction and an unassigned session. Inspect components and the session list. Change dates to the following week: the earlier report must remain labelled with its original period and cannot be exported as the following week. Regenerate, review actual membership, then export CSV. If Explorer fails to open, keep the verified saved-file receipt rather than creating another report. No billing total is invented from these time components.

Future qualification: stable identities, summary/detail agreement, actual zone/day boundaries, midnight sessions, adjustment chain, excluded/unassigned/unreadable evidence, filter freshness, concurrent ledger append, output collisions, CSV/HTML content and viewer failure. None executed. Planning/source evidence only, no implementation or native acceptance claim.
