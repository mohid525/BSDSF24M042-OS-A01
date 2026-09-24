CC = gcc
CFLAGS = -Wall -Wextra -std=c17
CPPFLAGS = -Iinclude
PICFLAGS = $(CFLAGS) -fPIC

SRC_DIR = src
OBJ_DIR = obj
LIB_DIR = lib
BIN_DIR = bin

PREFIX ?= /usr/local
INSTALL_BIN_DIR = $(PREFIX)/bin
INSTALL_MAN_DIR = $(PREFIX)/share/man/man3
DATA_DIR = $(PREFIX)/share/libmyutils
MAN_PAGES = $(wildcard man/man3/*.3)

STATIC_LIB = $(LIB_DIR)/libmyutils.a
SHARED_LIB = $(LIB_DIR)/libmyutils.so

STATIC_TARGET = $(BIN_DIR)/client_static
DYNAMIC_TARGET = $(BIN_DIR)/client_dynamic

MAIN_OBJECT = $(OBJ_DIR)/main.o

LIB_OBJECTS = \
	$(OBJ_DIR)/mystrfunctions.o \
	$(OBJ_DIR)/myfilefunctions.o

PIC_OBJECTS = \
	$(OBJ_DIR)/mystrfunctions.pic.o \
	$(OBJ_DIR)/myfilefunctions.pic.o

HEADERS = $(wildcard include/*.h)

.PHONY: all build run-static run-dynamic install clean

all: build

build: $(STATIC_TARGET) $(DYNAMIC_TARGET)

$(STATIC_TARGET): $(MAIN_OBJECT) $(STATIC_LIB)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) $(STATIC_LIB) -o $@

$(DYNAMIC_TARGET): $(MAIN_OBJECT) $(SHARED_LIB)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $@

$(STATIC_LIB): $(LIB_OBJECTS)
	ar rcs $@ $^
	ranlib $@

$(SHARED_LIB): $(PIC_OBJECTS)
	$(CC) -shared -o $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(OBJ_DIR)/%.pic.o: $(SRC_DIR)/%.c $(HEADERS)
	$(CC) $(PICFLAGS) $(CPPFLAGS) -c $< -o $@

run-static: $(STATIC_TARGET)
	./$(STATIC_TARGET)

run-dynamic: $(DYNAMIC_TARGET)
	LD_LIBRARY_PATH=./$(LIB_DIR) ./$(DYNAMIC_TARGET)

install: $(STATIC_TARGET) $(MAN_PAGES)
	mkdir -p $(INSTALL_BIN_DIR)
	mkdir -p $(INSTALL_MAN_DIR)
	mkdir -p $(DATA_DIR)
	install -m 755 $(STATIC_TARGET) $(INSTALL_BIN_DIR)/client
	install -m 644 $(MAN_PAGES) $(INSTALL_MAN_DIR)
	install -m 644 test.txt $(DATA_DIR)/test.txt

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(OBJ_DIR)/*.pic.o
	rm -f $(STATIC_LIB)
	rm -f $(SHARED_LIB)
	rm -f $(STATIC_TARGET)
	rm -f $(DYNAMIC_TARGET)
