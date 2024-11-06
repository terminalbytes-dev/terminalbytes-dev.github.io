---
title: "Adjust JVM RAM Settings"
date: 2023-07-18T11:00:00+10:00
# weight: 1
# aliases: ["/first"]
categories: ["Reference"]
series: ["Migrated from Jekyll"]
tags: ["jvm","ram","server","settings"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "SQLTools information"
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
    image: /images/logos/jvm_logo.png # image path/url
    alt: "<alt text>" # alt text
    caption: "JVM Logo" # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

By default, the JVM heap size is 1GB, which is usually enough to accomodate the data used by the Task Engine. However, a larger heap size may be required under some circumstances.

The JVM setting that we adjust the RAM on is located at:

```cmd
E:\manhattan\tomcat\Tomcat_IWMS\bin\Tomcat_IWMSw.exe
```

Double-click on this file and be presented with the following window:

![Tomcat Service JVM RAM Settings](/assets/img/2023/07/18/jvm_settings.png){: width="767" height="597" }

The setting for **Intial memory pool** should be set to 128, but the recommended minimum for **Maximum memory pool** should be 1024 _(1GB)_. In the last review for this on `AU-SYD-APPb`, it was noted to be only **512** on SYDA-NMH-APPa and **1024** on `SAU-SYD-APPb`. This will be updated to bring it inline with non-prod to **2048** from `RITM0093697`.

In general, changes to the maximum memory pool setting in Apache Tomcat's IWMS Properties under the Java tab require a restart of the Tomcat service to take effect. Restarting the service ensures that the changes are properly applied and the Tomcat server uses the new maximum memory pool value.

Keep in mind that restarting the Tomcat service will briefly interrupt the availability of your application or website hosted on Tomcat. It's a good practice to schedule service restarts during periods of low traffic or maintenance windows to minimize any potential impact on users.

After restarting the Tomcat service, it will start using the updated maximum memory pool value specified in the IWMS Properties.

The service that requires a restart is `Apache Tomcat_IWMS`, which will have a flow-on effect on the following clients:

- AGS _(urouter_ags_prod)_
- IR _(urouter_inlandrail_prod)_
- QGAO _(urouter_qgao_prod)_

The script to execute following the change could be considered like this, run as administrator:

```powershell
foreach ($i in @('AU-SYD-APPa','AU-SYD-APPb')) { Get-Service -ComputerName $i -Name "Tomcat_IWMS" | Restart-Service -Confirm:$false }
```

