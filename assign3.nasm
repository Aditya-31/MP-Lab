;Assignment 3 Write an assembly language program to convert from HEXADECIMAL to BCD
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
	print msg1,length1
	
	accept inputNo,2
	call convert
	mov [no1],al
	
	accept inputNo,3
	call convert
	mov [no2],al
	
	print msg2,length2
	print no1,2	;write display byte
	print no2,2	;same as above
	
	print space,spaceLength
	print msg3,length3
	;HEX TO BCD
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
		
	displaybyte:
		;point to 2nd position in an empty array
		mov rsi,disparr+1
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
			print disparr,2
			ret
	
section .data
	msg1 db "Input a Hexadecimal number",10
	length1 equ $ -msg1
	msg2 db "Output number obtained is",10
	length2 equ $ -msg2
	msg3 db "BCD equivalent is",10
	length3 equ $ -msg3
	space db " ",10
	spaceLength equ $ -space
	
	array1 dw 2710H,03E8H, 0064H,000AH,0001H
	count1 db 05H
section .bss
	inputNo resb 05
	no1 	resb 02
	no2		resb 02
	remainder1 resw 02
	temp 	resb 01
