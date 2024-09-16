---
title: "Preventing .pdb File Generation with dotnet Publish and CSPROJ Configuration"
date: 2024-09-11T04:06:00+10:00
# weight: 1
# aliases: ["/first"]
tags: ["dotnet", "publish", "CSPROJ", "DebugType", "PDB files"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "How to prevent .pdb file generation during dotnet publish using the DebugType option"
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
    image: /images/logos/c_sharp_logo.jpg # image path/url
    alt: "c sharp logo" # alt text
    caption: '' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

When publishing .NET applications, you might want to avoid generating .pdb files, which contain debugging information. This can help reduce the size of your deployment package and protect your source code.

To modify the `dotnet publish` command to prevent the creation of .pdb files, you can use the `-p:DebugType=none` option. Here's how you can adjust your publish command:

```bash
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -p:DebugType=none
```

This command publishes your project in Release mode, as a self-contained single file, targeting the `win-x64` runtime, and skips generating .pdb files.

If you prefer configuring this in your CSPROJ file, add the `<DebugType>none</DebugType>` property within your `<PropertyGroup>`. Here’s how your CSPROJ file should look:

```xml
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>net8.0</TargetFramework>
    <ImplicitUsings>disable</ImplicitUsings>
    <Nullable>enable</Nullable>
    <AssemblyName>MRIAwsRC</AssemblyName>
    <DebugType>none</DebugType> <!-- Prevents the PDB file from being generated -->
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="AWSSDK.Core" Version="3.7.304.16" />
    <PackageReference Include="AWSSDK.EC2" Version="3.7.330" />
    <PackageReference Include="AWSSDK.RDS" Version="3.7.313.13" />
  </ItemGroup>

</Project>
```

Adding `<DebugType>none</DebugType>` ensures that no .pdb files are produced during the build and publish processes, streamlining your deployment and enhancing security.