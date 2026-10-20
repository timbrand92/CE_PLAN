# CE log outcome watcher: the 30-minute loop (desk tool, built 21 Oct 2026). The DESK starts it; it is not started by anything else.
# Every 30 minutes on weekdays from 08:00 to 18:30 Melbourne time, and once more at 19:00, it runs log_outcomes.ps1 when AutoCAD is
# running or a CE log changed since the last run, rewrites C:\CE_PLAN\areas\LOG_OUTCOMES_<yyyy-MM-dd>.md (the day so far on top, one
# short block per run below it, newest first), appends ONE line per run to desk_jobs\log_outcomes.log, and adds failure candidates to
# areas\LOG_FAILURE_CANDIDATES.md. It only reads logs. It never touches AutoCAD, the plugin, Tim's settings or any drawing, and it does
# NOT push to git (the desk commits the day report). Stop it by creating C:\CE_PLAN\desk_jobs\STOP_LOGWATCH.flag.
# Usage (hidden, background): Start-Process pwsh -WindowStyle Hidden -ArgumentList '-NoProfile','-File','C:\CE_PLAN\desk_jobs\log_outcomes_loop.ps1'
# Test one run now:  pwsh -File log_outcomes_loop.ps1 -Once -ForDate 2026-10-20 -AreasDir <scratch> -LogFile <scratch>\x.log -StateFile <scratch>\s.json
param(
  [switch]$Once,                                           # run one tick now (ignores the schedule and the "AutoCAD running" test) and exit
  [string]$ForDate,                                        # with -Once: report a whole past day (yyyy-MM-dd)
  [string]$Dir = 'C:\CE_PLAN\desk_jobs',
  [string]$AreasDir = 'C:\CE_PLAN\areas',
  [string]$LogFile,
  [string]$StateFile,
  [string]$CandidateFile,
  [string]$StopFlag,
  [string]$AppData = $env:APPDATA
)
$ErrorActionPreference = 'Continue'
$utf8 = New-Object Text.UTF8Encoding($false)
if (-not $LogFile) { $LogFile = Join-Path $Dir 'log_outcomes.log' }
if (-not $StateFile) { $StateFile = Join-Path $Dir 'log_outcomes_seen.json' }
if (-not $CandidateFile) { $CandidateFile = Join-Path $AreasDir 'LOG_FAILURE_CANDIDATES.md' }
if (-not $StopFlag) { $StopFlag = Join-Path $Dir 'STOP_LOGWATCH.flag' }
$watcher = Join-Path $Dir 'log_outcomes.ps1'
$melTz = [TimeZoneInfo]::FindSystemTimeZoneById('AUS Eastern Standard Time')
$marker = '<!-- RUN LOG: newest first -->'

function Get-MelNow { [TimeZoneInfo]::ConvertTime([datetime]::UtcNow, [TimeZoneInfo]::Utc, $melTz) }
function Write-RunLog([string]$line) { [IO.File]::AppendAllText($LogFile, $line + "`r`n", $utf8) }
function Test-Stop { Test-Path -LiteralPath $StopFlag }

function Get-NextSlot([datetime]$mel) {
  # slots are 08:00, 08:30 ... 18:30 and 19:00, Monday to Friday, Melbourne time
  for ($d = 0; $d -lt 9; $d++) {
    $day = $mel.Date.AddDays($d)
    if ($day.DayOfWeek -eq 'Saturday' -or $day.DayOfWeek -eq 'Sunday') { continue }
    $slots = @(); for ($m = 8 * 60; $m -le 19 * 60; $m += 30) { $slots += $day.AddMinutes($m) }
    foreach ($sl in $slots) { if ($sl -gt $mel.AddSeconds(5)) { return $sl } }
  }
}

function Test-LogsChanged([datetime]$since) {
  $paths = @((Join-Path $AppData 'CE_CVL_SUITE\logs'), (Join-Path $AppData 'CE_STRUC_SUITE\logs'), (Join-Path $AppData 'CE_STRUC_SUITE\logs\RuntimeDiagnostics'), (Join-Path $AppData 'CE_STRUC_SUITE\logs\StructuralCommands'))
  foreach ($p in $paths) {
    if (-not (Test-Path -LiteralPath $p)) { continue }
    $hit = Get-ChildItem -LiteralPath $p -File -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -gt $since } | Select-Object -First 1
    if ($hit) { return $true }
  }
  return $false
}

$script:lastRun = [datetime]::MinValue
$script:prev = $null
$script:prevDay = ''

