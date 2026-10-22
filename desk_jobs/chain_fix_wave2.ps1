# Desk 23 Oct 2026: run fix wave 2 batches 1 to 5 one after another (Sonnet, Team). Stop flag STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix_wave2.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
foreach ($b in 1..5) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'STOP flag'; exit }
  $out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\fix_wave2_b$b.txt" -Model sonnet
  Log "$out"
  $m = [regex]::Match("$out", 'pid (\d+)')
  if ($m.Success) { Wait-Process -Id ([int]$m.Groups[1].Value) -ErrorAction SilentlyContinue }
  Log "finished batch $b"
}
