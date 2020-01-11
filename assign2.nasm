;Assignment 2 Write an assembly language program to perform 1.overlap and 2. 
;Aditya Gade 	SEA18	11/1/20

global _start

_start:

section.data
	;Non Overlap
	sarr db 01H,02H,03H,04H,05H,06H,07H,08H	;rsi	
	darr db 00H,00H,00H,00H,00H,00H,00H,00H	;rdi
	cnt1 db 10	;for sarr
	cnt2 db 10	;for darr
section .text
	;Print Macro
	%macro print 2
	    mov rax,1
	    mov rdi,1
	    mov rsi,%1
	    ;rsi requires HEX values
	    mov rdx,%2
	    syscall
	%endmacro

	;Display Procedure for a byte sized
	
	
	;Execution
	mov rsi,sarr
	mov rdi,darr
	
	l1:
		mov al,[rsi]
		mov [rdi],al;becuase we cant directly copy from rsi to rdi
		inc rsi
		inc rdi
		dec byte[cnt1]
		jnz l1
		
	;Display darr
	mov rsi,darr
	l2: 
		mov al,[rsi]
		push rsi
		call displayByte
		pop rsi
		inc rsi
		dec byte [cnt2]
		jnz l2
