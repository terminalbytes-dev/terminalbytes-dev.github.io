---
title: "Dumping and Restoring PostgreSQL Tables via CLI"
date: 2025-03-28T00:44:00+10:00
tags: ["PostgreSQL", "pg_dump", "CLI", "Database", "Backup", "Restore"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "A concise guide to dumping and restoring individual PostgreSQL tables using the command line, including how to set environment passwords securely and handle table-level exports and imports with precision."
disableHLJS: true
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
    image: /images/logos/postgresql_logo.png
    alt: "PostgreSQL logo"
    caption: ''
    relative: false
    hidden: false
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes"
    appendFilePath: true
---

Dumping and restoring specific tables in PostgreSQL can be done cleanly and precisely using `pg_dump` and `pg_restore` or `psql`. This guide demonstrates how to perform table-level exports and re-imports from the command line while keeping authentication secure and automation-friendly.

## Prerequisites

- PostgreSQL client tools (`pg_dump`, `psql`, `pg_restore`) installed.
- Access to a PostgreSQL database with sufficient privileges.
- Terminal access with environment variable support.

## Setting the Password Securely

Before executing any PostgreSQL CLI command that requires authentication, set the environment variable `PGPASSWORD` to avoid interactive prompts:

```bash
export PGPASSWORD="MySecurePassword123!"
```

This allows commands like pg_dump and psql to run without prompting for the password each time. Always unset it afterward if you're not in a secure shell session:

```bash
unset PGPASSWORD
```

## Dumping a Single Table

To dump a specific table (e.g., `public.customers`) from a database (`mydb`) to a custom format file:

```bash
pg_dump -U postgres -d mydb -t public.customers -F c -f customers_table.dmp
```

- `-U postgres`: PostgreSQL username.
- `-d mydb`: Database name.
- `-t public.customers`: Table name including schema.
- `-F c`: Output format: custom.
- `-f customers_table.dmp`: Destination file name.

This produces a binary `.dmp` file that can be restored independently.

## Dumping in Plain SQL Format

If you prefer a human-readable `.sql` file:

```bash
pg_dump -U postgres -d mydb -t public.customers -F p > customers_table.sql
```

This is useful for quick diffs or editing before re-import.

## Dumping Multiple Tables

Use multiple `-t` flags for more than one table:

```bash
pg_dump -U postgres -d mydb -t public.customers -t public.orders -F c -f partial_backup.dmp
```

Or supply them via a pattern:

```bash
pg_dump -U postgres -d mydb -t 'public.sales_*' -F c -f sales_tables.dmp
```

## Restoring a Table from a .dmp File

To restore a table dump into another database (e.g., mydb_restored):

```bash
pg_restore -U postgres -d mydb_restored -F c customers_table.dmp
```

For plain SQL dumps:

```bash
psql -U postgres -d mydb_restored -f customers_table.sql
```

Ensure the destination table doesn’t already exist, or use the --clean flag:

```bash
pg_restore -U postgres -d mydb_restored --clean -F c customers_table.dmp
```

## Verifying Table Restore

After restoring, connect to the database and list the table:

```bash
psql -U postgres -d mydb_restored
```

Then check if the data is there:

```sql
SELECT COUNT(*) FROM public.customers;
```

Or list all restored tables:

```sql
\dt public.*
```

## Exporting Without Data (Schema Only)

For schema-only exports:

```bash
pg_dump -U postgres -d mydb -t public.customers --schema-only -F p > customers_schema.sql
```

This is helpful when migrating structure without content.

## Importing into a Different Schema

To remap a table into a different schema (e.g., from `public` to `archive`), you must modify the SQL file before restoring, or use `--schema` and manual preparation with the custom format.

---

Efficient table-level backups help isolate risk and streamline migrations. Use pg_dump with -t to selectively export data and pg_restore or psql to rehydrate as needed. For security, avoid hardcoding passwords and rely on PGPASSWORD only when appropriate.