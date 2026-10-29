<#
Lunch-window helper (Desk 29 Oct 2026, CE_ACAD / robot / build / 23).
Tim, Thu 29 Oct 2026: "if autocad is open at 2pm you need to save everything and close it during lunch then reopen everything at 3pm as it was".

Amendment 1 (CE_ACAD / robot / build / 24), Tim, Thu 29 Oct 2026: "same thing with 5:30pm except with both those times, check that the pc
has been idle for 5 minutes before doing so, that way it knows im not around".

  -Action Close   at 14:00 (slot Lunch) or 17:30 (slot Evening) on a weekday: if Tim's AutoCAD is open, wait until the PC has had no keyboard
                  or mouse input for -IdleMinutes (default 5; checked every 60 s; gives up at 14:55 / 20:00 and leaves AutoCAD open), then
                  save every drawing (QSAVE), check each one reads Saved, record the open drawings, then ask AutoCAD to quit (never kill it).
                  It refuses, and leaves AutoCAD exactly as it is, when: LUNCH_PAUSE.flag exists, the idle time cannot be read, a never-saved
                  drawing has content or changes, a drawing is read-only with changes, a save fails, or AutoCAD stays busy (a command or
                  dialog running, or Tim back at the keyboard) for 10 minutes. Saturday and Sunday: nothing.
  -Action Reopen  at 15:00 (slot Lunch: today's lunch close) or 08:30 (slot Morning: the previous working day's evening close, so Friday
                  17:30 reopens Monday 08:30): wait (up to 10 min) for the robot, Codex and the driver lock to be clear, then start
                  AutoCAD with the recorded command line and profile, open the drawings in the recorded order, activate the recorded active
                  drawing and restore maximised/normal. If AutoCAD is already running (Tim started it) it does nothing. No idle check.
                  A saved list older than 4 days is never reopened: it is logged and deleted.
  -Action Status  prints counts only.
  -DryRun         decides and reports, but saves, closes, launches and writes nothing (the idle time is read once, not waited for).
  -Slot           Auto (from the clock) or Lunch / Evening (Close) / Lunch / Morning (Reopen), for a by-hand run with -IgnoreClock.

PRIVATE DATA (RULES 11): drawing paths live ONLY in the local state folder C:\ce_rc_scratch\lunch (outside OneDrive and every git repo,
checked at run time). The repo log desk_jobs\lunch_window.log gets counts only; Write-RepoLog refuses any line that looks like a path or a drawing name.
Tests: lunch_window_tests.ps1 in C:\ce_rc_scratch\lunch\tests (offline, mocked AutoCAD). Dot-source with -Action Lib to load the functions only.
#>
param(
    [ValidateSet('Close', 'Reopen', 'Status', 'Lib')] [string]$Action = 'Status',
    [switch]$DryRun,
    [switch]$IgnoreClock,
    [ValidateSet('Auto', 'Lunch', 'Evening', 'Morning')] [string]$Slot = 'Auto',
    [ValidateRange(1, 120)] [int]$IdleMinutes = 5,
    [string]$StateDir = 'C:\ce_rc_scratch\lunch',
    [string]$DeskDir = 'C:\CE_PLAN\desk_jobs',
    [string]$LockFile = 'C:\ce_rc_drv\ACAD_LOCK.json'
)

