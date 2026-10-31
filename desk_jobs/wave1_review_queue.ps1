# CE 02 Sat 31 Oct 2026 14:58: launches the wave 1 Team reviewers (hidden consoles) when fewer than 3 Team jobs of mine run. Order RP, RE, RS; RS waits until the T2 writer report exists. Pause with PAUSE_WAVE1.flag. Not a build script.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\wave1_review_queue.log"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
L 'review queue started'
foreach ($k in 'RP', 'RE', 'RS') {
  while ($true) {
    $running = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'cmd.exe' -and $_.CommandLine -match 'team_wave1(rev)?_[A-Z0-9]+\.txt' }).Count
    $ready = $true; if ($k -eq 'RS' -and -not (Test-Path 'C:\CE_PLAN\areas\WAVE1_WRITING_T2_REPORT.md')) { $ready = $false }
    if ($ready -and -not (Test-Path "$d\PAUSE_WAVE1.flag") -and $running -lt 3) { break }
    Start-Sleep 30
  }
  $cmd = 'cmd.exe /c set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + "$d\team_wave1rev_$k.txt" + '" > "' + "$d\team_wave1rev_$k.log" + '" 2>&1'
  $si = New-CimInstance -ClassName Win32_ProcessStartup -ClientOnly -Property @{ ShowWindow = [uint16]0 }
  $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ ProcessStartupInformation = $si; CommandLine = $cmd; CurrentDirectory = 'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\desk-new-chat-start-prompt-a377a5' }
  L "launched $k pid $($r.ProcessId) rc $($r.ReturnValue) (running before: $running)"
  Start-Sleep 45
}
L 'all reviewers launched; queue ends'
