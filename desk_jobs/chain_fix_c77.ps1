# CE 01 Build, 29 Oct 2026: nine Team fix jobs for the C-77 backlog, strictly one after another (one dotnet at a time). Each opens a DRAFT PR. Nothing is installed. Stop flag STOP_CHAIN.flag. Job g (cover to the pipe outside) runs on Opus; the rest on Sonnet.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix_c77.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($k in 'a','b','c','d','e','f','g','h','i') {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $model = 'sonnet'; if ($k -eq 'g') { $model = 'opus' }
  $job = "$d\team_fix_c77$k.txt"; $lg = "$d\team_fix_c77$k.log"
  $cmd = 'set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model ' + $model + ' --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
  Log "starting team_fix_c77${k} (${model})"
  Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -Wait
  Log "finished team_fix_c77${k}"
  if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your')) { Log "team_fix_c77${k} log ends with a login or limit line: the desk reads it"; exit }
}
Log 'all fix jobs finished'