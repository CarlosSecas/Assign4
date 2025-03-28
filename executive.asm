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
;  File name: executive.asm
;  Language: X86-64
;  Max page width: 124 columns
;  Assemble (standard): nasm -f elf64 -l executive.lis -o executive.o executive.asm
;  Assemble (debug): nasm -f elf64 -gdwarf -l executive.lis -o executive.o executive.asm
;  Optimal print specification: Landscape, 7 points, monospace, 8½x11 paper
;  Prototype of this function: extern double executive();
; 
;
;
;
;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;declarations

global executive

extern fill_random_array

extern isnan

extern sort

extern show_array

extern normalize_array

extern printf

extern scanf

extern fgets

extern stdin

extern strlen

extern atoi


segment .data ;intialized data here

user_name_msg db 10, "Please enter your name: ", 10,0
user_title_msg db 10, "PLease enter your title (Mr, Ms, Sargent, Chief, Project Leader, etc): ", 10,0
greeting_msg db 10, "Nice to meet you %s %s", 10, 10, 0

intro_msg db 10, "This program will generate 64-bit IEEE float numbers.", 10,0
numbers_wanted_msg db 10, "How many numbers do you want. Today's limit is 100 per customer: ",0
numbers_stored_msg db 10, "Your numbers have been stored in an array. Here is that array.", 10, 10,0
invalid_input_msg db 10, "Invalid input. PLease enter a number between 1 and 100.", 10,0
normalize_array_msg db 10, "The array will now be normalized to the range 1.0 to 2.0 Here is the normalized array.", 10, 10,0
sorted_array_msg db 10, "The array will now be sorted.", 10, 10,0
goodbye_msg db 10, "Good bye %s. You are welcome any time.", 10,0

intformat db "%d", 0

segment .bss ;Declare pointers to un-intialized space here

name resb 100
title resb 100
nums_array resq 100
number_input resb 10

segment .text

executive:

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


;Print prompt for user name
mov rax, 0
mov rdi, user_name_msg
call printf

;Read user name using fgets
mov rax, 0
mov rdi, name
mov rsi, 100
mov rdx, [stdin]
call fgets

;Remove newline
mov rax, 0
mov rdi, name
call strlen
mov [name+rax-1], byte 0

;Print prompt for user title
mov rax, 0
mov rdi, user_title_msg
call printf

;Read user title
mov rax, 0
mov rdi, title
mov rsi, 100
mov rdx, [stdin]
call fgets

;Remove newline character
mov rax, 0
mov rdi, title
call strlen
mov [title+rax-1], byte 0

;Print greeting message
mov rax, 0
mov rdi, greeting_msg
mov rsi, title
mov rdx, name
call printf 

;Loop starts to get the size of the array from user
input_loop:

;Print intro of program
mov rax, 0
mov rdi, intro_msg
call printf

;Print prompt to get user size for the array
mov rax, 0
mov rdi, numbers_wanted_msg
call printf

;Read the number input from the user using fgets
mov rax, 0
mov rdi, number_input ;Use a separate buffer to store the number input
mov rsi, 10      
mov rdx, [stdin]
call fgets

;Remove the newline character
mov rax, 0
mov rdi, number_input
call strlen
mov [number_input+rax-1], byte 0

;Convert the number of elements to an integer using atoi
mov rdi, number_input 
call atoi
mov rbx, rax ; Store the result in rbx


;Validate input range (1 - 100)
cmp rbx, 1
jl invalid_input ;If the input is less than 1 then tell user to try again
cmp rbx, 100
jg invalid_input ;If the input is greater than 100 then tell user to try again

;If the input is valid then continue
jmp valid_input


;Handle invalid input
invalid_input:
mov rax, 0
mov rdi, invalid_input_msg
call printf
jmp input_loop ; go back and prompt user again


valid_input:

;Call fill_random_array to generate random numbers 
mov rax, 0
mov rdi, nums_array
mov rsi, rbx
call fill_random_array

;Print a statement to the user that the array of numbers will be stored and printed
mov rax, 0
mov rdi, numbers_stored_msg
call printf

;Print the array using show_array to display the random numbers.
mov rax, 0
mov rdi, nums_array
mov rsi, rbx
call show_array

;Now normalize the array
mov rax, 0
mov rdi, nums_array
mov rsi, rbx
call normalize_array

;Print to the user the array will be normalized
mov rax, 0
mov rdi, normalize_array_msg
call printf

;Print the normalized array
mov rax, 0
mov rdi, nums_array
mov rsi, rbx
call show_array

;Call sort to sort the normalized array
mov rax, 0
mov rdi, nums_array
mov rsi, rbx
call sort

;Print to the user that the array will be sorted
mov rax, 0
mov rdi, sorted_array_msg
call printf

;Print the sorted normalized array
mov rax, 0
mov rdi, nums_array
mov rsi, rbx
call show_array

;Print goodbye message to user
mov rax, 0
mov rdi, goodbye_msg
mov rsi, title
call printf

;Return pointer to name buffer
mov rax, name

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
;End of the function executive ====================================================================