# RISC-V cross compiler
CC = riscv64-linux-gnu-gcc

# Compiler flags: static linking, optimization, and all warnings enabled.
CFLAGS = -static -O2 -Wall

# List of target executables
TARGETS = test_addi test_nand test_sub test_load test_div

# Directory to store the compiled binaries
BIN_DIR = bin

# Ensure bin directory exists before placing compiled files
$(shell mkdir -p $(BIN_DIR))

# Default target: build all executables
all: $(TARGETS)

# Build test_div from test_div.c
test_div: test_div.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_div test_div.c

# Build test_load from test_load.c
test_load: test_load.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_load test_load.c 

# Build test_sub from test_sub.c
test_sub: test_sub.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_sub test_sub.c

# Build test_nand from test_nand.c
test_nand: test_nand.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_nand test_nand.c

# Build test_addi from test_addi.c
test_addi: test_addi.c
	$(CC) $(CFLAGS) -o $(BIN_DIR)/test_addi test_addi.c

# Clean up build artifacts
clean:
	rm -f $(BIN_DIR)/*

.PHONY: all clean
