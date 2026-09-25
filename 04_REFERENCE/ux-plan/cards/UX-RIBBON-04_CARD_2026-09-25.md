# UX-RIBBON-04 workflow card — merge and automate the Structural Workspace/System commands, move the rest into Manager

**DRAFT · awaiting Tim's approval before any code starts.** Not built, tested in AutoCAD, installed or
Tim-accepted. Source of the ruling: `decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md`, "Front door,
batch 1 — 25 Sep 2026, 13:50", UX-RIBBON-04. Tim's own words, not one of the offered choices: **"merge and
automte them as much as possible then add tomanager."** Recorded intent: "The seven commands that install
and repair the CE workspace, menu and toolbars are merged into as few as possible and automated as far as
possible (repair happens without the user having to run them). What remains goes into Manager. Nothing on
the CE ribbon." **OPEN 2 (CESTRUC's fate) is now answered**, same file, "Structural front door" section,
UX-STRUC-10 (25 Sep 2026, 23:54) — see item 4 in section 2 below; OPEN 1, 3, 4 and 5 remain open.

## 1. Correcting the premise the question was asked under, before proposing anything

The design-pack source for this question (`docs/design/V3_UI/windows/01_RIBBON.md` §8.2/§8.5) describes the
CE Structural tab's `Administration ▸ Workspace` (5 commands) and `Administration ▸ System` (2 commands)
flyouts as commands that **"install and repair the CE workspace, menu and toolbars."** Reading the actual
commands on `origin/master` at `bf57f739` (24 Sep 2026), that description does not match what they do. The
phrase "install and repair the CE workspace, menu and toolbars" is accurate for **Civil's**
`WorkspaceMenuInstallerService.cs` / `CuiMenuGeneratorService.cs` (the `CE CVL` pull-down menu and seven
toolbars, already answered separately — UX-RIBBON-03). It is not what these seven Structural commands do.
This card describes what they actually do, so Tim's "merge and automate" ruling can be applied to the real
behaviour rather than the mis-described one.

**What the seven commands actually are** (`Modules/Structural/Commands/UiCommands.cs`,
`Modules/Structural/Commands/UtilityCommands.cs`, `Modules/Structural/Assets/Config/command-registry.json`):

1. **`CETOOLS`** (registry label "Open Command Hub", registry note "Primary entry for day-to-day use") —
   opens the CETOOLS palette (JobTime tracking, Notes, Checklist, Commands hub): `PaletteManager.Show()`.
2. **`CETOOLSTOGGLE`** — toggles that same palette's visibility: `PaletteManager.Toggle()`. **Registry
   inconsistency found:** the registry lists `CETOOLSTOGGLE` as an *alias* of `CETOOLS` (same command, same
   behaviour) — but the source code registers it as its own, separate `[CommandMethod]` with different
   behaviour (Show vs Toggle). One of the two records is wrong and should be corrected as part of this
   card's build, not left as a live discrepancy.
3. **`CECHECKLIST`** — switches the already-open CETOOLS palette to its Checklist tab:
   `PaletteManager.SwitchToTab("Checklist")`.
4. **`CESTRUC`** (legacy alias `CE_STRUC_SUITE`) — opens a separate window, `StrucSuiteWindow`.
5. **`CENOTES`** — opens the shared notes browser (`NotesBrowserDialog`) across all users and jobs.
6. **`STRIPLAYERSMERGE`** — a drafting utility: merges strip-footing layers in the current drawing now
   (`CeTextService.MergeStripFootingLayersNow()`). This changes drawing layers, not the CE workspace/menu.
7. **`STRUCLINKTEXT`** — a drafting utility: prompts to pick a parent entity then a text/label entity and
   links them (`LinkService.LinkText`). This edits the drawing, not the CE workspace/menu.

None of the seven installs a CUIX menu, a toolbar, or repairs a corrupted workspace profile — that job
belongs to Civil's separate `WorkspaceMenuInstallerService`/`CuiMenuGeneratorService`, which Structural does
not currently have an equivalent of. Four of the seven (`CETOOLS`, `CETOOLSTOGGLE`, `CECHECKLIST`, `CESTRUC`)
are window/palette openers; one (`CENOTES`) opens a content browser; two (`STRIPLAYERSMERGE`,
`STRUCLINKTEXT`) are drawing-editing utilities with generic, apparently auto-generated registry
descriptions ("Executes CE utility/system command X for audit, deployment, linking, or maintenance tasks")
that read like placeholder text rather than a written description — worth a genuine one-line description
each while this card is being built, so a future drafter reading CEHELP knows what they do.

