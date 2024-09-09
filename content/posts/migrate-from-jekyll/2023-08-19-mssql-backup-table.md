---
title: MSSQL Backup Table
author: danijeljw
date: 2023-08-19 11:00:00 +1000
categories: [SQL,MSSQL]
tags: [sql,mssql,microsoft]
series: ['Migrated from Jekyll']
aliases: ['migrate-from-jekyll']
cover:
  image: /images/logos/microsoft-sql-server-logo.png
  caption: 'MSSQL Logo'
ShowToc: true
TocOpen: true
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: 'Suggest Changes' # edit text
    appendFilePath: true # to append file path to Edit link
---

## MSSQL Backup Table

Exporting data from a SQL Server table can be efficiently managed using PowerShell. This guide provides a simple approach to exporting data from a specified table to a CSV file.

```powershell
# PowerShell script to export table data
$sqlInstance = "YOUR_SQL_SERVER_INSTANCE"
$db = "YOUR_DATABASE_NAME"
$schema = "YOUR_SCHEMA_NAME"
$table = "YOUR_TABLE_NAME"
$csvOutfile = "C:\path\to\output\${table}_BACKUP.csv"

# Check and create the directory if necessary
$directory = [System.IO.Path]::GetDirectoryName($csvOutfile)
if (-not (Test-Path -Path $directory)) {
    New-Item -Path $directory -ItemType Directory -Force
}

# Execute SQL query and export to CSV
Invoke-SqlCmd -Query "SELECT * FROM [${db}].[${schema}].[${table}];" -ServerInstance "${sqlInstance}" |
    Export-Csv -Path $csvOutfile -NoTypeInformation -Force -Confirm:$false
```

### Instructions

1. Replace YOUR_SQL_SERVER_INSTANCE, YOUR_DATABASE_NAME, YOUR_SCHEMA_NAME, and YOUR_TABLE_NAME with your specific SQL Server details.
1. Adjust the $csvOutfile path to match your preferred output directory.

This script simplifies the data export process and ensures the output directory is created if it doesn't already exist.

For further adjustments or suggestions, please visit [this GitHub repository](https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content) and suggest modifications.