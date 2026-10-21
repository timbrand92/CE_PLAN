# Desk 22 Oct 2026: C-59 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 90 (Sonnet) if GO, THEN S-41 (Structural) assembler -> finalizer -> payload 91 if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c59_s41.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
function IsGo($fin) {
  if (-not (Test-Path $fin)) { return $false }
  $txt = Get-Content $fin -Raw
  return ($txt -match '\*\*GO at `[0-9a-f]{40}`' -and $txt -notmatch 'NO-GO at')
}
function Stopped() { if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; return $true } return $false }

if (Stopped) { exit }
Log 'chain start: C-59 first, then S-41; nothing is installed by this chain.'

# ---- C-59 (Civil + Manager) ----
$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C59_ASSEMBLY_REPORT_2026-10-22.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C59_FINALIZER_REPORT_2026-10-22.md'
$cOk = $true
RunJob 'train_c59_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-59 assembly report: C-59 stops before its finalizer'; $cOk = $false }
if ($cOk) {
  RunJob 'train_c59_finalizer_job.txt' 'opus'
  if (Stopped) { exit }
  if (-not (Test-Path $cFin)) { Log 'no C-59 finalizer report: C-59 stops before payload 90'; $cOk = $false }
}
if ($cOk) {
  if (IsGo $cFin) {
    Log 'C-59 finalizer verdict GO: building payload 90 (candidate c1055). Nothing is installed by this chain.'
    RunJob 'payload90_c59_job.txt' 'sonnet'
    if (Stopped) { exit }
  } else { Log 'C-59 finalizer verdict is not GO: no payload 90; the desk reads the report' }
}

# ---- S-41 (Structural), only after C-59 has fully finished ----
$sAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S41_ASSEMBLY_REPORT_2026-10-22.md'
$sFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S41_FINALIZER_REPORT_2026-10-22.md'
RunJob 'train_s41_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $sAsm)) { Log 'no S-41 assembly report: chain stops before the S-41 finalizer'; exit }
RunJob 'train_s41_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $sFin)) { Log 'no S-41 finalizer report: chain stops before payload 91'; exit }
if (-not (IsGo $sFin)) { Log 'S-41 finalizer verdict is not GO: stopping for the desk'; exit }
Log 'S-41 finalizer verdict GO: building payload 91 (candidate s1039). Nothing is installed by this chain.'
RunJob 'payload91_s41_job.txt' 'sonnet'
Log 'chain complete'
