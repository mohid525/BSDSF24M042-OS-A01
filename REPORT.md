# Operating Systems Assignment Report

## Project

BSDSF24M042-OS-A01

## Feature 2: Multi-file Project Using Make

This feature implements a multi-file C project containing custom string functions, file-processing functions, and a driver program.

## Source Files

- `src/mystrfunctions.c` implements string functions.
- `src/myfilefunctions.c` implements file-counting and search functions.
- `src/main.c` tests all implemented functions.
- `include/` contains function declarations.
- `Makefile` automates compilation and execution.

## Makefile Linkage

A rule such as:

```make
$(TARGET): $(OBJECTS)

## Feature 3: Static Library Build

The static-library Makefile differs from the direct-compilation Makefile because it first compiles source files into object files.

The reusable object files are:

```text
obj/mystrfunctions.o
obj/myfilefunctions.o
