;
;Aditya Gade 	SEA18	18/12/19

global _start

_start:

section .text

;SYSTEM CALL FOR DISPLAYING MESSAGE
	mov rax,1
	mov rdi,1
	mov rsi,message
	mov rdx,length
	syscall
;SYSTEM CALL FOR EXITING
	mov rax,60
	mov rdi,0
	syscall

section .data
	message db "HELLO WORLD"
	length equ	$- message




;OUTPUT:

;mplab@mplab-HP-dx2280-MT-RA529AV:~$ cd SEA18
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ ls
;b1.nasm  b1.nasm~
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ nasm -f elf64 -o exe.o b1.nasm
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ ld -o exe exe.o
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ ./exe
;HELLO WORLDmplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ 

