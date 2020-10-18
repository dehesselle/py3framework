# relocatable `Python.framework`

## Motivation

Although you can download an official Python 3 framework build from https://www.python.org, it's not suitable to be bundled with an app as it is not relocatable: libraries point to system locations below `/Library/Frameworks`. So I'm creating my own relocatable version of `Python.framework` to be used (and bundled) in other projects.

## Build

### Prerequisites

It's best to use a recent version of Xcode along with the 10.11 SDK to achieve broad backward compatiblity.  
You can get older SDKs from older versions of Xcode (check the downloads section in your Apple Developer account) or use little helpers like [XcodeLegacy](https://github.com/devernay/xcodelegacy).

### Instructions

- Review the following settings in `020-vars.sh` and adjust to your liking.

  ```bash
  # line 8: build directory
  WRK_DIR=/Users/Shared/work/py3framework

  # line 56: target platform
  export MACOSX_DEPLOYMENT_TARGET=10.11   # OS X El Capitan

  # line 57: parent folder containing your MacOSX*.sdk
  [ -z $SDKROOT_DIR ] && SDKROOT_DIR=/opt/sdks
  ```

- Run the scripts to build and package `Python.framework`.

  ```bash
  ./110-build.sh      # download and compile everything
  ./210-package.sh    # make the framework relocatable
  ```

If you left everything at default, you'll find `Python.framework` in

```bash
/Users/Shared/work/py3framework/opt/Frameworks
```

## Download

See the releases page.

## License

[GPL](LICENSE)
