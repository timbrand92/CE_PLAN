# Desk 20 Oct 2026: two fixer jobs one after the other on the Team account (BUG-852 split; BUG-416 residual path), then stops.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix56.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
function RunJob($file, $model) {
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\$file" -Model $model
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished $file"
}
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
RunJob 'fix_bug416_residual_job.txt' 'sonnet'
if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
RunJob 'fix_1493_split_job.txt' 'sonnet'
Log 'chain complete'