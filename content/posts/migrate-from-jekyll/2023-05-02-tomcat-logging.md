---
title: Tomcat Logging
author: danijeljw
date: 2023-05-02 11:00:00 +1000
categories: [Other]
tags: [tomcat,logging,logs,log]
series: ['Migrated from Jekyll']
aliases: ['migrate-from-jekyll']
ShowToc: true
TocOpen: true
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: 'Suggest Changes' # edit text
    appendFilePath: true # to append file path to Edit link
---

Tomcat logs are generated for localhost access. Files are named `localhost_access_log.yyyy-MM-dd.txt` and located at `E:\ApplicationName\Tomcat\<client_env>\conf`.

Line item of a file is structured like:

```
140.168.75.129 - - [02/May/2023:00:06:11 +1000] "POST /<client_env>/wrd/run/SPDEDMHAPI.GRIDGET HTTP/1.1" [74553] 200 1435175
```

Here's a breakdown of each part of the example log entry you provided:

- `140.168.75.129`: This is the IP address of the remote client that made the request.
- `-`: This indicates that no remote user was authenticated for this request.
- `-`: This indicates the user that made the request is unknown.
- `[02/May/2023:00:06:11 +1000]`: This is the timestamp of the request, in the format [day/month/year:hour:minute:second timezone]. In this example, the timezone is +1000, which indicates the time is in Australian Eastern Standard Time (AEST).
- `"POST /<client_env>/wrd/run/SPDEDMHAPI.GRIDGET HTTP/1.1"`: This is the request line, which contains the HTTP method (POST), the requested URL _(/<client_env>/wrd/run/SPDEDMHAPI.GRIDGET)_, and the HTTP version (HTTP/1.1).
- `[74553]`: This is the response time, in milliseconds. In this case, it took 74553 milliseconds (or 74.553 seconds) for the server to generate the response to the request.
- `200`: This is the HTTP status code returned by the server. In this case, it is 200, which means "OK".
- `1435175`: This is the size of the response body, in bytes. In this case, it is 1435175 bytes, or approximately 1.4 MB.