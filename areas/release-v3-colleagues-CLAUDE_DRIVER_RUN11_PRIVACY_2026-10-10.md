# Claude driver run 11: the privacy pass, Saturday 10 Oct 2026 (PC clock 06:19 to 06:25)

**Run:** CE_ACAD / release-v3-colleagues / test / 01, run 11, Sonnet, headless. Gate item 11 (no colleague hand-out before both privacy builds are checked). Test copies only: `C:\ce_rc_drv\CLD19_B1.dwg` (hash 34BBE37C2EA4 = DRV1_B1) and `C:\ce_rc_drv\CLD19_S1.dwg` (hash 950AFDF6E523 = DRV2_S1), both open and writable in one AutoCAD 2027 (pid 34740, started by the driver; `Get-Process acad` showed nothing first). Driver: `acad_driver_witness.ps1` only, through a counting wrapper. Nothing saved. The driver was not bypassed.

## Answer first

1. **New remote addresses: none.** The established TCP connections of acad.exe were sampled 17 times (at start, after every AI-related command, after every step, and at the end). Every sample showed 0 established connections to any address other than this PC. At the end the process held one local connection and one bound port, nothing remote.
2. **Nothing AI-related PASSED or FAILED on its on-screen wording, because the driver cannot see those windows.** The CDASK palette and the CEMARKUP window are not readable (details in items 4 and 5). So the exact "AI features are switched off on this PC" and Hand/Hybrid sentences were **not read on screen**. The privacy claim (nothing sent) is supported by the network watch, not by reading the messages.
3. **Counts, 7 items:** PASS 3, BLOCKED 2, SKIPPED 2, FAIL 0. Driver calls used: **43 of 70**, about 6 minutes of 90.
4. **Versions read first (nine DLLs, readdll.ps1):** Civil 3.0.44+b7eed253, Manager 1.1.44+b7eed253, Structural 1.0.113+2e0cf385, all three lanes each. The start-up line printed `CE CVL loaded: CE_CVL_SUITE v3.0.44.0 [Modern]`.
5. **AutoCAD closed cleanly** (driver `quit`, close window, no kill, lock released); the last line below says so.

## Network watch (item 1)

1. **Method:** `Get-NetTCPConnection -OwningProcess 34740`, Established state, loopback excluded, addresses only. No drawing data read or printed.
2. **Samples:** before launch (no acad), then 06:20:06, 06:20:21, 06:20:38, 06:20:45 (after CDASK), 06:20:57, 06:21:17, 06:21:36 (after CDIMPORTXCIVIL), 06:21:44, 06:22:01, 06:22:31, 06:22:45 (after CEMARKUP), 06:22:53, 06:23:06, 06:23:45, 06:24:25, 06:24:39 and a final all-state read before quit. Result each time: 0 remote.
3. **Environment:** CE_CLOUD_URL and CE_CLOUD_AUTH are both set on this PC (names only read, values never printed). New remote addresses: **none**.
4. **What this does not prove:** a short connection (the CE Cloud start-up heartbeat the C-35 report says is still sent: install code and versions) could open and close between two samples. I did not see one, but sampling every few seconds cannot rule it out. A proper proof needs a packet or proxy log on the PC, which is the finalizer's fake-service method, not this one.

## The items

1. **CDASK (Civil, AI features OFF): BLOCKED for the message, PASS for "nothing sent".**
   1. Typed `CDASK` with `-Force` (bare, because it opens the palette and asks nothing; source: `AskCommand.cs` only toggles the palette). It printed `Command: CDASK` and nothing else; CMDACTIVE 0, no alarm. The CE log printed `CE Assistant palette created` at 06:20:44.
   2. **The palette is not visible to the driver.** `ui windows` listed only AutoCAD and the CE Inspector and Footings palettes; `ui scan "CE Assistant"` said "no visible window matches". So I could not read the sentence `AI features are switched off on this PC (Settings > AI > AI features). Nothing was sent.`. In the code it is shown only after a question is sent in the palette (or its buttons are pressed), and sending one is a click and typing step the driver cannot do on a window it cannot see.
   3. The Civil settings file (`CE_CVL_SUITE\settings.json`, 672 bytes) has no AI group, and Tim's `CD_Settings.json` is unchanged, so AI features are OFF (the default). Network: 0 remote after the command.
