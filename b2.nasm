;Basics 2: Setting up a macro
;
;Aditya Gade 	SEA18	18/12/19

global _start

_start:

section .text
;MACRO FOR PRINT (ATLEAST ONE PARAMETER)
	%macro print 2
		mov rax,1
		mov rdi,1
		mov rsi,%1
		mov rdx,%2	
		syscall
	%endmacro 
;EXECUTING PRINT'S MACRO
	print message1,length1
	print message2,length2
	print message3,length3
;SYSTEM CALL FOR EXITING
	mov rax,60
	mov rdi,0
	syscall

section .data
	message1 db "HELLO WORLD "
	length1 equ	$- message1

	message2 db "AVENGERS "
	length2 equ	$- message2

	message3 db "ASSEMBLE "
	length3 equ	$- message3

;OUTPUT:
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ nasm -f elf64 -o exe.o b2.nasm
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ ld -o exe exe.o
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ ./exe
;HELLO WORLD AVENGERS ASSEMBLEmplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$     