function Invoke-Tick([datetime]$melSlot, [bool]$final, [bool]$force) {
  $pcNow = Get-Date
  $acad = [bool](Get-Process -Name acad -ErrorAction SilentlyContinue)
  $changed = Test-LogsChanged $script:lastRun
  $stamp = $melSlot.ToString('yyyy-MM-dd HH:mm')
  if (-not $force -and -not $final -and -not $acad -and -not $changed) {
    Write-RunLog ("{0} | skipped: AutoCAD not running and no CE log changed" -f $stamp)
    return
  }
  if ($ForDate -and $force) {
    $d0 = [datetime]::ParseExact($ForDate, 'yyyy-MM-dd', $null)
    $since = $d0.ToString('yyyy-MM-dd 00:00'); $until = $d0.ToString('yyyy-MM-dd 23:59'); $dayKey = $ForDate
  } else {
    $since = $pcNow.Date.ToString('yyyy-MM-dd 00:00'); $until = $pcNow.ToString('yyyy-MM-dd HH:mm'); $dayKey = $pcNow.ToString('yyyy-MM-dd')
  }
  if ($script:prevDay -ne $dayKey) { $script:prev = $null; $script:prevDay = $dayKey }
  try {
    $r = & $watcher -Since $since -Until $until -StateFile $StateFile -CandidateFile $CandidateFile -AppData $AppData -PassThru
  } catch {
    Write-RunLog ("{0} | ERROR in log_outcomes.ps1: {1}" -f $stamp, (($_.Exception.Message -replace '[A-Za-z]:\\\S+', '<path>') -replace '\s+', ' '))
    return
  }
  $script:lastRun = $pcNow
  $dayFile = Join-Path $AreasDir ("LOG_OUTCOMES_{0}.md" -f $dayKey)
  $oldRuns = ''
  if (Test-Path -LiteralPath $dayFile) {
    $txt = [IO.File]::ReadAllText($dayFile)
    $ix = $txt.IndexOf($marker)
    if ($ix -ge 0) { $oldRuns = $txt.Substring($ix + $marker.Length).TrimStart("`r", "`n") }
  }
  $dW = $r.Worked; $dR = $r.Refused; $dC = $r.Cancelled; $dWn = $r.Warned; $dF = $r.Failed; $dU = $r.Unknown; $dS = $r.Sessions
  if ($script:prev) { $dW -= $script:prev.Worked; $dR -= $script:prev.Refused; $dC -= $script:prev.Cancelled; $dWn -= $script:prev.Warned; $dF -= $script:prev.Failed; $dU -= $script:prev.Unknown; $dS -= $script:prev.Sessions }
  $script:prev = $r
  $block = New-Object Text.StringBuilder
  [void]$block.AppendLine(("### Run at {0} Melbourne" -f $stamp))
  [void]$block.AppendLine()
  [void]$block.AppendLine(("1. **Since the last run:** {0} more command runs (worked {1}, refused {2}, cancelled {3}, warned {4}, failed {5}, unknown {6})." -f $dS, $dW, $dR, $dC, $dWn, $dF, $dU))
  [void]$block.AppendLine(("2. **Day so far:** worked {0}, refused {1}, cancelled {2}, warned {3}, failed {4}, unknown {5}; {6} new warning/error types; {7} new failure candidate(s) this run." -f $r.Worked, $r.Refused, $r.Cancelled, $r.Warned, $r.Failed, $r.Unknown, $r.NewMessages, $r.NewCandidates))
  [void]$block.AppendLine(("3. **Why it ran:** {0}." -f $(if ($force -and $ForDate) { 'backfill of a past day' } elseif ($force) { 'test run' } elseif ($final) { 'the 19:00 closing run' } elseif ($acad) { 'AutoCAD is running' } else { 'a CE log changed' })))
  [void]$block.AppendLine()
  $out = New-Object Text.StringBuilder
  [void]$out.AppendLine(("<!-- Written by log_outcomes_loop.ps1; the desk commits this file. Reports show command names, counts and messages only (no drive paths, no drawing names). -->"))
  [void]$out.AppendLine(("_Updated {0} Melbourne time._" -f $stamp))
  [void]$out.AppendLine()
  [void]$out.Append($r.Text)
  [void]$out.AppendLine()
  [void]$out.AppendLine('---')
  [void]$out.AppendLine()
  [void]$out.AppendLine('## Run log')
  [void]$out.AppendLine()
  [void]$out.AppendLine($marker)
  [void]$out.AppendLine()
  [void]$out.Append($block.ToString())
  [void]$out.Append($oldRuns)
  [IO.File]::WriteAllText($dayFile, $out.ToString(), $utf8)
  Write-RunLog ("{0} | sessions {1} | worked {2} | refused {3} | cancelled {4} | warned {5} | failed {6} | unknown {7} | new msgs {8} | candidates +{9} | acad {10}" -f $stamp, $r.Sessions, $r.Worked, $r.Refused, $r.Cancelled, $r.Warned, $r.Failed, $r.Unknown, $r.NewMessages, $r.NewCandidates, $(if ($acad) { 'yes' } else { 'no' }))
}

if ($Once) {
  Invoke-Tick (Get-MelNow) $false $true
  return
}

Write-RunLog ("{0} | loop started (stop flag: {1})" -f (Get-MelNow).ToString('yyyy-MM-dd HH:mm'), (Split-Path $StopFlag -Leaf))
while ($true) {
  if (Test-Stop) { Write-RunLog ("{0} | loop stopped by flag" -f (Get-MelNow).ToString('yyyy-MM-dd HH:mm')); break }
  $slot = Get-NextSlot (Get-MelNow)
  while ((Get-MelNow) -lt $slot) {
    if (Test-Stop) { break }
    $left = ($slot - (Get-MelNow)).TotalSeconds
    Start-Sleep -Seconds ([math]::Max(1, [math]::Min(30, $left)))
  }
  if (Test-Stop) { Write-RunLog ("{0} | loop stopped by flag" -f (Get-MelNow).ToString('yyyy-MM-dd HH:mm')); break }
  $isFinal = ($slot.Hour -eq 19 -and $slot.Minute -eq 0)
  Invoke-Tick $slot $isFinal $false
}
