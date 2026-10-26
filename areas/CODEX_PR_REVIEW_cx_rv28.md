**ANSWER FIRST — Codex second opinion, 26 October 2026, 22:38 Melbourne (AEDT)**

1. **PR #1788 — HOLD.** Keep `drainPluginOutbox` OFF. The extra upload can carry private text and damaged records, and it deletes records which were never sent. Structural records do not stay on the PC as the brief requires: they are deleted.
2. **Agreement count: 0 agree, 1 disagree.** Opus said MERGE-WITH-FIXES for predecessor #954; Codex says HOLD for replacement #1788. The requested temporary-file fix is present, but the privacy boundary is still incomplete.
3. **Most important finding:** “Civil record” is accepted by searching for a piece of text, without checking the complete record. Some text is never cleaned. For example, a damaged record containing the Civil identifier followed by unfinished private text is still written to the office folder.
4. **Tim's decision:** before ON ever ships, approve the exact information and people allowed to receive it. Recommendation: keep OFF until the faults below are fixed; send only explicitly approved Civil fields and keep unsent records locally. For example, support could receive a job number and command failure, while a client name and Structural history stay on the PC. The train list's permanent-deletion policy is not approval from Tim and conflicts with this brief. No engineering decision or Manager administrator expansion is needed for this review; the 9 November Civil + Manager release remains the scope.

---

**Technical evidence and method**

1. **Read-only work — verified-by-reading.** Read RULES, ROUTER, CE_PLAN's start/map and Manager area, then the C-69 list section 1 item 11 and section 2. Used live `gh pr view 1788 --json headRefOid,baseRefName,headRefName,state,isDraft,files`, `gh pr diff 1788`, `git fetch origin`, `git show`, `git diff` and `git grep`. Read the upload implementation twice, including its full head version and numbered second pass, plus the tests, switch reader, actual Civil writer and scrub helpers. Only this report was created by this review.
2. **Independence limitation — verified-by-reading.** The required train list already disclosed the older verdict. My initial read of the R2 report for its method also exposed its summary verdict before the code review; that was a sequencing mistake, so this was not fully blinded. I formed and stated HOLD from the code before opening the detailed Opus item 11, then compared it. Findings below come from code paths and explicit counterexamples, not from adopting that summary.
3. **Method adapted to the brief — verified-by-reading.** Used the existing reports' cause, scope, tests, protected-file and train-overlap checks, and their verdict vocabulary: MERGE, MERGE-WITH-FIXES, HOLD, REJECT. No trial merge of code, build, test execution, AutoCAD, installation, sub-agent or PR mutation. The CE_PLAN merge was the explicitly authorised report-saving operation. The installed DLLs were not inspected: this is a PR-head review, not an installed-version acceptance claim.
4. **Evidence labels.** “Verified-by-reading” means directly established from the named source, including a deterministic manual trace; it never means executed. “Suspected” means a possible runtime circumstance not observed here. No invented string below names a real client, site, login or computer.

---

