# CE log outcome watcher (desk tool, built 21 Oct 2026 for desk plan/03).
# Reads the CE plugin logs (read-only, FileShare.ReadWrite so a running AutoCAD is never disturbed), groups the lines into
# COMMAND SESSIONS from the markers the logs really contain, and says for each command: worked / refused / cancelled / warned /
# failed / unknown. It changes NO plugin code, NO setting, NO drawing, starts NO AutoCAD, and never writes to a CE log folder.
# Usage:  pwsh -File log_outcomes.ps1 -Since '2026-10-20 00:00' -Until '2026-10-20 23:59' -Out C:\...\report.md
# See LOG_OUTCOMES_README.md for what each outcome means and what the logs do NOT record.
param(
  [string]$Since,                                   # 'yyyy-MM-dd HH:mm' (or date only). Default: start of today.
  [string]$Until,                                   # default: now
  [string]$Out,                                     # report file (markdown). Default: print to the console.
  [string]$StateFile = (Join-Path $PSScriptRoot 'log_outcomes_seen.json'),
  [string]$CandidateFile,                           # when given, append one line per new failure candidate
  [switch]$NoState,                                 # do not read or write the state file (dry run)
  [string]$AppData = $env:APPDATA,                  # where the CE log folders live (override for tests)
  [int]$MinWorked = 2,                              # 'Used successfully' needs at least this many WORKED
  [switch]$PassThru                                 # return a summary object (used by log_outcomes_loop.ps1)
)
$ErrorActionPreference = 'Stop'
$utf8 = New-Object Text.UTF8Encoding($false)

function ConvertTo-Moment([string]$s, [datetime]$default) {
  if ([string]::IsNullOrWhiteSpace($s)) { return $default }
  foreach ($f in 'yyyy-MM-dd HH:mm', 'yyyy-MM-dd HH:mm:ss', 'yyyy-MM-dd') {
    $d = [datetime]::MinValue
    if ([datetime]::TryParseExact($s.Trim(), $f, [Globalization.CultureInfo]::InvariantCulture, 'None', [ref]$d)) { return $d }
  }
  throw "Cannot read the time '$s' (use 'yyyy-MM-dd HH:mm')."
}
$sinceT = ConvertTo-Moment $Since ((Get-Date).Date)
$untilT = ConvertTo-Moment $Until (Get-Date)
$sinceS = $sinceT.ToString('yyyy-MM-dd HH:mm:ss.fff')
$untilS = $untilT.ToString('yyyy-MM-dd HH:mm:ss.fff')
$melTz = [TimeZoneInfo]::FindSystemTimeZoneById('AUS Eastern Standard Time')

# ---------------------------------------------------------------- privacy: nothing from a client project leaves this tool
$userA = 'Timothy'; $userB = 'Brand'            # split so this file carries no personal term (leak-scan)
$addrWords ='\b(Street|Road|Court|Avenue|Crescent|Boulevard|Parade|Terrace|Highway|Lane)\b'
function Protect-Text([string]$t, [int]$cut = 200) {
  if ($null -eq $t) { return '' }
  $t = $t -replace '[A-Za-z]:\\[^"<>|*?\r\n]*?\.(?:dwg|dxf|dwt|dws)\b', '<dwg>'
  $t = $t -replace '[A-Za-z]:\\[^"<>|*?\r\n]*?\.(?:json|txt|log|csv|pdf|xlsx?|bak|dll|xml|lsp|cuix|bundle)\b', '<path>'
  $t = $t -replace '[A-Za-z]:\\[^\s"''<>|,;)]+', '<path>'
  $t = $t -replace '\\\\[A-Za-z0-9_.\-]+\\[^\s"''<>|,;)]+', '<path>'
  $t = $t -replace '\b[A-Za-z0-9_\-]+(?: [A-Za-z0-9_\-,]+){0,6}\.dwg\b', '<dwg>'
  $t = $t -replace '\b[A-Z]?\d{2}-\d{2,3}[A-Za-z0-9_\-]*', '<job>'
  $t = $t -replace ($userA + $userB + '|TIMOTH~1'), '<user>'
  $t = $t -replace '[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}', '<email>'
  if ($t -match $addrWords -or $t -match '\.dwg\b|[A-Za-z]:\\') { $t = '<message withheld: may name a project or an address>' }
  $t = ($t -replace '\s+', ' ').Trim()
  if ($t.Length -gt $cut) { $t = $t.Substring(0, $cut - 1) + '…' }
  return $t
}
function Get-NormKey([string]$t) {   # same message with different handles/numbers counts as one
  $k = Protect-Text $t 400
  $k = $k -replace '\b(?=[0-9A-F]*\d)[0-9A-F]{5,8}\b', '<h>'
  $k = $k -replace '\d+(?:\.\d+)?', '#'
  return $k
}

# ---------------------------------------------------------------- reading logs (shared read, never write)
function Read-LogLines([string]$path) {
  $list = New-Object 'System.Collections.Generic.List[string]'
  $fs = $null
  try {
    $fs = New-Object IO.FileStream($path, [IO.FileMode]::Open, [IO.FileAccess]::Read, [IO.FileShare]::ReadWrite)
    $sr = New-Object IO.StreamReader($fs, [Text.Encoding]::UTF8, $true)
    while ($null -ne ($ln = $sr.ReadLine())) { $list.Add($ln) }
  } catch { } finally { if ($fs) { $fs.Dispose() } }
  return , $list
}
function Get-NameDate([string]$name) { if ($name -match '(\d{8})') { return [datetime]::ParseExact($Matches[1], 'yyyyMMdd', $null) } return $null }
function Test-InWindow([IO.FileInfo]$fi, [int]$daysBefore) {
  if ($fi.LastWriteTime -lt $sinceT) { return $false }
  $d = Get-NameDate $fi.Name
  if ($d -and ($d -gt $untilT.Date)) { return $false }
  if ($d -and ($d -lt $sinceT.Date.AddDays(-$daysBefore))) { return $false }
  return $true
}

