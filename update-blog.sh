#!/usr/bin/env bash

# exit immediately if a command exits with a non-zero status
set -e

# Run hugo command
hugo

# Check the exit status of the last command
if [ $? -ne 0 ]; then
  echo "Error: Hugo build failed."
  exit 1
else
  echo "Hugo build succeeded."
  git add .
  git commit -m 'update blog'
  git push --set-upstream origin dev
  git push
fi