1. **PR #1788 — BUG-552a, Manager plugin-outbox upload — HOLD**

   **Head read — verified-by-reading**

   Live head `4b5cc0c53645a678eeb09570c763a3603ba55d98`, branch `fb/r2fix-954-bug552a`; OPEN and draft. Rechecked before writing this report: unchanged. It exactly matches the reference head in `TRAIN_C69_PR_LIST_2026-10-26.md` section 1 item 11.

   Base branch `claude/rel-20261025r`, fetched tip `d8840a0920f97fedc3b94f98e56eb5a4eb6b663e`. The live diff and local base-to-head diff both contain four files: `Modules/Manager.Tests/Services/CeAdminPluginOutboxDrainTests.cs` +419; `Modules/Manager/Services/CeAdminStorageService.cs` +266/-1; `Modules/Manager/Services/CeOneGlanceStatus.cs` +6; `REGRESSION_LOG.md` +70. All code line numbers below refer to this head.

   **What it changes in AutoCAD, for Tim — verified-by-reading**

   With the switch OFF, this adds no plugin-outbox upload. With ON, Manager's existing start-up, refresh and Upload actions also process Civil and Structural's shared queue. Civil reports which pass its check are written to the office IT folder. This changes reporting, not pipes, pits or drawing geometry.

   The implementation also destroys old queued files, Structural records, unidentified records and old support bundles. An apparently successful upload can therefore mean “nothing sent, several records deleted”. This contradicts the brief's “Structural records stay” and “nothing is deleted ... without being sent”.

   **Checks and results**

   1. **Claimed cause: PASS — verified-by-reading.** `Shared/CE_SHARED/Services/CeTelemetryStore.cs:59` puts the plugin queue under `%APPDATA%\TIM_CE_CADTOOLS\CE_Admin\outbox`. Manager's `CeAdminStorageService.cs:24` uses `%APPDATA%\CE_CADTOOLS\CE_Admin`, and the base's `TryUploadOutbox` only calls `UploadOutbox` on that folder. The one-time move at lines 35–39 does not continuously collect later plugin writes. The missed second queue is real.

   2. **Scope of fix: PARTIAL — verified-by-reading.** The last commit's `.tmp`/`.bak` exclusions are correctly applied to the age-delete loop at storage line 264 and upload loop at line 316, case-insensitively. The broader PR also establishes a new off-PC data route and permanent deletion policy. Its effect exceeds “upload Civil records after cleaning them”.

   3. **OFF behaviour: PASS for the new queue route, with a qualification — verified-by-reading.** Storage line 207 gates the backlog read/delete, first-ON stamp and plugin-file upload. OFF does not enumerate, read or send that queue through the new route. The normal Manager upload still runs at line 206. The call does read the switch file and constructs path/identity arguments even when OFF; “nothing new is read” cannot literally include the switch and environment values themselves.

      The existing `GetLocalRoot` migration can move the old plugin folder into Manager's folder before the ordinary, unfiltered Manager upload. This predates this PR. OFF therefore means no *additional* plugin drain, not proof that no plugin-origin record can ever leave through the old migration route. Current PC migration state was not inspected.

   4. **Switch/default/old settings: PASS — verified-by-reading.** `CeOneGlanceStatus.cs:240` defines `drainPluginOutbox`; line 243 reads it through `ReadFlagFromFile`. Default path is `%APPDATA%\CE_SUITE\manager-switches.json`. Missing/unreadable/oversized/invalid JSON returns false; an older valid file without the key returns false; only the Boolean true enables it. `CeSwitchJsonReader` rejects duplicate names, incomplete JSON and trailing data. A missing file cannot create or enable this switch.

      Minor consistency issue: the new key is absent from `ParseObject`'s known-switch type-validation list. A string value still returns false for this switch, so this does not enable sharing; it merely lacks the same “broken switch” reporting as existing keys. Add the key to that list when repairing the PR.

   5. **Exactly what leaves with ON: unrestricted record contents after partial string substitution — verified-by-reading.** Destination is `GetItAdminPath()` plus `CE Plugin Admin`, retaining the source relative folder and filename. It is a filesystem write to the office share, not a new HTTP endpoint. The code does not restrict records to the following schemas: these are the current Civil producer's fields, read in `Modules/Drainage/Services/AdminTelemetryService.cs:34`, `:53` and `:68`.

      **Machine report, every field:** `PluginId`, `PluginVersion`, `InstalledVersion`, `LoadedVersion`, `BuildType`, `UserName`, `MachineName`, `AutoCadVersion`, `LastSeenUtc`, `HealthState`, `StatusSummary`, `RestartRequired`, `IsLoaded`, `IsInstalled`, `SourceRoot`.

      **Command usage, every field:** `PluginId`, `PluginVersion`, `UserName`, `MachineName`, `AutoCadVersion`, `CommandName`, `Result`, `StartedUtc`, `FinishedUtc`, `DurationMs`, `DrawingName`.

      **Fault, every field:** `PluginId`, `PluginVersion`, `UserName`, `MachineName`, `AutoCadVersion`, `Utc`, `Category`, `CommandName`, `Severity`, `Message`, `Details`, `IsCrashInference`.

      The current producer hashes the login and computer name; those stable codes remain in the payload and machine filename. They are pseudonyms, not removed fields. Usage retains command, result, timing, duration and a drawing/job label. Faults retain diagnostic text/stack information after cleaning. Machine reports retain versions, health, load state and source-root text. Civil's local `SessionState` is outside `outbox` and is not normally sent by this route.

      **Beyond those fields:** every unrecognised field, property name, number, Boolean and null is retained; string array elements and unmatched text are not processed by `AnyTextField`. Relative directory names and filenames are copied unchanged. Thus no finite “only these fields can leave” guarantee exists. The normal Manager outbox also continues uploading its existing contents, independently of the new Civil check.

   6. **Scrubbing: FAIL — verified-by-reading; five manual examples below.** Storage lines 349–354 scrub only regex-matched quoted property values, excluding any property named `PluginId`. The scrubber at `CeSupportBundleScrub.cs:97` removes recognised paths, not arbitrary client/site prose. Its bare-name rule at line 34 removes only the final word of a spaced drawing name without a job number. CE-own-folder exceptions also retain some non-drawing paths. The unchanged `CePiiScrub.cs:44` leaves names shorter than three characters and some longer names embedded in words.

      These are manual traces of the actual patterns, not executed tests. For examples A–D assume synthetic current login `SYNTHETIC_LOGIN` and computer `SYNTHETIC_PC`; neither occurs in those strings. Paths are shown after JSON unescaping.

      **A — PASS, verified-by-reading:** `Could not open D:\Jobs\26-123 SYNTHETIC_CLIENT\C101.dwg` becomes `Could not open [job 26-123]`. Drive path, client-folder text and drawing filename are removed.

      **B — PASS, verified-by-reading:** `\\SYNTHETIC_SERVER\Jobs\26-124 SYNTHETIC_SITE\C102.dwg` becomes `[job 26-124]`. The server/share path and site text are removed.

      **C — FAIL, verified-by-reading:** `Opened SYNTHETIC_CLIENT SYNTHETIC_SITE.dwg` becomes `Opened SYNTHETIC_CLIENT [drawing name removed]`. The client token survives because there is no full path or leading job number. Current Civil's earlier fault cleaner has a spaced-name rule, but Manager's helper does not; Manager is draining historical and otherwise unvalidated records too.

      **D — FAIL, verified-by-reading:** `Client: SYNTHETIC_CLIENT; site: SYNTHETIC_SITE` is unchanged. Neither helper recognises arbitrary client/site prose. It must not be exported merely because the surrounding object says Civil.

      **E — FAIL, verified-by-reading:** with invented current login `ab` and PC name `xy`, `Login: ab; PC: xy` is unchanged. `CePiiScrub` deliberately ignores names shorter than three characters. Longer current names meeting its matching rules become salted codes, not blanks; other people's names are not generally removed. No salt or real identifier was read for this review.

   7. **Structural exclusion: PARTIAL, absolute guarantee FAIL — verified-by-reading.** A normal flat record whose first `PluginId` is `CE_STRUC_SUITE` is never sent by the new loop; it is deleted at storage line 345. However, the first matching identifier anywhere wins. The valid invented object `{"History":{"PluginId":"CE_CVL_SUITE"},"PluginId":"CE_STRUC_SUITE","DrawingName":"SYNTHETIC_SITE"}` passes because the nested Civil identifier appears first. No top-level schema check runs. That is a deterministic bypass, not evidence that the current flat Structural writer emits this shape; its presence in a real queue is **suspected, not observed**. The pre-existing migration route in check 3 is another limit on the word “never”.

   8. **Damaged record skipped without blocking others: FAIL — verified-by-reading.** The regex at storage line 342 accepts the unfinished text `{"PluginId":"CE_CVL_SUITE","Message":"SYNTHETIC_CLIENT` despite the missing closing quote and braces. The unfinished `Message` does not match the replacement regex, so it goes out unchanged. Similarly `{"PluginId":"CE_CVL_SUITE","Notes":["SYNTHETIC_CLIENT"]}` retains the array string. No complete JSON parse occurs.

      A file without an identifier, over 2 MiB, or unreadable is treated as something to delete. Upload-loop file I/O exceptions generally continue to the next file, but a locked/undeletable old file in `TryClearPluginBacklog` reaches its one outer catch at line 274 and cancels the whole plugin drain. Actual locked files were not exercised; this failure path is **verified-by-reading**, occurrence on Tim's PC is **suspected**. Recursive enumeration also occurs outside the upload loop's per-file catch.

   9. **Nothing deleted unsent: FAIL — verified-by-reading.** Storage line 253 deletes real-login machine filenames, line 267 deletes pre-first-ON files, line 327 deletes support bundles, and line 345 deletes non-Civil/unidentified/oversized/unreadable records. None requires a successful send. A missing or invalid first-ON timestamp starts a new cutoff, potentially deleting more queued history; an I/O exception reading it stops the drain instead.

      Accepted Civil data is written before deletion at lines 358–359, which is good, but there is no ownership claim or identity check across read/write/delete. A heartbeat replaced after the read can be deleted although the newer contents were never sent. This possible interleaving is **suspected at runtime**, with the missing protection **verified-by-reading**. `CeTelemetryStore.WriteJson` writes directly to final filenames and machine heartbeats reuse their filename, so ignoring `.tmp` files does not address every concurrent-write case.

   10. **Tests read and whether they catch the fix: PARTIAL — verified-by-reading.** The live new test file contains 19 `[Test]` methods; none was run here. `SwitchOn_ATmpOrBakFileIsLeftAloneAndNeverSent` at line 100 asserts that a fresh `.tmp`, fresh `.bak` and 30-day-old `.tmp` remain local, none is sent, and only the finished Civil record is sent then removed. The previous commit lacks both exclusions: the old temporary file is deleted and the newer ones can be uploaded. Therefore this test is a meaningful regression test for the final fix by code comparison; no executed red/green claim is made.

       The other tests assert: missing/absent/string-valued switch stays OFF and true enables it; OFF preserves plugin files while Manager files upload; ON sends a Civil file and deletes an old zip; missing plugin folder succeeds; real-login filenames are deleted while coded/other-login filenames are sent; old failures, usage and machine reports are deleted while newer Civil records are sent; first-ON time is recorded once; OFF records no time; an unwritable time prevents plugin uploads; Structural usage and machine files are deleted; unreadable-as-JSON/no-ID samples are deleted; recognised drawing paths are removed while job number, command and stack method remain; files introduced after the backlog pass receive the Civil check; an extra scalar `Note` is scrubbed; current-login filenames on another PC are deleted.

       **Coverage gaps, verified-by-reading:** the damaged sample at test line 314 has no Civil identifier, so it cannot detect malformed JSON that does have one. No test covers nested/duplicate identifiers, array strings, escaped property names, bare client prose, short identities, a private relative filename, read-to-delete replacement, or one locked backlog file followed by a valid Civil record. Tests actively require unsent Structural/backlog deletion, contrary to this brief. The “other PC” case at line 156 explicitly expects another login's readable filename to be uploaded; the filename is not scrubbed. Builder counts in the train list are historical claims, not rerun evidence.

   11. **REDO safety: PASS within changed code — verified-by-reading.** No drawing write, transaction, command dispatch, document event or Undo handler is introduced. The changed storage functions operate on filesystem reports. Nothing here adds a drawing write between U and REDO. Real AutoCAD REDO behaviour was not tested.

   12. **Locked layers, Xrefs and REFEDIT: PASS/not applicable — verified-by-reading.** No drawing object access, layer unlock, reference detach or REFEDIT bypass appears in the changed code. These guards are unaffected.

   13. **CE_SHARED, installer and signed updates: PASS — verified-by-reading.** The four-file head diff changes no `Shared/CE_SHARED` source, installer, signing, update manifest, deployment file, project version or `PackageContents.xml`. Existing helpers are called, not changed. No installer-touch HOLD is needed; this HOLD is for the reporting defects. A later Manager release version bump belongs to the authorised train, not this review.

   14. **R-00 engineering values: PASS/not applicable — verified-by-reading.** No engineering number or council value is added. The 2 MiB record cap is a software limit, not a Settings-page engineering value. The Boolean is a Manager switch-file key, not a new Civil Settings property.

   15. **R-27 hard blocks: no new drafting hard block — verified-by-reading.** No drawing operation is refused and neither permitted serious case is changed (spine identity deletion; colleague update on failed build). Reporting can return false for a stamp/backlog failure; that is an upload failure, not a reason to stop drafting. Repair the whole-queue failure in check 8 without sending private data to satisfy “continue”.

   16. **Plain wording: PARTIAL — verified-by-reading.** No window or command label is added. Existing upload sentences are plain. However, “Nothing was waiting to send” can follow permanent deletions with zero uploads, and “the rest are still waiting on this PC” can misdescribe a partially purged queue. Update the outcome wording after changing retention. Internal comments claiming every string is scrubbed and only Civil can go overstate the actual protection.

   17. **Train clashes: log overlap only — verified-by-reading.** Queried live heads/files for #1781, #1782, #1783, #1784, #1785, #1787, #1786, #1790, #1789 and #1791; all match their C-69 reference heads. None touches the two Manager production files or the new Manager test file. No competing `drainPluginOutbox` key is introduced by those Civil changes. All eleven diffs prepend at `REGRESSION_LOG.md` line 1 (`@@ -0,0 +1,... @@`), including this PR's 70 lines. Preserve every entry with separated headings when assembling. No combined build or trial merge was performed, so a clean assembled train is not claimed.

   **Verdict and exact fixes — HOLD**

   The default-OFF containment and `.tmp`/`.bak` repair are real. They do not justify approving the current privacy-sensitive upload path as correct. The following are required before reconsidering the verdict; no implementation was changed in this review.

   1. **Validate and limit records — storage lines 292–296 and 331–354.** Replace the identifier/string regexes and hand-written JSON processing with full bounded JSON parsing. Require one top-level Civil identifier, reject duplicate/conflicting identifiers and trailing/incomplete content, and validate the supported record kind. Construct an outbound object from explicitly approved fields; do not forward unknown properties, array strings or raw input remnants. Preserve a rejected source locally and continue. Add regression cases for the unfinished Civil object, nested Civil/root Structural object, duplicate identifiers and string arrays; assert no outbound file and a later valid record still sends.

   2. **Remove unsent deletion — storage lines 230–277, 325–346 and 358–359.** Keep Structural, old, unknown, oversized and damaged records locally as this brief requires. Do not use a first-ON timestamp to purge history. If unsuitable records need separation, use a local-only retained area with an explicit retention policy; never upload them as a workaround. Isolate each file failure so an old locked record cannot block valid records. Change the deletion-asserting tests at lines 135, 151, 172, 236, 256, 278, 297 and 314 to assert preservation and no upload. Any future permanent cleanup needs Tim's explicit ruling.

   3. **Close privacy gaps — storage lines 349–358; `CeSupportBundleScrub.cs:28`, `:34`, `:81` and `:97`.** Handle whole spaced drawing names, not just the last word. Do not export unrestricted diagnostic prose on the assumption that a path cleaner removes arbitrary client/site names; use approved structured diagnostics or omit unproven text from automatic sharing. Constrain CE-folder exceptions to actual trusted roots. For this new route, normalise identity fields to codes regardless of identifier length and exclude unverified identities embedded in free text. This can be done in Manager without changing CE_SHARED. Add the five examples above plus plain-text/short-identity and trusted-folder lookalike cases.

   4. **Protect filenames and read/delete ownership — storage lines 318 and 356–359.** Generate safe destination relative names from validated record type and coded identifiers, never arbitrary source names. Hold a source claim that prevents replacement/deletion races, write the checked destination successfully, and remove only that exact claimed source. A newer replacement must remain queued. Add tests for a source name carrying a synthetic identity and a heartbeat replaced after the read. Do not merely compare timestamps and leave another delete race.

   5. **Tests, switch consistency and honest outcomes — test file lines 48–419; `CeOneGlanceStatus.cs` in `ParseObject`; storage lines 129–135.** Retain the working temporary-file regression. Add malformed, missing, false and absent-key switch cases through the real flag reader; register `DrainPluginOutboxKey` in the known Boolean-key list. Add complete real-schema payload cases and failed-write retention. Report sent, kept and unreadable counts accurately. These tests are requested fixes, not tests executed during this review.

   **Tim's word before ON — verified-by-reading distinction**

   Only Tim can authorise this wider sharing scope: recipient/access, the approved field list, stable user/PC codes, job numbers, command timings, diagnostic text and retention. Do not treat “safe to merge OFF”, a green test run or this report as permission to turn it ON. The present brief already requires retaining Structural and other unsent records; follow that now rather than assuming consent to the older deletion policy. Administrator feature work stays parked.

   **Opus comparison — verified-by-reading**

   Detailed comparator: `REVIEW_OPEN_PRS_R2_26OCT.md`, item 11, predecessor #954 at `78bea5b5`; the C-69 list carries that verdict to #1788 pending a fresh independent read. Opus requested the temporary/backup-file exclusion and identified ON as Tim's privacy decision. That exclusion is now implemented and its test is meaningful. I agree with those facts and with default OFF, but not with the overall readiness verdict or the unrestricted “each scrubbed / only Civil” claims.

   **#1788: Codex DISAGREES with the Opus verdict (Opus said MERGE-WITH-FIXES, Codex says HOLD) because the live replacement head still accepts malformed or misidentified records, can retain private text and filenames, and deletes unsent records contrary to this brief.**

---

1. **Not verified by execution.** Zero builds or tests run; no AutoCAD, share access, real outbox contents, installed version or live switch file inspected. No actual leak or loss on Tim's PC is alleged. The review establishes code defects and gaps, not a production incident.
2. **Report handoff.** Only `areas/CODEX_PR_REVIEW_cx_rv28.md` is this session's change. Save by that exact name in CE_PLAN, merge `origin/main` without rebase, push with the normal leak-scan hook, and check no ahead remains. Unrelated existing workspace changes belong to other jobs and must not be staged.