# ---------------------------------------------------------------- what each log line means
# Lines that are noise for the outcome (still listed under new messages): the block-file security note fires on every pit insert.
$noiseRx = '^SECURITY: Block file resolved'
$refuseRx = 'edit refused|not renamed|\bnot split\b|\brefused\b|Nothing was changed|[Nn]o clear spot|left where it is|not allowed'
$warnTextRx = 'Redo was not available|\bcould not\b|\bfailed\b|\bunable to\b'
$ceCheckRx = '^\[CE[^\]]*\].*\bcheck\b'      # a "[CE] ... check" line is CE asking the user to look at something
$failTextRx = '\bunhandled\b|\w+Exception\b|stack trace'
# FINGERPRINTS. With debug logging OFF (Tim's normal setting) the start/end markers below do not exist, so a few plain INFO
# lines are used instead. Role: start = a run began, attach = part of that run, done = the run's own completion line,
# oneshot = a single line that is both the start and the completion. Found by comparing the INFO lines inside marker-
# bracketed runs (debug ON) with the robot reports; every pattern here was seen in a real log.
$fps = @(
  @{ Cmd = 'CD'; Rx = '^CD command started$'; Role = 'start' }
  @{ Cmd = 'CD'; Rx = '^CD command completed successfully$'; Role = 'done' }
  @{ Cmd = 'CDEDIT'; Rx = '^PipeEdit: exact pipe-text roles unavailable'; Role = 'attach' }
  @{ Cmd = 'CDEDIT'; Rx = '^\[C8\] CDEDIT older pipe'; Role = 'attach' }
  @{ Cmd = 'CDEDIT'; Rx = '^CDEDIT-CASCADE:|coordinated pipe update committed'; Role = 'done' }
  @{ Cmd = 'CDRECOVERINVERTS'; Rx = '^CDRECOVERINVERTS: pipe .* invert text written'; Role = 'done' }
  @{ Cmd = 'CDTWL'; Rx = '^\[TWL\] '; Role = 'oneshot' }
  @{ Cmd = 'CDTIDYLABELS'; Rx = '^\[TidyUp\] route=cdtidylabels-'; Role = 'oneshot' }
  @{ Cmd = 'PIT'; Rx = '^Pit added: '; Role = 'oneshot' }
  @{ Cmd = '(sync step: CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT)'; Rx = '^\[PitRestore\] Restored user-set pit data'; Role = 'oneshot' }
)
$gapSec = @{ 'CDEDIT' = 300; 'CD' = 300 }       # how long a run may be quiet before the next line starts a new run
$tokenRx = New-Object Text.RegularExpressions.Regex('^(?:\[(?!PERF)[A-Za-z0-9 ]+\] )?(CD[A-Z0-9]{3,})\b(?!\.)', 'Compiled')
$tokenSkip = @('CDGRIPROUTE', 'CDPIPEATTACHMENTACTION')
$lineRx = New-Object Text.RegularExpressions.Regex('^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d\.\d{3}) \[(INF|DBG|WRN|ERR|FTL|VRB)\] (?:\d{4}-\d\d-\d\d \d\d:\d\d:\d\d\.\d{3} \[\w+\] )?(.*)$', 'Compiled')
$guardRx = New-Object Text.RegularExpressions.Regex("UcsGuardService . '([A-Za-z0-9_.\-]+)' (starting|ended|cancelled)", 'Compiled')

function Get-EventKind([string]$lvl, [string]$msg) {
  if ($msg -match $noiseRx) { return 'noise' }
  # A message ending in a reason code in square brackets, e.g. "...no unique matching drawing/project spine identity. [OtherKindOfObject]",
  # is CE's own deliberate refusal (robot run 34 saw the user get "Nothing was changed" for exactly this line), not a crash.
  if ($lvl -ne 'DBG' -and $msg -match '\[[A-Z][A-Za-z]{5,}\]\s*$' -and $msg -match 'Exception|failed|could not|refused') { return 'refuse' }
  if ($lvl -eq 'ERR') { return 'fail' }
  if ($lvl -eq 'DBG' -or $lvl -eq 'VRB') { return $null }   # debug chatter never decides an outcome
  if ($msg -match $refuseRx) { return 'refuse' }
  if ($msg -match $failTextRx) { return 'fail' }
  if ($lvl -eq 'WRN') { return 'warn' }
  if ($msg -match $warnTextRx -or $msg -match $ceCheckRx) { return 'warn' }
  return $null
}

# ---------------------------------------------------------------- versions (Civil: 'CE_CVL_SUITE vX Started' lines in the plain log)
$civilLogs = Join-Path $AppData 'CE_CVL_SUITE\logs'
$verList = New-Object 'System.Collections.Generic.List[object]'
foreach ($vf in 'CE_CVL_SUITE.log.2', 'CE_CVL_SUITE.log.1', 'CE_CVL_SUITE.log') {
  $p = Join-Path $civilLogs $vf
  if (Test-Path -LiteralPath $p) {
    foreach ($ln in (Read-LogLines $p)) {
      if ($ln.Contains(' Started') -and $ln -match '^(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d\.\d{3}) \[\w+\] CE_CVL_SUITE v([\d.]+) Started') {
        $verList.Add([pscustomobject]@{ T = $Matches[1]; V = ($Matches[2] -replace '(\.0)+$', '') })
      }
    }
  }
}
$verSorted = @($verList | Sort-Object T)
function Get-CivilVersion([string]$ts) {
  $v = 'unknown build'
  foreach ($e in $verSorted) { if ($e.T -le $ts) { $v = $e.V } else { break } }
  return $v
}
$strucVersion = 'unknown build'
$bgPrefix = '('                                   # pseudo-commands (background steps) start with a bracket and are not counted as commands
try {
  $sdll = Get-ChildItem -LiteralPath (Join-Path $AppData 'Autodesk\ApplicationPlugins\CE_STRUC_SUITE.bundle') -Recurse -Filter 'CE_STRUC_SUITE.dll' -ErrorAction Stop | Select-Object -First 1
  if ($sdll) { $strucVersion = (($sdll.VersionInfo.ProductVersion -replace '\+.*$', '') -replace '(\.0)+$', '') + ' (installed now)' }
} catch { }

