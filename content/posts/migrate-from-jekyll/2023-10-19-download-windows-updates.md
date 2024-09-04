---
title: Download Windows Updates
author: danijel
date: 2023-10-19 11:00:00 +1000
categories: [PowerShell]
tags: [powershell,posh,windows,updates]
series: ['Migrated from Jekyll']
aliases: ['migrate-from-jekyll']
ShowToc: true
TocOpen: true
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: 'Suggest Changes' # edit text
    appendFilePath: true # to append file path to Edit link
---

Download Windows KB Updates using PowerShell:

```powershell
# Specify the SSL/TLS protocol version (adjust as needed)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Set params
$cve = "CVE-2023-36884"
$rootPath = "E:\temp"
$msu = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/10/windows10.0-kb5031362-x64_d5547372d929a0cfcd12559f75d03507ce6c5d8b.msu"
$msuList = @(
    "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/09/windows10.0-kb5030504-x64_5451b059e3ada37433b65b36ab51bc4c785aab47.msu",
    "https://catalog.s.download.windowsupdate.com/d/msdownload/update/software/secu/2023/10/windows10.0-kb5031362-x64_d5547372d929a0cfcd12559f75d03507ce6c5d8b.msu"
    
)

# Create directory
New-Item -Path "${rootPath}\${cve}" -ItemType Directory -Force -Confirm:$false

# Switch between msu and msuList
if ($msuList.Count -gt 1) {
    foreach ($msu in $msuList) {
        # Download file locally
        Invoke-WebRequest -UseBasicParsing -Uri $msu -OutFile "${rootPath}\${cve}\$(Split-Path -Path $msu -Leaf)"
    }
}
else {
    # Download file locally
    Invoke-WebRequest -UseBasicParsing -Uri $msu -OutFile "${rootPath}\${cve}\$(Split-Path -Path $msu -Leaf)"
}
```

This example has `$msuList` provided. And that will run. If you need to run just a single `$msu`, then set `$msuList` to a zero count:

```powershell
$msuList = @()
```