#!/usr/bin/env bash
# Exit immediately if any command fails.
set -e

# -----------------------------------------------------------------------------
# Check if Docker is running.
# -----------------------------------------------------------------------------
if docker info > /dev/null 2>&1; then
    echo "Docker is running."
else
    echo "Docker is not running." >&2
    exit 1
fi

# -----------------------------------------------------------------------------
# Build Docker image for Hugo.
# -----------------------------------------------------------------------------
echo "Building Docker image 'my-hugo:0.128.0'..."
docker build -t my-hugo:0.128.0 .

# -----------------------------------------------------------------------------
# Test the Hugo build.
# Temporarily disable exit-on-error to capture the exit code.
# -----------------------------------------------------------------------------
echo "Running Hugo build with garbage collection and minification..."
set +e
docker run --rm -v "$PWD":/app my-hugo:0.128.0 hugo --gc --minify
exit_code=$?
set -e

if [ $exit_code -ne 0 ]; then
    echo "Error: Hugo build failed." >&2
    exit $exit_code
else
    echo "Hugo build succeeded."
    
    # -----------------------------------------------------------------------------
    # Commit and push changes to Git.
    # -----------------------------------------------------------------------------
    git add .
    git commit -m 'update blog'
    git push --set-upstream origin dev
    git push
fi
