---
title: Set TLS1.1 and TLS1.2 in PowerShell
author: danijeljw
date: 2023-05-03 11:00:00 +1000
categories: [Other]
tags: [powershell]
series: ['Migrated from Jekyll']
aliases: ['migrate-from-jekyll']
cover:
  image: /images/logos/powershell.png
  caption: 'PowerShell logo'
ShowToc: true
TocOpen: true
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: 'Suggest Changes' # edit text
    appendFilePath: true # to append file path to Edit link
---

## Set TLS 1.1 and TLS 1.2 in PowerShell
Ensuring that your PowerShell scripts and applications use secure communication protocols is crucial for maintaining the security and integrity of data exchanges. Transport Layer Security (TLS) is a protocol that provides encryption for network communications, and TLS 1.1 and TLS 1.2 are widely used standards. In this article, we'll show you how to configure PowerShell to use these protocols.

## Why Set TLS 1.1 and TLS 1.2?
TLS 1.1 and TLS 1.2 offer enhanced security features compared to earlier versions of TLS. As of today, TLS 1.0 and earlier versions are considered outdated and vulnerable to various attacks. By using TLS 1.1 and TLS 1.2, you ensure that your applications benefit from improved security and encryption standards.

## How to Configure TLS 1.1 and TLS 1.2 in PowerShell
To set TLS 1.1 and TLS 1.2 as the security protocols for your PowerShell session, you can use the following command:

```powershell
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls
```

### Breakdown of the Command
- `[Net.ServicePointManager]::SecurityProtocol`: This property gets or sets the security protocol used by the ServicePointManager class for SSL/TLS connections.
- `[Net.SecurityProtocolType]::Tls12`: This specifies TLS 1.2 as one of the protocols to be used.
- `[Net.SecurityProtocolType]::Tls11`: This specifies TLS 1.1 as one of the protocols to be used.
- `[Net.SecurityProtocolType]::Tls`: This specifies the default TLS protocol, which could be TLS 1.0 in older environments but is generally less secure.

By setting these protocols, PowerShell will prefer the more secure TLS 1.2 over TLS 1.1, and only fall back to TLS 1.1 if TLS 1.2 is not supported by the server.

## Verifying the Configuration
After setting the protocols, you can verify that your configuration is effective by running a script that attempts to connect to a server using TLS. Check the logs or output to ensure that the desired protocol is being used.