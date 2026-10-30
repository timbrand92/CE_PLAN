# CE 02 Fri 30 Oct 2026: AutoCAD filler (top-40 pack A, N45-N54). Runs C:\ce-fx\retest\spec_next40_a.txt through chain4 (30 s all-clear wait, honours ROBOT_STOP_AT.txt). Started by acad_watchdog.ps1 from FILL_SCRIPTS.txt. No model tokens.
$env:CE_RUNNER_TIM_AWAY = '1'
& pwsh -NoProfile -File 'C:\ce-fx\c75regrade3\chain4.ps1' -SpecFile 'C:\ce-fx\retest\spec_next40_a.txt' -StopFirst '2026-10-31 05:00' -StopAll '2026-10-31 05:30' -Fresh
