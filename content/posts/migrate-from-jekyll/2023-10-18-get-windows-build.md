---
title: Retrieve Windows OS Build
author: danijeljw
date: 2023-10-18 11:00:00 +1000
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

Retrieve Windows OS build from terminal by using the following code:

```powershell
$fullBuildNumber = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name BuildLabEx).BuildLabEx
$baseBuildNumber = $fullBuildNumber -split '\.' | Select-Object -First 2
$baseBuildNumber -join '.'
```
