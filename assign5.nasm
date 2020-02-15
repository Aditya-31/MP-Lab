;Assignment  Write an assembly language program to calculate factorial of a HEX number in HEX output
;Aditya Gade 	SEA18	15/2/20
;IF SEGMENTATION FAULT OCCURS TRY AN INCREASE THE SIZE OF VARIABLES IN BSS
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
	
	;Input
	mov rax,0000H
	print msg1,length1
	accept inputNo,3
	call convert
	mov [stackNo],al
	mov [counter],al
	
	push rax
	print msg2,length2
	pop rax
	mov rax,[stackNo]
	mov rcx,[counter]
	dec rcx
	l1: push rax
		dec rax
		cmp rax,1
		ja l1	;jump if above
	l2: pop rbx
		mul rbx
		dec rcx
		jnz l2
	call displayWord
	
	;Exit
	mov rax,60
	mov rdi,0
	syscall
	
	convert:
		mov rsi,inputNo
		mov al,[rsi]
		cmp al,39H
		jbe L1
		sub al,7H
		L1:	sub al,30H
			;Rotate 4 times to swap a 2 digit number 
			rol al,4	;rotateLeft which,howMuch
			mov bl,al
			inc rsi
			mov al,[rsi]
			cmp al,39H
			jbe L2
			sub al,7H
			L2: sub al,30H
			add al,bl
		ret
	displayWord:	;16 or 4 can be written for both
		mov rsi,disparr+15
		mov rcx,16
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
		print disparr,16
		ret

section .data
	msg1 db "Enter HEX number whose factorial is to be evaluated : "
	length1 equ $-msg1
	msg2 db "The factorial of the inputed HEX no. is : "
	length2 equ $-msg2
	space db " ",10
	spaceLength equ $-space
section .bss
	stackNo resb 30
	counter resb 30
	inputNo resb 10
	disparr resb 32
