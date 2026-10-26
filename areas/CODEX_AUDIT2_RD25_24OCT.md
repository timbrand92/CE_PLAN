1. **ANSWER FIRST — HIGH 0 / MEDIUM 2 / LOW 1.** Three new findings, all SURE by reading the code. None was run in AutoCAD. Audit completed 26 October 2026, Melbourne; the requested 24OCT filename is retained.

2. **Most important — an incomplete release can pass its checks.** The release checker accepts Civil without the extra file that Copy Rotate and Move Rotate require in AutoCAD 2027. One existing unit test explicitly expects that incomplete package to pass.

3. **Second — loading the missing file later does not fully restore the open drawing.** Copy Rotate can start working, while placing a downpipe directly on a pit still refuses in that same drawing. Closing and reopening the drawing creates a fresh connection to the loaded file.

4. **Third — a diagnostic switch can remove working pipe-label grips.** Choosing Native accepts the choice even when its file is absent, turns off the working alternative, and tells the drafter to click the label again. This affects the diagnostic command, not the normal default.

5. **Next action.** The later AI test lane should run the three synthetic checks below. No testing is requested from Tim. No source, installation, drawing or setting was changed by this audit.

---

1. **Scope and source identity.** Read Tim's rules, router, plan map and relevant release/transform records. Fetched the plugin repository, then used a detached, read-only worktree at `C:\ce-cx\rd25`; no branch or code commit. Source reads used Git objects, not the main checkout's uncommitted files.

   Civil/Manager: `origin/claude/rel-20261023m`, `f7f7d551552c21db3058ed839abacd1ec8a3b4d4` (manifest versions 3.0.72 / 1.1.72). Structural: `origin/claude/rel-20261023s`, `e6d597c0fbc25e78118760887a70810e0890c9a9` (Structural manifest 1.0.122). The later AREA instruction takes precedence over the brief's earlier 22 October refs. These are source identities; live installed binaries were not inspected.

2. **Earlier evidence and duplication check.** Read `AUDIT_C58_C60_S40_S41_2026-10-22.md` and `CODEX_AUDIT_CIVIL_22OCT.md`, `CODEX_AUDIT_STRUCTURAL_22OCT.md`, `CODEX_AUDIT_GATE_22OCT.md`. Searched `BUG_CARPARK.md` before source inspection and again against the candidate failures. Cross-checked relevant later audit records. Known items are excluded from the counts.

   **Known references only:** BUG-001; BUG-519; BUG-523; BUG-885; BUG-1018; BUG-1137; BUG-1138; BUG-1209.

3. **Evidence meaning.** SURE / verified-by-reading establishes the specified control flow or package rule. It does not mean a native reproduction was performed. Every deterministic test below is NOT RUN. No suspected-only finding is counted. R-27 and R-00 remain in force; no new drafting prohibition or engineering default is proposed. Manager administrator work stays parked.

4. **RD25-01 — MEDIUM — SURE / verified-by-reading: the release gate treats a required transform file as optional.**

   **File:line:** `Shared/CE.Release/OfficialReleaseGate.cs:1411`, `:1435`, `:1443`; `Installer.Tests/StandaloneCivilReleaseProfileTests.cs:165`; `Modules/Drainage/Commands/CopyRotateCommands.cs:44`, `:45`, `:54`, `:61`; `Modules/Drainage/CE_CVL_SUITE.csproj:329`.

   **What the drafter or office sees:** a package can satisfy the StandaloneCivil release check, yet every 2027 CR, COPYROT, MR and MOVEROT attempt stops with `CE ObjectARX transform component is missing. Repair the CE installation.` No selection/base-point interaction starts and nothing moves or copies.

   **Exact failure scenario:** prepare an otherwise passing StandaloneCivil candidate with all required managed lanes and the native grip file, but omit `Contents/Win64/Modern/CE_TRANSFORM_2027.arx` BEFORE creating its release evidence. The native-file predicate permits `transformCount <= 1`. The test named `BuildAndVerify_StandaloneCivil_WithoutOptionalTransform_RemainsAccepted` removes that file, builds release evidence, and asserts both Build and Verify succeed. These are the test's assertions, not test results from this audit.

   The 2027 command owner has no fallback: it requires the file before loading its `CETransformRun` export. Its project also excludes Copy Rotate LISP on that lane. This is an inconsistent package contract, not a complaint that an on-demand module lacks a startup entry. It is also not post-signature tampering: evidence is made for the already-incomplete candidate.

   **DETERMINISTIC TEST — fixture and steps:** use the existing isolated `StandaloneCivilReleaseProfileTests` fixture, with its test signing key and otherwise valid approval/evidence. First retain the transform file as a positive control. Then follow the existing missing-transform case: remove only that file, leave its optional manifest entry absent, call the real release Build and Verify routes with freshly generated evidence. Correct assertion: missing required transform is rejected by name; intact control succeeds. Current source explicitly expects the missing-file case to succeed.

   **AutoCAD consequence check:** on a disposable AutoCAD 2027 profile with actual Civil 3.0.72 binaries and only that ARX omitted, open a synthetic millimetre drawing. Type `LINE`, `0,0`, `1000,0`, Enter. Type each of `CR`, `COPYROT`, `MR`, `MOVEROT`. Assert the quoted missing-component command-line text and unchanged line coordinates/count. This characterises the failure; release acceptance must prevent this incomplete candidate. This is not a claim that today's complete bundle passes every other release gate.

   **Smallest fix:** require exactly one non-empty transform FILE for a current StandaloneCivil candidate, while allowing its MANIFEST ENTRY to remain absent because Civil loads it on demand. Separate those two checks: changing the shared predicate to require an entry everywhere would reject a valid manifest. Reverse the existing missing-file test's success expectation and retain the demand-loaded-without-entry positive control. Do not add a runtime LISP fallback or restart Manager administrator development.

