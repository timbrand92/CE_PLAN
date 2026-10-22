# Applies the status-line replacements from areas\CARPARK_RECONCILIATION_2026-10-22.md to BUG_CARPARK.md.
# Usage: apply_reconciliation.ps1 -Target <path to BUG_CARPARK.md> [-DryRun]   (DryRun: reports only, writes nothing)
# Only a line that begins '**Status:**' and matches the old line character for character is replaced.
# Entries BUG-873 and later are never touched. Inserts ("no status line") and non-status old lines are skipped.
param(
    [string]$Target = 'C:\CE_PLAN\BUG_CARPARK.md',
    [string]$Recon = 'C:\CE_PLAN\areas\CARPARK_RECONCILIATION_2026-10-22.md',
    [switch]$DryRun
)
$ErrorActionPreference = 'Stop'
$utf8 = New-Object System.Text.UTF8Encoding($false)

# 1. parse the replacement list (section 4: '@@ BUG-NNN (...)', then '- old', then '+ new')
$rl = [IO.File]::ReadAllLines($Recon, $utf8)
$start = [Array]::FindIndex($rl, [Predicate[string]]{ param($l) $l -like '## 4. Ready-to-apply*' })
if ($start -lt 0) { throw 'Section 4 not found: format ambiguous, stopping.' }
$reps = @()
for ($i = $start; $i -lt $rl.Length; $i++) {
    if ($rl[$i] -like '## 5.*') { break }
    if ($rl[$i] -match '^@@ BUG-(\d+) ') {
        $old = $rl[$i + 1]; $new = $rl[$i + 2]
        if (-not ($old.StartsWith('- ') -and $new.StartsWith('+ '))) { throw "Format ambiguous at line $($i+1): stopping." }
        $reps += [pscustomobject]@{ Id = [int]$Matches[1]; Old = $old.Substring(2); New = $new.Substring(2) }
    }
}
Write-Output "Parsed $($reps.Count) replacements"

# 2. apply
$text = [IO.File]::ReadAllText($Target, $utf8)
$nl = if ($text.Contains("`r`n")) { "`r`n" } else { "`n" }
$lines = [regex]::Split($text, '\r?\n')
$applied = @(); $skipped = @()
foreach ($r in $reps) {
    $idStr = '{0:D3}' -f $r.Id
    if ($r.Id -ge 873) { $skipped += "BUG-$idStr (873 or later: not touched)"; continue }
    if (-not $r.Old.StartsWith('**Status:**')) { $skipped += "BUG-$idStr (old line is not a Status line / no status line: not changed)"; continue }
    $heads = @(for ($i = 0; $i -lt $lines.Length; $i++) { if ($lines[$i] -match "^## BUG-$idStr(\D|$)") { $i } })
    if ($heads.Count -ne 1) { $skipped += "BUG-$idStr ($($heads.Count) headings: ambiguous, re-check)"; continue }
    $h = $heads[0]; $hit = -1
    for ($j = $h + 1; $j -lt $lines.Length; $j++) {
        if ($lines[$j] -like '## *') { break }
        if ($lines[$j].StartsWith('**Status:**')) { $hit = $j; break }
    }
    if ($hit -lt 0) { $skipped += "BUG-$idStr (no status line found)"; continue }
    if ($lines[$hit] -cne $r.Old) { $skipped += "BUG-$idStr (changed since: re-check)"; continue }
    if (-not $r.New.StartsWith('**Status:**')) { $skipped += "BUG-$idStr (new line is not a Status line)"; continue }
    $lines[$hit] = $r.New
    $applied += "BUG-$idStr"
}
Write-Output "Applied $($applied.Count); skipped $($skipped.Count)"
$skipped | ForEach-Object { Write-Output "  SKIP $_" }
if ($DryRun) { Write-Output 'DRY RUN: nothing written'; return }

# 3. write
[IO.File]::WriteAllText($Target, ($lines -join $nl), $utf8)
Write-Output "Written $Target"
