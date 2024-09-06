---
title: "How to Completely Clear Git History in a Repo"
date: 2024-09-01T14:47:00+10:00
# weight: 1
# aliases: ["/first"]
tags: [git", "clear git history", "devops", "git reset", "remove secrets", "git force push", "git orphan branch", "git cleanup", "repository cleanup", "version control"]
author: danijeljw
showToc: true
TocOpen: false
draft: false
hidemeta: false
comments: false
description: "Learn how to completely clear Git history in your repository, remove sensitive data, and start fresh while keeping your current project files intact."
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
    image: /images/logos/640px-Git-logo.png # image path/url
    alt: "<alt text>" # alt text
    caption: 'raspberry pi os logo' # display caption under cover
    relative: false # when using page bundles set this to true
    hidden: false # only hide on current single page
editPost:
    URL: "https://github.com/terminalbytes-dev/terminalbytes-dev.github.io/tree/main/content"
    Text: "Suggest Changes" # edit text
    appendFilePath: true # to append file path to Edit link
---

Accidentally committed secrets or need to clean up the Git history in your repository? Here’s a quick and effective way to completely reset your Git history without losing the current state of your project.

## Why Clear Git History?

- **Sensitive data:** Remove secrets from history.
- **Simplified respository:** Reduce clutter and size.
- **Start fresh:** After significant changes.

## Steps to Clear Entire Git History

1. **Create a new orphan branch:** This branch has no history
    ```sh
    git checkout --orphan latest_branch
    ```

1. **Add all files:** Stage your current project files
    ```sh
    git add .
    ```

1. **Make the first commit:** Create a new commit for the current project state
    ```sh
    git commit -m "Initial commit with cleaned history"
    ```

1. **Delete the old `main` branch:** Remove the old branch with the unwanted history
    ```sh
    git branch -D main
    ```

1. **Rename orphan branch to `main`:** Replace the old branch with the new clean branch
    ```sh
    git branch -m main
    ```

1. **Force-push to the remote:** Push the new clean history to your repository, overwriting the old one
    ```sh
    git push --force origin main
    ```

1. **(Optional) Delete old tags:** If necessary, remove any old tags pointing to the previous history.
    ```sh
    git tag -l | xargs git tag -d
    git push origin --delete $(git tag -l)
    ```

1. **Clean up local references:** Remove any leftover local references to the old history
    ```sh
    git reflog expire --expire=now --all
    git gc --prune=now --aggressive
    ```

By following these steps, you’ve completely cleared the Git history while retaining your current project files. This method ensures you have a fresh start without old commits lingering in your repository. It's a practical solution for sensitive data removal or simplifying your repository's state in any environment.
