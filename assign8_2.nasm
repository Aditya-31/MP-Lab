%include "macro.asm"
global _main ;main can be wriiten any other name except start bcoz start is already used
 _main:
 
 global proc1
 extern buffer,act_len
 
 section .text
 	proc1:
 	print buffer,[act_len]
 	print msg1,len1
 	accept num,2
 	mov bl,byte[num]
 	mov rsi, buffer
 	
 	b1:
 	mov al,[rsi]
 	cmp al,0AH
 	je label1
 	cmp al,20H
 	je label2
 	cmp al,bl
 	je label3
 	jmp break
 	
 	label1:
		inc byte[linecnt]
		jmp break
	
 	label2:
		inc byte[spacecnt]
		jmp break
	
 	label3:
		inc byte[charcnt]
		jmp break 	
	break:
		inc rsi
		dec byte[act_len]
		jnz b1	

	print space,spaceLength

	print msg2,len2
	mov al,byte[linecnt]
	call displayWord
	
	print space,spaceLength
	
	print msg3,len3
	mov al,byte[spacecnt]
	call displayWord
	
	print space,spaceLength
	
	print msg4,len4
	inc byte[charcnt]
	mov al,byte[charcnt]
	call displayWord
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
	msg1 db "Enter character to be counted: "
	len1 equ $-msg1
	msg2 db "No. of Lines : "
	len2 equ $-msg2
	msg3 db "No. of Spaces : "
	len3 equ $-msg3 	
	msg4 db "No. of Character : "
	len4 equ $-msg4
	space db " ",10
	spaceLength equ $-space
 section .bss
 	linecnt resb 20
 	spacecnt resb 20
 	charcnt resb 20
 	num resb 5
 	disparr resb 32
 
;HOW TO COMPILE
;unix@unix-HP-dx2480-MT-KL969AV:~$ cd SEA18
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ nasm -f elf64 -o exe2.o a8_2.nasm
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ nasm -f elf64 -o exe1.o a8_1.nasm
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ ld -o exe1 exe1.o exe2.o
;unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ ./exe1 t1.txt
;Aditya Balasaheb Gade
;India vs Newzeland
;virat kohli
; Enter character to be counted: k
; 
;No. of Lines : 0003 
;No. of Spaces : 0006 
;No. of Character : 0001unix@unix-HP-dx2480-MT-KL969AV:~/SEA18$ 
