# Window-to-drawing selection and return

FOR TIM

A large CE window must let us pick on the plan and then return to the same row, values and preview. Picking an outline is not permission to adopt its area or connect it to a pipe.

## Status and authority

Proposed shared interaction detail across the existing reviewed command owners. Read with root05 identity/change contract, root21 project context, root24 discovery, root31 area review and the Structural detailed cards. It retains CE appearance, approximately90% AutoCAD-owner sizing, large previews, visible actions and minimal tabs/no main-page scrolling on the intended desktop. Exact native hide/restore/focus behaviour remains to be proved; this is not a claim that every current window behaves this way.

This proposal does not redesign active CD/PIT, replace approved command prompts, or introduce manual alignment in CV7 import (that route expressly requires its approved alignment preview and no manual pick-point placement). It applies only where selecting/drawing in AutoCAD is already an allowed workflow.

The large-window handoff applies to an originating design/review window. It does not require native commands to open one, change an approved picker, or turn the dockable Ask CE palette into a modal window; retain the interaction-type qualifications in19.

## Before, during and after a pick

| Stage | Proposed user experience | Boundary |
|---|---|---|
| Before picking | The button names the purpose: Select boundary, Select member, Select destination or Locate on plan. Header identifies the original job/drawing and selected row. | No generic Pick that conceals whether the result changes identity, engineering allocation or only preview |
| Start pick | Preserve typed fields, selected row, review basis, pending edits and preview position. Temporarily yield drawing space through the owner's supported native route. Show the existing command prompt and selection eligibility. | No Apply/Save merely to move the window out of the way; no separate full-size window covering the drawing |
| Hover/preview | Where supported, highlight only the candidate being inspected and identify local/protected/foreign/ambiguous state. | Highlight is temporary non-printing presentation; it does not establish a connection, governing value or permission to modify |
| Accept valid selection | Restore the same window/row with selected identity and a large relevant preview. Show the resulting proposal and any differences from the previous selection. | Selection populates a candidate according to the reviewed command. A separate engineering confirmation still applies wherever the approved workflow requires it |
| Invalid or ambiguous selection | Give the concrete reason and allow another selection or cancel. Preserve prior valid selection and pending values. | Do not substitute nearest eligible geometry, silently erase prior identity or insert Unknown as zero |
| Escape before accepting selection | Cancel this pending pick and restore its originating review with prior values intact. | Proposed default for this shared sequence only; owner-specific immediate actions and command Escape semantics require reconciliation, not blanket override |
| Close originating window while pick is pending | Cancel the pending handoff, resolve drafts through its existing close rules and ignore late selection completion. | No late callback reopens a closed window or applies to whichever row/job is now active |

The return target includes job, drawing, originating window instance, row and operation purpose. A visible object label alone cannot identify it. If the original object or evidence changes while the user is in the drawing, the restored review shows Changed since preview and requires revalidation of affected proposals.

## Four representative uses

### Reference points are different from editable objects

Normal native protections do not turn every Xref or locked-layer reference into forbidden evidence. The purpose of the pick must remain explicit:

| Pick purpose | Preserved boundary |
|---|---|
| Snap to a point or inspect background geometry | Where the reviewed command/native context permits, use it as read-only location evidence. This does not unlock, clone, adopt or modify the referenced object. It does not prove a hydraulic connection or load-bearing intent. |
| Select a referenced object as evidence | Use only the owner's qualified read-only reference route, retaining source identity and availability. Eligibility for measurement/reference is separate from local editing or permanent relationship adoption. |
| Edit, adopt or transform an object | Check the exact workflow's local/foreign/protection eligibility. Do not bypass locked-layer, Xref, REFEDIT or unsupported-object protections, or substitute a local clone to evade them. |

For example, picking two wall-marker points against an architectural Xref can supply location evidence without editing the Xref or proving that the wall bears load. The local marker's output space, authority and protection checks remain separate. This clarification does not permit CV7's prohibited manual alignment picks, and does not claim every command supports every reference context.

1. **Catchment:** typed manual area remains visible while selecting an existing roof outline. On return show measured area alongside report/manual/governing values. Selection does not discard the typed value or automatically adopt the measurement.
2. **Structural detail:** selecting a local beam returns its drawing/view/level identity. Selecting a copied beam does not inherit the original support/calculation relationship. Manual creation remains separately available.
3. **Destination review:** selecting a proposed destination shows the old and new destinations and affected allocation basis. Merely locating the candidate on plan does not reconnect a DP. The active item/network owner's approved review remains authoritative.
4. **Locate finding:** highlight an affected pit/member/sheet reference, then return to the same finding. This is inspection, not repair or relinking. An unavailable target stays unresolved; no nearest-object replacement.

## Interrupted picks and drafting context

| Interruption | Required distinction |
|---|---|
| User activates a different recognised job/drawing | Shared context may follow the recognised drawing, but the original pending pick/draft remains tied to its origin. Suspend/cancel that pick and offer return to its original review; do not consume a selection in the new drawing as if it belonged to the first |
| Original drawing closes or object is erased | Retain a missing-target finding and draft where supported. Do not claim automatic recovery or recreate the object |
| Another native command is active | Respect the command owner's availability and normal AutoCAD interaction. Do not secretly cancel the user's command to force a pick |
| Window cannot safely yield/restore in its current host | Explain unavailable selection action and retain inputs. The exact supported fallback is an owner/native qualification, not an invented second implementation |
| Accepted immediate drawing action occurred before return | Show that actual action and its qualified Undo/save boundary. Escape of the next prompt does not undo earlier accepted work |
| Repeated click/late completion | One active pick for the originating review; no duplicated actions or late result applied to a new row. Disabling/re-enabling must preserve keyboard access and visible status |

## Proposed native acceptance package

Use one synthetic drawing with a roof outline, local beam, protected Xref and two recognised test-job drawings. Enter unsaved values, pick valid/invalid/protected objects, Escape, change active drawing, erase a selected test object, and close the originating review during a pending selection. Verify the exact row/values return, temporary overlays clear, no unintended connection/adoption occurs, and protected content is unchanged. At intended desktop scaling verify the large preview and footer remain usable before and after drawing selection.

This package is future native evidence. Offline mockups cannot prove owner sizing, AutoCAD focus, active-command interaction, Escape, Undo or saved drawing state. No native operation was run here.
