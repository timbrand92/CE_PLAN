# Train S-45 (Structural only): PR list, Mon 26 Oct 2026

Written by the Team job that wrote the S-45 job files (about 17:50 Melbourne time). Source: `release-v3-colleagues-R2_FIXES_APPLIED_26OCT.md`, section "Structural (base 3a3caac5)". Tim's ruling of 26 Oct: smaller, regular updates, because the testing numbers must go up (`decisions/2026-10-26_TIM_ARCHUNITNET_ADOPT_SMALL_UPDATES.md`). This train is the six round-2 Structural PRs and nothing else.

## ANSWER FIRST

1. **Base:** `claude/rel-20261025s` at `3a3caac5db7687f1b5d1a6e09571976c52b2b05a` (read with `git ls-remote` at 17:45 on 26 Oct). That is the INSTALLED Structural 1.0.124 (train S-44). The Opus-signed head under the version commit is `007a211d9db4bdbd259a7ed821a21711c3b1e92f`.
2. **New branch:** `claude/rel-20261026s` (free on origin when checked; the branches `claude/rel-20261026t` and `claude/rel-20261026u` that exist belong to Civil and Manager trains). New version: Structural 1.0.125. Payload candidate: `s1043`, report `PAYLOAD_S1043_REPORT.md` (the last report on disk is `PAYLOAD_S1042_REPORT.md`).
3. **Six PRs, all OPEN drafts, all with base `claude/rel-20261025s`, every one a new round-2 PR that replaces an older PR (the old PR stays open and untouched).** Heads read live with gh at 17:45 on 26 Oct are below. The assembler reads them again at merge time; a head that moved must be a descendant of the head below or the PR is left out.

## The six PRs, in merge order

1. **#1792 (BUG-503 S-13, replaces #1157)**, head `04f4d1696a3533fee1d22c6a9fbecd14fc6ea428`. The FADOPT raft question "Are they External or Internal beams?" now sees an EB label. Switch `AdoptAsksUnlabelledBeamKind`, ships ON. Files: `AdoptBeamKindAsk.cs` (new), `FoundationService.cs`, `UserSettings.cs`, test `AdoptBeamKindAskTests.cs`, `REGRESSION_LOG.md`.
2. **#1793 (BUG-530, replaces #1154)**, head `c8e45895cb3aa3d0707947ecc343c2a3ccec7054`. An old pad with no recorded size is drawn at the 600 mm placeholder with a warning. Switch `UnknownPadSizeIsNotInvented`, ships ON. Files: `UnknownPadSizePolicy.cs` (new), `FoundationService.cs`, `UserSettings.cs`, test `UnknownPadSizeTests.cs`, log. KNOWN CLASH with #1792 in `FoundationService.cs`, `UserSettings.cs` and `REGRESSION_LOG.md`: keep both.
3. **#1794 (BUG-550 and BUG-557, replaces #1139)**, head `0181c01b49e4eefa95d993cd508134b4f39aa691`. "Enable MarkupAI" becomes a real switch (stays ON, today's value); "Share learning data" starts OFF on a new PC; `CEMARKUPUNDO` is no longer behind the switch. Files: `MarkupAISwitch.cs` (new), `MarkupAICommands.cs`, `UiCommands.cs`, `MarkupAIModels.cs`, test `MarkupAISwitchTests.cs`, log. Touches the markup command path: the finalizer reads it for Cancel, Escape and U.
4. **#1795 (BUG-519, replaces #1135)**, head `ec7ef8a07d7f639a36162b1ec7aaf615e07efde1`. Structural prints one plain start-up line instead of the long list; the long list returns with `Diagnostics.ShowFullStartupList` (default OFF). Files: `StartupBanner.cs` (new), `Plugin.cs` (start-up only), `UserSettings.cs`, test `StartupBannerTests.cs`, log. Touches `Plugin.cs`: the finalizer must say it changes only the start-up message and no command, ribbon or registration.
5. **#1796 (BUG-503 S-15, replaces #1146)**, head `2e01d8fee6bae135cfba1187ea0da863ad061708`. Plain words in CSSOILREPORT, CSWINDCLASS and STRSCHEDREFRESH. Files: `StructuralPlainWords.cs` (new), `SoilAndWindCommands.cs`, `UtilityCommands.cs`, test `StructuralPlainWordsTests.cs`, log. Wording only.
6. **#1797 (BUG-453, replaces #843)**, head `c1533e67c2c2609c04a04c04b028e04936f865e1`. The off commands say "not switched on yet"; the lintel and roof point-load lines read as plurals. Files: five `*CommandService.cs` / `LintelProposalService.cs` one-line edits, test `OffEngineWordingTests.cs`, log. Wording only.

## Not in this train, on purpose

1. **The six OLD PRs they replace** (#1157, #1154, #1139, #1135, #1146, #843): they stay open and untouched (nothing closed or retargeted, D6).
2. **#1737 (BUG-1041):** still waiting for its two review fixes (head `4ae66b1b` at the S-44 finalizer).
3. **Every Civil and Manager PR:** they have their own trains.
4. **Anything not named above:** no PR is added without a review that says MERGE at the head merged.

## Settings expected from the train (the finalizer confirms in the merged code)

1. `AdoptAsksUnlabelledBeamKind` ON and `UnknownPadSizeIsNotInvented` ON (the old behaviour is the logged bug each time).
2. `Diagnostics.ShowFullStartupList` OFF.
3. MarkupAI: `Enabled` stays ON; `ShareLearningData` starts OFF on a new PC (the finalizer says what an old settings file that already holds a value does: not checked by the job writer).

## Carry-over from the round-2 report

1. **The Structural full suite stalled** at full CPU for 30 minutes on 26 Oct (R2 report, point 3). The S-45 finalizer runs it itself, names any hanging test and places it against the bare S-44 base.
2. **EB-label raft fault with the switch OFF (#1157):** every EB-labelled raft edge is adopted as Internal. For the desk.
