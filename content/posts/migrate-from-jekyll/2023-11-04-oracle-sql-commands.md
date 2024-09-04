---
title: Oracle SQL Commands
author: danijel
date: 2022-12-02 11:00:00 +1000
categories: [SQL,Oracle]
tags: [oracle,sql,reference,commands]
series: ['Migrated from Jekyll']
aliases: ['migrate-from-jekyll']
ShowToc: true
TocOpen: true
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: 'Suggest Changes' # edit text
    appendFilePath: true # to append file path to Edit link
cover:
  image: /images/logos/oracle-db580x224_tcm69-40873.jpg
  caption: 'Oracle DB logo'
---

This guide provides a set of essential Oracle SQL commands for database management. These commands cover basic querying, data export/import, and file management tasks.

### Basic Commands

| Use | Command |
|:----|:--------|
| Get current user | `SELECT USER FROM DUAL;` |
| Get current schema | `SELECT SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM DUAL;` |
| Get current schema and user | `SELECT USER, SYS_CONTEXT('USERENV', 'CURRENT_SCHEMA') AS CURRENT_SCHEMA FROM DUAL;` |
| List directory contents | `SELECT * FROM TABLE (dbmb_file_util.listdir(p_directory => 'YOUR_DIRECTORY')) ORDER BY mtime DESC;` |

### Finding Tables

To check if a table exists, use: 

```sql
SELECT table_name FROM user_tables WHERE table_name='YOUR_TABLE_NAME';
```

### Show Table Indexes

To list indexes for a specific table (use uppercase for table name):

```sql
SELECT index_name FROM dba_indexes WHERE table_name='YOUR_TABLE_NAME';
```

### Data Pump S3 Commands

#### Upload File

Upload a file from the local directory to an AWS S3 bucket:

| Key | Value |
|:----|:------|
| `your-s3-bucket` | S3 Bucket name |
| `your_file.dmp` | File to upload |
| `your_prefix/` | Target directory _(including trailing slash)_ |

```sql
SELECT dbms_s3_tasks.upload_to_s3(
    p_bucket_name    => 'your-s3-bucket',
    p_prefix         => 'your_file.dmp',
    p_s3_prefix      => 'your_prefix/',
    p_directory_name => 'YOUR_DIRECTORY'
) AS TASK_ID
FROM DUAL;
```

#### Check Transfer Status

To check the status of a transfer:

| Key | Value |
|:----|:------|
| `task_id` | Task ID |

```sql
SELECT text
FROM table(dbms_file_util.read_text_file('YOUR_DIRECTORY', 'transfer_task_id.log'));
```

#### Download File

Download a file from an AWS S3 bucket to local directory:

| Key | Value |
|:----|:------|
| `your-s3-bucket` | S3 Bucket name |
| `your_file.dmp` | File to download |
| `your_prefix/` | Source directory _(including trailing slash)_ |

```sql
SELECT dbms_s3_tasks.download_from_s3(
    p_bucket_name    => 'your-s3-bucket',
    p_s3_prefix      => 'your_prefix/your_file.dmp',
    p_directory_name => 'YOUR_DIRECTORY'
) AS TASK_ID
FROM DUAL;
```

#### List Directory Files

List all files in the directory

```sql
SELECT *
FROM TABLE(dbmbs_file_util.listdir(p_directory => 'YOUR_DIRECTORY'))
ORDER BY mtime DESC;
```

#### Delete Files

Delete files from directory

| Key | Value |
|:----|:------|
| `file_to_delete.dmp` | File to delete |

```sql
EXEC utl_file.remove('YOUR_DIRECTORY', 'file_to_delete.dmp');
```

### Export Data

#### Export User Tables

Export tables from a schema. Replace placeholders with actual values:


| Key | Value |
|:----|:------|
| `dbuser` | Database user |
| `password` | Database password |
| `source_db` | Source database |
| `target_schema` | Target schema |

```sql
expdp dbuser/password@source_db
tables=target_schema.TABLE1, target_schema.TABLE2
dumpfile=target_schema-tables.dmp
logfile=target_schema-tables.log
directory=YOUR_DIRECTORY
EXCLUDE=STATISTICS;
```

### Import Data

#### Import Data from .DMP File

Import data from a .dmp file:

| Key | Value |
|:----|:------|
| `password` | Database password |
| `source_db` | Database DNS entry |
| `target_schema` | Target schema |
| `data_file.dmp` | Data dump file |
| `import_log.log` | Log file name |
| `source_schema` | Source schema |

```sh
impdp dbuser/password@source_db schemas=target_schema dumpfile=data_file.dmp logfile=import_log.log directory=YOUR_DIRECTORY transform=oid:n remap_schema=source_schema:target_schema
```

#### Error Logs

To view error logs:

```sql
SELECT * FROM errorlog ORDER BY 1 DESC;
```
