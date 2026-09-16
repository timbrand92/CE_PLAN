# Issue recovery — finished files, unfinished package and history

FOR TIM

If plotting stops halfway, CE should show exactly what exists and what remains. Retrying must not create another revision, overwrite the previous issued set or mistake a saved history row for a complete PDF.

This is proposed interaction detail under [shared issue authority and inspected owner](02_SHARED_JOB_AND_ISSUE.md) and [included versus revised sheet contract](23_CHANGE_ALLOCATION_AND_ISSUE_HANDOFF.md). The newer shared owner already has mechanical completion/history checks; this proposal reuses that owner, not a replacement publisher. Full selected-set combined PDF remains the approved target; current combined-per-DWG qualification remains explicit. Nothing is plotted, issued or transmitted here.

## 1. Freeze exactly what is being reviewed

Before producing output, show issue purpose, editable output names/destination, exact drawing/layout/sheet identities in reviewed order, included set and revised subset, current/proposed revision/date, paper/style/grouping and unresolved findings. Review is tied to that content and source state. An output filename alone cannot identify the reviewed package.

QA disposition and mechanical output readiness remain separate. A deliberate recorded engineering departure does not turn Unknown into Pass. Conversely, advisory findings do not create an invented blanket prohibition on printing. Required valid sources, protected-object rules and exact output identity still apply.

### Accepted on screen versus saved source

Before output, show the source state for each included DWG/layout: the basis actually reviewed, whether accepted drawing changes remain unsaved, and which qualified basis the existing publisher will read. A newly placed detail visible on screen is not proof it exists in the saved DWG; a saved file is not proof it includes the latest reviewed edit. This planning has not established the publisher's exact native read behavior for every route.

| Source condition | Proposed review/action |
|---|---|
| Reviewed changes are accepted in the open drawing but not saved | Identify the pending source difference. Offer the owner's qualified Save then revalidate route, or leave the issue unfinalised. Do not claim output will include those changes merely because they are visible. |
| Publisher explicitly supports a reviewed current-drawing snapshot | Bind output evidence to that exact supported snapshot and revalidate it. Do not invent such capability from an active drawing or command return. |
| User intends an earlier saved/issued basis | Make the earlier basis explicit and retain its identity; use only an owner-supported reviewed route. It cannot be described as the current changed drawing. A historical file is not automatically a new issue. |
| Source save fails, is cancelled or cannot be established | Keep accepted on-screen work and the previous saved source distinct. Report actual state; no fake saved receipt, forced discard or silent substitution. Other unrelated drafting remains available. |
| Drawing changes after source validation | Renew the affected source/output review before using the previous confirmation. Reopening a dialog does not make the old source stamp current. |

**First issue example:** a new member detail has been placed but not saved. The selected sheet identifies that difference before output; its proof must correspond to the basis actually used. **Revised issue example:** an accepted beam change remains unsaved while its earlier saved sheet is still available. Do not mark the new revision complete from that older file. The user still chooses included sheets and the revised subset; saving does not itself issue them or increment their revisions.

The exact Save, source capture and plotting sequence remains the existing issue owner's implementation responsibility. This is a missing visible handoff requirement, not a new publisher, automatic save permission, or a claim that all native publishers read only from disk. Future combined qualification must inspect actual output content as well as the source receipt in these two examples.

## 2. Progress with truthful scope

| Stage shown | Visible evidence | Available proposed action |
|---|---|---|
| Reviewed, not started | Exact package and unchanged-sheet dates | Return to edit or Cancel without claiming output |
| Preparing source/output | Specific drawing/layout and resource being prepared | Request Stop; show request pending until the active operation acknowledges it |
| Producing files | Current sheet/file and known completed scope; progress denominator is expected outputs/sheets, not generic time percentage | Stop pending; no promise that the current native operation can be interrupted instantly |
| Verifying result | Expected versus observed files/pages/order and selected-source consistency | Review differences; never mark Complete from command return alone |
| Files verified, history pending | Exact output receipt and pending history action | Record history through existing owner; opening output is separate from finalising issue |
| Issue recorded | Verified package identity and saved history receipt | Open outputs/history; delivery to a client is a separate explicitly authorised action |

No new version increment occurs because a progress window closes, a Stop is requested or verification is retried. Completed earlier operations are not reversed by a Cancel label.

## 3. Recover a partially produced issue

**Example:** six sheets are included and only two revised. Output fails after part of the package is written.

The recovery view lists each expected file/group with **Verified complete / Partial / Failed with known absence / Unknown** and the contained sheet identities where proved. A Failed exception alone is not known absence. For a combined file, a few successful pages do not make the file a verified partial package that can safely be appended; use the publisher's qualified recovery capability, otherwise regenerate to a reviewed separate staging destination.

Proposed actions:

- **Inspect existing output:** verify actual file/readability/expected pages/source identity. Opening Explorer is not this verification.
- **Retry remaining verified scope:** available only where readback proves absence or an exact safe-resume point and original reviewed inputs still match. Preserve completed outputs; no blind retry over possible partial files.
- **Review changed package:** required when source, membership, order, names or revision intent changed. This is a new reviewed package, not permission to reuse an old completion receipt.
- **Leave unfinalised:** retain the receipt and reviewed intent. Existing issued history and prior issued PDFs remain unchanged. A draft/partial file remains clearly non-issued.

If a destination already contains a previous issued package, do not overwrite it to repair this attempt. Show collision and reviewed output identity; choose an allowed distinct output name/destination through the existing naming controls. Choosing an existing file as evidence is not proof it was produced from this reviewed source.

## 4. Files are complete but history save failed

Show **Output verified — issue record not saved** with exact output identity and the failed history operation. The user can retry **Record issue history** using the existing owner receipt, after revalidating unchanged source/selection/manifest. It must not replot, increment revisions again or silently replace another issue's history.

If a retry cannot prove whether history was already saved, inspect the existing record using the operation/package identity before writing. An already-recorded exact result is not a second issue. A conflicting record needs review; do not resolve by matching a display name or today's date.

If source changed after files completed, keep the output as evidence of that earlier reviewed source. It cannot be represented as current output for the changed drawing. Renewed review determines the next issue operation; history recovery is not a way to bless stale files against new content.

## 5. Close, reopen and two-job protection

Close during preparation resolves pending actions through truthful Stop/leave-incomplete state. Close after verified output does not delete files. Close after history saved does not undo the issued record. AutoCAD Undo remains scoped to qualified drawing changes, not a global undo of external PDFs/history.

Reopen shows the original job, intended revision, selected sheets and known operation outcome. Switching drawings cannot retarget retry/finalisation to another project. If the source job is unavailable, retain the receipt as unavailable evidence and allow unrelated work; never attach it to a similar folder.

## 6. Planning stress scenarios

1. Stop requested during one sheet: acknowledge actual boundary; show completed/unknown scope rather than “nothing happened”.
2. Plot returns an error but a file exists: inspect actual file before offering retry; no automatic overwrite.
3. Four files complete, fifth unknown: preserve four, qualify fifth, retain unfinalised issue.
4. Combined PDF has wrong order or missing page: no mechanically complete receipt; history remains pending.
5. Output verified, history write denied: retry history only without a second revision or plot.
6. History response lost: read back operation identity; avoid duplicate record.
7. Change an unchanged included sheet to revised during recovery: renew exact review; do not reuse the prior receipt.
8. Switch jobs during recovery: original identity stays visible; no write into the new job.

These are interaction expectations and owner handoffs, not performed runtime tests. No source, drawing, issued file, manifest or running process was touched.
