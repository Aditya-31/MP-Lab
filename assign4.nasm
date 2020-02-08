;Assignment 4 Write an assembly language program to perform Multiplication of 2 8bit HEX numbers by
; a] Successive Addition and b] Shift and Add 
;Aditya Gade 	SEA18	8/2/20

global   _start
_start:

section .text
	;Print MACRO	
		%macro print 2
		mov rax,1
		mov rdi,1
		mov rsi,%1
		mov rdx,%2
		syscall
		%endmacro
	;Accepting a Choice
		%macro accept 2
		mov rax,0
		mov rdi,0
		mov rsi,%1
		mov rdx,%2
		syscall
		%endmacro
		
	;CH1:Successive Addition
		print msg1,length1
		accept inputNo,3
		call convert
		mov [num1],al
	
		print msg2,length2
		accept inputNo,3
		call convert
		mov [num2],al
		
		print msg3,length3
		mov ax,0000H
		label:add ax,[num1]
			dec byte [num2]
			jnz label
		call displayWord
	
	;EXIT	
	mov rax,60
	mov rdi,0
	syscall
	
	
	convert:
		mov rsi,inputNo
		mov al,[rsi]
		cmp al,39H
		jbe l1
		sub al,7H
		l1:	sub al,30H
			;Rotate 4 times to swap a 2 digit number 
			rol al,4	;rotateLeft which,howMuch
			mov bl,al
			inc rsi
			mov al,[rsi]
			cmp al,39H
			jbe l2
			sub al,7H
			l2: sub al,30H
			add al,bl
		ret
	displayWord:
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
	msg1 db "Enter 1st number: "
	length1 equ $-msg1
	msg2 db "Enter 2nd number: "
	length2 equ $-msg2
	msg3 db "The result of their multiplication is: "
	length3 equ $-msg3
	space db " ",10
	spaceLength equ $-space
section .bss
	num1 resb 03
	num2 resb 03
	inputNo resb 04
	disparr resb 32
