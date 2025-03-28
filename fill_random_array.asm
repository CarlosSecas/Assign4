;****************************************************************************************************************************
;Program name: "Random Products".  This program generates 64-bit IEEE random numbers and normalize's it and prints it to the user.
; Copyright (C) 2025  Carlos Secas .          *
;                                                                                                                           *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.  This program is distributed in the hope that it will be useful,   *
;but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See   *
;the GNU General Public License for more details A copy of the GNU General Public License v3 is available here:             *
;<https://www.gnu.org/licenses/>.                                                                                           *
;****************************************************************************************************************************




;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;Author information
;  Author name: Carlos Secas
;  Author email: carlosJsecas@csu.fullerton.edu
;  CWID: 886088269
;  Class: 240-09 Section 09
;
;Program information
;  Program name: Random Products
;  Programming languages: Two module in C, five in x86, and one in bash
;  Date program began: 2025-Mar-21
;  Date of last update: 2025-Mar-27
;  Files in this program: main.c, sort.c, executive.asm, fill_random_array.asm, isnan.asm, normalize_array.asm, show_array.asm, r.sh
;  Testing: Alpha testing completed.  All functions are correct.
;  Status: Ready for release to customers
;
;Purpose
;  This program generates 64-bit IEEE random numbers and normalize's it and prints it to the user.
;
;Devlopment
;  This assembly code was developed using NASM in a Linux-based enviorment within Github Codespaces,
;  accessed remotely from a Windows 10 system.  
;
;This file:
;  File name: fill_random_array.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l fill_random_array.lis -o fill_random_array.o fill_random_array.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double fill_random_array();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

global fill_random_array

extern printf

extern isnan


segment .data ;intialized data here
;empty

segment .bss ;Declare pointers to un-intialized space here
;empty

segment .text

fill_random_array:

;backup GPRs
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf


;Store the address of the array and size in GPRS
mov r15, rdi ;store array
mov r14, rsi ;number of values

;Intialize a counter to 0 
mov r13, 0

generate_loop:

;Generate a random number and store it in r12
mov rax, 0
rdrand r12

;Push the random number onto the stack
push r12
push r12
movsd xmm15, [rsp] ;Move the 64-bit number into xmm register
pop r12
pop r12

;Check if the generated number is nan
movsd xmm0, xmm15
call isnan
cmp rax, 0
jne generate_loop ;If it's nan then generate another number

;Store the valid number in the array
movsd [r15 + r13 * 8], xmm15 ;Store it as floating point #

;Increment counter
inc r13
cmp r13, r14


jl generate_loop


;Restore the GPRs
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp   ;Restore rbp to the base of the activation record of the caller program
ret
;End of the function fill_random_array ====================================================================