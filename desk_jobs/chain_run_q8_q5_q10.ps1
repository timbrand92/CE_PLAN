# CE 05 chain: waits for q8 (pid given), then launches q5 (g164), then q10 (g169), one Team job at a time.
# Before each launch: Team 7-day under 30 and C: free over 27 GB, else stop and write the reason to CHAIN_Q_STOPPED.txt.
param([int]$WaitPid = 0)
$d = 'C:\CE_PLAN\desk_jobs'
function Wait-Job-End([int]$p) { while ($p -gt 0 -and (Get-Process -Id $p -ErrorAction SilentlyContinue)) { Start-Sleep -Seconds 30 } }
function Start-Lane([string]$script) {
  $line = (& "$d\team_usage.ps1" 2>&1 | Out-String)
  $wk = if ($line -match '7-day (\d+)%') { [int]$Matches[1] } else { 99 }
  $free = (Get-PSDrive C).Free / 1GB
  if ($wk -ge 30 -or $free -lt 27) { "$(Get-Date) STOP before $script : Team week $wk, C: free $([math]::Round($free,1)) GB" | Set-Content "$d\CHAIN_Q_STOPPED.txt"; return 0 }
  $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine="pwsh -NoProfile -WindowStyle Hidden -File $d\$script"; CurrentDirectory=$d}
  "$(Get-Date) launched $script pid $($r.ProcessId) (Team week $wk, C: $([math]::Round($free,1)) GB)" | Add-Content "$d\CHAIN_Q_LOG.txt"
  return [int]$r.ProcessId
}
Wait-Job-End $WaitPid
$p = Start-Lane 'chain_fix_g164.ps1'
if ($p -eq 0) { exit }
Wait-Job-End $p
$p = Start-Lane 'chain_fix_g169.ps1'