$script:StateDir = $StateDir
$script:DeskDir = $DeskDir
$script:LockFile = $LockFile
$script:StateFile = Join-Path $StateDir 'lunch_state.json'
$script:DetailLog = Join-Path $StateDir 'lunch_detail.log'     # local only: may name drawings
$script:RepoLog = Join-Path $DeskDir 'lunch_window.log'        # in the CE_PLAN repo: counts only
$script:BusyWaitSec = 600       # 10 minutes of retries before giving up (Close: leave AutoCAD open; Reopen: leave it closed)
$script:BusyStepSec = 30
$script:QuitWaitSec = 180       # how long to wait for acad.exe to go after Quit
$script:LaunchWaitSec = 300     # how long to wait for a fresh AutoCAD to answer
$script:TypingIdleMs = 120000   # someone typed or moved the mouse in the last 2 minutes = Tim is still working: treat as busy
$script:IdleMinutes = $IdleMinutes   # before any close the PC must have had no keyboard/mouse input for this long (Tim is away)
$script:IdleStepSec = 60        # idle re-check interval
$script:StaleDays = 4           # a saved drawing list older than this is never reopened (Fri 17:30 -> Mon 08:30 is under 3 days)
# start windows (minutes after midnight) for each action and slot; the 14:00/17:30/15:00/08:30 tasks start inside them
$script:Windows = @{ CloseLunch = @(835, 860); CloseEvening = @(1045, 1070); ReopenLunch = @(895, 930); ReopenMorning = @(505, 540) }
# idle give-up times: past these the close is abandoned and AutoCAD left open
$script:GiveUp = @{ Lunch = [timespan]'14:55'; Evening = [timespan]'20:00' }

# ------------------------------------------------------------------ the outside world (replaced by mocks in the offline tests)
$script:Sys = @{
    GetAcad    = { Get-RunningAcad }
    AcadProcs  = { @(Get-CimInstance Win32_Process -Filter "Name='acad.exe'" | ForEach-Object { [pscustomobject]@{ Id = [int]$_.ProcessId; CommandLine = [string]$_.CommandLine; Path = [string]$_.ExecutablePath } }) }
    OtherProcs = { @(Get-CimInstance Win32_Process | ForEach-Object { [pscustomobject]@{ Id = [int]$_.ProcessId; Name = [string]$_.Name; CommandLine = [string]$_.CommandLine } }) }
    PidAlive   = { param($id) [bool](Get-Process -Id $id -ErrorAction SilentlyContinue) }
    Sleep      = { param($s) Start-Sleep -Seconds $s }
    Now        = { Get-Date }
    IdleMs     = { Get-IdleMs }
    Profile    = { Get-AcadProfileName }
    StartAcad  = { param($exe, $argLine) Start-Process -FilePath $exe -ArgumentList $argLine -PassThru | Out-Null }
    FileLocked = { param($p) Test-FileLocked $p }
}

function Initialize-LunchNative {
    if (-not ('LunchCom' -as [type])) {
        Add-Type -TypeDefinition @'
using System; using System.Runtime.InteropServices;
public static class LunchCom {
    [DllImport("ole32.dll")] static extern int CLSIDFromProgID([MarshalAs(UnmanagedType.LPWStr)] string progId, out Guid clsid);
    [DllImport("oleaut32.dll")] static extern int GetActiveObject(ref Guid rclsid, IntPtr reserved, [MarshalAs(UnmanagedType.IUnknown)] out object ppunk);
    [StructLayout(LayoutKind.Sequential)] struct LASTINPUTINFO { public uint cbSize; public uint dwTime; }
    [DllImport("user32.dll")] static extern bool GetLastInputInfo(ref LASTINPUTINFO plii);
    [DllImport("kernel32.dll")] static extern uint GetTickCount();
    public static object GetRunning(string progId) { Guid g; if (CLSIDFromProgID(progId, out g) != 0) return null; object o; if (GetActiveObject(ref g, IntPtr.Zero, out o) != 0) return null; return o; }
    public static long IdleMs() { LASTINPUTINFO li = new LASTINPUTINFO(); li.cbSize = (uint)Marshal.SizeOf(typeof(LASTINPUTINFO)); if (!GetLastInputInfo(ref li)) return -1; return (long)(uint)(GetTickCount() - li.dwTime); }
}
'@
    }
}
function Get-RunningAcad {
    Initialize-LunchNative
    foreach ($prog in 'AutoCAD.Application.26', 'AutoCAD.Application') { $a = [LunchCom]::GetRunning($prog); if ($a) { return $a } }
    return $null
}
# milliseconds since the last keyboard/mouse input in this desktop session, or $null when it cannot be read
# (no interactive session, e.g. a task not set to run only when logged on, or the call failed): $null is treated as NOT idle
function Get-IdleMs {
    try {
        if ((Get-Process -Id $PID).SessionId -eq 0) { return $null }
        Initialize-LunchNative; $ms = [LunchCom]::IdleMs()
        if ($ms -lt 0) { return $null }; return $ms
    } catch { return $null }
}
function Get-AcadProfileName {
    # AutoCAD 2027: HKCU\Software\Autodesk\AutoCAD\R26.0\<CurVer>\Profiles, default value = the current profile name
    try {
        $r = 'HKCU:\Software\Autodesk\AutoCAD\R26.0'; $cv = (Get-ItemProperty $r -ErrorAction Stop).CurVer
        return [string](Get-ItemProperty "$r\$cv\Profiles" -ErrorAction Stop).'(default)'
    } catch { return '' }
}
function Test-FileLocked([string]$p) {
    try { $fs = [IO.File]::Open($p, 'Open', 'Read', 'None'); $fs.Close(); return $false } catch { return $true }
}

