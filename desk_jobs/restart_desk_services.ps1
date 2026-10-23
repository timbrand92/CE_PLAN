# Desk 23 Oct 2026: run this after the Claude app has been restarted (or the PC rebooted) to bring the desk machinery back. Safe to run any time: it starts only what is missing. Usage: pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\restart_desk_services.ps1
$d = 'C:\CE_PLAN\desk_jobs'
function Alive($pat) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match $pat }).Count }
$started = @()
foreach ($s in 'acad_janitor', 'disk_guard', 'codex_supervisor', 'log_outcomes_loop') {
  if ((Alive "$s\.ps1") -eq 0) { $null = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = "pwsh.exe -NoProfile -WindowStyle Hidden -File $d\$s.ps1"; CurrentDirectory = $d }; $started += $s }
}
# the supervisor starts the AutoCAD conveyor itself in SPEND mode (it waits 2 minutes)
"started: " + ($(if ($started) { $started -join ', ' } else { 'nothing (all alive)' }))
"mode: " + (Get-Content "$d\CODEX_MODE.txt" -TotalCount 1)
"acad: " + @(Get-Process acad -ErrorAction SilentlyContinue).Count + "; settings guard: " + (Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json') + "; C: free GB: " + [math]::Round((Get-PSDrive C).Free / 1GB, 1)
"claude -p jobs alive: " + @(Get-CimInstance Win32_Process -Filter "Name='cmd.exe'" | Where-Object { $_.CommandLine -match 'claude -p' }).Count + " (a job that died with the app has no cmd process: check chain_*.log tails and restart that step by hand)"
