# relocatable `Python.framework`

## Motivation

Although you can download an official Python 3 framework build from https://www.python.org, it's not suitable to be bundled with an app as it is not relocatable: libraries point to system locations below `/Library/Frameworks`. So I'm creating my own relocatable version of `Python.framework` to be used (and bundled) in other projects.

## Build

### Prerequisites

I am using Xcode 10.3 with the 10.9 SDK to build this. Other combinations and build targets may work (I've built on El Capitan for a while myself) as well, YMMV.
You can get older SDKs from older versions of Xcode (check the downloads section in your Apple Developer account) or use little helpers like [XcodeLegacy](https://github.com/devernay/xcodelegacy).

### Instructions

- Adjust the build directory in `020-vars.sh` to your liking:

  ```bash
  WRK_DIR=/Users/Shared/work
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
