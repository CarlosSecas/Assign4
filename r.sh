#!/bin/bash

# Program Name: Random Products
# Author: Carlos Secas
# Author Email: carlosJsecas@gmail.com
# CWID: 886088269
# Class: 240-09 Section 09
# This file is the script file that accompanies the "Random Products" program.
# Prepare for execution in normal mode (not gdb mode).

# Delete unnecessary files
rm -f *.o
rm -f *.out

echo "Assembling executive.asm..."
nasm -f elf64 -l executive.lis -o executive.o executive.asm

echo "Assembling fill_random_array.asm..."
nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm

echo "Assembling normalize_array.asm..."
nasm -f elf64 -l normalize_array.lis -o normalize_array.o normalize_array.asm

echo "Assemble the source file show_array.asm"
nasm -f elf64 -l show_array.lis -o show_array.o show_array.asm

echo "Assemble the source file isnan.asm"
nasm -f elf64 -l isnan.lis -o isnan.o isnan.asm

echo "Compiling the C source file main.c..."
gcc -m64 -Wall -no-pie -std=c2x -c -o main.o main.c

echo "Compiling the C source file sort.c..."
gcc -m64 -Wall -no-pie -std=c2x -c -o sort.o sort.c

echo "Link the object modules to create an executable file"
gcc -m64 -no-pie -o random.out executive.o fill_random_array.o normalize_array.o show_array.o isnan.o main.o sort.o -std=c2x -Wall -z noexecstack -lm

echo "Setting execute permissions for random.out..."
chmod +x random.out

echo "Executing the program..."
./random.out

echo "This bash script will now terminate."