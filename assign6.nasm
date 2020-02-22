;Assignment 1 Display Procedure and print macro to display a number
;Aditya Gade 	SEA18	22/2/2020
%include "macro.asm"
global _start

_start:
	
section .text

		backToMenu:
		print space,spaceLength
		print menu,menuLength
		accept choice,2
		mov al,byte[choice]
		cmp al,31H
		je CH1
		cmp al,32H
		je CH2
		cmp al,33H
		je CH3
		cmp al,34H
		je Exit
		
	CH1:;Put from file to console
		print menuCh1,menuCh1Length
		pop rcx
		pop rcx
		pop rcx
		;No. of pop's upon no of arguements
		mov [filename1],rcx
		fopen [filename1]
		cmp rax,-1H
		je openError
		mov [filehandle1],rax
		fread[filehandle1],buffer,bufferLength
	;rax has bufferLength after fread including of null character so dec rax
		dec rax
		mov[actualLength],rax
		print buffer,[actualLength]
		jmp backToMenu
	CH2:
		print menuCh2,menuCh2Length
		;Copy from one to another
		;actual requirement 4 times but 3 times already done in ch1
		pop rcx
		;No. of pop's upon no of arguements
		mov [filename2],rcx
		fopen [filename2]
		cmp rax,-1H
		je	openError
		mov [filehandle2],rax
		fwrite [filehandle2],buffer,[actualLength]
		fclose [filehandle2]
		fclose [filehandle1]
		jmp backToMenu
	CH3:
		print menuCh3,menuCh3Length
		;Delete a file
		fdelete[filename1]
		jmp backToMenu
	Exit:
		mov rax,60
		mov rdi,0
		syscall
	openError: 
		print msg1,len1
		jmp backToMenu
section .data
	msg1 db "Error in opening the file",10
	len1 equ $-msg1
	space db " ",10
	spaceLength equ $-space
	menu db "64 bit ALP for perfoeming:",10 
		db "1.TYPE",10
		db "2.Copy into another file",10
		db "3.Delete a file",10
		db "4.Exit",10
		db "Enter your choice : "
	menuLength equ $ -menu
	menuCh1 db "The contents of the file are : ",10
	menuCh1Length equ $-menuCh1
	menuCh2 db "The copied File contents are : ",10
	menuCh2Length equ $-menuCh2
	menuCh3 db "The file has been deleted!!! ",10
	menuCh3Length equ $-menuCh3
section .bss
	filename1 resb 32
	filehandle1 resb 32
	buffer resb 32
	bufferLength resb 32
	actualLength resb 32
	choice resb 02
	filename2 resb 32
	filehandle2 resb 32
