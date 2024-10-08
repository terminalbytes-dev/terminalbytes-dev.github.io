---
title: "Efficient Oracle User and Role Management with Dynamic SQL"
date: 2024-10-06T15:54:00+10:00
# weight: 1
# aliases: ["/first"]
tags: ["Oracle", "PL/SQL", "User Management", "Role Management", "Automation", "Database Security"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "A quick guide on automating Oracle user and role management using PL/SQL. Learn how to dynamically create users, assign custom roles, and manage schema permissions with this efficient approach."
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
    image: /images/logos/PL-SQL-Commands1.jpg # image path/url
    alt: "PL/SQL" # alt text
    caption: '' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

Automating Oracle database user and role management can streamline processes and improve security. Here's a quick breakdown of a PL/SQL script that handles user creation, role assignment, and permission management efficiently.

## Key Actions

1. **Drop Existing User:** Before creating a user, we drop the existing user if found to avoid conflicts:

```sql
EXECUTE IMMEDIATE 'DROP USER' || v_user_name || 'CASCADE';
```

An exception is handled if the user doesn't exist.

2. **Create User:** After cleanup, the script creates a new user:

```sql
EXECUTE IMMEDIATE 'CREATE USER ' || v_user_name || ' IDENTIFIED BY ' || v_password;
```

3. **Create Custom Role:** This role is built to be read-only:

```sql
EXECUTE IMMEDIATE 'CREATE ROLE ' || v_role_name;
```

4. **Limit Permissions:** Excessive privileges are revoked to ensure strict access:
```sql
EXECUTE IMMEDIATE 'REVOKE DBA FROM ' || v_role_name;
```
5. **Grant SELECT Permissions:** The role is granted SELECT privileges on all tables within the specified schema:\

```sql
FOR t IN (SELECT table_name FROM all_tables WHERE owner = v_schema_name) LOOP
   EXECUTE IMMEDIATE 'GRANT SELECT ON ' || v_schema_name || '.' || t.table_name || ' TO ' || v_role_name;
END LOOP;
```

6. **Assign Role to User:** Finally, the user is granted the custom role and session access:

```sql
EXECUTE IMMEDIATE 'GRANT ' || v_role_name || ' TO ' || v_user_name;
```

The script commits the changes after execution. This simple approach to managing Oracle user roles and permissions helps automate routine tasks, ensuring security and consistency across database environments.

## Entire Script

```sql
DECLARE
   v_schema_name VARCHAR2(30) := 'TARGET_SCHEMA_NAME_HERE';
   v_user_name VARCHAR2(30) := 'INTENDED_USERNAME_HERE';
   v_password VARCHAR2(30) := 'INTENDED_USERPASSWORD_HERE';
   v_role_name VARCHAR2(30) := 'INTENDED_USERROLE_HERE';
BEGIN
   -- #1: Drop the user if it exists
   BEGIN
      EXECUTE IMMEDIATE 'DROP USER ' || v_user_name || ' CASCADE';
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE != -1918 THEN -- ORA-01918: user does not exist
            RAISE;
         END IF;
   END;

   -- #2: Create user with password
   EXECUTE IMMEDIATE 'CREATE USER ' || v_user_name || ' IDENTIFIED BY ' || v_password;

   -- #3: Make custom read-only role
   BEGIN
      EXECUTE IMMEDIATE 'CREATE ROLE ' || v_role_name;
   EXCEPTION
      WHEN OTHERS THEN
         IF SQLCODE != -1920 THEN -- ORA-01920: role does not exist
            RAISE;
         END IF;
   END;

   -- #4: Remove any excessive permissions from role
   EXECUTE IMMEDIATE 'REVOKE SELECT_CATALOG_ROLE FROM ' || v_role_name;
   EXECUTE IMMEDIATE 'REVOKE DBA FROM ' || v_role_name;
   EXECUTE IMMEDIATE 'REVOKE SELECT ANY DICTIONARY FROM ' || v_role_name;
   EXECUTE IMMEDIATE 'REVOKE SELECT ON ALL_USERS FROM ' || v_role_name;
   EXECUTE IMMEDIATE 'REVOKE SELECT ON DBA_USERS FROM ' || v_role_name;
   EXECUTE IMMEDIATE 'REVOKE SELECT ON ALL_TRIGGERS FROM ' || v_role_name;
   EXECUTE IMMEDIATE 'REVOKE SELECT ON DBA_TRIGGERS FROM ' || v_role_name;

   -- #5: Grant SELECT on all tables in the specified schema to the role
   FOR t IN (SELECT table_name FROM all_tables WHERE owner = v_schema_name) LOOP
      EXECUTE IMMEDIATE 'GRANT SELECT ON ' || v_schema_name || '.' || t.table_name || ' TO ' || v_role_name;
   END LOOP;

   -- #6: Grant the custom role and CREATE SESSION privilege to the user
   EXECUTE IMMEDIATE 'GRANT ' || v_role_name || ' TO ' || v_user_name;
   EXECUTE IMMEDIATE 'GRANT CREATE SESSION TO ' || v_user_name;

   -- #7: Commit the changes
   COMMIT;
END;
/
```