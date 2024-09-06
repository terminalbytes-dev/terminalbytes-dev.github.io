---
title: "Rebuild Indexes in Oracle SQL"
date: 2024-06-18T14:11:00+10:00
# weight: 1
# aliases: ["/first"]
tags: ["sqltools"]
author: danijel
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Rebuild Indexes in Oracle SQL"
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
    alt: "<alt text>" # alt text
    caption: "Oracle SQL" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

## Obtain Number of Indexes

In the PROD database, query to get a total number of indexes currently found:

```sql
SELECT COUNT(*) AS index_count FROM USER_INDEXES;
```

Then run the same command in the NONPROD database, and find the total number of differences.

## Get List of FUNCIDX_STATUS Disabled

To find which indexes are `funcidx_status = 'DISABLED'`, run the following:

```sql
SELECT * FROM user_indexes WHERE status = 'VALID' AND funcidx_status = 'DISABLED';
```

## Rebuild FUNCIDX_STATUS Disabled Indexes

To automatically rebuild that list, run following command:

```sql
DECLARE
    CURSOR c_indexes IS
        SELECT index_name
        FROM user_indexes
        WHERE status = 'VALID'
          AND funcidx_status = 'DISABLED';
    v_index_name VARCHAR2(30);
BEGIN
    FOR r_index IN c_indexes LOOP
        v_index_name := r_index.index_name;
        EXECUTE IMMEDIATE 'ALTER INDEX ' || v_index_name || ' REBUILD ONLINE';
    END LOOP;
END;
/
```

If you want to time the process used to rebuild these indexes, you can add a timer to the function:

```sql
DECLARE
    CURSOR c_indexes IS
        SELECT index_name
        FROM user_indexes
        WHERE status = 'VALID'
          AND funcidx_status = 'DISABLED';
    v_index_name VARCHAR2(30);
    v_start_time TIMESTAMP;
    v_end_time TIMESTAMP;
BEGIN
    FOR r_index IN c_indexes LOOP
        v_index_name := r_index.index_name;
        
        -- Record start time
        v_start_time := SYSTIMESTAMP;
        
        -- Rebuild the index
        EXECUTE IMMEDIATE 'ALTER INDEX ' || v_index_name || ' REBUILD ONLINE';
        
        -- Record end time
        v_end_time := SYSTIMESTAMP;
        
        -- Output the time taken for each index
        DBMS_OUTPUT.PUT_LINE('Time taken to rebuild index ' || v_index_name || ': ' || (v_end_time - v_start_time));
    END LOOP;
END;
/
```
