%include "macro.asm"
global _start
 _start:
 
 global buffer,act_len
 extern proc1
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
	call proc1
	
	exit:
	mov rax,60
	mov rdi,0
	syscall

	err:print mx,lx
	call exit	
section .data
	mx db "Error Opening File",10
	lx equ $-mx
		
section .bss
	filename resb 320
	filehandle resb 320
	act_len resb 320
	buf_len resb 320
	buffer resb 320
	
