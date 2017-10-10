# fks-texmf

TeX macros for physics (contest) typesetting.

* TODO installation (Linux distros, windows)
* TODO maintenance (tests, branching, packaging)


## Packaging

Packages for Linux distributions are built in [Open Build Service](http://build.opensuse.org/).
All data are stored in the main Git repository and build service package
contains just a `_service` file that references the Git repository and
transformations to comply with OBS package format.

To rebuild packages with a fresh pull from the repo call

    osc service remoterun

### Debian

  * Beware that Build-Depends is duplicated both in `*.dsc` and
    `debian.control` file (does not need frequent changes though).

## Tests

  * `tests/source` any `t*.tex` files are compiled with the macros.
  * `tests/exp-res` here you should put PNG files with expected test results
    (matching respective source filename).
    * Simply call `make test-results` to refresh the PNG patterns.

### Metadata

The test files can arbitrary key=value metadata comments
```
	%META_TEST foo=bar
```

Following keys are supported:

  * `META_TEST ignore=1` test is run but results are ignored
  * `META_TEST nopdf=1` test is supposed to produce no PDF output
  * `META_TEST roi=<l>x<t>,<w>x<h>` left and top coordinate, width and height
    size (all relative [0,1]) of region of interest that is compared against
    the pattern