5. **RD25-02 — MEDIUM — SURE / verified-by-reading: a failed first native registration remains failed after a successful late load.**

   **File:line:** `Modules/Drainage/Services/LinkService.cs:1572`, `:1575`, `:1598`; `Services/SourceCloneMapNativeBridge.cs:36`, `:62`, `:192`, `:222`; `Services/LinkService.SourceLanding.cs:458`, `:461`, `:464`; `Commands/CopyRotateCommands.cs:44`, `:50`, `:57`. Short paths in this finding are relative to `Modules/Drainage`.

   **What the drafter sees:** after the missing transform file is made available and loaded successfully, CR works but DP still refuses a pick on a valid pit in the drawing that was already open. The refusal continues to describe the original missing file. Opening a fresh copy can work, making the same installation appear inconsistent between drawings.

   **Exact failure scenario:** on AutoCAD 2027, document A registers while its assembly-relative `CE_TRANSFORM_2027.arx` is absent. The failure catch disables its receipt ledger and returns null. The document has already been added to `RegisteredDbs`; subsequent activation returns before `TryRegister`. That is the sole production call site. Clearing the ledger does not repair it: `Clear` returns immediately when unavailable.

   Restoring/loading the correct ARX lets the independent CR/MR loader succeed, but never re-registers document A's receipt callback. Its `SessionIdentity` remains empty and pit landing returns `Source-to-pit placement is unavailable:` with the original error. This is a recoverability defect on supported AutoCAD 2027, not a new claim about unavailable older-version support or the separate pipe-object bridge.

   **DETERMINISTIC TEST — fixture:** disposable 2027 profile and two copies, A and B, of one synthetic Civil drawing. Each has one unlocked CE pit P1, 600 mm square, at `0,0,0`, cover RL 20.000 m; clear surroundings and no existing source at the centre. Use identical settings and valid source assets. Start with the transform ARX withheld from this test profile only; do not alter Tim's installation.

   **Typed steps and assertions:** open A. Assert the CE log contains `Source COPY receipts unavailable: The source COPY component is missing. Repair the CE installation.` Make the correct ARX available at its expected test-bundle path. Draw a plain line from `10000,0` to `11000,0`; type `CR`, select that line, Enter, base `10000,0`, destination `10000,2000`, rotation `0`. Assert `Copy Rotate complete.` and one extra line: the file is now usable.

   In A, type `DP`, pick `0,0,0`, then Esc after recording the result. Correct recovery assertion: a downpipe can be placed on P1 without the old missing-component refusal. Current source predicts no joined source and a CE log line beginning `[Source] The pick was refused: Source-to-pit placement is unavailable:` that still cites the missing component. Now open B after the successful load and repeat DP at P1 as the positive control. Close/reopen A and repeat to distinguish a stale document registration from an installation failure. Record source count and the exact log text for each copy; keep the controls otherwise identical.

   **Smallest fix:** add a bounded re-registration attempt for a failed document when a required source action is explicitly invoked after the module becomes available. Dispose any old registration safely and rebuild the document's valid session before recomputing landing evidence. Keep the missing-capability check until that handshake succeeds; do not fake a ready flag, reset the entire link service, or add a drawing-writing idle retry. This touches protected link-service ownership and must be routed to its owner.

