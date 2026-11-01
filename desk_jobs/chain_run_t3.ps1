# CE 05 chain v2 (Rule 20): wait for q8, then pl3 (tranche 3 planner), q5, q10, then tranche 3 batches t1..tN, ONE Team job at a time.
# Before each launch: Team 7-day under 30 and C: free over 27 GB, else stop, write CHAIN_Q_STOPPED.txt and exit.
param([int]$WaitPid = 0, [int]$FirstB = 158)
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
function New-TrancheJobs {
  $g89 = [System.IO.File]::ReadAllText("$d\chain_fix_g89.ps1", $enc)
  $l = [System.IO.File]::ReadAllLines('C:\CE_PLAN\areas\NEXT_TRANCHE2_01NOV.md', $enc)
  $ci = [array]::FindIndex($l, [Predicate[string]]{ param($x) $x -like '## COMMON BLOCK*' })
  $ai = [array]::FindIndex($l, [Predicate[string]]{ param($x) $x -like '## A. THE BATCHES*' })
  $common = ($l[($ci+4)..($ai-1)] | Where-Object { $_.Trim() -ne '' })
  $m = [System.IO.File]::ReadAllLines('C:\CE_PLAN\areas\NEXT_TRANCHE3_01NOV.md', $enc)
  $a = [array]::FindIndex($m, [Predicate[string]]{ param($x) $x -like '## A. THE BATCHES*' })
  $b = [array]::FindIndex($m, [Predicate[string]]{ param($x) $x -like '## B. ORDER*' })
  $starts = @(); for ($i = $a; $i -lt $b; $i++) { if ($m[$i] -match '^\d+\. \*\*t\d+:') { $starts += $i } }
  $scripts = @()
  for ($n = 0; $n -lt $starts.Count; $n++) {
    $k = "t$($n+1)"; $lane = 173 + $n; $bnum = "B-$($FirstB + $n)"
    $end = if ($n + 1 -lt $starts.Count) { $starts[$n+1] - 1 } else { $b - 1 }
    $batch = ($m[$starts[$n]..$end] | Where-Object { $_.Trim() -ne '' }) -join "`n"
    $head = "YOUR KEY: $k. YOUR BUILD NUMBER: $bnum (provisional from CE 05, use it at the start of every PR title; CE 01 may renumber). Written by CE 05 from C:\CE_PLAN\areas\NEXT_TRANCHE3_01NOV.md. Replace <key> below with $k. Read the COMMON RULES, then THE BATCH (its THE TASK paragraph is your job). Tranche 3 batch $k."
    $txt = $head + "`n`nCOMMON RULES:`n" + (($common -join "`n").Replace('<key>', $k)) + "`n`nTHE BATCH:`n" + $batch.Replace('<key>', $k) + "`n"
    [System.IO.File]::WriteAllText("$d\team_fix_$k.txt", $txt, $enc)
    $s = $g89.Replace('s10', $k).Replace('chain_fix_g89', "chain_fix_g$lane").Replace('C:\ce-scratch\', 'C:\CE_WORK\scratch\')
    $s = $s.Replace("`$d = 'C:\CE_PLAN\desk_jobs'", "`$d = 'C:\CE_PLAN\desk_jobs'`nforeach (`$p in 'struc','logs','tmp') { New-Item -ItemType Directory -Force (""C:\CE_WORK\scratch\$k\"" + `$p) | Out-Null }")
    [System.IO.File]::WriteAllText("$d\chain_fix_g$lane.ps1", $s, $enc)
    $scripts += "chain_fix_g$lane.ps1"
  }
  "$(Get-Date) generated $($scripts.Count) tranche 3 jobs from B-$FirstB" | Add-Content "$d\CHAIN_Q_LOG.txt"
  return $scripts
}
Wait-End $WaitPid
$p = Start-Lane 'chain_fix_g172.ps1'; if ($p -eq 0) { exit }; Wait-End $p
$t3 = @(); if (Test-Path 'C:\CE_PLAN\areas\NEXT_TRANCHE3_01NOV.md') { $t3 = New-TrancheJobs }
foreach ($s in @('chain_fix_g164.ps1', 'chain_fix_g169.ps1') + $t3) {
  $p = Start-Lane $s; if ($p -eq 0) { exit }; Wait-End $p
}
"$(Get-Date) chain finished" | Add-Content "$d\CHAIN_Q_LOG.txt"