# ------------------------------------------------------------------ logging and the private-data guard
function Test-LooksPrivate([string]$t) {
    # a drive path, a UNC path, or a drawing/file name: never allowed in the repo log
    return ($t -match '[A-Za-z]:\\' -or $t -match '\\\\' -or $t -match '(?i)\.(dwg|dwt|dxf|dws|bak|sv\$)\b')
}
function Write-RepoLog([string]$t) {
    if (Test-LooksPrivate $t) { $t = 'line withheld: it looked like a path or a drawing name (see the local detail log)' }
    $line = '{0} {1}' -f ((& $script:Sys.Now).ToString('ddd dd MMM HH:mm')), $t
    Add-Content -LiteralPath $script:RepoLog -Value $line
    Write-Output $line
}
function Write-DetailLog([string]$t) {
    $line = '{0} {1}' -f ((& $script:Sys.Now).ToString('yyyy-MM-dd HH:mm:ss')), $t
    Add-Content -LiteralPath $script:DetailLog -Value $line
}
function Test-LocalOnlyFolder([string]$dir) {
    # true only when the folder is outside OneDrive, outside C:\CE_PLAN and C:\Lisp Files, and not inside any git working copy
    $full = [IO.Path]::GetFullPath($dir).TrimEnd('\') + '\'
    $bad = @($env:OneDrive, $env:OneDriveCommercial, $env:OneDriveConsumer, 'C:\CE_PLAN', 'C:\Lisp Files', 'C:\TimOS') | Where-Object { $_ }
    foreach ($b in $bad) { if ($full.StartsWith(([IO.Path]::GetFullPath($b).TrimEnd('\') + '\'), [StringComparison]::OrdinalIgnoreCase)) { return $false } }
    if ($full -match '(?i)\\OneDrive') { return $false }
    $p = $full.TrimEnd('\')
    while ($p) {
        if (Test-Path -LiteralPath (Join-Path $p '.git')) { return $false }
        $parent = Split-Path $p -Parent; if (-not $parent -or $parent -eq $p) { break }; $p = $parent
    }
    return $true
}
function Initialize-StateDir {
    if (-not (Test-LocalOnlyFolder $script:StateDir)) { throw 'the state folder is synced or inside a repo: refusing to write drawing paths there' }
    if (-not (Test-Path -LiteralPath $script:StateDir)) { New-Item -ItemType Directory -Path $script:StateDir -Force | Out-Null }
}

# ------------------------------------------------------------------ COM helpers (work the same on real AutoCAD and on the mocks)
function Get-DocList($acad) {
    $docs = $acad.Documents; $n = [int]$docs.Count; $out = @()
    for ($i = 0; $i -lt $n; $i++) { $out += , $docs.Item($i) }
    return $out
}
function Get-DocVar($doc, [string]$name) { $doc.GetVariable($name) }

# Is AutoCAD free to be saved and closed? A command running in any drawing, a dialog open (COM calls are refused), or Tim typing = busy.
function Test-AcadBusy($acad) {
    try {
        if ((& $script:Sys.IdleMs) -lt $script:TypingIdleMs) { return 'someone is using the keyboard or mouse' }
        foreach ($d in (Get-DocList $acad)) { if ([int](Get-DocVar $d 'CMDACTIVE') -ne 0) { return 'a command is running' } }
        return ''
    } catch { return 'AutoCAD is not answering (a dialog may be open)' }
}

# The snapshot: one record per open drawing, in Documents order. Untitled drawings get path ''.
function Get-AcadSnapshot($acad) {
    $active = $acad.ActiveDocument; $activeName = [string]$active.Name
    $list = @(); $i = 0
    foreach ($d in (Get-DocList $acad)) {
        $full = [string]$d.FullName
        $titled = $true; try { $titled = ([int](Get-DocVar $d 'DWGTITLED') -ne 0) } catch { }
        if (-not $full) { $titled = $false }
        $saved = [bool]$d.Saved
        $dbmod = 0; try { $dbmod = [int](Get-DocVar $d 'DBMOD') } catch { }
        $items = 0; try { $items = [int]$d.ModelSpace.Count } catch { }
        $list += [pscustomobject]@{
            order = $i; path = $(if ($titled) { $full } else { '' }); name = [string]$d.Name; titled = $titled
            read_only = [bool]$d.ReadOnly; modified = ((-not $saved) -or $dbmod -ne 0); has_content = ($items -gt 0)
            active = ([string]$d.Name -eq $activeName -and ([string]$d.FullName -eq [string]$active.FullName))
        }
        $i++
    }
    return $list
}

# The close decision, before any save. Returns '' when closing is allowed, otherwise the reason (counts only, no names).
function Get-CloseRefusal($snap) {
    $untitledWork = @($snap | Where-Object { -not $_.titled -and ($_.modified -or $_.has_content) }).Count
    if ($untitledWork -gt 0) { return "left open: $untitledWork never-saved drawing(s) hold work (no save location is ever invented)" }
    $roMod = @($snap | Where-Object { $_.titled -and $_.read_only -and $_.modified }).Count
    if ($roMod -gt 0) { return "left open: $roMod read-only drawing(s) have changes that cannot be saved" }
    if (@($snap | Where-Object titled).Count -eq 0) { return 'left open: no saved drawings are open (nothing to restore later)' }
    return ''
}

# The pause switch (Amendment 1): Tim's close instruction is unconditional, so the old "only when a robot job is waiting" guard is gone.
# LUNCH_PAUSE.flag in the desk folder stops every Close (holidays such as Cup Day, or Tim working late); Reopen still works.
function Test-Paused { Test-Path -LiteralPath (Join-Path $script:DeskDir 'LUNCH_PAUSE.flag') }

# Which slot is this run? Close: Lunch (13:55-14:20) or Evening (17:25-17:50). Reopen: Lunch (14:55-15:30) or Morning (08:25-09:00).
# Weekends: none. -IgnoreClock: -Slot if given, otherwise guessed from the hour.
function Get-Slot([string]$kind, [datetime]$t) {
    $choices = $(if ($kind -eq 'Close') { 'Lunch', 'Evening' } else { 'Lunch', 'Morning' })
    if ($Slot -ne 'Auto' -and $Slot -notin $choices) { return $null }
    $m = $t.Hour * 60 + $t.Minute
    if ($IgnoreClock) {
        if ($Slot -ne 'Auto') { return $Slot }
        if ($kind -eq 'Close') { return $(if ($m -lt 16 * 60) { 'Lunch' } else { 'Evening' }) }
        return $(if ($m -lt 12 * 60) { 'Morning' } else { 'Lunch' })
    }
    if ($t.DayOfWeek -in 'Saturday', 'Sunday') { return $null }
    foreach ($c in $choices) {
        if ($Slot -ne 'Auto' -and $Slot -ne $c) { continue }
        $w = $script:Windows["$kind$c"]; if ($m -ge $w[0] -and $m -le $w[1]) { return $c }
    }
    return $null
}
function Get-GiveUpTime([string]$slot, [datetime]$now) {
    if ($IgnoreClock) { return $now.AddMinutes(30) }
    return $now.Date.Add($script:GiveUp[$slot])
}
function Get-PrevWorkingDay([datetime]$d) {
    $p = $d.Date.AddDays(-1); while ($p.DayOfWeek -in 'Saturday', 'Sunday') { $p = $p.AddDays(-1) }; return $p
}

# Wait until nobody has touched the keyboard or mouse for IdleMinutes. '' = idle; otherwise the reason (minutes only, never a clock time of input).
function Wait-ForIdle([datetime]$giveUp) {
    $need = [long]$script:IdleMinutes * 60000
    while ($true) {
        $ms = & $script:Sys.IdleMs
        if ($null -eq $ms) { return 'cannot read idle time (no desktop session or the call failed), treated as not idle' }
        if ([long]$ms -ge $need) { return '' }
        if ((& $script:Sys.Now) -ge $giveUp) {
            return "not idle: keyboard or mouse used $([int][math]::Floor($ms / 60000)) min ago (needs $($script:IdleMinutes) min), gave up at $($giveUp.ToString('HH:mm'))"
        }
        & $script:Sys.Sleep $script:IdleStepSec
    }
}

# Is the robot, Codex or a driver session still busy with AutoCAD? (same lock rule as acad_driver_v3 Get-V3LockState)
function Get-RobotActivity {
    if (Test-Path -LiteralPath $script:LockFile) {
        try {
            $l = Get-Content -LiteralPath $script:LockFile -Raw | ConvertFrom-Json
            $nowUnix = ([DateTimeOffset](& $script:Sys.Now)).ToUnixTimeSeconds()
            $live = $l.who -and [long]$l.expires -gt $nowUnix
            if ($live -and [int]$l.pid -gt 0 -and -not (& $script:Sys.PidAlive ([int]$l.pid))) { $live = $false }
            if ($live) { return 'the AutoCAD lock is held' }
        } catch { }
    }
    $p = @(& $script:Sys.OtherProcs | Where-Object { $_.CommandLine -match '(?i)codex(\.exe|\.cmd|\.js)?["]?\s+exec|tester_run[0-9]|chain_runner_run|case_runner\.ps1|acad_driver_v3|acad_driver_witness|desk_install_[cs][0-9]' })
    if ($p.Count -gt 0) { return 'a robot, Codex or driver process is running' }
    return ''
}

function Read-State { if (Test-Path -LiteralPath $script:StateFile) { Get-Content -LiteralPath $script:StateFile -Raw | ConvertFrom-Json } else { $null } }
function Save-State($s) { Initialize-StateDir; $s | ConvertTo-Json -Depth 6 | Set-Content -LiteralPath $script:StateFile -Encoding utf8 }

# ------------------------------------------------------------------ CLOSE (14:00 lunch, 17:30 evening)
function Invoke-LunchClose {
    $now = & $script:Sys.Now
    if (-not $IgnoreClock -and $now.DayOfWeek -in 'Saturday', 'Sunday') { return (Write-RepoLog "close: not a weekday ($($now.DayOfWeek)): nothing done, AutoCAD is free at weekends") }
    $slot = Get-Slot 'Close' $now
    if (-not $slot) { return (Write-RepoLog 'close: not a weekday 13:55-14:20 or 17:25-17:50, nothing done') }
    $tag = "close ($($slot.ToLower()))"
    if (Test-Paused) { return (Write-RepoLog "${tag}: paused (LUNCH_PAUSE.flag is set): AutoCAD left as it is") }
    $acadP = @(& $script:Sys.AcadProcs)
    if ($acadP.Count -eq 0) { return (Write-RepoLog "${tag}: AutoCAD is not open, nothing to do") }
    if ($acadP.Count -gt 1) { return (Write-RepoLog "${tag}: left open: $($acadP.Count) AutoCAD sessions are running (one expected)") }
    $robot = Get-RobotActivity
    if ($robot) { return (Write-RepoLog "${tag}: left open: $robot (this AutoCAD may not be Tim's)") }

    # Tim must be away: no keyboard or mouse for IdleMinutes, re-checked every 60 s until the give-up time (14:55 / 20:00)
    $giveUp = Get-GiveUpTime $slot $now
    if ($DryRun) {
        $ms = & $script:Sys.IdleMs
        if ($null -eq $ms) { return (Write-RepoLog "${tag} (dry run): left open: cannot read idle time") }
        if ([long]$ms -lt [long]$script:IdleMinutes * 60000) { return (Write-RepoLog "${tag} (dry run): not idle now (keyboard or mouse used $([int][math]::Floor($ms / 60000)) min ago, needs $($script:IdleMinutes) min); a real run re-checks every 60 s until $($giveUp.ToString('HH:mm'))") }
    } else {
        $idleWhy = Wait-ForIdle $giveUp
        if ($idleWhy) { return (Write-RepoLog "${tag}: left open: $idleWhy") }
        $acadP = @(& $script:Sys.AcadProcs)
        if ($acadP.Count -ne 1) { return (Write-RepoLog "${tag}: AutoCAD sessions changed while waiting for idle ($($acadP.Count) running), nothing done") }
    }
    $acad = & $script:Sys.GetAcad
    if (-not $acad) { return (Write-RepoLog "${tag}: left open: AutoCAD is running but would not answer (COM attach failed)") }

    # wait for AutoCAD (and Tim) to be idle: retry every 30 s for 10 minutes (never past the give-up time), never force
    $waited = 0
    while ($true) {
        $why = Test-AcadBusy $acad
        if (-not $why) { break }
        if ($waited -ge $script:BusyWaitSec -or (& $script:Sys.Now) -ge $giveUp) { return (Write-RepoLog "${tag}: left open: AutoCAD busy ($why) for $([int]($waited/60)) minutes, nothing touched") }
        & $script:Sys.Sleep $script:BusyStepSec; $waited += $script:BusyStepSec
    }

    $snap = @(Get-AcadSnapshot $acad)
    $refuse = Get-CloseRefusal $snap
    if ($refuse) { return (Write-RepoLog "${tag}: $refuse") }
    $titled = @($snap | Where-Object titled)

    $proc = $acadP[0]
    $state = [ordered]@{
        status = 'captured'; slot = $slot.ToLower(); captured_at = $now.ToString('yyyy-MM-dd HH:mm:ss'); captured_day = $now.ToString('yyyy-MM-dd')
        acad_pid = $proc.Id; acad_exe = $proc.Path; acad_cmdline = $proc.CommandLine; profile = [string](& $script:Sys.Profile)
        window_state = $(try { [int]$acad.WindowState } catch { 0 })
        documents = @($titled | ForEach-Object { [ordered]@{ order = $_.order; path = $_.path; read_only = $_.read_only; active = $_.active } })
        untitled_empty_skipped = @($snap | Where-Object { -not $_.titled }).Count
    }
    if ($DryRun) { return (Write-RepoLog "${tag} (dry run): idle ok; would save and close $($titled.Count) drawing(s); nothing saved, closed or written") }

    # save each titled, writable drawing (QSAVE), then check every one reads Saved
    $docs = @(Get-DocList $acad); $fail = 0
    foreach ($d in $docs) {
        if (-not [string]$d.FullName) { continue }
        if ([bool]$d.ReadOnly) { continue }       # read-only and unchanged (changed ones were refused above)
        try { [void]$d.Save() } catch { $fail++; Write-DetailLog "save failed: $([string]$d.FullName): $($_.Exception.Message)" }
    }
    $unsaved = @($docs | Where-Object { [string]$_.FullName -and -not [bool]$_.Saved }).Count
    if ($fail -gt 0 -or $unsaved -gt 0) { return (Write-RepoLog "${tag}: left open: $fail save(s) failed, $unsaved drawing(s) not reading saved; AutoCAD not closed") }

    $state.status = 'saved'; Save-State $state
    Write-DetailLog "captured $($titled.Count) drawing(s): $(($titled | ForEach-Object { $_.path }) -join ' | ')"
    try { [void]$acad.Quit() } catch { Write-DetailLog "Quit raised: $($_.Exception.Message)" }
    $acad = $null; [GC]::Collect(); [GC]::WaitForPendingFinalizers()

    $t = 0
    while ((& $script:Sys.PidAlive $proc.Id) -and $t -lt $script:QuitWaitSec) { & $script:Sys.Sleep 5; $t += 5 }
    if (& $script:Sys.PidAlive $proc.Id) {
        $state.status = 'quit-pending'; Save-State $state
        return (Write-RepoLog "${tag}: saved $($titled.Count) drawing(s) and asked AutoCAD to quit, but it is still running after $($script:QuitWaitSec) s; NOT killed")
    }
    $state.status = 'closed'; $state.closed_at = (& $script:Sys.Now).ToString('yyyy-MM-dd HH:mm:ss'); Save-State $state
    return (Write-RepoLog "${tag}: closed $($titled.Count) drawing(s), active one recorded, AutoCAD gone")
}

# ------------------------------------------------------------------ REOPEN (15:00 after a lunch close, 08:30 after the previous working day's evening close)
function Invoke-LunchReopen {
    $now = & $script:Sys.Now
    $slot = Get-Slot 'Reopen' $now
    if (-not $slot) { return (Write-RepoLog 'reopen: not a weekday 14:55-15:30 or 08:25-09:00, nothing done') }
    $tag = "reopen ($($slot.ToLower()))"
    $s = Read-State
    if (-not $s) { return (Write-RepoLog "${tag}: nothing was closed, nothing to do") }
    $cap = [datetime]::ParseExact([string]$s.captured_at, 'yyyy-MM-dd HH:mm:ss', [Globalization.CultureInfo]::InvariantCulture)
    $age = ($now - $cap).TotalDays
    if ($age -gt $script:StaleDays) {
        Remove-Item -LiteralPath $script:StateFile -Force
        return (Write-RepoLog "${tag}: the saved drawing list is $([int][math]::Floor($age)) days old (over $($script:StaleDays)): deleted, nothing opened")
    }
    if ($s.status -ne 'closed') { return (Write-RepoLog "${tag}: nothing waiting to reopen (last status $($s.status))") }
    $stSlot = $(if ($s.slot) { [string]$s.slot } else { 'lunch' })
    if (-not $IgnoreClock) {
        if ($slot -eq 'Lunch' -and ($stSlot -ne 'lunch' -or $s.captured_day -ne $now.ToString('yyyy-MM-dd'))) { return (Write-RepoLog "${tag}: nothing was closed at lunch today, nothing to do") }
        if ($slot -eq 'Morning' -and ($stSlot -ne 'evening' -or $s.captured_day -ne (Get-PrevWorkingDay $now).ToString('yyyy-MM-dd'))) { return (Write-RepoLog "${tag}: nothing was closed on the last working evening, nothing to do") }
    }

    $waited = 0
    while ($true) {
        $why = Get-RobotActivity
        if (-not $why) { break }
        if ($waited -ge $script:BusyWaitSec) { return (Write-RepoLog "${tag}: left closed: $why after $([int]($waited/60)) minutes (state kept; run -Action Reopen -IgnoreClock to reopen by hand)") }
        & $script:Sys.Sleep $script:BusyStepSec; $waited += $script:BusyStepSec
    }
    if (@(& $script:Sys.AcadProcs).Count -gt 0) {
        $s.status = 'skipped-acad-running'; Save-State $s
        return (Write-RepoLog "${tag}: AutoCAD is already running (Tim or another session started it): nothing opened")
    }

    $docs = @($s.documents | Sort-Object { [int]$_.order })
    $missing = 0; $locked = 0; $toOpen = @()
    foreach ($d in $docs) {
        if (-not (Test-Path -LiteralPath $d.path)) { $missing++; Write-DetailLog "missing: $($d.path)"; continue }
        if (& $script:Sys.FileLocked $d.path) { $locked++; Write-DetailLog "locked: $($d.path)"; continue }
        $toOpen += , $d
    }
    if ($DryRun) { return (Write-RepoLog "${tag} (dry run): would start AutoCAD and open $($toOpen.Count) drawing(s); $missing missing, $locked locked") }

    $argLine = Get-RelaunchArgs ([string]$s.acad_cmdline) ([string]$s.profile)
    & $script:Sys.StartAcad ([string]$s.acad_exe) $argLine
    $acad = $null; $t = 0
    while ($t -lt $script:LaunchWaitSec) {
        $acad = & $script:Sys.GetAcad
        if ($acad) { try { [void]$acad.Documents.Count; break } catch { $acad = $null } }
        & $script:Sys.Sleep 5; $t += 5
    }
    if (-not $acad) { return (Write-RepoLog "${tag}: AutoCAD was started but did not answer within $($script:LaunchWaitSec) s; no drawings opened (state kept)") }

    $startDocs = @(Get-DocList $acad)   # the blank Drawing1 AutoCAD may open on start
    $opened = 0; $failed = 0; $activeDoc = $null
    foreach ($d in $toOpen) {
        $ok = $false; $tries = 0
        while (-not $ok -and $tries -lt 12) {
            try { $doc = $acad.Documents.Open([string]$d.path, [bool]$d.read_only); $ok = $true } catch { $tries++; & $script:Sys.Sleep 5 }
        }
        if ($ok) { $opened++; if ($d.active) { $activeDoc = $doc } } else { $failed++; Write-DetailLog "open failed: $($d.path)" }
    }
    foreach ($b in $startDocs) {
        try { if (-not [string]$b.FullName -and [bool]$b.Saved -and $opened -gt 0) { [void]$b.Close($false) } } catch { }
    }
    if ($activeDoc) { try { [void]$activeDoc.Activate() } catch { } }
    if ([int]$s.window_state -gt 0) { try { $acad.WindowState = [int]$s.window_state } catch { } }

    $s.status = 'reopened'; $s | Add-Member -NotePropertyName reopened_at -NotePropertyValue ((& $script:Sys.Now).ToString('yyyy-MM-dd HH:mm:ss')) -Force; Save-State $s
    $notBack = $missing + $locked + $failed
    if ($notBack -gt 0) { return (Write-RepoLog "${tag}: reopened $opened drawing(s); could not reopen $notBack drawing(s) ($missing missing, $locked locked, $failed failed)") }
    return (Write-RepoLog "${tag}: reopened $opened drawing(s) in order, active one restored")
}

# the recorded acad.exe command line minus the exe itself, with the profile added when it was not already named
function Get-RelaunchArgs([string]$cmdline, [string]$profileName) {
    $rest = $cmdline.Trim()
    if ($rest.StartsWith('"')) { $rest = $rest.Substring($rest.IndexOf('"', 1) + 1) } else { $sp = $rest.IndexOf(' '); $rest = $(if ($sp -ge 0) { $rest.Substring($sp) } else { '' }) }
    $rest = $rest.Trim()
    if ($profileName -and $rest -notmatch '(?i)(^|\s)/p\s') { $rest = ($rest + ' /p "' + $profileName + '"').Trim() }
    return $rest
}

# ------------------------------------------------------------------ STATUS
function Invoke-LunchStatus {
    $ms = & $script:Sys.IdleMs
    $idle = $(if ($null -eq $ms) { 'cannot be read' } else { "$([int][math]::Floor($ms / 60000)) min (needs $($script:IdleMinutes))" })
    $common = "pause flag: $(if (Test-Paused) { 'SET, closes do nothing' } else { 'not set' }); idle now: $idle"
    $s = Read-State
    if (-not $s) { return "lunch window: no state recorded; $common" }
    $n = @($s.documents).Count; $ro = @($s.documents | Where-Object read_only).Count
    $missing = @($s.documents | Where-Object { -not (Test-Path -LiteralPath $_.path) }).Count
    $slotName = $(if ($s.slot) { $s.slot } else { 'lunch' })
    return "lunch window: status $($s.status), slot $slotName, captured $($s.captured_at), $n drawing(s) recorded ($ro read-only), $missing missing on disk now; $common"
}

switch ($Action) {
    'Lib' { }
    'Status' { Invoke-LunchStatus }
    'Close' { try { Invoke-LunchClose } catch { Write-RepoLog "close: stopped on an error, AutoCAD left as it was: $($_.Exception.GetType().Name)" } }
    'Reopen' { try { Invoke-LunchReopen } catch { Write-RepoLog "reopen: stopped on an error: $($_.Exception.GetType().Name)" } }
}
