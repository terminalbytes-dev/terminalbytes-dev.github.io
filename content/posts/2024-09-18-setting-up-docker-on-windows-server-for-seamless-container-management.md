---
title: "Setting Up Docker on Windows Server for Seamless Container Management"
date: 2024-09-11T16:50:00+10:00
# weight: 1
# aliases: ["/first"]
tags: ["Docker", "Windows Server", "PowerShell", "Installation", "Containers"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Guide to installing Docker on Windows Server, including enabling necessary features, installing through PowerShell, and verifying the installation."
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
    image: /images/logos/docker_logo.jpg # image path/url
    alt: "docker logo" # alt text
    caption: '' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

If you're looking to run containers on a Windows Server environment, Docker is your go-to solution. This guide walks you through installing Docker on Windows Server 2016 or later, ensuring a smooth setup for container orchestration.

## Prerequisites

- A running instance of Windows Server 2016 or later.
- Administrator access to the server.
- A basic understanding of PowerShell commands.

## Step 1: Enable Windows Features for Docker

Before installing Docker, ensure that the necessary features, like Containers and Hyper-V, are enabled on your Windows Server. These components are crucial for Docker's functionality, particularly for running Windows containers.

Open PowerShell as an Administrator and run the following commands:

```powershell
Install-WindowsFeature -Name Containers -Restart
Install-WindowsFeature -Name Hyper-V -IncludeManagementTools -Restart
```

These commands will enable the Containers feature and the Hyper-V role on your server. The `-Restart` flag is used to automatically reboot the server once the installation is complete, as a reboot is required for the changes to take effect.

## Step 2: Install Docker

With the necessary Windows features enabled, you can now proceed to install Docker. The simplest way is to use the DockerMsftProvider module, which allows you to install Docker directly from the PowerShell Gallery.

Run these commands in an elevated PowerShell session:

```powershell
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
```

- **Install-Module:** Fetches the DockerMsftProvider module from the PowerShell Gallery.
- **Install-Package:** Uses the DockerMsftProvider to install Docker on your system.

After the installation completes, you might be prompted to restart the server again. If so, execute:

```powershell
Restart-Computer
```

## Step 3: Verify Docker Installation

Once your system has restarted, you need to verify that Docker is installed and running correctly. Open PowerShell as an Administrator and run:

```powershell
docker version
```

This command outputs the Docker client and server versions, confirming that Docker is properly installed. You should see output similar to:

```yaml
Client:
 Version:           20.10.7
 API version:       1.41
 Go version:        go1.13.15
...

Server:
 Engine:
  Version:          20.10.7
  API version:      1.41 (minimum version 1.12)
...
```

## Step 4: Start the Docker Service (if needed)

Docker should start automatically upon installation. However, if it doesn't, you can manually start the Docker service:

```powershell
Start-Service docker
```

To ensure Docker starts automatically with the system:

```powershell
Set-Service -Name docker -StartupType Automatic
```

## Step 5: Testing Docker with a Hello World Container

To confirm that Docker is fully operational, run a test container using the classic "Hello World" image:

```powershell
docker run hello-world
```

Docker will pull the hello-world image from Docker Hub (if it's not already downloaded) and run it. The output should be a friendly message from Docker, confirming that your installation was successful.

## Step 6: Optional - Configuring the Docker Daemon

If you need to customize the Docker daemon settings, you can do so by modifying the daemon.json file located in C:\ProgramData\Docker\config. For instance, to change the default storage driver or enable debug mode, edit this file:

```json
{
  "storage-driver": "windowsfilter",
  "debug": true,
  "log-level": "info"
}
```

After editing the file, restart the Docker service to apply the changes:

```powershell
Restart-Service docker
```

## Troubleshooting Tips

- **Service Fails to Start:** If Docker fails to start, check the event logs or run Get-EventLog -LogName Application -Source Docker for detailed error messages.
- **Network Issues:** If containers have network issues, ensure that your network adapter is correctly configured and that Windows Firewall rules allow Docker traffic.
- **Compatibility:** Ensure that your Windows Server version is compatible with the version of Docker you are installing.

## Wrapping Up

With Docker now running on your Windows Server, you can start managing containers efficiently. Whether you're setting up a test environment, deploying microservices, or automating tasks, Docker on Windows Server provides a robust platform for containerized applications.

Happy containerizing!
