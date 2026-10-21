$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_fix22.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
$out = & pwsh -NoProfile -File "$d\launch_job.ps1" -JobFile "$d\fix_round_22oct_job.txt" -Model sonnet
Log "$out"
