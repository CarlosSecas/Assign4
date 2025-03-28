//****************************************************************************************************************************
//Program name: "Random Products". This program generates 64-bit IEEE random numbers and normalize's it and prints it to the user.                 *
//Copyright (C) 2025  Carlos Secas.                                                                                           *
//                                                                                                                            *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
//but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.        *
//See the GNU General Public License for more details. A copy of the GNU General Public License v3 is available here:        *
//<https://www.gnu.org/licenses/>.                                                                                            *
//****************************************************************************************************************************
//****************************************************************************************************************************

//Author: Carlos Secas
//Author email: carlosJsecas@csu.fullerton.edu
//CWID: 886088269
//Class: CPSC 240-09 Section 09
//Program name: Huron’s Triangles
//Programming languages: Two modules in C, five in X86 Assembly, and one in Bash.
//Date program began: 2025-Mar-21
//Date of last update: 2025-Mar-27
//Files in this program: main.c, sort.c, executive.asm, fill_random_array.asm, isnan.asm, normalize_array.asm, show_array.asm, r.sh
//Testing: Alpha testing completed. All functions work correctly.
//Status: Ready for release to the customers

//Purpose of this program:
// This program generates 64-bit IEEE random numbers and normalize's it and prints it to the user.

// Devolpment:
//  This C code was developed using Github Codespaces, accessed remotely from a Windows 10 system.

//This file:
//  File name: main.c
//  Language: C language, 202x standardization where x will be a decimal digit.
//  Max page width: 124 columns
//  Compile: gcc -m64 -Wall -no-pie -std=c2x -c main.c
//  Link: gcc -m64 -no-pie -o random.out executive.o fill_random_array.o normalize.o show_array.o isnan.o main.o sort.o -std=c2x -Wall -z noexecstack -lm




#include <stdio.h>
#include <string.h>

extern char* executive();

int main(void) {

    printf("\nWelcome to Random Products, LLC\n");
    printf("This software is maintained by Carlos Secas\n");

    char* name = executive();

    printf("\nOh. %s. We hope you enjoyed your arrays. Do come again.\n", name);
    printf("A zero will be returned to the operating system.\n");

    return 0;
}