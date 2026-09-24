# Operating Systems Assignment Report

## Project Information

- Project: `BSDSF24M042-OS-A01`
- Student: Muhammad Mohid
- Platform: Ubuntu Linux x86_64
- Compiler: GCC
- Build tool: GNU Make
- Version control: Git and GitHub

---

# Feature 1: Project Scaffolding and Version Control

## Objective

The purpose of Feature 1 was to create a professional Linux C project structure and place it under Git and GitHub version control.

## Project Structure

```text
BSDSF24M042-OS-A01/
├── src/        C source files
├── include/    Header files
├── lib/        Static and dynamic libraries
├── bin/        Compiled executable programs
├── obj/        Intermediate object files
├── README.md   Project overview
└── REPORT.md   Assignment analysis
```

## GitHub Repository

The project was created as a public GitHub repository named:

```text
BSDSF24M042-OS-A01
```

The repository was cloned into Ubuntu Linux and used as the working directory for all project development.

## Git Workflow

The basic Git workflow used was:

```bash
git add .
git commit -m "Create project structure"
git push origin main
```

Git tracks the project history and allows changes to be saved incrementally. The `main` branch contains the stable project state, while feature branches are used for separate development tasks.

## Result

Feature 1 established the required directory structure and connected the local Ubuntu project to GitHub. The project files can now be developed, committed, pushed, tagged, and released professionally.

---

# Feature 2: Multi-file Project Using Make

## Objective

Feature 2 converted the project into a multi-file C program. The project contains separate source files for string functions, file functions, and the driver program.

## Source and Header Files

- `include/mystrfunctions.h` contains declarations for string functions.
- `include/myfilefunctions.h` contains declarations for file functions.
- `src/mystrfunctions.c` implements custom string functions.
- `src/myfilefunctions.c` implements file-counting and search functions.
- `src/main.c` tests the functions.
- `test.txt` provides input data for file-processing tests.

## Implemented Functions

The string module contains:

```c
mystrlen
mystrcpy
mystrncpy
mystrcat
```

The file module contains:

```c
wordCount
mygrep
```

## Compilation Process

Each source file is first compiled into an object file:

```bash
gcc -Wall -Wextra -std=c17 -Iinclude -c src/mystrfunctions.c -o obj/mystrfunctions.o
gcc -Wall -Wextra -std=c17 -Iinclude -c src/myfilefunctions.c -o obj/myfilefunctions.o
gcc -Wall -Wextra -std=c17 -Iinclude -c src/main.c -o obj/main.o
```

The object files are then linked into an executable:

```bash
gcc obj/main.o obj/mystrfunctions.o obj/myfilefunctions.o -o bin/client
```

The compiler option `-Iinclude` tells GCC where to find the header files.

## Makefile

The Makefile automates compilation and execution. Important concepts include:

- `CC` stores the compiler name.
- `CFLAGS` stores compiler warning and language options.
- `CPPFLAGS` stores the header-file path.
- Object files are compiled from source files.
- The final executable is linked from all required object files.
- The `run` rule executes the program.
- The `clean` rule removes generated files.

The direct-linking rule is conceptually:

```make
$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET)
```

This means that all object files are linked directly into the executable.

## Testing Result

The program successfully tested both modules:

```text
Length: 16
Copied string: Linux
Copied with limit: Assembly
Concatenated string: Hello Linux

Lines: 5
Words: 22
Characters: 147

Matching lines: 3
```

## Feature 2 Git Workflow

Feature 2 was developed on the `multifile-build` branch:

```bash
git switch -c multifile-build
git add .
git commit -m "Implement multifile utility project"
git push -u origin multifile-build
```

The version was tagged and released as:

```text
v0.1.1-multifile
```

The compiled executable `client` was attached to the GitHub release.

## Feature 2 Report Questions

### 1. Explanation of the linking rule

The rule:

```make
$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $(TARGET)
```

states that the executable depends on all object files. If any source file changes, its object file is rebuilt and the executable is linked again.

In Feature 2, object files are linked directly into the executable. In Feature 3, reusable object files are first placed into a static library and the executable is linked against that library.

