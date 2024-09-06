---
title: Change AD Domain User Password
author: danijeljw
date: 2023-11-06 11:00:00 +1000
categories: [Windows]
tags: [windows,ad,domain,controller,user,account,password,change]
series: ['Migrated from Jekyll']
aliases: ['migrate-from-jekyll']
ShowToc: true
TocOpen: true
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: 'Suggest Changes' # edit text
    appendFilePath: true # to append file path to Edit link
---

To change your Windows domain password from any machine connected to the domain, follow these steps:

1. Open PowerShell.
1. Run the following command:

```powershell
net user $env:USERNAME <new_password> /domain
```

Replace `<new_password>` with your desired new password.

This command updates your password on the domain controller without requiring your current password. It’s a good practice to update your password regularly, such as monthly, to maintain security.
