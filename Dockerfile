FROM golang:1.27-bookworm

# Build the Docker image first
#  > sudo docker build -t ne0nd0g/merlin-base .
# Build multi-arch Docker image and push tagged version to Docker Hub
# > sudo docker buildx build --push --platform linux/amd64,linux/arm64 --tag ne0nd0g/merlin-base:v1.9.0 .

# Install the MinGW cross-compilers (for Windows payloads) and unzip (for the mimikatz archive).
# Versions are intentionally unpinned: this is a rolling base image rebuilt against current apt.
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc-mingw-w64-x86-64-win32 \
        gcc-mingw-w64-i686 \
        unzip && \
    rm -rf /var/lib/apt/lists/*

# Download Mimikatz (x64) from the latest upstream release
WORKDIR /opt/
RUN wget --quiet https://github.com/gentilkiwi/mimikatz/releases/latest/download/mimikatz_trunk.zip && \
    unzip -j mimikatz_trunk.zip x64/mimikatz.exe -d /opt && \
    rm /opt/mimikatz_trunk.zip

# Download Garble
RUN go install mvdan.cc/garble@v0.18.0
