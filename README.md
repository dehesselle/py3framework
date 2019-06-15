# relocatable `Python.framework`

## Motivation

Although you can download an official Python 3 framework build from https://www.python.org, it's not suitable to be bundled with an app as it is not relocatable: libraries point to system locations below `/Library/Frameworks`. So I'm creating my own relocatable version of `Python.framework` to be used (and bundled) in other projects.

## Build

### Prerequisites

These scripts have been written and designed for macOS 10.13.6 and expect to find Xcode 10.1 as well as the 10.9 SDK (installed via [XcodeLegacy](https://github.com/devernay/xcodelegacy)) on your system. You can remove the dependency on 10.9 SDK by deleting the file `025-vars_sdk109.sh`.

### Instructions

- Adjust the build directory in `020-vars.sh` to your liking:

  ```bash
  WRK_DIR=/work
  ```

- Run the scripts to build and package `Python.framework`. 
  
  ```bash
  ./110-build.sh      # download and compile everything
  ./210-package.sh    # make the Framework relocatable
  ```

## Download

See the releases page.

## License

[GPL](LICENSE)
