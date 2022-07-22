# Changelog

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

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
