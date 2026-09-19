# Assistant and cloud recovery — detailed planning extension

FOR TIM

An unavailable assistant must leave drafting usable. A delayed answer belongs to the drawing and evidence it originally reviewed. Stopping or retrying an assistant request must never repeat a drawing change.

## Approved basis and limits

`docs/CARDS/AI-01_ASK_CE_MCP_AUTOMATION.md` records approval of AI1–AI15 and subsequent refinements: permissions at the actual drawing-write boundary, project-carried confidential status, local-only paired connection, explicit Apply and stale-preview refusal. Retain these exact controls. This document elaborates recovery scenarios; it does not approve a provider, send data, change permissions or declare the planned bridge built.

The card's original AI1 calls for CDASK redirect for one Stable release; its refinement says Tim would lean toward a permanent alias. Preserve CDASK access pending the existing owner's precise alias disposition; do not turn that wording into authorised retirement. The old cloud spec's hosting/provider/open-item status is historical and is not a request to reopen settled decisions.

## User-visible states and actions

### First use: choose the actual session before Ask

This proposed interaction fills the ordinary first-use handoff under approved AI2/4/5/7/9/14/15. It does not establish that the bridge is built, grant provider access, or ask to connect anything during this planning run.

| User step | Required visible result and boundary |
|---|---|
| Open the retained Ask CE doorway | Show Disconnected or actual verified connection, selected drawing and effective permissions. Opening the palette does not pair automatically or read a drawing. |
| Review the eligible provider/connection route | Apply the recorded provider and project policy first. Claude production and Tim-only development fallback remain their approved separate scopes; Codex drawing access staysR0 until its distinct approval. No staff key entry or silent provider switch. |
| Choose the local AutoCAD session and drawing | Identify the actual process/session and exact drawing, distinguishing duplicate captions. Selection is pending context, not a permission grant. Ambiguous or unavailable targets remain unresolved. |
| Pair using the local connection's code | The approved localhost-only bridge validates pairing and its short-lived token. Show pending/failed/paired truthfully. No token duration, unattended pairing or remote listener is invented here. Cancel leaves no new authorised session; an already completed prior pairing must be reported separately. |
| Review effective scope | Show the drawing, connection and actual allowed read/write level in the palette. The role defaults remain staff R2/W1, Tim R3/W2, confidential R0/W0, subject to stricter provider/project restrictions. The effective role established by the owner cannot override a denied provider route or confidential job. No self-service role selector is proposed. Unknown permission is blocked. |
| Make the first permitted Ask | Capture only the authorised frozen, non-writing snapshot for that exact drawing/scope; show what is being reviewed and Stop. No SyncWithDrawing, continuous scan or engineering adoption occurs merely from asking. Work pauses at required command/save/plot boundaries underAI14. |
| Review the answer | Show evidence, uncertainty and any proposed next action. An answer is not a drawing change or engineering Pass. Any later permitted write retains Plan/Preview/explicit approval/Apply/currentness checks and its qualified Undo. |
| Disconnect | Immediately end connection authority and make the state visible. Pending requests cannot later borrow it; completed independent actions remain separately recorded. Reconnecting requires a valid reviewed target/scope, not reuse of an expired permission display. |

Confidential status travels with the project. A new drawing or a reopened session must re-establish actual target/policy rather than inherit a caption or elevated display from the last job. Temporary elevation ends with AutoCAD as already approved; reconnect is not an elevation mechanism.

**Example:** two local AutoCAD sessions show drawings with the same basename. The user chooses the verified intended session/drawing before a permitted read-only review. Switching focus to the other session while the snapshot is pending cannot retarget the request. If that route is ineligible, drafting continues and Ask remains unavailable for that drawing; pairing success alone never bypasses the restriction.

Future owner qualification: cancelled/failed pairing; duplicate drawing captions; stale/expired connection; confidential job on another machine; drawing switch before snapshot capture; first permitted non-writing Ask; immediate Disconnect and late result; reconnection without stale permissions. No connection, token, drawing snapshot or provider call was made here.

