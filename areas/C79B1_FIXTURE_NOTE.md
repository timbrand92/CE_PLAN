# C-79b1 damaged-record fixture: F1 note (Sun 1 Nov 2026, Opus fixture builder F1)

**Answer first: the four setups and four probes are written, but NONE can run today.** The robot deliberately refuses typed Lisp: the case validator says "typed text may not contain '(' (typed LISP wedged AutoCAD in run 47)", and v2 `type` refuses "(" unless `-AllowLisp`, which the case runner never passes. Validate: the 4 probes are 4 invalid, so I moved them to `cases\drafts_c79b1_01nov\held_dmg_lisp_blocked\` (the main folder validates 0 of 0 and the writers' checks stay clean). Control ids: every control id is known (no window steps).

1. **What is needed to unblock (CE 00 / Tim decide; F1 edited no driver file):** recommended, one new v3 driver verb that writes ONE text into ONE named CE record through COM (no typed Lisp, so no run-47 wedge risk). Second choice, let the runner forward `-AllowLisp` and lift the validator ban for that flag only; that reverses a safety rule made after a real wedge.
2. **Files written:** `cases\_setups\SETUP-DMG-LINKS`, `SETUP-DMG-OUTLETROLES`, `SETUP-DMG-LPD`, `SETUP-DMG-PITLIST` (`.setup.txt`); probes `PROBE-DMG-LINKS`, `-PITLIST`, `-OUTLETROLES`, `-LPD` (`.case.txt`, FAMILY dmgprobe, ORDER 901 to 904) in the held folder.
3. **Damaged bytes:** only #1892's test builds real bytes: `{"Pipes":[{"PipeHandle":"2A4",` (truncated JSON, "as BUG-1154 leaves it", `Bug1141UnreadableLinkRecordTests.cs`, PR #1892 diff line 114). #1940, #1943, #1952, #1958 and #1953 pass a "damaged" flag, not bytes, so all four setups write that same string. It is invalid JSON in every reader, and every reader treats invalid JSON as unreadable (traced below).
4. **Writers: use these names now.** The setup names are final; only the Lisp route changes once unblocked. Each setup leaves `$<name>_before`, `$<name>_after` (expected `DMGREAD {"Pipes":[{"PipeHandle":"2A4",`) and `$n0`.

---

## Common to all four setups

1. **How the Lisp is built:** a typed case word cannot hold a double quote, and v2 refuses whole words such as NEW, LOAD, OPEN, SAVE and PRINT. So every string comes from character codes (`vl-list->string`) or a symbol name (`vl-symbol-name 'X`). Each line is one complete expression, 38 to 228 characters (the limit is 500). Brackets balance and no line holds a refused word (checked with `C:\ce-fx\c79b1_f1\check_typed.ps1`, which uses v2's own deny list).
2. **The four shared lines (identical in every setup):**
   - `(setq cedmg (vl-list->string '(123 34 80 105 112 101 115 34 58 91 123 34 80 105 112 101 72 97 110 100 108 101 34 58 34 50 65 52 34 44)) cedmgm (vl-list->string '(68 77 71 82 69 65 68 32)))`. This sets the damaged text and the readback marker `DMGREAD ` (decoded and checked in PowerShell).
   - `cedmgput (d k)`: if record k exists in dictionary d, it is removed (`dictremove`) and erased (`entdel`), then a new Xrecord holding `(1 . cedmg)` is added under the same name (`entmakex` + `dictadd`). The text uses group 1, the DxfCode.Text that every CE reader joins.
   - `cedmgdict (p k)`: returns sub-dictionary k of p, creating it if it is missing.
   - `cedmgget (d k)`: prints `DMGREAD ` plus the first 60 characters of the record's text, or `DMGREAD NONE`.
3. **Undo:** the damage is an ordinary drawing change, so a U straight after the setup takes it away. Cases must run their own command before any U. The probes draw a line at 190000,-95000, U it, then read the record back to prove the damage survived.
4. **Nothing is saved:** the session copy on disk stays the master copy, as the runner requires.

## 1. SETUP-DMG-LINKS (the saved pit-and-pipe link record): #1892, also the link side of #1958, #1952, #1970

1. **Where the record is:** this record is on the pit itself, not in the drawing-wide CE dictionary: pit `109D56` (P3, named in SETUP-R47's comment), its extension dictionary, then `CE_CVL_SUITE_LINKS`, then Xrecord `PIT_LINK`. Names: `LinkService.cs:24-25` at 9545489c. Read by `ReadPitLinkJson`, `LinkService.Persistence.cs:754-769` at 9545489c.
2. **Lisp:** `(progn (setq cex (cdr (assoc 360 (entget (handent "109D56" from codes)))) cel (… (dictsearch cex 'CE_CVL_SUITE_LINKS))) (cedmgget cel 'PIT_LINK))`, then `(if cel (cedmgput cel (vl-symbol-name 'PIT_LINK)))`, then the readback.
3. **What CE should print (#1892, head 9545489c), once per drawing per session, at the U after another command (the full rebuild at `LinkService.Reactors.cs:924`):** `[CE] The CE link record on one pit (drawing handle 109D56, at <x>, <y>) could not be read, so CE skipped it and loaded the rest. That pit may not drag its pipes when it is moved; its record has been left as it is.` (`UnreadableLinkRecordRule.Line`, PR diff lines 253-289). Log: `[Link] BUG-1141: pit 109D56 has a link record that cannot be read; skipped by the cache rebuild and left as it is.` (PR diff, `NameUnreadableCacheRecord`).
4. **Could NOT confirm offline:**
   - that 109D56 is a pit with a `PIT_LINK` record in DRV1_B1;
   - that `assoc 360` on the pit is its extension dictionary;
   - that the rebuild after U with light reads goes through `CachePitCacheEntry` for every pit;
   - that the U of the line does not also take back the Lisp change.
5. **#1970 needs a PIPE record, not this one:** #1970 needs a pipe whose level write fails (its own PR text: "make a pipe whose CE record is damaged (a case the robot does not have yet)"). That is the same Lisp with a PIPE handle and `PIPE_LINK` (`LinkService.cs:26`). I do not know a pipe handle in DRV1_B1 offline, and I have not confirmed that a damaged `PIPE_LINK` really makes `TryStorePipeInverts` return false. The expected line is `[CE] Warning: the level was not saved on pipe <name> itself. ...` (PR #1970 diff line 242).

## 2. SETUP-DMG-PITLIST (the saved pit list CE keeps): #1952, #1958, part of #1953

1. **Where the record is:** the drawing-wide dictionary, then `CE_CVL_SUITE_PROJECT`, then Xrecord `PROJECT_DATA`. Names: `ProjectDataStorageContract.cs:9-10` at 6845a095. Read by `TryLoadFromDrawing`, `ProjectDataService.Persistence.cs:1062-1117` at 6845a095: invalid JSON is caught, so the record counts as existing, holding text, and unreadable. That is the BUG-971 hold state.
2. **Lisp:** read `(dictsearch (namedobjdict) 'CE_CVL_SUITE_PROJECT)`, then `(cedmgput cen 'PROJECT_DATA)`, then the readback.
3. **What CE should print:**
   - **When a drawing opens with this damage (command line):** `[CE] The CE record in this drawing could not be read (it may have been written by a newer CE). CE will not save over it, so the original schedule rows and remarks stay in the drawing. Changes made now to the CE record will not be saved. Open this drawing with the newer CE, or ask for help.`
   - **After U, with #1952 (log only, no command line):** `[ProjectData] The CE record in this drawing exists but could not be read (it may have been written by a newer CE). CE will not save over it; the original stays in the drawing.` (both at `ProjectDataService.Persistence.cs:994-1003` at 6845a095).
   - **Possible older-build log line:** `Project data could not be refreshed after U; reopen CDEDIT before relying on schedule values.` (`LinkService.Reactors.cs:915`).
   - **#1958 (log, once per drawing):** `[Inspector] The pit and pipe list saved in this drawing could not be read; values show as Unknown.` (`InspectorPaletteService.cs`, PR #1958 diff line 977).
4. **Could NOT confirm offline:**
   - whether CE writes its in-memory list back over the damage at the next CE command, or reacts to the erase of the old record;
   - most important: #1958 and #1953 only act when CE has NO list in memory, which means a drawing just OPENED with the damage on disk. The runner cannot reopen inside a case, and it refuses to reopen a copy whose file changed. So this live setup serves #1952 fully but #1958 and #1953 only once a damaged drawing FILE exists. One way: the setup plus `save-copy` as the last case of a session (ORDER 99), then the runner owner promotes that copy as a fixture. That is a runner-owner decision, not F1's.

## 3. SETUP-DMG-OUTLETROLES (the saved outlet roles record): #1940

1. **Where the record is:** the drawing-wide dictionary, then `CE_CVL_NETWORK_REDESIGN`, then Xrecord `OUTLET_ROLES`. Names: `NetworkRedesignOutletRoleService.cs:13-15` at c55494e0. `ReadWithStatusInTransaction` (PR diff lines 628-700): invalid JSON, empty text or the wrong object type reads as Damaged; a missing record reads as Missing.
2. **Lisp:** as for PITLIST, with `CE_CVL_NETWORK_REDESIGN` / `OUTLET_ROLES`. The dictionary is created if the drawing has never been redesigned; the before-read shows `DMGREAD NONE` in that case.
3. **What CE should print (only in the Civil Hub redesign Apply result, `CivilHubService.cs:65`):** `Warning: the outlet roles saved in this drawing at the last redesign could not be read, so the check of the nominated outlets against them was skipped. CE kept a copy of the damaged record in this drawing (CE_CVL_NETWORK_REDESIGN, OUTLET_ROLES_DAMAGED_COPY) before writing the new roles.` Log: `CV-01H4 apply: Warning: ...` (PR diff lines 388-401 and 456). The copy `OUTLET_ROLES_DAMAGED_COPY` can be read back with `(cedmgget ceo (vl-symbol-name 'OUTLET_ROLES_DAMAGED_COPY))`.
4. **Could NOT confirm offline:**
   - whether DRV1_B1 holds this record;
   - the Civil Hub redesign window's control ids (the probe only proves the damage is in place).

## 4. SETUP-DMG-LPD (the saved LPD record): #1943

1. **Where the record is:** the drawing-wide dictionary, then `CE_CVL_SUITE_LPD`, then Xrecord `DATA` (the legacy single-LPD record). Names: `LpdStorageContract.cs:10-11` at 62c8f363. Invalid JSON gives `The legacy LPD DATA record is damaged.` (status Unknown, `MultiLpdDrawingAuthorityReader.cs:150-171`). #1943 counts that as unreadable (PR diff lines 880-896). With no LPD dictionary at all, the drawing simply reads as having no LPD, not unreadable.
2. **Lisp:** as for PITLIST, with `CE_CVL_SUITE_LPD` / `DATA`. An extra before-read records whether `AUTHORITY_SET` exists: DATA beside AUTHORITY_SET is also Unknown, but for a different reason ("both legacy DATA and ...", lines 107-112).
3. **What CE should print (redesign Apply result):** `Warning: this drawing has a legal point of discharge (CDLPD) record that CE cannot read, so the check that keeps a Fixed outlet where it is was skipped. Apply does not change the CDLPD record. Open CDLPD to check or re-confirm the outlet.` (PR diff lines 287-289).
4. **Could NOT confirm offline:**
   - whether DRV1_B1 has an LPD;
   - what CDLPD itself prints on this damage (not traced).

## Faults noticed (name only, nothing edited)

1. **No sanctioned record-damage route in the driver:** the case runner's `type` neither knows nor forwards `-AllowLisp`, and the validator bans "(". So no robot case can build any damaged-record fixture today. The C-79b1 plan's "one Team builder job" for this fixture assumed a route that does not exist.
2. **`gh` is not on the tool PATH:** I used `C:\Program Files\GitHub CLI\gh.exe`.
