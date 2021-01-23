# relocatable `Python.framework`

## Motivation

Although you can download an official Python 3 framework build from https://www.python.org, it's not suitable to be bundled with an app as it is not relocatable: libraries point to system locations below `/Library/Frameworks`. So I'm creating my own relocatable version of `Python.framework` to be used (and bundled) in other projects.

## Building

The preferred way to build is letting GitHub's CI do it for you.

### GitHub CI: `build.yml`

This is supposed to work out of the box and will target 10.15.

If you want to target 10.11 like I'm doing, you need to provide a downloadable archive for the SDK named `MacOSX10.11.sdk.tar.xz` and add a secret to your repository named `SDK1011_DOWNLOAD_URL` that contains the URL to that download.

### GitHub CI: `build_inkscape.yml`

This is mostly a copy of the `build.yml` workflow to produce a customized version of the Python framework to be bundled with Inkscape. You can safely ignore/delete/... this.
### build locally

By default, the build process will use `/Users/Shared/work/py3framework` as work directory (`$WRK_DIR`) and target your current OS. You can adjust those settings by creating a configuration file `010-vars-local.sh`:

```bash
# adjust values to your needs
echo "WRK_DIR=$HOME/py3framework" > 010-vars-local.sh
echo "SDKROOT=$HOME/MacOSX10.13.sdk" >> 010-vars-local.sh
```

Now run:

```bash
./build.sh
```

If all goes well, you'll find `$WRK_DIR/Frameworks/Python.framework` as result.

## Download

See the releases page.

## License

[GPL-3.0-or-later](LICENSE)
