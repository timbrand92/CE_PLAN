# Help, availability and return to drafting

FOR TIM

Help must explain the next drawing action. An unavailable tool needs a reason and a useful route back; a button labelled Opening is not proof that its window opened.

This supplements [settings, assets and Help](03_SETTINGS_ASSETS_AND_HELP.md) and [command discovery](planner/command_discovery_reconciliation.md). Preserve existing reviewed command routes and unavailable/hidden states. The following observations are read-only source evidence, not a live installation check.

## Inspected shared-owner behaviour

Owner copy: `C:\Users\TimothyBrand\.codex\worktrees\44b2\CE_ACAD_PLUGIN`.

| Source | Observed boundary |
|---|---|
| `Modules/Manager/UI/Dialogs/PluginManagerWindow.Help.cs:11–34` | Fallback resolution sends Civil CDHELP or Structural CEHELP through the loaded-module command policy, using descriptors and captured loaded assembly identities. This does not establish every legacy alias or Help topic is migrated. |
| Same file `:205–213` | Civil journey callbacks require current session generation, exact hosted view, Help tab and Journeys section. Old callbacks are not accepted solely because their original view once existed. |
| Same file `:331–357` | Fallback first resolves pending settings; unavailable resolution gives feedback; successful dispatch says Opening and prevents a duplicate queued action temporarily. Pending settings and Help are not independent in this route. |
| Same file `:360–371` | Dispatch needs an active document and queues command text. Returning true proves queuing succeeded in this function, not that a Help window rendered or a topic loaded. |
| Same file `:374–411` | Civil/Structural fallback availability and descriptor status are displayed separately. Missing/ambiguous descriptor status is UNKNOWN. Loaded identity capture failure returns no identities. |
| `Modules/Manager/UI/Pages/HelpWorkspacePage.xaml.cs:25–51` | Hosted-content absence shows its reason; fallback controls are enabled separately. This is not proof of useful offline content or parity with the existing full Help browser. |

## End-user planning contract

| Situation | Required experience | Proof still needed |
|---|---|---|
| Relevant object selected | Describe applicable action in drawing terms, with exact command and before/after; retain direct command access | Topic-to-command/object mapping and native selection handoff |
| No required selection | Explain what to select and allow return to drawing; no silent action on nearest object | Focus/selection/cancel in AutoCAD |
| Module unavailable | Explain actual capability state and show an available Help/recovery route; do not offer an executable-looking unsupported action | Exact loaded/compatible module and fallback matrix |
| Embedded Help unavailable | Preserve the reviewed existing Help route with an honest limitation | Existing browser content, topic/search/anchor parity and offline behaviour |
| Pending settings while opening Help | Preserve approved Apply/Discard/Stay resolution; failure retains draft | Actual host departure/fallback interaction |
| No active drawing | Show why this command fallback cannot launch; general reference guidance should remain useful where supported | Distinguish current dispatch limitation from future non-drawing Help capability |
| Late callback after leaving Help | Do not reopen/minimise another window or retarget a different job | Native lifecycle and focus evidence; source guard is bounded evidence only |
| Missing asset found through Help | Return to the asset's identity/version and unavailable reason; no similar-name substitution | Catalogue and original command owner contract |

Future acceptance uses a synthetic drawing: open relevant Help with and without selection; leave Help before delayed callback; open fallback with a dirty settings draft; remove only a test capability and verify honest unavailable feedback; inspect offline topics/search and return to drafting. None of these native checks ran overnight.

## Scope qualification

The current shared frame is useful source evidence. It does not prove complete migration of Help topics, command discovery or the entire plugin. Keep the already approved old routes until owner-led parity and Tim's native acceptance. These are planning requirements; no Help command, process, browser fallback or provider was launched in this read.

## Structural command search, favourites and recent actions

Additional read-only root evidence: `Modules/Structural/UI/Dialogs/CommandPaletteWindow.xaml.cs:35–104,177–213`, `UI/Palette/CommandsPanel.xaml.cs:164–189,294–355`, `Services/CommandRegistryService.cs:53–60`.

| Action | Current source boundary | Required user meaning |
|---|---|---|
| Search popup | Builds visible registry entries including expert tools; ranks command/alias prefixes, substrings, label/description and group; shows up to12 | Search match is not installed availability or engineering approval. Respect approved hidden/retired states; explain expert tools rather than implying ordinary daily use. |
| Enter/double-click | Stores preferred command, closes once, then queues it to the active drawing from OnClosed | Queued does not mean command completed. Source close guard exists; actual focus, selection retention and duplicate-run behaviour remain native qualification. |
| Escape / loss of activation | Closes popup; no pending command is set by those handlers | Cancel before choosing a command should not run a result. Once selected/queued, popup closure is not drawing Undo. |
| Pin/unpin | Updates personal HubSettings list, deduplicates, caps24 and immediately calls SaveSettings | Personal preference, separate from drawing/project draft. Closing palette does not discard an already saved favourite. Save failure/durability requires settings-owner evidence. |
| Recent commands | After dispatcher invocation adds command to list, caps16 and saves settings | Recent means requested here, not proved successful. Do not use it as action completion or audit receipt. |
| Render favourites | Looks up stored command and skips missing/hidden entries | A stored favourite does not revive a retired/hidden command. Missing-command explanation remains a target usability detail, not an approved new recovery mechanism. |

Future synthetic acceptance: search primary/alias/plain description; select and cancel with Escape; pin a valid tool, save/reopen, then make only a test entry unavailable; run with/without a suitable drawing selection; compare popup and palette routes. Native command protections and existing command-specific previews remain authoritative. No command, preference save or drawing interaction was executed during this read.
