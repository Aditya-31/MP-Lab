; Write a 64 bit ALP to switch from real to protected mode and display the contents of :
;1.MSW 2.TR 3.LDTR 4.GDTR 5.IDTR
;Name: Aditya Gade 		Class:SE-A Comp 		Roll No:18		Date:4/3/2020
%include "macro.asm"

global _start

_start:

section .text

	;MSW
		smsw eax	
		mov[for32bits],eax
		bt eax,00
		jc l1
		print message1,length1
		jmp exit
		l1:	print message2,length2
			print space,spaceLength
			print message3,length3
		
			mov ax,[for32bits+2]
			call displayprocedure
		
			mov ax,[for32bits]
			call displayprocedure
	;TR
		print space,spaceLength
		str bx	
		mov[for16bits],bx
		print message4,length4
		mov ax,[for16bits]
		call displayprocedure
	;LDT
		print space,spaceLength
		sldt bx	
		mov[for16bits],bx
		print message5,length5
		mov ax,[for16bits]
		call displayprocedure
	;GDT
		print space,spaceLength
		sgdt [for48bits]
		print message6,length6
		mov ax,[for48bits+4]
		call displayprocedure
		mov ax,[for48bits+2]
		call displayprocedure
		mov ax,[for48bits]
		call displayprocedure	
	;IDT
		print space,spaceLength
		sidt [for48bits]
		print message7,length7
		mov ax,[for48bits+4]
		call displayprocedure
		mov ax,[for48bits+2]
		call displayprocedure
		mov ax,[for48bits]
		call displayprocedure	
	exit:
	mov rax,60
	mov rdi,0
	syscall
	
	displayprocedure:
		mov rsi,disparr+3
		mov rcx,4
		L3:mov rdx,0
			mov rbx,10H
			div rbx
			;div divisor    ..it automatically takes in rdx:rax pair as dividend
			;returns quotient-rax	 and	 remainder-dl
			cmp dl,09H
			;conditional j-jump b-below e-equal jump to label l1
			jbe labelBelow
			;if jump value isnt satisfied then all statements are executed below
			add dl,07H
			labelBelow:add dl,30H
			;putting the number in dl into array
			mov [rsi],dl
			dec rsi
			dec rcx
			;rsi-array index rcx-counter var
			jnz L3
		;j-jump nz-not zero
		;Print Macro Call
		print disparr,4
		ret

section .data
	message1 db "Real Mode ON (Expected operations can't be performed)",10
	length1 equ $-message1
	
	message2 db "Protected Mode ON!!!",10
	length2 equ $-message2
	
	message3 db "Contents of MSW are : "
	length3 equ $-message3
	
	message4 db "TR Contents : "
	length4 equ $-message4
	
	message5 db "LDTR Contents : "
	length5 equ $-message5

	message6 db "GDTR Contents : "
	length6 equ $-message6

	message7 db "GDTR Contents : "
	length7 equ $-message7

	space db "",10
	spaceLength equ $-space
section .bss
	for16bits resb 40
	for32bits resb 100
	for48bits resb 100
	disparr resb 32
	
;OUTPUT:
;unix@unix-HP-dx2480-MT-KL969AV:~$ cd SEA18
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ nasm -f elf64 -o exe.o assign9.nasm
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ ld -o exe exe.o
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ ./exe
;Protected Mode ON!!!

;Contents of MSW are : 8005003B
;TR Contents : 0040
;LDTR Contents : 0000
;GDTR Contents : 7F289000007F
;GDTR Contents : FF5780000FFFunix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ 

