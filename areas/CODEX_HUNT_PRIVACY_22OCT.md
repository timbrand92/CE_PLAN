# CODEX independent privacy and security hunt — 22 October brief

1. **ANSWER FIRST — HIGH 2 / MEDIUM 2 / LOW 0.** Four new findings, verified-by-reading. No AutoCAD reproduction, build or test was run. Review completed 23 October 2026, Melbourne time.

2. **Most important: the approved AI connection can redirect drawing information and the access token elsewhere.** The approval check refuses redirects, but the separate sender carrying the actual question, drawing information or page does not. A redirect from that address is the exact condition; this is not evidence that CE Cloud currently redirects or that anyone's data has leaked.

3. **The other faults.** Starting Civil can send its cloud access token over an unencrypted connection if the configured address uses HTTP. Structural keeps a growing diagnostic history containing full drawing paths. A specially formed imported markup package can save its work one folder above where it belongs and reuse another package's saved actions.

4. **SEC-001 remains closed within the source checked.** The old Azure upload code and shipped storage-key configuration are absent from the Civil/Manager release. No new live embedded credential was identified by the targeted text searches. This does not prove historical credentials were revoked or certify installed DLLs.

5. **Next action.** Route H01/H02 to the Civil connection owner and H03/H04 to Structural. The later tester can use the synthetic fixtures below. Manager administrator work stays parked; this report does not propose a new drawing hard-block or reopen the earlier installer findings.

---

1. **Scope and authority.** Read `C:\TimOS\RULES.md`, `ROUTER.md`, the CE plan start/map, the nominated audit and all three available `CODEX_AUDIT_*_22OCT.md` reports. Also consulted the earlier off-PC inventory and relevant bug entries to avoid presenting their privacy faults as new. The specific read-only brief overrides the appended worktree/build/PR instructions. This report is the sole authored repository file.

2. **Pinned source.** After `git fetch origin`, Civil/Manager reference `origin/claude/rel-20261022m` resolved to `40ee0a36f7960145743954b39859eb6c3af92869`; Structural reference `origin/claude/rel-20261022s2` resolved to `2c9a96942a024888a5ab520600f2d5025de83036`. These are the brief's Civil 3.0.70 / Manager 1.1.70 and Structural 1.0.121 sources. Installed binaries were not inspected. All source references below are Git-object lines at these commits: Civil/Manager unless explicitly labelled Structural.

3. **Evidence language.** VERIFIED-BY-READING means the named control flow exists in that source. Predicted native outcomes remain unexecuted. SUSPECTED items are explicitly excluded from the counts. No live credentials, live settings, drawings, private evidence store, server configuration or Windows access permissions were read. No real customer identifiers or secret values are included here.

4. **Test boundary.** Every DETERMINISTIC TEST below is a specification for later execution, not a test result. Use a disposable Windows profile and synthetic files. Network fixtures must use dummy credentials and test endpoints only; never redirect a real seat token. Use the production HTTP transport for redirect checks: an injected message handler does not exercise its automatic redirect behaviour. Test AutoCAD 2024 and 2027 separately.

## Numbered findings

1. **H01 — HIGH — startup telemetry accepts HTTP and an unapproved destination. VERIFIED-BY-READING.**

   **File:line:** `Modules/Drainage/Services/FleetTelemetryStartupService.cs:54`, `:57`, `:68`; `Modules/Drainage/Services/TelemetryQueueService.cs:135`, `:180`, `:187`, `:191`, `:197`.

   **For Tim:** A colleague can open AutoCAD normally and silently send the CE access token without encryption if their cloud address was entered with `http://`. The AI approval setting does not protect this startup call. No drawing content is in a normal heartbeat, but the token is also used for AI access.

   **Exact failure scenario:** Heartbeat is ON; `CE_CLOUD_AUTH` is nonblank; `CE_CLOUD_URL` is an absolute HTTP URL, or an HTTPS authority different from the approved provider. The sender checks only that both environment variables are nonblank, constructs `/v1/telemetry`, attaches `x-api-key` and sends. It neither requires HTTPS nor consults `CeAiProviderApproval`. This works independently of the AI master switch. The same transport also leaves automatic redirects enabled; H02 deals with that separate destination-change flaw.

   **DETERMINISTIC TEST — fixture:** Disposable profile, empty telemetry queue, heartbeat ON and AI features OFF. A local request-capture server listens at `http://127.0.0.1:18765` and returns HTTP 204. Set process-only cloud URL to that address and cloud authentication to a clearly synthetic marker. Keep a different approved HTTPS authority in the fixture policy.

   **Typed steps:** Start AutoCAD using that profile, open an empty synthetic drawing, wait for startup to finish, then type `CDSETTINGS` and verify the heartbeat checkbox is ON. Inspect the request-capture window. Repeat from a fresh process with heartbeat OFF. A third run uses a trusted test HTTPS endpoint that differs from the fixture approval.

   **Assertion:** The capture window must show zero requests to HTTP or to the unapproved authority, with no token received. Current source predicts a `POST /v1/telemetry` carrying the synthetic `x-api-key` in the ON runs; OFF returns before queueing or flushing. Preserve that capture text as evidence, without a real credential. An offline failure is not a passing transport-policy test.

   **Correction direction:** Validate the initial telemetry destination before attaching the token; use an explicit approved HTTPS authority and disable redirects. Continue drafting if telemetry cannot be sent. Do not treat server-side rejection of the payload as protection for a token already transmitted.

