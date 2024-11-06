---
title: "Generating SSH Keys with Positional Parameters"
date: 2024-11-06T08:00:00+10:00
tags: ["ssh-keygen", "SSH Keys", "Positional Parameters", "Linux", "Bash"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "A guide to generating ECDSA SSH keys with user-defined positional parameters for key file names and comments. Learn to create SSH keys using a single, flexible command."
disableHLJS: true
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
    image: /images/logos/ssh-keygen.png
    alt: "SSH Key Generation"
    caption: ''
    relative: false
    hidden: false
---

Generating SSH keys is a crucial part of managing secure access, especially for tasks like server administration, CI/CD setups, and automation. Here’s how to create flexible SSH keys using a one-liner that supports user-defined positional parameters, letting you adjust the key type, bit size, file name, and comment on the fly.

## Command Overview

With this approach, you can set default values for each parameter while allowing flexibility in how the command is executed.

### Command with Positional Parameters

The following shell script uses positional parameters to dynamically create an SSH key:

```bash
#!/bin/bash
ssh-keygen -t ${1:-ecdsa} -b ${2:-521} -f ~/.ssh/${3:-default-key} -C "${4:-no-comment}" -N ""
```

#### Explanation:
- `${1:-ecdsa}`: Sets the key type. Defaults to ecdsa if no type is specified.
- `${2:-521}`: Sets the bit size, defaulting to 521.
- `${3:-default-key}`: Defines the output filename, defaulting to default-key.
- `${4:-no-comment}`: Provides an optional comment for easier key identification.
- `-N ""`: Specifies an empty passphrase.

### Using the Command

This command allows flexibility, letting you provide only the parameters you need while relying on sensible defaults for the rest.

#### Full Example

To generate a **4096-bit RSA key** with the filename my-key and a comment:

```bash
./generate-ssh-key.sh rsa 4096 my-key "custom comment"
```

This generates an RSA key with 4096 bits, saving it to `~/.ssh/my-key` and adding `"custom comment"` as the comment.

#### Default Example

Running the command without any arguments will create a **521-bit ECDSA key** named `default-key` with no comment:

```bash
./generate-ssh-key.sh
```

#### Partial Example

To create a **256-bit ECDSA key** named `custom-key`:

```bash
./generate-ssh-key.sh ecdsa 256 custom-key
```

This approach offers a straightforward and flexible method to generate SSH keys dynamically, making it ideal for script-based deployments or automation tasks. Each parameter has a default, ensuring that the command works even if you don’t specify every value.