### 2. Git tags

A Git tag is a permanent name assigned to a particular commit. Tags are useful for marking important versions such as releases.

A lightweight tag only stores a reference to a commit:

```bash
git tag v0.1.1-multifile
```

An annotated tag stores additional information such as the tag message, author, and date:

```bash
git tag -a v0.1.1-multifile -m "Version 0.1.1: Multi-file Build"
```

Annotated tags are more suitable for official releases.

### 3. GitHub Releases and binary assets

A GitHub Release is a published version of a project connected to a Git tag. It provides release notes and downloadable files.

Attaching a compiled binary such as `client` allows users or instructors to download and run the program without compiling the source code themselves.

---

# Feature 3: Static Library Build

## Objective

Feature 3 reorganized the project so that reusable functions were compiled into a static library. The main program was then linked against this library.

## Static Library

The static library created was:

```text
lib/libmyutils.a
```

It contains:

```text
mystrfunctions.o
myfilefunctions.o
```

The library does not contain `main.o` because `main.o` contains the program entry point and belongs to the executable.

## Static Library Makefile

The important Makefile variables are:

```make
LIB = lib/libmyutils.a
TARGET = bin/client_static
LIB_OBJECTS = obj/mystrfunctions.o obj/myfilefunctions.o
MAIN_OBJECT = obj/main.o
```

The library is created with:

```make
$(LIB): $(LIB_OBJECTS)
	ar rcs $@ $^
	ranlib $@
```

The executable is linked against the library with:

```make
$(TARGET): $(MAIN_OBJECT) $(LIB)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) -Llib -lmyutils -o $@
```

The option `-Llib` tells the linker to search the `lib` directory. The option `-lmyutils` tells the linker to use `libmyutils.a`.

## Build and Test

The project was built using:

```bash
make clean
make -B
make run
```

The resulting executable was:

```text
bin/client_static
```

The program produced the expected string and file-processing results.

## Static Library Analysis

The archive contents were checked using:

```bash
ar -t lib/libmyutils.a
```

The output confirmed that the archive contains:

```text
mystrfunctions.o
myfilefunctions.o
```

The library symbols were checked using:

```bash
nm -g --defined-only lib/libmyutils.a
```

The executable symbols were checked using:

```bash
nm bin/client_static | grep -E 'mystrlen|mystrcpy|mystrncpy|mystrcat|wordCount|mygrep'
```

The function symbols were present in the executable. This proves that the required object code was copied from the static library into `client_static`.

The command:

```bash
ldd bin/client_static
```

did not show `libmyutils.so`. This confirms that the custom utility library was statically linked into the executable.

## Feature 3 Git Workflow

Feature 3 was developed on the separate branch:

```text
static-build
```

The changes were committed and pushed using:

```bash
git add .gitignore Makefile REPORT.md
git commit -m "Build and document static library"
git push -u origin static-build
```

The static-library version was tagged:

```text
v0.2.1-static
```

The GitHub release was titled:

```text
Version 0.2.1: Static Library Build
```

The following binary assets were attached:

```text
libmyutils.a
client_static
```

## Feature 3 Report Questions

### 1. Differences between the Part 2 and Part 3 Makefiles

In Part 2, the source files were compiled into object files and then linked directly into one executable.

In Part 3, the Makefile separates the main program object from the reusable library objects. It creates `lib/libmyutils.a` using `ar rcs`, runs `ranlib`, and links `main.o` against the library using `-Llib -lmyutils`.

The Feature 3 library contains:

```text
mystrfunctions.o
myfilefunctions.o
```

It does not contain `main.o` because a library should contain reusable functions, not the program entry point.

### 2. Purpose of ar and ranlib

The `ar` command creates and manages an archive of object files. The command:

```bash
ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o
```

creates the static library.

The letters mean:

- `r`: insert or replace object files
- `c`: create the archive if it does not exist
- `s`: create an index of symbols

The `ranlib` command creates or updates the symbol index of the archive. The index allows the linker to find functions efficiently inside the static library.

### 3. Static linking and nm

The command:

