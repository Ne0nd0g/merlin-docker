FROM golang:1.21-bullseye

# Build the Docker image first
#  > sudo docker build -t ne0nd0g/merlin-base .
# Build multi-arch Docker image and push tagged version to Docker Hub
# > sudo docker buildx build --push --platform linux/amd64,linux/arm64 --tag ne0nd0g/merlin-base:v1.7.0 .

# Update APT
RUN apt update
RUN apt install -y gcc-mingw-w64-x86-64-win32 unzip

# Download Mimikatz
WORKDIR /opt/
RUN wget --quiet https://github.com/gentilkiwi/mimikatz/releases/latest/download/mimikatz_trunk.zip
RUN unzip -j mimikatz_trunk.zip x64/mimikatz.exe -d /opt
RUN rm /opt/mimikatz_trunk.zip

# Download Garble
RUN go install mvdan.cc/garble@v0.12.1