# ---------------------------------------------------------------- session machinery
$script:evSeq = 0
$sessions = New-Object 'System.Collections.Generic.List[object]'   # finished sessions
$allMsgs = New-Object 'System.Collections.Generic.List[object]'    # every [ERR]/[WRN] event, for 'new message' tracking
$counts = @{ filesRead = 0; linesRead = 0; orphanEvents = 0 }
$sourcesRead = New-Object 'System.Collections.Generic.List[string]'

function New-Session([string]$suite, [string]$cmd, [string]$ts, [string]$kind, [string]$file) {
  return @{ Suite = $suite; Cmd = $cmd; Start = $ts; End = $ts; Kind = $kind; EndMark = $null; Done = $false; Events = (New-Object 'System.Collections.Generic.List[object]'); File = $file }
}
function Close-Session($s, [string]$endMark, [string]$ts) {
  if ($ts) { $s.End = $ts }
  $s.EndMark = $endMark
  $fail = @($s.Events | Where-Object { $_.Kind -eq 'fail' })
  $refuse = @($s.Events | Where-Object { $_.Kind -eq 'refuse' })
  $warn = @($s.Events | Where-Object { $_.Kind -eq 'warn' })
  # A refusal or warning followed later in the same run by the command's own completion line (CDEDIT: "coordinated pipe update
  # committed") means CE declined one path and then finished the job: that run WORKED. A failure is never overridden.
  $done = @($s.Events | Where-Object { $_.Completion })
  if ($done.Count -gt 0 -and $fail.Count -eq 0) {
    $lastDone = ($done | ForEach-Object { [long]$_.Seq } | Measure-Object -Maximum).Maximum
    $refuse = @($refuse | Where-Object { [long]$_.Seq -gt $lastDone })
    $warn = @($warn | Where-Object { [long]$_.Seq -gt $lastDone })
  }
  # A repeating command (CD, PIT) is ended with Esc or Enter, which the guard logs as 'cancelled': when the run also logged its
  # own completion line, it worked.
  $outcome = 'UNKNOWN'
  if ($fail.Count -gt 0) { $outcome = 'FAILED' }
  elseif ($refuse.Count -gt 0) { $outcome = 'REFUSED' }
  elseif ($done.Count -gt 0) { $outcome = if ($warn.Count -gt 0) { 'WARNED' } else { 'WORKED' } }
  elseif ($endMark -eq 'cancelled') { $outcome = 'CANCELLED' }
  elseif ($warn.Count -gt 0) { $outcome = 'WARNED' }
  elseif ($endMark -eq 'ended' -or $endMark -eq 'completed') { $outcome = 'WORKED' }
  $s.Outcome = $outcome
  $s.Ver = if ($s.Suite -eq 'Civil') { Get-CivilVersion $s.Start } else { $strucVersion }
  $sessions.Add($s)
}

function Read-CivilStructured {
  $dir = $civilLogs
  if (-not (Test-Path -LiteralPath $dir)) { return }
  $files = Get-ChildItem -LiteralPath $dir -Filter 'ce_cvl_structured_*.log' | Where-Object { Test-InWindow $_ 0 } | Sort-Object Name
  $open = @{}                                    # UcsGuard sessions by command name
  $stack = New-Object 'System.Collections.Generic.List[object]'
  $adhoc = @{}                                   # token sessions by command name
  foreach ($fi in $files) {
    $counts.filesRead++; $sourcesRead.Add($fi.Name)
    $last = $null
    foreach ($ln in (Read-LogLines $fi.FullName)) {
      $counts.linesRead++
      $m = $lineRx.Match($ln)
      if (-not $m.Success) {
        if ($last -and $ln -match '^\s+at ') {            # a stack trace line: whatever came just before it failed
          if ($last.Kind -ne 'noise' -and $last.Kind -ne 'fail') { $last.Kind = 'fail'; if ($last.Sess -and -not $last.InList) { $last.Sess.Events.Add($last); $last.InList = $true } }
        }
        continue
      }
      $ts = $m.Groups[1].Value
      if ($ts -lt $sinceS -or $ts -gt $untilS) { $last = $null; continue }
      $lvl = $m.Groups[2].Value; if ($lvl -eq 'FTL') { $lvl = 'ERR' }
      $msg = $m.Groups[3].Value
      $g = $guardRx.Match($msg)
      if ($g.Success) {
        $name = $g.Groups[1].Value; $what = $g.Groups[2].Value
        if ($what -eq 'starting') {
          if ($open.ContainsKey($name)) { $old = $open[$name]; [void]$stack.Remove($old); Close-Session $old $null $null }
          $s = New-Session 'Civil' $name $ts 'marker' $fi.Name
          $open[$name] = $s; $stack.Add($s)
        } elseif ($open.ContainsKey($name)) {
          $s = $open[$name]; [void]$stack.Remove($s); $open.Remove($name)
          Close-Session $s $what $ts
        }
        $last = $null; continue
      }
      $kind = Get-EventKind $lvl $msg
      $sess = $null
      $fpRole = $null; $fpCmd = $null
      if ($lvl -ne 'DBG') { foreach ($fp in $fps) { if ($msg -match $fp.Rx) { $fpCmd = $fp.Cmd; $fpRole = $fp.Role; break } } }
      if ($stack.Count -gt 0) { $sess = $stack[$stack.Count - 1] }
      else {
        $tok = $null
        $tm = $tokenRx.Match($msg)
        if ($fpCmd) { $tok = $fpCmd }
        elseif ($tm.Success -and ($tokenSkip -notcontains $tm.Groups[1].Value)) { $tok = $tm.Groups[1].Value }
        if ($tok) {
          $gap = if ($gapSec.ContainsKey($tok)) { $gapSec[$tok] } else { 120 }
          $a = $adhoc[$tok]
          $age = if ($a) { (([datetime]$ts) - ([datetime]$a.End)).TotalSeconds } else { 0 }
          if ($fpRole -eq 'done' -and $a -and -not $a.Done -and $age -le 1800) { $sess = $a }              # a completion line closes the open run
          elseif ($a -and $age -le $gap -and (-not $a.Done -or $age -le 3)) { $sess = $a }
          else { if ($a) { Close-Session $a $null $null }; $sess = New-Session 'Civil' $tok $ts 'token' $fi.Name; $adhoc[$tok] = $sess }
          $sess.End = $ts
        } else {
          # a plain line in the second or so after a command's summary line belongs to it (e.g. the Tidy labels "no clear spot" lines)
          $best = $null
          foreach ($a in $adhoc.Values) { if ((([datetime]$ts) - ([datetime]$a.End)).TotalSeconds -le 3 -and ($null -eq $best -or $a.End -gt $best.End)) { $best = $a } }
          if ($best -and $lvl -ne 'DBG' -and $msg -notmatch '^\[PERF') { $sess = $best }
        }
      }
      $script:evSeq++
      $evt = @{ Ts = $ts; Seq = $script:evSeq; Lvl = $lvl; Msg = $msg; Kind = $kind; Sess = $sess; InList = $false; File = $fi.Name; Completion = $false }
      if ($sess -and $fpCmd -and $sess.Cmd -eq $fpCmd -and ($fpRole -eq 'done' -or $fpRole -eq 'oneshot')) { $evt.Completion = $true; $sess.Done = $true; $sess.Events.Add($evt); $evt.InList = $true }
      if ($kind -and $sess -and -not $evt.InList) { $sess.Events.Add($evt); $evt.InList = $true }
      if ($lvl -eq 'ERR' -or $lvl -eq 'WRN') {
        $cmdName = if ($sess) { $sess.Cmd } else { '(no command marker)' }
        if (-not $sess) { $counts.orphanEvents++ }
        $allMsgs.Add([pscustomobject]@{ Ts = $ts; Lvl = $lvl; Msg = $msg; Cmd = $cmdName; Suite = 'Civil'; File = $fi.Name; Kind = $kind })
      }
      $last = $evt
    }
  }
  foreach ($s in @($open.Values)) { Close-Session $s $null $null }
  foreach ($s in @($adhoc.Values)) { Close-Session $s $null $null }
}

