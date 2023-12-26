FROM golang:1.21-bullseye

# Build the Docker image first
#  > sudo docker build -t ne0nd0g/merlin-base .

# Update APT
RUN apt update
RUN apt upgrade -y
RUN apt install -y apt-transport-https vim gcc-mingw-w64 unzip xz-utils

# Install Microsoft package signing key
RUN wget --quiet -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
RUN mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
RUN wget --quiet https://packages.microsoft.com/config/debian/10/prod.list
RUN mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
RUN chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
RUN chown root:root /etc/apt/sources.list.d/microsoft-prod.list

# Install Microsoft .NET Core 2.1 SDK
RUN apt update
RUN apt install -y dotnet-sdk-2.1

# Clone Merlin Server
WORKDIR /opt
RUN git clone -b v2.1.0 --recurse-submodules https://github.com/Ne0nd0g/merlin
WORKDIR /opt/merlin
RUN go mod download
RUN make linux DIR=/opt/merlin

# Clone Merlin CLI
WORKDIR /opt
RUN git clone -b v1.1.2 https://github.com/Ne0nd0g/merlin-cli
WORKDIR /opt/merlin-cli
RUN go mod download
RUN make linux DIR=/opt/merlin-cli

# Clone Merlin Agent
WORKDIR /opt/
RUN git clone -b v2.3.0 https://github.com/Ne0nd0g/merlin-agent
WORKDIR /opt/merlin-agent
RUN go mod download
RUN ["make", "all", "DIR=/opt/merlin/data/bin"]

# Clone Merlin Agent DLL
WORKDIR /opt/
RUN git clone -b v2.2.0 https://github.com/Ne0nd0g/merlin-agent-dll
WORKDIR /opt/merlin-agent-dll
RUN go mod download
RUN ["make", "DIR=/opt/merlin/data/bin"]

# Build SharpGen
WORKDIR /opt/merlin/data/src/cobbr/SharpGen
RUN dotnet build -c release

# Download Mimikatz
WORKDIR /opt/merlin/data/src/
RUN wget --quiet https://github.com/gentilkiwi/mimikatz/releases/latest/download/mimikatz_trunk.zip
RUN unzip mimikatz_trunk.zip -d mimikatz
RUN rm /opt/merlin/data/src/mimikatz_trunk.zip

# Download Garble
RUN go install mvdan.cc/garble@v0.11.0
