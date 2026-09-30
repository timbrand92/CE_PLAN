# Area M1 — Manager: dashboard, one-button update, safe updates and rollback

**Product:** CE_ACAD (the AutoCAD plugin). **Plan:** `C:\CE_PLAN\MASTER_PLAN.md`. **This file is the one place for this area's items, status, bugs, parked ideas, test steps and regression list.** Update it in the same reply as the work.

## 1. What this area is

Manager: dashboard, one-button update, safe updates and rollback. (From the area register in `MASTER_PLAN.md`.)

## 2. Where the detail is

1. `04_REFERENCE\manager\MANAGER_PRODUCT_PLAN.md`
2. GitHub issue #36 on the plugin repo

## 3. Items and status

1. **CE Blocks palette — code candidate, 24 Sep 2026:** Tim approved the `04_REFERENCE/CE_BLOCKS_PALETTE_CARD_2026-09-24.md` answers at 15:00 Melbourne: same inserts as today's tool palettes, one palette, buttons on the CE tabs, exported thumbnails first. `codex/ce-blocks` tip `a64199bb`, draft [PR #174](https://github.com/timbrand92/CE_ACAD_PLUGIN/pull/174), builds the Manager-owned CEBLOCKS command and settings, with a Civil CE button; Structural remains a separate later line. Twelve real exports and 307 blocks parse. Manager focused 16/16, Civil focused 18/18; both themes' actual palette pictures inspected. Manager and Civil three Release lanes have zero errors after the existing native ARX prerequisite was built locally. The full Civil suite is for the release chat after 17:30. Built and offline-tested only; not installed, opened in AutoCAD or Tim-accepted. The accepted native checklist is in `PENDING_TESTS.md`.

2. **M-SET-01 Move My Settings — decided 30 Sep 2026, not started.** Tim: "yes ship it inside the plugin, write the prompt". The Tim-accepted standalone CE AutoCAD Settings Transfer tool (2027 -> 2026 accepted in AutoCAD 30 Sep: "it works") ships inside the Manager bundle; a Manager-tab button **Move My Settings** (Save / Load / Undo) closes AutoCAD and hands over to it, then offers Start AutoCAD. Decision: `decisions\2026-09-30_SETTINGS_TRANSFER_IN_PLUGIN.md`. Build prompt: `CHAT_PROMPT_MANAGER_SETTINGS_TRANSFER_01.md` (chat name `CE_ACAD / manager / build / 01`). Open for Tim: OneDrive folder name; staff or admin-only button. **Queued by the release controller 30 Sep 2026 11:17 (INT-017), in two stages:** stage 1 (Parts A-C: import the tool into `Tools/CE_AcadSettings`, two engine fixes, launch options) started 11:16 by a Sonnet builder on `claude/manager-settings-move` (draft PR to follow); stage 2 (Parts D-E: Manager button and CESETTINGSMOVE in three lanes, packaging, 72-file validation) by an Opus builder after stage 1, then an Opus review. Tim's AutoCAD checklist is in `PENDING_TESTS.md`. Built / Tested / Installed / Tim-accepted: none yet.

_Opened 19 Sep 2026; this area had no area file before. Its state in the old master plan's register was "see the source documents". Add items here as work starts; say Built / Tested / Installed / Tim-accepted separately, never a percentage._

## 4. Bugs

`BUG_CARPARK.md` at the root of this repository is the one bug file. List this area's open bug IDs here.

## 5. Parked

`IDEAS_INBOX.md` at the root is the one idea file. List this area's parked items here.

## 6. Test steps

`PENDING_TESTS.md` at the root is the one list of built-but-not-tested work. Rows for this area are named there. Write steps Tim can follow in AutoCAD, saying what "right" looks like, in both lanes (2027 and 2024/net48).

## 7. Regression list

_"These things must still work", re-checked before any deploy. Seed from `REGRESSION_LOG.md` in the plugin repo._

1. _(none recorded yet)_
