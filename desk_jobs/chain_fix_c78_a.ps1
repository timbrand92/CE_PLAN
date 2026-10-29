# CE 01 Build, 29 Oct 2026: C-78 backlog lane A (engineering numbers, pilot-critical fixes). Starts when chain_fix_c77_l1\.ps1 has ended. Builds stay one at a time across lanes (the job texts wait while another dotnet build or test runs). Nothing is installed. Stop flag STOP_CHAIN.flag. Jobs c and h run on Opus, the rest on Sonnet.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix_c78_a.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$w = 0
while (Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match 'chain_fix_c77_l1\.ps1' -and $_.Name -match 'pwsh' }) { Start-Sleep 120; $w++; if ($w -gt 360) { Log 'predecessor lane still running after 12 hours: this lane stops'; exit } }
Log 'predecessor lane finished: starting'
foreach ($k in 'a','c','d','e') {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $model = 'sonnet'; if ($k -eq 'c' -or $k -eq 'h') { $model = 'opus' }
  $job = "$d\team_fix_c78$k.txt"; $lg = "$d\team_fix_c78$k.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting team_fix_c78${k} (${model})"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished team_fix_c78${k}"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your')) { Log "team_fix_c78${k} log ends with a login or limit line: the desk reads it"; exit }
}
Log 'lane finished'