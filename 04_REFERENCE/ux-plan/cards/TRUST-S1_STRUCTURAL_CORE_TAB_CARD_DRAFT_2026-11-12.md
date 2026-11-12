# TRUST-S1: the Structural tab cut down to the core, roof down

**Status: DRAFT.** Not approved, not built, not tested, not installed. No code starts until Tim approves this card.
**Class:** Modify (the Structural ribbon and pull-down menu). Nothing is deleted; every command can still be typed.
**Source:** Tim, 5 Nov: small core for colleagues, "KEEP WHAT IS ACTUALLY WORKING FROM STRUCTURAL". Tim, 4 Oct: Structural drafts roof down (UX-STRUC-13). Step S1 of `areas\trust-plan-structural.md`. Tool list: that file, section 1, and the keep / hide list that follows it.

---

## FOR TIM

**Today the Structural tab shows about 300 buttons in seven panels sorted by kind of tool. This card shows about 30 (32 in the full list, `areas\STRUCTURAL_COMMAND_SORT_12NOV.md`), in the order you draft a house: roof, floors, bracing, then tools.**

```before
Tab "CE STRUC" (or "CE Structural"): Beams | Columns & Footings | Rebar & Bracing |
Annotate | Schedules | Line styles | Admin. About 300 buttons.
P1 and Settings sit in Annotate because nothing says where they belong.
```

```after
Tab "CE Structural", once cards S2 to S4 are in: Roof (R1, P1, BT1) |
Floors (beams 1 2 4 5, BDL, BSET, DS, DS1, TS1, C1, C2, the five switches, FJ1) |
Bracing (AB, BB, A/B switch, bracing panel, schedules) | Tools (CLEAN, Help, Settings).
32 buttons. On the first trial day (decision 3, recommended): 27; BT1, the bracing
panel and the three schedule tools stay typed only until card S4 is in.
```

**What this card does not do:**

1. **It does not stop anyone typing a hidden command.**
2. **It does not fix any tool.** Which faulty tools wait off the tab is decision 3.
3. **It does not touch footings.** Footing tools are typed only until each earns its place.

## Decisions for Tim (read these first)

1. **The button list.** Recommended: the list above (from your command log). OPEN.
2. **Panel names.** Recommended: Roof, Floors, Bracing, Tools. Example: a new colleague drafting a roof looks left first. OPEN.
3. **Buttons with open faults.** Recommended: **off the tab until card S4 is in: BT1, the bracing panel, STRSCHEDCREATE, STRSCHEDREFRESH, STRSCHEDSYNC,** because each can overstate bracing or change the wrong pier on a sheet. **On the tab, with the fault written on the tool note: the support blocks and CLEAN,** because they are your most used tools, the support block fault bites only when a member schedule is in the drawing, and CLEAN's fault is its wording. Example: a colleague clicks Bracing Schedule and gets a table one row short; under this they cannot click it until it is fixed. OPEN.
4. **Beam drop-down:** recommended **yes**, one Beam button with 1, 2, 4, 5 inside, because the numbers mean nothing to a new colleague. OPEN.
5. **Tab name:** recommended **"CE Structural"**, matching "CE Drainage" and "CE Design". OPEN.
6. **What decides a button: the core list or the expert mark.** Recommended: **the core list alone.** The expert mark keeps its present meaning (it only hides tools in the palette and Help). Example: STRSCHEDREFRESH is marked expert today but is in the core list, so it is on the tab once card S4 is in. OPEN.

## 1. What you'd see

1. **One Structural tab** beside the Civil tabs, on every drawing, as today.
2. **Four panels in drafting order,** left to right: Roof, Floors, Bracing, Tools.
3. **Typing any hidden command still runs it,** including the old short names (SDS, ABS, FASTSAVE).
4. **The old flat tab** comes back with one switch and a restart.

## 2. The full experience

1. **Trigger:** the ribbon is built when AutoCAD starts. Changing the switch needs a restart, and the Settings row says so.
2. **Prompts, selection, preview, Cancel, Undo:** none. Layout only; no drawing is touched.
3. **Save and reopen:** nothing is stored in a drawing.
4. **Locked layers, Xrefs, REFEDIT:** not touched.
5. **The pull-down menu (all AutoCAD years):** today it comes from a ready-made menu file or a separate 219-command list, not from the list the ribbon reads (Verified, `Services\WorkspaceMenuInstallerService.cs:40-61`; the 219 count is carried). **This card makes both read one office core list,** so they cannot drift.
6. **AutoCAD 2022 to 2024:** the tools that only work on 2027 stay greyed with a plain reason, as built for UX-STRUC-12.
7. **Discovery:** Help lists every typed command, as today.

## 3. Settings

1. **"Structural core tab"** (new, off by default): on = the four-panel tab. This is the switch for the trial and the undo.
2. **The core list** lives in one office file shipped with the release, read by the ribbon and the menu. Office-wide, not per person.
3. **The expert mark is not used for the core tab** (decision 6). Today the ribbon ignores it (Verified, `Services\RibbonCommandHubService.cs:178`); the core list alone decides.

## 4. What it reuses

1. **The hidden mark,** which the ribbon already obeys (Verified, `RibbonCommandHubService.cs:176-179`).
2. **The ribbon family code ruled on 25 Sep** (beam and tag drop-downs, one name per tool), built and off. Whether the core tab uses the drop-downs is decision 4.
3. **The Civil core list file** from card TRUST-02, so Civil and Structural choose buttons the same way.

## 5. How it gets proven

**Robot, AutoCAD 2027:**

1. Read the ribbon back against the core list: every panel and button in order. Any extra or missing button fails.
2. Press every button once on a made-up Structural copy: each starts its command.
3. Type ten hidden commands, including SDS, ABS and FASTSAVE: each runs.
4. Read the pull-down menu: same tools as the core list.
5. Switch off and restart: the old tab is back, complete.
6. A list with one button removed must fail check 1.

**Robot, AutoCAD 2024:** the menu lists the same tools.

**Codex:** one look at the tab at normal and narrow widths: labels not cut off, no software words, icons present.

**Tim, about three working days:** draft a real job roof to bracing from the tab. Right = you never typed a command you use daily and never hunted for a button.

## 6. Not known yet

1. **Which of the two Structural ribbon builders draws on Tim's PC today:** the own "CE STRUC" tab (`RibbonCommandHubService.cs:17`) or the shared "CE Structural" contribution (`CeStrucRibbonContributor.cs:18`). The card must change whichever is live. Both were read; which runs was not traced.
2. **How the command log's "BEAM" maps to 1, 2, 4 and 5.**
3. **Which Structural tools colleagues use.** No record.

Written from reading Structural 1.0.126 (commit 8de95c34). Nothing here was run in AutoCAD.
