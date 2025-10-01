param(
  [ValidateSet('Morning','Mid')]
  [string]$Mode = 'Morning'
)

# ---------- paths ----------
$Root     = "$env:USERPROFILE\Documents\CurtisWay\Journal"
$Template = "$env:USERPROFILE\Documents\CurtisWay\docs\trading_checklist.md"
$Date     = (Get-Date -Format 'yyyy-MM-dd')
$Today    = Join-Path $Root "$Date - Daily_Trading_Checklist.md"

# ---------- ensure template & today's file ----------
New-Item -ItemType Directory -Path $Root -Force | Out-Null
if (-not (Test-Path $Template)) {
  Add-Type -AssemblyName System.Windows.Forms
  [System.Windows.Forms.MessageBox]::Show("Missing template:`n$Template","CurtisWay") | Out-Null
  exit 1
}
if (-not (Test-Path $Today)) { Copy-Item $Template $Today }

# ---------- mid-session block (appended once) ----------
if ($Mode -eq 'Mid') {
  $marker = '## Mid-session check (≈13:15, new H4 bar)'
  $text = Get-Content -Raw $Today
  if ($text -notmatch [regex]::Escape($marker)) {
@"
$marker

- [ ] <span style="color:red"><b>Still going OK?</b></span>
- Notes (13:15): ____________________________

"@ | Add-Content -Path $Today
  }
  # optional chime
  try {
    $wav = 'C:\Windows\Media\Windows Notify Calendar.wav'
    if (Test-Path $wav) { (New-Object System.Media.SoundPlayer $wav).Play() }
  } catch {}
}

# ---------- launch editor & capture process ----------
$editors = @(
  "C:\Program Files\TypeAura\TypeAura.exe",
  "C:\Program Files (x86)\TypeAura\TypeAura.exe",
  "$env:LOCALAPPDATA\Programs\Typora\Typora.exe",
  "C:\Program Files\Typora\Typora.exe"
)

if ($e = ($editors | Where-Object { Test-Path $_ } | Select-Object -First 1)) {
  $p = Start-Process -FilePath $e -ArgumentList "`"$Today`"" -PassThru
} else {
  try   { $p = Start-Process -FilePath $Today -PassThru }
  catch { $p = Start-Process notepad.exe $Today -PassThru }
}

# ---------- position on chosen monitor & bring to front ----------
$targetMonitor = 1   # 1 = primary, 2 = second, 3 = third (your Samsung)

Add-Type -AssemblyName System.Windows.Forms
$p.WaitForInputIdle(5000) | Out-Null
$null = (New-Object -ComObject WScript.Shell).AppActivate($p.Id)

$code = @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
  [DllImport("user32.dll")] public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@
Add-Type -TypeDefinition $code -ErrorAction SilentlyContinue

$screens = [System.Windows.Forms.Screen]::AllScreens
if ($targetMonitor -ge $screens.Count) { $targetMonitor = 0 }
$wa = $screens[$targetMonitor].WorkingArea

$w = [Math]::Min([int]($wa.Width*0.8), 1200)
$h = [Math]::Min([int]($wa.Height*0.85), 900)
$x = $wa.X + ([int](($wa.Width  - $w)/2))
$y = $wa.Y + ([int](($wa.Height - $h)/2))

[WinAPI]::ShowWindow($p.MainWindowHandle, 9)       | Out-Null   # SW_RESTORE
[WinAPI]::MoveWindow($p.MainWindowHandle,$x,$y,$w,$h,$true) | Out-Null
[WinAPI]::SetForegroundWindow($p.MainWindowHandle) | Out-Null
