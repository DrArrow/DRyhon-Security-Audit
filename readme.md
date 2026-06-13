# 🛡️ DRyhon Security Audit

> A PowerShell-based Windows Security Auditing Framework created by **DrArrow** for rapid endpoint assessment and HTML-based security reporting.

![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-blue)
![Windows](https://img.shields.io/badge/Platform-Windows-success)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Demo

![DRyhon Demo](./screenshots/dryhon-demo.gif)

## 📖 Overview

DRyhon is a lightweight security auditing tool written entirely in PowerShell. It performs essential security checks on Windows systems and generates a professional HTML report for security reviews, incident response, and system health assessments.

The tool leverages native Windows and PowerShell capabilities to gather information about processes, event logs, user accounts, network connections, and critical system files.

---

## ✨ Features

### 🔍 Process Analysis

* Displays top CPU-consuming processes
* Helps identify suspicious or resource-intensive applications



### 📋 Security Event Monitoring

* Retrieves recent Windows Security Event Logs
* Displays:

  * Timestamp
  * Event ID
  * Severity Level




### 🛡️ File Integrity Verification

Calculates SHA256 hashes for critical Windows files:

* `C:\Windows\System32\ntoskrnl.exe`
* `C:\Windows\System32\winlogon.exe`

Useful for:

* Integrity verification
* Baseline comparison
* Malware investigations

![Class](./screenshots/6.jpg)



### 👤 User Account Auditing

Collects information about:

* Local user accounts
* Account status
* Last logon time


### ⚠️ Suspicious Account Detection

Identifies:

* Disabled accounts
* Recently active accounts

![Class](./screenshots/5.jpg)


### 🌐 Network Monitoring

Enumerates active TCP connections including:

* Local Address
* Local Port
* Remote Address
* Remote Port

![Class](./screenshots/2.jpg)




### 🚨 Suspicious Port Detection

Checks for connections on commonly abused ports:

| Port | Description                                    |
| ---- | ---------------------------------------------- |
| 1337 | Potential Backdoor Activity                    |
| 4444 | Reverse Shell / Penetration Testing Frameworks |

![Class](./screenshots/4.jpg)


### 💻 System Information Collection

Collects:

* Computer Name
* Domain
* Manufacturer
* Model

### 📊 Professional HTML Reporting

Features:

* Dark-themed interface
* Color-coded alerts
* Structured tables
* Easy-to-read layout


![Class](./screenshots/1.jpg)
---

## 📂 Project Structure

```text
DRyhon/
│
├── DRyhon.ps1
├── README.md
└── AuditReports/
```

---

## ⚙️ Requirements

### Supported Platforms

* Windows 10
* Windows 11
* Windows Server 2016+
* Windows Server 2019+
* Windows Server 2022+

### PowerShell

* PowerShell 5.1 or later

### Permissions

Run PowerShell as **Administrator** for full functionality.

---

## 🚀 Usage

Run the script from an elevated PowerShell session:

```powershell
powershell.exe -ExecutionPolicy Bypass -File .\DRyhon.ps1
```

---

## 📄 Report Output

Generated reports are stored in:

```text
C:\AuditReports\
```

Example:

```text
C:\AuditReports\DRArrow_20260610_143501.html
```

---

## 📈 Report Sections

The generated report includes:

* Top Processes by CPU Usage
* Recent Security Events
* File Integrity Check
* Local Users
* Suspicious Accounts
* Active Network Connections
* Suspicious Ports
* System Information

---

## 🎯 Use Cases

### Blue Team Operations

* Daily Security Audits
* Endpoint Monitoring
* Threat Hunting

### Incident Response

* Initial Host Triage
* Suspicious Activity Investigation
* Evidence Collection Support

### System Administration

* User Account Reviews
* Network Visibility
* System Health Monitoring

### Cybersecurity Training

* Lab Environments
* Security Demonstrations
* PowerShell Learning Projects

---

## 🔮 Future Enhancements

Planned features:

* Windows Defender Status Checks
* Scheduled Task Auditing
* Service Enumeration
* Startup Program Analysis
* Registry Auditing
* IOC Scanning
* PDF Report Export
* Email Notifications
* SIEM Integration
* Threat Intelligence Enrichment

---

## 👨‍💻 Author

### DrArrow

Cybersecurity Enthusiast | Security Researcher | IT Professional

DRyhon was developed to provide a fast, simple, and effective way to perform Windows security audits using native PowerShell capabilities.

---

## ⚠️ Disclaimer

This project is intended for:

* Defensive Security
* Security Auditing
* Educational Purposes
* System Administration

Users are responsible for ensuring compliance with all applicable laws, regulations, and organizational policies.

---

## 📜 License

MIT License

Copyright © 2026 DrArrow

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
