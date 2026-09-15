# CE Civil Editor UI/UX Brief — CDEDIT, PIPEEDIT, PITEDIT

**Status:** Approved workshop authority  
**Date:** 2026-08-31  
**Audience:** Claude / UI implementation sessions

## Purpose

Refit the user experience for the CE Civil drainage editors without redesigning approved engineering behavior. The screens must feel like practical AutoCAD drafting tools for civil staff, not developer/debug panels.

## Core rule — engineering vs presentation

Engineering/actual values and drawing presentation are separate but always considered together.

**Engineering** controls what the network actually is: object identity, pipe type, diameter, material, connected objects, flow, design/actual grade, ILs where applicable, pit cover level, pit bottom IL, depth, surface, lid class, standard detail, schedule data.

**Presentation** controls only how that information appears on the drawing: labels, visibility, above/below, arrows, decimal display, wording overrides and annotation positions.

Presentation must never silently change engineering data. Hiding IL text does not delete IL data. A custom displayed grade does not change the engineering grade. Engineering changes may preview their drawing consequences before save.

## Shared editor behavior

- Editors are popup windows.
- On open, zoom to the selected object with useful context and strongly highlight it.
- Pit zoom includes connected pipe ends; pipe zoom includes the full pipe and relevant connections/pits.
- `Inspect Drawing` temporarily gets the editor out of the way so the drafter can pan/zoom and understand project context. Returning preserves the session and unsaved preview.
- `Focus on Pit` / `Focus on Pipe` restores contextual zoom/highlight when requested.
- Normal close restores the AutoCAD view from before editor open. If the user deliberately navigated through Inspect Drawing, preserve that navigated view.
- Live preview is expected for safe presentation changes and safe engineering previews. Show one clear banner: `Preview — changes not saved`.
- `Save and Close` commits valid changes and closes.
- `Cancel` restores the exact starting drawing/editor state.
- Engineering contradictions may block Save and Close. Presentation issues never block otherwise valid engineering.
- Validation language: `Info`, `Warning`, `Blocking`.
- Use plain drafting wording. Prefer `Source` over `Provenance`; `Was / Now` over `Current / Proposed`; `Needs check`, `Cannot save`, `Drawing changed`, `Read only` over developer terminology.
- Source indicators are subtle and only shown where source matters (survey/imported/calculated/assumed/pinned, etc.). Do not badge every ordinary field.
- When useful, show one short plain-English explanation under a calculated value.
- `Was / Now` appears locally only when a field has changed; do not force a permanent large review rail.

## CE-controlled annotations

- Never open raw AutoCAD text editing for CE-controlled annotations.
- Double-clicking CE text resolves to the owning pit/pipe, opens the correct editor and jumps directly to the relevant engineering/presentation field.
- Single-selecting CE text then running CDEDIT does the same.
- AutoCAD Properties for CE-controlled data is read-only/informational. CDEDIT is the editing doorway.

# CDEDIT — the main doorway

CDEDIT is the default edit command.

It must support pre-selection, prompted selection, pit/pipe geometry, CE text ownership resolution, one-object routing, same-type batch editing, and clear rejection of mixed pit/pipe selections with odd objects highlighted.

## Batch editing principles

- Only safe fields are exposed.
- Differing values show `Multiple`.
- A blank never erases.
- A field must be explicitly enabled/ticked before batch write.
- Primary action: `Apply to Selected`.
- One accepted batch should be one AutoCAD Undo step.

### Pipe batch

High-value batch uses include presentation presets (`Standard`, `Simple Pipe`, `Simple Pipe + Arrow`), invert labels On/Off, 2dp / 3dp, diameter, material, safe pipe type changes, and an explicit engineering action such as `Set Design Grade = 1 in 100` only for compatible pipes with preview and compatibility checks.

Do not casually batch-edit individual ILs, flow direction or connection-specific values.

### Pit batch

Safe uses include pit type, size/detail where compatible, lid class, Pit Label Block On/Off, Cover Level Text On/Off, Pit Bottom IL text On/Off, and schedule inclusion/set.

Do not batch-edit cover levels, connected pipe-end ILs, pit bottom ILs or pit depths.

### Switching objects

Within PIPEEDIT allow same-type navigation such as Previous / Next / Pick Another Pipe. PITEDIT likewise for pits only.

If unsaved changes exist: `Save & Switch / Discard & Switch / Stay Here`.

# PIPEEDIT

## Visual structure

Use a medium-width vertically stacked form, not a wide dashboard and not a permanent side evidence rail.

Order:

1. Identity header — real identity such as `P1 → P2`, plus useful type/size context.
2. Engineering.
3. Connections.
4. Presentation.
5. Schedule/documentation only where it has a real workflow destination.

