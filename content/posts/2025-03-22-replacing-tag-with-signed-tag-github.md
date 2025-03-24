---
title: "Replacing Tag with Signed Tag on Github"
date: 2025-03-22T21:18:00+10:00
tags: ["Git", "GitHub", "Signed Tag", "Bash", "Version Control"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Learn how to replace an existing Git tag with a new signed tag to enhance security and traceability in your version control workflow."
disableHLJS: false
hideSummary: false
searchHidden: false
ShowReadingTime: true
ShowBreadCrumbs: true
ShowPostNavLinks: true
ShowWordCount: true
ShowRssButtonInSectionTermList: true
UseHugoToc: true
cover:
    image: /images/logos/github_logo.png
    alt: "Github Logo"
    caption: '' 
    relative: false 
    hidden: false 
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes"
    appendFilePath: true
---

When working with Git tags, there are times when you need to replace an existing tag with a new signed one to boost security and ensure authenticity. The script below automates the process by first removing any previous tag (both locally and remotely) and then creating and pushing a new signed tag—all with a few simple Bash commands.

## How the Script Operates

The process is broken down into these main steps:

1. Removing the Local Tag:  
   The script starts by attempting to delete the local tag specified by TAG_NAME. If it isn’t found, it simply notifies you rather than failing.

1. Removing the Remote Tag:  
   It then tries to remove the tag from your remote repository (defaulted to origin). If the tag doesn’t exist there, you get a friendly message, and the script continues.

1. Creating a New Signed Tag:  
   The core of the script uses git tag -s to create a signed tag. This signed tag is essential if you want cryptographic verification that the tag comes from you.

1. Verifying the Tag’s Signature:  
   After creating the tag, the script verifies the signature to ensure everything’s in order.

1. Pushing the New Tag:  
   Finally, the new signed tag is pushed to your remote repository, updating your shared codebase.

## The Script

Below is the complete script:

```bash
#!/usr/bin/env bash
set -e

TAG_NAME="v0.0.3"
TAG_MESSAGE="v0.0.3"
REMOTE="origin"

echo "Deleting local tag '$TAG_NAME' if it exists..."
git tag -d "$TAG_NAME" || echo "Local tag '$TAG_NAME' did not exist."

echo "Deleting remote tag '$TAG_NAME' if it exists..."
git push --delete "$REMOTE" "$TAG_NAME" || echo "Remote tag '$TAG_NAME' did not exist."

echo "Creating new signed tag '$TAG_NAME'..."
git tag -s "$TAG_NAME" -m "$TAG_MESSAGE"

echo "Verifying the tag signature..."
git tag -v "$TAG_NAME"

echo "Pushing new tag '$TAG_NAME' to remote '$REMOTE'..."
git push "$REMOTE" "$TAG_NAME"

echo "Tag '$TAG_NAME' has been updated with a signature."
```

## Breaking Down the Commands

### Script Setup:

The shebang (`#!/usr/bin/env bash`) ensures the script runs with Bash, and `set -e` makes it exit immediately if any command fails, preventing unexpected issues during execution.

### Variable Declarations:

Both `TAG_NAME` and `TAG_MESSAGE` are set to `"v0.0.3"`, making it easy to adjust for your versioning needs. The `REMOTE` variable is set to `"origin"`, which is typically your default remote repository name.

### Local Tag Deletion:

The command `git tag -d "$TAG_NAME"` removes the local tag if it exists. If it doesn’t, the script echoes a message rather than throwing an error.

### Remote Tag Deletion:

Similarly, `git push --delete "$REMOTE" "$TAG_NAME"` attempts to remove the tag from the remote repository, with a graceful fallback if the tag isn’t found.

### Creating the Signed Tag:

With `git tag -s "$TAG_NAME" -m "$TAG_MESSAGE"`, a new signed tag is created. This tag is verified using your GPG key, adding an extra layer of security.

### Verifying and Pushing the Tag:

The signature is verified with `git tag -v "$TAG_NAME"`, and finally, the new tag is pushed to the remote repository using git push "$REMOTE" "$TAG_NAME".

This script provides a neat way to automate the process of updating Git tags securely. It ensures that any outdated or unsigned tags are replaced with a signed version, keeping your release workflow robust and trustworthy.
