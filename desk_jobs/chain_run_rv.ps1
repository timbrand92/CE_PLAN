# CE 05 chain (Rule 20): rv18 then rv19 (Opus pre-reviews on Team), one at a time. Same gating as chain_run_t3.ps1.
$d = 'C:\CE_PLAN\desk_jobs'
function Wait-End([int]$p) { while ($p -gt 0 -and (Get-Process -Id $p -ErrorAction SilentlyContinue)) { Start-Sleep -Seconds 30 } }
function Start-Lane([string]$script) {
  $line = (& "$d\team_usage.ps1" 2>&1 | Out-String)
  $wk = if ($line -match '7-day (\d+)%') { [int]$Matches[1] } else { 99 }
  $free = (Get-PSDrive C).Free / 1GB
  if ($wk -ge 30 -or $free -lt 27) { "$(Get-Date) STOP before $script : Team week $wk, C: free $([math]::Round($free,1)) GB" | Set-Content "$d\CHAIN_Q_STOPPED.txt"; return 0 }
  $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine="pwsh -NoProfile -WindowStyle Hidden -File $d\$script"; CurrentDirectory=$d}
  "$(Get-Date) launched $script pid $($r.ProcessId) (Team week $wk, C: $([math]::Round($free,1)) GB)" | Add-Content "$d\CHAIN_Q_LOG.txt"
  return [int]$r.ProcessId
}
foreach ($s in 'chain_fix_g176.ps1', 'chain_fix_g177.ps1') { $p = Start-Lane $s; if ($p -eq 0) { exit }; Wait-End $p }
"$(Get-Date) rv chain finished" | Add-Content "$d\CHAIN_Q_LOG.txt"
