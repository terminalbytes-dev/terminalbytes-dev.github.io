#!/usr/bin/env bash

# exit immediately if a command exits with a non-zero status
set -e

# Check docker is running
if docker info > /dev/null 2>&1; then
    echo "Docker is running."
else
    echo "Docker is not running." >&2
    exit 1
fi

# Build docker image
docker build -t my-hugo:0.128.0 .

# Test the build of the site
docker run --rm -v "$PWD":/app my-hugo:0.128.0 hugo --gc --minify

