---
title: "Resolving AWS RDS Schema Privilege Issues with DBMS_SCHEDULER"
date: 2024-09-04T18:12:00+10:00
# weight: 1
# aliases: ["/first"]
tags: [ "AWS RDS", "DBMS_SCHEDULER", "ORA-27486", "ORA-00990", "email security", "SPF", "DKIM", "DMARC", "MTA-STS", "TLS-RPT", "BIMI", "DNS", "email authentication" ]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Resolve ORA-27486 and ORA-00990 errors in AWS RDS by ensuring proper privileges and using the MANAGE SCHEDULER role for DBMS_SCHEDULER tasks."
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
    image: /images/logos/oracle-db580x224_tcm69-40873.jpg # image path/url
    alt: "Oracle logo" # alt text
    caption: 'oracle logo' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

When working with Oracle databases on AWS RDS, you may encounter privilege-related errors while attempting to schedule jobs using the DBMS_SCHEDULER package. If you face an issue where your schema user lacks the necessary privileges, here's a guide to help you troubleshoot and resolve the problem.

## Issue: Insufficient Privileges

Consider a scenario where you run the following script in AWS RDS as a schema user:

```sql
BEGIN
  DBMS_SCHEDULER.DISABLE1_CALENDAR_CHECK();
  DBMS_SCHEDULER.CREATE_SCHEDULE(
    schedule_name => 'NEWCOUNT',
    start_date => NULL,
    repeat_interval => 'FREQ=HOURLY;INTERVAL=1',
    end_date => NULL
  );
  COMMIT;
END;
/
```

If you encounter the error:

```yaml
ORA-27486: insufficient privileges
ORA-06512: at "SYS.DBMS_ISCHED", line 1179
ORA-06512: at "SYS.DBMS_SCHEDULER", line 1652
ORA-06512: at line 2
```

## Understanding the Issue

The `ORA-27486: insufficient privileges` error indicates that the schema user does not have the necessary privileges to perform operations with `DBMS_SCHEDULER`. This package requires specific privileges that are not granted to regular schema users by default.

## Privileges Required

To work with `DBMS_SCHEDULER`, you typically need the following privileges:

- **CREATE JOB:** To create and manage scheduler jobs.
- **CREATE SCHEDULE:** To create and manage scheduler schedules.
- **CREATE PROGRAM:** To create and manage scheduler programs.

## Steps to Resolve

1. **Check User Privileges**

Ensure that the schema user has been granted the required privileges. You may need to request these privileges from your DBA or AWS RDS admin.

```sql
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'your_user';
```

1. **Grant Required Roles and Privileges**

For scheduling tasks in Oracle, you typically need the `MANAGE SCHEDULER` role, which includes the necessary privileges to create and manage schedules, jobs, and programs. The `CREATE SCHEDULE` privilege is not valid on its own in Oracle.

As a DBA, you can grant the role using:

```sql
GRANT MANAGE SCHEDULER TO your_user;
```

1. **Verify Existing Roles**

Check if the schema user has been granted the MANAGE SCHEDULER role:

```sql
SELECT * FROM DBA_ROLE_PRIVS WHERE GRANTEE = 'your_user';
```

1. **Retry Running Your Script**

After ensuring the correct privileges are granted, retry running your script.

## Example Script After Grant

Here's an updated version of your script after ensuring that the correct privileges are granted:

```sql
BEGIN
  DBMS_SCHEDULER.DISABLE1_CALENDAR_CHECK();
  DBMS_SCHEDULER.CREATE_SCHEDULE(
    schedule_name => 'NEWCOUNT',
    start_date => NULL,
    repeat_interval => 'FREQ=HOURLY;INTERVAL=1',
    end_date => NULL
  );
  COMMIT;
END;
/
```

## AWS RDS Specific Considerations

AWS RDS for Oracle might have some restrictions or differences compared to traditional on-premises Oracle installations. Make sure to consult the [AWS RDS documentation](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_Oracle.html) for any specific restrictions or additional configuration that might be required.

By following these steps, you can resolve privilege issues and successfully utilize the `DBMS_SCHEDULER` package in your AWS RDS Oracle environment. If problems persist, consult AWS RDS support or Oracle documentation for further assistance.
