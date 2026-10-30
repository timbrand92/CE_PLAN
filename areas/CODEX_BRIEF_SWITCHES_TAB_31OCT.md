# Codex brief: new Settings tab "Switches" (Tim item 126)

Written by CE 05, Sat 31 Oct 2026, for the Codex window lane (windows are Codex-owned). Not a Sonnet job. B number: ask CE 01 before the PR is opened.

## NAME THIS CHAT
CE_ACAD / civil-settings / build / 01

## What Tim said
Voice batch 1, item 9 (QUESTIONS item 75 and 75a): Tim's word "9yes". Decision item 126 in `C:\CE_PLAN\decisions\2026-10-29_TIM_ANSWERS.md`: a new Settings tab called "Switches" lists every new on/off switch and the five Pit Schedule tuning figures in plain English. A long list may scroll. No collapsed sections. Until it exists, those values are file-only and ON.

## What the drafter sees
1. A new tab named **Switches** in the Civil Settings window (CE Settings).
2. A plain-English list, one line per switch, each with a tick box that is ticked by default. No code names on screen. Each line says what it does in AutoCAD terms, for example "Pit Schedule rows grow for a long remark".
3. Below the switches, a small list of five numbers with a box each: 0.75 (how much of the text height each character counts when CE estimates the lines), 1.2 (the closest line spacing, times the text height), and 50, 20 and 25 (the Pit Schedule row-growth limits).
4. A list longer than the window scrolls. Nothing is folded away.
5. OK saves, Cancel and Esc leave everything unchanged. Values are kept after reopening.

## Which values go on it (file-only today, found in QUESTIONS items 75 and 75a)
1. pipe.mismatchBoxSkipsOwnSuggestion
2. Excel.UseAutoCadLoadedClosedXml
3. linking.wsudExportSkipsSampleSite
4. updatesButtonOpensOwnScreen
5. detention.councilTcForStorage
6. pipe.largePipeRedesignReadsMinFall
7. linking.scheduleRowGrowsForLongRemark
8. linking.scheduleDoubleRowHidesDivider
9. linking.inspectorReadsSavedRecordWhenNotLoaded (#1880)
10. The five Pit Schedule figures from #1881 above.
11. "more coming": every new switch from the Civil jobs queued on 31 Oct (grade warning, steeper-pipe warning, Recall Last, one cover measure) and any switch added later. The list must be built so a new switch is added in one place.

Check the real names and current defaults in `Modules/Drainage/Models/UserSettings.cs` before writing a line on screen. If a name above does not exist, say so; do not invent one.

## Hard limits
1. The Settings page is exactly at its height limit (two tick boxes broke 10 page-fit tests earlier), so this must be a NEW tab, not extra rows on an existing one.
2. Settings engine change: under the re-test rule a Settings-engine change forces a FULL re-test. Say plainly in the PR whether the settings engine itself changes. A new tab that only reads and writes existing keys is a window change plus the Settings smoke set.
3. CE_SHARED must not change.
4. Nothing hard-coded: the tab reads and writes the same Settings keys the commands already read.
5. Never overwrite a saved value; a switch the drafter unticked stays unticked.
6. Plain English only on screen (RULES 2.4 and the plain-English UI rule). Gold accent on dark, CE deep blue #1E5AA8 on light.
7. Draft PR only, base `origin/claude/rel-20261102a`. Nothing is closed or merged.

## Proof Tim wants
1. A screenshot of the tab with all lines ticked.
2. Untick one switch, OK, close, reopen: it stays unticked, and the command that uses it behaves the old way.
3. Cancel and Esc: nothing changes.
4. The Settings smoke S1 result (Settings file unchanged after open and Cancel; a save writes only the changed keys).

## Not tested / open
Nothing is built. The exact list of switches is not final until the Civil jobs w1 to w5 land.
