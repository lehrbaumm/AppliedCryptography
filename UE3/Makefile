CC=gcc
ASM=nasm

all: solution.asm
	$(ASM) -f elf64 solution.asm
	$(CC) -o solution.bin solution.o


run: solution.asm
	$(ASM) -f elf64 solution.asm
	$(CC) -o solution.bin solution.o
	./solution.bin

test: solution.asm
	$(ASM) -f elf64 -g solution.asm
	$(CC) -g -o solution.bin solution.o

edit: solution.asm
	vim solution.asm
