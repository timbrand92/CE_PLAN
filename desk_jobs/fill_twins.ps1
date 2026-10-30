$env:CE_RUNNER_TIM_AWAY = '1'
& pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile 'C:\ce-fx\retest\spec_fill_twins.txt' -StopFirst '2026-10-31 05:00' -StopAll '2026-10-31 05:30' -Fresh
