# CE 02 Sat 31 Oct 2026 14:15: launches the wave 1 Team writers one after another so that at most 3 run at once (CE 00 cap). Not a build script. Pause by creating C:\CE_PLAN\desk_jobs\PAUSE_WAVE1.flag (no new writer starts). Stops when every job has been launched.
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\wave1_queue.log"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
$order = 'S2', 'S3', 'T1', 'T2'   # E1-E4 and S1 are already launched (14:35)
$launched = @{}
L "queue started; order $($order -join ' ')"
foreach ($k in $order) {
  while ($true) {
    $running = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'cmd.exe' -and $_.CommandLine -match 'team_wave1_[A-Z][0-9]\.txt' }).Count
    if (-not (Test-Path "$d\PAUSE_WAVE1.flag") -and $running -lt 3) { break }
    Start-Sleep 30
  }
  $cmd = 'cmd.exe /c set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + "$d\team_wave1_$k.txt" + '" > "' + "$d\team_wave1_$k.log" + '" 2>&1'
  $si = New-CimInstance -ClassName Win32_ProcessStartup -ClientOnly -Property @{ ShowWindow = [uint16]0 }   # 14:37: HIDDEN console, the visible console of each writer took the foreground from AutoCAD and blocked robot keys (R31, R37 ...)
  $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ ProcessStartupInformation = $si; CommandLine = $cmd; CurrentDirectory = 'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\desk-new-chat-start-prompt-a377a5' }
  L "launched $k pid $($r.ProcessId) rc $($r.ReturnValue) (running before: $running)"
  Start-Sleep 45
}
L 'all jobs launched; queue ends'

