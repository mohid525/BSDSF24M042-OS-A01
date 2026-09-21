CC = gcc
CFLAGS = -Wall -Wextra -std=c17
CPPFLAGS = -Iinclude

TARGET = bin/client
SOURCES = $(wildcard src/*.c)
HEADERS = $(wildcard include/*.h)

.PHONY: all build run clean

all: build

build: $(TARGET)

$(TARGET): $(SOURCES) $(HEADERS)
	$(CC) $(CFLAGS) $(CPPFLAGS) $(SOURCES) -o $(TARGET)

run: build
	./$(TARGET)

clean:
	rm -f $(TARGET)
