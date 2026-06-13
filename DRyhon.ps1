<#
    DRyhon Security Audit Script
    Author: Dr.Arrow
    Purpose: Daily security audit tool with colorful console + HTML report
    License: MIT
#>

# === ASCII Banner ===
$banner = @"
   ____  ____        _                       
  |  _ \|  _ \ _   _| |__   ___  _ __        
  | | | | |_) | | | | '_ \ / _ \| '_ \       
  | |_| |  _ <| |_| | | | | (_) | | | |      
  |____/|_| \_\\__, |_| |_|\___/|_| |_|      
               |___/                         
        === DR.Arrow Security Audit ===
A PowerShell-based Windows Security Auditing Framework created by DrArrow for rapid endpoint assessment and HTML-based security reporting.

Copyright (c) 2026 DrArrow

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

"@
Write-Host $banner -ForegroundColor Cyan

# === Setup Paths ===
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$reportDir = "C:\AuditReports"
$reportPath = "$reportDir\DRArrow_$timestamp.html"

if (!(Test-Path $reportDir)) {
    New-Item -ItemType Directory -Path $reportDir | Out-Null
}

# === CSS Styling for HTML Report ===
$css = @"
<style>
body { font-family: Consolas, monospace; background-color: #1e1e1e; color: #d4d4d4; }
h2 { color: #00ffff; border-bottom: 1px solid #00ffff; padding-bottom: 5px; }
table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
th { background-color: #007acc; color: white; padding: 5px; }
td { border: 1px solid #444; padding: 5px; }
.success { color: #00ff00; font-weight: bold; }
.warning { color: #ff4500; font-weight: bold; }
</style>
"@

# === Collect Report Sections ===
$report = @()

# Processes
$report += "<h2>Top Processes by CPU</h2>"
$report += (Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 Name, CPU, Id | ConvertTo-Html -Fragment)

# Event Logs
$report += "<h2>Recent Security Events</h2>"
$report += (Get-WinEvent -LogName Security -MaxEvents 10 | Select-Object TimeCreated, Id, LevelDisplayName | ConvertTo-Html -Fragment)

# File Integrity
$report += "<h2>File Integrity Check</h2>"
$files = "C:\Windows\System32\ntoskrnl.exe","C:\Windows\System32\winlogon.exe"
foreach ($file in $files) {
    $hash = Get-FileHash -Path $file -Algorithm SHA256
    $report += "<p><span class='success'>$($hash.Path)</span> → <span class='warning'>$($hash.Hash)</span></p>"
}

# Users
$report += "<h2>Local Users</h2>"
$report += (Get-LocalUser | Select-Object Name, Enabled, LastLogon | ConvertTo-Html -Fragment)

# Suspicious Accounts
$report += "<h2>Suspicious Accounts</h2>"
$suspicious = Get-LocalUser | Where-Object { $_.Enabled -eq $false -or $_.LastLogon -gt (Get-Date).AddDays(-1) }
if ($suspicious) {
    $report += ( $suspicious | ConvertTo-Html -Fragment )
    $report += "<p class='warning'>⚠ Suspicious accounts detected!</p>"
} else {
    $report += "<p class='success'>No suspicious accounts found.</p>"
}

# Network Connections
$report += "<h2>Active Network Connections</h2>"
$report += (Get-NetTCPConnection | Where-Object { $_.State -eq "Established" } | Select-Object LocalAddress, LocalPort, RemoteAddress, RemotePort | ConvertTo-Html -Fragment)

# Suspicious Ports
$report += "<h2>Suspicious Ports</h2>"
$badPorts = Get-NetTCPConnection | Where-Object { $_.RemotePort -in 1337,4444 }
if ($badPorts) {
    $report += ($badPorts | ConvertTo-Html -Fragment)
    $report += "<p class='warning'>⚠ Suspicious ports detected!</p>"
} else {
    $report += "<p class='success'>No suspicious ports found.</p>"
}

# System Info
$report += "<h2>System Information</h2>"
$report += (Get-WmiObject -Class Win32_ComputerSystem | Select-Object Name, Domain, Manufacturer, Model | ConvertTo-Html -Fragment)

# === Save HTML Report with CSS ===
ConvertTo-Html -Body ($report -join "`n") -Head $css -Title "DR.Arrow Security Audit Report" |
    Out-File $reportPath

Write-Host "`nReport saved to $reportPath" -ForegroundColor Green
Write-Host "=== DR.Arrow Audit Completed - Stay Secure ===" -ForegroundColor Cyan