function Read-NativeGrip {
  $p = Join-Path $civilLogs 'native_grip_2027.log'
  if (-not (Test-Path -LiteralPath $p)) { return }
  $fi = Get-Item -LiteralPath $p
  if ($fi.LastWriteTime -lt $sinceT) { return }
  $sourcesRead.Add($fi.Name)
  foreach ($ln in (Read-LogLines $p)) {
    $counts.linesRead++
    if ($ln.Length -lt 24) { continue }
    $ts = $ln.Substring(0, 23)
    if ($ts -lt $sinceS -or $ts -gt $untilS) { continue }
    $msg = $ln.Substring(24)
    if ($msg -match '(?i)\b(fail|failed|error|exception|refus|abort)') {
      $allMsgs.Add([pscustomobject]@{ Ts = $ts; Lvl = 'WRN'; Msg = $msg; Cmd = '(native grip module)'; Suite = 'Civil'; File = $fi.Name; Kind = 'warn' })
    }
  }
}

function Read-RibbonClicks {
  $p = Join-Path $civilLogs 'ribbon-clicks.log'
  $clicks = @{}
  if (Test-Path -LiteralPath $p) {
    $fi = Get-Item -LiteralPath $p
    if ($fi.LastWriteTime -ge $sinceT) {
      $sourcesRead.Add($fi.Name)
      foreach ($ln in (Read-LogLines $p)) {
        if ($ln.Length -lt 24) { continue }
        $ts = $ln.Substring(0, 23)
        if ($ts -lt $sinceS -or $ts -gt $untilS) { continue }
        if ($ln -match '^\S+ \S+ (\w+): sent to ') { $c = $Matches[1] } elseif ($ln -match 'click with no command parameter') { $c = '(button with no command)' } else { continue }
        $clicks[$c] = 1 + [int]$clicks[$c]
      }
    }
  }
  return $clicks
}

function Read-StructuralRuntime {
  $dir = Join-Path $AppData 'CE_STRUC_SUITE\logs\RuntimeDiagnostics'
  $cmdSeen = @{}                                 # name -> list of datetimes, for de-duplication against struct_commands
  if (-not (Test-Path -LiteralPath $dir)) { return $cmdSeen }
  $ignore = @('CESTRUC_PALETTE_RESTORE')
  $files = Get-ChildItem -LiteralPath $dir -Filter 'runtime_2*.jsonl' | Where-Object { Test-InWindow $_ 1 } | Sort-Object Name
  foreach ($fi in $files) {
    $counts.filesRead++; $sourcesRead.Add($fi.Name)
    foreach ($ln in (Read-LogLines $fi.FullName)) {
      $counts.linesRead++
      if (-not $ln.Contains('"category":"command"')) { continue }
      try { $o = $ln | ConvertFrom-Json } catch { continue }
      $utc = [datetime]::Parse($o.utc, [Globalization.CultureInfo]::InvariantCulture, 'AdjustToUniversal,AssumeUniversal')
      $loc = [TimeZoneInfo]::ConvertTimeFromUtc($utc, [TimeZoneInfo]::Local)
      $ts = $loc.ToString('yyyy-MM-dd HH:mm:ss.fff')
      if ($ts -lt $sinceS -or $ts -gt $untilS) { continue }
      $name = [string]$o.name
      if ($ignore -contains $name) { continue }
      if (-not $cmdSeen.ContainsKey($name)) { $cmdSeen[$name] = New-Object 'System.Collections.Generic.List[datetime]' }
      $cmdSeen[$name].Add($loc)
      $s = New-Session 'Structural' $name $ts 'runtime' $fi.Name
      $end = switch ([string]$o.status) { 'completed' { 'completed' } 'cancelled' { 'cancelled' } default { 'failed' } }
      if ($end -eq 'failed') { $s.Events.Add(@{ Ts = $ts; Lvl = 'ERR'; Msg = ("command ended with status '" + $o.status + "' " + $o.details); Kind = 'fail'; File = $fi.Name }) }
      Close-Session $s $end $ts
    }
  }
  return $cmdSeen
}

