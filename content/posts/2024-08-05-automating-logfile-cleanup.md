---
title: "Automating Log File Cleanup with PowerShell: An Optimized Approach"
date: 2024-08-05T13:57:00+10:00
# weight: 1
# aliases: ["/first"]
tags: ["dfs","replication"]
author: "Me"
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Efficiently manage and clean up old log files using an optimized powershell script"
disableHLJS: true # to disable highlightjs
disableShare: true
disableHLJS: false
hideSummary: false
searchHidden: true
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: /images/logos/powershell.png # image path/url
    alt: "powershell logo" # alt text
    caption: "<text>" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

Maintaining a clean and organized file system is crucial, especially when dealing with large volumes of log files that can quickly accumulate over time. To address this, we’ve developed a PowerShell script that automates the cleanup of old log files from a specific directory and its subdirectories. In this post, we’ll walk through what this script does and how it works.




## Script Overview

The script is designed to:

- Identify log files in a specified directory that are older than a defined number of days.
- Delete these old log files.
- Log the deletion operations to a specified log file for auditing purposes.
- This script is optimized to use .NET methods for file operations, ensuring efficiency and reliability.

## Script Location

The script is stored in the following path on our system:

```
E:\ApplicationName\forms\maintenance\Nonprod-LogFile-Cleanup-Optimized.ps1
```

## Key Components of the Script

### 1. Defining Variables

At the beginning of the script, several key variables are defined:

```powershell
$logDirectory = "\\\au-syd-fsx\share\IWMS\applicationname\logs"  # The root directory where the log files are located
$daysOld = 35                                             # Number of days to determine the age of log files
$logFile = "E:\ApplicationName\forms\maintainance\logs\deletion_log.txt"  # Path to the log file where operations will be recorded
$logDirectory specifies the root directory where the log files are stored.
$daysOld sets the threshold for file age. Files older than this value (in days) will be deleted.
$logFile is the path to the log file that will record all deletion operations.
```

### 2. Creating or Clearing the Log File

Before the script performs any operations, it checks if the log file exists. If it does, the file is cleared; if not, a new file is created:

```powershell
if ([System.IO.File]::Exists($logFile)) {
    [System.IO.File]::WriteAllText($logFile, "")
} else {
    [System.IO.File]::Create($logFile).Dispose()
}
```

### 3. Writing Log Entries

A custom function, Write-LogBatch, is defined to handle writing log entries in batch mode, ensuring efficient file I/O operations:

```powershell
function Write-LogBatch {
    param (
        [string[]]$messages
    )
    [System.IO.File]::AppendAllLines($logFile, $messages)
}
```

### 4. Checking Directory Existence

The script ensures that the specified log directory exists before proceeding. If the directory does not exist, the script logs an error and exits:

```powershell
if (-Not [System.IO.Directory]::Exists($logDirectory)) {
    Write-LogBatch @("$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - The specified directory does not exist: $logDirectory")
    exit
}
```

### 5. Calculating the Threshold Date

The script calculates the threshold date by subtracting the number of days specified in $daysOld from the current date:

```powershell
$thresholdDate = (Get-Date).AddDays(-$daysOld)
```

### 6. Identifying and Deleting Old Log Files

The script enumerates all .log files in the directory and its subdirectories, filtering those that were created before the threshold date. It then attempts to delete each of these files:

```powershell
$logFiles = [System.IO.Directory]::EnumerateFiles($logDirectory, "*.log", [System.IO.SearchOption]::AllDirectories) | 
            Where-Object { 
                $fileInfo = New-Object System.IO.FileInfo($_)
                ($fileInfo.CreationTime -lt $thresholdDate)
            }

$logMessages = @()

foreach ($file in $logFiles) {
    try {
        [System.IO.File]::Delete($file)
        $logMessages += "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Deleted: $file"
    } catch {
        $logMessages += "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Failed to delete: $file. Error: $_"
    }
}
```

### 7. Logging the Operations

Finally, if there are any log messages generated during the deletion process, the script writes them all at once to the log file:

```powershell
if ($logMessages.Count -gt 0) {
    Write-LogBatch $logMessages
}
```

By following the steps outlined above, you can customize and deploy this script in your environment, tailoring it to meet your specific needs. Regular log file cleanup is essential for maintaining optimal system performance and ensuring compliance with storage policies.
