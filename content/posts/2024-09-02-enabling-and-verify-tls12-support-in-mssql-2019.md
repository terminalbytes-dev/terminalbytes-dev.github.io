---
title: "Enabling and Verifying TLS 1.2 Support in Microsoft SQL Server 2019"
date: 2024-09-03T10:35:00+10:00
# weight: 1
# aliases: ["/first"]
tags: ["sql server", "tls 1.2", "database security", "microsoft sql server 2019", "encryption", "it security", "network configuration", "sql server configuration", "windows server", "data protection", "mssql2019", "mssql"]
author: danijel
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Learn how to enable and verify TLS 1.2 support in Microsoft SQL Server 2019 to ensure secure data communications."
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
    image: /images/logos/microsoft-sql-server-logo.png # image path/url
    alt: "MSSQL logo" # alt text
    caption: 'MSSQL logo' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

Ensuring secure communications is crucial in today’s digital landscape, and Transport Layer Security (TLS) 1.2 is a vital protocol for encrypted data transfers. If you’re running Microsoft SQL Server 2019, it’s essential to confirm that it is configured to use TLS 1.2. This guide will walk you through the steps to enable and verify TLS 1.2 support for your SQL Server 2019 instance.

## Step 1: Verify SQL Server 2019 Version

Before diving into configurations, ensure you're using SQL Server 2019. To check the version:

1. Open **SQL Server Management Studio (SSMS)**.
1. Connect to your SQL Server instance.
1. Run the following SQL query:
    ```sql
    SELECT @@VERSION
    ```
    This command will display the current SQL Server version and edition.


## Step 2: Update Windows Server

TLS 1.2 support requires that your operating system is up to date. Follow these stesps to ensure your Windows Server is current:

1. Go to **Settings > Update & Security > Windows Update**.
1. CHeck for updates and install any available updates, including critical security patches.

## Step 3: Enable TLS 1.2 on Windows Server

To configure Windows Server to support TLS 1.2:

1. **Open Registry Editor:**
    - Press `Win + R`, type `regedit`, and press Enter.
1. **Navigate to the Registry Key:**
    - Go to: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\`
1. **Create TLS 1.2 Keys:**
    - Right-click on `Protocols`, select **New > Key**, and name it `TLS 1.2`.
    - Right-click on `TLS 1.2`, select **New > Key**, and name it `Client`.
    - Right-click on `TLS 1.2`, select **New > Key**, and name it `Server`.
1. **Create DWORD Values:**
    - For both `CLient` and `Server` keys, create two DWORD values:
        - Right-click on the `Client` or `Server` key, select **New > DWORD (32-bit) Value**.
        - Name it `Enabled` and set its value to `1`.
        - Name it `DisabledByDefault` and set its value to `0`.
1. **Restart the Server:**
    - Close Registry Editor and restart your server to apply the changes.

## Step 4: Configure SQL Server to Use TLS 1.2

SQL Server 2019 generally uses the system-level TLS configuration. However, ensuring that your SQL Server is up to date is crucial:

1. **Update SQL Server:**
    - Make sure your SQL Server 2019 instance is updated to the latest server pack or cumulative update. These updates may include important patches for TLS 1.2 support.
1. **Verify Network Configuration:**
    - Open **SQL Server Configuration Manager**.
    - Navigate to **SQL Server Network Configuration > Protocol for [Your Instance]**.
    - Confirm that **TCP/IP** is enabled.

## Step 5: Verify TLS 1.2 Usage

To ensure SQL Server is using TLS 1.2:

1. **Check SQL Server Error Logs:**
    - Open **SQL Server Management Studio (SSMS)**.
    - Access the **Error Logs** under the Management node.
    - Look for entries indicating that TLS 1.2 is being utilized.
1. **Use Network Monitoring Tools:**
    - Employ network monitoring tools like Wireshark to verify that TLS 1.2 is being used for connections to your SQL Server.
1. **Verify Connection Encryption:**
    - Execute the following SQL query:
    ```sql
    SELECT * FROM sys.dm_exec_connections WHERE encrypt_option = 'TRUE';
    ```
    - This query checks if encryption is enabled for connections.

Configuring and verifying TLS 1.2 support in SQL Server 2019 is crucial for ensuring secure communications. By following these steps, you can confirm that your SQL Server is using the latest and most secure version of TLS for encrypted connections. Regular updates and proper configuration will help maintain the security and integrity of your data.

If you encounter any issues or need further assistance, consult Microsoft’s documentation or support resources for additional troubleshooting.
