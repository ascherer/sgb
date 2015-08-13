# The Stanford GraphBase

“The [Stanford GraphBase](https://www-cs-faculty.stanford.edu/~knuth/sgb.html)
(SGB) is a collection of datasets and computer programs that generate and
examine a wide variety of graphs and networks.” It was developed and published
by [Donald E. Knuth](https://www-cs-faculty.stanford.edu/~knuth) in 1993. The
fully documented source code is available for download from [Stanford
University](https://ftp.cs.stanford.edu/pub/sgb/sgb.tar.gz) and in the book
“The Stanford GraphBase, A Platform for Combinatorial Computing,” published
jointly by ACM Press and Addison-Wesley Publishing Company in 1993. (This book
contains several chapters with additional information not available in the
electronic distribution.)

## Prerequisites

The source code of SGB is written in accordance with the rules of the
[Literate Programming](https://www-cs-faculty.stanford.edu/~knuth/lp.html)
paradigm, so you need to make sure that your computer supports the
[CWEB](https://www-cs-faculty.stanford.edu/~knuth/cweb.html) system. The CWEB
sources are available for download from [Stanford
University](https://ftp.cs.stanford.edu/pub/cweb/cweb.tar.gz). Bootstrapping
CWEB on Unix systems is elementary and documented in the CWEB distribution;
pre-compiled binary executables of the CWEB tools for Win32 systems are
available from
[www.literateprogramming.com](http://www.literateprogramming.com).

## Getting Started

Details of this software can be found in the [README](README) file.

## Why have another project here?

The present project on Github holds all releases by DEK from 1992 to 2025
in the **master** branch. Much more interesting is the **local** branch;
it provides further improvements to the SGB sources plus a “specfile”
`sgb.spec` for building installable packages for rpm and deb based Linux
distributions with the help of the rpmbuild and debbuild utilities
respectively.

### Major features added

* Fix compiler warnings (`gcc -Wall -Wextra -O3`) with _modified_ changefiles
  in the `PROTOTYPES` directory
* Advanced build script `sgb.spec` for rpm and deb packaging
* Extract shared object `libgb.so` for general use
* Improved compliance with current compiler standards

### Postscript

The [extensively patched version of SGB](https://github.com/ascherer/sgb/tree/master/PROTOTYPES) is used in the [Boost Graph Library](https://github.com/boostorg/graph) as a [VertexListGraph adaptor](https://github.com/boostorg/graph/blob/develop/include/boost/graph/stanford_graph.hpp).
