# BUG-562: where the start-up "; error: syntax error" does NOT come from (build/03 run 81, Sat 10 Oct 2026, read only)

**Answer first:** it does not come from any CE file. Everything CE ships or installs that AutoCAD could run as LISP at start-up was read and is clean. The evidence points at the stale CE menu groups still listed in Tim's own acad.CUIX (BUG-435), because the line comes straight after the two "Menu item failed to load" lines. That is not proven: only AutoCAD itself can say which file prints it. Nothing in Tim's files was changed.

## What was checked (all read only, nothing written)

1. **Tim's start-up chain.** `...\AutoCAD 2027\R26.0\enu\Support\acad.lsp` is 3 lines: `(load "ce_suite_startup.lsp")`. `ce_suite_startup.lsp` (77 lines, written 5 Oct) defines three helper functions and an `s::startup` whose body is only comments (the NETLOAD route was retired). Brackets balance in both (final depth 0, no open string). `AecArchxOE.mnl` (Autodesk's own, 4 Feb) also balances. There is no `acaddoc.lsp` and no other `.mnl` in that Support folder.
2. **CE bundles.** `CE_CVL_SUITE.bundle` and `CE_STRUC_SUITE.bundle` carry `Copy Rotate.lsp` (and Structural carries `TIM Copy Paste as Block - CPB 1.lsp`) under `Win64\Legacy\Assets\Lisp` and `Win64\Net8\Assets\Lisp`. Both balance. Nothing loads them at start-up: they are only loaded by a command, when the user types it. `CE_SUITE_MANAGER.bundle` has no LISP, no CUIX and no menu file. `Modern\Assets\Lisp` does not exist.
3. **CE code.** No CE source sends a LISP expression at start-up. The only places that send `(progn ...)` or `(load ...)` are commands (Copy Rotate, the Structural text mirror, the Structural CPB route), each run by a click or a typed command.
4. **CE logs.** `ce_cvl_structured_20261010.log`, `ce_struc_structured_20261010.log` and the other CE logs contain no "syntax error" at all. So AutoCAD prints it, not CE.
5. **Tim's main menu file.** `acad.CUIX` (and the two copies `acad.CUIX.before_ce_cleanup_20261009` and `acad.cuix.ce_bak`) still hold workspace entries for the menu groups `CE_CVL_SUITE_MENU`, `CE_STRUC_SUITE_MENU`, `CE_SUITE_MANAGER_MENU`, plus two groups AutoCAD cannot find (`SP2006`, `TIM_CAD_SUITE`). These match the start-up lines "Menu item failed to load: CE_CVL_SUITE_MENU:CE CVL" and "...CE_SUITE_MANAGER_MENU:CE Manager" (Codex W46 item 7, in that order, then the syntax error, then "CE CVL loaded").

## What is not known

1. **Which of the two unresolved groups, or which stale menu, prints it.** A stale menu group with a companion `.mnl`, or a macro in `TIM_CAD_SUITE` / `SP2006`, is the likely kind. The profile's Startup Suite (APPLOAD list) is in the registry, which a shell must not open (BUG-238), and it was not read.

## Cheapest way to settle it (for Codex, or Tim's menu clean-up in DAY1)

1. Start AutoCAD on a **copy of Tim's profile** after the stale groups are unloaded (`CUIUNLOAD` the three CE groups, then `CUIUNLOAD` `SP2006` and `TIM_CAD_SUITE`) and read the first lines again. If the syntax error is gone with the menus, BUG-435's clean-up is the fix and BUG-562 closes with it. If it stays, open `APPLOAD` > Startup Suite and read the list; the file named there is the source.
2. Nothing for CE to change in code.