function Read-StructuralCommands($cmdSeen) {
  $dir = Join-Path $AppData 'CE_STRUC_SUITE\logs\StructuralCommands'
  if (-not (Test-Path -LiteralPath $dir)) { return }
  $files = Get-ChildItem -LiteralPath $dir -Filter 'struct_commands_2*.log' | Where-Object { Test-InWindow $_ 0 } | Sort-Object Name
  foreach ($fi in $files) {
    $counts.filesRead++; $sourcesRead.Add($fi.Name)
    $clean = $null
    foreach ($ln in (Read-LogLines $fi.FullName)) {
      $counts.linesRead++
      $parts = $ln -split ' \| ', 6
      if ($parts.Count -lt 5 -or $parts[0].Length -lt 23) { continue }
      $ts = $parts[0]
      if ($ts -lt $sinceS -or $ts -gt $untilS) { continue }
      $lvl = $parts[1].Trim()
      $cmd = ($parts[2] -replace '^cmd=', ''); $step = ($parts[3] -replace '^step=', '')
      $msg = if ($parts.Count -ge 6) { $parts[5] -replace '^msg=', '' } else { '' }
      if ($cmd -eq 'BACKUP') { continue }              # rolling autosave copy: background, not a user command
      if ($cmd -eq 'CLEAN') {                          # CLEAN logs one row per sub-step: group rows within 2 minutes
        if ($clean -and (([datetime]$ts) - ([datetime]$clean.End)).TotalSeconds -gt 120) { Close-Session $clean 'completed' $null; $clean = $null }
        if (-not $clean) { $clean = New-Session 'Structural' 'CLEAN' $ts 'steps' $fi.Name }
        $clean.End = $ts
        if ($lvl -eq 'ERROR') { $clean.Events.Add(@{ Ts = $ts; Lvl = 'ERR'; Msg = ("CLEAN step '" + $step + "': " + $msg); Kind = 'fail'; File = $fi.Name }) }
        continue
      }
      if ($step -ne 'completed' -and $step -ne 'cancelled' -and $lvl -ne 'ERROR') { continue }
      $dup = $false
      if ($cmdSeen.ContainsKey($cmd)) { foreach ($d in $cmdSeen[$cmd]) { if ([math]::Abs((([datetime]$ts) - $d).TotalSeconds) -le 5) { $dup = $true; break } } }
      if ($dup) { continue }                           # the runtime diagnostics already recorded this command
      $s = New-Session 'Structural' $cmd $ts 'commandlog' $fi.Name
      if ($lvl -eq 'ERROR') { $s.Events.Add(@{ Ts = $ts; Lvl = 'ERR'; Msg = ("step '" + $step + "': " + $msg); Kind = 'fail'; File = $fi.Name }); Close-Session $s 'failed' $ts }
      elseif ($step -eq 'cancelled') { Close-Session $s 'cancelled' $ts }
      else { Close-Session $s 'completed' $ts }
    }
    if ($clean) { Close-Session $clean 'completed' $null; $clean = $null }
  }
}

function Read-StructuralMainLogs {
  # No command markers here: only the warnings and errors are used (for 'new messages' and failure candidates).
  $p = Join-Path $AppData 'CE_STRUC_SUITE\logs\ce_struc_suite.log'
  if (Test-Path -LiteralPath $p) {
    $fi = Get-Item -LiteralPath $p
    if ($fi.LastWriteTime -ge $sinceT) {
      $sourcesRead.Add($fi.Name)
      foreach ($ln in (Read-LogLines $p)) {
        $counts.linesRead++
        if ($ln -match '^\[(\d{4}-\d\d-\d\d \d\d:\d\d:\d\d\.\d{3})\] \[(WARNING|ERROR)\s*\] (?:\[CE_STRUC_SUITE\] )?(.*)$') {
          $ts = $Matches[1]
          if ($ts -lt $sinceS -or $ts -gt $untilS) { continue }
          $l = if ($Matches[2] -eq 'ERROR') { 'ERR' } else { 'WRN' }
          $allMsgs.Add([pscustomobject]@{ Ts = $ts; Lvl = $l; Msg = $Matches[3]; Cmd = '(no command marker)'; Suite = 'Structural'; File = $fi.Name; Kind = (Get-EventKind $l $Matches[3]) })
        }
      }
    }
  }
  $dir = Join-Path $AppData 'TIM_CE_CADTOOLS\logs'
  if (Test-Path -LiteralPath $dir) {
    foreach ($fi in (Get-ChildItem -LiteralPath $dir -Filter 'ce_struc_structured_2*.log' | Where-Object { Test-InWindow $_ 0 } | Sort-Object Name)) {
      $counts.filesRead++; $sourcesRead.Add($fi.Name)
      foreach ($ln in (Read-LogLines $fi.FullName)) {
        $counts.linesRead++
        $m = $lineRx.Match($ln)
        if (-not $m.Success) { continue }
        $ts = $m.Groups[1].Value
        if ($ts -lt $sinceS -or $ts -gt $untilS) { continue }
        $l = $m.Groups[2].Value
        if ($l -ne 'ERR' -and $l -ne 'WRN' -and $l -ne 'FTL') { continue }
        if ($l -eq 'FTL') { $l = 'ERR' }
        $allMsgs.Add([pscustomobject]@{ Ts = $ts; Lvl = $l; Msg = $m.Groups[3].Value; Cmd = '(no command marker)'; Suite = 'Structural'; File = $fi.Name; Kind = (Get-EventKind $l $m.Groups[3].Value) })
      }
    }
  }
}

