---
title: "Understanding Email Security Protocols"
date: 2024-09-06T14:11:26+10:00
# weight: 1
# aliases: ["/first"]
tags: ["email security", "SPF", "DKIM", "DMARC", "MTA-STS", "TLS-RPT", "BIMI", "DNS", "email authentication"]
author: danijel
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Overview of essential email security protocols like SPF, DKIM, DMARC, MTA-STS, TLS-RPT, and BIMI to enhance email authentication and protection."
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
    image: static/images/logos/email-security-cover-art.jpg # image path/url
    alt: "email security" # alt text
    caption: 'email security' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

Email security relies on several key protocols that protect against phishing, spoofing, and ensure secure email delivery. Here’s a breakdown of essential protocols to configure for secure email communication.

## DNS (Domain Name System)

DNS translates human-readable domain names into IP addresses, making it essential for both general internet communication and email security.

**Example:**

```sh
# To view DNS records, use dig:
dig example.com

# Output will include A, MX, TXT, and other records.
```

For email security, DNS is where you configure critical TXT and CNAME records for protocols like SPF, DKIM, and DMARC.

## SPF (Sender Policy Framework)

SPF helps prevent email spoofing by allowing domain owners to specify which mail servers are authorized to send emails on behalf of their domain.

**SPF Record Example:**

```txt
v=spf1 include:example.com -all
```

For email security, DNS is where you configure critical TXT and CNAME records for protocols like SPF, DKIM, and DMARC.

## SPR (Sender Policy Framework)

SPF helps prevent email spoofing by allowing domain owners to specify which mail servers are authorized to send emails on behalf of their domain.

**SPF Record Example:**

```txt
v=spf1 include:example.com -all
```

This record states that only servers from `example.com` are authorized to send emails for this domain. Non-authorized servers will cause the email to fail SPF checks.

**Command to verify SPF:**

```sh
dig TXT example.com
```

## DKIM (DomainKeys Identified Mail)

DKIM signs outgoing emails with a private key, ensuring the recipient’s server can verify the authenticity of the email by checking the corresponding public key in the DNS.

**Setting up DKIM:**
1. Generate DKIM keys (public/private).
1. Add the public key as a DNS TXT record.
1. Configure your mail server to sign outgoing emails with the private key.

**DKIM Record Example:**

```txt
v=DKIM1; k=rsa; p=MIIBIjANBgkq...
```

**Command to check DKIM status:**

```sh
dig TXT default._domainkey.example.com
```

## MTA-STS (Mail Transfer Agent Strict Transport Security)

MTA-STS enforces the use of TLS encryption for email in transit, preventing man-in-the-middle attacks by ensuring secure email delivery.

**MTA-STS Policy Example:**

```txt
version: STSv1
mode: enforce
mx: mail.example.com
max_age: 86400
```

This policy is stored at `https://mta-sts.example.com/.well-known/mta-sts.txt` and is used by sending servers to enforce encryption.

**DNS Record for MTA-STS:**

```txt
_tlsrpt.example.com. IN TXT "v=TLSRPTv1; rua=mailto:tls-reports@example.com"
```

## TLS-RPT (Transport Layer Security Reporting)

TLS-RPT helps by reporting any issues when email servers fail to establish a secure TLS connection. This makes it easier to track and fix any security problems with email encryption.

**TLS-RPT DNS Record Example:**

```txt
_tlsrpt.example.com. IN TXT "v=TLSRPTv1; rua=mailto:tls-reports@example.com"
```

The specified email address will receive reports on failed TLS connections.

## BIMI (Brand Indicators for Message Identification)

BIMI enables organizations to display their logo in recipients' inboxes if the email passes authentication checks, enhancing brand visibility and recipient trust.

**BIMI Record Example:**

```txt
default._bimi.example.com.  IN  TXT  "v=BIMI1; l=https://example.com/logo.svg"
```

This record points ot the location of your logo file, usually an SVG, to be displayed next to authenticated emails.
