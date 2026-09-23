CC = gcc
CFLAGS = -Wall -Wextra -std=c17
CPPFLAGS = -Iinclude

SRC_DIR = src
OBJ_DIR = obj
LIB_DIR = lib
BIN_DIR = bin

LIB = $(LIB_DIR)/libmyutils.a
TARGET = $(BIN_DIR)/client_static

LIB_OBJECTS = $(OBJ_DIR)/mystrfunctions.o \
              $(OBJ_DIR)/myfilefunctions.o

MAIN_OBJECT = $(OBJ_DIR)/main.o
HEADERS = $(wildcard include/*.h)

.PHONY: all build run clean

all: build

build: $(TARGET)

$(TARGET): $(MAIN_OBJECT) $(LIB)
	$(CC) $(CFLAGS) $(MAIN_OBJECT) -L$(LIB_DIR) -lmyutils -o $@

$(LIB): $(LIB_OBJECTS)
	ar rcs $@ $^
	ranlib $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

run: build
	./$(TARGET)

clean:
	rm -f $(OBJ_DIR)/*.o
	rm -f $(LIB)
	rm -f $(TARGET)