Rare controls may collapse under `More Engineering` / `More Presentation`; core fields remain visible.

Preferred footer: Inspect Drawing / Focus on Pipe / Adjust Drawing Positions / Save and Close / Cancel.

## Engineering

Put size/material before levels: Pipe Type, Diameter, Material, then Flow / grade / levels as relevant.

Do not assume every pipe needs the same IL workflow. Charged and other special lines may legitimately not use ILs in the normal way.

### Flow direction

Show plainly, e.g. `P1 → P2`, with `Reverse Flow`.

Reverse Flow changes intended flow only. Never silently swap or recalculate inverts. If existing levels then contradict flow, show the contradiction and block save until resolved.

The drawing flow arrow must always follow actual/proven flow. Presentation can control arrow On/Off and position, never reverse it independently.

### Grade

Keep engineering grade and displayed grade separate.

Engineering/design grade drives engineering calculations. Presentation choice for grade shown on plan: `Actual`, `Design`, `Custom`.

If the user enters a design grade, ask which end/IL is held fixed, defaulting to the stronger source. Do not silently choose the wrong anchor.

### IL requirements

Do not impose `gravity pipe = ILs required` universally.

Some short/simple pipes legitimately do not need ILs for the final design reader. Missing ILs are only blocking where that pipe/workflow actually requires them.

If a pipe does not currently require ILs, show `Levels: Not required / Not set`, with `Add / Set Invert Levels` if the pipe later needs them.

If a workflow changes from levelled to no-IL, never silently delete engineering IL data. Presentation Off and engineering-data removal are distinct actions.

## Simple Pipe / Simple Pipe + Arrow

These are heavily used and must remain first-class workflows.

A Simple Pipe is still a real CE pipe with Pipe Type, Diameter, Material and relevant grade/default behavior (typically 1 in 100 unless the selected type has different rules).

`Simple Pipe` primarily means simplified presentation / no unnecessary IL presentation.

`Simple Pipe + Arrow` is the same underlying pipe setup with flow arrow presentation On. It is not a separate engineering pipe type.

Do not remove these as “creation-only” concepts. PIPEEDIT must understand and edit them properly.

## Main pipe label presentation

Use company presets rather than dozens of independent checkboxes.

Examples: Standard — `DN375 RCP @ 1 in 100`; Simple — `DN375 RCP`; Size Only — `DN375`; Existing — `EX. DN225 uPVC`; Advanced / Custom only when required.

Main label aligns with the pipe and stays readable. Normal position: `Above Pipe / Below Pipe` plus manual position adjustment.

## Invert label presentation

- Number comes from stored engineering IL.
- Default label: `IL 42.85`.
- `IL` prefix always present.
- Default 2 decimal places; optional third decimal.
- Default one shared setting for both ends: `Above Pipe / Below Pipe / Off`.
- `Set ends separately` only when needed.
- Pit ID is not shown by default.
- A deliberately different displayed number is an explicit `Display Override`, clearly flagged.

## Pipe type wording / supplementary text

Actual Pipe Type drives normal standard wording. Presentation may override wording without changing actual pipe type. Mark it `Custom presentation text` and provide `Reset to Standard`.

There is no invented pipe record remark if there is nowhere meaningful for it to go. An optional Drawing Note/supplementary presentation text is fine.

## Adjust Drawing Positions

One button enters adjustment mode for main pipe label, either invert label and flow arrow. Do not clutter the form with separate Move buttons or raw offset fields.

Manual positions persist through recalculation/editing and move with the pipe maintaining relative offsets. `Reset Positions` restores standard placement.

## Recall Last

Keep it. Default: recall both engineering setup + presentation setup. Allow Engineering-only or Presentation-only where useful.

Never copy object-unique data such as connected pit IDs, proven flow or actual ILs. Recall Last loads as preview before Save and Close.

# PIPEEDIT Connections

Connectivity is independent of ILs. A short pipe can participate fully in network topology even when ILs are not needed/displayed.

Show compact useful context, e.g. `From: DP1`, `Connects to: DN375 main line`, `Network continues to: P7`.

Healthy connections are read-only/quiet. `Connect / Disconnect / Resolve` only appears when useful.

# PITEDIT

## Visual structure

Medium-width stacked form.

Order: Header — Pit ID; Engineering; Connected Pipes; Presentation; Schedule.

Preferred footer: Inspect Drawing / Focus on Pit / Save and Close / Cancel.

Retain the current pit annotation placement/movement behavior where it already works well. Improve how controls are housed, not the underlying placement workflow.

## Identity / type

- One Pit Number / Pit Identifier field only.
- Remove duplicate Label field editing the same identity.
- Pit Label Block follows this value.
- Pit Type is a controlled dropdown plus `Other` custom type.

