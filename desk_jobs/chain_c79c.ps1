# CE 01, Sun 1 Nov 2026 10:55: one Team job, the C-79c ASSEMBLER (Sonnet), train_c79c_assembler_job.txt. Installs NOTHING. Stop flag STOP_CHAIN.flag. PassThru + WaitForExit pattern.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c79c.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
New-Item -ItemType Directory -Force 'C:\CE_WORK\scratch\c79c\tmp', 'C:\CE_WORK\scratch\c79c\logs', 'C:\CE_WORK\scratch\c79c\struc' | Out-Null
$free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
while ($free -lt 27) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  Log "C: has $free GB free, under the 27 GB floor: waiting"; Start-Sleep -Seconds 600
  $free = [math]::Round((Get-PSDrive C).Free / 1GB, 1)
}
$job = "$d\train_c79c_assembler_job.txt"; $lg = "$d\train_c79c_assembler_job.log"
$cmd = 'set "CE_STRUC_SUITE_APPDATA_ROOT=C:\CE_WORK\scratch\c79c\struc"&& set "CE_LOG_DIR_OVERRIDE=C:\CE_WORK\scratch\c79c\logs"&& set "TEMP=C:\CE_WORK\scratch\c79c\tmp"&& set "TMP=C:\CE_WORK\scratch\c79c\tmp"&& set "CLAUDE_CONFIG_DIR=C:\Users\TimothyBrand\.claude-team"&& set "PATH=%PATH%;C:\Users\TimothyBrand\AppData\Roaming\npm"&& claude -p --model sonnet --permission-mode bypassPermissions --output-format text < "' + $job + '" > "' + $lg + '" 2>&1'
Log "starting train_c79c_assembler_job.txt (sonnet), C: $free GB free"
$pj = Start-Process cmd.exe -ArgumentList '/c', $cmd -WorkingDirectory 'C:\Lisp Files\CE_ACAD_PLUGIN' -WindowStyle Hidden -PassThru; try { $pj.PriorityClass = 'BelowNormal' } catch {}; $pj.WaitForExit()
Log 'finished train_c79c_assembler_job.txt'
if ((Test-Path $lg) -and ((Get-Content $lg -Tail 5 -ErrorAction SilentlyContinue) -match 'OAuth|session limit|hit your|/login')) { Log 'assembler log ends with a login or limit line: the desk reads it'; exit }
Log 'lane finished'
