# Desk 23 Oct 2026: make chain_install_c61_s42.ps1 kill any old conveyor before restarting it (no duplicate conveyors).
$f = 'C:\CE_PLAN\desk_jobs\chain_install_c61_s42.ps1'
$t = [IO.File]::ReadAllText($f)
$marker = 'Start-Process pwsh -WindowStyle Hidden -ArgumentList "-NoProfile -File $d\codex_conveyor.ps1"'
$kill = 'Get-CimInstance Win32_Process | Where-Object { $_.Name -match ''pwsh'' -and $_.CommandLine -match ''codex_conveyor'' } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch { } }'
if ($t.Contains($marker) -and -not $t.Contains('Stop-Process -Id $_.ProcessId')) {
  $t = $t.Replace($marker, $kill + "`r`n" + $marker)
  [void][scriptblock]::Create($t)
  [IO.File]::WriteAllText($f, $t, (New-Object Text.UTF8Encoding($false)))
  'patched'
} else { 'marker missing or already patched' }