2. **CDIMPORTXCIVIL (Civil): PASS (first prompt only).** Typed `CDIMPORTXCIVIL` with `-ExpectWindow "X-Civil import"`. The window `Creative Engineering | X-Civil import` appeared in 6 s. Its text: `Choose the consultant drawing or package. Check the schedule before co...`, source `No source chosen`, buttons `Choose DWG…`, `Choose package folder…`, `Read source` (disabled), `Close`. No file picked, so the "try AI extraction?" question could not be reached; **it never appeared** (it only comes after a failed schedule read). `ui scan`: plain English OK, 0 jargon, 0 raw ids. Closed with `ui close` (WindowPattern.Close). AutoCAD printed `CDIMPORTXCIVIL cancelled. Nothing was drawn.` Network: 0 remote.
3. **Analyse markups on a layout tab: SKIPPED.** It is a button in the CDASK palette, which the driver cannot see, and it needs a layout tab picked. Not tried.
4. **CEMARKUP (Structural): the window opens; its text is BLOCKED.** Typed `CEMARKUP` with `-Force`. AutoCAD printed `[CE_STRUC_SUITE] Opening CEMARKUP review window.`; CMDACTIVE 0. `ui windows` shows a window titled `CEMARKUP` (view-only). `ui tree "CEMARKUP"` was **REFUSED**: the title is not on the CE window allow-list. I did not go round the refusal. The window was left open and closed with AutoCAD.
5. **CEMARKUPPARSE, Parse, Ask AI (Structural): SKIPPED.** CEMARKUPPARSE opens a file picker first (`PromptOpenFileOptions`), then asks source mode and project type; I could not prove a complete one-line form (a FILEDIA 0 command-line file prompt is untested here) and the driver cannot press a picker. Not typed. The Hand sentence `Use Bluebeam mode, or tag the marks by hand.` and Hybrid sentence `Hand-drawn marks on the PDF are not read; tag them by hand.` are in the code (`MarkupAIOffPcPolicy.cs`), not seen on screen. Parse and Ask AI are buttons in the CEMARKUP window: not reachable.
6. **REDO sanity on the new build: PASS 2 of 2.** Both: plain `_.CIRCLE 0,40000 10`, `U` (echo `CIRCLE`), 15 s, switch to the other drawing and back, `REDO` printed `CIRCLE` and `Everything has been redone`. (a) on Structural (CLD19_S1), (b) on Civil (CLD19_B1). No `Nothing to redo`.
7. **System variables (both drawings): PASS, unchanged.** Civil before and after: OSMODE 5375, SAVETIME 5, CLAYER "BLOCKS". Structural before and after: OSMODE 5375, SAVETIME 5, CLAYER "0". I used no `setvar`.

## Settings files before and after

1. Eleven JSON files read by hash before and after (Civil `settings.json`, Structural `CS_Settings.json`, and the TIM_CE_CADTOOLS set including `CD_Settings.json` ACD64E79 and `CS_Settings.json` 622A246F). **Ten identical.**
2. **One change: `CE_STRUC_SUITE\CS_Settings.json` grew from 29,213 to 29,249 bytes (B823E5EB to D43EFEB1).** This is the expected first start of Structural 1.0.113 (the controller's entry 256 said it adds `SendPagesToAiEnabled`). I did not read the file's contents; 36 bytes fits one key. New baseline for later runs: **D43EFEB1, 29,249 bytes**.

## What I could not prove

1. **The on-screen wording of every AI-off message** (CDASK, Hand and Hybrid sentences). Two driver gaps cause it: (a) the CE Assistant palette is not visible to `ui windows`; (b) the CEMARKUP window title is not on the allow-list, so even `ui tree` is refused.
2. **That nothing is sent.** I saw no remote connection, but I also pressed none of the send buttons (Analyse markups, Ask AI, Parse). The no-send proof for those stays the finalizers' fake-service test.
3. **The X-Civil "try AI extraction?" question.** It needs a picked source file whose schedule read fails.
4. **Whether the CE Cloud heartbeat connected.** Not seen; too brief to catch by sampling.

## Gate item 11 reading

1. **Not yet green by this run alone.** What this run adds: no remote connection, the X-Civil window never asked an AI question, CEMARKUP opens and prints its own line only, REDO works on both builds, nothing changed in the settings except the expected Structural key.
2. **What is still needed:** someone to read the CDASK palette sentence and the CEMARKUP window sentences once. The cheapest way is Tim or Codex looking at both windows (about 3 minutes), or a tooling change to the driver.

## Findings for the tooling worker

1. **Allow-list:** add `CEMARKUP` (read-only: tree, read, scan, close) and the CE Assistant palette (title to be found) as view-only readable windows.
2. **`ui windows` does not list the CE Assistant palette** even though the CE log says it was created (`CE Assistant palette created`). It may be floating off the lists or on another monitor; same family as run 5's second-monitor gap.
3. **`quit`** deleted its stray logs as before; harmless.

## Summary

AutoCAD closed cleanly: PASS 3, BLOCKED 2, SKIPPED 2, FAIL 0, 43 of 70 driver calls.
