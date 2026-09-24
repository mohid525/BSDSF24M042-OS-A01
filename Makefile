CC = gcc
CFLAGS = -Wall -Wextra -std=c17
CPPFLAGS = -Iinclude
PICFLAGS = $(CFLAGS) -fPIC

SRC_DIR = src
OBJ_DIR = obj
LIB_DIR = lib
BIN_DIR = bin

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

.PHONY: all build run-static run-dynamic clean

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

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(OBJ_DIR)/*.pic.o
	rm -f $(STATIC_LIB)
	rm -f $(SHARED_LIB)
	rm -f $(STATIC_TARGET)
	rm -f $(DYNAMIC_TARGET)
