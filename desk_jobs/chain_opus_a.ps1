# CE 01 Build, 29 Oct 2026: Team Opus lane o_a (read-only reviews and diagnoses, NO build slot). Resumes after a 5-hour limit instead of dying: a job whose log ends with a limit line is re-run after a wait (up to 3 tries).
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_opus_o_a.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($k in 'o1','o2','o3') {
  $job = "$d\team_opus_$k.txt"; $lg = "$d\team_opus_$k.log"
  $tries = 0
  while ($tries -lt 3) {
    if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
    $tries++
    $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model opus --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
    Log "starting team_opus_${k} try ${tries}"
    Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
    Log "finished team_opus_${k}"
    $tail = ''
    if (Test-Path $lg) { $tail = (Get-Content $lg -Tail 6 -ErrorAction SilentlyContinue) -join ' ' }
    if ($tail -match 'hit your|session limit|usage limit|rate limit') { Log "limit line after ${k}: waiting 20 minutes, then re-running"; Start-Sleep 1200; continue }
    if ($tail -match 'OAuth|Please run /login|not logged in') { Log "login line after ${k}: the desk reads it"; exit }
    break
  }
}
Log 'lane finished'