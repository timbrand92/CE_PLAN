# CE 05 chain (Rule 20): wait for the rv chain watcher, then tr1 (draft backlog triage, Sonnet), then Opus pre-review groups r1..rN generated from its plan.
param([int]$WaitPid = 0)
$d = 'C:\CE_PLAN\desk_jobs'
$enc = New-Object System.Text.UTF8Encoding($false)
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
function New-ReviewJobs {
  $plan = 'C:\CE_PLAN\areas\DRAFT_BACKLOG_TRIAGE_01NOV.md'
  if (-not (Test-Path $plan)) { return @() }
  $g89 = [System.IO.File]::ReadAllText("$d\chain_fix_g89.ps1", $enc)
  $tpl = [System.IO.File]::ReadAllText("$d\team_fix_rv19.txt", $enc)
  $m = [System.IO.File]::ReadAllLines($plan, $enc)
  $a = [array]::FindIndex($m, [Predicate[string]]{ param($x) $x -like '## A. THE GROUPS*' })
  $b = [array]::FindIndex($m, [Predicate[string]]{ param($x) $x -like '## B. ORDER*' })
  if ($a -lt 0 -or $b -lt 0) { return @() }
  $starts = @(); for ($i = $a; $i -lt $b; $i++) { if ($m[$i] -match '^\d+\. \*\*r\d+:') { $starts += $i } }
  $scripts = @()
  for ($n = 0; $n -lt [math]::Min(8, $starts.Count); $n++) {
    $k = "rv$(20 + $n)"; $lane = 179 + $n
    $end = if ($n + 1 -lt $starts.Count) { $starts[$n+1] - 1 } else { $b - 1 }
    $prs = ($m[$starts[$n]..$end] | Where-Object { $_.Trim() -ne '' }) -join ' '
    $out = "OPUS_PREREVIEW_BACKLOG_R$($n+1)_01NOV.md"
    $t = [regex]::Replace($tpl, '(?s)^PRE-REVIEW BRIEF: .*? Opus, Team, read-only\.', { param($mm) "PRE-REVIEW BRIEF: Backlog group (from areas\DRAFT_BACKLOG_TRIAGE_01NOV.md): $prs Opus, Team, read-only." })
    $t = $t.Replace('OPUS_PREREVIEW_1984_1988_GROUP_01NOV.md', $out).Replace('BUGFIX_*_REPORT_01NOV.md named below', 'BUGFIX_*_REPORT_*.md if one is named below or findable; if none exists say so and judge from the diff and the carpark entry')
    [System.IO.File]::WriteAllText("$d\team_fix_$k.txt", $t, $enc)
    $s = $g89.Replace('s10', $k).Replace('chain_fix_g89', "chain_fix_g$lane").Replace('C:\ce-scratch\', 'C:\CE_WORK\scratch\')
    $s = $s.Replace("`$d = 'C:\CE_PLAN\desk_jobs'", "`$d = 'C:\CE_PLAN\desk_jobs'`nforeach (`$p in 'struc','logs','tmp') { New-Item -ItemType Directory -Force (""C:\CE_WORK\scratch\$k\"" + `$p) | Out-Null }")
    $s = $s.Replace("`$k -eq 'c' -or `$k -eq 'h'", "`$k -eq 'c' -or `$k -eq 'h' -or `$k -like 'rv*'")
    [System.IO.File]::WriteAllText("$d\chain_fix_g$lane.ps1", $s, $enc)
    $scripts += "chain_fix_g$lane.ps1"
  }
  "$(Get-Date) generated $($scripts.Count) backlog review jobs" | Add-Content "$d\CHAIN_Q_LOG.txt"
  return $scripts
}
Wait-End $WaitPid
$p = Start-Lane 'chain_fix_g178.ps1'; if ($p -eq 0) { exit }; Wait-End $p
foreach ($s in (New-ReviewJobs)) { $p = Start-Lane $s; if ($p -eq 0) { exit }; Wait-End $p }
"$(Get-Date) tr chain finished" | Add-Content "$d\CHAIN_Q_LOG.txt"