## 2. What works today — Keep / Modify / Retire, per command

1. **`CETOOLS` — Keep the function, Modify the entry point.** Opens the CETOOLS palette; registry calls it
   the "Primary entry for day-to-day use." This is not an admin/repair command at all — it is Structural's
   main palette launcher. Recommend it survives, but moved off the "Administration" registry group (it was
   mis-grouped) and kept reachable, likely from the Structural ribbon's own CE panel rather than folded into
   Manager, since Manager cannot reasonably host a command a drafter needs open all day. **This is the one
   command in the seven this card recommends NOT moving into Manager — flagged as OPEN 1 below because it
   conflicts with Tim's literal "what remains goes into Manager."**
2. **`CETOOLSTOGGLE` — Merge into `CETOOLS`.** A toggle and a show of the same palette do not need two
   top-level commands. Recommend retiring `CETOOLSTOGGLE` as a separate typed command (keep it as a silent
   redirect to `CETOOLS` for anyone with it in muscle memory or an old macro, per the standing
   no-retirement-without-Tim rule) and fixing the registry's alias/behaviour mismatch either way.
3. **`CECHECKLIST` — Merge into `CETOOLS`.** "Switch to a tab in an already-open palette" is not a
   standalone workflow; it only does something useful if `CETOOLS` is already open, or if it silently opens
   it first. Recommend folding it into the palette itself (a Checklist tab you click, as the other tabs
   already are) and keeping `CECHECKLIST` as a typed redirect that opens `CETOOLS` on that tab, for the same
   no-retirement reason.
4. **`CESTRUC` — decided 25 Sep 2026, UX-STRUC-10 (closes OPEN 2).** Read at commit `8c077569` in the
   Structural release chat: `StrucSuiteWindow` is a modeless window of 109 command buttons across 7 top-level
   tabs (Beams, Text + Supports, Bracing, Bored Piers, Imports, Schedules + Export, Utilities), offered to Tim
   as "Find a tool" search / retire / keep. Tim, verbatim: *"cestruc does a lot more than search commands,
   retire the search as ribbon will cover it".* **CESTRUC's command-launcher role is retired; the family ribbon
   covers it** (superseding the "revisit in detail" hold this card recorded earlier the same day). The
   full-function-preservation rule still applies: the Structural release chat checked every one of the 109
   buttons against the command registry (`04_REFERENCE\structural\cards\STRUC-RIBBON_CARD_2026-09-26.md`
   §"Pinned source" item 10) and found all but one already has its own registry `group`/`subgroup` — an
   existing ribbon-dropdown home independent of CESTRUC — and the four `CEADMIN|...` buttons duplicate actions
   already on the existing, ribbon-reachable Admin Hub (`CEADMIN` → `AdminHubWindow`). The one genuine gap is
   "Create schedule template" (`CREATETEMPLATE`), which has no registry entry at all; it needs a real home
   (most likely folded into the Schedules family) before the window is retired. See that card for the full
   Kept/Moved detail; this card's own OPEN 2 is now closed.
5. **`CENOTES` — Keep the function, candidate for Manager.** A genuine, separate piece of content (shared
   notes across all users and jobs) that survives independent of any one drawing session — a good fit for a
   Manager tab rather than a ribbon button, consistent with how Diagnostics already folded into Manager
   (§8.2 of the design pack: "flyout Diagnostics — Administration/Diagnostics, 4 commands — Replaced: Folded
   into Manager and `CEHEALTH`").
6. **`STRIPLAYERSMERGE` and `STRUCLINKTEXT` — Keep, but not "into Manager."** These edit the active drawing.
   Manager is CE's install/update/repair/admin surface (`Modules/Manager/UI/Pages`,
   `Modules/Manager/Services/CeAdminPolicyService.cs`, `PluginManagerWindow`) — it has no drawing-editing
   surface and none of its existing pages write to a DWG. Moving a drawing-editing command "into Manager"
   would be new scope beyond anything Manager does today. Recommend they stay Structural-owned, typed
   commands (consistent with UX-REP-01's precedent for `CDSYNC`/`CDREBUILD`: expert, typed-only, hidden from
   the ribbon is fine, but the write itself has to run from the drawing session, not from Manager). Flagged
   as OPEN 3, since this reads against Tim's literal wording.
