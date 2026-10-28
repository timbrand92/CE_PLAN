<#
  ce_log_evidence.ps1  (desk tool, 29 Oct 2026)  READ ONLY.
  Answers: which everyday CE tools show up in Tim's real CE logs since a date, how often, when last,
  and which lines look like refusals or failures. Signatures live in ce_log_signatures.json.
  Never writes to a CE folder, never deletes, no network, starts nothing.
  Run:  pwsh -NoProfile -File C:\CE_PLAN\desk_jobs\ce_log_evidence.ps1 -Since 2026-10-26
  Optional: -Out <file> (writes the report text there), -IncludeRobotFailures (failure list for every session).
  What a log line proves: the command ran and CE printed that sentence. It does not prove the drawing looks right.
  Classes: tim = a drawing session that is not a robot copy and not in a known Codex window;
           codex = inside a knownNonTimWindows entry; robot = robot copies (CLDV.. / DRV..) and blank Drawing1 starts.
#>
param(
  [datetime]$Since = '2026-10-26',
  [string]$Signatures = (Join-Path $PSScriptRoot 'ce_log_signatures.json'),
  [string]$Out,
  [switch]$IncludeRobotFailures
)
$ErrorActionPreference = 'Stop'
$sig = Get-Content -Raw -LiteralPath $Signatures | ConvertFrom-Json
$sinceS = $Since.ToString('yyyy-MM-dd HH:mm:ss')
$robotRx = [regex]::new($sig.robotSessionNames); $blankRx = [regex]::new($sig.blankSessionNames)
$wins = @($sig.knownNonTimWindows | ForEach-Object { [pscustomobject]@{ f = $_.from; t = $_.to } })
$ign = [regex]::new('(' + (($sig.ignoreLines | ForEach-Object { [regex]::Escape($_) }) -join '|') + ')')
$cls3 = 'tim', 'codex', 'robot'

# compile signatures
$tools = foreach ($t in $sig.tools) {
  $o = [pscustomobject]@{ T = $t; Rx = @{}; N = @{}; New = @{} }
  foreach ($k in 'ran', 'did', 'weak') {
    $o.Rx[$k] = @($t.$k | Where-Object { $_ } | ForEach-Object { [regex]::new($_) })
    foreach ($c in $cls3) { $o.N["$k|$c"] = 0; $o.New["$k|$c"] = '' }
  }
  $o
}
$failRx = @($sig.failPatterns | ForEach-Object { [pscustomobject]@{ Tool = $_.tool; Rx = [regex]::new($_.pattern) } })
$allPat = @($sig.tools | ForEach-Object { $_.ran; $_.did; $_.weak } | Where-Object { $_ }) + @($sig.failPatterns | ForEach-Object { $_.pattern }) + 'JobTime: session created', 'v[\d.]+ Started$'
$pre = [regex]::new('(' + ($allPat -join ')|(') + ')', 'Compiled')
$fails = @{}; $sw = [System.Collections.Generic.List[object]]::new(); $spans = @{}
$srcInfo = [System.Collections.Generic.List[string]]::new()

function ClassOf([string]$sess, [string]$ts) {
  if ($sess -ne 'other') { return 'robot' }
  $m = $ts.Substring(0, 16)
  foreach ($w in $wins) { if ([string]::CompareOrdinal($m, $w.f) -ge 0 -and [string]::CompareOrdinal($m, $w.t) -le 0) { return 'codex' } }
  'tim'
}
function Score([string]$line, [string]$ts, [string]$cls) {
  foreach ($o in $tools) { foreach ($k in 'ran', 'did', 'weak') { foreach ($r in $o.Rx[$k]) { if ($r.IsMatch($line)) {
    $o.N["$k|$cls"]++; if ([string]::CompareOrdinal($ts, $o.New["$k|$cls"]) -gt 0) { $o.New["$k|$cls"] = $ts }; break } } } }
  if ($cls -eq 'tim' -or $IncludeRobotFailures) {
    if (-not $ign.IsMatch($line)) { foreach ($f in $failRx) { if ($f.Rx.IsMatch($line)) {
      $txt = $line.Substring(24) -replace '[A-Za-z]:\\\S+', '<path>' -replace '\b[0-9A-F]{5,8}\b', '#' -replace '\d+(\.\d+)?', '#'
      $key = "$cls|$txt"
      if (-not $fails.ContainsKey($key)) { $fails[$key] = [pscustomobject]@{ Cls = $cls; Tool = $f.Tool; N = 0; Newest = ''; Sample = ($line.Substring(24) -replace '[A-Za-z]:\\\S+', '<path>') } }
      $fails[$key].N++; $fails[$key].Newest = $ts; break } } }
  }
}
function Scan([string]$path, [bool]$civil) {
  $fs = [IO.File]::Open($path, 'Open', 'Read', 'ReadWrite'); $sr = [IO.StreamReader]::new($fs)
  $sess = 'blank'; $first = ''; $last = ''
  try { while ($null -ne ($l = $sr.ReadLine())) {
    if ($l.Length -lt 30 -or $l[4] -ne '-') { continue }
    $ts = $l.Substring(0, 19); if ($first -eq '') { $first = $ts }; $last = $ts
    if ($civil) {
      if ($l.EndsWith(' Started')) { $sess = 'blank'; $sw.Add([pscustomobject]@{ T = $ts; S = $sess }) }
      elseif ($l.Contains('JobTime: session created')) {
        $nm = ($l -replace '^.*session created\s+\S+\s+', '') -replace '\s+\(ID [0-9a-f]+\)\s*$', ''
        $sess = if ($robotRx.IsMatch($nm)) { 'robot' } elseif ($blankRx.IsMatch($nm)) { 'blank' } else { 'other' }
        $sw.Add([pscustomobject]@{ T = $ts; S = $sess })
      }
      $s = $sess
    } else { $s = 'blank'; for ($i = $sw.Count - 1; $i -ge 0; $i--) { if ([string]::CompareOrdinal($sw[$i].T, $ts) -le 0) { $s = $sw[$i].S; break } } }
    if ([string]::CompareOrdinal($ts, $sinceS) -lt 0 -or -not $pre.IsMatch($l)) { continue }
    Score $l $ts (ClassOf $s $ts)
  } } finally { $sr.Dispose() }
  $srcInfo.Add("$([IO.Path]::GetFileName($path)): lines run from $first to $last")
}
$app = $env:APPDATA
foreach ($f in (Get-ChildItem -LiteralPath "$app\CE_CVL_SUITE\logs" -Filter 'CE_CVL_SUITE.log*' | Sort-Object LastWriteTime)) { Scan $f.FullName $true }
foreach ($f in (Get-ChildItem -LiteralPath "$app\CE_SUITE_MANAGER\logs" -Filter 'ce_manager_structured_*.log' -ErrorAction SilentlyContinue | Sort-Object Name)) { Scan $f.FullName $false }

