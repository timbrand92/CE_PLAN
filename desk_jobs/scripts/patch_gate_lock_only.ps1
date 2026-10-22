# Desk 23 Oct 2026 (Tim: "need to find a way": Codex AutoCAD testing must run as constantly as possible): the Codex gate and the conveyor clean-up refused to run whenever ANY tester_run job existed, even while that job was only writing code; verifyV9b and verifyW1 never started (gate timed out after 4 h). New rule: only a live AutoCAD process, a live lock or a settings guard blocks a Codex run; the v2 lock is the one mutual exclusion for every AutoCAD user (driver v3 waits for it up to 60 minutes).
$l = 'C:\CE_PLAN\desk_jobs\launch_codex_retry.ps1'
$t = [IO.File]::ReadAllText($l)
$old = "  if (Get-CimInstance Win32_Process -Filter `"Name='cmd.exe'`" | Where-Object { `$_.CommandLine -match 'tester_run|evidence_job' }) { return `$false }"
if ($t.Contains($old)) { $t = $t.Replace($old, "  # 23 Oct 2026: job presence no longer blocks (lock, AutoCAD process and settings guard do)"); [IO.File]::WriteAllText($l, $t, (New-Object Text.UTF8Encoding($false))); [void][scriptblock]::Create($t); 'launcher gate patched' } else { 'launcher gate line not found' }
$c = 'C:\CE_PLAN\desk_jobs\codex_conveyor.ps1'
$u = [IO.File]::ReadAllText($c)
$oldc = "  if (Get-CimInstance Win32_Process -Filter `"Name='cmd.exe'`" | Where-Object { `$_.CommandLine -match 'tester_run|evidence_job' }) { Log 'a robot/driver job owns AutoCAD: cleanup skipped'; return `$true }"
$newc = "  `$lk = 'C:\ce_rc_drv\ACAD_LOCK.json'; if (Test-Path `$lk) { try { `$lj = Get-Content `$lk -Raw | ConvertFrom-Json; if ([double]`$lj.expires -gt [DateTimeOffset]::UtcNow.ToUnixTimeSeconds() -and `$lj.who -notmatch '^Codex') { Log ('lock held by ' + `$lj.who + ': cleanup skipped'); return `$true } } catch { } }"
if ($u.Contains($oldc)) { $u = $u.Replace($oldc, $newc); [IO.File]::WriteAllText($c, $u, (New-Object Text.UTF8Encoding($false))); [void][scriptblock]::Create($u); 'conveyor cleanup patched' } else { 'conveyor cleanup line not found' }