7. **Automating repair — Missing, and not obviously applicable.** Tim's ruling asks for repair to "happen
   without the user having to run them." Of the seven, only `STRIPLAYERSMERGE` looks like something that
   could plausibly run unattended (a drawing-layer cleanup), and even that changes drawing content, which
   the plugin's standing rule (native AutoCAD protection, "never silently... bypass protected content") and
   UX-STD-03 ("CE never saves the drawing," by extension CE does not silently rewrite it either) both argue
   against doing without a preview and an Undo. Recommend "automated" here means **removing the need to
   remember to open a window** (e.g. `CETOOLS`/Checklist surfacing automatically at the point a drafter
   needs it) rather than commands silently rewriting a drawing — but this is a genuine open question for
   Tim, not a recommendation this card is confident about. Flagged as OPEN 4.

## 3. The full experience, with today's state and the intended result

1. **Ribbon/trigger — Modify.** Today all seven are typed commands, reachable through the Structural tab's
   `CE ▸ Workspace` and `CE ▸ System` flyouts (§8.2 of the design pack). Intended: the merged set
   (`CETOOLS` absorbing `CETOOLSTOGGLE`/`CECHECKLIST`) stays typed and, per OPEN 1, may keep one ribbon
   entry point since it is daily-use, not admin; `CENOTES` moves to a Manager tab; `STRIPLAYERSMERGE` and
   `STRUCLINKTEXT` stay Structural-typed, expert-only, off the ribbon flyout that is retiring; `CESTRUC`'s
   own launcher window is retired (per UX-STRUC-10 above), its buttons rediscovered through the rebuilt
   family ribbon and the existing Admin Hub.
2. **Prompts — Keep, unchanged for the two drawing utilities.** `STRUCLINKTEXT`'s two-entity pick prompt is
   unaffected by this card. `CETOOLS`/`CENOTES` open windows with no command-line prompt; `CESTRUC` no longer
   opens a launcher window once retired, but the typed command itself keeps working.
3. **Selection — Keep, unchanged.** `STRUCLINKTEXT` already runs `DrawingSafetyService.CommandPreFlight`
   before its picks; not touched here.
4. **Preview — not applicable to the four window-openers.** `STRIPLAYERSMERGE` currently has no preview
   before it merges layers — if Tim wants any automation of it, a preview and one Undo would need to be
   added first, per the native-protection rule; this card does not propose building that without Tim's
   separate say-so (see OPEN 4).
5. **Drawing output — unchanged** for `STRIPLAYERSMERGE`/`STRUCLINKTEXT`; none for the rest.
6. **Cancel/Escape — unchanged**, no new drawing-changing action is proposed by this card.
7. **One Undo — unchanged** for the two drawing commands; not applicable to the window-openers.
8. **Save/reopen — not applicable.**
9. **Where values come from — not applicable**, no Settings values are introduced by the merge itself.
10. **Discovery — Modify.** Today these sit in two flyouts most drafters never open (registry marks four of
    the seven `expert: true` or similar). Intended: the daily-use palette entry point is easier to find (one
    button, not a flyout inside a flyout), and `CENOTES` gains a real Manager home instead of living beside
    system-maintenance commands it has nothing to do with.

## 4. Example drawings

1. **DWG-S (Structural):** open it, run `CETOOLS`, `CECHECKLIST`, `CENOTES`, `CESTRUC` to confirm each still
   reaches its current window/tab after the merge. Run `STRUCLINKTEXT` on one dimension text and its parent
   line, and `STRIPLAYERSMERGE` on a drawing with at least two strip-footing layers, to confirm neither
   command's own behaviour changed — only its ribbon/typed entry point did.

## 5. Automated guards vs Tim's AutoCAD checklist