2. **H02 — HIGH — AI messages bypass the approval boundary through HTTP redirects. VERIFIED-BY-READING; redirected delivery is not reproduced here.**

   **File:line:** `Modules/Drainage/Controls/CeAssistantControl.xaml.cs:690`, `:703`, `:711`, `:739`; `CE.AI.Core/AnthropicChatClient.cs:37`, `:120`, `:125`, `:129`; `Modules/Drainage/Services/MarkupAnalysisService.cs:234`; `Modules/Drainage/Services/XcivilVisionScheduleExtractionService.cs:292`.

   **For Tim:** CE can correctly approve one cloud address, then send the actual AI request to a different address named in a redirect. For example, an incorrectly configured gateway could receive the question and drawing information although it was never approved.

   **Exact failure scenario:** The approved endpoint returns a valid seat grant from `/v1/access`, then returns HTTP 307 with a different HTTPS authority in `Location` for `/v1/messages`. Seat requests use `AllowAutoRedirect=false`; the separate `AnthropicChatClient` uses the default `HttpClient` transport. There is no redirect refusal or destination revalidation in that sender. The predicted 307 follow-up preserves the POST body and custom `x-api-key` header. Approval checks before a request cannot validate the destination introduced by its subsequent redirect. Both vision paths instantiate this same sender.

   **DETERMINISTIC TEST — fixture:** Two loopback HTTPS endpoints A and B with trusted test certificates and different ports. Only A is approved. A serves a schema-valid, unexpired R2/W1 seat grant matching the fixture policy/account and dummy token. A's messages route returns 307 to B; B records headers/body and returns a valid minimal Anthropic SSE response with text `SYNTHETIC-REDIRECT-REPLY`. Use a synthetic Civil drawing already classified Standard and AI features ON.

   **Typed steps:** Type `CDASK`; send `Reply with the synthetic test marker.` Observe the assistant panel and B's request-capture window. Repeat with a synthetic one-page image through **From file...**, after establishing valid access and a title-block area. Do not use any customer drawing or page.

   **Assertion:** B must receive zero requests, and the assistant must not display `SYNTHETIC-REDIRECT-REPLY`. Current transport predicts B receives the dummy token and complete request, and the chat displays the synthetic reply. The image variant must also send nothing to B. Run a positive control where A returns the same SSE response directly, to establish that the fixture permission and response are valid.

   **Correction direction:** Disable automatic redirects in the shared AI sender and telemetry sender; retain the initial authority check. Test the real HTTP transport, not just the existing fake-handler request shape. No claim is made that the checked-in CE Cloud worker currently emits a redirect.

