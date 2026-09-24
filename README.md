# BSDSF24M042-OS-A01

A modular C utility project developed for the Operating Systems assignment. The project demonstrates multi-file compilation, static and dynamic libraries, Makefile automation, Git version control, Linux man pages, and system installation.

## Features

- Custom string utility functions
- File line, word, and character counting
- Pattern searching in files
- Multi-file C compilation
- Static library creation
- Dynamic library creation
- Makefile build automation
- Binary analysis using `ar`, `nm`, `readelf`, and `ldd`
- Linux manual pages
- System-wide installation
- Git branching, tagging, and GitHub Releases

## Project Structure

```text
BSDSF24M042-OS-A01/
├── src/        C source files
├── include/    Header files
├── lib/        Static and dynamic libraries
├── bin/        Executable programs
├── obj/        Intermediate object files
├── man/man3/   Library manual pages
├── test.txt    Test input data
├── Makefile    Build and installation automation
├── README.md   Project overview
└── REPORT.md   Assignment report and analysis
```

## Utility Functions

### String functions

```text
mystrlen
mystrcpy
mystrncpy
mystrcat
```

### File functions

```text
wordCount
mygrep
```

## Requirements

The project requires:

- Ubuntu or another Linux distribution
- GCC
- GNU Make
- Git
- Standard Linux utilities

Check the installed tools:

```bash
gcc --version
make --version
git --version
```

## Build the Project

Build the static and dynamic libraries and both executables:

```bash
make
```

To force a complete rebuild:

```bash
make clean
make -B
```

## Run the Programs

Run the statically linked executable:

```bash
make run-static
```

Run the dynamically linked executable:

```bash
make run-dynamic
```

The dynamic executable uses the library path:

```text
lib/libmyutils.so
```

## Generated Files

The build produces:

```text
lib/libmyutils.a       Static library
lib/libmyutils.so      Dynamic library
bin/client_static      Statically linked executable
bin/client_dynamic     Dynamically linked executable
```

## Analyze the Libraries

List the object files inside the static library:

```bash
ar -t lib/libmyutils.a
```

Display static-library symbols:

```bash
nm -g --defined-only lib/libmyutils.a
```

Display dynamic-library symbols:

```bash
nm -D --defined-only lib/libmyutils.so
```

Display dynamic dependencies:

```bash
ldd bin/client_dynamic
```

Display the libraries required by the dynamic executable:

```bash
readelf -d bin/client_dynamic | grep NEEDED
```

## Install the Program and Man Pages

Install the executable, test data, and manual pages:

```bash
sudo make install
```

This installs:

```text
/usr/local/bin/client
/usr/local/share/libmyutils/test.txt
/usr/local/share/man/man3/
```

After installation, the program can be run from any directory:

```bash
client
```

View a manual page:

```bash
man 3 mystrlen
```

List the installed location of a manual page:

```bash
man -w mystrlen
```

## Clean Generated Files

Remove compiled objects, libraries, and executables:

```bash
make clean
```

## Git Branches

The project was developed using separate branches:

```text
main             Stable project branch
multifile-build  Feature 2: multi-file compilation
static-build     Feature 3: static library
dynamic-build    Feature 4: dynamic library
man-pages        Feature 5: documentation and installation
```

## Releases

The project versions are marked using annotated Git tags:

```text
v0.1.1-multifile  Multi-file build
v0.2.1-static     Static library build
v0.3.1-dynamic    Dynamic library build
v0.4.1-final      Final build with man pages and installation
```

GitHub Releases contain the corresponding release notes and compiled assets where required.

## Author

Muhammad Mohid
