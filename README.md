# SDSC "R" roll

## Overview

This Rocks roll bundles the R statistical computing package.

R is a free software environment for statistical computing and graphics. For
more information about R please visit the <a href="http://www.r-project.org"
target="_blank">official web page</a>.


## Requirements

To build/install this roll you must have root access to a Rocks development
machine (e.g., a frontend or development appliance).

If your Rocks development machine does *not* have Internet access you must
download the appropriate R source file(s) using a machine that does have
Internet access and copy them into the `src/R` directory on your Rocks
development machine.


## Dependencies

yum install tk-devel

tk-devel is not needed by R itself; however, a number of R modules depend on R
having been compiled with it present.

The sdsc-roll must be installed on the build machine, since the build process
depends on make include files provided by that roll.

The roll sources assume that modulefiles provided by SDSC compiler
rolls are available, but it will build without them as long as the environment
variables they provide are otherwise defined.

If they are present, the build process uses the Intel MKL libraries and assumes
that the mkl modulefile provided by the SDSC mkl-roll or intel-roll is
available.  It will build without the modulefile as long as the environment
variables it provides are otherwise defined.  If MKL is not present, the build
process uses R's internal BLAS implementation.


## Building

To build the R-roll, execute this on a Rocks development machine
(e.g., a frontend or development appliance):

```shell
% make 2>&1 | tee build.log
```

A successful build will create the file `R-*.disk1.iso`.  If you built the
roll on a Rocks frontend, proceed to the installation step. If you built the
roll on a Rocks development appliance, you need to copy the roll to your Rocks
frontend before continuing with installation.

This roll source supports building with different compilers; by default, it
builds using the gnu compilers.  To build for a different configuration, use
the `ROLLCOMPILER` make variable, e.g.,

```shell
% make ROLLCOMPILER=intel
```

This roll source supports building with different compilers.
The `ROLLCOMPILER` make variable can be used to
specify the names of compiler modulefiles to use for building the
software, e.g.,

```shell
% make ROLLCOMPILER=gnu/4.8.1
```

If the environment variable MKL_ROOT is set either before the build or by the
ROLLCOMPILER module, the build process will incorporate the Math Kernel
Libraries into the R installation.


## Installation

To install, execute these instructions on a Rocks frontend:

```shell
% rocks add roll *.iso
% rocks enable roll R
% cd /export/rocks/install
% rocks create distro
% rocks run roll R | bash
```

In addition to the software itself, the roll installs R environment module files
in:

```shell
/opt/modulefiles/applications/R
```

## Testing

The R-roll includes a test script which can be run to verify proper installation
of the roll documentation, binaries and module files. To run the test scripts
execute the following command(s):

```shell
% /root/rolltests/R.t 
```
