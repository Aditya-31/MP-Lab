;Name: Aditya Gade 		Date:22/2/2020	SE-A	18
;Collection of various marcos required throughout the assignments


%macro print 2
    mov rax,1
    mov rdi,1
    mov rsi,%1
    ;rsi requires HEX values
    mov rdx,%2
    syscall
%endmacro

%macro accept 2
		mov rax,0
		mov rdi,0
		mov rsi,%1
		mov rdx,%2
		syscall
%endmacro

%macro fopen 1
	mov rax,2
	mov rdi,%1
	mov rsi,2
	mov rdx,0777o
	syscall
%endmacro

%macro fread 3
	mov rax,0
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fwrite 3
	mov rax,1
	mov rdi,%1
	mov rsi,%2
	mov rdx,%3
	syscall
%endmacro

%macro fclose 1
	mov rax,3
	mov rdi,%1
	syscall
%endmacro

%macro fdelete 1
	mov rax,87
	mov rdi,%1
	syscall
%endmacro