| State | What the drafter sees and can do | What must remain true |
|---|---|---|
| Ready | Selected drawing, allowed scope, connection, Ask | Scope is actual, not the last drawing's caption |
| Waiting for AutoCAD | Finish current command or Stop | No late action may borrow a new drawing or selection |
| Reviewing | Named evidence/scope and progress; Stop | Non-writing snapshot; drafting remains responsive |
| Partial answer then connection lost | Incomplete answer clearly marked; deliberate retry | Partial text is not a completed design review or approved proposal |
| Proposal ready | Before/after, affected items, source and Apply | Engineering Unknown remains Unknown; permission/currentness rechecked |
| Source or drawing changed | Review needs refreshing | Prior confirmation cannot approve changed targets |
| Stopped | Pending work cancelled; completed separate actions listed if any | Stop is not a claim that an already accepted operation was undone |
| Operation outcome uncertain | Checking actual drawing result; no blind repeat | Establish whether the exact operation committed before offering retry |
| Service unavailable or access denied | Plain reason and recovery route; continue manual tools | No switch to an unapproved provider or personal key |

These are proposed state labels, not a claim that every label currently exists.

## Concrete source evidence requiring owner qualification

Read-only inspection16September2026, current root source:

- `CE.AI.Core/Agent/ClaudeConversation.cs:246–288`: start and completion watchdogs stop awaiting the executor when their timer wins. The pending executor is not cancelled by that timeout path. Its queued callback at250–254 calls the tool with the original cancellation token; there is no timeout-triggered revocation in that callback itself.
- `Modules/Drainage/AI/AutoCadExecutor.cs:97–137`: schedules the supplied callback and later executes it. This inspected executor does not itself bind an immutable drawing identity or permission/revision check.
- `Modules/Drainage/AI/SmartifyPipeTool.cs:63–87`: accepts a cancellation token but calls synchronous Execute without checking it; Execute obtains the then-active drawing and implied selection. Its observed output is a proposal and `IsWrite` is false. This is evidence of a possible late-context read, **not proof of a late drawing write or a reproduced runtime bug**.
- `CE.AI.Core/AnthropicChatClient.cs:59–98`: bounded retries; connection retry stops once a text delta reached the caller. Preserve this distinction in the UI rather than concatenating a restarted answer as one uninterrupted result.

**Required future qualification:** expire pending operation authority after Stop/timeout/disconnect/drawing change; validate exact drawing, selected targets, source revision and permission when execution actually starts and again at Apply. Determine actual committed outcome before retrying a write. Do not claim that stopping an await by itself stops work. Reconcile newer owner implementations before proposing changes; this read describes this inspected copy only.

## Cloud status is not drawing readiness

`CE.Cloud/worker/src/worker.js:729–795` shows a messages proxy, telemetry, fleet and a basic root health response. Root health responds without proving provider credentials, upstream availability, durable telemetry or a valid drawing scope. Product health must separate these facts.

`worker.js:183–218` can return202 with `stored:false` when no telemetry store is bound, and can accept some events while rejecting others. Therefore “request accepted” must not be displayed as “support evidence safely stored”. Inspect actual receipts and retain truthful pending/failed/partial status under the approved support policy. No endpoint was called and no deployment configuration was read here.

The historical cloud spec describes five responsibilities. Observed routes in this file alone do not prove update delivery, remote configuration or feedback storage absent across the product; their existing owners and pathways must be reconciled separately. Do not create a competing updater based on this file.

## Synthetic qualification scenarios

1. Queue a pipe review while a drawing command is busy; timeout; change to another synthetic drawing before the callback begins. Expected: stale request cannot read/apply as though it belongs to the new drawing.
2. Stop during a partial streamed answer. Expected: incomplete state, no duplicate answer on silent retry, no later Apply without a fresh valid review.
3. Accept one exact proposed change; lose the result receipt. Expected: reconcile the committed operation before Retry; do not create a second pipe/member or duplicate issue entry.
4. Receive a healthy cloud root response but provider access fails. Expected: cloud reachable/assistant unavailable, manual drafting remains usable.
5. Support transfer returns accepted but not stored, or partly rejected. Expected: receipt states actual outcome; no false successful archive.
6. Mark a synthetic project confidential, reopen on another machine in a future test. Expected: the approved project-carried restriction persists; local settings cannot silently override it.

These are planning acceptance cases only. No plugin test, live request, source edit or AutoCAD interaction occurred. Independent whole-plugin audit remains in progress.