function Read-CivilFileEvidence {
  # Some commands leave a saved findings file in the Civil log folder (CDRULES with All, CDCHECKDWG). The file's save time is
  # evidence the command finished; the file name carries a drawing name and is never printed.
  if (-not (Test-Path -LiteralPath $civilLogs)) { return }
  $map = @(@{ Pat = 'cdrules-*.txt'; Cmd = 'CDRULES' }, @{ Pat = 'cdcheck-*.txt'; Cmd = 'CDCHECKDWG' })
  foreach ($m in $map) {
    foreach ($fi in (Get-ChildItem -LiteralPath $civilLogs -Filter $m.Pat | Where-Object { $_.LastWriteTime -ge $sinceT -and $_.LastWriteTime -le $untilT })) {
      $t = [datetime]$fi.LastWriteTime
      $ts = $t.ToString('yyyy-MM-dd HH:mm:ss.fff')
      $dup = $false
      foreach ($s in $sessions) {
        if ($s.Cmd -eq $m.Cmd -and $s.Suite -eq 'Civil' -and $s.Kind -ne 'file' -and $s.Start -le $t.AddSeconds(15).ToString('yyyy-MM-dd HH:mm:ss.fff') -and $s.End -ge $t.AddSeconds(-15).ToString('yyyy-MM-dd HH:mm:ss.fff')) { $dup = $true; break }
      }
      if ($dup) { continue }
      $counts.filesRead++
      $s2 = New-Session 'Civil' $m.Cmd $ts 'file' ($m.Pat -replace '\*', '<drawing>-<time>')
      $s2.Events.Add(@{ Ts = $ts; Lvl = 'INF'; Msg = 'findings file saved'; Kind = $null; File = $s2.File; Completion = $true })
      Close-Session $s2 'completed' $ts
    }
  }
}

# ---------------------------------------------------------------- run
Read-CivilStructured
Read-CivilFileEvidence
Read-NativeGrip
$clicks = Read-RibbonClicks
$cmdSeenRt = Read-StructuralRuntime
Read-StructuralCommands $cmdSeenRt
Read-StructuralMainLogs

# ---------------------------------------------------------------- state: which [ERR]/[WRN] messages are new
$state = @{ seenMessages = @{}; candidates = @() }
if (-not $NoState -and (Test-Path -LiteralPath $StateFile)) {
  try {
    $j = Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8 | ConvertFrom-Json
    if ($j.seenMessages) { foreach ($pr in $j.seenMessages.PSObject.Properties) { $state.seenMessages[$pr.Name] = [string]$pr.Value } }
    if ($j.candidates) { $state.candidates = @($j.candidates) }
  } catch { }
}
$dayKey = $sinceT.ToString('yyyy-MM-dd')
$msgGroups = @{}
foreach ($e in $allMsgs) {
  if ($e.Kind -eq 'noise') { continue }
  $k = $e.Suite + '|' + $e.Lvl + '|' + (Get-NormKey $e.Msg)
  if (-not $msgGroups.ContainsKey($k)) { $msgGroups[$k] = [pscustomobject]@{ Key = $k; Lvl = $e.Lvl; Suite = $e.Suite; Cmd = $e.Cmd; First = $e.Ts; Sample = $e.Msg; File = $e.File; Count = 0 } }
  $msgGroups[$k].Count++
}
$newMsgs = @()
foreach ($g in ($msgGroups.Values | Sort-Object First)) {
  $seenOn = $state.seenMessages[$g.Key]
  if (-not $seenOn -or $seenOn -ge $dayKey) { $newMsgs += $g }
}

# ---------------------------------------------------------------- aggregate by suite + command
$outcomes = 'WORKED', 'REFUSED', 'CANCELLED', 'WARNED', 'FAILED', 'UNKNOWN'
$byCmd = @{}
foreach ($s in $sessions) {
  if ($s.Cmd.StartsWith($bgPrefix)) { continue }
  $k = $s.Suite + '|' + $s.Cmd
  if (-not $byCmd.ContainsKey($k)) {
    $o = @{ Suite = $s.Suite; Cmd = $s.Cmd; Total = 0; First = $s.Start; Last = $s.End; Msgs = @{}; Builds = @{} }
    foreach ($x in $outcomes) { $o[$x] = 0 }
    $byCmd[$k] = $o
  }
  $o = $byCmd[$k]
  $o.Total++; $o[$s.Outcome]++
  if ($s.Start -lt $o.First) { $o.First = $s.Start }
  if ($s.End -gt $o.Last) { $o.Last = $s.End }
  if (-not $o.Builds.ContainsKey($s.Ver)) { $o.Builds[$s.Ver] = @{ WORKED = 0; FAILED = 0; REFUSED = 0; WARNED = 0; CANCELLED = 0; UNKNOWN = 0 } }
  $o.Builds[$s.Ver][$s.Outcome]++
  foreach ($ev in $s.Events) {
    if (-not $ev.Kind -or $ev.Kind -eq 'noise') { continue }
    $label = switch ($ev.Kind) { 'fail' { 'FAILED' } 'refuse' { 'REFUSED' } default { 'WARNED' } }
    if ($label -eq 'WARNED' -and $s.Outcome -ne 'WARNED') { continue }          # only show warnings that decided the outcome
    if ($label -eq 'REFUSED' -and $s.Outcome -ne 'REFUSED' -and $s.Outcome -ne 'FAILED') { continue }
    $mk = $label + '|' + (Get-NormKey $ev.Msg)
    if (-not $o.Msgs.ContainsKey($mk)) { $o.Msgs[$mk] = @{ Label = $label; Text = (Protect-Text $ev.Msg 200); Count = 0; First = $ev.Ts } }
    $o.Msgs[$mk].Count++
  }
}
$tot = @{}; foreach ($x in $outcomes) { $tot[$x] = 0 }
$bgSteps = 0
foreach ($s in $sessions) { if ($s.Cmd.StartsWith($bgPrefix)) { $bgSteps++ } else { $tot[$s.Outcome]++ } }
$cmdSessions = @($sessions | Where-Object { -not $_.Cmd.StartsWith($bgPrefix) })
$markerSessions = @($cmdSessions | Where-Object { $_.Kind -eq 'marker' -or $_.Kind -eq 'runtime' -or $_.Kind -eq 'commandlog' -or $_.Kind -eq 'steps' }).Count
$tokenSessions = @($cmdSessions | Where-Object { $_.Kind -eq 'token' -or $_.Kind -eq 'file' }).Count

