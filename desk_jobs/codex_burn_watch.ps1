# Desk 26 Oct 2026 (Tim: Codex announced a weekly reset coming today, any time): watches the Codex burn. daily_cap.sh ends the burn by itself (renames BURN_UNTIL.txt) when the end time passes or Codex's weekly reset time changes, but it is only called by the supervisor and conveyor in PACE mode, so this watcher calls it every 5 minutes. The moment the burn is over it writes PACE back into CODEX_MODE.txt (jobs already running finish; only new starts are held by the normal daily share). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
$bash = 'C:\Program Files\Git\bin\bash.exe'
$burn = 'C:\Lisp Files\_CODEX_RUNNER\BURN_UNTIL.txt'
function Log($t) { Add-Content "$d\codex_burn_watch.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
Log 'burn watcher started'
while ($true) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $o = & $bash -c 'bash "/c/Lisp Files/_CODEX_RUNNER/daily_cap.sh" explain' 2>$null
  if (-not (Test-Path $burn)) {
    $m = (Get-Content "$d\CODEX_MODE.txt" -TotalCount 1 -ErrorAction SilentlyContinue)
    if ($m -ne 'PACE') { Set-Content "$d\CODEX_MODE.txt" 'PACE'; Log ("BURN OVER (" + ($o | Select-Object -First 1) + "): CODEX_MODE.txt set to PACE; running jobs finish, new starts follow the normal daily share") }
    Log 'burn over: watcher ends'
    exit
  }
  Start-Sleep 300
}