1. **Automated:** a registry test asserting the corrected `CETOOLSTOGGLE` alias/behaviour record; a redirect
   test proving `CETOOLSTOGGLE` and `CECHECKLIST` still reach `CETOOLS`'s palette (Show, then the Checklist
   tab) after the merge; a ribbon-contributor test proving the retired flyout no longer appears and that no
   registry-visible command was silently dropped (only merged or relocated, matching the "nothing is
   retired without Tim's yes" rule already applied by keeping every old command name as a working redirect).
2. **Tim's AutoCAD checklist (DWG-S):** open the Structural ribbon. **Right result:** the old two
   admin flyouts are gone from the CE tab (or reduced to whatever OPEN 1 settles), `CETOOLS` still opens the
   same palette, `CETOOLSTOGGLE`/`CECHECKLIST` typed at the command line still reach it, `CENOTES` opens
   from its new Manager tab, `CESTRUC` typed at the command line still runs (its launcher window is retired
   per UX-STRUC-10, but every function it opened is now reachable from the family ribbon or the Admin Hub —
   confirm "Create schedule template" specifically, since it needed a new registered home), and
   `STRIPLAYERSMERGE`/`STRUCLINKTEXT` still work exactly as before when typed.

## 6. Slices — smallest first

1. **Slice 1 — fix the registry inconsistency and write real descriptions.** Correct the
   `CETOOLS`/`CETOOLSTOGGLE` alias-vs-command mismatch; replace the two auto-generated-looking
   `STRIPLAYERSMERGE`/`STRUCLINKTEXT` descriptions with real ones. No behaviour change, no ribbon change.
2. **Slice 2 — merge the three palette commands.** `CETOOLSTOGGLE` and `CECHECKLIST` become typed redirects
   into `CETOOLS`'s own palette/tab; the palette itself keeps its Checklist tab exactly as it is today.
3. **Slice 3 — retire the two ribbon flyouts, keep every command typed.** Remove `Administration ▸
   Workspace` and `Administration ▸ System` from the Structural CE tab; every one of the seven (or five,
   after slice 2) keeps working when typed, per the no-silent-retirement rule.
4. **Slice 4 — move `CENOTES` into Manager.** Give it a tab on an existing Manager workspace page (the
   `SettingsWorkspacePage`/`HelpWorkspacePage` pattern of General/Civil/Structural/Manager tabs is the
   nearest existing precedent) or a page of its own, per Tim's answer to OPEN 5.
5. **Slice 5 — whatever OPEN 1, 3 and 4 settle** for `CETOOLS`'s own home and the two drawing-editing
   utilities. `CESTRUC`'s fate is no longer part of this slice — OPEN 2 is answered (UX-STRUC-10); its own
   retirement work is tracked as slice 8 of the Structural ribbon card
   (`04_REFERENCE\structural\cards\STRUC-RIBBON_CARD_2026-09-26.md`), not here, to avoid two cards building
   the same thing.

## 7. OPEN questions, each with a recommended answer

1. **OPEN 1 — `CETOOLS` is Structural's main day-to-day palette opener, not an admin/repair command. Does
   "what remains goes into Manager" really mean `CETOOLS` moves into Manager, or does it mean only the
   genuinely administrative remainder does?** *Recommended: `CETOOLS` keeps a Structural ribbon entry point
   (it is not admin work); only `CENOTES` (a real content browser) moves into Manager.*
2. **OPEN 2 — ANSWERED 25 Sep 2026 (UX-STRUC-10).** `StrucSuiteWindow` (opened by `CESTRUC`) is a 109-button,
   7-tab command launcher duplicating what the family ribbon already covers. Tim: *"cestruc does a lot more
   than search commands, retire the search as ribbon will cover it".* Its launcher role is retired; see item 4
   in section 2 above and the Structural ribbon card's own preservation check for the one function
   (`CREATETEMPLATE`) that still needs a registered home first.
3. **OPEN 3 — `STRIPLAYERSMERGE` and `STRUCLINKTEXT` edit the drawing; Manager has no drawing-editing
   surface today. Does "add to manager" really include these two, or only the window-opening/admin
   commands?** *Recommended: keep both in Structural, typed, expert-flagged; moving drawing-editing logic
   into Manager would be new Manager scope this ruling did not ask for.*
4. **OPEN 4 — what does "automated" mean for `STRIPLAYERSMERGE` specifically — automatic on a trigger
   (e.g. drawing open, or CECHECKDWG-style), or just easier to find/run?** *Recommended: easier to find
   only, for now — an unattended drawing rewrite needs its own preview-and-one-Undo workflow card and
   review gate, per the native-protection rule, rather than being folded into this merge.*
5. **OPEN 5 — where exactly in Manager does `CENOTES` live: a new tab on an existing workspace page, or its
   own page?** *Recommended: a tab on a Manager workspace page, following the existing
   General/Civil/Structural/Manager tab pattern already used by `SettingsWorkspacePage` and
   `HelpWorkspacePage`, rather than inventing a new page shape.*
