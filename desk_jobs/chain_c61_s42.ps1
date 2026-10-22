# Desk 23 Oct 2026: C-61 (Civil + Manager) assembler (Sonnet) -> finalizer (Opus) -> payload 93 (Sonnet) if GO, THEN S-42 (Structural) assembler -> finalizer -> payload 94 if GO, strictly one job after another on the Team account (two assemblers at once corrupt each other). Installs NOTHING. Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c61_s42.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
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
Log 'chain start: C-61 first, then S-42; nothing is installed by this chain.'

# ---- C-61 (Civil + Manager) ----
$cAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C61_ASSEMBLY_REPORT_2026-10-23.md'
$cFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_C61_FINALIZER_REPORT_2026-10-23.md'
$cOk = $true
RunJob 'train_c61_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $cAsm)) { Log 'no C-61 assembly report: C-61 stops before its finalizer'; $cOk = $false }
if ($cOk) {
  RunJob 'train_c61_finalizer_job.txt' 'opus'
  if (Stopped) { exit }
  if (-not (Test-Path $cFin)) { Log 'no C-61 finalizer report: C-61 stops before payload 93'; $cOk = $false }
}
if ($cOk) {
  if (IsGo $cFin) {
    Log 'C-61 finalizer verdict GO: building payload 93 (candidate c1057). Nothing is installed by this chain.'
    RunJob 'payload93_c61_job.txt' 'sonnet'
    if (Stopped) { exit }
  } else { Log 'C-61 finalizer verdict is not GO: no payload 93; the desk reads the report' }
}

# ---- S-42 (Structural), only after C-61 has fully finished ----
$sAsm = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S42_ASSEMBLY_REPORT_2026-10-23.md'
$sFin = 'C:\CE_PLAN\areas\release-v3-colleagues-TRAIN_S42_FINALIZER_REPORT_2026-10-23.md'
RunJob 'train_s42_assembler_job.txt' 'sonnet'
if (Stopped) { exit }
if (-not (Test-Path $sAsm)) { Log 'no S-42 assembly report: chain stops before the S-42 finalizer'; exit }
RunJob 'train_s42_finalizer_job.txt' 'opus'
if (Stopped) { exit }
if (-not (Test-Path $sFin)) { Log 'no S-42 finalizer report: chain stops before payload 94'; exit }
if (-not (IsGo $sFin)) { Log 'S-42 finalizer verdict is not GO: stopping for the desk'; exit }
Log 'S-42 finalizer verdict GO: building payload 94 (candidate s1040). Nothing is installed by this chain.'
RunJob 'payload94_s42_job.txt' 'sonnet'
Log 'chain complete'
