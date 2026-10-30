# CE 01, 30 Oct 2026: writes desk_jobs\C78_PAYLOAD_GO.flag so payload 114 can compile and test before the C-77 full set ends.
# Writes the flag at 22:15 (PC clock, Melbourne) on 30 Oct, or earlier when desk_jobs\FULL_SET_DONE.txt appears. Stops on STOP_CHAIN.flag.
$d = 'C:\CE_PLAN\desk_jobs'
function Log($t) { Add-Content "$d\chain_c78.log" ("{0} {1}" -f (Get-Date -Format 'ddd HH:mm'), $t) }
Log 'flag watcher started: C78_PAYLOAD_GO.flag is written at 03:30 on 31 Oct; CE 01 writes it earlier by hand when the addendum pass is merged and tested'
$at = [datetime]'2026-10-31 03:30'
while ($true) {
  if (Test-Path "$d\STOP_CHAIN.flag") { Log 'flag watcher: STOP flag'; exit }
  if ((Get-Date) -ge $at) { break }
  Start-Sleep 60
}
Set-Content "$d\C78_PAYLOAD_GO.flag" ("written by the flag watcher at " + (Get-Date -Format 'yyyy-MM-dd HH:mm'))
Log 'flag watcher: C78_PAYLOAD_GO.flag written'
