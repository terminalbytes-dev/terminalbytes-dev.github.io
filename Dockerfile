# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Declare TARGETARCH (provided automatically by BuildKit)
ARG TARGETARCH

# Set environment variable for non-interactive apt installs
ENV DEBIAN_FRONTEND=noninteractive
ENV HUGO_VERSION=0.128.0

# Update package lists and install necessary tools
RUN apt-get update && apt-get install -y \
    wget \
    dpkg \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Hugo Extended, selecting the package based on TARGETARCH.
RUN wget -O /tmp/hugo.deb "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-${TARGETARCH}.deb" \
    && dpkg -i /tmp/hugo.deb \
    && rm /tmp/hugo.deb

# Set the working directory to /app
WORKDIR /app

# Optionally, expose Hugo's default server port (1313)
EXPOSE 1313

# Set the default command to run Hugo
CMD ["hugo"]
