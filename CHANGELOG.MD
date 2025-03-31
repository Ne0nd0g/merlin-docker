# Changelog

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## v1.9.0 - 2025-03-31

### Added

- Mingw package `gcc-mingw-w64-i686` to compile for 32-bit

## v1.8.0 - 2024-10-14

### Changed

- Upgraded from golang:1.21-bullseye to golang:1.22-bullseye
- Upgraded Garble to v0.13.0

## v1.7.1 - 2024-09-01

### Changed

- Fixed command to extract Mimikatz directly to /opt

## v1.7.0 - 2024-08-30

### Changed

- Created multi-arch builds with: `sudo docker buildx build --push --platform linux/amd64,linux/arm64 --tag ne0nd0g/merlin-base:v1.7.0 .`
- Removed the following packages to decrease size and truly be a base image:
    - Merlin Server
    - Merlin CLI
    - Merlin Agent
    - Merlin Agent DLL
    - SharpGen
    - apt-transport-https, vim, xz-utils
    - Microsoft .NET Core 2.1 SDK
- Replaced gcc-mingw-w64 with gcc-mingw-w64-x86-64-win32

## v1.6.1 - 2024-04-23

### Changed

- Upgraded merlin to v2.1.3
- Upgraded merlin-agent to v2.4.1
- Upgraded merlin-agent-dll to v2.3.1
- Upgraded merlin-cli to v1.1.4

## v1.6.0 - 2024-03-27

### Changed

- Upgraded merlin to v2.1.2
- Upgraded merlin-agent to v2.4.0
- Upgraded merlin-agent-dll to v2.3.0
- Upgraded Garble to v0.12.1

## v1.5.0 - 2023-12-26

### Changed

- Upgraded merlin to v2.1.0
- Upgraded merlin-agent to v2.3.0
- Upgraded merlin-agent-dll to v2.2.0
- Upgraded Garble to v0.11.0

## v1.4.0 - 2023-06-11

## Changed

- Upgraded merlin to v1.5.1
- Upgraded merlin-agent to v1.6.5
- Upgraded merlin-agent-dll to v1.6.2
- Upgraded Garble to v0.9.3

## Removed

- Python 3 install
- Merlin on Mythic packages and repositories
- sRDI
- go-donut

## v1.3.0 - 2022-11-11

### Changed

- Upgraded base image to Go v1.19
- Upgraded merlin-agent & merlin-agent-dll to v1.6.0

## v1.2.0 - 2022-10-31

## Changed

- Fixed sRDI to a known good commit hash `5690685aee6751d0dbcf2c50b6fdd4427c1c9a0a`
- Upgraded Garble to v0.7.2
- Upgrade Python to 3.8.15

## v1.1.2 - 2022-07-22

## Changed

- Clone specific tagged versions of merlin and merlin-agent

## v1.1.1 - 2022-07-09

### Changed

- Upgraded base image to Go 1.18
- Upgraded Python to 3.18.13
- Upgraded Garble to 0.7.0

### Added

- Clone down Merlin on Mythic repository and download the associated modules

### Removed

- Removed `go install` commands for Merlin that were not useful

## v1.0.0 - 2022-07-09

- Initial release _with_ a standardized versioning system and associated tag

### Changed

- Explicitly set Garble to use version 0.6.0 because later version do not support Go v1.17
