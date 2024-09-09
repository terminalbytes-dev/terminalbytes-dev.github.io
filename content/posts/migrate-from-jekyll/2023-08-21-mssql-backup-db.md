---
title: MSSQL Backup Db
author: danijeljw
date: 2023-08-21 11:00:00 +1000
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

To back up a database before deleting records, use SQL Server's backup functionality:

```sql
-- Back up the entire database
BACKUP DATABASE YourDatabaseName
TO DISK = 'C:\Backup\YourDatabaseBackup.bak';

-- Delete records from the table
DELETE FROM [YourDatabaseName].[dbo].[YourTableName];
```

Replace `YourDatabaseName` with your database's name and adjust the backup file path `'C:\Backup\YourDatabaseBackup.bak'` as needed.

**Note:** This approach backs up the entire database. For backing up just a specific table, consider exporting the table data to a file before deletion.