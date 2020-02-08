;Assignment 3 Write an assembly language program to convert :a]HEXADECIMAL to BCD and b]BCD to HEXADECIMAL
;Aditya Gade 	SEA18	18/1/20

global _start

_start:

section .text
	;Print Macro
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
		print menu,lengthMenu
		accept choice,2
		mov al,byte[choice]
		cmp al,31H
		je CH1
		cmp al,32H
		je CH2
		cmp al,33H
		je CH3
		
	CH1:
		print msg1,length1
		accept inputNo,2
		call convert
		mov [no1],al
	
		accept inputNo,3
		call convert
		mov [no2],al
	
		;HEX TO BCD
		print space,spaceLength
		print msg3,length3
		mov al,[no2]
		mov ah,[no1]
		mov rsi,array1
		labelDiv: mov dx,0
			mov bx,[rsi]
			div bx
			mov [remainder1],dx
			push rsi
			;display cha shortcut below 3 lines
				add al,30H
				mov [temp],al
				print temp,1
			pop rsi
			mov ax,[remainder1]
			add rsi,2
			dec byte[count1]
			jnz labelDiv
		print space,spaceLength
		jmp backToMenu
		
	CH2:
		;Multiply ax=(ax or al)*bx
		print space,spaceLength
		print msg4,length4
		mov rsi,array1
		l5: push rsi
			accept inputNo,1
			pop rsi
			mov al,byte[inputNo] ;input no
			sub al,30H 		;Conversion from ASCII to regular
			mov bx,[rsi]	
			mul bx
			add [result],ax
			add rsi,2
			dec byte[count2]
			jnz l5
		print msg5,length5	
		mov ax,[result]
		call displayWord	;4 digit
		print space,spaceLength
		jmp backToMenu
		
	CH3:	
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
		
	displaybyte:	;I'VE USED SHORTCUT
		;point to base empty array
		mov rsi,disparr
		;		,base+offset
		
		;declare count as 2
		mov rcx,2
		;we divide the number in a loop(L2 is a loop label) to separate digits
		 L2:mov rdx,0
			mov rbx,10H
			div rbx
			;div divisor    ..it automatically takes in rdx:rax pair as dividend
			;returns quotient-rax	 and	 remainder-dl
			cmp dl,09H
			;conditional j-jump b-below e-equal jump to label l1
			jbe L1
			;if jump value isnt satisfied then all statements are executed below
			add dl,07H
			L1:add dl,30H
			;putting the number in dl into array
			mov [rsi],dl
			dec rsi
			dec rcx
			;rsi-array index rcx-counter var
			jnz L2
			;j-jump nz-not zero
			;Print Macro Call
			print disparr,1
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
	msg1 db "Input a Hexadecimal number",10
	length1 equ $ -msg1
	msg2 db "Output number obtained is",10
	length2 equ $ -msg2
	msg3 db "BCD equivalent is",10
	length3 equ $ -msg3
	msg4 db "Enter BCD Input",10
	length4 equ $ -msg4
	space db " ",10
	spaceLength equ $ -space
	msg5 db "HEX equivalent is",10
	length5 equ $ -msg5
	menu db "1.HEX to BCD",10
		  db "2.BCD to HEX",10
		  db "3.Exit",10
		  db "Enter your choice : "
	lengthMenu equ $ -menu
	
	array1 dw 2710H,03E8H, 0064H,000AH,0001H
	count1 db 05H ;while using HEX to BCD
	count2 db 05H ;while using BCD to HEX
section .bss
	choice	resb 02
	disparr resb 32
	inputNo resb 05
	no1 	resb 02
	no2		resb 02
	remainder1 resw 02
	temp 	resb 01
	result resw 02