3. **H03 — MEDIUM — Structural runtime diagnostics retain full drawing paths without size or age limits. VERIFIED-BY-READING.**

   **File:line, Structural:** `Modules/Structural/Models/UserSettings.cs:392`; `Modules/Structural/Services/RuntimeDiagnosticsService.cs:106`, `:858`, `:876`, `:910`, `:919`, `:1067`, `:1088`.

   **For Tim:** Normal Structural commands leave the complete drawing location in a daily history file, including any user or job folders in that location. Those files keep accumulating. A long-running or repeatedly failing session also keeps enlarging today's file; CE's ordinary rolling-log limit does not apply to this second log.

   **Exact failure scenario:** Runtime diagnostics defaults ON, verbose diagnostics OFF. A tracked command such as CEMEMBER completes or is cancelled in a saved drawing. `SafeDocumentName` returns `doc.Name`; `RecordTimedEvent` serialises it unchanged as `drawing`. `WriteJsonLine_NoLock` synchronously appends to `runtime_YYYYMMDD.jsonl`. Neither this service's initialisation nor its writer limits file size or prunes old daily files. The 45-minute queues bound health calculations in memory, not these files. The separate Serilog writer's seven-file retention is irrelevant to this directory.

   **DETERMINISTIC TEST — fixture:** Disposable Structural settings folder with runtime diagnostics ON, verbose OFF. Synthetic mm drawing `C:\CE_PRIVACY_FIXTURE\PRIVATE_MARKER\privacy-probe.dwg`, DIMSCALE 50 and LTSCALE 500. Seed `Logs\RuntimeDiagnostics\runtime_20000101.jsonl` with a synthetic marker and today's file with 6 MiB of valid synthetic JSON lines. Six MiB is a probe beyond Civil's 5 MiB rolling threshold, not an asserted Structural setting.

   **Typed steps:** Open the fixture; type `CEMEMBER`, `SI`, `310UB32`, `Centreline`, `Both`, `0,0`, `3000,0`, then Esc. Inspect today's JSONL in a text viewer and the old file's presence. Repeat the command and restart once.

   **Assertion / current-source prediction:** A new command record contains the full fixture path, including `PRIVATE_MARKER`; today's file grows past its seeded size without rolling, and the old marker file remains after restart. Record the command line's member count and the JSON `command`/`drawing` fields together. The corrected implementation needs a documented finite byte/file/age policy, tested at its actual boundaries; retention and identifier handling must be explicit. No disk-full event or AutoCAD slowdown was measured in this hunt.

   **Correction direction:** Bound this diagnostic stream and retain only the drawing identity needed for troubleshooting. Keep timekeeping/job records under their separate retention requirements. This is a local-history finding; no automatic upload of this RuntimeDiagnostics directory was established.

4. **H04 — MEDIUM — importing package ID `..` escapes the markup package directory. VERIFIED-BY-READING.**

   **File:line, Structural:** `Modules/Structural/Commands/MarkupAICommands.cs:113`, `:137`; `Modules/Structural/Services/MarkupAIStorageService.cs:76`, `:93`, `:107`, `:176`, `:284`; `Modules/Structural/Services/MarkupAIWorkflowService.cs:108`, `:113`.

   **For Tim:** Loading a malformed markup file can put its saved actions outside its own folder. A second such file then picks up the first file's actions, so the review can show work that did not belong to the file just opened.

   **Exact failure scenario:** Imported JSON sets `PackageId` to `..`. Deserialisation accepts it. `SanitizeName` replaces invalid filename characters, but periods remain valid. `Path.Combine(Packages, "..")` therefore resolves to the parent MarkupAI folder. Loading immediately reads its `command-plans.json`; if absent, it builds and writes plans there. No Save click or Run action is needed. Slash characters are replaced, so this particular proof is a one-level escape, not a claim of arbitrary paths or code execution.

   **DETERMINISTIC TEST — fixture:** Disposable profile and two synthetic JSON files. First file: `{"PackageId":"..","IncludesCivil":false,"Items":[],"Unresolved":[]}`. Ensure there is no `MarkupAI\command-plans.json`. Second phase uses the same JSON while the parent file contains one synthetic manual plan: `[{"ActionId":"foreign-action","ItemId":"not-in-package","Executor":0,"CommandName":"SYNTHETIC-FOREIGN-PLAN","Status":0}]`. Do not execute the plan.

   **Typed steps:** Type `CEMARKUPLOAD`; select the first JSON in **Select Markup Package**. Inspect the parent file and command line. Close the markup window. Prepare the second-phase parent file in the disposable profile, type `CEMARKUPLOAD` and select the same empty package again.

   **Assertion:** Loading must keep all new work below a valid individual package folder and must not load the seeded parent plan. Current source predicts parent `command-plans.json` becomes `[]` on the first run; the command line says `[CEMARKUP] Loaded package ..`. In the second phase it reports `Items=0, Unresolved=0, Plans=1`, proving actions came from outside that package. A safe generated ID plus a clear warning can preserve the drafter's ability to inspect the import; this does not require hard-blocking drafting.

   **Correction direction:** Validate imported IDs as single non-dot segments, resolve and check containment before every read/write, and bind saved plans to their package's contents. Also validate the unsanitised ID used by `BuildPackageFileName` at line 280; a broader escape through that filename was not established here.