6. **RD25-03 — LOW — SURE / verified-by-reading: the diagnostic Native choice disables working grips without checking that its replacement loaded.**

   **File:line:** `Modules/Drainage/Commands/GripRouteCommand.cs:50`, `:51`, `:53`; `Services/GripRouteService.cs:66`, `:70`, `:72`, `:77`; `Models/GripRouteSettings.cs:41`, `:83`; `Services/NativeGripModulePresenceService.cs:49`, `:75`. Short paths are relative to `Modules/Drainage`.

   **What the drafter sees:** after `CDGRIPROUTE`, Native, the command says `Grip route set to 'native'. Press Esc, then click a pipe label again.` The Slide/Offset/Flip grips disappear when the native ARX is missing. The log also calls the native module `ON`, although it is not loaded. The chosen route is saved, so restarting does not restore the working alternative.

   **Exact failure scenario:** AutoCAD 2027; native grip file absent; Managed route initially working. The command saves Native and immediately applies it. The policy unregisters the managed grips solely from the chosen enum; the status uses that same preference as if it described availability. The separate presence checker only reports once at startup and cannot stop or qualify this later success message. This is LOW because CDGRIPROUTE is a field-diagnostic command; Managed remains the normal default.

   **DETERMINISTIC TEST — fixture and steps:** disposable 2027 profile, actual Civil binaries, no `CE_CVL_NATIVE_GRIP_2027.arx`; synthetic mm drawing containing a verified CE pipe P1 and its unlocked pipe label. Keep all other native files intact. Type `CDGRIPROUTE`, Managed, then `CDGRIPROUTE`, Show. Assert window/command text reports managed overrule `ON`; click P1's label and record its working action grips. Type `CDGRIPROUTE`, Native; Esc; click the same label; type `CDGRIPROUTE`, Show.

   Correct assertion: the choice is visibly reported as unavailable and the drafter is offered the working Managed route; no unqualified claim that the native module is ON. Current source predicts success wording, managed overrule `off`, no replacement action grips, and CE log `Civil grip route (CDGRIPROUTE): native; managed overrule off; native 2027 module ON.` Switch back to Managed and verify the same label recovers as a control. Restore the isolated preference afterwards. No geometry should change in any leg.

   **Smallest fix:** check native availability on this explicit route change and distinguish requested route from loaded/working state in both text and log. When unavailable, explain it before replacing the working route and offer Managed. Keep an intentional diagnostic override possible and clearly labelled; do not introduce a drafting hard block or silently change the normal default.

7. **Coverage and controls read.** The standalone Civil manifest separates Legacy R24.1-R24.9, Net8 R25.0-R25.9 and Modern R26.0-R27.0; grip/object entries are narrower R26.0-R26.9. The trial manifest is R26.0 only. The native transform build links the 2027 libraries and the Civil native caller is compiled only for NET10. No future-host compatibility is inferred from the broader managed range.

   Missing transform files, failed loads and missing exports have visible managed error handling. Native transform failures print a rollback message; cancellation before the final operation makes no transform write by reading. Clone-map registration checks layout and handshake version, and retains callback roots if unregister fails. These are useful controls, not proof of native execution or complete Undo/Redo safety.

   The separate Structural source has no registered MR/CR owner in `LegacyPortCommands.cs:38`; its remaining helper is not treated as a reachable new command. Trial-only commands and its approved restricted object types are not counted as newly broken production promises. The manual transform build prerequisite already recorded in the release area is excluded from new findings.

8. **What I did NOT check.** No AutoCAD or core-console session, native loading, build, unit test, installation, binary/hash inspection, signed production-candidate validation, live Settings inspection, screenshot, performance measurement, or sub-agent. No native version was accepted by this audit. No unseen command is claimed to fail silently: the recorded failures have either refusal text or misleading diagnostic success text.

   Full transform geometry, all object classes, OSNAP/UCS/attributes, native exception rollback, proxy persistence, Undo/Redo, six-year runtime compatibility and the complete native object/grip implementations remain untested. This was a scoped loading and recovery trace, not a certification of those systems. The 9 November Civil + Manager release decision and parked Manager administrator work are unchanged.

9. **Summary — 79 words.** Three new findings: two MEDIUM and one LOW. The release checker approves Civil without its required 2027 transform file; a failed first native registration does not recover in an already-open drawing after the file loads; and the diagnostic Native grip choice can remove working grips while claiming success. All are verified by reading, with deterministic checks for the later AI test lane. No code or installation changed. No builds, tests or AutoCAD checks ran. Existing findings were excluded.
