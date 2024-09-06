---
title: "Quick Headless Raspberry Pi Setup: Enable SSH and Disable Desktop"
date: 2024-09-03T14:07:00+10:00
# weight: 1
# aliases: ["/first"]
tags: ["raspberry pi", "ssh", "headless raspberry pi", "devops", "raspberry pi configuration", "raspberry pi setup", "enable ssh", "remote management", "sd card configuration", "raspberry pi no gui", "raspberry pi cli", "systemd", "cmdline.txt", "linux", "iot", "raspberry pi for devops"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Enable SSH on a headless Raspberry Pi by editing SD card files. Perfect for DevOps engineers managing devices remotely."
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
    image: /images/logos/800px-Raspberry_Pi_OS_Logo.png # image path/url
    alt: "<alt text>" # alt text
    caption: 'raspberry pi os logo' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

For a fast headless setup on your Raspberry Pi, you can enable SSH and disable the desktop interface (GUI) by modifying files on the SD card without needing a monitor or keyboard.

## Enable SSH

1. **Insert the SD card** into your computer. Find the `boot` partition on the SD card, which is accessible from any operating system.

1. **Create an empty** `ssh` **file** in the `boot` partition:
    - On Linux/macOS:
    ```sh
    touch /Volumes/boot/ssh
    ```
    - On Windows (PowerShell):
    ```powershell
    New-Item -Path E:\ssh -ItemType File
    ```
    _(Replace `E:` with the correct drive letter of your SD card's boot partition.)_

1. **Re-insert the SD card** into your Raspberry Pi and power it on. SSH will now be enabled, allowing remote access.

## Disable Desktop (GUI)

To save system resources and boot directly into command-line mode, follow these steps:

1. **Open the** `cmdline.txt` **file** located in the `boot` partition.

1. **Add this to the end of the line:

    ```
    systemd.unit=multi-user.target
    ```
    Ensure everything stays on one line with no breaks.

1. **Save the file** and safely eject the SD card.

1. **Insert the SD card back** into your Raspberrry Pi and reboot. The Pi will not boot into text-based mode without loading the GUI.

By enabling SSH and disabling the GUI, you streamline your Raspberry Pi for remote management and optimize its performance, making it ideal for headless use in a variety of DevOps environments.