## What leaves the PC and what stays local

1. **Startup CE Cloud heartbeat — exact application fields.** `FleetTelemetryStartupService.cs:57` creates exactly `installId`, `eventType` = `heartbeat`, `tsUtc`, `pluginVersion`, `acadRelease`, and `tfm`. The timestamp is UTC; the version is the Civil assembly version, not a Manager/Structural inventory. Optional `commandName`, `crashFingerprint`, `count`, `durationMs` and `errorCount` are null and omitted (`TelemetryEvent.cs:34`). There is no drawing name, raw login, raw PC name, drawing geometry or path in this normal event. `x-api-key` carries the seat token in the HTTP header. The receiver also necessarily sees network metadata such as the source IP; that is not a JSON field.

2. **Identity, queue and switch.** `InstallIdentityService.cs:91` hashes machine GUID plus Windows username with SHA-256 and keeps 32 hexadecimal characters. A persisted random GUID substitutes for an unreadable machine GUID. Raw values are not the heartbeat ID. The heartbeat switch defaults ON and has a visible privacy checkbox (`CivilSettingsView.xaml:207`). OFF skips startup queueing and flushing. The queue is `%APPDATA%\CE_CVL_SUITE\telemetry\outbox.jsonl`, rolling at 5 MiB with two backups. One flush sends up to 500 current-file rows, so the startup POST may also carry previously queued events, not just the new heartbeat.

3. **Other CE Cloud telemetry.** The additional production enqueue found is `XcivilVisionFallbackOrchestrator.cs:162`: `installId`, `eventType` = `xcivil_vision_extraction`, `tsUtc`, `count` = extracted pit-entry count. It queues independently of the startup heartbeat switch and is picked up by a later flush. The count is not the combined pit/pipe count. Declared command/crash/AI-usage event names are not proof those event types are actively sent. Worker source validates fields/codes (`CE.Cloud/worker/src/worker.js:192`); the client flush reads raw stored lines rather than validating them again. No live worker or traffic was examined.

4. **Civil AI.** CDASK uses CE Cloud: seat token to `/v1/access`; then the typed question, conversation/tool results and permitted Civil project data/geometry to `/v1/messages` (`CeAssistantControl.xaml.cs:680`). Direct-key chat is refused. AI master switch, project classification, current seat/provider approval and egress audit checks exist. Markup/consultant-PDF paths blank the configured title-block rectangle locally and send one page per request (`MarkupAnalysisService.cs:174`; `XcivilVisionScheduleExtractionService.cs:146`); the PDF fallback defaults to No. The checked-in worker forwards the message body to Anthropic with its server-held key (`worker.js:804`). It is not a second title-block scrubber. H02 applies to the PC's message transport. These checks do not certify that the configured rectangle covers every title block.

5. **Structural AI and dependency downloads.** In the actual Structural release, `MarkupAIOffPcPolicy.cs:32` always returns false. Both old OpenAI callers consult it before reading a key, so those PDF/chat requests are unreachable even with the sending switch ON. Do not repeat the earlier whole-PDF leak as active on this head. Optional local-processing preparation still runs `pip install pyautocad comtypes pywin32` when enabled (`MarkupAIPyAutocadWorkerService.cs:335`); that contacts the configured Python package service. It is a dependency download, not proof that a drawing is uploaded. Existing off-PC audit records already cover this family.

6. **Office reports and time data.** Manager automatically attempts outbox copying to the configured office IT folder after startup, and refresh can retry (`Plugin.cs:140`; `CeAdminStorageService.cs:138`). OneDrive/share synchronisation can then move those files off the PC. This is separate from CE Cloud telemetry. Civil's raw failure details/drawing names and the old/new outbox-root mismatch remain visible in the source (`AdminTelemetryService.cs:176`, `:324`; `CeAdminStorageService.cs:25`); they were already recorded in BUG-553/BUG-491 and are not new counts here. Structural's main admin records hash identifiers and scrub failure text, but H03 concerns a separate runtime log. Existing job-time export routes send hours/job data into configured office folders; they are not governed by the heartbeat checkbox.