```bash
nm bin/client_static | grep mystrlen
```

shows the `mystrlen` symbol. Other functions such as `mystrcpy`, `mystrncpy`, `mystrcat`, `wordCount`, and `mygrep` are also present.

This means the linker copied the required object code from `libmyutils.a` into `client_static`. The executable therefore contains the library functions and does not need a separate `libmyutils.so` at runtime.

---

# Conclusion

The project demonstrates three stages of professional C development:

1. Feature 1 created the project structure and version-control workflow.
2. Feature 2 implemented and built a multi-file C project using Make.
3. Feature 3 created a reusable static library and linked the application against it.


---

# Feature 4: Dynamic Library Build

## Objective

Feature 4 extends the project to use a dynamic library. Unlike a static library, the shared library code is not copied completely into the executable. The operating system loads the shared library at runtime.

## Dynamic Library

The dynamic library created was:

```text
lib/libmyutils.so
```

It was created using position-independent object code and the GCC shared-library option:

```bash
gcc -shared -o lib/libmyutils.so \
obj/mystrfunctions.pic.o obj/myfilefunctions.pic.o
```

The `-fPIC` option creates Position-Independent Code. This code can execute correctly regardless of where the operating system loads it into memory. This is important for shared libraries because the same library can be loaded at different memory addresses by different processes.

## Dynamic Executable

The dynamically linked executable was:

```text
bin/client_dynamic
```

It was linked using:

```bash
gcc -Wall -Wextra -std=c17 obj/main.o \
-Llib -lmyutils -o bin/client_dynamic
```

The `-Llib` option tells the linker to search the `lib` directory. The `-lmyutils` option links against `libmyutils.so`.

## Runtime Library Loading

Running the dynamic executable directly produced:

```text
error while loading shared libraries: libmyutils.so:
cannot open shared object file
```

This occurred because the dynamic loader did not automatically search the project’s `lib` directory.

The program ran successfully using:

```bash
LD_LIBRARY_PATH=./lib ./bin/client_dynamic
```

The Makefile includes this environment variable in the `run-dynamic` target.

## Dynamic Linking Analysis

The library dependency was checked with:

```bash
ldd bin/client_dynamic
```

Without `LD_LIBRARY_PATH`, the output showed:

```text
libmyutils.so => not found
```

With the library path specified:

```bash
LD_LIBRARY_PATH=./lib ldd bin/client_dynamic
```

the output showed:

```text
libmyutils.so => ./lib/libmyutils.so
```

The required shared library was also confirmed using:

```bash
readelf -d bin/client_dynamic | grep NEEDED
```

The output contained:

```text
Shared library: [libmyutils.so]
Shared library: [libc.so.6]
```

The exported functions were checked using:

```bash
nm -D --defined-only lib/libmyutils.so
```

The output contained:

```text
mystrlen
mystrcpy
mystrncpy
mystrcat
wordCount
mygrep
```

## Feature 4 Report Questions

### 1. Position-Independent Code

Position-Independent Code, created using `-fPIC`, is machine code that can execute correctly regardless of its memory address.

Shared libraries require position-independent code because the operating system may load the same library at different addresses in different processes. This allows shared-library code to be reused safely.

### 2. Difference between static and dynamic executable sizes

The static and dynamic executables in this project were both approximately 17 KB. The difference is small because the project contains only a small amount of code.

In general, a static executable is larger because it contains copies of the required library code. A dynamic executable is usually smaller because the library code remains in a separate `.so` file and is loaded at runtime.

Dynamic linking also allows multiple programs to share one copy of a library in memory and allows the library to be updated separately from the executable.

### 3. LD_LIBRARY_PATH and the dynamic loader

`LD_LIBRARY_PATH` is an environment variable that adds directories to the dynamic loader’s library search path.

This command:

```bash
LD_LIBRARY_PATH=./lib ./bin/client_dynamic
```

tells Linux to search the project’s `lib` directory for `libmyutils.so`.

The need for this variable shows that the operating system’s dynamic loader searches configured system directories by default. It does not automatically search the current project’s `lib` directory.
