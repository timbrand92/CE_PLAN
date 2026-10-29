# Area H — SPS/pump stations, wet wells, pump controls and rising mains

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

SPS/pump stations, wet wells, pump controls and rising mains. (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `04_REFERENCE\civil-system-design-2026-09-16\`

## 3. Items and status

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "Planned". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

1. **UX plan, 26 Sep 2026 (Tim, UX-SPS-01 to 04):** one Pump Station tool (wet well, duty + standby pumps, inlet, rising main start, storage from the catchment, one U); rising main drawn as a Rising Main pipe to a discharge pit; the office SPS detail filled from the job; CE gives the duty point, the engineer names the pump. Not built. Needs a workflow card (release chat). Record: decisions/2026-09-25_V3_PLAN_DISCUSSION_RULINGS.md.

## 3b. Planning, 29 Oct 2026 (carpark and planning intake chat, from Tim's words)

Tim (decisions/2026-10-29_TIM_ANSWERS.md item 99, question 17, gap audit 17 Oct section 3 item 12, UX-SPS Q1 and Q3): "can we plan this in planning chat if its not organised already". **Status: PLANNED ONLY. Nothing built, tested, installed or Tim-accepted.** Until Tim answers, the default stays "detail not set" and the duty-point working still runs.

**Was it already organised? Partly.** The card `04_REFERENCE\ux-plan\cards\UX-SPS-01-04_PUMP_STATION_CARD_2026-10-07.md` (draft, 7 Oct) holds Tim's four rulings and a build order, but its "what exists today" is out of date and its Q1 and Q3 were never answered. What the installed code (Civil 3.0.85, commit 09126560, read not run) already has:
1. **A pump sizing engine** (`PumpSizingService`, with a CDCALC "Pump System" tab): worst storm for the job's rainfall, wet well volume, pump duty from a ladder (1, 2, 3, 4, 5, 6, 8, 10, 12 L/s), static rise, rising main size, notes showing each step.
2. **An SPS detail generator** (`SpsDetailGenerator`) that draws the wet well and tank section from the office detail's conventions.
3. **Three pump settings on the Settings page** (the rising main split at 5 L/s and the 50 mm and 80 mm sizes). The other numbers are fixed in the code (see Q3).
4. **Missing, as the card says:** friction loss and total head (the engine gives static rise only), a Pump Station command and window, a Rising Main pipe to a discharge pit, the master detail filled from the job.

**Q1, where the master detail lives (found on the drive, not yet confirmed by Tim).** In `Creative Engineering - Drafting\Standard Details\Civil`: `CE Civil WATER TANKS - PUMP STATIONS Details.dwg` (with a .dxf, and many .bak copies from different PCs), `CE Civil PUMP STATION Detail.pdf` and `SPS DIAGRAM.pdf`; older copies sit in `0_SUPERSEDED`. Recommendation: the .dwg in the Civil folder is the master, the PDFs are print copies, the .bak and SUPERSEDED files are ignored. Tim confirms one name.

**Q3, the storage rule (the engine already has one; Tim has not approved it).** In plain English: the wet well holds the larger of (a) the water from the worst storm minus what the pump moves in 30 minutes, and (b) 10 mm of rain over the catchment (1 percent of the area in cubic metres). The pump is the smallest on the ladder whose 30-minute volume covers the well. The pump pit invert sits 100 mm below the inlet. Fixed in the code today (R-00 breach, to move to Settings with sources): the 30-minute emptying time, the 1 percent, the pump ladder, the 100 mm, the runoff figure 0.90 for hard surfaces, Bayside's 1 in 20 storm, and the storm durations swept. Recommendation: keep the rule as it is, ask Tim to approve or change it in plain words, move each number to Settings, and show the working beside the result (as the card already says).

**Build order (each slice a card and Tim's approval before code; any builder can build any item, PC-06):**
1. **H-0 Reconcile the card** with the code above (the intake chat has not edited the card).
2. **H-1 Settings-first:** the fixed numbers above onto the Settings page, with sources, once Tim approves Q3. No behaviour change at the starting values.
3. **H-2 Duty point complete:** add friction loss and total head (needs the card's Q2: friction method and roughness, recommended Hazen-Williams with Tim's roughness value; never guessed).
4. **H-3 A hidden CDPUMP** that prints the duty point from typed flow, lift and main (gap audit step, PR 1058). The engineer names the pump; CE never does.
5. **H-4 Rising Main pipe type** to a discharge pit through the normal pipe path (card Q4: what the duty flow is on a stormwater job; recommended typed by the engineer with CE showing what the catchment suggests).
6. **H-5 The Pump Station window and plan picture,** Accept as one Undo, then the master detail filled with the job's levels, storage, duty and main size; Unknown stays "Unknown" (needs Q1).
7. **H-6 Council variants** (storm and rules per council from the council rulebook, not the code).

**Still open on the card, not asked in item 99:** Q2 friction method and roughness, Q4 duty flow on a stormwater job, Q5 command name and ribbon home (recommended `CDPUMP`, hidden until the first slice passes).

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_