7. **Support files and ordinary logs.** CESUPPORT builds a local ZIP and tells the user to send it themselves. Its default remains Desktop unless `supportZipLocalFolder` is ON; it now warns if that location is inside OneDrive (`CeSupportBundleService.cs:50`). This older Desktop/sync issue is not counted again. The ZIP selects recent recognised logs, excludes individual files above 5 MiB and runs a drawing-path/login scrubber. Civil's ordinary log uses 5 MiB rotation with two backups (`CeLogWriter.cs:40`); Civil/Structural structured logs retain seven daily files. These limits do not cover all telemetry/outbox files or Structural's RuntimeDiagnostics JSONL. Local logs are not globally anonymised; a scrubbed support copy is distinct from its source.

## Secrets, permissions and loading checks

1. **SEC-001 re-verification.** Git tree/reference searches show no production `CeAzureBlobService`, `CeAzurePublishService`, `CeAzureReleaseBlobStore` or shipped `blob-config.json` in the Civil/Manager release. The release project also records its removal. `CeApprovedReleaseService.cs:757` requires the office-folder boundary and calls the official verifier with embedded trusted public keys; approval comparison pins hashes/source/profile at line 737. `Shared/CE.Release/OfficialReleaseGate.cs:830` verifies RSA-PSS/SHA-256 signatures and rejects unsafe paths/reparse points in the inspected package route. The earlier release-gate report's separate approval-floor, packaging and activation findings are not repeated or declared fixed.

2. **Credential searches and limits.** Targeted Git text searches for common API-token/private-key/storage-signature forms found no live embedded credential in the scoped production sources/configuration. The sole Civil-side hit in that search was the named `SyntheticCredentialMaterial` test helper (`Installer.Tests/OfficialReleaseGateTests.cs:1500`). Structural AI settings store an environment-variable name; Civil reads cloud credentials from environment variables. The actual environment, private key drawer, installed files, historical Git objects, binaries and logs were outside this read-only source audit. Therefore historical revocation and absence of secrets from every possible local log remain unverified.

3. **File permissions.** Settings, telemetry and runtime logs use ordinary per-user directories and inherit Windows permissions; these writers do not establish a dedicated access list. That does not by itself mean other Windows users can read them. Actual inherited permissions and synced-profile policies were not examined, so no world-readable finding is claimed. Release-authority packaging has an explicit directory-permission step (`Installer/ReleaseAuthorityPackaging.cs:639`); it is not evidence about runtime log permissions.

4. **Deserialisation and imports.** The inspected imports use concrete JSON types; scoped searches found no enabled BinaryFormatter, NetDataContractSerializer or Newtonsoft TypeNameHandling setting. LandXML explicitly prohibits DTDs and uses a null XML resolver (`Modules/Drainage/Helpers/LandXmlParser.cs:99`), so an external-entity leak is not supported there. These are narrow checks, not a universal safe-deserialisation certificate. H04 is an actual path-validation error after ordinary JSON loading. Retired ZIP extraction in `Installer/Program.cs` is under `#if false` and was not treated as an active import route.

5. **DLL loading — SUSPECTED hardening gap, not a fifth finding.** Manager's process-wide resolver loads a matching name from its own bundle directory, then AutoCAD's directory (`Modules/Manager/Plugin.cs:58`). Structural resolves matching names from its plugin path (`CeToolsInitializer.cs:195`). These functions do not recheck a release signature/hash or limit the requesting assembly. A per-user bundle can be writable by that user, but no new permission crossing, malicious installed file or repeatable drafter failure was proven. Later safe check: on a disposable profile, use an inert fixture dependency with a distinct marker and record the resolved full path/marker in an AutoCAD diagnostic command; establish actual ACLs and which caller can trigger resolution before assigning exploit severity. Do not replace a live DLL. The Manager MCP class is a descriptor-only stub, not a listening server.

6. **Delivery and exclusions.** No code checkout, branch, plugin commit, build, test, AutoCAD launch, install or sub-agent. Only this report is staged by name in CE_PLAN, after fetch and merge of `origin/main`; the normal leak-scan push hook is retained. Earlier command-outcome, drawing-write, Structural drafting and installer faults remain with their existing reports. No bug is marked fixed or accepted.

## Summary

1. **Summary.** Four new source findings: two HIGH sending-boundary failures and two MEDIUM Structural storage faults. Normal heartbeat content is six fixed fields plus a credential header; it contains no drawing data. Structural's old OpenAI paths are disabled. SEC-001's removed Azure publishing route remains absent. Older report/privacy faults are cross-referenced without recounting. Installed behaviour, permissions, server configuration and every proposed AutoCAD test remain unverified. Fix the sending boundary first, then bound diagnostic retention and contain markup package paths.
