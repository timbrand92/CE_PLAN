# Never-empty Team feeder (CE 05, Mon 2 Nov 2026, CE 00 Rule 20).
# Every 60 s: if no headless Team job ('claude -p') has run for 3 minutes, start the next job file from desk_jobs\team_queue (name order).
# One job at a time. Guards: Team 7-day under 40, C: free over 27 GB. If a guard fails: write CHAIN_Q_STOPPED.txt and wait (re-checks every 5 min; clears the file when it recovers).
# Job file: first line '# MODEL: sonnet' or '# MODEL: opus'. Drop files in the folder; started files move to team_queue_started\.
# Stop: create desk_jobs\STOP_FEEDER.flag. Log: desk_jobs\team_queue.log. Start with WMI Win32_Process Create, never Start-Process.
$d = 'C:\CE_PLAN\desk_jobs'
$q = "$d\team_queue"; $st = "$d\team_queue_started"
New-Item -ItemType Directory -Force $q, $st | Out-Null
function Log($t) { Add-Content "$d\team_queue.log" ("{0} FEEDER {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function Team-Busy { @(Get-CimInstance Win32_Process | Where-Object { ($_.Name -eq 'claude.exe' -and $_.CommandLine -match ' -p ') -or ($_.Name -eq 'pwsh.exe' -and $_.CommandLine -match '-File .*(chain_fix_|chain_run_)') }).Count -gt 0 }
Log 'feeder started'
$idle = 3
while ($true) {
  if (Test-Path "$d\STOP_FEEDER.flag") { Log 'stop flag: exiting'; break }
  try {
    if (Team-Busy) { $idle = 0 } else { $idle++ }
    if ($idle -ge 3) {
      $next = Get-ChildItem $q -Filter *.txt -ErrorAction SilentlyContinue | Sort-Object Name | Select-Object -First 1
      if ($next) {
        $line = (& "$d\team_usage.ps1" 2>&1 | Out-String)
        $wk = if ($line -match '7-day (\d+)%') { [int]$Matches[1] } else { 99 }
        $free = (Get-PSDrive C).Free / 1GB
        if ($wk -ge 40 -or $free -lt 27) {
          Set-Content "$d\CHAIN_Q_STOPPED.txt" "$(Get-Date) feeder waiting before $($next.Name): Team week $wk, C: free $([math]::Round($free,1)) GB"
          Log "guard stop: Team week $wk, C: $([math]::Round($free,1)) GB"
          Start-Sleep -Seconds 240
        } else {
          Remove-Item "$d\CHAIN_Q_STOPPED.txt" -ErrorAction SilentlyContinue
          $key = ($next.BaseName -replace '[^A-Za-z0-9_]', '_'); if ($key.Length -gt 24) { $key = $key.Substring(0, 24) }
          $dest = Join-Path $st $next.Name
          Move-Item $next.FullName $dest -Force
          $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ CommandLine = "pwsh -NoProfile -WindowStyle Hidden -File $d\chain_fix_generic.ps1 -JobFile `"$dest`" -Key $key"; CurrentDirectory = $d }
          Log "launched $($next.Name) pid $($r.ProcessId) (Team week $wk, C: $([math]::Round($free,1)) GB)"
          $idle = 0
          Start-Sleep -Seconds 45
        }
      } else {
        Set-Content "$d\CHAIN_Q_STOPPED.txt" "$(Get-Date) feeder: team_queue is EMPTY, drop job files in desk_jobs\team_queue"
        Log 'queue empty'
        Start-Sleep -Seconds 300
      }
    }
  } catch { Log ("error: " + $_.Exception.Message) }
  Start-Sleep -Seconds 60
}
