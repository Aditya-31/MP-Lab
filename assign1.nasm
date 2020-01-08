;Assignment 1 Display Procedure and print macro to display a number
;Aditya Gade 	SEA18	21/12/19

global _start

_start:

section .text
;------------------------------
;Print Macro
%macro print 2
    mov rax,1
    mov rdi,1
    mov rsi,%1
    ;rsi requires HEX values
    mov rdx,%2
    syscall
%endmacro
;------------------------------ 

;------------------------------
;An example to display a number(the 2 comments below)
;mov rax,1234567812345678H
;call displayproc

;Now to Display an array
	;1 Point to an array
	mov rsi,arr
	;to fetch an element from the array
l3:	mov rax,[rsi]
	push rsi
	call displayproc
	pop rsi
	add rsi,8;Here 8 bcoz numbers are stored in the format of pairs and we have 16/2=8 pair 
	dec byte[count1]
	jnz l3
;-------------------------
;To check and count the negative and positive numbers from the array
	;point the array
	mov rsi,arr
l7: bt qword[rsi],63
	;bittest quadword,checkbit number
	jc labelNegativeCount
	;jump to this label
	inc byte [positiveCount]
	jmp labelNext
	;Unconditional
labelNegativeCount: inc byte[negativeCount]
labelNext: 	add rsi,8
	dec byte[arrayCount]
	jnz l7
	;2 digit numbers so al is used
	mov al,byte[positiveCount]
	call displayproc1
	print msg1,Length1
	print space,spaceLength
	
	mov al,byte[negativeCount]
	call displayproc1
	print msg2,Length2
	print space,spaceLength
;-------------------------
;----EXIT SYSCALL
mov rax,60
mov rdi,0
syscall
;------

;----------------------------
;Display Procedure basic Definition
displayproc:
    
    ;point to 16th position in an empty array
    mov rsi,disparr+15
    ;		,base+offset
    
    ;declare count as 16
    mov rcx,16
    
    ;we divide the number in a loop(L2 is a loop label) to separate digits
     l2:mov rdx,0
    	mov rbx,10H
    	div rbx
    	;div divisor    ..it automatically takes in rdx:rax pair as dividend
    	;returns quotient-rax	 and	 remainder-dl
    	cmp dl,09H
    	;conditional j-jump b-below e-equal jump to label l1
    	jbe l1
    	;if jump value isnt satisfied then all statements are executed below
    	add dl,07H
    	l1:add dl,30H
    	;putting the number in dl into array
    	mov [rsi],dl
    	dec rsi
    	dec rcx
    	;rsi-array index rcx-counter var
    	jnz l2
    	;j-jump nz-not zero
		;Print Macro Call
		print disparr,16
		ret
;----------------------------
;Display Procedure for 2 digit Definition
displayproc1:
    
    ;point to 16th position in an empty array
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
;----------------------------

;----------------------------

;*****
section .data
	arr dq 1234567812345678H,8765432323567532H,3101200115112000H,9767314922258012H,9422266466110872H
	count1 db 05
	arrayCount db 05
	space db " ",10
	spaceLength equ	$- space
	msg1 db "Positive "
	Length1 equ	$- msg1
	msg2 db "Negative "
	Length2 equ	$- msg2
;*****


;*****
section .bss
;undefined so declared in .bss
disparr resb 32
;2 counters positive and negative
positiveCount resb 02
negativeCount resb 02
;name datatype size  






;OUTPUT:
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ nasm -f elf64 -o exe.o assign1.nasm
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ ld -o exe exe.o
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ ./exe
;1234567812345678876543232356753231012001151120009767314922258012942226646611087202Positive  
;03Negative  
;mplab@mplab-HP-dx2280-MT-RA529AV:~/SEA18$ 

