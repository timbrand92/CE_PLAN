# CE 01 3 Nov 2026: install C-79b2 (Civil 3.0.91 / Manager 1.1.89 re-stamped, 16 PRs, candidate c1077) when its payload report is clean, the C-79b1 line is installed, AutoCAD is free AND the machine has had 10 quiet minutes (away-gate ruling of 30 Oct). Structural is not in this train. NOT STARTED by the job that wrote it: CE 01 starts it only after the C-79b1 install is clean, the 24 h gap and CE 02 has named the pause time and given 10 minutes warning.
# Waits for the payload report PAYLOAD_C1077_REPORT.md, then waits until the C-79b1 install chain has finished and the installed Civil line reads 3.0.90, then holds the Codex AutoCAD lane (STOP_CODEX.flag), waits for AutoCAD, the lock and every Codex AutoCAD job to be clear, claims the lock and runs the install script.
$d = 'C:\CE_PLAN\desk_jobs'
$origHold = $null; if (Test-Path "$d\STOP_CODEX.flag") { $origHold = Get-Content "$d\STOP_CODEX.flag" -Raw }
function Log($t) { Add-Content "$d\chain_install_c79b2.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$rep = 'C:\Lisp Files\_TEST_COPIES_20260923\PAYLOAD_C1077_REPORT.md'
$w = 0
while (-not (Test-Path $rep)) { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }; Start-Sleep 120; $w++; if ($w -gt 240) { Log 'no payload report after 8 h: stop for the desk'; exit } }
Start-Sleep 30
$rc = Get-Content $rep -Raw
if ($rc -notmatch 'verified \d+, bad 0, extra 0' -or ([regex]::Matches($rc, 'verified \d+, bad 0, extra 0')).Count -lt 2) { Log 'payload report not clean: stop for the desk'; exit }
# C-79b2 sits on C-79b1: never install it before the C-79b1 line is in place.
$w = 0
while ($true) {
  $c77run = [bool](Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_install_c79b1\.ps1' -and $_.Name -match 'pwsh' })
  $p = Join-Path $env:APPDATA 'Autodesk\ApplicationPlugins\CE_CVL_SUITE.bundle\Contents\Win64\Legacy\CE_CVL_SUITE.dll'
  $pv = ''
  if (Test-Path -LiteralPath $p) { $pv = (Get-Item -LiteralPath $p).VersionInfo.ProductVersion }
  if ((-not $c77run) -and $pv.StartsWith('3.0.90')) { break }
  if ($w -eq 0) { Log ('waiting for the C-79b1 line: installed Civil reads [' + $pv + '], C-79b1 install chain running ' + $c77run) }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  Start-Sleep 120; $w++
  if ($w -gt 240) { Log 'C-79b1 line not installed after 8 h: stop for the desk'; exit }
}
if (-not $origHold) { Set-Content "$d\STOP_CODEX.flag" 'install hold c79b2' }
Log 'payload report clean and C-79b1 installed; Codex lane held (STOP_CODEX.flag); waiting for AutoCAD, the lock and every Codex AutoCAD job to be clear'
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public static class IdleProbeC79a {
  [StructLayout(LayoutKind.Sequential)] public struct LII { public uint cbSize; public uint dwTime; }
  [DllImport("user32.dll")] public static extern bool GetLastInputInfo(ref LII p);
  public static double IdleMinutes() { LII l = new LII(); l.cbSize = (uint)Marshal.SizeOf(typeof(LII)); GetLastInputInfo(ref l); return ((uint)Environment.TickCount - l.dwTime) / 60000.0; }
}
"@
$lk = 'C:\ce_rc_drv\ACAD_LOCK.json'
$w = 0; $mine = $false
while ($true) {
  $live = $false
  if (Test-Path $lk) { try { $j = Get-Content $lk -Raw | ConvertFrom-Json; if ([double]$j.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()) { $live = $true } } catch { $live = $true } }
  $acad = [bool](Get-Process acad, accoreconsole -ErrorAction SilentlyContinue)
  $guard = Test-Path 'C:\Lisp Files\_ACAD_DRIVER\settings_guard.json'
  $cl = [bool](Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match "codex exec" -and $_.CommandLine -match "_TEST_COPIES" -and $_.CommandLine -notmatch "Get-CimInstance" })
  $quiet = ([IdleProbeC79a]::IdleMinutes() -ge 15)
  if (-not $live -and -not $acad -and -not $guard -and -not $cl -and $quiet) {
    $now = [DateTimeOffset]::UtcNow.ToUnixTimeSeconds()
    $rec = [ordered]@{ who = 'Desk-install-c79b2'; pid = $PID; acad_pid = 0; acad_start = 0; since = $now; since_text = (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'); refreshed = $now; note = 'claimed by the C-79b2 install chain'; expires = ($now + 900); expires_text = (Get-Date).AddMinutes(15).ToString('yyyy-MM-dd HH:mm:ss') }
    ($rec | ConvertTo-Json) | Set-Content $lk -Encoding UTF8
    Start-Sleep 20
    $chk = $null; try { $chk = Get-Content $lk -Raw | ConvertFrom-Json } catch { }
    if ($chk -and $chk.who -eq 'Desk-install-c79b2' -and -not (Get-Process acad -ErrorAction SilentlyContinue)) { $mine = $true; break }
    Log 'lost the lock race: waiting again'
  }
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; if (-not $origHold) { Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue }; exit }
  Start-Sleep 10; $w++; if ($w -gt 2880) { Log 'AutoCAD busy for 8 h: stop for the desk'; if (-not $origHold) { Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue }; exit }
}
Log 'AutoCAD free and lock claimed: installing C-79b2'
$o1 = & pwsh -NoProfile -File "$d\scripts\desk_install_c79b2.ps1" 2>&1 | Out-String
Log ($o1.Trim().Split("`n")[-1])
if ($o1 -notmatch 'INSTALL VERIFIED') { Log 'C-79b2 install not verified: stop for the desk (Codex hold lifted below)' }
try { $chk = Get-Content $lk -Raw | ConvertFrom-Json; if ($chk.who -eq 'Desk-install-c79b2') { Remove-Item $lk -Force } } catch { }
if (-not $origHold) { Remove-Item "$d\STOP_CODEX.flag" -ErrorAction SilentlyContinue }
if (-not $origHold) { Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'pwsh' -and $_.CommandLine -match 'codex_conveyor' } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force } catch { } } }
Log 'lock released; Codex hold lifted; the supervisor restarts the conveyor'