# session summary (Tim-class sessions listed by time only, never by drawing name)
$r = [System.Collections.Generic.List[string]]::new()
$r.Add("CE LOG EVIDENCE   since $sinceS   (log clock = this PC, Melbourne)   run $(Get-Date -Format 'yyyy-MM-dd HH:mm')")
$r.Add('Sources read (read only):'); $srcInfo | ForEach-Object { $r.Add("  $_") }
$r.Add('Tim-class sessions (drawing opened that is not a robot copy, outside known Codex windows):')
$n = 0; foreach ($e in $sw) { if ($e.S -eq 'other' -and [string]::CompareOrdinal($e.T, $sinceS) -ge 0 -and (ClassOf 'other' $e.T) -eq 'tim') { $r.Add("  opened $($e.T)"); $n++ } }
if ($n -eq 0) { $r.Add('  none in the logs since that date') }
$r.Add(''); $r.Add('PER TOOL (counts are log lines that match; Tim = his own sessions, Codex = known Codex windows, Robot = robot copies and blank starts)')
$r.Add('ran = the command ended (for a silent tool: the command it lives inside ended). did = CE logged a sentence showing what it did. weak = indirect hint only.')
foreach ($o in $tools) {
  $t = $o.T; $parts = foreach ($c in $cls3) {
    $x = foreach ($k in 'ran', 'did', 'weak') { if ($o.Rx[$k].Count) { "$k=$($o.N["$k|$c"])" } }
    $nw = ($o.New.Keys | Where-Object { $_.EndsWith("|$c") } | ForEach-Object { $o.New[$_] } | Sort-Object -Descending | Select-Object -First 1)
    "{0}: {1}{2}" -f $c, ($x -join ' '), $(if ($nw) { " newest $($nw.Substring(0,16))" } else { '' })
  }
  $r.Add(("{0,-5} {1}" -f $t.id, $t.name)); $r.Add("      " + ($parts -join '  |  ') + "  |  silent in log: $($t.silent)")
  if ($t.silentWhat) { $r.Add("      note: $($t.silentWhat)") }
  foreach ($fe in @($t.files)) { if ($fe) {
    $d = [Environment]::ExpandEnvironmentVariables($fe.dir)
    $fl = @(Get-ChildItem -LiteralPath $d -Filter $fe.filter -ErrorAction SilentlyContinue | Where-Object { $_.LastWriteTime -ge $Since } | Sort-Object LastWriteTime)
    $r.Add("      file evidence ($($fe.label)): $($fl.Count) file(s) since the date" + $(if ($fl.Count) { ", newest $($fl[-1].LastWriteTime.ToString('yyyy-MM-dd HH:mm'))" } else { '' })) } }
}
$r.Add(''); $r.Add($(if ($IncludeRobotFailures) { 'REFUSAL / FAILURE-LOOKING LINES (all sessions, grouped by shape)' } else { 'REFUSAL / FAILURE-LOOKING LINES in Tim-class sessions (grouped by shape; drawing paths masked)' }))
if ($fails.Count -eq 0) { $r.Add('  none') }
foreach ($f in ($fails.Values | Sort-Object Newest -Descending)) { $s = $f.Sample; if ($s.Length -gt 230) { $s = $s.Substring(0, 230) + '...' }
  $r.Add("  [$($f.Cls)] x$($f.N) newest $($f.Newest.Substring(0,16)) ($($f.Tool)): $s") }
$r.Add(''); $r.Add('A log line proves the command ran and CE printed that sentence. It does not prove the drawing looks right, and it is not Tim acceptance.')
$txt = $r -join "`r`n"
if ($Out) { Set-Content -LiteralPath $Out -Value $txt -Encoding UTF8 }
$txt
