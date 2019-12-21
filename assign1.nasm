;Assignment 1 Display Procedure and print macro to display an undefined array
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

mov rax,1234567812345678H
call displayproc

;----EXIT SYSCALL
mov rax,60
mov rdi,0
syscall
;------

;----------------------------
;Display Procedure Definition
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
;----------------------------
;Print Macro Call
print disparr,16
;----------------------------
;********
ret
;******
section .bss
;undefined so declared in .bss
disparr resb 32
;name datatype size  
