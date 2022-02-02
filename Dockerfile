FROM golang:1.17-buster

# Build the Docker image first
#  > sudo docker build -t ne0nd0g/merlin-base .

# Update APT
RUN apt update
RUN apt upgrade -y
RUN apt install -y apt-transport-https vim gcc-mingw-w64 unzip xz-utils

# Download & Install Python 3.8
WORKDIR /opt
RUN wget --quiet https://www.python.org/ftp/python/3.8.12/Python-3.8.12.tar.xz
RUN tar -xf Python-3.8.12.tar.xz
WORKDIR /opt/Python-3.8.12/
RUN apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev
RUN ./configure --enable-optimizations --enable-shared
# This takes a very long time
RUN make
RUN make install
RUN ldconfig /opt/Python3.8.12
RUN python3.8 -m pip install --upgrade pip

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

# Add Go packages to the module cache
RUN go install github.com/Ne0nd0g/merlin@v1.2.1
RUN go install github.com/Ne0nd0g/merlin-agent@v1.2.1
# For Mythic payload container
RUN go get golang.org/x/tools@v0.1.5

# Clone Merlin Server
WORKDIR /opt
RUN git clone --recurse-submodules https://github.com/Ne0nd0g/merlin
WORKDIR /opt/merlin
RUN go mod download

# Clone Merlin Agent
WORKDIR /opt/
RUN git clone https://github.com/Ne0nd0g/merlin-agent
WORKDIR /opt/merlin-agent
RUN go mod download
RUN make all

# Clone Merlin Agent DLL
WORKDIR /opt/
RUN git clone https://github.com/Ne0nd0g/merlin-agent-dll
WORKDIR /opt/merlin-agent-dll
RUN go mod download
RUN make

# Build SharpGen
WORKDIR /opt/merlin/data/src/cobbr/SharpGen
RUN dotnet build -c release

# Download Mimikatz
WORKDIR /opt/merlin/data/src/
RUN wget --quiet https://github.com/gentilkiwi/mimikatz/releases/latest/download/mimikatz_trunk.zip
RUN unzip mimikatz_trunk.zip -d mimikatz
RUN rm /opt/merlin/data/src/mimikatz_trunk.zip

# Download sRDI
WORKDIR /opt/merlin/data/src
RUN git clone https://github.com/monoxgas/sRDI

# Move out to the root directory
WORKDIR /

# Download go-donut
RUN go install github.com/Binject/go-donut@latest

# Download Garble
RUN go install mvdan.cc/garble@latest

# Install Mythic Packages
# https://docs.mythic-c2.net/customizing/payload-type-development/container-syncing#current-translation-container-versions
RUN pip install aio_pika requests mythic-payloadtype-container==0.1.7 dynaconf==3.1.4
