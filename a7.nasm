%include "macro.nasm"
global _start
 _start:
 
section .text
	pop rcx
	pop rcx
	pop rcx
	
	mov [filename],rcx
	fopen [filename]
	cmp rax,-1
	je err
	mov [filehandle],rax
	
	fread [filehandle],buffer,buf_len
	dec rax
	mov [act_len],rax
	print buffer,[act_len]
	
	mov al,[act_len]
	mov [cnt1],al
	ol:
	mov al,[act_len]
	dec al
	mov [cnt2],al
	mov rsi,buffer
	mov rdi,buffer
	inc rdi
	
	il:
	mov al,[rsi]
	mov bl,[rdi]
	cmp al,bl
	jbe l1
	call swap
	
	l1:
	mov [rsi],al
	mov [rdi],bl
	inc rsi
	inc rdi
	dec byte[cnt2]
	jnz il
	dec byte[cnt1]
	jnz ol

print buffer , [act_len]	
;	fwrite [filehandle],buffer,[act_len]
	
	fclose [filehandle]
	mov rax,60
	mov rdi,0
	syscall
	
	swap:
	mov cl,al
	mov al,bl
	mov bl,cl
	ret
	
	err:print mx,lx
	
section .data
	mx db "Error Opening File",10
	lx equ $-mx
		
section .bss
	filename resb 320
	filehandle resb 320
	act_len resb 320
	buf_len resb 320
	buffer resb 320
	cnt1 resb 10
	cnt2 resb 10
