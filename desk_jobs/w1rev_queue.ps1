# CE 02 Sun 1 Nov 2026 (CE 00 instruction 07:00): four read-only Opus review jobs on Team for the 56 PASS-UNREVIEWED main cases of the C-78 full re-test, two at a time, after the Team 5-hour reset at 08:10. Not a build script. Pause: C:\CE_PLAN\desk_jobs\PAUSE_W1REV.flag. Log: w1rev_queue.log (job start and end times = review minutes).
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\w1rev_queue.log"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Mine { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'cmd.exe' -and $_.CommandLine -match 'team_w1rev_[1-4]\.txt' }).Count }
function AllTeam { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'cmd.exe' -and $_.CommandLine -match '\.claude-team' -and $_.CommandLine -match 'claude -p' }).Count }
function Alive($k) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'cmd.exe' -and $_.CommandLine -match "team_w1rev_$k\.txt" }).Count -gt 0 }
function Launch($k) {
  while ($true) { if (-not (Test-Path "$d\PAUSE_W1REV.flag") -and (Mine) -lt 2 -and (AllTeam) -lt 3) { break }; Start-Sleep 30 }
  $cmd = 'cmd.exe /c set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + "$d\team_w1rev_$k.txt" + '" > "' + "$d\team_w1rev_$k.log" + '" 2>&1'
  $si = New-CimInstance -ClassName Win32_ProcessStartup -ClientOnly -Property @{ ShowWindow = [uint16]0 }
  $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ ProcessStartupInformation = $si; CommandLine = $cmd; CurrentDirectory = 'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\desk-new-chat-start-prompt-a377a5' }
  L "launched review $k pid $($r.ProcessId) rc $($r.ReturnValue)"
  Start-Sleep 45
}
L 'queue started; starts at once'
foreach ($k in 1, 2) { Launch $k }
foreach ($k in 1, 2) { while (Alive $k) { Start-Sleep 30 }; L "review $k ended" }
L 'all four reviews ended; queue ends'
