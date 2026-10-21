# Desk (plan/03) install of Structural 1.0.120 (train S-40, candidate s1038). Adapted from the controller's proven install_c64 script; verifies by SHA256 of every candidate file against the live file.
$ErrorActionPreference = 'Stop'
$ap = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins'
$ts = Get-Date -Format 'yyyyMMdd-HHmmss'
$log = 'C:\ce_rc_scratch\install_s40_desk.log'
function L($t) { $line = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + ' ' + $t; Add-Content -LiteralPath $log -Value $line; Write-Output $line }
function Busy {
  $a = @(Get-Process acad, accoreconsole -ErrorAction SilentlyContinue).Count
  $c = @(Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'queue3|codex\.js|codex exec' -and $_.CommandLine -match 'queue3.*verifyW|-C\s+\W?C:.Lisp Files._TEST_COPIES' -and $_.CommandLine -notmatch 'Get-CimInstance' }).Count
  return @($a, $c)
}
$r = Busy; if ($r[0] -ne 0 -or $r[1] -ne 0) { L "ABORT: AutoCAD $($r[0]) / Codex $($r[1]) running"; exit 5 }
Start-Sleep 60
$r = Busy; if ($r[0] -ne 0 -or $r[1] -ne 0) { L "ABORT on second check: AutoCAD $($r[0]) / Codex $($r[1])"; exit 5 }
$cand = 'C:\ce_rc_scratch\s1038'
$jobs = @(@{ n = 'CE_STRUC_SUITE'; want = '1.0.120' })
foreach ($j in $jobs) {
  if (-not (Test-Path -LiteralPath (Join-Path $ap ($j.n + '.bundle')))) { L ('ABORT: live bundle missing ' + $j.n); exit 8 }
  if (-not (Test-Path -LiteralPath (Join-Path $cand ($j.n + '.bundle')))) { L ('ABORT: candidate missing ' + $j.n); exit 7 }
}
# Tim's settings files copied aside (read-only copies) and hashed
$settings = 'C:\ce_rc_scratch\settings_pre_s40'
New-Item -ItemType Directory -Force $settings | Out-Null
$sf = @("$env:APPDATA\CE_STRUC_SUITE\CS_Settings.json", "$env:APPDATA\TIM_CE_CADTOOLS\CD_Settings.json", "$env:APPDATA\TIM_CE_CADTOOLS\CS_Settings.json")
$before = @{}
foreach ($p in $sf) { if (Test-Path $p) { $before[$p] = (Get-FileHash $p -Algorithm SHA256).Hash; Copy-Item -LiteralPath $p -Destination (Join-Path $settings (($p -replace '[:\\]', '_'))) -Force } }
L 'settings copied aside and hashed'
$prior = '063a6351'
foreach ($j in $jobs) {
  $n = $j.n; $live = Join-Path $ap ($n + '.bundle'); $new = Join-Path $cand ($n + '.bundle'); $bak = $n + '_PRE_' + $prior + '_' + $ts + '.backup'
  Rename-Item -LiteralPath $live -NewName $bak
  L ('renamed ' + $n + ' -> ' + $bak)
  & robocopy $new $live /E /NFL /NDL /NJH /NJS /NP | Out-Null
  if ($LASTEXITCODE -ge 8) { L ('ROBOCOPY FAILED ' + $n + ' code ' + $LASTEXITCODE + ': restoring'); Remove-Item -LiteralPath $live -Recurse -Force -ErrorAction SilentlyContinue; Rename-Item -LiteralPath (Join-Path $ap $bak) -NewName ($n + '.bundle'); exit 9 }
  L ('copied ' + $n + ' (robocopy code ' + $LASTEXITCODE + ')')
}
$ok = $true
foreach ($j in $jobs) {
  $n = $j.n; $live = Join-Path $ap ($n + '.bundle'); $new = Join-Path $cand ($n + '.bundle')
  $cf = Get-ChildItem -LiteralPath $new -Recurse -File; $lf = Get-ChildItem -LiteralPath $live -Recurse -File
  $bad = 0
  foreach ($f in $cf) {
    $rel = $f.FullName.Substring($new.Length); $t = $live + $rel
    if (-not (Test-Path -LiteralPath $t)) { $bad++; continue }
    if ((Get-Item -LiteralPath $t).Length -ne $f.Length) { $bad++; continue }
    if ((Get-FileHash -LiteralPath $t -Algorithm SHA256).Hash -ne (Get-FileHash -LiteralPath $f.FullName -Algorithm SHA256).Hash) { $bad++ }
  }
  $extra = $lf.Count - $cf.Count
  L ("$n : candidate files $($cf.Count), live files $($lf.Count), bad $bad, extra $extra")
  if ($bad -ne 0 -or $extra -ne 0) { $ok = $false }
  foreach ($lane in 'Legacy', 'Net8', 'Modern') {
    $dll = Get-ChildItem (Join-Path $live ('Contents\Win64\' + $lane)) -Filter ($n + '.dll') -ErrorAction SilentlyContinue | Select-Object -First 1
    if (-not $dll) { L ($n + ' ' + $lane + ' DLL MISSING'); $ok = $false; continue }
    $pv = $dll.VersionInfo.ProductVersion
    if (-not $pv.StartsWith($j.want)) { L ($n + ' ' + $lane + ' WRONG VERSION ' + $pv); $ok = $false } else { L ($n + ' ' + $lane + ' ' + $pv) }
  }
}
foreach ($p in $sf) { if ($before.ContainsKey($p)) { $h = (Get-FileHash $p -Algorithm SHA256).Hash; if ($h -ne $before[$p]) { L ('SETTINGS CHANGED: ' + $p); $ok = $false } else { L ('settings unchanged: ' + (Split-Path $p -Leaf)) } } }
if ($ok) { L 'INSTALL VERIFIED: Structural 1.0.120 installed, every file matches the candidate, settings unchanged' } else { L 'INSTALL PROBLEM: see above' }