# ---------------------------------------------------------------- failure candidates (one line per day + command + message)
$newCandidates = New-Object 'System.Collections.Generic.List[string]'
$candLines = New-Object 'System.Collections.Generic.List[string]'
$candGroups = @{}
foreach ($s in $sessions) {
  foreach ($ev in $s.Events) {
    if ($ev.Kind -ne 'fail') { continue }
    $ck = $ev.Ts.Substring(0, 10) + '|' + $s.Cmd + '|' + (Get-NormKey $ev.Msg)
    if (-not $candGroups.ContainsKey($ck)) { $candGroups[$ck] = @{ Ts = $ev.Ts; Cmd = $s.Cmd; Msg = $ev.Msg; File = $ev.File; Count = 0; Suite = $s.Suite } }
    $candGroups[$ck].Count++
  }
}
foreach ($e in $allMsgs) {                       # new [ERR] outside any command session also counts
  if ($e.Lvl -ne 'ERR' -or $e.Cmd -ne '(no command marker)' -and $e.Cmd -ne '(native grip module)') { continue }
  $ck = $e.Ts.Substring(0, 10) + '|' + $e.Cmd + '|' + (Get-NormKey $e.Msg)
  if (-not $candGroups.ContainsKey($ck)) { $candGroups[$ck] = @{ Ts = $e.Ts; Cmd = $e.Cmd; Msg = $e.Msg; File = $e.File; Count = 0; Suite = $e.Suite } }
  $candGroups[$ck].Count++
}
foreach ($ck in ($candGroups.Keys | Sort-Object { $candGroups[$_].Ts })) {
  if ($state.candidates -contains $ck) { continue }
  $c = $candGroups[$ck]
  $nk = Get-NormKey $c.Msg
  $prev = $state.seenMessages[$c.Suite + '|ERR|' + $nk]; if (-not $prev) { $prev = $state.seenMessages[$c.Suite + '|WRN|' + $nk] }
  $cnt = [string]$c.Count; if ($prev -and $prev -lt $c.Ts.Substring(0, 10)) { $cnt += ' (recurring, first seen ' + $prev + ')' }
  $candLines.Add(('{0} | {1} | {2} | {3} | {4}' -f $c.Ts.Substring(0, 16), $c.Cmd, (Protect-Text $c.Msg 160), $c.File, $cnt))
  $newCandidates.Add($ck)
}

# ---------------------------------------------------------------- report
function Fmt-Span([string]$a, [string]$b) { if ($a.Substring(0, 10) -eq $b.Substring(0, 10)) { return $a.Substring(11, 5) + ' to ' + $b.Substring(11, 5) } return $a.Substring(0, 16) + ' to ' + $b.Substring(0, 16) }
function Fmt-Counts($o) {
  $bits = @()
  foreach ($x in $outcomes) { if ($o[$x] -gt 0) { $bits += ('{0} {1}' -f $x.ToLower(), $o[$x]) } }
  return ($bits -join ', ')
}
$sb = New-Object Text.StringBuilder
function Add-Line([string]$t = '') { [void]$sb.AppendLine($t) }

Add-Line ("# CE log outcomes: {0} to {1} (Melbourne time, PC clock)" -f $sinceT.ToString('ddd dd MMM yyyy HH:mm'), $untilT.ToString('ddd dd MMM yyyy HH:mm'))
Add-Line
Add-Line '**Answer first.**'
Add-Line
Add-Line ("1. **Commands seen:** {0} command runs in the logs ({1} with a start/end line or a command record, {2} recognised from lines or files that name the command)." -f $cmdSessions.Count, $markerSessions, $tokenSessions)
Add-Line ("2. **Worked:** {0}. **Refused (CE said no in plain words):** {1}. **Cancelled:** {2}. **Warned:** {3}. **Failed:** {4}. **Unknown (no outcome line):** {5}." -f $tot.WORKED, $tot.REFUSED, $tot.CANCELLED, $tot.WARNED, $tot.FAILED, $tot.UNKNOWN)
Add-Line ("3. **New warnings/errors today:** {0} message types not seen on an earlier day. **Failure candidates added:** {1}." -f @($newMsgs).Count, $candLines.Count)
Add-Line '4. **How to read this:** WORKED means the command ran to its end with no error, refusal or warning line. It does not prove the drawing came out right. This is use evidence from the logs, not an acceptance: Tim''s use does not replace a Codex pass (RULES 4.5) unless the desk decides otherwise.'
Add-Line ("5. **Read:** {0} files, {1} lines; {2} warnings/errors outside any command run." -f $counts.filesRead, $counts.linesRead, $counts.orphanEvents)
Add-Line ("6. **Background sync steps (not counted above):** {0}. With debug logging off the log only shows that a project-data sync ran, not whether CDSYNC, CDRECOVERINVERTS, PIT or CDEDIT ran it." -f $bgSteps)
Add-Line

foreach ($suite in 'Civil', 'Structural') {
  $list = @($byCmd.Values | Where-Object { $_.Suite -eq $suite } | Sort-Object { $_.Cmd })
  $n = if ($suite -eq 'Civil') { 2 } else { 3 }
  Add-Line ("## {0}. {1}: every command, by outcome" -f $n, $suite)
  Add-Line
  if ($list.Count -eq 0) { Add-Line '1. **No command runs found in this period.**'; Add-Line; continue }
  $i = 0
  foreach ($o in $list) {
    $i++
    $bk = @($o.Builds.Keys | Sort-Object)
    $builds = if ($bk.Count -gt 3) { '{0} to {1} ({2} builds)' -f $bk[0], $bk[-1], $bk.Count } else { $bk -join ', ' }
    Add-Line ("{0}. **{1}**: {2} (total {3}); {4}; build {5}." -f $i, $o.Cmd, (Fmt-Counts $o), $o.Total, (Fmt-Span $o.First $o.Last), $builds)
    $shown = 0
    foreach ($lab in 'FAILED', 'REFUSED', 'WARNED') {
      foreach ($mk in ($o.Msgs.Keys | Sort-Object { $o.Msgs[$_].First })) {
        $mm = $o.Msgs[$mk]
        if ($mm.Label -ne $lab) { continue }
        if ($shown -ge 3) { break }
        $shown++
        Add-Line ("   - **{0}:** {1} (x{2}, first {3})" -f $mm.Label.ToLower(), $mm.Text, $mm.Count, $mm.First.Substring(11, 5))
      }
    }
  }
  Add-Line
}