## Size / preset / detail

- Use `Plan Length` and `Plan Width`, not bare X/Y.
- Keep presets as a smaller `Change Pit / Preset…` action in edit mode.
- Preset can populate type, dimensions and Standard Detail but is a starting configuration, not a lock.
- Show selected Standard Detail near pit type/size, with `Change Detail`.
- Standard/custom details come from the CE standard-details library.
- If modified away from the standard, preserve provenance as `Modified from Standard`, with options to remain modified, choose another standard detail or convert to Custom Detail.
- Drawing Intelligence should know these details and help validate them.

## Orientation

- Hide orientation for square pits unless relevant.
- For non-square pits use `Rotate Pit in Drawing`.
- Options: `Align to Pipe` and `Pick Angle`.
- Do not expose a raw angle box as the main workflow.
- CE may show current orientation/alignment for information.

## Levels / depth

Always show together: Cover Level, Pit Bottom IL, Pit Depth.

Use `Pit Bottom IL` to distinguish it from connected pipe-end ILs.

Connected pipes own their own end ILs. The pit does not own a competing connection IL.

### Pit Bottom

Modes: `Automatic` / `Custom`.

Automatic follows the selected standard/detail rules. If the detail requires a sump, show Sump Depth only when applicable. Do not hard-code a generic sump rule into the UI.

Custom allows `Enter by Depth` or `Enter by Bottom IL`; user enters one and CE calculates the other from Cover Level. Mark this as a manual/custom engineering value. Do not silently alter connected pipe ILs.

### Cover Level

Completely editable. Survey/TIN is reference evidence, not authority. Where available, keep `Use Survey RL` as a one-click action.

Changing CL previews resulting depth. Do not move connected pipe ILs just to make the pit work.

## Surface / Lid Class

Surface is both detected and editable. Controlled company list such as Landscape / Footpath / Driveway / Road / Other.

If confident: `Detected: Driveway`. If uncertain: `Likely: Driveway — Confirm / Change`.

Lid Class stays a directly editable dropdown. Surface may suggest lid class, but never lock it.

User confirmations/corrections feed the broader company learning model.

## Connected Pipes

Compact rows, e.g. `P6 → P7 · DN300 RCP · IL 43.85 · ARRIVING` and `P7 → P8 · DN375 RCP · IL 43.82 · LEAVING`.

Pipe-end ILs are read-only in PITEDIT. Clicking a row can highlight that pipe or open PIPEEDIT at that connection.

## PITEDIT Presentation

There are two distinct drawing objects.

### Pit Label Block

Shows identifier only, e.g. `P7`. It remains independent of Cover Level Text.

### Cover Level Text

Fixed company-standard component order:

1. Pit Type description when applicable, e.g. `SILT PIT`
2. `CL 45.32`
3. `IL 43.70` if enabled
4. Drawing Note if present

Hidden components close up naturally with no blank lines.

- `CL` prefix always used.
- `IL` prefix always used.
- 2 decimals by default; optional third decimal.
- Pit Bottom IL can be shown on plan as well as schedule.
- Drawing Note is presentation only and is incorporated into the Cover Level Text object.

### Pit Record Remark

Separate from Drawing Note. It belongs to the pit data/schedule, not drawing presentation.

# Schedule

Schedule is a distinct small section — neither Engineering nor Presentation.

For pits show compact status, e.g. `Included ✓ · Set A`, with `Change…` only when required.

Do not invent pipe schedule/record fields without a real destination.

# Locked / XREF behavior

Locked-layer or XREF CE objects still open for full inspection but are clearly read-only, with a plain explanation of why editing is unavailable.

# Visual direction

Approved direction: medium-width Windows-style popup; vertically stacked sections; calm and professional; strong headings; simple field rows; minimal decorative cards; status color only where meaningful; no emoji controls; source/status indicators use words, not color alone; rare controls collapse while core engineering stays visible; strong selected-object highlight occurs in AutoCAD rather than excessive UI chrome; one obvious primary `Save and Close` action.

# Required adjustment to PR #20

PR #20 is useful shared-shell infrastructure, but do not adopt its initial UX literally.

Specifically: simplify `Apply / Update / OK` into the approved `Save and Close` everyday workflow; do not show provenance chips on every field; do not force a permanent evidence rail; keep Was/Now contextual rather than permanent heavy review UI; live preview is an expected interaction where safe, not necessarily a global toggle; retain useful infrastructure for reversible preview, status, focus, accessibility and common shell styling.

# Acceptance summary

A drafter should be able to open CDEDIT, immediately understand what object they are editing, see actual engineering values first, understand connections, then control how those values appear on the drawing — without ever wondering whether a presentation choice changed the network.
