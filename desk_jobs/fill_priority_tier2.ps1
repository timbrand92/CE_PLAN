# CE 02 Fri 30 Oct 2026: priority tier 2 filler (pack A and the rest of pack B), after the C-77 full set. No model tokens.
$env:CE_RUNNER_TIM_AWAY = '1'
& pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile 'C:\ce-fx\retest\spec_priority_tier2.txt' -StopFirst '2026-10-31 05:00' -StopAll '2026-10-31 05:30' -Fresh