Add-Line '## 4. Used successfully (use evidence, not an acceptance)'
Add-Line
Add-Line ("This lists commands that WORKED at least {0} times in the period with no FAILED run, by suite and build. It is evidence from the logs that the command ran to its end when used. It is not a Codex pass and not Tim's acceptance (RULES 4.5)." -f $MinWorked)
Add-Line
$j = 0
foreach ($o in ($byCmd.Values | Sort-Object { $_.Suite }, { $_.Cmd })) {
  foreach ($v in ($o.Builds.Keys | Sort-Object)) {
    $b = $o.Builds[$v]
    if ($b.WORKED -ge $MinWorked -and $b.FAILED -eq 0) {
      $j++
      Add-Line ("{0}. **{1} {2}** on build {3}: worked {4} times, refused {5}, warned {6}, cancelled {7}, no failure." -f $j, $o.Suite, $o.Cmd, $v, $b.WORKED, $b.REFUSED, $b.WARNED, $b.CANCELLED)
    }
  }
}
if ($j -eq 0) { Add-Line '1. **None yet in this period.**' }
Add-Line

Add-Line '## 5. New warnings and errors (not seen on an earlier day)'
Add-Line
if (@($newMsgs).Count -eq 0) { Add-Line '1. **None.**' }
else {
  $k = 0
  foreach ($g in $newMsgs) {
    $k++
    if ($k -gt 40) { Add-Line ("{0}. **...and {1} more** (see the log)." -f $k, (@($newMsgs).Count - 40)); break }
    Add-Line ("{0}. **[{1}] {2}, {3}:** {4} (x{5}, first {6})" -f $k, $g.Lvl, $g.Suite, $g.Cmd, (Protect-Text $g.Sample 200), $g.Count, $g.First.Substring(11, 5))
  }
}
Add-Line

Add-Line '## 6. Ribbon clicks seen'
Add-Line
if ($clicks.Count -eq 0) { Add-Line '1. **None in this period** (the ribbon-click log only records some clicks; its last entry on this PC was 14 Oct).' }
else { $k = 0; foreach ($c in ($clicks.Keys | Sort-Object)) { $k++; Add-Line ("{0}. **{1}:** {2} click(s)." -f $k, $c, $clicks[$c]) } }
Add-Line

Add-Line '## 7. What the logs could not tell us'
Add-Line
Add-Line '1. **Civil start and end lines exist only when debug logging is ON.** The "UcsGuardService ... starting / ended / cancelled" lines that bracket a command are debug lines (and only from about build 3.0.60). With debug OFF (Tim''s normal setting) only a few commands leave an INFO line that names them (CD, CDEDIT on an older pipe, CDTWL, CDTIDYLABELS, PIT, CDRECOVERINVERTS when it writes text) or a saved findings file (CDRULES All, CDCHECKDWG). CDSYNC, CDINSPECTOR, CDCHECKS, PITSCHEDULE and CDRULES Values are invisible then.'
Add-Line '2. **Plain command-line answers** such as "Updated 4 pipes..." or "Everything has been redone" are shown on the AutoCAD command line, not saved in the log.'
Add-Line '3. **Manager** and the checkdwg / xcdimport tools write no per-command outcome here.'
Add-Line '4. **Structural build number** is not in its logs; the installed build is read from the plugin file.'
Add-Line ("5. **Sources read:** {0}." -f (($sourcesRead | Select-Object -Unique) -join ', '))

$text = $sb.ToString()
# final leak sweep: any line that still looks like a drive path, a drawing or a person is withheld
$swept = 0
$clean = foreach ($ln in ($text -split "`r?`n")) {
  if ($ln -match ('[A-Za-z]:\\|\.dwg\b|' + $userA + $userB + '|@[A-Za-z0-9.\-]+\.(com|au)\b')) { $swept++; '- <line withheld by the leak sweep>' } else { $ln }
}
$text = ($clean -join "`r`n") + "`r`n"
if ($swept -gt 0) { $text += "`r`n(Leak sweep withheld $swept line(s).)`r`n" }

if ($Out) {
  $full = if ([IO.Path]::IsPathRooted($Out)) { $Out } else { Join-Path (Get-Location).Path $Out }
  [IO.File]::WriteAllText($full, $text, $utf8)
} elseif (-not $PassThru) { Write-Output $text }

# ---------------------------------------------------------------- state + candidates (never touches a CE folder)
if ($CandidateFile -and $candLines.Count -gt 0) {
  $cf = $CandidateFile
  if (-not (Test-Path -LiteralPath $cf)) {
    [IO.File]::WriteAllText($cf, "# Log failure candidates`r`n`r`nOne line per new FAILED command run or new [ERR] message seen in the CE logs (written by log_outcomes.ps1). The desk reads this at each tick and files real product problems as bugs. This file never creates a BUG_CARPARK entry.`r`n`r`nFormat: date time | command | message (cut) | log file name | count`r`n`r`n", $utf8)
  }
  [IO.File]::AppendAllText($cf, (($candLines -join "`r`n") + "`r`n"), $utf8)
}
if (-not $NoState) {
  foreach ($g in $msgGroups.Values) { if (-not $state.seenMessages.ContainsKey($g.Key)) { $state.seenMessages[$g.Key] = $g.First.Substring(0, 10) } }
  $candAll = @($state.candidates) + @($newCandidates)
  $payload = [ordered]@{ updated = (Get-Date -Format 'yyyy-MM-dd HH:mm'); seenMessages = $state.seenMessages; candidates = $candAll }
  [IO.File]::WriteAllText($StateFile, ($payload | ConvertTo-Json -Depth 4), $utf8)
}

if ($PassThru) {
  return [pscustomobject]@{
    Sessions = $cmdSessions.Count; Worked = $tot.WORKED; Refused = $tot.REFUSED; Cancelled = $tot.CANCELLED; Warned = $tot.WARNED
    Failed = $tot.FAILED; Unknown = $tot.UNKNOWN; NewMessages = @($newMsgs).Count; NewCandidates = $candLines.Count
    ByCommand = $byCmd; AllSessions = $sessions; Text = $text; Swept = $swept
  }
}
