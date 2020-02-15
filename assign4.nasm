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
		
	backToMenu:
		print space,spaceLength
		print menu,lengthMenu
		accept choice,2
		mov al,byte[choice]
		cmp al,31H
		je CH1
		cmp al,32H
		je CH2
		cmp al,33H
		je CH3
		
	CH1:;Successive Addition
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
		jmp backToMenu
	CH2: ;Shift and Add
		print space,spaceLength
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
		mov[result],ax
		
		mov ax,[num1]
		mov bx,[num2]
		repeat: shr bx,1	;shift contents bx to right by 1
				jnc l1	; if cf=0 then go to l1
				add [result],ax
				l1: shl ax,1	;;shift contents ax to left by 1
				cmp ax,0000H
				je l2
				cmp bx,0000H
				jne repeat
		l2: mov ax,[result]
		call displayWord
		jmp backToMenu
		
	CH3:;EXIT	
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
	menu db "MULTIPLICATION OF 2 HEX NUMBERS:(Each of Length 2)",10 
		db "1.Successive Addition",10
		db "2.Shift and Add",10
		db "3.Exit",10
		db "Enter your choice : "
	lengthMenu equ $ -menu
section .bss
	num1 resb 03
	num2 resb 03
	inputNo resb 04
	disparr resb 32
	result resw 02
	choice	resb 02
	



;OUTPUT:
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ ./exe
;MULTIPLICATION OF 2 HEX NUMBERS:(Each of Length 2)
;1.Successive Addition
;2.Shift and Add
;3.Exit
;Enter your choice : 1
;Enter 1st number: 04
;Enter 2nd number: 05
;The result of their multiplication is: 0014
;MULTIPLICATION OF 2 HEX NUMBERS:(Each of Length 2)
;1.Successive Addition
;2.Shift and Add
;3.Exit
;Enter your choice : 2   
 
;Enter 1st number: 05
;Enter 2nd number: 03
;The result of their multiplication is: 000F
;MULTIPLICATION OF 2 HEX NUMBERS:(Each of Length 2)
;1.Successive Addition
;2.Shift and Add
;3.Exit
;Enter your choice : 3
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ 
