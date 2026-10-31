# CE 02 Sun 1 Nov 2026: C-79b1 case-writing jobs on Team (CE 00 GO 00:40: fixture job F1 after the 03:10 Team reset, writers straight after it, at most 3 of mine at once with CE 05's counted). Not a build script. Pause: create C:\CE_PLAN\desk_jobs\PAUSE_C79B1.flag (no new job starts; running jobs finish).
$d = 'C:\CE_PLAN\desk_jobs'; $log = "$d\c79b1_queue.log"
function L($t) { Add-Content $log ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm:ss'), $t) }
function Running { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'cmd.exe' -and $_.CommandLine -match '\.claude-team' -and $_.CommandLine -match 'claude -p' }).Count }
function JobAlive($k) { @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'cmd.exe' -and $_.CommandLine -match "team_c79b1_$k\.txt" }).Count -gt 0 }
function Launch($k, $model) {
  while ($true) { if (-not (Test-Path "$d\PAUSE_C79B1.flag") -and (Running) -lt 3) { break }; Start-Sleep 30 }
  $cmd = 'cmd.exe /c set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + "$d\team_c79b1_$k.txt" + '" > "' + "$d\team_c79b1_$k.log" + '" 2>&1'
  $si = New-CimInstance -ClassName Win32_ProcessStartup -ClientOnly -Property @{ ShowWindow = [uint16]0 }
  $r = Invoke-CimMethod -ClassName Win32_Process -MethodName Create -Arguments @{ ProcessStartupInformation = $si; CommandLine = $cmd; CurrentDirectory = 'C:\Lisp Files\CE_ACAD_PLUGIN\.claude\worktrees\desk-new-chat-start-prompt-a377a5' }
  L "launched $k pid $($r.ProcessId) rc $($r.ReturnValue) (running before: $(Running))"
  Start-Sleep 45
}
function WaitDone($k) { while (JobAlive $k) { Start-Sleep 30 }; L "$k ended" }
L 'queue started; waits for 03:10 Sun'
$start = [datetime]::Today.AddHours(3).AddMinutes(10)
while ((Get-Date) -lt $start) { Start-Sleep 30 }
L 'it is 03:10 or later: launching F1 and W1'
Launch 'F1' 'opus'
Launch 'W1' 'opus'
WaitDone 'F1'
Launch 'W2' 'opus'
WaitDone 'W1'; WaitDone 'W2'
Launch 'R' 'opus'
WaitDone 'R'
L 'all four jobs and the review ended; queue ends'
